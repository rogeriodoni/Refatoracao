#==============================================================================
# VerificarFuncoesNaoDefinidas.ps1
#
# PROPOSITO: Encontra chamadas a funcoes/metodos que NAO existem, que em VFP9
#            so estouram em RUNTIME com "File 'nome.prg' does not exist."
#            Duas familias, ambas originadas do Erro154 (2026-09-09):
#
#   NAO-DEFINIDA     - helper que o migrador inventou e nunca definiu
#                      (ex.: ConverterParaLogico, chamado em 6 BOs sem existir)
#   METODO-SEM-THIS  - metodo da propria classe chamado sem o THIS.
#                      (CLAUDE.md regra #8; VFP procura <nome>.prg em disco)
#
# ESCOPO: so nomes do NAMESPACE DE HELPERS do projeto (prefixos Converter/
#         Tratar/Formatar/Validar/Obter/Carregar/...). Restringir ao namespace
#         eh o que mantem o detector com ZERO falso positivo: nome de cursor
#         (TmpX/CsX/CrX), palavra de SQL (VALUES/SUM) e spec de tipo (C(10),
#         N(6,2)) nunca casam com esses prefixos. Uma varredura generica de
#         "funcao nao definida" produz ~400 falsos positivos e foi descartada.
#
# USO:
#   .\VerificarFuncoesNaoDefinidas.ps1                  # projeto inteiro
#   .\VerificarFuncoesNaoDefinidas.ps1 -Caminho <dir>   # subarvore
#
# VALIDACAO (2026-09-09): na arvore pre-fix acusa os 17 call sites reais de
# ConverterParaLogico e mais nada; na arvore corrigida acusa zero.
#==============================================================================

param(
    [string]$Caminho = "C:\4c\projeto\app"
)

$ErrorActionPreference = "Stop"

# --- funcoes nativas do VFP9 (nao sao do projeto) ---------------------------
$builtinsRaw = @(
    'abs acopy acos addbs addproperty adel adir aelement aerror afields afont agetclass agetfileversion ains',
    'ainstance alanguage alen alias alines allt alltrim amembers amouseobj anetresources ansitooem aprinters',
    'aprocinfo asc ascan aselobj asessions asin asort assert asubscript at ataginfo atan atc atcc atcline atline',
    'atn2 aused avcxclasses avg between bindevent bitand bitclear bitlshift bitnot bitor bitrshift bitset bittest',
    'bitxor bof capslock cast cdow cdx ceiling character chr chrsaw chrtran chrtranc cmonth cndx col comarray',
    'comclassinfo compobj comproperty comreturnerror count cpconvert cpcurrent cpdbf createbinary createobject',
    'createobjectex createoffline ctod ctot curdir cursor cursorgetprop cursorsetprop cursortoxml curval date',
    'datetime day dbc dbf dbgetprop dbsetprop ddeaborttrans ddeadvise ddeenabled ddeexecute ddeinitiate',
    'ddelasterror ddepoke dderequest ddesetoption ddesetservice ddesettopic ddeterminate deleted descending',
    'difference directory diskspace displaypath dmy dodefault dow driveType dropoffline dtoc dtor dtos dtot',
    'editsource empty eof error evaluate evl execscript exp fchsize fclose fcount fcreate feof ferror fflush fgets',
    'fieldtype file filer filetostr fklabel fksize floor flush fontmetric fopen for forceext forcepath form found',
    'fputs fread fseek fsize fullpath funique fv fwrite getbar getcolor getcp getcurdir getdir getenv getfile',
    'getfldstate getfont gethost getnextmodified getobject getpad getpem getprinter getwordcount getwordnum',
    'gomonth headerheight home hour iif imestatus indbc indexseek inkey inlist inputbox insmode int isalpha',
    'isblank iscolor isdigit isexclusive isflocked ishosted isleadbyte islocked islower ismemofetched isnull',
    'isreadonly isrlocked istransactable isupper justdrive justext justfname justpath juststem key keymatch',
    'lastkey lcase left leftc len lenc like likec lineno loadpicture locfile log log10 lookup lower ltrim lupdate',
    'macname max mcol md5 mdown memlines memory menu message messagebox min minute mline mod month mrkbar mrkpad',
    'mrow mtoc mton mwindow ndx newobject normalize noteex numeric nvl objnum objtoclient objvar occurs oemtoansi',
    'oldval on order os padc padl padr parameters payment pcol pcount pemstatus pi popup primary printstatus',
    'prmbar prmpad program prompt proper prow prtinfo putfile puzzle pv quarter rand rat ratc ratline rdlevel',
    'readkey reccount recno recsize refresh reindex relation removeproperty rename replicate reportbehavior',
    'requery rgb rgbscheme right rightc rlock round rtod rtrim savepicture scheme scols seconds secs seek select',
    'set setfldstate sign sin skpbar skppad soundex space sqlcancel sqlcolumns sqlcommit sqlconnect sqldisconnect',
    'sqlexec sqlgetprop sqlidleddisconnect sqlmoreresults sqlprepare sqlrollback sqlsetprop sqlstringconnect',
    'sqltables sqrt srows stops str strconv strextract strtofile strtran stuff stuffc subs substr substrc sum sys',
    'sysmetric tablerevert tableupdate tabs tag tagcount tagno tan target textmerge time transform trim ttoc ttod',
    'txnlevel txtwidth type ubound ucase unbindevents unique updated upper used val values varread vartype version',
    'wborder wchild wcols wexist wfont wlast wlcol wlrow wmaximum wminimum wontop woutput wparent wread wrows',
    'wtitle wvisible year zap')
$builtins = @{}
foreach ($bloco in $builtinsRaw) { foreach ($n in ($bloco -split '\s+')) { if ($n) { $builtins[$n] = $true } } }

# prefixos do namespace de helpers/metodos do projeto
$regexNamespace = '^(Converter|Tratar|Formatar|Escapar|Validar|Msg|Mostrar|Calcular|Obter|Gerar|Verificar|Limpar|Preencher|Extrair|Normalizar|Aplicar|Montar|Checar|Carregar|Configurar|Atualizar|Registrar|Executar|Habilitar|Desabilitar|Selecionar|Preparar|Definir|Exibir)[A-Z]'

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  FUNCOES CHAMADAS E NAO DEFINIDAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Caminho: $Caminho" -ForegroundColor Gray
Write-Host ""

$arquivos = Get-ChildItem -Path $Caminho -Recurse -Filter "*.prg" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch '\.bak$' }
Write-Host "Arquivos .prg: $($arquivos.Count)" -ForegroundColor Gray

# --- passo 1: catalogar o que EXISTE ----------------------------------------
# funcao GLOBAL = definida fora de DEFINE CLASS (chamavel sem THIS.)
# METODO        = definida dentro de DEFINE CLASS (exige THIS.)
$globais = @{}
$metodos = @{}
$declares = @{}

foreach ($arq in $arquivos) {
    $dentroClasse = $false
    foreach ($linha in [System.IO.File]::ReadAllLines($arq.FullName)) {
        if ($linha -match '(?i)^\s*DEFINE\s+CLASS\s')  { $dentroClasse = $true }
        if ($linha -match '(?i)^\s*ENDDEFINE')         { $dentroClasse = $false }
        if ($linha -match '(?i)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:FUNCTION|PROCEDURE)\s+([A-Za-z_]\w*)') {
            if ($dentroClasse) { $metodos[$Matches[1].ToLower()] = $true }
            else               { $globais[$Matches[1].ToLower()] = $true }
        }
        # DECLARE <tipo> <Nome> IN <dll>  (API do Windows / DLL externa)
        if ($linha -match '(?i)\bDECLARE\s+\w+\s+([A-Za-z_]\w*)\s+IN\s') {
            $declares[$Matches[1].ToLower()] = $true
        }
    }
}
Write-Host "Funcoes globais: $($globais.Count)   Metodos de classe: $($metodos.Count)   DECLARE externos: $($declares.Count)" -ForegroundColor Gray
Write-Host ""

# --- passo 2: procurar chamadas orfas ---------------------------------------
$achados = @()
foreach ($arq in $arquivos) {
    $nLinha = 0
    foreach ($bruta in [System.IO.File]::ReadAllLines($arq.FullName)) {
        $nLinha++
        $linha = $bruta -replace '\s*&&.*$', ''            # comentario de fim de linha
        if ($linha -match '^\s*\*')                                          { continue }
        if ($linha -match '(?i)^\s*(?:PROTECTED\s+|HIDDEN\s+)?(?:FUNCTION|PROCEDURE)\s') { continue }
        $linha = $linha -replace '"[^"]*"', '""' -replace "'[^']*'", "''"     # literais
        if ($linha -match '(?i)\bDECLARE\s')                                 { continue }

        # chamada "nua": nome( sem ponto antes (com ponto seria metodo de objeto)
        foreach ($m in [regex]::Matches($linha, '(?:^|[^A-Za-z0-9_.])([A-Za-z_]\w*)\s*\(')) {
            $nome = $m.Groups[1].Value
            $k = $nome.ToLower()
            if ($builtins.ContainsKey($k) -or $declares.ContainsKey($k) -or $globais.ContainsKey($k)) { continue }
            if ($nome -notmatch $regexNamespace) { continue }
            $tipo = if ($metodos.ContainsKey($k)) { 'METODO-SEM-THIS' } else { 'NAO-DEFINIDA' }
            $achados += [PSCustomObject]@{
                Arquivo = $arq.FullName.Replace('C:\4c\', '')
                Linha   = $nLinha
                Nome    = $nome
                Tipo    = $tipo
            }
        }
    }
}

# --- passo 3: relatorio ------------------------------------------------------
if ($achados.Count -eq 0) {
    Write-Host "OK - nenhuma chamada orfa encontrada." -ForegroundColor Green
    exit 0
}

Write-Host "$($achados.Count) chamada(s) orfa(s):" -ForegroundColor Red
Write-Host ""
foreach ($grupo in ($achados | Group-Object Tipo | Sort-Object Name)) {
    Write-Host "== $($grupo.Name)  ($($grupo.Count))" -ForegroundColor Yellow
    if ($grupo.Name -eq 'NAO-DEFINIDA') {
        Write-Host "   Helper inexistente: DEFINIR em projeto\app\utils\functions.prg" -ForegroundColor Gray
        Write-Host "   (ou trocar a chamada por um helper que ja exista)." -ForegroundColor Gray
    } else {
        Write-Host "   Metodo da propria classe chamado sem THIS. - prefixar com THIS." -ForegroundColor Gray
        Write-Host "   (CLAUDE.md regra #8)" -ForegroundColor Gray
    }
    foreach ($linhaAchado in ($grupo.Group | Sort-Object Nome, Arquivo, Linha)) {
        Write-Host ("   {0,-42} {1}:{2}" -f $linhaAchado.Nome, $linhaAchado.Arquivo, $linhaAchado.Linha)
    }
    Write-Host ""
}
Write-Host "Resumo por nome:" -ForegroundColor Cyan
$achados | Group-Object Nome | Sort-Object Count -Descending |
    ForEach-Object { Write-Host ("   {0,-42} {1} call site(s)" -f $_.Name, $_.Count) }
exit 1
