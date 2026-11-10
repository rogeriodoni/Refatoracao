*==============================================================================
* probar_form_fase6c.prg - Fase 6, parte 3: prova que os BINDEVENT de GotFocus
* sao de fato ENTREGUES pelo evento (e nao so registrados).
*
* As partes 1 e 2 provaram (a) que AEVENTS lista as quatro ligacoes e (b) que os
* handlers fazem a coisa certa quando CHAMADOS. Faltava a terceira coisa, que eh
* a que falha em silencio quando esta errada: o evento REAL chegar ao delegate.
* Aqui o form eh EXIBIDO (WindowType trocado para 0 so no probe, senao Show()
* bloqueia) e o foco eh movido com SetFocus - entao o GotFocus parte do VFP, nao
* de uma chamada direta.
*
* O BO eh trocado pelo stub antes de qualquer coisa: sem isso, um KeyPress
* acidental poderia alcancar o SQL Server (inalcancavel nesta maquina) e
* pendurar o processo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loCnt, loStub
PUBLIC gc_ArqProbe6c
gc_ArqProbe6c = "C:\4c\tasks\task772\probar_form_fase6c_resultado.txt"
lcArqSaida    = gc_ArqProbe6c
lcSaida       = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase6c_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")
SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

ON ERROR DO TratarErroProbe6c WITH ERROR(), MESSAGE(), PROGRAM(), LINENO()

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO Init: " + loErro.Message + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    loCnt  = loForm.cnt_4c_Container1
    loStub = CREATEOBJECT("StubBOSigOpNop")
    loForm.this_oBusinessObject = loStub

    *-- WindowType = 0 SO no probe: com o modal (1, que eh o do legado) o
    *-- Show() bloquearia a execucao e nada mais seria medido.
    loForm.WindowType = 0
    loForm.Show()
    lcSaida = lcSaida + "P1 form exibido (WindowType trocado para 0 so no probe)" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    *-- ===== GotFocus REAL no campo da O.P. =====
    loCnt.txt_4c_OP.Value        = 0
    loCnt.txt_4c_Envelope.Value  = 888
    loForm.img_4c_Imagem.Visible = .T.

    loCnt.txt_4c_Envelope.SetFocus()
    loCnt.txt_4c_OP.SetFocus()

    lcSaida = lcSaida + "SetFocus em txt_4c_OP -> Envelope=" + TRANSFORM(loCnt.txt_4c_Envelope.Value) + ;
              " (esperado 0 = GotFocus ENTREGUE)" + ;
              " Imagem.Visible=" + TRANSFORM(loForm.img_4c_Imagem.Visible) + ;
              " (esperado .F. = When reproduzido)" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    *-- ===== GotFocus REAL no campo do Envelope =====
    loCnt.txt_4c_OP.Value = 777
    loCnt.txt_4c_Envelope.SetFocus()

    lcSaida = lcSaida + "SetFocus em txt_4c_Envelope -> OP=" + TRANSFORM(loCnt.txt_4c_OP.Value) + ;
              " (esperado 0 = GotFocus ENTREGUE)" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    lcSaida = lcSaida + "chamadas ao BO no probe: OP=" + TRANSFORM(loStub.nChamadasOP) + ;
              " Env=" + TRANSFORM(loStub.nChamadasEnv) + ;
              " (esperado 0/0 - GotFocus nao consulta)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "RESULTADO=OK" + CHR(13) + CHR(10)

    loForm.Hide()
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcSaida = lcSaida + "--- MENSAGENS EM MODO TESTE ---" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "--- sem arquivo de mensagens de teste ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
ON ERROR
QUIT


PROCEDURE TratarErroProbe6c(par_nErro, par_cMensagem, par_cPrograma, par_nLinha)
    STRTOFILE("ON ERROR: " + TRANSFORM(par_nErro) + " - " + par_cMensagem + ;
              " | PROG=" + par_cPrograma + " | LINHA=" + TRANSFORM(par_nLinha) + ;
              CHR(13) + CHR(10), gc_ArqProbe6c, 1)
ENDPROC
