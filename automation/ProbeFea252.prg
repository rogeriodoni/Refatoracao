*==============================================================================
* ProbeFea252.prg - Erro252: FormFea nao abria
*   "Erro em ConfigurarResultado: Alias 'TMPOPERA' is not found. Linha: 4398"
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA (antes: ConfigurarResultado estourava e o Init devolvia .F.)
*   2) TmpOpera / TmpResFas / TmpResumo existem logo apos o Init (legado: Load)
*   3) as grades do container Resultado ficaram realmente ligadas aos cursores
*      (RecordSource + Column.ControlSource sobrevivem ao Init)
* NAO chama Show(): travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fea252.txt"
#DEFINE OUT "C:\4c\automation\probe_fea252.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_oCnt, loc_oG
loc_nFalhas = 0
STRTOFILE("=== PROBE Erro252 - FormFea ===" + CHR(13)+CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FeaBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFea.prg") ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    loc_oForm = CREATEOBJECT("FormFea")
    loc_cL = "1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_cL = "2) cursores: TmpOpera=" + TRANSFORM(USED("TmpOpera")) + ;
             " TmpResFas=" + TRANSFORM(USED("TmpResFas")) + ;
             " TmpResumo=" + TRANSFORM(USED("TmpResumo")) + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF !(USED("TmpOpera") AND USED("TmpResFas") AND USED("TmpResumo"))
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oCnt = loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Resultado
    loc_oG = loc_oCnt.Pagina.Pages(1).GradeEntradas
    loc_cL = "3) GradeEntradas RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + ;
             " Col5=[" + loc_oG.Column5.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF UPPER(ALLTRIM(loc_oG.Column1.ControlSource)) != "TMPOPERA.TPOPS"
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oG = loc_oCnt.Pagina.Pages(3).GradeResumo
    loc_cL = "4) GradeResumo  RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    loc_oG = loc_oCnt.GradeMat
    loc_cL = "5) GradeMat     RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE("PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY
QUIT
