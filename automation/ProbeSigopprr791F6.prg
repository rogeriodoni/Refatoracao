*==============================================================================
* ProbeSigopprr791F6.prg - Instancia Formsigopprr headless (Fase 6 / task791)
* e mede o que esta fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto);
*   (2) os 2 campos restantes do dump existem com as propriedades literais
*       (Label2 + SENHA: Format/InputMask/PasswordChar/geometria);
*   (3) os handlers de LostFocus estao PUBLIC (BINDEVENT ignora PROTECTED);
*   (4) o BINDEVENT ficou LIGADO - prova chamando o evento NATIVO
*       (txt.LostFocus()) e conferindo o efeito, porque AEVENTS devolve 0
*       com DataSession = 2;
*   (5) o ramo de RECUSA limpa os dois campos (sem banco, ValidarLogin
*       devolve .F. e o handler cai no ELSE);
*   (6) FecharDialogo usa Hide() e NAO Release() - a referencia do chamador
*       sobrevive e as properties de retorno continuam legiveis.
* NAO chama Show() (modal: bloquearia o headless).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_791_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oTxt
loc_cOut = "C:\4c\automation\probe_791_f6_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopprrBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopprr.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("Formsigopprr")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- (2) Campos do dump
        STRTOFILE(CHR(13)+CHR(10)+"EXISTE lbl_4c_Label1=" + TRANSFORM(PEMSTATUS(loc_oForm,"lbl_4c_Label1",5)) + ;
                  " txt_4c_USUARIO=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_USUARIO",5)) + ;
                  " lbl_4c_Label2=" + TRANSFORM(PEMSTATUS(loc_oForm,"lbl_4c_Label2",5)) + ;
                  " txt_4c_SENHA=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_SENHA",5)), loc_cOut, 1)

        WITH loc_oForm.lbl_4c_Label2
            STRTOFILE(CHR(13)+CHR(10)+"LBL2 Caption=[" + .Caption + "] T=" + TRANSFORM(.Top) + ;
                      " L=" + TRANSFORM(.Left) + " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                      " AutoSize=" + TRANSFORM(.AutoSize) + " Fore=" + TRANSFORM(.ForeColor) + ;
                      " Vis=" + TRANSFORM(.Visible), loc_cOut, 1)
        ENDWITH

        WITH loc_oForm.txt_4c_SENHA
            STRTOFILE(CHR(13)+CHR(10)+"SENHA Fmt=[" + .Format + "] Mask=[" + .InputMask + "]" + ;
                      " Pwd=[" + .PasswordChar + "] T=" + TRANSFORM(.Top) + " L=" + TRANSFORM(.Left) + ;
                      " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                      " Tab=" + TRANSFORM(.TabIndex) + " VT=" + VARTYPE(.Value) + ;
                      " Themes=" + TRANSFORM(.Themes) + " Vis=" + TRANSFORM(.Visible), loc_cOut, 1)
        ENDWITH

        *-- (3) Escopo dos handlers (2 = PROTECTED). BINDEVENT exige PUBLIC.
        STRTOFILE(CHR(13)+CHR(10)+"PROTECTED? UsuarioLostFocus=" + TRANSFORM(PEMSTATUS(loc_oForm,"UsuarioLostFocus",2)) + ;
                  " SenhaLostFocus=" + TRANSFORM(PEMSTATUS(loc_oForm,"SenhaLostFocus",2)) + ;
                  " ValidarOperador=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarOperador",2)) + ;
                  " ValidarCredenciais=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarCredenciais",2)) + ;
                  " FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
                  " LimparCampos=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2)), loc_cOut, 1)

        *-- (4)+(5) BINDEVENT ligado: dispara o evento NATIVO do TextBox com
        *--         credenciais preenchidas. Sem banco ValidarLogin recusa, e
        *--         o ramo ELSE tem de ter limpado os DOIS campos.
        loc_oForm.txt_4c_USUARIO.Value = "001"
        loc_oForm.txt_4c_SENHA.Value   = "XPTO"
        loc_oForm.txt_4c_SENHA.LostFocus()
        STRTOFILE(CHR(13)+CHR(10)+"POS-SenhaLostFocus USUARIO=[" + TRANSFORM(loc_oForm.txt_4c_USUARIO.Value) + ;
                  "] SENHA=[" + TRANSFORM(loc_oForm.txt_4c_SENHA.Value) + ;
                  "] Autenticado=" + TRANSFORM(loc_oForm.this_lAutenticado) + ;
                  " Operador=[" + loc_oForm.this_cOperador + "]" + ;
                  " EmValidacao=" + TRANSFORM(loc_oForm.this_lEmValidacao), loc_cOut, 1)

        *-- ValidarOperador isolado
        loc_oForm.txt_4c_USUARIO.Value = ""
        STRTOFILE(CHR(13)+CHR(10)+"ValidarOperador(vazio)=" + TRANSFORM(loc_oForm.ValidarOperador()), loc_cOut, 1)
        loc_oForm.txt_4c_USUARIO.Value = "007"
        STRTOFILE(CHR(13)+CHR(10)+"ValidarOperador(007)=" + TRANSFORM(loc_oForm.ValidarOperador()) + ;
                  " ValidarCredenciais=" + TRANSFORM(loc_oForm.ValidarCredenciais()) + ;
                  " BO.this_cUsuarios=[" + loc_oForm.this_oBusinessObject.this_cUsuarios + "]", loc_cOut, 1)

        *-- (4b) BINDEVENT do USUARIO: campo vazio -> FecharDialogo
        loc_oForm.txt_4c_USUARIO.Value = ""
        loc_oForm.txt_4c_USUARIO.LostFocus()
        STRTOFILE(CHR(13)+CHR(10)+"POS-UsuarioLostFocus(vazio) VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " EmValidacao=" + TRANSFORM(loc_oForm.this_lEmValidacao), loc_cOut, 1)

        *-- (6) FecharDialogo nao mata a referencia
        loc_oForm.FecharDialogo()
        STRTOFILE(CHR(13)+CHR(10)+"POS-FecharDialogo VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " Visible=" + TRANSFORM(loc_oForm.Visible) + ;
                  " Autenticado=" + TRANSFORM(loc_oForm.this_lAutenticado), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"POS-Release(chamador) VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
    ENDIF

    STRTOFILE(CHR(13)+CHR(10)+"FIM OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"ERRO: " + loc_oErro.Message + ;
              " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
              " | Proc " + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
