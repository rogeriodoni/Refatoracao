*-- Probe de instanciacao do Formsigopftc (Fase 7 - task737).
*-- NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
*-- morreria por timeout antes do CREATEOBJECT). Carrega a mao so o que o
*-- form usa.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loForm, lcSaida, lcMet, lnI
lcSaida = "C:\4c\automation\_probe737f7_resultado.txt"
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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopftcBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\Formsigopftc.prg") ADDITIVE

*-- O PAR eh obrigatorio: sem gc_4c_ArquivoErroTeste o MsgErro cai no
*-- MESSAGEBOX real e o processo fica pendurado sem gravar nada
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe737f7_dialogs.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)

*-- Legado: Init(pCnx, pcTipo, pcDopes). Migrado: (TipoAcao, Operacao, IClis)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigopftc", "INSERIR", "VENDA", "0000000001")
CATCH TO loErro
    lcOut = lcOut + "EXCECAO NO CREATEOBJECT: " + loErro.Message + ;
            " LN=" + TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

lcOut = lcOut + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIACAO     = OK" + CHR(13) + CHR(10)
    lcOut = lcOut + "BaseClass        = " + loForm.BaseClass + CHR(13) + CHR(10)
    lcOut = lcOut + "Caption          = " + loForm.Caption + CHR(13) + CHR(10)
    lcOut = lcOut + "Width x Height   = " + TRANSFORM(loForm.Width) + " x " + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcOut = lcOut + "CriouForm        = " + TRANSFORM(loForm.this_lCriouForm) + CHR(13) + CHR(10)
    lcOut = lcOut + "TipoAcao         = [" + loForm.this_cTipoAcao + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "Operacao         = [" + loForm.this_cOperacao + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "IClis            = [" + loForm.this_cIclis + "]" + CHR(13) + CHR(10)

    *-- Os eventos principais tem de ser alcancaveis DE FORA (o form pai os
    *-- chama assim). PEMSTATUS(...,5) so prova EXISTENCIA, nao escopo
    *-- (regra #3/#51) - por isso a chamada real logo abaixo.
    lcOut = lcOut + "--- PEMSTATUS dos eventos principais ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 7
        lcMet = GETWORDNUM("ChecarFichaTecnica MostrarForm OcultarForm " + ;
                           "MontarFichaTecnica CarregarFichaTecnica " + ;
                           "DesmontarFichaTecnica ValidarFichaTecnica", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 24) + " = " + ;
                TRANSFORM(PEMSTATUS(loForm, lcMet, 5)) + ;
                "  protegido=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 2)) + CHR(13) + CHR(10)
    ENDFOR

    *-- Chamadas REAIS de fora da classe. Sem cursor_4c_Ficha aberto, as tres
    *-- sao no-op guardado - e justamente isso prova que o metodo eh
    *-- alcancavel e que a guarda do legado esta no lugar.
    lcOut = lcOut + "--- chamadas reais de fora ---" + CHR(13) + CHR(10)
    TRY
        lcOut = lcOut + "  ValidarFichaTecnica()   -> " + TRANSFORM(loForm.ValidarFichaTecnica()) + CHR(13) + CHR(10)
        loForm.DesmontarFichaTecnica()
        lcOut = lcOut + "  DesmontarFichaTecnica() -> OK" + CHR(13) + CHR(10)
        loForm.OcultarForm()
        lcOut = lcOut + "  OcultarForm()           -> OK (AreaFicha.Visible=" + ;
                TRANSFORM(loForm.cnt_4c_AreaFicha.Visible) + ")" + CHR(13) + CHR(10)
        lcOut = lcOut + "  ChecarFichaTecnica('X') -> " + TRANSFORM(loForm.ChecarFichaTecnica("X")) + CHR(13) + CHR(10)
    CATCH TO loErro2
        lcOut = lcOut + "  EXCECAO: " + loErro2.Message + " LN=" + ;
                TRANSFORM(loErro2.LineNo) + " PROC=" + loErro2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
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
