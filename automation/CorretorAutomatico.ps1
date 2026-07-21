#==============================================================================
# CorretorAutomatico.ps1
#
# PROPOSITO: Aplica correções automáticas para anti-padrões conhecidos em
#            arquivos .prg gerados pela migração
#
# ANTI-PADROES CORRIGIDOS:
#   1. RETURN dentro de TRY/CATCH -> Substituir por atribuição de variável
#   2. THIS.InicializarForm() após DODEFAULT -> Remover linha
#   3. loForm.Show(1) -> Substituir por loForm.Show()
#   4. loForm.Release() após Show -> Remover linha
#   5. (par_cAlias).campo -> Substituir por SELECT + campo
#   6. Salvar(loc_lNovoRegistro) -> Substituir por Salvar()
#   7. this_cNomeTabela -> this_cTabela
#   8. this_cChavePrimaria -> this_cCampoChave
#   9. VAL(xxx.Value) em campos numericos -> Remover VAL() desnecessario
#  10. Grid.AllowAddNew/.AllowDelete/.AllowEdit -> Remover (nao existem em VFP9)
#  11. BOM UTF-8 no inicio do arquivo -> Remover (VFP9 nao suporta)
#  12. CREATEOBJECT("TamanhoBO") -> CREATEOBJECT("TamBO") (conforme analise.json)
#  13. DEFINE CLASS FormX AS FORM -> DEFINE CLASS FormX AS FormBase
#  14. loc_lResultado vs loc_lSucesso -> Corrigir para nome declarado
#  15. PageFrame.BackColor -> Remover (PageFrame NAO tem BackColor, apenas Pages)
#  16. SetAll("FontName", ..., "Column") -> Grid.FontName (Column NAO tem FontName)
#  17. OptionGroup.Button1 -> OptionGroup.Buttons(1) (via AddObject requer array syntax)
#  18. Caracteres encoding invalido em comentarios -> Substituir por ASCII puro
#  19. PageFrame.ErasePage -> Remover (PageFrame NAO tem ErasePage em VFP9)
#  20. CREATE CURSOR C(N) onde N > 254 -> C(254) (limite VFP9 para campos Character)
#  21. PROTECTED PROCEDURE CarregarLista -> Remover PROTECTED (TesteAutomatico nao consegue chamar)
#  22. .Name em Pages/Columns dentro de WITH -> REMOVER (rename quebra .PageN/.ColumnN referências posteriores)
#  23. TextBox.ControlSource dentro de Column -> Remover (Column.ControlSource ja faz binding)
#  24. OptionGroup.FontName/.FontSize -> Remover (OptionGroup NAO tem FontName/FontSize, apenas Buttons)
#  26. ELSEIF -> ELSE + IF + ENDIF (VFP9 nao suporta ELSEIF)
#  27. Ternario ? : -> IIF() (VFP9 nao suporta operador ternario)
#  28. LOCATE IN alias FOR -> SELECT alias + LOCATE FOR (VFP9 nao suporta LOCATE IN)
#  29. ShowWindow/WindowType ausentes em Form -> Adicionar ShowWindow=1, WindowType=1 (form fecha imediatamente sem isso)
#  31. Aspas duplicadas com EscaparSQL/FormatarDataSQL -> Remover aspas extras (estas funcoes JA incluem aspas)
#  37. ComboBox.NumberOfElements -> Remover (propriedade NAO existe em VFP9)
#  38. Grid.Panel -> Remover (propriedade NAO existe em VFP9)
#  39. PUBLIC PROCEDURE dentro de DEFINE CLASS -> PROCEDURE (PUBLIC e invalido dentro de classe VFP9)
#  45. IF cond THEN cmd (inline IF com THEN) -> IF cond ENDELSE cmd ENDIF (VFP9 nao suporta THEN)
#  46. COUNT TO var IN alias -> SELECT alias + COUNT TO var (VFP9 COUNT nao tem clausula IN)
#  66. NVL(campo, 0) = 1/0 em campos BIT -> IF/ELSE/ENDIF com VARTYPE (IIF avalia AMBOS ramos, NVL falha com LOGICAL)
#  67. par_nKeyCode = 63 em KeyPress -> 115 (F4=115, NAO 63 que eh '?')
#  70. gb_4c_ValidandoUI sem guard TYPE() em InicializarForm -> Adicionar IF TYPE("gb_4c_ValidandoUI") != "L" guard
#  71. VAL(STR(x.Value)) redundante -> x.Value direto (STR retorna string, VAL reconverte, .Value ja tem tipo correto)
#  72. CREATE CURSOR campo N(1,0) onde schema.sql diz BIT -> L (BIT = LOGICAL no VFP9)
#      Tambem corrige Check1.Value = 0 -> .F. e Check1.Value = 1 -> .T. para campos BIT
#  73. BOParaForm CheckBox.Value = (expr logica) -> IIF(expr, 1, 0) (manter tipo NUMERICO)
#
# PARAMETROS:
#   -ArquivoPrg : Caminho do arquivo .prg a corrigir
#   -TaskDir    : Diretório da task (para salvar log de correções)
#
# EXEMPLOS:
#   .\CorretorAutomatico.ps1 -ArquivoPrg "C:\4c\projeto\app\forms\cadastros\FormCor.prg"
#   .\CorretorAutomatico.ps1 -ArquivoPrg "C:\4c\projeto\app\classes\CorBO.prg" -TaskDir "C:\4c\tasks\task1"
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-04
#
# POLITICA OBRIGATORIA - SWEEP RETROATIVO:
#   Ao adicionar um novo pattern OU corrigir um pattern existente neste arquivo,
#   eh OBRIGATORIO rodar imediatamente:
#       powershell.exe -ExecutionPolicy Bypass -File C:\4c\automation\CorrigirTodosFormularios.ps1
#   Sem isso, forms ja migrados continuam com o anti-pattern ate serem testados manualmente.
#   Historico: task018/UfsBO.prg (PUBLIC FUNCTION) e task001/FormDepartamento.prg (ELSEIF)
#   passaram porque novos patterns/correcoes nao foram aplicados retroativamente.
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [string]$ArquivoPrg = "",

    [Parameter(Mandatory=$false)]
    [string]$TaskDir = ""
)

$ErrorActionPreference = "Stop"

#------------------------------------------------------------------------------
# Estrutura para armazenar correções aplicadas
#------------------------------------------------------------------------------

$script:Correcoes = @()

function Add-Correcao {
    param(
        [string]$Tipo,
        [int]$Linha,
        [string]$Original,
        [string]$Corrigido,
        [string]$Descricao
    )

    $script:Correcoes += [PSCustomObject]@{
        Tipo = $Tipo
        Linha = $Linha
        Original = $Original
        Corrigido = $Corrigido
        Descricao = $Descricao
    }
}

#------------------------------------------------------------------------------
# Funções de correção
#------------------------------------------------------------------------------

function Corrigir-ReturnNoTryCatch {
    <#
    .SYNOPSIS
    Detecta e corrige RETURN dentro de TRY/CATCH

    .DESCRIPTION
    RETURN dentro de TRY/CATCH causa "RETURN/RETRY statement not allowed in TRY/CATCH"
    Solução: Declarar variável local, atribuir valor, e RETURN apenas fora do TRY/CATCH
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroTry = $false
    $nivelTry = 0
    $variavelAdicionada = @{}  # Rastreia procedures onde já adicionamos variável

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta início de TRY
        if ($linha -match '^\s*TRY\s*$') {
            $dentroTry = $true
            $nivelTry++
        }

        # Detecta fim de TRY (ENDTRY)
        if ($linha -match '^\s*ENDTRY\s*$') {
            $nivelTry--
            if ($nivelTry -le 0) {
                $dentroTry = $false
                $nivelTry = 0
            }
        }

        # Se estiver dentro de TRY e encontrar RETURN
        if ($dentroTry -and $linha -match '^\s*RETURN\s+(.+)$') {
            $valorRetorno = $Matches[1]

            # Determinar variavel correta: verificar LOCAL declaration do procedimento atual
            $varTarget = "loc_lResultado"
            # Procurar para tras ate o PROCEDURE mais recente
            for ($k = $i - 1; $k -ge 0; $k--) {
                if ($Linhas[$k] -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\b') { break }
                if ($Linhas[$k] -match '(?i)LOCAL\b.*\bloc_lSucesso\b') {
                    $varTarget = "loc_lSucesso"
                    break
                }
            }

            # Substitui RETURN por atribuição direta à variavel correta
            $novaLinha = $linha -replace 'RETURN\s+(.+)', "$varTarget = `$1"
            $novaLinha = $novaLinha -replace '\s*&&.*$', ''  # Remove comentários

            Add-Correcao -Tipo "RETURN_NO_TRY" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "RETURN dentro de TRY substituido por atribuicao"

            $resultado += $novaLinha
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-InicializarFormDuplicado {
    <#
    .SYNOPSIS
    Remove chamada duplicada de THIS.InicializarForm() após DODEFAULT()

    .DESCRIPTION
    FormBase.Init() já chama InicializarForm() internamente.
    Chamar novamente causa erro "A member object with this name already exists"
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $ultimaFoiDodefault = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta DODEFAULT()
        if ($linha -match 'DODEFAULT\s*\(\s*\)') {
            $ultimaFoiDodefault = $true
            $resultado += $linha
            continue
        }

        # Se última foi DODEFAULT e esta é InicializarForm, remove
        if ($ultimaFoiDodefault -and $linha -match 'THIS\.InicializarForm\s*\(\s*\)') {
            Add-Correcao -Tipo "INICIALIZAR_DUPLICADO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "Chamada duplicada de InicializarForm removida"
            $ultimaFoiDodefault = $false
            continue  # Não adiciona a linha
        }

        $ultimaFoiDodefault = $false
        $resultado += $linha
    }

    return $resultado
}

function Corrigir-ShowModal {
    <#
    .SYNOPSIS
    Corrige loForm.Show(1) para loForm.Show()

    .DESCRIPTION
    No novo sistema, forms são controlados pelo FormBase.
    Show(1) não deve ser usado.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        if ($linha -match '\.Show\s*\(\s*1\s*\)') {
            $novaLinha = $linha -replace '\.Show\s*\(\s*1\s*\)', '.Show()'

            Add-Correcao -Tipo "SHOW_MODAL" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "Show(1) substituido por Show()"

            $resultado += $novaLinha
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-ReleaseAposShow {
    <#
    .SYNOPSIS
    Remove loForm.Release() após Show()

    .DESCRIPTION
    FormBase gerencia o ciclo de vida do form.
    Chamar Release() após Show() causa erro.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $ultimaFoiShow = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta Show()
        if ($linha -match '\.Show\s*\(') {
            $ultimaFoiShow = $true
            $resultado += $linha
            continue
        }

        # Se última foi Show e esta é Release, remove
        if ($ultimaFoiShow -and $linha -match '\.Release\s*\(\s*\)') {
            Add-Correcao -Tipo "RELEASE_APOS_SHOW" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "Release() apos Show() removido"
            $ultimaFoiShow = $false
            continue  # Não adiciona a linha
        }

        # Ignora linhas vazias e comentários para manter contexto
        if ($linha -match '^\s*$' -or $linha -match '^\s*\*') {
            $resultado += $linha
            continue
        }

        $ultimaFoiShow = $false
        $resultado += $linha
    }

    return $resultado
}

function Corrigir-SalvarComParametro {
    <#
    .SYNOPSIS
    Corrige Salvar(loc_lNovoRegistro) para Salvar()

    .DESCRIPTION
    BusinessBase.Salvar() não recebe parâmetro.
    Ele usa this_lNovoRegistro internamente.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        if ($linha -match '\.Salvar\s*\(\s*[a-zA-Z_]+\s*\)') {
            $novaLinha = $linha -replace '\.Salvar\s*\([^)]+\)', '.Salvar()'

            Add-Correcao -Tipo "SALVAR_PARAMETRO" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "Salvar() nao recebe parametro"

            $resultado += $novaLinha
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-NomePropriedadesBO {
    <#
    .SYNOPSIS
    Corrige nomes incorretos de propriedades do BusinessBase

    .DESCRIPTION
    - this_cNomeTabela -> this_cTabela
    - this_cChavePrimaria -> this_cCampoChave
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $modificada = $false

        # this_cNomeTabela -> this_cTabela
        if ($linha -match 'this_cNomeTabela') {
            $linha = $linha -replace 'this_cNomeTabela', 'this_cTabela'
            $modificada = $true
        }

        # this_cChavePrimaria -> this_cCampoChave
        if ($linha -match 'this_cChavePrimaria') {
            $linha = $linha -replace 'this_cChavePrimaria', 'this_cCampoChave'
            $modificada = $true
        }

        if ($modificada) {
            Add-Correcao -Tipo "NOME_PROPRIEDADE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Nome de propriedade corrigido"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-AliasComPonto {
    <#
    .SYNOPSIS
    Corrige (par_cAlias).campo para SELECT + campo

    .DESCRIPTION
    VFP não suporta (variavel).campo diretamente.
    Deve usar SELECT (variavel) antes de acessar campos.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta padrão (par_cAlias).campo ou (loc_cAlias).campo
        # EXCLUI: .Columns(n).Prop, .Buttons(n).Prop, .Pages(n).Prop (acesso por index de colecao VFP)
        if ($linha -match '\(([a-zA-Z_]+)\)\.([a-zA-Z_]+)' -and $linha -notmatch '\.(Columns|Buttons|Pages|Controls|Objects|Forms|Items)\(') {
            $alias = $Matches[1]
            $campo = $Matches[2]

            # Substitui por apenas o campo (assume que SELECT já foi feito)
            $novaLinha = $linha -replace '\([a-zA-Z_]+\)\.', ''

            Add-Correcao -Tipo "ALIAS_COM_PONTO" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "Sintaxe (alias).campo corrigida"

            $resultado += $novaLinha
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-TextBoxValueFalse {
    <#
    .SYNOPSIS
    Detecta TextBox sem inicialização de .Value

    .DESCRIPTION
    TextBox.Value default é .F. (false), não string vazia.
    Deve inicializar com .Value = ""

    NOTA: Esta correção é de detecção - não corrige automaticamente
    #>
    param([string[]]$Linhas)

    # Esta função apenas detecta, não corrige
    # Porque a correção depende do contexto (onde está o AddObject)

    return $Linhas
}

function Corrigir-ValDesnecessario {
    <#
    .SYNOPSIS
    Remove VAL() desnecessario e VAL(STR()) redundante em atribuicoes de campos numericos

    .DESCRIPTION
    Padroes detectados e corrigidos:
    - .this_nXXX = VAL(THIS.xxx.Value) -> THIS.xxx.Value (TextBox.Value ja retorna numerico)
    - .this_nXXX = VAL(STR(THIS.xxx.Value)) -> THIS.xxx.Value (STR converte para string, VAL reconverte - redundante)
    - VAL(xxx.txt_4c_XXX.Value) onde XXX indica campo numerico -> xxx.txt_4c_XXX.Value

    NOTA: TextBox.Value ja retorna o tipo correto. VAL() e desnecessario em campos numericos.
    VAL(STR()) e PIOR: STR() converte para string e VAL() reconverte, mas o resultado ja estava correto.
    Pattern #9 (VAL desnecessario) + #71 (VAL(STR()) redundante).
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $modificada = $false

        # Padrao 0 (NOVO #71): VAL(STR(xxx.Value)) -> xxx.Value
        # VAL(STR()) eh redundante - STR converte numerico para string, VAL reconverte para numerico
        # O .Value ja tem o tipo correto, entao ambos wrappers sao desnecessarios
        if ($linha -match 'VAL\s*\(\s*STR\s*\(([^)]+)\.Value\)\s*\)') {
            $novaLinha = $linha -replace 'VAL\s*\(\s*STR\s*\(([^)]+)\.Value\)\s*\)', '$1.Value'
            if ($novaLinha -ne $linha) {
                $linha = $novaLinha
                $modificada = $true
                Add-Correcao -Tipo "VAL_STR_REDUNDANTE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "VAL(STR(x.Value)) redundante -> x.Value direto (Pattern #71)"
            }
        }

        # Padrao 1: .this_nXXX = VAL(THIS.xxx.Value) -> THIS.xxx.Value
        # O campo de destino eh numerico (this_n), TextBox.Value ja retorna numerico
        if ($linha -match '\.this_n\w+\s*=\s*VAL\s*\(([^)]+)\)') {
            $novaLinha = $linha -replace 'VAL\s*\(([^)]+)\.Value\)', '$1.Value'
            if ($novaLinha -ne $linha) {
                $linha = $novaLinha
                $modificada = $true
            }
        }

        # Padrao 2: = VAL(xxx.txt_4c_XXX.Value) onde XXX indica campo numerico
        # Termos que indicam campo numerico: Preco, Valor, Quantidade, Qtd, Numero, Num, Variacao, Percentual
        if ($linha -match '=\s*VAL\s*\([^)]*\.(txt_4c_(?:Preco|Valor|Quantidade|Qtd|Numero|Num|Variacao|Percentual|Total|Saldo|Custo|Comissao|Desconto|Acrescimo|Taxa)\w*)\.Value\)') {
            $novaLinha = $linha -replace 'VAL\s*\(([^)]+)\.Value\)', '$1.Value'
            if ($novaLinha -ne $linha) {
                $linha = $novaLinha
                $modificada = $true
            }
        }

        if ($modificada -and $script:Correcoes[-1].Tipo -ne "VAL_STR_REDUNDANTE") {
            Add-Correcao -Tipo "VAL_DESNECESSARIO" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "VAL() removido de campo numerico"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-GridPropriedadesInvalidas {
    <#
    .SYNOPSIS
    Remove propriedades inválidas de Grid que não existem em VFP9

    .DESCRIPTION
    As seguintes propriedades NÃO EXISTEM no VFP9 Grid:
    - AllowAddNew
    - AllowDelete
    - AllowEdit
    - AllowUpdate

    Claude CLI às vezes gera essas propriedades incorretamente.
    Esta função remove essas linhas para evitar "Property XXX is not found".
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $propriedadesInvalidas = @('AllowAddNew', 'AllowDelete', 'AllowEdit', 'AllowUpdate', 'GridColor')

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $remover = $false

        # Detecta .AllowAddNew = .F. ou .AllowDelete = .T. ou .GridColor = RGB(...) etc.
        foreach ($prop in $propriedadesInvalidas) {
            if ($linha -match "\.$prop\s*=\s*") {
                Add-Correcao -Tipo "GRID_PROPRIEDADE_INVALIDA" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "(removido)" -Descricao "Propriedade $prop nao existe em VFP9 Grid"
                $remover = $true
                break
            }
        }

        if (-not $remover) {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-NomeClasseBO {
    <#
    .SYNOPSIS
    Corrige nomes de classes BO inconsistentes usando o analise.json

    .DESCRIPTION
    Claude CLI às vezes gera nomes de BO expandidos (ex: TamanhoBO em vez de TamBO).
    Esta função lê o analise.json e garante que CREATEOBJECT usa o nome correto.

    Exemplos de correções:
    - CREATEOBJECT("TamanhoBO") -> CREATEOBJECT("TamBO")
    - CREATEOBJECT("CorresBO") -> CREATEOBJECT("CorBO")
    #>
    param(
        [string[]]$Linhas,
        [string]$TaskDir
    )

    # Se não há TaskDir, retorna sem modificações
    if ([string]::IsNullOrEmpty($TaskDir)) {
        return $Linhas
    }

    # Tenta ler analise.json
    $analiseFile = Join-Path $TaskDir "analise.json"
    if (-not (Test-Path $analiseFile)) {
        return $Linhas
    }

    try {
        $analise = Get-Content $analiseFile -Raw | ConvertFrom-Json
        $boClasseCorreta = $analise.form.boClass

        if ([string]::IsNullOrEmpty($boClasseCorreta)) {
            return $Linhas
        }

        # Extrai o prefixo base (ex: "Tam" de "TamBO", "Cor" de "CorBO")
        $prefixoBase = $boClasseCorreta -replace "BO$", ""

        # GUARD: Verificar se o nome na analise.json conflita com DEFINE CLASS real
        # Se existe um .prg com DEFINE CLASS diferente do analise.json, o DEFINE CLASS vence
        $classesDir = Join-Path (Split-Path $TaskDir -Parent | Split-Path -Parent) "projeto\app\classes"
        if (-not (Test-Path $classesDir)) {
            $classesDir = "C:\4c\projeto\app\classes"
        }
        $boFiles = Get-ChildItem -Path $classesDir -Filter "*BO.prg" -ErrorAction SilentlyContinue
        foreach ($bf in $boFiles) {
            $bfContent = Get-Content $bf.FullName -Raw -ErrorAction SilentlyContinue
            if ($bfContent -match "(?i)DEFINE\s+CLASS\s+(\w+BO)\s+AS") {
                $realDefineClass = $Matches[1]
                $realPrefix = ($realDefineClass -replace '(?i)BO$','').ToLower()
                # Se o prefixo do DEFINE CLASS real contem o prefixo da analise (ou vice-versa)
                # e o DEFINE CLASS real eh diferente do analise.json, nao renomear
                if ($realPrefix.Contains($prefixoBase.ToLower()) -or $prefixoBase.ToLower().Contains($realPrefix)) {
                    if ($realDefineClass -ne $boClasseCorreta) {
                        # DEFINE CLASS real vence sobre analise.json - pular renomeacao
                        return $Linhas
                    }
                }
            }
        }

        # Padrões comuns de expansão incorreta do Claude
        $expansoes = @{
            "Tam" = @("Tamanho", "Tamanhos", "Size", "Sizes")
            "Cor" = @("Cores", "Color", "Colors", "Colour")
            "Pro" = @("Produto", "Produtos", "Product", "Products")
            "Grp" = @("Grupo", "Grupos", "Group", "Groups")
            "Dep" = @("Departamento", "Departamentos", "Department", "Departments")
            "Car" = @("Cargo", "Cargos", "Position", "Positions")
            "Cli" = @("Cliente", "Clientes", "Client", "Clients", "Customer", "Customers")
            "Ven" = @("Vendedor", "Vendedores", "Salesperson", "Salespersons")
            "For" = @("Fornecedor", "Fornecedores", "Supplier", "Suppliers")
            "Fun" = @("Funcionario", "Funcionarios", "Employee", "Employees")
        }

        $resultado = @()

        for ($i = 0; $i -lt $Linhas.Count; $i++) {
            $linha = $Linhas[$i]
            $linhaOriginal = $linha
            $corrigida = $false

            # Detecta CREATEOBJECT("XXXbo") com nome incorreto
            if ($linha -match 'CREATEOBJECT\s*\(\s*"([^"]+BO)"\s*\)') {
                $boEncontrado = $Matches[1]

                # Se já é o nome correto, pula
                if ($boEncontrado -eq $boClasseCorreta) {
                    $resultado += $linha
                    continue
                }

                # Verifica se é uma variação conhecida
                if ($expansoes.ContainsKey($prefixoBase)) {
                    foreach ($variacao in $expansoes[$prefixoBase]) {
                        $boVariacao = "${variacao}BO"
                        if ($boEncontrado -eq $boVariacao) {
                            $linha = $linha -replace [regex]::Escape("CREATEOBJECT(`"$boVariacao`")"), "CREATEOBJECT(`"$boClasseCorreta`")"
                            Add-Correcao -Tipo "BO_NOME_INCORRETO" -Linha ($i + 1) -Original "CREATEOBJECT(`"$boVariacao`")" -Corrigido "CREATEOBJECT(`"$boClasseCorreta`")" -Descricao "Nome de BO corrigido conforme analise.json"
                            $corrigida = $true
                            break
                        }
                    }
                }

                # Se ainda não corrigiu e o nome parece errado (diferente do esperado)
                if (-not $corrigida -and $boEncontrado -ne $boClasseCorreta) {
                    # Verifica se parece ser o mesmo BO (contém o prefixo ou é variação)
                    $boSemSufixo = $boEncontrado -replace "BO$", ""
                    if ($boSemSufixo.ToLower().Contains($prefixoBase.ToLower()) -or
                        $prefixoBase.ToLower().Contains($boSemSufixo.ToLower().Substring(0, [Math]::Min(3, $boSemSufixo.Length)))) {
                        $linha = $linha -replace [regex]::Escape("CREATEOBJECT(`"$boEncontrado`")"), "CREATEOBJECT(`"$boClasseCorreta`")"
                        Add-Correcao -Tipo "BO_NOME_INCORRETO" -Linha ($i + 1) -Original "CREATEOBJECT(`"$boEncontrado`")" -Corrigido "CREATEOBJECT(`"$boClasseCorreta`")" -Descricao "Nome de BO corrigido conforme analise.json"
                        $corrigida = $true
                    }
                }
            }

            $resultado += $linha
        }

        return $resultado
    }
    catch {
        Write-Host "AVISO: Erro ao processar analise.json: $($_.Exception.Message)" -ForegroundColor Yellow
        return $Linhas
    }
}

function Corrigir-HerancaFormBase {
    <#
    .SYNOPSIS
    Corrige DEFINE CLASS X AS FORM -> DEFINE CLASS X AS FormBase

    .DESCRIPTION
    Forms devem herdar de FormBase, não de FORM nativo do VFP.
    Isso garante que métodos e propriedades do framework estejam disponíveis.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta DEFINE CLASS XxxForm AS FORM (mas não FormBase)
        if ($linha -match '^\s*DEFINE\s+CLASS\s+Form\w+\s+AS\s+FORM\s*$' -and $linha -notmatch 'FormBase') {
            $linha = $linha -replace '\bAS\s+FORM\s*$', 'AS FormBase'
            Add-Correcao -Tipo "HERANCA_FORMBASE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Form deve herdar de FormBase, nao FORM"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-VariavelResultadoSucesso {
    <#
    .SYNOPSIS
    Corrige uso de loc_lResultado quando loc_lSucesso foi declarado (e vice-versa)

    .DESCRIPTION
    Erro comum onde se declara LOCAL loc_lSucesso mas depois usa loc_lResultado.
    Esta função detecta a inconsistência e corrige para usar o nome declarado.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $variavelDeclarada = $null
    $escopo = 0  # Rastreia PROCEDURE/ENDPROC para escopo local

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $linhaUpper = $linha.ToUpper().Trim()

        # Detecta início de procedimento
        if ($linhaUpper -match '^(PROCEDURE|FUNCTION)\s+') {
            $escopo++
            $variavelDeclarada = $null
        }

        # Detecta fim de procedimento
        if ($linhaUpper -match '^(ENDPROC|ENDFUNC)') {
            $escopo--
            $variavelDeclarada = $null
        }

        # Detecta declaração LOCAL loc_lSucesso ou loc_lResultado
        if ($linha -match '\bLOCAL\b.*\b(loc_lSucesso|loc_lResultado)\b') {
            if ($linha -match '\bloc_lSucesso\b') {
                $variavelDeclarada = "loc_lSucesso"
            } elseif ($linha -match '\bloc_lResultado\b') {
                $variavelDeclarada = "loc_lResultado"
            }
        }

        # Se temos uma variável declarada, corrige usos inconsistentes
        if ($variavelDeclarada -eq "loc_lSucesso" -and $linha -match '\bloc_lResultado\b') {
            $linha = $linha -replace '\bloc_lResultado\b', 'loc_lSucesso'
            Add-Correcao -Tipo "VARIAVEL_INCONSISTENTE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Corrigido loc_lResultado -> loc_lSucesso (conforme declaracao)"
        }
        elseif ($variavelDeclarada -eq "loc_lResultado" -and $linha -match '\bloc_lSucesso\b' -and $linha -notmatch '\bLOCAL\b') {
            $linha = $linha -replace '\bloc_lSucesso\b', 'loc_lResultado'
            Add-Correcao -Tipo "VARIAVEL_INCONSISTENTE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Corrigido loc_lSucesso -> loc_lResultado (conforme declaracao)"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PageFrameBackColor {
    <#
    .SYNOPSIS
    Remove .BackColor de PageFrame (PageFrame NAO tem essa propriedade)

    .DESCRIPTION
    PageFrame NAO tem propriedade BackColor - apenas as Pages internas tem.
    Esta correcao remove linhas como ".BackColor = RGB(...)" quando estao
    diretamente no PageFrame (nao em .Page1.BackColor, .Page2.BackColor, etc).
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroWithPageFrame = $false
    $nomePageFrame = ""

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta AddObject PageFrame e captura o nome
        if ($linha -match 'AddObject\s*\(\s*["\x27](\w+)["\x27]\s*,\s*["\x27]PageFrame["\x27]\s*\)') {
            $nomePageFrame = $Matches[1]
        }

        # Detecta inicio de WITH para o PageFrame
        if ($linha -match "^\s*WITH\s+(THIS\.)?$nomePageFrame\s*$" -and $nomePageFrame -ne "") {
            $dentroWithPageFrame = $true
        }

        # Detecta fim do WITH
        if ($linha -match '^\s*ENDWITH\s*$' -and $dentroWithPageFrame) {
            $dentroWithPageFrame = $false
        }

        # Remove .BackColor direto no PageFrame (NAO em .Page1.BackColor, etc)
        if ($dentroWithPageFrame -and $linha -match '^\s*\.BackColor\s*=' -and $linha -notmatch '\.Page\d+\.BackColor') {
            Add-Correcao -Tipo "PAGEFRAME_BACKCOLOR" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(linha removida)" -Descricao "Removido .BackColor de PageFrame (PageFrame nao tem essa propriedade)"
            continue  # Pula esta linha (nao adiciona ao resultado)
        }

        # Remove pgf_xxx.BackColor fora de WITH (acesso direto)
        if ($linha -match '^\s*(THIS\.)?[\w]+\.BackColor\s*=' -and $linha -notmatch '\.Page\d+\.BackColor') {
            # Verifica se eh um PageFrame conhecido
            if ($linha -match "(THIS\.)?($nomePageFrame)\.BackColor" -and $nomePageFrame -ne "") {
                Add-Correcao -Tipo "PAGEFRAME_BACKCOLOR" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(linha removida)" -Descricao "Removido .BackColor de PageFrame (PageFrame nao tem essa propriedade)"
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-SetAllFontNameColumn {
    <#
    .SYNOPSIS
    Corrige SetAll("FontName", ..., "Column") -> Grid.FontName

    .DESCRIPTION
    Column NAO tem propriedade FontName - apenas Grid tem.
    SetAll com "Column" para FontName causa "Property FONTNAME is not found".
    Solucao: Definir FontName diretamente no Grid.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta .SetAll("FontName", "xxx", "Column")
        if ($linha -match '\.SetAll\s*\(\s*"FontName"\s*,\s*"([^"]+)"\s*,\s*"Column"\s*\)') {
            $fonte = $Matches[1]
            $novaLinha = $linha -replace '\.SetAll\s*\(\s*"FontName"\s*,\s*"[^"]+"\s*,\s*"Column"\s*\)', ".FontName = `"$fonte`""
            Add-Correcao -Tipo "SETALL_FONTNAME_COLUMN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "Column NAO tem FontName - definir no Grid"
            $resultado += $novaLinha
        }
        # Detecta .SetAll("FontSize", n, "Column") - tambem corrigir
        elseif ($linha -match '\.SetAll\s*\(\s*"FontSize"\s*,\s*(\d+)\s*,\s*"Column"\s*\)') {
            $tamanho = $Matches[1]
            $novaLinha = $linha -replace '\.SetAll\s*\(\s*"FontSize"\s*,\s*\d+\s*,\s*"Column"\s*\)', ".FontSize = $tamanho"
            Add-Correcao -Tipo "SETALL_FONTSIZE_COLUMN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "Column NAO tem FontSize - definir no Grid"
            $resultado += $novaLinha
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-OptionGroupButton {
    <#
    .SYNOPSIS
    Corrige .Button1/.Button2 -> .Buttons(1)/.Buttons(2)

    .DESCRIPTION
    OptionGroup criado via AddObject requer sintaxe de array para acessar botoes.
    .Button1 causa "Unknown member BUTTON1".
    Solucao: Usar .Buttons(1), .Buttons(2), etc.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $modificada = $false

        # Detecta .Button1, .Button2, .Button3, etc.
        if ($linha -match '\.Button(\d+)\.') {
            $numero = $Matches[1]
            $linha = $linha -replace "\.Button$numero\.", ".Buttons($numero)."
            $modificada = $true
        }

        if ($modificada) {
            Add-Correcao -Tipo "OPTIONGROUP_BUTTON" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "OptionGroup via AddObject requer .Buttons(n)"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-EncodingInvalido {
    <#
    .SYNOPSIS
    Remove caracteres de encoding invalido (> 127 ASCII) em comentarios

    .DESCRIPTION
    Caracteres acentuados mal formados (� � �) causam erro "Statement is not valid in a class definition"
    porque o compilador VFP9 nao consegue processar UTF-8 com encoding invalido.
    Solucao: Substituir caracteres > 127 ASCII por '?' apenas em linhas de comentario.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $modificada = $false

        # Detecta linhas de comentario (* no inicio)
        if ($linha -match '^\s*\*') {
            # Verifica se tem caracteres > 127 ASCII
            $temCaracterInvalido = $false
            foreach ($char in $linha.ToCharArray()) {
                if ([int][char]$char -gt 127) {
                    $temCaracterInvalido = $true
                    break
                }
            }

            if ($temCaracterInvalido) {
                # Substitui caracteres invalidos por '?'
                $novaLinha = ""
                foreach ($char in $linha.ToCharArray()) {
                    if ([int][char]$char -gt 127) {
                        $novaLinha += '?'
                    } else {
                        $novaLinha += $char
                    }
                }
                $linha = $novaLinha
                $modificada = $true
            }
        }

        if ($modificada) {
            Add-Correcao -Tipo "ENCODING_INVALIDO" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Caracteres invalidos substituidos por '?' em comentario"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PageFrameErasePage {
    <#
    .SYNOPSIS
    Remove propriedade ErasePage de PageFrame (nao existe em VFP9)

    .DESCRIPTION
    PageFrame NAO tem propriedade ErasePage em VFP9.
    Gera erro "Property ERASEPAGE is not found" em runtime.
    Esta funcao remove a linha para evitar o erro.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta .ErasePage = .T. ou .ErasePage = .F.
        if ($linha -match '^\s*\.ErasePage\s*=\s*\.(?:T|F)\.') {
            Add-Correcao -Tipo "PAGEFRAME_ERASEPAGE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "(removido)" -Descricao "Propriedade ErasePage nao existe em VFP9 PageFrame"
            # Nao adiciona a linha (remove)
        }
        else {
            $resultado += $linha
        }
    }

    return $resultado
}

function Corrigir-CreateCursorFieldWidth {
    <#
    .SYNOPSIS
    Corrige C(N) > 254 em CREATE CURSOR para C(254)

    .DESCRIPTION
    VFP9 limita campos Character em CREATE CURSOR a 254 caracteres.
    C(290), C(300) etc. causam "Field width or number of decimal places is invalid".
    Esta funcao substitui C(N) onde N > 254 por C(254).
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Processa apenas linhas com CREATE CURSOR
        if ($linha -match 'CREATE\s+CURSOR') {
            $linhaCorrigida = [regex]::Replace($linha, 'C\((\d+)\)', {
                param($m)
                $n = [int]$m.Groups[1].Value
                if ($n -gt 254) { "C(254)" } else { $m.Value }
            })
            if ($linhaCorrigida -ne $linhaOriginal) {
                Add-Correcao -Tipo "CREATE_CURSOR_FIELD_WIDTH" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linhaCorrigida.Trim() -Descricao "VFP9: Campo C() em CREATE CURSOR limitado a 254 chars - substituido por C(254)"
                $linha = $linhaCorrigida
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-CarregarListaProtected {
    <#
    .SYNOPSIS
    Remove PROTECTED de PROCEDURE CarregarLista

    .DESCRIPTION
    CarregarLista deve ser PUBLIC para o TesteAutomatico poder chama-la.
    PEMSTATUS com flag 5 retorna .T. mesmo para metodos PROTECTED,
    mas a chamada subsequente falha com "Property CARREGARLISTA is not found".
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        if ($linha -match '^\s*PROTECTED\s+PROCEDURE\s+CarregarLista\b') {
            $linha = $linha -replace 'PROTECTED\s+', ''
            Add-Correcao -Tipo "CARREGAR_LISTA_PROTECTED" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "CarregarLista deve ser PUBLIC - PROTECTED impede chamada do TesteAutomatico"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PublicProcedureEmDefineClass {
    <#
    .SYNOPSIS
    Remove PUBLIC de declaracoes PROCEDURE/FUNCTION dentro de DEFINE CLASS

    .DESCRIPTION
    VFP9 nao aceita 'PUBLIC PROCEDURE' nem 'PUBLIC FUNCTION' dentro de DEFINE CLASS.
    Todos os metodos dentro de uma classe sao PUBLIC por default.
    Apenas PROTECTED e HIDDEN sao modifiers validos.
    'PUBLIC PROCEDURE'/'PUBLIC FUNCTION' causa "Syntax error" na compilacao,
    seguido de cascade de "Statement is not valid in a class definition"
    e em runtime o CREATEOBJECT do BO retorna .F. -> "VARTYPE retornou: L"
    ao tentar abrir o form. Bug observado na task018 (UfsBO.prg).
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroDeClasse = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $linhaTrimmed = $linha.TrimStart()

        # Detectar inicio de DEFINE CLASS
        if ($linhaTrimmed -match '^DEFINE\s+CLASS\b' -and $linhaTrimmed -notmatch '^\s*\*') {
            $dentroDeClasse = $true
        }

        # Detectar fim de DEFINE CLASS
        if ($linhaTrimmed -match '^ENDDEFINE\b' -and $dentroDeClasse) {
            $dentroDeClasse = $false
        }

        # Dentro de classe: PUBLIC PROCEDURE/FUNCTION -> PROCEDURE/FUNCTION
        if ($dentroDeClasse -and $linhaTrimmed -match '^PUBLIC\s+(PROCEDURE|FUNCTION)\s+' -and $linhaTrimmed -notmatch '^\s*\*') {
            $tipoMetodo = $matches[1]
            $linha = $linha -replace "PUBLIC\s+$tipoMetodo", $tipoMetodo
            Add-Correcao -Tipo "PUBLIC_PROCEDURE_EM_DEFINE_CLASS" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "PUBLIC $tipoMetodo invalido dentro de DEFINE CLASS - removido PUBLIC"
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PageNameOrdering {
    <#
    .SYNOPSIS
    REMOVE .Name de Pages e Columns (dentro e fora de WITH blocks)

    .DESCRIPTION
    Em VFP9, .Name RENOMEIA o objeto. Qualquer acesso posterior via .Page1/.Column1
    falha com "Unknown member PAGE1/COLUMN1". Reordenar NAO resolve porque o resto
    do código continua usando .Page1/.Page2/.Column1 etc.

    Detecta 3 padroes:
      1. Dentro de WITH: .Name = "xxx"           (quando WITH é de Page/Column)
      2. Fora de WITH:   varName.PageN.Name = ... (formato direto)
      3. Fora de WITH:   varName.ColumnN.Name = ... (formato direto)

    EXEMPLO (problema - dentro de WITH):
        WITH THIS.pgf_4c_1.Page1
            .Caption = "Saldo"
            .Name    = "SALDO"   <- renomeia! .Page1 deixa de existir
        ENDWITH
        loc_o = THIS.pgf_4c_1.Page1  <- FALHA!

    EXEMPLO (corrigido):
        WITH THIS.pgf_4c_1.Page1
            .Caption = "Saldo"
            && .Name removido - renomear Pages/Columns quebra referências
        ENDWITH
    #>
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]@()
    $dentroWithPageCol = $false
    $withTarget = ""

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaTrimmed = $linha.Trim()

        # Detecta inicio de WITH para Page ou Column
        if ($linhaTrimmed -match '(?i)^WITH\s+.*\.(Page\d+|Column\d+)\s*$') {
            $dentroWithPageCol = $true
            $withTarget = $Matches[1]
        }
        # Detecta fim de WITH
        if ($linhaTrimmed -match '(?i)^ENDWITH\s*$') {
            $dentroWithPageCol = $false
            $withTarget = ""
        }

        # Padrao 1: .Name = "xxx" dentro de WITH de Page/Column
        if ($dentroWithPageCol -and $linhaTrimmed -match '(?i)^\.Name\s*=\s*"') {
            $originalText = $linhaTrimmed
            Add-Correcao -Tipo "REMOVE_PAGE_COL_NAME" -Linha ($i + 1) -Original $originalText -Corrigido "(removido)" -Descricao ".Name em $withTarget dentro de WITH REMOVIDO - rename quebra referências .${withTarget}"
            continue  # Pula a linha (remove)
        }

        # Padrao 2: varName.PageN.Name = ... (fora de WITH)
        if ($linhaTrimmed -match '(?i)^\w+\.Page\d+\.Name\s*=') {
            $originalText = $linhaTrimmed
            Add-Correcao -Tipo "REMOVE_PAGE_COL_NAME" -Linha ($i + 1) -Original $originalText -Corrigido "(removido)" -Descricao ".PageN.Name REMOVIDO - rename quebra referências posteriores via .PageN"
            continue
        }

        # Padrao 3: varName.ColumnN.Name = ... (fora de WITH)
        if ($linhaTrimmed -match '(?i)^\w+\.Column\d+\.Name\s*=') {
            $originalText = $linhaTrimmed
            Add-Correcao -Tipo "REMOVE_PAGE_COL_NAME" -Linha ($i + 1) -Original $originalText -Corrigido "(removido)" -Descricao ".ColumnN.Name REMOVIDO - rename quebra referências posteriores via .ColumnN"
            continue
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

function Corrigir-TextBoxControlSourceEmColumn {
    <#
    .SYNOPSIS
    Remove .ControlSource de TextBox/CheckBox adicionados via AddObject em Grid Columns

    .DESCRIPTION
    Quando um TextBox e adicionado via loc_oCol.AddObject("txt", "TextBox"), o VFP9
    usa o Column.ControlSource para o binding de dados. Se o TextBox tambem tiver
    seu proprio .ControlSource, ocorre "Parent object will not allow this property setting"
    porque TextBox.Value = .F. (logico) nao corresponde ao tipo do campo do cursor.

    Esta funcao detecta o padrao:
        loc_oCol.AddObject("txt_xxx", "TextBox")
        WITH loc_oCol.txt_xxx
            .ControlSource = "Cursor.Campo"  <- REMOVER (redundante e causa erro)
            .FontName = ...
        ENDWITH
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroDeColumnControl = $false
    $profundidadeWith = 0
    $nomesControlesEmColuna = [System.Collections.Generic.HashSet[string]]@()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha     = $Linhas[$i]
        $linhaOriginal = $linha

        # Detecta AddObject de TextBox ou CheckBox em loc_oCol
        if ($linha -match 'loc_oCol\.AddObject\("([^"]+)",\s*"(?:TextBox|CheckBox)"\)') {
            [void]$nomesControlesEmColuna.Add($Matches[1])
        }

        # Detecta inicio de WITH block para controle em coluna
        if ($linha -match '^\s*WITH\s+loc_oCol\.(\w+)\s*$') {
            $nomeCtrl = $Matches[1]
            if ($nomesControlesEmColuna.Contains($nomeCtrl)) {
                $dentroDeColumnControl = $true
                $profundidadeWith = 1
            }
        }
        elseif ($dentroDeColumnControl) {
            if ($linha -match '^\s*WITH\b') {
                $profundidadeWith++
            }
            elseif ($linha -match '^\s*ENDWITH\b') {
                $profundidadeWith--
                if ($profundidadeWith -le 0) {
                    $dentroDeColumnControl = $false
                    $profundidadeWith = 0
                }
            }
            elseif ($profundidadeWith -eq 1 -and $linha -match '^\s*\.ControlSource\s*=') {
                # Remove ControlSource redundante dentro de controle em Column
                Add-Correcao -Tipo "TEXTBOX_CONTROLSOURCE_COLUMN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "(removido)" -Descricao "TextBox/CheckBox em Grid Column nao deve ter .ControlSource proprio - Column.ControlSource ja faz o binding"
                # Substitui a linha por comentario explicativo
                $linha = ($linha -replace '\.ControlSource\s*=.*$', '&& ControlSource omitido: Column.ControlSource ja faz o binding')
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-OptionGroupFontName {
    <#
    .SYNOPSIS
    Remove .FontName/.FontSize de OptionGroup e CommandGroup (nao existem, usar nas Buttons)

    .DESCRIPTION
    OptionGroup e CommandGroup criados via AddObject NAO possuem propriedades FontName/FontSize.
    Essas propriedades devem ser definidas nas Buttons individuais (.Buttons(1), .Buttons(2), etc.).
    Tentar definir .FontName no grupo causa "Property FONTNAME is not found".
    Esta funcao detecta o padrao:
        AddObject("xxx", "OptionGroup") ou AddObject("xxx", "CommandGroup")
        WITH ... .xxx
            .FontName = "Tahoma"   <- REMOVER
            .FontSize = 8          <- REMOVER
        ENDWITH
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $groupNames = [System.Collections.Generic.HashSet[string]]@()
    $insideGroupWith = $false
    $currentGroupType = ""

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha
        $remover = $false

        # Detecta AddObject de OptionGroup ou CommandGroup
        if ($linha -match 'AddObject\s*\(\s*"([^"]+)"\s*,\s*"(OptionGroup|CommandGroup)"\s*\)') {
            [void]$groupNames.Add($Matches[1])
        }

        # Detecta WITH block que termina com nome de grupo
        if ($linha -match '^\s*WITH\s+') {
            foreach ($name in $groupNames) {
                if ($linha -match "\.$([regex]::Escape($name))\s*$") {
                    $insideGroupWith = $true
                    break
                }
            }
        }

        # Dentro de WITH de OptionGroup/CommandGroup, remover FontName/FontSize
        if ($insideGroupWith) {
            if ($linha -match '^\s*\.FontName\s*=') {
                $remover = $true
                Add-Correcao -Tipo "GROUP_FONTNAME" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "(removido)" -Descricao "OptionGroup/CommandGroup NAO tem FontName - definir nas Buttons individuais"
            }
            elseif ($linha -match '^\s*\.FontSize\s*=') {
                $remover = $true
                Add-Correcao -Tipo "GROUP_FONTSIZE" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "(removido)" -Descricao "OptionGroup/CommandGroup NAO tem FontSize - definir nas Buttons individuais"
            }

            if ($linha -match '^\s*ENDWITH\b') {
                $insideGroupWith = $false
            }
        }

        if (-not $remover) {
            $resultado += $linha
        }
    }

    return $resultado
}

#------------------------------------------------------------------------------
# 26. ELSEIF -> ELSE + IF (VFP9 nao suporta ELSEIF)
#------------------------------------------------------------------------------

function Corrigir-ElseIf {
    param([string[]]$Linhas)

    # Abordagem: single-pass com stack para rastrear nesting de IF/ENDIF
    # Cada entrada no stack = numero de ELSEIFs convertidos nesse bloco IF
    $resultado = @()
    $stack = [System.Collections.Generic.Stack[int]]::new()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaTrim = $linha.Trim().ToUpper()

        # Detecta inicio de IF (exceto linhas de comentario)
        if ($linhaTrim -match '^IF\b' -and -not $linhaTrim.StartsWith("*")) {
            $stack.Push(0)
            $resultado += $linha
            continue
        }

        # Detecta ELSEIF
        if ($linha -match '^(\s*)ELSEIF\b(.*)$') {
            $indent = $Matches[1]
            $condicao = $Matches[2]

            # Substituir ELSEIF por ELSE + IF
            $resultado += "${indent}ELSE"
            $resultado += "${indent}    IF${condicao}"

            # Incrementar contador de ELSEIFs no bloco IF atual
            if ($stack.Count -gt 0) {
                $current = $stack.Pop()
                $stack.Push($current + 1)
            }

            Add-Correcao -Tipo "ELSEIF" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "ELSE + IF${condicao}" -Descricao "VFP9 nao suporta ELSEIF - convertido para ELSE + IF + ENDIF extra"
            continue
        }

        # Detecta ENDIF
        if ($linhaTrim -match '^ENDIF\b' -and -not $linhaTrim.StartsWith("*")) {
            if ($stack.Count -gt 0) {
                $pendentes = $stack.Pop()
                if ($pendentes -gt 0) {
                    # Adicionar N ENDIFs extras ANTES do ENDIF original
                    $indent = $linha -replace '\S.*$', ''
                    for ($j = 0; $j -lt $pendentes; $j++) {
                        $resultado += "${indent}    ENDIF"
                    }
                }
            }
            $resultado += $linha
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# 27. Ternário ? : -> IIF() (VFP9 nao suporta operador ternario)
#------------------------------------------------------------------------------

function Corrigir-TernarioParaIIF {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Ignorar comentários
        if ($linha.Trim() -match '^\*|^&&') {
            $resultado += $linha
            continue
        }

        # Detecta padrão: ISNULL(xxx) ? valor1 : valor2
        # Ou: condicao ? valor1 : valor2 (em atribuições)
        if ($linha -match '(.*=\s*)(.*?)\s+\?\s+(.*?)\s+:\s+(.*)$') {
            $prefixo = $Matches[1]
            $condicao = $Matches[2]
            $valorTrue = $Matches[3]
            $valorFalse = $Matches[4]

            # Verificar se não é dentro de string
            if ($condicao -notmatch "^['""]") {
                $novaLinha = "${prefixo}IIF(${condicao}, ${valorTrue}, ${valorFalse})"
                $resultado += $novaLinha
                Add-Correcao -Tipo "TERNARIO_IIF" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "VFP9 nao suporta operador ternario ? : - convertido para IIF()"
                continue
            }
        }

        # Padrão alternativo: ALLTRIM(ISNULL(xxx) ? "" : xxx)
        if ($linha -match '(.*)(ALLTRIM\()(ISNULL\([^)]+\))\s+\?\s+(""|'''')\s+:\s+([^)]+)(\).*)$') {
            $pre = $Matches[1]
            $fn = $Matches[2]
            $isnullExpr = $Matches[3]
            $valorTrue2 = $Matches[4]
            $valorFalse2 = $Matches[5]
            $pos = $Matches[6]

            $novaLinha = "${pre}${fn}IIF(${isnullExpr}, ${valorTrue2}, ${valorFalse2})${pos}"
            $resultado += $novaLinha
            Add-Correcao -Tipo "TERNARIO_IIF" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $novaLinha.Trim() -Descricao "VFP9 nao suporta operador ternario ? : - convertido para IIF()"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# 28. LOCATE IN alias FOR -> SELECT alias + LOCATE FOR (VFP9 nao suporta LOCATE IN)
#------------------------------------------------------------------------------

function Corrigir-LocateIn {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        # Variante 1: LOCATE IN alias FOR condicao
        if ($linha -match '^(\s*)LOCATE\s+IN\s+(\S+)\s+FOR\s+(.*)$') {
            $indent = $Matches[1]
            $alias = $Matches[2]
            $condicao = $Matches[3]

            $resultado += "${indent}SELECT ${alias}"
            $resultado += "${indent}LOCATE FOR ${condicao}"
            Add-Correcao -Tipo "LOCATE_IN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "SELECT ${alias} + LOCATE FOR ${condicao}" -Descricao "VFP9 nao suporta LOCATE IN - convertido para SELECT + LOCATE FOR"
            continue
        }

        # Variante 2: LOCATE FOR condicao IN alias  (bug observado em task001/FormDepartamento.prg:1011, 2026-05-14)
        if ($linha -match '^(\s*)LOCATE\s+FOR\s+(.+?)\s+IN\s+(\S+)\s*$') {
            $indent = $Matches[1]
            $condicao = $Matches[2]
            $alias = $Matches[3]

            $resultado += "${indent}SELECT ${alias}"
            $resultado += "${indent}LOCATE FOR ${condicao}"
            Add-Correcao -Tipo "LOCATE_IN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "SELECT ${alias} + LOCATE FOR ${condicao}" -Descricao "VFP9 nao suporta clausula IN no LOCATE - convertido para SELECT + LOCATE FOR"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# 29. ShowWindow/WindowType ausentes em Form -> Adicionar (form fecha sem isso)
#------------------------------------------------------------------------------
function Corrigir-ShowWindowAusente {
    param([string[]]$Linhas)

    # Verifica se eh um arquivo Form (DEFINE CLASS ... AS FormBase)
    $ehForm = $false
    $temShowWindow = $false
    $temWindowType = $false
    $linhaDefineClass = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i].Trim()
        if ($linha -match '(?i)^DEFINE\s+CLASS\s+\w+\s+AS\s+FormBase') {
            $ehForm = $true
            $linhaDefineClass = $i
        }
        if ($linha -match '(?i)^\s*ShowWindow\s*=\s*1') {
            $temShowWindow = $true
        }
        if ($linha -match '(?i)^\s*WindowType\s*=\s*1') {
            $temWindowType = $true
        }
    }

    if (-not $ehForm -or ($temShowWindow -and $temWindowType)) {
        return $Linhas
    }

    # Encontra onde inserir (antes de ControlBox ou apos Caption/AutoCenter)
    $resultado = [System.Collections.ArrayList]::new()
    $inserido = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaTrim = $linha.Trim()

        # Inserir antes de ControlBox = .F. (se existir como propriedade de classe)
        if (-not $inserido -and $linhaTrim -match '(?i)^ControlBox\s*=\s*\.F\.') {
            $indent = if ($linha -match '^(\s+)') { $Matches[1] } else { "`t" }
            if (-not $temShowWindow) {
                [void]$resultado.Add("${indent}ShowWindow = 1")
                Add-Correcao -Tipo "SHOWWINDOW_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido "ShowWindow = 1" -Descricao "ShowWindow=1 adicionado (form fecha imediatamente sem isso)"
            }
            if (-not $temWindowType) {
                [void]$resultado.Add("${indent}WindowType = 1")
                Add-Correcao -Tipo "WINDOWTYPE_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido "WindowType = 1" -Descricao "WindowType=1 adicionado (form deve ser modal)"
            }
            $inserido = $true
        }

        # Fallback: se nao encontrou ControlBox como propriedade de classe,
        # inserir APOS DataSession = X (propriedade comum em forms com DataSession privada)
        # ou APOS a linha DEFINE CLASS (ultimo recurso)
        if (-not $inserido -and $linhaTrim -match '(?i)^DataSession\s*=\s*\d') {
            [void]$resultado.Add($linha)
            $indent = if ($linha -match '^(\s+)') { $Matches[1] } else { "`t" }
            if (-not $temShowWindow) {
                [void]$resultado.Add("${indent}ShowWindow = 1")
                Add-Correcao -Tipo "SHOWWINDOW_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido "ShowWindow = 1" -Descricao "ShowWindow=1 adicionado apos DataSession (form fecha imediatamente sem isso)"
            }
            if (-not $temWindowType) {
                [void]$resultado.Add("${indent}WindowType = 1")
                Add-Correcao -Tipo "WINDOWTYPE_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido "WindowType = 1" -Descricao "WindowType=1 adicionado apos DataSession (form deve ser modal)"
            }
            $inserido = $true
            continue
        }

        [void]$resultado.Add($linha)
    }

    # Ultimo fallback: inserir logo apos DEFINE CLASS
    if (-not $inserido -and $linhaDefineClass -ge 0) {
        $resultadoFinal = [System.Collections.ArrayList]::new()
        for ($i = 0; $i -lt $resultado.Count; $i++) {
            [void]$resultadoFinal.Add($resultado[$i])
            if ($i -eq $linhaDefineClass) {
                $indent = "`t"
                if (-not $temShowWindow) {
                    [void]$resultadoFinal.Add("${indent}ShowWindow = 1")
                    Add-Correcao -Tipo "SHOWWINDOW_AUSENTE" -Linha ($i + 2) -Original "(ausente)" -Corrigido "ShowWindow = 1" -Descricao "ShowWindow=1 adicionado apos DEFINE CLASS (form fecha imediatamente sem isso)"
                }
                if (-not $temWindowType) {
                    [void]$resultadoFinal.Add("${indent}WindowType = 1")
                    Add-Correcao -Tipo "WINDOWTYPE_AUSENTE" -Linha ($i + 2) -Original "(ausente)" -Corrigido "WindowType = 1" -Descricao "WindowType=1 adicionado apos DEFINE CLASS (form deve ser modal)"
                }
            }
        }
        return $resultadoFinal.ToArray()
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# BINDEVENT handlers sem LPARAMETERS para eventos que passam parametros
# Eventos VFP que passam parametros obrigatorios:
#   AfterRowColChange(nColIndex)
#   KeyPress(nKeyCode, nShiftAltCtrl)
#   InteractiveChange (sem parametro, mas incluido por seguranca)
# Se o handler nao declara par_, VFP gera "No PARAMETER statement is found"
#------------------------------------------------------------------------------
function Corrigir-BindEventSemParametros {
    param([string[]]$Linhas)

    # Mapa: evento → parametros esperados no handler
    $eventosComParam = @{
        'AfterRowColChange' = 'par_nColIndex'
        'KeyPress'          = 'par_nKeyCode, par_nShiftAltCtrl'
    }

    # Fase 1: Coletar todos os BINDEVENTs com eventos que passam parametros
    $bindHandlers = @{}
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)BINDEVENT\s*\(.+?,\s*"(\w+)"\s*,\s*.+?,\s*"(\w+)"\s*\)') {
            $evento = $Matches[1]
            $handler = $Matches[2]
            foreach ($ev in $eventosComParam.Keys) {
                if ($evento -eq $ev) {
                    $bindHandlers[$handler] = @{ Evento = $ev; Params = $eventosComParam[$ev]; LinhaBindEvent = $i }
                }
            }
        }
    }

    if ($bindHandlers.Count -eq 0) {
        return $Linhas
    }

    # Fase 2: Verificar se os handlers tem parametros
    $resultado = [System.Collections.ArrayList]::new()
    $handlersCorrigidos = @{}
    $handlersInjetadosLparam = @{}  # Handlers onde ja injetamos LPARAMETERS na proxima linha (Formsigrepes-style)
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaTrim = $linha.Trim()
        $corrigiu = $false

        # Detecta PROCEDURE HandlerName() sem parametros -> corrige adicionando params
        foreach ($handler in $bindHandlers.Keys) {
            if ($handlersCorrigidos.ContainsKey($handler)) { continue }
            $info = $bindHandlers[$handler]
            if ($linhaTrim -match "(?i)^PROCEDURE\s+$handler\s*\(\s*\)\s*$") {
                $novaLinha = $linha -replace "(?i)(PROCEDURE\s+$handler\s*)\(\s*\)", "`$1($($info.Params))"
                [void]$resultado.Add($novaLinha)
                Add-Correcao -Tipo "BINDEVENT_SEM_PARAMS" -Linha ($i + 1) `
                    -Original $linhaTrim `
                    -Corrigido $novaLinha.Trim() `
                    -Descricao "Handler de $($info.Evento) precisa de LPARAMETERS - VFP passa parametros obrigatorios"
                $handlersCorrigidos[$handler] = $true
                $corrigiu = $true
                break
            }
        }

        # Detecta PROCEDURE HandlerName (SEM parens) — Formsigrepes-style
        # Injeta LPARAMETERS como nova linha imediatamente apos, com indent consistente
        if (-not $corrigiu) {
            foreach ($handler in $bindHandlers.Keys) {
                if ($handlersCorrigidos.ContainsKey($handler)) { continue }
                if ($handlersInjetadosLparam.ContainsKey($handler)) { continue }
                $info = $bindHandlers[$handler]
                if ($linhaTrim -match "(?i)^PROCEDURE\s+$handler\s*$") {
                    # Verificar se ja tem LPARAMETERS logo abaixo (evita duplicar)
                    $jaTemLparam = $false
                    for ($j = $i + 1; $j -lt [Math]::Min($i + 3, $Linhas.Count); $j++) {
                        if ($Linhas[$j].Trim() -match '(?i)^LPARAMETERS\s+par_') {
                            $jaTemLparam = $true
                            break
                        }
                    }
                    if (-not $jaTemLparam) {
                        # Detectar indent do proximo LOCAL/comando
                        $indent = "        "  # default 8 espacos
                        for ($j = $i + 1; $j -lt [Math]::Min($i + 5, $Linhas.Count); $j++) {
                            if ($Linhas[$j] -match '^(\s+)\S') {
                                $indent = $Matches[1]
                                break
                            }
                        }
                        [void]$resultado.Add($linha)
                        [void]$resultado.Add("${indent}LPARAMETERS $($info.Params)")
                        Add-Correcao -Tipo "BINDEVENT_LPARAM_INJETADO" -Linha ($i + 2) `
                            -Original "(LPARAMETERS ausente em handler bindado a $($info.Evento))" `
                            -Corrigido "${indent}LPARAMETERS $($info.Params)" `
                            -Descricao "Injetado LPARAMETERS em '$handler' (handler de $($info.Evento) sem params gera 'No PARAMETER statement is found')"
                        $handlersInjetadosLparam[$handler] = $true
                        $corrigiu = $true
                        break
                    }
                }
            }
        }

        if (-not $corrigiu) {
            [void]$resultado.Add($linha)
        }
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #112: KeyPress handler de LOOKUP sem guard 13/9/115
# Detecta PROCEDURE Validar* / PROCEDURE Abrir* bindada a KeyPress que abre
# FormBuscaAuxiliar (via CREATEOBJECT). Injeta guard imediatamente apos
# LPARAMETERS: IF par_nKeyCode != 13 AND != 9 AND != 115 / RETURN / ENDIF
# Sem guard, picker abre a cada tecla digitada (UX quebrada).
# Bug: Formsigrepes.prg (2026-07-02, Erro18): 24 handlers de lookup sem guard.
#------------------------------------------------------------------------------
function Corrigir-KeyPressGuardLookup {
    param([string[]]$Linhas)

    # Fase 1: coletar handlers bindados a KeyPress
    $keyPressHandlers = @{}
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)BINDEVENT\s*\(.+?,\s*"KeyPress"\s*,\s*.+?,\s*"(\w+)"\s*\)') {
            $keyPressHandlers[$Matches[1]] = $true
        }
    }
    if ($keyPressHandlers.Count -eq 0) { return $Linhas }

    # Fase 2: para cada handler, ver se abre FormBuscaAuxiliar E se ja tem guard
    # Se abre picker E nao tem guard, injetar apos LPARAMETERS
    $resultado = [System.Collections.ArrayList]::new()
    $procIdxCache = @{}   # handler -> {start=idx, end=idx, hasPicker=bool, hasGuard=bool, lparamIdx=idx}

    # Scan sequencial: identificar cada PROCEDURE e mapear corpo
    $currentHandler = ""
    $procStart = -1
    $procHasPicker = $false
    $procHasGuard = $false
    $procLparamIdx = -1

    function Test-HandlerRelevant($name) {
        # Considera todos os handlers KeyPress cujo body abre FormBuscaAuxiliar
        # (padrao Validar*/Abrir*/Buscar* usual)
        return $true
    }

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $trim = $linha.Trim()
        if ($trim -match '(?i)^PROCEDURE\s+(\w+)') {
            # Salvar handler anterior se relevante
            if ($currentHandler -ne "" -and $keyPressHandlers.ContainsKey($currentHandler)) {
                $procIdxCache[$currentHandler] = @{
                    Start = $procStart
                    End = $i - 1
                    HasPicker = $procHasPicker
                    HasGuard = $procHasGuard
                    LparamIdx = $procLparamIdx
                }
            }
            $currentHandler = $Matches[1]
            $procStart = $i
            $procHasPicker = $false
            $procHasGuard = $false
            $procLparamIdx = -1
        } elseif ($trim -match '(?i)^ENDPROC') {
            if ($currentHandler -ne "" -and $keyPressHandlers.ContainsKey($currentHandler)) {
                $procIdxCache[$currentHandler] = @{
                    Start = $procStart
                    End = $i
                    HasPicker = $procHasPicker
                    HasGuard = $procHasGuard
                    LparamIdx = $procLparamIdx
                }
            }
            $currentHandler = ""
        } elseif ($currentHandler -ne "" -and $keyPressHandlers.ContainsKey($currentHandler)) {
            if ($trim -match '(?i)^LPARAMETERS\s+par_nKeyCode') {
                $procLparamIdx = $i
            } elseif ($trim -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
                $procHasPicker = $true
            } elseif ($trim -match 'par_nKeyCode\s*!=\s*13\s+AND\s+par_nKeyCode\s*!=\s*9\s+AND\s+par_nKeyCode\s*!=\s*115') {
                $procHasGuard = $true
            } elseif ($trim -match 'par_nKeyCode\s*=\s*13\s+OR\s+par_nKeyCode\s*=\s*9\s+OR\s+par_nKeyCode\s*=\s*115') {
                $procHasGuard = $true
            }
        }
    }

    # Fase 3: injetar guard nos handlers relevantes
    $guardInjectAfter = @{}  # linha index -> lista de linhas para injetar depois dela
    foreach ($handler in $procIdxCache.Keys) {
        $info = $procIdxCache[$handler]
        if (-not $info.HasPicker) { continue }   # so injeta em handler que abre picker
        if ($info.HasGuard) { continue }         # ja tem guard
        if ($info.LparamIdx -lt 0) { continue }  # sem LPARAMETERS (pattern #30 fix primeiro)
        # Detectar indent do LPARAMETERS
        $lparamLinha = $Linhas[$info.LparamIdx]
        $indent = ""
        if ($lparamLinha -match '^(\s+)') { $indent = $Matches[1] }
        $guardInjectAfter[$info.LparamIdx] = @(
            "${indent}IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115"
            "${indent}    RETURN"
            "${indent}ENDIF"
        )
        Add-Correcao -Tipo "KEYPRESS_GUARD_LOOKUP" -Linha ($info.LparamIdx + 2) `
            -Original "(guard 13/9/115 ausente em handler de lookup KeyPress)" `
            -Corrigido "IF par_nKeyCode != 13 AND != 9 AND != 115 / RETURN / ENDIF" `
            -Descricao "Handler '$handler' abre FormBuscaAuxiliar sem guard Enter/Tab/F4 - Pattern #112 injetou guard (picker nao abre mais a cada tecla)"
    }

    # Fase 4: reconstruir array com injecoes
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        [void]$resultado.Add($Linhas[$i])
        if ($guardInjectAfter.ContainsKey($i)) {
            foreach ($novaLinha in $guardInjectAfter[$i]) {
                [void]$resultado.Add($novaLinha)
            }
        }
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #115: SigCdGcr tem coluna 'descrs' (com 'r'), NAO 'descs'.
# Migrador confunde com SigCdGpr/SigCdLin/SigCdCol que legitimamente tem 'descs'.
# Fase 1: identifica cursores derivados de SigCdGcr (via SQLEXEC ou FormBuscaAuxiliar Init).
# Fase 2: em qualquer linha que contenha SigCdGcr E descs, ou em cursor derivado, corrige.
# Fase 3: dentro do escopo do AbrirBusca* que abre FormBuscaAuxiliar sobre SigCdGcr,
#         corrige mAddColuna("descs") e ALLTRIM(descs) apos SELECT (cursor).
# Bug em FormSIGREAEG/FormSIGREEGG/FormSigReCsp/Formsigreegp (2026-07-02, Erro21).
#------------------------------------------------------------------------------
function Corrigir-SigCdGcrDescrsColuna {
    param([string[]]$Linhas)

    # Fase 1: identificar cursores derivados de SigCdGcr
    $cursoresGcr = @{}  # cursorName -> $true
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        # Padrao SQLEXEC: SELECT ... FROM SigCdGcr ... "cursor_X"
        # As chamadas geralmente sao multi-linha; olhar 2 linhas a frente para o cursor destino
        if ($linha -match '(?i)FROM\s+SigCdGcr\b') {
            # Buscar cursor destino nas proximas 3 linhas
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"(cursor_4c_\w+)"\s*\)') {
                    $cursoresGcr[$Matches[1]] = $true
                    break
                }
            }
        }
        # Padrao FormBuscaAuxiliar: CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdGcr", <cursor>, ...)
        if ($linha -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
            # As chamadas sao multi-linha; olhar ate 3 linhas a frente
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"SigCdGcr"\s*,\s*(\w+)') {
                    # cursor pode ser variavel (loc_cCursor) ou string literal
                    $cursorArg = $Matches[1]
                    if ($cursorArg -match '(?i)^loc_') {
                        # Variavel: buscar assign na PROCEDURE atual (backward search)
                        for ($k = $j; $k -ge [Math]::Max(0, $j - 30); $k--) {
                            if ($Linhas[$k] -match "(?i)$cursorArg\s*=\s*`"(cursor_\w+)`"") {
                                $cursoresGcr[$Matches[1]] = $true
                                break
                            }
                        }
                    }
                    break
                }
                if ($Linhas[$j] -match '(?i)"SigCdGcr"\s*,\s*"(cursor_\w+)"') {
                    $cursoresGcr[$Matches[1]] = $true
                    break
                }
            }
        }
    }

    # Fase 2 + 3: corrigir descs -> descrs em contextos SigCdGcr
    $resultado = [System.Collections.ArrayList]::new()
    $inSigCdGcrBusca = $false  # dentro de bloco AbrirBusca* que abre SigCdGcr
    $procBraceDepth = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Rastreio de bloco AbrirBusca sobre SigCdGcr (para corrigir mAddColuna)
        if ($linha -match '(?i)^\s*PROCEDURE\s+\w+') {
            $inSigCdGcrBusca = $false
        }
        if ($linha -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
            # Olhar frente por "SigCdGcr"
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"SigCdGcr"') {
                    $inSigCdGcrBusca = $true
                    break
                }
            }
        }
        if ($linha -match '(?i)^\s*loc_oBusca\.Release\s*\(') {
            $inSigCdGcrBusca = $false
        }

        # (a) linha que mencione SigCdGcr E descs -> corrigir
        if ($linha -match '(?i)SigCdGcr' -and $linha -match '(?i)\bdescs\b') {
            $linha = $linha -replace '(?i)\bdescs\b', 'descrs'
        }

        # (b) referencia a cursor.descs para cursor derivado de SigCdGcr
        foreach ($cursor in $cursoresGcr.Keys) {
            $linha = $linha -replace "(?i)($cursor)\.descs\b", "`$1.descrs"
        }

        # (c) dentro de bloco AbrirBusca* de SigCdGcr, corrigir mAddColuna("descs" ...)
        if ($inSigCdGcrBusca) {
            $linha = $linha -replace '(?i)mAddColuna\s*\(\s*"descs"', 'mAddColuna("descrs"'
        }

        # (d) linhas ALLTRIM(descs) apos SELECT (cursor) de SigCdGcr
        # Heuristica: se linha anterior era `SELECT (algum_cursor_de_SigCdGcr)`, corrigir ALLTRIM(descs) na proxima
        if ($i -gt 0) {
            $linhaAnterior = $Linhas[$i - 1]
            foreach ($cursor in $cursoresGcr.Keys) {
                if ($linhaAnterior -match "(?i)SELECT\s+\(\s*(loc_cCursor|`"$cursor`")\s*\)" -or `
                    $linhaAnterior -match "(?i)SELECT\s+$cursor\b") {
                    if ($linha -match '(?i)ALLTRIM\s*\(\s*descs\s*\)') {
                        $linha = $linha -replace '(?i)ALLTRIM\s*\(\s*descs\s*\)', 'ALLTRIM(descrs)'
                    }
                }
            }
        }

        if ($linha -ne $original) {
            Add-Correcao -Tipo "SIGCDGCR-DESCRS-COL" -Linha ($i + 1) `
                -Original $original.Trim() `
                -Corrigido $linha.Trim() `
                -Descricao "SigCdGcr tem coluna 'descrs' (com r), NAO 'descs' - Pattern #115 corrigiu"
        }
        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #114: Handler de validacao com MsgAviso("...encontrada") antes de
# THIS.AbrirBusca<X>() — UX quebrada: user ve dialog "nao encontrada" antes
# do picker abrir. Fix: remover MsgAviso + clear-field, deixar apenas AbrirBusca.
# Antes do fix, user tinha 2 modais em sequencia (Aviso -> OK -> Picker) e o
# valor digitado era limpo antes do picker abrir (perdia o LIKE prefix).
# Bug em FormSIGREADS.prg (2026-07-02, Erro20) + 49 forms com mesmo padrao.
#------------------------------------------------------------------------------
function Corrigir-MsgAvisoAntesDoPicker {
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]::new()
    $i = 0
    while ($i -lt $Linhas.Count) {
        $linha = $Linhas[$i]

        # Detecta MsgAviso("...encontrad...", "...") ou similar (single OU multi-linha)
        if ($linha -match '(?i)^\s*MsgAviso\s*\(\s*["\[].*encontrad') {
            # v2 (2026-07-21): detecta fim de MsgAviso multi-linha (continuation `;`)
            # Linha inicial "MsgAviso(...)" pode ter ; no fim; segue continuando ate
            # encontrar linha SEM `;` no fim, que eh a ultima do statement MsgAviso.
            $idxMsgAvisoEnd = $i
            while ($idxMsgAvisoEnd -lt ($Linhas.Count - 1) -and $Linhas[$idxMsgAvisoEnd] -match ';\s*$') {
                $idxMsgAvisoEnd++
            }

            # Olhar ate 5 linhas apos o fim do MsgAviso por THIS.AbrirBusca<X>()
            $achouAbrirBusca = -1
            for ($j = $idxMsgAvisoEnd + 1; $j -lt [Math]::Min($idxMsgAvisoEnd + 6, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)^\s*THIS\.AbrirBusca\w+\s*\(') {
                    $achouAbrirBusca = $j
                    break
                }
                # Aceita linhas de clear-field entre MsgAviso e AbrirBusca
                if ($Linhas[$j] -match '(?i)^\s*[\w.\[\]]+\.Value\s*=\s*(""|SPACE\()') {
                    continue
                }
                # Aceita linhas em branco
                if ($Linhas[$j].Trim() -eq "") {
                    continue
                }
                # Qualquer outra coisa nao qualifica (nao eh o anti-padrao)
                break
            }

            if ($achouAbrirBusca -gt 0) {
                # Registra correcao
                $multiLinha = if ($idxMsgAvisoEnd -gt $i) { " (multi-linha $($idxMsgAvisoEnd - $i + 1)L)" } else { "" }
                Add-Correcao -Tipo "MSGAVISO-ANTES-PICKER" -Linha ($i + 1) `
                    -Original $linha.Trim() `
                    -Corrigido "(MsgAviso$multiLinha + clear-field removidos)" `
                    -Descricao "MsgAviso redundante antes de THIS.AbrirBusca handler - Pattern #114 v2 (suporte multi-linha via continuation `;`)"

                # Detectar indent da linha MsgAviso para adicionar comentario
                $indent = ""
                if ($linha -match '^(\s+)') { $indent = $Matches[1] }
                [void]$resultado.Add("${indent}*-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix")

                # Pula MsgAviso (todas as linhas do statement multi-linha) e clear-field ate chegar no AbrirBusca (mantido)
                $i = $achouAbrirBusca
                continue
            }
        }

        [void]$resultado.Add($linha)
        $i++
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #113: REPORT cmg_4c_Botoes com Buttons(N).Left + Width transbordando CommandGroup.Width
# Formsigrepes-like: CommandGroup Width=273, Buttons Width=65, Lefts=5/80/155/230 (inc 75)
# ends em 295 > 273 -> Encerrar renderiza cortado. Fix: recalcular Lefts com gap=2 -> 5/72/139/206.
# Bug: Formsigrepes.prg (2026-07-02, Erro19).
#------------------------------------------------------------------------------
function Corrigir-CmgReportButtonsOverflow {
    param([string[]]$Linhas)

    # Detectar bloco AddObject("cmg_4c_Botoes", "CommandGroup") + coletar Width
    $cmgWidth = -1
    $cmgFound = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if (-not $cmgFound -and $linha -match '(?i)AddObject\s*\(\s*"cmg_4c_Botoes"') {
            $cmgFound = $true
            continue
        }
        if ($cmgFound -and $linha -match '(?i)^\s*\.Width\s*=\s*(\d+)') {
            $cmgWidth = [int]$Matches[1]
            break
        }
        if ($cmgFound -and $linha -match '(?i)^\s*ENDWITH\s*$') {
            break  # saiu do WITH do CommandGroup sem achar Width
        }
    }
    if ($cmgWidth -lt 0) { return $Linhas }

    # Coletar Left/Width de Buttons(1..4) — mapa: buttonIdx -> @{LeftLinha=idx, LeftVal=n, WidthLinha=idx, WidthVal=n}
    $buttons = @{}
    $currentBtn = 0
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)WITH\s+.+cmg_4c_Botoes\.Buttons\(\s*(\d+)\s*\)') {
            $currentBtn = [int]$Matches[1]
            if (-not $buttons.ContainsKey($currentBtn)) {
                $buttons[$currentBtn] = @{ LeftLinha = -1; LeftVal = -1; WidthLinha = -1; WidthVal = -1 }
            }
            continue
        }
        if ($currentBtn -gt 0) {
            if ($linha -match '(?i)^\s*\.Left\s*=\s*(\d+)') {
                $buttons[$currentBtn].LeftLinha = $i
                $buttons[$currentBtn].LeftVal = [int]$Matches[1]
            } elseif ($linha -match '(?i)^\s*\.Width\s*=\s*(\d+)') {
                $buttons[$currentBtn].WidthLinha = $i
                $buttons[$currentBtn].WidthVal = [int]$Matches[1]
            } elseif ($linha -match '(?i)^\s*ENDWITH\s*$') {
                $currentBtn = 0
            }
        }
    }

    # Verificar se algum Button transborda
    $maxEnd = 0
    $btnWidthCanon = -1
    foreach ($idx in @(1, 2, 3, 4)) {
        if (-not $buttons.ContainsKey($idx)) { return $Linhas }
        $b = $buttons[$idx]
        if ($b.LeftLinha -lt 0 -or $b.WidthLinha -lt 0) { return $Linhas }
        $endX = $b.LeftVal + $b.WidthVal
        if ($endX -gt $maxEnd) { $maxEnd = $endX }
        if ($btnWidthCanon -lt 0) { $btnWidthCanon = $b.WidthVal }
    }
    if ($maxEnd -le $cmgWidth) { return $Linhas }   # nao transborda -> nada a fazer

    # Recalcular Lefts: usar Buttons(1).Width como canonic
    $btnW = $buttons[1].WidthVal
    $totalBtn = 4 * $btnW
    $freeSpace = $cmgWidth - $totalBtn - 5  # 5 = margem esquerda
    if ($freeSpace -lt 3) { return $Linhas }   # nao ha como caber
    $gap = [Math]::Floor($freeSpace / 3)
    if ($gap -lt 1) { $gap = 1 }

    $novosLefts = @{
        1 = 5
        2 = 5 + $btnW + $gap
        3 = 5 + 2 * ($btnW + $gap)
        4 = 5 + 3 * ($btnW + $gap)
    }

    # Aplicar substituicoes
    $resultado = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linhaCorrigida = $Linhas[$i]
        foreach ($idx in @(1, 2, 3, 4)) {
            if ($buttons[$idx].LeftLinha -eq $i) {
                $original = $linhaCorrigida
                $linhaCorrigida = $linhaCorrigida -replace '(?i)(\.Left\s*=\s*)\d+', "`${1}$($novosLefts[$idx])"
                Add-Correcao -Tipo "CMG-REPORT-BTN-OVERFLOW" -Linha ($i + 1) `
                    -Original $original.Trim() `
                    -Corrigido $linhaCorrigida.Trim() `
                    -Descricao "cmg_4c_Botoes.Buttons($idx).Left transbordava CommandGroup.Width=$cmgWidth - Pattern #113 recalculou Left=$($novosLefts[$idx]) (gap $gap)"
            }
        }
        [void]$resultado.Add($linhaCorrigida)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Aspas duplicadas com EscaparSQL/FormatarDataSQL
# EscaparSQL() retorna 'valor' (com aspas), FormatarDataSQL() retorna 'YYYY-MM-DD'
# Detecta padroes como: campo = '" + EscaparSQL(x) + "'" que geram ''valor''
#------------------------------------------------------------------------------
function Corrigir-AspasDuplicadasSQL {
    <#
    .SYNOPSIS
    Remove aspas duplicadas ao redor de EscaparSQL()/FormatarDataSQL()

    .DESCRIPTION
    Estas funcoes JA retornam o valor com aspas simples ('valor').
    Quando o codigo adiciona aspas extras, gera SQL invalido: ''valor''

    EXEMPLO (problema):
        "WHERE campo = '" + EscaparSQL(val) + "'"    gera: campo = ''valor''
    EXEMPLO (corrigido):
        "WHERE campo = " + EscaparSQL(val)            gera: campo = 'valor'

    Estrategia: substituir  '" + EscaparSQL(  por  " + EscaparSQL(
                e           ) + "'"           por  )
    #>
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]@()

    # Strings de busca/substituicao pre-construidas (evita problemas de escape)
    $dq = [char]34   # aspas dupla "
    $sq = [char]39   # aspas simples '

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Detecta se a linha contem EscaparSQL ou FormatarDataSQL
        if ($linha -match "(EscaparSQL|FormatarDataSQL)\s*\(") {

            foreach ($func in @("EscaparSQL", "FormatarDataSQL")) {
                # Passo 1: Remove aspa simples ANTES do " + Func(
                # Busca:   '" + Func(    ou    ' " + Func(
                # Troca por:  " + Func(
                $busca1  = "${sq}${dq} + ${func}("
                $troca1  = "${dq} + ${func}("
                $linha = $linha.Replace($busca1, $troca1)

                # Passo 2: Para cada Func(xxx), encontrar o ) e remover  + "'" depois
                $pos = 0
                while (($idx = $linha.IndexOf("${func}(", $pos)) -ge 0) {
                    # Encontra o ) correspondente
                    $parenCount = 0
                    $j = $idx + $func.Length
                    while ($j -lt $linha.Length) {
                        if ($linha[$j] -eq [char]40) { $parenCount++ }      # (
                        elseif ($linha[$j] -eq [char]41) {                   # )
                            $parenCount--
                            if ($parenCount -eq 0) { break }
                        }
                        $j++
                    }
                    # $j aponta para o ) de fechamento
                    if ($j -lt $linha.Length) {
                        $resto = $linha.Substring($j + 1)
                        $restoTrim = $resto.TrimStart()
                        # Caso A: termina com  + "'"  (string so com aspa simples)
                        # Em VFP:  + "'"  eh  operador + string_contendo_aspa_simples
                        $sufixoFinal = "+ ${dq}${sq}${dq}"
                        # Caso B: continua com  + "' AND "  ou  + "' xxx "  (aspa simples no inicio de string)
                        $sufixoCont = "+ ${dq}${sq}"
                        if ($restoTrim.StartsWith($sufixoFinal) -and ($restoTrim.Length -eq $sufixoFinal.Length -or [char]::IsWhiteSpace($restoTrim[$sufixoFinal.Length]) -or $restoTrim[$sufixoFinal.Length] -eq [char]13 -or $restoTrim[$sufixoFinal.Length] -eq [char]10)) {
                            # Remove  + "'"  inteiro (final de expressao)
                            $linha = $linha.Substring(0, $j + 1) + $restoTrim.Substring($sufixoFinal.Length)
                        }
                        elseif ($restoTrim.StartsWith($sufixoCont)) {
                            # Remove  + "'  e substitui por  + "  (aspa simples dentro de string com conteudo)
                            $sufixoNovo = "+ ${dq}"
                            $linha = $linha.Substring(0, $j + 1) + " " + $sufixoNovo + $restoTrim.Substring($sufixoCont.Length)
                        }
                    }
                    $pos = $j + 1
                    if ($pos -ge $linha.Length) { break }
                }
            }
        }

        if ($linha -ne $original) {
            Add-Correcao -Tipo "ASPAS_DUPLICADAS_SQL" -Linha ($i + 1) -Original $original.Trim() -Corrigido $linha.Trim() -Descricao "EscaparSQL/FormatarDataSQL JA incluem aspas - aspas extras removidas"
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #32: Self-assignment de objetos (THIS.obj = THIS.obj) causa erro VFP9
#------------------------------------------------------------------------------

function Corrigir-SelfAssignmentObjeto {
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]::new()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Detectar: THIS.xxx = THIS.xxx (self-assignment)
        if ($linha -match "^\s*THIS\.(\w+)\s*=\s*THIS\.\1\s*$") {
            $propName = $Matches[1]
            # Comentar a linha (remover)
            $linha = "			*-- REMOVIDO (self-assignment causa erro VFP9): $($original.Trim())"
            Add-Correcao -Tipo "SELF_ASSIGNMENT_OBJETO" -Linha ($i + 1) -Original $original.Trim() -Corrigido "(removido)" -Descricao "Self-assignment THIS.$propName = THIS.$propName causa 'is a method, event, or object'"
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #33: Variáveis legadas do Framework (_EMPR, _EMPRESA, pEmp)
# Substitui por go_4c_Sistema.cCodEmpresa
#------------------------------------------------------------------------------

function Corrigir-VariaveisLegadasFramework {
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]::new()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Pula comentarios
        if ($linha -match "^\s*\*") {
            [void]$resultado.Add($linha)
            continue
        }

        # Substitui _Empr (case insensitive) por go_4c_Sistema.cCodEmpresa
        # Mas NAO dentro de strings [...] ou "..." e NAO em TYPE("_EMPR")
        if ($linha -match "(?i)\b_Empr\b" -and $linha -notmatch "(?i)TYPE\s*\(\s*[`"']_EMPR") {
            # Substituir apenas fora de strings SQL [...] - detectar contexto
            # Pattern: ALLTRIM(_Empr) ou + _Empr + ou = _Empr
            $linha = $linha -replace "(?i)\bALLTRIM\s*\(\s*_Empr\s*\)", "ALLTRIM(go_4c_Sistema.cCodEmpresa)"
            $linha = $linha -replace "(?i)(?<![`"'\[])\b_Empr\b(?![`"'\]])", "go_4c_Sistema.cCodEmpresa"
        }

        if ($linha -ne $original) {
            Add-Correcao -Tipo "VARIAVEL_LEGADA_FRAMEWORK" -Linha ($i + 1) -Original $original.Trim() -Corrigido $linha.Trim() -Descricao "_EMPR substituido por go_4c_Sistema.cCodEmpresa"
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #34: ISEMPTY() nao existe em VFP9 - substituir por EMPTY()
# VFP tenta resolver como DO isempty.prg e gera erro
#------------------------------------------------------------------------------

function Corrigir-IsEmptyParaEmpty {
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]::new()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Pula comentarios
        if ($linha -match "^\s*\*") {
            [void]$resultado.Add($linha)
            continue
        }

        # Substitui ISEMPTY( por EMPTY( (case insensitive)
        if ($linha -match "(?i)\bISEMPTY\s*\(") {
            $linha = $linha -replace "(?i)\bISEMPTY\s*\(", "EMPTY("
        }

        if ($linha -ne $original) {
            Add-Correcao -Tipo "ISEMPTY_NAO_EXISTE" -Linha ($i + 1) -Original $original.Trim() -Corrigido $linha.Trim() -Descricao "ISEMPTY() substituido por EMPTY() (ISEMPTY nao existe em VFP9)"
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #35: this_cMensagemErro ausente em Form que herda de FormBase
# FormBase NAO tem this_cMensagemErro (so BusinessBase tem).
# Se o Form usa THIS.this_cMensagemErro, deve declarar a propriedade.
#------------------------------------------------------------------------------
function Fix-MensagemErroAusente {
    param([string[]]$linhas)
    $resultado = [System.Collections.Generic.List[string]]::new($linhas.Length)
    $resultado.AddRange($linhas)

    # Verificar se eh Form (herda de FormBase)
    $herdaFormBase = $false
    $temPropriedade = $false
    $usaPropriedade = $false
    $linhaClassDef = -1

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -imatch "^\s*DEFINE\s+CLASS\s+\w+\s+AS\s+FormBase") {
            $herdaFormBase = $true
            $linhaClassDef = $i
        }
        if ($linhas[$i] -imatch "^\s*this_cMensagemErro\s*=") {
            $temPropriedade = $true
        }
        if ($linhas[$i] -imatch "THIS\.this_cMensagemErro") {
            $usaPropriedade = $true
        }
    }

    if ($herdaFormBase -and $usaPropriedade -and !$temPropriedade -and $linhaClassDef -ge 0) {
        # Encontrar primeira linha de propriedade apos DEFINE CLASS
        $insertAt = $linhaClassDef + 1
        for ($j = $linhaClassDef + 1; $j -lt $linhas.Count; $j++) {
            if ($linhas[$j] -imatch "^\s*this_\w+\s*=" -or $linhas[$j] -imatch "^\s*\w+\s*=\s*") {
                $insertAt = $j
                break
            }
        }
        $resultado.Insert($insertAt, "    this_cMensagemErro = """"")
        Add-Correcao -Tipo "MENSAGEMERRO_AUSENTE" -Linha ($insertAt + 1) -Original "(ausente)" -Corrigido 'this_cMensagemErro = ""' -Descricao "Propriedade this_cMensagemErro adicionada (NAO herdada de FormBase, necessaria para CATCH blocks)"
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #36: REPORT FORM TO FILE com expressao inline
# VFP9 nao aceita expressoes inline nem name expression (var) em TO FILE
# Deve usar macro expansion &var
#------------------------------------------------------------------------------
function Fix-ReportFormToFile {
    param([string[]]$linhas)
    $resultado = [System.Collections.Generic.List[string]]::new($linhas.Length)

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $linha = $linhas[$i]
        $original = $linha

        # Detecta: REPORT FORM xxx TO FILE <expressao_complexa> TYPE
        # Onde expressao_complexa contem + ou ( ou funcoes
        if ($linha -imatch "REPORT\s+FORM\s+\w+\s+TO\s+FILE\s+(.+?)\s+TYPE" -and $Matches[1] -match "[\+\(]") {
            $expr = $Matches[1].Trim()
            # Se ja eh macro &var, ignorar
            if ($expr -notmatch "^&") {
                $varName = "loc_cArqReport"
                # Inserir LOCAL + atribuicao antes da linha
                $indent = if ($linha -match "^(\s+)") { $Matches[1] } else { "        " }
                $resultado.Add("${indent}LOCAL $varName")
                $resultado.Add("${indent}$varName = $expr")
                $linha = $linha -replace [regex]::Escape($expr), "&$varName"
                Add-Correcao -Tipo "REPORT_FORM_INLINE" -Linha ($i + 1) -Original $original.Trim() -Corrigido $linha.Trim() -Descricao "REPORT FORM TO FILE: expressao inline convertida para macro &var"
            }
        }

        [void]$resultado.Add($linha)
    }

    return $resultado.ToArray()
}

#------------------------------------------------------------------------------
# Pattern #37/#38: Propriedades VFP9 inexistentes em controles
#------------------------------------------------------------------------------
function Corrigir-PropriedadesInexistentesControles {
    <#
    .SYNOPSIS
    Remove propriedades que NAO existem em controles VFP9 especificos

    .DESCRIPTION
    Propriedades que Claude gera incorretamente:
    - ComboBox.NumberOfElements (nao existe em VFP9)
    - Grid.Panel (nao existe em VFP9)
    - Grid.SplitBar (nao existe em VFP9)
    - ComboBox.Sorted (nao existe em VFP9 ComboBox via AddObject)
    - PageFrame.FontName (nao existe em PageFrame VFP9 - definir nas Pages)
    - PageFrame.FontSize (nao existe em PageFrame VFP9 - definir nas Pages)
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $propriedadesInvalidas = @(
        'NumberOfElements',
        '\.Panel\s*=',
        '\.SplitBar\s*=',
        'pgf_\w+\.FontName\s*=',
        'pgf_\w+\.FontSize\s*='
    )

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $remover = $false

        foreach ($prop in $propriedadesInvalidas) {
            if ($linha -match "\.$prop") {
                $propName = if ($prop -match '(\w+)') { $Matches[1] } else { $prop }
                Add-Correcao -Tipo "PROPRIEDADE_INEXISTENTE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "Propriedade $propName nao existe em VFP9"
                $remover = $true
                break
            }
        }

        if (-not $remover) {
            $resultado += $linha
        }
    }

    return $resultado
}

#------------------------------------------------------------------------------
# Pattern 39: MESSAGEBOX direto -> funcoes messages.prg
#------------------------------------------------------------------------------
function Corrigir-BindEventValidParaLostFocus {
    <#
    .SYNOPSIS
    Substitui BINDEVENT com "Valid" por "LostFocus" em TextBox/ComboBox

    .DESCRIPTION
    BINDEVENT com evento "Valid" nao dispara de forma confiavel em TextBox/ComboBox.
    Usar "LostFocus" ao inves.
    #>
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '^\s*\*') { continue }
        if ($linha -match '(?i)BINDEVENT\(.+?(txt_|cbo_|cmb_).+?,\s*"Valid"\s*,') {
            $novaLinha = $linha -replace '"Valid"', '"LostFocus"'
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "BINDEVENT_VALID_TO_LOSTFOCUS" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao 'BINDEVENT "Valid" -> "LostFocus" (Valid nao dispara em TextBox)'
                $Linhas[$i] = $novaLinha
            }
        }
    }

    return $Linhas
}

function Corrigir-MessageBoxDireto {
    <#
    .SYNOPSIS
    Substitui MESSAGEBOX() direto por funcoes de messages.prg (MsgInfo/MsgAviso/MsgErro)

    .DESCRIPTION
    MESSAGEBOX direto bloqueia o pipeline de testes automatizados.
    Substituir por MsgInfo (icone 64), MsgAviso (icone 48), MsgErro (icone 16).
    NAO substitui MESSAGEBOX com retorno atribuido (ex: loc_nResp = MESSAGEBOX(...))
    NAO substitui MESSAGEBOX com icone 4/36 (confirmacao Sim/Nao) pois MsgConfirma retorna .T./.F.
    #>
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Ignorar linhas comentadas
        if ($linha -match '^\s*\*') { continue }
        if ($linha -match '^\s*&&') { continue }

        # Ignorar MESSAGEBOX com retorno atribuido (ex: loc_nResp = MESSAGEBOX)
        if ($linha -match '=\s*MESSAGEBOX\(') { continue }

        # Ignorar MESSAGEBOX com confirmacao (icone 4, 36, 4+32, etc)
        if ($linha -match 'MESSAGEBOX\(.+?,\s*(4|36|4\s*\+)') { continue }

        # Substituir MESSAGEBOX informativo (icone 64)
        if ($linha -match '(?i)^\s*MESSAGEBOX\((.+?),\s*64\s*,\s*""\s*\)\s*$') {
            $msg = $Matches[1]
            $novaLinha = $linha -replace '(?i)MESSAGEBOX\(.+?,\s*64\s*,\s*""\s*\)', "MsgInfo($msg)"
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "MESSAGEBOX_TO_MSG" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "MESSAGEBOX(msg,64) -> MsgInfo(msg)"
                $Linhas[$i] = $novaLinha
            }
        }
        # Substituir MESSAGEBOX aviso (icone 48)
        elseif ($linha -match '(?i)^\s*MESSAGEBOX\((.+?),\s*48\s*,\s*""\s*\)\s*$') {
            $msg = $Matches[1]
            $novaLinha = $linha -replace '(?i)MESSAGEBOX\(.+?,\s*48\s*,\s*""\s*\)', "MsgAviso($msg)"
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "MESSAGEBOX_TO_MSG" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "MESSAGEBOX(msg,48) -> MsgAviso(msg)"
                $Linhas[$i] = $novaLinha
            }
        }
        # Substituir MESSAGEBOX erro (icone 16) com titulo vazio
        elseif ($linha -match '(?i)^\s*MESSAGEBOX\((.+?),\s*16\s*,\s*""\s*\)\s*$') {
            $msg = $Matches[1]
            $novaLinha = $linha -replace '(?i)MESSAGEBOX\(.+?,\s*16\s*,\s*""\s*\)', "MsgErro($msg)"
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "MESSAGEBOX_TO_MSG" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "MESSAGEBOX(msg,16) -> MsgErro(msg)"
                $Linhas[$i] = $novaLinha
            }
        }
        # Substituir MESSAGEBOX erro (icone 16) com titulo "Erro"
        elseif ($linha -match '(?i)^\s*MESSAGEBOX\((.+?),\s*16\s*,\s*"Erro"\s*\)\s*$') {
            $msg = $Matches[1]
            $novaLinha = $linha -replace '(?i)MESSAGEBOX\(.+?,\s*16\s*,\s*"Erro"\s*\)', "MsgErro($msg)"
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "MESSAGEBOX_TO_MSG" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "MESSAGEBOX(msg,16,'Erro') -> MsgErro(msg)"
                $Linhas[$i] = $novaLinha
            }
        }
        # Substituir MESSAGEBOX aviso (icone 48+32)
        elseif ($linha -match '(?i)^\s*MESSAGEBOX\((.+?),\s*48\s*\+\s*32\s*,\s*""\s*\)\s*$') {
            $msg = $Matches[1]
            $novaLinha = $linha -replace '(?i)MESSAGEBOX\(.+?,\s*48\s*\+\s*32\s*,\s*""\s*\)', "MsgAviso($msg)"
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "MESSAGEBOX_TO_MSG" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "MESSAGEBOX(msg,48+32) -> MsgAviso(msg)"
                $Linhas[$i] = $novaLinha
            }
        }
    }

    return $Linhas
}

#------------------------------------------------------------------------------
# Pattern: Check1.ControlSource em Grid Column (Error 1767)
# Remove linhas Check1.ControlSource que conflitam com Column.ControlSource
#------------------------------------------------------------------------------
function Corrigir-Check1ControlSource {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Remove Check1.ControlSource (conflita com Column.ControlSource)
        if ($linha -match '^\s*\S*\.Check1\.ControlSource\s*=') {
            Add-Correcao -Tipo "CHECK1_CONTROLSOURCE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "Check1.ControlSource conflita com Column.ControlSource (Error 1767)"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #40 - AddObject com objeto ao inves de strings (sintaxe invertida)
# Detecta: parent.AddObject(loc_oXxx, "nome") -> parent.AddObject("nome", "Classe")
# NOTA: Correcao complexa - apenas DETECTA e reporta, nao corrige automaticamente
#------------------------------------------------------------------------------
function Corrigir-AddObjectInvertido {
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta AddObject(loc_oXxx, "nome") - objeto como 1o parametro
        if ($linha -match '\.AddObject\s*\(\s*loc_o\w+\s*,\s*"') {
            Add-Correcao -Tipo "ADDOBJECT_INVERTIDO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(MANUAL: trocar para AddObject('nome', 'Classe'))" -Descricao "AddObject recebe (cNome, cClasse) strings, NAO objeto. Causa 'Function argument invalid'"
        }
    }

    return $Linhas
}

#------------------------------------------------------------------------------
# #41 - Grid Column CurrentControl="Check1" sem AddObject previo
# Detecta .CurrentControl = "Check1" sem .AddObject("Check1"...) antes
# Corrige adicionando AddObject + Caption antes do CurrentControl
#------------------------------------------------------------------------------
function Corrigir-GridCheck1SemAddObject {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta .ColumnN.CurrentControl = "Check1" (ou .CurrentControl = "Check1" dentro de WITH)
        if ($linha -match '\.CurrentControl\s*=\s*"Check1"') {
            # Verificar se as 30 linhas anteriores ja tem AddObject("Check1")
            # Lookback ampliado para detectar AddObject dentro de WITH blocks
            $jaTemAddObject = $false
            $lookback = [Math]::Min(30, $i)
            for ($j = $i - $lookback; $j -lt $i; $j++) {
                if ($j -ge 0 -and $Linhas[$j] -match 'AddObject\s*\(\s*[''"]Check1[''"]') {
                    $jaTemAddObject = $true
                    break
                }
            }

            if (-not $jaTemAddObject) {
                # Extrair o prefixo de indentacao e o path do Column
                $indent = ""
                if ($linha -match '^(\s+)') { $indent = $matches[1] }

                # Extrair path do Column (ex: .Column1 ou loc_oP1.grd_4c_X.Column1)
                $colPath = ""
                if ($linha -match '(\S+\.Column\d+)\.CurrentControl') {
                    $colPath = $matches[1]
                } elseif ($linha -match '^\s+\.CurrentControl') {
                    # Dentro de WITH - usar .Column1 baseado no contexto
                    # Buscar para tras pelo WITH mais proximo
                    for ($j = $i - 1; $j -ge [Math]::Max(0, $i - 20); $j--) {
                        if ($Linhas[$j] -match '\.Column(\d+)\.' -or $Linhas[$j] -match 'Column(\d+)\.Sparse') {
                            $colPath = ".Column$($matches[1])"
                            break
                        }
                    }
                }

                if ($colPath) {
                    $resultado += "${indent}${colPath}.AddObject(`"Check1`", `"CheckBox`")"
                    $resultado += "${indent}${colPath}.Check1.Caption = `"`""
                } else {
                    # Fallback: adicionar com .Column1 generico
                    $resultado += "${indent}.AddObject(`"Check1`", `"CheckBox`")"
                    $resultado += "${indent}.Check1.Caption = `"`""
                }

                Add-Correcao -Tipo "GRID_CHECK1_SEM_ADDOBJECT" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "Adicionado AddObject('Check1','CheckBox') + Check1.Caption antes" -Descricao "CurrentControl='Check1' requer AddObject previo (Unknown member CHECK1 cascateia)"
            }
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #50 - PageFrame Visible ausente (objetos AddObject iniciam Visible=.F.)
# Detecta pgf_4c_Paginas.ActivePage = 1 sem pgf_4c_Paginas.Visible = .T. antes
# Adiciona .Visible = .T. antes do ActivePage
#------------------------------------------------------------------------------
function Corrigir-PageFrameVisibleAusente {
    param([string[]]$Linhas)

    $resultado = @()
    $temPageFrame = ($Linhas -join "`n") -match 'pgf_4c_Paginas'
    $temVisible = ($Linhas -join "`n") -match 'pgf_4c_Paginas\.Visible\s*=\s*\.T\.'

    if ($temPageFrame -and -not $temVisible) {
        for ($i = 0; $i -lt $Linhas.Count; $i++) {
            $linha = $Linhas[$i]
            if ($linha -match '^\s*(THIS\.)?pgf_4c_Paginas\.ActivePage\s*=\s*1') {
                $indent = ""
                if ($linha -match '^(\s+)') { $indent = $matches[1] }
                $resultado += "${indent}THIS.pgf_4c_Paginas.Visible = .T."
                Add-Correcao -Tipo "PAGEFRAME_VISIBLE_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido "pgf_4c_Paginas.Visible = .T." -Descricao "AddObject cria controles com Visible=.F. - PageFrame precisa ser tornado visivel"
            }
            $resultado += $linha
        }
    } else {
        $resultado = $Linhas
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #49 - Page.Visible (Page NAO tem propriedade Visible em VFP9)
# Detecta .PageN.Visible = .T./.F. e remove a linha
# Pages sao controladas pelo PageFrame via ActivePage, nao tem Visible
#------------------------------------------------------------------------------
function Corrigir-PageVisible {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '\.Page\d+\.Visible\s*=') {
            Add-Correcao -Tipo "PAGE_VISIBLE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(linha removida)" -Descricao "Page NAO tem propriedade Visible em VFP9 - causa 'Property VISIBLE is not found'"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #45 - IF cond THEN cmd (inline IF com THEN)
# VFP9 NAO suporta THEN keyword em IF. Gera "Command contains unrecognized phrase/keyword."
# Fix: expandir para multi-linha IF / ENDIF
#------------------------------------------------------------------------------
function Corrigir-InlineIfThen {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta: IF <cond> THEN <cmd>  (THEN seguido de algo na mesma linha, fora de comentarios)
        # Nao processar linhas que sao comentarios (*  ou &&)
        $linhaT = $linha.TrimStart()
        if ($linhaT -notmatch '^[*&]' -and $linha -match '^(\s*)IF\s+(.+?)\s+THEN\s+(.+)$') {
            $indent = $Matches[1]
            $cond   = $Matches[2].Trim()
            $cmd    = $Matches[3].Trim()

            $resultado += "${indent}IF ${cond}"
            $resultado += "${indent}    ${cmd}"
            $resultado += "${indent}ENDIF"

            Add-Correcao -Tipo "INLINE_IF_THEN" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "IF ${cond} / ${cmd} / ENDIF" -Descricao "VFP9 nao suporta THEN em IF - expandido para multi-linha"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #46 - COUNT TO var IN alias
# VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword."
# Fix: SELECT alias + COUNT TO var
#------------------------------------------------------------------------------
function Corrigir-CountToIn {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta: COUNT TO var IN alias  (com ou sem condicao FOR)
        if ($linha -match '^(\s*)COUNT\s+TO\s+(\w+)\s+IN\s+(\S+)(.*)$') {
            $indent    = $Matches[1]
            $var       = $Matches[2]
            $alias     = $Matches[3]
            $resto     = $Matches[4].Trim()   # pode ser FOR condicao ou vazio

            $resultado += "${indent}SELECT ${alias}"
            if ($resto) {
                $resultado += "${indent}COUNT TO ${var} ${resto}"
            } else {
                $resultado += "${indent}COUNT TO ${var}"
            }

            Add-Correcao -Tipo "COUNT_TO_IN" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "SELECT ${alias} + COUNT TO ${var}" -Descricao "VFP9 COUNT nao tem clausula IN - convertido para SELECT + COUNT TO"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# #47 - CheckBox .Value com tipo logico (.T./.F.) ao inves de numerico (0/1)
# CheckBox.Value DEVE ser NUMERICO para evitar type mismatch em comparacoes
# Fix: chk_4c_*.Value = .T. -> 1, chk_4c_*.Value = .F. -> 0
#------------------------------------------------------------------------------
function Corrigir-CheckBoxValueLogico {
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta chk_4c_*.Value = .T. e troca por 1
        if ($linha -match '(chk_4c_\w+\.Value\s*=\s*)\.T\.') {
            $linhaCorrigida = $linha -replace '(chk_4c_\w+\.Value\s*=\s*)\.T\.', '${1}1'
            Add-Correcao -Tipo "CHECKBOX_VALUE_LOGICO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $linhaCorrigida.Trim() -Descricao "CheckBox.Value deve ser numerico, .T. trocado por 1"
            $resultado += $linhaCorrigida
            continue
        }

        # Detecta chk_4c_*.Value = .F. e troca por 0
        if ($linha -match '(chk_4c_\w+\.Value\s*=\s*)\.F\.') {
            $linhaCorrigida = $linha -replace '(chk_4c_\w+\.Value\s*=\s*)\.F\.', '${1}0'
            Add-Correcao -Tipo "CHECKBOX_VALUE_LOGICO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $linhaCorrigida.Trim() -Descricao "CheckBox.Value deve ser numerico, .F. trocado por 0"
            $resultado += $linhaCorrigida
            continue
        }

        # Detecta .Value = .T. dentro de WITH block para CheckBox (sem prefixo chk_4c_)
        # Apenas se a linha anterior ou contexto sugere CheckBox
        # Nao implementado - risco de falso positivo

        $resultado += $linha
    }

    return $resultado
}

#------------------------------------------------------------------------------
# Função principal
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# #48 - CREATEOBJECT("XxxBO") verifica se DEFINE CLASS existe no arquivo .prg
# Se o nome usado no CREATEOBJECT nao corresponde ao DEFINE CLASS real,
# corrige automaticamente (ex: carBO -> CargoBO)
#------------------------------------------------------------------------------
# =============================================================================
# #51 FormatarGridLista ausente - metodo chamado mas nao definido
# =============================================================================
function Corrigir-FormatarGridListaAusente {
    param([string[]]$Linhas)

    $conteudo = $Linhas -join "`n"
    # Se chama FormatarGridLista mas nao define o PROCEDURE
    $chamado = $conteudo -match '(?i)THIS\.FormatarGridLista\s*\('
    $definido = $conteudo -match '(?i)PROCEDURE\s+FormatarGridLista\b'

    if ($chamado -and -not $definido) {
        # Inserir o metodo padrao antes de ENDDEFINE
        $resultado = @()
        $inserido = $false
        for ($i = 0; $i -lt $Linhas.Count; $i++) {
            if (-not $inserido -and $Linhas[$i] -match '^\s*ENDDEFINE\s*$') {
                $resultado += ""
                $resultado += "    *--------------------------------------------------------------------------"
                $resultado += "    * FormatarGridLista - Formata visual do grid da lista"
                $resultado += "    *--------------------------------------------------------------------------"
                $resultado += "    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)"
                $resultado += "        WITH par_oGrid"
                $resultado += "            IF .ColumnCount > 0"
                $resultado += '                .FontName = "Tahoma"'
                $resultado += "                .FontSize = 8"
                $resultado += "            ENDIF"
                $resultado += "        ENDWITH"
                $resultado += "    ENDPROC"
                $resultado += ""
                $inserido = $true
                Add-Correcao -Tipo "FORMATAR_GRID_LISTA_AUSENTE" -Linha ($i + 1) -Original "(metodo ausente)" -Corrigido "PROCEDURE FormatarGridLista adicionado" -Descricao "Metodo chamado mas nao definido - padrao Tahoma 8pt"
            }
            $resultado += $Linhas[$i]
        }
        return $resultado
    }
    return $Linhas
}

# =============================================================================
# #52 Property declaration + AddObject mesmo nome = "Object name is invalid"
# =============================================================================
function Corrigir-PropertyAddObjectConflito {
    param([string[]]$Linhas)

    $resultado = @()
    # Coletar nomes de AddObject
    $addObjNames = @()
    foreach ($l in $Linhas) {
        if ($l -match '(?i)THIS\.AddObject\s*\(\s*"(\w+)"') {
            $addObjNames += $Matches[1].ToLower()
        }
    }

    if ($addObjNames.Count -eq 0) { return $Linhas }

    $dentroDefineClass = $false
    $primeiroProc = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*DEFINE\s+CLASS\b') { $dentroDefineClass = $true }
        if ($linha -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\b') { $primeiroProc = $true }

        # Propriedades estao entre DEFINE CLASS e primeiro PROCEDURE
        if ($dentroDefineClass -and -not $primeiroProc) {
            # Detecta: nome_objeto = .NULL. ou nome_objeto = ""
            if ($linha -match '(?i)^\s+(\w+)\s*=\s*(\.NULL\.|""|\.F\.|0)\s*$') {
                $propName = $Matches[1].ToLower()
                if ($addObjNames -contains $propName) {
                    Add-Correcao -Tipo "PROPERTY_ADDOBJECT_CONFLITO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "Propriedade '$propName' conflita com AddObject mesmo nome - 'Object name is invalid'"
                    continue  # Remove a linha
                }
            }
        }
        $resultado += $linha
    }
    return $resultado
}

# =============================================================================
# #53 AddObject com nome duplicado no mesmo container/metodo
# =============================================================================
function Corrigir-AddObjectDuplicado {
    param([string[]]$Linhas)

    $resultado = @()
    $addObjPorMetodo = @{}  # key=metodo, value=hash de parent.name
    $metodoAtual = ""

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Rastrear metodo atual
        if ($linha -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+(\w+)') {
            $metodoAtual = $Matches[2].ToLower()
            $addObjPorMetodo[$metodoAtual] = @{}
        }

        # Detectar AddObject
        if ($metodoAtual -and $linha -match '(?i)(\w+)\.AddObject\s*\(\s*"(\w+)"\s*,\s*"(\w+)"') {
            $parent = $Matches[1].ToLower()
            $objName = $Matches[2].ToLower()
            $objClass = $Matches[3]
            $key = "${parent}.${objName}"

            if (-not $addObjPorMetodo.ContainsKey($metodoAtual)) {
                $addObjPorMetodo[$metodoAtual] = @{}
            }

            if ($addObjPorMetodo[$metodoAtual].ContainsKey($key)) {
                # Nome duplicado! Renomear com sufixo numerico
                $counter = 2
                $newName = "${objName}${counter}"
                while ($addObjPorMetodo[$metodoAtual].ContainsKey("${parent}.${newName}")) {
                    $counter++
                    $newName = "${objName}${counter}"
                }
                $oldObjName = $Matches[2]  # Case original
                $novaLinha = $linha -replace "(?i)AddObject\s*\(\s*`"$oldObjName`"", "AddObject(`"${newName}`""
                Add-Correcao -Tipo "ADDOBJECT_DUPLICADO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $novaLinha.Trim() -Descricao "Nome duplicado '$objName' no mesmo container - renomeado para '$newName'"
                $addObjPorMetodo[$metodoAtual]["${parent}.${newName}"] = $true

                # Tambem renomear referencias subsequentes neste metodo (proximo WITH block)
                $resultado += $novaLinha
                # Renomear no WITH que segue
                $j = $i + 1
                while ($j -lt $Linhas.Count -and $Linhas[$j] -notmatch '(?i)^\s*ENDWITH') {
                    $Linhas[$j] = $Linhas[$j] -replace "(?i)\b$oldObjName\b", $newName
                    $j++
                }
                if ($j -lt $Linhas.Count) {
                    # ENDWITH line - no change needed
                }
                continue
            } else {
                $addObjPorMetodo[$metodoAtual][$key] = $true
            }
        }
        $resultado += $linha
    }
    return $resultado
}

# =============================================================================
# #54 Container AddObject sem .Visible = .T. -> botoes/controles ficam invisiveis
# =============================================================================
function Corrigir-ContainerVisibleAusente {
    param([string[]]$Linhas)

    $resultado = [System.Collections.ArrayList]@()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        [void]$resultado.Add($Linhas[$i])

        # Detectar ENDWITH apos bloco de Container (cnt_4c_*)
        if ($Linhas[$i] -match '^\s*ENDWITH\s*$' -and $i -ge 2) {
            # Verificar se o WITH anterior era para um container cnt_4c_*
            $temVisibleTrue = $false
            $temVisibleFalse = $false
            $ehContainer = $false
            $ehPage = $false
            $containerName = ""
            for ($j = $i - 1; $j -ge [Math]::Max(0, $i - 30); $j--) {
                if ($Linhas[$j] -match '(?i)WITH\s+.*\.(cnt_4c_\w+)\s*$') {
                    $containerName = $Matches[1]
                    $ehContainer = $true
                    break
                }
                # Detectar se eh WITH para Page (Page1, Page2, etc) - Pages NAO tem Visible
                if ($Linhas[$j] -match '(?i)WITH\s+.*\.Page\d+\s*$') {
                    $ehPage = $true
                    break
                }
                if ($Linhas[$j] -match '(?i)\.Visible\s*=\s*\.T\.') {
                    $temVisibleTrue = $true
                }
                if ($Linhas[$j] -match '(?i)\.Visible\s*=\s*\.F\.') {
                    $temVisibleFalse = $true
                }
                if ($Linhas[$j] -match '(?i)WITH\s+') { break }  # Outro WITH
            }
            # Adicionar .Visible = .T. SOMENTE se:
            # 1. Eh container cnt_4c_* (nao Page)
            # 2. NAO tem .Visible = .T. (ja definido)
            # 3. NAO tem .Visible = .F. (container flutuante intencional)
            if ($ehContainer -and -not $ehPage -and -not $temVisibleTrue -and -not $temVisibleFalse) {
                $indentacao = if ($Linhas[$i] -match '^(\s*)') { $Matches[1] + "    " } else { "            " }
                $resultado.RemoveAt($resultado.Count - 1)  # Remove ENDWITH
                [void]$resultado.Add("${indentacao}.Visible     = .T.")
                [void]$resultado.Add($Linhas[$i])  # Re-adiciona ENDWITH
                Add-Correcao -Tipo "CONTAINER_VISIBLE_AUSENTE" -Linha ($i + 1) -Original "(ausente)" -Corrigido ".Visible = .T." -Descricao "Container '$containerName' sem Visible = .T. - controles ficam invisiveis"
            }
        }
    }
    return $resultado
}

# =============================================================================
# #55 LPARAMETERS duplicado apos PROCEDURE com parametros na assinatura
# =============================================================================
function Corrigir-LparametersNoProcedure {
    param([string[]]$Linhas)

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detectar PROCEDURE com parametros na assinatura
        if ($Linhas[$i] -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+\w+\s*\(par_\w+') {
            $resultado += $Linhas[$i]
            # Verificar se proxima linha eh LPARAMETERS
            if ($i + 1 -lt $Linhas.Count -and $Linhas[$i + 1] -match '(?i)^\s*LPARAMETERS\s+') {
                Add-Correcao -Tipo "LPARAMETERS_DUPLICADO" -Linha ($i + 2) -Original $Linhas[$i + 1].Trim() -Corrigido "(removido)" -Descricao "LPARAMETERS duplicado - parametros ja declarados no PROCEDURE. Causa 'Unrecognized command verb'."
                $i++  # Skip a linha LPARAMETERS
            }
        } else {
            $resultado += $Linhas[$i]
        }
    }
    return $resultado
}

function Corrigir-CreateObjectVsDefineClass {
    param([string[]]$Linhas, [string]$TaskDir)

    $classesDir = "C:\4c\projeto\app\classes"
    if (-not (Test-Path $classesDir)) { return $Linhas }

    # Carrega todos os BO files e seus DEFINE CLASS names
    $boMap = @{}
    $boFiles = Get-ChildItem -Path $classesDir -Filter "*BO.prg" -ErrorAction SilentlyContinue
    foreach ($bf in $boFiles) {
        $boContent = Get-Content $bf.FullName -Raw -ErrorAction SilentlyContinue
        if ($boContent -match "(?i)DEFINE\s+CLASS\s+(\w+BO)\s+AS") {
            $boMap[$Matches[1].ToLower()] = @{
                RealName = $Matches[1]
                BaseName = $bf.BaseName
                Prefix = ($Matches[1] -replace '(?i)BO$','').ToLower()
            }
        }
    }
    if ($boMap.Count -eq 0) { return $Linhas }

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '^\s*\*') { continue }

        if ($linha -match 'CREATEOBJECT\s*\(\s*"([^"]+BO)"\s*\)') {
            $boNameUsado = $Matches[1]

            # Se ja existe exatamente, pula
            if ($boMap.ContainsKey($boNameUsado.ToLower())) { continue }

            # Busca BO com prefixo compativel
            $prefUsado = ($boNameUsado -replace '(?i)BO$','').ToLower()
            foreach ($entry in $boMap.Values) {
                if ($entry.Prefix.Contains($prefUsado) -or $prefUsado.Contains($entry.Prefix)) {
                    $Linhas[$i] = $linha -replace [regex]::Escape("CREATEOBJECT(`"$boNameUsado`")"), "CREATEOBJECT(`"$($entry.RealName)`")"
                    Add-Correcao -Tipo "CREATEOBJECT_VS_DEFINECLASS" -Linha ($i + 1) `
                        -Original "CREATEOBJECT(`"$boNameUsado`")" `
                        -Corrigido "CREATEOBJECT(`"$($entry.RealName)`")" `
                        -Descricao "Nome BO corrigido: arquivo tem DEFINE CLASS $($entry.RealName)"
                    break
                }
            }
        }
    }
    return $Linhas
}

# =============================================================================
# #56 Container.Themes = .F. -> Container nao tem Themes em VFP9
# =============================================================================
function Corrigir-ContainerThemes {
    param([string[]]$Linhas)

    $resultado = @()
    $dentroWithContainer = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detectar WITH para Container (cnt_4c_*)
        if ($Linhas[$i] -match '(?i)WITH\s+.*\.(cnt_4c_\w+)\s*$') {
            $dentroWithContainer = $true
        }
        if ($Linhas[$i] -match '(?i)^\s*ENDWITH\s*$') {
            $dentroWithContainer = $false
        }
        # Remover .Themes dentro de WITH para Container
        if ($dentroWithContainer -and $Linhas[$i] -match '(?i)^\s*\.Themes\s*=') {
            Add-Correcao -Tipo "CONTAINER_THEMES" -Linha ($i + 1) -Original $Linhas[$i].Trim() -Corrigido "(removido)" -Descricao "Container nao tem .Themes em VFP9 - propriedade inexistente"
            continue
        }
        $resultado += $Linhas[$i]
    }
    return $resultado
}

# =============================================================================
# #57 MsgConfirma() = 6 -> MsgConfirma retorna logical, nao numerico
# =============================================================================
function Corrigir-MsgConfirmaNumerico {
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detectar IF var = 6 onde var veio de MsgConfirma
        if ($Linhas[$i] -match '(?i)^\s*IF\s+(\w+)\s*=\s*6\s*$') {
            $varName = $Matches[1]
            # Verificar se a variavel foi atribuida de MsgConfirma nas 5 linhas anteriores
            for ($j = [Math]::Max(0, $i - 5); $j -lt $i; $j++) {
                if ($Linhas[$j] -match "(?i)$varName\s*=\s*MsgConfirma\(") {
                    $original = $Linhas[$i]
                    $Linhas[$i] = $Linhas[$i] -replace '(?i)(IF\s+\w+)\s*=\s*6\s*$', '$1'
                    Add-Correcao -Tipo "MSGCONFIRMA_NUMERICO" -Linha ($i + 1) -Original $original.Trim() -Corrigido $Linhas[$i].Trim() -Descricao "MsgConfirma retorna .T./.F., nao numerico 6"
                    break
                }
            }
        }
    }
    return $Linhas
}

function Corrigir-AppendFromSemSelect {
    <#
    .SYNOPSIS
    Detecta ZAP IN cursor seguido de APPEND FROM sem SELECT cursor antes.
    ZAP IN nao muda a work area corrente, entao APPEND FROM vai para o cursor errado.
    Fix: adiciona SELECT cursor_destino antes do APPEND FROM.
    #>
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detecta: ZAP IN cursor_xxx
        if ($Linhas[$i] -match '(?i)^\s*ZAP\s+IN\s+(\w+)\s*$') {
            $cursorDestino = $Matches[1]
            # Verifica as proximas 3 linhas por APPEND FROM sem SELECT antes
            for ($j = $i + 1; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                # Se encontrou SELECT cursor_destino antes, OK
                if ($Linhas[$j] -match "(?i)^\s*SELECT\s+$([regex]::Escape($cursorDestino))\s*$") {
                    break
                }
                # Se encontrou APPEND FROM sem SELECT antes
                if ($Linhas[$j] -match '(?i)^\s*APPEND\s+FROM\s+') {
                    $indent = $Linhas[$j] -replace '^(\s*).*', '$1'
                    $selectLine = "${indent}SELECT $cursorDestino"
                    # Tambem corrigir ZAP IN -> SELECT + ZAP (sem IN)
                    $originalZap = $Linhas[$i]
                    $zapIndent = $Linhas[$i] -replace '^(\s*).*', '$1'
                    $Linhas[$i] = "${zapIndent}SELECT $cursorDestino"
                    # Inserir ZAP na linha seguinte
                    $zapLine = "${zapIndent}ZAP"
                    $novasLinhas = [System.Collections.ArrayList]@($Linhas[0..$i])
                    [void]$novasLinhas.Add($zapLine)
                    if ($i + 1 -lt $Linhas.Count) {
                        $novasLinhas.AddRange($Linhas[($i + 1)..($Linhas.Count - 1)])
                    }
                    $Linhas = $novasLinhas.ToArray()
                    Add-Correcao -Tipo "APPEND_FROM_SEM_SELECT" -Linha ($i + 1) -Original $originalZap.Trim() -Corrigido "SELECT $cursorDestino + ZAP" -Descricao "ZAP IN nao muda work area - SELECT cursor antes de APPEND FROM"
                    break
                }
            }
        }
    }
    return $Linhas
}

function Corrigir-GridRecordMarkDeleteMark {
    <#
    .SYNOPSIS
    Detecta grids criados via AddObject sem RecordMark=.F. e DeleteMark=.F.
    Adiciona as propriedades dentro do bloco WITH do grid.

    SAFETY GUARD (2026-07-02): Grids configurados via helper (ex:
    ConfigurarGrdP1) NAO tem WITH direto apos AddObject. Sem esse guard,
    o pattern encontrava o ENDWITH do CommandButton adjacente (padrao
    classico: cmd_4c_SelXxx logo abaixo do grid) e injetava .RecordMark
    dentro de WITH de CommandButton, causando "Property RECORDMARK is not
    found" em runtime — engolido silenciosamente por CATCH em
    InicializarForm, resultando em "VARTYPE retornou: L" no menu (Erro17
    Formsigrepes.prg 2026-07-02). Agora exige `WITH <gridName>` explicito
    entre o AddObject e o ENDWITH.
    #>
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detecta: AddObject("grd_4c_...", "Grid")
        if ($Linhas[$i] -match '(?i)AddObject\(\s*"(grd_4c_\w+)"\s*,\s*"Grid"\s*\)') {
            $gridName = $Matches[1]
            # Busca o ENDWITH do WITH block deste grid (proximo ENDWITH)
            $temRecordMark = $false
            $temDeleteMark = $false
            $temWithGrid = $false
            $endWithIdx = -1
            for ($j = $i + 1; $j -lt [Math]::Min($i + 30, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match "(?i)^\s*WITH\s+.*\.$([regex]::Escape($gridName))\s*$") {
                    $temWithGrid = $true
                }
                if ($Linhas[$j] -match '(?i)\.RecordMark\s*=') { $temRecordMark = $true }
                if ($Linhas[$j] -match '(?i)\.DeleteMark\s*=') { $temDeleteMark = $true }
                if ($Linhas[$j] -match '(?i)^\s*ENDWITH\s*$') {
                    $endWithIdx = $j
                    break
                }
            }
            # SAFETY GUARD: so injeta se houver WITH explicito do proprio grid
            # (previne injecao em ENDWITH de CommandButton adjacente quando grid
            # eh configurado via helper como ConfigurarGrdP1).
            if ($endWithIdx -gt 0 -and $temWithGrid -and (!$temRecordMark -or !$temDeleteMark)) {
                $indent = $Linhas[$endWithIdx] -replace '^(\s*).*', '$1'
                $propIndent = $indent + "    "
                $novasLinhas = [System.Collections.ArrayList]@()
                for ($k = 0; $k -lt $Linhas.Count; $k++) {
                    if ($k -eq $endWithIdx -and !$temRecordMark) {
                        [void]$novasLinhas.Add("${propIndent}.RecordMark   = .F.")
                        if (!$temDeleteMark) {
                            [void]$novasLinhas.Add("${propIndent}.DeleteMark   = .F.")
                        }
                        Add-Correcao -Tipo "GRID_RECORDMARK_DELETEMARK" -Linha ($k + 1) -Original "(ausente)" -Corrigido ".RecordMark = .F. + .DeleteMark = .F." -Descricao "Grid $gridName sem RecordMark/DeleteMark - barras de marcacao visiveis"
                    }
                    [void]$novasLinhas.Add($Linhas[$k])
                }
                $Linhas = $novasLinhas.ToArray()
            }
        }
    }
    return $Linhas
}

# =============================================================================
# #59/#60 BackStyle em CommandGroup, OptionGroup, CommandButton -> remover
# BackStyle NAO existe nesses controles em VFP9.
# Apenas Label, CheckBox, Shape, Container, Image possuem BackStyle.
# =============================================================================
function Corrigir-BackStyleInexistente {
    <#
    .SYNOPSIS
    Remove .BackStyle de CommandButton (standalone ou .Buttons(N) de CommandGroup).
    CommandButton NAO possui BackStyle em VFP9.
    EXCECOES:
      - CommandGroup TEM BackStyle (descoberto via framework btnReport, 2026-05-15).
        Inicialmente esta funcao tambem removia de CommandGroup, mas isso quebrava
        forms REPORT cujo CommandGroup precisa de BackStyle=0 (transparente sobre
        o fundo do form). Agora preservado.
      - OptionButton (.Buttons(N) de OptionGroup) TEM BackStyle - NUNCA remover.
        Pattern #86 injeta BackStyle=0 em OptionGroup.Buttons(N) se ausente.
    #>
    param([string[]]$Linhas)

    # Fase 1: mapear nomes de CommandGroup vs OptionGroup separadamente
    $commandGroupNames = [System.Collections.Generic.HashSet[string]]@()
    $optionGroupNames = [System.Collections.Generic.HashSet[string]]@()
    $buttonNames = [System.Collections.Generic.HashSet[string]]@()
    for ($k = 0; $k -lt $Linhas.Count; $k++) {
        $lk = $Linhas[$k]
        if ($lk -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"CommandGroup"\s*\)') {
            [void]$commandGroupNames.Add($Matches[1])
        }
        elseif ($lk -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"OptionGroup"\s*\)') {
            [void]$optionGroupNames.Add($Matches[1])
        }
        elseif ($lk -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"CommandButton"\s*\)') {
            [void]$buttonNames.Add($Matches[1])
        }
    }

    $resultado = @()
    $insideCommandGroupWith = $false
    $insideOptionGroupButtonsWith = $false
    $insideCommandButtonWith = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $remover = $false

        # Detecta WITH block que referencia um botao (CommandGroup tem BackStyle - nao tracked)
        if ($linha -match '(?i)^\s*WITH\s+') {
            # CommandButton standalone (WITH ref.cmdbutton)
            foreach ($name in $buttonNames) {
                if ($linha -match "(?i)\.$([regex]::Escape($name))\s*$") {
                    $insideCommandButtonWith = $true
                    break
                }
            }
            # Detecta WITH para .Buttons(N) - identificar se grupo pai e CommandGroup ou OptionGroup
            if ($linha -match '(?i)^\s*WITH\s+([a-zA-Z_][\w\.]*)\.Buttons\s*\(\s*\d+\s*\)\s*$') {
                $refCompleta = $Matches[1]
                $nomeGrupo = ($refCompleta -split '\.')[-1]
                if ($optionGroupNames.Contains($nomeGrupo)) {
                    $insideOptionGroupButtonsWith = $true
                }
                else {
                    # Default: tratar como CommandGroup.Buttons(N) -> CommandButton (sem BackStyle)
                    $insideCommandButtonWith = $true
                }
            }
        }

        # Dentro de WITH, remover .BackStyle APENAS em CommandButton (standalone ou Buttons() de CommandGroup).
        # CommandGroup TEM BackStyle - nao remover.
        # OptionButton (Buttons() de OptionGroup) TEM BackStyle - nao remover.
        if ($insideCommandButtonWith -and (-not $insideOptionGroupButtonsWith) -and $linha -match '(?i)^\s*\.BackStyle\s*=') {
            $remover = $true
            $tipoControle = if ($insideCommandGroupWith) { "CommandGroup" } else { "CommandButton" }
            Add-Correcao -Tipo "BACKSTYLE_INEXISTENTE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "$tipoControle nao tem BackStyle em VFP9 (OptionGroup.Buttons preservado por #86)"
        }

        if ($linha -match '(?i)^\s*ENDWITH\b') {
            $insideCommandGroupWith = $false
            $insideOptionGroupButtonsWith = $false
            $insideCommandButtonWith = $false
        }

        if (-not $remover) {
            $resultado += $linha
        }
    }
    return $resultado
}

# =============================================================================
# #86 OptionGroup.Buttons(N) sem BackStyle=0 -> injetar (task022)
# OptionButton TEM BackStyle. Sem BackStyle=0, fundo opaco clipa captions
# acentuadas ("N"+CHR(227)+"o" aparece como "Na").
# =============================================================================
function Corrigir-OptionGroupButtonsBackStyle {
    param([string[]]$Linhas)

    # Fase 1: identificar nomes de OptionGroups criados via AddObject
    $optionGroups = @{}
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"OptionGroup"\s*\)') {
            $optionGroups[$Matches[1]] = $true
        }
    }
    if ($optionGroups.Count -eq 0) { return $Linhas }

    # Fase 2: processar WITH blocks de <opg>.Buttons(N), injetar .BackStyle = 0 se ausente
    $resultado = New-Object System.Collections.ArrayList
    $dentroButtons = $false
    $linhasBuffer = @()
    $idxInicio = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            if ($dentroButtons) { $linhasBuffer += $linha } else { [void]$resultado.Add($linha) }
            continue
        }

        # Detectar entrada em WITH <ref>.<optionGroupName>.Buttons(N)
        if (-not $dentroButtons) {
            $m = [regex]::Match($linha, '(?i)^\s*WITH\s+([a-zA-Z_][\w\.]*)\.Buttons\s*\(\s*\d+\s*\)\s*$')
            if ($m.Success) {
                $refCompleta = $m.Groups[1].Value
                $nomeGrupo = ($refCompleta -split '\.')[-1]
                if ($optionGroups.ContainsKey($nomeGrupo)) {
                    $dentroButtons = $true
                    $linhasBuffer = @($linha)
                    $idxInicio = $i
                    continue
                }
            }
        }

        if ($dentroButtons) {
            $linhasBuffer += $linha
            if ($linha -match '(?i)^\s*ENDWITH\b') {
                # Verificar se BackStyle ja existe no buffer
                $temBackStyle = $false
                foreach ($lb in $linhasBuffer) {
                    if ($lb -match '(?i)^\s*\.BackStyle\s*=') {
                        $temBackStyle = $true
                        break
                    }
                }

                if (-not $temBackStyle) {
                    # Determinar indentacao dos .props (olhar segunda linha do buffer)
                    $indent = ''
                    if ($linhasBuffer.Count -ge 2 -and $linhasBuffer[1] -match '^(\s*)\.') {
                        $indent = $Matches[1]
                    }
                    # Injetar .BackStyle = 0 apos a linha .Caption (se existir), senao apos a primeira prop
                    $insertIdx = -1
                    for ($j = 0; $j -lt $linhasBuffer.Count; $j++) {
                        if ($linhasBuffer[$j] -match '(?i)^\s*\.Caption\s*=') {
                            $insertIdx = $j + 1
                            break
                        }
                    }
                    if ($insertIdx -lt 0) {
                        # Sem Caption - inserir logo apos WITH (linha 1)
                        $insertIdx = 1
                    }
                    $novaProp = $indent + '.BackStyle = 0'
                    $novoBuffer = @()
                    for ($j = 0; $j -lt $linhasBuffer.Count; $j++) {
                        $novoBuffer += $linhasBuffer[$j]
                        if ($j -eq ($insertIdx - 1)) {
                            $novoBuffer += $novaProp
                        }
                    }
                    $linhasBuffer = $novoBuffer
                    Add-Correcao -Tipo "OPTIONGROUP-BUTTONS-BACKSTYLE" -Linha ($idxInicio+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Injetado .BackStyle = 0 em OptionGroup.Buttons(N) (evita clipping de caption acentuada)"
                }

                foreach ($lb in $linhasBuffer) {
                    [void]$resultado.Add($lb)
                }
                $linhasBuffer = @()
                $dentroButtons = $false
                $idxInicio = -1
                continue
            }
            continue
        }

        [void]$resultado.Add($linha)
    }

    # Flush de buffer incompleto (caso raro)
    if ($linhasBuffer.Count -gt 0) {
        foreach ($lb in $linhasBuffer) {
            [void]$resultado.Add($lb)
        }
    }

    return ,$resultado.ToArray()
}

# =============================================================================
# #87 OptionGroup.Width deve acomodar MAX(Buttons[i].Left + Buttons[i].Width) + 10
# OptionGroup com BorderStyle=0 ainda clipa conteudo; container precisa crescer
# se Buttons foram expandidos (ex: para CHR codes acentuados "Nao").
# =============================================================================
function Corrigir-OptionGroupWidthAcomodaBotoes {
    param([string[]]$Linhas)

    # Fase 1: identificar OptionGroups e seus WITH blocks
    # Coletar: nome, linha_do_Width (para modificar), valor_atual_Width
    # Tambem coletar: para cada Buttons(N) do grupo, Left+Width
    $optionGroups = @{}

    $nomeAtual = $null
    $dentroContainer = $false
    $dentroButton = $false
    $contadorEndWith = 0
    $contadorEndWithBtn = 0
    $btnLeft = 0
    $btnWidth = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]

        # Detectar AddObject de OptionGroup
        if ($l -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"OptionGroup"\s*\)') {
            $nomeAtual = $Matches[1]
            if (-not $optionGroups.ContainsKey($nomeAtual)) {
                $optionGroups[$nomeAtual] = @{
                    Name = $nomeAtual
                    WidthLine = -1
                    CurrentWidth = 0
                    MaxRight = 0
                }
            }
            continue
        }

        # Detectar entrada em WITH <...>.<nomeAtual>
        if ($nomeAtual -and -not $dentroContainer -and -not $dentroButton -and `
            $l -match "(?i)^\s*WITH\s+[\w\.]+\.$([regex]::Escape($nomeAtual))\s*$") {
            $dentroContainer = $true
            $contadorEndWith = 1
            continue
        }

        # Detectar entrada em WITH <...>.<nomeAtual>.Buttons(N)
        if ($nomeAtual -and -not $dentroContainer -and -not $dentroButton -and `
            $l -match "(?i)^\s*WITH\s+[\w\.]+\.$([regex]::Escape($nomeAtual))\.Buttons\s*\(\s*\d+\s*\)\s*$") {
            $dentroButton = $true
            $contadorEndWithBtn = 1
            $btnLeft = 0
            $btnWidth = 0
            continue
        }

        if ($dentroContainer) {
            if ($l -match '(?i)^\s*WITH\b') { $contadorEndWith++ }
            if ($l -match '(?i)^\s*ENDWITH\b') {
                $contadorEndWith--
                if ($contadorEndWith -le 0) { $dentroContainer = $false }
                continue
            }
            if ($l -match '(?i)^\s*\.Width\s*=\s*(\d+)\s*$') {
                $optionGroups[$nomeAtual].WidthLine = $i
                $optionGroups[$nomeAtual].CurrentWidth = [int]$Matches[1]
            }
            continue
        }

        if ($dentroButton) {
            if ($l -match '(?i)^\s*WITH\b') { $contadorEndWithBtn++ }
            if ($l -match '(?i)^\s*ENDWITH\b') {
                $contadorEndWithBtn--
                if ($contadorEndWithBtn -le 0) {
                    # Final do bloco Buttons — atualizar MaxRight
                    $direita = $btnLeft + $btnWidth
                    if ($direita -gt $optionGroups[$nomeAtual].MaxRight) {
                        $optionGroups[$nomeAtual].MaxRight = $direita
                    }
                    $dentroButton = $false
                }
                continue
            }
            if ($l -match '(?i)^\s*\.Left\s*=\s*(\d+)\s*$') {
                $btnLeft = [int]$Matches[1]
            }
            if ($l -match '(?i)^\s*\.Width\s*=\s*(\d+)\s*$') {
                $btnWidth = [int]$Matches[1]
            }
            continue
        }
    }

    # Fase 2: para cada OptionGroup, se Width < MaxRight + 10, ajustar
    $resultado = New-Object System.Collections.ArrayList
    $ajustesPorLinha = @{}
    foreach ($og in $optionGroups.Values) {
        if ($og.WidthLine -lt 0) { continue }
        if ($og.MaxRight -le 0) { continue }
        $widthNecessaria = $og.MaxRight + 10
        if ($og.CurrentWidth -lt $widthNecessaria) {
            $ajustesPorLinha[$og.WidthLine] = @{
                NomeOg = $og.Name
                Antigo = $og.CurrentWidth
                Novo = $widthNecessaria
            }
        }
    }

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($ajustesPorLinha.ContainsKey($i)) {
            $info = $ajustesPorLinha[$i]
            # Preservar indentacao
            if ($linha -match '(?i)^(\s*\.Width\s*=\s*)\d+\s*$') {
                $novaLinha = $Matches[1] + $info.Novo.ToString()
                Add-Correcao -Tipo "OPTIONGROUP-WIDTH-ACOMODA" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "OptionGroup $($info.NomeOg).Width=$($info.Antigo) -> $($info.Novo) (acomodar Buttons + 10 margem)"
                [void]$resultado.Add($novaLinha)
                continue
            }
        }
        [void]$resultado.Add($linha)
    }

    return ,$resultado.ToArray()
}

# =============================================================================
# #61 PageFrame.TabStyle -> remover (read-only em VFP9)
# TabStyle eh definido apenas no design-time e NAO pode ser alterado via codigo.
# =============================================================================
function Corrigir-NovoRegistroSemDodefault {
    <#
    .SYNOPSIS
    Detecta NovoRegistro()/EditarRegistro() em BOs sem DODEFAULT() e adiciona.
    Sem DODEFAULT(), BusinessBase nao seta this_lEmEdicao=.T. e Salvar() falha.
    Pattern #62. Somente aplica em arquivos *BO.prg (nao FormBase/BusinessBase).
    #>
    param(
        [string[]]$Linhas,
        [string]$Arquivo = ""
    )

    # Somente aplicar em arquivos BO (nao FormBase ou BusinessBase)
    if (-not [string]::IsNullOrEmpty($Arquivo)) {
        $nomeArquivo = Split-Path -Leaf $Arquivo
        if ($nomeArquivo -notmatch '(?i)BO\.prg$' -or $nomeArquivo -match '(?i)^(formbase|businessbase)\.prg$') {
            return $Linhas
        }
    }

    $resultado = @()
    $dentroMetodo = $false
    $nomeMetodo = ""
    $primeiraLinha = $true
    $jaTemDodefault = $false
    $linhaAposProc = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta PROCEDURE NovoRegistro ou EditarRegistro (somente em *BO.prg)
        if ($linha -match '(?i)^\s*PROCEDURE\s+(NovoRegistro|EditarRegistro)\s*\(?\)?\s*$') {
            $dentroMetodo = $true
            $nomeMetodo = $Matches[1]
            $primeiraLinha = $true
            $jaTemDodefault = $false
            $linhaAposProc = $i + 1
            $resultado += $linha
            continue
        }

        if ($dentroMetodo) {
            # Verifica se DODEFAULT ja existe
            if ($linha -match '(?i)^\s*DODEFAULT\s*\(?\s*\)?\s*$') {
                $jaTemDodefault = $true
            }

            # Detecta ENDPROC
            if ($linha -match '(?i)^\s*ENDPROC\b') {
                if (-not $jaTemDodefault) {
                    # Inserir DODEFAULT() logo apos o PROCEDURE
                    $novoResultado = @()
                    for ($j = 0; $j -lt $resultado.Count; $j++) {
                        $novoResultado += $resultado[$j]
                        if ($j -eq ($linhaAposProc - 1)) {
                            # Detectar indentacao
                            $indent = "        "
                            if ($resultado[$j] -match '^(\s*)') {
                                $indent = $Matches[1] + "    "
                            }
                            $novoResultado += "${indent}DODEFAULT()"
                            Add-Correcao -Tipo "NOVO_REGISTRO_SEM_DODEFAULT" -Linha ($linhaAposProc + 1) -Original "$nomeMetodo() sem DODEFAULT()" -Corrigido "DODEFAULT() adicionado" -Descricao "$nomeMetodo sem DODEFAULT - BusinessBase.this_lEmEdicao nao seria setado"
                        }
                    }
                    $resultado = $novoResultado
                }
                $dentroMetodo = $false
            } elseif ($primeiraLinha -and $linha -match '\S') {
                $primeiraLinha = $false
            }
        }

        $resultado += $linha
    }
    return $resultado
}

function Corrigir-PageFrameTabStyle {
    <#
    .SYNOPSIS
    Remove .TabStyle de PageFrame. Propriedade read-only em VFP9.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $pageFrameNames = [System.Collections.Generic.HashSet[string]]@()
    $insidePageFrameWith = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $remover = $false

        # Detecta AddObject de PageFrame
        if ($linha -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"PageFrame"\s*\)') {
            [void]$pageFrameNames.Add($Matches[1])
        }

        # Detecta WITH block para PageFrame (por nome ou padrao pgf_4c_)
        if ($linha -match '(?i)^\s*WITH\s+') {
            foreach ($name in $pageFrameNames) {
                if ($linha -match "(?i)\.$([regex]::Escape($name))\s*$") {
                    $insidePageFrameWith = $true
                    break
                }
            }
            # Padrao generico: WITH ... .pgf_4c_
            if ($linha -match '(?i)\.pgf_4c_\w+\s*$') {
                $insidePageFrameWith = $true
            }
        }

        # Dentro de WITH de PageFrame, remover .TabStyle
        if ($insidePageFrameWith -and $linha -match '(?i)^\s*\.TabStyle\s*=\s*\d+') {
            $remover = $true
            Add-Correcao -Tipo "PAGEFRAME_TABSTYLE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(removido)" -Descricao "PageFrame.TabStyle eh read-only em VFP9 - nao pode ser definido via codigo"
        }

        if ($linha -match '(?i)^\s*ENDWITH\b') {
            $insidePageFrameWith = $false
        }

        if (-not $remover) {
            $resultado += $linha
        }
    }
    return $resultado
}

# =============================================================================
# #63 Container BackStyle=0 com CommandButtons dentro -> BackStyle=1
# Container transparente com CommandButtons nao recebe cliques quando
# sobrepoe outro container opaco. Fix: BackStyle=1 + BackColor escuro.
# Somente containers cnt_4c_Botoes* ou cnt_4c_Saida*.
# =============================================================================
function Corrigir-ContainerTransparenteComBotoes {
    <#
    .SYNOPSIS
    Containers cnt_4c_Botoes/cnt_4c_Saida/cnt_4c_BotoesDados que hospedam
    CommandButtons CRUD DEVEM ser TRANSPARENTES (BackStyle=0). LLM frequentemente
    copia o padrao de cnt_4c_Cabecalho (opaco escuro) e aplica aos botoes,
    criando caixa cinza ao redor dos botoes que destoa do layout original.
    Remove BackStyle=1 + BackColor=RGB(100,100,100) desses containers.
    EXCECAO: cnt_4c_Cabecalho continua opaco propositalmente.
    Pattern #63 (invertido em 2026-04-16 apos licao do FormDepartamento task016).
    #>
    param([string[]]$Linhas, [string]$Arquivo = "")

    # SAFETY GUARD (2026-07-02): pattern eh CRUD-canonico. NAO aplicar em classes
    # utilitarias (FormBuscaAuxiliar precisa BackStyle=1 opaco para nao expor Picture
    # do fundo entre grid e botoes; ver Pattern #107 que forca opaco quando overlay
    # sobre grid, mas nao ativa quando container esta ABAIXO do grid como em FBA).
    if ($Arquivo -match '(?i)\\classes\\') {
        return $Linhas
    }

    # Fase 1: Identificar containers de botoes (cnt_4c_Botoes/Saida/BotoesDados)
    # que contem CommandButtons como filhos
    $containerComBotao = [System.Collections.Generic.HashSet[string]]@()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detecta CommandButtons filhos: ...cnt_4c_Botoes.AddObject("cmd_4c_...", "CommandButton")
        if ($Linhas[$i] -match '(?i)\.(cnt_4c_(?:Botoes|Saida|BotoesDados)\w*)\.AddObject\s*\(\s*"[^"]+"\s*,\s*"CommandButton"\s*\)') {
            [void]$containerComBotao.Add($Matches[1])
        }
    }

    if ($containerComBotao.Count -eq 0) {
        return $Linhas
    }

    # Fase 2: Dentro do WITH desses containers, trocar BackStyle=1 -> BackStyle=0
    # e remover BackColor=RGB(100,100,100) (ou similar escuro)
    $resultado = @()
    $dentroWithContainer = $false
    $containerAtual = ""

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*WITH\s+') {
            foreach ($name in $containerComBotao) {
                if ($linha -match "(?i)\.$([regex]::Escape($name))\s*$") {
                    $dentroWithContainer = $true
                    $containerAtual = $name
                    break
                }
            }
        }

        if ($dentroWithContainer) {
            # Corrigir BackStyle = 1 -> BackStyle = 0 (tornar transparente)
            if ($linha -match '(?i)^(\s*)\.BackStyle\s*=\s*1\s*$') {
                $indent = $Matches[1]
                $resultado += "${indent}.BackStyle = 0"
                Add-Correcao -Tipo "CONTAINER_BOTOES_TRANSPARENTE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido ".BackStyle = 0" -Descricao "Container $containerAtual (hospeda botoes CRUD) deve ser transparente - NAO criar caixa cinza ao redor dos botoes"
                continue
            }

            # Remover BackColor escuro (RGB proximos de 0,0,0 a 90,90,90) em containers de botoes
            if ($linha -match '(?i)^(\s*)\.BackColor\s*=\s*RGB\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\s*$') {
                $r = [int]$Matches[2]
                $g = [int]$Matches[3]
                $b = [int]$Matches[4]
                # Se cor eh escura (soma < 300, indica cinza escuro/preto), remover linha
                if (($r + $g + $b) -lt 300) {
                    Add-Correcao -Tipo "CONTAINER_BOTOES_TRANSPARENTE" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(linha removida)" -Descricao "Container $containerAtual com BackColor escuro removido - deve ser transparente"
                    continue
                }
            }

            if ($linha -match '(?i)^\s*ENDWITH\b') {
                $dentroWithContainer = $false
                $containerAtual = ""
            }
        }

        $resultado += $linha
    }
    return $resultado
}

# =============================================================================
# #81 PageFrame.Height deve compensar Top=-29 (formula Form.Height + 29)
# Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), PageFrame.Height
# DEVE ser Form.Height + 29. Senao, sobram 29px descobertos no bottom expondo
# fundo cinza nativo do form como borda indesejada.
# Licao aprendida do FormDepartamento (task016) em 2026-04-16.
# =============================================================================
function Corrigir-PageFrameHeightTop29 {
    <#
    .SYNOPSIS
    Em forms frmcadastro: se pgf_4c_Paginas tem .Top=-29 e .Height=Form.Height,
    ajusta .Height para Form.Height + 29.
    Pattern #81.
    #>
    param([string[]]$Linhas)

    # Fase 1: Descobrir Form.Height (declarado na classe do Form)
    $formHeight = $null
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Match "Height = 600" apos DEFINE CLASS (nao dentro de WITH pgf/cnt/txt)
        if ($Linhas[$i] -match '(?i)^\s*Height\s*=\s*(\d+)\s*(&&.*)?$') {
            $formHeight = [int]$Matches[1]
            break
        }
    }

    if ($null -eq $formHeight) {
        return $Linhas
    }

    $heightEsperado = $formHeight + 29

    # Fase 2: Localizar WITH THIS.pgf_4c_Paginas com Top=-29 e ajustar Height
    $resultado = @()
    $dentroWithPageFrame = $false
    $top29Detectado = $false
    $bufferLinhas = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*WITH\s+.*\.pgf_4c_Paginas\s*$') {
            $dentroWithPageFrame = $true
            $top29Detectado = $false
            $resultado += $linha
            continue
        }

        if ($dentroWithPageFrame) {
            if ($linha -match '(?i)^\s*\.Top\s*=\s*-29\s*$') {
                $top29Detectado = $true
            }

            # So corrige Height se Top=-29 ja foi visto (assumindo ordem declarativa)
            # OU se o valor atual for igual a Form.Height (sinal claro do bug)
            if ($linha -match '(?i)^(\s*)\.Height\s*=\s*(\d+)\s*(&&.*)?$') {
                $valorAtual = [int]$Matches[2]
                $indent = $Matches[1]
                if ($top29Detectado -and $valorAtual -eq $formHeight) {
                    $resultado += "${indent}.Height    = $heightEsperado"
                    Add-Correcao -Tipo "PAGEFRAME_HEIGHT_TOP29" -Linha ($i + 1) -Original $linha.Trim() -Corrigido ".Height = $heightEsperado" -Descricao "pgf_4c_Paginas.Height ajustado para Form.Height + 29 (compensa Top=-29) - elimina borda cinza no bottom"
                    continue
                }
            }

            if ($linha -match '(?i)^\s*ENDWITH\b') {
                $dentroWithPageFrame = $false
                $top29Detectado = $false
            }
        }

        $resultado += $linha
    }
    return $resultado
}

# =============================================================================
# #64 FormBuscaAuxiliar: Release antes de ler cursor -> WARNING
# Se Release() ou USE IN cursor_4c_Busca aparece ANTES de ler os valores
# do cursor, os dados sao perdidos. Nao faz auto-fix, apenas alerta.
# =============================================================================
function Corrigir-FormBuscaAuxiliarOrdem {
    <#
    .SYNOPSIS
    Detecta Release() ou USE IN cursor antes de leitura de cursor_4c_Busca.
    Emite WARNING (nao faz auto-fix).
    Pattern #64.
    #>
    param([string[]]$Linhas)

    $conteudo = $Linhas -join "`r`n"

    # Buscar blocos com FormBuscaAuxiliar
    $matches = [regex]::Matches($conteudo, '(?si)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar".*?(?=PROCEDURE\b|ENDPROC\b|\z)')

    foreach ($bloco in $matches) {
        $blocoTexto = $bloco.Value
        $blocoInicio = ($conteudo.Substring(0, $bloco.Index) -split "`r`n").Count

        # Encontrar posicoes relativas dentro do bloco
        $linhasBloco = $blocoTexto -split "`r`n"
        $posRelease = -1
        $posUseIn = -1
        $posLeitura = -1

        for ($j = 0; $j -lt $linhasBloco.Count; $j++) {
            # Release()
            if ($posRelease -eq -1 -and $linhasBloco[$j] -match '(?i)\.Release\s*\(\s*\)') {
                $posRelease = $j
            }
            # USE IN cursor_4c_Busca
            if ($posUseIn -eq -1 -and $linhasBloco[$j] -match '(?i)USE\s+IN\s+.*cursor_4c_Busca') {
                $posUseIn = $j
            }
            # Leitura de cursor: cursor_4c_Busca.campo (atribuicao)
            if ($posLeitura -eq -1 -and $linhasBloco[$j] -match '(?i)cursor_4c_Busca\.\w+' -and $linhasBloco[$j] -notmatch '(?i)^\s*\*') {
                $posLeitura = $j
            }
        }

        # Verifica se Release ou USE IN aparece ANTES da leitura
        if ($posLeitura -gt 0) {
            if ($posRelease -ge 0 -and $posRelease -lt $posLeitura) {
                $linhaAbsoluta = $blocoInicio + $posRelease
                Add-Correcao -Tipo "BUSCA_RELEASE_ANTES_LEITURA" -Linha $linhaAbsoluta -Original "Release() na linha $linhaAbsoluta, leitura na linha $($blocoInicio + $posLeitura)" -Corrigido "(WARNING - correcao manual)" -Descricao "Release() ANTES de ler cursor_4c_Busca - dados perdidos. Ordem correta: ler cursor -> Release -> USE IN"
            }
            if ($posUseIn -ge 0 -and $posUseIn -lt $posLeitura) {
                $linhaAbsoluta = $blocoInicio + $posUseIn
                Add-Correcao -Tipo "BUSCA_USEIN_ANTES_LEITURA" -Linha $linhaAbsoluta -Original "USE IN na linha $linhaAbsoluta, leitura na linha $($blocoInicio + $posLeitura)" -Corrigido "(WARNING - correcao manual)" -Descricao "USE IN cursor_4c_Busca ANTES de ler valores - cursor destruido. Ordem correta: ler cursor -> Release -> USE IN"
            }
        }
    }

    # Nao modifica o conteudo - apenas emite warnings
    return $Linhas
}

# =============================================================================
# #65 SQL column names legados que nao existem no schema real
# Detecta aliases legados comuns em queries SQL e emite WARNING.
# =============================================================================
function Corrigir-SQLColunasLegadas {
    <#
    .SYNOPSIS
    Detecta nomes de colunas legados em queries SQL que nao correspondem
    ao schema real do SQL Server. Emite WARNING (nao faz auto-fix).
    Pattern #65.
    #>
    param([string[]]$Linhas)

    # Mapeamento de nomes legados -> nomes reais no SQL Server
    $colunasLegadas = @{
        'DataAlts'  = 'dtalts'
        'HoraAlts'  = 'horaalts'
        'UsuaAlts'  = 'usuaalts'
        'DataIncs'  = 'dtincs'
    }

    # Contextos SQL: TEXT TO ... ENDTEXT ou strings com SELECT/WHERE/ORDER BY
    $dentroTextTo = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta TEXT TO ... ENDTEXT
        if ($linha -match '(?i)^\s*TEXT\s+TO\b') {
            $dentroTextTo = $true
            continue
        }
        if ($linha -match '(?i)^\s*ENDTEXT\b') {
            $dentroTextTo = $false
            continue
        }

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            continue
        }

        # Verificar se a linha esta em contexto SQL
        $ehContextoSQL = $dentroTextTo -or ($linha -match '(?i)(SELECT|WHERE|ORDER\s+BY|GROUP\s+BY|SET\s+\w+\s*=|INSERT\s+INTO|UPDATE\s+\w+\s+SET)')

        if ($ehContextoSQL) {
            foreach ($legado in $colunasLegadas.Keys) {
                # Busca case-insensitive mas exata (palavra inteira)
                if ($linha -match "(?i)\b$legado\b") {
                    $real = $colunasLegadas[$legado]
                    Add-Correcao -Tipo "SQL_COLUNA_LEGADA" -Linha ($i + 1) -Original "$legado (na linha: $($linha.Trim()))" -Corrigido "(WARNING) Usar '$real' em vez de '$legado'" -Descricao "Coluna '$legado' eh nome legado CamelCase - schema real usa '$real'"
                }
            }
        }
    }

    # Nao modifica o conteudo - apenas emite warnings
    return $Linhas
}

# =============================================================================
# #66 NVL(campo, 0) = 1 em campos BIT (LOGICAL no VFP9)
# Campos BIT do SQL Server chegam como LOGICAL (.T./.F.) no VFP9.
# NVL(campo, 0) mistura LOGICAL com NUMERIC causando type mismatch.
# IMPORTANTE: IIF() em VFP9 avalia AMBOS os ramos. Quando campo eh LOGICAL,
# o ramo NVL(campo,0) falha porque NVL nao aceita LOGICAL com default NUMERIC.
# Solucao: usar IF/ELSE/ENDIF (multi-linha) em vez de IIF.
# =============================================================================
function Corrigir-NvlBitField {
    <#
    .SYNOPSIS
    Detecta NVL(campo, 0) = 1 ou NVL(campo, 0) = 0 e expande para IF/ELSE/ENDIF
    com VARTYPE check para suportar tanto campos BIT (LOGICAL) quanto NUMERIC(1,0).
    NUNCA usar IIF() porque VFP9 avalia AMBOS os ramos causando type mismatch.
    Pattern #66.
    #>
    param([string[]]$Linhas)

    $resultado = @()

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # GUARD: pular se ja esta dentro de IF VARTYPE (ja foi corrigido anteriormente)
        if ($linha -match '(?i)^\s*IF\s+VARTYPE\s*\(' -and $linha -match '(?i)NVL\s*\(') {
            $resultado += $linha
            continue
        }
        # GUARD: pular IIF legado (ja corrigido em versao anterior - sera tratado manualmente)
        if ($linha -match '(?i)IIF\s*\(\s*VARTYPE\s*\(' -and $linha -match '(?i)NVL\s*\(') {
            $resultado += $linha
            continue
        }

        # Detecta: <target> = NVL(campo, 0) = 1/0 ou <target> = (NVL(campo, 0) = 1/0) (assignment context)
        if ($linha -match '(?i)^(\s*)(.*?)\s*=\s*\(?\s*NVL\s*\(\s*([\w\.]+)\s*,\s*0\s*\)\s*=\s*([01])\s*\)?\s*$') {
            $indent = $Matches[1]
            $target = $Matches[2].Trim()
            $campo  = $Matches[3]
            $valor  = $Matches[4]

            if ($valor -eq "1") {
                $resultado += "${indent}IF VARTYPE($campo) = ""L"""
                $resultado += "${indent}    $target = $campo"
                $resultado += "${indent}ELSE"
                $resultado += "${indent}    $target = (NVL($campo, 0) = 1)"
                $resultado += "${indent}ENDIF"
            } else {
                $resultado += "${indent}IF VARTYPE($campo) = ""L"""
                $resultado += "${indent}    $target = !$campo"
                $resultado += "${indent}ELSE"
                $resultado += "${indent}    $target = (NVL($campo, 0) = 0)"
                $resultado += "${indent}ENDIF"
            }

            Add-Correcao -Tipo "NVL_BIT_FIELD" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "IF VARTYPE($campo)=""L"" / $target = ... / ELSE / $target = (NVL(...)) / ENDIF" -Descricao "NVL(campo,0)=valor em campo BIT. IIF avalia AMBOS ramos causando type mismatch. Expandido para IF/ELSE/ENDIF"
            continue
        }

        # Detecta: NVL(campo, 0) = 1/0 sem assignment (standalone expression - raro)
        if ($linha -match '(?i)NVL\s*\(\s*([\w\.]+)\s*,\s*0\s*\)\s*=\s*([01])') {
            $campo = $Matches[1]
            $valor = $Matches[2]

            # Sem contexto de assignment, emitir warning para revisao manual
            Add-Correcao -Tipo "NVL_BIT_FIELD_WARN" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(revisar manualmente)" -Descricao "NVL(campo,0)=$valor sem assignment detectado. IIF nao eh seguro (avalia ambos ramos). Converter para IF/ELSE/ENDIF manualmente"
            $resultado += $linha
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# #67 Wrong F4 key code (63 instead of 115) em KeyPress handlers
# VFP9 KeyPress: F4=115, F5=116. Code 63 is '?' (ASCII).
# Claude sometimes generates 63 for F4 which is wrong.
# =============================================================================
function Corrigir-F4KeyCode {
    <#
    .SYNOPSIS
    Detecta par_nKeyCode = 63 em KeyPress handlers e substitui por
    par_nKeyCode = 115 (F4 correto) ou INLIST com codigos corretos.
    Pattern #67.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroKeyPress = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta inicio de PROCEDURE KeyPress handler
        if ($linha -match '(?i)^\s*PROCEDURE\s+\w*KeyPress\b') {
            $dentroKeyPress = $true
        }

        # Detecta fim de PROCEDURE
        if ($dentroKeyPress -and $linha -match '(?i)^\s*ENDPROC\b') {
            $dentroKeyPress = $false
        }

        # Dentro de um KeyPress handler, corrigir par_nKeyCode = 63
        if ($dentroKeyPress) {
            # Caso 1: par_nKeyCode = 63 OR ... (parte de expressao maior)
            if ($linha -match '(?i)par_nKeyCode\s*=\s*63\s+OR\b') {
                $linhaCorrigida = $linha -replace '(?i)par_nKeyCode\s*=\s*63', 'par_nKeyCode = 115'
                $resultado += $linhaCorrigida
                Add-Correcao -Tipo "F4_KEYCODE_ERRADO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $linhaCorrigida.Trim() -Descricao "F4 key code corrigido: 63 (?) -> 115 (F4). VFP9 KeyPress: F4=115, F5=116"
                continue
            }
            # Caso 2: par_nKeyCode = 63 isolado (sem OR depois)
            if ($linha -match '(?i)par_nKeyCode\s*=\s*63\b' -and $linha -notmatch '(?i)par_nKeyCode\s*=\s*63\s+OR\b') {
                $linhaCorrigida = $linha -replace '(?i)par_nKeyCode\s*=\s*63', 'par_nKeyCode = 115'
                $resultado += $linhaCorrigida
                Add-Correcao -Tipo "F4_KEYCODE_ERRADO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido $linhaCorrigida.Trim() -Descricao "F4 key code corrigido: 63 (?) -> 115 (F4). VFP9 KeyPress: F4=115, F5=116"
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-ValidandoUIGuard {
    <#
    .SYNOPSIS
    Adiciona guard TYPE() para gb_4c_ValidandoUI no inicio de InicializarForm.
    Pattern #70.

    .DESCRIPTION
    Forms que usam gb_4c_ValidandoUI (variavel global do TesteAutomatico) DEVEM
    ter um guard no inicio de InicializarForm para declarar a variavel se nao existir.
    Sem isso, o form abre com erro "Variable GB_4C_VALIDANDOUI is not found" em runtime normal.

    Detecta: gb_4c_ValidandoUI usado no arquivo SEM guard TYPE("gb_4c_ValidandoUI")
    em InicializarForm.
    Corrige: Adiciona o guard apos as declaracoes LOCAL de InicializarForm.
    #>
    param([string[]]$Linhas)

    $conteudo = $Linhas -join "`r`n"

    # So aplica se o arquivo usa gb_4c_ValidandoUI mas NAO tem guard TYPE
    if ($conteudo -notmatch 'gb_4c_ValidandoUI') {
        return $Linhas
    }
    if ($conteudo -match 'TYPE\s*\(\s*"gb_4c_ValidandoUI"\s*\)') {
        return $Linhas
    }

    # Encontrar PROCEDURE InicializarForm
    $resultado = @()
    $dentroInicializarForm = $false
    $guardInserido = $false
    $ultimaLinhaLocal = -1
    $linhaInicioProc = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($Linhas[$i] -match '(?i)^\s*PROCEDURE\s+InicializarForm\b') {
            $dentroInicializarForm = $true
            $linhaInicioProc = $i
            $ultimaLinhaLocal = $i  # fallback: inserir logo apos PROCEDURE
        }
        if ($dentroInicializarForm -and -not $guardInserido) {
            # Rastrear ultima linha LOCAL
            if ($Linhas[$i] -match '(?i)^\s*LOCAL\s+') {
                $ultimaLinhaLocal = $i
            }
            # Detectar inicio do TRY ou primeira linha de codigo (nao-LOCAL, nao-comentario, nao-vazia)
            if ($i -gt $linhaInicioProc -and $Linhas[$i] -match '(?i)^\s*(TRY|IF |DO |THIS\.|DODEFAULT|loc_|STORE|RETURN)') {
                # Inserir guard ANTES desta linha, APOS a ultima LOCAL
                $insertPos = $ultimaLinhaLocal + 1
                # Adicionar tudo ate insertPos
                for ($j = $resultado.Count; $j -le $insertPos - 1; $j++) {
                    # ja foi adicionado no loop anterior
                }
                # Inserir as linhas de guard
                $guardLines = @(
                    "",
                    "        IF TYPE(""gb_4c_ValidandoUI"") != ""L""",
                    "            PUBLIC gb_4c_ValidandoUI",
                    "            gb_4c_ValidandoUI = .F.",
                    "        ENDIF",
                    ""
                )
                # Rebuild: tudo ate $ultimaLinhaLocal ja esta no $resultado
                # Agora adicionar guard + linha atual
                $novoResultado = @()
                for ($k = 0; $k -lt $resultado.Count; $k++) {
                    $novoResultado += $resultado[$k]
                }
                # Adicionar linhas desde resultado.Count ate $i-1 (se houver)
                for ($k = $resultado.Count; $k -lt $i; $k++) {
                    $novoResultado += $Linhas[$k]
                }
                # Se insertPos esta entre resultado.Count e $i, precisamos inserir no ponto certo
                # Simplificar: reconstruir do zero
                $novoResultado = @()
                for ($k = 0; $k -le $ultimaLinhaLocal; $k++) {
                    $novoResultado += $Linhas[$k]
                }
                $novoResultado += $guardLines
                for ($k = $ultimaLinhaLocal + 1; $k -lt $Linhas.Count; $k++) {
                    $novoResultado += $Linhas[$k]
                }

                Add-Correcao -Tipo "VALIDANDOUI_GUARD" -Linha ($ultimaLinhaLocal + 2) -Original "(sem guard TYPE para gb_4c_ValidandoUI)" -Corrigido "IF TYPE(""gb_4c_ValidandoUI"") != ""L"" ... ENDIF" -Descricao "Guard gb_4c_ValidandoUI adicionado em InicializarForm (Pattern #70)"

                return $novoResultado
            }
        }
        if ($dentroInicializarForm -and $Linhas[$i] -match '(?i)^\s*ENDPROC\b') {
            $dentroInicializarForm = $false
        }
        $resultado += $Linhas[$i]
    }

    return $Linhas
}

# =============================================================================
# #72 CREATE CURSOR campo N(1,0) onde schema.sql diz BIT -> L
# BIT columns in SQL Server map to LOGICAL in VFP9, not NUMERIC(1,0).
# Also fixes Check1.Value = 0 -> .F. and Check1.Value = 1 -> .T. for BIT fields.
# =============================================================================

# Cache global para evitar re-leitura do schema.sql em cada chamada
$script:BitColumnsCache = $null

function Get-BitColumnsFromSchema {
    <#
    .SYNOPSIS
    Parses schema.sql to build a HashSet of column names that are BIT type.
    Caches the result for subsequent calls.
    #>
    if ($null -ne $script:BitColumnsCache) {
        return $script:BitColumnsCache
    }

    $schemaPath = "C:\4c\docs\schema.sql"
    $bitColumns = New-Object System.Collections.Generic.HashSet[string]([System.StringComparer]::OrdinalIgnoreCase)

    if (-not (Test-Path $schemaPath)) {
        Write-Host "  AVISO: schema.sql nao encontrado em $schemaPath - Pattern #72 ignorado" -ForegroundColor Yellow
        $script:BitColumnsCache = $bitColumns
        return $bitColumns
    }

    try {
        # schema.sql is UTF-16 encoded
        $schemaContent = Get-Content -Path $schemaPath -Encoding Unicode -Raw

        # Parse [column_name] [bit] patterns
        $matches = [regex]::Matches($schemaContent, '\[(\w+)\]\s+\[bit\]', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($m in $matches) {
            $colName = $m.Groups[1].Value
            [void]$bitColumns.Add($colName)
        }

        Write-Host "  Schema BIT columns carregadas: $($bitColumns.Count) colunas" -ForegroundColor Gray
    }
    catch {
        Write-Host "  AVISO: Erro ao ler schema.sql: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    $script:BitColumnsCache = $bitColumns
    return $bitColumns
}

function Corrigir-CursorBitFields {
    <#
    .SYNOPSIS
    Detecta campos N(1,0) em CREATE CURSOR que sao BIT no schema.sql e corrige para L.
    Tambem corrige Check1.Value = 0 -> .F. e Check1.Value = 1 -> .T. para campos BIT.
    Pattern #72.
    #>
    param([string[]]$Linhas)

    $bitColumns = Get-BitColumnsFromSchema
    if ($bitColumns.Count -eq 0) {
        return $Linhas
    }

    $resultado = @()
    $dentroCreateCursor = $false
    $bitFieldsEncontrados = New-Object System.Collections.Generic.HashSet[string]([System.StringComparer]::OrdinalIgnoreCase)

    # Pass 1: Fix N(1,0) -> L in CREATE CURSOR for BIT columns
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar inicio de CREATE CURSOR
        if ($linha -match '(?i)CREATE\s+CURSOR\s+') {
            $dentroCreateCursor = $true
        }

        if ($dentroCreateCursor) {
            # Detectar campo com N(1,0) ou N(1, 0)
            if ($linha -match '(?i)^\s*(\w+)\s+N\s*\(\s*1\s*,\s*0\s*\)') {
                $fieldName = $Matches[1]
                if ($bitColumns.Contains($fieldName)) {
                    $linhaOriginal = $linha
                    $linha = $linha -replace '(?i)N\s*\(\s*1\s*,\s*0\s*\)', 'L'
                    [void]$bitFieldsEncontrados.Add($fieldName)

                    Add-Correcao -Tipo "CURSOR_BIT_FIELD" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Campo $fieldName eh BIT no schema.sql -> tipo L (LOGICAL) no cursor (Pattern #72)"
                }
            }

            # Detectar fim do CREATE CURSOR (linha sem ;\ de continuacao ou com ) final)
            if ($linha -match '\)\s*$' -and $linha -notmatch ';\s*$') {
                $dentroCreateCursor = $false
            }
            # Tambem finalizar se a linha nao termina com ;
            if ($linha -notmatch ';\s*\\?\s*$' -and $linha -notmatch '(?i)CREATE\s+CURSOR') {
                $dentroCreateCursor = $false
            }
        }

        $resultado += $linha
    }

    # Pass 2: Fix Check1.Value = 0 -> .F. and Check1.Value = 1 -> .T. for BIT fields
    # Only if we found BIT fields in this file
    if ($bitFieldsEncontrados.Count -gt 0) {
        $resultado2 = @()
        for ($i = 0; $i -lt $resultado.Count; $i++) {
            $linha = $resultado[$i]

            # Pular comentarios
            if ($linha -match '(?i)^\s*(\*|&&)') {
                $resultado2 += $linha
                continue
            }

            # Detectar Check1.Value = 0 ou .Value = 0 (near checkbox assignments)
            if ($linha -match '(?i)(Check\d*\.Value|\.Value)\s*=\s*0\s*$') {
                $linhaOriginal = $linha
                $linha = $linha -replace '(?i)(\.Value\s*=\s*)0\s*$', '${1}.F.'

                Add-Correcao -Tipo "CURSOR_BIT_FIELD" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Check1.Value = 0 -> .F. para campo BIT (LOGICAL) (Pattern #72)"
            }
            elseif ($linha -match '(?i)(Check\d*\.Value|\.Value)\s*=\s*1\s*$') {
                $linhaOriginal = $linha
                $linha = $linha -replace '(?i)(\.Value\s*=\s*)1\s*$', '${1}.T.'

                Add-Correcao -Tipo "CURSOR_BIT_FIELD" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "Check1.Value = 1 -> .T. para campo BIT (LOGICAL) (Pattern #72)"
            }

            $resultado2 += $linha
        }
        return $resultado2
    }

    return $resultado
}

# =============================================================================
# #73 BOParaForm CheckBox.Value = (expressao logica) -> IIF(..., 1, 0)
# Quando CorretorAuto #47 define CheckBox.Value como NUMERICO (0/1),
# BOParaForm deve atribuir NUMERICO, nao LOGICAL.
# ERRADO: chk.Value = (loc_oBO.this_nXxx = 1)   <- atribui .T./.F. (LOGICAL)
# CORRETO: chk.Value = IIF(loc_oBO.this_nXxx = 1, 1, 0)  <- atribui 1/0 (NUMERIC)
# =============================================================================
function Corrigir-BOParaFormCheckBoxLogico {
    <#
    .SYNOPSIS
    Detecta .Value = (expressao) em BOParaForm onde expressao eh comparacao logica
    e converte para IIF(expressao, 1, 0) para manter tipo NUMERICO.
    Pattern #73.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $dentroBOParaForm = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar inicio/fim de BOParaForm
        if ($linha -match '(?i)PROCEDURE\s+BOParaForm') {
            $dentroBOParaForm = $true
        }
        if ($dentroBOParaForm -and $linha -match '(?i)^(\s*)ENDPROC') {
            $dentroBOParaForm = $false
        }

        if ($dentroBOParaForm) {
            # Detecta: xxx.Value = (loc_oBO.this_xxx = 1) ou similar
            # Pattern: .Value = (algo = algo)  onde o resultado seria LOGICAL
            # GUARD: pular se ja tem IIF
            if ($linha -notmatch '(?i)IIF\s*\(' -and $linha -match '(?i)(\.Value\s*=\s*)\(([^)]+)\)\s*$') {
                $prefix = $Matches[1]
                $expr = $Matches[2]

                # Verificar se a expressao contem comparacao (= 1, = 0, etc.)
                if ($expr -match '=\s*[01]' -or $expr -match '(?i)=\s*\.T\.' -or $expr -match '(?i)=\s*\.F\.') {
                    $linhaOriginal = $linha
                    $novoValor = "IIF($expr, 1, 0)"
                    $linha = $linha -replace [regex]::Escape($Matches[0]), "${prefix}${novoValor}"

                    Add-Correcao -Tipo "BOPARAFORM_CHECKBOX_LOGICO" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "BOParaForm CheckBox.Value = (expr logica) atribui LOGICAL. Convertido para IIF(expr, 1, 0) para manter NUMERICO (Pattern #73)"
                }
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #68: Container.BorderStyle nao existe em VFP9
# Container tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup).
# Detecta .BorderStyle dentro de contexto AddObject("xxx", "Container") e REMOVE a linha.
# =============================================================================
function Corrigir-ContainerBorderStyle {
    param([string[]]$Linhas)

    $resultado = @()
    $dentroContainer = $false
    $contadorEndWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar AddObject com Container
        if ($linha -match '(?i)AddObject\s*\(\s*"[^"]+"\s*,\s*"Container"\s*\)') {
            $dentroContainer = $true
            $contadorEndWith = 0
        }

        # Detectar WITH (incrementar nivel)
        if ($dentroContainer -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }

        # Detectar ENDWITH (decrementar nivel)
        if ($dentroContainer -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroContainer = $false
            }
        }

        # Remover .BorderStyle dentro de contexto Container
        if ($dentroContainer -and $linha -match '(?i)^\s*\.BorderStyle\s*=') {
            Add-Correcao -Tipo "CONTAINER-BORDERSTYLE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Removido .BorderStyle de Container (propriedade nao existe em VFP9)"
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #70: Validar() -> ValidarDados() (task017)
# BusinessBase.Salvar chama THIS.ValidarDados(); Validar() eh silenciosamente pulado.
# =============================================================================
function Corrigir-ValidarParaValidarDados {
    param([string[]]$Linhas)

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Pular comentarios
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar "PROTECTED PROCEDURE Validar()" ou "PROCEDURE Validar()" (sem Dados)
        if ($linha -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+Validar\s*\(\s*\)\s*$') {
            $nova = $linha -replace '(?i)\bValidar\s*\(\s*\)', 'ValidarDados()'
            Add-Correcao -Tipo "VALIDAR-VALIDARDADOS" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Renomeado Validar() -> ValidarDados() (hook correto do BusinessBase.Salvar)"
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #71: IIF() com numerico direto sem comparacao (task017)
# IIF(THIS.this_nFlag, '1', '0') -> IIF(THIS.this_nFlag = 1, '1', '0')
# =============================================================================
function Corrigir-IIFNumericoSemComparacao {
    param([string[]]$Linhas)

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar IIF(THIS.this_n<nome>, '1', '0') e IIF(THIS.this_n<nome>, '0', '1')
        $pattern = "(?i)IIF\s*\(\s*(THIS\.this_n\w+)\s*,\s*('[01]')\s*,\s*('[01]')\s*\)"
        if ($linha -match $pattern) {
            $nova = [regex]::Replace($linha, $pattern, {
                param($m)
                "IIF($($m.Groups[1].Value) = 1, $($m.Groups[2].Value), $($m.Groups[3].Value))"
            })
            if ($nova -ne $linha) {
                Add-Correcao -Tipo "IIF-NUMERICO-COMPARACAO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "IIF(this_n*, ...) precisa comparacao explicita (= 1) para gerar LOGICAL"
                $resultado += $nova
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #72: this_n* com NVL(col,0)=1 (converte para LOGICAL) (task017)
# THIS.this_nFlag = (NVL(col, 0) = 1) -> THIS.this_nFlag = NVL(col, 0)
# =============================================================================
function Corrigir-NumericoPreservaTipo {
    param([string[]]$Linhas)

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar: THIS.this_n<nome> = (NVL(col, 0) = 1) [com ou sem parenteses externos]
        $pattern = '(?i)(THIS\.this_n\w+)\s*=\s*\(?\s*NVL\s*\(\s*(\w+)\s*,\s*0\s*\)\s*=\s*1\s*\)?'
        if ($linha -match $pattern) {
            $nova = [regex]::Replace($linha, $pattern, '$1 = NVL($2, 0)')
            Add-Correcao -Tipo "NUMERICO-PRESERVA-TIPO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "this_n* com NVL(col,0)=1 converteria para LOGICAL; simplificado para NVL(col, 0)"
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #73: CheckBox AddObject init .Value=.F./.T. (task017)
# Complementa #47. Converte init para .Value=0/1 (NUMERIC).
# =============================================================================
function Corrigir-CheckBoxInitLogico {
    param([string[]]$Linhas)

    $resultado = @()
    $dentroCheckBox = $false
    $contadorEndWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        if ($linha -match '(?i)AddObject\s*\(\s*"(chk_4c_\w+)"\s*,\s*"CheckBox"\s*\)') {
            $dentroCheckBox = $true
            $contadorEndWith = 0
        }

        if ($dentroCheckBox -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }

        if ($dentroCheckBox -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroCheckBox = $false
            }
        }

        if ($dentroCheckBox -and $linha -match '(?i)^\s*\.Value\s*=\s*\.F\.\s*$') {
            $nova = $linha -replace '(?i)\.F\.', '0'
            Add-Correcao -Tipo "CHECKBOX-INIT-LOGICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "CheckBox init .Value=.F. -> .Value=0 (consistencia com LimparCampos NUMERIC)"
            $resultado += $nova
            continue
        }

        if ($dentroCheckBox -and $linha -match '(?i)^\s*\.Value\s*=\s*\.T\.\s*$') {
            $nova = $linha -replace '(?i)\.T\.', '1'
            Add-Correcao -Tipo "CHECKBOX-INIT-LOGICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "CheckBox init .Value=.T. -> .Value=1"
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #74: BINDEVENT "LostFocus" em handler lookup FormBuscaAuxiliar (task017/018)
# Troca LostFocus -> KeyPress. Ajuste manual do handler (params + guard) ainda necessario.
# =============================================================================
function Corrigir-LostFocusLookupBusca {
    param([string[]]$Linhas)

    # Coleta handlers de lookup por 4 heuristicas (mais larga que antes):
    #   (a) PROCEDURE cujo corpo contem CREATEOBJECT("FormBuscaAuxiliar")
    #   (b) Nome da PROCEDURE contem "Lookup" (ex: AbrirLookupCor, UsuarsLookupLostFocus)
    #   (c) Nome da PROCEDURE contem "Validar" E o arquivo inteiro tem FormBuscaAuxiliar
    #   (d) Nome da PROCEDURE termina em "LostFocus" (ex: UsuarsLostFocus) — gerador
    #       tende a nomear handlers assim mesmo sem ser lookup; o trigger aqui eh
    #       que BINDEVENT LostFocus raramente eh o que se quer (KeyPress eh melhor)
    # Motivo: tasks 017-022 tiveram lookups usando LostFocus que escapavam porque
    # o CREATEOBJECT estava em AbrirLookupXxx, nao no handler BINDEVENT. Heuristica
    # (d) pega o caso de task016 (UsuarsLostFocus) que nao caia em (a/b/c).
    $arquivoTemFormBusca = (($Linhas -join "`n") -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"')

    $handlersLookup = @()
    $procNome = $null
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)^\s*PROCEDURE\s+(\w+)') {
            $procNome = $Matches[1]
            # (b) nome contem Lookup
            if ($procNome -match '(?i)Lookup' -and $handlersLookup -notcontains $procNome) {
                $handlersLookup += $procNome
            }
            # (c) nome contem Validar e arquivo tem FormBuscaAuxiliar
            if ($procNome -match '(?i)Validar' -and $arquivoTemFormBusca -and $handlersLookup -notcontains $procNome) {
                $handlersLookup += $procNome
            }
            # (d) nome termina em "LostFocus" (ex: UsuarsLostFocus)
            if ($procNome -match '(?i)LostFocus$' -and $handlersLookup -notcontains $procNome) {
                $handlersLookup += $procNome
            }
        }
        # (a) body tem CREATEOBJECT FormBuscaAuxiliar
        if ($procNome -and $l -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
            if ($handlersLookup -notcontains $procNome) {
                $handlersLookup += $procNome
            }
        }
    }

    if ($handlersLookup.Count -eq 0) { return $Linhas }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # BINDEVENT(..., "LostFocus", ..., "<handlerLookup>")
        $m = [regex]::Match($linha, '(?i)BINDEVENT\s*\([^,]+,\s*"LostFocus"\s*,\s*[^,]+,\s*"(\w+)"')
        if ($m.Success -and $handlersLookup -contains $m.Groups[1].Value) {
            $nova = $linha -replace '(?i)"LostFocus"', '"KeyPress"'
            Add-Correcao -Tipo "LOSTFOCUS-LOOKUP" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "BINDEVENT LostFocus -> KeyPress para handler $($m.Groups[1].Value) (evita recursao com FormBuscaAuxiliar). IMPORTANTE: adicionar manualmente parametros (par_nKeyCode, par_nShiftAltCtrl) e guard ENTER/TAB/F4 no handler."
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #75: ALLTRIM em campo numerico (task018)
# Envolve com TRANSFORM quando controle tem .Value = <numero> no AddObject.
# =============================================================================
function Corrigir-ALLTRIMCampoNumerico {
    param([string[]]$Linhas)

    # Fase 1: detectar controles numericos (AddObject + .Value = numero)
    $controlesNumericos = @{}
    $ultimoControle = $null
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)AddObject\s*\(\s*"(txt_4c_\w+|obj_4c_\w+)"\s*,\s*"(TextBox|Spinner)"\s*\)') {
            $ultimoControle = $Matches[1]
        }
        if ($ultimoControle -and $l -match '(?i)^\s*\.Value\s*=\s*(\d+)\s*$') {
            $controlesNumericos[$ultimoControle] = $true
            $ultimoControle = $null
        }
        if ($l -match '(?i)^\s*ENDWITH') {
            $ultimoControle = $null
        }
    }

    if ($controlesNumericos.Count -eq 0) { return $Linhas }

    # Fase 2: detectar ALLTRIM(<qualquer_coisa>.<controle_numerico>.Value) sem TRANSFORM
    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        $nova = $linha
        foreach ($ctrl in $controlesNumericos.Keys) {
            $padrao = "(?i)ALLTRIM\s*\(\s*([a-zA-Z_][\w\.]*\.$ctrl\.Value)\s*\)"
            if ($nova -match $padrao -and $nova -notmatch "(?i)ALLTRIM\s*\(\s*TRANSFORM") {
                $nova = [regex]::Replace($nova, $padrao, 'ALLTRIM(TRANSFORM($1))')
                Add-Correcao -Tipo "ALLTRIM-NUMERICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "ALLTRIM em $ctrl (numerico) -> ALLTRIM(TRANSFORM(...))"
            }
        }

        $resultado += $nova
    }

    return $resultado
}

# =============================================================================
# Pattern #76: cmd_4c_Encerrar.Caption errado (task018)
# Normaliza Caption "X"/"Sair"/"" para "Encerrar".
# =============================================================================
function Corrigir-EncerrarCaptionX {
    param([string[]]$Linhas)

    $resultado = @()
    $dentroEncerrar = $false
    $contadorEndWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        if ($linha -match '(?i)AddObject\s*\(\s*"cmd_4c_Encerrar"\s*,\s*"CommandButton"\s*\)') {
            $dentroEncerrar = $true
            $contadorEndWith = 0
        }

        if ($dentroEncerrar -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }
        if ($dentroEncerrar -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroEncerrar = $false
            }
        }

        if ($dentroEncerrar -and $linha -match '(?i)^\s*\.Caption\s*=\s*"(X|Sair|)"\s*$') {
            $nova = $linha -replace '(?i)"(X|Sair|)"', '"Encerrar"'
            Add-Correcao -Tipo "ENCERRAR-CAPTION" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cmd_4c_Encerrar.Caption -> 'Encerrar' (padrao CRUD FormCor/FormMoe)"
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-CntBotoesLeft542 {
    param([string[]]$Linhas, [string]$Arquivo = "")

    # SAFETY GUARD (2026-07-02): pattern eh CRUD-canonico (form 1000px).
    # NAO aplicar em classes utilitarias (FormBuscaAuxiliar, FormBuscaSimples, FormErro etc)
    # que tem Width menor e ficariam com container fora da tela.
    if ($Arquivo -match '(?i)\\classes\\') {
        return $Linhas
    }

    # Detecta AddObject("cnt_4c_Botoes", "Container") + linha posterior com .Left = <qualquer valor != 542>
    # Requer estar dentro do WITH cnt_4c_Botoes (nao de outro container)
    $resultado = @()
    $dentroCntBotoes = $false
    $contadorEndWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        if ($linha -match '(?i)AddObject\s*\(\s*"cnt_4c_Botoes"\s*,\s*"Container"\s*\)') {
            $dentroCntBotoes = $true
            $contadorEndWith = 0
        }

        if ($dentroCntBotoes -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }
        if ($dentroCntBotoes -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroCntBotoes = $false
            }
        }

        # Detectar .Left = <numero != 542> dentro do WITH cnt_4c_Botoes
        if ($dentroCntBotoes -and $linha -match '(?i)^(\s*\.Left\s*=\s*)(\d+)\s*$') {
            $indent = $Matches[1]
            $valor = [int]$Matches[2]
            if ($valor -ne 542) {
                $nova = "$indent 542"
                Add-Correcao -Tipo "CNT-BOTOES-LEFT-542" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cnt_4c_Botoes.Left=$valor -> 542 (padrao canonico form 1000px)"
                $resultado += $nova
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PagePictureFrmCadastro {
    param([string[]]$Linhas, [string]$Arquivo)

    # So aplica em forms frmcadastro (pasta cadastros\ no path)
    if ($Arquivo -notmatch '(?i)\\forms\\cadastros\\') {
        return $Linhas
    }

    $resultado = New-Object System.Collections.ArrayList
    $dentroPageFrame = $false
    $contadorEndWith = 0
    $page1PictureInserido = $false
    $page2PictureInserido = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            [void]$resultado.Add($linha)
            continue
        }

        # Entrando em WITH THIS.pgf_4c_Paginas
        if ($linha -match '(?i)^\s*WITH\s+THIS\.pgf_4c_Paginas\s*$') {
            $dentroPageFrame = $true
            $contadorEndWith = 1
            [void]$resultado.Add($linha)
            continue
        }

        if ($dentroPageFrame -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }
        if ($dentroPageFrame -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroPageFrame = $false
            }
        }

        # Detectar .Page1.Caption = ... e injetar .Page1.Picture logo apos (se nao existir)
        if ($dentroPageFrame -and $linha -match '(?i)^(\s*)\.Page1\.Caption\s*=') {
            [void]$resultado.Add($linha)
            # Verificar se Page1.Picture ja existe nas proximas ~5 linhas
            $temPicture = $false
            for ($j = $i+1; $j -lt [Math]::Min($i+6, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)^\s*\.Page1\.Picture\s*=') {
                    $temPicture = $true
                    break
                }
            }
            if (-not $temPicture -and -not $page1PictureInserido) {
                $indent = $Matches[1]
                $novaLinha = "$indent.Page1.Picture   = gc_4c_CaminhoIcones + `"fundo_cad_1003.jpg`""
                [void]$resultado.Add($novaLinha)
                Add-Correcao -Tipo "PAGE-PICTURE-FRMCADASTRO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "injetado .Page1.Picture = fundo_cad_1003.jpg apos .Page1.Caption"
                $page1PictureInserido = $true
            }
            continue
        }

        if ($dentroPageFrame -and $linha -match '(?i)^(\s*)\.Page2\.Caption\s*=') {
            [void]$resultado.Add($linha)
            $temPicture = $false
            for ($j = $i+1; $j -lt [Math]::Min($i+6, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)^\s*\.Page2\.Picture\s*=') {
                    $temPicture = $true
                    break
                }
            }
            if (-not $temPicture -and -not $page2PictureInserido) {
                $indent = $Matches[1]
                $novaLinha = "$indent.Page2.Picture   = gc_4c_CaminhoIcones + `"fundo_cad_1003.jpg`""
                [void]$resultado.Add($novaLinha)
                Add-Correcao -Tipo "PAGE-PICTURE-FRMCADASTRO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "injetado .Page2.Picture = fundo_cad_1003.jpg apos .Page2.Caption"
                $page2PictureInserido = $true
            }
            continue
        }

        [void]$resultado.Add($linha)
    }

    return ,$resultado.ToArray()
}

function Corrigir-HeaderWidthTotal {
    param([string[]]$Linhas)

    # Detecta cnt_4c_Sombra ou cnt_4c_Cabecalho com .Width = THIS.Width - <N> ou .Width = <numero menor que 1000>
    # Normaliza para .Width = THIS.Width
    $resultado = @()
    $dentroHeader = $false
    $contadorEndWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Entrando em AddObject de cnt_4c_Sombra ou cnt_4c_Cabecalho
        if ($linha -match '(?i)AddObject\s*\(\s*"(cnt_4c_Sombra|cnt_4c_Cabecalho)"\s*,\s*"Container"\s*\)') {
            $dentroHeader = $true
            $contadorEndWith = 0
        }

        if ($dentroHeader -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWith++
        }
        if ($dentroHeader -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWith--
            if ($contadorEndWith -le 0) {
                $dentroHeader = $false
            }
        }

        # Caso 1: .Width = THIS.Width - <N>
        if ($dentroHeader -and $linha -match '(?i)^(\s*\.Width\s*=\s*)THIS\.Width\s*-\s*\d+\s*$') {
            $nova = $Matches[1] + 'THIS.Width'
            Add-Correcao -Tipo "HEADER-WIDTH-TOTAL" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cnt_4c_Sombra/Cabecalho.Width='THIS.Width - N' -> 'THIS.Width' (cobre faixa atras do cnt_4c_Saida)"
            $resultado += $nova
            continue
        }

        # Caso 2: .Width = <numero literal menor que 1000>
        if ($dentroHeader -and $linha -match '(?i)^(\s*\.Width\s*=\s*)(\d+)\s*$') {
            $indent = $Matches[1]
            $valor = [int]$Matches[2]
            if ($valor -lt 1000) {
                $nova = "$indent`THIS.Width"
                Add-Correcao -Tipo "HEADER-WIDTH-TOTAL" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cnt_4c_Sombra/Cabecalho.Width=$valor -> THIS.Width (cobre faixa atras do cnt_4c_Saida)"
                $resultado += $nova
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-MostrarErroParaMsgAviso {
    param([string[]]$Linhas)

    # Detecta MostrarErro(..msg..) / MsgErro(..msg..) cuja mensagem e' validacao de UI
    # (inclui mensagens concatenadas via CHR(225)/CHR(227)/CHR(231)/CHR(243) para acentos
    # — convencao do projeto). Substitui por MsgAviso(...).
    $resultado = @()

    # Heuristica POSITIVA: marcadores de validacao UI (literal OR CHR-encoded accents)
    $markersValidacao = @(
        '(?i)"\s*(Selecione|Informe|Escolha|Digite|Preencha|Nenhum)\b',
        '(?i)"\s*Valor\b',
        '(?i)"\s*Campo\b',
        '(?i)"\s*Inv[^"]*"',
        '(?i)"\s*inv[^"]*"',
        '(?i)"\s*obrigat[^"]*"',
        '(?i)"\s*J[^"]*cadastrad',
        '(?i)"\s*Aten[^"]*"',
        '(?i)"Inv"\s*\+\s*CHR\(225\)',
        '(?i)"inv"\s*\+\s*CHR\(225\)',
        '(?i)"obrigat"\s*\+\s*CHR\(243\)',
        '(?i)"Sele"\s*\+\s*CHR\(231\)',
        '(?i)"Aten"\s*\+\s*CHR\(231\)',
        '(?i)"n"\s*\+\s*CHR\(227\)\s*\+\s*"o\s+selec',
        '(?i)"n"\s*\+\s*CHR\(227\)\s*\+\s*"o\s+encontrad',
        '(?i)"C"\s*\+\s*CHR\(243\)\s*\+\s*"digo'
    )

    # Heuristica NEGATIVA: NAO trocar se for exception tecnica
    $markersErroTecnico = @(
        'loException\.Message',
        'CapturarErroSQL',
        '(?i)"Erro\s+ao\s+\w+:',
        '(?i)"Falha\s+ao',
        '(?i)"Connectivity\s+error'
    )

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Padrao amplo: captura EVERYTHING entre MostrarErro(/MsgErro( e o ) final da linha
        # (funciona para chamadas single-line incluindo concatenacao via CHR())
        $pattern = '(?i)(MostrarErro|MsgErro)\s*\((.*)\)'
        $m = [regex]::Match($linha, $pattern)
        if ($m.Success) {
            $fullArgs = $m.Groups[2].Value

            # Negativa tem prioridade: erro tecnico NAO vira MsgAviso
            $ehErroTecnico = $false
            foreach ($marker in $markersErroTecnico) {
                if ($linha -match $marker) { $ehErroTecnico = $true; break }
            }

            if (-not $ehErroTecnico) {
                $ehValidacao = $false
                foreach ($marker in $markersValidacao) {
                    if ($fullArgs -match $marker) { $ehValidacao = $true; break }
                }

                if ($ehValidacao) {
                    # Dropar segundo arg (titulo) se existir como ', "<literal>"' no final
                    $novaCall = $fullArgs
                    if ($novaCall -match '^(.+?),\s*"[^"]*"\s*$') {
                        $novaCall = $Matches[1]
                    }
                    $novaLinha = $linha -replace '(?i)(MostrarErro|MsgErro)\s*\(.*\)', "MsgAviso($novaCall)"
                    Add-Correcao -Tipo "MOSTRARERRO-MSGAVISO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "validacao UI deve usar MsgAviso (heuristica CHR-aware)"
                    $resultado += $novaLinha
                    continue
                }
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-GridColumnCountAntesRecordSource {
    param([string[]]$Linhas)

    # Detecta: <grid>.RecordSource = "cursor_..." sem <grid>.ColumnCount = N
    # na linha imediatamente anterior. Injeta ColumnCount com base no numero
    # de .ColumnN.ControlSource distintos nas proximas ~15 linhas.
    # Evita que Grid auto-expanda para TODAS as colunas do cursor.

    $resultado = New-Object System.Collections.ArrayList

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            [void]$resultado.Add($linha)
            continue
        }

        # Detectar: <ref>.RecordSource = "cursor_..."
        if ($linha -match '(?i)^(\s*)([a-zA-Z_][\w\.]*)\.RecordSource\s*=\s*"cursor_\w+"\s*$') {
            $indent = $Matches[1]
            $gridRef = $Matches[2]

            # Ja tem .ColumnCount = N na linha anterior?
            $temColumnCount = $false
            if ($i -gt 0) {
                $linhaAnterior = $Linhas[$i - 1]
                if ($linhaAnterior -match "(?i)^\s*$([regex]::Escape($gridRef))\.ColumnCount\s*=\s*\d+\s*$") {
                    $temColumnCount = $true
                }
            }

            if (-not $temColumnCount) {
                # Contar .ColumnN.ControlSource distintos nas proximas 15 linhas
                $colunasDistintas = @{}
                for ($j = $i+1; $j -lt [Math]::Min($i+16, $Linhas.Count); $j++) {
                    $lj = $Linhas[$j]
                    if ($lj -match "(?i)^\s*$([regex]::Escape($gridRef))\.Column(\d+)\.ControlSource\s*=") {
                        $colunasDistintas[[int]$Matches[1]] = $true
                    }
                }
                $totalColunas = $colunasDistintas.Count
                if ($totalColunas -lt 1) { $totalColunas = 3 }  # fallback

                $novaLinha = "$indent$gridRef.ColumnCount = $totalColunas"
                [void]$resultado.Add($novaLinha)
                Add-Correcao -Tipo "GRID-COLUMNCOUNT-ANTES-RECORDSOURCE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Injetado $gridRef.ColumnCount = $totalColunas antes de RecordSource (evita auto-bind de colunas extras do cursor)"
            }
        }

        [void]$resultado.Add($linha)
    }

    return ,$resultado.ToArray()
}

function Corrigir-LocPaginaPictureAusente {
    param([string[]]$Linhas, [string]$Arquivo)

    # So aplica em forms frmcadastro (pasta cadastros\)
    if ($Arquivo -notmatch '(?i)\\forms\\cadastros\\') {
        return $Linhas
    }

    $resultado = New-Object System.Collections.ArrayList
    $dentroMetodo = $false
    $aguardandoLocOPagina = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            [void]$resultado.Add($linha)
            continue
        }

        # Detectar entrada em PROCEDURE ConfigurarPagina*
        if ($linha -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+ConfigurarPagina\w*\s*\(') {
            $dentroMetodo = $true
            $aguardandoLocOPagina = $true
            [void]$resultado.Add($linha)
            continue
        }

        # Saindo do metodo (ENDPROC)
        if ($dentroMetodo -and $linha -match '(?i)^\s*ENDPROC\b') {
            $dentroMetodo = $false
            $aguardandoLocOPagina = $false
            [void]$resultado.Add($linha)
            continue
        }

        if ($dentroMetodo -and $aguardandoLocOPagina) {
            # Detectar: loc_oPagina = THIS.pgf_4c_Paginas.Page[12]
            if ($linha -match '(?i)^(\s*)loc_oPagina\s*=\s*THIS\.pgf_4c_Paginas\.Page\d') {
                $indent = $Matches[1]
                [void]$resultado.Add($linha)

                # Verificar se ja existe loc_oPagina.Picture nas proximas ~15 linhas
                $temPicture = $false
                for ($j = $i+1; $j -lt [Math]::Min($i+15, $Linhas.Count); $j++) {
                    $lj = $Linhas[$j]
                    if ($lj -match '(?i)^\s*loc_oPagina\.Picture\s*=') {
                        $temPicture = $true
                        break
                    }
                    if ($lj -match '(?i)AddObject\s*\(') {
                        break
                    }
                    if ($lj -match '(?i)^\s*ENDPROC\b') {
                        break
                    }
                }

                if (-not $temPicture) {
                    # Por seguranca, usa gc_4c_CaminhoIcones (global, sempre disponivel)
                    $refVar = 'gc_4c_CaminhoIcones'
                    [void]$resultado.Add('')
                    [void]$resultado.Add($indent + '*-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)')
                    [void]$resultado.Add($indent + 'loc_oPagina.Picture = ' + $refVar + ' + "fundo_cad_1003.jpg"')
                    Add-Correcao -Tipo "LOC-OPAGINA-PICTURE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Injetado loc_oPagina.Picture = fundo_cad_1003.jpg em ConfigurarPagina* (sem isso a pagina fica branca)"
                }

                $aguardandoLocOPagina = $false
                continue
            }
        }

        [void]$resultado.Add($linha)
    }

    return ,$resultado.ToArray()
}

function Corrigir-CntSaidaEncerrarCanonico {
    param([string[]]$Linhas)

    # Normaliza cnt_4c_Saida (Left=917, Width=90) e cmd_4c_Encerrar dentro dele
    # (Width=75, Height=75) para padrao canonico FormCor.
    # Reforca lesson #86 — task018/019/020 repetiram os valores errados mesmo
    # com regra nos prompts, entao auto-fix garante consistencia.

    $resultado = @()
    $dentroCntSaida = $false
    $dentroEncerrar = $false
    $contadorEndWithSaida = 0
    $contadorEndWithEncerrar = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar entrada em AddObject("cnt_4c_Saida", "Container")
        if ($linha -match '(?i)AddObject\s*\(\s*"cnt_4c_Saida"\s*,\s*"Container"\s*\)') {
            $dentroCntSaida = $true
            $contadorEndWithSaida = 0
            $resultado += $linha
            continue
        }

        # Detectar entrada em AddObject("cmd_4c_Encerrar", "CommandButton")
        # (pode estar dentro do escopo do cnt_4c_Saida OU em outro container)
        if ($linha -match '(?i)AddObject\s*\(\s*"cmd_4c_Encerrar"\s*,\s*"CommandButton"\s*\)') {
            $dentroEncerrar = $true
            $contadorEndWithEncerrar = 0
            $resultado += $linha
            continue
        }

        # Tracking WITH/ENDWITH para cnt_4c_Saida
        if ($dentroCntSaida -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWithSaida++
        }
        if ($dentroCntSaida -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWithSaida--
            if ($contadorEndWithSaida -le 0) {
                $dentroCntSaida = $false
            }
        }

        # Tracking WITH/ENDWITH para cmd_4c_Encerrar
        if ($dentroEncerrar -and $linha -match '(?i)^\s*WITH\b') {
            $contadorEndWithEncerrar++
        }
        if ($dentroEncerrar -and $linha -match '(?i)^\s*ENDWITH\b') {
            $contadorEndWithEncerrar--
            if ($contadorEndWithEncerrar -le 0) {
                $dentroEncerrar = $false
            }
        }

        # Dentro do WITH cnt_4c_Saida: normalizar .Left = N e .Width = N
        if ($dentroCntSaida) {
            # .Left = <expressao qualquer> -> 917
            if ($linha -match '(?i)^(\s*\.Left\s*=\s*).+$') {
                $indent = $Matches[1]
                $restoLinha = $linha.Substring($indent.Length).TrimEnd()
                # Se ja eh 917, nao mexer
                if ($restoLinha -ne '917') {
                    $novaLinha = $indent + '917'
                    Add-Correcao -Tipo "CNT-SAIDA-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cnt_4c_Saida.Left normalizado para 917 (padrao FormCor)"
                    $resultado += $novaLinha
                    continue
                }
            }
            # .Width = N -> 90 (se != 90)
            if ($linha -match '(?i)^(\s*\.Width\s*=\s*)(\d+)\s*$') {
                $indent = $Matches[1]
                $valor = [int]$Matches[2]
                if ($valor -ne 90) {
                    $novaLinha = "${indent}90"
                    Add-Correcao -Tipo "CNT-SAIDA-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cnt_4c_Saida.Width=$valor -> 90 (padrao FormCor)"
                    $resultado += $novaLinha
                    continue
                }
            }
        }

        # Dentro do WITH cmd_4c_Encerrar: normalizar .Width e .Height
        if ($dentroEncerrar) {
            # .Width = N -> 75 (se != 75)
            if ($linha -match '(?i)^(\s*\.Width\s*=\s*)(\d+)\s*$') {
                $indent = $Matches[1]
                $valor = [int]$Matches[2]
                if ($valor -ne 75) {
                    $novaLinha = "${indent}75"
                    Add-Correcao -Tipo "ENCERRAR-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cmd_4c_Encerrar.Width=$valor -> 75 (padrao FormCor)"
                    $resultado += $novaLinha
                    continue
                }
            }
            # .Height = N -> 75 (se != 75)
            if ($linha -match '(?i)^(\s*\.Height\s*=\s*)(\d+)\s*$') {
                $indent = $Matches[1]
                $valor = [int]$Matches[2]
                if ($valor -ne 75) {
                    $novaLinha = "${indent}75"
                    Add-Correcao -Tipo "ENCERRAR-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "cmd_4c_Encerrar.Height=$valor -> 75 (padrao FormCor)"
                    $resultado += $novaLinha
                    continue
                }
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #87: .Width = THIS.Width - 60/-65 em Page container deixa faixa visivel
# =============================================================================
# task018/019/021 geraram containers-base da Page com Width=THIS.Width-60
# para "evitar sobrepor cnt_4c_Saida", mas o container de saida eh flutuante
# sobre a Page (BackStyle=0) entao a subtracao so deixa uma faixa clara
# expondo o fundo do form. Padrao canonico: Width=THIS.Width (ocupa toda).
function Corrigir-PageWidthStripMinus60 {
    param([string[]]$Linhas)

    # Safety: so aplica em forms CRUD (tem cnt_4c_Saida ou herda de FormBase)
    $conteudo = $Linhas -join "`n"
    $ehCRUD = ($conteudo -match '(?i)cnt_4c_Saida|AS\s+FormBase')
    if (-not $ehCRUD) { return $Linhas }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # .Width = THIS.Width - <N> onde N in {60,65,70}
        if ($linha -match '(?i)^(\s*\.Width\s*=\s*)THIS\.Width\s*-\s*(\d+)\s*$') {
            $indent = $Matches[1]
            $subtracao = [int]$Matches[2]
            if ($subtracao -ge 50 -and $subtracao -le 80) {
                $nova = "${indent}THIS.Width"
                Add-Correcao -Tipo "PAGE-WIDTH-STRIP" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao ".Width = THIS.Width - $subtracao -> THIS.Width (container flutuante de saida nao precisa deduzir largura; deixava faixa clara exposta)"
                $resultado += $nova
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #88: Botoes de saida genericos (Sair/Fechar/Cancelar/X) -> Encerrar canonico
# =============================================================================
# Complementa Corrigir-CntSaidaEncerrarCanonico (que so trata cnt_4c_Saida exato).
# Detecta CommandButton cujo nome sugere saida (cmd_4c_Sair/Fechar/Cancelar/X) em
# form CRUD e normaliza para Caption="Encerrar", Width=75, Height=75. Mantem nome
# do objeto (pois outros pontos do form podem referenciar o nome original).
function Corrigir-BotaoSaidaCanonico {
    param([string[]]$Linhas, [string]$Arquivo = "")

    # SAFETY GUARD (2026-07-02): pattern eh CRUD-canonico. NAO aplicar em classes
    # utilitarias (FormBuscaAuxiliar tem cmd_4c_Cancelar como Cancelar, W=64, nao Encerrar W=75).
    if ($Arquivo -match '(?i)\\classes\\') {
        return $Linhas
    }

    # Safety: so aplica em forms CRUD
    $conteudo = $Linhas -join "`n"
    $ehCRUD = ($conteudo -match '(?i)cnt_4c_Saida|AS\s+FormBase|frmcadastro')
    if (-not $ehCRUD) { return $Linhas }

    $resultado = @()
    $dentroBotaoSaida = $false
    $contadorWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar AddObject("cmd_4c_<Sair|Fechar|Cancelar|X>", "CommandButton")
        # (cmd_4c_Encerrar ja eh tratado em Corrigir-CntSaidaEncerrarCanonico)
        if ($linha -match '(?i)AddObject\s*\(\s*"(cmd_4c_(?:Sair|Fechar|Cancelar|X|Saida))"\s*,\s*"CommandButton"\s*\)') {
            $dentroBotaoSaida = $true
            $contadorWith = 0
            $resultado += $linha
            continue
        }

        if ($dentroBotaoSaida) {
            if ($linha -match '(?i)^\s*WITH\b')    { $contadorWith++ }
            if ($linha -match '(?i)^\s*ENDWITH\b') { $contadorWith--; if ($contadorWith -le 0) { $dentroBotaoSaida = $false } }

            # .Caption = "X"/"Sair"/"Fechar"/"Cancelar" -> "Encerrar"
            if ($linha -match '(?i)^(\s*\.Caption\s*=\s*)"(X|Sair|Fechar|Cancelar)"\s*$') {
                $indent = $Matches[1]
                $capOrig = $Matches[2]
                $nova = "${indent}""Encerrar"""
                Add-Correcao -Tipo "BOTAO-SAIDA-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Caption=""$capOrig"" -> ""Encerrar"" (padrao canonico CRUD)"
                $resultado += $nova
                continue
            }
            # .Width = N -> 75
            if ($linha -match '(?i)^(\s*\.Width\s*=\s*)(\d+)\s*$') {
                $indent = $Matches[1]
                $valor = [int]$Matches[2]
                if ($valor -ne 75) {
                    Add-Correcao -Tipo "BOTAO-SAIDA-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Botao de saida Width=$valor -> 75"
                    $resultado += "${indent}75"
                    continue
                }
            }
            # .Height = N -> 75
            if ($linha -match '(?i)^(\s*\.Height\s*=\s*)(\d+)\s*$') {
                $indent = $Matches[1]
                $valor = [int]$Matches[2]
                if ($valor -ne 75) {
                    Add-Correcao -Tipo "BOTAO-SAIDA-CANONICO" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Botao de saida Height=$valor -> 75"
                    $resultado += "${indent}75"
                    continue
                }
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #90: MostrarAviso(...) NAO EXISTE -> MsgAviso(...)
# =============================================================================
# Gerador inventou MostrarAviso por analogia com MostrarErro (que existe em
# FormErro.prg). Mas MostrarAviso nao existe em lugar nenhum do projeto.
# Funcao correta para validacao de UI: MsgAviso(...) (messages.prg).
# Runtime error: "File 'mostraraviso.prg' does not exist" (VFP9 procura .prg
# externo quando nome nao eh encontrado).
# Substituicao direta (sem heuristica) porque MostrarAviso NUNCA eh valido.
function Corrigir-MostrarAvisoInexistente {
    param([string[]]$Linhas)

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        if ($linha -match '(?i)\bMostrarAviso\s*\(') {
            $nova = $linha -replace '(?i)\bMostrarAviso\s*\(', 'MsgAviso('
            Add-Correcao -Tipo "MOSTRARAVISO-INEXISTENTE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "MostrarAviso(...) -> MsgAviso(...). Funcao MostrarAviso NAO existe (gerador inventou por analogia com MostrarErro)."
            $resultado += $nova
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #91: SQLEXEC em cursor existente sem fechar antes (uncommitted changes)
# =============================================================================
# Em BO.Buscar / BO.CarregarPorCodigo, se SQLEXEC usa alias de cursor que o
# form ja criou como placeholder do grid (cursor_4c_Dados, cursor_4c_Lista),
# VFP9 falha com "Table buffer for alias X contains uncommitted changes" porque
# o cursor anterior pode ter edicoes pendentes via grid.
# Fix: injetar USED()+TABLEREVERT+USE IN antes do SQLEXEC.
function Corrigir-SQLExecCursorGuard {
    param([string[]]$Linhas)

    # So aplica em BOs (tem FUNCTION Buscar OU FUNCTION CarregarPorCodigo)
    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)FUNCTION\s+(Buscar|CarregarPorCodigo)\b') {
        return $Linhas
    }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Detectar SQLEXEC(..., <sql>, "<cursor_4c_Xxx>")
        if ($linha -match '(?i)SQLEXEC\s*\([^,]+,[^,]+,\s*"(cursor_4c_\w+)"\s*\)') {
            $cursorNome = $Matches[1]

            # Verificar se nas linhas anteriores (ate 10) ja existe guard para este cursor
            $temGuard = $false
            for ($j = [Math]::Max(0, $i - 10); $j -lt $i; $j++) {
                if ($Linhas[$j] -match "(?i)USED\s*\(\s*`"$cursorNome`"\s*\)" -and $Linhas[$j+1] -match "(?i)TABLEREVERT|USE\s+IN") {
                    $temGuard = $true
                    break
                }
                if ($Linhas[$j] -match "(?i)USE\s+IN\s+$cursorNome\b") {
                    $temGuard = $true
                    break
                }
            }

            if (-not $temGuard) {
                # Detectar indentacao da linha do SQLEXEC
                $indent = ''
                if ($linha -match '^(\s*)') { $indent = $Matches[1] }

                # Injetar guard antes
                $resultado += "${indent}*-- Fechar cursor anterior se existir (evita `"Table buffer contains uncommitted changes`")"
                $resultado += "${indent}IF USED(`"$cursorNome`")"
                $resultado += "${indent}    TABLEREVERT(.T., `"$cursorNome`")"
                $resultado += "${indent}    USE IN $cursorNome"
                $resultado += "${indent}ENDIF"
                $resultado += ""
                Add-Correcao -Tipo "SQLEXEC-CURSOR-GUARD" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Injetado guard USED/TABLEREVERT/USE IN antes de SQLEXEC em '$cursorNome' (evita `"Table buffer contains uncommitted changes`" quando form usa o cursor como RecordSource do grid)."
            }

            $resultado += $linha
            continue
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PemstatusCursorParaType {
    param([string[]]$Linhas)

    # Detecta PEMSTATUS com alias de cursor (heuristica):
    # 1. PEMSTATUS((<var>), "<campo>", 5)  -- forma com parenteses extras (typica em CarregarDoCursor)
    # 2. PEMSTATUS(<var>, "<campo>", 5)    -- forma sem parenteses, onde <var> comeca com par_c/loc_cAlias/etc. (nome sugestivo de cursor)
    # Troca por: TYPE(<var> + ".<campo>") != "U"
    # Falso positivo evitado: se <var> eh "THIS.<obj>" ou similar, nao troca.

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        # Forma 1: PEMSTATUS((<var>), "<campo>", 5) -- parenteses extras = forte indicacao de cursor alias
        $patternForma1 = '(?i)PEMSTATUS\s*\(\s*\(\s*([a-zA-Z_][\w]*)\s*\)\s*,\s*"([^"]+)"\s*,\s*5\s*\)'
        if ($linha -match $patternForma1) {
            $novaLinha = [regex]::Replace($linha, $patternForma1, {
                param($m)
                "TYPE(" + $m.Groups[1].Value + " + `".$($m.Groups[2].Value)`") != `"U`""
            })
            if ($novaLinha -ne $linha) {
                Add-Correcao -Tipo "PEMSTATUS-CURSOR-PARA-TYPE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "PEMSTATUS((alias), 'campo', 5) -> TYPE(alias + '.campo') != 'U' (PEMSTATUS nao aceita cursor)"
                $resultado += $novaLinha
                continue
            }
        }

        # Forma 2: PEMSTATUS(<var>, "<campo>", 5) onde <var> eh nome sugestivo de cursor
        # Heuristica: var comeca com par_c, ou contem Alias/alias/Cursor/cursor
        $patternForma2 = '(?i)PEMSTATUS\s*\(\s*([a-zA-Z_][\w]*)\s*,\s*"([^"]+)"\s*,\s*5\s*\)'
        $m2 = [regex]::Match($linha, $patternForma2)
        if ($m2.Success) {
            $varNome = $m2.Groups[1].Value
            # Exclui THIS e formas obj.prop (ja tratado por nao match)
            $ehCursor = $false
            if ($varNome -match '(?i)^par_c[A-Z]') { $ehCursor = $true }
            if ($varNome -match '(?i)(Alias|alias|Cursor|cursor)') { $ehCursor = $true }

            if ($ehCursor) {
                $novaLinha = $linha -replace $patternForma2, "TYPE($($m2.Groups[1].Value) + `".$($m2.Groups[2].Value)`") != `"U`""
                Add-Correcao -Tipo "PEMSTATUS-CURSOR-PARA-TYPE" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "PEMSTATUS($varNome, 'campo', 5) onde $varNome sugere cursor -> TYPE(...)"
                $resultado += $novaLinha
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-CntSombraGrayColor {
    <#
    .SYNOPSIS
    Atualiza BackColor de cnt_4c_Cabecalho/cnt_4c_Sombra de RGB(53,53,53) para RGB(100,100,100)

    .DESCRIPTION
    O cntSombra do framework.vcx (cabecalho cinza dos forms CRUD/REPORT/OPERACIONAL)
    tem `BackColor=RGB(100,100,100)` (cinza medio). Migracoes geravam RGB(53,53,53)
    (quase preto) por engano. Esta correcao detecta a cor errada dentro de WITH/AddObject
    de cnt_4c_Cabecalho ou cnt_4c_Sombra e substitui pela correta.

    SCOPE LIMITADO: so substitui se a linha estiver em uma janela de +/-10 linhas
    em torno de uma referencia a "cnt_4c_Cabecalho" ou "cnt_4c_Sombra" (para evitar
    afetar outros containers que possam ter cor diferente intencional).

    Bug observado system-wide em 2026-05-15.
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $janela = 10

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        if ($linha -match '\.BackColor\s*=\s*RGB\(\s*53\s*,\s*53\s*,\s*53\s*\)') {
            $temContextoSombra = $false
            $iniBusca = [Math]::Max(0, $i - $janela)
            $fimBusca = [Math]::Min($Linhas.Count - 1, $i + $janela)
            for ($j = $iniBusca; $j -le $fimBusca; $j++) {
                if ($Linhas[$j] -match 'cnt_4c_(Cabecalho|Sombra)') {
                    $temContextoSombra = $true
                    break
                }
            }

            if ($temContextoSombra) {
                $linha = $linha -replace 'RGB\(\s*53\s*,\s*53\s*,\s*53\s*\)', 'RGB(100, 100, 100)'
                Add-Correcao -Tipo "CNT-SOMBRA-GRAY-COLOR" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "cnt_4c_Cabecalho/Sombra BackColor RGB(53,53,53) (errado/quase-preto) -> RGB(100,100,100) (cinza medio do framework cntSombra)"
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-PicturePositionReport {
    <#
    .SYNOPSIS
    Botoes de relatorio com PicturePosition=1 (icon-LEFT) -> 13 (icon-ABOVE)

    .DESCRIPTION
    Em forms REPORT (frmrelatorio), os 4 botoes do CommandGroup btnReport
    (Visualizar/Imprimir/DocExcel/Sair) devem ter PicturePosition=13
    (icone acima do caption, centralizado). Migracoes geram .PicturePosition=1
    porque esse e o valor no SCX legado, mas em VFP9 isso significa
    icon-LEFT-of-text, causando captions truncadas quando Width<75.

    Detecta: linha com `.PicturePosition = 1` IMEDIATAMENTE precedida ou seguida
    por outra linha que contenha `gc_4c_CaminhoIcones + "relatorio_*` ou
    `gc_4c_CaminhoIcones + "geral_email` (icones de report buttons).

    SCOPE LIMITADO para evitar falsos positivos: so substitui se houver
    evidencia explicita de botao de relatorio (Picture com prefixo relatorio_).
    Bug observado em task023/SIGREVIS + task024/sigrevto (2026-05-15).
    #>
    param([string[]]$Linhas)

    $resultado = @()
    $janela = 4   # buscar Picture em +/- 4 linhas em torno do PicturePosition

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaOriginal = $linha

        if ($linha -match '^(\s*)\.PicturePosition\s*=\s*1\s*(\&\&.*)?$') {
            $indent = $matches[1]

            # Buscar Picture de relatorio em janela
            $temIconReport = $false
            $iniBusca = [Math]::Max(0, $i - $janela)
            $fimBusca = [Math]::Min($Linhas.Count - 1, $i + $janela)
            for ($j = $iniBusca; $j -le $fimBusca; $j++) {
                if ($Linhas[$j] -match '\.Picture\s*=\s*gc_4c_CaminhoIcones\s*\+\s*"(relatorio_|geral_email)') {
                    $temIconReport = $true
                    break
                }
            }

            if ($temIconReport) {
                $linha = "$indent.PicturePosition = 13"
                Add-Correcao -Tipo "PICTUREPOSITION-REPORT" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "PicturePosition=1 (icon-LEFT) em botao de relatorio -> 13 (icon-ABOVE)"
            }
        }

        $resultado += $linha
    }

    return $resultado
}

function Corrigir-LookupKeyPressExpand {
    param([string[]]$Linhas)

    # Fase 1: identificar PROCEDUREs que criam FormBuscaAuxiliar OU chamam AbrirLookup*
    # (sao os handlers de lookup onde = 115 precisa ser expandido)
    $procLookup = @{}
    $procAtual = $null
    $linhaProcAtual = -1
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)^\s*PROCEDURE\s+(\w+)') {
            $procAtual = $Matches[1]
            $linhaProcAtual = $i
        }
        if ($procAtual -and $l -match '(?i)^\s*ENDPROC\b') {
            $procAtual = $null
        }
        if ($procAtual -and ($l -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"' -or $l -match '(?i)THIS\.AbrirLookup\w+\s*\(')) {
            $procLookup[$procAtual] = $true
        }
    }

    if ($procLookup.Count -eq 0) { return $Linhas }

    # Fase 2: para cada proc de lookup, expandir `IF par_nKeyCode = 115` em `IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115`
    $resultado = @()
    $procAtual = $null
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        if ($linha -match '(?i)^\s*(\*|&&)') {
            $resultado += $linha
            continue
        }

        if ($linha -match '(?i)^\s*PROCEDURE\s+(\w+)') {
            $procAtual = $Matches[1]
        }
        if ($linha -match '(?i)^\s*ENDPROC\b') {
            $procAtual = $null
        }

        # Dentro de um handler de lookup: expandir "IF par_nKeyCode = 115"
        if ($procAtual -and $procLookup.ContainsKey($procAtual)) {
            if ($linha -match '^(\s*)IF\s+par_nKeyCode\s*=\s*115\s*$') {
                $indent = $Matches[1]
                $novaLinha = $indent + 'IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115'
                Add-Correcao -Tipo "LOOKUP-KEYPRESS-EXPAND" -Linha ($i+1) -Original "(auto-fix)" -Corrigido "(auto-fix)" -Descricao "Handler de lookup $procAtual expandido para ENTER(13)/TAB(9)/F4(115)"
                $resultado += $novaLinha
                continue
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #95: Forms com DataSession=2 precisam que Init() chame DODEFAULT()
# para herdar SET DATE TO BRITISH / SET CENTURY ON do FormBase.Init().
# Sem DODEFAULT(), datasession privada mantem defaults VFP (AMERICAN/CENTURY OFF)
# e datas exibem como "05/25/26" em vez de "25/05/2026".
# =============================================================================
function Corrigir-InitFormSemDodefault {
    <#
    .SYNOPSIS
    Detecta forms (DEFINE CLASS ... AS FormBase) com DataSession=2 e PROCEDURE Init()
    que NAO chama DODEFAULT() - insere DODEFAULT() no inicio do corpo.
    #>
    param([string[]]$Linhas)

    # Fase 1: detectar se este arquivo eh um form que herda de FormBase E tem DataSession=2
    $herdaFormBase = $false
    $temDataSession2 = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)^\s*DEFINE\s+CLASS\s+\w+\s+AS\s+FormBase\b') {
            $herdaFormBase = $true
        }
        if ($l -match '(?i)^\s*DataSession\s*=\s*2\b') {
            $temDataSession2 = $true
        }
    }

    if (-not ($herdaFormBase -and $temDataSession2)) {
        return $Linhas
    }

    # Fase 2: localizar PROCEDURE Init() e verificar se tem DODEFAULT()
    $linhaProcInit = -1
    $linhaEndprocInit = -1
    $dentroInit = $false
    $temDodefault = $false

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]

        # Detecta PROCEDURE Init (com ou sem parenteses)
        if (-not $dentroInit -and $l -match '(?i)^\s*PROCEDURE\s+Init\s*\(?\s*\)?\s*$') {
            $dentroInit = $true
            $linhaProcInit = $i
            continue
        }

        if ($dentroInit) {
            # Verifica chamada a DODEFAULT (com ou sem parenteses, com ou sem RETURN)
            if ($l -match '(?i)\bDODEFAULT\s*\(?\s*\)?') {
                $temDodefault = $true
            }

            if ($l -match '(?i)^\s*ENDPROC\b') {
                $linhaEndprocInit = $i
                break
            }
        }
    }

    # Se nao existe Init() ou ja tem DODEFAULT(), nao precisa corrigir
    if ($linhaProcInit -lt 0 -or $temDodefault) {
        return $Linhas
    }

    # Fase 3: inserir DODEFAULT() logo apos a linha PROCEDURE Init()
    # Detecta indentacao usando proxima linha nao-vazia dentro do Init
    $indent = "        "
    for ($j = $linhaProcInit + 1; $j -lt $linhaEndprocInit; $j++) {
        if ($Linhas[$j] -match '^(\s+)\S') {
            $indent = $Matches[1]
            break
        }
    }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $resultado += $Linhas[$i]
        if ($i -eq $linhaProcInit) {
            $resultado += "${indent}DODEFAULT()  && Garante SET DATE TO BRITISH/SET CENTURY ON do FormBase em datasession privada"
            Add-Correcao -Tipo "INIT_SEM_DODEFAULT" -Linha ($linhaProcInit + 2) -Original "PROCEDURE Init() sem DODEFAULT()" -Corrigido "DODEFAULT() adicionado" -Descricao "Form com DataSession=2 sem DODEFAULT() em Init() - SET DATE/CENTURY do FormBase nao seria herdado, datas exibem como MM/DD/YY (Pattern #95)"
        }
    }

    return $resultado
}

# =============================================================================
# Pattern #96: Substitui Picture com nomes de arquivo inexistentes em vbmp/
# pelos icones canonicos de forms REPORT. Tambem padroniza gc_4c_Icones ->
# gc_4c_CaminhoIcones. Bug observado em Formsigatcrp.prg (2026-06-25).
# =============================================================================
function Corrigir-PictureReportIconesInexistentes {
    param([string[]]$Linhas)

    $substituicoes = [ordered]@{
        'geral_visualizar_60\.jpg' = 'relatorio_video_26.jpg'
        'geral_imprimir_60\.jpg'   = 'relatorio_impressora_26.jpg'
        'geral_excel_60\.jpg'      = 'geral_envelope_32.jpg'
        'geral_fechar_60\.jpg'     = 'relatorio_sair_60.jpg'
        # Nomes corrompidos por strip-prefix bugado (task026/SIGREADS): "imagens\v" -> "ideo", "imagens\b" -> "otao"
        '"ideo\.jpg"'              = '"relatorio_video_26.jpg"'
        '"otao_encerrar\.jpg"'     = '"relatorio_sair_60.jpg"'
        # Nomes "bare" sem sufixo _26/_60 (legacy framework names que NAO existem em vbmp/)
        '"video\.jpg"'             = '"relatorio_video_26.jpg"'
        '"impressora\.jpg"'        = '"relatorio_impressora_26.jpg"'
        '"excel\.jpg"'             = '"geral_envelope_32.jpg"'
        '"botao_encerrar\.jpg"'    = '"relatorio_sair_60.jpg"'
    }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # 1. Padroniza gc_4c_Icones -> gc_4c_CaminhoIcones
        if ($linha -match '\bgc_4c_Icones\b') {
            $antes = $linha
            $linha = $linha -replace '\bgc_4c_Icones\b', 'gc_4c_CaminhoIcones'
            Add-Correcao -Tipo "ICONES-VAR-PADRAO" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "gc_4c_Icones (legado) -> gc_4c_CaminhoIcones (Pattern #96)"
        }

        # 2. Substitui nomes de arquivo inexistentes em vbmp/
        foreach ($pattern in $substituicoes.Keys) {
            if ($linha -match $pattern) {
                $antes = $linha
                $linha = $linha -replace $pattern, $substituicoes[$pattern]
                Add-Correcao -Tipo "PICTURE-REPORT-INEXISTENTE" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Icone $pattern nao existe em vbmp/ -> $($substituicoes[$pattern]) (Pattern #96)"
            }
        }

        $resultado += $linha
    }

    return $resultado
}

# =============================================================================
# Pattern #97: Forms REPORT (com cmg_4c_Botoes ou PROCEDURE CriarBotoesRelatorio)
# DEVEM ter cnt_4c_Cabecalho (container superior cinza com titulo). Se ausente,
# insere PROCEDURE ConfigurarCabecalho e a chamada antes de CriarBotoesRelatorio.
# Bug observado em Formsigatcrp.prg (2026-06-25). Template: FormSigReAac.prg.
# =============================================================================
function Corrigir-CabecalhoReportAusente {
    param([string[]]$Linhas)

    $ehReport = $false
    $temCabecalho = $false
    $linhaProcCriarBotoes = -1
    $linhaCallCriarBotoes = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)^\s*PROCEDURE\s+CriarBotoesRelatorio\b') {
            $ehReport = $true
            $linhaProcCriarBotoes = $i
        }
        if ($l -match '(?i)\bcmg_4c_Botoes\b') {
            $ehReport = $true
        }
        if ($l -match '(?i)\bcnt_4c_Cabecalho\b' -or $l -match '(?i)\bConfigurarCabecalho\b') {
            $temCabecalho = $true
        }
        if ($l -match '(?i)^\s*THIS\.CriarBotoesRelatorio\s*\(\s*\)') {
            $linhaCallCriarBotoes = $i
        }
    }

    if (-not $ehReport -or $temCabecalho) { return $Linhas }
    if ($linhaProcCriarBotoes -lt 0 -or $linhaCallCriarBotoes -lt 0) { return $Linhas }

    # Bloco template (FormSigReAac.prg:104-146 canonico)
    $bloco = @(
        '    *=========================================================================='
        '    * CONFIGURARCABECALHO - Container escuro superior com titulo do relatorio'
        '    *   Equivalente ao cntSombra do frmrelatorio legado.'
        '    *   Auto-inserido pelo CorretorAutomatico Pattern #97.'
        '    *=========================================================================='
        '    PROCEDURE ConfigurarCabecalho'
        '        THIS.AddObject("cnt_4c_Cabecalho", "Container")'
        '        WITH THIS.cnt_4c_Cabecalho'
        '            .Top         = 0'
        '            .Left        = 0'
        '            .Width       = THIS.Width'
        '            .Height      = 80'
        '            .BackStyle   = 1'
        '            .BackColor   = RGB(100, 100, 100)'
        '            .BorderWidth = 0'
        '            .Visible     = .T.'
        ''
        '            .AddObject("lbl_4c_Sombra", "Label")'
        '            WITH .lbl_4c_Sombra'
        '                .Top       = 22'
        '                .Left      = 22'
        '                .Width     = THISFORM.Width'
        '                .Height    = 30'
        '                .Caption   = THISFORM.Caption'
        '                .FontName  = "Tahoma"'
        '                .FontSize  = 14'
        '                .FontBold  = .T.'
        '                .ForeColor = RGB(0, 0, 0)'
        '                .BackStyle = 0'
        '                .Visible   = .T.'
        '            ENDWITH'
        ''
        '            .AddObject("lbl_4c_Titulo", "Label")'
        '            WITH .lbl_4c_Titulo'
        '                .Top       = 20'
        '                .Left      = 20'
        '                .Width     = THISFORM.Width'
        '                .Height    = 30'
        '                .Caption   = THISFORM.Caption'
        '                .FontName  = "Tahoma"'
        '                .FontSize  = 14'
        '                .FontBold  = .T.'
        '                .ForeColor = RGB(255, 255, 255)'
        '                .BackStyle = 0'
        '                .Visible   = .T.'
        '            ENDWITH'
        '        ENDWITH'
        '    ENDPROC'
        ''
    )

    # Recua ate o comentario que precede PROCEDURE CriarBotoesRelatorio
    $linhaInsercaoBloco = $linhaProcCriarBotoes
    for ($j = $linhaProcCriarBotoes - 1; $j -ge 0; $j--) {
        $l = $Linhas[$j]
        if ($l -match '^\s*\*' -or $l -match '^\s*$') {
            $linhaInsercaoBloco = $j
        } else {
            break
        }
    }

    # Detecta indentacao da chamada
    $indentCall = "                "
    if ($Linhas[$linhaCallCriarBotoes] -match '^(\s+)') {
        $indentCall = $Matches[1]
    }

    $resultado = @()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($i -eq $linhaInsercaoBloco) {
            foreach ($linhaBloco in $bloco) { $resultado += $linhaBloco }
        }
        if ($i -eq $linhaCallCriarBotoes) {
            $resultado += "${indentCall}THIS.ConfigurarCabecalho()"
        }
        $resultado += $Linhas[$i]
    }

    Add-Correcao -Tipo "REPORT-CABECALHO-AUSENTE" -Linha ($linhaProcCriarBotoes + 1) -Original "(REPORT sem cnt_4c_Cabecalho)" -Corrigido "ConfigurarCabecalho() inserido + chamado em InicializarForm" -Descricao "Form REPORT sem container superior cinza (cntSombra) - bloco padrao FormSigReAac.prg inserido (Pattern #97)"

    return $resultado
}

# =============================================================================
# Pattern #98: Labels em cnt_4c_Cabecalho (lbl_4c_Sombra/lbl_4c_Titulo) com
# AutoSize=.T. fazem o titulo passar atras dos botoes quando caption eh longo.
# Remove AutoSize=.T. e injeta Width=THIS.Width se ausente.
# Bug observado em Formsigrecmc.prg (2026-06-25).
# =============================================================================
function Corrigir-CabecalhoLabelsAutoSize {
    param([string[]]$Linhas)

    # Fase 1: detectar blocos WITH de lbl_4c_Sombra / lbl_4c_Titulo dentro de cnt_4c_Cabecalho
    # Heuristica: linha "WITH ...lbl_4c_(Sombra|Titulo)" inicia bloco, "ENDWITH" termina.
    $dentroLabel = $false
    $temAutoSizeT = $false
    $linhaAutoSize = -1
    $temWidth = $false
    $linhaIndent = "                "
    $blocoInicio = -1

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        [void]$resultado.Add($Linhas[$i])
    }

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]

        if (-not $dentroLabel) {
            if ($l -match '(?i)^\s*WITH\s+.*lbl_4c_(Sombra|Titulo)\b') {
                # Verifica se eh dentro de cnt_4c_Cabecalho — olha atras (-15 linhas)
                $contextoCabecalho = $false
                $iniBusca = [Math]::Max(0, $i - 15)
                for ($j = $iniBusca; $j -lt $i; $j++) {
                    if ($resultado[$j] -match '(?i)cnt_4c_Cabecalho') { $contextoCabecalho = $true; break }
                }
                if ($contextoCabecalho) {
                    $dentroLabel = $true
                    $temAutoSizeT = $false
                    $linhaAutoSize = -1
                    $temWidth = $false
                    $blocoInicio = $i
                    $linhaIndent = "                "
                }
            }
            continue
        }

        # Dentro do bloco WITH ...lbl_*
        if ($l -match '(?i)^\s*ENDWITH\b') {
            # Aplica correcoes
            if ($temAutoSizeT) {
                # Substitui AutoSize=.T. por AutoSize=.F.
                $resultado[$linhaAutoSize] = $resultado[$linhaAutoSize] -replace '(?i)\.AutoSize\s*=\s*\.T\.', '.AutoSize  = .F.'
                Add-Correcao -Tipo "CABECALHO-AUTOSIZE-T" -Linha ($linhaAutoSize + 1) -Original "(AutoSize=.T. em lbl_4c_Cabecalho)" -Corrigido "AutoSize=.F." -Descricao "Label de cnt_4c_Cabecalho com AutoSize=.T. - caption longo passa atras dos botoes (Pattern #98)"
            }
            # Injeta Width=THIS.Width se nao havia (independente do AutoSize)
            if ($temAutoSizeT -and -not $temWidth) {
                $widthLine = "${linhaIndent}.Width     = THIS.Width"
                $heightLine = "${linhaIndent}.Height    = 30"
                # Inserir DEPOIS da linha do AutoSize corrigido
                $resultado.Insert($linhaAutoSize + 1, $widthLine)
                $resultado.Insert($linhaAutoSize + 2, $heightLine)
                # Pula linhas inseridas (shift index)
                $i += 2
                Add-Correcao -Tipo "CABECALHO-WIDTH-AUSENTE" -Linha ($linhaAutoSize + 2) -Original "(Width ausente apos AutoSize=.F.)" -Corrigido "Width=THIS.Width + Height=30 injetados" -Descricao "Sem Width explicito apos AutoSize=.F., Label fica com Width=100 default (Pattern #98)"
            }
            $dentroLabel = $false
            continue
        }

        # Detecta indentacao (primeira linha de propriedade)
        if ($l -match '^(\s+)\.[A-Z]' -and $linhaIndent -eq "                ") {
            $linhaIndent = $Matches[1]
        }

        if ($l -match '(?i)^\s*\.AutoSize\s*=\s*\.T\.') {
            $temAutoSizeT = $true
            $linhaAutoSize = $i
        }
        if ($l -match '(?i)^\s*\.Width\s*=') {
            $temWidth = $true
        }
    }

    # Converter ArrayList para string[]
    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #99: Standalone CommandButton (fora de CommandGroup) com .Picture +
# .Themes=.F. nao renderiza o icone. Substitui Themes=.F.->Themes=.T. e adiciona
# DisabledPicture (mesma imagem) se .Enabled=.F. estiver presente.
# Bug observado em Formsigrecmc.prg cmd_4c_Graficos (2026-06-25).
# Detecta APENAS standalone (WITH THIS.cmd_* ou WITH <container>.cmd_*),
# NUNCA WITH ...cmg_4c_Botoes.Buttons(N) (que mantem Themes=.F. canonico).
# =============================================================================
function Corrigir-StandaloneCommandButtonTheme {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    $dentroBloco = $false
    $linhaWithCmd = -1
    $temPicture = $false
    $temThemesF = $false
    $linhaThemesF = -1
    $temDisabledPic = $false
    $temEnabledF = $false
    $pictureExpr = ""
    $linhaIndent = "            "

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]

        if (-not $dentroBloco) {
            # WITH THIS.cmd_4c_* (standalone) — EXCLUI Buttons(N) e cmg_4c_*
            if ($l -match '(?i)^\s*WITH\s+(THIS|THISFORM)\.\s*cmd_4c_\w+\s*$') {
                # Confirma que NAO eh Buttons(N) — heuristica pelo nome cmd_4c_ (Buttons sao acessados via cmg_4c_Botoes.Buttons(N))
                $dentroBloco = $true
                $linhaWithCmd = $i
                $temPicture = $false
                $temThemesF = $false
                $linhaThemesF = -1
                $temDisabledPic = $false
                $temEnabledF = $false
                $pictureExpr = ""
                $linhaIndent = "            "
            }
            continue
        }

        # Dentro de bloco WITH
        if ($l -match '(?i)^\s*ENDWITH\b') {
            if ($temPicture -and $temThemesF) {
                # Corrige Themes=.F. -> Themes=.T.
                $resultado[$linhaThemesF] = $resultado[$linhaThemesF] -replace '(?i)\.Themes\s*=\s*\.F\.', '.Themes           = .T.'
                Add-Correcao -Tipo "STANDALONE-BTN-THEMES-F" -Linha ($linhaThemesF + 1) -Original "(.Themes=.F. em standalone CommandButton com Picture)" -Corrigido ".Themes=.T." -Descricao "Standalone CommandButton com Picture+Themes=.F. nao renderiza icone (Pattern #99)"

                # Adiciona DisabledPicture se ausente (e tinha Enabled=.F.)
                if (-not $temDisabledPic -and $temEnabledF -and $pictureExpr -ne "") {
                    $disabledLine = "${linhaIndent}.DisabledPicture  = $pictureExpr"
                    # Inserir DEPOIS da linha do Themes corrigido
                    $resultado.Insert($linhaThemesF + 1, $disabledLine)
                    $i++
                    Add-Correcao -Tipo "STANDALONE-BTN-DISABLEDPIC" -Linha ($linhaThemesF + 2) -Original "(DisabledPicture ausente em standalone com Enabled=.F.)" -Corrigido ".DisabledPicture = $pictureExpr" -Descricao "Standalone CommandButton com Enabled=.F. precisa de DisabledPicture (Pattern #99)"
                }
            }
            $dentroBloco = $false
            continue
        }

        # Captura propriedades
        if ($l -match '^(\s+)\.[A-Z]' -and $linhaIndent -eq "            ") {
            $linhaIndent = $Matches[1]
        }

        if ($l -match '(?i)^\s*\.Picture\s*=\s*(.+?)\s*(\&\&.*)?$') {
            $temPicture = $true
            $pictureExpr = $Matches[1].Trim()
        }
        if ($l -match '(?i)^\s*\.DisabledPicture\s*=') {
            $temDisabledPic = $true
        }
        if ($l -match '(?i)^\s*\.Themes\s*=\s*\.F\.') {
            $temThemesF = $true
            $linhaThemesF = $i
        }
        if ($l -match '(?i)^\s*\.Enabled\s*=\s*\.F\.') {
            $temEnabledF = $true
        }
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #100: REPORT Buttons(3) deve ser "Arquivos Email" (envelope), NAO Excel
# =============================================================================
# Framework frmrelatorio.btnReport.Command3 (docs/FRAMEWORK_class_codigo_fonte.txt
# ~6644-6664): Picture=geral_envelope_32.jpg, Caption="\<Arquivos Email".
# O Name interno "DocExcel" eh apenas legado - induz o gerador ao erro de tratar
# como Excel + relatorio_excel_26.jpg. SCOPE: dentro de WITH .Buttons(3)/ENDWITH
# em CommandGroup REPORT (cmg_4c_Botoes). Bug observado em FormSigReAac.prg
# (2026-06-26, task025). Template canonico: FormSigReAac.prg:209-228.
# =============================================================================
function Corrigir-Buttons3RelatorioEmail {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    $dentroButtons3 = $false
    $linhaWithButtons3 = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta entrada em WITH ...Buttons(3) - aceita formato nested (.Buttons(3))
        # OU full path (THIS.cmg_4c_Botoes.Buttons(3) / cmg.Buttons(3) / etc.)
        if (-not $dentroButtons3 -and $linha -match '(?i)^\s*WITH\s+[\w\.]*\.?Buttons\s*\(\s*3\s*\)\s*$') {
            $dentroButtons3 = $true
            $linhaWithButtons3 = $i
        }
        # Saida do bloco (ENDWITH no mesmo nivel)
        elseif ($dentroButtons3 -and $linha -match '(?i)^\s*ENDWITH\s*$') {
            $dentroButtons3 = $false
        }
        elseif ($dentroButtons3) {
            # 1. Caption variantes de Excel/DocExcel -> "\<Arquivos Email"
            #    Cobre: "Excel", "Doc. Excel", "Doc.Excel", "DocExcel", "Doc Excel"
            #    (o Name interno legado eh "DocExcel" — induz gerador ao erro;
            #     Caption canonico do framework eh "\<Arquivos Email" com hotkey A)
            if ($linha -match '(?i)^(\s*\.Caption\s*=\s*)"(Excel|Doc\.? ?Excel|DocExcel)"(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + '"\<Arquivos Email"' + $Matches[3]
                Add-Correcao -Tipo "REPORT-BTN3-CAPTION" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Buttons(3) REPORT: Caption variante Excel/DocExcel -> '\<Arquivos Email' (framework btnReport.Command3 - Pattern #100 v2, Erro50 2026-07-17)"
            }
            # 1b. Caption sem barra invertida (hotkey perdido em sed anterior)
            elseif ($linha -match '(?i)^(\s*\.Caption\s*=\s*)"<Arquivos Email"(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + '"\<Arquivos Email"' + $Matches[2]
                Add-Correcao -Tipo "REPORT-BTN3-HOTKEY" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Buttons(3) REPORT: Caption '<Arquivos Email' -> '\<Arquivos Email' (restore hotkey A, Pattern #100 v2)"
            }
            # 2. Picture relatorio_excel_26.jpg -> geral_envelope_32.jpg
            elseif ($linha -match '(?i)^(\s*\.Picture\s*=\s*[^"]*")relatorio_excel_26\.jpg("(\s*(?:&&.*)?)?)$') {
                $antes = $linha
                $linha = $linha -replace 'relatorio_excel_26\.jpg', 'geral_envelope_32.jpg'
                Add-Correcao -Tipo "REPORT-BTN3-PICTURE" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Buttons(3) REPORT: Picture relatorio_excel_26.jpg -> geral_envelope_32.jpg (Pattern #100)"
            }
            # 3. ToolTipText "Exportar para Excel" / "Gerar Uma Planilha Excel*" -> "Arquivos Email"
            elseif ($linha -match '(?i)^(\s*\.ToolTipText\s*=\s*)"(Exportar para Excel|Gerar Uma Planilha Excel.*)"(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + '"Arquivos Email"' + $Matches[3]
                Add-Correcao -Tipo "REPORT-BTN3-TOOLTIP" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Buttons(3) REPORT: ToolTipText -> 'Arquivos Email' (Pattern #100)"
            }
        }

        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #101: Buttons(N) de cmg_4c_Botoes (REPORT) com FontName="Tahoma"
# =============================================================================
# Framework frmrelatorio.btnReport.CommandN tem FontName="Comic Sans MS" e o
# SCX original NAO sobrescreve, entao a forma canonica eh "Comic Sans MS".
# Gerador frequentemente usa "Tahoma" por default. SCOPE: dentro de WITH
# .Buttons(N)/ENDWITH em CommandGroup REPORT (cmg_4c_Botoes) - aceita ambos
# formatos: WITH .Buttons(N) e WITH THIS.cmg_4c_Botoes.Buttons(N).
# Bug observado em FormSigReAac.prg (2026-06-26, task025).
# Template canonico: FormSigReAac.prg:169-250.
# =============================================================================
function Corrigir-ButtonsReportFontNameComicSans {
    param([string[]]$Linhas)

    # Heuristica REPORT: arquivo tem cmg_4c_Botoes em algum lugar
    $ehReport = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($Linhas[$i] -match '(?i)\bcmg_4c_Botoes\b') {
            $ehReport = $true
            break
        }
    }
    if (-not $ehReport) {
        return $Linhas
    }

    $resultado = New-Object System.Collections.ArrayList
    $dentroButtons = $false
    $temFontName = $false
    $temFontSize = $false
    $linhaCaption = -1
    $linhaButtonsStart = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta entrada em WITH ...Buttons(N) - REPORT cmg_4c_Botoes
        # Aceita: WITH .Buttons(N) | WITH THIS.cmg_4c_Botoes.Buttons(N) | WITH <var>.Buttons(N)
        if (-not $dentroButtons -and $linha -match '(?i)^\s*WITH\s+[\w\.]*\.?Buttons\s*\(\s*\d+\s*\)\s*$') {
            $dentroButtons = $true
            $temFontName = $false
            $temFontSize = $false
            $linhaCaption = -1
            $linhaButtonsStart = $resultado.Count
            [void]$resultado.Add($linha)
            continue
        }

        # Saida do bloco - se faltava FontName/FontSize, injetar APOS .Caption
        if ($dentroButtons -and $linha -match '(?i)^\s*ENDWITH\s*$') {
            if (-not $temFontName -and $linhaCaption -ge 0) {
                # Detecta indentacao do Caption para usar a mesma
                $captionLine = [string]$resultado[$linhaCaption]
                $indent = ""
                if ($captionLine -match '^(\s+)\.') {
                    $indent = $Matches[1]
                }
                $novasLinhas = @()
                if (-not $temFontName) {
                    $novasLinhas += "${indent}.FontName        = `"Comic Sans MS`""
                }
                if (-not $temFontSize) {
                    $novasLinhas += "${indent}.FontSize        = 8"
                }
                # Inserir as novas linhas apos Caption
                $insertPos = $linhaCaption + 1
                foreach ($nl in $novasLinhas) {
                    $resultado.Insert($insertPos, $nl)
                    $insertPos++
                }
                Add-Correcao -Tipo "REPORT-BTN-FONT-MISSING" -Linha ($linhaButtonsStart + 1) -Original "Buttons(N) REPORT sem FontName/FontSize" -Corrigido "FontName='Comic Sans MS' + FontSize=8 injetados apos .Caption" -Descricao "Buttons(N) de cmg_4c_Botoes sem FontName/FontSize - injetando canonico Comic Sans MS / 8 (Pattern #101)"
            }
            $dentroButtons = $false
            [void]$resultado.Add($linha)
            continue
        }

        if ($dentroButtons) {
            # Substitui FontName "Tahoma" por "Comic Sans MS"
            if ($linha -match '(?i)^(\s*\.FontName\s*=\s*)"Tahoma"(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + '"Comic Sans MS"' + $Matches[2]
                Add-Correcao -Tipo "REPORT-BTN-FONTNAME" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "Buttons(N) REPORT: FontName 'Tahoma' -> 'Comic Sans MS' (framework btnReport canonico - Pattern #101)"
                $temFontName = $true
            }
            elseif ($linha -match '(?i)^\s*\.FontName\s*=') {
                $temFontName = $true
            }

            if ($linha -match '(?i)^\s*\.FontSize\s*=') {
                $temFontSize = $true
            }

            if ($linha -match '(?i)^\s*\.Caption\s*=') {
                $linhaCaption = $resultado.Count
            }
        }

        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #102: Buttons(3) e Buttons(4) de cmg_4c_Botoes (REPORT) sem WordWrap=.T.
# =============================================================================
# Framework frmrelatorio.btnReport tem Command3.WordWrap=.T. (linha 6653) e
# Command4.WordWrap=.T. (linha 6673). Sem WordWrap, captions longos como
# "Arquivos Email" (14 chars) sao TRUNCADOS porque nao cabem em 1 linha dentro
# de 65-75px com Comic Sans MS bold-italic 8. Buttons(1)/(2) MANTEM WordWrap=.F.
# (default). SCOPE: arquivo com cmg_4c_Botoes (heuristica REPORT) + dentro de
# WITH ...Buttons(3)/(4) ENDWITH (aceita nested .Buttons(N) e full path).
# Bug em FormSigReAac.prg (2026-06-26, task025, imagem erro4.PNG).
# Template canonico: FormSigReAac.prg:211-230 (Buttons(3) com WordWrap=.T.).
# =============================================================================
function Corrigir-ButtonsReportWordWrap {
    param([string[]]$Linhas)

    # Heuristica REPORT: arquivo tem cmg_4c_Botoes em algum lugar
    $ehReport = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($Linhas[$i] -match '(?i)\bcmg_4c_Botoes\b') {
            $ehReport = $true
            break
        }
    }
    if (-not $ehReport) {
        return $Linhas
    }

    $resultado = New-Object System.Collections.ArrayList
    $dentroButtons34 = $false
    $temWordWrap = $false
    $linhaCaption = -1
    $linhaButtonsStart = -1
    $btnIndex = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta entrada em WITH ...Buttons(3) ou Buttons(4) REPORT
        if (-not $dentroButtons34 -and $linha -match '(?i)^\s*WITH\s+[\w\.]*\.?Buttons\s*\(\s*([34])\s*\)\s*$') {
            $dentroButtons34 = $true
            $btnIndex = [int]$Matches[1]
            $temWordWrap = $false
            $linhaCaption = -1
            $linhaButtonsStart = $resultado.Count
            [void]$resultado.Add($linha)
            continue
        }

        # Saida do bloco - se faltava WordWrap, injetar APOS .Caption
        if ($dentroButtons34 -and $linha -match '(?i)^\s*ENDWITH\s*$') {
            if (-not $temWordWrap -and $linhaCaption -ge 0) {
                $captionLine = [string]$resultado[$linhaCaption]
                $indent = ""
                if ($captionLine -match '^(\s+)\.') {
                    $indent = $Matches[1]
                }
                $resultado.Insert($linhaCaption + 1, "${indent}.WordWrap        = .T.")
                Add-Correcao -Tipo "REPORT-BTN-WORDWRAP" -Linha ($linhaButtonsStart + 1) -Original "Buttons($btnIndex) REPORT sem WordWrap" -Corrigido ".WordWrap = .T. injetado apos .Caption" -Descricao "Buttons($btnIndex) de cmg_4c_Botoes sem WordWrap=.T. - caption pode ser truncado (framework btnReport.Command$btnIndex tem WordWrap=.T. - Pattern #102)"
            }
            $dentroButtons34 = $false
            [void]$resultado.Add($linha)
            continue
        }

        if ($dentroButtons34) {
            if ($linha -match '(?i)^\s*\.WordWrap\s*=') {
                $temWordWrap = $true
            }
            if ($linha -match '(?i)^\s*\.Caption\s*=') {
                $linhaCaption = $resultado.Count
            }
        }

        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #103: grids dentro de forms REPORT precisam de HeaderHeight=0 +
# RowHeight=18 + FontName="Tahoma" (canonico frmrelatorio)
# =============================================================================
# Em forms REPORT (heuristica: arquivo contem cmg_4c_Botoes), os grids
# (grd_4c_*) seguem padrao canonico do framework frmrelatorio:
#   - HeaderHeight = 0 (header escondido; Label externa serve de pseudo-header)
#   - RowHeight = 18 (nao 16 que o gerador usa por default)
#   - FontName = "Tahoma" (nao "Verdana" que o gerador usa por default)
# SCOPE: dentro de WITH ...grd_4c_*/ENDWITH em arquivo REPORT. Substitui se
# .RowHeight = 16 -> 18, .FontName = "Verdana" -> "Tahoma" e INJETA
# .HeaderHeight = 0 se ausente. Bug em FormSIGREADS.prg (2026-06-26, task026).
# =============================================================================
function Corrigir-GridReportCanonico {
    param([string[]]$Linhas)

    # Heuristica REPORT: arquivo tem cmg_4c_Botoes em algum lugar
    $ehReport = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($Linhas[$i] -match '(?i)\bcmg_4c_Botoes\b') {
            $ehReport = $true
            break
        }
    }
    if (-not $ehReport) {
        return $Linhas
    }

    $resultado = New-Object System.Collections.ArrayList
    $dentroGrid = $false
    $temHeaderHeight = $false
    $linhaWidthOuHeight = -1
    $linhaGridStart = -1

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]

        # Detecta entrada em WITH ...grd_4c_*
        if (-not $dentroGrid -and $linha -match '(?i)^\s*WITH\s+[\w\.]*\.?grd_4c_\w+\s*$') {
            $dentroGrid = $true
            $temHeaderHeight = $false
            $linhaWidthOuHeight = -1
            $linhaGridStart = $resultado.Count
            [void]$resultado.Add($linha)
            continue
        }

        # Saida do bloco
        if ($dentroGrid -and $linha -match '(?i)^\s*ENDWITH\s*$') {
            if (-not $temHeaderHeight -and $linhaWidthOuHeight -ge 0) {
                # Detecta indentacao do .Width/.Height
                $widthLine = [string]$resultado[$linhaWidthOuHeight]
                $indent = ""
                if ($widthLine -match '^(\s+)\.') {
                    $indent = $Matches[1]
                }
                $resultado.Insert($linhaWidthOuHeight + 1, "${indent}.HeaderHeight       = 0")
                Add-Correcao -Tipo "REPORT-GRID-HEADERHEIGHT" -Linha ($linhaGridStart + 1) -Original "grd_4c_* REPORT sem HeaderHeight" -Corrigido ".HeaderHeight = 0 injetado apos .Width/.Height" -Descricao "grd_4c_* em form REPORT sem HeaderHeight=0 - headers ficam visiveis (Pattern #103)"
            }
            $dentroGrid = $false
            [void]$resultado.Add($linha)
            continue
        }

        if ($dentroGrid) {
            # Substitui RowHeight=16 -> 18
            if ($linha -match '(?i)^(\s*\.RowHeight\s*=\s*)16(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + "18" + $Matches[2]
                Add-Correcao -Tipo "REPORT-GRID-ROWHEIGHT" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "grd_4c_* REPORT: RowHeight 16 -> 18 (canonico frmrelatorio - Pattern #103)"
            }

            # Substitui FontName "Verdana" -> "Tahoma"
            if ($linha -match '(?i)^(\s*\.FontName\s*=\s*)"Verdana"(\s*(?:&&.*)?)$') {
                $antes = $linha
                $linha = $Matches[1] + '"Tahoma"' + $Matches[2]
                Add-Correcao -Tipo "REPORT-GRID-FONTNAME" -Linha ($i + 1) -Original $antes.Trim() -Corrigido $linha.Trim() -Descricao "grd_4c_* REPORT: FontName 'Verdana' -> 'Tahoma' (canonico frmrelatorio - Pattern #103)"
            }

            # Marca se ja tem HeaderHeight
            if ($linha -match '(?i)^\s*\.HeaderHeight\s*=') {
                $temHeaderHeight = $true
            }

            # Lembra a ultima linha de Width/Height para inserir HeaderHeight depois
            if ($linha -match '(?i)^\s*\.(Width|Height)\s*=') {
                $linhaWidthOuHeight = $resultado.Count
            }
        }

        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #104: Standalone CommandButton auxiliar (SelTudo/Apaga ao lado de Grid)
#              OMITE .Picture inteira
# =============================================================================
# Bug: Botoes standalone auxiliares ao lado de grids de selecao (cmd_4c_SelTudo,
# cmd_4c_Apaga) sao gerados pelo pipeline SEM a linha .Picture = ... . O SCX
# original SEMPRE tem .Picture nesses botoes (framework imagens geral_marcar_26.jpg
# para Selecionar, cadastro_excluir_26.jpg para Desmarcar). O botao renderiza
# como retangulo branco 45x45 sem qualquer icone.
#
# Diferente do Pattern #99 (Themes=.F. bloqueando Picture DEFINIDO), aqui o
# .Picture esta AUSENTE — a linha nem foi gerada.
#
# Heuristica: se WITH cmd_4c_* tem .ToolTipText = "Selecionar"/"Desmarcar"/
# "Marcar Todos"/"Limpar" e NAO tem .Picture, injeta .Picture + .DisabledPicture
# conforme mapeamento canonico + normaliza .Themes = .T.
#
# SCOPE: apenas WITH ...cmd_4c_* (standalone), NUNCA cmg_4c_Botoes.Buttons(N).
# Bug em Formsigrecmc.prg (task052, erro6.PNG, 2026-07-01).
# =============================================================================
function Corrigir-StandaloneButtonPictureAusente {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # Mapeamento canonico ToolTipText -> Icone (case-insensitive)
    $mapaIcones = @{
        'selecionar'    = 'geral_marcar_26.jpg'
        'marcar todos'  = 'geral_marcar_26.jpg'
        'marcar'        = 'geral_marcar_26.jpg'
        'desmarcar'     = 'cadastro_excluir_26.jpg'
        'limpar'        = 'cadastro_excluir_26.jpg'
    }

    $dentroBloco = $false
    $linhaWithCmd = -1
    $linhaEndWith = -1
    $temPicture = $false
    $temThemesF = $false
    $linhaThemesF = -1
    $tooltipCanonico = ""
    $linhaAncoraInsercao = -1
    $linhaIndent = "            "

    $i = 0
    while ($i -lt $resultado.Count) {
        $l = $resultado[$i]

        if (-not $dentroBloco) {
            # WITH ...cmd_4c_* (standalone) — EXCLUI Buttons(N) e cmg_4c_*
            if ($l -match '(?i)^\s*WITH\s+[\w\.]*cmd_4c_\w+\s*$') {
                $dentroBloco = $true
                $linhaWithCmd = $i
                $temPicture = $false
                $temThemesF = $false
                $linhaThemesF = -1
                $tooltipCanonico = ""
                $linhaAncoraInsercao = -1
                $linhaIndent = "            "
            }
            $i++
            continue
        }

        # Dentro de bloco WITH
        if ($l -match '(?i)^\s*ENDWITH\b') {
            $linhaEndWith = $i
            # Aplicar fix se: NAO tem Picture, tem tooltip canonico
            if (-not $temPicture -and $tooltipCanonico -ne "") {
                $icone = $mapaIcones[$tooltipCanonico]
                $pictureExpr = "gc_4c_CaminhoIcones + `"$icone`""

                # Ancorar insercao: usar linhaAncoraInsercao (linha do .Caption) ou linha antes do ENDWITH
                $inserirEm = if ($linhaAncoraInsercao -ge 0) { $linhaAncoraInsercao + 1 } else { $linhaEndWith }

                $pictureLine = "$linhaIndent.Picture         = $pictureExpr"
                $disabledLine = "$linhaIndent.DisabledPicture = $pictureExpr"

                $resultado.Insert($inserirEm, $pictureLine)
                $resultado.Insert($inserirEm + 1, $disabledLine)
                $i += 2
                $linhaEndWith += 2
                $linhaThemesF = if ($linhaThemesF -ge $inserirEm) { $linhaThemesF + 2 } else { $linhaThemesF }

                Add-Correcao -Tipo "STANDALONE-BTN-PICTURE-MISSING" -Linha ($inserirEm + 1) -Original "(.Picture ausente em standalone cmd_4c_* com ToolTipText='$tooltipCanonico')" -Corrigido ".Picture = $pictureExpr" -Descricao "Standalone CommandButton auxiliar sem .Picture (tooltip='$tooltipCanonico' -> $icone) - Pattern #104"

                # Se tem Themes=.F., promover para Themes=.T. (padrao standalone com Picture)
                if ($temThemesF -and $linhaThemesF -ge 0) {
                    $resultado[$linhaThemesF] = $resultado[$linhaThemesF] -replace '(?i)\.Themes\s*=\s*\.F\.', '.Themes          = .T.'
                    Add-Correcao -Tipo "STANDALONE-BTN-THEMES-NORM" -Linha ($linhaThemesF + 1) -Original "(.Themes=.F. em standalone com Picture injetado)" -Corrigido ".Themes = .T." -Descricao "Standalone CommandButton com Picture requer Themes=.T. - Pattern #104 (complementa #99)"
                }
            }
            $dentroBloco = $false
            $i++
            continue
        }

        # Captura indentacao no primeiro .Propriedade
        if ($l -match '^(\s+)\.[A-Z]' -and $linhaIndent -eq "            ") {
            $linhaIndent = $Matches[1]
        }

        if ($l -match '(?i)^\s*\.Picture\s*=') {
            $temPicture = $true
        }
        if ($l -match '(?i)^\s*\.Themes\s*=\s*\.F\.') {
            $temThemesF = $true
            $linhaThemesF = $i
        }
        if ($l -match '(?i)^\s*\.Caption\s*=') {
            $linhaAncoraInsercao = $i
        }
        if ($l -match '(?i)^\s*\.ToolTipText\s*=\s*"([^"]+)"') {
            $ttp = $Matches[1].Trim().ToLower()
            if ($mapaIcones.ContainsKey($ttp)) {
                $tooltipCanonico = $ttp
            }
        }

        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #105: SigCdOpe eh single-column — NUNCA usar `descrs`/`Descrs`
# =============================================================================
# Bug: Lookup FormBuscaAuxiliar e SELECT contra SigCdOpe referenciam coluna
# `descrs`/`Descrs` que NAO EXISTE. SigCdOpe tem `Dopes` (char(20)) que eh
# PK **E** descricao ao mesmo tempo.
#
# Sintoma runtime: "Variable 'DESCRS' is not found" em
# FormBuscaAuxiliar.ConfigurarGrid linha 327.
#
# Detecta e corrige 2 anti-patterns:
# (a) `mAddColuna("descrs"|"Descrs"|"DESCRS", ...)` dentro de bloco que
#     menciona "SigCdOpe" nas +/-15 linhas anteriores — remove a linha.
# (b) `SELECT ... Descrs ... FROM SigCdOpe` — remove Descrs da lista de
#     colunas do SELECT.
#
# Bug em Formsigrecmc.prg:1848 (task052, erro7.PNG, 2026-07-01) e
# FormSigReCmp.prg:1767/1813 (task045).
# =============================================================================
function Corrigir-SigCdOpeDescrsColuna {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    $i = 0
    while ($i -lt $resultado.Count) {
        $l = $resultado[$i]

        # Caso (a): mAddColuna("descrs"|"Descrs"|"DESCRS", ...) - remover se contexto SigCdOpe
        if ($l -match '(?i)mAddColuna\s*\(\s*"descrs"') {
            # Verifica se ha "SigCdOpe" nas 15 linhas anteriores (mesma procedure/lookup)
            $temSigCdOpe = $false
            $inicio = [Math]::Max(0, $i - 15)
            for ($j = $inicio; $j -lt $i; $j++) {
                if ($resultado[$j] -match '(?i)SigCdOpe') {
                    $temSigCdOpe = $true
                    break
                }
            }
            if ($temSigCdOpe) {
                $original = $l.Trim()
                $resultado.RemoveAt($i)
                Add-Correcao -Tipo "SIGCDOPE-DESCRS-MADDCOLUNA" -Linha ($i + 1) -Original $original -Corrigido "(linha removida)" -Descricao "SigCdOpe nao tem coluna 'descrs' - Pattern #105 removeu mAddColuna invalida"
                continue
            }
        }

        # Caso (b): SELECT com coluna Descrs de SigCdOpe
        # Padrao: "SELECT Dopes, Descrs FROM SigCdOpe" ou variantes
        if ($l -match '(?i)SELECT\s+.*\b[Dd]escrs\b.*FROM\s+SigCdOpe') {
            $original = $l.Trim()
            # Remove ", Descrs" ou "Descrs," (case-insensitive) apenas se seguido/precedido de Dopes
            $novaLinha = $l -replace '(?i),\s*[Dd]escrs\b', ''
            $novaLinha = $novaLinha -replace '(?i)\b[Dd]escrs\s*,\s*', ''
            if ($novaLinha -ne $l) {
                $resultado[$i] = $novaLinha
                Add-Correcao -Tipo "SIGCDOPE-DESCRS-SELECT" -Linha ($i + 1) -Original $original -Corrigido $novaLinha.Trim() -Descricao "SigCdOpe nao tem coluna 'Descrs' - Pattern #105 removeu do SELECT"
            }
        }

        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #106: CommandButton icone-only (Caption="") NUNCA setar Enabled=.F.
#              em runtime — icone some
# =============================================================================
# Bug: Standalone CommandButton com Caption="" + .Picture fica retangulo vazio
# quando .Enabled=.F. INDEPENDENTE de Themes=.T./F. Refina Pattern #99 que
# funciona apenas para botoes COM caption.
#
# Deteccao (2 passes):
#   Pass 1: Identifica cmd_4c_* declarados com .Caption = "" + .Picture
#           (icone-only) dentro de blocos WITH ... ENDWITH
#   Pass 2: Remove linhas <container>.cmd_4c_X.Enabled = .F./.T. no runtime
#           (fora do WITH inicial) para os cmd_4c_X identificados no pass 1
#
# Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG,
# 2026-07-01). Solucao (a) da secao #110 — remove disable, mantendo apenas
# desabilitacao do controle FUNCIONAL alvo (grade).
# =============================================================================
function Corrigir-IconOnlyButtonDisableRuntime {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # Pass 1: identificar cmd_4c_* icone-only
    # Otimizacao: pre-check por substring
    $iconOnlyButtons = @{}
    $dentroWith = $false
    $btnAtual = ""
    $temCaptionVazio = $false
    $temPicture = $false

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]
        $lTrimmed = $l.TrimStart()

        if (-not $dentroWith) {
            # Pre-check: precisa comecar com WITH e conter cmd_4c_
            if ($lTrimmed.StartsWith('WITH ', [System.StringComparison]::OrdinalIgnoreCase) `
                -and $l.IndexOf('cmd_4c_', [System.StringComparison]::OrdinalIgnoreCase) -ge 0 `
                -and $l.IndexOf('Buttons(', [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
                if ($l -match '(?i)^\s*WITH\s+[\w\.]*\.?(cmd_4c_\w+)\s*$') {
                    $dentroWith = $true
                    $btnAtual = $Matches[1]
                    $temCaptionVazio = $false
                    $temPicture = $false
                }
            }
            continue
        }

        # Dentro de WITH — pre-check por substring
        if ($lTrimmed.StartsWith('ENDWITH', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($temCaptionVazio -and $temPicture) {
                $iconOnlyButtons[$btnAtual.ToLower()] = $true
            }
            $dentroWith = $false
            $btnAtual = ""
            continue
        }
        # .Caption = "" — pre-check
        if (-not $temCaptionVazio -and $lTrimmed.StartsWith('.Caption', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Caption\s*=\s*""\s*(\&\&.*)?$') {
                $temCaptionVazio = $true
            }
        }
        # .Picture = ... — pre-check
        if (-not $temPicture -and $lTrimmed.StartsWith('.Picture', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Picture\s*=\s*[^"''\s]') {
                $temPicture = $true
            }
        }
    }

    if ($iconOnlyButtons.Count -eq 0) {
        # Nada icone-only encontrado — nada a corrigir
        $saida = New-Object string[] $resultado.Count
        for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
        return $saida
    }

    # Pass 2: remover .Enabled = .F./.T. em runtime para botoes icone-only
    # Runtime = linha do tipo `<container>.cmd_4c_X.Enabled = ...` (NAO dentro de WITH)
    # Otimizacao: pre-check rapido por substring antes de rodar regex
    $removidas = 0
    $dentroWith = $false
    $i = 0
    while ($i -lt $resultado.Count) {
        $l = $resultado[$i]

        # Pre-check rapido: linha precisa conter ".cmd_4c_" e ".Enabled"
        # Isso pula 99% das linhas sem custo de regex
        $lTrimmed = $l.TrimStart()

        # Rastreia WITH/ENDWITH — pre-check por substring
        if ($lTrimmed.StartsWith('WITH ', [System.StringComparison]::OrdinalIgnoreCase) -or `
            $lTrimmed.StartsWith('WITH.', [System.StringComparison]::OrdinalIgnoreCase)) {
            $dentroWith = $true
            $i++
            continue
        }
        if ($lTrimmed.StartsWith('ENDWITH', [System.StringComparison]::OrdinalIgnoreCase)) {
            $dentroWith = $false
            $i++
            continue
        }

        if (-not $dentroWith -and $l.IndexOf('.cmd_4c_', [System.StringComparison]::OrdinalIgnoreCase) -ge 0 `
            -and $l.IndexOf('.Enabled', [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
            # Padrao simplificado: .cmd_4c_NOME.Enabled = valor
            if ($l -match '(?i)\.(cmd_4c_\w+)\.Enabled\s*=\s*(\.[TF]\.|par_\w+)') {
                $btnNome = $Matches[1].ToLower()
                if ($iconOnlyButtons.ContainsKey($btnNome)) {
                    $original = $l.Trim()
                    $resultado.RemoveAt($i)
                    $removidas++
                    Add-Correcao -Tipo "ICON-ONLY-BTN-DISABLE-REMOVED" -Linha ($i + 1) -Original $original -Corrigido "(linha removida)" -Descricao "CommandButton icone-only ${btnNome} - Enabled=.F./.T. em runtime some com icone - Pattern #106 removeu linha"
                    continue
                }
            }
        }

        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #107: Container de botoes overlay Grid com BackStyle=0 gera "ghost
#              trails" ao scrollar
# =============================================================================
# Bug: Container filho de Form contendo CommandButtons + BackStyle=0 (transparente)
# cuja bbox sobrepoe Grid irmao. Ao scrollar o grid, redraw parcial deixa
# "carimbos" dos botoes visiveis multiplicados na area do grid.
#
# Fix: forcar BackStyle=1 + BackColor=RGB(255,255,255) no container.
# (Nao alteramos Top para preservar layout intencional — SCX original pode
# ter Top < grid.bottom por design.)
#
# Deteccao (3 passes):
#   Pass 1: identifica bbox de todos Grid (grd_4c_* declarados via AddObject)
#           = (Top, Top+Height)
#   Pass 2: identifica Containers (cnt_4c_*) que contem CommandButton dentro
#           (via <container>.AddObject("cmd_4c_*", "CommandButton")) e captura
#           seu (Top, Top+Height, BackStyle)
#   Pass 3: para cada Container com BackStyle=0 cuja bbox sobrepoe alguma Grid
#           bbox → forcar BackStyle=1 + injetar BackColor=RGB(255,255,255)
#
# Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01)
# =============================================================================
function Corrigir-ContainerBotoesOverlayGrid {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # ---------- Pass 1: bbox de Grids (grd_4c_*) ----------
    # Coleta apenas grid.Top e grid.Height do WITH block imediato
    $gridBBoxes = New-Object System.Collections.ArrayList

    $dentroGrid = $false
    $gridTop = 0
    $gridHeight = 0
    $temTop = $false
    $temHeight = $false

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]
        $lTrimmed = $l.TrimStart()

        if (-not $dentroGrid) {
            if ($lTrimmed.StartsWith('WITH ', [System.StringComparison]::OrdinalIgnoreCase) `
                -and $l.IndexOf('grd_4c_', [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
                $dentroGrid = $true
                $gridTop = 0; $gridHeight = 0
                $temTop = $false; $temHeight = $false
            }
            continue
        }

        if ($lTrimmed.StartsWith('ENDWITH', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($temTop -and $temHeight) {
                [void]$gridBBoxes.Add(@{ Top = $gridTop; Bottom = $gridTop + $gridHeight })
            }
            $dentroGrid = $false
            continue
        }

        if (-not $temTop -and $lTrimmed.StartsWith('.Top', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Top\s*=\s*(\d+)') {
                $gridTop = [int]$Matches[1]
                $temTop = $true
            }
        }
        if (-not $temHeight -and $lTrimmed.StartsWith('.Height', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Height\s*=\s*(\d+)') {
                $gridHeight = [int]$Matches[1]
                $temHeight = $true
            }
        }
    }

    if ($gridBBoxes.Count -eq 0) {
        # Sem Grids no arquivo — nada a corrigir
        $saida = New-Object string[] $resultado.Count
        for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
        return $saida
    }

    # ---------- Pass 2: identifica cnt_4c_* que contem CommandButton ----------
    # Padrao tipico: <container>.AddObject("cmd_4c_*", "CommandButton")
    $containersComBotao = @{}
    foreach ($l in $resultado) {
        if ($l -match '(?i)(cnt_4c_\w+)\s*\.\s*AddObject\s*\(\s*"cmd_4c_\w+"\s*,\s*"CommandButton"') {
            $containersComBotao[$Matches[1].ToLower()] = $true
        }
    }

    if ($containersComBotao.Count -eq 0) {
        # Sem containers com botao — nada a corrigir
        $saida = New-Object string[] $resultado.Count
        for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
        return $saida
    }

    # ---------- Pass 3: para cada Container detectado, analisa bbox + BackStyle ----------
    # Se BackStyle=0 e bbox sobrepoe algum grid, injeta BackStyle=1 + BackColor branco
    $dentroCnt = $false
    $cntNome = ""
    $cntTop = 0
    $cntHeight = 0
    $temCntTop = $false
    $temCntHeight = $false
    $linhaBackStyle0 = -1
    $linhaIndent = "            "
    $temBackColor = $false
    $linhasCorrigidas = @{}

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]
        $lTrimmed = $l.TrimStart()

        if (-not $dentroCnt) {
            if ($lTrimmed.StartsWith('WITH ', [System.StringComparison]::OrdinalIgnoreCase) `
                -and $l -match '(?i)WITH\s+[\w\.]*\.?(cnt_4c_\w+)\s*$') {
                $candidato = $Matches[1].ToLower()
                if ($containersComBotao.ContainsKey($candidato)) {
                    $dentroCnt = $true
                    $cntNome = $candidato
                    $cntTop = 0; $cntHeight = 0
                    $temCntTop = $false; $temCntHeight = $false
                    $linhaBackStyle0 = -1
                    $temBackColor = $false
                    $linhaIndent = "            "
                }
            }
            continue
        }

        if ($lTrimmed.StartsWith('ENDWITH', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($temCntTop -and $temCntHeight -and $linhaBackStyle0 -ge 0) {
                $cntBottom = $cntTop + $cntHeight
                # Verifica overlap com algum grid
                $overlap = $false
                foreach ($gb in $gridBBoxes) {
                    if ($cntTop -lt $gb.Bottom -and $cntBottom -gt $gb.Top) {
                        $overlap = $true
                        break
                    }
                }
                if ($overlap) {
                    # Fix: BackStyle=0 -> BackStyle=1
                    $original = $resultado[$linhaBackStyle0].Trim()
                    $resultado[$linhaBackStyle0] = $resultado[$linhaBackStyle0] -replace '(?i)\.BackStyle\s*=\s*0', '.BackStyle = 1'
                    Add-Correcao -Tipo "CNT-OVERLAY-GRID-BACKSTYLE" -Linha ($linhaBackStyle0 + 1) -Original $original -Corrigido $resultado[$linhaBackStyle0].Trim() -Descricao "Container ${cntNome} sobrepoe Grid com BackStyle=0 (ghost trails) - Pattern #107 forcou BackStyle=1"

                    # Injeta BackColor se ausente
                    if (-not $temBackColor) {
                        $backColorLine = "${linhaIndent}.BackColor = RGB(255, 255, 255)"
                        $resultado.Insert($linhaBackStyle0 + 1, $backColorLine)
                        $i++
                        Add-Correcao -Tipo "CNT-OVERLAY-GRID-BACKCOLOR" -Linha ($linhaBackStyle0 + 2) -Original "(BackColor ausente)" -Corrigido ".BackColor = RGB(255, 255, 255)" -Descricao "Container ${cntNome} ganhou BackColor branco para BackStyle=1 funcionar - Pattern #107"
                    }
                }
            }
            $dentroCnt = $false
            $cntNome = ""
            continue
        }

        # Captura indentacao
        if ($linhaIndent -eq "            " -and $l -match '^(\s+)\.[A-Z]') {
            $linhaIndent = $Matches[1]
        }

        if (-not $temCntTop -and $lTrimmed.StartsWith('.Top', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Top\s*=\s*(\d+)') {
                $cntTop = [int]$Matches[1]
                $temCntTop = $true
            }
        }
        if (-not $temCntHeight -and $lTrimmed.StartsWith('.Height', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.Height\s*=\s*(\d+)') {
                $cntHeight = [int]$Matches[1]
                $temCntHeight = $true
            }
        }
        if ($linhaBackStyle0 -lt 0 -and $lTrimmed.StartsWith('.BackStyle', [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($l -match '(?i)^\s*\.BackStyle\s*=\s*0\b') {
                $linhaBackStyle0 = $i
            }
        }
        if (-not $temBackColor -and $lTrimmed.StartsWith('.BackColor', [System.StringComparison]::OrdinalIgnoreCase)) {
            $temBackColor = $true
        }
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #108: OptionGroup.Buttons(N).Value != 0 marca todos radio buttons
# =============================================================================
# Bug: Dentro de bloco `WITH ...Buttons(N)` (OptionGroup), setar `.Value = M`
# com M != 0 faz radio button aparecer marcado. Se multiplos Buttons(N) tem
# .Value = N (2, 3, 4, ...), TODOS aparecem selecionados de uma vez porque
# VFP9 trata qualquer nao-zero como truthy.
#
# Deteccao:
#   - Bloco WITH ...Buttons(N)/ENDWITH (qualquer profundidade de container)
#   - Dentro do bloco, linha .Value = M onde M > 1
#   - Remove a linha
#
# SCOPE: apenas Buttons(N) — nao afeta OptionGroup.Value ou controles standalone.
# NAO afeta CommandGroup.Buttons(N) (esses nao tem semantica de radio).
#
# Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups.
# =============================================================================
function Corrigir-OptionButtonValueSpurio {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # Passo 1: identificar todos os OptionGroups (para restringir a Buttons de OG, nao CG)
    # Heuristica simples: se arquivo contem `AddObject("*", "OptionGroup")` para o nome
    # que aparece em `WITH ...NOME.Buttons(N)`, entao eh OptionGroup Buttons.
    $optionGroupNames = @{}
    foreach ($l in $resultado) {
        if ($l -match '(?i)AddObject\s*\(\s*"(\w+)"\s*,\s*"OptionGroup"') {
            $optionGroupNames[$Matches[1].ToLower()] = $true
        }
    }

    if ($optionGroupNames.Count -eq 0) {
        # Sem OptionGroups — nada a corrigir
        $saida = New-Object string[] $resultado.Count
        for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
        return $saida
    }

    # Passo 2: percorrer o arquivo procurando `WITH ...Buttons(N)` de OptionGroup
    $dentroButtonsOG = $false
    $removidas = 0
    $i = 0
    while ($i -lt $resultado.Count) {
        $l = $resultado[$i]
        $lTrimmed = $l.TrimStart()

        if (-not $dentroButtonsOG) {
            # Pre-check por substring: linha comeca com WITH e contem Buttons(
            if ($lTrimmed.StartsWith('WITH ', [System.StringComparison]::OrdinalIgnoreCase) `
                -and $l.IndexOf('Buttons(', [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
                # Extrair o nome do OG imediatamente antes de .Buttons(
                if ($l -match '(?i)WITH\s+[\w\.]*\.?(\w+)\s*\.Buttons\s*\(\s*\d+\s*\)\s*$') {
                    $ogNome = $Matches[1].ToLower()
                    if ($optionGroupNames.ContainsKey($ogNome)) {
                        $dentroButtonsOG = $true
                    }
                }
            }
            $i++
            continue
        }

        # Dentro de WITH ...Buttons(N)
        if ($lTrimmed.StartsWith('ENDWITH', [System.StringComparison]::OrdinalIgnoreCase)) {
            $dentroButtonsOG = $false
            $i++
            continue
        }

        # Detectar .Value = M onde M >= 2 (numero literal)
        if ($l -match '(?i)^\s*\.Value\s*=\s*(\d+)\s*(\&\&.*)?$') {
            $valorNumerico = [int]$Matches[1]
            if ($valorNumerico -ge 2) {
                $original = $l.Trim()
                $resultado.RemoveAt($i)
                $removidas++
                Add-Correcao -Tipo "OPTIONBTN-VALUE-SPURIO" -Linha ($i + 1) -Original $original -Corrigido "(linha removida)" -Descricao "OptionButton.Value=$valorNumerico dentro de Buttons(N) marca todos radios (VFP9 trata como truthy) - Pattern #108 removeu linha"
                continue
            }
        }

        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

# =============================================================================
# Pattern #109: TornarControlesVisiveis skip com LOOP deixa sub-controles hidden
# =============================================================================
# Bug: Metodo recursivo TornarControlesVisiveis tem skip para containers
# hidden-por-default (`IF INLIST(...) LOOP ENDIF`). O LOOP pula TANTO setar
# Visible do container QUANTO recursar dentro dele. Sub-controles ficam
# Visible=.F. permanente — container aparece vazio quando mostrado depois.
#
# Fix: injetar bloco recursivo `IF PEMSTATUS/ControlCount > 0 / THIS.TCV(...) /
# ENDIF` ANTES do LOOP, para tornar sub-controles visiveis preservando Visible
# do container.
#
# Deteccao:
#   - PROCEDURE TornarControlesVisiveis
#   - IF INLIST(...) na proxima linha (padrao skip list)
#   - LOOP na linha seguinte (ate ~4 linhas apos IF)
#   - ENDIF depois do LOOP
#   - NAO ha `THIS.TornarControlesVisiveis(` entre IF e LOOP
#
# Bug em Formsigregli.prg (task108, 2026-07-01) — containers cnt_4c_Etiquetas/
# Relacao apareciam vazios ao usuario selecionar Tipo de Impressao.
# =============================================================================
function Corrigir-TornarControlesVisiveisSkipRecursivo {
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # Pre-check: arquivo precisa conter TornarControlesVisiveis
    $temTCV = $false
    foreach ($l in $resultado) {
        if ($l -match '(?i)PROCEDURE\s+TornarControlesVisiveis\b') {
            $temTCV = $true
            break
        }
    }
    if (-not $temTCV) {
        $saida = New-Object string[] $resultado.Count
        for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
        return $saida
    }

    # Percorrer: dentro de TornarControlesVisiveis, achar `IF INLIST` seguido de LOOP
    # em ate ~4 linhas, sem THIS.TornarControlesVisiveis(...) entre eles
    $dentroTCV = $false
    $iEndProc = -1
    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $l = $resultado[$i]
        $lTrimmed = $l.TrimStart()

        if ($lTrimmed -match '(?i)^PROCEDURE\s+TornarControlesVisiveis\b') {
            $dentroTCV = $true
            continue
        }
        if ($dentroTCV -and $lTrimmed -match '(?i)^ENDPROC\b') {
            $iEndProc = $i
            $dentroTCV = $false
            continue
        }

        if (-not $dentroTCV) { continue }

        # Detectar IF INLIST(...) — padrao skip list
        if ($lTrimmed -match '(?i)^IF\s+INLIST\s*\(') {
            $iIf = $i
            # Buscar LOOP nas proximas 4 linhas
            $iLoop = -1
            $temRecursao = $false
            for ($j = $i + 1; $j -lt [Math]::Min($i + 5, $resultado.Count); $j++) {
                $lj = $resultado[$j].TrimStart()
                if ($lj -match '(?i)THIS\.TornarControlesVisiveis\s*\(') {
                    $temRecursao = $true
                    break
                }
                if ($lj -match '(?i)^LOOP\b') {
                    $iLoop = $j
                    break
                }
                if ($lj -match '(?i)^ENDIF\b') {
                    # ENDIF sem LOOP intermediario — nao eh padrao skip
                    break
                }
            }

            if ($iLoop -gt 0 -and -not $temRecursao) {
                # Injetar bloco recursivo antes do LOOP
                # Captura indentacao do LOOP
                $loopLine = $resultado[$iLoop]
                $loopIndent = ""
                if ($loopLine -match '^(\s*)LOOP') {
                    $loopIndent = $Matches[1]
                }

                $bloco = @(
                    "${loopIndent}*-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.",
                    "${loopIndent}IF PEMSTATUS(loc_oControl, `"ControlCount`", 5) AND loc_oControl.ControlCount > 0",
                    "${loopIndent}    THIS.TornarControlesVisiveis(loc_oControl)",
                    "${loopIndent}ENDIF"
                )

                # Inserir na posicao do LOOP (antes)
                for ($k = $bloco.Count - 1; $k -ge 0; $k--) {
                    $resultado.Insert($iLoop, $bloco[$k])
                }
                $iLoop += $bloco.Count
                $i = $iLoop  # continuar apos o LOOP

                Add-Correcao -Tipo "TCV-SKIP-SEM-RECURSAO" -Linha ($iIf + 1) -Original "IF INLIST(...) ... LOOP (sem recursao)" -Corrigido "Bloco recursivo injetado antes do LOOP" -Descricao "TornarControlesVisiveis skip com LOOP pula sub-controles - Pattern #109 injetou recursao"
                continue
            }
        }
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

function Corrigir-fAcessoEmpresa {
    <#
        Pattern #110 - fAcessoEmpresa() do Framework legado NAO foi portada.
        Chamadas diretas quebram runtime com "File 'facessoempresa.prg' does not exist".

        MODO CHECK (3 args, retorna boolean):
            fAcessoEmpresa(usu, "C"|"D", cod)  ->  VerificarAcessoEmpresa(usu, cod)
        Auto-fix aplicado.

        MODO LOOKUP (5 args, popula 2 textboxes):
            fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)  ->  bloco FormBuscaAuxiliar multi-linha
        NAO auto-fix (contexto do form necessario). Insere comentario-warning acima da chamada.
    #>
    param([string[]]$Linhas)

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    # Regex para chamada single-line: captura contexto (`=`, `!` ou nada) + argumentos
    $rxCall = '(?i)fAcessoEmpresa\s*\(([^)]*)\)'

    for ($i = 0; $i -lt $resultado.Count; $i++) {
        $linha = [string]$resultado[$i]

        # Pular linhas de comentario (* ou && inicial apos whitespace)
        $lTrim = $linha.TrimStart()
        if ($lTrim.StartsWith('*') -or $lTrim.StartsWith('&&')) { continue }

        if ($linha -notmatch $rxCall) { continue }

        $argsRaw = $Matches[1]

        # Contar argumentos: split por virgula (args nao contem virgula em strings do padrao)
        $argsList = $argsRaw -split ',' | ForEach-Object { $_.Trim() }
        $nArgs = $argsList.Count

        if ($nArgs -eq 3) {
            # MODO CHECK: fAcessoEmpresa(usu, "modo", cod) -> VerificarAcessoEmpresa(usu, cod)
            $usu = $argsList[0]
            $cod = $argsList[2]
            $original = $linha.Trim()
            $chamadaOriginal = $Matches[0]
            $novaChamada = "VerificarAcessoEmpresa($usu, $cod)"
            $linha = $linha.Replace($chamadaOriginal, $novaChamada)
            $resultado[$i] = $linha

            Add-Correcao -Tipo "FACESSOEMPRESA-CHECK" -Linha ($i + 1) -Original $original -Corrigido $linha.Trim() -Descricao "fAcessoEmpresa(3-args) NAO portada -> VerificarAcessoEmpresa(usu, cod) - Pattern #110"
        }
        elseif ($nArgs -eq 5) {
            # MODO LOOKUP: 5 args exige bloco FormBuscaAuxiliar multi-linha.
            # Nao auto-fix. Injeta comentario-warning ACIMA se ainda nao existe.
            $indent = ($linha -replace '^(\s*).*$','$1')
            $warning = "${indent}*!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378."

            $jaTemWarning = ($i -gt 0) -and ([string]$resultado[$i - 1]).Contains("CORRETOR #110")
            if (-not $jaTemWarning) {
                $resultado.Insert($i, $warning)
                $i++  # pular o warning inserido

                Add-Correcao -Tipo "FACESSOEMPRESA-LOOKUP-WARN" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(warning-comment injetado acima)" -Descricao "fAcessoEmpresa(5-args) NAO portada - lookup requer bloco FormBuscaAuxiliar manual - Pattern #110 injetou warning"
            }
        }
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

function Corrigir-CommandButtonRecordMarkInvalido {
    <#
        Pattern #111 - .RecordMark / .DeleteMark sao propriedades EXCLUSIVAS de Grid.
        Gerador copia esse par de blocos WITH de Grid e cola em WITH de CommandButton
        adjacente (padrao classico: cmd_4c_SelXxx/cmd_4c_DslXxx ao lado de grids de
        selecao multipla). VFP9 trava com "Property RECORDMARK is not found" ao
        instanciar o form. Erro eh engolido pelo TRY/CATCH silencioso em
        InicializarForm -> CREATEOBJECT retorna .F. -> menu mostra "VARTYPE retornou: L".

        Estrategia:
        - Fase 1: mapear objetos por tipo via AddObject("<nome>", "<tipo>")
        - Fase 2: dentro de blocos WITH <objetoNaoGrid>, remover linhas
                  .RecordMark = .F. e .DeleteMark = .F.
        - Grid e derivados (GridBase) sao PRESERVADOS
    #>
    param([string[]]$Linhas)

    # Fase 1: mapear todos os AddObject e classificar por tipo
    $objsGrid = [System.Collections.Generic.HashSet[string]]@()
    $objsNaoGrid = [System.Collections.Generic.HashSet[string]]@()

    for ($k = 0; $k -lt $Linhas.Count; $k++) {
        if ($Linhas[$k] -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"([^"]+)"\s*\)') {
            $nome = $Matches[1]
            $tipo = $Matches[2]
            if ($tipo -match '(?i)^(Grid|GridBase)$') {
                [void]$objsGrid.Add($nome)
            } else {
                [void]$objsNaoGrid.Add($nome)
            }
        }
    }

    if ($objsNaoGrid.Count -eq 0) {
        return $Linhas
    }

    # Fase 2: percorrer procurando WITH <objNaoGrid> ... ENDWITH e remover RecordMark/DeleteMark
    $resultado = New-Object System.Collections.ArrayList
    $dentroWithNaoGrid = $false
    $contadorWith = 0

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = [string]$Linhas[$i]

        # Detectar WITH que abre bloco sobre objeto nao-Grid
        if ($linha -match '(?i)^\s*WITH\s+') {
            $ehNaoGrid = $false
            foreach ($nome in $objsNaoGrid) {
                # Match: WITH ...<obj>  (final da linha eh o nome do objeto)
                if ($linha -match "(?i)\.$([regex]::Escape($nome))\s*$") {
                    $ehNaoGrid = $true
                    break
                }
            }
            if ($ehNaoGrid) {
                $dentroWithNaoGrid = $true
                $contadorWith = 1
                [void]$resultado.Add($linha)
                continue
            }
        }

        if ($dentroWithNaoGrid) {
            # Nested WITH
            if ($linha -match '(?i)^\s*WITH\s+') {
                $contadorWith++
            }
            if ($linha -match '(?i)^\s*ENDWITH\b') {
                $contadorWith--
                if ($contadorWith -le 0) {
                    $dentroWithNaoGrid = $false
                }
            }

            # Remover .RecordMark = .F. ou .DeleteMark = .F.
            if ($linha -match '(?i)^\s*\.(RecordMark|DeleteMark)\s*=\s*\.F\.\s*$') {
                $prop = $Matches[1]
                Add-Correcao -Tipo "CMDBTN-RECORDMARK-INVALIDO" -Linha ($i + 1) -Original $linha.Trim() -Corrigido "(linha removida)" -Descricao ".$prop nao existe em CommandButton/Label/Container/etc — so em Grid. Runtime error 'Property $($prop.ToUpper()) is not found' - Pattern #111"
                continue
            }
        }

        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #116: Corrigir-FwProgressBarStubMembros
# Garante que o stub `classes/fwprogressbar.prg` expoe TODOS os membros
# esperados pela interface do framework legado.
#
# Membros obrigatorios:
#   Labels: Titulo, SubTitulo, Rodape, lblPercentage
#   Shapes: shpThermBg, shpThermBar
#   Metodos: Init, Update, Complete (nao validados aqui -- validacao textual)
#
# Se algum Label estiver ausente, o pattern injeta ADD OBJECT canonico antes
# de "PROCEDURE Init" e ajusta Height (+18 por Label adicionado).
#
# Origem: Bug Erro26 (2026-07-07) - Formsigrepes.prg linha 4562 estourou
#         "Unknown member RODAPE" porque o stub nao tinha o Label Rodape.
# Regra:  Se codigo migrado usa membro do fwprogressbar que nao existe no
#         stub, ADICIONAR AO STUB (NUNCA alterar o form migrado).
#
# Este pattern NAO participa do pipeline per-file (Invoke-CorrecaoAutomatica).
# Deve ser chamado explicitamente (uma vez por sweep) por
# CorrigirTodosFormularios.ps1 ou apos qualquer edicao ao stub.
#==============================================================================
function Corrigir-FwProgressBarStubMembros {
    param(
        [string]$StubPath = "C:\4c\projeto\app\classes\fwprogressbar.prg"
    )

    if (-not (Test-Path $StubPath)) {
        Write-Host "AVISO Pattern #116: stub fwprogressbar.prg nao encontrado em $StubPath" -ForegroundColor Yellow
        return $false
    }

    # Interface esperada (Labels canonicos alinhados verticalmente no stub)
    $labelsCanonicos = [ordered]@{
        'Titulo'        = @{ Top =  8; FontSize = 9; FontBold = $true;  Alignment = 0; Descricao = 'titulo principal' }
        'SubTitulo'     = @{ Top = 28; FontSize = 8; FontBold = $false; Alignment = 0; Descricao = 'subtitulo / categoria' }
        'lblPercentage' = @{ Top = 68; FontSize = 8; FontBold = $false; Alignment = 2; Descricao = 'percentual (auto-atualizado por Update)' }
        'Rodape'        = @{ Top = 86; FontSize = 8; FontBold = $false; Alignment = 2; Descricao = 'mensagens auxiliares (<ESC> para interromper...)' }
    }

    $conteudo = [System.IO.File]::ReadAllText($StubPath, [System.Text.Encoding]::GetEncoding(1252))
    $linhas = $conteudo -split "`r`n|`n"

    $membrosFaltando = @()
    foreach ($nome in $labelsCanonicos.Keys) {
        $regex = "(?i)^\s*ADD OBJECT\s+$nome\s+AS\s+Label"
        $encontrado = $false
        foreach ($linha in $linhas) {
            if ($linha -match $regex) { $encontrado = $true; break }
        }
        if (-not $encontrado) { $membrosFaltando += $nome }
    }

    if ($membrosFaltando.Count -eq 0) {
        Write-Host "Pattern #116: fwprogressbar stub completo (Titulo/SubTitulo/Rodape/lblPercentage OK)" -ForegroundColor Gray
        return $true
    }

    Write-Host "Pattern #116: fwprogressbar stub incompleto - faltam: $($membrosFaltando -join ', ')" -ForegroundColor Yellow

    # Backup
    Copy-Item -Path $StubPath -Destination "$StubPath.bak" -Force

    # Localiza ponto de insercao: linha imediatamente antes de "PROCEDURE Init"
    $idxInsercao = -1
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '(?i)^\s*PROCEDURE\s+Init\b') {
            # Recua ate linha em branco anterior (ou usa a propria linha)
            $idxInsercao = $i
            while ($idxInsercao -gt 0 -and [string]::IsNullOrWhiteSpace($linhas[$idxInsercao - 1])) {
                $idxInsercao--
            }
            break
        }
    }
    if ($idxInsercao -lt 0) {
        # Fallback: antes de ENDDEFINE
        for ($i = $linhas.Count - 1; $i -ge 0; $i--) {
            if ($linhas[$i] -match '(?i)^\s*ENDDEFINE\b') { $idxInsercao = $i; break }
        }
    }
    if ($idxInsercao -lt 0) {
        Write-Host "Pattern #116: nao foi possivel localizar ponto de insercao (PROCEDURE Init / ENDDEFINE)" -ForegroundColor Red
        return $false
    }

    # Gera blocos ADD OBJECT para membros faltantes
    $blocos = New-Object System.Collections.ArrayList
    foreach ($nome in $membrosFaltando) {
        $spec = $labelsCanonicos[$nome]
        [void]$blocos.Add("    *-- Pattern #116: $nome ($($spec.Descricao))")
        [void]$blocos.Add("    ADD OBJECT $nome AS Label WITH ;")
        [void]$blocos.Add("        Top       = $($spec.Top), ;")
        [void]$blocos.Add("        Left      = 10, ;")
        [void]$blocos.Add("        Width     = 360, ;")
        [void]$blocos.Add("        Height    = $(if ($nome -eq 'Titulo') { 18 } else { 14 }), ;")
        [void]$blocos.Add("        AutoSize  = .F., ;")
        [void]$blocos.Add("        Alignment = $($spec.Alignment), ;")
        [void]$blocos.Add("        FontName  = `"Tahoma`", ;")
        [void]$blocos.Add("        FontSize  = $($spec.FontSize), ;")
        if ($spec.FontBold) { [void]$blocos.Add("        FontBold  = .T., ;") }
        [void]$blocos.Add("        BackStyle = 0, ;")
        [void]$blocos.Add("        Caption   = `"`"")
        [void]$blocos.Add("")
    }

    # Reconstroi linhas: [0..idxInsercao-1] + blocos + [idxInsercao..end]
    $novasLinhas = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $idxInsercao; $i++) { [void]$novasLinhas.Add($linhas[$i]) }
    foreach ($ln in $blocos) { [void]$novasLinhas.Add($ln) }
    for ($i = $idxInsercao; $i -lt $linhas.Count; $i++) { [void]$novasLinhas.Add($linhas[$i]) }

    # Ajusta Height do form (+18 por Label adicionado)
    $heightExtra = 18 * $membrosFaltando.Count
    for ($i = 0; $i -lt $novasLinhas.Count; $i++) {
        if ($novasLinhas[$i] -match '^(\s*Height\s*=\s*)(\d+)(\s*)$') {
            $novoValor = [int]$Matches[2] + $heightExtra
            $novasLinhas[$i] = "$($Matches[1])$novoValor$($Matches[3])"
            break
        }
    }

    # Salva com encoding VFP9 compativel (cp1252)
    $conteudoFinal = ($novasLinhas -join "`r`n")
    [System.IO.File]::WriteAllText($StubPath, $conteudoFinal, [System.Text.Encoding]::GetEncoding(1252))

    foreach ($nome in $membrosFaltando) {
        Add-Correcao -Tipo "FWPROGRESSBAR-STUB-MEMBRO" -Linha $idxInsercao -Original "(ausente)" -Corrigido "ADD OBJECT $nome AS Label" -Descricao "Pattern #116: membro '$nome' adicionado ao stub classes/fwprogressbar.prg. Membros esperados pela interface do framework legado nao podem estar ausentes -- forms migrados quebrariam com 'Unknown member $($nome.ToUpper())'."
    }

    Write-Host "Pattern #116: adicionados $($membrosFaltando.Count) Label(s) ao stub, Height +$heightExtra" -ForegroundColor Green
    return $true
}

#==============================================================================
# Pattern #117: Corrigir-ReportFormSemGuard
# Detecta chamadas REPORT FORM via macro substitution (`REPORT FORM &<var>.`)
# sem guard IF FILE() e substitui por helper canonico THIS.ExecutarReportForm.
#
# ANTES:
#   LOCAL loc_cReportPathX
#   loc_cReportPathX = gc_4c_CaminhoReports + "SIGREPEX"
#   REPORT FORM &loc_cReportPathX. PREVIEW NOCONSOLE
#
# DEPOIS:
#   THIS.ExecutarReportForm("SIGREPEX", "PREVIEW")
#
# Se helper ExecutarReportForm nao existe no arquivo, injeta antes da primeira
# procedure que emite REPORT FORM. Modos: PREVIEW / PRINTER_PROMPT / PRINTER.
#
# Origem: Bug Erro27 (2026-07-07) - Formsigrepes.prg linha 5533 procedure
#         Visualizacao estourou "File does not exist" ao abrir SIGREPEX.frx
#         (nao portado). Runtime nao indicava qual FRX faltava. Helper mostra
#         path completo pro dev criar.
#==============================================================================
function Corrigir-ReportFormSemGuard {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Regex para linha REPORT FORM &<var>[.] OU REPORT FORM (<var>), <SUFIXO> [NOCONSOLE]
    # Cobre duas formas:
    #   (a) Macro:      REPORT FORM &loc_cReportPath.  PREVIEW NOCONSOLE
    #   (b) Parenteses: REPORT FORM (loc_cFrxPath)     PREVIEW NOCONSOLE
    # Dot terminator do & eh opcional (VFP9 aceita `&var.` e `&var<space>`).
    # NOCONSOLE eh opcional (helper injeta NOCONSOLE sempre).
    $reportFormRegex = '^(\s*)REPORT\s+FORM\s+(?:&(\w+)\.?|\((\w+)\))\s+(.+?)(?:\s+NOCONSOLE)?\s*$'
    # Regex para atribuicao: <var> = gc_4c_CaminhoReports + "BASE" ou "BASE.frx"
    # (parenteses forma frequentemente usa "BASE.frx" no valor)
    $atribRegexTemplate = '^\s*{0}\s*=\s*gc_4c_CaminhoReports\s*\+\s*"([^"]+)"\s*$'
    $localRegexTemplate = '^\s*LOCAL\s+{0}\s*$'

    $substituicoes = @{}
    $indexesRemover = @{}
    $bloqueiosVariaveis = @{}  # varName -> $true (evita colisao entre chamadas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -notmatch $reportFormRegex) { continue }

        $indent  = $Matches[1]
        # $Matches[2] = macro varName (form a); $Matches[3] = parens varName (form b)
        $varName = if ([string]::IsNullOrEmpty($Matches[2])) { $Matches[3] } else { $Matches[2] }
        $sufixo  = $Matches[4].Trim().ToUpper()

        $modo = $null
        if     ($sufixo -match '^PREVIEW$')                { $modo = 'PREVIEW' }
        elseif ($sufixo -match '^TO\s+PRINTER\s+PROMPT$')  { $modo = 'PRINTER_PROMPT' }
        elseif ($sufixo -match '^TO\s+PRINTER$')           { $modo = 'PRINTER' }
        if ($null -eq $modo) { continue }

        # Rastrear ate 8 linhas atras a atribuicao a $varName
        $atribRegex = [string]::Format($atribRegexTemplate, [regex]::Escape($varName))
        $baseNome = $null
        $atribuicaoIdx = -1
        $limInf = [Math]::Max(0, $i - 8)
        for ($j = $i - 1; $j -ge $limInf; $j--) {
            if ($Linhas[$j] -match $atribRegex) {
                # Strip .frx do valor (parenteses form frequentemente inclui: "SigReVis.frx")
                $baseNome = $Matches[1] -replace '(?i)\.frx$', ''
                $atribuicaoIdx = $j
                break
            }
        }
        if ($null -eq $baseNome) { continue }

        # Verificar LOCAL <var> na linha anterior a atribuicao
        $localIdx = -1
        if ($atribuicaoIdx -gt 0) {
            $localRegex = [string]::Format($localRegexTemplate, [regex]::Escape($varName))
            if ($Linhas[$atribuicaoIdx - 1] -match $localRegex) {
                $localIdx = $atribuicaoIdx - 1
            }
        }

        $substituicoes[$i] = [PSCustomObject]@{
            Indent     = $indent
            Base       = $baseNome
            Modo       = $modo
            VarName    = $varName
            AtribIdx   = $atribuicaoIdx
            LocalIdx   = $localIdx
            LinhaOrig  = $linha
        }
        if ($localIdx -ge 0) { $indexesRemover[$localIdx] = $true }
        $indexesRemover[$atribuicaoIdx] = $true
    }

    if ($substituicoes.Count -eq 0) { return $Linhas }

    # Helper ja existe?
    $helperExiste = $false
    foreach ($ln in $Linhas) {
        if ($ln -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+ExecutarReportForm\b') {
            $helperExiste = $true
            break
        }
    }

    # Se ausente, encontrar ponto de insercao: primeira PROCEDURE que contem REPORT FORM
    $helperInsertIdx = -1
    if (-not $helperExiste) {
        $primeiroReportIdx = ($substituicoes.Keys | Sort-Object)[0]
        for ($k = $primeiroReportIdx; $k -ge 0; $k--) {
            if ($Linhas[$k] -match '(?i)^\s*PROCEDURE\s+\w+') {
                $helperInsertIdx = $k
                break
            }
        }
        if ($helperInsertIdx -lt 0) {
            # Sem PROCEDURE anterior - nao seguro injetar
            return $Linhas
        }
    }

    # Bloco do helper canonico (com isolamento de locale + REPORTBEHAVIOR 80 +
    # guard cursor vazio). FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    # SET POINT="." (US) e renderizados em modo REPORTBEHAVIOR 80. Executar no
    # VFP9 default (POINT="," BR + REPORTBEHAVIOR 90) causa overflow visual em
    # campos numericos (asteriscos "*****") mesmo com valores curtos.
    # Guard cursor vazio (par_cCursorDados opcional): evita preview em branco
    # / impressao vazia sem mensagem quando SELECT retorna 0 registros.
    # Origem: Erro28 (asteriscos, 2026-07-07) + Erro30 (cursor vazio, 2026-07-07).
    $helperBloco = @(
        '    *-- ============================================================',
        '    *-- PROCEDURE ExecutarReportForm (Pattern #117)',
        '    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,',
        '    *-- exibe MostrarErro descritivo com o path faltante.',
        '    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM',
        '    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com',
        '    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede',
        '    *-- fontes em runtime e mostra asteriscos em campos numericos.',
        '    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"',
        '    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,',
        '    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.',
        '    *-- ============================================================',
        '    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)',
        '        LOCAL loc_cFRX',
        '        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")',
        '',
        '        IF NOT FILE(loc_cFRX)',
        '            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;',
        '                loc_cFRX + CHR(13) + CHR(13) + ;',
        '                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")',
        '            RETURN .F.',
        '        ENDIF',
        '',
        '        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)',
        '        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)',
        '            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0',
        '                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;',
        '                    "Aten" + CHR(231) + CHR(227) + "o")',
        '                RETURN .F.',
        '            ENDIF',
        '        ENDIF',
        '',
        '        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)',
        '        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig',
        '        loc_cPointOrig    = SET("POINT")',
        '        loc_cSepOrig      = SET("SEPARATOR")',
        '        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")',
        '        SET POINT TO "."',
        '        SET SEPARATOR TO ","',
        '        SET REPORTBEHAVIOR 80',
        '',
        '        DO CASE',
        '            CASE par_cModo == "PREVIEW"',
        '                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE',
        '            CASE par_cModo == "PRINTER_PROMPT"',
        '                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE',
        '            CASE par_cModo == "PRINTER"',
        '                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE',
        '        ENDCASE',
        '',
        '        SET POINT TO (loc_cPointOrig)',
        '        SET SEPARATOR TO (loc_cSepOrig)',
        '        SET REPORTBEHAVIOR (loc_nBehaviorOrig)',
        '',
        '        RETURN .T.',
        '    ENDPROC',
        ''
    )

    # Mapa idxLinha -> nova linha (chamada helper)
    $substituicoesPorIdx = @{}
    foreach ($idx in $substituicoes.Keys) {
        $info = $substituicoes[$idx]
        $substituicoesPorIdx[[int]$idx] = "$($info.Indent)THIS.ExecutarReportForm(""$($info.Base)"", ""$($info.Modo)"")"
    }

    # Reconstruir array de linhas
    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if (-not $helperExiste -and $i -eq $helperInsertIdx) {
            foreach ($hl in $helperBloco) { [void]$resultado.Add($hl) }
        }
        if ($substituicoesPorIdx.ContainsKey($i)) {
            [void]$resultado.Add($substituicoesPorIdx[$i])
            continue
        }
        if ($indexesRemover.ContainsKey($i)) {
            continue
        }
        [void]$resultado.Add($Linhas[$i])
    }

    # Registrar correcoes
    foreach ($idx in $substituicoes.Keys) {
        $info = $substituicoes[$idx]
        $sufixoLegivel = switch ($info.Modo) {
            'PREVIEW'        { 'PREVIEW' }
            'PRINTER_PROMPT' { 'TO PRINTER PROMPT' }
            'PRINTER'        { 'TO PRINTER' }
        }
        Add-Correcao -Tipo "REPORT-FORM-SEM-GUARD" -Linha ($idx + 1) `
            -Original "REPORT FORM &$($info.VarName). $sufixoLegivel NOCONSOLE" `
            -Corrigido "THIS.ExecutarReportForm(""$($info.Base)"", ""$($info.Modo)"")" `
            -Descricao "Pattern #117: REPORT FORM macro sem guard IF FILE() substituido por helper canonico. Sem guard, FRX legado nao portado estoura runtime 'File does not exist' sem indicar qual arquivo."
    }
    if (-not $helperExiste) {
        Add-Correcao -Tipo "REPORT-FORM-HELPER-INJETADO" -Linha ($helperInsertIdx + 1) `
            -Original "(helper ExecutarReportForm ausente)" `
            -Corrigido "PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)" `
            -Descricao "Pattern #117: helper ExecutarReportForm injetado antes da primeira procedure que emite REPORT FORM."
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #118: Corrigir-SelectLocalVarSemMPrefix
# Detecta blocos SELECT VFP local (SELECT ... FROM cursor ... INTO CURSOR ...
# READWRITE) e prefixa `loc_c\w+` com `m.` onde nao ja qualificado por table
# alias (crXxx.) ou ja com `m.`.
#
# VFP name resolution: identificador solto em SELECT/GROUP BY/IIF/SUM/WHERE
# tenta primeiro COLUNA de tabela do FROM, depois memory variable. Sem `m.`,
# runtime estoura "SQL: Column 'LOC_CXXX' is not found".
#
# Escopo: SOMENTE blocos SELECT-INTO-CURSOR (VFP local). NAO afeta SQLEXEC
# (SQL Server, onde vars sao embutidas via EscaparSQL).
#
# Deteccao de bloco:
#   - Inicio: linha comeca com `SELECT ` (case-insensitive), fora de string
#   - Fim: linha contem `INTO CURSOR` (com ou sem READWRITE)
#   - Continuacao: SELECTs multi-linha usam `;` como line terminator VFP
#
# Prefixo: para cada palavra matching `\bloc_c\w+\b` na linha:
#   - Se ja prefixado com `m.` -> pular
#   - Se ja qualificado com `<alias>.<loc_c...>` (alias.<x>) -> pular
#   - Senao -> prefixar com `m.` (idempotente em segunda passada)
#
# Origem: Erro30-b (2026-07-07, sigrevtoBO.prg PrepararDados linhas 239-283).
#==============================================================================
function Corrigir-SelectLocalVarSemMPrefix {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # FASE 1: identificar blocos SELECT-INTO-CURSOR completos (lookahead).
    # Marca linhas $i..$j onde $i abre um SELECT SQL e $j contem INTO CURSOR.
    # CRITERIO estrito para distinguir SQL SELECT de work-area SELECT:
    #   SQL SELECT deve conter na 1a linha um dos: `*`, virgula, `TOP`, `FROM`, OU
    #   terminar com `;` (multi-linha).
    #   Alem disso, o bloco deve conter `INTO CURSOR` em ate 40 linhas apos start.
    # Work-area SELECT (skip): `SELECT alias` sozinho na linha, sem `,`/`FROM`/`;`/`*`.
    $regexSelectStart = '^\s*SELECT\s+'
    $regexSqlHint     = '(?i)^\s*SELECT\s+(?:\*|TOP\s|DISTINCT\s|.+?,|.+?\bFROM\b)'
    $regexMultiLine   = ';\s*(&&.*)?$'
    $regexIntoCursor  = '(?i)\bINTO\s+CURSOR\b'
    # Variavel loc_cXxx nao precedida por `m.` ou `<alias>.`
    $regexVarLoc = '(?<![\w.])loc_c\w+(?![\w])'
    # Controle de fluxo dentro do bloco (nao aplicar prefixo)
    $regexControleFluxo = '(?i)^\s*(LOCAL|IF|ELSE|ENDIF|FOR |ENDFOR|DO |ENDDO|CASE|ENDCASE|OTHERWISE|WHILE|ENDWHILE|SCAN|ENDSCAN|TRY|CATCH|ENDTRY|RETURN|SET\s|USE\s|SQLEXEC\()'

    $blocosSelect = @{}  # idxLinha -> $true se dentro de bloco valido

    $i = 0
    while ($i -lt $Linhas.Count) {
        $linha = $Linhas[$i]
        if ($linha -match $regexSelectStart) {
            # A linha inicial deve parecer SQL (tem `,`, `FROM`, `*`, ou continuacao `;`)
            $ehSqlSelect = ($linha -match $regexSqlHint) -or ($linha -match $regexMultiLine)
            if ($ehSqlSelect) {
                # Procura INTO CURSOR nas proximas 40 linhas
                $intoIdx = -1
                $maxLook = [Math]::Min($Linhas.Count, $i + 40)
                for ($j = $i; $j -lt $maxLook; $j++) {
                    if ($Linhas[$j] -match $regexIntoCursor) {
                        $intoIdx = $j
                        break
                    }
                    # Corta bloco cedo se encontrar linha sem continuacao `;` e sem FROM/GROUP/etc
                    # (bloco SQL SELECT quebra imediatamente)
                    if ($j -gt $i -and $Linhas[$j] -notmatch $regexMultiLine -and $Linhas[$j] -notmatch $regexIntoCursor) {
                        # Ultima linha do bloco sem INTO CURSOR: nao eh SELECT-INTO-CURSOR
                        break
                    }
                }
                if ($intoIdx -ge 0) {
                    # Marca todo o bloco $i..$intoIdx como candidato ao prefixo
                    for ($k = $i; $k -le $intoIdx; $k++) {
                        $blocosSelect[$k] = $true
                    }
                    $i = $intoIdx + 1
                    continue
                }
            }
        }
        $i++
    }

    if ($blocosSelect.Count -eq 0) { return $Linhas }

    # FASE 2 DESABILITADA (Erro33 2026-07-08 refinement 2): a normalizacao de
    # alias -> memvar conflitava com o padrao REPORT onde alias PRECISA ser
    # diferente do memvar (nome esperado pelo FRX legado, ex: `loc_cMoeda AS
    # lcMoeda`). Reverter alias -> memvar quebrava o binding do FRX.
    # Regra atualizada: NAO renomear aliases automaticamente. O caller (prompt
    # ou revisao manual) decide o alias correto conforme contexto:
    #   - REPORT com FRX legado: `<memvar_novo> AS <coluna_do_legado>`
    #   - GROUP BY sobre memvar: usar o ALIAS (nome escolhido) — resolve unambiguamente
    #   - Nao-REPORT / sem GROUP BY: qualquer alias OK
    # Bugs originarios: Erro31 (alias arbitrario causava GROUP BY fail) — fix
    # canonico e usar `GROUP BY <alias>` em vez de `GROUP BY <memvar>`.
    # Erro33 (alias == memvar em SELECT list quebrava FRX) — fix canonico e
    # alinhar alias ao nome esperado pelo FRX.
    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        [void]$resultado.Add($Linhas[$i])
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #119: Corrigir-FormatarDataSQLDatetime
# Detecta chamadas `FormatarDataSQL(DATETIME())` e substitui por literal
# "GETDATE(), " (fragmento SQL Server) — a funcao FormatarDataSQL historicamente
# checava `VARTYPE(pdData) != "D"` e retornava "NULL" quando recebia DATETIME
# (tipo T). Isso quebrava INSERT em LogAuditoria.DataHora (NOT NULL) — Erro35
# 2026-07-08 no relatorio "Log de Acessos" (SigReAacBO.RegistrarAuditoria).
# GETDATE() eh a funcao SQL Server nativa avaliada server-side, padrao canonico
# do BusinessBase.RegistrarAuditoria (classes/businessbase.prg:267).
# Escopo: BOs REPORT que sobrescrevem RegistrarAuditoria com auditoria custom.
# 4 BOs afetados na descoberta (SigReAacBO, SIGREDESBO, SigReDdpBO, sigredocBO).
# Complementa: melhora sistemica em FormatarDataSQL (utils/functions.prg) para
# aceitar tipos D e T e produzir 'YYYY-MM-DD HH:MM:SS' para T.
# Origem: Erro35 (2026-07-08).
#==============================================================================
function Corrigir-FormatarDataSQLDatetime {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Padrao: FormatarDataSQL(DATETIME()) (com variacoes de espacamento)
    $regex = '(?i)FormatarDataSQL\s*\(\s*DATETIME\s*\(\s*\)\s*\)'

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match $regex) {
            $novaLinha = [regex]::Replace($linha, $regex, "GETDATE()")
            Add-Correcao -Tipo "FORMATARDATASQL-DATETIME" -Linha ($i + 1) `
                -Original $linha.Trim() `
                -Corrigido $novaLinha.Trim() `
                -Descricao "Pattern #119: FormatarDataSQL(DATETIME()) retorna 'NULL' (bug historico: filtro VARTYPE=='D' rejeitava tipo T). Substituido por GETDATE() (funcao SQL Server avaliada server-side, padrao canonico BusinessBase.RegistrarAuditoria). Origem Erro35 (2026-07-08)."
            $linha = $novaLinha
        }
        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #120: Corrigir-MacroMPrefixQuebrado
# Detecta o anti-pattern `&m.<var>.` gerado por Pattern #118 aplicando `m.`
# indiscriminadamente. Dentro do macro operator `&`, o `.` termina o nome —
# `&m.loc_cWhere.` tenta expandir a variavel `m` (nao existe) → VFP9 erro 10
# "Syntax error." aborta o SELECT/REPORT. A regra `m.` do Pattern #118 vale
# APENAS para refs normais (SELECT list, WHERE column ops, function args,
# GROUP BY), NUNCA dentro de macro `&`.
# Substituicao: `&m.` -> `&` (safe global replace — `&m.` NUNCA eh construcao
# valida em VFP9; o unico "m." legitimo eh prefixo de escopo memvar em refs
# normais, e essa forma nao aparece com `&` na frente).
# Idempotente. Complementa Pattern #118 excluindo macros do escopo do fix.
# Origem: Erro37 (2026-07-14) — SIGREADSBO.PrepararDados linha 492
# (WHERE &m.loc_cWhere1.). Varredura global: 13 ocorrencias em 8 arquivos.
#==============================================================================
function Corrigir-MacroMPrefixQuebrado {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # &m. sempre indica macro quebrada em VFP9. Padrao: & (literal), m (literal), . (literal)
    # Nao pode aparecer em codigo VFP valido.
    $regex = '&m\.'

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match $regex) {
            $novaLinha = [regex]::Replace($linha, $regex, '&')
            Add-Correcao -Tipo "MACRO-M-PREFIX-QUEBRADO" -Linha ($i + 1) `
                -Original $linha.Trim() `
                -Corrigido $novaLinha.Trim() `
                -Descricao "Pattern #120: `&m.<var>.` eh macro quebrada — VFP9 le o nome do macro ate o primeiro `.`, entao `&m.` tenta expandir variavel `m` (nao existe) e estoura Erro 10 'Syntax error.'. A regra `m.` do Pattern #118 vale APENAS para refs normais dentro de SELECT VFP local, NUNCA dentro de macro `&`. Substituido por `&<var>.` (sem prefixo m.). Origem Erro37 (2026-07-14, SIGREADSBO)."
            $linha = $novaLinha
        }
        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #121: Corrigir-GridColumnCheckboxSparse
# Detecta blocos WITH ... Column1 (ou Column2, etc) que contem
# `CurrentControl = "Check1"` mas NAO contem `Sparse = .F.` — injeta a linha.
# Default VFP9 eh Sparse=.T., que renderiza o CurrentControl (CheckBox)
# APENAS na linha corrente do grid — outras linhas mostram valor bruto (0/1)
# como texto plano, quebrando UX de checkbox column.
# Padrao canonico: Formsigrepes.prg:3095-3104.
# Origem: Erro41 (2026-07-14) — FormSIGREADS grd_4c_TipoOps + grd_4c_Grupos.
# Idempotente: nao afeta blocos que ja tem Sparse (=.F. ou =.T.).
#==============================================================================
function Corrigir-GridColumnCheckboxSparse {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    $resultado = New-Object System.Collections.ArrayList
    $i = 0
    while ($i -lt $Linhas.Count) {
        $linha = $Linhas[$i]

        # Detecta inicio de bloco WITH ... .ColumnN (case-insensitive)
        if ($linha -match '^\s*WITH\s+.+\.Column\d+\s*$') {
            # Coletar bloco ate ENDWITH
            $blocoLinhas = New-Object System.Collections.ArrayList
            [void]$blocoLinhas.Add($linha)
            $j = $i + 1
            $temCurrentControlCheck1 = $false
            $temSparse = $false
            $temAddObjectCheck1 = $false
            $idxAddObjectCheck1 = -1
            $indentBloco = ''
            if ($linha -match '^(\s+)') { $indentBloco = $Matches[1] }

            while ($j -lt $Linhas.Count) {
                $l = $Linhas[$j]
                [void]$blocoLinhas.Add($l)
                if ($l -match '^\s*ENDWITH\s*$') { break }
                if ($l -match '(?i)CurrentControl\s*=\s*[''"]Check1[''"]') { $temCurrentControlCheck1 = $true }
                if ($l -match '(?i)\.Sparse\s*=\s*') { $temSparse = $true }
                if ($l -match '(?i)\.AddObject\s*\(\s*[''"]Check1[''"]\s*,\s*[''"]CheckBox[''"]\s*\)') {
                    $temAddObjectCheck1 = $true
                    $idxAddObjectCheck1 = $blocoLinhas.Count - 1
                }
                $j++
            }

            # Se e bloco Column CheckBox sem Sparse: injetar
            if ($temCurrentControlCheck1 -and -not $temSparse -and $temAddObjectCheck1) {
                # Determinar indent interno (linha apos WITH)
                $indentInterno = $indentBloco + '    '
                if ($blocoLinhas.Count -ge 2) {
                    $linha1 = $blocoLinhas[1]
                    if ($linha1 -match '^(\s+)') { $indentInterno = $Matches[1] }
                }
                # Inserir Sparse=.F. ANTES do AddObject("Check1", ...)
                $linhaNova = $indentInterno + '.Sparse    = .F.'
                $blocoLinhas.Insert($idxAddObjectCheck1, $linhaNova)

                Add-Correcao -Tipo "GRID-CHECKBOX-SPARSE" -Linha ($i + 1) `
                    -Original "Column CheckBox sem .Sparse = .F." `
                    -Corrigido ".Sparse = .F. injetado antes de AddObject Check1" `
                    -Descricao "Pattern 121: Grid Column com CurrentControl=Check1 sem .Sparse=.F. renderiza CheckBox APENAS na linha corrente (default VFP9 Sparse=.T.); outras linhas mostram valor bruto (0/1) como texto plano. Usuario NAO consegue clicar checkboxes das demais linhas. Injetado .Sparse=.F. antes de AddObject Check1. Padrao canonico Formsigrepes.prg linhas 3095-3104. Origem Erro41 (2026-07-14 FormSIGREADS)."
            }

            # Emitir bloco (modificado ou nao)
            foreach ($bl in $blocoLinhas) { [void]$resultado.Add($bl) }
            $i = $j + 1
        } else {
            [void]$resultado.Add($linha)
            $i++
        }
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #122: Corrigir-BtnReportGuardEmptyMsgErro
# Detecta em forms REPORT o padrao:
#   MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ...)      <- property variant
#   MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ...)     <- method variant
# Wrap com guard `IF !EMPTY(<expr>) / MsgErro / ENDIF` (nested-IF style).
# Motivo: o helper canonico ExecutarReportForm (Pattern #117) exibe seu proprio
# MsgAviso quando cursor vazio ou FRX ausente e retorna .F. sem setar
# cMensagemErro — sem guard, MsgErro("") mostra modal com titulo "Relatorio" e
# corpo VAZIO em sequencia (Erro40, 2026-07-14 FormSIGREADS + Erro48, 2026-07-17
# FormSigReAni). Nested-IF eh SEGURO com ELSE branches (RegistrarAuditoria em
# sucesso) — a variante antiga `AND !EMPTY(...)` na condicao do IF externo
# quebrava semantica quando havia ELSE.
# Idempotente: skip se linha imediatamente anterior a MsgErro ja tem IF !EMPTY
# com mesma expressao, OU se IF externo ja tem AND !EMPTY (retrocompat).
#==============================================================================
function Corrigir-BtnReportGuardEmptyMsgErro {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Regex para detectar MsgErro(THIS.this_oRelatorio.<msg-source>, ...)
    # Captura: (1) indent, (2) fonte da mensagem (this_cMensagemErro OR ObterMensagemErro())
    $rxMsgErro = '(?i)^(\s*)MsgErro\s*\(\s*THIS\.this_oRelatorio\.(this_cMensagemErro|ObterMensagemErro\(\))'

    $resultado = New-Object System.Collections.ArrayList
    $i = 0

    while ($i -lt $Linhas.Count) {
        $linha = $Linhas[$i]

        if ($linha -match $rxMsgErro) {
            $indent = $Matches[1]
            $exprMsg = 'THIS.this_oRelatorio.' + $Matches[2]

            # Idempotencia: linha anterior ja tem IF !EMPTY com a mesma expr?
            $jaGuardado = $false
            if ($resultado.Count -gt 0) {
                $lnAnt = [string]$resultado[$resultado.Count - 1]
                $exprEscape = [regex]::Escape($exprMsg)
                if ($lnAnt -match ('(?i)IF\s+!\s*EMPTY\s*\(\s*' + $exprEscape + '\s*\)')) {
                    $jaGuardado = $true
                }
            }

            # Idempotencia retrocompat: IF externo (walk back) ja tem AND !EMPTY?
            if (-not $jaGuardado) {
                $k = $resultado.Count - 1
                while ($k -ge 0 -and $k -ge $resultado.Count - 6) {
                    $lnBack = [string]$resultado[$k]
                    if ($lnBack -match '(?i)AND\s+!\s*EMPTY\s*\(\s*THIS\.this_oRelatorio\.(this_cMensagemErro|ObterMensagemErro\(\))') {
                        $jaGuardado = $true
                        break
                    }
                    if ($lnBack -match '(?i)^\s*IF\s+') { break }
                    $k--
                }
            }

            if ($jaGuardado) {
                [void]$resultado.Add($linha)
                $i++
                continue
            }

            # Descobrir extensao do bloco MsgErro (single-line ou continuation com ;)
            $blocoMsgErro = @($linha)
            $j = $i
            while ($j -lt $Linhas.Count - 1 -and $Linhas[$j] -match ';\s*$') {
                $j++
                $blocoMsgErro += $Linhas[$j]
            }

            # Injetar guard nested-IF (mais seguro que AND !EMPTY — funciona com ELSE)
            [void]$resultado.Add($indent + 'IF !EMPTY(' + $exprMsg + ')')
            foreach ($ln in $blocoMsgErro) { [void]$resultado.Add($ln) }
            [void]$resultado.Add($indent + 'ENDIF')

            Add-Correcao -Tipo "BTN-REPORT-EMPTY-MSGERRO-GUARD" -Linha ($i + 1) `
                -Original $linha.Trim() `
                -Corrigido ("IF !EMPTY(" + $exprMsg + ") / MsgErro / ENDIF") `
                -Descricao "Pattern 122 (v2): MsgErro(<msg-source>, ...) em BtnVisualizarClick/BtnImprimirClick sem guard EMPTY. Helper ExecutarReportForm (Pattern 117) mostra MsgAviso proprio quando cursor vazio/FRX ausente e retorna .F. sem cMensagemErro, causando SEGUNDO modal com titulo Relatorio e corpo VAZIO. Wrap com nested IF !EMPTY (seguro com ELSE branches). Cobre variantes this_cMensagemErro (property) e ObterMensagemErro() (method). Origens: Erro40 (2026-07-14 FormSIGREADS) + Erro48 (2026-07-17 FormSigReAni)."

            $i = $j + 1
            continue
        }

        [void]$resultado.Add($linha)
        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #124: Corrigir-ReportFormToPrintTypo
# Corrige o typo `TO PRINT` -> `TO PRINTER` em REPORT FORM. `TO PRINT` NAO eh
# sintaxe valida do VFP9 (correto eh `TO PRINTER [PROMPT]`). Deve rodar ANTES
# dos Patterns #117 e #123 para normalizar a sintaxe antes das transformacoes
# via helper. Idempotente (nao afeta `TO PRINTER` ja correto).
# Origem: sweep 2026-07-14 detectou 48 linhas com o typo.
#==============================================================================
function Corrigir-ReportFormToPrintTypo {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Regex 1: REPORT FORM ... TO PRINT [PROMPT] [NOCONSOLE] (mesma linha)
    # Case-insensitive. \b garante word boundary (evita match em PRINTER ja correto).
    $rx = '(?i)(REPORT\s+FORM\s+.+?\s+TO\s+)PRINT(\b(?!ER))'
    # Regex 2: linha de continuacao (REPORT FORM ... ;\n    TO PRINT ...)
    # Match apenas quando linha comeca (whitespace) + TO PRINT — evita false positive
    # em strings literais que contem "TO PRINT" (nao comecam na linha).
    $rxCont = '(?i)^(\s*TO\s+)PRINT(\b(?!ER))'

    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -match $rx) {
            $novaLinha = [regex]::Replace($linha, $rx, '${1}PRINTER${2}')
            Add-Correcao -Tipo "REPORT-FORM-TO-PRINT-TYPO" -Linha ($i + 1) `
                -Original $linha.Trim() `
                -Corrigido $novaLinha.Trim() `
                -Descricao "Pattern 124: REPORT FORM ... TO PRINT nao eh sintaxe valida do VFP9; correto eh TO PRINTER [PROMPT]. Typo comum em BOs migrados. Substituido TO PRINT -> TO PRINTER preservando PROMPT/NOCONSOLE. Idempotente."
            $linha = $novaLinha
        }
        elseif ($linha -match $rxCont) {
            # Continuacao de linha; verificar se linha anterior tem REPORT FORM com `;`
            $ehContReport = $false
            if ($resultado.Count -gt 0) {
                $lnAnt = [string]$resultado[$resultado.Count - 1]
                if ($lnAnt -match '(?i)REPORT\s+FORM\s+.+;\s*$') {
                    $ehContReport = $true
                }
            }
            if ($ehContReport) {
                $novaLinha = [regex]::Replace($linha, $rxCont, '${1}PRINTER${2}')
                Add-Correcao -Tipo "REPORT-FORM-TO-PRINT-TYPO" -Linha ($i + 1) `
                    -Original $linha.Trim() `
                    -Corrigido $novaLinha.Trim() `
                    -Descricao "Pattern 124 (continuacao): TO PRINT em linha de continuacao apos REPORT FORM ... ;. Corrigido para TO PRINTER preservando PROMPT/NOCONSOLE."
                $linha = $novaLinha
            }
        }
        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #123: Corrigir-ReportFormConcatInline
# Estende o Pattern #117 para a forma inline concat:
#   REPORT FORM (gc_4c_CaminhoReports + "BASE") PREVIEW NOCONSOLE
#   REPORT FORM (gc_4c_CaminhoReports + "BASE.frx") TO PRINTER PROMPT NOCONSOLE
# Pattern #117 nao pega essa variacao porque so aceita `(<var>)` ou `&<var>.`
# (variavel simples). Como 90+ BOs REPORT migrados usam a forma inline concat,
# vale um pattern dedicado que injeta o helper ExecutarReportForm quando ausente
# e substitui cada chamada por `THIS.ExecutarReportForm("BASE", "MODO")`.
# Idempotente. Helper canonico eh identico ao Pattern #117.
# Origem: sweep de 2026-07-14 apos Erro38 (SIGREADS FRX ausente) mostrou 90 BOs
# com essa forma nao coberta.
#==============================================================================
function Corrigir-ReportFormConcatInline {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Regex captura:
    #   Grupo 1: indent
    #   Grupo 2: BASE (com ou sem .frx)
    #   Grupo 3: SUFIXO (PREVIEW | TO PRINTER PROMPT | TO PRINTER)
    # NOCONSOLE eh opcional; strip .frx eh feito depois.
    $rx = '^(\s*)REPORT\s+FORM\s+\(\s*gc_4c_CaminhoReports\s*\+\s*"([^"]+)"\s*\)\s+(PREVIEW|TO\s+PRINTER\s+PROMPT|TO\s+PRINTER)(?:\s+NOCONSOLE)?\s*$'

    $substituicoes = @{}

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -notmatch $rx) { continue }

        $indent  = $Matches[1]
        $baseRaw = $Matches[2]
        $sufixo  = $Matches[3].Trim().ToUpper()

        $baseNome = $baseRaw -replace '(?i)\.frx$', ''

        $modo = $null
        if     ($sufixo -match '^PREVIEW$')                { $modo = 'PREVIEW' }
        elseif ($sufixo -match '^TO\s+PRINTER\s+PROMPT$')  { $modo = 'PRINTER_PROMPT' }
        elseif ($sufixo -match '^TO\s+PRINTER$')           { $modo = 'PRINTER' }
        if ($null -eq $modo) { continue }

        $substituicoes[$i] = [PSCustomObject]@{
            Indent    = $indent
            Base      = $baseNome
            Modo      = $modo
            LinhaOrig = $linha
        }
    }

    if ($substituicoes.Count -eq 0) { return $Linhas }

    # Verificar se helper ja existe
    $helperExiste = $false
    foreach ($ln in $Linhas) {
        if ($ln -match '(?i)^\s*(PROTECTED\s+)?PROCEDURE\s+ExecutarReportForm\b') {
            $helperExiste = $true
            break
        }
    }

    # Ponto de injecao: primeira PROCEDURE que emite REPORT FORM
    $helperInsertIdx = -1
    if (-not $helperExiste) {
        $primeiroReportIdx = ($substituicoes.Keys | Sort-Object)[0]
        for ($k = $primeiroReportIdx; $k -ge 0; $k--) {
            if ($Linhas[$k] -match '(?i)^\s*PROCEDURE\s+\w+') {
                $helperInsertIdx = $k
                break
            }
        }
        if ($helperInsertIdx -lt 0) { return $Linhas }
    }

    # Bloco helper canonico (identico ao Pattern #117)
    $helperBloco = @(
        '    *-- ============================================================',
        '    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)',
        '    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,',
        '    *-- exibe MostrarErro descritivo com o path faltante.',
        '    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM',
        '    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com',
        '    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede',
        '    *-- fontes em runtime e mostra asteriscos em campos numericos.',
        '    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"',
        '    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,',
        '    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.',
        '    *-- ============================================================',
        '    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)',
        '        LOCAL loc_cFRX',
        '        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")',
        '',
        '        IF NOT FILE(loc_cFRX)',
        '            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;',
        '                loc_cFRX + CHR(13) + CHR(13) + ;',
        '                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")',
        '            RETURN .F.',
        '        ENDIF',
        '',
        '        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)',
        '        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)',
        '            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0',
        '                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;',
        '                    "Aten" + CHR(231) + CHR(227) + "o")',
        '                RETURN .F.',
        '            ENDIF',
        '        ENDIF',
        '',
        '        *-- Isolamento de locale + modo de renderizacao (Erro28)',
        '        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig',
        '        loc_cPointOrig    = SET("POINT")',
        '        loc_cSepOrig      = SET("SEPARATOR")',
        '        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")',
        '        SET POINT TO "."',
        '        SET SEPARATOR TO ","',
        '        SET REPORTBEHAVIOR 80',
        '',
        '        DO CASE',
        '            CASE par_cModo == "PREVIEW"',
        '                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE',
        '            CASE par_cModo == "PRINTER_PROMPT"',
        '                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE',
        '            CASE par_cModo == "PRINTER"',
        '                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE',
        '        ENDCASE',
        '',
        '        SET POINT TO (loc_cPointOrig)',
        '        SET SEPARATOR TO (loc_cSepOrig)',
        '        SET REPORTBEHAVIOR (loc_nBehaviorOrig)',
        '',
        '        RETURN .T.',
        '    ENDPROC',
        ''
    )

    # Mapa idxLinha -> nova linha (chamada helper)
    $substituicoesPorIdx = @{}
    foreach ($idx in $substituicoes.Keys) {
        $info = $substituicoes[$idx]
        $substituicoesPorIdx[[int]$idx] = "$($info.Indent)THIS.ExecutarReportForm(""$($info.Base)"", ""$($info.Modo)"")"
    }

    # Reconstruir array de linhas
    $resultado = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if (-not $helperExiste -and $i -eq $helperInsertIdx) {
            foreach ($hl in $helperBloco) { [void]$resultado.Add($hl) }
        }
        if ($substituicoesPorIdx.ContainsKey($i)) {
            [void]$resultado.Add($substituicoesPorIdx[$i])
            continue
        }
        [void]$resultado.Add($Linhas[$i])
    }

    # Registrar correcoes
    foreach ($idx in $substituicoes.Keys) {
        $info = $substituicoes[$idx]
        Add-Correcao -Tipo "REPORT-FORM-CONCAT-INLINE" -Linha ($idx + 1) `
            -Original $info.LinhaOrig.Trim() `
            -Corrigido ("THIS.ExecutarReportForm(""" + $info.Base + """, """ + $info.Modo + """)") `
            -Descricao "Pattern 123: REPORT FORM (gc_4c_CaminhoReports + BASE) inline substituido por helper canonico THIS.ExecutarReportForm. Sem helper, FRX ausente estoura runtime File does not exist sem indicar arquivo; FRXs legados renderizam asteriscos em campos numericos no VFP9 default (REPORTBEHAVIOR 90 + POINT BR); cursor vazio abre preview em branco. Origem sweep 2026-07-14 (extensao do Pattern 117 para forma inline concat)."
    }
    if (-not $helperExiste) {
        Add-Correcao -Tipo "REPORT-FORM-HELPER-INJETADO" -Linha ($helperInsertIdx + 1) `
            -Original "(helper ExecutarReportForm ausente)" `
            -Corrigido "PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)" `
            -Descricao "Pattern 123: helper ExecutarReportForm injetado antes da primeira procedure que emite REPORT FORM (forma inline concat)."
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #125: Corrigir-SigCdEmpColunasInvalidas
# Bug: SigCdEmp tem colunas `Cemps` (char(3), codigo empresa) e `Razas` (char(40),
# razao social). Migracao inventa `Emps`/`emps` e `NComps`/`nemp` (nao existem)
# por analogia com SigCdBal.Emps ou com nomes de TextBox (`Get_Empresa`).
# Runtime: `[SQL Server]Nome de coluna 'Emps' invalido` ao digitar codigo empresa.
#
# CUIDADO: `SigCdBal.emps` e `SigIvTrh.emps` EXISTEM legitimamente.
# Regra so aplica quando FROM/2o arg de FormBuscaAuxiliar eh `SigCdEmp`.
#
# Fase 1: identificar cursores populados de SigCdEmp
#   (SELECT ... FROM SigCdEmp + destino nas 3 linhas seguintes,
#    ou CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmp", <cursor>, ...))
# Fase 2: substituir tokens Emps/NComps/emps/nemp por Cemps/Razas/cemps/razas
#   preservando case:
#   (a) linhas com SigCdEmp E token quebrado (SELECT/WHERE/JOIN)
#   (b) mAddColuna/CREATEOBJECT filter col dentro de bloco AbrirBusca* SigCdEmp
#   (c) refs <cursor>.emps/.nemp/.NComps para cursores identificados na Fase 1
#
# Origem: Erro44 (2026-07-16, FormSigReAiv.prg + FormSIGREHCP.prg).
# Idempotente.
#==============================================================================
function Corrigir-SigCdEmpColunasInvalidas {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Fase 1: identificar cursores derivados de SigCdEmp
    $cursoresEmp = @{}  # cursorName (case-insensitive) -> $true
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        # SQLEXEC: SELECT ... FROM SigCdEmp ... "cursor_X"
        if ($linha -match '(?i)FROM\s+SigCdEmp\b') {
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"(cursor_\w+)"\s*\)') {
                    $cursoresEmp[$Matches[1].ToLower()] = $true
                    break
                }
            }
        }
        # FormBuscaAuxiliar: CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmp", <cursor>, ...)
        if ($linha -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"SigCdEmp"\s*,\s*"(cursor_\w+)"') {
                    $cursoresEmp[$Matches[1].ToLower()] = $true
                    break
                }
                if ($Linhas[$j] -match '(?i)"SigCdEmp"\s*,\s*(\w+)') {
                    $cursorArg = $Matches[1]
                    if ($cursorArg -match '(?i)^loc_') {
                        # Var: buscar atribuicao anterior na PROCEDURE
                        for ($k = $j; $k -ge [Math]::Max(0, $j - 30); $k--) {
                            if ($Linhas[$k] -match "(?i)$cursorArg\s*=\s*`"(cursor_\w+)`"") {
                                $cursoresEmp[$Matches[1].ToLower()] = $true
                                break
                            }
                        }
                    }
                    break
                }
            }
        }
    }

    # ScriptBlock helper de substituicao case-preserving (inline para evitar scope)
    $substituirTokens = {
        param([string]$Texto)
        # Order: NComps/ncomps/DEmps antes de nemp/Emps para evitar sobreposicao acidental
        $r = $Texto
        $r = $r -creplace '\bNCOMPS\b', 'RAZAS'
        $r = $r -creplace '\bNComps\b', 'Razas'
        $r = $r -creplace '\bncomps\b', 'razas'
        $r = $r -creplace '\bNEMP\b',   'RAZAS'
        $r = $r -creplace '\bNemp\b',   'Razas'
        $r = $r -creplace '\bnemp\b',   'razas'
        $r = $r -creplace '\bDEMPS\b',  'RAZAS'
        $r = $r -creplace '\bDEmps\b',  'Razas'
        $r = $r -creplace '\bdemps\b',  'razas'
        $r = $r -creplace '\bEMPS\b',   'CEMPS'
        $r = $r -creplace '\bEmps\b',   'Cemps'
        $r = $r -creplace '\bemps\b',   'cemps'
        return $r
    }

    # Fase 2: corrigir linhas
    $resultado = [System.Collections.ArrayList]::new()
    $inSigCdEmpBusca = $false
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $original = $linha

        # Rastreio de bloco AbrirBusca sobre SigCdEmp
        if ($linha -match '(?i)^\s*PROCEDURE\s+\w+' -or $linha -match '(?i)^\s*ENDPROC\b') {
            $inSigCdEmpBusca = $false
        }
        if ($linha -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"') {
            # Olhar frente por "SigCdEmp" nas proximas 4 linhas
            for ($j = $i; $j -lt [Math]::Min($i + 4, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)"SigCdEmp"') {
                    $inSigCdEmpBusca = $true
                    break
                }
            }
        }
        if ($linha -match '(?i)^\s*loc_oBusca\.Release\s*\(') {
            $inSigCdEmpBusca = $false
        }

        # (a) Linha contem SigCdEmp E algum token quebrado (mesma linha)
        if ($linha -match '(?i)SigCdEmp' -and $linha -match '(?i)\b(emps|nemp|ncomps|NComps|demps|DEmps)\b') {
            $linha = & $substituirTokens $linha
        }

        # (b) Dentro de bloco AbrirBusca* de SigCdEmp: mAddColuna E argumentos do CREATEOBJECT
        if ($inSigCdEmpBusca) {
            # mAddColuna("emps"|...) -> mAddColuna("cemps"|...) preservando case
            if ($linha -match '(?i)mAddColuna\s*\(\s*"(emps|nemp|ncomps|demps|Emps|Nemp|NComps|DEmps|EMPS|NEMP|NCOMPS|DEMPS)"') {
                $linha = & $substituirTokens $linha
            }
            # 3o arg do CREATEOBJECT (filter col) — linha com "SigCdEmp"
            if ($linha -match '(?i)"SigCdEmp"\s*,\s*"[^"]+"\s*,\s*"(emps|nemp|ncomps|demps|Emps|Nemp|NComps|DEmps|EMPS|NEMP|NCOMPS|DEMPS)"') {
                $linha = & $substituirTokens $linha
            }
        }

        # (c) Referencias <cursor>.emps/.nemp/.NComps/.DEmps para cursores identificados
        foreach ($cursor in $cursoresEmp.Keys) {
            # Case-insensitive match do nome do cursor, case-preserving do campo
            $rxCursor = [regex]::Escape($cursor)
            if ($linha -imatch "$rxCursor\.\s*(emps|nemp|ncomps|demps|NComps|DEmps|Emps|Nemp|EMPS|NEMP|NCOMPS|DEMPS)\b") {
                $linha = [regex]::Replace($linha, "(?i)($rxCursor)(\.\s*)(EMPS|Emps|emps|NCOMPS|NComps|ncomps|NEMP|Nemp|nemp|DEMPS|DEmps|demps)\b", {
                    param($m)
                    $prefixo = $m.Groups[1].Value + $m.Groups[2].Value
                    $token   = $m.Groups[3].Value
                    switch -CaseSensitive ($token) {
                        'EMPS'   { return $prefixo + 'CEMPS' }
                        'Emps'   { return $prefixo + 'Cemps' }
                        'emps'   { return $prefixo + 'cemps' }
                        'NCOMPS' { return $prefixo + 'RAZAS' }
                        'NComps' { return $prefixo + 'Razas' }
                        'ncomps' { return $prefixo + 'razas' }
                        'NEMP'   { return $prefixo + 'RAZAS' }
                        'Nemp'   { return $prefixo + 'Razas' }
                        'nemp'   { return $prefixo + 'razas' }
                        'DEMPS'  { return $prefixo + 'RAZAS' }
                        'DEmps'  { return $prefixo + 'Razas' }
                        'demps'  { return $prefixo + 'razas' }
                        default  { return $m.Value }
                    }
                })
            }
        }

        if ($linha -ne $original) {
            Add-Correcao -Tipo "SIGCDEMP-COLUNAS-CANONICAS" -Linha ($i + 1) `
                -Original $original.Trim() `
                -Corrigido $linha.Trim() `
                -Descricao "Pattern #125: SigCdEmp tem colunas 'Cemps' (char(3), PK) e 'Razas' (char(40), razao social), NAO 'Emps'/'NComps'/'emps'/'nemp'. Runtime tipico: SQL Server 'Nome de coluna Emps invalido' ao digitar codigo empresa. Cuidado: SigCdBal.emps e SigIvTrh.emps EXISTEM - regra so aplica quando FROM/lookup eh SigCdEmp. Origem Erro44 (2026-07-16, FormSigReAiv + FormSIGREHCP)."
        }
        [void]$resultado.Add($linha)
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #126: Corrigir-SigCdEmpTextBoxMaxLength
# Bug: TextBox de codigo empresa (txt_4c_Empresa/CEmps/Emps) mapeia para
# SigCdEmp.Cemps (char(3)), mas o gerador omite MaxLength (default VFP9=0
# unlimited) ou estima por Width=33px (~2 chars) gerando MaxLength=2.
# User digita menos que 3 chars, SQL Server pad-completa e ValidarEmpresa
# retorna descricao — mas relatorio filtra SigCdBal.emps que nao acha
# registros (nomes de empresa geralmente sao 3 chars).
# Screenshot Erro45: "Empresa: [00] MARCELLA BAHIA" — user digitou "00".
#
# Deteccao: bloco WITH ... .txt_4c_(Empresa|C?Emps|CEmp) ate ENDWITH.
# Acao:
#   (a) .MaxLength = N com N != 3 -> altera para 3
#   (b) .MaxLength ausente -> injeta .MaxLength = 3 antes do ENDWITH
# Idempotente. Escopo estrito ao WITH do TextBox alvo.
#
# Origem: Erro45 (2026-07-16, FormSigReAiv screenshot + sweep 15 forms).
# Complementa Pattern #125 (mesma tabela SigCdEmp, dominio UI).
#==============================================================================
function Corrigir-SigCdEmpTextBoxMaxLength {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    $resultado = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    $i = 0
    while ($i -lt $resultado.Count) {
        $linha = $resultado[$i]
        # Detecta abertura de bloco WITH ...txt_4c_(Empresa|C?Emps|CEmp)
        if ($linha -match '(?i)^\s*WITH\s+.+\.txt_4c_(Empresa|C?Emps|CEmp)\s*$') {
            # Coletar bloco ate ENDWITH
            $idxMaxLen = -1
            $curVal = $null
            $idxEndWith = -1
            $indentInterno = ''
            $end = [Math]::Min($i + 60, $resultado.Count - 1)
            for ($j = $i + 1; $j -le $end; $j++) {
                $lj = $resultado[$j]
                if ($lj -match '(?i)^\s*ENDWITH\s*$') { $idxEndWith = $j; break }
                if ($lj -match '(?i)^(\s*)\.MaxLength\s*=\s*(\d+)') {
                    $idxMaxLen = $j
                    $curVal = [int]$Matches[2]
                }
                # Detecta indent do primeiro .Xxx=
                if ($indentInterno -eq '' -and $lj -match '^(\s*)\.\w+\s*=') {
                    $indentInterno = $Matches[1]
                }
            }

            if ($idxEndWith -lt 0) { $i++; continue }

            if ($idxMaxLen -ge 0) {
                # Caso (a): .MaxLength presente
                if ($curVal -ne 3) {
                    $original = $resultado[$idxMaxLen]
                    # Preserva indentacao + alinhamento original, so troca o valor
                    $novaLinha = $original -replace '(?i)(\.MaxLength\s*=\s*)\d+', ('${1}' + '3')
                    $resultado[$idxMaxLen] = $novaLinha
                    Add-Correcao -Tipo "SIGCDEMP-TEXTBOX-MAXLENGTH" -Linha ($idxMaxLen + 1) `
                        -Original $original.Trim() `
                        -Corrigido $novaLinha.Trim() `
                        -Descricao "Pattern #126: TextBox de codigo empresa (mapeia para SigCdEmp.Cemps char(3)) DEVE ter .MaxLength = 3. Valor $curVal estava permitindo entrada incorreta (2 chars aceita quando codigo real tem 3). Origem Erro45 (2026-07-16, FormSigReAiv)."
                }
            } else {
                # Caso (b): .MaxLength ausente - injetar
                if ($indentInterno -eq '') { $indentInterno = '            ' }
                $novaLinha = "$indentInterno.MaxLength   = 3"
                $resultado.Insert($idxEndWith, $novaLinha)
                Add-Correcao -Tipo "SIGCDEMP-TEXTBOX-MAXLENGTH" -Linha ($idxEndWith + 1) `
                    -Original "(.MaxLength ausente no WITH txt_4c_$($Matches[1]))" `
                    -Corrigido ".MaxLength = 3 injetado antes de ENDWITH" `
                    -Descricao "Pattern #126: TextBox de codigo empresa (mapeia para SigCdEmp.Cemps char(3)) sem .MaxLength - default VFP9 eh 0 (unlimited). Injetado .MaxLength = 3 antes do ENDWITH. Origem Erro45 (2026-07-16, FormSigReAiv)."
                # Reposiciona: pula o bloco (agora tem 1 linha a mais)
                $i = $idxEndWith + 1
                continue
            }
        }
        $i++
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

function Corrigir-ReportBOCursorDadosDeclarada {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Filtro rapido: sem THIS.this_cCursorDados no arquivo, skip
    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)THIS\.this_cCursorDados') { return $Linhas }

    # Se ja tem declaracao (linha `this_cCursorDados = ...`), skip - idempotente
    if ($conteudo -match '(?im)^\s*this_cCursorDados\s*=') { return $Linhas }

    # Localiza DEFINE CLASS XxxBO AS RelatorioBase (case-insensitive)
    $idxDefineClass = -1
    $idxEndDefine = -1
    $classBase = ''
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($idxDefineClass -lt 0 -and $Linhas[$i] -match '(?i)^\s*DEFINE\s+CLASS\s+(\w+)\s+AS\s+RelatorioBase\b') {
            $idxDefineClass = $i
            $classBase = $Matches[1]
        }
        elseif ($idxDefineClass -ge 0 -and $Linhas[$i] -match '(?i)^\s*ENDDEFINE\b') {
            $idxEndDefine = $i
            break
        }
    }

    if ($idxDefineClass -lt 0) { return $Linhas }
    if ($idxEndDefine -lt 0) { $idxEndDefine = $Linhas.Count - 1 }

    # Localiza a ultima property `this_XXX =` no bloco (para antes do primeiro PROCEDURE/FUNCTION)
    $idxUltimaProperty = -1
    $indentProperty = ''
    for ($i = $idxDefineClass + 1; $i -le $idxEndDefine; $i++) {
        # Para no primeiro PROCEDURE/FUNCTION (fim do bloco de props)
        if ($Linhas[$i] -match '(?i)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\b') {
            break
        }
        # Match property padrao 'this_<name> = <value>'
        if ($Linhas[$i] -match '^(\s*)this_\w+\s*=') {
            $idxUltimaProperty = $i
            $indentProperty = $Matches[1]
        }
    }

    if ($idxUltimaProperty -lt 0) { return $Linhas }

    # Injetar apos a ultima property
    $resultado = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $Linhas.Count; $i++) { [void]$resultado.Add($Linhas[$i]) }

    $novaLinha1 = ''
    $novaLinha2 = $indentProperty + '*-- Pattern #142: injetado pelo CorretorAutomatico (default vazio) - REVISAR e substituir pelo alias do cursor binding do FRX'
    $novaLinha3 = $indentProperty + 'this_cCursorDados = ""     && FIXME Pattern #142 pos-Erro51'

    $resultado.Insert($idxUltimaProperty + 1, $novaLinha3)
    $resultado.Insert($idxUltimaProperty + 1, $novaLinha2)
    $resultado.Insert($idxUltimaProperty + 1, $novaLinha1)

    Add-Correcao -Tipo "REPORTBO-CURSORDADOS-DECLARADA" -Linha ($idxUltimaProperty + 2) `
        -Original "(this_cCursorDados NAO declarada em DEFINE CLASS $classBase AS RelatorioBase)" `
        -Corrigido "this_cCursorDados = `"`" injetado apos ultima property (linha $($idxUltimaProperty + 1))" `
        -Descricao "Pattern #142: BO REPORT $classBase chama THIS.ExecutarReportForm(base, modo, THIS.this_cCursorDados) mas nao declara a property - runtime crash 'Property THIS_CCURSORDADOS is not found'. Injetado default '' (vazio) para nao crashar (Pattern #117 guard 'VARTYPE==C AND !EMPTY' skip o cursor-vazio). REVISAR e substituir pelo alias do cursor binding do FRX legado (consultar PROCEDURE visualizacao em tasks/task<NNN>/<base>_form_codigo_fonte.txt - buscar cursor do ultimo SELECT/GO TOP antes do REPORT FORM). Origem Erro51 (2026-07-21, FormSIGREAEG)."

    Write-Host "[Pattern #142] $classBase - this_cCursorDados injetado VAZIO - REVISAR e substituir pelo alias do FRX legado" -ForegroundColor Yellow

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #143: Corrigir-IndexOnCollateGeneralWarning
# WARNING-only: sinaliza INDEX ON com chave composta grande em BOs REPORT.
# Sob SET COLLATE TO "GENERAL" (config.prg:182) o limite maximo de chave CDX
# cai de 240 para ~120 bytes. Chaves grandes estouram: "Invalid key length.".
# Correcao manual sugerida: usar ORDER BY no SELECT-SQL (sort in-memory nao
# tem esse limite; ordem de registros eh o que REPORT FORM precisa para
# grupos FRX). Alternativa: SET COLLATE TO "MACHINE" antes do INDEX ON e
# restaurar depois.
# Origem: Erro53 (2026-07-21, FormSIGREAUP, SIGREAUPBO linha 210):
#   INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem
#   com Quebra1/Quebra2 max=72 chars → total 162 → 324 bytes sob GENERAL.
# NAO auto-refactor porque:
#   (a) INDEX ON usado para SEEK precisa continuar como INDEX (nao vira ORDER BY).
#   (b) Detectar se INDEX eh usado apenas para REPORT FORM eh AST-level.
#   (c) SUBSTR-truncar componentes altera semantica de ordenacao.
# WARNING amarelo permite dev decidir per-case.
#==============================================================================
function Corrigir-IndexOnCollateGeneralWarning {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Filtro: aplica apenas em BOs REPORT (herdam RelatorioBase)
    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)DEFINE\s+CLASS\s+\w+\s+AS\s+RelatorioBase\b') {
        return $Linhas
    }

    # INDEX ON <expr>+<expr>+... TAG <tag>
    # Heuristica: 3+ concatenacoes (2+ operadores "+") indicam chave composta grande
    $rx = '^(\s*)INDEX\s+ON\s+(.+?)\s+TAG\s+(\w+)\s*$'

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        if ($linha -notmatch $rx) { continue }

        $expr = $Matches[2]
        $tag  = $Matches[3]

        # Contar operadores "+" (separadores de campos concatenados)
        $plusCount = ([regex]::Matches($expr, '\+')).Count
        if ($plusCount -lt 2) { continue }  # 3+ componentes = risco

        Add-Correcao -Tipo "WARN-INDEX-ON-COLLATE-GENERAL" -Linha ($i + 1) `
            -Original $linha.Trim() `
            -Corrigido "(REVISAR MANUAL) SELECT-SQL com ORDER BY em vez de INDEX ON" `
            -Descricao "Pattern #143 WARNING: INDEX ON com $($plusCount + 1) componentes concatenados (TAG $tag). Sob SET COLLATE TO GENERAL (config.prg) limite CDX cai de 240 para ~120 bytes. Se chave > ~60 chars, runtime crash 'Invalid key length.'. Fix recomendado: substituir por ORDER BY no SELECT-SQL que criou o cursor. Alternativa: SET COLLATE TO MACHINE antes do INDEX e restaurar depois. Origem: Erro53 (2026-07-21, SIGREAUPBO)."

        Write-Host "[Pattern #143] Linha $($i + 1): INDEX ON com $($plusCount + 1) componentes (TAG $tag) - REVISAR (risco Invalid key length sob COLLATE GENERAL)" -ForegroundColor Yellow
    }

    return $Linhas
}

#==============================================================================
# Pattern #144: Corrigir-ReportFormLocVarIIFWarning
# WARNING-only: sinaliza `REPORT FORM (loc_c<Var>) <MODO>` fora do helper
# ExecutarReportForm em BOs REPORT. Cobre o blind spot dos Patterns #117 e
# #123 quando a variavel eh atribuida em multi-linha ou com IIF:
#   loc_cRelatorio = gc_4c_CaminhoReports + ;
#                    IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")
#   REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
# Pattern #117 exige atribuicao single-line com string literal simples;
# Pattern #123 exige forma inline `REPORT FORM (gc_4c_CaminhoReports + "X")`.
# Nenhum pega o padrao IIF-assigned ou multi-linha.
# Fix manual: refatorar para chamar THIS.ExecutarReportForm(<expr>, "MODO", cursor)
# onde <expr> pode ser a propria IIF, mantendo semantica; injetar helper se
# ausente (template canonico em SIGREAEGBO.prg:1192-1235).
# NAO auto-refactor porque:
#   (a) Decidir cursor correto como 3o param exige leitura de PrepararDados.
#   (b) Multi-linha com `;` requer parser AST, nao regex confiavel.
#   (c) Erro na substituicao quebra REPORT FORM silenciosamente.
# Origem: Erro54 (2026-07-21, FormSIGREAUP/SIGREAUPBO): sem helper, "File
# does not exist" nao indicava qual FRX faltava; sem isolamento de locale,
# FRXs Fortyus renderizavam asteriscos em numericos; sem guard cursor
# vazio, preview em branco.
#==============================================================================
function Corrigir-ReportFormLocVarIIFWarning {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Filtro: aplica apenas em BOs REPORT (herdam RelatorioBase)
    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)DEFINE\s+CLASS\s+\w+\s+AS\s+RelatorioBase\b') {
        return $Linhas
    }

    # Localiza range da PROCEDURE ExecutarReportForm (se existir) para excluir
    # chamadas REPORT FORM legitimas dentro do helper canonico.
    $helperStart = -1
    $helperEnd = -1
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($helperStart -lt 0 -and $Linhas[$i] -match '(?i)^\s*(PROTECTED\s+|HIDDEN\s+)?PROCEDURE\s+ExecutarReportForm\b') {
            $helperStart = $i
        }
        elseif ($helperStart -ge 0 -and $Linhas[$i] -match '(?i)^\s*ENDPROC\b') {
            $helperEnd = $i
            break
        }
    }

    # REPORT FORM (<var>) <MODO>  - var comeca com loc_c (variavel local)
    $rx = '^(\s*)REPORT\s+FORM\s+\(\s*(loc_c\w+)\s*\)\s+(PREVIEW|TO\s+PRINTER\s+PROMPT|TO\s+PRINTER)(?:\s+NOCONSOLE)?\s*$'

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Skip: dentro do helper canonico
        if ($helperStart -ge 0 -and $i -ge $helperStart -and ($helperEnd -lt 0 -or $i -le $helperEnd)) {
            continue
        }

        $linha = $Linhas[$i]
        if ($linha -notmatch $rx) { continue }

        $varName = $Matches[2]
        $modo    = $Matches[3].Trim()

        Add-Correcao -Tipo "WARN-REPORT-FORM-LOCVAR-IIF" -Linha ($i + 1) `
            -Original $linha.Trim() `
            -Corrigido "(REVISAR MANUAL) THIS.ExecutarReportForm(<expr>, `"$($modo -replace '\s+','_' -replace 'TO_PRINTER_PROMPT','PRINTER_PROMPT' -replace 'TO_PRINTER','PRINTER')`", `"<cursor>`")" `
            -Descricao "Pattern #144 WARNING: REPORT FORM ($varName) fora do helper canonico ExecutarReportForm. Var $varName possivelmente atribuida via IIF ou multi-linha (blind spot dos Patterns #117/#123). Fix manual: refatorar Visualizar/Imprimir/Documento para chamar THIS.ExecutarReportForm(<expr>, `"PREVIEW|PRINTER_PROMPT|PRINTER`", <cursor>); injetar helper se ausente (template SIGREAEGBO.prg:1192-1235). Sem helper: FRX ausente estoura 'File does not exist' generico; FRXs Fortyus renderizam asteriscos em numericos; cursor vazio abre preview em branco. Origem: Erro54 (2026-07-21, SIGREAUPBO)."

        Write-Host "[Pattern #144] Linha $($i + 1): REPORT FORM ($varName) fora do helper canonico - REVISAR e refatorar para THIS.ExecutarReportForm" -ForegroundColor Yellow
    }

    return $Linhas
}

#==============================================================================
# Pattern #145: Corrigir-DestroySemDodefault
# Detecta forms que sobrescrevem PROCEDURE Destroy sem chamar DODEFAULT() no
# final. Isso quebra o FIX menu-shrinks aplicado em FormBase.Destroy (Erro58),
# porque a lógica de RELEASE POPUP + CriarMenuPrincipal nao roda.
#
# ANTES:
#   PROCEDURE Destroy()
#       IF USED("cursor_X")
#           USE IN cursor_X
#       ENDIF
#   ENDPROC
#
# DEPOIS:
#   PROCEDURE Destroy()
#       IF USED("cursor_X")
#           USE IN cursor_X
#       ENDIF
#       DODEFAULT()   && Injetado - chama FormBase.Destroy (menu-shrinks fix)
#   ENDPROC
#
# Auto-fix seguro: injeta DODEFAULT() como ultima linha antes de ENDPROC.
# So aplica se o form herda de FormBase (checa DEFINE CLASS ... AS FormBase).
# Origem: Erro58 (2026-07-21) — 233 forms tinham Destroy override, 1 sem DODEFAULT.
# Sem esse pattern, novos forms migrados podem ficar sem DODEFAULT e perder o
# menu-shrinks fix silenciosamente.
#==============================================================================
function Corrigir-DestroySemDodefault {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    # Filtro: aplica apenas em forms que herdam de FormBase
    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)DEFINE\s+CLASS\s+\w+\s+AS\s+FormBase\b') {
        return $Linhas
    }

    # Localiza bloco PROCEDURE Destroy ... ENDPROC
    $procStart = -1
    $procEnd = -1
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($procStart -lt 0 -and $Linhas[$i] -match '(?i)^\s*PROCEDURE\s+Destroy\s*\(') {
            $procStart = $i
        }
        elseif ($procStart -ge 0 -and $Linhas[$i] -match '(?i)^\s*ENDPROC\b') {
            $procEnd = $i
            break
        }
    }

    if ($procStart -lt 0 -or $procEnd -lt 0) { return $Linhas }

    # Verifica se ja tem DODEFAULT no bloco
    $temDodefault = $false
    for ($i = $procStart; $i -le $procEnd; $i++) {
        if ($Linhas[$i] -match '(?i)DODEFAULT\s*\(\s*\)') {
            $temDodefault = $true
            break
        }
    }

    if ($temDodefault) { return $Linhas }  # Ja OK, skip

    # Injetar DODEFAULT() antes de ENDPROC, respeitando indentacao
    $indent = ""
    # Pega indent da linha anterior a ENDPROC (ou do PROCEDURE + 4 espacos)
    for ($i = $procEnd - 1; $i -gt $procStart; $i--) {
        if ($Linhas[$i] -match '^(\s+)\S') {
            $indent = $Matches[1]
            break
        }
    }
    if ([string]::IsNullOrEmpty($indent)) {
        # Fallback: usar indent do PROCEDURE + 4 espacos
        if ($Linhas[$procStart] -match '^(\s*)PROCEDURE') {
            $indent = $Matches[1] + "    "
        } else {
            $indent = "        "
        }
    }

    $resultado = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($i -eq $procEnd) {
            [void]$resultado.Add($indent + "DODEFAULT()   && FIX menu-shrinks: chama FormBase.Destroy (RELEASE POPUP + CriarMenuPrincipal)")
        }
        [void]$resultado.Add($Linhas[$i])
    }

    Add-Correcao -Tipo "DESTROY-SEM-DODEFAULT" -Linha ($procEnd + 1) `
        -Original "PROCEDURE Destroy sem DODEFAULT" `
        -Corrigido "DODEFAULT injetado antes de ENDPROC" `
        -Descricao "Pattern 145: Form sobrescrevia PROCEDURE Destroy sem chamar DODEFAULT - isso quebrava o fix menu-shrinks em FormBase.Destroy Erro58. Injetado DODEFAULT como ultima linha do bloco para restaurar a cadeia de heranca. Sem esse fix, popups do MSYSMENU Cadastros Movimentos Relatorios renderizam truncados apos este form fechar cache visual stale do VFP9. Origem Erro58 2026-07-21."

    Write-Host "[Pattern #145] PROCEDURE Destroy sem DODEFAULT() - INJETADO" -ForegroundColor Yellow

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

#==============================================================================
# Pattern #146: Corrigir-GridCheckboxPropsExplicitas
# Detecta AddObject Check1 CheckBox em WITH Column1 e injeta propriedades
# explicitas ReadOnly, Visible, Alignment, Top, Left, Height, Width se ausentes.
#
# ANTES:
#   WITH loc_oGrd.Column1
#       .Width = 15
#       .Sparse = .F.
#       .AddObject Check1 CheckBox
#       .Check1.Caption = ""
#       .CurrentControl = Check1
#       .ControlSource = cursor.SelImp
#   ENDWITH
#
# DEPOIS: Injeta apos .Check1.Caption:
#       .Check1.Alignment = 0
#       .Check1.ReadOnly = .F.
#       .Check1.Visible = .T.
#       .Check1.Top = 9
#       .Check1.Left = 2
#       .Check1.Height = 17
#       .Check1.Width = 22
#
# Motivo: Sem essas props explicitas, CheckBox em Grid Column pode renderizar
# como retangulo pequeno ou nao responder a cliques (VFP9 assume defaults que
# nao funcionam bem em contexto Grid). Origem: Erro59 (2026-07-21, Formsigreato)
# — cliques em checkbox nao mudavam estado. Legacy sempre define essas props.
# Complementa Pattern #121 Sparse=.F.
# Idempotente: se qualquer prop ja existe no bloco, skip da mesma prop.
#==============================================================================
function Corrigir-GridCheckboxPropsExplicitas {
    param([string[]]$Linhas)

    if ($null -eq $Linhas -or $Linhas.Count -eq 0) { return $Linhas }

    $conteudo = $Linhas -join "`n"
    if ($conteudo -notmatch '(?i)\.AddObject\s*\(\s*"Check1"\s*,\s*"CheckBox"') {
        return $Linhas
    }

    $resultado = [System.Collections.ArrayList]::new()
    $i = 0
    $totalInjecoes = 0

    while ($i -lt $Linhas.Count) {
        $linha = $Linhas[$i]
        [void]$resultado.Add($linha)

        # Detectar linha com .Check1.Caption dentro de WITH Column1 (padrao canonico)
        if ($linha -match '(?i)^(\s*)\.Check1\.Caption\s*=\s*""') {
            $indent = $Matches[1]

            # Verificar se as props ja estao presentes nas proximas ~15 linhas ate ENDWITH
            $j = $i + 1
            $temAlignment = $false; $temReadOnly = $false; $temVisible = $false
            $temTop = $false; $temLeft = $false; $temHeight = $false; $temWidth = $false
            $endWithIdx = -1
            while ($j -lt $Linhas.Count -and ($j - $i) -lt 20) {
                if ($Linhas[$j] -match '(?i)^\s*ENDWITH\s*$') { $endWithIdx = $j; break }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Alignment\s*=') { $temAlignment = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.ReadOnly\s*=')  { $temReadOnly = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Visible\s*=')   { $temVisible = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Top\s*=')       { $temTop = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Left\s*=')      { $temLeft = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Height\s*=')    { $temHeight = $true }
                if ($Linhas[$j] -match '(?i)^\s*\.Check1\.Width\s*=')     { $temWidth = $true }
                $j++
            }

            # Injetar as ausentes apos .Check1.Caption
            $injetou = $false
            if (-not $temAlignment) { [void]$resultado.Add($indent + '.Check1.Alignment = 0'); $injetou = $true }
            if (-not $temReadOnly)  { [void]$resultado.Add($indent + '.Check1.ReadOnly  = .F.'); $injetou = $true }
            if (-not $temVisible)   { [void]$resultado.Add($indent + '.Check1.Visible   = .T.'); $injetou = $true }
            if (-not $temTop)       { [void]$resultado.Add($indent + '.Check1.Top       = 9'); $injetou = $true }
            if (-not $temLeft)      { [void]$resultado.Add($indent + '.Check1.Left      = 2'); $injetou = $true }
            if (-not $temHeight)    { [void]$resultado.Add($indent + '.Check1.Height    = 17'); $injetou = $true }
            if (-not $temWidth)     { [void]$resultado.Add($indent + '.Check1.Width     = 22'); $injetou = $true }

            if ($injetou) {
                $totalInjecoes++
                Add-Correcao -Tipo "GRID-CHECKBOX-PROPS-EXPLICITAS" -Linha ($i + 2) `
                    -Original ".Check1 sem props explicitas ReadOnly/Visible/Alignment/Top/Left/Height/Width" `
                    -Corrigido "Injetadas props explicitas apos .Check1.Caption" `
                    -Descricao "Pattern 146: CheckBox em Grid Column sem props explicitas nao responde a cliques em runtime. Sem ReadOnly=.F. o VFP9 pode assumir readonly em contexto Grid; sem Top/Left/Height/Width a area clicavel eh menor que o retangulo visual. Injetadas as 7 props canonicas do legado. Origem Erro59 2026-07-21 Formsigreato."
            }
        }

        $i++
    }

    if ($totalInjecoes -gt 0) {
        Write-Host "[Pattern #146] $totalInjecoes bloco(s) Check1 com props explicitas injetadas" -ForegroundColor Yellow
    }

    $saida = New-Object string[] $resultado.Count
    for ($k = 0; $k -lt $resultado.Count; $k++) { $saida[$k] = [string]$resultado[$k] }
    return $saida
}

function Invoke-CorrecaoAutomatica {
    param(
        [string]$Arquivo,
        [string]$TaskDir = ""
    )

    Write-Host "=== CORRETOR AUTOMATICO ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Arquivo: $Arquivo" -ForegroundColor White
    Write-Host ""

    if (-not (Test-Path $Arquivo)) {
        Write-Host "ERRO: Arquivo nao encontrado: $Arquivo" -ForegroundColor Red
        return $false
    }

    # Cria backup
    $backupFile = $Arquivo + ".bak"
    Copy-Item -Path $Arquivo -Destination $backupFile -Force
    Write-Host "Backup criado: $backupFile" -ForegroundColor Gray

    # Lê arquivo como bytes para detectar e remover BOM UTF-8
    $bytes = [System.IO.File]::ReadAllBytes($Arquivo)
    $bomRemovido = $false

    # Detecta BOM UTF-8 (EF BB BF = 239 187 191)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        # Remove BOM
        $bytes = $bytes[3..($bytes.Length - 1)]
        $bomRemovido = $true
        Add-Correcao -Tipo "BOM_UTF8" -Linha 1 -Original "(BOM UTF-8: EF BB BF)" -Corrigido "(removido)" -Descricao "BOM UTF-8 removido - VFP9 nao suporta"
        Write-Host "BOM UTF-8 detectado e removido!" -ForegroundColor Yellow
    }

    # Converte bytes para string e depois para linhas
    $conteudo = [System.Text.Encoding]::UTF8.GetString($bytes)
    $linhas = $conteudo -split "`r`n|`n"

    Write-Host "Linhas originais: $($linhas.Count)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Aplicando correcoes..." -ForegroundColor Yellow

    # Aplica correções em sequência
    $linhas = Corrigir-ReturnNoTryCatch -Linhas $linhas
    $linhas = Corrigir-InicializarFormDuplicado -Linhas $linhas
    $linhas = Corrigir-ShowModal -Linhas $linhas
    $linhas = Corrigir-ReleaseAposShow -Linhas $linhas
    $linhas = Corrigir-SalvarComParametro -Linhas $linhas
    $linhas = Corrigir-NomePropriedadesBO -Linhas $linhas
    $linhas = Corrigir-AliasComPonto -Linhas $linhas
    $linhas = Corrigir-ValDesnecessario -Linhas $linhas
    $linhas = Corrigir-GridPropriedadesInvalidas -Linhas $linhas
    $linhas = Corrigir-NomeClasseBO -Linhas $linhas -TaskDir $TaskDir
    $linhas = Corrigir-HerancaFormBase -Linhas $linhas
    $linhas = Corrigir-VariavelResultadoSucesso -Linhas $linhas
    $linhas = Corrigir-PageFrameBackColor -Linhas $linhas
    $linhas = Corrigir-PageFrameErasePage -Linhas $linhas
    $linhas = Corrigir-SetAllFontNameColumn -Linhas $linhas
    $linhas = Corrigir-OptionGroupButton -Linhas $linhas
    $linhas = Corrigir-EncodingInvalido -Linhas $linhas
    $linhas = Corrigir-CreateCursorFieldWidth -Linhas $linhas
    $linhas = Corrigir-CarregarListaProtected -Linhas $linhas
    $linhas = Corrigir-PublicProcedureEmDefineClass -Linhas $linhas
    $linhas = Corrigir-PageNameOrdering -Linhas $linhas
    $linhas = Corrigir-TextBoxControlSourceEmColumn -Linhas $linhas
    $linhas = Corrigir-OptionGroupFontName -Linhas $linhas
    $linhas = Corrigir-ElseIf -Linhas $linhas
    $linhas = Corrigir-TernarioParaIIF -Linhas $linhas
    $linhas = Corrigir-LocateIn -Linhas $linhas
    $linhas = Corrigir-ShowWindowAusente -Linhas $linhas
    $linhas = Corrigir-BindEventSemParametros -Linhas $linhas
    $linhas = Corrigir-AspasDuplicadasSQL -Linhas $linhas
    $linhas = Corrigir-SelfAssignmentObjeto -Linhas $linhas
    $linhas = Corrigir-VariaveisLegadasFramework -Linhas $linhas
    $linhas = Corrigir-IsEmptyParaEmpty -Linhas $linhas
    $linhas = Fix-MensagemErroAusente -linhas $linhas
    $linhas = Fix-ReportFormToFile -linhas $linhas
    $linhas = Corrigir-PropriedadesInexistentesControles -Linhas $linhas
    $linhas = Corrigir-BindEventValidParaLostFocus -Linhas $linhas
    $linhas = Corrigir-MessageBoxDireto -Linhas $linhas
    $linhas = Corrigir-Check1ControlSource -Linhas $linhas
    $linhas = Corrigir-AddObjectInvertido -Linhas $linhas
    $linhas = Corrigir-GridCheck1SemAddObject -Linhas $linhas
    $linhas = Corrigir-PageVisible -Linhas $linhas
    $linhas = Corrigir-PageFrameVisibleAusente -Linhas $linhas
    $linhas = Corrigir-InlineIfThen -Linhas $linhas
    $linhas = Corrigir-CountToIn -Linhas $linhas
    $linhas = Corrigir-CheckBoxValueLogico -Linhas $linhas
    $linhas = Corrigir-CreateObjectVsDefineClass -Linhas $linhas -TaskDir $TaskDir
    $linhas = Corrigir-FormatarGridListaAusente -Linhas $linhas
    $linhas = Corrigir-PropertyAddObjectConflito -Linhas $linhas
    $linhas = Corrigir-AddObjectDuplicado -Linhas $linhas
    $linhas = Corrigir-ContainerVisibleAusente -Linhas $linhas
    $linhas = Corrigir-LparametersNoProcedure -Linhas $linhas
    $linhas = Corrigir-ContainerThemes -Linhas $linhas
    $linhas = Corrigir-MsgConfirmaNumerico -Linhas $linhas
    $linhas = Corrigir-AppendFromSemSelect -Linhas $linhas
    $linhas = Corrigir-GridRecordMarkDeleteMark -Linhas $linhas
    $linhas = Corrigir-BackStyleInexistente -Linhas $linhas
    $linhas = Corrigir-OptionGroupButtonsBackStyle -Linhas $linhas
    $linhas = Corrigir-OptionGroupWidthAcomodaBotoes -Linhas $linhas
    $linhas = Corrigir-PageFrameTabStyle -Linhas $linhas
    $linhas = Corrigir-NovoRegistroSemDodefault -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-ContainerTransparenteComBotoes -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-FormBuscaAuxiliarOrdem -Linhas $linhas
    $linhas = Corrigir-SQLColunasLegadas -Linhas $linhas
    $linhas = Corrigir-NvlBitField -Linhas $linhas
    $linhas = Corrigir-F4KeyCode -Linhas $linhas
    $linhas = Corrigir-ValidandoUIGuard -Linhas $linhas
    $linhas = Corrigir-CursorBitFields -Linhas $linhas
    $linhas = Corrigir-BOParaFormCheckBoxLogico -Linhas $linhas
    $linhas = Corrigir-ContainerBorderStyle -Linhas $linhas
    $linhas = Corrigir-PageFrameHeightTop29 -Linhas $linhas
    $linhas = Corrigir-ValidarParaValidarDados -Linhas $linhas
    $linhas = Corrigir-IIFNumericoSemComparacao -Linhas $linhas
    $linhas = Corrigir-NumericoPreservaTipo -Linhas $linhas
    $linhas = Corrigir-CheckBoxInitLogico -Linhas $linhas
    $linhas = Corrigir-LostFocusLookupBusca -Linhas $linhas
    $linhas = Corrigir-ALLTRIMCampoNumerico -Linhas $linhas
    $linhas = Corrigir-EncerrarCaptionX -Linhas $linhas
    $linhas = Corrigir-CntBotoesLeft542 -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-PagePictureFrmCadastro -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-HeaderWidthTotal -Linhas $linhas
    $linhas = Corrigir-MostrarErroParaMsgAviso -Linhas $linhas
    $linhas = Corrigir-MostrarAvisoInexistente -Linhas $linhas
    $linhas = Corrigir-SQLExecCursorGuard -Linhas $linhas
    $linhas = Corrigir-CntSaidaEncerrarCanonico -Linhas $linhas
    $linhas = Corrigir-PageWidthStripMinus60 -Linhas $linhas
    $linhas = Corrigir-BotaoSaidaCanonico -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-GridColumnCountAntesRecordSource -Linhas $linhas
    $linhas = Corrigir-LocPaginaPictureAusente -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-PemstatusCursorParaType -Linhas $linhas
    $linhas = Corrigir-PicturePositionReport -Linhas $linhas
    $linhas = Corrigir-CntSombraGrayColor -Linhas $linhas
    $linhas = Corrigir-LookupKeyPressExpand -Linhas $linhas
    $linhas = Corrigir-InitFormSemDodefault -Linhas $linhas
    $linhas = Corrigir-PictureReportIconesInexistentes -Linhas $linhas
    $linhas = Corrigir-CabecalhoReportAusente -Linhas $linhas
    $linhas = Corrigir-CabecalhoLabelsAutoSize -Linhas $linhas
    $linhas = Corrigir-StandaloneCommandButtonTheme -Linhas $linhas
    $linhas = Corrigir-Buttons3RelatorioEmail -Linhas $linhas
    $linhas = Corrigir-ButtonsReportFontNameComicSans -Linhas $linhas
    $linhas = Corrigir-ButtonsReportWordWrap -Linhas $linhas
    $linhas = Corrigir-GridReportCanonico -Linhas $linhas
    $linhas = Corrigir-StandaloneButtonPictureAusente -Linhas $linhas
    $linhas = Corrigir-SigCdOpeDescrsColuna -Linhas $linhas
    $linhas = Corrigir-IconOnlyButtonDisableRuntime -Linhas $linhas
    $linhas = Corrigir-ContainerBotoesOverlayGrid -Linhas $linhas
    $linhas = Corrigir-OptionButtonValueSpurio -Linhas $linhas
    $linhas = Corrigir-TornarControlesVisiveisSkipRecursivo -Linhas $linhas
    $linhas = Corrigir-fAcessoEmpresa -Linhas $linhas
    $linhas = Corrigir-CommandButtonRecordMarkInvalido -Linhas $linhas
    $linhas = Corrigir-KeyPressGuardLookup -Linhas $linhas
    $linhas = Corrigir-CmgReportButtonsOverflow -Linhas $linhas
    $linhas = Corrigir-MsgAvisoAntesDoPicker -Linhas $linhas
    $linhas = Corrigir-SigCdGcrDescrsColuna -Linhas $linhas
    $linhas = Corrigir-ReportFormToPrintTypo -Linhas $linhas
    $linhas = Corrigir-ReportFormSemGuard -Linhas $linhas
    $linhas = Corrigir-SelectLocalVarSemMPrefix -Linhas $linhas
    $linhas = Corrigir-FormatarDataSQLDatetime -Linhas $linhas
    $linhas = Corrigir-MacroMPrefixQuebrado -Linhas $linhas
    $linhas = Corrigir-GridColumnCheckboxSparse -Linhas $linhas
    $linhas = Corrigir-BtnReportGuardEmptyMsgErro -Linhas $linhas
    $linhas = Corrigir-ReportFormConcatInline -Linhas $linhas
    $linhas = Corrigir-SigCdEmpColunasInvalidas -Linhas $linhas
    $linhas = Corrigir-SigCdEmpTextBoxMaxLength -Linhas $linhas
    $linhas = Corrigir-ReportBOCursorDadosDeclarada -Linhas $linhas
    $linhas = Corrigir-IndexOnCollateGeneralWarning -Linhas $linhas
    $linhas = Corrigir-ReportFormLocVarIIFWarning -Linhas $linhas
    $linhas = Corrigir-DestroySemDodefault -Linhas $linhas
    $linhas = Corrigir-GridCheckboxPropsExplicitas -Linhas $linhas

    # Salva arquivo corrigido (sem BOM - VFP9 nao suporta UTF8 com BOM)
    $conteudoFinal = $linhas -join "`r`n"
    [System.IO.File]::WriteAllText($Arquivo, $conteudoFinal, [System.Text.Encoding]::GetEncoding(1252))

    Write-Host ""
    Write-Host "Correcoes aplicadas: $($script:Correcoes.Count)" -ForegroundColor $(if ($script:Correcoes.Count -gt 0) { "Green" } else { "Gray" })
    Write-Host ""

    # Mostra detalhes das correções
    if ($script:Correcoes.Count -gt 0) {
        Write-Host "Detalhes:" -ForegroundColor Cyan
        foreach ($correcao in $script:Correcoes) {
            Write-Host "  Linha $($correcao.Linha): [$($correcao.Tipo)]" -ForegroundColor Yellow
            Write-Host "    Original:  $($correcao.Original)" -ForegroundColor Red
            Write-Host "    Corrigido: $($correcao.Corrigido)" -ForegroundColor Green
            Write-Host ""
        }
    }

    return $true
}

function Save-LogCorrecoes {
    param([string]$TaskDir, [string]$Arquivo)

    if ([string]::IsNullOrEmpty($TaskDir)) {
        return
    }

    $logFile = Join-Path $TaskDir "correcoes_$(Split-Path -Leaf $Arquivo).json"

    $log = @{
        arquivo = $Arquivo
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
        totalCorrecoes = $script:Correcoes.Count
        correcoes = $script:Correcoes
    }

    $log | ConvertTo-Json -Depth 5 | Set-Content -Path $logFile -Encoding UTF8

    Write-Host "Log de correcoes salvo: $logFile" -ForegroundColor Gray
}

#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

# Sem -ArquivoPrg: permite dot-sourcing (`. .\CorretorAutomatico.ps1`) por
# outros scripts que queiram usar apenas as funcoes (ex: sweep chamando
# Corrigir-FwProgressBarStubMembros diretamente).
if ([string]::IsNullOrEmpty($ArquivoPrg)) {
    return
}

try {
    $resultado = Invoke-CorrecaoAutomatica -Arquivo $ArquivoPrg -TaskDir $TaskDir

    if ($resultado) {
        # Salva log se TaskDir fornecido
        if (-not [string]::IsNullOrEmpty($TaskDir)) {
            Save-LogCorrecoes -TaskDir $TaskDir -Arquivo $ArquivoPrg
        }

        Write-Host ""
        Write-Host "=== CORRECAO CONCLUIDA ===" -ForegroundColor Green

        if ($script:Correcoes.Count -eq 0) {
            Write-Host "Nenhuma correcao necessaria." -ForegroundColor Gray
            exit 0
        }
        else {
            Write-Host "$($script:Correcoes.Count) correcao(oes) aplicada(s)." -ForegroundColor Green
            exit 0
        }
    }
    else {
        exit 1
    }
}
catch {
    Write-Host ""
    Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
    exit 1
}
