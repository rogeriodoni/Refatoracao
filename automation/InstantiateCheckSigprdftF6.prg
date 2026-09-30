*-- Probe da FASE 6 (task599 / sigprdft): prova que os metodos Validar*
*-- existem, sao PUBLIC (chamaveis de FORA da classe - PEMSTATUS sozinho
*-- nao prova escopo, ver CLAUDE.md regra #3) e reproduzem os guards do
*-- Valid legado.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprdft_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_lR
loc_cRes = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- ConfigurarAmbiente() NAO eh chamado (conecta em 192.168.200.10,
    *-- inalcancavel nesta maquina). Carregar so as dependencias.
    PUBLIC gnConnHandle
    gnConnHandle = -1

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
    SET PROCEDURE TO (gcCaminhoClasses + "sigprdftBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprdft.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("Formsigprdft")

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "FORM OK  W=" + TRANSFORM(loc_oForm.Width) + ;
                   " H=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)
        loc_cRes = loc_cRes + "LASTKEY() no probe = " + TRANSFORM(LASTKEY()) + CHR(13) + CHR(10)

        *-- property nova (ThisForm.abandona do legado)
        loc_cRes = loc_cRes + "this_lAbandona existe = " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "this_lAbandona", 5)) + ;
            "  valor=" + TRANSFORM(loc_oForm.this_lAbandona) + CHR(13) + CHR(10)

        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- ValidarDigitos (esperado F / F+limpa / T) ---" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Digitos.Value = ""
        loc_lR = loc_oForm.ValidarDigitos()
        loc_cRes = loc_cRes + "  vazio      -> " + TRANSFORM(loc_lR) + "  (esperado .F.)" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Digitos.Value = "12"
        loc_lR = loc_oForm.ValidarDigitos()
        loc_cRes = loc_cRes + "  '12'       -> " + TRANSFORM(loc_lR) + "  (esperado .F.)  campo apos=[" + ;
            loc_oForm.txt_4c_Digitos.Value + "] (esperado vazio)" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Digitos.Value = "1234"
        loc_lR = loc_oForm.ValidarDigitos()
        loc_cRes = loc_cRes + "  '1234'     -> " + TRANSFORM(loc_lR) + "  (esperado .T.)" + CHR(13) + CHR(10)

        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- ValidarParcelas (esperado F / T) ---" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Text1.Value = ""
        loc_lR = loc_oForm.ValidarParcelas()
        loc_cRes = loc_cRes + "  vazio      -> " + TRANSFORM(loc_lR) + "  (esperado .F.)" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Text1.Value = "03"
        loc_lR = loc_oForm.ValidarParcelas()
        loc_cRes = loc_cRes + "  '03'       -> " + TRANSFORM(loc_lR) + "  (esperado .T.)" + CHR(13) + CHR(10)

        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- ValidarDataVencimento ---" + CHR(13) + CHR(10)

        *-- (a) parcelado (OptionGroup=2) com data passada -> reprova
        loc_oForm.obj_4c_Optiongroup1.Value = 2
        loc_oForm.txt_4c_Datas.Value = DATE() - 5
        loc_lR = loc_oForm.ValidarDataVencimento()
        loc_cRes = loc_cRes + "  opt=2 data passada -> " + TRANSFORM(loc_lR) + "  (esperado .F.)" + CHR(13) + CHR(10)

        *-- (b) parcelado com campo vazio -> normaliza para DATE()+30 e aprova
        loc_oForm.txt_4c_Datas.Value = {}
        loc_lR = loc_oForm.ValidarDataVencimento()
        loc_cRes = loc_cRes + "  opt=2 vazio        -> " + TRANSFORM(loc_lR) + "  (esperado .T.)  campo apos=" + ;
            DTOC(loc_oForm.txt_4c_Datas.Value) + "  (esperado " + DTOC(DATE() + 30) + ")" + CHR(13) + CHR(10)

        *-- (c) a vista (OptionGroup=1): data de hoje NAO eh recusada
        loc_oForm.obj_4c_Optiongroup1.Value = 1
        loc_oForm.txt_4c_Datas.Value = DATE()
        loc_lR = loc_oForm.ValidarDataVencimento()
        loc_cRes = loc_cRes + "  opt=1 data hoje    -> " + TRANSFORM(loc_lR) + "  (esperado .T.)" + CHR(13) + CHR(10)

        *-- (d) parcelado com data futura -> aprova
        loc_oForm.obj_4c_Optiongroup1.Value = 2
        loc_oForm.txt_4c_Datas.Value = DATE() + 10
        loc_lR = loc_oForm.ValidarDataVencimento()
        loc_cRes = loc_cRes + "  opt=2 data futura  -> " + TRANSFORM(loc_lR) + "  (esperado .T.)" + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprdft_f6.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + ;
        FILETOSTR("C:\4c\automation\vfp_error_sigprdft_f6.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprdft_f6.txt")
QUIT
