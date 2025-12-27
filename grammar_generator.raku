my %base-gens = verb => ("hit", "took", "saw", "liked", "killed", "massaged", "hugged", "shutted"),
		noun => ("woman", "ball", "table", "man", "tree", "pencil", "gun", "bathtub"),
		article => ("a", "the");

my %composite-gens = noun-phrase => ("article", "noun"),
		     verb-phrase => ("verb", "noun-phrase"),
		     sentence => ("noun-phrase", "verb-phrase");

multi sub generate(@list) {
    @list.flatmap: { generate($_) };
}

multi sub generate($atom) {
     if %base-gens{$atom}:exists {
	 %base-gens{$atom}.pick;
     } elsif %composite-gens{$atom}:exists {
	 generate(%composite-gens{$atom})
     } else {
	 $atom;
     }
}

multi sub MAIN(+@what) {
    say generate(@what).join(" ");
}


