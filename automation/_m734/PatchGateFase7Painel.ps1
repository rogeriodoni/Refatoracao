# PatchGateFase7Painel.ps1
#
# Patch cirurgico no OrquestradorMigracao.ps1 (nona excecao do gate da Fase 7,
# Test-VerbosCrudSaoTodosDePainelDeLinha): a assinatura "abre painel + popula
# campo do MESMO painel" so casava a forma QUALIFICADA do legado
# ("ThisForm.cnt_inserir.Visible = .t.", SIGOPCFL). O SIGOPFLP escreve o MESMO
# Click dentro de um bloco WITH (".Visible = .T." sob "With
# ThisForm.Cnt_Inserir"), e com isso a dispensa nunca acontecia.
#
# Escrito como script (e nao via ferramenta de edicao) para preservar o CRLF do
# arquivo: insercao com CRLF explicito e escrita em UTF-8 COM BOM.
#
# NAO usar latin-1 (28591) nesta volta, mesmo que a receita de restauracao de
# CRLF a recomende para arquivos .prg: este .ps1 eh UTF-8 COM BOM, e
# [System.IO.File]::ReadAllText(path, enc) HONRA o BOM detectado e ignora o
# encoding passado - o texto volta em UTF-8 (com caracteres > 255 como "⚠" e
# "—"), e gravar isso em latin-1 troca cada um deles por "?" em TODO o arquivo.
# Medido em 2026-11-04: a primeira tentativa corrompeu ~20 blocos de prompt e
# teve de ser revertida do backup.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)

$enc = New-Object System.Text.UTF8Encoding($true)   # UTF-8 COM BOM, como o arquivo
$txt = [System.IO.File]::ReadAllText($Orquestrador) # autodetecta o BOM

$funcao = @'
<#
.SYNOPSIS
    Resolve os blocos WITH de um corpo de metodo legado: toda linha que comeca
    por "." recebe o alvo do WITH como prefixo.

.DESCRIPTION
    Existe para os predicados que casam "<caminho.>X.<membro>" no corpo de um
    Click do legado (hoje Test-VerbosCrudSaoTodosDePainelDeLinha). O legado
    escreve o MESMO trecho de duas formas:

        ThisForm.cnt_inserir.Visible = .t.           && qualificada (SIGOPCFL)

        With ThisForm.Cnt_Inserir                    && bloco WITH (SIGOPFLP)
            .Visible          = .T.
            .GetData.Value    = CrSigCdClh.Datas
        EndWith

    Sem resolver a segunda, o predicado nao enxerga o painel e a dispensa nunca
    acontece - o gate passa a exigir os quatro BtnXxxClick de um legado que tem
    barra de LINHA de grade, o que so se satisfaz INVENTANDO botao (viola o
    PILAR 1) ou criando metodo vazio (proibido pela regra de completude).

    Mantem as linhas "With"/"EndWith" na saida e preserva a indentacao, para que
    qualquer regex ancorado em inicio de linha continue valendo. WITH aninhado
    usa o alvo mais interno (pilha). Linha "." sem WITH aberto fica intacta -
    sem alvo nao ha o que resolver, e inventar um seria pior que nao resolver.

.PARAMETER Corpo
    Corpo do metodo legado, tipicamente o retorno de
    Get-CorpoClickDoObjetoLegado.
#>
function Expand-BlocosWithDoCorpoLegado {
    param([string]$Corpo)

    if ([string]::IsNullOrWhiteSpace($Corpo)) { return $Corpo }

    $ic    = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    $pilha = New-Object System.Collections.Generic.List[string]
    $saida = New-Object System.Collections.Generic.List[string]

    foreach ($linha in ($Corpo -split "`r?`n")) {
        # "With <alvo>" - alvo relativo ("With .Buttons(1)") resolve contra o
        # WITH de fora.
        $mWith = [regex]::Match($linha, '^[ \t]*With[ \t]+(\.?[A-Za-z0-9_]+(?:\.[A-Za-z0-9_]+)*)[ \t]*$', $ic)
        if ($mWith.Success) {
            $alvo = $mWith.Groups[1].Value
            if ($alvo.StartsWith('.')) {
                if ($pilha.Count -gt 0) { $alvo = $pilha[$pilha.Count - 1] + $alvo }
                else                    { $alvo = $alvo.TrimStart('.') }
            }
            $pilha.Add($alvo)
            $saida.Add($linha)
            continue
        }

        if ($linha -match '(?i)^[ \t]*EndWith\b') {
            if ($pilha.Count -gt 0) { $pilha.RemoveAt($pilha.Count - 1) }
            $saida.Add($linha)
            continue
        }

        $mMembro = [regex]::Match($linha, '^([ \t]*)\.([A-Za-z0-9_].*)$')
        if ($mMembro.Success -and $pilha.Count -gt 0) {
            $saida.Add($mMembro.Groups[1].Value + $pilha[$pilha.Count - 1] + '.' + $mMembro.Groups[2].Value)
            continue
        }

        $saida.Add($linha)
    }

    return ($saida -join "`r`n")
}

'@

# --- 1. Insere a funcao auxiliar antes do doc-comment da nona excecao --------
$ancoraFim = "function Test-VerbosCrudSaoTodosDePainelDeLinha {"
if (([regex]::Matches($txt, [regex]::Escape($ancoraFim))).Count -ne 1) {
    "ANCORA=FALHA (function Test-VerbosCrudSaoTodosDePainelDeLinha)"
    exit 2
}
if ($txt -match 'function Expand-BlocosWithDoCorpoLegado') {
    "JA PATCHADO (Expand-BlocosWithDoCorpoLegado presente)"
} else {
    # O doc-comment da nona excecao comeca no ultimo "<#" antes da funcao
    $posFunc = $txt.IndexOf($ancoraFim)
    $posDoc  = $txt.LastIndexOf("<#", $posFunc)
    if ($posDoc -lt 0) { "ANCORA=FALHA (doc-comment da nona excecao)"; exit 2 }
    $txt = $txt.Substring(0, $posDoc) + ($funcao -replace "`r?`n", "`r`n") + $txt.Substring($posDoc)
    "INSERCAO=OK (Expand-BlocosWithDoCorpoLegado)"
}

# --- 2. Faz as camadas (1) e (2) medirem o corpo com os WITH resolvidos ------
$velho = @'
        # Camada 3: sem o Click no dump, NAO dispensa.
        if ($null -eq $corpo) { return $false }

        # (1) ABRE um painel: "<caminho.>X.Visible = .T.".
        $mVis = [regex]::Match(
            $corpo,
'@
$novo = @'
        # Camada 3: sem o Click no dump, NAO dispensa.
        if ($null -eq $corpo) { return $false }

        # O legado escreve esse Click das DUAS formas: qualificada
        # ("ThisForm.cnt_inserir.Visible = .t.", SIGOPCFL) e dentro de um bloco
        # WITH (".Visible = .T." sob "With ThisForm.Cnt_Inserir", SIGOPFLP).
        # As camadas (1) e (2) casam "X.<membro>", entao a forma com WITH tem
        # de ser resolvida antes - senao a assinatura nao casa e a dispensa
        # nunca acontece. A camada (3) segue medindo o corpo ORIGINAL:
        # prefixar membro nao cria nem apaga comando proibido.
        $corpoExp = Expand-BlocosWithDoCorpoLegado -Corpo $corpo

        # (1) ABRE um painel: "<caminho.>X.Visible = .T.".
        $mVis = [regex]::Match(
            $corpoExp,
'@
$velho = $velho -replace "`r?`n", "`r`n"
$novo  = $novo  -replace "`r?`n", "`r`n"

if ($txt -match 'corpoExp') {
    "CAMADA1=JA PATCHADO"
} else {
    if (([regex]::Matches($txt, [regex]::Escape($velho))).Count -ne 1) {
        "ANCORA=FALHA (camada 1 da nona excecao)"
        exit 2
    }
    $txt = $txt.Replace($velho, $novo)
    "CAMADA1=OK"

    $velho2 = @'
        $painel = [regex]::Escape($mVis.Groups[1].Value)
        if ($corpo -notmatch ('(?im)^[ \t]*(?:[A-Za-z0-9_]+\.)*' + $painel + '\.[A-Za-z0-9_]+[ \t]*\.[ \t]*Value[ \t]*=')) {
'@
    $novo2 = @'
        $painel = [regex]::Escape($mVis.Groups[1].Value)
        if ($corpoExp -notmatch ('(?im)^[ \t]*(?:[A-Za-z0-9_]+\.)*' + $painel + '\.[A-Za-z0-9_]+[ \t]*\.[ \t]*Value[ \t]*=')) {
'@
    $velho2 = $velho2 -replace "`r?`n", "`r`n"
    $novo2  = $novo2  -replace "`r?`n", "`r`n"
    if (([regex]::Matches($txt, [regex]::Escape($velho2))).Count -ne 1) {
        "ANCORA=FALHA (camada 2 da nona excecao)"
        exit 2
    }
    $txt = $txt.Replace($velho2, $novo2)
    "CAMADA2=OK"
}

[System.IO.File]::WriteAllText($Orquestrador, $txt, $enc)
"GRAVADO=OK"

$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 2
}
"SINTAXE=OK"
exit 0
