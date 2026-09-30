*==============================================================================
* InstantiateCheckSigPrGf1F3.prg - valida a Fase 3 de FormSigPrGf1 (task612)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA e reproduz a geometria do legado (800x158);
*   2. cnt_4c_Sombra existe com os labels lbl_4c_LblSombra/lbl_4c_LblTitulo
*      preenchidos com THIS.Caption.
*
* gnConnHandle = 1 eh handle FALSO: o Init do BO nao faz SQL (so seta datas
* default e a empresa corrente), entao nem precisa de handle real.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF3, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprgf1f3.txt"
gc_4c_LogF3            = "C:\4c\automation\instantiate_sigprgf1f3_result.txt"
gnConnHandle           = 1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF3)
    DELETE FILE (gc_4c_LogF3)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprgf1.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprgf1.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprgf1bo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprgf1bo.fxp"
ENDIF

LOCAL loc_oForm, loc_oErro
LogP("FASE3 task612 - inicio " + TTOC(DATETIME()))

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
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    TRY
        LogP("2 cnt_4c_Sombra: BackColor=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.BackColor) + ;
            " LblSombra=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + ;
            " LblTitulo=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]")
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("3 BO instanciado: VARTYPE=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
            " Empresa=[" + loc_oForm.this_oBusinessObject.this_cEmpresa + "]" + ;
            " DtIni=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " DtFim=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFinal))
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.Release()
        LogP("4 Release() OK")
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message)
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
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF3, 1)
ENDPROC
