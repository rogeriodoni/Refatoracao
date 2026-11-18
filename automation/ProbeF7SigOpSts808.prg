* ProbeF7SigOpSts808.prg - exercita os metodos da Fase 7 que NAO dependem de
* SQL Server:
*   - SigOpStsBO.ExisteStatusDuplicado (validacao sobre o cursor da grade)
*   - SigOpStsBO.GravarStatus com guardas (sem conexao / sem operacao)
*   - escopo PUBLIC dos metodos que o form chama de fora (regra #51)
*   - a logica de reaproveitar/criar linha em branco do CmdInserirClick
*     reproduzida sobre o mesmo cursor
* A prova vem do arquivo de saida, nao do exit code.
SET SAFETY OFF
SET RESOURCE OFF
SET EXACT ON
SET DELETED ON

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7sts_probe_erros.txt"

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpStsBO.prg"   ADDITIVE

LOCAL loc_cRel, loBO, loc_lDup, loc_lGrav, loc_cCid

loc_cRel = ""

*-- Cria o cursor com a MESMA estrutura que ListarStatusOperacao produz
CREATE CURSOR cursor_4c_Status ;
    (cidchaves C(20), dopes C(20), status C(1), descs C(20))

INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K1", "MALOTE", "A", "ABERTO")
INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K2", "MALOTE", "F", "FECHADO")

TRY
    loBO = CREATEOBJECT("SigOpStsBO")
    loc_cRel = loc_cRel + "CREATEOBJECT SigOpStsBO = " + VARTYPE(loBO) + CHR(13) + CHR(10)
CATCH TO loErr
    loc_cRel = loc_cRel + "CREATEOBJECT SigOpStsBO = ERRO " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- Escopo: os metodos que o FORM chama de fora nao podem ser PROTECTED
*-- (atributo 2 = Protected; o atributo 4 eh User-defined e da .T. em tudo)
loc_cRel = loc_cRel + "PROTECTED ExisteStatusDuplicado = " + ;
    IIF(PEMSTATUS(loBO, "ExisteStatusDuplicado", 2), "SIM(BUG)", "NAO(ok)") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "PROTECTED GravarStatus          = " + ;
    IIF(PEMSTATUS(loBO, "GravarStatus", 2), "SIM(BUG)", "NAO(ok)") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "PROTECTED ListarStatusOperacao  = " + ;
    IIF(PEMSTATUS(loBO, "ListarStatusOperacao", 2), "SIM(BUG)", "NAO(ok)") + CHR(13) + CHR(10)

loBO.this_cOperacaoPai = "MALOTE"

*-- 1) Sem duplicidade
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "1) sem duplicidade -> " + IIF(loc_lDup, ".T.(BUG)", ".F.(ok)") + ;
    " status=[" + loBO.this_cStatusDuplicado + "]" + CHR(13) + CHR(10)

*-- 2) Logica do CmdInserirClick: nao ha linha em branco -> cria UMA
SELECT cursor_4c_Status
LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(loBO.this_cOperacaoPai) ;
    AND EMPTY(NVL(status, ""))
IF !FOUND()
    loc_cCid = LEFT(ALLTRIM(fUniqueIds()), 20)
    INSERT INTO cursor_4c_Status (dopes, cidchaves) VALUES (loBO.this_cOperacaoPai, loc_cCid)
ENDIF
loc_cRel = loc_cRel + "2) Inserir (1a vez) -> RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Status")) + ;
    " (esperado 3)" + CHR(13) + CHR(10)

*-- 3) Segundo Inserir deve REAPROVEITAR a linha em branco (guard do LOCATE)
SELECT cursor_4c_Status
LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(loBO.this_cOperacaoPai) ;
    AND EMPTY(NVL(status, ""))
IF !FOUND()
    INSERT INTO cursor_4c_Status (dopes, cidchaves) ;
        VALUES (loBO.this_cOperacaoPai, LEFT(ALLTRIM(fUniqueIds()), 20))
ENDIF
loc_cRel = loc_cRel + "3) Inserir (2a vez) -> RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Status")) + ;
    " (esperado 3 - reaproveitou) FOUND=" + IIF(FOUND(), "SIM", "NAO") + CHR(13) + CHR(10)

*-- 4) UMA linha em branco NAO eh duplicidade
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "4) 1 linha em branco -> " + IIF(loc_lDup, ".T.(BUG)", ".F.(ok)") + CHR(13) + CHR(10)

*-- 5) Status repetido -> duplicidade, com o codigo do PRIMEIRO grupo repetido
INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
    VALUES ("K3", "MALOTE", "F", "FECHADO")
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "5) status F repetido -> " + IIF(loc_lDup, ".T.(ok)", ".F.(BUG)") + ;
    " status=[" + loBO.this_cStatusDuplicado + "] (esperado F)" + CHR(13) + CHR(10)

*-- 6) Linha MARCADA para exclusao nao entra (SET DELETED ON)
SELECT cursor_4c_Status
LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == "K3"
IF FOUND()
    DELETE
ENDIF
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "6) repetida EXCLUIDA -> " + IIF(loc_lDup, ".T.(BUG)", ".F.(ok)") + CHR(13) + CHR(10)

*-- 7) DUAS linhas em branco -> duplicidade do status VAZIO (literal do legado)
INSERT INTO cursor_4c_Status (dopes, cidchaves) VALUES ("MALOTE", "K4")
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "7) 2 linhas em branco -> " + IIF(loc_lDup, ".T.(ok)", ".F.(BUG)") + ;
    " status=[" + loBO.this_cStatusDuplicado + "] (esperado vazio)" + CHR(13) + CHR(10)

*-- 8) O cursor de totais nao pode ficar aberto, e o alias corrente tem de
*--    voltar a ser o da grade (este dialogo roda na DataSession do pai)
SELECT cursor_4c_Status
loc_lDup = loBO.ExisteStatusDuplicado()
loc_cRel = loc_cRel + "8) totais fechado=" + IIF(USED("cursor_4c_Totais"), "NAO(BUG)", "SIM(ok)") + ;
    " alias restaurado=" + IIF(UPPER(ALIAS()) == "CURSOR_4C_STATUS", "SIM(ok)", "NAO(BUG) [" + ALIAS() + "]") + ;
    CHR(13) + CHR(10)

*-- 9) GravarStatus sem operacao-pai recusa (o DELETE apagaria outro conjunto)
loBO.this_cOperacaoPai = ""
loc_lGrav = loBO.GravarStatus("")
loc_cRel = loc_cRel + "9) GravarStatus sem operacao -> " + IIF(loc_lGrav, ".T.(BUG)", ".F.(ok)") + ;
    " erroExibido=" + IIF(loBO.this_lErroExibido, "SIM(ok)", "NAO(BUG)") + CHR(13) + CHR(10)

*-- 10) GravarStatus sem conexao recusa sem estourar (gnConnHandle inexistente)
loBO.this_cOperacaoPai = "MALOTE"
loc_lGrav = loBO.GravarStatus("MALOTE")
loc_cRel = loc_cRel + "10) GravarStatus sem conexao -> " + IIF(loc_lGrav, ".T.(BUG)", ".F.(ok)") + ;
    " erroExibido=" + IIF(loBO.this_lErroExibido, "SIM(ok)", "NAO(BUG)") + CHR(13) + CHR(10)

*-- 11) As flags de sessao NAO podem ter sido zeradas por uma gravacao que falhou
loBO.this_lHouveInclusao = .T.
loBO.this_lHouveExclusao = .T.
= loBO.GravarStatus("MALOTE")
loc_cRel = loc_cRel + "11) flags apos falha -> Inc=" + IIF(loBO.this_lHouveInclusao, ".T.(ok)", ".F.(BUG)") + ;
    " Exc=" + IIF(loBO.this_lHouveExclusao, ".T.(ok)", ".F.(BUG)") + CHR(13) + CHR(10)

STRTOFILE(loc_cRel, "C:\4c\automation\_f7sts_probe.txt")
QUIT
