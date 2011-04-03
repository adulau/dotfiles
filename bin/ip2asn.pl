#!/usr/bin/perl
#
# Takes as input IP address (one per line)
# and output the guessed IP location along with ASN origin and its description
#
# perl iporigin.pl 
# 8.8.8.8
# US;AS15169;GOOGLE - Google Inc.;8.8.8.8
# 8.8.4.4
# US;AS15169;GOOGLE - Google Inc.;8.8.4.4
# 4.4.4.4
# US;AS3356;LEVEL3 Level 3 Communications;4.4.4.4
#
# 
# This file is in the public domain.
# 
# Alexandre Dulaunoy - http://github.com/adulau

use Net::Whois::RIS;
use IP::Country::Fast;  
my $country = IP::Country::Fast->new();
$| = 1;

while (<STDIN>) {
        next if /^#/;
        chomp();
        @v = split(/ /, $_);
        $v[0];
        $l = Net::Whois::RIS->new();
        $l->getIPInfo($v[0]);
        print $country->inet_atocc($v[0]).";".$l->getOrigin().";".$l->getDescr().";".$v[0]."\n";
}
