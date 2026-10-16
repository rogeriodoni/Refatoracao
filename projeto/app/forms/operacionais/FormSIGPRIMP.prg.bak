*==============================================================================
* FormSIGPRIMP.prg
* Form: Importacao de dados (Movimentacao de Estoque a partir de arquivo .TXT)
* Herda de: FormBase
* Tipo: OPERACIONAL - layout PLANO (sem PageFrame): o legado (SIGPRIMP.SCX) nao
*       tem PageFrame - cabecalho + textbox de arquivo + listbox de arquivos
*       disponiveis + botoes de acao (Visualizar/Imprimir/Movimentar/Encerrar),
*       todos filhos diretos do form (sem container de botoes).
* SCX Origem: SIGPRIMP.SCX (tasks\task629\SIGPRIMP_form_codigo_fonte.txt)
*
* Estrutura: DEFINE CLASS, Init/InicializarForm, cabecalho (cntSombra), area
* de arquivos (Shape2/Label/TextBox/ListBox) e botoes de acao (Shape1/
* Cancela/Visualizar/Imprimir/BtnMovEst) - todos filhos diretos do form.
*
* SEM LOOKUP: SIGPRIMP.SCX nao tem campo algum com busca auxiliar - a varredura
* do dump por fwBuscaExt/fwBuscaSel/fwBuscaInt/mAddColuna/sigacess()/Acesso*()
* devolve ZERO ocorrencia. O unico campo da tela (Get_Arquivo) apenas EXIBE o
* diretorio de importacao lido de SigCdPam e tem "PROCEDURE When / Return .f."
* no legado, isto eh, nao aceita digitacao - campo somente-leitura nao tem onde
* receber codigo para um picker resolver. Criar FormBuscaAuxiliar aqui seria
* inventar tabela de lookup que o original nunca consulta (viola os PILARES 1
* e 2 e a regra "NUNCA inventar tabelas de lookup").
*
* REGRA DOS CAMPOS (entra nesta fase junto com eles): o legado condiciona o
* botao "Moviment. de Estoque" ao campo de arquivo -
* "btnMovEst.PROCEDURE When / Return !Empty(thisform.get_Arquivo.Value)": com o
* diretorio em branco o botao fica DESABILITADO, nao apenas inerte. Reproduzido
* por ValidarArquivoImportacao() (a regra) + AtualizarEstadoBotoes() (o efeito
* visual do When), chamados no funil de carga, no fim do InicializarForm e no
* retorno do processamento (regra #40 - quem desabilita tem de reabilitar).
*
* HOOKS DE TRANSFERENCIA (FormParaBO/BOParaForm): existem de verdade neste
* form, embora o legado nao lhes de nome. O Init do SCX faz
* "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" - isso eh BOParaForm()
* literal (property do BO -> campo da tela); e o btnMovEst.Click le o
* diretorio de volta e monta "lcArq = lcDirImport + Alltrim(laArq(lnPrc,1))"
* para entregar ao MovEst - isso eh FormParaBO() (campo da tela -> property do
* BO). Esta fase so os CONSOLIDA num ponto unico de recarga: antes as duas
* atribuicoes estavam inline em CarregarListaArquivos e em BtnMovEstClick.
*
* NOMES CANONICOS DE CRUD QUE NAO TEM EQUIVALENTE AQUI (o legado nao tem CRUD -
* nem frmcadastro, nem Grupo_Op, nem pcEscolha, nem Incluir/Alterar/Excluir -
* e criar metodo vazio eh proibido pela regra de completude):
*   HabilitarCampos(par_lHabilitar) - nao ha campo editavel para habilitar: o
*     unico TextBox eh somente-leitura por construcao ("Get_Arquivo.When /
*     Return .f.") e o ListBox so aceita selecao. Quem decide o que esta ativo
*     eh AtualizarEstadoBotoes(), que reproduz o When do btnMovEst.
*   LimparCampos() - o legado DECIDIU nao limpar: a linha que zeraria o campo
*     esta COMENTADA no fim do movest ("*!* thisform.get_Arquivo.Value = []").
*     Limpar aqui divergiria do comportamento original (PILAR 1); o diretorio
*     de importacao eh fixo e vem de SigCdPam, nao eh dado de digitacao.
*   AjustarBotoesPorModo() - nao existe modo (LISTA/INCLUIR/ALTERAR/
*     VISUALIZAR/EXCLUIR) nesta tela. O equivalente real eh
*     AtualizarEstadoBotoes(), chamado no funil de carga, no fim do
*     InicializarForm e no retorno do processamento (regra #40).
*   BtnBuscarClick / BtnSalvarClick - o SCX tem exatamente tres botoes ativos:
*     btnMovEst (a acao, -> BtnMovEstClick), Cancela (-> BtnCancelarClick) e os
*     dois ocultos Visualizar/Imprimir. Nao ha botao de busca nem de gravar
*     registro; a gravacao eh o proprio processamento do arquivo.
*
* NAO-PORT DELIBERADO: PROCEDURE Load do legado so chama =fConfigGeral()
* (funcao GLOBAL legada que nao veio no acervo). O wrapper NO-OP em
* utils\fconfiggeral.prg existe so para o p-code de VCX legado continuar
* resolvendo o nome - este form herda direto de "form" (BaseClass), sem
* VCX nenhum, entao nem o wrapper eh alcancado. O que fConfigGeral fazia
* (config global) ja ocorre antes deste form abrir via config.prg/main.prg/
* SIGPRIMPBO.CarregarParametrosSistema(). Mesmo padrao de FormSigPrEop.prg/
* FormSigPrCar.prg/FormSigMvExp.prg.
*==============================================================================

DEFINE CLASS FormSIGPRIMP AS FormBase

    *-- Dimensoes e comportamento exatos do original (SIGPRIMP.SCX: 1000x330)
    Width        = 1000
    Height       = 330
    Caption      = "Importa" + CHR(231) + CHR(227) + "o de dados"
    AutoCenter   = .T.
    DataSession  = 2
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    *-- SCX: Closable = .F. / Movable = .F. / ClipControls = .F. Com TitleBar = 0
    *-- nao ha caixa de fechar nem barra para arrastar, mas Closable = .F. e' o
    *-- que impede fechar por Ctrl+F4 - no legado a saida e' sempre o botao
    *-- Encerrar (Cancela, com Cancel = .T.). THIS.Release() nao e' afetado.
    *-- ShowTips = .T. do SCX nao se repete: ja vem herdado de FormBase.
    *-- A saida ("Cancela" no legado, Caption="Encerrar") tem handler
    *-- BtnCancelarClick - nome canonico (Btn*Click), nao o nome do objeto
    *-- legado (regra PILAR 3 + gate da Fase 7, piso de handlers por prefixo).
    Closable     = .F.
    Movable      = .F.
    ClipControls = .F.
    Themes       = .F.
    WindowType   = 1
    ShowWindow   = 1

    *==========================================================================
    * Init - o PROCEDURE Init do SCX legado nao recebe parametros
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria o Business Object e monta a estrutura visual
    * completa (cabecalho, area de arquivos e botoes de acao), carrega os
    * parametros do sistema e a lista de .TXT disponiveis, e aplica a regra do
    * When do legado sobre o botao de movimentacao (AtualizarEstadoBotoes).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRIMPBO." + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF

            *-- Le SigCdPam e lista os .TXT do diretorio de importacao (Init do
            *-- legado). O guard de modo teste/validacao de UI (sem conexao SQL)
            *-- mora DENTRO de CarregarLista(), que eh o funil unico de carga.
            THIS.CarregarLista()

            THIS.TornarControlesVisiveis(THIS)

            *-- Efeito do "btnMovEst.When" do legado: o botao de movimentacao
            *-- fica habilitado so se o campo de arquivo estiver preenchido.
            THIS.AtualizarEstadoBotoes()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame): o legado
    * (SIGPRIMP.SCX) nao declara PageFrame nenhum - so aplica fonte padrao
    * equivalente ao container raiz. Metodo mantido para compatibilidade com a
    * validacao textual do pipeline de migracao (Fase 3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra a montagem da "pagina" unica do form
    * OPERACIONAL (cabecalho + arquivo + lista + botoes de acao). Equivale a
    * Page1 (Lista) dos forms CRUD. Este form NAO tem Grid/CRUD (SIGPRIMP.SCX
    * nao declara PageFrame nem grade de registros - a "lista" do legado eh o
    * ListBox de arquivos .TXT disponiveis para importacao, e as "acoes" sao
    * Visualizar/Imprimir/Movimentar Estoque/Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaArquivos()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *==========================================================================
    * ConfigurarAreaArquivos - Shape2 (moldura decorativa), label "Arquivos
    * Importacao :", TextBox com o diretorio de importacao (somente leitura -
    * equivalente ao Get_Arquivo.When que sempre retorna .F. no legado) e o
    * ListBox com os arquivos .TXT disponiveis (Arquivos no legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaArquivos()
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 7
            .Left        = 4
            .Width       = 758
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
            .Left      = 310
            .Top       = 111
            *-- Say4 do SCX e' classe "say" (AutoSize=.T./Alignment=0) e nao
            *-- declara Width. Regra #23: AutoSize e' no-op em Label criado por
            *-- AddObject, logo a Width vai explicita. Medido no VFP9
            *-- (automation\medir_fase5_sigprimp.prg): o caption em Tahoma 8
            *-- bold mede 126 px - com 125 a legenda era CORTADA. 130 e' o vao
            *-- exato ate o TextBox (310 -> 440), sem invadi-lo.
            .Width     = 130
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 21
            .Left          = 440
            .Top           = 108
            .Width         = 250
            .Margin        = 0
            .SpecialEffect = 1
            .TabIndex      = 4
            .BorderColor   = RGB(100, 100, 100)
            *-- "SIGPRIMP.Get_Arquivo / PROCEDURE When / Return .f." do dump: no
            *-- legado o campo NUNCA recebe foco - ele so EXIBE o diretorio de
            *-- importacao que o Init le de SigCdPam. ReadOnly impede a edicao e
            *-- TabStop = .F. reproduz o salto do controle na ordem de
            *-- tabulacao, que eh o efeito do When devolvendo .F.
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = ""
            .Height        = 169
            .Left          = 402
            .Top           = 130
            .Width         = 288
            .Sorted        = .T.
            .TabIndex      = 6
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes de acao do form (Cancela/Encerrar,
    * Visualizar, Imprimir, btnMovEst). Visualizar/Imprimir permanecem com
    * Visible = .F. (igual ao Init do legado - "Thisform.imprimir.Visible = .f."
    * / "Thisform.visualizar.Visible = .f.") e nunca sao reativados em nenhum
    * ponto do dump original: o Click deles referencia um container
    * "opEstoque" que nao existe em SIGPRIMP.SCX (codigo morto herdado do
    * template Fortyus, inalcancavel porque os botoes ficam sempre ocultos).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        *-- Shape1 do legado: moldura decorativa sobre a area dos 4 botoes de
        *-- acao (Left=773..1002 cobre BtnMovEst/Visualizar/Imprimir/Cancela).
        *-- BackStyle=0 + BorderStyle=0 (transparente) - igual ao Shape2.
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -12
            .Left        = 773
            .Width       = 229
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 925
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .PicturePosition = 13
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")

        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top               = 3
            .Left              = 775
            .Height            = 75
            .Width             = 75
            .WordWrap          = .F.
            .Picture           = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Themes            = .T.
            .Caption           = "\<Video"
            .Enabled           = .T.
            .PicturePosition   = 13
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top               = 3
            .Left              = 850
            .Height            = 75
            .Width             = 75
            .Picture           = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Themes            = .T.
            .Caption           = "\<Impressora "
            .Enabled           = .T.
            .PicturePosition   = 13
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
        WITH THIS.cmd_4c_BtnMovEst
            .Top             = 3
            .Left            = 700
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .Themes          = .T.
            .Caption         = "Moviment. de Estoque"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .PicturePosition = 7
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnMovEst, "Click", THIS, "BtnMovEstClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de carga da "lista" deste form OPERACIONAL (o
    * ListBox de arquivos .TXT disponiveis; nao ha Grid nem registros de CRUD).
    * Concentra o guard de ambiente: em validacao de UI / modo teste nao ha
    * conexao SQL, e CarregarParametrosSistema() faz SQLEXEC em SigCdPam.
    *
    * PUBLIC de proposito: o harness (TesteAutomatico.prg) chama
    * THIS.oForm.CarregarLista() de FORA da classe - metodo PROTECTED passaria
    * o PEMSTATUS(...,5) e falharia na chamada real (regra #3/#51).
    *==========================================================================
    PROCEDURE CarregarLista()
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            *-- Sem banco: a tela fica montada e vazia, como o legado ficaria
            *-- se o diretorio de importacao estivesse em branco. O estado dos
            *-- botoes continua sendo decidido pelo When reproduzido.
            THIS.AtualizarEstadoBotoes()
            RETURN .F.
        ENDIF

        RETURN THIS.CarregarListaArquivos()
    ENDPROC

    *==========================================================================
    * CarregarListaArquivos - Le SigCdPam (CarregarParametrosSistema do BO),
    * exibe o diretorio de importacao no txt_4c_Arquivo (via BOParaForm) e
    * lista os .TXT disponiveis no obj_4c_Arquivos. Equivalente ao final do
    * PROCEDURE Init do legado (linhas 699-715 do dump).
    *
    * Entrar por aqui pressupoe conexao SQL ativa - o guard de ambiente esta em
    * CarregarLista(), que eh o ponto de entrada.
    *==========================================================================
    PROTECTED PROCEDURE CarregarListaArquivos()
        *-- LOCAL com subscrito JA declara ARRAY: medido no VFP9 2026-10-14
        *-- (automation\medir_fase8_localarray.prg) - "LOCAL loc_aArq[1]"
        *-- misturado com escalares devolve TYPE "C" e ADIR preenche
        *-- normalmente, identico a "LOCAL ARRAY". Quem estoura
        *-- "'LOC_AARQ' is not an array" eh "LOCAL loc_aArq" SEM o subscrito.
        LOCAL loc_aArq[1], loc_nArq, loc_nPrc

        IF !THIS.this_oBusinessObject.CarregarParametrosSistema()
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        *-- "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" do Init legado
        THIS.BOParaForm()

        THIS.obj_4c_Arquivos.Clear()

        loc_nArq = ADIR(loc_aArq, ALLTRIM(THIS.this_oBusinessObject.this_cDirImport) + "*.TXT")
        IF loc_nArq > 0
            FOR loc_nPrc = 1 TO loc_nArq
                THIS.obj_4c_Arquivos.AddItem(ALLTRIM(loc_aArq[loc_nPrc, 1]))
            ENDFOR
        ENDIF

        *-- O campo acabou de mudar: reavalia o When do legado sobre o botao.
        THIS.AtualizarEstadoBotoes()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarArquivoImportacao - Transcricao do guard que o legado mantem sobre
    * o campo de arquivo:
    *
    *     SIGPRIMP.btnMovEst / PROCEDURE When
    *     Return !Empty(thisform.get_Arquivo.Value)
    *
    * Sem o diretorio de importacao preenchido (SigCdPam.DirImports) nao ha o
    * que varrer: o legado nem deixa o botao "Moviment. de Estoque" ativo.
    * PUBLIC de proposito - eh chamado pelo handler do Click, por
    * AtualizarEstadoBotoes e de FORA da classe pelas checagens do pipeline
    * (metodo PROTECTED falharia em runtime - regra #51).
    *==========================================================================
    PROCEDURE ValidarArquivoImportacao()
        LOCAL loc_cDirImport

        IF VARTYPE(THIS.txt_4c_Arquivo) != "O"
            RETURN .F.
        ENDIF

        *-- Fonte unica eh o TEXTBOX, nao a property do BO: eh o .Value que o
        *-- legado le no When (e eh dele que BtnMovEstClick monta o caminho).
        loc_cDirImport = ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))

        RETURN !EMPTY(loc_cDirImport)
    ENDPROC

    *==========================================================================
    * AtualizarEstadoBotoes - Aplica na tela o resultado do When do legado.
    * O VFP9 reavalia o When a cada tentativa de foco; o migrado liga o guard ao
    * .Enabled do botao e o atualiza em TODO caminho que mexe no campo (carga
    * inicial, fim do InicializarForm e retorno do processamento) - sem isso o
    * usuario clicaria num botao ativo que nao faz nada, sem retorno nenhum.
    * O botao tem Caption + Themes = .T. + DisabledPicture, entao continua
    * desenhando o icone quando desabilitado.
    *==========================================================================
    PROCEDURE AtualizarEstadoBotoes()
        IF VARTYPE(THIS.cmd_4c_BtnMovEst) != "O"
            RETURN
        ENDIF

        THIS.cmd_4c_BtnMovEst.Enabled = THIS.ValidarArquivoImportacao()
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere BO -> Form. Transcricao do bloco do Init legado
    * que exibe o diretorio de importacao na tela:
    *
    *     SIGPRIMP / PROCEDURE Init
    *     Thisform.get_Arquivo.Value = crSigCdPam.DirImports
    *
    * (crSigCdPam eh o cursor de SigCdPam, que nesta arquitetura virou
    * SIGPRIMPBO.CarregarParametrosSistema -> this_cDirImport.)
    *
    * Reavalia o estado dos botoes no fim porque o campo que o When do legado
    * consulta ACABOU de mudar - sem isso o botao de movimentacao ficaria
    * cinza mesmo com o diretorio preenchido.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm" e
    * o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador aqui
    * nao tornaria o metodo publico, so esconderia que ele segue protegido.
    * Medido em 2026-10-14 (automation\probe_fase8_sigprimp.prg): declarado sem
    * PROTECTED, PEMSTATUS(...,2) ainda devolve .T. e a chamada de FORA da
    * classe estoura "Property BOPARAFORM is not found". Chamar sempre por
    * THIS. de dentro da classe (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDirImport, ""))
            loc_lSucesso = .T.
        ENDIF

        THIS.AtualizarEstadoBotoes()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere Form -> BO. Equivalente ao inicio do
    * btnMovEst.Click do legado, que le o diretorio de volta e monta o caminho
    * do arquivo que vai ser entregue ao processamento:
    *
    *     SIGPRIMP.btnMovEst / PROCEDURE Click
    *     lcDirImport = Alltrim(crSigCdPam.DirImports)
    *     lcArq = lcDirImport + Alltrim(laArq(lnPrc, 1))
    *     llOk = ThisForm.MovEst(lcArq)
    *
    * par_cArquivo - caminho completo do .TXT da volta corrente do laco.
    *
    * SEM o argumento, APENAS o diretorio eh sincronizado e this_cArquivo fica
    * INTACTO. Isso nao eh detalhe: FormBase.Salvar() chama THIS.FormParaBO()
    * sem argumento nenhum, e zerar this_cArquivo ali apagaria o arquivo em
    * processamento no meio do caminho - o BO receberia caminho vazio e
    * recusaria a importacao com "Informe o arquivo a importar.".
    *
    * A FONTE do diretorio eh o TEXTBOX, nao a property do BO: eh o .Value que
    * o When do legado consulta, e eh dele que o caminho do arquivo foi montado
    * em BtnMovEstClick (mesmo criterio de fonte unica de
    * ValidarArquivoImportacao).
    *
    * Retorno LOGICO de proposito: o chamador tem de ABORTAR o processamento
    * quando a transferencia falha - hook de transferencia que devolve sempre
    * .T. (ou nada) deixa o fluxo seguir com property errada e o BO gravaria em
    * cima de dado invalido, calado.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de BOParaForm (escopo herdado de
    * FormBase; o VFP9 nao deixa alargar).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO(par_cArquivo)
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_Arquivo) = "O"

            THIS.this_oBusinessObject.this_cDirImport = ;
                ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))

            IF VARTYPE(par_cArquivo) = "C"
                loc_cArquivo = ALLTRIM(par_cArquivo)
                THIS.this_oBusinessObject.this_cArquivo = loc_cArquivo

                *-- Com arquivo informado, a transferencia so vale se ele
                *-- existir: o legado monta o caminho a partir do que o ADir
                *-- devolveu, logo um caminho inexistente aqui significa que o
                *-- arquivo saiu do diretorio entre a listagem e o
                *-- processamento.
                loc_lSucesso = !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            ELSE
                *-- Sincronizacao do diretorio apenas - nada a validar.
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - Botao Encerrar (Cancela no legado: "ThisForm.Release").
    * Nome segue o padrao canonico PROCEDURE (Cmd|Btn)\w*Click do projeto -
    * nao herdar o nome do objeto legado (regra PILAR 3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnMovEstClick - Processa TODOS os .TXT do diretorio de importacao
    * (btnMovEst.Click do legado): para cada arquivo chama o BO.Inserir()
    * (equivalente a ThisForm.MovEst(lcArq)); em caso de sucesso move o
    * arquivo para a subpasta "OK\" e remove da lista. O guard de habilitacao
    * do legado (PROCEDURE When: "Return !Empty(thisform.get_Arquivo.Value)")
    * vira o IF EMPTY no inicio do metodo.
    *==========================================================================
    PROCEDURE BtnMovEstClick()
        LOCAL loc_cDirImport, loc_aArq[1], loc_nArq, loc_nPrc, loc_cArq, ;
            loc_lOk, loc_cPastaOk, loc_cDestino, loc_cNomeArq

        *-- Mesmo guard do "btnMovEst.When" do legado: o .Enabled ja impede o
        *-- clique, mas tecla de atalho/Enter tambem chega ao Click.
        IF !THIS.ValidarArquivoImportacao()
            RETURN
        ENDIF

        loc_cDirImport = ALLTRIM(THIS.txt_4c_Arquivo.Value)

        loc_nArq = ADIR(loc_aArq, loc_cDirImport + "*.TXT")
        IF loc_nArq > 0
            FOR loc_nPrc = 1 TO loc_nArq
                WAIT WINDOW "Processando Arquivo " + ALLTRIM(STR(loc_nPrc)) + ;
                    " de " + ALLTRIM(STR(loc_nArq)) NOWAIT NOCLEAR

                loc_cNomeArq = ALLTRIM(loc_aArq[loc_nPrc, 1])
                loc_cArq     = loc_cDirImport + loc_cNomeArq
                loc_cDestino = ""

                *-- Transferencia Form -> BO num ponto unico. Falhando (arquivo
                *-- saiu do diretorio entre a listagem e agora), pula para o
                *-- proximo em vez de mandar o BO abrir caminho inexistente.
                IF !THIS.FormParaBO(loc_cArq)
                    LOOP
                ENDIF

                loc_lOk = THIS.this_oBusinessObject.Inserir()

                IF loc_lOk
                    loc_cPastaOk = loc_cDirImport + "OK\"
                    IF !DIRECTORY(loc_cPastaOk)
                        MKDIR (loc_cPastaOk)
                    ENDIF
                    IF DIRECTORY(loc_cPastaOk)
                        loc_cDestino = loc_cPastaOk + loc_cNomeArq
                        COPY FILE (loc_cArq) TO (loc_cDestino)
                    ENDIF
                    IF !EMPTY(loc_cDestino) AND FILE(loc_cDestino)
                        DELETE FILE (loc_cArq)
                        *-- O legado remove por POSICAO ("Arquivos.RemoveItem(
                        *-- lnPrc - lnDel)"), o que casa com a ordem do ADir -
                        *-- mas o ListBox tem "Sorted = .T." no SCX, entao a
                        *-- ordem EXIBIDA eh alfabetica e a posicao do ADir
                        *-- aponta para outra linha: o arquivo processado fica
                        *-- na lista e um nao-processado desaparece dela. Defeito
                        *-- HERDADO (regra #28); conserto registrado aqui -
                        *-- remover pelo NOME entrega o efeito que o legado
                        *-- evidentemente pretendia, sem depender da ordenacao.
                        THIS.RemoverArquivoDaLista(loc_cNomeArq)
                    ENDIF
                    THIS.obj_4c_Arquivos.Refresh()
                ENDIF
            ENDFOR
        ELSE
            *-- Legado: Messagebox([Nenhum arquivo para importar.],64,[Aviso]) - o
            *-- icone 64 eh INFORMACAO (MsgInfo), nao aviso (48); o titulo do legado
            *-- eh "Aviso" mesmo assim. Transcrito literal.
            MsgInfo("Nenhum arquivo para importar.", "Aviso")
        ENDIF

        *-- Funil de volta (regra #40): reavalia o When apos o processamento.
        THIS.AtualizarEstadoBotoes()
    ENDPROC

    *==========================================================================
    * RemoverArquivoDaLista - Tira do obj_4c_Arquivos a linha cujo texto eh o
    * nome do arquivo informado. Substitui o RemoveItem por POSICAO do legado,
    * que nao funciona com o "Sorted = .T." que o proprio SCX declara no
    * ListBox (ver comentario em BtnMovEstClick).
    *
    * Varre de BAIXO para CIMA: RemoveItem reindexa as linhas seguintes, e
    * percorrer na ordem crescente pularia a linha logo abaixo da removida.
    *==========================================================================
    PROCEDURE RemoverArquivoDaLista(par_cNomeArq)
        LOCAL loc_nI, loc_cAlvo

        IF VARTYPE(THIS.obj_4c_Arquivos) != "O" OR VARTYPE(par_cNomeArq) != "C"
            RETURN .F.
        ENDIF

        loc_cAlvo = UPPER(ALLTRIM(par_cNomeArq))

        FOR loc_nI = THIS.obj_4c_Arquivos.ListCount TO 1 STEP -1
            IF UPPER(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_nI))) == loc_cAlvo
                THIS.obj_4c_Arquivos.RemoveItem(loc_nI)
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cabecalho escuro (cntSombra no legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top         = 17
            .Width       = THIS.Width
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - este form OPERACIONAL tem uma unica "pagina" (par_nPagina
    * = 1). Mantido para compatibilidade com o padrao do pipeline de migracao.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina != 1
            RETURN
        ENDIF
        THIS.Enabled = .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao). cmd_4c_Visualizar
    * e cmd_4c_Imprimir ficam FORA do loop: o legado os mantem Visible = .F.
    * para sempre (Init: "Thisform.imprimir.Visible = .f." / "Thisform.
    * visualizar.Visible = .f.", nunca revertido em nenhum ponto do dump).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_VISUALIZAR", "CMD_4C_IMPRIMIR")
                    *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera referencia do Business Object
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
