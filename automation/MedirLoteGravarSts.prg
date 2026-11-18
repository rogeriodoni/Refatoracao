* MedirLoteGravarSts.prg - imprime o LOTE SQL que
* SigOpStsBO.MontarLoteGravacao produz, para conferir o DELETE + os INSERTs e o
* envelope transacional SEM precisar do SQL Server (192.168.200.10 eh
* inalcancavel desta maquina).
*
* MontarLoteGravacao eh PROTECTED (peca interna de GravarStatus - regra #51);
* o harness a alcanca por SUBCLASSE, sem afrouxar o escopo do codigo de
* producao.
SET SAFETY OFF
SET RESOURCE OFF
SET DELETED ON

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gcOut
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_medir_lote_msgs.txt"
gcOut = ""

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"      ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"       ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpStsBO.prg"   ADDITIVE

LOCAL loBO, loErr, lcLote
LOCAL ARRAY laChaves[1]

CREATE CURSOR cursor_4c_Status ;
    (cidchaves C(20), dopes C(20), status C(1), descs C(20))
INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K1", "MALOTE", "A", "ABERTO")
INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K2", "MALOTE", "F", "FECHADO")
*-- linha em branco: o legado a DESCARTA (If Empty(m.status) / Loop)
INSERT INTO cursor_4c_Status (cidchaves, dopes) VALUES ("K3", "MALOTE")
*-- linha marcada para exclusao: SET DELETED ON a esconde do SCAN
INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K4", "MALOTE", "X", "EXCLUIDO")
GO BOTTOM
DELETE
GO TOP

TRY
    loBO = CREATEOBJECT("SigOpStsTesteLote_4c")

    *-- CASO 1: grade com 2 status validos + 1 em branco + 1 excluida
    lcLote = loBO.ChamarMontarLote("MALOTE", @laChaves)
    gcOut = gcOut + "CASO 1 - 2 validos / 1 branco / 1 excluida" + CHR(13) + CHR(10) + ;
        "  linhas no lote = " + TRANSFORM(loBO.this_nLinhasLote) + " (esperado 2)" + CHR(13) + CHR(10) + ;
        "  chave[1] = [" + laChaves[1] + "]" + CHR(13) + CHR(10) + ;
        "  chave[2] = [" + IIF(ALEN(laChaves) >= 2, laChaves[2], "(ausente)") + "]" + CHR(13) + CHR(10) + ;
        "  alias corrente apos montar = [" + ALIAS() + "] (esperado CURSOR_4C_STATUS)" + CHR(13) + CHR(10) + ;
        "  LOTE:" + CHR(13) + CHR(10) + ;
        STRTRAN(lcLote, "; ", ";" + CHR(13) + CHR(10) + "    ") + CHR(13) + CHR(10) + CHR(13) + CHR(10)

    *-- CASO 2: grade SEM nenhum status valido -> o lote fica SO com o DELETE
    SELECT cursor_4c_Status
    DELETE ALL
    lcLote = loBO.ChamarMontarLote("MALOTE", @laChaves)
    gcOut = gcOut + "CASO 2 - nenhuma linha valida (usuario apagou tudo)" + CHR(13) + CHR(10) + ;
        "  linhas no lote = " + TRANSFORM(loBO.this_nLinhasLote) + " (esperado 0)" + CHR(13) + CHR(10) + ;
        "  tem DELETE = " + IIF("DELETE FROM SIGOPSTS" $ UPPER(lcLote), "SIM (ok)", "NAO (BUG)") + CHR(13) + CHR(10) + ;
        "  tem INSERT = " + IIF("INSERT INTO SIGOPSTS" $ UPPER(lcLote), "SIM (BUG)", "NAO (ok)") + CHR(13) + CHR(10) + CHR(13) + CHR(10)

    *-- CASO 3: apostrofo no codigo da operacao tem de sair ESCAPADO
    SELECT cursor_4c_Status
    RECALL ALL
    lcLote = loBO.ChamarMontarLote("O'BRIEN", @laChaves)
    gcOut = gcOut + "CASO 3 - apostrofo na operacao (O'BRIEN)" + CHR(13) + CHR(10) + ;
        "  trecho do DELETE = [" + ;
        SUBSTR(lcLote, AT("DELETE FROM", lcLote), 60) + "]" + CHR(13) + CHR(10)

CATCH TO loErr
    gcOut = gcOut + "ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(gcOut, "C:\4c\automation\_medir_lote.txt")
QUIT

*------------------------------------------------------------------------------
DEFINE CLASS SigOpStsTesteLote_4c AS SigOpStsBO
    PROCEDURE ChamarMontarLote(par_cOperacaoPai, par_aChaves)
        RETURN THIS.MontarLoteGravacao(par_cOperacaoPai, @par_aChaves)
    ENDPROC
ENDDEFINE
