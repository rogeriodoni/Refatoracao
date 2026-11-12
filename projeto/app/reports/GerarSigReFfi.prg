*==============================================================================
* Gera SigReFfi.frx - Relatorio de Fluxo Financeiro Analitico
*
* O FRX legado NAO veio no acervo (a task101 traz apenas o SCX, que chama
* "Report Form SigReFfi"). A estrutura de BANDAS e' herdada de SIGOPCHR.frx,
* que tem exatamente o formato necessario (cabecalho de pagina + 1 grupo +
* detalhe + rodape de grupo + sumario) e cujos valores de totaltype/resettotal
* sao conhecidos-bons. Os OBJETOS sao reescritos para o contrato de csRelatorio.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcDest, lcO, loE, loTit, loLbl, loDet, loGrp, loSum, loLin, lnI
lcDest = "C:\Users\roger\AppData\Local\Temp\claude\C--4c\4f9b1a46-e4d2-49b6-b9fb-664c6ca624ff\scratchpad\SigReFfi"
lcO = ""

*-- layout das colunas: hpos, width, alinhamento(0=esq 1=dir), expr, rotulo
#DEFINE NCOL 8
LOCAL ARRAY laC[NCOL, 5]
laC[1,1] =     0  && Vencimento
laC[1,2] =  6800
laC[1,3] =     0
laC[1,4] = [IIF(Fase = 1, "", DTOC(Vencs))]
laC[1,5] = [Vencto.]
laC[2,1] =  7000  && Grupo/Conta
laC[2,2] =  9500
laC[2,3] =     0
laC[2,4] = [ALLTRIM(Grupos) + "/" + ALLTRIM(Contas)]
laC[2,5] = [Grupo/Conta]
laC[3,1] = 16700  && Descricao da conta
laC[3,2] = 13000
laC[3,3] =     0
laC[3,4] = [DsContas]
laC[3,5] = [Descri] + CHR(231) + CHR(227) + [o]
laC[4,1] = 29900  && Operacao
laC[4,2] = 11000
laC[4,3] =     0
laC[4,4] = [DopCs]
laC[4,5] = [Opera] + CHR(231) + CHR(227) + [o]
laC[5,1] = 41100  && Historico
laC[5,2] = 15000
laC[5,3] =     0
laC[5,4] = [Hists]
laC[5,5] = [Hist] + CHR(243) + [rico]
laC[6,1] = 56300  && marcador de pago
laC[6,2] =  1200
laC[6,3] =     0
laC[6,4] = [FlPagos]
laC[6,5] = [P]
laC[7,1] = 57700  && Valor (Fase 1 guarda em Saldos; Fases 2 e 3 em Valors)
laC[7,2] = 10450
laC[7,3] =     1
laC[7,4] = [IIF(Fase = 1, Saldos, Valors)]
laC[7,5] = [Valor]
laC[8,1] = 68350  && Valor convertido na moeda de referencia
laC[8,2] = 10450
laC[8,3] =     1
laC[8,4] = [Vl_Convertido]
laC[8,5] = [Convertido]

TRY
    IF FILE(lcDest + ".frx")
        DELETE FILE (lcDest + ".frx")
    ENDIF
    IF FILE(lcDest + ".frt")
        DELETE FILE (lcDest + ".frt")
    ENDIF
    COPY FILE "C:\4c\projeto\app\reports\SIGOPCHR.frx" TO (lcDest + ".frx")
    COPY FILE "C:\4c\projeto\app\reports\SIGOPCHR.frt" TO (lcDest + ".frt")

    USE (lcDest + ".frx") EXCLUSIVE ALIAS fx
    SELECT fx

    LOCATE FOR objtype = 8 AND INT(vpos) =  6770
    SCATTER MEMO NAME loTit
    LOCATE FOR objtype = 8 AND INT(vpos) = 13125
    SCATTER MEMO NAME loLbl
    LOCATE FOR objtype = 8 AND INT(vpos) = 20625
    SCATTER MEMO NAME loDet
    LOCATE FOR objtype = 8 AND INT(vpos) = 24687 AND totaltype = 2
    SCATTER MEMO NAME loGrp
    LOCATE FOR objtype = 8 AND INT(vpos) = 36666 AND resettotal = 1
    SCATTER MEMO NAME loSum
    LOCATE FOR objtype = 6
    SCATTER MEMO NAME loLin
    *-- os moldes herdam um SUPEXPR ("imprimir quando") do SIGOPCHR que aponta
    *-- para csCabecalho.nConta, coluna que nao existe no contrato deste relatorio.
    FOR lnI = 1 TO 6
        LOCAL loM
        loM = EVALUATE("lo" + SUBSTR("TitLblDetGrpSumLin", (lnI-1)*3+1, 3))
        loM.supexpr = ""
        loM.suptype = 0
    NEXT
    lcO = lcO + "moldes capturados (titulo/rotulo/detalhe/grupo/sumario/linha)" + CHR(13)+CHR(10)

    *-- o grupo passa a quebrar por Quebras (numerado pelo passe de quebra do BO)
    REPLACE expr WITH "quebras" FOR objtype = 9 AND objcode = 3

    DELETE FOR INLIST(objtype, 5, 6, 7, 8)
    PACK
    lcO = lcO + "objetos antigos removidos" + CHR(13)+CHR(10)

    *---------------- CABECALHO DE PAGINA ----------------
    loTit.hpos = 12395
    loTit.width = 54583
    loTit.offset = 2
    loTit.vpos = 2708
    loTit.expr = "gcCabRel"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.vpos = 6770
    loTit.expr = "ALLTRIM(csCabecalho.nm_titulo)"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.vpos = 8750
    loTit.expr = "ALLTRIM(csCabecalho.nm_empresa)"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.vpos = 10208
    loTit.expr = "ALLTRIM(csCabecalho.nm_periodo)"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.hpos = 67604
    loTit.width = 10937
    loTit.offset = 2
    loTit.vpos = 2916
    loTit.expr = "DATE()"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.vpos = 4895
    loTit.expr = "TIME()"
    APPEND BLANK
    GATHER MEMO NAME loTit

    loTit.vpos = 9895
    loTit.expr = ["P" + CHR(225) + "g. " + TRANSF(_PAGENO, "@L 999")]
    APPEND BLANK
    GATHER MEMO NAME loTit

    *---------------- ROTULOS DE COLUNA ----------------
    FOR lnI = 1 TO NCOL
        loLbl.vpos   = 13125
        loLbl.hpos   = laC[lnI,1]
        loLbl.width  = laC[lnI,2]
        loLbl.offset = laC[lnI,3]
        loLbl.expr   = ["] + laC[lnI,5] + ["]
        loLbl.totaltype = 0
        APPEND BLANK
        GATHER MEMO NAME loLbl
    NEXT

    *-- regua sob os rotulos
    loLin.vpos   = 14800
    loLin.hpos   = 0
    loLin.width  = 78800
    loLin.height = 104
    APPEND BLANK
    GATHER MEMO NAME loLin

    *---------------- DETALHE ----------------
    FOR lnI = 1 TO NCOL
        loDet.vpos   = 20625
        loDet.hpos   = laC[lnI,1]
        loDet.width  = laC[lnI,2]
        loDet.offset = laC[lnI,3]
        loDet.expr   = laC[lnI,4]
        loDet.totaltype  = 0
        loDet.resettotal = 1
        loDet.picture = IIF(lnI >= 7, ["999,999,999.99"], "")
        APPEND BLANK
        GATHER MEMO NAME loDet
    NEXT

    *---------------- RODAPE DO GRUPO (sub-total) ----------------
    loGrp.vpos   = 24687
    loGrp.hpos   = 16700
    loGrp.width  = 39400
    loGrp.offset = 1
    loGrp.expr   = "ALLTRIM(CsTotals)"
    loGrp.totaltype = 0
    loGrp.picture = ""
    APPEND BLANK
    GATHER MEMO NAME loGrp

    loGrp.hpos   = 57700
    loGrp.width  = 10450
    loGrp.offset = 1
    loGrp.expr   = "IIF(Fase = 1, Saldos, Valors)"
    loGrp.totaltype = 2
    loGrp.picture = ["999,999,999.99"]
    APPEND BLANK
    GATHER MEMO NAME loGrp

    loGrp.hpos   = 68350
    loGrp.width  = 10450
    loGrp.expr   = "Vl_Convertido"
    loGrp.totaltype = 2
    APPEND BLANK
    GATHER MEMO NAME loGrp

    *---------------- SUMARIO (total geral) ----------------
    loSum.vpos   = 36666
    loSum.hpos   = 16700
    loSum.width  = 39400
    loSum.offset = 1
    loSum.expr   = ["TOTAL GERAL:"]
    loSum.totaltype = 0
    loSum.picture = ""
    APPEND BLANK
    GATHER MEMO NAME loSum

    loSum.hpos   = 57700
    loSum.width  = 10450
    loSum.expr   = "IIF(Fase = 1, Saldos, Valors)"
    loSum.totaltype  = 2
    loSum.resettotal = 1
    loSum.picture = ["999,999,999.99"]
    APPEND BLANK
    GATHER MEMO NAME loSum

    loSum.hpos   = 68350
    loSum.width  = 10450
    loSum.expr   = "Vl_Convertido"
    APPEND BLANK
    GATHER MEMO NAME loSum

    lcO = lcO + "objetos novos: " + TRANSFORM(RECCOUNT()) + " registros no total" + CHR(13)+CHR(10)
    USE IN fx
    STRTOFILE(lcO, "C:\Users\roger\AppData\Local\Temp\claude\C--4c\4f9b1a46-e4d2-49b6-b9fb-664c6ca624ff\scratchpad\mkffi.txt")
CATCH TO loE
    lcO = lcO + "ERRO " + loE.Message + " lin " + TRANSFORM(loE.LineNo) + CHR(13)+CHR(10)
    STRTOFILE(lcO, "C:\Users\roger\AppData\Local\Temp\claude\C--4c\4f9b1a46-e4d2-49b6-b9fb-664c6ca624ff\scratchpad\mkffi.txt")
ENDTRY
QUIT
