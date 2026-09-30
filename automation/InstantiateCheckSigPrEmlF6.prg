*-- Probe de instanciacao do FormSigPrEml (task603, Fase 6).
*-- NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina; carrega
*-- a mao apenas as dependencias do form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigpreml_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL lcSaida
lcSaida = "C:\4c\automation\instantiate_check_sigpreml_f6.txt"
STRTOFILE("[1] inicio" + CHR(13) + CHR(10), lcSaida)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("[2] config.prg OK" + CHR(13) + CHR(10), lcSaida, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + ;
             "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrEmlBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrEml.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE OK" + CHR(13) + CHR(10), lcSaida, 1)

PUBLIC gnConnHandle, gc_4c_UsuarioLogado
gnConnHandle        = -1
gc_4c_UsuarioLogado = "TESTE"

LOCAL loForm, loErr, lcOut
lcOut  = ""
loForm = .NULL.

TRY
    loForm = CREATEOBJECT("FormSigPrEml", "001MALOTE                   3", "INSERIR")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO CREATEOBJECT: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE("[4] pos CREATEOBJECT" + CHR(13) + CHR(10), lcSaida, 1)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)

    *-- Superficie da Fase 6: a celula editavel + os validadores
    lcOut = lcOut + "Column4.ReadOnly="        + TRANSFORM(loForm.grd_4c_Dados.Column4.ReadOnly) + CHR(13) + CHR(10)
    lcOut = lcOut + "Column4.Text1.ReadOnly="  + TRANSFORM(loForm.grd_4c_Dados.Column4.Text1.ReadOnly) + CHR(13) + CHR(10)
    lcOut = lcOut + "Column4.Text1.MaxLength=" + TRANSFORM(loForm.grd_4c_Dados.Column4.Text1.MaxLength) + CHR(13) + CHR(10)
    lcOut = lcOut + "Column4.ControlSource=["  + loForm.grd_4c_Dados.Column4.ControlSource + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "ValidarEnvio existe="       + TRANSFORM(PEMSTATUS(loForm, "ValidarEnvio", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "ValidarEmailCelula existe=" + TRANSFORM(PEMSTATUS(loForm, "ValidarEmailCelula", 5)) + CHR(13) + CHR(10)

    *-- Prova que o BINDEVENT da celula Email esta ligado de verdade
    LOCAL ARRAY laEv[1, 5]
    LOCAL lnEv, lnI, lcLig
    lcLig = ""
    lnEv  = AEVENTS(laEv, loForm.grd_4c_Dados.Column4.Text1)
    FOR lnI = 1 TO lnEv
        lcLig = lcLig + IIF(EMPTY(lcLig), "", ",") + TRANSFORM(laEv[lnI, 3])
    ENDFOR
    lcOut = lcOut + "AEVENTS(Column4.Text1)=" + TRANSFORM(lnEv) + " [" + lcLig + "]" + CHR(13) + CHR(10)

    *-- Cursor do form: DataSession = 1, mesma sessao do probe
    lcOut = lcOut + "cursor_4c_Dados USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
            "  RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), -1)) + CHR(13) + CHR(10)

    *-- CASO A: grade VAZIA -> ValidarEnvio tem de RECUSAR
    TRY
        lcOut = lcOut + "A) grade vazia    -> ValidarEnvio=" + TRANSFORM(loForm.ValidarEnvio()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "A) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO B: uma linha, NAO marcada -> tem de RECUSAR
    TRY
        SELECT cursor_4c_Dados
        INSERT INTO cursor_4c_Dados (checks, contas, rclis, emails, empdopnums, acaos) ;
            VALUES (0, "0000000001", "CLIENTE TESTE", "cliente@dominio.com.br", ;
                    "001MALOTE                   3", "INSERIR")
        lcOut = lcOut + "B) nao marcada    -> ValidarEnvio=" + TRANSFORM(loForm.ValidarEnvio()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "B) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO C: marcada mas SEM email -> tem de RECUSAR
    TRY
        SELECT cursor_4c_Dados
        GO TOP
        REPLACE ALL checks WITH 1, emails WITH ""
        lcOut = lcOut + "C) marcada s/mail -> ValidarEnvio=" + TRANSFORM(loForm.ValidarEnvio()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "C) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO D: marcada COM email -> tem de ACEITAR
    TRY
        SELECT cursor_4c_Dados
        GO TOP
        REPLACE ALL emails WITH "cliente@dominio.com.br"
        lcOut = lcOut + "D) marcada c/mail -> ValidarEnvio=" + TRANSFORM(loForm.ValidarEnvio()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "D) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO E: acao invalida -> tem de RECUSAR (mesmo com linha marcada e email)
    TRY
        loForm.this_cEscolha = "XPTO"
        lcOut = lcOut + "E) acao invalida  -> ValidarEnvio=" + TRANSFORM(loForm.ValidarEnvio()) + CHR(13) + CHR(10)
        loForm.this_cEscolha = "INSERIR"
    CATCH TO loErr
        lcOut = lcOut + "E) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO F: ValidarEmailCelula normaliza (ALLTRIM) o valor digitado
    TRY
        SELECT cursor_4c_Dados
        GO TOP
        loForm.grd_4c_Dados.Column4.Text1.Value = "  novo@dominio.com  "
        loForm.ValidarEmailCelula(13, 0)
        lcOut = lcOut + "F) normalizacao   -> cursor.emails=[" + ;
                ALLTRIM(cursor_4c_Dados.emails) + "] len=" + ;
                TRANSFORM(LEN(RTRIM(cursor_4c_Dados.emails))) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "F) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO G: tecla que NAO eh Enter/Tab tem de sair pelo early-return.
    *-- Nao da para medir isso pelo cursor: a Column4 esta BOUND ao
    *-- ControlSource, entao a propria atribuicao a Text1.Value do probe ja
    *-- escreve no campo (por isso o cursor mostra "digitando"). O que prova
    *-- o early-return eh a AUSENCIA do aviso - o valor tambem nao tem "@",
    *-- e no caso J (mesma falta, com ENTER) o aviso sai.
    TRY
        SELECT cursor_4c_Dados
        GO TOP
        REPLACE emails WITH "antes@dominio.com"
        loForm.grd_4c_Dados.Column4.Text1.Value = "digitando"
        loForm.ValidarEmailCelula(65, 0)
        GO TOP
        lcOut = lcOut + "G) tecla comum    -> cursor.emails=[" + ;
                ALLTRIM(cursor_4c_Dados.emails) + "] (sem aviso = early-return OK)" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "G) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO H: ValidarEnvio preserva o registro corrente do cursor
    TRY
        SELECT cursor_4c_Dados
        INSERT INTO cursor_4c_Dados (checks, contas, rclis, emails, empdopnums, acaos) ;
            VALUES (1, "0000000002", "OUTRO CLIENTE", "outro@dominio.com", ;
                    "001MALOTE                   3", "INSERIR")
        GO 2
        LOCAL lnAntes
        lnAntes = RECNO("cursor_4c_Dados")
        loForm.ValidarEnvio()
        lcOut = lcOut + "H) recno antes=" + TRANSFORM(lnAntes) + " depois=" + ;
                TRANSFORM(RECNO("cursor_4c_Dados")) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "H) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- CASO J: com ENTER e valor SEM "@" o aviso TEM de sair. Comparado com
    *-- o caso G (mesma falta de "@", tecla comum), isolando o early-return:
    *-- G nao pode gerar aviso, J tem de gerar.
    TRY
        SELECT cursor_4c_Dados
        GO TOP
        loForm.grd_4c_Dados.Column4.Text1.Value = "sem-arroba"
        loForm.ValidarEmailCelula(13, 0)
        lcOut = lcOut + "J) enter s/arroba -> avisou" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "J) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    *-- Handlers das fases anteriores continuam de pe
    TRY
        loForm.BtnSelTudoClick()
        loForm.BtnApagaClick()
        loForm.HeaderContasClick()
        loForm.HeaderRclisClick()
        loForm.HeaderEmailsClick()
        loForm.ChkCheckKeyPress(13, 0)
        lcOut = lcOut + "I) handlers fases 4/5: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "I) EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
    loForm = .NULL.
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, lcSaida, 1)
QUIT
