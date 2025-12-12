# tic tac toe
sub take-idx(Str $str, @idxs) {
    (@idxs.map: { $str.substr($_, 1) }).join;
}

sub thrice(Str $str) {
    $str ~ $str ~ $str;
}

sub show-pos(Str $pos) {
    for $pos.comb(3) -> $line {
	say '|', $line.comb.join('|'), '|';
    }
}

sub triplets(Str $pos) {
    my @horizontal = $pos.comb(3);
    my @vertical = (0,1,2).map: { take-idx($pos, [$_, $_+3, $_+6]) };

    @horizontal.append(@vertical).push(take-idx($pos, [0, 4, 8])).push(take-idx($pos, [2, 4, 6]));
}

sub has-won(Str $pos, Str $who) {
    thrice($who) (elem) triplets($pos);
}

sub is-tie(Str $pos) {
    not has-won($pos, "x")
    and not has-won($pos, "o")
    and not $pos ~~ /"-"/;
}

multi sub MAIN(Str $pos) {
    show-pos($pos);
    say has-won($pos, "x");
    say is-tie($pos);
    say triplets($pos);
}

#my $start-pos = '---------';
#my $test-pos = '-x--x--x-';

