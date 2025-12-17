sub dedup(Str $content) {
    my @lines = $content.lines;
    my $prev = @lines.first;

    gather {
	take $prev;
	
	for @lines.skip(1) {
	    take $_ unless $_ ~~ $prev;
	    $prev = $_;
	}
    };
}

multi sub MAIN(Str $in) {
    .say for dedup(slurp $in);
}
