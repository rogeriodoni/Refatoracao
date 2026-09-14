SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

PUBLIC gp_cLog
gp_cLog = "C:\4c\tasks\task501\logs\06_testForm.log"

* Inicializa log
STRTOFILE("=== TESTE DIRETO Formprc ===" + CHR(13), gp_cLog)
DO EscLog WITH "[ETAPA 1] Carregando dependencias..."

CD C:\4c\projeto\app\start
DO config.prg

SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\FormBuscaAuxiliar.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\FormErro.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\prcBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\cadastros\Formprc.prg ADDITIVE

DO EscLog WITH "OK - Dependencias carregadas"

*-- [ETAPA 1B] Conectar
DO EscLog WITH "[ETAPA 1B] Conectando ao banco..."
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle < 0
    DO EscLog WITH "ERRO - Falha na conexao SQL"
    QUIT
ENDIF
SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
DO EscLog WITH "OK - Conectado (Handle: " + TRANSFORM(gnConnHandle) + ")"

*-- [ETAPA 2] Criar objeto
DO EscLog WITH "[ETAPA 2] Criando objeto Formprc..."
LOCAL loc_oForm
TRY
    loc_oForm = CREATEOBJECT("Formprc")
    IF ISNULL(loc_oForm) OR TYPE("loc_oForm") # "O"
        DO EscLog WITH "ERRO - CREATEOBJECT retornou NULL"
    ELSE
        DO EscLog WITH "OK - Objeto criado: " + loc_oForm.Class
    ENDIF
CATCH TO loEx
    DO EscLog WITH "ERRO CREATEOBJECT: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo) + " em " + loEx.Procedure
ENDTRY

*-- [ETAPA 3] Mostrar
IF TYPE("loc_oForm") = "O" AND !ISNULL(loc_oForm)
    DO EscLog WITH "[ETAPA 3] Mostrando formulario..."
    TRY
        loc_oForm.WindowType = 0
        loc_oForm.Show()
        DOEVENTS
        IF loc_oForm.Visible
            DO EscLog WITH "OK - Visivel Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height)
        ELSE
            DO EscLog WITH "ERRO - Formulario nao ficou visivel"
        ENDIF
    CATCH TO loEx
        DO EscLog WITH "ERRO Show: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo)
    ENDTRY

    *-- [ETAPA 4] Botoes
    DO EscLog WITH "[ETAPA 4] Testando botoes..."
    LOCAL ARRAY loc_aBtns[3, 2]
    loc_aBtns[1, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Incluir"
    loc_aBtns[1, 2] = "Incluir"
    loc_aBtns[2, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Alterar"
    loc_aBtns[2, 2] = "Alterar"
    loc_aBtns[3, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Excluir"
    loc_aBtns[3, 2] = "Excluir"

    LOCAL loc_i, loc_oBotao
    FOR loc_i = 1 TO 3
        TRY
            loc_oBotao = EVALUATE("loc_oForm." + loc_aBtns[loc_i, 1])
            IF TYPE("loc_oBotao") = "O" AND !ISNULL(loc_oBotao)
                loc_oBotao.Click()
                DOEVENTS
                DO EscLog WITH "OK btn - " + loc_aBtns[loc_i, 2]
                IF WEXIST(WONTOP()) AND WONTOP() # loc_oForm.Name
                    KEYBOARD "{ESC}"
                    DOEVENTS
                ENDIF
            ELSE
                DO EscLog WITH "NOT FOUND btn - " + loc_aBtns[loc_i, 2]
            ENDIF
        CATCH TO loEx
            DO EscLog WITH "ERR btn " + loc_aBtns[loc_i, 2] + ": " + loEx.Message
        ENDTRY
    ENDFOR

    *-- [ETAPA 5] Fechar
    DO EscLog WITH "[ETAPA 5] Fechando formulario..."
    TRY
        loc_oForm.Release()
        DO EscLog WITH "OK - Formulario fechado"
    CATCH TO loEx
        DO EscLog WITH "ERRO Fechar: " + loEx.Message
    ENDTRY
ENDIF

*-- [ETAPA 6] Desconectar
DO EscLog WITH "[ETAPA 6] Desconectando..."
IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
    gnConnHandle = 0
    DO EscLog WITH "OK - Desconectado"
ENDIF

DO EscLog WITH "=== FIM DO TESTE === Fim: " + TTOC(DATETIME())
QUIT

*----------------------------------------------------------------------
PROCEDURE EscLog(par_cMsg)
*----------------------------------------------------------------------
    LOCAL lh
    IF FILE(gp_cLog)
        lh = FOPEN(gp_cLog, 1)
    ELSE
        lh = FCREATE(gp_cLog)
    ENDIF
    IF lh > 0
        =FSEEK(lh, 0, 2)
        =FPUTS(lh, par_cMsg)
        =FCLOSE(lh)
    ENDIF
ENDPROC
