SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut731
gcOut731 = "C:\4c\automation\probe731f5.txt"
STRTOFILE("PROBE 731 F5 INICIO" + CHR(13) + CHR(10), gcOut731)

*-- Sem banco: o InicializarForm pula CarregarLista em modo teste
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe731f5_erro.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpEnt")
Log731("ambiente OK - gb_4c_ModoTeste=" + TRANSFORM(gb_4c_ModoTeste))

LOCAL loForm, lnI, lcZ

*== INSTANCIA 1: desbloqueada, com os 9 parametros do pai ====================
loForm = CREATEOBJECT("FormSigOpEnt", "001", "MALOTE", 3, DATE() + 10, .NULL., ;
                      5, DATE(), .F., 30)
Log731("CREATEOBJECT(desbloq) -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    lcZ = ""
    FOR lnI = 1 TO loForm.ControlCount
        lcZ = lcZ + IIF(EMPTY(lcZ), "", " | ") + UPPER(loForm.Controls(lnI).Name) + ;
              "(tab=" + TRANSFORM(loForm.Controls(lnI).TabIndex) + ")"
    ENDFOR
    Log731("Z-ORDER/TAB (" + TRANSFORM(loForm.ControlCount) + "): " + lcZ)

    Log731("EXISTEM? lbl_4c_PrazoAtual=" + TRANSFORM(PEMSTATUS(loForm, "lbl_4c_PrazoAtual", 5)) + ;
           " txt_4c_PrazoAtual=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_PrazoAtual", 5)) + ;
           " lbl_4c_PrazoNovo=" + TRANSFORM(PEMSTATUS(loForm, "lbl_4c_PrazoNovo", 5)) + ;
           " txt_4c_PrazoNovo=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_PrazoNovo", 5)))

    DumpLbl731(loForm.lbl_4c_PrazoAtual, "lbl_4c_PrazoAtual (Say1 L315 T110)")
    DumpTxt731(loForm.txt_4c_PrazoAtual, "txt_4c_PrazoAtual (getAtual L315 T124)")
    DumpLbl731(loForm.lbl_4c_PrazoNovo,  "lbl_4c_PrazoNovo (Say2 L315 T161)")
    DumpTxt731(loForm.txt_4c_PrazoNovo,  "txt_4c_PrazoNovo (getNova L315 T175)")

    *-- Truncamento: texto renderizado tem de caber na Width fixada
    Log731("TEXTO vs WIDTH: 'Data Atual' px=" + ;
           TRANSFORM(TXTWIDTH("Data Atual", "Tahoma", 8, "B") * FONTMETRIC(6, "Tahoma", 8, "B")) + ;
           " Width=" + TRANSFORM(loForm.lbl_4c_PrazoAtual.Width) + ;
           " | 'Nova Data' px=" + ;
           TRANSFORM(TXTWIDTH("Nova Data", "Tahoma", 8, "B") * FONTMETRIC(6, "Tahoma", 8, "B")) + ;
           " Width=" + TRANSFORM(loForm.lbl_4c_PrazoNovo.Width))

    *-- Nenhum controle pode passar da borda do Form
    Log731("BORDAS: Form=" + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + ;
           " | campo direita=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Left + loForm.txt_4c_PrazoNovo.Width) + ;
           " | campo baixo=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Top + loForm.txt_4c_PrazoNovo.Height) + ;
           " | rotulo direita=" + TRANSFORM(loForm.lbl_4c_PrazoAtual.Left + loForm.lbl_4c_PrazoAtual.Width))

    *-- Sobreposicao com a grade (105..278) e com a faixa do cabecalho (0..80)
    Log731("SOBREPOSICAO: grade direita=" + TRANSFORM(loForm.grd_4c_Dados.Left + loForm.grd_4c_Dados.Width) + ;
           " < campo Left=" + TRANSFORM(loForm.txt_4c_PrazoAtual.Left) + ;
           " | faixa fim=" + TRANSFORM(loForm.cnt_4c_Sombra.Top + loForm.cnt_4c_Sombra.Height) + ;
           " < rotulo Top=" + TRANSFORM(loForm.lbl_4c_PrazoAtual.Top))

    *-- Valor inicial: getAtual = pPrz, getNova = vazio (Ctod(''))
    Log731("VALORES: PrazoAtual=[" + TRANSFORM(loForm.txt_4c_PrazoAtual.Value) + "] tipo=" + ;
           VARTYPE(loForm.txt_4c_PrazoAtual.Value) + ;
           " | PrazoNovo=[" + TRANSFORM(loForm.txt_4c_PrazoNovo.Value) + "] tipo=" + ;
           VARTYPE(loForm.txt_4c_PrazoNovo.Value) + " EMPTY=" + ;
           TRANSFORM(EMPTY(loForm.txt_4c_PrazoNovo.Value)))
    Log731("BO: this_dPrazoAtual=[" + TRANSFORM(loForm.this_oBusinessObject.this_dPrazoAtual) + "]" + ;
           " this_dPrazoNovo EMPTY=" + TRANSFORM(EMPTY(loForm.this_oBusinessObject.this_dPrazoNovo)))

    *-- Data brasileira na datasession privada (DataSession = 2)
    Log731("DATASESSION=" + TRANSFORM(loForm.DataSessionId) + ;
           " SET DATE=" + SET("DATE") + " CENTURY=" + SET("CENTURY") + ;
           " DTOC(PrazoAtual)=" + DTOC(loForm.txt_4c_PrazoAtual.Value))

    *-- Desbloqueado: getNova e Confirmar habilitados
    Log731("ENABLED(desbloq): PrazoNovo=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Enabled) + ;
           " Confirmar=" + TRANSFORM(loForm.cmd_4c_Confirmar.Enabled) + ;
           " Cancelar=" + TRANSFORM(loForm.cmd_4c_Cancelar.Enabled))

    *-- "When / Return .f." do getAtual
    Log731("SOMENTE-LEITURA: PrazoAtual.ReadOnly=" + TRANSFORM(loForm.txt_4c_PrazoAtual.ReadOnly) + ;
           " TabStop=" + TRANSFORM(loForm.txt_4c_PrazoAtual.TabStop) + ;
           " Enabled=" + TRANSFORM(loForm.txt_4c_PrazoAtual.Enabled) + ;
           " | PrazoNovo.ReadOnly=" + TRANSFORM(loForm.txt_4c_PrazoNovo.ReadOnly) + ;
           " TabStop=" + TRANSFORM(loForm.txt_4c_PrazoNovo.TabStop))

    *-- Funil pos-gravacao: BO muda, Sincronizar espelha e LIMPA a data nova
    loForm.txt_4c_PrazoNovo.Value            = DATE() + 20
    loForm.this_oBusinessObject.this_dPrazoNovo = DATE() + 20
    loForm.this_oBusinessObject.this_dPrazoAtual = DATETIME() + 86400 * 20   && DATETIME de proposito
    loForm.SincronizarCamposPrazo()
    Log731("FUNIL: PrazoAtual=[" + TRANSFORM(loForm.txt_4c_PrazoAtual.Value) + "] tipo=" + ;
           VARTYPE(loForm.txt_4c_PrazoAtual.Value) + ;
           " | PrazoNovo EMPTY=" + TRANSFORM(EMPTY(loForm.txt_4c_PrazoNovo.Value)) + ;
           " tipo=" + VARTYPE(loForm.txt_4c_PrazoNovo.Value) + ;
           " | BO.this_dPrazoNovo EMPTY=" + TRANSFORM(EMPTY(loForm.this_oBusinessObject.this_dPrazoNovo)))

    *-- Reaplicacao do bloqueio pelo funil
    loForm.this_oBusinessObject.this_lBloquear = .T.
    loForm.AplicarBloqueioAlteracao()
    Log731("FUNIL BLOQUEIO: PrazoNovo.Enabled=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Enabled) + ;
           " Confirmar.Enabled=" + TRANSFORM(loForm.cmd_4c_Confirmar.Enabled))

    *-- Visibilidade (AddObject nasce .F.; TornarControlesVisiveis repoe)
    Log731("VISIBLE: lblA=" + TRANSFORM(loForm.lbl_4c_PrazoAtual.Visible) + ;
           " txtA=" + TRANSFORM(loForm.txt_4c_PrazoAtual.Visible) + ;
           " lblN=" + TRANSFORM(loForm.lbl_4c_PrazoNovo.Visible) + ;
           " txtN=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Visible))

    *-- Harness: CarregarLista continua PUBLIC e funcionando
    Log731("CarregarLista()=" + TRANSFORM(loForm.CarregarLista()) + ;
           " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), -1)))

    loForm.Release()
    Log731("Release(1) OK")
ENDIF

*== INSTANCIA 2: pBlqAlt = .T. (so consulta) =================================
loForm = CREATEOBJECT("FormSigOpEnt", "001", "MALOTE", 7, DATE() + 4, .NULL., ;
                      0, DATE(), .T., 0)
Log731("CREATEOBJECT(bloq) -> VARTYPE=" + VARTYPE(loForm))
IF VARTYPE(loForm) = "O"
    Log731("ENABLED(bloq): PrazoNovo=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Enabled) + ;
           " Confirmar=" + TRANSFORM(loForm.cmd_4c_Confirmar.Enabled) + ;
           " Cancelar=" + TRANSFORM(loForm.cmd_4c_Cancelar.Enabled) + ;
           " | BO.this_lBloquear=" + TRANSFORM(loForm.this_oBusinessObject.this_lBloquear))
    Log731("FOCO one-shot: this_lFocoInicialAplicado=" + TRANSFORM(loForm.this_lFocoInicialAplicado))
    loForm.Release()
    Log731("Release(2) OK")
ENDIF

*== INSTANCIA 3: sem nenhum parametro (harness/probe headless) ===============
loForm = CREATEOBJECT("FormSigOpEnt")
Log731("CREATEOBJECT(sem params) -> VARTYPE=" + VARTYPE(loForm))
IF VARTYPE(loForm) = "O"
    Log731("SEM PARAMS: PrazoAtual EMPTY=" + TRANSFORM(EMPTY(loForm.txt_4c_PrazoAtual.Value)) + ;
           " PrazoNovo.Enabled=" + TRANSFORM(loForm.txt_4c_PrazoNovo.Enabled) + ;
           " tab(novo/conf/grd/lblA/txtA/lblN/canc)=" + ;
           TRANSFORM(loForm.txt_4c_PrazoNovo.TabIndex) + "/" + ;
           TRANSFORM(loForm.cmd_4c_Confirmar.TabIndex) + "/" + ;
           TRANSFORM(loForm.grd_4c_Dados.TabIndex) + "/" + ;
           TRANSFORM(loForm.lbl_4c_PrazoAtual.TabIndex) + "/" + ;
           TRANSFORM(loForm.txt_4c_PrazoAtual.TabIndex) + "/" + ;
           TRANSFORM(loForm.lbl_4c_PrazoNovo.TabIndex) + "/" + ;
           TRANSFORM(loForm.cmd_4c_Cancelar.TabIndex))
    loForm.Release()
    Log731("Release(3) OK")
ENDIF

Log731("ARQUIVO DE ERRO DO FORMBASE existe=" + TRANSFORM(FILE(gc_4c_ArquivoErroTeste)))
IF FILE(gc_4c_ArquivoErroTeste)
    Log731("CONTEUDO: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF
Log731("CK99 FIM")
QUIT


PROCEDURE Log731(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut731, 1)
ENDPROC

PROCEDURE DumpLbl731(par_oObj, par_cNome)
    Log731("LBL " + par_cNome + ": Cap=[" + par_oObj.Caption + "]" + ;
        " L/T=" + TRANSFORM(par_oObj.Left) + "/" + TRANSFORM(par_oObj.Top) + ;
        " W/H=" + TRANSFORM(par_oObj.Width) + "/" + TRANSFORM(par_oObj.Height) + ;
        " Font=" + par_oObj.FontName + " " + TRANSFORM(par_oObj.FontSize) + ;
        " Bold=" + TRANSFORM(par_oObj.FontBold) + ;
        " AutoSize=" + TRANSFORM(par_oObj.AutoSize) + ;
        " Align=" + TRANSFORM(par_oObj.Alignment) + ;
        " BackStyle=" + TRANSFORM(par_oObj.BackStyle) + ;
        " WordWrap=" + TRANSFORM(par_oObj.WordWrap) + ;
        " ForeColor=" + TRANSFORM(par_oObj.ForeColor) + ;
        " (90,90,90=" + TRANSFORM(RGB(90, 90, 90)) + ")")
ENDPROC

PROCEDURE DumpTxt731(par_oObj, par_cNome)
    Log731("TXT " + par_cNome + ":" + ;
        " L/T=" + TRANSFORM(par_oObj.Left) + "/" + TRANSFORM(par_oObj.Top) + ;
        " W/H=" + TRANSFORM(par_oObj.Width) + "/" + TRANSFORM(par_oObj.Height) + ;
        " Font=" + par_oObj.FontName + " " + TRANSFORM(par_oObj.FontSize) + ;
        " Align=" + TRANSFORM(par_oObj.Alignment) + ;
        " Themes=" + TRANSFORM(par_oObj.Themes) + ;
        " ForeColor=" + TRANSFORM(par_oObj.ForeColor) + ;
        " ValueType=" + VARTYPE(par_oObj.Value) + ;
        " Format=[" + par_oObj.Format + "]" + ;
        " InputMask=[" + par_oObj.InputMask + "]" + ;
        " ControlSource=[" + par_oObj.ControlSource + "]")
ENDPROC
