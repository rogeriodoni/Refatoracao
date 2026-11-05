use strict; use warnings;
# Levanta, para cada form, o bloco WITH de cnt_4c_Botoes com BackStyle = 1,
# ignorando linhas de COMENTARIO, e diz se existe faixa de cabecalho na mesma pagina.
binmode(STDOUT, ":encoding(UTF-8)");

my @files = glob("projeto/app/forms/*/*.prg");
for my $f (@files) {
    open my $fh, "<", $f or next;
    my @l = <$fh>;
    close $fh;
    chomp @l;

    # faixa: container com BackColor RGB(100,100,100) e Height >= 60 (regra #11)
    my $temFaixa = 0;
    for (my $i = 0; $i < @l; $i++) {
        next if $l[$i] =~ /^\s*\*/;
        next unless $l[$i] =~ /BackColor\s*=\s*RGB\(\s*100\s*,\s*100\s*,\s*100\s*\)/i;
        for (my $j = $i - 8; $j <= $i + 8; $j++) {
            next if $j < 0 || $j >= @l;
            next if $l[$j] =~ /^\s*\*/;
            if ($l[$j] =~ /\.Height\s*=\s*(\d+)/ && $1 >= 60) { $temFaixa = 1; last }
        }
        last if $temFaixa;
    }

    # blocos cnt_4c_Botoes
    for (my $i = 0; $i < @l; $i++) {
        next unless $l[$i] =~ /AddObject\(\s*"cnt_4c_Botoes"/i;
        my ($bsLine, $bsVal, $bcLine, $bcVal, $end) = (0, "", 0, "", 0);
        for (my $j = $i + 1; $j < @l && $j < $i + 40; $j++) {
            if ($l[$j] =~ /^\s*ENDWITH/i) { $end = $j + 1; last }
            next if $l[$j] =~ /^\s*\*/;                 # COMENTARIO: ignorar
            if ($l[$j] =~ /^\s*\.BackStyle\s*=\s*(\S+)/i) { $bsLine = $j + 1; $bsVal = $1 }
            if ($l[$j] =~ /^\s*\.BackColor\s*=\s*(.+?)\s*$/i) { $bcLine = $j + 1; $bcVal = $1 }
        }
        next unless $bsVal eq "1";
        my $nome = $f; $nome =~ s{.*/}{}; $nome =~ s/\.prg$//;
        printf "%s\t%s\t%d\t%d\t%s\t%d\t%s\t%s\n",
            $nome, $f, $i + 1, $bsLine, $bsVal, $bcLine, $bcVal, ($temFaixa ? "COM-FAIXA" : "SEM-FAIXA");
    }
}
