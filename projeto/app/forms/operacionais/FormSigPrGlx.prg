*==============================================================================
* FormSigPrGlx.prg - Form Operacional: Previa da Globalizacao
* Migrado de: tasks/task618/SigPrGlx.scx (SIGPRGLX)
*
* Processo de globalizacao de saldos de producao: consolida, por
* produto/cor/tamanho, o que esta em Estoque x em Producao x Pedido,
* permite ao usuario redistribuir saldo disponivel (abas de Estoque
* Disponivel/Producao em Fase/Requisicao de material) e, ao confirmar,
* grava os movimentos de transferencia/globalizacao atraves do BO
* (SigPrGlxBO).
*
* Nao segue o padrao Page1=Lista/Page2=Dados de CRUD: o legado tem UM
* unico PageFrame (PageDados) com 6 sub-paginas de fluxo (grade
* principal, selecao de linha/estoque/disponivel/requisicao), navegadas
* por botao (Tabs=.F.), nao por cadastro.
*
* Estrutura ja entregue: DEFINE CLASS, Init, InicializarForm,
* ConfigurarPageFrame (PageFrame com as 6 paginas do legado + cabecalho da
* Page1) e Destroy (Fase 3); grade principal e botoes de acao da Page1
* (Fase 4); grade de selecao, totais, imagem e observacao da Page2
* (Fases 5-6); e, nesta Fase 6, as sub-paginas restantes - Page3 (Totais
* por Linha), Page4 (Selecionar Estoque), Page5 (Disponivel/Tamanho) e
* Page6 (Requisicao Manual de Material), esta ultima com os DOIS unicos
* lookups do form (Column1/Column5 de GradePedra -> SigCdPro, via
* FormBuscaAuxiliar). Os handlers de Click/navegacao e o processamento
* entram nas Fases 7-8.
*==============================================================================

DEFINE CLASS FormSigPrGlx AS FormBase

    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow   = 0
    DataSession  = 2
    ShowWindow = 1
    MaxButton    = .F.
    MinButton    = .F.
    FontName     = "Tahoma"
    FontSize     = 8
    *-- WindowType = 0 na classe (evita timeout em VFP9 -T/harness de teste);
    *-- producao promove para modal (1) no Init, como FormICD/FormHOR/FormGps.
    WindowType   = 0

    *--------------------------------------------------------------------------
    * Parametros recebidos de quem abre a previa - equivalentes ao
    * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
    * _numeroOp, _PorDestino do Init legado. Repassados para o BO em
    * InicializarForm (SigPrGlxBO.this_lReserva/this_nEmphPdr/
    * this_lAutomatico/this_cNumeroDaOp/this_lPorDestino).
    *--------------------------------------------------------------------------
    this_oFormPai      = .NULL.    && thisform.ParentForm (_ParentForm) - de fato FormSigPrGl2 (CREATEOBJECT("FormSigPrGlx", THIS, ...) em FormSigPrGl2.BtnProcessarClick)
    this_dDataAnalise  = {}        && thisform.Data        (_Data) - vestigial: o real 2o parametro enviado por FormSigPrGl2 eh this_nDataSessionId (NUMERICO), nao uma data
    this_lReservaAuto  = .F.       && thisform.Reserva     (_ReservaAuto)
    this_nGerEmphPdr   = 0         && thisform.EmphPdr      (_nGerEmphPdr)
    this_lAutomatico   = .F.       && thisform.Automatico   (_Autom)
    this_nNumeroDaOp   = 0         && thisform.Numerodaop   (_numeroOp) - NUMERICO: FormSigPrGl2.BtnProcessarClick envia VAL(this_cNumeroDaOp)
    this_lPorDestino   = .F.       && thisform.PorDestino   (_PorDestino)

    *-- Guarda de reentrancia dos lookups de produto da Page6: o Show() do
    *-- picker bloqueia, o foco sai e volta da celula da grade e o proprio
    *-- gatilho pode disparar de novo, empilhando um segundo picker.
    this_lLookupEmCurso = .F.

    *-- ThisForm.OldValue do legado - valor da celula ANTES da edicao, usado
    *-- pelos Valid das colunas digitaveis (Page1 e Page2, Column7/Column10)
    *-- para restaurar o conteudo quando a validacao recusa.
    *--
    *-- Tem de ser property do FORM, como no legado: medido no VFP9 em
    *-- 2026-10-06 que NEM Column, NEM Column.Text1, NEM TextBox possuem
    *-- OldValue (PEMSTATUS = .F. nos tres; ler estoura "Property OLDVALUE
    *-- is not found"). O legado captura em "ThisForm.OldValue = This.Value"
    *-- no When de cada coluna; aqui a captura vai no GotFocus das mesmas
    *-- colunas, porque BINDEVENT em "When" nao dispara de forma confiavel
    *-- (regra #3 do CLAUDE.md) e GotFocus tem o mesmo gatilho util: o
    *-- usuario entrou na celula e ainda nao digitou.
    this_nOldValue = 0

    *-- ThisForm.Liberado do legado - gate de UMA edicao da coluna
    *-- "Produzir Estq" (Column8/GradeItens Page1) apos autorizacao de
    *-- BtnAlteraqtdClick (DO FORM SigOpSen). Consumido e desarmado no
    *-- LostFocus da propria coluna.
    this_lLiberadoAlteracao = .F.

    *--------------------------------------------------------------------------
    * Init - recebe os parametros do chamador (equivalente ao Lparameters do
    * legado) e delega o resto para FormBase.Init() (que chama
    * InicializarForm()). Promove WindowType/ShowWindow para modal fora do
    * modo de teste, igual ao padrao FormICD/FormHOR/FormGps.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_dData, par_lReservaAuto, par_nGerEmphPdr, ;
                    par_lAutomatico, par_cNumeroOp, par_lPorDestino

        IF PCOUNT() >= 1
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai

                *-- CRITICO: assume a DataSessionId do pai ANTES do DODEFAULT()
                *-- (que chama InicializarForm()) - sem isto este form abre
                *-- numa sessao privada NOVA e TmpFinal/TmpFinalg (criados por
                *-- FormSigPrGl2BO.ExecutarProcessamento na sessao do PAI)
                *-- ficam invisiveis: a grade principal abriria sempre vazia.
                *-- Mesmo padrao ja adotado em FormSigPrGlp.Init.
                IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
                    THIS.DataSessionId = par_oFormPai.DataSessionId
                ENDIF
            ENDIF
        ENDIF

        *-- par_dData (2o parametro) eh vestigial - o chamador real
        *-- (FormSigPrGl2.BtnProcessarClick) envia this_nDataSessionId
        *-- (NUMERICO), que o Init legado tambem nunca lia. Guardado so
        *-- quando vier DATE/DATETIME de fato (chamada manual/teste).
        IF PCOUNT() >= 2
            IF INLIST(VARTYPE(par_dData), "D", "T")
                THIS.this_dDataAnalise = par_dData
            ENDIF
        ENDIF

        IF PCOUNT() >= 3
            IF VARTYPE(par_lReservaAuto) = "L"
                THIS.this_lReservaAuto = par_lReservaAuto
            ENDIF
        ENDIF

        IF PCOUNT() >= 4
            IF VARTYPE(par_nGerEmphPdr) = "N"
                THIS.this_nGerEmphPdr = par_nGerEmphPdr
            ENDIF
        ENDIF

        IF PCOUNT() >= 5
            IF VARTYPE(par_lAutomatico) = "L"
                THIS.this_lAutomatico = par_lAutomatico
            ENDIF
        ENDIF

        *-- par_cNumeroOp eh NUMERICO no chamador real (VAL(this_cNumeroDaOp))
        IF PCOUNT() >= 6
            IF VARTYPE(par_cNumeroOp) = "N"
                THIS.this_nNumeroDaOp = par_cNumeroOp
            ENDIF
        ENDIF

        IF PCOUNT() >= 7
            IF VARTYPE(par_lPorDestino) = "L"
                THIS.this_lPorDestino = par_lPorDestino
            ENDIF
        ENDIF

        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
        *-- bloqueante). Fora do modo de teste, promove para modal de verdade.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, repassa os parametros
    * recebidos no Init e monta a estrutura visual base (PageFrame + as 6
    * paginas do legado + cabecalho da Page1).
    *--------------------------------------------------------------------------
    *
    * NAO LIGAR "SET EXACT ON" NESTA TELA. Este form tem DataSession = 2,
    * logo nasce com os SETs no default do VFP (EXACT OFF) - e eh disso que
    * TODA a navegacao por item depende. Medido no VFP9 em 2026-10-06, com
    * chave de 22 chars (CPros+CodCors+CodTams) sobre indice de 34:
    *
    *   SET EXACT OFF -> SEEK prefixo = .T.   | SET KEY prefixo -> 1 linha
    *   SET EXACT ON  -> SEEK prefixo = .F.   | SET KEY prefixo -> 0 linhas
    *
    * Com EXACT ON as grades de resumo (cursor_4c_TmpSaldg/cursor_4c_TmpFabr,
    * cujos indices tem Priors/Grupos/Estos/Emps/Nops DEPOIS da chave do
    * item) ficariam PERMANENTEMENTE VAZIAS e os Valid das colunas
    * digitaveis deixariam de achar o saldo - sem erro e sem log. O
    * config.prg liga EXACT ON na sessao 1; esta sessao privada nao herda, e
    * eh justamente o que faz o codigo funcionar igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = IIF(THIS.this_lReservaAuto, ;
            "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
            "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
        THIS.this_cTituloForm = THIS.Caption

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
            loc_lProsseguir = (VARTYPE(THIS.this_oBusinessObject) = "O")

            IF !loc_lProsseguir
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGlxBO.", ;
                        "Erro em InicializarForm")
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_nEmphPdr     = THIS.this_nGerEmphPdr
                THIS.this_oBusinessObject.this_lAutomatico  = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_nNumeroDaOp  = THIS.this_nNumeroDaOp
                THIS.this_oBusinessObject.this_lPorDestino  = THIS.this_lPorDestino

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaTotaisLinha()
                THIS.ConfigurarPaginaEstoque()
                THIS.ConfigurarPaginaTamanhos()
                THIS.ConfigurarPaginaRequisicao()

                THIS.TornarControlesVisiveis(THIS)

                *-- BOParaForm DEPOIS de TornarControlesVisiveis: este ultimo
                *-- forca Visible = .T. em todo controle que nao esteja na
                *-- sua lista de excecao, e eh BOParaForm quem decide a
                *-- visibilidade REAL de Pedras/SelEstoque/Disponivel a
                *-- partir de crSigCdPam/fChecaAcesso - rodar antes faria a
                *-- decisao ser sobrescrita se a lista mudar. Tambem repoe o
                *-- titulo e o rotulo "Periodo: NN meses".
                THIS.BOParaForm()

                *-- Carga da grade principal + filtros relacionais + totais
                *-- (bloco final do Init legado). Em modo de teste/validacao
                *-- de UI nao ha dados do form pai - pular evita o aviso
                *-- "sem dados de globalizacao" num contexto sem usuario.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_1.ActivePage = 1

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - cria o pgf_4c_1 (SIGPRGLX.PageDados no legado)
    * com as 6 paginas originais (Tabs=.F. - navegacao por botao, nao por
    * aba nativa) e o cabecalho (cntSombra do legado), que so existe na
    * Page1. Grid/totais/botoes de cada pagina entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPag1, loc_oCab

        THIS.AddObject("pgf_4c_1", "PageFrame")

        WITH THIS.pgf_4c_1
            .Top       = -27
            .Left      = -1
            .Width     = 804
            .Height    = 635
            .PageCount = 6
            .Tabs      = .F.
        ENDWITH

        *-- Page1: cabecalho (cntSombra legado) - unico container de titulo
        *-- do form; as demais paginas sao sub-telas de selecao/detalhe e nao
        *-- repetem a faixa.
        loc_oPag1 = THIS.pgf_4c_1.Page1

        loc_oPag1.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = loc_oPag1.cnt_4c_Sombra

        WITH loc_oCab
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .SpecialEffect = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize  = .F.
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = ""
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - completa a Page1 (SIGPRGLX.PageDados.Page1 no
    * legado) com a grade principal (GradeItens -> grd_4c_Dados), os 3
    * paineis de resumo (Container3 "Estoque Disponivel"/grupo-conta,
    * Container1 "Estoque Em Producao"/fase, Container5 "Periodo/Referencia
    * Analisada"), a imagem do produto (ImgFigJpg) e os totais gerais da
    * pagina (Tot_Qtd/Tot_Est/Tot_Prz/Tot_prdc/Tot_prze), alem dos botoes de
    * acao/navegacao - todos filhos DIRETOS da Page1 (mapeamento.json:
    * SIGPRGLX.PageDados.Page1.<X>). Posicoes/Top/Left copiadas de
    * tasks/task618/layout.json SEM a compensacao +27 do PageFrame, mesmo
    * padrao ja usado no cnt_4c_Sombra (Fase 3).
    *
    * grd_4c_Dados liga DIRETO em TmpFinalg - cursor da MESMA DataSession
    * privada que FormSigPrGl2BO.ExecutarProcessamento deixa aberto (nome
    * LITERAL, nao cursor_4c_ - regra documentada em
    * FormSigPrGl2.BtnProcessarClick), por isso o Init assume
    * THIS.DataSessionId = par_oFormPai.DataSessionId. Em modo de teste de
    * UI (gb_4c_ValidandoUI), TmpFinalg nao existe - cria-se aqui um
    * cursor de apoio com a MESMA estrutura so para a tela abrir sem erro.
    * cursor_4c_TmpSaldg/cursor_4c_TmpFabr (Container3/Container1) sao os
    * equivalentes migrados de TmpSaldG/TmpFabr - mesma origem compartilhada.
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * this_lPermiteAjustarPrioridade - "If fChecaAcesso('SIGPRGLO',
    * 'PRIORIDADE')" do legado (Init, Container1/Container3.GradeDisp):
    * controla se a coluna Prior das grades de resumo eh editavel e se
    * cmd_4c_SelEstoque fica visivel.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION this_lPermiteAjustarPrioridade()
        RETURN fChecaAcesso("SIGPRGLO", "PRIORIDADE")
    ENDFUNC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oCnt, loc_nCol

        loc_oPag1 = THIS.pgf_4c_1.Page1

        IF !USED("TmpFinalg")
            CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
                Linhas C(10), Qtds N(10,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), ;
                Fabrs N(10,3), Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
                KeySelM L, KeySelMP L, UsuLibs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros
        ENDIF
        IF !USED("cursor_4c_TmpSaldg")
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
                CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
        ENDIF
        IF !USED("cursor_4c_TmpFabr")
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
                CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
            SET NULL OFF
            INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
        ENDIF
        IF !USED("cursor_4c_TmpSaldo")
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
                Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams TAG CPros
        ENDIF
        *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
        *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
        *-- colunas editaveis (Column7 aqui, Column10 na Page2)
        IF !USED("TmpSaldU")
            CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
            INDEX ON Cpros TAG Cpros
        ENDIF

        *-- Grade principal (TmpFinalg) -----------------------------------
        loc_oPag1.AddObject("grd_4c_Dados", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column10.
        loc_oPag1.grd_4c_Dados.RecordSource = ""
        loc_oPag1.grd_4c_Dados.ColumnCount  = 10
        loc_oPag1.grd_4c_Dados.RecordSource = "TmpFinalg"

        WITH loc_oPag1.grd_4c_Dados
            .Top         = 173
            .Left        = 52
            .Width       = 586
            .Height      = 173
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ReadOnly     = .F.

            .Column1.ControlSource = "TmpFinalg.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width = 90
            .Column1.ReadOnly = .T.

            .Column2.ControlSource = "TmpFinalg.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width = 50
            .Column2.ReadOnly = .T.

            .Column3.ControlSource = "TmpFinalg.Flag"
            .Column3.Header1.Caption = ""
            .Column3.Width = 30

            .Column4.ControlSource = "TmpFinalg.Qtds"
            .Column4.Header1.Caption = "N" + CHR(250) + "mero"
            .Column4.Width = 60
            .Column4.ReadOnly = .T.

            .Column5.ControlSource = "TmpFinalg.Saldo"
            .Column5.Header1.Caption = "Qtde Pedido"
            .Column5.Width = 70
            .Column5.ReadOnly = .T.

            .Column6.ControlSource = "TmpFinalg.Produzir"
            .Column6.Header1.Caption = "Produzir"
            .Column6.Width = 70
            .Column6.ReadOnly = .T.

            .Column7.ControlSource = "TmpFinalg.Fabrs"
            .Column7.Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
            .Column7.Width = 80
            .Column7.ReadOnly = .F.
            .Column7.DynamicBackColor = "RGB(255,255,204)"

            .Column8.ControlSource = "TmpFinalg.Produzir2"
            .Column8.Header1.Caption = "Produzir Estq"
            .Column8.Width = 80
            .Column8.ReadOnly = .T.
            .Column8.DynamicForeColor = "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"

            .Column9.ControlSource = "TmpFinalg.CodTams"
            .Column9.Header1.Caption = "Tam"
            .Column9.Width = 40
            .Column9.ReadOnly = .T.

            .Column10.ControlSource = "TmpFinalg.Estoque"
            .Column10.Header1.Caption = "Qtd Estoque"
            .Column10.Width = 76
            .Column10.ReadOnly = .F.
        ENDWITH

        *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
        *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
        *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
        *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
        *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
        *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column9.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        loc_oPag1.grd_4c_Dados.Column3.Text1.ReadOnly = .T.
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column3.Text1, "DblClick", THIS, "GradeItensPage1Column3DblClick")
        *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
        *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col7")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col10")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage1Column7Valid")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GradeItensPage1Column8LostFocus")
        *-- Column10 (Qtd Estoque) eh a SEGUNDA coluna digitavel do legado -
        *-- mesmo par Valid/LostFocus de Column7 (dump 7046-7146)
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage1Column10Valid")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage1AfterRowColChange")

        *-- Container3 "Estoque Disponivel" (grupo/conta, TmpSaldG) --------
        loc_oPag1.AddObject("cnt_4c_Container3", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container3
        WITH loc_oCnt
            .Top = 371
            .Left = 50
            .Width = 363
            .Height = 186
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize = .F.
            .Top = 1
            .Left = 0
            .Width = 363
            .Height = 16
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Estoque Dispon" + CHR(237) + "vel"
        ENDWITH

        loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column6.
        loc_oCnt.grd_4c_DispGrupo.RecordSource = ""
        loc_oCnt.grd_4c_DispGrupo.ColumnCount = 6
        loc_oCnt.grd_4c_DispGrupo.RecordSource = "cursor_4c_TmpSaldg"

        WITH loc_oCnt.grd_4c_DispGrupo
            .Top = 15
            .Left = 3
            .Width = 358
            .Height = 147
            .RecordMark = .F.
            .DeleteMark = .F.
            .ReadOnly = .T.

            *-- Headers transcritos de SIGPRGLX.PageDados.Page1.Container3.
            *-- GradeDisp (dump task618, linhas 1215-1340): "Atual" (Saldo) e
            *-- "Utilizado" (Saldo-Disps) - nao "Saldo"/"Reservado".
            .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
            .Column1.Header1.Caption = "Grupo"
            .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
            .Column2.Header1.Caption = "Conta"
            .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
            .Column3.Header1.Caption = "Atual"
            .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
            .Column4.Header1.Caption = "Utilizado"
            .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
            .Column5.Header1.Caption = "Disponivel"
            .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
            .Column6.Header1.Caption = "Prior"
            .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
        ENDWITH
        BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize = .F.
            .Top = 163
            .Left = 128
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Qtd
            .Top = 161
            .Left = 174
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Est
            .Top = 161
            .Left = 234
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Prz
            .Top = 161
            .Left = 292
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Container1 "Estoque Em Producao" (fase, TmpFabr) ---------------
        loc_oPag1.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container1
        WITH loc_oCnt
            .Top = 371
            .Left = 418
            .Width = 308
            .Height = 136
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label12", "Label")
        WITH loc_oCnt.lbl_4c_label12
            .AutoSize = .F.
            .Top = 1
            .Left = 1
            .Width = 305
            .Height = 16
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH

        loc_oCnt.AddObject("grd_4c_DispFase", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column6.
        loc_oCnt.grd_4c_DispFase.RecordSource = ""
        loc_oCnt.grd_4c_DispFase.ColumnCount = 6
        loc_oCnt.grd_4c_DispFase.RecordSource = "cursor_4c_TmpFabr"

        WITH loc_oCnt.grd_4c_DispFase
            .Top = 15
            .Left = 2
            .Width = 303
            .Height = 99
            .RecordMark = .F.
            .DeleteMark = .F.
            .ReadOnly = .T.

            .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
            .Column1.Header1.Caption = "Fase"
            .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
            .Column2.Header1.Caption = "Quantidade"
            .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
            .Column3.Header1.Caption = "Disponivel"
            .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
            .Column4.Header1.Caption = "Prior"
            .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
            .Column5.ControlSource = ""
            .Column5.Header1.Caption = ""
            .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
            .Column6.Header1.Caption = "Nop"
            .Column6.Visible = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")

        loc_oCnt.AddObject("lbl_4c_label22", "Label")
        WITH loc_oCnt.lbl_4c_label22
            .AutoSize = .F.
            .Top = 115
            .Left = 102
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_tot_qtd2", "TextBox")
        WITH loc_oCnt.txt_4c_tot_qtd2
            .Top = 113
            .Left = 145
            .Width = 61
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_tot_est2", "TextBox")
        WITH loc_oCnt.txt_4c_tot_est2
            .Top = 113
            .Left = 207
            .Width = 61
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Container5 "Periodo/Referencia Analisada" ----------------------
        loc_oPag1.AddObject("cnt_4c_Container5", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container5
        WITH loc_oCnt
            .Top = 129
            .Left = 36
            .Width = 727
            .Height = 40
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LabPeriodo", "Label")
        WITH loc_oCnt.lbl_4c_LabPeriodo
            .AutoSize = .F.
            .Top = 2
            .Left = 8
            .Width = 105
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Per" + CHR(237) + "odo:"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LabProduto", "Label")
        WITH loc_oCnt.lbl_4c_LabProduto
            .AutoSize = .F.
            .Top = 18
            .Left = 8
            .Width = 127
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Refer" + CHR(234) + "ncia Analisada :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oCnt.txt_4c_Cpros
            .Top = 16
            .Left = 141
            .Width = 108
            .Height = 19
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label13", "Label")
        WITH loc_oCnt.lbl_4c_label13
            .AutoSize = .F.
            .Top = 18
            .Left = 269
            .Width = 83
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Qtde Vendida :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Venda
            .Top = 17
            .Left = 349
            .Width = 80
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.TotVenda"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label23", "Label")
        WITH loc_oCnt.lbl_4c_label23
            .AutoSize = .F.
            .Top = 18
            .Left = 448
            .Width = 164
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
        WITH loc_oCnt.txt_4c_Minima
            .Top = 17
            .Left = 623
            .Width = 80
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.QtdMins"
        ENDWITH

        *-- Imagem do produto corrente (SigCdPro.FigJpgs) ------------------
        loc_oPag1.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPag1.img_4c_FigJpg
            .Top = 255
            .Left = 646
            .Width = 122
            .Height = 89
            .Stretch = 1
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")

        *-- Totais gerais da pagina (soma de TmpFinalg) --------------------
        loc_oPag1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag1.lbl_4c_Label1
            .AutoSize = .F.
            .Top = 348
            .Left = 224
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Qtd
            .Top = 346
            .Left = 271
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_prdc", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_prdc
            .Top = 346
            .Left = 339
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Est
            .Top = 346
            .Left = 407
            .Width = 68
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Prz
            .Top = 346
            .Left = 476
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_prze", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_prze
            .Top = 346
            .Left = 543
            .Width = 75
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Botoes de navegacao/acao - filhos diretos da Page1, posicoes do
        *-- legado (tasks/task618/layout.json). Pedras/SelEstoque/Disponivel
        *-- nascem ocultos (Visible=.F. no SCX original); a logica que os
        *-- exibe por tipo de estoque (TipoEstos) e o restante dos Click
        *-- (Processar/TotLinha/Alteraqtd/Pedras/Cancelar) entra na fase de
        *-- eventos/handlers.
        loc_oPag1.AddObject("cmd_4c_Pedras", "CommandButton")
        WITH loc_oPag1.cmd_4c_Pedras
            .Top     = 2
            .Left    = 348
            .Width   = 75
            .Height  = 75
            .Caption = "\<Requisi" + CHR(231) + CHR(245) + "es"
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")

        loc_oPag1.AddObject("cmd_4c_SelEstoque", "CommandButton")
        WITH loc_oPag1.cmd_4c_SelEstoque
            .Top     = 2
            .Left    = 423
            .Width   = 75
            .Height  = 75
            .Caption = "\<Estoques"
            .Visible = THIS.this_lPermiteAjustarPrioridade()
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")

        loc_oPag1.AddObject("cmd_4c_Disponivel", "CommandButton")
        WITH loc_oPag1.cmd_4c_Disponivel
            .Top     = 2
            .Left    = 498
            .Width   = 75
            .Height  = 75
            .Caption = "\<Disponiveis"
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")

        loc_oPag1.AddObject("cmd_4c_TotLinha", "CommandButton")
        WITH loc_oPag1.cmd_4c_TotLinha
            .Top     = 2
            .Left    = 573
            .Width   = 75
            .Height  = 75
            .Caption = "\<Total/Linhas"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")

        loc_oPag1.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPag1.cmd_4c_Processar
            .Top     = 2
            .Left    = 648
            .Width   = 75
            .Height  = 75
            .Caption = "\<Processar"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        loc_oPag1.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPag1.cmd_4c_Cancelar
            .Top     = 2
            .Left    = 723
            .Width   = 75
            .Height  = 75
            .Caption = "Encerrar"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Cancelar, "Click", THIS, "BtnEncerrarClick")

        loc_oPag1.AddObject("cmd_4c_Alteraqtd", "CommandButton")
        WITH loc_oPag1.cmd_4c_Alteraqtd
            .Top     = 189
            .Left    = 687
            .Width   = 40
            .Height  = 40
            .Caption = ""
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Alteraqtd, "Click", THIS, "BtnAlteraqtdClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - completa a Page2 (SIGPRGLX.PageDados.Page2 no
    * legado) com a grade de selecao de linha (GradeItens -> grd_4c_Dados,
    * ligada ao cursor TmpFinal do legado), os totais GERAL (Label1 "Totais :"
    * + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc, azul) e SELECIONADO (Label2 "Qtd
    * Selecionada :" + Tot_sEst/Tot_sPrc, vermelho), a imagem do produto
    * corrente (img_4c_FigJpg), a observacao do item (obj_4c_ObsItens +
    * lbl_4c_Txt_ObsItens) e o botao Cancelar/Voltar - ver
    * tasks/task618/SigPrGlx_form_codigo_fonte.txt linhas 2386-2924.
    *
    * Page2 NAO tem nenhum campo de lookup (F4/fwBuscaExt) no legado - todas
    * as colunas da grade sao ReadOnly (dados ja resolvidos na Page1) ou
    * quantidade editavel validada por faixa (Column7/Column10.Valid, fase
    * de eventos). O unico lookup de todo o form (fwBuscaExt sobre SigCdPro,
    * por Cpros) fica em Page6.GradePedra (Requisicao Manual de Material),
    * montada em ConfigurarPaginaRequisicao(), com os dois lookups da
    * Column1/Column5 completamente implementados.
    *
    * A grade do legado foi desenhada com colunas RENOMEADAS (Column.Name)
    * fora da ordem fisica de criacao - o que importa para a fidelidade
    * visual eh a ORDEM mostrada (ColumnOrder) e nao a ordem de criacao.
    * Aqui os 10 Column1..Column10 ja nascem na ORDEM VISUAL final do
    * legado (Produto/Cor/Tam/Opera??o/N?mero/Quantidade/Estoque/Produzir/
    * Obs/Produ??o), evitando reproduzir o artefato de renomeacao do SCX.
    * Estoque (editavel, fundo amarelo) e Produ??o (editavel, fundo
    * amarelo) sao as 2 colunas que o usuario preenche manualmente - as
    * demais ficam ReadOnly, como no legado.
    *
    * TmpFinal (literal, nao cursor_4c_) eh o cursor de apoio desta grade -
    * a populacao real entra em fase posterior; a estrutura aqui tem de
    * bater exatamente com o que for populado depois (mesma regra do
    * cursor de apoio usada em ConfigurarPaginaLista).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2, loc_nCol

        loc_oPag2 = THIS.pgf_4c_1.Page2

        *-- TmpFinal (literal, nao cursor_4c_) - cursor compartilhado criado
        *-- por FormSigPrGl2BO.ExecutarProcessamento na MESMA DataSession
        *-- (THIS.DataSessionId assumida do pai em Init - ver regra na
        *-- cabeca de ConfigurarPaginaLista). Cursor de apoio so para modo
        *-- de teste de UI, com a MESMA estrutura exportada pelo pai.
        IF !USED("TmpFinal")
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
                Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
                Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
                Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
                ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros
        ENDIF

        *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
        *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
        *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
        loc_oPag2.AddObject("grd_4c_Dados", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column10.
        loc_oPag2.grd_4c_Dados.RecordSource = ""
        loc_oPag2.grd_4c_Dados.ColumnCount  = 10
        loc_oPag2.grd_4c_Dados.RecordSource = "TmpFinal"

        WITH loc_oPag2.grd_4c_Dados
            .Top          = 181
            .Left         = 53
            .Width        = 703
            .Height       = 189
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 17
            .GridLineColor = RGB(238, 238, 238)
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ReadOnly     = .F.

            .Column1.ControlSource = "TmpFinal.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width = 108
            .Column1.ReadOnly = .T.

            .Column2.ControlSource = "TmpFinal.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width = 38
            .Column2.ReadOnly = .T.

            .Column3.ControlSource = "TmpFinal.Dopes"
            .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column3.Width = 150
            .Column3.ReadOnly = .T.

            .Column4.ControlSource = "TmpFinal.Numes"
            .Column4.Header1.Caption = "N" + CHR(250) + "mero"
            .Column4.Width = 47
            .Column4.ReadOnly = .T.

            .Column5.ControlSource = "TmpFinal.Saldo"
            .Column5.Header1.Caption = "Quantidade"
            .Column5.Width = 65
            .Column5.ReadOnly = .T.

            .Column6.ControlSource = "TmpFinal.Produzir"
            .Column6.Header1.Caption = "Produzir"
            .Column6.Width = 65
            .Column6.ReadOnly = .T.

            .Column7.ControlSource = "TmpFinal.Estoque"
            .Column7.Header1.Caption = "Estoque"
            .Column7.Width = 65
            .Column7.ReadOnly = .F.
            .Column7.BackColor = RGB(255, 255, 204)
            .Column7.Text1.FontBold = .T.
            .Column7.Text1.BackColor = RGB(255, 255, 204)

            .Column8.ControlSource = [IIF(!EMPTY(TmpFinal.Obsps), "*", "")]
            .Column8.Header1.Caption = "Obs"
            .Column8.Width = 21
            .Column8.ReadOnly = .T.

            .Column9.ControlSource = "TmpFinal.CodTams"
            .Column9.Header1.Caption = "Tam"
            .Column9.Width = 38
            .Column9.ReadOnly = .T.

            .Column10.ControlSource = "TmpFinal.Fabrs"
            .Column10.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
            .Column10.Width = 65
            .Column10.ReadOnly = .F.
            .Column10.BackColor = RGB(255, 255, 204)
            .Column10.Text1.FontBold = .T.
            .Column10.Text1.BackColor = RGB(255, 255, 204)
        ENDWITH

        *-- Cabecalhos: Tahoma 8, alinhado ao centro, azul - igual ao legado
        *-- em todas as 10 colunas.
        FOR loc_nCol = 1 TO 10
            WITH EVALUATE("loc_oPag2.grd_4c_Dados.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Alignment  = 2
                .ForeColor  = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        FOR loc_nCol = 1 TO 10
            IF !INLIST(loc_nCol, 7, 10)
                BINDEVENT(loc_oPag2.grd_4c_Dados.Columns(loc_nCol).Text1, "GotFocus", THIS, "GradeItensPage2GotFocus")
            ENDIF
        ENDFOR
        *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
        *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col7")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col10")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage2Column7Valid")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage2Column10Valid")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
        BINDEVENT(loc_oPag2.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage2AfterRowColChange")

        *-- Totais (parte 1 de 2 - Label1 + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc,
        *-- total GERAL em azul). Parte 2 (Label2/Tot_sEst/Tot_sPrc = total
        *-- SELECIONADO em vermelho, ImgFigJpg, ObsItens, Txt_ObsItens e o
        *-- botao Cancelar) vem a seguir.
        loc_oPag2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag2.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 372
            .Left      = 403
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Totais :"
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Qtd
            .Top       = 370
            .Left      = 449
            .Width     = 68
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Est
            .Top       = 370
            .Left      = 516
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_prc", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_prc
            .Top       = 370
            .Left      = 581
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Prz
            .Top       = 370
            .Left      = 648
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        *-- Totais (parte 2 de 2) -----------------------------------------
        *-- Label2/Tot_sEst/Tot_sPrc = "Qtd Selecionada" (Estoque/Producao
        *-- somados pelo usuario nas sub-paginas 4/5/6), em VERMELHO para
        *-- destacar do total GERAL (Label1, em azul) acima.
        loc_oPag2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag2.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 164
            .Left      = 383
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtd Selecionada : "
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_sEst", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_sEst
            .Top       = 162
            .Left      = 501
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_sPrc", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_sPrc
            .Top       = 162
            .Left      = 567
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Value     = 0
        ENDWITH

        *-- Imagem do produto da linha corrente (TmpPro.FigJpgs, carregada no
        *-- AfterRowColChange de grd_4c_Dados - fase de eventos). Nasce oculta
        *-- como no legado (Visible=.F.) - so aparece quando ha figura.
        loc_oPag2.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPag2.img_4c_FigJpg
            .Top         = 394
            .Left        = 73
            .Width       = 135
            .Height      = 92
            .Stretch     = 1
            .Visible     = .F.
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
        ENDWITH

        *-- Observacao do item corrente (TmpFinal.Obsps) - EditBox somente
        *-- leitura, com label de titulo que a fase de eventos atualiza com
        *-- o codigo do produto (Txt_ObsItens.Caption, no AfterRowColChange).
        loc_oPag2.AddObject("lbl_4c_Txt_ObsItens", "Label")
        WITH loc_oPag2.lbl_4c_Txt_ObsItens
            .AutoSize  = .F.
            .Top       = 400
            .Left      = 221
            .Width     = 119
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
        ENDWITH

        loc_oPag2.AddObject("obj_4c_ObsItens", "EditBox")
        WITH loc_oPag2.obj_4c_ObsItens
            .Top            = 415
            .Left           = 221
            .Width          = 396
            .Height         = 69
            .ReadOnly       = .T.
            .ControlSource  = "TmpFinal.Obsps"
        ENDWITH

        *-- Cancelar/Voltar da Page2 (volta para a grade principal - Page1 -
        *-- apos validar que Estoque/Producao selecionados fecham com o que
        *-- foi reservado nas sub-paginas; validacao real na fase de eventos).
        loc_oPag2.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPag2.cmd_4c_Cancelar
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarPage2Click")
    ENDPROC


    *--------------------------------------------------------------------------
    * ConfigurarPaginaTotaisLinha - Page3 (SIGPRGLX.PageDados.Page3): grade
    * de totais consolidados por linha de produto (GradeLinhas -> TmpLinha no
    * legado, alimentada pelo Click de cmd_4c_TotLinha). Toda a grade eh
    * somente-leitura no legado (Grid.ReadOnly = .T.), portanto NAO tem
    * lookup - nao ha onde digitar codigo para o picker resolver.
    *
    * Posicoes/Top/Left transcritas da secao "PROPRIEDADES DE:
    * SIGPRGLX.PageDados.Page3.*" do dump legado, SEM compensacao de
    * PageFrame (mesmo criterio das Fases 3-5 deste form, cujo
    * pgf_4c_1.Top = -27 veio cru do SCX).
    *
    * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
    * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
    * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
        LOCAL loc_oPag3, loc_nCol

        loc_oPag3 = THIS.pgf_4c_1.Page3

        WITH loc_oPag3
            .Caption   = "Totais por Linha"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_Linhas")
            CREATE CURSOR cursor_4c_Linhas ;
                (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
                 Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
        ENDIF
        SET NULL OFF

        *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
        loc_oPag3.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag3.lbl_4c_Label2
            .AutoSize   = .F.
            .Top        = 147
            .Left       = 173
            .Width      = 157
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Totais por Linha"
        ENDWITH

        loc_oPag3.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag3.shp_4c_Shape4
            .Top         = 169
            .Left        = 168
            .Width       = 437
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Grade de totais por linha (GradeLinhas / TmpLinha) --------------
        loc_oPag3.AddObject("grd_4c_Linhas", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column5.
        loc_oPag3.grd_4c_Linhas.RecordSource = ""
        loc_oPag3.grd_4c_Linhas.ColumnCount  = 5
        loc_oPag3.grd_4c_Linhas.RecordSource = "cursor_4c_Linhas"

        WITH loc_oPag3.grd_4c_Linhas
            .Top          = 181
            .Left         = 167
            .Width        = 438
            .Height       = 292
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            *-- Grid.ReadOnly propaga para as colunas: tem de vir ANTES delas.
            .ReadOnly     = .T.

            .Column1.ControlSource = "cursor_4c_Linhas.Linhas"
            .Column1.Header1.Caption = "Linha"
            .Column1.Width     = 84
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.ReadOnly  = .T.
            .Column1.ForeColor = RGB(36, 84, 155)

            .Column2.ControlSource = "cursor_4c_Linhas.Saldo"
            .Column2.Header1.Caption = "Quantidade"
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.Sparse    = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.InputMask = "999,999.99"
            .Column2.Text1.MaxLength = 10

            .Column3.ControlSource = "cursor_4c_Linhas.Estoque"
            .Column3.Header1.Caption = "Estoque"
            .Column3.Width     = 80
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.Sparse    = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.InputMask = "999,999.99"
            .Column3.Text1.MaxLength = 10

            .Column4.ControlSource = "cursor_4c_Linhas.Fabrs"
            .Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
            .Column4.Width     = 80
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.Sparse    = .F.
            .Column4.ReadOnly  = .T.
            .Column4.Text1.InputMask = "999,999.99"
            .Column4.Text1.MaxLength = 10

            .Column5.ControlSource = "cursor_4c_Linhas.Produzir"
            .Column5.Header1.Caption = "Produzir"
            .Column5.Width     = 80
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.Sparse    = .F.
            .Column5.ReadOnly  = .T.
            .Column5.Text1.InputMask = "999,999.99"
            .Column5.Text1.MaxLength = 10
        ENDWITH

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag3.grd_4c_Linhas.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- Voltar (CancelaLin) --------------------------------------------
        loc_oPag3.AddObject("cmd_4c_CancelaLin", "CommandButton")
        WITH loc_oPag3.cmd_4c_CancelaLin
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLinClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaEstoque - Page4 (SIGPRGLX.PageDados.Page4, "Selecionar
    * Estoque"): grade de saldo disponivel POR GRUPO/CONTA (GradeDisp ->
    * TmpDisp no legado, montado pelo Click de cmd_4c_SelEstoque a partir de
    * TmpSaldG) mais os totalizadores Qtde Pedida / Qtde Selecionada.
    *
    * No legado as Pages 4 e 5 compartilham o MESMO alias TmpDisp, recriado
    * com estruturas DIFERENTES a cada clique (Page4 traz Grupo/Conta/Prior,
    * Page5 traz Produto/Cor/Tam). Aqui cada grade recebe o SEU cursor
    * (cursor_4c_DispEstoque / cursor_4c_DispTamanho): manter o alias
    * compartilhado obrigaria a derrubar o alias ligado a outra grade, o que
    * zera o ColumnCount dela e a deixa morta pelo resto da vida do form.
    * Divergencia de CODIGO (PILAR 3) - o que o usuario ve eh identico.
    *
    * Unica coluna editavel: "Utilizar" (Column5) - quantidade que o usuario
    * tira daquele grupo/conta. As outras quatro sao ReadOnly no legado,
    * portanto esta pagina nao tem campo de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaEstoque()
        LOCAL loc_oPag4, loc_nCol

        loc_oPag4 = THIS.pgf_4c_1.Page4

        WITH loc_oPag4
            .Caption    = "Selecionar Estoque"
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(0, 128, 192)
            .Enabled    = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_DispEstoque")
            CREATE CURSOR cursor_4c_DispEstoque ;
                (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
                 Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
                 Disps N(12,3) NULL, Utilizar N(12,3) NULL)
        ENDIF
        SET NULL OFF

        *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
        loc_oPag4.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag4.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 138
            .Left       = 197
            .Width      = 184
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Selecionar Estoque"
        ENDWITH

        loc_oPag4.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag4.shp_4c_Shape4
            .Top         = 159
            .Left        = 191
            .Width       = 370
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros -
        *-- mesmo cursor literal usado em grd_4c_Dados.RecordSource da Page1,
        *-- NAO o cursor_4c_Dados renomeado que nunca chegou a existir aqui).
        loc_oPag4.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag4.txt_4c_Cpros
            .Top           = 138
            .Left          = 479
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        *-- Grade de disponivel por grupo/conta (GradeDisp / TmpSaldG) ------
        loc_oPag4.AddObject("grd_4c_DispEstoque", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column5.
        loc_oPag4.grd_4c_DispEstoque.RecordSource = ""
        loc_oPag4.grd_4c_DispEstoque.ColumnCount  = 5
        loc_oPag4.grd_4c_DispEstoque.RecordSource = "cursor_4c_DispEstoque"

        WITH loc_oPag4.grd_4c_DispEstoque
            .Top          = 169
            .Left         = 191
            .Width        = 370
            .Height       = 244
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .Panel        = 1
            *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreveria
            *-- o ReadOnly = .F. da coluna Utilizar.
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.

            .Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
            .Column2.Header1.Caption = "Conta"
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.

            .Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
            .Column3.Header1.Caption = "Prior"
            .Column3.Width     = 24
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.

            .Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
            .Column4.Header1.Caption = "Disponivel"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.

            .Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
            .Column5.Header1.Caption = "Utilizar"
            .Column5.Width     = 75
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
        BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- Totalizadores da selecao ----------------------------------------
        loc_oPag4.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag4.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 418
            .Left      = 220
            .Width     = 82
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Pedida : "
        ENDWITH

        loc_oPag4.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag4.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 437
            .Left      = 192
            .Width     = 110
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Selecionada : "
        ENDWITH

        loc_oPag4.AddObject("txt_4c_Qt_pedida", "TextBox")
        WITH loc_oPag4.txt_4c_Qt_pedida
            .Top       = 413
            .Left      = 312
            .Width     = 67
            .Height    = 23
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag4.AddObject("txt_4c_Qt_Selec", "TextBox")
        WITH loc_oPag4.txt_4c_Qt_Selec
            .Top       = 436
            .Left      = 312
            .Width     = 67
            .Height    = 23
            .Alignment = 3
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        *-- Voltar (CancelaDisp) --------------------------------------------
        loc_oPag4.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag4.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage4Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaTamanhos - Page5 (SIGPRGLX.PageDados.Page5,
    * "Disponivel/Tamanho"): grade do saldo disponivel QUEBRADO POR TAMANHO
    * (GradeDisp -> TmpDisp no legado, montado pelo Click de
    * cmd_4c_Disponivel a partir de TmpSaldo) mais os mesmos totalizadores
    * Qtde Pedida / Qtde Selecionada da Page4.
    *
    * Cursor proprio (cursor_4c_DispTamanho) pelo motivo explicado em
    * ConfigurarPaginaEstoque. Unica coluna editavel: "Utilizar" (Column5) -
    * as demais sao ReadOnly, portanto esta pagina nao tem lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaTamanhos()
        LOCAL loc_oPag5, loc_nCol

        loc_oPag5 = THIS.pgf_4c_1.Page5

        WITH loc_oPag5
            .Caption   = "Disponivel/Tamanho"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_DispTamanho")
            CREATE CURSOR cursor_4c_DispTamanho ;
                (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
                 Disps N(12,3) NULL, Utilizar N(12,3) NULL)
        ENDIF
        SET NULL OFF

        loc_oPag5.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag5.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 150
            .Left       = 246
            .Width      = 205
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Selecionar Tamanhos"
        ENDWITH

        loc_oPag5.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag5.shp_4c_Shape4
            .Top         = 171
            .Left        = 240
            .Width       = 328
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag5.txt_4c_Cpros
            .Top           = 151
            .Left          = 486
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        loc_oPag5.AddObject("grd_4c_DispTamanho", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column5.
        loc_oPag5.grd_4c_DispTamanho.RecordSource = ""
        loc_oPag5.grd_4c_DispTamanho.ColumnCount  = 5
        loc_oPag5.grd_4c_DispTamanho.RecordSource = "cursor_4c_DispTamanho"

        WITH loc_oPag5.grd_4c_DispTamanho
            .Top          = 181
            .Left         = 239
            .Width        = 327
            .Height       = 228
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .Panel        = 1
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.

            .Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width     = 38
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.FontBold = .T.

            .Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
            .Column3.Header1.Caption = "Tam"
            .Column3.Width     = 24
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.FontBold = .T.

            .Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
            .Column4.Header1.Caption = "Disponivel"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.

            .Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
            .Column5.Header1.Caption = "Utilizar"
            .Column5.Width     = 75
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
        BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        loc_oPag5.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag5.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 415
            .Left      = 289
            .Width     = 82
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Pedida : "
        ENDWITH

        loc_oPag5.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag5.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 434
            .Left      = 261
            .Width     = 110
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Selecionada : "
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Qt_pedida", "TextBox")
        WITH loc_oPag5.txt_4c_Qt_pedida
            .Top       = 410
            .Left      = 379
            .Width     = 67
            .Height    = 23
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Qt_Selec", "TextBox")
        WITH loc_oPag5.txt_4c_Qt_Selec
            .Top       = 433
            .Left      = 379
            .Width     = 67
            .Height    = 23
            .Alignment = 3
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag5.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag5.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage5Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaRequisicao - Page6 (SIGPRGLX.PageDados.Page6,
    * "Requisicao"): "Requisicao Manual de Material" (GradePedra -> SelPedra
    * no legado, aberta pelo Click de cmd_4c_Pedras). Esta eh a UNICA pagina
    * do form que tem campo de lookup - as duas colunas de produto
    * (Column1 "Produto" = material requisitado e Column5 "Produto" =
    * material substituto) tem Valid que abre o picker de SigCdPro:
    *
    *   SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid (linha 8093)
    *   SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid (linha 8176)
    *   CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
    *                'CPros', This.Value, 'Selecao', 1000)
    *     -> mAddColuna('CPros','','Codigo') / mAddColuna('DPros','','Descricao')
    *
    * Column2 (Descricao) e Column3 (Uni) sao preenchidas pelo proprio
    * lookup da Column1 (o Replace SelPedra.Dpros/Cunis do legado) e tem
    * When -> Return .f. (nao digitaveis). Column4 (Qtde) e Column5 so
    * aceitam digitacao com a Column1 preenchida - o When do legado eh
    * Return (Not EMPTY(Column1.Text1.Value)), reproduzido como guarda no
    * inicio dos handlers.
    *
    * cursor_4c_Requisicao eh o cursor de apoio de SelPedra; o legado garante
    * ao menos UMA linha em branco (Init: "If Reccount('SelPedra') = 0 /
    * Append Blank"), que eh onde o usuario digita o primeiro material.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaRequisicao()
        LOCAL loc_oPag6, loc_nCol

        loc_oPag6 = THIS.pgf_4c_1.Page6

        WITH loc_oPag6
            .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_Requisicao")
            CREATE CURSOR cursor_4c_Requisicao ;
                (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
                 Qtds N(12,3) NULL, Cpro2s C(14) NULL)
        ENDIF
        SET NULL OFF

        *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
        *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
        *-- digitar o primeiro material.
        IF USED("cursor_4c_Requisicao")
            IF RECCOUNT("cursor_4c_Requisicao") = 0
                SELECT cursor_4c_Requisicao
                APPEND BLANK
                REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
                        Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
                GO TOP IN cursor_4c_Requisicao
            ENDIF
        ENDIF

        *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
        loc_oPag6.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag6.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 168
            .Left       = 132
            .Width      = 294
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
        ENDWITH

        loc_oPag6.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag6.shp_4c_Shape4
            .Top         = 189
            .Left        = 119
            .Width       = 500
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros) --
        loc_oPag6.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag6.txt_4c_Cpros
            .Top           = 169
            .Left          = 487
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        *-- Grade de requisicao manual (GradePedra / SelPedra) --------------
        loc_oPag6.AddObject("grd_4c_Pedra", "Grid")

        *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
        *-- antes de o bloco abaixo acessar .Column1..Column5.
        loc_oPag6.grd_4c_Pedra.RecordSource = ""
        loc_oPag6.grd_4c_Pedra.ColumnCount  = 5
        loc_oPag6.grd_4c_Pedra.RecordSource = "cursor_4c_Requisicao"

        WITH loc_oPag6.grd_4c_Pedra
            .Top          = 197
            .Left         = 119
            .Width        = 500
            .Height       = 261
            .FontSize     = 8
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            *-- Grid.ReadOnly ANTES das colunas: propaga e sobrescreveria o
            *-- ReadOnly = .F. das colunas digitaveis (1, 4 e 5).
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .F.
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.MaxLength   = 14
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
            .Column1.Text1.ToolTipText = "F4 ou duplo clique: buscar produto"

            .Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width     = 200
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.FontBold    = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
            .Column3.Header1.Caption = "Uni"
            .Column3.Width     = 30
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.FontBold    = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
            .Column4.Header1.Caption = "Qtde"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .F.
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
            .Column5.Header1.Caption = "Produto"
            .Column5.Width     = 80
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.MaxLength   = 14
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)
            .Column5.Text1.ToolTipText = "F4 ou duplo clique: buscar produto substituto"
        ENDWITH

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag6.grd_4c_Pedra.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- LOOKUPS -------------------------------------------------------
        *-- Column1.Text1 e Column5.Text1 do legado tem Valid com
        *-- fwBuscaExt sobre SigCdPro. BINDEVENT "Valid" NAO dispara de
        *-- forma confiavel em TextBox (regra #3), entao o gatilho vai no
        *-- KeyPress (ENTER/TAB/F4 - o equivalente a "sair do campo") e no
        *-- DblClick, que eh o atalho canonico de lookup do sistema novo.
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "KeyPress", THIS, "GrdPedraProdutoKeyPress")
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "DblClick", THIS, "GrdPedraProdutoDblClick")

        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "KeyPress", THIS, "GrdPedraSubstitutoKeyPress")
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "DblClick", THIS, "GrdPedraSubstitutoDblClick")

        *-- Voltar (CancelaDisp) --------------------------------------------
        loc_oPag6.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag6.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag6.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage6Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdPedraProdutoKeyPress / GrdPedraProdutoDblClick - gatilhos do lookup
    * do MATERIAL REQUISITADO (GradePedra.Column1.Text1.Valid no legado).
    * PUBLIC (sem PROTECTED): BINDEVENT so enxerga metodo publico.
    * LPARAMETERS obrigatorio - sem ele o primeiro keystroke estoura
    * "No PARAMETER statement is found".
    *--------------------------------------------------------------------------
    PROCEDURE GrdPedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        *-- Guarda obrigatoria: sem ela o picker abriria a CADA tecla
        *-- digitada e o usuario nao conseguiria terminar o codigo.
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoRequisicao()
    ENDPROC

    PROCEDURE GrdPedraProdutoDblClick()
        THIS.AbrirLookupProdutoRequisicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoRequisicao - lookup do material requisitado
    * (Column1 "Produto"), transcrito de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid:
    *
    *   If Not Empty(This.Value)
    *       loLista = CreateObject('fwBuscaExt', ..., 'SigCdPro',
    *                              'crListaRemota', 'CPros', This.Value, 'Selecao', 1000)
    *       If Not loLista.plAchouRegistro
    *           loLista.mAddColuna('CPros','','Codigo')
    *           loLista.mAddColuna('DPros','','Descricao')
    *           loLista.Show()
    *       EndIf
    *       This.Value = CrListaRemota.Cpros
    *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
    *       Use In crListaRemota
    *       ThisForm.PageDados.Page6.GradePedra.Refresh
    *   EndIf
    *
    * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
    * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
    * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
    * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
    * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoRequisicao()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        LOCAL loc_oGrade, loc_oCampo

        IF THIS.this_lLookupEmCurso
            RETURN
        ENDIF
        THIS.this_lLookupEmCurso = .T.

        TRY
            loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
            loc_oCampo = loc_oGrade.Column1.Text1

            *-- Legado: "If Not Empty(This.Value)" - campo vazio nao consulta.
            IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
                loc_cValor = ALLTRIM(loc_oCampo.Value)

                IF USED("cursor_4c_BuscaProduto")
                    USE IN cursor_4c_BuscaProduto
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", ;
                    "cursor_4c_BuscaProduto", ;
                    "CPros", ;
                    loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    *-- this_lAchouRegistro: o Init ja resolveu o match exato
                    *-- (1 registro) - nesse caso o picker NAO deve aparecer.
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    *-- Atribuicao SO sob a guarda de selecao: fora dela, o
                    *-- usuario que desiste do picker teria o campo ZERADO.
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                        IF !EOF("cursor_4c_BuscaProduto")
                            loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)

                            IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
                                REPLACE Cpros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
                                        Dpros WITH TratarNulo(cursor_4c_BuscaProduto.DPros, ""), ;
                                        Cunis WITH TratarNulo(cursor_4c_BuscaProduto.Cunis, "") ;
                                   IN cursor_4c_Requisicao
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_BuscaProduto")
                        USE IN cursor_4c_BuscaProduto
                    ENDIF

                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF

                loc_oGrade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao buscar Produto")
        ENDTRY

        *-- Liberado DEPOIS do ENDTRY para valer tambem quando o CATCH dispara.
        THIS.this_lLookupEmCurso = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdPedraSubstitutoKeyPress / GrdPedraSubstitutoDblClick - gatilhos do
    * lookup do MATERIAL SUBSTITUTO (GradePedra.Column5.Text1.Valid).
    *--------------------------------------------------------------------------
    PROCEDURE GrdPedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoSubstituto()
    ENDPROC

    PROCEDURE GrdPedraSubstitutoDblClick()
        THIS.AbrirLookupProdutoSubstituto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoSubstituto - lookup do material substituto
    * (Column5 "Produto"), transcrito de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid. Igual ao da
    * Column1, SEM o Replace de Dpros/Cunis - o legado so devolve o codigo
    * aqui, porque Descricao/Uni da linha pertencem ao material PRINCIPAL.
    *
    * A guarda inicial reproduz o When do legado
    * (Return (Not EMPTY(...Column1.Text1.Value))): sem material principal
    * digitado, a coluna do substituto nao aceita entrada e, portanto, nao
    * abre o picker.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoSubstituto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        LOCAL loc_oGrade, loc_oCampo

        IF THIS.this_lLookupEmCurso
            RETURN
        ENDIF
        THIS.this_lLookupEmCurso = .T.

        TRY
            loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
            loc_oCampo = loc_oGrade.Column5.Text1

            *-- When do legado: so ha substituto se ha material principal.
            IF EMPTY(loc_oGrade.Column1.Text1.Value)
                MsgAviso("Informe primeiro o Produto da requisi" + CHR(231) + ;
                         CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
                    loc_cValor = ALLTRIM(loc_oCampo.Value)

                    IF USED("cursor_4c_BuscaProduto")
                        USE IN cursor_4c_BuscaProduto
                    ENDIF

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdPro", ;
                        "cursor_4c_BuscaProduto", ;
                        "CPros", ;
                        loc_cValor, ;
                        "Sele" + CHR(231) + CHR(227) + "o")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                            IF !EOF("cursor_4c_BuscaProduto")
                                loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)

                                IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
                                    REPLACE Cpro2s WITH ALLTRIM(cursor_4c_BuscaProduto.CPros) ;
                                       IN cursor_4c_Requisicao
                                ENDIF
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_BuscaProduto")
                            USE IN cursor_4c_BuscaProduto
                        ENDIF

                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF

                    *-- LostFocus do legado: garante sempre UMA linha em branco
                    *-- no fim, para o usuario digitar o proximo material.
                    THIS.GarantirLinhaLivreRequisicao()

                    loc_oGrade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao buscar Produto")
        ENDTRY

        THIS.this_lLookupEmCurso = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
    *
    *   SELECT SelPedra
    *   xPosicao = RECNO()
    *   Locate For Empty(Cpros)
    *   If Eof()
    *       Append Blank
    *   EndIf
    *   Locate for Recno() = xPosicao
    *
    * Mantem sempre ao menos uma linha em branco disponivel na grade e
    * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
    * do legado (que empurra o cursor para a linha de baixo) nao eh
    * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
    * ponto o foco ja voltou do picker e o salto adicional tiraria o
    * usuario da linha que ele acabou de preencher.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
        LOCAL loc_nPosicao

        IF !USED("cursor_4c_Requisicao")
            RETURN
        ENDIF

        SELECT cursor_4c_Requisicao
        loc_nPosicao = RECNO()

        LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
        IF EOF("cursor_4c_Requisicao")
            APPEND BLANK
            REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
                    Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
        ENDIF

        IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
            GOTO loc_nPosicao IN cursor_4c_Requisicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1GotFocus - "GotFocus -> Column7.Text1.SetFocus" das
    * colunas 1/2/4/5/6/9/10 do legado (dump 6730-6793): a grade so tem UMA
    * coluna de entrada de verdade (Fabrs); clicar em qualquer outra
    * redireciona o foco para ela.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1GotFocus()
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * CapturarOldValuePage1 / CapturarOldValuePage2 - "ThisForm.OldValue =
    * This.Value" do When das colunas digitaveis (Page1 e Page2,
    * Column7/Column10). Guardam o valor ANTES da edicao para que o Valid
    * possa restaura-lo quando recusar a entrada.
    *
    * Ligados ao GotFocus (nao ao When): BINDEVENT em "When" de TextBox de
    * Grid nao dispara de forma confiavel (regra #3 do CLAUDE.md), e
    * GotFocus cobre o mesmo instante - a celula acabou de receber o foco e
    * o usuario ainda nao digitou.
    *
    * par_nColuna: 7 ou 10 (a coluna que ganhou o foco).
    *--------------------------------------------------------------------------
    PROCEDURE CapturarOldValuePage1()
        LPARAMETERS par_nColuna

        DO CASE
            CASE par_nColuna = 10
                THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value
            OTHERWISE
                THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.Value
        ENDCASE
    ENDPROC

    PROCEDURE CapturarOldValuePage1Col7()
        THIS.CapturarOldValuePage1(7)
    ENDPROC

    PROCEDURE CapturarOldValuePage1Col10()
        THIS.CapturarOldValuePage1(10)
    ENDPROC

    PROCEDURE CapturarOldValuePage2Col7()
        THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.Value
    ENDPROC

    PROCEDURE CapturarOldValuePage2Col10()
        THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column3DblClick - Column3 (Flag) DblClick/Click do
    * legado (dump 6946-6961): atalho para a pagina de selecao de linha.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column3DblClick()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_1.Page2.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column7Valid - transcricao de GradeItens.Column7.Text1.
    * Valid (dump 6833-6913): valida a quantidade de Fabrs (producao em
    * fase) reservada manualmente para o item corrente e redistribui o
    * saldo em cursor_4c_TmpSaldo/cursor_4c_TmpFabr/TmpFinal.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column7Valid()
        LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk

        loc_oCampo    = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1
        loc_nValorNovo = loc_oCampo.Value

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF
        IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
            IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
                    "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
                    "Confirmar")
                loc_oCampo.Value = THIS.this_nOldValue
                RETURN
            ENDIF
        ENDIF

        loc_lOk = .T.
        DO CASE
            CASE loc_nValorNovo = THIS.this_nOldValue
                * nada a fazer
            CASE loc_nValorNovo < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > TmpFinalg.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Estoque)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
                    "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            OTHERWISE
                IF cursor_4c_TmpSaldo.Fabrs >= loc_nValorNovo
                    REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
                    REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                            QtdMins - Produzir, 0), ;
                            UsuLibs WITH " " IN TmpFinalg

                    REPLACE KeySelmp WITH .F. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldo
                    loc_nXBaixa = Fabrs - DispFs
                    SELECT cursor_4c_TmpFabr
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
                            REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
                            REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
                        ENDIF
                        SELECT cursor_4c_TmpFabr
                    ENDSCAN

                    loc_nXBaixa = loc_nValorNovo
                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Fabrs WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
                            AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa >= 0
                        IF (TmpFinal.Saldo - TmpFinal.Estoque) >= loc_nXBaixa
                            REPLACE TmpFinal.Fabrs WITH TmpFinal.Fabrs + loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Estoque)
                            REPLACE TmpFinal.Fabrs WITH (TmpFinal.Saldo - TmpFinal.Estoque)
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                        SELECT TmpFinal
                    ENDSCAN
                ELSE
                    MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
                        "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        IF !loc_lOk
            loc_oCampo.Value = THIS.this_nOldValue
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.
    * Valid (dump 7046-7128): irma exata da Column7 acima, mas para a
    * quantidade de ESTOQUE (TmpFinalg.Estoque). Redistribui o saldo em
    * cursor_4c_TmpSaldo (Disps) -> cursor_4c_TmpSaldg (Disps por
    * grupo/conta) -> TmpFinal (Estoque linha a linha).
    *
    * Duas diferencas de verbo em relacao a Column7, que vem do legado e NAO
    * sao simetria quebrada por descuido:
    *   - o teto eh (Saldo - Fabrs), nao (Saldo - Estoque);
    *   - no cursor_4c_TmpSaldg o legado SATURA primeiro (Replace Disps With
    *     Saldo While ...) e so depois DESCONTA xBaixa no Scan, enquanto na
    *     Column7 ele ZERA (Replace Disps With 0) e depois SOMA. Transcrito
    *     literalmente (regra #17 do CLAUDE.md).
    *
    * UNICA divergencia consciente: no 5o Case o legado escreve
    * "This.Value = This.Value = Thisform.OldValue" - um typo que avalia a
    * comparacao e grava um LOGICO num campo numerico. Aqui restaura o valor
    * anterior (que eh o que os outros quatro Case fazem e o que o typo
    * claramente pretendia); transcrever o typo gravaria .T./.F. em
    * TmpFinalg.Estoque e estouraria "Data type mismatch".
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column10Valid()
        LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk

        loc_oCampo     = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1
        loc_nValorNovo = loc_oCampo.Value

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF
        IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
            IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
                    "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
                    "Confirmar")
                loc_oCampo.Value = THIS.this_nOldValue
                RETURN
            ENDIF
        ENDIF

        loc_lOk = .T.
        DO CASE
            CASE loc_nValorNovo = THIS.this_nOldValue
                * nada a fazer
            CASE loc_nValorNovo < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > TmpFinalg.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Fabrs)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
                    "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            OTHERWISE
                IF cursor_4c_TmpSaldo.Saldo >= loc_nValorNovo
                    REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
                    REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                            QtdMins - Produzir, 0), ;
                            UsuLibs WITH " " IN TmpFinalg

                    REPLACE KeySelm WITH .F. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldo
                    loc_nXBaixa = Saldo - Disps

                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
                            REPLACE cursor_4c_TmpSaldg.Disps WITH 0
                        ENDIF
                        SELECT cursor_4c_TmpSaldg
                    ENDSCAN

                    loc_nXBaixa = loc_nValorNovo
                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
                            REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs) IN TmpFinal
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                        SELECT TmpFinal
                    ENDSCAN
                ELSE
                    MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
                        "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        IF !loc_lOk
            loc_oCampo.Value = THIS.this_nOldValue
        ENDIF

        SELECT TmpFinalg
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
    * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
    * form esta em modo RESERVA, o item corrente ainda nao tem estoque
    * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
    *
    *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
    *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
    *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
    *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
    *
    * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
    * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de
    * TextBox de Grid nao dispara de forma confiavel (regra #3 do
    * CLAUDE.md) - AfterRowColChange cobre exatamente o mesmo gatilho util,
    * que eh "o item corrente mudou".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarVisibilidadeDisponivel()
        LOCAL loc_nTipoEsto

        THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.

        IF !THIS.this_lReservaAuto
            RETURN
        ENDIF
        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF
        IF TmpFinalg.Estoque != 0
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_nTipoEsto = THIS.this_oBusinessObject.ObterTipoEstoqueProduto(ALLTRIM(TmpFinalg.Cpros))

        IF INLIST(loc_nTipoEsto, 3, 4)
            THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column8LostFocus - desarma o gate de liberacao manual
    * (ThisForm.Liberado = .f. do legado) apos UMA edicao de Column8.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.this_lLiberadoAlteracao = .F.
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1LostFocus - recalcula os totais gerais da Page1
    * (Tot_Qtd/Tot_Est/Tot_prdc/Tot_Prz/Tot_prze), igual ao LostFocus de
    * Column7 no legado (dump 6918-6933) - RECNO salvo/restaurado porque
    * SUM percorre o cursor e deixa o ponteiro em EOF.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.AtualizarTotaisPage1()
    ENDPROC

    PROTECTED PROCEDURE AtualizarTotaisPage1()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze

        IF !USED("TmpFinalg")
            RETURN
        ENDIF

        SELECT TmpFinalg
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
            GOTO loc_nRecno
        ENDIF

        WITH THIS.pgf_4c_1.Page1
            .txt_4c_Tot_Qtd.Value  = loc_nSal
            .txt_4c_Tot_Est.Value  = loc_nEst
            .txt_4c_Tot_prdc.Value = loc_nPrc
            .txt_4c_Tot_Prz.Value  = loc_nPrz
            .txt_4c_Tot_prze.Value = loc_nPrze
            .txt_4c_Tot_Qtd.Refresh()
            .txt_4c_Tot_Est.Refresh()
            .txt_4c_Tot_prdc.Refresh()
            .txt_4c_Tot_Prz.Refresh()
            .txt_4c_Tot_prze.Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1AfterRowColChange - transcricao de GradeItens.
    * AfterRowColChange (dump 6666-6726): ao trocar de linha na grade
    * principal, reposiciona cursor_4c_TmpSaldg/cursor_4c_TmpFabr no
    * produto/cor/tamanho corrente, atualiza os totais dos paineis
    * Container3/Container1 e carrega a imagem do produto.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1AfterRowColChange(par_nColIndex)
        LOCAL loc_cChave, loc_cFiltro, loc_cArquivo, loc_oPag1

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_oPag1 = THIS.pgf_4c_1.Page1
        *-- Chave POSICIONAL: o padding faz parte dela (CPros C(14) +
        *-- CodCors C(4) + CodTams C(4) = 22). ALLTRIM nas partes encurta a
        *-- chave e ela nunca casa (regra #42 do CLAUDE.md).
        loc_cChave = TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams

        = SEEK(loc_cChave, "cursor_4c_TmpSaldo", "CPros")

        *-- As duas grades de resumo tem de mostrar SO as linhas do item
        *-- corrente - o legado faz isso com "Set Key To TmpFinalg.Cpros +
        *-- CodCors + CodTams", REEMITIDO aqui a cada troca de linha (medido
        *-- no VFP9 em 2026-10-06: SET KEY TO <expr> eh ESTATICO, congela a
        *-- faixa no valor do momento e nao reavalia). SEEK no lugar dele
        *-- posicionaria o ponteiro mas deixaria a grade exibindo TODOS os
        *-- produtos.
        *--
        *-- Aqui, porem, NAO se usa SET KEY e sim SET FILTER com "==" e o
        *-- valor EMBUTIDO por macro: a faixa do SET KEY eh parcial (22 chars
        *-- contra indices de 34/47) e faixa parcial fica VAZIA sob
        *-- SET EXACT ON - e a faixa eh avaliada na NAVEGACAO, inclusive no
        *-- desenho do Grid, entao nao ha bloco onde salvar/restaurar o SET.
        *-- Hoje esta sessao nasce com EXACT OFF (DataSession = 2) e SET KEY
        *-- funcionaria, mas seria uma mina: ligar EXACT ON por qualquer
        *-- outro motivo apagaria as duas grades em silencio. "==" eh imune
        *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
        loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"

        SELECT cursor_4c_TmpSaldg
        SET ORDER TO CPros
        SET KEY TO
        SET FILTER TO &loc_cFiltro
        GO TOP

        WITH loc_oPag1.cnt_4c_Container3
            .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
            .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
            .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
            .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
                IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
                IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
            .grd_4c_DispGrupo.Refresh()
            .Visible     = .T.
        ENDWITH

        SELECT cursor_4c_TmpFabr
        SET ORDER TO Cpros
        SET KEY TO
        SET FILTER TO &loc_cFiltro
        GO TOP

        WITH loc_oPag1.cnt_4c_Container1
            .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)
            .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0) - TratarNulo(cursor_4c_TmpSaldo.DispFs, 0)
            .grd_4c_DispFase.Refresh()
            .Visible     = .T.
        ENDWITH

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb_" + SYS(3) + ".jpg"
            loc_oPag1.img_4c_FigJpg.Picture = ""
            loc_oPag1.img_4c_FigJpg.Visible = .F.
            IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros), loc_cArquivo)
                loc_oPag1.img_4c_FigJpg.Picture = loc_cArquivo
                loc_oPag1.img_4c_FigJpg.Visible = .T.
            ENDIF
        ENDIF

        *-- "Disponiveis" eh decidido POR ITEM (When de Column10 no legado)
        THIS.AtualizarVisibilidadeDisponivel()

        SELECT TmpFinalg
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispGrupoColumn6LostFocus / GradeDispFaseColumn4LostFocus -
    * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
    * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispGrupoColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
    ENDPROC

    PROCEDURE GradeDispFaseColumn4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgPage1DblClick - "Do Form SigOpZom" do legado (zoom da
    * imagem). SigOpZom nao foi migrado - ausencia reportada via MsgAviso
    * (regra #27 do CLAUDE.md: ausencia visivel, nunca mascarada), em vez
    * de silenciosamente nao fazer nada.
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgPage1DblClick()
        MsgAviso("Visualiza" + CHR(231) + CHR(227) + "o ampliada da imagem (SigOpZom) " + ;
            "ainda n" + CHR(227) + "o foi portada para o novo sistema.", "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - troca a pagina ativa do pgf_4c_1 (equivalente a
    * ThisForm.PageDados.ActivePage = N do legado, usado por todos os botoes
    * de navegacao entre a grade principal e as sub-paginas de selecao:
    * Disponivel/SelEstoque/Pedras abrem uma pagina de detalhe, Cancela*
    * volta para a Page1). PUBLIC (nao PROTECTED) porque o harness de teste
    * automatizado chama THIS.oForm.AlternarPagina(N) direto de fora da
    * classe (mesma regra de BtnIncluirClick/CarregarLista).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina()
        LPARAMETERS par_nPagina

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= THIS.pgf_4c_1.PageCount
            THIS.pgf_4c_1.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2GotFocus - idem GradeItensPage1GotFocus, mas para a
    * grade de selecao de linha (Page2): toda coluna que nao seja a 7
    * (Estoque) ou a 10 (Produ" + "cao") redireciona para a Column7.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2GotFocus()
        THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2Column7Valid / Column10Valid - transcricao de
    * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
    * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
    * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2Column7Valid()
        LOCAL loc_oCampo, loc_nPSaldo

        loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
        loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value

        IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
            RETURN
        ENDIF

        DO CASE
            CASE loc_oCampo.Value < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > TmpFinal.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > loc_nPSaldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Fabrs)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
        ENDCASE
    ENDPROC

    PROCEDURE GradeItensPage2Column10Valid()
        LOCAL loc_oCampo, loc_nPSaldo

        loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1
        loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value

        IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
            RETURN
        ENDIF

        DO CASE
            CASE loc_oCampo.Value < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > TmpFinal.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > loc_nPSaldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Estoque)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2LostFocus - recalcula Tot_Qtd/Tot_Est/Tot_prc/Tot_Prz
    * da Page2 (dump 7384-7398 / 7504-7517, identicos nas duas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF !USED("TmpFinal")
            RETURN
        ENDIF

        SELECT TmpFinal
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
            GOTO loc_nRecno
        ENDIF

        WITH THIS.pgf_4c_1.Page2
            .txt_4c_Tot_Qtd.Value = loc_nSal
            .txt_4c_Tot_Est.Value = loc_nEst
            .txt_4c_Tot_prc.Value = loc_nPrc
            .txt_4c_Tot_Prz.Value = loc_nPrz
            .txt_4c_Tot_Qtd.Refresh()
            .txt_4c_Tot_Est.Refresh()
            .txt_4c_Tot_prc.Refresh()
            .txt_4c_Tot_Prz.Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2AfterRowColChange - transcricao de GradeItens.
    * AfterRowColChange da Page2 (dump 7251-7279): atualiza o rotulo e a
    * imagem do produto da linha corrente. Usa o MESMO
    * CarregarFotoProduto() do BO ja usado na Page1 (que decodifica o
    * base64 corretamente) em vez do StrToFile direto do legado - o dump da
    * Page2 grava o campo cru, sem o Strconv/Strtran que a Page1 faz, o que
    * geraria um arquivo .jpg invalido.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2AfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_oPag2

        IF !USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        loc_oPag2 = THIS.pgf_4c_1.Page2
        loc_oPag2.obj_4c_ObsItens.Refresh()
        loc_oPag2.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb6_" + SYS(3) + ".jpg"
            loc_oPag2.img_4c_FigJpg.Picture = ""
            loc_oPag2.img_4c_FigJpg.Visible = .F.
            IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinal.Cpros), loc_cArquivo)
                loc_oPag2.img_4c_FigJpg.Picture = loc_cArquivo
                loc_oPag2.img_4c_FigJpg.Visible = .T.
            ENDIF
        ENDIF

        SELECT TmpFinal
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
    * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
    * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
    * disponivel da linha e contra o saldo total ainda nao atendido
    * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispEstoqueColumn5Valid()
        LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno

        loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1

        IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")
            RETURN
        ENDIF

        loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs

        IF loc_oCampo.Value > cursor_4c_DispEstoque.Disps
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF
        IF loc_oCampo.Value < 0
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        loc_nRecno = RECNO("cursor_4c_DispEstoque")
        SELECT cursor_4c_DispEstoque
        SUM Utilizar TO loc_nQtdUti
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
            GOTO loc_nRecno
        ENDIF

        IF loc_nQtdUti > loc_nPSaldo
            MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
        THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
    ENDPROC

    PROCEDURE GradeDispTamanhoColumn5Valid()
        LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno

        loc_oCampo = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1

        IF !USED("cursor_4c_DispTamanho")
            RETURN
        ENDIF

        loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value

        IF loc_oCampo.Value > cursor_4c_DispTamanho.Disps
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        loc_nRecno = RECNO("cursor_4c_DispTamanho")
        SELECT cursor_4c_DispTamanho
        SUM Utilizar TO loc_nQtdUti
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
            GOTO loc_nRecno
        ENDIF

        IF loc_nQtdUti > loc_nPSaldo
            MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
        THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispColumn5LostFocus - "If Lastkey()=13 / Keyboard DNARROW" +
    * Refresh do legado (dump 7790-7795, 8058-7? identico nas duas
    * paginas). O avanco automatico de linha via KEYBOARD nao eh
    * reproduzido (regra geral do projeto contra simular teclado); o
    * Refresh, que corrige o redraw da celula, permanece. BINDEVENT em
    * "LostFocus" nao repassa o controle de origem como parametro -
    * refresca as duas colunas (Page4 e Page5), ambas inofensivas se a
    * pagina correspondente nao estiver ativa.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispColumn5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_DispEstoque", 5)
            THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1.Refresh()
        ENDIF
        IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_DispTamanho", 5)
            THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis todos os controles criados via
    * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame e
    * Controls de Container recursivamente. cmd_4c_Pedras/SelEstoque/
    * Disponivel nascem Visible=.F. no SCX legado (so aparecem conforme o
    * TipoEstos do produto corrente - logica da fase de eventos) e por isso
    * sao filtrados aqui, senao esta rotina reabre os tres incondicionalmente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_PEDRAS", ;
                        "CMD_4C_SELESTOQUE", "CMD_4C_DISPONIVEL", "IMG_4C_FIGJPG")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - "Encerrar" da Page1 (cmd_4c_Cancelar). Fecha a tela;
    * Destroy() ja reabilita o form pai (THIS.this_oFormPai).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarPage2Click - transcricao de Page2.Cancelar.Click (dump
    * 7530-7550): so volta para a Page1 se o total de Estoque/Fabrs
    * distribuido na grade de selecao (TmpFinal) bater com o que
    * TmpFinalg espera para o item corrente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarPage2Click()
        LOCAL loc_nEstoque, loc_nFabrica, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF !USED("TmpFinalg") OR !USED("TmpFinal")
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        loc_nEstoque = TmpFinalg.Estoque
        loc_nFabrica = TmpFinalg.Fabrs

        SELECT TmpFinal
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        GO TOP

        IF loc_nEst != loc_nEstoque
            MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF loc_nPrc != loc_nFabrica
            MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaLinClick - transcricao de Page3.CancelaLin.Click (dump
    * 7562-7572): volta para a Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaLinClick()
        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - transcricao de Page1.TotLinha.Click (dump
    * 6478-6512): monta TmpLinha (totais por Linha + linha "TOTAIS") a
    * partir de TmpFinalg e liga a grade da Page3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick()
        LOCAL loc_oGrid, loc_nCol

        IF !USED("TmpFinalg")
            RETURN
        ENDIF

        IF USED("TmpLinha")
            USE IN TmpLinha
        ENDIF

        SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
                SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
            FROM TmpFinalg GROUP BY 1 ;
            UNION ALL ;
            SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
                SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
            FROM TmpFinalg GROUP BY 1 ;
            INTO CURSOR TmpLinha ORDER BY 2, 1

        loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "TmpLinha"
        loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
        loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
        loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
        loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
        loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"

        *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
        *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
        *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
        *-- ordem de ConfigurarPaginaTotaisLinha.
        loc_oGrid.Column1.Header1.Caption = "Linha"
        loc_oGrid.Column1.Width     = 84
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column1.Resizable = .F.
        loc_oGrid.Column1.Sparse    = .F.
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)

        loc_oGrid.Column2.Header1.Caption = "Quantidade"
        loc_oGrid.Column2.Width     = 80
        loc_oGrid.Column2.Movable   = .F.
        loc_oGrid.Column2.Resizable = .F.
        loc_oGrid.Column2.Sparse    = .F.
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.InputMask = "999,999.99"
        loc_oGrid.Column2.Text1.MaxLength = 10

        loc_oGrid.Column3.Header1.Caption = "Estoque"
        loc_oGrid.Column3.Width     = 80
        loc_oGrid.Column3.Movable   = .F.
        loc_oGrid.Column3.Resizable = .F.
        loc_oGrid.Column3.Sparse    = .F.
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column3.Text1.InputMask = "999,999.99"
        loc_oGrid.Column3.Text1.MaxLength = 10

        loc_oGrid.Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column4.Width     = 80
        loc_oGrid.Column4.Movable   = .F.
        loc_oGrid.Column4.Resizable = .F.
        loc_oGrid.Column4.Sparse    = .F.
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column4.Text1.InputMask = "999,999.99"
        loc_oGrid.Column4.Text1.MaxLength = 10

        loc_oGrid.Column5.Header1.Caption = "Produzir"
        loc_oGrid.Column5.Width     = 80
        loc_oGrid.Column5.Movable   = .F.
        loc_oGrid.Column5.Resizable = .F.
        loc_oGrid.Column5.Sparse    = .F.
        loc_oGrid.Column5.ReadOnly  = .T.
        loc_oGrid.Column5.Text1.InputMask = "999,999.99"
        loc_oGrid.Column5.Text1.MaxLength = 10

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        loc_oGrid.SetAll("DynamicFontBold", [TmpLinha.Linhas = "TOTAIS"], "Column")
        loc_oGrid.SetAll("DynamicForeColor", [IIF(TmpLinha.Linhas = "TOTAIS", RGB(0,0,255), RGB(0,0,0))], "Column")

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .T.
        THIS.AlternarPagina(3)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - transcricao de Page1.SelEstoque.Click (dump
    * 6524-6583): lista o saldo priorizado por grupo/conta do item
    * corrente (cursor_4c_TmpSaldg) na Page4, para o usuario redistribuir a
    * prioridade/uso manualmente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick()
        LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_oGrid

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_cCpro = TmpFinalg.Cpros
        loc_cCor  = TmpFinalg.CodCors
        loc_cTam  = TmpFinalg.CodTams

        IF USED("cursor_4c_DispEstoque")
            THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.RecordSource = ""
            USE IN cursor_4c_DispEstoque
        ENDIF

        SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
            FROM cursor_4c_TmpSaldg ;
            WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
            ORDER BY 1, 2, 3, 4 ;
            INTO CURSOR cursor_4c_DispEstoque READWRITE

        IF RECCOUNT("cursor_4c_DispEstoque") = 0
            MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
        loc_oGrid.ColumnCount = 5
        loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
        loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
        loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
        loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
        loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
        loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"

        *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
        *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
        *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
        loc_oGrid.Column1.Header1.Caption = "Grupo"
        loc_oGrid.Column1.Width     = 80
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column2.Header1.Caption = "Conta"
        loc_oGrid.Column2.Width     = 80
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column3.Header1.Caption = "Prior"
        loc_oGrid.Column3.Width     = 24
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column4.Header1.Caption = "Disponivel"
        loc_oGrid.Column4.Width     = 75
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column5.Header1.Caption = "Utilizar"
        loc_oGrid.Column5.Width     = 75
        loc_oGrid.Column5.ReadOnly  = .F.
        loc_oGrid.Column5.Text1.FontBold = .T.

        WITH THIS.pgf_4c_1.Page4
            .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
            .txt_4c_Qt_Selec.Value  = 0
        ENDWITH
        loc_oGrid.Refresh()

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .T.
        THIS.AlternarPagina(4)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - transcricao de Page1.Disponivel.Click (dump
    * 4487-4550): lista o saldo disponivel do produto/cor corrente
    * QUEBRADO POR TAMANHO (cursor_4c_TmpSaldo) na Page5.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick()
        LOCAL loc_cCpro, loc_cCor, loc_oGrid

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF TmpFinalg.Estoque != 0 OR TmpFinalg.Fabrs != 0
            MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + "o tem estar Zero antes deste Processo!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_cCpro = TmpFinalg.Cpros
        loc_cCor  = TmpFinalg.CodCors

        IF USED("cursor_4c_DispTamanho")
            THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.RecordSource = ""
            USE IN cursor_4c_DispTamanho
        ENDIF

        SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
            FROM cursor_4c_TmpSaldo ;
            WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
            ORDER BY 1, 2, 3 ;
            INTO CURSOR cursor_4c_DispTamanho READWRITE

        IF RECCOUNT("cursor_4c_DispTamanho") = 0
            MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
        loc_oGrid.ColumnCount = 5
        loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
        loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
        loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
        loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
        loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"

        *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
        *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
        *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
        loc_oGrid.Column1.Header1.Caption = "Produto"
        loc_oGrid.Column1.Width     = 80
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column2.Header1.Caption = "Cor"
        loc_oGrid.Column2.Width     = 38
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.FontBold = .T.
        loc_oGrid.Column3.Header1.Caption = "Tam"
        loc_oGrid.Column3.Width     = 24
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column3.Text1.FontBold = .T.
        loc_oGrid.Column4.Header1.Caption = "Disponivel"
        loc_oGrid.Column4.Width     = 75
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column5.Header1.Caption = "Utilizar"
        loc_oGrid.Column5.Width     = 75
        loc_oGrid.Column5.ReadOnly  = .F.
        loc_oGrid.Column5.Text1.FontBold = .T.

        WITH THIS.pgf_4c_1.Page5
            .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
            .txt_4c_Qt_Selec.Value  = 0
        ENDWITH
        loc_oGrid.Refresh()

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .T.
        THIS.AlternarPagina(5)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage4Click - transcricao de Page4.CancelaDisp.Click
    * (dump 7584-7666): devolve o "Utilizar" marcado na grade de
    * grupo/conta para TmpFinalg/cursor_4c_TmpSaldo/cursor_4c_TmpSaldg e
    * TmpFinal, e volta para a Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage4Click()
        LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa

        IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
            SELECT cursor_4c_DispEstoque
            SUM Utilizar TO loc_nQtdUti

            IF loc_nQtdUti > 0
                SELECT cursor_4c_DispEstoque
                SCAN
                    IF cursor_4c_DispEstoque.Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar

                    = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
                        "cursor_4c_TmpSaldo", "CPros")

                    SELECT TmpFinalg
                    REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
                            Estoque  WITH Estoque + loc_nLnQtUtil, ;
                            UsuLibs  WITH " " IN TmpFinalg

                    SELECT cursor_4c_TmpSaldo
                    REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo

                    IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                        INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                    ENDIF
                    REPLACE keySelm WITH .T. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
                        STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
                    REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
                    SELECT cursor_4c_DispEstoque
                ENDSCAN

                = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")

                loc_nXBaixa = TmpFinalg.Estoque
                SELECT TmpFinal
                SET ORDER TO
                SET ORDER TO Cpros
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                        TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
                        AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                    IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
                        REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa
                        loc_nXBaixa = 0
                    ELSE
                        loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
                        REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs)
                    ENDIF
                    REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                    SELECT TmpFinal
                ENDSCAN
            ENDIF
        ENDIF

        THIS.AtualizarTotaisPage1()

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage5Click - transcricao de Page5.CancelaDisp.Click
    * (dump 7835-7959): quebra a linha de TmpFinal/TmpFinalg do
    * produto/cor corrente por TAMANHO, de acordo com o "Utilizar" marcado
    * em cursor_4c_DispTamanho, e reflete a quebra em SigMvIts (tabela
    * real - a linha de origem, sem tamanho definido, eh dividida numa
    * nova linha com o tamanho escolhido).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage5Click()
        LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery

        IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        SELECT TmpFinal
        SET ORDER TO
        loc_nRegFinal = RECNO()

        SELECT cursor_4c_DispTamanho
        SUM Utilizar TO loc_nQtdUti

        IF loc_nQtdUti > 0
            IF USED("Temporario")
                USE IN Temporario
            ENDIF
            SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE

            SELECT cursor_4c_DispTamanho
            SCAN
                IF cursor_4c_DispTamanho.Utilizar = 0
                    LOOP
                ENDIF
                loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar

                = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros")

                SELECT TmpFinal
                SCATTER MEMVAR
                SELECT Temporario
                APPEND BLANK
                GATHER MEMVAR
                REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
                        Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
                        Temporario.Estoque WITH loc_nLnQtUtil, ;
                        Temporario.Produzir WITH 0

                SELECT TmpFinal
                REPLACE TmpFinal.Saldo WITH TmpFinal.Saldo - loc_nLnQtUtil, ;
                        TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nLnQtUtil

                REPLACE Saldo WITH Saldo - loc_nLnQtUtil, Produzir WITH Produzir - loc_nLnQtUtil IN TmpFinalg

                SELECT TmpFinalg
                REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                    QtdMins - Produzir, 0) IN TmpFinalg

                SELECT cursor_4c_TmpSaldo
                REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - loc_nLnQtUtil

                SELECT cursor_4c_TmpSaldg
                SET ORDER TO CPros
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldo.Saldo ;
                    WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                          cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                          cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams

                *-- Divide a linha SEM tamanho de SigMvIts (tabela real) em
                *-- duas: a original com a quantidade restante e uma nova
                *-- com o tamanho escolhido e loc_nLnQtUtil (dump 7896-7916)
                loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                    " AND Citens = " + FormatarNumeroSQL(TmpFinal.Citens, 0) + ;
                    " AND CodCors = " + EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ;
                    " AND CodTams = " + EscaparSQL(SPACE(4))
                IF USED("cursor_4c_MvItsOrig")
                    USE IN cursor_4c_MvItsOrig
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvItsOrig") >= 0 AND ;
                        USED("cursor_4c_MvItsOrig") AND !EOF("cursor_4c_MvItsOrig")

                    IF (cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil) = 0
                        SQLEXEC(gnConnHandle, "DELETE FROM SigMvIts WHERE cIdChaves = " + ;
                            EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET Qtds = " + ;
                            FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
                            ", Aqtds = " + FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
                            " WHERE cIdChaves = " + EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
                    ENDIF

                    SQLEXEC(gnConnHandle, ;
                        "INSERT INTO SigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Aqtds, CodCors, CodTams, QtdEmbs, cIdChaves) " + ;
                        "VALUES (" + FormatarNumeroSQL(cursor_4c_MvItsOrig.Citens, 0) + ", " + ;
                        EscaparSQL(cursor_4c_MvItsOrig.Emps) + ", " + EscaparSQL(cursor_4c_MvItsOrig.Dopes) + ", " + ;
                        FormatarNumeroSQL(cursor_4c_MvItsOrig.Numes, 0) + ", " + ;
                        EscaparSQL(cursor_4c_MvItsOrig.Cpros) + ", " + FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + ;
                        FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + EscaparSQL(cursor_4c_MvItsOrig.CodCors) + ", " + ;
                        EscaparSQL(cursor_4c_DispTamanho.CodTams) + ", 1, " + EscaparSQL(fUniqueIds()) + ")")
                ENDIF
                IF USED("cursor_4c_MvItsOrig")
                    USE IN cursor_4c_MvItsOrig
                ENDIF

                SELECT cursor_4c_DispTamanho
            ENDSCAN

            IF USED("Temporario") AND RECCOUNT("Temporario") > 0
                SELECT TmpFinal
                APPEND FROM DBF("Temporario")
            ENDIF
            IF loc_nRegFinal > 0 AND loc_nRegFinal <= RECCOUNT("TmpFinal")
                GOTO loc_nRegFinal IN TmpFinal
            ENDIF
            IF TmpFinal.Saldo = 0
                SELECT TmpFinal
                DELETE
            ENDIF

            SELECT TmpFinalg
            IF TmpFinalg.Saldo = 0
                DELETE
            ENDIF

            = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
        ENDIF

        THIS.AtualizarTotaisPage1()

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage6Click - "Voltar" da Page6 (Requisicao Manual).
    * NAO existe no legado original (a pagina de requisicao do dump nao
    * tem Cancelar) - segue o mesmo padrao de retorno das outras
    * sub-paginas, canonico do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage6Click()
        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page6.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - transcricao de Page1.Pedras.Click (dump 7216-7239):
    * liga a grade de requisicao manual (SelPedra/cursor_4c_Requisicao) e
    * vai para a Page6.
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick()
        LOCAL loc_oGrid

        loc_oGrid = THIS.pgf_4c_1.Page6.grd_4c_Pedra
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "cursor_4c_Requisicao"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page6.Enabled = .T.
        THIS.AlternarPagina(6)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
    * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
    * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado
    * (ver feedback_sigopsen_ausente_gate_autorizacao) - gate de
    * AUTORIZACAO tratado FAIL-CLOSED: dialogo indisponivel = NAO
    * autorizado, nunca MsgConfirma/skip.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraqtdClick()
        LOCAL loc_cString, loc_cRetorno, loc_lOk, loc_oErro

        IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR TmpFinalg.Produzir2 = 0
            MsgAviso("Refer" + CHR(234) + "ncia Sem Quantidade a Produzir para Estoque!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + ;
            " Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))

        loc_cRetorno = ""
        loc_lOk = .F.
        TRY
            DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
            loc_lOk = (LEFT(TratarNulo(loc_cRetorno, ""), 1) = "*")
        CATCH TO loc_oErro
            MsgErro("Dialogo de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen) indispon" + CHR(237) + "vel - " + ;
                "altera" + CHR(231) + CHR(227) + "o N" + CHR(195) + "O autorizada." + CHR(13) + loc_oErro.Message, ;
                "Erro de Autoriza" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDTRY

        IF !loc_lOk
            MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o autorizada!!!", "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            REPLACE TmpFinalg.UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10) IN TmpFinalg
            THIS.this_lLiberadoAlteracao = .T.
            THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .F.
        ENDIF
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - leva para a tela o que o Init legado lia dos cursores de
    * parametro do sistema (crSigCdPam/CrSigCdPac), hoje carregados uma
    * unica vez em SigPrGlxBO.Init:
    *
    *   Thisform.SigKey = CrSigCdPac.sigKeys                 -> BO.this_cSigKey
    *   lab_periodo.Caption = 'Periodo: '+Alltrim(Str(
    *       CrSigCdPac.nMeses,2))+' meses'                   -> BO.this_nPacNMeses
    *   Pedras.Visible = .f.                                 -> BO.this_cPamDop*
    *   If Not Empty(crSigCdPam.DopEmphs) And Not Empty(DopReqcs)
    *      And Not Empty(DopPedcs) And Not Empty(DopComps)
    *      And Not ThisForm.Reserva -> Pedras.Visible = .t.
    *   SelEstoque.Visible (fChecaAcesso SIGPRGLO/PRIORIDADE)
    *   Caption / lblSombra / lblTitulo (modo Reserva x Globalizacao)
    *
    * PROTECTED EXPLICITO: FormBase ja declara BOParaForm como PROTECTED e
    * o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
    * mentiria para quem le, porque o metodo continua protegido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag1, loc_lTemPedras, loc_oErro

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_1.Page1

            *-- Titulo da tela e os dois labels da faixa do cabecalho
            THIS.Caption = IIF(THIS.this_lReservaAuto, ;
                "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
                "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
            THIS.this_cTituloForm = THIS.Caption
            loc_oPag1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            loc_oPag1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            IF VARTYPE(loc_oBO) = "O"
                *-- "Periodo: NN meses" (SigCdPac.nmeses). O legado monta o
                *-- rotulo INTEIRO aqui; o Caption posto em
                *-- ConfigurarPaginaLista eh so o texto base de projeto.
                loc_oPag1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption = ;
                    "Per" + CHR(237) + "odo: " + ALLTRIM(STR(loc_oBO.this_nPacNMeses, 2)) + " meses"

                *-- "Requisicoes" (cmd_4c_Pedras): so com as QUATRO operacoes
                *-- de requisicao configuradas em SigCdPam e fora do modo
                *-- Reserva.
                loc_lTemPedras = !EMPTY(loc_oBO.this_cPamDopEmphs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopReqcs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopPedcs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopComps) AND ;
                                 !THIS.this_lReservaAuto
                loc_oPag1.cmd_4c_Pedras.Visible = loc_lTemPedras
            ELSE
                loc_oPag1.cmd_4c_Pedras.Visible = .F.
            ENDIF

            *-- "Estoques" (cmd_4c_SelEstoque): mesma condicao de acesso que
            *-- libera a coluna Prior das grades de resumo.
            loc_oPag1.cmd_4c_SelEstoque.Visible = THIS.this_lPermiteAjustarPrioridade()

            *-- "Disponiveis" (cmd_4c_Disponivel) nasce oculto e eh decidido
            *-- por item em AtualizarVisibilidadeDisponivel().
            loc_oPag1.cmd_4c_Disponivel.Visible = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - (re)liga a grade principal da Page1 ao cursor
    * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
    *
    *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
    *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
    *       CodCors+CodTams / Go Top          (filtro relacional por item)
    *   Select TmpFabr  / idem
    *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
    *   ThisForm.pageDados.Page1.GradeItens.Setfocus
    *
    * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
    * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
    * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
    * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
    * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
    * grade viraria "Column1/Column2" generica e editavel. Por isso a
    * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
    *
    * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
    * repinta a grade sozinho).
    *
    * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
    * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
    * de fora da classe (regra #3 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("TmpFinalg")
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;
                    "o para exibir - reprocesse a gera" + CHR(231) + CHR(227) + "o de O.P.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oGrid = THIS.pgf_4c_1.Page1.grd_4c_Dados

                *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de
                *-- existir antes do bloco abaixo acessar .Column1..Column10
                *-- (mesmo padrao usado no restante deste form).
                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 10
                loc_oGrid.RecordSource = "TmpFinalg"

                WITH loc_oGrid
                    .Column1.ControlSource  = "TmpFinalg.Cpros"
                    .Column2.ControlSource  = "TmpFinalg.CodCors"
                    .Column3.ControlSource  = "TmpFinalg.Flag"
                    .Column4.ControlSource  = "TmpFinalg.Qtds"
                    .Column5.ControlSource  = "TmpFinalg.Saldo"
                    .Column6.ControlSource  = "TmpFinalg.Produzir"
                    .Column7.ControlSource  = "TmpFinalg.Fabrs"
                    .Column8.ControlSource  = "TmpFinalg.Produzir2"
                    .Column9.ControlSource  = "TmpFinalg.CodTams"
                    .Column10.ControlSource = "TmpFinalg.Estoque"

                    *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
                    *-- a fonte do Grid recalcula toda largura para o default.
                    .Column1.Width  = 90
                    .Column2.Width  = 50
                    .Column3.Width  = 30
                    .Column4.Width  = 60
                    .Column5.Width  = 70
                    .Column6.Width  = 70
                    .Column7.Width  = 80
                    .Column8.Width  = 80
                    .Column9.Width  = 40
                    .Column10.Width = 76

                    .Column1.Header1.Caption  = "Produto"
                    .Column2.Header1.Caption  = "Cor"
                    .Column3.Header1.Caption  = ""
                    .Column4.Header1.Caption  = "N" + CHR(250) + "mero"
                    .Column5.Header1.Caption  = "Qtde Pedido"
                    .Column6.Header1.Caption  = "Produzir"
                    .Column7.Header1.Caption  = "Qtd Produ" + CHR(231) + CHR(227) + "o"
                    .Column8.Header1.Caption  = "Produzir Estq"
                    .Column9.Header1.Caption  = "Tam"
                    .Column10.Header1.Caption = "Qtd Estoque"

                    *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid
                    *-- propaga para as colunas e sobrescreveria): so Fabrs
                    *-- (7) e Estoque (10) sao digitaveis no legado.
                    .ReadOnly = .F.
                    .Column1.ReadOnly  = .T.
                    .Column2.ReadOnly  = .T.
                    .Column3.ReadOnly  = .T.
                    .Column4.ReadOnly  = .T.
                    .Column5.ReadOnly  = .T.
                    .Column6.ReadOnly  = .T.
                    .Column7.ReadOnly  = .F.
                    .Column8.ReadOnly  = .T.
                    .Column9.ReadOnly  = .T.
                    .Column10.ReadOnly = .F.

                    .Column7.DynamicBackColor = "RGB(255,255,204)"
                    .Column8.DynamicForeColor = ;
                        "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
                ENDWITH

                SELECT TmpFinalg
                GO TOP

                *-- Ordem das grades de resumo (Set Order To Cpros do Init
                *-- legado). O FILTRO por item corrente NAO vem aqui: eh
                *-- GradeItensPage1AfterRowColChange quem o aplica, e ele eh
                *-- chamado no fim deste metodo para a primeira linha - uma
                *-- fonte unica, em vez de duas copias para divergirem.
                IF USED("cursor_4c_TmpSaldg")
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                ENDIF
                IF USED("cursor_4c_TmpFabr")
                    SELECT cursor_4c_TmpFabr
                    SET ORDER TO Cpros
                ENDIF

                SELECT TmpFinalg
                GO TOP
                loc_oGrid.Refresh()

                *-- Totais gerais e paineis/imagem do primeiro item
                THIS.AtualizarTotaisPage1()
                THIS.AtualizarVisibilidadeDisponivel()
                IF !EOF("TmpFinalg")
                    THIS.GradeItensPage1AfterRowColChange(1)
                ENDIF

                SELECT TmpFinalg
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - repassa a Processar() os dois campos que o Init legado
    * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.
    * Cnt_Previsao.GetPrevisao/GetGeracao). THIS.this_oFormPai eh o
    * FormSigPrGl2 (pai direto); THIS.this_oFormPai.this_oParentForm eh o
    * FormSigPrGlo (avo, "Processamento de O.P."). Mesmo padrao ja adotado
    * em FormSigPrGlp.FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oGlo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                loc_oGlo = .NULL.
                IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "this_oParentForm", 5)
                    IF VARTYPE(THIS.this_oFormPai.this_oParentForm) = "O"
                        loc_oGlo = THIS.this_oFormPai.this_oParentForm
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oGlo) = "O" AND PEMSTATUS(loc_oGlo, "cnt_4c_Previsao", 5)
                    THIS.this_oBusinessObject.this_dPrevisao    = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
                    THIS.this_oBusinessObject.this_dDataGeracao = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
                ELSE
                    *-- Sem o form avo (ex.: teste direto desta tela), usa a
                    *-- data de hoje para ambos - nunca deixa {} (gravaria
                    *-- a O.P. com data em branco)
                    THIS.this_oBusinessObject.this_dPrevisao    = DATE()
                    THIS.this_oBusinessObject.this_dDataGeracao = DATE()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - "Processar" da Page1 (dump 4562-6466). So
    * ORQUESTRA: repassa ao BO os parametros que o Init legado lia do form
    * avo (FormParaBO) e delega toda a gravacao a SigPrGlxBO.Processar().
    * "Do Form SigReGli" do fecho legado NAO foi migrado - mostra o numero
    * da O.P. via MsgInfo e fecha esta tela, mesmo padrao de
    * FormSigPrGlp.BtnProcessarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.FormParaBO()
                    THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled    = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled   = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled   = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled     = .F.

                    loc_lSucesso = THIS.this_oBusinessObject.Processar()

                    IF loc_lSucesso
                        MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
                            "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
                            " gerada.", "Confirmar")
                        loc_lFechar = .T.
                    ELSE
                        THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled  = .T.
                        THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled = THIS.this_lPermiteAjustarPrioridade()
                        THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled = .T.
                        THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled   = .T.

                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (padrao do Cancelar.Click legado: a
    * previa eh modeless-sobre-pai, nao modal de verdade, entao quem fecha
    * precisa devolver o Enabled do pai manualmente).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
