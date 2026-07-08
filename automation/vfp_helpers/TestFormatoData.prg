*==============================================================================
* TestFormatoData.prg - Versao simplificada
* Apenas valida que FormBase.Init() aplica SET DATE TO BRITISH em datasession privada.
* NAO chama Show() (evita SQL queries em InicializarForm) - usa modo UI.
*==============================================================================
LPARAMETERS par_cFormClass, par_cLogFile

SET SAFETY OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_cLog, loc_oForm, loc_lSucesso
loc_cLog = ""
loc_lSucesso = .T.

*-- Captura SET DATE/CENTURY ANTES de carregar config (datasession global = default VFP)
LOCAL loc_cDateAntes
loc_cDateAntes = SET("DATE")
loc_cLog = loc_cLog + "SET DATE global ANTES config.prg: " + loc_cDateAntes + CHR(13) + CHR(10)

*-- Carregar ambiente como main.prg faria
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
CATCH TO loEx
    loc_cLog = loc_cLog + "ERRO ao carregar config: " + loEx.Message + CHR(13) + CHR(10)
    STRTOFILE(loc_cLog, par_cLogFile)
    QUIT
ENDTRY

loc_cLog = loc_cLog + "SET DATE global APOS config.prg: " + SET("DATE") + " (esperado: DMY ou BRITISH)" + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "SET CENTURY global APOS config.prg: " + SET("CENTURY") + " (esperado: ON)" + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "" + CHR(13) + CHR(10)

*-- Ativa modo UI para pular SQL queries em InicializarForm
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

loc_cLog = loc_cLog + "=== TESTE: " + par_cFormClass + " (DataSession=2) ===" + CHR(13) + CHR(10)

*-- Cria o form (DataSession=2 cria datasession privada, FormBase.Init() roda)
TRY
    loc_oForm = CREATEOBJECT(par_cFormClass)
    IF VARTYPE(loc_oForm) != "O"
        loc_cLog = loc_cLog + "FALHA: CREATEOBJECT retornou " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
        STRTOFILE(loc_cLog, par_cLogFile)
        QUIT
    ENDIF
    loc_cLog = loc_cLog + "OK - Objeto form criado" + CHR(13) + CHR(10)
CATCH TO loEx
    loc_cLog = loc_cLog + "ERRO ao criar form: " + loEx.Message + CHR(13) + CHR(10)
    STRTOFILE(loc_cLog, par_cLogFile)
    QUIT
ENDTRY

*-- Entrar na datasession privada do form para capturar os SETs
LOCAL loc_nSessOriginal, loc_nSessForm
loc_nSessOriginal = SET("DATASESSION")
loc_nSessForm = loc_oForm.DataSessionId
SET DATASESSION TO loc_nSessForm

LOCAL loc_cSetDate, loc_cSetCentury, loc_cSetMark
loc_cSetDate = SET("DATE")
loc_cSetCentury = SET("CENTURY")
loc_cSetMark = SET("MARK")

loc_cLog = loc_cLog + "" + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "DataSessionId do form: " + TRANSFORM(loc_nSessForm) + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "SET DATE na datasession privada: " + loc_cSetDate + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "SET CENTURY na datasession privada: " + loc_cSetCentury + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "SET MARK na datasession privada: " + loc_cSetMark + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "" + CHR(13) + CHR(10)

*-- Validar
IF UPPER(ALLTRIM(loc_cSetDate)) == "BRITISH" OR UPPER(ALLTRIM(loc_cSetDate)) == "DMY"
    loc_cLog = loc_cLog + "[OK] SET DATE correto: " + loc_cSetDate + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "[FALHA] SET DATE eh " + loc_cSetDate + " - esperado BRITISH/DMY" + CHR(13) + CHR(10)
    loc_lSucesso = .F.
ENDIF

IF UPPER(ALLTRIM(loc_cSetCentury)) == "ON"
    loc_cLog = loc_cLog + "[OK] SET CENTURY ON" + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "[FALHA] SET CENTURY eh " + loc_cSetCentury + " - esperado ON" + CHR(13) + CHR(10)
    loc_lSucesso = .F.
ENDIF

*-- Formato visual: DTOC(DATE()) deve ser DD/MM/YYYY (10 chars)
LOCAL loc_cValorFormatado
loc_cValorFormatado = DTOC(DATE())
loc_cLog = loc_cLog + "" + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "DTOC(DATE()) na datasession do form: '" + loc_cValorFormatado + "'" + CHR(13) + CHR(10)

IF LEN(loc_cValorFormatado) = 10 AND SUBSTR(loc_cValorFormatado, 3, 1) == "/" AND SUBSTR(loc_cValorFormatado, 6, 1) == "/"
    loc_cLog = loc_cLog + "[OK] Formato DD/MM/YYYY (10 chars com '/')" + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "[FALHA] Formato inesperado (esperado: DD/MM/YYYY)" + CHR(13) + CHR(10)
    loc_lSucesso = .F.
ENDIF

*-- Voltar e fechar
SET DATASESSION TO loc_nSessOriginal
TRY
    loc_oForm.Release()
CATCH
ENDTRY

loc_cLog = loc_cLog + "" + CHR(13) + CHR(10)
IF loc_lSucesso
    loc_cLog = loc_cLog + "=== RESULTADO: SUCESSO ===" + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "=== RESULTADO: FALHA ===" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cLog, par_cLogFile)
QUIT
