SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probef6_813_err.txt"

LOCAL loc_cOut, loc_cBase
loc_cBase = "C:\4c\projeto\app\"
loc_cOut  = ""

SET PROCEDURE TO (loc_cBase + "utils\functions.prg")   ADDITIVE
SET PROCEDURE TO (loc_cBase + "utils\messages.prg")    ADDITIVE
SET PROCEDURE TO (loc_cBase + "utils\validators.prg")  ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\formbase.prg")     ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\gridbase.prg")     ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\SigOpTotBO.prg")   ADDITIVE
SET PROCEDURE TO (loc_cBase + "forms\operacionais\FormSigOpTot.prg") ADDITIVE

*-- Cursores COMPARTILHADOS que o form pai de movimento prepara
CREATE CURSOR crSigCdOpe (ChkQtds N(1), PesoVts N(1), PrecoVts N(1), ;
    TotCompos N(1), Opers N(1), HabServs N(1), Cmoes C(3))
INSERT INTO crSigCdOpe (ChkQtds, PesoVts, PrecoVts, TotCompos, HabServs, Opers, Cmoes) ;
    VALUES (0, 1, 1, 0, 0, 1, "   ")
GO TOP IN crSigCdOpe

CREATE CURSOR TprMvCab (Dopes C(20), VCompensas N(10,2), VCompensa2 N(10,2))
INSERT INTO TprMvCab (Dopes, VCompensas, VCompensa2) VALUES ("COMPRA", 1.50, 0.00)
GO TOP IN TprMvCab

CREATE CURSOR crTpmMvItn (CItens C(10), Codbarras C(14), Cpros C(20), Cunis C(3), ;
    MoeFats C(3), Moedas C(3), Opers C(1), Pesos N(10,3), Qtds N(10,2), ;
    TPesos N(10,3), Totas N(15,2))
INSERT INTO crTpmMvItn (CItens, Codbarras, Cpros, Cunis, MoeFats, Moedas, Opers, ;
    Pesos, Qtds, TPesos, Totas) ;
    VALUES ("I001", "", "PRO-001", "UN ", "BRL", "BRL", "E", 2.000, 3.00, 6.000, 300.00)
GO TOP IN crTpmMvItn

CREATE CURSOR crTpmMvIts (CItens C(10), Codtams C(5), Pesos N(10,3), Qtds N(10,2))
INDEX ON CItens TAG CItens
GO TOP IN crTpmMvIts

CREATE CURSOR crTpmMvItn3 (Cpros C(20), Moedas C(3), Totas N(15,2))
GO TOP IN crTpmMvItn3

CREATE CURSOR crTmpUni (Cunis C(3), Cestos C(1))
INSERT INTO crTmpUni (Cunis, Cestos) VALUES ("UN ", "1")
GO TOP IN crTmpUni

CREATE CURSOR crSigOpCdc (DocQtd2s C(12), HabServs N(1))
INSERT INTO crSigOpCdc (DocQtd2s, HabServs) VALUES ("", 0)
GO TOP IN crSigOpCdc

CREATE CURSOR crSigOpCdd (MtCubs N(4))
INSERT INTO crSigOpCdd (MtCubs) VALUES (0)
GO TOP IN crSigOpCdd

LOCAL loc_nSessao
loc_nSessao = SET("DATASESSION")
loc_cOut = loc_cOut + "DataSession do probe: " + TRANSFORM(loc_nSessao) + CHR(13) + CHR(10)

*-- Form PAI stub, so com a property Op_Escolha que o dialogo le
LOCAL loc_oPai
loc_oPai = CREATEOBJECT("PaiStubSigOpTot813")
loc_oPai.Op_Escolha = "ALTERAR"

LOCAL loc_oForm, loc_oErro
TRY
    loc_oForm = CREATEOBJECT("FormSigOpTot", loc_oPai, loc_nSessao)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCEPTION no CREATEOBJECT: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "VARTYPE(oForm): " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    LOCAL ARRAY loc_aEv[1,5]
    LOCAL loc_nEv, loc_nI
    loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Compensacao)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 1) BINDEVENT de txt_4c_Compensacao ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  bindings: " + TRANSFORM(loc_nEv) + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO loc_nEv
        loc_cOut = loc_cOut + "  [" + UPPER(loc_aEv[loc_nI,3]) + " -> " + ;
            UPPER(loc_aEv[loc_nI,4]) + "]" + CHR(13) + CHR(10)
    ENDFOR

    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 2) escopo dos metodos ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  ValidarCompensacao     PROTECTED? " + ;
        IIF(PEMSTATUS(loc_oForm, "ValidarCompensacao", 2), "SIM (ERRADO)", "nao (OK)") + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  ValidarCompensacaoExec PROTECTED? " + ;
        IIF(PEMSTATUS(loc_oForm, "ValidarCompensacaoExec", 2), "SIM (esperado)", "nao") + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 3) Format/InputMask (dump x migrado) ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_TotQtde     Format=[" + loc_oForm.txt_4c_TotQtde.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_TotQtde.InputMask + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_TotPeso     Format=[" + loc_oForm.txt_4c_TotPeso.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_TotPeso.InputMask + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_TotPesoC    Format=[" + loc_oForm.txt_4c_TotPesoC.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_TotPesoC.InputMask + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_Compensacao Format=[" + loc_oForm.txt_4c_Compensacao.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_Compensacao.InputMask + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_TotPes      Format=[" + loc_oForm.txt_4c_TotPes.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_TotPes.InputMask + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_Mtcub       Format=[" + loc_oForm.txt_4c_Mtcub.Format + ;
        "] InputMask=[" + loc_oForm.txt_4c_Mtcub.InputMask + "]  (dump: InputMask)" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 4) estado inicial ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  lbl_4c_Label5.Visible=" + TRANSFORM(loc_oForm.lbl_4c_Label5.Visible) + ;
        " txt_4c_Mtcub.Visible=" + TRANSFORM(loc_oForm.txt_4c_Mtcub.Visible) + " (dump: .F./.F.)" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  txt_4c_TotPesoC.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_TotPesoC.ReadOnly) + ;
        " txt_4c_Compensacao.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Compensacao.ReadOnly) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  lbl_4c_Label3.AutoSize=" + TRANSFORM(loc_oForm.lbl_4c_Label3.AutoSize) + ;
        " Width=" + TRANSFORM(loc_oForm.lbl_4c_Label3.Width) + ;
        " Height=" + TRANSFORM(loc_oForm.lbl_4c_Label3.Height) + ;
        " Alignment=" + TRANSFORM(loc_oForm.lbl_4c_Label3.Alignment) + ;
        " ForeColor=" + TRANSFORM(loc_oForm.lbl_4c_Label3.ForeColor) + CHR(13) + CHR(10)

    gb_4c_ModoTeste = .F.
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 5) ValidarCompensacao: valor VALIDO ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  antes : TprMvCab.VCompensas=" + TRANSFORM(TprMvCab.VCompensas) + ;
        "  txt.Value=" + TRANSFORM(loc_oForm.txt_4c_Compensacao.Value) + CHR(13) + CHR(10)
    loc_oForm.txt_4c_Compensacao.Value = 2.50
    loc_oForm.ValidarCompensacao()
    loc_cOut = loc_cOut + "  depois: TprMvCab.VCompensas=" + TRANSFORM(TprMvCab.VCompensas) + ;
        "  txt.Value=" + TRANSFORM(loc_oForm.txt_4c_Compensacao.Value) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  BO.this_nCompensacao=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nCompensacao) + ;
        "  BO.this_nCompensacaoAnt=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nCompensacaoAnt) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  BO.this_nTotPesoC=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotPesoC) + ;
        "  txt_4c_TotPesoC.Value=" + TRANSFORM(loc_oForm.txt_4c_TotPesoC.Value) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  BO.cMensagemErro=[" + loc_oForm.this_oBusinessObject.this_cMensagemErro + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  flag reentrancia depois da chamada: " + ;
        TRANSFORM(loc_oForm.this_lEmValidacaoCompensacao) + " (tem de ser .F.)" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 6) guarda de reentrancia ---" + CHR(13) + CHR(10)
    loc_oForm.this_lEmValidacaoCompensacao = .T.
    loc_oForm.txt_4c_Compensacao.Value = 99.99
    loc_oForm.ValidarCompensacao()
    loc_cOut = loc_cOut + "  com flag .T.: TprMvCab.VCompensas=" + TRANSFORM(TprMvCab.VCompensas) + ;
        " (tem de continuar 2.50)" + CHR(13) + CHR(10)
    loc_oForm.this_lEmValidacaoCompensacao = .F.
    loc_oForm.txt_4c_Compensacao.Value = 2.50

    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- 7) BO.ValidarCompensacao: valor NEGATIVO ---" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  retorno: " + TRANSFORM(loc_oForm.this_oBusinessObject.ValidarCompensacao(-5)) + ;
        " (tem de ser .F.)" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  mensagem: [" + loc_oForm.this_oBusinessObject.this_cMensagemErro + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "  legado  : [Valor de Compensa" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lido]" + CHR(13) + CHR(10)

    gb_4c_ModoTeste = .T.
    loc_oForm.Release()
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- dialogos suprimidos no ModoTeste ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\_probef6_813.txt")
QUIT

DEFINE CLASS PaiStubSigOpTot813 AS Custom
    Op_Escolha = ""
ENDDEFINE
