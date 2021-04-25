use utf8;
package CovidHelp::Schema::Result::Migration;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::Migration

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

=head1 TABLE: C<public.migrations>

=cut

__PACKAGE__->table("public.migrations");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'migrations_id_seq'

=head2 migration

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 batch

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "migrations_id_seq",
  },
  "migration",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "batch",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-25 17:59:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3VeWb58so7L1C4GvFNP4Ow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
