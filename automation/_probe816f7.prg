*==============================================================================
* _probe816f7.prg - Probe da Fase 7 do Formsigopvci (task816)
*
* Prova que a tela ABRE depois das mudancas da Fase 7 e que os DOIS handlers
* de botao do legado existem, sao PUBLIC e estao LIGADOS aos botoes certos.
*
* gnConnHandle = 0 + gb_4c_ValidandoUI = .T.: CarregarConfiguracaoFiscal nao
* toca no SQL Server (inalcancavel nesta maquina) e o Init nao exibe o dialogo
* de conexao. gb_4c_ModoTeste redireciona MsgAviso/MsgErro/MsgInfo a arquivo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe816f7_dialogs.txt"
gb_4c_ValidandoUI      = .T.
gnConnHandle           = 0

LOCAL lcOut, lcCk, loForm, lcR, lnI, loErr
LOCAL ARRAY laEv[1]
lcCk  = "C:\4c\automation\_probe816f7_ck.txt"
lcOut = "C:\4c\automation\_probe816f7_out.txt"

ON ERROR STRTOFILE("ON ERROR: " + MESSAGE() + " LINENO=" + TRANSFORM(LINENO()) + ;
    " PROG=" + PROGRAM() + CHR(13) + CHR(10), lcCk, .T.)

STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), lcCk)
CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK2 config.prg ok" + CHR(13) + CHR(10), lcCk, .T.)
ConfigurarAmbiente()
STRTOFILE("CK3 ConfigurarAmbiente ok" + CHR(13) + CHR(10), lcCk, .T.)
GarantirClasse("Formsigopvci")
STRTOFILE("CK4 GarantirClasse ok" + CHR(13) + CHR(10), lcCk, .T.)

loForm = CREATEOBJECT("Formsigopvci")
STRTOFILE("CK5 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcCk, .T.)

lcR = "VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcR = lcR + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcR = lcR + "ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)
    lcR = lcR + "BaseClass=[" + loForm.BaseClass + "]" + CHR(13) + CHR(10)

    *-- Existencia + ESCOPO dos handlers (2 = Protected). PEMSTATUS(...,5) da
    *-- .T. ate em metodo PROTECTED, por isso os dois atributos.
    lcR = lcR + "BtnConsultarClick existe=" + TRANSFORM(PEMSTATUS(loForm, "BtnConsultarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loForm, "BtnConsultarClick", 2)) + CHR(13) + CHR(10)
    lcR = lcR + "BtnEncerrarClick existe=" + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 2)) + CHR(13) + CHR(10)
    lcR = lcR + "ValidarFaixaConsulta existe=" + TRANSFORM(PEMSTATUS(loForm, "ValidarFaixaConsulta", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loForm, "ValidarFaixaConsulta", 2)) + CHR(13) + CHR(10)
    lcR = lcR + "ResolverFaixaMFD existe=" + TRANSFORM(PEMSTATUS(loForm, "ResolverFaixaMFD", 5)) + CHR(13) + CHR(10)
    lcR = lcR + "BO.ResolverSequenciaPorData existe=" + ;
        TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject, "ResolverSequenciaPorData", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject, "ResolverSequenciaPorData", 2)) + CHR(13) + CHR(10)

    *-- BINDEVENT dos botoes: AEVENTS devolve o alvo na coluna 3 e o metodo na 4
    TRY
        lnI = AEVENTS(laEv, loForm.cmg_4c_Botoes.Buttons(1))
        lcR = lcR + "Buttons(1) binds=" + TRANSFORM(lnI) + CHR(13) + CHR(10)
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcR = lcR + "  B1 evento=[" + TRANSFORM(laEv[lnI, 3]) + "] metodo=[" + ;
                TRANSFORM(laEv[lnI, 4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
    CATCH TO loErr
        lcR = lcR + "AEVENTS B1 ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    TRY
        lnI = AEVENTS(laEv, loForm.cmg_4c_Botoes.Buttons(2))
        lcR = lcR + "Buttons(2) binds=" + TRANSFORM(lnI) + CHR(13) + CHR(10)
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcR = lcR + "  B2 evento=[" + TRANSFORM(laEv[lnI, 3]) + "] metodo=[" + ;
                TRANSFORM(laEv[lnI, 4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
    CATCH TO loErr
        lcR = lcR + "AEVENTS B2 ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- Exercita a VALIDACAO de faixa (nao toca na impressora)
    TRY
        loForm.obj_4c_Optiongroup1.Value = 1
        loForm.txt_4c_Text1.Value = ""
        loForm.txt_4c_Text2.Value = ""
        lcR = lcR + "ValidarFaixaConsulta(vazia)=" + TRANSFORM(loForm.ValidarFaixaConsulta()) + CHR(13) + CHR(10)

        loForm.txt_4c_Text1.Value = "000010"
        loForm.txt_4c_Text2.Value = "000005"
        lcR = lcR + "ValidarFaixaConsulta(10>5)=" + TRANSFORM(loForm.ValidarFaixaConsulta()) + CHR(13) + CHR(10)

        loForm.txt_4c_Text1.Value = "000005"
        loForm.txt_4c_Text2.Value = "000010"
        lcR = lcR + "ValidarFaixaConsulta(5a10)=" + TRANSFORM(loForm.ValidarFaixaConsulta()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "VALIDACAO ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- ResolverFaixaMFD por CUPOM (nao consulta banco nem DLL)
    TRY
        loForm.obj_4c_Optiongroup1.Value = 1
        lcR = lcR + "ResolverFaixaMFD(cupom)=" + TRANSFORM(loForm.ResolverFaixaMFD()) + ;
            " tipo=[" + loForm.this_cTipoMFD + "] ini=[" + loForm.this_cInicioMFD + ;
            "] fim=[" + loForm.this_cFimMFD + "]" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "RESOLVER ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- Clique no Consultar com faixa INVALIDA: recusa na validacao e NAO chega
    *-- a impressora; o segundo clique prova que a flag foi liberada.
    TRY
        loForm.obj_4c_Optiongroup1.Value = 1
        loForm.txt_4c_Text1.Value = ""
        loForm.txt_4c_Text2.Value = ""
        loForm.BtnConsultarClick()
        lcR = lcR + "BtnConsultarClick(1a) OK EmConsulta=" + ;
            TRANSFORM(loForm.this_lEmConsulta) + CHR(13) + CHR(10)
        loForm.BtnConsultarClick()
        lcR = lcR + "BtnConsultarClick(2a) OK EmConsulta=" + ;
            TRANSFORM(loForm.this_lEmConsulta) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "CONSULTAR ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- CarregarCupomDeArquivo com SDF de verdade: prova o caminho que os
    *-- quatro ramos de impressora compartilham, sem precisar de DLL
    TRY
        STRTOFILE(PADR("CUPOM FISCAL LINHA 1", 50) + CHR(13) + CHR(10) + ;
                  PADR("ITEM 001 TESTE", 50) + CHR(13) + CHR(10), ;
                  "C:\4c\automation\_probe816f7_mfd.txt")
        lcR = lcR + "CarregarCupomDeArquivo=" + ;
            TRANSFORM(loForm.CarregarCupomDeArquivo("C:\4c\automation\_probe816f7_mfd.txt", 50)) + CHR(13) + CHR(10)
        lcR = lcR + "  Edit1 len=" + TRANSFORM(LEN(loForm.edt_4c_Edit1.Value)) + ;
            " ini=[" + LEFT(loForm.edt_4c_Edit1.Value, 25) + "]" + CHR(13) + CHR(10)
        lcR = lcR + "  BO.this_cConteudoCupom len=" + ;
            TRANSFORM(LEN(loForm.this_oBusinessObject.this_cConteudoCupom)) + CHR(13) + CHR(10)
        lcR = lcR + "  cursor_4c_Mfd aberto depois=" + TRANSFORM(USED("cursor_4c_Mfd")) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "CARREGARCUPOM ERRO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- ObterDiretorioDaruma: sem o XML tem de devolver o default do legado
    TRY
        lcR = lcR + "ObterDiretorioDaruma=[" + loForm.ObterDiretorioDaruma() + "]" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "DARUMA DIR ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- Wrappers de funcao global do legado criados nesta fase
    TRY
        lcR = lcR + "LeituraFab=[" + LeituraFab("") + "]" + ;
            " LeMFD=" + TRANSFORM(LeMFD("1", "2", "")) + ;
            " VerifPorta=" + TRANSFORM(VerifPorta()) + ;
            " RotStatus=" + TRANSFORM(RotStatus(.T.)) + ;
            " FecharPorta=" + TRANSFORM(FecharPorta(.T.)) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcR = lcR + "WRAPPERS ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
    lcR = lcR + "Release OK" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcR, lcOut)
STRTOFILE("CK9 fim" + CHR(13) + CHR(10), lcCk, .T.)
QUIT
