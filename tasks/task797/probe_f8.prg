*-- Probe da Fase 8: instancia FormSIGOPRPS em modo teste e mede a tela montada.
*-- Execucao unattended (regra CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task797\logs\probe_f8_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL loc_cOut, loc_oF, loc_oErro
loc_cOut = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

*-- config.prg redefine gb_4c_ValidandoUI = .F. - repor DEPOIS dele
gb_4c_ValidandoUI = .T.
GarantirClasse("FormSIGOPRPS")

TRY
    loc_oF = CREATEOBJECT("FormSIGOPRPS", "001", "RPS", "1", 123, "MALOTE", 7)

    loc_cOut = loc_cOut + "VARTYPE=" + VARTYPE(loc_oF) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oF) = "O"
        loc_cOut = loc_cOut + ;
            "BaseClass=" + loc_oF.BaseClass + CHR(13) + CHR(10) + ;
            "Caption=[" + loc_oF.Caption + "]" + CHR(13) + CHR(10) + ;
            "WxH=" + TRANSFORM(loc_oF.Width) + "x" + TRANSFORM(loc_oF.Height) + CHR(13) + CHR(10) + ;
            "DataSessionId=" + TRANSFORM(loc_oF.DataSessionId) + CHR(13) + CHR(10) + ;
            "Closable=" + TRANSFORM(loc_oF.Closable) + CHR(13) + CHR(10) + ;
            "ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13) + CHR(10) + ;
            "SET(DATE)=" + SET("DATE") + " CENTURY=" + SET("CENTURY") + CHR(13) + CHR(10)

        *-- Cabecalho
        loc_cOut = loc_cOut + "cab.Width=" + TRANSFORM(loc_oF.cnt_4c_Cabecalho.Width) + ;
            " lblTitulo.W=" + TRANSFORM(loc_oF.cnt_4c_Cabecalho.lbl_4c_Titulo.Width) + ;
            " Cap=[" + ALLTRIM(loc_oF.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption) + "]" + CHR(13) + CHR(10)

        *-- Grid montado
        WITH loc_oF.grd_4c_Dados
            loc_cOut = loc_cOut + "grid: Cols=" + TRANSFORM(.ColumnCount) + ;
                " RowHeight=" + TRANSFORM(.RowHeight) + ;
                " ScrollBars=" + TRANSFORM(.ScrollBars) + ;
                " ReadOnly=" + TRANSFORM(.ReadOnly) + ;
                " Visible=" + TRANSFORM(.Visible) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "widths=" + TRANSFORM(.Column1.Width) + "/" + ;
                TRANSFORM(.Column2.Width) + "/" + TRANSFORM(.Column3.Width) + "/" + ;
                TRANSFORM(.Column4.Width) + " (soma=" + ;
                TRANSFORM(.Column1.Width + .Column2.Width + .Column3.Width + .Column4.Width) + ;
                " de " + TRANSFORM(.Width) + ")" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "hdrAlign=" + TRANSFORM(.Column1.Header1.Alignment) + "/" + ;
                TRANSFORM(.Column2.Header1.Alignment) + "/" + TRANSFORM(.Column3.Header1.Alignment) + "/" + ;
                TRANSFORM(.Column4.Header1.Alignment) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "txtMargin=" + TRANSFORM(.Column1.Text1.Margin) + ;
                " txtFontSize=" + TRANSFORM(.Column1.Text1.FontSize) + ;
                " col4TxtAlign=" + TRANSFORM(.Column4.Text1.Alignment) + CHR(13) + CHR(10)
        ENDWITH

        *-- Campos de identificacao preenchidos por BOParaForm
        loc_cOut = loc_cOut + "campos: Emps=[" + TRANSFORM(loc_oF.txt_4c__Emps.Value) + ;
            "] Tipos=[" + TRANSFORM(loc_oF.txt_4c__Tipos.Value) + ;
            "] Series=[" + TRANSFORM(loc_oF.txt_4c__Series.Value) + ;
            "] NumRps=[" + TRANSFORM(loc_oF.txt_4c__NumRps.Value) + ;
            "] Dopes=[" + TRANSFORM(loc_oF.txt_4c__Dopes.Value) + ;
            "] Numes=[" + TRANSFORM(loc_oF.txt_4c__Numes.Value) + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "ReadOnly/TabStop Emps=" + TRANSFORM(loc_oF.txt_4c__Emps.ReadOnly) + ;
            "/" + TRANSFORM(loc_oF.txt_4c__Emps.TabStop) + CHR(13) + CHR(10)

        *-- Visibilidade e escopo dos metodos exigidos pelo gate
        loc_cOut = loc_cOut + "PEM CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oF, "CarregarLista", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loc_oF, "CarregarLista", 2)) + ;
            " | BOParaForm prot=" + TRANSFORM(PEMSTATUS(loc_oF, "BOParaForm", 2)) + ;
            " | CmdEncerrarClick prot=" + TRANSFORM(PEMSTATUS(loc_oF, "CmdEncerrarClick", 2)) + CHR(13) + CHR(10)

        *-- Botao Encerrar + BINDEVENT
        loc_cOut = loc_cOut + "Encerrar: Cap=[" + loc_oF.cmd_4c_Encerrar.Caption + ;
            "] Cancel=" + TRANSFORM(loc_oF.cmd_4c_Encerrar.Cancel) + ;
            " Pic=" + IIF(FILE(loc_oF.cmd_4c_Encerrar.Picture), "EXISTE", "AUSENTE") + ;
            " Visible=" + TRANSFORM(loc_oF.cmd_4c_Encerrar.Visible) + CHR(13) + CHR(10)
        LOCAL ARRAY loc_aEv[1,1]
        LOCAL loc_nEv, loc_nE, loc_cBind
        loc_cBind = "nenhum"
        loc_nEv = AEVENTS(loc_aEv, loc_oF.cmd_4c_Encerrar)
        FOR loc_nE = 1 TO loc_nEv
            IF UPPER(ALLTRIM(loc_aEv[loc_nE, 3])) == "CLICK"
                loc_cBind = ALLTRIM(loc_aEv[loc_nE, 4])
            ENDIF
        ENDFOR
        loc_cOut = loc_cOut + "BINDEVENT Click -> [" + loc_cBind + "] (total=" + TRANSFORM(loc_nEv) + ")" + CHR(13) + CHR(10)

        *-- Nenhum filho fora da area do pai (regra #30)
        LOCAL loc_i, loc_o, loc_cFora
        loc_cFora = ""
        FOR loc_i = 1 TO loc_oF.ControlCount
            loc_o = loc_oF.Controls(loc_i)
            IF VARTYPE(loc_o) = "O" AND PEMSTATUS(loc_o, "Left", 5) AND PEMSTATUS(loc_o, "Width", 5)
                IF loc_o.Left + loc_o.Width > loc_oF.Width OR loc_o.Top + loc_o.Height > loc_oF.Height
                    loc_cFora = loc_cFora + loc_o.Name + "(" + TRANSFORM(loc_o.Left) + "+" + ;
                        TRANSFORM(loc_o.Width) + "," + TRANSFORM(loc_o.Top) + "+" + ;
                        TRANSFORM(loc_o.Height) + ") "
                ENDIF
            ENDIF
        ENDFOR
        loc_cOut = loc_cOut + "FORA DO FORM: " + IIF(EMPTY(loc_cFora), "nenhum", loc_cFora) + CHR(13) + CHR(10)

        loc_oF.Release()
        loc_cOut = loc_cOut + "Release OK" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\tasks\task797\logs\probe_f8_resultado.txt")
QUIT
