*-- Probe da Fase 4 do task750 (Formsigopind) - compilacao + instanciacao +
*-- conferencia das propriedades do grid de Saldo contra o dump legado
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lcOut
lcOut = "C:\4c\automation\vfp_helpers\probe750_f4_resultado.txt"
lcRes = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe750_f4_dialogs.txt"

PUBLIC gnConnHandle
gnConnHandle = 0

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE

LOCAL lcBO, lcForm
lcBO   = gc_4c_CaminhoClasses + "sigopindBO.prg"
lcForm = gc_4c_CaminhoForms + "operacionais\Formsigopind.prg"

lcRes = lcRes + "=== COMPILACAO (fxp apagado antes) ===" + CHR(13) + CHR(10)
ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))
ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))
ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))
ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
COMPILE (lcBO)
COMPILE (lcForm)
lcRes = lcRes + "BO.FXP   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "BO.ERR   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.FXP = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.ERR = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))) + CHR(13) + CHR(10)
IF FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
    lcRes = lcRes + "--- FORM.ERR ---" + CHR(13) + CHR(10) + ;
            FILETOSTR(STRTRAN(UPPER(lcForm), ".PRG", ".ERR")) + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcRes, lcOut)

SET PROCEDURE TO (lcBO)   ADDITIVE
SET PROCEDURE TO (lcForm) ADDITIVE

*==========================================================================
* 1) UPDATE do Matriz - roda na sessao do PROBE, com a MESMA estrutura
*    NULL-enabled do cursor do form, para provar que a expressao eh valida
*    em VFP9 e que classifica M/F/vazio como o legado
*==========================================================================
lcRes = lcRes + CHR(13) + CHR(10) + "=== 1) UPDATE Matriz (legado: Iif(Empty(ContaMats),'',Iif(Contas=ContaMats,'M','F'))) ===" + CHR(13) + CHR(10)
LOCAL loErrU
TRY
    SET NULL ON
    CREATE CURSOR cr750 (Contas C(10) NULL, ContaMats C(10) NULL, Matriz C(1) NULL)
    SET NULL OFF
    INSERT INTO cr750 (Contas, ContaMats, Matriz) VALUES ("0000000001", "0000000001", " ")
    INSERT INTO cr750 (Contas, ContaMats, Matriz) VALUES ("0000000002", "0000000001", " ")
    INSERT INTO cr750 (Contas, ContaMats, Matriz) VALUES ("0000000003", "          ", " ")
    INSERT INTO cr750 (Contas, ContaMats, Matriz) VALUES ("0000000004", .NULL., " ")

    UPDATE cr750 ;
        SET Matriz = IIF(EMPTY(NVL(ContaMats, "")), "", ;
                         IIF(NVL(Contas, "") = NVL(ContaMats, ""), "M", "F"))

    SELECT cr750
    SCAN
        lcRes = lcRes + "  Contas=" + NVL(cr750.Contas, "<null>") + ;
                " ContaMats=" + NVL(cr750.ContaMats, "<null>   ") + ;
                " -> Matriz=[" + NVL(cr750.Matriz, "?") + "]" + CHR(13) + CHR(10)
    ENDSCAN
    lcRes = lcRes + "  esperado: M (igual), F (diferente), vazio (branco), vazio (null)" + CHR(13) + CHR(10)
    USE IN cr750
CATCH TO loErrU
    lcRes = lcRes + "  EXCECAO no UPDATE: " + loErrU.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcRes, lcOut)

*==========================================================================
* 2) Instanciacao do form
*==========================================================================
lcRes = lcRes + CHR(13) + CHR(10) + "=== 2) INSTANCIACAO ===" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

LOCAL loForm, loErr
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigopind")
CATCH TO loErr
    lcRes = lcRes + "EXCECAO: " + loErr.Message + " | LN=" + TRANSFORM(loErr.LineNo) + ;
            " | PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcRes = lcRes + "VARTYPE(loForm) = [" + VARTYPE(loForm) + "]  (esperado O)" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

IF VARTYPE(loForm) = "O"
    lcRes = lcRes + "BaseClass    = [" + loForm.BaseClass + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "Caption      = [" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "Width/Height = " + TRANSFORM(loForm.Width) + "/" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcRes = lcRes + "DataSession  = " + TRANSFORM(loForm.DataSession) + CHR(13) + CHR(10)
    lcRes = lcRes + "ControlCount = " + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)
    lcRes = lcRes + "BO VARTYPE   = [" + VARTYPE(loForm.this_oBusinessObject) + "]" + CHR(13) + CHR(10)

    *----------------------------------------------------------------------
    * 3) Grid de Saldo - propriedades contra o dump legado
    *----------------------------------------------------------------------
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 3) grd_4c_Saldos x dump legado ===" + CHR(13) + CHR(10)
    IF PEMSTATUS(loForm.pgf_4c_1.Page1, "grd_4c_Saldos", 5)
        LOCAL loG
        loG = loForm.pgf_4c_1.Page1.grd_4c_Saldos
        lcRes = lcRes + "Top/Left/W/H  = " + TRANSFORM(loG.Top) + "/" + TRANSFORM(loG.Left) + ;
                "/" + TRANSFORM(loG.Width) + "/" + TRANSFORM(loG.Height) + ;
                "   (dump: 140/10/980/453)" + CHR(13) + CHR(10)
        lcRes = lcRes + "ColumnCount   = " + TRANSFORM(loG.ColumnCount) + "   (dump: 7)" + CHR(13) + CHR(10)
        lcRes = lcRes + "RecordMark    = " + TRANSFORM(loG.RecordMark) + "   (dump: .T.)" + CHR(13) + CHR(10)
        lcRes = lcRes + "DeleteMark    = " + TRANSFORM(loG.DeleteMark) + "   (dump: .F.)" + CHR(13) + CHR(10)
        lcRes = lcRes + "ScrollBars    = " + TRANSFORM(loG.ScrollBars) + "   (dump: 2)" + CHR(13) + CHR(10)
        lcRes = lcRes + "GridLineColor = " + TRANSFORM(loG.GridLineColor) + ;
                "   (dump RGB(238,238,238)=" + TRANSFORM(RGB(238,238,238)) + ")" + CHR(13) + CHR(10)
        lcRes = lcRes + "Themes        = " + TRANSFORM(loG.Themes) + "   (dump: .F.)" + CHR(13) + CHR(10)
        lcRes = lcRes + "ReadOnly      = " + TRANSFORM(loG.ReadOnly) + "   (dump: .T.)" + CHR(13) + CHR(10)
        lcRes = lcRes + "RecordSource  = [" + loG.RecordSource + "]" + CHR(13) + CHR(10)

        LOCAL lnI, loC, lcEsperaW, lcEsperaO, lcEsperaCS
        lcEsperaW  = "100,433,43,140,41,136,28"
        lcEsperaO  = "1,2,5,4,6,3,7"
        lcEsperaCS = "Contas,Rclis,Moedas,Saldos,Emps,Cpfs,Matriz"
        lcRes = lcRes + CHR(13) + CHR(10) + "col | Width (dump) | ColumnOrder (dump) | ControlSource (dump) | Header" + CHR(13) + CHR(10)
        FOR lnI = 1 TO 7
            loC = EVALUATE("loG.Column" + TRANSFORM(lnI))
            lcRes = lcRes + TRANSFORM(lnI) + "   | " + ;
                    PADR(TRANSFORM(loC.Width) + " (" + GETWORDNUM(lcEsperaW, lnI, ",") + ")", 14) + "| " + ;
                    PADR(TRANSFORM(loC.ColumnOrder) + " (" + GETWORDNUM(lcEsperaO, lnI, ",") + ")", 19) + "| " + ;
                    PADR(loC.ControlSource + " (" + GETWORDNUM(lcEsperaCS, lnI, ",") + ")", 50) + "| [" + ;
                    loC.Header1.Caption + "]" + CHR(13) + CHR(10)
        ENDFOR

        lcRes = lcRes + CHR(13) + CHR(10) + "Column4.Text1.InputMask = [" + loG.Column4.Text1.InputMask + ;
                "]   (dump: 99,999,999,999.99)" + CHR(13) + CHR(10)
        lcRes = lcRes + "Column3.Text1.Alignment = " + TRANSFORM(loG.Column3.Text1.Alignment) + "   (dump: 3)" + CHR(13) + CHR(10)
        lcRes = lcRes + "Column7.Text1.Alignment = " + TRANSFORM(loG.Column7.Text1.Alignment) + "   (dump: 2)" + CHR(13) + CHR(10)
        lcRes = lcRes + "Column1.Header1.ForeColor = " + TRANSFORM(loG.Column1.Header1.ForeColor) + ;
                "   (dump RGB(90,90,90)=" + TRANSFORM(RGB(90,90,90)) + ")" + CHR(13) + CHR(10)
        lcRes = lcRes + "Column1.DynamicBackColor = [" + LEFT(loG.Column1.DynamicBackColor, 70) + "...]" + CHR(13) + CHR(10)
        lcRes = lcRes + "Column7.DynamicBackColor vazio = " + TRANSFORM(EMPTY(loG.Column7.DynamicBackColor)) + ;
                "   (esperado .F.)" + CHR(13) + CHR(10)
    ELSE
        lcRes = lcRes + "*** grd_4c_Saldos AUSENTE ***" + CHR(13) + CHR(10)
    ENDIF
    STRTOFILE(lcRes, lcOut)

    *----------------------------------------------------------------------
    * 4) Cursor do form (DataSession privada) - estrutura e tags
    *----------------------------------------------------------------------
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 4) cursor_4c_Saldos (datasession do form) ===" + CHR(13) + CHR(10)
    LOCAL lnSesAnt
    lnSesAnt = SET("Datasession")
    SET DATASESSION TO loForm.DataSessionId
    IF USED("cursor_4c_Saldos")
        SELECT cursor_4c_Saldos
        lcRes = lcRes + "USED = .T.  FCOUNT = " + TRANSFORM(FCOUNT()) + ;
                "  RECCOUNT = " + TRANSFORM(RECCOUNT()) + CHR(13) + CHR(10)
        lcRes = lcRes + "TAGS: "
        LOCAL lnT
        FOR lnT = 1 TO 10
            IF EMPTY(TAG(lnT))
                EXIT
            ENDIF
            lcRes = lcRes + TAG(lnT) + " "
        ENDFOR
        lcRes = lcRes + "  (legado: Contas, Rclis, Cpfs)" + CHR(13) + CHR(10)
        lcRes = lcRes + "ORDER corrente = [" + ORDER() + "]  (esperado vazio)" + CHR(13) + CHR(10)
    ELSE
        lcRes = lcRes + "*** cursor_4c_Saldos NAO existe na sessao do form ***" + CHR(13) + CHR(10)
    ENDIF
    SET DATASESSION TO lnSesAnt

    *----------------------------------------------------------------------
    * 5) Visibilidade dos metodos que o harness chama de fora (regra #3/#51)
    *----------------------------------------------------------------------
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 5) PEMSTATUS attr 2 (PROTECTED) - esperado .F. ===" + CHR(13) + CHR(10)
    lcRes = lcRes + "MontaGrade    = " + TRANSFORM(PEMSTATUS(loForm, "MontaGrade", 2)) + CHR(13) + CHR(10)
    lcRes = lcRes + "CarregarLista = " + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
    lcRes = lcRes + "AlternarPagina= " + TRANSFORM(PEMSTATUS(loForm, "AlternarPagina", 2)) + CHR(13) + CHR(10)

    *----------------------------------------------------------------------
    * 6) MontaGrade("") - caminho sem grupo: nao pode estourar e tem de
    *    repor Width/ColumnOrder/ControlSource depois do RecordSource
    *----------------------------------------------------------------------
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 6) MontaGrade('') com gnConnHandle=0 ===" + CHR(13) + CHR(10)
    LOCAL llMG, loErrM
    TRY
        llMG = loForm.MontaGrade("")
        lcRes = lcRes + "retorno = " + TRANSFORM(llMG) + "  (gnConnHandle=0 -> .F. esperado, sem excecao)" + CHR(13) + CHR(10)
    CATCH TO loErrM
        lcRes = lcRes + "EXCECAO: " + loErrM.Message + " | LN=" + TRANSFORM(loErrM.LineNo) + ;
                " | PROC=" + loErrM.Procedure + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
    loForm = .NULL.
    lcRes = lcRes + CHR(13) + CHR(10) + "Release OK" + CHR(13) + CHR(10)
ENDIF

lcRes = lcRes + CHR(13) + CHR(10) + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

QUIT
