*==============================================================================
* ProbeF8SigOpCtf716.prg - Probe da FASE 8 de FormSigOpCtf (task716)
*
* A Fase 8 entrega os dois hooks de transferencia (FormParaBO / BOParaForm) e
* o montador de buffer do protocolo no BO (MontarBufferSiTef), que substituiu
* as QUATRO copias inline da expressao de padding. Este probe prova isso nos
* objetos REAIS, nao por leitura do fonte.
*
* POR QUE UMA SUBCLASSE: FormBase declara FormParaBO/BOParaForm como PROTECTED
* e o VFP9 nao deixa a subclasse ALARGAR escopo herdado, entao chamar
* loForm.FormParaBO() de um script solto estoura "Property FORMPARABO is not
* found" - e num VFP headless esse Program Error PENDURA o processo sem log e
* sem exit. Subclasse ALCANCA membro protegido; script solto nao. Ver regra
* #51 e a memoria "formbase_hooks_protected_nao_alargam".
*
* ARMADILHAS respeitadas (precedente ProbeF8SigOpCtd715.prg):
*   - apagar o .fxp antes de rodar (o VFP reaproveita compilado antigo);
*   - cada chamada em TRY/CATCH PROPRIO, senao nao se distingue "nao rodou"
*     de "rodou e falhou";
*   - marcador de versao na saida, para nao ler resultado velho como novo;
*   - o buffer tem CHR(0) - logar LEN e o prefixo ALLTRIM, nunca o cru.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC pcCk
pcCk = "C:\4c\automation\probe_f8_sigopctf.txt"
STRTOFILE("CK1 inicio (probe v1 - subclasse)" + CHR(13) + CHR(10), pcCk)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f8_sigopctf_erros.txt"
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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCtfBO.prg")              ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCtf.prg") ADDITIVE
STRTOFILE("CK3 dependencias OK" + CHR(13) + CHR(10), pcCk, 1)

LOCAL loForm, loErro, llOk, lcBuf

STRTOFILE("CK4 antes do CREATEOBJECT" + CHR(13) + CHR(10), pcCk, 1)
loForm = .NULL.
TRY
    *-- Init(EndSiTef, IdTerminal, ValorPago, TipoPgto, DataTrans, Nsu,
    *--      Cartao, Impressora, CodEstabs)
    loForm = CREATEOBJECT("ProbeSigOpCtf", "127.0.0.1", "001", 150.75, ;
        "C", DATE(), "123456", "N", .F., "01")
CATCH TO loErro
    STRTOFILE("CK4x EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
        " PROC=" + loErro.Procedure + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK5 instancia=" + VARTYPE(loForm) + CHR(13) + CHR(10), pcCk, 1)

IF VARTYPE(loForm) != "O"
    STRTOFILE("CK5x FALHOU - form nao instanciou" + CHR(13) + CHR(10), pcCk, 1)
    QUIT
ENDIF

*-- CK6 - FormParaBO leva os QUATRO campos digitaveis para o BO
TRY
    loForm.txt_4c_SENHA.Value   = "1234"
    loForm.txt_4c_Digitos.Value = "9876"
    loForm.txt_4c_Cartao.Value  = "4111111111111111"
    loForm.txt_4c_Codigo.Value  = "321"
    llOk = loForm.ProbeFormParaBO()
    WITH loForm.this_oBusinessObject
        STRTOFILE("CK6 FormParaBO ret=" + TRANSFORM(llOk) + ;
            " senha=[" + .this_cSenhaSupervisor + "]" + ;
            " digitos=[" + .this_cUltimosDigitos + "]" + ;
            " cartao=[" + .this_cNumeroCartao + "]" + ;
            " codseg=[" + .this_cCodSeguranca + "]" + ;
            "  (esperado .T. / 1234 / 9876 / 4111111111111111 / 321)" + ;
            CHR(13) + CHR(10), pcCk, 1)
    ENDWITH
CATCH TO loErro
    STRTOFILE("CK6x EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
        CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK7 - GUARDA: campo em BRANCO nao apaga a property ja aceita pelo passo
*-- anterior do protocolo
TRY
    loForm.txt_4c_SENHA.Value   = ""
    loForm.txt_4c_Digitos.Value = ""
    loForm.txt_4c_Cartao.Value  = ""
    loForm.txt_4c_Codigo.Value  = ""
    llOk = loForm.ProbeFormParaBO()
    WITH loForm.this_oBusinessObject
        STRTOFILE("CK7 campos vazios ret=" + TRANSFORM(llOk) + ;
            " senha=[" + .this_cSenhaSupervisor + "]" + ;
            " digitos=[" + .this_cUltimosDigitos + "]" + ;
            " cartao=[" + .this_cNumeroCartao + "]" + ;
            " codseg=[" + .this_cCodSeguranca + "]" + ;
            "  (esperado PRESERVADOS: 1234 / 9876 / 4111111111111111 / 321)" + ;
            CHR(13) + CHR(10), pcCk, 1)
    ENDWITH
CATCH TO loErro
    STRTOFILE("CK7x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK8 - BOParaForm: caminho inverso devolve os quatro campos a tela e
*-- reproduz as duas atribuicoes do Init legado (Valor e Caption do Label5)
TRY
    llOk = loForm.ProbeBOParaForm()
    STRTOFILE("CK8 BOParaForm ret=" + TRANSFORM(llOk) + ;
        " senha=[" + loForm.txt_4c_SENHA.Value + "]" + ;
        " digitos=[" + loForm.txt_4c_Digitos.Value + "]" + ;
        " cartao=[" + loForm.txt_4c_Cartao.Value + "]" + ;
        " codseg=[" + loForm.txt_4c_Codigo.Value + "]" + ;
        " valor=" + TRANSFORM(loForm.txt_4c_Valor.Value) + ;
        "  (esperado .T. / 1234 / 9876 / 4111111111111111 / 321 / 150.75)" + ;
        CHR(13) + CHR(10), pcCk, 1)
CATCH TO loErro
    STRTOFILE("CK8x EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
        CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK9 - BOParaForm com pcCartao = "S" troca o rotulo, como o Init legado
TRY
    STRTOFILE("CK9a Label5 antes=[" + loForm.lbl_4c_Label5.Caption + "]" + ;
        CHR(13) + CHR(10), pcCk, 1)
    loForm.this_cCartao = "S"
    llOk = loForm.ProbeBOParaForm()
    STRTOFILE("CK9b cartao=S -> Label5=[" + loForm.lbl_4c_Label5.Caption + "]" + ;
        "  (esperado 'Digite a Validade')" + CHR(13) + CHR(10), pcCk, 1)
    loForm.this_cCartao = "N"
CATCH TO loErro
    STRTOFILE("CK9x EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK10 - MontarBufferSiTef: forma generica (2000 - LEN) e a LITERAL do
*-- GetDigitos (complemento 1996). Buffer tem CHR(0) - logar LEN e prefixo.
TRY
    WITH loForm.this_oBusinessObject
        lcBuf = .MontarBufferSiTef("1234")
        STRTOFILE("CK10a generico('1234') LEN=" + TRANSFORM(LEN(lcBuf)) + ;
            " prefixo=[" + LEFT(lcBuf, 4) + "]" + ;
            " this_cBuffer LEN=" + TRANSFORM(LEN(.this_cBuffer)) + ;
            "  (esperado 2000 / 1234 / 2000)" + CHR(13) + CHR(10), pcCk, 1)

        lcBuf = .MontarBufferSiTef("9876", 1996)
        STRTOFILE("CK10b literal('9876',1996) LEN=" + TRANSFORM(LEN(lcBuf)) + ;
            " prefixo=[" + LEFT(lcBuf, 4) + "]" + ;
            "  (esperado 2000 / 9876)" + CHR(13) + CHR(10), pcCk, 1)

        *-- as duas formas coincidem com 4 caracteres: eh por isso que
        *-- transcrever o 1996 do legado nao muda o caminho normal
        STRTOFILE("CK10c coincidem p/ 4 chars = " + ;
            TRANSFORM(.MontarBufferSiTef("9876", 1996) == .MontarBufferSiTef("9876")) + ;
            "  (esperado .T.)" + CHR(13) + CHR(10), pcCk, 1)

        *-- valor mais longo que o complemento literal: a forma generica
        *-- encurta o padding, a literal mantem 1996 (fidelidade ao legado)
        lcBuf = .MontarBufferSiTef("123456")
        STRTOFILE("CK10d generico('123456') LEN=" + TRANSFORM(LEN(lcBuf)) + ;
            "  (esperado 2000)" + CHR(13) + CHR(10), pcCk, 1)

        *-- nao estoura com vazio nem com tipo inesperado
        lcBuf = .MontarBufferSiTef("")
        STRTOFILE("CK10e vazio LEN=" + TRANSFORM(LEN(lcBuf)) + ;
            "  (esperado 2000)" + CHR(13) + CHR(10), pcCk, 1)
        lcBuf = .MontarBufferSiTef(0)
        STRTOFILE("CK10f numerico LEN=" + TRANSFORM(LEN(lcBuf)) + ;
            " prefixo=[" + LEFT(lcBuf, 1) + "]" + ;
            "  (esperado 2000 / 0)" + CHR(13) + CHR(10), pcCk, 1)
    ENDWITH
CATCH TO loErro
    STRTOFILE("CK10x EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
        CHR(13) + CHR(10), pcCk, 1)
ENDTRY

*-- CK11 - os dois hooks sao PROTECTED de verdade (atributo 2 = Protected). O
*-- atributo 5 responde "existe?", nao "da para chamar daqui?", e devolveria
*-- .T. de qualquer jeito - nao serve de prova (regras #3/#51).
STRTOFILE("CK11 FormParaBO protegido=" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 2)) + ;
    " BOParaForm protegido=" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 2)) + ;
    "  (esperado .T. / .T. - herdado de FormBase)" + CHR(13) + CHR(10), pcCk, 1)

*-- CK12 - o handler do unico botao do legado continua PUBLIC (eh chamado de
*-- fora, pelo BINDEVENT do CommandGroup SAIDA)
STRTOFILE("CK12 BtnCancelaClick protegido=" + TRANSFORM(PEMSTATUS(loForm, "BtnCancelaClick", 2)) + ;
    "  (esperado .F.)" + CHR(13) + CHR(10), pcCk, 1)

*-- CK13 - MontarBufferSiTef existe no BO e eh PUBLIC (o form o chama de fora)
STRTOFILE("CK13 MontarBufferSiTef existe=" + ;
    TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject, "MontarBufferSiTef", 5)) + ;
    " protegido=" + TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject, "MontarBufferSiTef", 2)) + ;
    "  (esperado .T. / .F.)" + CHR(13) + CHR(10), pcCk, 1)

STRTOFILE("CK14 form vivo: VARTYPE(loForm)=" + VARTYPE(loForm) + ;
    " VARTYPE(BO)=" + VARTYPE(loForm.this_oBusinessObject) + CHR(13) + CHR(10), pcCk, 1)

loForm.Release()
loForm = .NULL.
STRTOFILE("CK15 FIM" + CHR(13) + CHR(10), pcCk, 1)
QUIT

*==============================================================================
* ProbeSigOpCtf - subclasse SO do harness. Existe porque FormParaBO/BOParaForm
* sao PROTECTED (herdado de FormBase) e script solto nao alcanca membro
* protegido; subclasse alcanca. NAO vai para o projeto.
*==============================================================================
DEFINE CLASS ProbeSigOpCtf AS FormSigOpCtf

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
