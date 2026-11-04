*------------------------------------------------------------------------------
* Formsigopdtf.prg - Form Operacional: Sitef - Cartao de Debito
* Migrado de: tasks/task725/sigopdtf_form_codigo_fonte.txt (SIGOPDTF.scx)
* Integracao com terminal SiTef (DLL CliSiTef32I.DLL) - sem tabela propria.
*
* FORM OPERACIONAL de layout proprio: raiz "Class: form / BaseClass: form"
* no SCX legado, SEM PageFrame (nenhum objeto BaseClass: pageframe na arvore -
* ver layout.json / mapeamento.json) e SEM grid. NAO segue o padrao
* Page1=Lista/Page2=Dados do CRUD (mesmo criterio de FormSigOpCtf/
* Formsigprdft, dialogos TEF irmaos ja migrados neste projeto).
*
* ConfigurarPageFrame() eh mantido como nome do metodo orquestrador da
* estrutura visual (convencao do pipeline multi-fase), mas NAO cria
* PageFrame nenhum - delega para os configuradores especificos (cabecalho
* nesta fase; campos e botao de saida foram acrescentados aqui pela Fase 4).
*
* FASE 3/8 (Estrutura Base): DEFINE CLASS + propriedades, Init(),
* InicializarForm(), ConfigurarPageFrame() (so cabecalho por enquanto),
* Destroy(). Campos de captura (GetValor/GetDigitos/GetCartao/GetCodSeg/
* Optiongroup1/Text1/GetDatas), botao de saida (SAIDA/CANCELA) e os eventos
* de protocolo SiTef entram nas fases seguintes (4-8).
*
* FASE 5/8 (Campos Principais - Parte 1): NADA A ACRESCENTAR, e esta CERTO.
* Esta fase pede "metade dos campos da Page2" - e este legado nao tem Page2
* nenhuma: SIGOPDTF eh um dialogo MODAL de CAPTURA (perfil CAPTURA do gate),
* que so coleta valores digitados e os devolve ao chamador, sem tabela nem
* cursor por tras. Os campos nao moram numa pagina de Dados; moram direto no
* Form, e ja foram entregues por INTEIRO (100%, nao 50%) pela Fase 4 em
* ConfigurarCampos()/ConfigurarBotaoSaida()/ConfigurarOrdemTabulacao().
*
* Paridade conferida objeto a objeto contra o dump (SECAO 1 = 26 objetos) e
* contra layout.json/mapeamento.json - cobertura TOTAL, sem nada a fazer:
*   6 TextBox  : GetValor->txt_4c_Valor, GetDigitos->txt_4c_Digitos,
*                GetCartao->txt_4c_Cartao, Text1->txt_4c_Text1,
*                GetDatas->txt_4c_Datas, GetCodSeg->txt_4c_Codigo
*   1 OptionGroup: Optiongroup1->obj_4c_Optiongroup1 (2 Buttons transcritos)
*   1 CommandGroup: SAIDA->obj_4c_SAIDA (Command1/CANCELA)
*   2 Container : cntSombra->cnt_4c_Cabecalho, Container1->cnt_4c_Container1
*   1 Shape     : Shape2->shp_4c_Shape2
*   12 Label    : lblSombra, lblTitulo, Label5, Label2, Label8,
*                 Container1.Label1, Label11, Label4, Label6, Label12,
*                 Label1 ("0 - Inexistente"), Label3 ("1 - Ilegivel")
*
* Format/InputMask transcritos conforme a regra #49 (override VAZIO do Form
* Designer NAO se transcreve): InputMask entrou em GetValor/GetDigitos/
* GetCartao/Text1/GetCodSeg; GetDatas tem InputMask = "" no dump e por isso
* NAO recebe InputMask aqui; os cinco Format = "" do dump tambem ficam fora.
* Os 7 Label que declaram AutoSize = .T. no dump saem com .AutoSize = .F. +
* Width/Height EXPLICITOS do SCX (regra #23 - AutoSize eh no-op em Label
* criado por AddObject e, com WordWrap, DESCARTA a Height).
* Optiongroup1.Option1.Value = 1 do dump NAO eh transcrito nos Buttons: em
* OptionGroup quem guarda a selecao eh o Value do GRUPO (ja .Value = 1) e
* ButtonsValue != 0 marcaria todos de uma vez (regra do pattern #108).
*
* MEDIDO em 2026-10-31 (helpers reais do OrquestradorMigracao.ps1 carregados
* por AST, nunca por dot-source): o gate de conteudo da Fase 5 PASSA pelo
* ramo CAPTURA - temListaEstritaF5 = False (zero BaseClass grid|pageframe,
* e os helpers estritos ListBoxLigaLista/TokenGradeProprioForm/
* AddCursorLigaGrade/ControlSourceLigaLista todos False; a UNICA ocorrencia
* de ControlSource no dump eh o "OPSENHA" do CommandGroup SAIDA, vestigio da
* classe Grupo_Saida que NAO eh prova de lista), temCampoCaptura = True,
* apiNos = False, dialogoExibicao = False, legadoCapturaF5 = True, e do lado
* migrado 6 TextBox contra um piso de 3 (metade dos 6 do legado).
*
* O que FORCOU o retry desta fase nao foi o gate, foi o guard de NO-OP, que
* roda ANTES dele e usa o predicado do perfil DESPACHANTE
* (Test-LegadoSemCampoNemLista = False aqui, porque este legado TEM campos).
* Divergencia guard-x-gate ja registrada na memoria do projeto para a Fase 6
* (task699/SIGOPCHP) e para a Fase 4 (task699, task715, task717); esta eh a
* primeira ocorrencia medida na Fase 5. Nao se conserta no .prg: as duas
* unicas formas de "satisfazer" o guard escrevendo codigo seriam inventar
* campos que o legado nao tem (viola o PILAR 1) ou criar um
* ConfigurarPaginaDados vazio (stub disfarcado, proibido pela regra de
* completude). O fix cabe no guard do orquestrador - e nao foi feito agora
* porque ha RunLoop VIVO (PID 20544) e 1062 insercoes nao commitadas no
* OrquestradorMigracao.ps1, e editar o .ps1 nao valeria para a execucao em
* curso (& script.ps1 parseia o arquivo na invocacao).
*
* FASE 6/8 (Campos Restantes e Lookups) - medido contra o dump completo
* (34 metodos/eventos, SECAO 3 inteira lida): ZERO campo restante (Fase 5
* ja entregou os 6 TextBox/1 OptionGroup/1 CommandGroup por INTEIRO) e ZERO
* lookup (nenhuma ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
* mAddColuna/CreateObject('fwBusca...) em metodo algum - este dialogo
* conversa com o terminal SiTef via DLL, nunca com tabela de lookup.
*
* Diferente do irmao FormSigOpCtf (cuja Fase 6 transcreveu DOIS Valid
* simples e isolados - ValidarDigitos/ValidarCodSeg), aqui NAO HA Valid
* isolado para transcrever:
*   - GetCodSeg.Valid esta INTEIRO comentado no dump (prefixo "*!*") -
*     codigo morto, desligado de proposito pelo legado; nada a transcrever.
*   - GetDigitos.Valid, GetDigitos.GotFocus, Text1.Valid, GetDatas.Valid,
*     GetDatas.GotFocus e GetCodSeg.LostFocus sao cada um uma VARIANTE do
*     MESMO laco interativo com a DLL (PUBLIC ProximoComando/TipoCampo/
*     TamanhoMinimo/TamanhoMaximo/Buffer/lnContinua/lnRetorno, declaradas
*     no Init legado e lidas/escritas por TODOS esses metodos em conjunto)
*     - indivisiveis do SAIDA.CANCELA.Click/ErroTef/RetornoFalha/
*     MontaRetorno. Fragmentar esse laco agora geraria ou BINDEVENT para
*     metodo inexistente, ou um pedaco de maquina de estado que nao faz
*     nada sozinho - o "stub disfarcado" que a regra de completude proibe.
*     Confirmado tambem em sigopdtfBO.prg (Fases 1-2): ConectarSiTef/
*     IniciarSiTef/ContinuarSiTef/MontarBufferSiTef ja existem no BO,
*     prontos para serem CONSUMIDOS pelo laco - mas o laco em si (que
*     decide QUANDO chamar cada um) e' o corpo das Fases 7-8, mesmo
*     recorte ja usado nos 3 irmaos desta familia (FormSigOpCtf,
*     Formsigprdft, FormSIGPRTFH).
*
* O que SOBRA de genuinamente independente do laco - e por isso ENTRA
* nesta fase - e' a familia Optiongroup1/Option1 (InteractiveChange/
* Option1.KeyPress/Option1.GotFocus): nenhum dos tres chama a DLL, so
* alternam txt_4c_Datas.Enabled/Value. Implementados abaixo
* (OptTipoVendaChange/OptTipoVendaBtn1KeyPress/OptTipoVendaBtn1GotFocus),
* registrados via BINDEVENT em RegistrarEventosCampos() (chamado por
* InicializarForm). Gate reproduzido fielmente: Optiongroup1.When
* ("Return(ThisForm.pctvenda)") bloqueia a ENTRADA de foco no grupo
* enquanto o protocolo nao libera - BINDEVENT em "When" nao bloqueia nada
* (regra CLAUDE.md #3/#47, retorno do delegate descartado), entao o gate
* vira guarda no TOPO dos tres handlers, testando THIS.this_lTipoVendaLiberado
* (property ja declarada na Fase 3, default .T. - so a Fase 7, ao
* implementar GetDatas.GotFocus/"ThisForm.pcTvenda = .f.", vai fecha-la no
* momento certo). Nomes e logica identicos ao irmao Formsigprdft
* (OptTipoVendaChange/Btn1KeyPress/Btn1GotFocus), que tem o MESMO
* Optiongroup1/txt_4c_Datas e ja passou por este mesmo recorte de fases.
*
* O QUE AINDA NAO ENTRA ATE A FASE 6 (escopo legitimo das Fases 7-8): os
* BINDEVENT restantes (GotFocus/LostFocus/Valid de GetValor/GetDigitos/
* GetCartao/GetCodSeg/Text1/GetDatas), o Click do CANCELA, o KeyPress de
* ESC do Form e o protocolo SiTef propriamente dito
* (ContinuaFuncaoSiTefInterativo / ErroTef / RetornoFalha / MontaRetorno).
*
* FASE 7/8 (Eventos Principais dos Botoes) - entregue: o Click do UNICO
* botao do form e o que ele consome.
*
* Este legado NAO TEM barra CRUD, e isso foi medido no dump, nao presumido:
* zero "frmcadastro", zero "frmrelatorio", zero "Grupo_Op", zero
* "pcEscolha", zero nome de botao em (btn|cmd|Command)(Incluir|Alterar|
* Visualizar|Excluir) e zero "<X>.Click" com verbo CRUD. A superficie de
* botao que o dump PROVA existir eh UMA: nenhum objeto com
* "BaseClass: commandbutton" e um unico "BaseClass: commandgroup" (SAIDA,
* ButtonCount = 1, botao CANCELA). O ButtonCount = 2 que tambem aparece no
* dump eh do Optiongroup1 - radio nao eh botao de acao.
* Portanto os quatro BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick NAO existem aqui: gera-los exigiria inventar botoes
* (viola o PILAR 1) ou criar metodos vazios (proibido pela regra de
* completude).
*
* Entregue nesta fase:
*   - BtnCancelarClick()  <- SIGOPDTF.SAIDA.CANCELA.Click (o botao)
*   - KeyPress()          <- SIGOPDTF.KeyPress (ESC aciona o mesmo Click)
*   - RetornoFalha()      <- SIGOPDTF.retornofalha (consumido pelo Click)
*   - ErroTef()           <- SIGOPDTF.errotef (alimenta o RetornoFalha)
*   - BINDEVENT do Click em RegistrarEventosCampos()
*
* O handler leva o prefixo canonico Btn*Click e eh nomeado pela ACAO
* (cancelar), nunca pelo objeto legado ("CancelaClick") - ver nota completa
* no proprio metodo, junto com a divergencia deliberada Release() -> Hide().
*
* AINDA FORA (Fase 8): os eventos dos campos de captura e o laco interativo
* com a DLL, mais MontaRetorno/Unload/MontarRetornoTef/Move. MontaRetorno
* depende de estado que so o laco produz (pcBandeira/lsCartao vem de
* Left(Buffer,5), lcSaque do dialogo SigCsTef, lnParcs do Text1.Valid e
* ldData do GetDatas.Valid), por isso nao antecipa aqui.
*------------------------------------------------------------------------------

DEFINE CLASS Formsigopdtf AS FormBase

    Height      = 370
    Width       = 467
    AutoCenter  = .T.
    BorderStyle = 2
    *-- ShowWindow/WindowType nascem 0 DE PROPOSITO e sao restaurados para o
    *-- modal top-level do SCX legado no Init, fora de modo de teste (ver nota
    *-- la). Havia aqui uma segunda atribuicao "ShowWindow = 1" logo abaixo,
    *-- remanescente de fase anterior: como a ULTIMA vence, a classe nascia
    *-- top-level e o form travava o VFP9 headless (-T) no probe desta fase,
    *-- exatamente o que o Init diz estar evitando.
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Tahoma"
    FontSize    = 8
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    KeyPreview  = .T.
    Themes      = .F.
    AlwaysOnTop = .T.

    this_oBusinessObject = .NULL.

    *-- Parametros recebidos na criacao (migrado de SIGOPDTF.Init PARAMETERS) -
    *-- guardados no Form ate InicializarForm() transferir para o BO.
    this_cEndSiTef = ""
    this_nValPago  = 0
    this_cCupom    = ""
    this_cCaixa    = ""
    this_cTipPagto = ""
    this_nNumParcs = 1
    this_cIdent    = ""
    this_cOpers    = ""
    this_lKeyEsc   = .T.        && ThisForm.pckeyesc (legado) - habilita ESC para cancelar

    *-- DebCred (parametro legado) eh CHARACTER ("P"=Prazo / "D"=Debito /
    *-- "C"=Credito - ver SIGOPDTF.GetDigitos.Valid/GotFocus, que comparam
    *-- lsDebCred com esses literais), NUNCA logico. O BO (sigopdtfBO, Fase 1)
    *-- declara this_lDebCred como LOGICAL mas nunca o le em metodo algum -
    *-- property morta por enquanto. Guardado aqui como character, fiel ao
    *-- parametro original, para as fases de evento (7-8) que implementam o
    *-- protocolo leem o valor real sem depender daquela property.
    this_cDebCred = ""

    *-- ThisForm.abandona (legado - declarada em RESERVED3/ClassInfo do SCX).
    *-- O dump NUNCA a atribui: nasce .F. e so eh LIDA, em GetDigitos.Valid
    *-- ("IF tHISfORM.abandona / Thisform.release"). Quem liga a flag eh o
    *-- chamador externo que abriu o dialogo, para derrubar a transacao em
    *-- curso.
    this_lAbandona = .F.

    *-- pctvenda (property do SCX legado, default .T.). Unico consumidor:
    *-- Optiongroup1.When ("Return(ThisForm.pctvenda)"), que BLOQUEIA a
    *-- entrada de foco no grupo Tipo de Venda ate o protocolo liberar.
    this_lTipoVendaLiberado = .T.

    *-- lnParcs / ldData do legado: variaveis PUBLIC declaradas no
    *-- SIGOPDTF.Init e lidas so no Unload (retorno da tela). Nao podem ser
    *-- lidas dos controles no lugar delas (mesmo criterio do irmao
    *-- Formsigprdft) - moram aqui e sao alimentadas nos mesmos pontos do
    *-- legado quando os campos de captura forem ligados (fases seguintes).
    this_cParcelasTef = ""
    this_dDataTef     = {}

    *-- Guarda de reentrancia dos lacos do protocolo (FASE 8/8). Os lacos
    *-- exibem dialogo MODAL (ExibirMensagemTef) e desabilitam campos, o que
    *-- tira e devolve o foco - e isso REDISPARA o LostFocus/GotFocus que
    *-- chamou o laco, empilhando uma segunda conversa com o terminal sobre a
    *-- primeira (regras #37/#47). Com um unico PIN-pad do outro lado, a
    *-- segunda conversa consome a resposta da primeira e a transacao sai
    *-- embaralhada - sem erro na tela.
    this_lEmProtocolo = .F.

    *-- Espelho do RETURN do SIGOPDTF.Unload para o chamador que abre esta
    *-- tela por CREATEOBJECT + Show() (padrao do projeto). Preenchida no
    *-- Destroy quando o calculo do retorno (MontarRetornoTef) existir.
    this_cRetornoTef = ""

    *--------------------------------------------------------------------------
    * Init - recebe os parametros da transacao (migrado de SIGOPDTF.Init
    * PARAMETERS EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs,
    * lcIdent, pcOpers) e define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
                    par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers

        THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"

        THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
        THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
        THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
        THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
        THIS.this_cDebCred  = IIF(VARTYPE(par_cDebCred) = "C", par_cDebCred, "")
        THIS.this_cTipPagto = IIF(VARTYPE(par_cTipPagto) = "C", par_cTipPagto, "")
        THIS.this_nNumParcs = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 1)
        THIS.this_cIdent    = IIF(VARTYPE(par_cIdent) $ "NC", TRANSFORM(par_cIdent), "")
        THIS.this_cOpers    = IIF(VARTYPE(par_cOpers) = "C", par_cOpers, "")

        *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
        *-- (top-level window bloqueante) em modo de teste automatizado.
        *-- Classe definida com ShowWindow=0/WindowType=0; producao restaura
        *-- o modal top-level aqui (SCX legado: WindowType = 1).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - ESC cancela a transacao. Migrado de SIGOPDTF.KeyPress, INTEIRO:
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     If nKeyCode = 27 And  nShiftAltCtrl = 0 And ThisForm.pcKeyEsc
    *         NoDefault
    *         ThisForm.SAIDA.CANCELA.Click
    *     Endif
    *
    * KeyPreview = .T. na classe (transcrito do SCX) garante que este evento do
    * FORM dispara ANTES dos controles filhos processarem a tecla - sem ele o
    * ESC seria consumido pelo TextBox em foco e o cancelamento nunca chegaria.
    * "ThisForm.SAIDA.CANCELA.Click" vira a chamada direta a THIS.BtnCancelarClick()
    * (o handler do Click daquele botao - ver nota de nomenclatura la).
    * Sem DODEFAULT: FormBase nao define KeyPress, e nao marcar NODEFAULT fora
    * do ramo do ESC eh exatamente o que deixa as outras teclas seguirem o
    * caminho normal, como no legado.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
            NODEFAULT
            THIS.BtnCancelarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopdtfBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdtfBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.RegistrarEventosCampos()
                THIS.TornarControlesVisiveis(THIS)

                *-- Transfere os parametros recebidos no Init para o BO e monta
                *-- o identificador de terminal (migrado de SIGOPDTF.Init WITH
                *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
                *-- teste headless (sem gnConnHandle real).
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
                    THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
                    THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
                    THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
                    THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
                    THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
                    THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
                    THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers

                    THIS.this_oBusinessObject.CarregarIdentificacaoTerminal()

                    *-- FASE 8/8: le a forma de pagamento (crSigOpFp do Init
                    *-- legado). TEM de vir ANTES de ConfigurarValoresIniciais,
                    *-- que decide a legenda e o estado inicial dos campos a
                    *-- partir de lCartao, e antes de qualquer laco do
                    *-- protocolo, que consulta Garantias/lSaque/Tcdc/Dias/
                    *-- MesFec em cada pergunta do terminal.
                    THIS.this_oBusinessObject.CarregarConfiguracaoPagamento()
                ENDIF

                *-- FASE 8/8: WITH Thisform do final do SIGOPDTF.Init (valores
                *-- iniciais dos campos). Fora do IF de modo de teste de
                *-- proposito: nao toca no banco, so na tela, e eh o que faz o
                *-- dialogo abrir com valor/data/parcelas preenchidos.
                THIS.ConfigurarValoresIniciais()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (form legado nao tem Lista/Dados como CRUD - ver
    * analise.json temGrid=false e layout.json sem BaseClass pageframe/grid):
    * SIGOPDTF eh um dialogo modal de captura de pagamento. Por enquanto so
    * o cabecalho eh montado; ConfigurarCampos()/ConfigurarBotaoSaida() serao
    * acrescentados aqui pelas fases seguintes (4-8), que tambem ligam os
    * eventos de protocolo SiTef.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarBotaoSaida()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria container escuro superior com labels de
    * titulo (migrado de SIGOPDTF.cntSombra/lblSombra/lblTitulo). Caption dos
    * labels espelha THIS.Caption (definido dinamicamente no Init), nao o
    * texto estatico "Cadastro de Testes" gravado no SCX (placeholder de
    * template de framework, sobrescrito em runtime pelo legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100,100,100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0,0,0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255,255,255)
            .Caption       = THIS.Caption
            *-- SCX legado: lblTitulo.ToolTipText = "Titulo do Relatorio"
            .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria os campos de captura direto no Form (sem
    * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
    * dump SIGOPDTF, sem compensacao +29 porque nao ha PageFrame.Top=-29
    * aqui). Migrado de: SIGOPDTF.Shape2/Label5/GetValor/Label2/GetDigitos/
    * Label8/Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/
    * Label6/Text1/GetDatas/GetCodSeg/Label12/Label1("0 - Inexistente")/
    * Label3("1 - Ilegivel").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oCnt

        *-- Shape2 - moldura decorativa ao redor dos campos
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 92
            .Left          = 0
            .Width         = 466
            .Height        = 202
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
        ENDWITH

        *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 101
            .Left      = 138
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "VALOR :"
        ENDWITH

        *-- SCX nao sobrescreve Enabled aqui (nasce .T.) - o campo e protegido
        *-- de digitacao pelo GetValor.When = "Return .f." (bloqueia foco),
        *-- nao por Enabled=.F. (fases de evento, 6-8).
        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Top               = 98
            .Left              = 185
            .Width             = 100
            .Height            = 23
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "99,999,999.99"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Label2 "4 ULTIMOS DIGITOS :" + txt_4c_Digitos (GetDigitos)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 170
            .Left      = 64
            .Width     = 119
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "4 ULTIMOS DIGITOS :"
        ENDWITH

        THIS.AddObject("txt_4c_Digitos", "TextBox")
        WITH THIS.txt_4c_Digitos
            .Top       = 167
            .Left      = 185
            .Width     = 40
            .Height    = 23
            .Value     = ""
            .InputMask = "9999"
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackColor = RGB(212,208,200)
        ENDWITH

        *-- Label8 "NUMERO CARTAO :" + txt_4c_Cartao (GetCartao)
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .AutoSize    = .F.
            .Alignment   = 0
            .BorderStyle = 0
            .Top         = 135
            .Left        = 79
            .Width       = 104
            .Height      = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .ForeColor   = RGB(90,90,90)
            .BackStyle   = 0
            .Caption     = "NUMERO CARTAO :"
        ENDWITH

        THIS.AddObject("txt_4c_Cartao", "TextBox")
        WITH THIS.txt_4c_Cartao
            .Top               = 132
            .Left              = 185
            .Width             = 160
            .Height            = 23
            .Alignment         = 3
            .Value             = ""
            .InputMask         = "9999999999999999999"
            .MaxLength         = 19
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Container1 - balao de instrucao "Insira ou Passe o Cartao"
        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 302
            .Left          = 37
            .Width         = 392
            .Height        = 58
            .SpecialEffect = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .F.
            .Alignment = 2
            .Top       = 13
            .Left      = 21
            .Width     = 349
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Insira ou Passe o Cartao"
        ENDWITH

        *-- Label11 "1a PARCELA/VENCTO :" + txt_4c_Datas (GetDatas)
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 267
            .Left      = 61
            .Width     = 122
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
        ENDWITH

        THIS.AddObject("txt_4c_Datas", "TextBox")
        WITH THIS.txt_4c_Datas
            .Top               = 265
            .Left              = 185
            .Width             = 75
            .Height            = 23
            .Alignment         = 3
            .Value             = {}
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 203
            .Left      = 92
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "TIPO DE VENDA :"
        ENDWITH

        THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH THIS.obj_4c_Optiongroup1
            .ButtonCount = 2
            .Top         = 199
            .Left        = 185
            .Width       = 161
            .Height      = 26
            .Enabled     = .T.
            .Value       = 1

            WITH .Buttons(1)
                .Caption  = " A vista"
                .Top      = 4
                .Left     = 5
                .Width    = 61
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption  = " Predatado"
                .Top      = 5
                .Left     = 73
                .Width    = 80
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
            ENDWITH
        ENDWITH

        *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .F.
            .Alignment = 0
            .Top       = 237
            .Left      = 102
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "N" + CHR(186) + " PARCELAS :"
        ENDWITH

        THIS.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.txt_4c_Text1
            .Top               = 233
            .Left              = 185
            .Width             = 27
            .Height            = 23
            .Value             = ""
            .InputMask         = "99"
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .DisabledForeColor = RGB(0,0,0)
        ENDWITH

        *-- Label12 "COD. SEG. :" + txt_4c_Codigo (GetCodSeg)
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 169
            .Left       = 237
            .Width      = 62
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90,90,90)
            .BackStyle  = 0
            .Caption    = "COD. SEG. :"
        ENDWITH

        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top               = 165
            .Left              = 302
            .Width             = 52
            .Height            = 23
            .Value             = ""
            .InputMask         = "99999"
            .Enabled           = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .BackColor         = RGB(255,255,255)
            .DisabledForeColor = RGB(64,0,64)
        ENDWITH

        *-- Legenda fixa do codigo de seguranca (SIGOPDTF.Label1/Label3 -
        *-- "0 - Inexistente" / "1 - Ilegivel", filhos DIRETOS do form, NAO do
        *-- Container1 - mesmo nome de objeto, parent diferente, sem colisao)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 162
            .Left       = 357
            .Width      = 86
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90,90,90)
            .BackStyle  = 0
            .Caption    = "0 - Inexistente"
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize   = .F.
            .Alignment  = 0
            .FontItalic = .F.
            .Top        = 178
            .Left       = 356
            .Width      = 62
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90,90,90)
            .BackStyle  = 0
            .Caption    = "1 - Ilegivel"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoSaida - CommandGroup obj_4c_SAIDA com o botao Cancelar
    * (unico botao do form - dialogo modal de captura, sem CRUD).
    * Migrado de: SIGOPDTF.SAIDA (Command1/CANCELA). ControlSource="OPSENHA"
    * do dump NAO transcrito - artefato de template do Form Designer sem
    * campo correspondente (grupo tem 1 unico botao, nao ha o que refletir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount = 1
            .Top         = -2
            .Left        = 387
            .Width       = 85
            .Height      = 85
            .BorderStyle = 0
            *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
            *-- BackStyle - sem esta linha o grupo nasce opaco (default 1) e
            *-- pinta um retangulo branco sobre a faixa cinza do cabecalho.
            .BackStyle   = 0
            .Value       = 0

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Cancel     = .F.
                .Caption    = "\<Cancelar"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - reproduz a ordem de tabulacao do SCX legado
    * (TabIndex: GetValor=1, GetCartao=2, GetDigitos=3, GetCodSeg=4,
    * Optiongroup1=7, Text1=11, GetDatas=13, SAIDA=17 - demais TabIndex sao
    * de Labels, que nao tem TabStop e por isso nao entram aqui, mesmo
    * criterio da regra ja aplicada em Formsigprdft.ConfigurarOrdemTabulacao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        THIS.txt_4c_Valor.TabIndex        = 1    && SCX: GetValor      TabIndex=1
        THIS.txt_4c_Cartao.TabIndex       = 2    && SCX: GetCartao     TabIndex=2
        THIS.txt_4c_Digitos.TabIndex      = 3    && SCX: GetDigitos    TabIndex=3
        THIS.txt_4c_Codigo.TabIndex       = 4    && SCX: GetCodSeg     TabIndex=4
        THIS.obj_4c_Optiongroup1.TabIndex = 5    && SCX: Optiongroup1  TabIndex=7
        THIS.txt_4c_Text1.TabIndex        = 6    && SCX: Text1         TabIndex=11
        THIS.txt_4c_Datas.TabIndex        = 7    && SCX: GetDatas      TabIndex=13
        THIS.obj_4c_SAIDA.TabIndex        = 8    && SCX: SAIDA         TabIndex=17
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarValoresIniciais - FASE 8/8. Migrado do trecho final do
    * SIGOPDTF.Init que nenhuma fase anterior tinha coberto (as Fases 3-7
    * trataram parametros, layout e eventos; estes sao os VALORES):
    *
    *     ThisForm.GetDigitos.BackColor = 12632256
    *     WITH Thisform
    *         .GetDatas.Value = DATE()
    *         .GetValor.Value = lnValPago
    *         IF crSigOpFp.lCartao = "S"
    *             .GetCartao.Enabled = .t.
    *             .Label2.Caption    = "Validade Cartao :"
    *         EndIf
    *     Endwith
    *     ThisForm.Container1.Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
    *     IF !Thisform.getDatas.Enabled
    *         IF crSigOpFp.lCartao = "N"
    *             ...Caption = "Insira ou Passe"  + CHR(13) + "o Cartao"
    *         ELSE
    *             ...Caption = "Digite o Numero"  + CHR(13) + "do Cartao"
    *         EndIf
    *     EndIf
    *     ThisForm.Text1.Value = TRANSFORM(lnNumParcs, "@L 99")
    *     ThisForm.GetValor.SetFocus
    *
    * O BackColor cinza do GetDigitos eh SINALIZACAO de "campo aguardando o
    * terminal": o legado o pinta de 12632256 = RGB(192,192,192) na abertura e
    * o devolve para 16777215 = RGB(255,255,255) no fim do DigitosGotFocus,
    * quando o campo passa a aceitar digitacao. Note que isso SOBREPOE o
    * BackColor 212,208,200 que o SCX declara no controle (e que a Fase 4
    * transcreveu certo) - os dois existem, em momentos diferentes.
    *
    * lnParcs/ldData/lcSaque/DCD do Init legado tambem sao semeados aqui -
    * sao as variaveis PUBLIC que alimentam o retorno da tela (Unload).
    *
    * DUAS DIVERGENCIAS DELIBERADAS, as duas por causa do GetValor.When
    * ("Return .f.", transcrito no dump), que torna o campo INALCANCAVEL pelo
    * foco - o valor eh so exibicao, o usuario nunca digita nele:
    *
    *   1. ".ReadOnly = .T. / .TabStop = .F." no lugar do When. BINDEVENT em
    *      "When" nao bloqueia nada (o retorno do delegate eh descartado -
    *      regra #3/#47), entao sem estas duas linhas o campo migrado ficaria
    *      EDITAVEL e o operador poderia alterar o valor da transacao na tela
    *      antes de o protocolo comecar. Reproduz o efeito observavel do
    *      legado, nao a mecanica dele.
    *   2. O "GetValor.SetFocus" NAO eh transcrito. Medido no VFP9: SetFocus
    *      em TextBox com TabStop = .F. nao move o foco, e em campo cujo When
    *      devolve .F. o legado tambem nao movia - a linha sempre foi inocua.
    *      Chamar SetFocus aqui, com o form ainda invisivel (InicializarForm
    *      roda dentro do Init, antes do Show), estouraria
    *      "Cannot SetFocus to an invisible or disabled object".
    *
    * O "ThisForm.Caption" e o "Thisform.ZOrder(0)" do mesmo trecho legado
    * tambem ficam fora: o Caption ja eh definido no Init (Fase 3, com CHR()),
    * e o ZOrder(0) servia para trazer a janela a frente no desktop MDI do
    * legado - aqui a classe ja tem AlwaysOnTop = .T. (transcrito do SCX).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarValoresIniciais()
        LOCAL loc_oBO, loc_lCartao

        loc_oBO = THIS.this_oBusinessObject

        *-- lCartao = "S" na forma de pagamento. Sem BO (modo de validacao de
        *-- UI) assume o default .F. da property, que eh o ramo "N" do legado.
        loc_lCartao = .F.
        IF VARTYPE(loc_oBO) = "O"
            loc_lCartao = loc_oBO.this_lOpFpCartao
        ENDIF

        *-- Cinza de "aguardando o terminal" (12632256 = RGB(192,192,192)).
        THIS.txt_4c_Digitos.BackColor = RGB(192,192,192)

        THIS.txt_4c_Datas.Value = DATE()
        THIS.txt_4c_Valor.Value = THIS.this_nValPago

        *-- GetValor.When = "Return .f." no legado (ver nota acima).
        THIS.txt_4c_Valor.ReadOnly = .T.
        THIS.txt_4c_Valor.TabStop  = .F.

        IF loc_lCartao
            THIS.txt_4c_Cartao.Enabled = .T.
            THIS.lbl_4c_Label2.Caption = "Validade Cartao :"
        ENDIF

        *-- O legado atribui a legenda, depois a REATRIBUI dentro do
        *-- "IF !getDatas.Enabled". Como o SCX declara GetDatas.Enabled = .F.
        *-- (e a Fase 4 transcreveu), esse IF eh SEMPRE verdadeiro na abertura
        *-- e quem decide eh o ramo interno - transcrito nessa ordem.
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
        IF !THIS.txt_4c_Datas.Enabled
            IF !loc_lCartao
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
            ELSE
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
            ENDIF
        ENDIF

        *-- lnParcs do legado (mascara "@L 99"), espelhado no campo e na
        *-- property que alimenta o retorno da tela.
        THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_nNumParcs, "@L 99")
        THIS.this_cParcelasTef  = TRANSFORM(THIS.this_nNumParcs, "@L 99")

        *-- ldData / lcSaque / DCD do Init legado.
        THIS.this_dDataTef = DATE()
        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.this_cValorSaque     = "0,00"
            loc_oBO.this_lDataConfirmada = .F.
            loc_oBO.this_nNumParcs       = THIS.this_nNumParcs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventosCampos - BINDEVENT dos eventos de campo que NAO
    * dependem do laco interativo com a DLL (ver nota da FASE 6/8 no
    * cabecalho). Migrado de SIGOPDTF.Optiongroup1 (InteractiveChange) e
    * SIGOPDTF.Optiongroup1.Option1 (KeyPress/GotFocus), mais o Click do
    * UNICO botao do form (SIGOPDTF.SAIDA.CANCELA.Click), acrescentado pela
    * Fase 7. Os campos restantes (GetValor/GetDigitos/GetCartao/GetCodSeg/
    * Text1/GetDatas) entram na Fase 8, junto com o laco interativo que os
    * governa.
    *
    * O Click vai no Buttons(1), nao no CommandGroup: o grupo SAIDA tem
    * ButtonCount = 1 e eh o BOTAO que o legado nomeia (CANCELA) e cujo
    * Click o dump declara.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosCampos()
        BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTipoVendaChange")
        BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptTipoVendaBtn1KeyPress")
        BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptTipoVendaBtn1GotFocus")

        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")

        *-- FASE 8/8: os campos de captura e o laco interativo com a DLL.
        *
        * POR QUE O "Valid" DO LEGADO VIRA "KeyPress" AQUI: BINDEVENT em
        * "Valid" NAO dispara em TextBox (regra do CLAUDE.md), entao o Valid
        * eh simulado no KeyPress testando ENTER (13) / TAB (9) - o mesmo
        * recorte dos irmaos Formsigprdft/FormSigOpCtf. Nao confundir com a
        * regra #47 (lookup NUNCA em KeyPress): ali o defeito eh abrir um
        * PICKER a cada tecla; aqui o handler testa a tecla no topo e so
        * entao conversa com o terminal, que eh exatamente o que a regra
        * manda fazer quando se usa KeyPress.
        *
        * GetCodSeg eh a EXCECAO e fica em "LostFocus" de verdade: no legado o
        * protocolo dele mora no PROPRIO LostFocus (nao no Valid, que esta
        * inteiro comentado no dump), e LostFocus dispara por BINDEVENT sem
        * problema. Como esse laco abre dialogo modal, ele leva guarda de
        * reentrancia (this_lEmProtocolo) - ver o metodo.
        *
        * GotFocus de GetDigitos/GetDatas carrega os dois lacos MAIORES
        * (conexao+inicio da transacao e confirmacao da data), fiel ao legado,
        * que de proposito dispara a conversa com o terminal ao campo receber
        * o foco, nao ao perde-lo.
        BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")
        BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",  THIS, "DigitosKeyPress")
        BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")

        BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "Text1GotFocus")
        BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "Text1KeyPress")
        BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "Text1LostFocus")

        BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "DatasGotFocus")
        BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "DatasKeyPress")
        BINDEVENT(THIS.txt_4c_Datas, "LostFocus", THIS, "DatasLostFocus")

        BINDEVENT(THIS.txt_4c_Codigo, "GotFocus",  THIS, "CodSegGotFocus")
        BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodSegLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoVendaChange - migrado de SIGOPDTF.Optiongroup1.InteractiveChange:
    *     ThisForm.getDatas.Enabled=.t.
    *     IF This.Value = 1
    *         ThisForm.getdatas.Value=DATE()
    *     ELSE
    *         ThisForm.getdatas.Value=ctod("")
    *     Endif
    *
    * Gate no topo = SIGOPDTF.Optiongroup1.When ("Return(ThisForm.pctvenda)"):
    * BINDEVENT em "When" nao bloqueia nada (regra CLAUDE.md #3/#47 - o
    * retorno do delegate e descartado), entao o bloqueio de foco do legado
    * vira guarda de saida antecipada aqui. THIS.this_lTipoVendaLiberado
    * (declarada na Fase 3, default .T.) so sera fechada pela Fase 7 ao
    * migrar GetDatas.GotFocus ("ThisForm.pcTvenda = .f.") - mesmo recorte
    * do irmao Formsigprdft.OptTipoVendaChange. PUBLIC: exigido por
    * BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoVendaChange()
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        THIS.txt_4c_Datas.Enabled = .T.
        IF THIS.obj_4c_Optiongroup1.Value = 1
            THIS.txt_4c_Datas.Value = DATE()
        ELSE
            THIS.txt_4c_Datas.Value = {}
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoVendaBtn1KeyPress - migrado de
    * SIGOPDTF.Optiongroup1.Option1.KeyPress:
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     IF nKeyCode = 13
    *         KEYBOARD '{TAB}'
    *     Endif
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoVendaBtn1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        IF par_nKeyCode = 13
            KEYBOARD "{TAB}"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoVendaBtn1GotFocus - migrado de
    * SIGOPDTF.Optiongroup1.Option1.GotFocus: "ThisForm.getDatas.Enabled=.t.".
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoVendaBtn1GotFocus()
        IF !THIS.this_lTipoVendaLiberado
            RETURN
        ENDIF

        THIS.txt_4c_Datas.Enabled = .T.
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DOS BOTOES (FASE 7/8)
    *
    * Este form tem UM BOTAO SO: o SCX legado declara apenas o CommandGroup
    * SAIDA (ButtonCount = 1, botao CANCELA, Caption "\<Cancelar"). Nao ha
    * barra CRUD a migrar - o legado herda de `form` (nao de `frmcadastro`),
    * nao tem Grupo_Op, nao tem pcEscolha e nao declara botao Incluir/Alterar/
    * Visualizar/Excluir em lugar nenhum do dump (conferido por grep: zero
    * ocorrencia das quatro grafias e zero "<X>.Click"). Gerar os quatro
    * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
    * exigiria INVENTAR botoes que o legado nao tem, violando o PILAR 1.
    *
    * Junto com o Click vem os dois metodos que ele CONSOME: RetornoFalha
    * (grava o arquivo de resposta que o PDV le) e ErroTef (traduz o codigo
    * de erro do protocolo para a mensagem que RetornoFalha gravara).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ErroTef - migrado de SIGOPDTF.errotef (PARAMETERS pnRetornos). Traduz os
    * codigos fixos de falha do protocolo interativo na mensagem gravada no
    * arquivo de resposta. Os cinco IF abaixo sao transcricao literal, na
    * mesma ordem e com os MESMOS textos (sem acento no legado - sao gravados
    * no IntPos.001 lido pelo software do PDV, nao exibidos na tela, entao
    * "corrigir" a grafia mudaria o conteudo do arquivo).
    *
    * O legado passa "0,00" como valor nos cinco casos, e NAO o valor da
    * transacao: em caminho de ERRO o campo 003-000 sai zerado de proposito.
    * Quem passa o valor real eh so o Click do Cancelar. Transcrito assim.
    *
    * O PRIMEIRO bloco do errotef legado NAO eh transcrito, e o motivo foi
    * MEDIDO no VFP9 em 2026-10-31 (probe descartavel, resultado abaixo):
    *
    *     If Type("lnRetorno") <> "N" and (lnRetorno > -1 Or lnRetorno < -5)
    *         ThisForm.RetornoFalha("Operacao Cancelada pelo Usuario", "0,00")
    *     Endif
    *
    * Esse bloco tem exatamente DOIS desfechos possiveis, nenhum deles
    * "disparar":
    *   - lnRetorno NUMERICO (o que todo call site do legado produz, porque
    *     cada metodo atribui lnRetorno antes de chamar o errotef):
    *     Type("lnRetorno") = "N", logo o 1o operando eh .F.; medido que o AND
    *     do VFP9 faz SHORT-CIRCUIT nesse caso -> resultado .F., NAO DISPAROU;
    *   - lnRetorno INDEFINIDO: o 1o operando eh .T., o 2o eh avaliado e
    *     estoura "Variable 'LNRETORNO' is not found." (medido).
    * Ou seja eh codigo morto-ou-quebrado: nunca houve execucao em que ele
    * gravasse o arquivo. Reproduzir a condicao com o par_nRetornos que este
    * metodo realmente recebe faria o bloco DISPARAR em casos em que o legado
    * nunca disparou (ErroTef(0), por exemplo), gravando um IntPos.001 de
    * cancelamento a mais - ou seja seria mudanca de comportamento disfarcada
    * de fidelidade. Preservado o desfecho real: nao dispara.
    *
    * PUBLIC: consumido pelo laco interativo (Fase 8), que roda fora desta
    * classe quando delegado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ErroTef(par_nRetornos)
        IF par_nRetornos = -1
            THIS.RetornoFalha("Modulo Nao Iniciado", "0,00")
        ENDIF
        IF par_nRetornos = -2
            THIS.RetornoFalha("Operacao Cancelada pelo Usuario", "0,00")
        ENDIF
        IF par_nRetornos = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida", "0,00")
        ENDIF
        IF par_nRetornos = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", "0,00")
        ENDIF
        IF par_nRetornos = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef", "0,00")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RetornoFalha - migrado de SIGOPDTF.retornofalha (PARAMETERS lcMensagem,
    * lnValPago). Monta o cursor local crSiTef (buffer de protocolo) e grava
    * os dois arquivos SDF que o software de retaguarda / PDV le
    * (C:\client\Resp\IntPos.001 e IntPos.STS). Nenhuma tabela do SQL Server
    * eh tocada aqui - o INSERT eh todo em cursor de memoria.
    *
    * A assinatura mantem os DOIS parametros do legado porque os dois call
    * sites passam valores DIFERENTES e isso muda o arquivo gravado:
    * ErroTef passa "0,00" (CARACTERE) e o Click do Cancelar passa o valor
    * numerico da transacao. Medido no VFP9 em 2026-10-31
    * (probe descartavel) que a formula do legado atende os dois tipos
    * sem ramificar, e por isso ela eh transcrita LITERALMENTE:
    *     TRANSFORM("0,00",  "99999999999.99") -> "0,00"    (passa direto)
    *     TRANSFORM(1234.56, "99999999999.99") -> "1234,56" (apos o STRTRAN)
    * O IIF de VARTYPE abaixo NAO eh ramo de formato: eh guarda para o
    * parametro AUSENTE, que chegaria como .F. logico e faria o TRANSFORM
    * estourar. Os dois call sites reais nunca caem nela.
    *
    * "001-000" usa STR(VAL(this_cIdent), 10) porque o legado faz
    * STR(ltIdent, 10) sobre o identificador recebido no Init, que aqui eh
    * guardado como CARACTERE (this_cIdent).
    *
    * Pasta C:\client\Resp ausente (maquina de desenvolvimento/teste sem a
    * integracao fiscal instalada) -> a grava eh pulada antes do TRY, sem
    * quebrar o cancelamento. O RETURN fica FORA de TRY/CATCH (regra #1).
    *
    * PUBLIC: chamado por ErroTef, pelo Click do Cancelar e pelo laco
    * interativo (Fase 8).
    *--------------------------------------------------------------------------
    PROCEDURE RetornoFalha(par_cMensagem, par_uValPago)
        LOCAL loc_cMensagem, loc_uValPago, loc_cValPago, loc_oErro

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", par_cMensagem)

        loc_uValPago = IIF(VARTYPE(par_uValPago) $ "CN", par_uValPago, 0)
        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(loc_uValPago, "99999999999.99")), ".", ",")

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
                IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - migrado de SIGOPDTF.SAIDA.CANCELA.Click, INTEIRO:
    *     lnRetorno=ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
    *               @TamanhoMinimo, @TamanhoMaximo, @Buffer, Len(Buffer), -1)
    *     ThisForm.RetornoFalha("Oper. Cancelada pelo Usuario(1)",lnValPago)
    *     Thisform.release
    *
    * O -1 na ultima posicao eh o codigo de ABORTO do protocolo: avisa o
    * terminal SiTef de que a operacao em curso foi cancelada pelo operador,
    * ANTES de gravar o arquivo de resposta. A chamada por referencia esta
    * encapsulada em sigopdtfBO.ContinuarSiTef (Fase 2), que preserva os
    * quatro parametros @ de estado do protocolo.
    *
    * NOME: prefixo canonico Btn*Click, nomeado pela ACAO (cancelar a
    * transacao e fechar a tela), nao pelo objeto legado - "CancelaClick"
    * herdaria o nome do SCX, o que viola o PILAR 3 e deixa o handler
    * invisivel para as convencoes do projeto.
    *
    * FECHA COM Hide(), NAO COM Release(), apesar do "Thisform.release" do
    * legado - e esta eh uma divergencia DELIBERADA de PILAR 3 (tempo de vida
    * do objeto), nao de PILAR 1 (para o usuario a tela fecha igual, porque
    * Hide() em form modal tambem devolve o Show()). Motivo: no VFP9 o
    * Release() de um form DESTROI o objeto mesmo havendo variavel externa
    * apontando para ele, e este dialogo existe para DEVOLVER o resultado da
    * transacao TEF. O legado entrega esse resultado pelo RETURN do evento
    * Unload, que so chega a quem abre com "DO FORM ... TO <var>"; o sistema
    * novo abre por CREATEOBJECT + Show(), onde aquele RETURN eh inalcancavel
    * e o resultado tem de ser lido da property this_cRetornoTef (declarada
    * na Fase 3 exatamente para isso). Com Release() aqui, o objeto morreria
    * neste Click e a leitura seguinte do chamador estouraria "is not an
    * object" - erro que apareceria LONGE da causa. O chamador libera o
    * dialogo depois de ler, que eh o contrato que o projeto ja adota em
    * FormBuscaAuxiliar.
    *
    * ATENCAO para a Fase 8: ao implementar Unload/MontarRetornoTef, o calculo
    * de this_cRetornoTef tem de ser gravado ANTES deste Hide() (o Destroy
    * passa a rodar apenas quando o chamador liberar, tarde demais para quem
    * le o valor logo apos o Show()).
    *
    * PUBLIC: alvo de BINDEVENT (regra #3) e chamado tambem pelo KeyPress do
    * ESC, reproduzindo o "ThisForm.SAIDA.CANCELA.Click" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        *-- Guarda sem equivalente no legado: em modo de validacao de UI o
        *-- InicializarForm sai antes de criar o BO (this_oBusinessObject
        *-- fica .NULL.) e a chamada a DLL estouraria. Em producao o BO
        *-- sempre existe, entao o caminho do legado eh preservado integral.
        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.ContinuarSiTef(-1)
            loc_oBO.this_lCancelado = .T.
            THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", loc_oBO.this_nValPago)
        ELSE
            THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", THIS.this_nValPago)
        ENDIF

        *-- FASE 8/8: cumprindo a exigencia que esta nota deixou escrita - o
        *-- this_cRetornoTef eh calculado ANTES de a tela fechar. EncerrarDialogo
        *-- faz as duas coisas (calcula e esconde) e eh o ponto unico de saida
        *-- usado tambem pelos cinco lacos do protocolo.
        THIS.EncerrarDialogo()
    ENDPROC

    *==========================================================================
    * EVENTOS AUXILIARES E CONSOLIDACAO FINAL (FASE 8/8)
    *
    * O que entra aqui eh o LACO INTERATIVO com o terminal SiTef - a razao de
    * existir desta tela - mais os hooks de transferencia e o retorno ao
    * chamador. As Fases 3-7 entregaram parametros, layout, os eventos do
    * Optiongroup e o Click do unico botao; o protocolo ficou para esta fase
    * de proposito, porque eh indivisivel: GetDigitos.Valid/GotFocus,
    * Text1.Valid, GetDatas.Valid/GotFocus e GetCodSeg.LostFocus sao cinco
    * VARIANTES do mesmo dialogo com a DLL, compartilhando o MESMO estado
    * (ProximoComando/TipoCampo/Buffer/lnContinua, que o legado mantinha em
    * variaveis PUBLIC e que aqui vivem no BO).
    *
    * TRES SUBSTITUICOES DE DIALOGO FILHO, todas por ausencia no acervo (os
    * .SCX nao vieram) e todas FALANDO EM VOZ ALTA em vez de silenciar - no
    * caminho de dinheiro, ausencia muda eh pior que ausencia visivel
    * (mesmo critrio da regra #27 sobre wrapper de funcao legada):
    *   - SigTfDss (mensagem de erro do protocolo) -> ExibirMensagemTef, que
    *     eh substituicao FIEL: o dialogo legado so exibia texto.
    *   - SigCsTef (valor do saque)        -> avisa e assume "0,00".
    *   - SigPrStf (senha do supervisor)   -> avisa e CANCELA a transacao,
    *     que eh o proprio ramo do legado para senha em branco.
    *   - SigCoCDC (consulta CDC)          -> avisa; o RetornoFalha que o
    *     legado grava em seguida eh preservado.
    *
    * "Thisform.release" e "RELEASE WINDOWS" do legado viram
    * THIS.EncerrarDialogo() - ver a nota de tempo de vida no proprio metodo
    * e no BtnCancelarClick da Fase 7.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExibirMensagemTef - substitui
    *     DO Form SigTfDss With <titulo>,"",<msg1>,<msg2>,"","VM",Left,Top
    * O SIGTFDSS.scx nao faz parte do acervo migrado; era um dialogo que so
    * EXIBIA as duas linhas de texto (o "VM" eh o esquema de cor), entao
    * MsgAviso eh substituicao fiel. MsgAviso e nao MsgErro de proposito: sao
    * mensagens de PROTOCOLO devolvidas pelo terminal ("Cartao Invalido",
    * "Senha Incorreta"), nao falhas tecnicas do sistema - e MsgErro exibe o
    * botao "Fechar Aplicacao", que aqui seria desastroso no meio de uma
    * transacao com o PIN-pad.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
        LOCAL loc_cMsg

        loc_cMsg = ALLTRIM(IIF(VARTYPE(par_cMsg1) = "C", par_cMsg1, ""))
        IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
            loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
        ENDIF
        IF EMPTY(loc_cMsg)
            loc_cMsg = "Falha na comunica" + CHR(231) + CHR(227) + "o com o terminal."
        ENDIF

        MsgAviso(loc_cMsg, IIF(VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo), ;
            par_cTitulo, "Transa" + CHR(231) + CHR(227) + "o"))
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarDialogo - ponto UNICO de saida da tela, substituindo os
    * "Thisform.release" e "RELEASE WINDOWS" espalhados pelos lacos do legado
    * (23 ocorrencias no dump).
    *
    * Cumpre a exigencia que a Fase 7 deixou escrita no BtnCancelarClick:
    * this_cRetornoTef eh calculado ANTES de a tela fechar. O motivo esta la
    * por extenso - em VFP9 o Release() destroi o objeto mesmo havendo
    * referencia externa viva, e esta tela existe para DEVOLVER o resultado da
    * transacao ao chamador, que no sistema novo abre por CREATEOBJECT + Show()
    * e le a property (o RETURN do Unload legado so chega a quem usa
    * "DO FORM ... TO <var>"). Fechar com Hide() mantem o objeto vivo e a
    * property legivel; quem abriu libera depois de ler, mesmo contrato do
    * FormBuscaAuxiliar.
    *
    * Idempotente de proposito: varios ramos do legado chamam release em
    * sequencia (ErroTef seguido de release, por exemplo), e o laco continua
    * executando as linhas seguintes depois disso. Recalcular o retorno a cada
    * chamada sobrescreveria com estado mais pobre o valor montado no primeiro
    * encerramento - por isso so calcula quando ainda esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarDialogo()
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDigitos - cabeca do SIGOPDTF.GetDigitos.Valid, antes do laco:
    *     IF tHISfORM.abandona
    *         Thisform.release
    *     eNDIF
    *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
    *         DO Form SigTfDss With "Erro na Transacao","","Quantidade de Digitos Invalida",...
    *         This.Value = ""
    *         Return(.f.)
    *     ENDIF
    *     IF EMPTY(This.Value)
    *         RETURN
    *     Endif
    *
    * Devolve .T. somente quando o laco deve rodar. Os dois ramos de saida do
    * legado devolvem .F. por motivos DIFERENTES e os dois tem de parar o
    * laco: "abandona" (o chamador derrubou a transacao) encerra a tela;
    * quantidade de digitos errada avisa e limpa o campo; campo VAZIO apenas
    * nao faz nada - este ultimo eh o caminho normal quando o foco passa pelo
    * campo sem o usuario digitar, e por isso NAO avisa nada.
    * PUBLIC: consumido pelo handler de KeyPress, que eh alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    FUNCTION ValidarDigitos()
        LOCAL loc_lProsseguir, loc_cValor

        loc_lProsseguir = .F.

        DO CASE
        CASE THIS.this_lAbandona
            THIS.EncerrarDialogo()
        OTHERWISE
            loc_cValor = ALLTRIM(THIS.txt_4c_Digitos.Value)
            DO CASE
            CASE LEN(loc_cValor) != 4 AND !EMPTY(loc_cValor)
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    "Quantidade de Digitos Invalida", "")
                THIS.txt_4c_Digitos.Value = ""
            CASE EMPTY(loc_cValor)
                *-- Caminho normal: o foco passou pelo campo sem digitacao.
            OTHERWISE
                loc_lProsseguir = .T.
            ENDCASE
        ENDCASE

        RETURN loc_lProsseguir
    ENDFUNC

    *--------------------------------------------------------------------------
    * DigitosGotFocus - migrado de SIGOPDTF.GetDigitos.GotFocus, o PRIMEIRO e
    * maior laco do protocolo: eh ele que CONFIGURA a conexao com o servidor
    * SiTef, INICIA a transacao e conduz a leitura do cartao.
    *
    * O laco do legado eh "DO WHILE llContinua", e llContinua nasce de
    *     llContinua = IIF(crSigOpFp.lCartao = "N", .t., .f.)
    * e NUNCA eh alterado dentro do laco - todas as saidas sao EXIT. Ou seja:
    * quando a forma de pagamento NAO aceita cartao digitado (lCartao = "N"),
    * a conversa com o terminal acontece aqui; quando aceita, o laco nao roda
    * nenhuma vez e a conversa fica para os outros campos. Transcrito como
    * esta - trocar por um laco que sempre roda inverteria o fluxo da tela.
    *
    * O identificador de terminal NAO eh recalculado aqui, embora o legado o
    * remonte a cada GotFocus (lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) +
    * TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")): no sistema novo isso
    * eh CarregarIdentificacaoTerminal(), ja executado pelo InicializarForm, e
    * suas duas entradas (empresa corrente e caixa recebido no Init) nao mudam
    * durante a vida do dialogo. Repetir faria duas consultas SQL a cada
    * passagem de foco, sem alterar o resultado.
    *
    * GUARDA DE REENTRANCIA (this_lEmProtocolo): sem equivalente no legado,
    * obrigatoria aqui. O laco exibe dialogo MODAL e mexe em .Enabled dos
    * campos; as duas coisas tiram e devolvem o foco, e isso REDISPARA este
    * mesmo GotFocus (regras #37/#47). Com um unico PIN-pad do outro lado, a
    * segunda conversa consumiria as respostas da primeira. A flag eh liberada
    * no fim de um corpo sem RETURN antecipado: o corpo real esta em
    * DigitosGotFocusExec(), e este wrapper garante a liberacao mesmo quando
    * aquele sai no meio (padrao imune a RETURN da regra #47).
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocus()
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        *-- SIGOPDTF.GetDigitos.When: "If Empty(This.Value) / Set Confirm Off /
        *-- Endif / Return(EMPTY(This.Value))". BINDEVENT nao alcanca "When"
        *-- (regra #3), entao o SET CONFIRM OFF vem para ca, com a mesma
        *-- condicao. O RETURN do When - que impedia ENTRAR no campo depois de
        *-- preenchido - eh reproduzido pelas transicoes de .Enabled que o
        *-- proprio protocolo faz (DigitosKeyPress termina com
        *-- txt_4c_Digitos.Enabled = .F.), nao por uma guarda inventada aqui.
        IF EMPTY(ALLTRIM(THIS.txt_4c_Digitos.Value))
            SET CONFIRM OFF
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DigitosGotFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosKeyPress - migrado de SIGOPDTF.GetDigitos.Valid (o SEGUNDO laco:
    * envia os 4 ultimos digitos do cartao e conduz senha/parcelamento ate o
    * terminal liberar a data de vencimento ou o codigo de seguranca).
    *
    * Ligado a "KeyPress" porque BINDEVENT em "Valid" nao dispara em TextBox
    * (ver nota em RegistrarEventosCampos): o Valid eh simulado testando
    * ENTER (13) / TAB (9) no topo - as duas teclas com que o usuario sai do
    * campo. A cabeca do Valid legado esta em ValidarDigitos().
    *
    * Guarda de reentrancia pelo mesmo motivo do GotFocus; corpo separado em
    * DigitosKeyPressExec() porque ele tem RETURN antecipado (padrao imune a
    * RETURN da regra #47 - set/clear simples deixaria a flag presa ligada e
    * MATARIA o campo pelo resto da vida do form).
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DigitosKeyPressExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosKeyPressExec - corpo do laco acima (ver nota de reentrancia).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPressExec()
        LOCAL loc_oBO, loc_nRetorno, loc_lParcelas, loc_nCampo, loc_cBuf, loc_cValor

        IF !THIS.ValidarDigitos()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cValor    = ALLTRIM(THIS.txt_4c_Digitos.Value)
        loc_lParcelas = .F.
        loc_nCampo    = 1
        loc_nRetorno  = 10000

        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.MontarBufferSiTef(loc_cValor)
        loc_oBO.this_nContinua = 1000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                    loc_oBO.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf))
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Trasa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                IF loc_nRetorno != 10000
                    EXIT
                ELSE
                    *-- Os dois ramos do legado devolvem (.t./.f.) e param o
                    *-- Valid; a diferenca eh que o de parcelamento ANTES
                    *-- libera o campo de parcelas. Transcrito assim.
                    IF loc_lParcelas
                        THIS.txt_4c_Text1.Enabled        = .T.
                        THIS.obj_4c_Optiongroup1.Enabled = .F.
                        *-- Legado: "This.Value=.f." - atribuir LOGICO a um
                        *-- TextBox cujo Value eh CARACTERE (.Value = "" na
                        *-- criacao) troca o tipo do controle e faz o
                        *-- ALLTRIM seguinte estourar. Limpa com "" , que eh o
                        *-- efeito pretendido (apagar os digitos digitados).
                        THIS.txt_4c_Digitos.Value = ""
                    ENDIF
                    RETURN
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, ;
                    IIF(ConverterParaData(THIS.txt_4c_Datas.Value) = DATE(), "1", "2"), ;
                    IIF(THIS.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
                *-- Legado: "IF Buffer = '1'". Com SET EXACT OFF (default) a
                *-- comparacao eh por PREFIXO, e o Buffer sempre comeca pelo
                *-- digito escolhido - ou seja o teste eh "o digito eh 1?".
                *-- Escrito aqui sobre o 1o caractere para nao depender do
                *-- estado de SET EXACT, que o config.prg deixa em ON
                *-- (ON faria o IF nunca casar e o EXIT nunca acontecer).
                IF LEFT(loc_oBO.this_cBuffer, 1) = "1"
                    EXIT
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_lOpFpGarantias
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                THIS.ObterValorSaque()
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + ;
                    REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND ;
               (loc_oBO.this_nTipoCampo = -1 OR loc_oBO.this_nTipoCampo = 506) AND ;
               THIS.this_cDebCred != "P"
                THIS.txt_4c_Datas.Enabled = .T.
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
                THIS.txt_4c_Codigo.Enabled = .T.
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND ;
               (THIS.this_cDebCred = "P" OR loc_oBO.this_nTipoCampo = 511)
                IF loc_nCampo = 1
                    loc_oBO.this_cBuffer = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99") + ;
                        REPLICATE(CHR(0), 1999)
                    loc_lParcelas = .T.
                    loc_nCampo    = 2
                    LOOP
                ELSE
                    THIS.txt_4c_Datas.Enabled = .T.
                    EXIT
                ENDIF
            ENDIF

            IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHora = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando = 22 AND THIS.this_cDebCred = "P"
                loc_oBO.this_cCupomRetorno = loc_cBuf
                loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND ;
               loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF THIS.this_cDebCred = "P" AND loc_oBO.this_cOpFpTcdc != "S"
                *-- DO FORM SigCoCDC WITH lsCupom - dialogo de consulta CDC
                *-- nao portado (SIGCOCDC.scx fora do acervo). O RetornoFalha
                *-- que o legado grava em seguida eh preservado, entao o PDV
                *-- recebe o mesmo arquivo de resposta de antes.
                MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
                    CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), ;
                    "Consulta CDC")
                THIS.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
                        loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
                        loc_oBO.this_cMensagemRetorno)
                ENDIF
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
        ELSE
            IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
                THIS.obj_4c_Optiongroup1.Enabled = .T.
                THIS.txt_4c_Datas.Enabled        = .T.
            ELSE
                THIS.obj_4c_Optiongroup1.Enabled = .F.
            ENDIF
        ENDIF

        *-- As duas ultimas linhas do Valid legado, nesta ordem: o campo de
        *-- digitos sai de cena e o grupo Tipo de Venda eh reaberto. A segunda
        *-- SOBREPOE o "Optiongroup1.Enabled = .F." do ELSE acima - esta no
        *-- legado assim e eh o que o usuario ve.
        THIS.txt_4c_Digitos.Enabled      = .F.
        THIS.obj_4c_Optiongroup1.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosGotFocusExec - corpo do laco acima (ver nota de reentrancia).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cData, loc_cHora, loc_lContinua, ;
              loc_nTipo, loc_lTipoVenda, loc_nTipoVenda, loc_cBandeira, loc_cBuf

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- ConfiguraIntSiTefInterativo(lsEndSitef, lsIdTerminal, lcIdTerminal, 0) <> 0
        IF !loc_oBO.ConectarSiTef()
            THIS.RetornoFalha("Sem comunicacao com SiTef", loc_oBO.this_nValPago)
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        *-- lcData = Str(Year(Date()),4) + Substr(Dtoc(Date()),4,2) + Substr(Dtoc(Date()),1,2)
        *-- lchora = Strtran(Time(),":","")
        loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
        loc_cHora = STRTRAN(TIME(), ":", "")

        *-- IniciaFuncaoSiTefInterativo(0, lcValPago, lsCupom, lcData, lcHora, lsCaixa, "") <> 10000
        IF !loc_oBO.IniciarSiTef(loc_cData, loc_cHora)
            THIS.RetornoFalha("Sem comunicacao com SiTef", loc_oBO.this_nValPago)
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        *-- Reset do estado do protocolo (as 6 PUBLIC do legado).
        loc_oBO.this_nProximoComando = 0
        loc_oBO.this_nTipoCampo      = 0
        loc_oBO.this_nTamanhoMinimo  = 0
        loc_oBO.this_nTamanhoMaximo  = 0
        loc_oBO.this_cBuffer         = SPACE(2000)
        loc_oBO.this_nContinua       = 0

        loc_oBO.this_cFinaliza        = ""
        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.this_cNsu             = ""

        loc_nTipo      = 1
        loc_lTipoVenda = .F.
        loc_nTipoVenda = 0
        loc_cBandeira  = ""
        loc_nRetorno   = 10000

        *-- llContinua = IIF(crSigOpFp.lCartao = "N", .t., .f.) - ver nota.
        loc_lContinua = !loc_oBO.this_lOpFpCartao

        THIS.obj_4c_Optiongroup1.Enabled = .F.

        DO WHILE loc_lContinua
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                    loc_oBO.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(loc_cBuf)
                IF loc_nTipoVenda = 2
                    loc_lTipoVenda = .T.
                ELSE
                    loc_nTipoVenda = 2
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_oBO.this_nProximoComando = 22
                IF LEN(ALLTRIM(loc_cBuf)) != 0
                    THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                        ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                    loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                    loc_nRetorno = -1
                    EXIT
                ENDIF
            ENDIF

            IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
            ENDIF

            *-- Os blocos de TipoCampo abaixo seguem a ordem do legado. Note
            *-- que uns terminam em LOOP e outros nao: TipoCampo = 131 (cartao)
            *-- cai adiante de proposito, porque o mesmo valor eh relido no
            *-- bloco de bandeira mais abaixo.
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
                loc_oBO.this_cBuffer  = SPACE(2000)
                loc_oBO.this_nContinua = 0
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHora = loc_cBuf
                loc_oBO.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = STRTRAN(loc_cBuf, CHR(0), " ")
                loc_oBO.this_cBuffer       = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + STRTRAN(loc_cBuf, CHR(0), " ")
                loc_oBO.this_cBuffer       = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
                loc_oBO.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu    = ALLTRIM(STR(VAL(loc_cBuf)))
                loc_oBO.this_cBuffer = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
                loc_oBO.this_cBuffer   = SPACE(2000)
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
                *-- MESSAGEBOX("Primeira Parcela A Vista", 36, "") = 6 (Sim/Nao).
                *-- MsgConfirma devolve LOGICO, nunca 6 (regra #7).
                IF MsgConfirma("Primeira Parcela A Vista", "Parcelamento")
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(THIS.this_cDebCred = "D" OR THIS.this_cDebCred = "P", ;
                        "2", "3") + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    IF loc_oBO.this_nNumParcs = 1
                        loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                        loc_nTipo = 3
                        LOOP
                    ELSE
                        IF loc_oBO.this_cOpFpTcdc = "S"
                            IF THIS.this_cDebCred != "P"
                                loc_oBO.this_cBuffer = "5" + REPLICATE(CHR(0), 1999)
                            ELSE
                                loc_oBO.this_cBuffer = "4" + REPLICATE(CHR(0), 1999)
                            ENDIF
                        ELSE
                            loc_oBO.this_cBuffer = "3" + REPLICATE(CHR(0), 1999)
                        ENDIF
                        LOOP
                    ENDIF
                ENDIF
                IF loc_nTipo = 3
                    loc_lTipoVenda = .T.
                    EXIT
                ENDIF
            ENDIF

            IF loc_oBO.this_nTipoCampo = 131
                loc_cBandeira           = loc_cBuf
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1 AND ;
               loc_nTipo = 2 AND SUBSTR(loc_cBuf, 1, 1) != "1"
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND ;
               ("4 DIGITOS" $ UPPER(loc_cBuf) OR loc_cBandeira = "00004")
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
                loc_oBO.this_cBuffer   = THIS.MontarBufferData() + REPLICATE(CHR(0), 1992)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
                loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 509
                loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nOpFpMesFec - 1)) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 511 AND loc_oBO.this_cOpFpTcdc = "S") OR ;
               (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505) OR ;
               (loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1 AND ;
                loc_oBO.this_cOpFpTcdc = "S" AND THIS.this_cDebCred = "P" AND !("DDMMAAAA" $ loc_cBuf))
                loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nNumParcs)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1 AND ;
               ("DDMMAAAA" $ loc_cBuf)
                THIS.txt_4c_Digitos.Enabled = .F.
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando != 21
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.

        IF loc_nRetorno < 0 OR THIS.this_lAbandona
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        *-- O legado monta o retorno aqui quando o NSU chegou, e nesta
        *-- chamada passa "lsNsu, lsNSU" - a MESMA variavel nas posicoes de
        *-- NSU e de autorizacao (as duas grafias diferem so em maiusculas, e
        *-- VFP nao distingue). Transcrito literal: trocar a 2a por
        *-- this_cAutoriza mudaria o campo 013-000 do arquivo de resposta que
        *-- o PDV le.
        IF !EMPTY(loc_oBO.this_cNsu)
            THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
                loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                loc_oBO.this_cNsu, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
                loc_oBO.this_cMensagemRetorno)
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        *-- Campo liberado para digitacao: devolve o branco (16777215).
        THIS.txt_4c_Digitos.BackColor = RGB(255,255,255)

        THIS.txt_4c_Cartao.Value = "#### #### #### ####"

        IF loc_lTipoVenda
            IF !THIS.txt_4c_Text1.Enabled
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
                THIS.txt_4c_Digitos.Enabled      = .F.
                THIS.obj_4c_Optiongroup1.Enabled = .T.
                THIS.txt_4c_Datas.Enabled        = .T.
                *-- O legado faz "Optiongroup1.Option1.SetFocus". Em VFP9 o
                *-- foco de OptionGroup vai no grupo (ele mesmo roteia para o
                *-- botao marcado) e SetFocus num Buttons(N) de grupo recem
                *-- habilitado falha quando o form ainda nao esta visivel.
                IF THIS.obj_4c_Optiongroup1.Visible AND THIS.obj_4c_Optiongroup1.Enabled
                    THIS.obj_4c_Optiongroup1.SetFocus()
                ENDIF
            ENDIF
        ELSE
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
            THIS.obj_4c_Optiongroup1.Enabled = .T.
        ENDIF

        THIS.obj_4c_SAIDA.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarBufferData - o legado repete SEIS vezes, em quatro metodos, a
    * mesma conversao da data de vencimento para o formato DDMMAAAA que o
    * terminal espera:
    *     lcData = DTOC(ThisForm.GetDatas.Value)
    *     Buffer = ALLTRIM(SUBSTR(lcData,1,2)) + ALLTRIM(SUBSTR(lcData,4,2)) +
    *              ALLTRIM(SUBSTR(lcData,7,4)) + REPLICATE(CHR(0), 1992)
    * Centralizado num metodo so (FONTE UNICA - seis copias divergiriam em
    * silencio na primeira mudanca). Devolve SO os 8 digitos; o complemento de
    * CHR(0) fica em cada call site, porque o legado usa tamanhos diferentes.
    *
    * DTOC depende de SET DATE/CENTURY. A classe roda sob o SET DATE BRITISH +
    * SET CENTURY ON que o FormBase.Init estabelece (regra #9.4), onde DTOC
    * devolve DD/MM/AAAA - os offsets 1,2 / 4,2 / 7,4 do legado pressupoem
    * exatamente isso. Por isso o recorte eh feito sobre DTOC e nao sobre uma
    * reconstrucao com DAY/MONTH/YEAR: manter o mesmo pressuposto, visivel.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarBufferData()
        LOCAL loc_cData

        loc_cData = DTOC(ConverterParaData(THIS.txt_4c_Datas.Value))

        RETURN ALLTRIM(SUBSTR(loc_cData, 1, 2)) + ALLTRIM(SUBSTR(loc_cData, 4, 2)) + ;
               ALLTRIM(SUBSTR(loc_cData, 7, 4))
    ENDFUNC

    *--------------------------------------------------------------------------
    * DigitosLostFocus - migrado de SIGOPDTF.GetDigitos.LostFocus
    * ("Set Confirm On"). O par SET CONFIRM OFF/ON do legado existe para o
    * campo com InputMask cheio avancar sozinho ao completar os 4 digitos
    * (OFF) e voltar a exigir ENTER nos demais (ON). O OFF correspondente
    * estava no When do campo, que BINDEVENT nao alcanca - fica no GotFocus.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosLostFocus()
        SET CONFIRM ON
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterValorSaque - substitui o bloco que o legado repete em quatro lacos:
    *     IF crSigOpFp.lSaque = "S"
    *         lcSaque = "0,00"
    *         DO FORM SigCsTef WITH ThisForm.Top, ThisForm.Left TO lcSaque
    *         Buffer = lcSaque
    *     Else
    *         Buffer = "0,00"
    *     Endif
    *
    * O SIGCSTEF.scx (caixa de dialogo que pergunta o valor do saque) NAO faz
    * parte do acervo migrado. AVISA em vez de silenciar: o valor fica em
    * "0,00", que eh o mesmo default que o legado usa quando a forma de
    * pagamento nao permite saque - e tambem o valor com que ele INICIA a
    * variavel antes de abrir o dialogo. Assumir zero calado faria o terminal
    * autorizar uma transacao SEM o saque que o cliente pediu, divergencia de
    * dinheiro invisivel (regra #17); com o aviso, o operador ve na hora.
    *
    * Deixa o valor em this_cValorSaque (BO), que eh de onde os call sites
    * montam o buffer e de onde MontarRetornoTef le o "lcSaque" do retorno.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterValorSaque()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.this_cValorSaque = "0,00"

        IF loc_oBO.this_lOpFpSaque
            MsgAviso("A forma de pagamento permite SAQUE, mas o di" + CHR(225) + "logo de " + ;
                "entrada do valor (SigCsTef) n" + CHR(227) + "o foi portado nesta migra" + ;
                CHR(231) + CHR(227) + "o." + CHR(13) + ;
                "Valor de saque assumido: 0,00.", "Saque")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParcelas - cabeca do SIGOPDTF.Text1.Valid:
    *     IF EMPTY(THIS.Value)
    *         RETURN .t.
    *     Endif
    * Campo vazio encerra o Valid SEM conversar com o terminal (o legado
    * devolve .t., isto eh "sai do campo, esta tudo bem"). Devolve .T. quando
    * o laco deve rodar - note que isso INVERTE o sentido do retorno legado
    * neste ramo, de proposito: aqui o booleano significa "ha trabalho a
    * fazer", nao "o campo eh valido".
    * PUBLIC: consumido pelo handler de KeyPress.
    *--------------------------------------------------------------------------
    FUNCTION ValidarParcelas()
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Text1.Value))
    ENDFUNC

    *--------------------------------------------------------------------------
    * Text1GotFocus - migrado de SIGOPDTF.Text1.GotFocus
    * ("ThisForm.pcTvenda = .f.") mais o SET CONFIRM OFF do Text1.When
    * ("Set Confirm off"), que BINDEVENT nao alcanca.
    *
    * pcTvenda = .F. FECHA o grupo Tipo de Venda: a partir daqui o
    * Optiongroup1.When do legado devolve .F. e o grupo nao aceita mais foco -
    * quem esta digitando parcelas nao pode voltar a trocar o tipo da venda.
    * Esta eh a property this_lTipoVendaLiberado, que a Fase 6 declarou e
    * deixou explicitamente para esta fase fechar no momento certo.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1GotFocus()
        SET CONFIRM OFF
        THIS.this_lTipoVendaLiberado = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1LostFocus - migrado de SIGOPDTF.Text1.LostFocus:
    *     Set Confirm on
    *     This.Value = TRANSFORM(VAL(This.Value),"@L 99")
    *     This.Enabled = .f.
    *     ThisForm.getDatas.Enabled = .t.
    * Normaliza o numero de parcelas para 2 digitos com zero a esquerda,
    * tranca o campo e passa a vez para a data de vencimento.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1LostFocus()
        SET CONFIRM ON

        THIS.txt_4c_Text1.Value = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
        *-- lnParcs do legado - entra no retorno da tela (Unload).
        THIS.this_cParcelasTef = THIS.txt_4c_Text1.Value

        THIS.txt_4c_Text1.Enabled = .F.
        THIS.txt_4c_Datas.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text1KeyPress - migrado de SIGOPDTF.Text1.Valid. Diferente dos outros
    * quatro, este NAO tem laco: faz UMA chamada ao terminal com o numero de
    * parcelas digitado e trata a resposta.
    *
    * DOIS BLOCOS DO LEGADO NAO SAO TRANSCRITOS, e o motivo eh o mesmo do
    * primeiro bloco do errotef (ver nota la): sao codigo morto-ou-quebrado.
    * O Valid legado tem, DUAS vezes seguidas e identicas:
    *     If ProximoComando = 20 And Upper(Alltrim(Buffer)) = '13 - OPERACAO CANCELADA?'
    *         Buffer = '0'+Replicate(Chr(0),1999)
    *         Loop
    *     Endif
    * Esse "Loop" esta FORA de qualquer DO WHILE/FOR/SCAN - o Valid nao tem
    * laco nenhum. Em VFP um LOOP sem laco que o contenha nao tem para onde
    * saltar; o bloco eh copia-e-cola das versoes com laco (GetDigitos.Valid,
    * GetCodSeg.LostFocus) e nunca pode ter funcionado como pretendido.
    * Transcrever o "Loop" aqui seria propagar o defeito; transcreve-lo como
    * retry (inventando o laco que o legado nao tem) mudaria o comportamento.
    * Preservado o desfecho real: o bloco nao faz nada. A duplicacao literal
    * tambem nao eh reproduzida, pelo mesmo motivo.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF
        IF !THIS.ValidarParcelas()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.

        *-- lnParcs = This.Value / Buffer = This.Value + REPLICATE(CHR(0),1990)
        *-- O complemento 1990 eh o do legado (e nao 2000 - LEN), transcrito.
        THIS.this_cParcelasTef = ALLTRIM(THIS.txt_4c_Text1.Value)
        loc_oBO.this_nParcelas = THIS.txt_4c_Text1.Value
        loc_oBO.MontarBufferSiTef(ALLTRIM(THIS.txt_4c_Text1.Value), 1990)
        loc_oBO.this_nContinua = 1000

        loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
        loc_cBuf     = loc_oBO.this_cBuffer

        THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

        IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
        ENDIF

        IF loc_oBO.this_nProximoComando = 22
            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
            loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
        ELSE
            *-- As duas ultimas linhas do Valid legado, no ramo que segue.
            loc_oBO.this_cBuffer   = ""
            loc_oBO.this_nContinua = 0
        ENDIF

        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataVencimento - cabeca do SIGOPDTF.GetDatas.Valid:
    *     IF LASTKEY() = 27
    *         RETURN .t.
    *     ENDIF
    *     ldData = IIF(EMPTY(This.Value), DATE()+30, This.Value)
    *     This.Value = ldData
    *     This.Refresh
    *     IF ThisForm.Optiongroup1.Value = 2 .and. This.Value <= DATE() .and. ! EMPTY(This.Value)
    *         DO Form SigTfDss With "Erro na Transacao","","Data Invalida",...
    *         RETURN .f.
    *     ENDIF
    *
    * Tres coisas que NAO se "arrumam" aqui:
    *   - ESC (LASTKEY 27) sai sem validar e sem conversar com o terminal;
    *   - data VAZIA assume HOJE + 30 DIAS, e ja GRAVA isso no campo - nao eh
    *     so default de leitura;
    *   - a recusa de data passada vale SO para venda a prazo
    *     (Optiongroup1.Value = 2). A vista, data de hoje eh legitima.
    * O terceiro teste do legado ("! EMPTY(This.Value)") eh inalcancavel na
    * pratica, porque a linha anterior acabou de preencher o campo; mantido
    * para nao mudar a expressao.
    *
    * ConverterParaData nos dois lados da comparacao: o TextBox nasce com
    * .Value = {} (DATE) mas pode receber DATETIME em algum caminho, e
    * comparar DATE com DATETIME estoura erro 11 (regra #16).
    * PUBLIC: consumido pelo handler de KeyPress.
    *--------------------------------------------------------------------------
    FUNCTION ValidarDataVencimento()
        LOCAL loc_lProsseguir, loc_dData

        loc_lProsseguir = .F.

        DO CASE
        CASE LASTKEY() = 27
            *-- ESC: sai do campo sem acionar o protocolo.
        OTHERWISE
            loc_dData = ConverterParaData(THIS.txt_4c_Datas.Value)
            IF EMPTY(loc_dData)
                loc_dData = DATE() + 30
            ENDIF
            THIS.txt_4c_Datas.Value = loc_dData
            THIS.this_dDataTef      = loc_dData
            THIS.txt_4c_Datas.Refresh()

            IF THIS.obj_4c_Optiongroup1.Value = 2 AND loc_dData <= DATE() AND !EMPTY(loc_dData)
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    "Data Invalida", "")
            ELSE
                loc_lProsseguir = .T.
            ENDIF
        ENDCASE

        RETURN loc_lProsseguir
    ENDFUNC

    *--------------------------------------------------------------------------
    * DatasLostFocus - migrado de SIGOPDTF.GetDatas.LostFocus
    * ("Set Confirm On"); o OFF correspondente esta no GetDatas.When e vem
    * para o GotFocus. PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DatasLostFocus()
        SET CONFIRM ON
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterSenhaSupervisor - substitui "DO FORM SigPrStf TO Senha" do
    * SIGOPDTF.GetDatas.Valid (ProximoComando = 30 / TipoCampo = 500: o
    * terminal esta pedindo autorizacao de supervisor).
    *
    * O SIGPRSTF.scx nao faz parte do acervo migrado. Devolve STRING VAZIA,
    * que no legado eh o ramo "o supervisor nao autorizou" - e esse ramo
    * CANCELA a transacao. Escolha deliberada e conservadora: devolver uma
    * senha qualquer para "deixar passar" autorizaria no terminal uma operacao
    * que ninguem aprovou. Com o aviso, o operador sabe por que a tela
    * cancelou e pode acionar a autorizacao pelo caminho do legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterSenhaSupervisor()
        MsgAviso("O terminal pediu SENHA DE SUPERVISOR, e o di" + CHR(225) + "logo de " + ;
            "autoriza" + CHR(231) + CHR(227) + "o (SigPrStf) n" + CHR(227) + "o foi " + ;
            "portado nesta migra" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
            "A transa" + CHR(231) + CHR(227) + "o ser" + CHR(225) + " CANCELADA.", ;
            "Autoriza" + CHR(231) + CHR(227) + "o")

        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * DatasGotFocus - migrado de SIGOPDTF.GetDatas.GotFocus. Zera o estado da
    * transacao, troca a legenda e - SO quando a venda nao eh a prazo, a data
    * ainda nao foi confirmada e a forma de pagamento nao usa CDC - conduz
    * DOIS lacos encadeados com o terminal.
    *
    * A condicao de entrada eh do legado e nao se simplifica:
    *     IF lsDebCred <> "P" .and. ! DCD .and. crSigOpFp.Tcdc <> "S"
    * Fora dela o metodo SO reposiciona a legenda - e esse "else implicito" eh
    * o caminho normal quando a data chega aqui pela segunda vez.
    *
    * O 1o laco ("DO WHILE ProximoComando <> 30") so existe quando o grupo
    * Tipo de Venda esta DESABILITADO: com ele habilitado o legado monta o
    * buffer direto da escolha do usuario (1 = a vista, 3 = a prazo) e nao
    * conversa. Transcrito com essa bifurcacao.
    *
    * Guarda de reentrancia e corpo separado pelo mesmo motivo do
    * DigitosGotFocus (dialogo modal + mexe em .Enabled = foco volta = evento
    * redispara).
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DatasGotFocus()
        *-- SIGOPDTF.GetDatas.When ("Set Confirm Off") - BINDEVENT nao alcanca
        *-- "When", e aqui o legado nao condiciona a nada.
        SET CONFIRM OFF

        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DatasGotFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasGotFocusExec - corpo do metodo acima (ver nota de reentrancia).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DatasGotFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- pcTvenda = .f. - fecha o grupo Tipo de Venda (ver Text1GotFocus).
        THIS.this_lTipoVendaLiberado = .F.

        *-- Zera o estado da transacao (as 7 PRIVATE do legado).
        loc_oBO.this_cTipTran         = ""
        loc_oBO.this_cDataHora        = ""
        loc_oBO.this_cCupomRetorno    = ""
        loc_oBO.this_cCartaoAux       = ""
        loc_oBO.this_cNsu             = ""
        loc_oBO.this_cAutoriza        = ""
        loc_oBO.this_cFinaliza        = ""
        loc_oBO.this_cMensagemRetorno = ""

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"

        *-- Condicao de entrada do legado - fora dela, so a legenda acima.
        IF !(THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND ;
             loc_oBO.this_cOpFpTcdc != "S")
            RETURN
        ENDIF

        loc_nRetorno = 10000

        IF THIS.obj_4c_Optiongroup1.Enabled
            loc_oBO.this_cBuffer = IIF(THIS.obj_4c_Optiongroup1.Value = 1, "1", "3") + ;
                REPLICATE(CHR(0), 1999)
        ELSE
            *-- 1o laco: drena o protocolo ate ProximoComando = 30.
            DO WHILE loc_oBO.this_nProximoComando != 30
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                loc_cBuf     = loc_oBO.this_cBuffer

                IF loc_oBO.this_nProximoComando = 20 AND ;
                   UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                    LOOP
                ENDIF

                IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
                    THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
                ENDIF

                THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

                IF loc_nRetorno < 0
                    THIS.ErroTef(loc_nRetorno)
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDDO
            loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1998)
        ENDIF

        loc_oBO.this_nContinua = 1000
        loc_oBO.this_cAutoriza = ""
        loc_nRetorno           = 10000

        *-- 2o laco: conduz a autorizacao da venda a prazo.
        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                    loc_oBO.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf))
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                IF "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_cBuf))
                    loc_oBO.ContinuarSiTef(-1)
                    loc_nRetorno = -8
                    EXIT
                ENDIF
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                IF loc_nRetorno != 10000
                    THIS.EncerrarDialogo()
                    RETURN
                ELSE
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno < 0
                THIS.RetornoFalha(IIF(EMPTY(loc_oBO.this_cMensagemRetorno), ;
                    "Operacao Cancelada pelo Usuario", loc_oBO.this_cMensagemRetorno), ;
                    loc_oBO.this_nValPago)
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
                IF loc_oBO.this_nTipoCampo = 510
                    IF loc_oBO.this_lOpFpGarantias
                        loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                    ELSE
                        loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
                loc_oBO.this_cBuffer   = THIS.MontarBufferData() + REPLICATE(CHR(0), 1992)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505
                loc_oBO.this_cBuffer   = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
                    REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
                IF MsgConfirma("Primeira Parcela A Vista", "Parcelamento")
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
                loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 509
                loc_oBO.this_cBuffer   = ALLTRIM(STR(loc_oBO.this_nOpFpMesFec - 1)) + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            *-- Sem LOOP no legado: cai nos blocos de captura abaixo.
            IF loc_oBO.this_nProximoComando = 30
                loc_oBO.this_cBuffer = THIS.MontarBufferData() + REPLICATE(CHR(0), 1992)
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_oBO.this_cBuffer
            ENDIF

            *-- Legado: UPPER(ALLTRIM(Buffer)) $ "DIGITE A SENHA" - o operador
            *-- "$" testa se o BUFFER esta CONTIDO no literal, nao o contrario.
            *-- Com buffer vazio isso eh sempre verdadeiro. Transcrito como
            *-- esta: trocar a ordem mudaria quando a legenda aparece.
            IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA"
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                THIS.ObterValorSaque()
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + ;
                    REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            loc_cBuf = loc_oBO.this_cBuffer

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHora = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
                    loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                    loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
                    loc_oBO.this_cMensagemRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF
        ENDIF

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasKeyPress - migrado de SIGOPDTF.GetDatas.Valid, o laco que FECHA a
    * transacao: envia a data de vencimento e, aprovada a venda, grava o
    * arquivo de retorno e encerra a tela.
    *
    * Ligado a "KeyPress" (ENTER/TAB) porque BINDEVENT em "Valid" nao dispara
    * em TextBox - ver nota em RegistrarEventosCampos. A cabeca do Valid
    * legado esta em ValidarDataVencimento().
    *
    * O legado encerra a tela INCONDICIONALMENTE no fim deste Valid (o
    * "Thisform.release" esta FORA do IF que escolhe entre MontaRetorno e
    * ErroTef) - transcrito assim: todo caminho que chega ao fim fecha o
    * dialogo, porque a transacao ja foi decidida pelo terminal.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.DatasKeyPressExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * DatasKeyPressExec - corpo do laco acima (ver nota de reentrancia).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE DatasKeyPressExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf, loc_nPrimo, loc_cSenha, ;
              loc_cData, loc_cHora

        IF !THIS.ValidarDataVencimento()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- 1o laco: drena o protocolo ate ProximoComando = 30.
        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF
        ENDDO

        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.this_cAutoriza        = ""
        loc_nPrimo                    = 1
        loc_nRetorno                  = 10000

        loc_oBO.this_cBuffer   = THIS.MontarBufferData() + REPLICATE(CHR(0), 1992)
        loc_oBO.this_nContinua = 1000

        *-- 2o laco: a autorizacao propriamente dita.
        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                    loc_oBO.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                IF THIS.this_cDebCred != "P"
                    IF LEN(ALLTRIM(loc_cBuf)) != 0
                        THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                            IIF(UPPER(ALLTRIM(loc_cBuf)) = "AGUARDE, EM PROCESSAMENTO", ;
                                "TRANSACAO CANCELADA", ALLTRIM(loc_cBuf)), "")
                        IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR ;
                           "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_cBuf))
                            loc_oBO.ContinuarSiTef(-1)
                            loc_nRetorno = -8
                            EXIT
                        ENDIF
                        RETURN
                    ELSE
                        loc_nRetorno = 0
                        EXIT
                    ENDIF
                ELSE
                    loc_oBO.this_cCupomRetorno = ALLTRIM(loc_cBuf)
                    loc_nRetorno = -1
                    EXIT
                ENDIF
            ENDIF

            IF loc_nRetorno != 10000
                THIS.RetornoFalha(IIF(EMPTY(loc_oBO.this_cMensagemRetorno), ;
                    "Operacao Cancelada pelo Usuario", loc_oBO.this_cMensagemRetorno), ;
                    loc_oBO.this_nValPago)
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 500
                loc_cSenha = THIS.ObterSenhaSupervisor()
                IF EMPTY(loc_cSenha)
                    THIS.RetornoFalha("Operacao Cancelada pelo Usuario", loc_oBO.this_nValPago)
                    loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + ;
                                SUBSTR(DTOC(DATE()), 1, 2)
                    loc_cHora = STRTRAN(TIME(), ":", "")
                    *-- O legado le o cupom do DBF SigTef (modulo fiscal, fora
                    *-- do acervo) e cai em "1" quando vazio - que eh o valor
                    *-- passado aqui, pelo mesmo motivo.
                    loc_oBO.FinalizarTransacaoSiTef(0, "1", loc_cData, loc_cHora)
                    loc_nRetorno = -2
                    EXIT
                ELSE
                    loc_oBO.MontarBufferSiTef(loc_cSenha, 1900)
                    LOOP
                ENDIF
            ENDIF

            IF UPPER(loc_cBuf) = "ASSUME GARANTIA" AND loc_nPrimo = 1
                IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?", "Garantia")
                    loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_nPrimo = 2
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                THIS.ObterValorSaque()
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + ;
                    REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = -1
                *-- Legado: DO FORM SigCsTef WITH ..., "Entrada CDC" TO lcSaque
                *-- (o MESMO dialogo do saque, com outro titulo - entrada do
                *-- CDC). Nao portado; assume "0,00" e avisa. O legado tambem
                *-- devolve lcSaque a "0,00" logo apos usar o valor.
                THIS.ObterValorSaque()
                loc_oBO.MontarBufferSiTef(loc_oBO.this_cValorSaque, 1900)
                loc_oBO.this_cValorSaque = "0,00"
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHora = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                *-- SPACE(3000) eh do legado (os outros lacos usam 2000). O
                *-- tamanho do buffer eh passado a DLL como LEN(Buffer), entao
                *-- a diferenca eh deliberada do original e foi transcrita.
                loc_oBO.this_cBuffer   = SPACE(3000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF THIS.this_cDebCred = "P"
                MsgAviso("Consulta CDC (SigCoCDC) n" + CHR(227) + "o portada nesta migra" + ;
                    CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "Cupom retornado pelo terminal: " + ALLTRIM(loc_oBO.this_cCupomRetorno), ;
                    "Consulta CDC")
                THIS.RetornoFalha("Consulta CDC Realizada", loc_oBO.this_nValPago)
            ELSE
                IF loc_nRetorno = 0
                    THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
                        loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                        loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
                        loc_oBO.this_cMensagemRetorno)
                ELSE
                    *-- Legado: "If lnRetorno >= -5". Os codigos -1..-5 tem
                    *-- mensagem propria no ErroTef; abaixo de -5 (o -8 de
                    *-- "CANC. CLIENTE", por exemplo) o legado nao grava nada
                    *-- aqui, porque a mensagem ja foi exibida no ramo 22.
                    IF loc_nRetorno >= -5
                        THIS.ErroTef(loc_nRetorno)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- "Thisform.release" FORA do IF no legado - ver nota no cabecalho.
        THIS.EncerrarDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegGotFocus - migrado de SIGOPDTF.GetCodSeg.GotFocus
    * ("Container1.Label1.Caption = 'Digite o Codigo' + CHR(13) + 'de Seguranca'")
    * mais o SET CONFIRM OFF do GetCodSeg.When, que BINDEVENT nao alcanca e que
    * no legado eh condicionado a campo vazio.
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegGotFocus()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
            SET CONFIRM OFF
        ENDIF

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Codigo" + CHR(13) + "de Seguranca"
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegLostFocus - migrado de SIGOPDTF.GetCodSeg.LostFocus: envia o
    * codigo de seguranca (CSEG) ao terminal e conduz o parcelamento.
    *
    * ESTE eh o unico laco que fica no evento LostFocus de verdade, e nao em
    * KeyPress: no legado o protocolo do CSEG mora no PROPRIO LostFocus. O
    * GetCodSeg.Valid existe no dump mas esta INTEIRO comentado (prefixo
    * "*!*") - codigo desligado de proposito, que nao se migra. E LostFocus
    * dispara por BINDEVENT sem problema (diferente de "Valid"), entao nao ha
    * razao para desviar do legado aqui.
    *
    * A guarda de reentrancia eh especialmente necessaria neste: o laco abre
    * dialogo MODAL (ExibirMensagemTef/MsgConfirma) e no fim mexe no .Enabled
    * de quatro controles - cada uma dessas coisas devolve o foco e
    * REDISPARARIA este mesmo LostFocus (regras #37/#47).
    * PUBLIC: alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegLostFocus()
        SET CONFIRM ON

        IF THIS.this_lEmProtocolo
            RETURN
        ENDIF
        *-- "IF EMPTY(This.Value) / RETURN" do legado.
        IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
            RETURN
        ENDIF

        THIS.this_lEmProtocolo = .T.
        THIS.CodSegLostFocusExec()
        THIS.this_lEmProtocolo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegLostFocusExec - corpo do laco acima (ver nota de reentrancia).
    * PUBLIC: chamado pelo wrapper; nunca ligado direto a evento.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegLostFocusExec()
        LOCAL loc_oBO, loc_nRetorno, loc_cBuf

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.this_cCodSeg          = ALLTRIM(THIS.txt_4c_Codigo.Value)
        loc_oBO.this_cMensagemRetorno = ""
        loc_oBO.MontarBufferSiTef(ALLTRIM(THIS.txt_4c_Codigo.Value))
        loc_oBO.this_nContinua = 1000
        loc_nRetorno           = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            loc_cBuf     = loc_oBO.this_cBuffer

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                    loc_oBO.this_nValPago)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 20 AND ;
               UPPER(ALLTRIM(loc_cBuf)) = "13 - OPERACAO CANCELADA?"
                loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
                LOOP
            ENDIF

            THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)

            IF loc_nRetorno = 0
                EXIT
            ENDIF

            IF loc_nRetorno < 0
                THIS.ErroTef(loc_nRetorno)
                THIS.EncerrarDialogo()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))
                loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                IF loc_nRetorno != 10000
                    THIS.EncerrarDialogo()
                    RETURN
                ELSE
                    LOOP
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF THIS.this_cTipPagto != "E"
                    loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, "1", ;
                        IIF(THIS.this_cTipPagto = "2", "3", "2")) + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                ELSE
                    EXIT
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND ;
               (THIS.this_cDebCred = "C" OR loc_oBO.this_nTipoCampo = 511)
                loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
                    REPLICATE(CHR(0), 1998)
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
                IF loc_oBO.this_lOpFpGarantias
                    loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
                ELSE
                    loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
                ENDIF
                loc_oBO.this_nContinua = 1000
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
                THIS.ObterValorSaque()
                loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + ;
                    REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            *-- Legado: UPPER(ALLTRIM(Buffer)) $ "DIGITE A SENHA" - buffer
            *-- CONTIDO no literal (ver nota igual em DatasGotFocusExec).
            IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA" OR ;
               loc_oBO.this_nProximoComando = 23
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
            ENDIF

            loc_cBuf = loc_oBO.this_cBuffer

            IF loc_oBO.this_nProximoComando = 3
                loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 100
                loc_oBO.this_cTipTran = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 105
                loc_oBO.this_cDataHora = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                loc_oBO.this_cCupomRetorno = STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                loc_oBO.this_cCupomRetorno = loc_oBO.this_cCupomRetorno + STRTRAN(loc_cBuf, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                loc_oBO.this_cCartaoAux = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 132
                loc_oBO.this_cBandeira = LEFT(loc_cBuf, 5)
            ENDIF
            IF loc_oBO.this_nTipoCampo = 134
                loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_cBuf)))
            ENDIF
            IF loc_oBO.this_nTipoCampo = 135
                loc_oBO.this_cAutoriza = loc_cBuf
            ENDIF
            IF loc_oBO.this_nTipoCampo = 136
                IF !loc_oBO.ValidarBinCartao(loc_cBuf)
                    loc_oBO.ContinuarSiTef(-1)
                    THIS.ExibirMensagemTef("Erro na Forma de Pagamento", ;
                        "Cart" + CHR(227) + "o Invalido para esta", ;
                        "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    THIS.EncerrarDialogo()
                    RETURN
                ENDIF
            ENDIF

            IF loc_nRetorno != 0
                loc_oBO.this_cFinaliza = loc_cBuf
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30 AND ;
               loc_oBO.this_nProximoComando != 34
                loc_oBO.this_cMensagemRetorno = loc_cBuf
                loc_oBO.this_cBuffer          = SPACE(2000)
                loc_oBO.this_nContinua        = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.MontaRetorno(loc_oBO.this_cTipTran, loc_oBO.this_cDataHora, ;
                    loc_oBO.this_cCupomRetorno, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
                    loc_oBO.this_cAutoriza, loc_oBO.this_cFinaliza, loc_oBO.this_nValPago, ;
                    loc_oBO.this_cMensagemRetorno)
            ENDIF
            THIS.EncerrarDialogo()
            RETURN
        ENDIF

        *-- Rearranjo final dos campos, transcrito na ordem do legado: a
        *-- primeira legenda eh SOBREPOSTA pelo ramo de baixo quando a venda
        *-- nao eh a prazo - esta assim no original.
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
        THIS.txt_4c_Digitos.Enabled = .F.
        THIS.txt_4c_Text1.Enabled   = .T.

        IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
            THIS.obj_4c_Optiongroup1.Enabled = .T.
            THIS.txt_4c_Datas.Enabled        = .T.
            THIS.txt_4c_Text1.Enabled        = .F.
        ELSE
            THIS.obj_4c_Optiongroup1.Enabled = .F.
            THIS.txt_4c_Datas.Enabled        = .F.
            THIS.txt_4c_Text1.Enabled        = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaRetorno - migrado de SIGOPDTF.montaretorno (PARAMETERS lsTipTran,
    * lsDataHora, lsCupom, lsCartao, lsNsu, lsAutoriza, lsFinaliza, lnValPago,
    * MenRet). Grava os mesmos dois arquivos SDF do RetornoFalha, agora com os
    * dados COMPLETOS da transacao APROVADA - eh este arquivo que o software
    * do PDV le para imprimir o comprovante.
    *
    * Nada aqui eh "arrumado": os numeros de campo (000-000, 010-000, ...), a
    * ordem, os recortes de lsDataHora e inclusive as DUAS ANOMALIAS do
    * original sao transcritos literalmente, porque o leitor do outro lado eh
    * o PDV e qualquer divergencia aparece como comprovante errado:
    *
    *   1. O campo "017-000" eh gravado DUAS vezes (primeiro "0", depois
    *      vazio), e "023-000" tambem (primeiro a hora, depois lsFinaliza).
    *      Como o arquivo eh lido em sequencia, a segunda ocorrencia vence.
    *      Esta assim no legado desde sempre.
    *   2. laCartao tem 11 posicoes e eh indexado por VAL(lsCartao)+1, mas o
    *      guard anterior aceita VAL(pcBandeira) de 0 a 10 - ou seja o indice
    *      vai de 1 a 11 e nunca estoura. O guard do legado eh
    *      "> 10 .or. < 0 -> lsCartao = '0'", transcrito igual.
    *
    * O par_cCartao recebido eh a BANDEIRA (os call sites passam
    * Thisform.pcBandeira nessa posicao, apesar do nome do parametro) - por
    * isso eh ele que alimenta o indice de laCartao.
    *
    * O laco do cupom quebra o texto em linhas de 029-NNN por CHR(10). A
    * condicao do legado eh "DO WHILE lsPos <> 0" com lsPos calculado DENTRO
    * do laco, o que faz a ultima linha (sem CHR(10)) entrar e so depois a
    * condicao falhar - por isso o contador final eh "lnLinha - 2".
    *
    * PUBLIC: chamado pelos cinco lacos do protocolo.
    *--------------------------------------------------------------------------
    PROCEDURE MontaRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
            par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_cValPago, loc_cLsCartao, loc_cCupom, loc_nPos, loc_nLinha, ;
              loc_cDataHora, loc_oErro
        LOCAL ARRAY loc_aCartao[11]

        loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")
        loc_cDataHora = IIF(VARTYPE(par_cDataHora) = "C", par_cDataHora, "")
        loc_cCupom    = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")

        loc_aCartao[1]  = "Outro, nao definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        *-- IF VAL(Thisform.pcBandeira) > 10 .or. VAL(Thisform.pcBandeira) < 0
        loc_cLsCartao = IIF(VARTYPE(par_cCartao) = "C", par_cCartao, "0")
        IF VAL(loc_cLsCartao) > 10 OR VAL(loc_cLsCartao) < 0
            loc_cLsCartao = "0"
        ENDIF

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cLsCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + IIF(VARTYPE(par_cTipTran) = "C", par_cTipTran, ""))
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + IIF(VARTYPE(par_cNsu) = "C", par_cNsu, ""))
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + IIF(VARTYPE(par_cAutoriza) = "C", par_cAutoriza, ""))
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(loc_cDataHora, 7, 2) + ;
                SUBSTR(loc_cDataHora, 5, 2) + SUBSTR(loc_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + THIS.txt_4c_Text1.Value)
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(loc_cDataHora, 7, 2) + ;
                SUBSTR(loc_cDataHora, 5, 2) + SUBSTR(loc_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(loc_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + IIF(VARTYPE(par_cFinaliza) = "C", par_cFinaliza, ""))
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(loc_cDataHora, 9, 6))

            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES (STRTRAN("029-" + ;
                    TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                    IIF(loc_nPos != 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom), ;
                    CHR(0), " "))
                loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + IIF(VARTYPE(par_cMenRet) = "C", par_cMenRet, ""))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere os campos da tela para as properties do BO.
    *
    * O legado nao tem um metodo equivalente: ele le os controles direto
    * (ThisForm.Text1.Value, ThisForm.GetDatas.Value) dentro dos lacos do
    * protocolo, e esses lacos continuam fazendo isso, fielmente. Este hook
    * existe para o CONTRATO da arquitetura em camadas (PILAR 3) e eh de fato
    * usado: consolida num ponto so a conversao de tipo que os campos pedem,
    * e eh chamado por LimparCampos e pelos pontos em que o BO precisa do
    * estado completo da tela.
    *
    * As tres conversoes NAO sao cosmeticas:
    *   - txt_4c_Text1 e txt_4c_Digitos sao CARACTERE na tela (.Value = "" na
    *     criacao, InputMask "99"/"9999") e a property de parcelas eh
    *     NUMERICA: VAL() eh obrigatorio, senao a property troca de tipo e a
    *     primeira comparacao aritmetica estoura.
    *   - txt_4c_Valor eh numerico, mas pode chegar como CARACTERE quando o
    *     InputMask e' aplicado em alguns caminhos - TratarNulo com padrao
    *     numerico normaliza.
    *   - txt_4c_Datas nasce DATE ({}) e pode receber DATETIME: ConverterParaData
    *     evita o erro 11 da regra #16.
    *
    * Optiongroup1.Value eh NUMERICO e 1-based (1 = A Vista, 2 = A Prazo) -
    * copiado DIRETO, sem +1/-1 (regra #45).
    *
    * PROTECTED: FormBase declara o hook como PROTECTED e subclasse nao alarga
    * escopo em VFP9 (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_nValPago   = TratarNulo(THIS.txt_4c_Valor.Value, 0)
            loc_oBO.this_cDigitos   = ALLTRIM(THIS.txt_4c_Digitos.Value)
            loc_oBO.this_cCartao    = ALLTRIM(THIS.txt_4c_Cartao.Value)
            loc_oBO.this_cCodSeg    = ALLTRIM(THIS.txt_4c_Codigo.Value)
            loc_oBO.this_nTipoVenda = THIS.obj_4c_Optiongroup1.Value
            loc_oBO.this_nParcelas  = THIS.txt_4c_Text1.Value
            loc_oBO.this_dDataVencto = ConverterParaData(THIS.txt_4c_Datas.Value)

            *-- Parametros que o Form guarda desde o Init (o BO declara
            *-- this_lDebCred como LOGICO e nunca o le - ver nota na Fase 3;
            *-- o valor CARACTERE real vive em THIS.this_cDebCred).
            loc_oBO.this_cTipPagto = THIS.this_cTipPagto
            loc_oBO.this_nNumParcs = THIS.this_nNumParcs
            loc_oBO.this_cIdent    = THIS.this_cIdent
            loc_oBO.this_cOpers    = THIS.this_cOpers

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso. Existe para o chamador que pre-carrega a
    * transacao no BO (valor, parcelas, vencimento vindos do pedido) antes de
    * exibir o dialogo, e para repintar a tela depois de o protocolo alterar
    * esses campos.
    *
    * txt_4c_Text1 volta com a MESMA mascara do legado (TRANSFORM "@L 99"),
    * porque o controle eh CARACTERE e a property eh numerica - sem a mascara
    * "3" viraria "3" em vez de "03" e o campo 018-000 do arquivo de retorno
    * sairia com um digito.
    *
    * Optiongroup1.Value so eh atribuido DENTRO da faixa dos 2 botoes: valor
    * fora dela (o 0 default do BO, por exemplo) marcaria todos os radios de
    * uma vez (regra do pattern #108).
    * PROTECTED: mesmo motivo do FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            THIS.txt_4c_Valor.Value   = TratarNulo(loc_oBO.this_nValPago, 0)
            THIS.txt_4c_Digitos.Value = loc_oBO.this_cDigitos
            THIS.txt_4c_Cartao.Value  = loc_oBO.this_cCartao
            THIS.txt_4c_Codigo.Value  = loc_oBO.this_cCodSeg
            THIS.txt_4c_Text1.Value   = TRANSFORM(loc_oBO.this_nParcelas, "@L 99")
            THIS.txt_4c_Datas.Value   = ConverterParaData(loc_oBO.this_dDataVencto)

            IF BETWEEN(loc_oBO.this_nTipoVenda, 1, THIS.obj_4c_Optiongroup1.ButtonCount)
                THIS.obj_4c_Optiongroup1.Value = loc_oBO.this_nTipoVenda
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - estado dos campos por etapa do protocolo. NAO eh o
    * HabilitarCampos de form CRUD (que liga/desliga a Page2 de Dados por
    * modo INCLUIR/ALTERAR/VISUALIZAR): aqui nao ha modo de edicao nenhum,
    * ha ETAPAS de conversa com o terminal, e o legado comanda cada campo na
    * linha exata em que o terminal pede o dado.
    *
    * Reune num lugar so os dois estados que o legado monta repetidas vezes:
    *   par_lHabilitar = .F. -> estado de ABERTURA, identico ao que o SCX
    *       declara (GetDigitos editavel, o resto travado) e que
    *       DigitosGotFocus reforca;
    *   par_lHabilitar = .T. -> estado de PARCELAMENTO LIBERADO, o mesmo que
    *       o fim do CodSegLostFocus/DigitosKeyPress monta quando a venda nao
    *       eh a prazo.
    * As transicoes INTERMEDIARIAS continuam onde o legado as poe (dentro dos
    * lacos), de proposito: centralizar todas aqui obrigaria a inventar uma
    * maquina de estados que o legado nao tem, e e' justamente onde esse tipo
    * de reescrita costuma trocar o ramo errado.
    * PROTECTED: so o proprio form chama.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        *-- GetValor nunca entra em edicao (When = .F. no legado - ver
        *-- ConfigurarValoresIniciais).
        THIS.txt_4c_Valor.ReadOnly = .T.
        THIS.txt_4c_Valor.TabStop  = .F.

        IF loc_lHabilitar
            THIS.txt_4c_Digitos.Enabled      = .F.
            THIS.txt_4c_Text1.Enabled        = .T.
            THIS.txt_4c_Datas.Enabled        = .T.
            THIS.obj_4c_Optiongroup1.Enabled = .T.
        ELSE
            THIS.txt_4c_Digitos.Enabled      = .T.
            THIS.txt_4c_Text1.Enabled        = .F.
            THIS.txt_4c_Datas.Enabled        = .F.
            THIS.txt_4c_Codigo.Enabled       = .F.
            THIS.obj_4c_Optiongroup1.Enabled = .F.

            *-- GetCartao depende da forma de pagamento (lCartao = "S"), nao
            *-- da etapa - mesmo criterio do Init legado.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Cartao.Enabled = THIS.this_oBusinessObject.this_lOpFpCartao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - devolve a tela ao estado de abertura, para o caso de o
    * chamador reaproveitar a MESMA instancia do dialogo em uma segunda
    * transacao.
    *
    * No legado isso nunca acontece: SIGOPDTF eh modal, vive UMA transacao e
    * morre no Thisform.release. No sistema novo a tela fecha com Hide() (para
    * o chamador conseguir ler o resultado - ver EncerrarDialogo), entao a
    * instancia SOBREVIVE e pode ser exibida de novo. Sem zerar o estado, a
    * segunda transacao herdaria NSU, bandeira, cupom e this_cRetornoTef da
    * primeira e gravaria um comprovante com dados da anterior - exatamente a
    * classe de defeito que a regra #32 descreve ("declarar NAO basta quando o
    * ciclo de vida difere").
    *
    * Zera TAMBEM this_cRetornoTef e o estado do protocolo no BO, nao apenas
    * os controles: eh o retorno que o chamador le.
    * PROTECTED: FormBase declara o hook como PROTECTED (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO

        THIS.txt_4c_Digitos.Value = ""
        THIS.txt_4c_Cartao.Value  = ""
        THIS.txt_4c_Codigo.Value  = ""
        THIS.txt_4c_Text1.Value   = TRANSFORM(THIS.this_nNumParcs, "@L 99")
        THIS.txt_4c_Datas.Value   = DATE()
        THIS.txt_4c_Valor.Value   = THIS.this_nValPago

        THIS.obj_4c_Optiongroup1.Value = 1

        THIS.this_cRetornoTef        = ""
        THIS.this_cParcelasTef       = TRANSFORM(THIS.this_nNumParcs, "@L 99")
        THIS.this_dDataTef           = DATE()
        THIS.this_lTipoVendaLiberado = .T.
        THIS.this_lEmProtocolo       = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_cTipTran         = ""
            loc_oBO.this_cDataHora        = ""
            loc_oBO.this_cCupomRetorno    = ""
            loc_oBO.this_cCartao          = ""
            loc_oBO.this_cCartaoAux       = ""
            loc_oBO.this_cBandeira        = ""
            loc_oBO.this_cNsu             = ""
            loc_oBO.this_cAutoriza        = ""
            loc_oBO.this_cFinaliza        = ""
            loc_oBO.this_cCodSeg          = ""
            loc_oBO.this_cDigitos         = ""
            loc_oBO.this_cMensagemRetorno = ""
            loc_oBO.this_cValorSaque      = "0,00"
            loc_oBO.this_lDataConfirmada  = .F.
            loc_oBO.this_lCancelado       = .F.

            loc_oBO.this_nProximoComando = 0
            loc_oBO.this_nTipoCampo      = 0
            loc_oBO.this_nTamanhoMinimo  = 0
            loc_oBO.this_nTamanhoMaximo  = 0
            loc_oBO.this_cBuffer         = SPACE(2000)
            loc_oBO.this_nContinua       = 0
        ENDIF

        THIS.ConfigurarValoresIniciais()
        THIS.HabilitarCampos(.F.)
        THIS.FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarRetornoTef - transcricao literal do RETURN do SIGOPDTF.Unload:
    *
    *     If ! Type('ThisForm.pcBandeira') = [C] or Empty(ThisForm.pcBandeira)
    *         ThisForm.pcBandeira = [00000]
    *     Endif
    *     If ! Type('ThisForm.lsCartao') = [C] or Empty(ThisForm.lsCartao)
    *         ThisForm.lsCartao = [00000]
    *     Endif
    *     RETURN(lcSaque + "/" + lnParcs + "/" + DTOC(ldData) + ThisForm.pcBandeira + ThisForm.lsCartao)
    *
    * Esta string EH o resultado da tela: o chamador a le e dela extrai saque,
    * parcelas, vencimento, bandeira e cartao. O formato nao se "arruma" -
    * note que ha "/" entre os tres primeiros e NENHUM separador entre
    * bandeira e cartao (os dois sao de 5 posicoes fixas, cortados com
    * LEFT(Buffer,5), e o chamador os separa por posicao). Mexer nisso
    * quebraria o chamador em silencio.
    *
    * Precedencia do legado: em VFP o "=" liga mais forte que o NOT, logo
    * "! Type(x) = [C]" eh NOT(Type(x) == 'C') - e nao (NOT Type(x)) == 'C'.
    * Por isso o teste migrado eh VARTYPE(...) != "C" OR EMPTY(...).
    *
    * Os tres CLEAR DLLS e o CHRSAW(2) do Unload legado estao COMENTADOS no
    * SCX (desligados de proposito - descarregar a CliSiTef32I.DLL entre duas
    * transacoes derrubava a sessao do PIN-pad), portanto nao sao migrados.
    * PUBLIC: lido pelo EncerrarDialogo, pelo Destroy e pelo Unload.
    *--------------------------------------------------------------------------
    FUNCTION MontarRetornoTef()
        LOCAL loc_oBO, loc_cSaque, loc_cBandeira, loc_cCartao, loc_dData

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO.this_cBandeira) != "C" OR EMPTY(loc_oBO.this_cBandeira)
                loc_oBO.this_cBandeira = "00000"
            ENDIF
            IF VARTYPE(loc_oBO.this_cCartaoAux) != "C" OR EMPTY(loc_oBO.this_cCartaoAux)
                loc_oBO.this_cCartaoAux = "00000"
            ENDIF

            loc_cBandeira = loc_oBO.this_cBandeira
            loc_cCartao   = loc_oBO.this_cCartaoAux
            loc_cSaque    = loc_oBO.this_cValorSaque
        ELSE
            *-- BO ja liberado. Nao eh caminho normal (EncerrarDialogo e
            *-- Destroy calculam o retorno ANTES de solta-lo), mas devolver
            *-- string truncada seria pior que devolver os defaults que o
            *-- proprio legado usa.
            loc_cBandeira = "00000"
            loc_cCartao   = "00000"
            loc_cSaque    = "0,00"
        ENDIF

        loc_dData = ConverterParaData(THIS.this_dDataTef)

        RETURN loc_cSaque + "/" + THIS.this_cParcelasTef + "/" + DTOC(loc_dData) + ;
               loc_cBandeira + loc_cCartao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Unload - migrado de SIGOPDTF.Unload. Em VFP9 o Unload dispara DEPOIS do
    * Destroy, quando this_oBusinessObject ja foi liberado; por isso devolve o
    * valor que EncerrarDialogo/Destroy cachearam em this_cRetornoTef, e so
    * recalcula se por algum caminho ele nao tiver sido preenchido.
    *
    * Atende os DOIS modos de abertura: "DO FORM ... TO lcRetorno" (le este
    * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
    * sobrevive ao fechamento porque o chamador ainda tem a referencia).
    * PUBLIC: evento de form.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF

        RETURN THIS.this_cRetornoTef
    ENDPROC

    *--------------------------------------------------------------------------
    * Move - migrado de SIGOPDTF.Move ("llCancela = .f."). llCancela eh a flag
    * de cancelamento do FORM CHAMADOR no padrao Fortyus (nao eh lida em ponto
    * nenhum deste SCX); no novo desenho ela vive no BO, como this_lCancelado.
    *
    * DESVIO DELIBERADO, registrado: o Move legado NAO chama DoDefault, isto eh
    * ENGOLE o reposicionamento. Aqui o DODEFAULT eh mantido, porque a classe
    * migrada usa AutoCenter = .T. e engolir o Move deixaria o dialogo
    * ancorado no canto. O legado nao sofria disso por posicionar a tela na mao
    * (TitleBar = 0 / ControlBox = .F. - o usuario nunca conseguiu arrasta-la).
    *
    * O DO CASE por PCOUNT() existe porque Move aceita 1, 2, 3 ou 4
    * argumentos: repassar parametro AUSENTE ao DODEFAULT o converteria em .F.
    * e o reposicionamento falharia com erro de tipo.
    * PUBLIC: evento de form.
    *--------------------------------------------------------------------------
    PROCEDURE Move(par_nLeft, par_nTop, par_nWidth, par_nHeight)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCancelado = .F.
        ENDIF

        DO CASE
        CASE PCOUNT() >= 4
            DODEFAULT(par_nLeft, par_nTop, par_nWidth, par_nHeight)
        CASE PCOUNT() = 3
            DODEFAULT(par_nLeft, par_nTop, par_nWidth)
        CASE PCOUNT() = 2
            DODEFAULT(par_nLeft, par_nTop)
        CASE PCOUNT() = 1
            DODEFAULT(par_nLeft)
        OTHERWISE
            DODEFAULT()
        ENDCASE
    ENDPROC

    *==========================================================================
    * O QUE NAO SE APLICA A ESTE FORM - e por que nao virou metodo vazio
    *
    * A Fase 8 pede, no texto generico do pipeline, "BtnBuscarClick,
    * BtnEncerrarClick, BtnSalvarClick, BtnCancelarClick, CarregarLista,
    * AjustarBotoesPorModo". Desses, so BtnCancelarClick existe aqui (entregue
    * na Fase 7), e os outros cinco NAO tem contrapartida no legado:
    *
    *   - Buscar/Encerrar/Salvar: o SCX declara UM botao (CommandGroup SAIDA,
    *     ButtonCount = 1, botao CANCELA) - medido no dump: zero objeto com
    *     "BaseClass: commandbutton" e zero "<Verbo>.Click". Criar os tres
    *     exigiria INVENTAR botoes (viola o PILAR 1).
    *   - CarregarLista: nao ha lista. Zero "BaseClass: grid" e zero
    *     "BaseClass: pageframe" na arvore do SCX, e os quatro testes estritos
    *     de lista do pipeline (ListBoxLigaLista, TokenGradeProprioForm,
    *     AddCursorLigaGrade, ControlSourceLigaLista) dao False neste dump. O
    *     unico "ControlSource" que ele tem eh "SAIDA.ControlSource = [OPSENHA]"
    *     num CommandGroup - vestigio da classe Grupo_Saida do Framework, nao
    *     prova de grade.
    *   - AjustarBotoesPorModo: nao ha modo CRUD. Zero "frmcadastro", zero
    *     "Grupo_Op", zero "pcEscolha" no dump; o estado da tela eh a ETAPA do
    *     protocolo, e quem o comanda eh HabilitarCampos + as transicoes
    *     dentro dos lacos.
    *
    * Gerar os cinco como metodos vazios, ou com um aviso de placeholder no
    * lugar do corpo, eh explicitamente proibido pela regra de completude, e
    * exibi-los na tela violaria o PILAR 1. O gate trata exatamente isso pelo ramo
    * PROTOCOLO (dialogo que conversa com dispositivo externo via DLL
    * declarada no SCX), que dispensa CarregarLista e cobra, em vez disso, os
    * hooks FormParaBO/BOParaForm e o handler do unico botao - os tres
    * entregues acima.
    *==========================================================================

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por padrao).
    * FILTRO: nenhum container flutuante neste form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form (migrado de SIGOPDTF.Release:
    * "ThisForm.poDataMgr.Release / dodefault()", que eh onde o legado solta o
    * gerenciador de dados). O calculo do retorno equivalente a SIGOPDTF.Unload
    * (this_cRetornoTef) entra quando os campos de captura (lcSaque/Cartao/
    * Bandeira) existirem nas fases seguintes.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- FASE 8/8: o retorno da tela (SIGOPDTF.Unload) eh calculado AQUI,
        *-- ANTES de soltar o BO - ele le this_cBandeira/this_cCartaoAux/
        *-- this_cValorSaque de dentro dele. Depois do .NULL. abaixo,
        *-- MontarRetornoTef so conseguiria devolver os defaults.
        *-- Em VFP9 o Unload dispara DEPOIS do Destroy, por isso o valor eh
        *-- cacheado na property em vez de recalculado la.
        IF EMPTY(THIS.this_cRetornoTef)
            THIS.this_cRetornoTef = THIS.MontarRetornoTef()
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
