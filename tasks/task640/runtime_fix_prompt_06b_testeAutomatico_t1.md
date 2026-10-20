# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarDadosReais': Sem conexao ao banco (gnConnHandle invalido); Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-16 19:56:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-16 19:56:12] [INFO] Config FPW: (nao fornecido)
[2026-10-16 19:56:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-16 19:56:12] [INFO] Timeout: 300 segundos
[2026-10-16 19:56:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0lvg2izs.prg
[2026-10-16 19:56:12] [INFO] Conteudo do wrapper:
[2026-10-16 19:56:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopagr', 'C:\4c\tasks\task640', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopagr', 'C:\4c\tasks\task640', 'OPERACIONAL'
QUIT

[2026-10-16 19:56:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0lvg2izs.prg
[2026-10-16 19:56:12] [INFO] VFP output esperado em: C:\4c\tasks\task640\vfp_output.txt
[2026-10-16 19:56:12] [INFO] Executando Visual FoxPro 9...
[2026-10-16 19:56:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0lvg2izs.prg
[2026-10-16 19:56:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0lvg2izs.prg
[2026-10-16 19:56:12] [INFO] Timeout configurado: 300 segundos
[2026-10-16 19:58:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-16 19:58:33] [INFO] VFP9 finalizado em 141.2641094 segundos
[2026-10-16 19:58:33] [INFO] Exit Code: 
[2026-10-16 19:58:33] [INFO] 
[2026-10-16 19:58:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-16 19:58:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0lvg2izs.prg
[2026-10-16 19:58:33] [INFO] 
[2026-10-16 19:58:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-16 19:58:33] [INFO] * Auto-generated wrapper for parameters
[2026-10-16 19:58:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-16 19:58:33] [INFO] * Parameters: 'Formsigopagr', 'C:\4c\tasks\task640', 'OPERACIONAL'
[2026-10-16 19:58:33] [INFO] 
[2026-10-16 19:58:33] [INFO] * Anti-dialog protections for unattended execution
[2026-10-16 19:58:33] [INFO] SET SAFETY OFF
[2026-10-16 19:58:33] [INFO] SET RESOURCE OFF
[2026-10-16 19:58:33] [INFO] SET TALK OFF
[2026-10-16 19:58:33] [INFO] SET NOTIFY OFF
[2026-10-16 19:58:33] [INFO] SYS(2335, 0)
[2026-10-16 19:58:33] [INFO] 
[2026-10-16 19:58:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopagr', 'C:\4c\tasks\task640', 'OPERACIONAL'
[2026-10-16 19:58:33] [INFO] QUIT
[2026-10-16 19:58:33] [INFO] 
[2026-10-16 19:58:33] [INFO] === Fim do Wrapper.prg ===
[2026-10-16 19:58:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopagr",
  "timestamp": "20261016195833",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Sem conexao ao banco (gnConnHandle invalido)",
      "detalhes": ""
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKMARCASKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 7,
    "falhou": 2,
    "percentual": 78
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopagr.prg):
*==============================================================================
* Formsigopagr.prg - Dialogo de Selecao/Agrupamento de Itens (Borracharia)
* Equivale a: SIGOPAGR.SCX (Framework Fortyus)
* Herda de: FormBase
*
* Form OPERACIONAL - dialogo MODAL, FLAT (sem PageFrame, sem Page1/Page2):
* o SCX legado nao tem nenhum PageFrame nem container de cabecalho - os
* controles (ShpFigura, grdItens, cntBotoes, ImgJpg, apaga, SelTudo) sao
* todos filhos DIRETOS do form, igual ao legado (CLAUDE.md regra sobre
* NAO inventar Page1/Page2 quando o original nao tem).
*
* Aberto a partir de um form de movimentacao que ja mantem o cursor de
* itens (crTpmMvItn no legado, this_cCursorMovimento aqui) aberto na MESMA
* DataSession (DataSession = 1, compartilhada - igual ao legado). Este
* dialogo agrupa esse cursor por Produto+Tamanho (sigopagrBO.
* MontarItensAgrupados), deixa o usuario marcar/ajustar peso e valor por
* grupo e propaga de volta para o cursor de movimento ao confirmar.
*
* PILAR 1 (UX): Caption do legado e literalmente "Sele??o de Localiza??o"
* (Selecao de Localizacao) - incoerente com o proposito real do dialogo
* (selecionar/marcar ITENS de borracharia, nao localizacao). Transcrito
* LITERALMENTE: e defeito/residuo do legado (dialogo provavelmente clonado
* de outro), nao um erro de migracao - "corrigir" o texto violaria a
* fidelidade pixel-perfect ao original.
*
* Historico de fases:
*   Fase 1/2: sigopagrBO.prg (propriedades, CarregarDoCursor, ObterChavePrimaria,
*             MontarItensAgrupados, MarcarTodosItens, AtualizarItemMovimento,
*             RecalcularTotaisMovimento, BuscarImagemProdutoPorCodigo)
*   Fase 3:   Formsigopagr.prg - estrutura base (Init, InicializarForm, Destroy)
*   Fase 4:   Estrutura visual (todos filhos DIRETOS do form, sem Page1/Page2 -
*             este dialogo NAO tem PageFrame): shp_4c_ShpFigura (moldura),
*             grd_4c_Dados (7 colunas - Column3 com CheckBox chk_4c_Check1,
*             regra #18), obj_4c_CntBotoes (CommandGroup Confirmar/Cancelar),
*             img_4c_ImgJpg (imagem do produto) e os botoes standalone
*             cmd_4c_SelTudo/cmd_4c_Apaga. Column.ControlSource fica VAZIO
*             (CLAUDE.md regra #41 - cursor_4c_Itens ainda nao existe neste
*             ponto); o bind com o cursor e os handlers (toggle do checkbox,
*             AfterRowColChange, Confirmar/Cancelar/SelTudo/Apaga) ficam
*             para fase posterior.
*   Fase 5:   NO-OP proposital. O objetivo generico da fase ("Form - Campos
*             Principais - ConfigurarPaginaDados com metade dos campos") nao
*             se aplica a este form: o dump SIGOPAGR.SCX (layout.json) nao
*             tem NENHUM TextBox/Label solto fora da grade - os unicos
*             controles de entrada do legado sao as celulas (Text1) das
*             colunas 1/2/4/5/6/7 de grdItens, ja entregues na Fase 4. Nao ha
*             Page2/Dados para criar (regra "nao inventar campos que o
*             legado nao tem" + regra "nao criar stub/metodo vazio por
*             completude artificial").
*   Fase 6:   NO-OP proposital, pela mesma razao da Fase 5. O objetivo
*             generico da fase ("Form - Campos Restantes e Lookups -
*             BINDEVENT F4/F5 com FormBuscaAuxiliar") tambem nao se aplica:
*             o dump sigopagr_form_codigo_fonte.txt foi conferido PROCEDURE
*             a PROCEDURE e nao contem nenhum CreateObject('fwbuscaext'/
*             'fwBuscaSel'), nenhum sigacess(...) e nenhum KeyPress/Valid
*             testando F4(=115)/F5(=116) - os unicos Valid/When do dump sao
*             os das celulas da grade (Column1/2.When = Return .F. e
*             Column4/5/6.When condicionados a CrSigOpCdd.AltValPes, ja
*             contemplados na estrutura da Fase 4). A UNICA consulta SQL
*             Server do dialogo (SigCdPro, via sigopagrBO.
*             BuscarImagemProdutoPorCodigo) e um lookup READ-ONLY disparado
*             por navegacao na grade (equivalente a grdItens.
*             AfterRowColChange do legado), nao um picker F4/DblClick de
*             campo digitavel - NAO segue o padrao
*             BINDEVENT+AbrirLookupXxx(FormBuscaAuxiliar) desta fase; o
*             handler que a consome pertence a Fase 7 ("Form - Eventos"),
*             junto com o toggle do CheckBox da Column3 e os Click de
*             Confirmar/Cancelar/SelTudo/apaga. Criar um
*             BINDEVENT/AbrirLookupXxx fake so para preencher a fase
*             violaria a mesma regra da Fase 5 (nao inventar UI/fluxo que o
*             legado nao tem).
*   Fase 7:   Eventos principais. O objetivo generico desta fase
*             ("BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick") eh do template CRUD e NAO se aplica a este
*             dialogo FLAT de selecao (sem Incluir/Alterar/Visualizar/
*             Excluir - decisao ja anunciada no comentario da Fase 6). Os
*             eventos reais implementados aqui, via ConfigurarEventos()
*             (BINDEVENT) chamado do InicializarForm:
*               - MontarGrade(): bind do grid ao cursor_4c_Itens -
*                 equivalente ao PROCEDURE montagrade do legado
*                 (RecordSource + Column*.ControlSource), chamado ao fim do
*                 InicializarForm (guardado por gb_4c_ValidandoUI, como
*                 CarregarLista nos forms CRUD). Reaplica Width/
*                 Header1.Caption DEPOIS do ControlSource (RecordSource
*                 reseta os dois - CLAUDE.md regra #41/Problema 48).
*               - AtualizarImagemItemCorrente()/GradeAfterRowColChange():
*                 equivalente a grdItens.AfterRowColChange do legado -
*                 consulta sigopagrBO.BuscarImagemProdutoPorCodigo e exibe
*                 em img_4c_ImgJpg (padrao de decodificacao idem
*                 Formsigmvsbn.CarregarImagemProduto).
*               - ChkMarcasClick/MouseDown/MouseUp/KeyPress: toggle do
*                 CheckBox da Column3 (Marcas), replicando o NODEFAULT dos
*                 4 handlers do dump (Click/MouseDown suprimem o toggle
*                 nativo, MouseUp delega a KeyPress(13,0), KeyPress faz o
*                 REPLACE e repinta imagem+grid).
*               - BtnCancelarClick/BtnConfirmarClick: Buttons(1)/(2) do
*                 CommandGroup (btnSair/btnConfirmar do dump). Cancelar so
*                 fecha (ThisForm.Release); Confirmar faz o SCAN FOR
*                 Marcas = 1 propagando Pesos/Valor via BO.
*                 CarregarDoCursor+AtualizarItemMovimento, chama
*                 RecalcularTotaisMovimento() uma vez no final e so entao
*                 fecha - replica btnConfirmar.Click linha a linha.
*               - CmdSelTudoClick/CmdApagaClick: SelTudo/apaga do dump, via
*                 BO.MarcarTodosItens(1)/(0).
*   Fase 8:   Consolidacao final. O objetivo generico desta fase
*             (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/FormParaBO/
*             BOParaForm/HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo) eh do template CRUD e NAO se aplica a
*             este dialogo FLAT - mesmo motivo ja anunciado nas Fases 5/6/7:
*             nao ha Page1/Page2, nao ha modos INCLUIR/ALTERAR/VISUALIZAR,
*             nao ha campos soltos fora da grade para mapear em FormParaBO/
*             BOParaForm. Os equivalentes reais ja foram entregues na Fase 7
*             (BtnCancelarClick/BtnConfirmarClick no lugar de Salvar/
*             Encerrar; MontarGrade() no lugar de CarregarLista). Revisao
*             final conferiu os dois PROCEDUREs do dump ainda nao
*             mencionados nos comentarios:
*               - Load ("=fConfigGeral()") - NAO PORTADO de proposito, mesmo
*                 padrao documentado em FormSigMvExp/FormSigPrCar/etc.
*                 (ver projeto\app\utils\fconfiggeral.prg): fConfigGeral era
*                 funcao GLOBAL de inicializacao do legado, e o que ela fazia
*                 (SETs, paths, aliases globais) ja ocorre em config.prg/
*                 main.prg antes deste form ser instanciado - chama-la aqui
*                 reproduziria codigo morto (regra CLAUDE.md: "em codigo
*                 NOSSO nunca se chama fConfigGeral").
*               - validacao - NAO PORTADO: no dump, o PROCEDURE inteiro esta
*                 COMENTADO (prefixo "*!*" em toda linha) e referencia
*                 controles que este form nem tem (getBase/getNvl2/getNvl3/
*                 getNvl4, de um dialogo de localizacao). Residuo do mesmo
*                 "clonado de outro dialogo" ja registrado no comentario do
*                 Caption (linha ~19 deste arquivo) - codigo morto, nunca
*                 chamado por procedure nenhum do dump. Nao ha nada para
*                 transcrever.
*
* Parametros de Init (equivalentes ao legado LParameters pCnx, pEscolha):
*   par_cEscolha         - pEscolha: modo ('INSERIR'/'ALTERAR'/...), usado
*                           pelo When de SelTudo/Apaga (Enabled na criacao,
*                           ver ConfigurarBotoesAuxiliares)
*   par_cCursorMovimento - substitui pCnx/poDataMgr: nome do cursor de
*                          movimento JA ABERTO pelo form chamador na mesma
*                          DataSession (equivalente a crTpmMvItn, fixo no
*                          legado por ser DataSession=1 global). pCnx
*                          (objeto poDataMgr do legado, usado so para
*                          CursorQuery) nao tem equivalente aqui: a unica
*                          consulta SQL Server real do dialogo
*                          (BuscarImagemProdutoPorCodigo) usa gnConnHandle
*                          global, como o resto do projeto.
*
* this_cOrigem - equivalente a "pcorigem" do dump (RESERVED3), property
* vestigial do legado: declarada no SCX mas NUNCA lida nem gravada por
* nenhum metodo do dump (Init so recebe pCnx/pEscolha). Mantida aqui so
* por paridade de propriedade, sem uso funcional - igual ao tratamento de
* this_nCitens em sigopagrBO.prg.
*==============================================================================

DEFINE CLASS Formsigopagr AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPAGR)
    Width        = 1059
    Height       = 500
    AutoCenter   = .T.
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
    ControlBox   = .F.
    Closable     = .F.
    FontName     = "Verdana"
    FontSize     = 8
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    WindowType   = 1
    ShowWindow   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do form chamador (equivalentes a pEscolha/pCnx)
    this_cEscolha          = ""
    this_cCursorMovimento  = ""

    *-- Vestigial - ver cabecalho do arquivo (equivalente a "pcorigem" do dump)
    this_cOrigem = ""

    *--------------------------------------------------------------------------
    * Init - Armazena os parametros recebidos do form chamador, cria o
    * Business Object e dispara FormBase.Init() (que chama
    * THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEscolha, par_cCursorMovimento)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cEscolha = IIF(VARTYPE(par_cEscolha) = "C", ALLTRIM(par_cEscolha), "")

            THIS.this_cCursorMovimento = IIF(VARTYPE(par_cCursorMovimento) = "C" AND !EMPTY(par_cCursorMovimento), ;
                ALLTRIM(par_cCursorMovimento), "crTpmMvItn")

            THIS.this_oBusinessObject = CREATEOBJECT("sigopagrBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigopagrBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopagr.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopagr.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Fundo do form + estrutura visual completa (grade,
    * shape de moldura, imagem do produto, CommandGroup Confirmar/Cancelar e
    * os botoes standalone SelTudo/Apaga) - este form NAO tem PageFrame nem
    * container de cabecalho (o SCX legado tambem nao tem). Bind de dados
    * (cursor_4c_Itens) e handlers de clique ficam para fase posterior.
    * Chamado automaticamente por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Ordem IDENTICA ao dump legado (SECAO 1 - arvore de objetos):
            *-- ShpFigura, grdItens, cntBotoes, ImgJpg, apaga, SelTudo. Todos
            *-- filhos DIRETOS do form - sem PageFrame/Page (form FLAT).
            THIS.ConfigurarShapeFigura()
            THIS.ConfigurarGradeItens()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarImagemProduto()
            THIS.ConfigurarBotoesAuxiliares()
            THIS.ConfigurarEventos()

            *-- Bind do grid ao cursor de itens (equivalente a ThisForm.MontaGrade()
            *-- + Select crTpmMvItn/crItensBor do Init legado) - pulado em modo de
            *-- validacao de UI, onde this_cCursorMovimento nao vem aberto (padrao
            *-- gb_4c_ValidandoUI, igual a CarregarLista nos forms CRUD).
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.MontarGrade()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopagr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShapeFigura - Moldura ao redor da imagem do produto
    * (SIGOPAGR.ShpFigura do dump). So BackStyle/BorderColor - Shape NAO tem
    * ForeColor (CLAUDE.md regra #33, conferido em propriedades_baseclasses.txt).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShapeFigura()
        THIS.AddObject("shp_4c_ShpFigura", "Shape")
        WITH THIS.shp_4c_ShpFigura
            .Top         = 141
            .Left        = 795
            .Height      = 348
            .Width       = 253
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeItens - Grade de itens agrupados (SIGOPAGR.grdItens do
    * dump), filha DIRETA do form. ColumnCount, larguras, ColumnOrder,
    * InputMask e headers identicos ao SCX. Column*.ControlSource fica VAZIO
    * propositalmente - o cursor cursor_4c_Itens (equivalente a crItensBor)
    * ainda nao existe neste ponto do Init (CLAUDE.md regra #41); o bind real
    * (equivalente ao PROCEDURE montagrade do legado) fica para fase posterior,
    * depois de sigopagrBO.MontarItensAgrupados popular o cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeItens()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top           = 6
            .Left          = 1
            .Width         = 742
            .Height        = 483
            .ColumnCount   = 7
            .FontName      = "Verdana"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(192, 192, 192)
            .Visible       = .T.
        ENDWITH

        *-- Column1: Produto (crItensBor.Cpros) - ColumnOrder 2
        WITH loc_oGrid.Column1
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 2
            .ControlSource     = ""
            .Width             = 122
            .Movable           = .F.
            .Resizable         = .F.
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Produto"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.Alignment   = 3
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2: Descricao (crItensBor.Dpros) - ColumnOrder 3
        WITH loc_oGrid.Column2
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 3
            .ControlSource     = ""
            .Width             = 250
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3: Marcas (checkbox) - ColumnOrder 1 (1a visualmente).
        *-- AddObject + CurrentControl + Sparse = .F. (CLAUDE.md regra #18) -
        *-- sem isso o controle nunca aparece, a coluna so desenha o Text1.
        *-- chk_4c_Check1.Caption = "Check1" transcrito LITERALMENTE do dump
        *-- (PILAR 1) - a Column.Width = 17 recorta a caixa, o texto nao
        *-- aparece na pratica (irrelevante visualmente, igual ao legado).
        WITH loc_oGrid.Column3
            .FontName        = "Verdana"
            .FontSize        = 8
            .ColumnOrder     = 1
            .ControlSource   = ""
            .Width           = 17
            .Sparse          = .F.
            .Visible         = .T.
            .Header1.Caption = ""
            .AddObject("chk_4c_Check1", "CheckBox")
            .chk_4c_Check1.Top       = 22
            .chk_4c_Check1.Left      = 22
            .chk_4c_Check1.Height    = 17
            .chk_4c_Check1.Width     = 60
            .chk_4c_Check1.FontName  = "Verdana"
            .chk_4c_Check1.FontSize  = 8
            .chk_4c_Check1.Alignment = 0
            .chk_4c_Check1.Caption   = "Check1"
            .chk_4c_Check1.Visible   = .T.
            .CurrentControl = "chk_4c_Check1"
        ENDWITH

        *-- Column4: Quantidade (crItensBor.Qtds) - ColumnOrder 5, sempre
        *-- ReadOnly no dump (sem relacao com o When de CrSigOpCdd.AltValPes)
        WITH loc_oGrid.Column4
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 5
            .ControlSource     = ""
            .Width             = 90
            .Movable           = .T.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Quantidade"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5: Valor (crItensBor.Valor) - ColumnOrder 6, editavel
        *-- (dump: ReadOnly = .F.); InputMask "99999,999.99"
        WITH loc_oGrid.Column5
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 6
            .ControlSource     = ""
            .Width             = 95
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .InputMask         = "99999,999.99"
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Valor"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6: Peso (crItensBor.Pesos) - ColumnOrder 7, editavel (dump
        *-- nao declara ReadOnly - default .F., igual a Column5); mesmo
        *-- InputMask "99999,999.99"
        WITH loc_oGrid.Column6
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 7
            .ControlSource     = ""
            .Width             = 95
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .InputMask         = "99999,999.99"
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Peso"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7: Tamanho (crItensBor.CodTams) - ColumnOrder 4, sempre
        *-- ReadOnly no dump
        WITH loc_oGrid.Column7
            .FontName          = "Verdana"
            .FontSize          = 8
            .ColumnOrder       = 4
            .ControlSource     = ""
            .Width             = 44
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Alignment = 2
            .Header1.Caption   = "Tam."
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - CommandGroup Confirmar/Cancelar (SIGOPAGR.cntBotoes
    * do dump, ButtonCount = 2). Buttons(1) = Command1/btnSair ("Cancelar"),
    * Buttons(2) = Command2/btnConfirmar ("Confirmar") - indexacao numerica
    * (CLAUDE.md regra #34), NUNCA .Name em Pages/Columns/Buttons. Icones
    * confirmados em vbmp\ (gc_4c_CaminhoIcones), igual ao restante do
    * projeto - o legado aponta para Framework\imagens, mas esses dois jpg
    * sao os icones canonicos CRUD ja usados em centenas de forms.
    * CommandGroup NAO tem FontName (CLAUDE.md regra #33) - fonte so nos
    * Buttons(N) individuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
        WITH THIS.obj_4c_CntBotoes
            .Top           = 10
            .Left          = 874
            .Width         = 171
            .Height        = 110
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.

            WITH .Buttons(1)
                .Top          = 5
                .Left         = 86
                .Height       = 100
                .Width        = 80
                .FontName     = "Verdana"
                .FontSize     = 8
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel       = .T.
                .Caption      = "\<Cancelar"
                .MousePointer = 15
                .ToolTipText  = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor    = RGB(36, 84, 155)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top          = 5
                .Left         = 5
                .Height       = 100
                .Width        = 80
                .FontName     = "Verdana"
                .FontSize     = 8
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption      = "\<Confirmar"
                .MousePointer = 15
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .ForeColor    = RGB(36, 84, 155)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarImagemProduto - Imagem do produto corrente (SIGOPAGR.ImgJpg
    * do dump), filha DIRETA do form. Visible = .F. ao abrir - o legado so
    * exibe apos o STRTOFILE/decodificacao do .jpg feito em
    * grdItens.AfterRowColChange, que fica para fase posterior junto com o
    * bind da grade (usa sigopagrBO.BuscarImagemProdutoPorCodigo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarImagemProduto()
        THIS.AddObject("img_4c_ImgJpg", "Image")
        WITH THIS.img_4c_ImgJpg
            .Top     = 144
            .Left    = 798
            .Height  = 341
            .Width   = 247
            .Stretch = 2
            .Picture = ""
            .Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAuxiliares - Botoes standalone SelTudo/apaga do dump,
    * filhos DIRETOS do form. Icone-only (Caption = "") - .Enabled setado
    * AQUI, dentro do bloco de criacao (nao em runtime posterior), reflete
    * o PROCEDURE When do legado (INLIST(pcEscolha,'INSERIR','ALTERAR')) e
    * eh seguro porque this_cEscolha ja esta definido antes de InicializarForm
    * rodar (atribuido em Init() - CLAUDE.md sobre Enabled=.F. em runtime
    * apagar o icone so se aplica a mudanca POSTERIOR a criacao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAuxiliares()
        LOCAL loc_lHabilitado
        loc_lHabilitado = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        *-- SelTudo (legado SIGOPAGR.SelTudo): marca todos os itens da grade
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 202
            .Left        = 745
            .Height      = 40
            .Width       = 45
            .FontName    = "Verdana"
            .FontSize    = 8
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Selecionar"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .TabStop     = .F.
            .Enabled     = loc_lHabilitado
            .Visible     = .T.
        ENDWITH

        *-- apaga (legado SIGOPAGR.apaga): desmarca todos os itens da grade
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 243
            .Left        = 745
            .Height      = 40
            .Width       = 45
            .FontBold    = .F.
            .FontItalic  = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .TabStop     = .F.
            .Enabled     = loc_lHabilitado
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga (BINDEVENT) os handlers de clique/teclado aos
    * controles criados nas fases anteriores. Equivalente aos PROCEDUREs
    * Click/KeyPress/MouseDown/MouseUp do dump legado (grdItens.
    * AfterRowColChange, Column3.Check1, cntBotoes.btnSair/btnConfirmar,
    * apaga, SelTudo). Handlers PUBLIC, parametros do evento declarados
    * (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        BINDEVENT(THIS.grd_4c_Dados.Column3.chk_4c_Check1, "Click",     THIS, "ChkMarcasClick")
        BINDEVENT(THIS.grd_4c_Dados.Column3.chk_4c_Check1, "KeyPress",  THIS, "ChkMarcasKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column3.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column3.chk_4c_Check1, "MouseUp",   THIS, "ChkMarcasMouseUp")

        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")

        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "CmdApagaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarGrade - Agrupa o cursor de movimento (sigopagrBO.
    * MontarItensAgrupados) e liga o grid ao cursor resultante (cursor_4c_Itens).
    * Equivalente ao PROCEDURE montagrade do legado:
    *   With ThisForm.grdItens
    *       .RecordSource = [crItensBor]
    *       .column1.ControlSource = [crItensBor.Cpros]  (...)
    *       .Refresh()
    *   EndWith
    * RecordSource/ControlSource RESETAM Width e Header1.Caption das colunas
    * (CLAUDE.md regra #41/Problema 48) - por isso os dois sao reaplicados
    * DEPOIS do bind, na mesma ordem canonica (ControlSource -> Width ->
    * Header1.Caption). Column3 e CheckBox (regra #18): CurrentControl/
    * Sparse reafirmados por seguranca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarGrade()
        LOCAL loc_oGrid, loc_cCursorItens, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

            IF THIS.this_oBusinessObject.MontarItensAgrupados(THIS.this_cCursorMovimento)
                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = loc_cCursorItens

                loc_oGrid.Column1.ControlSource = loc_cCursorItens + ".Cpros"
                loc_oGrid.Column2.ControlSource = loc_cCursorItens + ".Dpros"
                loc_oGrid.Column3.ControlSource = loc_cCursorItens + ".Marcas"
                loc_oGrid.Column4.ControlSource = loc_cCursorItens + ".Qtds"
                loc_oGrid.Column5.ControlSource = loc_cCursorItens + ".Valor"
                loc_oGrid.Column6.ControlSource = loc_cCursorItens + ".Pesos"
                loc_oGrid.Column7.ControlSource = loc_cCursorItens + ".CodTams"

                loc_oGrid.Column1.Width = 122
                loc_oGrid.Column2.Width = 250
                loc_oGrid.Column3.Width = 17
                loc_oGrid.Column4.Width = 90
                loc_oGrid.Column5.Width = 95
                loc_oGrid.Column6.Width = 95
                loc_oGrid.Column7.Width = 44

                loc_oGrid.Column1.Header1.Caption = "Produto"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = ""
                loc_oGrid.Column4.Header1.Caption = "Quantidade"
                loc_oGrid.Column5.Header1.Caption = "Valor"
                loc_oGrid.Column6.Header1.Caption = "Peso"
                loc_oGrid.Column7.Header1.Caption = "Tam."

                loc_oGrid.Column3.Sparse         = .F.
                loc_oGrid.Column3.CurrentControl = "chk_4c_Check1"

                loc_oGrid.Refresh()

                THIS.AtualizarImagemItemCorrente()

                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Formsigopagr.MontarGrade")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopagr.MontarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarImagemItemCorrente - Consulta a imagem do produto do item
    * CORRENTE da grade (sigopagrBO.BuscarImagemProdutoPorCodigo) e exibe em
    * img_4c_ImgJpg. Equivalente ao corpo de grdItens.AfterRowColChange do
    * legado (CursorQuery('SigCdPro', ..., 'FigJpgs') + Copy Memo to arquivo).
    * Decodificacao idem Formsigmvsbn.CarregarImagemProduto (3 prefixos
    * data:image/... + STRCONV UNICO - decodificar duas vezes corrompe o
    * JPEG).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarImagemItemCorrente()
        LOCAL loc_cCursorItens, loc_cCpros, loc_cCursorProduto, loc_cFoto, loc_cArquivo

        THIS.img_4c_ImgJpg.Visible = .F.
        THIS.img_4c_ImgJpg.Picture = ""

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

        IF !USED(loc_cCursorItens) OR EOF(loc_cCursorItens)
            RETURN
        ENDIF

        loc_cCpros = TratarNulo(EVALUATE(loc_cCursorItens + ".Cpros"), "")

        IF !THIS.this_oBusinessObject.BuscarImagemProdutoPorCodigo(loc_cCpros)
            RETURN
        ENDIF

        loc_cCursorProduto = THIS.this_oBusinessObject.this_cCursorProduto

        IF USED(loc_cCursorProduto) AND !EOF(loc_cCursorProduto)
            loc_cFoto = TratarNulo(THIS.this_oBusinessObject.this_cFigJpgs, "")
            IF !EMPTY(loc_cFoto)
                loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
                loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
                loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
                loc_cFoto = STRCONV(loc_cFoto, 14)

                loc_cArquivo = SYS(2023) + "\Sigopagr.jpg"
                IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                    THIS.img_4c_ImgJpg.Picture = loc_cArquivo
                    THIS.img_4c_ImgJpg.Visible = .T.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Alvo do BINDEVENT em grd_4c_Dados.
    * "AfterRowColChange" (grid nativo - so alcancavel via BINDEVENT, regra
    * #46: sem filtro de coluna e o uso certo para recarregar o detalhe da
    * linha corrente, igual ao legado que tambem ignora nColIndex). PUBLIC e
    * com o parametro do evento declarado (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.AtualizarImagemItemCorrente()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcasClick / ChkMarcasMouseDown / ChkMarcasMouseUp / ChkMarcasKeyPress
    * Toggle do CheckBox da Column3 (Marcas) - replica os 4 handlers do dump
    * (SIGOPAGR.grdItens.Column3.Check1): Click e MouseDown suprimem o toggle
    * nativo (NODEFAULT), MouseUp delega a KeyPress(13,0) e KeyPress (Enter/
    * Espaco) faz o REPLACE + repinta imagem e grid. PUBLIC - alvo de
    * BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcasClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkMarcasKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursorItens

        IF INLIST(par_nKeyCode, 13, 32)
            loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

            IF USED(loc_cCursorItens) AND !EOF(loc_cCursorItens)
                SELECT (loc_cCursorItens)
                REPLACE Marcas WITH IIF(Marcas = 0, 1, 0)
            ENDIF

            THIS.AtualizarImagemItemCorrente()
            THIS.grd_4c_Dados.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Buttons(1) do CommandGroup (btnSair do dump).
    * Equivalente literal: ThisForm.Release. PUBLIC - alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Buttons(2) do CommandGroup (btnConfirmar do dump).
    * Replica btnConfirmar.Click linha a linha:
    *   Select crItensBor / Go top / Scan for Marcas = 1
    *       Update crTpmMvItn set Pesos=..., Units=... where Cpros=... And CodTams=...
    *   EndScan
    *   Update crTpmMvItn set Totas = (Units * Qtds)
    *   ThisForm.Release
    * O Update por linha marcada vira BO.CarregarDoCursor (le a linha
    * corrente para this_cCpros/this_nPesos/this_nValor) +
    * BO.AtualizarItemMovimento (propaga para o cursor de movimento); o
    * Update final (uma unica vez, fora do SCAN) vira
    * BO.RecalcularTotaisMovimento. Falha em qualquer etapa aborta o SCAN
    * (EXIT - seguro dentro de TRY) e mantem o dialogo aberto (CLAUDE.md
    * regra #9 - CATCH nunca silencioso; "falha nunca eh muda").
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cCursorItens, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        TRY
            loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

            IF USED(loc_cCursorItens)
                SELECT (loc_cCursorItens)
                GO TOP
                SCAN FOR Marcas = 1
                    IF !THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursorItens)
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF

                    IF !THIS.this_oBusinessObject.AtualizarItemMovimento()
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF

                    SELECT (loc_cCursorItens)
                ENDSCAN
            ENDIF

            IF loc_lProsseguir
                IF !THIS.this_oBusinessObject.RecalcularTotaisMovimento()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopagr.BtnConfirmarClick")
        ENDTRY

        IF loc_lProsseguir
            THIS.Release()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick / CmdApagaClick - SelTudo/apaga do dump. Equivalente a
    * "Replace All Marcas with 1/0 + Go Top + AfterRowColChange + Refresh",
    * via sigopagrBO.MarcarTodosItens(1)/(0) (que ja faz REPLACE ALL + GO TOP).
    * PUBLIC - alvo de BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.MarcarTodosItens(1)
            THIS.AtualizarImagemItemCorrente()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CmdApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.MarcarTodosItens(0)
            THIS.AtualizarImagemItemCorrente()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Equivalente ao PROCEDURE Release do legado:
    *   Use In crItensBor
    *   Use In csProdItn
    * Fecha so os cursores LOCAIS criados por este dialogo via o BO
    * (this_cCursorItens / this_cCursorProduto) - NUNCA this_cCursorMovimento,
    * que pertence ao form chamador e sobrevive ao fechamento deste dialogo.
    * DODEFAULT() por ULTIMO (CLAUDE.md - sem isso o menu principal encolhe
    * visualmente apos fechar este form modal).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF !EMPTY(THIS.this_oBusinessObject.this_cCursorItens) AND ;
               USED(THIS.this_oBusinessObject.this_cCursorItens)
                USE IN (THIS.this_oBusinessObject.this_cCursorItens)
            ENDIF

            IF !EMPTY(THIS.this_oBusinessObject.this_cCursorProduto) AND ;
               USED(THIS.this_oBusinessObject.this_cCursorProduto)
                USE IN (THIS.this_oBusinessObject.this_cCursorProduto)
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopagrBO.prg):
*------------------------------------------------------------------------------
* sigopagrBO - Business Object para Formsigopagr
* Dialogo operacional de selecao/agrupamento de itens de borracharia por
* produto + tamanho, usado para marcar itens e ajustar peso/valor antes de
* propagar os valores de volta ao cursor de movimento (crTpmMvItn).
* Migrado de: SIGOPAGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida: ele recebe do form
* chamador um cursor de movimento JA ABERTO (crTpmMvItn no legado,
* this_cCursorMovimento aqui - DataSession compartilhada, igual ao legado
* DataSession=1), agrupa esse cursor por Produto+Tamanho para exibir na
* grade, deixa o usuario marcar linhas e propaga Pesos/Valor de volta para
* o PROPRIO cursor de movimento (manipulacao de cursor local, nao escrita
* em SQL Server). A UNICA tabela SQL Server realmente consultada e
* SigCdPro, e so para LEITURA (imagem do produto exibida ao navegar na
* grade) - por isso nao ha INSERT/UPDATE real para sobrescrever: ver
* comentario em Inserir()/Atualizar().
*------------------------------------------------------------------------------
DEFINE CLASS sigopagrBO AS BusinessBase

    *-- Propriedades do item agrupado (csProdItn / crItensBor no legado)
    this_nCitens  = 0
    this_cCpros   = ""
    this_cDpros   = ""
    this_cCodTams = ""
    this_nMarcas  = 0
    this_nQtds    = 0
    this_nValor   = 0
    this_nPesos   = 0
    this_cFigJpgs = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao SigMvSbnBO/SIGMVCMVBO)
    this_cCursorMovimento = ""                  && equivalente a crTpmMvItn - recebido do form chamador
    this_cCursorItens     = "cursor_4c_Itens"   && grade de itens agrupados, equivalente a crItensBor
    this_cCursorProduto   = "cursor_4c_Produto" && dados/imagem do produto exibido, equivalente a crTPro

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "Cpros"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
    * cursor de itens agrupados (this_cCursorItens, equivalente a crItensBor
    * do legado) para as propriedades this_* do item selecionado na grade.
    *   par_cAliasCursor - alias a ler; se omitido usa this_cCursorItens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
            ELSE
                THIS.this_cCpros   = TratarNulo(Cpros, "")
                THIS.this_cDpros   = TratarNulo(Dpros, "")
                THIS.this_cCodTams = TratarNulo(CodTams, "")
                THIS.this_nMarcas  = TratarNulo(Marcas, 0)
                THIS.this_nQtds    = TratarNulo(Qtds, 0)
                THIS.this_nValor   = TratarNulo(Valor, 0)
                THIS.this_nPesos   = TratarNulo(Pesos, 0)

                *-- csProdItn.cItens eh cursor vestigial do legado (criado no
                *-- Init, nunca populado nem lido em metodo nenhum do dump) -
                *-- crItensBor nao tem essa coluna. Mapear defensivamente so
                *-- quando presente, para a property nao ficar sem sentido
                *-- caso algum dia venha de um cursor de origem diferente.
                IF TYPE("Citens") = "N"
                    THIS.this_nCitens = Citens
                ELSE
                    THIS.this_nCitens = 0
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do item agrupado corrente: Produto +
    * Tamanho (Cpros+CodTams), equivalente ao par usado pelo legado no
    * "Where Cpros = ... And CodTams = ..." do btnConfirmar.Click.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros) + "|" + ALLTRIM(THIS.this_cCodTams)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarItensAgrupados - Agrupa o cursor de movimento (this_cCursorMovimento,
    * equivalente a crTpmMvItn) por Produto+Tamanho+Descricao, somando a
    * quantidade e pegando o maior valor/peso de cada grupo - replica
    * LITERALMENTE o SELECT do Init() legado:
    *   Select 0 as Marcas, Cpros, Dpros, CodTams, Sum(Qtds) as Qtds,
    *          Max(Units) as Valor, Max(Pesos) as Pesos From crTpmMvItn
    *   Where Not Empty(Cpros) Group By Cpros, CodTams, Dpros
    *          Into Cursor crItensBor ReadWrite
    * O cursor de movimento ja chega ABERTO (recebido do form chamador,
    * DataSession compartilhada - o legado usa DataSession=1); esta
    * operacao e 100% local, sem SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE MontarItensAgrupados(par_cCursorMovimento)
        LOCAL loc_cCursorMov, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        loc_cCursorMov = IIF(VARTYPE(par_cCursorMovimento) = "C" AND !EMPTY(par_cCursorMovimento), ;
            par_cCursorMovimento, THIS.this_cCursorMovimento)

        IF EMPTY(loc_cCursorMov) OR !USED(loc_cCursorMov)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        THIS.this_cCursorMovimento = loc_cCursorMov

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            SELECT 0 AS Marcas, Cpros, Dpros, CodTams, ;
                   SUM(Qtds) AS Qtds, MAX(Units) AS Valor, MAX(Pesos) AS Pesos ;
                FROM (loc_cCursorMov) ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros, CodTams, Dpros ;
                INTO CURSOR (THIS.this_cCursorItens) READWRITE

            SELECT (THIS.this_cCursorItens)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosItens - Marca/desmarca TODAS as linhas da grade de itens
    * agrupados. Equivalente ao SelTudo.Click (par_nMarcas = 1) e ao
    * apaga.Click (par_nMarcas = 0) do legado:
    *   Replace All crItensBor.Marcas with 1   (ou 0)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosItens(par_nMarcas)
        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "Cursor " + THIS.this_cCursorItens + " n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH IIF(par_nMarcas = 1, 1, 0)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarItemMovimento - Propaga Pesos/Valor do item CORRENTE (carregado
    * via CarregarDoCursor) para TODAS as linhas do cursor de movimento com o
    * mesmo Produto+Tamanho - replica LITERALMENTE o trecho do
    * btnConfirmar.Click legado (dentro do "Scan for Marcas = 1"):
    *   Update crTpmMvItn set Pesos = crItensBor.Pesos, Units = crItensBor.Valor
    *          where Cpros = crItensBor.Cpros And CodTams = crItensBor.CodTams
    * Este metodo NAO filtra por Marcas - quem decide QUAIS itens propagar e
    * o chamador (o Form varre o cursor de itens e chama isto so para as
    * linhas marcadas, replicando o "Scan for Marcas = 1" do legado).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarItemMovimento()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorMovimento)
            REPLACE ALL Pesos WITH THIS.this_nPesos, ;
                    Units WITH THIS.this_nValor ;
                FOR Cpros = THIS.this_cCpros AND CodTams = THIS.this_cCodTams

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotaisMovimento - Recalcula Totas = Units * Qtds em TODAS as
    * linhas do cursor de movimento - replica LITERALMENTE o trecho final do
    * btnConfirmar.Click legado, executado UMA UNICA VEZ apos propagar todos
    * os itens marcados (fora do loop de AtualizarItemMovimento):
    *   Update crTpmMvItn set Totas = (crTpmMvItn.Units * crTpmMvItn.Qtds)
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularTotaisMovimento()
        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorMovimento)
        REPLACE ALL Totas WITH Units * Qtds
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarImagemProdutoPorCodigo - Consulta Cpros/FigJpgs/Dpros em SigCdPro
    * para o produto corrente, replicando a consulta feita em
    * grdItens.AfterRowColChange do legado:
    *   = ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *                                      crItensBor.Cpros,'FigJpgs')
    * So LEITURA - a decodificacao do base64 (STRCONV) e a gravacao do .jpg
    * temporario (STRTOFILE) ficam no Form, que e quem exibe a Image (padrao
    * do projeto - ver Formsigmvsbn.CarregarImagemProduto).
    *--------------------------------------------------------------------------
    FUNCTION BuscarImagemProdutoPorCodigo(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF EMPTY(par_cCpros)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCpros))

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
            ELSE
                SELECT (THIS.this_cCursorProduto)
                GO TOP

                THIS.this_cFigJpgs = TratarNulo(FigJpgs, "")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar (SQL Server) - SIGOPAGR nunca grava em SigCdPro,
    * a unica tabela SQL Server que toca (e so para LER a imagem do produto -
    * ver BuscarImagemProdutoPorCodigo acima). O codigo fonte legado inteiro
    * (sigopagr_form_codigo_fonte.txt) foi conferido e nao contem nenhum
    * Insert/Update/Delete/TableUpdate/Gather contra o SQL Server - a unica
    * gravacao que o dialogo faz e a propagacao de Pesos/Valor para o cursor
    * de movimento recebido do form chamador (manipulacao de CURSOR local,
    * ver AtualizarItemMovimento/RecalcularTotaisMovimento acima), e isso
    * nao e uma escrita no banco. Por isso nao ha INSERT/UPDATE real para
    * sobrescrever aqui, e RegistrarAuditoria() nunca e chamado por este BO -
    * o comportamento padrao herdado de BusinessBase (recusar a operacao)
    * ja e o correto para este par de metodos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

ENDDEFINE

