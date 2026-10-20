*==============================================================================
* ProbeAut644F4.prg - Instancia FormSigOpAut headless (Fase 4 / task644) e
* mede o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto);
*   (2) a grade nasce vinculada: ColumnCount=3, RecordSource, os 3
*       ControlSource e as larguras 17/382/94 do SCX (prova que sobreviveram
*       ao RecordSource, que devolve tudo ao default 90);
*   (3) o CheckBox da Column1 virou CurrentControl, com Sparse=.F. e
*       ReadOnly=.F. - sem isso ele renderiza so na linha corrente ou nao
*       aceita clique;
*   (4) os 3 botoes standalone do legado existem e apontam para arquivo de
*       icone que EXISTE (.Picture inexistente falha em silencio);
*   (5) escopo dos metodos (os chamados de fora tem de ser PUBLIC);
*   (6) RECUPERACAO: derruba o alias da grade como
*       SigOpAutBO.PopularCursorPagamentos() faz (USE IN + CREATE CURSOR),
*       confere que o Grid cai para ColumnCount=0 e que VincularGrade() o
*       reconstroi com o CheckBox de volta. Eh o modo de falha documentado
*       (retangulo branco, sem erro e sem log).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: roda no ramo de ModoTeste do CarregarDados.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_aut644_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd, loc_cPic
loc_cOut = "C:\4c\automation\probe_aut644_f4_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpAutBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpAut.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("FormSigOpAut")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oGrd = loc_oForm.grd_4c_Dados

        *-- (2) Vinculo e geometria das colunas
        STRTOFILE(CHR(13)+CHR(10)+"GRID ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " RecordSourceType=" + TRANSFORM(loc_oGrd.RecordSourceType) + ;
                  " Top=" + TRANSFORM(loc_oGrd.Top) + " Left=" + TRANSFORM(loc_oGrd.Left) + ;
                  " W=" + TRANSFORM(loc_oGrd.Width) + " H=" + TRANSFORM(loc_oGrd.Height) + ;
                  " GridReadOnly=" + TRANSFORM(loc_oGrd.ReadOnly), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"COL1 CS=[" + ALLTRIM(loc_oGrd.Column1.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
                  " Order=" + TRANSFORM(loc_oGrd.Column1.ColumnOrder) + ;
                  " Sparse=" + TRANSFORM(loc_oGrd.Column1.Sparse) + ;
                  " RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
                  " CurrentControl=[" + ALLTRIM(loc_oGrd.Column1.CurrentControl) + "]", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"COL2 CS=[" + ALLTRIM(loc_oGrd.Column2.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column2.Width) + ;
                  " Order=" + TRANSFORM(loc_oGrd.Column2.ColumnOrder) + ;
                  " RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"COL3 CS=[" + ALLTRIM(loc_oGrd.Column3.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column3.Width) + ;
                  " Order=" + TRANSFORM(loc_oGrd.Column3.ColumnOrder) + ;
                  " RO=" + TRANSFORM(loc_oGrd.Column3.ReadOnly), loc_cOut, 1)

        *-- (3) CheckBox da coluna de marcacao
        IF PEMSTATUS(loc_oGrd.Column1, "chk_4c_Marca", 5)
            STRTOFILE(CHR(13)+CHR(10)+"CHK existe=SIM" + ;
                      " Visible=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.Visible) + ;
                      " RO=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.ReadOnly) + ;
                      " Top=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.Top) + ;
                      " Left=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.Left) + ;
                      " H=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.Height) + ;
                      " W=" + TRANSFORM(loc_oGrd.Column1.chk_4c_Marca.Width) + ;
                      " Caption=[" + loc_oGrd.Column1.chk_4c_Marca.Caption + "]", loc_cOut, 1)
        ELSE
            STRTOFILE(CHR(13)+CHR(10)+"CHK existe=NAO", loc_cOut, 1)
        ENDIF

        *-- (4) Botoes standalone e existencia real do arquivo de icone
        loc_cPic = ""
        loc_cPic = loc_cPic + "Grade[" + JUSTFNAME(loc_oForm.cmd_4c_Grade.Picture) + "]=" + ;
                   IIF(FILE(loc_oForm.cmd_4c_Grade.Picture), "OK", "FALTA") + " "
        loc_cPic = loc_cPic + "Imprimir[" + JUSTFNAME(loc_oForm.cmd_4c_Fwbtnm1.Picture) + "]=" + ;
                   IIF(FILE(loc_oForm.cmd_4c_Fwbtnm1.Picture), "OK", "FALTA") + " "
        loc_cPic = loc_cPic + "Sair[" + JUSTFNAME(loc_oForm.cmd_4c_Sair.Picture) + "]=" + ;
                   IIF(FILE(loc_oForm.cmd_4c_Sair.Picture), "OK", "FALTA")
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES " + loc_cPic, loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES POS Grade=" + TRANSFORM(loc_oForm.cmd_4c_Grade.Left) + ;
                  "/" + TRANSFORM(loc_oForm.cmd_4c_Grade.Top) + ;
                  " Imprimir=" + TRANSFORM(loc_oForm.cmd_4c_Fwbtnm1.Left) + ;
                  "/" + TRANSFORM(loc_oForm.cmd_4c_Fwbtnm1.Top) + ;
                  " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Left) + ;
                  "/" + TRANSFORM(loc_oForm.cmd_4c_Sair.Top) + ;
                  " SairCancel=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Cancel) + ;
                  " GradeVisible=" + TRANSFORM(loc_oForm.cmd_4c_Grade.Visible), loc_cOut, 1)

        *-- (5) Escopo (2 = PROTECTED)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO CarregarDados prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarDados",2)) + ;
                  " VincularGrade prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"VincularGrade",2)) + ;
                  " ConfigurarGrid prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConfigurarGrid",2)) + ;
                  " ObterModeloImpressoraFiscal prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ObterModeloImpressoraFiscal",2)), loc_cOut, 1)

        *-- (6) RECUPERACAO apos o alias da grade ser derrubado (o que
        *   PopularCursorPagamentos faz: USE IN + CREATE CURSOR)
        IF USED("cursor_4c_Pagamentos")
            USE IN cursor_4c_Pagamentos
        ENDIF
        CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
        INSERT INTO cursor_4c_Pagamentos (Marca, Obs, Fpags, Printed, Autenticas) ;
            VALUES (.T., "# 001; TESTE", "DINHEIRO", .F., 1)
        INSERT INTO cursor_4c_Pagamentos (Marca, Obs, Fpags, Printed, Autenticas) ;
            VALUES (.T., "# 002", "CHEQUE", .F., 3)
        STRTOFILE(CHR(13)+CHR(10)+"ALIAS DERRUBADO ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"VincularGrade retorno=" + TRANSFORM(loc_oForm.VincularGrade()), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"REVINCULADO ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " Col1CS=[" + ALLTRIM(loc_oGrd.Column1.ControlSource) + "]" + ;
                  " Col1CC=[" + ALLTRIM(loc_oGrd.Column1.CurrentControl) + "]" + ;
                  " ChkExiste=" + TRANSFORM(PEMSTATUS(loc_oGrd.Column1,"chk_4c_Marca",5)) + ;
                  " Col2CS=[" + ALLTRIM(loc_oGrd.Column2.ControlSource) + "]" + ;
                  " Col3CS=[" + ALLTRIM(loc_oGrd.Column3.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column1.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column2.Width) + "/" + TRANSFORM(loc_oGrd.Column3.Width) + ;
                  " Reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Pagamentos")) + ;
                  " Recno=" + TRANSFORM(RECNO("cursor_4c_Pagamentos")), loc_cOut, 1)

        *-- CarregarDados em ModoTeste tem de continuar devolvendo .T.
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(ModoTeste) retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"POS-RELEASE cursorAberto=" + TRANSFORM(USED("cursor_4c_Pagamentos")), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
