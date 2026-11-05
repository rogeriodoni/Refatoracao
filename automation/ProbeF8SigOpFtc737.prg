*==============================================================================
* ProbeF8SigOpFtc737.prg - Prova de RUNTIME da Fase 8 de Formsigopftc (task737)
*
* "A tela abre" so se prova INSTANCIANDO, e os metodos novos so se provam
* EXECUTANDO. Este probe faz as duas coisas sem rede:
*   1. instancia Formsigopftc em modo de teste (sem Show - o form eh MODAL,
*      WindowType = 1, e Show() travaria o processo headless)
*   2. confere que os metodos da Fase 8 EXISTEM e com o ESCOPO certo
*      (PEMSTATUS atributo 2 = Protected; CarregarLista/HabilitarCampos tem de
*      ser PUBLIC porque o harness os chama de FORA da classe - regra #3)
*   3. simula uma ficha JA montada e executa os caminhos novos
*
* Por que simular: MontarFichaTecnica depende de SigCdFtc/SigOpFtc no SQL
* Server, inalcancavel nesta maquina. O probe cria cursor_4c_Ficha com a MESMA
* lista de colunas de CarregarCaracteristicas e AddObject os dois campos
* mem_4c_Ficha<COrds> com os mesmos nomes que MontarFichaTecnica usaria - eh
* um duble do passo de montagem, nao uma reimplementacao do que se testa.
*
* NAO chamar ConfigurarAmbiente(): ela nao retorna nesta maquina e o probe
* morreria por timeout antes do CREATEOBJECT.
* gb_4c_ModoTeste SEM gc_4c_ArquivoErroTeste nao suprime dialogo - o par eh
* obrigatorio, senao o primeiro MsgErro abre MESSAGEBOX real e pendura tudo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f8_737_probe_dialogs.txt"
gnConnHandle           = 0

LOCAL lcSaida, lcTxt, loForm, loErro, lcCtrl, loCtrl, lnI
LOCAL ARRAY laMet[6, 2]

lcSaida = "C:\4c\automation\_f8_737_probe.txt"
lcTxt   = ""

IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF

*-- ETAPA 1: dependencias (so o que o form usa)
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "sigopftcBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopftc.prg") ADDITIVE

lcTxt = lcTxt + "[1] dependencias carregadas" + CHR(13) + CHR(10)
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 2: instanciacao (pcEscolha = ALTERAR -> campos EDITAVEIS)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigopftc", "ALTERAR", "OPERACAO TESTE", "CLI000001")
CATCH TO loErro
    lcTxt = lcTxt + "[2] EXCECAO no CREATEOBJECT: " + loErro.Message + ;
            " (linha " + TRANSFORM(loErro.LineNo) + ", " + loErro.Procedure + ")" + CHR(13) + CHR(10)
ENDTRY

lcTxt = lcTxt + "[2] VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)
STRTOFILE(lcTxt, lcSaida)

IF VARTYPE(loForm) != "O"
    lcTxt = lcTxt + "RESULTADO: FALHA - form nao instanciou" + CHR(13) + CHR(10)
    STRTOFILE(lcTxt, lcSaida)
    QUIT
ENDIF

lcTxt = lcTxt + "    Caption      = [" + loForm.Caption + "]" + CHR(13) + CHR(10)
lcTxt = lcTxt + "    BaseClass    = [" + loForm.BaseClass + "]" + CHR(13) + CHR(10)
lcTxt = lcTxt + "    Width/Height = " + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
lcTxt = lcTxt + "    DataSession  = " + TRANSFORM(loForm.DataSession) + CHR(13) + CHR(10)
lcTxt = lcTxt + "    CriouForm    = " + TRANSFORM(loForm.this_lCriouForm) + CHR(13) + CHR(10)
lcTxt = lcTxt + "    BO           = " + VARTYPE(loForm.this_oBusinessObject) + CHR(13) + CHR(10)

*-- ETAPA 3: metodos da Fase 8 - existencia e ESCOPO
*-- PEMSTATUS(o, m, 2) = .T. quando PROTECTED. CarregarLista e HabilitarCampos
*-- precisam ser PUBLIC (chamados de fora pelo harness); os outros quatro
*-- precisam ser PROTECTED (FormBase declara os dois hooks PROTECTED e VFP9 nao
*-- permite ALARGAR escopo de metodo herdado).
laMet[1, 1] = "CarregarLista"           && esperado PUBLIC
laMet[1, 2] = "PUBLIC"
laMet[2, 1] = "HabilitarCampos"
laMet[2, 2] = "PUBLIC"
laMet[3, 1] = "BtnCancelarClick"
laMet[3, 2] = "PUBLIC"
laMet[4, 1] = "FormParaBO"
laMet[4, 2] = "PROTECTED"
laMet[5, 1] = "BOParaForm"
laMet[5, 2] = "PROTECTED"
laMet[6, 1] = "ObterControleResposta"
laMet[6, 2] = "PROTECTED"

lcTxt = lcTxt + "[3] metodos da Fase 8:" + CHR(13) + CHR(10)
FOR lnI = 1 TO ALEN(laMet, 1)
    lcTxt = lcTxt + "    " + PADR(laMet[lnI, 1], 24) + ;
            " existe=" + TRANSFORM(PEMSTATUS(loForm, laMet[lnI, 1], 5)) + ;
            "  protected=" + TRANSFORM(PEMSTATUS(loForm, laMet[lnI, 1], 2)) + ;
            "  esperado=" + laMet[lnI, 2] + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 4: duble da ficha montada. Colunas IDENTICAS ao SELECT de
*-- CarregarCaracteristicas; COrds 1 = texto, COrds 2 = data.
CREATE CURSOR cursor_4c_Ficha ( ;
    ccars     C(20), ctits  C(20), clins N(2, 0), cords N(3, 0), ;
    maxs      N(3, 0), mins  N(3, 0), nchkcxas N(1, 0), ;
    cselecaos C(1),  ctpdados C(1), resps C(254), descrs C(40))

INSERT INTO cursor_4c_Ficha ;
    (ccars, ctits, clins, cords, maxs, mins, nchkcxas, cselecaos, ctpdados, resps, descrs) ;
    VALUES ("COR", "TOM", 1, 1, 30, 5, 0, "N", "T", "AZUL ESCURO", "Tom da cor")

INSERT INTO cursor_4c_Ficha ;
    (ccars, ctits, clins, cords, maxs, mins, nchkcxas, cselecaos, ctpdados, resps, descrs) ;
    VALUES ("PRAZO", "ENTREGA", 1, 2, 10, 0, 0, "N", "D", "15/03/2026", "Data de entrega")

*-- Campos que MontarFichaTecnica criaria, com os MESMOS nomes
loForm.cnt_4c_AreaFicha.AddObject("mem_4c_Ficha1", "EditBox")
WITH loForm.cnt_4c_AreaFicha.mem_4c_Ficha1
    .Value     = ""
    .MaxLength = 30
    .Tag       = ""
    .Visible   = .T.
ENDWITH

loForm.cnt_4c_AreaFicha.AddObject("mem_4c_Ficha2", "TextBox")
WITH loForm.cnt_4c_AreaFicha.mem_4c_Ficha2
    .Value     = {}
    .Format    = "E"
    .InputMask = "99/99/9999"
    .MaxLength = 10
    .Tag       = ""
    .Visible   = .T.
ENDWITH

lcTxt = lcTxt + "[4] duble montado: cursor_4c_Ficha com " + ;
        TRANSFORM(RECCOUNT("cursor_4c_Ficha")) + " linha(s) + 2 campos" + CHR(13) + CHR(10)
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 5: CarregarFichaTecnica -> CarregarLinhaFichaNoBO + BOParaForm
loForm.CarregarFichaTecnica()
lcTxt = lcTxt + "[5] CarregarFichaTecnica (BOParaForm):" + CHR(13) + CHR(10)
lcTxt = lcTxt + "    texto .Value = [" + TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.Value) + "]" + ;
        "  esperado [AZUL ESCURO]" + CHR(13) + CHR(10)
lcTxt = lcTxt + "    data  .Value = [" + TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha2.Value) + "]" + ;
        "  tipo=" + VARTYPE(loForm.cnt_4c_AreaFicha.mem_4c_Ficha2.Value) + ;
        "  esperado [15/03/2026] tipo D" + CHR(13) + CHR(10)
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 6: HabilitarCampos nos dois sentidos + respeito ao Tag "FIXA"
loForm.HabilitarCampos(.F.)
lcTxt = lcTxt + "[6] HabilitarCampos(.F.): ReadOnly texto=" + ;
        TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.ReadOnly) + ;
        " data=" + TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha2.ReadOnly) + ;
        "  esperado .T. .T." + CHR(13) + CHR(10)

loForm.HabilitarCampos(.T.)
lcTxt = lcTxt + "    HabilitarCampos(.T.): ReadOnly texto=" + ;
        TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.ReadOnly) + ;
        " data=" + TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha2.ReadOnly) + ;
        "  esperado .F. .F." + CHR(13) + CHR(10)

*-- Resposta FIXA tem de continuar travada mesmo habilitando
loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.Tag = "FIXA"
loForm.HabilitarCampos(.T.)
lcTxt = lcTxt + "    Tag=FIXA + HabilitarCampos(.T.): ReadOnly texto=" + ;
        TRANSFORM(loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.ReadOnly) + ;
        "  esperado .T." + CHR(13) + CHR(10)
loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.Tag = ""
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 7: ValidarFichaTecnica (LerRespostaDaTela). COrds 1 exige Mins = 5:
*-- "AZUL ESCURO" passa; "ABC" reprova.
lcTxt = lcTxt + "[7] ValidarFichaTecnica:" + CHR(13) + CHR(10)
lcTxt = lcTxt + "    com resposta cheia  = " + TRANSFORM(loForm.ValidarFichaTecnica()) + ;
        "  esperado .T." + CHR(13) + CHR(10)

loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.Value = "ABC"
lcTxt = lcTxt + "    com 3 chars (Mins 5) = " + TRANSFORM(loForm.ValidarFichaTecnica()) + ;
        "  esperado .F." + CHR(13) + CHR(10)
loForm.cnt_4c_AreaFicha.mem_4c_Ficha1.Value = "AZUL ESCURO"
STRTOFILE(lcTxt, lcSaida)

*-- ETAPA 8: GravarFichaTecnica -> FormParaBO. Sem banco, a carga das respostas
*-- ja gravadas falha e o metodo devolve .F. SEM estourar - o que se prova aqui
*-- eh que o caminho novo nao quebra e que a mensagem foi SUPRIMIDA (fica no
*-- _dialogs.txt), nao que o INSERT aconteceu.
lcTxt = lcTxt + "[8] GravarFichaTecnica (sem banco) = " + ;
        TRANSFORM(loForm.GravarFichaTecnica()) + ;
        "  esperado .F. (CarregarRespostasGravadas falha sem conexao)" + CHR(13) + CHR(10)

*-- ETAPA 9: CarregarLista sem banco - idem, nao pode estourar
lcTxt = lcTxt + "[9] CarregarLista (sem banco) = " + TRANSFORM(loForm.CarregarLista()) + ;
        "  esperado .F. (CarregarOperacaoComFicha falha sem conexao)" + CHR(13) + CHR(10)

*-- ETAPA 10: Release pelo caminho do Cancelar
loForm.BtnCancelarClick()
lcTxt = lcTxt + "[10] BtnCancelarClick executado (Release)" + CHR(13) + CHR(10)
loForm = .NULL.

lcTxt = lcTxt + "RESULTADO: probe concluido sem travar" + CHR(13) + CHR(10)
STRTOFILE(lcTxt, lcSaida)

QUIT
