#!/usr/bin/perl -w

# Just does the .. include's manually.

use strict;

my @buffer;
my $depth = 0;

sub read_up {
	my $fil = "";
	my $line;
	my $fh = $_[0];
	my $indent = $_[1];
	my $in;
	$depth++;
	if ($depth > 10) {
		die "Depth of includes is too much";
	}
	while ($line = <$fh>) {
		#chomp $line;
		$line =~ s/\t/        /g;
		$line =~ s/\n$//;
		if ($line =~ m/^\s*\.\. include::/) {
			$in = $line;
			$fil = $line;
			$in =~ s/\.\. include::.*$//;
			$fil =~ s/^\s*\.\. include:: *//;
			INNER: while ($line = <$fh>) {
			       chomp $line;
			       if ($line =~ m/^\s*$/) {
				       last INNER;
			       }
			       if ($line =~ m/:literal:/) {
				       push @buffer,$indent . $in . "::";
				       $in = $indent . $in . "    ";
				       push @buffer,$indent . $in;
			       }
		       }
			open (my $ifh, '<', $fil) or die "Couldn't include $fil\n";
			read_up($ifh, $indent . $in);
			$line = "";
		}
		push @buffer, $indent . $line;
	}
	$depth--;
}

sub enumerate {
	my @buf = @_;
	for (my $i = 0; $i <= $#buf; $i++) {
		print $buf[$i] . "\n";
	}
}

read_up(*STDIN,"");
enumerate(@buffer);
