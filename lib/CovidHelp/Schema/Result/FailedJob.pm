use utf8;
package CovidHelp::Schema::Result::FailedJob;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CovidHelp::Schema::Result::FailedJob

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

=head1 TABLE: C<public.failed_jobs>

=cut

__PACKAGE__->table("public.failed_jobs");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'failed_jobs_id_seq'

=head2 connection

  data_type: 'text'
  is_nullable: 0

=head2 queue

  data_type: 'text'
  is_nullable: 0

=head2 payload

  data_type: 'text'
  is_nullable: 0

=head2 exception

  data_type: 'text'
  is_nullable: 0

=head2 failed_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  size: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "failed_jobs_id_seq",
  },
  "connection",
  { data_type => "text", is_nullable => 0 },
  "queue",
  { data_type => "text", is_nullable => 0 },
  "payload",
  { data_type => "text", is_nullable => 0 },
  "exception",
  { data_type => "text", is_nullable => 0 },
  "failed_at",
  {
    data_type => "timestamp",
    default_value => \"current_timestamp",
    is_nullable => 0,
    size => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-04-25 17:59:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mKq3hBLaL/If2XWKODEC0A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
