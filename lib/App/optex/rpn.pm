package App::optex::rpn;

our $VERSION = "1.01";

=encoding utf-8

=head1 NAME

rpn - Reverse Polish Notation calculation

=head1 SYNOPSIS

    optex -Mrpn command ...

=head1 DESCRIPTION

B<rpn> is a filter module for B<optex> command which detect command
arguments which look like Reverse Polish Notation, and replace it by
the result of calculation.


=head1 EXAMPLE

Prevent to suspend macOS for 5 hours.

    $ optex -Mrpn caffeinate -d '3600,5,*'

=head1 SEE ALSO

L<App::optex>, L<https://github.com/kaz-utashiro/optex>

L<App::optex::rpn>, L<https://github.com/kaz-utashiro/optex-rpn>

L<https://qiita.com/kaz-utashiro/items/2df8c7fbd2fcb880cee6>

=head1 AUTHOR

Kazumasa Utashiro

=head1 LICENSE

Copyright 2021 Kazumasa Utashiro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

use v5.14;
use warnings;
use Carp;
use utf8;
use open IO => 'utf8', ':std';
use Data::Dumper;

my($mod, $argv);
sub initialize { ($mod, $argv) = @_ }

sub argv (&) {
    my $sub = shift;
    @$argv = $sub->(@$argv);
}

my @operator = sort { length $a <=> length $b } split /[,\s]+/, <<'END';
+,ADD  ++,INCR  -,SUB  --,DECR  *,MUL  /,DIV  %,MOD  POW  SQRT
SIN  COS  TAN
LOG  EXP
ABS  INT
&,AND  |,OR  !,NOT  XOR  ~
<,LT  <=,LE  =,==,EQ  >,GT  >=,GE  !=,NE
IF
DUP  EXCH  POP
MIN  MAX
TIME
RAND  LRAND
END

my $operator_re = join '|', map "\Q$_", @operator;
my $digit_re = qr/(?:\d*\.)?\d+/;
my $rpn_re = qr/$digit_re(?:[\s,]+|$digit_re|$operator_re)+/i;

sub rpn_calc {
    use Math::RPN();
    state $re = qr/(?:\d*\.)?\d+|[_a-z]+|--|\+\+|[<>!]=|\S/i;
    my @terms = map { /$re/g } @_;
    my @ans = Math::RPN::rpn @terms;
    if (@ans == 1 && $ans[0] && $ans[0] !~ /[^\.\d]/) {
	int $ans[0];
    } else {
	return undef;
    }
}


sub rpn {
    argv {
	my($cmd, @arg) = @_;
	my $count;
	for (@arg) {
	    if (/^$rpn_re$/ and my $calc = rpn_calc($_)) {
		if ($calc ne $_) {
		    $count++;
		    $_ = $calc;
		}
	    }
	}
	warn "exec: $cmd @arg\n";
	($cmd, @arg);
    };
}

1;

__DATA__

option default --rpn-all

option --rpn-all -M__PACKAGE__::rpn() $<move>

option --rpn -M__PACKAGE__::rpn() $<shift>

#  LocalWords:  rpn optex macOS
