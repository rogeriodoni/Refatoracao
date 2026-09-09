#==============================================================================
# VerificarAcessoContas.ps1
#
# PROPOSITO: Achar FORMS em que o legado aplica controle de acesso a conta
#            (fAcessoContas) e o migrado NAO aplica. O sintoma nao aparece em
#            tela: o lookup funciona, so que mostra conta de QUALQUER grupo -
#            e um buraco de permissao, nao de exibicao.
#
# O SINAL DECISIVO eh a comparacao legado x migrado. Procurar so por
# "SELECT ... FROM SigCdCli" nao serve: ha uso legitimo (o ClienteBO gerencia a
# propria SigCdCli, relatorios fazem JOIN para buscar descricao). Quem diz se o
# acesso era exigido eh o CODIGO LEGADO daquele form.
#
# SO FORMS. BOs sao excluidos de proposito: fAcessoContas eh funcao de UI (recebe
# objetos TextBox em pSt1/pSt2), e BO que referencia SigCdCli normalmente esta
# fazendo JOIN de relatorio. Incluir BOs levava a lista de 45 para 106, toda a
# diferenca sendo ruido (conferido em sigrecheBO: SigCdCli aparece 3x no JOIN do
# SELECT do relatorio).
#
# USO:
#   .\VerificarAcessoContas.ps1
#   .\VerificarAcessoContas.ps1 -IncluirBOs     # inclui BOs (ruidoso)
#
# Referencia da correcao: Formlch (5a5d9080), FormBch (40780a62), FormPEN.
# Origem: Erro155 (2026-09-09).
#==============================================================================

param(
    [switch]$IncluirBOs
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CONTROLE DE ACESSO A CONTA: legado x migrado" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$raiz  = "C:\4c\projeto\app"
$tasks = "C:\4c\tasks"

$alvos = @()
$alvos += Get-ChildItem -Path "$raiz\forms" -Recurse -Filter "Form*.prg" -ErrorAction SilentlyContinue |
          Where-Object { $_.Name -notmatch '\.bak$' }
if ($IncluirBOs) {
    $alvos += Get-ChildItem -Path "$raiz\classes" -Filter "*BO.prg" -ErrorAction SilentlyContinue |
              Where-Object { $_.Name -notmatch '\.bak$' }
}

# indice: nome base -> fonte legado mais recente
$indice = @{}
foreach ($a in (Get-ChildItem -Path $tasks -Directory -ErrorAction SilentlyContinue | Sort-Object Name)) {
    $an = Join-Path $a.FullName "analise.json"
    if (-not (Test-Path $an)) { continue }
    $leg = Get-ChildItem -Path $a.FullName -Filter "*_form_codigo_fonte.txt" -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $leg) { continue }
    $txt = [System.IO.File]::ReadAllText($an)
    # indice ESTRITO: so os campos canonicos formClass/boClass. Casar qualquer
    # token "Form*" no JSON sobre-mapeia (o arquivo cita outros forms) e chega a
    # atribuir o legado ERRADO a um form - o que viraria falso positivo aqui.
    foreach ($m in [regex]::Matches($txt, '(?i)"(?:formClass|boClass)"\s*:\s*"([A-Za-z0-9_]+)"')) {
        $indice[$m.Groups[1].Value.ToLower()] = $leg.FullName
    }
}

$gap = @(); $ok = 0; $semExigencia = 0; $semLegado = @()

foreach ($f in $alvos) {
    $txt = [System.IO.File]::ReadAllText($f.FullName)
    if ($txt -notmatch '(?i)SigCdCli') { continue }

    $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name).ToLower()
    if (-not $indice.ContainsKey($base)) { $semLegado += $f.Name; continue }

    $legTxt = [System.IO.File]::ReadAllText($indice[$base])
    $nLeg = ([regex]::Matches($legTxt, '(?i)fAcessoContas\s*\(')).Count
    $nMig = ([regex]::Matches($txt,    '(?i)fAcessoContas\s*\(')).Count

    if ($nLeg -eq 0) { $semExigencia++; continue }
    if ($nMig -gt 0) { $ok++; continue }

    $gap += [PSCustomObject]@{
        Arquivo  = $f.Name
        Pasta    = Split-Path (Split-Path $f.FullName -Parent) -Leaf
        Legado   = $nLeg
        SigCdCli = ([regex]::Matches($txt, '(?i)SigCdCli')).Count
        Razaos   = ([regex]::Matches($txt, '(?i)razaos')).Count
    }
}

Write-Host "  Analisados:              $($alvos.Count)" -ForegroundColor Gray
Write-Host "  Legado NAO exige acesso: $semExigencia" -ForegroundColor Gray
Write-Host "  Legado exige e migrado APLICA: $ok" -ForegroundColor Green
Write-Host "  Sem legado mapeado:      $($semLegado.Count)" -ForegroundColor Gray
Write-Host ""

if ($gap.Count -eq 0) {
    Write-Host "OK - nenhum form perdeu o controle de acesso a conta." -ForegroundColor Green
    exit 0
}

Write-Host "$($gap.Count) form(s) em que o LEGADO aplica fAcessoContas e o MIGRADO nao:" -ForegroundColor Red
Write-Host ""
Write-Host ("  {0,-26} {1,-12} {2,7} {3,9} {4,7}" -f "FORM", "PASTA", "LEGADO", "SigCdCli", "razaos") -ForegroundColor Gray
foreach ($g in ($gap | Sort-Object Legado -Descending)) {
    Write-Host ("  {0,-26} {1,-12} {2,7} {3,9} {4,7}" -f $g.Arquivo, $g.Pasta, $g.Legado, $g.SigCdCli, $g.Razaos)
}
Write-Host ""
Write-Host "COMO CORRIGIR (ver Formlch/FormBch/FormPEN):" -ForegroundColor Gray
Write-Host "  1. No legado, achar cada fAcessoContas e anotar o GRUPO passado (2o argumento)" -ForegroundColor Gray
Write-Host "  2. Trocar o SELECT direto em SigCdCli pela chamada a fAcessoContas, com o grupo" -ForegroundColor Gray
Write-Host "  3. Tipo 'C' = valida o codigo; tipo 'D' = BUSCA REVERSA pela descricao" -ForegroundColor Gray
Write-Host "  4. Picker proprio (FormBuscaAuxiliar sobre SigCdCli) tambem sai: quem abre a" -ForegroundColor Gray
Write-Host "     lista no legado eh o proprio fAcessoContas, ja filtrado" -ForegroundColor Gray
Write-Host "  5. NAO aplicar em painel de exibicao de registro ja carregado (BOParaForm):" -ForegroundColor Gray
Write-Host "     o legado nao valida acesso ao apenas exibir" -ForegroundColor Gray
exit 1
