sub dedup(Str $content) {
    my @lines = $content.lines;

    return $content if @lines.elems == 0;
    
    my $prev = @lines.first;

    gather {
	take $prev;
	
	for @lines.skip(1) {
	    take $_ unless $_ ~~ $prev;
	    $prev = $_;
	}
    }.join("\n")
}

multi sub MAIN(Str $in) {
    say dedup(slurp $in);
}
