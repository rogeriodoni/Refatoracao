*==============================================================================
* ProbeF7Task809.prg - Prova os TRES caminhos de saida do Formsigoptef
* (Fase 7/8): botao Cancelar, ESC (KeyPress) e Alt+F4 (WM_CLOSE -> QueryUnload).
*
* O que tem de ser verdade nos tres: o form fica INVISIVEL e o objeto continua
* VIVO (VARTYPE = "O"), para o chamador poder ler o resultado e chamar
* Release() ele mesmo (ver EncerrarDialogo no .prg migrado).
*
* Show(2) forca MODELESS: em VFP9 headless o Show() de form modal BLOQUEIA e o
* probe nunca termina. O que se mede aqui - QueryUnload, Hide() e tempo de vida
* do objeto - nao depende da modalidade; o que Show(2) NAO prova eh o "Hide()
* devolve o Show()" do caso modal.
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (licao
* "configurarambiente_bloqueia_probe_de_form"). As dependencias do form sao
* carregadas a mao, e gnConnHandle = 0 de proposito - eh o que o
* TesteAutomatico.prg faz, e CarregarParametrosPagamento pula o SQL nesse modo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loF, lcPath, loc_oErro
lcPath = "C:\4c\automation\_f7t809_probe.txt"
lcOut  = ""

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_UsuarioLogado
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7t809_erros.txt"
gc_4c_UsuarioLogado    = "PROBE"

STRTOFILE("P1 inicio" + CHR(13) + CHR(10), lcPath)

DECLARE INTEGER SendMessage IN "user32.dll" ;
    INTEGER hWnd, INTEGER wMsg, INTEGER wParam, INTEGER lParam

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("P2 config.prg OK" + CHR(13) + CHR(10), lcPath, 1)

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
                 gc_4c_CaminhoIcones)

    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoptefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoptef.prg") ADDITIVE

    STRTOFILE("P3 dependencias OK" + CHR(13) + CHR(10), lcPath, 1)
CATCH TO loc_oErro
    STRTOFILE("P3 SETUP FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

*-- Caminho 1: BtnCancelarClick (o Click do botao Cancelar)
TRY
    loF = CREATEOBJECT("Formsigoptef")
    lcOut = "C1_CRIOU=" + VARTYPE(loF) + CHR(13) + CHR(10)
    STRTOFILE(lcOut, lcPath, 1)
    loF.Show(2)
    STRTOFILE("C1_VISIBLE_ANTES=" + TRANSFORM(loF.Visible) + CHR(13) + CHR(10), lcPath, 1)
    loF.BtnCancelarClick()
    STRTOFILE("C1_VARTYPE_DEPOIS=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    STRTOFILE("C1_VISIBLE_DEPOIS=" + TRANSFORM(loF.Visible) + CHR(13) + CHR(10), lcPath, 1)
    STRTOFILE("C1_LEITURA_POS=" + TRANSFORM(loF.this_nValPago) + CHR(13) + CHR(10), lcPath, 1)
    STRTOFILE("C1_BO_CANCELADO=" + TRANSFORM(loF.this_oBusinessObject.this_lCancelado) + CHR(13) + CHR(10), lcPath, 1)
    loF.Release()
    STRTOFILE("C1_APOS_RELEASE=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
CATCH TO loc_oErro
    STRTOFILE("C1_ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

*-- Caminho 2: ESC pelo KeyPress do form
TRY
    loF = CREATEOBJECT("Formsigoptef")
    loF.Show(2)
    loF.KeyPress(27, 0)
    STRTOFILE("C2_VARTYPE_DEPOIS=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    STRTOFILE("C2_VISIBLE_DEPOIS=" + TRANSFORM(loF.Visible) + CHR(13) + CHR(10), lcPath, 1)
    loF.Release()
    STRTOFILE("C2_APOS_RELEASE=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
CATCH TO loc_oErro
    STRTOFILE("C2_ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

*-- Caminho 3: Alt+F4 (o VFP levanta QueryUnload no WM_CLOSE)
TRY
    loF = CREATEOBJECT("Formsigoptef")
    loF.Show(2)
    SendMessage(loF.HWnd, 0x0010, 0, 0)
    STRTOFILE("C3_VARTYPE_DEPOIS=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    IF VARTYPE(loF) = "O"
        STRTOFILE("C3_VISIBLE_DEPOIS=" + TRANSFORM(loF.Visible) + CHR(13) + CHR(10), lcPath, 1)
        loF.Release()
        STRTOFILE("C3_APOS_RELEASE=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    ELSE
        STRTOFILE("C3_DESTRUIDO=SIM (QueryUnload nao protegeu)" + CHR(13) + CHR(10), lcPath, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("C3_ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

STRTOFILE("FIM" + CHR(13) + CHR(10), lcPath, 1)
QUIT
