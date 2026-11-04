*==============================================================================
* ProbeErro307Botoes.prg - Confere no FORM INSTANCIADO que Incluir/Alterar/
* Excluir ficam DESABILITADOS (legado so-consulta) e que Visualizar/Buscar/
* Encerrar continuam ativos. Confere tambem os combos Menu e Tipo e o Submenu.
* Usa a COPIA do .prg (o app aberto segura o .fxp do projeto).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gcLB
gb_4c_ModoTeste        = .T.
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_307b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gcLB = "C:\4c\automation\probe_erro307_botoes.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLB)

LOCAL loc_oE, loF, loPg1, loPg2, lnI

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

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
    SET PROCEDURE TO ("C:\Users\roger\AppData\Local\Temp\claude\C--4c\5c3d6e1b-73f7-4c38-8cb7-934e8d60a318\scratchpad\chk307\OpsBO.prg")   ADDITIVE
    SET PROCEDURE TO ("C:\Users\roger\AppData\Local\Temp\claude\C--4c\5c3d6e1b-73f7-4c38-8cb7-934e8d60a318\scratchpad\chk307\FormOps.prg") ADDITIVE
    LB("B: deps carregadas (copias)")

    *-- com banco, para o combo Tipo poder ser populado de SigCdTom
    gnConnHandle = SQLSTRINGCONNECT("DRIVER={SQL Server};SERVER=192.168.200.10;" + ;
        "DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;")
    LB("C: gnConnHandle = " + TRANSFORM(gnConnHandle))

    loF = CREATEOBJECT("FormOps")
    LB("D: CREATEOBJECT -> " + VARTYPE(loF))

    IF VARTYPE(loF) = "O"
        loPg1 = loF.pgf_4c_Paginas.Page1
        loPg2 = loF.pgf_4c_Paginas.Page2

        LB("E: --- botoes da pagina Lista ---")
        LB("   Incluir    Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + "   (esperado .F.)")
        LB("   Alterar    Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled) + "   (esperado .F.)")
        LB("   Excluir    Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled) + "   (esperado .F.)")
        LB("   Visualizar Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled) + "   (esperado .T.)")
        LB("   Buscar     Enabled=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + "   (esperado .T.)")
        LB("   Encerrar   Enabled=" + TRANSFORM(loPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled) + "   (esperado .T.)")

        *-- o AjustarBotoesPorModo nao pode reabilitar (regra #40)
        loF.AjustarBotoesPorModo()
        LB("F: apos AjustarBotoesPorModo -> Incluir=" + ;
           TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
           " Alterar=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled) + ;
           " Excluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled))

        LB("G: --- combo Menu ---")
        LB("   RowSourceType=" + TRANSFORM(loPg2.cbo_4c_CmbMenus.RowSourceType) + ;
           "  RowSource=[" + loPg2.cbo_4c_CmbMenus.RowSource + "]" + ;
           "  itens=" + TRANSFORM(loPg2.cbo_4c_CmbMenus.ListCount) + ;
           "  Enabled=" + TRANSFORM(loPg2.cbo_4c_CmbMenus.Enabled))
        FOR lnI = 1 TO loPg2.cbo_4c_CmbMenus.ListCount
            LB("      [" + loPg2.cbo_4c_CmbMenus.List(lnI) + "]")
        ENDFOR

        LB("H: --- combo Tipo ---")
        LB("   itens=" + TRANSFORM(loPg2.cbo_4c_CmbTOpers.ListCount) + ;
           "  Enabled=" + TRANSFORM(loPg2.cbo_4c_CmbTOpers.Enabled))
        FOR lnI = 1 TO MIN(5, loPg2.cbo_4c_CmbTOpers.ListCount)
            LB("      [" + loPg2.cbo_4c_CmbTOpers.List(lnI) + "]")
        ENDFOR
        IF loPg2.cbo_4c_CmbTOpers.ListCount > 5
            LB("      ... (+" + TRANSFORM(loPg2.cbo_4c_CmbTOpers.ListCount - 5) + ")")
        ENDIF
        *-- seleciona o tipo 4 (VENDAS) como o legado faria ao carregar
        loF.SelecionarTipoOps(4)
        LB("   SelecionarTipoOps(4) -> Value=[" + loPg2.cbo_4c_CmbTOpers.Value + "]")
        loF.SelecionarTipoOps(0)
        LB("   SelecionarTipoOps(0) -> Value=[" + loPg2.cbo_4c_CmbTOpers.Value + "]  (00-OUTROS, antes era escondido)")

        LB("I: --- Submenu ---")
        LB("   MaxLength=" + TRANSFORM(loPg2.txt_4c_SubMenus.MaxLength) + ;
           " (legado 14)  ReadOnly=" + TRANSFORM(loPg2.txt_4c_SubMenus.ReadOnly))

        loF.Release()
        LB("J: Release OK")
    ENDIF
    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
        =SQLDISCONNECT(gnConnHandle)
    ENDIF
CATCH TO loc_oE
    LB("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
       " | Proc:" + loc_oE.Procedure)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLB, 1)
QUIT

PROCEDURE LB(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLB, 1)
ENDPROC
