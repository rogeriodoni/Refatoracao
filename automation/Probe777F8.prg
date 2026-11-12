*==============================================================================
* Probe777F8.prg - Probe da Fase 8 de FormSigOpPcu (task777)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com o cursor csGrade do "pai" aberto nesta sessao
*   2) as quatro propriedades de janela transcritas do dump estao vivas no
*      objeto (BorderStyle=2 / TitleBar=0 / ControlBox=.F. / ClipControls=.F.)
*      - com elas nao ha "X", logo nao ha saida que escape do funil
*      FecharDialogo e deixe de montar o cursor de resultado
*   3) a GRADE RECEBEU DADO - RecordSource, os 7 ControlSource, e as Width e
*      os Header1.Caption SOBREVIVENDO ao RecordSource (Problema 48)
*   4) o filtro do legado ("Set Key To pTipo") esta aplicado: so as linhas do
*      tipo pedido ficam visiveis, e o total do rodape bate com a soma de
*      Valos DELAS
*   5) as travas de coluna do legado ("When -> Return .f." em 6 colunas, e a
*      7a condicionada ao tipo): Column1/2/3/5/6/7 ReadOnly e Column4 nao
*   6) os titulos do Init legado (faixa do cabecalho com o Caption ORIGINAL,
*      Caption do form com o produto, subtitulo com "(Fator)"/"(Venda)")
*   7) a FORMULA do Column4.Valid legado, transcrita (regra #17), medida
*      valor a valor - inclusive AltCoef/CidChaves e o recalculo do acumulado
*   8) o ENTREGAVEL: FecharDialogo monta crPrFtp SO com as linhas alteradas e
*      DESFAZ o "Set Key To" (o cursor volta ao pai como ele o entregou)
*   9) escopo REAL dos metodos (PEMSTATUS ...,5 = existe / ...,2 = Protected):
*      os que o harness/probe chamam de fora tem de ser PUBLIC (regras #3/#51)
*
* Toda chamada vai em TRY/CATCH proprio - sem isso um Program Error abre
* dialogo que ninguem fecha e o probe pendura MUDO.
*
* O form tem DataSession = 1 (compartilha a sessao de quem o cria), entao os
* cursores montados AQUI sao exatamente os que ele enxerga - eh essa a
* traducao do par "DataSession = 2 + Set DataSession to pnDataSes" do legado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT "C:\4c\automation\probe_777f8.txt"

LOCAL loc_oE, loc_oForm, loc_oPai, loc_oGrd, loc_nVis, loc_nSoma, loc_cTxt
LOCAL loc_nAlt, loc_nTot, loc_nAcu, loc_nValEsp

STRTOFILE("=== PROBE Fase 8 - FormSigOpPcu (task777) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_777f8.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpPcuBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpPcu.prg") ADDITIVE

    gnConnHandle = -1

    *--------------------------------------------------------------------
    * Cursores que no legado o form PAI (SIGCDPRO) deixa abertos na MESMA
    * sessao. Estrutura e TAG transcritas do dump do pai
    * (tasks\task003\SIGCDPRO_form_codigo_fonte.txt, linhas 18017-18019).
    *
    * Tres linhas "V" (planilha de Venda) e duas "C" (Fator) - o filtro
    * "Set Key To" tem de deixar so as tres de "V" visiveis.
    *--------------------------------------------------------------------
    CREATE CURSOR CsGrade (Tipos c(1), Ordem n(3), Cpros c(14), Dpros c(30), ;
        Totas n(12,3), Coefs n(8,4), Valos n(12,3), TotalG n(12,3), ;
        Acumulas n(12,3), cGrus c(3), cods c(2), CidChaves c(20), ;
        AltCoef n(1,0), Sgrus c(6))

    INSERT INTO CsGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, cGrus, cods, AltCoef) ;
        VALUES ("V", 1, "PROD001", "PRODUTO UM", 100.000, 1.5000, 50.000, 150.000, 150.000, "001", "01", 0)
    INSERT INTO CsGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, cGrus, cods, AltCoef) ;
        VALUES ("V", 2, "PROD002", "PRODUTO DOIS", 200.000, 2.0000, 200.000, 400.000, 550.000, "001", "02", 0)
    INSERT INTO CsGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, cGrus, cods, AltCoef) ;
        VALUES ("V", 3, "PROD003", "PRODUTO TRES", 300.000, 1.0000, 0.000, 300.000, 850.000, "002", "03", 0)
    INSERT INTO CsGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, cGrus, cods, AltCoef) ;
        VALUES ("C", 1, "PROD004", "PRODUTO QUATRO", 400.000, 1.2000, 80.000, 480.000, 480.000, "003", "04", 0)
    INSERT INTO CsGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, cGrus, cods, AltCoef) ;
        VALUES ("C", 2, "PROD005", "PRODUTO CINCO", 500.000, 1.1000, 50.000, 550.000, 1030.000, "003", "05", 0)

    INDEX ON Tipos + STR(Ordem, 3) + Cpros TAG Ordem

    CREATE CURSOR CrSigCdPro (Cpros c(14), Dpros c(30))
    INSERT INTO CrSigCdPro VALUES ("PROD-PAI", "CAMISA SOCIAL BRANCA")

    STRTOFILE("csGrade montado: " + TRANSFORM(RECCOUNT("CsGrade")) + " linhas" + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("FALHA no setup: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*-- "Pai" minimo: o form so precisa responder a .Enabled
loc_oPai = .NULL.
TRY
    loc_oPai = CREATEOBJECT("Form")
CATCH TO loc_oE
    STRTOFILE("FALHA ao criar o pai: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 1) INSTANCIACAO
*==============================================================================
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpPcu", loc_oPai, SET("DATASESSION"), "V")
    STRTOFILE("[1] CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[1] FALHA: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              " / " + loc_oE.Procedure + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    STRTOFILE("ABORTADO - form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    QUIT
ENDIF

*==============================================================================
* 2) PROPRIEDADES DE JANELA (dump: BorderStyle=2 TitleBar=0 ControlBox=.F.)
*==============================================================================
TRY
    STRTOFILE("[2] BorderStyle=" + TRANSFORM(loc_oForm.BorderStyle) + ;
              "  TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
              "  ControlBox=" + TRANSFORM(loc_oForm.ControlBox) + ;
              "  ClipControls=" + TRANSFORM(loc_oForm.ClipControls) + ;
              "  WindowType=" + TRANSFORM(loc_oForm.WindowType) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[2] FALHA: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 3) BIND DA GRADE + Width/Caption sobrevivendo ao RecordSource
*==============================================================================
TRY
    loc_oGrd = loc_oForm.cnt_4c__Planilha.grd_4c_Dados
    STRTOFILE("[3] ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
              "  RecordSource=[" + loc_oGrd.RecordSource + "]" + CHR(13) + CHR(10), OUT, 1)
    loc_cTxt = ""
    FOR loc_nVis = 1 TO 7
        loc_cTxt = loc_cTxt + "    Col" + TRANSFORM(loc_nVis) + ;
            " CS=[" + EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nVis) + ".ControlSource") + "]" + ;
            " W=" + TRANSFORM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nVis) + ".Width")) + ;
            " Hdr=[" + EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nVis) + ".Header1.Caption") + "]" + ;
            " RO=" + TRANSFORM(EVALUATE("loc_oGrd.Column" + TRANSFORM(loc_nVis) + ".ReadOnly")) + ;
            CHR(13) + CHR(10)
    ENDFOR
    STRTOFILE(loc_cTxt, OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[3] FALHA: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 4) FILTRO DO LEGADO + TOTAL DO RODAPE
*==============================================================================
TRY
    SELECT CsGrade
    loc_nVis = 0
    COUNT TO loc_nVis
    loc_nSoma = 0
    SUM Valos TO loc_nSoma
    STRTOFILE("[4] linhas VISIVEIS apos Set Key To 'V' = " + TRANSFORM(loc_nVis) + ;
              " (esperado 3)  soma Valos = " + TRANSFORM(loc_nSoma) + ;
              "  rodape txt_4c_Adicional = " + ;
              TRANSFORM(loc_oForm.cnt_4c__Planilha.txt_4c_Adicional.Value) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[4] FALHA: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 6) TITULOS
*==============================================================================
TRY
    STRTOFILE("[6] Form.Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10) + ;
              "    faixa lblTitulo=[" + loc_oForm.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10) + ;
              "    subtitulo Label1=[" + loc_oForm.cnt_4c__Planilha.lbl_4c_Label1.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[6] FALHA: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 7) FORMULA DO Column4.Valid LEGADO
*    Linha 1 (Totas=100, Coefs 1.5 -> 2.0):
*      Valos  = Round((100 * 2.0) - 100, 3) = 100.000
*      TotalG = 100 + 100 = 200.000
*==============================================================================
TRY
    SELECT CsGrade
    GO TOP
    loc_oForm.this_oBusinessObject.ArmazenarCoefAnterior(CsGrade.Coefs)
    IF loc_oForm.this_oBusinessObject.RecalcularCoeficiente(2.0000)
        SELECT CsGrade
        GO TOP
        loc_nValEsp = ROUND((100.000 * 2.0000) - 100.000, 3)
        STRTOFILE("[7] linha 1 -> Coefs=" + TRANSFORM(CsGrade.Coefs) + ;
                  "  Valos=" + TRANSFORM(CsGrade.Valos) + " (esperado " + TRANSFORM(loc_nValEsp) + ")" + ;
                  "  TotalG=" + TRANSFORM(CsGrade.TotalG) + ;
                  "  Acumulas=" + TRANSFORM(CsGrade.Acumulas) + ;
                  "  AltCoef=" + TRANSFORM(CsGrade.AltCoef) + ;
                  "  CidChaves vazio=" + TRANSFORM(EMPTY(CsGrade.CidChaves)) + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.AtualizarTotalAdicional()
        STRTOFILE("    total adicional apos recalculo = " + ;
                  TRANSFORM(loc_oForm.cnt_4c__Planilha.txt_4c_Adicional.Value) + CHR(13) + CHR(10), OUT, 1)
    ELSE
        STRTOFILE("[7] RecalcularCoeficiente devolveu .F." + CHR(13) + CHR(10), OUT, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("[7] FALHA: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 8) ENTREGAVEL - FecharDialogo monta crPrFtp e DESFAZ o Set Key To
*==============================================================================
TRY
    loc_oForm.FecharDialogo()
    STRTOFILE("[8] crPrFtp existe=" + TRANSFORM(USED("crPrFtp")) + ;
              "  linhas=" + TRANSFORM(IIF(USED("crPrFtp"), RECCOUNT("crPrFtp"), -1)) + ;
              " (esperado 1 - so a linha com AltCoef=1)" + CHR(13) + CHR(10), OUT, 1)
    SELECT CsGrade
    loc_nVis = 0
    COUNT TO loc_nVis
    STRTOFILE("    csGrade visiveis apos FecharDialogo = " + TRANSFORM(loc_nVis) + ;
              " (esperado 5 - filtro desfeito)  pai.Enabled=" + ;
              TRANSFORM(loc_oPai.Enabled) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[8] FALHA: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

*==============================================================================
* 9) ESCOPO DOS METODOS (2 = Protected)
*==============================================================================
TRY
    loc_cTxt = "[9] escopos (Protected=.T. seria DEFEITO nos chamados de fora):" + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    CarregarDados          existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    AtualizarTitulos       existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarTitulos", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarTitulos", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    AtualizarTotalAdicional existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarTotalAdicional", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarTotalAdicional", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    BtnEncerrarClick       existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    FecharDialogo          existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    GridCoefGotFocus       existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "GridCoefGotFocus", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "GridCoefGotFocus", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    GridCoefLostFocus      existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "GridCoefLostFocus", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "GridCoefLostFocus", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    BO.RecalcularCoeficiente Protected=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "RecalcularCoeficiente", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    BO.MontarCursorAlterados Protected=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "MontarCursorAlterados", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    BO.FiltrarGrade          Protected=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "FiltrarGrade", 2)) + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + "    BO.ArmazenarCoefAnterior Protected=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "ArmazenarCoefAnterior", 2)) + CHR(13) + CHR(10)
    STRTOFILE(loc_cTxt, OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[9] FALHA: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

STRTOFILE("=== FIM DO PROBE ===" + CHR(13) + CHR(10), OUT, 1)
QUIT
