function Test-LegadoSomenteLeitura {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): caminho COMPLETO de cada
    # controle de ENTRADA de dados. Label/Image/Shape/Container NAO contam.
    # O caminho completo (Parent + "." + Objeto) e' necessario porque a
    # heranca de ReadOnly vem do ancestral - nome curto nao permite subir.
    $campos   = @{}
    $tipos    = @{}
    $objAtual = ""
    $paiAtual = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:') {
            # Zera SEMPRE: "Objeto:" sem nome (ha entradas vazias no dump) nao
            # pode herdar o nome do objeto anterior.
            $objAtual = ""
            $paiAtual = ""
            if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') { $objAtual = $matches[1] }
        } elseif ($linha -match '^\s*Parent:\s*(\S+)\s*$') {
            $paiAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) {
                $caminho = if ($paiAtual -and $paiAtual -ne '(raiz)') { "$paiAtual.$objAtual" } else { $objAtual }
                $campos[$caminho.ToUpper()] = $false
                $tipos[$caminho.ToUpper()]  = $matches[1].ToLower()
            }
        }
    }

    if ($campos.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): ReadOnly = .T., do proprio objeto do
    # bloco ou de um descendente declarado por caminho RELATIVO dentro dele
    # (Column3.ReadOnly = .T. / Column3.Text1.ReadOnly = .T. no bloco do Grid).
    $somenteLeitura = @{}
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:') {
            $objProp = ""
            if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') { $objProp = $matches[1].ToUpper() }
        } elseif ($objProp -and $linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura[$objProp] = $true
        } elseif ($objProp -and $linha -match '^\s*([\w\.]+)\.ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura["$objProp.$($matches[1].ToUpper())"] = $true
        } elseif ($objProp -and $linha -match '^\s*Style\s*=\s*2\s*$' -and
                  $tipos[$objProp] -eq 'combobox') {
            # ComboBox Style = 2 (Dropdown List) eh somente-selecao: 3a forma
            # canonica de campo nao-digitavel, alem de ReadOnly = .T. e
            # When -> .F.. Medido no VFP9 em 2026-09-29
            # (automation\medir_combo_style2.prg): com Style = 0 a digitacao de
            # "Zebra" cai em DisplayValue; com Style = 2 ela eh DESCARTADA e
            # ate a atribuicao por codigo de valor fora da lista eh recusada.
            # Style = 0/1 segue digitavel e derruba a excecao (fail-closed).
            $somenteLeitura[$objProp] = $true
        }
    }

    # 3a passada (SECAO 3 - metodos): PROCEDURE When que devolve .F. sem
    # condicao nenhuma. Aceita "Return .f.", "Return (.F.)" e "Return(.f.)" -
    # as tres grafias aparecem no MESMO dump do SIGMVSBN. When com qualquer
    # outra linha util NAO conta: pode devolver .T. em algum caminho.
    $objMet = ""
    $emWhen = $false
    $corpo  = @()
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*OBJETO:\s*(\S+)\s*$') {
            $objMet = $matches[1].ToUpper()
            continue
        }
        if (-not $emWhen) {
            if ($linha -match '^\s*PROCEDURE\s+When\s*$') {
                $emWhen = $true
                $corpo  = @()
            }
            continue
        }
        if ($linha -match '^\s*ENDPROC\s*$') {
            $emWhen = $false
            # @(...) obrigatorio: com UMA linha util o pipeline devolve String,
            # e $uteis[0] numa String da o primeiro CARACTERE, nao a linha.
            $uteis = @($corpo | ForEach-Object { $_.Trim() } |
                       Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' })
            if ($objMet -and $uteis.Count -eq 1 -and
                $uteis[0] -match '(?i)^Return\s*\(?\s*\.F\.\s*\)?\s*$') {
                $somenteLeitura[$objMet] = $true
            }
        } else {
            $corpo += $linha
        }
    }

    # Veredito: UM campo digitavel derruba a excecao.
    foreach ($caminho in @($campos.Keys)) {
        if ($somenteLeitura[$caminho]) { continue }

        # Sobe a hierarquia: Grid/Column com ReadOnly = .T. propaga aos filhos.
        $herdou = $false
        $partes = $caminho -split '\.'
        for ($i = $partes.Count - 2; $i -ge 0; $i--) {
            if ($somenteLeitura[(($partes[0..$i]) -join '.')]) { $herdou = $true; break }
        }
        if (-not $herdou) { return $false }
    }

    return $true
}

function Test-AcaoDoLegadoTemHandler {
    <#
    .SYNOPSIS
        O botao de ACAO que o legado realmente tem ganhou handler no migrado?
    .DESCRIPTION
        O gate da Fase 8 diz, em comentario, que "aceita o nome canonico CRUD
        ou o nome que o legado usa" - mas $padraoAcaoGravar so aceita a lista
        canonica Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK).
        Legado cuja acao NAO eh gravar em tabela usa outro verbo e a fase
        reprovava um form completo: SIGPRFTP -> Formsigprftp (task611), tela de
        transferencia de arquivos via FTP cujos botoes sao "Conecta",
        "Transfere", "Recebe" e "Rede Dial-Up". Nenhum verbo desses esta na
        lista, e a tela nao persiste NADA em tabela de negocio - a acao dela eh
        mover arquivo. Satisfazer a lista exigiria INVENTAR um botao que o
        legado nao tem (viola o PILAR 1) ou renomear o handler para um verbo
        que mente sobre o que ele faz.

        Lista de palavras no nome erra igual do lado do migrado e do lado do
        legado - a mesma armadilha que a Fase 7 teve com o verbo CRUD com
        sufixo. Entao aqui NAO se acrescenta verbo a lista: deriva-se o verbo
        do PROPRIO dump, pelo Caption/Name de cada CommandButton, e cobra-se
        que exista "PROCEDURE Btn<verbo>*Click" no migrado.

        O DONO do bloco eh identificado pelo BaseClass da ARVORE DA SECAO 1
        do dump, nao pelo prefixo do nome (2026-10-17, task644). O filtro
        original exigia Name comecando por cmd/btn/command/Grupo, mas esse
        prefixo eh convencao do autor do SCX, nao garantia: quando o botao
        herda de classe do Framework Fortyus, o Form Designer batiza pela
        CLASSE. Em SIGOPAUT (task644) os tres CommandButton se chamam 'Sair',
        'Fwbtnm1' (classe fwbtnm) e 'Grade' - nenhum casa o prefixo, entao o
        helper devolvia $false para uma tela que TEM botao de acao
        ("\<Imprimir", que autentica as linhas marcadas) e cujo migrado TEM o
        handler (BtnImprimirClick). Eh a mesma familia de erro que este
        helper foi criado para desfazer - decidir por lista/padrao de NOME -
        so que do lado do DONO em vez do VERBO. O dump ja traz a resposta
        certa em "Objeto: X / BaseClass: commandbutton"; o prefixo fica como
        FALLBACK para dump sem a SECAO 1 legivel.

        Medido em 2026-10-17 nos dumps de tasks\ com form migrado: a mudanca
        altera o veredito DESTE helper em 88 de 388 dumps, mas o veredito
        FINAL da Fase 8 em apenas 1 de 234 forms (SigOpAut) - os outros 87 ou
        ja passavam por $padraoAcaoGravar, ou por um dos 9 ramos de excecao,
        ou seguem reprovados por outro metodo faltante. Nenhum form que
        passava antes passa a reprovar (219 -> 220).

        O verbo passou a ser colhido tambem do MEMBRO INTERNO do grupo, e o
        handler aceito com prefixo Btn OU Cmd (2026-10-17, task648). As duas
        coisas sao a MESMA familia de erro que este helper existe para
        desfazer - ler o nivel/grafia errada do nome -, e sao
        indissociaveis: SIGOPBOL -> FormSIGOPBOL so passa com as duas. O
        dump declara um CommandGroup 'btnReport' SEM Caption (o verbo esta em
        'Command1.Name = "Cmd_Imprimir"', e o Caption do membro, 'Encerrar',
        eh verbo de SAIDA e continua descartado) e o migrado nomeia o handler
        'CmdImprimirClick', espelhando o objeto legado. So com (A) o helper
        colhe 'Imprimir'; so com (B) ele aceita 'Cmd...Click'.

        Medido em 2026-10-17 nos 392 dumps de tasks\ com form migrado: o
        veredito DESTE helper vai de 168 para 219 (+51), com ZERO regressao
        (nenhum .T. virou .F., como garante a monotonia - o resultado so eh
        consumido por '-not $legadoSemAcao -> $metodosFaltantes +='). O
        veredito FINAL da Fase 8 muda em 2 forms distintos: SIGOPBOL
        (task648) e SigPrEs1 (tasks 178/281/606, que ja passava pelo ramo
        FILTRO-DESPACHO). Conferidos os 30 forms distintos que mudam de
        veredito aqui: em TODOS o par eh verbo real do legado -> handler real
        do migrado (Imprimir->CmdImprimirClick, Processar->BtnProcessarClick,
        Consultar->BtnConsultarClick, ...), nenhum casamento por acidente.

        A fronteira de seguranca NAO foi tocada: este helper so eh consultado
        quando $legadoSemSalvar prova que o legado nao tem botao de gravar.
        Legado COM botao de gravar continua exigindo o nome canonico.

        FAIL-CLOSED:
          - dump ausente/ilegivel -> $false (ausencia de prova nao eh prova);
          - botao que so FECHA a tela nao conta como acao (Sair/Saida/
            Encerrar/Fechar/Cancelar/Retornar/OK/X) - senao qualquer form
            passaria pelo botao de sair. A lista de verbos de saida FOI
            AMPLIADA junto com a deteccao por BaseClass e nao se separa dela:
            admitir o CommandGroup 'SAIDA' do SIGTOSEN sem admitir o verbo
            'saida' faria aquele form passar pelo proprio botao de sair;
          - Caption/Name com menos de 4 letras uteis eh descartado: raiz curta
            casaria por acidente (ex.: "Ok" dentro de "BtnBloqueioClick");
          - exige o handler ancorado em inicio de linha, para a tabela
            "o que nao se aplica" do cabecalho do form nao satisfazer um
            -match solto e a checagem virar NO-OP.
    .OUTPUTS
        [bool] $true quando ao menos um botao de ACAO do legado tem handler.
    #>
    param(
        [string]$TextoDump,
        [string]$ConteudoForm
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump))    { return $false }
    if ([string]::IsNullOrWhiteSpace($ConteudoForm)) { return $false }

    # Verbos que apenas FECHAM a tela - nao sao acao.
    # 'saida'/'saida acentuado'/'saidas' e as formas verbais 'encerra'/'fecha'/
    # 'retorna'/'volta' entraram em 2026-10-17 JUNTO com a deteccao por
    # BaseClass abaixo, e sao parte indissociavel dela: SIGTOSEN (task017) tem
    # um UNICO CommandGroup chamado 'SAIDA' (botao interno 'CANCELA',
    # Cancel = .T., Picture cadastro_sair_60.jpg, ToolTip "[ESC] Sair do
    # Sistema") que o filtro por NOME escondia. Admitir o grupo sem admitir o
    # verbo faria 'SAIDA' casar com 'BtnSaidaClick' no migrado e o form
    # passaria pelo botao de SAIR - exatamente o furo que esta lista existe
    # para fechar. Medido: sem este acrescimo o veredito final mudava em 2
    # forms (SigOpAut e sigtosen); com ele, em 1 (so SigOpAut).
    $verbosDeSaida = @('sair','saida','sa' + [char]0x00ED + 'da','saidas',
                       'encerrar','encerra','fechar','fecha',
                       'cancelar','cancela','retornar','retorna',
                       'voltar','volta','abandonar','ok','x','esc','exit','close')

    # Blocos "* PROPRIEDADES DE: ..." de cada CommandButton do SCX. O dump
    # traz Name = "..." e, quando existe, Caption = "..." - e do Caption que
    # sai o verbo que o USUARIO ve (o Name costuma ser abreviado: cmdtran).
    $candidatos = New-Object System.Collections.Generic.List[string]

    # Nomes cujo BaseClass na ARVORE DA SECAO 1 do dump eh commandbutton/
    # commandgroup. Esta eh a fonte AUTORITATIVA de "isto eh um botao" - o
    # prefixo do nome eh so um palpite (ver .DESCRIPTION).
    $botoesPorBaseClass = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
    foreach ($o in [regex]::Matches($TextoDump,
        '(?im)^\s*Objeto:\s*(?<nome>[^\r\n]+?)\s*\r?\n(?:[^\r\n]*\r?\n){0,3}?\s*BaseClass:\s*(?:commandbutton|commandgroup)\s*$')) {
        [void]$botoesPorBaseClass.Add($o.Groups['nome'].Value.Trim())
    }

    $blocos = [regex]::Matches($TextoDump,
        '(?is)\*\s*PROPRIEDADES\s+DE:\s*(?<caminho>[^\r\n]+)\r?\n[-\s]*\r?\n(?<corpo>.*?)(?=\*\s*PROPRIEDADES\s+DE:|\z)')

    foreach ($b in $blocos) {
        $corpo = $b.Groups['corpo'].Value

        # So CommandButton/CommandGroup: o resto nao dispara acao por Click.
        # Aceita pelo BaseClass da arvore (prova) OU pelo prefixo do nome
        # (fallback para dump sem a SECAO 1 legivel) - ver .DESCRIPTION.
        $nome = [regex]::Match($corpo, '(?im)^\s*Name\s*=\s*"([^"]+)"').Groups[1].Value
        if ([string]::IsNullOrWhiteSpace($nome)) { continue }
        if (($nome -notmatch '(?i)^(cmd|btn|command|Grupo)') -and
            (-not $botoesPorBaseClass.Contains($nome))) { continue }

        $caption = [regex]::Match($corpo, '(?im)^\s*Caption\s*=\s*"([^"]*)"').Groups[1].Value

        # MEMBRO INTERNO do CommandGroup: quando o SCX declara o botao DENTRO
        # de um grupo, o Name/Caption de primeiro nivel sao do GRUPO - e o
        # grupo costuma nao ter Caption nenhum e um Name que nao diz nada
        # ('btnReport'). O verbo mora no membro: 'Command1.Name = "Cmd_Imprimir"'.
        # Mesma licao do CLAUDE.md #31 (membro interno com NOME PROPRIO nao se
        # ignora) e a mesma familia de erro que a deteccao por BaseClass ja
        # desfez neste helper - decidir pelo nivel errado do dump.
        $brutos = [System.Collections.Generic.List[string]]::new()
        [void]$brutos.Add($caption)
        [void]$brutos.Add($nome)
        foreach ($mi in [regex]::Matches($corpo, '(?im)^\s*\w+\.(?:Name|Caption)\s*=\s*"([^"]*)"')) {
            [void]$brutos.Add($mi.Groups[1].Value)
        }

        foreach ($bruto in $brutos) {
            if ([string]::IsNullOrWhiteSpace($bruto)) { continue }

            # "\<Transfere" -> "Transfere"; "Rede \<Dial-Up" -> "Rede Dial Up";
            # "cmdtran" -> "tran"
            $limpo = $bruto -replace '\\<', '' -replace '&', ''
            $limpo = $limpo -replace '(?i)^(cmd|btn|command)', ''
            $limpo = $limpo -replace '[^\p{L}]+', ' '

            foreach ($palavra in ($limpo -split '\s+')) {
                if ($palavra.Length -lt 4) { continue }
                if ($verbosDeSaida -contains $palavra.ToLower()) { continue }
                [void]$candidatos.Add($palavra)
            }
        }
    }

    foreach ($verbo in ($candidatos | Select-Object -Unique)) {
        # Raiz do verbo: "Transfere"/"Transferir"/"Transferencia" partilham
        # "Transfer"; "Recebe"/"Receber"/"Recebimento" partilham "Receb".
        $raiz = $verbo
        if ($raiz.Length -gt 5) { $raiz = $raiz.Substring(0, $raiz.Length - 1) }
        $raizEscapada = [regex]::Escape($raiz)

        # Prefixo Btn OU Cmd: o projeto nomeia handler de botao das DUAS
        # formas (Formsigprdft e o proprio FormSIGOPBOL usam Cmd<Verbo>Click,
        # espelhando o 'Cmd_Imprimir' do legado). Ancorar so em 'Btn' deixava
        # o padrao SILENCIOSAMENTE PARCIAL - casa a familia, nunca o especime
        # (CLAUDE.md #44, item 6).
        if ($ConteudoForm -match "(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(?:Btn|Cmd)\w*$raizEscapada\w*Click\b") {
            return $true
        }
    }

    return $false
}

function Get-ContagemBotoesLegado {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return 0 }

    $nBotoes = ([regex]::Matches($TextoDump, '(?im)^\s*BaseClass:\s*commandbutton\s*$')).Count

    # 1a passada: quais objetos sao CommandGroup (a BaseClass aparece na secao
    # "Objeto:", a ButtonCount aparece na secao "PROPRIEDADES DE:")
    $grupos   = @{}
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\w+)\s*$') {
            if ($matches[1] -ieq 'commandgroup' -and $objAtual) {
                $grupos[$objAtual.ToUpper()] = $true
            }
        }
    }

    # 2a passada: soma a ButtonCount SO dos objetos identificados como grupo
    $objProp = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1]
        } elseif ($linha -match '^\s*ButtonCount\s*=\s*(\d+)\s*$') {
            if ($objProp -and $grupos.ContainsKey($objProp.ToUpper())) {
                $nBotoes += [int]$matches[1]
            }
        }
    }

    return $nBotoes
}

# ---------------- medicao dos predicados da Fase 8 para SIGOPLOC ----------------
$dump = Get-Content 'C:\4c\tasks\task763\SigOpLoc_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg' -Raw

$temLista  = ($dump -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
             ($dump -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCampos = ($dump -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')

$padroesCrud = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrud = -not ($padroesCrud | Where-Object { $dump -match $_ })

$padroesSalvar = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$semSalvar = -not ($padroesSalvar | Where-Object { $dump -match $_ })

$soLeitura = Test-LegadoSomenteLeitura -TextoDump $dump
$temCarregar = ($conteudo -match 'PROCEDURE\s+Carregar\w*')
$acaoHandler = Test-AcaoDoLegadoTemHandler -TextoDump $dump -ConteudoForm $conteudo
$nBotoes = Get-ContagemBotoesLegado -TextoDump $dump
$temPcEscolha = ($dump -match 'pcEscolha')

Write-Host "temListaLegadoF8        = $temLista"
Write-Host "temCamposLegadoF8       = $temCampos"
Write-Host "semCrudLegadoF8         = $semCrud"
Write-Host "legadoSemSalvar         = $semSalvar"
Write-Host "Test-LegadoSomenteLeitura = $soLeitura   (FALSE => NAO eh visualizador/exibicao)"
Write-Host "migrado tem PROCEDURE Carregar* = $temCarregar"
Write-Host "nBotoesLegado           = $nBotoes"
Write-Host "dump cita pcEscolha     = $temPcEscolha"
Write-Host "Test-AcaoDoLegadoTemHandler = $acaoHandler"
Write-Host ""
$fluxoUnico = ($semCrud -and $temLista -and $temCampos -and (-not $soLeitura) -and $temCarregar)
Write-Host "=> legadoFluxoUnicoF8   = $fluxoUnico  (dispensa BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista)"
Write-Host "=> gate botao de acao   = $(if($acaoHandler){'SATISFEITO via Test-AcaoDoLegadoTemHandler'}else{'FALHA'})"
$nomes = @('BtnCancelarClick','FormParaBO','BOParaForm','CarregarLista')
$faltam = @($nomes | Where-Object { $conteudo -notmatch $_ })
Write-Host "nomes canonicos ausentes no arquivo (antes da dispensa) = $($faltam -join ', ')"

