*==============================================================================
* despopular_sigcdfs_teste.prg
*
* Rollback de popular_sigcdfs_teste.prg: remove APENAS as linhas de TESTE
* (codigos LIKE 'TESTE%') de SigCdFs, e as linhas de SigCdCmt que apontem para
* elas - senao ficariam motivos orfaos nas classificacoes de conta.
*
* NUNCA apaga linha que nao comece com TESTE: se o dado real do SigCdFs for
* carregado depois, este script continua seguro.
*
* Uso: DO despopular_sigcdfs_teste.prg
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

=SQLSETPROP(0, "ConnectTimeOut", 20)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

lnH = SQLSTRINGCONNECT("Driver={SQL Server};Server=192.168.200.10;" + ;
                       "Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;")
IF lnH <= 0
    MsgErro("Nao foi possivel conectar ao banco.", "Despopular SigCdFs")
    RETURN
ENDIF

*-- quanto sera removido, antes de remover
lnFs  = 0
lnCmt = 0
IF SQLEXEC(lnH, "SELECT COUNT(*) AS qtd FROM SigCdFs WHERE codigos LIKE 'TESTE%'", "cA") >= 0
    lnFs = cA.qtd
    USE IN cA
ENDIF
IF SQLEXEC(lnH, "SELECT COUNT(*) AS qtd FROM SigCdCmt WHERE Codigos LIKE 'TESTE%'", "cB") >= 0
    lnCmt = cB.qtd
    USE IN cB
ENDIF

IF (lnFs + lnCmt) = 0
    MsgInfo("Nada a remover: nenhuma linha TESTE em SigCdFs/SigCdCmt.", "Despopular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF

IF !MsgConfirma("Remover " + TRANSFORM(lnFs) + " motivo(s) de TESTE de SigCdFs e " + ;
                TRANSFORM(lnCmt) + " vinculo(s) em SigCdCmt?", "Despopular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF

*-- detalhe primeiro, depois o mestre
IF SQLEXEC(lnH, "DELETE FROM SigCdCmt WHERE Codigos LIKE 'TESTE%'") < 0
    MsgErro("Falha ao remover vinculos em SigCdCmt:" + CHR(13) + CapturarErroSQL(), "Despopular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF

IF SQLEXEC(lnH, "DELETE FROM SigCdFs WHERE codigos LIKE 'TESTE%'") < 0
    MsgErro("Falha ao remover motivos em SigCdFs:" + CHR(13) + CapturarErroSQL(), "Despopular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF

=SQLDISCONNECT(lnH)

MsgInfo("Removidos: " + TRANSFORM(lnFs) + " motivo(s) e " + TRANSFORM(lnCmt) + ;
        " vinculo(s) de TESTE.", "Despopular SigCdFs")
