# You are given an array of integers. Write a script to return the average excluding the minimum and maximum of the given array.

sub special-avg(@list) {
    my $min;
    my $max;

    for @list {
	$min = $max = $_ unless $min.defined;
	$min = $_ if $_ < $min;
	$max = $_ if $_ > $max;
    }

    my @final-list = gather for @list {
	take $_ unless any($min, $max) == $_;
    }

    @final-list.sum / @final-list.elems;
}

my @test-data = 3, 1, 1, 2, 3, 4, 5, 3, 6, 6;

say special-avg(@test-data);
