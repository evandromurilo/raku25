sub dedup(Str $content) {
    my $lines = $content.lines.list;
    my $prev = $lines.first;
    my $tail = $lines.tail({ $_ - 1});

    gather {
	take $prev;
	
	for $tail.list {
	    take $_ unless $_ ~~ $prev;
	    $prev = $_;
	}
    };
}

multi sub MAIN(Str $in) {
    my $contents = slurp $in;
    .say for dedup($contents);
}
