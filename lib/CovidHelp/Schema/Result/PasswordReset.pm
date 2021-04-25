use utf8;
package CovidHelp::Schema::Result::PasswordReset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::PasswordReset

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

=head1 TABLE: C<public.password_resets>

=cut

__PACKAGE__->table("public.password_resets");

=head1 ACCESSORS

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 token

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 created_at

  data_type: 'timestamp'
  is_nullable: 1
  size: 0

=cut

__PACKAGE__->add_columns(
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "token",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "created_at",
  { data_type => "timestamp", is_nullable => 1, size => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-25 17:59:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2k+YSJptAc61oTQAr/NliA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
