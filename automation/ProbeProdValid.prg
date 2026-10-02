*-- Erro186: regras do Salva.Click do legado, agora em ValidarRegrasGravacao.
*-- NAO grava: usa um BO de teste que expoe o ValidarDados (PROTECTED).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodvalid.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodvalid.txt"
LOCAL loc_oE, loc_oBO, loc_n, loc_cGru, loc_nErros
STRTOFILE("A: inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "ProdutoBO.prg")    ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("B: conn=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10), OUT, 1)

    *-- grupo SEM nenhuma obrigatoriedade ligada, para isolar cada regra
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cgrus FROM SigCdGrp" + ;
        " WHERE obrsgrus = 0 AND obrigfiscs = 0 AND obridecs = 0 AND obrcclas = 0" + ;
        "   AND obrfinps = 0 AND obrlinha = 0 AND obrcolec = 0 AND obrdimes = 0" + ;
        "   AND ajpvens = 0 AND obrpesoms = 0 AND obrconjuts = 0 AND localobrig = 0" + ;
        "   AND vldconjuts = 0 AND nchkpess = 0 AND fornecs = 0 AND omoecs = 0" + ;
        "   AND omoecusfs = 0 AND omoedas = 0 AND omoevs = 0 AND servprds = 0" + ;
        "   AND pcuss = 0 AND fcustos = 0 AND custofs = 0 AND pmargems = 0" + ;
        "   AND pvideals = 0 AND markupa = 0 AND pvens = 0" + ;
        "   AND LTRIM(RTRIM(ISNULL(grctobccs,''))) = ''" + ;
        "   AND SUBSTRING(cfggergprs,1,1) = ' ' AND SUBSTRING(cfggergprs,10,1) <> '1'" + ;
        "   AND SUBSTRING(cfggergprs,16,1) <> '1' AND SUBSTRING(cfggergprs,39,1) <> '1'" + ;
        "   AND SUBSTRING(cfggergprs,3,2) = '  ' AND SUBSTRING(cfggergprs,7,2) = '  '" + ;
        " ORDER BY cgrus", "crGN")
    loc_cGru = IIF(loc_n > 0 AND RECCOUNT("crGN") > 0, ALLTRIM(crGN.cgrus), "")
    STRTOFILE("C: grupo NEUTRO = [" + loc_cGru + "]" + CHR(13) + CHR(10), OUT, 1)

    IF EMPTY(loc_cGru)
        STRTOFILE("   *** nenhum grupo neutro - teste abortado" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_nErros = 0

        *-- BASE: um produto valido que deve PASSAR em tudo
        loc_nErros = loc_nErros + Caso("base valida", loc_cGru, "", .T., "")

        *-- 4) Descricao em branco
        loc_nErros = loc_nErros + Caso("descricao vazia", loc_cGru, "DPRO", .F., "Descri")

        *-- 13) Unidade 1
        loc_nErros = loc_nErros + Caso("unidade 1 vazia", loc_cGru, "CUNI", .F., "Unidade Inv")

        *-- 6) EAN13: NENHUM produto desta base tem ean13 <> 0 (conferido:
        *-- SELECT COUNT(*) WHERE ean13 <> 0 = 0), entao o ramo POSITIVO nao
        *-- tem como ser exercitado sem gravar. Prova-se (a) que com EAN13
        *-- preenchido e sem duplicata a regra NAO acusa, e (b) que a consulta
        *-- montada encontra linha quando existe duplicata - rodando a MESMA
        *-- forma de SQL contra cbars, que tem 255 linhas preenchidas.
        loc_nErros = loc_nErros + Caso("ean13 sem duplicata", loc_cGru, "EAN13NOVO", .T., "")
        DO ProvaSqlDuplicata

        *-- 18) Moeda do Preco de Venda inexistente
        loc_nErros = loc_nErros + Caso("moeda venda invalida", loc_cGru, "MOEV", .F., ;
            "Moeda do Pre")

        *-- 17) Moeda do Valor Estimado inexistente
        loc_nErros = loc_nErros + Caso("moeda estimado invalida", loc_cGru, "MOEDA", .F., ;
            "Valor Estimado")

        *-- 19) Moeda do Fator de Venda inexistente
        loc_nErros = loc_nErros + Caso("moeda fator invalida", loc_cGru, "MOEPV", .F., ;
            "Fator de Venda Inv")

        STRTOFILE(CHR(13) + CHR(10) + "TOTAL DE DIVERGENCIAS = " + ;
            TRANSFORM(loc_nErros) + CHR(13) + CHR(10), OUT, 1)

        *-- regras que dependem da CONFIG do grupo: achar um grupo que as ligue
        STRTOFILE(CHR(13) + CHR(10) + "=== regras ligadas por configuracao ===" + ;
            CHR(13) + CHR(10), OUT, 1)
        DO CfgCaso WITH "obrpesoms = 1",  "peso medio",       "Peso M", "PESOMS"
        DO CfgCaso WITH "obrconjuts = 1", "cod. pai",         "Cod. Pai", "CONJUNTS"
        DO CfgCaso WITH "localobrig = 1", "localizacao",      "Localiza", "LOCALS"
        DO CfgCaso WITH "fornecs = 1",    "fornecedor",       "Fornecedor Inv", "IFORS"
        DO CfgCaso WITH "omoecs = 1",     "moeda custo comp", "Moeda de Custo", "MOECS"
        DO CfgCaso WITH "servprds = 1",   "6 digitos",        "6 digitos", ""
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

*-- Monta um BO valido, aplica UM defeito e confere o veredito
FUNCTION Caso(par_cNome, par_cGru, par_cDefeito, par_lEsperado, par_cTrecho)
    LOCAL loc_o, loc_l, loc_n, loc_cEan, loc_nErro
    loc_o = CREATEOBJECT("ProdutoBOValid")
    loc_o.this_lNovoRegistro = .T.

    *-- registro BASE valido
    loc_o.this_cCpros  = "E186TST"
    loc_o.this_cDpros  = "PRODUTO DE TESTE ERRO186"
    loc_o.this_cCgrus  = par_cGru
    loc_o.this_cCunis  = "PC"
    loc_o.this_nSituas = 1

    DO CASE
        CASE par_cDefeito == "DPRO"
            loc_o.this_cDpros = ""
        CASE par_cDefeito == "CUNI"
            loc_o.this_cCunis = ""
        CASE par_cDefeito == "EAN13NOVO"
            loc_o.this_nEan13 = 7899999999999
        CASE par_cDefeito == "MOEV"
            loc_o.this_nPvens = 10
            loc_o.this_cMoevs = "ZZZ"
        CASE par_cDefeito == "MOEDA"
            loc_o.this_nValors = 10
            loc_o.this_cMoedas = "ZZZ"
        CASE par_cDefeito == "MOEPV"
            loc_o.this_nFvendas = 10
            loc_o.this_cMoepvs  = "ZZZ"
    ENDCASE

    loc_l = loc_o.ExporValidar()
    loc_nErro = 0

    IF loc_l != par_lEsperado
        loc_nErro = 1
    ENDIF
    IF !EMPTY(par_cTrecho) AND !(par_cTrecho $ loc_o.this_cMensagemErro)
        loc_nErro = 1
    ENDIF

    STRTOFILE("   " + PADR(par_cNome, 24) + " valido=" + TRANSFORM(loc_l) + ;
        " (esperado " + TRANSFORM(par_lEsperado) + ")  msg=[" + ;
        ALLTRIM(loc_o.this_cMensagemErro) + "]" + ;
        IIF(loc_nErro = 0, "  OK", "  *** DIVERGE") + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_prodvalid.txt", 1)

    RETURN loc_nErro
ENDFUNC

*-- Procura um grupo com a configuracao ligada e confere que a regra dispara
PROCEDURE CfgCaso(par_cCond, par_cNome, par_cTrecho, par_cLimpar)
    LOCAL loc_n, loc_cG, loc_o, loc_l
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cgrus FROM SigCdGrp WHERE " + par_cCond + " ORDER BY cgrus", "crCfg")
    loc_cG = IIF(loc_n > 0 AND RECCOUNT("crCfg") > 0, ALLTRIM(crCfg.cgrus), "")

    IF EMPTY(loc_cG)
        STRTOFILE("   " + PADR(par_cNome, 20) + " -- nenhum grupo com [" + par_cCond + ;
            "] no banco (regra nao exercitada)" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_o = CREATEOBJECT("ProdutoBOValid")
        loc_o.this_lNovoRegistro = .T.
        *-- preenche TUDO que as regras ANTERIORES exigem, para que a execucao
        *-- chegue ate a regra alvo (a ordem do legado eh preservada)
        loc_o.this_cCpros      = "E186TESTE12345"
        loc_o.this_cDpros      = "PRODUTO DE TESTE ERRO186"
        loc_o.this_cCgrus      = loc_cG
        loc_o.this_cCunis      = "PC"
        loc_o.this_cCunips     = "PC"
        loc_o.this_nSituas     = 1
        loc_o.this_cSgrus      = "SG"
        loc_o.this_cClfiscals  = "39232190"
        loc_o.this_cIdecpros   = "ID"
        loc_o.this_cCclass     = ""
        loc_o.this_cCodfinp    = "MOD"
        loc_o.this_cLinhas     = "LIN"
        loc_o.this_cColecoes   = "COL"
        loc_o.this_nTamps      = 1
        loc_o.this_cCodcors    = "COR"
        loc_o.this_cCproeqs    = "EQ"
        loc_o.this_cReffs      = "REFERENCIA123456"
        loc_o.this_cObsetqs    = "OBSERVACAO DE COMPONENTE LONGA"
        loc_o.this_cCompos     = "COMPOSICAO"
        loc_o.this_cMatprincs  = "MATPRINC"
        loc_o.this_cGruccus    = "GRUCC"
        loc_o.this_cContaccus  = "CONTACC"
        loc_o.this_cConjunts   = "000001"
        loc_o.this_cLocals     = "LOCAL"
        loc_o.this_cIfors      = "FORNEC"
        loc_o.this_nPesoms     = 1
        loc_o.this_cMoecs      = "R$"
        loc_o.this_cMoecusfs   = "R$"
        loc_o.this_cMoedas     = "R$"
        loc_o.this_cMoevs      = "R$"

        *-- ZERA so o campo da regra ALVO, senao ela nao teria o que acusar
        DO CASE
            CASE par_cLimpar == "PESOMS"
                loc_o.this_nPesoms = 0
            CASE par_cLimpar == "CONJUNTS"
                loc_o.this_cConjunts = ""
            CASE par_cLimpar == "LOCALS"
                loc_o.this_cLocals = ""
            CASE par_cLimpar == "IFORS"
                loc_o.this_cIfors = ""
            CASE par_cLimpar == "MOECS"
                loc_o.this_cMoecs = ""
        ENDCASE

        loc_l = loc_o.ExporValidar()
        STRTOFILE("   " + PADR(par_cNome, 20) + " grupo=[" + loc_cG + "] valido=" + ;
            TRANSFORM(loc_l) + " msg=[" + ALLTRIM(loc_o.this_cMensagemErro) + "]" + ;
            IIF(par_cTrecho $ loc_o.this_cMensagemErro, "  OK (acusou)", ;
                "  (acusou OUTRA regra antes - ordem do legado)") + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDIF
ENDPROC

*-- Prova que a FORMA do SQL de duplicata encontra linha quando ela existe.
*-- Usa cbars (255 linhas preenchidas) porque ean13 esta zerado em toda a base.
PROCEDURE ProvaSqlDuplicata
    LOCAL loc_n, loc_nVal, loc_cPro, loc_cSQL
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cpros, cbars FROM SigCdPro WHERE cbars <> 0 ORDER BY cpros", "crB")
    IF loc_n > 0 AND RECCOUNT("crB") > 0
        loc_nVal = crB.cbars
        loc_cPro = ALLTRIM(crB.cpros)
        *-- mesma forma do SQL do BO: numero cru + NOT cpros = '<outro>'
        loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE cbars = " + ;
            FormatarNumeroSQL(loc_nVal, 0) + " AND NOT cpros = " + EscaparSQL("ZZZINEXISTENTE")
        loc_n = SQLEXEC(gnConnHandle, loc_cSQL, "crDup")
        STRTOFILE("   forma do SQL de duplicata: valor=" + TRANSFORM(loc_nVal) + ;
            " SQLEXEC=" + TRANSFORM(loc_n) + " linhas=" + ;
            TRANSFORM(IIF(USED("crDup"), RECCOUNT("crDup"), -1)) + ;
            IIF(USED("crDup") AND RECCOUNT("crDup") > 0, "  OK (encontra a duplicata)", ;
                "  *** NAO ENCONTROU") + CHR(13) + CHR(10), OUT, 1)
    ENDIF
ENDPROC

DEFINE CLASS ProdutoBOValid AS ProdutoBO
    PROCEDURE ExporValidar()
        RETURN THIS.ValidarDados()
    ENDPROC
ENDDEFINE
