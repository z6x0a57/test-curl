package Test::Curl;

use 5.010001;
use strict;
use warnings;

use WWW::Curl::Easy;
use Test::More;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Test::Curl ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our %EXPORT_TAGS = ( 'all' => [ qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(curl_ok curl_not_ok curl_200_ok curl_200_not_ok
	
);

our $VERSION = '0.01';



# Initialize curl
#
# @param $url string
# @param follow_location {0, 1}
#
# @return WWW::Curl::Easy object

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

# Get curl http code.
#
# @param url string
#
# @return integer httpd code or string on error

sub get_curl_http_code
{
	my ($url, $follow_location) = @_;
    $follow_location = 0 if (!defined($follow_location));

	my $curl = init_curl($url, $follow_location);	

	my $ret = $curl->perform;

	return $curl->getinfo(CURLINFO_HTTP_CODE) if (!$ret);
	return -$ret;
}

sub curl_ok {
    my $url = shift;
    my $status = shift;

    my $result = get_curl_http_code($url);

    ok($result == $status);
}

sub curl_not_ok {
    my $url = shift;
    my $status = shift;

    my $result = get_curl_http_code($url);

    ok($result != $status);
}


sub curl_200_ok {
    my $url = shift;
    
    curl_ok($url, 200);
}
	
sub curl_200_not_ok {
    my $url = shift;

    curl_not_ok($url, 200);
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Test::Curl - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Test::Curl;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Test::Curl, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

z6x0a57, E<lt>z6x0a57@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by z6x0a57

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
