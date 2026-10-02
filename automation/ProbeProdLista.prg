*-- Erro182: grade da Lista do Cadastro de Produtos ao escolher o Grupo.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodlista.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodlista.txt"
LOCAL loc_oE, loc_oForm, loc_nR, loc_cGru, loc_oFil
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
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
    STRTOFILE("C: deps OK" + CHR(13)+CHR(10), OUT, 1)

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("D: conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    loc_oForm = CREATEOBJECT("FormProduto")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("E: NAO INSTANCIOU" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("E: Init OK" + CHR(13)+CHR(10), OUT, 1)
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE(Dump(loc_oForm, "01-apos-Init"), OUT, 1)

        *-- grupo REAL com mais produtos, dentro do periodo default 01/01/1900..31/12/2900
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 cgrus, COUNT(*) AS qtd FROM SigCdPro GROUP BY cgrus " + ;
            "ORDER BY COUNT(*) DESC", "crTopGru")
        loc_cGru = ""
        IF loc_nR > 0 AND RECCOUNT("crTopGru") > 0
            loc_cGru = ALLTRIM(crTopGru.cgrus)
            STRTOFILE("   grupo com mais produtos = [" + loc_cGru + "] qtd=" + ;
                      TRANSFORM(crTopGru.qtd) + CHR(13)+CHR(10), OUT, 1)
        ENDIF

        loc_oFil = loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        STRTOFILE("   DtIni=[" + TRANSFORM(loc_oFil.txt_4c_DtIni.Value) + "] DtFim=[" + ;
            TRANSFORM(loc_oFil.txt_4c_DtFim.Value) + "] Situas=" + ;
            TRANSFORM(loc_oFil.opt_4c_FilSituas.Value) + CHR(13)+CHR(10), OUT, 1)

        *-- simula o usuario DIGITANDO o grupo e saindo do campo (LostFocus)
        loc_oFil.txt_4c_Cgru.Value = loc_cGru
        loc_oForm.ValidarGrupoFiltro()
        STRTOFILE(Dump(loc_oForm, "02-apos-ValidarGrupoFiltro (escolha do grupo)"), OUT, 1)

        *-- segunda escolha de grupo (o 2o carregamento era onde quebrava)
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 cgrus FROM (SELECT cgrus, COUNT(*) q FROM SigCdPro " + ;
            "GROUP BY cgrus) t WHERE cgrus <> " + EscaparSQL(PADR(loc_cGru,3)) + ;
            " ORDER BY q DESC", "crGru2")
        IF loc_nR > 0 AND RECCOUNT("crGru2") > 0
            loc_oFil.txt_4c_Cgru.Value = ALLTRIM(crGru2.cgrus)
            loc_oForm.ValidarGrupoFiltro()
            STRTOFILE(Dump(loc_oForm, "03-apos-SEGUNDA-escolha [" + ALLTRIM(crGru2.cgrus) + "]"), OUT, 1)
        ENDIF

        *-- terceira: volta ao primeiro grupo
        loc_oFil.txt_4c_Cgru.Value = loc_cGru
        loc_oForm.ValidarGrupoFiltro()
        STRTOFILE(Dump(loc_oForm, "04-apos-TERCEIRA-escolha (volta ao 1o)"), OUT, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

FUNCTION Dump(par_oForm, par_cTag)
    LOCAL loc_c, loc_oG, loc_oE3, loc_nI
    loc_c = CHR(13)+CHR(10) + "=== " + par_cTag + CHR(13)+CHR(10)
    TRY
        loc_c = loc_c + "  USED=" + TRANSFORM(USED("cursor_4c_Dados"))
        IF USED("cursor_4c_Dados")
            loc_c = loc_c + "  RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
                    "  FCOUNT=" + TRANSFORM(FCOUNT("cursor_4c_Dados"))
        ENDIF
        loc_c = loc_c + CHR(13)+CHR(10)
        loc_oG = par_oForm.pgf_4c_Paginas.Page1.grd_4c_Dados
        loc_c = loc_c + "  Grid RecordSource=[" + loc_oG.RecordSource + "]" + ;
                "  ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + CHR(13)+CHR(10)
        FOR loc_nI = 1 TO loc_oG.ColumnCount
            loc_c = loc_c + "  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".ControlSource") + "]" + ;
                " W=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Width")) + ;
                " Cap=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + "]" + ;
                " CC=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".CurrentControl") + "]" + ;
                CHR(13)+CHR(10)
        ENDFOR
        loc_c = loc_c + "  lblProdutos=[" + ;
            par_oForm.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption + "]" + CHR(13)+CHR(10)
    CATCH TO loc_oE3
        loc_c = loc_c + "  DUMP-ERRO: " + loc_oE3.Message + CHR(13)+CHR(10)
    ENDTRY
    RETURN loc_c
ENDFUNC
