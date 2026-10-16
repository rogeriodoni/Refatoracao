SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_CaminhoIcones, gc_4c_UsuarioLogado
gnConnHandle      = -1
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_UsuarioLogado = "TESTE"

LOCAL loc_cBase, loc_cOut, loc_oF, loc_oErro
loc_cBase = "C:\4c\projeto\app\"
loc_cOut  = ""

SET PROCEDURE TO (loc_cBase + "utils\functions.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "utils\messages.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "utils\validators.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\formbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "classes\SIGPRMEIBO.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "forms\operacionais\FormSIGPRMEI.prg") ADDITIVE

TRY
    loc_oF = CREATEOBJECT("FormSIGPRMEI")
    loc_cOut = loc_cOut + "INSTANCIOU=" + VARTYPE(loc_oF) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oF) = "O"
        loc_cOut = loc_cOut + "Encerrar Left=" + TRANSFORM(loc_oF.btn_4c_Encerrar.Left) + ;
            " Top=" + TRANSFORM(loc_oF.btn_4c_Encerrar.Top) + ;
            " W=" + TRANSFORM(loc_oF.btn_4c_Encerrar.Width) + ;
            " H=" + TRANSFORM(loc_oF.btn_4c_Encerrar.Height) + CHR(13) + CHR(10)

        *-- rect esperado: 425..500 x 3..78
        loc_cOut = loc_cOut + "dentro  (430,10)  = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(430, 10, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "centro  (462,40)  = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(462, 40, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "esquerda(400,10)  = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(400, 10, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "abaixo  (430,100) = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(430, 100, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "sobreProcessar(360,10) vs Encerrar = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(360, 10, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "argNaoObjeto      = " + TRANSFORM(loc_oF.MouseSobreBotaoSair(430, 10, .F.)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "argNaoNumerico    = " + TRANSFORM(loc_oF.MouseSobreBotaoSair("x", 10, loc_oF.btn_4c_Encerrar)) + CHR(13) + CHR(10)

        loc_oF.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "ERRO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\probe_mei_mouse.txt")
QUIT
