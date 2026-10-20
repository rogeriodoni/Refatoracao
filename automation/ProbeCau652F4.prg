*==============================================================================
* ProbeCau652F4.prg - Instancia FormSIGOPCAU headless (Fase 4 / task652) e
* mede o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto). Isto tambem
*       PROVA que os 5 BINDEVENT de ConfigurarControles sao legais: medido
*       em 2026-10-17 (automation\tmp652\medir_bindevent.prg) que BINDEVENT
*       com delegate inexistente estoura NA HORA DO BIND com
*       "Property <X> is not found.";
*   (2) os 7 controles do SCX legado existem, com a geometria transcrita do
*       dump e o CommandGroup no prefixo canonico cmg_4c_ (PILAR 3);
*   (3) os 3 Buttons do grupo apontam para arquivo de icone que EXISTE
*       (.Picture inexistente falha em SILENCIO - regra #25);
*   (4) escopo dos metodos: todo delegate de BINDEVENT tem de ser PUBLIC
*       (regra #3 - PEMSTATUS(...,2) deve dar .F.);
*   (5) a arvore (OLEControl ctTree.ocx) eh corretamente PULADA em
*       ModoTeste e, mesmo sem ela, os metodos que a dirigem continuam
*       seguros: CarregarDados/BtnExpandirClick/BtnRecolherClick/
*       CUsuGotFocus/GrupoGotFocus nao estouram;
*   (6) CarregarDados sem filtro nenhum devolve .F. sem consultar o banco
*       (guard que o legado escreve nos 3 call sites do MakeTree), e com
*       filtro preenchido NAO deixa escapar o "Program Error" cru do VFP
*       quando gnConnHandle eh invalido.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_cau652_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oCmg, loc_cPic, loc_nI
loc_cOut = "C:\4c\automation\probe_cau652_f4_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCAUBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPCAU.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo (prova que os BINDEVENT sao legais)
    loc_oForm = CREATEOBJECT("FormSIGOPCAU")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"FORM W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " DataSession=" + TRANSFORM(loc_oForm.DataSession) + ;
                  " ControlBox=" + TRANSFORM(loc_oForm.ControlBox) + ;
                  " BorderStyle=" + TRANSFORM(loc_oForm.BorderStyle) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", loc_cOut, 1)

        *-- (2) Os 7 controles do legado
        STRTOFILE(CHR(13)+CHR(10)+"CONTROLES ControlCount=" + TRANSFORM(loc_oForm.ControlCount), loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            STRTOFILE(CHR(13)+CHR(10)+"  [" + TRANSFORM(loc_nI) + "] " + ;
                      PADR(loc_oForm.Controls(loc_nI).Name, 24) + ;
                      " base=" + PADR(loc_oForm.Controls(loc_nI).BaseClass, 14) + ;
                      " T=" + TRANSFORM(loc_oForm.Controls(loc_nI).Top) + ;
                      " L=" + TRANSFORM(loc_oForm.Controls(loc_nI).Left) + ;
                      " W=" + TRANSFORM(loc_oForm.Controls(loc_nI).Width) + ;
                      " H=" + TRANSFORM(loc_oForm.Controls(loc_nI).Height) + ;
                      " Vis=" + TRANSFORM(loc_oForm.Controls(loc_nI).Visible), loc_cOut, 1)
        ENDFOR

        STRTOFILE(CHR(13)+CHR(10)+"CMG renomeado existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "cmg_4c_Commandgroup1", 5)) + ;
                  " nome antigo existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "obj_4c_Commandgroup1", 5)), loc_cOut, 1)

        loc_oCmg = loc_oForm.cmg_4c_Commandgroup1
        STRTOFILE(CHR(13)+CHR(10)+"CMG ButtonCount=" + TRANSFORM(loc_oCmg.ButtonCount) + ;
                  " BackStyle=" + TRANSFORM(loc_oCmg.BackStyle) + ;
                  " SpecialEffect=" + TRANSFORM(loc_oCmg.SpecialEffect) + ;
                  " Value=" + TRANSFORM(loc_oCmg.Value), loc_cOut, 1)

        *-- (3) Icone de cada Button tem de EXISTIR em disco
        loc_cPic = ""
        FOR loc_nI = 1 TO loc_oCmg.ButtonCount
            loc_cPic = loc_cPic + CHR(13) + CHR(10) + "  Btn" + TRANSFORM(loc_nI) + ;
                " Cap=[" + ALLTRIM(loc_oCmg.Buttons(loc_nI).Caption) + "]" + ;
                " L=" + TRANSFORM(loc_oCmg.Buttons(loc_nI).Left) + ;
                " T=" + TRANSFORM(loc_oCmg.Buttons(loc_nI).Top) + ;
                " W=" + TRANSFORM(loc_oCmg.Buttons(loc_nI).Width) + ;
                " H=" + TRANSFORM(loc_oCmg.Buttons(loc_nI).Height) + ;
                " Fore=" + TRANSFORM(loc_oCmg.Buttons(loc_nI).ForeColor) + ;
                " Pic=[" + JUSTFNAME(loc_oCmg.Buttons(loc_nI).Picture) + "]=" + ;
                IIF(FILE(loc_oCmg.Buttons(loc_nI).Picture), "OK", "FALTA")
        ENDFOR
        STRTOFILE(CHR(13)+CHR(10)+"BUTTONS" + loc_cPic, loc_cOut, 1)

        *-- Imagens da arvore usadas em PrepararArvore (indices 1/2/3)
        STRTOFILE(CHR(13)+CHR(10)+"IMAGENS ARVORE Menu1=" + ;
                  IIF(FILE(gc_4c_CaminhoIcones + "Menu1.Bmp"), "OK", "FALTA") + ;
                  " x_planilha1=" + IIF(FILE(gc_4c_CaminhoIcones + "x_planilha1.bmp"), "OK", "FALTA") + ;
                  " MsgStop1=" + IIF(FILE(gc_4c_CaminhoIcones + "MsgStop1.Gif"), "OK", "FALTA"), loc_cOut, 1)

        *-- (4) Escopo: delegate de BINDEVENT tem de ser PUBLIC (2 = Protected)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) BtnExpandirClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnExpandirClick",2)) + ;
                  " BtnRecolherClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnRecolherClick",2)) + ;
                  " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",2)) + ;
                  " CUsuGotFocus=" + TRANSFORM(PEMSTATUS(loc_oForm,"CUsuGotFocus",2)) + ;
                  " GrupoGotFocus=" + TRANSFORM(PEMSTATUS(loc_oForm,"GrupoGotFocus",2)) + ;
                  " CarregarDados=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarDados",2)), loc_cOut, 1)

        *-- (5) Arvore pulada em ModoTeste + metodos seguros sem ela
        STRTOFILE(CHR(13)+CHR(10)+"TREEVIEW existe=" + TRANSFORM(PEMSTATUS(loc_oForm,"obj_4c_TreeView",5)), loc_cOut, 1)

        loc_oForm.CUsuGotFocus()
        loc_oForm.GrupoGotFocus()
        loc_oForm.BtnExpandirClick()
        loc_oForm.BtnRecolherClick()
        STRTOFILE(CHR(13)+CHR(10)+"HANDLERS sem arvore=OK NodeExp=" + ;
                  TRANSFORM(loc_oForm.this_nNodeExp), loc_cOut, 1)

        *-- (6) CarregarDados: sem filtro nenhum e com filtro
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(sem filtro) retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()), loc_cOut, 1)

        loc_oForm.txt_4c_CUsu.Value = "4CONTROL"
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(usuario=4CONTROL) retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()) + ;
                  " MsgBO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]", loc_cOut, 1)

        loc_oForm.txt_4c_CUsu.Value  = ""
        loc_oForm.txt_4c_Grupo.Value = "ADM"
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(grupo=ADM) retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()) + ;
                  " MsgBO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]", loc_cOut, 1)

        *-- BtnEncerrarClick por ULTIMO: ele libera o form
        loc_oForm.BtnEncerrarClick()
        STRTOFILE(CHR(13)+CHR(10)+"BtnEncerrarClick=OK", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
