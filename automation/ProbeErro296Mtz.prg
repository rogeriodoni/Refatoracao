*==============================================================================
* ProbeErro296Mtz.prg - Instancia o Formmtz headless e exercita o caminho do
* botao Incluir (que estourava "Parent object will not allow this property
* setting"). Carrega SO as dependencias do form: ConfigurarAmbiente() BLOQUEIA
* nesta maquina. Regra #6: SET SAFETY OFF + SET RESOURCE OFF.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz296.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

PUBLIC gcLog
gcLog = "C:\4c\automation\probe_erro296_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLog)

LOCAL loc_oE, loForm, loPg1, loPg2, loGrdL, loGrdD, loc_nI, loc_cTxt

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    LogMtz("B: config.prg OK")

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "mtzBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formmtz.prg") ADDITIVE
    LogMtz("C: deps carregadas")

    loForm = CREATEOBJECT("Formmtz")
    LogMtz("D: CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

    IF VARTYPE(loForm) = "O"
        LogMtz("   Caption=[" + loForm.Caption + "] Width=" + TRANSFORM(loForm.Width) + ;
               " Height=" + TRANSFORM(loForm.Height) + " ActivePage=" + ;
               TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + " Modo=" + loForm.this_cModoAtual)

        loPg1  = loForm.pgf_4c_Paginas.Page1
        loPg2  = loForm.pgf_4c_Paginas.Page2
        loGrdL = loPg1.grd_4c_Lista
        loGrdD = loPg2.grd_4c_Dados

        *-- LAYOUT Page1: faixa, botoes, saida e grade
        LogMtz("E: Page1 Cabecalho Top=" + TRANSFORM(loPg1.cnt_4c_Cabecalho.Top) + ;
               " Height=" + TRANSFORM(loPg1.cnt_4c_Cabecalho.Height) + ;
               " | Botoes Top=" + TRANSFORM(loPg1.cnt_4c_Botoes.Top) + ;
               " Left=" + TRANSFORM(loPg1.cnt_4c_Botoes.Left) + ;
               " Width=" + TRANSFORM(loPg1.cnt_4c_Botoes.Width) + ;
               " | Saida Top=" + TRANSFORM(loPg1.cnt_4c_Saida.Top) + ;
               " Left=" + TRANSFORM(loPg1.cnt_4c_Saida.Left) + ;
               " BackStyle=" + TRANSFORM(loPg1.cnt_4c_Saida.BackStyle))
        LogMtz("F: Grade Lista Top=" + TRANSFORM(loGrdL.Top) + " Left=" + TRANSFORM(loGrdL.Left) + ;
               " Width=" + TRANSFORM(loGrdL.Width) + " Height=" + TRANSFORM(loGrdL.Height) + ;
               " ColumnCount=" + TRANSFORM(loGrdL.ColumnCount) + ;
               " FontName=[" + loGrdL.FontName + "]")

        *-- Z-order da Page1 (faixa tem de ser o primeiro filho - regra #11)
        loc_cTxt = ""
        FOR loc_nI = 1 TO loPg1.ControlCount
            loc_cTxt = loc_cTxt + IIF(EMPTY(loc_cTxt), "", " | ") + UPPER(loPg1.Controls(loc_nI).Name)
        ENDFOR
        LogMtz("G: Page1 z-order: " + loc_cTxt)

        *-- Nenhum controle de dados pode ficar sob a faixa (Top < 109)
        LogMtz("H: Grade Lista acima da faixa? " + ;
               TRANSFORM(loGrdL.Top < loPg1.cnt_4c_Cabecalho.Top + loPg1.cnt_4c_Cabecalho.Height))

        *-- Grade Lista: cursor placeholder + bind pelo funil
        LogMtz("I: CarregarLista() = " + TRANSFORM(loForm.CarregarLista()) + ;
               " | USED(cursor_4c_Dados)=" + TRANSFORM(USED("cursor_4c_Dados")))
        LogMtz("J: VincularGradeLista() = " + TRANSFORM(loForm.VincularGradeLista()))
        loc_cTxt = ""
        FOR loc_nI = 1 TO loGrdL.ColumnCount
            loc_cTxt = loc_cTxt + "[" + EVALUATE("loGrdL.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + ;
                       "/" + TRANSFORM(EVALUATE("loGrdL.Column" + TRANSFORM(loc_nI) + ".Width")) + "] "
        ENDFOR
        LogMtz("K: Colunas Lista: " + loc_cTxt)

        *-- CAMINHO DO BOTAO INCLUIR (Erro296)
        loForm.this_cModoAtual = "INCLUIR"
        LogMtz("L: CriarCursorDetalheVazio = " + ;
               TRANSFORM(loForm.this_oBusinessObject.CriarCursorDetalheVazio("001")) + ;
               " | USED(cursor_4c_MtI)=" + TRANSFORM(USED("cursor_4c_MtI")) + ;
               " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_MtI"), RECCOUNT("cursor_4c_MtI"), -1)))

        LogMtz("M: FormatarGradeDetalhe() ...")
        loForm.FormatarGradeDetalhe()
        LogMtz("   FormatarGradeDetalhe OK")

        *-- O bind da coluna 28 (o que estourava)
        loGrdD.RecordSource = "cursor_4c_MtI"
        loGrdD.Column28.ControlSource = "cursor_4c_MtI.ChkValida"
        LogMtz("N: Column28.ControlSource=[" + loGrdD.Column28.ControlSource + ;
               "] CurrentControl=[" + loGrdD.Column28.CurrentControl + ;
               "] Sparse=" + TRANSFORM(loGrdD.Column28.Sparse) + ;
               " Width=" + TRANSFORM(loGrdD.Column28.Width) + ;
               " chk.Width=" + TRANSFORM(loGrdD.Column28.chk_4c_Check1.Width) + ;
               " chk.Centered=" + TRANSFORM(loGrdD.Column28.chk_4c_Check1.Centered))

        *-- ColumnOrder e larguras depois do rebind
        loForm.FormatarGradeDetalhe()
        loc_cTxt = ""
        FOR loc_nI = 1 TO 28
            loc_cTxt = loc_cTxt + TRANSFORM(loc_nI) + "=>" + ;
                TRANSFORM(EVALUATE("loGrdD.Column" + TRANSFORM(loc_nI) + ".ColumnOrder")) + ;
                "(w" + TRANSFORM(EVALUATE("loGrdD.Column" + TRANSFORM(loc_nI) + ".Width")) + ") "
        ENDFOR
        LogMtz("O: ColumnOrder/Width modo INCLUIR: " + loc_cTxt)

        loForm.this_cModoAtual = "ALTERAR"
        loForm.FormatarGradeDetalhe()
        LogMtz("P: modo ALTERAR -> Column16.Width=" + TRANSFORM(loGrdD.Column16.Width) + ;
               " Column27.Width=" + TRANSFORM(loGrdD.Column27.Width) + ;
               " Column16.Header=[" + loGrdD.Column16.Header1.Caption + "]" + ;
               " Column27.Header=[" + loGrdD.Column27.Header1.Caption + "]")

        *-- AlternarGradeDetalhe pelo caminho real (PROTECTED: via BtnIncluirClick)
        LogMtz("Q: BtnIncluirClick() = " + TRANSFORM(loForm.BtnIncluirClick()) + ;
               " ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + ;
               " Modo=" + loForm.this_cModoAtual)

        loForm.Release()
        LogMtz("R: Release OK")
    ENDIF

CATCH TO loc_oE
    LogMtz("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    LogMtz("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogMtz("DIALOGOS: nenhum")
ENDIF
LogMtz("Z: fim")
QUIT

PROCEDURE LogMtz(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLog, 1)
ENDPROC
