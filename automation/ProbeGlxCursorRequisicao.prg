*==============================================================================
* ProbeGlxCursorRequisicao.prg - o probe da Fase 6 acusou
*   "5 PAGE6 FALHOU: Alias is not found."
* ao medir RECCOUNT("cursor_4c_Requisicao") de FORA do form.
*
* Hipotese: FormSigPrGlx tem DataSession = 2 (private), entao os cursores
* criados pelo InicializarForm vivem na sessao do FORM, nao na do script.
* Nao seria um defeito do form, e sim do instrumento.
*
* Mede entrando na DataSessionId do proprio form antes de contar.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glxcur.txt"

LOCAL loc_oForm, loc_oErro, loc_cLog, loc_nSessaoScript
loc_cLog = "C:\4c\automation\logs\probe_glx_cursor_requisicao.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlxBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlx.prg") ADDITIVE
    GravaCur(loc_cLog, "0 SETUP OK")
CATCH TO loc_oErro
    GravaCur(loc_cLog, "0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

loc_nSessaoScript = SET("Datasession")

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGlx")
    GravaCur(loc_cLog, "1 Form DataSession=" + TRANSFORM(loc_oForm.DataSession) + ;
        " DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
        " / sessao do script=" + TRANSFORM(loc_nSessaoScript))

    *-- FORA da sessao do form (foi aqui que o probe anterior estourou)
    GravaCur(loc_cLog, "2 FORA: USED(cursor_4c_Requisicao)=" + ;
        TRANSFORM(USED("cursor_4c_Requisicao")))

    *-- DENTRO da sessao do form
    SET DATASESSION TO loc_oForm.DataSessionId
    GravaCur(loc_cLog, "3 DENTRO: USED(cursor_4c_Requisicao)=" + ;
        TRANSFORM(USED("cursor_4c_Requisicao")) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Requisicao")))
    GravaCur(loc_cLog, "4 DENTRO: cursor_4c_Dados USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
        " / cursor_4c_Linhas USED=" + TRANSFORM(USED("cursor_4c_Linhas")) + ;
        " / cursor_4c_DispEstoque USED=" + TRANSFORM(USED("cursor_4c_DispEstoque")) + ;
        " / cursor_4c_DispTamanho USED=" + TRANSFORM(USED("cursor_4c_DispTamanho")))

    *-- A linha em branco do Init legado (Append Blank) existe e eh editavel?
    SELECT cursor_4c_Requisicao
    GO TOP
    GravaCur(loc_cLog, "5 linha em branco: RECNO=" + TRANSFORM(RECNO()) + ;
        " Cpros=[" + cursor_4c_Requisicao.Cpros + "]" + ;
        " EOF=" + TRANSFORM(EOF()))

    *-- GarantirLinhaLivreRequisicao acrescenta linha quando a unica eh usada?
    REPLACE Cpros WITH "TESTE01" IN cursor_4c_Requisicao
    SET DATASESSION TO loc_nSessaoScript
    loc_oForm.AlternarPagina(1)
    SET DATASESSION TO loc_oForm.DataSessionId
    GravaCur(loc_cLog, "6 apos preencher a unica linha: RECCOUNT=" + ;
        TRANSFORM(RECCOUNT("cursor_4c_Requisicao")))

    SET DATASESSION TO loc_nSessaoScript
    loc_oForm.Release()
    GravaCur(loc_cLog, "7 RELEASE OK")
CATCH TO loc_oErro
    GravaCur(loc_cLog, "FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

QUIT

PROCEDURE GravaCur(par_cArq, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArq, 1)
ENDPROC
