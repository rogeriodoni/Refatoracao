*==============================================================================
* InstantiateCheckSigopclgF3.prg - valida a Fase 3 de Formsigopclg (task703)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA (1000x600) sem SQL (gb_4c_ModoTeste bypassa
*      ValidarParametros);
*   2. pgf_4c_Paginas existe com 2 paginas (Dados/Resultado);
*   3. cnt_4c_Cabecalho existe nas DUAS paginas com os labels preenchidos
*      com THIS.Caption;
*   4. cnt_4c_Botoes (Page1) e cnt_4c_BotoesAcao (Page2) existem, vazios,
*      nas posicoes esperadas;
*   5. this_oBusinessObject foi instanciado como sigopclgBO.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF3, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigopclgf3.txt"
gc_4c_LogF3            = "C:\4c\automation\instantiate_sigopclgf3_result.txt"
gnConnHandle           = 1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF3)
    DELETE FILE (gc_4c_LogF3)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopclg.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopclg.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopclgbo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigopclgbo.fxp"
ENDIF

LOCAL loc_oForm, loc_oErro
LogP("FASE3 task703 - inicio " + TTOC(DATETIME()))

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
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopclgBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopclg.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("Formsigopclg")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    TRY
        LogP("2 pgf_4c_Paginas: PageCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.PageCount) + ;
            " Top=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Top) + ;
            " Page1.Caption=[" + loc_oForm.pgf_4c_Paginas.Page1.Caption + "]" + ;
            " Page2.Caption=[" + loc_oForm.pgf_4c_Paginas.Page2.Caption + "]" + ;
            " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage))
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("3 Page1.cnt_4c_Cabecalho: BackColor=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.BackColor) + ;
            " Sombra=[" + loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption + "]" + ;
            " Titulo=[" + loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]")
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("4 Page2.cnt_4c_Cabecalho: BackColor=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.BackColor) + ;
            " Sombra=[" + loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption + "]" + ;
            " Titulo=[" + loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]")
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("5 Page1.cnt_4c_Botoes: Left=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Left) + ;
            " Top=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Top) + ;
            " Width=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Height))
    CATCH TO loc_oErro
        LogP("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("6 Page2.cnt_4c_BotoesAcao: Left=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.Left) + ;
            " Top=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.Top) + ;
            " Width=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.Height))
    CATCH TO loc_oErro
        LogP("6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("7 BO instanciado: VARTYPE=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
            " Tabela=[" + loc_oForm.this_oBusinessObject.this_cTabela + "]" + ;
            " CampoChave=[" + loc_oForm.this_oBusinessObject.this_cCampoChave + "]")
    CATCH TO loc_oErro
        LogP("7 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.Release()
        LogP("8 Release() OK")
    CATCH TO loc_oErro
        LogP("8 FALHOU: " + loc_oErro.Message)
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
