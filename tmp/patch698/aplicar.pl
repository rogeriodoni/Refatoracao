use strict; use warnings;
my $target = 'C:/4c/automation/OrquestradorMigracao.ps1';

sub slurp { my $f=shift; open(my $h,'<:raw',$f) or do { print "ERRO: abrir $f\n"; exit 3 }; local $/; my $d=<$h>; close $h; return $d; }
# Normaliza um snippet LF -> CRLF (o .ps1 e' 100% CRLF)
sub crlf { my $s=shift; $s =~ s/\r\n/\n/g; $s =~ s/\n/\r\n/g; return $s; }

my $src = slurp($target);
my $fn  = crlf(slurp('C:/4c/tmp/patch698/fn.txt'));
my $f7  = crlf(slurp('C:/4c/tmp/patch698/f7.txt'));
my $f8  = crlf(slurp('C:/4c/tmp/patch698/f8.txt'));

my $orig = $src;
my @fail;

# Substituicao LITERAL por indice (sem regex): o texto dos ancoras tem '(', '$'
# e '{', e montar o replacement com s/// exige /e - mais simples trocar por
# substr, que nao interpreta nada.
sub troca {
    my ($buf, $anc, $novo, $tag, $falhas) = @_;
    my $i = index($$buf, $anc);
    if ($i < 0)                        { push @$falhas, "$tag ausente";  return }
    if ($i != rindex($$buf, $anc))     { push @$falhas, "$tag ambiguo";  return }
    substr($$buf, $i, length($anc), $novo);
}

# ---- 1. insere a funcao logo apos Test-BarraCrudEhDoFormPai ----
if (index($src,"function Test-GrupoOpSemVerboCrud") >= 0) { push @fail, "funcao JA existe" }
else {
    my $anc1 = "    return \$achou\r\n}\r\nfunction Get-ContagemBotoesLegado {";
    troca(\$src, $anc1, "    return \$achou\r\n}\r\n\r\n" . $fn . "\r\nfunction Get-ContagemBotoesLegado {", 'anc1', \@fail);
}

# ---- 2. call site da Fase 7 ----
my $anc2 = "                                (Test-BarraCrudEhDoFormPai -TextoDump \$txtLegadoF7)) {\r\n"
         . "                                \$temCrudLegado = \$false\r\n"
         . "                            }\r\n";
troca(\$src, $anc2, $anc2 . $f7, 'anc2', \@fail);

# ---- 3. call site da Fase 8: declara a variavel nova ----
my $anc3 = "                                        (Test-BarraCrudEhDoFormPai -TextoDump \$txtLegadoF8)\r\n";
troca(\$src, $anc3, $anc3 . $f8, 'anc3', \@fail);

# ---- 4. os DOIS consumidores passam a ler a variavel nova ----
troca(\$src,
      "                    if (-not \$grupoOpEhDoPaiF8) { \$padroesCrudLegadoF8 += 'Grupo_Op' }",
      "                    if (-not \$grupoOpNaoProvaCrudF8) { \$padroesCrudLegadoF8 += 'Grupo_Op' }",
      'anc4', \@fail);

troca(\$src,
      "((\$txtLegadoF8 -match 'Grupo_Op') -and -not \$grupoOpEhDoPaiF8) -or",
      "((\$txtLegadoF8 -match 'Grupo_Op') -and -not \$grupoOpNaoProvaCrudF8) -or",
      'anc5', \@fail);

if (@fail) { print "FALHA: ", join(' | ', @fail), "\nNADA FOI GRAVADO\n"; exit 1 }

open(my $b,'>:raw','C:/4c/tmp/patch698/OrquestradorMigracao.ps1.PRE') or do { print "ERRO backup\n"; exit 3 };
print $b $orig; close $b;
open(my $o,'>:raw',$target) or do { print "ERRO gravar\n"; exit 3 };
print $o $src; close $o;

my $crlf_n = () = $src =~ /\r\n/g;
my $lf_n   = () = $src =~ /\n/g;
printf "OK  bytes %d -> %d   CRLF=%d  LF_only=%d   grupoOpEhDoPaiF8_restantes=%d\n",
    length($orig), length($src), $crlf_n, $lf_n-$crlf_n, scalar(() = $src =~ /grupoOpEhDoPaiF8/g);
