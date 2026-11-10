*-- Probe de instanciacao do Formsigopfis (Fase 7 - task742).
*-- NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
*-- morreria por timeout antes do CREATEOBJECT). Carrega a mao so o que o
*-- form usa.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loForm, lcSaida, lcMet, lnI, lnEv, lnQtd, loErro, loErro2
LOCAL ARRAY laEv[1, 5]
lcSaida = "C:\4c\automation\_probe742f7_resultado.txt"
lcOut   = ""

DO ("C:\4c\projeto\app\start\config.prg")

*-- SET PATH com UMA string concatenada: varias expressoes entre parenteses
*-- honram SO a primeira (regra #26)
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopfisBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\Formsigopfis.prg") ADDITIVE

*-- O PAR eh obrigatorio: sem gc_4c_ArquivoErroTeste o MsgErro/MsgAviso cai
*-- no MESSAGEBOX real e o processo fica pendurado sem gravar nada
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe742f7_dialogs.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)

*-- Legado: Init(loForm, loDatses). Migrado: (par_cCidchaves, par_oFormPai).
*-- Sem argumentos para exercitar o bypass de modo teste.
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigopfis")
CATCH TO loErro
    lcOut = lcOut + "EXCECAO NO CREATEOBJECT: " + loErro.Message + ;
            " LN=" + TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

lcOut = lcOut + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIACAO     = OK" + CHR(13) + CHR(10)
    lcOut = lcOut + "BaseClass        = " + loForm.BaseClass + CHR(13) + CHR(10)
    lcOut = lcOut + "Caption          = " + loForm.Caption + CHR(13) + CHR(10)
    lcOut = lcOut + "Width x Height   = " + TRANSFORM(loForm.Width) + " x " + ;
            TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcOut = lcOut + "PageCount        = " + TRANSFORM(loForm.pgf_4c_1.PageCount) + CHR(13) + CHR(10)

    *-- Os 9 handlers de Click: existencia E escopo. PEMSTATUS(...,5) so prova
    *-- EXISTENCIA; BINDEVENT exige PUBLIC, e metodo PROTECTED falha em
    *-- silencio (regra #3). PEMSTATUS(...,2) = protegido tem de dar .F.
    lcOut = lcOut + "--- handlers de Click (5=existe / 2=protegido) ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 9
        lcMet = GETWORDNUM("BtnConfirmarClick CmdImprimirEtiquetasClick " + ;
                           "CmdReimprimirDanfeClick CmdEnviarEmailNfeClick " + ;
                           "CmdCancelarNotaClick CmdCartaCorrecaoClick " + ;
                           "CmdProcessosNfceClick CmdGerarXmlClick " + ;
                           "CmdGerarNfeClick", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 28) + " existe=" + ;
                TRANSFORM(PEMSTATUS(loForm, lcMet, 5)) + ;
                "  protegido=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 2)) + CHR(13) + CHR(10)
    ENDFOR

    *-- BINDEVENT realmente ligado? AEVENTS com 2 argumentos lista os eventos
    *-- ligados ao OBJETO (coluna 3 = nome do evento de origem).
    lcOut = lcOut + "--- BINDEVENT do Click de cada botao ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 9
        lcMet = GETWORDNUM("cmd_4c_Ok pgf_4c_1.Page1.cmd_4c_ImpEtiqueta " + ;
                           "pgf_4c_1.Page1.cmd_4c_Fwbtnm1 pgf_4c_1.Page1.cmd_4c_Fwbtnm2 " + ;
                           "pgf_4c_1.Page1.cmd_4c_Fwbtnm3 pgf_4c_1.Page1.cmd_4c_Fwbtnm4 " + ;
                           "pgf_4c_1.Page1.cmd_4c_Fwbtnm5 pgf_4c_1.Page1.cmd_4c_Fwbtnm6 " + ;
                           "pgf_4c_1.Page1.cmd_4c_Fwbtnm7", lnI)
        lnQtd = 0
        IF TYPE("loForm." + lcMet) = "O"
            lnQtd = AEVENTS(laEv, EVALUATE("loForm." + lcMet))
        ENDIF
        lcOut = lcOut + "  " + PADR(lcMet, 34) + " eventos=" + TRANSFORM(lnQtd)
        FOR lnEv = 1 TO lnQtd
            lcOut = lcOut + " [" + TRANSFORM(laEv[lnEv, 3]) + "->" + ;
                    TRANSFORM(laEv[lnEv, 4]) + "]"
        ENDFOR
        lcOut = lcOut + CHR(13) + CHR(10)
    ENDFOR

    *-- Chamadas REAIS de fora da classe. Sem chave de nota, sem empresa e sem
    *-- conexao, cada handler para na sua PRIMEIRA guarda - e eh justamente
    *-- isso que se quer provar: o metodo eh alcancavel de fora e a guarda
    *-- esta no lugar, sem Program Error cru.
    lcOut = lcOut + "--- chamadas reais de fora ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 8
        lcMet = GETWORDNUM("CmdCancelarNotaClick CmdCartaCorrecaoClick " + ;
                           "CmdProcessosNfceClick CmdImprimirEtiquetasClick " + ;
                           "CmdGerarNfeClick CmdGerarXmlClick " + ;
                           "CmdEnviarEmailNfeClick CmdReimprimirDanfeClick", lnI)
        TRY
            EVALUATE("loForm." + lcMet + "()")
            lcOut = lcOut + "  " + PADR(lcMet, 28) + " -> OK" + CHR(13) + CHR(10)
        CATCH TO loErro2
            lcOut = lcOut + "  " + PADR(lcMet, 28) + " -> EXCECAO: " + ;
                    loErro2.Message + " LN=" + TRANSFORM(loErro2.LineNo) + ;
                    " PROC=" + loErro2.Procedure + CHR(13) + CHR(10)
        ENDTRY
    ENDFOR

    *-- BtnConfirmarClick fica por ULTIMO: ele termina em Release().
    TRY
        loForm.BtnConfirmarClick()
        lcOut = lcOut + "  " + PADR("BtnConfirmarClick", 28) + " -> OK (liberou o form)" + ;
                CHR(13) + CHR(10)
    CATCH TO loErro2
        lcOut = lcOut + "  " + PADR("BtnConfirmarClick", 28) + " -> EXCECAO: " + ;
                loErro2.Message + " LN=" + TRANSFORM(loErro2.LineNo) + ;
                " PROC=" + loErro2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    loForm = .NULL.
ELSE
    lcOut = lcOut + "INSTANCIACAO     = FALHOU" + CHR(13) + CHR(10)
ENDIF

lcOut = lcOut + "--- dialogos suprimidos ---" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, lcSaida)
QUIT
