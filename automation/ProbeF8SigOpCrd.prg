*-- Probe da FASE 8 de FormSigOpCrd (task713).
*--
*-- DUAS armadilhas desta tela, as duas medidas nesta sessao:
*--
*-- 1) fChecaAcesso eh redefinido AQUI, no proprio programa principal, porque
*--    a definicao viva eh a de Framework\sigacess.PRG (que vence a de
*--    functions.prg) e ela abre conexao SQL - sem SQL Server alcancavel nesta
*--    maquina ela PENDURA dentro do CREATEOBJECT do form, que eh onde o BO a
*--    chama para resolver this_lPodeExcluir.
*--
*-- 2) O form tem DataSession = 2 (privada), entao cursor_4c_Dados NAO existe
*--    na sessao do script: USED() devolve .F. e SELECT estoura. Por isso o
*--    probe faz SET DATASESSION TO loForm.DataSessionId depois de instanciar.
*--
*-- ATENCAO ao rodar: APAGAR o .fxp antes - o VFP reaproveita o compilado
*-- antigo e o probe roda codigo velho sem avisar.
SET SAFETY OFF
SET RESOURCE OFF
PUBLIC pcCk
pcCk = "C:\4c\automation\probe_f8crd.txt"
STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), pcCk)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f8crd_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"

DO config.prg
STRTOFILE("CK2 config.prg OK" + CHR(13) + CHR(10), pcCk, 1)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCrdBO.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCrd.prg") ADDITIVE
STRTOFILE("CK3 dependencias OK" + CHR(13) + CHR(10), pcCk, 1)

LOCAL loPai, loForm, loBO, lcAlias, llOk, lcChave, lnI, lcRO, lnSessao
loPai = CREATEOBJECT("FormPaiFalsoCrd")
loPai.PcEscolha = "INSERIR"

STRTOFILE("CK4 antes do CREATEOBJECT do form" + CHR(13) + CHR(10), pcCk, 1)
loForm = CREATEOBJECT("ProbeFormSigOpCrd", loPai, "COMPRA TESTE", "INSERIR")
STRTOFILE("CK5 instancia=" + VARTYPE(loForm) + CHR(13) + CHR(10), pcCk, 1)

IF VARTYPE(loForm) != "O"
    STRTOFILE("CK5x FALHOU - form nao instanciou" + CHR(13) + CHR(10), pcCk, 1)
    QUIT
ENDIF

loBO     = loForm.this_oBusinessObject
lcAlias  = ALLTRIM(loBO.this_cCursorDados)
lnSessao = loForm.DataSessionId
SET DATASESSION TO lnSessao
ON ERROR STRTOFILE("ERRO: " + MESSAGE() + " || " + MESSAGE(1) + ;
    " || LN=" + TRANSFORM(LINENO()) + " PROG=" + PROGRAM() + CHR(13) + CHR(10), pcCk, 1)
STRTOFILE("CK6 sessao=" + TRANSFORM(lnSessao) + " alias=[" + lcAlias + ;
    "] used=" + TRANSFORM(USED(lcAlias)) + " recc=" + ;
    TRANSFORM(IIF(USED(lcAlias), RECCOUNT(lcAlias), -1)) + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 1 - bind da grade e estado da digitacao apos o Init
lcRO = ""
FOR lnI = 1 TO loForm.grd_4c_Dados.ColumnCount
    lcRO = lcRO + TRANSFORM(loForm.grd_4c_Dados.Columns(lnI).ReadOnly) + " "
ENDFOR
STRTOFILE("CK7 T1 grade recsrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
    " colcount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
    " c1cs=[" + loForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
    " c4cs=[" + loForm.grd_4c_Dados.Column4.ControlSource + "]" + ;
    " c1w=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + ;
    " c3w=" + TRANSFORM(loForm.grd_4c_Dados.Column3.Width) + ;
    " gridRO=" + TRANSFORM(loForm.grd_4c_Dados.ReadOnly) + ;
    " gridEnab=" + TRANSFORM(loForm.grd_4c_Dados.Enabled) + ;
    " colRO=[" + lcRO + "]" + ;
    IIF(loForm.grd_4c_Dados.ColumnCount = 4 AND !loForm.grd_4c_Dados.ReadOnly ;
        AND loForm.grd_4c_Dados.Enabled AND lcRO == ".F. .F. .F. .F. ", ;
        " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- Linha de trabalho com valores conhecidos
SELECT (lcAlias)
GO TOP
REPLACE faixais WITH 100, faixafs WITH 200, percs WITH 5, multiplos WITH 10 IN (lcAlias)
lcChave = ALLTRIM(cidchaves)
STRTOFILE("CK8 linha preparada chave=[" + lcChave + "] dopes=[" + ALLTRIM(dopes) + ;
    "] lnovos=" + TRANSFORM(lnovos) + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 2 - FormParaBO le a LINHA CORRENTE para as properties do BO
llOk = loForm.ProbeFormParaBO()
STRTOFILE("CK9 T2 FormParaBO ret=" + TRANSFORM(llOk) + ;
    " faixais=" + TRANSFORM(loBO.this_nFaixais) + ;
    " faixafs=" + TRANSFORM(loBO.this_nFaixafs) + ;
    " percs=" + TRANSFORM(loBO.this_nPercs) + ;
    " multiplos=" + TRANSFORM(loBO.this_nMultiplos) + ;
    " chave=[" + ALLTRIM(loBO.this_cCidchaves) + "]" + ;
    IIF(llOk AND loBO.this_nFaixais = 100 AND loBO.this_nFaixafs = 200 ;
        AND loBO.this_nPercs = 5 AND loBO.this_nMultiplos = 10 ;
        AND ALLTRIM(loBO.this_cCidchaves) == lcChave, " [OK]", " [FALHOU]") + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 3 - GUARDA DE IDENTIDADE: chave do BO diferente da linha corrente
*--           NAO pode escrever
loBO.this_cCidchaves = "CHAVE-DE-OUTRA"
loBO.this_nFaixais   = 777
llOk = loForm.ProbeBOParaForm()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK10 T3 guarda identidade ret=" + TRANSFORM(llOk) + ;
    " faixais=" + TRANSFORM(faixais) + ;
    IIF(!llOk AND faixais = 100, " [OK nao escreveu]", " [FALHOU escreveu]") + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 4 - chave BATENDO: BOParaForm escreve as quatro colunas
loBO.this_cCidchaves = lcChave
loBO.this_nFaixais   = 11
loBO.this_nFaixafs   = 22
loBO.this_nPercs     = 3.5
loBO.this_nMultiplos = 44
llOk = loForm.ProbeBOParaForm()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK11 T4 BOParaForm escreve ret=" + TRANSFORM(llOk) + ;
    " faixais=" + TRANSFORM(faixais) + " faixafs=" + TRANSFORM(faixafs) + ;
    " percs=" + TRANSFORM(percs) + " multiplos=" + TRANSFORM(multiplos) + ;
    " dopes=[" + ALLTRIM(dopes) + "] chave=[" + ALLTRIM(cidchaves) + "]" + ;
    IIF(llOk AND faixais = 11 AND faixafs = 22 AND percs = 3.5 AND multiplos = 44 ;
        AND ALLTRIM(cidchaves) == lcChave AND !EMPTY(ALLTRIM(dopes)), ;
        " [OK identidade preservada]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 5 - LimparCampos zera as QUATRO colunas e preserva a identidade
llOk = loForm.ProbeLimparCampos()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK12 T5 LimparCampos ret=" + TRANSFORM(llOk) + ;
    " faixais=" + TRANSFORM(faixais) + " faixafs=" + TRANSFORM(faixafs) + ;
    " percs=" + TRANSFORM(percs) + " multiplos=" + TRANSFORM(multiplos) + ;
    " dopes=[" + ALLTRIM(dopes) + "] chave=[" + ALLTRIM(cidchaves) + "]" + ;
    IIF(llOk AND faixais = 0 AND faixafs = 0 AND percs = 0 AND multiplos = 0 ;
        AND ALLTRIM(cidchaves) == lcChave AND !EMPTY(ALLTRIM(dopes)), ;
        " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 6a - HabilitarCampos(.F.) fecha grade e colunas
loForm.HabilitarCampos(.F.)
lcRO = ""
FOR lnI = 1 TO loForm.grd_4c_Dados.ColumnCount
    lcRO = lcRO + TRANSFORM(loForm.grd_4c_Dados.Columns(lnI).ReadOnly) + " "
ENDFOR
STRTOFILE("CK13 T6a fechado gridRO=" + TRANSFORM(loForm.grd_4c_Dados.ReadOnly) + ;
    " gridEnab=" + TRANSFORM(loForm.grd_4c_Dados.Enabled) + ;
    " colRO=[" + lcRO + "]" + ;
    " excluirEnab=" + TRANSFORM(loForm.cmd_4c_Excluir.Enabled) + ;
    " encerrarEnab=" + TRANSFORM(loForm.cmd_4c_Encerrar.Enabled) + ;
    IIF(loForm.grd_4c_Dados.ReadOnly AND !loForm.grd_4c_Dados.Enabled ;
        AND lcRO == ".T. .T. .T. .T. " ;
        AND !loForm.cmd_4c_Excluir.Enabled AND loForm.cmd_4c_Encerrar.Enabled, ;
        " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 6b - e (.T.) reabre
loForm.HabilitarCampos(.T.)
lcRO = ""
FOR lnI = 1 TO loForm.grd_4c_Dados.ColumnCount
    lcRO = lcRO + TRANSFORM(loForm.grd_4c_Dados.Columns(lnI).ReadOnly) + " "
ENDFOR
STRTOFILE("CK14 T6b reaberto gridRO=" + TRANSFORM(loForm.grd_4c_Dados.ReadOnly) + ;
    " gridEnab=" + TRANSFORM(loForm.grd_4c_Dados.Enabled) + ;
    " colRO=[" + lcRO + "]" + ;
    " excluirEnab=" + TRANSFORM(loForm.cmd_4c_Excluir.Enabled) + ;
    IIF(!loForm.grd_4c_Dados.ReadOnly AND loForm.grd_4c_Dados.Enabled ;
        AND lcRO == ".F. .F. .F. .F. ", " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 7 - HabilitarCampos SEM argumento (como o harness chama) = .T.
loForm.HabilitarCampos(.F.)
loForm.HabilitarCampos()
STRTOFILE("CK15 T7 sem argumento gridRO=" + TRANSFORM(loForm.grd_4c_Dados.ReadOnly) + ;
    " gridEnab=" + TRANSFORM(loForm.grd_4c_Dados.Enabled) + ;
    IIF(!loForm.grd_4c_Dados.ReadOnly AND loForm.grd_4c_Dados.Enabled, ;
        " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 8 - CarregarLista de novo: religa a grade e reabre as colunas
llOk = loForm.CarregarLista()
lcRO = ""
FOR lnI = 1 TO loForm.grd_4c_Dados.ColumnCount
    lcRO = lcRO + TRANSFORM(loForm.grd_4c_Dados.Columns(lnI).ReadOnly) + " "
ENDFOR
STRTOFILE("CK16 T8 CarregarLista ret=" + TRANSFORM(llOk) + ;
    " recsrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
    " colcount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
    " c1cs=[" + loForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
    " colRO=[" + lcRO + "]" + ;
    " recc=" + TRANSFORM(IIF(USED(lcAlias), RECCOUNT(lcAlias), -1)) + ;
    IIF(loForm.grd_4c_Dados.ColumnCount = 4 AND lcRO == ".F. .F. .F. .F. ", ;
        " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 9 - FormParaBO em EOF devolve .F. e nao estoura
SELECT (lcAlias)
GO BOTTOM
SKIP
llOk = loForm.ProbeFormParaBO()
STRTOFILE("CK17 T9 FormParaBO em EOF ret=" + TRANSFORM(llOk) + ;
    IIF(!llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 10 - BOParaForm em EOF devolve .F. e nao estoura
llOk = loForm.ProbeBOParaForm()
STRTOFILE("CK18 T10 BOParaForm em EOF ret=" + TRANSFORM(llOk) + ;
    IIF(!llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

STRTOFILE("CK19 msgerro=[" + loForm.this_cMensagemErro + "]" + CHR(13) + CHR(10), pcCk, 1)
STRTOFILE("CK20 paiEnabled(antes do release)=" + TRANSFORM(loPai.Enabled) + CHR(13) + CHR(10), pcCk, 1)
SET DATASESSION TO 1
loForm.Release()
STRTOFILE("CK21 release OK paiEnabled=" + TRANSFORM(loPai.Enabled) + ;
    IIF(loPai.Enabled, " [OK pai reabilitado]", " [FALHOU pai preso]") + ;
    CHR(13) + CHR(10), pcCk, 1)
STRTOFILE("CK22 FIM" + CHR(13) + CHR(10), pcCk, 1)
QUIT


*-- Subclasse de teste: expoe por wrapper publico os hooks que FormBase
*-- declara PROTECTED (FormParaBO/BOParaForm/LimparCampos). Script solto NAO
*-- alcanca membro protegido - subclasse alcanca.
DEFINE CLASS ProbeFormSigOpCrd AS FormSigOpCrd
    PROCEDURE ProbeFormParaBO
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ProbeLimparCampos
        RETURN THIS.LimparCampos()
    ENDPROC
ENDDEFINE


*-- Form PAI falso: o dialogo so le PcEscolha e mexe em Enabled
DEFINE CLASS FormPaiFalsoCrd AS Form
    PcEscolha = ""
ENDDEFINE


*-- Permissao resolvida FORA do banco (ver cabecalho)
FUNCTION fChecaAcesso(par_cTabela, par_cOperacao, par_cMsg, par_cUsu, par_lTot)
RETURN .T.
ENDFUNC
