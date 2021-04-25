use utf8;
package CovidHelp::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::User

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

=head1 TABLE: C<public.users>

=cut

__PACKAGE__->table("public.users");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email_verified_at

  data_type: 'timestamp'
  is_nullable: 1
  size: 0

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 remember_token

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 created_at

  data_type: 'timestamp'
  is_nullable: 1
  size: 0

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1
  size: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email_verified_at",
  { data_type => "timestamp", is_nullable => 1, size => 0 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "remember_token",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "created_at",
  { data_type => "timestamp", is_nullable => 1, size => 0 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1, size => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_email_unique>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("users_email_unique", ["email"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-25 17:59:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SjJzS3RF6aHyFxCGT5e9lA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
