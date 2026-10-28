*==============================================================================
* ProbeCgvFormF5.prg - Prova a Fase 5/8 (campos de dados das abas, parte 1) do
* Formsigopcgv (task695). Cobre:
*   1) instanciacao completa (Init -> InicializarForm -> ConfigurarPaginaDados)
*      - prova que todo nome de controle referenciado pelos funis novos existe
*   2) os cursores novos do BO (TmpPar/crTmpTipos/dbAberto/dbDevolvido/
*      DbFollow/DbTitulo/TmpCart/dbEstoque) e os tags de UMA coluna
*   3) os controles das abas 2/3/4/6 e as colunas de cada grade
*   4) o CheckBox da grade de tipos (AddObject + CurrentControl + Sparse)
*   5) escopo dos metodos chamados de fora da classe (PUBLIC)
*   6) FiltrarTipos / AtualizarGrade* / AtualizarAbaResultadoAtiva sem excecao
*   7) os totais da aba Cheques espelhando as properties do BO
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gb_4c_ValidandoUI

#DEFINE OUT "C:\4c\automation\probe_cgvform_f5.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_oAba2, loc_oAba3, loc_oAba4, loc_oAba6
LOCAL loc_nI, loc_cCur, loc_cMet, loc_lOk
LOCAL ARRAY loc_aCur[8], loc_aMet[14]

STRTOFILE("=== PROBE Formsigopcgv - Fase 5/8 (task695) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cgvform_f5.txt"
    gb_4c_ValidandoUI      = .T.
    gc_4c_UsuarioLogado    = "TESTE"
    gnConnHandle           = -1

    IF FILE(gc_4c_ArquivoErroTeste)
        DELETE FILE (gc_4c_ArquivoErroTeste)
    ENDIF

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")               ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")                  ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcgvBO.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopcgv.prg")    ADDITIVE

    *-- ================================================= 1) instanciacao
    loc_oForm = CREATEOBJECT("Formsigopcgv")
    STRTOFILE("1) CREATEOBJECT Formsigopcgv -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", "") + ;
        CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("   *** FALHOU: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_oBO   = loc_oForm.this_oBusinessObject

        *-- O form tem DataSession = 2 (privada): os cursores locais dele NAO
        *-- aparecem na sessao 1 do probe - entrar na sessao do form
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE("   DataSessionId do form = " + TRANSFORM(loc_oForm.DataSessionId) + ;
            CHR(13) + CHR(10), OUT, 1)
        loc_oAba2 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
        loc_oAba3 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
        loc_oAba4 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4
        loc_oAba6 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6

        *-- ============================================= 2) cursores do BO
        loc_aCur[1] = "TmpPar"
        loc_aCur[2] = "crTmpTipos"
        loc_aCur[3] = "dbAberto"
        loc_aCur[4] = "dbDevolvido"
        loc_aCur[5] = "DbFollow"
        loc_aCur[6] = "DbTitulo"
        loc_aCur[7] = "TmpCart"
        loc_aCur[8] = "dbEstoque"

        STRTOFILE(CHR(13) + CHR(10) + "2) cursores locais do BO:" + CHR(13) + CHR(10), OUT, 1)
        FOR loc_nI = 1 TO 8
            loc_cCur = loc_aCur[loc_nI]
            STRTOFILE("   " + PADR(loc_cCur, 14) + " USED=" + ;
                IIF(USED(loc_cCur), "SIM", "NAO") + ;
                IIF(USED(loc_cCur), " campos=" + TRANSFORM(FCOUNT(loc_cCur)), "") + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDFOR

        *-- tags de UMA coluna criados para o SET KEY do filtro de grupo
        STRTOFILE("   TmpPar      TAG Grupos=" + ;
            IIF(TAGNO("Grupos", "", "TmpPar") > 0, "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   dbAberto    TAG Grupos=" + ;
            IIF(TAGNO("Grupos", "", "dbAberto") > 0, "SIM", "NAO") + ;
            " ordem corrente=[" + ORDER("dbAberto") + "]" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   dbDevolvido TAG Grupos=" + ;
            IIF(TAGNO("Grupos", "", "dbDevolvido") > 0, "SIM", "NAO") + ;
            " TAG Cheque=" + IIF(TAGNO("Cheque", "", "dbDevolvido") > 0, "SIM", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   DbFollow    TAG Nums=" + ;
            IIF(TAGNO("Nums", "", "DbFollow") > 0, "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   dbEstoque   TAG Grupos=" + ;
            IIF(TAGNO("Grupos", "", "dbEstoque") > 0, "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)

        *-- ============================================= 3) controles das abas
        STRTOFILE(CHR(13) + CHR(10) + "3) aba 2 (Pendencias): ControlCount=" + ;
            TRANSFORM(loc_oAba2.ControlCount) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   grd_4c_Pendentes=" + ;
            IIF(PEMSTATUS(loc_oAba2, "grd_4c_Pendentes", 5), ;
                "SIM cols=" + TRANSFORM(loc_oAba2.grd_4c_Pendentes.ColumnCount) + ;
                " RS=[" + loc_oAba2.grd_4c_Pendentes.RecordSource + "]", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   grd_4c_TiposPend=" + ;
            IIF(PEMSTATUS(loc_oAba2, "grd_4c_TiposPend", 5), ;
                "SIM cols=" + TRANSFORM(loc_oAba2.grd_4c_TiposPend.ColumnCount) + ;
                " RS=[" + loc_oAba2.grd_4c_TiposPend.RecordSource + "]", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   cbo_4c_GrupoPend=" + ;
            IIF(PEMSTATUS(loc_oAba2, "cbo_4c_GrupoPend", 5), "SIM", "NAO") + ;
            "  txt_4c_TotPend=" + IIF(PEMSTATUS(loc_oAba2, "txt_4c_TotPend", 5), "SIM", "NAO") + ;
            "  cmd_4c_AnexaPend=" + IIF(PEMSTATUS(loc_oAba2, "cmd_4c_AnexaPend", 5), "SIM", "NAO") + ;
            "  cmd_4c_ImpPend=" + IIF(PEMSTATUS(loc_oAba2, "cmd_4c_ImpPend", 5), "SIM", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)

        STRTOFILE(CHR(13) + CHR(10) + "3) aba 3 (Cheques): ControlCount=" + ;
            TRANSFORM(loc_oAba3.ControlCount) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   grd_4c_ChequeAberto=" + ;
            IIF(PEMSTATUS(loc_oAba3, "grd_4c_ChequeAberto", 5), ;
                "SIM cols=" + TRANSFORM(loc_oAba3.grd_4c_ChequeAberto.ColumnCount), "NAO") + ;
            "  Followup=" + IIF(PEMSTATUS(loc_oAba3, "grd_4c_ChequeFollowup", 5), "SIM", "NAO") + ;
            "  Titulo=" + IIF(PEMSTATUS(loc_oAba3, "grd_4c_ChequeTitulo", 5), "SIM", "NAO") + ;
            "  Devolvido=" + IIF(PEMSTATUS(loc_oAba3, "grd_4c_ChequeDevolvido", 5), "SIM", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   totais: LimiteCred=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_LimiteCred", 5), "SIM", "NAO") + ;
            " ChqAVencer=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_ChqAVencer", 5), "SIM", "NAO") + ;
            " ChqVencidos=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_ChqVencidos", 5), "SIM", "NAO") + ;
            " ChqDevolv=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_ChqDevolv", 5), "SIM", "NAO") + ;
            " SaldoCC=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_SaldoCC", 5), "SIM", "NAO") + ;
            " ChqNegoc=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_ChqNegoc", 5), "SIM", "NAO") + ;
            " VlEstoque=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_VlEstoque", 5), "SIM", "NAO") + ;
            " LimiteDisp=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_LimiteDisp", 5), "SIM", "NAO") + ;
            " TotAberto=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_TotChequeAberto", 5), "SIM", "NAO") + ;
            " TotDevolvido=" + IIF(PEMSTATUS(loc_oAba3, "txt_4c_TotDevolvido", 5), "SIM", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)

        STRTOFILE(CHR(13) + CHR(10) + "3) aba 4 (Cartao): ControlCount=" + ;
            TRANSFORM(loc_oAba4.ControlCount) + ;
            "  grd_4c_Cartao=" + IIF(PEMSTATUS(loc_oAba4, "grd_4c_Cartao", 5), ;
                "SIM cols=" + TRANSFORM(loc_oAba4.grd_4c_Cartao.ColumnCount) + ;
                " RS=[" + loc_oAba4.grd_4c_Cartao.RecordSource + "]", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)

        STRTOFILE("3) aba 6 (Estoque): ControlCount=" + ;
            TRANSFORM(loc_oAba6.ControlCount) + ;
            "  grd_4c_Estoque=" + IIF(PEMSTATUS(loc_oAba6, "grd_4c_Estoque", 5), ;
                "SIM cols=" + TRANSFORM(loc_oAba6.grd_4c_Estoque.ColumnCount) + ;
                " RS=[" + loc_oAba6.grd_4c_Estoque.RecordSource + "]", "NAO") + ;
            "  cbo_4c_GrupoEstoque=" + IIF(PEMSTATUS(loc_oAba6, "cbo_4c_GrupoEstoque", 5), "SIM", "NAO") + ;
            CHR(13) + CHR(10), OUT, 1)

        *-- ============================================= 4) CheckBox da grade
        STRTOFILE(CHR(13) + CHR(10) + "4) CheckBox da grade de tipos:" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   Columns(1).chk_4c_TipoPend=" + ;
            IIF(PEMSTATUS(loc_oAba2.grd_4c_TiposPend.Columns(1), "chk_4c_TipoPend", 5), "SIM", "NAO") + ;
            "  CurrentControl=[" + loc_oAba2.grd_4c_TiposPend.Columns(1).CurrentControl + "]" + ;
            "  Sparse=" + TRANSFORM(loc_oAba2.grd_4c_TiposPend.Columns(1).Sparse) + ;
            "  ControlSource=[" + loc_oAba2.grd_4c_TiposPend.Columns(1).ControlSource + "]" + ;
            "  ReadOnly=" + TRANSFORM(loc_oAba2.grd_4c_TiposPend.Columns(1).ReadOnly) + ;
            CHR(13) + CHR(10), OUT, 1)

        *-- ============================================= 5) escopo dos metodos
        loc_aMet[ 1] = "ConfigurarPaginaDados"
        loc_aMet[ 2] = "AtualizarAbaResultadoAtiva"
        loc_aMet[ 3] = "AtualizarGradePendencias"
        loc_aMet[ 4] = "AtualizarGradesCheques"
        loc_aMet[ 5] = "AtualizarGradeCartao"
        loc_aMet[ 6] = "AtualizarGradeEstoque"
        loc_aMet[ 7] = "FiltrarTipos"
        loc_aMet[ 8] = "PreencherTotaisCheques"
        loc_aMet[ 9] = "PreencherComboGrupo"
        loc_aMet[10] = "CarregarAbasResultado"
        loc_aMet[11] = "ChkTipoPendKeyPress"
        loc_aMet[12] = "ChkTipoPendMouseUp"
        loc_aMet[13] = "BtnAnexaPendClick"
        loc_aMet[14] = "BtnImpPendClick"

        STRTOFILE(CHR(13) + CHR(10) + "5) metodos do Form (5=existe, 2=PROTECTED):" + ;
            CHR(13) + CHR(10), OUT, 1)
        FOR loc_nI = 1 TO 14
            loc_cMet = loc_aMet[loc_nI]
            STRTOFILE("   " + PADR(loc_cMet, 28) + ;
                " existe=" + IIF(PEMSTATUS(loc_oForm, loc_cMet, 5), "SIM", "NAO") + ;
                " protected=" + IIF(PEMSTATUS(loc_oForm, loc_cMet, 2), "SIM", "NAO") + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDFOR

        STRTOFILE(CHR(13) + CHR(10) + "5b) metodos do BO (PUBLIC - chamados pelo Form):" + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarParametros   existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarParametros", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarParametros", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarPendencias   existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarPendencias", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarPendencias", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarCheques      existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarCheques", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarCheques", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarCartoes      existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarCartoes", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarCartoes", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarEstoque      existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarEstoque", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarEstoque", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarGruposCursor existe=" + IIF(PEMSTATUS(loc_oBO, "CarregarGruposCursor", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "CarregarGruposCursor", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   TotalPendencias      existe=" + IIF(PEMSTATUS(loc_oBO, "TotalPendencias", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "TotalPendencias", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   ObterCotacao         existe=" + IIF(PEMSTATUS(loc_oBO, "ObterCotacao", 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oBO, "ObterCotacao", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)

        *-- ============================================= 6) funis sem excecao
        STRTOFILE(CHR(13) + CHR(10) + "6) funis de repintura (cursores vazios):" + ;
            CHR(13) + CHR(10), OUT, 1)

        loc_oForm.FiltrarTipos()
        STRTOFILE("   FiltrarTipos OK - TmpPar visiveis=" + TRANSFORM(RECCOUNT("TmpPar")) + ;
            " total=" + TRANSFORM(loc_oAba2.txt_4c_TotPend.Value) + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.AtualizarGradePendencias()
        STRTOFILE("   AtualizarGradePendencias OK" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.AtualizarGradesCheques()
        STRTOFILE("   AtualizarGradesCheques OK" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.AtualizarGradeCartao()
        STRTOFILE("   AtualizarGradeCartao OK" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.AtualizarGradeEstoque()
        STRTOFILE("   AtualizarGradeEstoque OK" + CHR(13) + CHR(10), OUT, 1)

        FOR loc_nI = 1 TO 6
            loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.ActivePage = loc_nI
            loc_oForm.AtualizarAbaResultadoAtiva()
            STRTOFILE("   AtualizarAbaResultadoAtiva(aba " + TRANSFORM(loc_nI) + ") OK" + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDFOR
        loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultado.ActivePage = 1

        *-- toggle do CheckBox por teclado (o caminho do MouseUp delega a ele)
        IF USED("crTmpTipos")
            SELECT crTmpTipos
            INSERT INTO crTmpTipos (Listas, fPags) VALUES (1, "C/Corrente")
            GO TOP
            loc_oForm.ChkTipoPendKeyPress(13, 0)
            STRTOFILE("   ChkTipoPendKeyPress(13,0) -> Listas=" + ;
                TRANSFORM(crTmpTipos.Listas) + " (era 1)" + CHR(13) + CHR(10), OUT, 1)
            loc_oForm.ChkTipoPendMouseUp(1, 0, 0, 0)
            STRTOFILE("   ChkTipoPendMouseUp        -> Listas=" + ;
                TRANSFORM(crTmpTipos.Listas) + " (volta a 1)" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- ============================================= 7) totais espelhados
        loc_oBO.this_nLimiteCredito      = 1000
        loc_oBO.this_nChequesAVencer     = 100
        loc_oBO.this_nChequesVencidos    = 200
        loc_oBO.this_nChequesDevolvidos  = 300
        loc_oBO.this_nSaldoContaCorrente = 400
        loc_oBO.this_nChequesNegociados  = 500
        loc_oBO.this_nValorEstoque       = 600
        loc_oBO.this_nLimiteDisponivel   = -100
        loc_oBO.this_nTotalChequeAberto  = 700
        loc_oBO.this_cMoedaPadrao        = "USD"
        loc_oForm.PreencherTotaisCheques()

        STRTOFILE(CHR(13) + CHR(10) + "7) totais espelhados na aba Cheques:" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   LimiteCred=" + TRANSFORM(loc_oAba3.txt_4c_LimiteCred.Value) + ;
            " ChqAVencer=" + TRANSFORM(loc_oAba3.txt_4c_ChqAVencer.Value) + ;
            " ChqVencidos=" + TRANSFORM(loc_oAba3.txt_4c_ChqVencidos.Value) + ;
            " ChqDevolv=" + TRANSFORM(loc_oAba3.txt_4c_ChqDevolv.Value) + ;
            " SaldoCC=" + TRANSFORM(loc_oAba3.txt_4c_SaldoCC.Value) + ;
            " ChqNegoc=" + TRANSFORM(loc_oAba3.txt_4c_ChqNegoc.Value) + ;
            " VlEstoque=" + TRANSFORM(loc_oAba3.txt_4c_VlEstoque.Value) + ;
            " LimiteDisp=" + TRANSFORM(loc_oAba3.txt_4c_LimiteDisp.Value) + ;
            " TotAberto=" + TRANSFORM(loc_oAba3.txt_4c_TotChequeAberto.Value) + ;
            CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   LimiteDisp.ForeColor=" + TRANSFORM(loc_oAba3.txt_4c_LimiteDisp.ForeColor) + ;
            " (negativo deve ser vermelho = " + TRANSFORM(RGB(255,0,0)) + ")" + ;
            "  MoedaConta=[" + loc_oAba3.lbl_4c_MoedaConta.Caption + "]" + ;
            "  MoedaHist=[" + loc_oAba3.lbl_4c_MoedaHist.Caption + "]" + ;
            CHR(13) + CHR(10), OUT, 1)

        *-- ============================================= 8) troca de pagina
        loc_oForm.AlternarPagina(2)
        STRTOFILE(CHR(13) + CHR(10) + "8) AlternarPagina(2) -> ActivePage=" + ;
            TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " modo=[" + loc_oForm.this_cModoAtual + "]" + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.AlternarPagina(1)
        STRTOFILE("   AlternarPagina(1) -> ActivePage=" + ;
            TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " modo=[" + loc_oForm.this_cModoAtual + "]" + CHR(13) + CHR(10), OUT, 1)

        SET DATASESSION TO 1
        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + "=== FIM SEM EXCECAO ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE(CHR(13) + CHR(10) + "*** EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
        "    Linha : " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
        "    Proc  : " + loc_oE.Procedure + CHR(13) + CHR(10) + ;
        "    Codigo: " + TRANSFORM(loc_oE.ErrorNo) + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(CHR(13) + CHR(10) + "=== gc_4c_ArquivoErroTeste ===" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste), OUT, 1)
ENDIF

QUIT
