use utf8;
package CovidHelp::Schema::Result::MessageMaster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::MessageMaster

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

=head1 TABLE: C<general.message_master>

=cut

__PACKAGE__->table("general.message_master");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'general.message_master_id_seq'

=head2 message

  data_type: 'text'
  is_nullable: 0

=head2 message_signature

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 generated

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 0

=head2 first_reported

  data_type: 'integer'
  is_nullable: 0

=head2 last_reported

  data_type: 'integer'
  is_nullable: 0

=head2 report_count

  data_type: 'integer'
  is_nullable: 0

=head2 message_type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "general.message_master_id_seq",
  },
  "message",
  { data_type => "text", is_nullable => 0 },
  "message_signature",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "generated",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 0,
  },
  "first_reported",
  { data_type => "integer", is_nullable => 0 },
  "last_reported",
  { data_type => "integer", is_nullable => 0 },
  "report_count",
  { data_type => "integer", is_nullable => 0 },
  "message_type",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 message_logs

Type: has_many

Related object: L<CovidHelp::Schema::Result::MessageLog>

=cut

__PACKAGE__->has_many(
  "message_logs",
  "CovidHelp::Schema::Result::MessageLog",
  { "foreign.message_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-25 00:24:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3s2wpDWpAmi7kSSYo4/8jw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
