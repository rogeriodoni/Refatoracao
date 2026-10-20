# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrRssBO.prg] Marcador: * Todo
[SigPrRssBO.prg] Indicador de pendencia: * deixando o lock pendente
[SigPrRssBO.prg] Indicador de pendencia: * nao achou -> so pode excluir se SigMvCcr nao tiver movimento pendente
[FormSigPrRss.prg] Indicador de pendencia: *-- Verifica SigMvSlc/SigMvCcr: se tem movimento pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRss.prg):
*==============================================================================
* FormSigPrRss.prg - Recalculo de Saldos (Contas)
* Form OPERACIONAL - layout plano sem PageFrame (SIGPRRSS.SCX do legado)
* Irmao de FormSigPrRsa.prg (Recalculo de Saldos de Produto) - mesma estrutura,
* aplicada a fila de CONTAS (SigOpCls) em vez de produtos (SigOpClP).
* Uso interativo  : CREATEOBJECT("FormSigPrRss").Show()
* Uso parametrizado: CREATEOBJECT("FormSigPrRss", cParam, cUsuario, lOnLine).Show()
*==============================================================================

DEFINE CLASS FormSigPrRss AS FormBase

    *-- Parametros de execucao (populados em Init antes de DODEFAULT)
    this_cMensagemErro  = ""
    this_lParametrizado = .F.          && .T. = chamado por Fortyus.Exe (batch), equivale a ThisForm.Parametrizado
    this_lOnline        = .F.          && ThisForm.Online - ver nota em BtnOKClick (NAO significa loop continuo)
    this_cUsuario       = SPACE(10)    && ThisForm.Usuario - filtra a fila por usuario quando informado
    *-- Flag para interromper o loop de processamento (Encerrar clicado
    *-- durante o processamento). Regra #40: quem desabilita tem de
    *-- reabilitar/sinalizar no funil de volta - ver BtnEncerrarClick.
    this_lParar         = .F.

    *-- Estado do processamento. Duas flags porque o legado tem DOIS niveis:
    *--   "This.Enabled = .F." no topo do OK.Click    -> vale pela EXECUCAO inteira
    *--   "ThisForm.Sair.Enabled = .f." a cada passada -> vale por UMA passada
    *-- (o legado reabilita o Sair entre passadas, para dar ao usuario a
    *-- janela do Inkey para interromper). Modelar isso em flag, e nao ler o
    *-- .Enabled do widget de volta, eh o que permite a AjustarBotoesPorModo
    *-- ser o funil unico (regra #40) e o BtnEncerrarClick decidir sem
    *-- depender de um controle que pode nao ter sido criado.
    this_lEmProcessamento = .F.   && execucao em curso (Processar desabilitado)
    this_lEmPassada       = .F.   && passada em curso (Encerrar desabilitado)

    *-- Propriedades visuais (PILAR 1 - identico ao legado SIGPRRSS)
    Width        = 580
    Height       = 120
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Recalculo de Saldos"
    ShowTips     = .T.
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    WindowState  = 0
    Themes       = .F.
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Armazena parametros ANTES de DODEFAULT (que chama InicializarForm)
    * Transcreve "LParameters pParam, pUsuario, pOnLine" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cParam, par_cUsuario, par_lOnLine)
        THIS.Caption             = "Rec" + CHR(225) + "lculo de Saldos"
        THIS.this_lParametrizado = (TYPE("par_cParam") = "C")
        THIS.this_cUsuario       = IIF(TYPE("par_cUsuario") = "C", par_cUsuario, SPACE(10))
        THIS.this_lOnline        = IIF(TYPE("par_lOnLine") = "L", par_lOnLine, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Dispara o processamento sozinho em modo batch.
    * Transcreve o Activate legado, que tem exatamente 3 linhas:
    *
    *     If ThisForm.Parametrizado
    *         ThisForm.OK.Click()
    *     Endif
    *
    * Sem ele o Fortyus.Exe abre a tela parametrizada e fica esperando um
    * clique HUMANO em Processar - ou seja, o caminho desassistido, que eh a
    * razao de existir dos parametros pParam/pUsuario/pOnLine e de todo o
    * ramo this_lParametrizado (IniciarLog/GravarLog/QUIT), nunca roda.
    * Falha SILENCIOSA: nenhum erro, nenhum log, a tela so nao faz nada.
    *
    * Chama THIS.BtnOKClick() e nao THIS.cmd_4c_OK.Click(): BtnOKClick EH o
    * handler ligado por BINDEVENT ao Click do botao, entao a acao executada
    * eh a mesma, sem depender do despacho do evento.
    *
    * As tres guardas acrescentadas (que o legado nao precisava ter) estao
    * comentadas uma a uma no corpo do metodo.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        *-- Guardas em IF SEPARADOS de proposito: VFP9 NAO faz short-circuit
        *-- em AND/OR, entao encadear tudo numa expressao unica avaliaria
        *-- TODOS os termos sempre - inclusive em estado em que algum deles
        *-- nao pode ser avaliado (regra #27 do CLAUDE.md).
        IF !THIS.this_lParametrizado
            RETURN
        ENDIF

        *-- (1) e (2) O pipeline de migracao roda DESASSISTIDO (regra #6): um
        *-- loop de processamento disparado dentro de uma probe de teste ou da
        *-- validacao de UI travaria a migracao indefinidamente, do mesmo jeito
        *-- que um dialogo modal. No legado nao havia harness nenhum.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        *-- (3) Reentrancia: Activate redispara a CADA reativacao da janela
        *-- (volta de um dialogo, por exemplo) - sem guarda, uma segunda
        *-- varredura empilharia sobre a mesma fila. No legado a passada
        *-- parametrizada terminava em Release/Quit, logo a reentrada nao
        *-- aparecia.
        *--
        *-- A guarda e a FLAG de estado do form, e nao o .Enabled do botao:
        *-- com AjustarBotoesPorModo o .Enabled passou a ser DERIVADO da
        *-- flag, e ler o derivado de volta acrescentaria dependencia de um
        *-- controle que pode nao existir - Activate roda FORA de TRY/CATCH e
        *-- o erro sairia como Program Error cru (regra #38).
        IF THIS.this_lEmProcessamento
            RETURN
        ENDIF

        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form OPERACIONAL (sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e constroi a estrutura base do form
    * Botoes (Processar/Encerrar), label de progresso e Shape decorativo ficam
    * para a fase seguinte (Fase 4) - aqui so o cabecalho/chrome do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrRssBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Parametros de execucao para o BO: via hook, nao inline, para que
                *-- BtnOKClick possa re-sincronizar antes de cada execucao.
                THIS.FormParaBO()

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                *-- ORDEM DOS AddObject = Z-ORDER (o ultimo desenha POR CIMA).
                *-- No SCX legado a ordem de declaracao eh cntSombra -> Shape1
                *-- -> SAIR -> OK -> Label1, isto eh, o Shape1 fica ATRAS dos
                *-- botoes (Shape1 Left=478..568 cobre parte de OK 430..505 e
                *-- de Sair 505..580). Criando ConfigurarPaginaLista (botoes)
                *-- por ultimo, eles desenham por cima do Shape1 decorativo -
                *-- mesma tecnica de FormSigPrRsa.prg (regra #30 CLAUDE.md).
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()

                *-- Estado inicial dos botoes pelo FUNIL, para que o .Enabled
                *-- dos dois seja derivado das flags desde a abertura - e nao
                *-- herdado do default do AddObject.
                THIS.AjustarBotoesPorModo()

                IF THIS.this_lParametrizado
                    THIS.this_oBusinessObject.IniciarLog( ;
                        "Iniciando o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar SigPrRssBO."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container de titulo superior (cntSombra do legado)
    * AddObject FORA de WITH, depois WITH caminho explicito (anti-ghost props)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            *-- .Alignment/.FontUnderline sao DECLARADOS no dump do lblSombra
            *-- (Alignment = 0, FontUnderline = .F.) - transcritos, nao
            *-- inventados. Coincidem com o default do Label, entao nao mudam
            *-- o desenho; estao aqui para fixar o esquerdo-alinhado que a
            *-- classe "say" do Framework pressupoe e impedir que um passe
            *-- posterior "corrija" para .Alignment = 1, que jogaria o texto
            *-- contra a borda direita da caixa (regra #23 do CLAUDE.md).
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontUnderline = .F.
            .ForeColor = RGB(0, 0, 0)
            .Height    = 40
            .Left      = 10
            .Top       = 18
            *-- THIS.Width - 20 (nao a Width do container, nem o 769 do dump):
            *-- com Left = 10, usar a largura cheia do pai joga 10px do label
            *-- para fora dele, e filho que extrapola o pai eh RECORTADO sem
            *-- erro nenhum. O dump declara 769 porque o cntSombra do Form
            *-- Designer tem 800 de largura contra Form.Width = 580.
            .Width     = THIS.Width - 20
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize    = .F.
            *-- Alignment = 0 DECLARADO no dump do lblTitulo (ver nota no
            *-- lbl_4c_Sombra). O dump NAO declara FontUnderline para este
            *-- label, entao aqui ele nao aparece - transcrever so o que o
            *-- legado tem.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .ForeColor   = RGB(255, 255, 255)
            .Height      = 46
            .Left        = 10
            .Top         = 17
            *-- Mesma razao do lbl_4c_Sombra acima.
            .Width       = THIS.Width - 20
            .WordWrap    = .T.
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Agrupa os controles da area operacional (fase 4)
    * Form OPERACIONAL SIGPRRSS nao tem PageFrame/Grid/CRUD (dump: so Shape1,
    * cntSombra, SAIR, OK, Label1 - sem grid, sem lista de registros e sem
    * barra CRUD); aqui montamos os botoes Processar(OK)/Encerrar(Sair) e o
    * label de progresso (equivalente estrutural a "Page1" dos forms CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarLabelProgresso()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Shape1 do legado: elemento decorativo de fundo
    * atras dos botoes OK/SAIR (ver comentario de Z-ORDER em InicializarForm)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 478
            .Height      = 27
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Compatibilidade com o contrato dos forms CRUD. Form
    * OPERACIONAL nao tem PageFrame nem campo de entrada, entao nao ha
    * alternancia de paginas nem foco a devolver - permanece no-op.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Processar(OK) e Encerrar(SAIR), sobrepostos
    * ao Shape1 decorativo. Standalone com Picture: Themes=.T. +
    * DisabledPicture obrigatorio (regra #99 CLAUDE.md). Nomes de objeto
    * conforme mapeamento.json (SIGPRRSS.OK -> cmd_4c_OK).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_OK", "CommandButton")
        WITH THIS.cmd_4c_OK
            .Top             = 3
            .Left            = 430
            .Height          = 75
            .Width           = 75
            .Caption         = "Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .TabIndex        = 1
            .Cancel          = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 505
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ToolTipText     = "[ESC] Sair"
            .TabIndex        = 2
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_OK,   "Click", THIS, "BtnOKClick")
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelProgresso - Label1 do legado: status do processamento.
    * O Init legado limpa o Caption de design ("Label1") para "" antes de
    * qualquer processamento - reproduzido aqui na propria criacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelProgresso()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = ""
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Height    = 20
            .Left      = 135
            .Top       = 94
            .Width     = 309
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - Loop principal de processamento da fila SigOpCls.
    * Transcreve o OK.Click legado. Pontos em que a transcricao e explicita:
    *
    *   - Filtro da fila: "If Not Empty(ThisForm.Usuario) Or ThisForm.Online"
    *     decide entre filtrar por Onlines=1[+Usuario] ou trazer a fila
    *     inteira - fica dentro de SigPrRssBO.BuscarFila().
    *   - "ThisForm.Online" NAO significa loop continuo: ele e mais uma causa
    *     de SAIDA do DO WHILE (junto com ESC, erro de conexao e
    *     !Parametrizado). So repete a passada em modo Parametrizado PURO
    *     (batch) com Online = .F. - transcrito literalmente do legado:
    *     "If Not Parametrizado Or lnKey=27 Or llErrCnx Or Online / Exit".
    *   - MouseSobreBotaoSair: o legado testa
    *     "ThisForm.MouseSobreBotaoSair(mCol(...),mRow(...),ThisForm.Sair)"
    *     com lnKey=151 (clique direito durante o Inkey) para sair mais
    *     cedo. O metodo NAO aparece na extracao dos metodos (Secao 3) e
    *     esta marcado com "*" (desabilitado) na lista de propriedades
    *     customizadas (Secao 4 RESERVED3) - nao existe implementacao para
    *     portar (regra #13: nunca inventar helper que nao existe). O
    *     equivalente funcional (usuario interrompe o processamento clicando
    *     Encerrar) e coberto por this_lParar/BtnEncerrarClick, igual ao
    *     padrao ja estabelecido em FormSigPrRsa.prg.
    *   - TRY/CATCH em volta do corpo da passada: ACRESCIMO, nao transcricao.
    *     O legado rodava sob o ON ERROR global que o fConfigGeral() instalava
    *     no Load; aqui nao existe esse handler, e sem o CATCH a excecao
    *     ESCAPAVA do metodo deixando os DOIS botoes Enabled = .F. - ver o
    *     comentario do CATCH para a medicao e por que isso tranca a janela.
    *     O bloco INKEY/ON ERROR fica de FORA do TRY de proposito: em VFP9 o
    *     TRY/CATCH tem precedencia sobre o ON ERROR em qualquer ponto da
    *     pilha (regra #29), e envolve-lo faria o CATCH roubar o erro que o
    *     "ON ERROR loc_nError = 1" do legado existe para engolir - trocando
    *     "lnKey = 0 e segue" por "aborta a passada".
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        LOCAL loc_lOk, loc_nMov, loc_lErroCnx, loc_lProcessando
        LOCAL loc_nResultLock
        LOCAL loc_nKey, loc_nError, loc_cErro
        LOCAL loc_lSemRecalculo, loc_cMsgFalha
        LOCAL loc_oErro, loc_oErroRollback, loc_cMsgExcecao

        *-- "This.Enabled = .F." do legado, pelo funil (regra #40).
        THIS.HabilitarCampos(.F.)
        THIS.this_lParar = .F.

        *-- Ponto de recarga: re-sincroniza Usuario/Online/Parametrizado com o
        *-- BO antes de montar o SELECT da fila.
        THIS.FormParaBO()
        SET CURSOR OFF

        *-- Keyboard '{LEFTARROW}' do legado: injeta uma tecla inocua para
        *-- que o INKEY() da primeira passada encontre o buffer num estado
        *-- conhecido.
        KEYBOARD "{LEFTARROW}"

        loc_nMov          = 1
        loc_lErroCnx      = .F.
        loc_lProcessando  = .T.
        loc_lSemRecalculo = .F.
        loc_cMsgFalha     = ""
        loc_cMsgExcecao   = ""

        DO WHILE loc_lProcessando

            TRY
                *-- "ThisForm.Sair.Enabled = .f." do legado, pelo funil.
                THIS.this_lEmPassada = .T.
                THIS.AjustarBotoesPorModo()

                *-- Texto LITERAL do legado. Escrito na FONTE (this_cStatusMsg) e
                *-- pintado pelo BOParaForm, que e o unico que toca o Caption.
                THIS.this_oBusinessObject.this_cStatusMsg = ;
                    "Aguardando Contas Para Processar" + REPLICATE(".", loc_nMov)
                THIS.BOParaForm()
                loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)

                loc_lOk = THIS.this_oBusinessObject.BuscarFila()

                IF !loc_lOk
                    loc_lErroCnx = .T.
                ELSE
                    SELECT CrSigOpCls

                    SCAN
                        THIS.this_oBusinessObject.CarregarDoCursor("CrSigOpCls")

                        *-- Lock otimista do item (Update SigOpCls Set Usuars = Usuars)
                        loc_nResultLock = THIS.this_oBusinessObject.MarcarEmProcessamento()

                        IF loc_nResultLock <= 0
                            IF loc_nResultLock = -3
                                *-- queda de conexao com BD: Exit do Scan (legado)
                                loc_lErroCnx = .T.
                                EXIT
                            ENDIF
                            LOOP
                        ENDIF

                        IF !THIS.this_oBusinessObject.ProcessarItem()
                            *-- fRecalculaS INALCANCAVEL (ela esta portada em
                            *-- utils\functions.prg - so cai aqui com deploy
                            *-- quebrado, functions.prg fora do SET PROCEDURE
                            *-- ou PATH mal formado, regra #26). O BO mediu na
                            *-- primeira tentativa e nao tentara de novo -
                            *-- abandonar a passada AGORA, com UMA mensagem no
                            *-- fim, em vez de varrer a fila inteira falhando
                            *-- item a item (travaria o modo parametrizado).
                            IF !THIS.this_oBusinessObject.this_lRecalculoDisponivel
                                loc_lSemRecalculo = .T.
                                EXIT
                            ENDIF
                            IF EMPTY(loc_cMsgFalha)
                                loc_cMsgFalha = THIS.this_oBusinessObject.this_cMensagemErro
                            ENDIF
                            LOOP
                        ENDIF

                        *-- Verifica SigMvSlc/SigMvCcr: se tem movimento pendente,
                        *-- mantem na fila para reprocessar depois (Loop)
                        IF THIS.this_oBusinessObject.VerificarMovimento()
                            LOOP
                        ENDIF

                        *-- "Delete From SigOpCls ... Commit" do legado
                        IF !THIS.this_oBusinessObject.Excluir()
                            IF EMPTY(loc_cMsgFalha)
                                loc_cMsgFalha = THIS.this_oBusinessObject.this_cMensagemErro
                            ENDIF
                            LOOP
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Rollback() incondicional depois do EndScan (legado): descarta
                *-- o que tenha sobrado aberto na passada.
                THIS.this_oBusinessObject.DesfazerTransacao()

            CATCH TO loc_oErro
                *-- O loop faz SQL em toda passada e NAO tinha TRY/CATCH.
                *-- Medido no VFP9 (2026-10-18, automation\ProbeRss672F6.prg):
                *-- com a excecao escapando daqui, a tela ficava com
                *-- cmd_4c_OK.Enabled = .F. E cmd_4c_Sair.Enabled = .F., e
                *-- como este form tem TitleBar = 0 e ControlBox = .F. o
                *-- Encerrar eh a UNICA saida da janela - o usuario ficava
                *-- preso, sem como fechar, e o SET CURSOR vazava OFF. Em modo
                *-- parametrizado era pior: Program Error cru (regra #38) eh
                *-- modal e trava o processamento desassistido (regra #6).
                *--
                *-- Regra #9 (CATCH nunca silencioso): a mensagem eh guardada e
                *-- reportada pelo canal unico DEPOIS do ENDDO - nunca aqui -
                *-- para que a janela ja esteja utilizavel (botoes reabilitados,
                *-- cursor restaurado) quando o dialogo aparecer.
                *-- Regra #1: nenhum RETURN dentro de TRY/CATCH; a saida eh por
                *-- flag (loc_lProcessando) e o RETURN unico fica no fim.
                loc_cMsgExcecao = loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure

                *-- A excecao SALTOU o DesfazerTransacao() do fim da passada:
                *-- sem isto a transacao do item em curso fica ABERTA,
                *-- segurando lock no SQL Server. Em TRY proprio porque o
                *-- rollback pode estourar tambem - conexao caida eh justamente
                *-- uma das causas de cair neste CATCH.
                TRY
                    THIS.this_oBusinessObject.DesfazerTransacao()
                CATCH TO loc_oErroRollback
                    loc_cMsgExcecao = loc_cMsgExcecao + CHR(13) + ;
                        "O rollback tamb" + CHR(233) + "m falhou: " + ;
                        loc_oErroRollback.Message
                ENDTRY

                *-- Abortar a execucao: nao insistir numa fila cujo
                *-- processamento acabou de estourar.
                loc_lProcessando = .F.
            ENDTRY

            *-- "ThisForm.Sair.Enabled = .t." do legado: o Encerrar volta ENTRE
            *-- passadas, que e a janela em que o usuario pode interromper.
            THIS.this_lEmPassada = .F.
            THIS.AjustarBotoesPorModo()

            *-- Aguardar breve intervalo: permite que ESC seja detectado
            loc_nError = 0
            loc_cErro  = ON("Error")
            ON ERROR loc_nError = 1
            loc_nKey = INKEY(0.5, "M")
            IF loc_nError <> 0
                loc_nKey = 0
            ENDIF
            ON ERROR &loc_cErro.

            IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroCnx OR ;
               loc_lSemRecalculo OR THIS.this_lOnline OR THIS.this_lParar
                loc_lProcessando = .F.
            ENDIF

        ENDDO

        SET CURSOR ON

        *-- "ThisForm.Label1.Caption = ''" + "This.Enabled = .T." do legado,
        *-- pelos funis. HabilitarCampos(.T.) repoe AMBOS os botoes, entao nao
        *-- ha caminho de saida que deixe o Encerrar cinza - e ele e a UNICA
        *-- saida desta janela (TitleBar = 0, ControlBox = .F.).
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)

        *-- UMA mensagem por EXECUCAO, nunca uma por item. Em modo
        *-- parametrizado nao ha dialogo: a mensagem vai para o Fortyus.Log.
        DO CASE
        CASE !EMPTY(loc_cMsgExcecao)
            *-- Excecao capturada no loop: eh a falha mais grave e a
            *-- mais informativa, por isso vem ANTES das demais.
            THIS.ReportarFalhaProcessamento( ;
                "O processamento foi interrompido por um erro " + ;
                "inesperado." + CHR(13) + loc_cMsgExcecao, .T.)
        CASE loc_lSemRecalculo
            THIS.ReportarFalhaProcessamento( ;
                THIS.this_oBusinessObject.this_cMensagemErro, .T.)
        CASE loc_lErroCnx
            THIS.ReportarFalhaProcessamento( ;
                "Falha de conex" + CHR(227) + "o com o banco de dados." + CHR(13) + ;
                "O processamento foi interrompido e a fila preservada.", .T.)
        CASE !EMPTY(loc_cMsgFalha)
            *-- Os contadores entram AQUI, e so aqui: esta mensagem e do
            *-- sistema NOVO (o legado nao avisa nada ao deixar item na fila),
            *-- entao dizer quantos ficaram nao altera UX legada nenhuma - ao
            *-- contrario do Caption do Label1, que e texto literal do legado.
            THIS.ReportarFalhaProcessamento( ;
                "Algumas contas n" + CHR(227) + "o puderam ser processadas e " + ;
                "permanecem na fila." + CHR(13) + ;
                "Processadas: " + ;
                ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nProcessados)) + ;
                " de " + ;
                ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nTotalFila)) + ;
                CHR(13) + loc_cMsgFalha, .F.)
        ENDCASE

        IF THIS.this_lParametrizado
            THIS.this_oBusinessObject.GravarLog( ;
                "Concluindo o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
            THIS.Release()
            *-- "If Empty(ThisForm.Usuario) And Not ThisForm.Online / Quit / Endif"
            IF EMPTY(ALLTRIM(THIS.this_cUsuario)) AND !THIS.this_lOnline
                QUIT
            ENDIF
        ENDIF

        *-- Encerrar foi clicado durante o loop: agora e seguro fechar
        IF THIS.this_lParar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ReportarFalhaProcessamento - canal unico de saida das falhas do lote
    * par_lAbortou = .T. -> passada interrompida (erro); .F. -> terminou mas
    * deixou itens na fila (aviso). Modo parametrizado grava no Fortyus.Log
    * e NAO abre dialogo - o form e chamado pelo Fortyus.Exe sem ninguem na
    * frente da tela, e qualquer modal ali trava o processamento desassistido.
    *--------------------------------------------------------------------------
    PROCEDURE ReportarFalhaProcessamento(par_cMensagem, par_lAbortou)
        LOCAL loc_cTitulo, loc_cPrefixo

        IF EMPTY(par_cMensagem)
            RETURN
        ENDIF

        IF THIS.this_lParametrizado
            loc_cPrefixo = IIF(par_lAbortou, "ABORTADO: ", "AVISO: ")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.GravarLog(loc_cPrefixo + par_cMensagem)
            ENDIF
        ELSE
            loc_cTitulo = "Rec" + CHR(225) + "lculo de Saldos"
            IF par_lAbortou
                MsgErro(par_cMensagem, loc_cTitulo)
            ELSE
                MsgAviso(par_cMensagem, loc_cTitulo)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha form ou sinaliza parada do loop
    * Se OK Enabled    = nao estamos no loop -> Release imediato
    * Se OK Disabled   = estamos no loop      -> apenas seta flag; loop sai e Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.this_lParar = .T.

        *-- Decide pela FLAG de estado, nao lendo de volta o .Enabled do
        *-- botao: o estado "ha passada em curso" e do form, nao do widget, e
        *-- assim o Encerrar continua funcionando mesmo que ConfigurarBotoes
        *-- nao tenha rodado.
        IF !THIS.this_lEmProcessamento
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera Business Object (equivalente a "ThisForm.PodataMgr.Release"
    * do PROCEDURE Release legado)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Eventos CRUD - contrato do pipeline (form OPERACIONAL sem CRUD)
    *
    * SIGPRRSS (legado) e um form de PROCESSAMENTO em lote: o dump declara
    * APENAS cntSombra/lblSombra/lblTitulo/Shape1/SAIR/OK/Label1 - sem grid,
    * sem lista de registros e sem barra CRUD (nao herda de frmcadastro, nao
    * tem Grupo_Op nem pcEscolha). A unica acao operacional e Processar
    * (loop sobre SigOpCls), em BtnOKClick.
    *
    * Os SETE Btn*Click abaixo existem SO para manter o contrato de nomes
    * esperado pelo OrquestradorMigracao/TesteAutomatico (que chama
    * THIS.oForm.Metodo() direto de fora da classe - regra #3 CLAUDE.md). Sao
    * no-op SILENCIOSO de proposito, mesmo padrao de FormSigPrRsa.prg:
    *
    * ATENCAO ao ler: esta nota vale APENAS para os Btn*Click (Incluir,
    * Alterar, Visualizar, Excluir, Buscar, Salvar, Cancelar) e para
    * AlternarPagina. Os outros seis hooks do contrato - CarregarLista,
    * AjustarBotoesPorModo, HabilitarCampos, FormParaBO, BOParaForm e
    * LimparCampos - NAO sao no-op: cada um tem trabalho real neste form e
    * esta documentado no proprio corpo.
    *
    *   1. Nenhum cmd_4c_Incluir/Alterar/Visualizar/Excluir e criado por
    *      AddObject neste form (os 4 AddObject - cnt_4c_Cabecalho+2 labels,
    *      shp_4c_Shape1, cmd_4c_OK, cmd_4c_Sair, lbl_4c_Label1 - reproduzem
    *      exatamente os objetos do SCX legado - PILAR 1), entao nao existe
    *      caminho de UI que alcance estes metodos.
    *   2. Em modo de teste MsgAviso nao abre dialogo - ela GRAVA a mensagem
    *      em gc_4c_ArquivoErroTeste e ecoa "ERRO_TESTE:" no console. Avisar
    *      aqui contaminaria o arquivo de ERRO do harness com um nao-erro.
    *   3. A regra de completude do pipeline proibe Btn*Click que so exibe
    *      MsgAviso (stub disfarcado).
    *
    * Retornam .T. (sucesso/no-op) para que qualquer chamador programatico
    * siga o fluxo normal.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - No-op silencioso (legado sem inclusao de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - No-op silencioso (legado sem alteracao de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - No-op silencioso (legado sem visualizacao de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - No-op silencioso (legado sem exclusao manual de registros
    * - a exclusao da fila e automatica, dentro de BtnOKClick/Excluir() do BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Sem-operacao (form OPERACIONAL sem lista de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Sem-operacao (form OPERACIONAL sem modo de edicao CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Sem-operacao (form OPERACIONAL sem modo de edicao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - funil de RECARGA da tela. Nao ha grade nem lista de
    * registros (o SCX legado nao tem Grid), mas o funil existe de verdade:
    * sincroniza os parametros de execucao com o BO e repinta o unico
    * indicador da tela (lbl_4c_Label1). PUBLIC porque o TesteAutomatico o
    * chama de FORA da classe (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.FormParaBO()
        THIS.BOParaForm()
        THIS.AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - FUNIL UNICO do par Processar/Encerrar.
    *
    * Reproduz os quatro pontos em que o OK.Click legado mexe no Enabled:
    *   "This.Enabled = .F."              -> this_lEmProcessamento = .T.
    *   "ThisForm.Sair.Enabled = .f."     -> this_lEmPassada       = .T.
    *   "ThisForm.Sair.Enabled = .t."     -> this_lEmPassada       = .F.
    *   "This.Enabled = .T."              -> this_lEmProcessamento = .F.
    *
    * Regra #40: quem desabilita tem de reabilitar no FUNIL de volta, nunca
    * em cada caller - aqui o estado vem sempre das duas flags, entao nao ha
    * caminho de saida capaz de deixar botao cinza. Esta tela e o caso extremo
    * dessa regra: com TitleBar = 0 e ControlBox = .F., o Encerrar e a UNICA
    * saida da janela - deixa-lo desabilitado prende o usuario.
    *
    * PEMSTATUS porque o metodo e PUBLIC e pode ser chamado antes de
    * ConfigurarBotoes (InicializarForm que falhou, ou harness de teste).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmd_4c_OK", 5)
            THIS.cmd_4c_OK.Enabled = !THIS.this_lEmProcessamento
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
            THIS.cmd_4c_Sair.Enabled = !THIS.this_lEmPassada
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere o estado de ENTRADA do form para o BO.
    *
    * Esta tela nao tem campo digitavel: o SCX legado declara apenas
    * cntSombra/lblSombra/lblTitulo/Shape1/SAIR/OK/Label1 (PILAR 1 - nenhum
    * TextBox foi inventado). O que ALIMENTA a operacao sao os tres
    * parametros do "LParameters pParam, pUsuario, pOnLine" do Init legado,
    * que no legado o proprio OK.Click le direto de ThisForm.Usuario /
    * ThisForm.Online. Transferi-los aqui e o FormParaBO LITERAL deste form -
    * nao e convencao vazia de Page2 de Dados.
    *
    * Existir como metodo (em vez de tres linhas soltas no InicializarForm)
    * da o PONTO DE RECARGA: BtnOKClick o chama no inicio de cada execucao,
    * entao uma segunda passada nunca roda com filtro de fila defasado.
    *
    * PROTECTED EXPLICITO: FormBase.prg declara "PROTECTED PROCEDURE
    * FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o escopo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
        THIS.this_oBusinessObject.this_lOnline        = THIS.this_lOnline
        THIS.this_oBusinessObject.this_cUsuario       = THIS.this_cUsuario
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - reflete o estado do BO no unico indicador da tela.
    *
    * lbl_4c_Label1 (Label1 do legado) e o unico controle de SAIDA do form, e
    * o texto exibido nele e exatamente o que o legado escreve - "Aguardando
    * Contas Para Processar" + Replicate(".", lnMov), montado pelo BtnOKClick
    * e guardado em this_cStatusMsg. Centralizar aqui evita o que o legado
    * tambem nao faz: escrever no Caption de dois lugares diferentes.
    *
    * NAO acrescenta contagem de itens ao Caption: a tela legada nao exibe
    * numero nenhum e isso seria desvio de UX (PILAR 1). Os contadores
    * this_nTotalFila/this_nProcessados sao consumidos apenas pelo relatorio
    * de falha parcial, que e mensagem do sistema novo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !PEMSTATUS(THIS, "lbl_4c_Label1", 5)
            RETURN .F.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.lbl_4c_Label1.Caption = THIS.this_oBusinessObject.this_cStatusMsg
        ELSE
            THIS.lbl_4c_Label1.Caption = ""
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - chave geral "a tela esta utilizavel".
    *
    * Nao ha campo de cadastro para habilitar (ver FormParaBO); o que esta
    * tela habilita/desabilita sao os dois botoes, e e exatamente o que o
    * "This.Enabled = .F." / "ThisForm.Sair.Enabled = .f." do OK.Click legado
    * faz. Escreve nas duas flags e delega a aplicacao ao funil
    * AjustarBotoesPorModo, para que exista UM lugar que toca .Enabled.
    *
    * par_lHabilitar = .F. -> entrando no processamento (os dois desabilitados)
    * par_lHabilitar = .T. -> processamento terminou (os dois de volta)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        THIS.this_lEmProcessamento = !loc_lHabilitar
        THIS.this_lEmPassada       = !loc_lHabilitar
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - apaga o indicador de progresso.
    *
    * E o "ThisForm.Label1.Caption = " que o legado executa em DOIS pontos:
    * no fim do Init e no fim do OK.Click. Limpa na FONTE (this_cStatusMsg do
    * BO) e repinta pelo BOParaForm, senao o proximo BOParaForm traria de
    * volta o texto da passada anterior.
    *
    * PROTECTED EXPLICITO: FormBase.prg declara "PROTECTED PROCEDURE
    * LimparCampos" e o VFP9 NAO deixa a subclasse ALARGAR o escopo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cStatusMsg = ""
        ENDIF
        THIS.BOParaForm()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRssBO.prg):
*==============================================================================
* Classe  : SigPrRssBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de contas (SIGPRRSS)
*            Form OPERACIONAL - processa fila SigOpCls chamando fRecalculaS
*            para cada conta na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*            Irmao de SigPrRsaBO (recalculo de saldo de PRODUTO) - mesma
*            estrutura, aplicada a CONTAS em vez de produtos.
*
* NOTA - fRecalculaS ESTA PORTADA (medido em 2026-10-18)
*   O OK.Click legado chama fRecalculaS duas vezes por item (recalculo do
*   saldo da conta e consolidacao), e a funcao EXISTE na nova arquitetura:
*   projeto\app\utils\functions.prg, portada de Framework\sigfuncs.PRG com
*   SQLEXEC(gnConnHandle) no lugar de loCnx.SqlExecute, junto com a auxiliar
*   fProcessarS. Outros cinco call sites do projeto ja a usam direto
*   (SigPrCccBO, SigPrMdcBO, FormSigPrMdc, Formsigopacc, Formsigmvcot).
*
*   Isto CORRIGE a nota anterior, copiada do irmao SigPrRsaBO, que afirmava
*   ausencia no acervo. A confusao e de NOME e vale registrar: o irmao
*   processa PRODUTOS e chama fRecalculaP - essa sim nao foi portada, e a
*   nota de escopo dele esta certa. Aqui e fRecalculaS, de CONTAS.
*
*   A deteccao de ausencia em ProcessarItem FICA, agora como rede de
*   seguranca de DEPLOY (functions.prg fora do SET PROCEDURE / PATH quebrado
*   - regra #26 ja produziu exatamente isso neste projeto), nao como premissa
*   sobre o acervo: sem ela, uma instalacao com functions.prg inalcancavel
*   abriria um dialogo MODAL por item da fila e travaria o lote.
*
*   fRecalculaS tambem resolve a pendencia do CursorQuery('SigCdPam',
*   'CrSigCdPam',...,[GrupoRecs,GrupoPags,ContaRecs,ContaPags]) que o Init
*   legado fazia: ela propria le essas quatro colunas de SigCdPam para o
*   cursor crAi1, entao o form nao precisa mais pre-carregar o cursor global.
*
* NOTA DE ESCOPO - SigPrSlS (CrSigPrSlS)
*   O Scatter/Zap/Append/Gather que o legado faz sobre esse cursor nao chega
*   ao banco: a linha "Thisform.Podatamgr.Update('CrSigPrSlS')" esta COMENTADA
*   no proprio fonte legado (SigPrRss_form_codigo_fonte.txt:433) e o buffer eh
*   descartado pelo Rollback incondicional que fecha o loop - por isso nao
*   havera INSERT/UPDATE migrado para SigPrSlS.
*==============================================================================
DEFINE CLASS SigPrRssBO AS BusinessBase

    *-- Parametros de execucao (LParameters pParam, pUsuario, pOnLine do Init legado)
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar
    this_lOnline         = .F.  && ThisForm.Online - loop continuo sem prompt de interrupcao
    this_cUsuario        = SPACE(10)  && ThisForm.Usuario - filtra a fila por usuario quando informado

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpCls (fila a processar)
    this_cCidChaves   = ""      && cidchaves char(20) - PK da fila
    this_cGrupos      = ""      && grupos char(10) - grupo da conta
    this_cContas      = ""      && contas char(10) - conta
    this_cMoedas      = ""      && moedas char(3) - moeda
    this_dDatas       = {}      && datas datetime - data do movimento
    this_cGruConMoes  = ""      && gruconmoes char(23) - Grupos + Contas + Moedas
    this_cUsuars      = ""      && usuars char(20) - usuario processador
    this_nOnlines     = 0       && onlines numeric(1,0) - processamento continuo (0/1)
    this_cEmps        = ""      && emps char(3) - empresa
    this_lChkPrc      = .F.     && chkprc bit - checagem de preco

    *-- Controle de TRANSACAO MANUAL (regra: o migrador descarta o Commit()
    *-- do legado e a gravacao fica presa na transacao aberta). O OK.Click
    *-- legado tem DOIS Commit() e SETE Rollback() - sem eles o
    *-- DELETE FROM SigOpCls nunca eh efetivado, a fila NAO drena e o lote
    *-- reprocessa os MESMOS itens a cada passada do DO WHILE, para sempre.
    this_lTransacaoManual = .F.

    *-- fRecalculaS ESTA portada (ver NOTA no cabecalho), entao em instalacao
    *-- sadia esta flag nunca cai. Ela e rede de seguranca de DEPLOY: se
    *-- functions.prg nao estiver alcancavel, a chamada estoura erro 1 do VFP9
    *-- ("File does not exist") e a flag faz a ausencia gerar UMA mensagem e
    *-- abortar a passada, em vez de um MsgErro MODAL POR ITEM da fila, que
    *-- travaria o modo parametrizado.
    this_lRecalculoDisponivel = .T.

    *--------------------------------------------------------------------------
    * Init - BO de processamento em lote (SIGPRRSS), nao um cadastro CRUD:
    * nao ha tabela/chave primaria "principal" governada por Salvar/Excluir,
    * entao this_cTabela e this_cCampoChave permanecem vazios (mesmo padrao de
    * SigPrRsaBO) e DODEFAULT() segue sem instanciar DataAccess.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.DetectarTransacaoManual()
    ENDPROC

    *--------------------------------------------------------------------------
    * DetectarTransacaoManual - mede UMA vez se a conexao esta em transacao
    * MANUAL (SQLGETPROP "Transactions" = 2) ou em auto-commit (1). Mesma
    * tecnica de SigPrRsaBO.prg: medir em vez de presumir deixa o par
    * Confirmar/DesfazerTransacao INERTE em auto-commit, sem precisar saber
    * de antemao qual modo esta ativo.
    *
    * SQLGETPROP com handle invalido DISPARA EXCECAO (nao devolve -1), e o
    * harness de teste define gnConnHandle = 0 de proposito; por isso a
    * guarda de tipo/valor ANTES e o TRY em volta. Sem conexao o resultado eh
    * .F. (par inerte), nunca falha de instanciacao do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DetectarTransacaoManual()
        LOCAL loc_oErro
        THIS.this_lTransacaoManual = .F.
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                THIS.this_lTransacaoManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lTransacaoManual = .F.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - SQLCOMMIT, equivalente ao ThisForm.PodataMgr.Commit()
    * do legado. O OK.Click chama Commit() em dois pontos distintos do loop de
    * processamento (cada um com o proprio caminho de falha) - o commit eh um
    * PASSO da regra de negocio, nao detalhe de infra.
    *
    * Inerte quando a conexao esta em auto-commit: devolve .T. sem chamar
    * nada, porque nesse modo o statement ja foi efetivado.
    *--------------------------------------------------------------------------
    FUNCTION ConfirmarTransacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        IF THIS.this_lTransacaoManual
            TRY
                loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
                IF !loc_lSucesso
                    THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + CHR(227) + ;
                        "o no banco de dados."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lSucesso = .F.
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DesfazerTransacao - SQLROLLBACK, equivalente ao ThisForm.Podatamgr.Rollback()
    * do legado (SETE chamadas no OK.Click: uma por caminho de falha, mais a
    * incondicional apos o EndScan, que descarta o que sobrou aberto na
    * passada). Sem retorno util: o legado tambem descarta o dele.
    *--------------------------------------------------------------------------
    PROCEDURE DesfazerTransacao()
        LOCAL loc_oErro
        IF THIS.this_lTransacaoManual
            TRY
                SQLROLLBACK(gnConnHandle)
            CATCH TO loc_oErro
                *-- Rollback que falha nao tem desdobramento: a transacao ja
                *-- esta perdida e o item sera reprocessado na proxima passada
                *-- (a fila so drena apos o DELETE confirmado). Registrar a
                *-- mensagem permite que o chamador a exiba se quiser, sem
                *-- abrir dialogo aqui - este metodo roda DENTRO do loop e um
                *-- modal por item travaria o modo parametrizado.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarFalha - canal UNICO de erro desta classe.
    *
    * Todo metodo deste BO roda DENTRO do loop de processamento do form (ou,
    * no caso dos logs, dentro do ramo parametrizado) - e em modo
    * parametrizado nao ha ninguem na frente da tela: um MsgErro ali eh modal
    * e TRAVA o processamento desassistido indefinidamente (regra #6), exatamente
    * como o DesfazerTransacao acima ja documentava. Pior: BuscarFila roda a
    * CADA passada e CarregarDoCursor a cada ITEM, entao uma conexao caida
    * geraria um dialogo por item.
    *
    * Regra #9 (CATCH nunca silencioso) continua honrada: a mensagem eh SEMPRE
    * gravada em this_cMensagemErro, que o form reporta uma unica vez por
    * execucao pelo canal dele (ReportarFalhaProcessamento -> Fortyus.Log em
    * modo batch, dialogo em modo interativo). No modo interativo o dialogo
    * imediato eh mantido, porque ali ha usuario para ler.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarFalha(par_cMensagem)
        LOCAL loc_cMensagem
        loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
        IF EMPTY(loc_cMensagem)
            RETURN
        ENDIF
        THIS.this_cMensagemErro = loc_cMensagem
        IF !THIS.this_lParametrizado
            MsgErro(loc_cMensagem, "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveGruConMoes - gruconmoes char(23) = grupos(10) + contas(10) +
    * moedas(3), transcrito de
    *   lcSql = [... where GruConMoes = ']+CrSigOpCls.Grupos+CrSigOpClS.Contas+CrSigOpClS.Moedas+[' ]
    * do OK.Click legado. Chave POSICIONAL (regra #42 CLAUDE.md) - cada parte
    * tem de vir com PADR explicito na largura da coluna de origem, NUNCA
    * ALLTRIM nas partes interiores, senao a concatenacao nunca mais casa com
    * o gruconmoes gravado em SigMvCcr/SigMvSlc (SELECT roda sem erro e
    * devolve ZERO linhas, em silencio).
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveGruConMoes()
        RETURN PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
               PADR(ALLTRIM(THIS.this_cContas), 10) + ;
               PADR(ALLTRIM(THIS.this_cMoedas), 3)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador do registro (fila SigOpCls)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpCls
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cContas    = NVL(contas, "")
                THIS.this_cMoedas    = NVL(moedas, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cUsuars    = NVL(usuars, "")
                THIS.this_nOnlines   = NVL(onlines, 0)
                THIS.this_cEmps      = NVL(emps, "")

                IF TYPE("gruconmoes") != "U"
                    THIS.this_cGruConMoes = NVL(gruconmoes, "")
                ELSE
                    THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()
                ENDIF

                *-- chkprc eh bit NULL - chega como Logico ou Numerico conforme
                *-- o driver (regra #13); testar VARTYPE antes de comparar.
                IF TYPE("chkprc") != "U"
                    IF VARTYPE(chkprc) = "L"
                        THIS.this_lChkPrc = chkprc
                    ELSE
                        THIS.this_lChkPrc = (NVL(chkprc, 0) <> 0)
                    ENDIF
                ELSE
                    THIS.this_lChkPrc = .F.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpCls (enfileira item para recalculo de saldo
    * de conta). Cobre TODAS as colunas da tabela (regra #22): cidchaves eh
    * PK sem default (gerada via fUniqueIds se vazia) e emps/onlines sao
    * NOT NULL sem default.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()

            loc_cSQL = "INSERT INTO SigOpCls " + ;
                       "(grupos, contas, moedas, datas, cidchaves, gruconmoes, " + ;
                       "usuars, onlines, chkprc, emps) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(THIS.this_cGruConMoes) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                       IIF(THIS.this_lChkPrc, "1", "0") + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                *-- Commit explicito: BusinessBase nao da SQLCOMMIT e a conexao
                *-- pode nascer em transacao MANUAL - sem isto o INSERT fica
                *-- preso e some ao fim do processo.
                loc_lSucesso = THIS.ConfirmarTransacao()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    THIS.DesfazerTransacao()
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo de saldos (SigOpCls)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpCls com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()

                loc_cSQL = "UPDATE SigOpCls SET " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "contas = " + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                           "moedas = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "gruconmoes = " + EscaparSQL(THIS.this_cGruConMoes) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "onlines = " + FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                           "chkprc = " + IIF(THIS.this_lChkPrc, "1", "0") + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- Commit explicito (ver nota em Inserir)
                    loc_lSucesso = THIS.ConfirmarTransacao()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ELSE
                        THIS.DesfazerTransacao()
                    ENDIF
                ELSE
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo de saldos (SigOpCls)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de
    * saldos de contas (fila SigOpCls)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpCls") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpCls em CrSigOpCls, transcrito do OK.Click:
    *   If Not Empty(ThisForm.Usuario) Or ThisForm.Online
    *       lcSql = [...Where Onlines = 1] + Iif(Usuario informado, [And Usuars='X'], [ ])
    *   Else
    *       lcSql = [...sem filtro...]
    *   Endif
    * Sem filtro de Usuario/Online, traz a fila INTEIRA (mesmo comportamento
    * do legado) - nao e bug de migracao, e a condicao que CERCA a consulta
    * (regra #21b CLAUDE.md).
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpCls")
                USE IN CrSigOpCls
            ENDIF

            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF !EMPTY(loc_cUsuario) OR THIS.this_lOnline
                loc_cSQL = "SELECT cidchaves, grupos, contas, moedas, datas, " + ;
                           "gruconmoes, usuars, onlines, chkprc, emps " + ;
                           "FROM SigOpCls WHERE onlines = 1 "
                IF !EMPTY(loc_cUsuario)
                    loc_cSQL = loc_cSQL + "AND usuars = " + EscaparSQL(loc_cUsuario) + " "
                ENDIF
                loc_cSQL = loc_cSQL + "ORDER BY gruconmoes"
            ELSE
                loc_cSQL = "SELECT cidchaves, grupos, contas, moedas, datas, " + ;
                           "gruconmoes, usuars, onlines, chkprc, emps " + ;
                           "FROM SigOpCls ORDER BY gruconmoes"
            ENDIF

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCls") > 0)

            *-- this_nTotalFila/this_nProcessados sao o par de contadores da
            *-- PASSADA corrente (uma volta do DO WHILE do form), por isso o
            *-- contador de processados zera aqui, junto com a releitura da
            *-- fila. Quem os consome eh o relatorio de falha parcial do form,
            *-- que eh mensagem do sistema NOVO - a tela legada nao exibe
            *-- contagem nenhuma e o Label1 continua com o texto literal do
            *-- legado (PILAR 1).
            THIS.this_nProcessados = 0
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpCls")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - lock otimista do item corrente, transcrito de
    *   lcUpdate = [ Update SigOpCls Set Usuars = Usuars Where CidChaves = '..']
    *   lnErro1  = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1 )
    * no OK.Click legado. Devolve o RESULTADO NUMERICO porque o legado
    * distingue -3 (queda de conexao -> Exit do Scan) de qualquer outra falha
    * (-> Loop). PUBLIC: o form percorre o cursor da fila e chama item a item.
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmProcessamento()
        LOCAL loc_nResult, loc_cSQL, loc_oErro
        loc_nResult = 0
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpCls SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult <= 0
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" do legado
                    THIS.DesfazerTransacao()
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
            loc_nResult = 0
        ENDTRY
        RETURN loc_nResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaS para o item carregado em this_c* e
    * CONFIRMA a transacao, transcrevendo este trecho do OK.Click legado:
    *
    *   If Used('crRecalculaS') / Use In crRecalculaS / Endif
    *   llOk = fRecalculaS( Grupos, Contas, Datas, Moedas, Podatamgr )
    *   If Not llOk / Loop / Endif
    *   llOk = fRecalculaS( .t., Podatamgr, .t., .f., .f., .t. )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *
    * O legado NAO faz Rollback apos a falha da PRIMEIRA chamada (so Loop,
    * deixando o lock pendente para o Rollback incondicional do fim do Scan),
    * mas faz Rollback apos a segunda chamada e apos o Commit. Mesma
    * simplificacao adotada em SigPrRsaBO.ProcessarItem (rollback em QUALQUER
    * falha, via "IF !loc_lSucesso"): o efeito transacional no fim da
    * iteracao e IDENTICO - nada commita, tudo desfaz, item fica na fila.
    *
    * fRecalculaS ESTA portada em utils\functions.prg (ver NOTA no cabecalho
    * da classe) - a disponibilidade e medida UMA vez (classificando o erro 1
    * do VFP9) so como rede de seguranca de DEPLOY, para que functions.prg
    * inalcancavel gere UMA mensagem e aborte a passada, em vez de um MsgErro
    * modal por item (travaria o modo parametrizado).
    *
    * A 2a chamada passa gnConnHandle (numerico) onde o legado passava o
    * objeto poDataMgr, porque na nova arquitetura nao existe objeto de
    * conexao. Isso e o que os outros call sites do projeto ja fazem
    * (SigPrCccBO, SigPrMdcBO, Formsigopacc) e e o contrato da funcao portada,
    * que resolve a conexao por "IIF(TYPE(pCnx)=N AND pCnx>0, pCnx,
    * gnConnHandle)". O 6o argumento (pAut = .T.) e transcrito do legado e e
    * quem carrega a semantica de "modo automatico" na versao portada.
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !THIS.this_lRecalculoDisponivel
            RETURN .F.
        ENDIF

        TRY
            IF USED("crRecalculaS")
                USE IN crRecalculaS
            ENDIF

            *-- Primeira chamada: recalcula o saldo da conta especifica
            loc_lSucesso = fRecalculaS( ;
                THIS.this_cGrupos, ;
                THIS.this_cContas, ;
                THIS.this_dDatas, ;
                THIS.this_cMoedas, ;
                gnConnHandle )

            IF loc_lSucesso
                *-- Segunda chamada: consolida os saldos recalculados
                loc_lSucesso = fRecalculaS(.T., gnConnHandle, .T., .F., .F., .T.)
            ENDIF

            IF loc_lSucesso
                *-- "llOk = ( ThisForm.PodataMgr.Commit() > 0 )" do legado
                loc_lSucesso = THIS.ConfirmarTransacao()
            ENDIF

            IF !loc_lSucesso
                THIS.DesfazerTransacao()
            ENDIF
        CATCH TO loc_oErro
            THIS.DesfazerTransacao()
            loc_lSucesso = .F.

            *-- Classificar o erro em vez de exibi-lo: erro 1 do VFP9 ("File
            *-- 'x' does not exist.") e como uma funcao global INALCANCAVEL se
            *-- manifesta (regra #13) - nome desconhecido seguido de "(" nao e
            *-- erro de compilacao, so estoura em runtime.
            *--
            *-- fRecalculaS EXISTE em utils\functions.prg (ver NOTA no
            *-- cabecalho): este ramo nao e "funcao nao migrada", e deploy
            *-- quebrado - functions.prg fora do SET PROCEDURE ou PATH mal
            *-- formado (regra #26). A mensagem diz isso, para nao mandar quem
            *-- for diagnosticar procurar uma migracao que ja foi feita.
            IF loc_oErro.ErrorNo = 1 AND "FRECALCULAS" $ UPPER(loc_oErro.Message)
                THIS.this_lRecalculoDisponivel = .F.
                THIS.this_cMensagemErro = "A fun" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + ;
                    "lculo de saldo (fRecalculaS) n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
                    "carregada (utils" + CHR(92) + "functions.prg inalcan" + CHR(231) + CHR(225) + "vel)." + ;
                    CHR(13) + "Nenhum saldo foi recalculado e a fila foi preservada."
            ELSE
                *-- Erro REAL do recalculo (SQL, dado, conexao): registrar
                *-- para o chamador exibir UMA vez no fim da passada.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular a exclusao da fila
    * (manter o item para reprocessar depois), transcrito de:
    *
    *   lcSql = [Select CidChaves From SigMvSlc where GruConMoes = '..' ]
    *   If Sqlexecute(lcSql,'TmpSccr') < 0 Or Reccount('TmpSccr') = 0
    *       lcSql = [Select GruConMoes, sum(1) as TT From SigMvCcr
    *                Where GruConMoes = '..' Group By GruConMoes]
    *       If Sqlexecute(lcSql,'TmpMccr') < 0 Or TmpMccr.TT > 0
    *           Loop
    *       Endif
    *   Endif
    *
    * Isto e: achou saldo corrente em SigMvSlc -> pode excluir da fila (.F.);
    * nao achou -> so pode excluir se SigMvCcr nao tiver movimento pendente
    * (TT = 0); erro de consulta em qualquer um dos dois -> NAO excluir (.T.).
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult, loc_oErro
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = THIS.MontarChaveGruConMoes()

            IF USED("TmpSccr")
                USE IN TmpSccr
            ENDIF
            loc_cSQL = "SELECT cidchaves FROM SigMvSlc " + ;
                       "WHERE gruconmoes = " + EscaparSQL(loc_cChave)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpSccr")

            IF loc_nResult < 0 OR !USED("TmpSccr") OR RECCOUNT("TmpSccr") = 0
                IF USED("TmpMccr")
                    USE IN TmpMccr
                ENDIF
                loc_cSQL = "SELECT gruconmoes, SUM(1) AS TT FROM SigMvCcr " + ;
                           "WHERE gruconmoes = " + EscaparSQL(loc_cChave) + " " + ;
                           "GROUP BY gruconmoes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr")
                IF loc_nResult < 0
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpMccr") AND RECCOUNT("TmpMccr") > 0
                        SELECT TmpMccr
                        IF NVL(TT, 0) > 0
                            loc_lDeveLoop = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("TmpSccr")
                USE IN TmpSccr
            ENDIF
            IF USED("TmpMccr")
                USE IN TmpMccr
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - remove o item da fila e CONFIRMA, transcrevendo:
    *
    *   lcDelete = [ Delete From SigOpCls Where CidChaves = '..' ]
    *   llOk = ( poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *   llOk = llOk And ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *
    * Este e o Commit MAIS CRITICO do form: e ele que efetiva a saida do item
    * da fila. Sem ele, com a conexao em transacao manual, o DELETE fica
    * preso e a fila nunca drena.
    *
    * NOTA DE ESCOPO - gravacao em SigPrSlS (CrSigPrSlS): entre a checagem de
    * movimento e o DELETE, o legado faz Scatter/Zap/Append/Gather sobre o
    * cursor CrSigPrSlS, mas a linha que o persistiria
    * ("* llOk = Thisform.Podatamgr.Update('CrSigPrSlS')") esta COMENTADA no
    * fonte legado e o buffer e descartado pelo Rollback incondicional do fim
    * do Scan. NAO migrado INSERT/UPDATE em SigPrSlS - inventar aqui uma
    * gravacao que o legado nao faz violaria o PILAR 2 tanto quanto perder
    * uma que ele faz.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpCls " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- "llOk = llOk And ( PodataMgr.Commit() > 0 )" do legado
                    loc_lSucesso = THIS.ConfirmarTransacao()

                    IF loc_lSucesso
                        *-- DELETE confirmado eh o UNICO ponto em que o item
                        *-- deixa de fato a fila - contar antes do Commit
                        *-- informaria item que o rollback devolveu.
                        THIS.this_nProcessados = THIS.this_nProcessados + 1
                    ENDIF
                ELSE
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao remover item da fila de recalculo de saldos (SigOpCls)."
                    ENDIF
                ENDIF

                IF !loc_lSucesso
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" - vale
                    *-- para a falha do DELETE E para a falha do Commit.
                    THIS.DesfazerTransacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        LOCAL loc_oErro
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

ENDDEFINE

