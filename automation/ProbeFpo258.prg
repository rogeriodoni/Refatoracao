*==============================================================================
* ProbeFpo258.prg - Erro258: FormFpo "totalmente fora do padrao"
*
* A tela tem entrada propria no MENU, entao segue o CRUD canonico:
*   Page1 = Lista (grade + Incluir/Visualizar/Alterar/Excluir/Buscar + Encerrar)
*   Incluir/Alterar/Visualizar levam a Page2 = Dados, com Confirmar/Cancelar.
*
* MEDE em VFP9 contra o banco real:
*   1) form 1000x600, barra CRUD em 542 (5 botoes) e cnt_4c_Saida em 917
*   2) grade de Lista ja populada ao abrir, sem "Header1" default
*   3) CRUD pelo FLUXO REAL: Incluir -> Page2 -> Confirmar -> volta a Lista;
*      Alterar -> Page2 -> Confirmar; Visualizar (so leitura); Excluir
*
* SEGURANCA: usa Dopes = 'ZZTESTE4C', que nao existe, e apaga no fim conferindo
* que a tabela volta a contagem inicial.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fpo258.txt"
#DEFINE OUT "C:\4c\automation\probe_fpo258.txt"
#DEFINE DOPESTESTE "ZZTESTE4C"

LOCAL loc_oE, loc_oF, loc_oG, loc_oP, loc_oD, loc_nBase, loc_nI, loc_cL, lcRel
STRTOFILE("=== PROBE Erro258 - FormFpo (CRUD canonico) ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO "C:\4c\automation\ProbeFpo258.prg"      ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cBase")
    loc_nBase = cBase.t
    STRTOFILE("baseline: SigOpFpo tem " + TRANSFORM(loc_nBase) + " linha(s)" + CHR(13) + CHR(10) + CHR(13) + CHR(10), OUT, 1)
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cT")
    IF cT.t > 0
        STRTOFILE("ABORTADO: a chave de teste ja existe" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *================= 1) LAYOUT =============================================
    STRTOFILE("1) LAYOUT - CRUD canonico de tela de MENU" + CHR(13) + CHR(10), OUT, 1)
    loc_oF = CREATEOBJECT("FormFpo")
    IF VARTYPE(loc_oF) != "O"
        STRTOFILE("   FORM NAO ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oP = loc_oF.pgf_4c_Paginas.Page1
    loc_oD = loc_oF.pgf_4c_Paginas.Page2
    STRTOFILE("   Form " + TRANSFORM(loc_oF.Width) + "x" + TRANSFORM(loc_oF.Height) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Form 1000x600", (loc_oF.Width = 1000 AND loc_oF.Height = 600)

    STRTOFILE("   Lista: barra CRUD L=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left) + ;
        " W=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Width) + ;
        "   Saida L=" + TRANSFORM(loc_oP.cnt_4c_Saida.Left) + ;
        " W=" + TRANSFORM(loc_oP.cnt_4c_Saida.Width) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "barra CRUD canonica (542 / 385)", ;
        (loc_oP.cnt_4c_Botoes.Left = 542 AND loc_oP.cnt_4c_Botoes.Width = 385)
    DO Chk WITH "cnt_4c_Saida canonico (917 / 90) - regra #10", ;
        (loc_oP.cnt_4c_Saida.Left = 917 AND loc_oP.cnt_4c_Saida.Width = 90)

    STRTOFILE("   botoes: Incluir=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Incluir.Left) + ;
        " Visualizar=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Visualizar.Left) + ;
        " Alterar=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Alterar.Left) + ;
        " Excluir=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Excluir.Left) + ;
        " Buscar=" + TRANSFORM(loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Buscar.Left) + ;
        " Encerrar=" + TRANSFORM(loc_oP.cnt_4c_Saida.Left + loc_oP.cnt_4c_Saida.cmd_4c_Encerrar.Left) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "os 5 botoes CRUD em 547/622/697/772/847 e Encerrar em 922", ;
        (loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Incluir.Left    = 547 AND ;
         loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Visualizar.Left = 622 AND ;
         loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Alterar.Left    = 697 AND ;
         loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Excluir.Left    = 772 AND ;
         loc_oP.cnt_4c_Botoes.Left + loc_oP.cnt_4c_Botoes.cmd_4c_Buscar.Left     = 847 AND ;
         loc_oP.cnt_4c_Saida.Left  + loc_oP.cnt_4c_Saida.cmd_4c_Encerrar.Left    = 922)

    loc_oG = loc_oP.grd_4c_Lista
    STRTOFILE("   grade T=" + TRANSFORM(loc_oG.Top) + " L=" + TRANSFORM(loc_oG.Left) + ;
        " W=" + TRANSFORM(loc_oG.Width) + " H=" + TRANSFORM(loc_oG.Height) + ;
        " ReadOnly=" + TRANSFORM(loc_oG.ReadOnly) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "grade de Lista 117/26/880/440 e somente leitura", ;
        (loc_oG.Top = 117 AND loc_oG.Left = 26 AND loc_oG.Width = 880 AND ;
         loc_oG.Height = 440 AND loc_oG.ReadOnly)
    DO Chk WITH "Page2 tem os campos do registro", ;
        (PEMSTATUS(loc_oD, "txt_4c_Dopes", 5) AND PEMSTATUS(loc_oD, "txt_4c_FPags", 5) AND ;
         PEMSTATUS(loc_oD, "txt_4c_FPagss", 5) AND PEMSTATUS(loc_oD, "chk_4c_Obrigs", 5) AND ;
         PEMSTATUS(loc_oD, "chk_4c_Autos", 5) AND PEMSTATUS(loc_oD, "chk_4c_Contabs", 5))
    DO Chk WITH "Page2: nenhum campo sob a faixa (Top >= 109)", ;
        (loc_oD.txt_4c_Dopes.Top >= 109 AND loc_oD.shp_4c_Campos.Top >= 109)

    *================= 2) GRADE DA LISTA =====================================
    STRTOFILE(CHR(13) + CHR(10) + "2) GRADE DA LISTA" + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nI = 1 TO 6
        STRTOFILE("   Col" + TRANSFORM(loc_nI) + " hdr=" + PADR(ALLTRIM(loc_oG.Columns(loc_nI).Header1.Caption), 16) + ;
            " src=" + PADR(ALLTRIM(loc_oG.Columns(loc_nI).ControlSource), 26) + ;
            " w=" + PADR(TRANSFORM(loc_oG.Columns(loc_nI).Width), 5) + ;
            " ctrl=" + ALLTRIM(loc_oG.Columns(loc_nI).CurrentControl) + CHR(13) + CHR(10), OUT, 1)
    ENDFOR
    DO Chk WITH "nenhum header default 'Header1'", ;
        (NOT ("HEADER1" $ UPPER(loc_oG.Column1.Header1.Caption + loc_oG.Column2.Header1.Caption + ;
         loc_oG.Column3.Header1.Caption + loc_oG.Column4.Header1.Caption + ;
         loc_oG.Column5.Header1.Caption + loc_oG.Column6.Header1.Caption)))
    DO Chk WITH "colunas O/A/C com CheckBox", ;
        (UPPER(ALLTRIM(loc_oG.Column3.CurrentControl)) == "CHECK1" AND ;
         UPPER(ALLTRIM(loc_oG.Column4.CurrentControl)) == "CHECK1" AND ;
         UPPER(ALLTRIM(loc_oG.Column5.CurrentControl)) == "CHECK1")
    STRTOFILE("   grid inicial -> " + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + " linha(s) de " + ;
        TRANSFORM(loc_nBase) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "GRID INICIAL: abre ja com os registros", (RECCOUNT("cursor_4c_Dados") = loc_nBase)
    DO Chk WITH "comeca na Lista com os botoes CRUD habilitados", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 1 AND loc_oP.cnt_4c_Botoes.cmd_4c_Incluir.Enabled)

    *================= 3) CRUD pelo FLUXO REAL ===============================
    STRTOFILE(CHR(13) + CHR(10) + "3) CRUD pelo fluxo real (Dopes = " + DOPESTESTE + ")" + CHR(13) + CHR(10), OUT, 1)

    *-- 3a) INCLUIR -> Page2 -> Confirmar
    loc_oF.BtnIncluirClick()
    STRTOFILE("   3a) INCLUIR -> ActivePage=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  modo=" + ALLTRIM(loc_oF.this_cModoAtual) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Incluir levou para a aba Dados em modo INCLUIR", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 2 AND loc_oF.this_cModoAtual == "INCLUIR")
    DO Chk WITH "campos limpos e editaveis", ;
        (EMPTY(loc_oD.txt_4c_Dopes.Value) AND !loc_oD.txt_4c_Dopes.ReadOnly)
    DO Chk WITH "Confirmar habilitado em INCLUIR, CRUD da Lista desabilitado", ;
        (loc_oD.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled AND !loc_oP.cnt_4c_Botoes.cmd_4c_Incluir.Enabled)

    loc_oD.txt_4c_Dopes.Value   = DOPESTESTE
    loc_oD.txt_4c_FPags.Value   = "CHEQUE"
    loc_oD.txt_4c_FPagss.Value  = "BOLETO PAG"
    loc_oD.chk_4c_Obrigs.Value  = 1
    loc_oD.chk_4c_Autos.Value   = 0
    loc_oD.chk_4c_Contabs.Value = 1
    loc_oF.BtnConfirmarClick()
    STRTOFILE("       apos Confirmar -> ActivePage=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  modo=" + ALLTRIM(loc_oF.this_cModoAtual) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Confirmar voltou para a Lista em modo LISTA", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 1 AND loc_oF.this_cModoAtual == "LISTA")
    DO Chk WITH "botoes CRUD REABILITADOS na volta (regra #40)", ;
        (loc_oP.cnt_4c_Botoes.cmd_4c_Incluir.Enabled AND loc_oP.cnt_4c_Botoes.cmd_4c_Excluir.Enabled)

    =SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cV1")
    STRTOFILE("       gravado: " + TRANSFORM(RECCOUNT("cV1")) + " linha(s)" + ;
        IIF(RECCOUNT("cV1") > 0, "  FPags=[" + ALLTRIM(NVL(cV1.FPags, "")) + "]" + ;
        " Obrigs=" + TRANSFORM(NVL(cV1.Obrigs, -1)) + " Autos=" + TRANSFORM(NVL(cV1.Autos, -1)) + ;
        " Contabs=" + TRANSFORM(NVL(cV1.Contabs, -1)) + ;
        " FPagss=[" + ALLTRIM(NVL(cV1.FPagss, "")) + "]" + ;
        " CidChaves=" + IIF(EMPTY(NVL(cV1.CidChaves, "")), "VAZIO", "gerado"), "") + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "GRAVACAO: 1 linha com os valores digitados", ;
        (RECCOUNT("cV1") = 1 AND ALLTRIM(NVL(cV1.FPags, "")) == "CHEQUE" AND ;
         NVL(cV1.Obrigs, -1) = 1 AND NVL(cV1.Autos, -1) = 0 AND NVL(cV1.Contabs, -1) = 1 AND ;
         ALLTRIM(NVL(cV1.FPagss, "")) == "BOLETO PAG")
    DO Chk WITH "GRAVACAO: CidChaves gerado (PK Fortyus)", (NOT EMPTY(ALLTRIM(NVL(cV1.CidChaves, ""))))
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cTot1")
    DO Chk WITH "GRAVACAO nao mexeu nas outras operacoes", (cTot1.t = loc_nBase + 1)
    DO Chk WITH "a Lista recarregou e ja mostra o novo registro", (RECCOUNT("cursor_4c_Dados") = loc_nBase + 1)

    *-- 3b) ALTERAR -> Page2 -> Confirmar
    SELECT cursor_4c_Dados
    LOCATE FOR ALLTRIM(Dopes) == DOPESTESTE
    DO Chk WITH "achou o registro na grade para alterar", FOUND()
    loc_oF.BtnAlterarClick()
    STRTOFILE("   3b) ALTERAR -> ActivePage=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  modo=" + ALLTRIM(loc_oF.this_cModoAtual) + ;
        "  campos=[" + ALLTRIM(loc_oD.txt_4c_Dopes.Value) + "/" + ALLTRIM(loc_oD.txt_4c_FPags.Value) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Alterar levou para Dados com o registro carregado", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 2 AND loc_oF.this_cModoAtual == "ALTERAR" AND ;
         ALLTRIM(loc_oD.txt_4c_Dopes.Value) == DOPESTESTE AND ;
         ALLTRIM(loc_oD.txt_4c_FPags.Value) == "CHEQUE" AND ;
         loc_oD.chk_4c_Obrigs.Value = 1)

    loc_oD.chk_4c_Obrigs.Value = 0
    loc_oD.chk_4c_Autos.Value  = 1
    loc_oD.txt_4c_FPagss.Value = "A RECEBER"
    loc_oF.BtnConfirmarClick()
    =SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cV2")
    STRTOFILE("       apos alterar: " + TRANSFORM(RECCOUNT("cV2")) + " linha(s)" + ;
        IIF(RECCOUNT("cV2") > 0, "  Obrigs=" + TRANSFORM(NVL(cV2.Obrigs, -1)) + ;
        " Autos=" + TRANSFORM(NVL(cV2.Autos, -1)) + " FPagss=[" + ALLTRIM(NVL(cV2.FPagss, "")) + "]", "") + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "ALTERACAO: valores atualizados, ainda 1 linha (UPDATE, nao INSERT)", ;
        (RECCOUNT("cV2") = 1 AND NVL(cV2.Obrigs, -1) = 0 AND NVL(cV2.Autos, -1) = 1 AND ;
         ALLTRIM(NVL(cV2.FPagss, "")) == "A RECEBER")
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cTot2")
    DO Chk WITH "ALTERACAO nao mexeu nas outras operacoes", (cTot2.t = loc_nBase + 1)

    *-- 3c) VISUALIZAR (so leitura)
    SELECT cursor_4c_Dados
    LOCATE FOR ALLTRIM(Dopes) == DOPESTESTE
    loc_oF.BtnVisualizarClick()
    STRTOFILE("   3c) VISUALIZAR -> ActivePage=" + TRANSFORM(loc_oF.pgf_4c_Paginas.ActivePage) + ;
        "  modo=" + ALLTRIM(loc_oF.this_cModoAtual) + ;
        "  ReadOnly=" + TRANSFORM(loc_oD.txt_4c_Dopes.ReadOnly) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "Visualizar abre Dados em SO LEITURA, sem Confirmar", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 2 AND loc_oF.this_cModoAtual == "VISUALIZAR" AND ;
         loc_oD.txt_4c_Dopes.ReadOnly AND !loc_oD.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled)
    loc_oF.BtnCancelarClick()
    DO Chk WITH "Cancelar voltou para a Lista", ;
        (loc_oF.pgf_4c_Paginas.ActivePage = 1 AND loc_oF.this_cModoAtual == "LISTA")

    *-- 3d) EXCLUIR. Em gb_4c_ModoTeste o MsgConfirma devolve .F. (nao ha quem
    *--     clique), entao o 1o BtnExcluirClick tem de ABORTAR - isso prova a
    *--     guarda de confirmacao. Depois exercitamos o caminho pos-confirmacao
    *--     pelo BO, que eh exatamente o que o botao faz quando o usuario aceita.
    SELECT cursor_4c_Dados
    LOCATE FOR ALLTRIM(Dopes) == DOPESTESTE
    loc_oF.BtnExcluirClick()
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cNo")
    DO Chk WITH "EXCLUSAO: respondendo NAO na confirmacao, nada eh apagado", (cNo.t = 1)

    SELECT cursor_4c_Dados
    LOCATE FOR ALLTRIM(Dopes) == DOPESTESTE
    IF loc_oF.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.CidChaves))
        DO Chk WITH "EXCLUSAO: Excluir() do BO devolveu .T.", loc_oF.this_oBusinessObject.Excluir()
        loc_oF.CarregarLista()
    ENDIF
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo WHERE Dopes = " + EscaparSQL(DOPESTESTE), "cV3")
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS t FROM SigOpFpo", "cTot3")
    STRTOFILE("   3d) EXCLUIR -> " + TRANSFORM(cV3.t) + " linha(s) de teste, " + ;
        TRANSFORM(cTot3.t) + " no total" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "EXCLUSAO: registro removido do banco", (cV3.t = 0)
    DO Chk WITH "EXCLUSAO nao mexeu nas outras operacoes", (cTot3.t = loc_nBase)

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
        "C:\4c\automation\probe_fpo258.txt", 1)
ENDPROC
