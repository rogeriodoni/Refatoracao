*-- Erro184: a aba Fiscal tem de chegar ao BO. O sintoma era a validacao
*-- "A Classificacao Fiscal Necessita Ser Preenchida" com o campo preenchido.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodfiscal.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodfiscal.txt"
LOCAL loc_oE, loc_oF, loc_oBO, loc_oFis, loc_oPrin, loc_oVal, loc_n, loc_cGru, loc_lOk
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

    loc_oF = CREATEOBJECT("FormProdutoTesteFis")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oBO  = loc_oF.this_oBusinessObject
    loc_oFis = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
    STRTOFILE("C: form OK" + CHR(13) + CHR(10), OUT, 1)

    *-- um grupo que EXIJA a classificacao fiscal (obrigfiscs = 1)
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cgrus FROM SigCdGrp WHERE obrigfiscs = 1 ORDER BY cgrus", "crGF")
    loc_cGru = IIF(loc_n > 0 AND RECCOUNT("crGF") > 0, ALLTRIM(crGF.cgrus), "")
    STRTOFILE("D: grupo com obrigfiscs=1 -> [" + loc_cGru + "]" + CHR(13) + CHR(10), OUT, 1)

    IF EMPTY(loc_cGru)
        STRTOFILE("   nenhum grupo exige classificacao fiscal - teste do bind apenas" + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDIF

    *-- preenche a tela como o usuario fez no print
    loc_oF.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Cgru.Value = loc_cGru
    loc_oF.BtnIncluirClick()
    loc_oPrin = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    loc_oPrin.txt_4c_Cpro.Value = "E184TESTE"
    loc_oPrin.txt_4c_Dpro.Value = "PRODUTO DE TESTE ERRO184"
    loc_oFis.txt_4c_Clfiscal.Value = "39232190"
    loc_oFis.txt_4c_Icms.Value     = "18.00"
    loc_oFis.txt_4c_Iat.Value      = "A"
    loc_oFis.txt_4c_Extipi.Value   = "99"

    STRTOFILE("E: BO ANTES do FormParaBO: clfiscals=[" + ;
        ALLTRIM(loc_oBO.this_cClfiscals) + "] icms=" + ;
        TRANSFORM(loc_oBO.this_nIcms) + " iats=[" + ALLTRIM(loc_oBO.this_cIats) + ;
        "]" + CHR(13) + CHR(10), OUT, 1)

    loc_oF.ExporFormParaBO()
    STRTOFILE("F: BO DEPOIS: clfiscals=[" + ALLTRIM(loc_oBO.this_cClfiscals) + "]" + ;
        IIF(ALLTRIM(loc_oBO.this_cClfiscals) == "39232190", " OK", " *** DIVERGE") + ;
        "  icms=[" + TRANSFORM(loc_oBO.this_nIcms) + "] iats=[" + ;
        ALLTRIM(loc_oBO.this_cIats) + "] extipi=[" + ALLTRIM(loc_oBO.this_cExtipi) + "]" + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- a validacao que disparava a mensagem do print. ValidarDados eh
    *-- PROTECTED no BO: um BO de teste espelha as properties e expoe o metodo.
    loc_oVal = CREATEOBJECT("ProdutoBOTeste")
    loc_oVal.this_cCgrus     = loc_oBO.this_cCgrus
    loc_oVal.this_cCpros     = loc_oBO.this_cCpros
    loc_oVal.this_cDpros     = loc_oBO.this_cDpros
    loc_oVal.this_cClfiscals = loc_oBO.this_cClfiscals
    *-- Erro186 acrescentou regras ANTERIORES a fiscal; preenche o minimo
    *-- para que o teste continue isolando a Classificacao Fiscal
    loc_oVal.this_cCunis  = "PC"
    loc_oVal.this_nSituas = 1
    loc_oVal.this_cMoecs  = "R$"
    loc_lOk = loc_oVal.ExporValidar()
    STRTOFILE("G: COM classificacao -> Validar=" + TRANSFORM(loc_lOk) + ;
        "  msg=[" + ALLTRIM(loc_oVal.this_cMensagemErro) + "]" + ;
        IIF("Classifica" $ loc_oVal.this_cMensagemErro AND ;
            "Fiscal" $ loc_oVal.this_cMensagemErro, "  *** AINDA ACUSA", "  OK") + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- e agora com a classificacao VAZIA: a mensagem TEM de voltar
    loc_oFis.txt_4c_Clfiscal.Value = ""
    loc_oF.ExporFormParaBO()
    loc_oVal.this_cClfiscals = loc_oBO.this_cClfiscals
    loc_oVal.this_cMensagemErro = ""
    loc_lOk = loc_oVal.ExporValidar()
    STRTOFILE("H: SEM classificacao -> Validar=" + TRANSFORM(loc_lOk) + ;
        "  msg=[" + ALLTRIM(loc_oVal.this_cMensagemErro) + "]" + ;
        IIF("Classifica" $ loc_oVal.this_cMensagemErro AND ;
            "Fiscal" $ loc_oVal.this_cMensagemErro, "  OK (acusa, como deve)", ;
            "  *** DEIXOU PASSAR") + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

DEFINE CLASS FormProdutoTesteFis AS FormProduto
    PROCEDURE ExporFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ExporValidar()
        RETURN THIS.this_oBusinessObject.ValidarDados()
    ENDPROC
ENDDEFINE

DEFINE CLASS ProdutoBOTeste AS ProdutoBO
    PROCEDURE ExporValidar()
        RETURN THIS.ValidarDados()
    ENDPROC
ENDDEFINE
