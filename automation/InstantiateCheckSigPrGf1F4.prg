*==============================================================================
* InstantiateCheckSigPrGf1F4.prg - valida a Fase 4 de FormSigPrGf1 (task612)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA (mantendo a Fase 3 intacta);
*   2. obj_4c_CmdGprocessa existe com ButtonCount=2 e a geometria do dump
*      legado (Left=643/Top=-2/Width=160/Height=85);
*   3. Buttons(1)=Processar / Buttons(2)=Encerrar com Picture apontando
*      para arquivo REAL em vbmp\ (FILE() checa existencia).
*
* gnConnHandle = 1 eh handle FALSO: o Init do BO nao faz SQL.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF4, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprgf1f4.txt"
gc_4c_LogF4            = "C:\4c\automation\instantiate_sigprgf1f4_result.txt"
gnConnHandle           = 1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF4)
    DELETE FILE (gc_4c_LogF4)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprgf1.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprgf1.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprgf1bo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprgf1bo.fxp"
ENDIF

LOCAL loc_oForm, loc_oErro
LogP("FASE4 task612 - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    LogP("0a config.prg OK")

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGf1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGf1.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGf1")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]", ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    TRY
        LogP("2 obj_4c_CmdGprocessa: ButtonCount=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.ButtonCount) + ;
            " Left=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Left) + ;
            " Top=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Top) + ;
            " Width=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Height) + ;
            " Visible=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Visible))
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("3 Buttons(1) Processar: Caption=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(1).Caption + "]" + ;
            " Picture=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(1).Picture + "]" + ;
            " FILE()=" + TRANSFORM(FILE(loc_oForm.obj_4c_CmdGprocessa.Buttons(1).Picture)))
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("4 Buttons(2) Encerrar: Caption=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Caption + "]" + ;
            " Picture=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Picture + "]" + ;
            " FILE()=" + TRANSFORM(FILE(loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Picture)) + ;
            " Cancel=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Cancel))
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("5 cnt_4c_Sombra ainda OK: LblTitulo=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]")
    CATCH TO loc_oErro
        LogP("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.Release()
        LogP("6 Release() OK")
    CATCH TO loc_oErro
        LogP("6 FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogP("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogP("DIALOGOS: nenhum")
ENDIF
LogP("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogP(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF4, 1)
ENDPROC
