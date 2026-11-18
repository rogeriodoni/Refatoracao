* MedirRepararCelulaSts.prg - prova que GarantirCelulaStatus/VincularGrade
* REINSTALAM a celula de lookup depois de a grade perder as Columns
* (ColumnCount = 0 -> ColumnCount = 2 recria as Columns e o controle
* AddObject desaparece - medido em MedirRebindColumn1Sts).
*
* Os dois metodos sao PROTECTED (sao hooks internos do form, nao se chamam de
* fora - regra #51). Para exercita-los, o harness usa uma SUBCLASSE de
* FormSigOpSts: subclasse ALCANCA membro PROTECTED da classe-mae, e assim o
* teste nao exige afrouxar o escopo do codigo de producao.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gcOut, gc_4c_ArquivoErroTeste, gnConnHandle
gc_4c_ArquivoErroTeste = "C:\4c\automation\_medir_reparar_msgs.txt"
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

    loForm = CREATEOBJECT("FormStsTeste_4c", .NULL., "MALOTE", "INSERIR", 1)
    loGrid = loForm.grd_4c_Dados
    Marcar(loGrid, "1 form c/cursor aberto")

    *-- o que ListarStatusOperacao faz a cada carga: zera o ColumnCount
    USE IN cursor_4c_Status
    Marcar(loGrid, "2 apos USE IN (carga)")

    *-- e o cursor volta, como depois do SELECT ... INTO CURSOR do BO
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
        VALUES ("K1", "MALOTE", "A", "ABERTO")
    Marcar(loGrid, "3 cursor recriado")

    *-- VincularGrade eh o funil de rebind: tem de devolver a celula
    TRY
        gcOut = gcOut + "VincularGrade -> " + ;
            IIF(loForm.ChamarVincularGrade(), ".T.", ".F.") + CHR(13) + CHR(10)
        Marcar(loGrid, "4 apos VincularGrade")
    CATCH TO loErr
        gcOut = gcOut + "4 apos VincularGrade    ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- e a celula tem de responder ao When/Valid, ou seja ser a classe certa
    IF PEMSTATUS(loGrid, "Column1", 5) AND PEMSTATUS(loGrid.Column1, "txt_4c_Status", 5)
        gcOut = gcOut + "5 classe da celula = [" + loGrid.Column1.txt_4c_Status.Class + "]" + ;
            " MaxLength=" + TRANSFORM(loGrid.Column1.txt_4c_Status.MaxLength) + ;
            " (esperado TextBoxStatusSts_4c / 1)" + CHR(13) + CHR(10)
    ELSE
        gcOut = gcOut + "5 classe da celula = *** CELULA AUSENTE ***" + CHR(13) + CHR(10)
    ENDIF

    *-- idempotencia: chamar de novo nao pode duplicar nem estourar
    TRY
        gcOut = gcOut + "6 GarantirCelulaStatus 2x -> " + ;
            IIF(loForm.ChamarGarantirCelulaStatus(), ".T.", ".F.") + CHR(13) + CHR(10)
        Marcar(loGrid, "7 apos 2a chamada")
    CATCH TO loErr
        gcOut = gcOut + "7 apos 2a chamada       ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- CmdInserirClick com a grade DESVINCULADA nao pode mais estourar
    USE IN cursor_4c_Status
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))
    Marcar(loGrid, "8 grade desvinculada")
    loForm.CmdInserirClick()
    gcOut = gcOut + "9 CmdInserirClick desvinculado -> RECCOUNT=" + ;
        TRANSFORM(RECCOUNT("cursor_4c_Status")) + " (esperado 1, sem erro)" + CHR(13) + CHR(10)

    loForm.Release()
CATCH TO loErr
    gcOut = gcOut + "ERRO GERAL: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(gcOut, "C:\4c\automation\_medir_reparar.txt")
QUIT

PROCEDURE Marcar(poGrid, pcPasso)
    LOCAL lcLin
    lcLin = PADR(pcPasso, 24) + ;
            " ColumnCount=" + TRANSFORM(poGrid.ColumnCount) + ;
            " PEM(Column1)=" + IIF(PEMSTATUS(poGrid, "Column1", 5), ".T.", ".F.")
    IF PEMSTATUS(poGrid, "Column1", 5)
        lcLin = lcLin + ;
            " PEM(txt_4c_Status)=" + IIF(PEMSTATUS(poGrid.Column1, "txt_4c_Status", 5), ".T.", ".F.") + ;
            " CurrentControl=[" + ALLTRIM(poGrid.Column1.CurrentControl) + "]" + ;
            " Sparse=" + IIF(poGrid.Column1.Sparse, ".T.", ".F.")
    ENDIF
    gcOut = gcOut + lcLin + CHR(13) + CHR(10)
ENDPROC

*------------------------------------------------------------------------------
* Subclasse de teste: expoe os hooks PROTECTED do form sem alterar o escopo
* deles no codigo de producao.
*------------------------------------------------------------------------------
DEFINE CLASS FormStsTeste_4c AS FormSigOpSts
    PROCEDURE ChamarVincularGrade
        RETURN THIS.VincularGrade()
    ENDPROC

    PROCEDURE ChamarGarantirCelulaStatus
        RETURN THIS.GarantirCelulaStatus()
    ENDPROC
ENDDEFINE
