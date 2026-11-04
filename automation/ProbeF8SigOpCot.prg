*-- Probe da FASE 8 de FormSigOpCot (task708).
*-- FormParaBO/BOParaForm sao PROTECTED (herdado de FormBase, que nao se
*-- alarga) - por isso o probe usa SUBCLASSE com wrapper publico: script
*-- solto nao alcanca membro protegido.
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcCk
lcCk = "C:\temp\f8cot\ck.txt"
STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), lcCk)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\temp\f8cot\probe_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"

DO config.prg
STRTOFILE("CK2 config.prg OK" + CHR(13) + CHR(10), lcCk, 1)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCotBO.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCot.prg") ADDITIVE
STRTOFILE("CK3 dependencias OK" + CHR(13) + CHR(10), lcCk, 1)

*-- Cursor de trabalho do form PAI (TmpCot) + cabecalho do documento (TprMvCab)
CREATE CURSOR cur_pai_cot (cmoes C(3), valos N(11,6), avalos N(11,6))
INSERT INTO cur_pai_cot (cmoes, valos, avalos) VALUES ("USD", 5.250000, 0)
INSERT INTO cur_pai_cot (cmoes, valos, avalos) VALUES ("EUR", 6.100000, 0)
INSERT INTO cur_pai_cot (cmoes, valos, avalos) VALUES ("", 0, 0)
CREATE CURSOR cur_pai_cab (cotusus C(10))
INSERT INTO cur_pai_cab (cotusus) VALUES ("")

LOCAL loPai, loForm, loBO, lcAlias, lnAntes, llOk
loPai = CREATEOBJECT("FormPaiFalsoCot")
loPai.pcEscolha             = "INSERIR"
loPai.this_cCursorCotacao   = "cur_pai_cot"
loPai.this_cCursorCabecalho = "cur_pai_cab"

loForm = CREATEOBJECT("ProbeFormSigOpCot", loPai, DATE())
STRTOFILE("CK4 instancia=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcCk, 1)

loBO    = loForm.this_oBusinessObject
lcAlias = loForm.this_cCursorCotacao

*-- gb_4c_ModoTeste faz o InicializarForm pular o CarregarLista: aqui ele eh
*-- chamado a mao, pelo wrapper, para exercitar o bind da grade
llOk = loForm.ProbeCarregarLista()
STRTOFILE("CK5 CarregarLista ret=" + TRANSFORM(llOk) + ;
    " recsrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
    " colcount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
    " c1cs=[" + loForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
    " c2cs=[" + loForm.grd_4c_Dados.Column2.ControlSource + "]" + ;
    " c1w=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + ;
    " c2w=" + TRANSFORM(loForm.grd_4c_Dados.Column2.Width) + ;
    " recc=" + TRANSFORM(RECCOUNT(lcAlias)) + " (3 inseridas, Load apaga a sem moeda)" + ;
    CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 1 - BOParaForm com BO VAZIO nao pode zerar a linha do pai
SELECT (lcAlias)
GO TOP
lnAntes = cur_pai_cot.valos
loBO.this_cMoeda      = ""
loBO.this_nValorAtual = 0
llOk = loForm.ProbeBOParaForm()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK6 T1 guard BO vazio: antes=" + TRANSFORM(lnAntes) + " depois=" + ;
    TRANSFORM(cur_pai_cot.valos) + " ret=" + TRANSFORM(llOk) + ;
    IIF(cur_pai_cot.valos = lnAntes, " [OK nao zerou]", " [FALHOU zerou]") + CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 2 - FormParaBO le a LINHA CORRENTE
SELECT (lcAlias)
GO TOP
llOk = loForm.ProbeFormParaBO()
STRTOFILE("CK7 T2 FormParaBO ret=" + TRANSFORM(llOk) + " bo.moeda=[" + ALLTRIM(loBO.this_cMoeda) + ;
    "] bo.valor=" + TRANSFORM(loBO.this_nValorAtual) + " linha=[" + ALLTRIM(cur_pai_cot.cmoes) + ;
    "] linha.valos=" + TRANSFORM(cur_pai_cot.valos) + ;
    IIF(ALLTRIM(loBO.this_cMoeda) == ALLTRIM(cur_pai_cot.cmoes) ;
        AND loBO.this_nValorAtual = cur_pai_cot.valos, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 3 - BOParaForm devolve o valor do BO para a linha corrente
loBO.this_nValorAtual = 9.123456
llOk = loForm.ProbeBOParaForm()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK8 T3 BOParaForm escreve ret=" + TRANSFORM(llOk) + " valos=" + ;
    TRANSFORM(cur_pai_cot.valos) + IIF(cur_pai_cot.valos = 9.123456, " [OK]", " [FALHOU]") + ;
    CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 4 - troca de linha: FormParaBO acompanha a moeda nova
SELECT (lcAlias)
GO BOTTOM
llOk = loForm.ProbeFormParaBO()
STRTOFILE("CK9 T4 troca linha bo.moeda=[" + ALLTRIM(loBO.this_cMoeda) + "] linha=[" + ;
    ALLTRIM(cur_pai_cot.cmoes) + "]" + ;
    IIF(ALLTRIM(loBO.this_cMoeda) == ALLTRIM(cur_pai_cot.cmoes), " [OK]", " [FALHOU]") + ;
    CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 5 - gravar na linha 2 nao contamina a linha 1
loBO.this_nValorAtual = 7.5
loForm.ProbeBOParaForm()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK10 T5 linha1 intacta valos=" + TRANSFORM(cur_pai_cot.valos) + ;
    IIF(cur_pai_cot.valos = 9.123456, " [OK]", " [FALHOU contaminou]") + CHR(13) + CHR(10), lcCk, 1)
GO BOTTOM
STRTOFILE("CK11 T5 linha2 gravada valos=" + TRANSFORM(cur_pai_cot.valos) + ;
    IIF(cur_pai_cot.valos = 7.5, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 6 - Cancelar desfaz pelo avalos (Replace All Valos With aValos)
loForm.BtnCancelarClick()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK12 T6 cancelar desfaz L1 valos=" + TRANSFORM(cur_pai_cot.valos) + " avalos=" + ;
    TRANSFORM(cur_pai_cot.avalos) + IIF(cur_pai_cot.valos = cur_pai_cot.avalos, " [OK]", " [FALHOU]") + ;
    " confirmado=" + TRANSFORM(loForm.this_lConfirmado) + CHR(13) + CHR(10), lcCk, 1)

*-- TESTE 7 - Confirmar marca a saida por Salvar sem tocar no cursor
SELECT (lcAlias)
GO TOP
lnAntes = cur_pai_cot.valos
loForm.BtnConfirmarClick()
SELECT (lcAlias)
GO TOP
STRTOFILE("CK13 T7 confirmar: confirmado=" + TRANSFORM(loForm.this_lConfirmado) + ;
    " valos=" + TRANSFORM(cur_pai_cot.valos) + ;
    IIF(loForm.this_lConfirmado AND cur_pai_cot.valos = lnAntes, " [OK]", " [FALHOU]") + ;
    CHR(13) + CHR(10), lcCk, 1)

STRTOFILE("CK14 msgerro=[" + loForm.this_cMensagemErro + "]" + CHR(13) + CHR(10), lcCk, 1)
loForm.Release()
STRTOFILE("CK15 release OK - FIM" + CHR(13) + CHR(10), lcCk, 1)
QUIT

*-- Subclasse de teste: expoe os hooks PROTECTED por wrapper publico
DEFINE CLASS ProbeFormSigOpCot AS FormSigOpCot
    PROCEDURE ProbeFormParaBO
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ProbeCarregarLista
        RETURN THIS.CarregarLista()
    ENDPROC
ENDDEFINE

DEFINE CLASS FormPaiFalsoCot AS Form
    pcEscolha             = ""
    this_cCursorCotacao   = ""
    this_cCursorCabecalho = ""
ENDDEFINE
