SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_drstits.txt"
#DEFINE OUT "C:\4c\automation\probe_drstits.txt"

LOCAL loc_oForm, loc_nI, loc_oObj, loc_oE

STRTOFILE("=== PROBE FormDrs / selecao de Tits ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "4control"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "DrsBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDrs.prg") ADDITIVE

    *-- ===== CENARIO A: com par_cTits (como o legado: DO FORM ... WITH pPrg)
    STRTOFILE(CHR(13) + CHR(10) + "--- A) CREATEOBJECT FormDrs COM par_cTits = FICHA TESTE ---" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm = CREATEOBJECT("FormDrs", "FICHA TESTE")
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("   VARTYPE=O | this_lSemTits=" + TRANSFORM(loc_oForm.this_lSemTits) + ;
            " | this_cTits=[" + ALLTRIM(loc_oForm.this_cTits) + "]" + ;
            " | Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
        IF PEMSTATUS(loc_oForm, "pgf_4c_Paginas", 5)
            STRTOFILE("   Botoes Page1:" + CHR(13) + CHR(10), OUT, 1)
            WITH loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                FOR loc_nI = 1 TO .ControlCount
                    loc_oObj = .Controls(loc_nI)
                    STRTOFILE("      " + PADR(loc_oObj.Name, 22) + " Left=" + ;
                        PADL(TRANSFORM(loc_oObj.Left), 4) + CHR(13) + CHR(10), OUT, 1)
                ENDFOR
            ENDWITH
            STRTOFILE("   cnt_4c_Campos Left=" + ;
                TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Campos.Left) + ;
                " Width=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Campos.Width) + ;
                " (form Width=" + TRANSFORM(loc_oForm.Width) + ")" + CHR(13) + CHR(10), OUT, 1)
        ELSE
            STRTOFILE("   *** pgf_4c_Paginas NAO existe (form nao montou)" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        loc_oForm.Release()
    ELSE
        STRTOFILE("   *** VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    ENDIF
    loc_oForm = .NULL.

    *-- ===== CENARIO B: sem parametro -> SelecionarTits (SigSyCit vazio nesta base)
    STRTOFILE(CHR(13) + CHR(10) + "--- B) CREATEOBJECT FormDrs SEM parametro ---" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm = CREATEOBJECT("FormDrs")
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("   VARTYPE=O | this_lSemTits=" + TRANSFORM(loc_oForm.this_lSemTits) + ;
            " | this_cTits=[" + ALLTRIM(loc_oForm.this_cTits) + "]" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   (menu: this_lSemTits=.T. -> Release() sem mensagem de erro)" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.Release()
    ELSE
        STRTOFILE("   *** VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + "FIM" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT
