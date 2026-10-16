*==============================================================================
* ProbeSigPrMdcDelete.prg - Mede o estado do cursor/ponteiro DEPOIS do
* BtnExcluirClick: SET("DELETED") na datasession privada, quantas linhas ficam
* NAVEGAVEIS (o que a grade mostra) e onde o ponteiro para.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_ProbeOut
gc_4c_ProbeOut         = "C:\4c\automation\ProbeSigPrMdcDelete.txt"
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeSigPrMdcDelete_erros.txt"
gnConnHandle           = -1

STRTOFILE("=== PROBE DELETE FormSigPrMdc ===" + CHR(13) + CHR(10), gc_4c_ProbeOut)

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrMdcBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrMdc.prg") ADDITIVE

LOCAL loF, lnDS, lnVis, lnDel
loF = CREATEOBJECT("FormSigPrMdc", .F.)
lnDS = SET("DATASESSION")
SET DATASESSION TO loF.DataSessionId

Passo("SET(DELETED) na datasession privada = [" + SET("DELETED") + "] (esperado ON)")

*-- Monta 3 pares completos
SELECT cursor_4c_Contas
GO TOP
REPLACE ContaAnt WITH "0000000001", ContaNov WITH "0000000002"
loF.BtnIncluirClick()
REPLACE ContaAnt WITH "0000000003", ContaNov WITH "0000000004"
loF.BtnIncluirClick()
REPLACE ContaAnt WITH "0000000005", ContaNov WITH "0000000006"

Passo("ANTES do Excluir: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Contas")) + ;
    " RECNO=" + TRANSFORM(RECNO("cursor_4c_Contas")))

*-- Posiciona no 2o par e exclui
SELECT cursor_4c_Contas
GO 2
Passo("posicionado em RECNO=" + TRANSFORM(RECNO()) + " ContaAnt=[" + ;
    ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")) + "]")

loF.BtnExcluirClick()

lnVis = 0
lnDel = 0
SELECT cursor_4c_Contas
*-- SCAN respeita SET DELETED (so percorre o que a grade mostra)
SCAN
    lnVis = lnVis + 1
ENDSCAN
*-- Conta deletados varrendo por RECNO (GO ignora o filtro de DELETED)
LOCAL lnI
FOR lnI = 1 TO RECCOUNT("cursor_4c_Contas")
    GO lnI IN cursor_4c_Contas
    IF DELETED("cursor_4c_Contas")
        lnDel = lnDel + 1
    ENDIF
ENDFOR

Passo("DEPOIS do Excluir: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Contas")) + ;
    " NAVEGAVEIS(SCAN)=" + TRANSFORM(lnVis) + " (esperado 2)" + ;
    " DELETADOS=" + TRANSFORM(lnDel) + " (esperado 1)")

SELECT cursor_4c_Contas
Passo("ponteiro final: RECNO=" + TRANSFORM(RECNO()) + ;
    " DELETED=" + TRANSFORM(DELETED()) + ;
    " ContaAnt=[" + ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")) + "]" + ;
    "  <- se DELETED=.T. o ponteiro parou numa linha que a grade NAO mostra")

Passo("grade: ActiveRow=" + TRANSFORM(loF.grd_4c_Dados.ActiveRow) + ;
    " RelativeRow=" + TRANSFORM(loF.grd_4c_Dados.RelativeRow))

SET DATASESSION TO (lnDS)
loF.Release()
Passo("=== FIM ===")
QUIT

PROCEDURE Passo(par_cTxt)
    STRTOFILE(par_cTxt + CHR(13) + CHR(10), gc_4c_ProbeOut, 1)
ENDPROC
