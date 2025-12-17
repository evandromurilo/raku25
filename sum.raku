multi sub MAIN(Str $in) {
    my $fh = open $in, :r;
    my $contents = $fh.slurp;
    $fh.close;
    
    say $contents.lines.sum;
}
