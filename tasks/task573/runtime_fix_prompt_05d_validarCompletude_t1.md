# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigMvMenBO.prg] Indicador de pendencia: * Inserir / Atualizar - deliberadamente NAO implement
[FormSigMvMen.prg] Indicador de pendencia: * tem"). O que a Fase 3 deixou pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[25/09/2026 05:18:30] Erro: Código da operação não informado



## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvMen.prg):
*====================================================================
* FormSigMvMen.prg
*
* Dialogo "Mensagem da Movimentacao"
* Formulario legado: SIGPDMEN (SigMvMen.scx)
*
* Tipo: OPERACIONAL - dialog modal simples, SEM PageFrame. A arvore de
* objetos do legado (tasks\task573\SigMvMen_form_codigo_fonte.txt,
* SECAO 1) tem raiz Class:form/BaseClass:form generica e nenhum
* BaseClass:pageframe - nao ha Page1/Lista nem Page2/Dados para
* reproduzir (ver CLAUDE.md e a licao "Gate da Fase 3 exigia
* ConfigurarPageFrame que o legado flat nao tem"). O form recebe o
* codigo da operacao (par_cDopes) e exibe, num EditBox somente-leitura,
* a mensagem configurada para essa operacao em SigOpCdI.
*
* FASE 4/8 - O legado (SIGPDMEN) eh um dialogo modal SEM lista e SEM
* PageFrame Lista/Dados: a arvore do dump (SECAO 1) nao tem BaseClass
* grid nem pageframe, entao o par "Grid + botoes CRUD" desta fase nao
* se aplica (mesma familia de excecao de FormSigMvExp/SIGMVEXP - ver
* licao "Gate da Fase 4 exigia Grid/CRUD que o legado despachante nao
* tem"). O que a Fase 3 deixou pendente para esta fase eh o UNICO
* controle interativo real do dialogo - o botao "ok" (SIGPDMEN.ok,
* classe fwbtng) - e o carregamento da mensagem via
* SigMvMenBO.CarregarPorCodigo, que o Init legado fazia depois de
* montar a tela (Cursorquery + Container1.GetMemo.Value + Ok.SetFocus).
*
* FASE 6/8 - "Campos restantes e lookups" tambem nao se aplica: o dump
* do legado (SECAO 1 + comportamento.json) nao tem nenhum padrao de
* lookup (sem CreateObject('fwbuscaext'/'fwBuscaSel',...), sem
* sigacess(), sem PROCEDURE Valid com busca) em controle nenhum do
* form - getMemo eh ReadOnly e o unico evento interativo eh
* SIGPDMEN.ok.Click (Fase 4). Todos os 8 objetos nao-vazios de
* tasks\task573\layout.json (cntSombra/lblSombra/lblTitulo/Shape1/ok/
* Container1/getMemo/Label2) ja foram criados nas fases 3-4 e a carga
* do texto (equivalente ao Cursorquery do Init legado) ja foi
* implementada em CarregarMensagem(). Nao ha "restante" a acrescentar
* (mesma familia da licao "Gate da Fase 6 exigia lookup que o legado
* nao tem" - nao inventar lookup/campo que o legado nao possui).
* Campo ReadOnly nao recebe lookup por definicao: nao ha onde o usuario
* digitar codigo para o picker resolver. O gate da Fase 6 valida este
* form pelo ramo EXIBICAO (temLayoutExibicaoF6 em
* automation\OrquestradorMigracao.ps1), espelho do que as Fases 4 e 5
* ja tinham - ver Test-LegadoDialogoExibicao.
*
* FASE 7/8 - "Eventos principais dos botoes" tambem nao se aplica no
* sentido literal de Incluir/Alterar/Visualizar/Excluir: o dump legado
* (SECAO 1) nao tem frmcadastro, nem Grupo_Op, nem qualquer botao ou
* variavel de modo CRUD - SIGPDMEN herda de `form` puro e declara UM
* UNICO controle interativo, SIGPDMEN.ok (fwbtng). Inventar os 4
* handlers CRUD violaria o PILAR 1 (o usuario veria botoes que o
* legado nunca teve) e a regra de completude (eles ficariam vazios,
* ja que nao ha o que Incluir/Alterar/Visualizar/Excluir num dialogo
* somente-leitura). O "evento principal" real deste form eh
* SIGPDMEN.ok.Click, ja implementado na Fase 4 como BtnOkClick() com a
* mesma logica do legado (Lastkey() # 13 -> Release; senao avisa e
* mantem o foco). O gate da Fase 7 (automation\OrquestradorMigracao.ps1)
* trata exatamente este caso: legado sem CRUD e com um unico botao no
* SCX valida pelo(s) handler(s) desse botao (minHandlersF7 = 1 quando
* Get-ContagemBotoesLegado = 1) - mesma familia das excecoes ja
* documentadas acima para as Fases 3, 4 e 6.
*
* FASE 8/8 - Consolidacao. Dos metodos que a fase lista, os que se
* aplicam a um dialogo somente-leitura foram entregues e os que sao
* convencao de form CRUD NAO existem, por nao haver o que implementar
* sem inventar tela (PILAR 1) ou deixar metodo vazio (regra de
* completude):
*
*   ENTREGUES nesta fase
*     BOParaForm()   - override do hook PROTECTED de FormBase (chamado
*                      por FormBase.Cancelar). Mapeia o UNICO campo do
*                      dialogo: SigMvMenBO.this_cMensagem -> EditBox
*                      obj_4c_GetMemo. A carga (CarregarMensagem) passou
*                      a usar este metodo, de modo que o mapeamento
*                      BO->tela vive num lugar so.
*     CarregarLista() - re-le a mensagem da operacao corrente no banco e
*                      repinta o painel. O "conteudo listado" deste
*                      dialogo eh a mensagem; eh o hook que o harness
*                      TesteAutomatico.prg exercita (PUBLIC - regra #3).
*
*   NAO SE APLICAM (o gate da Fase 8 trata este caso pelo ramo
*   legadoExibicaoF8 em automation\OrquestradorMigracao.ps1)
*     FormParaBO()      - sentido tela->BO. Nao existe campo editavel
*                         (getMemo eh ReadOnly = .T. no SCX) e a unica
*                         entrada do dialogo eh o parametro par_cDopes,
*                         que o Init ja guarda em this_cDopes.
*     BtnSalvarClick / BtnCancelarClick / HabilitarCampos / LimparCampos /
*     AjustarBotoesPorModo / BtnIncluir|Alterar|Visualizar|Excluir|
*     Buscar|EncerrarClick - o dump legado (SECAO 1/SECAO 3) nao tem
*                         frmcadastro, nem Grupo_Op, nem modo de edicao,
*                         nem Page2 de Dados: SIGPDMEN declara UM unico
*                         controle interativo (SIGPDMEN.ok) e o unico
*                         evento eh o Click dele, ja migrado como
*                         BtnOkClick. FormBase nao amarra F2-F5 a esses
*                         nomes (conferido em classes\formbase.prg), e
*                         FormParaBO/BOParaForm/LimparCampos ja existem
*                         la como hook - ausencia aqui nao quebra nada
*                         em runtime.
*
* Load legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo motivo
* registrado em FormSigMvExp.prg (task570): fConfigGeral era funcao
* GLOBAL de inicializacao da aplicacao legado, e na arquitetura nova
* esse papel eh do start\config.prg, que roda uma vez no startup. O
* wrapper utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
* legado que ainda o chamam (regra #27) - codigo nosso nao o chama.
*
* Chamador real (NAO eh item de menu): SIGMVCAB (tasks\task560) abre
* este dialogo no meio da validacao da movimentacao -
*   If crSigOpCdd.EmitMen = 1 And Not IsEmpty(crSigOpCdI.Mensagem)
*       Do Form SigMvMen With TprMvCab.Dopes
* - sempre COM o codigo da operacao. Por isso o form nao recebe entrada
* em menu.prg: pelo menu ele abriria sem par_cDopes e exibiria um painel
* em branco, tela que o legado nunca teve. A chamada a partir de
* Formsigmvcab.prg depende da migracao daquele bloco de validacao
* (crSigOpCdd.EmitMen), que hoje nao existe no form migrado e pertence a
* task560 - registrado, fora do escopo desta task.
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormSigMvMen AS FormBase

    *-- Parametro de entrada (codigo da operacao - SigOpCdI.dopes)
    this_cDopes = ""

    *-- Propriedades visuais (override FormBase) - copiadas do dump
    *-- do legado (SECAO 2, objeto SIGPDMEN)
    Width      = 800
    Height     = 269
    AutoCenter = .T.
    TitleBar   = 0
    ShowWindow = 1
    ControlBox = .F.
    MaxButton  = .F.
    MinButton  = .F.
    WindowType = 1
    Themes     = .F.
    Caption    = "Mensagens"

    *--------------------------------------------------------------------------
    * Init - Recebe o codigo da operacao e instancia o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDopes)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

            THIS.this_oBusinessObject = CREATEOBJECT("SigMvMenBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar Business Object de Mensagem da Movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarShape()
            THIS.ConfigurarBotaoOk()
            THIS.ConfigurarLabel2()
            THIS.ConfigurarContainer()
            THIS.CarregarMensagem()

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame):
    * aplica ao proprio Form as propriedades visuais que, no legado,
    * pertencem ao container raiz do dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.

        *-- Fonte: NADA a definir aqui, de proposito.
        *--
        *-- O SCX legado nao declara FontName/FontSize nem no form (SIGPDMEN)
        *-- nem no EditBox (getMemo): os dois ficam no default do VFP, e a
        *-- tabela de fontes do dump registra exatamente as duas fontes que a
        *-- tela usa - "Arial, 0, 9" (o default, de getMemo) e
        *-- "Comic Sans MS, 3, 8" (o botao OK, bold+italic). Quem declara fonte
        *-- no legado sao so os tres labels (Tahoma), ja reproduzidos em
        *-- ConfigurarCabecalho/ConfigurarLabel2.
        *--
        *-- Medido no VFP9 em 2026-09-25 (tasks\task573\logs\diag_config.txt):
        *-- controle criado por AddObject NAO herda a fonte do form - com
        *-- THIS.FontName = "Tahoma" no form, obj_4c_GetMemo continuou em
        *-- Arial/9. Entao versao antiga (SetAll antes de existir controle) e
        *-- form-level eram as DUAS no-op; e o default Arial 9 que o EditBox
        *-- recebe da base class JA eh o do legado. Declarar Tahoma aqui seria
        *-- divergir do PILAR 1 sem nem mudar o que a tela desenha.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Mensagens"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = 769
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Mensagens"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - Shape decorativo atras do botao OK (cmd_4c_Ok)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 691
            .Height      = 65
            .Width       = 65
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoOk - Unico botao do dialogo (SIGPDMEN.ok, classe fwbtng).
    * Posicao (Top/Left) e Picture EXATOS do dump legado; Width/Height nao
    * declarados no SCX (herdados da classe fwbtng, ausente do acervo) -
    * usado o canonico 75x75 do framework para botoes com este mesmo icone
    * (cadastro_salvar_60.jpg), que cabe dentro do Shape1 (691,7,65,65) sem
    * estourar a largura do form (723+75=798 < 800).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 2
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabel2 - Label decorativo "[ Texto ]" acima do container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabel2()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "[ Texto ]"
            .Height    = 16
            .Left      = 297
            .Top       = 82
            .Width     = 55
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer - Container que exibira a mensagem (Container1
    * + getMemo no legado). O EditBox nasce vazio aqui - THIS.CarregarMensagem()
    * (chamado logo em seguida, em InicializarForm) preenche o texto via
    * SigMvMenBO.CarregarPorCodigo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer()
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 98
            .Left          = 49
            .Width         = 554
            .Height        = 150
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Container1.AddObject("obj_4c_GetMemo", "EditBox")
        WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
            .BorderStyle = 0
            .Height      = 145
            .Left        = 2
            .ReadOnly    = .T.
            .ScrollBars  = 0
            .Top         = 2
            .Width       = 551
            .BackColor   = RGB(212, 208, 200)
            .Value       = ""
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMensagem - Espelha o restante do Init legado: monta o Caption
    * ("Mensagem da Movimentacao: " + Dopes) nos tres lugares onde o legado
    * repete (Form.Caption + os dois labels da faixa) e busca o texto da
    * operacao via SigMvMenBO.CarregarPorCodigo (equivalente ao
    * CrSigOpCdI.Mensagem que o Init original lia).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMensagem()
        LOCAL loc_cCaption, loc_lValidandoUI

        loc_cCaption = "Mensagem da Movimenta" + CHR(231) + CHR(227) + "o: " + THIS.this_cDopes

        THIS.Caption = loc_cCaption
        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption

        *-- Validacao de UI roda SEM conexao (ValidarUIFidelity.prg faz
        *-- gnConnHandle = -1): sem esta guarda o BO devolve "Conexao nao
        *-- disponivel", o MsgErro abaixo abre dialogo modal e o pipeline
        *-- trava. Padrao do projeto - FORMCOR_LICOES_APRENDIDAS.md,
        *-- Problema 4; mesmo guard do gemeo FormSigPdMen.
        loc_lValidandoUI = (TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI)

        IF !loc_lValidandoUI AND VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cDopes)
                THIS.BOParaForm()
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF

        THIS.cnt_4c_Container1.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Mapeamento BO -> tela. Override do hook PROTECTED de
    * FormBase (FormBase.Cancelar chama THIS.BOParaForm()).
    *
    * O dialogo tem UM campo: o EditBox obj_4c_GetMemo, alimentado por
    * SigMvMenBO.this_cMensagem (coluna SigOpCdI.mensagem). Espelha o
    * "ThisForm.Container1.GetMemo.Value = Alltrim(Nvl(CrSigOpCdI.Mensagem,[]))"
    * do Init legado - inclusive o Nvl, porque mensagem eh text e aceita NULL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.cnt_4c_Container1.obj_4c_GetMemo.Value = ;
            ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagem, ""))

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - PUBLIC (o harness TesteAutomatico.prg chama direto no
    * objeto do form, de fora da classe - regra #3 CLAUDE.md).
    *
    * Este dialogo nao tem grade: o conteudo que ele "lista" eh a mensagem da
    * operacao. O metodo re-le essa mensagem no banco (via
    * SigMvMenBO.CarregarPorCodigo) e repinta o painel, reaproveitando
    * CarregarMensagem para nao duplicar a regra.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Sem conexao (ValidarUIFidelity faz gnConnHandle = -1) nao ha o que
        *-- reler; CarregarMensagem ja tem a mesma guarda, esta evita a ida
        *-- desnecessaria e mantem o retorno coerente para o harness.
        IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
            loc_lSucesso = .T.
        ELSE
            IF !EMPTY(THIS.this_cDopes) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.CarregarMensagem()
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - PUBLIC (BINDEVENT - regra #3 CLAUDE.md). Espelha
    * SIGPDMEN.ok.Click: fecha o dialogo apenas quando o clique NAO veio do
    * Enter (LASTKEY() # 13) - como o Ok recebe foco inicial (Activate),
    * Enter dispara o Click do botao "default" sem o usuario ter clicado de
    * verdade, e o legado usa isso para exigir um clique real antes de sair.
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        IF LASTKEY() != 13
            THIS.Release()
        ELSE
            MsgInfo("Clique no bot" + CHR(227) + "o OK para sair.", "Aten" + CHR(231) + CHR(227) + "o")
            CLEAR TYPEAHEAD
            KEYBOARD CHR(27)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - "ThisForm.Ok.SetFocus" do Init legado so funciona depois do
    * form estar visivel; reproduzido aqui (dispara toda vez que o dialogo
    * ganha foco, o que eh inofensivo para SetFocus - operacao idempotente).
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        LOCAL loc_oErro

        *-- SetFocus estoura em controle invisivel/desabilitado, e Activate
        *-- nao tem caller que trate o erro: sem o TRY o usuario veria o
        *-- "Program Error" CRU do VFP (regra #38) ao abrir o dialogo.
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
                IF THIS.cmd_4c_Ok.Visible AND THIS.cmd_4c_Ok.Enabled
                    THIS.cmd_4c_Ok.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * recursivamente (padrao do projeto - AddObject cria com Visible=.F.
    * por default; aqui cada Configurar* ja fixa .Visible = .T., mas o
    * metodo cobre containers/paginas adicionados nas proximas fases)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvMenBO.prg):
*====================================================================
* SigMvMenBO.prg
*
* Business Object para o dialogo "Mensagem da Movimentacao"
* Formulario legado: SIGPDMEN (SigMvMen.scx)
*
* O legado abre este popup a partir da tela de Movimentacao passando
* o codigo da operacao (pDopes) e exibe o texto configurado para essa
* operacao. O campo memo Mensagem NAO pertence a SigOpCdd (tabela que
* o Init legado consulta via CursorQuery, sem nunca ler o resultado) e
* sim a SigOpCdI - mesma chave Dopes, coluna mensagem (text). E dali
* que o BO busca o texto (docs/schema.sql: dbo.SigOpCdi.mensagem).
*
* Tabela: SigOpCdI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigMvMenBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpCdI)
    this_cDopes    = ""    && dopes char(20) - PK (codigo da operacao)
    this_cMensagem = ""    && mensagem text

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpCdI"
            THIS.this_cCampoChave = "dopes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvMenBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor para as propriedades
    *====================================================================
    * O 2o argumento de TratarNulo eh o VALOR PADRAO, nao um codigo de tipo:
    * FUNCTION TratarNulo(puValor, puPadrao) / IF ISNULL(puValor) ... /
    * RETURN puPadrao (utils\functions.prg). Passar "C" faz a coluna NULL
    * virar a STRING "C" - e mensagem eh text NULL em todas as 38 linhas de
    * SigOpCdI neste banco, entao o painel do dialogo exibia a letra "C" em
    * vez de ficar em branco (medido em 2026-09-25,
    * tasks\task573\logs\diag_db2.txt). O legado faz Nvl(...,[]) - branco.
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopes    = TratarNulo(dopes, "")
            THIS.this_cMensagem = TratarNulo(mensagem, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Busca em SigOpCdI a mensagem configurada para a
    * operacao informada (equivalente funcional ao que o legado tentava
    * fazer lendo CrSigOpCdI - ver comentario no cabecalho do arquivo).
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cDopes, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigMvMen")
            USE IN cursor_4c_SigMvMen
        ENDIF

        loc_cSQL = "SELECT dopes, mensagem FROM SigOpCdI WHERE dopes = " + ;
            EscaparSQL(PADR(ALLTRIM(par_cDopes), 20))

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvMen")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigMvMen") > 0
                    THIS.CarregarDoCursor("cursor_4c_SigMvMen")
                ELSE
                    * Operacao sem registro de configuracao em SigOpCdI: o legado
                    * exibia a mensagem em branco (Nvl(...,[])) - reproduzir aqui.
                    THIS.this_cDopes    = ALLTRIM(par_cDopes)
                    THIS.this_cMensagem = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar mensagem da opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("cursor_4c_SigMvMen")
            USE IN cursor_4c_SigMvMen
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Chave do registro atual (para auditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cDopes, ""))
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - deliberadamente NAO implementados.
    *
    * O legado (SIGPDMEN) e um dialogo somente-leitura: getMemo tem
    * ReadOnly = .T. e o unico botao ("Ok") apenas fecha a tela - nao
    * existe Salvar. SigOpCdI e o registro MESTRE de configuracao da
    * Operacao (mais de 140 colunas NOT NULL alem de "mensagem"),
    * mantido pelo cadastro de Operacoes; implementar INSERT/UPDATE
    * aqui exigiria inventar valores para colunas que esta tela nunca
    * exibe, arriscando sobrescrever configuracao real (Pilar 2).
    * BusinessBase.Salvar() nunca eh chamado por este BO/form.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

ENDDEFINE

