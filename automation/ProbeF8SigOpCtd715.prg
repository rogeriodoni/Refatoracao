*==============================================================================
* ProbeF8SigOpCtd715.prg - Probe da FASE 8 de FormSigOpCtd (task715)
*
* A Fase 8 entrega os dois hooks de transferencia (FormParaBO / BOParaForm) e
* faz BtnProcurarClick ABORTAR quando FormParaBO falha. Este probe prova isso
* nos objetos REAIS, nao por leitura do fonte.
*
* POR QUE UMA SUBCLASSE: FormBase declara FormParaBO/BOParaForm como PROTECTED
* e o VFP9 nao deixa a subclasse ALARGAR escopo herdado, entao chamar
* loForm.BOParaForm() de um script solto estoura "Property BOPARAFORM is not
* found" - e num VFP headless esse Program Error PENDURA o processo (medido em
* 2026-10-31: a 1a versao deste probe travou exatamente nessa linha, sem log e
* sem exit). Subclasse ALCANCA membro protegido; script solto nao. Ver regra
* #51 e a memoria "formbase_hooks_protected_nao_alargam".
*
* ARMADILHAS respeitadas (precedente ProbeF6SigOpCrp714.prg):
*   - apagar o .fxp antes de rodar (o VFP reaproveita compilado antigo);
*   - nada de ON ERROR que so loga - cada chamada vai em TRY/CATCH PROPRIO,
*     senao nao se distingue "nao rodou" de "rodou e falhou";
*   - marcador de versao na saida, para nao ler resultado velho como novo;
*   - acionar Buttons(N).Click(), o caminho REAL do usuario, nao o handler.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC pcCk
pcCk = "C:\4c\automation\probe_f8_sigopctd.txt"
STRTOFILE("CK1 inicio (probe v2 - subclasse)" + CHR(13) + CHR(10), pcCk)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f8_sigopctd_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"

DO config.prg
STRTOFILE("CK2 config.prg OK" + CHR(13) + CHR(10), pcCk, 1)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")              ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")                ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")                ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")                ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")               ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")                ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")              ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCtdBO.prg")              ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCtd.prg") ADDITIVE
STRTOFILE("CK3 dependencias OK" + CHR(13) + CHR(10), pcCk, 1)

LOCAL loForm, loErro, lnI, llOk

STRTOFILE("CK4 antes do CREATEOBJECT" + CHR(13) + CHR(10), pcCk, 1)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("ProbeSigOpCtd", "Procura de Contas", .NULL., "MARIA", 50)
CATCH TO loErro
    STRTOFILE("CK4x EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
        " PROC=" + loErro.Procedure + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK5 instancia=" + VARTYPE(loForm) + CHR(13) + CHR(10), pcCk, 1)

IF VARTYPE(loForm) != "O"
    STRTOFILE("CK5x FALHOU - form nao instanciou" + CHR(13) + CHR(10), pcCk, 1)
    QUIT
ENDIF

*-- CK6 - BOParaForm ja rodou no InicializarForm: a tela abriu no default do BO
STRTOFILE("CK6 abertura: OptionGroup.Value=" + TRANSFORM(loForm.obj_4c_Optiongroup1.Value) + ;
    " BO.this_nOpcaoSelecionada=" + TRANSFORM(loForm.this_oBusinessObject.this_nOpcaoSelecionada) + ;
    "  (esperado 1 / 1)" + CHR(13) + CHR(10), pcCk, 1)

*-- CK7 - BOParaForm honra default DIFERENTE: prova que a fonte eh o BO, e nao
*-- o .Value hardcoded de ConfigurarControlesOpcao
TRY
    loForm.this_oBusinessObject.this_nOpcaoSelecionada = 3
    loForm.obj_4c_Optiongroup1.Value = 1
    llOk = loForm.ProbeBOParaForm()
    STRTOFILE("CK7 BO=3 (tela em 1) -> ret=" + TRANSFORM(llOk) + ;
        " OptionGroup.Value=" + TRANSFORM(loForm.obj_4c_Optiongroup1.Value) + ;
        "  (esperado .T. / 3)" + CHR(13) + CHR(10), pcCk, 1)
CATCH TO loErro
    STRTOFILE("CK7x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK8 - fora de faixa nunca DESMARCA o grupo (0 apagaria os 4 radios)
TRY
    loForm.this_oBusinessObject.this_nOpcaoSelecionada = 0
    llOk = loForm.ProbeBOParaForm()
    STRTOFILE("CK8a BO=0 -> OptionGroup.Value=" + TRANSFORM(loForm.obj_4c_Optiongroup1.Value) + ;
        "  (esperado 1, NUNCA 0)" + CHR(13) + CHR(10), pcCk, 1)
    loForm.this_oBusinessObject.this_nOpcaoSelecionada = 9
    llOk = loForm.ProbeBOParaForm()
    STRTOFILE("CK8b BO=9 -> OptionGroup.Value=" + TRANSFORM(loForm.obj_4c_Optiongroup1.Value) + ;
        "  (esperado 1)" + CHR(13) + CHR(10), pcCk, 1)
CATCH TO loErro
    STRTOFILE("CK8x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK9 - FormParaBO leva o modo CRU da tela para o BO (sem +1/-1)
FOR lnI = 1 TO 4
    TRY
        loForm.obj_4c_Optiongroup1.Value = lnI
        loForm.this_oBusinessObject.this_nOpcaoSelecionada = 0
        llOk = loForm.ProbeFormParaBO()
        STRTOFILE("CK9 tela=" + TRANSFORM(lnI) + " -> ret=" + TRANSFORM(llOk) + ;
            " BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nOpcaoSelecionada) + ;
            "  (esperado .T. / " + TRANSFORM(lnI) + ")" + CHR(13) + CHR(10), pcCk, 1)
    CATCH TO loErro
        STRTOFILE("CK9x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
    ENDTRY
ENDFOR

*-- CK10 - contrato 0..4 pelo Click REAL do botao (caminho do usuario), que
*-- agora passa por FormParaBO
FOR lnI = 1 TO 4
    TRY
        loForm.obj_4c_Optiongroup1.Value = lnI
        loForm.obj_4c_Commandgroup1.Buttons(1).Click()
        WITH loForm.this_oBusinessObject
            STRTOFILE("CK10 Procurar opt=" + TRANSFORM(lnI) + ;
                " -> ret=" + TRANSFORM(.this_nRetorno) + ;
                " oper=[" + .this_cOperador + "]" + ;
                " termo=[" + .this_cTermoBusca + "]" + ;
                " len=" + TRANSFORM(LEN(.this_cTermoBusca)) + ;
                " confirmou=" + TRANSFORM(.this_lConfirmou) + CHR(13) + CHR(10), pcCk, 1)
        ENDWITH
    CATCH TO loErro
        STRTOFILE("CK10x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
    ENDTRY
ENDFOR
TRY
    loForm.obj_4c_Commandgroup1.Buttons(2).Click()
    WITH loForm.this_oBusinessObject
        STRTOFILE("CK10 Encerrar -> ret=" + TRANSFORM(.this_nRetorno) + ;
            " oper=[" + .this_cOperador + "] termo=[" + .this_cTermoBusca + "]" + ;
            " confirmou=" + TRANSFORM(.this_lConfirmou) + ;
            "  (esperado 0 / vazio / vazio / .F.)" + CHR(13) + CHR(10), pcCk, 1)
    ENDWITH
CATCH TO loErro
    STRTOFILE("CK10xE EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK11 - os dois hooks sao PROTECTED de verdade (atributo 2 = Protected). O
*-- atributo 5 responde "existe?", nao "da para chamar daqui?", e devolveria
*-- .T. de qualquer jeito - nao serve de prova (regras #3/#51).
STRTOFILE("CK11 FormParaBO protegido=" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 2)) + ;
    " BOParaForm protegido=" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 2)) + ;
    "  (esperado .T. / .T. - herdado de FormBase)" + CHR(13) + CHR(10), pcCk, 1)

*-- CK12 - os dois handlers de botao continuam PUBLIC (eles SAO chamados de
*-- fora, pelo BINDEVENT do CommandGroup)
STRTOFILE("CK12 BtnProcurarClick protegido=" + TRANSFORM(PEMSTATUS(loForm, "BtnProcurarClick", 2)) + ;
    " BtnEncerrarClick protegido=" + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 2)) + ;
    "  (esperado .F. / .F.)" + CHR(13) + CHR(10), pcCk, 1)

*-- CK13 - o form sobreviveu aos dois Click (Hide, nao Release)
STRTOFILE("CK13 form vivo apos os Click: VARTYPE(loForm)=" + VARTYPE(loForm) + ;
    " VARTYPE(BO)=" + VARTYPE(loForm.this_oBusinessObject) + CHR(13) + CHR(10), pcCk, 1)

loForm.Release()
loForm = .NULL.
STRTOFILE("CK14 FIM" + CHR(13) + CHR(10), pcCk, 1)
QUIT

*==============================================================================
* ProbeSigOpCtd - subclasse SO do harness. Existe porque FormParaBO/BOParaForm
* sao PROTECTED (herdado de FormBase) e script solto nao alcanca membro
* protegido; subclasse alcanca. NAO vai para o projeto.
*==============================================================================
DEFINE CLASS ProbeSigOpCtd AS FormSigOpCtd

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
