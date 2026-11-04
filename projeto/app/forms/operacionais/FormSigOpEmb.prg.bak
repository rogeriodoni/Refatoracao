*==============================================================================
* FormSigOpEmb.prg - Dialogo "Quantidade de Embalagens" de um item de
* movimento - SIGOEMB
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - popup modal aberto a partir de um item de
*          movimento (SigMvCab/SigMvItn/SigMvIte), para digitar a
*          quantidade de cada embalagem cadastrada (SigCdEmb) e devolver
*          o peso total ao form pai.
*
* Chamada: CREATEOBJECT("FormSigOpEmb", par_oFormPai, par_nCitens, ;
*              par_cEmps, par_cDopes, par_nNumes)
*          (equivale ao legado "LParameters poForm, pCnx" - sem pCnx, que
*          nao existe mais neste ambiente, ja que o BO usa o handle
*          global gnConnHandle; o contexto da movimentacao (Emps/Dopes/
*          Numes/Citens), que o legado lia direto de crTpmMvItn/
*          TprMvCab por estarem na mesma data session do form pai, chega
*          aqui por PARAMETRO)
*
* Historico de fases:
*   Fase 1/2: SigOpEmbBO.prg (propriedades + CRUD completo)
*   Fase 3:   FormSigOpEmb.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame, ConfigurarCabecalho,
*             TornarControlesVisiveis, Destroy)
*   Fase 4:   grade de embalagens (grd_4c_Dados, 4 colunas) + CommandGroup
*             de confirmacao (cmg_4c_Botoes, 1 botao) + funil de carga
*             (CarregarLista/VincularGrade/RepintarGrade) + Valid da
*             celula de quantidade + devolucao do peso total ao form pai
*   Fase 5/6: auditoria propriedade-a-propriedade contra a SECAO 2 do dump
*             (flags de janela que faltavam) + trava das colunas
*             calculadas. NAO havia campo nem lookup a acrescentar - ver
*             as duas secoes abaixo, que registram a MEDICAO.
*   Fase 7:   auditoria de EVENTOS PRINCIPAIS - nada a acrescentar, ver
*             secao abaixo.
*   Fase 8:   consolidacao final. Fechado o unico trecho do legado que
*             ainda estava pela metade - as TRES primeiras linhas do
*             PROCEDURE Release (desvinculo da grade ANTES de fechar o
*             cursor), hoje em DesvincularGrade; e o Destroy deixou de
*             repetir os nomes de cursor em literal, passando a le-los
*             das properties do BO (FecharCursoresDoDialogo). Ver a
*             secao "CONSOLIDACAO (Fase 8)" abaixo, que registra a
*             MEDICAO do resto.
*
* CONSOLIDACAO (Fase 8): BtnBuscarClick / BtnEncerrarClick /
*     BtnSalvarClick / BtnCancelarClick / HabilitarCampos / LimparCampos /
*     AjustarBotoesPorModo NAO existem aqui, e FormParaBO / BOParaForm
*     ficam com o hook VAZIO herdado de FormBase. Nao eh omissao - eh o
*     que a tela tem:
*
*     - UM botao, provado pela SECAO 1/2 do dump (cntBotoes,
*       ButtonCount = 1). Nao ha Buscar, nao ha Salvar separado do
*       Encerrar e nao ha Cancelar: o Caption eh "\<Encerrar", o
*       ToolTipText eh "Confirmar a Selecao" e o Click GRAVA. Com
*       Closable = .F. e Cancel = .T. nesse mesmo botao, o ESC tambem
*       CONFIRMA - esta tela nao tem como desistir, e isso eh do legado.
*       O handler existe desde a Fase 4 batizado pela ACAO
*       (BtnConfirmarClick), nao pelo rotulo da tecla.
*     - NENHUM modo: o legado nao tem pcEscolha, nao e' frmcadastro e nao
*       tem Grupo_Op. Sem INCLUIR/ALTERAR/VISUALIZAR nao ha o que
*       HabilitarCampos habilitar nem o que AjustarBotoesPorModo ajustar,
*       e LimparCampos (chamado por FormBase.Novo) nao tem registro novo
*       para limpar - a grade ja abre com as quantidades gravadas do item
*       (o LEFT JOIN do Init legado).
*     - FormParaBO/BOParaForm mapeiam CAMPO A CAMPO uma ficha de Page2.
*       Aqui nao ha campo fora da grade (medido na Fase 5, secao CAMPOS
*       abaixo) e a grade esta ligada DIRETO ao cursor que o BO cria e
*       possui, entao nao existe par tela<->property para espelhar: a
*       transferencia form -> BO acontece por ARGUMENTO
*       (ValidarQuantidadeGrade passa par_oTxt.Value a
*       SigOpEmbBO.AtualizarPesoLinha, e o Init passa o contexto
*       Citens/Emps/Dopes/Numes), e a volta BO -> tela eh o proprio
*       cursor, repintado por RepintarGrade. Preencher os dois hooks
*       aqui seria codigo MORTO: quem os chama eh FormBase.Salvar e
*       FormBase.Cancelar, e esta tela nao usa nenhum dos dois (grava por
*       BtnConfirmarClick -> SigOpEmbBO.GravarEmbalagensDoItem).
*
*     Criar os sete como stub violaria a regra de completude; criar como
*     logica real inventaria botao, modo e ficha que o legado nao tem,
*     violando o PILAR 1. Registrado por extenso porque a ausencia
*     deles, sem esta nota, parece fase inacabada.
*
*     MEDIDO em VFP9 nesta fase (automation\ProbeEmb728Fase8.prg,
*     instanciando o form - "a tela abre" nao se prova lendo codigo):
*     CREATEOBJECT devolve objeto; a grade abre com ColumnCount = 4,
*     RecordSource ligado e as larguras/headers/InputMask do dump
*     (52/130/87/87 e Qtde/Embalagem/Peso/Peso Total); o When das celulas
*     da .T./.F./.F./.F. como o SCX; os seis metodos chamados de FORA da
*     classe estao PUBLIC (regras #3/#51); o Valid recalcula
*     pesos = qtds * pesoembs (4 x 2,50 -> 10,000); o total usa o
*     criterio Qtds > 0 do legado (12,500 em 3 linhas, uma com zero); o
*     Init zera "pesoemb" no form pai; e o encerramento fecha o cursor da
*     grade.
*
* EVENTOS PRINCIPAIS (Fase 7): nao existe BtnIncluirClick/BtnAlterarClick/
*     BtnVisualizarClick/BtnExcluirClick porque o legado NAO tem CRUD -
*     SIGOEMB nao e' frmcadastro, nao tem pcEscolha, nao tem Grupo_Op e a
*     SECAO 1 do dump prova UM botao so (cntBotoes, ButtonCount = 1,
*     BaseClass: commandgroup). Os 9 metodos da SECAO 3
*     (tasks\task728\SigOpEmb_form_codigo_fonte.txt e
*     comportamento.json) sao Init/Load/Release do form,
*     cntBotoes.Click, Grade.Column1.Text1.Valid e os quatro When das
*     colunas - nenhum deles e' Incluir/Alterar/Visualizar/Excluir. O
*     EVENTO PRINCIPAL desta tela (cntBotoes.Click) ja foi implementado
*     na Fase 4 como BtnConfirmarClick -> ConfirmarEmbalagensExec
*     (confirma a quantidade digitada, grava via BO, devolve o peso ao
*     form pai e fecha o dialogo) - repeti-lo aqui duplicaria o bind do
*     BINDEVENT em ConfigurarBotoesConfirmar. Criar os quatro handlers
*     CRUD como stub vazio violaria a regra de completude (proibido
*     metodo sem logica real); criar como logica real inventaria
*     comportamento que o legado nunca teve, violando o PILAR 1.
*
* CAMPOS: nao existe campo FORA da grade (nada a acrescentar nas Fases 5/6)
*     Contado na arvore de objetos do dump: os 4 "BaseClass: textbox" do
*     form tem Parent SIGOEMB.Grade.Column1..Column4, ou seja sao os Text1
*     NATIVOS das colunas (regra #18), entregues junto com a propria grade
*     na Fase 4. Fora deles o form tem: 1 grid, 1 container (cntSombra),
*     2 labels (lblSombra/lblTitulo - os dois do cabecalho), 1
*     commandgroup e 4 headers. Zero TextBox/EditBox/ComboBox/CheckBox/
*     Spinner avulso. Reproduzir um "campo solto" aqui exigiria duplicar a
*     celula de uma coluna como controle fantasma (nunca visivel, nao
*     reproduz nada do legado) ou inventar campo que o legado nao tem -
*     viola o PILAR 1 nos dois casos.
*
* LOOKUPS: o legado NAO tem lookup algum (nada a acrescentar na Fase 6)
*     Medido no dump, zero ocorrencia (case-insensitive) de: fwBuscaExt,
*     fwBuscaSel, fwBuscaInt, sigacess, AcessoEmpresa/Contas/Produto,
*     fSqlConector, mAddColuna, CreateObject e Seek. Os 9 metodos da
*     SECAO 3 sao: Init / Load / Release do form, btnConfirmar.Click,
*     Column1.Text1.Valid e os quatro When das colunas - nenhum deles
*     abre browse de selecao. Os unicos dados de referencia da tela
*     (codigo, descricao e peso unitario da embalagem) chegam pela
*     CONSULTA que monta a grade (SELECT ... FROM SigCdEmb, no BO), e nao
*     por picker: o usuario nao escolhe embalagem, ele digita a
*     quantidade de cada uma das que ja estao listadas. Criar aqui um
*     FormBuscaAuxiliar seria inventar tabela de lookup que o legado
*     nunca consultou.
*
* "Load -> =fConfigGeral()" do legado: deliberadamente NAO reproduzido como
*     chamada. fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg /
*     SIGFUNCS.PRG) que nao veio no acervo; o projeto tem
*     utils\fconfiggeral.prg, mas esse arquivo e' um wrapper que existe
*     SO para o p-code dos VCX legado o alcancar pelo PATH, e o proprio
*     cabecalho dele manda nao chama-lo de codigo nosso. O que a funcao
*     fazia era configuracao GLOBAL, que nesta arquitetura acontece antes
*     e em outro lugar: SETs/paths/variaveis globais em config.prg,
*     conexao e empresa em main.prg, e os cursores desta tela em
*     SigOpEmbBO (CriarCursorEmbalagens/CarregarCadastroEmbalagens/
*     CarregarLinhasDoItem). Este dialogo nao le nada que fConfigGeral
*     criasse - a unica tabela de referencia dele e' SigCdEmb, consultada
*     pelo proprio BO.
*
* CONTRATO DE CONSUMO (como abrir e ler o resultado):
*     loc_oDlg = CREATEOBJECT("FormSigOpEmb", THIS, <Citens>, ;
*                    <Emps>, <Dopes>, <Numes>)
*     IF VARTYPE(loc_oDlg) = "O"
*         loc_oDlg.Show()                              && modal: bloqueia
*         loc_nPeso = loc_oDlg.ObterPesoTotalEmbalagens()
*     ENDIF
* A tela fecha com Hide() (ver FecharDialogo) para o chamador ainda poder
* ler o peso; quando o form pai eh passado, o valor tambem chega nele pela
* property "pesoemb", como no legado.
*
* PILAR 1 (UX): dialogo pequeno e modal, 650x239, Caption "Quantidade de
* embalagens" (sem acentos). As propriedades de janela NAO foram
* deduzidas por analogia com os outros dialogos desta familia: o
* layout.json nao as captura, mas a SECAO 2 do dump
* (tasks\task728\SigOpEmb_form_codigo_fonte.txt, "PROPRIEDADES DE:
* SIGOEMB") declara TODAS uma a uma, e estao transcritas do dump no bloco
* de propriedades da classe abaixo. Registrado aqui porque a versao
* anterior deste cabecalho dizia o contrario, e "inferido por analogia"
* convida um sweep futuro a "corrigir" valor que e' do legado.
*
* PILAR 3 (arquitetura): o legado (SIGOEMB) e um form FLAT do VFP - SEM
* PageFrame, SEM Container alem do cntSombra (header). A arvore de
* objetos (layout.json) tem exatamente: form + cntSombra (com
* lblSombra/lblTitulo) + cntBotoes (CommandGroup, 1 botao) + Grade (4
* colunas). Nao ha Page1/Lista nem Page2/Dados - inventa-los violaria o
* PILAR 1. cntBotoes e a Grade entram na Fase 4 (fora do escopo desta
* fase, que e so a ESTRUTURA BASE).
*==============================================================================

DEFINE CLASS FormSigOpEmb AS FormBase

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form PAI no Init (equivalente a poForm e aos
    *-- valores que o legado lia direto de crTpmMvItn/TprMvCab, por
    *-- estarem na mesma data session do form pai)
    this_oFormPai = .NULL.   && poForm - referencia ao form pai (item de movimento); usada para devolver o peso total (thisform.parentform.pesoemb do legado)
    this_nCitens  = 0        && crTpmMvItn.Citens - item corrente da movimentacao
    this_cEmps    = ""       && TprMvCab.Emps - empresa da movimentacao
    this_cDopes   = ""       && TprMvCab.Dopes - operacao da movimentacao
    this_nNumes   = 0        && TprMvCab.Numes - numero da movimentacao

    *-- Resultado da tela: o lnTotP do btnConfirmar legado, CACHEADO aqui
    *-- para ser legivel apos o Show() (FecharDialogo usa Hide, e o Destroy
    *-- so roda quando o chamador liberar o objeto - tarde demais)
    this_nPesoTotalEmbalagens = 0

    *-- Trava do "Grade.Column1.SetFocus()" do fim do Init legado: o legado
    *-- posiciona o cursor UMA vez, na abertura (ver PosicionarFocoQuantidade)
    this_lFocoInicialAplicado = .F.

    *-- Propriedades visuais - TRANSCRITAS uma a uma da SECAO 2 do dump
    *-- ("PROPRIEDADES DE: SIGOEMB"), nunca derivadas umas das outras:
    *-- TitleBar = 0 / ControlBox = .F. NAO implicam Closable/MaxButton/
    *-- MinButton = .F. (medido no VFP9 - as cinco sao independentes), e
    *-- inventar qualquer uma delas muda comportamento sem aparecer em
    *-- screenshot nem em gate nenhum.
    *--
    *-- Ficam de fora apenas DoCreate (propriedade de design-time do Form
    *-- Designer, sem efeito em classe de .prg) e Picture, que depende de
    *-- gc_4c_CaminhoFramework e por isso e' atribuida em InicializarForm.
    Width        = 650
    Height       = 239
    AutoCenter   = .T.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    Themes       = .F.
    ShowTips     = .T.
    AlwaysOnTop  = .T.
    FontName     = "Verdana"
    FontSize     = 8
    Caption      = "Quantidade de embalagens"

    *-- DataSession = 1 do dump. Vale o default do VFP, mas esta EXPLICITO
    *-- de proposito: "1" significa a data session CORRENTE (a do form que
    *-- abriu este dialogo), nao "a sessao global numero 1". Esta tela
    *-- EXISTE para ler e reescrever os cursores do form pai (crSigMvIte /
    *-- crTpmMvItn, ver SigOpEmbBO), que so sao visiveis aqui por causa
    *-- disso. Trocar para 2 daria a este form uma sessao PRIVADA: os
    *-- cursores do pai desapareceriam, a grade abriria vazia e o peso
    *-- voltaria sempre zero - sem erro e sem log. A linha existe para que
    *-- um sweep de "forms sem DataSession" nao acrescente o 2.
    DataSession  = 1

    *-- KeyPreview = .T. do dump: INERTE nesta tela, como no legado - o SCX
    *-- nao declara PROCEDURE KeyPress nem no form nem em controle nenhum
    *-- (SECAO 3 do dump tem 9 metodos, nenhum deles KeyPress). Quem
    *-- responde ao ESC e' o Cancel = .T. do botao (ConfigurarBotoesConfirmar),
    *-- que funciona independente desta flag. Transcrita porque o dump a
    *-- declara, e nao para habilitar comportamento novo.
    KeyPreview   = .T.

    *-- Closable = .F. do dump (SECAO 2). TRANSCRITO, nao inventado - a
    *-- distincao importa: com TitleBar = 0 nao ha botao de fechar para
    *-- desenhar, mas Closable continua governando o Alt+F4, e aqui ele
    *-- fica bloqueado. Consequencia: a UNICA saida e' o botao, que GRAVA
    *-- (btnConfirmar) - ou seja esta tela nao tem como "desistir", e isso
    *-- e' comportamento do LEGADO, nao desvio. O efeito pratico e' menor
    *-- do que parece: a grade abre JA com as quantidades gravadas do item
    *-- (LEFT JOIN do Init legado), entao confirmar sem mexer em nada
    *-- regrava os mesmos valores e devolve o mesmo peso. Se o dump nao
    *-- declarasse esta propriedade, ela NAO poderia ser acrescentada por
    *-- coerencia com TitleBar/ControlBox, justamente porque o unico botao
    *-- commita.
    Closable     = .F.

    *--------------------------------------------------------------------------
    * Init - Armazena o contexto do item de movimento pai, cria o BO e
    * dispara FormBase.Init() (que chama THIS.InicializarForm() via
    * DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nCitens, par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
            THIS.this_nCitens  = IIF(VARTYPE(par_nCitens) = "N", par_nCitens, 0)
            THIS.this_cEmps    = IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),  "")
            THIS.this_cDopes   = IIF(VARTYPE(par_cDopes)  = "C", ALLTRIM(par_cDopes), "")
            THIS.this_nNumes   = IIF(VARTYPE(par_nNumes)  = "N", par_nNumes, 0)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEmbBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpEmbBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpEmb.Init")
            ELSE
                *-- Contexto da movimentacao propagado para o BO ANTES do
                *-- DODEFAULT(), que dispara InicializarForm().
                THIS.this_oBusinessObject.this_nCitens = THIS.this_nCitens
                THIS.this_oBusinessObject.this_cEmps   = THIS.this_cEmps
                THIS.this_oBusinessObject.this_cDopes  = THIS.this_cDopes
                THIS.this_oBusinessObject.this_nNumes  = THIS.this_nNumes

                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpEmb.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base (cabecalho).
    * Chamado automaticamente por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- "thisform.parentform.pesoemb = 0" do Init legado, na mesma
            *-- posicao (antes da consulta que monta a grade): se a tela for
            *-- fechada pelo X/Esc sem confirmar, o pai fica com ZERO em vez
            *-- do peso de uma abertura anterior
            THIS.DevolverPesoTotalAoPai(0)

            THIS.ConfigurarPageFrame()

            *-- Propaga o titulo para os labels do cabecalho (equivalente a
            *-- ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpEmb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base.
    * SIGOEMB original eh flat OPERACIONAL (sem PageFrame nativo) - popup
    * modal aberto a partir de um item de movimento. Nome mantido por
    * convencao do orquestrador multi-fase (mesmo padrao de
    * FormSigOpDet.ConfigurarPageFrame).
    *
    * ORDEM OBRIGATORIA:
    *   1. cabecalho PRIMEIRO - cmg_4c_Botoes fica em Top = -2, DENTRO da
    *      area da faixa (Top 0..80), e so desenha por cima dela se for
    *      criado DEPOIS (regra #11);
    *   2. CarregarLista ANTES da grade - Column.ControlSource estoura
    *      "Alias not found" se o cursor nao existir (regra #41), e
    *      SigOpEmbBO.CriarCursorEmbalagens() pode recriar o alias, o que
    *      derrubaria um bind ja feito;
    *   3. grade e botoes;
    *   4. RepintarGrade por ULTIMO - popular o cursor NAO repinta a grade
    *      (regra #21).
    *
    * NAO EXISTEM ConfigurarPaginaLista/AlternarPagina proprios nesta tela:
    * o SIGOEMB legado eh FLAT (a arvore do dump tem form + cntSombra +
    * cntBotoes + Grade, sem PageFrame nenhum), entao nao ha Page1/Lista
    * para configurar nem paginas para alternar. Criar os dois obrigaria a
    * INVENTAR um PageFrame e 6 botoes CRUD que o legado nao tem (viola o
    * PILAR 1) ou a deixar metodo vazio (proibido pela regra de
    * completude). O AlternarPagina herdado de FormBase ja eh inocuo
    * quando nao existe pgf_4c_Paginas, e por isso tambem nao eh
    * sobrescrito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.CarregarLista()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoesConfirmar()
        THIS.RepintarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cnt_4c_Cabecalho (cntSombra do
    * legado) com os dois labels do titulo. Largura do container segue
    * THIS.Width (regra CLAUDE.md #11 - nunca hardcoded); a largura dos
    * labels e derivada de THIS.Width (e nao do 769 fixo do dump, que
    * pertence a classe generica de 800px do Framework e, copiado
    * literalmente, ultrapassaria os 650px deste form e seria recortado
    * pelo container - regra CLAUDE.md #30).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_nLarguraLabel

        loc_nLarguraLabel = THIS.Width - 20

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Labels adicionados FORA do WITH do container: WITH aninhado com
        *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = ""
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = loc_nLarguraLabel
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = ""
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = loc_nLarguraLabel
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grade de embalagens (SIGOEMB.Grade do legado, classe
    * fwgrade do framework.vcx).
    *
    * Geometria e propriedades visuais transcritas do dump (Top=84, Left=84,
    * Width=380, Height=143, FontName="Verdana"/8, HeaderHeight=22,
    * RowHeight=20, ScrollBars=2, Panel=1, TabIndex=1, RecordMark=.F.).
    * NAO ha compensacao de Top aqui: este form eh FLAT, sem o PageFrame de
    * Top = -29 dos cadastros - os Tops do SCX ja sao absolutos no form.
    *
    * DeleteMark = .F. NAO esta no dump: a classe fwgrade do Framework
    * (docs/framework_frmcadastro_layout.md) ja nasce com as duas barras
    * desligadas e o SCX so precisou declarar RecordMark. Aqui a grade eh
    * Grid base do VFP, que nasce com DeleteMark = .T. - declarar .F. eh o
    * que REPRODUZ o legado, nao um desvio dele.
    *
    * Aqui ficam SO as propriedades que nao dependem de dado. Todo o bind
    * (ColumnCount/RecordSource/ControlSource/Width/Header1.Caption/
    * InputMask/CurrentControl/Sparse/ReadOnly) mora em VincularGrade, que
    * eh FONTE UNICA compartilhada com CarregarLista - duas copias do bind
    * divergiriam em silencio na primeira coluna nova (regra #44, item 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrade

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = THIS.grd_4c_Dados
        WITH loc_oGrade
            .Top          = 84
            .Left         = 84
            .Width        = 380
            .Height       = 143
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 22
            .RowHeight    = 20
            .ScrollBars   = 2
            .Panel        = 1
            .TabIndex     = 1
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        THIS.VincularGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - bind COMPLETO da grade ao cursor das embalagens.
    * FONTE UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
    * (recarga).
    *
    * Precisa ser reaplicado INTEIRO a cada recarga porque atribuir
    * RecordSource reseta Column.Width, Header1.Caption, Sparse e
    * CurrentControl (regra #48).
    *
    * ColumnCount so eh tocado quando esta diferente de 4: reatribui-lo
    * DESTROI os objetos Column e com eles os TextBox postos por AddObject.
    *
    * ControlSource das 4 colunas, transcrito do Init legado:
    *   Column1 -> LocalEmb.Qtds      (quantidade digitada - unica editavel)
    *   Column2 -> LocalEmb.Descs     (descricao da embalagem)
    *   Column3 -> LocalEmb.PesoEmbs  (peso unitario do cadastro)
    *   Column4 -> LocalEmb.Pesos     (Qtds * PesoEmbs)
    *
    * Movable/Resizable = .F. SO na Column1, porque eh so nela que o SCX
    * declara o par - as outras tres nao declaram e ficam no default .T.
    *
    * Grid.ReadOnly propaga para as colunas, por isso vem ANTES dos
    * Column.ReadOnly (regra #18) - e os Column.ReadOnly vem DEPOIS dele
    * justamente para nao serem sobrescritos pela propagacao.
    *
    * Column1 = .F. (o dump declara .F. e eh a unica celula que o usuario
    * digita). Columns 2/3/4 = .T.: o dump declara .F. nas quatro, mas e'
    * o "When -> Return .F." dos TextBox delas que BLOQUEIA as tres - e a
    * regra #46 manda devolver ReadOnly = .T. a coluna que o legado trava
    * por When. Nao e' redundancia: se a Column for recriada em algum
    * caminho de rebind, ela volta ao Text1 NATIVO (sem o When da
    * subclasse) e, com Grid.ReadOnly = .F. propagado, "Peso" e "Peso
    * Total" - que sao CALCULADOS - passariam a aceitar digitacao direta no
    * cursor, corrompendo o peso devolvido ao pai sem erro nenhum. Com o
    * When ativo o ReadOnly e' invisivel ao usuario (o When recusa o foco
    * ANTES), entao a navegacao por Tab do legado fica preservada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VincularGrade()
        LOCAL loc_lSucesso, loc_oGrade, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = THIS.ObterAliasGrade()

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED(loc_cAlias)
            loc_oGrade = THIS.grd_4c_Dados

            IF loc_oGrade.ColumnCount != 4
                loc_oGrade.ColumnCount = 4
            ENDIF

            loc_oGrade.RecordSource = loc_cAlias

            THIS.VincularColunaEmb(loc_oGrade.Column1, "txt_4c_Qtde", ;
                "TextBoxQtdeEmb_4c", loc_cAlias + ".qtds", 52, "Qtde", ;
                "999999", "999")

            THIS.VincularColunaEmb(loc_oGrade.Column2, "txt_4c_Descricao", ;
                "TextBoxLeituraEmb_4c", loc_cAlias + ".descs", 130, ;
                "Embalagem", "", "")

            THIS.VincularColunaEmb(loc_oGrade.Column3, "txt_4c_PesoUnitario", ;
                "TextBoxLeituraEmb_4c", loc_cAlias + ".pesoembs", 87, "Peso", ;
                "999999.999", "")

            THIS.VincularColunaEmb(loc_oGrade.Column4, "txt_4c_PesoTotal", ;
                "TextBoxLeituraEmb_4c", loc_cAlias + ".pesos", 87, ;
                "Peso Total", "999999.999", "")

            *-- Somente a Column1 declara o par no SCX
            loc_oGrade.Column1.Movable   = .F.
            loc_oGrade.Column1.Resizable = .F.

            *-- Grid.ReadOnly ANTES dos Column.ReadOnly (regra #18), senao a
            *-- propagacao dele apaga o que for definido nas colunas
            loc_oGrade.ReadOnly         = .F.

            *-- Qtde: unica celula digitavel (Column1.Text1.When -> .T.)
            loc_oGrade.Column1.ReadOnly = .F.

            *-- Embalagem / Peso / Peso Total: o legado trava as tres com
            *-- "When -> Return .F." (regra #46) - Peso e Peso Total sao
            *-- CALCULADOS e nao podem ser digitados em caminho nenhum
            loc_oGrade.Column2.ReadOnly = .T.
            loc_oGrade.Column3.ReadOnly = .T.
            loc_oGrade.Column4.ReadOnly = .T.

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VincularColunaEmb - bind de UMA coluna da grade.
    *
    * O TextBox de celula so eh recriado quando a Column o PERDEU (guarda
    * PEMSTATUS): AddObject com nome que ja existe estoura "Object is
    * already defined" e derrubaria o Init.
    *
    * A edicao/bloqueio de celula usa TextBox subclasse com When/Valid
    * EMBUTIDOS (fim deste arquivo), instalada com AddObject +
    * CurrentControl + Sparse = .F. - sem o CurrentControl a Column continua
    * desenhando o Text1 nativo e o controle nunca aparece (regra #18); e
    * BINDEVENT em Valid/When de TextBox dentro de Column nao dispara de
    * forma confiavel (regra #46).
    *
    * O controle interno eh alcancado por EVALUATE porque o nome dele chega
    * como STRING: Controls() eh indexado por NUMERO e passar o nome estoura
    * "CONTROLS is not an object" dentro de WITH (regra #34).
    *
    * par_cInputMaskColuna / par_cInputMaskControle - os dois vem do dump e
    * sao DIFERENTES na Column1 ("999999" na Column, "999" no Text1). Quem
    * governa a digitacao eh o do CONTROLE, entao transcrever so o da Column
    * mudaria o limite que o usuario enxerga. Vazio = o SCX nao declara, e
    * nada eh atribuido (regra #49: InputMask ausente nao se inventa).
    *
    * Ordem obrigatoria no fim: ControlSource -> InputMask -> Width ->
    * Header1.Caption. Mexer na fonte do dado reseta largura e cabecalho
    * (regra #48).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularColunaEmb(par_oColuna, par_cNomeControle, ;
            par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption, ;
            par_cInputMaskColuna, par_cInputMaskControle)

        IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
            par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
        ENDIF

        par_oColuna.CurrentControl = par_cNomeControle
        par_oColuna.Sparse         = .F.

        *-- Propriedades do TextBox da celula (Column<N>.Text1 do dump:
        *-- BorderStyle=0, Margin=0, ForeColor=0,0,0, BackColor=255,255,255)
        WITH EVALUATE("par_oColuna." + par_cNomeControle)
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.

            IF !EMPTY(par_cInputMaskControle)
                .InputMask = par_cInputMaskControle
            ENDIF
        ENDWITH

        WITH par_oColuna
            .ControlSource = par_cControlSource
            .FontName      = "Verdana"
            .FontSize      = 8

            IF !EMPTY(par_cInputMaskColuna)
                .InputMask = par_cInputMaskColuna
            ENDIF

            .Width             = par_nWidth
            .Header1.Caption   = par_cCaption
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesConfirmar - cntBotoes do legado: CommandGroup de UM
    * botao (ButtonCount = 1), que eh ao mesmo tempo o Confirmar e a saida
    * da tela.
    *
    * O nome do objeto legado eh "btnConfirmar", o Caption eh "\<Encerrar" e
    * o ToolTipText eh "Confirmar a Selecao" - a divergencia eh do PROPRIO
    * legado e esta transcrita como esta. O que o botao FAZ (o unico Click
    * do dump) eh somar o peso, regravar as linhas do item, devolver o total
    * ao pai e fechar: por isso o handler se chama pela ACAO
    * (BtnConfirmarClick), nao pelo rotulo da tecla.
    *
    * Geometria transcrita do dump (Top=-2, Left=567, 85x85; botao interno
    * 75x75 em 5,5). Left + Width = 652 passa 2px dos 650 do form - eh o
    * valor do SCX e fica como esta (PILAR 1).
    *
    * O padrao canonico cnt_4c_Saida/cmd_4c_Encerrar em Left = 917 (regra
    * #10) NAO se aplica aqui, por duas razoes somadas: aquele bloco eh dos
    * forms CRUD de 1000px (917 + 90 cairia fora deste dialogo de 650px e o
    * botao ficaria INVISIVEL), e este botao nao eh uma saida pura - ele
    * GRAVA. Mesma decisao de FormSigOpDet.
    *
    * AutoSize = .T. do dump NAO transcrito de proposito: em CommandGroup o
    * AutoSize faz a geometria do botao INTERNO DEFINIR a do grupo (medido
    * no VFP9 - regra #31), passando a sobrescrever o 85x85 que o proprio
    * SCX declara. Aqui os dois coincidem (5 + 75 + 5 = 85), entao manter a
    * geometria explicita nao muda um pixel e nao fica a merce do calculo.
    *
    * Criado DEPOIS de cnt_4c_Cabecalho de proposito: com Top = -2 o grupo
    * fica DENTRO da area da faixa e so desenha por cima dela se for o
    * AddObject posterior (regra #11).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesConfirmar()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_Botoes
        WITH loc_oGrp
            .ButtonCount   = 1
            .Top           = -2
            .Left          = 567
            .Width         = 85
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .TabIndex      = 2
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
        ENDWITH

        *-- Buttons(1) = btnConfirmar do legado
        WITH loc_oGrp.Buttons(1)
            .Top          = 5
            .Left         = 5
            .Height       = 75
            .Width        = 75
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Caption      = "\<Encerrar"
            .Cancel       = .T.
            .MousePointer = 15
            .TabIndex     = 1
            .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
        ENDWITH

        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAliasGrade - nome do alias que alimenta a grade.
    *
    * Lido do BO (this_cCursorEmbalagens), que eh o DONO da estrutura e o
    * ponto UNICO de CREATE CURSOR desta tela - repetir o literal aqui
    * criaria uma segunda fonte de verdade para o nome, e um renomeio no BO
    * passaria a bindar a grade num alias que ninguem popula. O literal
    * entra SO como ultimo recurso (BO ausente), para o metodo nunca
    * devolver string vazia e fazer USED("") estourar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterAliasGrade()
        LOCAL loc_cAlias
        loc_cAlias = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAlias = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCursorEmbalagens, ""))
        ENDIF

        IF EMPTY(loc_cAlias)
            loc_cAlias = "cursor_4c_Embalagens"
        ENDIF

        RETURN loc_cAlias
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDadosGrade - popula o cursor da grade ANTES de ela existir.
    *
    * Equivale ao trecho do Init legado que roda a consulta do cadastro
    * (LocalCdEmb) e monta o LEFT JOIN com as linhas do item (LocalEmb) -
    * aqui tudo isso mora em SigOpEmbBO.CarregarEmbalagensDoItem().
    *
    * Em validacao de UI / modo teste (gnConnHandle = -1) a carga real NAO
    * eh tentada: SigOpEmbBO.CarregarCadastroEmbalagens() exibe "Favor
    * Reinicializar o Processo!!!" sem conexao, e um MsgErro modal numa
    * instanciacao automatizada PENDURA o processo. Nesse caso so o cursor
    * VAZIO eh criado (CriarCursorEmbalagens), suficiente para a grade
    * bindar sem estourar.
    *
    * O cursor vazio tambem eh a rede da carga real que falha: sem alias
    * aberto, Column.ControlSource dispara "Alias not found" e derruba o
    * Init inteiro - a tela nao abriria (regra #41). Carga real falhando
    * NAO eh erro de fluxo: o BO ja exibiu a mensagem do SQL Server.
    *
    * NUNCA criar aqui um segundo CREATE CURSOR com a estrutura repetida:
    * APPEND FROM DBF() casa por NOME, e duas declaracoes com ordem ou
    * grafia diferentes eh o defeito classico dos forms OPERACIONAIS. A
    * estrutura mora so em SigOpEmbBO.CriarCursorEmbalagens().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDadosGrade()
        LOCAL loc_lModoSemBanco, loc_cAlias

        loc_cAlias = THIS.ObterAliasGrade()

        loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
            OR (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF loc_lModoSemBanco
                THIS.this_oBusinessObject.CriarCursorEmbalagens()
            ELSE
                IF !THIS.this_oBusinessObject.CarregarEmbalagensDoItem()
                    THIS.this_oBusinessObject.CriarCursorEmbalagens()
                ENDIF
            ENDIF
        ENDIF

        RETURN USED(loc_cAlias)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL UNICO de carga da grade: recarrega o cursor,
    * reaplica o bind e repinta.
    *
    * PUBLIC porque o harness de teste automatico chama
    * THIS.oForm.CarregarLista() de FORA da classe - PROTECTED passaria no
    * PEMSTATUS e falharia em runtime com "Property CARREGARLISTA is not
    * found" (regras #3 e #51).
    *
    * O rebind depois da carga NAO eh zelo: SigOpEmbBO.CriarCursorEmbalagens()
    * pode FECHAR e RECRIAR o alias (quando forcado, ou quando a estrutura
    * encontrada nao eh a esperada), e derrubar o alias que a grade usa como
    * RecordSource ZERA o ColumnCount e destroi os controles postos nas
    * Column por AddObject - a grade vira um retangulo branco sem erro, sem
    * log e pelo RESTO da vida do form. Na primeira chamada (dentro de
    * ConfigurarPageFrame) a grade ainda nao existe e o rebind eh pulado
    * pela guarda de VincularGrade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CarregarDadosGrade()

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.VincularGrade()
            THIS.RepintarGrade()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGrade - "Select LocalEmb / Go Top" + Refresh do fim do Init
    * legado.
    *
    * Popular o cursor NAO repinta a grade (regra #21): sem o GO TOP a
    * grade pode abrir posicionada em EOF e parecer VAZIA com o cursor
    * cheio, e o sintoma reportado ("a tela nao traz as embalagens") manda
    * o diagnostico para SQL/cursor/permissao, onde nao ha defeito nenhum.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION RepintarGrade()
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = THIS.ObterAliasGrade()

        IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            SELECT (loc_cAlias)
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - alvo do BINDEVENT do unico botao da tela. PUBLIC:
    * BINDEVENT ignora metodo PROTECTED em silencio (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        THIS.ConfirmarEmbalagensExec()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarEmbalagensExec - corpo do btnConfirmar.Click legado, na mesma
    * ordem:
    *   1. soma o peso total das embalagens (lnTotP);
    *   2. regrava as linhas do item;
    *   3. devolve o total ao pai (thisform.parentform.pesoemb = lnTotP);
    *   4. fecha a tela (ThisForm.Release()).
    * Os passos 1 e 2 sao do BO (GravarEmbalagensDoItem); 3 e 4 sao da TELA
    * e ficam aqui.
    *
    * DIVERGENCIA DELIBERADA, registrada para nao ser "consertada" num sweep
    * futuro: o legado NAO tem caminho de falha - ele escreve no cursor
    * remoto do pai sem conferir nada e SEMPRE faz Release. O BO migrado
    * DETECTA falha (sem item para enderecar a gravacao, erro do SQL Server,
    * lote revertido), e nesse caso a tela PERMANECE ABERTA: fechar
    * devolveria ao pai um peso que nao corresponde a nada gravado, e o
    * usuario veria o valor mudar na tela dele e perder tudo depois.
    * O peso so eh devolvido no caminho de SUCESSO, pela mesma razao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfirmarEmbalagensExec()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.GravarEmbalagensDoItem()
                    THIS.DevolverPesoTotalAoPai( ;
                        THIS.this_oBusinessObject.this_nPesoTotalEmbalagens)
                    THIS.FecharDialogo()
                ELSE
                    *-- BusinessBase/BO ja reportam a falha e marcam
                    *-- this_lErroExibido; a mensagem so eh repetida aqui se
                    *-- sobrou texto SEM ter sido exibido (regra #20)
                    IF !THIS.this_oBusinessObject.this_lErroExibido ;
                        AND !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Quantidade de Embalagens")
                    ENDIF

                    *-- A tela continua aberta: repintar devolve a grade ao
                    *-- topo para o usuario localizar o que corrigir
                    THIS.RepintarGrade()
                ENDIF
            ELSE
                *-- Sem BO nao ha o que gravar (instanciacao automatizada):
                *-- o dialogo apenas fecha, devolvendo peso zero
                THIS.DevolverPesoTotalAoPai(0)
                THIS.FecharDialogo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpEmb.ConfirmarEmbalagensExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DevolverPesoTotalAoPai - "thisform.parentform.pesoemb = <peso>" do
    * legado, que roda duas vezes: zerando no Init e com o total no
    * btnConfirmar.Click.
    *
    * O valor eh guardado ANTES em this_nPesoTotalEmbalagens, que eh o que
    * ObterPesoTotalEmbalagens() devolve - o caminho de leitura de quem abre
    * o dialogo com CREATEOBJECT + Show() (ver o contrato no cabecalho deste
    * arquivo). A copia para o pai NAO pode ficar no Destroy: FecharDialogo
    * usa Hide() e o Destroy so roda quando o chamador liberar o objeto,
    * tarde demais para quem le logo apos o Show().
    *
    * AddProperty quando o pai nao tem "pesoemb": eh o que o proprio
    * framework legado faz com as properties que espera do form
    * (If Type('ThisForm.<x>') == 'U' / ThisForm.AddProperty(...)), e sem
    * isso a atribuicao estouraria "Property PESOEMB is not found" num pai
    * migrado que ainda nao declare a property.
    *
    * Refresh no pai, NAO recarga: as linhas do item foram reescritas no
    * cursor que o pai ja tem aberto (SigOpEmbBO.SincronizarCursorItensMov)
    * - chamar um CarregarLista dele RECONSULTARIA o banco e descartaria
    * justamente essas alteracoes ainda nao comitadas. Falha aqui NAO eh
    * fatal: a gravacao ja aconteceu, entao o erro eh avisado e o fluxo
    * segue.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DevolverPesoTotalAoPai(par_nPeso)
        LOCAL loc_lSucesso, loc_nPeso, loc_oErro

        loc_lSucesso = .F.
        loc_nPeso    = IIF(VARTYPE(par_nPeso) = "N", par_nPeso, 0)

        THIS.this_nPesoTotalEmbalagens = loc_nPeso

        IF VARTYPE(THIS.this_oFormPai) = "O"
            TRY
                IF !PEMSTATUS(THIS.this_oFormPai, "pesoemb", 5)
                    THIS.this_oFormPai.AddProperty("pesoemb", 0)
                ENDIF

                THIS.this_oFormPai.pesoemb = loc_nPeso
                THIS.this_oFormPai.Refresh()

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgAviso("As embalagens foram gravadas, mas o peso total n" + ;
                    CHR(227) + "o p" + CHR(244) + "de ser devolvido " + ;
                    CHR(224) + " tela da movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message, "Quantidade de Embalagens")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterPesoTotalEmbalagens - leitura do resultado por quem abriu o
    * dialogo. PUBLIC: eh o contrato da tela.
    *--------------------------------------------------------------------------
    FUNCTION ObterPesoTotalEmbalagens()
        RETURN THIS.this_nPesoTotalEmbalagens
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharDialogo - ponto UNICO de encerramento da janela.
    *
    * Hide(), NAO Release(): medido no VFP9, Release() destroi o objeto
    * mesmo com o chamador segurando a referencia, e a leitura seguinte
    * (ObterPesoTotalEmbalagens) estoura "is not an object" - o dialogo
    * ficaria sem como devolver o peso que ele existe para calcular. O
    * legado entrega o resultado escrevendo no form pai, caminho que aqui
    * continua existindo (DevolverPesoTotalAoPai) mas que nao cobre quem
    * abre sem passar o pai. Em form modal o Hide tambem devolve o Show,
    * entao para o usuario a tela fecha igual (PILAR 1 preservado): muda so
    * o tempo de vida do objeto, que eh PILAR 3. O Release fica com o
    * CHAMADOR, como em FormBuscaAuxiliar.
    *
    * PUBLIC: chamado de dentro (ConfirmarEmbalagensExec) e pelo harness de
    * teste automatico, que procura FecharDialogo quando nao ha
    * BtnEncerrarClick/BtnFecharClick/BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarQuantidadeGrade - Grade.Column1.Text1.Valid do legado:
    *     Select LocalEmb
    *     Replace Qtds With This.Value,
    *             Pesos with Localemb.Qtds * LocalEmb.PesoEmbs
    *     thisform.grade.Refresh()
    *
    * A gravacao no cursor e o recalculo moram no BO (AtualizarPesoLinha);
    * aqui fica so o Refresh, que eh da TELA.
    *
    * O valor digitado vem de par_oTxt.Value, NAO do cursor: dentro do Valid
    * o cursor ainda tem o valor ANTIGO (regra #46) - ler dali recalcularia
    * o peso com a quantidade anterior.
    *
    * Retorna SEMPRE .T.: o Valid legado nao tem RETURN (e procedure sem
    * RETURN devolve .T. em VFP9), ou seja ele nunca prende o usuario na
    * celula. Devolver .F. numa falha mudaria o comportamento da tela.
    *
    * PUBLIC: chamado de FORA da classe, pelo Valid do TextBox da celula.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarQuantidadeGrade(par_oTxt)
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND VARTYPE(par_oTxt) = "O"
                THIS.this_oBusinessObject.AtualizarPesoLinha(par_oTxt.Value)
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpEmb.ValidarQuantidadeGrade")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - "This.Grade.Column1.SetFocus()" do fim do Init legado.
    *
    * No Init do form migrado a janela ainda nao esta visivel e SetFocus em
    * controle invisivel falha; o Activate roda quando a tela aparece, que eh
    * o instante em que o legado (DoCreate = .T., tela ja montada) tinha o
    * foco aplicado.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        THIS.PosicionarFocoQuantidade()
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarFocoQuantidade - corpo do Activate, com trava de uma unica
    * execucao: o legado posiciona o cursor UMA vez, na abertura. Sem a
    * trava, cada reativacao da janela puxaria o foco de volta para a
    * primeira celula e tiraria o usuario da linha em que ele estava.
    *
    * TRY/CATCH silencioso de proposito: foco eh conveniencia, nao funcao -
    * um SetFocus recusado (grade vazia, celula nao editavel, janela ainda
    * sem foco) nao pode render dialogo de erro na abertura da tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarFocoQuantidade()
        LOCAL loc_oErro

        IF !THIS.this_lFocoInicialAplicado
            THIS.this_lFocoInicialAplicado = .T.

            TRY
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5) ;
                    AND THIS.grd_4c_Dados.ColumnCount >= 1 ;
                    AND THIS.grd_4c_Dados.Visible
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            CATCH TO loc_oErro
                *-- Foco recusado: a tela continua utilizavel, o usuario so
                *-- precisa clicar na celula. Nao ha o que reportar.
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_p
                    FOR loc_p = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * DesvincularGrade - as TRES primeiras linhas do PROCEDURE Release
    * legado, que a migracao tinha deixado de fora:
    *     This.Grade.RecordSource          = []
    *     This.Grade.Column1.ControlSource = []
    *     This.Grade.Column2.ControlSource = []
    *
    * O legado solta o bind ANTES do "Use In LocalEmb", e a ordem eh o
    * ponto: fechar o alias com a grade ainda apontando para ele deixa o
    * Grid com RecordSource/ControlSource para um alias morto. Nao estoura
    * no encerramento (medido - o cursor fecha sem erro), mas um Refresh
    * que ainda chegue a grade nesse intervalo - repaint da janela a
    * caminho, Destroy do pai, Timer - pinta a partir de alias inexistente.
    * Soltar o bind primeiro eh o que o legado faz e custa tres linhas.
    *
    * Aqui o laco cobre as QUATRO colunas, nao as duas do legado: o SCX
    * declarava ControlSource nas quatro (Qtds/Descs/PesoEmbs/Pesos) e
    * limpava so duas, o que eh descuido do proprio legado e nao regra -
    * deixar Column3/Column4 ligadas reproduziria o descuido sem
    * reproduzir nenhum comportamento observavel.
    *
    * Idempotente e silencioso de proposito: roda no caminho de
    * encerramento, onde um dialogo de erro nao tem a quem avisar e
    * impediria o Destroy de concluir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesvincularGrade()
        LOCAL loc_nCol, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                FOR loc_nCol = 1 TO THIS.grd_4c_Dados.ColumnCount
                    STORE "" TO ("THIS.grd_4c_Dados.Column" + ;
                        TRANSFORM(loc_nCol) + ".ControlSource")
                ENDFOR

                THIS.grd_4c_Dados.RecordSource = ""
            ENDIF
        CATCH TO loc_oErro
            *-- Encerramento: nao ha a quem reportar, e insistir abortaria o
            *-- fechamento dos cursores logo abaixo.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresDoDialogo - "Use In LocalEmb" do PROCEDURE Release
    * legado, estendido aos cursores auxiliares que o BO abre.
    *
    * Os nomes vem das PROPERTIES do BO, nao de literais repetidos aqui:
    * o BO eh o dono da estrutura e o ponto unico de CREATE CURSOR desta
    * tela (mesmo argumento de ObterAliasGrade). Com os literais
    * duplicados, renomear um cursor no BO deixava este metodo fechando
    * alias que nao existe mais e VAZANDO o que passou a existir - sem
    * erro, sem log, e o vazamento so apareceria na proxima abertura, na
    * forma de estrutura antiga reaproveitada.
    *
    * NAO fecha this_cCursorItensMov (crSigMvIte) nem
    * this_cCursorItemCorrente (crTpmMvItn): esses dois sao do form PAI e
    * so estao visiveis aqui por DataSession = 1. Fecha-los mataria a
    * movimentacao em edicao do chamador - exatamente o que o legado nao
    * faz (o Release dele toca unicamente em LocalEmb).
    *
    * Os literais entram SO como ultimo recurso (BO ja liberado quando o
    * Destroy roda), para o cursor nao ficar aberto nesse caminho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresDoDialogo()
        LOCAL loc_nI, loc_cAlias, loc_oBO, loc_oErro
        LOCAL ARRAY loc_aCursores[4]

        *-- Fallback: os nomes atuais das properties do BO
        loc_aCursores[1] = "cursor_4c_Embalagens"
        loc_aCursores[2] = "cursor_4c_CadEmb"
        loc_aCursores[3] = "cursor_4c_LinhasItem"
        loc_aCursores[4] = "cursor_4c_EmbTemp"

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                IF PEMSTATUS(loc_oBO, "this_cCursorEmbalagens", 5)
                    loc_aCursores[1] = ALLTRIM(NVL(loc_oBO.this_cCursorEmbalagens, loc_aCursores[1]))
                ENDIF
                IF PEMSTATUS(loc_oBO, "this_cCursorCadEmb", 5)
                    loc_aCursores[2] = ALLTRIM(NVL(loc_oBO.this_cCursorCadEmb, loc_aCursores[2]))
                ENDIF
                IF PEMSTATUS(loc_oBO, "this_cCursorLinhasItem", 5)
                    loc_aCursores[3] = ALLTRIM(NVL(loc_oBO.this_cCursorLinhasItem, loc_aCursores[3]))
                ENDIF
                IF PEMSTATUS(loc_oBO, "this_cCursorTemp", 5)
                    loc_aCursores[4] = ALLTRIM(NVL(loc_oBO.this_cCursorTemp, loc_aCursores[4]))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- BO indisponivel: segue com os nomes de fallback acima.
        ENDTRY

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cAlias = loc_aCursores[loc_nI]

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                USE IN (loc_cAlias)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - PROCEDURE Release legado, na MESMA ordem dele: solta o bind
    * da grade e so DEPOIS fecha os cursores.
    *
    * DODEFAULT() por ultimo: FormBase.Destroy restaura os popups do menu
    * principal apos fechar form modal - sem isso por ultimo, o rendering
    * dos popups fica corrompido (CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.DesvincularGrade()
        THIS.FecharCursoresDoDialogo()

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxQtdeEmb_4c - celula "Qtde" (Column1) da grade de embalagens.
*
* Transcreve SIGOEMB.Grade.Column1.Text1 do legado:
*   When  -> Return .T.                       (unica coluna editavel)
*   Valid -> Replace Qtds/Pesos + Grade.Refresh  (-> ValidarQuantidadeGrade)
*
* Eventos EMBUTIDOS na classe, nao por BINDEVENT: BINDEVENT em Valid/When de
* TextBox dentro de Column nao dispara de forma confiavel (regra #46, e o
* cabecalho de classes\TextBoxGridLookup.prg). Mesmo padrao de
* TextBoxProdutoLpr_4c (FormLpr.prg) e das celulas de FormSigOpDet.
*
* O guard PEMSTATUS protege a classe de ser instalada num form que nao
* implemente o metodo (ela so existe para este, mas o custo eh uma linha e
* evita derrubar a tela em runtime).
*==============================================================================
DEFINE CLASS TextBoxQtdeEmb_4c AS TextBox

    PROCEDURE When()
        *-- "Return .T." do Column1.Text1.When legado: a quantidade eh o
        *-- unico campo que o usuario digita nesta tela, e o legado nao
        *-- condiciona a edicao a modo nenhum (o dialogo so existe dentro de
        *-- uma movimentacao em edicao)
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.

        IF PEMSTATUS(THISFORM, "ValidarQuantidadeGrade", 5)
            loc_lRetorno = THISFORM.ValidarQuantidadeGrade(THIS)
        ENDIF

        RETURN loc_lRetorno
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxLeituraEmb_4c - celulas Embalagem (Column2), Peso (Column3) e Peso
* Total (Column4) da grade de embalagens.
*
* Transcreve o "When -> Return .F." que SIGOEMB.Grade.Column2/3/4.Text1
* declaram no dump: as tres sao calculadas ou vindas do cadastro, e o legado
* impede que a celula receba foco - nao apenas que seja editada.
*
* O When eh a protecao PRIMARIA e eh o que reproduz a UX do legado: ele recusa
* o FOCO, enquanto Column.ReadOnly deixaria a celula receber foco e so recusar
* a digitacao - com o When ativo o usuario nunca chega a esse ponto, e a
* navegacao por Tab fica igual a do legado.
*
* O Column.ReadOnly = .T. que VincularGrade poe nestas tres colunas eh a rede
* de baixo, para o caso de a Column ser recriada e perder esta subclasse (ver
* o comentario de VincularGrade): sem ele, Peso e Peso Total - que sao
* CALCULADOS - voltariam a aceitar digitacao.
*==============================================================================
DEFINE CLASS TextBoxLeituraEmb_4c AS TextBox

    PROCEDURE When()
        RETURN .F.
    ENDPROC

ENDDEFINE
