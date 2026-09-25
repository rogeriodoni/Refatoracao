SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL lcLog, lnIni, lcDopes, lcDopesComMsg
lcLog = "C:\4c\tasks\task573\logs\diag_db2.txt"
STRTOFILE("INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcLog)

CD "C:\4c\projeto\app\start"
lnIni = SECONDS()
DO config.prg
ConfigurarAmbiente()
STRTOFILE("config+ambiente OK em " + TRANSFORM(SECONDS() - lnIni) + "s" + CHR(13) + CHR(10), lcLog, 1)

*-- MODO TESTE COMPLETO: os dois sao necessarios para MsgErro/MsgInfo nao
*-- abrirem dialogo modal (utils\messages.prg exige gb_4c_ModoTeste E
*-- gc_4c_ArquivoErroTeste preenchido)
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task573\logs\diag_db2_erros.txt"

gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
STRTOFILE("gnConnHandle=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10), lcLog, 1)
IF gnConnHandle <= 0
    STRTOFILE("SEM CONEXAO" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
    QUIT
ENDIF

lcDopes       = ""
lcDopesComMsg = ""

IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS total, SUM(CASE WHEN mensagem IS NOT NULL AND DATALENGTH(mensagem) > 0 THEN 1 ELSE 0 END) AS comMsg FROM SigOpCdI", "crCnt") > 0
    STRTOFILE("SigOpCdI total=" + TRANSFORM(crCnt.total) + " comMensagem=" + TRANSFORM(NVL(crCnt.comMsg, 0)) + CHR(13) + CHR(10), lcLog, 1)
    USE IN crCnt
ELSE
    STRTOFILE("COUNT falhou: " + MESSAGE() + CHR(13) + CHR(10), lcLog, 1)
ENDIF

IF SQLEXEC(gnConnHandle, "SELECT TOP 3 dopes FROM SigOpCdI WHERE mensagem IS NOT NULL AND DATALENGTH(mensagem) > 0 ORDER BY dopes", "crMsg") > 0
    SELECT crMsg
    SCAN
        STRTOFILE("  com mensagem: dopes=[" + ALLTRIM(crMsg.dopes) + "]" + CHR(13) + CHR(10), lcLog, 1)
        IF EMPTY(lcDopesComMsg)
            lcDopesComMsg = ALLTRIM(crMsg.dopes)
        ENDIF
    ENDSCAN
    USE IN crMsg
ENDIF

IF SQLEXEC(gnConnHandle, "SELECT TOP 3 dopes FROM SigOpCdI ORDER BY dopes", "crQq") > 0
    SELECT crQq
    SCAN
        STRTOFILE("  qualquer: dopes=[" + ALLTRIM(crQq.dopes) + "]" + CHR(13) + CHR(10), lcLog, 1)
        IF EMPTY(lcDopes)
            lcDopes = ALLTRIM(crQq.dopes)
        ENDIF
    ENDSCAN
    USE IN crQq
ENDIF

*-- Escolhe o melhor candidato: com mensagem se houver
IF !EMPTY(lcDopesComMsg)
    lcDopes = lcDopesComMsg
ENDIF

DO TestarForm WITH lcDopes,            "dopes REAL"
DO TestarForm WITH "ZZZZINEXISTENTE",  "dopes INEXISTENTE"
DO TestarForm WITH "",                 "dopes VAZIO"

=SQLDISCONNECT(gnConnHandle)
STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT

PROCEDURE TestarForm(par_cDopes, par_cRotulo)
    LOCAL loF, loEx, lcLog
    lcLog = "C:\4c\tasks\task573\logs\diag_db2.txt"
    STRTOFILE("--- " + par_cRotulo + " = [" + par_cDopes + "] ---" + CHR(13) + CHR(10), lcLog, 1)
    TRY
        loF = CREATEOBJECT("FormSigMvMen", par_cDopes)
        IF VARTYPE(loF) = "O"
            STRTOFILE("  Caption=[" + loF.Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
            STRTOFILE("  lblTitulo=[" + loF.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
            STRTOFILE("  lblSombra=[" + loF.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
            STRTOFILE("  Memo len=" + TRANSFORM(LEN(loF.cnt_4c_Container1.obj_4c_GetMemo.Value)) + ;
                " conteudo=[" + LEFT(loF.cnt_4c_Container1.obj_4c_GetMemo.Value, 120) + "]" + CHR(13) + CHR(10), lcLog, 1)
            STRTOFILE("  MemoFont=" + loF.cnt_4c_Container1.obj_4c_GetMemo.FontName + "/" + ;
                TRANSFORM(loF.cnt_4c_Container1.obj_4c_GetMemo.FontSize) + ;
                " ReadOnly=" + TRANSFORM(loF.cnt_4c_Container1.obj_4c_GetMemo.ReadOnly) + CHR(13) + CHR(10), lcLog, 1)
            loF.cnt_4c_Container1.obj_4c_GetMemo.Value = "###LIMPO###"
            STRTOFILE("  CarregarLista()=" + TRANSFORM(loF.CarregarLista()) + ;
                " -> memo len=" + TRANSFORM(LEN(loF.cnt_4c_Container1.obj_4c_GetMemo.Value)) + CHR(13) + CHR(10), lcLog, 1)
            STRTOFILE("  cursor_4c_SigMvMen vazou? " + TRANSFORM(USED("cursor_4c_SigMvMen")) + CHR(13) + CHR(10), lcLog, 1)
            loF.Release()
            STRTOFILE("  RELEASE OK" + CHR(13) + CHR(10), lcLog, 1)
        ELSE
            STRTOFILE("  CREATEOBJECT devolveu NAO-OBJETO: " + VARTYPE(loF) + CHR(13) + CHR(10), lcLog, 1)
        ENDIF
    CATCH TO loEx
        STRTOFILE("  ERRO: " + loEx.Message + " LN=" + TRANSFORM(loEx.LineNo) + ;
            " PROC=" + loEx.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY
ENDPROC
