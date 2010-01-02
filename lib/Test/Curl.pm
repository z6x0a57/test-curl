package Test::Curl;

=head1 NAME

Test::Curl - Testing HTTP response using WWW::Curl::Easy.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Test::More tests => 5;
    use Test::Curl;

    curl_ok('http://localhost', 200);
    curl_200_ok('http://localhost');
    curl_200_ok('http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.33-rc1.tar.bz2');
    curl_200_not_ok('http://localhost1');
    curl_200_not_ok('http://google.com');

=cut

use 5.010001;
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

sub init_curl
{
    my ($url, $follow_location) = @_;

    my $curl = new WWW::Curl::Easy;
	
    $curl->setopt(CURLOPT_HEADER, 0);
    $curl->setopt(CURLOPT_URL, $url);
	$curl->setopt(CURLOPT_FOLLOWLOCATION, $follow_location);
	$curl->setopt(CURLOPT_VERBOSE, 0);
	$curl->setopt(CURLOPT_UNRESTRICTED_AUTH, 1);
	$curl->setopt(CURLOPT_NOBODY, 1);
	$curl->setopt(CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)');
	
	return $curl;
}

sub get_curl_http_code
{
	my ($url, $follow_location) = @_;
    $follow_location = 0 if (!defined($follow_location));

	my $curl = init_curl($url, $follow_location);	

	my $ret = $curl->perform;

	return $curl->getinfo(CURLINFO_HTTP_CODE) if (!$ret);
	return -$ret;
}

=head2 curl_ok ($url, $status)

Checks if a host replies with $status correctly.

=cut

sub curl_ok {
    my $url = shift;
    my $status = shift;

    my $result = get_curl_http_code($url);

    ok($result == $status);
}

=head2 curl_not_ok ($url, $status)

Does the exact opposite of curl_ok().

=cut

sub curl_not_ok {
    my $url = shift;
    my $status = shift;

    my $result = get_curl_http_code($url);

    ok($result != $status);
}

=head2 curl_200_ok ($url)

Checks if a host replies with status 200 correctly.

=cut

sub curl_200_ok {
    my $url = shift;
    
    curl_ok($url, 200);
}

=head2 curl_200_not_ok ($url)

Does the exact opposite of curl_200_ok().

=cut

sub curl_200_not_ok {
    my $url = shift;

    curl_not_ok($url, 200);
}

1;
__END__
=head1 SUPPORT

You can find documentation for this module with the perldoc command.

perldoc Test::Ping

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

This program is free software; you can redistribute it and/or modify it
under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 3, or (at your option) any
later version.

=back

=cut
