*==============================================================================
* InstantiateCheckCgfF4.prg - Probe da Fase 4/8 do FormSIGOPCGF (Page1
* Filtros: grid completo + botoes CRUD + AlternarPagina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_ProbeLog
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\InstantiateCheckCgfF4_err.txt"
gc_4c_ProbeLog         = "C:\4c\automation\InstantiateCheckCgfF4.txt"

STRTOFILE("CK1 pre-config" + CHR(13) + CHR(10), gc_4c_ProbeLog)

ON ERROR DO ProbeErro WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

CD C:\4c\projeto\app\start
DO config.prg
= ProbeAnota("CK2 pos-config")

gb_4c_ValidandoUI = .T.

LOCAL loc_cPath
loc_cPath = gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
            gcCaminhoForms + "," + gcCaminhoIcones
SET PATH TO (loc_cPath)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCGFBO.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoForms   + "operacionais\FormSIGOPCGF.prg") ADDITIVE
= ProbeAnota("CK3 pos-setprocedure")

PUBLIC gnConnHandle
gnConnHandle = -1

PUBLIC goForm
goForm = .NULL.

TRY
    goForm = CREATEOBJECT("FormSIGOPCGF_Probe")
CATCH TO loErr
    = ProbeAnota("EXCECAO CREATEOBJECT: " + loErr.Message + " Ln=" + ;
                 TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure)
ENDTRY

IF VARTYPE(goForm) != "O"
    = ProbeAnota("1 INSTANCIA FALHOU VARTYPE=" + VARTYPE(goForm))
ELSE
    = ProbeAnota("1 INSTANCIA OK BaseClass=" + goForm.BaseClass + ;
                 " Caption=[" + goForm.Caption + "] ModoAtual=" + goForm.this_cModoAtual)

    LOCAL loc_oPag, loc_nSessaoAnt
    loc_oPag = goForm.pgf_4c_Paginas.Page1

    = ProbeAnota("2 GRIDS Tipos.Cols=" + TRANSFORM(loc_oPag.grd_4c_Tipos.ColumnCount) + ;
          " Clientes.Cols=" + TRANSFORM(loc_oPag.grd_4c_Clientes.ColumnCount) + ;
          " Clientes2.Cols=" + TRANSFORM(loc_oPag.grd_4c_Clientes2.ColumnCount) + ;
          "  (esperado 2 / 8 / 8)")

    = ProbeAnota("3 COLUNAS Clientes Col1.CS=[" + loc_oPag.grd_4c_Clientes.Column1.ControlSource + ;
          "] Col4.CS=[" + loc_oPag.grd_4c_Clientes.Column4.ControlSource + ;
          "] Col5.CurrentControl=[" + loc_oPag.grd_4c_Clientes.Column5.CurrentControl + "]")

    *-- Os cursores de trabalho vivem na DataSession PRIVADA do form
    *-- (DataSession=2) - entrar nela para inspecionar diretamente (regra
    *-- feedback_probe_stub_bo_nao_ve_cursor_datasession2). As chamadas a
    *-- metodos do form (goForm.Xxx()) nao precisam disso: o proprio objeto
    *-- troca de sessao internamente ao executar.
    loc_nSessaoAnt = SET("Datasession")
    SET DATASESSION TO (goForm.DataSessionID)

    = ProbeAnota("2b RecCount Tipos=" + TRANSFORM(RECCOUNT(goForm.this_oBusinessObject.this_cCursorTipos)) + ;
          " Clientes=" + TRANSFORM(RECCOUNT(goForm.this_oBusinessObject.this_cCursorClientes)) + ;
          "  (esperado >=1 / 1)")

    SET DATASESSION TO (loc_nSessaoAnt)

    *-- SelTudo / Apaga sobre grdTipo
    goForm.SelTudoClick()
    SET DATASESSION TO (goForm.DataSessionID)
    = ProbeAnota("4 SelTudoClick Imps(1aLinha)=" + ;
          TRANSFORM(EVALUATE(goForm.this_oBusinessObject.this_cCursorTipos + ".Imps")) + ;
          "  (esperado 1, se houver ao menos 1 linha com Dopes preenchido)")
    SET DATASESSION TO (loc_nSessaoAnt)

    goForm.ApagaClick()
    SET DATASESSION TO (goForm.DataSessionID)
    = ProbeAnota("5 ApagaClick Imps(1aLinha)=" + ;
          TRANSFORM(EVALUATE(goForm.this_oBusinessObject.this_cCursorTipos + ".Imps")) + ;
          "  (esperado 0)")
    SET DATASESSION TO (loc_nSessaoAnt)

    *-- Inserir/Excluir linha na grade de Clientes
    LOCAL loc_nRecsAntes, loc_nRecsDepoisInc, loc_nRecsDepoisExc
    SET DATASESSION TO (goForm.DataSessionID)
    loc_nRecsAntes = RECCOUNT(goForm.this_oBusinessObject.this_cCursorClientes)
    SET DATASESSION TO (loc_nSessaoAnt)

    goForm.BtnInserirClick()
    SET DATASESSION TO (goForm.DataSessionID)
    loc_nRecsDepoisInc = RECCOUNT(goForm.this_oBusinessObject.this_cCursorClientes)
    SET DATASESSION TO (loc_nSessaoAnt)

    goForm.BtnExcluirClick()
    SET DATASESSION TO (goForm.DataSessionID)
    loc_nRecsDepoisExc = RECCOUNT(goForm.this_oBusinessObject.this_cCursorClientes)
    SET DATASESSION TO (loc_nSessaoAnt)

    = ProbeAnota("6 Inserir/Excluir RecsAntes=" + TRANSFORM(loc_nRecsAntes) + ;
          " DepoisInserir=" + TRANSFORM(loc_nRecsDepoisInc) + ;
          " DepoisExcluir=" + TRANSFORM(loc_nRecsDepoisExc) + ;
          "  (grade sempre com >=1 linha em branco)")

    *-- Checkbox toggle (CheckE da 1a linha de Clientes)
    LOCAL loc_nAntes, loc_nDepois
    SET DATASESSION TO (goForm.DataSessionID)
    SELECT (goForm.this_oBusinessObject.this_cCursorClientes)
    GO TOP
    loc_nAntes = CheckE
    SET DATASESSION TO (loc_nSessaoAnt)

    goForm.ChkCliEKeyPress(13, 0)

    SET DATASESSION TO (goForm.DataSessionID)
    loc_nDepois = EVALUATE(goForm.this_oBusinessObject.this_cCursorClientes + ".CheckE")
    SET DATASESSION TO (loc_nSessaoAnt)

    = ProbeAnota("7 ChkCliEKeyPress CheckE Antes=" + TRANSFORM(loc_nAntes) + ;
          " Depois=" + TRANSFORM(loc_nDepois) + "  (esperado alternar 0<->1)")

    *-- AlternarPagina
    goForm.AlternarPagina(2)
    = ProbeAnota("8 AlternarPagina(2) ActivePage=" + TRANSFORM(goForm.pgf_4c_Paginas.ActivePage) + ;
          " ModoAtual=" + goForm.this_cModoAtual + "  (esperado 2 / DADOS)")

    goForm.AlternarPagina(1)
    = ProbeAnota("9 AlternarPagina(1) ActivePage=" + TRANSFORM(goForm.pgf_4c_Paginas.ActivePage) + ;
          " ModoAtual=" + goForm.this_cModoAtual + "  (esperado 1 / FILTROS)")

    *-- CmdAddFiltroClick (toggle de visibilidade)
    goForm.CmdAddFiltroClick()
    = ProbeAnota("12 CmdAddFiltroClick Filtros.Visible=" + TRANSFORM(loc_oPag.txt_4c_Filtros.Visible) + ;
          " NewFiltro.Visible=" + TRANSFORM(loc_oPag.txt_4c_NewFiltro.Visible) + ;
          "  (esperado .F. / .T.)")

    *-- Hooks PROTECTED (ValidarFiltrosData/Serializar/RestaurarFiltros):
    *-- alcancados de DENTRO da hierarquia via ProbeHooks()
    = ProbeAnota(goForm.ProbeHooks())

    goForm = .NULL.
    = ProbeAnota("14 LIBERADO")
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    = ProbeAnota("--- ArquivoErroTeste ---" + CHR(13) + CHR(10) + ;
                 FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF

= ProbeAnota("FIM")
QUIT

PROCEDURE ProbeAnota(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_ProbeLog, 1)
    RETURN .T.
ENDPROC

PROCEDURE ProbeErro(par_nErro, par_cMensagem, par_nLinha, par_cPrograma)
    STRTOFILE("ON ERROR #" + TRANSFORM(par_nErro) + " " + par_cMensagem + ;
              " Ln=" + TRANSFORM(par_nLinha) + " Prog=" + par_cPrograma + ;
              CHR(13) + CHR(10), gc_4c_ProbeLog, 1)
    RETURN
ENDPROC

*==============================================================================
* FormSIGOPCGF_Probe - subclasse SO do probe: expoe os hooks PROTECTED
* (ValidarFiltrosData/SerializarFiltros/RestaurarFiltros) chamando-os por
* THIS., de dentro da hierarquia.
*==============================================================================
DEFINE CLASS FormSIGOPCGF_Probe AS FormSIGOPCGF

    PROCEDURE ProbeHooks()
        LOCAL loc_cOut, loc_oPag, loc_cSerial
        loc_cOut = ""
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DtEmiI.Value = DATE() + 10
        loc_oPag.txt_4c_DtEmiF.Value = DATE()
        loc_cOut = loc_cOut + "10 ValidarFiltrosData com DtEmiI>DtEmiF = " + ;
              TRANSFORM(THIS.ValidarFiltrosData()) + "  (esperado .F.)" + CHR(13) + CHR(10)

        loc_oPag.txt_4c_DtEmiI.Value = {}
        loc_oPag.txt_4c_DtEmiF.Value = {}
        loc_cOut = loc_cOut + "11 ValidarFiltrosData vazio = " + ;
              TRANSFORM(THIS.ValidarFiltrosData()) + "  (esperado .T.)" + CHR(13) + CHR(10)

        loc_oPag.txt_4c_Titulos.Value = "T123"
        loc_cSerial = THIS.SerializarFiltros()
        loc_oPag.txt_4c_Titulos.Value = ""
        THIS.RestaurarFiltros(loc_cSerial)
        loc_cOut = loc_cOut + "13 Serializar/Restaurar Titulos=[" + ALLTRIM(loc_oPag.txt_4c_Titulos.Value) + ;
              "]  (esperado T123)"

        RETURN loc_cOut
    ENDPROC

ENDDEFINE
