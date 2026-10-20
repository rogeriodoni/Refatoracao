*==============================================================================
* ProbeTam680F6.prg - Probe funcional da Fase 6 de Formsigprtam (task680)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA em modo teste
*   2) cada Column da grade recebeu o TextBox de celula e esta exibindo ele
*      (CurrentControl + Sparse = .F. - regra #18), com o this_cPapel certo
*   3) escopos: os metodos chamados PELA CLASSE DA CELULA (de fora do form)
*      sao PUBLIC - CelulaGradeEditavel / ValidarCelulaGradeExec /
*      ValidarTamanhoGridExec / ValidarPercGridExec / ValidarValorGridExec /
*      GravarCelulaNumericaExec / AbrirLookupTamanhoGrade (regra #3/#51)
*   4) o When (CelulaGradeEditavel) devolve .F. em VISUALIZAR e .T. em
*      ALTERAR, e guarda o valor anterior na property NUMERICA certa sem
*      estourar o Tag (Tag eh estritamente Character no VFP9)
*   5) o Valid (ValidarCelulaGradeExec) nao estoura com a grade sem cursor
*      nem em modo VISUALIZAR
*
* NAO chama Show(): o form eh modal em producao e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_tam680.txt"
#DEFINE OUT "C:\4c\automation\probe_tam680_f6.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_oTxt, loc_lR
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 6 - Formsigprtam (task680) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprtamBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprtam.prg") ADDITIVE

    gnConnHandle    = -1
    gb_4c_ModoTeste = .T.

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("Formsigprtam", .NULL., "ALTERAR", "PRODTESTE")
    loc_cL = "1) VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        loc_cL = loc_cL + "   FALHA: form nao instanciou" + CHR(13) + CHR(10)
        STRTOFILE(loc_cL, OUT, 1)
    ELSE
        STRTOFILE(loc_cL, OUT, 1)

        *-- 2) celulas instaladas em cada Column
        STRTOFILE("2) celulas da grade" + CHR(13) + CHR(10), OUT, 1)
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column1, "txt_4c_CelCodTam",  "COD")
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column2, "txt_4c_CelDescTam", "DESC")
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column3, "txt_4c_CelPeso",    "PESO")
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column4, "txt_4c_CelPerc",    "PERC")
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column5, "txt_4c_CelValor",   "VALOR")
        loc_nFalhas = loc_nFalhas + ConferirCelula(loc_oForm.grd_4c_Dados.Column6, "txt_4c_CelPrazo",   "PRAZO")

        *-- 3) escopos (2 = PROTECTED; a classe da celula chama de FORA)
        STRTOFILE("3) escopo dos metodos chamados pela classe da celula" + CHR(13) + CHR(10), OUT, 1)
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "CelulaGradeEditavel")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "ValidarCelulaGradeExec")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "ValidarTamanhoGridExec")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "ValidarPercGridExec")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "ValidarValorGridExec")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "GravarCelulaNumericaExec")
        loc_nFalhas = loc_nFalhas + ConferirPublico(loc_oForm, "AbrirLookupTamanhoGrade")

        *-- 4) When: modo e captura do valor anterior
        STRTOFILE("4) When (CelulaGradeEditavel)" + CHR(13) + CHR(10), OUT, 1)

        loc_oTxt = loc_oForm.grd_4c_Dados.Column1.txt_4c_CelCodTam
        loc_oTxt.Value = "PP"
        loc_lR = loc_oForm.CelulaGradeEditavel("COD", loc_oTxt)
        STRTOFILE("   ALTERAR / COD   -> " + TRANSFORM(loc_lR) + "  Tag=[" + loc_oTxt.Tag + "]" + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lR OR !(loc_oTxt.Tag == "PP")
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .T. com Tag [PP]" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- celula NUMERICA: o valor anterior vai para property, nunca para o Tag
        loc_oTxt = loc_oForm.grd_4c_Dados.Column3.txt_4c_CelPeso
        loc_oTxt.Value = 12.5
        loc_lR = loc_oForm.CelulaGradeEditavel("PESO", loc_oTxt)
        STRTOFILE("   ALTERAR / PESO  -> " + TRANSFORM(loc_lR) + ;
                  "  this_nPesoAnterior=" + TRANSFORM(loc_oForm.this_nPesoAnterior) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lR OR loc_oForm.this_nPesoAnterior != 12.5
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .T. com this_nPesoAnterior = 12.5" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        loc_oTxt = loc_oForm.grd_4c_Dados.Column5.txt_4c_CelValor
        loc_oTxt.Value = 99.75
        loc_lR = loc_oForm.CelulaGradeEditavel("VALOR", loc_oTxt)
        STRTOFILE("   ALTERAR / VALOR -> " + TRANSFORM(loc_lR) + ;
                  "  this_nValorAnterior=" + TRANSFORM(loc_oForm.this_nValorAnterior) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lR OR loc_oForm.this_nValorAnterior != 99.75
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .T. com this_nValorAnterior = 99.75" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- modo VISUALIZAR trava as seis celulas (llVis do Init legado)
        loc_oForm.this_cEscolha = "VISUALIZAR"
        loc_oTxt = loc_oForm.grd_4c_Dados.Column1.txt_4c_CelCodTam
        loc_lR = loc_oForm.CelulaGradeEditavel("COD", loc_oTxt)
        STRTOFILE("   VISUALIZAR/COD  -> " + TRANSFORM(loc_lR) + CHR(13) + CHR(10), OUT, 1)
        IF loc_lR
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .F. em VISUALIZAR" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 5) Valid nao estoura sem cursor / em VISUALIZAR
        STRTOFILE("5) Valid (ValidarCelulaGradeExec) sem cursor" + CHR(13) + CHR(10), OUT, 1)
        loc_lR = loc_oForm.ValidarCelulaGradeExec("COD", loc_oTxt)
        STRTOFILE("   VISUALIZAR/COD  -> " + TRANSFORM(loc_lR) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lR
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .T. (sem cursor nao ha o que validar)" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        loc_oForm.this_cEscolha = "ALTERAR"
        loc_lR = loc_oForm.ValidarCelulaGradeExec("PESO", loc_oForm.grd_4c_Dados.Column3.txt_4c_CelPeso)
        STRTOFILE("   ALTERAR / PESO  -> " + TRANSFORM(loc_lR) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lR
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado .T." + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    loc_nFalhas = loc_nFalhas + 1
    STRTOFILE("EXCECAO: " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
              " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10), OUT, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("ERROS/AVISOS CAPTURADOS:" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
QUIT


*------------------------------------------------------------------------------
FUNCTION ConferirCelula(par_oCol, par_cNome, par_cPapel)
    LOCAL loc_nF, loc_cCur, loc_lSparse, loc_cPapel, loc_lTem
    loc_nF = 0

    loc_lTem = PEMSTATUS(par_oCol, par_cNome, 5)
    IF !loc_lTem
        STRTOFILE("   " + par_cNome + ": AUSENTE na Column - FALHA" + CHR(13) + CHR(10), OUT, 1)
        RETURN 1
    ENDIF

    loc_cCur    = par_oCol.CurrentControl
    loc_lSparse = par_oCol.Sparse
    loc_cPapel  = EVALUATE("par_oCol." + par_cNome + ".this_cPapel")

    STRTOFILE("   " + par_cNome + ": CurrentControl=[" + loc_cCur + "] Sparse=" + ;
              TRANSFORM(loc_lSparse) + " this_cPapel=[" + loc_cPapel + "]" + CHR(13) + CHR(10), OUT, 1)

    IF !(UPPER(ALLTRIM(loc_cCur)) == UPPER(par_cNome))
        loc_nF = loc_nF + 1
        STRTOFILE("      FALHA: CurrentControl nao aponta para a celula" + CHR(13) + CHR(10), OUT, 1)
    ENDIF
    IF loc_lSparse
        loc_nF = loc_nF + 1
        STRTOFILE("      FALHA: Sparse deveria ser .F." + CHR(13) + CHR(10), OUT, 1)
    ENDIF
    IF !(loc_cPapel == par_cPapel)
        loc_nF = loc_nF + 1
        STRTOFILE("      FALHA: this_cPapel esperado [" + par_cPapel + "]" + CHR(13) + CHR(10), OUT, 1)
    ENDIF

    RETURN loc_nF
ENDFUNC


*------------------------------------------------------------------------------
FUNCTION ConferirPublico(par_oForm, par_cMetodo)
    LOCAL loc_lExiste, loc_lProt
    loc_lExiste = PEMSTATUS(par_oForm, par_cMetodo, 5)
    loc_lProt   = IIF(loc_lExiste, PEMSTATUS(par_oForm, par_cMetodo, 2), .F.)

    STRTOFILE("   " + PADR(par_cMetodo, 26) + " existe=" + TRANSFORM(loc_lExiste) + ;
              " protected=" + TRANSFORM(loc_lProt) + CHR(13) + CHR(10), OUT, 1)

    IF !loc_lExiste OR loc_lProt
        STRTOFILE("      FALHA: tem de existir e ser PUBLIC" + CHR(13) + CHR(10), OUT, 1)
        RETURN 1
    ENDIF
    RETURN 0
ENDFUNC
