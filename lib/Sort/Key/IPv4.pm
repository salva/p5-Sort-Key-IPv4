package Sort::Key::IPv4;

use strict;
use warnings;

BEGIN {
    our $VERSION = '0.03';

    require XSLoader;
    XSLoader::load('Sort::Key::IPv4', $VERSION);
}

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw( ipv4keysort
                     ipv4keysort_inplace
                     ripv4keysort
                     ripv4keysort_inplace
                     ipv4sort
                     ipv4sort_inplace
                     ripv4sort
                     ripv4sort_inplace
                     ipv4_to_uv);


use Sort::Key::Register ipv4 => \&ipv4_to_uv, 'uint';

use Sort::Key::Maker ipv4keysort => 'ipv4';
use Sort::Key::Maker ripv4keysort => '-ipv4';
use Sort::Key::Maker ipv4sort => \&ipv4_to_uv, 'uint';
use Sort::Key::Maker ripv4sort => \&ipv4_to_uv, '-uint';

1;
__END__

=head1 NAME

Sort::Key::IPv4 - sort IP v4 addresses

=head1 SYNOPSIS

  use Sort::Key::IPv4 qw(ipv4sort);

  my @data = qw(1.1.1.1 1.1.1.0 1.1.1.2 2.1.0.3);
  my @sorted = ipv4sort @data;


  use Sort::Key::IPv4 qw(ipv4keysort);

  my @sorted = ipv4keysort { $_->ip_address } @hosts;

=head1 DESCRIPTION

This module extends the L<Sort::Key> family of modules to support
sorting of IP v4 addresses.

IPv4 addresses have to match the regular expression
C</^(\d)+\.(\d)+\.(\d)+\.(\d)+$/>.

=head2 FUNCTIONS

The functions that can be imported from this module are:

=over 4

=item ipv4sort @data

returns the IPv4 addresses in C<@data> sorted.

=item ripv4sort @data

returns the IPv4 addresses in C<@data> sorted in descending order.

=item ipv4keysort { CALC_KEY($_) } @data

returns the elements on C<@array> sorted by the IPv4
addresses resulting from applying them C<CALC_KEY>.

=item ripv4keysort { CALC_KEY($_) } @data

is similar to C<ipv4keysort> but sorts the elements in descending
order.

=item ipv4sort_inplace @data

=item ripv4sort_inplace @data

=item ipv4keysort_inplace { CALC_KEY($_) } @data

=item ripv4keysort_inplace { CALC_KEY($_) } @data

these functions are similar respectively to C<ipv4sort>, C<ripv4sort>,
C<ipv4sortkey> and C<ripv4sortkey>, but they sort the array C<@data> in
place.

=item ipv4_to_uv $key

converts the IPv4 value to a 32 bits unsigned integer.

=back

=head1 SEE ALSO

L<Sort::Key>, L<Sort::Key::Maker>

=head1 BUGS AND SUPPORT

Report bugs by email or using the CPAN RT system at
L<http://rt.cpan.org/>.

This module is hosted at GitHub:
L<http://github.com/salva/p5-Sort-Key-IPv4>.

=head1 COPYRIGHT AND LICENSE

Copyright E<copy> 2007, 2009 by Salvador FandiE<ntilde>o,
E<lt>sfandino@yahoo.comE<gt>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
