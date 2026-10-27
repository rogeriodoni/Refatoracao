*==============================================================================
* ProbeFti260.prg - Erro260 / Erro261 (FormFti - Cadastro de Feitios)
*   a) grade "Grupos de Produto" aparecia BRANCA depois de Incluir/Alterar
*   b) "Unknown member COLUMN3" no Activate da 2a aba (Custos Fixo)
*
* Causa unica: CriarCursoresGrade fazia "USE IN" + "CREATE CURSOR", fechando e
* recriando csGrade/csCusto. Fechar o alias derruba Grid.RecordSource e as
* Column.ControlSource ligadas em ConfigurarPgPage1/2, e o ColumnCount colapsa.
* O metodo eh rechamado em Incluir/Alterar/Visualizar, por isso o defeito so
* aparecia DEPOIS de entrar em edicao - abrir a tela nao pegava.
*
* MEDE em VFP9: ColumnCount, RecordSource e ControlSource das DUAS grades
* ANTES e DEPOIS de BtnIncluirClick, BtnAlterarClick e BtnVisualizarClick.
* Nao grava nada no banco.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fti260.txt"
#DEFINE OUT "C:\4c\automation\probe_fti260.txt"

LOCAL loc_oE, loc_oF, loc_oG1, loc_oG2, lcRel
STRTOFILE("=== PROBE Erro260/261 - FormFti ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO "C:\4c\automation\ProbeFti260.prg"      ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    loc_oF = CREATEOBJECT("FormFti")
    IF VARTYPE(loc_oF) != "O"
        STRTOFILE("   FORM NAO ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oG1 = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade
    loc_oG2 = loc_oF.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo

    DO Estado WITH loc_oG1, loc_oG2, "logo apos abrir a tela"
    DO ChkGrades WITH loc_oG1, loc_oG2, "ao abrir"

    *-- os tres caminhos que rechamam CriarCursoresGrade
    loc_oF.BtnIncluirClick()
    DO Estado WITH loc_oG1, loc_oG2, "apos BtnIncluirClick"
    DO ChkGrades WITH loc_oG1, loc_oG2, "apos INCLUIR"

    *-- e o Activate da 2a aba, que era onde estourava
    loc_oF.ConfigPage2Activate()
    STRTOFILE("   ConfigPage2Activate -> Column3.Header1 = [" + ;
        ALLTRIM(loc_oG2.Column3.Header1.Caption) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "ConfigPage2Activate rodou sem 'Unknown member COLUMN3'", ;
        (NOT ("UNKNOWN MEMBER" $ UPPER(IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), ""))))
    DO Chk WITH "caption da Column3 atualizado pelo Activate", ;
        (INLIST(ALLTRIM(loc_oG2.Column3.Header1.Caption), "Coeficiente", "( % )"))

    loc_oF.BtnCancelarClick()
    loc_oF.BtnAlterarClick()
    DO Estado WITH loc_oG1, loc_oG2, "apos BtnAlterarClick"
    DO ChkGrades WITH loc_oG1, loc_oG2, "apos ALTERAR"

    loc_oF.BtnCancelarClick()
    loc_oF.BtnVisualizarClick()
    DO Estado WITH loc_oG1, loc_oG2, "apos BtnVisualizarClick"
    DO ChkGrades WITH loc_oG1, loc_oG2, "apos VISUALIZAR"

    *-- Os cursores tem de continuar VIVOS (ZAP, nao USE IN). O form eh
    *-- DataSession = 2, entao eles vivem na sessao PRIVADA dele - de fora
    *-- USED() devolve .F. mesmo com o cursor aberto. Entrar na sessao do form.
    LOCAL loc_nSessaoAnt, loc_lG, loc_lC
    loc_nSessaoAnt = SET("DATASESSION")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_lG = USED("csGrade")
    loc_lC = USED("csCusto")
    SET DATASESSION TO loc_nSessaoAnt
    STRTOFILE("   na datasession do form: csGrade USED=" + TRANSFORM(loc_lG) + ;
        "  csCusto USED=" + TRANSFORM(loc_lC) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "os dois cursores seguem abertos (ZAP preserva o alias)", (loc_lG AND loc_lC)

    loc_oF.Release()
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

lcRel = FILETOSTR(OUT)
*-- excecao conta como falha: ela ABORTA o probe antes dos [FALHA] seguintes
STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + ;
    TRANSFORM(OCCURS("[FALHA]", lcRel) + OCCURS("EXCECAO:", lcRel)) + CHR(13) + CHR(10), OUT, 1)
QUIT


PROCEDURE Estado(poG1, poG2, pcQuando)
    STRTOFILE(CHR(13) + CHR(10) + pcQuando + ":" + CHR(13) + CHR(10) + ;
        "   grd_4c_Grade  ColumnCount=" + PADR(TRANSFORM(poG1.ColumnCount), 3) + ;
        " RecordSource=[" + PADR(ALLTRIM(poG1.RecordSource), 10) + "]" + ;
        " Col1.Src=[" + ALLTRIM(poG1.Column1.ControlSource) + "]" + CHR(13) + CHR(10) + ;
        "   grd_4c_Custo  ColumnCount=" + PADR(TRANSFORM(poG2.ColumnCount), 3) + ;
        " RecordSource=[" + PADR(ALLTRIM(poG2.RecordSource), 10) + "]" + ;
        " Col1.Src=[" + ALLTRIM(poG2.Column1.ControlSource) + "]" + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fti260.txt", 1)
ENDPROC

PROCEDURE ChkGrades(poG1, poG2, pcQuando)
    DO Chk WITH "grd_4c_Grade com 5 colunas e ligada a csGrade (" + pcQuando + ")", ;
        (poG1.ColumnCount = 5 AND UPPER(ALLTRIM(poG1.RecordSource)) == "CSGRADE" AND ;
         UPPER(ALLTRIM(poG1.Column1.ControlSource)) == "CSGRADE.CGRUS")
    DO Chk WITH "grd_4c_Custo com 4 colunas e ligada a csCusto (" + pcQuando + ")", ;
        (poG2.ColumnCount = 4 AND UPPER(ALLTRIM(poG2.RecordSource)) == "CSCUSTO" AND ;
         UPPER(ALLTRIM(poG2.Column1.ControlSource)) == "CSCUSTO.CPROS")
ENDPROC

PROCEDURE Chk(pcTitulo, plOk)
    STRTOFILE("   " + IIF(plOk, "[OK]   ", "[FALHA]") + " " + pcTitulo + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fti260.txt", 1)
ENDPROC
