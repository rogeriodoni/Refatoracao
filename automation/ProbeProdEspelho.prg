*-- Erro187: seis colunas tem DOIS controles (ControlSource compartilhado no
*-- legado). Preencher pela aba Componente tem de chegar ao BO.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodespelho.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodespelho.txt"
LOCAL loc_oE, loc_oF, loc_oBO, loc_oPri, loc_oFis, loc_oCmp, loc_nErros, loc_cMoe
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

    loc_oF = CREATEOBJECT("FormProdEspelho")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oBO  = loc_oF.this_oBusinessObject
    loc_oPri = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    loc_oCmp = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
    loc_oFis = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
    STRTOFILE("C: form OK" + CHR(13) + CHR(10), OUT, 1)

    *-- uma moeda REAL
    loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 cmoes FROM SigCdMoe ORDER BY cmoes", "crM")
    loc_cMoe = IIF(loc_n > 0 AND RECCOUNT("crM") > 0, ALLTRIM(crM.cmoes), "R$")
    STRTOFILE("D: moeda real = [" + loc_cMoe + "]" + CHR(13) + CHR(10), OUT, 1)

    loc_nErros = 0

    *-- CENARIO DO PRINT: o usuario preenche SO pela aba Componente
    loc_oCmp.txt_4c_Custof.Value  = "123.456"
    loc_oCmp.txt_4c_Moecusf.Value = loc_cMoe
    loc_oCmp.txt_4c_Pven.Value    = "99.99999"
    loc_oCmp.txt_4c_Moev.Value    = loc_cMoe
    loc_oCmp.txt_4c_Moepv.Value   = loc_cMoe
    loc_oCmp.txt_4c_Moeda.Value   = loc_cMoe
    *-- e deixa os gemeos das outras abas VAZIOS, como no print
    loc_oPri.txt_4c_Ctotal.Value  = ""
    loc_oPri.txt_4c_Mctotal.Value = ""
    loc_oPri.txt_4c_Pvenda.Value  = ""
    loc_oPri.txt_4c_Mpvenda.Value = ""
    loc_oPri.txt_4c_Mfvenda.Value = ""
    loc_oFis.txt_4c_Mvalor.Value  = ""

    loc_oF.ExporFormParaBO()
    STRTOFILE(CHR(13) + CHR(10) + "=== preenchido SO pela aba Componente ===" + ;
        CHR(13) + CHR(10), OUT, 1)
    loc_nErros = loc_nErros + Chk("custofs",  TRANSFORM(loc_oBO.this_nCustofs),  "123.456")
    loc_nErros = loc_nErros + Chk("moecusfs", ALLTRIM(loc_oBO.this_cMoecusfs),   loc_cMoe)
    loc_nErros = loc_nErros + Chk("pvens",    TRANSFORM(loc_oBO.this_nPvens),    "99.99999")
    loc_nErros = loc_nErros + Chk("moevs",    ALLTRIM(loc_oBO.this_cMoevs),      loc_cMoe)
    loc_nErros = loc_nErros + Chk("moepvs",   ALLTRIM(loc_oBO.this_cMoepvs),     loc_cMoe)
    loc_nErros = loc_nErros + Chk("moedas",   ALLTRIM(loc_oBO.this_cMoedas),     loc_cMoe)

    *-- CAMINHO INVERSO: preencher so pelas abas Principal/Fiscal
    loc_oF.ExporLimpar()
    loc_oPri.txt_4c_Ctotal.Value  = "7.777"
    loc_oPri.txt_4c_Mctotal.Value = loc_cMoe
    loc_oFis.txt_4c_Mvalor.Value  = loc_cMoe
    loc_oF.ExporFormParaBO()
    STRTOFILE(CHR(13) + CHR(10) + "=== preenchido SO pelas abas Principal/Fiscal ===" + ;
        CHR(13) + CHR(10), OUT, 1)
    loc_nErros = loc_nErros + Chk("custofs",  TRANSFORM(loc_oBO.this_nCustofs), "7.777")
    loc_nErros = loc_nErros + Chk("moecusfs", ALLTRIM(loc_oBO.this_cMoecusfs),  loc_cMoe)
    loc_nErros = loc_nErros + Chk("moedas",   ALLTRIM(loc_oBO.this_cMoedas),    loc_cMoe)

    *-- BOParaForm tem de escrever nos DOIS lados
    loc_oF.ExporLimpar()
    loc_oF.ExporBOParaForm()
    STRTOFILE(CHR(13) + CHR(10) + "=== BOParaForm escreve nos DOIS lados ===" + ;
        CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   Principal Mctotal=[" + ALLTRIM(loc_oPri.txt_4c_Mctotal.Value) + "]" + ;
        "  Componente Moecusf=[" + ALLTRIM(loc_oCmp.txt_4c_Moecusf.Value) + "]" + ;
        IIF(ALLTRIM(loc_oPri.txt_4c_Mctotal.Value) == ALLTRIM(loc_oCmp.txt_4c_Moecusf.Value), ;
            "  OK (iguais)", "  *** DIVERGEM") + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   Fiscal Mvalor=[" + ALLTRIM(loc_oFis.txt_4c_Mvalor.Value) + "]" + ;
        "  Componente Moeda=[" + ALLTRIM(loc_oCmp.txt_4c_Moeda.Value) + "]" + ;
        IIF(ALLTRIM(loc_oFis.txt_4c_Mvalor.Value) == ALLTRIM(loc_oCmp.txt_4c_Moeda.Value), ;
            "  OK (iguais)", "  *** DIVERGEM") + CHR(13) + CHR(10), OUT, 1)

    *-- LimparCampos tem de zerar os gemeos tambem
    loc_oCmp.txt_4c_Moecusf.Value = "XXX"
    loc_oF.ExporLimpar()
    STRTOFILE(CHR(13) + CHR(10) + "=== LimparCampos zera o gemeo ===" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   Componente Moecusf=[" + ALLTRIM(loc_oCmp.txt_4c_Moecusf.Value) + "]" + ;
        IIF(EMPTY(loc_oCmp.txt_4c_Moecusf.Value), "  OK", "  *** NAO LIMPOU") + ;
        CHR(13) + CHR(10), OUT, 1)

    STRTOFILE(CHR(13) + CHR(10) + "TOTAL DE DIVERGENCIAS = " + TRANSFORM(loc_nErros) + ;
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

FUNCTION Chk(par_cNome, par_cObtido, par_cEsperado)
    LOCAL loc_nErro
    loc_nErro = IIF(ALLTRIM(par_cObtido) == ALLTRIM(par_cEsperado), 0, 1)
    STRTOFILE("   " + PADR(par_cNome, 10) + " obtido=[" + ALLTRIM(par_cObtido) + ;
        "] esperado=[" + ALLTRIM(par_cEsperado) + "]" + ;
        IIF(loc_nErro = 0, "  OK", "  *** DIVERGE") + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_prodespelho.txt", 1)
    RETURN loc_nErro
ENDFUNC

DEFINE CLASS FormProdEspelho AS FormProduto
    PROCEDURE ExporFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ExporBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ExporLimpar()
        THIS.LimparCampos()
    ENDPROC
ENDDEFINE
