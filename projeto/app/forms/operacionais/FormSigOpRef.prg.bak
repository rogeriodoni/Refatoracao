*==============================================================================
* FormSigOpRef.prg
* Form OPERACIONAL: Replicacao de Produto (SigOpRef.SCX migrado) - dialogo
* MODAL que gera um PRODUTO NOVO (SigCdPro) a partir de um produto de origem
* ja cadastrado, copiando tambem a composicao (SigPrCpo) e as linhas
* (SigCdPrf) do produto de origem.
*
* Legado (Init): Lparameters pPro, pSit, pAut, pIFx, pCad, pDop, pGru
*   pPro - codigo do produto de ORIGEM (SigCdPro.cpros) - sempre informado
*          por quem abre o dialogo (ex.: Cadastro de Produto)
*   pSit - situacaoit: quando 1 ou 2, fixa a Situacao do produto novo e
*          desabilita a escolha (Opc_situacao.Enabled = .f.)
*   pAut - saiauto: .T. processa a copia automaticamente, sem confirmacao
*   pIFx - identfixa: identificador fixo repassado ao produto novo
*   pCad - cadpro: tipo de cadastro especial (5 = produto com foto/serial,
*          via SigOpCdd)
*   pDop - dopes: codigo de operacao (SigOpCdd.Dopes), usado quando pCad = 5
*   pGru - grupo de destino (opcional); quando omitido, o grupo de destino
*          comeca igual ao grupo do produto de origem
*
* Layout: form PLANO, sem PageFrame - o SCX legado nao tem abas nem Lista de
* registros (cntSombra + campos de origem/destino + Opc_situacao + cntBotoes
* com 2 botoes "Salvar"/"Cancelar"). Mesmo padrao de FormSigOpCcj.prg (familia
* SigOp): dialogo utilitario UNICO, nao um cadastro CRUD - sem Page1(Lista)/
* Page2(Dados) (analise.json: temGrid=false). Form 583x282 (dimensao exata
* do SIGOPREF.SCX legado), bem menor que o canonico 1000x600 de CRUD.
*
* Fase 3/8 - Estrutura base: propriedades visuais, Init() recebendo e
* validando os mesmos parametros do Init legado, InicializarForm() (cria o
* Business Object, monta o cabecalho e carrega o produto de ORIGEM - a unica
* consulta que o legado tambem faz incondicionalmente no Init, antes de
* exibir qualquer campo), e o cabecalho (cntSombra -> cnt_4c_Cabecalho).
* Campos de origem/destino, Opc_situacao e os dois botoes ficam para as
* proximas fases.
*
* Fase 4/8 - Dialogo de CAPTURA (sem Page1/Lista): o dump nao tem NENHUMA
* superficie de lista (zero BaseClass grid/pageframe, zero AddCursor/
* pColuna/RecordSource com valor, zero ControlSource com valor fora do
* CommandGroup) e TEM superficie de campos editaveis (5 TextBox fwget +
* 1 OptionGroup, nenhum ReadOnly=.T. incondicional - GetOldCPro/
* getOldCGrus/getolddpro so ficam Enabled=.F. porque espelham o produto
* de ORIGEM, que o usuario nao edita, mas nao sao campos de EXIBICAO do
* dialogo como um todo). Entao nao ha Grid nem 6 botoes CRUD a entregar
* aqui (inventa-los violaria o PILAR 1) - o entregavel real desta fase eh
* o container de botoes de ACAO do legado (cntBotoes -> cmg_4c_Botoes,
* CommandGroup com Confirmar/Cancelar), equivalente ao "cnt_4c_Botoes" do
* template CRUD. Mesmo padrao de FormSigMvChv.prg/FormSigOpCcj.prg
* (familia de dialogo OPERACIONAL flat sem Lista). Os campos (Fase 5) e
* os handlers de Click (fase de eventos/acao) ficam para as proximas
* fases.
*
* Fase 5/8 - Campos de CODIGO/GRUPO (primeira metade): este dialogo nao
* tem PageFrame/Page2 (regra da Fase 3 - form PLANO), entao os controles
* vao direto sobre THIS, igual a cnt_4c_Cabecalho/cmg_4c_Botoes. Metade 1
* cobre a dupla de linhas Codigo/Grupo (Say1/Say3/Say5/Say2 + GetOldCPro/
* getOldCGrus/getNewCpro/getNewCGrus do dump), transcrita 1:1 (Left/Top/
* Width/Height/MaxLength/InputMask/SpecialEffect/BorderColor/TabIndex/
* Enabled/DisabledBackColor/DisabledForeColor). GetOldCPro/getOldCGrus
* ficam Enabled=.F. (espelham o produto de ORIGEM - regra do dump, nao
* ReadOnly). Nomes de objeto seguem o nome da property do BO (ja criada
* nas Fases 1/2) para nao divergir (regra "BO property name DEVE bater
* com uso no Form"). A segunda metade (Descricao/Quantidade/Situacao +
* os dois labels de status) e o binding (BOParaForm/FormParaBO) ficam
* para a Fase 6.
*
* Fase 6/8 - Campos restantes (segunda metade) + binding: Say7/getolddpro
* (Descricao do produto de ORIGEM, Enabled=.F. - mesmo padrao das demais
* linhas de origem), Say6/getnewdpro (Descricao do produto NOVO, editavel -
* so usada quando o usuario digita manualmente; nos demais casos o legado
* remonta a descricao via fGerarDescrs/fGerDescritivo, que nao vieram no
* acervo - regra #27, ja documentado em SigOpRefBO.Inserir), Say4/Get_Qtd
* (Quantidade), Say19/Opc_situacao (Situacao Ativo/Inativo - ControlSource
* NUMERICO direto, Value = coluna, sem +1/-1) e os dois labels de status
* (lblOk/lblNotOk) - estes DOIS ultimos sao dead code no legado: nenhum
* metodo do SCX (Init/btnConfirmar.Click/btnSair.Click) jamais atribui
* .Visible aos dois (confirmado varrendo o dump inteiro) - ficam sempre
* ocultos, e por isso TornarControlesVisiveis tem uma excecao para NAO
* forcar .Visible = .T. neles (mesma tecnica de "containers flutuantes"
* do guia de migracao - um controle que o legado nunca exibe nao pode
* passar a aparecer so porque a ferramenta generica torna tudo visivel).
* Say19 nao declara Width/Height no dump (classe say AutoSize=.T.,
* regra CLAUDE.md #23) - como AutoSize eh no-op em Label criado por
* AddObject, a Width foi calculada para caber o texto "Situacao :" sem
* encostar no Opc_situacao (Left=190), seguindo a mesma regra.
*
* BOParaForm()/FormParaBO() fazem o binding completo entre os controles
* e as properties do SigOpRefBO (todas ja declaradas nas Fases 1/2).
* BOParaForm() tambem repete o bloco do Init legado que trava
* Opc_situacao.Enabled = .f. quando a Situacao foi fixada por parametro
* (pSit = 1 ou 2).
*
* Fase 6/8 - Validacao do campo "Grupo de Destino": este dialogo NAO tem
* lookup de picker (varrido o dump inteiro: zero fwBuscaExt/fwBuscaSel/
* fwBuscaInt/sigacess/mAddColuna) - inventar um FormBuscaAuxiliar aqui
* violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup". O que
* o legado tem no lugar eh UM Valid de verdade, no getNewCGrus: digitado
* o grupo, ele consulta SigCdGrp/SigCdGpr e GERA o codigo do produto
* novo. Essa e a validacao de campo desta fase, e esta implementada em
* ValidarGrupoDestino() (tela) + SigOpRefBO.GerarCodigoProdutoDestino()
* (regra de negocio, transcrita linha a linha - regra #17).
*
* Eventos ligados: BINDEVENT em "LostFocus" (NUNCA "KeyPress" - regra
* #47: o legado valida ao SAIR do campo, e em KeyPress a consulta
* dispararia a cada caractere) e em "GotFocus" (reproduz a primeira
* linha do When legado, que guarda o AntValue). Os tres PROCEDURE When
* do legado (getNewCpro/getNewCGrus/Get_Qtd) viram .Enabled em
* AjustarCamposPorEstado(), reaplicado sempre que Automatico/AcesGru
* mudam. O bloco do Init legado que decide se o grupo eh digitavel
* (csTmpGru.DigGprs <> 1 Or SaiAuto) esta em AplicarEstadoGrupoDestino(),
* chamado no fim do BOParaForm.
*
* Fase 7/8 - Eventos principais dos botoes. Este dialogo NAO tem a barra
* CRUD do frmcadastro (o legado herda de "form" puro: zero frmcadastro,
* zero Grupo_Op, zero pcEscolha no dump inteiro) - os UNICOS botoes do
* SCX sao os dois do cntBotoes, btnConfirmar ("Salvar") e btnSair
* ("Cancelar", Cancel = .T.). Inventar BtnIncluir/BtnAlterar/
* BtnVisualizar/BtnExcluir aqui violaria o PILAR 1 e a regra "NUNCA
* inventar"; os eventos principais desta tela sao, literalmente, esses
* dois - ligados por BINDEVENT em Buttons(1)/Buttons(2) no fim de
* ConfigurarBotoes:
*
*   BtnConfirmarClick  -> btnConfirmar.Click: valida duplicidade e codigo
*       vazio, pede a confirmacao (pulada quando SaiAuto) e dispara a
*       copia via NovoRegistro() + Salvar() do Business Object
*   BtnCancelarClick   -> btnSair.Click: devolve ao contador o sequencial
*       reservado (SigOpRefBO.CancelarCodigoReservado) e fecha sem gerar
*
* Entra tambem o ULTIMO bloco do Init legado ("If .SaiAuto /
* .cntBotoes.btnConfirmar.Click()"), em InicializarForm: quem abre com
* SaiAuto = .T. nunca exibe a tela e recebe o resultado pronto.
*
* RETORNO DO DIALOGO: o legado devolve o codigo gerado pelo RETURN do
* evento Unload ("Return ThisForm.RetCodProduto"), que so chega a quem
* abre com "DO FORM ... TO <var>" - e eh assim que SIGOPPRO e SIGMVCAB o
* abrem. O sistema novo abre por CREATEOBJECT + Show(), onde esse retorno
* eh inalcancavel, entao ele vem por ObterRetorno(). Como consequencia os
* dois botoes fecham com Hide() (funil FecharDialogo), nao com Release():
* Release destroi o objeto mesmo com o chamador segurando a referencia, e
* a leitura seguinte estouraria "is not an object". Quem chama o dialogo
* eh quem da o Release(), DEPOIS de ler. O PROCEDURE Unload continua
* existindo, lendo o cache preenchido no fechamento e no Destroy.
*
* Fase 8/8 - Consolidacao final. O dialogo ja estava funcionalmente
* completo ao fim da Fase 7 (os dois unicos botoes do SCX ligados, os
* cinco campos editaveis mapeados nos dois sentidos, a validacao do
* Grupo de Destino e os tres When do legado traduzidos para .Enabled).
* Esta fase fecha a migracao com:
*
*   - BtnCancelarClick: o handler do botao de abandono passou a usar o
*     nome canonico do projeto, em vez do nome do objeto legado
*     (btnSair). Ver o bloco do proprio metodo.
*   - FormParaBO()/BOParaForm(): conferidos campo a campo contra as
*     properties do SigOpRefBO - os 5 controles editaveis (codigo, grupo,
*     descricao, quantidade e situacao do produto NOVO) vao para o BO, e
*     os 3 de ORIGEM mais os 5 do destino voltam dele. As properties de
*     ESTADO do legado (SaiAuto/IdentFixa/CadPro/Dopes/SituacaoIt), que
*     nao tem controle na tela, sao alimentadas pelos parametros do Init
*     em CarregarProdutoOrigem.
*
* Os quatro nomes canonicos restantes do template CRUD NAO se aplicam a
* esta tela e inventa-los violaria o PILAR 1:
*
*   - CarregarLista()/AjustarBotoesPorModo(): nao ha Page1 de Lista nem
*     grade alguma no SCX (analise.json: temGrid = false), e tampouco
*     existe o conceito de MODO (zero pcEscolha no dump inteiro) - este
*     dialogo tem um unico fluxo, do Init ate o botao de acao.
*   - HabilitarCampos(): o equivalente fiel ja existe com o nome que
*     descreve o que o legado de fato faz - AjustarCamposPorEstado(),
*     transcricao dos tres PROCEDURE When do SCX; um HabilitarCampos
*     generico por modo nao teria modo nenhum para ler.
*   - LimparCampos(): o legado nunca limpa a tela - ele fecha. O dialogo
*     eh de uso unico (Init carrega o produto de origem, o botao de acao
*     gera e fecha), entao nao ha caminho de volta a limpar.
*==============================================================================

DEFINE CLASS FormSigOpRef AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SigOpRef.SCX)
    Width        = 583
    Height       = 282
    AutoCenter   = .T.
    Caption      = "Cadastro de Produto"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ShowTips     = .T.
    ClipControls = .F.
    Themes       = .F.

    *-- Parametros recebidos em Init() (legado pSit/pAut/pIFx/pCad/pDop/pGru) -
    *-- guardados aqui porque o Business Object so existe depois de
    *-- DODEFAULT() disparar FormBase.Init() -> InicializarForm().
    this_cParCodProdOrigem = ""
    this_nParSituacao      = 0
    this_lParSaiAuto       = .F.
    this_nParIdentFixa     = 0
    this_nParCadPro        = 0
    this_cParDopes         = ""
    this_cParGrupoDestino  = ""

    *-- Guarda de reentrancia do handler do "Grupo de Destino": ValidarGrupoDestino
    *-- esta ligado a LostFocus e escreve no .Value/.Enabled de outros campos,
    *-- o que pode devolver o foco a este - sem a guarda o proprio LostFocus
    *-- redispararia a consulta.
    this_lEmValidacaoGrupo = .F.

    *-- Guarda de reentrancia do botao "Salvar": o Click pode ser disparado
    *-- duas vezes (duplo clique, ou o disparo automatico do SaiAuto somado a
    *-- um clique do usuario) e cada passagem GERA UM PRODUTO - sem a guarda o
    *-- mesmo pedido criaria dois registros em SigCdPro.
    this_lEmGravacao = .F.

    *-- Cache do retorno do dialogo (RetCodProduto do legado). Preenchido no
    *-- FUNIL de fechamento e de novo no Destroy, enquanto o Business Object
    *-- ainda existe: o Unload - que devolve o valor a quem abriu com
    *-- "DO FORM ... TO <var>" - dispara DEPOIS do Destroy, e nesse ponto
    *-- FormBase.Destroy ja fez this_oBusinessObject = .NULL.
    *-- Comeca com " " (um espaco), igual ao legado ("ThisForm.RetCodproduto
    *-- = ' '"); EMPTY() trata vazio e espaco igual, entao o teste do
    *-- chamador ("If Not Empty(lcCodProduto)") nao muda.
    this_cRetCodProduto = " "

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos parametros do Init legado e reproduz a mesma
    * exigencia: o produto de origem (pPro) tem de ser informado - sem ele o
    * dialogo nao tem o que replicar. Os demais parametros sao opcionais,
    * com os mesmos defaults do legado (Iif(Type(...)...)). Em modo de teste
    * automatizado (TestFormWrapper/ValidarUIFidelity) a exigencia e
    * dispensada, para permitir instanciar o form so para validar a
    * estrutura visual - mesma excecao ja aplicada na familia SigOp
    * (FormSigOpCcj.Init).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCodProdOrigem, par_nSituacao, par_lSaiAuto, ;
            par_nIdentFixa, par_nCadPro, par_cDopes, par_cGrupoDestino)
        LOCAL loc_lParametrosOk, loc_lSucesso, loc_lModoTeste
        loc_lParametrosOk = .T.
        loc_lSucesso = .F.

        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

        IF !loc_lModoTeste
            IF VARTYPE(par_cCodProdOrigem) != "C" OR EMPTY(ALLTRIM(par_cCodProdOrigem))
                MsgAviso("O produto de origem informado n" + CHR(227) + "o " + ;
                    CHR(233) + " v" + CHR(225) + "lido...", "Par" + CHR(226) + ;
                    "metros Inv" + CHR(225) + "lidos!")
                loc_lParametrosOk = .F.
            ENDIF
        ENDIF

        IF loc_lParametrosOk
            THIS.this_cParCodProdOrigem = IIF(VARTYPE(par_cCodProdOrigem) = "C", par_cCodProdOrigem, "")
            THIS.this_nParSituacao      = IIF(VARTYPE(par_nSituacao) = "N", par_nSituacao, 0)
            THIS.this_lParSaiAuto       = IIF(VARTYPE(par_lSaiAuto) = "L", par_lSaiAuto, .F.)
            THIS.this_nParIdentFixa     = IIF(VARTYPE(par_nIdentFixa) = "N", par_nIdentFixa, 0)
            THIS.this_nParCadPro        = IIF(VARTYPE(par_nCadPro) = "N", par_nCadPro, 0)
            THIS.this_cParDopes         = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
            THIS.this_cParGrupoDestino  = IIF(VARTYPE(par_cGrupoDestino) = "C", par_cGrupoDestino, "")

            loc_lSucesso = DODEFAULT()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, monta a estrutura visual
    * basica (cabecalho) e carrega o produto de ORIGEM. Nao ha Grid nem
    * PageFrame neste dialogo - o SCX legado nao tem nenhum dos dois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lModoTeste, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpRefBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCamposCodigos()
                THIS.ConfigurarCamposRestantes()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                    (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                IF loc_lModoTeste OR EMPTY(ALLTRIM(THIS.this_cParCodProdOrigem))
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = THIS.CarregarProdutoOrigem()
                ENDIF

                IF loc_lSucesso
                    THIS.BOParaForm()
                    THIS.TornarControlesVisiveis(THIS)

                    *-- legado, ULTIMO bloco do Init:
                    *--   If .SaiAuto
                    *--       .cntBotoes.btnConfirmar.Click()
                    *--   EndIf
                    *-- Quem abre com SaiAuto = .T. nunca exibe a tela (o
                    *-- chamador legado usa "DO FORM ... NOSHOW"): a copia roda
                    *-- aqui mesmo e o resultado sai por ObterRetorno(). Em
                    *-- modo de teste automatizado nao dispara - o disparo
                    *-- GRAVA no banco, e instanciar o form para validar
                    *-- estrutura nao pode criar produto nenhum.
                    IF !loc_lModoTeste AND THIS.this_oBusinessObject.this_lSaiAuto
                        THIS.BtnConfirmarClick()
                    ENDIF
                ENDIF
            ELSE
                MsgErro("Erro ao criar Business Object de Replica" + CHR(231) + ;
                    CHR(227) + "o de Produto." + CHR(13) + "VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpRef")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - SigOpRef legado NAO TEM PageFrame: layout PLANO
    * com fundo new_background.jpg (Picture do dump), igual ao padrao de
    * dialogos OPERACIONAL pequenos sem abas (ver FormSigOpCcj.prg). Mantido
    * so para configurar a aparencia base do form - nao cria pagina alguma.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
    * Original: cntSombra Top=0, Left=0, Width=800 (boilerplate do template -
    * regra CLAUDE.md #11: usar THIS.Width, nunca o literal do SCX),
    * Height=80, BackColor=100,100,100; lblSombra/lblTitulo Left=10,
    * Width=THIS.Width-21, ForeColor preto/branco, FontSize=18.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Di" + CHR(225) + "logo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup cntBotoes do legado (ButtonCount=2):
    * Buttons(1) = Command1/btnConfirmar ("Salvar" - realiza a copia do
    * produto), Buttons(2) = Command2/btnSair ("Cancelar" - fecha sem
    * gravar, Cancel=.T.). Nao ha Page/Lista neste dialogo (regra #30: o
    * container flutua direto sobre o Form, por cima da faixa do
    * cabecalho - por isso eh chamado DEPOIS de ConfigurarCabecalho, igual
    * ao padrao canonico de saida da familia CRUD). Geometria, icones,
    * captions e ToolTipText transcritos do dump (SIGOPREF.cntBotoes):
    * Top=-2, Left=425, Width=160, Height=85; botoes 75x75 em
    * Left=5/80, Top=5, Comic Sans MS 8 bold italic.
    *
    * O BINDEVENT dos Click (BtnConfirmarClick/BtnCancelarClick) e a
    * implementacao dos handlers sao a Fase 7/8 e ja estao aqui: os dois
    * botoes do legado (os UNICOS deste dialogo) sao ligados no fim deste
    * metodo, junto da criacao do CommandGroup.
    *
    * No legado cada botao tem o SEU Click (cntBotoes.btnConfirmar.Click e
    * cntBotoes.btnSair.Click), nao o Click do grupo - por isso o BINDEVENT
    * vai em Buttons(1)/Buttons(2), um por botao, e nao no CommandGroup
    * (que dispararia um handler unico para os dois). Os handlers sao PUBLIC
    * de proposito: BINDEVENT em metodo PROTECTED falha em SILENCIO (regra
    * #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCmg, loc_oErro

        TRY
            THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
            loc_oCmg = THIS.cmg_4c_Botoes
            WITH loc_oCmg
                .Top           = -2
                .Left          = 425
                .Width         = 160
                .Height        = 85
                .ButtonCount   = 2
                .AutoSize      = .T.
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 0

                WITH .Buttons(1)
                    .Top           = 5
                    .Left          = 5
                    .Width         = 75
                    .Height        = 75
                    .AutoSize      = .F.
                    .FontName      = "Comic Sans MS"
                    .FontSize      = 8
                    .FontBold      = .T.
                    .FontItalic    = .T.
                    .WordWrap      = .T.
                    .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    *-- "\<" = tecla de acesso Alt+S do legado
                    *-- (Command1.Caption = "\<Salvar").
                    .Caption       = "\<Salvar"
                    .MousePointer  = 15
                    .ToolTipText   = "Realizar a C" + CHR(243) + "pia de Produtos"
                    .SpecialEffect = 0
                    .PicturePosition = 13
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top          = 5
                    .Left         = 80
                    .Width        = 75
                    .Height       = 75
                    .FontName     = "Comic Sans MS"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .FontItalic   = .T.
                    .WordWrap     = .T.
                    .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel       = .T.
                    *-- "\<" = tecla de acesso Alt+C do legado
                    *-- (Command2.Caption = "\<Cancelar").
                    .Caption      = "\<Cancelar"
                    .MousePointer = 15
                    .ToolTipText  = "[Esc] Sair Sem Gravar os Dados"
                    .SpecialEffect = 0
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .F.
                ENDWITH
            ENDWITH

            *-- legado: cntBotoes.btnConfirmar.Click / cntBotoes.btnSair.Click
            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnCancelarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCodigos - Fase 5/8 (primeira metade dos campos): as
    * duas linhas de Codigo/Grupo do dump (Say1/Say3/GetOldCPro/getOldCGrus
    * = ORIGEM, Say5/Say2/getNewCpro/getNewCGrus = DESTINO). Controles direto
    * sobre THIS (form PLANO, sem PageFrame - regra da Fase 3). Geometria,
    * MaxLength, InputMask, SpecialEffect, BorderColor, Enabled e cores de
    * desabilitado transcritos LITERALMENTE do dump do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCodigos()
        LOCAL loc_oErro

        TRY
            *-- Say1 "Codigo de Origem :"
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "C" + CHR(243) + "digo de Origem :"
                .Height    = 15
                .Left      = 98
                .Top       = 93
                .Width     = 94
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- GetOldCPro -> this_cCodProdOrigem (produto de ORIGEM, Enabled=.F.)
            THIS.AddObject("txt_4c_CodProdOrigem", "TextBox")
            WITH THIS.txt_4c_CodProdOrigem
                .Value             = ""
                .Height            = 23
                .Left              = 197
                .Top               = 89
                .Width             = 108
                .MaxLength         = 14
                .SpecialEffect     = 1
                .TabIndex          = 2
                .Enabled           = .F.
                .DisabledBackColor = RGB(251, 254, 226)
                .DisabledForeColor = RGB(36, 84, 155)
                .BorderColor       = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH

            *-- Say3 "Grupo de Origem :"
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Grupo de Origem :"
                .Height    = 15
                .Left      = 332
                .Top       = 93
                .Width     = 90
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- getOldCGrus -> this_cGrupoOrigem (produto de ORIGEM, Enabled=.F.)
            THIS.AddObject("txt_4c_GrupoOrigem", "TextBox")
            WITH THIS.txt_4c_GrupoOrigem
                .Value             = ""
                .Height            = 23
                .Left              = 435
                .Top               = 89
                .Width             = 31
                .MaxLength         = 10
                .SpecialEffect     = 1
                .TabIndex          = 10
                .Enabled           = .F.
                .DisabledBackColor = RGB(251, 254, 226)
                .DisabledForeColor = RGB(36, 84, 155)
                .BorderColor       = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH

            *-- Say5 "Codigo de Destino :"
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "C" + CHR(243) + "digo de Destino :"
                .Height    = 15
                .Left      = 96
                .Top       = 118
                .Width     = 96
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- getNewCpro -> this_cCodProdDestino (produto NOVO, editavel)
            THIS.AddObject("txt_4c_CodProdDestino", "TextBox")
            WITH THIS.txt_4c_CodProdDestino
                .Value         = ""
                .Height        = 23
                .Left          = 197
                .Top           = 114
                .Width         = 108
                .MaxLength     = 14
                .SpecialEffect = 1
                .TabIndex      = 3
                .BorderColor   = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Say2 "Grupo de Destino :"
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Grupo de Destino :"
                .Height    = 15
                .Left      = 330
                .Top       = 118
                .Width     = 92
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- getNewCGrus -> this_cGrupoDestino (produto NOVO, editavel)
            THIS.AddObject("txt_4c_GrupoDestino", "TextBox")
            WITH THIS.txt_4c_GrupoDestino
                .Value         = ""
                .Height        = 23
                .Left          = 435
                .Top           = 114
                .Width         = 31
                .MaxLength     = 3
                .SpecialEffect = 1
                .TabIndex      = 1
                .BorderColor   = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Eventos do campo "Grupo de Destino" (getNewCGrus do legado).
            *-- O legado valida no Valid, isto eh, ao SAIR do campo - logo o
            *-- evento certo eh "LostFocus", NUNCA "KeyPress" (regra #47: um
            *-- handler ligado a KeyPress dispararia a consulta e a geracao do
            *-- codigo a cada caractere, e o usuario nao conseguiria terminar
            *-- de digitar o grupo). "Valid" nao eh confiavel em BINDEVENT de
            *-- TextBox (regra #3), e o legado nao tem KeyPress neste campo.
            *--
            *-- GotFocus reproduz o When do legado ("ThisForm.Antvalue =
            *-- This.Value"), que roda ANTES de o campo receber o foco e
            *-- guarda o valor anterior - eh ele que alimenta o guard de
            *-- "valor nao mudou" no inicio do Valid.
            BINDEVENT(THIS.txt_4c_GrupoDestino, "GotFocus", THIS, "GrupoDestinoGotFocus")
            BINDEVENT(THIS.txt_4c_GrupoDestino, "LostFocus", THIS, "ValidarGrupoDestino")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCamposCodigos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposRestantes - Fase 6/8 (segunda metade dos campos): as
    * duas linhas de Descricao (Say7/getolddpro = ORIGEM, Say6/getnewdpro =
    * DESTINO - os captions de Say6/Say7 no dump SAO "C"+CHR(243)+"digo de
    * Destino :"/"C"+CHR(243)+"digo de Origem :", duplicando literalmente
    * Say5/Say1: peculiaridade do SCX legado, transcrita 1:1 - regra PILAR 1,
    * nao se "corrige" rotulo do legado), a linha de Quantidade (Say4/
    * Get_Qtd) e a linha de Situacao (Say19/Opc_situacao), alem dos dois
    * labels de status (lblOk/lblNotOk) que o legado cria mas nunca exibe
    * (ver nota no cabecalho do arquivo - ficam sempre Visible = .F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposRestantes()
        LOCAL loc_oErro

        TRY
            *-- Say7 "Codigo de Origem :" (rotulo da linha de Descricao ORIGEM)
            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "C" + CHR(243) + "digo de Origem :"
                .Height    = 15
                .Left      = 98
                .Top       = 170
                .Width     = 94
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- getolddpro -> this_cDescProdOrigem (produto de ORIGEM, Enabled=.F.)
            THIS.AddObject("txt_4c_DescProdOrigem", "TextBox")
            WITH THIS.txt_4c_DescProdOrigem
                .Value             = ""
                .Height            = 23
                .Left              = 196
                .Top               = 166
                .Width             = 290
                .SpecialEffect     = 1
                .TabIndex          = 4
                .Enabled           = .F.
                .DisabledBackColor = RGB(251, 254, 226)
                .DisabledForeColor = RGB(36, 84, 155)
                .BorderColor       = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH

            *-- Say6 "Codigo de Destino :" (rotulo da linha de Descricao DESTINO)
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "C" + CHR(243) + "digo de Destino :"
                .Height    = 15
                .Left      = 96
                .Top       = 195
                .Width     = 96
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- getnewdpro -> this_cDescProdDestino (produto NOVO, editavel -
            *-- so usada no modo manual; ver nota em SigOpRefBO.Inserir)
            THIS.AddObject("txt_4c_DescProdDestino", "TextBox")
            WITH THIS.txt_4c_DescProdDestino
                .Value         = ""
                .Height        = 23
                .Left          = 196
                .Top           = 191
                .Width         = 290
                .MaxLength     = 40
                .SpecialEffect = 1
                .TabIndex      = 5
                .BorderColor   = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Say4 "Quantidade :"
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Quantidade :"
                .Height    = 15
                .Left      = 357
                .Top       = 144
                .Width     = 65
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Get_Qtd -> this_nQuantidade
            THIS.AddObject("txt_4c_Quantidade", "TextBox")
            WITH THIS.txt_4c_Quantidade
                .Value         = 1
                .Height        = 23
                .Left          = 435
                .Top           = 140
                .Width         = 31
                .FontBold      = .T.
                .InputMask     = "99"
                .MaxLength     = 2
                .SpecialEffect = 1
                .TabIndex      = 6
                .BackColor     = RGB(231, 254, 253)
                .BorderColor   = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Say19 "Situacao :" - classe say sem Width/Height no dump
            *-- (AutoSize=.T. no legado; regra CLAUDE.md #23 - Width calculada
            *-- para caber o texto sem encostar no Opc_situacao em Left=190)
            THIS.AddObject("lbl_4c_Label19", "Label")
            WITH THIS.lbl_4c_Label19
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .Height    = 15
                .Left      = 142
                .Top       = 144
                .Width     = 46
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Opc_situacao -> this_nSituacao (ControlSource numerico direto:
            *-- Value = 1 Ativo / 2 Inativo, sem +1/-1 - regra #188)
            THIS.AddObject("opt_4c_Situacao", "OptionGroup")
            WITH THIS.opt_4c_Situacao
                .Top           = 143
                .Left          = 190
                .Width         = 129
                .Height        = 17
                .ButtonCount   = 2
                .AutoSize      = .F.
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Visible       = .T.

                WITH .Buttons(1)
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Ativ\<o"
                    .Height    = 15
                    .Left      = 5
                    .Top       = 1
                    .Width     = 43
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH

                WITH .Buttons(2)
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "I\<nativo"
                    .Height    = 17
                    .Left      = 63
                    .Top       = 0
                    .Width     = 61
                    .ForeColor = RGB(0, 0, 0)
                ENDWITH
            ENDWITH

            *-- lblNotOk - dead code no legado (nunca recebe .Visible = .T. em
            *-- nenhum metodo do SCX) - criado para fidelidade estrutural, mas
            *-- permanece OCULTO para sempre (ver TornarControlesVisiveis).
            THIS.AddObject("lbl_4c_LblNotOk", "Label")
            WITH THIS.lbl_4c_LblNotOk
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 9
                .Alignment  = 2
                .BackStyle  = 0
                .Caption    = "Novo Produto N" + CHR(227) + "o Foi Criado!"
                .Height     = 17
                .Left       = 147
                .Top        = 226
                .Width      = 306
                .ForeColor  = RGB(192, 46, 20)
                .Visible    = .F.
            ENDWITH

            *-- lblOk - mesma situacao: dead code, permanece OCULTO para sempre.
            THIS.AddObject("lbl_4c_LblOk", "Label")
            WITH THIS.lbl_4c_LblOk
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 9
                .Alignment  = 2
                .BackStyle  = 0
                .Caption    = "Novo Produto Criado!"
                .Height     = 37
                .Left       = 144
                .Top        = 239
                .Width      = 306
                .ForeColor  = RGB(0, 128, 0)
                .Visible    = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.ConfigurarCamposRestantes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia as properties do Business Object (ja carregadas por
    * CarregarProdutoOrigem) para os controles de tela. Equivalente ao bloco
    * final do Init legado que preenche GetOldCPro/GetOldCGrus/getNewCGrus/
    * getOldDpro/Get_Qtd e trava Opc_situacao quando a Situacao foi fixada
    * por parametro (pSit = 1 ou 2).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        *-- Produto de ORIGEM (somente exibicao)
        THIS.txt_4c_CodProdOrigem.Value  = ALLTRIM(NVL(loc_oBO.this_cCodProdOrigem, ""))
        THIS.txt_4c_GrupoOrigem.Value    = ALLTRIM(NVL(loc_oBO.this_cGrupoOrigem, ""))
        THIS.txt_4c_DescProdOrigem.Value = ALLTRIM(NVL(loc_oBO.this_cDescProdOrigem, ""))

        *-- Produto NOVO (editavel pelo usuario)
        THIS.txt_4c_CodProdDestino.Value  = ALLTRIM(NVL(loc_oBO.this_cCodProdDestino, ""))
        THIS.txt_4c_GrupoDestino.Value    = ALLTRIM(NVL(loc_oBO.this_cGrupoDestino, ""))
        THIS.txt_4c_DescProdDestino.Value = ALLTRIM(NVL(loc_oBO.this_cDescProdDestino, ""))
        THIS.txt_4c_Quantidade.Value      = IIF(VARTYPE(loc_oBO.this_nQuantidade) = "N" AND loc_oBO.this_nQuantidade > 0, loc_oBO.this_nQuantidade, 1)
        THIS.opt_4c_Situacao.Value        = IIF(INLIST(loc_oBO.this_nSituacao, 1, 2), loc_oBO.this_nSituacao, 1)

        *-- legado: If (.Situacaoit = 1) Or (.Situacaoit = 2) -> Opc_situacao.Enabled = .f.
        THIS.opt_4c_Situacao.Enabled = !(loc_oBO.this_nSituacaoIt = 1 OR loc_oBO.this_nSituacaoIt = 2)

        *-- legado (Init), bloco que fecha o preenchimento da tela:
        *--   If (csTmpGru.DigGprs <> 1) Or .SaiAuto
        *--       .AcesGru = .f.
        *--       .GetNewCGrus.Valid()
        *--       .GetNewCGrus.ReadOnly = .t.
        *--   Else
        *--       .AcesGru = .t.
        *--       .GetNewCGrus.ReadOnly = .f.
        *--       .GetNewCGrus.Setfocus
        *--   EndIf
        THIS.AplicarEstadoGrupoDestino()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia os campos editaveis de tela para o Business Object,
    * imediatamente antes de validar/gravar (equivalente a leitura de
    * Thisform.getNewCpro/getNewCGrus/getnewdpro/Get_Qtd/Opc_situacao no
    * inicio de btnConfirmar.Click). Chamado pelo handler de Confirmar na
    * Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cCodProdDestino  = ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, ""))
        loc_oBO.this_cGrupoDestino    = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))
        loc_oBO.this_cDescProdDestino = ALLTRIM(NVL(THIS.txt_4c_DescProdDestino.Value, ""))
        loc_oBO.this_nQuantidade      = IIF(VARTYPE(THIS.txt_4c_Quantidade.Value) = "N", THIS.txt_4c_Quantidade.Value, VAL(THIS.txt_4c_Quantidade.Value))
        loc_oBO.this_nSituacao        = THIS.opt_4c_Situacao.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarEstadoGrupoDestino - Transcricao do bloco final do Init legado
    * que decide se o GRUPO de destino eh digitavel e, quando nao eh, ja
    * dispara a geracao do codigo:
    *
    *   If (csTmpGru.DigGprs <> 1) Or .SaiAuto
    *       .AcesGru = .f.
    *       .GetNewCGrus.Valid()
    *       .GetNewCGrus.ReadOnly = .t.
    *   Else
    *       .AcesGru = .t.
    *       .GetNewCGrus.ReadOnly = .f.
    *       .GetNewCGrus.Setfocus
    *   EndIf
    *
    * O SetFocus so faz sentido com a tela ja visivel; em modo de teste
    * automatizado (sem Show) ele eh dispensado, igual as demais consultas.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarEstadoGrupoDestino()
        LOCAL loc_oBO, loc_lModoTeste

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        IF loc_oBO.this_nGrupoDestinoDigGprs != 1 OR loc_oBO.this_lSaiAuto
            loc_oBO.this_lAcesGru = .F.

            *-- legado: .GetNewCGrus.Valid() - a geracao do codigo roda JA no
            *-- Init quando o usuario nao tem acesso a digitar o grupo.
            THIS.ValidarGrupoDestino()

            THIS.txt_4c_GrupoDestino.ReadOnly = .T.
        ELSE
            loc_oBO.this_lAcesGru = .T.
            THIS.txt_4c_GrupoDestino.ReadOnly = .F.

            IF !loc_lModoTeste AND THIS.Visible AND THIS.txt_4c_GrupoDestino.Enabled
                THIS.txt_4c_GrupoDestino.SetFocus()
            ENDIF
        ENDIF

        THIS.AjustarCamposPorEstado()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposPorEstado - Reproduz os tres PROCEDURE When do legado, que
    * controlam quais campos aceitam digitacao conforme o estado do processo:
    *
    *   getNewCpro.When  -> Return Not ThisForm.Automatico
    *   getNewCGrus.When -> Return (ThisForm.AcesGru)
    *   Get_Qtd.When     -> Return (ThisForm.Automatico And Not ThisForm.SaiAuto)
    *
    * Em VFP9 o When de um controle criado por AddObject nao eh alcancavel por
    * BINDEVENT de forma confiavel (e BINDEVENT descarta o retorno do
    * delegate, logo um When ligado assim nao bloquearia nada - regra #3).
    * O equivalente fiel eh traduzir cada When para .Enabled e reaplicar
    * sempre que o estado muda: no fim do BOParaForm (via
    * AplicarEstadoGrupoDestino) e no fim de ValidarGrupoDestino, que sao os
    * dois unicos pontos onde Automatico/AcesGru mudam.
    *
    * PUBLIC de proposito (regra #3/#51): e chamado pelos handlers ligados por
    * BINDEVENT e pode ser acionado pelo harness de teste automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarCamposPorEstado()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        *-- getNewCpro.When: Return Not ThisForm.Automatico
        THIS.txt_4c_CodProdDestino.Enabled = !loc_oBO.this_lAutomatico

        *-- getNewCGrus.When: Return (ThisForm.AcesGru)
        THIS.txt_4c_GrupoDestino.Enabled = loc_oBO.this_lAcesGru

        *-- Get_Qtd.When: Return (ThisForm.Automatico And Not ThisForm.SaiAuto)
        THIS.txt_4c_Quantidade.Enabled = (loc_oBO.this_lAutomatico AND !loc_oBO.this_lSaiAuto)
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDestinoGotFocus - Reproduz a primeira linha do getNewCGrus.When do
    * legado ("ThisForm.Antvalue = This.Value"), que roda ANTES de o campo
    * receber o foco e guarda o valor que esta la. E esse valor que o guard do
    * inicio do Valid compara para nao repetir a consulta/geracao quando o
    * usuario entra e sai do campo sem alterar nada.
    *
    * PUBLIC: ligado por BINDEVENT (regra #3 - PROTECTED falha em silencio).
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDestinoGotFocus()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cAntValue = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoDestino - Handler do campo "Grupo de Destino", equivalente ao
    * PROCEDURE Valid do getNewCGrus legado:
    *
    *   If (ThisForm.AntValue = This.Value) And Not Empty(Thisform.GetNewCpro.Value)
    *       Return .t.
    *   EndIf
    *   ThisForm.Automatico = .f.
    *   lcCGrus = Alltrim(This.Value)
    *   ... (consulta SigCdGrp / SigCdGpr e monta lcNewCPros) ...
    *   With ThisForm
    *       .getNewCpro.Value = lcNewCPros
    *       .getNewCpro.Refresh
    *   EndWith
    *   If Not Empty(lcnewCpros)
    *       ThisForm.Automatico = .t.
    *   EndIf
    *
    * O calculo propriamente dito (a REGRA DE NEGOCIO: tipo de geracao,
    * mascaras, fGerUniqueKey) fica no Business Object
    * (SigOpRefBO.GerarCodigoProdutoDestino), transcrito linha a linha do
    * legado - aqui ficam so o guard de "valor nao mudou", a leitura/escrita
    * dos controles e a flag Automatico, que sao responsabilidade da tela.
    *
    * IMPORTANTE (regra #50): grupo cujo tipo de geracao NAO produz codigo
    * automatico (lnTpPro fora de {2,4,5}) devolve "" e o legado grava esse ""
    * no campo do codigo, deixando Automatico = .F. para o usuario digitar a
    * mao - nao eh erro, nao avisa nada e NAO se apaga o grupo digitado.
    *
    * PUBLIC: ligado por BINDEVENT (regra #3) e chamado por
    * AplicarEstadoGrupoDestino, que reproduz o ".GetNewCGrus.Valid()" do Init.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoDestino()
        LOCAL loc_oBO, loc_cGrus, loc_cNewCPros, loc_lModoTeste, ;
            loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Guarda de reentrancia: o handler esta ligado a LostFocus e escreve
        *-- no .Value/.Enabled de outros campos, o que pode devolver o foco a
        *-- este - sem a guarda o LostFocus redispararia a consulta.
        IF THIS.this_lEmValidacaoGrupo
            RETURN
        ENDIF

        *-- Sem conexao (harness de teste automatizado / ValidarUIFidelity) a
        *-- consulta nao roda - mesma excecao de InicializarForm.
        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        IF loc_lModoTeste
            RETURN
        ENDIF

        loc_oBO   = THIS.this_oBusinessObject
        loc_cGrus = ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, ""))

        *-- legado: If (ThisForm.AntValue = This.Value) And Not
        *--             Empty(Thisform.GetNewCpro.Value) -> Return .t.
        IF ALLTRIM(NVL(loc_oBO.this_cAntValue, "")) == loc_cGrus AND ;
                !EMPTY(ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, "")))
            RETURN
        ENDIF

        *-- A partir daqui o corpo roda sob TRY/CATCH: o handler eh disparado
        *-- por LostFocus, fora de qualquer TRY do form, e sem isto uma falha
        *-- aqui apareceria como "Program Error" CRU do VFP em vez do dialogo
        *-- do sistema. A flag de reentrancia eh liberada DEPOIS do ENDTRY,
        *-- para valer tambem quando o CATCH dispara (senao ela travaria ligada
        *-- e mataria a validacao pelo resto da vida do form).
        THIS.this_lEmValidacaoGrupo = .T.

        TRY
            *-- legado: ThisForm.Automatico = .f. (antes de tentar gerar)
            loc_oBO.this_lAutomatico   = .F.
            loc_oBO.this_cGrupoDestino = loc_cGrus

            loc_cNewCPros = loc_oBO.GerarCodigoProdutoDestino(loc_cGrus)

            *-- legado: .getNewCpro.Value = lcNewCPros / .getNewCpro.Refresh
            *-- (atribui MESMO vazio - e assim que o legado devolve o campo ao
            *-- usuario quando o grupo nao gera codigo automatico)
            loc_oBO.this_cCodProdDestino      = loc_cNewCPros
            THIS.txt_4c_CodProdDestino.Value  = loc_cNewCPros
            THIS.txt_4c_CodProdDestino.Refresh()

            *-- legado: If Not Empty(lcnewCpros) -> ThisForm.Automatico = .t.
            IF !EMPTY(loc_cNewCPros)
                loc_oBO.this_lAutomatico = .T.
            ENDIF

            *-- Automatico mudou: reaplicar os When do legado (getNewCpro e
            *-- Get_Qtd dependem dele)
            THIS.AjustarCamposPorEstado()

            *-- legado: o AntValue eh atualizado pelo When ao entrar no campo;
            *-- guardar aqui tambem evita repetir a consulta quando o controle
            *-- perde e recupera o foco sem o usuario digitar nada.
            loc_oBO.this_cAntValue = loc_cGrus
        CATCH TO loc_oErro
            loc_lProsseguir = .F.

            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpRef.ValidarGrupoDestino")
        ENDTRY

        THIS.this_lEmValidacaoGrupo = .F.

        RETURN loc_lProsseguir
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProdutoOrigem - Equivalente a CursorQuery([SigCdPro],[csTmpPro],
    * [CPros],pPro,[CPros,CGrus,Dpros]) do Init legado: busca o produto de
    * origem por codigo e delega ao Business Object (CarregarDoCursor, ja
    * escrito na Fase 1/2), que mapeia Cpros/Cgrus/Dpros para as properties
    * do produto de ORIGEM. Tambem repassa os demais parametros recebidos em
    * Init() (situacao/saiauto/identfixa/cadpro/dopes) e inicializa o grupo
    * de destino igual ao grupo de origem quando nenhum foi informado -
    * mesma regra do legado (lcGrp = Iif(Type(pGru)=C, pGru, csTmpPro.Cgrus)).
    *
    * Se o produto de origem nao existir, aborta - exatamente como o legado
    * fazia ao nao conseguir popular csTmpPro (MessageBox + Return .f.).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarProdutoOrigem()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ProdOrigemRef")
                USE IN cursor_4c_ProdOrigemRef
            ENDIF

            loc_cSQL = "SELECT cpros, cgrus, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cParCodProdOrigem), 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdOrigemRef")

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar o produto de origem:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ProdOrigemRef")
                    THIS.this_oBusinessObject.this_nSituacaoIt = THIS.this_nParSituacao
                    THIS.this_oBusinessObject.this_lSaiAuto    = THIS.this_lParSaiAuto
                    THIS.this_oBusinessObject.this_nIdentFixa  = THIS.this_nParIdentFixa
                    THIS.this_oBusinessObject.this_nCadPro     = THIS.this_nParCadPro
                    THIS.this_oBusinessObject.this_cDopes      = THIS.this_cParDopes

                    THIS.this_oBusinessObject.this_cGrupoDestino = ;
                        IIF(!EMPTY(ALLTRIM(THIS.this_cParGrupoDestino)), ;
                            ALLTRIM(THIS.this_cParGrupoDestino), ;
                            THIS.this_oBusinessObject.this_cGrupoOrigem)

                    IF THIS.this_nParSituacao = 1 OR THIS.this_nParSituacao = 2
                        THIS.this_oBusinessObject.this_nSituacao = THIS.this_nParSituacao
                    ENDIF

                    *-- legado (Init), nesta mesma ordem e com o mesmo aborto
                    *-- quando a consulta falha:
                    *--   CursorQuery([SigCdPam],[crSigCdPam],.f.,.f.,
                    *--               [CodProds, DigProds, TpCbars, CUnis])
                    *--   lcGrp = Iif(Type([pGru]) = [C], pGru, csTmpPro.Cgrus)
                    *--   CursorQuery([SigCdGrp],[csTmpGru],[CGrus],lcGrp,
                    *--               [CGrus, DigGprs])
                    *-- Os parametros do sistema entram ANTES do grupo porque o
                    *-- DigProds/CodProds deles eh o fallback usado na geracao
                    *-- do codigo do produto novo.
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarParametrosSistema()

                    IF loc_lSucesso
                        loc_lSucesso = THIS.this_oBusinessObject.CarregarGrupoDestino( ;
                            THIS.this_oBusinessObject.this_cGrupoDestino)
                    ENDIF
                ELSE
                    *-- legado: "A busca nao encontrou o registro" - mesma
                    *-- condicao de ExisteProduto(.F.) em SigOpRefBO.ValidarDados
                    MsgErro("O Produto de Origem Informado N" + CHR(227) + "o Existe!!!", "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdOrigemRef")
                USE IN cursor_4c_ProdOrigemRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpRef.CarregarProdutoOrigem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
    * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
    * metodo fica generico para reaproveitar nas fases seguintes).
    *
    * EXCECAO: lbl_4c_LblOk/lbl_4c_LblNotOk (lblOk/lblNotOk do legado) nunca
    * recebem .Visible = .T. em NENHUM metodo do SCX original (Init,
    * btnConfirmar.Click, btnSair.Click) - sao dead code herdado, e tornar
    * esses dois visiveis aqui faria a tela mostrar algo que o legado jamais
    * mostrou. Mesma tecnica de "containers flutuantes" do guia de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF INLIST(UPPER(loc_oControl.Name), "LBL_4C_LBLOK", "LBL_4C_LBLNOTOK")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC


    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Fase 7/8. Handler do botao "Salvar"
    * (cntBotoes.btnConfirmar do legado), a acao principal do dialogo: gera o
    * PRODUTO NOVO a partir do produto de origem. Transcricao do
    * btnConfirmar.Click legado, na MESMA ordem:
    *
    *   lcNewPros = Padr(Thisform.getNewCpro.Value, 14)
    *   lcLocGrus = Padr(Thisform.getOldCGrus.Value, 03)
    *   lcNewGrus = Padr(Thisform.getNewCGrus.Value, 03)
    *   ThisForm.RetCodproduto = ' '
    *   CursorQuery('SigCdPro','crTmp','CPros',lcNewPros)
    *   If (Reccount('crTmp') > 0)
    *       =MessageBox('A Nova Referencia Informada Ja Esta Cadastrada!!!',48)
    *       Thisform.getNewCpro.SetFocus
    *       Return 0
    *   EndIf
    *   If Empty(lcNewPros) Or fVerificarBarras(lcNewPros, crSigCdPam.TpCBars)
    *       =MessageBox('Codigo de Produto Invalido!!!', 48)
    *       Return 0
    *   EndIf
    *   If Not ThisForm.SaiAuto And MessageBox('Sera Gerado Um Novo Produto
    *            ... Confirma a Geracao ?', 4+32+256, ...) <> 6
    *       Wait Window 'Operacao Cancelada Pelo Usuario...' timeOut 2
    *       Wait Clear
    *       Return 0
    *   EndIf
    *   ... (copia de SigPrCpo / SigCdPrf / SigCdPro) ...
    *   ThisForm.RetCodproduto = ' '
    *   If ThisForm.mSv_Inserir()
    *       ThisForm.retcodproduto = Padr(lcNewPros,14) + Str(Get_Qtd.Value,2)
    *   EndIf
    *   ThisForm.Release
    *
    * A COPIA em si (os tres Zap/Scatter/Insert mais o mSv_Inserir) esta toda
    * no Business Object (SigOpRefBO.Inserir, Fase 2), chamada pelo par
    * canonico NovoRegistro() + Salvar() - regra #20: BusinessBase.Salvar() ja
    * EXIBE a falha em todo caminho de recusa, por isso nao ha ELSE com
    * MsgErro aqui.
    *
    * As duas checagens acima continuam NO HANDLER, e nao so no
    * SigOpRefBO.ValidarDados que as repete, porque no legado elas rodam
    * ANTES da pergunta de confirmacao e a primeira delas devolve o FOCO ao
    * campo do codigo - deixar so a validacao do BO perguntaria "confirma?"
    * para em seguida recusar, invertendo o fluxo da tela (PILAR 1).
    *
    * fVerificarBarras(lcNewPros, crSigCdPam.TpCBars) NAO tem equivalente: a
    * funcao global (SIGFUNCS.PRG) nao veio no acervo e so reforcava o
    * FORMATO do codigo digitado - mesma ausencia ja documentada em
    * SigOpRefBO.ValidarDados e em Formsigoppro/FormSigPrEtq (regra #27: nao
    * inventar o algoritmo de uma funcao de calculo ausente). O "Empty()" que
    * acompanha o teste no legado continua valendo e esta transcrito.
    *
    * Fechar com Hide() e nao com Release() eh deliberado - ver FecharDialogo.
    * O legado fecha a tela nos DOIS desfechos (gravou ou nao); quando nao
    * gravou, o retorno fica vazio e eh assim que o chamador descobre
    * ("If Not Empty(lcCodProduto)").
    *
    * PUBLIC: ligado por BINDEVENT em Buttons(1).Click (regra #3 - handler
    * PROTECTED falha em silencio) e chamado pelo disparo automatico do
    * SaiAuto em InicializarForm.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oBO, loc_cNovo, loc_cGrupoNovo, loc_cGrupoOrigem, ;
            loc_cMsg, loc_cLinhaGrupo, loc_lProsseguir, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Guarda de reentrancia: cada passagem GERA UM PRODUTO. Liberada
        *-- DEPOIS do ENDTRY para valer tambem quando o CATCH dispara (senao
        *-- travaria ligada e mataria o botao pelo resto da vida do form).
        IF THIS.this_lEmGravacao
            RETURN
        ENDIF

        THIS.this_lEmGravacao = .T.
        loc_lProsseguir       = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- legado: as tres primeiras linhas do Click leem a tela
            THIS.FormParaBO()

            *-- legado: ThisForm.RetCodproduto = ' '
            loc_oBO.this_cRetCodProduto = " "
            THIS.this_cRetCodProduto    = " "

            loc_cNovo        = PADR(ALLTRIM(NVL(THIS.txt_4c_CodProdDestino.Value, "")), 14)
            loc_cGrupoOrigem = PADR(ALLTRIM(NVL(THIS.txt_4c_GrupoOrigem.Value, "")), 3)
            loc_cGrupoNovo   = PADR(ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, "")), 3)

            *-- legado: a Nova Referencia ja esta cadastrada -> avisa, devolve
            *-- o foco ao campo do codigo e NAO fecha a tela
            IF loc_oBO.ExisteProduto(loc_cNovo)
                MsgAviso("A Nova Refer" + CHR(234) + "ncia Informada J" + ;
                    CHR(225) + " Est" + CHR(225) + " Cadastrada!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")

                IF THIS.Visible AND THIS.txt_4c_CodProdDestino.Enabled AND ;
                        THIS.txt_4c_CodProdDestino.Visible
                    THIS.txt_4c_CodProdDestino.SetFocus()
                ENDIF

                loc_lProsseguir = .F.
            ENDIF

            *-- legado: If Empty(lcNewPros) Or fVerificarBarras(...)
            IF loc_lProsseguir AND EMPTY(ALLTRIM(loc_cNovo))
                MsgAviso("C" + CHR(243) + "digo de Produto Inv" + CHR(225) + ;
                    "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            *-- legado: a confirmacao so eh pedida quando NAO eh processamento
            *-- automatico (SaiAuto), e a linha do grupo so entra na mensagem
            *-- quando o grupo de destino foi informado E mudou
            IF loc_lProsseguir AND !loc_oBO.this_lSaiAuto
                loc_cLinhaGrupo = ""
                IF !EMPTY(ALLTRIM(loc_cGrupoNovo)) AND loc_cGrupoOrigem <> loc_cGrupoNovo
                    loc_cLinhaGrupo = "O Grupo Gerado Ser" + CHR(225) + " o [" + ;
                        ALLTRIM(loc_cGrupoNovo) + "]"
                ENDIF

                loc_cMsg = "Ser" + CHR(225) + " Gerado Um Novo Produto Com a " + ;
                        "Refer" + CHR(234) + "ncia : [" + loc_cNovo + "]" + CHR(13) + ;
                    "Com a Situa" + CHR(231) + CHR(227) + "o : [" + ;
                        IIF(THIS.opt_4c_Situacao.Value = 1, "ATIVA", ;
                            "N" + CHR(195) + "O ATIVA") + "]" + CHR(13) + ;
                    loc_cLinhaGrupo + CHR(13) + ;
                    "Confirma a Gera" + CHR(231) + CHR(227) + "o ?"

                IF !MsgConfirma(loc_cMsg, "Solicita" + CHR(231) + CHR(227) + ;
                        "o de Confirma" + CHR(231) + CHR(227) + "o...")
                    WAIT WINDOW "Opera" + CHR(231) + CHR(227) + "o Cancelada " + ;
                        "Pelo Usu" + CHR(225) + "rio..." TIMEOUT 2
                    WAIT CLEAR
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Par canonico: este dialogo SEMPRE inclui (nao ha ramo de
                *-- alteracao no legado), entao NovoRegistro() deixa o BO em
                *-- modo de edicao/novo e Salvar() delega a Inserir(), que faz
                *-- a copia inteira (SigCdPro + SigPrCpo + SigCdPrf) num unico
                *-- lote transacionado e ja preenche this_cRetCodProduto no
                *-- formato do legado (Padr(cod,14) + Str(qtd,2)).
                loc_oBO.NovoRegistro()

                IF !loc_oBO.Salvar()
                    *-- legado: so nao preenche o retorno - a falha em si ja
                    *-- foi exibida por BusinessBase.Salvar()/Inserir()
                    *-- (regra #20), e a tela fecha do mesmo jeito.
                    loc_oBO.this_cRetCodProduto = " "
                ENDIF

                *-- legado: ThisForm.Release (nos dois desfechos)
                THIS.FecharDialogo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpRef.BtnConfirmarClick")
        ENDTRY

        THIS.this_lEmGravacao = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fase 7/8. Handler do botao "Cancelar"
    * (cntBotoes.btnSair do legado, Cancel = .T. / tecla [Esc]).
    *
    * NOME: batizado pelo PAPEL do botao (Caption = "\<Cancelar", ToolTipText
    * "[Esc] Sair Sem Gravar os Dados"), que eh o nome canonico do projeto para
    * o botao de abandono, e nao pelo nome do objeto legado (btnSair) - o
    * PILAR 3 manda nomes DIFERENTES do legado de qualquer forma, e o Caption
    * continua transcrito do dump (PILAR 1). Mesma decisao ja tomada para o
    * botao de gravar em outros forms da familia.
    *
    * NAO eh um simples "fecha a tela": antes de sair ele DEVOLVE ao contador o
    * sequencial que a geracao do codigo havia reservado, para o numero nao
    * ficar queimado quando o usuario desiste.
    *
    * A regra (qual chave de contador devolver, conforme o tipo de geracao do
    * grupo) mora no Business Object - SigOpRefBO.CancelarCodigoReservado eh a
    * inversa exata de GerarCodigoProdutoDestino e esta transcrita linha a
    * linha do btnSair.Click legado. Aqui ficam so a leitura do controle e o
    * fechamento, que sao responsabilidade da tela.
    *
    * legado:
    *   ... =fCanUniqueKey(ThisForm.NewSeq, 'PRODUTO' + ...) ...
    *   ThisForm.Retcodproduto = ' '
    *   ThisForm.Release
    *
    * PUBLIC: ligado por BINDEVENT em Buttons(2).Click (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                loc_oBO.CancelarCodigoReservado( ;
                    ALLTRIM(NVL(THIS.txt_4c_GrupoDestino.Value, "")))

                *-- legado: ThisForm.Retcodproduto = ' ' (sai sem gerar nada)
                loc_oBO.this_cRetCodProduto = " "
            ENDIF
        CATCH TO loc_oErro
            *-- Falhar ao devolver o sequencial nao pode impedir a saida: o
            *-- numero apenas fica queimado, que eh o desfecho seguro.
            MsgAviso(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Aviso em FormSigOpRef.BtnCancelarClick")
        ENDTRY

        THIS.this_cRetCodProduto = " "

        *-- legado: ThisForm.Release
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - FUNIL de fechamento ("Thisform.Release" do legado), com
    * UMA divergencia deliberada de PILAR 3: fecha com Hide(), nao com
    * Release().
    *
    * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * a leitura seguinte estoura "is not an object". Este dialogo existe para
    * DEVOLVER o codigo do produto gerado, e no legado essa resposta chega
    * pelo RETURN do evento Unload, que so alcanca quem abre com
    * "DO FORM ... TO <var>" (eh exatamente o que SIGOPPRO e SIGMVCAB fazem:
    * "DO Form SigOpRef With ... to lcCodPro" e tambem
    * "... name loProduto linked noshow" + "Left(loProduto.Retcodproduto,14)").
    * No sistema novo, que abre por CREATEOBJECT + Show(), esse retorno eh
    * inalcancavel - ele vem por ObterRetorno(). Hide() em form modal tambem
    * devolve o Show(), entao para o usuario a tela fecha igual (PILAR 1
    * preservado); muda so o tempo de vida do objeto, e eh o CHAMADOR quem
    * chama Release() depois de ler. Mesmo desenho que o FormBuscaAuxiliar do
    * projeto ja adota.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        *-- Enquanto o Business Object ainda existe: guarda o retorno para o
        *-- Unload, que so dispara depois de o Destroy ter zerado
        *-- this_oBusinessObject.
        THIS.CachearRetorno()

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * CachearRetorno - Copia para this_cRetCodProduto o retorno que o Business
    * Object montou, enquanto ele ainda existe. Chamado no FUNIL de
    * fechamento (FecharDialogo, por onde passam os dois botoes) e de novo no
    * Destroy, antes do DODEFAULT que libera o BO.
    *
    * PROTECTED: nao eh ligado por BINDEVENT nem chamado de fora - quem le o
    * resultado usa ObterRetorno(). Sempre com THIS. (regra #8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CachearRetorno()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cRetCodProduto = THIS.this_oBusinessObject.ObterRetorno()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterRetorno - Contrato de retorno do dialogo, equivalente ao
    * PROCEDURE Unload legado ("Return ThisForm.RetCodProduto").
    *
    * Formato do legado: PADR(codigo,14) + STR(quantidade,2). Vazio (ou um
    * espaco) = nenhum produto foi gerado.
    *
    * COMO O CHAMADOR USA (o legado abria com "DO FORM SigOpRef With ... to
    * lcCodPro", que entrega o retorno do Unload; o sistema novo abre por
    * CREATEOBJECT + Show() e esse retorno eh inalcancavel, por isso ele vem
    * por aqui):
    *
    *   loc_oRef = CREATEOBJECT("FormSigOpRef", loc_cCodProdOrigem, ;
    *                           loc_nSituacao, .F.)
    *   IF VARTYPE(loc_oRef) = "O"
    *       loc_oRef.Show()                       && modal: bloqueia
    *       loc_cRetorno = loc_oRef.ObterRetorno()
    *   ENDIF
    *   loc_cCodProduto = LEFT(loc_cRetorno, 14)
    *   IF !EMPTY(loc_cCodProduto)
    *       *-- produto gerado; VAL(SUBSTR(loc_cRetorno, 15)) = quantidade
    *   ENDIF
    *
    * Com SaiAuto = .T. (processamento automatico) nao ha Show(): a copia
    * roda dentro do proprio Init e o retorno ja esta pronto ao final do
    * CREATEOBJECT - exatamente como o "noshow" do chamador legado.
    *
    * A ordem importa: o dialogo fecha com Hide() (ver FecharDialogo), entao
    * continua legivel depois do Show(), e eh o CHAMADOR quem da o Release()
    * - DEPOIS de ler.
    *--------------------------------------------------------------------------
    FUNCTION ObterRetorno()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cRetCodProduto = THIS.this_oBusinessObject.ObterRetorno()
        ENDIF

        RETURN THIS.this_cRetCodProduto
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores que o form e o Business Object possam ter
    * deixado abertos e guarda o retorno antes de o BO ser liberado.
    *
    * Todos os cursores abaixo sao fechados pelos proprios metodos que os
    * criam; sao conferidos aqui so por seguranca, para o form nao vazar
    * alias quando algum deles aborta no meio (CATCH).
    *
    * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
    * popups do menu principal, e omiti-lo encolhe o menu do sistema.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_cAlias
        LOCAL ARRAY loc_aCursores[8]

        loc_aCursores[1] = "cursor_4c_ProdOrigemRef"
        loc_aCursores[2] = "cursor_4c_PamRef"
        loc_aCursores[3] = "cursor_4c_GrpDestRef"
        loc_aCursores[4] = "cursor_4c_GruProRef"
        loc_aCursores[5] = "cursor_4c_GruCanRef"
        loc_aCursores[6] = "cursor_4c_GprRef"
        loc_aCursores[7] = "cursor_4c_ExisteProRef"
        loc_aCursores[8] = "cursor_4c_OpCddRef"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cAlias = loc_aCursores[loc_nI]

            IF USED(loc_cAlias)
                *-- TABLEREVERT so com buffering ligado: sem ele a chamada nao
                *-- eh no-op, estoura "Function requires row or table buffering
                *-- mode" (regra #52). USE IN fecha o alias de qualquer forma.
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
        ENDFOR

        *-- Ultima chance de guardar o retorno: o DODEFAULT abaixo chega a
        *-- FormBase.Destroy, que faz this_oBusinessObject = .NULL., e o Unload
        *-- (que devolve o valor a quem abriu com "DO FORM ... TO") so dispara
        *-- DEPOIS disso.
        THIS.CachearRetorno()

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Unload - PROCEDURE Unload legado, mantido LITERAL para quem abrir este
    * dialogo com "DO FORM ... TO <var>", forma em que o VFP entrega ao
    * chamador justamente o retorno deste evento:
    *
    *   PROCEDURE Unload
    *   Return ThisForm.RetCodProduto
    *
    * Le o CACHE e nao o BO: o Unload dispara DEPOIS do Destroy, e nesse
    * ponto FormBase.Destroy ja fez this_oBusinessObject = .NULL. - perguntar
    * ao BO aqui estouraria. Quem enche o cache eh CachearRetorno, chamado no
    * fechamento e no Destroy.
    *
    * O caminho recomendado no sistema novo continua sendo CREATEOBJECT +
    * Show() + ObterRetorno(), que nao depende do ciclo de destruicao.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        RETURN THIS.this_cRetCodProduto
    ENDPROC
ENDDEFINE
