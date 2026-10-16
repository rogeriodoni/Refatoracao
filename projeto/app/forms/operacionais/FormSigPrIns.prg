*==============================================================================
* FormSigPrIns.prg - Informacoes do Servico
* Origem: SIGPRINS.SCX (tasks\task630\SigPrIns_form_codigo_fonte.txt)
* Herda de: FormBase
* Tipo: OPERACIONAL (dialogo modal FLAT, sem PageFrame no legado) - aberto
*       pelo form pai (FormSIGPRIMP, durante a importacao de movimentacao)
*       com CREATEOBJECT("FormSigPrIns", oFormPai) para o usuario confirmar
*       o Codigo e o Valor de um Servico antes de prosseguir. O legado
*       (PROCEDURE Init, LParameters pFrm) desabilita o form pai enquanto o
*       dialogo esta aberto e devolve o resultado via ThisForm.ParentForm.
*       cCodServ/nVlServ - reproduzido em BtnConfirmarClick/BtnCancelarClick.
*==============================================================================

DEFINE CLASS FormSigPrIns AS FormBase

    this_cMensagemErro = ""
    Width        = 685
    Height       = 153
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    AlwaysOnTop  = .T.
    DataSession  = 1

    *-- Referencia ao form pai (desabilitado enquanto o dialogo esta aberto;
    *-- ok.Click/Cancela.Click do legado reabilitam e devolvem cCodServ/nVlServ)
    this_oParentForm = .NULL.

    *==========================================================================
    * Init - Recebe o form pai (LParameters pFrm no legado) e inicializa
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm

        LOCAL loc_oErro
        TRY
            THIS.Caption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"

            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm   = par_oParentForm
                par_oParentForm.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria a estrutura visual basica (cabecalho)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "Imagens\" + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrInsBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()

                *-- ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption (Init legado)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Este dialogo e FLAT (sem PageFrame/Page1-Lista/Page2-Dados no
                *-- legado - ver SECAO 1 do dump: SIGPRINS so tem cntSombra +
                *-- Label1/get_CodServ/get_DescServ/Label2/get_Valor/ok/Cancela
                *-- como filhos diretos do form). Por isso NAO ha
                *-- ConfigurarPaginaLista()/AlternarPagina() nem Grid/botoes CRUD
                *-- de lista - inventa-los violaria o PILAR 1 (layout pixel-perfect)
                *-- e a regra "NUNCA inventar". Os unicos botoes do legado sao
                *-- ok (Confirma) e Cancela, tratados aqui.
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCampos()
                THIS.ConfigurarEventos()

                *-- Aplica o contrato dos tres When do legado (ver
                *-- HabilitarCampos). Tem de rodar DEPOIS de ConfigurarCampos()
                *-- - sem os controles criados nao ha o que habilitar.
                THIS.HabilitarCampos(.T.)

                THIS.CarregarDadosDoChamador()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o Business Object SigPrInsBO"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Inicializar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria o container cnt_4c_Sombra (faixa cinza do
    * topo, cntSombra no legado) com os labels lbl_4c_LblSombra/lbl_4c_LblTitulo.
    *
    * NOTA PARA FASES FUTURAS: este container tem de ser o PRIMEIRO AddObject
    * do form (regra #11 do CLAUDE.md) - os botoes cmd_4c_Ok/cmd_4c_Cancela
    * (Top=3, dentro da faixa de 80px) e os campos txt_4c__CodServ/
    * txt_4c__DescServ/txt_4c__Valor (Fases 5-6) devem ser adicionados DEPOIS,
    * para desenhar por cima da faixa.
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
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = ""
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Cria cmd_4c_Ok ("\<Confirma", ok.Click no legado)
    * e cmd_4c_Cancela ("Cancela", Cancela.Click no legado). Os dois sao
    * filhos DIRETOS do form (nao de um container de botoes) e ficam com
    * Top=3, dentro da faixa cinza de 80px de cnt_4c_Sombra - por isso sao
    * adicionados DEPOIS de ConfigurarCabecalho(), para desenhar por cima
    * da faixa (regra #11 do CLAUDE.md).
    *
    * Aqui fica so a estrutura visual dos botoes; os Click sao ligados em
    * ConfigurarEventos() (ok -> valida get_Valor > 0 e devolve Codigo/Valor
    * ao form pai; Cancela -> zera Codigo/Valor no form pai).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 534
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Confirma"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 609
            .Width           = 75
            .Height          = 75
            .Caption         = "Cancela"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Cria os campos de dados do dialogo (Label1/get_CodServ/
    * get_DescServ/Label2/get_Valor no legado). Filhos DIRETOS do form, criados
    * DEPOIS de ConfigurarCabecalho()/ConfigurarBotoesAcao() (regra #11 do
    * CLAUDE.md) - ficam em Top >= 92, abaixo da faixa de 80px de cnt_4c_Sombra,
    * entao a ordem de criacao aqui nao afeta z-order.
    *
    * FASE 5: Label1 + txt_4c__CodServ + txt_4c__DescServ (grupo "Servico :").
    * txt_4c__CodServ/txt_4c__DescServ ficam ReadOnly = .T. - no legado
    * get_CodServ.When e get_DescServ.When sempre retornam .F. (Problema 6 do
    * dump: SIGPRINS.get_CodServ/get_DescServ), ou seja os dois campos NUNCA
    * recebem foco por digitacao direta; sao populados pelo Init a partir do
    * form pai (LocalSacOp.cCodServs) e da consulta a SigCdPro
    * (CarregarDescricaoServico - Fase 7/8).
    *
    * FASE 6: Label2 + txt_4c__Valor (grupo "Valor :"). get_Valor.When
    * retorna .T. no legado - unico campo realmente editavel do dialogo.
    * Nao ha lookup (F4/F5) em nenhum campo deste form - o dump
    * (comportamento.json) nao registra fwbuscaext/fwBuscaSel/sigacess em
    * nenhum metodo, e o unico uso de CursorQuery e a consulta de descricao
    * do servico (CarregarDescricaoServico), que nao eh picker de usuario.
    * Inventar um lookup aqui violaria a regra "NUNCA inventar lookup que
    * nao existe no original".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 95
            .Left      = 40
            .Width     = 49
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Servi" + CHR(231) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- get_CodServ (SigCdPro.cPros char(14)) - ReadOnly, preenchido pelo
        *-- form pai (ver comentario do metodo acima)
        THIS.AddObject("txt_4c__CodServ", "TextBox")
        WITH THIS.txt_4c__CodServ
            .Top       = 92
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Arial"
            .FontSize  = 9
            .Value     = ""
            .MaxLength = 14
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- get_DescServ (SigCdPro.dPros char(65)) - ReadOnly, preenchido pela
        *-- consulta a SigCdPro (CarregarDescricaoServico / BOParaForm)
        *-- MaxLength = 65 vem da LARGURA DA COLUNA no schema (regra #19 do
        *-- CLAUDE.md), nao do .Width em pixels: medido em docs\schema.sql
        *-- (UTF-16, lido com Get-Content -Raw) SigCdPro.dpros e char(65).
        *-- O dump legado declara MaxLength = 0 (sem limite) e o campo e
        *-- ReadOnly, entao 65 nao restringe nada que o legado permitisse -
        *-- apenas impede que a descricao seja cortada na exibicao.
        THIS.AddObject("txt_4c__DescServ", "TextBox")
        WITH THIS.txt_4c__DescServ
            .Top       = 92
            .Left      = 177
            .Width     = 290
            .Height    = 23
            .FontName  = "Arial"
            .FontSize  = 9
            .Value     = ""
            .MaxLength = 65
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 122
            .Left      = 52
            .Width     = 37
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor :"
            .Visible   = .T.
        ENDWITH

        *-- get_Valor (LocalSacOp.nVlServs) - unico campo editavel do dialogo
        *-- (get_Valor.When retorna .T. no legado). InputMask/MaxLength
        *-- transcritos literalmente do dump (regra CLAUDE.md #49).
        THIS.AddObject("txt_4c__Valor", "TextBox")
        WITH THIS.txt_4c__Valor
            .Top        = 119
            .Left       = 96
            .Width      = 100
            .Height     = 23
            .FontName   = "Arial"
            .FontSize   = 9
            .Value      = 0
            .InputMask  = "9,999,999.99"
            .MaxLength  = 12
            .ReadOnly   = .F.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - Liga os eventos dos controles aos handlers do form
    *
    * NAO HA LOOKUP NESTE DIALOGO. O dump legado nao registra fwBuscaExt /
    * fwBuscaSel / fwBuscaInt / sigacess / mAddColuna / FormBuscaAuxiliar em
    * metodo nenhum: a SECAO 3 de SigPrIns_form_codigo_fonte.txt tem apenas
    * SIGPRINS.Init, SIGPRINS.Load, os tres When (get_CodServ -> .F.,
    * get_DescServ -> .F., get_Valor -> .T.) e os dois Click (ok e Cancela).
    * O unico acesso a tabela eh a consulta da descricao do servico em
    * SigCdPro (CursorQuery no Init -> CarregarDescricaoServico no BO), que
    * NAO eh picker de usuario. Por isso nao existe aqui BINDEVENT de
    * KeyPress/DblClick com F4/F5 nem metodo AbrirLookup*/AbrirBusca* -
    * inventar um violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
    * lookup que nao existem no original".
    *
    * Os eventos que o legado DE FATO tem sao os Click dos dois botoes.
    * Handlers PUBLIC de proposito: BINDEVENT ignora metodo PROTECTED
    * (regra #3 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmd_4c_Ok,      "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * CarregarDadosDoChamador - Reproduz o bloco final do Init legado: le o
    * cursor global LocalSacOp (populado por quem abre este dialogo - mesma
    * convencao Fortyus de CREATEOBJECT("FormSigPrIns", par_oParentForm)
    * logo apos popular LocalSacOp, ja que nenhum form migrado ate aqui
    * referencia SigPrIns/LocalSacOp - o chamador real fica para a task que
    * migrar esse form), consulta a descricao do servico via
    * BO.CarregarDescricaoServico() (fase 1/2) e preenche os tres campos.
    *
    * Legado (PROCEDURE Init, apos ThisForm.ParentForm = pFrm):
    *     ThisForm.get_CodServ.Value = LocalSacOp.cCodServs
    *     ThisForm.ParentForm.poDataMgr.CursorQuery('SigCdPro','LocalPro',
    *         'cPros', LocalSacOp.cCodServs, 'dPros')
    *     ThisForm.get_DescServ.Value = LocalPro.dPros
    *     ThisForm.get_Valor.Value = LocalSacOp.nVlServs
    *     ThisForm.get_Valor.SetFocus
    *
    * gb_4c_ValidandoUI pula a consulta SQL (padrao FormCor) - sem conexao
    * nao ha o que buscar, e o form so precisa abrir para a validacao visual.
    * Sem LocalSacOp populado (form instanciado fora do fluxo real), os
    * campos ficam nos defaults de ConfigurarCampos() - nao ha erro.
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosDoChamador()
        LOCAL loc_cCodigo, loc_nValor

        *-- Sem LocalSacOp populado (validacao de UI, ou form instanciado fora
        *-- do fluxo real) o dialogo abre com estado DETERMINISTICO em vez do
        *-- que o AddObject deixou - LimparCampos zera os tres campos e as
        *-- tres properties do BO de uma vez.
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.LimparCampos()
            RETURN
        ENDIF

        IF !USED("LocalSacOp") OR EOF("LocalSacOp")
            THIS.LimparCampos()
            RETURN
        ENDIF

        SELECT LocalSacOp
        loc_cCodigo = TratarNulo(cCodServs, "")
        loc_nValor  = ConverterParaNumero(TratarNulo(nVlServs, 0))

        *-- CarregarDescricaoServico() ja grava this_cCodServ/this_cDescServ no
        *-- BO (reproduz o CursorQuery('SigCdPro','LocalPro','cPros',...,'dPros')
        *-- do Init legado). Codigo e descricao chegam aos TextBox por
        *-- BOParaForm - e por isso que o codigo e atribuido ao BO ANTES, e nao
        *-- direto no TextBox: assim ha UMA fonte do valor exibido.
        IF !THIS.this_oBusinessObject.CarregarDescricaoServico(loc_cCodigo)
            *-- Consulta falhou (sem conexao/erro SQL): o legado tambem nao
            *-- trata "nao encontrado" de forma especial - segue com o codigo
            *-- que veio do chamador e a descricao vazia, para o usuario poder
            *-- confirmar o valor assim mesmo.
            THIS.this_oBusinessObject.this_cCodServ  = loc_cCodigo
            THIS.this_oBusinessObject.this_cDescServ = ""
        ENDIF

        THIS.this_oBusinessObject.this_nValor = loc_nValor

        THIS.BOParaForm()

        *-- ThisForm.get_Valor.SetFocus (ultima linha do Init legado)
        THIS.txt_4c__Valor.SetFocus()
    ENDPROC

    *==========================================================================
    * ValidarValorServico - Valida o valor informado (PUBLIC: chamado pelo
    * handler ligado por BINDEVENT)
    *
    * Transcricao LITERAL do guard que abre SIGPRINS.ok.Click no legado:
    *     If( ThisForm.get_Valor.Value <= 0 ) Then
    *         MessageBox('O valor do servico deve ser informado!',16,'')
    *         ThisForm.get_Valor.SetFocus
    *         Return(.F.)
    *     EndIf
    *
    * A validacao roda SO ao confirmar, que eh exatamente o que o legado faz -
    * NAO em LostFocus/KeyPress do campo, porque get_Valor nao tem Valid no
    * legado (so When -> .T.). Ligar isto a LostFocus faria o aviso saltar a
    * cada saida do campo, comportamento que o legado nao tem.
    *
    * MsgAviso no lugar do MessageBox icone 16: "campo obrigatorio" eh
    * validacao de UI, e a regra do projeto reserva MsgErro/MostrarErro para
    * excecao tecnica.
    *==========================================================================
    PROCEDURE ValidarValorServico()
        LOCAL loc_nValor, loc_lValido

        loc_lValido = .F.

        *-- ConverterParaNumero (utils\functions.prg) devolve o proprio valor
        *-- quando ja eh Numerico e converte quando o TextBox devolve
        *-- Caractere - evita "Operator/operand type mismatch" na comparacao.
        loc_nValor = ConverterParaNumero(THIS.txt_4c__Valor.Value)

        IF loc_nValor <= 0
            MsgAviso("O valor do servi" + CHR(231) + "o deve ser informado!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c__Valor.SetFocus()
        ELSE
            loc_lValido = .T.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * DevolverResultadoAoPai - Escreve Codigo/Valor no form pai e o reabilita
    *
    * Legado (ok.Click e Cancela.Click, mesmas tres linhas com valores
    * diferentes):
    *     ThisForm.ParentForm.cCodServ = <codigo>
    *     ThisForm.ParentForm.nVlServ  = <valor>
    *     ThisForm.ParentForm.Enabled  = .T.
    *
    * O form pai legado (SIGPRIMP) declara cCodServ/nVlServ; o migrado
    * (FormSIGPRIMP) ainda nao - por isso a escrita eh guardada por PEMSTATUS
    * e a property eh criada com AddProperty quando faltar. Sem o guard,
    * atribuir property inexistente num Form estoura "Property CCODSERV is
    * not found" e o dialogo nao devolve nada (regra #33 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE DevolverResultadoAoPai(par_cCodServ, par_nVlServ)
        LOCAL loc_oPai

        IF VARTYPE(THIS.this_oParentForm) = "O"
            loc_oPai = THIS.this_oParentForm

            IF !PEMSTATUS(loc_oPai, "cCodServ", 5) AND PEMSTATUS(loc_oPai, "AddProperty", 5)
                loc_oPai.AddProperty("cCodServ", "")
            ENDIF
            IF !PEMSTATUS(loc_oPai, "nVlServ", 5) AND PEMSTATUS(loc_oPai, "AddProperty", 5)
                loc_oPai.AddProperty("nVlServ", 0)
            ENDIF

            IF PEMSTATUS(loc_oPai, "cCodServ", 5)
                loc_oPai.cCodServ = par_cCodServ
            ENDIF
            IF PEMSTATUS(loc_oPai, "nVlServ", 5)
                loc_oPai.nVlServ = par_nVlServ
            ENDIF

            loc_oPai.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - SIGPRINS.ok.Click do legado (PUBLIC: BINDEVENT)
    *
    * Valida o valor; so devolve Codigo/Valor ao pai e fecha quando passa -
    * o Return(.F.) do legado existe justamente para NAO transferir nem
    * fechar. Como BINDEVENT descarta o retorno do delegate, o early-exit eh
    * feito por flag (regra #1 do CLAUDE.md: nunca RETURN dentro de
    * TRY/CATCH), e o Release fica FORA do TRY.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro, loc_lConfirmado

        loc_lConfirmado = .F.

        TRY
            *-- FormParaBO primeiro: o que o usuario digitou vira property do
            *-- BO, e e DE LA que sai o par Codigo/Valor devolvido ao pai.
            *-- ValidarValorServico continua lendo o TextBox, como o legado
            *-- (If ThisForm.get_Valor.Value <= 0) - e o MESMO valor que
            *-- FormParaBO acabou de copiar, e assim o validador segue
            *-- funcionando se for chamado isolado.
            IF THIS.FormParaBO() AND THIS.ValidarValorServico()
                THIS.DevolverResultadoAoPai(THIS.this_oBusinessObject.this_cCodServ, ;
                                            THIS.this_oBusinessObject.this_nValor)
                loc_lConfirmado = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lConfirmado = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Confirmar")
        ENDTRY

        IF loc_lConfirmado
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - SIGPRINS.Cancela.Click do legado (PUBLIC: BINDEVENT)
    *
    * Zera Codigo/Valor no pai, reabilita e fecha. O legado fecha SEM nenhuma
    * validacao, e fecha sempre - por isso o Release eh incondicional (fora do
    * TRY, regra #1 do CLAUDE.md).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.DevolverResultadoAoPai("", 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Cancelar")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere os campos da tela para as properties do BO
    *
    * Hook PROTECTED de FormBase (FormBase.prg:285). Mantido PROTECTED: a
    * classe base o declara assim e, em VFP9, PROTECTED na base PREVALECE
    * sobre o override sem modificador na subclasse (regra #51 do CLAUDE.md) -
    * tirar o modificador aqui nao alargaria o escopo, so daria a impressao
    * de que da para chamar de fora. Os unicos chamadores sao internos
    * (BtnConfirmarClick).
    *
    * Mapeamento (3 campos do SCX <-> 3 properties de SigPrInsBO):
    *     txt_4c__CodServ  (get_CodServ)  -> this_cCodServ   SigCdPro.cPros char(14)
    *     txt_4c__DescServ (get_DescServ) -> this_cDescServ  SigCdPro.dPros char(65)
    *     txt_4c__Valor    (get_Valor)    -> this_nValor     LocalSacOp.nVlServs
    *
    * O codigo vai SEM ALLTRIM, de proposito: o legado repassa o valor CRU
    * (ThisForm.ParentForm.cCodServ = ThisForm.get_CodServ.Value), o campo
    * nasce de LocalSacOp.cCodServs e cPros e char(14) de largura fixa -
    * aparar o padding mudaria a chave que o form pai recebe (regra #42).
    *
    * O valor passa por ConverterParaNumero porque o TextBox devolve ora
    * Numerico ora Caractere conforme o caminho (digitacao com InputMask x
    * atribuicao por codigo); comparar/atribuir sem normalizar estoura
    * "Operator/operand type mismatch".
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCodServ  = THIS.txt_4c__CodServ.Value
                THIS.this_oBusinessObject.this_cDescServ = THIS.txt_4c__DescServ.Value
                THIS.this_oBusinessObject.this_nValor    = ConverterParaNumero(THIS.txt_4c__Valor.Value)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - Transfere as properties do BO para os campos da tela
    *
    * Caminho inverso de FormParaBO, com o mesmo mapeamento de 3 campos.
    * Chamado por CarregarDadosDoChamador(), depois de
    * BO.CarregarDescricaoServico() ter resolvido a descricao em SigCdPro -
    * reproduz as tres atribuicoes do Init legado:
    *     ThisForm.get_CodServ.Value  = LocalSacOp.cCodServs
    *     ThisForm.get_DescServ.Value = LocalPro.dPros
    *     ThisForm.get_Valor.Value    = LocalSacOp.nVlServs
    *
    * TratarNulo em todos os tres: this_cDescServ sai de uma coluna do SQL
    * Server e pode chegar .NULL. (o 2o argumento de TratarNulo e o VALOR
    * PADRAO, nao o tipo). Atribuir .NULL. a .Value exibiria ".NULL." na tela.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c__CodServ.Value  = TratarNulo(THIS.this_oBusinessObject.this_cCodServ, "")
                THIS.txt_4c__DescServ.Value = TratarNulo(THIS.this_oBusinessObject.this_cDescServ, "")
                THIS.txt_4c__Valor.Value    = ConverterParaNumero(TratarNulo(THIS.this_oBusinessObject.this_nValor, 0))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera os tres campos da tela e as tres properties do BO
    *
    * Override do hook PROTECTED de FormBase (FormBase.prg:276, chamado por
    * FormBase.Novo()). Aqui serve ao caminho em que o dialogo abre SEM o
    * cursor LocalSacOp populado (validacao de UI, ou instanciacao fora do
    * fluxo real): sem ele os campos ficariam no que o AddObject deixou, e o
    * estado inicial da tela dependeria da ordem de criacao dos controles.
    *
    * Limpa os DOIS lados (tela e BO) porque sao as duas metades do mesmo
    * estado - zerar so a tela deixaria o BO com o servico anterior e o
    * proximo FormParaBO/DevolverResultadoAoPai poderia devolver ao pai um
    * codigo que nao esta mais em lugar nenhum da tela.
    *
    * Cada campo recebe o literal do SEU tipo (Caractere "" / Numerico 0),
    * igual ao que ConfigurarCampos() atribuiu no AddObject: trocar o tipo
    * de .Value em runtime quebraria a comparacao seguinte.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c__CodServ.Value  = ""
            THIS.txt_4c__DescServ.Value = ""
            THIS.txt_4c__Valor.Value    = 0

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCodServ  = ""
                THIS.this_oBusinessObject.this_cDescServ = ""
                THIS.this_oBusinessObject.this_nValor    = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Aplica o contrato dos tres When do legado
    *
    * O SCX nao tem modo de edicao (nao ha frmcadastro, nem pcEscolha, nem
    * Page1/Page2): quem decide o que e editavel sao os tres When, e eles sao
    * CONSTANTES - nao dependem de modo nenhum.
    *     SIGPRINS.get_CodServ.When  -> Return(.F.)   nunca recebe foco
    *     SIGPRINS.get_DescServ.When -> Return(.F.)   nunca recebe foco
    *     SIGPRINS.get_Valor.When    -> Return(.T.)   unico campo editavel
    *
    * Por isso Codigo e Descricao ficam ReadOnly INCONDICIONALMENTE - eles
    * sao preenchidos pelo chamador (LocalSacOp) e pela consulta a SigCdPro,
    * e o usuario nunca digita neles. Somente o Valor acompanha
    * par_lHabilitar, que e o unico grau de liberdade que o legado tem.
    *
    * NAO mexe em .Enabled dos botoes: o legado nunca desabilita ok/Cancela,
    * e inventar isso violaria o PILAR 1. Chamado com .T. por
    * InicializarForm() - estado unico do dialogo no legado.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oErro

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            *-- get_CodServ.When / get_DescServ.When = .F. (sempre)
            THIS.txt_4c__CodServ.ReadOnly  = .T.
            THIS.txt_4c__DescServ.ReadOnly = .T.

            *-- get_Valor.When = .T. (unico campo que o usuario digita)
            THIS.txt_4c__Valor.ReadOnly = !loc_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FINAL - metodos da convencao CRUD que este form NAO tem
    *
    * O checklist da Fase 8 pede CarregarLista(), AjustarBotoesPorModo(),
    * AlternarPagina(), BtnIncluirClick/BtnAlterarClick/BtnExcluirClick/
    * BtnBuscarClick/BtnSalvarClick/BtnEncerrarClick. NENHUM deles existe
    * aqui, e a ausencia e deliberada - inventa-los violaria o PILAR 1 e a
    * regra "NUNCA inventar", e cria-los vazios violaria a regra de
    * completude. Prova, dump a dump (SigPrIns_form_codigo_fonte.txt):
    *
    *   CarregarLista / grade: a SECAO 1 lista os 12 objetos do SCX -
    *     Dataenvironment, SIGPRINS, cntSombra, lblSombra, lblTitulo,
    *     Label1, get_CodServ, get_DescServ, Label2, get_Valor, ok, Cancela.
    *     NAO ha BaseClass grid nem pageframe, nao ha AddCursor/pColuna/
    *     RecordSource/ControlSource e comportamento.json fecha com
    *     "totalQueries": 0. Nao existe LISTA para carregar: o dialogo abre
    *     ja sabendo de QUAL servico se trata (o codigo vem do form pai em
    *     LocalSacOp.cCodServs) - nao ha escolha de registro a fazer.
    *
    *   AjustarBotoesPorModo / AlternarPagina: nao ha PageFrame (tela FLAT,
    *     685x153) nem modo - o SCX nao tem frmcadastro, Grupo_Op nem
    *     pcEscolha. Os dois botoes do legado estao sempre no mesmo estado.
    *
    *   BtnIncluir/Alterar/Excluir/BuscarClick: a SECAO 3 tem exatamente 7
    *     metodos com codigo - Init e Load do form, os tres When e os dois
    *     Click (ok e Cancela). Nao ha barra CRUD nem busca.
    *
    *   BtnSalvarClick / BtnEncerrarClick: os dois botoes que existem ja
    *     estao implementados com o nome da acao que o legado lhes da -
    *     BtnConfirmarClick (ok, "\<Confirma") e BtnCancelarClick (Cancela).
    *     Nenhum dos dois grava em tabela: ok.Click copia Codigo/Valor para
    *     ThisForm.ParentForm.cCodServ/nVlServ e fecha; Cancela.Click zera
    *     os dois no pai e fecha. Por isso o BO tambem nao sobrescreve
    *     Inserir/Atualizar/ExecutarExclusao.
    *
    * SIGPRINS.Load (=fConfigGeral() + =DoDefault()) TAMBEM nao foi portado,
    * e de proposito: fconfiggeral.prg existe em utils\ apenas como wrapper
    * no-op para o p-code dos VCX legado, e o proprio cabecalho dele diz
    * "em codigo NOSSO nunca se chama fConfigGeral" - o que a funcao fazia
    * no legado (configuracao global) ja acontece em config.prg/main.prg
    * antes deste form existir. Chama-la aqui so mascararia a ausencia.
    *==========================================================================

    *==========================================================================
    * Destroy - Re-habilita o form pai e libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
