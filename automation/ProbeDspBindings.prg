*==============================================================================
* ProbeDspBindings - lista os BINDEVENTs ativos de txt_4c_cd_grupo e
* txt_4c_cd_conta do FormDsp (Erro229), provando qual EVENTO dispara a
* validacao. AEVENTS(array, oOrigem) - col 3 = evento, col 4 = metodo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_dspbind.txt"
#DEFINE OUT "C:\4c\automation\probe_dspbind.txt"

LOCAL loc_oForm, loc_oE, loc_nI, loc_nQtd, loc_oPg2
LOCAL ARRAY loc_aEv[1]

STRTOFILE("=== PROBE FormDsp / bindings de Grupo e Conta ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "DspBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDsp.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormDsp")
    STRTOFILE("CREATEOBJECT FormDsp -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", "") + ;
        CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        QUIT
    ENDIF

    loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2

    STRTOFILE(CHR(13) + CHR(10) + "--- txt_4c_cd_grupo ---" + CHR(13) + CHR(10), OUT, 1)
    loc_nQtd = AEVENTS(loc_aEv, loc_oPg2.txt_4c_cd_grupo)
    STRTOFILE("   bindings: " + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nI = 1 TO loc_nQtd
        STRTOFILE("   evento=" + PADR(loc_aEv[loc_nI, 3], 12) + ;
            " -> metodo=" + loc_aEv[loc_nI, 4] + CHR(13) + CHR(10), OUT, 1)
    ENDFOR

    STRTOFILE(CHR(13) + CHR(10) + "--- txt_4c_cd_conta ---" + CHR(13) + CHR(10), OUT, 1)
    loc_nQtd = AEVENTS(loc_aEv, loc_oPg2.txt_4c_cd_conta)
    STRTOFILE("   bindings: " + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nI = 1 TO loc_nQtd
        STRTOFILE("   evento=" + PADR(loc_aEv[loc_nI, 3], 12) + ;
            " -> metodo=" + loc_aEv[loc_nI, 4] + CHR(13) + CHR(10), OUT, 1)
    ENDFOR

    STRTOFILE(CHR(13) + CHR(10) + "guardas: this_lEmLookupGrupo=" + ;
        TRANSFORM(loc_oForm.this_lEmLookupGrupo) + ;
        " this_lEmLookupConta=" + TRANSFORM(loc_oForm.this_lEmLookupConta) + ;
        CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("FIM" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm.Release()

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT
