use utf8;
package CovidHelp::Schema::Result::MessageLog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::MessageLog

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<general.message_log>

=cut

__PACKAGE__->table("general.message_log");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'general.message_log_id_seq'

=head2 gateway_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 server_generated

  data_type: 'integer'
  is_nullable: 0

=head2 generated

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 0

=head2 message_type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 text_value

  data_type: 'text'
  is_nullable: 1

=head2 sender_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 message_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "general.message_log_id_seq",
  },
  "gateway_id",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "server_generated",
  { data_type => "integer", is_nullable => 0 },
  "generated",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 0,
  },
  "message_type",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "text_value",
  { data_type => "text", is_nullable => 1 },
  "sender_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "message_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 message

Type: belongs_to

Related object: L<CovidHelp::Schema::Result::MessageMaster>

=cut

__PACKAGE__->belongs_to(
  "message",
  "CovidHelp::Schema::Result::MessageMaster",
  { id => "message_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 sender

Type: belongs_to

Related object: L<CovidHelp::Schema::Result::SenderMaster>

=cut

__PACKAGE__->belongs_to(
  "sender",
  "CovidHelp::Schema::Result::SenderMaster",
  { id => "sender_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-24 22:54:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZGVLxbdb3xSiQTku8CKiKQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
