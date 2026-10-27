*==============================================================================
* InstantiateCheckCgfF5.prg - Probe da Fase 5/8 do FormSIGOPCGF (Page2
* Dados: Shape1 + cmgRetornar + 6 botoes de acao + 1a metade dos campos).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_ProbeLog
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\InstantiateCheckCgfF5_err.txt"
gc_4c_ProbeLog         = "C:\4c\automation\InstantiateCheckCgfF5.txt"

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
    goForm = CREATEOBJECT("FormSIGOPCGF")
CATCH TO loErr
    = ProbeAnota("EXCECAO CREATEOBJECT: " + loErr.Message + " Ln=" + ;
                 TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure)
ENDTRY

IF VARTYPE(goForm) != "O"
    = ProbeAnota("1 INSTANCIA FALHOU VARTYPE=" + VARTYPE(goForm))
ELSE
    = ProbeAnota("1 INSTANCIA OK BaseClass=" + goForm.BaseClass)

    LOCAL loc_oPag
    loc_oPag = goForm.pgf_4c_Paginas.Page2

    = ProbeAnota("2 Shape1 Top=" + TRANSFORM(loc_oPag.shp_4c_Shape1.Top) + ;
          " Left=" + TRANSFORM(loc_oPag.shp_4c_Shape1.Left) + "  (esperado 83/6)")

    = ProbeAnota("3 cmgRetornar.ButtonCount=" + TRANSFORM(loc_oPag.obj_4c_CmgRetornar.ButtonCount) + ;
          " Buttons(1).Caption=[" + loc_oPag.obj_4c_CmgRetornar.Buttons(1).Caption + "]")

    = ProbeAnota("4 Botoes acao: Recebe.Caption=[" + loc_oPag.cmd_4c_BtnRecebe.Caption + ;
          "] Movimento.Caption=[" + loc_oPag.cmd_4c_BtnMovimento.Caption + ;
          "] FollowUpC.Caption=[" + loc_oPag.cmd_4c_BtnFollowUpC.Caption + ;
          "] FollowUpL.Caption=[" + loc_oPag.cmd_4c_BtnFollowUpL.Caption + ;
          "] Imprimir.Caption=[" + loc_oPag.cmd_4c_BtnImprimir.Caption + ;
          "] Planilha.Caption=[" + loc_oPag.cmd_4c_BtnPlanilha.Caption + "]")

    = ProbeAnota("5 cbo_4c_Ordem.RowSource=[" + loc_oPag.cbo_4c_Ordem.RowSource + "]")

    = ProbeAnota("6 Campos: NFs.Value=[" + loc_oPag.txt_4c_NFs.Value + ;
          "] EspecieNfs.Value=[" + loc_oPag.txt_4c_EspecieNfs.Value + ;
          "] Emps.Value=[" + loc_oPag.txt_4c_Emps.Value + ;
          "] ContEms.Value=[" + loc_oPag.txt_4c_ContEms.Value + ;
          "] DContEms.Value=[" + loc_oPag.txt_4c_DContEms.Value + ;
          "] Contas.Value=[" + loc_oPag.txt_4c_Contas.Value + ;
          "] DContas.Value=[" + loc_oPag.txt_4c_DContas.Value + "]")

    *-- Navegacao Page1 <-> Page2 via cmgRetornar (ja bindado e funcional)
    goForm.AlternarPagina(2)
    goForm.CmgRetornarClick()
    = ProbeAnota("7 Apos CmgRetornarClick ActivePage=" + TRANSFORM(goForm.pgf_4c_Paginas.ActivePage) + ;
          " ModoAtual=" + goForm.this_cModoAtual + "  (esperado 1 / FILTROS)")

    goForm = .NULL.
    = ProbeAnota("8 LIBERADO")
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
