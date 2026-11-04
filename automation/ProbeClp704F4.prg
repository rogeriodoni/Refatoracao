*==============================================================================
* ProbeClp704F4.prg - Instancia FormSigOpClp headless (Fase 4 / task704) e mede
* o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto) SEM o cursor do
*       form pai - caminho de validacao de UI / teste automatizado;
*   (2) nesse caminho a grade nasce com as 7 colunas JA formatadas (larguras
*       31/70/150/75/98/72/35, ColumnOrder 1/3/2/5/6/4/7 e os cabecalhos do
*       SCX), e NAO com 7 colunas de 90px e cabecalho "Column1";
*   (3) com o cursor do contrato presente, CarregarLista() devolve .T., liga
*       RecordSource + os 7 ControlSource e as larguras/cabecalhos SOBREVIVEM
*       ao bind (atribuir RecordSource devolve tudo ao default 90 - este eh o
*       ponto do metodo);
*   (4) escopo dos metodos chamados de fora tem de ser PUBLIC (PEMSTATUS ,2);
*   (5) o botao Encerrar existe e aponta para arquivo de icone que EXISTE
*       (.Picture inexistente falha em silencio).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: a tela nao consulta banco, exibe cursor do pai.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_clp704_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd, loc_lLigou, loc_cPic
loc_cOut = "C:\4c\automation\probe_clp704_f4_result.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpClpBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpClp.prg") ADDITIVE
    STRTOFILE(CHR(13) + CHR(10) + "deps OK", loc_cOut, 1)

    *-- (1) Init completo SEM cursor do pai
    loc_oForm = CREATEOBJECT("FormSigOpClp")
    STRTOFILE(CHR(13) + CHR(10) + "CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13) + CHR(10) + "FORM BaseClass=[" + loc_oForm.BaseClass + "]" + ;
                  " W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                  " Controls=" + TRANSFORM(loc_oForm.ControlCount) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", loc_cOut, 1)

        loc_oGrd = loc_oForm.grd_4c_Dados

        *-- (2) SEM cursor: grade sem fonte, mas colunas JA formatadas
        STRTOFILE(CHR(13) + CHR(10) + "--- SEM CURSOR ---", loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "GRID CC=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RS=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " Top=" + TRANSFORM(loc_oGrd.Top) + " Left=" + TRANSFORM(loc_oGrd.Left) + ;
                  " W=" + TRANSFORM(loc_oGrd.Width) + " H=" + TRANSFORM(loc_oGrd.Height) + ;
                  " RO=" + TRANSFORM(loc_oGrd.ReadOnly) + ;
                  " Visible=" + TRANSFORM(loc_oGrd.Visible), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "WIDTHS=" + ;
                  TRANSFORM(loc_oGrd.Column1.Width) + "/" + TRANSFORM(loc_oGrd.Column2.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column3.Width) + "/" + TRANSFORM(loc_oGrd.Column4.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column5.Width) + "/" + TRANSFORM(loc_oGrd.Column6.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column7.Width), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "ORDERS=" + ;
                  TRANSFORM(loc_oGrd.Column1.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column2.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column3.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column4.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column5.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column6.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column7.ColumnOrder), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "HEADERS=[" + ;
                  ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column3.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column4.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column5.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column6.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column7.Header1.Caption) + "]", loc_cOut, 1)

        *-- (3) COM o cursor do contrato (o que o form pai entrega)
        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Operacoes ( ;
            Emps C(3) NULL, Dopes C(20) NULL, MascNum C(10) NULL, ;
            Datas T NULL, Valos N(12,2) NULL, Tipo C(10) NULL, Moeda C(3) NULL)
        SET NULL OFF
        INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Datas, Valos, Tipo, Moeda) ;
            VALUES ("001", "MALOTE", "3", DATETIME(), 1234.56, "Destino", "RS")
        INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Datas, Valos, Tipo, Moeda) ;
            VALUES ("001", "DEPOSITO", "7", DATETIME(), 98.70, "Origem", "RS")
        INDEX ON Emps + Dopes + MascNum TAG Num
        INDEX ON Datas TAG Datas
        SET ORDER TO TAG Num
        GO TOP

        loc_lLigou = loc_oForm.CarregarLista()
        STRTOFILE(CHR(13) + CHR(10) + "--- COM CURSOR ---", loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "CarregarLista=" + TRANSFORM(loc_lLigou) + ;
                  " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Operacoes")), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "GRID CC=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RS=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " RSType=" + TRANSFORM(loc_oGrd.RecordSourceType), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "CS=[" + ;
                  ALLTRIM(loc_oGrd.Column1.ControlSource) + "][" + ALLTRIM(loc_oGrd.Column2.ControlSource) + "][" + ;
                  ALLTRIM(loc_oGrd.Column3.ControlSource) + "][" + ALLTRIM(loc_oGrd.Column4.ControlSource) + "][" + ;
                  ALLTRIM(loc_oGrd.Column5.ControlSource) + "][" + ALLTRIM(loc_oGrd.Column6.ControlSource) + "][" + ;
                  ALLTRIM(loc_oGrd.Column7.ControlSource) + "]", loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "WIDTHS=" + ;
                  TRANSFORM(loc_oGrd.Column1.Width) + "/" + TRANSFORM(loc_oGrd.Column2.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column3.Width) + "/" + TRANSFORM(loc_oGrd.Column4.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column5.Width) + "/" + TRANSFORM(loc_oGrd.Column6.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column7.Width), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "ORDERS=" + ;
                  TRANSFORM(loc_oGrd.Column1.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column2.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column3.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column4.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column5.ColumnOrder) + "/" + TRANSFORM(loc_oGrd.Column6.ColumnOrder) + "/" + ;
                  TRANSFORM(loc_oGrd.Column7.ColumnOrder), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "HEADERS=[" + ;
                  ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column3.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column4.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column5.Header1.Caption) + "][" + ALLTRIM(loc_oGrd.Column6.Header1.Caption) + "][" + ;
                  ALLTRIM(loc_oGrd.Column7.Header1.Caption) + "]", loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "COL5 Format=[" + ALLTRIM(loc_oGrd.Column5.Format) + "]" + ;
                  " COL1 RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
                  " Movable=" + TRANSFORM(loc_oGrd.Column1.Movable) + ;
                  " RecordMark=" + TRANSFORM(loc_oGrd.RecordMark) + ;
                  " DeleteMark=" + TRANSFORM(loc_oGrd.DeleteMark), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "PONTEIRO alias=[" + ALIAS() + "]" + ;
                  " RECNO=" + TRANSFORM(RECNO("cursor_4c_Operacoes")), loc_cOut, 1)

        *-- (4) Escopo (2 = Protected). Chamados de fora -> tem de ser .F.
        STRTOFILE(CHR(13) + CHR(10) + "PROTECTED CarregarLista=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + ;
                  " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + ;
                  " LerParametrosDoFormPai=" + TRANSFORM(PEMSTATUS(loc_oForm, "LerParametrosDoFormPai", 2)) + ;
                  " FormatarColunasGrade=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormatarColunasGrade", 2)), loc_cOut, 1)

        *-- (5) Botao Encerrar e icone
        loc_cPic = loc_oForm.cmg_4c_Operacao.Buttons(1).Picture
        STRTOFILE(CHR(13) + CHR(10) + "BOTAO Caption=[" + ALLTRIM(loc_oForm.cmg_4c_Operacao.Buttons(1).Caption) + "]" + ;
                  " Cancel=" + TRANSFORM(loc_oForm.cmg_4c_Operacao.Buttons(1).Cancel) + ;
                  " Grupo=" + TRANSFORM(loc_oForm.cmg_4c_Operacao.Left) + "/" + ;
                  TRANSFORM(loc_oForm.cmg_4c_Operacao.Top) + ;
                  " Picture[" + JUSTFNAME(loc_cPic) + "]=" + IIF(FILE(loc_cPic), "OK", "FALTA"), loc_cOut, 1)

        *-- (6) Reordenacao: o funil repinta e as larguras continuam de pe
        loc_oForm.this_oBusinessObject.OrdenarPorData()
        loc_lLigou = loc_oForm.CarregarLista()
        STRTOFILE(CHR(13) + CHR(10) + "--- APOS OrdenarPorData + CarregarLista ---", loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "CarregarLista=" + TRANSFORM(loc_lLigou) + ;
                  " ORDER=[" + ORDER("cursor_4c_Operacoes") + "]" + ;
                  " WIDTHS=" + TRANSFORM(loc_oGrd.Column1.Width) + "/" + ;
                  TRANSFORM(loc_oGrd.Column3.Width) + "/" + TRANSFORM(loc_oGrd.Column5.Width) + ;
                  " HEADER1=[" + ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "]", loc_cOut, 1)

        loc_oForm.Release()
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + "FIM OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "ERRO=" + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
