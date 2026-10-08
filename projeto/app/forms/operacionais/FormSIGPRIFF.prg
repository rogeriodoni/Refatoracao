*==============================================================================
* FormSIGPRIFF.prg
*
* Form OPERACIONAL - dialogo generico de entrada de dados (equivalente a um
* InputBox) do fluxo da impressora fiscal / TEF.
*
* Legado: SIGPRIFF.SCX (objeto "form1") - WindowType=1 (modal), Width=409,
*   Height=50, SEM PageFrame e SEM Container algum: Text1 e Combo1 penduram
*   direto na Form (Parent: form1). Layout FLAT SEM CONTAINER.
*
*   PARAMETERS do Init legado:
*       pcCab, pcTipo, pcTitulo, pcMaximo, pcMinimo, pcDado
*   Chamador (sigprtef.PRG linha 181):
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                             TamanhoMaximo, TipoDados TO Valores
*
* FASE 4/8: adicionados os controles reais do dialogo - txt_4c_Resposta
*   (Text1) e cbo_4c_Opcoes (Combo1), direto em THIS (SEM PageFrame/Container,
*   fiel ao legado: form1 nao tem Page nenhuma). Este form NAO tem Grid, NAO
*   tem Page1/Page2 e NAO tem botoes CRUD - o SCX original (form1) e o
*   comportamento.json confirmam arvore de 4 objetos (dataenvironment, form1,
*   Text1, Combo1), zero commandbutton/commandgroup, zero SQL. O template
*   generico de Fase 4 ("Grid e Botoes CRUD") NAO se aplica a este legado -
*   inventar Grid/Page/botoes aqui violaria o PILAR 1 (fidelidade de UX) e a
*   regra de nunca fabricar interface que o legado nao tem.
*   KeyPress/ESC/Enter entram nas Fases 7-8.
*
* FASE 5/8: o legado NAO tem Page2 de Dados nem campo algum fora dos dois
*   controles que a Fase 4 ja entregou (o dump tem 4 objetos no total), entao
*   "metade dos campos da Page2" aqui eh ZERO - inventar campo/Page/Container
*   violaria o PILAR 1, e metodo vazio eh stub disfarcado. O trabalho REAL
*   desta fase foi AUDITAR, propriedade por propriedade, o que a Fase 4
*   transcreveu do dump, medindo cada ponto no VFP9 (2026-10-07):
*     - cbo_4c_Opcoes.RowSource apontava para "THIS.this_aOpcoesExibir":
*       array que eh property do FORM resolve por THISFORM, nunca por THIS.
*       Medido: "Property THIS_AOPCOESEXIBIR is not found" ainda no Init -
*       o form NAO ABRIA em modo algum. Corrigido para THISFORM.
*     - combo de RowSourceType=5 nao reage ao DIMENSION do array: medido
*       ListCount = 1 (so a 1a opcao no dropdown) e = 3 so apos Requery().
*       Acrescentado o Requery() depois de popular as opcoes.
*     - array declarado por DIMENSION no DEFINE CLASS nasce com elemento
*       LOGICO: medido List(1) = ".F." no dropdown. Zerado para "".
*     - txt_4c_Resposta.Value = "" explicito (dump: "Value = " vazio).
*     - Form.WindowState = 0 transcrito do dump.
*   O dump NAO declara TabIndex em Text1/Combo1 - nao ha TabIndex a
*   transcrever, e inventar ordem de tabulacao seria desvio do legado.
*
* FASE 6/8: "campos restantes e lookups". O legado NAO TEM LOOKUP ALGUM - o
*   dump inteiro (4 objetos) nao casa fwBuscaExt/fwBuscaSel/fwBuscaInt,
*   mAddColuna, sigacess() nem Acesso*(): inventar um picker aqui violaria o
*   PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao existem no
*   original". E nao sobrou campo a acrescentar (Text1/Combo1 saem na Fase 4).
*   O que de fato FALTAVA aos dois campos era o COMPORTAMENTO DELES: o legado
*   nao tem botao nenhum (zero commandbutton/commandgroup no dump), entao a
*   captura da resposta mora no KeyPress de CADA campo -
*       Text1.KeyPress : IF nKeyCode = 13 / Resposta = ThisForm.Text1.Value
*       Combo1.KeyPress: IF nKeyCode = 13 / Resposta = SUBSTR(Combo1.Value,1,1)
*   Entregues aqui como TxtRespostaKeyPress/CboOpcoesKeyPress ligados por
*   BINDEVENT (AddObject nao aceita codigo de evento) e PUBLIC (regra #3).
*   Sem eles os campos existiam e NAO respondiam: o dialogo so podia ser
*   fechado pela barra de titulo e o chamador recebia sempre vazio
*   ("Operacao Cancelada pelo Usuario"), sem erro nenhum na tela.
*
*   Contrato de TIPO da resposta (ValidarRespostaDigitada), transcrito do UNICO
*   chamador do acervo - C:\4install\FortyusMC\Fortyus\sigprtef.PRG:181-199:
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                              TamanhoMaximo, TipoDados TO Valores
*       IF EMPTY(valores) .or. ISNULL(valores)     -> cancelamento
*       TipoCampo 504/506/515 ou "DDMMAAAA"$Buffer -> Valores = DTOC(Valores)
*       TipoCampo 130                              -> TRANSFORM(Valores,"99999999.99")
*       demais                                     -> Buffer = ALLTRIM(Valores)
*   DTOC exige DATE, a picture numerica do TRANSFORM espera NUMERIC e ALLTRIM
*   exige CHARACTER - tipo errado estoura erro 11 NO CHAMADOR (familia da regra
*   #16). O modo "M" PREVALECE sobre pcDado: o Init legado desvia para o Combo1
*   ANTES de olhar pcDado e o Combo1 captura SUBSTR(Value,1,1), sempre
*   CHARACTER - e o chamador chega a mandar ProximoComando = 20 (que forca
*   lptipo = "M") com TipoDados ja preenchido.
*
*   TamanhoMinimo NAO vira validacao: medido no chamador (linhas 40-41 e 69)
*   que ele vem por referencia da DLL do SiTef e o legado so o usa dentro do
*   IIF(pcMaximo<pcMinimo,...) do MaxLength - nunca como piso de digitacao.
*
* FASE 8/8: "eventos auxiliares e consolidacao". O legado NAO TEM botao, grid,
*   Page1/Page2 nem CRUD algum (confirmado nas Fases 4-7) - os itens genericos
*   do template de Fase 8 (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
*   BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
*   CarregarLista/AjustarBotoesPorModo) NAO se aplicam a este dialogo e nao
*   foram inventados, pela mesma regra que guiou as Fases 4-6 (nao fabricar
*   interface/funcionalidade que o legado nao tem). O que de fato faltava,
*   anotado no cabecalho das Fases 6-7 como ainda nao entregue, era o FLUXO DE SAIDA
*   do dialogo:
*     - form1.KeyPress (IF nKeyCode = 27 / RELEASE WINDOWS): implementado como
*       PROCEDURE KeyPress do FORM (THIS.Hide(), nao THIS.Release() - mesma
*       razao de TxtRespostaKeyPress/CboOpcoesKeyPress: Release() destruiria o
*       objeto antes do chamador conseguir ler a resposta). this_uResposta
*       permanece "" (valor com que THIS.this_oBusinessObject.this_uResposta
*       e inicializado), e o chamador detecta isso como cancelamento, igual ao
*       legado "IF EMPTY(valores) .or. ISNULL(valores)".
*     - Unload -> Return(Resposta): o legado devolve o valor PUBLIC Resposta
*       direto no DO FORM ... TO Valores, mecanismo que CREATEOBJECT/Show()
*       nao reproduz. Substituido por this_uResposta, property do FORM (nao so
*       do BO) espelhada em TxtRespostaKeyPress/CboOpcoesKeyPress logo apos
*       DefinirResposta() - mesmo padrao de acesso direto que FormSIGPRSTF usa
*       (this_cSenhaRetorno/this_lCancelado lidos pelo chamador via
*       loForm.this_uResposta, sem getter). Nenhum menu.prg - este dialogo e
*       sub-rotina de outro codigo (sigprtef.PRG, acervo legado), nunca aberto
*       direto pelo usuario; FormSIGPRSTF (mesma familia de dialogo) tambem nao
*       tem entrada de menu, ao contrario de Formsigprila/FormVca.
*
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormSIGPRIFF AS FormBase
    this_cMensagemErro = ""
	ShowWindow = 1

    *-- Propriedades visuais (legado: form1 Height=50 Width=409 WindowType=1)
    Height     = 50
    Width      = 409
    AutoCenter = .T.
    Caption    = "Form1"
    KeyPreview = .T.
    WindowType = 1      && Modal
    WindowState = 0     && Legado: form1 WindowState = 0 (janela normal)

    *-- Parametros do dialogo (espelham os PARAMETERS do Init legado),
    *-- guardados ANTES de DODEFAULT() para que InicializarForm() (chamado
    *-- por FormBase.Init() via DODEFAULT) possa configurar o Business
    *-- Object com eles.
    this_cCabecalhoDialogo = ""    && pcCab    - opcoes separadas por ";" (modo "M")
                                   &&            ou texto do rotulo nos demais modos
    this_cTipoDialogo      = ""    && pcTipo   - "M" = multipla escolha (ComboBox)
    this_nMaximoDialogo    = 0     && pcMaximo - tamanho (ordem trocada - ver SIGPRIFFBO.prg)
    this_nMinimoDialogo    = 0     && pcMinimo - tamanho (ordem trocada - ver SIGPRIFFBO.prg)
    this_cDadoDialogo      = ""    && pcDado   - "D" = data, "V" = valor, outro = caractere

    *-- Resultado do dialogo, espelhado do BO (THIS.this_oBusinessObject.
    *-- this_uResposta) para o chamador ler direto em loForm.this_uResposta
    *-- depois do Show() modal voltar - mesmo padrao de acesso direto que
    *-- FormSIGPRSTF usa com this_cSenhaRetorno/this_lCancelado. Equivalente ao
    *-- PUBLIC Resposta do legado, que o Unload devolvia via DO FORM ... TO.
    *-- Vazio = usuario cancelou (ESC ou fechou sem digitar/escolher nada),
    *-- igual ao legado ("IF EMPTY(valores) .or. ISNULL(valores)").
    this_uResposta = ""

    *-- Array usado como RowSource (RowSourceType=5) do cbo_4c_Opcoes -
    *-- legado: PUBLIC laOpcoes[lnRep] dentro do Init do form1. Precisa ser
    *-- property do FORM (nao do BO) porque RowSource resolve o nome como
    *-- expressao no contexto do proprio form.
    DIMENSION this_aOpcoesExibir[1]

    *--------------------------------------------------------------------------
    * Init - Construtor. Recebe os PARAMETERS do form legado e os guarda ANTES
    * de DODEFAULT(), porque FormBase.Init() -> InicializarForm() precisa
    * deles para configurar o Business Object. this_cTituloForm (property de
    * FormBase) recebe par_cTitulo aqui - FormBase.Init() ja aplica em
    * THIS.Caption automaticamente, sem necessidade de repetir a atribuicao.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCabecalho, par_cTipo, par_cTitulo, par_nMaximo, par_nMinimo, par_cDado)
        THIS.this_cCabecalhoDialogo = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipoDialogo      = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
        THIS.this_nMaximoDialogo    = IIF(VARTYPE(par_nMaximo) = "N", par_nMaximo, 0)
        THIS.this_nMinimoDialogo    = IIF(VARTYPE(par_nMinimo) = "N", par_nMinimo, 0)
        THIS.this_cDadoDialogo      = IIF(VARTYPE(par_cDado) = "C", par_cDado, "")
        THIS.this_cTituloForm       = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente por FormBase.Init() via
    * DODEFAULT(). Instancia o SIGPRIFFBO, transfere os parametros do dialogo
    * para ele (espelha o corpo do Init do form1 legado) e configura os
    * controles visuais (txt_4c_Resposta/cbo_4c_Opcoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIFFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SIGPRIFFBO", "FormSIGPRIFF.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.ConfigurarParametros( ;
                    THIS.this_cCabecalhoDialogo, ;
                    THIS.this_cTipoDialogo, ;
                    THIS.this_cTituloForm, ;
                    THIS.this_nMaximoDialogo, ;
                    THIS.this_nMinimoDialogo, ;
                    THIS.this_cDadoDialogo)

                THIS.ConfigurarControles()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSIGPRIFF.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria txt_4c_Resposta (Text1) e cbo_4c_Opcoes
    * (Combo1) direto em THIS - legado NAO tem PageFrame/Container algum
    * (form1 eh FLAT, os dois controles sao filhos diretos de form1). Espelha
    * o corpo do Init do form1 legado: um dos dois fica Visible=.F. conforme
    * this_cTipoDialogo, e o Text1 recebe configuracao extra conforme
    * this_cDadoDialogo (data/valor/caractere).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_nQtd, loc_nI

        *-- Array do RowSource: declarado por DIMENSION no DEFINE CLASS, ele
        *-- nasce com os elementos em LOGICO (medido no VFP9 2026-10-07:
        *-- VARTYPE(elemento) = "L"). Sem zerar para "" o combo exibe um item
        *-- ".F." (medido: ListCount = 1, List(1) = ".F."). No legado o
        *-- laOpcoes so passa a existir no modo "M", dentro do Init.
        DIMENSION THIS.this_aOpcoesExibir[1]
        THIS.this_aOpcoesExibir[1] = ""

        *-- txt_4c_Resposta (legado: Text1 - Alignment=3, SelectOnEntry=.T.)
        THIS.AddObject("txt_4c_Resposta", "TextBox")
        WITH THIS.txt_4c_Resposta
            .Top           = 12
            .Left          = 12
            .Width         = 389
            .Height        = 25
            *-- Dump legado: "Value = " (vazio) = caractere vazio. Explicito
            *-- porque os ramos "D"/"V" mais abaixo TROCAM o tipo do .Value
            *-- (Date / Numeric) e o ramo de caractere depende deste valor base.
            .Value         = ""
            .Alignment     = 3
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH

        *-- cbo_4c_Opcoes (legado: Combo1 - Style=2 "Dropdown List",
        *-- RowSourceType=5 "Array", RowSource = "laopcoes").
        *-- RowSource de array que eh PROPERTY do form resolve por THISFORM e
        *-- NUNCA por THIS: medido no VFP9 2026-10-07 que
        *-- "THIS.this_aOpcoesExibir" estoura "Property THIS_AOPCOESEXIBIR is
        *-- not found" ainda no Init (THIS resolve contra o proprio ComboBox),
        *-- derrubando a abertura do form INTEIRO; com THISFORM o combo lista
        *-- as opcoes (ListCount = 3 no mesmo ensaio).
        THIS.AddObject("cbo_4c_Opcoes", "ComboBox")
        WITH THIS.cbo_4c_Opcoes
            .Top                = 12
            .Left               = 12
            .Width              = 390
            .Height             = 24
            .Style              = 2
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(0, 0, 0)
            .ReadOnly           = .F.
            .RowSourceType      = 5
            .RowSource          = "THISFORM.this_aOpcoesExibir"
            .Visible            = .T.
        ENDWITH

        IF THIS.this_oBusinessObject.EhMultiplaEscolha()
            *-- Legado: Thisform.text1.Visible = .f. (modo "M")
            loc_nQtd = THIS.this_oBusinessObject.ObterQuantidadeOpcoes()

            IF loc_nQtd > 0
                DIMENSION THIS.this_aOpcoesExibir[loc_nQtd]
                FOR loc_nI = 1 TO loc_nQtd
                    THIS.this_aOpcoesExibir[loc_nI] = THIS.this_oBusinessObject.ObterOpcao(loc_nI)
                ENDFOR
            ELSE
                DIMENSION THIS.this_aOpcoesExibir[1]
                THIS.this_aOpcoesExibir[1] = ""
            ENDIF

            *-- Combo de RowSourceType=5 NAO reage sozinho ao DIMENSION do
            *-- array: medido no VFP9 2026-10-07 que, populando 3 opcoes depois
            *-- de o RowSource estar definido, ListCount fica em 1 (so a 1a
            *-- opcao aparece no dropdown) e so vai para 3 depois do Requery().
            THIS.cbo_4c_Opcoes.Requery()

            THIS.txt_4c_Resposta.Visible = .F.
        ELSE
            *-- Legado: Thisform.combo1.Visible = .f. (demais modos)
            THIS.cbo_4c_Opcoes.Visible = .F.

            DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cDadoDialogo)) == "D"
                *-- Legado: ThisForm.Text1.Value = Ctod('')
                THIS.txt_4c_Resposta.Value = {}
            CASE UPPER(ALLTRIM(THIS.this_cDadoDialogo)) == "V"
                *-- Legado: ThisForm.Text1.InputMask = "999,999.99" / Value = 0
                THIS.txt_4c_Resposta.InputMask = "999,999.99"
                THIS.txt_4c_Resposta.Value     = 0
            OTHERWISE
                *-- Legado: ThisForm.Text1.MaxLength = IIF(pcMaximo<pcMinimo,pcMinimo,pcMaximo)
                THIS.txt_4c_Resposta.MaxLength = THIS.this_oBusinessObject.ObterTamanhoCampo()
            ENDCASE
        ENDIF

        *-- Eventos dos CAMPOS. O legado nao tem botao algum, entao a captura da
        *-- resposta mora no KeyPress de cada campo (Text1.KeyPress e
        *-- Combo1.KeyPress, os dois com "IF nKeyCode = 13"). Ligados aos DOIS
        *-- controles sempre, qualquer que seja o modo: quem decide qual responde eh
        *-- o Visible que o bloco acima ja ajustou.
        BINDEVENT(THIS.txt_4c_Resposta, "KeyPress", THIS, "TxtRespostaKeyPress")
        BINDEVENT(THIS.cbo_4c_Opcoes,   "KeyPress", THIS, "CboOpcoesKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarRespostaDigitada - Contrato de TIPO da resposta, do jeito que o
    * CHAMADOR do dialogo o aplica (sigprtef.PRG:189-198 - ver cabecalho deste
    * arquivo). Predicado puro: NAO exibe mensagem e NAO bloqueia nada, porque
    * o legado captura o que estiver no controle e fecha - inclusive VAZIO, que
    * o chamador trata como cancelamento ("IF EMPTY(valores) .or.
    * ISNULL(valores)"). Serve para o handler de captura decidir o que GRAVAR
    * em this_uResposta, de modo a nunca entregar ao chamador um valor de tipo
    * que ele nao sabe formatar.
    *
    * Tipo exigido por modo:
    *     modo "M" (ComboBox) -> "C"  (SUBSTR(Value,1,1): sempre 1 caractere -
    *                                  PREVALECE sobre pcDado, como no Init legado)
    *     pcDado = "D"        -> "D"  (chamador faz DTOC)
    *     pcDado = "V"        -> "N"  (chamador faz TRANSFORM com picture numerica)
    *     demais              -> "C"  (chamador faz ALLTRIM)
    *
    * PUBLIC: chamado pelos handlers ligados por BINDEVENT e pelo fluxo de
    * saida que a Fase 8 acrescenta.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarRespostaDigitada(par_uValor)
        LOCAL loc_cTipoEsperado, loc_lMultipla, loc_cDado

        IF ISNULL(par_uValor)
            RETURN .F.
        ENDIF

        *-- Fonte do modo: o BO (mesma regra do EhMultiplaEscolha). Sem BO
        *-- instanciado, cai na propria property do form, que eh a origem do
        *-- valor que o BO recebeu em ConfigurarParametros.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lMultipla = THIS.this_oBusinessObject.EhMultiplaEscolha()
        ELSE
            loc_lMultipla = (UPPER(ALLTRIM(THIS.this_cTipoDialogo)) == "M")
        ENDIF

        loc_cDado = UPPER(ALLTRIM(THIS.this_cDadoDialogo))

        DO CASE
        CASE loc_lMultipla
            loc_cTipoEsperado = "C"
        CASE loc_cDado == "D"
            loc_cTipoEsperado = "D"
        CASE loc_cDado == "V"
            loc_cTipoEsperado = "N"
        OTHERWISE
            loc_cTipoEsperado = "C"
        ENDCASE

        RETURN (VARTYPE(par_uValor) == loc_cTipoEsperado)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtRespostaKeyPress - Legado: form1.Text1.KeyPress
    *     IF nKeyCode = 13 / Resposta = ThisForm.Text1.Value / RELEASE WINDOWS
    * O RELEASE WINDOWS do legado vira THIS.Hide(): o form eh modal
    * (WindowType = 1), entao o Show() do chamador fica bloqueado ate aqui e o
    * Hide() devolve o controle a ele com o objeto VIVO, para que a resposta
    * ainda possa ser lida (mesmo padrao do FormSIGPRSTF). Release() destruiria
    * o objeto antes da leitura.
    * PUBLIC por ser alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtRespostaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        LOCAL loc_uValor, loc_cDado

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        loc_uValor = THIS.txt_4c_Resposta.Value
        loc_cDado  = UPPER(ALLTRIM(THIS.this_cDadoDialogo))

        *-- Caminho do legado: guarda o .Value COMO ESTA, preservando o tipo
        *-- (o chamador conta com Date em "D" e Numeric em "V"). Os demais CASE
        *-- sao defensivos de FRONTEIRA - nao dispararam em nenhum dos 5 modos
        *-- medidos, e existem para que um .Value fora do contrato nunca chegue
        *-- ao DTOC/TRANSFORM/ALLTRIM do chamador como erro 11.
        DO CASE
        CASE THIS.ValidarRespostaDigitada(loc_uValor)
            *-- contrato satisfeito - nada a converter
        CASE loc_cDado == "D"
            loc_uValor = ConverterParaData(loc_uValor)
        CASE loc_cDado == "V"
            loc_uValor = IIF(VARTYPE(loc_uValor) = "C", VAL(loc_uValor), 0)
        OTHERWISE
            loc_uValor = TRANSFORM(loc_uValor)
        ENDCASE

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DefinirResposta(loc_uValor)
        ENDIF

        *-- Espelha no FORM (equivalente ao PUBLIC Resposta do legado) - ver
        *-- comentario de this_uResposta no cabecalho da classe.
        THIS.this_uResposta = loc_uValor

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * CboOpcoesKeyPress - Legado: form1.Combo1.KeyPress
    *     IF nKeyCode = 13 / Resposta = SUBSTR(ThisForm.Combo1.Value,1,1) /
    *     RELEASE WINDOWS
    * O SUBSTR(...,1,1) eh REGRA, nao detalhe: o chamador monta as opcoes como
    * "<codigo>:<texto>;" (sigprtef.PRG:175 - Escolhas = "0:Sim;1:Nao;"), logo a
    * resposta eh o CODIGO, isto eh o 1o caractere do item escolhido. Nada
    * escolhido -> Value vazio -> SUBSTR("",1,1) = "" -> o chamador le como
    * cancelamento, igual ao legado.
    * PUBLIC por ser alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CboOpcoesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        LOCAL loc_uSelecionado, loc_cResposta

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        loc_uSelecionado = THIS.cbo_4c_Opcoes.Value

        *-- ComboBox de RowSourceType = 5 sobre array de caracteres devolve
        *-- CHARACTER; o TRANSFORM cobre o caso de o array trazer outro tipo,
        *-- para o SUBSTR nunca estourar erro 11.
        IF VARTYPE(loc_uSelecionado) != "C"
            loc_uSelecionado = TRANSFORM(loc_uSelecionado)
        ENDIF

        loc_cResposta = SUBSTR(loc_uSelecionado, 1, 1)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DefinirResposta(loc_cResposta)
        ENDIF

        *-- Espelha no FORM (equivalente ao PUBLIC Resposta do legado) - ver
        *-- comentario de this_uResposta no cabecalho da classe.
        THIS.this_uResposta = loc_cResposta

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Legado: form1.KeyPress
    *     IF nkeycode = 27 / RELEASE WINDOWS / Endif
    * KeyPreview = .T. (propriedade copiada do legado) garante que o FORM
    * recebe o KeyPress antes de txt_4c_Resposta/cbo_4c_Opcoes. THIS.Hide() no
    * lugar de THIS.Release() - mesma razao de TxtRespostaKeyPress/
    * CboOpcoesKeyPress: Release() destruiria o objeto antes do chamador
    * conseguir ler this_uResposta, que permanece "" (cancelamento, igual ao
    * legado) porque nenhum dos dois handlers de captura rodou.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor. DODEFAULT() OBRIGATORIO como ultima linha (FormBase
    * restaura o menu principal apos qualquer form modal fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
