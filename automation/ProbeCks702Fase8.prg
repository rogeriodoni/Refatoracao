*==============================================================================
* ProbeCks702Fase8.prg - Probe da Fase 8 de Formsigopcks (task702)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo), o contrato de retorno do
* PROCEDURE Unload legado - Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs:
*   1) o form INSTANCIA com os parametros do Init legado
*   2) estado inicial eh FAIL-CLOSED: ObterResultadoSaida devolve " " + Usuar
*      (espaco na posicao 1 = nao autorizado). O usuario vem do
*      "Thisform.usulibs = Usuar" do Init legado
*   3) autorizado (ConcluirAutorizacaoSemSenha, o ramo "usuario sem senha
*      cadastrada") -> "*" + quem liberou
*   4) BO.ObterResultadoSaida grava o MESMO valor em BO.this_cRetorno
*   5) FecharDialogo CACHEIA o resultado em this_cResultadoSaida (eh o que o
*      Unload le depois de o Destroy ter zerado o BO)
*   6) Unload() devolve o cache
*   7) AbortarAutorizacao volta o resultado para " " (fail-closed) e recacheia
*   8) o form continua LEGIVEL depois de FecharDialogo (Hide, nao Release) -
*      que eh a razao de o dialogo nao se destruir sozinho
*   9) ObterResultadoSaida eh PUBLIC nos DOIS lados (o form chama o metodo do
*      BO de fora; o chamador chama o do form de fora - regra #51)
*
* NAO chama Show(): WindowType = 1 (modal) bloquearia o harness headless.
* NAO exercita ValidarUsuario/ValidarSenha com valor: o SQL Server
* 192.168.200.10 nao tem rota desta maquina (gnConnHandle = -1 aqui).
*
* Regra #6: script auxiliar roda unattended - SET SAFETY OFF + SET RESOURCE OFF.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cks702_f8.txt"
#DEFINE OUT "C:\4c\automation\probe_cks702_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cRet, loc_cCache, loc_nFalhas, loc_oE
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - Formsigopcks (task702) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcksBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopcks.prg") ADDITIVE

    gnConnHandle = -1

    *-- (1) instanciacao com os parametros do Init legado
    loc_oForm = CREATEOBJECT("Formsigopcks", "CANCITEM", "Cancelamento de Item", ;
                             "Item ja faturado!")

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("[FALHA 1] CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
        loc_nFalhas = loc_nFalhas + 1
    ELSE
        STRTOFILE("[OK 1] form instanciado: " + loc_oForm.Name + CHR(13) + CHR(10), OUT, 1)
        loc_oBO = loc_oForm.this_oBusinessObject

        *-- (9) escopo: os dois ObterResultadoSaida sao chamados de FORA
        STRTOFILE("[9] BO.ObterResultadoSaida   PROTECTED=" + ;
            IIF(PEMSTATUS(loc_oBO, "ObterResultadoSaida", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("[9] Form.ObterResultadoSaida PROTECTED=" + ;
            IIF(PEMSTATUS(loc_oForm, "ObterResultadoSaida", 2), "SIM", "NAO") + CHR(13) + CHR(10), OUT, 1)
        IF PEMSTATUS(loc_oBO, "ObterResultadoSaida", 2) OR PEMSTATUS(loc_oForm, "ObterResultadoSaida", 2)
            STRTOFILE("[FALHA 9] metodo de contrato PROTECTED - estouraria ao ser chamado de fora" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (2) fail-closed inicial
        loc_cRet = loc_oForm.ObterResultadoSaida()
        STRTOFILE("[2] inicial  = [" + loc_cRet + "]  LEFT1=[" + LEFT(loc_cRet, 1) + "]" + CHR(13) + CHR(10), OUT, 1)
        IF LEFT(loc_cRet, 1) == "*"
            STRTOFILE("[FALHA 2] dialogo recem-aberto ja autoriza" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        IF !(ALLTRIM(SUBSTR(loc_cRet, 2)) == "TESTE")
            STRTOFILE("[FALHA 2b] usulibs nao veio do usuario logado" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (3) ramo "usuario sem senha cadastrada" do usuario.Valid legado
        loc_oBO.this_cUsuLibs = "ADMIN"
        loc_oBO.ConcluirAutorizacaoSemSenha()
        loc_cRet = loc_oForm.ObterResultadoSaida()
        STRTOFILE("[3] autorizado = [" + loc_cRet + "]" + CHR(13) + CHR(10), OUT, 1)
        IF !(loc_cRet == "*ADMIN")
            STRTOFILE("[FALHA 3] esperado [*ADMIN]" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (4) o BO guarda o mesmo valor em this_cRetorno
        STRTOFILE("[4] BO.this_cRetorno = [" + loc_oBO.this_cRetorno + "]" + CHR(13) + CHR(10), OUT, 1)
        IF !(loc_oBO.this_cRetorno == loc_cRet)
            STRTOFILE("[FALHA 4] this_cRetorno divergente" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (5) FecharDialogo cacheia
        loc_oForm.FecharDialogo()
        loc_cCache = loc_oForm.this_cResultadoSaida
        STRTOFILE("[5] cache pos-FecharDialogo = [" + loc_cCache + "]" + CHR(13) + CHR(10), OUT, 1)
        IF !(loc_cCache == "*ADMIN")
            STRTOFILE("[FALHA 5] cache nao preenchido pelo funil de fechamento" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (6) Unload le o cache
        loc_cRet = loc_oForm.Unload()
        STRTOFILE("[6] Unload() = [" + TRANSFORM(loc_cRet) + "]" + CHR(13) + CHR(10), OUT, 1)
        IF !(VARTYPE(loc_cRet) == "C" AND loc_cRet == "*ADMIN")
            STRTOFILE("[FALHA 6] Unload nao devolveu o cache" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (7) negativa volta para fail-closed e recacheia
        loc_oForm.AbortarAutorizacao()
        loc_cRet = loc_oForm.ObterResultadoSaida()
        STRTOFILE("[7] pos-Abortar = [" + loc_cRet + "]  cache=[" + loc_oForm.this_cResultadoSaida + "]" + CHR(13) + CHR(10), OUT, 1)
        IF LEFT(loc_cRet, 1) == "*" OR !(loc_oForm.this_cResultadoSaida == loc_cRet)
            STRTOFILE("[FALHA 7] abortar nao devolveu o estado nao-autorizado" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- (8) o form sobrevive ao fechamento (Hide, nao Release)
        STRTOFILE("[8] VARTYPE(form) pos-fechamento = " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
        IF VARTYPE(loc_oForm) != "O"
            STRTOFILE("[FALHA 8] form destruido - chamador nao conseguiria ler o retorno" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("[EXCECAO] " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "RESULTADO: " + ;
    IIF(loc_nFalhas = 0, "TODAS AS PROVAS PASSARAM", TRANSFORM(loc_nFalhas) + " FALHA(S)") + ;
    CHR(13) + CHR(10), OUT, 1)

QUIT
