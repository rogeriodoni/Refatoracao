*==============================================================================
* probar_form_fase6d.prg - Fase 6, parte 4: tenta provar que o BINDEVENT de
* KeyPress tambem eh ENTREGUE pelo evento real, e nao so registrado.
*
* A parte 3 provou a entrega do GotFocus com SetFocus. KeyPress nao tem
* equivalente direto em script: so chega por teclado. Aqui o form eh exibido
* (WindowType 0 so no probe) e a tecla eh injetada com KEYBOARD + INKEY, que eh
* o MESMO par que o Init do legado usa ("Keyboard Chr(32)" + "=Inkey(0)").
*
* Se o teclado simulado nao for roteado para o controle focado em execucao
* headless, o resultado sai "chamadasOP=0" - e isso NAO prova defeito: prova
* apenas que a injecao de tecla nao serve de prova aqui (o mesmo que a nota de
* KEYBOARD x Format="M" ja registra para outro caso). Por isso o BO eh o stub:
* em nenhum cenario este probe alcanca o SQL Server.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loCnt, loStub
PUBLIC gc_ArqProbe6d
gc_ArqProbe6d = "C:\4c\tasks\task772\probar_form_fase6d_resultado.txt"
lcArqSaida    = gc_ArqProbe6d
lcSaida       = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase6d_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")
SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

ON ERROR DO TratarErroProbe6d WITH ERROR(), MESSAGE(), PROGRAM(), LINENO()

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

    loForm.WindowType = 0
    loForm.Show()
    lcSaida = lcSaida + "P1 form exibido" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    loCnt.txt_4c_OP.SetFocus()
    loCnt.txt_4c_OP.Value = 4242

    KEYBOARD CHR(13) PLAIN
    = INKEY(1)

    lcSaida = lcSaida + "KEYBOARD CHR(13) no campo O.P. -> chamadasOP=" + ;
              TRANSFORM(loStub.nChamadasOP) + " valorOP=" + TRANSFORM(loStub.nUltimoOP) + ;
              " (1/4242 = KeyPress ENTREGUE; 0 = injecao de tecla nao serve de prova headless)" + ;
              CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    lcSaida = lcSaida + "RESULTADO=OK" + CHR(13) + CHR(10)
    loForm.Hide()
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
ON ERROR
QUIT


PROCEDURE TratarErroProbe6d(par_nErro, par_cMensagem, par_cPrograma, par_nLinha)
    STRTOFILE("ON ERROR: " + TRANSFORM(par_nErro) + " - " + par_cMensagem + ;
              " | PROG=" + par_cPrograma + " | LINHA=" + TRANSFORM(par_nLinha) + ;
              CHR(13) + CHR(10), gc_ArqProbe6d, 1)
ENDPROC
