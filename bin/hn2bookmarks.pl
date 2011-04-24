#!/usr/bin/perl
#
# http://news.ycombinator.com/submitted?id=adulau

use Scrappy;

my $spidy = Scrappy->new;

my $url = "http://news.ycombinator.com/submitted?id=adulau";

my @bookmarks;

sub hnfetch {

   my $url = shift;

   print STDERR "Fetching ".$url."\n";
$spidy->crawl( $url,
{
  'table td a'=> sub {
    if ($_[0]->{href} =~ m/^http/) {
        push (@bookmarks, $_[0]->{href});
    }

   if ($_[0]->{text} =~ m/^More$/) {
        my $nextpage = "http://news.ycombinator.com".$_[0]->{href};
        hnfetch($nextpage);
        last;
   }

  },

}
)

}

hnfetch($url);

print @bookmarks;
