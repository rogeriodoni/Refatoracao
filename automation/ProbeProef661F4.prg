*==============================================================================
* ProbeProef661F4.prg - Instancia Formsigproef headless (Fase 4 / task661) e
* mede o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto) - "a tela abre"
*       so se prova instanciando;
*   (2) a grade grd_4c_Dados existe com a geometria do dump legado e
*       ColumnCount = 7 (o Sqltrans legado eleva o esqueleto de 6 do SCX);
*   (3) os 5 CommandButton de acao existem com Top/Left/Width/Height do dump
*       e com .Picture apontando para arquivo que EXISTE (.Picture
*       inexistente falha em SILENCIO - regra #25);
*   (4) escopo: CarregarDados tem de ser PUBLIC (chamada de fora, regra #51)
*       e BuscarTransacoes do BO tambem;
*   (5) CarregarDados com gnConnHandle invalido NAO deixa escapar o
*       "Program Error" cru do VFP - o erro tem de morrer no CATCH do BO;
*   (6) depois do CarregarDados a grade fica vinculada (RecordSource) e as
*       larguras/legendas sobrevivem ao reset que o RecordSource provoca.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gnConnHandle = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_proef661_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd, loc_cCol, loc_nI, loc_cBtn
LOCAL loc_oCnt, loc_cNome
loc_cOut = "C:\4c\automation\probe_proef661_f4_result.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "sigproefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigproef.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("Formsigproef")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"FORM W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", loc_cOut, 1)

        loc_oCnt = loc_oForm.cnt_4c_Transa
        STRTOFILE(CHR(13)+CHR(10)+"CNT_TRANSA ControlCount=" + TRANSFORM(loc_oCnt.ControlCount), loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oCnt.ControlCount
            STRTOFILE(CHR(13)+CHR(10)+"  [" + TRANSFORM(loc_nI) + "] " + ;
                      PADR(loc_oCnt.Controls(loc_nI).Name, 20) + ;
                      " base=" + PADR(loc_oCnt.Controls(loc_nI).BaseClass, 14) + ;
                      " T=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Top) + ;
                      " L=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Left) + ;
                      " W=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Width) + ;
                      " H=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Height) + ;
                      " Vis=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Visible), loc_cOut, 1)
        ENDFOR

        *-- (2) Grade
        loc_oGrd = loc_oForm.cnt_4c_Transa.grd_4c_Dados
        STRTOFILE(CHR(13)+CHR(10)+"GRADE T=" + TRANSFORM(loc_oGrd.Top) + ;
                  " L=" + TRANSFORM(loc_oGrd.Left) + ;
                  " W=" + TRANSFORM(loc_oGrd.Width) + ;
                  " H=" + TRANSFORM(loc_oGrd.Height) + ;
                  " ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " ReadOnly=" + TRANSFORM(loc_oGrd.ReadOnly) + ;
                  " RecordMark=" + TRANSFORM(loc_oGrd.RecordMark) + ;
                  " DeleteMark=" + TRANSFORM(loc_oGrd.DeleteMark), loc_cOut, 1)

        loc_cCol = ""
        FOR loc_nI = 1 TO loc_oGrd.ColumnCount
            loc_cCol = loc_cCol + CHR(13) + CHR(10) + "  Col" + TRANSFORM(loc_nI) + ;
                " W=" + PADR(TRANSFORM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".Width")), 5) + ;
                " Cap=[" + ALLTRIM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".Header1.Caption")) + "]" + ;
                " CS=[" + ALLTRIM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".ControlSource")) + "]"
        ENDFOR
        STRTOFILE(CHR(13)+CHR(10)+"COLUNAS (antes do bind)" + loc_cCol, loc_cOut, 1)

        *-- (3) Botoes de acao + icone existente em disco
        loc_cBtn = ""
        FOR loc_nI = 1 TO 5
            loc_cNome = GETWORDNUM("cmd_4c_Gerencial cmd_4c_Ultimo cmd_4c_Reimprime cmd_4c_Cancela cmd_4c_Ok", loc_nI)
            IF PEMSTATUS(loc_oCnt, loc_cNome, 5)
                loc_cBtn = loc_cBtn + CHR(13) + CHR(10) + "  " + PADR(loc_cNome, 18) + ;
                    " T=" + TRANSFORM(EVALUATE("loc_oCnt." + loc_cNome + ".Top")) + ;
                    " L=" + TRANSFORM(EVALUATE("loc_oCnt." + loc_cNome + ".Left")) + ;
                    " W=" + TRANSFORM(EVALUATE("loc_oCnt." + loc_cNome + ".Width")) + ;
                    " H=" + TRANSFORM(EVALUATE("loc_oCnt." + loc_cNome + ".Height")) + ;
                    " Cap=[" + ALLTRIM(EVALUATE("loc_oCnt." + loc_cNome + ".Caption")) + "]" + ;
                    " Pic=[" + JUSTFNAME(EVALUATE("loc_oCnt." + loc_cNome + ".Picture")) + "]=" + ;
                    IIF(FILE(EVALUATE("loc_oCnt." + loc_cNome + ".Picture")), "OK", "FALTA")
            ELSE
                loc_cBtn = loc_cBtn + CHR(13) + CHR(10) + "  " + PADR(loc_cNome, 18) + " AUSENTE"
            ENDIF
        ENDFOR
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES" + loc_cBtn, loc_cOut, 1)

        *-- (4) Escopo (2 = Protected): metodo chamado de fora tem de dar .F.
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) Form.CarregarDados=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + ;
                  " BO.BuscarTransacoes=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "BuscarTransacoes", 2)) + ;
                  " BO.CarregarDoCursor=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "CarregarDoCursor", 2)), loc_cOut, 1)

        *-- (5)/(6) CarregarDados com a conexao do ambiente de teste
        STRTOFILE(CHR(13)+CHR(10)+"TYPE(gnConnHandle)=" + TYPE("gnConnHandle"), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()) + ;
                  " MsgBO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]" + ;
                  " cursor=" + TRANSFORM(USED("cursor_4c_Transacao")) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]", loc_cOut, 1)

        IF USED("cursor_4c_Transacao")
            STRTOFILE(CHR(13)+CHR(10)+"RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Transacao")) + ;
                      " FCOUNT=" + TRANSFORM(FCOUNT("cursor_4c_Transacao")), loc_cOut, 1)
            loc_cCol = ""
            FOR loc_nI = 1 TO loc_oGrd.ColumnCount
                loc_cCol = loc_cCol + CHR(13) + CHR(10) + "  Col" + TRANSFORM(loc_nI) + ;
                    " W=" + PADR(TRANSFORM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".Width")), 5) + ;
                    " Cap=[" + ALLTRIM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".Header1.Caption")) + "]" + ;
                    " CS=[" + ALLTRIM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nI) + ".ControlSource")) + "]"
            ENDFOR
            STRTOFILE(CHR(13)+CHR(10)+"COLUNAS (apos o bind)" + loc_cCol, loc_cOut, 1)
        ENDIF

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
