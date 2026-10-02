*-- Erro184: ida e volta das 4 abas recem-ligadas (Componente, Processo,
*-- Consumo, Designer). Nao grava no banco: prova o Form->BO->Form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodabas4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodabas4.txt"
LOCAL loc_oE, loc_oF, loc_oBO, loc_oCmp, loc_oFas, loc_oCon, loc_oDes, loc_nErros
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

    loc_oF = CREATEOBJECT("FormProdAbas4")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oBO  = loc_oF.this_oBusinessObject
    loc_oCmp = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
    loc_oFas = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
    loc_oCon = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
    loc_oDes = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
    STRTOFILE("C: form OK" + CHR(13) + CHR(10), OUT, 1)

    *-- COMPONENTE
    loc_oCmp.txt_4c_MarkupA.Value   = "2.500"
    loc_oCmp.txt_4c_Pcus.Value      = "11.11111"
    loc_oCmp.txt_4c_Moec.Value      = "USD"
    loc_oCmp.txt_4c_Status.Value    = "ABC"
    loc_oCmp.txt_4c_MatP.Value      = "MATPRINC01"
    loc_oCmp.txt_4c_Margem.Value    = "0.123456"
    loc_oCmp.txt_4c_VarPesoMs.Value = "7.25"
    loc_oCmp.cnt_4c_MtPrima.txt_4c_Compos.Value    = "COMPOSICAO TESTE"
    loc_oCmp.cnt_4c_MtPrima.cbo_4c_CmbMontaDescs.Value = 3
    loc_oCmp.cnt_4c_MtPrima.txt_4c_Casas.Value     = "4"

    *-- PROCESSO
    loc_oFas.txt_4c_Qmin.Value        = "12.500"
    loc_oFas.txt_4c_PesoPdrs.Value    = "1.100"
    loc_oFas.txt_4c_PesoBris.Value    = "2.200"
    loc_oFas.txt_4c_PesoMetal.Value   = "3.300"
    loc_oFas.txt_4c_CodGarras.Value   = "GARRA01"
    loc_oFas.txt_4c_Conquilha.Value   = "CONQ01"
    loc_oFas.txt_4c_Volumes.Value     = "9"
    loc_oFas.txt_4c_TEnts.Value       = "15"
    loc_oFas.txt_4c_DiasGar.Value     = "365"
    loc_oFas.txt_4c_LtMinsV.Value     = "5.500"
    loc_oFas.txt_4c_Vucp.Value        = "99.99"
    loc_oFas.txt_4c_Mucp.Value        = "BRL"
    loc_oFas.txt_4c_DtUcp.Value       = "15/03/2026"
    loc_oFas.chk_4c_Fwoption1.Value   = 1
    loc_oFas.chk_4c_OpcCravCera.Value = 2
    loc_oFas.obj_4c_Fwoption2.Value   = 1

    *-- CONSUMO e DESIGNER
    loc_oCon.txt_4c_Qtcpnt.Value       = "42"
    loc_oCon.chk_4c_ChkFund.Value      = 1
    loc_oDes.obj_4c_GetObsInsp.Value   = "OBSERVACAO DE INSPECAO TESTE"

    IF !loc_oF.ExporFormParaBO()
        STRTOFILE("D: FormParaBO FALHOU" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        STRTOFILE("D: FormParaBO OK" + CHR(13) + CHR(10), OUT, 1)
        loc_nErros = 0
        loc_nErros = loc_nErros + Chk("markupa",   TRANSFORM(loc_oBO.this_nMarkupa),   "2.500")
        loc_nErros = loc_nErros + Chk("pcuss",     TRANSFORM(loc_oBO.this_nPcuss),     "11.11111")
        loc_nErros = loc_nErros + Chk("moecs",     ALLTRIM(loc_oBO.this_cMoecs),       "USD")
        loc_nErros = loc_nErros + Chk("status",    ALLTRIM(loc_oBO.this_cStatus),      "ABC")
        loc_nErros = loc_nErros + Chk("matprincs", ALLTRIM(loc_oBO.this_cMatprincs),   "MATPRINC01")
        loc_nErros = loc_nErros + Chk("margems",   TRANSFORM(loc_oBO.this_nMargems),   "0.123456")
        loc_nErros = loc_nErros + Chk("varpesoms", TRANSFORM(loc_oBO.this_nVarpesoms), "7.25")
        loc_nErros = loc_nErros + Chk("compos",    ALLTRIM(loc_oBO.this_cCompos),      "COMPOSICAO TESTE")
        loc_nErros = loc_nErros + Chk("montadescs",TRANSFORM(loc_oBO.this_nMontadescs),"3")
        loc_nErros = loc_nErros + Chk("casas",     TRANSFORM(loc_oBO.this_nCasas),     "4")
        loc_nErros = loc_nErros + Chk("qtminfabs", TRANSFORM(loc_oBO.this_nQtminfabs), "12.500")
        loc_nErros = loc_nErros + Chk("pesopdrs",  TRANSFORM(loc_oBO.this_nPesopdrs),  "1.100")
        loc_nErros = loc_nErros + Chk("pesobris",  TRANSFORM(loc_oBO.this_nPesobris),  "2.200")
        loc_nErros = loc_nErros + Chk("pesometal", TRANSFORM(loc_oBO.this_nPesometal), "3.300")
        loc_nErros = loc_nErros + Chk("codgarras", ALLTRIM(loc_oBO.this_cCodgarras),   "GARRA01")
        loc_nErros = loc_nErros + Chk("conquilhas",ALLTRIM(loc_oBO.this_cConquilhas),  "CONQ01")
        loc_nErros = loc_nErros + Chk("volumes",   TRANSFORM(loc_oBO.this_nVolumes),   "9")
        loc_nErros = loc_nErros + Chk("tents",     TRANSFORM(loc_oBO.this_nTents),     "15")
        loc_nErros = loc_nErros + Chk("diasgar",   TRANSFORM(loc_oBO.this_nDiasgar),   "365")
        loc_nErros = loc_nErros + Chk("ltminsv",   TRANSFORM(loc_oBO.this_nLtminsv),   "5.500")
        loc_nErros = loc_nErros + Chk("vultcomps", TRANSFORM(loc_oBO.this_nVultcomps), "99.99")
        loc_nErros = loc_nErros + Chk("multcomps", ALLTRIM(loc_oBO.this_cMultcomps),   "BRL")
        loc_nErros = loc_nErros + Chk("ultcomps",  DTOC(ConverterParaData(loc_oBO.this_dUltcomps)), "15/03/2026")
        loc_nErros = loc_nErros + Chk("varias",    TRANSFORM(loc_oBO.this_nVarias),    "1")
        loc_nErros = loc_nErros + Chk("cravcers",  TRANSFORM(loc_oBO.this_nCravcers),  "2")
        loc_nErros = loc_nErros + Chk("prodvars",  TRANSFORM(loc_oBO.this_nProdvars),  "1")
        loc_nErros = loc_nErros + Chk("qtdcpnts",  TRANSFORM(loc_oBO.this_nQtdcpnts),  "42")
        loc_nErros = loc_nErros + Chk("chkfunds",  TRANSFORM(loc_oBO.this_lChkfunds),  ".T.")
        loc_nErros = loc_nErros + Chk("obsinsp",   ALLTRIM(loc_oBO.this_mObsinsp),     "OBSERVACAO DE INSPECAO TESTE")
        STRTOFILE("E: divergencias no Form->BO = " + TRANSFORM(loc_nErros) + CHR(13) + CHR(10), OUT, 1)

        *-- agora a VOLTA: zera a tela, roda BOParaForm e confere
        loc_oF.ExporLimpar()
        STRTOFILE("F: apos LimparCampos -> markupA=[" + ;
            ALLTRIM(loc_oCmp.txt_4c_MarkupA.Value) + "] codgarras=[" + ;
            ALLTRIM(loc_oFas.txt_4c_CodGarras.Value) + "] chkfund=" + ;
            TRANSFORM(loc_oCon.chk_4c_ChkFund.Value) + "  (tem de estar tudo vazio/0)" + ;
            CHR(13) + CHR(10), OUT, 1)

        loc_oF.ExporBOParaForm()
        STRTOFILE("G: apos BOParaForm -> markupA=[" + ALLTRIM(loc_oCmp.txt_4c_MarkupA.Value) + ;
            "] moecs=[" + ALLTRIM(loc_oCmp.txt_4c_Moec.Value) + ;
            "] combo=[" + TRANSFORM(loc_oCmp.cnt_4c_MtPrima.cbo_4c_CmbMontaDescs.Value) + ;
            "] codgarras=[" + ALLTRIM(loc_oFas.txt_4c_CodGarras.Value) + ;
            "] dtucp=[" + ALLTRIM(loc_oFas.txt_4c_DtUcp.Value) + ;
            "] cravcers=" + TRANSFORM(loc_oFas.chk_4c_OpcCravCera.Value) + ;
            " qtcpnt=[" + ALLTRIM(loc_oCon.txt_4c_Qtcpnt.Value) + ;
            "] chkfund=" + TRANSFORM(loc_oCon.chk_4c_ChkFund.Value) + ;
            " obsinsp=[" + ALLTRIM(loc_oDes.obj_4c_GetObsInsp.Value) + "]" + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDIF
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
    IF loc_nErro > 0
        STRTOFILE("   *** " + PADR(par_cNome, 12) + " obtido=[" + ALLTRIM(par_cObtido) + ;
            "] esperado=[" + ALLTRIM(par_cEsperado) + "]" + CHR(13) + CHR(10), ;
            "C:\4c\automation\probe_prodabas4.txt", 1)
    ENDIF
    RETURN loc_nErro
ENDFUNC

DEFINE CLASS FormProdAbas4 AS FormProduto
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
