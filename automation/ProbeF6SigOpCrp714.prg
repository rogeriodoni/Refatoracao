*==============================================================================
* ProbeF6SigOpCrp714.prg - Probe da FASE 6 de FormSigOpCrp (task714)
*
* A Fase 6 ("campos restantes e lookups") neste dialogo entrega:
*   - os 3 campos digitaveis do legado (criados na Fase 4) com os defaults da
*     CLASSE do framework (fweditdata / fwget) que o SCX nao sobrescreve;
*   - NENHUM lookup - o legado nao tem nenhum (medido no dump: zero fwBusca*,
*     zero mAddColuna, zero sigacess, zero Acesso*, zero F4/F5);
*   - o Valid dos 3 campos como Validar<Campo> ligado a "LostFocus".
*
* Este probe PROVA essa entrega nos objetos REAIS: instancia o form, confere
* propriedade por propriedade contra o dump + a classe lida do VCX, confere que
* os BINDEVENT estao de fato REGISTRADOS (AEVENTS, nao apenas "o metodo
* existe") e exercita a exclusao mutua dos 3 criterios nos DOIS sentidos
* (mudou / nao mudou).
*
* ARMADILHAS respeitadas aqui:
*   - AEVENTS tem DOIS argumentos; o nome do evento eh a COLUNA 3 do array
*     (a coluna 2 eh o objeto delegate). AEVENTS(a, obj, "Click") estoura
*     "Too many arguments.".
*   - NENHUM ON ERROR que apenas loga: o ON ERROR do VFP retoma na linha
*     SEGUINTE, entao se a condicao de um IF estoura a execucao cai DENTRO do
*     corpo do IF e o log declara OK sem ter medido nada. Aqui cada teste
*     calcula a condicao numa variavel dentro de TRY/CATCH.
*   - APAGAR o .fxp antes de rodar - o VFP reaproveita o compilado antigo e o
*     probe roda codigo velho sem avisar.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC pcCk
pcCk = "C:\4c\automation\probe_f6_sigopcrp.txt"
STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), pcCk)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f6_sigopcrp_erros.txt"
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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCrpBO.prg")              ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCrp.prg") ADDITIVE
STRTOFILE("CK3 dependencias OK" + CHR(13) + CHR(10), pcCk, 1)

LOCAL loPai, loForm, loBO, llOk, lnI, lnQtd, lcDtl, loErro

loPai = CREATEOBJECT("FormPaiFalsoCrp")

STRTOFILE("CK4 antes do CREATEOBJECT do form" + CHR(13) + CHR(10), pcCk, 1)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpCrp", 1, loPai)
CATCH TO loErro
    STRTOFILE("CK4x EXCECAO no CREATEOBJECT: " + loErro.Message + ;
        " LN=" + TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + ;
        CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK5 instancia=" + VARTYPE(loForm) + CHR(13) + CHR(10), pcCk, 1)

IF VARTYPE(loForm) != "O"
    STRTOFILE("CK5x FALHOU - form nao instanciou" + CHR(13) + CHR(10), pcCk, 1)
    QUIT
ENDIF

loBO = loForm.this_oBusinessObject
STRTOFILE("CK6 BO=" + VARTYPE(loBO) + " msgerro=[" + loForm.this_cMensagemErro + "]" + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 1 - os TRES campos do legado existem, e nada alem deles
lnQtd = 0
FOR lnI = 1 TO loForm.ControlCount
    IF UPPER(loForm.Controls(lnI).BaseClass) == "TEXTBOX"
        lnQtd = lnQtd + 1
    ENDIF
ENDFOR
STRTOFILE("CK7 T1 qtd TextBox no form=" + TRANSFORM(lnQtd) + ;
    IIF(lnQtd = 3, " [OK 3 campos, igual ao legado]", " [FALHOU]") + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 2 - txt_4c_Lancamento x dump getLancamento + classe fweditdata.
*--           fweditdata NAO declara Format nem InputMask (lido do VCX como
*--           DBF): o campo Data nao pode ganhar mascara inventada (regra #49).
llOk = .F.
TRY
    llOk = loForm.txt_4c_Lancamento.Left = 154 AND ;
           loForm.txt_4c_Lancamento.Top = 113 AND ;
           loForm.txt_4c_Lancamento.Width = 80 AND ;
           loForm.txt_4c_Lancamento.Height = 23 AND ;
           loForm.txt_4c_Lancamento.Alignment = 3 AND ;
           !loForm.txt_4c_Lancamento.Themes AND ;
           loForm.txt_4c_Lancamento.SpecialEffect = 1 AND ;
           UPPER(ALLTRIM(loForm.txt_4c_Lancamento.FontName)) == "TAHOMA" AND ;
           loForm.txt_4c_Lancamento.FontSize = 8 AND ;
           EMPTY(loForm.txt_4c_Lancamento.Format) AND ;
           EMPTY(loForm.txt_4c_Lancamento.InputMask) AND ;
           VARTYPE(loForm.txt_4c_Lancamento.Value) == "D"
CATCH TO loErro
    STRTOFILE("CK8e T2 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK8 T2 Lancamento L=" + TRANSFORM(loForm.txt_4c_Lancamento.Left) + ;
    " T=" + TRANSFORM(loForm.txt_4c_Lancamento.Top) + ;
    " W=" + TRANSFORM(loForm.txt_4c_Lancamento.Width) + ;
    " H=" + TRANSFORM(loForm.txt_4c_Lancamento.Height) + ;
    " Align=" + TRANSFORM(loForm.txt_4c_Lancamento.Alignment) + ;
    " Themes=" + TRANSFORM(loForm.txt_4c_Lancamento.Themes) + ;
    " SpEf=" + TRANSFORM(loForm.txt_4c_Lancamento.SpecialEffect) + ;
    " Fmt=[" + loForm.txt_4c_Lancamento.Format + "]" + ;
    " Mask=[" + loForm.txt_4c_Lancamento.InputMask + "]" + ;
    " tipoValue=" + VARTYPE(loForm.txt_4c_Lancamento.Value) + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 3 - txt_4c_Valor / txt_4c_Historico x dump + classe fwget.
*--           fwget declara Format = "K" e NAO declara InputMask.
llOk = .F.
TRY
    llOk = loForm.txt_4c_Valor.Left = 338 AND loForm.txt_4c_Valor.Top = 113 AND ;
           loForm.txt_4c_Valor.Width = 80 AND loForm.txt_4c_Valor.Height = 23 AND ;
           ALLTRIM(loForm.txt_4c_Valor.Format) == "K" AND ;
           EMPTY(loForm.txt_4c_Valor.InputMask) AND ;
           !loForm.txt_4c_Valor.Themes AND ;
           VARTYPE(loForm.txt_4c_Valor.Value) == "N" AND ;
           loForm.txt_4c_Historico.Left = 154 AND loForm.txt_4c_Historico.Top = 137 AND ;
           loForm.txt_4c_Historico.Width = 264 AND loForm.txt_4c_Historico.Height = 23 AND ;
           ALLTRIM(loForm.txt_4c_Historico.Format) == "K" AND ;
           EMPTY(loForm.txt_4c_Historico.InputMask) AND ;
           !loForm.txt_4c_Historico.Themes AND ;
           VARTYPE(loForm.txt_4c_Historico.Value) == "C"
CATCH TO loErro
    STRTOFILE("CK9e T3 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK9 T3 Valor L/T/W/H=" + TRANSFORM(loForm.txt_4c_Valor.Left) + "/" + ;
    TRANSFORM(loForm.txt_4c_Valor.Top) + "/" + TRANSFORM(loForm.txt_4c_Valor.Width) + "/" + ;
    TRANSFORM(loForm.txt_4c_Valor.Height) + " Fmt=[" + loForm.txt_4c_Valor.Format + "]" + ;
    " tipo=" + VARTYPE(loForm.txt_4c_Valor.Value) + ;
    " | Historico L/T/W/H=" + TRANSFORM(loForm.txt_4c_Historico.Left) + "/" + ;
    TRANSFORM(loForm.txt_4c_Historico.Top) + "/" + TRANSFORM(loForm.txt_4c_Historico.Width) + "/" + ;
    TRANSFORM(loForm.txt_4c_Historico.Height) + " Fmt=[" + loForm.txt_4c_Historico.Format + "]" + ;
    " tipo=" + VARTYPE(loForm.txt_4c_Historico.Value) + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 4 - labels de dados NAO em branco sobre a textura clara da Picture
*--           (regra #12: canonico RGB(90,90,90)) e Alignment 0 (regra #23).
llOk = .F.
TRY
    llOk = loForm.lbl_4c_Label1.ForeColor = RGB(90,90,90) AND ;
           loForm.lbl_4c_Label2.ForeColor = RGB(90,90,90) AND ;
           loForm.lbl_4c_Label3.ForeColor = RGB(90,90,90) AND ;
           loForm.lbl_4c_Label1.Alignment = 0 AND ;
           loForm.lbl_4c_Label2.Alignment = 0 AND ;
           loForm.lbl_4c_Label3.Alignment = 0
CATCH TO loErro
    STRTOFILE("CK10e T4 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK10 T4 labels fore=" + TRANSFORM(loForm.lbl_4c_Label1.ForeColor) + "/" + ;
    TRANSFORM(loForm.lbl_4c_Label2.ForeColor) + "/" + TRANSFORM(loForm.lbl_4c_Label3.ForeColor) + ;
    " align=" + TRANSFORM(loForm.lbl_4c_Label1.Alignment) + "/" + ;
    TRANSFORM(loForm.lbl_4c_Label2.Alignment) + "/" + TRANSFORM(loForm.lbl_4c_Label3.Alignment) + ;
    " caps=[" + ALLTRIM(loForm.lbl_4c_Label1.Caption) + "][" + ;
    ALLTRIM(loForm.lbl_4c_Label2.Caption) + "][" + ALLTRIM(loForm.lbl_4c_Label3.Caption) + "]" + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 5 - os BINDEVENT estao REGISTRADOS (AEVENTS: 2 argumentos, evento na
*--           COLUNA 3) e NENHUM campo tem handler em "KeyPress" - handler de
*--           validacao em KeyPress eh a assinatura de defeito da regra #47.
lcDtl = ""
llOk  = .T.
TRY
    lcDtl = lcDtl + "Lanc=[" + ListarEventosLigados(loForm.txt_4c_Lancamento) + "]"
    lcDtl = lcDtl + " Valor=[" + ListarEventosLigados(loForm.txt_4c_Valor) + "]"
    lcDtl = lcDtl + " Hist=[" + ListarEventosLigados(loForm.txt_4c_Historico) + "]"
    lcDtl = lcDtl + " Btn1=[" + ListarEventosLigados(loForm.obj_4c_Commandgroup1.Buttons(1)) + "]"
    lcDtl = lcDtl + " Btn2=[" + ListarEventosLigados(loForm.obj_4c_Commandgroup1.Buttons(2)) + "]"

    llOk = ContarEventoLigado(loForm.txt_4c_Lancamento, "GOTFOCUS")  = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Lancamento, "LOSTFOCUS") = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Valor,      "GOTFOCUS")  = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Valor,      "LOSTFOCUS") = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Historico,  "GOTFOCUS")  = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Historico,  "LOSTFOCUS") = 1 AND ;
           ContarEventoLigado(loForm.txt_4c_Lancamento, "KEYPRESS")  = 0 AND ;
           ContarEventoLigado(loForm.txt_4c_Valor,      "KEYPRESS")  = 0 AND ;
           ContarEventoLigado(loForm.txt_4c_Historico,  "KEYPRESS")  = 0 AND ;
           ContarEventoLigado(loForm.obj_4c_Commandgroup1.Buttons(1), "CLICK") = 1 AND ;
           ContarEventoLigado(loForm.obj_4c_Commandgroup1.Buttons(2), "CLICK") = 1
CATCH TO loErro
    llOk = .F.
    STRTOFILE("CK11e T5 EXCECAO: " + loErro.Message + ;
        " LN=" + TRANSFORM(loErro.LineNo) + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK11 T5 bindevent " + lcDtl + IIF(llOk, " [OK]", " [FALHOU]") + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 6 - GotFocus alimenta o Tag do BO (a metade "entrada" do par)
llOk = .F.
TRY
    loForm.txt_4c_Lancamento.Value = DATE()
    loForm.TxtLancamentoGotFocus()
    loForm.txt_4c_Valor.Value = 123.45
    loForm.TxtValorGotFocus()
    loForm.txt_4c_Historico.Value = "SAQUE"
    loForm.TxtHistoricoGotFocus()
    llOk = ALLTRIM(loBO.this_cTagDatas) == DTOS(DATE()) AND ;
           VAL(loBO.this_cTagValors) = 123.45 AND ;
           ALLTRIM(loBO.this_cTagHists) == "SAQUE"
CATCH TO loErro
    STRTOFILE("CK12e T6 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK12 T6 tags=[" + ALLTRIM(loBO.this_cTagDatas) + "][" + ;
    ALLTRIM(loBO.this_cTagValors) + "][" + ALLTRIM(loBO.this_cTagHists) + "]" + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 7 - ValidarLancamento: MUDOU a data -> zera Valor e Historico na TELA
*--           (legado: getValor.Value = 0.00 / getHistorico.Value = '')
llOk = .F.
TRY
    loForm.txt_4c_Lancamento.Value = DATE() - 1
    loForm.ValidarLancamento()
    llOk = loForm.txt_4c_Valor.Value = 0 AND EMPTY(loForm.txt_4c_Historico.Value)
CATCH TO loErro
    STRTOFILE("CK13e T7 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK13 T7 Lanc mudou -> Valor=" + TRANSFORM(loForm.txt_4c_Valor.Value) + ;
    " Hist=[" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
    IIF(llOk, " [OK zerou os outros dois]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 8 - ValidarValor: MUDOU o valor -> zera Data e Historico na TELA
llOk = .F.
TRY
    loForm.txt_4c_Lancamento.Value = DATE()
    loForm.txt_4c_Historico.Value  = "SAQUE"
    loForm.txt_4c_Valor.Value      = 500.00
    loForm.TxtValorGotFocus()
    loForm.txt_4c_Valor.Value      = 900.00
    loForm.ValidarValor()
    llOk = EMPTY(loForm.txt_4c_Lancamento.Value) AND EMPTY(loForm.txt_4c_Historico.Value)
CATCH TO loErro
    STRTOFILE("CK14e T8 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK14 T8 Valor mudou -> Data=[" + DTOC(loForm.txt_4c_Lancamento.Value) + ;
    "] Hist=[" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
    IIF(llOk, " [OK zerou os outros dois]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 9 - ValidarHistorico: MUDOU o texto -> zera Data e Valor na TELA
llOk = .F.
TRY
    loForm.txt_4c_Lancamento.Value = DATE()
    loForm.txt_4c_Valor.Value      = 77.00
    loForm.txt_4c_Historico.Value  = "AAA"
    loForm.TxtHistoricoGotFocus()
    loForm.txt_4c_Historico.Value  = "BBB"
    loForm.ValidarHistorico()
    llOk = EMPTY(loForm.txt_4c_Lancamento.Value) AND loForm.txt_4c_Valor.Value = 0
CATCH TO loErro
    STRTOFILE("CK15e T9 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK15 T9 Hist mudou -> Data=[" + DTOC(loForm.txt_4c_Lancamento.Value) + ;
    "] Valor=" + TRANSFORM(loForm.txt_4c_Valor.Value) + ;
    IIF(llOk, " [OK zerou os outros dois]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 10 - NAO MUDOU: nenhum dos tres handlers pode zerar nada
*--            (o legado so limpa dentro do If This.Value # This.Tag)
llOk = .F.
TRY
    loForm.txt_4c_Lancamento.Value = DATE()
    loForm.TxtLancamentoGotFocus()
    loForm.txt_4c_Valor.Value      = 333.00
    loForm.TxtValorGotFocus()
    loForm.txt_4c_Historico.Value  = "CCC"
    loForm.TxtHistoricoGotFocus()
    loForm.ValidarLancamento()
    loForm.ValidarValor()
    loForm.ValidarHistorico()
    llOk = loForm.txt_4c_Lancamento.Value = DATE() AND ;
           loForm.txt_4c_Valor.Value = 333.00 AND ;
           ALLTRIM(loForm.txt_4c_Historico.Value) == "CCC"
CATCH TO loErro
    STRTOFILE("CK16e T10 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK16 T10 nada mudou -> Data=[" + DTOC(loForm.txt_4c_Lancamento.Value) + ;
    "] Valor=" + TRANSFORM(loForm.txt_4c_Valor.Value) + ;
    " Hist=[" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
    IIF(llOk, " [OK preservou os tres]", " [FALHOU limpou sem o usuario mudar]") + ;
    CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 11 - Picture dos botoes APONTA PARA ARQUIVO QUE EXISTE
*--            (regra #25: .Picture inexistente falha em SILENCIO)
llOk = .F.
TRY
    llOk = loForm.obj_4c_Commandgroup1.ButtonCount = 2 AND ;
           FILE(loForm.obj_4c_Commandgroup1.Buttons(1).Picture) AND ;
           FILE(loForm.obj_4c_Commandgroup1.Buttons(2).Picture) AND ;
           loForm.obj_4c_Commandgroup1.Buttons(2).Cancel
CATCH TO loErro
    STRTOFILE("CK17e T11 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK17 T11 btn1 pic=" + TRANSFORM(FILE(loForm.obj_4c_Commandgroup1.Buttons(1).Picture)) + ;
    " btn2 pic=" + TRANSFORM(FILE(loForm.obj_4c_Commandgroup1.Buttons(2).Picture)) + ;
    " cancel2=" + TRANSFORM(loForm.obj_4c_Commandgroup1.Buttons(2).Cancel) + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 12 - ordem de tabulacao efetiva: os 3 campos ANTES do grupo de botoes
llOk = .F.
TRY
    llOk = loForm.txt_4c_Lancamento.TabIndex < loForm.txt_4c_Valor.TabIndex AND ;
           loForm.txt_4c_Valor.TabIndex < loForm.txt_4c_Historico.TabIndex AND ;
           loForm.txt_4c_Historico.TabIndex < loForm.obj_4c_Commandgroup1.TabIndex
CATCH TO loErro
    STRTOFILE("CK18e T12 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK18 T12 tabindex Lanc=" + TRANSFORM(loForm.txt_4c_Lancamento.TabIndex) + ;
    " Valor=" + TRANSFORM(loForm.txt_4c_Valor.TabIndex) + ;
    " Hist=" + TRANSFORM(loForm.txt_4c_Historico.TabIndex) + ;
    " Grupo=" + TRANSFORM(loForm.obj_4c_Commandgroup1.TabIndex) + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

*-- TESTE 13 - campos, labels e grupo VISIVEIS (AddObject nasce Visible=.F.)
llOk = .F.
TRY
    llOk = loForm.txt_4c_Lancamento.Visible AND loForm.txt_4c_Valor.Visible AND ;
           loForm.txt_4c_Historico.Visible AND loForm.lbl_4c_Label1.Visible AND ;
           loForm.lbl_4c_Label2.Visible AND loForm.lbl_4c_Label3.Visible AND ;
           loForm.obj_4c_Commandgroup1.Visible
CATCH TO loErro
    STRTOFILE("CK19e T13 EXCECAO: " + loErro.Message + CHR(13) + CHR(10), pcCk, 1)
ENDTRY
STRTOFILE("CK19 T13 visiveis campos=" + TRANSFORM(loForm.txt_4c_Lancamento.Visible) + ;
    TRANSFORM(loForm.txt_4c_Valor.Visible) + TRANSFORM(loForm.txt_4c_Historico.Visible) + ;
    " labels=" + TRANSFORM(loForm.lbl_4c_Label1.Visible) + ;
    TRANSFORM(loForm.lbl_4c_Label2.Visible) + TRANSFORM(loForm.lbl_4c_Label3.Visible) + ;
    " grupo=" + TRANSFORM(loForm.obj_4c_Commandgroup1.Visible) + ;
    IIF(llOk, " [OK]", " [FALHOU]") + CHR(13) + CHR(10), pcCk, 1)

STRTOFILE("CK20 msgerro final=[" + loForm.this_cMensagemErro + "]" + CHR(13) + CHR(10), pcCk, 1)
loForm.Release()
STRTOFILE("CK21 FIM" + CHR(13) + CHR(10), pcCk, 1)
QUIT


*------------------------------------------------------------------------------
* ContarEventoLigado - quantos BINDEVENT existem no objeto para um evento.
*
* AEVENTS aceita DOIS argumentos (consulta por objeto de ORIGEM) - com um
* terceiro estoura "Too many arguments.". O nome do evento eh a COLUNA 3 do
* array (a 2 eh o objeto DELEGATE); o array eh sempre 2-D, inclusive com 1
* binding, por isso ALEN(a, 1) para contar linhas.
*------------------------------------------------------------------------------
FUNCTION ContarEventoLigado(par_oOrigem, par_cEvento)
    LOCAL loc_nQtd, loc_nI, loc_nAchou
    LOCAL ARRAY loc_aEv[1, 5]

    loc_nQtd   = AEVENTS(loc_aEv, par_oOrigem)
    loc_nAchou = 0

    IF loc_nQtd > 0
        FOR loc_nI = 1 TO ALEN(loc_aEv, 1)
            IF UPPER(ALLTRIM(loc_aEv[loc_nI, 3])) == UPPER(ALLTRIM(par_cEvento))
                loc_nAchou = loc_nAchou + 1
            ENDIF
        ENDFOR
    ENDIF

    RETURN loc_nAchou
ENDFUNC


*------------------------------------------------------------------------------
* ListarEventosLigados - "EVENTO>metodo" de cada binding, para o log
*------------------------------------------------------------------------------
FUNCTION ListarEventosLigados(par_oOrigem)
    LOCAL loc_nQtd, loc_nI, loc_cLista
    LOCAL ARRAY loc_aEv[1, 5]

    loc_nQtd   = AEVENTS(loc_aEv, par_oOrigem)
    loc_cLista = ""

    IF loc_nQtd > 0
        FOR loc_nI = 1 TO ALEN(loc_aEv, 1)
            loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", " ") + ;
                UPPER(ALLTRIM(loc_aEv[loc_nI, 3])) + ">" + ALLTRIM(loc_aEv[loc_nI, 4])
        ENDFOR
    ENDIF

    RETURN loc_cLista
ENDFUNC


*------------------------------------------------------------------------------
* Form PAI falso: este dialogo so le Top/Left/Width do pai (posicionamento)
*------------------------------------------------------------------------------
DEFINE CLASS FormPaiFalsoCrp AS Form
    Top   = 50
    Left  = 100
    Width = 1000
ENDDEFINE
