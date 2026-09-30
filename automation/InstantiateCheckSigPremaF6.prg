*-- Probe de instanciacao do Formsigprema (task602, Fase 6).
*-- Carrega SO as dependencias (nao chama ConfigurarAmbiente, que puxa menu.prg
*-- e trava o probe) e instancia o form em modo de validacao de UI, para provar
*-- que os BINDEVENT novos da coluna Email nao derrubam o Init.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gnConnHandle       = -1
gc_4c_UsuarioLogado = "TESTE"

LOCAL loc_cResultado, loc_oForm, loc_oErro, loc_cCls, loc_cUtl, loc_cFrm
LOCAL loc_nBind, loc_i, loc_cEventos
LOCAL ARRAY loc_aEv[1]
loc_cResultado = "FAIL"

loc_cCls = "C:\4c\projeto\app\classes\"
loc_cUtl = "C:\4c\projeto\app\utils\"
loc_cFrm = "C:\4c\projeto\app\forms\operacionais\"

gc_4c_CaminhoIcones = "C:\4c\vbmp\"

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

    IF VARTYPE(loc_oForm) = "O"
        *-- Prova que os BINDEVENT novos chegaram no Text1 da coluna Email.
        *-- AEVENTS tem 2 argumentos e o nome do evento fica na COLUNA 3.
        loc_cEventos = ""
        loc_nBind = AEVENTS(loc_aEv, loc_oForm.grd_4c_Dados.Column4.Text1)
        FOR loc_i = 1 TO loc_nBind
            loc_cEventos = loc_cEventos + IIF(EMPTY(loc_cEventos), "", "/") + ;
                           ALLTRIM(loc_aEv[loc_i, 3])
        ENDFOR

        loc_cResultado = "OK" + ;
            " Width="       + TRANSFORM(loc_oForm.Width) + ;
            " Height="      + TRANSFORM(loc_oForm.Height) + ;
            " Grid="        + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + ;
            " ColCount="    + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
            " Col4CS=["     + loc_oForm.grd_4c_Dados.Column4.ControlSource + "]" + ;
            " Col4RO="      + TRANSFORM(loc_oForm.grd_4c_Dados.Column4.ReadOnly) + ;
            " ValEmail="    + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarEmailLinha", 5)) + ;
            " ValEmailKP="  + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarEmailLinhaKeyPress", 5)) + ;
            " ValEnvio="    + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarEnvio", 5)) + ;
            " nBindCol4="   + TRANSFORM(loc_nBind) + ;
            " evCol4=["     + loc_cEventos + "]"
        loc_oForm.Release()
    ELSE
        loc_cResultado = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cResultado = "EXCEPTION: " + loc_oErro.Message + ;
        " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cResultado, "C:\4c\automation\instantiate_check_sigprema_f6.txt")
QUIT
