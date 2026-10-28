SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_cgb689f8.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigopcgb")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)

    *-- Fase 8: o Timer tmr_4c_FocoBarras tem de existir e nascer DESARMADO
    lcOut = lcOut + "Timer existe=" + TRANSFORM(PEMSTATUS(loForm, "tmr_4c_FocoBarras", 5))
    IF PEMSTATUS(loForm, "tmr_4c_FocoBarras", 5)
        lcOut = lcOut + "  BaseClass=" + loForm.tmr_4c_FocoBarras.BaseClass + ;
            "  Interval=" + TRANSFORM(loForm.tmr_4c_FocoBarras.Interval) + ;
            "  Enabled=" + TRANSFORM(loForm.tmr_4c_FocoBarras.Enabled)
    ENDIF
    lcOut = lcOut + CHR(13) + CHR(10)

    *-- Fase 8: os metodos novos tem de ser PUBLIC (BINDEVENT exige - regra #3)
    lcOut = lcOut + "PROTECTED? BarrasGotFocus=" + TRANSFORM(PEMSTATUS(loForm, "BarrasGotFocus", 2)) + ;
        " BarrasLostFocus=" + TRANSFORM(PEMSTATUS(loForm, "BarrasLostFocus", 2)) + ;
        " TimerFocoBarras=" + TRANSFORM(PEMSTATUS(loForm, "TimerFocoBarras", 2)) + ;
        " FocarBarras=" + TRANSFORM(PEMSTATUS(loForm, "FocarBarras", 2)) + ;
        " ValidarBarrasExec=" + TRANSFORM(PEMSTATUS(loForm, "ValidarBarrasExec", 2)) + CHR(13) + CHR(10)

    *-- Fase 8: o BINDEVENT dos tres eventos novos esta de pe?
    *-- AEVENTS tem DOIS argumentos e consulta por objeto de ORIGEM; o nome do
    *-- evento eh a coluna 3 e o metodo delegate a coluna 4.
    LOCAL ARRAY laEv[1,5]
    LOCAL lnEv, lnI, lcLig
    lcLig = ""
    TRY
        lnEv = AEVENTS(laEv, loForm.txt_4c_Barras)
        FOR lnI = 1 TO lnEv
            lcLig = lcLig + "  txt_4c_Barras." + ALLTRIM(laEv[lnI, 3]) + " -> " + ALLTRIM(laEv[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
        lnEv = AEVENTS(laEv, loForm.tmr_4c_FocoBarras)
        FOR lnI = 1 TO lnEv
            lcLig = lcLig + "  tmr_4c_FocoBarras." + ALLTRIM(laEv[lnI, 3]) + " -> " + ALLTRIM(laEv[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
    CATCH TO loErr
        lcLig = lcLig + "  ERRO AEVENTS: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY
    lcOut = lcOut + "Bindings Fase 8:" + CHR(13) + CHR(10) + lcLig

    *-- Estado inicial: sem codigo pesquisado -> grades e botoes desabilitados
    lcOut = lcOut + "Sem codigo: Historico.Enabled=" + TRANSFORM(loForm.grd_4c_Historico.Enabled) + ;
        " Movimento.Enabled=" + TRANSFORM(loForm.grd_4c_Movimento.Enabled) + ;
        " Devolucao.Enabled=" + TRANSFORM(loForm.grd_4c_Devolucao.Enabled) + ;
        " Imprimir.Enabled=" + TRANSFORM(loForm.cmd_4c_BtnImprimir.Enabled) + ;
        " Barras.Enabled=" + TRANSFORM(loForm.txt_4c_Barras.Enabled) + CHR(13) + CHR(10)

    *-- GotFocus grava o peantvalue
    TRY
        loForm.txt_4c_Barras.Value = 12345
        loForm.BarrasGotFocus()
        lcOut = lcOut + "BarrasGotFocus: this_nBarrasAnterior=" + ;
            TRANSFORM(loForm.this_nBarrasAnterior) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BarrasGotFocus: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- LostFocus com valor NAO mudado: nao pesquisa (guard peantvalue) e,
    *-- como LASTKEY() nao eh 13/9/digito num teste headless, nao arma o timer
    TRY
        loForm.BarrasLostFocus()
        lcOut = lcOut + "LostFocus (valor igual): Timer.Enabled=" + ;
            TRANSFORM(loForm.tmr_4c_FocoBarras.Enabled) + ;
            " EmPesquisa=" + TRANSFORM(loForm.this_lEmPesquisa) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BarrasLostFocus: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- LostFocus com valor MUDADO: ValidarBarras roda e, sem conexao,
    *-- PodeConsultarBanco() barra - a flag de reentrancia tem de VOLTAR a .F.
    TRY
        loForm.txt_4c_Barras.Value = 99999
        loForm.BarrasLostFocus()
        lcOut = lcOut + "LostFocus (valor mudou): EmPesquisa=" + ;
            TRANSFORM(loForm.this_lEmPesquisa) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BarrasLostFocus/2: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- Guard de reentrancia: com a flag ligada, ValidarBarras devolve .F.
    TRY
        loForm.this_lEmPesquisa = .T.
        lcOut = lcOut + "ValidarBarras c/ flag ligada=" + ;
            TRANSFORM(loForm.ValidarBarras()) + CHR(13) + CHR(10)
        loForm.this_lEmPesquisa = .F.
    CATCH TO loErr
        lcOut = lcOut + "ERRO ValidarBarras: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- Timer one-shot: desarma a si proprio
    TRY
        loForm.tmr_4c_FocoBarras.Enabled = .T.
        loForm.TimerFocoBarras()
        lcOut = lcOut + "TimerFocoBarras: Timer.Enabled depois=" + ;
            TRANSFORM(loForm.tmr_4c_FocoBarras.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO TimerFocoBarras: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- FocarBarras com campo travado nao deve estourar
    TRY
        loForm.txt_4c_Barras.Enabled = .F.
        loForm.FocarBarras()
        loForm.txt_4c_Barras.Enabled = .T.
        lcOut = lcOut + "FocarBarras c/ campo travado: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO FocarBarras: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- LimparGrades volta a desabilitar tudo (funil de volta)
    TRY
        loForm.AtualizarEstadoBotoes(123)
        lcOut = lcOut + "AtualizarEstadoBotoes(123): Historico.Enabled=" + ;
            TRANSFORM(loForm.grd_4c_Historico.Enabled) + ;
            " Imprimir.Enabled=" + TRANSFORM(loForm.cmd_4c_BtnImprimir.Enabled) + CHR(13) + CHR(10)
        loForm.LimparGrades()
        lcOut = lcOut + "LimparGrades(): Historico.Enabled=" + ;
            TRANSFORM(loForm.grd_4c_Historico.Enabled) + ;
            " Imprimir.Enabled=" + TRANSFORM(loForm.cmd_4c_BtnImprimir.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO estado/limpar: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loForm.BtnEncerrarClick()
        lcOut = lcOut + "BtnEncerrarClick: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BtnEncerrarClick: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- DIALOGS/ERROS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\probe689f8.txt")
QUIT

