<#
.SYNOPSIS
    Audita as properties de ThisForm que o p-code de uma classe VCX legado toca, e
    aponta as que o form migrado precisa declarar.

.DESCRIPTION
    Regra #32 do CLAUDE.md / secao 218 da skill vfp9-migration. Origem: Erro166.

    O p-code do VCX chama ThisForm.<x> em dezenas de pontos. Para a MAIORIA delas o
    proprio VCX se vira, com o par guarda + AddProperty:

        If Type('ThisForm.OldEmpresa') == 'U'
            ThisForm.AddProperty('OldEmpresa', ...)
        EndIf

    Essas nunca dao erro. As que aparecem CRUAS, sem esse par, sao exatamente as que
    estouram em runtime - no clsconta eram 18 properties, 17 auto-criadas e UMA nao
    (AlterouLgpd), que fazia gravar uma ALTERACAO estourar
    "Erro 1734: Property ALTEROULGPD is not found" dentro do mGravaDados.

    Este script faz a varredura que acha a que falta E prova que nao ha outra na fila.

    NAO eh um pattern do CorretorAutomatico: nao ha texto errado no .prg gerado para
    reescrever - ha uma declaracao FALTANDO, e so o p-code do VCX diz qual.

.PARAMETER Vcx
    Caminho da .vcx legado (default: Framework\classresp.vcx).

.PARAMETER Classe
    Nome da classe dentro da .vcx (default: clsconta).

.PARAMETER Form
    Caminho do .prg migrado que hospeda a classe.

.PARAMETER Vfp9
    Caminho do vfp9.exe.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File automation\VerificarPropsThisFormVCX.ps1

.NOTES
    Exit code 0 = nada a declarar. 1 = ha property sem guarda ausente no form.
#>
[CmdletBinding()]
param(
    [string] $Vcx     = 'C:\4c\Framework\classresp.vcx',
    [string] $Classe  = 'clsconta',
    [string] $Form    = 'C:\4c\projeto\app\forms\operacionais\FormCliente.prg',
    [string] $Vfp9    = 'C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe'
)

$ErrorActionPreference = 'Stop'

# Membros NATIVOS de Form - o migrado herda, nunca precisa declarar.
# (so os que aparecem como ThisForm.<x> no p-code do Framework legado)
$NATIVAS = @(
    'name','lockscreen','height','width','top','left','backcolor','forecolor',
    'caption','datasessionid','datasession','refresh','release','hide','show',
    'addproperty','addobject','removeobject','zorder','setfocus','visible',
    'enabled','activate','autocenter','borderstyle','windowtype','closable',
    'cls','print','saveas','drag','move'
)

function Fail($msg) {
    Write-Host "[THISFORM-PROPS] ERRO: $msg" -ForegroundColor Red
    exit 2
}

foreach ($p in @($Vcx, $Form, $Vfp9)) {
    if (-not (Test-Path -LiteralPath $p)) { Fail "arquivo nao encontrado: $p" }
}

$tmpDir = Join-Path $env:TEMP ("propsvcx_" + [guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $tmpDir -Force | Out-Null

try {
    $dump = Join-Path $tmpDir 'methods.txt'
    $prg  = Join-Path $tmpDir 'dump.prg'

    # ------------------------------------------------------------------
    # 1) Dumpar a coluna Methods SO dos registros da classe pedida.
    #    O .VCT eh p-code: grep no arquivo inteiro mistura TODAS as classes
    #    e traz lixo de bytes printaveis. Ler a .vcx como DBF eh o unico
    #    jeito confiavel (mesma tecnica da secao 214 da skill).
    # ------------------------------------------------------------------
    $vfpScript = @"
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcKey
lcOut = ""
USE "$Vcx" ALIAS vcxc IN 0 SHARED
SELECT vcxc
SCAN
    lcKey = LOWER(ALLTRIM(NVL(vcxc.Parent, "")) + "|" + ALLTRIM(NVL(vcxc.ObjName, "")))
    IF "$($Classe.ToLower())" `$ lcKey
        lcOut = lcOut + NVL(vcxc.Methods, "") + CHR(13) + CHR(10)
    ENDIF
ENDSCAN
USE IN vcxc
STRTOFILE(lcOut, "$dump")
QUIT
"@
    Set-Content -LiteralPath $prg -Value $vfpScript -Encoding ASCII
    & $Vfp9 -t $prg | Out-Null

    if (-not (Test-Path -LiteralPath $dump)) {
        Fail "o VFP9 nao gerou o dump de Methods (classe '$Classe' existe em $Vcx?)"
    }
    $texto = Get-Content -LiteralPath $dump -Raw
    if ([string]::IsNullOrWhiteSpace($texto)) {
        Fail "dump vazio - a classe '$Classe' nao casou nenhum registro em $Vcx"
    }

    # ------------------------------------------------------------------
    # 2) Todas as ThisForm.<x> citadas pelo p-code da classe
    # ------------------------------------------------------------------
    $todas = [regex]::Matches($texto, '(?i)\bThisForm\.([A-Za-z_][A-Za-z0-9_]*)') |
             ForEach-Object { $_.Groups[1].Value.ToLower() } |
             Sort-Object -Unique

    # ------------------------------------------------------------------
    # 3) Duas formas de o VCX se proteger sozinho - NAO confundir:
    #
    #    AUTO-CRIADA: guarda Type(...)=='U' + AddProperty. O VCX materializa
    #      a property se faltar. O form nao precisa declarar.
    #
    #    TESTADA: o VCX so TOCA a property depois de um Type('ThisForm.X...'),
    #      tipicamente =='O' para referencia de objeto que o migrado nao tem
    #      (ThisForm.Pagina, o PageFrame do frmcadastro legado). Nao estoura,
    #      mas o uso SO eh seguro se TODOS os sites estiverem sob o guard -
    #      o script nao consegue provar isso, entao reporta como WARNING para
    #      conferencia humana, nunca como falha.
    #
    #    Sem isto o script acusa ThisForm.Pagina como ausente, que eh falso
    #    positivo - o modo de falha que a memoria de auditorias ja registrou.
    # ------------------------------------------------------------------
    $autoGuarda = [regex]::Matches($texto, "(?i)Type\(\s*'\s*ThisForm\.([A-Za-z_][A-Za-z0-9_]*)\s*'\s*\)\s*==?\s*'U'") |
                  ForEach-Object { $_.Groups[1].Value.ToLower() }
    $autoAdd    = [regex]::Matches($texto, "(?i)AddProperty\(\s*[\['""]\s*([A-Za-z_][A-Za-z0-9_]*)") |
                  ForEach-Object { $_.Groups[1].Value.ToLower() }
    $auto = @($autoGuarda + $autoAdd) | Sort-Object -Unique

    # qualquer Type('ThisForm.X...') - com ou sem sufixo de caminho, qualquer resultado
    $testada = [regex]::Matches($texto, "(?i)Type\(\s*'\s*ThisForm\.([A-Za-z_][A-Za-z0-9_]*)") |
               ForEach-Object { $_.Groups[1].Value.ToLower() } | Sort-Object -Unique

    # ------------------------------------------------------------------
    # 4) O que o .prg migrado ja oferece (properties E metodos)
    # ------------------------------------------------------------------
    $srcForm = Get-Content -LiteralPath $Form -Raw
    $declProp = [regex]::Matches($srcForm, '(?m)^\s{1,8}([A-Za-z_][A-Za-z0-9_]*)\s*=') |
                ForEach-Object { $_.Groups[1].Value.ToLower() }
    # metodo conta: ThisForm.checaibge eh chamada de metodo, nao leitura de property
    $declMet  = [regex]::Matches($srcForm, '(?im)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:PROCEDURE|FUNCTION)\s+([A-Za-z_][A-Za-z0-9_]*)') |
                ForEach-Object { $_.Groups[1].Value.ToLower() }
    $declarado = @($declProp + $declMet) | Sort-Object -Unique

    # ------------------------------------------------------------------
    # 5) Veredito
    # ------------------------------------------------------------------
    $candidatas = $todas | Where-Object { $NATIVAS -notcontains $_ -and $auto -notcontains $_ }
    $semGuarda  = $candidatas | Where-Object { $testada -notcontains $_ }
    $soTestada  = $candidatas | Where-Object { $testada -contains $_ -and $declarado -notcontains $_ }
    $faltando   = $semGuarda  | Where-Object { $declarado -notcontains $_ }

    $formNome = Split-Path -Leaf $Form
    Write-Host ""
    Write-Host "[THISFORM-PROPS] classe '$Classe' em $(Split-Path -Leaf $Vcx) x $formNome" -ForegroundColor Cyan
    Write-Host ("  ThisForm.<x> citadas pelo p-code : {0}" -f $todas.Count)
    Write-Host ("  nativas de Form (herdadas)       : {0}" -f (@($todas | Where-Object { $NATIVAS -contains $_ }).Count))
    Write-Host ("  auto-criadas pelo VCX            : {0}" -f (@($todas | Where-Object { $auto -contains $_ }).Count))
    Write-Host ("  SEM guarda (o form deve declarar): {0}" -f (@($semGuarda).Count))

    if (@($semGuarda).Count -gt 0) {
        Write-Host ("    -> " + ((@($semGuarda) | Sort-Object) -join ', ')) -ForegroundColor DarkGray
    }

    if (@($soTestada).Count -gt 0) {
        Write-Host ""
        Write-Host ("  WARNING - tocadas so apos Type('ThisForm.X...'), e o form nao as tem ({0}):" -f @($soTestada).Count) -ForegroundColor DarkYellow
        foreach ($p in (@($soTestada) | Sort-Object)) {
            Write-Host ("    - ThisForm." + $p) -ForegroundColor DarkYellow
        }
        Write-Host "    Nao estouram enquanto TODO uso estiver sob o guard. Conferir os sites" -ForegroundColor DarkGray
        Write-Host "    um a um (secao 218) - o script nao consegue provar isso sozinho." -ForegroundColor DarkGray
    }

    if (@($faltando).Count -eq 0) {
        Write-Host ""
        Write-Host "  OK: nenhuma property sem guarda esta ausente do form." -ForegroundColor Green
        exit 0
    }

    Write-Host ""
    Write-Host ("  AUSENTES no form - vao estourar em runtime ({0}):" -f @($faltando).Count) -ForegroundColor Yellow
    foreach ($p in (@($faltando) | Sort-Object)) {
        Write-Host ("    - ThisForm." + $p) -ForegroundColor Yellow
        $ctx = [regex]::Matches($texto, '(?i).{0,70}\bThisForm\.' + [regex]::Escape($p) + '\b.{0,50}') |
               ForEach-Object { $_.Value.Trim() -replace '\s+', ' ' } | Sort-Object -Unique | Select-Object -First 3
        foreach ($c in $ctx) { Write-Host ("        " + $c) -ForegroundColor DarkGray }
    }
    Write-Host ""
    Write-Host "  Antes de so declarar, conferir (secao 218 da skill):" -ForegroundColor Yellow
    Write-Host "    1. os cursores que o bloco recem-habilitado usa existem?" -ForegroundColor DarkGray
    Write-Host "    2. o ciclo de vida do migrado difere do legado? flag de sessao" -ForegroundColor DarkGray
    Write-Host "       precisa de RESET no funil de chamadas, nao so da declaracao." -ForegroundColor DarkGray
    exit 1
}
finally {
    Remove-Item -LiteralPath $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
}
