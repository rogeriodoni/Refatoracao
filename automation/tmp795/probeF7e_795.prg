*-- Probe da FASE 7 de FormSIGOPRES (variante B): mesmo cenario do probe
*-- de Fase 3/4 que PASSOU (cursores do chamador existindo), mais a medicao
*-- do EVENTO do botao: depois de BtnEncerrarClick() a referencia do chamador
*-- tem de continuar viva e this_nSaldo legivel (Hide, nao Release).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcSaida
lcSaida = "C:\4c\automation\tmp795\probeF7e_795_r1.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_UsuarioLogado, gc_4c_ArquivoErroTeste
gnConnHandle        = 0
gb_4c_ModoTeste     = .T.
gc_4c_UsuarioLogado    = "TESTE"

*-- PAR OBRIGATORIO: gb_4c_ModoTeste sozinho NAO suprime dialogo -
*-- EscreverErroParaArquivo (messages.prg) exige TAMBEM gc_4c_ArquivoErroTeste,
*-- senao MsgErro cai num MESSAGEBOX real e o processo headless TRAVA.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp795\probeF7e_795_dialogs.txt"

*-- ON ERROR gravando em arquivo: sem ele, erro de runtime fora de TRY abre
*-- dialogo modal invisivel e o probe morre calado.
ON ERROR DO RegistrarErroProbe WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

STRTOFILE("PASSO=config.prg" + CHR(13) + CHR(10), lcSaida)
DO ("C:\4c\projeto\app\start\config.prg")

*-- config.prg redefine gb_4c_ValidandoUI = .F. no proprio corpo (linha 118):
*-- setar ANTES do DO eh sobrescrito em silencio.
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.
STRTOFILE("gnConnHandle pos-config=" + TRANSFORM(gnConnHandle) + ;
          CHR(13) + CHR(10), lcSaida, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPRESBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPRES.prg") ADDITIVE

*-- Cursores do chamador, iguais aos do probe que passou
CREATE CURSOR cab_teste (empdopnums C(29), datas D, prazoents D, dopes C(20))
INSERT INTO cab_teste (empdopnums, datas, prazoents, dopes) ;
    VALUES ("001MALOTE                   3", DATE(), DATE() + 15, "VENDA")

CREATE CURSOR item_teste (cpros C(14), qtds N(9,3), qtbaixas N(9,3))
INSERT INTO item_teste (cpros, qtds, qtbaixas) VALUES ("PROD001", 10, 0)

SELECT item_teste

STRTOFILE("PASSO=createobject" + CHR(13) + CHR(10), lcSaida, 1)

LOCAL loForm, loErro
loForm = .NULL.

TRY
    loForm = CREATEOBJECT("FormSIGOPRES", 123.456, "cab_teste", "item_teste")
CATCH TO loErro
    STRTOFILE("EXCECAO=" + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
              " PROC=" + loErro.Procedure + CHR(13) + CHR(10), lcSaida, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT=FALHOU (VARTYPE=" + VARTYPE(loForm) + ")" + ;
              CHR(13) + CHR(10), lcSaida, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT=OK" + CHR(13) + CHR(10), lcSaida, 1)

*-- Escopo: BtnEncerrarClick eh alvo de BINDEVENT -> tem de ser PUBLIC.
*-- PEMSTATUS(...,2) = .T. significaria PROTECTED.
STRTOFILE("PROT_BtnEncerrarClick=" + ;
          IIF(PEMSTATUS(loForm, "BtnEncerrarClick", 2), "SIM", "NAO") + ;
          "  PROT_FecharDialogo=" + ;
          IIF(PEMSTATUS(loForm, "FecharDialogo", 2), "SIM", "NAO") + ;
          "  EXISTE_FecharDialogo=" + ;
          IIF(PEMSTATUS(loForm, "FecharDialogo", 5), "SIM", "NAO") + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- Prova que o BINDEVENT do botao esta ligado ao handler certo
LOCAL ARRAY laEv[1, 5]
LOCAL lnEv, lnJ, lcBind
*-- AEVENTS tem DOIS argumentos; evento na coluna 3, metodo delegate na 4.
*-- TRY/CATCH (nao ON ERROR): ON ERROR retoma na linha seguinte e faria a
*-- checagem virar falso positivo.
lcBind = "(nao lido)"
TRY
    lnEv = AEVENTS(laEv, loForm.cmd_4c_Fwbtng1)
    lcBind = "n=" + TRANSFORM(lnEv)
    FOR lnJ = 1 TO lnEv
        lcBind = lcBind + "  [" + ALLTRIM(laEv[lnJ, 3]) + " -> " + ;
                 ALLTRIM(laEv[lnJ, 4]) + "]"
    ENDFOR
CATCH TO loErro
    lcBind = "EXCECAO [" + loErro.Message + "]"
ENDTRY
STRTOFILE("AEVENTS botao: " + lcBind + ;
          "  Cancel=" + TRANSFORM(loForm.cmd_4c_Fwbtng1.Cancel) + ;
          "  Caption=[" + loForm.cmd_4c_Fwbtng1.Caption + "]" + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- Saldo que o BO calculou / herdou, ANTES do clique
STRTOFILE("ANTES Visible=" + TRANSFORM(loForm.Visible) + ;
          " this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
          " BO.this_nSaldo=" + TRANSFORM(loForm.this_oBusinessObject.this_nSaldo) + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- Semeia um valor DIFERENTE no BO para provar que o clique copia do BO
loForm.this_oBusinessObject.this_nSaldo = 42.75
STRTOFILE("PASSO=BtnEncerrarClick (chamando, BO.saldo=42,75)" + ;
          CHR(13) + CHR(10), lcSaida, 1)
loForm.BtnEncerrarClick()
STRTOFILE("PASSO=BtnEncerrarClick RETORNOU" + CHR(13) + CHR(10), lcSaida, 1)

*-- Checkpoint ANTES da leitura: com Release() quem morre eh a LEITURA
STRTOFILE("PASSO=lendo loForm DEPOIS do clique" + CHR(13) + CHR(10), lcSaida, 1)
STRTOFILE("POS VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcSaida, 1)
STRTOFILE("POS Visible=" + TRANSFORM(loForm.Visible) + ;
          " this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- O chamador eh quem libera (contrato documentado no cabecalho do form)
loForm.Release()
loForm = .NULL.
STRTOFILE("POS_RELEASE VARTYPE(loForm)=" + VARTYPE(loForm) + ;
          "  cursor_4c_Dados USED=" + IIF(USED("cursor_4c_Dados"), "SIM", "NAO") + ;
          CHR(13) + CHR(10), lcSaida, 1)

STRTOFILE("FIM" + CHR(13) + CHR(10), lcSaida, 1)
QUIT

PROCEDURE RegistrarErroProbe(par_nErro, par_cMsg, par_nLinha, par_cProg)
    STRTOFILE("ON_ERROR erro=" + TRANSFORM(par_nErro) + " msg=[" + par_cMsg + "]" + ;
              " linha=" + TRANSFORM(par_nLinha) + " prog=[" + par_cProg + "]" + ;
              CHR(13) + CHR(10), "C:\4c\automation\tmp795\probeF7e_795_r1.txt", 1)
ENDPROC