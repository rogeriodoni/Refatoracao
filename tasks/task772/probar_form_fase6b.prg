*==============================================================================
* probar_form_fase6b.prg - Fase 6, parte 2: prova o lado POSITIVO dos handlers
* (ENTER/TAB com o campo preenchido DISPARA a consulta) SEM tocar no SQL
* Server.
*
* Por que o stub: a primeira versao deste probe chamou a consulta de verdade e
* o vfp9.exe FICOU BLOQUEADO (192.168.200.10 eh inalcancavel nesta maquina -
* ver feedback_sqlserver_200_10_inalcancavel_maquina_pipeline); o processo teve
* de ser morto e os passos 4 e 5 nao produziram saida. Trocando o Business
* Object por um stub que so REGISTRA a chamada, o gatilho fica provado sem
* depender de rede. O stub nao precisa enxergar cursor (devolve .F. =
* "nao localizado"), entao a limitacao de datasession privada
* (feedback_probe_stub_bo_nao_ve_cursor_datasession2) nao se aplica.
*
* ON ERROR + marcador gravado a CADA passo: sem isso um erro de runtime abre
* dialogo modal, o processo pendura com janela escondida e a saida nao diz
* ONDE parou (foi o que aconteceu na 1a tentativa).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loCnt, loStub
PUBLIC gc_ArqProbe6b
gc_ArqProbe6b = "C:\4c\tasks\task772\probar_form_fase6b_resultado.txt"
lcArqSaida    = gc_ArqProbe6b
lcSaida       = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase6b_erros.txt"

SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")

*-- O config.prg pode ter redefinido SET PROCEDURE - reanexa o stub depois.
SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

ON ERROR DO TratarErroProbe6b WITH ERROR(), MESSAGE(), PROGRAM(), LINENO()

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
    lcSaida = lcSaida + "CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO: " + loErro.Message + ;
              " | Linha: " + TRANSFORM(loErro.LineNo) + ;
              " | Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcSaida, lcArqSaida)

IF VARTYPE(loForm) = "O"
    loCnt  = loForm.cnt_4c_Container1

    loStub = .NULL.
    TRY
        loStub = CREATEOBJECT("StubBOSigOpNop")
    CATCH TO loErro
        lcSaida = lcSaida + "FALHA ao criar stub: " + loErro.Message + CHR(13) + CHR(10)
    ENDTRY
    STRTOFILE(lcSaida, lcArqSaida)

    IF VARTYPE(loStub) = "O"
        loForm.this_oBusinessObject = loStub
        lcSaida = lcSaida + "P1 BO trocado por stub" + CHR(13) + CHR(10)
        STRTOFILE(lcSaida, lcArqSaida)

        *-- ===== ENTER com O.P. preenchida DISPARA a consulta =====
        loCnt.txt_4c_OP.Value       = 4242
        loCnt.txt_4c_Envelope.Value = 0
        loForm.ValidarOP(13, 0)
        lcSaida = lcSaida + "ENTER com OP=4242 -> chamadasOP=" + TRANSFORM(loStub.nChamadasOP) + ;
                  " valorOP=" + TRANSFORM(loStub.nUltimoOP) + ;
                  " chamadasEnv=" + TRANSFORM(loStub.nChamadasEnv) + ;
                  " (esperado 1/4242/0 = CONSULTOU por O.P.)" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "  this_lEmConsulta=" + TRANSFORM(loForm.this_lEmConsulta) + ;
                  " (esperado .F. - liberada depois do ENDTRY)" + CHR(13) + CHR(10)
        STRTOFILE(lcSaida, lcArqSaida)

        *-- ===== TAB com Envelope preenchido DISPARA a consulta =====
        loCnt.txt_4c_OP.Value       = 0
        loCnt.txt_4c_Envelope.Value = 3131
        loForm.ValidarEnvelope(9, 0)
        lcSaida = lcSaida + "TAB com Envelope=3131 -> chamadasEnv=" + TRANSFORM(loStub.nChamadasEnv) + ;
                  " valorEnv=" + TRANSFORM(loStub.nUltimoEnv) + ;
                  " chamadasOP=" + TRANSFORM(loStub.nChamadasOP) + ;
                  " (esperado 1/3131/1 = CONSULTOU por Envelope, O.P. intocada)" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "  this_lEmConsulta=" + TRANSFORM(loForm.this_lEmConsulta) + ;
                  " (esperado .F.)" + CHR(13) + CHR(10)
        STRTOFILE(lcSaida, lcArqSaida)

        *-- ===== Guarda de reentrancia BLOQUEIA =====
        loForm.this_lEmConsulta = .T.
        loCnt.txt_4c_OP.Value   = 5555
        loForm.ValidarOP(13, 0)
        lcSaida = lcSaida + "ENTER com this_lEmConsulta=.T. -> chamadasOP=" + TRANSFORM(loStub.nChamadasOP) + ;
                  " (esperado 1 = guarda bloqueou, sem nova chamada)" + CHR(13) + CHR(10)
        loForm.this_lEmConsulta = .F.

        *-- ===== Tecla que nao sai do campo NAO dispara =====
        loCnt.txt_4c_OP.Value = 6666
        loForm.ValidarOP(65, 0)
        lcSaida = lcSaida + "tecla 65 (A) com OP=6666 -> chamadasOP=" + TRANSFORM(loStub.nChamadasOP) + ;
                  " (esperado 1 = NAO consultou)" + CHR(13) + CHR(10)

        lcSaida = lcSaida + "RESULTADO=OK" + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "RESULTADO=STUB INDISPONIVEL" + CHR(13) + CHR(10)
    ENDIF
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


*==============================================================================
* TratarErroProbe6b - ON ERROR do probe: grava o erro no proprio arquivo de
* saida (modo APPEND) e segue, para nenhum erro de runtime abrir dialogo modal
* e pendurar o processo com a janela escondida.
*==============================================================================
PROCEDURE TratarErroProbe6b(par_nErro, par_cMensagem, par_cPrograma, par_nLinha)
    STRTOFILE("ON ERROR: " + TRANSFORM(par_nErro) + " - " + par_cMensagem + ;
              " | PROG=" + par_cPrograma + " | LINHA=" + TRANSFORM(par_nLinha) + ;
              CHR(13) + CHR(10), gc_ArqProbe6b, 1)
ENDPROC
