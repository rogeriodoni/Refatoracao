*==============================================================================
* ProbeErro297Mtz.prg - Instancia o Formmtz e exercita:
*   1) ValidarAnoMtz por ATRIBUICAO (o harness nao dirige Format="K!" por tecla)
*   2) a ordem fonte-antes-das-larguras em AlternarGradeDetalhe (via o mesmo
*      encadeamento: RecordSource -> ControlSource -> FontSize -> Formatar)
* Carrega so as dependencias do form (ConfigurarAmbiente() bloqueia aqui).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz297.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

PUBLIC gcLog297
gcLog297 = "C:\4c\automation\probe_erro297_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLog297)

LOCAL loc_oE, loForm, loPg2, loGrdD, loTxt, loc_nI, loc_cTxt, loc_cAnt

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
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
    Log297("B: deps carregadas")

    loForm = CREATEOBJECT("Formmtz")
    Log297("C: CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

    IF VARTYPE(loForm) = "O"
        loPg2  = loForm.pgf_4c_Paginas.Page2
        loGrdD = loPg2.grd_4c_Dados
        loTxt  = loPg2.txt_4c_Ano

        Log297("D: txt_4c_Ano Alignment=" + TRANSFORM(loTxt.Alignment) + ;
               " Format=[" + loTxt.Format + "] MaxLength=" + TRANSFORM(loTxt.MaxLength) + ;
               " SpecialEffect=" + TRANSFORM(loTxt.SpecialEffect))

        *-- ValidarAnoMtz: digitacao simulada nao dirige Format="K!", testar por
        *-- ATRIBUICAO (que eh como o LostFocus ve o campo depois de digitado)
        Log297("E: --- ValidarAnoMtz por atribuicao ---")
        FOR loc_nI = 1 TO 7
            loc_cAnt = ICASE(loc_nI = 1, "2", loc_nI = 2, "20", loc_nI = 3, "202", ;
                             loc_nI = 4, "2026", loc_nI = 5, "26", ;
                             loc_nI = 6, "1999", "")
            loTxt.Value = loc_cAnt
            loForm.ValidarAnoMtz()
            Log297("   entrada [" + loc_cAnt + "] -> Value=[" + loTxt.Value + "]" + ;
                   " avisos=" + TRANSFORM(IIF(FILE(gc_4c_ArquivoErroTeste), ;
                   OCCURS("Informe um Ano", FILETOSTR(gc_4c_ArquivoErroTeste)), 0)))
        ENDFOR

        *-- Grade: reproduzir a ordem REAL de AlternarGradeDetalhe
        Log297("F: CriarCursorDetalheVazio = " + ;
               TRANSFORM(loForm.this_oBusinessObject.CriarCursorDetalheVazio("001")))
        loForm.this_cModoAtual = "INCLUIR"
        loGrdD.ColumnCount  = 28
        loGrdD.RecordSource = "cursor_4c_MtI"
        loGrdD.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
        loGrdD.Column28.ControlSource = "cursor_4c_MtI.ChkValida"
        loGrdD.FontName = "Tahoma"
        loGrdD.FontSize = 8
        loForm.FormatarGradeDetalhe()

        loc_cTxt = ""
        FOR loc_nI = 1 TO 28
            loc_cTxt = loc_cTxt + TRANSFORM(loc_nI) + ":" + ;
                TRANSFORM(EVALUATE("loGrdD.Column" + TRANSFORM(loc_nI) + ".Width")) + " "
        ENDFOR
        Log297("G: larguras modo INCLUIR (16..27 tem de ser 0): " + loc_cTxt)

        loForm.this_cModoAtual = "ALTERAR"
        loForm.FormatarGradeDetalhe()
        Log297("H: modo ALTERAR -> Column16.Width=" + TRANSFORM(loGrdD.Column16.Width) + ;
               " Column3.Width=" + TRANSFORM(loGrdD.Column3.Width) + ;
               " Column28.Width=" + TRANSFORM(loGrdD.Column28.Width))

        loForm.Release()
        Log297("I: Release OK")
    ENDIF

CATCH TO loc_oE
    Log297("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Log297("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Log297("DIALOGOS: nenhum")
ENDIF
Log297("Z: fim")
QUIT

PROCEDURE Log297(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLog297, 1)
ENDPROC
