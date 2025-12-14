sub concat(Str $in, Str $out) {
    my $fh = open $in, :r;
    my $contents = $fh.slurp;
    $fh.close;

    $fh = open $out, :a;
    $fh.say($contents);
    $fh.close;
}

multi sub MAIN(Str $out, +@in) {
    concat($_, $out) for @in
}
