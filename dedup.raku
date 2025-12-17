sub dedup(Str $content) {
    my @lines = $content.lines;
    my $prev = @lines.first;
    my @tail = @lines.tail({ $_ - 1});

    gather {
	take $prev;
	
	for @tail {
	    take $_ unless $_ ~~ $prev;
	    $prev = $_;
	}
    };
}

multi sub MAIN(Str $in) {
    .say for dedup(slurp $in);
}
