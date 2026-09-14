SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

PUBLIC gp_cLog2
gp_cLog2 = "C:\4c\tasks\task501\logs\06_testForm.log"

STRTOFILE("=== TESTE Formprc ===" + CHR(13), gp_cLog2)
DO EscLog2 WITH "[ETAPA 1] Carregando dependencias..."

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

DO EscLog2 WITH "OK - Dependencias carregadas"

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle < 0
    DO EscLog2 WITH "ERRO - Falha na conexao SQL"
    QUIT
ENDIF
SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
DO EscLog2 WITH "[ETAPA 1B] OK - Conectado (Handle: " + TRANSFORM(gnConnHandle) + ")"

DO EscLog2 WITH "[ETAPA 2] Criando objeto Formprc..."
LOCAL loc_oForm2
TRY
    loc_oForm2 = CREATEOBJECT("Formprc")
    IF ISNULL(loc_oForm2) OR TYPE("loc_oForm2") # "O"
        DO EscLog2 WITH "ERRO - CREATEOBJECT retornou NULL"
    ELSE
        DO EscLog2 WITH "OK - Objeto criado: " + loc_oForm2.Class
    ENDIF
CATCH TO loEx
    DO EscLog2 WITH "ERRO CREATEOBJECT: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo) + " em " + loEx.Procedure
ENDTRY

IF TYPE("loc_oForm2") = "O" AND !ISNULL(loc_oForm2)
    DO EscLog2 WITH "[ETAPA 3] Mostrando formulario..."
    TRY
        loc_oForm2.WindowType = 0
        loc_oForm2.Show()
        DOEVENTS
        IF loc_oForm2.Visible
            DO EscLog2 WITH "OK - Visivel Width=" + TRANSFORM(loc_oForm2.Width) + " Height=" + TRANSFORM(loc_oForm2.Height)
        ELSE
            DO EscLog2 WITH "ERRO - Nao ficou visivel"
        ENDIF
    CATCH TO loEx
        DO EscLog2 WITH "ERRO Show: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo)
    ENDTRY

    DO EscLog2 WITH "[ETAPA 4] Testando botoes..."
    LOCAL ARRAY loc_aBtns2[3, 2]
    loc_aBtns2[1, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Incluir"
    loc_aBtns2[1, 2] = "Incluir"
    loc_aBtns2[2, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Alterar"
    loc_aBtns2[2, 2] = "Alterar"
    loc_aBtns2[3, 1] = "pgf_4c_Principal.Page1.cnt_4c_Botoes.cmd_4c_Excluir"
    loc_aBtns2[3, 2] = "Excluir"

    LOCAL loc_i2, loc_oBotao2
    FOR loc_i2 = 1 TO 3
        TRY
            loc_oBotao2 = EVALUATE("loc_oForm2." + loc_aBtns2[loc_i2, 1])
            IF TYPE("loc_oBotao2") = "O" AND !ISNULL(loc_oBotao2)
                loc_oBotao2.Click()
                DOEVENTS
                DO EscLog2 WITH "OK btn - " + loc_aBtns2[loc_i2, 2]
                IF WEXIST(WONTOP()) AND WONTOP() # loc_oForm2.Name
                    KEYBOARD "{ESC}"
                    DOEVENTS
                ENDIF
            ELSE
                DO EscLog2 WITH "NOT FOUND btn - " + loc_aBtns2[loc_i2, 2]
            ENDIF
        CATCH TO loEx
            DO EscLog2 WITH "ERR btn " + loc_aBtns2[loc_i2, 2] + ": " + loEx.Message
        ENDTRY
    ENDFOR

    DO EscLog2 WITH "[ETAPA 5] Fechando formulario..."
    TRY
        loc_oForm2.Release()
        DO EscLog2 WITH "OK - Formulario fechado"
    CATCH TO loEx
        DO EscLog2 WITH "ERRO Fechar: " + loEx.Message
    ENDTRY
ENDIF

IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
    gnConnHandle = 0
    DO EscLog2 WITH "OK - Desconectado"
ENDIF

DO EscLog2 WITH "=== FIM DO TESTE === Fim: " + TTOC(DATETIME())
QUIT

PROCEDURE EscLog2(par_cMsg)
    LOCAL lh2
    IF FILE(gp_cLog2)
        lh2 = FOPEN(gp_cLog2, 1)
    ELSE
        lh2 = FCREATE(gp_cLog2)
    ENDIF
    IF lh2 > 0
        =FSEEK(lh2, 0, 2)
        =FPUTS(lh2, par_cMsg)
        =FCLOSE(lh2)
    ENDIF
ENDPROC
