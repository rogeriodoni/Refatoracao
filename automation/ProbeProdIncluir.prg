*-- Erro184: "Incluir" tem de levar o grupo do filtro da Lista para a ficha.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodincluir.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodincluir.txt"
LOCAL loc_oE, loc_oF, loc_oFil, loc_oPg, loc_cGru, loc_n
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

    loc_oF = CREATEOBJECT("FormProdutoTeste")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oFil = loc_oF.pgf_4c_Paginas.Page1.cnt_4c_Filtros
    loc_oPg  = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    STRTOFILE("C: form OK" + CHR(13) + CHR(10), OUT, 1)

    *-- um grupo REAL
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "crG")
    loc_cGru = IIF(loc_n > 0 AND RECCOUNT("crG") > 0, ALLTRIM(crG.cgrus), "")
    STRTOFILE("D: grupo de teste=[" + loc_cGru + "] desc=[" + ;
        IIF(USED("crG"), ALLTRIM(NVL(crG.dgrus, "")), "") + "]" + CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 1: SEM grupo no filtro -> legado recusa ("Grupo Invalido!!!")
    loc_oFil.txt_4c_Cgru.Value = ""
    loc_oPg.txt_4c_Cgru.Value  = "ZZZ"
    loc_oF.this_cModoAtual     = "LISTA"
    loc_oF.BtnIncluirClick()
    STRTOFILE("E: SEM grupo -> modo=[" + loc_oF.this_cModoAtual + "]" + ;
        " pagina=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  (esperado: modo LISTA, pagina 1)" + CHR(13) + CHR(10), OUT, 1)

    *-- CENARIO 2: COM grupo no filtro -> ficha abre com o Grupo preenchido
    loc_oFil.txt_4c_Cgru.Value = loc_cGru
    loc_oPg.txt_4c_Cgru.Value  = ""
    loc_oPg.txt_4c_Dgru.Value  = ""
    loc_oF.BtnIncluirClick()
    STRTOFILE("F: COM grupo -> modo=[" + loc_oF.this_cModoAtual + "]" + ;
        " pagina=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   ficha: Cgru=[" + ALLTRIM(loc_oPg.txt_4c_Cgru.Value) + "]" + ;
        " Dgru=[" + ALLTRIM(loc_oPg.txt_4c_Dgru.Value) + "]" + ;
        IIF(ALLTRIM(loc_oPg.txt_4c_Cgru.Value) == loc_cGru, "  OK", "  *** DIVERGE") + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- e o grupo tem de chegar ao BO na gravacao
    loc_oF.ExporFormParaBO()
    STRTOFILE("G: BO.this_cCgrus=[" + ;
        ALLTRIM(loc_oF.this_oBusinessObject.this_cCgrus) + "]" + ;
        IIF(ALLTRIM(loc_oF.this_oBusinessObject.this_cCgrus) == loc_cGru, "  OK", "  *** DIVERGE") + ;
        CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   defaults do INSERIR: situas=" + ;
        TRANSFORM(loc_oF.this_oBusinessObject.this_nSituas) + ;
        " consigs=" + TRANSFORM(loc_oF.this_oBusinessObject.this_nConsigs) + ;
        " cravcers=" + TRANSFORM(loc_oF.this_oBusinessObject.this_nCravcers) + ;
        IIF(loc_oF.this_oBusinessObject.this_nSituas = 1 AND ;
            loc_oF.this_oBusinessObject.this_nConsigs = 1, "  OK", "  *** DIVERGE") + ;
        CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("H: unidade default: Cuni=[" + ALLTRIM(loc_oPg.txt_4c_Cuni.Value) + ;
        "] Duni=[" + ALLTRIM(loc_oPg.txt_4c_Duni.Value) + ;
        "] Cunip=[" + ALLTRIM(loc_oPg.txt_4c_Cunip.Value) + "]" + ;
        "  (SigCdGrp.cunips vazio -> cai no SigCdPam.cunis)" + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

*-- subclasse so do teste: PROTECTED eh acessivel dentro da hierarquia
DEFINE CLASS FormProdutoTeste AS FormProduto
    PROCEDURE ExporFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
ENDDEFINE
