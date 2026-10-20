*==============================================================================
* ProbeScn673F7.prg - Probe da Fase 7 de FormSigPrScn (task673)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) os 7 controles do legado existem (2 label + 2 textbox + container c/ 2 label)
*   3) o form NAO tem botao algum - nem CommandButton/CommandGroup na arvore,
*      nem os 4 handlers CRUD: a Fase 7 nao tem evento de botao a portar
*      porque o SCX legado nao declara botao nenhum
*   4) escopos (regra #3): ValidarSenha e ValidarParametros PUBLIC (alvos de
*      BINDEVENT / chamada externa pelo harness)
*   5) ValidarSenha esta ligado ao LostFocus do campo SENHA (AEVENTS)
*   6) Format/InputMask/PasswordChar transcritos do SCX (regra #49)
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless. NAO autentica de verdade: o SQL Server 192.168.200.10 nao
* tem rota desta maquina (gnConnHandle = -1 aqui).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_scn673.txt"
#DEFINE OUT "C:\4c\automation\probe_scn673_f7.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_nI, loc_nEv, loc_nBot
LOCAL ARRAY loc_aEv[1, 5]
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 7 - FormSigPrScn ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrScnBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrScn.prg") ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("FormSigPrScn")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Width=" + TRANSFORM(loc_oForm.Width) + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                  " WindowType=" + TRANSFORM(loc_oForm.WindowType), ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- 2) os 7 controles do legado
    loc_cL = "2) controles do legado:" + CHR(13) + CHR(10) + ;
        "   lbl_4c_Label1  = " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label1", 5))  + CHR(13) + CHR(10) + ;
        "   lbl_4c_Label2  = " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label2", 5))  + CHR(13) + CHR(10) + ;
        "   txt_4c_USUARIO = " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_USUARIO", 5)) + CHR(13) + CHR(10) + ;
        "   txt_4c_SENHA   = " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_SENHA", 5))   + CHR(13) + CHR(10) + ;
        "   cnt_4c_Sombra  = " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5))  + CHR(13) + CHR(10)
    IF PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)
        loc_cL = loc_cL + ;
        "     lbl_4c_LblSombra = " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)) + CHR(13) + CHR(10) + ;
        "     lbl_4c_LblTitulo = " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)) + CHR(13) + CHR(10)
    ENDIF
    IF !(PEMSTATUS(loc_oForm, "lbl_4c_Label1", 5) AND PEMSTATUS(loc_oForm, "lbl_4c_Label2", 5) ;
         AND PEMSTATUS(loc_oForm, "txt_4c_USUARIO", 5) AND PEMSTATUS(loc_oForm, "txt_4c_SENHA", 5) ;
         AND PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5))
        loc_cL = loc_cL + "   *** FALHA: controle do legado ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) ZERO botao, igual ao legado
    loc_nBot = 0
    FOR loc_nI = 1 TO loc_oForm.ControlCount
        IF INLIST(UPPER(loc_oForm.Controls(loc_nI).BaseClass), "COMMANDBUTTON", "COMMANDGROUP")
            loc_nBot = loc_nBot + 1
        ENDIF
    ENDFOR
    loc_cL = "3) botoes (o SCX legado nao declara nenhum):" + CHR(13) + CHR(10) + ;
        "   CommandButton/CommandGroup na arvore = " + TRANSFORM(loc_nBot) + " esperado 0" + CHR(13) + CHR(10) + ;
        "   BtnIncluirClick    = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnIncluirClick", 5))    + " esperado .F." + CHR(13) + CHR(10) + ;
        "   BtnAlterarClick    = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnAlterarClick", 5))    + " esperado .F." + CHR(13) + CHR(10) + ;
        "   BtnVisualizarClick = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnVisualizarClick", 5)) + " esperado .F." + CHR(13) + CHR(10) + ;
        "   BtnExcluirClick    = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExcluirClick", 5))    + " esperado .F." + CHR(13) + CHR(10)
    IF loc_nBot != 0 OR PEMSTATUS(loc_oForm, "BtnIncluirClick", 5) OR PEMSTATUS(loc_oForm, "BtnAlterarClick", 5) ;
       OR PEMSTATUS(loc_oForm, "BtnVisualizarClick", 5) OR PEMSTATUS(loc_oForm, "BtnExcluirClick", 5)
        loc_cL = loc_cL + "   *** FALHA: ha botao/handler CRUD que o legado nao tem" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) escopos (atributo 2 = Protected)
    loc_cL = "4) escopos (atributo 2 = Protected):" + CHR(13) + CHR(10) + ;
        "   ValidarSenha      Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarSenha", 2))      + " esperado .F." + CHR(13) + CHR(10) + ;
        "   ValidarParametros Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarParametros", 2)) + " esperado .F." + CHR(13) + CHR(10)
    IF PEMSTATUS(loc_oForm, "ValidarSenha", 2) OR PEMSTATUS(loc_oForm, "ValidarParametros", 2)
        loc_cL = loc_cL + "   *** FALHA: escopo errado (BINDEVENT/harness exigem PUBLIC)" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) o BINDEVENT do unico evento do legado (SENHA.LostFocus)
    loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_SENHA)
    loc_cL = "5) BINDEVENT em txt_4c_SENHA: " + TRANSFORM(loc_nEv) + " vinculo(s)" + CHR(13) + CHR(10)
    *-- O AEVENTS devolve o DELEGATE na coluna 4; o nome do evento ("LostFocus")
    *-- eh literal no BINDEVENT do ConfigurarCampos, nao sai legivel do array.
    FOR loc_nI = 1 TO loc_nEv
        loc_cL = loc_cL + "   delegate -> [" + TRANSFORM(loc_aEv[loc_nI, 4]) + "]" + CHR(13) + CHR(10)
    ENDFOR
    IF loc_nEv < 1
        loc_cL = loc_cL + "   *** FALHA: SENHA sem o LostFocus do legado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) Format/InputMask/PasswordChar transcritos do SCX
    loc_cL = "6) campos (transcritos do SCX):" + CHR(13) + CHR(10) + ;
        "   USUARIO Format=[" + loc_oForm.txt_4c_USUARIO.Format + "] InputMask=[" + ;
             loc_oForm.txt_4c_USUARIO.InputMask + "] TabIndex=" + TRANSFORM(loc_oForm.txt_4c_USUARIO.TabIndex) + CHR(13) + CHR(10) + ;
        "   SENHA   Format=[" + loc_oForm.txt_4c_SENHA.Format + "] InputMask=[" + ;
             loc_oForm.txt_4c_SENHA.InputMask + "] PasswordChar=[" + loc_oForm.txt_4c_SENHA.PasswordChar + ;
             "] TabIndex=" + TRANSFORM(loc_oForm.txt_4c_SENHA.TabIndex) + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_USUARIO.Format != "K" OR loc_oForm.txt_4c_SENHA.Format != "K" ;
       OR loc_oForm.txt_4c_SENHA.PasswordChar != "*"
        loc_cL = loc_cL + "   *** FALHA: Format/PasswordChar fora do SCX" + CHR(13) + CHR(10)
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
