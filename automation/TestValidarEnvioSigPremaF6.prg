*-- Teste funcional de Formsigprema.ValidarEnvio (task602, Fase 6).
*-- Instanciar o form nao prova a regra: aqui o cursor de trabalho e' populado
*-- a mao em 3 cenarios e se confere o RETORNO de ValidarEnvio, que e' o que
*-- decide se BtnEnviarEmailClick chega a anunciar "Email enviado com sucesso!".
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
*-- gb_4c_ModoTeste sozinho NAO suprime dialogo: messages.prg so desvia para
*-- arquivo quando gc_4c_ArquivoErroTeste tambem esta definido.
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_validarenvio_msgs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cResultado, loc_oForm, loc_oErro, loc_cCls, loc_cUtl, loc_cFrm
LOCAL loc_lVazio, loc_lSemMarca, loc_lMarcaSemEmail, loc_lOkEnvio, loc_lRecnoOk

loc_cResultado = "FAIL"
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
    ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

    loc_oForm = CREATEOBJECT("Formsigprema")

    *-- CENARIO 1: cursor existe mas VAZIO -> nenhuma marcada -> .F.
    loc_lVazio = loc_oForm.ValidarEnvio()

    *-- CENARIO 2: 2 linhas com email, NENHUMA marcada -> .F.
    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE Checks WITH 0, Contas WITH "C001", Rclis WITH "CLIENTE UM", ;
            Emails WITH "um@teste.com", EmpDopNums WITH "001MALOTE", ;
            Prioridade WITH "NORMAL"
    APPEND BLANK
    REPLACE Checks WITH 0, Contas WITH "C002", Rclis WITH "CLIENTE DOIS", ;
            Emails WITH "dois@teste.com", EmpDopNums WITH "001MALOTE", ;
            Prioridade WITH "NORMAL"
    loc_lSemMarca = loc_oForm.ValidarEnvio()

    *-- CENARIO 3: linha marcada mas SEM email -> .F. (caso que no legado
    *-- passava batido e exibia "Email enviado com sucesso!")
    SELECT cursor_4c_Dados
    GO TOP
    REPLACE ALL Checks WITH 0
    APPEND BLANK
    REPLACE Checks WITH 1, Contas WITH "C003", Rclis WITH "CLIENTE TRES", ;
            Emails WITH "", EmpDopNums WITH "001MALOTE", Prioridade WITH "NORMAL"
    loc_lMarcaSemEmail = loc_oForm.ValidarEnvio()

    *-- CENARIO 4: linha marcada COM email -> .T.
    SELECT cursor_4c_Dados
    GO TOP
    REPLACE Checks WITH 1
    GO 2
    loc_lOkEnvio = loc_oForm.ValidarEnvio()
    *-- e a linha corrente tem de continuar onde estava (registro 2)
    loc_lRecnoOk = (RECNO("cursor_4c_Dados") = 2)

    loc_cResultado = ;
        "vazio_deve_ser_F="            + TRANSFORM(loc_lVazio)         + ;
        " semMarca_deve_ser_F="        + TRANSFORM(loc_lSemMarca)      + ;
        " marcadaSemEmail_deve_ser_F=" + TRANSFORM(loc_lMarcaSemEmail) + ;
        " marcadaComEmail_deve_ser_T=" + TRANSFORM(loc_lOkEnvio)       + ;
        " preservaRecno_deve_ser_T="   + TRANSFORM(loc_lRecnoOk)

    IF !loc_lVazio AND !loc_lSemMarca AND !loc_lMarcaSemEmail ;
       AND loc_lOkEnvio AND loc_lRecnoOk
        loc_cResultado = loc_cResultado + " >>> TESTE_OK"
    ELSE
        loc_cResultado = loc_cResultado + " >>> TESTE_FAIL"
    ENDIF

    loc_oForm.Release()
CATCH TO loc_oErro
    loc_cResultado = "EXCEPTION: " + loc_oErro.Message + ;
        " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cResultado, "C:\4c\automation\test_validarenvio_sigprema_f6.txt")
QUIT
