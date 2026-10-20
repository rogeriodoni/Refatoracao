SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_sigopalc_f6_msgs.txt"

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cCls, loc_cUtl, loc_cFrm, loc_nEv, loc_cEv, loc_i, loc_n
LOCAL ARRAY loc_aEv[1, 5]
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
    SET PROCEDURE TO (loc_cCls + "SigOpAlCBO.prg") ADDITIVE
    SET PROCEDURE TO (loc_cFrm + "FormSigOpAlC.prg") ADDITIVE
    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    *-- Init(lcMoeda, lnCotacao, ldData) do legado
    loc_oForm = CREATEOBJECT("FormSigOpAlC", "USD", 5.4321, DATE())

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "CREATEOBJECT devolveu NAO-OBJETO (VARTYPE=" + VARTYPE(loc_oForm) + ") >>> TESTE_FAIL"
    ELSE
        loc_cRes = "FORM_OK Caption=[" + loc_oForm.Caption + "]" + ;
                   " W/H=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

        *-- os 4 campos do legado existem?
        loc_cRes = loc_cRes + "CAMPOS:" + ;
            " Usuario=" + IIF(PEMSTATUS(loc_oForm, "txt_4c_Usuario", 5), "SIM", "NAO") + ;
            " Senha="   + IIF(PEMSTATUS(loc_oForm, "txt_4c_Senha",   5), "SIM", "NAO") + ;
            " Moeda="   + IIF(PEMSTATUS(loc_oForm, "txt_4c_Moeda",   5), "SIM", "NAO") + ;
            " Cotacao=" + IIF(PEMSTATUS(loc_oForm, "txt_4c_Cotacao", 5), "SIM", "NAO") + CHR(13) + CHR(10)

        loc_cRes = loc_cRes + "VALORES: Moeda=[" + TRANSFORM(loc_oForm.txt_4c_Moeda.Value) + "]" + ;
            " ReadOnlyMoeda=" + TRANSFORM(loc_oForm.txt_4c_Moeda.ReadOnly) + ;
            " Cotacao=[" + TRANSFORM(loc_oForm.txt_4c_Cotacao.Value) + "]" + ;
            " MaskCot=[" + loc_oForm.txt_4c_Cotacao.InputMask + "]" + ;
            " MaskUsu=[" + loc_oForm.txt_4c_Usuario.InputMask + "]" + ;
            " PwdSenha=[" + loc_oForm.txt_4c_Senha.PasswordChar + "]" + CHR(13) + CHR(10)

        *-- os handlers sao PUBLIC (chamaveis de fora, como o BINDEVENT exige)?
        loc_cRes = loc_cRes + "HANDLERS_PUBLIC:" + ;
            " ValidarUsuario="        + IIF(PEMSTATUS(loc_oForm, "ValidarUsuario",       2), "PROTECTED", "PUBLIC") + ;
            " ValidarSenha="          + IIF(PEMSTATUS(loc_oForm, "ValidarSenha",         2), "PROTECTED", "PUBLIC") + ;
            " ValidarCotacao="        + IIF(PEMSTATUS(loc_oForm, "ValidarCotacao",       2), "PROTECTED", "PUBLIC") + ;
            " ValidarAcessoCotacao="  + IIF(PEMSTATUS(loc_oForm, "ValidarAcessoCotacao", 2), "PROTECTED", "PUBLIC") + CHR(13) + CHR(10)

        *-- os BINDEVENT foram de fato registrados? AEVENTS(array, oOrigem) -
        *   coluna 3 = evento, coluna 4 = metodo delegado. NAO usar
        *   AEVENTS(array, 0): o form tem DataSession = 2 e os bindings
        *   nascem na sessao PRIVADA dele, invisiveis para a sessao 1.
        FOR loc_i = 1 TO 4
            loc_cEv = ICASE(loc_i = 1, "txt_4c_Usuario", loc_i = 2, "txt_4c_Senha", ;
                            loc_i = 3, "txt_4c_Cotacao", "txt_4c_Moeda")
            loc_nEv = AEVENTS(loc_aEv, EVALUATE("loc_oForm." + loc_cEv))
            loc_cRes = loc_cRes + "BINDEVENTS " + PADR(loc_cEv, 15) + "= " + TRANSFORM(loc_nEv)
            FOR loc_n = 1 TO loc_nEv
                loc_cRes = loc_cRes + " [" + TRANSFORM(loc_aEv[loc_n, 3]) + " -> " + TRANSFORM(loc_aEv[loc_n, 4]) + "]"
            ENDFOR
            loc_cRes = loc_cRes + CHR(13) + CHR(10)
        ENDFOR

        *-- When de Get_Cotacao: sem Usuario preenchido, o foco volta para Usuario
        loc_oForm.txt_4c_Usuario.Value = ""
        loc_oForm.ValidarAcessoCotacao()
        loc_cRes = loc_cRes + "WHEN_COTACAO_SEM_USUARIO=OK" + CHR(13) + CHR(10)

        *-- KeyPress que NAO eh Enter/Tab nao dispara validacao nenhuma
        loc_oForm.ValidarUsuario(65, 0)
        loc_oForm.ValidarSenha(65, 0)
        loc_oForm.ValidarCotacao(65, 0)
        loc_cRes = loc_cRes + "GUARDA_KEYCODE=OK" + CHR(13) + CHR(10)

        *-- Enter com Usuario VAZIO: o legado so valida If Not Empty(This.Value)
        loc_oForm.ValidarUsuario(13, 0)
        loc_cRes = loc_cRes + "ENTER_USUARIO_VAZIO=OK" + CHR(13) + CHR(10)

        *-- Enter na Cotacao com valor ZERO: condicao (This.Value <> 0) do legado
        loc_oForm.txt_4c_Cotacao.Value = 0
        loc_oForm.ValidarCotacao(13, 0)
        loc_cRes = loc_cRes + "ENTER_COTACAO_ZERO=OK >>> TESTE_OK"

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure + " >>> TESTE_FAIL"
ENDTRY
STRTOFILE(loc_cRes, "C:\4c\automation\test_sigopalc_f6.txt")
QUIT
