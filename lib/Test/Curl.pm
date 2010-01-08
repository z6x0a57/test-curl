package Test::Curl;

=head1 NAME

Test::Curl - Testing HTTP response using WWW::Curl::Easy.

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

=head1 SYNOPSIS
    
    use Test::Curl;
    use Test::More tests => 4;
    use WWW::Curl::Easy;

    my $curl = new WWW::Curl::Easy;

    $curl->setopt(CURLOPT_HEADER, 0);
    $curl->setopt(CURLOPT_FOLLOWLOCATION, 0);
    $curl->setopt(CURLOPT_VERBOSE, 0);
    $curl->setopt(CURLOPT_UNRESTRICTED_AUTH, 1);
    $curl->setopt(CURLOPT_NOBODY, 1);
    $curl->setopt(CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)');

    curl_ok($curl, 'http://localhost', 200);
    curl_not_ok($curl, 'http://localhost', 404);
    curl_200_ok($curl, 'http://github.com');
    curl_200_not_ok($curl, 'http://www.github.com');

=cut

use 5.006001;
use strict;
use warnings;

use WWW::Curl::Easy;
use Test::More;

require Exporter;

our @ISA = qw(Exporter);

=head1 EXPORT

curl_ok

curl_not_ok

curl_200_ok

curl_200_not_ok

=cut

our %EXPORT_TAGS = ( 'all' => [ qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok

);

=head1 SUBROUTINES/METHODS

=cut

sub get_curl_http_code
{
    my ($curl, $url) = @_;

    $curl->setopt(CURLOPT_URL, $url);
    my $ret = $curl->perform;

    return $curl->getinfo(CURLINFO_HTTP_CODE) if (!$ret);
    return -$ret;
}

=head2 curl_ok ($curl, $url, $status)

Checks if a host replies with $status correctly.

=cut

sub curl_ok {
    my ($curl, $url, $status) = @_;

    my $result = get_curl_http_code($curl, $url);

    ok($result == $status);
}

=head2 curl_not_ok ($curl, $url, $status)

Does the exact opposite of curl_ok().

=cut

sub curl_not_ok {
    my ($curl, $url, $status) = @_;

    my $result = get_curl_http_code($curl, $url);

    ok($result != $status);
}

=head2 curl_200_ok ($curl, $url)

Checks if a host replies with status 200 correctly.

=cut

sub curl_200_ok {
    my ($curl, $url) = @_;
    
    curl_ok($curl, $url, 200);
}

=head2 curl_200_not_ok ($curl, $url)

Does the exact opposite of curl_200_ok().

=cut

sub curl_200_not_ok {
    my ($curl, $url) = @_;

    curl_not_ok($curl, $url, 200);
}

1;
__END__

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

perldoc Test::Curl

If you have Git, this is the clone path:

git@github.com:z6x0a57/test-curl.git

You can also look for information at:

=over 4

=item * GitHub Website:

L<http://github.com/z6x0a57/test-curl/tree/master>

=back

=head1 AUTHOR

z6x0a57, E<lt>z6x0a57@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by z6x0a57

This library is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut
