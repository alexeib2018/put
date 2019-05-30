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


sub getdata() {
	print '[{ "id": 1,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so330105",
	          "account_name":  "canteen - corona",
	          "ext_doc":       "ont8 main 931 sat",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           6,
	          "qty_pick":      6                    },

            { "id": 2,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so330107",
	          "account_name":  "canteen - corona",
	          "ext_doc":       "ont8 inbound 931 sat",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           3,
	          "qty_pick":      3                    },

            { "id": 3,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so330251",
	          "account_name":  "canteen - corona",
	          "ext_doc":       "947 gu1ead san dima",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           3,
	          "qty_pick":      3                    },

            { "id": 4,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so326517",
	          "account_name":  "canteen - vista",
	          "ext_doc":       "rt 2 seaworld east s",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           2,
	          "qty_pick":      0                    },

            { "id": 5,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so326490",
	          "account_name":  "canteen - vista",
	          "ext_doc":       "rt 2 kaiser smart ma",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           4,
	          "qty_pick":      0                    },

            { "id": 6,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so326499",
	          "account_name":  "canteen - vista",
	          "ext_doc":       "rt 2 cal western tri",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           2,
	          "qty_pick":      2                    },

            { "id": 7,
	          "shipment_date": "2018-08-31",
	          "sales_order":   "so326504",
	          "account_name":  "canteen - vista",
	          "ext_doc":       "rt 2 cal seaworld perks",
	          "item_no":       "50749",
	          "description":   "bb tri tuna salad",
	          "qty":           4,
	          "qty_pick":      4                    }]';
}


sub update {
	my $id = shift;
	my $qty = shift;
	print '{"status":"ok"}';
}


sub done {
	my $ref = shift;
	print '{"status":"ok"}';
}


sub undo {
	my $ref = shift;
	print '{"status":"ok"}';
}


print "Content-Type: application/json\n\n";
my %form_data = get_form_data();

if ($form_data{'cmd'} eq 'update') {
	my $id = $form_data{'id'};
	my $qty = $form_data{'qty'};
	update($id, $qty);
} elsif ($form_data{'cmd'} eq 'undo') {
	my $ref = $form_data{'ref'};
	undo($ref);
} elsif ($form_data{'cmd'} eq 'getdata') {
	getdata();
}
