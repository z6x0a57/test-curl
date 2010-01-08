use 5.006001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Test::Curl',
    VERSION_FROM      => 'lib/Test/Curl.pm', # finds $VERSION
    PREREQ_PM         => {
                            WWW::Curl::Easy => 0
                         }, 
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Test/Curl.pm', # retrieve abstract from module
       AUTHOR         => 'z6x0a57 <z6x0a57@gmail.com>') : ()),
);
