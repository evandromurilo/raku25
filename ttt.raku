# tic tac toe
sub at(Str $str, $idx) {
    $str.substr($idx, 1);
}

sub take-idx(Str $str, @idxs) {
    (@idxs.map: { at($str, $_) }).join;
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

sub dumb-strat(Str $pos, Str $me) {
    $pos.subst("-", $me);
}

sub interactive-strat(Str $pos, Str $me) {
    show-pos($pos);
    my $play = prompt("Your turn " ~ $me ~ ": ").Int;

    if not is-available($pos, $play) {
	say("not available, try again");
	return interactive-strat($pos, $me);
    }

    $pos.substr(0, $play-1) ~ $me ~ $pos.substr($play);
}

sub is-available(Str $pos, $square) {
    at($pos, $square-1) ~~ /"-"/;
}

sub opponent(Str $who) {
    if $who ~~ "o" {
	"x";
    } else {
	"o";
    }
}

sub play-game(Str $pos, &cur-strat, &next-strat, Str $who) {
    if (has-won($pos, opponent($who))) {
	opponent($who) ~ " wins the game " ~ $pos;
    } elsif (is-tie($pos)) {
	"tie " ~ $pos;
    } else {
	play-game(cur-strat($pos, $who), &next-strat, &cur-strat, opponent($who))
    }
}

multi sub MAIN(Str $pos) {
    show-pos($pos);
    say has-won($pos, "x");
    say is-tie($pos);
    say triplets($pos);
}

multi sub MAIN() {
    my $result = play-game("---------", &dumb-strat, &interactive-strat, "x");
    say $result;
    my $board = ($result ~~ / .*\h(<[xo-]>.*)$ /)[0].Str;
    show-pos $board;
}

multi sub MAIN("opponent", Str $who) {
    say opponent($who);
}

#my $start-pos = '---------';
#my $test-pos = '-x--x--x-';

