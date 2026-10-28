*==============================================================================
* ProbeFea252.prg - Erro252: FormFea nao abria
*   "Erro em ConfigurarResultado: Alias 'TMPOPERA' is not found. Linha: 4398"
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA (antes: ConfigurarResultado estourava e o Init devolvia .F.)
*   2) TmpOpera / TmpResFas / TmpResumo existem logo apos o Init (legado: Load)
*   3) as grades do container Resultado ficaram realmente ligadas aos cursores
*      (RecordSource + Column.ControlSource sobrevivem ao Init)
* NAO chama Show(): travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fea252.txt"
#DEFINE OUT "C:\4c\automation\probe_fea252.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_oCnt, loc_oG, loc_nI, loc_nC, loc_cNome, loc_oCol
loc_nFalhas = 0
STRTOFILE("=== PROBE Erro252 - FormFea ===" + CHR(13)+CHR(10), OUT)
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
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FeaBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFea.prg") ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    loc_oForm = CREATEOBJECT("FormFea")
    loc_cL = "1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_cL = "2) cursores: TmpOpera=" + TRANSFORM(USED("TmpOpera")) + ;
             " TmpResFas=" + TRANSFORM(USED("TmpResFas")) + ;
             " TmpResumo=" + TRANSFORM(USED("TmpResumo")) + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF !(USED("TmpOpera") AND USED("TmpResFas") AND USED("TmpResumo"))
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oCnt = loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Resultado
    loc_oG = loc_oCnt.Pagina.Pages(1).GradeEntradas
    loc_cL = "3) GradeEntradas RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + ;
             " Col5=[" + loc_oG.Column5.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    IF UPPER(ALLTRIM(loc_oG.Column1.ControlSource)) != "TMPOPERA.TPOPS"
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oG = loc_oCnt.Pagina.Pages(3).GradeResumo
    loc_cL = "4) GradeResumo  RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    loc_oG = loc_oCnt.GradeMat
    loc_cL = "5) GradeMat     RecordSource=[" + loc_oG.RecordSource + "]" + ;
             " Col1=[" + loc_oG.Column1.ControlSource + "]" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) colunas das grades Entradas/Saidas contra o SCX legado
    FOR loc_nC = 1 TO 2
        loc_cNome = IIF(loc_nC = 1, "GradeEntradas", "GradeSaidas")
        loc_oG = loc_oCnt.Pagina.Pages(loc_nC).&loc_cNome
        STRTOFILE("6." + TRANSFORM(loc_nC) + ") " + loc_cNome + CHR(13)+CHR(10), OUT, 1)
        FOR loc_nI = 1 TO 5
            loc_oCol = loc_oG.Columns(loc_nI)
            STRTOFILE("    Col" + TRANSFORM(loc_nI) + ;
                " src="  + PADR(ALLTRIM(loc_oCol.ControlSource), 20) + ;
                " w="    + PADR(TRANSFORM(loc_oCol.Width), 5) + ;
                " mask=" + PADR(ALLTRIM(loc_oCol.InputMask), 12) + ;
                " ord="  + TRANSFORM(loc_oCol.ColumnOrder) + ;
                " hdr="  + ALLTRIM(loc_oCol.Header1.Caption) + CHR(13)+CHR(10), OUT, 1)
        ENDFOR
    ENDFOR
    *-- 7) TmpOpera tem as colunas de falha de ENTRADA que o legado declara?
    STRTOFILE("7) TmpOpera PFalhaE=" + TRANSFORM(TYPE("TmpOpera.PFalhaE") = "N") + ;
        " FalhaE=" + TRANSFORM(TYPE("TmpOpera.FalhaE") = "N") + CHR(13)+CHR(10), OUT, 1)
    IF TYPE("TmpOpera.PFalhaE") != "N" OR TYPE("TmpOpera.FalhaE") != "N"
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 8) layout da pagina Dados: nenhum controle de dados pode invadir a faixa
    *--    (cnt_4c_Cabecalho ocupa Top 29..109 - regra #11). A barra de acao do
    *--    topo (cnt_4c_BotoesAcao) eh a excecao: fica POR CIMA da faixa.
    LOCAL loc_oPg2, loc_oObj, loc_nMinTop, loc_cMin, loc_nFundo
    loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2
    loc_nMinTop = 99999
    loc_cMin = ""
    STRTOFILE("8) filhos diretos da Page2 (Dados):" + CHR(13)+CHR(10), OUT, 1)
    FOR loc_nI = 1 TO loc_oPg2.ControlCount
        loc_oObj = loc_oPg2.Controls(loc_nI)
        STRTOFILE("    " + PADR(loc_oObj.Name, 20) + ;
            " T=" + PADR(TRANSFORM(loc_oObj.Top), 5) + ;
            " L=" + PADR(TRANSFORM(loc_oObj.Left), 5) + ;
            " W=" + PADR(TRANSFORM(loc_oObj.Width), 5) + ;
            " H=" + PADR(TRANSFORM(loc_oObj.Height), 5) + ;
            " Vis=" + TRANSFORM(loc_oObj.Visible) + CHR(13)+CHR(10), OUT, 1)
        IF !INLIST(UPPER(loc_oObj.Name), "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
            IF loc_oObj.Top < loc_nMinTop
                loc_nMinTop = loc_oObj.Top
                loc_cMin = loc_oObj.Name
            ENDIF
        ENDIF
    ENDFOR
    STRTOFILE("   menor Top de controle de dados = " + TRANSFORM(loc_nMinTop) + ;
        " (" + ALLTRIM(loc_cMin) + ") - faixa termina em 109" + CHR(13)+CHR(10), OUT, 1)
    IF loc_nMinTop < 109
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_nFundo = loc_oPg2.cnt_4c_Resultado.Top + loc_oPg2.cnt_4c_Resultado.Height
    STRTOFILE("   base do cnt_4c_Resultado = " + TRANSFORM(loc_nFundo) + ;
        " / altura util da pagina = " + TRANSFORM(loc_oForm.Height + 29) + CHR(13)+CHR(10), OUT, 1)
    IF loc_nFundo > loc_oForm.Height + 29
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 9) alinhamento dos botoes entre a pagina Lista e a pagina Dados:
    *--    Encerrar da Lista e Encerrar(Cancelar) da Dados tem de cair no MESMO
    *--    Left absoluto, e Confirmar sobre o Buscar da Lista.
    LOCAL loc_oPg1, loc_nL1, loc_nL2, loc_nL3, loc_nL4
    loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page1
    loc_nL1 = loc_oPg1.cnt_4c_Saida.Left  + loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Left
    loc_nL2 = loc_oPg2.cnt_4c_BotoesAcao.Left + loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Left
    loc_nL3 = loc_oPg1.cnt_4c_Botoes.Left + loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Left
    loc_nL4 = loc_oPg2.cnt_4c_BotoesAcao.Left + loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Left
    STRTOFILE("9) Encerrar  Lista=" + TRANSFORM(loc_nL1) + " Dados=" + TRANSFORM(loc_nL2) + ;
        "   Buscar Lista=" + TRANSFORM(loc_nL3) + " / Confirmar Dados=" + TRANSFORM(loc_nL4) + CHR(13)+CHR(10), OUT, 1)
    IF loc_nL1 != loc_nL2 OR loc_nL3 != loc_nL4
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    *-- o Container RECORTA: o Cancelar tem de caber na largura de nascimento
    STRTOFILE("   BotoesAcao T=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.Top) + ;
        " L=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.Left) + ;
        " W=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.Width) + ;
        " / Cancelar precisa de " + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Left + ;
             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Width) + CHR(13)+CHR(10), OUT, 1)
    IF loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Left + loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Width > loc_oPg2.cnt_4c_BotoesAcao.Width
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    STRTOFILE("PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY
QUIT
