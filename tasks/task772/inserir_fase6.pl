use strict;
use warnings;

my $form = 'C:/4c/projeto/app/forms/operacionais/FormSIGOPNOP.prg';
my $dir  = 'C:/4c/tasks/task772/';

sub slurp_lines {
    my ($f) = @_;
    open(my $fh, '<', $f) or exit(2);
    my @l = <$fh>;
    close($fh);
    # normaliza para LF internamente
    s/\r?\n\z// for @l;
    return @l;
}

my @prop = slurp_lines($dir . 'fase6_prop.txt');
my @call = slurp_lines($dir . 'fase6_call.txt');
my @met  = slurp_lines($dir . 'fase6_metodos.txt');
my @src  = slurp_lines($form);

my ($nProp, $nCall, $nMet) = (0, 0, 0);
my @out;
my $viuTabIndexEnv = 0;

for my $i (0 .. $#src) {
    my $ln = $src[$i];
    push @out, $ln;

    if ($ln =~ /^\tthis_lImagensArvore\s*=\s*\.F\.\s*$/) {
        push @out, @prop;
        $nProp++;
        next;
    }

    if ($ln =~ /^\t\t\tTHIS\.AplicarOrdemTabulacao\(\)\s*$/) {
        push @out, @call;
        $nCall++;
        next;
    }

    if ($ln =~ /loc_oCnt\.txt_4c_Envelope\.TabIndex\s*=\s*loc_nSeq/) {
        $viuTabIndexEnv = 1;
        next;
    }

    if ($viuTabIndexEnv && $ln =~ /^\tENDPROC\s*$/) {
        push @out, @met;
        $nMet++;
        $viuTabIndexEnv = 0;
        next;
    }
}

if ($nProp != 1 || $nCall != 1 || $nMet != 1) {
    print "ANCORAS: prop=$nProp call=$nCall met=$nMet (esperado 1/1/1) - NADA GRAVADO\n";
    exit(3);
}

open(my $fh, '>', $form) or exit(4);
binmode($fh);
print $fh join("\r\n", @out), "\r\n";
close($fh);

print "OK prop=$nProp call=$nCall met=$nMet linhas=" . scalar(@out) . "\n";
exit(0);
