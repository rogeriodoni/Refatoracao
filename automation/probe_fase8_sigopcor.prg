*==============================================================================
* probe_fase8_sigopcor.prg - Fase 8 de FormSIGOPCOR (task707)
*
* 1) Recompila Form + BO com .FXP/.ERR apagados (senao roda codigo velho).
* 2) Instancia o form em MODO TESTE e confere o ESCOPO dos tres hooks novos:
*    FormParaBO/BOParaForm/LimparCampos tem de ficar PROTECTED (FormBase os
*    declara assim e VFP9 nao permite alargar escopo herdado).
* 3) Exercita os tres por uma SUBCLASSE (que pode chamar metodo protegido do
*    pai), sem tocar no banco:
*      A) FormParaBO: tela -> objeto de negocio (faixa + contexto + linha)
*      B) BOParaForm: objeto de negocio -> tela (faixa + REPLACE via LOCATE)
*      C) LimparCampos: limpa os dois campos e a coluna de retificacao SEM
*         destruir o catalogo de ocorrencias (RECCOUNT preservado)
* 4) REGRESSAO da Fase 7: a enumeracao da faixa continua igual depois de
*    ValidarFaixaNotas passar a delegar o espelho a FormParaBO.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cOut, loc_cForm, loc_cBO, loc_cFxpF, loc_cFxpB, loc_cErrF, loc_cErrB
LOCAL loc_oForm, loc_oErro, loc_cLog, loc_nG, loc_cCRLF, loc_oBO

loc_cCRLF = CHR(13) + CHR(10)
loc_cOut  = "C:\4c\automation\probe_fase8_sigopcor_result.txt"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPCORBO.prg"
loc_cFxpF = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.fxp"
loc_cFxpB = "C:\4c\projeto\app\classes\SIGOPCORBO.fxp"
loc_cErrF = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.err"
loc_cErrB = "C:\4c\projeto\app\classes\SIGOPCORBO.err"
loc_cLog  = "=== PROBE FASE 8 - FormSIGOPCOR ===" + loc_cCRLF

IF FILE(loc_cFxpF)
    DELETE FILE (loc_cFxpF)
ENDIF
IF FILE(loc_cFxpB)
    DELETE FILE (loc_cFxpB)
ENDIF
IF FILE(loc_cErrF)
    DELETE FILE (loc_cErrF)
ENDIF
IF FILE(loc_cErrB)
    DELETE FILE (loc_cErrB)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cLog = loc_cLog + "FXP BO   : " + IIF(FILE(loc_cFxpB), "OK", "AUSENTE") + loc_cCRLF
loc_cLog = loc_cLog + "FXP Form : " + IIF(FILE(loc_cFxpF), "OK", "AUSENTE") + loc_cCRLF
loc_cLog = loc_cLog + "ERR BO   : " + IIF(FILE(loc_cErrB), FILETOSTR(loc_cErrB), "nenhum") + loc_cCRLF
loc_cLog = loc_cLog + "ERR Form : " + IIF(FILE(loc_cErrF), FILETOSTR(loc_cErrF), "nenhum") + loc_cCRLF

PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, go_4c_Sistema
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_fase8_sigopcor_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")
SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBO) ADDITIVE
SET PROCEDURE TO (loc_cForm) ADDITIVE

*----------------------------------------------- 2) escopo dos hooks novos
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPCOR", .NULL., "001", "1", DATE(), DATE())
CATCH TO loc_oErro
    loc_cLog = loc_cLog + "EXCECAO INSTANCIA: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + loc_cCRLF
ENDTRY

loc_cLog = loc_cLog + "VARTYPE form : " + VARTYPE(loc_oForm) + loc_cCRLF

IF VARTYPE(loc_oForm) = "O"
    loc_cLog = loc_cLog + "INSTANCIOU OK  Caption=[" + loc_oForm.Caption + "]" + loc_cCRLF
    loc_cLog = loc_cLog + "--- escopo (atributo 2 = PROTECTED; os tres hooks DEVEM ser protegidos) ---" + loc_cCRLF
    loc_cLog = loc_cLog + "FormParaBO    existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + loc_cCRLF
    loc_cLog = loc_cLog + "BOParaForm    existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + loc_cCRLF
    loc_cLog = loc_cLog + "LimparCampos  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + loc_cCRLF
    loc_cLog = loc_cLog + "CarregarLista existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "  (harness chama de fora: tem de ser .F.)" + loc_cCRLF

    loc_oForm.Release()
ENDIF

*----------------------------------------------- 3) exercicio pela subclasse
loc_cLog = loc_cLog + "--- exercicio dos hooks (subclasse, sem banco) ---" + loc_cCRLF
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeF8", .NULL., "001", "22", DATE() - 10, DATE())
CATCH TO loc_oErro
    loc_cLog = loc_cLog + "EXCECAO SUBCLASSE: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + loc_cCRLF
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_oBO = loc_oForm.this_oBusinessObject

    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM",   "texto um")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (2, "OCORRENCIA DOIS", "")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (3, "OCORRENCIA TRES", "texto tres")
    GO TOP IN cursor_4c_Ocorrencias

    *-- A) FormParaBO: tela -> objeto de negocio
    loc_oForm.txt_4c_NotaIni.Value = "000100"
    loc_oForm.txt_4c_NotaFim.Value = "000105"
    loc_cLog = loc_cLog + "A) FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + loc_cCRLF
    loc_cLog = loc_cLog + "   cNfisDe=[" + loc_oBO.this_cNfisDe + "] cNfisAte=[" + loc_oBO.this_cNfisAte + ;
        "]  (esperado 000100 / 000105)" + loc_cCRLF
    loc_cLog = loc_cLog + "   cEmps=[" + loc_oBO.this_cEmps + "] cSeries=[" + loc_oBO.this_cSeries + ;
        "]  (esperado 001 / 22)" + loc_cCRLF
    loc_cLog = loc_cLog + "   dEmisDe=" + DTOC(loc_oBO.this_dEmisDe) + " dEmisAte=" + DTOC(loc_oBO.this_dEmisAte) + ;
        "  (esperado " + DTOC(DATE() - 10) + " / " + DTOC(DATE()) + ")" + loc_cCRLF
    loc_cLog = loc_cLog + "   linha corrente: nNoccors=" + TRANSFORM(loc_oBO.this_nNoccors) + ;
        " cMretifs=[" + loc_oBO.this_cMretifs + "]  (esperado 1 / texto um)" + loc_cCRLF
    loc_cLog = loc_cLog + "   this_cNfis=[" + loc_oBO.this_cNfis + ;
        "]  (esperado VAZIO - a nota concreta e resolvida na gravacao)" + loc_cCRLF

    *-- A2) FormParaBO com o cursor no EOF: tem de ZERAR a linha, nao manter a anterior
    SELECT cursor_4c_Ocorrencias
    GO BOTTOM
    SKIP
    loc_oForm.ProbeFormParaBO()
    loc_cLog = loc_cLog + "A2) cursor em EOF -> nNoccors=" + TRANSFORM(loc_oBO.this_nNoccors) + ;
        " cMretifs=[" + loc_oBO.this_cMretifs + "]  (esperado 0 / vazio)" + loc_cCRLF

    *-- B) BOParaForm: objeto de negocio -> tela (REPLACE pela ocorrencia 3)
    loc_oBO.this_cNfisDe  = "000200"
    loc_oBO.this_cNfisAte = "000202"
    loc_oBO.this_nNoccors = 3
    loc_oBO.this_cMretifs = "TEXTO VINDO DO BO"
    loc_cLog = loc_cLog + "B) BOParaForm retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + loc_cCRLF
    loc_cLog = loc_cLog + "   NotaIni=[" + loc_oForm.txt_4c_NotaIni.Value + "] NotaFim=[" + ;
        loc_oForm.txt_4c_NotaFim.Value + "]  (esperado 000200 / 000202)" + loc_cCRLF
    SELECT cursor_4c_Ocorrencias
    LOCATE FOR cursor_4c_Ocorrencias.cods = 3
    loc_cLog = loc_cLog + "   linha cods=3 retifs=[" + TratarNulo(cursor_4c_Ocorrencias.retifs, "") + ;
        "]  (esperado TEXTO VINDO DO BO)" + loc_cCRLF
    LOCATE FOR cursor_4c_Ocorrencias.cods = 1
    loc_cLog = loc_cLog + "   linha cods=1 retifs=[" + TratarNulo(cursor_4c_Ocorrencias.retifs, "") + ;
        "]  (esperado texto um - intacta)" + loc_cCRLF

    *-- B2) ocorrencia inexistente: nenhuma linha pode ser tocada
    loc_oBO.this_nNoccors = 99
    loc_oBO.this_cMretifs = "NAO DEVE APARECER"
    loc_oForm.ProbeBOParaForm()
    SELECT cursor_4c_Ocorrencias
    LOCATE FOR "NAO DEVE APARECER" $ TratarNulo(cursor_4c_Ocorrencias.retifs, "")
    loc_cLog = loc_cLog + "B2) ocorrencia 99 (inexistente) escreveu em alguma linha=" + ;
        TRANSFORM(FOUND("cursor_4c_Ocorrencias")) + "  (esperado .F.)" + loc_cCRLF

    *-- C) LimparCampos: limpa campos e retificacao, PRESERVA o catalogo
    loc_cLog = loc_cLog + "C) antes de limpar: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + ;
        " retificacoes preenchidas=" + TRANSFORM(loc_oForm.ProbeContar()) + loc_cCRLF
    loc_oForm.ProbeLimpar()
    loc_cLog = loc_cLog + "   depois de limpar: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + ;
        "  (esperado 3 - catalogo intacto)" + loc_cCRLF
    loc_cLog = loc_cLog + "   retificacoes preenchidas=" + TRANSFORM(loc_oForm.ProbeContar()) + ;
        "  (esperado 0)" + loc_cCRLF
    loc_cLog = loc_cLog + "   NotaIni=[" + loc_oForm.txt_4c_NotaIni.Value + "] NotaFim=[" + ;
        loc_oForm.txt_4c_NotaFim.Value + "]  (esperado vazios)" + loc_cCRLF
    loc_cLog = loc_cLog + "   BO reespelhado: cNfisDe=[" + loc_oBO.this_cNfisDe + "] cNfisAte=[" + ;
        loc_oBO.this_cNfisAte + "]  (esperado vazios)" + loc_cCRLF
    loc_cLog = loc_cLog + "   contexto PRESERVADO: cEmps=[" + loc_oBO.this_cEmps + "] cSeries=[" + ;
        loc_oBO.this_cSeries + "]  (esperado 001 / 22)" + loc_cCRLF
    SELECT cursor_4c_Ocorrencias
    GO TOP
    loc_cLog = loc_cLog + "   linha 1 descs=[" + ALLTRIM(cursor_4c_Ocorrencias.descs) + ;
        "] cods=" + TRANSFORM(cursor_4c_Ocorrencias.cods) + "  (catalogo nao apagado)" + loc_cCRLF

    *------------------------------------- 4) REGRESSAO da enumeracao da faixa
    loc_cLog = loc_cLog + "--- REGRESSAO Fase 7 (espelho agora via FormParaBO) ---" + loc_cCRLF
    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM",   "texto um")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (2, "OCORRENCIA DOIS", "")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (3, "OCORRENCIA TRES", "texto tres")

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "000123"
    loc_oForm.txt_4c_NotaFim.Value = "000123"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "A) 000123..000123 n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "100"
    loc_oForm.txt_4c_NotaFim.Value = "102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "B) 100..102       n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "000100"
    loc_oForm.txt_4c_NotaFim.Value = "000102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "C) 000100..000102 n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "200"
    loc_oForm.txt_4c_NotaFim.Value = "100"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "D) 200..100 (inv) n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "A100"
    loc_oForm.txt_4c_NotaFim.Value = "A102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "E) A100..A102     n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = ""
    loc_oForm.txt_4c_NotaFim.Value = ""
    loc_oForm.BtnConfirmarClick()
    loc_cLog = loc_cLog + "G) faixa vazia    gravou=[" + loc_oForm.probe_cLog + "] vivo=" + ;
        TRANSFORM(VARTYPE(loc_oForm) = "O") + loc_cCRLF

    loc_oForm.probe_cLog = ""
    loc_nG = loc_oForm.ProbeGravarSemValidar()
    loc_cLog = loc_cLog + "H) sem validar    n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    loc_oForm.BtnEncerrarClick()
    loc_cLog = loc_cLog + "I) BtnEncerrarClick executou sem erro" + loc_cCRLF
ENDIF

loc_cLog = loc_cLog + "--- dialogos capturados ---" + loc_cCRLF
loc_cLog = loc_cLog + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "nenhum")

STRTOFILE(loc_cLog, loc_cOut)
QUIT

*==============================================================================
DEFINE CLASS ProbeF8 AS FormSIGOPCOR
    probe_cLog = ""

    *-- Chamar metodo PROTECTED do pai de DENTRO da subclasse e legitimo: e
    *-- exatamente como o proprio form o usa. O que nao se pode e alargar o
    *-- escopo redeclarando o hook como publico.
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimpar()
        THIS.LimparCampos()
    ENDPROC

    PROCEDURE ProbeContar()
        RETURN THIS.ContarRetificacoesDigitadas()
    ENDPROC

    *-- Sobrescreve o gravador para registrar a nota em vez de ir ao banco
    PROTECTED PROCEDURE GravarOcorrencia(par_cNfis, par_nNoccors, par_cMretifs)
        THIS.probe_cLog = THIS.probe_cLog + "[" + par_cNfis + "/" + ;
            ALLTRIM(TRANSFORM(par_nNoccors)) + "]"
        RETURN .T.
    ENDPROC

    PROCEDURE ProbeGravar()
        LOCAL loc_nRet
        loc_nRet = -1

        IF THIS.ValidarFaixaNotas()
            loc_nRet = THIS.GravarRetificacoesDaFaixa()
        ENDIF

        RETURN loc_nRet
    ENDPROC

    PROCEDURE ProbeGravarSemValidar()
        RETURN THIS.GravarRetificacoesDaFaixa()
    ENDPROC
ENDDEFINE
