* MedirRebindColumn1Sts.prg - mede o que acontece com a CELULA de lookup
* (txt_4c_Status, instalada por Column.AddObject + CurrentControl) quando a
* grade perde as colunas (ColumnCount = 0, provado em MedirGradeColumn1Sts)
* e VincularGrade reconstroi com ColumnCount = 2.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gcOut, gc_4c_ArquivoErroTeste, gnConnHandle
gc_4c_ArquivoErroTeste = "C:\4c\automation\_medir_rebind_msgs.txt"
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.
gcOut = ""

LOCAL loForm, loErr, loGrid

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

    *-- cursor JA aberto e CORRENTE quando o form nasce -> a grade auto-binda
    IF USED("cursor_4c_Status")
        USE IN cursor_4c_Status
    ENDIF
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
        VALUES ("K1", "MALOTE", "A", "ABERTO")
    SELECT cursor_4c_Status

    loForm = CREATEOBJECT("FormSigOpSts", .NULL., "MALOTE", "INSERIR", 1)
    loGrid = loForm.grd_4c_Dados
    Marcar(loGrid, "1 form c/cursor aberto")

    *-- o que ListarStatusOperacao faz a cada carga
    USE IN cursor_4c_Status
    Marcar(loGrid, "2 apos USE IN (carga)")

    *-- e o cursor volta, como depois do SELECT ... INTO CURSOR do BO
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
        VALUES ("K1", "MALOTE", "A", "ABERTO")
    Marcar(loGrid, "3 cursor recriado")

    *-- ColumnCount = 2 recria as Columns: a celula AddObject sobrevive?
    loGrid.ColumnCount = 2
    Marcar(loGrid, "4 apos ColumnCount=2")

    TRY
        loForm.CarregarDados()
        Marcar(loGrid, "5 apos CarregarDados")
        loGrid.RecordSource = "cursor_4c_Status"
        loGrid.Column1.ControlSource = "cursor_4c_Status.status"
        loGrid.Column1.CurrentControl = "txt_4c_Status"
        Marcar(loGrid, "6 apos CurrentControl")
    CATCH TO loErr
        gcOut = gcOut + "5 apos CurrentControl   ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
CATCH TO loErr
    gcOut = gcOut + "ERRO GERAL: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(gcOut, "C:\4c\automation\_medir_rebind.txt")
QUIT

PROCEDURE Marcar(poGrid, pcPasso)
    LOCAL lcLin
    lcLin = PADR(pcPasso, 24) + ;
            " ColumnCount=" + TRANSFORM(poGrid.ColumnCount) + ;
            " PEM(Column1)=" + IIF(PEMSTATUS(poGrid, "Column1", 5), ".T.", ".F.")
    IF PEMSTATUS(poGrid, "Column1", 5)
        lcLin = lcLin + ;
            " PEM(txt_4c_Status)=" + IIF(PEMSTATUS(poGrid.Column1, "txt_4c_Status", 5), ".T.", ".F.") + ;
            " CurrentControl=[" + ALLTRIM(poGrid.Column1.CurrentControl) + "]"
    ENDIF
    gcOut = gcOut + lcLin + CHR(13) + CHR(10)
ENDPROC
