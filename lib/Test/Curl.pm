package Test::Curl;

use 5.006001;
use strict;
use warnings;

use base 'Test::Builder::Module';

use Readonly;
use Test::More;
use WWW::Curl::Easy;

our $VERSION = '0.05';

my $CLASS = __PACKAGE__;

Readonly my $HTTP_STATUS_OK => 200;

our %EXPORT_TAGS = ( 'all' => [ qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok);

sub get_curl_http_code
{
    my ($curl, $url) = @_;

    $curl->setopt(CURLOPT_URL, $url);
    my $ret = $curl->perform;

    if (!$ret)
    {
        return $curl->getinfo(CURLINFO_HTTP_CODE);
    }

    return -$ret;
}

sub curl_ok {
    my ($curl, $url, $status) = @_;

    my $tb = $CLASS->builder;
    my $result = get_curl_http_code($curl, $url);

    return $tb->ok($result == $status, $url.q{ }.$result);
}

sub curl_not_ok {
    my ($curl, $url, $status) = @_;

    my $tb = $CLASS->builder;

    my $result = get_curl_http_code($curl, $url);

    return $tb->ok($result != $status, $url.q{ }.$result);
}

sub curl_200_ok {
    my ($curl, $url) = @_;

    return curl_ok($curl, $url, $HTTP_STATUS_OK);
}

sub curl_200_not_ok {
    my ($curl, $url) = @_;

    return curl_not_ok($curl, $url, $HTTP_STATUS_OK);
}

1;
__END__

=head1 NAME

Test::Curl - Testing HTTP response using WWW::Curl::Easy.

=head1 VERSION

Version 0.05

=cut

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
    $curl->setopt(CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1');

    curl_ok($curl, 'http://localhost', 200);
    curl_not_ok($curl, 'http://localhost', 404);
    curl_200_ok($curl, 'http://github.com');
    curl_200_not_ok($curl, 'http://www.github.com');

=cut

=head1 EXPORT

curl_ok

curl_not_ok

curl_200_ok

curl_200_not_ok

=cut

=head1 SUBROUTINES/METHODS

=cut

=head2 curl_ok ($curl, $url, $status)

Checks if a host replies with $status correctly.

=cut

=head2 curl_not_ok ($curl, $url, $status)

Does the exact opposite of curl_ok().

=cut

=head2 curl_200_ok ($curl, $url)

Checks if a host replies with status 200 correctly.

=cut

=head2 curl_200_not_ok ($curl, $url)

Does the exact opposite of curl_200_ok().

=cut

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

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2010 by z6x0a57

This library is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut
