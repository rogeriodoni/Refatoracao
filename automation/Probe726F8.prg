*==============================================================================
* Probe726F8.prg - Probe da Fase 8 de FormSIGOPDVM (task726)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com CarregarLista rodando dentro do InicializarForm
*   2) escopo REAL dos metodos (PEMSTATUS ...,5 = existe / ...,2 = Protected):
*      CarregarLista e VincularColunasGrade PUBLICOS (o harness os chama de
*      fora - regras #3/#51), AplicarColunasDoDump PROTECTED
*   3) A GRADE RECEBEU DADO - RECCOUNT do cursor da comparacao e os VALORES
*      de cada linha. Abrir a tela nao prova nada num visualizador: o
*      equivalente a "testar gravando" eh provar que a consulta devolve LINHA
*   4) RecordSource + os 7 ControlSource ligados, e Width/Caption das 7
*      colunas SOBREVIVENDO ao RecordSource (Problema 48)
*   5) POSSE do cursor: criado por nos -> this_lCursorProprio = .T. e o
*      Destroy FECHA; pre-criado pelo "pai" -> .F. e o Destroy NAO fecha
*   6) ramo de FALHA (sem cursor de origem): a tela ABRE, a grade fica SEM
*      RecordSource e Width/Caption continuam repostos
*
* Toda chamada vai em TRY/CATCH proprio - sem isso um Program Error abre
* dialogo que ninguem fecha e o probe pendura MUDO.
*
* O form tem DataSession = 1 (compartilha a sessao de quem o cria), entao os
* cursores de origem montados AQUI sao exatamente os que ele enxerga - e o
* cursor da comparacao nasce nesta mesma sessao, o que eh justamente o motivo
* da regra de POSSE do item 5.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT "C:\4c\automation\probe_726f8.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_dData, loc_cCur, loc_nI, loc_cLinha

STRTOFILE("=== PROBE Fase 8 - FormSIGOPDVM (task726) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_726f8.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPDVMBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPDVM.prg") ADDITIVE

    gnConnHandle = -1
    loc_dData    = DATE()

    *--------------------------------------------------------------------
    * Cursores que no legado o form PAI deixa abertos na mesma sessao
    *
    * Caixa 001: mapa 80 x caixa 100 x itens 90 -> DIVERGE (passo 1)
    *            ValCxs = 100 - 5 (financeiro) = 95 / ValMrs = 80
    * Caixa 002: mapa 50 x caixa 50 x itens 50 -> FECHA, nao entra
    * Caixa 003: existe no caixa e NAO no mapa -> entra pelo passo 2
    *            ValCxs = 30 (sem descontar financeiro) / ValMrs = 0
    *--------------------------------------------------------------------
    CREATE CURSOR crPaiCaixa (Emps C(3), Datas D, Ecfs C(6), Valos N(14,2))
    INSERT INTO crPaiCaixa VALUES ("001", loc_dData, "001ABC", 100.00)
    INSERT INTO crPaiCaixa VALUES ("001", loc_dData, "002XYZ",  50.00)
    INSERT INTO crPaiCaixa VALUES ("001", loc_dData, "003QQQ",  30.00)

    CREATE CURSOR crPaiItens (Emps C(3), Datas D, Ecfs C(6), Valos N(14,2))
    INSERT INTO crPaiItens VALUES ("001", loc_dData, "001ABC",  90.00)
    INSERT INTO crPaiItens VALUES ("001", loc_dData, "002XYZ",  50.00)
    INSERT INTO crPaiItens VALUES ("001", loc_dData, "003QQQ",  25.00)

    CREATE CURSOR crPaiFin (Emps C(3), Datas D, Ecfs C(6), Valos N(14,2))
    INSERT INTO crPaiFin VALUES ("001", loc_dData, "001ABC", 5.00)

    CREATE CURSOR crPaiMapa (NCaixa C(3), VlContabil N(14,2), Iss N(14,2), Isento N(14,2))
    INSERT INTO crPaiMapa VALUES ("001", 80.00, 0.00, 0.00)
    INSERT INTO crPaiMapa VALUES ("002", 50.00, 0.00, 0.00)

    STRTOFILE("origem: caixa=" + TRANSFORM(RECCOUNT("crPaiCaixa")) + ;
        " itens=" + TRANSFORM(RECCOUNT("crPaiItens")) + ;
        " fin=" + TRANSFORM(RECCOUNT("crPaiFin")) + ;
        " mapa=" + TRANSFORM(RECCOUNT("crPaiMapa")) + CHR(13) + CHR(10), OUT, 1)

    *-- 1) instanciacao (InicializarForm chama CarregarLista)
    loc_oForm = CREATEOBJECT("FormSIGOPDVM", .NULL., "crPaiCaixa", "crPaiItens", ;
        "crPaiFin", "crPaiMapa", "001", loc_dData)
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " Caption=[" + loc_oForm.Caption + "]", " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO  = loc_oForm.this_oBusinessObject
    loc_cCur = ALLTRIM(loc_oBO.this_cCursorDestino)

    *-- 2) escopo REAL dos metodos (existe / PROTECTED)
    STRTOFILE("2) escopo (existe / PROTECTED):" + CHR(13) + CHR(10) + ;
        "   CarregarLista         existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10) + ;
        "   VincularColunasGrade  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "VincularColunasGrade", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "VincularColunasGrade", 2)) + CHR(13) + CHR(10) + ;
        "   AplicarColunasDoDump  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarColunasDoDump", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarColunasDoDump", 2)) + CHR(13) + CHR(10) + ;
        "   BtnEncerrarClick      existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + CHR(13) + CHR(10), OUT, 1)

    *-- 3) A GRADE RECEBEU DADO? (o teste que importa num visualizador)
    STRTOFILE("3) cursor [" + loc_cCur + "] USED=" + TRANSFORM(USED(loc_cCur)) + ;
        IIF(USED(loc_cCur), " RECCOUNT=" + TRANSFORM(RECCOUNT(loc_cCur)), "") + ;
        "  mensagemBO=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10), OUT, 1)

    IF USED(loc_cCur)
        SELECT (loc_cCur)
        GO TOP
        loc_nI = 0
        SCAN
            loc_nI = loc_nI + 1
            loc_cLinha = "   linha " + TRANSFORM(loc_nI) + ;
                ": Caixas=[" + ALLTRIM(Caixas) + "]" + ;
                " ValCxs=" + TRANSFORM(ValCxs) + ;
                " ValItens=" + TRANSFORM(ValItens) + ;
                " ValMrs=" + TRANSFORM(ValMrs) + ;
                " ValNfs=" + TRANSFORM(ValNfs) + ;
                " | DifMr=" + TRANSFORM(ValCxs - ValMrs) + ;
                " DifIT=" + TRANSFORM(ValCxs - ValItens)
            STRTOFILE(loc_cLinha + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
        STRTOFILE("   ESPERADO: 2 linhas - 001 (95/90/80 | 15/5) e 003 (30/25/0 | 30/5)" + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDIF

    *-- 4) vinculo e geometria das 7 colunas
    STRTOFILE("4) grade: RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
        " ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nI = 1 TO 7
        STRTOFILE("   Column" + TRANSFORM(loc_nI) + ;
            " CS=[" + EVALUATE("loc_oForm.grd_4c_Dados.Column" + TRANSFORM(loc_nI) + ".ControlSource") + "]" + ;
            " W=" + TRANSFORM(EVALUATE("loc_oForm.grd_4c_Dados.Column" + TRANSFORM(loc_nI) + ".Width")) + ;
            " Ord=" + TRANSFORM(EVALUATE("loc_oForm.grd_4c_Dados.Column" + TRANSFORM(loc_nI) + ".ColumnOrder")) + ;
            " Cap=[" + EVALUATE("loc_oForm.grd_4c_Dados.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + "]" + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDFOR

    *-- 5a) POSSE: fomos nos que criamos -> Destroy FECHA
    STRTOFILE("5a) this_lCursorProprio=" + TRANSFORM(loc_oForm.this_lCursorProprio) + ;
        " (esperado .T. - o cursor nao existia antes)" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm.Release()
    loc_oForm = .NULL.
    STRTOFILE("    apos Release -> USED(" + loc_cCur + ")=" + TRANSFORM(USED(loc_cCur)) + ;
        " (esperado .F.)" + CHR(13) + CHR(10), OUT, 1)

    *-- 5b) POSSE: cursor PRE-CRIADO (como o pai faz no legado) -> Destroy NAO fecha
    CREATE CURSOR cursor_4c_Dados ;
        (Datas T, Emps C(3), Caixas C(3), ValCxs N(14,2), ;
         ValItens N(14,2), ValMrs N(14,2), ValNfs N(14,2))
    loc_oForm = CREATEOBJECT("FormSIGOPDVM", .NULL., "crPaiCaixa", "crPaiItens", ;
        "crPaiFin", "crPaiMapa", "001", loc_dData)
    STRTOFILE("5b) cursor PRE-criado -> this_lCursorProprio=" + ;
        TRANSFORM(loc_oForm.this_lCursorProprio) + " (esperado .F.)" + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
        " (esperado 2 - o BO fez ZAP e repopulou)" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm.Release()
    loc_oForm = .NULL.
    STRTOFILE("    apos Release -> USED(cursor_4c_Dados)=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
        " (esperado .T. - o cursor eh do PAI, nao se fecha)" + CHR(13) + CHR(10), OUT, 1)
    IF USED("cursor_4c_Dados")
        USE IN cursor_4c_Dados
    ENDIF

    *-- 6) ramo de FALHA: sem cursor de origem nenhum
    loc_oForm = CREATEOBJECT("FormSIGOPDVM")
    STRTOFILE("6) sem contexto -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", ;
            " RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "] (esperado vazio)" + ;
            " ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
            " Col1.W=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + ;
            " Col7.W=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column7.Width) + ;
            " Col1.Cap=[" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
            " Col7.Cap=[" + loc_oForm.grd_4c_Dados.Column7.Header1.Caption + "]" + ;
            " proprio=" + TRANSFORM(loc_oForm.this_lCursorProprio) + ;
            " avisada=" + TRANSFORM(loc_oForm.this_lFalhaComparacaoAvisada), ;
            " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

    STRTOFILE("PROBE_OK" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + ;
        " | Linha: " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc: " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT
