package CovidHelp;
use Mojo::Base 'Mojolicious', -signatures;
use DDP;
use CovidHelp::Schema;
use Digest::MD5 qw(md5_hex) ;
use Encode;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');
  $self->plugin('Logf');

  # Configure the application
  $self->secrets($config->{secrets});



  my $schema  ;
  $self->helper(schema =>  sub { return $schema // &get_schema ( shift )   ;   });

  $self->helper(whapi_message => \&whapi_message);

  $self->logf( debug => "Loading Yancy plugin ....");
  my $username = $self->config->{db_username};
  my $password = $self->config->{db_password};
  my $dsn = $self->config->{dsn};
  $self->plugin ('Yancy' , { 
          backend => {
              'Dbic' => [ 'CovidHelp::Schema' , $dsn, $username, $password  ]
          },  
          editor => {
              return_to => "/"
          },
          schema => {  
              PasswordReset => {
                  "x-ignore" => 1,
              }
          },
      }
  );  

  $self->plugin(DbicSchemaViewer => { schema => $self->schema , }); 

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('site#home');

  $r->post('/api/post_whatsappmessage')->to(cb=>\&whatsappmessage);
  $r->post('/api/readmessages')->to(cb=>\&readmessages);

}


sub get_schema {
    my ($c) = shift;
    my $username = $c->config->{db_username};
    my $password = $c->config->{db_password};
    my $dsn = $c->config->{dsn};
    my $schema = CovidHelp::Schema->connect( $dsn , $username , $password , { AutoCommit=> 1} );
    return $schema;
}

sub whatsappmessage {

    my ($c) = shift ;
    my $param = $c->req->json;

    my $schema = $c->schema;

    my $response ;

    my $data    = $param -> {app} -> { data };
    my $message = $data -> {message} -> [0];
    my $sender  = $data -> {sender} -> {id};
    my ($sender_mobile ) = split '@' , $sender;

    $c->logf (debug => "data:%s" , np $data);
    $c->logf (debug => "message:%s" , np $message);



    my $message_type = $message->{type};
    $c->logf (debug => "message_type is :%s" , $message_type);

    $c->logf (debug => "sender:%s" , np $sender);
    $c->logf (debug => "sender_mobile:%s" , np $sender_mobile);

    my $senderobj = $schema->resultset('SenderMaster')->find_or_create( {  mobile => $sender_mobile });

    my $gateway_id = $message->{id} ;
    my $server_generated = $message->{time};
    my $value  = $message->{value};
    my $text   = $message->{text};
    my $sender_id =  $senderobj->id ;

    my $message_signature;

    if ($message_type =~ /image|video|audio/) {

        my $url = $value ;
        $c-> logf( debug => "fetching URL $url");


        my $ua  = Mojo::UserAgent->new;
        my $res = $ua->get($url)->result;

        my $content = $res-> body;
        $message_signature = md5_hex($content);

        $c->logf( debug => "length content: %d , signature: %s"  , length ($content) , $message_signature ) ;

    } elsif ($message_type =~ /text/) {
        my $min_length = $c->config->{min_length};
        my $length = length($value ) ;
        if ( $length < $min_length) {
            $response = "Please send a message at least $min_length characters long. Your message is $length characters long and has been ignored.";
            goto FINAL;
        }

        $message_signature = &message_signature($value);

    } else {
        $response = "Hi we are working on accepting $message_type format , please repost it again soon.";
        goto FINAL;
    }


    my $message_id ;


    $c->logf( debug => "message signature is: %s" , $message_signature);

    my ($existing_message) = $schema->resultset('MessageMaster') -> search ( { message_signature => $message_signature }) -> all();

    my $now = time;
    if ($existing_message) {
        $message_id = $existing_message-> id();
        my $report_count = $existing_message->report_count ;
        $existing_message-> update ( {
                last_reported => $now,
                report_count =>  $report_count + 1 ,
            });
        $response = "Thanks for forwarding the message, however it was already received $report_count times before.";
    } else {
        my ($message) = $schema->resultset('MessageMaster') -> create ( 
            { 
                message_signature => $message_signature ,
                message => $value,
                message_type => $message_type,
                first_reported => $now ,
                last_reported => $now,
                report_count => 1,
            }
        );
        $message_id = $message-> id;
        $response = "Thanks your message has been accepted";
    }


    my $messagelogobj = $schema->resultset('MessageLog')->create( 
        { 
            gateway_id=> $gateway_id,
            server_generated=> $server_generated,
            message_type => $message_type,
            text_value => $text,
            value => $value,
            sender_id => $sender_id,
            message_id => $message_id,
        });



    FINAL:

    $c->whapi_message ("919990001315", $sender_mobile, $response );


    $c->render( json => { message => $response });

}

sub readmessages {

    my ($c) = shift;
    my $be = $c->yancy->backend ;
    my $param = $c->req->json ;

    my $limit      = $param -> {limit} || 10 ;
    my $offset     = $param -> {offset} || 0 ;
    my $order_by   = $param->{order_by} || {}  ;

    my %search;

    my $result = $be->list( 'MessageMaster' , \%search , 
        {   
            order_by => $order_by  ,
            limit => $limit,
            offset=> $offset 
        }   
    );  
    my $data  = $result-> {items};
    my $total = $result-> {total};

    $c->render( json => { records => $data, total => $total } );



}


sub message_signature {

    my ($message) = @_;

    $message = Encode::encode_utf8($message);
    $message =~ s#\s+##g;


    my $digest = md5_hex($message);

    return $digest;
}

sub whapi_message {

    my ($c) = shift;

    my ($from , $to , $message) = @_;

    my $ua  = Mojo::UserAgent->new;

    $to ||= "";


    unless ( $to ) {
        $c->logf(warn => "Sorry destination ('$to') is not specified, bailing out." );
        return ;
    }

    unless ( length($to) == 12 ) {
        $c->logf(warn => "Sorry destination ('$to') is not 12 digits , bailing out." );
        return ;
    }

    $c->logf(debug => "whapi_message: sending message  %s -> %s" , $from  , $to);

    my $apidata = {
        "app" => {
            "id" => $from,
            "data" => {
                "recipient" => {
                    "id" =>  $to
                },
                "message" => [
                    {
                        "type" => "text",
                        "value" => $message
                    }
                ]
            }
        }
    };
    my $res = $ua->post("https://whapi.io/api/send" => {Accept => '*/*'} => json => $apidata )->result->json;;
    $c->logf(debug => "result is: %s" , np $res);
}



1;
