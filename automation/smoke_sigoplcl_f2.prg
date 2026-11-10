SET SAFETY OFF
SET RESOURCE OFF
SET DATE TO DMY
SET CENTURY ON
SET DELETED ON
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC go_4c_Sistema, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\smoke_sigoplcl_f2_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gb_4c_ValidandoUI      = .T.
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "Sys2015Tmp", "4c_tmp_")

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes")
SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpLclBO.prg" ADDITIVE

LOCAL loc_cOut, loc_oBO, loc_nQtd, loc_cXML, loc_lOk, loc_cXMLStr, loc_cXMLStr2
loc_cOut = ""

*-- Cursor do form CHAMADOR (contrato externo: nome do legado)
CREATE CURSOR crTpmMvItn (cItens N(10,0), Cpros C(14), Dpros C(65), ;
                          Locals C(10), Localos C(10))
INSERT INTO crTpmMvItn VALUES (1, "PROD001", "PRODUTO UM",   "", "")
INSERT INTO crTpmMvItn VALUES (2, "PROD002", "PRODUTO DOIS", "", "")
INSERT INTO crTpmMvItn VALUES (3, "PROD003", "PRODUTO TRES", "", "")
INSERT INTO crTpmMvItn VALUES (4, "",        "SEM PRODUTO",  "", "")

TRY
    loc_oBO = CREATEOBJECT("SigOpLclBO")
    loc_cOut = loc_cOut + "1) CREATEOBJECT SigOpLclBO -> " + VARTYPE(loc_oBO) + CHR(13) + CHR(10)

    loc_oBO.this_cEscolha = "INSERIR"
    loc_oBO.this_cOrigem  = ""

    loc_cOut = loc_cOut + "2) CriarCursorLocalizacoes -> " + ;
        TRANSFORM(loc_oBO.CriarCursorLocalizacoes()) + CHR(13) + CHR(10)

    loc_lOk = loc_oBO.CarregarItens("")
    loc_cOut = loc_cOut + "3) CarregarItens -> " + TRANSFORM(loc_lOk) + "  itens visiveis="
    SELECT cursor_4c_Itens
    COUNT TO loc_nQtd
    loc_cOut = loc_cOut + TRANSFORM(loc_nQtd) + " (esperado 3: item 4 tem Cpros vazio)" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "   TAGs: cItens=" + TRANSFORM(TAGNO("cItens","","cursor_4c_Itens")) + ;
        " Cpros=" + TRANSFORM(TAGNO("Cpros","","cursor_4c_Itens")) + ;
        " Categoria=" + TRANSFORM(TAGNO("Categoria","","cursor_4c_Itens")) + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "4) OrdenarItens 1 Cpros -> " + TRANSFORM(loc_oBO.OrdenarItens(1)) + ;
        "  ORDER=" + ORDER("cursor_4c_Itens") + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "   OrdenarItens 2 Categoria -> " + TRANSFORM(loc_oBO.OrdenarItens(2)) + ;
        "  ORDER=" + ORDER("cursor_4c_Itens") + CHR(13) + CHR(10)

    SELECT cursor_4c_Itens
    SET ORDER TO TAG cItens
    GO TOP
    loc_cOut = loc_cOut + "5) CarregarDoCursor default -> " + TRANSFORM(loc_oBO.CarregarDoCursor()) + ;
        "  cItens=" + TRANSFORM(loc_oBO.this_nCItens) + ;
        "  Cpros=[" + loc_oBO.this_cCpros + "]" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "   CarregarDoCursor crTpmMvItn -> " + ;
        TRANSFORM(loc_oBO.CarregarDoCursor("crTpmMvItn")) + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "6) MarcarTodosItens 1 -> " + TRANSFORM(loc_oBO.MarcarTodosItens(1)) + ;
        "  selecionados=" + TRANSFORM(loc_oBO.ContarItensSelecionados()) + ;
        "  temSel=" + TRANSFORM(loc_oBO.this_lTemItensSelecionados) + CHR(13) + CHR(10)
    loc_lOk = loc_oBO.MarcarTodosItens(0)
    loc_cOut = loc_cOut + "   MarcarTodosItens 0 -> " + TRANSFORM(loc_lOk) + ;
        "  selecionados=" + TRANSFORM(loc_oBO.ContarItensSelecionados()) + CHR(13) + CHR(10)

    SELECT cursor_4c_Itens
    GO TOP
    loc_cOut = loc_cOut + "7) AlternarMarcaItem -> " + TRANSFORM(loc_oBO.AlternarMarcaItem()) + ;
        "  selecionados=" + TRANSFORM(loc_oBO.ContarItensSelecionados()) + CHR(13) + CHR(10)

    loc_oBO.this_cBase = ""
    loc_cOut = loc_cOut + "8) ValidarNiveis sem Base -> " + ;
        TRANSFORM(loc_oBO.ValidarNiveis(.F.)) + "  msg=[" + ;
        ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10)

    loc_oBO.this_cBase = "01"
    loc_oBO.this_cNvl2 = "02"
    loc_oBO.this_cNvl3 = "03"
    loc_oBO.this_cNvl4 = "0004"
    loc_cOut = loc_cOut + "9) ValidarNiveis com Base -> " + ;
        TRANSFORM(loc_oBO.ValidarNiveis(.F.)) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "   MontarLocalizacao -> [" + loc_oBO.MontarLocalizacao() + ;
        "] len=" + TRANSFORM(LEN(loc_oBO.MontarLocalizacao())) + " esperado 10" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "10) Inserir -> " + TRANSFORM(loc_oBO.Inserir()) + ;
        "  gravados=" + TRANSFORM(loc_oBO.this_nItensGravados) + CHR(13) + CHR(10)
    SELECT cursor_4c_Locais
    loc_cOut = loc_cOut + "    cursor_4c_Locais regs=" + TRANSFORM(RECCOUNT("cursor_4c_Locais"))
    GO TOP
    loc_cOut = loc_cOut + "  1a linha cItens=" + TRANSFORM(cursor_4c_Locais.cItens) + ;
        " Locals=[" + cursor_4c_Locais.Locals + "]" + CHR(13) + CHR(10)
    SELECT cursor_4c_Itens
    COUNT TO loc_nQtd
    loc_cOut = loc_cOut + "    itens restantes na grade=" + TRANSFORM(loc_nQtd) + " esperado 2" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "    niveis limpos? Base=[" + ALLTRIM(loc_oBO.this_cBase) + "]" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "11) Atualizar -> " + TRANSFORM(loc_oBO.Atualizar()) + ;
        "  confirmados=" + TRANSFORM(loc_oBO.this_nItensConfirmados) + CHR(13) + CHR(10)
    SELECT crTpmMvItn
    LOCATE FOR cItens = 1
    loc_cOut = loc_cOut + "    crTpmMvItn item1 Locals=[" + crTpmMvItn.Locals + ;
        "] Localos=[" + crTpmMvItn.Localos + "]" + CHR(13) + CHR(10)

    loc_oBO.this_cOrigem = "ORIGEM"
    loc_cOut = loc_cOut + "12) Atualizar ramo ORIGEM -> " + TRANSFORM(loc_oBO.Atualizar()) + ;
        "  confirmados=" + TRANSFORM(loc_oBO.this_nItensConfirmados) + CHR(13) + CHR(10)
    SELECT crTpmMvItn
    LOCATE FOR cItens = 1
    loc_cOut = loc_cOut + "    crTpmMvItn item1 Localos=[" + crTpmMvItn.Localos + "]" + CHR(13) + CHR(10)

    *-- ReverterXML + wrapper fXmlToCursor
    *-- Caso REAL de producao: XML COM schema XSD embutido
    CREATE CURSOR cursor_4c_Nivel1 (cidchaves C(20), cods C(2), descs C(20))
    INSERT INTO cursor_4c_Nivel1 VALUES ("CH-N1-01", "01", "BASE UM")
    CREATE CURSOR cNvAux (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
    INSERT INTO cNvAux VALUES ("CH-N1-01", "01", "BASE UM", 1, "")
    INSERT INTO cNvAux VALUES ("CH-N1-09", "09", "BASE NOVE", 0, "")
    = CURSORTOXML("cNvAux", "loc_cXMLStr", 1, 0, 0, "VFPSchema")
    loc_cXML = loc_cXMLStr

    CREATE CURSOR cursor_4c_Nivel2 (cidchaves C(20), cods C(2), descs C(20), nivel M)
    INSERT INTO cursor_4c_Nivel2 (cidchaves, cods, descs) VALUES ("CH-N2-02", "02", "NIVEL DOIS")
    REPLACE nivel WITH loc_cXML IN cursor_4c_Nivel2
    SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel2 WHERE 1 = 0 ;
        INTO CURSOR cursor_4c_LcNv2 READWRITE

    loc_cOut = loc_cOut + "13) ReverterXML XML COM schema -> " + ;
        TRANSFORM(loc_oBO.ReverterXML("cursor_4c_Nivel2", "cursor_4c_Nivel1", "cursor_4c_LcNv2")) + ;
        "  cursor_4c_LcNv2 regs=" + TRANSFORM(RECCOUNT("cursor_4c_LcNv2")) + ;
        " esperado 1 (so o Marcas<>0)" + CHR(13) + CHR(10)
    IF RECCOUNT("cursor_4c_LcNv2") > 0
        SELECT cursor_4c_LcNv2
        GO TOP
        loc_cOut = loc_cOut + "    Cods pai=[" + ALLTRIM(cursor_4c_LcNv2.Cods) + ;
            "] Codigo proprio=[" + ALLTRIM(cursor_4c_LcNv2.Codigo) + ;
            "] Descs=[" + ALLTRIM(cursor_4c_LcNv2.Descs) + "]" + ;
            "  esperado Cods=01 Codigo=02" + CHR(13) + CHR(10)
    ENDIF

    *-- Caso DEGENERADO: XML SEM schema (tipos inferidos errado).
    *-- Nao pode mais abortar a expansao - deve seguir e trazer a linha.
    = CURSORTOXML("cNvAux", "loc_cXMLStr2", 1, 0, 0, "")
    CREATE CURSOR cursor_4c_Nivel3 (cidchaves C(20), cods C(2), descs C(20), nivel M)
    INSERT INTO cursor_4c_Nivel3 (cidchaves, cods, descs) VALUES ("CH-N3-03", "03", "NIVEL TRES")
    REPLACE nivel WITH loc_cXMLStr2 IN cursor_4c_Nivel3
    SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel3 WHERE 1 = 0 ;
        INTO CURSOR cursor_4c_LcNv3 READWRITE

    loc_cOut = loc_cOut + "13b) ReverterXML XML SEM schema -> " + ;
        TRANSFORM(loc_oBO.ReverterXML("cursor_4c_Nivel3", "cursor_4c_Nivel2", "cursor_4c_LcNv3")) + ;
        "  cursor_4c_LcNv3 regs=" + TRANSFORM(RECCOUNT("cursor_4c_LcNv3")) + ;
        " nao deve abortar" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "14) CarregarNivelFiltrado LcNv2 / 01 -> " + ;
        TRANSFORM(loc_oBO.CarregarNivelFiltrado("cursor_4c_LcNv2", "01")) + " linha(s)" + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "15) BuscarFotoProduto sem conexao -> [" + ;
        loc_oBO.BuscarFotoProduto("PROD001") + "] esperado vazio" + CHR(13) + CHR(10)

    loc_oBO.this_cEscolha = "PROCURAR"
    loc_cOut = loc_cOut + "16) Inserir em modo PROCURAR -> " + TRANSFORM(loc_oBO.Inserir()) + ;
        "  msg=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "] esperado .F." + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "17) LimparDados -> " + TRANSFORM(loc_oBO.LimparDados()) + CHR(13) + CHR(10)

    loc_oBO = .NULL.
    loc_cOut = loc_cOut + "18) Destroy; cursor_4c_Itens aberto? " + ;
        TRANSFORM(USED("cursor_4c_Itens")) + " esperado .F." + CHR(13) + CHR(10)

CATCH TO loc_oErro
    loc_cOut = loc_cOut + "*** EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\smoke_sigoplcl_f2.txt")
QUIT
