*==============================================================================
* ProbePpp666F8.prg - Probe funcional da Fase 8 de FormSigPrPpp (task666)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA com o contrato do chamador (form pai + DataSessionId)
*      e cria os 5 campos de exibicao, as 2 grades e o botao Encerrar
*   2) adocao da DataSession do pai (Init) - sem ela TprMvCab fica invisivel
*   3) escopos: CarregarLista / RepintarGrades /
*      GradeOperacoesAfterRowColChange / CmdEncerrarClick tem de ser PUBLIC
*      (chamados de fora / alvos de BINDEVENT - regra #3/#51)
*   4) TODO campo e TODA grade somente-leitura (o legado declara os 5
*      "PROCEDURE When / Return .f." e Grid/ColumnN.ReadOnly = .T.)
*   5) binding das 2 grades (RecordSource/ColumnCount/ControlSource)
*   6) CarregarFiltrosDoFormPai: os 5 .Value vem do BO do form PAI
*   7) CarregarLista popula a grade MESTRE a partir de TprMvCab, na ordem
*      emps/dopes/numes, e repinta sem estourar
*   8) GradeOperacoesAfterRowColChange respeita o guard por LINHA do legado
*      (ThisForm.LinhaAnterior) e le a linha corrente para o BO
*   9) MontarChaveEmpDopNums devolve 29 chars POSICIONAIS (regra #42)
*  10) CmdEncerrarClick reabilita o form pai (grp_operacao.cmd_sair.Click)
*
* NAO chama Show(): o form eh modal em producao e travaria o harness.
* Sem conexao SQL (gnConnHandle = -1) a carga dos ITENS falha de proposito -
* o que se mede eh que a grade MESTRE carrega e que nada estoura.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
#DEFINE OUT "C:\4c\automation\probe_ppp666_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_oPai, loc_cL, loc_nFalhas, loc_oE, loc_cCur
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigPrPpp (task666) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    *-- Depois do config.prg (ele reseta as flags de teste).
    gb_4c_ModoTeste        = .T.
    gb_4c_ValidandoUI      = .F.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ppp666.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    gnConnHandle           = -1
    IF FILE(gc_4c_ArquivoErroTeste)
        DELETE FILE (gc_4c_ArquivoErroTeste)
    ENDIF

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPPPBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPPP.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbePpp666F8.prg"    ADDITIVE

    *-- Cursor que o form PAI deixa pronto, na sessao CORRENTE. O form
    *-- filho tem de adotar esta sessao para enxerga-lo.
    IF USED("TprMvCab")
        USE IN TprMvCab
    ENDIF
    CREATE CURSOR TprMvCab (emps C(3), dopes C(20), numes N(6,0), datas D, valos N(14,2))
    INSERT INTO TprMvCab (emps, dopes, numes, datas, valos) VALUES ("001", "MALOTE",  3, {^2026-03-10}, 150.00)
    INSERT INTO TprMvCab (emps, dopes, numes, datas, valos) VALUES ("001", "ENTRADA", 7, {^2026-04-02}, 999.90)
    INSERT INTO TprMvCab (emps, dopes, numes, datas, valos) VALUES ("001", "MALOTE",  1, {^2026-02-01},  10.00)

    loc_oPai = CREATEOBJECT("PaiPppFake")

    *-- 1) instanciacao com o contrato do chamador
    loc_oForm = CREATEOBJECT("ProbePppF8", loc_oPai, loc_oPai.DataSessionId)
    loc_cL = "1) CREATEOBJECT(form, pai, dsid) -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE(loc_cL + "   *** NAO ABRIU" + CHR(13)+CHR(10) + "PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_cL = loc_cL + "   Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height) + ;
        " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)+CHR(10) + ;
        "   campos: Grupo=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_Grupo",5)) + ;
        " Conta=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c__cliente",5)) + ;
        " ContaDesc=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c__cliente_desc",5)) + ;
        " DtIni=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c__dt_inicial",5)) + ;
        " DtFim=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c__dt_final",5)) + CHR(13)+CHR(10) + ;
        "   grades: Operacoes=" + TRANSFORM(PEMSTATUS(loc_oForm,"grd_4c_Operacoes",5)) + ;
        " Itens=" + TRANSFORM(PEMSTATUS(loc_oForm,"grd_4c_Itens",5)) + ;
        "   botao=" + TRANSFORM(PEMSTATUS(loc_oForm,"cmg_4c_Grp_operacao",5)) + ;
        "   cabecalho=" + TRANSFORM(PEMSTATUS(loc_oForm,"cnt_4c_Cabecalho",5)) + CHR(13)+CHR(10)
    IF !PEMSTATUS(loc_oForm,"txt_4c_Grupo",5) OR !PEMSTATUS(loc_oForm,"txt_4c__cliente",5) ;
       OR !PEMSTATUS(loc_oForm,"txt_4c__cliente_desc",5) OR !PEMSTATUS(loc_oForm,"txt_4c__dt_inicial",5) ;
       OR !PEMSTATUS(loc_oForm,"txt_4c__dt_final",5) OR !PEMSTATUS(loc_oForm,"grd_4c_Operacoes",5) ;
       OR !PEMSTATUS(loc_oForm,"grd_4c_Itens",5) OR !PEMSTATUS(loc_oForm,"cmg_4c_Grp_operacao",5)
        loc_cL = loc_cL + "   *** FALHA: superficie incompleta" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) adocao da DataSession do pai
    loc_cL = "2) DataSession: form.DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
        " pai=" + TRANSFORM(loc_oPai.DataSessionId) + ;
        "   USED(TprMvCab) de dentro da sessao do form=" + TRANSFORM(loc_oForm.TesteUsed("TprMvCab")) + CHR(13)+CHR(10)
    IF loc_oForm.DataSessionId != loc_oPai.DataSessionId OR !loc_oForm.TesteUsed("TprMvCab")
        loc_cL = loc_cL + "   *** FALHA: o form nao enxerga o cursor do pai" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos (atributo 2 = Protected). Todos tem de ser PUBLIC.
    loc_cL = "3) escopos (Prot=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   CarregarLista                   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2))                   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   RepintarGrades                  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"RepintarGrades",2))                  + " esperado .F." + CHR(13)+CHR(10) + ;
        "   GradeOperacoesAfterRowColChange Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"GradeOperacoesAfterRowColChange",2)) + " esperado .F." + CHR(13)+CHR(10) + ;
        "   CmdEncerrarClick                Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CmdEncerrarClick",2))                + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BO.CarregarOperacoes            Prot=" + TRANSFORM(PEMSTATUS(loc_oBO,"CarregarOperacoes",2))                 + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BO.CarregarDoCursor             Prot=" + TRANSFORM(PEMSTATUS(loc_oBO,"CarregarDoCursor",2))                  + " esperado .F." + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"CarregarLista",2) OR PEMSTATUS(loc_oForm,"RepintarGrades",2) ;
       OR PEMSTATUS(loc_oForm,"GradeOperacoesAfterRowColChange",2) OR PEMSTATUS(loc_oForm,"CmdEncerrarClick",2) ;
       OR PEMSTATUS(loc_oBO,"CarregarOperacoes",2) OR PEMSTATUS(loc_oBO,"CarregarDoCursor",2)
        loc_cL = loc_cL + "   *** FALHA de escopo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) somente-leitura (PILAR 1: os 5 "When -> Return .f." + grades)
    loc_cL = "4) somente-leitura:" + CHR(13)+CHR(10) + ;
        "   Grupo=" + TRANSFORM(loc_oForm.txt_4c_Grupo.ReadOnly) + ;
        " Conta=" + TRANSFORM(loc_oForm.txt_4c__cliente.ReadOnly) + ;
        " ContaDesc=" + TRANSFORM(loc_oForm.txt_4c__cliente_desc.ReadOnly) + ;
        " DtIni=" + TRANSFORM(loc_oForm.txt_4c__dt_inicial.ReadOnly) + ;
        " DtFim=" + TRANSFORM(loc_oForm.txt_4c__dt_final.ReadOnly) + CHR(13)+CHR(10) + ;
        "   grdOperacoes=" + TRANSFORM(loc_oForm.grd_4c_Operacoes.ReadOnly) + ;
        " grdItens=" + TRANSFORM(loc_oForm.grd_4c_Itens.ReadOnly) + CHR(13)+CHR(10)
    IF !loc_oForm.txt_4c_Grupo.ReadOnly OR !loc_oForm.txt_4c__cliente.ReadOnly ;
       OR !loc_oForm.txt_4c__cliente_desc.ReadOnly OR !loc_oForm.txt_4c__dt_inicial.ReadOnly ;
       OR !loc_oForm.txt_4c__dt_final.ReadOnly ;
       OR !loc_oForm.grd_4c_Operacoes.ReadOnly OR !loc_oForm.grd_4c_Itens.ReadOnly
        loc_cL = loc_cL + "   *** FALHA: ha controle digitavel numa tela somente-leitura" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) binding das grades
    loc_cL = "5) binding:" + CHR(13)+CHR(10) + ;
        "   grdOperacoes RecordSource=[" + loc_oForm.grd_4c_Operacoes.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Operacoes.ColumnCount) + " esperado 5" + CHR(13)+CHR(10) + ;
        "      cols=[" + loc_oForm.grd_4c_Operacoes.Column1.ControlSource + "][" + ;
        loc_oForm.grd_4c_Operacoes.Column2.ControlSource + "][" + ;
        loc_oForm.grd_4c_Operacoes.Column3.ControlSource + "][" + ;
        loc_oForm.grd_4c_Operacoes.Column4.ControlSource + "][" + ;
        loc_oForm.grd_4c_Operacoes.Column5.ControlSource + "]" + CHR(13)+CHR(10) + ;
        "   grdItens RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Itens.ColumnCount) + " esperado 3" + CHR(13)+CHR(10) + ;
        "      cols=[" + loc_oForm.grd_4c_Itens.Column1.ControlSource + "][" + ;
        loc_oForm.grd_4c_Itens.Column2.ControlSource + "][" + ;
        loc_oForm.grd_4c_Itens.Column3.ControlSource + "]" + CHR(13)+CHR(10)
    IF loc_oForm.grd_4c_Operacoes.ColumnCount != 5 OR loc_oForm.grd_4c_Itens.ColumnCount != 3 ;
       OR EMPTY(loc_oForm.grd_4c_Operacoes.RecordSource) OR EMPTY(loc_oForm.grd_4c_Itens.RecordSource) ;
       OR EMPTY(loc_oForm.grd_4c_Operacoes.Column5.ControlSource) ;
       OR EMPTY(loc_oForm.grd_4c_Itens.Column3.ControlSource)
        loc_cL = loc_cL + "   *** FALHA de binding" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) os 5 campos de exibicao vieram do BO do form PAI (Fase 6/8)
    loc_cL = "6) filtros herdados do pai:" + CHR(13)+CHR(10) + ;
        "   Grupo=[" + ALLTRIM(loc_oForm.txt_4c_Grupo.Value) + "] esperado [G01]" + CHR(13)+CHR(10) + ;
        "   Conta=[" + ALLTRIM(loc_oForm.txt_4c__cliente.Value) + "] esperado [11101]" + CHR(13)+CHR(10) + ;
        "   ContaDesc=[" + ALLTRIM(loc_oForm.txt_4c__cliente_desc.Value) + "] esperado [CLIENTE DE TESTE]" + CHR(13)+CHR(10) + ;
        "   DtIni=" + DTOC(loc_oForm.txt_4c__dt_inicial.Value) + " DtFim=" + DTOC(loc_oForm.txt_4c__dt_final.Value) + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_Grupo.Value) != "G01" ;
       OR ALLTRIM(loc_oForm.txt_4c__cliente.Value) != "11101" ;
       OR ALLTRIM(loc_oForm.txt_4c__cliente_desc.Value) != "CLIENTE DE TESTE" ;
       OR loc_oForm.txt_4c__dt_inicial.Value != {^2026-01-01} ;
       OR loc_oForm.txt_4c__dt_final.Value != {^2026-12-31}
        loc_cL = loc_cL + "   *** FALHA: os filtros do pai nao chegaram na tela" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) CarregarLista popula a grade MESTRE a partir de TprMvCab
    loc_cCur = ALLTRIM(loc_oBO.this_cCursorOperacoes)
    loc_oForm.CarregarLista()
    loc_cL = "7) CarregarLista (grade MESTRE):" + CHR(13)+CHR(10) + ;
        "   RECCOUNT(" + loc_cCur + ")=" + TRANSFORM(loc_oForm.TesteReccount(loc_cCur)) + " esperado 3" + CHR(13)+CHR(10) + ;
        "   1a linha (ORDER BY emps,dopes,numes) -> [" + loc_oForm.TesteCampo(loc_cCur, "dopes") + "] numes=" + ;
        TRANSFORM(loc_oForm.TesteCampoN(loc_cCur, "numes")) + "  esperado [ENTRADA] 7" + CHR(13)+CHR(10) + ;
        "   MousePointer apos a carga=" + TRANSFORM(loc_oForm.MousePointer) + " esperado 0" + ;
        "   LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + " esperado .F." + CHR(13)+CHR(10)
    IF loc_oForm.TesteReccount(loc_cCur) != 3 ;
       OR ALLTRIM(loc_oForm.TesteCampo(loc_cCur, "dopes")) != "ENTRADA" ;
       OR loc_oForm.TesteCampoN(loc_cCur, "numes") != 7 ;
       OR loc_oForm.MousePointer != 0 OR loc_oForm.LockScreen
        loc_cL = loc_cL + "   *** FALHA na carga da grade mestre" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) guard por LINHA do AfterRowColChange (ThisForm.LinhaAnterior)
    loc_oForm.this_nLinhaAnterior = loc_oForm.grd_4c_Operacoes.ActiveRow
    loc_oBO.this_cDopes = "SENTINELA"
    loc_oForm.GradeOperacoesAfterRowColChange(2)
    loc_cL = "8) AfterRowColChange:" + CHR(13)+CHR(10) + ;
        "   mesma LINHA (so trocou de coluna) -> BO.this_cDopes=[" + ALLTRIM(loc_oBO.this_cDopes) + ;
        "] esperado [SENTINELA] (nao recarrega)" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oBO.this_cDopes) != "SENTINELA"
        loc_cL = loc_cL + "   *** FALHA: recarregou sem o usuario mudar de linha" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.this_nLinhaAnterior = -1
    loc_oForm.GradeOperacoesAfterRowColChange(1)
    loc_cL = loc_cL + "   LINHA diferente -> BO.this_cDopes=[" + ALLTRIM(loc_oBO.this_cDopes) + ;
        "] this_nNumes=" + TRANSFORM(loc_oBO.this_nNumes) + "  esperado [ENTRADA] 7" + CHR(13)+CHR(10) + ;
        "   this_nLinhaAnterior=" + TRANSFORM(loc_oForm.this_nLinhaAnterior) + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oBO.this_cDopes) != "ENTRADA" OR loc_oBO.this_nNumes != 7
        loc_cL = loc_cL + "   *** FALHA: nao leu a linha corrente para o BO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) chave POSICIONAL de 29 chars (regra #42)
    loc_cL = "9) MontarChaveEmpDopNums 001/MALOTE/3:" + CHR(13)+CHR(10) + ;
        "   LEN=" + TRANSFORM(LEN(loc_oBO.MontarChaveEmpDopNums("001", "MALOTE", 3))) + " esperado 29" + ;
        "   valor=[" + loc_oBO.MontarChaveEmpDopNums("001", "MALOTE", 3) + "]" + CHR(13)+CHR(10)
    IF LEN(loc_oBO.MontarChaveEmpDopNums("001", "MALOTE", 3)) != 29
        loc_cL = loc_cL + "   *** FALHA: chave posicional com largura errada" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 10) CmdEncerrarClick reabilita o pai. Por ultimo: faz Release().
    loc_oPai.Enabled = .F.
    loc_oForm.CmdEncerrarClick()
    loc_cL = "10) CmdEncerrarClick -> pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + " esperado .T." + ;
        "   SetFocus no campo Conta do pai=" + TRANSFORM(loc_oPai.txt_4c_Conta.this_lFocado) + CHR(13)+CHR(10)
    IF !loc_oPai.Enabled OR !loc_oPai.txt_4c_Conta.this_lFocado
        loc_cL = loc_cL + "   *** FALHA: nao devolveu o controle ao form pai" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    IF FILE(gc_4c_ArquivoErroTeste)
        STRTOFILE(CHR(13)+CHR(10) + "--- mensagens suprimidas em ModoTeste ---" + CHR(13)+CHR(10) + ;
            FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
    ENDIF

    STRTOFILE(CHR(13)+CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13)+CHR(10) + "PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

QUIT

*-- Subclasse de sondagem: le cursores DENTRO da DataSession do form (um
*-- script solto le na sessao dele, nao na do form - sem isto o teste da
*-- grade mediria a sessao errada).
DEFINE CLASS ProbePppF8 AS FormSigPrPpp
    FUNCTION TesteUsed(par_cAlias)
        RETURN USED(par_cAlias)
    ENDFUNC
    FUNCTION TesteReccount(par_cAlias)
        RETURN IIF(USED(par_cAlias), RECCOUNT(par_cAlias), -1)
    ENDFUNC
    FUNCTION TesteCampo(par_cAlias, par_cCampo)
        LOCAL loc_x
        loc_x = ""
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            GO TOP
            loc_x = EVALUATE(par_cAlias + "." + par_cCampo)
        ENDIF
        RETURN loc_x
    ENDFUNC
    FUNCTION TesteCampoN(par_cAlias, par_cCampo)
        LOCAL loc_n
        loc_n = -1
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            GO TOP
            loc_n = EVALUATE(par_cAlias + "." + par_cCampo)
        ENDIF
        RETURN loc_n
    ENDFUNC
ENDDEFINE

*-- Duble do form PAI (FormSigPrPpc), com a MESMA superficie que o filho
*-- consome: DataSessionId, Enabled, this_oBusinessObject (os 5 filtros) e
*-- txt_4c_Conta. Classe Container (nao Empty): Empty nao aceita AddObject.
DEFINE CLASS PaiPppFake AS Container
    this_oBusinessObject = .NULL.
    PROCEDURE Init()
        THIS.AddProperty("DataSessionId", SET("DataSession"))
        THIS.this_oBusinessObject = CREATEOBJECT("BOPppFake")
        THIS.AddObject("txt_4c_Conta", "TxtPppFake")
        RETURN .T.
    ENDPROC
ENDDEFINE

DEFINE CLASS BOPppFake AS Custom
    this_cGrupo     = "G01"
    this_cConta     = "11101"
    this_cContaDesc = "CLIENTE DE TESTE"
    this_dInicial   = {^2026-01-01}
    this_dFinal     = {^2026-12-31}
ENDDEFINE

DEFINE CLASS TxtPppFake AS TextBox
    this_lFocado = .F.
    PROCEDURE SetFocus()
        THIS.this_lFocado = .T.
    ENDPROC
ENDDEFINE
