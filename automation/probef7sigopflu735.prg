*==============================================================================
* probef7sigopflu735.prg - Exercita em RUNTIME os eventos entregues na Fase 7
* do FormSIGOPFLU (task735): os 4 Click da barra do relatorio
* (Visualizar/Imprimir/Arquivos Email/Encerrar), o BINDEVENT de cada
* Buttons(N) e o funil de validacao ValidarPreAcao().
*
* Setup conforme a receita medida nesta maquina: NAO chamar
* ConfigurarAmbiente() (nao retorna aqui) - DO config.prg + SET PATH +
* SET PROCEDURE a mao do que o form usa, mais PUBLIC gnConnHandle.
* gb_4c_ModoTeste + gc_4c_ArquivoErroTeste SEMPRE em par, senao MsgAviso cai
* num MESSAGEBOX real e o processo trava sem produzir resultado.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m735\probe_f7_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m735\probe_f7_sigopflu.txt"
loc_cOut = "=== PROBE Fase 7 - FormSIGOPFLU (task735) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")  ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "relatoriobase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPFLUBO.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "relatorios\FormSIGOPFLU.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro

TRY
    loc_oForm = CREATEOBJECT("FormSIGOPFLU")
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) <> "O"
    loc_cOut = loc_cOut + "[2] Form NAO instanciado - VARTYPE = " + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF

loc_cOut = loc_cOut + "[2] Form instanciado OK" + CHR(13) + CHR(10)

*-- [3] Os handlers precisam ser PUBLIC: BINDEVENT ignora PROTECTED em
*-- silencio e o harness os chama de FORA da classe (regras #3 e #51).
*-- PEMSTATUS(..., 2) = Protected -> tem de ser .F.
LOCAL loc_nI
LOCAL ARRAY loc_aMet[4]
loc_aMet[1] = "BtnVisualizarClick"
loc_aMet[2] = "BtnImprimirClick"
loc_aMet[3] = "BtnExcelClick"
loc_aMet[4] = "BtnEncerrarClick"

FOR loc_nI = 1 TO ALEN(loc_aMet)
    loc_cOut = loc_cOut + "[3] " + PADR(loc_aMet[loc_nI], 20) + ;
        " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2)) + ;
        CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] BINDEVENT de cada Buttons(N).Click -> handler correspondente
LOCAL loc_nQtd, loc_nJ, loc_nB
LOCAL ARRAY loc_aEv[1, 5]
FOR loc_nB = 1 TO 4
    loc_nQtd = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(loc_nB))
    loc_cOut = loc_cOut + "[4] Buttons(" + TRANSFORM(loc_nB) + ") bindings=" + ;
        TRANSFORM(loc_nQtd)
    IF loc_nQtd > 0
        FOR loc_nJ = 1 TO ALEN(loc_aEv, 2)
            loc_cOut = loc_cOut + " | c" + TRANSFORM(loc_nJ) + "=" + ;
                TRANSFORM(loc_aEv[1, loc_nJ])
        ENDFOR
    ENDIF
    loc_cOut = loc_cOut + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] ValidarPreAcao: os quatro casos do btnReport.Click legado.
*--     Cada caso tem de ser RECUSADO (mensagem no arquivo de dialogs) e
*--     NAO pode chegar ao BO. O cenario eh montado nos controles da Page1.
LOCAL loc_oPg, loc_cDlg, loc_nLen
loc_oPg = loc_oForm.pgf_4c_Paginas.Page1

*-- 5a) Data Inicial vazia
loc_oPg.txt_4c_DtInicial.Value = {}
loc_oPg.txt_4c_DtFinal.Value   = DATE()
loc_oPg.txt_4c_Grupo.Value     = "11101"
loc_oForm.BtnVisualizarClick()
loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
loc_cOut = loc_cOut + "[5a] DtInicial vazia -> 'Data Inicial' na msg = " + ;
    TRANSFORM("Data Inicial" $ loc_cDlg) + CHR(13) + CHR(10)
loc_nLen = LEN(loc_cDlg)

*-- 5b) Data Final vazia
loc_oPg.txt_4c_DtInicial.Value = DATE()
loc_oPg.txt_4c_DtFinal.Value   = {}
loc_oForm.BtnImprimirClick()
loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
loc_cOut = loc_cOut + "[5b] DtFinal vazia -> 'Data Final Inv' na msg nova = " + ;
    TRANSFORM("Data Final Inv" $ SUBSTR(loc_cDlg, loc_nLen + 1)) + CHR(13) + CHR(10)
loc_nLen = LEN(loc_cDlg)

*-- 5c) Data Final anterior a Inicial
loc_oPg.txt_4c_DtInicial.Value = DATE()
loc_oPg.txt_4c_DtFinal.Value   = DATE() - 10
loc_oForm.BtnExcelClick()
loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
loc_cOut = loc_cOut + "[5c] DtFinal < DtInicial -> 'maior que a Inicial' na msg nova = " + ;
    TRANSFORM("maior que a Inicial" $ SUBSTR(loc_cDlg, loc_nLen + 1)) + CHR(13) + CHR(10)
loc_nLen = LEN(loc_cDlg)

*-- 5d) Grupo vazio
loc_oPg.txt_4c_DtInicial.Value = DATE()
loc_oPg.txt_4c_DtFinal.Value   = DATE()
loc_oPg.txt_4c_Grupo.Value     = ""
loc_oForm.BtnVisualizarClick()
loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
loc_cOut = loc_cOut + "[5d] Grupo vazio -> 'Grupo Inv' na msg nova = " + ;
    TRANSFORM("Grupo Inv" $ SUBSTR(loc_cDlg, loc_nLen + 1)) + CHR(13) + CHR(10)
loc_nLen = LEN(loc_cDlg)
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] Filtros VALIDOS: a validacao do form tem de LIBERAR a acao, e dai o
*--     fluxo chega ao BO. Com gnConnHandle = 0 o SQLEXEC do BO falha - o que
*--     interessa aqui eh que a mensagem nova NAO seja mais de validacao de
*--     filtro, prova de que ValidarPreAcao nao bloqueia cenario legitimo.
loc_oPg.txt_4c_DtInicial.Value = DATE() - 30
loc_oPg.txt_4c_DtFinal.Value   = DATE()
loc_oPg.txt_4c_Grupo.Value     = "11101"
loc_oPg.txt_4c_DGrupo.Value    = "GRUPO TESTE"
loc_oPg.chk_4c_ChkData.Value   = 1
loc_oForm.BtnVisualizarClick()
loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
loc_cOut = loc_cOut + "[6] Filtros validos -> passou da validacao de filtro = " + ;
    TRANSFORM(!("Grupo Inv" $ SUBSTR(loc_cDlg, loc_nLen + 1))) + CHR(13) + CHR(10) + ;
    "[6] msg nova: [" + ALLTRIM(STRTRAN(STRTRAN(SUBSTR(loc_cDlg, loc_nLen + 1), ;
    CHR(13), " "), CHR(10), " ")) + "]" + CHR(13) + CHR(10)

*-- [6b] FormParaRelatorio transferiu os filtros para o BO?
loc_cOut = loc_cOut + "[6b] BO this_cGrupo=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cGrupo) + ;
    "] this_cDGrupo=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cDGrupo) + ;
    "] this_lImpData=" + TRANSFORM(loc_oForm.this_oRelatorio.this_lImpData) + ;
    " tipoDtIni=" + VARTYPE(loc_oForm.this_oRelatorio.this_dDtInicial) + ;
    " dtIni=" + DTOC(loc_oForm.this_oRelatorio.this_dDtInicial) + ;
    " dtFin=" + DTOC(loc_oForm.this_oRelatorio.this_dDtFinal) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] Encerrar NAO valida nada e fecha a tela, mesmo com filtro em branco
*--     (eh a unica saida do form: TitleBar=0 / ControlBox=.F. / Closable=.F.)
loc_oPg.txt_4c_DtInicial.Value = {}
loc_oPg.txt_4c_Grupo.Value     = ""
loc_nLen = LEN(IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), ""))

TRY
    loc_oForm.BtnEncerrarClick()
    loc_cDlg = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
    loc_cOut = loc_cOut + "[7] Encerrar com filtros vazios -> form liberado=" + ;
        TRANSFORM(VARTYPE(loc_oForm) <> "O") + ;
        " | sem mensagem nova=" + TRANSFORM(LEN(loc_cDlg) = loc_nLen) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[7] FALHA no BtnEncerrarClick: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "=== FIM DO PROBE ===" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
