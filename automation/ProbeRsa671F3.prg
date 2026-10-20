*==============================================================================
* ProbeRsa671F3.prg - Instancia FormSigPrRsa headless (Fase 3 / task671) e
* mede o que a fase entregou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve OBJETO, nao .F.) - a
*       unica prova de que a tela abre ("Init de form grande falha em cadeia");
*   (2) as propriedades visuais transcritas do dump chegaram ao objeto;
*   (3) o cabecalho existe com os nomes do .prg (alinhados no mapeamento.json)
*       (cnt_4c_Cabecalho / lbl_4c_Sombra / lbl_4c_Titulo), com o Caption
*       propagado e as cores/geometria canonicas;
*   (4) o .Picture do fundo aponta para arquivo que EXISTE em disco
*       (.Picture inexistente falha em SILENCIO - regra #25);
*   (5) os handlers que o harness chama de fora sao PUBLIC (regra #3 -
*       PEMSTATUS(...,2) tem de dar .F.);
*   (6) o BO foi instanciado, recebeu o filtro de prioridade e montou o
*       cursor global CrSigCdPam;
*   (7) a abertura PARAMETRIZADA (modo lote) tambem conclui e grava o
*       Fortyus.Log.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_rsa671_f3.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nI, loc_oCnt, loc_cLog
loc_cOut = "C:\4c\automation\probe_rsa671_f3_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    *-- config.prg nao cria gnConnHandle (quem conecta eh o main.prg): declarar
    *-- em 0, igual ao TesteAutomatico.prg faz de proposito.
    PUBLIC gnConnHandle
    gnConnHandle = 0

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrRsaBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrRsa.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK gnConnHandle=" + TRANSFORM(gnConnHandle), loc_cOut, 1)

    *-- (1) Abertura interativa (sem parametros)
    loc_oForm = CREATEOBJECT("FormSigPrRsa")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- (2) Propriedades visuais do dump
        STRTOFILE(CHR(13)+CHR(10)+"FORM W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " DataSession=" + TRANSFORM(loc_oForm.DataSession) + ;
                  " BorderStyle=" + TRANSFORM(loc_oForm.BorderStyle) + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                  " ControlBox=" + TRANSFORM(loc_oForm.ControlBox) + ;
                  " WindowType=" + TRANSFORM(loc_oForm.WindowType) + ;
                  " Closable=" + TRANSFORM(loc_oForm.Closable) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", loc_cOut, 1)

        *-- (4) Fundo do form
        STRTOFILE(CHR(13)+CHR(10)+"PICTURE=[" + JUSTFNAME(loc_oForm.Picture) + "] " + ;
                  IIF(FILE(loc_oForm.Picture), "EXISTE", "FALTA"), loc_cOut, 1)

        *-- (3) Arvore de controles entregue nesta fase
        STRTOFILE(CHR(13)+CHR(10)+"CONTROLES ControlCount=" + TRANSFORM(loc_oForm.ControlCount), loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            STRTOFILE(CHR(13)+CHR(10)+"  [" + TRANSFORM(loc_nI) + "] " + ;
                      PADR(loc_oForm.Controls(loc_nI).Name, 20) + ;
                      " base=" + PADR(loc_oForm.Controls(loc_nI).BaseClass, 12) + ;
                      " T=" + TRANSFORM(loc_oForm.Controls(loc_nI).Top) + ;
                      " L=" + TRANSFORM(loc_oForm.Controls(loc_nI).Left) + ;
                      " W=" + TRANSFORM(loc_oForm.Controls(loc_nI).Width) + ;
                      " H=" + TRANSFORM(loc_oForm.Controls(loc_nI).Height) + ;
                      " Vis=" + TRANSFORM(loc_oForm.Controls(loc_nI).Visible), loc_cOut, 1)
        ENDFOR

        loc_oCnt = loc_oForm.cnt_4c_Cabecalho
        STRTOFILE(CHR(13)+CHR(10)+"CABECALHO BackStyle=" + TRANSFORM(loc_oCnt.BackStyle) + ;
                  " BackColor=" + TRANSFORM(loc_oCnt.BackColor) + ;
                  " (RGB(100,100,100)=" + TRANSFORM(RGB(100,100,100)) + ")" + ;
                  " BorderWidth=" + TRANSFORM(loc_oCnt.BorderWidth) + ;
                  " ControlCount=" + TRANSFORM(loc_oCnt.ControlCount), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"LBL SOMBRA T=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Top) + ;
                  " L=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Left) + ;
                  " W=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Width) + ;
                  " H=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Height) + ;
                  " Fore=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.ForeColor) + ;
                  " FontSize=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.FontSize) + ;
                  " AutoSize=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.AutoSize) + ;
                  " Vis=" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Visible) + ;
                  " Cap=[" + ALLTRIM(loc_oCnt.lbl_4c_Sombra.Caption) + "]", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"LBL TITULO T=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Top) + ;
                  " L=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Left) + ;
                  " W=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Width) + ;
                  " H=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Height) + ;
                  " Fore=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.ForeColor) + ;
                  " FontSize=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.FontSize) + ;
                  " AutoSize=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.AutoSize) + ;
                  " Vis=" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Visible) + ;
                  " Tip=[" + ALLTRIM(loc_oCnt.lbl_4c_Titulo.ToolTipText) + "]" + ;
                  " Cap=[" + ALLTRIM(loc_oCnt.lbl_4c_Titulo.Caption) + "]", loc_cOut, 1)

        *-- (5) Escopo e bypass de ValidarParametros (2 = Protected)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) BtnProcessarClick=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 2)) + ;
                  " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + ;
                  " TxtPrioridadeKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "TxtPrioridadeKeyPress", 2)) + ;
                  " CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + ;
                  " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2)), loc_cOut, 1)

        *-- (6) Estado do BO e cursor global de parametros
        STRTOFILE(CHR(13)+CHR(10)+"BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
                  " Tabela=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cTabela) + "]" + ;
                  " Chave=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCampoChave) + "]" + ;
                  " Prioridade=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                  " Parametrizado=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lParametrizado), loc_cOut, 1)

        *-- O form tem DataSession = 2 (sessao privada): o cursor criado pelo
        *-- BO dentro dela NAO eh visivel da sessao 1 do probe - medir de
        *-- dentro da sessao do form, senao o resultado eh falso negativo.
        LOCAL loc_nSessaoAnt
        loc_nSessaoAnt = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE(CHR(13)+CHR(10)+"CrSigCdPam (sessao " + TRANSFORM(loc_oForm.DataSessionId) + ;
                  ") usado=" + TRANSFORM(USED("CrSigCdPam")) + ;
                  " reccount=" + TRANSFORM(IIF(USED("CrSigCdPam"), RECCOUNT("CrSigCdPam"), -1)) + ;
                  " GrupoRecs=" + TRANSFORM(TYPE("CrSigCdPam.GrupoRecs")) + ;
                  " ContaPags=" + TRANSFORM(TYPE("CrSigCdPam.ContaPags")), loc_cOut, 1)
        SET DATASESSION TO loc_nSessaoAnt

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RELEASE interativo=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

    *-- (7) Abertura PARAMETRIZADA (modo lote do Fortyus.Exe): pParam char +
    *-- pPrior numerico. Confere o Fortyus.Log gravado pelo Init.
    loc_cLog = ADDBS(gc_4c_CaminhoBase) + "Fortyus.Log"
    IF FILE(loc_cLog)
        DELETE FILE (loc_cLog)
    ENDIF

    loc_oForm = CREATEOBJECT("FormSigPrRsa", "LOTE", 1)
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT(parametrizado)=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"PARAM Parametrizado=" + TRANSFORM(loc_oForm.this_lParametrizado) + ;
                  " Prioridade=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                  " BOPrioridade=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"LOG existe=" + IIF(FILE(loc_cLog), "SIM", "NAO") + ;
                  " tamanho=" + TRANSFORM(IIF(FILE(loc_cLog), LEN(FILETOSTR(loc_cLog)), 0)), loc_cOut, 1)
        loc_oForm.Release()
        IF FILE(loc_cLog)
            DELETE FILE (loc_cLog)
        ENDIF
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT_PARAM", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
