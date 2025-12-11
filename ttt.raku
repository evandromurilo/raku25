# tic tac toe
sub show-pos(Str $pos) {
    for $pos.comb(3) -> $line {
	say '|', $line.comb.join('|'), '|';
    }
}

sub has-won(Str $pos, Str $who) {
    $pos ~~ / $who$who$who / or # horizontal
    $pos ~~ / $who..$who..$who / or # vertical
    $pos ~~ / $who...$who...$who / or # first diagonal
    $pos ~~ / $who.$who...$who /; # second diagonal
}

multi sub MAIN(Str $pos) {
    show-pos($pos);
    say has-won($pos, "x");
}

#my $start-pos = '---------';
#my $test-pos = '-x--x--x-';

