*==============================================================================
* FormSigPrGst.prg - Geracao de Movimentacoes de Estoque
*==============================================================================
* Herda de: FormBase
* BO: SigPrGstBO
* Legado: SIGPRGST.SCX
* Tipo: OPERACIONAL (form PLANO sem PageFrame - os objetos do dump sao
*       filhos diretos de SIGPRGST ou de cntSombra, sem Pagina.Lista/Dados)
*
* Tela auxiliar aberta por um form pai que ja populou os cursores
* csCabec/csItens/csEstPe (pedidos de movimentacao ainda nao gerados) e
* CrSigCdNec/CrSigCdEmb (parametros de embalagem). O usuario escolhe, na
* grade de csCabec (GrdCab), qual pedido confirmar; a grade de itens
* (GrdIte) espelha csItens do pedido corrente via AfterRowColChange. O
* botao Confirmar (CmdGrava) chama SigPrGstBO.GerarPedido(), que grava os
* movimentos (SigMvCab/SigMvItn/SigMvIts/SigMvPec/SigInBep) e, com
* sucesso, abre SigMvCab para o usuario revisar a movimentacao recem-
* gerada; o botao Sair (CmdCancela) confirma cancelamento quando houver
* pedidos ainda nao confirmados.
*
* Recebe o form pai via Init(par_oFormPai) - equivalente ao
* "Parameters poform" do legado, que le ThisForm.ParentForm.pcEscolha
* (repassado para SigPrGstBO.this_cPcEscolha). Sem DataSession=2: o
* legado nao declara DataSession proprio (default = 1, sessao
* compartilhada com quem abriu a tela) - csCabec/csItens/csEstPe/
* CrSigCdNec/CrSigCdEmb, populados pelo form pai, precisam continuar
* visiveis aqui pelo mesmo motivo.
*
* Montagem: Fase 3 - estrutura base (DEFINE CLASS, Init/Destroy/
* InicializarForm, cabecalho cnt_4c_Sombra, TornarControlesVisiveis).
* Fase 4 - as duas grades (grd_4c_GrdCab/grd_4c_GrdIte) com a carga de
* dados (CarregarLista/CarregarItensPedido) e os dois botoes de acao.
* Fase 6 - pedido corrente -> BO (SincronizarPedidoCorrente), os dois guards
* do legado (ValidarPedidoSelecionado/ValidarSaidaSemConfirmar), os
* membros publicos pcEscolha/GrupoOper e ProcessaPeriodo().
* Roteiro completo em ConfigurarPageFrame().
*==============================================================================

DEFINE CLASS FormSigPrGst AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRGST.SCX: Width=1000, Height=600, BorderStyle=2,
    * AutoCenter=.T., ControlBox=.F., Movable=.F., KeyPreview=.T., TitleBar=0,
    * WindowType=1 - dump de SigPrGst_form_codigo_fonte.txt, linhas 222-235)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    KeyPreview   = .T.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Gera" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(245) + "es de Estoque"

    *--------------------------------------------------------------------------
    * ThisForm.ParentForm do legado - form que ja populou csCabec/csItens/
    * csEstPe/CrSigCdNec/CrSigCdEmb antes de abrir esta tela (ver cabecalho
    * do arquivo). Guardado apenas para repassar pcEscolha ao BO no Init -
    * nenhum metodo com codigo do dump le mais nada de volta dele.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Membros publicos do form legado (Secao 4 do dump, RESERVED3/ClassInfo de
    * SIGPRGST: grupooper / parentform / pcescolha / podatamgr / *gerarpedido /
    * *processaperiodo). O nome destes DOIS fica IDENTICO ao do legado, de
    * proposito - excecao consciente ao PILAR 3 (prefixo this_), pela mesma
    * razao da regra #32 do CLAUDE.md: eles nao sao estado interno desta
    * classe, sao a INTERFACE que o form FILHO le de volta. O CmdGrava.Click
    * legado abre a tela de movimentacao passando o proprio form como pai
    * ("Do Form SigMvCab With ..., ThisForm, .f., .t."), e de la o acesso eh
    * por ThisForm.ParentForm.pcEscolha / .GrupoOper - renomear aqui quebraria
    * essa leitura em runtime, sem erro de compilacao.
    *
    * O valor fica espelhado em SigPrGstBO.this_cPcEscolha / this_cGrupoOper
    * (quem consome o estado nas regras de negocio eh o BO, conforme PILAR 3).
    *--------------------------------------------------------------------------
    pcEscolha = SPACE(10)
    GrupoOper = SPACE(10)

    *--------------------------------------------------------------------------
    * Init - recebe o form pai (equivalente a "Parameters poform" do legado)
    * e cria o Business Object ANTES do DODEFAULT(), para que
    * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
    * encontre pronto. Repassa pcEscolha do pai para o BO (equivalente a
    * "ThisForm.PcEscolha = ThisForm.ParentForm.pcEscolha").
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGstBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- "ThisForm.GrupoOper = Space(10)" do Init legado
                THIS.GrupoOper = SPACE(10)
                THIS.this_oBusinessObject.this_cGrupoOper = SPACE(10)

                IF PCOUNT() >= 1 AND VARTYPE(par_oFormPai) = "O"
                    THIS.this_oFormPai = par_oFormPai

                    IF PEMSTATUS(par_oFormPai, "pcEscolha", 5)
                        *-- "ThisForm.PcEscolha = ThisForm.ParentForm.pcEscolha"
                        THIS.pcEscolha = PADR(TratarNulo(par_oFormPai.pcEscolha, ""), 10)
                        THIS.this_oBusinessObject.this_cPcEscolha = THIS.pcEscolha
                    ENDIF
                ENDIF

                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Gera" + CHR(231) + CHR(227) + "o de Movimenta" + ;
                CHR(231) + CHR(245) + "es de Estoque: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
    * eh liberado aqui - pertence a quem o criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela inteira via ConfigurarPageFrame(): fundo,
    * cabecalho, as duas grades (ja ligadas aos cursores do form pai) e os dois
    * botoes de acao. Os Click dos botoes entram na fase de eventos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGstBO.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGST nao
    * tem PageFrame no legado (layout flat: cntSombra + 2 grids + 2 botoes
    * no proprio form) - o nome do metodo eh mantido apenas como ponto de
    * entrada arquitetural padrao (mesmo papel em FormSigPrGmi/FormSigPrGlp).
    *
    * NOTA SOBRE O ROTEIRO GENERICO DE 8 FASES: o template padrao da Fase 4
    * ("Grid e botoes CRUD - Page1") pressupoe form CRUD com PageFrame
    * Lista/Dados e 6 botoes (Incluir/Visualizar/Alterar/Excluir/Buscar/
    * Encerrar). SIGPRGST NAO tem essa superficie - o dump legado (Secao 1
    * do .txt) prova PageFrame=0, e os UNICOS botoes do form inteiro sao
    * CmdCancela ("Sair") e CmdGrava ("Confirmar"). Inventar PageFrame
    * Lista/Dados ou os 6 botoes CRUD viola o PILAR 1 (UX) e a regra "NUNCA
    * inventar" (CLAUDE.md) - mesma familia de caso documentada para
    * SIGMVEXP/SIGPDMEN/SIGMVVDE/SIGPRCCC (formularios OPERACIONAL cuja
    * superficie real nao casa com o template CRUD). Esta fase entrega,
    * em vez disso, a superficie REAL do legado: os dois grids de lista
    * (csCabec/csItens) e os dois botoes de acao.
    *
    * Historico de montagem (migracao multi-fase):
    *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
    *   Fase 4 (esta)  - ConfigurarGrids() (grd_4c_GrdCab + grd_4c_GrdIte,
    *                     formatadas por FormatarGridCabecalho()/
    *                     FormatarGridItens()) + CarregarLista() /
    *                     CarregarItensPedido() (funil unico do bind a
    *                     csCabec/csItens, usado tambem pelo
    *                     GrdCabAfterRowColChange) + ConfigurarBotoesAcao()
    *                     (shp_4c_ShpP2 decorativo + cmd_4c_CmdGrava +
    *                     cmd_4c_CmdCancela)
    *   Fase 6 (esta)  - a superficie de DADOS que este legado de fato tem.
    *                     NAO ha campo nem lookup a acrescentar, e isso esta
    *                     PROVADO pelo dump: a Secao 1 nao lista um unico
    *                     controle de entrada (textbox/combobox/checkbox/
    *                     optiongroup/spinner) fora das colunas das grades, as
    *                     colunas das DUAS grades sao ReadOnly = .T. (Secao 2)
    *                     e o arquivo inteiro nao tem UMA ocorrencia de
    *                     fwBuscaExt/fwBuscaSel/mAddColuna/sigacess/Acesso* -
    *                     o unico CreateObject do form eh fwprogressbar, dentro
    *                     de gerarpedido. Inventar uma Page2 de Dados, um campo
    *                     com ControlSource ou um lookup para alguma tabela
    *                     auxiliar violaria o PILAR 1 e a regra explicita
    *                     "NUNCA inventar tabelas de lookup que nao existem no
    *                     original"; metodo de lookup vazio seria stub
    *                     disfarcado. O dado de ENTRADA desta tela eh a LINHA
    *                     selecionada em csCabec - e eh isso que a fase
    *                     entrega: SincronizarPedidoCorrente() (a linha
    *                     corrente alimentando as propriedades do BO, nos dois
    *                     caminhos que a mudam), ValidarPedidoSelecionado() e
    *                     ValidarSaidaSemConfirmar() (os dois guards
    *                     transcritos do topo de CmdGrava.Click e de
    *                     CmdCancela.Click, que a Fase 7 vai chamar), os
    *                     membros publicos pcEscolha/GrupoOper e o metodo de
    *                     contrato ProcessaPeriodo() (ClassInfo do SCX).
    *   Fase 7 (esta)  - BINDEVENT de Click em cmd_4c_CmdGrava/cmd_4c_CmdCancela
    *                     (BtnConfirmarClick: ValidarPedidoSelecionado() ->
    *                     this_oBusinessObject.GerarPedido() -> abrir
    *                     Formsigmvcab; BtnSairClick:
    *                     ValidarSaidaSemConfirmar() -> THIS.Release())
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrids()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrids - cria grd_4c_GrdCab (pedidos a gerar, csCabec) e
    * grd_4c_GrdIte (itens do pedido corrente, csItens) com a geometria e as
    * propriedades estaticas transcritas do dump legado
    * (SigPrGst_form_codigo_fonte.txt, Secao 2 - GrdCab/GrdIte).
    *
    * ATENCAO ao mapear as colunas do dump: o SCX guarda a ORDEM FISICA dos
    * registros de coluna com "ColumnN.Name = ColumnM", e o legado referencia
    * as colunas pelo NOME (With ThisForm.GrdCab / .Column3.ControlSource),
    * exibindo-as na ordem de ColumnOrder. No GrdCab os dois nao coincidem:
    *
    *   ColumnOrder | objeto legado | Header          | Width | ControlSource
    *   ------------+---------------+-----------------+-------+---------------
    *        1      | Column1       | Emp             |    35 | csCabec.EmpDs
    *        2      | Column7       | Movimentacao    |   225 | csCabec.Dopes
    *        3      | Column2       | Grupo Origem    |   100 | csCabec.GrupoOs
    *        4      | Column3       | Conta Origem    |   100 | csCabec.ContaOs
    *        5      | Column5       | Grupo Destino   |   100 | csCabec.GrupoDs
    *        6      | Column4       | Conta Destino   |   100 | csCabec.ContaDs
    *        7      | Column6       | Confirmacao     |   100 | csCabec.Gerado
    *
    * (35+225+5*100 = 760, dentro do Width=798 da grade). Aqui as colunas sao
    * criadas por POSICAO (.Column1 .. .Column7 de um Grid com ColumnCount=7),
    * entao a posicao N recebe o que o legado exibe em ColumnOrder = N - e NAO
    * o registro N do dump. No GrdIte as duas ordens coincidem (ColumnOrder 1
    * a 7 = Column1 a Column7), mas as larguras tambem precisam vir por NOME:
    * 36 / 120 / 403 / 23 / 130 / 100 / 130 (soma 942, Width=980).
    *
    * O bind de dados NAO fica aqui: csCabec/csItens sao abertos pelo form PAI
    * (DataSession=1, sessao compartilhada - ver cabecalho do arquivo) e podem
    * nao existir ainda. Toda a ligacao com os cursores vive em
    * CarregarLista()/CarregarItensPedido(), que sao o funil unico desse
    * trabalho - chamado tambem quando o usuario troca de linha na grade de
    * cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oErro

        TRY
            *----------------------------------------------------------------
            * grd_4c_GrdCab - pedidos ainda nao gerados (csCabec)
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_GrdCab", "Grid")
            WITH THIS.grd_4c_GrdCab
                .Top               = 95
                .Left              = 11
                .Width             = 798
                .Height            = 194
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ColumnCount       = 7
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ReadOnly          = .T.
                .HeaderHeight      = 15
                .RowHeight         = 16
                .ScrollBars        = 2
                .TabStop           = .F.
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.
            ENDWITH

            *-- Colunas/cabecalhos. O ReadOnly de cada coluna fica em
            *-- FormatarGridCabecalho porque tem de vir DEPOIS do
            *-- Grid.ReadOnly acima, que propaga para as colunas
            THIS.FormatarGridCabecalho()

            BINDEVENT(THIS.grd_4c_GrdCab, "AfterRowColChange", THIS, "GrdCabAfterRowColChange")

            *----------------------------------------------------------------
            * grd_4c_GrdIte - itens do pedido corrente (csItens, escopado por
            * csCabec.EmpDopNums em CarregarItensPedido)
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_GrdIte", "Grid")
            WITH THIS.grd_4c_GrdIte
                .Top               = 295
                .Left              = 10
                .Width             = 980
                .Height            = 289
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ColumnCount       = 7
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ReadOnly          = .T.
                .HeaderHeight      = 15
                .RowHeight         = 16
                .ScrollBars        = 2
                .TabStop           = .F.
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.
            ENDWITH

            THIS.FormatarGridItens()

            *-- Carga inicial: equivalente ao bloco final do Init legado
            *-- (Select CsCabec / Go Top / Select CsItens / Set Key To ... /
            *--  With ThisForm.GrdCab ... / With ThisForm.GrdIte ...)
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrids")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridCabecalho - Width / Header1.Caption / ReadOnly / Text1 de
    * TODAS as colunas de grd_4c_GrdCab.
    *
    * Metodo separado porque esse bloco precisa rodar DUAS vezes: na montagem
    * (ConfigurarGrids) e depois de CADA bind de RecordSource/ControlSource em
    * CarregarLista() - o VFP9 reseta Column.Width, Header1.Caption e
    * Column.ReadOnly para os defaults quando a fonte de dados da grade muda
    * (Problema 48 de FORMCOR_LICOES_APRENDIDAS.md; CLAUDE.md regra #43.1).
    * Por isso Width vem SEMPRE depois do ControlSource, nunca antes.
    *
    * Movable/Resizable: o dump declara .F. apenas nas colunas legado
    * Column1/Column2/Column4/Column5/Column6 - as legado Column3
    * (Conta Origem, posicao 4) e Column7 (Movimentacao, posicao 2) nao os
    * declaram e ficam no default .T. A assimetria eh do SCX legado, nao
    * descuido da migracao (AllowHeaderSizing = .F. no Grid ja bloqueia o
    * redimensionamento na pratica).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridCabecalho()
        WITH THIS.grd_4c_GrdCab

            *-- Posicao 1 (legado Column1) - Emp
            WITH .Column1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Emp"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 35
            ENDWITH

            *-- Posicao 2 (legado Column7) - Movimentacao
            WITH .Column2
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                WITH .Header1
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 225
            ENDWITH

            *-- Posicao 3 (legado Column2) - Grupo Origem
            WITH .Column3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Grupo Origem"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 100
            ENDWITH

            *-- Posicao 4 (legado Column3) - Conta Origem
            WITH .Column4
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                WITH .Header1
                    .Caption   = "Conta Origem"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 100
            ENDWITH

            *-- Posicao 5 (legado Column5) - Grupo Destino
            WITH .Column5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Grupo Destino"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 100
            ENDWITH

            *-- Posicao 6 (legado Column4) - Conta Destino
            WITH .Column6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Conta Destino"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 100
            ENDWITH

            *-- Posicao 7 (legado Column6) - Confirmacao. Verde, negrito e
            *-- centralizado: eh a coluna que mostra o "OK" de csCabec.Gerado
            WITH .Column7
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .Alignment = 2
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 128, 0)
                WITH .Header1
                    .Caption   = "Confirma" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
                WITH .Text1
                    .FontBold    = .T.
                    .FontSize    = 8
                    .Alignment   = 2
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 128, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
                .Width = 100
            ENDWITH

        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridItens - Width / Header1.Caption / ReadOnly / Text1 de TODAS
    * as colunas de grd_4c_GrdIte. Mesmo motivo de FormatarGridCabecalho: roda
    * na montagem e depois de cada bind em CarregarItensPedido().
    *
    * As 7 colunas do GrdIte compartilham no dump as MESMAS propriedades
    * (FontSize 8, Movable/Resizable .F., ReadOnly .T., Text1 BorderStyle 0 /
    * Margin 0 / ReadOnly .T. / preto sobre branco, Header1 Tahoma 8
    * centralizado preto) - variam apenas Width e Caption, por isso o laco.
    *
    * A posicao 1 tem Header1.Caption = "" no legado (coluna do numero do
    * item, csItens.CItens): vazio eh o valor do dump, nao caption esquecido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridItens()
        LOCAL loc_nCol
        LOCAL ARRAY loc_aLargura[7], loc_aCaption[7]

        loc_aLargura[1] = 36
        loc_aLargura[2] = 120
        loc_aLargura[3] = 403
        loc_aLargura[4] = 23
        loc_aLargura[5] = 130
        loc_aLargura[6] = 100
        loc_aLargura[7] = 130

        loc_aCaption[1] = ""
        loc_aCaption[2] = "Produto"
        loc_aCaption[3] = "Descri" + CHR(231) + CHR(227) + "o do Produto"
        loc_aCaption[4] = "M"
        loc_aCaption[5] = "Pr. Unit."
        loc_aCaption[6] = "Quantidade"
        loc_aCaption[7] = "Total"

        FOR loc_nCol = 1 TO 7
            *-- Columns(N) (PLURAL) eh a collection que aceita indice de
            *-- variavel; .Column(N) NAO existe em VFP9 (CLAUDE.md regra #43)
            WITH THIS.grd_4c_GrdIte.Columns(loc_nCol)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.

                WITH .Header1
                    .Caption   = loc_aCaption[loc_nCol]
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH

                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH

                *-- Width por ULTIMO (ver FormatarGridCabecalho)
                .Width = loc_aLargura[loc_nCol]
            ENDWITH
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - liga as duas grades aos cursores do form pai e posiciona
    * as duas no primeiro registro. Transcricao do bloco final do Init legado
    * (SigPrGst_form_codigo_fonte.txt, PROCEDURE Init):
    *
    *     Select CsCabec / Go Top
    *     Select CsItens / Set Key To CsCabec.EmpdopNums / Go Top
    *     Select CsCabec
    *     With ThisForm.GrdCab ... RecordSource + 7 ControlSource +
    *                             SetAll DynamicBackColor + Refresh
    *     With ThisForm.GrdIte ... RecordSource + 7 ControlSource + Refresh
    *
    * csCabec/csItens NAO sao abertos aqui: quem os popula eh o form que abre
    * esta tela (ver cabecalho do arquivo). O guard USED() existe porque
    * atribuir RecordSource/ControlSource a um alias inexistente derruba o
    * Init com "Alias ... is not found" e o form nunca abre (CLAUDE.md regra
    * #41) - eh o que aconteceria em ValidarUIFidelity/gb_4c_ModoTeste, que
    * instanciam o form sem form pai. Sem os cursores as grades ficam com as
    * colunas formatadas e RecordSource vazio, que eh o estado correto.
    *
    * PUBLIC (sem PROTECTED) de proposito: TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS(...,5) devolve
    * .T. mesmo para metodo PROTECTED - o harness entraria no branch e a
    * chamada falharia em runtime (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csCabec")
                SELECT csCabec
                GO TOP

                THIS.grd_4c_GrdCab.RecordSourceType = 1
                THIS.grd_4c_GrdCab.RecordSource      = "csCabec"

                WITH THIS.grd_4c_GrdCab
                    .Column1.ControlSource = "csCabec.EmpDs"
                    .Column2.ControlSource = "csCabec.Dopes"
                    .Column3.ControlSource = "csCabec.GrupoOs"
                    .Column4.ControlSource = "csCabec.ContaOs"
                    .Column5.ControlSource = "csCabec.GrupoDs"
                    .Column6.ControlSource = "csCabec.ContaDs"
                    .Column7.ControlSource = "csCabec.Gerado"

                    *-- Linha amarelada no pedido JA gerado (transcrito do
                    *-- SetAll do Init legado)
                    .SetAll("DynamicBackColor", ;
                        "IIF(EMPTY(csCabec.Gerado), RGB(255,255,255), RGB(255,255,204))", ;
                        "Column")
                ENDWITH

                *-- O bind acima reseta Width/Header1.Caption/ReadOnly das
                *-- colunas: reaplicar ANTES do Refresh
                THIS.FormatarGridCabecalho()

                SELECT csCabec
                GO TOP
                THIS.grd_4c_GrdCab.Refresh()
            ENDIF

            *-- Pedido corrente (linha de csCabec) -> propriedades do BO
            THIS.SincronizarPedidoCorrente()

            *-- Grade de itens (escopada pelo pedido corrente de csCabec)
            THIS.CarregarItensPedido()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPedido - liga grd_4c_GrdIte a csItens, escopa o cursor no
    * pedido corrente de csCabec e repinta a grade. Funil UNICO desse trabalho:
    * chamado pela carga inicial (CarregarLista) E pela troca de linha na grade
    * de cabecalho (GrdCabAfterRowColChange) - sem isso a grade de itens fica
    * visualmente parada ao trocar de pedido (CLAUDE.md regra #21a).
    *
    * SET KEY TO depende da ordem ativa em csItens, criada pelo form pai junto
    * com o cursor (o legado conta com ela: "Select CsItens / Set Key To
    * CsCabec.EmpdopNums"). O teste de ORDER() nao existe no legado - ele
    * evita que a tela morra quando o form eh instanciado sem form pai
    * (ValidarUIFidelity/gb_4c_ModoTeste), caso em que nao ha o que escopar.
    *
    * PUBLIC: chamado pelo handler ligado por BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPedido()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csItens")
                THIS.grd_4c_GrdIte.RecordSourceType = 1
                THIS.grd_4c_GrdIte.RecordSource      = "csItens"

                WITH THIS.grd_4c_GrdIte
                    .Column1.ControlSource = "csItens.CItens"
                    .Column2.ControlSource = "csItens.CPros"
                    .Column3.ControlSource = "csItens.DPros"
                    .Column4.ControlSource = "csItens.Moedas"
                    .Column5.ControlSource = "csItens.Units"
                    .Column6.ControlSource = "csItens.Qtds"
                    .Column7.ControlSource = "csItens.Totas"
                ENDWITH

                *-- Reaplicar apos o bind (ver FormatarGridCabecalho)
                THIS.FormatarGridItens()

                SELECT csItens
                IF USED("csCabec") AND !EMPTY(ORDER("csItens"))
                    SET KEY TO csCabec.EmpdopNums
                ENDIF
                GO TOP

                *-- Devolve o alias corrente para a grade de cabecalho, como o
                *-- legado faz ("Select CsCabec" antes de montar GrdCab)
                IF USED("csCabec")
                    SELECT csCabec
                ENDIF

                THIS.grd_4c_GrdIte.Refresh()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarItensPedido")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GrdCabAfterRowColChange - transcricao de SIGPRGST.GrdCab.AfterRowColChange
    * (dump legado): ao trocar de linha/coluna em grd_4c_GrdCab, re-escopa
    * csItens para o pedido agora corrente em csCabec e repinta grd_4c_GrdIte.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (CLAUDE.md
    * regra #3); declara par_nColIndex porque o grid invoca o evento sempre
    * com esse parametro (handler sem o parametro estoura "No PARAMETER
    * statement is found").
    *--------------------------------------------------------------------------
    PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
        *-- Trocou o pedido corrente: alinhar o BO com a nova linha ANTES de
        *-- re-escopar os itens (a chave que CarregarItensPedido usa no
        *-- SET KEY TO eh a desta linha)
        THIS.SincronizarPedidoCorrente()
        THIS.CarregarItensPedido()
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarPedidoCorrente - leva a linha CORRENTE de csCabec para as
    * propriedades do BO (this_cEmps / this_cDopes / this_cEmpDopNums).
    *
    * POR QUE ISTO EH O "CAMPO" DESTA TELA: SIGPRGST nao tem nenhum controle
    * de entrada de dados - o dump legado (Secao 1) prova que os unicos
    * objetos do form sao duas grades, o container do cabecalho, um Shape
    * decorativo e os dois botoes; zero textbox/combobox/checkbox fora das
    * colunas das grades, e as colunas das DUAS grades sao ReadOnly = .T.
    * (Secao 2: GrdCab/GrdIte .ColumnN.Text1.ReadOnly = .T.). A unica "coisa
    * que o usuario informa" eh QUAL LINHA de csCabec esta selecionada, e eh
    * exatamente isso que o legado propaga quando escopa os itens:
    *
    *     Select CsItens
    *     Set Key To CsCabec.EmpdopNums
    *
    * Dai a chave do pedido corrente ser o dado de entrada deste form. O BO
    * declara as tres propriedades desde a Fase 1 e nada as alimentava; sem
    * este funil, ObterChavePrimaria() (usada pela auditoria de
    * BusinessBase) devolve a chave VAZIA e o registro de auditoria da
    * geracao sai sem identificar o pedido - falha silenciosa, sem erro na
    * tela. GerarPedido() le csCabec direto, como o legado, entao a geracao
    * em si nao depende disto - a auditoria sim.
    *
    * Chamado nos DOIS caminhos que mudam o pedido corrente: a carga inicial
    * (CarregarLista) e a troca de linha na grade (GrdCabAfterRowColChange) -
    * mesmo funil unico de CarregarItensPedido (CLAUDE.md regra #40: quem
    * muda estado repoe em CADA caminho, nunca so no primeiro).
    *
    * A chave NAO eh remontada aqui: le-se csCabec.EmpDopNums como gravado,
    * porque ela eh POSICIONAL (Emps char(3) + Dopes char(20) + Str(Numes,6)
    * = char(29)) e reconstruir com as partes ja aparadas devolve chave curta
    * que nunca casa no SET KEY (CLAUDE.md regra #42).
    *
    * PUBLIC: chamado por GrdCabAfterRowColChange, que roda por BINDEVENT
    * (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarPedidoCorrente()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED("csCabec") AND !EOF("csCabec") AND !BOF("csCabec")
                    THIS.this_oBusinessObject.this_cEmps       = PADR(TratarNulo(csCabec.Emps, ""), 3)
                    THIS.this_oBusinessObject.this_cDopes      = PADR(TratarNulo(csCabec.Dopes, ""), 20)
                    THIS.this_oBusinessObject.this_cEmpDopNums = TratarNulo(csCabec.EmpDopNums, "")
                ELSE
                    *-- Sem linha corrente nao ha pedido: limpar, para nao
                    *-- deixar a chave do pedido ANTERIOR grudada no BO
                    THIS.this_oBusinessObject.this_cEmps       = SPACE(3)
                    THIS.this_oBusinessObject.this_cDopes      = SPACE(20)
                    THIS.this_oBusinessObject.this_cEmpDopNums = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.SincronizarPedidoCorrente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPedidoSelecionado - guard do pedido corrente, transcrito do
    * TOPO de SIGPRGST.CmdGrava.Click (dump legado):
    *
    *     Select csCabec
    *     If Eof([csCabec])
    *         =MessageBox([Selecione Um Pedido a Ser Gerado Na Grade e Tente
    *                      Novamente], 16, [Atencao!!!])
    *         Return .f.
    *     EndIf
    *
    * Devolve .T. quando ha pedido corrente e a geracao pode prosseguir; .F.
    * depois de ja ter avisado o usuario. Quem chama eh o Click de
    * cmd_4c_CmdGrava (fase de eventos), ANTES de
    * this_oBusinessObject.GerarPedido().
    *
    * O texto da mensagem eh o do legado, palavra por palavra. Vai em
    * MsgAviso (dialogo amarelo) e nao em MsgErro: eh validacao de UI
    * ("Selecione um registro"), nao excecao tecnica - o legado usa icone 16
    * (critico), desvio consciente e documentado para seguir o padrao de
    * mensagens do sistema novo.
    *
    * NAO bloqueia pedido JA gerado, de proposito: o legado deixa passar
    * (GerarPedido devolve sucesso sem fazer nada quando csCabec.Gerado esta
    * preenchido) justamente para que o "If llRet And Not Empty(csCabec.
    * Gerado)" seguinte reabra a movimentacao existente para conferencia.
    * Barrar aqui tiraria do usuario esse caminho de consulta.
    *
    * PUBLIC: o harness de teste chama os validadores do form de fora da
    * classe, e PEMSTATUS(...,5) devolve .T. mesmo para metodo PROTECTED
    * (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPedidoSelecionado()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .F.

        TRY
            IF !USED("csCabec")
                *-- Nao existe no legado: la o cursor eh garantido pelo form
                *-- pai. Aqui evita "Alias is not found" derrubar o Click
                *-- quando a tela eh instanciada sem pai (modo teste).
                MsgAviso("Nenhum pedido carregado para gera" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT csCabec

                IF EOF("csCabec")
                    MsgAviso("Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Pedido corrente valido: alinhar o BO com a linha antes
                    *-- de entregar o fluxo para GerarPedido()
                    THIS.SincronizarPedidoCorrente()
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.ValidarPedidoSelecionado")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSaidaSemConfirmar - guard da saida, transcrito de
    * SIGPRGST.CmdCancela.Click (dump legado):
    *
    *     Select Emps, Dopes, Numes From csCabec Where Empty(Gerado) ;
    *       Into Cursor LocalGerado
    *     lnFal = Reccount([LocalGerado])
    *     If (lnFal > 0)
    *         If MessageBox([Existem ] + Alltrim(Str(lnFal,10)) +
    *                       [ Operacoes Nao Confirmadas!] + Chr(13) +
    *                       [Tem Certeza Que Nao Deseja Gerar Esses Pedidos?],
    *                       4+32+256, [Atencao!!!]) <> 6
    *             Return .f.
    *         Else
    *             fGravarLog([T], CrSigCdNec.Dopps, [AUTOMATICO],
    *                        [A Geracao de ] + Alltrim(Str(lnFal,10)) +
    *                        [ Operacao Foi Cancelada Sem Confirmacao])
    *         EndIf
    *     EndIf
    *     ThisForm.Release
    *
    * Devolve .T. quando a tela pode fechar (nada a confirmar, ou o usuario
    * confirmou abandonar) e .F. quando o usuario desistiu de sair. Quem
    * chama eh o Click de cmd_4c_CmdCancela (fase de eventos), que so chama
    * THIS.Release() com .T.
    *
    * Tres pontos transcritos que o migrador costuma perder (CLAUDE.md
    * regra #21b - a condicao que CERCA a validacao faz parte dela):
    *   1. o filtro eh Empty(Gerado) - conta os NAO confirmados, nao o total;
    *   2. a contagem entra no TEXTO da pergunta;
    *   3. confirmando a saida, o legado REGISTRA o abandono em log antes de
    *      liberar - nao eh "nao faz nada".
    *
    * Cursor de trabalho renomeado de LocalGerado para cursor_4c_NaoGerados
    * (PILAR 3) - nenhum outro metodo do legado o le. O legado o deixa aberto
    * e aqui ele eh fechado: alias de trabalho vazando de um form modal
    * colide com o proximo uso.
    *
    * fGravarLog eh o wrapper de compatibilidade em utils\ (no-op
    * documentado, 5 parametros; o legado chama com 4).
    *
    * PUBLIC: mesma razao de ValidarPedidoSelecionado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSaidaSemConfirmar()
        LOCAL loc_lPodeSair, loc_nFal, loc_cQtd, loc_cDopps, loc_oErro
        loc_lPodeSair = .T.

        TRY
            IF USED("csCabec")
                IF USED("cursor_4c_NaoGerados")
                    USE IN cursor_4c_NaoGerados
                ENDIF

                SELECT Emps, Dopes, Numes ;
                    FROM csCabec ;
                    WHERE EMPTY(Gerado) ;
                    INTO CURSOR cursor_4c_NaoGerados

                loc_nFal = IIF(USED("cursor_4c_NaoGerados"), RECCOUNT("cursor_4c_NaoGerados"), 0)

                IF USED("cursor_4c_NaoGerados")
                    USE IN cursor_4c_NaoGerados
                ENDIF

                SELECT csCabec

                IF loc_nFal > 0
                    loc_cQtd = ALLTRIM(STR(loc_nFal, 10))

                    IF MsgConfirma("Existem " + loc_cQtd + " Opera" + CHR(231) + CHR(245) + "es N" + ;
                            CHR(227) + "o Confirmadas!" + CHR(13) + ;
                            "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
                            "Aten" + CHR(231) + CHR(227) + "o")

                        *-- Usuario confirmou abandonar: registrar o abandono,
                        *-- como o legado faz antes do Release
                        loc_cDopps = ""
                        IF USED("CrSigCdNec")
                            loc_cDopps = TratarNulo(CrSigCdNec.Dopps, "")
                        ENDIF

                        fGravarLog("T", loc_cDopps, "AUTOMATICO", ;
                            "A Gera" + CHR(231) + CHR(227) + "o de " + loc_cQtd + " Opera" + ;
                            CHR(231) + CHR(227) + "o Foi Cancelada Sem Confirma" + CHR(231) + CHR(227) + "o")
                    ELSE
                        *-- Desistiu de sair: a tela continua aberta
                        loc_lPodeSair = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.ValidarSaidaSemConfirmar")
        ENDTRY

        RETURN loc_lPodeSair
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessaPeriodo - transcricao LITERAL de SIGPRGST.processaperiodo (dump
    * legado, Secao 3), cujo corpo inteiro no SCX sao duas linhas:
    *
    *     Lparameters P1, P2, P3  && Rotina Criada Apenas Para Nao Gerar Erro
    *                             && Nas Chamadas do SigMvCab.
    *     Return .t.
    *
    * Nao eh codigo em aberto: o proprio comentario do legado diz que o
    * metodo existe para SATISFAZER UM CONTRATO. O CmdGrava.Click abre a tela
    * de movimentacao passando este form como pai ("Do Form SigMvCab With
    * ..., ThisForm, .f., .t."), e SigMvCab chama ProcessaPeriodo no pai
    * durante o seu proprio fluxo; o pai de verdade (a tela de pedidos) tem
    * uma rotina de periodo, este despachante nao - e devolver .t. eh a
    * resposta correta, porque nao ha periodo a reprocessar depois de gerar o
    * movimento. Copiar o `Return .t.` eh reproduzir a regra, nao adiar
    * trabalho; qualquer calculo inventado aqui seria pior (CLAUDE.md regra
    * #17 - calculo adivinhado grava numero errado em silencio).
    *
    * Omitir o metodo tem efeito concreto: a chamada vinda do form filho
    * estoura "Property PROCESSAPERIODO is not found" em RUNTIME, e nao em
    * compilacao (CLAUDE.md regra #32), bem no meio da gravacao.
    *
    * PUBLIC e com o NOME DO LEGADO (sem prefixo this_/par_ nos parametros
    * sendo a assinatura externa): quem chama eh outro form, por
    * ThisForm.ParentForm.ProcessaPeriodo(...) - renomear quebra a chamada.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessaPeriodo(P1, P2, P3)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - shp_4c_ShpP2 (separador decorativo) + os DOIS
    * botoes reais do legado: cmd_4c_CmdGrava ("Confirmar") e
    * cmd_4c_CmdCancela ("Sair"). Posicoes/icones/caption transcritos do
    * dump (Secao 2: ShpP2/CmdCancela/CmdGrava). Os dois ficam na faixa do
    * cabecalho (Top=3, dentro da Height=80 de cnt_4c_Sombra), como filhos
    * diretos do form - standalone, fora de CommandGroup.
    *
    * Themes = .T. + DisabledPicture obrigatorios em standalone CommandButton
    * com .Picture definido (CorretorAutomatico Pattern #99) - sem isso o
    * icone some quando o botao for desabilitado.
    *
    * Click vinculado por BINDEVENT (CLAUDE.md regra #3 - exige metodo
    * PUBLIC) para BtnConfirmarClick()/BtnSairClick(), implementados na Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_ShpP2", "Shape")
            WITH THIS.shp_4c_ShpP2
                .Top           = 11
                .Left          = 819
                .Width         = 21
                .Height        = 37
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_CmdGrava", "CommandButton")
            WITH THIS.cmd_4c_CmdGrava
                .Top             = 3
                .Left            = 850
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
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

            THIS.AddObject("cmd_4c_CmdCancela", "CommandButton")
            WITH THIS.cmd_4c_CmdCancela
                .Top             = 3
                .Left            = 925
                .Width           = 75
                .Height          = 75
                .Caption         = "Sair"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
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

            BINDEVENT(THIS.cmd_4c_CmdGrava, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(THIS.cmd_4c_CmdCancela, "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - transcricao de SIGPRGST.CmdGrava.Click (dump legado):
    *
    *     Select csCabec
    *     If Eof([csCabec])
    *         =MessageBox([Selecione Um Pedido...], 16, [Atencao!!!])
    *         Return .f.
    *     EndIf
    *     llRet = ThisForm.GerarPedido()
    *     If llRet And Not Empty(csCabec.Gerado)
    *         Do Form SigMvCab With csCabec.GerDopes, csCabec.GerNumes,
    *                               csCabec.GerEmps, .t., 3, ThisForm, .f., .t.
    *     EndIf
    *
    * O guard (Eof) ja esta em ValidarPedidoSelecionado() (Fase 6), que
    * tambem alinha o BO com a linha corrente (SincronizarPedidoCorrente)
    * antes de GerarPedido() ler csCabec. A decisao de abrir a tela de
    * movimentacao usa o MESMO teste do legado - csCabec.Gerado preenchido
    * DEPOIS da chamada, nao this_lGerado do BO - porque csCabec.Gerado fica
    * preenchido tanto quando GerarPedido() acabou de gravar quanto quando o
    * pedido JA estava gerado (GerarPedido() devolve .T. sem fazer nada
    * nesse caso, igual ao "If Empty(csCabec.Gerado) ... EndIf / Return
    * llOks" do legado) - nos dois casos o legado abre SigMvCab para
    * conferencia.
    *
    * Do Form SigMvCab With <8 parametros posicionais> (Dopes/Numes/Emps do
    * movimento gerado, modo Visualizar, ThisForm pai) NAO tem equivalente
    * direto: Formsigmvcab.prg (migracao de SigMvCab) foi migrado como
    * cadastro CRUD autonomo, com Init() sem parametros (lista propria,
    * sem abertura filtrada por chave) - mudar essa assinatura eh trabalho
    * da migracao de SigMvCab, fora do escopo desta fase. Abrir pelo padrao
    * canonico do projeto (CREATEOBJECT + VARTYPE + Show(), sem Release() -
    * FormBase cuida disso) entrega a mesma intencao do legado (deixar o
    * usuario revisar a movimentacao) sem inventar parametros que o form
    * migrado nao suporta.
    *
    * A grade de cabecalho eh repintada apos GerarPedido() para refletir a
    * coluna Confirmacao/realce amarelo (DynamicBackColor, CarregarLista) -
    * REPLACE em csCabec.Gerado acontece no mesmo cursor ja ligado ao grid,
    * entao Refresh() basta, sem precisar reabrir o RecordSource.
    *
    * PUBLIC - BINDEVENT exige metodo publico (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lGerou, loc_oFormMv, loc_oErro

        TRY
            IF THIS.ValidarPedidoSelecionado()
                loc_lGerou = THIS.this_oBusinessObject.GerarPedido()

                IF !loc_lGerou
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao Gerar Pedido")
                ELSE
                    IF USED("csCabec")
                        THIS.grd_4c_GrdCab.Refresh()
                    ENDIF

                    *-- "If llRet And Not Empty(csCabec.Gerado) / Do Form SigMvCab..."
                    IF USED("csCabec") AND !EMPTY(TratarNulo(csCabec.Gerado, ""))
                        loc_oFormMv = CREATEOBJECT("Formsigmvcab")

                        IF VARTYPE(loc_oFormMv) = "O"
                            loc_oFormMv.Show()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - transcricao de SIGPRGST.CmdCancela.Click (dump
    * legado): o guard (contagem de pedidos nao confirmados + confirmacao +
    * log) ja esta inteiro em ValidarSaidaSemConfirmar() (Fase 6) - aqui so
    * resta chamar o guard e, se ele devolver .T., fechar a tela
    * ("ThisForm.Release").
    *
    * PUBLIC - BINDEVENT exige metodo publico (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_oErro

        TRY
            IF THIS.ValidarSaidaSemConfirmar()
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.BtnSairClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (layout.json): cntSombra Top=0, Left=0, Width=1100, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 1100 do dump (que extrapola o Width=1000
    * do proprio form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
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

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
    * eventuais PageFrames filhos) tornando tudo visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
