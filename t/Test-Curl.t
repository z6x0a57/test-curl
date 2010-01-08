# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Test-Curl.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::Curl;
use Test::More tests => 4;
use WWW::Curl::Easy;

#########################

my $curl = new WWW::Curl::Easy;

$curl->setopt(CURLOPT_HEADER, 0);
$curl->setopt(CURLOPT_FOLLOWLOCATION, 0);
$curl->setopt(CURLOPT_VERBOSE, 0);
$curl->setopt(CURLOPT_UNRESTRICTED_AUTH, 1);
$curl->setopt(CURLOPT_NOBODY, 1);
$curl->setopt(CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)');

curl_ok($curl, 'http://github.com', 200);
curl_not_ok($curl, 'http://github.com', 404);
curl_200_ok($curl, 'http://github.com');
curl_200_not_ok($curl, 'http://www.github.com');

1;
