#!/usr/bin/env perl
use strict;
use warnings;


sub get_form_data {
	my $method = $ENV{'REQUEST_METHOD'};

	my $text = '';
	if ( $method eq "GET" ) {
		$text = $ENV{'QUERY_STRING'};

	}
	else {    # default to POST
	   	read( STDIN, $text, $ENV{'CONTENT_LENGTH'} );
		# print "Content-type: text/plain\n\n";
	}
	# print "request: $text\n";

	my @value_pairs = split( /&/, $text );

	my %form_results = ();

	foreach my $pair (@value_pairs) {
		( my $key, my $value ) = split( /=/, $pair );
		$value =~ tr/+/ /;
		$value =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
		$value =~ tr/A-Za-z0-9\ \,\.\:\/\@\-\!\"\_\{\}//dc;
		$value =~ s/^\s+//g;
		$value =~ s/\s+$//g;

		$form_results{$key} = $value;    # store the key in the results hash
		# print "$key = $value\n";
	}
	%form_results;
}


sub get_data() {
	print "[{ 'text': 'task 1',
	          'qty': 13,
	          'ref': 11,
	          'who': 'Kevin' },
	        { 'text': 'task 2',
	          'qty': 3,
	          'ref': 22,
	          'who': 'Alexei' },
	        { 'text': 'task 3',
	          'qty': 4,
	          'ref': 33,
	          'who': 'Kevin' },
	        { 'text': 'task 4',
	          'qty': 5,
	          'ref': 44,
	          'who': 'Alexei' }]";
}


print "Content-Type: application/json\n\n";
my %form_data = get_form_data();

if ($form_data{'cmd'} eq 'getdata') {
	get_data();
}
