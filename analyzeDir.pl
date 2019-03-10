# set options
use strict;
use Cwd;
use v5.14.0;
use utf8;
use warnings;

# set variables
my %dict;

# set subroutines
sub removeBonds {
  my $self = shift(@_);
  my $name = join(" ", grep(!/^$/, split(/[\ ]+|[\-]+|[\_]+|[\.]+|[\t]+|[\,]+|[\(]+|[\)]+|[\"]+|[\']+/, $self)));
  if ($name ne $self) {
    $name = removeBonds($name);
  }
  return $name;
}

sub makeSepaBigList {
  my @outputList;
  my @inputList = @_;
  while ( scalar @inputList > 0 ) {
    push(@outputList, join(" ", @inputList));
    pop(@inputList);
  }
  if ( scalar @_ > 1 ) {
    shift(@_);
    @outputList = ( @outputList, makeSepaBigList(@_) );
  }
  return @outputList;
}

# look what filenames we have in current directory and list them into an array so that we can later loop over that array
opendir(my $dirhandle, getcwd) || die "Can not open current dir!";
while (readdir $dirhandle) {
  if ( /^[^\.]/ ) {
    my $separatedName = removeBonds($_);
    # by looping over the array we split the individual filenames into arrays of words
    my @splitSepaList = split(" ", $separatedName);
    # we look for one and multi-word occurences
    my @splitSepaBig = makeSepaBigList(@splitSepaList);
    # we need a hash-table to put our findings in and count them
    for my $bigSepaInstance (@splitSepaBig) {
      $dict{$bigSepaInstance}++;
    }
  }
}
closedir $dirhandle;

# lastly we are going to print our findings
foreach my $name (sort { $dict{$a} <=> $dict{$b} } keys %dict) {
    printf "%-8s %s\n", $name, $dict{$name};
}
