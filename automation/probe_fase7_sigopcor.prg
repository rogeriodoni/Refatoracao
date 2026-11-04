*==============================================================================
* probe_fase7_sigopcor.prg - Fase 7 de FormSIGOPCOR (task707)
* 1) Recompila Form + BO com .FXP/.ERR apagados (senao roda codigo velho).
* 2) Instancia o form em MODO TESTE: prova que os dois BINDEVENT novos
*    (Buttons 1 e 2 -> BtnConfirmarClick/BtnCancelarClick) VINCULAM - delegate
*    inexistente ou PROTECTED estoura no proprio BINDEVENT.
* 3) Exercita a regra da gravacao numa SUBCLASSE que sobrescreve
*    GravarOcorrencia (so registra a nota), para provar a enumeracao da faixa
*    sem tocar no banco.
* 4) Exercita o caminho REAL (gnConnHandle = -1): Salvar falha e o laco para.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cOut, loc_cForm, loc_cBO, loc_cFxpF, loc_cFxpB, loc_cErrF, loc_cErrB
LOCAL loc_oForm, loc_oErro, loc_cLog, loc_nG, loc_i, loc_cCRLF

loc_cCRLF = CHR(13) + CHR(10)
loc_cOut  = "C:\4c\automation\probe_fase7_sigopcor_result.txt"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPCORBO.prg"
loc_cFxpF = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.fxp"
loc_cFxpB = "C:\4c\projeto\app\classes\SIGOPCORBO.fxp"
loc_cErrF = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.err"
loc_cErrB = "C:\4c\projeto\app\classes\SIGOPCORBO.err"
loc_cLog  = "=== PROBE FASE 7 - FormSIGOPCOR ===" + loc_cCRLF

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_fase7_sigopcor_dialogs.txt"
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

*------------------------------------------------------------------ 1) instancia
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

    loc_cLog = loc_cLog + "--- escopo dos handlers (atributo 2 = PROTECTED, deve ser .F.) ---" + loc_cCRLF
    loc_cLog = loc_cLog + "BtnConfirmarClick existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 2)) + loc_cCRLF
    loc_cLog = loc_cLog + "BtnCancelarClick  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + loc_cCRLF
    loc_cLog = loc_cLog + "BtnEncerrarClick  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + loc_cCRLF

    loc_cLog = loc_cLog + "--- BINDEVENT registrado nos 2 botoes (AEVENTS) ---" + loc_cCRLF
    LOCAL ARRAY loc_aE[1]
    FOR loc_i = 1 TO 2
        IF AEVENTS(loc_aE, loc_oForm.cmg_4c_Sair.Buttons(loc_i)) > 0
            loc_cLog = loc_cLog + "Buttons(" + TRANSFORM(loc_i) + ") evento=" + ;
                TRANSFORM(loc_aE[1, 2]) + " delegate=" + TRANSFORM(loc_aE[1, 4]) + loc_cCRLF
        ELSE
            loc_cLog = loc_cLog + "Buttons(" + TRANSFORM(loc_i) + ") NENHUM VINCULO" + loc_cCRLF
        ENDIF
    ENDFOR

    *--- 4) caminho REAL sem conexao: Salvar falha, laco para, nada de sucesso
    loc_cLog = loc_cLog + "--- caminho REAL (gnConnHandle = -1) ---" + loc_cCRLF
    IF USED("cursor_4c_Ocorrencias")
        SELECT cursor_4c_Ocorrencias
        ZAP
        INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM", "texto um")
        loc_oForm.txt_4c_NotaIni.Value = "000123"
        loc_oForm.txt_4c_NotaFim.Value = "000123"
        loc_oForm.BtnConfirmarClick()
        loc_cLog = loc_cLog + "BtnConfirmarClick sem banco: form ainda vivo=" + ;
            TRANSFORM(VARTYPE(loc_oForm) = "O") + loc_cCRLF
    ELSE
        loc_cLog = loc_cLog + "cursor_4c_Ocorrencias AUSENTE" + loc_cCRLF
    ENDIF

    loc_oForm.Release()
ENDIF

*------------------------------------------------------- 3) enumeracao da faixa
loc_cLog = loc_cLog + "--- enumeracao da faixa (subclasse, sem banco) ---" + loc_cCRLF
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeF7", .NULL., "001", "1", DATE(), DATE())
CATCH TO loc_oErro
    loc_cLog = loc_cLog + "EXCECAO SUBCLASSE: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + loc_cCRLF
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM",   "texto um")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (2, "OCORRENCIA DOIS", "")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (3, "OCORRENCIA TRES", "texto tres")

    loc_cLog = loc_cLog + "ContarRetificacoesDigitadas = " + ;
        TRANSFORM(loc_oForm.ProbeContar()) + "  (esperado 2)" + loc_cCRLF

    *-- A) faixa de UMA nota -> valor LITERAL digitado (preserva zeros)
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "000123"
    loc_oForm.txt_4c_NotaFim.Value = "000123"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "A) 000123..000123 n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    *-- B) faixa numerica simples
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "100"
    loc_oForm.txt_4c_NotaFim.Value = "102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "B) 100..102       n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    *-- C) faixa com zeros a esquerda -> largura preservada
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "000100"
    loc_oForm.txt_4c_NotaFim.Value = "000102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "C) 000100..000102 n=" + TRANSFORM(loc_nG) + "  " + loc_oForm.probe_cLog + loc_cCRLF

    *-- D) faixa INVERTIDA -> recusa, zero gravacao
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "200"
    loc_oForm.txt_4c_NotaFim.Value = "100"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "D) 200..100 (inv) n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    *-- E) limite nao numerico e diferente -> recusa
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "A100"
    loc_oForm.txt_4c_NotaFim.Value = "A102"
    loc_nG = loc_oForm.ProbeGravar()
    loc_cLog = loc_cLog + "E) A100..A102     n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    *-- F) grade SEM retificacao -> nao grava e nao fecha
    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM", "")
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = "100"
    loc_oForm.txt_4c_NotaFim.Value = "100"
    loc_oForm.BtnConfirmarClick()
    loc_cLog = loc_cLog + "F) sem retificacao gravou=[" + loc_oForm.probe_cLog + "] vivo=" + ;
        TRANSFORM(VARTYPE(loc_oForm) = "O") + loc_cCRLF

    *-- G) faixa VAZIA -> guarda do legado, nada gravado
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = ""
    loc_oForm.txt_4c_NotaFim.Value = ""
    loc_oForm.BtnConfirmarClick()
    loc_cLog = loc_cLog + "G) faixa vazia    gravou=[" + loc_oForm.probe_cLog + "] vivo=" + ;
        TRANSFORM(VARTYPE(loc_oForm) = "O") + loc_cCRLF

    *-- H) gravacao chamada SEM a validacao -> recusa (nota em branco)
    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (1, "OCORRENCIA UM", "texto um")
    loc_oForm.probe_cLog = ""
    loc_oForm.txt_4c_NotaIni.Value = ""
    loc_oForm.txt_4c_NotaFim.Value = ""
    loc_oForm.this_oBusinessObject.this_cNfisDe  = ""
    loc_oForm.this_oBusinessObject.this_cNfisAte = ""
    loc_nG = loc_oForm.ProbeGravarSemValidar()
    loc_cLog = loc_cLog + "H) sem validar    n=" + TRANSFORM(loc_nG) + "  [" + loc_oForm.probe_cLog + ;
        "]  (esperado 0)" + loc_cCRLF

    *-- I) o alias de saida delega para o Cancelar (fecha a tela)
    loc_oForm.BtnEncerrarClick()
    loc_cLog = loc_cLog + "I) BtnEncerrarClick executou sem erro" + loc_cCRLF
ENDIF

loc_cLog = loc_cLog + "--- dialogos capturados ---" + loc_cCRLF
loc_cLog = loc_cLog + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "nenhum")

STRTOFILE(loc_cLog, loc_cOut)
QUIT

*==============================================================================
DEFINE CLASS ProbeF7 AS FormSIGOPCOR
    probe_cLog = ""

    *-- Sobrescreve o gravador para registrar a nota em vez de ir ao banco:
    *-- prova a enumeracao da faixa sem SQL.
    PROTECTED PROCEDURE GravarOcorrencia(par_cNfis, par_nNoccors, par_cMretifs)
        THIS.probe_cLog = THIS.probe_cLog + "[" + par_cNfis + "/" + ;
            ALLTRIM(TRANSFORM(par_nNoccors)) + "]"
        RETURN .T.
    ENDPROC

    *-- Espelha a ORDEM real do handler: valida (que tambem espelha a faixa no
    *-- objeto de negocio) e so depois grava. -1 = recusado na validacao.
    PROCEDURE ProbeGravar()
        LOCAL loc_nRet
        loc_nRet = -1

        IF THIS.ValidarFaixaNotas()
            loc_nRet = THIS.GravarRetificacoesDaFaixa()
        ENDIF

        RETURN loc_nRet
    ENDPROC

    *-- Prova que a gravacao chamada SEM a validacao nao escreve nota em branco
    PROCEDURE ProbeGravarSemValidar()
        RETURN THIS.GravarRetificacoesDaFaixa()
    ENDPROC

    PROCEDURE ProbeContar()
        RETURN THIS.ContarRetificacoesDigitadas()
    ENDPROC
ENDDEFINE
