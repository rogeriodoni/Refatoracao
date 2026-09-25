*==============================================================================
* test_task571_fase7.prg - instancia o Formsigmvitn e confere que os handlers
* da Fase 7 existem E que os BINDEVENT novos apontam para controles REAIS.
*
* Por que instanciar: BINDEVENT contra controle inexistente estoura DENTRO do
* TRY do InicializarForm - o CREATEOBJECT devolveria .F. sem exception visivel
* (CLAUDE.md: "a tela abre so se prova instanciando").
*
* O log e gravado com STRTOFILE a CADA passo (grava e fecha na hora): se algum
* handler abrir dialogo/modal e travar o processo headless, o arquivo mostra
* exatamente onde parou (tecnica da CLAUDE.md #29).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gp_cSaida, gp_cTexto
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_task571_fase7_erros.txt"
gp_cSaida              = "C:\4c\automation\vfp_helpers\test_task571_fase7_result.txt"
gp_cTexto              = ""

LOCAL loc_oForm, loc_oErro, loc_i, loc_cM, loc_nOk, loc_nFalta
LOCAL ARRAY loc_aMetodos[11]

RegistrarPasso("inicio")

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
RegistrarPasso("config + ConfigurarAmbiente OK")

*-- SET PROCEDURE explicito: o ADIR do config empilha 912 arquivos; o teste da
*-- Fase 4 tambem carregava na mao.
SET PROCEDURE TO (gcCaminhoClasses + "sigmvitnBO.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigmvitn.prg") ADDITIVE
RegistrarPasso("SET PROCEDURE explicito OK")

loc_aMetodos[1]  = "CmdEnviaProdClick"
loc_aMetodos[2]  = "IdentificaProximoClick"
loc_aMetodos[3]  = "BtnCadastrosDestinoClick"
loc_aMetodos[4]  = "BtnCadastrosOrigemClick"
loc_aMetodos[5]  = "CmdTefChqClick"
loc_aMetodos[6]  = "CmdInsChequeClick"
loc_aMetodos[7]  = "LimparCntItem"
loc_aMetodos[8]  = "ExcluirItemCorrente"
loc_aMetodos[9]  = "AbrirCadastroConta"
loc_aMetodos[10] = "LimparChequePreTef"
loc_aMetodos[11] = "ValidarChequesLancados"

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("Formsigmvitn")
CATCH TO loc_oErro
    RegistrarPasso("EXCEPTION no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Procedure: " + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    RegistrarPasso("INSTANCIOU OK - BaseClass=[" + loc_oForm.BaseClass + "] Caption=[" + loc_oForm.Caption + "]")

    loc_nOk    = 0
    loc_nFalta = 0
    FOR loc_i = 1 TO ALEN(loc_aMetodos)
        loc_cM = loc_aMetodos[loc_i]
        IF PEMSTATUS(loc_oForm, loc_cM, 5)
            loc_nOk = loc_nOk + 1
        ELSE
            loc_nFalta = loc_nFalta + 1
            RegistrarPasso("METODO AUSENTE: " + loc_cM)
        ENDIF
    ENDFOR
    RegistrarPasso("metodos da Fase 7 presentes: " + TRANSFORM(loc_nOk) + " / ausentes: " + TRANSFORM(loc_nFalta))

    *-- Os controles-alvo dos BINDEVENT novos existem de fato?
    RegistrarPasso("alvo cmd_4c_CmdEnviaProd = " + ;
        TYPE("loc_oForm.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd"))
    RegistrarPasso("alvo Identifica.cmd_4c_Proximo = " + ;
        TYPE("loc_oForm.cnt_4c__Identifica.cmd_4c_Proximo"))
    RegistrarPasso("alvo Destino.cmd_4c_BtnCadastros = " + ;
        TYPE("loc_oForm.cnt_4c__Identifica.cnt_4c_Destino.cmd_4c_BtnCadastros"))
    RegistrarPasso("alvo Origem.cmd_4c_BtnCadastros = " + ;
        TYPE("loc_oForm.cnt_4c__Identifica.cnt_4c_Origem.cmd_4c_BtnCadastros"))
    RegistrarPasso("alvo Cnt_Chq.cmd_4c_TefChq = " + ;
        TYPE("loc_oForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq.cmd_4c_TefChq"))
    RegistrarPasso("alvo Cnt_Chq.cmd_4c_Ins = " + ;
        TYPE("loc_oForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq.cmd_4c_Ins"))

    *-- Handlers que NAO podem abrir dialogo nem soltar a tela.
    TRY
        loc_oForm.CmdInsChequeClick()
        RegistrarPasso("CmdInsChequeClick executou sem exception")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION CmdInsChequeClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.IdentificaProximoClick()
        RegistrarPasso("IdentificaProximoClick executou sem exception")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION IdentificaProximoClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    *-- Guard do btnCadastros: Conta/CPF vazios devem BARRAR antes de qualquer
    *-- CREATEOBJECT("FormCTA") - se o Show() modal abrisse, o processo travaria
    *-- e este log pararia aqui (CLAUDE.md #37).
    TRY
        loc_oForm.BtnCadastrosDestinoClick()
        RegistrarPasso("BtnCadastrosDestinoClick barrou sem abrir FormCTA (guard Conta/CPF)")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION BtnCadastrosDestinoClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.BtnCadastrosOrigemClick()
        RegistrarPasso("BtnCadastrosOrigemClick barrou sem abrir FormCTA (guard Conta/CPF)")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION BtnCadastrosOrigemClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    *-- CmdEnviaProdClick com Valor=0: caminho de rejeicao (MsgAviso suprimido
    *-- em modo teste) + ExcluirItemCorrente + LimparCntItem.
    TRY
        loc_oForm.CmdEnviaProdClick()
        RegistrarPasso("CmdEnviaProdClick executou sem exception")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION CmdEnviaProdClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    *-- CmdTefChqClick fica por ULTIMO: no caminho de sucesso ele pode chamar
    *-- CmdOkClick, que faz Release() do form.
    TRY
        loc_oForm.CmdTefChqClick()
        RegistrarPasso("CmdTefChqClick executou sem exception")
    CATCH TO loc_oErro
        RegistrarPasso("EXCEPTION CmdTefChqClick: " + loc_oErro.Message + ;
            " | Linha: " + TRANSFORM(loc_oErro.LineNo) + " | Procedure: " + loc_oErro.Procedure)
    ENDTRY

    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.Release()
    ENDIF
    RegistrarPasso("Release OK")
ELSE
    RegistrarPasso("FALHOU - CREATEOBJECT devolveu " + VARTYPE(loc_oForm))
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    RegistrarPasso("--- ERROS CAPTURADOS EM MODO TESTE ---")
    RegistrarPasso(FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF

RegistrarPasso("=== FIM ===")
QUIT

PROCEDURE RegistrarPasso(par_cLinha)
    gp_cTexto = gp_cTexto + par_cLinha + CHR(13) + CHR(10)
    STRTOFILE(gp_cTexto, gp_cSaida)
ENDPROC
