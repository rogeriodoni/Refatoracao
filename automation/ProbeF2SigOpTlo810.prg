* ProbeF2SigOpTlo810.prg
* Exercita os metodos da Fase 2 do SigOpTloBO (task810) com cursores de
* mentira no lugar dos cursores do form PAI, nos DOIS modos (OFFLINE e
* ONLINE), e grava o resultado medido em _f2tlo_probe.txt.
*
* Nao toca o banco: o BO nao consulta nada, e CarregarParametroPerLocais()
* cai no caminho "sem conexao" porque gnConnHandle = -1.
SET SAFETY OFF
SET RESOURCE OFF
SET EXACT ON
SET DELETED OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f2tlo_probe_erro.txt"

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpTloBO.prg") ADDITIVE

LOCAL loc_cRel, loc_oBO, loc_lOK
loc_cRel = ""

*-- cursores que no sistema real sao do form PAI (modo OFFLINE)
CREATE CURSOR cursor_4c_Historico (localis C(10), tipos N(1,0), qtds N(11,3))
INSERT INTO cursor_4c_Historico VALUES ("L001", 1, 10.000)
INSERT INTO cursor_4c_Historico VALUES ("L001", 1,  5.000)
INSERT INTO cursor_4c_Historico VALUES ("L002", 1,  7.000)
INSERT INTO cursor_4c_Historico VALUES ("L002", 2,  3.000)
INSERT INTO cursor_4c_Historico VALUES ("L003", 3, 99.000)

CREATE CURSOR cursor_4c_Etiqueta (qtds N(9,3))
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)

loc_oBO = CREATEOBJECT("SigOpTloBO")
loc_cRel = loc_cRel + "BO VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10)

loc_lOK = loc_oBO.TotalizarLocais(1)
loc_cRel = loc_cRel + "OFFLINE TotalizarLocais=" + IIF(loc_lOK, "T", "F") + ;
    " msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10)

loc_cRel = loc_cRel + "OFFLINE linhas=" + TRANSFORM(IIF(USED("cursor_4c_Locais"), RECCOUNT("cursor_4c_Locais"), -1)) + ;
    " (esperado 3)" + CHR(13) + CHR(10)

IF USED("cursor_4c_Locais")
    SELECT cursor_4c_Locais
    SCAN
        loc_cRel = loc_cRel + "  linha [" + ALLTRIM(cursor_4c_Locais.Localis) + "] Leitura=" + ;
            ALLTRIM(STR(cursor_4c_Locais.Leitura, 10, 2)) + " ReLeitura=" + ;
            ALLTRIM(STR(cursor_4c_Locais.ReLeitura, 10, 2)) + CHR(13) + CHR(10)
    ENDSCAN
ENDIF

loc_cRel = loc_cRel + "OFFLINE TotalLido=" + ALLTRIM(STR(loc_oBO.this_nTotalLido, 10, 2)) + " (esperado 18.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE TotalEstoque=" + ALLTRIM(STR(loc_oBO.this_nTotalEstoque, 10, 2)) + " (esperado 4.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE PercLeitura=" + ALLTRIM(STR(loc_oBO.this_nPercLeitura, 12, 2)) + " (esperado 450.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE TotalReleitura=" + ALLTRIM(STR(loc_oBO.this_nTotalReleitura, 10, 2)) + " (esperado 0.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE PercReleitura=" + ALLTRIM(STR(loc_oBO.this_nPercReleitura, 10, 2)) + " (esperado 0.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE linha corrente carregada=[" + ALLTRIM(loc_oBO.this_cLocalis) + "] (esperado L001)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "OFFLINE ponteiro do historico (RECNO)=" + TRANSFORM(RECNO("cursor_4c_Historico")) + " (esperado 5 = Go Bottom)" + CHR(13) + CHR(10)

*-- rotulos do rodape: perlocals desligado (sem conexao) -> os tres vazios
loc_cRel = loc_cRel + "PerLocals=" + IIF(loc_oBO.this_lPerLocals, "T", "F") + ;
    " TextoLido=[" + loc_oBO.ObterTextoTotalLido() + "]" + ;
    " TextoEstoque=[" + loc_oBO.ObterTextoTotalEstoque() + "]" + ;
    " TextoPerc=[" + loc_oBO.ObterTextoPercLeitura() + "]" + CHR(13) + CHR(10)

*-- com o parametro LIGADO, a formatacao do legado
loc_oBO.this_lPerLocals = .T.
loc_cRel = loc_cRel + "PerLocals=T" + ;
    " TextoLido=[" + loc_oBO.ObterTextoTotalLido() + "]" + ;
    " TextoEstoque=[" + loc_oBO.ObterTextoTotalEstoque() + "]" + ;
    " TextoPerc=[" + loc_oBO.ObterTextoPercLeitura() + "]" + CHR(13) + CHR(10)

*-- modo ONLINE: os cursores do pai sao outros dois
CREATE CURSOR cursor_4c_HistoricoOnLine (localis C(10), tipos N(1,0), qtds N(11,3))
INSERT INTO cursor_4c_HistoricoOnLine VALUES ("L009", 2, 20.000)

CREATE CURSOR cursor_4c_EtiquetaOnLine (qtds N(9,3))
INSERT INTO cursor_4c_EtiquetaOnLine VALUES (1.000)
INSERT INTO cursor_4c_EtiquetaOnLine VALUES (1.000)

loc_lOK = loc_oBO.TotalizarLocais(2, .T.)
loc_cRel = loc_cRel + "ONLINE TotalizarLocais=" + IIF(loc_lOK, "T", "F") + ;
    " msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE linhas=" + TRANSFORM(IIF(USED("cursor_4c_Locais"), RECCOUNT("cursor_4c_Locais"), -1)) + ;
    " (esperado 1 - o Zap descartou a totalizacao anterior)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE local=[" + ALLTRIM(loc_oBO.this_cLocalis) + "] Leitura=" + ;
    ALLTRIM(STR(loc_oBO.this_nLeitura, 10, 2)) + " ReLeitura=" + ;
    ALLTRIM(STR(loc_oBO.this_nReLeitura, 10, 2)) + " (esperado L009 0.00 20.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE TotalLido=" + ALLTRIM(STR(loc_oBO.this_nTotalLido, 10, 2)) + " (esperado 20.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE TotalEstoque=" + ALLTRIM(STR(loc_oBO.this_nTotalEstoque, 10, 2)) + " (esperado 2.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE PercLeitura=" + ALLTRIM(STR(loc_oBO.this_nPercLeitura, 12, 2)) + " (esperado 1000.00)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "ONLINE ponteiro do historico online (RECNO)=" + TRANSFORM(RECNO("cursor_4c_HistoricoOnLine")) + ;
    " (esperado 2 = EOF, sem Go Bottom neste ramo)" + CHR(13) + CHR(10)

*-- Buscar() tem de refazer a totalizacao no modo corrente, sem SELECT remoto
loc_lOK = loc_oBO.Buscar()
loc_cRel = loc_cRel + "Buscar()=" + IIF(loc_lOK, "T", "F") + " linhas=" + ;
    TRANSFORM(IIF(USED("cursor_4c_Locais"), RECCOUNT("cursor_4c_Locais"), -1)) + ;
    " TotalLido=" + ALLTRIM(STR(loc_oBO.this_nTotalLido, 10, 2)) + " (esperado T 1 20.00)" + CHR(13) + CHR(10)

*-- cursor de leituras AUSENTE: recusa com mensagem, sem estourar
loc_oBO.this_cCursorHistoricoOnLine = "cursor_4c_NaoExiste"
loc_lOK = loc_oBO.TotalizarLocais(2, .T.)
loc_cRel = loc_cRel + "SEM CURSOR TotalizarLocais=" + IIF(loc_lOK, "T", "F") + ;
    " msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "] (esperado F com mensagem)" + CHR(13) + CHR(10)

loc_cRel = loc_cRel + "ERRO MSG ARQUIVO=" + IIF(FILE(gc_4c_ArquivoErroTeste), "EXISTE", "ausente") + CHR(13) + CHR(10)

STRTOFILE(loc_cRel, "C:\4c\automation\_f2tlo_probe.txt")

QUIT
