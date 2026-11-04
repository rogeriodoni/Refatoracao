SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe722f4.txt"
STRTOFILE("PROBE INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
Log722("config.prg carregado")

ConfigurarAmbiente()
Log722("ConfigurarAmbiente OK - PATH=" + SET("PATH"))

GarantirClasse("FormSigOpDmp")
Log722("GarantirClasse OK")

LOCAL loForm, loPg1, loPg2, loGrd, loBt
loForm = CREATEOBJECT("FormSigOpDmp")
Log722("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log722("Caption=[" + loForm.Caption + "] Width=" + TRANSFORM(loForm.Width) + ;
           " Height=" + TRANSFORM(loForm.Height) + " ActivePage=" + ;
           TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + " Modo=" + loForm.this_cModoAtual)

    loPg1 = loForm.pgf_4c_Paginas.Page1
    loPg2 = loForm.pgf_4c_Paginas.Page2
    Log722("Page1.ControlCount=" + TRANSFORM(loPg1.ControlCount) + ;
           " Page2.ControlCount=" + TRANSFORM(loPg2.ControlCount))

    *-- Z-order da Page1: a faixa tem de ser o filho 1 (regra #11)
    LOCAL lnI, lcZ
    lcZ = ""
    FOR lnI = 1 TO loPg1.ControlCount
        lcZ = lcZ + IIF(EMPTY(lcZ), "", " | ") + UPPER(loPg1.Controls(lnI).Name)
    ENDFOR
    Log722("Page1 z-order: " + lcZ)

    *-- Os 5 botoes CRUD + Encerrar
    Log722("Botoes CRUD: Incluir=" + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)) + ;
           " Visualizar=" + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)) + ;
           " Alterar="    + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)) + ;
           " Excluir="    + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)) + ;
           " Buscar="     + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)) + ;
           " Encerrar="   + TRANSFORM(PEMSTATUS(loPg1.cnt_4c_Saida, "cmd_4c_Encerrar", 5)))

    loBt = loPg1.cnt_4c_Botoes.cmd_4c_Incluir
    Log722("Incluir: Left=" + TRANSFORM(loBt.Left) + " Top=" + TRANSFORM(loBt.Top) + ;
           " W=" + TRANSFORM(loBt.Width) + " H=" + TRANSFORM(loBt.Height) + ;
           " Visible=" + TRANSFORM(loBt.Visible) + " Caption=[" + loBt.Caption + "]" + ;
           " PictureOK=" + TRANSFORM(FILE(loBt.Picture)))

    loBt = loPg1.cnt_4c_Saida.cmd_4c_Encerrar
    Log722("Encerrar: Left=" + TRANSFORM(loPg1.cnt_4c_Saida.Left + loBt.Left) + ;
           " W=" + TRANSFORM(loBt.Width) + " Caption=[" + loBt.Caption + "]" + ;
           " PictureOK=" + TRANSFORM(FILE(loBt.Picture)))

    *-- Confirmar/Cancelar da pagina Dados
    Log722("Page2: Confirmar=" + TRANSFORM(PEMSTATUS(loPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)) + ;
           " Cancelar=" + TRANSFORM(PEMSTATUS(loPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)) + ;
           " CancelarPictureOK=" + TRANSFORM(FILE(loPg2.cnt_4c_Salva.cmd_4c_Cancelar.Picture)))

    *-- Grade da Lista
    loGrd = loPg1.grd_4c_Lista
    Log722("Grade: Top=" + TRANSFORM(loGrd.Top) + " Left=" + TRANSFORM(loGrd.Left) + ;
           " W=" + TRANSFORM(loGrd.Width) + " H=" + TRANSFORM(loGrd.Height) + ;
           " ColumnCount=" + TRANSFORM(loGrd.ColumnCount) + ;
           " RecordSource=[" + loGrd.RecordSource + "]" + ;
           " Visible=" + TRANSFORM(loGrd.Visible) + ;
           " ReadOnly=" + TRANSFORM(loGrd.ReadOnly))
    Log722("Grade.Column1: ControlSource=[" + loGrd.Column1.ControlSource + "]" + ;
           " Width=" + TRANSFORM(loGrd.Column1.Width) + ;
           " Header=[" + loGrd.Column1.Header1.Caption + "]" + ;
           " ReadOnly=" + TRANSFORM(loGrd.Column1.ReadOnly))
    Log722("cursor_4c_Dados USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
           " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), -1)))

    *-- Escopo dos metodos chamados de fora (regras #3 e #51): 2 = PROTECTED
    Log722("PROTECTED? CarregarLista=" + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + ;
           " AlternarPagina="      + TRANSFORM(PEMSTATUS(loForm, "AlternarPagina", 2)) + ;
           " AjustarBotoesPorModo="+ TRANSFORM(PEMSTATUS(loForm, "AjustarBotoesPorModo", 2)) + ;
           " BtnCancelarClick="    + TRANSFORM(PEMSTATUS(loForm, "BtnCancelarClick", 2)) + ;
           " BtnEncerrarClick="    + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 2)) + ;
           " BO.Buscar="           + TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject, "Buscar", 2)))

    *-- Enabled dos botoes em LISTA
    Log722("LISTA: Incluir.Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
           " Buscar.Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + ;
           " Confirmar.Enabled=" + TRANSFORM(loPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled) + ;
           " Cancelar.Enabled=" + TRANSFORM(loPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled))

    *-- Ida para a pagina Dados em modo INCLUIR e volta pelo funil
    loForm.this_cModoAtual = "INCLUIR"
    loForm.AlternarPagina(2)
    Log722("APOS AlternarPagina(2) INCLUIR: ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + ;
           " Modo=" + loForm.this_cModoAtual + ;
           " Incluir.Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
           " Confirmar.Enabled=" + TRANSFORM(loPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled))

    loForm.BtnCancelarClick()
    Log722("APOS BtnCancelarClick: ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + ;
           " Modo=" + loForm.this_cModoAtual + ;
           " Incluir.Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
           " Buscar.Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + ;
           " Grade.RecordSource=[" + loGrd.RecordSource + "]" + ;
           " Column1.Header=[" + loGrd.Column1.Header1.Caption + "]" + ;
           " Column1.Width=" + TRANSFORM(loGrd.Column1.Width))

    *-- CarregarLista chamada de fora duas vezes seguidas (re-bind)
    Log722("CarregarLista() direto = " + TRANSFORM(loForm.CarregarLista()) + ;
           " Column1.Width=" + TRANSFORM(loGrd.Column1.Width) + ;
           " Header=[" + loGrd.Column1.Header1.Caption + "]")

    loForm.Release()
    Log722("Release OK")
ENDIF

Log722("PROBE FIM")
QUIT

PROCEDURE Log722(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
