*==============================================================================
* ProbeBin646Fase8.prg - Probe da Fase 8 de FormSIGOPBIN (task646)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) os 5 controles do legado existem (2 labels + textbox + container c/ 2 labels)
*   3) escopos: FormParaBO/BOParaForm PROTECTED (FormBase os declara assim e o
*      VFP9 nao permite alargar) e BinKeyPress/ValidarCampoBin PUBLIC
*      (alvos de BINDEVENT / chamada externa - regra CLAUDE.md #3)
*   4) FormParaBO le o TextBox e alimenta BO.this_cCodBins
*   5) BOParaForm espelha BO.this_cCodBins de volta no TextBox
*   6) ObterResultadoSaida reproduz o Unload legado:
*        Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
*   7) MaxLength do campo = 6 (SigOpFpb.codbins char(6)) e InputMask do SCX
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless. NAO exercita ValidarBin com valor preenchido: o SQL Server
* 192.168.200.10 nao tem rota desta maquina (gnConnHandle = -1 aqui).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_bin646.txt"
#DEFINE OUT "C:\4c\automation\probe_bin646_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_cRes
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSIGOPBIN ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPBINBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPBIN.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeBin646Fase8.prg"      ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao, com o pPag que o form chamador passa
    loc_oForm = CREATEOBJECT("ProbeBinF8", "001")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Width=" + TRANSFORM(loc_oForm.Width) + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + ;
                  " Fpagto=[" + ALLTRIM(loc_oForm.this_cFpagto) + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) os controles do legado
    loc_cL = "2) controles do legado:" + CHR(13) + CHR(10) + ;
        "   lbl_4c_Frase     = " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Frase", 5))  + CHR(13) + CHR(10) + ;
        "   lbl_4c_Label2    = " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label2", 5)) + CHR(13) + CHR(10) + ;
        "   txt_4c_Bin       = " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Bin", 5))    + CHR(13) + CHR(10) + ;
        "   cnt_4c_Sombra    = " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + CHR(13) + CHR(10)
    IF !(PEMSTATUS(loc_oForm, "lbl_4c_Frase", 5) AND PEMSTATUS(loc_oForm, "lbl_4c_Label2", 5) ;
         AND PEMSTATUS(loc_oForm, "txt_4c_Bin", 5) AND PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5))
        loc_cL = loc_cL + "   *** FALHA: controle do legado ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos
    loc_cL = "3) escopos (atributo 2 = Protected):" + CHR(13) + CHR(10) + ;
        "   FormParaBO      Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2))      + " esperado .T." + CHR(13) + CHR(10) + ;
        "   BOParaForm      Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2))      + " esperado .T." + CHR(13) + CHR(10) + ;
        "   BinKeyPress     Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BinKeyPress", 2))     + " esperado .F." + CHR(13) + CHR(10) + ;
        "   ValidarCampoBin Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarCampoBin", 2)) + " esperado .F." + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2) ;
       OR PEMSTATUS(loc_oForm, "BinKeyPress", 2) OR PEMSTATUS(loc_oForm, "ValidarCampoBin", 2)
        loc_cL = loc_cL + "   *** FALHA: escopo errado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) FormParaBO le o controle e alimenta o BO
    loc_oForm.txt_4c_Bin.Value = "411111"
    loc_oBO.this_cCodBins      = ""
    loc_oForm.TesteFormParaBO()
    loc_cL = "4) FormParaBO: txt=[411111] -> BO.this_cCodBins=[" + ;
             ALLTRIM(loc_oBO.this_cCodBins) + "] esperado [411111]" + CHR(13) + CHR(10)
    IF ALLTRIM(loc_oBO.this_cCodBins) != "411111"
        loc_cL = loc_cL + "   *** FALHA" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) BOParaForm espelha de volta
    loc_oForm.txt_4c_Bin.Value = ""
    loc_oBO.this_cCodBins      = "550000"
    loc_oForm.TesteBOParaForm()
    loc_cL = "5) BOParaForm: BO=[550000] -> txt=[" + ;
             ALLTRIM(loc_oForm.txt_4c_Bin.Value) + "] esperado [550000]" + CHR(13) + CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_Bin.Value) != "550000"
        loc_cL = loc_cL + "   *** FALHA" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) ObterResultadoSaida reproduz o Unload legado, nos dois estados
    loc_oBO.this_lZSen    = .F.
    loc_oBO.this_cUsuLibs = ""
    loc_cRes = loc_oForm.ObterResultadoSaida()
    loc_cL = "6) ObterResultadoSaida (Unload legado):" + CHR(13) + CHR(10) + ;
             "   ZSen=.F. UsuLibs=[]       -> [" + loc_cRes + "] esperado [ ]" + CHR(13) + CHR(10)
    IF loc_cRes != " "
        loc_cL = loc_cL + "   *** FALHA no ramo NAO autorizado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oBO.this_lZSen    = .T.
    loc_oBO.this_cUsuLibs = "411111"
    loc_cRes = loc_oForm.ObterResultadoSaida()
    loc_cL = loc_cL + "   ZSen=.T. UsuLibs=[411111] -> [" + loc_cRes + "] esperado [*411111]" + CHR(13) + CHR(10)
    IF loc_cRes != "*411111"
        loc_cL = loc_cL + "   *** FALHA no ramo autorizado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) MaxLength = largura da coluna no schema; InputMask transcrito do SCX
    loc_cL = "7) campo: MaxLength=" + TRANSFORM(loc_oForm.txt_4c_Bin.MaxLength) + ;
             " esperado 6 (SigOpFpb.codbins char(6))" + CHR(13) + CHR(10) + ;
             "   InputMask=[" + loc_oForm.txt_4c_Bin.InputMask + "] (transcrito do SCX)" + CHR(13) + CHR(10) + ;
             "   Alignment=" + TRANSFORM(loc_oForm.txt_4c_Bin.Alignment) + " esperado 3" + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_Bin.MaxLength != 6
        loc_cL = loc_cL + "   *** FALHA: MaxLength fora do schema" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE(CHR(13) + CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10) + "PROBE_FALHAS=EXCECAO" + ;
              CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT

*-- Subclasse para alcancar os hooks PROTECTED: script solto NAO alcanca
*-- membro protegido, subclasse alcanca (regra conhecida do projeto).
DEFINE CLASS ProbeBinF8 AS FormSIGOPBIN
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
ENDDEFINE
