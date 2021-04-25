


my @tables =  qw (
general.sender_master
general.message_master
general.message_log
);

my $regex  = join '|' , map { s/^\w+\.//g;   $_;}  @tables ;


{
        schema_class =>  'CovidHelp::Schema',
        connect_info => {
                dsn  => "dbi:Pg:dbname=covidhelp_db;host=postgresql;port=5432;",
                user => "covidhelp_user",
                pass => "xxxxxxxxxxxxxxxxxxxxx",
        } ,
        loader_options => {
            dump_directory => './lib',
            components => [ qw( InflateColumn::DateTime TimeStamp ) ],
            db_schema  => [ qw( general public ofbiz) ],
                qualify_objects  => 1 ,
                constraint  => $regex ? qr#^($regex)$# : undef,
        },
}

