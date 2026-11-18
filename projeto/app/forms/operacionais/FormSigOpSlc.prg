*==============================================================================
* FORMSIGOPSLC.PRG - Formulario Operacional: Selecao de Moeda (dialogo filho)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SIGOPSLC.SCX (task803)
*
* Pilares:
*   UX   -> layout identico ao legado (800x400, TitleBar=0, Closable=.F.,
*           MaxButton=.F., MinButton=.F., Movable=.F., cabecalho cinza no
*           topo sem titulo visivel - Caption do form eh "" no SCX)
*   BD   -> SigCdMoe (consulta/validacao, via SigOpSlcBO); nao grava nada
*   CODE -> arquitetura em camadas (FormBase / SigOpSlcBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que outro form abre para o usuario escolher a moeda de um
*   lancamento de credito. O legado NAO persiste nada aqui: devolve o
*   codigo da moeda escolhida (ou o cancelamento) gravando DIRETO em
*   propriedades do form pai (ThisForm.ParentForm), sem metodo intermediario:
*
*     Cancela.Click  -> ThisForm.ParentForm.CanceladoExterno = .T. / Release
*     Confirma.Click -> ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.Value / Release
*
*   O bloco de Grupo/Conta (Grade/Get_Grupo/Get_Conta/Get_DConta/SayGrupo/
*   SayConta) existe no SCX mas fica SEMPRE oculto - o Init legado recebe
*   _GetConta como parametro e, na linha seguinte, sobrescreve para .f.
*   incondicionalmente (regra #17 do CLAUDE.md: transcrever literal, nao
*   "corrigir" removendo o hardcode nem reativar o bloco). Ver a NOTA no
*   cabecalho de SigOpSlcBO.prg para o detalhe completo.
*
* CHAMADA (equivale ao Do Form SigOpSlc With _GetConta, _GetMoeda, ThisForm
* do legado):
*   loForm = CREATEOBJECT("FormSigOpSlc", par_lGetConta, par_lGetMoeda, THISFORM)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (Cancela.Click e
*   Confirma.Click chamam ThisForm.Release - fase 7), nao do chamador. O
*   resultado chega ao pai pelas propriedades que os botoes escrevem nele
*   (CanceladoExterno / MoedaMaior), nao por retorno de metodo.
*
* PARAMETROS (legado: LParameters _GetConta, _GetMoeda, _Parent)
*   par_lGetConta - aceito por simetria com a assinatura legada, mas SEMPRE
*                   sobrescrito para .F. (regra #17 - ver SigOpSlcBO.prg)
*   par_lGetMoeda - legado: _GetMoeda. Controla a visibilidade do bloco de
*                   moeda e o ajuste de altura da tela (fases seguintes).
*                   Omitido, assume .T. (bloco de moeda visivel, que eh o
*                   uso real desta tela)
*   par_oFormPai  - legado: _Parent. Form que abriu o dialogo e que recebe o
*                   resultado (ThisForm.ParentForm, RESERVED3/ClassInfo do
*                   SCX = "parentform")
*
* FASE 3: estrutura base do form - DEFINE CLASS com as propriedades
* visuais transcritas do SCX, as propriedades de estado (espelho do
* _GetConta/_GetMoeda/_Parent do Init legado), Init com os tres parametros,
* ValidarParametros, InicializarForm, ConfigurarDecoracao (Picture),
* ConfigurarCabecalho (cntSombra), TornarControlesVisiveis e Destroy.
*
* FASE 4: bloco de moeda (Label1, SayMoeda, get_cd_moeda, get_ds_moeda -
* ConfigurarBlocoMoeda) e o bloco de Grupo/Conta PERMANENTEMENTE OCULTO
* (Grade, SayGrupo, SayConta, Get_Grupo, Get_Conta, Get_DCONTA -
* ConfigurarBlocoContaGrupo), ambos criados depois do cabecalho. Esta tela
* NAO eh um cadastro CRUD (sem Page1=Lista/Page2=Dados, sem botoes Incluir/
* Alterar/Excluir) - eh um dialogo modal FILHO que so devolve um codigo de
* moeda ao form pai (ver cabecalho de SigOpSlcBO.prg); a grade que existe
* no SCX (RecordSource = "TmpCliente") pertence ao bloco morto de Conta,
* nunca a uma lista de registros deste form.
*
* FASE 5 (esta fase): ajuste de altura/posicao do Init legado
* (AjustarLayoutConformeMoeda) e a busca do default de moeda no cursor do
* chamador (CarregarMoedaDefaultDeTmpBaixa). Legado:
*
*     If !_GetMoeda
*         This.Height = This.Height - 25
*     Else
*         Select TmpBaixa
*         Scan for Tipos = 'X'
*             This.Get_cd_moeda.value = moedas
*             =Seek( moedas, 'crSigCdMoe', 'CMoes' )
*             This.Get_ds_moeda.value = crSigCdMoe.dmoes
*             exit
*         Endscan
*     Endif
*     If !_GetConta And _GetMoeda
*         This.Get_cd_moeda.Top = 50
*         This.Get_ds_moeda.top = 50
*         This.SayMoeda.top = 54
*         This.Height = 100
*     Endif
*     This.Refresh
*
* Como this_lExibirConta eh SEMPRE .F. (regra #17), "!_GetConta And
* _GetMoeda" equivale sempre a "_GetMoeda" - os dois Ifs do legado cobrem
* so os DOIS estados de this_lExibirMoeda (nao quatro combinacoes):
*   this_lExibirMoeda = .F. -> This.Height -= 25 (375), sem reposicionar
*   this_lExibirMoeda = .T. -> busca o default em TmpBaixa E reposiciona
*       get_cd_moeda/get_ds_moeda/SayMoeda, com Height = 100
*
* TmpBaixa, como TmpCliente e crSigCdPgr (fase 4), eh cursor do FORM PAI -
* este dialogo so LE, nunca declara. O Seek legado em crSigCdMoe (cursor
* global legado, sem guarda de sucesso) equivale no sistema novo a
* THIS.this_oBusinessObject.ValidarMoedaPorCodigo(), que ja faz SQLEXEC em
* SigCdMoe e preserva o codigo mesmo se a busca falhar (regra #37/#50).
*
* ORDEM DE CRIACAO - o cabecalho eh o PRIMEIRO AddObject do form. Os botoes
* Cancela/Confirma do SCX ficam em Top = 3 (dentro da faixa, Top 0..80) -
* quem for criado depois desenha POR CIMA; invertida a ordem, a faixa cinza
* cobriria os dois botoes (regra #11 do CLAUDE.md).
*
* FASE 6 (esta fase): lookup de moeda. Legado:
*
*     get_cd_moeda.Valid: If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
*                             <fwBuscaSel> Else If IsEmpty(This.Value) <Cd/Ds = ''>
*     get_ds_moeda.Valid: mesma logica, Seek por DMoes
*     get_ds_moeda.When:  Return IsEmpty(Thisform.Get_Cd_Moeda.Value)
*
* CdMoedaLostFocus/DsMoedaLostFocus (BINDEVENT em "LostFocus", nao em
* "Valid" - BINDEVENT nao eh confiavel em "Valid" de TextBox, e em
* "KeyPress" sem testar a tecla o picker abriria a cada caractere digitado,
* regra #47) chamam ValidarMoedaPorCodigo/ValidarMoedaPorDescricao do BO; a
* busca por fwBuscaSel vira AbrirBuscaMoeda, Pattern A do FormBuscaAuxiliar
* (regra #36/#37 - match exato tentado no Init via this_lAchouRegistro,
* Show() so se nao achou, atribuicao so sob this_lSelecionou), igual ao
* padrao ja usado para SigCdMoe em Formccr.prg. Guarda de reentrancia
* this_lEmLookup (regra #37): o picker eh MODAL e tira o foco do campo, o
* que redispara o proprio LostFocus - por isso o corpo de cada handler vive
* num metodo *Exec separado, liberado mesmo com RETURN antecipado.
*
* DsMoedaWhen reproduz o When via BINDEVENT (padrao estabelecido em
* FormSigOpBcb.prg/FormSigOpCcl.prg - "When" aceita handler PUBLIC
* retornando o logico que decide o foco, diferente de "Valid").
*
* FASE 7 (esta fase): Click de cmd_4c_Confirma/cmd_4c_Cancela
* (CmdConfirmaClick/BtnEncerrarClick) - gravam direto em
* this_oFormPai.MoedaMaior/CanceladoExterno (ThisForm.ParentForm no legado,
* NAO eh um cadastro CRUD: nao ha Incluir/Alterar/Excluir/Visualizar no SCX
* nem no Init legado - os UNICOS botoes sao Confirma ("\<Ok") e Cancela
* ("Encerrar"), ja criados na fase 4 (ConfigurarBotoesAcao).
*
* FASE 8 (esta fase): eventos auxiliares do bloco de Grupo/Conta
* (ConfigurarEventosContaGrupo) - nao ha FormParaBO/BOParaForm/CarregarLista/
* HabilitarCampos/AjustarBotoesPorModo neste form: ele NAO eh um cadastro
* CRUD (sem Page1=Lista/Page2=Dados, sem botoes Incluir/Alterar/Excluir), e
* sim um dialogo FILHO com dois botoes de saida (Confirma/Cancela, ja ligados
* na fase 7). O que faltava para fechar a paridade com o comportamento.json
* eram os eventos do bloco oculto de Grupo/Conta - SigOpSlcBO.prg (NOTA do
* cabecalho) ja antecipa isso: "Os validadores desses campos ... ficam no
* Form (camada de UI), que eh quem os aciona via BINDEVENT". Legado:
*
*     Get_Grupo.Valid:  If !fAcessoContab(Usuar,'C',This.Value,This,'',
*                           Thisform.get_conta.value) / Messagebox('Acesso
*                           Negado...',48,'') / This.Value = '' / Endif
*     Get_Conta.Valid:  mesma logica com fAcessoContas(Usuar,Get_Grupo.Value,
*                           'C',This.Value,This.Get_Conta,This.Get_dConta)
*     Get_DCONTA.Valid: mesma logica, tipo 'D'
*     Get_DCONTA.When:  Return IsEmpty(Thisform.Get_Conta.Value)
*     Grade (AfterRowColChange): ThisForm.Get_Grupo/Get_Conta/Get_DConta.Value
*                           = Grupo/Conta/Nome (linha corrente de TmpCliente)
*     Grade.ColumnN.Text1.KeyPress: Tab/Enter -> Get_Grupo.SetFocus
*
* fAcessoContab/fAcessoContas JA EXISTEM como helpers globais portados em
* utils\functions.prg (linhas 709/991) e escrevem direto nos TextBox
* recebidos por parametro (pCod/pDsc, pSt1/pSt2) - por isso os handlers so
* delegam, sem duplicar logica de UI. "This" nos dois ultimos Valid do dump
* refere-se ao FORM (ThisForm.Get_Grupo/Get_Conta/Get_DConta), nao ao
* TextBox do evento - unico jeito de "This.Get_Grupo" fazer sentido, ja que
* TextBox nao tem membro Get_Grupo; aqui o handler mora no FORM (THIS ja eh
* o form), entao a leitura fica direta.
*
* Mesmo com estes handlers implementados, o bloco PERMANECE inatingivel pelo
* usuario (this_lExibirConta eh sempre .F. - regra #17): a implementacao
* fecha a paridade estrutural com o comportamento.json sem reativar o
* bloco. BINDEVENT em "LostFocus" (nao em "Valid", que nao eh confiavel em
* TextBox - regra #47) e MsgAviso no lugar do Messagebox cru (icone 48 =
* aviso, regra MESSAGEBOX PROIBIDO do CLAUDE.md).
*==============================================================================

DEFINE CLASS FormSigOpSlc AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *==========================================================================

    *-- SIGOPSLC: Height = 400 / Width = 800
    this_cMensagemErro = ""
    Height       = 400
    Width        = 800

    *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.

    *-- Caption = "" no SCX legado. O Init legado copia ThisForm.Caption
    *-- (vazio) para os dois labels do cabecalho - transcrito literal, sem
    *-- inventar titulo (PILAR 1)
    Caption      = ""

    *-- TitleBar = 0 / Closable = .F. / MaxButton = .F. / MinButton = .F. /
    *-- Movable = .F. / ClipControls = .F. - as SEIS sao declaradas no SCX.
    *-- Sem barra de titulo e sem Closable, a unica saida eh pelos botoes
    *-- Cancela/Confirma (fase 7)
    TitleBar     = 0
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.

    *-- WindowType = 1 (modal), como o SCX declara. O pai abre este dialogo
    *-- e precisa que o Show() bloqueie ate o usuario escolher Cancelar ou
    *-- Confirmar
    WindowType   = 1
    WindowState  = 0

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow   = 1

    *-- Fonte base do Framework legado. Os controles do corpo declaram a
    *-- propria fonte no SCX (Tahoma 18 no cabecalho, Tahoma 8 nos campos e
    *-- labels) e sao transcritos nas fases seguintes
    FontName     = "Tahoma"
    FontSize     = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). Este dialogo roda na
    *-- mesma sessao do form pai e por isso enxerga os cursores que ele ja
    *-- deixa abertos (crSigCdMoe, e no bloco de moeda da fase 5, TmpBaixa).
    *-- Com DataSession = 2 esses cursores ficariam invisiveis aqui
    DataSession  = 1

    *==========================================================================
    * PROPRIEDADES DE ESTADO - espelham o LParameters do Init legado
    *==========================================================================

    *-- this_oFormPai -> ThisForm.ParentForm do legado (RESERVED3/ClassInfo
    *-- do SCX = "parentform"): o form que abriu este dialogo e que recebe o
    *-- resultado (CanceladoExterno / MoedaMaior) nas fases 7
    this_oFormPai = .NULL.

    *-- this_lExibirConta -> _GetConta do legado. SEMPRE .F. (regra #17 -
    *-- ver NOTA em SigOpSlcBO.prg): decide a visibilidade do bloco
    *-- Grade/Get_Grupo/Get_Conta/Get_DCONTA/SayGrupo/SayConta, que fica
    *-- permanentemente oculto para QUALQUER chamador
    this_lExibirConta = .F.

    *-- this_lExibirMoeda -> _GetMoeda do legado: decide a visibilidade do
    *-- bloco de moeda (get_cd_moeda/get_ds_moeda/SayMoeda) e o ajuste de
    *-- altura/posicao da tela (fase 5)
    this_lExibirMoeda = .T.

    *-- this_lEmLookup -> guarda de reentrancia do lookup de moeda (fase 6,
    *-- regra #37 do CLAUDE.md). O picker FormBuscaAuxiliar eh MODAL e tira
    *-- o foco do campo, o que redispara o proprio LostFocus
    this_lEmLookup = .F.

    *==========================================================================
    * Init - LParameters _GetConta, _GetMoeda, _Parent do legado
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_lGetConta, par_lGetMoeda, par_oFormPai

        *-- Legado: _GetConta = .f. (hardcode incondicional, regra #17) -
        *-- par_lGetConta eh aceito so por simetria com a assinatura legada
        *-- e NUNCA usado, exatamente como SigOpSlcBO.Init faz com
        *-- par_lExibirConta
        THIS.this_lExibirConta = .F.

        *-- Legado: _GetMoeda (parametro real, sem hardcode)
        IF VARTYPE(par_lGetMoeda) = "L"
            THIS.this_lExibirMoeda = par_lGetMoeda
        ELSE
            THIS.this_lExibirMoeda = .T.
        ENDIF

        *-- Legado: ThisForm.ParentForm = _Parent
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * quem receba CanceladoExterno/MoedaMaior (fase 7), e o legado tambem
    * depende dessa referencia (ThisForm.ParentForm.CanceladoExterno/
    * MoedaMaior nos dois Click).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o bypass
    * a instanciacao reprovaria sempre.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
                    "outro formul" + CHR(225) + "rio.", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object da Fase 1-2. Legado: Init(_GetConta eh
            *-- sempre .f., _GetMoeda eh o parametro real) - mesma logica
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpSlcBO", ;
                THIS.this_lExibirConta, THIS.this_lExibirMoeda)

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpSlcBO.", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            ELSE
                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO AddObject
                *-- do form: os botoes Cancela/Confirma ficam em Top = 3,
                *-- DENTRO da faixa (Top 0..80), e precisam ser criados
                *-- depois para desenhar por cima (regra #11)
                THIS.ConfigurarCabecalho()

                *-- Botoes de acao Confirma (Ok) e Cancela (Encerrar) -
                *-- criados LOGO APOS o cabecalho, pelo motivo acima
                THIS.ConfigurarBotoesAcao()

                *-- Bloco de moeda (visivel por padrao, controlado por
                *-- this_lExibirMoeda)
                THIS.ConfigurarBlocoMoeda()

                *-- Bloco de Grupo/Conta - PERMANENTEMENTE OCULTO (regra #17:
                *-- this_lExibirConta eh sempre .F.)
                THIS.ConfigurarBlocoContaGrupo()

                *-- Eventos auxiliares do bloco de Grupo/Conta (fase 8) -
                *-- precisa dos controles ja criados pelo metodo acima
                THIS.ConfigurarEventosContaGrupo()

                *-- Liga a Grade ao cursor TmpCliente do form pai. Devolve
                *-- .F. quando o cursor nao esta aberto (chamador que nao
                *-- usa o bloco de Conta - que eh o caso de TODOS, regra
                *-- #17); isso NAO eh falha de inicializacao, por isso o
                *-- retorno nao entra em loc_lSucesso
                THIS.CarregarDados()

                *-- Ajuste de altura/posicao + default de moeda (TmpBaixa)
                *-- do Init legado - precisa dos controles do bloco de
                *-- moeda ja criados (ConfigurarBlocoMoeda, acima)
                THIS.AjustarLayoutConformeMoeda()

                *-- FASE 6+: lookup de moeda e os Click dos dois botoes
                *-- entram nas proximas fases

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Legado: This.Refresh (ultima linha do Init)
                THIS.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpSlc: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Legado:
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption (que eh
    * ""), por isso .Caption = THIS.Caption (dinamico), nao o literal
    * "Cadastro de Testes" que aparece no dump (esse literal eh so o default
    * do Form Designer, nunca chega a ser exibido).
    *
    * Width do container usa THIS.Width (canonico da faixa, regra #11) em
    * vez do literal 800 - sao o mesmo valor aqui, mas THIS.Width acompanha
    * o form se o Height/Width mudar na fase 5 (ajuste de altura).
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - os DOIS botoes do dialogo (Confirma e Cancela)
    *
    * Legado (classe fwbtng, base commandbutton) - o SCX so sobrescreve
    * Top/Left/Picture/Caption/Cancel, o resto vem da classe:
    *
    *   Confirma  Top=3  Left=650  Caption="\<Ok"
    *             Picture=..\framework\imagens\cadastro_salvar_60.jpg
    *   Cancela   Top=3  Left=725  Caption="Encerrar"  Cancel=.T.
    *             Picture=..\framework\imagens\cadastro_sair_60.jpg
    *   fwbtng    FontName="Comic Sans MS" FontSize=8 FontBold=.T.
    *             FontItalic=.T. WordWrap=.T. MousePointer=15
    *             ForeColor=90,90,90 BackColor=255,255,255 Themes=.F.
    *
    * NAO sao os 6 botoes CRUD do frmcadastro: este eh um dialogo FILHO e o
    * legado declara exatamente estes dois - inventar Incluir/Alterar/
    * Excluir/Buscar violaria o PILAR 1.
    *
    * GEOMETRIA - por que 75 x 75 e nao os 80 x 100 da classe fwbtng:
    * o SCX nao declara Width/Height, e os 80 x 100 da classe NAO fecham com
    * os Left que ele declara - 650+80 = 730 invadiria 5px o Cancela (725) e
    * 725+80 = 805 passaria 5px da borda do form (Width = 800), ficando
    * RECORTADO (regra #30). Com 75 a geometria do proprio SCX fecha exata:
    * 650+75 = 725 (encosta no Cancela) e 725+75 = 800 (encosta na borda) -
    * ou seja, os Left do dump SO fazem sentido com botao de 75, que eh
    * tambem o tamanho canonico destes botoes de icone no projeto
    * (framework_frmcadastro_layout.md / regra #10). Height 75 com Top = 3
    * termina em 78, dentro da faixa do cabecalho (Height 80) - com os 100
    * da classe o botao vazaria 23px abaixo dela.
    *
    * Picture: so o CAMINHO muda (..\framework\imagens\ -> gc_4c_CaminhoIcones);
    * o nome do arquivo eh transcrito do dump, nunca escolhido por semelhanca
    * semantica (regra #25) - por isso "Encerrar" leva cadastro_sair_60.jpg e
    * "Ok" leva cadastro_salvar_60.jpg, como o legado manda.
    *
    * Themes = .T. + DisabledPicture: obrigatorio em CommandButton STANDALONE
    * com Picture, senao o icone nao renderiza (CorretorAutomatico #99). A
    * excecao Themes = .F. vale para Buttons(N) de CommandGroup, que nao eh
    * o caso aqui.
    *
    * Os Click (Cancela -> CanceladoExterno do pai, Confirma -> MoedaMaior
    * do pai) sao ligados por BINDEVENT no fim desta procedure, nos metodos
    * BtnEncerrarClick/CmdConfirmaClick (fase 7).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao
        LOCAL loc_cIconeOk, loc_cIconeSair
        loc_cIconeOk   = ""
        loc_cIconeSair = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeOk   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDIF

        *-- Confirma -> cmd_4c_Confirma ("\<Ok": o \< marca o atalho Alt+O,
        *-- transcrito literal do Caption do SCX)
        THIS.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cmd_4c_Confirma
            .Caption      = "\<Ok"
            .Top          = 3
            .Left         = 650
            .Width        = 75
            .Height       = 75
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.
            .Enabled      = .T.
            .ToolTipText  = "Confirma a moeda selecionada"

            IF !EMPTY(loc_cIconeOk) AND FILE(loc_cIconeOk)
                .Picture         = loc_cIconeOk
                .DisabledPicture = loc_cIconeOk
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Confirma, "Click", THIS, "CmdConfirmaClick")

        *-- Cancela -> cmd_4c_Cancela (Cancel = .T.: eh o botao do ESC no
        *-- legado, e neste dialogo sem ControlBox eh a unica saida)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Caption      = "Encerrar"
            .Cancel       = .T.
            .Top          = 3
            .Left         = 725
            .Width        = 75
            .Height       = 75
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.
            .Enabled      = .T.
            .ToolTipText  = "Encerra sem selecionar moeda"

            IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
                .Picture         = loc_cIconeSair
                .DisabledPicture = loc_cIconeSair
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * CmdConfirmaClick - Confirma.Click do legado:
    *
    *     ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.value
    *     ThisForm.Release
    *
    * Grava o codigo de moeda escolhido DIRETO na property do form pai (sem
    * metodo intermediario, igual ao legado) e fecha o dialogo. O legado nao
    * valida nada aqui - mesmo com o campo vazio, grava vazio e fecha (regra
    * #17: transcrever literal, sem inventar validacao que o legado nao tem).
    *
    * PEMSTATUS guarda a atribuicao: o contrato (property MoedaMaior) eh do
    * form PAI, nao deste dialogo, e sem a guarda um pai que nao declare essa
    * property faria THIS.this_oFormPai.MoedaMaior estourar "Property
    * MOEDAMAIOR is not found" em vez de simplesmente nao devolver nada.
    *
    * THIS.this_oBusinessObject.Confirmar() (fase 8, consolidacao): marca
    * this_lConfirmou/this_lCancelado no BO - sem efeito no que chega ao
    * form pai (que continua sendo gravado aqui, exatamente como o legado),
    * mas fecha o metodo que a fase 2 criou e a fase 7 deixou sem chamador.
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico.
    *==========================================================================
    PROCEDURE CmdConfirmaClick
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "MoedaMaior", 5) AND ;
                   PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
                    THIS.this_oFormPai.MoedaMaior = THIS.txt_4c__cd_moeda.Value
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.Confirmar()
            ENDIF

            THIS.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar a moeda selecionada: " + loc_oErro.Message, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Cancela.Click do legado (Caption "Encerrar" - handler
    *
    *     ThisForm.ParentForm.CanceladoExterno = .T.
    *     ThisForm.Release
    *
    * Avisa o form pai que o usuario desistiu e fecha o dialogo. Mesma
    * guarda de PEMSTATUS da CmdConfirmaClick, pelo mesmo motivo (contrato
    * eh do form pai).
    *
    * THIS.this_oBusinessObject.Cancelar() (fase 8, consolidacao) - mesmo
    * racional da chamada a Confirmar() em CmdConfirmaClick.
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico. Tambem
    * alcancavel direto (Cancel = .T. no AddObject - ESC aciona o botao).
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "CanceladoExterno", 5)
                    THIS.this_oFormPai.CanceladoExterno = .T.
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.Cancelar()
            ENDIF

            THIS.Release()
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar a sele" + CHR(231) + CHR(227) + "o de moeda: " + ;
                    loc_oErro.Message, "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBlocoMoeda - Label1 (texto instrucional), SayMoeda,
    * get_cd_moeda e get_ds_moeda do legado.
    *
    * Legado (Init):
    *   This.Get_cd_moeda.Visible = _GetMoeda
    *   This.Get_ds_moeda.Visible = _GetMoeda
    *   This.SayMoeda.Visible     = _GetMoeda
    *
    * Label1 NAO eh tocado pelo Init legado - fica sempre visivel,
    * independente de _GetMoeda (regra #17: transcrever literal).
    *
    * Reposicionamento condicional (Get_cd_moeda.Top=50, Get_ds_moeda.Top=50,
    * SayMoeda.Top=54, This.Height=100 quando !_GetConta And _GetMoeda) e o
    * default de moeda lido de TmpBaixa ficam para a FASE 5 - aqui os
    * controles nascem nas posicoes ORIGINAIS do dump (Top=284/287).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBlocoMoeda
        *-- Label1 -> lbl_4c_Label1 (texto instrucional, sempre visivel)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Selecione a moeda para efetuar lan" + CHR(231) + ;
                         "amentos de cr" + CHR(233) + "dito."
            .Top       = 90
            .Left      = 295
            .Width     = 209
            .Height    = 36
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- SayMoeda -> lbl_4c_Moeda ("Moeda : "). Visibilidade segue
        *-- this_lExibirMoeda (legado: This.SayMoeda.Visible = _GetMoeda)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .Caption   = "Moeda : "
            .Top       = 287
            .Left      = 232
            .Width     = 44
            .ForeColor = RGB(90, 90, 90)
            .Visible   = THIS.this_lExibirMoeda
        ENDWITH

        *-- get_cd_moeda -> txt_4c__cd_moeda (codigo da moeda - crSigCdMoe.CMoes
        *-- char(3)). Format = "K!" e InputMask = "" no dump (InputMask vazio
        *-- eh override vazio do Form Designer, nao se transcreve - regra #49)
        THIS.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH THIS.txt_4c__cd_moeda
            .Value     = ""
            .Format    = "K!"
            .Top       = 284
            .Left      = 278
            .Width     = 31
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = THIS.this_lExibirMoeda
        ENDWITH

        *-- get_ds_moeda -> txt_4c__ds_moeda (descricao da moeda -
        *-- crSigCdMoe.DMoes char(15))
        THIS.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH THIS.txt_4c__ds_moeda
            .Value     = ""
            .Format    = "K!"
            .Top       = 284
            .Left      = 309
            .Width     = 115
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = THIS.this_lExibirMoeda
        ENDWITH

        *-- FASE 6 - lookup de moeda. "LostFocus" (nao "Valid": BINDEVENT
        *-- nao eh confiavel em "Valid" de TextBox; nao "KeyPress": sem
        *-- testar a tecla o picker abriria a cada caractere - regra #47).
        *-- "When" reproduz get_ds_moeda.When do legado (padrao
        *-- FormSigOpBcb.prg/FormSigOpCcl.prg)
        BINDEVENT(THIS.txt_4c__cd_moeda, "LostFocus", THIS, "CdMoedaLostFocus")
        BINDEVENT(THIS.txt_4c__ds_moeda, "LostFocus", THIS, "DsMoedaLostFocus")
        BINDEVENT(THIS.txt_4c__ds_moeda, "When", THIS, "DsMoedaWhen")
    ENDPROC

    *==========================================================================
    * DsMoedaWhen - get_ds_moeda.When do legado:
    *     Return IsEmpty(Thisform.Get_Cd_Moeda.Value)
    *
    * Enquanto o codigo da moeda estiver vazio, a descricao pode receber
    * foco (usuario pode digitar a descricao para buscar); com o codigo
    * preenchido, o foco NAO entra na descricao - o usuario so digita UM dos
    * dois caminhos por vez. BINDEVENT em "When" (nao em "Valid"/
    * "LostFocus") reproduz a propriedade When do legado - padrao
    * estabelecido em FormSigOpBcb.prg/FormSigOpCcl.prg.
    *
    * Metodo PUBLIC/FUNCTION (regra #3 do CLAUDE.md): BINDEVENT exige alvo
    * publico, e PROTECTED faria o bind falhar silenciosamente.
    *==========================================================================
    FUNCTION DsMoedaWhen()
        IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
            RETURN .T.
        ENDIF

        RETURN EMPTY(ALLTRIM(THIS.txt_4c__cd_moeda.Value))
    ENDFUNC

    *==========================================================================
    * CdMoedaLostFocus - get_cd_moeda.Valid do legado:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
    *         <fwBuscaSel>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *
    * Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    * campo, o que redispara este proprio LostFocus. O corpo vive em
    * CdMoedaLostFocusExec para a flag ser liberada mesmo com RETURN
    * antecipado.
    *==========================================================================
    PROCEDURE CdMoedaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.CdMoedaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE CdMoedaLostFocusExec()
        LOCAL loc_cCodigo

        IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(THIS.txt_4c__cd_moeda.Value)

        *-- Legado: Else / If IsEmpty(This.Value) -> os dois viram ''
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c__ds_moeda.Value = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.ValidarMoedaPorCodigo("")
            ENDIF
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ValidarMoedaPorCodigo(loc_cCodigo)
            THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
            THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
        ELSE
            *-- Nao achou: abre o picker direto, SEM MsgAviso e SEM apagar o
            *-- digitado (regra #50) - o valor atual vira prefixo de busca
            THIS.AbrirBuscaMoeda(loc_cCodigo)
        ENDIF
    ENDPROC

    *==========================================================================
    * DsMoedaLostFocus - get_ds_moeda.Valid do legado (mesma logica de
    * CdMoedaLostFocus, Seek original por DMoes). Mesmo padrao de guarda de
    * reentrancia.
    *==========================================================================
    PROCEDURE DsMoedaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DsMoedaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE DsMoedaLostFocusExec()
        LOCAL loc_cDescricao

        IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
            RETURN
        ENDIF

        loc_cDescricao = ALLTRIM(THIS.txt_4c__ds_moeda.Value)

        IF EMPTY(loc_cDescricao)
            THIS.txt_4c__cd_moeda.Value = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.ValidarMoedaPorDescricao("")
            ENDIF
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ValidarMoedaPorDescricao(loc_cDescricao)
            THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
            THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
        ELSE
            THIS.AbrirBuscaMoeda(loc_cDescricao)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaMoeda - picker de SigCdMoe. Pattern A do FormBuscaAuxiliar
    * (regras #36/#37 do CLAUDE.md), igual ao padrao ja usado para SigCdMoe
    * em Formccr.prg: 1o argumento eh o HANDLE de conexao, match exato
    * tentado no proprio Init (this_lAchouRegistro), Show() so quando nao
    * achou, atribuicao so sob this_lSelecionou.
    *
    * par_cValorFiltro - o que o usuario tinha digitado (codigo OU
    * descricao, dependendo de quem chamou); vira o 5o argumento do Init.
    *
    * Legado: fwBuscaSel aberto pelo Valid de get_cd_moeda/get_ds_moeda
    * quando o Seek em crSigCdMoe (cursor global legado) falha.
    *==========================================================================
    PROCEDURE AbrirBuscaMoeda(par_cValorFiltro)
        LOCAL loc_oBusca, loc_oErro

        IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
            RETURN
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", ;
                IIF(VARTYPE(par_cValorFiltro) = "C", par_cValorFiltro, ""), ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    THIS.txt_4c__cd_moeda.Value = ALLTRIM(TratarNulo(cmoes, ""))
                    THIS.txt_4c__ds_moeda.Value = ALLTRIM(TratarNulo(dmoes, ""))

                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.this_cCdMoeda = THIS.txt_4c__cd_moeda.Value
                        THIS.this_oBusinessObject.this_cDsMoeda = THIS.txt_4c__ds_moeda.Value
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir a busca de moeda: " + loc_oErro.Message, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBlocoContaGrupo - Grade, SayGrupo, SayConta, Get_Grupo,
    * Get_Conta e Get_DCONTA do legado.
    *
    * PERMANENTEMENTE OCULTO (regra #17 do CLAUDE.md): o Init legado recebe
    * _GetConta como parametro e, na linha seguinte, sobrescreve
    * incondicionalmente para .f. - estes seis controles NUNCA ficam
    * visiveis, para NENHUM chamador (ver NOTA no cabecalho de
    * SigOpSlcBO.prg). Transcrito por completude estrutural com o SCX
    * (PILAR 1), sem reativar o bloco nem "corrigir" o hardcode.
    *
    * ControlSource/RecordSource apontam para cursores do FORM PAI
    * (crSigCdPgr, TmpCliente) que este dialogo nao declara. Como o bloco
    * fica sempre invisivel, o binding so eh aplicado SE o cursor ja
    * estiver aberto nesta sessao (DataSession = 1) - sem essa guarda, um
    * cursor ausente derrubaria o Init (regra #41 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBlocoContaGrupo
        *-- SayGrupo -> lbl_4c_Grupo
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .FontName  = "Tahoma"
            .Caption   = "Grupo : "
            .Left      = 235
            .Top       = 310
            .ForeColor = RGB(90, 90, 90)
            .Visible   = THIS.this_lExibirConta
        ENDWITH

        *-- SayConta -> lbl_4c_Conta
        THIS.AddObject("lbl_4c_Conta", "Label")
        WITH THIS.lbl_4c_Conta
            .FontName  = "Tahoma"
            .Caption   = "Conta : "
            .Left      = 235
            .Top       = 332
            .ForeColor = RGB(90, 90, 90)
            .Visible   = THIS.this_lExibirConta
        ENDWITH

        *-- Get_Grupo -> txt_4c_Grupo (legado: ControlSource = "crSigCdPgr.Grupos")
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Value    = ""
            .Format   = "K!"
            .Top      = 308
            .Left     = 278
            .Height   = 21
            .Width    = 79
            .FontName = "Tahoma"
            .FontSize = 8
            IF USED("crSigCdPgr")
                .ControlSource = "crSigCdPgr.Grupos"
            ENDIF
            .Visible  = THIS.this_lExibirConta
        ENDWITH

        *-- Get_Conta -> txt_4c_Conta (legado: ControlSource = "crSigCdPgr.Contas")
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Value    = ""
            .Format   = "K!"
            .Top      = 330
            .Left     = 278
            .Height   = 21
            .Width    = 79
            .FontName = "Tahoma"
            .FontSize = 8
            IF USED("crSigCdPgr")
                .ControlSource = "crSigCdPgr.Contas"
            ENDIF
            .Visible  = THIS.this_lExibirConta
        ENDWITH

        *-- Get_DCONTA -> txt_4c_DCONTA (legado: ControlSource = "" - texto
        *-- livre, sem binding)
        THIS.AddObject("txt_4c_DCONTA", "TextBox")
        WITH THIS.txt_4c_DCONTA
            .Value       = ""
            .Top         = 352
            .Left        = 278
            .Height      = 21
            .Width       = 291
            .ReadOnly    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = THIS.this_lExibirConta
        ENDWITH

        *-- Grade -> grd_4c_Dados (legado: RecordSource = "TmpCliente",
        *-- cursor do FORM PAI)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Top               = 123
            .Left              = 230
            .Width             = 339
            .Height            = 155
            .RowHeight         = 17
            .ScrollBars        = 2
            .ReadOnly          = .T.
            .Visible           = THIS.this_lExibirConta
        ENDWITH

        *-- Largura/cabecalho das colunas NAO ficam aqui: moram em
        *-- AplicarFormatoGrade, que eh a FONTE UNICA desses numeros e eh
        *-- reusada pelo CarregarDados depois do RecordSource (duplicar os
        *-- valores nos dois lugares eh o que deixa a grade mudar de
        *-- geometria entre a montagem e a 1a carga)
        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria das colunas da Grade
    *
    * Valores transcritos do dump (SIGOPSLC.Grade):
    *   Column1  Width=65   Header1.Caption="Grupo"  Alignment=2  ForeColor=90,90,90
    *   Column2  Width=65   Header1.Caption="Conta"  Alignment=2  ForeColor=90,90,90
    *   Column3  Width=175  Header1.Caption="Nome"   Alignment=2  ForeColor=90,90,90
    *   (todas Movable=.F., Resizable=.F., FontSize=8, Header1 Tahoma 8)
    * Conferencia: 65 + 65 + 175 = 305, dentro dos Grade.Width = 339.
    *
    * Existe como metodo porque a grade eh configurada em DOIS momentos - na
    * montagem (ConfigurarBlocoContaGrupo) e na recarga (CarregarDados, que
    * mexe em RecordSource/ControlSource e pode zerar Width e Caption, o
    * Problema 48). Com os dois chamando este metodo nao ha como os dois
    * lados divergirem em silencio.
    *
    * Metodo PUBLIC: o form pai pode reaplicar o formato depois de repopular
    * o proprio TmpCliente.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            WITH THIS.grd_4c_Dados
                .Column1.Width             = 65
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontSize          = 8
                .Column1.Header1.Caption   = "Grupo"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)

                .Column2.Width             = 65
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontSize          = 8
                .Column2.Header1.Caption   = "Conta"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)

                .Column3.Width             = 175
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.FontSize          = 8
                .Column3.Header1.Caption   = "Nome"
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * CarregarDados - liga a Grade ao cursor de contas do FORM PAI e a
    * repinta. Unico ponto do form que mexe no RecordSource da grade.
    *
    * Legado: a Grade nasce com RecordSource = "TmpCliente" direto no SCX, e
    * TmpCliente NAO pertence a este dialogo - eh um cursor que o chamador
    * deixa aberto antes do Do Form (mesma situacao de TmpBaixa e
    * crSigCdPgr, documentada no cabecalho de SigOpSlcBO.prg). Por isso aqui
    * nao ha SQLEXEC: nao ha consulta propria a fazer, so o binding.
    *
    * Sem o cursor aberto o binding NAO eh aplicado - atribuir RecordSource
    * de alias inexistente derruba o Init (regra #41). Devolve .F. nesse
    * caso, e o chamador trata como "nada a exibir", nao como erro: o bloco
    * de Conta/Grupo fica permanentemente oculto (regra #17), entao a
    * ausencia de TmpCliente eh o caminho NORMAL desta tela.
    *
    * Fecha com GO TOP + Refresh (regra #21a): popular/ligar cursor nao
    * repinta a grade sozinho.
    *
    * Metodo PUBLIC (regra #3): o harness de teste (TesteCarregarDadosReais)
    * o chama de fora, SEM argumento, e PROTECTED faria a chamada estourar
    * em runtime com "Property CARREGARDADOS is not found".
    *==========================================================================
    PROCEDURE CarregarDados
        LOCAL loc_lCarregou, loc_oErro
        loc_lCarregou = .F.

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF !USED("TmpCliente")
            RETURN .F.
        ENDIF

        TRY
            WITH THIS.grd_4c_Dados
                *-- ColumnCount antes do RecordSource. Reatribuir o MESMO
                *-- valor nao recria as Column (nao ha controle posto por
                *-- Column.AddObject nesta grade a perder)
                .ColumnCount = 3

                .RecordSource = "TmpCliente"

                *-- Colunas do dump: Column1=Grupo, Column2=Conta,
                *-- Column3=Nome (os campos que o AfterRowColChange legado
                *-- le para alimentar Get_Grupo/Get_Conta/Get_DConta)
                .Column1.ControlSource = "TmpCliente.Grupo"
                .Column2.ControlSource = "TmpCliente.Conta"
                .Column3.ControlSource = "TmpCliente.Nome"
            ENDWITH

            *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
            *-- podem zerar Width e Header1.Caption. Mesma fonte usada na
            *-- montagem, entao nao ha numero duplicado aqui
            THIS.AplicarFormatoGrade()

            *-- Legado: a Grade so mostra dado depois do posicionamento +
            *-- repintura (o Init legado termina com This.Refresh)
            GO TOP IN TmpCliente
            THIS.grd_4c_Dados.Refresh()

            loc_lCarregou = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a grade de contas: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * ConfigurarEventosContaGrupo - liga os eventos do bloco de Grupo/Conta
    * (fase 8). Chamado logo depois de ConfigurarBlocoContaGrupo, que cria
    * txt_4c_Grupo/txt_4c_Conta/txt_4c_DCONTA/grd_4c_Dados.
    *
    * BINDEVENT em "LostFocus" (nao "Valid" - nao confiavel em TextBox,
    * regra #47) para os tres campos; "When" so no DCONTA (unico que o
    * legado declara); "AfterRowColChange" na Grade SEM filtro de coluna
    * (sincroniza os tres campos com a linha corrente - uso legitimo da
    * regra #46); "KeyPress" nos Text1 das tres colunas (navegacao Tab/
    * Enter -> foco em Grupo, igual ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosContaGrupo
        IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
            BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupoLostFocus")
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Conta", 5)
            BINDEVENT(THIS.txt_4c_Conta, "LostFocus", THIS, "ValidarContaLostFocus")
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
            BINDEVENT(THIS.txt_4c_DCONTA, "LostFocus", THIS, "ValidarDContaLostFocus")
            BINDEVENT(THIS.txt_4c_DCONTA, "When", THIS, "DContaWhen")
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
                BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
            ENDIF
            IF PEMSTATUS(THIS.grd_4c_Dados, "Column2", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
                BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
            ENDIF
            IF PEMSTATUS(THIS.grd_4c_Dados, "Column3", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column3, "Text1", 5)
                BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupoLostFocus - Get_Grupo.Valid do legado:
    *
    *     If !fAcessoContab( Usuar, 'C', This.Value, This,'',
    *                        Thisform.get_conta.value )
    *         Messagebox( 'Acesso Negado...', 48, '' )
    *         This.Value = ''
    *     Endif
    *
    * fAcessoContab (utils\functions.prg) ja escreve This.Value/.Refresh
    * sozinho quando recebe um objeto em pCod - por isso o 4o argumento eh o
    * proprio TextBox, igual ao legado passa "This".
    *
    * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico.
    *==========================================================================
    PROCEDURE ValidarGrupoLostFocus
        LOCAL loc_oErro

        IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        TRY
            IF !fAcessoContab(gc_4c_UsuarioLogado, "C", THIS.txt_4c_Grupo.Value, ;
                    THIS.txt_4c_Grupo, "", THIS.txt_4c_Conta.Value)
                MsgAviso("Acesso Negado...", "")
                THIS.txt_4c_Grupo.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar o grupo: " + loc_oErro.Message, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarContaLostFocus - Get_Conta.Valid do legado:
    *
    *     If !fAcessoContas( Usuar, This.Get_Grupo.Value, 'C', This.Value,
    *                        This.Get_Conta, This.Get_dConta )
    *         Messagebox( 'Acesso Negado...', 48, '' )
    *         This.Get_Conta.Value = ''
    *         This.Get_dConta.Value = ''
    *     Endif
    *
    * "This" no dump refere-se ao FORM (unico jeito de "This.Get_Grupo"
    * fazer sentido, ja que o TextBox Get_Conta nao tem esse membro) - este
    * handler mora no form, entao THIS ja eh a referencia correta.
    *==========================================================================
    PROCEDURE ValidarContaLostFocus
        LOCAL loc_oErro

        IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
                OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
            RETURN
        ENDIF

        TRY
            IF !fAcessoContas(gc_4c_UsuarioLogado, THIS.txt_4c_Grupo.Value, "C", ;
                    THIS.txt_4c_Conta.Value, THIS.txt_4c_Conta, THIS.txt_4c_DCONTA)
                MsgAviso("Acesso Negado...", "")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_DCONTA.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar a conta: " + loc_oErro.Message, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDContaLostFocus - Get_DCONTA.Valid do legado (mesma logica de
    * ValidarContaLostFocus, 'D' no lugar de 'C' - tipo busca por
    * descricao/leitora de cheque):
    *
    *     If !fAcessoContas( Usuar, This.Get_Grupo.Value, 'D', This.Value,
    *                        This.Get_Conta, This.Get_dConta )
    *         Messagebox( 'Acesso Negado...', 48, '' )
    *         This.Get_Conta.Value = ''
    *         This.Get_dConta.Value = ''
    *     Endif
    *==========================================================================
    PROCEDURE ValidarDContaLostFocus
        LOCAL loc_oErro

        IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
                OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
            RETURN
        ENDIF

        TRY
            IF !fAcessoContas(gc_4c_UsuarioLogado, THIS.txt_4c_Grupo.Value, "D", ;
                    THIS.txt_4c_DCONTA.Value, THIS.txt_4c_Conta, THIS.txt_4c_DCONTA)
                MsgAviso("Acesso Negado...", "")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_DCONTA.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar a conta: " + loc_oErro.Message, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DContaWhen - Get_DCONTA.When do legado:
    *     Return IsEmpty(Thisform.Get_Conta.Value)
    *
    * O foco so entra em DCONTA enquanto Conta estiver vazia (fluxo de
    * leitora de cheque - ToolTipText "Passe o Cheque na Leitora").
    *
    * Metodo PUBLIC/FUNCTION (regra #3): BINDEVENT exige alvo publico.
    *==========================================================================
    FUNCTION DContaWhen()
        IF !PEMSTATUS(THIS, "txt_4c_Conta", 5)
            RETURN .T.
        ENDIF

        RETURN EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
    ENDFUNC

    *==========================================================================
    * GradeAfterRowColChange - Grade (Procedure) do legado:
    *
    *     LPARAMETERS nColIndex
    *     ThisForm.Get_Grupo.Value = Grupo
    *     ThisForm.Get_Conta.Value = Conta
    *     ThisForm.Get_DConta.Value = Nome
    *
    * Sincroniza os tres campos com a linha corrente de TmpCliente (mesmos
    * campos ligados em CarregarDados: Column1/2/3 -> Grupo/Conta/Nome).
    * SEM filtro de coluna - uso legitimo de AfterRowColChange (regra #46):
    * nao valida celula, so espelha o registro atual.
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
                OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
            RETURN
        ENDIF

        IF !USED("TmpCliente") OR EOF("TmpCliente")
            RETURN
        ENDIF

        THIS.txt_4c_Grupo.Value  = TratarNulo(TmpCliente.Grupo, "")
        THIS.txt_4c_Conta.Value  = TratarNulo(TmpCliente.Conta, "")
        THIS.txt_4c_DCONTA.Value = TratarNulo(TmpCliente.Nome, "")
    ENDPROC

    *==========================================================================
    * GradeColunaKeyPress - Grade.ColumnN.Text1.KeyPress do legado (as tres
    * colunas tem o mesmo corpo):
    *
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     If nKeyCode = 9 or nKeyCode = 13
    *         ThisForm.Get_Grupo.SetFocus
    *     Endif
    *==========================================================================
    PROCEDURE GradeColunaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
                THIS.txt_4c_Grupo.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarLayoutConformeMoeda - ajuste de altura/posicao do Init legado:
    *
    *   If !_GetMoeda
    *       This.Height = This.Height - 25
    *   Else
    *       <busca o default de moeda em TmpBaixa - CarregarMoedaDefaultDeTmpBaixa>
    *   Endif
    *   If !_GetConta And _GetMoeda
    *       This.Get_cd_moeda.Top = 50
    *       This.Get_ds_moeda.top = 50
    *       This.SayMoeda.top = 54
    *       This.Height = 100
    *   Endif
    *
    * Como this_lExibirConta eh SEMPRE .F. (regra #17), "!_GetConta And
    * _GetMoeda" equivale sempre a "_GetMoeda" - os dois Ifs do legado
    * cobrem so os DOIS estados de this_lExibirMoeda:
    *
    *   this_lExibirMoeda = .F. -> Height -= 25 (375), sem reposicionar
    *   this_lExibirMoeda = .T. -> busca o default em TmpBaixa E reposiciona
    *       get_cd_moeda/get_ds_moeda/SayMoeda, com Height = 100
    *
    * Chamado do InicializarForm, DEPOIS de ConfigurarBlocoMoeda (os
    * controles reposicionados precisam existir) e ANTES de
    * TornarControlesVisiveis.
    *==========================================================================
    PROTECTED PROCEDURE AjustarLayoutConformeMoeda
        IF !THIS.this_lExibirMoeda
            THIS.Height = THIS.Height - 25
        ELSE
            THIS.CarregarMoedaDefaultDeTmpBaixa()

            IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
                THIS.txt_4c__cd_moeda.Top = 50
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
                THIS.txt_4c__ds_moeda.Top = 50
            ENDIF
            IF PEMSTATUS(THIS, "lbl_4c_Moeda", 5)
                THIS.lbl_4c_Moeda.Top = 54
            ENDIF

            THIS.Height = 100
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarMoedaDefaultDeTmpBaixa - legado:
    *
    *   Select TmpBaixa
    *   Scan for Tipos = 'X'
    *       This.Get_cd_moeda.value = moedas
    *       =Seek( moedas, 'crSigCdMoe', 'CMoes' )
    *       This.Get_ds_moeda.value = crSigCdMoe.dmoes
    *       exit
    *   Endscan
    *
    * TmpBaixa eh cursor do FORM PAI (mesma situacao de TmpCliente e
    * crSigCdPgr na fase 4) - sem ele aberto nesta DataSession = 1, nao ha
    * default a buscar, e isso NAO eh erro (devolve .F. calado).
    *
    * O Seek legado em crSigCdMoe (cursor global, SEM checar o resultado)
    * equivale aqui a ValidarMoedaPorCodigo(), que faz o SQLEXEC em
    * SigCdMoe e preserva o codigo encontrado em TmpBaixa mesmo que a
    * busca na tabela de moedas nao encontre nada (regra #37/#50 - nunca
    * apagar um codigo ja resolvido).
    *
    * Restaura o alias corrente ao final: SELECT TmpBaixa muda a work area
    * ativa, e este metodo roda antes de qualquer outra carga do form.
    *==========================================================================
    PROTECTED PROCEDURE CarregarMoedaDefaultDeTmpBaixa
        LOCAL loc_cAliasAnterior, loc_cMoedaDefault, loc_oErro
        loc_cMoedaDefault = ""

        IF !USED("TmpBaixa")
            RETURN .F.
        ENDIF

        loc_cAliasAnterior = ALIAS()

        TRY
            SELECT TmpBaixa
            SCAN FOR Tipos = "X"
                loc_cMoedaDefault = TratarNulo(moedas, "")
                EXIT
            ENDSCAN
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler a moeda padr" + CHR(227) + ;
                "o em TmpBaixa: " + loc_oErro.Message
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        IF EMPTY(loc_cMoedaDefault)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.ValidarMoedaPorCodigo(loc_cMoedaDefault)

            IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
                THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
                THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre o form e os containers tornando
    * visivel o que foi criado.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
    *
    * Esta fase ja tem o bloco de Grupo/Conta (this_lExibirConta sempre .F.)
    * e o bloco de moeda (this_lExibirMoeda): o loop generico forca .T. em
    * TUDO, entao os dois blocos tem de ser re-ocultados/reavaliados DEPOIS
    * do loop - exatamente como o Init legado faz com
    * This.Grade.Visible = _GetConta etc.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) != "O"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                IF loc_oControle.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)

                        IF VARTYPE(loc_oFilho) = "O"
                            IF PEMSTATUS(loc_oFilho, "Visible", 5)
                                loc_oFilho.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        *-- Bloco de Grupo/Conta - SEMPRE oculto (regra #17: this_lExibirConta
        *-- eh forcado a .F. no Init, para qualquer chamador)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Visible = THIS.this_lExibirConta
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Grupo", 5)
            THIS.lbl_4c_Grupo.Visible = THIS.this_lExibirConta
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Conta", 5)
            THIS.lbl_4c_Conta.Visible = THIS.this_lExibirConta
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
            THIS.txt_4c_Grupo.Visible = THIS.this_lExibirConta
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Conta", 5)
            THIS.txt_4c_Conta.Visible = THIS.this_lExibirConta
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
            THIS.txt_4c_DCONTA.Visible = THIS.this_lExibirConta
        ENDIF

        *-- Bloco de moeda - segue this_lExibirMoeda (legado: Visible = _GetMoeda)
        IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
            THIS.txt_4c__cd_moeda.Visible = THIS.this_lExibirMoeda
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
            THIS.txt_4c__ds_moeda.Visible = THIS.this_lExibirMoeda
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Moeda", 5)
            THIS.lbl_4c_Moeda.Visible = THIS.this_lExibirMoeda
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - devolve o controle ao FormBase (que libera o BO e restaura o
    * menu - regra #52 do CLAUDE.md).
    *
    * NAO libera this_oFormPai: o SCX legado nunca chama ParentForm.Release -
    * o pai continua vivo e eh ele quem usa o resultado (CanceladoExterno/
    * MoedaMaior) depois que este dialogo fecha. Aqui a referencia eh apenas
    * anulada, para nao segurar o pai alem do tempo.
    *==========================================================================
    PROCEDURE Destroy
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
