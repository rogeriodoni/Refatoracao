*-- Teste de runtime dos metodos da Fase 2 que nao dependem de conexao SQL:
*-- MontarChaveEmpDnPs (chave POSICIONAL) e CarregarDoCursor (leitura do cursor).
*-- Nao usa ConfigurarAmbiente(): so carrega o que eh necessario, para nao abrir
*-- conexao nem dialogo num processo headless.
SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF
SET TALK OFF

LOCAL loc_cLog, loc_cSaida, loc_oBO, loc_cChave, loc_nAreaAntes, loc_nAreaDepois
LOCAL loc_lOK, loc_cEsperado

loc_cLog = "C:\4c\tasks\task772\testar_bo_fase2_resultado.txt"
loc_cSaida = ""

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SIGOPNOPBO.prg") ADDITIVE

loc_oBO = CREATEOBJECT("TesteSigOpNopBO")

IF VARTYPE(loc_oBO) != "O"
    STRTOFILE("FALHA: nao instanciou o BO de teste", loc_cLog)
    QUIT
ENDIF

*------------------------------------------------------------------------------
* TESTE 1 - MontarChaveEmpDnPs: a chave tem de ter EXATAMENTE 33 posicoes
*           (Emps 3 + Dopps 20 + Str(Numps,10)), que eh a largura do char(33)
*------------------------------------------------------------------------------
loc_cChave = loc_oBO.MontarChaveEmpDnPs("001", "MALOTE", 3)
loc_cEsperado = PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 10)

loc_cSaida = loc_cSaida + "TESTE 1 - MontarChaveEmpDnPs" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  chave   = [" + loc_cChave + "]" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  LEN     = " + TRANSFORM(LEN(loc_cChave)) + " (esperado 33)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  bate    = " + IIF(loc_cChave == loc_cEsperado, "SIM", "NAO") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  RESULT  = " + IIF(LEN(loc_cChave) = 33 AND loc_cChave == loc_cEsperado, "OK", "FALHOU") + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*-- prova de que ALLTRIM nas partes QUEBRARIA a chave (o defeito da regra #42)
loc_cSaida = loc_cSaida + "TESTE 1b - forma ERRADA (ALLTRIM nas partes) para contraste" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  LEN com ALLTRIM = " + TRANSFORM(LEN(ALLTRIM("001") + ALLTRIM("MALOTE") + STR(3, 10))) + ;
    " (!= 33 -> nunca casaria)" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*-- argumentos ausentes / de tipo errado nao podem estourar
loc_cSaida = loc_cSaida + "TESTE 1c - argumentos ausentes/tipo errado" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  LEN(sem args)   = " + TRANSFORM(LEN(loc_oBO.MontarChaveEmpDnPs())) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  LEN(tipo errado)= " + TRANSFORM(LEN(loc_oBO.MontarChaveEmpDnPs(0, .F., "x"))) + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*------------------------------------------------------------------------------
* TESTE 2 - CarregarDoCursor sobre cursor com a MESMA estrutura da arvore.
*           Servicos entra NUMERICO (o SELECT do BO faz CAST(... AS INT)).
*------------------------------------------------------------------------------
CREATE CURSOR cursor_4c_Arvore ( ;
    Cidchaves C(20), Nenvs N(10,0), EmpDnPs C(33), Datas D, ;
    Grupoos C(10), Contaos C(10), Grupods C(10), Contads C(10), ;
    Servicos N(1,0), Nops N(10,0), Cmats C(14), Dpros C(65), ;
    Qtds N(9,3), Cunis C(3), Peso2s N(9,3), Cunips C(3), ;
    Pesos N(9,3), Cpros C(14), NopMaes N(10,0), TotPesos N(11,3))

INSERT INTO cursor_4c_Arvore ;
    (Cidchaves, Nenvs, EmpDnPs, Datas, Grupoos, Contaos, Grupods, Contads, ;
     Servicos, Nops, Cmats, Dpros, Qtds, Cunis, Peso2s, Cunips, Pesos, ;
     Cpros, NopMaes, TotPesos) ;
    VALUES ;
    ("CHV0001", 777, loc_cChave, DATE(), "GRP01", "CTA01", "GRP02", "CTA02", ;
     1, 555, "MAT-X", "PRODUTO X", 12.5, "KG", 3.25, "GR", 99.125, ;
     "PRO-001", 888, 1234.567)

*-- area de trabalho ANTES: o metodo tem de devolver o foco onde estava
CREATE CURSOR cursor_4c_Outro (campo C(1))
SELECT cursor_4c_Outro
loc_nAreaAntes = SELECT()

SELECT cursor_4c_Arvore
GO TOP
SELECT cursor_4c_Outro

loc_lOK = loc_oBO.CarregarDoCursor("cursor_4c_Arvore")
loc_nAreaDepois = SELECT()

loc_cSaida = loc_cSaida + "TESTE 2 - CarregarDoCursor" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  retorno        = " + IIF(loc_lOK, ".T.", ".F.") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Cidchaves      = [" + ALLTRIM(loc_oBO.this_cCidchaves) + "]" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Nenvs          = " + TRANSFORM(loc_oBO.this_nNenvs) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Dpros          = [" + ALLTRIM(loc_oBO.this_cDpros) + "]" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Pesos          = " + TRANSFORM(loc_oBO.this_nPesos) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  TotPesos       = " + TRANSFORM(loc_oBO.this_nTotPesos) + " (esperado 1234.567)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Datas VARTYPE  = " + VARTYPE(loc_oBO.this_dDatas) + " (esperado D)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Servicos       = " + IIF(loc_oBO.this_lServicos, ".T.", ".F.") + ;
    " / VARTYPE = " + VARTYPE(loc_oBO.this_lServicos) + " (esperado L e .T.)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  area restaurada= " + IIF(loc_nAreaAntes = loc_nAreaDepois, "SIM", "NAO") + CHR(13) + CHR(10)

*-- decomposicao POSICIONAL tem de recuperar as partes originais
loc_cSaida = loc_cSaida + "  Emps           = [" + loc_oBO.this_cEmps + "] (esperado [001])" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Dopps(ALLTRIM) = [" + ALLTRIM(loc_oBO.this_cDopps) + "] (esperado [MALOTE])" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Numps          = " + TRANSFORM(loc_oBO.this_nNumps) + " (esperado 3)" + CHR(13) + CHR(10)

*-- round-trip: remontar a chave a partir das partes decompostas
loc_cSaida = loc_cSaida + "  round-trip     = " + ;
    IIF(loc_oBO.MontarChaveEmpDnPs(loc_oBO.this_cEmps, loc_oBO.this_cDopps, loc_oBO.this_nNumps) == loc_cChave, ;
        "OK (chave identica)", "FALHOU") + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*------------------------------------------------------------------------------
* TESTE 3 - cursor SEM a coluna TotPesos (alias cru de SQLEXEC).
*           Sem o guard TYPE(), o nome de campo inexistente estouraria
*           "Variable TOTPESOS is not found".
*------------------------------------------------------------------------------
CREATE CURSOR cursor_4c_Nensi ( ;
    Cidchaves C(20), Nenvs N(10,0), EmpDnPs C(33), Datas D, ;
    Grupoos C(10), Contaos C(10), Grupods C(10), Contads C(10), ;
    Servicos N(1,0), Nops N(10,0), Cmats C(14), Dpros C(65), ;
    Qtds N(9,3), Cunis C(3), Peso2s N(9,3), Cunips C(3), ;
    Pesos N(9,3), Cpros C(14), NopMaes N(10,0))

INSERT INTO cursor_4c_Nensi ;
    (Cidchaves, Nenvs, EmpDnPs, Datas, Servicos, Nops, Cmats, Pesos) ;
    VALUES ("CHV0002", 111, loc_cChave, DATE(), 0, 222, "MAT-Y", 5.5)

loc_lOK = loc_oBO.CarregarDoCursor("cursor_4c_Nensi")

loc_cSaida = loc_cSaida + "TESTE 3 - cursor sem a coluna TotPesos" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  retorno   = " + IIF(loc_lOK, ".T.", ".F.") + " (sem erro = guard TYPE() funcionou)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  TotPesos  = " + TRANSFORM(loc_oBO.this_nTotPesos) + " (esperado 0)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Servicos  = " + IIF(loc_oBO.this_lServicos, ".T.", ".F.") + " (esperado .F.)" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*------------------------------------------------------------------------------
* TESTE 4 - cursor em EOF e alias inexistente: nenhum dos dois pode estourar
*------------------------------------------------------------------------------
SELECT cursor_4c_Arvore
GO BOTTOM
SKIP
loc_lOK = loc_oBO.CarregarDoCursor("cursor_4c_Arvore")

loc_cSaida = loc_cSaida + "TESTE 4 - EOF e alias inexistente" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  EOF retorno     = " + IIF(loc_lOK, ".T.", ".F.") + " (esperado .F., sem erro)" + CHR(13) + CHR(10)

loc_lOK = loc_oBO.CarregarDoCursor("cursor_4c_NaoExiste")
loc_cSaida = loc_cSaida + "  inexistente     = " + IIF(loc_lOK, ".T.", ".F.") + " (esperado .F.)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  mensagem        = [" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*------------------------------------------------------------------------------
* TESTE 5 - ObterChavePrimaria (via wrapper, por ser PROTECTED) e LimparDados
*------------------------------------------------------------------------------
SELECT cursor_4c_Arvore
GO TOP
loc_lOK = loc_oBO.CarregarDoCursor("cursor_4c_Arvore")

loc_cSaida = loc_cSaida + "TESTE 5 - ObterChavePrimaria e LimparDados" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  chave primaria  = [" + loc_oBO.ExporChavePrimaria() + "]" + CHR(13) + CHR(10)

loc_oBO.LimparDados()
loc_cSaida = loc_cSaida + "  pos-LimparDados EmpDnPs vazio = " + IIF(EMPTY(loc_oBO.this_cEmpDnPs), "SIM", "NAO") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  pos-LimparDados cursor fechado= " + IIF(!USED("cursor_4c_Arvore"), "SIM", "NAO") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  pos-LimparDados Servicos      = " + IIF(loc_oBO.this_lServicos, ".T.", ".F.") + " (esperado .F.)" + CHR(13) + CHR(10)

STRTOFILE(loc_cSaida, loc_cLog)

QUIT


*==============================================================================
* Subclasse de teste: Init VAZIO de proposito.
* Instanciar o BO real chamaria BusinessBase.Init, que sem conexao SQL abre
* dialogo e travaria o VFP num processo headless.
* ExporChavePrimaria existe so para alcancar ObterChavePrimaria, que eh
* PROTECTED (o Form NUNCA chama metodo PROTECTED do BO).
*==============================================================================
DEFINE CLASS TesteSigOpNopBO AS SIGOPNOPBO

    PROCEDURE Init()
        THIS.this_cCursorArvore = "cursor_4c_Arvore"
        THIS.this_cCursorProduto = "cursor_4c_Produto"
        THIS.ResetarRegistroCorrente()
        RETURN .T.
    ENDPROC

    PROCEDURE ExporChavePrimaria()
        RETURN THIS.ObterChavePrimaria()
    ENDPROC

ENDDEFINE
