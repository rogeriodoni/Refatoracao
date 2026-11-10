use strict;
use warnings;

# Insere o ramo ARVORE no gate da Fase 6 do OrquestradorMigracao.ps1.
# O arquivo de origem eh LF-only (medido com `file`): a gravacao usa "\n" para
# NAO converter 19 mil linhas para CRLF e enterrar a mudanca real em ruido de
# whitespace.

my $orq = 'C:/4c/automation/OrquestradorMigracao.ps1';
my $blk = 'C:/4c/tasks/task772/gate_f6_arvore.txt';

sub slurp_lines {
    my ($f) = @_;
    open(my $fh, '<', $f) or exit(2);
    binmode($fh);
    local $/;
    my $all = <$fh>;
    close($fh);
    my @l = split(/\n/, $all, -1);
    s/\r\z// for @l;
    pop @l if (@l && $l[-1] eq '');
    return @l;
}

my @ins = slurp_lines($blk);
my @src = slurp_lines($orq);

my ($nIns, $nLista, $nMsgVis, $nMsgGrade, $nMsgCapt, $nMsgPag, $nFalha) = (0,0,0,0,0,0,0);
my @out;
my $viuMsgExibicaoF6 = 0;

for my $i (0 .. $#src) {
    my $ln = $src[$i];

    # (1) lista final de ramos aceitos da Fase 6
    if ($ln =~ /^(\s+)\$temLayoutVisualizadorF6 -or \$temLayoutGradeUnicaF6 -or \$temLayoutCapturaF6 -or \$temLayoutPagSemDadosF6\) \{$/) {
        my $ind = $1;
        push @out, $ind . '$temLayoutVisualizadorF6 -or $temLayoutGradeUnicaF6 -or $temLayoutCapturaF6 -or $temLayoutPagSemDadosF6 -or';
        push @out, $ind . '$temLayoutArvoreF6) {';
        $nLista++;
        next;
    }

    # (2) exclusoes das mensagens [i] dos ramos POSTERIORES ao novo.
    #     O indent eh capturado ANTES do segundo -match: match sem grupo
    #     RESETA $1 em Perl.
    if ($ln =~ /^(\s+)-not \(\$temPaginaDados -or \$temLayoutFlat -or \$temLayoutDespachanteF6 -or \$temLayoutExibicaoF6\)\) \{$/) {
        my $ind = $1;
        if ($i > 0 && $src[$i-1] =~ /temLayoutVisualizadorF6/) {
            push @out, $ind . '-not ($temPaginaDados -or $temLayoutFlat -or $temLayoutDespachanteF6 -or $temLayoutExibicaoF6 -or';
            push @out, $ind . '      $temLayoutArvoreF6)) {';
            $nMsgVis++;
            next;
        }
    }

    if ($ln =~ /^(\s+)\$temLayoutVisualizadorF6\)\) \{$/) {
        push @out, $1 . '$temLayoutVisualizadorF6 -or $temLayoutArvoreF6)) {';
        $nMsgGrade++;
        next;
    }

    if ($ln =~ /^(\s+)-not \(\$temPaginaDados -or \$temLayoutFlat -or \$temLayoutDespachanteF6 -or \$temLayoutExibicaoF6 -or \$temLayoutVisualizadorF6 -or \$temLayoutGradeUnicaF6\)\) \{$/) {
        my $ind = $1;
        push @out, $ind . '-not ($temPaginaDados -or $temLayoutFlat -or $temLayoutDespachanteF6 -or $temLayoutExibicaoF6 -or $temLayoutVisualizadorF6 -or $temLayoutGradeUnicaF6 -or';
        push @out, $ind . '      $temLayoutArvoreF6)) {';
        $nMsgCapt++;
        next;
    }

    if ($ln =~ /^(\s+)\$temLayoutVisualizadorF6 -or \$temLayoutGradeUnicaF6 -or \$temLayoutCapturaF6\)\) \{$/) {
        my $ind = $1;
        push @out, $ind . '$temLayoutVisualizadorF6 -or $temLayoutGradeUnicaF6 -or $temLayoutCapturaF6 -or';
        push @out, $ind . '$temLayoutArvoreF6)) {';
        $nMsgPag++;
        next;
    }

    # (3) texto da mensagem de reprovacao
    if ($ln =~ /\[!\] Form nao passou na Fase 6:/ && $ln =~ /layout paginado nao-CRUD \(OPERACIONAL\) exige dump provando PageFrame/) {
        $ln =~ s/e o metodo de lookup implementado"/e o metodo de lookup implementado; layout arvore (OPERACIONAL, sem PageFrame) exige dump provando lista ActiveX de arvore (API de nos), campo sem ControlSource e sem lookup no legado + OLEControl, paridade numerica de campos, BINDEVENT e handler de validacao no migrado"/;
        push @out, $ln;
        $nFalha++;
        next;
    }

    push @out, $ln;

    # (4) o bloco novo entra logo DEPOIS da mensagem [i] do ramo EXIBICAO
    if (!$viuMsgExibicaoF6 && $ln =~ /\[i\] Fase 6 \(layout exibicao\)/) {
        $viuMsgExibicaoF6 = 1;
        next;
    }
    if ($viuMsgExibicaoF6 == 1 && $ln =~ /^\s+\}$/) {
        push @out, @ins;
        $nIns++;
        $viuMsgExibicaoF6 = 2;
        next;
    }
}

my $ok = ($nIns == 1 && $nLista == 1 && $nMsgVis == 1 && $nMsgGrade == 1 && $nMsgCapt == 1 && $nMsgPag == 1 && $nFalha == 1);

if (!$ok) {
    print "ANCORAS: ins=$nIns lista=$nLista msgVis=$nMsgVis msgGrade=$nMsgGrade msgCapt=$nMsgCapt msgPag=$nMsgPag falha=$nFalha (esperado 1 em cada) - NADA GRAVADO\n";
    exit(3);
}

open(my $fh, '>', $orq) or exit(4);
binmode($fh);
print $fh join("\n", @out), "\n";
close($fh);

print "OK ins=$nIns lista=$nLista msgVis=$nMsgVis msgGrade=$nMsgGrade msgCapt=$nMsgCapt msgPag=$nMsgPag falha=$nFalha linhas=" . scalar(@out) . "\n";
exit(0);
