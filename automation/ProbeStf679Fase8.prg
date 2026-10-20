*==============================================================================
* ProbeStf679Fase8.prg - Probe da Fase 8 de FormSIGPRSTF (task679)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.) com a geometria
*      e as propriedades de janela do SCX
*   2) os controles do legado existem (faixa + 2 labels, shape, 2 campos de
*      senha, legenda, container + label de instrucao, CommandGroup de saida)
*   3) escopos: FormParaBO/BOParaForm/LimparCampos PROTECTED (FormBase os
*      declara assim e o VFP9 nao permite alargar) e ValidarSenha/
*      BtnCancelarClick PUBLIC (alvos de BINDEVENT - regra CLAUDE.md #3)
*   4) FormParaBO le o TextBox e alimenta BO.this_cSenha
*   5) BOParaForm espelha BO.this_cSenha de volta no TextBox
*   6) LimparCampos zera campo + BO + flag (o ThisForm.Senha.Value="" legado)
*   7) ValidarSenha reproduz o SENHA.KeyPress legado: ENTER (13) confirma e
*      ObterSenha devolve o digitado; tecla QUALQUER OUTRA nao confirma
*   8) BtnCancelarClick reproduz o CANCELA.Click legado: ObterSenha devolve ""
*   9) o Caption de instrucao eh o que o Init legado gera em runtime
*  10) o .Picture do botao EXISTE em vbmp (regra #25: Picture ausente falha
*      em SILENCIO)
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless. Nao precisa de SQL: comportamento.json confirma
* metodosComSQL=0 (o dialogo so captura o valor digitado).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_stf679.txt"
#DEFINE OUT "C:\4c\automation\probe_stf679_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_cRes
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSIGPRSTF (SigTfSup) ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRSTFBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRSTF.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeStf679Fase8.prg"      ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao + propriedades de janela do SCX
    loc_oForm = CREATEOBJECT("ProbeStfF8")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Width=" + TRANSFORM(loc_oForm.Width) + " (400)" + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + " (200)" + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + " (0)" + ;
                  " WindowType=" + TRANSFORM(loc_oForm.WindowType) + " (1)" + ;
                  " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    IF loc_oForm.Width != 400 OR loc_oForm.Height != 200 OR loc_oForm.WindowType != 1
        STRTOFILE("   *** FALHA: geometria/modalidade fora do SCX" + CHR(13) + CHR(10), OUT, 1)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) os controles do legado
    loc_cL = "2) controles do legado:" + CHR(13) + CHR(10) + ;
        "   cnt_4c_Sombra          = " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5))          + CHR(13) + CHR(10) + ;
        "   .lbl_4c_LblSombra      = " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)) + CHR(13) + CHR(10) + ;
        "   .lbl_4c_LblTitulo      = " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)) + CHR(13) + CHR(10) + ;
        "   shp_4c_Shape1          = " + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5))          + CHR(13) + CHR(10) + ;
        "   txt_4c_SenhaSupervisor = " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_SenhaSupervisor", 5)) + CHR(13) + CHR(10) + ;
        "   lbl_4c_Label3          = " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label3", 5))          + CHR(13) + CHR(10) + ;
        "   txt_4c_SENHA           = " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_SENHA", 5))           + CHR(13) + CHR(10) + ;
        "   cnt_4c_Container1      = " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Container1", 5))      + CHR(13) + CHR(10) + ;
        "   .lbl_4c_Label1         = " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Container1, "lbl_4c_Label1", 5)) + CHR(13) + CHR(10) + ;
        "   obj_4c_SAIDA           = " + TRANSFORM(PEMSTATUS(loc_oForm, "obj_4c_SAIDA", 5))           + CHR(13) + CHR(10) + ;
        "   .ButtonCount           = " + TRANSFORM(loc_oForm.obj_4c_SAIDA.ButtonCount) + " (1)"       + CHR(13) + CHR(10)
    IF !(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5) AND PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5) ;
         AND PEMSTATUS(loc_oForm, "txt_4c_SenhaSupervisor", 5) AND PEMSTATUS(loc_oForm, "lbl_4c_Label3", 5) ;
         AND PEMSTATUS(loc_oForm, "txt_4c_SENHA", 5) AND PEMSTATUS(loc_oForm, "cnt_4c_Container1", 5) ;
         AND PEMSTATUS(loc_oForm, "obj_4c_SAIDA", 5) AND loc_oForm.obj_4c_SAIDA.ButtonCount = 1)
        loc_cL = loc_cL + "   *** FALHA: controle do legado ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    *-- campo real mascarado; o decorativo do SCX nunca recebe foco
    loc_cL = loc_cL + "   txt_4c_SENHA.PasswordChar=[" + loc_oForm.txt_4c_SENHA.PasswordChar + "] (*)" + ;
             "  txt_4c_SenhaSupervisor.Enabled=" + TRANSFORM(loc_oForm.txt_4c_SenhaSupervisor.Enabled) + " (.F.)" + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_SENHA.PasswordChar != "*" OR loc_oForm.txt_4c_SenhaSupervisor.Enabled
        loc_cL = loc_cL + "   *** FALHA: mascara/estado dos campos fora do SCX" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos
    loc_cL = "3) escopos (atributo 2 = Protected):" + CHR(13) + CHR(10) + ;
        "   FormParaBO       Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2))       + " esperado .T." + CHR(13) + CHR(10) + ;
        "   BOParaForm       Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2))       + " esperado .T." + CHR(13) + CHR(10) + ;
        "   LimparCampos     Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2))     + " esperado .T." + CHR(13) + CHR(10) + ;
        "   ValidarSenha     Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarSenha", 2))     + " esperado .F." + CHR(13) + CHR(10) + ;
        "   BtnCancelarClick Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + " esperado .F." + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2) ;
       OR !PEMSTATUS(loc_oForm, "LimparCampos", 2) ;
       OR PEMSTATUS(loc_oForm, "ValidarSenha", 2) OR PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)
        loc_cL = loc_cL + "   *** FALHA: escopo errado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) FormParaBO le o controle e alimenta o BO
    loc_oForm.txt_4c_SENHA.Value = "X1Y2Z3"
    loc_oBO.this_cSenha          = ""
    loc_oForm.TesteFormParaBO()
    loc_cL = "4) FormParaBO: txt=[X1Y2Z3] -> BO.this_cSenha=[" + ALLTRIM(loc_oBO.this_cSenha) + "] esperado [X1Y2Z3]" + CHR(13) + CHR(10)
    IF ALLTRIM(loc_oBO.this_cSenha) != "X1Y2Z3"
        loc_cL = loc_cL + "   *** FALHA" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) BOParaForm espelha de volta
    loc_oForm.txt_4c_SENHA.Value = ""
    loc_oBO.this_cSenha          = "A9B8"
    loc_oForm.TesteBOParaForm()
    loc_cL = "5) BOParaForm: BO=[A9B8] -> txt=[" + ALLTRIM(loc_oForm.txt_4c_SENHA.Value) + "] esperado [A9B8]" + CHR(13) + CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_SENHA.Value) != "A9B8"
        loc_cL = loc_cL + "   *** FALHA" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) LimparCampos zera campo, BO e flag de confirmacao
    loc_oForm.txt_4c_SENHA.Value = "SUJO"
    loc_oBO.this_cSenha          = "SUJO"
    loc_oBO.this_lConfirmou      = .T.
    loc_oForm.TesteLimparCampos()
    loc_cL = "6) LimparCampos: txt=[" + ALLTRIM(loc_oForm.txt_4c_SENHA.Value) + "] BO=[" + ;
             ALLTRIM(loc_oBO.this_cSenha) + "] Confirmou=" + TRANSFORM(loc_oBO.this_lConfirmou) + ;
             " esperado [] [] .F." + CHR(13) + CHR(10)
    IF !EMPTY(loc_oForm.txt_4c_SENHA.Value) OR !EMPTY(loc_oBO.this_cSenha) OR loc_oBO.this_lConfirmou
        loc_cL = loc_cL + "   *** FALHA" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) Caption de instrucao gerado pelo Init legado, e 10) icone do botao
    *--    (medidos ANTES do Release do passo 7, que destroi a instancia)
    loc_cRes = loc_oForm.cnt_4c_Container1.lbl_4c_Label1.Caption
    loc_cL = "9) Caption de instrucao = [" + STRTRAN(loc_cRes, CHR(13), "<CR>") + ;
             "] esperado [Digite a Senha<CR>do Supervisor]" + CHR(13) + CHR(10)
    IF loc_cRes != "Digite a Senha" + CHR(13) + "do Supervisor"
        loc_cL = loc_cL + "   *** FALHA: Init legado nao reproduzido" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cRes = loc_oForm.obj_4c_SAIDA.Buttons(1).Picture
    loc_cL = loc_cL + "10) Picture=[" + loc_cRes + "] FILE()=" + TRANSFORM(FILE(loc_cRes)) + " esperado .T." + CHR(13) + CHR(10)
    IF !FILE(loc_cRes)
        loc_cL = loc_cL + "   *** FALHA: icone inexistente (falharia em SILENCIO na tela)" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) ValidarSenha = SENHA.KeyPress legado (instancia PROPRIA: confirma e fecha)
    loc_oForm = CREATEOBJECT("ProbeStfF8")
    loc_oBO   = loc_oForm.this_oBusinessObject
    loc_oForm.txt_4c_SENHA.Value = "SEGREDO1"
    loc_oForm.ValidarSenha(65, 0)
    loc_cL = "7) ValidarSenha: tecla 65 (nao-ENTER) -> Confirmou=" + TRANSFORM(loc_oBO.this_lConfirmou) + ;
             " ObterSenha=[" + loc_oBO.ObterSenha() + "] esperado .F. []" + CHR(13) + CHR(10)
    IF loc_oBO.this_lConfirmou OR !EMPTY(loc_oBO.ObterSenha())
        loc_cL = loc_cL + "   *** FALHA: confirmou sem ENTER" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.ValidarSenha(13, 0)
    loc_cL = loc_cL + "   ENTER (13) -> Confirmou=" + TRANSFORM(loc_oBO.this_lConfirmou) + ;
             " ObterSenha=[" + ALLTRIM(loc_oBO.ObterSenha()) + "] esperado .T. [SEGREDO1]" + CHR(13) + CHR(10)
    IF !loc_oBO.this_lConfirmou OR ALLTRIM(loc_oBO.ObterSenha()) != "SEGREDO1"
        loc_cL = loc_cL + "   *** FALHA: ENTER nao confirmou" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) BtnCancelarClick = CANCELA.Click legado (ObterSenha volta vazio)
    loc_oForm = CREATEOBJECT("ProbeStfF8")
    loc_oBO   = loc_oForm.this_oBusinessObject
    loc_oForm.txt_4c_SENHA.Value = "SEGREDO2"
    loc_oForm.BtnCancelarClick()
    loc_cL = "8) BtnCancelarClick: ObterSenha=[" + loc_oBO.ObterSenha() + "] Confirmou=" + ;
             TRANSFORM(loc_oBO.this_lConfirmou) + " esperado [] .F." + CHR(13) + CHR(10)
    IF !EMPTY(loc_oBO.ObterSenha()) OR loc_oBO.this_lConfirmou
        loc_cL = loc_cL + "   *** FALHA: cancelar nao limpou" + CHR(13) + CHR(10)
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
DEFINE CLASS ProbeStfF8 AS FormSIGPRSTF
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
    FUNCTION TesteLimparCampos()
        RETURN THIS.LimparCampos()
    ENDFUNC
ENDDEFINE
