# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigOpCfp.prg] Indicador de pendencia: * Integracao pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfp.prg):
*==============================================================================
* FormSigOpCfp.prg
*
* Dialogo OPERACIONAL "Cfop's Permitidas para Operacao" (legado SIGOPCFP.scx).
* Filho MODAL do Cadastro de Operacoes (SigCdOpe): mantem a grade de CFOPs
* permitidos para a Operacao corrente, com os limites de Observacao (Padrao/
* Inicial/Final) de cada CFOP - um registro de SigCdOop por linha da grade.
*
* Legado (Init): Lparameters poForm, pnDataSes, pcEscolha
*   poForm    - form pai (SigCdOpe), usado so para 3 coisas: Enabled=.F./.T.
*               enquanto o dialogo esta aberto, posicionar o dialogo perto da
*               grade da Lista do pai, e ler crSigCdOpe.Dopes (cursor da
*               datasession COMPARTILHADA do pai).
*   pnDataSes - DataSession do form pai, repassada via "Set DataSession to"
*               para enxergar o cursor crSigCdOpe do pai na mesma sessao.
*   pcEscolha - modo (INSERIR/ALTERAR/...) que define se Inserir/Excluir ficam
*               habilitados (grade so-leitura em VISUALIZAR).
*
* Diferente do legado, que precisa da DataSession compartilhada so para
* alcancar "crSigCdOpe.Dopes", o form migrado recebe o codigo da Operacao
* (Dopes) diretamente como parametro escalar - SigOpCfpBO acessa o banco via
* SQLEXEC proprio (gnConnHandle), sem cursor global nem DataSession
* compartilhada com o pai (memorias feedback_cursores_globais_fortyus e
* feedback_datasession_1_eh_sessao_corrente). this_oParentForm continua
* guardado (objeto, nao mais so o nome) para as duas outras finalidades do
* legado: habilitar/desabilitar o pai enquanto o dialogo esta aberto
* (AjustarBotoesFormPai - legado "mCtrlBotoes") e posicionar o dialogo perto
* da grade da Lista do pai (PosicionarJuntoAoFormPai).
*
* Nao segue o padrao PageFrame Page1=Lista/Page2=Dados do CRUD: e um dialogo
* OPERACIONAL com layout FLAT (cabecalho + grade + botoes soltos direto no
* form), igual ao legado - analise.json confirma formType=OPERACIONAL e o
* dump (SECAO 1) nao declara PageFrame nenhum (raiz "Class: form" generico).
*
* Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init() (recebe
* par_oFormPai/par_cDopes/par_cEscolha), InicializarForm() (cria o Business
* Object, aparencia do form, faixa do cabecalho, posicionamento junto ao pai
* e desabilita o pai enquanto o dialogo estiver aberto) e
* TornarControlesVisiveis (AddObject cria com Visible=.F. por padrao).
*
* Fase 4/8 - Grade e botoes: ConfigurarGrade() monta a grade (GradeSubN ->
* grd_4c_Dados, 4 colunas CFOP/Obs/De/Ate) e ConfigurarBotoes() monta os
* tres botoes (cmdSair/cmdInserir/cmdExcluir -> cmd_4c_CmdSair/
* cmd_4c_CmdInserir/cmd_4c_CmdExcluir), com Inserir/Excluir Visible/Enabled
* conforme this_cEscolha (legado). CarregarGrade() popula o cursor de
* trabalho do Business Object (equivalente a TmpCfoOp) e vincula o grid a
* ele - chamado em InicializarForm, guardado por gb_4c_ValidandoUI.
*
* Fase 5/8 - Lookup da coluna CFOP: TextBoxCfopGridCfp_4c (classes\
* TextBoxGridLookup.prg), instalada em Column1 via AddObject + CurrentControl
* + Sparse = .F. (regra #18) - BINDEVENT em evento de celula de Grid NAO eh
* confiavel (regra #46). Valid/KeyPress(F4/F5) delegam para
* ValidarCfopGridExec()/AbrirLookupCfopGrade() (metodos PUBLIC deste form,
* chamados de fora da classe pela celula - mesma exigencia de BINDEVENT da
* regra #3), que reproduzem o fwBuscaExt do legado contra SigCdCfo.
*
* Fase 6/8 - Lookup das colunas de Observacao (Padrao/Inicial/Final):
* TextBoxObsGridCfp_4c (classes\TextBoxGridLookup.prg), instalada em
* Column2/Column3/Column4 com o mesmo padrao AddObject + CurrentControl +
* Sparse = .F. da Column1. Valid/KeyPress(F4/F5) delegam para
* ValidarObsGridExec()/AbrirLookupObsGrade() (metodos PUBLIC deste form),
* que reproduzem o fwBuscaExt do legado contra SigCdObs E a validacao
* cruzada entre as tres colunas da mesma linha (ObsInis <= ObsPads <=
* ObsFins). Este dialogo nao tem pagina de Dados/Salvar separada - toda a
* edicao acontece nas celulas da grade (Column1..4), por isso nao ha
* container de botoes Salvar/Cancelar equivalente ao CRUD Page2 (o
* "cnt_4c_BotoesAcao" do template generico de fase 6 nao se aplica a este
* form OPERACIONAL).
*
* Fase 7/8 - Eventos principais: este dialogo NAO segue o padrao CRUD
* Incluir/Alterar/Visualizar/Excluir (o legado SIGOPCFP so tem cmdInserir/
* cmdExcluir/cmdSair - nenhum Alterar nem Visualizar, a edicao eh direto
* nas celulas da grade). BtnInserirClick/BtnExcluirClick/BtnSairClick
* (BINDEVENT no Click dos 3 CommandButton de ConfigurarBotoes) transcrevem
* cmdInserir/cmdExcluir/cmdSair do legado; SigOpCfpBO.SalvarGrade() (nova)
* persiste as alteracoes linha a linha (Inserir/Atualizar/ExecutarExclusao
* ja existentes) com o MESMO resultado final do bulk Delete+Append do
* legado (PILAR 3 - arquitetura obrigatoriamente diferente). O When de
* cada coluna de Observacao (habilita so depois do CFOP preenchido) vai
* em CelulaObsGradeEditavel(), chamado por TextBoxObsGridCfp_4c.When().
*
* Fase 8/8 - Consolidacao final: Destroy() acrescenta a rede de seguranca
* que reabilita this_oParentForm/AjustarBotoesFormPai mesmo fora do caminho
* de sucesso de BtnSairClick, e fecha os cursores de trabalho deste dialogo
* (cursor_4c_Dados/this_cCursorGrade e cursor_4c_OopOriginais) antes de
* DODEFAULT() (CorretorAutomatico Pattern #145). Os metodos auxiliares do
* template generico de form CRUD (FormParaBO/BOParaForm, HabilitarCampos/
* LimparCampos, CarregarLista, AjustarBotoesPorModo, BtnSalvarClick/
* BtnCancelarClick/BtnBuscarClick/BtnEncerrarClick) NAO se aplicam a este
* form OPERACIONAL: nao ha Page1/Page2, a edicao eh direto nas celulas da
* grade (CarregarGrade/BtnInserirClick/BtnExcluirClick da fase 4/7 cobrem o
* equivalente de CarregarLista/Incluir/Excluir) e o "salvar" eh
* SalvarGrade(), chamado por BtnSairClick (fase 7) - o proprio botao
* "Encerrar" do legado (cmdSair). THIS.Release() em BtnSairClick eh seguro
* aqui (diferente de dialogo tipo FormBuscaAuxiliar/FormSigOpCbx): este
* dialogo nao devolve nenhum valor por property para o chamador ler depois
* do Show() - toda a persistencia ja aconteceu via SalvarGrade() antes do
* Release(), e o legado tambem nao expõe nenhum "Retorno" no Unload do
* SIGOPCFP original.
*
* Integracao pendente: diferente de form OPERACIONAL autonomo (menu ->
* AbrirForm<X>), este dialogo e filho MODAL do Cadastro de Operacoes
* (SigCdOpe) e exige par_oFormPai/par_cDopes/par_cEscolha na abertura -
* nao ha como abri-lo isolado pelo menu. A chamada
* CREATEOBJECT("FormSigOpCfp", ThisForm, <Dopes>, <pcEscolha>).Show() fica
* a cargo da migracao do form de Operacoes (SigCdOpe/FormOPE), que ainda
* nao referencia este dialogo (grep confirmado em 2026-10-23) - sem
* SET PROCEDURE nem item de menu proprios aqui, portanto.
*==============================================================================

DEFINE CLASS FormSigOpCfp AS FormBase

    *-- Propriedades visuais (legado SIGOPCFP.scx)
    Width        = 800
    Height       = 400
    BorderStyle  = 2
    ControlBox   = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1

    *-- Parametros recebidos na abertura (legado: Lparameters poForm,
    *-- pnDataSes, pcEscolha - pnDataSes deixou de ser necessario, ver nota
    *-- no cabecalho do arquivo)
    this_oParentForm = .NULL.
    this_cDopes      = ""   && codigo da Operacao (legado "crSigCdOpe.Dopes")
    this_cEscolha    = ""   && legado "pcEscolha" - habilita Inserir/Excluir

    *--------------------------------------------------------------------------
    * Init - Recebe o form pai, o codigo da Operacao (Dopes) e o modo de
    * edicao, monta o Caption dinamico (legado: "Cfop's p/: " +
    * AllTrim(Proper(crSigCdOpe.Dopes))) e encaminha para
    * FormBase.Init()/InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cDopes, par_cEscolha)
        THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_cEscolha    = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")

        THIS.Caption = "Cfop's p/: " + ALLTRIM(PROPER(THIS.this_cDopes))

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Instancia o Business Object (repassando o codigo da
    * Operacao recebido no Init), monta a aparencia do form e a faixa do
    * cabecalho, posiciona o dialogo perto da grade da Lista do pai e
    * desabilita o pai enquanto o dialogo estiver aberto (legado: Init faz
    * "Thisform.ParentForm.Enabled = .F." + "Thisform.mCtrlBotoes(.F.)").
    * Monta a grade e os botoes (ConfigurarGrade/ConfigurarBotoes) e, fora do
    * modo de validacao de UI, carrega os Cfops ja permitidos (CarregarGrade).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCfpBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                THIS.ConfigurarAparencia()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoes()
                THIS.PosicionarJuntoAoFormPai()

                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                THIS.AjustarBotoesFormPai(.F.)

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarGrade()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Cfop's Permitidas " + ;
                    "para Opera" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCfp")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparencia - Fundo padrao do dialogo (legado: form.Picture =
    * ..\framework\imagens\new_background.jpg) e fonte base (Tahoma 8, igual
    * aos demais controles do dump).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (legado: cntSombra), com os
    * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). O legado
    * declara cntSombra.Width=800/labels.Width=769 (boilerplate do template
    * generico de frmcadastro, igual a FormSigOpCbx - mesmo dump, mesmos
    * valores) - cnt_4c_Sombra usa THIS.Width (regra #11, canonico); os
    * labels mantem a largura literal do dump (769 < 800, cabe inteiro na
    * area visivel, nao ha clipping).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarJuntoAoFormPai - Reproduz o calculo de Top/Left do Init
    * legado, que ancora o dialogo perto da grade da Lista do form pai:
    *   .Top  = ParentForm.Top + Grade.Top + 50
    *   .Left = ParentForm.Left + Grade.Left + Grade.Columns(1).Width + ;
    *           Grade.Columns(3).Width + 16
    *
    * No sistema novo a grade da Lista do pai (form CRUD canonico) fica em
    * pgf_4c_Paginas.Page1.grd_4c_Lista (ver docs\framework_frmcadastro_layout.md
    * e FormCor.prg) - cada nivel e checado com PEMSTATUS antes de usar, para
    * nao estourar quando o form pai ainda nao segue essa estrutura (ou em
    * instanciacao standalone/teste, sem form pai). Falhando qualquer
    * checagem, o dialogo mantem o AutoCenter padrao herdado de FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        LOCAL loc_oGrade

        IF VARTYPE(THIS.this_oParentForm) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
            RETURN
        ENDIF

        loc_oGrade = THIS.this_oParentForm.pgf_4c_Paginas.Page1.grd_4c_Lista

        IF !PEMSTATUS(loc_oGrade, "Column1", 5) OR !PEMSTATUS(loc_oGrade, "Column3", 5)
            RETURN
        ENDIF

        THIS.AutoCenter = .F.
        THIS.Top  = THIS.this_oParentForm.Top + loc_oGrade.Top + 50
        THIS.Left = THIS.this_oParentForm.Left + loc_oGrade.Left + ;
            loc_oGrade.Column1.Width + loc_oGrade.Column3.Width + 16
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesFormPai - Legado "mCtrlBotoes(plHabilita)": percorre os
    * botoes CRUD do form pai e o botao de saida, habilitando/desabilitando
    * conforme par_lHabilita. No pai (form CRUD canonico) os botoes CRUD ficam
    * em pgf_4c_Paginas.Page1.cnt_4c_Botoes e o de saida em
    * pgf_4c_Paginas.Page1.cnt_4c_Saida (docs\framework_frmcadastro_layout.md) -
    * equivalente a Grupo_Op/Grupo_Saida.Sair do legado. Cada nivel e checado
    * com PEMSTATUS; sem a estrutura esperada (form pai ausente ou standalone/
    * teste), o metodo e no-op.
    *
    * Chamado com .F. no InicializarForm (legado: Init); com .T. no
    * BtnSairClick (legado: cmdSair.Click), nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesFormPai(par_lHabilita)
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_nI, loc_oCtrl

        IF VARTYPE(THIS.this_oParentForm) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        loc_oPagina = THIS.this_oParentForm.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
            loc_oBotoes = loc_oPagina.cnt_4c_Botoes
            FOR loc_nI = 1 TO loc_oBotoes.ControlCount
                loc_oCtrl = loc_oBotoes.Controls(loc_nI)
                IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON" AND loc_oCtrl.Visible
                    loc_oCtrl.Enabled = par_lHabilita
                ENDIF
            ENDFOR
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
            loc_oSaida = loc_oPagina.cnt_4c_Saida
            FOR loc_nI = 1 TO loc_oSaida.ControlCount
                loc_oCtrl = loc_oSaida.Controls(loc_nI)
                IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON"
                    loc_oCtrl.Enabled = par_lHabilita
                ENDIF
            ENDFOR
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Monta a grade de Cfops permitidos (legado GradeSubN,
    * 4 colunas: CFOP/Obs/De/Ate - equivalentes a Cfops/ObsPads/ObsInis/
    * ObsFins de SigCdOop). Aqui so a ESTRUTURA visual (Width/Header/estilo
    * de cada coluna) - RecordSource/ControlSource ficam em CarregarGrade(),
    * DEPOIS do Business Object (re)criar o cursor de trabalho, porque
    * vincular antes seria descartado quando o cursor for recriado (mesmo
    * padrao de FormFpN.ConfigurarPaginaLista/CarregarDados). As colunas 1
    * (lookup de CFOP) e 2/3/4 (lookup de Observacao) recebem BINDEVENT nas
    * fases 5/6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 120
            .Left          = 281
            .Width         = 237
            .Height        = 221
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "CFOP"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de CFOP (legado: fwBuscaExt contra SigCdCfo) - celula
            *-- com Valid/LostFocus/KeyPress embutidos (regra #18/#46), nunca
            *-- AfterRowColChange. Instalada POR CIMA do Text1 (CurrentControl).
            .AddObject("txt_4c_Cfop", "TextBoxCfopGridCfp_4c")
            .CurrentControl = "txt_4c_Cfop"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .Width     = 35
            .ReadOnly  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Obs"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de Observacao PADRAO (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsInis/ObsFins da
            *-- mesma linha - regra #18/#46).
            .AddObject("txt_4c_ObsPad", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsPad.this_cCampoObs = "OBSPADS"
            .CurrentControl = "txt_4c_ObsPad"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .Width     = 35
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "De"
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Lookup de Observacao INICIAL (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsPads da mesma linha).
            .AddObject("txt_4c_ObsIni", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsIni.this_cCampoObs = "OBSINIS"
            .CurrentControl = "txt_4c_ObsIni"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .Width     = 35
            .Sparse    = .T.
            .ReadOnly  = .F.
            .BackColor = RGB(255, 255, 255)
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "At" + CHR(233)
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Margin    = 0
                .Top       = 21
                .Left      = 13
                .Width     = 100
                .Height    = 23
            ENDWITH

            *-- Lookup de Observacao FINAL (legado: fwBuscaExt contra
            *-- SigCdObs + validacao cruzada contra ObsPads da mesma linha).
            .AddObject("txt_4c_ObsFim", "TextBoxObsGridCfp_4c")
            .txt_4c_ObsFim.this_cCampoObs = "OBSFINS"
            .CurrentControl = "txt_4c_ObsFim"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        THIS.grd_4c_Dados.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Monta os 3 botoes do dialogo (legado cmdInserir/
    * cmdExcluir/cmdSair - fwbtng/framework.vcx, ambos CommandButton
    * standalone). Inserir/Excluir ficam Visible/Enabled conforme
    * this_cEscolha (legado Init: "Iif(Type('Thisform.PcEscolha')#'C', .T.,
    * InList(Thisform.PcEscolha,'INSERIR','ALTERAR'))") - grade fica
    * so-leitura fora de INSERIR/ALTERAR (ex.: VISUALIZAR). cmdSair fica
    * sempre disponivel, com Cancel=.T. (ESC aciona, igual ao legado). O
    * Click de cada botao fica para a fase 7/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lHabilitaEdicao

        loc_lHabilitaEdicao = IIF(EMPTY(THIS.this_cEscolha), .T., ;
            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"))

        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Tahoma"
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
            .Visible         = loc_lHabilitaEdicao
            .Enabled         = loc_lHabilitaEdicao
        ENDWITH

        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
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
            .Visible         = loc_lHabilitaEdicao
            .Enabled         = loc_lHabilitaEdicao
        ENDWITH

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
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
            .Visible         = .T.
            .Enabled         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Inclui linha em branco na grade (legado:
    * cmdInserir.Click: "Locate for Cfops = Space(10) / If Eof() / Insert
    * Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
    * fUniqueIds()) / Endif", reaproveitando a linha vazia se ja existir
    * uma - nunca abre uma segunda). this_oBusinessObject.NovoRegistro()
    * gera a chave (InicializarValoresPadrao -> fUniqueIds(), regra #22 -
    * PK Fortyus nunca pode nascer vazia) e zera as demais propriedades
    * (LimparDados tambem zera this_cDopes - reposto abaixo, igual ao
    * padrao de SigOpCflBO.this_cNums).
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

        IF EOF()
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

            SELECT (loc_cCursor)
            APPEND BLANK
            REPLACE dopes     WITH THIS.this_oBusinessObject.this_cDopes, ;
                    cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
                    cfops     WITH "", ;
                    cgrus     WITH "", ;
                    obspads   WITH 0, ;
                    obsinis   WITH 0, ;
                    obsfins   WITH 0
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove a linha corrente da grade (legado:
    * cmdExcluir.Click: "If Not Eof() / Delete / Skip / Skip - 1 / Endif").
    * So marca a linha como deletada no cursor de trabalho - a exclusao
    * efetiva em SigCdOop (quando a linha ja existia la) acontece em
    * SalvarGrade(), no BtnSairClick, igual ao legado (que so regrava
    * SigCdOop ao sair do dialogo, nunca a cada clique em Excluir).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        IF !EOF()
            DELETE
            SKIP
            SKIP -1
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o dialogo (legado: cmdSair.Click). So tenta
    * gravar quando o dialogo estava em modo editavel (legado: "If
    * Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible") - em
    * VISUALIZAR (Inserir/Excluir ocultos pelo this_cEscolha) fecha direto,
    * sem tocar no banco. Falhando a gravacao (Cfop duplicado ou erro de
    * SQL - SigOpCfpBO.SalvarGrade ja exibiu o aviso/erro), o dialogo
    * PERMANECE aberto para o usuario corrigir, igual ao "Return .f." do
    * legado no meio do Click (nao reabilita o pai, nao libera o form).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_lPodeEditar, loc_lSucesso

        loc_lPodeEditar = THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
        loc_lSucesso    = .T.

        IF loc_lPodeEditar AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.SalvarGrade()
        ENDIF

        IF loc_lSucesso
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.AjustarBotoesFormPai(.T.)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Popula o cursor de trabalho do Business Object com os
    * Cfops ja permitidos para a Operacao corrente (legado Init: "Select *
    * From SigCdOop where Dopes=...") e vincula o grid a ele. RecordSource/
    * ControlSource ficam aqui (nao em ConfigurarGrade) porque o Business
    * Object RECRIA o cursor a cada chamada - vincular antes seria
    * descartado (mesmo padrao de FormFpN.CarregarDados). Reaplica
    * Header1.Caption depois do ControlSource, porque RecordSource reseta
    * os cabecalhos das colunas.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_oGrid, loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarCfopsPermitidos()
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
        loc_oGrid   = THIS.grd_4c_Dados

        loc_oGrid.ColumnCount  = 4
        loc_oGrid.RecordSource = loc_cCursor

        loc_oGrid.Column1.ControlSource = loc_cCursor + ".cfops"
        loc_oGrid.Column2.ControlSource = loc_cCursor + ".obspads"
        loc_oGrid.Column3.ControlSource = loc_cCursor + ".obsinis"
        loc_oGrid.Column4.ControlSource = loc_cCursor + ".obsfins"

        loc_oGrid.Column1.Header1.Caption = "CFOP"
        loc_oGrid.Column2.Header1.Caption = "Obs"
        loc_oGrid.Column3.Header1.Caption = "De"
        loc_oGrid.Column4.Header1.Caption = "At" + CHR(233)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
        ENDIF

        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfopGridExec - Corpo do Valid da celula CFOP da grade (legado
    * SIGOPCFP.GradeSubN.Column1.Text1.Valid: "If Lastkey() == 27 / Return"
    * antes de qualquer coisa - ESC na celula aborta o Valid sem tentar o
    * lookup, preservando o valor atual). PUBLIC: chamado de FORA da classe
    * do form pela celula TextBoxCfopGridCfp_4c (THISFORM.<metodo>, mesma
    * exigencia de BINDEVENT da regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfopGridExec(par_oTxt)
        IF LASTKEY() = 27
            RETURN .T.
        ENDIF

        RETURN THIS.AbrirLookupCfopGrade(par_oTxt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCfopGrade - Lookup de CFOP (legado: "xBrox = CreateObject(
    * 'fwBuscaExt',...,'SigCdCfo','crSigCdCfo','Codigos',This.Value,
    * 'Selecao',.t.,'Codigos')" + mAddColuna Codigos/Descricaos/Operacaos).
    * FormBuscaAuxiliar.Init ja tenta o match exato sozinho (regra #37) -
    * so abre o Show() quando nao resolveu. Atribuicao do valor escolhido
    * SOMENTE sob a guarda this_lSelecionou (regra #37); fora dela, o
    * legado faz "Else This.Value = ''" (ESC no picker limpa o codigo) -
    * reproduzido aqui, nao eh o defeito da regra #50 (ali nao havia
    * picker nenhum para servir de feedback).
    *
    * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
    * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
    * sistema novo). PUBLIC pelo mesmo motivo de ValidarCfopGridExec.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCfopGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cValor

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCfo", ;
            "cursor_4c_BuscaCfop", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfop")
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaCfop.codigos)
            ELSE
                par_oTxt.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCfop")
            USE IN cursor_4c_BuscaCfop
        ENDIF

        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarObsGridExec - Corpo do Valid das celulas de Observacao da grade
    * (legado SIGOPCFP.GradeSubN.Column2/3/4.Text1.Valid - as 3 colunas
    * repetem o mesmo padrao): abre o lookup quando a celula nao esta vazia
    * e, em seguida, valida CRUZADO contra as outras duas colunas da MESMA
    * linha (Padrao/Inicial/Final) - "Return 0" do legado mantem o foco na
    * celula quando a cruzada falha. par_cCampoObs ("OBSPADS"/"OBSINIS"/
    * "OBSFINS") vem de TextBoxObsGridCfp_4c.this_cCampoObs e diz qual das
    * tres regras aplicar. PUBLIC: chamado de FORA da classe do form pela
    * celula (mesma exigencia de BINDEVENT da regra #3).
    *
    * O valor em validacao ainda esta em par_oTxt.Value (o cursor so recebe
    * DEPOIS - regra #46); os outros dois lados da comparacao vem do cursor
    * da grade, que ja reflete o que foi digitado nas celulas anteriores da
    * mesma linha.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarObsGridExec(par_oTxt, par_cCampoObs)
        LOCAL loc_lResultado, loc_cCursor, loc_nObsPad, loc_nObsIni, loc_nObsFin

        IF LASTKEY() = 27
            RETURN .T.
        ENDIF

        loc_lResultado = .T.

        IF !EMPTY(par_oTxt.Value)
            THIS.AbrirLookupObsGrade(par_oTxt)
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF USED(loc_cCursor)
            loc_nObsPad = EVALUATE(loc_cCursor + ".obspads")
            loc_nObsIni = EVALUATE(loc_cCursor + ".obsinis")
            loc_nObsFin = EVALUATE(loc_cCursor + ".obsfins")

            DO CASE
            CASE par_cCampoObs = "OBSPADS"
                loc_nObsPad = par_oTxt.Value
                IF !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsIni) AND (loc_nObsIni > loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
                        "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
                IF loc_lResultado AND !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsFin) AND (loc_nObsFin < loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
                        "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            CASE par_cCampoObs = "OBSINIS"
                loc_nObsIni = par_oTxt.Value
                IF !EMPTY(loc_nObsIni) AND !EMPTY(loc_nObsPad) AND (loc_nObsIni > loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
                        "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            CASE par_cCampoObs = "OBSFINS"
                loc_nObsFin = par_oTxt.Value
                IF !EMPTY(loc_nObsFin) AND !EMPTY(loc_nObsPad) AND (loc_nObsFin < loc_nObsPad)
                    MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
                        "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDCASE
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupObsGrade - Lookup de Observacao (legado: "xBrox =
    * CreateObject('fwBuscaExt',...,'SigCdObs','crSigCdObs','Codigos',
    * This.Value,'Cadastro de Observacoes',.t.,'Codigos')" + mAddColuna
    * Codigos/Observas). FormBuscaAuxiliar.Init ja tenta o match exato
    * sozinho (regra #37) - equivalente ao ChkRegister do legado, que so
    * abre o picker quando o codigo digitado NAO existe. Coluna numeric(3,0)
    * (SigCdObs.codigos/SigCdOop.obspads-obsinis-obsfins): o valor digitado
    * eh convertido para string so para a busca (par_cValor de
    * FormBuscaAuxiliar eh sempre Character); de volta, o Codigos escolhido
    * retorna NUMERICO para a celula. ESC no picker zera a celula (legado:
    * "This.Value = Iif(Lastkey()==27, 0, crSigCdObs.Codigos)") - NAO bloqueia
    * a saida da celula (a cruzada de ValidarObsGridExec trata Empty(0) como
    * "sem restricao", igual ao legado).
    *
    * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
    * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
    * sistema novo). PUBLIC pelo mesmo motivo de ValidarObsGridExec.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupObsGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cValor

        loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, 0)))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdObs", ;
            "cursor_4c_BuscaObs", "codigos", loc_cValor, ;
            "Cadastro de Observa" + CHR(231) + CHR(245) + "es", .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("observas", "", "Observa" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
                par_oTxt.Value = NVL(cursor_4c_BuscaObs.codigos, 0)
            ELSE
                par_oTxt.Value = 0
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaObs")
            USE IN cursor_4c_BuscaObs
        ENDIF

        par_oTxt.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaObsGradeEditavel - Legado (GradeSubN.Column2/3/4.Text1.When):
    * "Return (not Empty(TmpCfoOp.Cfops))" - as celulas de Observacao
    * (Padrao/Inicial/Final) so ficam editaveis depois do CFOP da MESMA
    * linha estar preenchido. Chamado pelo When de TextBoxObsGridCfp_4c
    * (classes\TextBoxGridLookup.prg) - PUBLIC pelo mesmo motivo das
    * demais delegacoes de celula de grade (regra #3/#46).
    *--------------------------------------------------------------------------
    PROCEDURE CelulaObsGradeEditavel()
        LOCAL loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .T.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        RETURN !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".cfops"), "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Consolidacao final (fase 8/8): rede de seguranca para o pai e
    * limpeza dos cursores de trabalho deste dialogo.
    *
    * BtnSairClick (fase 7/8) ja reabilita THIS.this_oParentForm e chama
    * AjustarBotoesFormPai(.T.) no caminho de SUCESSO antes de THIS.Release().
    * Mas o legado garantia a reabilitacao do pai so por viver na MESMA
    * DataSession/Release Windows unico - aqui, se o dialogo for destruido por
    * qualquer caminho que nao passe por ali (erro nao tratado em algum ponto
    * fora de TRY, RELEASE externo), o pai NAO pode ficar desabilitado para
    * sempre. Repetir aqui eh idempotente (reabilitar duas vezes nao tem
    * efeito colateral).
    *
    * Fecha tambem cursor_4c_Dados (grade de trabalho, this_cCursorGrade do
    * BO) e cursor_4c_OopOriginais (snapshot usado por SalvarGrade) - os
    * demais cursores temporarios (cursor_4c_BuscaCfop/Obs,
    * cursor_4c_OopTemp/Duplic/Removidas) ja se fecham inline nos proprios
    * metodos. O nome do cursor de grade e lido ANTES do DODEFAULT() (abaixo)
    * porque FormBase.Destroy() anula THIS.this_oBusinessObject.
    *
    * DODEFAULT() por ULTIMO (CorretorAutomatico Pattern #145) - sem isso
    * FormBase.Destroy() nao roda e o menu principal fica com popups
    * encolhidos apos este dialogo fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cCursorGrade

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
        ELSE
            loc_cCursorGrade = "cursor_4c_Dados"
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.AjustarBotoesFormPai(.T.)

        IF !EMPTY(loc_cCursorGrade) AND USED(loc_cCursorGrade)
            USE IN (loc_cCursorGrade)
        ENDIF

        IF USED("cursor_4c_OopOriginais")
            USE IN cursor_4c_OopOriginais
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
    * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
    * metodo fica generico para reaproveitar nas fases seguintes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCfpBO.prg):
*==============================================================================
* SigOpCfpBO.prg - Business Object para Cfop's Permitidas por Operacao
*
* Form OPERACIONAL (popup filho do Cadastro de Operacoes - SigCdOpe): mantem
* a lista de CFOPs permitidos para uma Operacao (Dopes), com os limites de
* Observacao (Padrao/Inicial/Final) de cada CFOP.
*
* Tabela: SigCdOop (cada registro = um CFOP permitido para uma Operacao)
*   cfops      char(10) NOT NULL - codigo do CFOP permitido
*   cidchaves  char(20) NOT NULL - chave primaria (PK Fortyus, gerada com fUniqueIds())
*   dopes      char(20) NOT NULL - codigo da Operacao (FK SigCdOpe.Dopes)
*   cgrus      char(3)  NOT NULL - grupo (nao exibido na grade, preservado do SELECT *)
*   obspads    numeric(3,0) NOT NULL - observacao padrao
*   obsinis    numeric(3,0) NOT NULL - observacao inicial
*   obsfins    numeric(3,0) NOT NULL - observacao final
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCfpBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade (mapeamento para a tabela SigCdOop)
    * Cada instancia representa UMA linha da grade de CFOPs permitidos.
    *==========================================================================
    this_cCidChaves  = ""   && cidchaves char(20) - PK Fortyus
    this_cDopes      = ""   && dopes char(20) - codigo da Operacao (FK SigCdOpe.Dopes)
    this_cCfop       = ""   && cfops char(10) - codigo do CFOP permitido
    this_cCgrupo     = ""   && cgrus char(3) - grupo (NOT NULL, nao exibido na grade)
    this_nObsPadrao  = 0    && obspads numeric(3,0) - observacao padrao da operacao
    this_nObsInicial = 0    && obsinis numeric(3,0) - observacao inicial permitida
    this_nObsFinal   = 0    && obsfins numeric(3,0) - observacao final permitida

    *-- Cursor de trabalho do grid (legado "TmpCfoOp") - editavel, recriado
    *-- a cada CarregarCfopsPermitidos(). Nome exposto para o Form vincular
    *-- RecordSource/ControlSource DEPOIS de (re)carregar (igual a FpNBO).
    this_cCursorGrade = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdOop"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/
    * CancelarEdicao). this_cDopes TAMBEM eh limpo - eh FK para a Operacao
    * (SigCdOpe.Dopes) que o Form (fase do layout) deve repor logo apos
    * THIS.NovoRegistro(), igual ao padrao de SigOpCflBO.this_cNums.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves  = ""
        THIS.this_cDopes      = ""
        THIS.this_cCfop       = ""
        THIS.this_cCgrupo     = ""
        THIS.this_nObsPadrao  = 0
        THIS.this_nObsInicial = 0
        THIS.this_nObsFinal   = 0
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Espelha o ramo do cmdInserir.Click legado:
    *     Insert Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
    * A chave ja nasce com a linha em branco, antes do usuario preencher o
    * CFOP - exatamente como o legado gera a PK na hora de inserir a linha na
    * grade, nao na hora de salvar.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * de SigCdOop (cursor_4c_Dados ou o cursor temporario da grade).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * campo nao eh sintaxe valida em VFP9.
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, ao
    * posicionar na linha da grade (ex.: BtnExcluirClick/AfterRowColChange).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes,     "")
                THIS.this_cCfop       = TratarNulo(cfops,     "")
                THIS.this_cCgrupo     = TratarNulo(cgrus,     "")
                THIS.this_nObsPadrao  = TratarNulo(obspads,   0)
                THIS.this_nObsInicial = TratarNulo(obsinis,   0)
                THIS.this_nObsFinal   = TratarNulo(obsfins,   0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursorGrade - (Re)cria o cursor de trabalho do grid, vazio,
    * com a mesma estrutura de SigCdOop usada na grade (legado "TmpCfoOp" -
    * "Select * From xCfoOp Into Cursor TmpCfoOp ReadWrite"). Chamado por
    * CarregarCfopsPermitidos() antes de popular - o Form so vincula
    * RecordSource/ControlSource DEPOIS dessa chamada (regra: Column.
    * ControlSource exige que o cursor ja exista).
    *==========================================================================
    PROCEDURE InicializarCursorGrade()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorGrade) ;
                (cidchaves C(20) NULL, dopes C(20) NULL, cfops C(10) NULL, ;
                 cgrus C(3) NULL, obspads N(3,0) NULL, obsinis N(3,0) NULL, obsfins N(3,0) NULL)
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.InicializarCursorGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCfopsPermitidos - Carrega para THIS.this_cCursorGrade todos os
    * Cfops ja permitidos da Operacao corrente (THIS.this_cDopes), espelhando
    * a consulta do Init legado ("Select * From SigCdOop where Dopes=...").
    * SQLEXEC vai para um cursor TEMPORARIO - nunca direto no cursor do grid
    * (SQLEXEC sobre o alias ligado ao Grid zera o ColumnCount). PUBLIC: o
    * Form chama de fora, apos instanciar o BO (regra #51).
    *==========================================================================
    PROCEDURE CarregarCfopsPermitidos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = THIS.InicializarCursorGrade()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF

            loc_cSQL = "SELECT cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins" + ;
                " FROM SigCdOop WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OopTemp")

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorGrade)
                IF RECCOUNT("cursor_4c_OopTemp") > 0
                    APPEND FROM DBF("cursor_4c_OopTemp")
                ENDIF
                GO TOP

                *-- Snapshot das chaves JA existentes em SigCdOop ao abrir o
                *-- dialogo - usado por SalvarGrade() (fase 7/8) para decidir
                *-- Inserir() x Atualizar() x excluir por diferenca, sem
                *-- precisar do Delete+Append em massa do legado.
                IF USED("cursor_4c_OopOriginais")
                    USE IN cursor_4c_OopOriginais
                ENDIF
                SELECT cidchaves FROM (THIS.this_cCursorGrade) ;
                    INTO CURSOR cursor_4c_OopOriginais

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
            MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarCfopsPermitidos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Transcricao das validacoes do legado espalhadas pelos
    * Valid das colunas da grade (Column2/Column3/Column4): a Observacao
    * Inicial nao pode ser maior que a Padrao, e a Observacao Final nao pode
    * ser menor que a Padrao. Empty(0) = .T. em VFP9, entao a checagem so
    * entra em vigor quando os dois lados estao preenchidos - igual ao legado.
    * Chamado por BusinessBase.Salvar(), que exibe a falha via ExibirFalha()
    * quando este metodo devolve .F. (regra #20) - sem MsgAviso proprio aqui.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cCfop))
            THIS.this_cMensagemErro = "Cfop n" + CHR(227) + "o informado."
        CASE EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
        CASE !EMPTY(THIS.this_nObsInicial) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsInicial > THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Inicial N" + ;
                CHR(227) + "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!"
        CASE !EMPTY(THIS.this_nObsFinal) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsFinal < THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Final N" + ;
                CHR(227) + "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!"
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - Inclui um CFOP permitido para a Operacao em SigCdOop.
    * Espelha o INSERT em massa do cmdSair.Click legado (Select * From
    * TmpCfoOp / Append From Dbf), aplicado linha a linha pela arquitetura
    * nova. cgrus eh NOT NULL e nao aparece na grade - vem preservado da
    * propriedade (this_cCgrupo), carregada do SELECT * do cursor de origem.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdOop (cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCfpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza um CFOP permitido existente em SigCdOop.
    * dopes e cidchaves sao a chave do registro e NAO sao regraveis; cfops e
    * as tres observacoes (padrao/inicial/final) espelham o que o usuario
    * edita nas colunas da grade. cgrus eh regravado com o mesmo valor
    * carregado (nunca editado na tela), preservando o grupo original.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdOop
                   SET cfops   = <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                       cgrus   = <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                       obspads = <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                       obsinis = <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                       obsfins = <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                 WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCfpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExisteChaveOriginal - .T. se par_cCidChaves ja existia em SigCdOop ao
    * abrir o dialogo (snapshot cursor_4c_OopOriginais, tirado em
    * CarregarCfopsPermitidos). Usado por SalvarGrade() para decidir entre
    * Inserir() e Atualizar() - sem indice em cursor_4c_OopOriginais, por
    * isso LOCATE (poucas linhas, nao precisa de SEEK).
    *==========================================================================
    PROTECTED FUNCTION ExisteChaveOriginal(par_cCidChaves)
        LOCAL loc_lAchou, loc_cAliasAtual

        loc_lAchou = .F.

        IF USED("cursor_4c_OopOriginais")
            loc_cAliasAtual = ALIAS()
            SELECT cursor_4c_OopOriginais
            LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(NVL(par_cCidChaves, ""))
            loc_lAchou = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * SalvarGrade - Persiste as alteracoes da grade de Cfops permitidos
    * (this_cCursorGrade): INSERT para linha nova, UPDATE para linha
    * existente, DELETE para linha removida pelo usuario - resultado final
    * equivalente ao cmdSair.Click legado (Delete From SigCdOop Where
    * Dopes=... seguido de reinsercao INTEGRAL de TmpCfoOp), aqui aplicado
    * linha a linha pelos metodos Inserir/Atualizar/ExecutarExclusao ja
    * existentes (PILAR 3 - arquitetura obrigatoriamente diferente do
    * legado, mesmo resultado final no banco).
    *
    * Validacoes na MESMA ordem do legado:
    *   1. Descarta as linhas em branco do cursor (legado: "Delete For
    *      Cfops = Space(10)") - cmdInserir.Click (fase 7/8) cria a linha
    *      vazia; se o usuario sair sem preencher o Cfop, ela e descartada
    *      em silencio, igual ao legado.
    *   2. Cfop duplicado entre as linhas remanescentes (legado: "Select
    *      Cfops, sum(1) From TmpCfoOp Group by 1 having sum(1) > 1") ->
    *      aborta com o MESMO aviso do legado e devolve .F. SEM alterar o
    *      banco - BtnSairClick (fase 7/8) mantem o dialogo aberto para o
    *      usuario corrigir (legado: "Return .f." no meio do Click).
    *
    * As linhas que existiam ao abrir o dialogo e que nao sobraram no
    * cursor apos a etapa 1 (porque o usuario excluiu, ou porque a linha
    * em branco por acaso reaproveitou uma chave existente - nunca ocorre,
    * cidchaves de linha nova sempre vem de fUniqueIds()) sao EXCLUIDAS do
    * banco.
    *
    * PUBLIC: chamado pelo form em BtnSairClick (regra #51 - Inserir/
    * Atualizar/ExecutarExclusao continuam PROTECTED, acessados so por
    * este metodo, da PROPRIA classe).
    *==========================================================================
    PROCEDURE SalvarGrade()
        LOCAL loc_lSucesso, loc_cCursor, loc_nDuplic

        loc_lSucesso = .T.
        loc_cCursor  = THIS.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        TRY
            *-- 1) descarta linhas em branco (legado: Delete For Cfops = Space(10))
            SELECT (loc_cCursor)
            DELETE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

            *-- 2) duplicidade de Cfop entre as linhas remanescentes
            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF
            SELECT cfops FROM (loc_cCursor) WHERE !DELETED() ;
                GROUP BY cfops HAVING COUNT(*) > 1 INTO CURSOR cursor_4c_OopDuplic

            loc_nDuplic = RECCOUNT("cursor_4c_OopDuplic")

            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF

            IF loc_nDuplic > 0
                MsgAviso("Existem Cfops em Duplicidade. Favor Acertar!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- 3) INSERT/UPDATE das linhas remanescentes
            IF loc_lSucesso
                SELECT (loc_cCursor)
                SCAN FOR !DELETED()
                    THIS.CarregarDoCursor(loc_cCursor)

                    IF THIS.ExisteChaveOriginal(THIS.this_cCidChaves)
                        loc_lSucesso = THIS.Atualizar()
                    ELSE
                        loc_lSucesso = THIS.Inserir()
                    ENDIF

                    IF !loc_lSucesso
                        EXIT
                    ENDIF

                    SELECT (loc_cCursor)
                ENDSCAN
            ENDIF

            *-- 4) exclui as linhas que existiam antes e nao sobraram no cursor
            IF loc_lSucesso AND USED("cursor_4c_OopOriginais")
                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF

                SELECT cidchaves FROM cursor_4c_OopOriginais ;
                    WHERE cidchaves NOT IN ;
                        (SELECT cidchaves FROM (loc_cCursor) WHERE !DELETED()) ;
                    INTO CURSOR cursor_4c_OopRemovidas

                SELECT cursor_4c_OopRemovidas
                SCAN
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_lSucesso = THIS.ExecutarExclusao()
                    IF !loc_lSucesso
                        EXIT
                    ENDIF
                    SELECT cursor_4c_OopRemovidas
                ENDSCAN

                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.SalvarGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui o CFOP permitido de SigCdOop.
    * Espelha o cmdExcluir.Click legado (Delete na linha corrente da grade) -
    * aqui aplicado direto na tabela, chave por cidchaves.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdOop WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCfpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

