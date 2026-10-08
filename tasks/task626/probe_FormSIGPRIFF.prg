*-- Probe: instanciar FormSIGPRIFF nos 4 modos do dialogo legado.
*-- Cadeia MINIMA (ConfigurarAmbiente() trava o VFP9 headless - ver memoria).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_CaminhoIcones, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\_tmp\probe_sigpriff_erro.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_UsuarioLogado    = "TESTE"

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg")  ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg")     ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\FormErro.prg")     ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SIGPRIFFBO.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg") ADDITIVE

LOCAL loc_cOut
loc_cOut = "PROBE FormSIGPRIFF - " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
           REPLICATE("=", 72) + CHR(13) + CHR(10)

*-- (1) sem parametro nenhum (modo caractere, defaults)
loc_cOut = loc_cOut + ProbeCaso("1 SEM PARAMETRO", .NULL., .NULL., .NULL., .NULL., .NULL., .NULL.)

*-- (2) modo "M" - multipla escolha, 3 opcoes (como sigprtef passa Escolhas)
loc_cOut = loc_cOut + ProbeCaso("2 MODO M (3 opcoes)", "Debito;Credito;Dinheiro;", "M", ;
                                "Forma de Pagamento", 0, 0, "")

*-- (3) modo caractere com tamanho (pcMaximo/pcMinimo trocados pelo chamador)
loc_cOut = loc_cOut + ProbeCaso("3 CARACTERE Max/Min", "", "L", "Digite o CPF", 3, 11, "C")

*-- (4) modo "D" (data) e (5) modo "V" (valor)
loc_cOut = loc_cOut + ProbeCaso("4 MODO D (data)",  "", "L", "Data de Emissao", 0, 0, "D")
loc_cOut = loc_cOut + ProbeCaso("5 MODO V (valor)", "", "L", "Valor do Documento", 0, 0, "V")

STRTOFILE(loc_cOut, "C:\4c\automation\_tmp\probe_sigpriff.txt")
QUIT

*------------------------------------------------------------------------------
PROCEDURE ProbeCaso(par_cRotulo, par_cCab, par_cTipo, par_cTit, par_nMax, par_nMin, par_cDado)
    LOCAL loc_oF, loc_oE, loc_c, loc_nI
    loc_c = CHR(13) + CHR(10) + "[" + par_cRotulo + "]" + CHR(13) + CHR(10)

    TRY
        IF ISNULL(par_cCab)
            loc_oF = CREATEOBJECT("FormSIGPRIFF")
        ELSE
            loc_oF = CREATEOBJECT("FormSIGPRIFF", par_cCab, par_cTipo, par_cTit, par_nMax, par_nMin, par_cDado)
        ENDIF

        IF VARTYPE(loc_oF) != "O"
            loc_c = loc_c + "  FALHOU: CREATEOBJECT devolveu VARTYPE=" + VARTYPE(loc_oF) + CHR(13) + CHR(10)
        ELSE
            loc_c = loc_c + "  BaseClass=[" + loc_oF.BaseClass + "] Caption=[" + loc_oF.Caption + "]" + ;
                    " W=" + TRANSFORM(loc_oF.Width) + " H=" + TRANSFORM(loc_oF.Height) + ;
                    " WindowType=" + TRANSFORM(loc_oF.WindowType) + ;
                    " WindowState=" + TRANSFORM(loc_oF.WindowState) + ;
                    " ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13) + CHR(10)

            loc_c = loc_c + "  txt_4c_Resposta: Visible=" + TRANSFORM(loc_oF.txt_4c_Resposta.Visible) + ;
                    " VARTYPE(.Value)=[" + VARTYPE(loc_oF.txt_4c_Resposta.Value) + "]" + ;
                    " MaxLength=" + TRANSFORM(loc_oF.txt_4c_Resposta.MaxLength) + ;
                    " InputMask=[" + loc_oF.txt_4c_Resposta.InputMask + "]" + ;
                    " Alignment=" + TRANSFORM(loc_oF.txt_4c_Resposta.Alignment) + ;
                    " Top/Left/W/H=" + TRANSFORM(loc_oF.txt_4c_Resposta.Top) + "/" + ;
                    TRANSFORM(loc_oF.txt_4c_Resposta.Left) + "/" + ;
                    TRANSFORM(loc_oF.txt_4c_Resposta.Width) + "/" + ;
                    TRANSFORM(loc_oF.txt_4c_Resposta.Height) + CHR(13) + CHR(10)

            loc_c = loc_c + "  cbo_4c_Opcoes:   Visible=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.Visible) + ;
                    " Style=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.Style) + ;
                    " RowSourceType=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.RowSourceType) + ;
                    " RowSource=[" + loc_oF.cbo_4c_Opcoes.RowSource + "]" + ;
                    " ListCount=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.ListCount) + CHR(13) + CHR(10)

            loc_c = loc_c + "  Itens do combo:  "
            IF loc_oF.cbo_4c_Opcoes.ListCount = 0
                loc_c = loc_c + "<nenhum>"
            ELSE
                FOR loc_nI = 1 TO loc_oF.cbo_4c_Opcoes.ListCount
                    loc_c = loc_c + "[" + TRANSFORM(loc_oF.cbo_4c_Opcoes.List(loc_nI)) + "]"
                ENDFOR
            ENDIF
            loc_c = loc_c + CHR(13) + CHR(10)

            loc_oF = .NULL.
        ENDIF
    CATCH TO loc_oE
        loc_c = loc_c + "  EXCECAO: " + loc_oE.Message + ;
                " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
                " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_c
ENDPROC
