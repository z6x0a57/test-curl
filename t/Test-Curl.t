# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Test-Curl.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::Curl;
use Test::More tests => 2;
BEGIN { use_ok('Test::Curl') };

#########################
curl_200_ok('http://localhost');
# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

