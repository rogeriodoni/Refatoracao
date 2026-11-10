*-- Probe da FASE 8 do FormSigOpLib (task760).
*--
*-- Prova, em RUNTIME, os tres metodos que a fase entregou:
*--   FormParaBO()             tela -> BO
*--   BOParaForm()             BO -> tela, com a guarda de Fixos <> 2
*--   BO.FecharRetornoDoTipo() a conta do retorno, agora com fonte unica
*--
*-- Os DOIS primeiros sao PROTECTED por HERANCA (a FormBase os declara assim),
*-- e em VFP9 a subclasse nao alarga escopo - chamar do script estoura
*-- "Property FORMPARABO is not found" mesmo com o metodo visivelmente
*-- declarado no .prg, e PEMSTATUS(...,5) MENTE (responde "existe?", nao "da
*-- para chamar daqui?"). Por isso a instancia eh de uma SUBCLASSE de teste
*-- com wrappers publicos: subclasse alcanca membro protegido, script solto
*-- nao. A subclasse mora SO aqui, nunca em projeto\app\.
*--
*-- O ponto CENTRAL eh o passo 5: com Fixos = 2 (descricao LIVRE) o hook de
*-- volta NAO pode sobrescrever o que o usuario digitou. Era o defeito que um
*-- refactor de desduplicacao introduziria, e nenhum gate o pegaria.
*--
*-- Sem banco nesta maquina (192.168.200.10 inalcancavel): os passos que
*-- precisariam de SELECT sao exercitados alimentando as properties do BO
*-- direto, que eh exatamente o estado em que CarregarDoCursor as deixa.
*--
*-- TRY/CATCH POR CHAMADA: sem ele, um "Property X is not found" em VFP
*-- headless abre um Program Error que ninguem fecha e o processo PENDURA.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut760f8
gcOut760f8 = "C:\4c\automation\probef8sigoplib760.txt"
STRTOFILE("PROBE F8 task760 v1 INICIO" + CHR(13) + CHR(10), gcOut760f8)

*-- SETUP A MAO, sem ConfigurarAmbiente(): nesta maquina aquele metodo NAO
*-- RETORNA (medido - fica pendurado antes de qualquer CREATEOBJECT, e o VFP
*-- para no IDE). A 1a versao deste probe o chamava e gravou SO a linha de
*-- INICIO. DO config.prg sozinho apenas define as globais gc_4c_Caminho* e
*-- retorna - ele NAO carrega classe nem form, por isso o bloco de
*-- SET PROCEDURE abaixo eh obrigatorio (sem ele o CREATEOBJECT estouraria
*-- "Class definition FORMSIGOPLIB is not found" e o probe estaria medindo a
*-- falta de setup, nao o form).
DO ("C:\4c\projeto\app\start\config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpLibBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpLib.prg") ADDITIVE

*-- gnConnHandle: quem conecta eh o main.prg, NAO o config.prg. Sem declarar,
*-- a primeira referencia (ate TRANSFORM para log) estoura "Variable
*-- 'GNCONNHANDLE' is not found" e a mensagem parece defeito de conexao.
*-- Zero eh de proposito - eh o mesmo valor que o TesteAutomatico.prg usa, e
*-- eh o que faz o get_descr.When nao ir ao banco.
PUBLIC gnConnHandle
gnConnHandle = 0

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef8sigoplib760_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log760f8("ambiente OK - gnConnHandle=" + TRANSFORM(gnConnHandle))

LOCAL loForm, loErro, lcRet, lcDigitado

*==============================================================
* 0) Instanciacao - COM parametro (contrato do chamador) e SEM
*    (contrato do harness, que faz CREATEOBJECT sem argumento)
*==============================================================
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("ProbeFormSigOpLib760")
CATCH TO loErro
    Log760f8("0a) CREATEOBJECT sem parametro FALHOU: " + loErro.Message + ;
             " / LN " + TRANSFORM(loErro.LineNo) + " / PROC " + loErro.Procedure)
    loForm = .NULL.
ENDTRY
Log760f8("0a) CREATEOBJECT sem parametro -> VARTYPE=" + VARTYPE(loForm))
IF VARTYPE(loForm) = "O"
    loForm.Release()
ENDIF

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("ProbeFormSigOpLib760", 3, "TIPO01")
CATCH TO loErro
    Log760f8("0b) CREATEOBJECT com 2 parametros FALHOU: " + loErro.Message + ;
             " / LN " + TRANSFORM(loErro.LineNo) + " / PROC " + loErro.Procedure)
    loForm = .NULL.
ENDTRY
Log760f8("0b) CREATEOBJECT(3, TIPO01) -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"

    *==============================================================
    * 1) ESCOPO dos nomes novos. PEMSTATUS(...,5)=existe,
    *    (...,2)=protected.
    *
    *    ESPERADO:
    *      FormParaBO / BOParaForm       protected=SIM (herdado da
    *                                    FormBase; so chamaveis por THIS.
    *                                    ou pela subclasse de teste)
    *      os outros quatro              protected=NAO - sao chamados de
    *                                    FORA (BINDEVENT / funil / form
    *                                    chamador) e metodo protegido em
    *                                    QUALQUER nivel da heranca estoura
    *                                    "Property X is not found"
    *                                    (regra #51)
    *==============================================================
    Escopo760f8(loForm, "FormParaBO")
    Escopo760f8(loForm, "BOParaForm")
    Escopo760f8(loForm, "AplicarTipoSelecionado")
    Escopo760f8(loForm, "AtualizarEstadoDescricao")
    Escopo760f8(loForm, "BtnOkClick")
    Escopo760f8(loForm.this_oBusinessObject, "FecharRetornoDoTipo")

    *==============================================================
    * 2) A semente do Init chegou ao campo, e o hook de ida levou o
    *    estado da tela ao BO (ele roda no fim do InicializarForm)
    *==============================================================
    Log760f8("2) campo codigo=[" + loForm.txt_4c__codigo.Value + "] (esperado TIPO01)")
    WITH loForm.this_oBusinessObject
        Log760f8("   BO.this_nTipoFiltro=" + TRANSFORM(.this_nTipoFiltro) + " (esperado 3)")
        Log760f8("   BO.this_cCods=[" + .this_cCods + "] LEN=" + ;
                 TRANSFORM(LEN(.this_cCods)) + " (esperado LEN 10 - PADR)")
    ENDWITH

    *==============================================================
    * 3) FormParaBO de fora: tela -> BO, codigo PADDED em 10
    *==============================================================
    loForm.txt_4c__codigo.Value = "A9"
    loForm.txt_4c__descr.Value  = "DESCRICAO DIGITADA"
    TRY
        loForm.ProbeFormParaBO()
        WITH loForm.this_oBusinessObject
            Log760f8("3) FormParaBO: BO.this_cCods=[" + .this_cCods + "] LEN=" + ;
                     TRANSFORM(LEN(.this_cCods)) + " (esperado A9 + brancos, LEN 10)")
            Log760f8("   BO.this_cDescs=[" + .this_cDescs + "] (CRU, sem ALLTRIM)")
        ENDWITH
    CATCH TO loErro
        Log760f8("3) FormParaBO FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 4) Fixos <> 2 (descricao DERIVADA): o BO fecha o retorno e o
    *    hook de volta repinta os DOIS campos
    *==============================================================
    TRY
        WITH loForm.this_oBusinessObject
            .this_cCods  = PADR("11101", 10)
            .this_cDescs = PADR("LIBERACAO TOTAL", 60)
            .this_nFixos = 1
        ENDWITH
        loForm.txt_4c__codigo.Value = "sujo"
        loForm.txt_4c__descr.Value  = "sujo"

        loForm.AplicarTipoSelecionado()

        lcRet = loForm.this_oBusinessObject.this_cRetorno
        Log760f8("4) Fixos=1 -> campo codigo=[" + loForm.txt_4c__codigo.Value + "] (esperado 11101)")
        Log760f8("   campo descr=[" + ALLTRIM(loForm.txt_4c__descr.Value) + "] (esperado LIBERACAO TOTAL)")
        Log760f8("   BO.retorno LEN=" + TRANSFORM(LEN(lcRet)) + " (esperado 70 = 10+60 posicional)")
        Log760f8("   retorno 1..10=[" + LEFT(lcRet, 10) + "] retorno 11..=[" + ;
                 ALLTRIM(SUBSTR(lcRet, 11)) + "]")
        Log760f8("   form.this_cRetorno espelhou o BO? " + ;
                 TRANSFORM(loForm.this_cRetorno == lcRet))
    CATCH TO loErro
        Log760f8("4) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 5) O PONTO CENTRAL - Fixos = 2 (descricao LIVRE): o hook de
    *    volta NAO pode apagar o que o usuario digitou, e o retorno
    *    NAO se fecha aqui (quem o fecha eh o Valid da descricao)
    *==============================================================
    TRY
        WITH loForm.this_oBusinessObject
            .this_cCods    = PADR("22202", 10)
            .this_cDescs   = PADR("TEXTO DA TABELA", 60)
            .this_nFixos   = 2
            .this_cRetorno = "RETORNO-ANTERIOR"
        ENDWITH

        lcDigitado = "TEXTO QUE O USUARIO DIGITOU"
        loForm.txt_4c__descr.Value = lcDigitado

        loForm.ProbeBOParaForm()

        Log760f8("5) Fixos=2 -> campo codigo=[" + loForm.txt_4c__codigo.Value + ;
                 "] (esperado 22202 - codigo repinta SEMPRE)")
        Log760f8("   campo descr=[" + loForm.txt_4c__descr.Value + "]")
        Log760f8("   DIGITACAO PRESERVADA? " + ;
                 TRANSFORM(loForm.txt_4c__descr.Value == lcDigitado) + " (tem de ser .T.)")

        loForm.this_oBusinessObject.FecharRetornoDoTipo()
        Log760f8("   FecharRetornoDoTipo com Fixos=2 nao mexeu no retorno? " + ;
                 TRANSFORM(loForm.this_oBusinessObject.this_cRetorno == "RETORNO-ANTERIOR"))
    CATCH TO loErro
        Log760f8("5) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 6) Caminho da descricao LIVRE fechando o retorno:
    *    Get_codigo.Value + get_descr.Value do legado
    *==============================================================
    TRY
        loForm.txt_4c__codigo.Value = "22202"
        loForm.txt_4c__descr.Value  = "LIVRE AQUI"
        loForm.ValidarDescricaoLostFocus()
        lcRet = loForm.this_cRetorno
        Log760f8("6) descricao livre -> retorno=[" + lcRet + "]")
        Log760f8("   codigo nos 10 primeiros=[" + LEFT(lcRet, 10) + "] (esperado 22202 + brancos)")
        Log760f8("   descricao a partir do 11=[" + SUBSTR(lcRet, 11) + "] (esperado LIVRE AQUI)")
    CATCH TO loErro
        Log760f8("6) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 7) get_descr.When sem conexao: campo nao-editavel, sem ir ao banco
    *==============================================================
    TRY
        loForm.AtualizarEstadoDescricao()
        Log760f8("7) sem conexao -> descr.ReadOnly=" + TRANSFORM(loForm.txt_4c__descr.ReadOnly) + ;
                 " TabStop=" + TRANSFORM(loForm.txt_4c__descr.TabStop))
    CATCH TO loErro
        Log760f8("7) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 8) Unload devolve o retorno (contrato do legado), e o botao Ok
    *    fecha com Hide - o objeto segue legivel depois
    *==============================================================
    TRY
        Log760f8("8) Unload -> [" + loForm.Unload() + "]")
        loForm.BtnOkClick()
        Log760f8("   depois do BtnOkClick: VARTYPE=" + VARTYPE(loForm) + ;
                 " Visible=" + TRANSFORM(loForm.Visible) + ;
                 " retorno ainda legivel=[" + loForm.this_cRetorno + "]")
    CATCH TO loErro
        Log760f8("8) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    TRY
        loForm.Release()
    CATCH TO loErro
        Log760f8("Release FALHOU: " + loErro.Message)
    ENDTRY
    loForm = .NULL.
ENDIF

Log760f8("PROBE F8 task760 FIM")
QUIT

PROCEDURE Log760f8(pcTexto)
    STRTOFILE(pcTexto + CHR(13) + CHR(10), gcOut760f8, 1)
ENDPROC

PROCEDURE Escopo760f8(poObj, pcNome)
    IF VARTYPE(poObj) != "O"
        Log760f8("1) " + PADR(pcNome, 24) + " <objeto ausente>")
    ELSE
        Log760f8("1) " + PADR(pcNome, 24) + " existe=" + ;
            IIF(PEMSTATUS(poObj, pcNome, 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(poObj, pcNome, 2), "SIM", "NAO"))
    ENDIF
ENDPROC

*-- Subclasse de teste: wrappers PUBLIC para os dois hooks PROTECTED. A
*-- subclasse ALCANCA membro protegido do pai; script solto nao. Mora SO
*-- aqui, nunca em projeto\app\ - alargar o escopo no form migrado nem
*-- funcionaria (o PROTECTED vem da FormBase) e mentiria para quem le.
*-- Instanciada NO LUGAR do form: herda Init, InicializarForm e tudo mais,
*-- entao os passos que nao usam wrapper exercitam o form de verdade.
DEFINE CLASS ProbeFormSigOpLib760 AS FormSigOpLib

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
