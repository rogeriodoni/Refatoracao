SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .T.
gnConnHandle = -1
gc_4c_UsuarioLogado = "TESTE"
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_validaremail_msgs.txt"

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cCls, loc_cUtl, loc_cFrm, loc_cGravado
loc_cRes = "FAIL"
loc_cCls = "C:\4c\projeto\app\classes\"
loc_cUtl = "C:\4c\projeto\app\utils\"
loc_cFrm = "C:\4c\projeto\app\forms\operacionais\"
TRY
    SET PATH TO ("C:\4c\projeto\app\start,C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms,C:\4c\vbmp")
    SET PROCEDURE TO (loc_cUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (loc_cUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (loc_cUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "sigpremaBO.prg") ADDITIVE
    SET PROCEDURE TO (loc_cFrm + "Formsigprema.prg") ADDITIVE
    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
    loc_oForm = CREATEOBJECT("Formsigprema")

    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE Checks WITH 1, Contas WITH "C001", Emails WITH "  JOAO@Teste.COM  "

    *-- simula o usuario tendo digitado com espacos e maiusculas na celula
    loc_oForm.grd_4c_Dados.Column4.Text1.Value = "  JOAO@Teste.COM  "
    loc_oForm.ValidarEmailLinha()

    loc_cGravado = cursor_4c_Dados.Emails
    loc_cRes = "gravado=[" + loc_cGravado + "]" + ;
               " textbox=[" + loc_oForm.grd_4c_Dados.Column4.Text1.Value + "]" + ;
               IIF(ALLTRIM(loc_cGravado) == "joao@teste.com", " >>> TESTE_OK", " >>> TESTE_FAIL")
    loc_oForm.Release()
CATCH TO loc_oErro
    loc_cRes = "EXCEPTION: " + loc_oErro.Message + " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY
STRTOFILE(loc_cRes, "C:\4c\automation\test_validaremail_sigprema_f6.txt")
QUIT
