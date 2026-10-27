*==============================================================================
* ProbeFpo259.prg - Erro259
*   a) "Table buffer for alias CURSOR_4C_DADOS contains uncommitted changes"
*      ao Salvar/recarregar depois de a grade ter sido editada
*   b) a grade principal estava PERMITINDO alteracao (ela eh so exibicao: a
*      edicao acontece na aba Dados)
*
* MEDE em VFP9 contra o banco real:
*   1) Grid e TODAS as colunas somente leitura DEPOIS do bind (o ColumnCount do
*      VincularGrade recria as colunas e zera o ReadOnly delas)
*   2) os CheckBox O/A/C tambem somente leitura
*   3) recarregar com o buffer SUJO nao estoura (guard de Buffering + USE IN
*      antes do SQLEXEC, regra #52)
*   4) o fluxo Alterar -> Confirmar continua funcionando de ponta a ponta
*
* SEGURANCA: usa Dopes = 'ZZTESTE4C', que nao existe, e apaga no fim.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fpo259.txt"
#DEFINE OUT "C:\4c\automation\probe_fpo259.txt"
#DEFINE DOPESTESTE "ZZTESTE4C"

LOCAL loc_oE, loc_oF, loc_oG, loc_oP, loc_oD, loc_nBase, loc_nI, loc_nFalhas
LOCAL loc_lTodasRO, loc_lOk, lcRel
STRTOFILE("=== PROBE Erro259 - FormFpo ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO (gcCaminhoClasses + "FpoBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFpo.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeFpo259.prg"      ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cBase")
    loc_nBase = cBase.t
    STRTOFILE("baseline: SigOpFpo tem " + TRANSFORM(loc_nBase) + " linha(s)" + CHR(13) + CHR(10) + CHR(13) + CHR(10), OUT, 1)

    loc_oF = CREATEOBJECT("FormFpo")
    loc_oP = loc_oF.pgf_4c_Paginas.Page1
    loc_oD = loc_oF.pgf_4c_Paginas.Page2
    loc_oG = loc_oP.grd_4c_Lista

    *================= 1) GRADE SO EXIBICAO ==================================
    STRTOFILE("1) A grade principal eh SO EXIBICAO" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   Grid.ReadOnly = " + TRANSFORM(loc_oG.ReadOnly) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Grid.ReadOnly = .T.", loc_oG.ReadOnly

    loc_lTodasRO = .T.
    FOR loc_nI = 1 TO 6
        STRTOFILE("   Col" + TRANSFORM(loc_nI) + ".ReadOnly = " + ;
            TRANSFORM(loc_oG.Columns(loc_nI).ReadOnly) + ;
            IIF(INLIST(loc_nI, 3, 4, 5), "   Check1.ReadOnly = " + ;
            TRANSFORM(loc_oG.Columns(loc_nI).Check1.ReadOnly), "") + CHR(13) + CHR(10), OUT, 1)
        IF !loc_oG.Columns(loc_nI).ReadOnly
            loc_lTodasRO = .F.
        ENDIF
    ENDFOR
    DO Chk WITH "todas as 6 colunas ReadOnly (o ColumnCount do bind as recria)", loc_lTodasRO
    DO Chk WITH "CheckBox O/A/C somente leitura", ;
        (loc_oG.Column3.Check1.ReadOnly AND loc_oG.Column4.Check1.ReadOnly AND ;
         loc_oG.Column5.Check1.ReadOnly)

    *================= 2) BUFFER SUJO ========================================
    STRTOFILE(CHR(13) + CHR(10) + "2) Recarregar com o buffer SUJO (o erro do print)" + CHR(13) + CHR(10), OUT, 1)
    SELECT cursor_4c_Dados
    STRTOFILE("   Buffering do cursor = " + TRANSFORM(CURSORGETPROP("Buffering", "cursor_4c_Dados")) + CHR(13) + CHR(10), OUT, 1)

    *-- liga buffering e suja o registro, reproduzindo o que a grade editavel fazia
    =CURSORSETPROP("Buffering", 5, "cursor_4c_Dados")
    GO TOP
    REPLACE Obrigs WITH IIF(NVL(Obrigs, 0) = 1, 0, 1)
    STRTOFILE("   apos REPLACE -> GETFLDSTATE(1) = " + TRANSFORM(GETFLDSTATE(-1)) + ;
        "  (buffer sujo)" + CHR(13) + CHR(10), OUT, 1)

    loc_lOk = loc_oF.CarregarLista()
    STRTOFILE("   CarregarLista() com buffer sujo -> " + TRANSFORM(loc_lOk) + ;
        "   linhas=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "recarregou SEM o erro 'contains uncommitted changes'", ;
        (loc_lOk AND RECCOUNT("cursor_4c_Dados") = loc_nBase)
    DO Chk WITH "a alteracao pendente foi descartada (nao foi parar no banco)", ;
        (!("uncommitted" $ LOWER(IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), ""))))

    *-- e a grade continua ligada depois do USE IN + novo SQLEXEC
    DO Chk WITH "grade segue ligada ao cursor apos o recarregamento", ;
        (UPPER(ALLTRIM(loc_oG.RecordSource)) == "CURSOR_4C_DADOS" AND ;
         UPPER(ALLTRIM(loc_oG.Column1.ControlSource)) == "CURSOR_4C_DADOS.DOPES")
    DO Chk WITH "e segue somente leitura depois do recarregamento", ;
        (loc_oG.ReadOnly AND loc_oG.Column3.ReadOnly)

    *================= 3) ALTERAR -> SALVAR ponta a ponta ====================
    STRTOFILE(CHR(13) + CHR(10) + "3) Incluir -> Alterar -> Salvar (o fluxo do print)" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.BtnIncluirClick()
    loc_oD.txt_4c_Dopes.Value   = DOPESTESTE
    loc_oD.txt_4c_FPags.Value   = "CHEQUE"
    loc_oD.chk_4c_Obrigs.Value  = 1
    loc_oF.BtnConfirmarClick()

    SELECT cursor_4c_Dados
    LOCATE FOR ALLTRIM(Dopes) == DOPESTESTE
    DO Chk WITH "registro incluido aparece na Lista", FOUND()

    loc_oF.BtnAlterarClick()
    loc_oD.chk_4c_Obrigs.Value = 0
    loc_oD.chk_4c_Autos.Value  = 1
    loc_oF.BtnConfirmarClick()
    STRTOFILE("   apos Salvar -> ActivePage=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  modo=" + ALLTRIM(loc_oF.this_cModoAtual) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Salvar voltou para a Lista sem erro", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 1 AND loc_oF.this_cModoAtual == "LISTA")

    =SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cV")
    STRTOFILE("   no banco: " + TRANSFORM(RECCOUNT("cV")) + " linha(s)" + ;
        IIF(RECCOUNT("cV") > 0, "  Obrigs=" + TRANSFORM(NVL(cV.Obrigs, -1)) + ;
        " Autos=" + TRANSFORM(NVL(cV.Autos, -1)), "") + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "ALTERACAO gravada (1 linha, valores novos)", ;
        (RECCOUNT("cV") = 1 AND NVL(cV.Obrigs, -1) = 0 AND NVL(cV.Autos, -1) = 1)

    *-- nada das outras operacoes pode ter mudado pelo REPLACE do passo 2
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cTot")
    DO Chk WITH "nenhuma linha alheia alterada/criada", (cTot.t = loc_nBase + 1)

    *================= 4) LIMPEZA ============================================
    STRTOFILE(CHR(13) + CHR(10) + "4) LIMPEZA" + CHR(13) + CHR(10), OUT, 1)
    =SQLEXEC(gnConnHandle, "DELETE FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE))
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cFim")
    STRTOFILE("   SigOpFpo voltou a " + TRANSFORM(cFim.t) + " linha(s) (baseline " + TRANSFORM(loc_nBase) + ")" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "tabela restaurada ao estado inicial", (cFim.t = loc_nBase)

    loc_oF.Release()
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

lcRel = FILETOSTR(OUT)
STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + TRANSFORM(OCCURS("[FALHA]", lcRel)) + CHR(13) + CHR(10), OUT, 1)
QUIT


PROCEDURE Chk(pcTitulo, plOk)
    STRTOFILE("   " + IIF(plOk, "[OK]   ", "[FALHA]") + " " + pcTitulo + CHR(13) + CHR(10), ;
        "C:\4c\automation\probe_fpo259.txt", 1)
ENDPROC
