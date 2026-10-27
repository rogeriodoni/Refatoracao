*==============================================================================
* ProbeFti263.prg - FormFti: grades de Grupo e Custo Fixo
*   a) os lookups de Grupo e Produto nunca abriam
*   b) apos gravar, a grade nao trazia o que foi digitado
*
* Causa (a): BINDEVENT em "When"/"Valid" de Column.Text1 NAO dispara de forma
* confiavel (regra #46). O padrao certo eh TextBox subclasse com os eventos
* embutidos (TextBoxCelulaFti_4c), instalada com AddObject + CurrentControl +
* Sparse = .F. (regra #18).
* Causa (b): dentro do Valid o digitado vive em .Value e o CURSOR so recebe
* DEPOIS - os metodos liam do cursor e validavam o valor ANTERIOR.
*
* MEDE em VFP9 contra o banco real:
*   1) as 6 celulas instaladas, com CurrentControl e Sparse corretos
*   2) o Valid resolve a partir do que foi DIGITADO e devolve ao TextBox
*   3) ciclo completo: digitar nas duas grades -> gravar -> reabrir -> conferir
*
* SEGURANCA: usa cods = 'ZZ', que nao existe, e apaga no fim (SigPrFti+SigPrFto).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fti263.txt"
#DEFINE OUT "C:\4c\automation\probe_fti263.txt"
#DEFINE CODTESTE "ZZ"

LOCAL loc_oE, loc_oF, loc_oPg2, loc_oG1, loc_oG2, loc_nBase, lcRel
LOCAL loc_cGrupo, loc_cProduto, loc_nLidas, loc_oCel
STRTOFILE("=== PROBE FormFti - grades de Grupo e Custo ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")  ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")  ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FtiBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFti.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeFti263.prg"      ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti", "cBase")
    loc_nBase = cBase.t
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti WHERE cods = " + EscaparSQL(CODTESTE), "cT")
    IF cT.t > 0
        STRTOFILE("ABORTADO: o codigo de teste ja existe" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    *-- um grupo e um produto REAIS para digitar nas grades
    =SQLEXEC(gnConnHandle, "SELECT TOP 1 Cgrus FROM SigCdGrp ORDER BY Cgrus", "cG")
    =SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros FROM SigCdPro ORDER BY CPros", "cP")
    loc_cGrupo   = ALLTRIM(NVL(cG.Cgrus, ""))
    loc_cProduto = ALLTRIM(NVL(cP.CPros, ""))
    STRTOFILE("baseline: SigPrFti " + TRANSFORM(loc_nBase) + " linha(s);  grupo de teste=[" + ;
        loc_cGrupo + "]  produto de teste=[" + loc_cProduto + "]" + CHR(13) + CHR(10) + CHR(13) + CHR(10), OUT, 1)

    loc_oF = CREATEOBJECT("FormFti")
    *-- O form eh DataSession = 2: csGrade/csCusto vivem na sessao PRIVADA dele.
    *-- De fora, "SELECT csGrade" estoura "Alias CSGRADE is not found". Entrar na
    *-- sessao do form para o teste inteiro (SQLEXEC funciona em qualquer sessao).
    LOCAL loc_nSessaoAnt
    loc_nSessaoAnt = SET("DATASESSION")
    SET DATASESSION TO loc_oF.DataSessionId
    loc_oPg2 = loc_oF.pgf_4c_Paginas.Page2
    loc_oG1 = loc_oPg2.pgf_4c_Configuracao.Page1.grd_4c_Grade
    loc_oG2 = loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo

    *================= 1) celulas instaladas =================================
    STRTOFILE("1) Celulas com eventos embutidos (regra #46/#18)" + CHR(13) + CHR(10), OUT, 1)
    DO Cel WITH loc_oG1, 1, "GRUPOCOD",  "grd_4c_Grade.Column1 (Grupo)"
    DO Cel WITH loc_oG1, 3, "GRUPOCOEF", "grd_4c_Grade.Column3 (Coeficiente)"
    DO Cel WITH loc_oG1, 4, "GRUPOPROD", "grd_4c_Grade.Column4 (Produto)"
    DO Cel WITH loc_oG2, 1, "CUSTOCOD",  "grd_4c_Custo.Column1 (Produto)"
    DO Cel WITH loc_oG2, 3, "CUSTOCOEF", "grd_4c_Custo.Column3 (Coeficiente)"
    DO Cel WITH loc_oG2, 4, "CUSTOCOL4", "grd_4c_Custo.Column4"

    *================= 2) Valid le o DIGITADO ================================
    STRTOFILE(CHR(13) + CHR(10) + "2) O Valid resolve a partir do que foi DIGITADO" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.BtnIncluirClick()
    loc_oPg2.txt_4c_Codigo.Value    = CODTESTE
    loc_oPg2.txt_4c_Descricao.Value = "TESTE GRADES"
    loc_oPg2.txt_4c_Valor.Value     = 10
    loc_oPg2.txt_4c_CdMoeda.Value   = "R"

    *-- digita o grupo NA CELULA (o cursor ainda nao recebeu) e dispara o Valid
    SELECT csGrade
    GO TOP
    loc_oCel = loc_oG1.Column1.txt_4c_Cel
    loc_oCel.Value = loc_cGrupo
    STRTOFILE("   celula Grupo digitada = [" + ALLTRIM(loc_oCel.Value) + "]" + ;
        "   cursor ANTES do Valid = [" + ALLTRIM(csGrade.Cgrus) + "]" + CHR(13) + CHR(10), OUT, 1)
    =loc_oF.GradeGrupoCol1Valid(loc_oCel)
    STRTOFILE("   depois do Valid: cursor=[" + ALLTRIM(csGrade.Cgrus) + "]" + ;
        "  descricao=[" + ALLTRIM(csGrade.Dgrus) + "]" + ;
        "  celula=[" + ALLTRIM(loc_oCel.Value) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Valid levou o DIGITADO para o cursor (nao o valor anterior)", ;
        (ALLTRIM(csGrade.Cgrus) == loc_cGrupo)
    DO Chk WITH "Valid preencheu a descricao do grupo pelo lookup", ;
        (NOT EMPTY(ALLTRIM(csGrade.Dgrus)))

    *================= 3) ciclo gravar -> reabrir ============================
    STRTOFILE(CHR(13) + CHR(10) + "3) Digitar nas duas grades -> gravar -> reabrir" + CHR(13) + CHR(10), OUT, 1)
    SELECT csGrade
    GO TOP
    REPLACE CPros WITH loc_cProduto, Coefs WITH 1.5
    SELECT csCusto
    GO TOP
    REPLACE Cpros WITH loc_cProduto, Dpros WITH "PRODUTO TESTE", Coefs WITH 2.5, Seqs WITH 1
    STRTOFILE("   csGrade: Cgrus=[" + ALLTRIM(csGrade.Cgrus) + "] CPros=[" + ALLTRIM(csGrade.CPros) + ;
        "] Coefs=" + TRANSFORM(csGrade.Coefs) + CHR(13) + CHR(10) + ;
        "   csCusto: Cpros=[" + ALLTRIM(csCusto.Cpros) + "] Coefs=" + TRANSFORM(csCusto.Coefs) + CHR(13) + CHR(10), OUT, 1)

    loc_oF.BtnSalvarClick()

    =SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFto WHERE cods = " + EscaparSQL(CODTESTE) + " ORDER BY seqs", "cI")
    STRTOFILE("   SigPrFto gravou " + TRANSFORM(RECCOUNT("cI")) + " item(ns)" + CHR(13) + CHR(10), OUT, 1)
    IF RECCOUNT("cI") > 0
        SELECT cI
        SCAN
            STRTOFILE("      cgrus=[" + ALLTRIM(NVL(cI.cgrus, "")) + "] cpros=[" + ;
                ALLTRIM(NVL(cI.cpros, "")) + "] coefs=" + TRANSFORM(NVL(cI.coefs, 0)) + CHR(13) + CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
    DO Chk WITH "GRAVOU as 2 linhas (1 de grupo + 1 de custo)", (RECCOUNT("cI") = 2)

    *-- reabrir o registro: a grade tem de trazer o que foi digitado
    loc_oF.BtnAlterarClick()
    loc_nLidas = 0
    IF USED("csGrade")
        SELECT csGrade
        COUNT FOR !EMPTY(ALLTRIM(Cgrus)) TO loc_nLidas
    ENDIF
    STRTOFILE("   apos reabrir: csGrade com " + TRANSFORM(loc_nLidas) + " linha(s) preenchida(s)" + ;
        "   Cgrus=[" + ALLTRIM(NVL(csGrade.Cgrus, "")) + "] Dgrus=[" + ALLTRIM(NVL(csGrade.Dgrus, "")) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "a grade de Grupos TRAZ o que foi gravado", (loc_nLidas >= 1)

    loc_nLidas = 0
    IF USED("csCusto")
        SELECT csCusto
        COUNT FOR !EMPTY(ALLTRIM(Cpros)) TO loc_nLidas
        GO TOP
    ENDIF
    STRTOFILE("   apos reabrir: csCusto com " + TRANSFORM(loc_nLidas) + " linha(s) preenchida(s)" + ;
        "   Cpros=[" + ALLTRIM(NVL(csCusto.Cpros, "")) + "] Coefs=" + TRANSFORM(NVL(csCusto.Coefs, 0)) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "a grade de Custos Fixo TRAZ o que foi gravado", (loc_nLidas >= 1)

    *================= 4) LIMPEZA ============================================
    STRTOFILE(CHR(13) + CHR(10) + "4) LIMPEZA" + CHR(13) + CHR(10), OUT, 1)
    =SQLEXEC(gnConnHandle, "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(CODTESTE))
    =SQLEXEC(gnConnHandle, "DELETE FROM SigPrFti WHERE cods = " + EscaparSQL(CODTESTE))
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFti", "cFim")
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigPrFto WHERE cods = " + EscaparSQL(CODTESTE), "cFim2")
    STRTOFILE("   SigPrFti voltou a " + TRANSFORM(cFim.t) + " (baseline " + TRANSFORM(loc_nBase) + ")" + ;
        "   SigPrFto de teste: " + TRANSFORM(cFim2.t) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "tabelas restauradas ao estado inicial", (cFim.t = loc_nBase AND cFim2.t = 0)

    SET DATASESSION TO loc_nSessaoAnt
    loc_oF.Release()
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

lcRel = FILETOSTR(OUT)
STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + ;
    TRANSFORM(OCCURS("[FALHA]", lcRel) + OCCURS("EXCECAO:", lcRel)) + CHR(13) + CHR(10), OUT, 1)
QUIT


PROCEDURE Cel(poGrid, pnCol, pcTag, pcNome)
    LOCAL loc_lOk, loc_cCtrl
    loc_cCtrl = UPPER(ALLTRIM(poGrid.Columns(pnCol).CurrentControl))
    loc_lOk = (loc_cCtrl == "TXT_4C_CEL") AND ;
              (NOT poGrid.Columns(pnCol).Sparse) AND ;
              PEMSTATUS(poGrid.Columns(pnCol), "txt_4c_Cel", 5) AND ;
              (UPPER(ALLTRIM(poGrid.Columns(pnCol).txt_4c_Cel.this_cCelula)) == pcTag)
    STRTOFILE("   " + PADR(pcNome, 36) + " CurrentControl=" + PADR(loc_cCtrl, 12) + ;
        " Sparse=" + PADR(TRANSFORM(poGrid.Columns(pnCol).Sparse), 3) + ;
        " celula=" + ALLTRIM(poGrid.Columns(pnCol).txt_4c_Cel.this_cCelula) + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fti263.txt", 1)
    DO Chk WITH pcNome + " com a celula " + pcTag, loc_lOk
ENDPROC

PROCEDURE Chk(pcTitulo, plOk)
    STRTOFILE("   " + IIF(plOk, "[OK]   ", "[FALHA]") + " " + pcTitulo + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fti263.txt", 1)
ENDPROC
