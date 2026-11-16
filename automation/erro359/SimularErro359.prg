*==============================================================================
* SimularErro359.prg - Fluxo Financeiro Sintetico (Formsigreffn / sigreffnBO)
* 1) instancia o form e confere sobreposicao dos controles da Page1
* 2) roda PrepararDados com os titulos T359CCR* (13/11 a 30/11/2026)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loc_oPag, loc_nI, loc_nJ, loc_oA, loc_oB, loc_nSobre
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro359\erro.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_cOut = loc_cOut + "conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10)
    GarantirClasse("Formsigreffn")

    *-- 1) Layout
    loForm = CREATEOBJECT("Formsigreffn")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    IF VARTYPE(loForm) = "O"
        loc_oPag = loForm.pgf_4c_Paginas.Page1
        loc_nSobre = 0
        FOR loc_nI = 1 TO loc_oPag.ControlCount
            loc_oA = loc_oPag.Controls(loc_nI)
            loc_cOut = loc_cOut + PADR(loc_oA.Name, 26) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + ;
                " W=" + PADL(loc_oA.Width,4) + " H=" + PADL(loc_oA.Height,4) + CHR(13)+CHR(10)
            FOR loc_nJ = loc_nI + 1 TO loc_oPag.ControlCount
                loc_oB = loc_oPag.Controls(loc_nJ)
                IF loc_oA.Left < loc_oB.Left + loc_oB.Width AND loc_oB.Left < loc_oA.Left + loc_oA.Width AND ;
                   loc_oA.Top < loc_oB.Top + loc_oB.Height AND loc_oB.Top < loc_oA.Top + loc_oA.Height
                    loc_nSobre = loc_nSobre + 1
                    loc_cOut = loc_cOut + "   >> SOBREPOE " + loc_oB.Name + CHR(13)+CHR(10)
                ENDIF
            ENDFOR
        ENDFOR
        loc_cOut = loc_cOut + "sobreposicoes=" + TRANSFORM(loc_nSobre) + CHR(13)+CHR(10)
        loForm.Release()
    ENDIF

    *-- 2) Dados
    loBO = CREATEOBJECT("T359BO")
    loBO.InicializarCursoresAuxiliares()
    loBO.MarcarEmpresas()
    loBO.MarcarDisponibilidades()
    loBO.MarcarOperacoes()
    loBO.this_dDtInicial = {^2026-11-13}
    loBO.this_dDtFinal   = {^2026-11-30}
    loBO.this_cCdMoeda = "R"
    loBO.this_cDsMoeda = "REAIS"
    loBO.this_nVlCotacao = 1
    loBO.this_cCdMoedl = ""
    loBO.this_nTotalizaContas = 0
    loBO.this_nConciliado = 0
    loBO.this_nOpcao = 3
    loBO.this_nTipoImp = 1
    loBO.this_nListaAtra = 1
    loBO.this_nConsidAtra = 2
    loBO.this_nPrev = 3
    loBO.this_nSitua = 2
    loBO.this_nSaldo = 1
    loc_cOut = loc_cOut + "PrepararDados=" + TRANSFORM(loBO.Rodar()) + " msg=" + loBO.ObterMensagemErro() + CHR(13)+CHR(10)
    SELECT csRelatorio
    SET ORDER TO
    SCAN
        loc_cOut = loc_cOut + "F" + TRANSFORM(Fase) + " " + PADR(ALLTRIM(Grupos)+"/"+ALLTRIM(Contas),22) + ;
            " Saldos=" + TRANSFORM(Saldos) + " Venc=" + Vencs + " Pags=" + TRANSFORM(Pags) + " Recs=" + TRANSFORM(Recs) + ;
            " DoDia=" + TRANSFORM(do_Dia) + " Acum=" + TRANSFORM(Acumulado) + " Saldo=" + TRANSFORM(Saldo) + CHR(13)+CHR(10)
    ENDSCAN
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro359\simulacao_out.txt")
QUIT

DEFINE CLASS T359BO AS sigreffnBO
    PROCEDURE Rodar()
        RETURN THIS.PrepararDados()
    ENDPROC
ENDDEFINE
