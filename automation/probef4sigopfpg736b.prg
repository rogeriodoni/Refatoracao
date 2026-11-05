*==============================================================================
* probef4sigopfpg736b.prg - Exercita em RUNTIME a Fase 4 do FormSigOpFpg
* (task736) APOS o funil de carga: grd_4c_Dados + VincularGrade() +
* CarregarDados() + AjustarBotoesPorModo().
*
* O cursor da grade vive na DATASESSION PRIVADA do form (DataSession = 2),
* entao USED() da sessao default NAO o enxerga - o probe troca para
* loc_oForm.DataSessionID antes de medir (por isso o probe anterior reportava
* "cursor_4c_Dados NAO existe" sem haver defeito).
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m736\probe_f4b_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut, loc_nSessaoProbe
loc_cLog = "C:\4c\automation\_m736\probe_f4b_sigopfpg.txt"
loc_cOut = "=== PROBE Fase 4-b - FormSigOpFpg (task736) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFpgBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFpg.prg") ADDITIVE

loc_nSessaoProbe = SET("Datasession")
loc_cOut = loc_cOut + "[1] Setup OK - datasession do probe = " + ;
    TRANSFORM(loc_nSessaoProbe) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- Pai simulado: o Init legado le pForm.pcEscolha e faz pForm.Enabled = .F.
LOCAL loc_oPai, loc_oForm, loc_oErro
loc_oPai = CREATEOBJECT("Form")
loc_oPai.AddProperty("pcEscolha", "INSERIR")

TRY
    loc_oForm = CREATEOBJECT("FormSigOpFpg", loc_oPai, loc_nSessaoProbe, .F.)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) <> "O"
    loc_cOut = loc_cOut + "[2] Form NAO instanciado - VARTYPE = " + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF

loc_cOut = loc_cOut + "[2] Form instanciado OK - DataSessionID=" + ;
    TRANSFORM(loc_oForm.DataSessionID) + " | pai.Enabled=" + ;
    TRANSFORM(loc_oPai.Enabled) + " | OpEscolha=[" + loc_oForm.this_cOpEscolha + ;
    "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [3] Cursor da grade DENTRO da datasession privada do form
LOCAL loc_cCursor, loc_nF
LOCAL ARRAY loc_aCampos[1, 4]
loc_cCursor = loc_oForm.this_cCursorGrade

SET DATASESSION TO loc_oForm.DataSessionID

IF USED(loc_cCursor)
    loc_cOut = loc_cOut + "[3] " + loc_cCursor + " existe (datasession privada) - campos: " + ;
        TRANSFORM(AFIELDS(loc_aCampos, loc_cCursor)) + CHR(13) + CHR(10)
    FOR loc_nF = 1 TO ALEN(loc_aCampos, 1)
        loc_cOut = loc_cOut + "    " + loc_aCampos[loc_nF, 1] + " " + ;
            loc_aCampos[loc_nF, 2] + "(" + TRANSFORM(loc_aCampos[loc_nF, 3]) + ;
            "," + TRANSFORM(loc_aCampos[loc_nF, 4]) + ")" + CHR(13) + CHR(10)
    ENDFOR
    loc_cOut = loc_cOut + "    ALIAS corrente = [" + ALIAS() + ;
        "] RECNO=" + TRANSFORM(RECNO(loc_cCursor)) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT(loc_cCursor)) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[3] FALHA - " + loc_cCursor + " NAO existe na datasession do form" + ;
        CHR(13) + CHR(10)
ENDIF

*-- [4] Popular 3 linhas e provar que CarregarDados repinta e vai para o topo
INSERT INTO (loc_cCursor) (FPags, Valos, Vencs, MoeFpgs, CotFpgs) ;
    VALUES ("001", 1500.00, DATE(), "BRL", 1.000000)
INSERT INTO (loc_cCursor) (FPags, Valos, Vencs, MoeFpgs, CotFpgs) ;
    VALUES ("002", 750.50, DATE() + 30, "BRL", 1.000000)
INSERT INTO (loc_cCursor) (FPags, Valos, Vencs, MoeFpgs, CotFpgs) ;
    VALUES ("003", 250.25, DATE() + 60, "USD", 5.432100)

GO BOTTOM
loc_cOut = loc_cOut + "[4] 3 linhas inseridas - RECNO antes do funil = " + ;
    TRANSFORM(RECNO(loc_cCursor)) + CHR(13) + CHR(10)

SET DATASESSION TO loc_nSessaoProbe
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_lCarregou
loc_lCarregou = loc_oForm.CarregarDados()

SET DATASESSION TO loc_oForm.DataSessionID
loc_cOut = loc_cOut + "[4] CarregarDados() retornou " + TRANSFORM(loc_lCarregou) + ;
    " - RECNO depois = " + TRANSFORM(RECNO(loc_cCursor)) + ;
    " (esperado 1) | RECCOUNT=" + TRANSFORM(RECCOUNT(loc_cCursor)) + ;
    " | ALIAS corrente = [" + ALIAS() + "]" + CHR(13) + CHR(10)
SET DATASESSION TO loc_nSessaoProbe
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] Grid depois do rebind: largura/ordem/mascara/header preservados
WITH loc_oForm.grd_4c_Dados
    loc_cOut = loc_cOut + "[5] grd_4c_Dados - ColumnCount=" + TRANSFORM(.ColumnCount) + ;
        " RecordSource=[" + .RecordSource + "] ReadOnly=" + TRANSFORM(.ReadOnly) + ;
        " TabIndex=" + TRANSFORM(.TabIndex) + " Visible=" + TRANSFORM(.Visible) + ;
        CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    Col1 CS=[" + .Column1.ControlSource + "] W=" + ;
        TRANSFORM(.Column1.Width) + " Ord=" + TRANSFORM(.Column1.ColumnOrder) + ;
        " RO=" + TRANSFORM(.Column1.ReadOnly) + " Fnt=[" + .Column1.FontName + ;
        "] Txt1RO=" + TRANSFORM(.Column1.Text1.ReadOnly) + ;
        " Txt1Brd=" + TRANSFORM(.Column1.Text1.BorderStyle) + ;
        " Hdr=[" + .Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    Col2 CS=[" + .Column2.ControlSource + "] W=" + ;
        TRANSFORM(.Column2.Width) + " Ord=" + TRANSFORM(.Column2.ColumnOrder) + ;
        " RO=" + TRANSFORM(.Column2.ReadOnly) + " Mask=[" + .Column2.InputMask + ;
        "] Hdr=[" + .Column2.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    Col3 CS=[" + .Column3.ControlSource + "] W=" + ;
        TRANSFORM(.Column3.Width) + " Ord=" + TRANSFORM(.Column3.ColumnOrder) + ;
        " RO=" + TRANSFORM(.Column3.ReadOnly) + ;
        " Hdr=[" + .Column3.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    Col4 CS=[" + .Column4.ControlSource + "] W=" + ;
        TRANSFORM(.Column4.Width) + " Ord=" + TRANSFORM(.Column4.ColumnOrder) + ;
        " RO=" + TRANSFORM(.Column4.ReadOnly) + ;
        " Hdr=[" + .Column4.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    Col5 CS=[" + .Column5.ControlSource + "] W=" + ;
        TRANSFORM(.Column5.Width) + " Ord=" + TRANSFORM(.Column5.ColumnOrder) + ;
        " RO=" + TRANSFORM(.Column5.ReadOnly) + " Mask=[" + .Column5.InputMask + ;
        "] Hdr=[" + .Column5.Header1.Caption + "]" + CHR(13) + CHR(10)
ENDWITH
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] VincularGrade reexecutado NAO perde largura nem caption (idempotente)
loc_oForm.VincularGrade()
WITH loc_oForm.grd_4c_Dados
    loc_cOut = loc_cOut + "[6] Apos 2o VincularGrade - W1=" + TRANSFORM(.Column1.Width) + ;
        " W2=" + TRANSFORM(.Column2.Width) + " W3=" + TRANSFORM(.Column3.Width) + ;
        " W4=" + TRANSFORM(.Column4.Width) + " W5=" + TRANSFORM(.Column5.Width) + ;
        " | Ord3=" + TRANSFORM(.Column3.ColumnOrder) + ;
        " Ord4=" + TRANSFORM(.Column4.ColumnOrder) + ;
        " Ord5=" + TRANSFORM(.Column5.ColumnOrder) + ;
        " | Hdr1=[" + .Column1.Header1.Caption + "] Hdr5=[" + ;
        .Column5.Header1.Caption + "]" + CHR(13) + CHR(10)
ENDWITH
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] AjustarBotoesPorModo - Apaga.Visible = Inlist(OpEscolha,INSERIR,ALTERAR)
LOCAL loc_nM
LOCAL ARRAY loc_aModos[5]
loc_aModos[1] = "INSERIR"
loc_aModos[2] = "ALTERAR"
loc_aModos[3] = "CONSULTAR"
loc_aModos[4] = "EXCLUIR"
loc_aModos[5] = ""

FOR loc_nM = 1 TO ALEN(loc_aModos, 1)
    loc_oForm.this_cOpEscolha = loc_aModos[loc_nM]
    loc_oForm.AjustarBotoesPorModo()
    loc_cOut = loc_cOut + "[7] OpEscolha=[" + PADR(loc_aModos[loc_nM], 9) + ;
        "] -> cmd_4c_Apaga.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Apaga.Visible) + ;
        " | Ok.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Visible) + ;
        " Cancela.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Visible) + ;
        " Cancela.Cancel=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Cancel) + ;
        CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [8] Dialogos suprimidos pelo modo teste (prova que nada abriu MESSAGEBOX)
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "[8] Dialogos capturados:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[8] NENHUM dialogo de erro/aviso disparado" + CHR(13) + CHR(10)
ENDIF

loc_oForm.Release()
loc_cOut = loc_cOut + "[9] Form liberado - pai.Enabled=" + ;
    TRANSFORM(loc_oPai.Enabled) + " - FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
