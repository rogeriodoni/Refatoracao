# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-24 18:48:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-24 18:48:12] [INFO] Config FPW: (nao fornecido)
[2026-10-24 18:48:12] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-24 18:48:12] [INFO] Timeout: 300 segundos
[2026-10-24 18:48:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_b2myirge.prg
[2026-10-24 18:48:12] [INFO] Conteudo do wrapper:
[2026-10-24 18:48:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigopcgp', 'C:\4c\tasks\task693\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcgp', 'C:\4c\tasks\task693\logs\06_testForm.log'
QUIT

[2026-10-24 18:48:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_b2myirge.prg
[2026-10-24 18:48:13] [INFO] VFP output esperado em: C:\4c\tasks\task693\vfp_output.txt
[2026-10-24 18:48:13] [INFO] Executando Visual FoxPro 9...
[2026-10-24 18:48:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_b2myirge.prg
[2026-10-24 18:48:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_b2myirge.prg
[2026-10-24 18:48:13] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigopcgp
Inicio: 24/10/2026 18:48:14

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 24/10/2026 18:52:18
Duracao: 244 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-24 18:52:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-24 18:52:18] [INFO] VFP9 finalizado em 245.5828813 segundos
[2026-10-24 18:52:19] [INFO] Exit Code: 
[2026-10-24 18:52:19] [INFO] 
[2026-10-24 18:52:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-24 18:52:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_b2myirge.prg
[2026-10-24 18:52:19] [INFO] 
[2026-10-24 18:52:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-24 18:52:19] [INFO] * Auto-generated wrapper for parameters
[2026-10-24 18:52:19] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-24 18:52:20] [INFO] * Parameters: 'Formsigopcgp', 'C:\4c\tasks\task693\logs\06_testForm.log'
[2026-10-24 18:52:20] [INFO] 
[2026-10-24 18:52:20] [INFO] * Anti-dialog protections for unattended execution
[2026-10-24 18:52:20] [INFO] SET SAFETY OFF
[2026-10-24 18:52:20] [INFO] SET RESOURCE OFF
[2026-10-24 18:52:20] [INFO] SET TALK OFF
[2026-10-24 18:52:20] [INFO] SET NOTIFY OFF
[2026-10-24 18:52:20] [INFO] SYS(2335, 0)
[2026-10-24 18:52:20] [INFO] 
[2026-10-24 18:52:21] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcgp', 'C:\4c\tasks\task693\logs\06_testForm.log'
[2026-10-24 18:52:21] [INFO] QUIT
[2026-10-24 18:52:21] [INFO] 
[2026-10-24 18:52:21] [INFO] === Fim do Wrapper.prg ===
[2026-10-24 18:52:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgp.prg):
*============================================================
* Formsigopcgp.prg
* Pesquisa Global de Produtos (SIGOPCGP)
* Tipo: OPERACIONAL - layout customizado com grids e containers
* Fase 3/8: Estrutura Base
*============================================================
DEFINE CLASS Formsigopcgp AS FormBase

  Height      = 614
  Width       = 1000
  Caption     = "Pesquisa Global de Produtos"
  AutoCenter  = .T.
  BorderStyle = 2
  TitleBar    = 0
  DataSession = 2
  ShowWindow = 1
  WindowType = 1
  KeyPreview  = .T.

  *-- Propriedades de estado
  this_oBusinessObject    = .NULL.
  this_cModoAtual         = "CONSULTA"
  this_cMensagemErro      = ""
  this_lPrimeira          = .T.
  this_lConsultaExecutada = .F.
  this_lAlteraPreco       = .F.
  this_cPrompt            = ""
  this_nTpcalcp           = 0
  this_nEmpresa           = 0
  this_cGrupo             = ""
  this_cSubGrupo          = ""
  this_cFornecedor        = ""
  this_cOrigem            = "T"
  this_nTipoCalculo       = 0
  this_lExibeInativos     = .F.
  this_lExibeCompostos    = .F.
  this_cCodPesq           = ""
  this_cDesPesq           = ""
  this_nPageAtual         = 1

  *------------------------------------------------------------
  PROCEDURE Init
    RETURN DODEFAULT()
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE InicializarForm
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    TRY
      THIS.this_oBusinessObject = CREATEOBJECT("sigopcgpBO")
      IF VARTYPE(THIS.this_oBusinessObject) = "O"
        THIS.this_cPrompt = THIS.Caption
        THIS.InicializarCursores()
        THIS.ConfigurarPageFrame()
        THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
        BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_Operacao,       "Click", THIS, "GrpOperacaoClick")
        BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_LimparFiltros,  "Click", THIS, "GrpLimparFiltrosClick")

        *-- Grid AfterRowColChange para carregar detalhes do produto selecionado
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos, ;
          "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")

        *-- Inicializar combos de filtro
        THIS.PopularCombos()
        *-- Criar botao Voltar na pagina de resultado
        THIS.ConfigurarBtnVoltar()
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        *-- Carregar dados iniciais dos grids de filtro
        THIS.CarregarCaracteristicas()
        THIS.CarregarTiposOperacao()

        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio.", "Erro")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPageFrame
    *-- PageFrame principal (fld_principal) - 2 paginas: Consulta e Resultado
    THIS.AddObject("pgf_4c_1", "PageFrame")
    WITH THIS.pgf_4c_1
      .Top         = 0
      .Left        = 0
      .Width       = 1005
      .Height      = 616
      .PageCount   = 2
      .Tabs        = .F.
    ENDWITH

    THIS.ConfigurarPaginaConsulta()
    THIS.ConfigurarPaginaLista()
    THIS.ConfigurarPaginaResultado()
    THIS.ConfigurarPaginaDados()

    THIS.pgf_4c_1.Visible = .T.
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaConsulta
    *-- Page1 = pagina de filtros/consulta
    WITH THIS.pgf_4c_1.Page1
      .Caption   = ""
      .BackColor = RGB(236, 233, 216)

      *-- Container titulo (cntSombra) - barra de titulo azul
      .AddObject("cnt_4c_Sombra", "Container")
      WITH .cnt_4c_Sombra
        .Top         = 0
        .Left        = 0
        .Width       = THIS.Width
        .Height      = 28
        .BackColor   = RGB(0, 0, 128)
        .BorderWidth = 0
        .Visible     = .T.

        .AddObject("lbl_4c_Titulo", "Label")
        WITH .lbl_4c_Titulo
          .Top       = 4
          .Left      = 4
          .Width     = THIS.Width
          .Height    = 20
          .Caption   = "Pesquisa Global de Produtos"
          .FontName  = "Tahoma"
          .FontSize  = 10
          .FontBold  = .T.
          .ForeColor = RGB(255, 255, 255)
          .BackStyle = 0
          .AutoSize  = .F.
        ENDWITH
      ENDWITH

      *-- CommandGroup de operacoes (grp_operacao): Consultar + Cancelar
      .AddObject("grp_4c_Operacao", "CommandGroup")
      WITH .grp_4c_Operacao
        .Top         = -3
        .Left        = 844
        .Height      = 85
        .Width       = 160
        .ButtonCount = 2
        .BorderStyle = 0
        .Visible     = .T.
      ENDWITH

      WITH .grp_4c_Operacao.Buttons(1)
        .Caption     = "\<Consultar"
        .Top         = 5
        .Left        = 5
        .Width       = 75
        .Height      = 75
        .FontName    = "Comic Sans MS"
        .FontSize    = 8
        .FontBold    = .T.
        .FontItalic  = .T.
        .ToolTipText = "Consultar Usando os Filtros Informados"
      ENDWITH

      WITH .grp_4c_Operacao.Buttons(2)
        .Caption     = "Encerrar"
        .Top         = 5
        .Left        = 80
        .Width       = 75
        .Height      = 75
        .FontName    = "Comic Sans MS"
        .FontSize    = 8
        .FontBold    = .T.
        .FontItalic  = .T.
        .Cancel      = .T.
        .ToolTipText = "[ESC] Sair"
      ENDWITH

      *-- Botao Limpar Filtros (Commandgroup1 do legado)
      .AddObject("grp_4c_LimparFiltros", "CommandGroup")
      WITH .grp_4c_LimparFiltros
        .Top         = 36
        .Left        = 839
        .Width       = 75
        .Height      = 40
        .ButtonCount = 1
        .BorderStyle = 0
        .Visible     = .T.
      ENDWITH
      WITH .grp_4c_LimparFiltros.Buttons(1)
        .Top         = 3
        .Left        = 3
        .Width       = 40
        .Height      = 34
        .Caption     = ""
        .ToolTipText = "Limpar os Campos dos Filtros"
      ENDWITH

      *-- PageFrame de filtros (Filtro) - PageCount=1, Top=-25
      .AddObject("pgf_4c_Filtro", "PageFrame")
      WITH .pgf_4c_Filtro
        .Top         = -25
        .Left        = 0
        .Width       = 1005
        .Height      = 641
        .PageCount   = 1
        .Tabs        = .F.
      ENDWITH

      WITH .pgf_4c_Filtro.Page1
        .Caption   = ""
        .BackColor = RGB(236, 233, 216)
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaResultado
    *-- Page2 = pagina de resultados com 6 sub-paginas
    WITH THIS.pgf_4c_1.Page2
      .Caption   = ""
      .BackColor = RGB(236, 233, 216)

      *-- Label TxtCaption (legenda da consulta)
      .AddObject("lbl_4c_TxtCaption", "Label")
      WITH .lbl_4c_TxtCaption
        .Top       = 0
        .Left      = 0
        .Width     = 1000
        .Height    = 17
        .Caption   = ""
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
        .ForeColor = RGB(0, 0, 0)
        .AutoSize  = .F.
      ENDWITH

      *-- PageFrame de resultados (Result) - 6 sub-paginas com abas
      .AddObject("pgf_4c_Result", "PageFrame")
      WITH .pgf_4c_Result
        .Top         = 17
        .Left        = 0
        .Width       = 1000
        .Height      = 590
        .PageCount   = 6
        .Tabs        = .T.
      ENDWITH

      *-- PageOrder 1: Selecao/Filtro Produtos
      WITH .pgf_4c_Result.Page1
        .Caption   = "Sele" + CHR(231) + CHR(227) + "o"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 2: Custo
      WITH .pgf_4c_Result.Page2
        .Caption   = "Custo"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 3: Composicao
      WITH .pgf_4c_Result.Page3
        .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 4: Estoque/Historico
      WITH .pgf_4c_Result.Page4
        .Caption   = "Estoque/Hist" + CHR(243) + "rico"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 5: Industria/Fase
      WITH .pgf_4c_Result.Page5
        .Caption   = "Ind" + CHR(250) + "stria/Fase"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 6: Estoque/Etiquetas
      WITH .pgf_4c_Result.Page6
        .Caption   = "Estoque/Etiquetas"
        .BackColor = RGB(236, 233, 216)
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE InicializarCursores
    *-- Validacao de UI nao executa SQL - apenas cria placeholders
    IF NOT USED("cursor_4c_Dados")
      SET NULL ON
      CREATE CURSOR cursor_4c_Dados ;
        (cpros  C(15), dpros  C(60), cgrus  C(5),  ;
         dgrus  C(40), cmoes  C(3),  price  N(18,4),;
         qatua  N(18,4), ativo L)
      SET NULL OFF
    ENDIF

    IF NOT USED("CsMatPrima")
      SET NULL ON
      CREATE CURSOR CsMatPrima ;
        (mats C(15), dcompos C(60), qtd_inicial N(18,4), ;
         qtd_final N(18,4), apenas L, Cgrus C(5), Tipos C(10))
      SET NULL OFF
    ENDIF

    IF NOT USED("cursor_4c_Caract")
      SET NULL ON
      CREATE CURSOR cursor_4c_Caract ;
        (marcado L, cods C(5), descs C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("cursor_4c_TOpe")
      SET NULL ON
      CREATE CURSOR cursor_4c_TOpe ;
        (marcado L, ctipo C(5), dtipo C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("CrSigMvHst")
      SET NULL ON
      CREATE CURSOR CrSigMvHst ;
        (cpros C(15), dtmov D, qtmov N(18,4), vlmov N(18,4))
      SET NULL OFF
    ENDIF

    IF NOT USED("CsEtiqueta")
      SET NULL ON
      CREATE CURSOR CsEtiqueta ;
        (cpros C(15), dpros C(60), qetiq N(18,4))
      SET NULL OFF
    ENDIF

    IF NOT USED("CsFase")
      SET NULL ON
      CREATE CURSOR CsFase ;
        (cpros C(15), cfases C(5), dfases C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("CrProdutos")
      SET NULL ON
      CREATE CURSOR CrProdutos (cpros C(15), dpros C(60))
      SET NULL OFF
    ENDIF
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE CarregarDados
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE BtnConsultarClick
    LOCAL loc_oPag, loc_oFiltros, loc_lSucesso, loc_cCaption
    LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF

    loc_oPag     = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_lSucesso = .F.

    TRY
      *-- Cria objeto de filtros
      loc_oFiltros = CREATEOBJECT("Empty")

      *-- Produto / Descricao
      ADDPROPERTY(loc_oFiltros, "cProdutoInicial",     ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value))
      ADDPROPERTY(loc_oFiltros, "cProdutoFinal",       ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value))
      ADDPROPERTY(loc_oFiltros, "cDescricao",          ALLTRIM(loc_oPag.txt_4c_Descricao.Value))
      ADDPROPERTY(loc_oFiltros, "cDescritivo",         ALLTRIM(loc_oPag.txt_4c_Descritivo.Value))

      *-- Equivalente (so usa se checkbox marcado)
      ADDPROPERTY(loc_oFiltros, "cEquivalente", ;
        IIF(loc_oPag.chk_4c_Equiv.Value = 1, ALLTRIM(loc_oPag.txt_4c_Equiv.Value), ""))

      *-- Grupo / SubGrupo / Grande Grupo
      ADDPROPERTY(loc_oFiltros, "cGrandeGrupoCod",     ALLTRIM(loc_oPag.txt_4c_Gde.Value))
      ADDPROPERTY(loc_oFiltros, "cGrupoCod",           ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value))
      ADDPROPERTY(loc_oFiltros, "cSubgrupoCod",        ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value))

      *-- Linha / Colecao
      ADDPROPERTY(loc_oFiltros, "cLinha",              ALLTRIM(loc_oPag.txt_4c_LinhaI.Value))
      ADDPROPERTY(loc_oFiltros, "cLinha2",             ALLTRIM(loc_oPag.txt_4c_LinhaF.Value))
      ADDPROPERTY(loc_oFiltros, "cColuna",             ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value))
      ADDPROPERTY(loc_oFiltros, "cColuna2",            ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value))

      *-- Fornecedor / Referencia
      ADDPROPERTY(loc_oFiltros, "cFornecedorCod",      ALLTRIM(loc_oPag.txt_4c_CdFornec.Value))
      ADDPROPERTY(loc_oFiltros, "cRefFornecedor",      ALLTRIM(loc_oPag.txt_4c_RefFornec.Value))
      ADDPROPERTY(loc_oFiltros, "cRefFornecedorFinal", ALLTRIM(loc_oPag.txt_4c_RefFornecF.Value))
      ADDPROPERTY(loc_oFiltros, "nOptTipoRef",         loc_oPag.opt_4c_TpReffs.Value)

      *-- Cor / Faixa Valor / Classificacao
      ADDPROPERTY(loc_oFiltros, "cCorCod",             ALLTRIM(loc_oPag.txt_4c_Cor.Value))
      ADDPROPERTY(loc_oFiltros, "cFxPreco",            ALLTRIM(loc_oPag.txt_4c_FxPreco.Value))
      ADDPROPERTY(loc_oFiltros, "cClassificacao",      ALLTRIM(loc_oPag.txt_4c_Classe.Value))

      *-- Lista de Precos / Promocao
      ADDPROPERTY(loc_oFiltros, "cListaPrecos",        ALLTRIM(loc_oPag.txt_4c_Lista.Value))
      ADDPROPERTY(loc_oFiltros, "cPromocao",           ALLTRIM(loc_oPag.txt_4c_Promo.Value))

      *-- Situacao / Imagem (0=Todos)
      ADDPROPERTY(loc_oFiltros, "nSituacao",           loc_oPag.cmb_4c_Situas.ListIndex)
      ADDPROPERTY(loc_oFiltros, "nImagem",             loc_oPag.cmb_4c_Imagem.ListIndex)

      *-- Pesos (converte string com mascara para numero)
      loc_cPesoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoI.Value), ",", "")
      loc_cPesoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoF.Value), ",", "")
      ADDPROPERTY(loc_oFiltros, "nPesoInicial", VAL(loc_cPesoI))
      ADDPROPERTY(loc_oFiltros, "nPesoFinal",   VAL(loc_cPesoF))

      *-- Custo
      loc_cCustoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoI.Value), ",", "")
      loc_cCustoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoF.Value), ",", "")
      ADDPROPERTY(loc_oFiltros, "nCustoInicial", VAL(loc_cCustoI))
      ADDPROPERTY(loc_oFiltros, "nCustoFinal",   VAL(loc_cCustoF))
      ADDPROPERTY(loc_oFiltros, "cMoedaCusto",   ALLTRIM(loc_oPag.txt_4c_MoeCusto.Value))

      *-- Datas (CTOD("") retorna {} - data vazia segura)
      ADDPROPERTY(loc_oFiltros, "dDataAltInicial", CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltI.Value)))
      ADDPROPERTY(loc_oFiltros, "dDataAltFinal",   CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltF.Value)))

      *-- Executa busca no BO
      THIS.MousePointer = 11

      loc_lSucesso = THIS.this_oBusinessObject.BuscarProdutos(loc_oFiltros)

      THIS.MousePointer = 0

      IF loc_lSucesso AND USED("cursor_4c_Produtos")
        *-- Transfere resultados para CrProdutos (RecordSource do grid)
        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = ""

        IF USED("CrProdutos")
          SELECT CrProdutos
          ZAP IN CrProdutos
        ENDIF

        IF RECCOUNT("cursor_4c_Produtos") > 0
          SELECT CrProdutos
          APPEND FROM DBF("cursor_4c_Produtos") FIELDS cpros, dpros
        ENDIF

        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = "CrProdutos"
        SELECT CrProdutos
        IF !EOF()
          GO TOP
        ENDIF
        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.Refresh()

        *-- Atualiza legenda e navega para pagina de resultado
        loc_cCaption = THIS.this_cPrompt
        THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = loc_cCaption
        THIS.this_lConsultaExecutada                   = .T.

        THIS.AlternarPagina(2)
      ELSE
        THIS.MousePointer = 0
        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
          MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
        ELSE
          MsgAviso("Nenhum produto encontrado com os filtros informados.")
        ENDIF
      ENDIF

    CATCH TO loc_oErro
      THIS.MousePointer = 0
      MsgErro("Erro na consulta: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oFiltros = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BtnCancelarClick: cancela edicao de preco (restaura ReadOnly nos campos de preco)
  PROCEDURE BtnCancelarClick
    LOCAL loc_oCab
    TRY
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
      loc_oCab.txt_4c_PrVendaR.ReadOnly   = .T.
      loc_oCab.txt_4c_MoePrVR.ReadOnly    = .T.
      loc_oCab.txt_4c_PesoMedioR.ReadOnly = .T.
      loc_oCab.txt_4c_FatorVR.ReadOnly    = .T.
      loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .T.
      loc_oCab = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho pode nao estar instanciado ainda; ReadOnly e melhor-esforco
    ENDTRY
    THIS.this_lAlteraPreco = .F.
    THIS.AjustarBotoesPorModo()
  ENDPROC

  *------------------------------------------------------------
  *-- TornarControlesVisiveis: exclui containers flutuantes (Visible=.F.)
  PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome
    IF VARTYPE(par_oContainer) # "O"
      RETURN
    ENDIF
    FOR loc_i = 1 TO par_oContainer.ControlCount
      loc_oCtrl = par_oContainer.Controls(loc_i)
      loc_cNome = UPPER(loc_oCtrl.Name)

      *-- Containers flutuantes/ocultos por design permanecem Visible=.F.
      *-- (cnt_4c_Sombra eh o cabecalho fixo, controlado direto no Init - regra #11)
      IF INLIST(loc_cNome, ;
          "CNT_4C_PRECO",    ;
          "CNT_4C_ZOOM",     ;
          "CNT_4C_FILTROS",  ;
          "CNT_4C_ETIQUETA", ;
          "CNT_4C_DETALHE",  ;
          "CNT_4C_SOMBRA")
        LOOP
      ENDIF

      *-- Indicador "Produto Descontinuado": nasce oculto e so aparece quando
      *-- o produto selecionado esta descontinuado (situas = 2).
      IF INLIST(loc_cNome, "SHP_4C_DESCONTINUADO", "LBL_4C_DESCONTINUADO")
        *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
        IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
            THIS.TornarControlesVisiveis(loc_oCtrl)
        ENDIF
        LOOP
      ENDIF

      loc_oCtrl.Visible = .T.

      *-- Recursao em Containers
      IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
        IF loc_oCtrl.ControlCount > 0
          THIS.TornarControlesVisiveis(loc_oCtrl)
        ENDIF
      ENDIF

      *-- Recursao em Pages de PageFrame
      IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
        FOR loc_j = 1 TO loc_oCtrl.PageCount
          THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
        ENDFOR
      ENDIF
    ENDFOR
    loc_oCtrl = .NULL.
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE Destroy
    *-- Liberar todos os cursores utilizados pelo form
    LOCAL loc_aCursores(15), loc_i
    loc_aCursores(1)  = "cursor_4c_Dados"
    loc_aCursores(2)  = "CsMatPrima"
    loc_aCursores(3)  = "CrSigCdPro"
    loc_aCursores(4)  = "CrSigMvEst"
    loc_aCursores(5)  = "CrSigOpEtq1"
    loc_aCursores(6)  = "CrSigPrCpo"
    loc_aCursores(7)  = "CrSigMvHst"
    loc_aCursores(8)  = "CrSigMvEtr"
    loc_aCursores(9)  = "CrProdutos"
    loc_aCursores(10) = "TotGrupo2"
    loc_aCursores(11) = "CsFase"
    loc_aCursores(12) = "CsEtiqueta"
    loc_aCursores(13) = "crProEtqEqs"
    loc_aCursores(14) = "cursor_4c_Caract"
    loc_aCursores(15) = "cursor_4c_TOpe"

    FOR loc_i = 1 TO 15
      IF USED(loc_aCursores(loc_i))
        USE IN (loc_aCursores(loc_i))
      ENDIF
    ENDFOR

    *-- Liberar objeto de negocio
    THIS.this_oBusinessObject = .NULL.

    DODEFAULT()
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE AlternarPagina(par_nPagina)
    THIS.pgf_4c_1.ActivePage = par_nPagina
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE GrpOperacaoClick
    DO CASE
    CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 1
      THIS.BtnConsultarClick()
    CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 2
      THIS.BtnEncerrarClick()
    ENDCASE
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaLista
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    *-- Separador horizontal (sh_Refs)
    loc_oPag.AddObject("shp_4c_Refs", "Shape")
    WITH loc_oPag.shp_4c_Refs
      .Top         = 481
      .Left        = 8
      .Height      = 1
      .Width       = 981
      .BorderStyle = 1
      .BorderWidth = 2
      .BackStyle   = 0
    ENDWITH

    *== LINHA 1: Produto inicial/final + Equivalente + Situacao + Imagem ==
    loc_oPag.AddObject("lbl_4c_Produto", "Label")
    WITH loc_oPag.lbl_4c_Produto
      .Top       = 84
      .Left      = 66
      .Width     = 47
      .Height    = 15
      .Caption   = "\<Produto :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ProdutoI", "TextBox")
    WITH loc_oPag.txt_4c_ProdutoI
      .Top           = 80
      .Left          = 117
      .Width         = 126
      .Height        = 22
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_ProdutoA", "Label")
    WITH loc_oPag.lbl_4c_ProdutoA
      .Top       = 84
      .Left      = 253
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ProdutoF", "TextBox")
    WITH loc_oPag.txt_4c_ProdutoF
      .Top           = 80
      .Left          = 282
      .Width         = 126
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Equiv", "Label")
    WITH loc_oPag.lbl_4c_Equiv
      .Top       = 84
      .Left      = 446
      .Width     = 65
      .Height    = 15
      .Caption   = "Equivalente :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Equiv", "TextBox")
    WITH loc_oPag.txt_4c_Equiv
      .Top           = 80
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("chk_4c_Equiv", "CheckBox")
    WITH loc_oPag.chk_4c_Equiv
      .Top           = 83
      .Left          = 628
      .Width         = 18
      .Height        = 17
      .Caption       = ""
      .Value         = 0
      .BackStyle     = 0
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Situacao", "Label")
    WITH loc_oPag.lbl_4c_Situacao
      .Top       = 84
      .Left      = 660
      .Width     = 53
      .Height    = 15
      .Caption   = " Situa" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("cmb_4c_Situas", "ComboBox")
    WITH loc_oPag.cmb_4c_Situas
      .Top         = 80
      .Left        = 716
      .Width       = 98
      .Height      = 23
      .FontName    = "Tahoma"
      .FontSize    = 8
      .Style       = 2
      .BorderStyle = 1
    ENDWITH

    *== LINHA 2: Descricao + Barras + Imagem ==
    loc_oPag.AddObject("lbl_4c_Descricao", "Label")
    WITH loc_oPag.lbl_4c_Descricao
      .Top       = 108
      .Left      = 58
      .Width     = 55
      .Height    = 15
      .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Descricao", "TextBox")
    WITH loc_oPag.txt_4c_Descricao
      .Top           = 104
      .Left          = 117
      .Width         = 291
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Barras", "Label")
    WITH loc_oPag.lbl_4c_Barras
      .Top       = 108
      .Left      = 445
      .Width     = 66
      .Height    = 15
      .Caption   = "C" + CHR(243) + "d. Barras :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Barra", "TextBox")
    WITH loc_oPag.txt_4c_Barra
      .Top           = 104
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K"
      .InputMask     = "99999999999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Imagem", "Label")
    WITH loc_oPag.lbl_4c_Imagem
      .Top       = 108
      .Left      = 666
      .Width     = 47
      .Height    = 15
      .Caption   = "Imagem :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("cmb_4c_Imagem", "ComboBox")
    WITH loc_oPag.cmb_4c_Imagem
      .Top         = 104
      .Left        = 716
      .Width       = 98
      .Height      = 23
      .FontName    = "Tahoma"
      .FontSize    = 8
      .Style       = 2
      .BorderStyle = 1
    ENDWITH

    *== LINHA 3: Descritivo + Linha Inicial/Final ==
    loc_oPag.AddObject("lbl_4c_Descritivo", "Label")
    WITH loc_oPag.lbl_4c_Descritivo
      .Top       = 132
      .Left      = 57
      .Width     = 56
      .Height    = 15
      .Caption   = "Descritivo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Descritivo", "TextBox")
    WITH loc_oPag.txt_4c_Descritivo
      .Top           = 128
      .Left          = 117
      .Width         = 291
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Linha", "Label")
    WITH loc_oPag.lbl_4c_Linha
      .Top       = 132
      .Left      = 477
      .Width     = 34
      .Height    = 15
      .Caption   = "\<Linha :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_LinhaI", "TextBox")
    WITH loc_oPag.txt_4c_LinhaI
      .Top           = 128
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_LinhaA", "Label")
    WITH loc_oPag.lbl_4c_LinhaA
      .Top       = 132
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_LinhaF", "TextBox")
    WITH loc_oPag.txt_4c_LinhaF
      .Top           = 128
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 4: Completa + Grupo Venda Inicial/Final ==
    loc_oPag.AddObject("lbl_4c_Completa", "Label")
    WITH loc_oPag.lbl_4c_Completa
      .Top       = 155
      .Left      = 59
      .Width     = 54
      .Height    = 15
      .Caption   = "Completa :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DCompl", "TextBox")
    WITH loc_oPag.txt_4c_DCompl
      .Top           = 152
      .Left          = 117
      .Width         = 291
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 25
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoVenda", "Label")
    WITH loc_oPag.lbl_4c_GrupoVenda
      .Top       = 156
      .Left      = 440
      .Width     = 71
      .Height    = 15
      .Caption   = "Grupo \<Venda :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoVI", "TextBox")
    WITH loc_oPag.txt_4c_GrupoVI
      .Top           = 152
      .Left          = 515
      .Width         = 108
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoVA", "Label")
    WITH loc_oPag.lbl_4c_GrupoVA
      .Top       = 156
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoVF", "TextBox")
    WITH loc_oPag.txt_4c_GrupoVF
      .Top           = 152
      .Left          = 649
      .Width         = 108
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 5: Grupo (produto) + Peso Medio ==
    loc_oPag.AddObject("lbl_4c_Grupo", "Label")
    WITH loc_oPag.lbl_4c_Grupo
      .Top       = 178
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Grupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Gde", "TextBox")
    WITH loc_oPag.txt_4c_Gde
      .Top           = 174
      .Left          = 117
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "!K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoSep", "Label")
    WITH loc_oPag.lbl_4c_GrupoSep
      .Top       = 175
      .Left      = 154
      .Width     = 10
      .Height    = 15
      .Caption   = "/"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdGrupo", "TextBox")
    WITH loc_oPag.txt_4c_CdGrupo
      .Top           = 174
      .Left          = 163
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsGrupo", "TextBox")
    WITH loc_oPag.txt_4c_DsGrupo
      .Top           = 174
      .Left          = 200
      .Width         = 208
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Peso", "Label")
    WITH loc_oPag.lbl_4c_Peso
      .Top       = 180
      .Left      = 448
      .Width     = 63
      .Height    = 15
      .Caption   = "Peso M" + CHR(233) + "dio :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_PesoI", "TextBox")
    WITH loc_oPag.txt_4c_PesoI
      .Top           = 174
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 8
      .InputMask     = "999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PesoA", "Label")
    WITH loc_oPag.lbl_4c_PesoA
      .Top       = 180
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_PesoF", "TextBox")
    WITH loc_oPag.txt_4c_PesoF
      .Top           = 174
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 8
      .InputMask     = "999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 6: Subgrupo + Preco Custo + Modelo ==
    loc_oPag.AddObject("lbl_4c_Sgrupo", "Label")
    WITH loc_oPag.lbl_4c_Sgrupo
      .Top       = 202
      .Left      = 58
      .Width     = 55
      .Height    = 15
      .Caption   = "Subgrupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdSGrupo", "TextBox")
    WITH loc_oPag.txt_4c_CdSGrupo
      .Top           = 198
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsSGrupo", "TextBox")
    WITH loc_oPag.txt_4c_DsSGrupo
      .Top           = 198
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PCusto", "Label")
    WITH loc_oPag.lbl_4c_PCusto
      .Top       = 203
      .Left      = 429
      .Width     = 82
      .Height    = 15
      .Caption   = "Pre" + CHR(231) + "o de Custo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CustoI", "TextBox")
    WITH loc_oPag.txt_4c_CustoI
      .Top           = 198
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PCustoA", "Label")
    WITH loc_oPag.lbl_4c_PCustoA
      .Top       = 203
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CustoF", "TextBox")
    WITH loc_oPag.txt_4c_CustoF
      .Top           = 198
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeCusto", "TextBox")
    WITH loc_oPag.txt_4c_MoeCusto
      .Top           = 198
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Modelo", "Label")
    WITH loc_oPag.lbl_4c_Modelo
      .Top       = 202
      .Left      = 839
      .Width     = 43
      .Height    = 15
      .Caption   = "Modelo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodFinP", "TextBox")
    WITH loc_oPag.txt_4c_CodFinP
      .Top           = 198
      .Left          = 886
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_ModeloA", "Label")
    WITH loc_oPag.lbl_4c_ModeloA
      .Top       = 202
      .Left      = 931
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodFinPF", "TextBox")
    WITH loc_oPag.txt_4c_CodFinPF
      .Top           = 198
      .Left          = 959
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 7: Cor + Valor Estimado + Faixa Valor ==
    loc_oPag.AddObject("lbl_4c_Cor", "Label")
    WITH loc_oPag.lbl_4c_Cor
      .Top       = 225
      .Left      = 87
      .Width     = 26
      .Height    = 15
      .Caption   = "Cor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Cor", "TextBox")
    WITH loc_oPag.txt_4c_Cor
      .Top           = 222
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DCor", "TextBox")
    WITH loc_oPag.txt_4c_DCor
      .Top           = 222
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Estimado", "Label")
    WITH loc_oPag.lbl_4c_Estimado
      .Top       = 226
      .Left      = 432
      .Width     = 79
      .Height    = 15
      .Caption   = "Valor Estimado :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EstimI", "TextBox")
    WITH loc_oPag.txt_4c_EstimI
      .Top           = 222
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_EstimadoA", "Label")
    WITH loc_oPag.lbl_4c_EstimadoA
      .Top       = 226
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EstimF", "TextBox")
    WITH loc_oPag.txt_4c_EstimF
      .Top           = 222
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeEstim", "TextBox")
    WITH loc_oPag.txt_4c_MoeEstim
      .Top           = 222
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_FxPreco", "Label")
    WITH loc_oPag.lbl_4c_FxPreco
      .Top       = 226
      .Left      = 820
      .Width     = 62
      .Height    = 15
      .Caption   = "Faixa Valor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_FxPreco", "TextBox")
    WITH loc_oPag.txt_4c_FxPreco
      .Top           = 222
      .Left          = 886
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 15
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 8: Preco Venda + Classificacao + Tamanho ==
    loc_oPag.AddObject("lbl_4c_PVenda", "Label")
    WITH loc_oPag.lbl_4c_PVenda
      .Top       = 251
      .Left      = 427
      .Width     = 84
      .Height    = 15
      .Caption   = "Pre" + CHR(231) + "o de Venda :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_VendaI", "TextBox")
    WITH loc_oPag.txt_4c_VendaI
      .Top           = 247
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PVendaA", "Label")
    WITH loc_oPag.lbl_4c_PVendaA
      .Top       = 251
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_VendaF", "TextBox")
    WITH loc_oPag.txt_4c_VendaF
      .Top           = 247
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeVenda", "TextBox")
    WITH loc_oPag.txt_4c_MoeVenda
      .Top           = 247
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Classe", "Label")
    WITH loc_oPag.lbl_4c_Classe
      .Top       = 251
      .Left      = 812
      .Width     = 70
      .Height    = 15
      .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Classe", "TextBox")
    WITH loc_oPag.txt_4c_Classe
      .Top           = 247
      .Left          = 886
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- Legado: Say31 / getTam / get_dTam (SigCdTam). O par codigo+descricao
    *-- ocupa exatamente esta linha no SCX (getTam Left=115 W=52, get_dTam Left=170 W=236).
    loc_oPag.AddObject("lbl_4c_Tamanho", "Label")
    WITH loc_oPag.lbl_4c_Tamanho
      .Top       = 249
      .Left      = 59
      .Width     = 54
      .Height    = 15
      .Caption   = "Tamanho :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tam", "TextBox")
    WITH loc_oPag.txt_4c_Tam
      .Top           = 246
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 4
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DTam", "TextBox")
    WITH loc_oPag.txt_4c_DTam
      .Top           = 246
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 9: Lista Precos + Periodo Alteracao + Dimensoes ==
    loc_oPag.AddObject("lbl_4c_Lista", "Label")
    WITH loc_oPag.lbl_4c_Lista
      .Top       = 272
      .Left      = 32
      .Width     = 81
      .Height    = 15
      .Caption   = "Lista de Pre" + CHR(231) + "os :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Lista", "TextBox")
    WITH loc_oPag.txt_4c_Lista
      .Top           = 270
      .Left          = 117
      .Width         = 239
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 30
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PeriodoAlt", "Label")
    WITH loc_oPag.lbl_4c_PeriodoAlt
      .Top       = 275
      .Left      = 466
      .Width     = 45
      .Height    = 15
      .Caption   = "Per" + CHR(237) + "odo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtAltI", "TextBox")
    WITH loc_oPag.txt_4c_DtAltI
      .Top           = 271
      .Left          = 515
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_DtAltA", "Label")
    WITH loc_oPag.lbl_4c_DtAltA
      .Top       = 275
      .Left      = 598
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtAltF", "TextBox")
    WITH loc_oPag.txt_4c_DtAltF
      .Top           = 271
      .Left          = 621
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- OptTpDtCad (Alt/Inc)
    loc_oPag.AddObject("opt_4c_TpDtCad", "OptionGroup")
    loc_oPag.opt_4c_TpDtCad.Top         = 271
    loc_oPag.opt_4c_TpDtCad.Left        = 708
    loc_oPag.opt_4c_TpDtCad.Width       = 81
    loc_oPag.opt_4c_TpDtCad.Height      = 24
    loc_oPag.opt_4c_TpDtCad.ButtonCount = 2
    loc_oPag.opt_4c_TpDtCad.BorderStyle = 0
    loc_oPag.opt_4c_TpDtCad.BackStyle   = 0
    loc_oPag.opt_4c_TpDtCad.Value       = 1
    WITH loc_oPag.opt_4c_TpDtCad.Buttons(1)
      .Caption  = "Alt"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 35
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpDtCad.Buttons(2)
      .Caption  = "Inc"
      .BackStyle = 0
      .Top      = 2
      .Left     = 39
      .Width    = 35
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Dimensao Profundidade
    loc_oPag.AddObject("lbl_4c_Profund", "Label")
    WITH loc_oPag.lbl_4c_Profund
      .Top       = 275
      .Left      = 828
      .Width     = 55
      .Height    = 15
      .Caption   = "Profund. :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamps", "TextBox")
    WITH loc_oPag.txt_4c_Tamps
      .Top           = 271
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 10: Promocao + Dimensao Altura ==
    loc_oPag.AddObject("lbl_4c_Promo", "Label")
    WITH loc_oPag.lbl_4c_Promo
      .Top       = 295
      .Left      = 57
      .Width     = 56
      .Height    = 15
      .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Promo", "TextBox")
    WITH loc_oPag.txt_4c_Promo
      .Top           = 292
      .Left          = 117
      .Width         = 239
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 25
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Altura", "Label")
    WITH loc_oPag.lbl_4c_Altura
      .Top       = 297
      .Left      = 840
      .Width     = 42
      .Height    = 15
      .Caption   = "Altura :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamas", "TextBox")
    WITH loc_oPag.txt_4c_Tamas
      .Top           = 293
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 11: Fornecedor + Dimensao Comprimento + grdCaracts ==
    loc_oPag.AddObject("lbl_4c_Fornec", "Label")
    WITH loc_oPag.lbl_4c_Fornec
      .Top       = 317
      .Left      = 49
      .Width     = 64
      .Height    = 15
      .Caption   = "Fornecedor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdFornec", "TextBox")
    WITH loc_oPag.txt_4c_CdFornec
      .Top           = 314
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsFornec", "TextBox")
    WITH loc_oPag.txt_4c_DsFornec
      .Top           = 314
      .Left          = 200
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Comprim", "Label")
    WITH loc_oPag.lbl_4c_Comprim
      .Top       = 319
      .Left      = 826
      .Width     = 57
      .Height    = 15
      .Caption   = "Comprim. :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamcs", "TextBox")
    WITH loc_oPag.txt_4c_Tamcs
      .Top           = 315
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    THIS.ConfigurarGrdCaracts(loc_oPag)

    *== LINHA 12: Ref.Fornecedor + Opt_TpReffs + Conjunto ==
    loc_oPag.AddObject("lbl_4c_RefFornec", "Label")
    WITH loc_oPag.lbl_4c_RefFornec
      .Top       = 339
      .Left      = 25
      .Width     = 88
      .Height    = 15
      .Caption   = "Ref. Fornecedor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_RefFornec", "TextBox")
    WITH loc_oPag.txt_4c_RefFornec
      .Top           = 336
      .Left          = 117
      .Width         = 115
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_RefFornecA", "Label")
    WITH loc_oPag.lbl_4c_RefFornecA
      .Top       = 339
      .Left      = 237
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_RefFornecF", "TextBox")
    WITH loc_oPag.txt_4c_RefFornecF
      .Top           = 336
      .Left          = 260
      .Width         = 115
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Opt_TpReffs (Similar/Equivalente/Todos)
    loc_oPag.AddObject("opt_4c_TpReffs", "OptionGroup")
    loc_oPag.opt_4c_TpReffs.Top         = 336
    loc_oPag.opt_4c_TpReffs.Left        = 377
    loc_oPag.opt_4c_TpReffs.Width       = 187
    loc_oPag.opt_4c_TpReffs.Height      = 23
    loc_oPag.opt_4c_TpReffs.ButtonCount = 3
    loc_oPag.opt_4c_TpReffs.BorderStyle = 0
    loc_oPag.opt_4c_TpReffs.BackStyle   = 0
    loc_oPag.opt_4c_TpReffs.Value       = 3
    WITH loc_oPag.opt_4c_TpReffs.Buttons(1)
      .Caption  = "Similar"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 58
      .Height   = 19
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpReffs.Buttons(2)
      .Caption  = "Equivalente"
      .BackStyle = 0
      .Top      = 2
      .Left     = 62
      .Width    = 65
      .Height   = 19
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpReffs.Buttons(3)
      .Caption  = "Todos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 129
      .Width    = 55
      .Height   = 19
      .AutoSize = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Conjunto", "Label")
    WITH loc_oPag.lbl_4c_Conjunto
      .Top       = 341
      .Left      = 830
      .Width     = 53
      .Height    = 15
      .Caption   = "Conjunto :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Conjunto", "TextBox")
    WITH loc_oPag.txt_4c_Conjunto
      .Top           = 337
      .Left          = 886
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .InputMask     = "999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 12-b: Colecao (Say30 / getCategoria / getDCategoria - SigCdCtg) ==
    *-- Legado: linha propria em Top=280 da coluna da esquerda. Na coluna esquerda
    *-- do migrado nao ha vao livre entre Tamanho (246) e Lista (270), entao o par
    *-- foi realocado para a faixa central livre na mesma altura de Promocao.
    loc_oPag.AddObject("lbl_4c_Colecao", "Label")
    WITH loc_oPag.lbl_4c_Colecao
      .Top       = 295
      .Left      = 463
      .Width     = 48
      .Height    = 15
      .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("txt_4c_Categoria", "TextBox")
    WITH loc_oPag.txt_4c_Categoria
      .Top           = 292
      .Left          = 515
      .Width         = 63
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DCategoria", "TextBox")
    WITH loc_oPag.txt_4c_DCategoria
      .Top           = 292
      .Left          = 581
      .Width         = 225
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 12-c: Localizacao (Say32 / getLocals) - coluna da direita ==
    loc_oPag.AddObject("lbl_4c_Localizacao", "Label")
    WITH loc_oPag.lbl_4c_Localizacao
      .Top       = 177
      .Left      = 819
      .Width     = 64
      .Height    = 15
      .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .WordWrap  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("txt_4c_Locals", "TextBox")
    WITH loc_oPag.txt_4c_Locals
      .Top           = 174
      .Left          = 886
      .Width         = 86
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 12-d: Cod. Macro (Say52 / getCodMacro) + chkOff - coluna da direita ==
    loc_oPag.AddObject("lbl_4c_CodMacro", "Label")
    WITH loc_oPag.lbl_4c_CodMacro
      .Top       = 362
      .Left      = 818
      .Width     = 65
      .Height    = 15
      .Caption   = "Cod. Macro :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodMacro", "TextBox")
    WITH loc_oPag.txt_4c_CodMacro
      .Top           = 359
      .Left          = 886
      .Width         = 52
      .Height        = 22
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("chk_4c_Off", "CheckBox")
    WITH loc_oPag.chk_4c_Off
      .Top       = 361
      .Left      = 945
      .Width     = 40
      .Height    = 17
      .Caption   = "Off"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .FontBold  = .T.
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
      .Value     = 0
    ENDWITH

    *== LINHA 13: Empresa + Grupo CC ==
    loc_oPag.AddObject("lbl_4c_Empresa", "Label")
    WITH loc_oPag.lbl_4c_Empresa
      .Top       = 360
      .Left      = 63
      .Width     = 50
      .Height    = 15
      .Caption   = "Empresa :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Emps", "TextBox")
    WITH loc_oPag.txt_4c_Emps
      .Top           = 358
      .Left          = 117
      .Width         = 31
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsEmps", "TextBox")
    WITH loc_oPag.txt_4c_DsEmps
      .Top           = 358
      .Left          = 150
      .Width         = 360
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoCC", "Label")
    WITH loc_oPag.lbl_4c_GrupoCC
      .Top       = 383
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Grupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoCC", "TextBox")
    WITH loc_oPag.txt_4c_GrupoCC
      .Top           = 380
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NGrupoCC", "TextBox")
    WITH loc_oPag.txt_4c_NGrupoCC
      .Top           = 380
      .Left          = 199
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Produto Web (optWebs)
    loc_oPag.AddObject("lbl_4c_ProdWeb", "Label")
    WITH loc_oPag.lbl_4c_ProdWeb
      .Top       = 392
      .Left      = 851
      .Width     = 72
      .Height    = 15
      .Caption   = "Produto Web :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("opt_4c_Webs", "OptionGroup")
    loc_oPag.opt_4c_Webs.Top         = 407
    loc_oPag.opt_4c_Webs.Left        = 851
    loc_oPag.opt_4c_Webs.Width       = 132
    loc_oPag.opt_4c_Webs.Height      = 63
    loc_oPag.opt_4c_Webs.ButtonCount = 5
    loc_oPag.opt_4c_Webs.BorderStyle = 0
    loc_oPag.opt_4c_Webs.BackStyle   = 0
    loc_oPag.opt_4c_Webs.Value       = 5
    WITH loc_oPag.opt_4c_Webs.Buttons(1)
      .Caption  = "Sim"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(2)
      .Caption  = "N" + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 14
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(3)
      .Caption  = "Tudo"
      .BackStyle = 0
      .Top      = 26
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(4)
      .Caption  = "Sim/N" + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 38
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(5)
      .Caption  = "Apenas Web"
      .BackStyle = 0
      .Top      = 50
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH

    *== LINHA 14: Conta CC ==
    loc_oPag.AddObject("lbl_4c_ContaCC", "Label")
    WITH loc_oPag.lbl_4c_ContaCC
      .Top       = 405
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Conta :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdConta", "TextBox")
    WITH loc_oPag.txt_4c_CdConta
      .Top           = 402
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NConta", "TextBox")
    WITH loc_oPag.txt_4c_NConta
      .Top           = 402
      .Left          = 199
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *== LINHA 15: Composicao (label + grd_composicao) ==
    loc_oPag.AddObject("lbl_4c_Composicao", "Label")
    WITH loc_oPag.lbl_4c_Composicao
      .Top       = 425
      .Left      = 44
      .Width     = 69
      .Height    = 15
      .Caption   = " Composi" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    THIS.ConfigurarGrdComposicao(loc_oPag)

    *== LINHA 16: Tipo de Operacao + grdTOpe + Operacao campos ==
    loc_oPag.AddObject("lbl_4c_TipoOpe", "Label")
    WITH loc_oPag.lbl_4c_TipoOpe
      .Top       = 488
      .Left      = 19
      .Width     = 94
      .Height    = 15
      .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("chk_4c_MarcaTOpe", "CheckBox")
    WITH loc_oPag.chk_4c_MarcaTOpe
      .Top       = 487
      .Left      = 120
      .Width     = 13
      .Height    = 16
      .Caption   = ""
      .Value     = 0
      .BackStyle = 0
    ENDWITH

    THIS.ConfigurarGrdTOpe(loc_oPag)

    loc_oPag.AddObject("lbl_4c_Operacao", "Label")
    WITH loc_oPag.lbl_4c_Operacao
      .Top       = 488
      .Left      = 561
      .Width     = 56
      .Height    = 15
      .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EmpsO", "TextBox")
    WITH loc_oPag.txt_4c_EmpsO
      .Top           = 486
      .Left          = 618
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
    WITH loc_oPag.txt_4c_Operacao
      .Top           = 486
      .Left          = 652
      .Width         = 151
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_OperacaoI", "TextBox")
    WITH loc_oPag.txt_4c_OperacaoI
      .Top           = 486
      .Left          = 805
      .Width         = 55
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .Format        = "K"
      .InputMask     = "999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- Botao arquivo (equivalente ao Commandgroup1 em Filtro.Principal)
    loc_oPag.AddObject("grp_4c_Arquivo", "CommandGroup")
    WITH loc_oPag.grp_4c_Arquivo
      .Top         = 482
      .Left        = 476
      .Width       = 55
      .Height      = 55
      .ButtonCount = 1
      .BorderStyle = 0
    ENDWITH
    WITH loc_oPag.grp_4c_Arquivo.Buttons(1)
      .Top         = 3
      .Left        = 3
      .Width       = 40
      .Height      = 40
      .Caption     = ""
      .ToolTipText = "Arquivo"
    ENDWITH

    *== LINHA 17: Periodo Operacao + OptTpData + OptOperacao + OptPagamento ==
    loc_oPag.AddObject("lbl_4c_DtOpe", "Label")
    WITH loc_oPag.lbl_4c_DtOpe
      .Top       = 516
      .Left      = 496
      .Width     = 121
      .Height    = 17
      .Caption   = "Dt Opera" + CHR(231) + CHR(227) + "o : "
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtOpeI", "TextBox")
    WITH loc_oPag.txt_4c_DtOpeI
      .Top           = 511
      .Left          = 618
      .Width         = 80
      .Height        = 25
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtOpeF", "TextBox")
    WITH loc_oPag.txt_4c_DtOpeF
      .Top           = 511
      .Left          = 716
      .Width         = 80
      .Height        = 25
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- OptTpData (Dt Operacao / Dt Cadastro)
    loc_oPag.AddObject("opt_4c_TpData", "OptionGroup")
    loc_oPag.opt_4c_TpData.Top         = 512
    loc_oPag.opt_4c_TpData.Left        = 800
    loc_oPag.opt_4c_TpData.Width       = 187
    loc_oPag.opt_4c_TpData.Height      = 24
    loc_oPag.opt_4c_TpData.ButtonCount = 2
    loc_oPag.opt_4c_TpData.BorderStyle = 0
    loc_oPag.opt_4c_TpData.BackStyle   = 0
    loc_oPag.opt_4c_TpData.Value       = 1
    WITH loc_oPag.opt_4c_TpData.Buttons(1)
      .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 90
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpData.Buttons(2)
      .Caption  = "Dt Cadastro"
      .BackStyle = 0
      .Top      = 2
      .Left     = 94
      .Width    = 90
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Filtro de Situacao da Operacao (3 opcoes)
    loc_oPag.AddObject("opt_4c_Operacao", "OptionGroup")
    loc_oPag.opt_4c_Operacao.Top         = 534
    loc_oPag.opt_4c_Operacao.Left        = 615
    loc_oPag.opt_4c_Operacao.Width       = 227
    loc_oPag.opt_4c_Operacao.Height      = 24
    loc_oPag.opt_4c_Operacao.ButtonCount = 3
    loc_oPag.opt_4c_Operacao.BorderStyle = 0
    loc_oPag.opt_4c_Operacao.BackStyle   = 0
    WITH loc_oPag.opt_4c_Operacao.Buttons(1)
      .Caption  = "Pendentes"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Operacao.Buttons(2)
      .Caption  = "Faturados"
      .BackStyle = 0
      .Top      = 2
      .Left     = 76
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Operacao.Buttons(3)
      .Caption  = "Todos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 150
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Filtro de Situacao do Pagamento (3 opcoes)
    loc_oPag.AddObject("opt_4c_Pagamento", "OptionGroup")
    loc_oPag.opt_4c_Pagamento.Top         = 550
    loc_oPag.opt_4c_Pagamento.Left        = 615
    loc_oPag.opt_4c_Pagamento.Width       = 227
    loc_oPag.opt_4c_Pagamento.Height      = 24
    loc_oPag.opt_4c_Pagamento.ButtonCount = 3
    loc_oPag.opt_4c_Pagamento.BorderStyle = 0
    loc_oPag.opt_4c_Pagamento.BackStyle   = 0
    loc_oPag.opt_4c_Pagamento.Value       = 3
    WITH loc_oPag.opt_4c_Pagamento.Buttons(1)
      .Caption  = "Pagos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Pagamento.Buttons(2)
      .Caption  = "Pendentes"
      .BackStyle = 0
      .Top      = 2
      .Left     = 76
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Pagamento.Buttons(3)
      .Caption  = "Cancelados"
      .BackStyle = 0
      .Top      = 2
      .Left     = 150
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *== LINHA 18: Conta Financeira + CPF + Botao Conjuge ==
    loc_oPag.AddObject("lbl_4c_ContaFin", "Label")
    WITH loc_oPag.lbl_4c_ContaFin
      .Top       = 578
      .Left      = 72
      .Width     = 38
      .Height    = 15
      .Caption   = "Conta :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ContaO", "TextBox")
    WITH loc_oPag.txt_4c_ContaO
      .Top           = 576
      .Left          = 118
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_CPF", "TextBox")
    WITH loc_oPag.txt_4c_CPF
      .Top           = 576
      .Left          = 200
      .Width         = 146
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NContaO", "TextBox")
    WITH loc_oPag.txt_4c_NContaO
      .Top           = 576
      .Left          = 348
      .Width         = 346
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Botao Conjuge (cmdConjuge)
    loc_oPag.AddObject("grp_4c_Conjuge", "CommandGroup")
    WITH loc_oPag.grp_4c_Conjuge
      .Top         = 565
      .Left        = 698
      .Width       = 46
      .Height      = 37
      .ButtonCount = 1
      .BorderStyle = 0
    ENDWITH
    WITH loc_oPag.grp_4c_Conjuge.Buttons(1)
      .Top         = 3
      .Left        = 3
      .Width       = 40
      .Height      = 31
      .Caption     = ""
      .ToolTipText = "Procurar Conta Por C" + CHR(244) + "njuge"
    ENDWITH

    *-- BINDEVENTs: Lookups F4 nos campos de filtro
    BINDEVENT(loc_oPag.txt_4c_ProdutoI,  "KeyPress", THIS, "TxtProdutoIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_ProdutoF,  "KeyPress", THIS, "TxtProdutoFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Equiv,     "KeyPress", THIS, "TxtEquivKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdGrupo,   "KeyPress", THIS, "TxtCdGrupoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Gde,       "KeyPress", THIS, "TxtGdeKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdSGrupo,  "KeyPress", THIS, "TxtCdSGrupoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Cor,       "KeyPress", THIS, "TxtCorKeyPress")
    BINDEVENT(loc_oPag.txt_4c_LinhaI,    "KeyPress", THIS, "TxtLinhaIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_LinhaF,    "KeyPress", THIS, "TxtLinhaFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoVI,   "KeyPress", THIS, "TxtGrupoVIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoVF,   "KeyPress", THIS, "TxtGrupoVFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeEstim,  "KeyPress", THIS, "TxtMoeEstimKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeVenda,  "KeyPress", THIS, "TxtMoeVendaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CodFinP,   "KeyPress", THIS, "TxtCodFinPKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CodFinPF,  "KeyPress", THIS, "TxtCodFinPFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Classe,    "KeyPress", THIS, "TxtClasseKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Tam,       "KeyPress", THIS, "TxtTamKeyPress")
    BINDEVENT(loc_oPag.txt_4c_DTam,      "KeyPress", THIS, "TxtDTamKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Categoria, "KeyPress", THIS, "TxtCategoriaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_DCategoria,"KeyPress", THIS, "TxtDCategoriaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Promo,     "KeyPress", THIS, "TxtPromoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Lista,     "KeyPress", THIS, "TxtListaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdFornec,  "KeyPress", THIS, "TxtCdFornecKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Emps,      "KeyPress", THIS, "TxtEmpsKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoCC,   "KeyPress", THIS, "TxtGrupoCCKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdConta,   "KeyPress", THIS, "TxtCdContaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_ContaO,    "KeyPress", THIS, "TxtContaOKeyPress")
    BINDEVENT(loc_oPag.txt_4c_EmpsO,     "KeyPress", THIS, "TxtEmpsOKeyPress")

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdComposicao(par_oPag)
    par_oPag.AddObject("grd_4c_Composicao", "Grid")
    par_oPag.grd_4c_Composicao.Top          = 425
    par_oPag.grd_4c_Composicao.Left         = 117
    par_oPag.grd_4c_Composicao.Width        = 722
    par_oPag.grd_4c_Composicao.Height       = 54
    par_oPag.grd_4c_Composicao.ColumnCount  = 7
    par_oPag.grd_4c_Composicao.RecordSource = "CsMatPrima"

    WITH par_oPag.grd_4c_Composicao
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 18
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      WITH .Column1
        .Width           = 108
        .ControlSource   = "CsMatPrima.mats"
        .Movable         = .F.
        .Resizable       = .F.
        .Header1.Caption = "Caracter" + CHR(237) + "stica"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column2
        .Width           = 290
        .ControlSource   = "CsMatPrima.dcompos"
        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column3
        .Width           = 80
        .ControlSource   = "CsMatPrima.qtd_inicial"
        .Header1.Caption = "Qtd"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column4
        .Width           = 80
        .ControlSource   = "CsMatPrima.qtd_final"
        .Header1.Caption = "Quantidade"
        .Header1.Alignment = 2
      ENDWITH

      *-- Column5: CheckBox (apenas)
      .Column5.AddObject("Check1", "CheckBox")
      WITH .Column5
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "CsMatPrima.apenas"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column6
        .Width           = 31
        .ControlSource   = "CsMatPrima.Cgrus"
        .Header1.Caption = "Grupo"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column7
        .Width           = 80
        .ControlSource   = "CsMatPrima.Tipos"
        .Header1.Caption = "Tipos"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdCaracts(par_oPag)
    par_oPag.AddObject("grd_4c_Caract", "Grid")
    par_oPag.grd_4c_Caract.Top          = 319
    par_oPag.grd_4c_Caract.Left         = 568
    par_oPag.grd_4c_Caract.Width        = 187
    par_oPag.grd_4c_Caract.Height       = 105
    par_oPag.grd_4c_Caract.ColumnCount  = 2
    par_oPag.grd_4c_Caract.RecordSource = "cursor_4c_Caract"

    WITH par_oPag.grd_4c_Caract
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 17
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      *-- Column1: CheckBox (marcado)
      .Column1.AddObject("Check1", "CheckBox")
      WITH .Column1
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "cursor_4c_Caract.marcado"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column2
        .Width           = 150
        .ControlSource   = "cursor_4c_Caract.descs"
        .Header1.Caption = "Caracter" + CHR(237) + "stica"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdTOpe(par_oPag)
    par_oPag.AddObject("grd_4c_TOpe", "Grid")
    par_oPag.grd_4c_TOpe.Top          = 485
    par_oPag.grd_4c_TOpe.Left         = 118
    par_oPag.grd_4c_TOpe.Width        = 360
    par_oPag.grd_4c_TOpe.Height       = 89
    par_oPag.grd_4c_TOpe.ColumnCount  = 3
    par_oPag.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"

    WITH par_oPag.grd_4c_TOpe
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 17
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      *-- Column1: CheckBox (marcado)
      .Column1.AddObject("Check1", "CheckBox")
      WITH .Column1
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "cursor_4c_TOpe.marcado"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column2
        .Width           = 31
        .ControlSource   = "cursor_4c_TOpe.ctipo"
        .Header1.Caption = "C" + CHR(243) + "d"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column3
        .Width           = 290
        .ControlSource   = "cursor_4c_TOpe.dtipo"
        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  *-- Fase 5/8: Page2 (Selecao) - Grid + Cabecalho Parte 1
  PROTECTED PROCEDURE ConfigurarPaginaDados
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1

    *-- Grid principal de produtos (grd_produtos)
    loc_oPag.AddObject("grd_4c_Produtos", "Grid")
    loc_oPag.grd_4c_Produtos.Top          = 5
    loc_oPag.grd_4c_Produtos.Left         = 0
    loc_oPag.grd_4c_Produtos.Width        = 655
    loc_oPag.grd_4c_Produtos.Height       = 275
    loc_oPag.grd_4c_Produtos.ColumnCount  = 2
    loc_oPag.grd_4c_Produtos.RecordSource = "CrProdutos"

    WITH loc_oPag.grd_4c_Produtos
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 18
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.
      .ReadOnly          = .T.

      WITH .Column1
        .Width             = 108
        .ControlSource     = "CrProdutos.cpros"
        .Movable           = .F.
        .Resizable         = .F.
        .Header1.Caption   = "C" + CHR(243) + "d"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column2
        .Width             = 525
        .ControlSource     = "CrProdutos.dpros"
        .Movable           = .F.
        .Resizable         = .F.
        .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH

    *-- Imagem do produto (FigJpg) - lado direito do grid
    loc_oPag.AddObject("img_4c_FigJpg", "Image")
    WITH loc_oPag.img_4c_FigJpg
      .Top         = 5
      .Left        = 658
      .Width       = 222
      .Height      = 220
      .BorderStyle = 0
      .Stretch     = 2
    ENDWITH

    *-- Container de detalhe do produto (legado: Pag_Resultado.Result.Selecao)
    *-- Area util da Page1 do pgf_4c_Result: ~568px de altura. O container vai de
    *-- 283 a 519 e os dois memos ficam na faixa 522..560, abaixo dele.
    loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
    WITH loc_oPag.cnt_4c_Cabecalho
      .Top         = 283
      .Left        = 0
      .Width       = THIS.Width
      .Height      = 236
      .BackColor   = RGB(236, 233, 216)
      .BorderWidth = 0
      .Visible     = .T.

      *----------------------------------------------------------
      *-- COLUNA A (Left 5..336): identificacao / classificacao
      *----------------------------------------------------------

      *-- A1: Fornecedor (Get_cd_fornecedor / Get_ds_fornecedor)
      .AddObject("lbl_4c_Lbl_fornecedor", "Label")
      WITH .lbl_4c_Lbl_fornecedor
        .Top       = 8
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Fornecedor :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__cd_fornecedor", "TextBox")
      WITH .txt_4c__cd_fornecedor
        .Top           = 5
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_fornecedor", "TextBox")
      WITH .txt_4c__ds_fornecedor
        .Top           = 5
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 50
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A2: Ref. Fornecedor (Get_ref_fornecedor)
      .AddObject("lbl_4c_Lbl_ref_fornecedor", "Label")
      WITH .lbl_4c_Lbl_ref_fornecedor
        .Top       = 31
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Ref.Fornec. :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__ref_fornecedor", "TextBox")
      WITH .txt_4c__ref_fornecedor
        .Top           = 28
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 20
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A3: Grupo (Get_cd_grupo / Get_ds_grupo)
      .AddObject("lbl_4c_Lbl_grupo", "Label")
      WITH .lbl_4c_Lbl_grupo
        .Top       = 54
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Grupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__cd_grupo", "TextBox")
      WITH .txt_4c__cd_grupo
        .Top           = 51
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_grupo", "TextBox")
      WITH .txt_4c__ds_grupo
        .Top           = 51
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A4: Subgrupo (Get_cd_sgrupo / Get_ds_sgrupo)
      .AddObject("lbl_4c_SGrupo", "Label")
      WITH .lbl_4c_SGrupo
        .Top       = 77
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Subgrupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__cd_sgrupo", "TextBox")
      WITH .txt_4c__cd_sgrupo
        .Top           = 74
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_sgrupo", "TextBox")
      WITH .txt_4c__ds_sgrupo
        .Top           = 74
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 20
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A5: Grande Grupo (get_cd_ggrupo / get_ds_ggrupo)
      .AddObject("lbl_4c_Label15", "Label")
      WITH .lbl_4c_Label15
        .Top       = 100
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Gde. Grupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__cd_ggrupo", "TextBox")
      WITH .txt_4c__cd_ggrupo
        .Top           = 97
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_ggrupo", "TextBox")
      WITH .txt_4c__ds_ggrupo
        .Top           = 97
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A6: Linha (CdLinha / DsLinha)
      .AddObject("lbl_4c_Label5", "Label")
      WITH .lbl_4c_Label5
        .Top       = 123
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Linha :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_CdLinha", "TextBox")
      WITH .txt_4c_CdLinha
        .Top           = 120
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DsLinha", "TextBox")
      WITH .txt_4c_DsLinha
        .Top           = 120
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A7: Grupo de Venda (Get_GrVenda / Get_GrDvenda)
      .AddObject("lbl_4c_Label4", "Label")
      WITH .lbl_4c_Label4
        .Top       = 146
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Gr. Venda :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_GrVenda", "TextBox")
      WITH .txt_4c_GrVenda
        .Top           = 143
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_GrDvenda", "TextBox")
      WITH .txt_4c_GrDvenda
        .Top           = 143
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A8: Cor (getCor / Get_dCor)
      .AddObject("lbl_4c_LblCor", "Label")
      WITH .lbl_4c_LblCor
        .Top       = 169
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Cor Padr" + CHR(227) + "o :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_CodCorR", "TextBox")
      WITH .txt_4c_CodCorR
        .Top           = 166
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 4
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DescCorR", "TextBox")
      WITH .txt_4c_DescCorR
        .Top           = 166
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A9: Categoria / Colecao (Get_CdCategoria / Get_DsCategoria)
      .AddObject("lbl_4c_LblCategoria", "Label")
      WITH .lbl_4c_LblCategoria
        .Top       = 192
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Categoria :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_CdCategoriaR", "TextBox")
      WITH .txt_4c_CdCategoriaR
        .Top           = 189
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DsCategoriaR", "TextBox")
      WITH .txt_4c_DsCategoriaR
        .Top           = 189
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- A10: Modelo (getCodFinP / getDesFinP)
      .AddObject("lbl_4c_Label14", "Label")
      WITH .lbl_4c_Label14
        .Top       = 215
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Modelo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_CodFinP", "TextBox")
      WITH .txt_4c_CodFinP
        .Top           = 212
        .Left          = 78
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DesFinP", "TextBox")
      WITH .txt_4c_DesFinP
        .Top           = 212
        .Left          = 136
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *----------------------------------------------------------
      *-- COLUNA B (Left 345..678): descritivo / codigos auxiliares
      *----------------------------------------------------------

      *-- B1: Descritivo (getDPro2s)
      .AddObject("lbl_4c_LblDPro2s", "Label")
      WITH .lbl_4c_LblDPro2s
        .Top       = 8
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Descritivo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_DPro2s", "TextBox")
      WITH .txt_4c_DPro2s
        .Top           = 5
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 45
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B2: Unidade (Get_cd_unidade)
      .AddObject("lbl_4c_Lbl_unidade", "Label")
      WITH .lbl_4c_Lbl_unidade
        .Top       = 31
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Unidade :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__cd_unidade", "TextBox")
      WITH .txt_4c__cd_unidade
        .Top           = 28
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B3: Conjunto / Cod. Pai (getConjunto)
      .AddObject("lbl_4c_Label37", "Label")
      WITH .lbl_4c_Label37
        .Top       = 54
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Cod. Pai :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_Conjunto", "TextBox")
      WITH .txt_4c_Conjunto
        .Top           = 51
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B4: Equivalente (getEquivalente)
      .AddObject("lbl_4c_Label3", "Label")
      WITH .lbl_4c_Label3
        .Top       = 77
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Equivalente :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_Equivalente", "TextBox")
      WITH .txt_4c_Equivalente
        .Top           = 74
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 14
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B5: Codigo de Barras (Get_vBars)
      .AddObject("lbl_4c_Label23", "Label")
      WITH .lbl_4c_Label23
        .Top       = 100
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Barra :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_VBars", "TextBox")
      WITH .txt_4c_VBars
        .Top           = 97
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 14
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B6: Classificacao (Get_Class)
      .AddObject("lbl_4c_LblClassif", "Label")
      WITH .lbl_4c_LblClassif
        .Top       = 123
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_ClassifR", "TextBox")
      WITH .txt_4c_ClassifR
        .Top           = 120
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B7: Localizacao (getLocals)
      .AddObject("lbl_4c_LblLocais", "Label")
      WITH .lbl_4c_LblLocais
        .Top       = 146
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_LocaisR", "TextBox")
      WITH .txt_4c_LocaisR
        .Top           = 143
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B8: Cod. Macro (getCodMacro)
      .AddObject("lbl_4c_LblCodMacro", "Label")
      WITH .lbl_4c_LblCodMacro
        .Top       = 169
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Cod. Macro :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_CodMacroR", "TextBox")
      WITH .txt_4c_CodMacroR
        .Top           = 166
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B9: Preco de Venda (Get_pr_venda / Get_pr_venda_moeda)
      .AddObject("lbl_4c_LblPrVenda", "Label")
      WITH .lbl_4c_LblPrVenda
        .Top       = 192
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Pr. Venda :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_PrVendaR", "TextBox")
      WITH .txt_4c_PrVendaR
        .Top           = 189
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9,999,999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_MoePrVR", "TextBox")
      WITH .txt_4c_MoePrVR
        .Top           = 189
        .Left          = 543
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- B10: Fator de Venda (cntDados1.get_fator_venda / _moeda)
      .AddObject("lbl_4c_LblFatorV", "Label")
      WITH .lbl_4c_LblFatorV
        .Top       = 215
        .Left      = 345
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Fator :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_FatorVR", "TextBox")
      WITH .txt_4c_FatorVR
        .Top           = 212
        .Left          = 420
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9,999,999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_MoeFatorR", "TextBox")
      WITH .txt_4c_MoeFatorR
        .Top           = 212
        .Left          = 543
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *----------------------------------------------------------
      *-- COLUNA C (Left 688..985): valores / datas / observacoes
      *----------------------------------------------------------

      *-- C1: Qtd. Minima (cntDados1.get_qtd_minima)
      .AddObject("lbl_4c_Lbl_qtd_minima", "Label")
      WITH .lbl_4c_Lbl_qtd_minima
        .Top       = 8
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Qtd. M" + CHR(237) + "nima :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c__qtd_minima", "TextBox")
      WITH .txt_4c__qtd_minima
        .Top           = 5
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "999,999.999"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C2: Peso Medio (Get_peso_medio)
      .AddObject("lbl_4c_LblPesoMedio", "Label")
      WITH .lbl_4c_LblPesoMedio
        .Top       = 31
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Peso M" + CHR(233) + "dio :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_PesoMedioR", "TextBox")
      WITH .txt_4c_PesoMedioR
        .Top           = 28
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "999,999.9999"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C3: Preco De (get_PrecoDe)
      .AddObject("lbl_4c_LblPrecoDe", "Label")
      WITH .lbl_4c_LblPrecoDe
        .Top       = 54
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Pre" + CHR(231) + "o De :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_PrecoDeR", "TextBox")
      WITH .txt_4c_PrecoDeR
        .Top           = 51
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9,999,999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C4: Percentual de desconto (getPerDesc)
      .AddObject("lbl_4c_LblPerDesc", "Label")
      WITH .lbl_4c_LblPerDesc
        .Top       = 77
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "% Desc. :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_PerDescR", "TextBox")
      WITH .txt_4c_PerDescR
        .Top           = 74
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C5: Data de Inclusao (cntDados1.Get_Datainclusao)
      .AddObject("lbl_4c_LblDtInclusao", "Label")
      WITH .lbl_4c_LblDtInclusao
        .Top       = 100
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Dt. Inclus" + CHR(227) + "o :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_DtInclusaoR", "TextBox")
      WITH .txt_4c_DtInclusaoR
        .Top           = 97
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C6: Usuario de Inclusao (cntDados1.Get_UsuInc)
      .AddObject("lbl_4c_LblUsuInc", "Label")
      WITH .lbl_4c_LblUsuInc
        .Top       = 123
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Usu. Inclus" + CHR(227) + "o :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_UsuIncR", "TextBox")
      WITH .txt_4c_UsuIncR
        .Top           = 120
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C7: Data da Ultima Compra (cntDados1.get_Dtucp)
      .AddObject("lbl_4c_LblDtUltComp", "Label")
      WITH .lbl_4c_LblDtUltComp
        .Top       = 146
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Dt. Ult.Compra :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_DtUltCompR", "TextBox")
      WITH .txt_4c_DtUltCompR
        .Top           = 143
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C8: Valor da Ultima Compra (cntDados1.Get_vucp / Get_mucp)
      .AddObject("lbl_4c_LblVlUltComp", "Label")
      WITH .lbl_4c_LblVlUltComp
        .Top       = 169
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Vl. Ult.Compra :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_VlUltCompR", "TextBox")
      WITH .txt_4c_VlUltCompR
        .Top           = 166
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "999,999.99999"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_MoeUltCompR", "TextBox")
      WITH .txt_4c_MoeUltCompR
        .Top           = 166
        .Left          = 892
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C9: Observacao 1 (Get_Observacao1)
      .AddObject("lbl_4c_LblObs1", "Label")
      WITH .lbl_4c_LblObs1
        .Top       = 192
        .Left      = 688
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Observa" + CHR(231) + CHR(245) + "es :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .Alignment = 0
        .AutoSize  = .F.
        .BackStyle = 0
        .ForeColor = RGB(90, 90, 90)
      ENDWITH

      .AddObject("txt_4c_Obs1R", "TextBox")
      WITH .txt_4c_Obs1R
        .Top           = 189
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- C10: Observacao 2 (Get_Observacao2)
      .AddObject("txt_4c_Obs2R", "TextBox")
      WITH .txt_4c_Obs2R
        .Top           = 212
        .Left          = 769
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH
    ENDWITH

    *-- Memos de Observacao de Compras (getObsCompras) e Descritivo complementar
    *-- (getDPro3s). No legado sao EditBox com ControlSource em crTSigPro.ObsCompras
    *-- / crTSigPro.DPro3s; aqui sao preenchidos por codigo em GrdProdutosAfterRowColChange.
    loc_oPag.AddObject("lbl_4c_LblObsCompras", "Label")
    WITH loc_oPag.lbl_4c_LblObsCompras
      .Top       = 525
      .Left      = 5
      .Width     = 72
      .Height    = 15
      .Caption   = "Obs. Compras :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("edt_4c_ObsCompras", "EditBox")
    WITH loc_oPag.edt_4c_ObsCompras
      .Top           = 522
      .Left          = 80
      .Width         = 398
      .Height        = 38
      .FontName      = "Tahoma"
      .FontSize      = 8
      .SpecialEffect = 1
      .ScrollBars    = 2
      .ReadOnly      = .T.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_LblDPro3s", "Label")
    WITH loc_oPag.lbl_4c_LblDPro3s
      .Top       = 525
      .Left      = 488
      .Width     = 46
      .Height    = 15
      .Caption   = "Compl. :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    loc_oPag.AddObject("edt_4c_DPro3s", "EditBox")
    WITH loc_oPag.edt_4c_DPro3s
      .Top           = 522
      .Left          = 536
      .Width         = 330
      .Height        = 38
      .FontName      = "Tahoma"
      .FontSize      = 8
      .SpecialEffect = 1
      .ScrollBars    = 2
      .ReadOnly      = .T.
    ENDWITH

    *-- Indicador "Produto Descontinuado" (legado Shape1 + Say12)
    loc_oPag.AddObject("shp_4c_Descontinuado", "Shape")
    WITH loc_oPag.shp_4c_Descontinuado
      .Top         = 524
      .Left        = 876
      .Width       = 15
      .Height      = 15
      .Curvature   = 0
      .BorderColor = RGB(0, 0, 0)
      .FillStyle   = 0
      .FillColor   = RGB(255, 0, 0)
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Descontinuado", "Label")
    WITH loc_oPag.lbl_4c_Descontinuado
      .Top       = 542
      .Left      = 876
      .Width     = 110
      .Height    = 15
      .Caption   = "Descontinuado"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .Alignment = 0
      .AutoSize  = .F.
      .BackStyle = 0
      .ForeColor = RGB(90, 90, 90)
    ENDWITH

    *-- Container botoes de acao (Salvar/Cancelar) - abaixo da imagem
    loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
    WITH loc_oPag.cnt_4c_BotoesAcao
      .Top         = 228
      .Left        = 658
      .Width       = 222
      .Height      = 52
      .BackColor   = RGB(236, 233, 216)
      .BorderWidth = 0
      .Visible     = .T.

      .AddObject("cmd_4c_Salvar", "CommandButton")
      WITH .cmd_4c_Salvar
        .Top      = 3
        .Left     = 3
        .Width    = 100
        .Height   = 23
        .Caption  = "Salvar"
        .FontName = "Tahoma"
        .FontSize = 8
        .Enabled  = .F.
      ENDWITH

      *-- Height do botao limitado a altura util do container (52 - 2x3 de margem),
      *-- senao o controle fica recortado pelo pai e some da tela.
      .AddObject("cmd_4c_Cancelar", "CommandButton")
      WITH .cmd_4c_Cancelar
        .Top      = 3
        .Left     = 116
        .Width    = 75
        .Height   = 75
        .Caption  = "Encerrar"
        .FontName = "Tahoma"
        .FontSize = 8
        .Enabled  = .F.
      ENDWITH
    ENDWITH

    loc_oPag = .NULL.
  ENDPROC

  *============================================================
  *-- KEYPRESS HANDLERS - Lookup F4 (par_nKeyCode=28 ou 115)
  *============================================================

  PROCEDURE TxtProdutoIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ProdutoI")
      THIS.AbrirLookupProduto("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtProdutoFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ProdutoF")
      THIS.AbrirLookupProduto("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtEquivKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Equiv")
      THIS.AbrirLookupEquiv()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdGrupo")
      THIS.AbrirLookupGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtGdeKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Gde")
      THIS.AbrirLookupGrandeGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdSGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdSGrupo")
      THIS.AbrirLookupSubGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Cor")
      THIS.AbrirLookupCor()
    ENDIF
  ENDPROC

  PROCEDURE TxtLinhaIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_LinhaI")
      THIS.AbrirLookupLinha("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtLinhaFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_LinhaF")
      THIS.AbrirLookupLinha("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoVIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoVI")
      THIS.AbrirLookupGrupoV("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoVFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoVF")
      THIS.AbrirLookupGrupoV("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeCusto")
      THIS.AbrirLookupMoeda("MoeCusto")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeEstimKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeEstim")
      THIS.AbrirLookupMoeda("MoeEstim")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeVendaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeVenda")
      THIS.AbrirLookupMoeda("MoeVenda")
    ENDIF
  ENDPROC

  PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CodFinP")
      THIS.AbrirLookupModeloFin("P")
    ENDIF
  ENDPROC

  PROCEDURE TxtCodFinPFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CodFinPF")
      THIS.AbrirLookupModeloFin("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtClasseKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Classe")
      THIS.AbrirLookupClasse()
    ENDIF
  ENDPROC

  PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Tam")
      THIS.AbrirLookupTamanho("C")
    ENDIF
  ENDPROC

  PROCEDURE TxtDTamKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_DTam")
      THIS.AbrirLookupTamanho("D")
    ENDIF
  ENDPROC

  PROCEDURE TxtCategoriaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Categoria")
      THIS.AbrirLookupCategoria("C")
    ENDIF
  ENDPROC

  PROCEDURE TxtDCategoriaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_DCategoria")
      THIS.AbrirLookupCategoria("D")
    ENDIF
  ENDPROC

  PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Promo")
      THIS.AbrirLookupPromocao()
    ENDIF
  ENDPROC

  PROCEDURE TxtListaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Lista")
      THIS.AbrirLookupLista()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdFornecKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdFornec")
      THIS.AbrirLookupFornecedor()
    ENDIF
  ENDPROC

  PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Emps")
      THIS.AbrirLookupEmpresa("Emps", "DsEmps")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoCCKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoCC")
      THIS.AbrirLookupGrupoCC()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdConta")
      THIS.AbrirLookupContaCC()
    ENDIF
  ENDPROC

  PROCEDURE TxtContaOKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ContaO")
      THIS.AbrirLookupContaFin()
    ENDIF
  ENDPROC

  PROCEDURE TxtEmpsOKeyPress(par_nKeyCode, par_nShiftAlt)
    IF THIS.DispararLookup(par_nKeyCode, "txt_4c_EmpsO")
      THIS.AbrirLookupEmpresa("EmpsO", "")
    ENDIF
  ENDPROC

  *------------------------------------------------------------
  *-- DispararLookup: decide se o lookup deve abrir para a tecla recebida.
  *-- F4 (28/115) abre sempre - eh pedido explicito de lista pelo usuario.
  *-- ENTER (13) / TAB (9) reproduzem o PROCEDURE Valid do legado, que so
  *-- consulta quando o campo tem conteudo (If Not Empty(This.Value)).
  PROTECTED FUNCTION DispararLookup(par_nKeyCode, par_cControle)
    LOCAL loc_oPag, loc_uValor, loc_lAbre
    loc_lAbre = .F.

    IF INLIST(par_nKeyCode, 28, 115)
      loc_lAbre = .T.
    ELSE
      IF INLIST(par_nKeyCode, 9, 13)
        loc_oPag   = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
        loc_uValor = EVALUATE("loc_oPag." + par_cControle + ".Value")
        loc_lAbre  = !EMPTY(loc_uValor)
        loc_oPag   = .NULL.
      ENDIF
    ENDIF

    RETURN loc_lAbre
  ENDFUNC

  *============================================================
  *-- ABRIR LOOKUP METHODS
  *============================================================

  PROCEDURE AbrirLookupProduto(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    DO CASE
      CASE par_cTipo = "I"
        loc_cTarget = "txt_4c_ProdutoI"
        loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
      CASE par_cTipo = "F"
        loc_cTarget = "txt_4c_ProdutoF"
        loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
      OTHERWISE
        RETURN
    ENDCASE
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPro", "cursor_4c_LkpProd", "cpros", loc_cVal, "Produto")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d. Produto")
      loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpProd.cpros)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpProd")
      USE IN cursor_4c_LkpProd
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupEquiv
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Equiv.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPro", "cursor_4c_LkpEquiv", "cpros", loc_cVal, "Produto/Equivalente")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Equiv.Value = ALLTRIM(cursor_4c_LkpEquiv.cpros)
    ELSE
      loc_oPag.txt_4c_Equiv.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpEquiv")
      USE IN cursor_4c_LkpEquiv
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGrp", "cursor_4c_LkpGrp", "CGrus", loc_cVal, "Grupo de Produto")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("DGrus", "", "Grupo")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.CGrus)
      loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.DGrus)
    ELSE
      loc_oPag.txt_4c_CdGrupo.Value = ""
      loc_oPag.txt_4c_DsGrupo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGrp")
      USE IN cursor_4c_LkpGrp
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrandeGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGpr", "cursor_4c_LkpGpr", "codigos", loc_cVal, "Grande Grupo")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Gde.Value = ALLTRIM(cursor_4c_LkpGpr.codigos)
    ELSE
      loc_oPag.txt_4c_Gde.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGpr")
      USE IN cursor_4c_LkpGpr
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupSubGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPsg", "cursor_4c_LkpPsg", "codigos", loc_cVal, "Sub-Grupo")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descricaos", "", "Sub-Grupo")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.codigos)
      loc_oPag.txt_4c_DsSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.descricaos)
    ELSE
      loc_oPag.txt_4c_CdSGrupo.Value = ""
      loc_oPag.txt_4c_DsSGrupo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpPsg")
      USE IN cursor_4c_LkpPsg
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupCor
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Cor.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCor", "cursor_4c_LkpCor", "cods", loc_cVal, "Cor")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cods", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs", "", "Cor")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Cor.Value  = ALLTRIM(cursor_4c_LkpCor.cods)
      loc_oPag.txt_4c_DCor.Value = ALLTRIM(cursor_4c_LkpCor.descs)
    ELSE
      loc_oPag.txt_4c_Cor.Value  = ""
      loc_oPag.txt_4c_DCor.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCor")
      USE IN cursor_4c_LkpCor
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupLinha(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "I"
      loc_cTarget = "txt_4c_LinhaI"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
    ELSE
      loc_cTarget = "txt_4c_LinhaF"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdLin", "cursor_4c_LkpLin", "Linhas", loc_cVal, "Linha")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Linhas", "", "Linha")
      loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpLin.Linhas)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpLin")
      USE IN cursor_4c_LkpLin
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupoV(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "I"
      loc_cTarget = "txt_4c_GrupoVI"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
    ELSE
      loc_cTarget = "txt_4c_GrupoVF"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCol", "cursor_4c_LkpCol", "Colecoes", loc_cVal, "Grupo de Venda")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Descs",    "", "Grupo Venda")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpCol.Colecoes)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCol")
      USE IN cursor_4c_LkpCol
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupMoeda(par_cCampo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cCtrl = "txt_4c_" + par_cCampo
    loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdMoe", "cursor_4c_LkpMoe", "CMoes", loc_cVal, "Moeda")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("DMoes", "", "Moeda")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpMoe.CMoes)
    ELSE
      loc_oPag.&loc_cCtrl..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpMoe")
      USE IN cursor_4c_LkpMoe
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupModeloFin(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "P"
      loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinP.Value)
    ELSE
      loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinPF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdFip", "cursor_4c_LkpFip", "Cods", loc_cVal, "Modelo/Finalizador")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      IF par_cTipo = "P"
        loc_oPag.txt_4c_CodFinP.Value  = ALLTRIM(cursor_4c_LkpFip.Cods)
      ELSE
        loc_oPag.txt_4c_CodFinPF.Value = ALLTRIM(cursor_4c_LkpFip.Cods)
      ENDIF
    ELSE
      IF par_cTipo = "P"
        loc_oPag.txt_4c_CodFinP.Value  = ""
      ELSE
        loc_oPag.txt_4c_CodFinPF.Value = ""
      ENDIF
    ENDIF
    IF USED("cursor_4c_LkpFip")
      USE IN cursor_4c_LkpFip
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupClasse
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Classe.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCls", "cursor_4c_LkpCls", "cods", loc_cVal, ;
      "Classifica" + CHR(231) + CHR(227) + "o")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs", "", "Classifica" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Classe.Value = ALLTRIM(cursor_4c_LkpCls.cods)
    ELSE
      loc_oPag.txt_4c_Classe.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCls")
      USE IN cursor_4c_LkpCls
    ENDIF
    loc_oForm.Release()
  ENDPROC

  *------------------------------------------------------------
  *-- AbrirLookupTamanho: legado getTam.Valid / get_dTam.Valid
  *-- fwbuscaext sobre SigCdTam, buscando por Cods ("C") ou Descs ("D").
  *-- Os dois lados preenchem SEMPRE o par codigo + descricao.
  PROCEDURE AbrirLookupTamanho(par_cLado)
    LOCAL loc_oPag, loc_cVal, loc_cCampo, loc_oForm
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    IF par_cLado = "D"
      loc_cCampo = "Descs"
      loc_cVal   = ALLTRIM(loc_oPag.txt_4c_DTam.Value)
    ELSE
      loc_cCampo = "Cods"
      loc_cVal   = ALLTRIM(loc_oPag.txt_4c_Tam.Value)
    ENDIF

    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdTam", "cursor_4c_LkpTam", loc_cCampo, loc_cVal, ;
      "Sele" + CHR(231) + CHR(227) + "o de Tamanho")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF

    IF NOT loc_oForm.this_lAchouRegistro
      IF par_cLado = "D"
        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
      ELSE
        loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
      ENDIF
      loc_oForm.Show()
    ENDIF

    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpTam")
      SELECT cursor_4c_LkpTam
      loc_oPag.txt_4c_Tam.Value  = ALLTRIM(NVL(cursor_4c_LkpTam.Cods, ""))
      loc_oPag.txt_4c_DTam.Value = ALLTRIM(NVL(cursor_4c_LkpTam.Descs, ""))
    ENDIF

    IF USED("cursor_4c_LkpTam")
      USE IN cursor_4c_LkpTam
    ENDIF
    loc_oForm.Release()
    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- AbrirLookupCategoria: legado getCategoria.Valid / getDCategoria.Valid
  *-- fwbuscaext sobre SigCdCtg, buscando por Cods ("C") ou Descs ("D").
  PROCEDURE AbrirLookupCategoria(par_cLado)
    LOCAL loc_oPag, loc_cVal, loc_cCampo, loc_oForm
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    IF par_cLado = "D"
      loc_cCampo = "Descs"
      loc_cVal   = ALLTRIM(loc_oPag.txt_4c_DCategoria.Value)
    ELSE
      loc_cCampo = "Cods"
      loc_cVal   = ALLTRIM(loc_oPag.txt_4c_Categoria.Value)
    ENDIF

    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCtg", "cursor_4c_LkpCtg", loc_cCampo, loc_cVal, ;
      "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF

    IF NOT loc_oForm.this_lAchouRegistro
      IF par_cLado = "D"
        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
      ELSE
        loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
      ENDIF
      loc_oForm.Show()
    ENDIF

    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCtg")
      SELECT cursor_4c_LkpCtg
      loc_oPag.txt_4c_Categoria.Value  = ALLTRIM(NVL(cursor_4c_LkpCtg.Cods, ""))
      loc_oPag.txt_4c_DCategoria.Value = ALLTRIM(NVL(cursor_4c_LkpCtg.Descs, ""))
    ENDIF

    IF USED("cursor_4c_LkpCtg")
      USE IN cursor_4c_LkpCtg
    ENDIF
    loc_oForm.Release()
    loc_oPag = .NULL.
  ENDPROC

  PROCEDURE AbrirLookupPromocao
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Promo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigPrPmc", "cursor_4c_LkpPmc", "promos", loc_cVal, "Promo" + CHR(231) + CHR(227) + "o")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("promos", "", "Promo" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPmc.promos)
    ELSE
      loc_oPag.txt_4c_Promo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpPmc")
      USE IN cursor_4c_LkpPmc
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupLista
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Lista.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdLpc", "cursor_4c_LkpLpc", "lprecos", loc_cVal, ;
      "Lista de Pre" + CHR(231) + "os")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("lprecos", "", "Lista")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Lista.Value = ALLTRIM(cursor_4c_LkpLpc.lprecos)
    ELSE
      loc_oPag.txt_4c_Lista.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpLpc")
      USE IN cursor_4c_LkpLpc
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupFornecedor
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdFornec.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpForn", "Iclis", loc_cVal, "Fornecedor")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Fornecedor")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdFornec.Value = ALLTRIM(cursor_4c_LkpForn.Iclis)
      loc_oPag.txt_4c_DsFornec.Value = ALLTRIM(cursor_4c_LkpForn.Rclis)
    ELSE
      loc_oPag.txt_4c_CdFornec.Value = ""
      loc_oPag.txt_4c_DsFornec.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpForn")
      USE IN cursor_4c_LkpForn
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupEmpresa(par_cCampo, par_cCampoDes)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl, loc_cCtrlD
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cCtrl = "txt_4c_" + par_cCampo
    loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdEmp", "cursor_4c_LkpEmp", "Cemps", loc_cVal, "Empresa")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Razas", "", "Empresa")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpEmp.Cemps)
      IF NOT EMPTY(par_cCampoDes)
        loc_cCtrlD = "txt_4c_" + par_cCampoDes
        loc_oPag.&loc_cCtrlD..Value = ALLTRIM(cursor_4c_LkpEmp.Razas)
      ENDIF
    ELSE
      loc_oPag.&loc_cCtrl..Value = ""
      IF NOT EMPTY(par_cCampoDes)
        loc_cCtrlD = "txt_4c_" + par_cCampoDes
        loc_oPag.&loc_cCtrlD..Value = ""
      ENDIF
    ENDIF
    IF USED("cursor_4c_LkpEmp")
      USE IN cursor_4c_LkpEmp
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupoCC
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_GrupoCC.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descrs",  "", "Grupo C/C")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_GrupoCC.Value  = ALLTRIM(cursor_4c_LkpGcr.codigos)
      loc_oPag.txt_4c_NGrupoCC.Value = ALLTRIM(cursor_4c_LkpGcr.descrs)
    ELSE
      loc_oPag.txt_4c_GrupoCC.Value  = ""
      loc_oPag.txt_4c_NGrupoCC.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGcr")
      USE IN cursor_4c_LkpGcr
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupContaCC
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdConta.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpConta", "Iclis", loc_cVal, "Conta Corrente")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Conta")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_LkpConta.Iclis)
      loc_oPag.txt_4c_NConta.Value  = ALLTRIM(cursor_4c_LkpConta.Rclis)
    ELSE
      loc_oPag.txt_4c_CdConta.Value = ""
      loc_oPag.txt_4c_NConta.Value  = ""
    ENDIF
    IF USED("cursor_4c_LkpConta")
      USE IN cursor_4c_LkpConta
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupContaFin
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpContaO", "Iclis", loc_cVal, "Conta Financeira")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Conta")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_LkpContaO.Iclis)
      loc_oPag.txt_4c_NContaO.Value = ALLTRIM(cursor_4c_LkpContaO.Rclis)
    ELSE
      loc_oPag.txt_4c_ContaO.Value  = ""
      loc_oPag.txt_4c_NContaO.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpContaO")
      USE IN cursor_4c_LkpContaO
    ENDIF
    loc_oForm.Release()
  ENDPROC

  *------------------------------------------------------------
  *-- GrpLimparFiltrosClick: limpa todos os campos de filtro
  PROCEDURE GrpLimparFiltrosClick
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Produto
      loc_oPag.txt_4c_ProdutoI.Value  = ""
      loc_oPag.txt_4c_ProdutoF.Value  = ""
      loc_oPag.txt_4c_Descricao.Value = ""
      loc_oPag.txt_4c_Descritivo.Value= ""
      loc_oPag.txt_4c_Barra.Value     = ""
      loc_oPag.txt_4c_Equiv.Value     = ""
      loc_oPag.chk_4c_Equiv.Value     = 0

      *-- Situacao / Imagem
      loc_oPag.cmb_4c_Situas.ListIndex = 0
      loc_oPag.cmb_4c_Imagem.ListIndex = 0

      *-- Grupo / SubGrupo
      loc_oPag.txt_4c_Gde.Value      = ""
      loc_oPag.txt_4c_CdGrupo.Value  = ""
      loc_oPag.txt_4c_DsGrupo.Value  = ""
      loc_oPag.txt_4c_CdSGrupo.Value = ""
      loc_oPag.txt_4c_DsSGrupo.Value = ""

      *-- Linha / Colecao
      loc_oPag.txt_4c_LinhaI.Value  = ""
      loc_oPag.txt_4c_LinhaF.Value  = ""
      loc_oPag.txt_4c_GrupoVI.Value = ""
      loc_oPag.txt_4c_GrupoVF.Value = ""

      *-- Descricao completa
      loc_oPag.txt_4c_DCompl.Value = ""

      *-- Pesos
      loc_oPag.txt_4c_PesoI.Value = ""
      loc_oPag.txt_4c_PesoF.Value = ""

      *-- Custo / Venda / Estimado
      loc_oPag.txt_4c_CustoI.Value  = ""
      loc_oPag.txt_4c_CustoF.Value  = ""
      loc_oPag.txt_4c_MoeCusto.Value= ""
      loc_oPag.txt_4c_VendaI.Value  = ""
      loc_oPag.txt_4c_VendaF.Value  = ""
      loc_oPag.txt_4c_MoeVenda.Value= ""
      loc_oPag.txt_4c_EstimI.Value  = ""
      loc_oPag.txt_4c_EstimF.Value  = ""
      loc_oPag.txt_4c_MoeEstim.Value= ""
      loc_oPag.txt_4c_FxPreco.Value = ""

      *-- Cor / Tamanho / Colecao / Classificacao / Modelo
      loc_oPag.txt_4c_Cor.Value     = ""
      loc_oPag.txt_4c_DCor.Value    = ""
      loc_oPag.txt_4c_Tam.Value        = ""
      loc_oPag.txt_4c_DTam.Value       = ""
      loc_oPag.txt_4c_Categoria.Value  = ""
      loc_oPag.txt_4c_DCategoria.Value = ""
      loc_oPag.txt_4c_Classe.Value  = ""
      loc_oPag.txt_4c_CodFinP.Value = ""
      loc_oPag.txt_4c_CodFinPF.Value= ""

      *-- Lista / Promocao
      loc_oPag.txt_4c_Lista.Value = ""
      loc_oPag.txt_4c_Promo.Value = ""

      *-- Fornecedor / Referencia
      loc_oPag.txt_4c_CdFornec.Value  = ""
      loc_oPag.txt_4c_DsFornec.Value  = ""
      loc_oPag.txt_4c_RefFornec.Value = ""
      loc_oPag.txt_4c_RefFornecF.Value= ""
      loc_oPag.opt_4c_TpReffs.Value   = 3

      *-- Datas
      loc_oPag.txt_4c_DtAltI.Value = ""
      loc_oPag.txt_4c_DtAltF.Value = ""
      loc_oPag.opt_4c_TpDtCad.Value = 1

      *-- Empresa / GrupoCC / Conta
      loc_oPag.txt_4c_Emps.Value    = ""
      loc_oPag.txt_4c_DsEmps.Value  = ""
      loc_oPag.txt_4c_GrupoCC.Value = ""
      loc_oPag.txt_4c_NGrupoCC.Value= ""
      loc_oPag.txt_4c_CdConta.Value = ""
      loc_oPag.txt_4c_NConta.Value  = ""
      loc_oPag.txt_4c_ContaO.Value  = ""
      loc_oPag.txt_4c_NContaO.Value = ""

      *-- Produto Web
      loc_oPag.opt_4c_Webs.Value = 5

      *-- Dimensoes
      loc_oPag.txt_4c_Tamps.Value   = ""
      loc_oPag.txt_4c_Tamas.Value   = ""
      loc_oPag.txt_4c_Tamcs.Value   = ""
      loc_oPag.txt_4c_Conjunto.Value= ""

      *-- Localizacao / Cod. Macro / Off (legado Commandgroup1.Click)
      loc_oPag.txt_4c_Locals.Value   = ""
      loc_oPag.txt_4c_CodMacro.Value = ""
      loc_oPag.chk_4c_Off.Value      = 0

      THIS.this_lConsultaExecutada = .F.

    CATCH TO loc_oErro
      MsgErro("Erro ao limpar filtros: " + loc_oErro.Message, "Erro")
    ENDTRY
  ENDPROC

  *============================================================
  *-- FASE 7: EVENTOS OPERACIONAIS PRINCIPAIS
  *============================================================

  *------------------------------------------------------------
  *-- PopularCombos: inicializa combos Situacao e Imagem
  PROTECTED PROCEDURE PopularCombos
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    WITH loc_oPag.cmb_4c_Situas
      .Clear
      .AddItem("Ativos  ")
      .AddItem("Inativos")
      .AddItem("Ambos   ")
      .Value = "Ambos   "
    ENDWITH

    WITH loc_oPag.cmb_4c_Imagem
      .Clear
      .AddItem("c/Imagem")
      .AddItem("s/Imagem")
      .AddItem("Ambos   ")
      .Value = "Ambos   "
    ENDWITH

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- ConfigurarBtnVoltar: cria botao Voltar na pagina de resultados
  PROTECTED PROCEDURE ConfigurarBtnVoltar
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page2

    loc_oPag.AddObject("cmd_4c_Voltar", "CommandButton")
    WITH loc_oPag.cmd_4c_Voltar
      .Top         = 0
      .Left        = 920
      .Width       = 75
      .Height      = 17
      .Caption     = "\<Voltar"
      .FontName    = "Tahoma"
      .FontSize    = 8
      .FontBold    = .T.
      .Visible     = .T.
    ENDWITH

    BINDEVENT(loc_oPag.cmd_4c_Voltar, "Click", THIS, "BtnVoltarClick")
    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BtnVoltarClick: retorna para pagina de filtros
  PROCEDURE BtnVoltarClick
    THIS.Caption = THIS.this_cPrompt
    THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = THIS.Caption
    THIS.AlternarPagina(1)
  ENDPROC

  *------------------------------------------------------------
  *-- KeyPress do Form: F8 ativa busca por LIKE
  PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = -7
      IF VARTYPE(go_4c_Sistema) = "O"
        go_4c_Sistema.BuscaP = .T.
      ENDIF
    ENDIF
    DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
  ENDPROC

  *------------------------------------------------------------
  *-- GrdProdutosAfterRowColChange: carrega detalhes do produto selecionado
  PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
    LOCAL loc_cCodPro, loc_cSQL, loc_nRet, loc_oCab, loc_lProsseguir
    LOCAL loc_cCodGru, loc_cCodSgru, loc_cCodCor
    LOCAL loc_cDsSgrupo, loc_cDsCor
    LOCAL loc_nPrecoDe, loc_nPVenda, loc_dAux, loc_oPagSel, loc_lDescont

    IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
      RETURN
    ENDIF

    SELECT CrProdutos
    IF EOF()
      RETURN
    ENDIF

    loc_cCodPro = ALLTRIM(CrProdutos.cpros)
    IF EMPTY(loc_cCodPro)
      RETURN
    ENDIF

    loc_lProsseguir = .T.
    TRY
      THIS.MousePointer = 11

      *-- Query principal: dados do produto com JOINs
      loc_cSQL = ;
        "Select a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis, " + ;
        "a.ifors, a.reffs, a.qmins, a.pvens, a.moevs, " + ;
        "a.pesoms, a.fcustos, a.moepcs, a.fvendas, a.moepvs, " + ;
        "a.obspeds, a.obspes, a.linhas, a.colecoes, " + ;
        "a.CodCors, a.cproeqs, a.cClass, a.Locals, a.cbars, " + ;
        "a.CodFinP, a.Conjunts, a.Mercs, a.pcuss, a.moecs, " + ;
        "a.situas, a.DPro2s, a.DPro3s, a.Volumes, " + ;
        "a.Categoria, a.CodMacro, a.ObsCompras, a.PrecoDe, " + ;
        "a.dtincs, a.UsuIncs, a.UltComps, a.vUltComps, a.MUltComps, " + ;
        "k.descs As descCtg, " + ;
        "a.pesobs, a.tamps, a.tamhs, a.tamls, a.ProdWebs, " + ;
        "c.rclis, g.dgrus, " + ;
        "b.descs As desccol, l.descs As desclin, " + ;
        "f.descs As descftio, h.descs As descgru " + ;
        "From SigCdPro a " + ;
        "Left Join SigCdGrp g On a.cgrus = g.cgrus " + ;
        "Left Join SigCdCol b On a.colecoes = b.colecoes " + ;
        "Left Join SigCdLin l On a.linhas = l.linhas " + ;
        "Left Join SigPrFti f On a.cftios = f.cods " + ;
        "Left Join SigCdCli c On a.ifors = c.iclis " + ;
        "Left Join SigCdGpr h On a.Mercs = h.codigos " + ;
        "Left Join SigCdCtg k On a.Categoria = k.Cods " + ;
        "Where a.cpros = " + EscaparSQL(loc_cCodPro)

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProd")
      IF loc_nRet < 1
        THIS.MousePointer = 0
        loc_lProsseguir = .F.
      ENDIF

      IF loc_lProsseguir
          SELECT cursor_4c_TmpProd
          IF EOF()
            THIS.MousePointer = 0
            IF USED("cursor_4c_TmpProd")
              USE IN cursor_4c_TmpProd
            ENDIF
            loc_lProsseguir = .F.
          ENDIF
      ENDIF

      IF loc_lProsseguir
          GO TOP IN cursor_4c_TmpProd

      *-- Buscar subgrupo separadamente
          loc_cCodGru  = ALLTRIM(NVL(cursor_4c_TmpProd.cgrus, ""))
          loc_cCodSgru = ALLTRIM(NVL(cursor_4c_TmpProd.sgrus, ""))

          loc_cDsSgrupo = ""
          IF !EMPTY(loc_cCodSgru)
            loc_cSQL = "Select descricaos From SigCdPsg " + ;
              "Where cgrus = " + EscaparSQL(loc_cCodGru) + ;
              " And codigos = " + EscaparSQL(loc_cCodSgru)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSgr") >= 1
              IF USED("cursor_4c_TmpSgr") AND !EOF("cursor_4c_TmpSgr")
                loc_cDsSgrupo = ALLTRIM(NVL(cursor_4c_TmpSgr.descricaos, ""))
              ENDIF
              IF USED("cursor_4c_TmpSgr")
                USE IN cursor_4c_TmpSgr
              ENDIF
            ENDIF
          ENDIF

      *-- Buscar cor separadamente
          loc_cCodCor = ALLTRIM(NVL(cursor_4c_TmpProd.CodCors, ""))

          loc_cDsCor = ""
          IF !EMPTY(loc_cCodCor)
            loc_cSQL = "Select descs From SigCdCor Where Cods = " + ;
              EscaparSQL(loc_cCodCor)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCor") >= 1
              IF USED("cursor_4c_TmpCor") AND !EOF("cursor_4c_TmpCor")
                loc_cDsCor = ALLTRIM(NVL(cursor_4c_TmpCor.descs, ""))
              ENDIF
              IF USED("cursor_4c_TmpCor")
                USE IN cursor_4c_TmpCor
              ENDIF
            ENDIF
          ENDIF

      *-- Preencher campos do cabecalho
          loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

      *-- Fornecedor
          loc_oCab.txt_4c__cd_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.ifors, ""))
          loc_oCab.txt_4c__ds_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.rclis, ""))

      *-- Ref. Fornecedor
          loc_oCab.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.reffs, ""))

      *-- Grupo
          loc_oCab.txt_4c__cd_grupo.Value = loc_cCodGru
          loc_oCab.txt_4c__ds_grupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.dgrus, ""))

      *-- Subgrupo
          loc_oCab.txt_4c__cd_sgrupo.Value = loc_cCodSgru
          loc_oCab.txt_4c__ds_sgrupo.Value = loc_cDsSgrupo

      *-- Linha
          loc_oCab.txt_4c_CdLinha.Value = ALLTRIM(NVL(cursor_4c_TmpProd.linhas, ""))
          loc_oCab.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_TmpProd.desclin, ""))

      *-- Grupo de Venda
          loc_oCab.txt_4c_GrVenda.Value  = ALLTRIM(NVL(cursor_4c_TmpProd.colecoes, ""))
          loc_oCab.txt_4c_GrDvenda.Value = ALLTRIM(NVL(cursor_4c_TmpProd.desccol, ""))

      *-- Unidade
          loc_oCab.txt_4c__cd_unidade.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cunis, ""))

      *-- Grande Grupo
          loc_oCab.txt_4c__cd_ggrupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.Mercs, ""))
          loc_oCab.txt_4c__ds_ggrupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.descgru, ""))

      *-- Modelo / Finalizador
          loc_oCab.txt_4c_CodFinP.Value = ALLTRIM(NVL(cursor_4c_TmpProd.CodFinP, ""))
          loc_oCab.txt_4c_DesFinP.Value = ALLTRIM(NVL(cursor_4c_TmpProd.descftio, ""))

      *-- Conjunto
          loc_oCab.txt_4c_Conjunto.Value = ALLTRIM(STR(NVL(cursor_4c_TmpProd.Conjunts, 0)))

      *-- Equivalente
          loc_oCab.txt_4c_Equivalente.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cproeqs, ""))

      *-- Qtd Minima
          loc_oCab.txt_4c__qtd_minima.Value = NVL(cursor_4c_TmpProd.qmins, 0)

      *-- Cod Barras
          loc_oCab.txt_4c_VBars.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cbars, ""))

      *-- Cor
          loc_oCab.txt_4c_CodCorR.Value  = loc_cCodCor
          loc_oCab.txt_4c_DescCorR.Value = loc_cDsCor

      *-- Classificacao
          loc_oCab.txt_4c_ClassifR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cClass, ""))

      *-- Preco Venda
          loc_oCab.txt_4c_PrVendaR.Value  = NVL(cursor_4c_TmpProd.pvens, 0)
          loc_oCab.txt_4c_MoePrVR.Value   = ALLTRIM(NVL(cursor_4c_TmpProd.moevs, ""))

      *-- Peso Medio
          loc_oCab.txt_4c_PesoMedioR.Value = NVL(cursor_4c_TmpProd.pesoms, 0)

      *-- Fator Venda
          loc_oCab.txt_4c_FatorVR.Value   = NVL(cursor_4c_TmpProd.fvendas, 0)
          loc_oCab.txt_4c_MoeFatorR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.moepvs, ""))

      *-- Locais
          loc_oCab.txt_4c_LocaisR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.Locals, ""))

      *-- Obs. 1 e 2 (legado: Get_Observacao1 = obspes, Get_Observacao2 = obspeds)
          loc_oCab.txt_4c_Obs1R.Value = ALLTRIM(NVL(cursor_4c_TmpProd.obspes, ""))
          loc_oCab.txt_4c_Obs2R.Value = ALLTRIM(NVL(cursor_4c_TmpProd.obspeds, ""))

      *-- Descritivo (getDPro2s)
          loc_oCab.txt_4c_DPro2s.Value = ALLTRIM(NVL(cursor_4c_TmpProd.DPro2s, ""))

      *-- Categoria / Colecao (Get_CdCategoria / Get_DsCategoria)
          loc_oCab.txt_4c_CdCategoriaR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.Categoria, ""))
          loc_oCab.txt_4c_DsCategoriaR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.descCtg, ""))

      *-- Cod. Macro (getCodMacro)
          loc_oCab.txt_4c_CodMacroR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.CodMacro, ""))

      *-- Preco De e percentual de desconto (get_PrecoDe / getPerDesc)
      *-- Formula transcrita do legado (grd_produtos.AfterRowColChange): com
      *-- PrecoDe e pvens ambos preenchidos -> ((pvens / PrecoDe) * 100) - 100;
      *-- caso contrario -> 0.
          loc_nPrecoDe = NVL(cursor_4c_TmpProd.PrecoDe, 0)
          loc_nPVenda  = NVL(cursor_4c_TmpProd.pvens, 0)
          loc_oCab.txt_4c_PrecoDeR.Value = loc_nPrecoDe
          IF loc_nPrecoDe <> 0 AND loc_nPVenda <> 0
            loc_oCab.txt_4c_PerDescR.Value = ((loc_nPVenda / loc_nPrecoDe) * 100) - 100
          ELSE
            loc_oCab.txt_4c_PerDescR.Value = 0
          ENDIF

      *-- Inclusao e ultima compra (cntDados1 do legado)
          loc_dAux = NVL(cursor_4c_TmpProd.dtincs, {})
          loc_oCab.txt_4c_DtInclusaoR.Value = IIF(EMPTY(loc_dAux), "", ;
            DTOC(ConverterParaData(loc_dAux)))
          loc_oCab.txt_4c_UsuIncR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.UsuIncs, ""))

          loc_dAux = NVL(cursor_4c_TmpProd.UltComps, {})
          loc_oCab.txt_4c_DtUltCompR.Value = IIF(EMPTY(loc_dAux), "", ;
            DTOC(ConverterParaData(loc_dAux)))
          loc_oCab.txt_4c_VlUltCompR.Value  = NVL(cursor_4c_TmpProd.vUltComps, 0)
          loc_oCab.txt_4c_MoeUltCompR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.MUltComps, ""))

      *-- Memos: Obs. de Compras e Descritivo complementar
          loc_oPagSel = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1
          loc_oPagSel.edt_4c_ObsCompras.Value = ALLTRIM(NVL(cursor_4c_TmpProd.ObsCompras, ""))
          loc_oPagSel.edt_4c_DPro3s.Value     = ALLTRIM(NVL(cursor_4c_TmpProd.DPro3s, ""))

      *-- Indicador de produto descontinuado (legado Shape1 + Say12, situas = 2)
          loc_lDescont = (NVL(cursor_4c_TmpProd.situas, 0) = 2)
          loc_oPagSel.shp_4c_Descontinuado.Visible = loc_lDescont
          loc_oPagSel.lbl_4c_Descontinuado.Visible = loc_lDescont
          loc_oPagSel = .NULL.

      *-- Atualizar legenda com codigo do produto
          THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = ;
            THIS.this_cPrompt + " - Produto: " + loc_cCodPro + ;
            " - " + ALLTRIM(NVL(cursor_4c_TmpProd.dpros, ""))

      *-- Carregar imagem do produto
          THIS.CarregarImagemProduto(loc_cCodPro)

      *-- Liberar cursor temporario
          IF USED("cursor_4c_TmpProd")
            USE IN cursor_4c_TmpProd
          ENDIF

          loc_oCab = .NULL.
          THIS.MousePointer = 0

      ENDIF
    CATCH TO loc_oErro
      THIS.MousePointer = 0
      loc_oCab = .NULL.
      IF USED("cursor_4c_TmpProd")
        USE IN cursor_4c_TmpProd
      ENDIF
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarImagemProduto: carrega imagem JPG do produto
  PROTECTED PROCEDURE CarregarImagemProduto(par_cCodPro)
    LOCAL loc_cSQL, loc_nRet, loc_cArquivo, loc_oImg

    loc_oImg = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.img_4c_FigJpg
    loc_oImg.Picture = ""

    TRY
      loc_cSQL = "Select FigJpgs From SigCdPro " + ;
        "Where cpros = " + EscaparSQL(par_cCodPro)
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpImg")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpImg") AND !EOF("cursor_4c_TmpImg")
        IF !ISNULL(cursor_4c_TmpImg.FigJpgs) AND !EMPTY(cursor_4c_TmpImg.FigJpgs)
          loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
          STRTOFILE(cursor_4c_TmpImg.FigJpgs, loc_cArquivo)
          loc_oImg.Picture = loc_cArquivo
        ENDIF
      ENDIF
      IF USED("cursor_4c_TmpImg")
        USE IN cursor_4c_TmpImg
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: imagem nao disponivel (cursor/SQLEXEC pode falhar, FigJpgs vazio); produto exibe sem foto
    ENDTRY

    loc_oImg = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarCaracteristicas: carrega grid de caracteristicas do filtro
  PROTECTED PROCEDURE CarregarCaracteristicas
    LOCAL loc_cSQL, loc_nRet
    TRY
      loc_cSQL = "Select 0 as marcado, Codigos as cods, " + ;
        "Codigos as descs From SigCrRap"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCaract")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpCaract")
        IF USED("cursor_4c_Caract")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = ""
          SELECT cursor_4c_Caract
          SELECT cursor_4c_Caract
          ZAP
          APPEND FROM DBF("cursor_4c_TmpCaract")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.ColumnCount = 2
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.ControlSource  = "cursor_4c_Caract.marcado"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.Header1.Caption = ""
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.ControlSource  = "cursor_4c_Caract.descs"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.Header1.Caption = "Caracter" + CHR(237) + "stica"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Refresh()
        ENDIF
        USE IN cursor_4c_TmpCaract
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: caracteristicas nao disponiveis para o produto; grid permanece vazio sem dialog
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarTiposOperacao: carrega grid de tipos de operacao
  PROTECTED PROCEDURE CarregarTiposOperacao
    LOCAL loc_cSQL, loc_nRet
    TRY
      loc_cSQL = "Select 0 as marcado, Codigos as ctipo, " + ;
        "Descrs as dtipo From SigCdTom"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTOpe")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpTOpe")
        IF USED("cursor_4c_TOpe")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = ""
          SELECT cursor_4c_TOpe
          SELECT cursor_4c_TOpe
          ZAP
          APPEND FROM DBF("cursor_4c_TmpTOpe")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.ColumnCount = 3
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.ControlSource  = "cursor_4c_TOpe.marcado"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.Header1.Caption = ""
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.ControlSource  = "cursor_4c_TOpe.ctipo"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.Header1.Caption = "C" + CHR(243) + "d"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.ControlSource  = "cursor_4c_TOpe.dtipo"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Refresh()
        ENDIF
        USE IN cursor_4c_TmpTOpe
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: tipos de operacao nao disponiveis para o produto; grid permanece vazio sem dialog
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- MontaStrTpOpe: monta string IN para filtro de tipos de operacao
  PROTECTED PROCEDURE MontaStrTpOpe
    LOCAL loc_cResult
    loc_cResult = ""

    IF !USED("cursor_4c_TOpe")
      RETURN loc_cResult
    ENDIF

    SELECT cursor_4c_TOpe
    SCAN FOR cursor_4c_TOpe.marcado
      IF !EMPTY(loc_cResult)
        loc_cResult = loc_cResult + ","
      ENDIF
      loc_cResult = loc_cResult + "'" + ;
        ALLTRIM(cursor_4c_TOpe.ctipo) + "'"
    ENDSCAN

    RETURN loc_cResult
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarComposicaoFiltro: carrega grid composicao do filtro
  PROTECTED PROCEDURE CarregarComposicaoFiltro
    LOCAL loc_cSQL, loc_nRet

    IF USED("CsMatPrima")
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = ""
      SELECT CsMatPrima
      ZAP IN CsMatPrima
    ENDIF

    TRY
      loc_cSQL = "Select cpros as mats, dpros as dcompos, " + ;
        "0.00 as qtd_inicial, 0.00 as qtd_final, " + ;
        ".F. as apenas, cgrus as Cgrus, '' as Tipos " + ;
        "From SigCdPro Where 1=0"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpMat")
        USE IN cursor_4c_TmpMat
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: SQLEXEC inicial pode falhar (estrutura cursor); CsMatPrima sera populado por consulta real
    ENDTRY

    IF USED("CsMatPrima")
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = "CsMatPrima"
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.Refresh()
    ENDIF
  ENDPROC

  *------------------------------------------------------------
  *-- LimparCamposCabecalho: limpa todos os campos de detalhe do produto
  PROTECTED PROCEDURE LimparCamposCabecalho
    LOCAL loc_oCab

    loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

    TRY
      loc_oCab.txt_4c__cd_fornecedor.Value  = ""
      loc_oCab.txt_4c__ds_fornecedor.Value  = ""
      loc_oCab.txt_4c__ref_fornecedor.Value = ""
      loc_oCab.txt_4c__cd_grupo.Value       = ""
      loc_oCab.txt_4c__ds_grupo.Value       = ""
      loc_oCab.txt_4c__cd_sgrupo.Value      = ""
      loc_oCab.txt_4c__ds_sgrupo.Value      = ""
      loc_oCab.txt_4c_CdLinha.Value         = ""
      loc_oCab.txt_4c_DsLinha.Value         = ""
      loc_oCab.txt_4c_GrVenda.Value         = ""
      loc_oCab.txt_4c_GrDvenda.Value        = ""
      loc_oCab.txt_4c__cd_unidade.Value     = ""
      loc_oCab.txt_4c__cd_ggrupo.Value      = ""
      loc_oCab.txt_4c__ds_ggrupo.Value      = ""
      loc_oCab.txt_4c_CodFinP.Value         = ""
      loc_oCab.txt_4c_DesFinP.Value         = ""
      loc_oCab.txt_4c_Conjunto.Value        = ""
      loc_oCab.txt_4c_Equivalente.Value     = ""
      loc_oCab.txt_4c__qtd_minima.Value     = 0
      loc_oCab.txt_4c_VBars.Value           = ""
      loc_oCab.txt_4c_CodCorR.Value         = ""
      loc_oCab.txt_4c_DescCorR.Value        = ""
      loc_oCab.txt_4c_ClassifR.Value        = ""
      loc_oCab.txt_4c_PrVendaR.Value        = 0
      loc_oCab.txt_4c_MoePrVR.Value         = ""
      loc_oCab.txt_4c_PesoMedioR.Value      = 0
      loc_oCab.txt_4c_FatorVR.Value         = 0
      loc_oCab.txt_4c_MoeFatorR.Value       = ""
      loc_oCab.txt_4c_LocaisR.Value         = ""
      loc_oCab.txt_4c_Obs1R.Value           = ""
      loc_oCab.txt_4c_Obs2R.Value           = ""
      loc_oCab.txt_4c_DPro2s.Value          = ""
      loc_oCab.txt_4c_CdCategoriaR.Value    = ""
      loc_oCab.txt_4c_DsCategoriaR.Value    = ""
      loc_oCab.txt_4c_CodMacroR.Value       = ""
      loc_oCab.txt_4c_PrecoDeR.Value        = 0
      loc_oCab.txt_4c_PerDescR.Value        = 0
      loc_oCab.txt_4c_DtInclusaoR.Value     = ""
      loc_oCab.txt_4c_UsuIncR.Value         = ""
      loc_oCab.txt_4c_DtUltCompR.Value      = ""
      loc_oCab.txt_4c_VlUltCompR.Value      = 0
      loc_oCab.txt_4c_MoeUltCompR.Value     = ""

      WITH THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1
        .img_4c_FigJpg.Picture         = ""
        .edt_4c_ObsCompras.Value       = ""
        .edt_4c_DPro3s.Value           = ""
        .shp_4c_Descontinuado.Visible  = .F.
        .lbl_4c_Descontinuado.Visible  = .F.
      ENDWITH
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho/img_4c_FigJpg podem nao estar instanciados; LimparCampos eh melhor-esforco
    ENDTRY

    loc_oCab = .NULL.
  ENDPROC

  *============================================================
  *-- FASE 7: EVENTOS PRINCIPAIS
  *============================================================
  *-- SIGOPCGP e tela OPERACIONAL de CONSULTA (Pesquisa Global de Produtos),
  *-- nao tela CRUD: o legado (comportamento.json/layout.json, 657 objetos
  *-- mapeados) nao tem botao de Incluir nem de Excluir produto - inclusao e
  *-- exclusao pertencem ao Cadastro de Produtos (SigCdPro/FormProduto).
  *-- BtnIncluirClick/BtnExcluirClick NAO sao criados aqui de proposito -
  *-- seria inventar funcionalidade que o legado nao tem (CLAUDE.md PILAR 1).
  *-- Os dois eventos reais desta tela, equivalentes aos botoes do legado, sao:

  *------------------------------------------------------------
  *-- BtnVisualizarClick: executa a consulta com os filtros informados e
  *-- exibe o resultado - alias de BtnConsultarClick, que e a propria acao
  *-- de "visualizar" produtos nesta tela (legado: Cmd_Consulta.Click).
  PROCEDURE BtnVisualizarClick
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  *-- BtnAlterarClick: habilita a edicao do preco/peso medio/fator do produto
  *-- selecionado na grade. Equivalente ao legado altpreco.Click
  *-- ("Confirma a Alteracao de Preco" + ThisForm.AlteraPreco = .T.), mas sem
  *-- abrir SigCdPro.Scx: os campos editaveis ja estao no proprio cabecalho
  *-- do resultado (txt_4c_PrVendaR/PesoMedioR/FatorVR) e sao gravados por
  *-- BtnSalvarClick - simplificacao de arquitetura (PILAR 3), mesmo
  *-- resultado de negocio do legado.
  PROCEDURE BtnAlterarClick
    LOCAL loc_oCab

    IF !USED("CrProdutos") OR EOF("CrProdutos")
      MsgAviso("Selecione um produto na grade antes de alterar o pre" + CHR(231) + "o.")
      RETURN
    ENDIF

    IF !fChecaAcesso("SIGOPCGP", "ALTPRECO")
      MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para alterar pre" + CHR(231) + "os.")
      RETURN
    ENDIF

    IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o?", "Confirma" + CHR(231) + CHR(227) + "o")
      RETURN
    ENDIF

    THIS.this_lAlteraPreco = .T.

    TRY
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
      loc_oCab.txt_4c_PrVendaR.ReadOnly   = .F.
      loc_oCab.txt_4c_MoePrVR.ReadOnly    = .F.
      loc_oCab.txt_4c_PesoMedioR.ReadOnly = .F.
      loc_oCab.txt_4c_FatorVR.ReadOnly    = .F.
      loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .F.
      loc_oCab.txt_4c_PrVendaR.SetFocus()
      loc_oCab = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho pode nao estar instanciado ainda; ReadOnly e melhor-esforco
    ENDTRY

    THIS.AjustarBotoesPorModo()
  ENDPROC

  *============================================================
  *-- FASE 8: METODOS DE CONSOLIDACAO
  *============================================================

  *------------------------------------------------------------
  *-- BtnBuscarClick: executa busca usando filtros informados (alias de BtnConsultarClick)
  PROCEDURE BtnBuscarClick
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  *-- BtnEncerrarClick: encerra o formulario
  PROCEDURE BtnEncerrarClick
    THIS.Release()
  ENDPROC

  *------------------------------------------------------------
  *-- BtnSalvarClick: salva alteracao de preco do produto selecionado
  PROCEDURE BtnSalvarClick
    LOCAL loc_lSucesso, loc_cCodPro, loc_oCab
    LOCAL loc_cSQL, loc_nRet

    loc_lSucesso = .F.

    IF !THIS.this_lAlteraPreco
      MsgAviso("Altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o n" + CHR(227) + "o habilitada.")
      RETURN
    ENDIF

    IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
      MsgAviso("Nenhum produto selecionado.")
      RETURN
    ENDIF

    SELECT CrProdutos
    IF EOF()
      MsgAviso("Nenhum produto selecionado.")
      RETURN
    ENDIF

    loc_cCodPro = ALLTRIM(CrProdutos.cpros)
    IF EMPTY(loc_cCodPro)
      MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o identificado.")
      RETURN
    ENDIF

    loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

    TRY
      *-- Recarregar dados atuais do produto do banco para nao perder campos nao editaveis
      loc_cSQL = "SELECT dpros, cgrus, sgrus, cunis, ifors, reffs, " + ;
        "pcuss, moecs, pesoms, fcustos, margems, pvens, valors " + ;
        "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSalvar")

      IF loc_nRet >= 1 AND USED("cursor_4c_TmpSalvar") AND !EOF("cursor_4c_TmpSalvar")
        GO TOP IN cursor_4c_TmpSalvar

        THIS.this_oBusinessObject.this_cCodPro        = loc_cCodPro
        THIS.this_oBusinessObject.this_cDescPro       = ALLTRIM(NVL(cursor_4c_TmpSalvar.dpros,   ""))
        THIS.this_oBusinessObject.this_cGrupoPro      = ALLTRIM(NVL(cursor_4c_TmpSalvar.cgrus,   ""))
        THIS.this_oBusinessObject.this_cSubGrupoPro   = ALLTRIM(NVL(cursor_4c_TmpSalvar.sgrus,   ""))
        THIS.this_oBusinessObject.this_cUnidadePro    = ALLTRIM(NVL(cursor_4c_TmpSalvar.cunis,   ""))
        THIS.this_oBusinessObject.this_cFornecedorPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.ifors,   ""))
        THIS.this_oBusinessObject.this_cRefPro        = ALLTRIM(NVL(cursor_4c_TmpSalvar.reffs,   ""))
        THIS.this_oBusinessObject.this_nPrecoCusto    = NVL(cursor_4c_TmpSalvar.pcuss,   0)
        THIS.this_oBusinessObject.this_cMoedaCustoPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.moecs,   ""))
        THIS.this_oBusinessObject.this_nMargem        = NVL(cursor_4c_TmpSalvar.margems, 0)
        THIS.this_oBusinessObject.this_nCustoEstimado = NVL(cursor_4c_TmpSalvar.valors,  0)

        *-- Campos editaveis pelo usuario (preco, peso, fator)
        THIS.this_oBusinessObject.this_nPrecoVenda  = NVL(loc_oCab.txt_4c_PrVendaR.Value,   0)
        THIS.this_oBusinessObject.this_nPesoMedio   = NVL(loc_oCab.txt_4c_PesoMedioR.Value, 0)
        THIS.this_oBusinessObject.this_nFatorCusto  = NVL(loc_oCab.txt_4c_FatorVR.Value,    0)

        IF USED("cursor_4c_TmpSalvar")
          USE IN cursor_4c_TmpSalvar
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

        IF loc_lSucesso
          MsgInfo("Pre" + CHR(231) + "o atualizado com sucesso.")
          *-- Restaurar ReadOnly nos campos de preco apos salvar
          loc_oCab.txt_4c_PrVendaR.ReadOnly   = .T.
          loc_oCab.txt_4c_MoePrVR.ReadOnly    = .T.
          loc_oCab.txt_4c_PesoMedioR.ReadOnly = .T.
          loc_oCab.txt_4c_FatorVR.ReadOnly    = .T.
          loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .T.
          THIS.this_lAlteraPreco = .F.
          THIS.AjustarBotoesPorModo()
        ELSE
          IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
          MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
          ENDIF
        ENDIF
      ELSE
        IF USED("cursor_4c_TmpSalvar")
          USE IN cursor_4c_TmpSalvar
        ENDIF
        MsgErro("Produto n" + CHR(227) + "o encontrado no banco de dados.", "Erro")
      ENDIF

    CATCH TO loc_oErro
      MsgErro("Erro ao salvar: " + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_TmpSalvar")
        USE IN cursor_4c_TmpSalvar
      ENDIF
    ENDTRY

    loc_oCab = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- FormParaBO: copia todos os campos do formulario para propriedades do BO
  *-- Nomenclatura das properties segue EXATAMENTE a declaracao em sigopcgpBO.prg
  PROTECTED PROCEDURE FormParaBO
    LOCAL loc_oPag, loc_oBO
    LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF
    LOCAL loc_cEstimI, loc_cEstimF, loc_cVendaI, loc_cVendaF
    LOCAL loc_cTamps, loc_cTamas, loc_cTamcs

    IF VARTYPE(THIS.this_oBusinessObject) != "O"
      RETURN
    ENDIF

    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_oBO  = THIS.this_oBusinessObject

    TRY
      *-- Produto / Descricao / Descritivo / Descr. Completa / Barra
      loc_oBO.this_cProdutoInicial = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
      loc_oBO.this_cProdutoFinal   = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
      loc_oBO.this_cDescricao      = ALLTRIM(loc_oPag.txt_4c_Descricao.Value)
      loc_oBO.this_cDescritivo     = ALLTRIM(loc_oPag.txt_4c_Descritivo.Value)
      loc_oBO.this_cDCompl         = ALLTRIM(loc_oPag.txt_4c_DCompl.Value)
      loc_oBO.this_nBarra          = ALLTRIM(loc_oPag.txt_4c_Barra.Value)

      *-- Equivalente
      loc_oBO.this_lEquivalentes = (loc_oPag.chk_4c_Equiv.Value = 1)
      loc_oBO.this_cEquivalente  = ALLTRIM(loc_oPag.txt_4c_Equiv.Value)

      *-- Grupo / SubGrupo / Grande Grupo / Linha / Colecao (Grupo de Venda)
      loc_oBO.this_cGde      = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
      loc_oBO.this_cCdGrupo  = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
      loc_oBO.this_cDsGrupo  = ALLTRIM(loc_oPag.txt_4c_DsGrupo.Value)
      loc_oBO.this_cCdSGrupo = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
      loc_oBO.this_cDsSGrupo = ALLTRIM(loc_oPag.txt_4c_DsSGrupo.Value)
      loc_oBO.this_cLinhaI   = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
      loc_oBO.this_cLinhaF   = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
      loc_oBO.this_cColecaoI = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
      loc_oBO.this_cColecaoF = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)

      *-- Peso (faixa)
      loc_cPesoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoI.Value), ",", "")
      loc_cPesoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoF.Value), ",", "")
      loc_oBO.this_nPesoInicial = VAL(loc_cPesoI)
      loc_oBO.this_nPesoFinal   = VAL(loc_cPesoF)

      *-- Cor
      loc_oBO.this_cCor  = ALLTRIM(loc_oPag.txt_4c_Cor.Value)
      loc_oBO.this_cDCor = ALLTRIM(loc_oPag.txt_4c_DCor.Value)

      *-- Tamanho + dimensoes (profundidade / altura / comprimento)
      loc_oBO.this_cTam  = ALLTRIM(loc_oPag.txt_4c_Tam.Value)
      loc_oBO.this_cDTam = ALLTRIM(loc_oPag.txt_4c_DTam.Value)
      loc_cTamps = STRTRAN(ALLTRIM(loc_oPag.txt_4c_Tamps.Value), ",", "")
      loc_cTamas = STRTRAN(ALLTRIM(loc_oPag.txt_4c_Tamas.Value), ",", "")
      loc_cTamcs = STRTRAN(ALLTRIM(loc_oPag.txt_4c_Tamcs.Value), ",", "")
      loc_oBO.this_nTamProf = VAL(loc_cTamps)
      loc_oBO.this_nTamAlt  = VAL(loc_cTamas)
      loc_oBO.this_nTamComp = VAL(loc_cTamcs)

      *-- Categoria (Colecao) / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de valor
      loc_oBO.this_cCategoria  = ALLTRIM(loc_oPag.txt_4c_Categoria.Value)
      loc_oBO.this_cDCategoria = ALLTRIM(loc_oPag.txt_4c_DCategoria.Value)
      loc_oBO.this_cConjunto   = ALLTRIM(loc_oPag.txt_4c_Conjunto.Value)
      loc_oBO.this_cClasse     = ALLTRIM(loc_oPag.txt_4c_Classe.Value)
      loc_oBO.this_cCodFinPI   = ALLTRIM(loc_oPag.txt_4c_CodFinP.Value)
      loc_oBO.this_cCodFinPF   = ALLTRIM(loc_oPag.txt_4c_CodFinPF.Value)
      loc_oBO.this_cFxPreco    = ALLTRIM(loc_oPag.txt_4c_FxPreco.Value)
      loc_oBO.this_cLocais     = ALLTRIM(loc_oPag.txt_4c_Locals.Value)
      loc_oBO.this_cCodMacro   = ALLTRIM(loc_oPag.txt_4c_CodMacro.Value)

      *-- CPF/CGC, Situacao, Imagem, Produto Web, Off (fora de linha)
      loc_oBO.this_cCPF        = ALLTRIM(loc_oPag.txt_4c_CPF.Value)
      loc_oBO.this_cSituacao   = ALLTRIM(loc_oPag.cmb_4c_Situas.Value)
      loc_oBO.this_cImagem     = ALLTRIM(loc_oPag.cmb_4c_Imagem.Value)
      loc_oBO.this_nProdutoWeb = loc_oPag.opt_4c_Webs.Value
      loc_oBO.this_lOff        = (loc_oPag.chk_4c_Off.Value = 1)

      *-- Fornecedor / Referencia / Lista de precos / Promocao
      loc_oBO.this_cCdFornecedor   = ALLTRIM(loc_oPag.txt_4c_CdFornec.Value)
      loc_oBO.this_cDsFornecedor   = ALLTRIM(loc_oPag.txt_4c_DsFornec.Value)
      loc_oBO.this_cRefFornecedor  = ALLTRIM(loc_oPag.txt_4c_RefFornec.Value)
      loc_oBO.this_cRefFornecedorF = ALLTRIM(loc_oPag.txt_4c_RefFornecF.Value)
      loc_oBO.this_nTpReffs        = loc_oPag.opt_4c_TpReffs.Value
      loc_oBO.this_cLista          = ALLTRIM(loc_oPag.txt_4c_Lista.Value)
      loc_oBO.this_cPromo          = ALLTRIM(loc_oPag.txt_4c_Promo.Value)

      *-- Faixas de valor (custo / estimado / venda) + moeda
      loc_cCustoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoI.Value), ",", "")
      loc_cCustoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoF.Value), ",", "")
      loc_oBO.this_nCustoInicial = VAL(loc_cCustoI)
      loc_oBO.this_nCustoFinal   = VAL(loc_cCustoF)
      loc_oBO.this_cMoeCusto     = ALLTRIM(loc_oPag.txt_4c_MoeCusto.Value)

      loc_cEstimI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_EstimI.Value), ",", "")
      loc_cEstimF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_EstimF.Value), ",", "")
      loc_oBO.this_nEstimadoInicial = VAL(loc_cEstimI)
      loc_oBO.this_nEstimadoFinal   = VAL(loc_cEstimF)
      loc_oBO.this_cMoeEstimado     = ALLTRIM(loc_oPag.txt_4c_MoeEstim.Value)

      loc_cVendaI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_VendaI.Value), ",", "")
      loc_cVendaF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_VendaF.Value), ",", "")
      loc_oBO.this_nVendaInicial = VAL(loc_cVendaI)
      loc_oBO.this_nVendaFinal   = VAL(loc_cVendaF)
      loc_oBO.this_cMoeVenda     = ALLTRIM(loc_oPag.txt_4c_MoeVenda.Value)

      *-- Empresa / Operacao / Periodo
      loc_oBO.this_cEmpresa      = ALLTRIM(loc_oPag.txt_4c_Emps.Value)
      loc_oBO.this_cDEmpresa     = ALLTRIM(loc_oPag.txt_4c_DsEmps.Value)
      loc_oBO.this_cEmpresaOpe   = ALLTRIM(loc_oPag.txt_4c_EmpsO.Value)
      loc_oBO.this_cOperacaoI    = ALLTRIM(loc_oPag.txt_4c_OperacaoI.Value)
      loc_oBO.this_cOperacaoF    = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
      loc_oBO.this_nTipoOperacao = loc_oPag.opt_4c_Operacao.Value
      loc_oBO.this_nTipoData     = loc_oPag.opt_4c_TpData.Value
      loc_oBO.this_nTipoDataCad  = loc_oPag.opt_4c_TpDtCad.Value
      loc_oBO.this_nFormaPagto   = loc_oPag.opt_4c_Pagamento.Value
      loc_oBO.this_lMarcaTOpe    = (loc_oPag.chk_4c_MarcaTOpe.Value = 1)
      loc_oBO.this_dDtOperacaoI  = CTOD(ALLTRIM(loc_oPag.txt_4c_DtOpeI.Value))
      loc_oBO.this_dDtOperacaoF  = CTOD(ALLTRIM(loc_oPag.txt_4c_DtOpeF.Value))
      loc_oBO.this_dDtAlteracaoI = CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltI.Value))
      loc_oBO.this_dDtAlteracaoF = CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltF.Value))

      *-- Grupo/Conta contabil (C.C.) e Conta de origem/destino do movimento
      loc_oBO.this_cCdGrupoContab = ALLTRIM(loc_oPag.txt_4c_GrupoCC.Value)
      loc_oBO.this_cDsGrupoContab = ALLTRIM(loc_oPag.txt_4c_NGrupoCC.Value)
      loc_oBO.this_cConta         = ALLTRIM(loc_oPag.txt_4c_CdConta.Value)
      loc_oBO.this_cDConta        = ALLTRIM(loc_oPag.txt_4c_NConta.Value)
      loc_oBO.this_cContaO        = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
      loc_oBO.this_cDContaO       = ALLTRIM(loc_oPag.txt_4c_NContaO.Value)

    CATCH TO loc_oErro
      MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oPag = .NULL.
    loc_oBO  = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BOParaForm: copia propriedades do BO para os campos do formulario
  *-- Nomenclatura das properties segue EXATAMENTE a declaracao em sigopcgpBO.prg
  PROTECTED PROCEDURE BOParaForm
    LOCAL loc_oPag, loc_oBO

    IF VARTYPE(THIS.this_oBusinessObject) != "O"
      RETURN
    ENDIF

    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_oBO  = THIS.this_oBusinessObject

    TRY
      *-- Produto / Descricao / Descritivo / Descr. Completa / Barra
      loc_oPag.txt_4c_ProdutoI.Value   = loc_oBO.this_cProdutoInicial
      loc_oPag.txt_4c_ProdutoF.Value   = loc_oBO.this_cProdutoFinal
      loc_oPag.txt_4c_Descricao.Value  = loc_oBO.this_cDescricao
      loc_oPag.txt_4c_Descritivo.Value = loc_oBO.this_cDescritivo
      loc_oPag.txt_4c_DCompl.Value     = loc_oBO.this_cDCompl
      loc_oPag.txt_4c_Barra.Value      = IIF(loc_oBO.this_nBarra = 0, "", ALLTRIM(STR(loc_oBO.this_nBarra, 14)))

      *-- Equivalente
      loc_oPag.txt_4c_Equiv.Value = loc_oBO.this_cEquivalente
      loc_oPag.chk_4c_Equiv.Value = IIF(loc_oBO.this_lEquivalentes, 1, 0)

      *-- Grupo / SubGrupo / Grande Grupo / Linha / Colecao (Grupo de Venda)
      loc_oPag.txt_4c_Gde.Value      = loc_oBO.this_cGde
      loc_oPag.txt_4c_CdGrupo.Value  = loc_oBO.this_cCdGrupo
      loc_oPag.txt_4c_DsGrupo.Value  = loc_oBO.this_cDsGrupo
      loc_oPag.txt_4c_CdSGrupo.Value = loc_oBO.this_cCdSGrupo
      loc_oPag.txt_4c_DsSGrupo.Value = loc_oBO.this_cDsSGrupo
      loc_oPag.txt_4c_LinhaI.Value   = loc_oBO.this_cLinhaI
      loc_oPag.txt_4c_LinhaF.Value   = loc_oBO.this_cLinhaF
      loc_oPag.txt_4c_GrupoVI.Value  = loc_oBO.this_cColecaoI
      loc_oPag.txt_4c_GrupoVF.Value  = loc_oBO.this_cColecaoF

      *-- Peso (faixa)
      loc_oPag.txt_4c_PesoI.Value = TRANSFORM(loc_oBO.this_nPesoInicial)
      loc_oPag.txt_4c_PesoF.Value = TRANSFORM(loc_oBO.this_nPesoFinal)

      *-- Cor
      loc_oPag.txt_4c_Cor.Value  = loc_oBO.this_cCor
      loc_oPag.txt_4c_DCor.Value = loc_oBO.this_cDCor

      *-- Tamanho + dimensoes (profundidade / altura / comprimento)
      loc_oPag.txt_4c_Tam.Value   = loc_oBO.this_cTam
      loc_oPag.txt_4c_DTam.Value  = loc_oBO.this_cDTam
      loc_oPag.txt_4c_Tamps.Value = TRANSFORM(loc_oBO.this_nTamProf)
      loc_oPag.txt_4c_Tamas.Value = TRANSFORM(loc_oBO.this_nTamAlt)
      loc_oPag.txt_4c_Tamcs.Value = TRANSFORM(loc_oBO.this_nTamComp)

      *-- Categoria (Colecao) / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de valor
      loc_oPag.txt_4c_Categoria.Value  = loc_oBO.this_cCategoria
      loc_oPag.txt_4c_DCategoria.Value = loc_oBO.this_cDCategoria
      loc_oPag.txt_4c_Conjunto.Value   = loc_oBO.this_cConjunto
      loc_oPag.txt_4c_Classe.Value     = loc_oBO.this_cClasse
      loc_oPag.txt_4c_CodFinP.Value    = loc_oBO.this_cCodFinPI
      loc_oPag.txt_4c_CodFinPF.Value   = loc_oBO.this_cCodFinPF
      loc_oPag.txt_4c_FxPreco.Value    = loc_oBO.this_cFxPreco
      loc_oPag.txt_4c_Locals.Value     = loc_oBO.this_cLocais
      loc_oPag.txt_4c_CodMacro.Value   = loc_oBO.this_cCodMacro

      *-- CPF/CGC, Situacao, Imagem, Produto Web, Off (fora de linha)
      loc_oPag.txt_4c_CPF.Value     = loc_oBO.this_cCPF
      loc_oPag.cmb_4c_Situas.Value  = loc_oBO.this_cSituacao
      loc_oPag.cmb_4c_Imagem.Value  = loc_oBO.this_cImagem
      loc_oPag.opt_4c_Webs.Value    = IIF(BETWEEN(loc_oBO.this_nProdutoWeb, 1, 5), loc_oBO.this_nProdutoWeb, 5)
      loc_oPag.chk_4c_Off.Value     = IIF(loc_oBO.this_lOff, 1, 0)

      *-- Fornecedor / Referencia / Lista de precos / Promocao
      loc_oPag.txt_4c_CdFornec.Value   = loc_oBO.this_cCdFornecedor
      loc_oPag.txt_4c_DsFornec.Value   = loc_oBO.this_cDsFornecedor
      loc_oPag.txt_4c_RefFornec.Value  = loc_oBO.this_cRefFornecedor
      loc_oPag.txt_4c_RefFornecF.Value = loc_oBO.this_cRefFornecedorF
      loc_oPag.opt_4c_TpReffs.Value    = IIF(BETWEEN(loc_oBO.this_nTpReffs, 1, 3), loc_oBO.this_nTpReffs, 1)
      loc_oPag.txt_4c_Lista.Value      = loc_oBO.this_cLista
      loc_oPag.txt_4c_Promo.Value      = loc_oBO.this_cPromo

      *-- Faixas de valor (custo / estimado / venda) + moeda
      loc_oPag.txt_4c_CustoI.Value   = TRANSFORM(loc_oBO.this_nCustoInicial)
      loc_oPag.txt_4c_CustoF.Value   = TRANSFORM(loc_oBO.this_nCustoFinal)
      loc_oPag.txt_4c_MoeCusto.Value = loc_oBO.this_cMoeCusto

      loc_oPag.txt_4c_EstimI.Value   = TRANSFORM(loc_oBO.this_nEstimadoInicial)
      loc_oPag.txt_4c_EstimF.Value   = TRANSFORM(loc_oBO.this_nEstimadoFinal)
      loc_oPag.txt_4c_MoeEstim.Value = loc_oBO.this_cMoeEstimado

      loc_oPag.txt_4c_VendaI.Value   = TRANSFORM(loc_oBO.this_nVendaInicial)
      loc_oPag.txt_4c_VendaF.Value   = TRANSFORM(loc_oBO.this_nVendaFinal)
      loc_oPag.txt_4c_MoeVenda.Value = loc_oBO.this_cMoeVenda

      *-- Empresa / Operacao / Periodo
      loc_oPag.txt_4c_Emps.Value       = loc_oBO.this_cEmpresa
      loc_oPag.txt_4c_DsEmps.Value      = loc_oBO.this_cDEmpresa
      loc_oPag.txt_4c_EmpsO.Value       = loc_oBO.this_cEmpresaOpe
      loc_oPag.txt_4c_OperacaoI.Value   = loc_oBO.this_cOperacaoI
      loc_oPag.txt_4c_Operacao.Value    = loc_oBO.this_cOperacaoF
      loc_oPag.opt_4c_Operacao.Value    = IIF(BETWEEN(loc_oBO.this_nTipoOperacao, 1, 3), loc_oBO.this_nTipoOperacao, 3)
      loc_oPag.opt_4c_TpData.Value      = IIF(BETWEEN(loc_oBO.this_nTipoData, 1, 2), loc_oBO.this_nTipoData, 1)
      loc_oPag.opt_4c_TpDtCad.Value     = IIF(BETWEEN(loc_oBO.this_nTipoDataCad, 1, 2), loc_oBO.this_nTipoDataCad, 1)
      loc_oPag.opt_4c_Pagamento.Value   = IIF(BETWEEN(loc_oBO.this_nFormaPagto, 1, 3), loc_oBO.this_nFormaPagto, 3)
      loc_oPag.chk_4c_MarcaTOpe.Value   = IIF(loc_oBO.this_lMarcaTOpe, 1, 0)
      loc_oPag.txt_4c_DtOpeI.Value  = IIF(EMPTY(loc_oBO.this_dDtOperacaoI), "", DTOC(loc_oBO.this_dDtOperacaoI))
      loc_oPag.txt_4c_DtOpeF.Value  = IIF(EMPTY(loc_oBO.this_dDtOperacaoF), "", DTOC(loc_oBO.this_dDtOperacaoF))
      loc_oPag.txt_4c_DtAltI.Value  = IIF(EMPTY(loc_oBO.this_dDtAlteracaoI), "", DTOC(loc_oBO.this_dDtAlteracaoI))
      loc_oPag.txt_4c_DtAltF.Value  = IIF(EMPTY(loc_oBO.this_dDtAlteracaoF), "", DTOC(loc_oBO.this_dDtAlteracaoF))

      *-- Grupo/Conta contabil (C.C.) e Conta de origem/destino do movimento
      loc_oPag.txt_4c_GrupoCC.Value  = loc_oBO.this_cCdGrupoContab
      loc_oPag.txt_4c_NGrupoCC.Value = loc_oBO.this_cDsGrupoContab
      loc_oPag.txt_4c_CdConta.Value  = loc_oBO.this_cConta
      loc_oPag.txt_4c_NConta.Value   = loc_oBO.this_cDConta
      loc_oPag.txt_4c_ContaO.Value   = loc_oBO.this_cContaO
      loc_oPag.txt_4c_NContaO.Value  = loc_oBO.this_cDContaO

    CATCH TO loc_oErro
      MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oPag = .NULL.
    loc_oBO  = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- HabilitarCampos: habilita/desabilita controles conforme permissao de alteracao de preco
  PROTECTED PROCEDURE HabilitarCampos
    LOCAL loc_oPag, loc_lPode, loc_oCab

    loc_lPode = THIS.this_lAlteraPreco
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Filtros de consulta sempre habilitados
      loc_oPag.txt_4c_ProdutoI.Enabled  = .T.
      loc_oPag.txt_4c_ProdutoF.Enabled  = .T.
      loc_oPag.txt_4c_Descricao.Enabled = .T.
      loc_oPag.txt_4c_Descritivo.Enabled = .T.
      loc_oPag.txt_4c_Barra.Enabled     = .T.
      loc_oPag.txt_4c_Equiv.Enabled     = .T.
      loc_oPag.chk_4c_Equiv.Enabled     = .T.
      loc_oPag.txt_4c_CdGrupo.Enabled   = .T.
      loc_oPag.txt_4c_CdSGrupo.Enabled  = .T.
      loc_oPag.txt_4c_CdFornec.Enabled  = .T.
      loc_oPag.txt_4c_RefFornec.Enabled = .T.
      loc_oPag.txt_4c_Cor.Enabled       = .T.
    CATCH TO loc_oErro
      *-- INTENCIONAL: filtros podem nao estar instanciados; Enabled eh melhor-esforco
    ENDTRY

    TRY
      *-- Campos de preco no resultado: editaveis somente se lAlteraPreco = .T.
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
      loc_oCab.txt_4c_PrVendaR.ReadOnly   = !loc_lPode
      loc_oCab.txt_4c_MoePrVR.ReadOnly    = !loc_lPode
      loc_oCab.txt_4c_PesoMedioR.ReadOnly = !loc_lPode
      loc_oCab.txt_4c_FatorVR.ReadOnly    = !loc_lPode
      loc_oCab.txt_4c_MoeFatorR.ReadOnly  = !loc_lPode
      loc_oCab = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho de resultado pode nao estar instanciado; ReadOnly eh melhor-esforco
    ENDTRY

    THIS.AjustarBotoesPorModo()

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- LimparCampos: limpa todos os campos de filtro (delega para GrpLimparFiltrosClick)
  PROCEDURE LimparCampos
    THIS.GrpLimparFiltrosClick()
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarLista: executa a consulta e carrega os grids de resultado
  PROCEDURE CarregarLista
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  *-- AjustarBotoesPorModo: habilita/desabilita botoes de acao conforme permissoes e estado
  PROCEDURE AjustarBotoesPorModo
    LOCAL loc_oCnt, loc_lHabilitar

    loc_lHabilitar = THIS.this_lAlteraPreco AND THIS.this_lConsultaExecutada

    TRY
      loc_oCnt = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao
      loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lHabilitar
      loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lHabilitar
      loc_oCnt = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_BotoesAcao pode nao estar instanciado; Enabled eh melhor-esforco
    ENDTRY
  ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcgpBO.prg):
*==============================================================================
* sigopcgpBO.prg - Business Object para Consulta Global de Produtos
* Origem: SIGOPCGP.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgpBO AS BusinessBase

    *-- Controle de fluxo (equivalentes as propriedades/vars do form legado)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_cProdutoAtual      = ""    && _Produto - produto corrente (crTSigPro.cpros) na Pagina Resultado
    this_lAlteraPreco       = .F.   && ThisForm.AlteraPreco - fluxo de alteracao de preco (Do Form SigCdPro)
    this_lPrEca             = .F.   && par_prEca recebido no Init do form legado (fluxo iniciado por outra tela)
    this_nTpCalcp           = 0     && ThisForm.Tpcalcp - tipo de calculo de preco em uso
    this_cComposiciona      = ""    && ThisForm.Composiciona - grupo de composicao corrente
    this_lRetornoCj         = .F.   && ThisForm.RetornoCj - retorno do dialogo de conjuge (Do Form SigOpCcj)
    this_cEmpOperas         = ""    && ThisForm.EmpOperas - empresa selecionada para a faixa de operacao
    this_lUsuarioRestrito   = .F.   && ThisForm.llUser - restringe edicao de imagem/preco por tipo de usuario

    *-- Filtro: Produto (faixa de codigo + descricoes)
    this_cProdutoInicial = ""    && Get_produto_inicial - SigCdPro.cpros (faixa - inicio)
    this_cProdutoFinal   = ""    && Get_produto_final   - SigCdPro.cpros (faixa - fim)
    this_cDescricao      = ""    && Get_descricao       - SigCdPro.dpros (contem)
    this_cDescritivo     = ""    && Get_Descritivo      - SigCdPro.descritivo (contem)
    this_cDCompl         = ""    && Get_DCompl          - descricao completa (contem)
    this_cEquivalente    = ""    && getEquivalente      - SigCdPro.cpros do produto equivalente
    this_nBarra          = 0     && Get_Barra           - codigo de barras (SigCdPro.cbars)
    this_lEquivalentes   = .F.   && chkEquivalentes     - .T. = inclui produtos equivalentes na busca

    *-- Filtro: Grupo / Subgrupo / Grande Grupo / Linha / Colecao
    this_cCdGrupo    = ""    && get_cd_grupo  - SigCdGrp.cgrus
    this_cDsGrupo    = ""    && get_ds_grupo  - SigCdGrp.dgrus (preenchido pelo lookup)
    this_cCdSGrupo   = ""    && get_cd_sgrupo - SigCdPsg.codigos (subgrupo do grupo acima)
    this_cDsSGrupo   = ""    && get_ds_sgrupo - SigCdPsg.descricaos (preenchido pelo lookup)
    this_cGde        = ""    && Get_gde       - SigCdGpr.codigos (grande grupo)
    this_cLinhaI     = ""    && GetLin        - SigCdLin.linhas (faixa - inicio)
    this_cLinhaF     = ""    && GetLin2       - SigCdLin.linhas (faixa - fim)
    this_cColecaoI   = ""    && GetCol        - SigCdCol.colecoes (faixa - inicio)
    this_cColecaoF   = ""    && GetCol1       - SigCdCol.colecoes (faixa - fim)

    *-- Filtro: Peso / Cor / Tamanho / Dimensoes
    this_nPesoInicial = 0     && get_peso_inicial - SigCdPro.pesoms (faixa - inicio)
    this_nPesoFinal   = 0     && get_peso_final   - SigCdPro.pesoms (faixa - fim)
    this_cCor         = ""    && getCor      - SigCdCor.cods
    this_cDCor        = ""    && Get_dCor    - SigCdCor.descs (preenchido pelo lookup)
    this_cTam         = ""    && getTam      - SigCdTam.cods
    this_cDTam        = ""    && get_dTam    - SigCdTam.descs (preenchido pelo lookup)
    this_nTamProf     = 0     && get_tamps   - dimensao: profundidade
    this_nTamAlt      = 0     && get_tamas   - dimensao: altura
    this_nTamComp     = 0     && get_tamcs   - dimensao: comprimento

    *-- Filtro: Categoria / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de Valor
    this_cCategoria   = ""    && getCategoria   - SigCdCtg.cods
    this_cDCategoria  = ""    && getDCategoria  - SigCdCtg.descs (preenchido pelo lookup)
    this_cConjunto    = ""    && getConjunto    - codigo pai (SigCdPro.conjunts)
    this_cClasse      = ""    && get_cClass     - SigCdCls.cods
    this_cCodFinPI    = ""    && getCodFinP     - SigCdFip.cods (Modelo, faixa - inicio)
    this_cCodFinPF    = ""    && getCodFinPF    - SigCdFip.cods (Modelo, faixa - fim)
    this_cFxPreco     = ""    && getFxPreco     - SigCdPpc/SigCdPpi (faixa de valor do grupo)
    this_cLocais      = ""    && getLocals      - localizacao do produto
    this_cCodMacro    = ""    && getCodMacro    - codigo macro do produto

    *-- Filtro: CPF/CGC, Situacao, Imagem, Web
    this_cCPF          = ""    && Get_CPF   - CPF/CGC do cliente/fornecedor (faixa de operacao)
    this_cSituacao     = ""    && cmbSituas  - situacao do produto (RowSource)
    this_cImagem       = ""    && cmbImagem  - filtro por presenca de imagem (RowSource)
    this_nProdutoWeb   = 0     && optWebs    - indice do OptionGroup (5 opcoes) - produto web
    this_lOff          = .F.   && chkOff     - produto fora de linha / inativo no site

    *-- Filtro: Fornecedor / Referencia / Lista de Precos / Promocao
    this_cCdFornecedor   = ""    && get_cd_fornecedor  - SigCdCli.iclis (fAcessoContas)
    this_cDsFornecedor   = ""    && get_ds_fornecedor  - SigCdCli.rclis (preenchido pelo lookup)
    this_cRefFornecedor  = ""    && get_ref_fornecedor - SigCdPro.reffs (faixa - inicio)
    this_cRefFornecedorF = ""    && Get_ReffsF         - SigCdPro.reffs (faixa - fim)
    this_nTpReffs        = 0     && Opt_TpReffs        - indice do OptionGroup (3 opcoes)
    this_cLista          = ""    && Get_Lista          - SigCdLpc.lprecos
    this_cPromo          = ""    && get_promo          - SigPrPmc.promos

    *-- Filtro: Faixas de valor (custo / estimado / venda) + moeda
    this_nCustoInicial    = 0     && get_custo_inicial    - faixa de custo (inicio)
    this_nCustoFinal      = 0     && get_custo_final      - faixa de custo (fim)
    this_cMoeCusto        = ""    && get_moe_custo        - SigCdMoe.cmoes
    this_nEstimadoInicial = 0     && get_estimado_inicial - faixa de valor estimado (inicio)
    this_nEstimadoFinal   = 0     && get_estimado_final   - faixa de valor estimado (fim)
    this_cMoeEstimado     = ""    && get_moe_estimado     - SigCdMoe.cmoes
    this_nVendaInicial    = 0     && get_venda_inicial    - faixa de preco de venda (inicio)
    this_nVendaFinal      = 0     && get_venda_final      - faixa de preco de venda (fim)
    this_cMoeVenda        = ""    && get_moe_venda        - SigCdMoe.cmoes

    *-- Filtro: Empresa / Operacao / Periodo
    this_cEmpresa      = ""    && getEmps    - SigCdEmp.cemps
    this_cDEmpresa     = ""    && getDEmps   - SigCdEmp.razas (preenchido pelo lookup)
    this_cEmpresaOpe   = ""    && getEmpsO   - SigCdEmp.cemps (faixa de operacao)
    this_cOperacaoI    = ""    && Get_Operacaoi - SigCdOpe.dopes (faixa - inicio)
    this_cOperacaoF    = ""    && Get_Operacao  - SigCdOpe.dopes (faixa - fim)
    this_nTipoOperacao = 0     && OptOperacao   - indice do OptionGroup (3 opcoes)
    this_nTipoData     = 0     && OptTpData     - indice do OptionGroup (2 opcoes) - Dt. Operacao / Dt. Cadastro
    this_nTipoDataCad  = 0     && OptTpDtCad    - indice do OptionGroup (2 opcoes) - Inclusao / Alteracao
    this_nFormaPagto   = 0     && OptPagamento  - indice do OptionGroup (3 opcoes)
    this_lMarcaTOpe    = .F.   && ck_MarcaTOpe  - marca/desmarca todos os tipos de operacao da grade
    this_dDtOperacaoI  = {}    && get_dt_inicial - faixa de data de operacao (inicio)
    this_dDtOperacaoF  = {}    && get_dt_final   - faixa de data de operacao (fim)
    this_dDtAlteracaoI = {}    && getDtAltI      - faixa de data de alteracao (inicio)
    this_dDtAlteracaoF = {}    && getDtAltF      - faixa de data de alteracao (fim)

    *-- Filtro: Grupo/Conta Contabil (C.C. relacionado) e Conta de Origem/Destino do movimento
    this_cCdGrupoContab = ""    && get_Grupo   - SigCdCrg.ccargs (fAcessoContab)
    this_cDsGrupoContab = ""    && get_NGrupo  - descricao do grupo contabil (preenchido pelo lookup)
    this_cConta         = ""    && Get_Conta   - SigCdCli.iclis (fAcessoContas)
    this_cDConta        = ""    && Get_NConta  - SigCdCli.rclis (preenchido pelo lookup)
    this_cContaO        = ""    && get_ContaO  - SigCdCli.iclis (conta de origem/destino do movimento)
    this_cDContaO       = ""    && get_NContaO - SigCdCli.rclis (preenchido pelo lookup)

    *--------------------------------------------------------------------------
    * Init - este BO eh de CONSULTA customizada (SigOpCgp nao eh cadastro CRUD
    * de uma tabela so, e sim um painel que cruza SigCdPro com dezenas de
    * tabelas de apoio). this_cTabela/this_cCampoChave ficam com a entidade
    * central da consulta (Produtos), mas NAO sao passados a DODEFAULT():
    * BusinessBase.Init(pcTabela) so instanciaria um DataAccess generico sobre
    * SigCdPro, que este BO nao usa (as consultas sao todas via SQLEXEC).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o produto corrente a partir do cursor que
    * alimenta a grade de resultados (CrTSigPro/CrProdutos no legado). Este BO
    * eh de CONSULTA (SigOpCgp cruza SigCdPro com dezenas de tabelas de apoio
    * via SQLEXEC proprios de cada aba de resultado) - nao ha gravacao de
    * registro aqui, so o rastreio de qual produto esta em foco.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cProdutoAtual = TratarNulo(cpros, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigOpCgp eh consulta sobre SigCdPro; a chave do
    * registro em foco (usada so se algum fluxo chegar a chamar
    * RegistrarAuditoria) eh o codigo do produto corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cProdutoAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - SigOpCgp eh form de CONSULTA
    * (Consulta Global de Produtos): nenhum botao do legado grava SigCdPro por
    * aqui - alteracao e inclusao de produto abrem Do Form SigCdPro (FormProduto,
    * via BtnCadastroAlterar/btnProduto). A unica gravacao vista no dump
    * (Update SigCdPrf Set Obs em Pag_Resultado.Result.Fase.Get_Obs.LostFocus)
    * eh a observacao de fase de producao, que pertence ao metodo da propria
    * grade/aba Fase (fases seguintes desta migracao), nao a este trio. O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este BO.
    *--------------------------------------------------------------------------

ENDDEFINE

