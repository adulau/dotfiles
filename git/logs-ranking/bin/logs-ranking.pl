#!/usr/bin/perl

use strict;

use Net::Whois::RIS;
use Socket;
$| = 1;

my %iporigin;
my %ipranking;

sub BGPRankingLookup {
    my $asn = shift;
    $asn =~ s/AS//g;
    my $bgpranking =
      IO::Socket::INET->new( PeerAddr => "pdns.circl.lu", PeerPort => 43 )
      or die();
    print $bgpranking $asn . "\n";
    my $x;
    while (<$bgpranking>) {
        $x = $x . $_;
    }
    return $x;

    $bgpranking->shutdown();
}

sub getASN {
    my $ip = shift;    #or hostname

    if ( !( $ip =~ /^(\d+\.){3}\d+$/ ) ) {
        my $ipn = inet_aton($ip) or next;
        $ip = inet_ntoa($ipn);
    }

    my $l = Net::Whois::RIS->new();
    $l->getIPInfo($ip);
    return $l->getOrigin();
}

sub ipExist {
    my $ip = shift;

    if ( exists $iporigin{$ip} ) {
        return 1;
    }
    else {
        return undef;
    }

}

sub rankingExist {
    my $ip = shift;

    if ( exists $ipranking{$ip} ) {
        return 1;
    }
    else {
        return undef;
    }
}

sub ipAdd {
    my $ip  = shift;
    my $asn = shift;

    $iporigin{$ip} = $asn;
}

sub rankingAdd {
    my $ip      = shift;
    my $ranking = shift;
    $ipranking{$ip} = $ranking;

}

while (<STDIN>) {
    my $saved = $_;
    my @ipext = split( / /, $_, );
    my $ip    = $ipext[0];

    if ( not ipExist($ip) ) {
        ipAdd( $ip, getASN($ip) );
    }
    if ( not rankingExist($ip) ) {
        my @rankl = split( /,/, BGPRankingLookup( $iporigin{$ip} ) );
        rankingAdd( $ip, $rankl[1] );
    }

    my @rankl = split( /,/, BGPRankingLookup( $iporigin{$ip} ) );
    print $iporigin{$ip} . "," . $ipranking{$ip} . "," . $saved;
}

