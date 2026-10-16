use strict; use warnings;
local $/;
my $f = 'C:/4c/automation/GerarFRXSigReCmc.prg';
open(my $h, '<', $f) or die $!;
my $t = <$h>;
close $h;
my $n = 0;

# 1) Cabecalho de coluna tem de ser objtype 8 (campo), nao 5 (label):
#    label NAO avalia expressao - "CsCabecalho.nm_tipo" sairia literal.
my $old = <<'OLD';
                    REPLACE vpos      WITH ALT_PAGEHEADER - 1500, ;
                            hpos      WITH par_aCols[lnLabel, 3], ;
OLD
my $new = <<'NEW';
                    *-- objtype 8 (campo), NAO 5 (label): Label em FRX nao avalia
                    *-- expressao - a legenda dinamica sairia literal na pagina.
                    *-- Eh o que o FRX legado da familia faz (SigReCmv: t=8 |'Data').
                    REPLACE objtype   WITH 8, ;
                            vpos      WITH ALT_PAGEHEADER - 1500, ;
                            hpos      WITH par_aCols[lnLabel, 3], ;
NEW
$old =~ s/\n/\r\n/g; $new =~ s/\n/\r\n/g;
die "bloco da legenda nao casou\n" unless index($t, $old) >= 0;
$t =~ s/\Q$old\E/$new/; $n++;

# 2) Larguras/posicoes revisadas
my %pos = (
  # Cm1 (retrato, 75000)
  'laCm1[1,3] = 0'      => 'laCm1[1,3] = 0',
  'laCm1[1,4] = 4500'   => 'laCm1[1,4] = 5000',
  'laCm1[2,3] = 5000'   => 'laCm1[2,3] = 5500',
  'laCm1[2,4] = 10000'  => 'laCm1[2,4] = 11000',
  'laCm1[3,3] = 15500'  => 'laCm1[3,3] = 17000',
  'laCm1[3,4] = 27000'  => 'laCm1[3,4] = 26000',
  'laCm1[4,3] = 43000'  => 'laCm1[4,3] = 43500',
  'laCm1[5,3] = 52500'  => 'laCm1[5,3] = 53000',
  'laCm1[5,4] = 7000'   => 'laCm1[5,4] = 7500',
  'laCm1[6,3] = 60000'  => 'laCm1[6,3] = 61000',
  'laCm1[6,4] = 15000'  => 'laCm1[6,4] = 14000',
  # Cm2 (paisagem, 109000)
  'laCm2[1,4] = 10000'  => 'laCm2[1,4] = 11000',
  'laCm2[2,3] = 10500'  => 'laCm2[2,3] = 11500',
  'laCm2[2,4] = 26000'  => 'laCm2[2,4] = 25000',
  # Cm3 (paisagem, 109000)
  'laCm3[1,4] = 4000'   => 'laCm3[1,4] = 4500',
  'laCm3[2,3] = 4500'   => 'laCm3[2,3] = 5000',
  'laCm3[2,4] = 10000'  => 'laCm3[2,4] = 11000',
  'laCm3[3,3] = 15000'  => 'laCm3[3,3] = 16500',
  'laCm3[3,4] = 21000'  => 'laCm3[3,4] = 20000',
  'laCm3[4,3] = 36500'  => 'laCm3[4,3] = 37000',
  'laCm3[4,4] = 14000'  => 'laCm3[4,4] = 13500',
  'laCm3[5,3] = 51000'  => 'laCm3[5,3] = 51000',
  'laCm3[6,3] = 54500'  => 'laCm3[6,3] = 54500',
  'laCm3[6,4] = 14000'  => 'laCm3[6,4] = 13500',
  'laCm3[7,3] = 69000'  => 'laCm3[7,3] = 68500',
  'laCm3[8,3] = 80500'  => 'laCm3[8,3] = 80000',
  'laCm3[9,3] = 97000'  => 'laCm3[9,3] = 96500',
);
for my $k (keys %pos) {
    next if $pos{$k} eq $k;
    die "nao casou: $k\n" unless index($t, $k) >= 0;
    $t =~ s/\Q$k\E/$pos{$k}/; $n++;
}

open($h, '>', $f) or die $!;
binmode $h;
print $h $t;
close $h;
print "patches aplicados: $n\n";
