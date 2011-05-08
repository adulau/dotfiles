logs-ranking
============

logs-ranking is a simple Perl script to add [BGP security ranking](http://bgpranking.circl.lu/) for
each IP address seen. The purpose is to ease network security analysis by providing a weight to
each log entry especially when you have large dataset.

logs-ranking queries two Whois interface:

* RIPE RIS interface
* CIRCL BGP Ranking interface.

logs-ranking is currently supporting Apache common/combined logs format.


Usage
-----

    cat ../logs/www.foo.be-access.log|  perl logs-ranking.pl >www.foo.be-access.log-ranked

After gathering the BGP security ranking for your logs, it will be prepended to
the log files with the following format:

<ASN>,<BGP ranking value in float>,original line

So you can use whatever tools to sort, merge, cut the ranked logs. For example,
you can use sort to sort with the higher score value:

    sort -r -g -t"," -k2 myrankedlogfiles.txt

Software required
-----------------

* A recent version of Perl
* [Net::Whois::RIS](http://search.cpan.org/dist/Net-Whois-RIS/)

License
-------

Copyright (C) 2011 Alexandre Dulaunoy

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


