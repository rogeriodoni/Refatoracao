*==============================================================================
* probef8sigopflp734.prg - Exercita em RUNTIME os entregaveis da Fase 8 do
* FormSigOpFlp (task734): Confirmar/Cancelar do painel (Inserir e Alterar via
* SQL real), Encerrar (SalvarContato idempotente), AtualizarCamposCliente e o
* atalho de teclado da grade (GridColumnKeyPress). SQL Server alcancavel desta
* maquina em 2026-11-04 (ver memoria project_sqlserver_200_10...) - usa conexao
* REAL para provar o INSERT/UPDATE, e desfaz no final (DELETE do historico de
* teste; o contato gravado por Encerrar eh idempotente - mesmo valor de volta).
*
* Setup conforme a receita medida nesta maquina: DO config.prg + SET PATH +
* SET PROCEDURE a mao, SEM ConfigurarAmbiente(). gb_4c_ModoTeste = .T. so para
* suprimir dialogs (MsgErro/MsgAviso) - NAO impede SQL real, so pula
* CarregarLista()/ObterAcesso() internos do Init, chamados a mao abaixo.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m734\probe_f8_dialogs.txt"

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m734\probe_f8_sigopflp.txt"
loc_cOut = "=== PROBE Fase 8 - FormSigOpFlp (task734) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFlpBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFlp.prg") ADDITIVE

*-- [1] Conexao REAL (SQL Server alcancavel desta maquina - 2026-11-04)
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
gnConnHandle = SQLSTRINGCONNECT("DRIVER={SQL Server};SERVER=192.168.200.10;" + ;
    "DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;")

loc_cOut = loc_cOut + "[1] gnConnHandle=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

IF gnConnHandle <= 0
    loc_cOut = loc_cOut + "[1] FALHA DE CONEXAO - abortando probe" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF

*-- [2] Conta de teste: 1a linha de SigCdCli, so leitura
LOCAL loc_cContaTeste, loc_nResult
loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 iclis, grupos FROM SigCdCli ORDER BY iclis", "cursor_4c_ProbeCli")
IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProbeCli") > 0
    SELECT cursor_4c_ProbeCli
    GO TOP
    loc_cContaTeste = ALLTRIM(cursor_4c_ProbeCli.iclis)
    loc_cOut = loc_cOut + "[2] conta de teste=[" + loc_cContaTeste + "] grupo=[" + ;
        ALLTRIM(cursor_4c_ProbeCli.grupos) + "]" + CHR(13) + CHR(10)
    USE IN cursor_4c_ProbeCli
ELSE
    loc_cOut = loc_cOut + "[2] FALHA - SigCdCli sem linhas (result=" + ;
        TRANSFORM(loc_nResult) + ") - abortando" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [3] Instancia o form com a conta real
LOCAL loc_oForm, loc_oErro
TRY
    loc_oForm = CREATEOBJECT("FormSigOpFlp", loc_cContaTeste, {}, 0)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[3] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) <> "O"
    loc_cOut = loc_cOut + "[3] Form NAO instanciado" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF
loc_cOut = loc_cOut + "[3] Form instanciado OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] CarregarLista a mao (gb_4c_ModoTeste pula a chamada automatica do Init)
*-- cursor_4c_Dados vive na DataSession PRIVADA do form (DataSession=2) - o
*-- script roda na sessao 1 por default, entao SELECT/USED/LOCATE sobre ele
*-- aqui no probe exigem SET DATASESSION TO loc_oForm.DataSessionId antes
*-- (regra: feedback_probe_stub_bo_nao_ve_cursor_datasession2).
LOCAL loc_lCarregouOK, loc_nSessaoAnt, loc_nReccountGrade, loc_oErroDS
loc_lCarregouOK = loc_oForm.CarregarLista()

loc_nSessaoAnt = SET("Datasession")
loc_cOut = loc_cOut + "[4-diag] DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
    " sessaoAntes=" + TRANSFORM(loc_nSessaoAnt) + CHR(13) + CHR(10)

loc_nReccountGrade = -1
TRY
    SET DATASESSION TO (loc_oForm.DataSessionId)
    loc_cOut = loc_cOut + "[4-diag] sessaoDepoisDoSwitch=" + TRANSFORM(SET("Datasession")) + ;
        " AUSED=" + TRANSFORM(AUSED("loc_aAliases")) + CHR(13) + CHR(10)
    IF USED("cursor_4c_Dados")
        loc_nReccountGrade = RECCOUNT("cursor_4c_Dados")
    ENDIF
CATCH TO loc_oErroDS
    loc_cOut = loc_cOut + "[4-diag] ERRO no switch/USED: " + loc_oErroDS.Message + CHR(13) + CHR(10)
ENDTRY
SET DATASESSION TO (loc_nSessaoAnt)

loc_cOut = loc_cOut + "[4] CarregarLista=" + TRANSFORM(loc_lCarregouOK) + ;
    " grupo=[" + loc_oForm.this_cGrupo + "] conta=[" + loc_oForm.this_cConta + "]" + ;
    " reccountGrade=" + TRANSFORM(loc_nReccountGrade) + ;
    CHR(13) + CHR(10)
loc_cOut = loc_cOut + "[4] CntGruCon: grupo=[" + ALLTRIM(loc_oForm.cnt_4c_GruCon.txt_4c_Grupo.Value) + ;
    "] conta=[" + ALLTRIM(loc_oForm.cnt_4c_GruCon.txt_4c_Conta.Value) + ;
    "] razao=[" + ALLTRIM(loc_oForm.cnt_4c_GruCon.txt_4c_DConta.Value) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "[4] CntContato: tel1=[" + ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Tel1.Value) + ;
    "] tel2=[" + ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Tel2.Value) + ;
    "] ddd=[" + ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_DDDs.Value) + ;
    "] email=[" + ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Email.Value) + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] GridColumnKeyPress(-1,...) = atalho F2 -> deve equivaler a BtnIncluirClick
loc_oForm.GridColumnKeyPress(-1, 0)
loc_cOut = loc_cOut + "[5] F2 via GridColumnKeyPress: painel=" + ;
    TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)

*-- Cancela esse Incluir disparado pelo atalho antes do teste "oficial" de Incluir
loc_oForm.BtnCancelarClick()
loc_cOut = loc_cOut + "[5] apos Cancelar: painel=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] Incluir (real): abre painel, preenche Historico/Observacao com marcador
*-- UNICO e confirma (BtnSalvarClick -> PainelParaBO + NovoRegistro + Salvar)
LOCAL loc_cMarcador, loc_cMarcador2
loc_cMarcador = "TST_F8_" + SYS(2015)
loc_oForm.BtnIncluirClick()
loc_oForm.cnt_4c__Inserir.txt_4c_Hist.Value   = loc_cMarcador
loc_oForm.cnt_4c__Inserir.obj_4c_GetObs.Value = "Obs inclusao probe fase8"
loc_oForm.BtnSalvarClick()
loc_cOut = loc_cOut + "[6] apos Confirmar(Incluir): painel=" + ;
    TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + " tipo=[" + loc_oForm.this_cTipo + "]" + ;
    " grade=" + TRANSFORM(loc_oForm.grd_4c_Dados.Visible) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] Confirma via SQL direto que o INSERT realmente aconteceu, e captura a
*-- chave gerada (fUniqueIds) para a limpeza final
LOCAL loc_cCidChaveTeste
loc_cCidChaveTeste = ""
loc_nResult = SQLEXEC(gnConnHandle, "SELECT cidchaves, obs FROM SigCdClh WHERE hists = " + ;
    EscaparSQL(loc_cMarcador), "cursor_4c_ProbeIns")
IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProbeIns") = 1
    SELECT cursor_4c_ProbeIns
    GO TOP
    loc_cCidChaveTeste = ALLTRIM(cursor_4c_ProbeIns.cidchaves)
    loc_cOut = loc_cOut + "[7] INSERT confirmado via SQL - cidchaves=[" + loc_cCidChaveTeste + ;
        "] obs=[" + ALLTRIM(cursor_4c_ProbeIns.obs) + "]" + CHR(13) + CHR(10)
    USE IN cursor_4c_ProbeIns
ELSE
    loc_cOut = loc_cOut + "[7] FALHA - INSERT nao encontrado (result=" + ;
        TRANSFORM(loc_nResult) + ", linhas=" + ;
        TRANSFORM(IIF(USED("cursor_4c_ProbeIns"), RECCOUNT("cursor_4c_ProbeIns"), -1)) + ")" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [8] Alterar (real): posiciona a grade na linha do marcador, abre o painel
*-- via Alterar, muda a Observacao e confirma (BtnSalvarClick -> EditarRegistro
*-- + Atualizar)
LOCAL loc_lAchouNaGrade
loc_lAchouNaGrade = .F.
IF !EMPTY(loc_cCidChaveTeste)
    loc_nSessaoAnt = SET("Datasession")
    TRY
        SET DATASESSION TO (loc_oForm.DataSessionId)
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(hists) == loc_cMarcador
            loc_lAchouNaGrade = FOUND()
        ENDIF
    CATCH TO loc_oErroDS
        loc_cOut = loc_cOut + "[8] ERRO ao localizar: " + loc_oErroDS.Message + CHR(13) + CHR(10)
    ENDTRY
    SET DATASESSION TO (loc_nSessaoAnt)

    loc_cOut = loc_cOut + "[8] localizou na grade=" + TRANSFORM(loc_lAchouNaGrade) + CHR(13) + CHR(10)

    IF loc_lAchouNaGrade
        loc_oForm.BtnAlterarClick()
        loc_cOut = loc_cOut + "[8] apos Alterar: painel=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
            " tipo=[" + loc_oForm.this_cTipo + "] histNoPainel=[" + ;
            ALLTRIM(loc_oForm.cnt_4c__Inserir.txt_4c_Hist.Value) + "]" + CHR(13) + CHR(10)

        loc_cMarcador2 = "Obs alterada probe fase8 " + SYS(2015)
        loc_oForm.cnt_4c__Inserir.obj_4c_GetObs.Value = loc_cMarcador2
        loc_oForm.BtnSalvarClick()
        loc_cOut = loc_cOut + "[8] apos Confirmar(Alterar): painel=" + ;
            TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)
        STRTOFILE(loc_cOut, loc_cLog)

        *-- Confirma a ALTERACAO via SQL direto
        loc_nResult = SQLEXEC(gnConnHandle, "SELECT obs FROM SigCdClh WHERE cidchaves = " + ;
            EscaparSQL(loc_cCidChaveTeste), "cursor_4c_ProbeAlt")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProbeAlt") = 1
            SELECT cursor_4c_ProbeAlt
            GO TOP
            loc_cOut = loc_cOut + "[8] UPDATE confirmado via SQL - obs=[" + ;
                ALLTRIM(cursor_4c_ProbeAlt.obs) + "] esperado=[" + loc_cMarcador2 + "]" + ;
                " bate=" + TRANSFORM(ALLTRIM(cursor_4c_ProbeAlt.obs) == loc_cMarcador2) + CHR(13) + CHR(10)
            USE IN cursor_4c_ProbeAlt
        ELSE
            loc_cOut = loc_cOut + "[8] FALHA ao reler apos Alterar" + CHR(13) + CHR(10)
        ENDIF
    ENDIF
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [9] Cancelar (real): seleciona de novo e abre/cancela sem gravar
IF !EMPTY(loc_cCidChaveTeste)
    loc_nSessaoAnt = SET("Datasession")
    loc_lAchouNaGrade = .F.
    TRY
        SET DATASESSION TO (loc_oForm.DataSessionId)
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(hists) == loc_cMarcador
            loc_lAchouNaGrade = FOUND()
        ENDIF
    CATCH TO loc_oErroDS
        loc_cOut = loc_cOut + "[9] ERRO ao localizar: " + loc_oErroDS.Message + CHR(13) + CHR(10)
    ENDTRY
    SET DATASESSION TO (loc_nSessaoAnt)

    IF loc_lAchouNaGrade
        loc_oForm.BtnAlterarClick()
        loc_oForm.cnt_4c__Inserir.obj_4c_GetObs.Value = "ISTO NAO DEVE SER GRAVADO"
        loc_oForm.BtnCancelarClick()
        loc_cOut = loc_cOut + "[9] apos Cancelar: painel=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
            " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)

        loc_nResult = SQLEXEC(gnConnHandle, "SELECT obs FROM SigCdClh WHERE cidchaves = " + ;
            EscaparSQL(loc_cCidChaveTeste), "cursor_4c_ProbeCanc")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProbeCanc") = 1
            SELECT cursor_4c_ProbeCanc
            GO TOP
            loc_cOut = loc_cOut + "[9] Cancelar NAO gravou - obs=[" + ;
                ALLTRIM(cursor_4c_ProbeCanc.obs) + "] (esperado continuar =[" + loc_cMarcador2 + "])" + CHR(13) + CHR(10)
            USE IN cursor_4c_ProbeCanc
        ENDIF
    ENDIF
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [10] Encerrar (real, IDEMPOTENTE): grava de volta os MESMOS valores que
*-- AtualizarCamposCliente ja carregou em CntContato - prova SalvarContato sem
*-- alterar dado de verdade. Libera o form (Release) ao final - ULTIMO uso.
LOCAL loc_cTel1Antes, loc_cTel2Antes, loc_cDDDAntes, loc_cEmailAntes
loc_cTel1Antes  = ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Tel1.Value)
loc_cTel2Antes  = ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Tel2.Value)
loc_cDDDAntes   = ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_DDDs.Value)
loc_cEmailAntes = ALLTRIM(loc_oForm.cnt_4c_Contato.txt_4c_Email.Value)

loc_oForm.BtnEncerrarClick()
loc_cOut = loc_cOut + "[10] Encerrar chamado (form liberado)" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

loc_nResult = SQLEXEC(gnConnHandle, "SELECT tel1s, tel2s, ddds, emails FROM SigCdCli WHERE iclis = " + ;
    EscaparSQL(PADR(loc_cContaTeste, 10)), "cursor_4c_ProbeContato")
IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProbeContato") = 1
    SELECT cursor_4c_ProbeContato
    GO TOP
    loc_cOut = loc_cOut + "[10] Contato apos Encerrar: tel1=[" + ALLTRIM(cursor_4c_ProbeContato.tel1s) + ;
        "] (antes=[" + loc_cTel1Antes + "]) tel2=[" + ALLTRIM(cursor_4c_ProbeContato.tel2s) + ;
        "] (antes=[" + loc_cTel2Antes + "]) ddd=[" + ALLTRIM(cursor_4c_ProbeContato.ddds) + ;
        "] (antes=[" + loc_cDDDAntes + "]) email=[" + ALLTRIM(cursor_4c_ProbeContato.emails) + ;
        "] (antes=[" + loc_cEmailAntes + "])" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "[10] idempotente=" + TRANSFORM( ;
        ALLTRIM(cursor_4c_ProbeContato.tel1s) == loc_cTel1Antes AND ;
        ALLTRIM(cursor_4c_ProbeContato.tel2s) == loc_cTel2Antes AND ;
        ALLTRIM(cursor_4c_ProbeContato.ddds) == loc_cDDDAntes AND ;
        ALLTRIM(cursor_4c_ProbeContato.emails) == loc_cEmailAntes) + CHR(13) + CHR(10)
    USE IN cursor_4c_ProbeContato
ELSE
    loc_cOut = loc_cOut + "[10] FALHA ao reler contato apos Encerrar" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [11] Limpeza: remove o historico de teste criado em [6]/[8]
IF !EMPTY(loc_cCidChaveTeste)
    loc_nResult = SQLEXEC(gnConnHandle, "DELETE FROM SigCdClh WHERE cidchaves = " + ;
        EscaparSQL(loc_cCidChaveTeste))
    loc_cOut = loc_cOut + "[11] Limpeza DELETE result=" + TRANSFORM(loc_nResult) + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

loc_cOut = loc_cOut + "[12] FIM DO PROBE" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
