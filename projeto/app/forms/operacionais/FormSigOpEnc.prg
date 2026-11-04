*==============================================================================
* FormSigOpEnc.prg - Encerramento de Contas
* Origem: SIGOPENC.SCX (task730)
* Herda de: FormBase
* Tipo: OPERACIONAL (flat layout - sem PageFrame/paginas; Container1 do legado
*       concentra o filtro + contra-partida e a grade de saldos fica solta
*       no form, dentro de uma moldura Shape)
*
* FASE 5/8 - Campos principais: bloco "Filtro" do Container1 legado
* (Label1 / lbl_grupo / Get_Grupo / Get_DGrupo / Say1 / Get_Conta /
* get_Dconta), com a dependencia entre eles (os "Procedure When" do legado)
* e o funil que repassa o filtro ao BO e recarrega a grade (as chamadas a
* ThisForm.MontaTela() dos Valid).
*
* FASE 6/8 - Campos restantes e lookups: bloco "Contra-Partida" (Label4 /
* Say4 / Get_GrupoC / Get_DgrupoC / Say5 / Get_contaC / Get_DcontaC) e bloco
* "Operacao" (Shape1 / Label2 / Get_Dope, lido de SigCdPac.DopZers no Init).
*
* A resolucao codigo <-> descricao NAO chama fAcessoContab/fAcessoContas
* direto: essas funcoes (utils\functions.prg) reexibem o picker legado
* (FormBuscaSimples) e, apos ele fechar, leem o REGISTRO CORRENTE do cursor
* de apoio para preencher o TextBox - sem distinguir "usuario selecionou" de
* "usuario cancelou", o mesmo defeito que a memoria do projeto documenta para
* fAcessoContas em lookup de UI (auto-preenche com o 1o registro). Em troca,
* THIS.ResolverCodigoDescricao() usa o padrao canonico do projeto: busca
* EXATA pelo valor digitado e, so se ela falhar, abre o picker por
* THIS.AbrirLookupCanonico() (herdado de FormBase), que so atribui o valor
* quando this_lSelecionou confirma a escolha do usuario.
*
* FASE 7/8 - Este form NAO tem CRUD (o legado nao declara Incluir/Alterar/
* Visualizar/Excluir - comportamento.json nao lista nenhum desses verbos; os
* unicos botoes sao SelTudo/Apaga/Processar/Encerrar, ja cobertos nas fases
* anteriores). O trabalho real desta fase e completar BtnProcessarClick com
* os 4 guards do cmdProcessa.Click legado e com a geracao dos lancamentos de
* encerramento em si (THIS.this_oBusinessObject.ProcessarEncerramento()),
* deixada so ESBOCADA na Fase 6 e implementada por completo aqui.
*
* FASE 8/8 - CONSOLIDACAO FINAL: os nomes genericos de form CRUD que um
* checklist padrao cobraria (BtnBuscarClick, BtnSalvarClick, BtnCancelarClick,
* FormParaBO/BOParaForm, Habilitar/LimparCampos, CarregarLista,
* AjustarBotoesPorModo) NAO se aplicam aqui, pela mesma razao da Fase 7: o
* legado SIGOPENC nao tem Page1=Lista/Page2=Dados, nao tem registro unico em
* edicao e nao grava por Inserir/Atualizar/Excluir - e um dialogo de
* PROCESSAMENTO EM LOTE (marca contas na grade de saldos e gera, de uma vez,
* os lancamentos de encerramento de todas as marcadas). Os equivalentes reais
* ja existem sob os nomes do dominio do form:
*   CarregarLista()        -> CarregarDados() (recarrega grd_4c_Dados)
*   LimparCampos()         -> LimparFiltro() (zera os 8 campos do Container1)
*   BtnSalvarClick()       -> BtnProcessarClick() (acao principal, com os 4
*                             guards do legado e ProcessarEncerramento())
*   BtnCancelarClick()     -> nao existe no legado (nao ha edicao para
*                             cancelar; LimparFiltro() e o "reset" ja usado
*                             dentro do proprio BtnProcessarClick ao concluir)
*   BtnBuscarClick()       -> nao existe no legado (a consulta de saldos e
*                             automatica via AplicarFiltro(), nos LostFocus
*                             dos campos de Grupo/Conta - nao ha botao
*                             "Buscar" no dump)
*   HabilitarCampos()/
*   AjustarBotoesPorModo() -> nao existem no legado (nao ha modo
*                             INCLUIR/ALTERAR/VISUALIZAR; os campos do filtro
*                             ficam sempre editaveis, e o unico Enabled
*                             condicional e cmd_4c_CmdProcessa, ja tratado em
*                             CarregarDados())
*
* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
* decisao ja documentada em FormSIGPRMEI.prg/FormSigMvExp.prg/
* FormSigOpCcl.prg: fConfigGeral era funcao GLOBAL do legado (sig.prg/
* SIGFUNCS.PRG) que nao veio no acervo; o wrapper NO-OP em
* projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
* continuar resolvendo o nome, e em codigo NOSSO nunca se chama fConfigGeral.
*
* "Procedure fazcontra" do legado (gera a entrada espelhada/contra-partida a
* partir do registro CORRENTE de CrSigMvCcr) nao virou metodo separado: esta
* dobrada dentro do SCAN de THIS.this_oBusinessObject.ProcessarEncerramento(),
* no bloco "Entrada CONTRA-PARTIDA", que troca Grupos/Contas/Opers pelos
* campos S* na mesma iteracao em que a entrada direta e montada - evita
* depender de releitura de "registro corrente" (que nesta arquitetura nao
* existe um cursor crSigMvCcr com Append Blank, e sim um INSERT INTO
* SigMvCcr por SQLEXEC).
*==============================================================================

DEFINE CLASS FormSigOpEnc AS FormBase

    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Encerramento de Contas"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Guarda de reentrancia dos lookups (regra CLAUDE.md #37/#47): o picker
    *-- FormBuscaAuxiliar e MODAL e e aberto de DENTRO de um LostFocus; ao
    *-- tomar o foco ele faz o proprio LostFocus do campo disparar de novo, o
    *-- que empilharia um segundo dialogo sobre o primeiro. Ligada no FUNIL
    *-- (AbrirLookup<X>) e liberada DEPOIS que ele retorna.
    this_lEmLookup = .F.

    *-- Guarda de "valor nao mudou" dos LostFocus de lookup (regra CLAUDE.md
    *-- #47/Problema 45): no legado o Valid so dispara quando o Value MUDA;
    *-- LostFocus dispara SEMPRE, inclusive em Tab de passagem sem digitar
    *-- nada. Cada propriedade guarda o ultimo valor ja validado do campo
    *-- correspondente - atualizada so DEPOIS da validacao rodar.
    this_cUltimoGrupoLostFocusValidado   = ""
    this_cUltimoDGrupoLostFocusValidado  = ""
    this_cUltimoContaLostFocusValidado   = ""
    this_cUltimoDContaLostFocusValidado  = ""
    this_cUltimoGrupoCLostFocusValidado  = ""
    this_cUltimoDGrupoCLostFocusValidado = ""
    this_cUltimoContaCLostFocusValidado  = ""
    this_cUltimoDContaCLostFocusValidado = ""

    *==========================================================================
    * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura visual base
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEncBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigOpEncBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnc.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- SigCdPac.DopZers precisa estar lido ANTES de
                *-- ConfigurarContainerFiltro(), que copia o valor para
                *-- txt_4c_Dope.Value dentro de ConfigurarCamposOperacao()
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContainerFiltro()
                THIS.ConfigurarAreaSaldo()
                THIS.ConfigurarBotoesAcao()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga inicial da grade. Com o filtro de Grupo vazio o
                *-- sentinela ZYWZYWZYWZ do legado nao casa nada e a grade
                *-- abre VAZIA, de proposito (regra #35a).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
    * titulo do form duplicado (sombra preta + texto branco por cima)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerFiltro - Moldura "Filtro / Contra-Partida" (Container1
    * do legado) e, dentro dela, os tres blocos de campos: Filtro,
    * Contra-Partida e Operacao (com o Shape1 que destaca a Operacao).
    *
    * AjustarTabIndexContainer1() roda por ULTIMO, so depois que os 16
    * controles com TabIndex no dump (labels inclusive) ja existem no
    * container - setar o TabIndex de um rotulo (9, 10, 11, 13..16) ANTES
    * disso reduziria o valor ao ControlCount corrente (regra do VFP9 que
    * limita TabIndex ao numero de controles ja existentes).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerFiltro()
        THIS.AddObject("cnt_4c_Filtro", "Container")
        WITH THIS.cnt_4c_Filtro
            .Top         = 106
            .Left        = 60
            .Width       = 679
            .Height      = 132
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarCamposFiltro()
        THIS.ConfigurarCamposContraPartida()
        THIS.ConfigurarCamposOperacao()
        THIS.AjustarTabIndexContainer1()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposFiltro - Bloco "Filtro" do Container1 legado, transcrito
    * objeto a objeto do dump (Top/Left/Width/Height/Font/ForeColor/Format/
    * MaxLength). Os Top/Left ficam IGUAIS aos do dump porque sao relativos ao
    * Container, que ja esta posicionado em 106,60 - nao ha PageFrame com
    * Top = -29 neste form (layout FLAT), logo nao ha compensacao a aplicar.
    *
    * Mapa legado -> migrado:
    *   Label1     "Filtro"  -> lbl_4c_Filtro
    *   lbl_grupo  "Grupo :" -> lbl_4c_Grupo
    *   Get_Grupo            -> txt_4c_Grupo    (SigCdGcr.codigos char(10))
    *   Get_DGrupo           -> txt_4c_DGrupo   (SigCdGcr.descrs  char(40))
    *   Say1       "Conta :" -> lbl_4c_Conta
    *   Get_Conta            -> txt_4c_Conta    (SigCdCli.iclis   char(10))
    *   get_Dconta           -> txt_4c_DConta   (SigCdCli.rclis   char(50))
    *
    * ForeColor dos rotulos: Label1 declara 255,0,0 EXPLICITO no dump (titulo
    * de secao em Verdana 10 bold, igual ao Label4/Label2 do mesmo container);
    * lbl_grupo e Say1 declaram 90,90,90, que tambem e o canonico da classe
    * say sobre a textura clara do form (regra CLAUDE.md #12). Nenhum deles
    * leva branco.
    *
    * AutoSize: lbl_grupo declara AutoSize = .T. no dump, mas AutoSize e
    * NO-OP em Label criado por AddObject (regra CLAUDE.md #23) - por isso
    * .AutoSize = .F. com Width/Height transcritos do dump, que JA SAO o
    * auto-size calculado pelo Form Designer. Alignment NAO e declarado em
    * rotulo nenhum deste bloco: fica 0 (esquerda), como a classe say.
    *
    * Alignment dos TextBox: o dump NAO declara Alignment em nenhum dos quatro
    * getters, entao a propriedade NAO e tocada - TextBox criado por AddObject
    * nasce com Alignment = 3, e inventar 0 aqui seria divergencia visual.
    *
    * Format/MaxLength (regras CLAUDE.md #49 e #19):
    *   Get_Grupo   Format = "!"  (maiuscula)      MaxLength = 10
    *   Get_DGrupo  Format = ""   -> override VAZIO do Form Designer, NAO se
    *                               transcreve                MaxLength = 20
    *   Get_Conta   classe fwget -> Format = "K" por heranca  MaxLength = 10
    *   get_Dconta  classe fwget -> Format = "K" por heranca  MaxLength = 50
    * MaxLength vem da largura da COLUNA no schema, nunca do Width em pixels:
    * SigCdGcr.codigos/SigCdCli.iclis sao char(10) e SigCdCli.rclis e char(50)
    * (os dois ultimos conferem com o MaxLength = 50 declarado no dump).
    * Get_DGrupo mantem o 20 do dump: e o limite de digitacao que o legado
    * impoe na busca por descricao, nao a largura de SigCdGcr.descrs.
    *
    * Propriedades herdadas da classe fwget (framework.vcx) que o TextBox base
    * do VFP9 nao traz, transcritas nos dois getters de classe fwget:
    * Height = 23, Themes = .F., DisabledBackColor = 192,192,192,
    * DisabledForeColor = 0,0,0. Get_Conta nao declara Height no dump porque
    * herda esse 23 - os irmaos fwget do mesmo container o declaram.
    *
    * TabIndex: so os quatro getters o recebem aqui (1..4, exatamente os do
    * dump). Os rotulos deste bloco tambem declaram TabIndex no dump (9, 10 e
    * 15), mas Label nao e ponto de parada do Tab e o VFP9 LIMITA o TabIndex
    * ao numero de controles ja existentes no container: gravar 15 num
    * container com 7 controles o reduziria a 7 e renumeraria os getters,
    * trocando a ordem de navegacao. Os TabIndex dos rotulos e dos demais
    * getters (5..8 e 12) sao aplicados por AjustarTabIndexContainer1(), no
    * final de ConfigurarContainerFiltro(), quando os 16 controles do dump
    * (Contra-Partida e Operacao inclusive) ja existem no container.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        *-- Label1 "Filtro" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_Filtro", "Label")
        WITH loc_oCnt.lbl_4c_Filtro
            .Top       = 2
            .Left      = 3
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Filtro"
            .Visible   = .T.
        ENDWITH

        *-- lbl_grupo "Grupo :"
        loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oCnt.lbl_4c_Grupo
            .Top       = 7
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo - codigo do Grupo de Contas do filtro (SigCdGcr.codigos)
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top       = 3
            .Left      = 123
            .Width     = 80
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "!"
            .MaxLength = 10
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 1
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_DGrupo - descricao do Grupo do filtro (SigCdGcr.descrs)
        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Top       = 3
            .Left      = 204
            .Width     = 290
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 2
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say1 "Conta :"
        loc_oCnt.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oCnt.lbl_4c_Conta
            .Top       = 32
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH

        *-- Get_Conta - codigo da Conta do filtro (SigCdCli.iclis)
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top               = 29
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 3
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- get_Dconta - descricao da Conta do filtro (SigCdCli.rclis)
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Top               = 29
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .MaxLength         = 50
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 4
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- DEPENDENCIA entre os campos (os "Procedure When" do legado, que
        *-- bloqueiam o foco enquanto a dependencia nao e satisfeita).
        *-- BINDEVENT "When" funciona de forma confiavel em TextBox - ao
        *-- contrario de "Valid", que NAO e (regra CLAUDE.md).
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "When", THIS, "DGrupoWhen")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "When", THIS, "ContaWhen")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "When", THIS, "DContaWhen")

        *-- O Valid do legado roda ao SAIR do campo; o gancho equivalente e
        *-- "LostFocus" (BINDEVENT "Valid" nao e confiavel em TextBox).
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "LostFocus", THIS, "DGrupoLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "LostFocus", THIS, "ContaLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposContraPartida - Bloco "Contra-Partida" do Container1
    * legado, transcrito do dump: Label4 (titulo da secao) / Get_GrupoC +
    * Get_DgrupoC + Say4 (par Grupo) / Get_contaC + Get_DcontaC + Say5 (par
    * Conta). Os quatro getters sao classe fwget (framework.vcx), igual aos
    * da fase anterior: Height = 23, Themes = .F., DisabledBackColor/
    * DisabledForeColor.
    *
    * Mapa legado -> migrado:
    *   Label4     "Contra-Partida" -> lbl_4c_ContraPartida
    *   Say4       "Grupo :"        -> lbl_4c_GrupoC
    *   Get_GrupoC                  -> txt_4c_GrupoC   (SigCdGcr.codigos char(10))
    *   Get_DgrupoC                 -> txt_4c_DGrupoC  (SigCdGcr.descrs  char(40))
    *   Say5       "Conta :"        -> lbl_4c_ContaC
    *   Get_contaC                  -> txt_4c_ContaC   (SigCdCli.iclis   char(10))
    *   Get_DcontaC                 -> txt_4c_DContaC  (SigCdCli.rclis   char(50))
    *
    * ForeColor: Label4 declara 255,0,0 (mesmo vermelho de Label1, titulo de
    * secao); Say4/Say5 declaram 90,90,90 (classe say sobre a textura clara
    * do form, regra CLAUDE.md #12). AutoSize = .T. de Label4 e NO-OP em
    * Label por AddObject (regra #23) - fica .F. com Width/Height do dump.
    *
    * MaxLength (regra #19): Get_GrupoC/Get_contaC usam o default herdado da
    * classe fwget (sem MaxLength no dump); Get_DcontaC declara 50, que
    * confere com SigCdCli.rclis char(50). Get_DgrupoC nao declara MaxLength
    * no dump.
    *
    * TabIndex: fica para AjustarTabIndexContainer1() - ver comentario em
    * ConfigurarContainerFiltro().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposContraPartida()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        *-- Label4 "Contra-Partida" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_ContraPartida", "Label")
        WITH loc_oCnt.lbl_4c_ContraPartida
            .Top       = 53
            .Left      = 2
            .Width     = 110
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Contra-Partida"
            .Visible   = .T.
        ENDWITH

        *-- Say4 "Grupo :" (rotulo do par GrupoC/DgrupoC)
        loc_oCnt.AddObject("lbl_4c_GrupoC", "Label")
        WITH loc_oCnt.lbl_4c_GrupoC
            .Top       = 78
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH

        *-- Get_GrupoC - codigo do Grupo contra-partida (SigCdGcr.codigos)
        loc_oCnt.AddObject("txt_4c_GrupoC", "TextBox")
        WITH loc_oCnt.txt_4c_GrupoC
            .Top               = 75
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Get_DgrupoC - descricao do Grupo contra-partida (SigCdGcr.descrs)
        loc_oCnt.AddObject("txt_4c_DGrupoC", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupoC
            .Top               = 75
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 40
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Say5 "Conta :" (rotulo do par ContaC/DContaC)
        loc_oCnt.AddObject("lbl_4c_ContaC", "Label")
        WITH loc_oCnt.lbl_4c_ContaC
            .Top       = 102
            .Left      = 83
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH

        *-- Get_contaC - codigo da Conta contra-partida (SigCdCli.iclis)
        loc_oCnt.AddObject("txt_4c_ContaC", "TextBox")
        WITH loc_oCnt.txt_4c_ContaC
            .Top               = 99
            .Left              = 123
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Get_DcontaC - descricao da Conta contra-partida (SigCdCli.rclis)
        loc_oCnt.AddObject("txt_4c_DContaC", "TextBox")
        WITH loc_oCnt.txt_4c_DContaC
            .Top               = 99
            .Left              = 204
            .Width             = 290
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 50
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- DEPENDENCIA entre os campos (os "Procedure When" do legado).
        *-- Get_GrupoC e Get_contaC NAO tem "Procedure When" no dump - ficam
        *-- sempre habilitados, sem depender do par Grupo/Conta do Filtro.
        BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "When", THIS, "DGrupoCWhen")
        BINDEVENT(loc_oCnt.txt_4c_DContaC, "When", THIS, "DContaCWhen")

        *-- O Valid do legado roda ao SAIR do campo (regra LostFocus, como no
        *-- bloco Filtro). Nenhum dos quatro chama MontaTela() - a
        *-- Contra-Partida nao afeta a consulta da grade de saldos.
        BINDEVENT(loc_oCnt.txt_4c_GrupoC,  "LostFocus", THIS, "GrupoCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "LostFocus", THIS, "DGrupoCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_ContaC,  "LostFocus", THIS, "ContaCLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DContaC, "LostFocus", THIS, "DContaCLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOperacao - Bloco "Operacao" do Container1 legado:
    * Shape1 (moldura) + Label2 (titulo da secao) + Get_Dope (valor lido de
    * SigCdPac.DopZers no Init - this_cOperacao do BO, ja carregado por
    * CarregarParametros() antes deste metodo rodar).
    *
    * Get_Dope.When do legado devolve .F. incondicional: o campo nunca recebe
    * foco, e por isso nunca e digitado pelo usuario - e so exibicao do
    * parametro do sistema. BackColor 255,255,215 (amarelo palido) e o padrao
    * do framework legado para esse tipo de campo informativo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOperacao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        loc_oCnt.AddObject("shp_4c_Operacao", "Shape")
        WITH loc_oCnt.shp_4c_Operacao
            .Top         = 72
            .Left        = 509
            .Width       = 166
            .Height      = 57
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label2 "Operacao" (titulo da secao)
        loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oCnt.lbl_4c_Operacao
            .Top       = 78
            .Left      = 517
            .Width     = 72
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- Get_Dope - operacao de movimento de estoque (SigCdPac.DopZers)
        loc_oCnt.AddObject("txt_4c_Dope", "TextBox")
        WITH loc_oCnt.txt_4c_Dope
            .Top       = 99
            .Left      = 516
            .Width     = 151
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .MaxLength = 20
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 215)
            .Value     = THIS.this_oBusinessObject.this_cOperacao
            .Visible   = .T.
        ENDWITH

        *-- Get_Dope.When devolve .F. incondicional no legado
        BINDEVENT(loc_oCnt.txt_4c_Dope, "When", THIS, "DopeWhen")
    ENDPROC

    *==========================================================================
    * AjustarTabIndexContainer1 - Aplica o TabIndex dos rotulos e dos getters
    * de Contra-Partida/Operacao, transcritos do dump (regra CLAUDE.md #
    * explicada em ConfigurarCamposFiltro). Roda por ULTIMO, quando os 16
    * controles ja existem no container - so assim o VFP9 aceita os valores
    * altos (9..16) sem renumerar/limitar.
    *==========================================================================
    PROTECTED PROCEDURE AjustarTabIndexContainer1()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtro

        loc_oCnt.txt_4c_GrupoC.TabIndex         = 5
        loc_oCnt.txt_4c_DGrupoC.TabIndex        = 6
        loc_oCnt.txt_4c_ContaC.TabIndex         = 7
        loc_oCnt.txt_4c_DContaC.TabIndex        = 8
        loc_oCnt.lbl_4c_Grupo.TabIndex          = 9
        loc_oCnt.lbl_4c_Filtro.TabIndex         = 10
        loc_oCnt.lbl_4c_ContraPartida.TabIndex  = 11
        loc_oCnt.txt_4c_Dope.TabIndex           = 12
        loc_oCnt.lbl_4c_GrupoC.TabIndex         = 13
        loc_oCnt.lbl_4c_ContaC.TabIndex         = 14
        loc_oCnt.lbl_4c_Conta.TabIndex          = 15
        loc_oCnt.lbl_4c_Operacao.TabIndex       = 16
    ENDPROC

    *==========================================================================
    * DGrupoWhen / ContaWhen / DContaWhen - equivalentes aos "Procedure When"
    * do legado, transcritos um a um:
    *
    *   Get_DGrupo.When  -> IsEmpty(Get_Grupo.Value)
    *   Get_Conta.When   -> Not IsEmpty(Get_Grupo.Value)
    *   get_Dconta.When  -> IsEmpty(Get_Conta.Value) And
    *                       Not IsEmpty(Get_Grupo.Value)
    *
    * Isto e, cada par codigo/descricao aceita digitacao por UM lado so, e a
    * Conta so abre depois que o Grupo esta preenchido.
    *
    * DGrupoCWhen / DContaCWhen seguem o mesmo padrao para a Contra-Partida -
    * Get_GrupoC e Get_contaC NAO tem When no dump (sempre habilitados):
    *
    *   Get_DgrupoC.When -> IsEmpty(Get_GrupoC.Value)
    *   Get_DcontaC.When -> IsEmpty(Get_ContaC.Value)
    *
    * DopeWhen e o Get_Dope.When do legado - devolve .F. incondicional, o
    * campo nunca recebe foco (e so exibicao do parametro do sistema).
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    FUNCTION DGrupoWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION ContaWhen()
        RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION DContaWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)) AND ;
               !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION DGrupoCWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value))
    ENDFUNC

    FUNCTION DContaCWhen()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value))
    ENDFUNC

    FUNCTION DopeWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * ResolverCodigoDescricao - Substitui fAcessoContab()/fAcessoContas() na
    * resolucao codigo <-> descricao dos quatro pares de campos deste form
    * (Grupo/DGrupo, GrupoC/DgrupoC, Conta/DConta, ContaC/DContaC).
    *
    * As duas funcoes legado (utils\functions.prg) reexibem o picker
    * FormBuscaSimples e, ao fechar, leem o REGISTRO CORRENTE do cursor de
    * apoio para preencher o par - sem distinguir "usuario selecionou" de
    * "usuario cancelou o dialogo". E exatamente o defeito que a memoria do
    * projeto documenta para fAcessoContas em lookup de UI (auto-preenche com
    * o 1o registro do cursor ao cancelar). Aqui, em troca, busca-se o valor
    * EXATO primeiro; so na falta dele abre-se THIS.AbrirLookupCanonico()
    * (herdado de FormBase), que SO atribui quando o usuario confirma a
    * escolha (this_lSelecionou) - nunca apaga o que foi digitado (regra
    * CLAUDE.md #50).
    *
    * Resolve por CODIGO se par_oTxtCod estiver preenchido (gancho dos
    * LostFocus de Grupo/GrupoC/Conta/ContaC); por DESCRICAO caso contrario
    * (gancho dos LostFocus de DGrupo/DgrupoC/DConta/DContaC) - a mutua
    * exclusividade e garantida pelos When acima, que so liberam o campo de
    * descricao quando o de codigo esta vazio.
    *
    * PROTECTED: nenhum BINDEVENT aponta direto para este metodo (so para os
    * *LostFocus que o chamam).
    *==========================================================================
    PROTECTED PROCEDURE ResolverCodigoDescricao(par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
        LOCAL loc_cCod, loc_cDesc, loc_cCursor, loc_cSQL, loc_nResult, loc_oErro
        loc_cCursor = "cursor_4c_ResolverCodDesc"

        TRY
            loc_cCod  = ALLTRIM(par_oTxtCod.Value)
            loc_cDesc = ALLTRIM(par_oTxtDesc.Value)

            IF !EMPTY(loc_cCod)
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
                    " FROM " + par_cTabela + ;
                    " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
                    IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    par_oTxtDesc.Value = ALLTRIM(Descs)
                ELSE
                    THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
                        par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
                ENDIF

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ELSE
                IF !EMPTY(loc_cDesc)
                    IF USED(loc_cCursor)
                        USE IN (loc_cCursor)
                    ENDIF

                    loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
                        " FROM " + par_cTabela + ;
                        " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
                        IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                    IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                        SELECT (loc_cCursor)
                        par_oTxtCod.Value = ALLTRIM(Cods)
                    ELSE
                        THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
                            par_cTitulo, loc_cDesc, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
                    ENDIF

                    IF USED(loc_cCursor)
                        USE IN (loc_cCursor)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupo / AbrirLookupConta / AbrirLookupGrupoC / AbrirLookupContaC
    * - FUNIL de lookup dos quatro pares codigo/descricao do form. Um metodo
    * por PAR (nao por campo): no legado o mesmo fAcessoContab/fAcessoContas
    * atende o Valid do codigo E o da descricao, decidindo pelo argumento
    * 'C'/'D'; aqui quem decide e ResolverCodigoDescricao, olhando qual dos
    * dois TextBox do par esta preenchido.
    *
    * Tabelas e colunas transcritas do legado (NUNCA adivinhadas):
    *   fAcessoContab -> SigCdGcr (codigos / descrs)  - grupos contabeis
    *   fAcessoContas -> SigCdCli (iclis  / rclis )   - contas correntes,
    *                    restritas ao grupo do bloco (pGrp do legado)
    *
    * A guarda this_lEmLookup mora AQUI, no funil, e nao em cada LostFocus:
    * assim cobre tambem qualquer outra entrada futura (F3/DblClick) com uma
    * unica trava. Como ResolverCodigoDescricao envolve todo o corpo em
    * TRY/CATCH e nao tem RETURN antecipado, a linha que libera a flag roda
    * sempre - inclusive quando o CATCH dispara (regra CLAUDE.md #47).
    *
    * PUBLIC (sem PROTECTED): sao chamados pelos *LostFocus e podem ser
    * acionados de FORA da classe (harness de teste) - regra CLAUDE.md #3/#51.
    *==========================================================================
    PROCEDURE AbrirLookupGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Grupo, ;
            THIS.cnt_4c_Filtro.txt_4c_DGrupo, ;
            "SigCdGcr", "codigos", "descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Conta, ;
            THIS.cnt_4c_Filtro.txt_4c_DConta, ;
            "SigCdCli", "iclis", "rclis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            THIS.FiltroGrupoParaConta())
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupGrupoC()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_GrupoC, ;
            THIS.cnt_4c_Filtro.txt_4c_DGrupoC, ;
            "SigCdGcr", "codigos", "descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo (Contra-Partida)", "")
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE AbrirLookupContaC()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_ContaC, ;
            THIS.cnt_4c_Filtro.txt_4c_DContaC, ;
            "SigCdCli", "iclis", "rclis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta (Contra-Partida)", ;
            THIS.FiltroGrupoCParaConta())
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * GrupoLostFocus / DGrupoLostFocus / ContaLostFocus / DContaLostFocus -
    * o que o Valid do legado faz ao sair de cada campo do Filtro:
    *
    *   Get_Grupo.Valid  -> fAcessoContab('C',...) / lcGrupo = This.Value /
    *                       ThisForm.MontaTela() / Refreshes
    *   Get_DGrupo.Valid -> fAcessoContab('D',...) / ThisForm.MontaTela()
    *   Get_Conta.Valid  -> fAcessoContas('C',...) / ThisForm.MontaTela()
    *   get_Dconta.Valid -> fAcessoContas('D',...) / ThisForm.MontaTela()
    *
    * O lookup fica no funil THIS.AbrirLookup<X>() (ver comentario acima), que
    * substitui as chamadas a fAcessoContab/fAcessoContas. O MontaTela() esta
    * no funil UNICO AplicarFiltro, que repassa o filtro ao BO e chama
    * CarregarDados.
    *
    * O IF de reentrancia aqui, alem do que ja existe no AbrirLookup<X>,
    * suprime tambem o AplicarFiltro() quando o LostFocus redispara com o
    * picker modal aberto - recarregar a grade por baixo do dialogo nao e o
    * que o legado faz.
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE GrupoLostFocus()
        LOCAL loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
        IF loc_cValor == THIS.this_cUltimoGrupoLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupGrupo()
        THIS.AplicarFiltro()
        THIS.this_cUltimoGrupoLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
    ENDPROC

    PROCEDURE DGrupoLostFocus()
        LOCAL loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
        IF loc_cValor == THIS.this_cUltimoDGrupoLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupGrupo()
        THIS.AplicarFiltro()
        THIS.this_cUltimoDGrupoLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
    ENDPROC

    PROCEDURE ContaLostFocus()
        LOCAL loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
        IF loc_cValor == THIS.this_cUltimoContaLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupConta()
        THIS.AplicarFiltro()
        THIS.this_cUltimoContaLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
    ENDPROC

    PROCEDURE DContaLostFocus()
        LOCAL loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
        IF loc_cValor == THIS.this_cUltimoDContaLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupConta()
        THIS.AplicarFiltro()
        THIS.this_cUltimoDContaLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
    ENDPROC

    *==========================================================================
    * FiltroGrupoParaConta - expressao "grupos = '<Grupo>'" usada como
    * par_cFiltroExtra de ResolverCodigoDescricao() para a Conta do Filtro -
    * equivalente ao "grupo" lido no inicio de Get_Conta.Valid/get_Dconta.Valid
    * do legado (ThisForm.Container1.Get_Grupo.Value), que fAcessoContas
    * usava para restringir a busca ao grupo do filtro.
    *==========================================================================
    PROTECTED PROCEDURE FiltroGrupoParaConta()
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
        RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
    ENDPROC

    *==========================================================================
    * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
    * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
    *
    *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
    *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
    *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
    *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
    *
    * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
    * filtro de saldos, so e usada no Processar (fase 7/8).
    *
    * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),
    * que ja carrega a guarda de reentrancia do picker modal.
    *
    * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE GrupoCLostFocus()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
        IF loc_cValor == THIS.this_cUltimoGrupoCLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupGrupoC()
        THIS.this_cUltimoGrupoCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
    ENDPROC

    PROCEDURE DGrupoCLostFocus()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupoC.Value)
        IF loc_cValor == THIS.this_cUltimoDGrupoCLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupGrupoC()
        THIS.this_cUltimoDGrupoCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupoC.Value)
    ENDPROC

    PROCEDURE ContaCLostFocus()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
        IF loc_cValor == THIS.this_cUltimoContaCLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupContaC()
        THIS.this_cUltimoContaCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
    ENDPROC

    PROCEDURE DContaCLostFocus()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DContaC.Value)
        IF loc_cValor == THIS.this_cUltimoDContaCLostFocusValidado
            RETURN
        ENDIF
        THIS.AbrirLookupContaC()
        THIS.this_cUltimoDContaCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DContaC.Value)
    ENDPROC

    *==========================================================================
    * FiltroGrupoCParaConta - mesma ideia de FiltroGrupoParaConta(), mas para
    * a Conta da Contra-Partida: o legado usa Get_GrupoC.Value (nao
    * Get_Grupo.Value) como grupo de referencia em Get_contaC.Valid/
    * Get_DcontaC.Valid.
    *==========================================================================
    PROTECTED PROCEDURE FiltroGrupoCParaConta()
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
        RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
    ENDPROC

    *==========================================================================
    * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
    * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
    * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
    *
    * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
    * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
    * a cada saida de campo, inclusive em Tab de passagem. A semantica do
    * legado e preservada - o que muda e so a consulta repetida.
    *
    * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
    * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
    * posicional concatenada (regra CLAUDE.md #42).
    *
    * PUBLIC (sem PROTECTED) porque e chamado dos handlers de BINDEVENT e pelo
    * harness de teste, de FORA da classe - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE AplicarFiltro()
        LOCAL loc_cGrupo, loc_cConta, loc_oErro

        TRY
            loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)

            IF loc_cGrupo == ALLTRIM(THIS.this_oBusinessObject.this_cGrupoFiltro) AND ;
               loc_cConta == ALLTRIM(THIS.this_oBusinessObject.this_cContaFiltro)
                *-- Filtro inalterado: a grade ja reflete esta consulta
            ELSE
                THIS.this_oBusinessObject.this_cGrupoFiltro = loc_cGrupo
                THIS.this_oBusinessObject.this_cContaFiltro = loc_cConta

                THIS.this_oBusinessObject.this_cDescGrupoFiltro = ;
                    ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
                THIS.this_oBusinessObject.this_cDescContaFiltro = ;
                    ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)

                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.AplicarFiltro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparFiltro - "Procedure iniciar" legado completo, que zera os OITO
    * campos do Filtro e da Contra-Partida:
    *
    *   With ThisForm.Container1
    *       .Get_GrupoC.Value = ' ' / .Get_grupo.Value = ' '
    *       .Get_DgrupoC.Value = ' ' / .Get_DGrupo.Value = ' '
    *       .Get_DcontaC.Value = ' ' / .get_dconta.Value = ' '
    *       .Get_contaC.Value = ' ' / .Get_conta.Value = ' '
    *   EndWith
    *   ThisForm.MontaTela()
    *
    * O legado usa um ESPACO, nao string vazia; aqui fica "" porque todos os
    * campos passam por ALLTRIM em todo consumidor (AplicarFiltro, os When e o
    * CarregarSaldos do BO), e o espaco solo so existia para o Empty() legado
    * dar verdadeiro - resultado identico. Get_Dope NAO entra aqui: o legado
    * "iniciar" nao o zera (e so exibicao do parametro do sistema).
    *
    * Zera tambem os pares guardados no BO, senao a guarda de "filtro
    * inalterado" do AplicarFiltro impediria a recarga.
    *
    * PUBLIC (sem PROTECTED): e o encerramento do Processar e o harness de
    * teste o chama de FORA da classe - regra CLAUDE.md #3.
    *==========================================================================
    PROCEDURE LimparFiltro()
        LOCAL loc_oErro

        TRY
            WITH THIS.cnt_4c_Filtro
                .txt_4c_Grupo.Value   = ""
                .txt_4c_DGrupo.Value  = ""
                .txt_4c_Conta.Value   = ""
                .txt_4c_DConta.Value  = ""
                .txt_4c_GrupoC.Value  = ""
                .txt_4c_DGrupoC.Value = ""
                .txt_4c_ContaC.Value  = ""
                .txt_4c_DContaC.Value = ""
            ENDWITH

            THIS.this_oBusinessObject.this_cGrupoFiltro     = ""
            THIS.this_oBusinessObject.this_cDescGrupoFiltro = ""
            THIS.this_oBusinessObject.this_cContaFiltro     = ""
            THIS.this_oBusinessObject.this_cDescContaFiltro = ""
            THIS.this_oBusinessObject.this_cGrupoContra     = ""
            THIS.this_oBusinessObject.this_cDescGrupoContra = ""
            THIS.this_oBusinessObject.this_cContaContra     = ""
            THIS.this_oBusinessObject.this_cDescContaContra = ""

            *-- Reseta as guardas de "valor nao mudou" dos LostFocus - senao
            *-- redigitar o MESMO codigo depois de limpar ficaria sem validar
            *-- (guarda comparando contra o valor antigo, nao contra o atual).
            THIS.this_cUltimoGrupoLostFocusValidado   = ""
            THIS.this_cUltimoDGrupoLostFocusValidado  = ""
            THIS.this_cUltimoContaLostFocusValidado   = ""
            THIS.this_cUltimoDContaLostFocusValidado  = ""
            THIS.this_cUltimoGrupoCLostFocusValidado  = ""
            THIS.this_cUltimoDGrupoCLostFocusValidado = ""
            THIS.this_cUltimoContaCLostFocusValidado  = ""
            THIS.this_cUltimoDContaCLostFocusValidado = ""

            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.LimparFiltro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAreaSaldo - Moldura, rotulo e grade da area de saldos
    * (shp_saldo + lbl_saldo + grd_saldo do legado). Cria tambem, via
    * CriarCursorSaldosPlaceholder, o cursor vazio com a MESMA estrutura que a
    * carga via SQL vai usar mais adiante (SigMvSlc + SigCdCli no MontaTela
    * legado), para o Grid ja nascer ligado - regra "cursor placeholder =
    * cursor real" do CLAUDE.md.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaSaldo()
        THIS.AddObject("shp_4c_Saldo", "Shape")
        WITH THIS.shp_4c_Saldo
            .Top         = 262
            .Left        = 81
            .Width       = 613
            .Height      = 254
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Saldo", "Label")
        WITH THIS.lbl_4c_Saldo
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Contas / Saldos "
            .Top       = 248
            .Left      = 90
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.CriarCursorSaldosPlaceholder()
        THIS.ConfigurarGridSaldo()
    ENDPROC

    *==========================================================================
    * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
    * carga por SQL vai popular depois (equivalente ao
    * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
    * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
    * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
    * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
    * incremental.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
             saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
        SET NULL OFF

        SELECT (loc_cCursor)
        INDEX ON contas TAG Contas
        INDEX ON rclis TAG Rclis
    ENDPROC

    *==========================================================================
    * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
    * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
    * Marcas - sem handler extra, o proprio binding da Column grava no
    * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
    * destaca a linha ja processada (Flag = 1), igual ao SetAll do
    * MontaTela().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridSaldo()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount/RecordSource FORA do WITH (regra CLAUDE.md #41): com
        *-- os dois dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
        *-- recriou as colunas no instante em que .Column1 e referenciado, e
        *-- estoura "Unknown member COLUMN1". Atribuir por referencia explicita
        *-- ANTES do WITH garante que as colunas ja existem quando o bloco
        *-- abaixo as configura.
        THIS.grd_4c_Dados.ColumnCount  = 5
        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        WITH THIS.grd_4c_Dados
            .Top           = 268
            .Left          = 87
            .Width         = 601
            .Height        = 244
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)

            .Column1.ControlSource     = loc_cCursor + ".contas"
            .Column1.Width             = 80
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.Header1.Caption   = "Conta"
            .Column1.Header1.Alignment = 2

            .Column2.ControlSource     = loc_cCursor + ".rclis"
            .Column2.Width             = 320
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2

            .Column3.ControlSource     = loc_cCursor + ".moedas"
            .Column3.Alignment         = 3
            .Column3.Width             = 40
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.Header1.Caption   = "Moeda"
            .Column3.Header1.Alignment = 2

            .Column4.ControlSource      = loc_cCursor + ".saldos"
            .Column4.Width              = 94
            .Column4.Movable            = .F.
            .Column4.Resizable          = .F.
            .Column4.ReadOnly           = .T.
            .Column4.Text1.InputMask    = "999,999,999.99"
            .Column4.Header1.Caption    = "Saldo"
            .Column4.Header1.Alignment  = 2

            .Column5.AddObject("Check1", "CheckBox")
            .Column5.Check1.Caption    = ""
            .Column5.Check1.Value      = 0
            .Column5.CurrentControl    = "Check1"
            .Column5.Sparse            = .F.
            .Column5.ReadOnly          = .F.
            .Column5.Width             = 21
            .Column5.ControlSource     = loc_cCursor + ".marcas"
            .Column5.Header1.Caption   = ""

            .SetAll("DynamicBackColor", ;
                "IIF(" + loc_cCursor + ".Flag = 1, RGB(220,255,220), RGB(255,255,255))", ;
                "Column")

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - SelTudo/Apaga (manipulam o cursor_4c_Saldos),
    * cmd_4c_CmdProcessa (cmdProcessa.Click do legado) e cmd_4c_Encerrar
    * (cmdGprocessa.cmdSair do legado). O CommandGroup de 1 botao do dump
    * (BackStyle=0, BorderStyle=0 - sem efeito visual nenhum) foi achatado
    * para um CommandButton avulso, seguindo o padrao ja usado em outros
    * forms OPERACIONAIS do projeto (ex.: FormDCC.cmd_4c_Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 519
            .Left        = 90
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .ToolTipText = "Seleciona tudo"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 519
            .Left        = 132
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarca tudo"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_CmdProcessa", "CommandButton")
        WITH THIS.cmd_4c_CmdProcessa
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_SelTudo,     "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,       "Click", THIS, "BtnApagaClick")
        BINDEVENT(THIS.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * CarregarDados - MontaTela() do legado: recarrega a grade de saldos a
    * partir do filtro corrente (Grupo / Conta, guardados no BO) e habilita o
    * Processar so quando ha linha para processar.
    *
    * Funil UNICO de recarga da grade. O legado chama MontaTela() em todo
    * ponto que muda o filtro (Get_Grupo.Valid, Get_Conta.Valid,
    * Get_DGrupo.Valid, get_Dconta.Valid e o limpa-campos); as fases
    * seguintes, que criam esses campos, chamam ESTE metodo - nunca repetem a
    * consulta.
    *
    * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
    * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
    * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
    * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
    * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
    * destruiria o Check1 posto por AddObject - regra #18/#41).
    *
    * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
    * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
    * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
    * SQL/permissao.
    *
    * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
    * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos

            IF !USED(loc_cCursor)
                THIS.CriarCursorSaldosPlaceholder()
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.CarregarSaldos()

            loc_nLinhas = 0
            IF USED(loc_cCursor)
                loc_nLinhas = RECCOUNT(loc_cCursor)
                SELECT (loc_cCursor)
                GO TOP
            ENDIF

            *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
            *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
            THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
    * Update CrSigMvSlc Set Marcas = 1 do legado)
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
    * Update CrSigMvSlc Set Marcas = 0 do legado)
    *==========================================================================
    PROCEDURE BtnApagaClick()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
    * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
    * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
    * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
    * lancamentos de encerramento por conta marcada - delegado a
    * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
    * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
    * Update/Commit/RollBack de ThisForm.poDataMgr.
    *
    * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
    * mensagens do legado, na mesma ordem. Guardados numa unica variavel
    * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
    * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
    * 4 "If Empty(...) / Return 0" sequenciais do legado).
    *
    * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
    * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
    * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
    * regra CLAUDE.md #35a).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
            loc_nSelecionadas, loc_oErro

        loc_cErro = ""

        TRY
            loc_cGrupo  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
            loc_cGrupoC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
            loc_cContaC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
            loc_cDope   = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Dope.Value)

            IF EMPTY(loc_cGrupo)
                loc_cErro = "Obrigat" + CHR(243) + "rio Informar o Grupo de Filtro!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cGrupoC)
                loc_cErro = "Grupo de Contra-Partida n" + CHR(227) + "o Informado!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cContaC)
                loc_cErro = "Conta de Contra-Partida n" + CHR(227) + "o informada!!!"
            ENDIF
            IF EMPTY(loc_cErro) AND EMPTY(loc_cDope)
                loc_cErro = "Opera" + CHR(231) + CHR(227) + "o de Mov.Estoque n" + CHR(227) + ;
                    "o cadastrada nos Par" + CHR(226) + "metros do Sistema!!!"
            ENDIF

            IF !EMPTY(loc_cErro)
                MsgAviso(loc_cErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_nSelecionadas = 0

                IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                    SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
                    COUNT TO loc_nSelecionadas FOR marcas = 1
                ENDIF

                IF loc_nSelecionadas = 0
                    MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas

                    IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
                        MsgInfo("Encerramento processado com sucesso!", "Confirmar")
                        THIS.LimparFiltro()
                    ELSE
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
                        ENDIF
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - cmdGprocessa.cmdSair.Click do legado (fecha o form)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
    * recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho do BO (equivalente ao
    * ThisForm.poDataMgr.Release do legado)
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorSaldos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorLancamentos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorLancamentos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorCabecalhos)
                    USE IN (THIS.this_oBusinessObject.this_cCursorCabecalhos)
                ENDIF
                IF USED(THIS.this_oBusinessObject.this_cCursorParametros)
                    USE IN (THIS.this_oBusinessObject.this_cCursorParametros)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormSigOpEnc.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
