# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 4/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-27 22:19:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-27 22:19:01] [INFO] Config FPW: (nao fornecido)
[2026-09-27 22:19:01] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 22:19:01] [INFO] Timeout: 300 segundos
[2026-09-27 22:19:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oiotbj12.prg
[2026-09-27 22:19:01] [INFO] Conteudo do wrapper:
[2026-09-27 22:19:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrDsc', 'C:\4c\tasks\task601\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrDsc', 'C:\4c\tasks\task601\logs\06_testForm.log'
QUIT

[2026-09-27 22:19:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oiotbj12.prg
[2026-09-27 22:19:01] [INFO] VFP output esperado em: C:\4c\tasks\task601\vfp_output.txt
[2026-09-27 22:19:01] [INFO] Executando Visual FoxPro 9...
[2026-09-27 22:19:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oiotbj12.prg
[2026-09-27 22:19:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oiotbj12.prg
[2026-09-27 22:19:01] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrDsc
Inicio: 27/09/2026 22:19:02

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 27/09/2026 22:22:10
Duracao: 188 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-27 22:22:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-27 22:22:10] [INFO] VFP9 finalizado em 188.5009244 segundos
[2026-09-27 22:22:10] [INFO] Exit Code: 
[2026-09-27 22:22:10] [INFO] 
[2026-09-27 22:22:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-27 22:22:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oiotbj12.prg
[2026-09-27 22:22:10] [INFO] 
[2026-09-27 22:22:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-27 22:22:10] [INFO] * Auto-generated wrapper for parameters
[2026-09-27 22:22:10] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 22:22:10] [INFO] * Parameters: 'FormSigPrDsc', 'C:\4c\tasks\task601\logs\06_testForm.log'
[2026-09-27 22:22:10] [INFO] 
[2026-09-27 22:22:10] [INFO] * Anti-dialog protections for unattended execution
[2026-09-27 22:22:10] [INFO] SET SAFETY OFF
[2026-09-27 22:22:10] [INFO] SET RESOURCE OFF
[2026-09-27 22:22:10] [INFO] SET TALK OFF
[2026-09-27 22:22:10] [INFO] SET NOTIFY OFF
[2026-09-27 22:22:10] [INFO] SYS(2335, 0)
[2026-09-27 22:22:10] [INFO] 
[2026-09-27 22:22:10] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrDsc', 'C:\4c\tasks\task601\logs\06_testForm.log'
[2026-09-27 22:22:10] [INFO] QUIT
[2026-09-27 22:22:10] [INFO] 
[2026-09-27 22:22:10] [INFO] === Fim do Wrapper.prg ===
[2026-09-27 22:22:10] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg):
*==============================================================================
* FormSigPrDsc.prg - Montagem de Descricao de Produtos
* Origem: SIGPRDSC.SCX (task601)
* Herda de: FormBase
* Tipo: OPERACIONAL (form flat, sem PageFrame no legado - tudo pendurado
*       direto na Form). Consulta produtos que aguardam traducao (fila
*       SigPrPrt), monta a descricao (Grupo + Cor) via SigCdGrp/SigCdCor,
*       traduz via dicionario (SigCdDic) e grava de volta em SigCdPro
*       (DscCompras/ObsCompras/DPros).
*
* FASE 4/8 - Grid e Botoes: alem da estrutura base (Fase 3), acrescenta o
* cursor local (cursor_4c_Produtos), a grade (grd_4c_Dados) e os 3 botoes de
* acao (cmd_4c_BtnSelecionar/cmd_4c_BtnAtualizar/cmd_4c_BtnSair). Atualizar e
* Sair ja estao funcionais (handlers renomeados na Fase 8 para BtnGravarClick
* e BtnCancelarClick); Selecionar so recebe o Click quando os campos de filtro
* getCProsI/getCProsF/getCGrus entrarem no form, numa fase seguinte do
* pipeline (Campos).
*
* FASE 5/8 - Campos Principais (Parte 1): acrescenta a primeira metade dos
* campos de filtro do legado (Say3/getCProsI e Say1/getCProsF - a faixa
* "Produtos de : ___ ate ___"), mapeados para lbl_4c_ProdutosDe/
* txt_4c_CProsI e lbl_4c_Ate/txt_4c_CProsF. Sao apenas os controles
* (Left/Top/Width identicos ao SCX legado) - o campo Grupo (Say2/getCGrus)
* e o BINDEVENT de KeyPress/lookup de todos os tres entram nas fases
* seguintes do pipeline (Campos Parte 2 / Eventos).
*
* FASE 6/8 - Campos Restantes e Lookups: acrescenta o ultimo campo de
* filtro do legado (Say2/getCGrus - "Grupo de Produto :"), mapeado para
* lbl_4c_Grupo/txt_4c_CGrus, e liga os TRES lookups (fwbuscaext no legado)
* via BINDEVENT KeyPress (Enter/Tab/F4) + DblClick.
*
* Os pickers ficam em AbrirLookupProduto() (SigCdPro) e AbrirLookupGrupo()
* (SigCdGrp), pela API MANUAL do FormBuscaAuxiliar (Pattern A: cursor
* populado no caller + mAddColuna + Show). NAO se usa o helper
* AbrirLookupCanonico do FormBase porque o picker de produto do legado tem
* TRES colunas (CPros/DPros/CGrus) e o helper so expoe duas (Cods/Descs);
* e NAO se usa o CREATEOBJECT de 2+ argumentos ("Pattern B"), que a propria
* CLAUDE.md marca como defeituoso. Cada um reproduz o contrato do legado
* (If Not plAchouRegistro): com match EXATO de um registro o picker nao eh
* exibido, e a atribuicao do valor fica DENTRO da guarda de selecao
* (regra #37 - o legado atribuia fora dela e corrompia o campo no cancelar).
*
* Replica tambem os dois efeitos do PROCEDURE Valid legado: ao resolver um
* produto em getCProsI/getCProsF, copia o valor para o outro campo da faixa
* se estiver vazio e limpa getCGrus (e, no getCGrus, limpa a faixa toda) -
* o legado filtra por faixa de produto OU por grupo, nunca os dois. A outra
* metade dessa exclusividade sao os PROCEDURE When dos tres campos, aqui em
* AtualizarExclusividadeFiltros() (When = .F. -> Enabled = .F.).
*
* FASE 7/8 - Eventos Principais: liga o botao Selecionar (BtnSelecionarClick +
* Processamento(), equivalentes ao PROCEDURE Click do btnSelecionar e ao
* PROCEDURE processamento do legado) e acrescenta em InicializarForm() o
* carregamento do dicionario de traducao (cursor_4c_Dicionario, equivalente a
* crSigCdDic do PROCEDURE Init legado). Este form OPERACIONAL nao tem botoes
* de CRUD (Incluir/Alterar/Visualizar/Excluir) - o legado (SIGPRDSC.SCX) tem
* apenas Selecionar/Atualizar/Sair, e a paridade funcional exigida pelo
* PILAR 1 e com ESSES tres, nao com um CRUD que o form original nunca teve.
*
* FASE 8/8 - Eventos Auxiliares e Consolidacao Final. SIGPRDSC.SCX tem TRES
* botoes (Selecionar / Atualizar / Encerrar), nenhum CRUD e nenhum PageFrame -
* nao ha Page1/Page2 nem modo INCLUIR/ALTERAR/VISUALIZAR a reproduzir. Os
* metodos desta fase foram entregues mapeando cada nome canonico ao que a tela
* REALMENTE faz, sem inventar botao nenhum (PILAR 1) e sem metodo vazio:
*
*   BtnGravarClick      handler do botao "Atualizar" (legado btnAtualizar,
*                       Click = ThisForm.Gravacao -> Update SigCdPro +
*                       Delete SigPrPrt + Commit). Nomeado pela ACAO, nao pelo
*                       rotulo: o objeto e a Caption continuam "Atualizar".
*   BtnCancelarClick    handler do botao "Encerrar" (legado btnSair, que
*                       declara Cancel = .T. - eh o botao de cancelar do form,
*                       ESC e clique no mesmo caminho).
*   BtnSelecionarClick  o "Buscar" desta tela (Fase 7), agora passando os
*                       filtros pelo par FormParaBO / BOParaForm.
*   FormParaBO          os tres filtros da tela -> BO (PROTECTED: o hook eh
*   BOParaForm          PROTECTED em FormBase e VFP9 nao alarga escopo).
*                       BOParaForm exibe o espelhamento da faixa feito por
*                       SigPrDscBO.NormalizarFiltros() e reaplica os When.
*   CarregarLista       Go Top no cursor + Grid.Refresh(), agora tambem no fim
*                       de Processamento() e de BtnGravarClick - popular o
*                       cursor nao repinta a grade sozinho (CLAUDE.md #21).
*   AjustarBotoesPorModo  funil UNICO do Enabled do botao Atualizar, nos
*                       quatro pontos em que o legado o liga/desliga (ver o
*                       comentario do metodo). Sem o funil, o Enabled = .F.
*                       ficava espalhado em quatro lugares - o defeito da
*                       CLAUDE.md #40.
*
* Ficaram DE FORA, por nao terem semantica nesta tela: BtnBuscarClick e
* BtnSalvarClick (seriam segundo nome para Selecionar e Atualizar);
* BtnIncluirClick/BtnAlterarClick/BtnExcluirClick e AlternarPagina (nao ha
* CRUD nem paginas); HabilitarCampos (o legado nao habilita/desabilita campo
* por modo - o que ele tem eh a exclusividade faixa-x-grupo dos PROCEDURE
* When, que esta em AtualizarExclusividadeFiltros); LimparCampos (nao existe
* limpeza geral - os Valid limpam SUBCONJUNTOS de filtro, ja implementados em
* ValidarCProsI/ValidarCProsF/ValidarCGrus). Cria-los vazios ou como apelido
* de metodo existente seria stub disfarcado.
*
* No BO, a gravacao segue linha-a-linha: BtnGravarClick faz o SCAN de
* cursor_4c_Produtos chamando EditarRegistro + CarregarDoCursor + Salvar por
* produto - a mesma topologia N-linhas do PROCEDURE gravacao legado (Scan
* While llOks), e o motivo de FormParaBO cuidar dos filtros e nao das colunas
* da grade (que o legado deixa ReadOnly). SigPrDscBO ganhou TemFiltro() e
* NormalizarFiltros() (criterio da guarda de filtro vazio e espelhamento da
* faixa, transcritos do Click do btnSelecionar) e a chamada a fGravarLog()
* (wrapper no-op, utils\fgravarlog.prg) no ramo em que o Delete SigPrPrt
* falha, reproduzindo a linha "=fGravarLog([T], Upper(ThisForm.Name), Usuar,
* [Falha na Conexao (Traducao)])" do PROCEDURE gravacao original que faltava.
*==============================================================================

DEFINE CLASS FormSigPrDsc AS FormBase

    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 2
    Caption      = ""

    *-- Guarda de reentrancia dos lookups: Show() de form modal chamado
    *-- de dentro de um handler pode disparar o handler outra vez e
    *-- empilhar um segundo picker.
    this_lEmLookup = .F.

    *-- .T. somente entre o fim de um Processamento() bem-sucedido e a
    *-- gravacao (ou o inicio de uma nova selecao). Junto com "a lista tem
    *-- linha" eh o que AjustarBotoesPorModo() usa para decidir o Enabled do
    *-- botao Atualizar - ver o comentario daquele metodo.
    this_lListaPronta = .F.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual
    * base do form (cabecalho). Chamado automaticamente por FormBase.Init().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrDscBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                *-- crSigCdDic do PROCEDURE Init legado: dicionario de traducao
                *-- (Portugues->Ingles), carregado 1x na abertura do form e
                *-- usado depois em Processamento(). No legado, falha aqui
                *-- eh fatal (MessageBox + Return .f., form nao termina de
                *-- abrir) - reproduzido abortando InicializarForm(). Pulado
                *-- em gb_4c_ValidandoUI (sem conexao SQL real - padrao
                *-- FormCor/FORMCOR_LICOES_APRENDIDAS.md Problema 4).
                loc_lSucesso = .T.

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF USED("cursor_4c_Dicionario")
                        USE IN cursor_4c_Dicionario
                    ENDIF

                    loc_cSQL = "SELECT expressao, traducao FROM SigCdDic " + ;
                               "WHERE idioma = " + EscaparSQL(PADR("INGLES", 10)) + " " + ;
                               "ORDER BY LEN(expressao) DESC, expressao"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario")

                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (crSigCdDic)")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                    THIS.ConfigurarPageFrame()

                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * SIGPRDSC.SCX nao declara PageFrame algum (raiz "form" generica, tudo
    * pendurado direto na Form) - nao ha Page1/Page2 a reproduzir, sob pena
    * de inventar estrutura que o legado nao tem (PILAR 1/PILAR 3).
    * Nesta fase (Estrutura Base) so o cabecalho e montado; ConfigurarGrid,
    * ConfigurarCampos e ConfigurarBotoes serao acrescentados aqui pelas
    * fases seguintes do pipeline (Grid+Botoes / Campos / Eventos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria o container escuro superior com os labels
    * de titulo, equivalente ao cntSombra/lblSombra/lblTitulo do legado
    * (SIGPRDSC.cntSombra: Top=0, Left=0, Width=800, Height=80, BackColor
    * RGB(100,100,100)).
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
            .Width         = loc_oCab.Width - 20
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
            .AutoSize  = .F.
            .Width     = loc_oCab.Width - 20
            .Height    = 46
            .Top       = 17
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255,255,255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria o cursor local de produtos traduzidos (equivalente
    * ao "Create Cursor crProdutos" do PROCEDURE Load do legado, que roda antes
    * do Init) e a grade que o exibe (Grade do legado: RecordSource="crProdutos",
    * ColumnCount=3, colunas Codigo/Portugues/Traduzido - Grade.Text1.ControlSource
    * "csContas.CprosAnt"/"csContas.CprosNov" do dump SAO artefato de outra
    * grade copiada no SCX - csContas nao existe neste form nem tem relacao com
    * crProdutos, por isso NAO sao transcritos aqui).
    *
    * O cursor comeca vazio - quem o povoa eh o botao Selecionar (equivalente
    * ao PROCEDURE processamento do legado), acrescentado numa fase seguinte
    * do pipeline junto com os campos de filtro getCProsI/getCProsF/getCGrus.
    * A grade fica SEMPRE ReadOnly, como o legado (.Grade.ReadOnly = .t. no
    * Init - nunca alterado depois em lugar nenhum do codigo original).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Produtos")
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (CPros C(14), Portugues C(254), ;
                Traduzido C(254), DscCompras M, ObsCompras M)
            SET NULL OFF
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 164
            .Left              = 15
            .Width             = 769
            .Height            = 343
            .ColumnCount       = 3
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 17
            .RowHeight         = 17
            .ScrollBars        = 2
            .RecordSource      = "cursor_4c_Produtos"
            .ReadOnly          = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width         = 108
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.CPros"
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oGrid.Column1.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .Width         = 290
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.Portugues"
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Portugu" + CHR(234) + "s"
        ENDWITH
        WITH loc_oGrid.Column2.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .Width         = 339
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.Traduzido"
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Traduzido"
        ENDWITH
        WITH loc_oGrid.Column3.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria os 3 botoes de acao do form (todos filhos diretos
    * da Form no legado, sem CommandGroup): btnSelecionar/btnAtualizar/btnSair
    * mapeados para cmd_4c_BtnSelecionar/cmd_4c_BtnAtualizar/cmd_4c_BtnSair
    * (mapeamento.json). O Commandgroup3 do legado (ButtonCount=0, BorderStyle=0,
    * BackStyle=0) nao desenha nada em runtime - eh um retangulo de guia deixado
    * no Form Designer sem nenhum botao dentro - por isso nao tem equivalente
    * aqui (nada a reproduzir: o legado tambem nao mostra nada nesse ponto).
    *
    * cmd_4c_BtnSelecionar (equivalente ao PROCEDURE processamento do legado)
    * tem o Click ligado a BtnSelecionarClick/Processamento() (ver mais abaixo),
    * ja que os campos de filtro getCProsI/getCProsF/getCGrus foram acrescentados
    * na Fase 5/6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_BtnSelecionar", "CommandButton")
        WITH THIS.cmd_4c_BtnSelecionar
            .Top             = 116
            .Left            = 744
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "a_arrow6.bmp"
            .DisabledPicture = gc_4c_CaminhoIcones + "a_arrow6.bmp"
            .ToolTipText     = "Selecionar"
            .Themes          = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnSelecionar, "Click", THIS, "BtnSelecionarClick")

        THIS.AddObject("cmd_4c_BtnAtualizar", "CommandButton")
        WITH THIS.cmd_4c_BtnAtualizar
            .Top        = 3
            .Left       = 650
            .Width      = 75
            .Height     = 75
            .Caption    = "\<Atualizar"
            .Picture    = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .FontName   = "Comic Sans MS"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 8
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .DisabledPicture  = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .Enabled    = .F.
        ENDWITH
        *-- Handler nomeado pela ACAO, nao pelo objeto legado: o Click do
        *-- btnAtualizar chama ThisForm.Gravacao, cujo corpo eh o
        *-- Update SigCdPro + Delete SigPrPrt + Commit. Ou seja, "Atualizar"
        *-- eh o botao de GRAVAR desta tela. O objeto e a Caption continuam
        *-- "Atualizar" (PILAR 1 - o usuario ve o mesmo botao de antes); so o
        *-- nome interno do metodo descreve o que ele faz (PILAR 3).
        BINDEVENT(THIS.cmd_4c_BtnAtualizar, "Click", THIS, "BtnGravarClick")

        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top        = 3
            .Left       = 725
            .Width      = 75
            .Height     = 75
            .Caption    = "Encerrar"
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .FontName   = "Comic Sans MS"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 8
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        *-- btnSair eh o botao Cancel do legado (Cancel = .T. no dump), logo
        *-- ESC e o clique caem no MESMO handler. Por isso o metodo se chama
        *-- BtnCancelarClick - eh o cancelamento da tela -, enquanto o objeto
        *-- e a Caption continuam "Encerrar" (PILAR 1 + CLAUDE.md #10).
        BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnCancelarClick")

        *-- Estado inicial do botao de gravar pelo MESMO funil que todas as
        *-- transicoes seguintes usam (ver AjustarBotoesPorModo). O legado faz
        *-- isso no PROCEDURE Init (.btnAtualizar.Enabled = .f.); aqui o
        *-- cursor_4c_Produtos ja existe (criado em ConfigurarGrid, que roda
        *-- antes deste metodo) e esta vazio, entao o funil chega ao mesmo .F.
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria a faixa de filtro do legado (Say3/getCProsI,
    * Say1/getCProsF e Say2/getCGrus - "Produtos de : ___ ate ___  Grupo
    * de Produto : ___"), controles diretos da Form (sem PageFrame), com
    * Left/Top/Width identicos ao dump do SCX.
    *
    * Say3/Say1/Say2 sao classe "say" pura no dump (nao declaram Width nem
    * Alignment) - AutoSize = .T. + Alignment = 0, sem inventar caixa (regra
    * #23). Format = "K" do legado equivale a SelectOnEntry = .T. em VFP9
    * (substitui o texto ao entrar no campo, nao restringe o que pode ser
    * digitado - por isso NAO e o Format = "M" da regra #24).
    *
    * FASE 6/8: acrescenta lbl_4c_Grupo/txt_4c_CGrus (Say2/getCGrus) e liga
    * os 3 lookups via BINDEVENT (ver ValidarCProsI/ValidarCProsF/
    * ValidarCGrus mais abaixo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_ProdutosDe", "Label")
        WITH THIS.lbl_4c_ProdutosDe
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Left      = 155
            .Top       = 138
            .Caption   = "Produtos de :"
        ENDWITH

        THIS.AddObject("txt_4c_CProsI", "TextBox")
        WITH THIS.txt_4c_CProsI
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 233
            .Top           = 135
            .Width         = 108
            .MaxLength     = 14
            .SelectOnEntry = .T.
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Ate", "Label")
        WITH THIS.lbl_4c_Ate
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Left      = 345
            .Top       = 138
            .Caption   = "at" + CHR(233)
        ENDWITH

        THIS.AddObject("txt_4c_CProsF", "TextBox")
        WITH THIS.txt_4c_CProsF
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 370
            .Top           = 135
            .Width         = 108
            .MaxLength     = 14
            .SelectOnEntry = .T.
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Left      = 505
            .Top       = 138
            .Caption   = "Grupo de Produto :"
        ENDWITH

        THIS.AddObject("txt_4c_CGrus", "TextBox")
        WITH THIS.txt_4c_CGrus
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 614
            .Top           = 135
            .Width         = 31
            .MaxLength     = 3
            .SelectOnEntry = .T.
            .Value         = ""
        ENDWITH

        *-- Lookups (fwbuscaext no legado) - Enter(13)/Tab(9)/F4(115) e
        *-- duplo-clique disparam o mesmo picker que o Valid do legado abria
        *-- ao sair do campo.
        BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "CProsIKeyPress")
        BINDEVENT(THIS.txt_4c_CProsI, "DblClick", THIS, "CProsIDblClick")

        BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "CProsFKeyPress")
        BINDEVENT(THIS.txt_4c_CProsF, "DblClick", THIS, "CProsFDblClick")

        BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "CGrusKeyPress")
        BINDEVENT(THIS.txt_4c_CGrus, "DblClick", THIS, "CGrusDblClick")

        *-- Exclusividade faixa-de-produto X grupo (PROCEDURE When do legado)
        THIS.AtualizarExclusividadeFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * CProsIKeyPress/CProsIDblClick - disparam o lookup de getCProsI em
    * Enter(13)/Tab(9)/F4(115) ou duplo-clique (regra: BINDEVENT exige
    * metodo PUBLIC - #3; BINDEVENT em "Valid" nao dispara em TextBox, por
    * isso o Valid do legado eh reproduzido no KeyPress).
    *--------------------------------------------------------------------------
    PROCEDURE CProsIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarCProsI()
    ENDPROC

    PROCEDURE CProsIDblClick()
        THIS.ValidarCProsI()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCProsI - equivalente ao PROCEDURE Valid de getCProsI. Abre o
    * lookup de produto e, resolvido o codigo, replica o efeito colateral do
    * legado: se getCProsF estiver vazio recebe o mesmo codigo e getCGrus eh
    * limpo (o legado filtra por FAIXA DE PRODUTO ou por GRUPO, nunca pelos
    * dois).
    *
    * DESVIO DELIBERADO do legado: la o "This.Value = crListaRemota.CPros"
    * roda FORA de qualquer guarda de selecao, entao cancelar o picker
    * sobrescrevia o campo com a linha em que o cursor por acaso estava e
    * propagava esse valor. Aqui a atribuicao e a propagacao ficam dentro da
    * guarda de selecao (regra #37): cancelar preserva o que o usuario
    * digitou e nao contamina os outros filtros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCProsI()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
            IF THIS.AbrirLookupProduto(THIS.txt_4c_CProsI)
                *-- legado: If Not Empty(This.Value) And Empty(getCProsF.Value)
                IF !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND ;
                   EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
                    THIS.txt_4c_CProsF.Value = THIS.txt_4c_CProsI.Value
                    THIS.txt_4c_CProsF.Refresh()
                    THIS.txt_4c_CGrus.Value = ""
                    THIS.txt_4c_CGrus.Refresh()
                ENDIF
            ENDIF
        ENDIF

        THIS.AtualizarExclusividadeFiltros()
        THIS.txt_4c_CProsI.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CProsFKeyPress/CProsFDblClick - espelho de CProsIKeyPress/DblClick
    * para getCProsF.
    *--------------------------------------------------------------------------
    PROCEDURE CProsFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarCProsF()
    ENDPROC

    PROCEDURE CProsFDblClick()
        THIS.ValidarCProsF()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCProsF - equivalente ao PROCEDURE Valid de getCProsF: mesma
    * tabela/colunas de ValidarCProsI; se getCProsI estiver vazio recebe o
    * codigo e getCGrus eh limpo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCProsF()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
            IF THIS.AbrirLookupProduto(THIS.txt_4c_CProsF)
                *-- legado: If Not Empty(This.Value) And Empty(getCProsI.Value)
                IF !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value)) AND ;
                   EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
                    THIS.txt_4c_CProsI.Value = THIS.txt_4c_CProsF.Value
                    THIS.txt_4c_CProsI.Refresh()
                    THIS.txt_4c_CGrus.Value = ""
                    THIS.txt_4c_CGrus.Refresh()
                ENDIF
            ENDIF
        ENDIF

        THIS.AtualizarExclusividadeFiltros()
        THIS.txt_4c_CProsF.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CGrusKeyPress/CGrusDblClick - disparam o lookup de getCGrus em
    * Enter(13)/Tab(9)/F4(115) ou duplo-clique.
    *--------------------------------------------------------------------------
    PROCEDURE CGrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarCGrus()
    ENDPROC

    PROCEDURE CGrusDblClick()
        THIS.ValidarCGrus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCGrus - equivalente ao PROCEDURE Valid de getCGrus. Resolvido o
    * grupo, limpa a faixa de produto inteira (getCProsI e getCProsF), como
    * o legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCGrus()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
            *-- legado: If Not Empty(This.Value) -> limpa a faixa inteira
            IF THIS.AbrirLookupGrupo(THIS.txt_4c_CGrus) AND ;
               !EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
                THIS.txt_4c_CProsI.Value = ""
                THIS.txt_4c_CProsI.Refresh()
                THIS.txt_4c_CProsF.Value = ""
                THIS.txt_4c_CProsF.Refresh()
            ENDIF
        ENDIF

        THIS.AtualizarExclusividadeFiltros()
        THIS.txt_4c_CGrus.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupProduto - picker de produto, equivalente ao
    *   CreateObject([fwbuscaext], ThisForm.poDataMgr.pnIdConn, [SigCdPro],
    *                [crListaRemota], [CPros], This.Value, [Selecao], 1000)
    * dos PROCEDURE Valid de getCProsI/getCProsF.
    *
    * Usa a API MANUAL do FormBuscaAuxiliar (Pattern A: cursor populado aqui
    * + mAddColuna + Show) e NAO o helper AbrirLookupCanonico do FormBase,
    * porque o legado declara TRES colunas no picker (CPros/DPros/CGrus) e o
    * helper so expoe duas (Cods/Descs). Tambem nao usa o CREATEOBJECT de
    * 2+ argumentos ("Pattern B"), que a CLAUDE.md marca como defeituoso.
    *
    * Contrato do legado (If Not loLista.plAchouRegistro): com match EXATO de
    * UM registro o picker NAO eh exibido - o codigo se resolve direto.
    * Devolve .T. quando o campo recebeu um codigo valido de SigCdPro.
    *
    * Colunas conferidas em docs/schema.sql: SigCdPro.cpros char(14),
    * dpros char(65), cgrus char(3).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProduto(par_oTxt)
        LOCAL loc_lOk, loc_cValor, loc_cTitulo, loc_cSQL, loc_nRes, loc_oBusca, loc_oErro
        loc_lOk = .F.

        IF VARTYPE(par_oTxt) != "O" OR THIS.this_lEmLookup
            RETURN .F.
        ENDIF

        THIS.this_lEmLookup = .T.
        loc_cValor  = ALLTRIM(par_oTxt.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        TRY
            IF USED("cursor_4c_BuscaPro")
                USE IN SELECT("cursor_4c_BuscaPro")
            ENDIF

            *-- 1) match EXATO (o que o Init do fwbuscaext legado fazia antes
            *--    de decidir se abria o picker)
            loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
                       "WHERE cpros = " + EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")

            IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 1
                SELECT cursor_4c_BuscaPro
                GO TOP
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
                loc_lOk = .T.
            ELSE
                *-- 2) busca por PREFIXO em codigo OU descricao
                IF USED("cursor_4c_BuscaPro")
                    USE IN SELECT("cursor_4c_BuscaPro")
                ENDIF
                loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro " + ;
                           "WHERE (cpros LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR dpros LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
                           "ORDER BY cpros"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")

                *-- 3) fallback SHOW-ALL: prefixo sem match abre a lista toda,
                *--    em vez de um picker vazio
                IF loc_nRes > 0 AND USED("cursor_4c_BuscaPro") AND RECCOUNT("cursor_4c_BuscaPro") = 0
                    USE IN SELECT("cursor_4c_BuscaPro")
                    loc_cSQL = "SELECT cpros, dpros, cgrus FROM SigCdPro ORDER BY cpros"
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaPro")
                ENDIF

                IF loc_nRes < 0
                    MsgErro("Erro ao consultar produtos." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                ELSE
                    IF !USED("cursor_4c_BuscaPro") OR RECCOUNT("cursor_4c_BuscaPro") = 0
                        MsgAviso("Nenhum produto cadastrado.", loc_cTitulo)
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaPro"
                            loc_oBusca.this_cCampoCodigo    = "cpros"
                            loc_oBusca.this_cCampoDescricao = "dpros"
                            loc_oBusca.this_cTitulo         = loc_cTitulo
                            IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
                                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                            ENDIF

                            *-- as TRES colunas do legado, na ordem do mAddColuna
                            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.mAddColuna("cgrus", "", "Grupo")

                            loc_oBusca.Show()

                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                                SELECT cursor_4c_BuscaPro
                                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaPro.cpros)
                                loc_lOk = .T.
                            ENDIF

                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaPro")
                USE IN SELECT("cursor_4c_BuscaPro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupProduto")
            IF USED("cursor_4c_BuscaPro")
                USE IN SELECT("cursor_4c_BuscaPro")
            ENDIF
        ENDTRY

        *-- fora do ENDTRY para liberar a guarda tambem quando o CATCH dispara
        THIS.this_lEmLookup = .F.

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - picker de grupo de produto, equivalente ao
    *   CreateObject([fwbuscaext], ..., [SigCdGrp], [crListaRemota], [CGrus],
    *                This.Value, [Selecao], 1000)
    * do PROCEDURE Valid de getCGrus, com as DUAS colunas que o legado
    * declara (mAddColuna CGrus/DGrus).
    *
    * Colunas conferidas em docs/schema.sql: SigCdGrp.cgrus char(3),
    * dgrus char(20).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo(par_oTxt)
        LOCAL loc_lOk, loc_cValor, loc_cTitulo, loc_cSQL, loc_nRes, loc_oBusca, loc_oErro
        loc_lOk = .F.

        IF VARTYPE(par_oTxt) != "O" OR THIS.this_lEmLookup
            RETURN .F.
        ENDIF

        THIS.this_lEmLookup = .T.
        loc_cValor  = ALLTRIM(par_oTxt.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        TRY
            IF USED("cursor_4c_BuscaGru")
                USE IN SELECT("cursor_4c_BuscaGru")
            ENDIF

            *-- 1) match EXATO
            loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
                       "WHERE cgrus = " + EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")

            IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 1
                SELECT cursor_4c_BuscaGru
                GO TOP
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
                loc_lOk = .T.
            ELSE
                *-- 2) busca por PREFIXO em codigo OU descricao
                IF USED("cursor_4c_BuscaGru")
                    USE IN SELECT("cursor_4c_BuscaGru")
                ENDIF
                loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp " + ;
                           "WHERE (cgrus LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR dgrus LIKE " + EscaparSQL(loc_cValor + "%") + ") " + ;
                           "ORDER BY cgrus"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")

                *-- 3) fallback SHOW-ALL
                IF loc_nRes > 0 AND USED("cursor_4c_BuscaGru") AND RECCOUNT("cursor_4c_BuscaGru") = 0
                    USE IN SELECT("cursor_4c_BuscaGru")
                    loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus"
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGru")
                ENDIF

                IF loc_nRes < 0
                    MsgErro("Erro ao consultar grupos de produto." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF !USED("cursor_4c_BuscaGru") OR RECCOUNT("cursor_4c_BuscaGru") = 0
                        MsgAviso("Nenhum grupo de produto cadastrado.", loc_cTitulo)
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino  = "cursor_4c_BuscaGru"
                            loc_oBusca.this_cCampoCodigo    = "cgrus"
                            loc_oBusca.this_cCampoDescricao = "dgrus"
                            loc_oBusca.this_cTitulo         = loc_cTitulo
                            IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
                                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                            ENDIF

                            loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")

                            loc_oBusca.Show()

                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                                SELECT cursor_4c_BuscaGru
                                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
                                loc_lOk = .T.
                            ENDIF

                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGru")
                USE IN SELECT("cursor_4c_BuscaGru")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
            IF USED("cursor_4c_BuscaGru")
                USE IN SELECT("cursor_4c_BuscaGru")
            ENDIF
        ENDTRY

        THIS.this_lEmLookup = .F.

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarExclusividadeFiltros - reproduz os PROCEDURE When do legado:
    *   getCProsI.When -> Return Empty(ThisForm.getCGrus.Value)
    *   getCProsF.When -> Return Empty(ThisForm.getCGrus.Value)
    *   getCGrus.When  -> Return Empty(ThisForm.getCProsI.Value) And
    *                            Empty(ThisForm.getCProsF.Value)
    *
    * Ou seja: o legado filtra por FAIXA DE PRODUTO **ou** por GRUPO, nunca
    * pelos dois - o campo do outro criterio fica inalcancavel enquanto o
    * primeiro estiver preenchido (a mesma exclusividade que o
    * PROCEDURE processamento assume ao montar o Where com CGrus OU
    * CPros BetWeen). Essas condicoes SAO a regra, nao enfeite (#21b).
    *
    * When = .F. impede o controle de receber foco; em controle criado por
    * AddObject nao existe subclasse onde declarar o When, e o equivalente
    * funcional eh Enabled = .F., que produz o mesmo bloqueio de foco.
    * Nao ha risco de travamento: o campo que JA esta preenchido continua
    * habilitado, entao sempre da para limpa-lo e voltar ao outro criterio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarExclusividadeFiltros()
        LOCAL loc_lTemGrupo, loc_lTemFaixa

        loc_lTemGrupo = !EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
        loc_lTemFaixa = !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) OR ;
                        !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))

        THIS.txt_4c_CProsI.Enabled = !loc_lTemGrupo
        THIS.txt_4c_CProsF.Enabled = !loc_lTemGrupo
        THIS.txt_4c_CGrus.Enabled  = !loc_lTemFaixa
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - reposiciona o cursor local e repinta a grade (equivalente
    * ao ThisForm.Grade.Refresh do legado, chamado no PROCEDURE processamento a
    * cada linha inserida em crProdutos). A populacao real do cursor_4c_Produtos
    * entra junto com o botao Selecionar, numa fase seguinte do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            GO TOP
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelecionarClick - equivalente ao PROCEDURE Click do btnSelecionar
    * legado. Desabilita o botao de gravar, valida que ao menos um filtro foi
    * informado, completa a faixa de produto quando so uma ponta foi digitada
    * (o legado espelha o inicio no fim e vice-versa) e dispara
    * THIS.Processamento().
    *
    * O espelhamento da faixa eh REGRA, nao formatacao de tela: por isso vive
    * em SigPrDscBO.NormalizarFiltros() e chega aqui pelo par
    * FormParaBO -> BOParaForm. O .Refresh() de cada TextBox que o legado faz
    * junto (getCProsF.Refresh) esta dentro de BOParaForm.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelecionarClick()
        *-- legado: ThisForm.btnAtualizar.Enabled = .f. (primeira linha do Click)
        *-- A selecao anterior deixa de valer JA AQUI, antes de validar os
        *-- filtros - com filtro vazio o legado sai do Click com a grade ainda
        *-- mostrando a lista antiga mas o Atualizar desligado. Quem religa eh
        *-- o fim de Processamento(), pelo mesmo funil.
        THIS.this_lListaPronta = .F.
        THIS.AjustarBotoesPorModo()

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.TemFiltro()
            MsgAviso("Nenhum Filtro Foi Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.txt_4c_CProsI.SetFocus()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.NormalizarFiltros()
        THIS.BOParaForm()

        THIS.Processamento()
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - equivalente ao PROCEDURE processamento do legado. Monta
    * a lista de produtos candidatos (por faixa CPros OU por CGrus - nunca os
    * dois, mesma exclusividade de AtualizarExclusividadeFiltros), e para cada
    * um consulta Grupo (SigCdGrp) e Cor (SigCdCor) via LEFT JOIN a partir de
    * SigCdPro.
    *
    * DESVIO NENHUM - TRANSCRICAO LITERAL (regra #17): no metodo original a
    * variavel lcDes eh inicializada com [] logo no comeco do laco e NUNCA
    * reatribuida antes do "If Not Empty(lcDes)" - lcIni/lnGrD (calculados a
    * partir do LEFT JOIN) nao alimentam lcDes em lugar nenhum do codigo
    * fonte extraido (SigPrDsc_form_codigo_fonte.txt, metodo completo, sem
    * truncamento). Ou seja, o bloco de traducao e o "Insert Into crProdutos"
    * sao CODIGO MORTO no proprio legado - o processamento sempre roda (monta
    * cursor_4c_PrdTraduz, consulta Grupo/Cor de cada produto) mas nunca insere
    * linha em cursor_4c_Produtos, e por isso cmd_4c_BtnAtualizar nunca fica
    * habilitado por este caminho. Mantido identico ao legado (PILAR 1) -
    * "reescrever" essa lacuna inventaria regra de negocio que nao existe em
    * lugar nenhum do sistema original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Processamento()
        LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cSQL, loc_nResultado, loc_oProg
        LOCAL loc_cPro, loc_cDes, loc_cIni, loc_nGrD, loc_cIng, loc_oErro

        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            ZAP
        ENDIF

        *-- Filtros vem do BO (postos la por FormParaBO e ja espelhados por
        *-- NormalizarFiltros), nao relidos da tela. O PADR eh aplicado SO
        *-- aqui, na montagem do SQL, exatamente como o legado
        *-- (lcPrI = Padr(getCProsI.Value, 14) / lcGru = Padr(getCGrus.Value, 3));
        *-- as properties do BO ficam sem padding para que BOParaForm nao
        *-- devolva espacos a direita para dentro dos TextBox.
        loc_cPrI = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsI), 14)
        loc_cPrF = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsF), 14)
        loc_cGru = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCGrus), 3)

        IF !EMPTY(loc_cGru)
            loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cgrus = " + EscaparSQL(loc_cGru) + ;
                       " ORDER BY cpros"
        ELSE
            loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros BETWEEN " + EscaparSQL(loc_cPrI) + ;
                       " AND " + EscaparSQL(loc_cPrF) + " ORDER BY cpros"
        ENDIF

        IF USED("cursor_4c_PrdTraduz")
            USE IN SELECT("cursor_4c_PrdTraduz")
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz")
        IF loc_nResultado < 0
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                "Falha na Conex" + CHR(227) + "o (crPrdTraduz)")
            RETURN
        ENDIF

        IF !USED("cursor_4c_PrdTraduz") OR RECCOUNT("cursor_4c_PrdTraduz") = 0
            RETURN
        ENDIF

        TRY
            loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_PrdTraduz"))
            loc_oProg.Show()

            SELECT cursor_4c_PrdTraduz
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.cpros)

                loc_oProg.Update("Produto : " + loc_cPro, .T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    IF USED("cursor_4c_LocalPro")
                        USE IN SELECT("cursor_4c_LocalPro")
                    ENDIF

                    loc_cSQL = "SELECT a.cpros, a.cgrus, a.codcors, b.dgrus, b.mercs, b.montagrds, c.descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.cgrus = a.cgrus " + ;
                               "LEFT JOIN SigCdCor c ON c.cods = a.codcors " + ;
                               "WHERE a.cpros = " + EscaparSQL(loc_cPro)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                        EXIT
                    ENDIF

                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_cIni = ALLTRIM(ALLTRIM(TratarNulo(dgrus, "")) + " " + ALLTRIM(TratarNulo(descs, "")))
                        loc_nGrD = TratarNulo(montagrds, 0)
                    ENDIF

                    *-- legado: lcDes permanece vazio ate aqui (ver comentario
                    *-- do cabecalho do metodo) - bloco transcrito tal como
                    *-- esta no fonte original, mesmo nunca executando.
                    IF !EMPTY(loc_cDes)
                        loc_cIng = loc_cDes

                        IF USED("cursor_4c_Dicionario")
                            SELECT cursor_4c_Dicionario
                            GO TOP
                            SCAN
                                loc_cIng = STRTRAN(loc_cIng, ALLTRIM(cursor_4c_Dicionario.expressao), ;
                                    ALLTRIM(cursor_4c_Dicionario.traducao))
                            ENDSCAN
                        ENDIF

                        loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                        loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                        INSERT INTO cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                            VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete(.T.)
            loc_oProg.Release()

            IF USED("cursor_4c_LocalPro")
                USE IN SELECT("cursor_4c_LocalPro")
            ENDIF
            IF USED("cursor_4c_PrdTraduz")
                USE IN SELECT("cursor_4c_PrdTraduz")
            ENDIF

            *-- legado: Select crProdutos / Go Top / If Not Eof() ->
            *-- btnAtualizar.Enabled = .t. Mesmo criterio, pelo funil: a
            *-- selecao terminou, entao o que decide eh haver linha na lista.
            THIS.this_lListaPronta = .T.
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Processamento")
            IF USED("cursor_4c_LocalPro")
                USE IN SELECT("cursor_4c_LocalPro")
            ENDIF
            IF USED("cursor_4c_PrdTraduz")
                USE IN SELECT("cursor_4c_PrdTraduz")
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGravarClick - handler do botao "Atualizar" (legado btnAtualizar, cujo
    * Click eh "ThisForm.Gravacao"). Nomeado pela ACAO que executa - gravar -,
    * nao pelo rotulo do botao: o objeto e a Caption continuam "Atualizar"
    * (PILAR 1), o nome do metodo descreve o efeito (PILAR 3).
    *
    * Grava as descricoes traduzidas de volta em SigCdPro e
    * remove cada produto da fila SigPrPrt (equivalente ao PROCEDURE gravacao
    * do legado). Percorre cursor_4c_Produtos linha a linha, delegando a
    * gravacao de cada uma ao Business Object (EditarRegistro+CarregarDoCursor+
    * Salvar) - a UPDATE/DELETE/COMMIT/ROLLBACK real esta em
    * SigPrDscBO.Atualizar(). Interrompe no primeiro erro, como o legado
    * (Scan While llOks).
    *--------------------------------------------------------------------------
    PROCEDURE BtnGravarClick()
        LOCAL loc_lOk, loc_oProg, loc_cPro, loc_nTotal, loc_oErro

        IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
            RETURN
        ENDIF

        loc_lOk = .T.
        loc_nTotal = RECCOUNT("cursor_4c_Produtos")

        TRY
            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show()

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOk
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.Update("Produto : " + loc_cPro, .T.)

                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")

                IF !THIS.this_oBusinessObject.Salvar()
                    loc_lOk = .F.
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o produto " + ;
                            loc_cPro + ".", "Erro")
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete(.T.)
            loc_oProg.Release()

            IF loc_lOk
                MsgInfo("Foram Gravados " + ALLTRIM(STR(loc_nTotal, 10)) + " Produtos!!!", ;
                    "Processamento Conclu" + CHR(237) + "do!!!")

                *-- Gravou: os produtos sairam da fila SigPrPrt (Delete no BO),
                *-- logo nao ha mais nada a gravar nesta lista. A GRADE CONTINUA
                *-- exibindo as linhas gravadas - o legado tambem nao limpa
                *-- crProdutos aqui, so desliga o botao, e essa confirmacao
                *-- visual faz parte da UX (PILAR 1).
                THIS.this_lListaPronta = .F.
            ENDIF

            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnGravarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - encerra o form. Equivalente ao PROCEDURE Click do
    * btnSair legado (corpo: "ThisForm.Release").
    *
    * O nome vem da propria declaracao do legado: btnSair tem Cancel = .T. no
    * dump, ou seja eh o botao de CANCELAR do form - ESC e o clique executam o
    * mesmo caminho, e nao ha um segundo botao de fechar de que este precise se
    * distinguir. O objeto (cmd_4c_BtnSair) e a Caption ("Encerrar") seguem
    * identicos ao legado e ao canonico da CLAUDE.md #10.
    *
    * PUBLIC de proposito: alem do BINDEVENT (que ignora metodo PROTECTED),
    * o harness TesteAutomatico.prg chama THIS.oForm.BtnCancelarClick() de
    * fora da classe, e PEMSTATUS(...,5) nao enxerga escopo (CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - funil UNICO do estado do botao Atualizar (o unico
    * botao desta tela que muda de estado; Selecionar e Encerrar valem sempre).
    *
    * Regra: Atualizar so fica habilitado quando existe selecao PRONTA e ela
    * tem ao menos uma linha. Os dois termos sao necessarios - por isso o par
    * this_lListaPronta + RECCOUNT, e nao so a contagem do cursor:
    *
    *   Init / ConfigurarBotoes    lista vazia e nao pronta  -> .F.
    *     (legado: PROCEDURE Init, .btnAtualizar.Enabled = .f.)
    *   inicio de BtnSelecionarClick  nao pronta             -> .F.
    *     (legado: 1a linha do Click do btnSelecionar; a grade AINDA exibe a
    *      selecao anterior, entao contar linhas devolveria .T. e inverteria
    *      o comportamento do legado)
    *   fim de Processamento()     pronta, conta as linhas   -> .T. se houver
    *     (legado: Select crProdutos / Go Top / If Not Eof())
    *   apos gravar com sucesso    deixa de estar pronta     -> .F.
    *     (legado: nada a regravar; a grade CONTINUA com as linhas gravadas)
    *
    * Concentrar isso aqui eh o que impede o defeito da CLAUDE.md #40 - estado
    * desligado num caminho e nunca religado no caminho de volta.
    *
    * Nao ha modo INCLUIR/ALTERAR/VISUALIZAR nesta tela (o legado SIGPRDSC.SCX
    * nao tem CRUD nem Page1/Page2): o parametro de modo do template CRUD nao
    * existe aqui, e this_cModoAtual nao eh consultado. O nome canonico eh
    * mantido porque eh o que o harness TesteAutomatico.prg procura.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemLinha

        loc_lTemLinha = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0

        IF PEMSTATUS(THIS, "cmd_4c_BtnAtualizar", 5)
            THIS.cmd_4c_BtnAtualizar.Enabled = THIS.this_lListaPronta AND loc_lTemLinha
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - leva os tres filtros da tela para o Business Object
    * (getCProsI/getCProsF/getCGrus do legado). Sao os unicos dados que o
    * usuario digita nesta tela: as colunas da grade nao sao editaveis (o
    * legado faz .Grade.ReadOnly = .t. no Init) e cada linha a gravar vai para
    * o BO por CarregarDoCursor(), dentro do SCAN de BtnGravarClick.
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook como PROTECTED e
    * VFP9 nao permite alargar o escopo na subclasse.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
            .this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
            .this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - devolve os filtros do Business Object para a tela, com o
    * .Refresh() de cada campo. Eh o que exibe o espelhamento da faixa feito
    * por SigPrDscBO.NormalizarFiltros(), reproduzindo as linhas
    * "getCProsF.Value = getCProsI.Value / getCProsF.Refresh" do Click do
    * btnSelecionar legado.
    *
    * Depois de mexer nos campos, reaplica AtualizarExclusividadeFiltros():
    * sao os PROCEDURE When do legado (faixa e grupo se excluem) e o valor
    * novo pode ter mudado qual dos dois criterios esta em uso.
    *
    * PROTECTED obrigatoriamente (hook PROTECTED em FormBase - ver FormParaBO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_CProsI.Value = THIS.this_oBusinessObject.this_cCProsI
        THIS.txt_4c_CProsF.Value = THIS.this_oBusinessObject.this_cCProsF
        THIS.txt_4c_CGrus.Value  = THIS.this_oBusinessObject.this_cCGrus

        THIS.txt_4c_CProsI.Refresh()
        THIS.txt_4c_CProsF.Refresh()
        THIS.txt_4c_CGrus.Refresh()

        THIS.AtualizarExclusividadeFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por padrao). Este form
    * nao tem containers flutuantes a filtrar.
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
    * Destroy - libera o cursor local de produtos traduzidos (equivalente ao
    * crProdutos do legado, populado pelas fases seguintes) antes de
    * delegar ao FormBase.Destroy() (restaura menu / libera BO).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_Dicionario")
            USE IN cursor_4c_Dicionario
        ENDIF
        IF USED("cursor_4c_PrdTraduz")
            USE IN cursor_4c_PrdTraduz
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*====================================================================
* SigPrDscBO.prg
*
* Business Object para SigPrDsc (Montagem de Descricao de Produtos)
* Tabela principal atualizada: SigCdPro (DscCompras, ObsCompras, DPros)
* Tabelas auxiliares: SigCdGrp, SigCdCor, SigCdDic, SigPrPrt
*
* Form OPERACIONAL: processa produtos sem traducao (fila em SigPrPrt),
* monta a descricao concatenando Grupo + Cor, traduz via dicionario
* (SigCdDic) e grava DscCompras/ObsCompras/DPros de volta em SigCdPro.
*====================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

	*-- Tabela principal e chave (para auditoria/BusinessBase)
	this_cTabela = "SigCdPro"
	this_cCampoChave = "CPros"

	*-- Filtro de faixa de produtos (telas getCProsI / getCProsF)
	this_cCProsI = ""
	this_cCProsF = ""

	*-- Filtro de grupo de produtos (tela getCGrus)
	this_cCGrus = ""

	*-- Produto corrente sendo processado/gravado (crProdutos.CPros)
	this_cCPros = ""

	*-- Descricao em portugues montada (Grupo + Cor) - crProdutos.Portugues
	this_cPortugues = ""

	*-- Descricao traduzida (ingles) - crProdutos.Traduzido
	this_cTraduzido = ""

	*-- Campos gravados de volta em SigCdPro.DscCompras / ObsCompras
	this_cDscCompras = ""
	this_cObsCompras = ""

	*-- Descricao final formatada gravada em SigCdPro.DPros
	this_cDPros = ""

	*-- Total de produtos processados/gravados (para mensagens de resumo)
	this_nTotalProcessados = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "CPros"

		THIS.this_cCProsI = ""
		THIS.this_cCProsF = ""
		THIS.this_cCGrus = ""
		THIS.this_cCPros = ""
		THIS.this_cPortugues = ""
		THIS.this_cTraduzido = ""
		THIS.this_cDscCompras = ""
		THIS.this_cObsCompras = ""
		THIS.this_cDPros = ""
		THIS.this_nTotalProcessados = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega as propriedades do produto corrente a
	* partir de uma linha do cursor crProdutos (estrutura do legado:
	* CPros c(14), Portugues c(254), Traduzido c(254), DscCompras m,
	* ObsCompras m). THIS.this_cDPros e recalculado aqui pela MESMA
	* formula do PROCEDURE gravacao legado (Padr(Alltrim(Portugues),40)),
	* pois DPros nao existe como coluna no cursor - e sempre derivado.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCPros      = ALLTRIM(TratarNulo(CPros, ""))
			THIS.this_cPortugues  = TratarNulo(Portugues, "")
			THIS.this_cTraduzido  = TratarNulo(Traduzido, "")
			THIS.this_cDscCompras = TratarNulo(DscCompras, "")
			THIS.this_cObsCompras = TratarNulo(ObsCompras, "")
			THIS.this_cDPros      = PADR(ALLTRIM(THIS.this_cPortugues), 40)

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* TemFiltro - .T. quando ao menos um dos tres filtros da tela foi
	* informado. Eh o criterio da primeira guarda do PROCEDURE Click do
	* btnSelecionar legado:
	*
	*   If Empty(getCProsI.Value) And Empty(getCProsF.Value) And
	*      Empty(getCGrus.Value) ... Return .f.
	*
	* So o CRITERIO vem para ca - a mensagem e o SetFocus continuam no
	* Form, que eh onde moram (sao UI).
	*====================================================================
	FUNCTION TemFiltro()
		RETURN !EMPTY(ALLTRIM(THIS.this_cCProsI)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCProsF)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCGrus))
	ENDFUNC

	*====================================================================
	* NormalizarFiltros - completa a faixa de produto quando o usuario
	* digitou apenas uma das pontas. TRANSCRICAO LITERAL do PROCEDURE
	* Click do btnSelecionar legado (regra #17 - criterio do legado nao
	* se reescreve):
	*
	*   If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
	*       getCProsF.Value = getCProsI.Value
	*   If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
	*       getCProsI.Value = getCProsF.Value
	*
	* NAO mexe no grupo: a exclusividade faixa-x-grupo eh feita pelos
	* PROCEDURE Valid dos campos (Form.ValidarCProsI/ValidarCProsF/
	* ValidarCGrus), NAO pelo botao Selecionar - o legado tambem nao a
	* aplica aqui, e aplicar limparia filtro que o usuario informou.
	*
	* Guarda os valores SEM padding de proposito: quem monta o SQL aplica
	* o Padr(...,14) / Padr(...,3) do legado. Padded aqui, o BOParaForm
	* devolveria espacos a direita para dentro dos TextBox da tela.
	*====================================================================
	PROCEDURE NormalizarFiltros()
		THIS.this_cCProsI = ALLTRIM(THIS.this_cCProsI)
		THIS.this_cCProsF = ALLTRIM(THIS.this_cCProsF)
		THIS.this_cCGrus  = ALLTRIM(THIS.this_cCGrus)

		*-- legado: If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
		IF !EMPTY(THIS.this_cCProsI) AND EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsF = THIS.this_cCProsI
		ENDIF

		*-- legado: If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
		IF EMPTY(THIS.this_cCProsI) AND !EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsI = THIS.this_cCProsF
		ENDIF
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave primaria do produto em processamento
	* (usada por RegistrarAuditoria).
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCPros)
	ENDFUNC

	*====================================================================
	* Inserir - Este form OPERACIONAL nunca cria produto novo em SigCdPro
	* (o cadastro de produtos e feito em outra tela; aqui so se traduz e
	* regrava a descricao de um produto JA existente, apontado pela fila
	* SigPrPrt). "Gravar" e sempre um UPDATE - o proprio PROCEDURE
	* gravacao do legado roda o mesmo par Update/Delete em qualquer
	* contexto -, entao Inserir delega para Atualizar.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		RETURN THIS.Atualizar()
	ENDPROC

	*====================================================================
	* Atualizar - Grava a descricao (portugues/traduzido) de volta em
	* SigCdPro e remove o produto da fila SigPrPrt. Espelha
	* literalmente o PROCEDURE gravacao do legado:
	*
	*   Update SigCdPro Set DscCompras = ..., ObsCompras = ..., DPros = ...
	*                   Where CPros = ...
	*   Delete From SigPrPrt Where CPros = ...
	*
	* tratando as duas instrucoes como uma unidade: se o Delete falhar
	* apos o Update ter sido aplicado, o legado reverte tudo (RollBack).
	* Conexao nasce em modo transacional manual (Transactions=2, memoria
	* feedback_conexao_sql_transactions_2_sem_commit) - commit/rollback
	* explicitos, no mesmo padrao de SigPrChrBO.ExecutarExclusao.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		IF EMPTY(ALLTRIM(THIS.this_cCPros))
			THIS.this_cMensagemErro = "Produto sem c" + CHR(243) + "digo (CPros) para grava" + CHR(231) + CHR(227) + "o."
			RETURN .F.
		ENDIF

		THIS.this_cDPros = PADR(ALLTRIM(THIS.this_cPortugues), 40)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET DscCompras = <<EscaparSQL(THIS.this_cDscCompras)>>,
					ObsCompras = <<EscaparSQL(THIS.this_cObsCompras)>>,
					DPros = <<EscaparSQL(THIS.this_cDPros)>>
				WHERE CPros = <<EscaparSQL(THIS.this_cCPros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(THIS.this_cCPros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					SQLCOMMIT(gnConnHandle)
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					*-- legado: =fGravarLog([T], Upper(ThisForm.Name), Usuar,
					*-- [Falha na Conexao (Traducao)]) - wrapper no-op
					*-- (utils\fgravarlog.prg, Erro163_Aba1); retorno descartado
					*-- igual ao original, so para reproduzir a chamada.
					=fGravarLog("T", "SIGPRDSC", gc_4c_UsuarioLogado, ;
						"Falha na Conex" + CHR(227) + "o (Traducao)")
					*-- this_cMensagemErro fica preenchida; quem EXIBE eh
					*-- BusinessBase.Salvar()->ExibirFalha() - MsgErro aqui
					*-- duplicaria a mensagem (regra: falha nunca eh muda, mas
					*-- tambem nunca eh mostrada duas vezes)
					THIS.this_cMensagemErro = "Falha ao remover o produto " + ALLTRIM(THIS.this_cCPros) + ;
						" da fila de tradu" + CHR(231) + CHR(227) + "o (SigPrPrt):" + CHR(13) + CapturarErroSQL()
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
				THIS.this_cMensagemErro = "Falha ao gravar a descri" + CHR(231) + CHR(227) + "o do produto " + ;
					ALLTRIM(THIS.this_cCPros) + " em SigCdPro:" + CHR(13) + CapturarErroSQL()
			ENDIF

		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

