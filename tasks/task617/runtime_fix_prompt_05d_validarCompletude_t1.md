# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrGlpBO.prg] Indicador de pendencia: * gravados corretamente; so o recalculo derivado fica pendente
[FormSigPrGlp.prg] Indicador de pendencia: * A saida eh SET FILTER com "==" (comparacao exata, independente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg):
*==============================================================================
* FormSigPrGlp.prg - Previa da Globalizacao
*==============================================================================
* Herda de: FormBase
* BO: SigPrGlpBO
* Legado: SIGPRGLP.SCX
* Tipo: OPERACIONAL (filho - form PLANO sem PageFrame: todos os 128 objetos
*       do dump sao filhos diretos de SIGPRGLP, sem Pagina.Lista/Dados)
*
* Tela de PREVIA/CONFIRMACAO do processamento disparado por FormSigPrGlo
* (Processamento de O.P./Reserva Automatica), chamada por FormSigPrGl2
* (Operacoes Selecionadas) quando o job selecionado NAO tem fabricacao
* propria (this_lPossuiFabricacao = .F. - com fabricacao, quem abre eh a
* irma FormSigPrGlx). Recebe do chamador os cursores temporarios ja
* calculados na MESMA DataSession privada (TmpFinal/TmpDisp/TmpSaldo/
* TmpSaldG/TmpLinha/SelPedra/CrSigCdPac/CrSigCdPam) e, ao confirmar (botao
* Processar), efetiva a geracao das Ordens de Producao em SigOpPic
* (SigPrGlpBO.Inserir/Atualizar).
*
* CONTRATO DE CHAMADA (ja implementado do lado do chamador - NAO alterar a
* ordem/tipo dos parametros sem atualizar FormSigPrGl2.BtnProcessarClick):
*   CREATEOBJECT("FormSigPrGlp", par_oParentForm, par_nDataSessionId,
*       par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp)
*   equivalente ao legado "Do Form SigPrGlp With ThisForm,
*       ThisForm.Datasessionid, Reserva, poDataMgr, Emphpdr, automatico,
*       Numerodaop" - pCnx (poDataMgr) SAI da lista: a conexao migrada eh o
*       gnConnHandle global. par_nDataSessionId eh vestigial (equivale ao
*       "_Data" do LParameters legado, que o proprio Init original nunca
*       lia - a sessao privada eh assumida de par_oParentForm.DataSessionId,
*       igual ao "_ParentForm.DataSessionId" do legado e ao mesmo padrao
*       ja usado em FormSigPrGlx/FormSigPrGf2).
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
* InicializarForm, cabecalho cnt_4c_Sombra). Roteiro das proximas fases em
* ConfigurarPageFrame().
*==============================================================================

DEFINE CLASS FormSigPrGlp AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRGLP.SCX: Width=1000, Height=600,
    * DataSession=2, BorderStyle=2, ControlBox=.F., Closable=.F.,
    * MaxButton=.F., MinButton=.F., ClipControls=.F., TitleBar=0,
    * WindowState=0, FontName="Tahoma" - PILAR 1)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    WindowState  = 0
    FontName     = "Tahoma"

    *-- WindowType = 1 eh canonico do projeto (mesmo padrao de FormSigPrGlx/
    *-- FormSigPrGf1/FormSigPrGf2): FormSigPrGl2.BtnProcessarClick abre este
    *-- form com CREATEOBJECT + variavel LOCAL + .Show() - com modeless o
    *-- Show() retornaria na hora e a LOCAL sairia de escopo, destruindo o
    *-- form (pisca e some).
    WindowType   = 1

    *-- DataSession = 2 transcrito do SCX. So vale quando este form eh
    *-- aberto SEM form pai (ganha sessao privada propria nesse caso); com
    *-- form pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
    *-- DODEFAULT(), para enxergar TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
    *-- TmpLinha/SelPedra/CrSigCdPac/CrSigCdPam que o pai ja populou.
    DataSession  = 2

    Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"

    *-- Referencia do form pai (ParentForm do legado). Reabilitado no
    *-- Destroy (o pai se desabilita antes de abrir este form filho).
    this_oParentForm = .NULL.

    *-- Guarda de reentrancia dos lookups de SigCdPro (colunas Produto e
    *-- Produto substituto do grd_4c_Pedras). FormBuscaAuxiliar eh MODAL:
    *-- o Show() bloqueia, o foco sai da celula e volta, e o proprio
    *-- KeyPress/DblClick pode disparar de novo empilhando um segundo
    *-- picker. Setada na entrada e limpa DEPOIS do ENDTRY, para valer
    *-- tambem quando o CATCH dispara.
    this_lLookupAberto = .F.

    *-- ThisForm.AntValue do legado (When da Column5.Text1 do GradePedra:
    *-- "ThisForm.AntValue = This.Value"), usado pelo LostFocus da mesma
    *-- coluna para decidir a insercao da linha em branco em SelPedra.
    this_cAntValue = ""

    *-- ThisForm.OldValue do legado (When da Column6.Text1 do GradeItens -
    *-- coluna Produzir), guardado no GotFocus e comparado no Valid para
    *-- decidir se o valor mudou e se precisa confirmar com o usuario a
    *-- perda da selecao manual de estoque (TmpSaldU.KeySelm).
    this_nProduzirValorAnterior = 0

    *--------------------------------------------------------------------------
    * Init - Recebe a referencia do form pai e os parametros de modo
    * (equivalente a "LParameters _ParentForm, _Data, _ReservaAuto, pCnx,
    * _nGerEmphPdr, _autom, _numeroOp" do legado - ver contrato de chamada
    * no cabecalho do arquivo). Assume a DataSessionId do pai e repassa os
    * parametros de modo ao BusinessObject ANTES do DODEFAULT(), para que
    * InicializarForm() ja os encontre prontos.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSessionId, par_lReservaAuto, ;
                   par_nGerEmphPdr, par_lAutom, par_nNumeroOp)

        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.DataSessionId    = par_oParentForm.DataSessionId
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
                THIS.this_oBusinessObject.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
                THIS.this_oBusinessObject.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
                THIS.this_oBusinessObject.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)

                DODEFAULT()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Pr" + CHR(233) + "via da Globaliza" + ;
                CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - os cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
    * TmpLinha/SelPedra/TmpSaldU) vivem na DataSession PRIVADA compartilhada
    * com o pai - nao ha o que fechar aqui (o pai, dono da sessao, fecha os
    * dele quando for a vez dele). So reabilita o form pai (desabilitado por
    * FormSigPrGl2.BtnProcessarClick antes de abrir este form filho) e
    * encadeia para FormBase.Destroy() (libera this_oBusinessObject e
    * restaura o menu principal). DODEFAULT() SEMPRE por ultimo.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.this_oParentForm = .NULL.
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar FormSigPrGlp: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Business Object ja foi criado e configurado em
    * Init(); aqui so falta resolver o Caption dinamico (Globalizacao x
    * Reserva Automatica), o SigKey (cursor global CrSigCdPac, que o form
    * pai ja populou na sessao compartilhada) e montar a moldura visual
    * (fundo + cabecalho). Os containers flutuantes, grids, botoes de acao
    * e eventos entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlpBO.", "Erro")
            ELSE
                *-- Caption dinamico (equivalente ao "If ThisForm.Reserva ...
                *-- Else ... EndIf" do Init legado)
                loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                IF THIS.this_oBusinessObject.this_lReserva
                    loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ENDIF
                THIS.Caption = loc_cCaption

                *-- SigKey (Thisform.SigKey = CrSigCdPac.sigKeys do Init
                *-- legado) - CrSigCdPac eh cursor global que o form pai ja
                *-- populou, visivel aqui porque a DataSessionId eh
                *-- compartilhada (ver Init acima)
                IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
                    THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
                ENDIF

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Carga inicial da grade principal - o bind + "Go Top" +
                *-- ".Refresh" com que o Init legado termina. Passa pelo funil
                *-- CarregarLista porque ConfigurarGradeItens so consegue ligar
                *-- o RecordSource se TmpFinal JA existia quando o grid foi
                *-- criado; recebido depois (ou recriado pelo form pai), o
                *-- grid ficaria permanentemente em branco.
                *-- Pulada em validacao de UI, que instancia o form sem
                *-- conexao e sem os cursores do chamador.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGlp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGLP nao
    * tem PageFrame no legado (layout flat) - o nome do metodo eh mantido
    * apenas como ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGlo/FormSigPrGf1).
    *
    * Roteiro das proximas fases:
    *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
    *   Fase 4 (esta)  - shp_4c_Shape2/shp_4c_Shape3 decorativos, os 7
    *                     botoes de acao standalone (Disponivel/TotLinha/
    *                     Pedras/SelEstoque/Cancelar/Processar/
    *                     btnRelatorio) e o grid principal grd_4c_Itens
    *                     (GradeItens, 9 colunas, RecordSource='TmpFinal')
    *   Fase 5 (esta)  - 3 dos 5 containers flutuantes (estrutura visual
    *                     apenas - RecordSource/ControlSource dos grids fica
    *                     para a Fase 7-8, igual ao legado, que so liga isso
    *                     dentro do Click de cada botao): cnt_4c_Container1
    *                     (Pecas a Produzir por Linha - botao TotLinha),
    *                     cnt_4c_Container2 (Estoque Disponivel por
    *                     Produto/Cor/Tam - botao Disponivel) e
    *                     cnt_4c_Container5 (Estoque Disponivel por
    *                     Grupo/Conta - botao SelEstoque)
    *   Fase 6 (esta)  - cnt_4c_Container4 (Requisicao de Componentes
    *                     Adicionais - botao Pedras; grid ligado a SelPedra
    *                     em runtime pelo Pedras.Click, mesmo padrao dos
    *                     containers da Fase 5), cnt_4c_Container3
    *                     (Estoque Disponivel por Conta, rodape SEMPRE
    *                     visivel - nao entra no filtro de
    *                     TornarControlesVisiveis), os campos totais da
    *                     grade principal (txt_4c_TotQtd/TotEst/TotPrz),
    *                     img_4c_ImgFigJpg (foto do item selecionado),
    *                     lbl_4c_TxtObsItens/obj_4c_ObsItens e os LOOKUPS
    *                     de SigCdPro das colunas Produto/Produto
    *                     substituto do grd_4c_Pedras (Valid legado ->
    *                     ValidarPedraProduto/ValidarPedraSubstituto +
    *                     AbrirLookupPedraProduto/AbrirLookupPedraSubstituto
    *                     via FormBuscaAuxiliar), o gate do When das
    *                     Column4/Column5 (AjustarColunasPedra, ligado ao
    *                     AfterRowColChange) e o LostFocus da Column5
    *                     (linha em branco no SelPedra)
    *   Fase 7 (esta)  - PrepararCursoresDeTrabalho() (o resto do Init
    *                     legado: linha em branco do SelPedra, cursores
    *                     TmpSaldU/crSigCdCom, bind do grid do Container3 e
    *                     totais do rodape) e ConfigurarEventos()
    *                     (BINDEVENT dos 6 botoes de acao + dos 4 botoes de
    *                     OK/Sair dos containers flutuantes), com os
    *                     handlers correspondentes: BtnDisponivelClick,
    *                     BtnSelEstoqueClick, BtnTotLinhaClick,
    *                     BtnPedrasClick, BtnRelatorioClick,
    *                     BtnCancelarClick, BtnConfirmarDispProdutoClick,
    *                     BtnConfirmarDispGrupoClick, BtnFecharPedrasClick
    *                     e BtnFecharLinhasClick
    *   Fase 8 (esta)  - BtnProcessarClick + o AfterRowColChange de
    *                     grd_4c_Itens (alimenta Container3/totais/imagem/
    *                     observacao), o When/Valid/LostFocus da coluna
    *                     Produzir e da coluna Utilizar dos dois paineis de
    *                     estoque, SigPrGlpBO.Processar/AtualizaPeso/
    *                     GravaHis e os funis de consolidacao no fim do
    *                     arquivo (CarregarLista/LigarGradeItens/
    *                     FormParaBO/BOParaForm/HabilitarCampos/
    *                     AjustarBotoesPorModo/LimparCampos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFormasDecorativas()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarGradeItens()
        THIS.ConfigurarContainer1()
        THIS.ConfigurarContainer2()
        THIS.ConfigurarContainer5()
        THIS.ConfigurarContainer4()
        THIS.ConfigurarContainer3()
        THIS.ConfigurarCamposTotais()

        *-- Fase 7: os cursores de trabalho que o Init legado prepara DEPOIS
        *-- de montar a tela, e o BINDEVENT dos botoes de acao. Os dois vem
        *-- por ULTIMO porque dependem de todos os controles ja criados.
        THIS.PrepararCursoresDeTrabalho()
        THIS.ConfigurarEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=1004, Height=80,
    * BackColor=RGB(100,100,100) (layout.json/dump) - Width usa THIS.Width
    * (canonico do projeto) em vez do literal 1004 do SCX, que ja excedia
    * em 4px o proprio Width do form (1000).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
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
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFormasDecorativas - Os dois Shape do dump (Shape2/Shape3) sao
    * meramente decorativos: BackStyle=0 (sem preenchimento) e BorderStyle=0
    * (sem borda desenhada) - BorderColor fica sem efeito visivel com
    * BorderStyle=0, mas eh transcrito do SCX mesmo assim (regra de
    * transcricao literal - nao inventar, nao omitir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFormasDecorativas()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 9
                .Left        = 9
                .Width       = 279
                .Height      = 51
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top         = 10
                .Left        = 820
                .Width       = 116
                .Height      = 38
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFormasDecorativas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Os 7 botoes de acao ficam soltos, filhos diretos
    * do form (o SCX nao os agrupa em CommandGroup/Container), desenhados
    * POR CIMA de cnt_4c_Sombra (Top=3..78 cabe dentro da faixa Top=0..80) -
    * por isso este metodo roda DEPOIS de ConfigurarCabecalho() em
    * ConfigurarPageFrame(). Propriedades comuns (FontBold/FontItalic/
    * FontName "Comic Sans MS"/FontSize/ForeColor RGB(90,90,90)/BackColor
    * branco/Themes=.F.) sao as mesmas do padrao canonico de botoes CRUD
    * (docs/framework_frmcadastro_layout.md), confirmadas 1-a-1 no dump.
    * Icones e Captions (com o "\<" de atalho Alt) transcritos literalmente
    * do SCX - nunca inventados (regra de icone: CLAUDE.md #25). BINDEVENT
    * dos Click entra na Fase 7-8 (roteiro do cabecalho de
    * ConfigurarPageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
            WITH THIS.cmd_4c_Disponivel
                .Top        = 3
                .Left       = 622
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
                .Caption    = "\<Disponiveis"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Pedras", "CommandButton")
            WITH THIS.cmd_4c_Pedras
                .Top             = 3
                .Left            = 472
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                *-- Themes=.T. + DisabledPicture (diverge do Themes=.F. do
                *-- SCX de proposito): este botao PODE nascer .Enabled=.F.
                *-- (ver abaixo) e botao standalone com Picture+Enabled=.F.
                *-- +Themes=.F. perde o icone em VFP9 (CorretorAutomatico #99)
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Visible         = .T.
                *-- Habilitado so quando o SigCdPam tem as 4 colunas de
                *-- transferencia preenchidas e NAO eh Reserva Automatica
                *-- (equivalente ao "If Not Empty(crSigCdPam.DopEmphs) ...
                *-- And Not ThisForm.Reserva" do Init legado)
                .Enabled         = !EMPTY(THIS.this_oBusinessObject.this_cPamDopEmphs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopReqcs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopPedcs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopComps)   AND ;
                                    !THIS.this_oBusinessObject.this_lReserva
            ENDWITH

            THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
            WITH THIS.cmd_4c_SelEstoque
                .Top             = 3
                .Left            = 547
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
                .Caption         = "\<Estoques"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
            WITH THIS.cmd_4c_TotLinha
                .Top        = 3
                .Left       = 697
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                .Caption    = "\<Total/Linhas"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
            WITH THIS.cmd_4c_BtnRelatorio
                .Top        = 3
                .Left       = 772
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption    = "\<Relat" + CHR(243) + "rio"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top        = 3
                .Left       = 847
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top        = 3
                .Left       = 922
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Sair"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeItens - Grid principal (GradeItens no legado), 9
    * colunas ligadas ao cursor TmpFinal (ja populado pelo form pai, na
    * DataSession privada compartilhada). O RecordSource eh atribuido aqui
    * SOB GUARDA de IF USED("TmpFinal") - o cursor so existe quando o form
    * eh aberto pelo fluxo real (FormSigPrGl2.BtnProcessarClick), e em modo
    * de teste de UI (gb_4c_ValidandoUI) nao existe. Quando ele chega
    * DEPOIS, quem liga a grade eh CarregarLista() (chamado no fim do
    * InicializarForm), que refaz o bind por LigarGradeItens() repondo
    * ControlSource/Width/Header na ordem canonica.
    *
    * IMPORTANTE - Correspondencia ControlSource x Header (conferida com o
    * dump linha a linha, incluindo cruzamento com os handlers de
    * GotFocus/Valid do legado, que confirmam qual coluna eh a UNICA
    * editavel): a ordem de DECLARACAO das colunas (Column1..Column9, a
    * mesma usada no ".ColumnN.ControlSource=" do Init legado) NAO anda em
    * paralelo com a ordem em que os Header1/Text1 aparecem no dump do SCX
    * - os Header1/Text1 sao indexados pelo .Name HISTORICO de cada coluna
    * (ex.: a coluna fisica 2, ligada a CodCors, tem .Name="Column5" e por
    * isso seu Header1.Caption fica na secao "Column5" do dump = "Quantidade").
    * Coluna 3 (fisica), ligada a Dopes, tem .Name="Column6", Header
    * "Produzir" e eh a UNICA com ReadOnly=.F. (BackColor 221,252,255) - os
    * handlers GotFocus de TODAS as outras colunas (comportamento.json)
    * fazem SetFocus justamente para "GradeItens.Column6.Text1", confirmando
    * que esta (fisica 3/Dopes/"Produzir") eh a coluna editavel do grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeItens()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Itens", "Grid")
            WITH THIS.grd_4c_Itens
                .Top               = 125
                .Left              = 11
                .Width             = 708
                .Height            = 224
                .FontName          = "Verdana"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 9

                IF USED("TmpFinal")
                    .RecordSource = "TmpFinal"
                ENDIF

                *-- Coluna 1 - Produto (Cpros)
                .Column1.ControlSource = "TmpFinal.Cpros"
                .Column1.Width         = 115
                .Column1.Movable       = .F.
                .Column1.Resizable     = .F.
                .Column1.ReadOnly      = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Cor (CodCors)
                .Column2.ControlSource = "TmpFinal.CodCors"
                .Column2.FontBold      = .T.
                .Column2.ColumnOrder   = 6
                .Column2.Width         = 80
                .Column2.Movable       = .F.
                .Column2.Resizable     = .F.
                .Column2.ReadOnly      = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Cor"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Movimentacao (Dopes) - SEMPRE ReadOnly (o dump
                *-- legado declara Column3.Text1.ReadOnly=.T., BackColor
                *-- 255,255,255, sem FontBold - a UNICA editavel do grid eh a
                *-- Column6/Produzir, corrigido abaixo)
                .Column3.ControlSource = "TmpFinal.Dopes"
                .Column3.ColumnOrder   = 8
                .Column3.Width         = 80
                .Column3.Movable       = .F.
                .Column3.Resizable     = .F.
                .Column3.ReadOnly      = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Codigo (Numes)
                .Column4.ControlSource = "TmpFinal.Numes"
                .Column4.FontBold      = .T.
                .Column4.Alignment     = 2
                .Column4.ColumnOrder   = 9
                .Column4.Width         = 38
                .Column4.Movable       = .F.
                .Column4.Resizable     = .F.
                .Column4.ReadOnly      = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "C" + CHR(243) + "digo"
                .Column4.Text1.FontBold    = .T.
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.Alignment   = 2
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Quantidade (Saldo)
                .Column5.ControlSource = "TmpFinal.Saldo"
                .Column5.FontBold      = .T.
                .Column5.ColumnOrder   = 7
                .Column5.Width         = 80
                .Column5.Movable       = .F.
                .Column5.Resizable     = .F.
                .Column5.ReadOnly      = .T.
                .Column5.BackColor     = RGB(255, 253, 179)
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Quantidade"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 253, 179)

                *-- Coluna 6 - Produzir - UNICA editavel do grid (dump legado:
                *-- Column6.Text1.ReadOnly=.F., FontBold=.T., BackColor
                *-- 221,252,255 - trocado com a Column3 por engano na Fase 4)
                .Column6.ControlSource = "TmpFinal.Produzir"
                .Column6.FontBold      = .T.
                .Column6.FontSize      = 8
                .Column6.ColumnOrder   = 4
                .Column6.Width         = 150
                .Column6.Movable       = .F.
                .Column6.Resizable     = .F.
                .Column6.ReadOnly      = .F.
                .Column6.BackColor     = RGB(221, 252, 255)
                .Column6.Header1.FontName  = "Verdana"
                .Column6.Header1.FontSize  = 8
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(36, 84, 155)
                .Column6.Header1.Caption   = "Produzir"
                .Column6.Text1.FontBold    = .T.
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .F.
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(221, 252, 255)

                *-- Coluna 7 - Estoque
                .Column7.ControlSource = "TmpFinal.Estoque"
                .Column7.FontSize      = 8
                .Column7.ColumnOrder   = 5
                .Column7.Width         = 50
                .Column7.Movable       = .F.
                .Column7.Resizable     = .F.
                .Column7.ReadOnly      = .T.
                .Column7.Header1.FontName  = "Verdana"
                .Column7.Header1.FontSize  = 8
                .Column7.Header1.Alignment = 2
                .Column7.Header1.ForeColor = RGB(36, 84, 155)
                .Column7.Header1.Caption   = "Estoque"
                .Column7.Text1.FontSize    = 8
                .Column7.Text1.BorderStyle = 0
                .Column7.Text1.Margin      = 0
                .Column7.Text1.ReadOnly    = .T.
                .Column7.Text1.ForeColor   = RGB(0, 0, 0)
                .Column7.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 8 - Obs (marcador "*" quando ha observacao)
                .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
                .Column8.FontSize      = 8
                .Column8.ColumnOrder   = 2
                .Column8.Width         = 38
                .Column8.Movable       = .F.
                .Column8.Resizable     = .F.
                .Column8.ReadOnly      = .T.
                .Column8.Header1.FontName  = "Verdana"
                .Column8.Header1.FontSize  = 8
                .Column8.Header1.Alignment = 2
                .Column8.Header1.ForeColor = RGB(36, 84, 155)
                .Column8.Header1.Caption   = "Obs"
                .Column8.Text1.FontSize    = 8
                .Column8.Text1.BorderStyle = 0
                .Column8.Text1.Margin      = 0
                .Column8.Text1.ReadOnly    = .T.
                .Column8.Text1.ForeColor   = RGB(0, 0, 0)
                .Column8.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 9 - Tam (CodTams)
                .Column9.ControlSource = "TmpFinal.CodTams"
                .Column9.FontSize      = 8
                .Column9.ColumnOrder   = 3
                .Column9.Width         = 38
                .Column9.Movable       = .F.
                .Column9.Resizable     = .F.
                .Column9.ReadOnly      = .T.
                .Column9.Header1.FontName  = "Verdana"
                .Column9.Header1.FontSize  = 8
                .Column9.Header1.Alignment = 2
                .Column9.Header1.ForeColor = RGB(36, 84, 155)
                .Column9.Header1.Caption   = "Tam"
                .Column9.Text1.FontSize    = 8
                .Column9.Text1.BorderStyle = 0
                .Column9.Text1.Margin      = 0
                .Column9.Text1.ReadOnly    = .T.
                .Column9.Text1.ForeColor   = RGB(0, 0, 0)
                .Column9.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer1 - "Pecas a produzir por linha" (Container1 no
    * legado), alternado pelo botao cmd_4c_TotLinha (Fase 7-8). Grid
    * grd_4c_Linhas 100% somente-leitura (o proprio Grid tem .ReadOnly=.T.
    * no dump, alem de cada Column) - Column1..4.ControlSource ficam vazios
    * de proposito (assim declarado no SCX): TotLinha.Click monta o cursor
    * TmpLinha e liga RecordSource/ControlSource em runtime (Fase 7-8),
    * igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer1()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container1", "Container")
            loc_oCnt = THIS.cnt_4c_Container1
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
                .Height    = 18
                .Left      = 259
                .Top       = 10
                .Width     = 170
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaLin", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaLin
                .Top         = 10
                .Left        = 620
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel      = .T.
                .Caption     = "OK"
                .ToolTipText = "[ESC] - Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_Linhas", "Grid")
            WITH loc_oCnt.grd_4c_Linhas
                .Top               = 32
                .Left              = 174
                .Width             = 359
                .Height            = 420
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .Visible           = .T.

                .ColumnCount = 4

                *-- Coluna 1 - Linha (futuro TmpLinha.Linhas)
                .Column1.ControlSource     = ""
                .Column1.Width             = 84
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Sparse            = .F.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Linha"
                .Column1.Text1.FontName    = "Arial"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Quantidade (futuro TmpLinha.Saldo)
                .Column2.ControlSource     = ""
                .Column2.Width             = 80
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Sparse            = .F.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Quantidade"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.InputMask   = "999,999.99"
                .Column2.Text1.Margin      = 0
                .Column2.Text1.MaxLength   = 10
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Estoque (futuro TmpLinha.Estoque)
                .Column3.ControlSource     = ""
                .Column3.Width             = 80
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Sparse            = .F.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Estoque"
                .Column3.Text1.FontName    = "Arial"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.InputMask   = "999,999.99"
                .Column3.Text1.Margin      = 0
                .Column3.Text1.MaxLength   = 10
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Produzir (futuro TmpLinha.Produzir)
                .Column4.ControlSource     = ""
                .Column4.Width             = 80
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Sparse            = .F.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Produzir"
                .Column4.Text1.FontName    = "Arial"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.InputMask   = "999,999.99"
                .Column4.Text1.Margin      = 0
                .Column4.Text1.MaxLength   = 10
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer2 - "Estoque Disponivel" por PRODUTO/COR/TAM,
    * alternado pelo botao cmd_4c_Disponivel (Fase 7-8). RecordSource/
    * ControlSource ficam de fora aqui (o SCX nao declara ControlSource
    * estatico para estas colunas - o Click do legado monta TmpDisp e liga
    * tudo em runtime, mesmo padrao do Container5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer2()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container2", "Container")
            loc_oCnt = THIS.cnt_4c_Container2
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 284
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top       = 10
                .Left      = 620
                .Height    = 75
                .Width     = 75
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel    = .T.
                .Caption   = "Sair"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispProduto", "Grid")
            WITH loc_oCnt.grd_4c_DispProduto
                .Top               = 32
                .Left              = 169
                .Width             = 370
                .Height            = 388
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .Panel             = 1
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Produto (futuro TmpDisp.Cpros)
                .Column1.Width             = 108
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Cor (futuro TmpDisp.CodCors)
                .Column2.FontBold          = .T.
                .Column2.ColumnOrder       = 2
                .Column2.Width             = 38
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Cor"
                .Column2.Text1.FontBold    = .T.
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Tam (futuro TmpDisp.CodTams)
                .Column3.FontBold          = .T.
                .Column3.ColumnOrder       = 3
                .Column3.Width             = 38
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Tam"
                .Column3.Text1.FontBold    = .T.
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Disponivel (futuro TmpDisp.Disps)
                .Column4.ColumnOrder       = 4
                .Column4.Width             = 75
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Disponivel"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Utilizar (futuro TmpDisp.Utilizar) - UNICA editavel
                .Column5.FontBold          = .T.
                .Column5.ColumnOrder       = 5
                .Column5.Width             = 75
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Utilizar"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Qtde " + CHR(224) + " Produzir :"
                .Height    = 15
                .Left      = 168
                .Top       = 432
                .Width     = 84
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Qtde " + CHR(224) + " Utilizar :"
                .Height    = 17
                .Left      = 365
                .Top       = 431
                .Width     = 109
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
            WITH loc_oCnt.txt_4c_QtSelec
                .Height        = 23
                .Width         = 80
                .Left          = 458
                .Top           = 428
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
            WITH loc_oCnt.txt_4c_QtPedida
                .Height        = 23
                .Width         = 80
                .Left          = 268
                .Top           = 428
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer5 - "Estoque Disponivel" por GRUPO/CONTA, alternado
    * pelo botao cmd_4c_SelEstoque ("Estoques" - Fase 7-8). O ColumnOrder do
    * grid NAO acompanha a ordem de declaracao das colunas (Column3/
    * Prioridade eh a PRIMEIRA visualmente - ColumnOrder=1) - transcrito
    * literal do dump, nao "corrigido".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer5()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container5", "Container")
            loc_oCnt = THIS.cnt_4c_Container5
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 284
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top         = 10
                .Left        = 620
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel      = .T.
                .Caption     = "OK"
                .ToolTipText = "[ESC] - Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
            WITH loc_oCnt.grd_4c_DispGrupo
                .Top               = 32
                .Left              = 141
                .Width             = 425
                .Height            = 372
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Grupo (futuro TmpDisp.Grupos) - ColumnOrder 2
                .Column1.ColumnOrder       = 2
                .Column1.Width             = 80
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Grupo"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Conta (futuro TmpDisp.Estos) - ColumnOrder 3
                .Column2.ColumnOrder       = 3
                .Column2.Width             = 80
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Conta"
                .Column2.Text1.FontBold    = .F.
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Prioridade (futuro TmpDisp.Priors) - ColumnOrder 1 (1a visual)
                .Column3.ColumnOrder       = 1
                .Column3.Width             = 80
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Prioridade"
                .Column3.Text1.FontBold    = .F.
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Disponivel (futuro TmpDisp.Disps) - ColumnOrder 4
                .Column4.ColumnOrder       = 4
                .Column4.Width             = 75
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Dispon" + CHR(237) + "vel"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Utilizar (futuro TmpDisp.Utilizar) - ColumnOrder 5, UNICA editavel
                .Column5.FontBold          = .T.
                .Column5.ColumnOrder       = 5
                .Column5.Width             = 75
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Utilizar"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.Alignment   = 3
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Value       = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Produzir :"
                .Height    = 15
                .Left      = 428
                .Top       = 413
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Utilizar :"
                .Height    = 15
                .Left      = 435
                .Top       = 438
                .Width     = 41
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oCnt.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo :"
                .Height    = 15
                .Left      = 93
                .Top       = 413
                .Width     = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oCnt.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta :"
                .Height    = 15
                .Left      = 93
                .Top       = 438
                .Width     = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
            WITH loc_oCnt.txt_4c_GetDGrupo
                .Height        = 23
                .Width         = 277
                .Left          = 141
                .Top           = 409
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
            WITH loc_oCnt.txt_4c_GetDConta
                .Height        = 23
                .Width         = 277
                .Left          = 141
                .Top           = 434
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
            WITH loc_oCnt.txt_4c_QtPedida
                .Height        = 23
                .Width         = 80
                .Left          = 486
                .Top           = 409
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
            WITH loc_oCnt.txt_4c_QtSelec
                .Height        = 23
                .Width         = 80
                .Left          = 486
                .Top           = 434
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer5")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer4 - "Requisicao de componentes adicionais"
    * (Container4 no legado), alternado pelo botao cmd_4c_Pedras (Fase 7-8).
    * Grid grd_4c_Pedras liga em runtime ao cursor SelPedra montado pelo
    * Click (mesmo padrao de RecordSource/ControlSource vazio ja usado nos
    * Containers 1/2/5) - Pedras.Click faz .RecordSource='SelPedra' e liga
    * Column1..5 a Cpros/Dpros/Cunis/Qtds/Cpro2s.
    *
    * ReadOnly por coluna transcrito do When de cada Text1 no legado:
    * Coluna1 (Produto) eh a UNICA de entrada livre - o Valid dela dispara
    * o lookup fwBuscaExt em SigCdPro (Fase 7-8) e preenche Descricao/Uni
    * (Colunas 2/3, sempre ReadOnly, "Return .f." no When). Colunas 4
    * (Qtde) e 5 (Produto substituto, com o proprio lookup fwBuscaExt) so
    * habilitam quando a Coluna1 estiver preenchida (When = "Return (Not
    * Empty(...Column1.Text1.Value))"); a Coluna5 tambem tem um LostFocus
    * que insere linha em branco no SelPedra (Fase 7-8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer4()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container4", "Container")
            loc_oCnt = THIS.cnt_4c_Container4
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
                .Height    = 18
                .Left      = 229
                .Top       = 8
                .Width     = 249
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top       = 10
                .Left      = 620
                .Height    = 75
                .Width     = 75
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel    = .T.
                .Caption   = "Sair"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_Pedras", "Grid")
            WITH loc_oCnt.grd_4c_Pedras
                .Top               = 32
                .Left              = 9
                .Width             = 605
                .Height            = 420
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Produto (futuro SelPedra.Cpros) - entrada
                *-- livre com lookup em SigCdPro (ValidarPedraProduto /
                *-- AbrirLookupPedraProduto, ligados por BINDEVENT abaixo)
                .Column1.ControlSource     = ""
                .Column1.Width             = 110
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .F.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .F.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Descricao (futuro SelPedra.Dpros) - sempre
                *-- ReadOnly, preenchida pelo lookup da Coluna1
                .Column2.ControlSource     = ""
                .Column2.Width             = 215
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Uni (futuro SelPedra.Cunis) - sempre ReadOnly,
                *-- preenchida pelo lookup da Coluna1
                .Column3.ControlSource     = ""
                .Column3.Width             = 50
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Uni"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Qtde (futuro SelPedra.Qtds) - habilita so
                *-- quando a Coluna1 estiver preenchida (gate do When
                *-- legado, reproduzido em PedrasAfterRowColChange)
                .Column4.ControlSource     = ""
                .Column4.Width             = 100
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .F.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Qtde"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.InputMask   = "999,999.99"
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .F.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Produto substituto (futuro SelPedra.Cpro2s) -
                *-- lookup proprio em SigCdPro (ValidarPedraSubstituto /
                *-- AbrirLookupPedraSubstituto), habilita so com a Coluna1
                *-- preenchida; LostFocus do legado insere linha em branco
                *-- no SelPedra (PedraSubstitutoLostFocus)
                .Column5.ControlSource     = ""
                .Column5.Width             = 125
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Produto"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- LOOKUPS fwBuscaExt em SigCdPro (legado: Valid das
            *-- Column1.Text1 e Column5.Text1 do GradePedra). BINDEVENT em
            *-- "Valid" NAO dispara de forma confiavel em TextBox: o gatilho
            *-- equivalente eh KeyPress com ENTER(13)/TAB(9)/F4(115), mais o
            *-- DblClick (CLAUDE.md regra BINDEVENT/KeyPress). Todos os
            *-- handlers sao PUBLIC - BINDEVENT falha em silencio com
            *-- PROTECTED (CLAUDE.md regra #3).
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "KeyPress", ;
                      THIS, "PedraProdutoKeyPress")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "DblClick", ;
                      THIS, "PedraProdutoDblClick")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "KeyPress", ;
                      THIS, "PedraSubstitutoKeyPress")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "DblClick", ;
                      THIS, "PedraSubstitutoDblClick")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "LostFocus", ;
                      THIS, "PedraSubstitutoLostFocus")

            *-- Gate das colunas Qtde/Produto-substituto: o legado usa
            *-- "When -> Return (Not Empty(Column1.Text1.Value))" nas
            *-- Column4/Column5. BINDEVENT descarta o retorno do delegate,
            *-- entao o When nao bloqueia edicao por essa via - o
            *-- equivalente fiel eh reavaliar o gate a cada troca de
            *-- linha/coluna (AfterRowColChange) e ligar/desligar as duas
            *-- colunas.
            BINDEVENT(loc_oCnt.grd_4c_Pedras, "AfterRowColChange", ;
                      THIS, "PedrasAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer4")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer3 - "Estoque Disponivel" por CONTA (Container3 no
    * legado), rodape SEMPRE VISIVEL (o dump nao declara Visible=.F. para
    * ele, ao contrario de Container1/2/4/5) - fica abaixo de grd_4c_Itens
    * (Top=125+224=349) e mostra o detalhe de estoque por Grupo/Conta do
    * ITEM SELECIONADO na grade principal. Distinto de cnt_4c_Container5
    * (mesmo titulo "Estoque Disponivel", mas alternado pelo botao Estoques
    * e mostrando outro produto/cor/tam escolhido pelo usuario).
    *
    * GradeDisp e os campos txt_4c_GetDGrupo/GetDConta/TotQtd/TotEst/TotPrz
    * ficam sem ControlSource/Value dinamico aqui - GradeItens.
    * AfterRowColChange (Fase 7-8) religa TmpSaldG com "Set Key To" filtrado
    * pelo Cpros+CodCors+CodTams do item corrente e atualiza estes campos,
    * igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer3()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container3", "Container")
            loc_oCnt = THIS.cnt_4c_Container3
            WITH loc_oCnt
                .Top           = 373
                .Left          = 12
                .Width         = 708
                .Height        = 205
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 16
                .Left      = 6
                .Top       = 5
                .Width     = 118
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispConta", "Grid")
            WITH loc_oCnt.grd_4c_DispConta
                .Top               = 24
                .Left              = 6
                .Width             = 444
                .Height            = 148
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .Visible           = .T.

                .ColumnCount = 6

                *-- Coluna 1 - Grupo (futuro TmpSaldG.Grupos)
                .Column1.ControlSource     = ""
                .Column1.Width             = 75
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Grupo"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Conta (futuro TmpSaldG.Estos)
                .Column2.ControlSource     = ""
                .Column2.Width             = 75
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Conta"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Atual
                .Column3.ControlSource     = ""
                .Column3.Width             = 70
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Atual"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Utilizado (futuro TmpSaldG.Utilizar)
                .Column4.ControlSource     = ""
                .Column4.Width             = 70
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Utilizado"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Disponivel (futuro TmpSaldG.Disps)
                .Column5.ControlSource     = ""
                .Column5.Width             = 80
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .T.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Dispon" + CHR(237) + "vel"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 6 - Emp (futuro TmpSaldG.Estos - empresa/filial)
                .Column6.ControlSource     = ""
                .Column6.Width             = 64
                .Column6.Movable           = .F.
                .Column6.Resizable         = .F.
                .Column6.ReadOnly          = .T.
                .Column6.Header1.FontName  = "Verdana"
                .Column6.Header1.FontSize  = 8
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(36, 84, 155)
                .Column6.Header1.Caption   = "Emp"
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .T.
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo"
                .Height    = 15
                .Left      = 454
                .Top       = 90
                .Width     = 36
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
            WITH loc_oCnt.txt_4c_GetDGrupo
                .Height        = 23
                .Width         = 247
                .Left          = 454
                .Top           = 106
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta"
                .Height    = 15
                .Left      = 454
                .Top       = 131
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
            WITH loc_oCnt.txt_4c_GetDConta
                .Height        = 23
                .Width         = 247
                .Left          = 454
                .Top           = 147
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotQtd", "TextBox")
            WITH loc_oCnt.txt_4c_TotQtd
                .Height        = 23
                .Width         = 80
                .Left          = 188
                .Top           = 173
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotEst", "TextBox")
            WITH loc_oCnt.txt_4c_TotEst
                .Height        = 23
                .Width         = 80
                .Left          = 269
                .Top           = 173
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotPrz", "TextBox")
            WITH loc_oCnt.txt_4c_TotPrz
                .Height        = 23
                .Width         = 80
                .Left          = 350
                .Top           = 173
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer3")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTotais - Ultimos controles filhos diretos do form:
    * totais da grade principal (txt_4c_TotQtd/TotEst/TotPrz, Top=349,
    * logo abaixo de grd_4c_Itens - distintos dos hom?nimos dentro de
    * cnt_4c_Container3, que mostram o detalhe da LINHA selecionada, nao o
    * somatorio geral), a foto do item (img_4c_ImgFigJpg, nasce oculta) e a
    * observacao do item (lbl_4c_TxtObsItens/obj_4c_ObsItens). Todos
    * alimentados por GradeItens.AfterRowColChange/Column6.Text1.LostFocus
    * na Fase 7-8 - aqui e so a moldura visual.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTotais()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("txt_4c_TotQtd", "TextBox")
            WITH THIS.txt_4c_TotQtd
                .Height        = 23
                .Width         = 80
                .Left          = 417
                .Top           = 349
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotEst", "TextBox")
            WITH THIS.txt_4c_TotEst
                .Height        = 23
                .Width         = 81
                .Left          = 498
                .Top           = 349
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotPrz", "TextBox")
            WITH THIS.txt_4c_TotPrz
                .Height        = 23
                .Width         = 82
                .Left          = 580
                .Top           = 349
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *-- Foto do item selecionado na grade principal - nasce oculta,
            *-- igual ao legado (Visible=.F. no dump); GradeItens.
            *-- AfterRowColChange decide quando mostrar (Fase 7-8).
            THIS.AddObject("img_4c_ImgFigJpg", "Image")
            WITH THIS.img_4c_ImgFigJpg
                .Top     = 125
                .Left    = 726
                .Width   = 266
                .Height  = 204
                .Stretch = 2
                .Visible = .F.
            ENDWITH

            THIS.AddObject("lbl_4c_TxtObsItens", "Label")
            WITH THIS.lbl_4c_TxtObsItens
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
                .Height    = 15
                .Left      = 726
                .Top       = 369
                .Width     = 134
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_ObsItens", "EditBox")
            WITH THIS.obj_4c_ObsItens
                .Top           = 361
                .Left          = 732
                .Width         = 266
                .Height        = 205
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 2
                .SpecialEffect = 1
                .ReadOnly      = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUPS DO grd_4c_Pedras (Container4 - "Requisicao de componentes
    * adicionais")
    *
    * Legado (SIGPRGLP.Container4.GradePedra):
    *   Column1.Text1.Valid -> CreateObject('fwBuscaExt', <conn>, 'SigCdPro',
    *       'crListaRemota', 'CPros', This.Value, 'Selecao', 1000);
    *       se Not plAchouRegistro -> mAddColuna('CPros'), mAddColuna('DPros'),
    *       Show(); This.Value = CrListaRemota.Cpros;
    *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra;
    *       Use In crListaRemota; GradePedra.Refresh
    *   Column5.Text1.Valid -> mesmo lookup, sem o Replace (so o codigo do
    *       produto substituto)
    *   Column4/Column5.When -> Return (Not Empty(Column1.Text1.Value))
    *   Column5.Text1.LostFocus -> garante uma linha em branco no fim do
    *       SelPedra (Locate For Empty(Cpros) / Append Blank) e desce o cursor
    *
    * Migrado: o picker canonico do projeto eh FormBuscaAuxiliar (substitui
    * fwBuscaExt). Contrato obrigatorio (CLAUDE.md regra #37): 1o argumento eh
    * o HANDLE da conexao (regra #36); Show() SO quando this_lAchouRegistro
    * for .F.; atribuicao SO sob this_lSelecionou - fora da guarda, uma
    * desistencia do usuario ZERARIA o codigo ja digitado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * PedraProdutoKeyPress - Gatilho do lookup da coluna Produto. PUBLIC
    * (BINDEVENT falha em silencio com PROTECTED). LPARAMETERS obrigatorio,
    * senao o VFP9 estoura "No PARAMETER statement is found".
    *--------------------------------------------------------------------------
    PROCEDURE PedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- ENTER(13)/TAB(9) reproduzem o Valid do legado (que rodava ao sair
        *-- da celula); F4(115) eh o atalho de lookup do projeto.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarPedraProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraProdutoDblClick - Duplo clique na celula Produto abre o picker
    * direto (equivalente ao F4).
    *--------------------------------------------------------------------------
    PROCEDURE PedraProdutoDblClick()
        THIS.AbrirLookupPedraProduto()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPedraProduto - Valid da Column1.Text1 do GradePedra. Com a
    * celula vazia o legado nao faz nada ("If Not Empty(This.Value)"); com
    * valor digitado tenta o casamento EXATO em SigCdPro e, achando, ja
    * preenche Descricao/Unidade no SelPedra sem exibir dialogo. Nao achando,
    * cai no picker (AbrirLookupPedraProduto), que repete o padrao do legado
    * (o fwBuscaExt tambem so mostrava a lista quando plAchouRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPedraProduto()
        LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro

        loc_lAchou = .F.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaPedra")
                    USE IN cursor_4c_BuscaPedra
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT cpros, dpros, cunis FROM SigCdPro " + ;
                        "WHERE cpros = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_BuscaPedra")

                    IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra") ;
                       AND RECCOUNT("cursor_4c_BuscaPedra") = 1
                        SELECT cursor_4c_BuscaPedra
                        GO TOP
                        THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
                                                 ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
                                                 ALLTRIM(cursor_4c_BuscaPedra.cunis))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaPedra")
                    USE IN cursor_4c_BuscaPedra
                ENDIF

                *-- Sem casamento exato o legado abria a lista - NUNCA
                *-- MsgAviso("nao encontrado") + limpar o campo antes do
                *-- picker (anti-padrao ja registrado no CLAUDE.md).
                IF !loc_lAchou
                    THIS.AbrirLookupPedraProduto()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraProduto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupPedraProduto - Picker de SigCdPro para a coluna Produto.
    * Substitui o "CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
    * 'CPros', This.Value, 'Selecao', 1000)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupPedraProduto()
        LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro

        *-- Guarda de reentrancia: o picker eh MODAL e o foco sai/volta da
        *-- celula, podendo redisparar o proprio gatilho.
        IF THIS.this_lLookupAberto
            RETURN
        ENDIF
        THIS.this_lLookupAberto = .T.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF USED("cursor_4c_BuscaPedra")
                USE IN cursor_4c_BuscaPedra
            ENDIF

            *-- 1o argumento = HANDLE da conexao (CLAUDE.md regra #36)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", ;
                "cursor_4c_BuscaPedra", ;
                "cpros", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() SO quando o Init nao resolveu sozinho o valor
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                *-- Atribuicao SO sob a guarda de selecao
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra")
                    SELECT cursor_4c_BuscaPedra
                    THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
                                             ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
                                             ALLTRIM(cursor_4c_BuscaPedra.cunis))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaPedra")
                USE IN cursor_4c_BuscaPedra
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraProduto")
        ENDTRY

        *-- Limpar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lLookupAberto = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPedraProduto - Efetiva a escolha do produto na linha corrente do
    * SelPedra. Transcreve o trecho final do Valid legado:
    *   This.Value = CrListaRemota.Cpros
    *   Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *           SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
    *   ThisForm.Container4.GradePedra.Refresh
    * O SelPedra eh cursor de trabalho criado pelo form PAI (mesma
    * DataSession) - por isso o USED() antes do REPLACE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPedraProduto(par_cCodigo, par_cDescricao, par_cUnidade)
        LOCAL loc_oGrid

        loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
        loc_oGrid.Column1.Text1.Value = par_cCodigo

        IF USED("SelPedra") AND !EOF("SelPedra")
            REPLACE SelPedra.Dpros WITH par_cDescricao, ;
                    SelPedra.Cunis WITH par_cUnidade IN SelPedra
        ENDIF

        *-- Com o Produto preenchido, o gate do When legado passa a liberar
        *-- as colunas Qtde e Produto substituto.
        THIS.AjustarColunasPedra()
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoKeyPress - Gatilho do lookup da coluna Produto
    * substituto (Column5). PUBLIC + LPARAMETERS, mesmas razoes da Column1.
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarPedraSubstituto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoDblClick - Duplo clique abre o picker direto.
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoDblClick()
        THIS.AbrirLookupPedraSubstituto()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPedraSubstituto - Valid da Column5.Text1 do GradePedra. Igual ao
    * da Column1, SEM o Replace de Descricao/Unidade (o legado so atribui o
    * codigo nesta coluna).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPedraSubstituto()
        LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro

        loc_lAchou = .F.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaPedra2")
                    USE IN cursor_4c_BuscaPedra2
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT cpros, dpros FROM SigCdPro " + ;
                        "WHERE cpros = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_BuscaPedra2")

                    IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra2") ;
                       AND RECCOUNT("cursor_4c_BuscaPedra2") = 1
                        SELECT cursor_4c_BuscaPedra2
                        GO TOP
                        THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaPedra2")
                    USE IN cursor_4c_BuscaPedra2
                ENDIF

                IF !loc_lAchou
                    THIS.AbrirLookupPedraSubstituto()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraSubstituto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupPedraSubstituto - Picker de SigCdPro para a coluna Produto
    * substituto (Column5.Text1 do GradePedra).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupPedraSubstituto()
        LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro

        IF THIS.this_lLookupAberto
            RETURN
        ENDIF
        THIS.this_lLookupAberto = .T.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF USED("cursor_4c_BuscaPedra2")
                USE IN cursor_4c_BuscaPedra2
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", ;
                "cursor_4c_BuscaPedra2", ;
                "cpros", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra2")
                    SELECT cursor_4c_BuscaPedra2
                    THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaPedra2")
                USE IN cursor_4c_BuscaPedra2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraSubstituto")
        ENDTRY

        THIS.this_lLookupAberto = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPedraSubstituto - "This.Value = CrListaRemota.Cpros" +
    * "ThisForm.Container4.GradePedra.Refresh" do Valid legado da Column5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPedraSubstituto(par_cCodigo)
        LOCAL loc_oGrid

        loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
        loc_oGrid.Column5.Text1.Value = par_cCodigo
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoLostFocus - LostFocus da Column5.Text1 do GradePedra.
    * Transcricao do legado:
    *   SELECT SelPedra / xPosicao = RECNO() / Locate For Empty(Cpros)
    *   If Eof() / Append Blank / EndIf
    *   Locate for Recno() = xPosicao / KEYBOARD '{DNARROW}'
    * Ou seja: garante que exista sempre UMA linha em branco no fim do
    * cursor (para o usuario continuar digitando), volta para a linha em que
    * estava e desce uma linha. PUBLIC (BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoLostFocus()
        LOCAL loc_nPosicao, loc_cAliasAnterior, loc_oErro

        TRY
            IF USED("SelPedra")
                loc_cAliasAnterior = ALIAS()

                SELECT SelPedra
                loc_nPosicao = RECNO("SelPedra")

                LOCATE FOR EMPTY(SelPedra.Cpros)
                IF EOF("SelPedra")
                    APPEND BLANK IN SelPedra
                ENDIF

                *-- "Locate for Recno() = xPosicao" do legado: volta para o
                *-- registro em que o usuario estava
                IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("SelPedra")
                    GO loc_nPosicao IN SelPedra
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                KEYBOARD "{DNARROW}"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PedraSubstitutoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PedrasAfterRowColChange - Reavalia, a cada troca de linha/coluna do
    * grd_4c_Pedras, o gate que o legado escrevia no When das Column4/Column5:
    *   "RETURN (Not EMPTY(ThisForm.Container4.GradePedra.Column1.Text1.Value))"
    * Guarda tambem o ThisForm.AntValue que o When da Column5 registrava.
    * PUBLIC e com o parametro do evento declarado (AfterRowColChange recebe
    * nColIndex) - CLAUDE.md regra #3.
    *--------------------------------------------------------------------------
    PROCEDURE PedrasAfterRowColChange(par_nColIndex)
        THIS.AjustarColunasPedra()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarColunasPedra - Aplica o gate do When legado: Qtde (Column4) e
    * Produto substituto (Column5) so aceitam digitacao com o Produto
    * (Column1) preenchido. Column.ReadOnly eh definido DEPOIS do
    * Grid.ReadOnly (o do grid propaga para as colunas e sobrescreveria).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarColunasPedra()
        LOCAL loc_oGrid, loc_lLiberado, loc_oErro

        TRY
            loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras

            loc_lLiberado = !EMPTY(ALLTRIM(TRANSFORM(loc_oGrid.Column1.Text1.Value)))

            loc_oGrid.Column4.ReadOnly       = !loc_lLiberado
            loc_oGrid.Column4.Text1.ReadOnly = !loc_lLiberado
            loc_oGrid.Column5.ReadOnly       = !loc_lLiberado
            loc_oGrid.Column5.Text1.ReadOnly = !loc_lLiberado

            *-- "ThisForm.AntValue = This.Value" do When da Column5
            THIS.this_cAntValue = ALLTRIM(TRANSFORM(loc_oGrid.Column5.Text1.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarColunasPedra")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDeTrabalho - Completa a preparacao de dados que o Init
    * legado faz DEPOIS de montar a tela e da qual os eventos desta fase
    * dependem (transcrito de SIGPRGLP.Init, dump linhas 2891-2959):
    *
    *   SELECT SelPedra / IF RECCOUNT() = 0 / APPEND BLANK    -> a grade de
    *       Requisicoes (cmd_4c_Pedras) abre com UMA linha em branco pronta
    *       para digitacao; sem isso o Click liga o grid a um cursor vazio.
    *   Create Cursor TmpSaldU (Cpros c(14), KeySelm L)       -> marca os
    *       produtos cujo estoque foi escolhido MANUALMENTE (consumido por
    *       BtnConfirmarDispGrupoClick).
    *   crSigCdCom (SigCdTpc + SigCdCom)                      -> tipos de
    *       componente que entram no custo (consumido pelo AtualizaPeso).
    *   Bind do grid do Container3 + Set Order/Set Key de TmpSaldG.
    *   SetAll('ReadOnly', .t.) da grade principal quando SigCdPam.TransfRes
    *       esta vazio (sem operacao de transferencia nao se edita Produzir).
    *   Totais Tot_Qtd/Tot_Est/Tot_Prz somados de TmpFinal.
    *
    * Todos os cursores de trabalho chegam prontos do form pai, na
    * DataSession privada compartilhada - por isso cada bloco eh guardado
    * por USED(): em modo de teste de UI nenhum deles existe e o metodo
    * simplesmente nao faz nada, sem erro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCursoresDeTrabalho()
        LOCAL loc_oErro, loc_nResultado, loc_cSQL

        TRY
            *-- Linha em branco no SelPedra (Init legado)
            IF USED("SelPedra")
                SELECT SelPedra
                IF RECCOUNT("SelPedra") = 0
                    APPEND BLANK
                ENDIF
            ENDIF

            *-- TmpSaldU - produtos com selecao MANUAL de estoque
            IF !USED("TmpSaldU")
                CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- crSigCdCom: "Select a.Tipos, a.Custos, b.CGrus From SigCdTpc a,
            *-- SigCdCom b Where a.Tipos = b.Tipos" + "Index On Tipos + CGrus
            *-- Tag Tipos" do Init legado. Vai para cursor temporario e dai
            *-- para cursor READWRITE porque cursor de SQLEXEC nasce
            *-- somente-leitura e nao aceita INDEX ON.
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !USED("crSigCdCom")
                loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus" + ;
                           "  FROM SigCdTpc a, SigCdCom b" + ;
                           " WHERE a.Tipos = b.Tipos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ComTmp")

                IF loc_nResultado >= 0 AND USED("cursor_4c_ComTmp")
                    SELECT * FROM cursor_4c_ComTmp INTO CURSOR crSigCdCom READWRITE
                    USE IN cursor_4c_ComTmp
                    SELECT crSigCdCom
                    INDEX ON Tipos + CGrus TAG Tipos
                ELSE
                    MsgErro("Falha ao carregar os tipos de componente (crSigCdCom)." + ;
                        CHR(13) + CapturarErroSQL(), "Erro")
                ENDIF
            ENDIF

            *-- TmpSaldG na ordem/faixa do item corrente + bind do Container3
            IF USED("TmpSaldG")
                SELECT TmpSaldG
                SET ORDER TO Cpros
                THIS.AplicarFaixaSaldoContas()
                THIS.LigarGradeContas()
            ENDIF

            *-- "Select TmpFinal / Sum Saldo, Estoque, Produzir / Go Top" +
            *-- os tres Tot_*.Value do Init legado. O GO TOP vem ANTES: o
            *-- legado deixa o ponteiro no primeiro item, e BOParaForm
            *-- preserva o RECNO corrente ao somar.
            IF USED("TmpFinal")
                SELECT TmpFinal
                GO TOP
            ENDIF
            THIS.BOParaForm()

            *-- Estado inicial dos botoes de acao + o "If
            *-- Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)" do
            *-- Init legado (a grade inteira vira somente-leitura sem a
            *-- operacao de transferencia de reserva configurada)
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararCursoresDeTrabalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFaixaSaldoContas - Restringe TmpSaldG ao item corrente de
    * TmpFinal (Produto + Cor + Tamanho), que eh o "Set Key To TmpFinal.Cpros
    * + TmpFinal.CodCors + TmpFinal.CodTams" do Init legado - reemitido la
    * pelo AfterRowColChange a cada troca de linha da grade principal.
    *
    * NAO da para usar SET KEY aqui. O indice de TmpSaldG eh COMPOSTO
    * (Cpros + CodCors + CodTams + Str(Priors,2) + Grupos + Estos) e a
    * chave acima cobre so os 22 primeiros caracteres; o legado roda com o
    * SET EXACT OFF default do VFP, mas o config.prg deste projeto liga
    * SET EXACT ON (linha 231), e com ele faixa/SEEK parciais sobre indice
    * composto NUNCA casam. Medido no VFP9 em 2026-09-29:
    *
    *     EXACT ON  -> SET KEY parcial: eof=.T. | SEEK parcial: .F.
    *     EXACT OFF -> SET KEY parcial: eof=.F. | SEEK parcial: .T.
    *
    * e a faixa eh avaliada na NAVEGACAO, nao no comando - setar SET KEY sob
    * EXACT OFF e restaurar EXACT ON em seguida tambem devolve eof=.T.
    * O efeito seria invisivel: com a faixa vazia o grid do Container3 fica
    * sempre em branco e, pior, "REPLACE TmpSaldG.Disps" em EOF NAO da erro
    * (medido) - a baixa de estoque por conta simplesmente nao aconteceria.
    *
    * A saida eh SET FILTER com "==" (comparacao exata, independente do
    * SET EXACT), com o valor da chave EMBUTIDO por macro para o filtro
    * ficar CONGELADO no item corrente, como o SET KEY do legado - um
    * filtro que referenciasse TmpFinal seria reavaliado a cada navegacao e
    * quebraria se TmpFinal fosse fechado ou chegasse a EOF.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFaixaSaldoContas()
        LOCAL loc_cChave, loc_cFiltro, loc_oErro

        TRY
            IF USED("TmpSaldG")
                SELECT TmpSaldG

                IF USED("TmpFinal") AND !EOF("TmpFinal")
                    loc_cChave = TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
                    *-- "]" quebraria o delimitador do literal montado abaixo;
                    *-- nenhum codigo de produto/cor/tamanho o usa
                    loc_cChave = STRTRAN(loc_cChave, "]", " ")

                    loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
                    SET FILTER TO &loc_cFiltro
                ELSE
                    SET FILTER TO
                ENDIF

                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarFaixaSaldoContas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarGradeContas - Liga o grid do Container3 (rodape SEMPRE visivel,
    * "Estoque Disponivel" por Grupo/Conta) ao cursor TmpSaldG, transcrito
    * de "With ThisForm.Container3.GradeDisp ... EndWith" do Init legado.
    *
    * Column4 exibe uma EXPRESSAO ("TmpSaldG.Saldo - TmpSaldG.Disps" = o
    * que ja foi utilizado), nao uma coluna - igual ao legado.
    *
    * .SetAll("ReadOnly", .T.) vem ANTES de .Column6.ReadOnly = .F. porque o
    * ReadOnly do Grid propaga para as colunas e sobrescreveria (regra #18).
    * Column6 (Emp) so libera quando o usuario tem o acesso PRIORIDADE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarGradeContas()
        LOCAL loc_oErro

        TRY
            WITH THIS.cnt_4c_Container3.grd_4c_DispConta
                .RecordSource          = "TmpSaldG"
                .Column1.ControlSource = "TmpSaldG.Grupos"
                .Column2.ControlSource = "TmpSaldG.Estos"
                .Column3.ControlSource = "TmpSaldG.Saldo"
                .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
                .Column5.ControlSource = "TmpSaldG.Disps"
                .Column6.ControlSource = "TmpSaldG.Emps"

                .SetAll("ReadOnly", .T.)

                IF fChecaAcesso("SIGPRGLO", "PRIORIDADE")
                    .Column6.ReadOnly              = .F.
                    THIS.cmd_4c_SelEstoque.Enabled = .T.
                ENDIF

                .Refresh()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeContas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga cada botao de acao ao seu handler.
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO
    * com metodo PROTECTED (CLAUDE.md regra #3).
    *
    * Os nomes seguem a ACAO e nao o nome do objeto legado, que eh misnomer
    * em dois casos: o "CancelaDisp" do Container2 e do Container5 nao
    * cancela nada - eh o OK que aplica a quantidade digitada na coluna
    * Utilizar e baixa o estoque (o SCX do Container5 ate rotula o botao
    * como "OK"). Nos Containers 1 e 4 o mesmo nome de classe so fecha o
    * painel, e ai o nome Fechar* eh o correto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmd_4c_Disponivel,   "Click", THIS, "BtnDisponivelClick")
            BINDEVENT(THIS.cmd_4c_SelEstoque,   "Click", THIS, "BtnSelEstoqueClick")
            BINDEVENT(THIS.cmd_4c_TotLinha,     "Click", THIS, "BtnTotLinhaClick")
            BINDEVENT(THIS.cmd_4c_Pedras,       "Click", THIS, "BtnPedrasClick")
            BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
            BINDEVENT(THIS.cmd_4c_Cancelar,     "Click", THIS, "BtnCancelarClick")

            BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnConfirmarDispProdutoClick")
            BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnConfirmarDispGrupoClick")
            BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnFecharPedrasClick")
            BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin,  "Click", ;
                THIS, "BtnFecharLinhasClick")

            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- Grade principal (GradeItens) - troca de linha/coluna alimenta
            *-- Container3/totais/imagem/observacao (legado: AfterRowColChange)
            BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
                THIS, "GradeItensAfterRowColChange")

            *-- Coluna Produzir (Column6, fisica e por .Name - fix do bug de
            *-- troca com a Column3, ver ConfigurarGradeItens) - When/Valid/
            *-- LostFocus do legado
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "GotFocus",  THIS, "ItemProduzirGotFocus")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress",  THIS, "ItemProduzirKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "LostFocus", THIS, "ItemProduzirLostFocus")

            *-- Demais colunas da grade principal - GotFocus redireciona para
            *-- a coluna Produzir (legado: "ThisForm.GradeItens.Column6.
            *-- Text1.SetFocus" nas Column1/3/4/5/7/8; Column2 e Column9 nao
            *-- tem esse redirecionamento no dump)
            BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")

            *-- Coluna Utilizar dos dois paineis de estoque (Container2 =
            *-- Produto/Cor/Tam, Container5 = Grupo/Conta) - Valid do legado,
            *-- emulado por KeyPress (BINDEVENT "Valid" nao dispara de forma
            *-- confiavel em TextBox). Reatribuir o MESMO ColumnCount nos
            *-- Click dos botoes Disponivel/Estoques NAO derruba este
            *-- BINDEVENT - mesmo comportamento ja medido e documentado em
            *-- ConfigurarContainer4/BtnPedrasClick.
            BINDEVENT(THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1, ;
                "KeyPress", THIS, "DispProdutoUtilizarKeyPress")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
                "KeyPress", THIS, "DispGrupoUtilizarKeyPress")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
                "LostFocus", THIS, "DispGrupoUtilizarLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - botao "Disponiveis" (SIGPRGLP.Disponivel.Click).
    * Abre o Container2 com o estoque disponivel do item corrente em TODOS
    * os tamanhos (TmpSaldo filtrado por Produto+Cor), para o usuario
    * escolher de qual tamanho tirar a quantidade.
    *
    * Os Width/Header1.Caption sao reaplicados DEPOIS do RecordSource
    * porque eh isso que o legado faz - e os valores dele divergem de
    * proposito do SCX (Column1 = 80 e nao 108; Column3 = 24 e nao 38).
    *
    * "m." nos nomes das variaveis LOCAIS dentro do SELECT VFP local eh
    * obrigatorio: sem ele o VFP resolve o identificador como COLUNA.
    *
    * _TALLY eh capturado na linha seguinte ao SELECT - no legado ele eh
    * lido varias linhas adiante, o que so funciona por nao haver comando
    * de dados no meio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick()
        LOCAL loc_cCpro, loc_cCor, loc_nTally, loc_oErro

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldo")
                MsgAviso("Nenhum item selecionado na grade.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
                  FROM TmpSaldo ;
                 WHERE Cpros   = m.loc_cCpro ;
                   AND CodCors = m.loc_cCor ;
                   AND Disps   > 0 ;
                 ORDER BY Cpros, CodCors, CodTams ;
                  INTO CURSOR TmpDisp READWRITE

                loc_nTally = _TALLY

                THIS.grd_4c_Itens.Enabled = .F.

                IF loc_nTally = 0
                    MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + ;
                        "vel Em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.BtnConfirmarDispProdutoClick()
                ELSE
                    WITH THIS.cnt_4c_Container2.grd_4c_DispProduto
                        .RecordSource = "TmpDisp"
                        .ColumnCount  = 5

                        .Column1.ControlSource = "TmpDisp.Cpros"
                        .Column2.ControlSource = "TmpDisp.CodCors"
                        .Column3.ControlSource = "TmpDisp.CodTams"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"

                        .Column1.Width = 80
                        .Column2.Width = 38
                        .Column3.Width = 24
                        .Column4.Width = 75
                        .Column5.Width = 75

                        .Column1.Header1.Caption = "Produto"
                        .Column2.Header1.Caption = "Cor"
                        .Column3.Header1.Caption = "Tam"
                        .Column4.Header1.Caption = "Disponivel"
                        .Column5.Header1.Caption = "Utilizar"
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container2.Visible = .T.

                    THIS.cnt_4c_Container2.ZOrder(0)
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.SetFocus()
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnDisponivelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - botao "Estoques" (SIGPRGLP.SelEstoque.Click).
    * Abre o Container5 com o estoque disponivel do item corrente quebrado
    * por Prioridade/Grupo/Conta (TmpSaldG filtrado por Produto+Cor+Tam).
    *
    * O legado consulta para o cursor "Resultado" e reabre o DBF dele sob o
    * alias TmpDisp ("Use Dbf('Resultado') Alias TmpDisp Again") justamente
    * para obter um alias GRAVAVEL - a coluna Utilizar eh digitada pelo
    * usuario. Transcrito literalmente.
    *
    * Os Header/Width tambem divergem do SCX de proposito (Column3 = "Prior"
    * com 24px, contra "Prioridade" com 80px desenhado na tela).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick()
        LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_nTally, loc_oErro

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldG")
                MsgAviso("Nenhum item selecionado na grade.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors
                loc_cTam  = TmpFinal.CodTams

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container5.grd_4c_DispGrupo.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
                       000000000.000 AS Utilizar ;
                  FROM TmpSaldG ;
                 WHERE Cpros   = m.loc_cCpro ;
                   AND CodCors = m.loc_cCor ;
                   AND CodTams = m.loc_cTam ;
                   AND Disps   > 0 ;
                  INTO CURSOR Resultado ;
                 ORDER BY 1, 2, 3, 4

                loc_nTally = _TALLY

                SELECT 0
                USE DBF("Resultado") ALIAS TmpDisp AGAIN
                USE IN Resultado

                THIS.grd_4c_Itens.Enabled = .F.

                IF loc_nTally = 0
                    MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + ;
                        "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.BtnConfirmarDispGrupoClick()
                ELSE
                    WITH THIS.cnt_4c_Container5.grd_4c_DispGrupo
                        .RecordSource = "TmpDisp"
                        .ColumnCount  = 5

                        .Column1.ControlSource = "TmpDisp.Grupos"
                        .Column2.ControlSource = "TmpDisp.Estos"
                        .Column3.ControlSource = "TmpDisp.Priors"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"

                        .Column1.Width = 80
                        .Column2.Width = 80
                        .Column3.Width = 24
                        .Column4.Width = 75
                        .Column5.Width = 75

                        .Column1.Header1.Caption = "Grupo"
                        .Column2.Header1.Caption = "Conta"
                        .Column3.Header1.Caption = "Prior"
                        .Column4.Header1.Caption = "Disponivel"
                        .Column5.Header1.Caption = "Utilizar"
                    ENDWITH

                    *-- Bloco do legado com o "Estoques" INCLUSO (eh o unico
                    *-- painel que desabilita o proprio botao que o abriu)
                    THIS.HabilitarCampos(.F., .T.)
                    THIS.cnt_4c_Container5.Visible = .T.

                    WITH THIS.cnt_4c_Container5
                        .ZOrder(0)
                        .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
                            loc_cCpro + " " + loc_cCor + "/" + loc_cTam + ")"
                        .txt_4c_QtPedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
                        .txt_4c_QtSelec.Value  = 0
                        .grd_4c_DispGrupo.Refresh()
                        .grd_4c_DispGrupo.Column5.SetFocus()
                        .grd_4c_DispGrupo.Refresh()
                    ENDWITH
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelEstoqueClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - botao "Total/Linhas" (SIGPRGLP.TotLinha.Click).
    * Abre o Container1 com o resumo por linha de producao (soma de
    * Saldo/Estoque/Produzir agrupada por TmpFinal.Linhas) e uma linha
    * "TOTAIS" acrescentada por UNION ALL, destacada em azul e negrito
    * pelas expressoes Dynamic* - transcritas do legado.
    *
    * A coluna "Ordem" existe so para ordenar (Order By 2, 1) e deixar
    * "TOTAIS" por ultimo - nao eh exibida (o grid tem 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick()
        LOCAL loc_oErro

        TRY
            IF !USED("TmpFinal")
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para totalizar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("TmpLinha")
                    THIS.cnt_4c_Container1.grd_4c_Linhas.RecordSource = ""
                ENDIF

                SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
                       SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
                  FROM TmpFinal ;
                 GROUP BY 1 ;
                 UNION ALL ;
                SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
                       SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
                  FROM TmpFinal ;
                 GROUP BY 1 ;
                  INTO CURSOR TmpLinha ;
                 ORDER BY 2, 1

                WITH THIS.cnt_4c_Container1.grd_4c_Linhas
                    .RecordSource = "TmpLinha"
                    .ColumnCount  = 4

                    .Column1.ControlSource = "TmpLinha.Linhas"
                    .Column2.ControlSource = "TmpLinha.Saldo"
                    .Column3.ControlSource = "TmpLinha.Estoque"
                    .Column4.ControlSource = "TmpLinha.Produzir"

                    .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
                    .SetAll("DynamicForeColor", ;
                        "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
                ENDWITH

                *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
                THIS.HabilitarCampos(.F., .F.)
                THIS.cnt_4c_Container1.Visible = .T.

                THIS.cnt_4c_Container1.ZOrder(0)
                THIS.cnt_4c_Container1.grd_4c_Linhas.Refresh()
                THIS.cnt_4c_Container1.grd_4c_Linhas.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnTotLinhaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - botao "Requisicoes" (SIGPRGLP.Pedras.Click).
    * Abre o Container4 (Requisicao de Componentes Adicionais) ligando a
    * grade ao cursor SelPedra, que o form pai criou e cuja unica linha em
    * branco foi garantida por PrepararCursoresDeTrabalho().
    *
    * Os lookups de SigCdPro das colunas Produto/Produto substituto ja estao
    * ligados por BINDEVENT desde ConfigurarContainer4() - reatribuir o
    * MESMO ColumnCount nao os derruba (medido no VFP9 em 2026-09-29:
    * AEVENTS continua 1 e Width/Header1.Caption ficam intactos).
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick()
        LOCAL loc_oErro

        TRY
            IF !USED("SelPedra")
                MsgAviso("Cursor de requisi" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.cnt_4c_Container4.grd_4c_Pedras.RecordSource = ""

                WITH THIS.cnt_4c_Container4.grd_4c_Pedras
                    .RecordSource = "SelPedra"
                    .ColumnCount  = 5

                    .Column1.ControlSource = "SelPedra.Cpros"
                    .Column2.ControlSource = "SelPedra.Dpros"
                    .Column3.ControlSource = "SelPedra.Cunis"
                    .Column4.ControlSource = "SelPedra.Qtds"
                    .Column5.ControlSource = "SelPedra.Cpro2s"
                ENDWITH

                *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
                THIS.HabilitarCampos(.F., .F.)
                THIS.cnt_4c_Container4.Visible = .T.

                THIS.cnt_4c_Container4.ZOrder(0)
                THIS.cnt_4c_Container4.grd_4c_Pedras.Refresh()
                THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.SetFocus()

                *-- Reaplica o gate do When legado (Qtde e Produto substituto
                *-- so liberam com o Produto preenchido) na linha em que o
                *-- grid acabou de pousar
                THIS.AjustarColunasPedra()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnPedrasClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRelatorioClick - botao "Relatorio" (SIGPRGLP.btnRelatorio.Click).
    * Monta o cursor crImpressao a partir de TmpFinal, completa a descricao
    * de cada produto consultando SigCdPro e manda para o SigReGlp.frx.
    *
    * O legado usa IsEmpty(TmpFinal.Obsps) na coluna ObsPs; aqui vai
    * ISNULL(...) OR EMPTY(...) - mesma semantica do IsEmpty do Fortyus
    * (que trata NULL como vazio), sem depender da resolucao do wrapper
    * pelo PATH. Mesma forma ja usada no Column8 da grade principal.
    *
    * A descricao eh buscada produto a produto, como no legado ("Select
    * Distinct Cpros ... Scan ... SqlExecute"): a consulta unica por IN
    * seria mais rapida, mas mudaria a forma do acesso ao banco sem que o
    * legado peca isso.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRelatorioClick()
        LOCAL loc_cSQL, loc_nResultado, loc_lProsseguir, loc_oErro

        TRY
            loc_lProsseguir = .T.

            IF !USED("TmpFinal")
                MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
                    "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
                       Saldo, Estoque, Produzir, ;
                       IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
                  FROM TmpFinal ;
                 ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
                  INTO CURSOR crImpressao READWRITE

                GO TOP IN crImpressao

                IF EOF("crImpressao")
                    MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
                        "o do Relat" + CHR(243) + "rio!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Sem conexao o relatorio sairia com a coluna Descricao em
            *-- branco, sem nenhum aviso - o legado nem chega a testar isso
            IF loc_lProsseguir AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
                    "o " + CHR(233) + " poss" + CHR(237) + "vel obter a descri" + CHR(231) + ;
                    CHR(227) + "o dos produtos.", "Falha na Conex" + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds

                SELECT LocalProds
                SCAN
                    loc_cSQL = "SELECT CPros, DPros" + ;
                               "  FROM SigCdPro" + ;
                               " WHERE CPros = " + EscaparSQL(LocalProds.CPros)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "LocalBus")

                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (LocalBus)")
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF

                    SELECT LocalBus
                    GO TOP IN LocalBus
                    IF !EOF("LocalBus")
                        UPDATE crImpressao SET DPros = LocalBus.DPros ;
                         WHERE CPros = LocalBus.CPros
                    ENDIF

                    SELECT LocalProds
                ENDSCAN

                IF USED("LocalBus")
                    USE IN LocalBus
                ENDIF
                IF USED("LocalProds")
                    USE IN LocalProds
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crImpressao
                GO TOP IN crImpressao
                THIS.ExecutarReportForm("SigReGlp", "PREVIEW", "crImpressao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnRelatorioClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - botao "Sair" (SIGPRGLP.Cancelar.Click).
    * Descarta a transacao em aberto e fecha a tela SEM efetivar nada.
    *
    * "ThisForm.poDataMgr.RollBack()" do legado vira SQLROLLBACK no handle
    * global: a conexao deste ambiente nasce com Transactions = 2 (manual),
    * entao o que o Processar tiver gravado e ainda nao confirmado precisa
    * ser revertido explicitamente aqui.
    *
    * O Release() fica FORA do TRY: liberar o form de dentro do bloco
    * derrubaria a propria pilha de execucao dentro dele (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLROLLBACK(gnConnHandle)
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF

            loc_lFechar = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
        ENDTRY

        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarDispProdutoClick - botao OK do Container2
    * (SIGPRGLP.Container2.CancelaDisp.Click). Apesar do nome legado, ele
    * CONFIRMA a escolha: para cada tamanho com Utilizar > 0 ele QUEBRA a
    * linha corrente de TmpFinal em duas - uma com o tamanho escolhido e a
    * quantidade retirada do estoque (Produzir = 0), e o restante segue na
    * linha original - e propaga a baixa em TmpSaldo/TmpSaldG e no item da
    * O.P. (SigMvIts) que ainda estava sem tamanho definido.
    *
    * Substituicoes de sintaxe (mesma semantica, forma valida em VFP9):
    *   "=Afiel(Tfinal)"  -> AFIELDS() com LOCAL ARRAY (a funcao EXIGE
    *       array declarado; LOCAL simples estoura em runtime)
    *   "Scatter To Memvar / Append From Array Memvar" -> SCATTER MEMVAR
    *       MEMO + APPEND BLANK + GATHER MEMVAR MEMO (copia do registro
    *       inteiro; o MEMO preserva a observacao do item na linha
    *       desmembrada, que continua sendo o MESMO item)
    *   "?pQtd / ?pAqt / ?pIds" -> EscaparSQL/FormatarNumeroSQL conforme o
    *       TIPO de cada coluna em SigMvIts (qtds/aqtds numeric(9,3),
    *       codtams char(4), cidchaves char(20))
    *
    * EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
    * char(20) + Str(Numes, 6): o padding FAZ PARTE da chave, por isso
    * PADR explicito e NUNCA ALLTRIM nas partes (regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarDispProdutoClick()
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nBaixa
        LOCAL loc_cEdn, loc_cSQL, loc_nResultado, loc_lProsseguir
        LOCAL loc_nQtd, loc_nAQtd, loc_cIds, loc_cExactOrig, loc_oErro
        LOCAL ARRAY loc_aTFinal[1]

        TRY
            loc_lProsseguir = .T.

            IF USED("TmpFinal") AND USED("TmpDisp")
                SELECT TmpFinal
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                loc_nQtdUti = 0
                SUM Utilizar TO loc_nQtdUti

                *-- Sem conexao nao da para acertar o item da O.P. em
                *-- SigMvIts, e o legado so descobre isso NO MEIO do laco -
                *-- quando TmpFinal/TmpSaldo/TmpSaldG ja foram alterados e o
                *-- "Return 0" deixa a divisao pela metade. Conferir ANTES de
                *-- mexer em qualquer cursor evita esse estado parcial.
                IF loc_nQtdUti > 0 AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                    MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
                        "o " + CHR(233) + " poss" + CHR(237) + "vel confirmar a sele" + ;
                        CHR(231) + CHR(227) + "o de estoque.", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir AND loc_nQtdUti > 0
                    SELECT TmpFinal
                    =AFIELDS(loc_aTFinal)
                    CREATE CURSOR Temporario FROM ARRAY loc_aTFinal

                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF

                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")

                        *-- Desmembra a linha corrente de TmpFinal: o tamanho
                        *-- escolhido vira uma linha nova ja coberta por
                        *-- estoque, e o restante fica na linha original
                        SELECT TmpFinal
                        SCATTER MEMVAR MEMO

                        SELECT Temporario
                        APPEND BLANK
                        GATHER MEMVAR MEMO
                        REPLACE Saldo    WITH loc_nQtUtil, ;
                                CodTams  WITH TmpDisp.CodTams, ;
                                Estoque  WITH loc_nQtUtil, ;
                                Produzir WITH 0 IN Temporario

                        REPLACE Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil IN TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal
                        REPLACE Disps    WITH TmpSaldo.Disps    - loc_nQtUtil IN TmpSaldo

                        *-- Redistribui a baixa entre as contas de TmpSaldG,
                        *-- da primeira com saldo em diante.
                        *--
                        *-- Os dois SEEK abaixo usam chave PARCIAL (22 dos 44
                        *-- caracteres do indice composto de TmpSaldG) e por
                        *-- isso exigem SET EXACT OFF: com o SET EXACT ON do
                        *-- config.prg eles devolvem .F. e, como o retorno eh
                        *-- descartado, o REPLACE seguinte cairia em EOF - que
                        *-- em VFP9 NAO da erro (medido em 2026-09-29). A
                        *-- redistribuicao inteira sumiria em silencio.
                        loc_nBaixa = TmpSaldo.Saldo - TmpSaldo.Disps

                        loc_cExactOrig = SET("EXACT")
                        SET EXACT OFF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE Disps WITH Saldo ;
                          WHILE Cpros   = TmpSaldo.Cpros ;
                            AND CodCors = TmpSaldo.CodCors ;
                            AND CodTams = TmpSaldo.CodTams

                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        SCAN WHILE Cpros   = TmpSaldo.Cpros ;
                               AND CodCors = TmpSaldo.CodCors ;
                               AND CodTams = TmpSaldo.CodTams ;
                               AND loc_nBaixa > 0
                            IF TmpSaldG.Disps >= loc_nBaixa
                                REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
                                loc_nBaixa = 0
                            ELSE
                                loc_nBaixa = loc_nBaixa - TmpSaldG.Disps
                                REPLACE TmpSaldG.Disps WITH 0
                            ENDIF
                        ENDSCAN

                        SET EXACT &loc_cExactOrig

                        *-- Acerta o item da O.P. que ainda estava sem tamanho
                        loc_cEdn = PADR(TmpFinal.Emps, 3) + PADR(TmpFinal.Dopes, 20) + ;
                                   STR(TmpFinal.Numes, 6)

                        loc_cSQL = "SELECT *" + ;
                                   "  FROM SigMvIts" + ;
                                   " WHERE empdopnums = " + EscaparSQL(loc_cEdn) + ;
                                   "   AND cpros = " + EscaparSQL(TmpFinal.Cpros)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2")

                        IF loc_nResultado < 0
                            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (TempEsti2 - 3)")
                            loc_lProsseguir = .F.
                            EXIT
                        ENDIF

                        SELECT TempEsti2
                        SCAN
                            IF TempEsti2.Citens <> TmpFinal.Citens
                                LOOP
                            ENDIF

                            IF TempEsti2.CodCors = TmpFinal.CodCors ;
                                    AND TempEsti2.CodTams = SPACE(4)

                                SCATTER MEMVAR

                                loc_nQtd  = loc_nQtUtil
                                loc_nAQtd = TempEsti2.Qtds
                                loc_cIds  = TempEsti2.cIdChaves

                                loc_cSQL = "UPDATE SigMvIts" + ;
                                           "   SET codtams = " + EscaparSQL(LEFT(TmpDisp.CodTams, 4)) + ;
                                           "     , qtds    = " + FormatarNumeroSQL(loc_nQtd,  3) + ;
                                           "     , aqtds   = " + FormatarNumeroSQL(loc_nAQtd, 3) + ;
                                           " WHERE cidchaves = " + EscaparSQL(loc_cIds)

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                        CapturarErroSQL(), ;
                                        "Falha na Conex" + CHR(227) + "o (Update - 9)")
                                    loc_lProsseguir = .F.
                                    EXIT
                                ENDIF

                                *-- Sobra do item original entra no cursor de
                                *-- itens que o Processar grava depois
                                IF USED("crSigMvIts")
                                    SELECT crSigMvIts
                                    APPEND BLANK
                                    GATHER MEMVAR
                                    REPLACE Qtds      WITH Qtds - loc_nQtUtil
                                    REPLACE AQtds     WITH Qtds
                                    REPLACE cIdChaves WITH fUniqueIds()
                                    IF crSigMvIts.Qtds = 0
                                        DELETE
                                    ENDIF
                                ENDIF

                                SELECT TempEsti2
                                EXIT
                            ENDIF
                        ENDSCAN

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT TmpDisp
                    ENDSCAN

                    IF loc_lProsseguir
                        SELECT TmpFinal
                        IF TmpFinal.Saldo = 0
                            DELETE
                        ENDIF
                        SELECT TmpFinal
                        APPEND FROM DBF("Temporario")
                        GO loc_nRegFinal

                        =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                    ENDIF

                    IF USED("Temporario")
                        USE IN Temporario
                    ENDIF
                    IF USED("TempEsti2")
                        USE IN TempEsti2
                    ENDIF
                ENDIF
            ENDIF

            THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container2, .F.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnConfirmarDispProdutoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarDispGrupoClick - botao OK do Container5
    * (SIGPRGLP.Container5.CancelaDisp.Click). Confirma de QUAIS contas sai
    * a quantidade: para cada linha com Utilizar > 0, abate o total a
    * produzir do item, baixa TmpSaldo e a conta correspondente em TmpSaldG
    * (chave Produto+Cor+Tam+Prioridade+Grupo+Conta) e marca o produto em
    * TmpSaldU.KeySelm, que sinaliza "estoque escolhido manualmente" para o
    * restante do processamento.
    *
    * A chave do SEEK em TmpSaldG eh POSICIONAL - Str(Priors, 2) entre o
    * tamanho e o grupo - e por isso nenhuma parte leva ALLTRIM (regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarDispGrupoClick()
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_oErro

        TRY
            IF USED("TmpFinal") AND USED("TmpDisp")
                SELECT TmpFinal
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                loc_nQtdUti = 0
                SUM Utilizar TO loc_nQtdUti

                IF loc_nQtdUti > 0
                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF

                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")

                        SELECT TmpFinal
                        REPLACE Produzir WITH Produzir - loc_nQtUtil IN TmpFinal
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir IN TmpFinal

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil

                        IF USED("TmpSaldU")
                            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                            ENDIF
                            REPLACE KeySelm WITH .T. IN TmpSaldU
                        ENDIF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
                              STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN

                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
            ENDIF

            THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container5, .T.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnConfirmarDispGrupoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFecharPedrasClick - botao "Sair" do Container4
    * (SIGPRGLP.Container4.CancelaDisp.Click). Aqui o nome legado eh
    * literal: nao ha nada a confirmar, o que foi digitado ja esta no
    * cursor SelPedra e sera lido pelo Processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnFecharPedrasClick()
        THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container4, .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFecharLinhasClick - botao "OK" do Container1
    * (SIGPRGLP.Container1.CancelaLin.Click). O painel de totais por linha
    * eh somente-leitura: fechar eh a unica acao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnFecharLinhasClick()
        THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container1, .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * RestaurarGradePrincipal - Bloco "With ThisForm ... EndWith" que
    * encerra os QUATRO handlers de fechamento de painel no legado
    * (Container1.CancelaLin e Container2/4/5.CancelaDisp): reabilita os
    * botoes de acao, esconde o painel, devolve o foco a coluna Produzir da
    * grade principal e traz a grade para frente.
    *
    * A UNICA diferenca entre os quatro no legado eh o SelEstoque: so o
    * Container5 o reabilita, porque so o BtnSelEstoqueClick o desabilita.
    * Dai o parametro par_lReabilitarSelEstoque.
    *
    * NOTA DE FIDELIDADE: o legado reabilita cmd_4c_Pedras
    * INCONDICIONALMENTE aqui, mesmo quando o Init o havia desabilitado por
    * falta das colunas de transferencia em SigCdPam. O comportamento eh
    * transcrito como esta - abrir o painel de Requisicoes nao depende
    * desses parametros (quem depende deles eh o Processar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RestaurarGradePrincipal(par_oContainer, par_lReabilitarSelEstoque)
        LOCAL loc_oErro

        TRY
            *-- Bloco "With ThisForm / .Processar.Enabled = .t. / ... /
            *-- EndWith" que o legado repete no fechamento de cada painel
            THIS.HabilitarCampos(.T., par_lReabilitarSelEstoque)

            IF VARTYPE(par_oContainer) = "O"
                par_oContainer.Visible = .F.
            ENDIF

            THIS.grd_4c_Itens.Enabled = .T.
            THIS.grd_4c_Itens.ZOrder(0)
            THIS.grd_4c_Itens.Refresh()
            THIS.grd_4c_Itens.Column6.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em RestaurarGradePrincipal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GRADE PRINCIPAL (grd_4c_Itens) - troca de linha/coluna e coluna
    * "Produzir" (Column6, fisica e por .Name - ver fix em ConfigurarGradeItens)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Transcricao de SIGPRGLP.GradeItens.
    * AfterRowColChange. A cada troca de linha/coluna da grade principal:
    * atualiza a observacao do item (memo TmpFinal.Obsps, ligado direto por
    * ControlSource em PrepararCursoresDeTrabalho), refaz a faixa/bind do
    * Container3 (Estoque Disponivel por Conta) para o item corrente e
    * recarrega a foto do produto (SigCdPro.FigJpgs, base64).
    *
    * "ThisForm.poDataMgr.CursorQuery" do legado (helper do Fortyus que nao
    * foi portado) vira SQLEXEC direto em cursor descartavel.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_cFoto, loc_oErro

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.obj_4c_ObsItens.Refresh()
                THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
                    ALLTRIM(TmpFinal.Cpros)

                IF USED("TmpSaldo")
                    =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF

                *-- "Select TmpSaldG / Set Order To Cpros / Set Key To ... /
                *-- Go Top" do legado - a faixa via SET KEY parcial nao
                *-- funciona sob o SET EXACT ON deste projeto (ver comentario
                *-- de AplicarFaixaSaldoContas); reusa o mesmo metodo que ja
                *-- resolve isso com SET FILTER congelado
                THIS.AplicarFaixaSaldoContas()

                WITH THIS.cnt_4c_Container3
                    IF USED("TmpSaldo") AND !EOF("TmpSaldo")
                        .txt_4c_TotQtd.Value = TmpSaldo.Saldo
                        .txt_4c_TotEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                        .txt_4c_TotPrz.Value = TmpSaldo.Disps
                    ENDIF

                    .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
                        IIF(!EMPTY(TmpFinal.CodCors), "Cor:" + ALLTRIM(TmpFinal.CodCors), "") + ;
                        IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + ALLTRIM(TmpFinal.CodTams), "")

                    .txt_4c_GetDGrupo.Value = ""
                    .txt_4c_GetDConta.Value = ""

                    IF USED("TmpSaldG") AND !EOF("TmpSaldG")
                        IF USED("TmpConta")
                            USE IN TmpConta
                        ENDIF
                        IF USED("TmpGrupo")
                            USE IN TmpGrupo
                        ENDIF

                        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                            SQLEXEC(gnConnHandle, ;
                                "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(ALLTRIM(TmpSaldG.Estos)), "TmpConta")
                            SQLEXEC(gnConnHandle, ;
                                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                                EscaparSQL(ALLTRIM(TmpSaldG.Grupos)), "TmpGrupo")
                        ENDIF

                        IF USED("TmpGrupo") AND !EOF("TmpGrupo")
                            .txt_4c_GetDGrupo.Value = ALLTRIM(TratarNulo(TmpGrupo.Descrs, ""))
                        ENDIF
                        IF USED("TmpConta") AND !EOF("TmpConta")
                            .txt_4c_GetDConta.Value = ALLTRIM(TratarNulo(TmpConta.Rclis, ""))
                        ENDIF

                        IF USED("TmpConta")
                            USE IN TmpConta
                        ENDIF
                        IF USED("TmpGrupo")
                            USE IN TmpGrupo
                        ENDIF
                    ENDIF

                    .grd_4c_DispConta.Refresh()
                ENDWITH

                *-- Foto do item (Clear Resources + StrToFile do legado)
                IF USED("crSigCdPro_4c_Foto")
                    USE IN crSigCdPro_4c_Foto
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    SQLEXEC(gnConnHandle, ;
                        "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "crSigCdPro_4c_Foto")
                ENDIF

                loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb.jpg"

                CLEAR RESOURCES
                THIS.img_4c_ImgFigJpg.Picture = ""
                THIS.img_4c_ImgFigJpg.Visible = .F.

                IF USED("crSigCdPro_4c_Foto") AND !EOF("crSigCdPro_4c_Foto") AND ;
                        !ISNULL(crSigCdPro_4c_Foto.FigJpgs) AND !EMPTY(crSigCdPro_4c_Foto.FigJpgs)
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro_4c_Foto.FigJpgs, ;
                        "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)

                    IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                        THIS.img_4c_ImgFigJpg.Picture = loc_cArquivo
                        THIS.img_4c_ImgFigJpg.Visible = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdPro_4c_Foto")
                    USE IN crSigCdPro_4c_Foto
                ENDIF

                SELECT TmpFinal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GradeItensAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemFocoColunaProduzir - GotFocus das demais colunas da grade principal
    * (Column1/3/4/5/7/8 - legado: "ThisForm.GradeItens.Column6.Text1.
    * SetFocus"). Column2 e Column9 nao tem esse redirecionamento no dump.
    *--------------------------------------------------------------------------
    PROCEDURE ItemFocoColunaProduzir()
        THIS.grd_4c_Itens.Column6.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirGotFocus - When da Column6.Text1 do GradeItens (coluna
    * Produzir). Guarda o valor anterior (ThisForm.OldValue do legado) e, em
    * modo Reserva Automatica com o item ainda sem estoque baixado, libera o
    * botao Disponiveis quando o grupo do produto tem TipoEstos 3 ou 4.
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirGotFocus()
        LOCAL loc_oErro

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.this_nProduzirValorAnterior = THIS.grd_4c_Itens.Column6.Text1.Value

                IF THIS.this_oBusinessObject.this_lReserva AND TmpFinal.Estoque = 0
                    IF USED("TempPro")
                        USE IN TempPro
                    ENDIF
                    IF USED("TempGru")
                        USE IN TempGru
                    ENDIF

                    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                        SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus FROM SigCdPro WHERE Cpros = " + ;
                            EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "TempPro")

                        IF USED("TempPro") AND !EOF("TempPro")
                            SQLEXEC(gnConnHandle, ;
                                "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
                                EscaparSQL(ALLTRIM(TempPro.CGrus)), "TempGru")

                            IF USED("TempGru") AND !EOF("TempGru") AND ;
                                    INLIST(TempGru.TipoEstos, 3, 4)
                                THIS.cmd_4c_Disponivel.Enabled = .T.
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("TempGru")
                        USE IN TempGru
                    ENDIF
                    IF USED("TempPro")
                        USE IN TempPro
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirGotFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirKeyPress - Gatilho do Valid da Column6.Text1 (coluna
    * Produzir), emulado por ENTER(13)/TAB(9) - BINDEVENT "Valid" nao
    * dispara de forma confiavel em TextBox (CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarItemProduzir()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarItemProduzir - Transcricao de SIGPRGLP.GradeItens.Column6.Text1.
    * Valid. Impede quantidade negativa ou maior que o saldo do item, confirma
    * com o usuario a perda de selecao manual de estoque (TmpSaldU.KeySelm) e,
    * aceitando a nova quantidade, redistribui a baixa de estoque entre
    * TmpSaldo/TmpSaldG.
    *
    * Os dois SEEK sobre TmpSaldG usam chave PARCIAL (Cpros+CodCors+CodTams,
    * sem a Prioridade/Grupo/Conta que completam o indice composto) - por
    * isso o bloco roda sob SET EXACT OFF, restaurado logo em seguida (mesma
    * tecnica ja usada em BtnConfirmarDispProdutoClick).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarItemProduzir()
        LOCAL loc_oTxt, loc_nBaixa, loc_cExactOrig, loc_lConfirma, loc_oErro

        TRY
            IF !USED("TmpFinal") OR !USED("TmpSaldo") OR !USED("TmpSaldG") OR EOF("TmpFinal")
                RETURN
            ENDIF

            loc_oTxt = THIS.grd_4c_Itens.Column6.Text1

            IF !USED("TmpSaldU")
                CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
                INDEX ON Cpros TAG Cpros
            ENDIF

            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF

            IF loc_oTxt.Value <> THIS.this_nProduzirValorAnterior AND TmpSaldU.KeySelm
                loc_lConfirma = MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + ;
                    CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. " + ;
                    "Deseja Continuar?", "Aten" + CHR(231) + CHR(227) + "o")
                IF !loc_lConfirma
                    loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    loc_oTxt.Refresh()
                    RETURN
                ENDIF
            ENDIF

            DO CASE
                CASE loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    * nada a fazer - mesmo valor

                CASE loc_oTxt.Value < 0
                    MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = THIS.this_nProduzirValorAnterior

                CASE loc_oTxt.Value > TmpFinal.Saldo
                    MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da " + ;
                        "Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = TmpFinal.Saldo - TmpFinal.Estoque

                CASE !SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") ;
                        AND TmpFinal.Produzir <> TmpFinal.Saldo
                    MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
                        "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = TmpFinal.Saldo

                OTHERWISE
                    IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_oTxt.Value
                        REPLACE TmpSaldo.Disps WITH ;
                            TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                        REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_oTxt.Value IN TmpFinal
                        REPLACE KeySelm WITH .F. IN TmpSaldU

                        loc_nBaixa = TmpSaldo.Saldo - TmpSaldo.Disps

                        loc_cExactOrig = SET("EXACT")
                        SET EXACT OFF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE Disps WITH Saldo ;
                          WHILE Cpros   = TmpSaldo.Cpros ;
                            AND CodCors = TmpSaldo.CodCors ;
                            AND CodTams = TmpSaldo.CodTams
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        SCAN WHILE Cpros   = TmpSaldo.Cpros ;
                               AND CodCors = TmpSaldo.CodCors ;
                               AND CodTams = TmpSaldo.CodTams ;
                               AND loc_nBaixa > 0
                            IF TmpSaldG.Disps >= loc_nBaixa
                                REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
                                loc_nBaixa = 0
                            ELSE
                                loc_nBaixa = loc_nBaixa - TmpSaldG.Disps
                                REPLACE TmpSaldG.Disps WITH 0
                            ENDIF
                        ENDSCAN

                        SET EXACT &loc_cExactOrig
                    ELSE
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
                            "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    ENDIF
            ENDCASE

            loc_oTxt.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarItemProduzir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirLostFocus - Transcricao de SIGPRGLP.GradeItens.Column6.
    * Text1.LostFocus. Reflete o Saldo/Estoque/Produzir agregados de todo o
    * TmpFinal nos totais do rodape da grade principal.
    *
    * O "Sum Saldo, Estoque, Produzir" com guarda de RECNO() eh exatamente o
    * que BOParaForm faz - o legado repete esse mesmo bloco aqui, no Init e
    * no retorno dos paineis de estoque, e aqui ele passa pelo funil unico.
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirLostFocus()
        LOCAL loc_oErro

        TRY
            IF USED("TmpFinal")
                THIS.BOParaForm()
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * COLUNA "UTILIZAR" DOS PAINEIS DE ESTOQUE (Container2 = Produto/Cor/Tam,
    * Container5 = Grupo/Conta)
    *==========================================================================

    *--------------------------------------------------------------------------
    * DispProdutoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
    * grd_4c_DispProduto (Container2), emulado por ENTER/TAB.
    *--------------------------------------------------------------------------
    PROCEDURE DispProdutoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDispProdutoUtilizar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDispProdutoUtilizar - Transcricao de SIGPRGLP.Container2.
    * GradeDisp.Column5.Text1.Valid. Impede utilizar mais do que o disponivel
    * na linha OU mais do que o total pedido, e espelha o somatorio em
    * txt_4c_QtSelec (This.Parent.Parent.Parent.Qt_Selec do legado - Text1 ->
    * Column -> Grid -> Container2).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDispProdutoUtilizar()
        LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro

        TRY
            IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
                RETURN
            ENDIF

            loc_oTxt = THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1

            IF loc_oTxt.Value > TmpDisp.Disps
                MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
                    "Dispon" + CHR(237) + "vel!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oTxt.Value = 0
                loc_oTxt.Refresh()
            ELSE
                SELECT TmpDisp
                loc_nRegDisp = RECNO()
                loc_nQtdUti  = 0
                SUM Utilizar TO loc_nQtdUti
                IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
                    GO loc_nRegDisp IN TmpDisp
                ENDIF

                IF loc_nQtdUti > TmpFinal.Saldo
                    MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
                        "Pedida!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = 0
                    loc_oTxt.Refresh()
                ELSE
                    THIS.cnt_4c_Container2.txt_4c_QtSelec.Value = loc_nQtdUti
                    THIS.cnt_4c_Container2.txt_4c_QtSelec.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispProdutoUtilizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DispGrupoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
    * grd_4c_DispGrupo (Container5), emulado por ENTER/TAB.
    *--------------------------------------------------------------------------
    PROCEDURE DispGrupoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDispGrupoUtilizar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDispGrupoUtilizar - Transcricao de SIGPRGLP.Container5.
    * GradeDisp.Column5.Text1.Valid. Mesma regra do Container2 (Disponivel na
    * linha + total pedido), mas o total pedido eh TmpFinal.Saldo -
    * TmpFinal.Estoque (o Container5 ja mostra so o saldo AINDA nao coberto
    * por estoque - ver BtnSelEstoqueClick).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDispGrupoUtilizar()
        LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro

        TRY
            IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
                RETURN
            ENDIF

            loc_oTxt = THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1

            IF loc_oTxt.Value > TmpDisp.Disps
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde " + ;
                    "Disponivel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oTxt.Value = 0
                loc_oTxt.Refresh()
            ELSE
                IF loc_oTxt.Value < 0
                    MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = 0
                    loc_oTxt.Refresh()
                ELSE
                    SELECT TmpDisp
                    loc_nRegDisp = RECNO()
                    loc_nQtdUti  = 0
                    SUM Utilizar TO loc_nQtdUti
                    IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
                        GO loc_nRegDisp IN TmpDisp
                    ENDIF

                    IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
                        MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde " + ;
                            "Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oTxt.Value = 0
                        loc_oTxt.Refresh()
                    ELSE
                        THIS.cnt_4c_Container5.txt_4c_QtSelec.Value = loc_nQtdUti
                        THIS.cnt_4c_Container5.txt_4c_QtSelec.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispGrupoUtilizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DispGrupoUtilizarLostFocus - Transcricao de SIGPRGLP.Container5.
    * GradeDisp.Column5.Text1.LostFocus: com Enter, desce uma linha na grade
    * (mesmo padrao do "{DNARROW}" ja usado em PedraSubstitutoLostFocus).
    *--------------------------------------------------------------------------
    PROCEDURE DispGrupoUtilizarLostFocus()
        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF
        THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - botao "Processar" (SIGPRGLP.Processar.Click).
    * Efetiva a geracao das Ordens de Producao/Reserva Automatica a partir
    * dos cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/TmpLinha/
    * SelPedra) ja preparados pelo form pai (FormSigPrGl2) e avo
    * (FormSigPrGlo). Este metodo so ORQUESTRA: repassa ao BO os dois
    * campos que o Init legado lia direto do avo ("_Prev"/"_DtGera" =
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao) e
    * o tipo de geracao de OP (Container1 do avo), e delega toda a gravacao
    * a SigPrGlpBO.Processar(), que transcreve o Click legado (1637 linhas
    * no dump original).
    *
    * THIS.this_oParentForm eh o FormSigPrGl2 (pai direto - "Operacoes
    * Selecionadas"); THIS.this_oParentForm.this_oParentForm eh o
    * FormSigPrGlo (avo - "Processamento de O.P."), que tem o
    * cnt_4c_Previsao e o cnt_4c_Container1.txt_4c_TpGOp.
    *
    * Release() fica FORA do TRY (regra #1 - liberar o proprio form de
    * dentro do bloco derrubaria a pilha de execucao dentro dele), mesmo
    * padrao ja usado em BtnCancelarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF !USED("TmpFinal") OR RECCOUNT("TmpFinal") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- FormParaBO sobe os parametros de modo que o Init legado le
                *-- do form avo (_Prev/_DtGera/_lcTpGOp/GerPorTp) + o SigKey.
                *-- Devolvendo .F. ele JA exibiu a causa - processar sem data
                *-- de previsao/geracao gravaria O.P. com data em branco.
                IF THIS.FormParaBO()
                    loc_lSucesso = THIS.this_oBusinessObject.Processar()

                    IF loc_lSucesso
                        MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
                            "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
                            " gerada.", "Confirmar")
                        loc_lFechar = .T.
                    ELSE
                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        IF loc_lFechar
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
    * #117/#147). O legado escreve "Report Form SigReGlp Preview NoConsole"
    * na forma BARE, que faz o VFP9 procurar o FRX no diretorio CORRENTE em
    * vez de gc_4c_CaminhoReports.
    *
    * O helper resolve o caminho, recusa com mensagem clara quando o FRX
    * nao existe, evita preview vazio, e isola SET POINT/SEPARATOR/
    * REPORTBEHAVIOR - os FRX legado Fortyus foram desenhados com
    * POINT="." e REPORTBEHAVIOR 80; no modo 90 os campos numericos saem
    * como asteriscos. No fim restaura o menu principal, que o preview
    * corrompe.
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_lProsseguir, loc_oErroMenu
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_lProsseguir = .T.
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            loc_cPointOrig    = SET("POINT")
            loc_cSepOrig      = SET("SEPARATOR")
            loc_nBehaviorOrig = SET("REPORTBEHAVIOR")

            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
                CASE par_cModo = "PREVIEW"
                    REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                CASE par_cModo = "PRINTER_PROMPT"
                    REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                CASE par_cModo = "PRINTER"
                    REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
            ENDCASE

            SET POINT TO (loc_cPointOrig)
            SET SEPARATOR TO (loc_cSepOrig)
            SET REPORTBEHAVIOR (loc_nBehaviorOrig)

            *-- O preview abre toolbar propria e corrompe o cache visual do
            *-- _MSYSMENU: sem este bloco os popups do menu principal voltam
            *-- encolhidos depois de fechar o preview (mesmo fix do
            *-- FormBase.Destroy)
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH TO loc_oErroMenu
                *-- CriarMenuPrincipal fora de escopo (harness de teste roda o
                *-- form sem menu.prg carregado). O relatorio ja foi entregue
                *-- e nao ha menu para restaurar - nada a reportar ao usuario.
            ENDTRY
        ENDIF

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FINAL - funis de carga, de mapeamento Form <-> BO e de
    * habilitacao da superficie editavel.
    *
    * SIGPRGLP eh form OPERACIONAL FLAT: o SCX legado nao tem PageFrame
    * Lista/Dados, nao tem frmcadastro nem a barra CRUD (Grupo_Op), e por
    * isso nao existem aqui os botoes Salvar/Buscar/Encerrar do padrao de
    * cadastro - o dump inteiro nao cita btnSalvar/btnGravar/mGravaDados.
    * O botao de acao eh "Processar" (SIGPRGLP.Processar.Click ->
    * BtnProcessarClick) e o de saida eh "Sair" (SIGPRGLP.Cancelar.Click ->
    * BtnCancelarClick). Criar Salvar/Buscar/Encerrar aqui seria INVENTAR
    * superficie que o legado nao tem (viola o PILAR 1).
    *
    * O que esta tela tem de verdade - e eh o que os metodos abaixo
    * consolidam num ponto unico - eh:
    *   (a) a grade principal ligada a TmpFinal            -> CarregarLista
    *   (b) os parametros de modo que o Init legado le do
    *       form AVO (FormSigPrGlo) e entrega ao
    *       processamento (_Prev/_DtGera/_lcTpGOp/GerPorTp) -> FormParaBO
    *   (c) Caption + totais do rodape + rotulo da
    *       observacao, derivados do BO e de TmpFinal       -> BOParaForm
    *   (d) o liga/desliga em bloco da tela enquanto um
    *       painel flutuante esta aberto                    -> HabilitarCampos
    *   (e) o estado inicial dos botoes de acao             -> AjustarBotoesPorModo
    *   (f) a limpeza dos campos de exibicao quando nao ha
    *       item corrente                                   -> LimparCampos
    *
    * ESCOPO: CarregarLista, HabilitarCampos e AjustarBotoesPorModo sao
    * PUBLIC (chamados de fora da classe pelo harness de teste e por
    * BINDEVENT, onde metodo PROTECTED falha em SILENCIO - CLAUDE.md regra
    * #3). Ja FormParaBO, BOParaForm e LimparCampos sao PROTECTED porque o
    * FormBase os declara assim (formbase.prg:276-285) e VFP9 NAO permite
    * ALARGAR escopo herdado: medido em 2026-09-29, omitir o PROTECTED aqui
    * faz PEMSTATUS devolver .T. e a chamada externa estourar mesmo assim
    * com "Property BOPARAFORM is not found". Sao chamados por THIS. de
    * dentro da classe (BtnProcessarClick -> FormParaBO; CarregarLista e
    * ItemProduzirLostFocus -> BOParaForm), que eh o contrato do FormBase.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Funil UNICO de (re)carga da grade principal
    * (grd_4c_Itens / GradeItens do legado, RecordSource = TmpFinal).
    *
    * Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21a): o
    * legado sempre fecha com "Go Top" + ".Refresh" e eh isso que este metodo
    * reproduz, em TODO caminho que mexe em TmpFinal (baixa de estoque por
    * produto, por conta, e o retorno dos paineis flutuantes).
    *
    * O rebind so acontece quando o RecordSource NAO esta mais em TmpFinal -
    * reatribuir RecordSource faz o VFP recalcular Column.Width para o default
    * 90 e zerar Header1.Caption (Problema 48), por isso o rebind passa por
    * LigarGradeItens(), que repoe as tres coisas na ordem canonica
    * (RecordSource -> ControlSource -> ColumnOrder -> Width -> Header).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("TmpFinal")
                *-- Os cursores de trabalho sao recebidos prontos do form pai
                *-- na DataSession compartilhada; sem eles nao ha o que exibir
                THIS.LimparCampos()
                MsgAviso("Os itens da pr" + CHR(233) + "via n" + CHR(227) + "o foram recebidos " + ;
                    "da tela de Processamento de O.P.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) != "TMPFINAL"
                    THIS.LigarGradeItens()
                ENDIF

                SELECT TmpFinal
                GO TOP IN TmpFinal
                THIS.grd_4c_Itens.Refresh()

                *-- Totais do rodape + Caption + rotulo da observacao
                THIS.BOParaForm()

                *-- Faixa do painel "Estoque Disponivel por Conta" (Container3)
                *-- no item que ficou corrente
                THIS.AplicarFaixaSaldoContas()
                THIS.cnt_4c_Container3.grd_4c_DispConta.Refresh()

                IF RECCOUNT("TmpFinal") = 0
                    THIS.LimparCampos()
                ENDIF

                loc_lSucesso = (RECCOUNT("TmpFinal") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarGradeItens - (Re)ligacao da grade principal a TmpFinal, transcrita
    * de "With .GradeItens ... EndWith" do Init legado.
    *
    * ORDEM OBRIGATORIA: RecordSource -> ControlSource -> ColumnOrder ->
    * Width -> Header1.Caption. RecordSource reseta Width e Caption, por isso
    * os dois vem por ULTIMO (Problema 48 / CLAUDE.md regra #35c). Os valores
    * sao os mesmos declarados em ConfigurarGradeItens (SCX legado).
    *
    * Column8 exibe uma EXPRESSAO (marcador "*" quando o item tem observacao),
    * nao uma coluna - igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarGradeItens()
        LOCAL loc_oErro

        TRY
            WITH THIS.grd_4c_Itens
                .ColumnCount  = 9
                .RecordSource = "TmpFinal"

                .Column1.ControlSource = "TmpFinal.Cpros"
                .Column2.ControlSource = "TmpFinal.CodCors"
                .Column3.ControlSource = "TmpFinal.Dopes"
                .Column4.ControlSource = "TmpFinal.Numes"
                .Column5.ControlSource = "TmpFinal.Saldo"
                .Column6.ControlSource = "TmpFinal.Produzir"
                .Column7.ControlSource = "TmpFinal.Estoque"
                .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
                .Column9.ControlSource = "TmpFinal.CodTams"

                .Column2.ColumnOrder = 6
                .Column3.ColumnOrder = 8
                .Column4.ColumnOrder = 9
                .Column5.ColumnOrder = 7
                .Column6.ColumnOrder = 4
                .Column7.ColumnOrder = 5
                .Column8.ColumnOrder = 2
                .Column9.ColumnOrder = 3

                .Column1.Width = 115
                .Column2.Width = 80
                .Column3.Width = 80
                .Column4.Width = 38
                .Column5.Width = 80
                .Column6.Width = 150
                .Column7.Width = 50
                .Column8.Width = 38
                .Column9.Width = 38

                .Column1.Header1.Caption = "Produto"
                .Column2.Header1.Caption = "Cor"
                .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column4.Header1.Caption = "C" + CHR(243) + "digo"
                .Column5.Header1.Caption = "Quantidade"
                .Column6.Header1.Caption = "Produzir"
                .Column7.Header1.Caption = "Estoque"
                .Column8.Header1.Caption = "Obs"
                .Column9.Header1.Caption = "Tam"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere para o Business Object tudo o que o
    * processamento le da TELA antes de efetivar as Ordens de Producao.
    *
    * Os campos editaveis desta tela vivem em CURSOR, nao em TextBox: a
    * coluna "Produzir" (TmpFinal.Produzir) e as colunas "Utilizar" dos dois
    * paineis de estoque estao ligadas por ControlSource e o BO le os
    * cursores diretamente - por isso o que sobe aqui sao os parametros de
    * MODO, que o Init legado le do form AVO (FormSigPrGlo, a tela de
    * Processamento de O.P.) e guarda em variaveis do proprio form:
    *
    *   _Prev    = Thisform.ParentForm.ParentForm.Container1.Get_Previsao.Value
    *   _DtGera  = ... Get_Geracao.Value
    *   _lcTpGOp = ... Get_TpGOp.Value
    *   GerPorTp = Not Empty(_lcTpGOp)
    *
    * mais o SigKey (CrSigCdPac.sigKeys), relido aqui porque o form pai pode
    * ter repopulado CrSigCdPac entre a abertura desta tela e o Processar.
    *
    * Retorna .F. (com mensagem) quando o avo nao esta acessivel - o
    * chamador ABORTA a gravacao nesse caso, em vez de processar com data de
    * previsao/geracao vazias.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oGlo, loc_cTpGOp, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                *-- "Thisform.SigKey = CrSigCdPac.sigKeys" do Init legado
                IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
                    THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
                ENDIF

                *-- Avo = FormSigPrGlo (pai deste form = FormSigPrGl2)
                loc_oGlo = .NULL.
                IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
                        PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
                    IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
                        loc_oGlo = THIS.this_oParentForm.this_oParentForm
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oGlo) != "O"
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar a tela de " + ;
                        "Processamento de O.P. (form av" + CHR(244) + ").", "Erro")
                ELSE
                    loc_cTpGOp = ALLTRIM(loc_oGlo.cnt_4c_Container1.txt_4c_TpGOp.Value)

                    THIS.this_oBusinessObject.this_dPrevisao      = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
                    THIS.this_oBusinessObject.this_dDataGeracao   = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
                    THIS.this_oBusinessObject.this_cTipoGeracaoOP = PADR(loc_cTpGOp, 10)
                    THIS.this_oBusinessObject.this_lGerPorTp      = !EMPTY(loc_cTpGOp)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Reflete na tela o estado do Business Object e dos cursores
    * de trabalho. Funil UNICO dos totais do rodape da grade principal, que o
    * legado recalcula em tres pontos diferentes com o MESMO codigo (Init,
    * Column6.LostFocus e o retorno dos paineis de estoque):
    *
    *   Select TmpFinal / Sum Saldo, Estoque, Produzir To lnSal, lnEst, lnPrz
    *   .Tot_Qtd.Value = lnSal / .Tot_Est.Value = lnEst / .Tot_Prz.Value = lnPrz
    *
    * SUM percorre o cursor inteiro e deixa o ponteiro em EOF - o RECNO() eh
    * guardado antes e restaurado depois, senao a linha corrente da grade
    * (e a faixa do Container3, que depende dela) se perde a cada total.
    *
    * Tambem repoe o Caption (Globalizacao x Reserva Automatica, do Init
    * legado) e o rotulo da observacao do item corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_cCaption, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                IF THIS.this_oBusinessObject.this_lReserva
                    loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ENDIF
                THIS.Caption = loc_cCaption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
            ENDIF

            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                loc_nSal   = 0
                loc_nEst   = 0
                loc_nPrz   = 0

                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz

                IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
                    GO loc_nRecno IN TmpFinal
                ENDIF

                THIS.txt_4c_TotQtd.Value = loc_nSal
                THIS.txt_4c_TotEst.Value = loc_nEst
                THIS.txt_4c_TotPrz.Value = loc_nPrz

                IF !EOF("TmpFinal")
                    THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + ;
                        "o do Item " + ALLTRIM(TmpFinal.Cpros)
                ENDIF
            ELSE
                THIS.txt_4c_TotQtd.Value = 0
                THIS.txt_4c_TotEst.Value = 0
                THIS.txt_4c_TotPrz.Value = 0
            ENDIF

            THIS.txt_4c_TotQtd.Refresh()
            THIS.txt_4c_TotEst.Refresh()
            THIS.txt_4c_TotPrz.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Liga/desliga em bloco a superficie de trabalho da
    * tela (os 5 botoes de acao, a grade principal e o painel de estoque por
    * conta do rodape), transcrito dos blocos "With ThisForm / .Processar.
    * Enabled = .f. / ... / EndWith" que o legado repete no Click de cada
    * botao que abre um painel flutuante, e do bloco espelhado (.t.) no
    * fechamento de cada painel.
    *
    * par_lIncluirSelEstoque controla se o botao "Estoques" entra no bloco:
    * ele so existe para quem tem o acesso PRIORIDADE (ver
    * AjustarBotoesPorModo), entao religa-lo sem criterio devolveria um
    * botao que o usuario nao deveria ter - o legado, pelo mesmo motivo, o
    * inclui no bloco do painel de estoque por conta e o omite nos demais.
    *
    * "Sair" (cmd_4c_Cancelar) entra no bloco porque o legado o desabilita
    * junto: com um painel aberto, a saida se da pelo OK/Sair do painel.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar, par_lIncluirSelEstoque)
        LOCAL loc_lLigar, loc_oErro
        loc_lLigar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            THIS.cmd_4c_Processar.Enabled  = loc_lLigar
            THIS.cmd_4c_Cancelar.Enabled   = loc_lLigar
            THIS.cmd_4c_TotLinha.Enabled   = loc_lLigar
            THIS.cmd_4c_Pedras.Enabled     = loc_lLigar
            THIS.cmd_4c_Disponivel.Enabled = loc_lLigar

            IF VARTYPE(par_lIncluirSelEstoque) = "L" AND par_lIncluirSelEstoque
                THIS.cmd_4c_SelEstoque.Enabled = loc_lLigar
            ENDIF

            THIS.cnt_4c_Container3.Enabled = loc_lLigar
            THIS.grd_4c_Itens.Enabled      = loc_lLigar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Estado inicial dos botoes de acao, conforme as
    * regras que o Init legado aplica uma a uma:
    *
    *   Requisicoes  - "ThisForm.Pedras.Enabled = .F." e so volta a .T. com
    *                  as QUATRO operacoes de transferencia preenchidas em
    *                  SigCdPam (DopEmphs/DopReqcs/DopPedcs/DopComps) E fora
    *                  da Reserva Automatica;
    *   Estoques     - nasce desligado no SCX e so liga com
    *                  fChecaAcesso('SIGPRGLO','PRIORIDADE');
    *   coluna
    *   Produzir     - "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly',
    *                  .t.)" - sem operacao de transferencia de reserva
    *                  configurada a grade inteira fica somente-leitura.
    *
    * As demais acoes (Processar/Total-Linhas/Disponiveis/Relatorio) e a
    * propria grade dependem de haver item em TmpFinal - processar ou
    * imprimir previa vazia nao faz sentido. "Sair" fica SEMPRE disponivel:
    * eh a unica saida da tela (o form legado tem TitleBar=0 e
    * ControlBox=.F.).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemItens, loc_lPedras, loc_oErro

        TRY
            loc_lTemItens = USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0

            loc_lPedras = .F.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lPedras = !EMPTY(THIS.this_oBusinessObject.this_cPamDopEmphs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopReqcs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopPedcs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopComps) AND ;
                              !THIS.this_oBusinessObject.this_lReserva
            ENDIF

            THIS.cmd_4c_Pedras.Enabled       = loc_lPedras AND loc_lTemItens
            THIS.cmd_4c_SelEstoque.Enabled   = loc_lTemItens AND fChecaAcesso("SIGPRGLO", "PRIORIDADE")
            THIS.cmd_4c_Processar.Enabled    = loc_lTemItens
            THIS.cmd_4c_TotLinha.Enabled     = loc_lTemItens
            THIS.cmd_4c_Disponivel.Enabled   = loc_lTemItens
            THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemItens
            THIS.grd_4c_Itens.Enabled        = loc_lTemItens
            THIS.cnt_4c_Container3.Enabled   = loc_lTemItens

            THIS.cmd_4c_Cancelar.Enabled     = .T.

            *-- "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)".
            *-- O ReadOnly do Grid propaga para as colunas, entao este bloco
            *-- fica DEPOIS de qualquer ajuste de coluna (regra #18).
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                    EMPTY(THIS.this_oBusinessObject.this_cPamTransfRes)
                THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os campos de EXIBICAO da tela (totais do rodape,
    * totais e descricoes do painel de estoque por conta, quantidades dos
    * paineis flutuantes, rotulo da observacao e a foto do produto).
    *
    * Nao toca nos CURSORES: TmpFinal/TmpSaldo/TmpSaldG pertencem a
    * DataSession compartilhada com o form pai, que os calculou - apagar o
    * conteudo deles aqui destruiria o trabalho do chamador. Chamado quando
    * nao ha item corrente (previa vazia ou cursores nao recebidos), para a
    * tela nao exibir numeros e a foto do ultimo item consultado.
    *
    * CLEAR RESOURCES antes de soltar a Picture: o arquivo TempGlb.jpg eh
    * reescrito a cada troca de linha e fica travado enquanto o VFP mantem a
    * imagem em cache (mesmo motivo do CLEAR RESOURCES do
    * GradeItensAfterRowColChange).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_TotQtd.Value = 0
            THIS.txt_4c_TotEst.Value = 0
            THIS.txt_4c_TotPrz.Value = 0
            THIS.txt_4c_TotQtd.Refresh()
            THIS.txt_4c_TotEst.Refresh()
            THIS.txt_4c_TotPrz.Refresh()

            THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"

            CLEAR RESOURCES
            THIS.img_4c_ImgFigJpg.Picture = ""
            THIS.img_4c_ImgFigJpg.Visible = .F.

            WITH THIS.cnt_4c_Container3
                .txt_4c_TotQtd.Value    = 0
                .txt_4c_TotEst.Value    = 0
                .txt_4c_TotPrz.Value    = 0
                .txt_4c_GetDGrupo.Value = ""
                .txt_4c_GetDConta.Value = ""
                .lbl_4c_Label1.Caption  = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            WITH THIS.cnt_4c_Container2
                .txt_4c_QtPedida.Value = 0
                .txt_4c_QtSelec.Value  = 0
            ENDWITH

            WITH THIS.cnt_4c_Container5
                .txt_4c_QtPedida.Value  = 0
                .txt_4c_QtSelec.Value   = 0
                .txt_4c_GetDGrupo.Value = ""
                .txt_4c_GetDConta.Value = ""
            ENDWITH

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem Visible=.F.). Os containers flutuantes do legado
    * (Container1/Container2/Container4/Container5 - cada um declara
    * "Visible = .F." no dump e eh alternado pelos botoes de acao Pedras/
    * SelEstoque/TotLinha/Disponivel, adicionados na Fase 4) sao FILTRADOS
    * aqui: tornar visivel incondicionalmente destruiria esse comportamento
    * (CLAUDE.md - regra de Containers Flutuantes em forms OPERACIONAL).
    * Container3 (Estoque Disponivel por conta, rodape) NAO entra no
    * filtro - o dump nao declara Visible para ele, ou seja permanece
    * visivel por padrao, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER1", ;
                        "CNT_4C_CONTAINER2", "CNT_4C_CONTAINER4", "CNT_4C_CONTAINER5")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGlpBO.prg):
*============================================================================
* SigPrGlpBO.prg - Business Object para Previa da Globalizacao (SIGPRGLP)
*
* Form OPERACIONAL (SIGPRGLP / FormSigPrGlp): tela de PREVIA/CONFIRMACAO
* do processamento disparado pelo SigPrGlo (Processamento de O.P.) ou pela
* Reserva Automatica - recebe do chamador (via Init legado com LParameters
* _ParentForm, _Data, _ReservaAuto, pCnx, _nGerEmphPdr, _autom, _numeroOp)
* os cursores temporarios ja calculados (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
* TmpLinha/SelPedra) e, ao confirmar (botao Processar), efetiva a geracao
* das Ordens de Producao gravando em SigOpPic/SigPdMvf/SigCdNec/SigMvCab/
* SigMvHst/SigBxEst/SigMvItn/SigMvIts/SigCdNei.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/processamento (Processar/CarregarDoCursor)
*============================================================================

DEFINE CLASS SigPrGlpBO AS BusinessBase

    *==========================================================================
    * Flags/parametros de modo - equivalem aos parametros recebidos no Init
    * do form legado (LParameters _ParentForm, _Data, _ReservaAuto, pCnx,
    * _nGerEmphPdr, _autom, _numeroOp)
    *==========================================================================
    this_lReserva      = .F.        && _ReservaAuto - .T. = "Previa da Reserva Automatica"
    this_nEmphPdr      = 0          && _nGerEmphPdr - empresa padrao de geracao (ThisForm.Emphpdr)
    this_lAutomatico   = .F.        && _autom - processamento automatico (sem interacao)
    this_nNumeroDaOp   = 0          && _numeroOp - numero da O.P. manual (ThisForm.Numerodaop)
    this_cSigKey       = SPACE(3)   && CrSigCdPac.sigKeys - chave de sistema (ThisForm.SigKey)

    *==========================================================================
    * Parametros do sistema (SigCdPam), referenciados ao longo do
    * processamento (Processar/validacoes) - equivalente ao cursor
    * crSigCdPam do Init legado, aqui recarregado para o BO nao depender
    * do form SigPrGlo que o chamou
    *==========================================================================
    this_cPamDopEmphs   = SPACE(20)  && SigCdPam.dopemphs
    this_cPamDopReqcs   = SPACE(20)  && SigCdPam.dopreqcs
    this_cPamDopPedcs   = SPACE(20)  && SigCdPam.doppedcs
    this_cPamDopComps   = SPACE(20)  && SigCdPam.dopcomps
    this_cPamTransfRes  = SPACE(20)  && SigCdPam.transfres
    this_cPamDoppPads   = SPACE(20)  && SigCdPam.dopppads
    this_cPamDopTrfCps  = SPACE(20)  && SigCdPam.doptrfcps
    this_cPamGruReservs = SPACE(10)  && SigCdPam.grureservs
    this_cPamConReservs = SPACE(10)  && SigCdPam.conreservs
    this_nPamAgrupEmph  = 0          && SigCdPam.agrupemph
    this_cPamOuros      = SPACE(14)  && SigCdPam.ouros
    this_cPamTpOpEntAus = SPACE(15)  && SigCdPam.tpopentaus
    this_cPamDopEntAus  = SPACE(20)  && SigCdPam.dopentaus
    this_nPamAutComps   = 0          && SigCdPam.autcomps
    this_nPamGlobAutos  = 0          && SigCdPam.globautos
    this_cPamGruConfs   = SPACE(10)  && SigCdPam.gruconfs
    this_cPamConConfs   = SPACE(10)  && SigCdPam.conconfs

    *==========================================================================
    * Parametros de configuracao (SigCdPac) lidos pelo Processar
    *==========================================================================
    this_cPacOpPdCompra = SPACE(20)  && SigCdPac.oppdcompra - operacao de pedido de compra de acabado
    this_nPacOpZers     = 0          && SigCdPac.opzers
    this_nPacAgrupReqs  = 0          && SigCdPac.agrupreqs - 1 = agrupa requisicao por fornecedor + prazo

    *==========================================================================
    * DbParam - o legado monta um cursor "DBParam" de UMA linha no Click do
    * SigPrGlo (grandparent) e o SIGPRGLP le tres colunas dele:
    *   CodTgOps = _lcTpGOp (tipo de geracao da OP escolhido no Container1)
    *   OpZers   = Iif(GerPorTp, CrTmpTpGop.OpZers, CrSigCdPac.OpZers)
    *   EntPes   = Iif(GerPorTp, CrTmpTpGop.EntPes, 0)
    * (CrTmpTpGop = SigInTgo filtrado pelo tipo escolhido.)
    * O cursor nao foi portado (SigPrGloBO registra "DBParam criado, nunca
    * lido"), entao as tres colunas viram properties deste BO, resolvidas em
    * CarregarDbParam() a partir do tipo de geracao / GerPorTp que o FORM le
    * do grandparent (FormSigPrGlo), exatamente como o legado fazia.
    *==========================================================================
    this_cTipoGeracaoOP = SPACE(10)  && _lcTpGOp (grandparent SigPrGloBO.this_cTipoGeracaoOP)
    this_lGerPorTp      = .F.        && ThisForm.GerPorTp do grandparent
    this_cDbCodTgOps    = SPACE(10)  && DBParam.CodTgOps
    this_nDbOpZers      = 0          && DBParam.OpZers
    this_nDbEntPes      = 0          && DBParam.EntPes

    *==========================================================================
    * Previsao de entrega / data de geracao - no legado vem de
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao
    * (FormSigPrGlo.cnt_4c_Previsao.txt_4c_Previsao/txt_4c_Geracao). O FORM
    * repassa para ca antes de chamar Processar().
    *==========================================================================
    this_dPrevisao      = {}         && _Prev
    this_dDataGeracao   = {}         && _DtGera

    *==========================================================================
    * Resultado do processamento
    *==========================================================================
    this_cMensagemErro   = ""        && ultima mensagem de erro (o form espelha)
    this_nNumeroOpGerada = 0         && _Nump - numero da OP efetivada por Processar()

    *==========================================================================
    * Colunas da O.P. gerada (SigOpPic) - this_cTabela/this_cCampoChave
    * definidos no Init - registro efetivado por THIS.Processar() (Fase 2)
    *==========================================================================
    this_dOpDataEs      = {}         && dataes
    this_dOpDataPs      = {}         && dataps
    this_cOpDopes       = SPACE(20)  && dopes
    this_cOpDopps       = SPACE(20)  && dopps
    this_cOpEmps        = SPACE(3)   && emps
    this_nOpNops        = 0          && nops
    this_nOpNumes       = 0          && numes
    this_nOpNumps       = 0          && numps
    this_cOpObss        = ""         && obss (memo)
    this_nOpQtds        = 0          && qtds
    this_dOpDataTrans   = {}         && datatrans
    this_cOpLocals      = SPACE(10)  && locals
    this_nOpNtrans      = 0          && ntrans
    this_cOpCpros       = SPACE(14)  && cpros
    this_cOpEmpds       = SPACE(3)   && empds
    this_dOpDtGeras     = {}         && dtgeras
    this_nOpSeqDivs     = 0          && seqdivs
    this_cOpCodCors     = SPACE(4)   && codcors
    this_cOpCodTams     = SPACE(4)   && codtams
    this_lOpDivs        = .F.        && divs (bit)
    this_lOpImprs       = .F.        && imprs (bit)
    this_cOpUsuars      = SPACE(10)  && usuars
    this_nOpNopMaes     = 0          && nopmaes
    this_nOpPesos       = 0          && pesos
    this_cOpCidChaves   = SPACE(20)  && cidchaves (PK)
    this_nOpCodBarras   = 0          && codbarras
    this_nOpQtdCpnts    = 0          && qtdcpnts
    this_nOpQtdTubos    = 0          && qtdtubos
    this_lOpIImprs      = .F.        && iimprs (bit)
    this_cOpMoedas      = SPACE(3)   && moedas
    this_nOpUnits       = 0          && units
    this_dOpDtFunds     = {}         && dtfunds
    this_nOpNFunds      = 0          && nfunds
    this_cOpDpros       = SPACE(65)  && dpros
    this_cOpEmpDNps     = SPACE(33)  && empdnps
    this_cOpEmpDopNops  = SPACE(33)  && empdopnops
    this_cOpEmpDopNums  = SPACE(29)  && empdopnums
    this_cOpNotas       = SPACE(6)   && notas
    this_cOpCodTGops    = SPACE(10)  && codtgops
    this_nOpCitens      = 0          && citens

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object configurando a tabela/chave de
    * referencia (SigOpPic/cidchaves - registro efetivado pelo botao
    * Processar do form legado) e carrega os parametros do sistema
    * (SigCdPam) usados na validacao/processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopemphs, dopreqcs, doppedcs, dopcomps, transfres, " + ;
                    "dopppads, doptrfcps, grureservs, conreservs, agrupemph, " + ;
                    "ouros, tpopentaus, dopentaus, autcomps " + ;
                    "FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamTransfRes  = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cPamDoppPads   = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (SigOpPic.cidchaves) do
    * registro corrente, usada por RegistrarAuditoria()
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOpCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as properties this_* (registro de SigOpPic
    * efetivado por THIS.Processar()) a partir do cursor informado.
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_dOpDataEs     = TratarNulo(dataes,     {})
                THIS.this_dOpDataPs     = TratarNulo(dataps,     {})
                THIS.this_cOpDopes      = TratarNulo(dopes,      SPACE(20))
                THIS.this_cOpDopps      = TratarNulo(dopps,      SPACE(20))
                THIS.this_cOpEmps       = TratarNulo(emps,       SPACE(3))
                THIS.this_nOpNops       = TratarNulo(nops,       0)
                THIS.this_nOpNumes      = TratarNulo(numes,      0)
                THIS.this_nOpNumps      = TratarNulo(numps,      0)
                THIS.this_cOpObss       = TratarNulo(obss,       "")
                THIS.this_nOpQtds       = TratarNulo(qtds,       0)
                THIS.this_dOpDataTrans  = TratarNulo(datatrans,  {})
                THIS.this_cOpLocals     = TratarNulo(locals,     SPACE(10))
                THIS.this_nOpNtrans     = TratarNulo(ntrans,     0)
                THIS.this_cOpCpros      = TratarNulo(cpros,      SPACE(14))
                THIS.this_cOpEmpds      = TratarNulo(empds,      SPACE(3))
                THIS.this_dOpDtGeras    = TratarNulo(dtgeras,    {})
                THIS.this_nOpSeqDivs    = TratarNulo(seqdivs,    0)
                THIS.this_cOpCodCors    = TratarNulo(codcors,    SPACE(4))
                THIS.this_cOpCodTams    = TratarNulo(codtams,    SPACE(4))
                THIS.this_lOpDivs       = TratarNulo(divs,       .F.)
                THIS.this_lOpImprs      = TratarNulo(imprs,      .F.)
                THIS.this_cOpUsuars     = TratarNulo(usuars,     SPACE(10))
                THIS.this_nOpNopMaes    = TratarNulo(nopmaes,    0)
                THIS.this_nOpPesos      = TratarNulo(pesos,      0)
                THIS.this_cOpCidChaves  = TratarNulo(cidchaves,  SPACE(20))
                THIS.this_nOpCodBarras  = TratarNulo(codbarras,  0)
                THIS.this_nOpQtdCpnts   = TratarNulo(qtdcpnts,   0)
                THIS.this_nOpQtdTubos   = TratarNulo(qtdtubos,   0)
                THIS.this_lOpIImprs     = TratarNulo(iimprs,     .F.)
                THIS.this_cOpMoedas     = TratarNulo(moedas,     SPACE(3))
                THIS.this_nOpUnits      = TratarNulo(units,      0)
                THIS.this_dOpDtFunds    = TratarNulo(dtfunds,    {})
                THIS.this_nOpNFunds     = TratarNulo(nfunds,     0)
                THIS.this_cOpDpros      = TratarNulo(dpros,      SPACE(65))
                THIS.this_cOpEmpDNps    = TratarNulo(empdnps,    SPACE(33))
                THIS.this_cOpEmpDopNops = TratarNulo(empdopnops, SPACE(33))
                THIS.this_cOpEmpDopNums = TratarNulo(empdopnums, SPACE(29))
                THIS.this_cOpNotas      = TratarNulo(notas,      SPACE(6))
                THIS.this_cOpCodTGops   = TratarNulo(codtgops,   SPACE(10))
                THIS.this_nOpCitens     = TratarNulo(citens,     0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Efetiva a O.P. gravando o registro em SigOpPic
    * (cidchaves eh a PK Fortyus - nunca gravar vazia, senao o proximo
    * registro colide no indice unico sigoppic_cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cOpCidChaves))
                THIS.this_cOpCidChaves = PADR(fUniqueIds(), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPic (dataes, dataps, dopes, dopps, emps, nops, numes, numps,
                    obss, qtds, datatrans, locals, ntrans, cpros, empds, dtgeras, seqdivs,
                    codcors, codtams, divs, imprs, usuars, nopmaes, pesos, cidchaves,
                    codbarras, qtdcpnts, qtdtubos, iimprs, moedas, units, dtfunds, nfunds,
                    dpros, empdnps, empdopnops, empdopnums, notas, codtgops, citens)
                VALUES (
                    <<FormatarDataSQL(THIS.this_dOpDataEs)>>,
                    <<FormatarDataSQL(THIS.this_dOpDataPs)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopes), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopps), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmps), 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNops, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNumps, 0)>>,
                    <<EscaparSQL(THIS.this_cOpObss)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtds, 3)>>,
                    <<FormatarDataSQL(THIS.this_dOpDataTrans)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpLocals), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNtrans, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCpros), 14))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmpds), 3))>>,
                    <<FormatarDataSQL(THIS.this_dOpDtGeras)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpSeqDivs, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodCors), 4))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTams), 4))>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpDivs, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpImprs, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpUsuars), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNopMaes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpPesos, 3)>>,
                    <<EscaparSQL(PADR(THIS.this_cOpCidChaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpCodBarras, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtdCpnts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtdTubos, 3)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpIImprs, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpMoedas), 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpUnits, 6)>>,
                    <<FormatarDataSQL(THIS.this_dOpDtFunds)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNFunds, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDpros), 65))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDNps, 33))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDopNops, 33))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDopNums, 29))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpNotas), 6))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTGops), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpCitens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigOpPic:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro de SigOpPic identificado por cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPic
                SET dataes     = <<FormatarDataSQL(THIS.this_dOpDataEs)>>,
                    dataps     = <<FormatarDataSQL(THIS.this_dOpDataPs)>>,
                    dopes      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopes), 20))>>,
                    dopps      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopps), 20))>>,
                    emps       = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmps), 3))>>,
                    nops       = <<FormatarNumeroSQL(THIS.this_nOpNops, 0)>>,
                    numes      = <<FormatarNumeroSQL(THIS.this_nOpNumes, 0)>>,
                    numps      = <<FormatarNumeroSQL(THIS.this_nOpNumps, 0)>>,
                    obss       = <<EscaparSQL(THIS.this_cOpObss)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nOpQtds, 3)>>,
                    datatrans  = <<FormatarDataSQL(THIS.this_dOpDataTrans)>>,
                    locals     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpLocals), 10))>>,
                    ntrans     = <<FormatarNumeroSQL(THIS.this_nOpNtrans, 0)>>,
                    cpros      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCpros), 14))>>,
                    empds      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmpds), 3))>>,
                    dtgeras    = <<FormatarDataSQL(THIS.this_dOpDtGeras)>>,
                    seqdivs    = <<FormatarNumeroSQL(THIS.this_nOpSeqDivs, 0)>>,
                    codcors    = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodCors), 4))>>,
                    codtams    = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTams), 4))>>,
                    divs       = <<FormatarNumeroSQL(IIF(THIS.this_lOpDivs, 1, 0), 0)>>,
                    imprs      = <<FormatarNumeroSQL(IIF(THIS.this_lOpImprs, 1, 0), 0)>>,
                    usuars     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpUsuars), 10))>>,
                    nopmaes    = <<FormatarNumeroSQL(THIS.this_nOpNopMaes, 0)>>,
                    pesos      = <<FormatarNumeroSQL(THIS.this_nOpPesos, 3)>>,
                    codbarras  = <<FormatarNumeroSQL(THIS.this_nOpCodBarras, 0)>>,
                    qtdcpnts   = <<FormatarNumeroSQL(THIS.this_nOpQtdCpnts, 0)>>,
                    qtdtubos   = <<FormatarNumeroSQL(THIS.this_nOpQtdTubos, 3)>>,
                    iimprs     = <<FormatarNumeroSQL(IIF(THIS.this_lOpIImprs, 1, 0), 0)>>,
                    moedas     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpMoedas), 3))>>,
                    units      = <<FormatarNumeroSQL(THIS.this_nOpUnits, 6)>>,
                    dtfunds    = <<FormatarDataSQL(THIS.this_dOpDtFunds)>>,
                    nfunds     = <<FormatarNumeroSQL(THIS.this_nOpNFunds, 0)>>,
                    dpros      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDpros), 65))>>,
                    empdnps    = <<EscaparSQL(PADR(THIS.this_cOpEmpDNps, 33))>>,
                    empdopnops = <<EscaparSQL(PADR(THIS.this_cOpEmpDopNops, 33))>>,
                    empdopnums = <<EscaparSQL(PADR(THIS.this_cOpEmpDopNums, 29))>>,
                    notas      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpNotas), 6))>>,
                    codtgops   = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTGops), 10))>>,
                    citens     = <<FormatarNumeroSQL(THIS.this_nOpCitens, 0)>>
                WHERE cidchaves = <<EscaparSQL(ALLTRIM(THIS.this_cOpCidChaves))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigOpPic:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FASE 8 - PROCESSAMENTO (Processar / AtualizaPeso / GravaHis)
    *
    * Transcricao do Click do botao Processar do form legado
    * (SIGPRGLP.Processar.Click, tasks\task617\SigPrGlp_form_codigo_fonte.txt
    * linhas 4255-5893) e dos dois metodos auxiliares que ele usa
    * (SIGPRGLP.atualizapeso, linhas 2736-2773, e SIGPRGLP.gravahis, linhas
    * 2778-2843).
    *
    * EQUIVALENCIAS LEGADO -> MIGRADO (fixadas nesta fase):
    *   ThisForm.poDataMgr.SqlExecute(q, c)  -> THIS.ExecutarSQL(q, c, rotulo)
    *   ThisForm.poDataMgr.CursorQuery(...)  -> THIS.ConsultarTabela(...)
    *   ThisForm.poDataMgr.Update('crXxx')   -> THIS.PersistirCursor('crXxx', 'Xxx')
    *   ThisForm.poDataMgr.Commit()/RollBack -> SQLCOMMIT()/SQLROLLBACK()
    *   _Empr                                -> go_4c_Sistema.cCodEmpresa
    *   Usuar                                -> gc_4c_UsuarioLogado
    *   ThisForm.Sigkey                      -> THIS.this_cSigKey
    *   DbParam.<col>                        -> THIS.this_cDbCodTgOps /
    *                                           this_nDbOpZers / this_nDbEntPes
    *   MessageBox(...) + Return 0           -> THIS.this_cMensagemErro + aborto
    *
    * REGRA #1 (CLAUDE.md): nenhum RETURN dentro de TRY/CATCH. Todos os
    * "Return 0" do legado viram a bandeira PRIVATE loc_lAbortar, propagada
    * por EXIT em cascata nos SCAN/DO WHILE aninhados e testada com
    * IF !loc_lAbortar nos blocos seguintes - mesmo idioma de
    * SigPrGloBO.Processar().
    *
    * ESTADO COMPARTILHADO: o Click legado eh um procedimento UNICO com
    * variaveis Private/Local visiveis do inicio ao fim (_Nump, _Dope, _Nume,
    * _Citens, _TProd, _TPeso, ...). Aqui ele foi quebrado em metodos por
    * bloco para nao estourar o limite de codigo por procedimento do VFP9, e
    * essas variaveis sao declaradas PRIVATE em Processar() - continuam
    * visiveis nos metodos chamados, exatamente como no legado. NAO trocar
    * por LOCAL: os metodos de bloco deixariam de enxerga-las.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExecutarSQL - Substitui ThisForm.poDataMgr.SqlExecute(lcQuery, cursor).
    *
    * O legado testa "< 1" e aborta; aqui vale a convencao ja adotada no resto
    * do projeto (FormSigPrGlp.BtnConfirmarDispProdutoClick, linhas 3181/3393/
    * 3424): so "< 0" eh FALHA DE SQL. Zero linhas eh resultado legitimo e
    * segue o fluxo - o legado abortava tambem com zero linhas porque o
    * SqlExecute do Fortyus devolvia o numero de linhas, e varias dessas
    * consultas retornam zero por natureza (ex.: TmpOpi conferindo se o numero
    * da O.P. ja existe, que SO pode prosseguir com zero linhas).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        *-- O SqlExecute do Fortyus PRESERVA a area de trabalho selecionada:
        *-- o legado chama SqlExecute DENTRO de SCAN (ex.: dump 5139, no SCAN
        *-- de TmpPedra) sem reselecionar depois, e o ENDSCAN continua no
        *-- cursor certo. SQLEXEC(), ao contrario, SELECIONA o cursor de
        *-- resultado. Sem salvar/restaurar aqui, o SKIP implicito do ENDSCAN
        *-- cairia no cursor errado - erro silencioso de varredura.
        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - Substitui ThisForm.poDataMgr.CursorQuery(tabela,
    * cursorDestino, campoChave, valorChave [, camposRetorno]), helper do
    * gerenciador de dados Fortyus que NAO existe no sistema migrado.
    *
    * Vira um SELECT simples. O cursor resultante fica ABERTO (o legado le
    * campos dele logo em seguida, e com zero linhas o VFP devolve o valor em
    * branco do campo, sem erro - comportamento identico ao do legado).
    * Somente-leitura: quem precisa de INSERT/INDEX usa AbrirCursorTabela().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, ;
            par_uValorChave, par_cCampos)

        LOCAL loc_cCampos, loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        *-- Preserva a area de trabalho selecionada, como o CursorQuery do
        *-- Fortyus (o legado o chama DENTRO de SCAN - dump 5096, SCAN de
        *-- TmpEmpH - sem reselecionar depois). Ver nota em ExecutarSQL.
        loc_cAliasAnt = ALIAS()
        loc_cCampos = "*"
        IF VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos)
            loc_cCampos = par_cCampos
        ENDIF

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - Cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada.
    *
    * Equivale ao AddCursor('<tabela>', ...) do gerenciador Fortyus, que era
    * como os cursores crSigOpPic/crSigPdMvf/crSigCdNec/crSigCdNei/crSigMvCab/
    * crSigMvHst/crSigBxEst/crSigMvItn/crSigMvIts chegavam ao Click legado
    * ja com TODAS as colunas da tabela destino e em branco - por isso o
    * "Update('crXxx')" (TABLEUPDATE) do legado gravava o registro INTEIRO e
    * nunca esbarrava em coluna NOT NULL ausente.
    *
    * Reproduzir a estrutura completa (em vez de inferir a lista de campos
    * pelos Insert Into do legado) eh o que garante a regra #22 do CLAUDE.md:
    * toda coluna NOT NULL sem DEFAULT da tabela destino esta no cursor e,
    * portanto, no INSERT montado por PersistirCursor().
    *
    * Substitui o "Select <cursor> / Zap" do topo do Click legado por
    * USE IN + recriacao: ZAP em cursor de DataSession privada ja travou a
    * tela neste projeto (licao registrada na memoria do time), e o efeito
    * util - cursor vazio com a mesma estrutura - eh o mesmo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - Formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome). Sempre pelos
    * helpers canonicos do projeto (regra #5 do CLAUDE.md), que ja devolvem
    * COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - Substitui ThisForm.poDataMgr.Update('<cursor>') do
    * legado (TABLEUPDATE do cursor amarrado por AddCursor): grava em
    * <par_cTabela>, linha a linha, TODAS as colunas do cursor.
    *
    * Como AbrirCursorTabela() criou o cursor com a estrutura completa da
    * tabela, a lista de colunas do INSERT eh a lista de colunas da TABELA -
    * cobrindo por construcao toda coluna NOT NULL (regra #22), inclusive as
    * que nao aparecem em tela nem no dump do legado.
    *
    * Cursor inexistente ou vazio nao eh erro: o legado tambem chamava
    * Update() em cursor vazio (quando o ramo que o alimenta nao rodou) e
    * seguia adiante.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + ;
                LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ReservarSequencia - Forma de BLOCO do fGerUniqueKey legado.
    *
    * O GravaHis legado chama fGerUniqueKey com QUATRO argumentos
    * (fGerUniqueKey(Dtos(Datas),,,_nRegistro + 1)), reservando um bloco de N
    * numeros de uma vez e devolvendo o ULTIMO do bloco - dai
    * "_Inicio = _Reservado - _nRegistro". O fGerUniqueKey portado
    * (projeto\app\utils\functions.prg) tem UM parametro e emite UM numero,
    * entao o bloco eh reservado aqui, com o MESMO contador
    * (dbo.SIGSYSEQ) e a MESMA instrucao atomica que ele usa.
    *
    * Fallback: se a chave ainda nao existe em SIGSYSEQ (UPDATE afeta zero
    * linhas), delega N vezes ao proprio fGerUniqueKey, que sabe semear a
    * chave nova - assim nao se duplica a regra de semente aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ReservarSequencia(par_cChave, par_nQtd)
        LOCAL loc_cChave, loc_nQtd, loc_nRet, loc_nUltimo, loc_nI, loc_lManual

        loc_cChave  = ALLTRIM(TratarNulo(par_cChave, ""))
        loc_nQtd    = MAX(1, INT(TratarNulo(par_nQtd, 1)))
        loc_nUltimo = 0

        IF EMPTY(loc_cChave)
            RETURN 0
        ENDIF

        IF loc_nQtd = 1
            RETURN fGerUniqueKey(loc_cChave)
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "UPDATE SIGSYSEQ SET conteudo = conteudo + " + FormatarNumeroSQL(loc_nQtd, 0) + ;
            " OUTPUT inserted.conteudo AS novo" + ;
            " WHERE valor = " + EscaparSQL(loc_cChave), ;
            "cursor_4c_SeqBloco")

        IF loc_nRet > 0 AND USED("cursor_4c_SeqBloco") AND RECCOUNT("cursor_4c_SeqBloco") > 0
            GO TOP IN cursor_4c_SeqBloco
            loc_nUltimo = INT(TratarNulo(cursor_4c_SeqBloco.novo, 0))
        ENDIF

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        IF loc_lManual
            IF loc_nUltimo > 0
                = SQLCOMMIT(gnConnHandle)
            ELSE
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        *-- Chave ainda inexistente em SIGSYSEQ: emite um a um pelo
        *-- fGerUniqueKey, que cria a chave com a semente correta.
        IF loc_nUltimo = 0
            FOR loc_nI = 1 TO loc_nQtd
                loc_nUltimo = fGerUniqueKey(loc_cChave)
                IF loc_nUltimo = 0
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_nUltimo
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCompos - Reconstrucao de fBuscarCompos(poDataMgr, empDopNums,
    * cpros, citens, filtro), chamada uma unica vez no Click legado
    * (dump linha 4984) e cujo retorno GATEIA um ramo:
    *
    *     lcBusca = fBuscarCompos(ThisForm.poDataMgr, lcepn, TmpFinal.Cpros,
    *                             TmpFinal.citens, '')
    *     If !Empty(lcBusca)
    *         Select * from &lcBusca. into cursor crSigPrCpo READWRITE
    *     EndIf
    *     Select crSigPrCpo
    *     Scan ... crSigPrCpo.Mats / .Qtds / .Pesos / .Cpros
    *
    * ATENCAO - INCERTEZA DOCUMENTADA: o fonte original de fBuscarCompos NAO
    * existe no acervo (procurado em projeto\app\utils, Framework\ e nos dumps
    * de tasks\). O contrato abaixo foi deduzido de DUAS passagens do PROPRIO
    * Click legado que fazem a mesma busca de composicao a mao:
    *
    *   - linha 4579: composicao SUBSTITUIDA na O.P.
    *       Select a.*, b.cgrus From SigSubMv a inner join SigCdPro b
    *        on a.mats = b.cpros
    *       where a.empdopnums = ?lcepn and a.cpros = ?TmpFinal.CPros
    *         and a.citem2 = ?TmpFinal.citens
    *
    *   - linhas 5564-5581 (bloco automatico): a MESMA consulta em SigSubMv e,
    *       "If Reccount('TmpCompo') = 0", o fallback para a composicao PADRAO
    *       do produto em SigPrCpo.
    *
    * Dai: devolve o nome do cursor com a composicao SUBSTITUIDA quando ela
    * existe para (empdopnums, cpros, citem2) e, quando nao existe, o da
    * composicao PADRAO (SigPrCpo por Cpros). Devolve string VAZIA quando
    * nenhuma das duas traz linha - e eh isso que o "If !Empty(lcBusca)" do
    * legado testa. Os quatro campos consumidos a seguir (Mats, Qtds, Pesos,
    * Cpros) existem nas DUAS tabelas (conferido em docs/schema.sql).
    *
    * par_cFiltro eh transcrito como condicao adicional opcional - o unico
    * call site passa string vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarCompos(par_cEmpDopNums, par_cCpros, par_nCitens, par_cFiltro)
        LOCAL loc_cFiltro, loc_cSQL, loc_cRet

        loc_cRet = ""
        loc_cFiltro = ""
        IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
            loc_cFiltro = " AND (" + par_cFiltro + ")"
        ENDIF

        *-- 1) composicao SUBSTITUIDA na movimentacao (SigSubMv)
        loc_cSQL = "SELECT a.Mats, a.Cpros, a.Qtds, a.Pesos, a.CItens, a.Citem2, b.CGrus" + ;
            " FROM SigSubMv a INNER JOIN SigCdPro b ON a.Mats = b.CPros" + ;
            " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
            " AND a.CPros = " + EscaparSQL(ALLTRIM(par_cCpros)) + ;
            " AND a.Citem2 = " + FormatarNumeroSQL(par_nCitens, 0) + loc_cFiltro

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_CompoSub", "fBuscarCompos - SigSubMv")
            IF USED("cursor_4c_CompoSub") AND RECCOUNT("cursor_4c_CompoSub") > 0
                loc_cRet = "cursor_4c_CompoSub"
            ENDIF
        ENDIF

        *-- 2) fallback: composicao PADRAO do produto (SigPrCpo)
        IF EMPTY(loc_cRet) AND EMPTY(THIS.this_cMensagemErro)
            loc_cSQL = "SELECT a.Mats, a.Cpros, a.Qtds, a.Pesos, b.CGrus" + ;
                " FROM SigPrCpo a INNER JOIN SigCdPro b ON a.Mats = b.CPros" + ;
                " WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCpros)) + loc_cFiltro

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_CompoPad", "fBuscarCompos - SigPrCpo")
                IF USED("cursor_4c_CompoPad") AND RECCOUNT("cursor_4c_CompoPad") > 0
                    loc_cRet = "cursor_4c_CompoPad"
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cRet
    ENDFUNC

    *==========================================================================
    * NOTA DE ESCOPO - fRecalculaP / fRecalculaC (recalculo de custo medio)
    *
    * O Click legado chama fRecalculaP/fRecalculaC em 12 pontos: 10 deles com
    * o retorno DESCARTADO (=fRecalculaP(...)), logo apos cada Insert Into
    * crSigMvHst, e 2 pares no fecho (dump linhas 5462/5466 e 5864/5868) na
    * forma de lote (fRecalculaP(.t., poDataMgr) / fRecalculaC(.t.,.f.,.f.,
    * poDataMgr)), onde o retorno gateia llErro.
    *
    * As DUAS funcoes NAO existem no acervo - nem como .prg, nem como fonte no
    * Framework, nem como string no p-code dos VCX (varredura binaria feita em
    * 2026-09-29 sobre Framework\*.VCT/*.VCX, origem\, tasks\ e projeto\).
    * Elas recalculam custo medio / preco medio de estoque (SigOpClP/SigOpClC).
    *
    * DECISAO (regra #27 do CLAUDE.md, 3a linha da tabela - funcao que produz
    * VALOR DE CALCULO fica AUSENTE e visivel, nunca vira stub): as chamadas
    * foram OMITIDAS, nao stubadas. Inventar um recalculo de custo medio
    * gravaria numero financeiro errado em silencio - risco muito maior do que
    * a ausencia. Os dois pares de fecho tambem foram omitidos SEM marcar
    * llErro: marcar erro abortaria e desfaria TODA a geracao de O.P. por
    * causa de uma funcao que nao existe.
    *
    * CONSEQUENCIA FUNCIONAL A REPORTAR: apos Processar(), o custo/preco medio
    * de estoque NAO eh recalculado. Os movimentos (SigMvHst/SigBxEst/
    * SigMvItn/SigMvIts/SigMvCab/SigOpPic/SigPdMvf/SigCdNec/SigCdNei) sao
    * gravados corretamente; so o recalculo derivado fica pendente. Mesmo
    * tratamento ja adotado em dmoBO.RecalcularEstoque/RecalcularCusto.
    *
    * Cada ponto de chamada esta marcado abaixo com o comentario
    * "*-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)".
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarParametrosProcessamento - Completa os parametros de sistema que
    * o Processar() usa e que o Init() desta classe ainda nao carregava:
    *
    *   SigCdPam.GlobAutos / GruConfs / ConConfs  (properties ja declaradas)
    *   SigCdPac.OpPdCompra / OpZers / AgrupReqs / SigKeys
    *
    * No legado esses valores vinham dos cursores globais crSigCdPam e
    * crSigCdPac que o form pai (SIGPRGLO) deixava abertos na DataSession
    * compartilhada. Aqui sao relidos do banco para o BO nao depender do pai
    * - mesma decisao ja tomada no Init() para o resto de SigCdPam.
    *
    * SigKeys so eh sobrescrito quando o FORM nao o preencheu
    * (FormSigPrGlp.InicializarForm le CrSigCdPac.sigKeys quando o cursor
    * global existe) - o valor do form tem precedencia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarParametrosProcessamento()
        LOCAL loc_lOk
        loc_lOk = .F.

        IF USED("cursor_4c_PamProc")
            USE IN cursor_4c_PamProc
        ENDIF
        IF SQLEXEC(gnConnHandle, ;
                "SELECT globautos, gruconfs, conconfs FROM SigCdPam", ;
                "cursor_4c_PamProc") >= 0 AND USED("cursor_4c_PamProc")

            IF !EOF("cursor_4c_PamProc")
                THIS.this_nPamGlobAutos = TratarNulo(cursor_4c_PamProc.globautos, 0)
                THIS.this_cPamGruConfs  = PADR(TratarNulo(cursor_4c_PamProc.gruconfs, ""), 10)
                THIS.this_cPamConConfs  = PADR(TratarNulo(cursor_4c_PamProc.conconfs, ""), 10)
            ENDIF
            USE IN cursor_4c_PamProc
            loc_lOk = .T.
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(SigCdPam) " + CapturarErroSQL()
        ENDIF

        IF loc_lOk
            loc_lOk = .F.
            IF USED("cursor_4c_PacProc")
                USE IN cursor_4c_PacProc
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                    "SELECT oppdcompra, opzers, agrupreqs, sigkeys FROM SigCdPac", ;
                    "cursor_4c_PacProc") >= 0 AND USED("cursor_4c_PacProc")

                IF !EOF("cursor_4c_PacProc")
                    THIS.this_cPacOpPdCompra = PADR(TratarNulo(cursor_4c_PacProc.oppdcompra, ""), 20)
                    THIS.this_nPacOpZers     = TratarNulo(cursor_4c_PacProc.opzers, 0)
                    THIS.this_nPacAgrupReqs  = TratarNulo(cursor_4c_PacProc.agrupreqs, 0)

                    IF EMPTY(ALLTRIM(THIS.this_cSigKey))
                        THIS.this_cSigKey = PADR(TratarNulo(cursor_4c_PacProc.sigkeys, ""), 3)
                    ENDIF
                ENDIF
                USE IN cursor_4c_PacProc
                loc_lOk = .T.
            ELSE
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(SigCdPac) " + CapturarErroSQL()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDbParam - Resolve as tres colunas do cursor "DBParam" do legado.
    *
    * O DBParam eh montado no Click do SigPrGlo (grandparent), nao no SIGPRGLP:
    *
    *     =Seek(_lcTpGOp,'CrTmpTpGOp')
    *     Create Cursor DBParam (CodTgOps c(10), OpZers n(1), EntPes n(1))
    *     Insert Into DbParam (CodTgOps, OpZers, EntPes) Values (
    *         _lcTpGOp,
    *         Iif(ThisForm.GerPorTp, CrTmpTpGop.OpZers, CrSigCdPac.OpZers),
    *         Iif(ThisForm.GerPorTp, CrTmpTpGop.EntPes, 0))
    *
    * CrTmpTpGop eh SigInTgo filtrado por Codigos = _lcTpGOp (colunas codigos,
    * descs, entpes, opzers, dopps - conferidas em docs/schema.sql).
    * CrSigCdPac.OpZers eh SigCdPac.opzers (THIS.this_nPacOpZers, carregado em
    * CarregarParametrosProcessamento).
    *
    * O cursor nao foi portado; as tres colunas viram properties deste BO e
    * sao lidas ao longo do Processar() (Pesos de crSigPdMvf, CodTgOps de
    * crSigOpPic e o gate da entrada automatica).
    *--------------------------------------------------------------------------
    FUNCTION CarregarDbParam()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cDbCodTgOps = PADR(ALLTRIM(THIS.this_cTipoGeracaoOP), 10)

            IF THIS.this_lGerPorTp
                *-- CrTmpTpGop = SigInTgo Where Codigos = _lcTpGOp
                THIS.this_nDbOpZers = 0
                THIS.this_nDbEntPes = 0

                IF USED("cursor_4c_TpGOp")
                    USE IN cursor_4c_TpGOp
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF SQLEXEC(gnConnHandle, ;
                            "SELECT opzers, entpes FROM SigInTgo WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTipoGeracaoOP)), ;
                            "cursor_4c_TpGOp") >= 0 AND USED("cursor_4c_TpGOp")

                        IF !EOF("cursor_4c_TpGOp")
                            THIS.this_nDbOpZers = TratarNulo(cursor_4c_TpGOp.opzers, 0)
                            THIS.this_nDbEntPes = TratarNulo(cursor_4c_TpGOp.entpes, 0)
                        ENDIF
                        USE IN cursor_4c_TpGOp
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(SigInTgo) " + CapturarErroSQL()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_nDbOpZers = THIS.this_nPacOpZers
                THIS.this_nDbEntPes = 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigPrGlpBO.CarregarDbParam")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizaPeso - Transcricao de SIGPRGLP.atualizapeso (dump 2736-2773).
    *
    * Opera sobre o cursor CORRENTE (cCompo = Alias() no legado; o chamador faz
    * "Select LocalCompo" imediatamente antes) e devolve o peso total dos
    * componentes que entram no custo.
    *
    * crSigCdPam.AutComps -> THIS.this_nPamAutComps (carregado no Init).
    * crSigCdCom -> cursor global preparado pelo FORM
    * (FormSigPrGlp.PrepararCursoresDeTrabalho), com Tipos/Custos/CGrus.
    *
    * Acesso aos campos do cursor corrente por EVALUATE: o legado usa macro
    * (&cCompo..CGrus), que aqui seria macro-substituicao desnecessaria -
    * EVALUATE eh a forma canonica de LEITURA por nome (regra #15).
    *
    * Falha de SQL grava this_cMensagemErro e devolve 0; o chamador aborta ao
    * ver a mensagem preenchida (o legado fazia MessageBox + Return 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizaPeso()
        LOCAL loc_cCompo, loc_nTotQtd, loc_cQuery, loc_nFator, loc_cUni, loc_lFalhou

        loc_cCompo  = ALIAS()
        loc_nTotQtd = 0
        loc_lFalhou = .F.

        IF EMPTY(loc_cCompo) OR !USED(loc_cCompo)
            RETURN 0
        ENDIF

        IF THIS.this_nPamAutComps != 1
            SELECT (loc_cCompo)
            SCAN
                IF !USED("crSigCdCom")
                    LOOP
                ENDIF

                SELECT crSigCdCom
                GO TOP IN crSigCdCom
                LOCATE FOR crSigCdCom.CGrus = EVALUATE(loc_cCompo + ".CGrus") ;
                       AND crSigCdCom.Custos = 1

                IF !EOF("crSigCdCom")
                    loc_cQuery = "SELECT a.cUnis, a.cUnips, b.BPesos" + ;
                        " FROM SigCdPro a, SigCdGrp b" + ;
                        " WHERE a.CPros = " + EscaparSQL(ALLTRIM(EVALUATE(loc_cCompo + ".Mats"))) + ;
                        " AND a.CGrus = b.CGrus"

                    IF !THIS.ExecutarSQL(loc_cQuery, "crSomaGru", "crSomaGru - 1")
                        loc_lFalhou = .T.
                        EXIT
                    ENDIF

                    GO TOP IN crSomaGru

                    IF !EOF("crSomaGru") AND INLIST(TratarNulo(crSomaGru.BPesos, 0), 1, 3)
                        loc_cUni = IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                            TratarNulo(crSomaGru.cUnis, ""), TratarNulo(crSomaGru.cUnips, ""))

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Fators FROM SigCdUni WHERE Cunis = " + ;
                                EscaparSQL(ALLTRIM(loc_cUni)), "LocalUni", "LocalUni")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF

                        loc_nFator = 1
                        IF USED("LocalUni") AND !EOF("LocalUni")
                            loc_nFator = IIF(TratarNulo(LocalUni.Fators, 0) = 0, 1, ;
                                TratarNulo(LocalUni.Fators, 0))
                        ENDIF

                        SELECT (loc_cCompo)
                        loc_nTotQtd = loc_nTotQtd + ( ;
                            IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                                EVALUATE(loc_cCompo + ".Qtds"), ;
                                EVALUATE(loc_cCompo + ".Pesos")) * loc_nFator)
                    ENDIF
                ENDIF

                SELECT (loc_cCompo)
            ENDSCAN

            SELECT (loc_cCompo)
        ENDIF

        IF loc_lFalhou
            loc_nTotQtd = 0
        ENDIF

        RETURN loc_nTotQtd
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravaHis - Transcricao de SIGPRGLP.gravahis (dump 2778-2843).
    *
    * Atribui as chaves primarias do historico de estoque (crSigMvHst):
    * CidChaves = Dtos(Datas) + <letra da operacao> + Transform(seq,"@L 999999")
    *             + SigKey     e    Seqs = sequencial da chave 'HISTBAR'.
    *
    * As duas sequencias sao BLOCOS reservados de uma vez (ver
    * ReservarSequencia) - o legado chama fGerUniqueKey com o 4o argumento.
    *
    * LocalOpe (SigCdOpe + SigCdOpd das operacoes presentes no historico) eh
    * montado igual ao legado, mas so era consumido pelo bloco *!* comentado
    * logo abaixo (a regra de trocar E/S por H/K foi desativada em 23/10/2015).
    * Mantido por fidelidade e para nao alterar o estado dos cursores.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravaHis()
        LOCAL loc_lOk, loc_cSql, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewOpe

        loc_lOk = .T.

        IF !USED("crSigMvHst")
            RETURN .T.
        ENDIF

        *-- LocalOpe: estrutura vazia de CrSigCdOpe (Select ... Where 0=1)
        IF USED("LocalOpe")
            USE IN LocalOpe
        ENDIF
        IF THIS.ExecutarSQL( ;
                "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                " FROM SigCdOpe WHERE 1 = 0", "cursor_4c_OpeEstr", "LocalOpe")

            SELECT * FROM cursor_4c_OpeEstr WHERE .F. INTO CURSOR LocalOpe READWRITE
            USE IN cursor_4c_OpeEstr
        ELSE
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            SELECT DISTINCT Dopes FROM crSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                    " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            SELECT LocalOpe
            INDEX ON Dopes TAG Dopes

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos," + ;
                    " EstOrigs, EstDests FROM SigCdOpd WHERE Dopps = " + ;
                    EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe - Opd")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            WAIT WINDOW "Criando Chaves Prim" + CHR(225) + "rias no Arquivo de Hist" + ;
                CHR(243) + "rico " NOWAIT

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT("crSigMvHst")

            IF loc_nRegistro > 0
                *-- Bloco de chaves do historico (uma chave por DATA do 1o
                *-- registro, igual ao legado: fGerUniqueKey(Dtos(Datas),,,N+1))
                *-- O legado repete o fGerUniqueKey ate sair diferente de zero
                *-- ("DO While _Reservado = 0 And _nRegistro > 0"), o que com
                *-- falha permanente de conexao vira laco INFINITO. Aqui uma
                *-- unica reserva ja eh atomica; zero significa falha real e
                *-- ABORTA - seguir adiante gravaria CidChaves com sequencial
                *-- NEGATIVO (_Reservado - _nRegistro), colidindo no indice
                *-- unico de SigMvHst.
                loc_nReservado = THIS.ReservarSequencia(DTOS(crSigMvHst.Datas), loc_nRegistro + 1)
                loc_nRerSeq    = 0
                IF loc_nReservado > 0
                    loc_nRerSeq = THIS.ReservarSequencia("HISTBAR", loc_nRegistro + 1)
                ENDIF

                IF loc_nReservado = 0 OR loc_nRerSeq = 0
                    WAIT CLEAR
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "N" + CHR(227) + "o foi poss" + CHR(237) + "vel reservar a numera" + ;
                        CHR(231) + CHR(227) + "o do hist" + CHR(243) + "rico de estoque."
                    RETURN .F.
                ENDIF

                loc_nInicio = loc_nReservado - loc_nRegistro
                loc_nIniSeq = loc_nRerSeq - loc_nRegistro

                SELECT crSigMvHst
                SCAN
                    loc_nInicio = loc_nInicio + 1
                    loc_nIniSeq = loc_nIniSeq + 1

                    *-- Tiago - 23/10/2015: grava no cidchaves a MESMA letra da
                    *-- movimentacao, para o historico ficar na ordem certa
                    *-- (o bloco *!* que trocava E/S por H/K esta desativado no
                    *-- legado e NAO foi transcrito)
                    loc_cNewOpe = TratarNulo(crSigMvHst.Opers, " ")

                    REPLACE CidChaves WITH DTOS(crSigMvHst.Datas) + loc_cNewOpe + ;
                            TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                            Seqs      WITH loc_nIniSeq ;
                        IN crSigMvHst

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDSCAN
            ENDIF

            WAIT CLEAR
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursoresDestino - Equivale ao bloco de "Select crXxx / Zap" do
    * topo do Click legado (dump 4261-4288). Os nove cursores de gravacao nao
    * existem na cadeia migrada (nem SigPrGloBO/FormSigPrGlo nem SigPrGl2BO/
    * FormSigPrGl2 os criam, e o dump legado do SIGPRGLO tampouco): sao
    * recriados aqui, VAZIOS e com a estrutura COMPLETA da tabela destino.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCursoresDestino()
        LOCAL loc_lOk

        loc_lOk = THIS.AbrirCursorTabela("crSigOpPic", "SigOpPic")
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigBxEst", "SigBxEst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
        ENDIF

        *-- Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
        IF loc_lOk
            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF
            SELECT * FROM crSigCdNei WHERE .F. INTO CURSOR GrSigCdNei READWRITE
            loc_lOk = USED("GrSigCdNei")
        ENDIF

        *-- crTplMvIts / crTpmMvItn: no legado nascem de
        *-- CursorQuery('SigMvIts'/'SigMvItn', ..., 'cIdChaves', fUniqueIds()),
        *-- isto eh, cursor VAZIO com a estrutura da tabela (a chave sorteada
        *-- nunca casa). Sao cursores de TRABALHO, diferentes de crSigMvIts/
        *-- crSigMvItn - a consolidacao de um para o outro esta em
        *-- ConsolidarMovimentoItens().
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTplMvIts", "SigMvIts")
            IF loc_lOk
                SELECT crTplMvIts
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTpmMvItn", "SigMvItn")
            IF loc_lOk
                SELECT crTpmMvItn
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - Libera os cursores de trabalho criados por
    * Processar(), tornando-o reexecutavel na mesma sessao do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL ARRAY loc_aCursores[34]
        LOCAL loc_nI

        loc_aCursores[1]  = "crSigOpPic"
        loc_aCursores[2]  = "crSigPdMvf"
        loc_aCursores[3]  = "crSigCdNec"
        loc_aCursores[4]  = "crSigCdNei"
        loc_aCursores[5]  = "crSigMvCab"
        loc_aCursores[6]  = "crSigMvHst"
        loc_aCursores[7]  = "crSigBxEst"
        loc_aCursores[8]  = "crSigMvItn"
        loc_aCursores[9]  = "crSigMvIts"
        loc_aCursores[10] = "GrSigCdNei"
        loc_aCursores[11] = "crTplMvIts"
        loc_aCursores[12] = "crTpmMvItn"
        loc_aCursores[13] = "TmpEmpH"
        loc_aCursores[14] = "TmpPedra"
        loc_aCursores[15] = "TmpMatPrz"
        loc_aCursores[16] = "TmpEstoque"
        loc_aCursores[17] = "TmpOpePed"
        loc_aCursores[18] = "TmpOpi"
        loc_aCursores[19] = "TmpUltItn"
        loc_aCursores[20] = "TempEest"
        loc_aCursores[21] = "TempEestI"
        loc_aCursores[22] = "TempEsti2"
        loc_aCursores[23] = "LocalCompo"
        loc_aCursores[24] = "LocalOpe"
        loc_aCursores[25] = "SelOperacao"
        loc_aCursores[26] = "xTmpOpe"
        loc_aCursores[27] = "crSigPrCpo"
        loc_aCursores[28] = "cursor_4c_CompoSub"
        loc_aCursores[29] = "cursor_4c_CompoPad"
        loc_aCursores[30] = "pEstoque"
        loc_aCursores[31] = "TmpNensi"
        loc_aCursores[32] = "xNensi"
        loc_aCursores[33] = "TmpLinF"
        loc_aCursores[34] = "TmpCompo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Processar - Transcricao do Click do botao Processar (SIGPRGLP.Processar.
    * Click, dump linhas 4255-5893). Efetiva a geracao das Ordens de Producao.
    *
    * CONTRATO (fixado em FormSigPrGlp.BtnProcessarClick): sem parametros. O
    * form preenche antes this_dPrevisao (_Prev), this_dDataGeracao (_DtGera),
    * this_cTipoGeracaoOP (_lcTpGOp) e this_lGerPorTp (GerPorTp). Devolve .T.
    * em sucesso, com this_nNumeroOpGerada = _Nump; em falha devolve .F. com
    * this_cMensagemErro preenchido (o form exibe via MsgErro).
    *
    * NAO transcrito (codigo morto conferido linha a linha no dump):
    *   - "Set Step On" (linha 5121) - abre o debugger do VFP, nao vai para
    *     producao
    *   - bloco *!* de override de _Dopp por TmpSigInTgo.Dopps (4296-4300)
    *   - blocos *!* que trocavam a letra E/S por H/K no CidChaves do
    *     historico (desativados pelo proprio legado em 23/10/2015)
    *   - "_Qtdcpnt = (crSigCdPro.QtdCpnts * _QtBaixado)" comentado em 4452
    *   - consulta comentada de SigPrCpo em 5571-5573
    *
    * FICA NO FORM (camada de apresentacao, ja implementada/decidida la):
    *   - "Do Form SigReGli With _Nump, ThisForm" (impressao da O.P. gerada)
    *   - ThisForm.Enabled / Processar.Enabled / Disponivel.Enabled /
    *     TotLinha.Enabled = .f. e o Cancelar.Click() + Keyboard '{ESC}' do
    *     fecho, que o BtnProcessarClick ja cobre fechando o form
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro, loc_cExactOrig

        *-- Estado compartilhado com os metodos de bloco (ver nota de
        *-- arquitetura acima): PRIVATE, como as Private/Local do Click legado
        PRIVATE loc_lAbortar, loc_tDay, loc_cEmpr, loc_cUsuar
        PRIVATE loc_cDopp, loc_cDope, loc_nNump, loc_nNumpe, loc_nSeqs
        PRIVATE loc_cCpros, loc_cReff, loc_cCor, loc_cTam, loc_dPrev, loc_dDtGera
        PRIVATE loc_nTProd, loc_nTPeso, loc_cClinha, loc_cNota
        PRIVATE loc_cGrupoD, loc_cContaD, loc_cGrupoC, loc_cContaC
        PRIVATE loc_nNume, loc_nCitens, loc_cDopePed, loc_nNopComp, loc_nQtBaixado
        PRIVATE loc_cDopEntAu, loc_nNumEntAu, loc_cChave, loc_cChave2, loc_lGrvEest
        PRIVATE loc_nSeq, loc_cDpTrf, loc_nNopI, loc_nNopF

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro   = ""
        THIS.this_nNumeroOpGerada = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal")
            THIS.this_cMensagemErro = "Os dados da pr" + CHR(233) + "via n" + CHR(227) + ;
                "o est" + CHR(227) + "o dispon" + CHR(237) + "veis." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        *-- SET EXACT: o Click legado roda com o default do VFP (EXACT OFF) e
        *-- depende disso - faz DEZENAS de SEEK PARCIAIS sobre indices
        *-- COMPOSTOS (Seek(SelPedra.Cpros) sobre CMats+Grupos+Contas,
        *-- Seek(TmpFinal.Cpros+CodCors+CodTams) sobre um indice de 6 partes
        *-- em TmpSaldG, Seek(nTran) sobre nTrans, ...). O config.prg deste
        *-- projeto liga SET EXACT ON (linha 231) e, medido no VFP9
        *-- (2026-09-29, ver FormSigPrGlp.AplicarFaixaSaldoContas), com EXACT
        *-- ON o SEEK parcial devolve .F. - as buscas NUNCA casariam e o
        *-- processamento gravaria material/requisicao duplicados em silencio,
        *-- sem nenhum erro na tela.
        *-- Restaurado no fim, inclusive no caminho do CATCH.
        loc_cExactOrig = SET("EXACT")
        SET EXACT OFF

        TRY
            *-- pDay = Datetime()
            loc_tDay   = DATETIME()
            loc_cEmpr  = PADR(go_4c_Sistema.cCodEmpresa, 3)
            loc_cUsuar = PADR(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10), 10)

            *-- Parametros do sistema + DBParam (o legado ja os tinha nos
            *-- cursores globais crSigCdPam/crSigCdPac/DBParam)
            IF !THIS.CarregarParametrosProcessamento()
                loc_lAbortar = .T.
            ENDIF
            IF !loc_lAbortar AND !THIS.CarregarDbParam()
                loc_lAbortar = .T.
            ENDIF

            *-- Select crSigOpPic / Zap  ... (9 cursores) + GrSigCdNei
            IF !loc_lAbortar AND !THIS.PrepararCursoresDestino()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                *-- _Dopp = crSigCdPam.DoppPads / _Dope = crSigCdPam.TransfRes
                loc_cDopp = PADR(THIS.this_cPamDoppPads, 20)
                loc_cDope = PADR(THIS.this_cPamTransfRes, 20)

                IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopp))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Numero da O.P. (_Nump) + conferencia de duplicidade
            IF !loc_lAbortar
                loc_nNump = 0
                IF !THIS.this_lReserva
                    IF THIS.this_nPamGlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                        loc_nNump = THIS.this_nNumeroDaOp
                    ELSE
                        loc_nNump = fGerUniqueKey(ALLTRIM(loc_cDopp))
                    ENDIF

                    IF !THIS.ExecutarSQL("SELECT Numps FROM SigOpPic WHERE Numps = " + ;
                            FormatarNumeroSQL(loc_nNump, 0), "TmpOpi", "TmpOpi")
                        loc_lAbortar = .T.
                    ELSE
                        IF RECCOUNT("TmpOpi") > 0
                            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de Op j" + CHR(225) + ;
                                " existe. Favor Corrigir!!!"
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                loc_nSeqs   = 0
                loc_cCpros  = ""
                loc_cReff   = SPACE(15)
                loc_cCor    = SPACE(4)
                loc_cTam    = SPACE(2)
                loc_dPrev   = ConverterParaData(THIS.this_dPrevisao)
                loc_dDtGera = ConverterParaData(THIS.this_dDataGeracao)
                loc_nTProd  = 0
                loc_nTPeso  = 0
                loc_cClinha = SPACE(10)
                loc_cNota   = SPACE(6)
                loc_cGrupoD = SPACE(10)
                loc_cContaD = SPACE(10)
                loc_nNumpe  = (loc_nNump * 10000) + 1
                loc_nNume   = 0
                loc_nCitens = 0

                *-- Cursores de acumulo de componentes / pedras / prazos
                IF USED("TmpEmpH")
                    USE IN TmpEmpH
                ENDIF
                CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    cpro2s C(10), Pesos N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats + cpro2s TAG CMats

                IF USED("TmpPedra")
                    USE IN TmpPedra
                ENDIF
                CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    Pesos N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats TAG CMats
                INDEX ON CMats + Grupos + Contas TAG MatGruCon

                IF USED("TmpMatPrz")
                    USE IN TmpMatPrz
                ENDIF
                CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), ;
                    PrazoEnts D, QtBaixas N(12,3))
                INDEX ON DTOC(PrazoEnts) + Cmats TAG MatPrazo DESC

                *-- _DopePed = crSigCdPac.OpPdCompra
                loc_cDopePed = PADR(THIS.this_cPacOpPdCompra, 20)
                IF !THIS.ConsultarTabela("SigCdOpe", "TmpOpePed", "Dopes", ALLTRIM(loc_cDopePed))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- 1) Producao / pedido de compra de acabado (dump 4363-4666)
            IF !loc_lAbortar
                THIS.ProcessarProducao()
            ENDIF

            *-- 2) Empenho de estoque + baixa das movimentacoes (4668-4927)
            IF !loc_lAbortar
                THIS.ProcessarEstoque()
            ENDIF

            *-- 3) Componentes/pedras: empenho, requisicao e pedido (4929-5235)
            IF !loc_lAbortar
                THIS.ProcessarComponentes()
            ENDIF

            *-- 4) Consolidacao crTpmMvItn/crTplMvIts -> crSigMvItn/crSigMvIts
            IF !loc_lAbortar
                THIS.ConsolidarMovimentoItens()
            ENDIF

            *-- 5) Entrada automatica de peso/material (5254-5417)
            IF !loc_lAbortar
                THIS.ProcessarEntradaAutomatica()
            ENDIF

            *-- 6) Chaves do historico + gravacao efetiva + commit (5419-5479)
            IF !loc_lAbortar
                IF THIS.GravarMovimentos()
                    loc_lSucesso = .T.
                ELSE
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- 7) Modo automatico: gera o fluxo de fases/transferencia e
            *--    grava o segundo lote (5491-5891)
            IF loc_lSucesso AND THIS.this_lAutomatico
                IF !THIS.ProcessarModoAutomatico()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_nNumeroOpGerada = loc_nNump
            ENDIF

        CATCH TO loc_oErro
            *-- Regra #9 (CATCH nunca silencioso): a mensagem NAO some - fica
            *-- em this_cMensagemErro e o FormSigPrGlp.BtnProcessarClick a
            *-- exibe via MsgErro sempre que Processar() devolve .F. Exibir
            *-- aqui tambem duplicaria o dialogo para o usuario.
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresProcessamento()

        IF loc_cExactOrig = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProducao - Transcricao de "If Not ThisForm.Reserva ... EndIf"
    * (dump 4363-4666): varre TmpFinal na ordem de agrupamento da O.P. e, para
    * cada item com Produzir <> 0, ou gera a O.P. de producao (crSigOpPic +
    * crSigPdMvf + crSigCdNec + GrSigCdNei, quebrando por QtPcs da linha), ou
    * - quando SigCdPac.OpPdCompra esta configurado e o produto NAO eh de
    * fabricacao propria (SigCdPro.FabrProPrs <> 1) - gera pedido de compra do
    * acabado (crSigMvCab + crTpmMvItn + crTplMvIts).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarProducao()
        LOCAL loc_cMat, loc_nQtdPrz, loc_nQtdLim, loc_nQtBaixar, loc_nVezes
        LOCAL loc_cCidC, loc_cIds, loc_nQtdTb, loc_nQtdcpnt, loc_nUnits, loc_cMoedas
        LOCAL loc_cQuery, loc_nBaixaAtual, loc_nPendente, loc_nPQtd, loc_nPQt2
        LOCAL loc_cEdn, loc_cPIds, loc_cPId2, loc_cForn, loc_nTotPed, loc_nPesoCmp
        LOCAL loc_lProsseguir

        IF THIS.this_lReserva
            RETURN
        ENDIF

        SELECT TmpFinal
        INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
        SET ORDER TO Cpros
        GO TOP

        DO WHILE !EOF("TmpFinal") AND !loc_lAbortar

            IF TmpFinal.Produzir != 0

                loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinal.CPros))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdLin", "CrSigCdLin", "Linhas", ALLTRIM(TmpFinal.Linhas))
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "CrSigCdGrp", "CGrus", ;
                        ALLTRIM(crSigCdPro.Cgrus), "Mercs, GeraTubs")
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGpr", "CrSigCdGpr", "Codigos", ;
                        ALLTRIM(CrSigCdGrp.Mercs), "MatPrincs, cpqtds")
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                *-- Tiago - Real Gold - 24/08/2015 - Se estiver configurado para
                *-- gerar pedido de compra de acabado, so industrializa os
                *-- produtos de fabricacao propria
                IF EMPTY(THIS.this_cPacOpPdCompra) OR ;
                        (!EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs = 1)

                    loc_cMat = IIF(!EMPTY(crSigCdPro.MatPrincs), crSigCdPro.MatPrincs, ;
                        IIF(!EMPTY(CrSigCdGpr.Matprincs), CrSigCdGpr.MatPrincs, THIS.this_cPamOuros))

                    loc_nQtdPrz   = TmpFinal.Produzir
                    loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                    loc_nQtBaixar = TmpFinal.Produzir
                    loc_nVezes    = 0

                    DO WHILE loc_nQtBaixar > 0 AND !loc_lAbortar

                        loc_nVezes = loc_nVezes + 1

                        IF loc_nQtBaixar < loc_nQtdLim
                            loc_nQtBaixado = loc_nQtBaixar
                            loc_nQtBaixar  = 0
                        ELSE
                            loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                            loc_nQtBaixado = loc_nQtdLim
                        ENDIF

                        *-- Quebra de grupo da O.P.: muda Linha/Referencia/
                        *-- Produto/Nota/Cor/Grupo/Conta de destino, ou a mesma
                        *-- combinacao dividida em mais de um lote (_lnVezes > 1)
                        IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + ;
                                loc_cGrupoD + loc_cContaD != ;
                                TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + ;
                                TmpFinal.Notas + TmpFinal.CodCors + TmpFinal.GrupoDs + ;
                                TmpFinal.ContaDs) OR loc_nVezes > 1

                            loc_cClinha = TmpFinal.Linhas
                            loc_cCpros  = TmpFinal.CPros
                            loc_cCor    = TmpFinal.CodCors
                            loc_cTam    = TmpFinal.CodTams
                            loc_cReff   = TmpFinal.Reffs
                            loc_cGrupoD = TmpFinal.GrupoDs
                            loc_cContaD = TmpFinal.ContaDs
                            loc_nSeqs   = loc_nSeqs + 1
                            loc_cNota   = TmpFinal.Notas
                            loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                            loc_cCidC   = DTOS(loc_dDtGera) + ;
                                TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + ;
                                THIS.this_cSigKey

                            INSERT INTO crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                    Grupoos, Contaos, Grupods, Contads, Nops, CodPds, Unids, ;
                                    Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                    loc_cUsuar, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                    loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCpros, ;
                                    crSigCdPro.CUnis, IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), ;
                                    loc_nTProd, 1, loc_cCidC, ;
                                    loc_cEmpr + SPACE(20) + STR(0, 6), ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10))

                            loc_cIds = DTOS(loc_dDtGera) + ;
                                TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + ;
                                THIS.this_cSigKey

                            INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                    TotPesos, Grupoos, Contaos, Grupods, Contads, cIdChaves, ;
                                    EmpDNps, Jobs) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                    loc_cUsuar, loc_nTPeso, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                    loc_cGrupoD, loc_cContaD, loc_cIds, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Jobs)

                            INSERT INTO GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, ;
                                    Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, loc_nNopComp, ;
                                    loc_nNopComp, loc_cMat, crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                    IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    THIS.this_cPamTpOpEntAus, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), fUniqueIds())

                            loc_nTProd = 0
                            loc_nTPeso = 0
                        ENDIF

                        loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                        *-- Tiago - 17/08/11 - Vianna: quantidade de pecas do
                        *-- tubo por componentes ou por matrizes (GeraTubs = 2)
                        IF crSigCdGrp.GeraTubs != 2
                            loc_nQtdTb = crSigCdPro.QtdCpnts
                        ELSE
                            IF !THIS.ExecutarSQL( ;
                                    "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                    EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigPrMtz", "crSigPrMtz")
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF
                            SELECT crSigPrMtz
                            loc_nQtdTb = crSigPrMtz.Total
                        ENDIF
                        loc_nQtdcpnt = (NVL(loc_nQtdTb, 0) * loc_nQtBaixado)

                        loc_nUnits  = 0
                        loc_cMoedas = SPACE(3)

                        loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)

                        loc_cQuery = "SELECT * FROM SigMvItn" + ;
                            " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                            " AND CPros = " + EscaparSQL(TmpFinal.Cpros)

                        IF !THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        SELECT TempEestI
                        SCAN
                            IF TempEestI.CItens = TmpFinal.Citens
                                loc_nUnits  = TempEestI.Units
                                loc_cMoedas = TempEestI.Moedas
                                EXIT
                            ENDIF
                        ENDSCAN

                        INSERT INTO crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, ;
                                Dataps, Obss, Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, ;
                                QtdCpnts, Units, Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, ;
                                Empds, EmpDopNops, Dpros, CodTgOps, Citens) ;
                            VALUES (loc_cEmpr, loc_cDopp, loc_nNump, loc_nNopComp, TmpFinal.Dopes, ;
                                TmpFinal.Numes, loc_dPrev, TmpFinal.Datas, TmpFinal.Obsps, ;
                                loc_nQtBaixado, loc_cCpros, loc_dDtGera, TmpFinal.CodCors, ;
                                TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, loc_nQtdcpnt, ;
                                loc_nUnits, loc_cMoedas, fUniqueIds(), ;
                                TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6), ;
                                loc_cEmpr + loc_cDopp + STR(loc_nNump, 10), TmpFinal.Notas, ;
                                TmpFinal.Emps, loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), ;
                                TmpFinal.Dpros, THIS.this_cDbCodTgOps, TmpFinal.cItens)

                        *-- Baixa da quantidade produzida nos itens da
                        *-- movimentacao de origem (SigMvItn / SigMvIts)
                        SELECT TempEestI
                        loc_nBaixaAtual = loc_nQtBaixado
                        SCAN WHILE loc_nBaixaAtual > 0
                            loc_cEdn  = TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6)
                            loc_cPIds = TempEestI.cIdChaves

                            IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) != 0

                                loc_cQuery = "SELECT * FROM SigMvIts" + ;
                                    " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                    " AND CItens = " + FormatarNumeroSQL(TempEestI.Citens, 0)

                                IF !THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 1")
                                    loc_lAbortar = .T.
                                    EXIT
                                ENDIF

                                SELECT TempEsti2
                                GO TOP
                                IF EOF("TempEsti2")
                                    loc_nPendente = TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds
                                    IF loc_nPendente > loc_nBaixaAtual
                                        loc_nPQtd = TempEestI.QtProds + loc_nBaixaAtual
                                        loc_nBaixaAtual = 0
                                    ELSE
                                        loc_nPQtd = TempEestI.QtProds + loc_nPendente
                                        loc_nBaixaAtual = loc_nBaixaAtual - loc_nPendente
                                    ENDIF

                                    loc_cQuery = "UPDATE SigMvItn SET DtAlts = " + ;
                                        FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                                        " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 1")
                                        loc_lAbortar = .T.
                                        EXIT
                                    ENDIF
                                ELSE
                                    SELECT TempEsti2
                                    SCAN WHILE loc_nBaixaAtual > 0
                                        loc_cPId2 = TempEsti2.cIdChaves

                                        loc_nPendente = TempEsti2.Qtds - TempEsti2.QtBaixas - TempEsti2.QtProds
                                        IF loc_nPendente != 0
                                            IF loc_nPendente > loc_nBaixaAtual
                                                loc_nPQtd = TempEestI.QtProds + loc_nBaixaAtual
                                                loc_nPQt2 = TempEsti2.QtProds + loc_nBaixaAtual
                                                loc_nBaixaAtual = 0
                                            ELSE
                                                loc_nPQtd = TempEestI.QtProds + loc_nPendente
                                                loc_nPQt2 = TempEsti2.QtProds + loc_nPendente
                                                loc_nBaixaAtual = loc_nBaixaAtual - loc_nPendente
                                            ENDIF

                                            loc_cQuery = "UPDATE SigMvItn SET DtAlts = " + ;
                                                FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                                FormatarNumeroSQL(loc_nPQtd, 3) + ;
                                                " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                                            IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 2")
                                                loc_lAbortar = .T.
                                                EXIT
                                            ENDIF

                                            loc_cQuery = "UPDATE SigMvIts SET QtProds = " + ;
                                                FormatarNumeroSQL(loc_nPQt2, 3) + ;
                                                " WHERE cIdChaves = " + EscaparSQL(loc_cPId2)

                                            IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 3")
                                                loc_lAbortar = .T.
                                                EXIT
                                            ENDIF
                                        ENDIF
                                    ENDSCAN
                                    IF loc_lAbortar
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDSCAN
                        IF loc_lAbortar
                            EXIT
                        ENDIF

                        loc_cQuery = "UPDATE SigMvCab SET Nops = " + ;
                            FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + ;
                            FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + ;
                            EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6))

                        IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 4")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        *-- Composicao substituida na O.P.: se existir e o
                        *-- sistema estiver configurado (AutComps <> 1), o peso
                        *-- vem da composicao e nao do peso do item
                        loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                        loc_cQuery = "SELECT a.*, b.cgrus FROM SigSubMv a" + ;
                            " INNER JOIN SigCdPro b ON a.mats = b.cpros" + ;
                            " WHERE a.empdopnums = " + EscaparSQL(loc_cEdn) + ;
                            " AND a.cpros = " + EscaparSQL(TmpFinal.CPros) + ;
                            " AND a.citem2 = " + FormatarNumeroSQL(TmpFinal.citens, 0)

                        IF !THIS.ExecutarSQL(loc_cQuery, "LocalCompo", "LocalCompo")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        IF THIS.this_nPamAutComps != 1 AND RECCOUNT("LocalCompo") > 0
                            SELECT LocalCompo
                            loc_nPesoCmp = THIS.AtualizaPeso()
                            IF !EMPTY(THIS.this_cMensagemErro)
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF
                            loc_nTProd = loc_nTProd + loc_nQtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * loc_nPesoCmp)

                            SELECT crSigOpPic
                            REPLACE Pesos WITH loc_nQtBaixado * loc_nPesoCmp IN crSigOpPic
                        ELSE
                            loc_nTProd = loc_nTProd + loc_nQtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * TmpFinal.Peso)
                        ENDIF

                        SELECT crSigPdMvf
                        REPLACE Pesos WITH IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), ;
                                Qtds  WITH loc_nTProd IN crSigPdMvf

                        SELECT GrSigCdNei
                        REPLACE Pesos WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                Qtds  WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso) ;
                            IN GrSigCdNei

                        SELECT crSigCdNec
                        REPLACE TotPesos WITH loc_nTPeso IN crSigCdNec
                        IF THIS.this_lAutomatico
                            REPLACE Autos WITH .T. IN crSigCdNec
                        ENDIF

                    ENDDO

                ELSE
                    *-- Pedido de compra do produto acabado
                    loc_cForn = PADR(IIF(!EMPTY(crSigCdPro.Ifors), crSigCdPro.Ifors, ;
                        TmpOpePed.ConOrigs), 10)
                    loc_nTotPed = TmpFinal.Produzir

                    SELECT crSigMvCab
                    GO TOP
                    LOCATE FOR crSigMvCab.Dopes = PADR(THIS.this_cPacOpPdCompra, 20) ;
                           AND crSigMvCab.ContaDs = loc_cForn
                    IF !EOF("crSigMvCab")
                        loc_nNume = crSigMvCab.Numes

                        SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                            WHERE crTpmMvItn.Emps = m.loc_cEmpr ;
                              AND crTpmMvItn.Dopes = m.loc_cDopePed ;
                              AND crTpmMvItn.Numes = m.loc_nNume ;
                            INTO CURSOR TmpUltItn
                        loc_nCitens = NVL(TmpUltItn.Citens, 0) + 1
                    ELSE
                        loc_nCitens = 9999
                    ENDIF

                    IF loc_nCitens >= 9999
                        loc_nCitens = 1
                        loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDopePed)

                        INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, ;
                                Usuars, Grupoos, Contaos, Grupods, Contads, Nops, Obses, ;
                                Empdopnums, cIdChaves, DtAlts) ;
                            VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, ;
                                ALLTRIM(fGerMascara(loc_nNume)), loc_dDtGera, DATETIME(), ;
                                loc_cUsuar, TmpOpePed.GruOrigs, loc_cForn, TmpOpePed.GruDests, ;
                                TmpOpePed.ConDests, loc_nNump, ;
                                "[ OP: " + STR(loc_nNump) + "] ", ;
                                loc_cEmpr + loc_cDopePed + STR(loc_nNume, 6), ;
                                fUniqueIds(), DATETIME())
                    ENDIF

                    INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, ;
                            Opers, Citens, Pesos, cUniPs, Obs) ;
                        VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.Cpros, loc_nTotPed, ;
                            crSigCdPro.Cunis, crSigCdPro.Dpros, "E", loc_nCitens, ;
                            CrSigCdPro.PesoMs, CrSigCdPro.cUniPs, TmpFinal.Obsps)

                    IF !EMPTY(TmpFinal.CodCors) OR !EMPTY(TmpFinal.CodTams)
                        INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, ;
                                CodCors, CodTams, QtdEmbs) ;
                            VALUES (loc_nCitens, loc_cEmpr, loc_cDopePed, loc_nNume, ;
                                TmpFinal.CPros, loc_nTotPed, CrSigCdPro.PesoMs, ;
                                TmpFinal.CodCors, TmpFinal.CodTams, 1)
                    ENDIF

                    loc_cQuery = "UPDATE SigMvCab SET Nops = " + ;
                        FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + ;
                        FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + ;
                        EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6))

                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 4.1")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                ENDIF
            ENDIF

            SELECT TmpFinal
            SKIP
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEstoque - Transcricao do dump 4668-4927. Monta TmpEstoque
    * (o que sai do estoque para nao ser produzido), gera a movimentacao de
    * transferencia/reserva (crSigMvCab + crTpmMvItn + crTplMvIts), o historico
    * de estoque (crSigMvHst) e baixa QtProds/QtReservas em SigMvItn/SigMvIts,
    * registrando as baixas em crSigBxEst.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque()
        LOCAL loc_nXBaixa, loc_nXReser, loc_cEdn, loc_cQuery, loc_lTemItem2
        LOCAL loc_nQtBaixar, loc_cPIds, loc_nPQtd, loc_cPNop, loc_lProsseguir

        IF USED("TmpSaldG")
            SELECT TmpSaldG
            *-- "Select TmpSaldg / Set Order To" do legado: derrubar a ordem
            *-- tambem derruba o SET KEY que o Init/AfterRowColChange legado
            *-- mantinha no item corrente. No migrado essa restricao eh um
            *-- SET FILTER (FormSigPrGlp.AplicarFaixaSaldoContas), que
            *-- SOBREVIVE ao SET ORDER TO - sem limpa-lo aqui, o REPLACE ALL
            *-- abaixo e todo o empenho de estoque enxergariam SO o produto
            *-- selecionado na grade.
            SET FILTER TO
            SET ORDER TO
            REPLACE ALL Reservs WITH Saldo - Disps IN TmpSaldG
        ENDIF

        IF USED("TmpEstoque")
            USE IN TmpEstoque
        ENDIF
        CREATE CURSOR TmpEstoque (EmpDs C(3), Cpros C(14), CodCors C(4), CodTams C(4), ;
            Emps C(3), Dopes C(20), Numes N(6), grupos C(10), Estos C(10), Estoque N(12,3))
        INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

        SELECT TmpFinal
        SET ORDER TO
        SCAN
            IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ;
                    ALLTRIM(TmpFinal.CPros), "FabrProPrs")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TmpFinal.Estoque != 0 AND ;
                    IIF(!EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs != 1, .F., .T.)

                loc_nXBaixa = TmpFinal.Estoque

                IF USED("TmpSaldG")
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                    SCAN WHILE TmpSaldG.Cpros = TmpFinal.Cpros ;
                            AND TmpSaldG.CodCors = TmpFinal.CodCors ;
                            AND TmpSaldG.CodTams = TmpFinal.CodTams ;
                            AND loc_nXBaixa > 0

                        IF TmpSaldG.Reservs >= loc_nXBaixa
                            REPLACE TmpSaldg.Reservs WITH TmpSaldg.Reservs - loc_nXBaixa IN TmpSaldG
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, ;
                                    Numes, Grupos, Estos, Estoque, EmpDs) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                                    TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                    TmpSaldg.Grupos, TmpSaldG.Estos, loc_nXBaixa, TmpSaldG.Emps)
                            loc_nXBaixa = 0
                        ELSE
                            *-- Rafael - 06/2016 - Se o Saldo for o mesmo do
                            *-- estoque, usou outro tamanho para nao produzir
                            IF (TmpSaldg.Reservs > 0) OR (TmpFinal.Estoque = TmpFinal.Saldo)
                                loc_nXBaixa = loc_nXBaixa - TmpSaldg.Reservs
                                loc_nXReser = IIF(TmpFinal.Estoque = TmpFinal.Saldo, ;
                                    loc_nXBaixa, TmpSaldg.Reservs)
                                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, ;
                                        Numes, Grupos, Estos, Estoque, EmpDs) ;
                                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                                        TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                        TmpSaldg.Grupos, TmpSaldg.Estos, loc_nXReser, TmpSaldG.Emps)
                                REPLACE TmpSaldg.Reservs WITH 0 IN TmpSaldG
                            ENDIF
                        ENDIF
                        SELECT TmpSaldG
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Tiago - Real Gold - 24/08/2015 - Com pedido de compra de
            *-- acabado configurado, gera reserva (empenho) de TODAS as pecas
            *-- que serao compradas, tendo ou nao estoque
            IF !EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs != 1
                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                        Grupos, Estos, Estoque, EmpDs) ;
                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                        TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                        "", "", TmpFinal.Qtds, TmpFinal.Emps)
            ENDIF

            SELECT TmpFinal
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        loc_lGrvEest = .F.
        loc_cChave   = SPACE(30)
        loc_cChave2  = SPACE(22)
        loc_nCitens  = 1

        SELECT TmpEstoque
        SET ORDER TO EmpDopNum
        SCAN
            loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEstoque.CPros))
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TmpEstoque

            IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2) OR ;
                    (TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) != loc_cChave)

                IF TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2
                    loc_lGrvEest = .F.
                ENDIF
                loc_cChave2 = TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos
                loc_cChave  = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                loc_cEdn = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                loc_cQuery = "UPDATE SigMvCab SET Nops = " + FormatarNumeroSQL(loc_nNump, 0) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 5")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                loc_lProsseguir = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(TmpEstoque.Dopes))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF crSigCdOpe.Globalizas = 1
                    loc_cGrupoD = PADR(TempEest.Grupoos, 10)
                    loc_cContaD = PADR(TempEest.Contaos, 10)
                ELSE
                    loc_cGrupoD = PADR(TempEest.Grupods, 10)
                    loc_cContaD = PADR(TempEest.Contads, 10)
                ENDIF

                IF !EMPTY(THIS.this_cPamGruReservs)
                    loc_cGrupoD = PADR(THIS.this_cPamGruReservs, 10)
                ENDIF
                IF !EMPTY(THIS.this_cPamConReservs)
                    loc_cContaD = PADR(THIS.this_cPamConReservs, 10)
                ENDIF

                IF (THIS.this_nPamAgrupEmph = 2 AND !EMPTY(THIS.this_cPamGruReservs) ;
                        AND !loc_lGrvEest) OR (THIS.this_nPamAgrupEmph != 2)

                    loc_nNume   = fGerUniqueKey(TmpEstoque.EmpDs + loc_cDope)
                    loc_nCitens = 1

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Grupods, Contads, Nops, Obses, cIdChaves, ;
                            Dtalts, EmpDopNums, EmpDs) ;
                        VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                            ALLTRIM(fGerMascara(loc_nNume)), loc_dDtGera, DATETIME(), loc_cUsuar, ;
                            TmpEstoque.grupos, TmpEstoque.Estos, loc_cGrupoD, loc_cContaD, loc_nNump, ;
                            IIF(THIS.this_lReserva, ;
                                "[ Reserva Autom" + CHR(225) + "tica ]", ;
                                "[ OP: " + STR(loc_nNump) + "] ") + loc_cChave, ;
                            fUniqueIds(), DATETIME(), ;
                            TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), loc_cEmpr)
                    loc_lGrvEest = .T.
                ELSE
                    loc_cEdn = TmpEstoque.Emps + loc_cDope + STR(loc_nNume, 6)
                    IF !THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    loc_cPNop = TempEest.Obses + " / " + loc_cChave

                    loc_cQuery = "UPDATE SigMvCab SET Obses = " + EscaparSQL(loc_cPNop) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                        " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 6")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                ENDIF
            ENDIF

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
                VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, ;
                    TmpEstoque.Estoque, crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens)

            IF crSigCdGrp.TipoEstos > 1
                INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, ;
                        CodTams, QtdEmbs) ;
                    VALUES (loc_nCitens, TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                        TmpEstoque.CPros, TmpEstoque.Estoque, TmpEstoque.CodCors, ;
                        TmpEstoque.CodTams, 1)
            ENDIF

            loc_nCitens = loc_nCitens + 1

            IF !THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF crSigCdOpe.Estoqs = 1
                INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, ;
                        Qtds, Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, ;
                        OriDopNums, cIdChaves, Seqs) ;
                    VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), TmpEstoque.EmpDs, loc_cDope, ;
                        loc_nNume, loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "S", ;
                        TmpEstoque.Grupos, TmpEstoque.Estos, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                        TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                        TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos, ;
                        TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)

                INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, ;
                        Qtds, Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, ;
                        OriDopNums, cIdChaves, Seqs) ;
                    VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), loc_cEmpr, loc_cDope, loc_nNume, ;
                        loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "E", loc_cGrupoD, ;
                        loc_cContaD, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                        loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                        TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)
            ENDIF

            *-- Baixa da quantidade que NAO sera produzida (QtProds)
            loc_nQtBaixar = TmpEstoque.Estoque

            loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(TmpEstoque.Cpros)

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
                loc_lAbortar = .T.
                EXIT
            ENDIF
            GO TOP IN TempEsti2
            loc_lTemItem2 = !EOF("TempEsti2")

            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(TmpEstoque.Cpros)

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TempEestI
            SCAN WHILE loc_nQtBaixar > 0
                loc_cPIds = TempEestI.cIdChaves
                IF TempEestI.QtProds + loc_nQtBaixar <= TempEestI.Qtds
                    loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                    loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                    loc_nPQtd      = TempEestI.Qtds
                ENDIF

                loc_cQuery = "UPDATE SigMvItn SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    ", QtReservas = " + ;
                    IIF(THIS.this_lReserva, FormatarNumeroSQL(loc_nPQtd, 3), ;
                        FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 7")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF !loc_lTemItem2
                    INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, ;
                            Dopebs, Numebs, Qtdfs, CidChaves, EmpDopNums, EmpDopNumb) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEestI.CItens, ;
                            TempEestI.Cpros, loc_dDtGera, TempEestI.Emps, TempEestI.Dopes, ;
                            TempEestI.Numes, loc_nQtBaixado, fUniqueIds(), ;
                            loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6))
                ENDIF
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque

            SELECT TempEsti2
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR ;
                        (TempEsti2.CodTams != TmpEstoque.CodTams)
                    LOOP
                ENDIF

                loc_cPIds = TempEsti2.cIdChaves

                IF TempEsti2.QtProds + loc_nQtBaixar <= TempEsti2.Qtds
                    loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                    loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                    loc_nPQtd      = TempEsti2.Qtds
                ENDIF

                loc_cQuery = "UPDATE SigMvIts SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    ", QtReservas = " + ;
                    IIF(THIS.this_lReserva, FormatarNumeroSQL(loc_nPQtd, 3), ;
                        FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 8")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
                        Numebs, Qtdfs, CodCors, CodTams, cIdChaves, EmpDopNums, EmpDopNumb) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEsti2.CItens, TempEsti2.cpros, ;
                        loc_dDtGera, TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                        loc_nQtBaixado, TempEsti2.CodCors, TempEsti2.CodTams, fUniqueIds(), ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                        TempEsti2.Emps + TempEsti2.Dopes + STR(TempEsti2.Numes, 6))
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            SELECT TmpEstoque
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComponentes - Transcricao do dump 4929-5235. So roda com as
    * tres operacoes de componente configuradas (DopEmphs/DopReqcs/DopPedcs),
    * fora da Reserva Automatica e com geracao de empenho ligada (Emphpdr).
    *
    * Acumula em TmpPedra (necessidade por material), TmpMatPrz (necessidade
    * por prazo de entrega) e TmpEmpH (empenho por material + produto pai) as
    * pedras avulsas (SelPedra) e a composicao de cada produto a produzir;
    * desconta o que ja esta em aberto (empenho/requisicao/pedido/compra/
    * transferencia) e o estoque (SigMvEst); e gera o empenho
    * (SigCdPam.DopEmphs) e a requisicao de compra (SigCdPam.DopReqcs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComponentes()
        LOCAL loc_nQtde, loc_nPeso, loc_cBusca, loc_cQuery, loc_cSql
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEds, loc_cEdn
        LOCAL loc_cCgru, loc_cForn, loc_nQtdEmphs, loc_nQtd, loc_nTotReq, loc_nBaixa
        LOCAL loc_nPesMd, loc_nPesoReq, loc_dDtEnt, loc_lProsseguir

        IF EMPTY(THIS.this_cPamDopEmphs) OR EMPTY(THIS.this_cPamDopReqcs) OR ;
                EMPTY(THIS.this_cPamDopPedcs) OR THIS.this_lReserva OR ;
                EMPTY(THIS.this_nEmphPdr)
            RETURN
        ENDIF

        *-- 1) Pedras/componentes avulsos digitados na grade de Requisicoes
        IF USED("SelPedra")
            SELECT SelPedra
            SCAN
                IF EMPTY(SelPedra.Cpros) OR SelPedra.Qtds <= 0
                    LOOP
                ENDIF

                loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(SelPedra.Cpros))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                    loc_nQtde = SelPedra.Qtds

                    SELECT TmpPedra
                    IF !SEEK(SelPedra.Cpros)
                        INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                            VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins)
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpPedra

                    *-- Tiago - 13/03/2012 - Vianna: material necessario por
                    *-- prazo de entrega, para gerar requisicao por prazo
                    SELECT TmpMatPrz
                    IF !SEEK(DTOC(DATE()) + SelPedra.Cpros)
                        INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                            VALUES (SelPedra.cpros, DATE())
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpMatPrz

                    SELECT TmpEmpH
                    IF !SEEK(SelPedra.Cpros + SelPedra.Cpro2s)
                        INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                            VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins, SelPedra.Cpro2s)
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpEmpH
                ENDIF

                SELECT SelPedra
            ENDSCAN
        ENDIF

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 2) Composicao dos produtos a produzir
        SELECT TmpFinal
        SET ORDER TO Cpros
        SCAN
            IF TmpFinal.Produzir = 0
                LOOP
            ENDIF

            loc_cSql = "SELECT GerEmphs FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(TmpFinal.Dopes)
            IF !THIS.ExecutarSQL(loc_cSql, "TmpDcOpe", "TmpDcOpe")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TratarNulo(TmpDcOpe.GerEmphs, 0) != 1
                LOOP
            ENDIF

            loc_cEdn   = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
            loc_cBusca = THIS.BuscarCompos(loc_cEdn, TmpFinal.Cpros, TmpFinal.citens, "")
            IF !EMPTY(THIS.this_cMensagemErro)
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF USED("crSigPrCpo")
                USE IN crSigPrCpo
            ENDIF
            *-- "Select * from &lcBusca. into cursor crSigPrCpo READWRITE" do
            *-- legado, sem macro-substituicao: BuscarCompos() so devolve um
            *-- destes dois nomes (composicao substituida x padrao)
            IF loc_cBusca == "cursor_4c_CompoSub"
                SELECT * FROM cursor_4c_CompoSub INTO CURSOR crSigPrCpo READWRITE
            ENDIF
            IF loc_cBusca == "cursor_4c_CompoPad"
                SELECT * FROM cursor_4c_CompoPad INTO CURSOR crSigPrCpo READWRITE
            ENDIF

            IF USED("crSigPrCpo")
                SELECT crSigPrCpo
                SCAN
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(crSigPrCpo.Mats))
                    IF loc_lProsseguir
                        loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                    ENDIF
                    IF loc_lProsseguir
                        loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                    ENDIF
                    IF !loc_lProsseguir
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND ;
                            !EMPTY(crSigCdGrp.ConEstps)

                        loc_nQtde = TmpFinal.Produzir * crSigPrCpo.Qtds
                        loc_nPeso = TmpFinal.Produzir * CrSigPrCpo.Pesos

                        SELECT TmpPedra
                        IF !SEEK(crSigPrCpo.Mats)
                            INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                    crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpPedra

                        *-- Tiago - 13/03/2012 - Vianna: 1 = agrupa por
                        *-- fornecedor + prazo de entrega, 2 = so fornecedor
                        SELECT TmpMatPrz
                        loc_dDtEnt = IIF(THIS.this_nPacAgrupReqs = 1, ;
                            NVL(TmpFinal.Entregas, CTOD("")), DATE())
                        IF !SEEK(DTOC(loc_dDtEnt) + crSigPrCpo.Mats)
                            INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                VALUES (crSigPrCpo.Mats, loc_dDtEnt)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpMatPrz

                        SELECT TmpEmpH
                        IF !SEEK(CrSigPrCpo.Mats + CrSigPrCpo.Cpros)
                            INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                    crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins, ;
                                    CrSigPrCpo.Cpros)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpEmpH
                    ENDIF

                    SELECT crSigPrCpo
                ENDSCAN
                IF loc_lAbortar
                    EXIT
                ENDIF
            ENDIF

            SELECT TmpFinal
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 3) Desconta o que ja esta em aberto nas 5 operacoes de componente
        *--    (Tiago - 07/07/2015 - ChkSubn = 0 restringe as movimentacoes
        *--    ainda nao baixadas, por desempenho)
        FOR loc_nX = 1 TO 5
            DO CASE
                CASE loc_nX = 1
                    loc_cOperBusca = THIS.this_cPamDopEmphs
                CASE loc_nX = 2
                    loc_cOperBusca = THIS.this_cPamDopReqcs
                CASE loc_nX = 3
                    loc_cOperBusca = THIS.this_cPamDopPedcs
                CASE loc_nX = 4
                    loc_cOperBusca = THIS.this_cPamDopComps
                OTHERWISE
                    loc_cOperBusca = THIS.this_cPamDopTrfCps
            ENDCASE

            *-- lcCampo = 'Qtd' + Iif(X=1,'Emphs',Iif(X=2,'Reqs',
            *--           Iif(X=3,'Pedcs','Comps')))  -> X=4 e X=5 usam QtdComps
            DO CASE
                CASE loc_nX = 1
                    loc_cCampo = "QtdEmphs"
                CASE loc_nX = 2
                    loc_cCampo = "QtdReqs"
                CASE loc_nX = 3
                    loc_cCampo = "QtdPedcs"
                OTHERWISE
                    loc_cCampo = "QtdComps"
            ENDCASE

            IF EMPTY(loc_cOperBusca)
                LOOP
            ENDIF

            loc_cEds = loc_cEmpr + PADR(loc_cOperBusca, 20)

            loc_cQuery = "SELECT * FROM SigMvCab WHERE EmpDopNums BETWEEN " + ;
                EscaparSQL(loc_cEds + "     0") + " AND " + ;
                EscaparSQL(loc_cEds + "999999") + " AND ChkSubn = 0"

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEest", "TempEest")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TempEest
            SCAN
                loc_cEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                IF !THIS.ConsultarTabela("SigMvItn", "TempEestI", "EmpDopNums", loc_cEdn)
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                SELECT TempEestI
                SCAN
                    IF (TempEestI.Qtds - TempEestI.QtBaixas) > 0
                        SELECT TmpPedra
                        IF SEEK(TempEestI.Cpros)
                            DO CASE
                                CASE loc_cCampo = "QtdEmphs"
                                    REPLACE QtdEmphs WITH QtdEmphs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                CASE loc_cCampo = "QtdReqs"
                                    REPLACE QtdReqs WITH QtdReqs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                CASE loc_cCampo = "QtdPedcs"
                                    REPLACE QtdPedcs WITH QtdPedcs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                OTHERWISE
                                    REPLACE QtdComps WITH QtdComps + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT TempEestI
                ENDSCAN
                IF loc_lAbortar
                    EXIT
                ENDIF
                SELECT TempEest
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF
        ENDFOR

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 4) Estoque disponivel dos grupos/contas de componente
        loc_cQuery = "SELECT b.* FROM SigMvEst b" + ;
            " WHERE NOT b.Sqtds = 0 AND b.Grupos + b.Estos IN (" + ;
            "SELECT GruEstps + ConEstPs AS Contas FROM SigCdGrp" + ;
            " WHERE NOT GruEstPs = " + EscaparSQL(SPACE(10)) + ;
            " AND NOT ConEstPs = " + EscaparSQL(SPACE(10)) + ;
            " GROUP BY GruEstPs, ConEstPs)"

        IF !THIS.ExecutarSQL(loc_cQuery, "pEstoque", "pEstoque")
            loc_lAbortar = .T.
            RETURN
        ENDIF
        GO TOP IN pEstoque

        SELECT pEstoque
        SCAN
            SELECT TmpPedra
            *-- Tiago - 17/02/2012 - Vianna: a checagem de estoque tem de
            *-- olhar tambem o grupo/conta configurado no grupo de produtos
            IF SEEK(pEstoque.Cpros + pEstoque.Grupos + pEstoque.Estos, "TmpPedra", "MatGruCon")
                REPLACE QtdEsts WITH QtdEsts + pEstoque.Sqtds IN TmpPedra
            ENDIF
            SELECT pEstoque
        ENDSCAN

        *-- 5) Empenho dos componentes (SigCdPam.DopEmphs)
        SELECT TmpEmpH
        SET ORDER TO GruMat
        GO TOP
        loc_cCgru   = TmpEmpH.CGrus
        loc_nCitens = 9999
        SCAN
            IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEmpH.CMats))
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TmpEmpH.Cgrus != loc_cCgru
                loc_nCitens = 9999
                loc_cCgru   = TmpEmpH.Cgrus
            ENDIF

            IF loc_nCitens >= 9999
                loc_nCitens = 1
                loc_cDope   = PADR(THIS.this_cPamDopEmphs, 20)
                loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDope)

                INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                        Grupoos, Contaos, Nops, Obses, EmpDopNums, cIdChaves, DtAlts) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                        loc_dDtGera, DATETIME(), loc_cUsuar, TmpEmpH.Grupos, TmpEmpH.contas, ;
                        loc_nNump, "[ OP: " + STR(loc_nNump) + "] ", ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), DATETIME())
            ENDIF

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                    Citens, cPro2s, Pesos, cUnips) ;
                VALUES (loc_cEmpr, loc_cDope, loc_nNume, TmpEmpH.cMats, TmpEmpH.Qtds, ;
                    crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, TmpEmpH.Cpro2s, ;
                    TmpEmpH.Pesos, CrSigCdPro.cUniPs)

            loc_nCitens = loc_nCitens + 1
            SELECT TmpEmpH
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 6) Quantidade a requisitar por material (QtdGReqs)
        SELECT TmpPedra
        SCAN
            *-- Tiago - 19/08: nao checa estoque se a operacao de Requisicao
            *-- estiver configurada para nao checar (SigOpCdc.VerEsts = 2)
            loc_cDope = PADR(THIS.this_cPamDopReqcs, 20)

            loc_lProsseguir = THIS.ConsultarTabela("SigOpCdd", "crSigOpCdd", "Dopes", ;
                ALLTRIM(loc_cDope), "ChkResComp")
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigOpCdc", "crSigOpCdc", "Dopes", ;
                    ALLTRIM(loc_cDope), "verests")
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TratarNulo(crSigOpCdc.verests, 0) != 2

                *-- Rafael - 04/07/2016 - quantidade de pecas ja requisitadas
                *-- para o componente
                loc_nQtdEmphs = 0
                loc_cQuery = "select Isnull(SUM(qtds),0) - Isnull(SUM(qtbaixas),0) as Qtds" + ;
                    " from SigMvItn where empdopnums in(" + ;
                    " select empdopnums from SigMvCab where empdopnums in(" + ;
                    " SELECT distinct EmpDopNums FROM SigBxEst" + ;
                    " WHERE dopebs = " + EscaparSQL(ALLTRIM(loc_cDope)) + ;
                    " and cpros = " + EscaparSQL(TmpPedra.CMats) + " and qtdes > 0 )" + ;
                    " and chksubn = 0) and cpros = " + EscaparSQL(TmpPedra.CMats) + ;
                    " And chksubn = 0 "

                IF !THIS.ExecutarSQL(loc_cQuery, "pQtdsReq", "pQtdsReq")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                loc_nQtdEmphs = IIF(TratarNulo(pQtdsReq.Qtds, 0) > 0, TratarNulo(pQtdsReq.Qtds, 0), 0)

                IF TratarNulo(crSigOpCdd.ChkResComp, 0) != 1
                    loc_nQtd = TmpPedra.Qtds - (TmpPedra.QtdEsts - TmpPedra.QtdMins + ;
                        TmpPedra.QtdReqs + TmpPedra.QtdPedcs + TmpPedra.QtdComps - ;
                        TmpPedra.QtdEmphs + loc_nQtdEmphs)
                ELSE
                    loc_nQtd = (TmpPedra.Qtds - TmpPedra.QtdEsts)
                ENDIF

                IF loc_nQtd > 0
                    REPLACE QtdgReqs WITH loc_nQtd IN TmpPedra
                ENDIF
            ELSE
                *-- Tiago - 06/12/2011 - Muredu: sem checagem de estoque, gera
                *-- requisicao de toda a composicao
                REPLACE QtdgReqs WITH TmpPedra.Qtds IN TmpPedra
            ENDIF

            SELECT TmpPedra
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 7) Requisicao de compra (SigCdPam.DopReqcs), por fornecedor + prazo
        SELECT TmpPedra
        SET ORDER TO GruMat
        GO TOP
        loc_cCgru = TmpPedra.CGrus

        *-- Tiago - 31/01/2011 - requisicao por fornecedor
        IF !THIS.ConsultarTabela("SigCdPro", "crTmpPro", "CPros", ALLTRIM(TmpPedra.CMats), "ifors")
            loc_lAbortar = .T.
            RETURN
        ENDIF
        loc_cForn = PADR(crTmpPro.Ifors, 10)

        loc_nCitens = 9999
        SELECT TmpPedra
        SCAN
            IF TmpPedra.QtdGreqs <= 0
                LOOP
            ENDIF
            loc_nTotReq = TmpPedra.QtdGreqs

            loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpPedra.CMats))
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "LocalUni", "CUnis", ;
                    ALLTRIM(crSigCdPro.CUniPs), "Fators")
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            DO WHILE loc_nTotReq > 0 AND !loc_lAbortar
                SELECT TmpMatPrz
                SCAN FOR TmpMatPrz.CMats = TmpPedra.CMats
                    IF TmpMatPrz.Qtds - TmpMatPrz.QtBaixas > 0
                        EXIT
                    ENDIF
                ENDSCAN

                loc_nBaixa = IIF(TmpMatPrz.Qtds > TmpMatPrz.QtBaixas AND ;
                    loc_nTotReq >= TmpMatPrz.Qtds, ;
                    (TmpMatPrz.Qtds - TmpMatPrz.QtBaixas), loc_nTotReq)
                loc_nTotReq = loc_nTotReq - loc_nBaixa
                REPLACE TmpMatPrz.QtBaixas WITH TmpMatPrz.QtBaixas + loc_nBaixa IN TmpMatPrz

                SELECT crSigMvCab
                GO TOP
                LOCATE FOR crSigMvCab.Dopes = PADR(THIS.this_cPamDopReqcs, 20) ;
                       AND crSigMvCab.PrazoEnts = IIF(EMPTY(TmpMatPrz.PrazoEnts), DATE(), ;
                            TmpMatPrz.PrazoEnts) ;
                       AND crSigMvCab.ContaDs = PADR(crSigCdPro.Ifors, 10)
                IF !EOF("crSigMvCab")
                    loc_cDope = crSigMvCab.Dopes
                    loc_nNume = crSigMvCab.Numes

                    SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                        WHERE crTpmMvItn.Emps = m.loc_cEmpr ;
                          AND crTpmMvItn.Dopes = m.loc_cDope ;
                          AND crTpmMvItn.Numes = m.loc_nNume ;
                        INTO CURSOR TmpUltItn
                    loc_nCitens = NVL(TmpUltItn.Citens, 0) + 1
                ELSE
                    loc_nCitens = 9999
                    loc_cCgru   = TmpPedra.Cgrus
                    loc_cForn   = PADR(crSigCdPro.Ifors, 10)
                ENDIF

                IF loc_nCitens >= 9999
                    loc_nCitens = 1
                    loc_cDope   = PADR(THIS.this_cPamDopReqcs, 20)
                    loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDope)

                    IF !THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                    loc_cForn = PADR(IIF(!EMPTY(loc_cForn), loc_cForn, crSigCdOpe.ConOrigs), 10)

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, ;
                            cIdChaves, DtAlts, PrazoEnts) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                            loc_dDtGera, DATETIME(), loc_cUsuar, crSigCdOpe.GruOrigs, loc_cForn, ;
                            crSigCdOpe.GruDests, crSigCdOpe.ConDests, loc_nNump, ;
                            "[ OP: " + STR(loc_nNump) + "] ", ;
                            loc_cEmpr + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), DATETIME(), ;
                            TmpMatPrz.PrazoEnts)
                ENDIF

                *-- Tiago - 12/04/2011 - Vianna: com o fator da segunda unidade
                *-- em 0 ou 1 o campo Peso controla QUANTIDADE, entao nao ha
                *-- calculo de peso total
                loc_nPesMd = IIF(TmpPedra.Pesos = 0, 0, ;
                    IIF(INLIST(TratarNulo(LocalUni.Fators, 0), 0, 1), ;
                        (TmpPedra.Qtds / TmpPedra.Pesos), (TmpPedra.Pesos / TmpPedra.Qtds)))
                loc_nPesoReq = IIF(INLIST(TratarNulo(LocalUni.Fators, 0), 0, 1), ;
                    TmpPedra.Pesos, ROUND(loc_nBaixa * loc_nPesMd, 3))

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                        Citens, Pesos, cUniPs) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, TmpPedra.cMats, loc_nBaixa, ;
                        crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, loc_nPesoReq, ;
                        CrSigCdPro.cUniPs)

                loc_nCitens = loc_nCitens + 1
            ENDDO

            IF loc_lAbortar
                EXIT
            ENDIF
            SELECT TmpPedra
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsolidarMovimentoItens - Transcricao do dump 5237-5252. Transfere os
    * cursores de trabalho crTpmMvItn/crTplMvIts (itens montados ao longo do
    * processamento) para os cursores de GRAVACAO crSigMvItn/crSigMvIts,
    * gerando cIdChaves e EmpDopNums de cada linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConsolidarMovimentoItens()

        SELECT crTpmMvItn
        SCAN
            INSERT INTO crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                    Citens, EmpDopNums, CidChaves, DtAlts, cpro2s, Pesos, cUniPs, Obs) ;
                VALUES (crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CPros, ;
                    crTpmMvItn.Qtds, crTpmMvItn.Cunis, crTpmMvItn.Dpros, crTpmMvItn.Opers, ;
                    crTpmMvItn.citens, ;
                    crTpmMvItn.Emps + crTpmMvItn.Dopes + STR(crTpmMvItn.Numes, 6), ;
                    fUniqueIds(), DATETIME(), crTpmMvItn.Cpro2s, crTpmMvItn.Pesos, ;
                    crTpmMvItn.cUniPs, crTpmMvItn.Obs)
            SELECT crTpmMvItn
        ENDSCAN

        SELECT crTplMvIts
        SCAN
            INSERT INTO crSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, ;
                    CidChaves, EmpDopNums, QtdEmbs) ;
                VALUES (crTplMvIts.Citens, crTplMvIts.Emps, crTplMvIts.Dopes, crTplMvIts.Numes, ;
                    crTplMvIts.CPros, crTplMvIts.Qtds, crTplMvIts.CodCors, crTplMvIts.CodTams, ;
                    fUniqueIds(), ;
                    crTplMvIts.Emps + crTplMvIts.Dopes + STR(crTplMvIts.Numes, 6), 1)
            SELECT crTplMvIts
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEntradaAutomatica - Transcricao do dump 5254-5417. So roda com
    * SigCdPam.DopEntAus + SigCdPam.TpOpEntAus configurados e DBParam.EntPes=1
    * (o "entrega peso" do tipo de geracao da O.P.): transfere GrSigCdNei para
    * o cursor de gravacao crSigCdNei, criando a necessidade (crSigCdNec) e o
    * historico de estoque (crSigMvHst) da operacao de entrada automatica.
    *
    * Dois ramos, conforme a operacao (SigCdOpd) tenha ou nao grupo/conta de
    * DESTINO: com destino, tudo eh agrupado numa unica necessidade; sem
    * destino, ha uma necessidade por combinacao Dopps+origem+destino.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEntradaAutomatica()
        LOCAL loc_cTpOp, loc_nTPesoAc, loc_lGravou, loc_cMat, loc_nQtde, loc_nPesoIt
        LOCAL loc_cOper, loc_cIds, loc_nEnv, loc_nPesoAc

        loc_cDopEntAu = PADR(THIS.this_cPamDopEntAus, 20)
        loc_cTpOp     = THIS.this_cPamTpOpEntAus

        IF EMPTY(loc_cDopEntAu) OR EMPTY(loc_cTpOp) OR THIS.this_nDbEntPes != 1
            RETURN
        ENDIF

        SELECT crSigCdNec
        INDEX ON EmpDnPs TAG EmpDnPs
        INDEX ON Dopps + GrupoOs + ContaOs + GrupoDs + ContaDs TAG DopEntAu

        SELECT GrSigCdNei
        LOCATE FOR .F.

        IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopEntAu), ;
                "Dopps, GruOrigs, ConOrigs, GruDests, ConDests, Origems, Destinos, EstOrigs, EstDests")
            loc_lAbortar = .T.
            RETURN
        ENDIF

        IF !EMPTY(crSigCdOpd.GruDests) AND !EMPTY(crSigCdOpd.ConDests)

            loc_cGrupoC = PADR(crSigCdOpd.GruOrigs, 10)
            loc_cContaC = PADR(crSigCdOpd.ConOrigs, 10)
            loc_cGrupoD = PADR(crSigCdOpd.GruDests, 10)
            loc_cContaD = PADR(crSigCdOpd.ConDests, 10)

            loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))

            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            SELECT Cmats, Cdescs, cUnis, TpOps, Nops, Nenvs, SUM(Pesos) AS Pesos, ;
                    SUM(Qtds) AS Qtds, SUM(Peso2s) AS Peso2s ;
                FROM GrSigCdNei INTO CURSOR TmpNensi GROUP BY 1, 2, 3, 4, 5, 6

            SELECT TmpNensi

            loc_nTPesoAc = 0
            loc_lGravou  = .F.

            SCAN
                loc_lGravou = .T.
                loc_cMat    = TmpNensi.Cmats

                IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "Cpros", ALLTRIM(loc_cMat), ;
                        "Cpros, Dpros, Cunis, MatPrincs")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, ;
                        TpOps, EmpDNps, cIdChaves, Peso2s, Nenvs, Nops) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, TmpNensi.Cmats, ;
                        TmpNensi.cDescs, TmpNensi.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, ;
                        THIS.this_cPamTpOpEntAus, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), ;
                        TmpNensi.peso2s, TmpNensi.Nenvs, TmpNensi.Nops)

                loc_nTPesoAc = loc_nTPesoAc + TmpNensi.Pesos
                loc_nQtde    = TmpNensi.Qtds
                loc_nPesoIt  = TmpNensi.Peso2s

                IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    *-- DtAudits: o legado grava Null; {} persiste como NULL
                    *-- identico (FormatarDataSQL trata os dois casos)
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidchaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT TmpNensi
            ENDSCAN

            IF loc_lAbortar
                RETURN
            ENDIF

            IF loc_lGravou
                loc_cIds = DTOS(DATE()) + ;
                    TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, ;
                        Contaos, Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), ;
                        loc_cUsuar, loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, ;
                        loc_nTPesoAc, loc_nNumpe, loc_cIds, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10))
            ENDIF

        ELSE

            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            SELECT * FROM GrSigCdNei INTO CURSOR TmpNensi ORDER BY EmpDnPs, Nops

            loc_nPesoAc  = 0
            loc_nTPesoAc = 0

            SELECT TmpNensi
            SCAN
                loc_nEnv = TmpNensi.nEnvs

                = SEEK(TmpNensI.EmpDnPs, "crSigCdNec", "EmpDnPs")

                loc_cGrupoC = PADR(crSigCdNec.GrupoOs, 10)
                loc_cContaC = PADR(crSigCdNec.ContaOs, 10)
                loc_cGrupoD = PADR(IIF(!EMPTY(crSigCdOpd.GruDests), crSigCdOpd.GruDests, ;
                    crSigCdNec.GrupoDs), 10)
                loc_cContaD = PADR(crSigCdNec.ContaDs, 10)

                IF !SEEK(loc_cDopEntAu + loc_cGrupoC + loc_cContaC + loc_cGrupoD + loc_cContaD, ;
                        "crSigCdNec", "DopEntAu")

                    loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))
                    loc_cIds = DTOS(DATE()) + ;
                        TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                    INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, ;
                            Contaos, Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps, Docus) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), ;
                            loc_cUsuar, loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, ;
                            loc_nTPesoAc, loc_nNumpe, loc_cIds, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), STR(loc_nNumpe))

                    loc_nPesoAc  = 0
                    loc_nTPesoAc = 0
                ENDIF

                SELECT TmpNensi
                loc_nQtde   = TmpNensi.Qtds
                loc_nPesoIt = TmpNensi.Peso2s
                loc_cMat    = TmpNensi.cMats

                loc_nTPesoAc = loc_nTPesoAc + TmpNensi.Pesos

                IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "Cpros", ALLTRIM(loc_cMat), ;
                        "Cpros, Dpros, Cunis, MatPrincs")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, ;
                        TpOps, EmpDNps, cIdChaves, nenvs, Peso2s, Nops) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, loc_cMat, crSigCdPro.Dpros, ;
                        crSigCdPro.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, ;
                        THIS.this_cPamTpOpEntAus, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), ;
                        loc_nEnv, TmpNensi.Peso2s, TmpNensi.Nops)

                IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidchaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT TmpNensi
            ENDSCAN
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarMovimentos - Transcricao do dump 5419-5479: chaves primarias do
    * historico (GravaHis) e gravacao efetiva dos nove cursores nas tabelas,
    * tudo em UMA transacao manual (a conexao deste ambiente nasce com
    * Transactions = 2), como o Commit()/RollBack() unico do legado.
    *
    * NAO transcrito: "Select Min(Datas) as Datas From CrSigMvCab Into Cursor
    * TmpGdm" (linha 5423) - o cursor TmpGdm eh criado e NUNCA lido, nem aqui
    * nem no resto do form (conferido no dump inteiro).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarMovimentos()
        LOCAL loc_lErro

        SELECT crSigMvHst
        GO TOP
        IF !THIS.GravaHis()
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        loc_lErro = .F.

        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPic", "SigOpPic")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigBxEst", "SigBxEst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP(.t., poDataMgr) / fRecalculaC(.t.,.f.,.f., poDataMgr):
        *-- omitidos (ver NOTA DE ESCOPO). Nao marcam llErro - abortar por
        *-- causa de uma funcao inexistente desfaria toda a geracao da O.P.

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarModoAutomatico - Transcricao do dump 5491-5891 ("If ThisForm.
    * automatico ... EndIf"). Gera automaticamente o fluxo de fases de
    * producao da O.P. recem-criada: para cada item da O.P. (TmpOpi) percorre
    * a sequencia de fases da linha (SigCdLnf), criando a necessidade
    * (crSigCdNec), o programa de fases (crSigPdMvf), os componentes de cada
    * fase (crSigCdNei) e o historico de estoque (crSigMvHst), e grava tudo
    * numa SEGUNDA transacao.
    *
    * As quatro validacoes de operacao automatica (SigCdOpd.Autos = 1 de
    * Movimento e = 2 de Encerramento, exigindo EXATAMENTE uma de cada) viram
    * this_cMensagemErro + retorno .F., no lugar dos MessageBox + Cancelar.
    * Click() + Return 0 do legado. O fechamento da tela fica no FORM.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarModoAutomatico()
        LOCAL loc_lOk, loc_lErro, loc_cSql, loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD
        LOCAL loc_dDtGe, loc_cUsuarLin, loc_nQtAnt, loc_nPsAnt, loc_nTran, loc_nInicio
        LOCAL loc_cIds, loc_cOper, loc_cXOper
        LOCAL ARRAY loc_aNensi[1, 18]

        loc_lOk   = .T.
        loc_lErro = .F.

        *-- Operacao de producao automatica de MOVIMENTO (Autos = 1)
        IF !THIS.ExecutarSQL("Select dopps From SigCdOpd where Autos = 1 ", ;
                "CrSigCdOpd", "CrSigCdOpd - Autos 1")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrSigCdOpd

        *-- Operacao de producao automatica de ENCERRAMENTO (Autos = 2)
        IF !THIS.ExecutarSQL("Select Dopps From SigCdOpd Where Autos = 2 ", ;
                "CrTmpOpp", "CrTmpOpp - Autos 2")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrTmpOpp
        loc_cDpTrf = PADR(CrTmpOpp.Dopps, 20)

        *-- Reabre os quatro cursores de gravacao (o legado faz Zap) e cria
        *-- os indices que este bloco usa
        IF !THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
            RETURN .F.
        ENDIF
        SELECT crSigPdMvf
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
            RETURN .F.
        ENDIF
        SELECT crSigCdNec
        INDEX ON Grupoos + contaOs + GrupoDs + ContaDs + DTOS(Datas) + STR(nAceites, 10) TAG Gravacao

        IF !THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
            RETURN .F.
        ENDIF
        SELECT crSigCdNei
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
            RETURN .F.
        ENDIF

        SELECT crSigCdNei
        = AFIELDS(loc_aNensi, "crSigCdNei")
        IF USED("xNensi")
            USE IN xNensi
        ENDIF
        CREATE CURSOR xNensi FROM ARRAY loc_aNensi

        *-- Fases de producao por linha
        IF !THIS.ExecutarSQL("Select * From SigCdLnf ", "cursor_4c_LinfTmp", "TmpLinf")
            RETURN .F.
        ENDIF
        IF USED("TmpLinF")
            USE IN TmpLinF
        ENDIF
        SELECT * FROM cursor_4c_LinfTmp INTO CURSOR TmpLinF READWRITE
        USE IN cursor_4c_LinfTmp
        SELECT TmpLinF
        INDEX ON Linhas + STR(Ordems, 2) TAG Linhas

        loc_nNopI = (loc_nNump * 10000) + 1
        loc_nNopF = (loc_nNump * 10000) + 9999
        loc_nSeq  = 1

        *-- ATENCAO - CORRECAO DE DEFEITO DO LEGADO: a consulta original
        *-- (dump 5554-5555) NAO traz EmpDopNums nem Citens, mas a consulta de
        *-- composicao logo abaixo (5566) referencia TmpOpi.empdopnums e
        *-- TmpOpi.citens - em VFP isso estoura "Variable not found" em
        *-- runtime. As duas colunas foram acrescentadas como MAX(), e NAO no
        *-- GROUP BY, justamente para NAO alterar a granularidade do
        *-- agrupamento original (dentro de um mesmo Nops/Cpros/CodTams as
        *-- linhas de SigOpPic compartilham a mesma origem).
        loc_cSql = "Select a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams," + ;
            " MAX(a.EmpDopNums) as EmpDopNums, MAX(a.Citens) as Citens," + ;
            " sum(a.Qtds) as Qtds, Sum(a.Pesos) as Pesos From SigOpPic a, SigCdPro b " + ;
            "Where a.Nops Between " + FormatarNumeroSQL(loc_nNopI, 0) + " And " + ;
            FormatarNumeroSQL(loc_nNopF, 0) + " And a.cpros = b.cpros " + ;
            "Group by a.Cpros, a.Nops, b.Linhas, b.Cunis, a.EmpDopNops, a.CodTams "

        IF !THIS.ExecutarSQL(loc_cSql, "cursor_4c_OpiTmp", "TmpOpi")
            RETURN .F.
        ENDIF
        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        SELECT * FROM cursor_4c_OpiTmp INTO CURSOR TmpOpi READWRITE
        USE IN cursor_4c_OpiTmp
        SELECT TmpOpi
        INDEX ON Nops TAG Nops
        INDEX ON Linhas + cpros TAG Linha

        SELECT TmpOpi
        SCAN
            *-- Composicao SUBSTITUIDA na O.P. e, na falta dela, a composicao
            *-- PADRAO do produto (com a substituicao por tamanho de SigSubCp)
            loc_cSql = "Select a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros," + ;
                " c.Fators, b.Varias, d.Mercs " + ;
                "From SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d " + ;
                "Where a.empdopnums = " + EscaparSQL(TmpOpi.empdopnums) + ;
                " and a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                " and a.citem2 = " + FormatarNumeroSQL(TmpOpi.citens, 0) + ;
                " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus "

            IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo")
                loc_lOk = .F.
                EXIT
            ENDIF

            IF RECCOUNT("TmpCompo") = 0
                loc_cSql = "Select a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators," + ;
                    " b.Varias, d.Mercs, " + ;
                    "Case When e.Qtds is null Then a.Qtds Else e.Qtds End as Qtds " + ;
                    "From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros " + ;
                    "Inner Join SigCdUni c On b.Cunis = c.Cunis " + ;
                    "Inner Join SigCdGrp d On b.Cgrus = d.Cgrus " + ;
                    "Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = " + ;
                    EscaparSQL(TmpOpi.CodTams) + " " + ;
                    "Where a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                    " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus"

                IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo - padrao")
                    loc_lOk = .F.
                    EXIT
                ENDIF
            ENDIF

            *-- "Select xNensi / Zap": recria vazio (ZAP em DataSession
            *-- privada ja travou a tela neste projeto)
            IF USED("xNensi")
                USE IN xNensi
            ENDIF
            CREATE CURSOR xNensi FROM ARRAY loc_aNensi

            SELECT TmpLinF
            IF !SEEK(TmpOpi.Linhas)
                MsgAviso("Linha :" + ALLTRIM(TmpOpi.Linhas) + " do Produto: " + ;
                    ALLTRIM(TmpOpi.cpros) + " nao Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT TmpOpi
                LOOP
            ENDIF
            loc_cGrpO     = PADR(TmpLinF.Grupos, 10)
            loc_cCtaO     = PADR(TmpLinF.Contas, 10)
            loc_dDtGe     = loc_dDtGera + TmpLinf.nDias
            loc_cUsuarLin = PADR(IIF(EMPTY(TmpLinf.Usuars), loc_cUsuar, TmpLinf.Usuars), 10)

            IF DOW(loc_dDtGe) = 7
                loc_dDtGe = loc_dDtGe + 2
            ELSE
                IF DOW(loc_dDtGe) = 1
                    loc_dDtGe = loc_dDtGe + 1
                ENDIF
            ENDIF

            SELECT TmpLinF
            SKIP
            SCAN WHILE TmpLinF.Linhas = TmpOpi.Linhas
                loc_cGrpD = PADR(TmpLinf.Grupos, 10)
                loc_cCtaD = PADR(TmpLinf.Contas, 10)

                SELECT crSigCdNec
                IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + ;
                        STR(TmpLinf.Ordems, 10))
                    APPEND BLANK
                    REPLACE GrupoOs  WITH loc_cGrpO, ;
                            ContaOs  WITH loc_cCtaO, ;
                            GrupoDs  WITH loc_cGrpD, ;
                            ContaDs  WITH loc_cCtaD, ;
                            Datas    WITH loc_dDtGe, ;
                            Dopps    WITH CrSigCdOpd.Dopps, ;
                            nTrans   WITH loc_nSeq, ;
                            Usuars   WITH loc_cUsuarLin, ;
                            nAceites WITH TmpLinf.Ordems ;
                        IN crSigCdNec

                    loc_nSeq = loc_nSeq + 1
                ENDIF

                INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, ;
                        Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                    VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, ;
                        TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, ;
                        TmpLinf.Ordems, CrSigCdNec.nTrans, loc_cUsuarLin)

                IF !EMPTY(TmpLinf.Cgrus) OR !EMPTY(TmpLinf.Mercs)
                    SELECT TmpCompo
                    SCAN
                        IF (TmpCompo.Cgrus = TmpLinf.Cgrus AND !EMPTY(TmpLinf.Cgrus)) OR ;
                                (TmpCompo.Mercs = TmpLinf.Mercs AND !EMPTY(TmpLinf.Mercs))

                            IF TmpCompo.Varias = 1 AND TmpOpi.Cpros != THIS.this_cPamOuros
                                loc_nQtAnt = TmpOpi.Pesos
                                loc_nPsAnt = TmpOpi.Pesos
                            ELSE
                                loc_nQtAnt = TmpCompo.Qtds * TmpOpi.Qtds
                                loc_nPsAnt = IIF(TmpCompo.Fators != 0, ;
                                    loc_nQtAnt * Tmpcompo.Fators, TmpCompo.Pesoms * TmpOpi.Qtds)
                            ENDIF

                            INSERT INTO xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                                    Qtds, Pesos) ;
                                VALUES (TmpOpi.Nops, TmpOpi.Nops, TmpCompo.Mats, ;
                                    TmpCompo.Dpros, TmpCompo.CUnis, TmpCompo.CGrus, ;
                                    loc_nQtAnt, loc_nPsAnt)
                        ENDIF
                        SELECT TmpCompo
                    ENDSCAN
                ENDIF

                SELECT xNensi
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO crSigCdNei FROM MEMVAR
                    REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                    SELECT xNensi
                ENDSCAN

                SELECT TmpLinF
            ENDSCAN

            loc_cGrpD = PADR(THIS.this_cPamGruConfs, 10)
            loc_cCtaD = PADR(THIS.this_cPamConConfs, 10)

            SELECT crSigCdNec
            IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + STR(99, 10))
                APPEND BLANK
                REPLACE GrupoOs  WITH loc_cGrpO, ;
                        ContaOs  WITH loc_cCtaO, ;
                        GrupoDs  WITH loc_cGrpD, ;
                        ContaDs  WITH loc_cCtaD, ;
                        Datas    WITH loc_dDtGe, ;
                        Dopps    WITH loc_cDpTrf, ;
                        Usuars   WITH loc_cUsuar, ;
                        nTrans   WITH loc_nSeq, ;
                        nAceites WITH 99 ;
                    IN crSigCdNec

                loc_nSeq = loc_nSeq + 1
            ENDIF

            INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, ;
                    Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, TmpOpi.Nops, ;
                    TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, TmpLinf.Ordems, ;
                    CrSigCdNec.nTrans, loc_cUsuar)

            SELECT xNensi
            SCAN
                SCATTER MEMVAR
                INSERT INTO crSigCdNei FROM MEMVAR
                REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                SELECT xNensi
            ENDSCAN

            SELECT TmpOpi
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        *-- Numeracao definitiva das necessidades + historico das fases
        SELECT crSigCdNec
        INDEX ON DTOS(Datas) + STR(nAceites, 10) TAG Datas
        SCAN
            loc_nTran   = crSigCdNec.nTrans
            loc_nInicio = fGerUniqueKey(ALLTRIM(CrSigCdNec.Dopps) + loc_cEmpr)
            loc_cIds    = DTOS(CrSigCdNec.Datas) + ;
                TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey

            REPLACE Emps      WITH loc_cEmpr, ;
                    Numps     WITH loc_nInicio, ;
                    Datars    WITH DATETIME(), ;
                    Nops      WITH loc_nNopI, ;
                    Autos     WITH .T., ;
                    CidChaves WITH loc_cIds, ;
                    EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                IN crSigCdNec

            SELECT crSigPdMvf
            = SEEK(loc_nTran)
            SCAN WHILE crSigPdMvf.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        Usuars    WITH CrSigCdNec.Usuars, ;
                        Datars    WITH DATETIME(), ;
                        Datas     WITH CrSigCdNec.Datas, ;
                        CidChaves WITH DTOS(CrSigCdNec.Datas) + ;
                            TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                            THIS.this_cSigKey, ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigPdMvf
                SELECT crSigPdMvf
            ENDSCAN

            loc_cSql = "Select * From SigCdOpd Where Dopps = " + ;
                EscaparSQL(ALLTRIM(CrSigCdNec.Dopps))
            IF !THIS.ExecutarSQL(loc_cSql, "CrSigCdOpd", "CrSigCdOpd - fase")
                loc_lOk = .F.
                EXIT
            ENDIF

            SELECT crSigCdNei
            = SEEK(loc_nTran)
            SCAN WHILE crSigCdNei.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        CidChaves WITH fUniqueIds(), ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigCdNei

                loc_cSql = "Select Cgrus From SigCdPro Where Cpros = " + ;
                    EscaparSQL(ALLTRIM(CrSigCdNei.Cmats))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalPro", "LocalPro")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                loc_cSql = "Select cEstoqs From SigCdGrp Where Cgrus = " + ;
                    EscaparSQL(ALLTRIM(LocalPro.Cgrus))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalGru", "LocalGru")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF INLIST(crSigCdOpd.EstOrigs, 1, 2) AND (crSigCdOpd.BxOEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper  = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    loc_cXOper = loc_cOper
                    *-- Tiago - 23/10/2015: grava no cidchaves a MESMA letra da
                    *-- movimentacao (o bloco *!* que trocava por H/K esta
                    *-- desativado no legado)
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cXOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupoos, ;
                            CrSigCdNec.Contaos, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupoos + CrSigCdNec.Contaos, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper  = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    loc_cXOper = loc_cOper
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cXOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT crSigCdNei
            ENDSCAN

            IF !loc_lOk
                EXIT
            ENDIF

            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 1)

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                SELECT DISTINCT b.Nops, b.Cpros, b.Qtds ;
                    FROM crSigCdNei a, TmpOpi b ;
                    WHERE a.nTrans = m.loc_nTran AND a.Nops = b.Nops ;
                    INTO CURSOR TmpHis

                loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")

                SELECT TmpHis
                SCAN
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNec.Numps, CrSigCdNec.Datas, ;
                            TmpHis.CPros, loc_cEmpr, TmpHis.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    SELECT TmpHis
                ENDSCAN
            ENDIF

            SELECT crSigCdNec
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigMvHst
        GO TOP

        *-- Marca como subnotada a necessidade original de cada item da O.P.
        SELECT TmpOpi
        SCAN
            loc_cSql = "Select CidChaves From SigCdNec Where EmpDnPs = " + ;
                EscaparSQL(TmpOpi.EmpDopNops)
            IF !THIS.ExecutarSQL(loc_cSql, "LocalNens", "Update - crSigCdNec")
                loc_lErro = .T.
                EXIT
            ENDIF

            SELECT LocalNens
            SCAN
                loc_cSql = "Update SigCdNec Set ChkSubn = 1 Where cidChaves = " + ;
                    EscaparSQL(LocalNens.CidChaves)
                IF !THIS.ExecutarSQL(loc_cSql, "", "Update - crSigCdNec 1")
                    loc_lErro = .T.
                    EXIT
                ENDIF
                SELECT LocalNens
            ENDSCAN
            IF loc_lErro
                EXIT
            ENDIF
            SELECT TmpOpi
        ENDSCAN

        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP / fRecalculaC de lote: omitidos (ver NOTA DE ESCOPO)

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

ENDDEFINE

