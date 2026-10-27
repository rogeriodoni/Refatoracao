*==============================================================================
* ProbeFti262.prg - Erro262 (FormFti - Cadastro de Feitios)
*   a) Confirmar estourava "Dados de cadeia ou binarios seriam truncados"
*   b) botao de excluir linha da grade invisivel (coberto pelo PageFrame)
*   c) Confirmar/Encerrar desalinhados em relacao a faixa escura
*
* MEDE em VFP9 contra o banco real:
*   1) MaxLength dos campos char contra a largura REAL da coluna
*   2) cnt_4c_BotoesLinha visivel e NA FRENTE do pgf_4c_Configuracao
*   3) cnt_4c_Salva no canonico da pagina Dados (Top=33 / Left=842)
*   4) gravacao de verdade: Incluir -> Confirmar -> conferir no banco
*
* SEGURANCA: usa cods = 'ZZ', que nao existe, e apaga no fim conferindo que a
* tabela volta a contagem inicial.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fti262.txt"
#DEFINE OUT "C:\4c\automation\probe_fti262.txt"
#DEFINE CODTESTE "ZZ"

LOCAL loc_oE, loc_oF, loc_oPg2, loc_nBase, lcRel, loc_nZB, loc_nZP
STRTOFILE("=== PROBE Erro262 - FormFti ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FtiBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFti.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeFti262.prg"      ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti", "cBase")
    loc_nBase = cBase.t
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti WHERE cods = " + EscaparSQL(CODTESTE), "cT")
    STRTOFILE("baseline: SigPrFti tem " + TRANSFORM(loc_nBase) + " linha(s); codigo de teste ja existe? " + ;
        TRANSFORM(cT.t) + CHR(13) + CHR(10) + CHR(13) + CHR(10), OUT, 1)
    IF cT.t > 0
        STRTOFILE("ABORTADO: o codigo de teste ja existe" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oF = CREATEOBJECT("FormFti")
    IF VARTYPE(loc_oF) != "O"
        STRTOFILE("   FORM NAO ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oPg2 = loc_oF.pgf_4c_Paginas.Page2

    *================= 1) MaxLength x largura da coluna ======================
    STRTOFILE("1) MaxLength contra a largura REAL da coluna (regra #19)" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   txt_4c_Codigo.MaxLength    = " + TRANSFORM(loc_oPg2.txt_4c_Codigo.MaxLength) + ;
        "   (SigPrFti.cods eh char(2))" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   txt_4c_Descricao.MaxLength = " + TRANSFORM(loc_oPg2.txt_4c_Descricao.MaxLength) + ;
        "   (SigPrFti.descs eh char(20))" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Codigo limitado a 2 (a coluna eh char(2))", (loc_oPg2.txt_4c_Codigo.MaxLength = 2)
    DO Chk WITH "Descricao limitada a 20 (a coluna eh char(20))", (loc_oPg2.txt_4c_Descricao.MaxLength = 20)

    *================= 2) botao de linha visivel e na frente =================
    STRTOFILE(CHR(13) + CHR(10) + "2) Botao de excluir linha da grade" + CHR(13) + CHR(10), OUT, 1)
    *-- ZOrderSet eh propriedade so do Form Designer (regra #33): em runtime
    *-- nao existe. A ordem Z se le pelo INDICE em Controls - indice menor =
    *-- mais a frente, e eh isso que o ZOrder(0) altera.
    LOCAL loc_nI
    LOCAL ARRAY loc_aNomes[1]
    DIMENSION loc_aNomes[loc_oPg2.ControlCount]
    loc_nZB = 0
    loc_nZP = 0
    FOR loc_nI = 1 TO loc_oPg2.ControlCount
        loc_aNomes[loc_nI] = UPPER(loc_oPg2.Controls(loc_nI).Name)
        IF UPPER(loc_oPg2.Controls(loc_nI).Name) == "CNT_4C_BOTOESLINHA"
            loc_nZB = loc_nI
        ENDIF
        IF UPPER(loc_oPg2.Controls(loc_nI).Name) == "PGF_4C_CONFIGURACAO"
            loc_nZP = loc_nI
        ENDIF
    ENDFOR
    STRTOFILE("   ControlCount da Page2 = " + TRANSFORM(loc_oPg2.ControlCount) + ;
        "   (indice do cnt_4c_Cabecalho, criado 1o = " + ;
        TRANSFORM(ASCAN(loc_aNomes, "CNT_4C_CABECALHO")) + ")" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   cnt_4c_BotoesLinha  T=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesLinha.Top) + ;
        " L=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesLinha.Left) + ;
        " Visible=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesLinha.Visible) + ;
        " indiceZ=" + TRANSFORM(loc_nZB) + CHR(13) + CHR(10) + ;
        "   pgf_4c_Configuracao T=" + TRANSFORM(loc_oPg2.pgf_4c_Configuracao.Top) + ;
        " L=" + TRANSFORM(loc_oPg2.pgf_4c_Configuracao.Left) + ;
        " W=" + TRANSFORM(loc_oPg2.pgf_4c_Configuracao.Width) + ;
        " indiceZ=" + TRANSFORM(loc_nZP) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "cnt_4c_BotoesLinha visivel", loc_oPg2.cnt_4c_BotoesLinha.Visible
    *-- Convencao MEDIDA: o cnt_4c_Cabecalho, criado PRIMEIRO e que fica ATRAS
    *-- de tudo, esta no indice 1 - logo indice MAIOR = mais a FRENTE, e o
    *-- ZOrder(0) leva para o ultimo indice.
    DO Chk WITH "botao de linha NA FRENTE do PageFrame que o cobria", ;
        (loc_nZB > 0 AND loc_nZP > 0 AND loc_nZB > loc_nZP)
    DO Chk WITH "cmd_4c_ExcluirLinha existe e visivel", ;
        (PEMSTATUS(loc_oPg2.cnt_4c_BotoesLinha, "cmd_4c_ExcluirLinha", 5) AND ;
         loc_oPg2.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha.Visible)

    *================= 3) alinhamento com a faixa ============================
    STRTOFILE(CHR(13) + CHR(10) + "3) Confirmar / Encerrar x faixa escura" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   faixa  T=" + TRANSFORM(loc_oPg2.cnt_4c_Cabecalho.Top) + ;
        " H=" + TRANSFORM(loc_oPg2.cnt_4c_Cabecalho.Height) + ;
        "  ->  ocupa " + TRANSFORM(loc_oPg2.cnt_4c_Cabecalho.Top) + ".." + ;
        TRANSFORM(loc_oPg2.cnt_4c_Cabecalho.Top + loc_oPg2.cnt_4c_Cabecalho.Height) + CHR(13) + CHR(10) + ;
        "   cnt_4c_Salva T=" + TRANSFORM(loc_oPg2.cnt_4c_Salva.Top) + ;
        " L=" + TRANSFORM(loc_oPg2.cnt_4c_Salva.Left) + ;
        " W=" + TRANSFORM(loc_oPg2.cnt_4c_Salva.Width) + ;
        "  (canonico 33 / 842 / 160)" + CHR(13) + CHR(10) + ;
        "   Confirmar L=" + TRANSFORM(loc_oPg2.cnt_4c_Salva.Left + loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Left) + ;
        "  Encerrar L=" + TRANSFORM(loc_oPg2.cnt_4c_Salva.Left + loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Left) + ;
        "  (canonico 847 / 922)" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "faixa no canonico (29 / 80)", ;
        (loc_oPg2.cnt_4c_Cabecalho.Top = 29 AND loc_oPg2.cnt_4c_Cabecalho.Height = 80)
    DO Chk WITH "cnt_4c_Salva no canonico (33 / 842 / 160)", ;
        (loc_oPg2.cnt_4c_Salva.Top = 33 AND loc_oPg2.cnt_4c_Salva.Left = 842 AND ;
         loc_oPg2.cnt_4c_Salva.Width = 160)
    DO Chk WITH "Confirmar em 847 e Encerrar em 922", ;
        (loc_oPg2.cnt_4c_Salva.Left + loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Left = 847 AND ;
         loc_oPg2.cnt_4c_Salva.Left + loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Left  = 922)
    DO Chk WITH "botoes cabem no form", ;
        (loc_oPg2.cnt_4c_Salva.Left + loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Left + 75 <= loc_oF.Width)

    *================= 4) gravacao de verdade ================================
    STRTOFILE(CHR(13) + CHR(10) + "4) Incluir -> Confirmar (o erro do print)" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.BtnIncluirClick()
    loc_oPg2.txt_4c_Codigo.Value    = CODTESTE
    loc_oPg2.txt_4c_Descricao.Value = "TESTE 4C"
    loc_oPg2.txt_4c_Valor.Value     = 10
    loc_oPg2.txt_4c_CdMoeda.Value   = "R"
    loc_oF.BtnSalvarClick()

    =SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti WHERE cods = " + EscaparSQL(CODTESTE), "cV")
    STRTOFILE("   gravado: " + TRANSFORM(RECCOUNT("cV")) + " linha(s)" + ;
        IIF(RECCOUNT("cV") > 0, "  cods=[" + ALLTRIM(NVL(cV.cods, "")) + "]" + ;
        " descs=[" + ALLTRIM(NVL(cV.descs, "")) + "]" + ;
        " moedas=[" + ALLTRIM(NVL(cV.moedas, "")) + "]", "") + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "GRAVACAO: 1 linha, sem 'seriam truncados'", ;
        (RECCOUNT("cV") = 1 AND ALLTRIM(NVL(cV.cods, "")) == CODTESTE)
    DO Chk WITH "nenhum erro de truncamento no log", ;
        (NOT ("TRUNCAD" $ UPPER(IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), ""))))
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti", "cTot")
    DO Chk WITH "nenhuma linha alheia tocada", (cTot.t = loc_nBase + 1)

    *-- O LEFT tem de proteger o UPDATE tambem. Salvar() so aceita em edicao,
    *-- entao carregar + EditarRegistro antes (regra #20).
    LOCAL loc_lUpd
    loc_lUpd = .F.
    IF loc_oF.this_oBusinessObject.CarregarPorCodigo(CODTESTE)
        loc_oF.this_oBusinessObject.EditarRegistro()
        loc_oF.this_oBusinessObject.this_cDescricao = REPLICATE("X", 40)
        loc_lUpd = loc_oF.this_oBusinessObject.Salvar()
    ENDIF
    DO Chk WITH "UPDATE com descricao de 40 chars nao estoura (LEFT corta)", loc_lUpd
    =SQLEXEC(gnConnHandle, "SELECT descs FROM SigPrFti WHERE cods = " + EscaparSQL(CODTESTE), "cU")
    STRTOFILE("   descs apos UPDATE de 40 chars = " + TRANSFORM(LEN(ALLTRIM(NVL(cU.descs, "")))) + ;
        " caracteres (coluna eh char(20))" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "gravou truncado em 20, nao recusou o UPDATE", ;
        (RECCOUNT("cU") = 1 AND LEN(ALLTRIM(NVL(cU.descs, ""))) = 20)

    *================= 5) LIMPEZA ============================================
    STRTOFILE(CHR(13) + CHR(10) + "5) LIMPEZA" + CHR(13) + CHR(10), OUT, 1)
    =SQLEXEC(gnConnHandle, "DELETE FROM SigPrFti WHERE cods IN (" + EscaparSQL(CODTESTE) + ", '99')")
    =SQLEXEC(gnConnHandle, "DELETE FROM SigPrFto WHERE cods IN (" + EscaparSQL(CODTESTE) + ", '99')")
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti", "cFim")
    STRTOFILE("   SigPrFti voltou a " + TRANSFORM(cFim.t) + " linha(s) (baseline " + TRANSFORM(loc_nBase) + ")" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "tabela restaurada ao estado inicial", (cFim.t = loc_nBase)

    loc_oF.Release()
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

lcRel = FILETOSTR(OUT)
STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + ;
    TRANSFORM(OCCURS("[FALHA]", lcRel) + OCCURS("EXCECAO:", lcRel)) + CHR(13) + CHR(10), OUT, 1)
QUIT


PROCEDURE Chk(pcTitulo, plOk)
    STRTOFILE("   " + IIF(plOk, "[OK]   ", "[FALHA]") + " " + pcTitulo + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fti262.txt", 1)
ENDPROC
