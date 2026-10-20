*==============================================================================
* ProbeBcb645Fase8.prg - Probe da Fase 8 de FormSigOpBcb (task645)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) escopos: LimparCampos/FormParaBO/BOParaForm PROTECTED (FormBase os
*      declara assim e o VFP9 nao permite alargar) e ConsultarCodigo PUBLIC
*      (alvo de BINDEVENT - regra CLAUDE.md #3)
*   3) LimparCampos limpa os 6 campos de exibicao + as 2 unidades
*   4) FormParaBO converte o codigo digitado e recusa codigo vazio
*   5) BOParaForm espelha as properties do BO, com o padding do banco
*      preservado nas unidades - "( KG )", igual ao legado
*   6) a guarda de reentrancia NAO TRAVA ligada apos saida antecipada
*   7) BtnConfirmarClick sem codigo na tela nao tenta gravar
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_bcb645.txt"
#DEFINE OUT "C:\4c\automation\probe_bcb645_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_lR, loc_oE
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpBcb ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpBcbBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpBcb.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeBcb645Fase8.prg"      ADDITIVE

    gnConnHandle = -1

    loc_oForm = CREATEOBJECT("ProbeBcbF8")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    loc_cL = "2) escopos (PEMSTATUS atributo 2 = Protected):" + CHR(13) + CHR(10) + ;
        "   LimparCampos    Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2))    + " esperado .T." + CHR(13) + CHR(10) + ;
        "   FormParaBO      Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2))      + " esperado .T." + CHR(13) + CHR(10) + ;
        "   BOParaForm      Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2))      + " esperado .T." + CHR(13) + CHR(10) + ;
        "   ConsultarCodigo Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ConsultarCodigo", 2)) + " esperado .F." + CHR(13) + CHR(10) + ;
        "   CodigoLostFocus Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CodigoLostFocus", 2)) + " esperado .F." + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "LimparCampos", 2) OR !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR ;
       !PEMSTATUS(loc_oForm, "BOParaForm", 2) OR PEMSTATUS(loc_oForm, "ConsultarCodigo", 2) OR ;
       PEMSTATUS(loc_oForm, "CodigoLostFocus", 2)
        loc_cL = loc_cL + "   *** FALHA de escopo" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    loc_oForm.txt_4c_Grupo.Value    = "G1"
    loc_oForm.txt_4c_Conta.Value    = "C1"
    loc_oForm.txt_4c_Produto.Value  = "P1"
    loc_oForm.txt_4c__dpro.Value    = "DESCRICAO"
    loc_oForm.txt_4c_Qtde.Value     = 7
    loc_oForm.txt_4c__peso.Value    = 9
    loc_oForm.lbl_4c_Label5.Caption = "( KG )"
    loc_oForm.lbl_4c_Label6.Caption = "( UN )"
    loc_oForm.TesteLimparCampos()
    loc_cL = "3) pos LimparCampos: Grupo=[" + loc_oForm.txt_4c_Grupo.Value + "]" + ;
             " Dpro=[" + loc_oForm.txt_4c__dpro.Value + "]" + ;
             " Qtde=" + TRANSFORM(loc_oForm.txt_4c_Qtde.Value) + ;
             " Peso=" + TRANSFORM(loc_oForm.txt_4c__peso.Value) + ;
             " Un1=[" + loc_oForm.lbl_4c_Label5.Caption + "]" + ;
             " Un2=[" + loc_oForm.lbl_4c_Label6.Caption + "]" + CHR(13) + CHR(10)
    IF !EMPTY(loc_oForm.txt_4c_Grupo.Value) OR !EMPTY(loc_oForm.txt_4c__dpro.Value) OR ;
       loc_oForm.txt_4c_Qtde.Value != 0 OR loc_oForm.txt_4c__peso.Value != 0 OR ;
       !EMPTY(loc_oForm.lbl_4c_Label5.Caption) OR !EMPTY(loc_oForm.lbl_4c_Label6.Caption)
        loc_cL = loc_cL + "   *** FALHA: LimparCampos nao limpou tudo" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    loc_oForm.txt_4c_Codigo.Value = "00000000012345"
    loc_lR = loc_oForm.TesteFormParaBO()
    loc_cL = "4) FormParaBO [00000000012345] -> retorno=" + TRANSFORM(loc_lR) + ;
             " BO.this_nCbars=" + TRANSFORM(loc_oBO.this_nCbars) + " esperado .T./12345" + CHR(13) + CHR(10)
    IF !loc_lR OR loc_oBO.this_nCbars != 12345
        loc_cL = loc_cL + "   *** FALHA na conversao" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_Codigo.Value = SPACE(14)
    loc_lR = loc_oForm.TesteFormParaBO()
    loc_cL = loc_cL + "   FormParaBO SPACE(14) -> retorno=" + TRANSFORM(loc_lR) + ;
             " BO.this_nCbars=" + TRANSFORM(loc_oBO.this_nCbars) + " esperado .F./0" + CHR(13) + CHR(10)
    IF loc_lR OR loc_oBO.this_nCbars != 0
        loc_cL = loc_cL + "   *** FALHA: codigo vazio deveria recusar" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    loc_oBO.this_cGrupos  = "001"
    loc_oBO.this_cContas  = "0100"
    loc_oBO.this_cCpros   = "PRO001"
    loc_oBO.this_cDpros   = "PRODUTO DE TESTE"
    loc_oBO.this_nQtds    = 12.5
    loc_oBO.this_nPesos   = 3.75
    loc_oBO.this_cCunis   = "KG "
    loc_oBO.this_cCunips  = "UN "
    loc_oForm.TesteBOParaForm()
    loc_cL = "5) pos BOParaForm: Grupo=[" + loc_oForm.txt_4c_Grupo.Value + "]" + ;
             " Conta=[" + loc_oForm.txt_4c_Conta.Value + "]" + ;
             " Produto=[" + loc_oForm.txt_4c_Produto.Value + "]" + ;
             " Dpro=[" + ALLTRIM(loc_oForm.txt_4c__dpro.Value) + "]" + ;
             " Qtde=" + TRANSFORM(loc_oForm.txt_4c_Qtde.Value) + ;
             " Peso=" + TRANSFORM(loc_oForm.txt_4c__peso.Value) + ;
             " Un1=[" + loc_oForm.lbl_4c_Label5.Caption + "]" + ;
             " Un2=[" + loc_oForm.lbl_4c_Label6.Caption + "]" + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_Qtde.Value != 12.5 OR loc_oForm.txt_4c__peso.Value != 3.75 OR ;
       loc_oForm.lbl_4c_Label5.Caption != "( KG )" OR loc_oForm.lbl_4c_Label6.Caption != "( UN )"
        loc_cL = loc_cL + "   *** FALHA: espelho/padding divergente do legado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    loc_oForm.txt_4c_Codigo.Value = "00000000012345"
    loc_lR = loc_oForm.ConsultarCodigo()
    loc_cL = "6) ConsultarCodigo 1a vez -> retorno=" + TRANSFORM(loc_lR) + ;
             " flag=" + TRANSFORM(loc_oForm.this_lEmConsulta) + " flag esperada .F." + CHR(13) + CHR(10)
    IF loc_oForm.this_lEmConsulta
        loc_cL = loc_cL + "   *** FALHA: flag TRAVOU ligada - lookup morreria" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_Codigo.Value = "00000000012345"
    loc_lR = loc_oForm.ConsultarCodigo()
    loc_cL = loc_cL + "   ConsultarCodigo 2a vez -> retorno=" + TRANSFORM(loc_lR) + ;
             " flag=" + TRANSFORM(loc_oForm.this_lEmConsulta) + CHR(13) + CHR(10)
    IF loc_oForm.this_lEmConsulta
        loc_cL = loc_cL + "   *** FALHA: flag TRAVOU na 2a chamada" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.this_lEmConsulta = .T.
    loc_lR = loc_oForm.ConsultarCodigo()
    loc_cL = loc_cL + "   com flag ligada -> retorno=" + TRANSFORM(loc_lR) + " esperado .F." + CHR(13) + CHR(10)
    IF loc_lR
        loc_cL = loc_cL + "   *** FALHA: guarda nao bloqueou a reentrancia" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.this_lEmConsulta = .F.
    STRTOFILE(loc_cL, OUT, 1)

    loc_oForm.txt_4c_Codigo.Value = SPACE(14)
    loc_oBO.this_cMensagemErro = ""
    loc_oBO.this_lEtiquetaLocalizada = .F.
    loc_oForm.BtnConfirmarClick()
    loc_cL = "7) BtnConfirmarClick sem codigo -> BO.this_cMensagemErro=[" + ;
             ALLTRIM(loc_oBO.this_cMensagemErro) + "] esperado vazio" + CHR(13) + CHR(10)
    IF !EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro))
        loc_cL = loc_cL + "   *** FALHA: tentou gravar sem codigo" + CHR(13) + CHR(10)
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

DEFINE CLASS ProbeBcbF8 AS FormSigOpBcb
    PROCEDURE TesteLimparCampos()
        THIS.LimparCampos()
    ENDPROC
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    PROCEDURE TesteBOParaForm()
        THIS.BOParaForm()
    ENDPROC
ENDDEFINE
