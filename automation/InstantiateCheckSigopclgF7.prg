*==============================================================================
* InstantiateCheckSigopclgF7.prg - valida a Fase 7 de Formsigopclg (task703)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA - o que prova que os 4 BINDEVENT novos BINDARAM
*      (delegate inexistente estoura no BIND, dentro do Init, nao no clique);
*   2. estado inicial do Init legado: Page2.Enabled = .F. e ActivePage = 1;
*   3. FormParaBO transfere os 10 filtros da Page1 para o BO (chamado por uma
*      subclasse Probe, porque o hook eh PROTECTED em FormBase e o VFP9 nao
*      deixa a subclasse alargar o escopo);
*   4. DesvincularGradeLog solta a grade SEM perder o ColumnCount, e
*      VincularGradeLog devolve RecordSource/ControlSource/Width/Caption;
*   5. AlternarPagina(2) RESPEITA o guard de this_nQtdeLog = 0 (o legado nao
*      muda de pagina quando a consulta nao devolve linha);
*   6. com linha no cursor: AlternarPagina(2) + RepintarGradeLog posicionam no
*      topo com a Page2 ativa, e GrdDadosAfterRowColChange sincroniza o
*      registro corrente do BO com a linha da grade;
*   7. BtnVoltarClick volta para a pagina de filtros e desliga a Page2
*      (btnDados.Click do legado), sem fechar a tela;
*   8. BtnProcessarClick respeita a recusa da confirmacao (em modo teste
*      MsgConfirma devolve .F.) e NAO troca de pagina;
*   9. BtnEncerrarClick libera a tela (btnSair.Click do legado).
*
* O cursor de resultado vive na datasession PRIVADA do form (DataSession=2),
* por isso o INSERT de teste roda dentro de SET DATASESSION TO
* <form>.DataSessionId - de fora, o alias simplesmente nao existe.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF7, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigopclgf7.txt"
gc_4c_LogF7            = "C:\4c\automation\instantiate_sigopclgf7_result.txt"
gnConnHandle           = 1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF7)
    DELETE FILE (gc_4c_LogF7)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oGrid, loc_nSessaoAnt, loc_oBO
LogP("FASE7 task703 - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopclgBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopclg.prg") ADDITIVE
    LogP("0 setup OK")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 1. Instanciacao (prova que os BINDEVENT bindaram)
TRY
    loc_oForm = CREATEOBJECT("ProbeSigopclgF7")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    LogP("ABORTADO - sem instancia")
    IF FILE(gc_4c_ArquivoErroTeste)
        LogP("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
    ENDIF
    QUIT
ENDIF

loc_oBO   = loc_oForm.this_oBusinessObject
loc_oGrid = loc_oForm.pgf_4c_Paginas.Page2.grd_4c_Dados

*-- 2. Estado inicial do Init legado
TRY
    LogP("2 INICIAL ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Page2.Enabled=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled) + ;
        " (esperado 1 / .F.)")
CATCH TO loc_oErro
    LogP("2 FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 3. Handlers EXISTEM e sao alcancaveis de fora (delegate de BINDEVENT)
TRY
    LogP("3 PEM BtnProcessarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 5)) + ;
        " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + ;
        " BtnVoltarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnVoltarClick", 5)) + ;
        " GrdDadosAfterRowColChange=" + TRANSFORM(PEMSTATUS(loc_oForm, "GrdDadosAfterRowColChange", 5)) + ;
        " | PROTECTED? FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + ;
        " BtnProcessarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 2)))
CATCH TO loc_oErro
    LogP("3 FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 4. FormParaBO: preenche os 10 filtros na tela e confere no BO
TRY
    WITH loc_oForm.pgf_4c_Paginas.Page1
        .txt_4c_UserRede.Value       = "REDE01              "
        .txt_4c_DtIni.Value          = DATE(2026, 1, 1)
        .txt_4c_DtFin.Value          = DATE(2026, 1, 31)
        .txt_4c_HrIni.Value          = "0830"
        .txt_4c_HrFin.Value          = "1745"
        .txt_4c_Prg.Value            = "SIGCDCOR  "
        .cbo_4c_GetOperacao.Value    = "Entrada"
        .txt_4c_UserSis.Value        = "USUSIS01  "
        .txt_4c_Param.Value          = "PAR1      "
        .txt_4c_Trans.Value          = "TRANS-X   "
    ENDWITH

    loc_oForm.ProbeFormParaBO()

    LogP("4 FormParaBO: UserRede=[" + loc_oBO.this_cUserRede + "]" + ;
        " DtIni=[" + DTOC(loc_oBO.this_dDtIni) + "] (" + VARTYPE(loc_oBO.this_dDtIni) + ")" + ;
        " DtFin=[" + DTOC(loc_oBO.this_dDtFin) + "] (" + VARTYPE(loc_oBO.this_dDtFin) + ")" + ;
        " HrIni=[" + loc_oBO.this_cHrIni + "] HrFin=[" + loc_oBO.this_cHrFin + "]" + ;
        " Prg=[" + loc_oBO.this_cPrg + "] Oper=[" + loc_oBO.this_cOperacao + "]" + ;
        " UserSis=[" + loc_oBO.this_cUserSis + "] Param=[" + loc_oBO.this_cParam + "]" + ;
        " Trans=[" + loc_oBO.this_cTrans + "]")
CATCH TO loc_oErro
    LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

*-- 5. Guard de AlternarPagina(2) com this_nQtdeLog = 0
TRY
    loc_oBO.this_nQtdeLog = 0
    loc_oForm.AlternarPagina(2)
    LogP("5 GUARD QtdeLog=0 -> ActivePage=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Page2.Enabled=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled) + ;
        " (esperado 1 / .F. - o legado nao muda de pagina sem linha)")
CATCH TO loc_oErro
    LogP("5 FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 6. Desvincular / Vincular a grade (o que protege do SQLEXEC de BuscarLog)
TRY
    loc_oForm.DesvincularGradeLog()
    LogP("6a DESVINCULADO RecordSource=[" + loc_oGrid.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
        " Col1.ControlSource=[" + loc_oGrid.Column1.ControlSource + "]" + ;
        " (esperado vazio / 7 / vazio)")

    loc_oForm.VincularGradeLog()
    LogP("6b VINCULADO RecordSource=[" + loc_oGrid.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
        " Col1.ControlSource=[" + loc_oGrid.Column1.ControlSource + "]" + ;
        " Col1.Width=" + TRANSFORM(loc_oGrid.Column1.Width) + ;
        " Col1.Header=[" + loc_oGrid.Column1.Header1.Caption + "]" + ;
        " Col5.ControlSource=[" + loc_oGrid.Column5.ControlSource + "]" + ;
        " fwget1.ControlSource=[" + loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Fwget1.ControlSource + "]")
CATCH TO loc_oErro
    LogP("6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

*-- 7. Com LINHA no cursor: troca de pagina + repintura + AfterRowColChange.
*--    O cursor vive na datasession PRIVADA do form (DataSession=2).
TRY
    loc_nSessaoAnt = SET("DATASESSION")
    SET DATASESSION TO loc_oForm.DataSessionId

    INSERT INTO cursor_4c_Log ;
        (cOpers, UsuaRedes, Datars, Horas, Progs, Opers, Usuasis, ;
         Parametros, Transacaos, CVersaos, cidchaves, Copias) ;
        VALUES ("Entrada", "REDE01", DATETIME(2026,1,10,8,31,0), "08:31:00", ;
                "SIGCDCOR", "E", "USUSIS01", "PAR1", "TRANSACAO-LINHA-1", ;
                "9.0.1", "CHAVE000000000000001", "0")

    INSERT INTO cursor_4c_Log ;
        (cOpers, UsuaRedes, Datars, Horas, Progs, Opers, Usuasis, ;
         Parametros, Transacaos, CVersaos, cidchaves, Copias) ;
        VALUES ("Saida", "REDE02", DATETIME(2026,1,11,17,44,0), "17:44:00", ;
                "SIGCDMOE", "S", "USUSIS02", "PAR2", "TRANSACAO-LINHA-2", ;
                "9.0.1", "CHAVE000000000000002", "0")

    SET DATASESSION TO (loc_nSessaoAnt)

    loc_oBO.this_nQtdeLog = 2
    loc_oForm.AlternarPagina(2)
    loc_oForm.RepintarGradeLog()

    SET DATASESSION TO loc_oForm.DataSessionId
    LogP("7a COM LINHA ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Page2.Enabled=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Log")) + ;
        " RECNO=" + TRANSFORM(RECNO("cursor_4c_Log")) + " (esperado 2 / .T. / 2 / 1)")
    SET DATASESSION TO (loc_nSessaoAnt)

    loc_oForm.GrdDadosAfterRowColChange(1)
    LogP("7b AfterRowColChange(1) linha 1 -> BO.this_cTransacaos=[" + ;
        ALLTRIM(loc_oBO.this_cTransacaos) + "]" + ;
        " UsuaRedes=[" + ALLTRIM(loc_oBO.this_cUsuaRedes) + "]" + ;
        " OperacaoDesc=[" + ALLTRIM(loc_oBO.this_cOperacaoDesc) + "]")

    SET DATASESSION TO loc_oForm.DataSessionId
    GO 2 IN cursor_4c_Log
    SET DATASESSION TO (loc_nSessaoAnt)

    loc_oForm.GrdDadosAfterRowColChange(3)
    LogP("7c AfterRowColChange(3) linha 2 -> BO.this_cTransacaos=[" + ;
        ALLTRIM(loc_oBO.this_cTransacaos) + "]" + ;
        " UsuaRedes=[" + ALLTRIM(loc_oBO.this_cUsuaRedes) + "]" + ;
        " OperacaoDesc=[" + ALLTRIM(loc_oBO.this_cOperacaoDesc) + "]")
CATCH TO loc_oErro
    LogP("7 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

*-- 8. BtnVoltarClick (btnDados.Click do legado)
TRY
    loc_oForm.BtnVoltarClick()
    LogP("8 BtnVoltarClick -> ActivePage=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Page2.Enabled=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled) + ;
        " form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + ;
        " (esperado 1 / .F. / .T. - NAO fecha a tela)")
CATCH TO loc_oErro
    LogP("8 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- 9. BtnProcessarClick: em modo teste MsgConfirma devolve .F. (recusa)
TRY
    LogP("9 BtnProcessarClick (confirmacao RECUSADA em modo teste) ret=" + ;
        TRANSFORM(loc_oForm.BtnProcessarClick()) + ;
        " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " RecordSource=[" + loc_oGrid.RecordSource + "]" + ;
        " (esperado .F. / 1 / grade intacta)")
CATCH TO loc_oErro
    LogP("9 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

*-- 10. BtnEncerrarClick (btnSair.Click do legado) - por ultimo, libera a tela
TRY
    loc_oForm.BtnEncerrarClick()
    LogP("10 BtnEncerrarClick -> VARTYPE(form)=" + VARTYPE(loc_oForm) + ;
        " (esperado O apos Release com referencia local, sem erro)")
CATCH TO loc_oErro
    LogP("10 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    LogP("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogP("DIALOGOS: nenhum")
ENDIF
LogP("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogP(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF7, 1)
ENDPROC

*==============================================================================
* ProbeSigopclgF7 - subclasse SO para exercitar o hook PROTECTED FormParaBO
* de dentro da classe (de fora, "Property FORMPARABO is not found").
*==============================================================================
DEFINE CLASS ProbeSigopclgF7 AS Formsigopclg

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

ENDDEFINE
