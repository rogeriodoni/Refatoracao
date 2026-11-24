* ProbeF7SigOpTrfCursores.prg
* Mede, SEM SQL (nenhum gnConnHandle), as premissas de VFP9 em que os
* handlers da Fase 7 do FormSigOpTrf se apoiam. Reproduz os dois cursores
* locais que SigOpTrfBO.CarregarRegras cria (xTrf/xOpe do legado) e executa
* a mesma sequencia dos handlers.
SET SAFETY OFF
SET RESOURCE OFF
SET EXACT ON
SET DELETED ON
ON ERROR DO ProbeErro WITH ERROR(), MESSAGE(), LINENO()

LOCAL loc_cOut, loc_cOrigem, loc_cDopedsExcluir, loc_nRecAntes
loc_cOut    = ""
loc_cOrigem = "VENDA"

CREATE CURSOR cursor_4c_Itens (Dopes C(20), Dopeds C(20), Cpros C(14), Dpros C(60))
INDEX ON Cpros TAG Cpros
INDEX ON Dopes + Dopeds TAG Dopes
SET ORDER TO

CREATE CURSOR cursor_4c_Operacoes (Dopes C(20))
INDEX ON Dopes TAG Dopes
SET ORDER TO

*-- Duas operacoes de destino, com 2 produtos cada
INSERT INTO cursor_4c_Operacoes (Dopes) VALUES ("TROCA")
INSERT INTO cursor_4c_Operacoes (Dopes) VALUES ("BRINDE")
INSERT INTO cursor_4c_Itens (Dopes, Dopeds, Cpros) VALUES (loc_cOrigem, "TROCA",  "P001")
INSERT INTO cursor_4c_Itens (Dopes, Dopeds, Cpros) VALUES (loc_cOrigem, "TROCA",  "P002")
INSERT INTO cursor_4c_Itens (Dopes, Dopeds, Cpros) VALUES (loc_cOrigem, "BRINDE", "P003")
INSERT INTO cursor_4c_Itens (Dopes, Dopeds, Cpros) VALUES (loc_cOrigem, "BRINDE", "P004")

*-- TESTE 1: INSERT INTO (nome em variavel) - forma usada nos handlers
LOCAL loc_cAliasOp
loc_cAliasOp = "cursor_4c_Operacoes"
INSERT INTO (loc_cAliasOp) (Dopes) VALUES (SPACE(20))
loc_cOut = loc_cOut + "T1_INSERT_INTO_ALIAS_VARIAVEL=" + ;
    TRANSFORM(RECCOUNT("cursor_4c_Operacoes") = 3) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "T1_PONTEIRO_NA_LINHA_NOVA=" + ;
    TRANSFORM(EMPTY(cursor_4c_Operacoes.Dopes)) + CHR(13) + CHR(10)

*-- TESTE 2: chave POSICIONAL do SET KEY (AplicarFiltroItensPorDestino)
SELECT cursor_4c_Itens
SET ORDER TO Dopes
SET KEY TO PADR(ALLTRIM(loc_cOrigem), 20) + PADR("TROCA", 20)
GO TOP
LOCAL loc_nVisiveis
COUNT TO loc_nVisiveis
loc_cOut = loc_cOut + "T2_SETKEY_POSICIONAL_VE_SO_TROCA=" + ;
    TRANSFORM(loc_nVisiveis = 2) + " (visiveis=" + TRANSFORM(loc_nVisiveis) + ")" + CHR(13) + CHR(10)

*-- TESTE 3: a MESMA chave com ALLTRIM nas PARTES (regra #42) nao casa nada
SET KEY TO ALLTRIM(loc_cOrigem) + ALLTRIM("TROCA")
GO TOP
COUNT TO loc_nVisiveis
loc_cOut = loc_cOut + "T3_ALLTRIM_NAS_PARTES_ZERA=" + ;
    TRANSFORM(loc_nVisiveis = 0) + " (visiveis=" + TRANSFORM(loc_nVisiveis) + ")" + CHR(13) + CHR(10)

*-- TESTE 4: CmdExcluirClick - DELETE FOR sob o filtro reafirmado
SELECT cursor_4c_Operacoes
SET ORDER TO Dopes
SEEK PADR("TROCA", 20)
loc_cDopedsExcluir = cursor_4c_Operacoes.Dopes

SELECT cursor_4c_Itens
SET ORDER TO Dopes
SET KEY TO PADR(ALLTRIM(loc_cOrigem), 20) + loc_cDopedsExcluir
GO TOP
SELECT cursor_4c_Itens
DELETE FOR ALLTRIM(NVL(Dopeds, "")) == ALLTRIM(loc_cDopedsExcluir)

SET KEY TO
SET ORDER TO
GO TOP
COUNT TO loc_nVisiveis
loc_cOut = loc_cOut + "T4_DELETE_FOR_LEVOU_SO_OS_2_DA_TROCA=" + ;
    TRANSFORM(loc_nVisiveis = 2) + " (vivos=" + TRANSFORM(loc_nVisiveis) + ")" + CHR(13) + CHR(10)

*-- TESTE 5: SKIP / IF EOF() GO BOTTOM do legado deixa linha VIVA
SELECT cursor_4c_Operacoes
DELETE
SKIP
IF EOF()
    GO BOTTOM
ENDIF
loc_cOut = loc_cOut + "T5_PONTEIRO_EM_LINHA_VIVA=" + ;
    TRANSFORM(!EOF() AND !DELETED()) + CHR(13) + CHR(10)

*-- TESTE 6: RECCOUNT conta registro MARCADO como excluido - premissa do
*-- criterio de fallback de PersistirRegras (ponto 3 do cabecalho)
SELECT cursor_4c_Itens
IF !EMPTY(ORDER())
    SET KEY TO
ENDIF
SET ORDER TO
GO TOP
COUNT TO loc_nVisiveis
loc_nRecAntes = RECCOUNT("cursor_4c_Itens")
loc_cOut = loc_cOut + "T6_RECCOUNT_CONTA_EXCLUIDO=" + ;
    TRANSFORM(loc_nRecAntes = 4 AND loc_nVisiveis = 2) + ;
    " (reccount=" + TRANSFORM(loc_nRecAntes) + " vivos=" + TRANSFORM(loc_nVisiveis) + ")" + ;
    CHR(13) + CHR(10)

*-- TESTE 7: SCAN do lote so ve linha VIVA (SET DELETED ON)
LOCAL loc_nVarridas
loc_nVarridas = 0
SELECT cursor_4c_Itens
IF !EMPTY(ORDER())
    SET KEY TO
ENDIF
SET ORDER TO
GO TOP
SCAN
    loc_nVarridas = loc_nVarridas + 1
ENDSCAN
loc_cOut = loc_cOut + "T7_SCAN_SO_LINHA_VIVA=" + ;
    TRANSFORM(loc_nVarridas = 2) + " (varridas=" + TRANSFORM(loc_nVarridas) + ")" + CHR(13) + CHR(10)

USE IN cursor_4c_Itens
USE IN cursor_4c_Operacoes

= STRTOFILE(loc_cOut, "C:\4c\automation\_probe814f7.txt")
QUIT

PROCEDURE ProbeErro
    LPARAMETERS par_nErro, par_cMsg, par_nLinha
    = STRTOFILE("ERRO=" + TRANSFORM(par_nErro) + " MSG=" + par_cMsg + ;
                " LINHA=" + TRANSFORM(par_nLinha), ;
                "C:\4c\automation\_probe814f7.txt")
    QUIT
ENDPROC
