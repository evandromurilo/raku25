sub increase($amount) {
    $*COUNTER += $amount;
}

my $*COUNTER = 0;

increase(10);

sub local-counter() {
    my $*COUNTER = 0;
    increase(5);
    increase(2);
    say "Inner counter is " ~ $*COUNTER;
}

local-counter();
increase(2);

say "Outer counter is " ~ $*COUNTER;
