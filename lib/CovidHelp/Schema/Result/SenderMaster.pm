use utf8;
package CovidHelp::Schema::Result::SenderMaster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::SenderMaster

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

=head1 TABLE: C<general.sender_master>

=cut

__PACKAGE__->table("general.sender_master");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'general.sender_master_id_seq'

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 generated

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "general.sender_master_id_seq",
  },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "generated",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<sender_master_mobile_key>

=over 4

=item * L</mobile>

=back

=cut

__PACKAGE__->add_unique_constraint("sender_master_mobile_key", ["mobile"]);

=head1 RELATIONS

=head2 message_logs

Type: has_many

Related object: L<CovidHelp::Schema::Result::MessageLog>

=cut

__PACKAGE__->has_many(
  "message_logs",
  "CovidHelp::Schema::Result::MessageLog",
  { "foreign.sender_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-24 22:28:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nT17A+f7H9GBCF0ShMfJkg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
