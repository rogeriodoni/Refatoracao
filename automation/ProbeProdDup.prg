*-- Erro185: codigo de produto DUPLICADO tem de ser barrado pelo sistema,
*-- nao pelo erro cru de PRIMARY KEY do SQL Server.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_proddup.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_proddup.txt"
LOCAL loc_oE, loc_oF, loc_oBO, loc_oPrin, loc_n, loc_cGru, loc_cExiste, loc_lOk, loc_oVal
STRTOFILE("A: inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ValidandoUI = .F.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "ProdutoBO.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormProduto.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("B: conn=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10), OUT, 1)

    loc_oF = CREATEOBJECT("FormProdDup")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oBO   = loc_oF.this_oBusinessObject
    loc_oPrin = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

    *-- um grupo real e um codigo que JA EXISTE
    loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 cgrus FROM SigCdGrp ORDER BY cgrus", "crG")
    loc_cGru = IIF(loc_n > 0 AND RECCOUNT("crG") > 0, ALLTRIM(crG.cgrus), "")
    loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 cpros FROM SigCdPro ORDER BY cpros", "crP")
    loc_cExiste = IIF(loc_n > 0 AND RECCOUNT("crP") > 0, ALLTRIM(crP.cpros), "")
    STRTOFILE("C: grupo=[" + loc_cGru + "]  codigo JA EXISTENTE=[" + loc_cExiste + "]" + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- ExisteProduto precisa enxergar os dois casos
    STRTOFILE("D: ExisteProduto([" + loc_cExiste + "]) = " + ;
        TRANSFORM(loc_oBO.ExisteProduto(loc_cExiste)) + "  (esperado .T.)" + ;
        CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   ExisteProduto([E185INEDITO]) = " + ;
        TRANSFORM(loc_oBO.ExisteProduto("E185INEDITO")) + "  (esperado .F.)" + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 1: incluir com codigo DUPLICADO -> Salvar tem de RECUSAR
    loc_oF.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Cgru.Value = loc_cGru
    loc_oF.BtnIncluirClick()
    loc_oPrin.txt_4c_Cpro.Value = loc_cExiste
    loc_oPrin.txt_4c_Dpro.Value = "TESTE ERRO185 DUPLICADO"
    loc_oF.ExporFormParaBO()
    loc_lOk = loc_oBO.Salvar()
    STRTOFILE("E: Salvar com codigo duplicado = " + TRANSFORM(loc_lOk) + ;
        "  msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + ;
        IIF(!loc_lOk AND "Cadastrado" $ loc_oBO.this_cMensagemErro, ;
            "  OK (barrado pelo sistema)", "  *** FALHOU") + CHR(13) + CHR(10), OUT, 1)

    *-- o aviso antecipado do campo (LostFocus) tambem tem de disparar
    loc_oF.this_cUltimoCodigoValidado = ""
    loc_oF.ValidarCodigoProdutoDados()
    STRTOFILE("F: aviso no LostFocus com codigo duplicado -> ver DIALOGOS abaixo" + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 2 e 3 usam um BO de teste que expoe o ValidarDados (PROTECTED).
    *-- NAO podem chamar Salvar(): isso GRAVARIA no banco de producao.
    loc_oVal = CREATEOBJECT("ProdutoBODup")
    loc_oVal.this_cCgrus = loc_oBO.this_cCgrus
    *-- preenche o que as regras do Erro186 passaram a exigir, para que o
    *-- teste isole a regra do CODIGO duplicado
    loc_oVal.this_cDpros  = "TESTE ERRO185"
    loc_oVal.this_cCunis  = "PC"
    loc_oVal.this_nSituas = 1

    *-- CENARIO 2: codigo INEDITO em registro NOVO -> nao pode barrar pelo codigo
    loc_oVal.this_cCpros        = "E185INEDITO"
    loc_oVal.this_lNovoRegistro = .T.
    loc_oVal.this_cMensagemErro = ""
    loc_lOk = loc_oVal.ExporValidar()
    STRTOFILE("G: ValidarDados, NOVO com codigo inedito = " + TRANSFORM(loc_lOk) + ;
        "  msg=[" + ALLTRIM(loc_oVal.this_cMensagemErro) + "]" + ;
        IIF("Cadastrado" $ loc_oVal.this_cMensagemErro, ;
            "  *** BARROU INDEVIDAMENTE", "  OK (nao barra pelo codigo)") + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 3: ALTERAR um produto existente NAO pode ser barrado
    loc_oVal.this_cCpros        = loc_cExiste
    loc_oVal.this_lNovoRegistro = .F.
    loc_oVal.this_cMensagemErro = ""
    loc_lOk = loc_oVal.ExporValidar()
    STRTOFILE("H: ValidarDados, ALTERAR do [" + loc_cExiste + "] = " + ;
        TRANSFORM(loc_lOk) + "  msg=[" + ALLTRIM(loc_oVal.this_cMensagemErro) + "]" + ;
        IIF("Cadastrado" $ loc_oVal.this_cMensagemErro, ;
            "  *** BARROU A ALTERACAO", "  OK (alteracao livre)") + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 4: mesmo codigo existente, mas marcado como NOVO -> barra
    loc_oVal.this_lNovoRegistro = .T.
    loc_oVal.this_cMensagemErro = ""
    loc_lOk = loc_oVal.ExporValidar()
    STRTOFILE("J: ValidarDados, NOVO com codigo [" + loc_cExiste + "] = " + ;
        TRANSFORM(loc_lOk) + "  msg=[" + ALLTRIM(loc_oVal.this_cMensagemErro) + "]" + ;
        IIF(!loc_lOk AND "Cadastrado" $ loc_oVal.this_cMensagemErro, ;
            "  OK (barra)", "  *** DEIXOU PASSAR") + CHR(13) + CHR(10), OUT, 1)

    *-- garantia: nada foi gravado
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE cpros = 'E185INEDITO'", "crV")
    STRTOFILE("I: linhas gravadas com E185INEDITO = " + ;
        TRANSFORM(IIF(USED("crV"), crV.qtd, -1)) + "  (esperado 0)" + ;
        CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

DEFINE CLASS FormProdDup AS FormProduto
    PROCEDURE ExporFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
ENDDEFINE

DEFINE CLASS ProdutoBODup AS ProdutoBO
    PROCEDURE ExporValidar()
        RETURN THIS.ValidarDados()
    ENDPROC
ENDDEFINE
