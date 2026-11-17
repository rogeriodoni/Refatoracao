*-- Probe da FASE 7 de FormSIGOPRES: prova o EVENTO do botao.
*-- Mede o que distingue Release() de Hide(): depois de BtnEncerrarClick(),
*-- a referencia do chamador tem de continuar viva e this_nSaldo legivel.
*-- Cada passo eh gravado ANTES da medicao seguinte: STRTOFILE grava e fecha
*-- na hora, entao o arquivo sobrevive a um Program Error que pendure o VFP.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcSaida
lcSaida = "C:\4c\automation\tmp795\probeF7_795_r1.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_UsuarioLogado
gnConnHandle        = 0
gb_4c_ModoTeste     = .T.
gb_4c_ValidandoUI   = .T.
gc_4c_UsuarioLogado = "TESTE"

STRTOFILE("PASSO=config.prg" + CHR(13) + CHR(10), lcSaida)
DO ("C:\4c\projeto\app\start\config.prg")

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

STRTOFILE("PASSO=createobject(77,5)" + CHR(13) + CHR(10), lcSaida, 1)

LOCAL loForm, loErro
loForm = .NULL.

TRY
    loForm = CREATEOBJECT("FormSIGOPRES", 77.5, "cab_teste", "item_teste")
CATCH TO loErro
    STRTOFILE("EXCECAO=" + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
              " PROC=" + loErro.Procedure + CHR(13) + CHR(10), lcSaida, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT=FALHOU" + CHR(13) + CHR(10), lcSaida, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT=OK" + CHR(13) + CHR(10), lcSaida, 1)

*-- Escopo dos metodos: BtnEncerrarClick eh alvo de BINDEVENT -> PUBLIC (0);
*-- FecharDialogo tambem PUBLIC. PEMSTATUS(...,2) = .T. seria PROTECTED.
STRTOFILE("PROT_BtnEncerrarClick=" + ;
          IIF(PEMSTATUS(loForm, "BtnEncerrarClick", 2), "SIM", "NAO") + ;
          "  PROT_FecharDialogo=" + ;
          IIF(PEMSTATUS(loForm, "FecharDialogo", 2), "SIM", "NAO") + ;
          CHR(13) + CHR(10), lcSaida, 1)

STRTOFILE("ANTES Visible=" + TRANSFORM(loForm.Visible) + ;
          " this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- Checkpoint ANTES da chamada e ANTES da leitura seguinte: com Release()
*-- quem morre eh a LEITURA, nao a chamada.
STRTOFILE("PASSO=BtnEncerrarClick (chamando)" + CHR(13) + CHR(10), lcSaida, 1)
loForm.BtnEncerrarClick()
STRTOFILE("PASSO=BtnEncerrarClick RETORNOU" + CHR(13) + CHR(10), lcSaida, 1)

STRTOFILE("PASSO=lendo loForm DEPOIS do clique" + CHR(13) + CHR(10), lcSaida, 1)
STRTOFILE("POS VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcSaida, 1)
STRTOFILE("POS Visible=" + TRANSFORM(loForm.Visible) + ;
          " this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
          CHR(13) + CHR(10), lcSaida, 1)

*-- O chamador eh quem libera (contrato documentado no cabecalho do form)
loForm.Release()
loForm = .NULL.
STRTOFILE("POS_RELEASE VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcSaida, 1)

STRTOFILE("FIM" + CHR(13) + CHR(10), lcSaida, 1)
QUIT
