#!/usr/bin/perl
#
#
# This perl script is dumping the urls submitted
# by an HN user. Sometime it's better than any
# del.icio.us stream when the HN user has some
# special interests.
#
# Usage:
#
#   perl hn2bookmarks.pl <hnusername>
#
# by Alexandre Dulaunoy, released under the modified BSD license.
#

use Scrappy;

my $spidy = Scrappy->new;

my $username = $ARGV[0];
my $url      = "http://news.ycombinator.com/submitted?id=" . $username;

my @bookmarks;

sub hnfetch {

    my $url = shift;

    print STDERR "Fetching " . $url . "\n";
    $spidy->crawl(
        $url,
        {
            'table td a' => sub {
                if ( $_[0]->{href} =~ m/^http/ ) {
                    push( @bookmarks, $_[0]->{href} )
                      if not( $_[0]->{href} =~ m/^http:\/\/ycombinator.com/ );
                }

                if ( $_[0]->{text} =~ m/^More$/ ) {
                    my $nextpage =
                      "http://news.ycombinator.com" . $_[0]->{href};
                    hnfetch($nextpage);
                    last;
                }

            },

        }
      )

}

hnfetch($url);

# remove footer URLs
splice( @bookmarks, -3 );

foreach (@bookmarks) {
    print $_. "\n";
}
