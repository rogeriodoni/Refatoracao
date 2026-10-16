*==============================================================================
* ProbeSigPrMdc.prg - Instancia FormSigPrMdc headless e exercita os caminhos
* reais (grade, incluir/excluir linha, LimparCampos, FormParaBO/BOParaForm,
* AtualizarProgresso, AjustarBotoesPorModo, CarregarLista).
* NAO chama ConfigurarAmbiente() (bloqueia nesta maquina) nem conecta ao SQL
* Server (192.168.200.10 sem rota) - nenhum destes caminhos precisa de SQL.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_ProbeOut
gc_4c_ProbeOut         = "C:\4c\automation\ProbeSigPrMdc.txt"
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeSigPrMdc_erros.txt"
gnConnHandle           = -1

STRTOFILE("=== PROBE FormSigPrMdc ===" + CHR(13) + CHR(10), gc_4c_ProbeOut)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg
Passo("[1] config.prg OK")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrMdcBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrMdc.prg") ADDITIVE
Passo("[2] SET PROCEDURE OK")

LOCAL loF, loE, lnDS, lcM, lnI
loF = .NULL.
TRY
    *-- Subclasse: LimparCampos/FormParaBO/BOParaForm sao PROTECTED em FormBase
    *-- e o VFP9 nao deixa alargar o escopo - script solto NAO alcanca, subclasse
    *-- alcanca. Por isso o probe instancia ProbeFormSigPrMdc, nao FormSigPrMdc.
    loF = CREATEOBJECT("ProbeFormSigPrMdc", .F.)
CATCH TO loE
    Passo("[3] FALHA CREATEOBJECT: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo) + ;
        " PROC=" + loE.Procedure)
ENDTRY

IF VARTYPE(loF) <> "O"
    Passo("[3] ABORTADO - VARTYPE=" + VARTYPE(loF))
ELSE
    Passo("[3] CREATEOBJECT OK classe=" + loF.Class + " W=" + TRANSFORM(loF.Width) + ;
        " H=" + TRANSFORM(loF.Height) + " modo=" + loF.this_cModoAtual)

    *-- O cursor do form vive na datasession PRIVADA (DataSession = 2)
    lnDS = SET("DATASESSION")
    SET DATASESSION TO loF.DataSessionId

    Passo("[4] USED(cursor_4c_Contas)=" + TRANSFORM(USED("cursor_4c_Contas")) + ;
        " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Contas"), RECCOUNT("cursor_4c_Contas"), -1)))

    Passo("[5] Grid RecordSource=[" + loF.grd_4c_Dados.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loF.grd_4c_Dados.ColumnCount) + ;
        " C1.Src=[" + loF.grd_4c_Dados.Column1.ControlSource + "]" + ;
        " C2.Src=[" + loF.grd_4c_Dados.Column2.ControlSource + "]" + ;
        " C1.Hdr=[" + loF.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
        " C2.Hdr=[" + loF.grd_4c_Dados.Column2.Header1.Caption + "]" + ;
        " C1.W=" + TRANSFORM(loF.grd_4c_Dados.Column1.Width) + ;
        " C2.W=" + TRANSFORM(loF.grd_4c_Dados.Column2.Width))

    *-- BtnIncluirClick com o par VAZIO: legado NAO acrescenta linha
    TRY
        loF.BtnIncluirClick()
        Passo("[6] BtnIncluirClick par VAZIO OK -> RECCOUNT=" + ;
            TRANSFORM(RECCOUNT("cursor_4c_Contas")) + " (esperado 1)")
    CATCH TO loE
        Passo("[6] FALHA BtnIncluirClick: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- Par preenchido: agora DEVE acrescentar linha nova e ficar nela
    SELECT cursor_4c_Contas
    GO TOP
    REPLACE ContaAnt WITH "0000000001", ContaNov WITH "0000000002"
    TRY
        loF.BtnIncluirClick()
        Passo("[7] BtnIncluirClick par CHEIO OK -> RECCOUNT=" + ;
            TRANSFORM(RECCOUNT("cursor_4c_Contas")) + " (esperado 2) RECNO=" + ;
            TRANSFORM(RECNO("cursor_4c_Contas")) + " (esperado 2)")
    CATCH TO loE
        Passo("[7] FALHA BtnIncluirClick: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    TRY
        loF.BtnExcluirClick()
        Passo("[8] BtnExcluirClick OK -> RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Contas")) + ;
            " naoDeletados=" + TRANSFORM(RECCOUNT("cursor_4c_Contas")) + " [RECCOUNT conta deletados]")
    CATCH TO loE
        Passo("[8] FALHA BtnExcluirClick: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- ChkRepsClick: ligar chkReps zera e desabilita Chk_DelCT (When do legado)
    TRY
        loF.chk_4c_Chk_DelCT.Value = 1
        loF.chk_4c_ChkReps.Value   = 1
        loF.ChkRepsClick()
        Passo("[9] ChkRepsClick OK -> DelCT.Value=" + TRANSFORM(loF.chk_4c_Chk_DelCT.Value) + ;
            " (esperado 0) DelCT.Enabled=" + TRANSFORM(loF.chk_4c_Chk_DelCT.Enabled) + ;
            " (esperado .F.)")
    CATCH TO loE
        Passo("[9] FALHA ChkRepsClick: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- FormParaBO / BOParaForm (ida e volta)
    TRY
        loF.chk_4c_ChkReps.Value   = 0
        loF.chk_4c_Chk_DelCT.Value = 1
        Passo("[10] FormParaBO=" + TRANSFORM(loF.ProbeFormParaBO()) + ;
            " -> BO.TrocarReps=" + TRANSFORM(loF.this_oBusinessObject.this_lTrocarReps) + ;
            " BO.ApagarAntiga=" + TRANSFORM(loF.this_oBusinessObject.this_lApagarContaAntiga) + ;
            " BO.CheckCadPro=" + TRANSFORM(loF.this_oBusinessObject.this_lCheckCadPro) + ;
            " BO.ContaAnt=[" + ALLTRIM(loF.this_oBusinessObject.this_cContaAnt) + "]")
        loF.chk_4c_Chk_DelCT.Value = 0
        Passo("[11] BOParaForm=" + TRANSFORM(loF.ProbeBOParaForm()) + ;
            " -> DelCT.Value=" + TRANSFORM(loF.chk_4c_Chk_DelCT.Value) + ;
            " (esperado 1, restaurado do BO)")
    CATCH TO loE
        Passo("[10/11] FALHA FormParaBO/BOParaForm: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- AjustarBotoesPorModo nos dois estados (regra #40 - reabilitar na volta)
    TRY
        loF.this_cModoAtual = "PROCESSANDO"
        loF.AjustarBotoesPorModo()
        Passo("[12] PROCESSANDO -> Incluir=" + TRANSFORM(loF.cmd_4c_BtnIncluir.Enabled) + ;
            " Processar=" + TRANSFORM(loF.cmd_4c_BtnProcessar.Enabled) + ;
            " Grid=" + TRANSFORM(loF.grd_4c_Dados.Enabled) + ;
            " Sair=" + TRANSFORM(loF.cmd_4c_BtnSair.Enabled) + " (Sair NUNCA trava)")
        loF.this_cModoAtual = "EDICAO"
        loF.AjustarBotoesPorModo()
        Passo("[13] EDICAO -> Incluir=" + TRANSFORM(loF.cmd_4c_BtnIncluir.Enabled) + ;
            " Processar=" + TRANSFORM(loF.cmd_4c_BtnProcessar.Enabled) + ;
            " Grid=" + TRANSFORM(loF.grd_4c_Dados.Enabled) + " (todos .T. = reabilitou)")
    CATCH TO loE
        Passo("[12/13] FALHA AjustarBotoesPorModo: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- AtualizarProgresso: contrato que BO.ProcessarMudancaContas espera
    TRY
        loF.AtualizarProgresso("SIGCDCLI / ICLIS", 50)
        Passo("[14] AtualizarProgresso OK -> txt=[" + ALLTRIM(loF.cnt_4c_Result.txt_4c_Arquivo.Value) + "]" + ;
            " barraW=" + TRANSFORM(loF.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width) + ;
            " (esperado 100) pct=[" + loF.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption + "]")
    CATCH TO loE
        Passo("[14] FALHA AtualizarProgresso: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- LimparCampos: reset do lote
    TRY
        SELECT cursor_4c_Contas
        GO TOP
        REPLACE ContaAnt WITH "0000000009", ContaNov WITH "0000000008"
        Passo("[15] LimparCampos=" + TRANSFORM(loF.ProbeLimparCampos()) + ;
            " -> RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Contas")) + " (esperado 1)" + ;
            " ContaAnt=[" + ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "?")) + "] (esperado vazio)" + ;
            " modo=" + loF.this_cModoAtual)
    CATCH TO loE
        Passo("[15] FALHA LimparCampos: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- CarregarLista SEM argumento (o harness chama assim)
    TRY
        Passo("[16] CarregarLista() sem arg=" + TRANSFORM(loF.CarregarLista()))
    CATCH TO loE
        Passo("[16] FALHA CarregarLista: " + loE.Message + " LN=" + TRANSFORM(loE.LineNo))
    ENDTRY

    *-- Escopo dos metodos chamados de FORA da classe (regra #3 / #51)
    LOCAL ARRAY laM[9]
    laM[1] = "CarregarLista"
    laM[2] = "AjustarBotoesPorModo"
    laM[3] = "AtualizarProgresso"
    laM[4] = "LimparCampos"
    laM[5] = "FormParaBO"
    laM[6] = "BOParaForm"
    laM[7] = "HabilitarCampos"
    laM[8] = "BtnIncluirClick"
    laM[9] = "BtnProcessarClick"
    lcM = ""
    FOR lnI = 1 TO 9
        lcM = lcM + laM[lnI] + "=" + ;
            IIF(PEMSTATUS(loF, laM[lnI], 2), "PROTECTED!", "public") + " "
    ENDFOR
    Passo("[17] escopo: " + lcM)

    *-- Escopo dos metodos do BO chamados pelo FORM (regra #51)
    LOCAL ARRAY laB[7]
    laB[1] = "ValidarParesContas"
    laB[2] = "ValidarCodigoConta"
    laB[3] = "ImportarDeXLS"
    laB[4] = "TrocarContaRepresentantes"
    laB[5] = "ExcluirContaAntiga"
    laB[6] = "InicializarCursorContas"
    laB[7] = "ValidarArqDBF"
    lcM = ""
    FOR lnI = 1 TO 7
        lcM = lcM + laB[lnI] + "=" + ;
            IIF(!PEMSTATUS(loF.this_oBusinessObject, laB[lnI], 5), "AUSENTE!", ;
                IIF(PEMSTATUS(loF.this_oBusinessObject, laB[lnI], 2), "PROTECTED!", "public")) + " "
    ENDFOR
    Passo("[18] escopo BO: " + lcM)

    SET DATASESSION TO (lnDS)

    TRY
        loF.Release()
        Passo("[19] Release OK")
    CATCH TO loE
        Passo("[19] FALHA Release: " + loE.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    Passo("[20] ERROS GRAVADOS NO MODO TESTE:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Passo("[20] nenhum erro gravado em gc_4c_ArquivoErroTeste")
ENDIF

Passo("=== FIM ===")
*-- Subclasse de prova: alcanca os hooks PROTECTED de FormBase
DEFINE CLASS ProbeFormSigPrMdc AS FormSigPrMdc
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ProbeLimparCampos()
        RETURN THIS.LimparCampos()
    ENDPROC
ENDDEFINE

QUIT

PROCEDURE Passo(par_cTxt)
    STRTOFILE(par_cTxt + CHR(13) + CHR(10), gc_4c_ProbeOut, 1)
ENDPROC
