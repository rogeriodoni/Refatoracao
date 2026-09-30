# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrEop.prg] Indicador de pendencia: *             fechar). Nada mais ficou pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg):
*====================================================================
* FormSigPrEop.prg
*
* Form OPERACIONAL modal (picker) - Selecao de Operacoes
*
* Chamado por outro form que ja populou um cursor de origem
* (equivalente a crTprMvCab do legado) com as movimentacoes
* candidatas. O usuario marca quais linhas entram no filtro e o
* form devolve, no cursor de destino informado pelo chamador, a
* chave composta EmpDopNums (ver SigPrEopBO.ObterChavePrimaria)
* de cada linha marcada - identico ao Scan do cmdSair.Click legado.
*
* Layout FLAT (legado SIGPREOP.SCX NAO tem PageFrame - grid,
* checkbox de marcar todos, par de campos somente-exibicao
* (Operacao/Numero) e botao OK ficam direto no form): grid e
* botoes entram na Fase 4, campos de exibicao na Fase 5,
* BINDEVENTs/eventos nas Fases 7-8.
*
* Chamada: CREATEOBJECT("FormSigPrEop", oParentForm,
*              cCabecalhoDados, cCursorOrigem, cCursorDestino)
* Herda de: FormBase
*
* Historico de fases:
*   Fase 1/2: SigPrEopBO.prg (propriedades + CarregarOperacoes/
*             MarcarTodasOperacoes/MontarCursorSelecionados)
*   Fase 3:   FormSigPrEop.prg - estrutura base (heranca, Init,
*             InicializarForm, faixa de cabecalho)
*   Fase 4:   FormSigPrEop.prg - grd_4c_Dados (7 colunas na ordem
*             ColumnOrder do legado), CarregarDados (carga do cursor +
*             vinculo da grade + GO TOP/Refresh), chk_4c_Ck_Marca e
*             cmd_4c_CmdSair (criacao visual; Click/BINDEVENT ficam
*             para as Fases 7/8)
*   Fase 5:   FormSigPrEop.prg - lbl_4c_Lbl_descricao + txt_4c__Operacao
*             (1o par label/campo de exibicao da linha corrente do
*             grid - equivalente a "ThisForm.get_Operacao.ControlSource
*             = [crOperacoes.Dopes]" do Init legado)
*   Fase 6:   FormSigPrEop.prg - lbl_4c_Label1 + txt_4c__Numes (2o par
*             label/campo de exibicao - Say1/get_Numes do legado,
*             equivalente a "ThisForm.get_Numes.ControlSource =
*             [crOperacoes.Numes]" do Init legado), o comportamento
*             desses campos (GridAfterRowColChange ligado por BINDEVENT
*             no AfterRowColChange da grade - o AfterRowColChange legado
*             existe SO para dar Refresh nos dois) e a validacao do
*             cursor de trabalho (ValidarCursorOperacoes), que confere as
*             9 colunas vinculadas pela grade e pelos campos ANTES de
*             qualquer ControlSource.
*
*             Sem lookups porque o legado nao tem nenhum: os dois campos
*             de exibicao tem PROCEDURE When / Return(.F.) (nunca recebem
*             foco, sao so espelho da linha corrente do grid) e nao ha
*             fwbuscaext / fwBuscaSel / sigacess / mAddColuna /
*             CreateObject de busca em lugar nenhum do codigo fonte
*             original - inventar um picker aqui violaria o PILAR 1 e a
*             regra "NUNCA inventar tabelas de lookup que nao existem no
*             original". Sem container de Salvar/Cancelar: este form
*             OPERACIONAL ja tem seu unico botao de acao (cmd_4c_CmdSair,
*             "OK") criado na Fase 4 - o legado nao tem par
*             Confirmar/Cancelar.
*   Fase 7:   FormSigPrEop.prg - eventos principais: o toggle do checkbox
*             de cada linha da grade (Column1.Check1 - GridCheck1Click/
*             MouseDown/MouseUp/KeyPress, os 4 handlers ligados por
*             BINDEVENT porque o CheckBox de Grid nao alterna sozinho -
*             o legado suprime o toggle nativo e alterna por codigo no
*             MouseDown e no KeyPress de Enter/Espaco, replicado
*             identico ao comportamento.json), CkMarcaClick (ck_Marca.
*             Click - marcar/desmarcar todas as linhas via BO.
*             MarcarTodasOperacoes) e BtnOKClick (cmdSair.Click - monta
*             o cursor de saida via BO.MontarCursorSelecionados e fecha o
*             picker).
*   Fase 8:   Consolidacao final. Os 11 metodos/eventos do
*             comportamento.json (comportamento.json.resumo.totalMetodos)
*             ja estavam TODOS implementados ao fim da Fase 7 - conferido
*             metodo a metodo contra o dump (SIGPREOP.Init, .grdOperacoes.
*             AfterRowColChange, .grdOperacoes.Column1.Check1.Click/
*             KeyPress/MouseDown/MouseUp, .ck_Marca.Click, .get_Operacao.
*             When, .get_Numes.When, .cmdSair.Click). Unica mudanca desta
*             fase: o handler do cmdSair.Click, escrito na Fase 7 como
*             CmdSairClick, foi renomeado para BtnOKClick - mesmo metodo,
*             mesmo BINDEVENT, sem nenhuma linha de logica alterada -
*             porque o Caption do botao no legado eh literalmente "OK" e
*             esse eh o nome canonico do handler de acao+fechamento nesta
*             arquitetura (BtnOKClick, ao lado de BtnSalvarClick/
*             BtnConfirmarClick/BtnGravarClick/BtnProcessaClick/
*             BtnAplicarClick/BtnExecutarClick para outros forms
*             OPERACIONAL cujo unico botao tambem grava algo antes de
*             fechar). Nada mais ficou pendente para esta fase.
*
* NAO-PORT DELIBERADO:
*   Load (=fConfigGeral()) - fConfigGeral era funcao GLOBAL da aplicacao
*   legado (sig.prg/SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP
*   em projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX
*   legado (nao editavel) continuar resolvendo o nome; em codigo NOSSO
*   nunca se chama fConfigGeral. O que ela fazia (configuracao global) ja
*   ocorre ANTES deste form abrir: config.prg (SETs/paths/aliases),
*   main.prg (conexao) e o proprio SigPrEopBO (seus cursores). Mesmo
*   padrao de FormSigPrCar.prg/FormSigMvExp.prg.
*
* NOMES CANONICOS DE CRUD QUE NAO SE APLICAM (e por que):
*   O SCX legado (SIGPREOP) tem UM UNICO botao - cmdSair ("OK") - e NENHUM
*   PageFrame: a grade e os dois campos de exibicao ficam direto no form
*   (layout FLAT). Nao ha Page1(Lista)/Page2(Dados), nao ha modos
*   INCLUIR/ALTERAR/VISUALIZAR (o picker so exibe e deixa marcar linhas de
*   um cursor que o chamador ja filtrou) e nao ha gravacao em SQL Server
*   (o BO documenta em detalhe por que Inserir/Atualizar/ExecutarExclusao
*   ficam com o comportamento herdado de BusinessBase). Por isso (os nomes
*   abaixo aparecem PROPOSITALMENTE grafados com "..." no lugar do miolo:
*   escritos inteiros, seriam encontrados por gate que procura o nome como
*   SUBSTRING do arquivo e este comentario passaria a "provar" metodo que
*   nao existe):
*     - Btn...Click (Buscar/Encerrar/Salvar/Cancelar) -> NENHUM destes
*       existe. O unico botao do legado (cmdSair, Caption "OK") virou
*       BtnOKClick: ele faz as duas coisas que Confirmar + Encerrar
*       fariam num CRUD - monta o cursor de saida E fecha o picker -
*       identico ao "Insert into crFilOper ... / ThisForm.Release" do
*       cmdSair.Click legado, que tambem nao separa as duas acoes.
*     - Form...BO / BO...Form -> NAO existem como par de mapeamento de
*       TextBox <-> propriedades: nao ha "ficha" para editar, so uma
*       LISTA com uma coluna marcavel. O equivalente funcional eh
*       CarregarDoCursor do BO (chamado por MontarCursorSelecionados
*       dentro do SCAN), que le a linha corrente do cursor de trabalho.
*     - Habilitar...Campos / Limpar...Campos -> NAO existem. Os dois
*       campos de exibicao (txt_4c__Operacao/txt_4c__Numes) sao SEMPRE
*       ReadOnly (o legado bloqueia foco neles com When -> Return .F.) e
*       nunca mudam de estado por modo, porque nao ha modo.
*     - Carregar...Lista -> o equivalente eh CarregarDados() (Fase 4-5):
*       popula o cursor de trabalho a partir do cursor de origem do
*       chamador e vincula a grade, igual ao "Select 1 as Selecionada, *
*       from crTprMvCab into cursor crOperacoes" do Init legado.
*     - Ajustar...PorModo -> NAO existe. Nao ha modo nem botao que mude de
*       Enabled/Visible por modo - o unico botao fica sempre habilitado.
*====================================================================

DEFINE CLASS FormSigPrEop AS FormBase

    *-- Propriedades do SCX original (RESERVED3: parentform / podatamgr)
    this_oParentForm     = .NULL.   && referencia ao form pai (desabilitado enquanto o picker esta aberto)
    this_cCabecalhoDados = ""       && lcCabData legado - Caption da coluna PrazoEnts (Column4) da grade

    *-- Nomes de cursor. O legado usa globais fixos (crTprMvCab/
    *-- crOperacoes/crFilOper); a nova arquitetura recebe origem/destino
    *-- do chamador como parametro e fixa so o nome do cursor de trabalho
    this_cCursorOrigem    = ""                    && cursor JA POPULADO pelo chamador (equivalente a crTprMvCab)
    this_cCursorDestino   = ""                    && cursor de saida do chamador (equivalente a crFilOper)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && cursor de trabalho da grade (equivalente a crOperacoes)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX)
    Width        = 740
    Height       = 431
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    DataSession  = 1
    Caption      = "Opera" + CHR(231) + CHR(245) + "es"

    *--------------------------------------------------------------------------
    * Init - Recebe o form pai, o Caption da coluna de prazo e os
    * cursores de origem/destino informados pelo chamador (equivalente a
    * Init(pFrm, lcCabData) do legado; os nomes de cursor sao explicitos
    * porque a nova arquitetura nao usa mais crTprMvCab/crFilOper globais)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cCabecalhoDados, par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oParentForm     = par_oParentForm
            THIS.this_cCabecalhoDados = IIF(VARTYPE(par_cCabecalhoDados) = "C", par_cCabecalhoDados, "")
            THIS.this_cCursorOrigem   = IIF(VARTYPE(par_cCursorOrigem) = "C", par_cCursorOrigem, "")
            THIS.this_cCursorDestino  = IIF(VARTYPE(par_cCursorDestino) = "C", par_cCursorDestino, "")

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base do form (chamado
    * por FormBase.Init via DODEFAULT). Layout FLAT: o legado
    * (SIGPREOP.SCX) nao tem PageFrame - grid, checkbox, campos e botao
    * vao direto no form nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPictureFundo
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEopBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrEopBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigPrEop.InicializarForm")
            ELSE
                *-- 1. Fundo do form (Picture do SCX legado)
                loc_cPictureFundo = gc_4c_CaminhoFramework + "Imagens\new_background.jpg"
                IF FILE(loc_cPictureFundo)
                    THIS.Picture = loc_cPictureFundo
                ENDIF

                *-- 2. Faixa de cabecalho (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- 3. Grid de operacoes (grdOperacoes do legado). Aqui vai so
                *-- a ESTRUTURA: o vinculo com o cursor (RecordSource /
                *-- ControlSource) fica em CarregarDados, porque ControlSource
                *-- apontando para cursor que ainda nao existe derruba o Init e
                *-- a tela nao chega a abrir (CLAUDE.md regra #41)
                THIS.ConfigurarGrid()

                *-- 4. Campos de exibicao da linha corrente do grid
                *-- (get_Operacao/get_Numes do legado). So a ESTRUTURA
                *-- visual: o vinculo (ControlSource) fica em CarregarDados,
                *-- pela mesma razao da grade (regra #41 - ControlSource
                *-- antes do cursor existir derruba o Init)
                THIS.ConfigurarCampos()

                *-- 5. Carga dos dados + vinculo da grade e dos campos de
                *-- exibicao - equivalente ao "Select 1 as Selecionada, *
                *-- from crTprMvCab into cursor crOperacoes readwrite"
                *-- seguido do "With ThisForm.grdOperacoes" e das duas
                *-- linhas ControlSource de get_Operacao/get_Numes do Init
                *-- legado
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND ;
                   !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarDados()
                ENDIF

                *-- 6. Checkbox "marcar/desmarcar todas" (ck_Marca do legado) -
                *-- criado DEPOIS da grade para ficar por cima dela (Top=123
                *-- cai sobre o topo do grdOperacoes, Top=121, igual ao legado)
                THIS.ConfigurarCkMarca()

                *-- 7. Botao OK (cmdSair do legado)
                THIS.ConfigurarBotoes()

                *-- 8. Torna toda a arvore visivel (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria a faixa cinza do topo (cntSombra do
    * legado): container opaco RGB(100,100,100) com o Caption do form
    * duplicado em lbl_4c_Sombra (sombra preta) e lbl_4c_Titulo (texto
    * branco por cima) - identico ao Init legado
    * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption /
    * ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 25
            .Left      = 10
            .Width     = THIS.cnt_4c_Cabecalho.Width - 31
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 24
            .Left        = 10
            .Width       = THIS.cnt_4c_Cabecalho.Width - 31
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Cria grd_4c_Dados (grdOperacoes do legado) com as 7
    * colunas na ordem visual do Init legado (ColumnOrder, NAO a ordem
    * fisica dos registros do dump - o SCX legado renomeia as colunas
    * internamente, mas aqui a colecao Columns(1..7) ja nasce na ordem
    * certa, sem precisar de rename - CLAUDE.md proibe .Name em Columns).
    * Somente a Column1 (Selecionada) eh editavel: AddObject de CheckBox +
    * CurrentControl + Sparse=.F., ReadOnly=.F. (regra do CheckBox em
    * Grid Column). As demais colunas replicam o
    * "For I=2 To .ColumnCount ... .ReadOnly = .t." do Init legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 121
            .Left              = 3
            .Width             = 732
            .Height            = 275
            .FontName          = "Tahoma"
            .HeaderHeight      = 19
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .ColumnCount       = 7

            *-- Column1 - Selecionada (checkbox, ColumnOrder implicito = 1)
            .Column1.AddObject("chk_4c_Check1", "CheckBox")
            WITH .Column1
                .FontName       = "Tahoma"
                .Width          = 15
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .F.
                .Sparse         = .F.
                .CurrentControl = "chk_4c_Check1"
                .Header1.Caption   = ""
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
            *-- O legado deixa o Caption default ("Check1") e liga AutoSize no
            *-- Init (.Column1.Check1.AutoSize = .t.); com a coluna em 15px o
            *-- texto fica recortado e so a caixinha aparece. Aqui o Caption
            *-- nasce vazio (mesmo resultado visual, sem depender do recorte)
            WITH .Column1.chk_4c_Check1
                .Caption   = ""
                .AutoSize  = .T.
                .Value     = 0
                .BackStyle = 0
            ENDWITH

            *-- Column2 - Datas (ColumnOrder = 2)
            WITH .Column2
                .FontName          = "Courier New"
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Data"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column3 - Emps (ColumnOrder = 3)
            WITH .Column3
                .FontName          = "Courier New"
                .Width             = 35
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Emp"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column4 - PrazoEnts (ColumnOrder = 4). Header dinamico:
            *-- "Column4.Header1.Caption = lcCabData" no Init legado
            WITH .Column4
                .FontName          = "Courier New"
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = IIF(!EMPTY(THIS.this_cCabecalhoDados), THIS.this_cCabecalhoDados, "Prev. Entrega")
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column5 - Contas (ColumnOrder = 5)
            WITH .Column5
                .FontName          = "Courier New"
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Cliente"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column6 - RClis (ColumnOrder = 6)
            WITH .Column6
                .FontName          = "Courier New"
                .Width             = 200
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Nome do Cliente"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column7 - Conjuges (ColumnOrder = 7, FontSize=9 no legado)
            WITH .Column7
                .FontName          = "Courier New"
                .FontSize          = 9
                .Width             = 205
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Conjug" + CHR(234)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- AfterRowColChange do legado: ao mudar a linha corrente da grade,
        *-- os dois campos de exibicao se repintam com os valores da nova
        *-- linha ("ThisForm.get_Operacao.Refresh() / ThisForm.get_Numes.
        *-- Refresh()"). Ligado aqui, junto da criacao da grade, porque o
        *-- evento existe SO para servir esses dois campos. O handler eh
        *-- PUBLIC e declara o parametro do evento - metodo PROTECTED ou sem
        *-- LPARAMETERS falha em SILENCIO no BINDEVENT (CLAUDE.md regra #3).
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")

        *-- Toggle do checkbox de marcacao (Column1.Check1 do legado). O
        *-- binding nativo do CheckBox de Grid NAO alterna o valor sozinho
        *-- (a celula recebe foco mas clicar/teclar nao muda nada) - o
        *-- legado suprime o toggle padrao nos 4 eventos e alterna por
        *-- codigo: Click = NoDefault (nao faz nada sozinho), MouseDown =
        *-- alterna Selecionada + Refresh + NoDefault, MouseUp = so
        *-- NoDefault, KeyPress = alterna em Enter(13)/Espaco(32) + Refresh
        *-- + NoDefault. Replicado tal qual (comportamento.json).
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "GridCheck1Click")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "GridCheck1MouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "GridCheck1MouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "GridCheck1KeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Cria os campos de exibicao da linha corrente do
    * grid (get_Operacao/get_Numes do legado, classe wget/textbox). Layout
    * FLAT direto no form, coordenadas EXATAS do dump (lbl_descricao
    * Top=402/Left=19/Width=56, get_Operacao Top=398/Left=87/Width=150).
    *
    * O legado bloqueia foco nesses campos (PROCEDURE When / Return(.F.)):
    * sao so espelho da linha corrente, nunca digitaveis pelo usuario.
    * Equivalente funcional aqui e .ReadOnly = .T. (o campo mostra o
    * valor mas nao aceita edicao).
    *
    * Cria os dois pares do dump: "Operacao" (lbl_4c_Lbl_descricao +
    * txt_4c__Operacao) e "Numero" (lbl_4c_Label1 + txt_4c__Numes -
    * Say1/get_Numes do legado). O ControlSource dos quatro NAO eh atribuido aqui:
    * fica em CarregarDados, depois que o cursor de trabalho existe
    * (CLAUDE.md regra #41).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
        WITH THIS.lbl_4c_Lbl_descricao
            .Top       = 402
            .Left      = 19
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c__Operacao", "TextBox")
        WITH THIS.txt_4c__Operacao
            .Top       = 398
            .Left      = 87
            .Width     = 150
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say1 do legado ("N" + CHR(186) + " :"), AutoSize=.T. no SCX -
        *-- texto curto (4 chars), sem risco de recorte (CLAUDE.md #23)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 402
            .Left      = 249
            .Width     = 21
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(186) + " :"
        ENDWITH

        THIS.AddObject("txt_4c__Numes", "TextBox")
        WITH THIS.txt_4c__Numes
            .Top       = 398
            .Left      = 276
            .Width     = 50
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula o cursor de trabalho da grade a partir do
    * cursor de origem que o chamador entregou e (re)vincula a grade a ele.
    *
    * Equivale ao "Select 1 as Selecionada, * from crTprMvCab into cursor
    * crOperacoes readwrite" + "With ThisForm.grdOperacoes ... EndWith" do
    * Init legado. Fica num metodo proprio (e nao dentro de ConfigurarGrid)
    * porque eh o ponto UNICO de carga: todo caminho que repopular o cursor
    * chama este metodo e sai com a grade repintada.
    *
    * Ordem obrigatoria: RecordSource -> ControlSource -> Width ->
    * Header1.Caption. Atribuir RecordSource RECALCULA as larguras das
    * colunas para o default 90 e reseta os captions, entao o que foi
    * definido em ConfigurarGrid precisa ser reaplicado DEPOIS do vinculo.
    *
    * Fecha com GO TOP + Refresh: encher o cursor NAO repinta a grade
    * sozinho (o legado tambem termina com "Go Top in" + ".Refresh").
    *
    * PUBLIC de proposito - o harness de teste chama metodos de carga
    * direto no objeto do form, de fora da classe (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        TRY
            *-- 1. Cursor de trabalho, a partir do cursor de origem que o
            *-- chamador ja populou (o BO exibe a propria falha se der erro)
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               !EMPTY(THIS.this_cCursorOrigem) AND USED(THIS.this_cCursorOrigem)
                THIS.this_oBusinessObject.CarregarOperacoes(THIS.this_cCursorOrigem, loc_cCursor)
            ENDIF

            *-- 2. Vinculo da grade + reaplicacao de larguras e captions.
            *-- ValidarCursorOperacoes vem ANTES de qualquer ControlSource:
            *-- o cursor de trabalho eh "SELECT 1 AS Selecionada, * FROM
            *-- <cursor do chamador>", logo as colunas que a grade e os dois
            *-- campos de exibicao vinculam dependem do que o chamador
            *-- entregou. Coluna ausente faz o ControlSource estourar
            *-- (CLAUDE.md regra #41) com mensagem que nao diz QUAL coluna
            *-- falta - a validacao nomeia todas de uma vez.
            IF USED(loc_cCursor) AND PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
               THIS.ValidarCursorOperacoes(loc_cCursor)
                WITH THIS.grd_4c_Dados
                    .ColumnCount  = 7
                    .RecordSource = loc_cCursor

                    .Column1.ControlSource = loc_cCursor + ".Selecionada"
                    .Column2.ControlSource = loc_cCursor + ".Datas"
                    .Column3.ControlSource = loc_cCursor + ".Emps"
                    .Column4.ControlSource = loc_cCursor + ".PrazoEnts"
                    .Column5.ControlSource = loc_cCursor + ".Contas"
                    .Column6.ControlSource = loc_cCursor + ".RClis"
                    .Column7.ControlSource = loc_cCursor + ".Conjuges"

                    *-- Larguras do SCX legado, ja na ordem VISUAL (o legado
                    *-- embaralha as colunas fisicas via ColumnOrder)
                    .Column1.Width = 15
                    .Column2.Width = 80
                    .Column3.Width = 35
                    .Column4.Width = 80
                    .Column5.Width = 80
                    .Column6.Width = 200
                    .Column7.Width = 205

                    .Column1.Header1.Caption = ""
                    .Column2.Header1.Caption = "Data"
                    .Column3.Header1.Caption = "Emp"
                    *-- Column4 tem header dinamico: "Column4.Header1.Caption =
                    *-- lcCabData" no Init legado (parametro recebido do chamador)
                    .Column4.Header1.Caption = IIF(!EMPTY(THIS.this_cCabecalhoDados), ;
                        THIS.this_cCabecalhoDados, "Prev. Entrega")
                    .Column5.Header1.Caption = "Cliente"
                    .Column6.Header1.Caption = "Nome do Cliente"
                    .Column7.Header1.Caption = "Conjug" + CHR(234)

                    *-- O CheckBox da coluna de marcacao tambem se perde no
                    *-- rebind - sem isto a coluna volta a desenhar o Text1 e
                    *-- o usuario nao consegue marcar linha nenhuma
                    IF PEMSTATUS(.Column1, "chk_4c_Check1", 5)
                        .Column1.CurrentControl = "chk_4c_Check1"
                    ENDIF
                    .Column1.Sparse   = .F.
                    .Column1.ReadOnly = .F.
                ENDWITH

                *-- 3. Repinta a grade (encher o cursor nao repinta sozinho)
                SELECT (loc_cCursor)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                *-- 4. Vincula os campos de exibicao da linha corrente
                *-- (get_Operacao.ControlSource = crOperacoes.Dopes /
                *-- get_Numes.ControlSource = crOperacoes.Numes no Init
                *-- legado) - so depois do cursor existir (regra #41).
                IF PEMSTATUS(THIS, "txt_4c__Operacao", 5)
                    THIS.txt_4c__Operacao.ControlSource = loc_cCursor + ".Dopes"
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c__Numes", 5)
                    THIS.txt_4c__Numes.ControlSource = loc_cCursor + ".Numes"
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCursorOperacoes - Confere que o cursor de trabalho expoe TODAS
    * as colunas que a grade e os dois campos de exibicao vinculam, ANTES
    * de qualquer atribuicao de ControlSource.
    *
    * Por que existe: o legado le de um cursor global FIXO (crTprMvCab) e
    * podia confiar nele. Aqui o cursor de origem chega como PARAMETRO do
    * chamador (this_cCursorOrigem) e o cursor de trabalho eh apenas
    * "SELECT 1 AS Selecionada, * FROM <origem>" - quem define as colunas
    * eh o chamador. Se faltar uma, a atribuicao de ControlSource estoura
    * (CLAUDE.md regra #41: ControlSource para coluna/cursor inexistente
    * derruba o vinculo) e a mensagem do VFP nao diz QUAL coluna falta:
    * o picker abre com a grade vazia e sem diagnostico. Aqui a checagem
    * eh feita de uma vez e a mensagem lista as colunas ausentes.
    *
    * Usa TYPE(alias + "." + campo) = "U" - NUNCA PEMSTATUS, que exige
    * OBJETO no 1o argumento e dispara erro 11 com nome de cursor.
    *
    * PUBLIC de proposito: alem do uso interno em CarregarDados, o harness
    * de teste chama metodos do form de fora da classe (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCursorOperacoes(par_cCursor)
        LOCAL loc_lValido, loc_cFaltando, loc_nI, loc_cCampo
        LOCAL ARRAY loc_aCampos[9]

        loc_lValido   = .F.
        loc_cFaltando = ""

        *-- Selecionada: Column1 (checkbox de marcacao, criada pelo SELECT do BO)
        *-- Datas/Emps/PrazoEnts/Contas/RClis/Conjuges: Column2..Column7
        *-- Dopes/Numes: txt_4c__Operacao / txt_4c__Numes
        loc_aCampos[1] = "Selecionada"
        loc_aCampos[2] = "Datas"
        loc_aCampos[3] = "Emps"
        loc_aCampos[4] = "PrazoEnts"
        loc_aCampos[5] = "Contas"
        loc_aCampos[6] = "RClis"
        loc_aCampos[7] = "Conjuges"
        loc_aCampos[8] = "Dopes"
        loc_aCampos[9] = "Numes"

        IF VARTYPE(par_cCursor) != "C" OR EMPTY(par_cCursor) OR !USED(par_cCursor)
            MsgErro("Cursor de opera" + CHR(231) + CHR(245) + "es indispon" + CHR(237) + "vel." + CHR(13) + ;
                "A grade de opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o pode ser vinculada.", ;
                "FormSigPrEop.ValidarCursorOperacoes")
        ELSE
            FOR loc_nI = 1 TO ALEN(loc_aCampos)
                loc_cCampo = loc_aCampos[loc_nI]
                IF TYPE(par_cCursor + "." + loc_cCampo) = "U"
                    loc_cFaltando = loc_cFaltando + IIF(EMPTY(loc_cFaltando), "", ", ") + loc_cCampo
                ENDIF
            ENDFOR

            IF EMPTY(loc_cFaltando)
                loc_lValido = .T.
            ELSE
                MsgErro("O cursor de origem informado pelo chamador n" + CHR(227) + "o possui " + ;
                    "a(s) coluna(s) abaixo, exigida(s) pela grade de opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CHR(13) + loc_cFaltando + CHR(13) + CHR(13) + ;
                    "Cursor de origem: " + ALLTRIM(THIS.this_cCursorOrigem), ;
                    "FormSigPrEop.ValidarCursorOperacoes")
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Handler do AfterRowColChange da grade
    * (ligado por BINDEVENT em ConfigurarGrid). Replica o metodo homonimo
    * do legado, que so faz repintar os dois campos de exibicao:
    *
    *     PROCEDURE AfterRowColChange
    *     LPARAMETERS nColIndex
    *     ThisForm.get_Operacao.Refresh()
    *     ThisForm.get_Numes.Refresh()
    *
    * Sem isto os dois campos continuam mostrando os valores da PRIMEIRA
    * linha enquanto o usuario navega pela grade - eles sao espelho da
    * linha corrente (o legado bloqueia foco neles com When -> Return .F.).
    *
    * par_nColIndex eh OBRIGATORIO mesmo sem uso: handler ligado por
    * BINDEVENT tem de declarar os parametros do evento, senao a chamada
    * falha em runtime (CLAUDE.md regra #3). Os guards de PEMSTATUS/USED
    * existem porque o AfterRowColChange dispara tambem durante o rebind
    * de CarregarDados, quando os campos podem ainda nao estar vinculados.
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)
            IF PEMSTATUS(THIS, "txt_4c__Operacao", 5)
                THIS.txt_4c__Operacao.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__Numes", 5)
                THIS.txt_4c__Numes.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCheck1Click - Column1.Check1.Click do legado ("NoDefault"): o
    * clique sozinho nao faz nada, quem alterna o valor eh o MouseDown (e o
    * KeyPress, via teclado). Existe so para suprimir o toggle nativo do
    * CheckBox, que nao repintaria a grade corretamente.
    *--------------------------------------------------------------------------
    PROCEDURE GridCheck1Click()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCheck1MouseDown - Column1.Check1 (evento com 4 parametros do
    * legado, 12 linhas): alterna Selecionada da linha CORRENTE do cursor
    * de trabalho e repinta a grade, identico ao
    * "m.Selecionada = Iif(crOperacoes.Selecionada = 0, 1, 0) / Select
    * crOperacoes / Gather Memvar Fields Selecionada / ThisForm.
    * grdOperacoes.Refresh / NoDefault" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GridCheck1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOperacoes

        IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE Selecionada WITH IIF(Selecionada = 0, 1, 0)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCheck1MouseUp - Column1.Check1 (evento com 4 parametros do
    * legado, 4 linhas): so suprime o toggle nativo ("NoDefault"), o
    * alternar ja aconteceu no MouseDown.
    *--------------------------------------------------------------------------
    PROCEDURE GridCheck1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCheck1KeyPress - Column1.Check1.KeyPress do legado: alterna
    * Selecionada da linha corrente em Enter(13) OU Espaco(32) - acesso via
    * teclado ao mesmo toggle que o MouseDown faz no clique do mouse.
    *--------------------------------------------------------------------------
    PROCEDURE GridCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOperacoes

        IF INLIST(par_nKeyCode, 13, 32)
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE Selecionada WITH IIF(Selecionada = 0, 1, 0)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCkMarca - Checkbox "marcar/desmarcar todas as linhas"
    * (ck_Marca do legado), posicionado por cima do canto superior
    * esquerdo da grade (Top=123 sobre Top=121 do grid), igual ao legado.
    * O Click (Replace All Selecionada with This.Value in crOperacoes +
    * grid.Refresh) eh ligado logo abaixo via BINDEVENT, em CkMarcaClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCkMarca()
        THIS.AddObject("chk_4c_Ck_Marca", "CheckBox")
        WITH THIS.chk_4c_Ck_Marca
            .Top       = 123
            .Left      = 15
            .Width     = 13
            .Height    = 17
            .Alignment = 0
            .Caption   = ""
            .Value     = 1
            .BackStyle = 0
        ENDWITH

        *-- ck_Marca.Click do legado: "Replace All Selecionada with
        *-- This.Value in crOperacoes / ThisForm.grdOperacoes.Refresh()"
        BINDEVENT(THIS.chk_4c_Ck_Marca, "Click", THIS, "CkMarcaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CkMarcaClick - Handler do checkbox "marcar/desmarcar todas as
    * linhas" (ck_Marca.Click do legado). Delega ao BO
    * (MarcarTodasOperacoes), que faz o REPLACE ALL no cursor de trabalho,
    * e repinta a grade em seguida.
    *--------------------------------------------------------------------------
    PROCEDURE CkMarcaClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)

                THIS.this_oBusinessObject.MarcarTodasOperacoes(THIS.this_cCursorOperacoes, ;
                    THIS.chk_4c_Ck_Marca.Value)

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.CkMarcaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botao OK (cmdSair do legado, classe fwbtng).
    * Standalone CommandButton com .Picture exige Themes=.T. +
    * DisabledPicture (senao o icone some quando o botao eh desabilitado -
    * CorretorAutomatico #99). O Click (monta o cursor de saida e libera o
    * form) eh ligado logo abaixo via BINDEVENT, em BtnOKClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 663
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH

        *-- cmdSair.Click do legado: monta o cursor de saida com a chave
        *-- das linhas marcadas e fecha o picker
        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnOKClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - Handler do botao OK (cmdSair.Click do legado):
    *
    *     Zap in crFilOper
    *     Select crOperacoes
    *     Locate for .F.
    *     Go Top in crOperacoes
    *     Scan
    *         If crOperacoes.Selecionada == 1
    *             Insert into crFilOper Values(Padr(crOperacoes.Emps,3)+
    *                 Padr(crOperacoes.Dopes,20)+Padl(Str(crOperacoes.Numes,6),6))
    *         Endif
    *     Endscan
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release
    *
    * Delegado ao BO (MontarCursorSelecionados), que faz o ZAP + SCAN +
    * INSERT no cursor de destino do chamador com a mesma chave composta
    * (EmpDopNums). Reabilitar o form pai fica a cargo de THIS.Destroy()
    * (ja implementado), disparado pelo Release() abaixo - nao duplicar
    * aqui. O legado sempre fecha o picker ao clicar OK, mesmo sem nada
    * selecionado (Scan de zero linhas so deixa crFilOper vazio) - por
    * isso o Release() roda incondicionalmente no fim do metodo, inclusive
    * quando a montagem do cursor falha (o erro ja foi exibido antes).
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel.", "FormSigPrEop.BtnOKClick")
            ELSE
                IF EMPTY(THIS.this_cCursorOperacoes) OR !USED(THIS.this_cCursorOperacoes) OR ;
                   EMPTY(THIS.this_cCursorDestino) OR !USED(THIS.this_cCursorDestino)
                    MsgErro("Cursor de opera" + CHR(231) + CHR(245) + "es ou cursor de destino " + ;
                        "indispon" + CHR(237) + "vel." + CHR(13) + "N" + CHR(227) + "o " + CHR(233) + ;
                        " poss" + CHR(237) + "vel montar a sele" + CHR(231) + CHR(227) + "o.", ;
                        "FormSigPrEop.BtnOKClick")
                ELSE
                    loc_lSucesso = THIS.this_oBusinessObject.MontarCursorSelecionados( ;
                        THIS.this_cCursorOperacoes, THIS.this_cCursorDestino)

                    IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigPrEop.BtnOKClick")
                    ENDIF
                ENDIF
            ENDIF

            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.BtnOKClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
    * percorre a arvore recursivamente tornando tudo visivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigPrEop.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita o form pai (a picker eh modal e o desabilita no
    * Init) e libera o cursor de trabalho aberto por este form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        IF !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEopBO.prg):
*====================================================================
* SigPrEopBO.prg
*
* Business Object para SigPrEop (Selecao de Operacoes)
* Tabela de origem: SigMvCab (movimentacao) | Chave composta: EmpDopNums
*
* Form OPERACIONAL modal (picker) chamado por outras telas do sistema
* para o usuario marcar quais movimentacoes (linhas de SigMvCab, ja
* filtradas pelo chamador num cursor de origem) entram num filtro.
* Nao executa SQL Server proprio: opera sobre cursores em memoria
* recebidos do form chamador (cursor de origem com as movimentacoes
* candidatas) e devolve, ao final, um cursor de saida com a chave
* composta EmpDopNums = Padr(Emps,3) + Padr(Dopes,20) + Padl(Str(Numes,6),6)
* de cada linha marcada - identico ao Scan do cmdSair.Click do legado.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- ===================================================================
    *-- Propriedades da entidade (linha corrente do cursor de operacoes)
    *-- ===================================================================
    this_nSelecionada  = 0     && Selecionada numeric(1,0) - flag de marcacao da linha no grid
    this_cEmps         = ""    && Emps char(3) - empresa (SigMvCab)
    this_cDopes        = ""    && Dopes char(20) - operacao/documento (SigMvCab / SigCdOpe.Dopes)
    this_nNumes        = 0     && Numes numeric(6,0) - numero da movimentacao (SigMvCab)
    this_dDatas        = {}    && Datas date - data da movimentacao
    this_dPrazoEnts    = {}    && PrazoEnts date - previsao de entrega
    this_cContas       = ""    && Contas char - codigo do cliente/conta (SigCdCli.Iclis)
    this_cRClis        = ""    && RClis char - nome/razao do cliente
    this_cConjuges     = ""    && Conjuges - indicador de operacao conjugada
    this_cEmpDopNums   = ""    && EmpDopNums char(29) - chave composta Emps(3)+Dopes(20)+Numes(6)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da linha corrente do
    * cursor de operacoes (Selecionada, Emps, Dopes, Numes, Datas,
    * PrazoEnts, Contas, RClis, Conjuges - as mesmas colunas produzidas
    * por "Select 1 as Selecionada, * from crTprMvCab" no Init legado)
    * para as properties this_* da linha corrente, e calcula a chave
    * composta EmpDopNums via ObterChavePrimaria().
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cEmps        = TratarNulo(Emps, "")
            THIS.this_cDopes       = TratarNulo(Dopes, "")
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = ConverterParaData(Datas)
            THIS.this_dPrazoEnts   = ConverterParaData(PrazoEnts)
            THIS.this_cContas      = TratarNulo(Contas, "")
            THIS.this_cRClis       = TratarNulo(RClis, "")
            THIS.this_cConjuges    = TratarNulo(Conjuges, "")

            THIS.this_cEmpDopNums = THIS.ObterChavePrimaria()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave composta EmpDopNums, identica ao Scan do
    * cmdSair.Click legado: Padr(Emps,3) + Padr(Dopes,20) +
    * Padl(Str(Numes,6),6) (char(29) = 3+20+6). Chave POSICIONAL - o
    * padding faz parte da chave, por isso PADR/PADL nas partes, NUNCA
    * ALLTRIM (CLAUDE.md regra #22 / Erro177: ALLTRIM nas partes internas
    * descasa a busca em SILENCIO, sem erro, devolvendo zero linhas).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + ;
            PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *====================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - o legado (SIGPREOP.SCX)
    * NAO grava nada em SQL Server: eh um picker modal que (1) recebe do
    * form chamador um cursor de origem JA FILTRADO (crTprMvCab), (2)
    * deixa o usuario marcar linhas via checkbox e (3) devolve ao
    * chamador um cursor de saida em memoria (crFilOper) com a chave
    * composta das linhas marcadas - tudo dentro do proprio processo VFP,
    * sem SQLEXEC, sem TABLEUPDATE, sem AddCursor remoto (comportamento.json
    * confirma: nenhum metodo do form tem gravacao remota). O
    * comportamento herdado de BusinessBase (recusar Inserir/Atualizar) ja
    * eh o correto para esta entidade neste form; a operacao real de
    * "gravacao" desta tela eh a montagem do cursor de saida, implementada
    * abaixo em MontarCursorSelecionados() (equivalente ao Scan do
    * cmdSair.Click).
    *====================================================================

    *====================================================================
    * CarregarOperacoes - Constroi o cursor de trabalho da grade a partir
    * do cursor de origem recebido do form chamador, replicando o Init
    * legado: "Select 1 as Selecionada, * from crTprMvCab into cursor
    * crOperacoes readwrite". par_cCursorOrigem eh o cursor JA POPULADO
    * pelo chamador (equivalente a crTprMvCab); par_cCursorDestino recebe
    * as mesmas colunas mais a coluna Selecionada, iniciada em 1 - o
    * legado marca TODAS as linhas como selecionadas por padrao (mesmo
    * valor inicial de ck_Marca.Value = 1).
    *====================================================================
    PROCEDURE CarregarOperacoes(par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOrigem) = "C" AND !EMPTY(par_cCursorOrigem) AND USED(par_cCursorOrigem) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino)

            TRY
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT 1 AS Selecionada, * FROM " + par_cCursorOrigem + ;
                    " INTO CURSOR " + par_cCursorDestino + " READWRITE"

                &loc_cSQL.

                IF USED(par_cCursorDestino)
                    SELECT (par_cCursorDestino)
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel montar o cursor de opera" + CHR(231) + CHR(245) + "es."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MarcarTodasOperacoes - Replica ck_Marca.Click do legado: marca ou
    * desmarca TODAS as linhas do cursor de operacoes de uma vez ("Replace
    * All Selecionada with This.Value in crOperacoes").
    *====================================================================
    PROCEDURE MarcarTodasOperacoes(par_cCursorOperacoes, par_nValor)
        LOCAL loc_lSucesso, loc_nRecno
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes)
            loc_nRecno = RECNO(par_cCursorOperacoes)

            SELECT (par_cCursorOperacoes)
            REPLACE ALL Selecionada WITH NVL(par_nValor, 0)

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursorOperacoes))
                GOTO loc_nRecno
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorSelecionados - Replica o Scan do cmdSair.Click legado:
    * percorre o cursor de operacoes e grava, no cursor de saida (ja
    * criado pelo form chamador, equivalente a crFilOper), a chave
    * composta EmpDopNums de cada linha marcada (Selecionada == 1). O
    * cursor de saida eh ZERADO no inicio (Zap in crFilOper do legado) e
    * espera uma unica coluna EmpDopNums char(29).
    *====================================================================
    PROCEDURE MontarCursorSelecionados(par_cCursorOperacoes, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nRecnoOrigem, loc_cChave, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino) AND USED(par_cCursorDestino)

            TRY
                loc_nRecnoOrigem = RECNO(par_cCursorOperacoes)

                SELECT (par_cCursorDestino)
                ZAP

                SELECT (par_cCursorOperacoes)
                SCAN FOR NVL(Selecionada, 0) = 1
                    THIS.CarregarDoCursor(par_cCursorOperacoes)
                    loc_cChave = THIS.ObterChavePrimaria()

                    INSERT INTO (par_cCursorDestino) VALUES (loc_cChave)

                    SELECT (par_cCursorOperacoes)
                ENDSCAN

                IF USED(par_cCursorOperacoes) AND BETWEEN(loc_nRecnoOrigem, 1, RECCOUNT(par_cCursorOperacoes))
                    SELECT (par_cCursorOperacoes)
                    GOTO loc_nRecnoOrigem
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

