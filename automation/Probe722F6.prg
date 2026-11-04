*==============================================================================
* Probe722F6.prg - Instancia FormSigOpDmp (Fase 6, task722) e exercita o que a
* fase entregou: a linha Conta, a grade de fases, as celulas editaveis, os
* botoes Inserir/Excluir de linha, as validacoes de Ordem/E-S e os "When".
*
* NAO chama ConfigurarAmbiente() - ela BLOQUEIA nesta maquina. Carrega a mao
* so as dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe722f6_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cSai, loc_oE
loc_cSai = "C:\4c\automation\probe722f6.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("A: inicio" + CHR(13) + CHR(10), loc_cSai)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), loc_cSai, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + ;
                 gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDmpBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormSigOpDmp.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), loc_cSai, 1)

    STRTOFILE(Exercitar() + CHR(13) + CHR(10), loc_cSai, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha: " + ;
        TRANSFORM(loc_oE.LineNo) + " | Proc: " + loc_oE.Procedure + ;
        CHR(13) + CHR(10), loc_cSai, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cSai, 1)
ELSE
    STRTOFILE("DIALOGOS SUPRIMIDOS: nenhum" + CHR(13) + CHR(10), loc_cSai, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), loc_cSai, 1)
QUIT


FUNCTION Exercitar()
    LOCAL loc_oForm, loc_oPg2, loc_oGrid, loc_cO, loc_oE2, loc_oCel
    LOCAL loc_nI, loc_cNomes, loc_nLin, loc_cChave1
    loc_cO = ""

    TRY
        loc_oForm = CREATEOBJECT("FormSigOpDmp")
        IF VARTYPE(loc_oForm) != "O"
            loc_cO = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm)
        ELSE
            loc_cO = "CK01 instanciou OK" + CHR(13) + CHR(10)

            loc_oPg2  = loc_oForm.pgf_4c_Paginas.Page2
            loc_oGrid = loc_oPg2.grd_4c_Fases

            *-- 1. Geometria dos controles da Fase 6 (dump + 29 de compensacao)
            loc_cO = loc_cO + "CK02 lbl_4c_Conta       T/L/W/H = " + ;
                TRANSFORM(loc_oPg2.lbl_4c_Conta.Top) + "/" + ;
                TRANSFORM(loc_oPg2.lbl_4c_Conta.Left) + "/" + ;
                TRANSFORM(loc_oPg2.lbl_4c_Conta.Width) + "/" + ;
                TRANSFORM(loc_oPg2.lbl_4c_Conta.Height) + ;
                "  (esperado 228/125/86/15)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK03 txt_4c_Conta       T/L/W/H = " + ;
                TRANSFORM(loc_oPg2.txt_4c_Conta.Top) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Conta.Left) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Conta.Width) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Conta.Height) + ;
                "  MaxLen=" + TRANSFORM(loc_oPg2.txt_4c_Conta.MaxLength) + ;
                "  Fmt=[" + loc_oPg2.txt_4c_Conta.Format + "]" + ;
                "  (esperado 223/214/80/25 MaxLen=10 Fmt=K!)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK04 txt_4c_DConta      T/L/W/H = " + ;
                TRANSFORM(loc_oPg2.txt_4c_DConta.Top) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_DConta.Left) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_DConta.Width) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_DConta.Height) + ;
                "  MaxLen=" + TRANSFORM(loc_oPg2.txt_4c_DConta.MaxLength) + ;
                "  (esperado 223/294/271/25 MaxLen=40)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK05 grd_4c_Fases       T/L/W/H = " + ;
                TRANSFORM(loc_oGrid.Top) + "/" + TRANSFORM(loc_oGrid.Left) + "/" + ;
                TRANSFORM(loc_oGrid.Width) + "/" + TRANSFORM(loc_oGrid.Height) + ;
                "  Cols=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                "  RowH=" + TRANSFORM(loc_oGrid.RowHeight) + ;
                "  (esperado 254/108/492/260 Cols=5 RowH=20)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK06 cmd_4c_InserirFase T/L/W/H = " + ;
                TRANSFORM(loc_oPg2.cmd_4c_InserirFase.Top) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_InserirFase.Left) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_InserirFase.Width) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_InserirFase.Height) + ;
                "  PicFile=" + TRANSFORM(FILE(loc_oPg2.cmd_4c_InserirFase.Picture)) + ;
                "  (esperado 338/607/40/40 PicFile=.T.)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK07 cmd_4c_ExcluirFase T/L/W/H = " + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Top) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Left) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Width) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Height) + ;
                "  PicFile=" + TRANSFORM(FILE(loc_oPg2.cmd_4c_ExcluirFase.Picture)) + ;
                "  (esperado 381/607/40/40 PicFile=.T.)" + CHR(13) + CHR(10)

            *-- 2. Cursor de detalhe e vinculo da grade
            loc_cO = loc_cO + "CK08 cursor_4c_Fases USED=" + ;
                TRANSFORM(USED("cursor_4c_Fases")) + ;
                "  FCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Fases"), ;
                    FCOUNT("cursor_4c_Fases"), -1)) + ;
                "  (esperado .T. / 8)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK09 RecordSource=[" + loc_oGrid.RecordSource + "]" + ;
                CHR(13) + CHR(10)

            FOR loc_nI = 1 TO 5
                loc_cO = loc_cO + "CK10." + TRANSFORM(loc_nI) + " Col" + ;
                    TRANSFORM(loc_nI) + " CS=[" + ;
                    loc_oGrid.Columns(loc_nI).ControlSource + "]" + ;
                    " Hdr=[" + loc_oGrid.Columns(loc_nI).Header1.Caption + "]" + ;
                    " W=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Width) + ;
                    " CurCtrl=[" + loc_oGrid.Columns(loc_nI).CurrentControl + "]" + ;
                    " Sparse=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Sparse) + ;
                    " Cel=[" + loc_oGrid.Columns(loc_nI).txt_4c_Cel.this_cCelula + "]" + ;
                    " MaxLen=" + TRANSFORM(loc_oGrid.Columns(loc_nI).txt_4c_Cel.MaxLength) + ;
                    CHR(13) + CHR(10)
            ENDFOR

            *-- 3. Visibilidade dos metodos chamados de FORA (regra #51)
            *--    PEMSTATUS(...,2) = .T. significa PROTECTED -> defeito.
            loc_cNomes = "GradeFasesCelulaWhen,GradeFasesOrdemValid," + ;
                "GradeFasesFaseValid,GradeFasesFuncionarioValid," + ;
                "GradeFasesTpOpValid,GradeFasesEsValid," + ;
                "AbrirLookupFaseGrade,AbrirLookupFuncionarioGrade," + ;
                "AbrirLookupTpOpGrade,AtualizarEstadoCampos,VincularGradeFases," + ;
                "RepintarGradeFases,InserirLinhaFase,BtnInserirFaseClick," + ;
                "BtnExcluirFaseClick,ValidarGrupoLostFocus,ValidarDGrupoLostFocus," + ;
                "ValidarContaLostFocus,ValidarDContaLostFocus,ValidarNomeLostFocus," + ;
                "TxtGrupoKeyPress,TxtDGrupoKeyPress,TxtContaKeyPress," + ;
                "TxtDContaKeyPress,TxtGrupoDblClick,TxtDGrupoDblClick," + ;
                "TxtContaDblClick,TxtDContaDblClick,CarregarLista,AlternarPagina," + ;
                "AjustarBotoesPorModo"
            loc_cO = loc_cO + "CK11 visibilidade:" + CHR(13) + CHR(10) + ;
                ChecarPublicos(loc_oForm, loc_cNomes)

            *-- 4. Inserir linha de fase (InsiraRegGrade do legado)
            loc_oForm.this_cModoAtual   = "INCLUIR"
            loc_oPg2.txt_4c_Nome.Value  = "DEMO TESTE"
            loc_cO = loc_cO + "CK12 InserirLinhaFase=" + ;
                TRANSFORM(loc_oForm.InserirLinhaFase()) + ;
                "  RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Fases")) + ;
                CHR(13) + CHR(10)

            SELECT cursor_4c_Fases
            GO TOP
            loc_cO = loc_cO + "CK13 linha1 nome=[" + ALLTRIM(cursor_4c_Fases.nome) + ;
                "] cidchaves vazio=" + TRANSFORM(EMPTY(cursor_4c_Fases.cidchaves)) + ;
                " len=" + TRANSFORM(LEN(ALLTRIM(cursor_4c_Fases.cidchaves))) + ;
                " ordems=" + TRANSFORM(cursor_4c_Fases.ordems) + ;
                "  (cidchaves vazio tem de ser .F. - regra #22)" + CHR(13) + CHR(10)

            *-- 5. Botao Inserir de linha: segunda linha, cidchaves DIFERENTE
            loc_oForm.BtnInserirFaseClick()
            loc_cO = loc_cO + "CK14 apos BtnInserirFaseClick RECCOUNT=" + ;
                TRANSFORM(RECCOUNT("cursor_4c_Fases"))
            SELECT cursor_4c_Fases
            GO 1
            loc_cChave1 = ALLTRIM(cursor_4c_Fases.cidchaves)
            GO 2
            loc_cO = loc_cO + "  cidchaves distintas=" + ;
                TRANSFORM(loc_cChave1 != ALLTRIM(cursor_4c_Fases.cidchaves)) + ;
                "  (esperado .T.)" + CHR(13) + CHR(10)

            *-- 6. Botao Excluir de linha: volta a 1 linha viva
            loc_oForm.BtnExcluirFaseClick()
            loc_nLin = 0
            SELECT cursor_4c_Fases
            COUNT TO loc_nLin
            loc_cO = loc_cO + "CK15 apos BtnExcluirFaseClick linhas vivas=" + ;
                TRANSFORM(loc_nLin) + "  (esperado 1)" + CHR(13) + CHR(10)

            *-- 7. Guarda de modo dos botoes de linha (When do legado)
            loc_oForm.this_cModoAtual = "LISTA"
            SELECT cursor_4c_Fases
            COUNT TO loc_nI
            loc_oForm.BtnInserirFaseClick()
            SELECT cursor_4c_Fases
            COUNT TO loc_nLin
            loc_cO = loc_cO + "CK16 modo LISTA: Inserir ignorado=" + ;
                TRANSFORM(loc_nI = loc_nLin) + "  (esperado .T.)" + CHR(13) + CHR(10)
            loc_oForm.this_cModoAtual = "INCLUIR"

            *-- 8. "When" das celulas da grade
            loc_oForm.this_cModoAtual = "LISTA"
            loc_cO = loc_cO + "CK17 CelulaWhen LISTA=" + ;
                TRANSFORM(loc_oForm.GradeFasesCelulaWhen())
            loc_oForm.this_cModoAtual = "ALTERAR"
            loc_cO = loc_cO + " ALTERAR=" + ;
                TRANSFORM(loc_oForm.GradeFasesCelulaWhen()) + ;
                "  (esperado .F. / .T.)" + CHR(13) + CHR(10)

            *-- 9. Validacao da coluna Ordem (0..999)
            loc_oCel = CREATEOBJECT("CelulaFake")
            loc_oCel.Value = 1500
            loc_oForm.GradeFasesOrdemValid(loc_oCel)
            loc_cO = loc_cO + "CK18 Ordem 1500 -> " + TRANSFORM(loc_oCel.Value) + ;
                "  (esperado 0)" + CHR(13) + CHR(10)
            loc_oCel.Value = 7
            loc_oForm.GradeFasesOrdemValid(loc_oCel)
            loc_cO = loc_cO + "CK19 Ordem 7 -> " + TRANSFORM(loc_oCel.Value) + ;
                "  (esperado 7)" + CHR(13) + CHR(10)

            *-- 10. Validacao da coluna E/S (E,S,P,H,T)
            loc_oCel.Value = "X"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "CK20 E/S [X] -> [" + TRANSFORM(loc_oCel.Value) + ;
                "]  (esperado espaco)" + CHR(13) + CHR(10)
            loc_oCel.Value = "h"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "CK21 E/S [h] -> [" + TRANSFORM(loc_oCel.Value) + ;
                "]  (esperado H)" + CHR(13) + CHR(10)
            loc_oCel.Value = "T"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "CK22 E/S [T] -> [" + TRANSFORM(loc_oCel.Value) + ;
                "]  (esperado T)" + CHR(13) + CHR(10)
            loc_cO = loc_cO + "CK23 operas gravado no cursor=[" + ;
                ALLTRIM(cursor_4c_Fases.operas) + "]  (esperado T)" + ;
                CHR(13) + CHR(10)

            *-- 11. Lookups sem conexao: nao podem estourar nem abrir dialogo
            loc_oPg2.txt_4c_Grupo.Value = "ZZZ"
            loc_oForm.ValidarGrupoLostFocus()
            loc_oPg2.txt_4c_Conta.Value = "ZZZ"
            loc_oForm.ValidarContaLostFocus()
            loc_oPg2.txt_4c_DGrupo.Value = "ZZZ"
            loc_oForm.ValidarDGrupoLostFocus()
            loc_oForm.TxtGrupoKeyPress(115, 0)
            loc_oForm.TxtGrupoKeyPress(65, 0)
            loc_oForm.TxtContaDblClick()
            loc_oCel.Value = "ZZZ"
            loc_oForm.GradeFasesFaseValid(loc_oCel)
            loc_oForm.GradeFasesFuncionarioValid(loc_oCel)
            loc_oForm.GradeFasesTpOpValid(loc_oCel)
            loc_cO = loc_cO + "CK24 lookups sem conexao: nenhuma excecao" + ;
                CHR(13) + CHR(10)

            *-- 12. ELSE do legado: codigo vazio limpa a descricao
            loc_oPg2.txt_4c_Grupo.Value  = ""
            loc_oPg2.txt_4c_DGrupo.Value = "SOBROU"
            loc_oForm.ValidarGrupoLostFocus()
            loc_cO = loc_cO + "CK25 Grupo vazio -> DGrupo=[" + ;
                ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value) + "]  (esperado vazio)" + ;
                CHR(13) + CHR(10)

            *-- 13. "When" dos campos (AtualizarEstadoCampos)
            loc_oForm.this_cModoAtual   = "ALTERAR"
            loc_oPg2.txt_4c_Grupo.Value = ""
            loc_oPg2.txt_4c_Conta.Value = ""
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "CK26 ALTERAR cod vazio: Grupo.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Grupo.ReadOnly) + ;
                " DGrupo.RO=" + TRANSFORM(loc_oPg2.txt_4c_DGrupo.ReadOnly) + ;
                " Conta.RO=" + TRANSFORM(loc_oPg2.txt_4c_Conta.ReadOnly) + ;
                " DConta.RO=" + TRANSFORM(loc_oPg2.txt_4c_DConta.ReadOnly) + ;
                "  (esperado .F./.F./.F./.F.)" + CHR(13) + CHR(10)

            loc_oPg2.txt_4c_Grupo.Value = "G1"
            loc_oPg2.txt_4c_Conta.Value = "C1"
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "CK27 ALTERAR cod cheio: DGrupo.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_DGrupo.ReadOnly) + ;
                " DConta.RO=" + TRANSFORM(loc_oPg2.txt_4c_DConta.ReadOnly) + ;
                "  (esperado .T./.T.)" + CHR(13) + CHR(10)

            loc_oForm.this_cModoAtual = "LISTA"
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "CK28 LISTA: Grupo.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Grupo.ReadOnly) + ;
                " Conta.RO=" + TRANSFORM(loc_oPg2.txt_4c_Conta.ReadOnly) + ;
                "  (esperado .T./.T.)" + CHR(13) + CHR(10)

            *-- 14. Ordem de tabulacao (dump: Grupo_Salva=1 .. Excluir=12)
            loc_cO = loc_cO + "CK29 TabIndex Salva/Nome/Grupo/DGrupo/Conta/" + ;
                "DConta/Lbl2/Grade/Ins/Exc = " + ;
                TRANSFORM(loc_oPg2.cnt_4c_Salva.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Grupo.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_DGrupo.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_Conta.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.txt_4c_DConta.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.lbl_4c_Conta.TabIndex) + "/" + ;
                TRANSFORM(loc_oGrid.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_InserirFase.TabIndex) + "/" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.TabIndex) + ;
                "  (esperado 1/4/5/6/7/8/9/10/11/12)" + CHR(13) + CHR(10)

            *-- 15. Nenhum controle de dados soterrado pela faixa (regra #11)
            loc_cO = loc_cO + "CK30 menor Top dos campos da ficha = " + ;
                TRANSFORM(MIN(loc_oPg2.txt_4c_Nome.Top, ;
                    MIN(loc_oPg2.txt_4c_Grupo.Top, ;
                    MIN(loc_oPg2.txt_4c_Conta.Top, loc_oGrid.Top)))) + ;
                "  (tem de ser >= 109)" + CHR(13) + CHR(10)

            *-- 16. Nenhum controle fora da area da Page (regra #30)
            loc_cO = loc_cO + "CK31 Grade dir=" + ;
                TRANSFORM(loc_oGrid.Left + loc_oGrid.Width) + ;
                " Excluir dir=" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Left + ;
                          loc_oPg2.cmd_4c_ExcluirFase.Width) + ;
                " Form.Width=" + TRANSFORM(loc_oForm.Width) + ;
                " Excluir base=" + ;
                TRANSFORM(loc_oPg2.cmd_4c_ExcluirFase.Top + ;
                          loc_oPg2.cmd_4c_ExcluirFase.Height) + ;
                " Form.Height=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

            *-- 17. AlternarPagina (funil que reabilita os botoes - regra #40)
            loc_oForm.AlternarPagina(2)
            loc_cO = loc_cO + "CK32 AlternarPagina(2) modo=[" + ;
                loc_oForm.this_cModoAtual + "] ActivePage=" + ;
                TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10)
            loc_oForm.AlternarPagina(1)
            loc_cO = loc_cO + "CK33 AlternarPagina(1) modo=[" + ;
                loc_oForm.this_cModoAtual + "] Incluir.Enabled=" + ;
                TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
                "  (esperado LISTA / .T.)" + CHR(13) + CHR(10)

            loc_oForm.Release()
            loc_cO = loc_cO + "CK34 Release OK" + CHR(13) + CHR(10)
        ENDIF

    CATCH TO loc_oE2
        loc_cO = loc_cO + "EXCEPTION NO EXERCICIO: " + loc_oE2.Message + ;
            " | Linha: " + TRANSFORM(loc_oE2.LineNo) + ;
            " | Proc: " + loc_oE2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_cO
ENDFUNC


FUNCTION ChecarPublicos(par_oForm, par_cNomes)
    LOCAL loc_nI, loc_cNome, loc_cOut, loc_nQtd, loc_cRuins
    loc_cOut   = ""
    loc_cRuins = ""
    loc_nQtd   = 0

    FOR loc_nI = 1 TO GETWORDCOUNT(par_cNomes, ",")
        loc_cNome = ALLTRIM(GETWORDNUM(par_cNomes, loc_nI, ","))
        loc_nQtd  = loc_nQtd + 1

        IF !PEMSTATUS(par_oForm, loc_cNome, 5)
            loc_cRuins = loc_cRuins + "     AUSENTE: " + loc_cNome + ;
                CHR(13) + CHR(10)
        ELSE
            IF PEMSTATUS(par_oForm, loc_cNome, 2)
                loc_cRuins = loc_cRuins + "     PROTECTED: " + loc_cNome + ;
                    CHR(13) + CHR(10)
            ENDIF
        ENDIF
    ENDFOR

    loc_cOut = "     " + TRANSFORM(loc_nQtd) + " metodos conferidos; " + ;
        IIF(EMPTY(loc_cRuins), "TODOS existem e sao PUBLIC", "PROBLEMAS:") + ;
        CHR(13) + CHR(10) + loc_cRuins

    RETURN loc_cOut
ENDFUNC


*-- Objeto minimo para exercitar os Valid de celula sem a grade no caminho
DEFINE CLASS CelulaFake AS Custom
    Value = ""
ENDDEFINE
