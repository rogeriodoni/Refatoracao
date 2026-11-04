*==============================================================================
* ProbeErro303Oet.prg - Mede, em coordenadas de TELA (Top + PageFrame.Top), a
* faixa do cabecalho e os botoes das DUAS paginas do FormOET, e lista o 1o
* controle de dados de cada uma (para saber se a faixa pode subir).
* PROCEDURE/FUNCTION no FIM; log nao se chama Log (colide com a nativa).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcL303, goF303
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_oet303.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcL303 = "C:\4c\automation\probe_erro303_oet.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL303)

LOCAL loc_oE, loPg1, loPg2, loc_nOff, loc_nI, loc_oC, loc_nMin, loc_cMin

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "OETBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormOET.prg") ADDITIVE
    LogP303("B: deps carregadas")

    goF303 = CREATEOBJECT("FormOET")
    LogP303("C: CREATEOBJECT -> " + VARTYPE(goF303) + ;
            "  Width=" + TRANSFORM(goF303.Width) + " Height=" + TRANSFORM(goF303.Height))

    loc_nOff = goF303.pgf_4c_Paginas.Top
    loPg1 = goF303.pgf_4c_Paginas.Page1
    loPg2 = goF303.pgf_4c_Paginas.Page2
    LogP303("   PageFrame.Top = " + TRANSFORM(loc_nOff))

    LogP303("D: --- PAGE1 (Lista) ---")
    LogP303("   faixa          tela " + Faixa(loPg1, loc_nOff))
    LogP303("   cnt_4c_Botoes  tela " + Cnt(loPg1, "cnt_4c_Botoes", loc_nOff))
    LogP303("   btn Incluir    tela " + Btn(loPg1, "cnt_4c_Botoes", "cmd_4c_Incluir", loc_nOff))
    LogP303("   cnt_4c_Saida   tela " + Cnt(loPg1, "cnt_4c_Saida", loc_nOff))
    LogP303("   btn Encerrar   tela " + Btn(loPg1, "cnt_4c_Saida", "cmd_4c_Encerrar", loc_nOff))

    LogP303("E: --- PAGE2 (Dados) ---")
    LogP303("   faixa              tela " + Faixa(loPg2, loc_nOff))
    LogP303("   cnt_4c_BotoesAcao  tela " + Cnt(loPg2, "cnt_4c_BotoesAcao", loc_nOff))
    LogP303("   btn Confirmar      tela " + Btn(loPg2, "cnt_4c_BotoesAcao", "cmd_4c_Confirmar", loc_nOff))
    LogP303("   btn Encerrar       tela " + Btn(loPg2, "cnt_4c_BotoesAcao", "cmd_4c_Cancelar", loc_nOff))

    *-- 1o controle de dados de cada pagina (define ate onde a faixa pode descer)
    LogP303("F: 1o controle de dados da Page1: " + PrimeiroDado(loPg1))
    LogP303("   1o controle de dados da Page2: " + PrimeiroDado(loPg2))

    goF303.Release()
    LogP303("G: Release OK")

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), gcL303, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), gcL303, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL303, 1)
QUIT

PROCEDURE LogP303(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL303, 1)
ENDPROC

FUNCTION Faixa(par_oPg, par_nOff)
    IF !PEMSTATUS(par_oPg, "cnt_4c_Cabecalho", 5)
        RETURN "(sem cnt_4c_Cabecalho)"
    ENDIF
    RETURN TRANSFORM(par_oPg.cnt_4c_Cabecalho.Top + par_nOff) + ".." + ;
           TRANSFORM(par_oPg.cnt_4c_Cabecalho.Top + par_oPg.cnt_4c_Cabecalho.Height + par_nOff) + ;
           "   (Top=" + TRANSFORM(par_oPg.cnt_4c_Cabecalho.Top) + ;
           " Height=" + TRANSFORM(par_oPg.cnt_4c_Cabecalho.Height) + ")"
ENDFUNC

FUNCTION Cnt(par_oPg, par_cNome, par_nOff)
    LOCAL loO
    IF !PEMSTATUS(par_oPg, par_cNome, 5)
        RETURN "(ausente)"
    ENDIF
    loO = EVALUATE("par_oPg." + par_cNome)
    RETURN TRANSFORM(loO.Top + par_nOff) + ".." + TRANSFORM(loO.Top + loO.Height + par_nOff) + ;
           "   (Top=" + TRANSFORM(loO.Top) + " Height=" + TRANSFORM(loO.Height) + ")"
ENDFUNC

FUNCTION Btn(par_oPg, par_cCnt, par_cBtn, par_nOff)
    LOCAL loC, loB
    IF !PEMSTATUS(par_oPg, par_cCnt, 5)
        RETURN "(container ausente)"
    ENDIF
    loC = EVALUATE("par_oPg." + par_cCnt)
    IF !PEMSTATUS(loC, par_cBtn, 5)
        RETURN "(botao ausente)"
    ENDIF
    loB = EVALUATE("loC." + par_cBtn)
    RETURN TRANSFORM(loC.Top + loB.Top + par_nOff) + ".." + ;
           TRANSFORM(loC.Top + loB.Top + loB.Height + par_nOff) + ;
           "   (btn.Top=" + TRANSFORM(loB.Top) + " Height=" + TRANSFORM(loB.Height) + ")"
ENDFUNC

FUNCTION PrimeiroDado(par_oPg)
    LOCAL lnI, loC, lnMin, lcMin
    lnMin = 99999
    lcMin = "(nenhum)"
    FOR lnI = 1 TO par_oPg.ControlCount
        loC = par_oPg.Controls(lnI)
        IF UPPER(loC.BaseClass) $ "TEXTBOXLABELCHECKBOXGRIDEDITBOXCOMBOBOXSPINNER"
            IF loC.Top < lnMin
                lnMin = loC.Top
                lcMin = ALLTRIM(loC.Name) + " [" + ALLTRIM(loC.BaseClass) + "] Top=" + ;
                        TRANSFORM(loC.Top)
            ENDIF
        ENDIF
    ENDFOR
    RETURN lcMin
ENDFUNC
