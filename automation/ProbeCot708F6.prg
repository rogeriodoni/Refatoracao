SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_708_f6_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_708_f6_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\TextBoxGridLookup.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCotBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCot.prg ADDITIVE

LOCAL lcOut, loF, loErr, lcCr, loTxt, llRet, lnDummy
lcCr = CHR(13) + CHR(10)
lcOut = ""

*-- Cursor de trabalho do form PAI (TmpCot do legado): cmoes / valos / avalos
IF USED("TmpCot")
    USE IN TmpCot
ENDIF
CREATE CURSOR TmpCot (cmoes C(3), valos N(12,7), avalos N(12,7))
INSERT INTO TmpCot (cmoes, valos, avalos) VALUES ("US$", 5.1234567, 0)
INSERT INTO TmpCot (cmoes, valos, avalos) VALUES ("EUR", 6.0000000, 0)
GO TOP IN TmpCot

*===========================================================================
* CENARIO A - instanciacao
*===========================================================================
lcOut = lcOut + "=== CENARIO A: instanciacao ===" + lcCr
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCot")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + lcCr
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + lcCr

IF VARTYPE(loF) = "O"
    *=======================================================================
    * CENARIO B - os tres metodos da celula existem e sao PUBLIC (regra #51)
    *             PEMSTATUS(o, "X", 2) = .F. significa NAO-protegido
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO B: metodos da celula (PUBLIC) ===" + lcCr
    lcOut = lcOut + "ValidarAcessoCotacao   existe=" + ;
        IIF(PEMSTATUS(loF, "ValidarAcessoCotacao", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "ValidarAcessoCotacao", 2)) + lcCr
    lcOut = lcOut + "ValidarCotacao         existe=" + ;
        IIF(PEMSTATUS(loF, "ValidarCotacao", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "ValidarCotacao", 2)) + lcCr
    lcOut = lcOut + "ValidarCotacaoKeyPress existe=" + ;
        IIF(PEMSTATUS(loF, "ValidarCotacaoKeyPress", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "ValidarCotacaoKeyPress", 2)) + lcCr
    lcOut = lcOut + "GradeCotacaoWhen (nome VELHO, deve ser NAO) = " + ;
        IIF(PEMSTATUS(loF, "GradeCotacaoWhen", 5), "SIM", "NAO") + lcCr

    *=======================================================================
    * CENARIO C - as duas celulas foram instaladas (regra #18)
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO C: Column.CurrentControl / Sparse ===" + lcCr
    WITH loF.grd_4c_Dados
        lcOut = lcOut + "ColumnCount = " + TRANSFORM(.ColumnCount) + ;
                "  Grid.ReadOnly = " + TRANSFORM(.ReadOnly) + lcCr
        lcOut = lcOut + "Col1 CurrentControl=[" + .Column1.CurrentControl + "]" + ;
                " Sparse=" + TRANSFORM(.Column1.Sparse) + ;
                " ReadOnly=" + TRANSFORM(.Column1.ReadOnly) + lcCr
        lcOut = lcOut + "Col2 CurrentControl=[" + .Column2.CurrentControl + "]" + ;
                " Sparse=" + TRANSFORM(.Column2.Sparse) + ;
                " ReadOnly=" + TRANSFORM(.Column2.ReadOnly) + lcCr
        lcOut = lcOut + "Col2 InputMask=[" + .Column2.InputMask + "] Format=[" + .Column2.Format + "]" + lcCr
        lcOut = lcOut + "Col1 classe=[" + .Column1.txt_4c_Moeda.Class + "]" + lcCr
        lcOut = lcOut + "Col2 classe=[" + .Column2.txt_4c_Cotacao.Class + "]" + lcCr
        lcOut = lcOut + "Col2 txt InputMask=[" + .Column2.txt_4c_Cotacao.InputMask + "]" + lcCr
    ENDWITH

    *=======================================================================
    * CENARIO D - When da coluna Moeda: Return .f. (legado literal)
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO D: When da celula Moeda (esperado .F.) ===" + lcCr
    TRY
        llRet = loF.grd_4c_Dados.Column1.txt_4c_Moeda.When()
        lcOut = lcOut + "Moeda.When() = " + TRANSFORM(llRet) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO Moeda.When: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO E - Valid da celula Cotacao
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO E: Valid da celula Cotacao ===" + lcCr
    loTxt = loF.grd_4c_Dados.Column2.txt_4c_Cotacao
    TRY
        CLEAR TYPEAHEAD
        llRet = loF.ValidarCotacao(loTxt)
        lcOut = lcOut + "ValidarCotacao() = " + TRANSFORM(llRet) + ;
                "  LASTKEY()=" + TRANSFORM(LASTKEY()) + ;
                "  CHRSAW()=" + TRANSFORM(CHRSAW()) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO ValidarCotacao: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + lcCr
    ENDTRY

    *-- Mesmo metodo com ENTER como ultima tecla: tem de enfileirar {DnArrow}
    TRY
        CLEAR TYPEAHEAD
        KEYBOARD CHR(13) PLAIN
        lnDummy = INKEY(0)
        lcOut = lcOut + "  (LASTKEY apos consumir ENTER = " + TRANSFORM(LASTKEY()) + ")" + lcCr
        CLEAR TYPEAHEAD
        llRet = loF.ValidarCotacao(loTxt)
        lcOut = lcOut + "  com LASTKEY=13 -> retorno=" + TRANSFORM(llRet) + ;
                "  CHRSAW()=" + TRANSFORM(CHRSAW()) + " (enfileirou tecla=" + ;
                IIF(CHRSAW(), "SIM", "nao") + ")" + lcCr
        CLEAR TYPEAHEAD
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO ValidarCotacao/ENTER: " + loErr.Message + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO F - KeyPress da celula: TAB (9) leva o foco para Salvar
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO F: KeyPress da celula (TAB=9 -> Salvar) ===" + lcCr
    TRY
        llRet = loF.ValidarCotacaoKeyPress(65, 0)
        lcOut = lcOut + "KeyPress(65,0) = " + TRANSFORM(llRet) + " (tecla comum: no-op)" + lcCr
        llRet = loF.ValidarCotacaoKeyPress(9, 0)
        lcOut = lcOut + "KeyPress(9,0)  = " + TRANSFORM(llRet) + " (TAB)" + lcCr
        lcOut = lcOut + "  Buttons(1).Caption = [" + loF.cmg_4c_Botoes.Buttons(1).Caption + "]" + lcCr
        lcOut = lcOut + "  Buttons(1) Visible/Enabled = " + ;
                TRANSFORM(loF.cmg_4c_Botoes.Buttons(1).Visible) + "/" + ;
                TRANSFORM(loF.cmg_4c_Botoes.Buttons(1).Enabled) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO KeyPress: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                " PROC=" + loErr.Procedure + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO G - When da celula Cotacao sem conexao: nao pode estourar
    *=======================================================================
    lcOut = lcOut + lcCr + "=== CENARIO G: When da celula Cotacao (sem SQL) ===" + lcCr
    TRY
        llRet = loF.ValidarAcessoCotacao(loTxt)
        lcOut = lcOut + "ValidarAcessoCotacao() = " + TRANSFORM(llRet) + lcCr
        llRet = loF.grd_4c_Dados.Column2.txt_4c_Cotacao.When()
        lcOut = lcOut + "Cotacao.When() via classe = " + TRANSFORM(llRet) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO ValidarAcessoCotacao: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + lcCr
    ENDTRY

    loF.Release()
ENDIF

lcOut = lcOut + lcCr + "=== dialogos suprimidos ===" + lcCr
IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + FILETOSTR(gc_4c_ArquivoErroTeste) + lcCr
ELSE
    lcOut = lcOut + "(nenhum)" + lcCr
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\probe_708_f6.txt")
QUIT
