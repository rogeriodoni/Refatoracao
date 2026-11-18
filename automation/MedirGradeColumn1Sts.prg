* MedirGradeColumn1Sts.prg - localiza em QUE passo a grade de FormSigOpSts
* perde a Column1 ("Unknown member COLUMN1" medido no CmdInserirClick).
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gcOut, gc_4c_ArquivoErroTeste, gnConnHandle
gc_4c_ArquivoErroTeste = "C:\4c\automation\_medir_col1_msgs.txt"
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.
gcOut = ""

LOCAL loForm, loErr

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("FormSigOpSts")
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .F.
    IF TYPE("gnConnHandle") != "N"
        gnConnHandle = -1
    ENDIF

    loForm = CREATEOBJECT("FormSigOpSts", .NULL., "MALOTE", "INSERIR", 1)
    Marcar(loForm, "1 apos Init")

    loForm.cmd_4c_Inserir.Visible = .T.
    Marcar(loForm, "2 apos Visible")

    IF USED("cursor_4c_Status")
        USE IN cursor_4c_Status
    ENDIF
    Marcar(loForm, "3 apos USE IN")

    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    Marcar(loForm, "4 apos CREATE CURSOR")

    INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
        VALUES ("K1", "MALOTE", "A", "ABERTO")
    Marcar(loForm, "5 apos INSERT")

    loForm.grd_4c_Dados.Refresh()
    Marcar(loForm, "6 apos Grid.Refresh")

    loForm.CmdInserirClick()
    Marcar(loForm, "7 apos CmdInserirClick")

    loForm.Release()

    *-- HIPOTESE: grade com RecordSource vazio AUTO-BINDA na area de trabalho
    *-- CORRENTE; fechar esse alias zera o ColumnCount e a Column1 desaparece.
    *-- Reproduz a ordem do harness: o cursor JA existe quando o form eh criado.
    IF USED("cursor_4c_Status")
        USE IN cursor_4c_Status
    ENDIF
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    SELECT cursor_4c_Status

    loForm = CREATEOBJECT("FormSigOpSts", .NULL., "MALOTE", "INSERIR", 1)
    Marcar(loForm, "8 form c/cursor aberto")

    USE IN cursor_4c_Status
    Marcar(loForm, "9 apos fechar o alias")

    loForm.Release()
CATCH TO loErr
    gcOut = gcOut + "ERRO GERAL: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(gcOut, "C:\4c\automation\_medir_col1.txt")
QUIT

PROCEDURE Marcar(poForm, pcPasso)
    LOCAL lcLin, loErr
    lcLin = PADR(pcPasso, 24) + ;
            " ColumnCount=" + TRANSFORM(poForm.grd_4c_Dados.ColumnCount) + ;
            " RecSrc=[" + ALLTRIM(poForm.grd_4c_Dados.RecordSource) + "]" + ;
            " RecSrcType=" + TRANSFORM(poForm.grd_4c_Dados.RecordSourceType) + ;
            " PEM(Column1)=" + IIF(PEMSTATUS(poForm.grd_4c_Dados, "Column1", 5), ".T.", ".F.") + ;
            " ALIAS()=[" + ALIAS() + "]"
    TRY
        poForm.grd_4c_Dados.Column1.SetFocus()
        lcLin = lcLin + " SetFocus=OK"
    CATCH TO loErr
        lcLin = lcLin + " SetFocus=ERRO(" + loErr.Message + ")"
    ENDTRY
    gcOut = gcOut + lcLin + CHR(13) + CHR(10)
ENDPROC
