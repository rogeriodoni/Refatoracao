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
#==============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$ArquivoPrg,

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
    Remove PUBLIC de declaracoes PROCEDURE dentro de DEFINE CLASS

    .DESCRIPTION
    VFP9 nao aceita 'PUBLIC PROCEDURE' dentro de DEFINE CLASS.
    Todos os metodos dentro de uma classe sao PUBLIC por default.
    'PUBLIC PROCEDURE' causa "Syntax error" na compilacao.
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

        # Dentro de classe: PUBLIC PROCEDURE -> PROCEDURE
        if ($dentroDeClasse -and $linhaTrimmed -match '^PUBLIC\s+PROCEDURE\s+' -and $linhaTrimmed -notmatch '^\s*\*') {
            $linha = $linha -replace 'PUBLIC\s+PROCEDURE', 'PROCEDURE'
            Add-Correcao -Tipo "PUBLIC_PROCEDURE_EM_DEFINE_CLASS" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido $linha.Trim() -Descricao "PUBLIC PROCEDURE invalido dentro de DEFINE CLASS - removido PUBLIC"
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

        # Detecta LOCATE IN alias FOR condicao
        if ($linha -match '^(\s*)LOCATE\s+IN\s+(\S+)\s+FOR\s+(.*)$') {
            $indent = $Matches[1]
            $alias = $Matches[2]
            $condicao = $Matches[3]

            $resultado += "${indent}SELECT ${alias}"
            $resultado += "${indent}LOCATE FOR ${condicao}"
            Add-Correcao -Tipo "LOCATE_IN" -Linha ($i + 1) -Original $linhaOriginal.Trim() -Corrigido "SELECT ${alias} + LOCATE FOR ${condicao}" -Descricao "VFP9 nao suporta LOCATE IN - convertido para SELECT + LOCATE FOR"
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
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $linha = $Linhas[$i]
        $linhaTrim = $linha.Trim()
        $corrigiu = $false

        # Detecta PROCEDURE HandlerName() sem parametros
        foreach ($handler in $bindHandlers.Keys) {
            if ($handlersCorrigidos.ContainsKey($handler)) { continue }
            $info = $bindHandlers[$handler]
            if ($linhaTrim -match "(?i)^PROCEDURE\s+$handler\s*\(\s*\)\s*$") {
                # Handler sem parametros - corrigir
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

        if (-not $corrigiu) {
            [void]$resultado.Add($linha)
        }
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
    #>
    param([string[]]$Linhas)

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        # Detecta: AddObject("grd_4c_...", "Grid")
        if ($Linhas[$i] -match '(?i)AddObject\(\s*"(grd_4c_\w+)"\s*,\s*"Grid"\s*\)') {
            $gridName = $Matches[1]
            # Busca o ENDWITH do WITH block deste grid (proximo ENDWITH)
            $temRecordMark = $false
            $temDeleteMark = $false
            $endWithIdx = -1
            for ($j = $i + 1; $j -lt [Math]::Min($i + 30, $Linhas.Count); $j++) {
                if ($Linhas[$j] -match '(?i)\.RecordMark\s*=') { $temRecordMark = $true }
                if ($Linhas[$j] -match '(?i)\.DeleteMark\s*=') { $temDeleteMark = $true }
                if ($Linhas[$j] -match '(?i)^\s*ENDWITH\s*$') {
                    $endWithIdx = $j
                    break
                }
            }
            if ($endWithIdx -gt 0 -and (!$temRecordMark -or !$temDeleteMark)) {
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
    Remove .BackStyle de CommandGroup e CommandButton (standalone ou .Buttons(N) de CommandGroup).
    Esses controles NAO possuem BackStyle em VFP9.
    EXCECAO: OptionButton (.Buttons(N) de OptionGroup) TEM BackStyle - NUNCA remover.
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

        # Detecta WITH block que referencia um grupo ou botao
        if ($linha -match '(?i)^\s*WITH\s+') {
            # CommandGroup (WITH ref.cmdgroup, sem .Buttons(N))
            foreach ($name in $commandGroupNames) {
                if ($linha -match "(?i)\.$([regex]::Escape($name))\s*$") {
                    $insideCommandGroupWith = $true
                    break
                }
            }
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

        # Dentro de WITH, remover .BackStyle APENAS em CommandGroup/CommandButton.
        # Nunca remover em OptionGroup.Buttons(N) - OptionButton TEM BackStyle.
        if (($insideCommandGroupWith -or $insideCommandButtonWith) -and (-not $insideOptionGroupButtonsWith) -and $linha -match '(?i)^\s*\.BackStyle\s*=') {
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
    Remove BackStyle=1 + BackColor=RGB(53,53,53) desses containers.
    EXCECAO: cnt_4c_Cabecalho continua opaco propositalmente.
    Pattern #63 (invertido em 2026-04-16 apos licao do FormDepartamento task016).
    #>
    param([string[]]$Linhas)

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
    # e remover BackColor=RGB(53,53,53) (ou similar escuro)
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

    # Coleta handlers de lookup por 3 heuristicas (mais larga que antes):
    #   (a) PROCEDURE cujo corpo contem CREATEOBJECT("FormBuscaAuxiliar")
    #   (b) Nome da PROCEDURE contem "Lookup" (ex: AbrirLookupCor, UsuarsLookupLostFocus)
    #   (c) Nome da PROCEDURE contem "Validar" E o arquivo inteiro tem FormBuscaAuxiliar
    #       (handlers que delegam a abertura para outro metodo)
    # Motivo: tasks 017-020 tiveram lookups usando LostFocus que nao caiam em (a)
    # porque o CREATEOBJECT estava em AbrirLookupXxx, nao no handler BINDEVENT.
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
    param([string[]]$Linhas)

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
    param([string[]]$Linhas)

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
    $linhas = Corrigir-ContainerTransparenteComBotoes -Linhas $linhas
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
    $linhas = Corrigir-CntBotoesLeft542 -Linhas $linhas
    $linhas = Corrigir-PagePictureFrmCadastro -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-HeaderWidthTotal -Linhas $linhas
    $linhas = Corrigir-MostrarErroParaMsgAviso -Linhas $linhas
    $linhas = Corrigir-CntSaidaEncerrarCanonico -Linhas $linhas
    $linhas = Corrigir-PageWidthStripMinus60 -Linhas $linhas
    $linhas = Corrigir-BotaoSaidaCanonico -Linhas $linhas
    $linhas = Corrigir-GridColumnCountAntesRecordSource -Linhas $linhas
    $linhas = Corrigir-LocPaginaPictureAusente -Linhas $linhas -Arquivo $Arquivo
    $linhas = Corrigir-PemstatusCursorParaType -Linhas $linhas
    $linhas = Corrigir-LookupKeyPressExpand -Linhas $linhas

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
