use strict; use warnings;
# Erro312 - torna TRANSPARENTE o container cnt_4c_Botoes nos forms em que ele
# foi gerado opaco (BackStyle = 1 + BackColor), o que desenha um anel/bloco em
# volta dos botoes por cima da faixa do cabecalho.
#
#   perl aplicar.pl alvos.tsv            -> dry-run (so relata)
#   perl aplicar.pl alvos.tsv --aplicar  -> grava
#
# Preserva CRLF e a indentacao original. Ignora linhas de comentario.

binmode(STDOUT, ":encoding(UTF-8)");
my ($lista, $modo) = @ARGV;
my $aplicar = (defined $modo && $modo eq '--aplicar');

open my $lf, "<:encoding(UTF-8)", $lista or die "lista: $!";
my %alvo;
while (<$lf>) {
    chomp;
    my @c = split /\t/;
    push @{ $alvo{ $c[1] } }, { add => $c[2], bs => $c[3], bc => $c[5] };
}
close $lf;

my ($nFiles, $nBs, $nBc) = (0, 0, 0);
for my $path (sort keys %alvo) {
    open my $fh, "<:raw", $path or die "$path: $!";
    local $/;
    my $raw = <$fh>;
    close $fh;

    my $crlf = ($raw =~ /\r\n/) ? 1 : 0;
    my @l = split /\r?\n/, $raw, -1;

    my @del;      # indices 0-based a remover
    my $mudou = 0;

    for my $b (@{ $alvo{$path} }) {
        my $iBs = $b->{bs} - 1;
        my $iBc = $b->{bc} - 1;

        # confere que a linha e mesmo o que o levantamento disse
        unless ($l[$iBs] =~ /^(\s*)\.BackStyle(\s*=\s*)1\s*$/) {
            printf "  !! %s linha %d nao casa BackStyle=1: [%s]\n", $path, $b->{bs}, $l[$iBs];
            next;
        }
        my ($ind, $eq) = ($1, $2);

        $l[$iBs] = $ind . ".BackStyle" . $eq . "0";
        $nBs++;
        $mudou = 1;

        if ($b->{bc} > 0) {
            if ($l[$iBc] =~ /^\s*\.BackColor\s*=/) {
                push @del, $iBc;
                $nBc++;
            } else {
                printf "  !! %s linha %d nao casa BackColor: [%s]\n", $path, $b->{bc}, $l[$iBc];
            }
        }

        # comentario explicativo imediatamente antes do BackStyle
        $l[$iBs] = $ind . "*-- TRANSPARENTE (Erro312): container opaco pinta um anel em volta dos"
                 . ($crlf ? "\r\n" : "\n")
                 . $ind . "*-- botoes, por cima da faixa do cabecalho. Canonico: FormCor."
                 . ($crlf ? "\r\n" : "\n")
                 . $l[$iBs];
    }

    next unless $mudou;
    $nFiles++;

    my %rm = map { $_ => 1 } @del;
    my @out = map { $l[$_] } grep { !$rm{$_} } 0 .. $#l;
    my $novo = join($crlf ? "\r\n" : "\n", @out);

    if ($aplicar) {
        open my $of, ">:raw", $path or die "grava $path: $!";
        print $of $novo;
        close $of;
    }
    (my $nome = $path) =~ s{.*/}{};
    printf "%s %s\n", ($aplicar ? "[ok]" : "[dry]"), $nome;
}

printf "\n%s: %d arquivos | %d BackStyle 1->0 | %d BackColor removidos\n",
    ($aplicar ? "APLICADO" : "DRY-RUN"), $nFiles, $nBs, $nBc;
