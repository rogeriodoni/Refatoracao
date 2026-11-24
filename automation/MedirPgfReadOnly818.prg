* MedirPgfReadOnly818.prg
* Mede, num PageFrame REAL do projeto (criado por AddObject em runtime),
* quais propriedades aceitam escrita. Usa o mesmo arranque do probe da
* Fase 4, que ja provou funcionar nesta maquina.
SET SAFETY OFF
SET RESOURCE OFF
= SYS(2335, 0)

LOCAL loc_cLog, loc_oForm, loc_oPgf
loc_cLog = "C:\4c\automation\_medir_pgf818b.txt"
= STRTOFILE("inicio" + CHR(13) + CHR(10), loc_cLog)

ON ERROR DO RegErro WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

CD "C:\4c\projeto\app\start"
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpVdiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpVdi.prg") ADDITIVE

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ValidandoUI      = .T.
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_medir_pgf818b_erros.txt"
= STRTOFILE("", gc_4c_ArquivoErroTeste)

loc_oForm = CREATEOBJECT("FormSigOpVdi")
IF VARTYPE(loc_oForm) != "O"
    = STRTOFILE("form nao criado - medicao abortada" + CHR(13) + CHR(10), loc_cLog, 1)
    QUIT
ENDIF

loc_oPgf = loc_oForm.pgf_4c_Paginas
= STRTOFILE("PageFrame real: BaseClass=" + loc_oPgf.BaseClass + CHR(13) + CHR(10) + ;
            "DEFAULT atual BorderWidth=" + TRANSFORM(loc_oPgf.BorderWidth) + ;
            " TabStyle=" + TRANSFORM(loc_oPgf.TabStyle) + CHR(13) + CHR(10), loc_cLog, 1)

= TestaEsc(loc_oPgf, "BorderWidth", 0,   loc_cLog)
= TestaEsc(loc_oPgf, "TabStyle",    0,   loc_cLog)
= TestaEsc(loc_oPgf, "Tabs",        .F., loc_cLog)
= TestaEsc(loc_oPgf, "PageCount",   2,   loc_cLog)
= TestaEsc(loc_oPgf, "Visible",     .T., loc_cLog)

*-- Page (loc_oPag dos metodos Configurar*) - Visible existe?
= TestaEsc(loc_oForm.pgf_4c_Paginas.Page1, "Visible", .T., loc_cLog)
= TestaEsc(loc_oForm.pgf_4c_Paginas.Page1, "Caption", "X", loc_cLog)

loc_oForm.Release()
= STRTOFILE("FIM" + CHR(13) + CHR(10), loc_cLog, 1)
QUIT

PROCEDURE RegErro(par_nErro, par_cMsg, par_nLinha, par_cProg)
    = STRTOFILE("!! ERRO " + TRANSFORM(par_nErro) + " [" + par_cMsg + "]" + CHR(13) + CHR(10), ;
                "C:\4c\automation\_medir_pgf818b.txt", 1)
ENDPROC

PROCEDURE TestaEsc(par_oObj, par_cProp, par_uVal, par_cLog)
    LOCAL loc_cRes, loc_oEx
    TRY
        STORE par_uVal TO ("par_oObj." + par_cProp)
        loc_cRes = "ESCRITA OK"
    CATCH TO loc_oEx
        loc_cRes = "ERRO: " + loc_oEx.Message
    ENDTRY
    = STRTOFILE(PADR(par_cProp, 14) + " : " + loc_cRes + CHR(13) + CHR(10), par_cLog, 1)
ENDPROC
