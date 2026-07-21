# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'LookupMetodosExistem': Campos de lookup encontrados mas nenhum metodo AbrirLookup existe | Detalhes: AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 11:56:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 11:56:42] [INFO] Config FPW: (nao fornecido)
[2026-07-18 11:56:42] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 11:56:42] [INFO] Timeout: 300 segundos
[2026-07-18 11:56:42] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gtxkdsrn.prg
[2026-07-18 11:56:42] [INFO] Conteudo do wrapper:
[2026-07-18 11:56:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
QUIT

[2026-07-18 11:56:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gtxkdsrn.prg
[2026-07-18 11:56:42] [INFO] VFP output esperado em: C:\4c\tasks\task325\vfp_output.txt
[2026-07-18 11:56:42] [INFO] Executando Visual FoxPro 9...
[2026-07-18 11:56:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gtxkdsrn.prg
[2026-07-18 11:56:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gtxkdsrn.prg
[2026-07-18 11:56:42] [INFO] Timeout configurado: 300 segundos
[2026-07-18 11:57:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 11:57:12] [INFO] VFP9 finalizado em 29.7117252 segundos
[2026-07-18 11:57:12] [INFO] Exit Code: 
[2026-07-18 11:57:12] [INFO] 
[2026-07-18 11:57:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 11:57:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gtxkdsrn.prg
[2026-07-18 11:57:12] [INFO] 
[2026-07-18 11:57:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 11:57:12] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 11:57:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 11:57:12] [INFO] * Parameters: 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
[2026-07-18 11:57:12] [INFO] 
[2026-07-18 11:57:12] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 11:57:12] [INFO] SET SAFETY OFF
[2026-07-18 11:57:12] [INFO] SET RESOURCE OFF
[2026-07-18 11:57:12] [INFO] SET TALK OFF
[2026-07-18 11:57:12] [INFO] SET NOTIFY OFF
[2026-07-18 11:57:12] [INFO] SYS(2335, 0)
[2026-07-18 11:57:12] [INFO] 
[2026-07-18 11:57:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
[2026-07-18 11:57:12] [INFO] QUIT
[2026-07-18 11:57:12] [INFO] 
[2026-07-18 11:57:12] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 11:57:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-18 11:59:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 11:59:25] [INFO] Config FPW: (nao fornecido)
[2026-07-18 11:59:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 11:59:25] [INFO] Timeout: 300 segundos
[2026-07-18 11:59:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ns251azi.prg
[2026-07-18 11:59:25] [INFO] Conteudo do wrapper:
[2026-07-18 11:59:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
QUIT

[2026-07-18 11:59:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ns251azi.prg
[2026-07-18 11:59:25] [INFO] VFP output esperado em: C:\4c\tasks\task325\vfp_output.txt
[2026-07-18 11:59:25] [INFO] Executando Visual FoxPro 9...
[2026-07-18 11:59:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ns251azi.prg
[2026-07-18 11:59:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ns251azi.prg
[2026-07-18 11:59:25] [INFO] Timeout configurado: 300 segundos
[2026-07-18 11:59:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 11:59:58] [INFO] VFP9 finalizado em 33.5701576 segundos
[2026-07-18 11:59:58] [INFO] Exit Code: 
[2026-07-18 11:59:58] [INFO] 
[2026-07-18 11:59:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 11:59:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ns251azi.prg
[2026-07-18 11:59:58] [INFO] 
[2026-07-18 11:59:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 11:59:58] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 11:59:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 11:59:58] [INFO] * Parameters: 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
[2026-07-18 11:59:58] [INFO] 
[2026-07-18 11:59:58] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 11:59:58] [INFO] SET SAFETY OFF
[2026-07-18 11:59:58] [INFO] SET RESOURCE OFF
[2026-07-18 11:59:58] [INFO] SET TALK OFF
[2026-07-18 11:59:58] [INFO] SET NOTIFY OFF
[2026-07-18 11:59:58] [INFO] SYS(2335, 0)
[2026-07-18 11:59:58] [INFO] 
[2026-07-18 11:59:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrRet', 'C:\4c\tasks\task325', 'OPERACIONAL'
[2026-07-18 11:59:58] [INFO] QUIT
[2026-07-18 11:59:58] [INFO] 
[2026-07-18 11:59:58] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 11:59:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrRet",
  "timestamp": "20260718115958",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
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
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": false,
      "erro": "Campos de lookup encontrados mas nenhum metodo AbrirLookup existe",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru"
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
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg):
*==============================================================================
* FormSigPrRet.prg
* Form Operacional: Retorno de Estoque / Etiquetas (SIGPRRET)
* Migrado de: SIGPRRET.SCX
*
* Tipo: OPERACIONAL (filtros + acao)
* BO  : SigPrRetBO
* NAO usa PageFrame CRUD - controles adicionados direto no form.
*==============================================================================

DEFINE CLASS FormSigPrRet AS FormBase

    *-- Propriedades visuais (copiadas do original SIGPRRET)
    Caption      = "Estoque"
    Width        = 1000
    Height       = 600
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    AlwaysOnTop  = .T.
    ShowWindow   = 1
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado
    this_cModoAtual  = "OPERACIONAL"
    this_cTipo       = ""
    this_cOpEscolha  = ""

    *==========================================================================
    * Init - DODEFAULT() aciona FormBase.Init que chama InicializarForm
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrRetBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrRetBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Imagem de fundo identica ao original
            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            *-- Construir UI (form OPERACIONAL: layout flat, sem PageFrame Lista/Dados)
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            *-- Vincular eventos dos botoes de acao
            BINDEVENT(THIS.obj_4c_Sair, "Click", THIS, "BtnSairClick")

            *-- BINDEVENTs para campos de lookup/validacao

            *-- Empresa
            BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "KpressCdEmpresa")
            BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "ValidarEmpresa")
            BINDEVENT(THIS.txt_4c_DsEmpresa, "KeyPress", THIS, "KpressDsEmpresa")

            *-- Periodo: valida data final >= data inicial
            BINDEVENT(THIS.txt_4c_Dataf, "KeyPress", THIS, "ValidarDataFinal")

            *-- Operacao e Industria (cursor local SigCdOpd)
            BINDEVENT(THIS.txt_4c_NmOperacao,  "KeyPress",  THIS, "KpressNmOperacao")
            BINDEVENT(THIS.txt_4c_NmOperacao,  "KeyPress", THIS, "ValidarOperacao")
            BINDEVENT(THIS.txt_4c_NmOperacao,  "InteractiveChange", THIS, "OnChangeNmOperacao")
            BINDEVENT(THIS.txt_4c_NmIndustria, "KeyPress",  THIS, "KpressNmIndustria")
            BINDEVENT(THIS.txt_4c_NmIndustria, "KeyPress", THIS, "ValidarIndustria")
            BINDEVENT(THIS.txt_4c_NmIndustria, "InteractiveChange", THIS, "OnChangeNmIndustria")

            *-- Grupo de Estoque (SigCdGcr: codigos/descrs)
            BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress",  THIS, "KpressCdGrEstoque")
            BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "ValidarGrupoEstoque")
            BINDEVENT(THIS.txt_4c_CdGrEstoque, "InteractiveChange", THIS, "OnChangeCdGrEstoque")
            BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress",  THIS, "KpressDsGrEstoque")

            *-- Estoque (SIGCDGFC: contas filtrado por GrupoEstoque)
            BINDEVENT(THIS.txt_4c_CdEstoque, "KeyPress",  THIS, "KpressCdEstoque")
            BINDEVENT(THIS.txt_4c_CdEstoque, "KeyPress", THIS, "ValidarEstoque")
            BINDEVENT(THIS.txt_4c_DsEstoque, "KeyPress",  THIS, "KpressDsEstoque")

            *-- Produto (SigCdPro: CPros/DPros)
            BINDEVENT(THIS.txt_4c_Cod,  "KeyPress",  THIS, "KpressCod")
            BINDEVENT(THIS.txt_4c_Cod,  "KeyPress", THIS, "ValidarProduto")
            BINDEVENT(THIS.txt_4c_Dcod, "KeyPress",  THIS, "KpressDcod")

            *-- Etiquetas: validar CBars em SigOpEtq
            BINDEVENT(THIS.txt_4c_Etii, "KeyPress", THIS, "ValidarEtii")
            BINDEVENT(THIS.txt_4c_Etif, "KeyPress", THIS, "ValidarEtif")
            BINDEVENT(THIS.txt_4c_Etif, "InteractiveChange", THIS, "OnChangeEtif")

            *-- Grande Grupo (SigCdGpr: codigos/descs)
            BINDEVENT(THIS.txt_4c_GdeGrupo, "KeyPress",  THIS, "KpressGdeGrupo")
            BINDEVENT(THIS.txt_4c_GdeGrupo, "KeyPress", THIS, "ValidarGrandeGrupo")

            *-- Grupo Produto (SigCdGrp: cgrus/dgrus)
            BINDEVENT(THIS.txt_4c_Cgru, "KeyPress",  THIS, "KpressCgru")
            BINDEVENT(THIS.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoProduto")
            BINDEVENT(THIS.txt_4c_Cgru, "InteractiveChange", THIS, "OnChangeCgru")
            BINDEVENT(THIS.txt_4c_Dgru, "KeyPress",  THIS, "KpressDgru")
            BINDEVENT(THIS.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoProdutoDesc")

            *-- Subgrupo Produto (SigCdPsg: codigos/descricaos filtrado por cgrus)
            BINDEVENT(THIS.txt_4c_CSGru, "KeyPress",  THIS, "KpressCSGru")
            BINDEVENT(THIS.txt_4c_CSGru, "KeyPress", THIS, "ValidarSubGrupo")
            BINDEVENT(THIS.txt_4c_DSGru, "KeyPress",  THIS, "KpressDSGru")
            BINDEVENT(THIS.txt_4c_DSGru, "KeyPress", THIS, "ValidarSubGrupoDesc")

            *-- Colecao/Grupo Venda (SigCdCol: Colecoes/Descs)
            BINDEVENT(THIS.txt_4c_Col,  "KeyPress",  THIS, "KpressCol")
            BINDEVENT(THIS.txt_4c_Col,  "KeyPress", THIS, "ValidarColecao")
            BINDEVENT(THIS.txt_4c_Col,  "InteractiveChange", THIS, "OnChangeCol")
            BINDEVENT(THIS.txt_4c_DCol, "KeyPress",  THIS, "KpressDCol")
            BINDEVENT(THIS.txt_4c_DCol, "KeyPress", THIS, "ValidarColecaoDesc")

            *-- Linha (SigCdLin: linhas/descs)
            BINDEVENT(THIS.txt_4c_Lin, "KeyPress",  THIS, "KpressLin")
            BINDEVENT(THIS.txt_4c_Lin, "KeyPress", THIS, "ValidarLinha")

            *-- Local do Produto (SigPrLcl: codigos/descricaos)
            BINDEVENT(THIS.txt_4c_Local, "KeyPress",  THIS, "KpressLocal")
            BINDEVENT(THIS.txt_4c_Local, "KeyPress", THIS, "ValidarLocalProduto")

            *-- Local da Etiqueta (SigPrLcl: codigos/descricaos)
            BINDEVENT(THIS.txt_4c_Localizas, "KeyPress",  THIS, "KpressLocalizas")
            BINDEVENT(THIS.txt_4c_Localizas, "KeyPress", THIS, "ValidarLocalEtiqueta")

            *-- Promocao (SigPrPmc: promos)
            BINDEVENT(THIS.txt_4c_Promos, "KeyPress",  THIS, "KpressPromos")
            BINDEVENT(THIS.txt_4c_Promos, "KeyPress", THIS, "ValidarPromocao")

            *-- Tornar controles visiveis
            THIS.TornarControlesVisiveis()

            *-- Carregar cursor local de operacoes e inicializar campos
            THIS.CarregarOperacoesLocal()
            THIS.InicializarCampos()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria cabecalho cinza (cntSombra do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 40
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top           = 17
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 46
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(255, 255, 255)
            .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Adiciona todos os campos de filtro diretamente no form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()

        *-- ?? Empresa ??????????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Top       = 136
            .Left      = 248
            .Width     = 50
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .Top           = 132
            .Left          = 303
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 3
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .Top           = 132
            .Left          = 336
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 40
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- ?? Periodo ??????????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 111
            .Left      = 253
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Datai", "TextBox")
        WITH THIS.txt_4c_Datai
            .Top           = 107
            .Left          = 303
            .Width         = 80
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = {}
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Ate1", "Label")
        WITH THIS.lbl_4c_Ate1
            .Caption   = "at" + CHR(233)
            .Top       = 111
            .Left      = 388
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Dataf", "TextBox")
        WITH THIS.txt_4c_Dataf
            .Top           = 107
            .Left          = 411
            .Width         = 80
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = {}
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Operacao / Numero De-Ate / Industria ?????????????????????????????
        THIS.AddObject("lbl_4c_Operacao", "Label")
        WITH THIS.lbl_4c_Operacao
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 162
            .Left      = 242
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH THIS.txt_4c_NmOperacao
            .Top           = 157
            .Left          = 303
            .Width         = 150
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Numero", "TextBox")
        WITH THIS.txt_4c_Numero
            .Top           = 157
            .Left          = 454
            .Width         = 55
            .Height        = 25
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .InputMask     = "999999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Ate2", "Label")
        WITH THIS.lbl_4c_Ate2
            .Caption   = "at" + CHR(233)
            .Top       = 162
            .Left      = 514
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Numerof", "TextBox")
        WITH THIS.txt_4c_Numerof
            .Top           = 157
            .Left          = 536
            .Width         = 55
            .Height        = 25
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .InputMask     = "999999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Industria", "Label")
        WITH THIS.lbl_4c_Industria
            .Caption   = "Ind" + CHR(250) + "stria :"
            .Top       = 189
            .Left      = 246
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NmIndustria", "TextBox")
        WITH THIS.txt_4c_NmIndustria
            .Top           = 184
            .Left          = 303
            .Width         = 150
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Chk_Preco (OptionGroup 4 botoes: Sim/Nao/Ideal/Atual) ????????????
        THIS.AddObject("obj_4c_ChkPreco", "OptionGroup")
        WITH THIS.obj_4c_ChkPreco
            .ButtonCount = 4
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Height      = 25
            .Left        = 606
            .Top         = 157
            .Width       = 200
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 50
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ideal"
                .Height    = 15
                .Left      = 97
                .Top       = 5
                .Width     = 42
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Atual"
                .Height    = 15
                .Left      = 152
                .Top       = 5
                .Width     = 43
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ?? Codigo / Descricao Produto ???????????????????????????????????????
        THIS.AddObject("lbl_4c_Codigo", "Label")
        WITH THIS.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 215
            .Left      = 256
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Cod", "TextBox")
        WITH THIS.txt_4c_Cod
            .Top           = 211
            .Left          = 303
            .Width         = 108
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 14
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dcod", "TextBox")
        WITH THIS.txt_4c_Dcod
            .Top           = 211
            .Left          = 413
            .Width         = 290
            .FontName      = "Tahoma"
            .Value         = ""
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Etiquetas (faixa de/ate e quantidade) ????????????????????????????
        THIS.AddObject("lbl_4c_Etiquetas", "Label")
        WITH THIS.lbl_4c_Etiquetas
            .Caption   = "Etiquetas :"
            .Top       = 240
            .Left      = 244
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Etii", "TextBox")
        WITH THIS.txt_4c_Etii
            .Top           = 236
            .Left          = 303
            .Width         = 108
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Ate3", "Label")
        WITH THIS.lbl_4c_Ate3
            .Caption   = "at" + CHR(233)
            .Top       = 240
            .Left      = 413
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Etif", "TextBox")
        WITH THIS.txt_4c_Etif
            .Top           = 236
            .Left          = 436
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Ou", "Label")
        WITH THIS.lbl_4c_Ou
            .Caption   = "Ou"
            .Top       = 240
            .Left      = 547
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_QtdEti", "TextBox")
        WITH THIS.txt_4c_QtdEti
            .Top           = 236
            .Left          = 570
            .Width         = 60
            .Height        = 23
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "99999"
            .Value         = 0
            .MaxLength     = 5
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_EtqSufixo", "Label")
        WITH THIS.lbl_4c_EtqSufixo
            .Caption   = "Etiquetas"
            .Top       = 240
            .Left      = 636
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ?? Grupo Estoque ?????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_GrupoEstoque", "Label")
        WITH THIS.lbl_4c_GrupoEstoque
            .Caption   = "Grupo Estoque :"
            .Top       = 266
            .Left      = 218
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH THIS.txt_4c_CdGrEstoque
            .Top           = 261
            .Left          = 303
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH THIS.txt_4c_DsGrEstoque
            .Top           = 261
            .Left          = 384
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 20
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Estoque ???????????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Estoque", "Label")
        WITH THIS.lbl_4c_Estoque
            .Caption   = "Estoque :"
            .Top       = 293
            .Left      = 250
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH THIS.txt_4c_CdEstoque
            .Top           = 288
            .Left          = 303
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH THIS.txt_4c_DsEstoque
            .Top           = 288
            .Left          = 384
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 40
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Grande Grupo ??????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
        WITH THIS.lbl_4c_GrandeGrupo
            .Caption   = "Grande Grupo :"
            .Top       = 319
            .Left      = 222
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_GdeGrupo", "TextBox")
        WITH THIS.txt_4c_GdeGrupo
            .Top           = 315
            .Left          = 303
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 3
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Grupo Produto ?????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_GrupoProduto", "Label")
        WITH THIS.lbl_4c_GrupoProduto
            .Caption   = "Grupo Produto :"
            .Top       = 344
            .Left      = 219
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Cgru", "TextBox")
        WITH THIS.txt_4c_Cgru
            .Top           = 340
            .Left          = 303
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 3
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dgru", "TextBox")
        WITH THIS.txt_4c_Dgru
            .Top           = 340
            .Left          = 336
            .Width         = 171
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 20
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Subgrupo Produto ??????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Subgrupo", "Label")
        WITH THIS.lbl_4c_Subgrupo
            .Caption   = "Subgrupo Produto :"
            .Top       = 370
            .Left      = 202
            .Width     = 96
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CSGru", "TextBox")
        WITH THIS.txt_4c_CSGru
            .Top           = 366
            .Left          = 303
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 6
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DSGru", "TextBox")
        WITH THIS.txt_4c_DSGru
            .Top           = 366
            .Left          = 385
            .Width         = 156
            .Height        = 21
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 20
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- ?? Grupo Venda / Colecao ?????????????????????????????????????????????
        THIS.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH THIS.lbl_4c_GrupoVenda
            .Caption   = "Grupo Venda :"
            .Top       = 394
            .Left      = 227
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Col", "TextBox")
        WITH THIS.txt_4c_Col
            .Top           = 390
            .Left          = 303
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DCol", "TextBox")
        WITH THIS.txt_4c_DCol
            .Top           = 390
            .Left          = 385
            .Width         = 255
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Linha ?????????????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Linha", "Label")
        WITH THIS.lbl_4c_Linha
            .Caption   = "Linha :"
            .Top       = 419
            .Left      = 264
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Lin", "TextBox")
        WITH THIS.txt_4c_Lin
            .Top           = 415
            .Left          = 303
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Local do Produto ??????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_LocalProduto", "Label")
        WITH THIS.lbl_4c_LocalProduto
            .Caption   = "Local do Produto :"
            .Top       = 444
            .Left      = 209
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Local", "TextBox")
        WITH THIS.txt_4c_Local
            .Top           = 440
            .Left          = 303
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Local da Etiqueta ?????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_LocalEtq", "Label")
        WITH THIS.lbl_4c_LocalEtq
            .Caption   = "Local da Etiqueta :"
            .Top       = 469
            .Left      = 207
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Localizas", "TextBox")
        WITH THIS.txt_4c_Localizas
            .Top           = 465
            .Left          = 303
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .Value         = ""
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Promocao ??????????????????????????????????????????????????????????
        THIS.AddObject("lbl_4c_Promocao", "Label")
        WITH THIS.lbl_4c_Promocao
            .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
            .Top       = 494
            .Left      = 242
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Promos", "TextBox")
        WITH THIS.txt_4c_Promos
            .Top           = 490
            .Left          = 303
            .Width         = 185
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Value         = ""
            .MaxLength     = 25
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K!"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .T.
        ENDWITH

        *-- ?? Ordem (OptionGroup 5 botoes) ?????????????????????????????????????
        THIS.AddObject("lbl_4c_Ordem", "Label")
        WITH THIS.lbl_4c_Ordem
            .Caption   = "Ordem :"
            .Top       = 516
            .Left      = 257
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("obj_4c_GetOrdem", "OptionGroup")
        WITH THIS.obj_4c_GetOrdem
            .ButtonCount = 5
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 20
            .Left        = 297
            .Top         = 513
            .Width       = 513
            WITH .Buttons(1)
                .Caption   = "Produto"
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 63
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Etiqueta"
                .Height    = 15
                .Left      = 71
                .Top       = 2
                .Width     = 65
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Height    = 15
                .Left      = 141
                .Top       = 2
                .Width     = 74
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Referencia Fornecedor"
                .Height    = 15
                .Left      = 220
                .Top       = 2
                .Width     = 148
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Categoria + Grupo"
                .Height    = 15
                .Left      = 377
                .Top       = 2
                .Width     = 108
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ?? Marca (OptionGroup 2 botoes: Sim/Nao) ?????????????????????????????
        THIS.AddObject("lbl_4c_Marca", "Label")
        WITH THIS.lbl_4c_Marca
            .Caption   = "Marca :"
            .Top       = 536
            .Left      = 260
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("obj_4c_OptMarcas", "OptionGroup")
        WITH THIS.obj_4c_OptMarcas
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 27
            .Left        = 297
            .Top         = 531
            .Width       = 118
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 42
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 17
                .Left      = 71
                .Top       = 5
                .Width     = 42
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta a "pagina" principal do form OPERACIONAL.
    *
    * SIGPRRET nao tem PageFrame Lista/Dados nem grid de registros - eh um
    * form de filtros que despacha para SigOpIpE (Consulta/Arquivadas/Digitacao).
    * O equivalente logico de "Page1 = Lista" aqui eh o painel de filtros + o
    * CommandGroup de acoes, ambos criados diretamente sobre o form.
    *
    * Delega para ConfigurarFiltros() (todos os txt_4c_*/lbl_4c_* de filtro,
    * OptionGroups Ordem/Marca/Chk_Preco) e ConfigurarBotoes() (obj_4c_Sair
    * com 4 CommandButtons: Consulta, Arquivadas, Digitacao, Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura TabIndex dos campos de filtro
    *
    * SIGPRRET eh form OPERACIONAL flat (nao tem PageFrame Lista/Dados). Este
    * metodo existe como ponto de integracao com o pipeline multi-fase, que
    * espera ConfigurarPaginaDados em todo Form. Aqui centralizamos a ordem
    * de tabulacao entre os campos de filtro seguindo a ordem visual do SCX
    * legado (top-to-bottom, left-to-right) - separado de ConfigurarFiltros
    * porque depende de TODOS os controles ja existirem no form.
    *
    * Chamado por ConfigurarPaginaLista apos ConfigurarFiltros/ConfigurarBotoes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- Ordem de tabulacao seguindo visual do SCX (top-to-bottom)
            THIS.txt_4c_Datai.TabIndex      = 1
            THIS.txt_4c_Dataf.TabIndex      = 2
            THIS.txt_4c_CdEmpresa.TabIndex  = 3
            THIS.txt_4c_DsEmpresa.TabIndex  = 4
            THIS.txt_4c_NmOperacao.TabIndex = 5
            THIS.txt_4c_Numero.TabIndex     = 6
            THIS.txt_4c_Numerof.TabIndex    = 7
            THIS.obj_4c_ChkPreco.TabIndex   = 8
            THIS.txt_4c_NmIndustria.TabIndex = 9
            THIS.txt_4c_Cod.TabIndex        = 10
            THIS.txt_4c_Dcod.TabIndex       = 11
            THIS.txt_4c_Etii.TabIndex       = 12
            THIS.txt_4c_Etif.TabIndex       = 13
            THIS.txt_4c_QtdEti.TabIndex     = 14
            THIS.txt_4c_CdGrEstoque.TabIndex = 15
            THIS.txt_4c_DsGrEstoque.TabIndex = 16
            THIS.txt_4c_CdEstoque.TabIndex  = 17
            THIS.txt_4c_DsEstoque.TabIndex  = 18
            THIS.txt_4c_GdeGrupo.TabIndex   = 19
            THIS.txt_4c_Cgru.TabIndex       = 20
            THIS.txt_4c_Dgru.TabIndex       = 21
            THIS.txt_4c_CSGru.TabIndex      = 22
            THIS.txt_4c_DSGru.TabIndex      = 23
            THIS.txt_4c_Col.TabIndex        = 24
            THIS.txt_4c_DCol.TabIndex       = 25
            THIS.txt_4c_Lin.TabIndex        = 26
            THIS.txt_4c_Local.TabIndex      = 27
            THIS.txt_4c_Localizas.TabIndex  = 28
            THIS.txt_4c_Promos.TabIndex     = 29
            THIS.obj_4c_GetOrdem.TabIndex   = 30
            THIS.obj_4c_OptMarcas.TabIndex  = 31
            THIS.obj_4c_Sair.TabIndex       = 32

        CATCH TO loc_oErro
            *-- TabIndex nao critico; se algum controle faltar, nao bloquear form
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Adiciona CommandGroup de acoes (sair do legado)
    * 4 botoes: Consulta / Arquivadas / Digitacao / Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()

        THIS.AddObject("obj_4c_Sair", "CommandGroup")
        WITH THIS.obj_4c_Sair
            .ButtonCount   = 4
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = 689
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 313
            .Themes        = .F.
            WITH .Buttons(1)
                .AutoSize   = .F.
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption    = "\<Consulta"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(2)
                .AutoSize   = .F.
                .Top        = 5
                .Left       = 81
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_disco_60.jpg"
                .Caption    = "\<Arquivadas"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(3)
                .AutoSize   = .F.
                .Top        = 5
                .Left       = 157
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
                .Caption    = "\<Digita" + CHR(231) + CHR(227) + "o"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(4)
                .AutoSize   = .F.
                .Top        = 5
                .Left       = 233
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

    ENDPROC

    *==========================================================================
    * AlternarPagina - Equivalente para form OPERACIONAL: limpa filtros
    *==========================================================================
    PROCEDURE AlternarPagina()
        THIS.InicializarCampos()
    ENDPROC

    *==========================================================================
    * BtnSairClick - Dispatcher do CommandGroup (BINDEVENT em InicializarForm)
    *==========================================================================
    PROCEDURE BtnSairClick()
        DO CASE
        CASE THIS.obj_4c_Sair.Value = 1
            THIS.BtnConsultaClick()
        CASE THIS.obj_4c_Sair.Value = 2
            THIS.BtnArquivadasClick()
        CASE THIS.obj_4c_Sair.Value = 3
            THIS.BtnDigitacaoClick()
        CASE THIS.obj_4c_Sair.Value = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnConsultaClick - Abre SigOpIpE em modo CONSULTA com filtros preenchidos
    *==========================================================================
    PROCEDURE BtnConsultaClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Definir variaveis PRIVATE conforme o legado (acessadas por SigOpIpE)
            PRIVATE pcCdProduto, pcDsProduto, pdDtInicial, pdDtFinal
            PRIVATE pnEtiqIni, pnEtiqFim, pnOrdem, pnQtdEti
            PRIVATE pcEstoque, pcGrEstoque, pcOperacao, pcIndustria
            PRIVATE pnNumero, pnNumerof, pcOptMarca
            PRIVATE pcGrupo, pcSGrus, pcColecoes, pcGdeGrupo
            PRIVATE pcEmpresa, pcLinha, pcDepto, pcLocaliza, pcPromos

            pcCdProduto = THIS.txt_4c_Cod.Value
            pcDsProduto = THIS.txt_4c_Dcod.Value
            pdDtInicial = THIS.txt_4c_Datai.Value
            pdDtFinal   = IIF(EMPTY(THIS.txt_4c_Dataf.Value), ;
                              CTOD("31/12/9999"), ;
                              THIS.txt_4c_Dataf.Value)
            pnEtiqIni   = THIS.txt_4c_Etii.Value
            pnEtiqFim   = THIS.txt_4c_Etif.Value
            pnOrdem     = THIS.obj_4c_GetOrdem.Value
            pcEstoque   = THIS.txt_4c_CdEstoque.Value
            pcGrEstoque = THIS.txt_4c_CdGrEstoque.Value
            pcOperacao  = THIS.txt_4c_NmOperacao.Value
            pcIndustria = THIS.txt_4c_NmIndustria.Value
            pnNumero    = THIS.txt_4c_Numero.Value
            pnNumerof   = THIS.txt_4c_Numerof.Value
            pcOptMarca  = THIS.obj_4c_OptMarcas.Value
            pcGrupo     = THIS.txt_4c_Cgru.Value
            pcSGrus     = THIS.txt_4c_CSGru.Value
            pcColecoes  = THIS.txt_4c_Col.Value
            pcGdeGrupo  = THIS.txt_4c_GdeGrupo.Value
            pcEmpresa   = THIS.txt_4c_CdEmpresa.Value
            pnQtdEti    = THIS.txt_4c_QtdEti.Value
            pcLinha     = THIS.txt_4c_Lin.Value
            pcDepto     = THIS.txt_4c_Local.Value
            pcLocaliza  = THIS.txt_4c_Localizas.Value
            pcPromos    = THIS.txt_4c_Promos.Value

            THIS.this_cTipo = "CONSULTA"

            DO FORM SigOpIpE WITH THIS

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir Consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnDigitacaoClick - Abre SigOpIpE em modo DIGITACAO (filtros zerados)
    *==========================================================================
    PROCEDURE BtnDigitacaoClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            PRIVATE pcCdProduto, pcDsProduto, pdDtInicial, pdDtFinal
            PRIVATE pnEtiqIni, pnEtiqFim, pnOrdem, pnQtdEti
            PRIVATE pcEstoque, pcGrEstoque, pcOperacao, pcIndustria
            PRIVATE pnNumero, pnNumerof, pcOptMarca
            PRIVATE pcGrupo, pcSGrus, pcColecoes, pcGdeGrupo
            PRIVATE pcEmpresa, pcPromos

            pcCdProduto = SPACE(10)
            pcDsProduto = SPACE(40)
            pdDtInicial = CTOD("  /  /  ")
            pdDtFinal   = CTOD("  /  /  ")
            pnEtiqIni   = 0
            pnEtiqFim   = 0
            pnOrdem     = THIS.obj_4c_GetOrdem.Value
            pcEstoque   = SPACE(10)
            pcGrEstoque = SPACE(40)
            pcOperacao  = SPACE(20)
            pcIndustria = SPACE(20)
            pnNumero    = 0
            pnNumerof   = 0
            pcOptMarca  = 1
            pcGdeGrupo  = SPACE(3)
            pcGrupo     = SPACE(3)
            pcColecoes  = SPACE(10)
            pcEmpresa   = SPACE(3)
            pcPromos    = THIS.txt_4c_Promos.Value

            THIS.this_cTipo = "DIGITACAO"

            DO FORM SigOpIpE WITH THIS

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir Digita" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnArquivadasClick - Abre SigOpIpE em modo ARQUIVADAS
    *==========================================================================
    PROCEDURE BtnArquivadasClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            PRIVATE pcCdProduto, pcDsProduto, pdDtInicial, pdDtFinal
            PRIVATE pnEtiqIni, pnEtiqFim, pnOrdem, pnQtdEti
            PRIVATE pcEstoque, pcGrEstoque, pcOperacao, pcIndustria
            PRIVATE pnNumero, pnNumerof, pcOptMarca
            PRIVATE pcGrupo, pcSGrus, pcColecoes, pcGdeGrupo
            PRIVATE pcEmpresa, pcCol, pcPromos

            pcCdProduto = SPACE(10)
            pcDsProduto = SPACE(40)
            pdDtInicial = CTOD("  /  /  ")
            pdDtFinal   = CTOD("  /  /  ")
            pnEtiqIni   = 0
            pnEtiqFim   = 0
            pnOrdem     = 1
            pcEstoque   = SPACE(10)
            pcGrEstoque = SPACE(40)
            pcOperacao  = SPACE(20)
            pcIndustria = SPACE(20)
            pnNumero    = 0
            pnNumerof   = 0
            pcOptMarca  = 1
            pcGdeGrupo  = SPACE(3)
            pcGrupo     = SPACE(3)
            pcColecoes  = SPACE(10)
            pcEmpresa   = SPACE(3)
            pcCol       = SPACE(10)
            pcPromos    = THIS.txt_4c_Promos.Value

            THIS.this_cTipo = "ARQUIVADAS"

            DO FORM SigOpIpE WITH THIS

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir Arquivadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL: equivale a "Digitacao"
    * Abre SigOpIpE em modo DIGITACAO (filtros zerados para nova entrada)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        RETURN THIS.BtnDigitacaoClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL: equivale a "Consulta"
    * Abre SigOpIpE em modo CONSULTA (filtros atuais do form)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        RETURN THIS.BtnConsultaClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL: equivale a "Consulta"
    * Abre SigOpIpE em modo CONSULTA (visualizacao do relatorio)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        RETURN THIS.BtnConsultaClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL: equivale a "Arquivadas"
    * Abre SigOpIpE em modo ARQUIVADAS (etiquetas removidas/arquivadas)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        RETURN THIS.BtnArquivadasClick()
    ENDPROC

    *==========================================================================
    * CarregarOperacoesLocal - Carrega cursor VFP local de SigCdOpd (para SEEK)
    *==========================================================================
    PROTECTED PROCEDURE CarregarOperacoesLocal()
        LOCAL loc_cSQL, loc_oErro

        TRY
            IF USED("cursor_4c_Opd")
                USE IN cursor_4c_Opd
            ENDIF

            loc_cSQL = "SELECT a.* FROM SigCdOpd a"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opd") > 0
                IF USED("cursor_4c_Opd")
                    SELECT cursor_4c_Opd
                    INDEX ON dopps TAG dopps
                    SET ORDER TO
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            *-- Cursor de operacoes opcional; nao bloquear abertura do form
        ENDTRY
    ENDPROC

    *==========================================================================
    * InicializarCampos - Limpa / inicializa todos os campos de filtro
    *==========================================================================
    PROTECTED PROCEDURE InicializarCampos()
        LOCAL loc_oErro

        TRY
            WITH THIS
                .txt_4c_Cod.Value         = ""
                .txt_4c_Dcod.Value        = ""
                .txt_4c_Datai.Value       = {}
                .txt_4c_Dataf.Value       = {}
                .txt_4c_Etii.Value        = 0
                .txt_4c_Etif.Value        = 0
                .txt_4c_QtdEti.Value      = 0
                .txt_4c_CdEstoque.Value   = ""
                .txt_4c_DsEstoque.Value   = ""
                .txt_4c_CdGrEstoque.Value = ""
                .txt_4c_DsGrEstoque.Value = ""
                .txt_4c_GdeGrupo.Value    = ""
                .txt_4c_Cgru.Value        = ""
                .txt_4c_Dgru.Value        = ""
                .txt_4c_CSGru.Value       = ""
                .txt_4c_DSGru.Value       = ""
                .txt_4c_Col.Value         = ""
                .txt_4c_DCol.Value        = ""
                .txt_4c_Lin.Value         = ""
                .txt_4c_Local.Value       = ""
                .txt_4c_Localizas.Value   = ""
                .txt_4c_Promos.Value      = ""
                .txt_4c_NmOperacao.Value  = ""
                .txt_4c_NmIndustria.Value = ""
                .txt_4c_Numero.Value      = 0
                .txt_4c_Numerof.Value     = 0
                .txt_4c_CdEmpresa.Value   = ""
                .txt_4c_DsEmpresa.Value   = ""
                .this_cTipo               = "CONSULTA"
                .this_cOpEscolha          = "ALTERAR"
            ENDWITH

            *-- Enabled inicial (replicando condicoes "When" do legado)
            *-- DsGrEstoque/CdEstoque/DsEstoque: somente quando CdGrEstoque preenchido
            THIS.txt_4c_DsGrEstoque.Enabled = .F.
            THIS.txt_4c_CdEstoque.Enabled   = .F.
            THIS.txt_4c_DsEstoque.Enabled   = .F.
            *-- Numero/Numerof: somente quando NmOperacao ou NmIndustria preenchido
            THIS.txt_4c_Numero.Enabled  = .F.
            THIS.txt_4c_Numerof.Enabled = .F.
            *-- Dgru: somente quando Cgru VAZIO (busca pela descricao so faz sentido sem codigo)
            THIS.txt_4c_Dgru.Enabled = .T.
            *-- DSGru: somente quando Cgru preenchido E CSGru vazio
            THIS.txt_4c_DSGru.Enabled = .F.
            *-- CSGru: somente quando Cgru preenchido
            THIS.txt_4c_CSGru.Enabled = .F.
            *-- DCol: somente quando Col preenchido
            THIS.txt_4c_DCol.Enabled = .F.
            *-- QtdEti: somente quando Etif vazio
            THIS.txt_4c_QtdEti.Enabled = .T.

            *-- Verificar parametro de empresa fixa
            THIS.VerificarEmpresaFixa()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar campos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VerificarEmpresaFixa - Le SigCdPac.fixaemp e trava empresa se necessario
    *==========================================================================
    PROTECTED PROCEDURE VerificarEmpresaFixa()
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "SELECT TOP 1 fixaemp FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    IF cursor_4c_Pac.fixaemp = 1
                        THIS.txt_4c_CdEmpresa.Value   = go_4c_Sistema.cCodEmpresa
                        THIS.txt_4c_CdEmpresa.Enabled = .F.
                        THIS.PreencherDescEmpresa(go_4c_Sistema.cCodEmpresa)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Parametro de empresa fixa opcional; ignorar falha
        ENDTRY
    ENDPROC

    *==========================================================================
    * PreencherDescEmpresa - Busca Razas em SigCdEmp pelo codigo
    *==========================================================================
    PROTECTED PROCEDURE PreencherDescEmpresa(par_cCodEmp)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cCodEmp))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                IF USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                    SELECT cursor_4c_Emp
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                IF USED("cursor_4c_Emp")
                    USE IN cursor_4c_Emp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Descricao de empresa opcional; ignorar falha
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles de nivel raiz
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * KEYPRESS HANDLERS - F4(115) abre picker / Tab+Enter(9/13) dispara Validar*
    *==========================================================================

    PROCEDURE KpressCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13, 115)
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
    ENDPROC

    PROCEDURE KpressNmOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarOperacao()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressNmIndustria(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaIndustria()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarIndustria()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoEstoque()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarGrupoEstoque()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13, 115)
            THIS.AbrirBuscaGrupoEstoqueDesc()
        ENDIF
    ENDPROC

    PROCEDURE KpressCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarEstoque()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13, 115)
            THIS.AbrirBuscaEstoque()
        ENDIF
    ENDPROC

    PROCEDURE KpressCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaProduto()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarProduto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDcod(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13, 115)
            THIS.AbrirBuscaProdutoDesc()
        ENDIF
    ENDPROC

    PROCEDURE KpressGdeGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrandeGrupo()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarGrandeGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressCgru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoProduto()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarGrupoProduto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDgru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoProdutoDesc()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarGrupoProdutoDesc()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressCSGru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSubGrupo()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarSubGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDSGru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSubGrupoDesc()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarSubGrupoDesc()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressCol(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaColecao()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarColecao()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressDCol(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaColecaoDesc()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarColecaoDesc()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressLin(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLinha()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarLinha()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLocalProduto()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarLocalProduto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressLocalizas(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLocalEtiqueta()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarLocalEtiqueta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE KpressPromos(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaPromocao()
        ELSE
            IF INLIST(par_nKeyCode, 9, 13)
            THIS.ValidarPromocao()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CHANGE HANDLERS
    *==========================================================================

    PROCEDURE OnChangeCdGrEstoque()
        LOCAL loc_lGrupoOk
        loc_lGrupoOk = !EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
        THIS.txt_4c_DsGrEstoque.Enabled = loc_lGrupoOk
        THIS.txt_4c_CdEstoque.Enabled   = loc_lGrupoOk
        THIS.txt_4c_DsEstoque.Enabled   = loc_lGrupoOk
        IF !loc_lGrupoOk
            THIS.txt_4c_DsGrEstoque.Value = ""
            THIS.txt_4c_CdEstoque.Value   = ""
            THIS.txt_4c_DsEstoque.Value   = ""
        ENDIF
    ENDPROC

    PROCEDURE OnChangeNmOperacao()
        LOCAL loc_lOk
        loc_lOk = !EMPTY(ALLTRIM(THIS.txt_4c_NmOperacao.Value)) OR ;
                  !EMPTY(ALLTRIM(THIS.txt_4c_NmIndustria.Value))
        THIS.txt_4c_Numero.Enabled  = loc_lOk
        THIS.txt_4c_Numerof.Enabled = loc_lOk
        IF !loc_lOk
            THIS.txt_4c_Numero.Value  = 0
            THIS.txt_4c_Numerof.Value = 0
        ENDIF
    ENDPROC

    PROCEDURE OnChangeNmIndustria()
        THIS.OnChangeNmOperacao()
    ENDPROC

    PROCEDURE OnChangeCgru()
        LOCAL loc_lCgruOk
        loc_lCgruOk = !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
        *-- Dgru: acessivel apenas quando Cgru VAZIO (busca por descricao)
        THIS.txt_4c_Dgru.Enabled  = !loc_lCgruOk
        *-- CSGru/DSGru: acessivel apenas quando Cgru preenchido
        THIS.txt_4c_CSGru.Enabled = loc_lCgruOk
        THIS.txt_4c_DSGru.Enabled = loc_lCgruOk
        IF !loc_lCgruOk
            THIS.txt_4c_Dgru.Value  = ""
            THIS.txt_4c_CSGru.Value = ""
            THIS.txt_4c_DSGru.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE OnChangeEtif()
        *-- QtdEti: acessivel apenas quando Etif vazio
        THIS.txt_4c_QtdEti.Enabled = EMPTY(THIS.txt_4c_Etif.Value) OR ;
                                      THIS.txt_4c_Etif.Value = 0
    ENDPROC

    PROCEDURE OnChangeCol()
        LOCAL loc_lColOk
        loc_lColOk = !EMPTY(ALLTRIM(THIS.txt_4c_Col.Value))
        THIS.txt_4c_DCol.Enabled = loc_lColOk
        IF !loc_lColOk
            THIS.txt_4c_DCol.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDAR (LostFocus) - Validam codigo e preenchem descricao
    *==========================================================================

    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmp") > 0 AND ;
               USED("cursor_4c_VldEmp") AND !EOF("cursor_4c_VldEmp")
                SELECT cursor_4c_VldEmp
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_VldEmp.Cemps)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_VldEmp.Razas)
            ELSE
                THIS.txt_4c_CdEmpresa.Value = ""
                THIS.txt_4c_DsEmpresa.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Empresa")
        ENDTRY
        IF USED("cursor_4c_VldEmp")
            USE IN cursor_4c_VldEmp
        ENDIF
    ENDPROC

    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.txt_4c_Dataf.Value) AND !EMPTY(THIS.txt_4c_Datai.Value)
            IF THIS.txt_4c_Dataf.Value < THIS.txt_4c_Datai.Value
                MsgAviso("Data Final deve ser maior ou igual " + CHR(224) + " Data Inicial.")
                THIS.txt_4c_Dataf.Value = {}
                THIS.txt_4c_Dataf.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarOperacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oErro
        loc_cValor = UPPER(ALLTRIM(THIS.txt_4c_NmOperacao.Value))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_Opd")
                SELECT cursor_4c_Opd
                SET ORDER TO dopps
                IF !SEEK(loc_cValor, "cursor_4c_Opd", "dopps")
                    THIS.txt_4c_NmOperacao.Value = ""
                ELSE
                    THIS.txt_4c_NmOperacao.Value = ALLTRIM(cursor_4c_Opd.dopps)
                ENDIF
            ELSE
                THIS.txt_4c_NmOperacao.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarIndustria(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oErro
        loc_cValor = UPPER(ALLTRIM(THIS.txt_4c_NmIndustria.Value))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_Opd")
                SELECT cursor_4c_Opd
                SET ORDER TO dopps
                IF !SEEK(loc_cValor, "cursor_4c_Opd", "dopps")
                    THIS.txt_4c_NmIndustria.Value = ""
                ELSE
                    THIS.txt_4c_NmIndustria.Value = ALLTRIM(cursor_4c_Opd.dopps)
                ENDIF
            ELSE
                THIS.txt_4c_NmIndustria.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Ind" + CHR(250) + "stria")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarGrupoEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_DsGrEstoque.Value = ""
            THIS.OnChangeCdGrEstoque()
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrEst") > 0 AND ;
               USED("cursor_4c_VldGrEst") AND !EOF("cursor_4c_VldGrEst")
                SELECT cursor_4c_VldGrEst
                THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_VldGrEst.codigos)
                THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_VldGrEst.descrs)
            ELSE
                THIS.txt_4c_CdGrEstoque.Value = ""
                THIS.txt_4c_DsGrEstoque.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Grupo Estoque")
        ENDTRY
        IF USED("cursor_4c_VldGrEst")
            USE IN cursor_4c_VldGrEst
        ENDIF
        THIS.OnChangeCdGrEstoque()
    ENDPROC

    PROCEDURE ValidarEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cGrupo, loc_cSQL, loc_oErro
        loc_cCod   = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
        loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_DsEstoque.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT a.contas, b.descrs FROM SIGCDGFC a " + ;
                       "INNER JOIN SigCdGcr b ON b.codigos = a.contas " + ;
                       "WHERE a.contas = " + EscaparSQL(loc_cCod)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEst") > 0 AND ;
               USED("cursor_4c_VldEst") AND !EOF("cursor_4c_VldEst")
                SELECT cursor_4c_VldEst
                THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_VldEst.contas)
                THIS.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_VldEst.descrs)
            ELSE
                THIS.txt_4c_CdEstoque.Value = ""
                THIS.txt_4c_DsEstoque.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Estoque")
        ENDTRY
        IF USED("cursor_4c_VldEst")
            USE IN cursor_4c_VldEst
        ENDIF
    ENDPROC

    PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Cod.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_Dcod.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro") > 0 AND ;
               USED("cursor_4c_VldPro") AND !EOF("cursor_4c_VldPro")
                SELECT cursor_4c_VldPro
                THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_VldPro.CPros)
                THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_VldPro.DPros)
            ELSE
                THIS.txt_4c_Cod.Value  = ""
                THIS.txt_4c_Dcod.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Produto")
        ENDTRY
        IF USED("cursor_4c_VldPro")
            USE IN cursor_4c_VldPro
        ENDIF
    ENDPROC

    PROCEDURE ValidarEtii(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nCBars, loc_cSQL, loc_oErro
        IF EMPTY(THIS.txt_4c_Etii.Value) OR THIS.txt_4c_Etii.Value = 0
            RETURN
        ENDIF
        TRY
            loc_nCBars = THIS.txt_4c_Etii.Value
            loc_cSQL = "SELECT TOP 1 a.CPros, a.CBars FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.CPros = b.CPros AND a.CBars = b.Cbars_new " + ;
                       "WHERE (a.CBars = " + FormatarNumeroSQL(loc_nCBars) + ;
                       " OR b.Cbars_old = " + FormatarNumeroSQL(loc_nCBars) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEtii") > 0 AND ;
               USED("cursor_4c_VldEtii") AND !EOF("cursor_4c_VldEtii")
                SELECT cursor_4c_VldEtii
                THIS.txt_4c_Etii.Value = cursor_4c_VldEtii.CBars
                IF EMPTY(THIS.txt_4c_Etif.Value) OR THIS.txt_4c_Etif.Value = 0
                    THIS.txt_4c_Etif.Value = THIS.txt_4c_Etii.Value
                ENDIF
            ELSE
                MsgAviso("Etiqueta n" + CHR(227) + "o cadastrada.")
                THIS.txt_4c_Etii.Value = 0
                THIS.txt_4c_Etii.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Etiqueta Inicial")
        ENDTRY
        IF USED("cursor_4c_VldEtii")
            USE IN cursor_4c_VldEtii
        ENDIF
    ENDPROC

    PROCEDURE ValidarEtif(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nCBars, loc_cSQL, loc_oErro
        IF EMPTY(THIS.txt_4c_Etif.Value) OR THIS.txt_4c_Etif.Value = 0
            THIS.OnChangeEtif()
            RETURN
        ENDIF
        TRY
            loc_nCBars = THIS.txt_4c_Etif.Value
            loc_cSQL = "SELECT TOP 1 a.CPros, a.CBars FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.CPros = b.CPros AND a.CBars = b.Cbars_new " + ;
                       "WHERE (a.CBars = " + FormatarNumeroSQL(loc_nCBars) + ;
                       " OR b.Cbars_old = " + FormatarNumeroSQL(loc_nCBars) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEtif") > 0 AND ;
               USED("cursor_4c_VldEtif") AND !EOF("cursor_4c_VldEtif")
                SELECT cursor_4c_VldEtif
                THIS.txt_4c_Etif.Value = cursor_4c_VldEtif.CBars
            ELSE
                MsgAviso("Etiqueta n" + CHR(227) + "o cadastrada.")
                THIS.txt_4c_Etif.Value = 0
                THIS.txt_4c_Etif.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Etiqueta Final")
        ENDTRY
        IF USED("cursor_4c_VldEtif")
            USE IN cursor_4c_VldEtif
        ENDIF
        THIS.OnChangeEtif()
    ENDPROC

    PROCEDURE ValidarGrandeGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_GdeGrupo.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGpr") > 0 AND ;
               USED("cursor_4c_VldGpr") AND !EOF("cursor_4c_VldGpr")
                SELECT cursor_4c_VldGpr
                THIS.txt_4c_GdeGrupo.Value = ALLTRIM(cursor_4c_VldGpr.codigos)
            ELSE
                THIS.txt_4c_GdeGrupo.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Grande Grupo")
        ENDTRY
        IF USED("cursor_4c_VldGpr")
            USE IN cursor_4c_VldGpr
        ENDIF
    ENDPROC

    PROCEDURE ValidarGrupoProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Cgru.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_Dgru.Value = ""
            THIS.OnChangeCgru()
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrp") > 0 AND ;
               USED("cursor_4c_VldGrp") AND !EOF("cursor_4c_VldGrp")
                SELECT cursor_4c_VldGrp
                THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_VldGrp.cgrus)
                THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_VldGrp.dgrus)
            ELSE
                THIS.txt_4c_Cgru.Value = ""
                THIS.txt_4c_Dgru.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Grupo Produto")
        ENDTRY
        IF USED("cursor_4c_VldGrp")
            USE IN cursor_4c_VldGrp
        ENDIF
        THIS.OnChangeCgru()
    ENDPROC

    PROCEDURE ValidarGrupoProdutoDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_cSQL, loc_oErro
        loc_cDesc = ALLTRIM(THIS.txt_4c_Dgru.Value)
        IF EMPTY(loc_cDesc) OR !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE dgrus LIKE " + ;
                       EscaparSQL(loc_cDesc + "%")
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrpD") > 0 AND ;
               USED("cursor_4c_VldGrpD") AND !EOF("cursor_4c_VldGrpD")
                SELECT cursor_4c_VldGrpD
                THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_VldGrpD.cgrus)
                THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_VldGrpD.dgrus)
            ELSE
                THIS.txt_4c_Dgru.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Grupo Produto")
        ENDTRY
        IF USED("cursor_4c_VldGrpD")
            USE IN cursor_4c_VldGrpD
        ENDIF
        THIS.OnChangeCgru()
    ENDPROC

    PROCEDURE ValidarSubGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cGru, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_CSGru.Value)
        loc_cGru = ALLTRIM(THIS.txt_4c_Cgru.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_DSGru.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos = " + ;
                       EscaparSQL(loc_cCod)
            IF !EMPTY(loc_cGru)
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGru)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPsg") > 0 AND ;
               USED("cursor_4c_VldPsg") AND !EOF("cursor_4c_VldPsg")
                SELECT cursor_4c_VldPsg
                THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_VldPsg.codigos)
                THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_VldPsg.descricaos)
            ELSE
                THIS.txt_4c_CSGru.Value = ""
                THIS.txt_4c_DSGru.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Subgrupo")
        ENDTRY
        IF USED("cursor_4c_VldPsg")
            USE IN cursor_4c_VldPsg
        ENDIF
    ENDPROC

    PROCEDURE ValidarSubGrupoDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_cGru, loc_cSQL, loc_oErro
        loc_cDesc = ALLTRIM(THIS.txt_4c_DSGru.Value)
        loc_cGru  = ALLTRIM(THIS.txt_4c_Cgru.Value)
        IF EMPTY(loc_cDesc)
            THIS.txt_4c_CSGru.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descricaos FROM SigCdPsg WHERE descricaos LIKE " + ;
                       EscaparSQL(loc_cDesc + "%")
            IF !EMPTY(loc_cGru)
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGru)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPsgD") > 0 AND ;
               USED("cursor_4c_VldPsgD") AND !EOF("cursor_4c_VldPsgD")
                SELECT cursor_4c_VldPsgD
                THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_VldPsgD.codigos)
                THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_VldPsgD.descricaos)
            ELSE
                THIS.txt_4c_CSGru.Value = ""
                THIS.txt_4c_DSGru.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Subgrupo")
        ENDTRY
        IF USED("cursor_4c_VldPsgD")
            USE IN cursor_4c_VldPsgD
        ENDIF
    ENDPROC

    PROCEDURE ValidarColecao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Col.Value)
        IF EMPTY(loc_cCod)
            THIS.txt_4c_DCol.Value = ""
            THIS.OnChangeCol()
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCol") > 0 AND ;
               USED("cursor_4c_VldCol") AND !EOF("cursor_4c_VldCol")
                SELECT cursor_4c_VldCol
                THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_VldCol.Colecoes)
                THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_VldCol.Descs)
            ELSE
                THIS.txt_4c_Col.Value  = ""
                THIS.txt_4c_DCol.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Cole" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_VldCol")
            USE IN cursor_4c_VldCol
        ENDIF
        THIS.OnChangeCol()
    ENDPROC

    PROCEDURE ValidarColecaoDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_cSQL, loc_oErro
        loc_cDesc = ALLTRIM(THIS.txt_4c_DCol.Value)
        IF EMPTY(loc_cDesc) OR !EMPTY(ALLTRIM(THIS.txt_4c_Col.Value))
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Descs LIKE " + ;
                       EscaparSQL(loc_cDesc + "%")
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldColD") > 0 AND ;
               USED("cursor_4c_VldColD") AND !EOF("cursor_4c_VldColD")
                SELECT cursor_4c_VldColD
                THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_VldColD.Colecoes)
                THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_VldColD.Descs)
            ELSE
                THIS.txt_4c_Col.Value  = ""
                THIS.txt_4c_DCol.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Cole" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_VldColD")
            USE IN cursor_4c_VldColD
        ENDIF
        THIS.OnChangeCol()
    ENDPROC

    PROCEDURE ValidarLinha(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Lin.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT linhas, descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLin") > 0 AND ;
               USED("cursor_4c_VldLin") AND !EOF("cursor_4c_VldLin")
                SELECT cursor_4c_VldLin
                THIS.txt_4c_Lin.Value = ALLTRIM(cursor_4c_VldLin.linhas)
            ELSE
                THIS.txt_4c_Lin.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Linha")
        ENDTRY
        IF USED("cursor_4c_VldLin")
            USE IN cursor_4c_VldLin
        ENDIF
    ENDPROC

    PROCEDURE ValidarLocalProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Local.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLoc") > 0 AND ;
               USED("cursor_4c_VldLoc") AND !EOF("cursor_4c_VldLoc")
                SELECT cursor_4c_VldLoc
                THIS.txt_4c_Local.Value = ALLTRIM(cursor_4c_VldLoc.codigos)
            ELSE
                THIS.txt_4c_Local.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Local do Produto")
        ENDTRY
        IF USED("cursor_4c_VldLoc")
            USE IN cursor_4c_VldLoc
        ENDIF
    ENDPROC

    PROCEDURE ValidarLocalEtiqueta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Localizas.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocE") > 0 AND ;
               USED("cursor_4c_VldLocE") AND !EOF("cursor_4c_VldLocE")
                SELECT cursor_4c_VldLocE
                THIS.txt_4c_Localizas.Value = ALLTRIM(cursor_4c_VldLocE.codigos)
            ELSE
                THIS.txt_4c_Localizas.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Local da Etiqueta")
        ENDTRY
        IF USED("cursor_4c_VldLocE")
            USE IN cursor_4c_VldLocE
        ENDIF
    ENDPROC

    PROCEDURE ValidarPromocao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_cSQL, loc_oErro
        loc_cCod = ALLTRIM(THIS.txt_4c_Promos.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT promos FROM SigPrPmc WHERE promos = " + EscaparSQL(loc_cCod)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPmc") > 0 AND ;
               USED("cursor_4c_VldPmc") AND !EOF("cursor_4c_VldPmc")
                SELECT cursor_4c_VldPmc
                THIS.txt_4c_Promos.Value = ALLTRIM(cursor_4c_VldPmc.promos)
            ELSE
                THIS.txt_4c_Promos.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Promo" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_VldPmc")
            USE IN cursor_4c_VldPmc
        ENDIF
    ENDPROC

    *==========================================================================
    * ABRIR BUSCA - Pickers usando FormBuscaAuxiliar (Modo 1: SELECT no Init)
    *==========================================================================

    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, "Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Empresa")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaEmpresaDesc()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, "Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Empresa")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_NmOperacao.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpd", "cursor_4c_BuscaOp", "dopps", loc_cValor, ;
                "Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_NmOperacao.Value = ALLTRIM(cursor_4c_BuscaOp.dopps)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
                        THIS.txt_4c_NmOperacao.Value = ALLTRIM(cursor_4c_BuscaOp.dopps)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_BuscaOp")
            USE IN cursor_4c_BuscaOp
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaIndustria()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_NmIndustria.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpd", "cursor_4c_BuscaInd", "dopps", loc_cValor, ;
                "Ind" + CHR(250) + "stria")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_NmIndustria.Value = ALLTRIM(cursor_4c_BuscaInd.dopps)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaInd")
                        THIS.txt_4c_NmIndustria.Value = ALLTRIM(cursor_4c_BuscaInd.dopps)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Ind" + CHR(250) + "stria")
        ENDTRY
        IF USED("cursor_4c_BuscaInd")
            USE IN cursor_4c_BuscaInd
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupoEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrEst", "codigos", loc_cValor, ;
                "Grupo Estoque")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                    THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
                        THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                        THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Grupo Estoque")
        ENDTRY
        IF USED("cursor_4c_BuscaGrEst")
            USE IN cursor_4c_BuscaGrEst
        ENDIF
        THIS.OnChangeCdGrEstoque()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupoEstoqueDesc()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cValor, ;
                "Grupo Estoque")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                    THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
                        THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                        THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Grupo Estoque")
        ENDTRY
        IF USED("cursor_4c_BuscaGrEst")
            USE IN cursor_4c_BuscaGrEst
        ENDIF
        THIS.OnChangeCdGrEstoque()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_cGrupo, loc_cFiltro, loc_oErro
        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDGFC", "cursor_4c_BuscaEst", "contas", loc_cValor, ;
                "Estoque", .F., .T., loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEst.contas)
                    THIS.txt_4c_DsEstoque.Value = ""
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("contas", "", "Estoque")
                    loc_oBusca.mAddColuna("grupos", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEst")
                        THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEst.contas)
                        THIS.txt_4c_DsEstoque.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Estoque")
        ENDTRY
        IF USED("cursor_4c_BuscaEst")
            USE IN cursor_4c_BuscaEst
        ENDIF
        THIS.ValidarEstoque()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Cod.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, "Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Produto")
        ENDTRY
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaProdutoDesc()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Dcod.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "DPros", loc_cValor, "Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Produto")
        ENDTRY
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrandeGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_GdeGrupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", loc_cValor, ;
                "Grande Grupo")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_GdeGrupo.Value = ALLTRIM(cursor_4c_BuscaGpr.codigos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
                        THIS.txt_4c_GdeGrupo.Value = ALLTRIM(cursor_4c_BuscaGpr.codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Grande Grupo")
        ENDTRY
        IF USED("cursor_4c_BuscaGpr")
            USE IN cursor_4c_BuscaGpr
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupoProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Cgru.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "cgrus", loc_cValor, ;
                "Grupo Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                    THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                        THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Grupo Produto")
        ENDTRY
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        THIS.OnChangeCgru()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupoProdutoDesc()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Dgru.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "dgrus", loc_cValor, ;
                "Grupo Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                    THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                        THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Grupo Produto")
        ENDTRY
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        THIS.OnChangeCgru()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaSubGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_cGru, loc_cFiltro, loc_oErro
        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_CSGru.Value)
            loc_cGru    = ALLTRIM(THIS.txt_4c_Cgru.Value)
            loc_cFiltro = IIF(EMPTY(loc_cGru), "", "cgrus = " + EscaparSQL(loc_cGru))
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaPsg", "codigos", loc_cValor, ;
                "Subgrupo", .F., .T., loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
                    THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPsg")
                        THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
                        THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Subgrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaPsg")
            USE IN cursor_4c_BuscaPsg
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaSubGrupoDesc()
        LOCAL loc_oBusca, loc_cValor, loc_cGru, loc_cFiltro, loc_oErro
        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_DSGru.Value)
            loc_cGru    = ALLTRIM(THIS.txt_4c_Cgru.Value)
            loc_cFiltro = IIF(EMPTY(loc_cGru), "", "cgrus = " + EscaparSQL(loc_cGru))
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaPsg", "descricaos", loc_cValor, ;
                "Subgrupo", .F., .T., loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
                    THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPsg")
                        THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
                        THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Subgrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaPsg")
            USE IN cursor_4c_BuscaPsg
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaColecao()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Col.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cValor, ;
                "Cole" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.Descs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                        THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                        THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.Descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Cole" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_BuscaCol")
            USE IN cursor_4c_BuscaCol
        ENDIF
        THIS.OnChangeCol()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaColecaoDesc()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_DCol.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "Descs", loc_cValor, ;
                "Cole" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.Descs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                        THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                        THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.Descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Cole" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_BuscaCol")
            USE IN cursor_4c_BuscaCol
        ENDIF
        THIS.OnChangeCol()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaLinha()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Lin.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "linhas", loc_cValor, "Linha")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Lin.Value = ALLTRIM(cursor_4c_BuscaLin.linhas)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX", "Linhas")
                    loc_oBusca.mAddColuna("descs",  "",           "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
                        THIS.txt_4c_Lin.Value = ALLTRIM(cursor_4c_BuscaLin.linhas)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Linha")
        ENDTRY
        IF USED("cursor_4c_BuscaLin")
            USE IN cursor_4c_BuscaLin
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaLocalProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Local.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLoc", "codigos", loc_cValor, ;
                "Local do Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLoc.codigos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
                        THIS.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLoc.codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Local do Produto")
        ENDTRY
        IF USED("cursor_4c_BuscaLoc")
            USE IN cursor_4c_BuscaLoc
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaLocalEtiqueta()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Localizas.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLocE", "codigos", loc_cValor, ;
                "Local da Etiqueta")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Localizas.Value = ALLTRIM(cursor_4c_BuscaLocE.codigos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocE")
                        THIS.txt_4c_Localizas.Value = ALLTRIM(cursor_4c_BuscaLocE.codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Local da Etiqueta")
        ENDTRY
        IF USED("cursor_4c_BuscaLocE")
            USE IN cursor_4c_BuscaLocE
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaPromocao()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Promos.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrPmc", "cursor_4c_BuscaPmc", "promos", loc_cValor, ;
                "Promo" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    THIS.txt_4c_Promos.Value = ALLTRIM(cursor_4c_BuscaPmc.promos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("promos", "", "Promo" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPmc")
                        THIS.txt_4c_Promos.Value = ALLTRIM(cursor_4c_BuscaPmc.promos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Promo" + CHR(231) + CHR(227) + "o")
        ENDTRY
        IF USED("cursor_4c_BuscaPmc")
            USE IN cursor_4c_BuscaPmc
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com valores dos campos de filtro do form
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                RETURN
            ENDIF

            loc_oBO.this_cCdEmpresa   = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            loc_oBO.this_cDsEmpresa   = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            loc_oBO.this_dDtInicial   = THIS.txt_4c_Datai.Value
            loc_oBO.this_dDtFinal     = THIS.txt_4c_Dataf.Value
            loc_oBO.this_cNmOperacao  = ALLTRIM(THIS.txt_4c_NmOperacao.Value)
            loc_oBO.this_cNmIndustria = ALLTRIM(THIS.txt_4c_NmIndustria.Value)
            loc_oBO.this_nNumero      = THIS.txt_4c_Numero.Value
            loc_oBO.this_nNumerof     = THIS.txt_4c_Numerof.Value
            loc_oBO.this_cCodProduto  = ALLTRIM(THIS.txt_4c_Cod.Value)
            loc_oBO.this_cDsProduto   = ALLTRIM(THIS.txt_4c_Dcod.Value)
            loc_oBO.this_nEtiqIni     = THIS.txt_4c_Etii.Value
            loc_oBO.this_nEtiqFim     = THIS.txt_4c_Etif.Value
            loc_oBO.this_nQtdEti      = THIS.txt_4c_QtdEti.Value
            loc_oBO.this_cCdGrEstoque = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_oBO.this_cDsGrEstoque = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            loc_oBO.this_cCdEstoque   = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            loc_oBO.this_cDsEstoque   = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
            loc_oBO.this_cGdeGrupo    = ALLTRIM(THIS.txt_4c_GdeGrupo.Value)
            loc_oBO.this_cCgru        = ALLTRIM(THIS.txt_4c_Cgru.Value)
            loc_oBO.this_cDgru        = ALLTRIM(THIS.txt_4c_Dgru.Value)
            loc_oBO.this_cCSGru       = ALLTRIM(THIS.txt_4c_CSGru.Value)
            loc_oBO.this_cDSGru       = ALLTRIM(THIS.txt_4c_DSGru.Value)
            loc_oBO.this_cCol         = ALLTRIM(THIS.txt_4c_Col.Value)
            loc_oBO.this_cDCol        = ALLTRIM(THIS.txt_4c_DCol.Value)
            loc_oBO.this_cLin         = ALLTRIM(THIS.txt_4c_Lin.Value)
            loc_oBO.this_cLocal       = ALLTRIM(THIS.txt_4c_Local.Value)
            loc_oBO.this_cLocalizas   = ALLTRIM(THIS.txt_4c_Localizas.Value)
            loc_oBO.this_cPromos      = ALLTRIM(THIS.txt_4c_Promos.Value)
            loc_oBO.this_nOrdem       = THIS.obj_4c_GetOrdem.Value
            loc_oBO.this_nOptMarcas   = THIS.obj_4c_OptMarcas.Value
            loc_oBO.this_nChkPreco    = THIS.obj_4c_ChkPreco.Value
            loc_oBO.this_cTipo        = THIS.this_cTipo
            loc_oBO.this_cOpEscolha   = THIS.this_cOpEscolha

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do form com valores do BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                RETURN
            ENDIF

            THIS.txt_4c_CdEmpresa.Value   = ALLTRIM(loc_oBO.this_cCdEmpresa)
            THIS.txt_4c_DsEmpresa.Value   = ALLTRIM(loc_oBO.this_cDsEmpresa)
            THIS.txt_4c_Datai.Value       = loc_oBO.this_dDtInicial
            THIS.txt_4c_Dataf.Value       = loc_oBO.this_dDtFinal
            THIS.txt_4c_NmOperacao.Value  = ALLTRIM(loc_oBO.this_cNmOperacao)
            THIS.txt_4c_NmIndustria.Value = ALLTRIM(loc_oBO.this_cNmIndustria)
            THIS.txt_4c_Numero.Value      = loc_oBO.this_nNumero
            THIS.txt_4c_Numerof.Value     = loc_oBO.this_nNumerof
            THIS.txt_4c_Cod.Value         = ALLTRIM(loc_oBO.this_cCodProduto)
            THIS.txt_4c_Dcod.Value        = ALLTRIM(loc_oBO.this_cDsProduto)
            THIS.txt_4c_Etii.Value        = loc_oBO.this_nEtiqIni
            THIS.txt_4c_Etif.Value        = loc_oBO.this_nEtiqFim
            THIS.txt_4c_QtdEti.Value      = loc_oBO.this_nQtdEti
            THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(loc_oBO.this_cCdGrEstoque)
            THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(loc_oBO.this_cDsGrEstoque)
            THIS.txt_4c_CdEstoque.Value   = ALLTRIM(loc_oBO.this_cCdEstoque)
            THIS.txt_4c_DsEstoque.Value   = ALLTRIM(loc_oBO.this_cDsEstoque)
            THIS.txt_4c_GdeGrupo.Value    = ALLTRIM(loc_oBO.this_cGdeGrupo)
            THIS.txt_4c_Cgru.Value        = ALLTRIM(loc_oBO.this_cCgru)
            THIS.txt_4c_Dgru.Value        = ALLTRIM(loc_oBO.this_cDgru)
            THIS.txt_4c_CSGru.Value       = ALLTRIM(loc_oBO.this_cCSGru)
            THIS.txt_4c_DSGru.Value       = ALLTRIM(loc_oBO.this_cDSGru)
            THIS.txt_4c_Col.Value         = ALLTRIM(loc_oBO.this_cCol)
            THIS.txt_4c_DCol.Value        = ALLTRIM(loc_oBO.this_cDCol)
            THIS.txt_4c_Lin.Value         = ALLTRIM(loc_oBO.this_cLin)
            THIS.txt_4c_Local.Value       = ALLTRIM(loc_oBO.this_cLocal)
            THIS.txt_4c_Localizas.Value   = ALLTRIM(loc_oBO.this_cLocalizas)
            THIS.txt_4c_Promos.Value      = ALLTRIM(loc_oBO.this_cPromos)
            THIS.obj_4c_GetOrdem.Value    = loc_oBO.this_nOrdem
            THIS.obj_4c_OptMarcas.Value   = loc_oBO.this_nOptMarcas
            THIS.obj_4c_ChkPreco.Value    = loc_oBO.this_nChkPreco
            THIS.this_cTipo               = ALLTRIM(loc_oBO.this_cTipo)

            *-- Reaplica restricoes condicionais apos popular os campos
            THIS.OnChangeCdGrEstoque()
            THIS.OnChangeNmOperacao()
            THIS.OnChangeCgru()
            THIS.OnChangeEtif()
            THIS.OnChangeCol()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles de filtro.
    * par_lHabilitar=.T. habilita todos (reaplica restricoes condicionais do legado).
    * par_lHabilitar=.F. desabilita todos (sem excecao).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oErro
        loc_lHab = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
        TRY
            THIS.txt_4c_Datai.Enabled       = loc_lHab
            THIS.txt_4c_Dataf.Enabled       = loc_lHab
            THIS.txt_4c_CdEmpresa.Enabled   = loc_lHab
            THIS.txt_4c_DsEmpresa.Enabled   = loc_lHab
            THIS.txt_4c_NmOperacao.Enabled  = loc_lHab
            THIS.txt_4c_NmIndustria.Enabled = loc_lHab
            THIS.txt_4c_Cod.Enabled         = loc_lHab
            THIS.txt_4c_Dcod.Enabled        = loc_lHab
            THIS.txt_4c_Etii.Enabled        = loc_lHab
            THIS.txt_4c_GdeGrupo.Enabled    = loc_lHab
            THIS.txt_4c_Cgru.Enabled        = loc_lHab
            THIS.txt_4c_Lin.Enabled         = loc_lHab
            THIS.txt_4c_Local.Enabled       = loc_lHab
            THIS.txt_4c_Localizas.Enabled   = loc_lHab
            THIS.txt_4c_Promos.Enabled      = loc_lHab
            THIS.obj_4c_GetOrdem.Enabled    = loc_lHab
            THIS.obj_4c_OptMarcas.Enabled   = loc_lHab
            THIS.obj_4c_ChkPreco.Enabled    = loc_lHab

            IF loc_lHab
                *-- Reaplica restricoes condicionais do legado (When logic)
                THIS.OnChangeCdGrEstoque()
                THIS.OnChangeNmOperacao()
                THIS.OnChangeCgru()
                THIS.OnChangeEtif()
                THIS.OnChangeCol()
            ELSE
                THIS.txt_4c_DsGrEstoque.Enabled = .F.
                THIS.txt_4c_CdEstoque.Enabled   = .F.
                THIS.txt_4c_DsEstoque.Enabled   = .F.
                THIS.txt_4c_Numero.Enabled      = .F.
                THIS.txt_4c_Numerof.Enabled     = .F.
                THIS.txt_4c_Dgru.Enabled        = .F.
                THIS.txt_4c_CSGru.Enabled       = .F.
                THIS.txt_4c_DSGru.Enabled       = .F.
                THIS.txt_4c_Etif.Enabled        = .F.
                THIS.txt_4c_QtdEti.Enabled      = .F.
                THIS.txt_4c_DCol.Enabled        = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de filtro (delega para InicializarCampos)
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.InicializarCampos()
    ENDPROC

    *==========================================================================
    * CarregarLista - Form OPERACIONAL sem lista: retorna .T. por compatibilidade
    * com o ciclo de vida FormBase/pipeline (nao ha grid de registros neste form).
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - OPERACIONAL: garante que todos os botoes do
    * CommandGroup obj_4c_Sair estejam visiveis e habilitados.
    * Nao ha alternancia de modo neste form (modo unico OPERACIONAL).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            WITH THIS.obj_4c_Sair
                .Buttons(1).Enabled = .T.
                .Buttons(1).Visible = .T.
                .Buttons(2).Enabled = .T.
                .Buttons(2).Visible = .T.
                .Buttons(3).Enabled = .T.
                .Buttons(3).Visible = .T.
                .Buttons(4).Enabled = .T.
                .Buttons(4).Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            *-- Botoes criados em InicializarForm; falha aqui nao e critica
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre SigOpIpE em modo CONSULTA com filtros do form
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN THIS.BtnConsultaClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Para form OPERACIONAL: confirma filtros e executa consulta.
    * Sincroniza BO com o estado atual do form antes de disparar a acao.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        RETURN THIS.BtnConsultaClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Limpa todos os campos de filtro do form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Opd")
            USE IN cursor_4c_Opd
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):
*==============================================================================
* SigPrRetBO.PRG
* Business Object - Operacional: Retorno de Estoque (Etiquetas)
*
* Herda de BusinessBase
* Form de filtros que abre SigOpIpE com variaveis PRIVATE.
* Sem CRUD - armazena parametros de filtro para consulta/digitacao/arquivadas.
*==============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *-- Sem tabela primaria (form operacional de filtros)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Operacao / Industria / Numero NF
    this_cNmOperacao  = ""
    this_cNmIndustria = ""
    this_nNumero      = 0
    this_nNumerof     = 0

    *-- Produto (SigCdPro: CPros / DPros)
    this_cCodProduto  = ""
    this_cDsProduto   = ""

    *-- Etiqueta (SigOpEtq: CBars n(14))
    this_nEtiqIni     = 0
    this_nEtiqFim     = 0
    this_nQtdEti      = 0

    *-- Grupo Estoque / Estoque
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Grande Grupo (SigCdGpr: Codigos char(3))
    this_cGdeGrupo    = ""

    *-- Grupo Produto (SigCdGrp: CGrus char(3) / DGrus char(20))
    this_cCgru        = ""
    this_cDgru        = ""

    *-- Sub-Grupo (SigCdPsg: Codigos char(6) / Descricaos char(20))
    this_cCSGru       = ""
    this_cDSGru       = ""

    *-- Grupo Venda / Colecao (SigCdCol: Colecoes / Descs)
    this_cCol         = ""
    this_cDCol        = ""

    *-- Linha (SigCdLin: linhas char(10))
    this_cLin         = ""

    *-- Local do Produto (SigPrLcl: Codigos char(10))
    this_cLocal       = ""

    *-- Local da Etiqueta (SigPrLcl: Codigos char(10))
    this_cLocalizas   = ""

    *-- Promocao (SigPrPmc: promos char(25))
    this_cPromos      = ""

    *-- Opcoes de impressao / ordenacao
    this_nOrdem       = 1
    this_nOptMarcas   = 1
    this_nChkPreco    = 2

    *-- Controle interno
    this_cTipo        = ""
    this_cOpEscolha   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem tabela primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_* a partir de cursor com parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCdEmpresa   = TratarNulo(CdEmpresa,   "C")
                THIS.this_cDsEmpresa   = TratarNulo(DsEmpresa,   "C")
                THIS.this_dDtInicial   = TratarNulo(DtInicial,   "D")
                THIS.this_dDtFinal     = TratarNulo(DtFinal,     "D")
                THIS.this_cNmOperacao  = TratarNulo(NmOperacao,  "C")
                THIS.this_cNmIndustria = TratarNulo(NmIndustria, "C")
                THIS.this_nNumero      = TratarNulo(Numero,      "N")
                THIS.this_nNumerof     = TratarNulo(Numerof,     "N")
                THIS.this_cCodProduto  = TratarNulo(CPros,       "C")
                THIS.this_cDsProduto   = TratarNulo(DPros,       "C")
                THIS.this_nEtiqIni     = TratarNulo(EtiqIni,     "N")
                THIS.this_nEtiqFim     = TratarNulo(EtiqFim,     "N")
                THIS.this_nQtdEti      = TratarNulo(QtdEti,      "N")
                THIS.this_cCdGrEstoque = TratarNulo(CdGrEstoque, "C")
                THIS.this_cDsGrEstoque = TratarNulo(DsGrEstoque, "C")
                THIS.this_cCdEstoque   = TratarNulo(CdEstoque,   "C")
                THIS.this_cDsEstoque   = TratarNulo(DsEstoque,   "C")
                THIS.this_cGdeGrupo    = TratarNulo(GdeGrupo,    "C")
                THIS.this_cCgru        = TratarNulo(CGrus,       "C")
                THIS.this_cDgru        = TratarNulo(DGrus,       "C")
                THIS.this_cCSGru       = TratarNulo(CSGru,       "C")
                THIS.this_cDSGru       = TratarNulo(DSGru,       "C")
                THIS.this_cCol         = TratarNulo(Colecoes,    "C")
                THIS.this_cDCol        = TratarNulo(Descs,       "C")
                THIS.this_cLin         = TratarNulo(Linhas,      "C")
                THIS.this_cLocal       = TratarNulo(CdLocal,     "C")
                THIS.this_cLocalizas   = TratarNulo(Localizas,   "C")
                THIS.this_cPromos      = TratarNulo(Promos,      "C")
                THIS.this_nOrdem       = TratarNulo(Ordem,       "N")
                THIS.this_nOptMarcas   = TratarNulo(OptMarcas,   "N")
                THIS.this_nChkPreco    = TratarNulo(ChkPreco,    "N")
                THIS.this_cTipo        = TratarNulo(Tipo,        "C")
                THIS.this_cOpEscolha   = TratarNulo(OpEscolha,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Carrega SigCdOpd para lookup de operacoes por SEEK
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("SigCdOpd")
                USE IN SigCdOpd
            ENDIF
            loc_cSQL = "SELECT a.* FROM SigCdOpd a"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd") > 0
                SELECT SigCdOpd
                INDEX ON dopps TAG dopps
                SET ORDER TO
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEtiqueta - Resolve CBars via SigOpEtq + SigOpEta (renomeadas)
    * Retorna 0 se invalido, ou o CBars resolvido se encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEtiqueta(par_nCBars)
        LOCAL loc_nResultado, loc_cSQL, loc_oErro, loc_lcCBars
        loc_nResultado = 0
        TRY
            loc_lcCBars = ALLTRIM(STR(par_nCBars, 14))
            loc_cSQL = "SELECT a.CPros, a.CBars " + ;
                       "FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.CBars = " + loc_lcCBars + ;
                       " OR b.cbars_old = " + loc_lcCBars + ")"
            IF USED("cursor_4c_EtiqTemp")
                USE IN cursor_4c_EtiqTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqTemp") > 0
                SELECT cursor_4c_EtiqTemp
                GO TOP
                IF !EOF("cursor_4c_EtiqTemp")
                    loc_nResultado = cursor_4c_EtiqTemp.CBars
                ENDIF
                USE IN cursor_4c_EtiqTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar etiqueta")
        ENDTRY
        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaCadastrada - Confirma existencia de CBars em SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaCadastrada(par_nCBars)
        LOCAL loc_lExiste, loc_cSQL, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 CBars FROM SigOpEtq " + ;
                       "WHERE CBars = " + ALLTRIM(STR(par_nCBars, 14))
            IF USED("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqCheck") > 0
                SELECT cursor_4c_EtiqCheck
                loc_lExiste = !EOF("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar etiqueta")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL de filtros sem persistencia em tabela propria.
    * Valida parametros minimos e registra auditoria da operacao (Consulta/Impressao).
    * Nao ha INSERT em base porque o legado usa SigOpIpE via variaveis PRIVATE
    * e a acao efetiva do form eh disparar consulta/impressao para SigCdPro/SigOpEtq.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("CONSULTA_ETIQUETA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL: re-executa consulta com filtros atualizados.
    * Nao ha UPDATE em base porque nao existe tabela primaria (form de filtros).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REEXECUCAO_FILTRO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica coerencia minima dos filtros do form operacional.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                MsgAviso("Data Final deve ser maior ou igual a Data Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND THIS.this_nEtiqIni > 0 AND THIS.this_nEtiqFim > 0
            IF THIS.this_nEtiqFim < THIS.this_nEtiqIni
                MsgAviso("Etiqueta Final deve ser maior ou igual a Etiqueta Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND !EMPTY(THIS.this_nNumero) AND !EMPTY(THIS.this_nNumerof)
            IF THIS.this_nNumerof < THIS.this_nNumero
                MsgAviso("N" + CHR(250) + "mero Final deve ser maior ou igual ao N" + CHR(250) + "mero Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao do form em LogAuditoria (SQL Server).
    * Como nao ha chave primaria, usa hash textual dos filtros como identificador.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cDetalhe, loc_oErro
        TRY
            loc_cDetalhe = "Emp=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                           " Prod=" + ALLTRIM(THIS.this_cCodProduto) + ;
                           " Grp=" + ALLTRIM(THIS.this_cCgru) + ;
                           " Est=" + ALLTRIM(THIS.this_cCdEstoque) + ;
                           " DtI=" + DTOC(THIS.this_dDtInicial) + ;
                           " DtF=" + DTOC(THIS.this_dDtFinal) + ;
                           " EtqI=" + ALLTRIM(STR(THIS.this_nEtiqIni, 14)) + ;
                           " EtqF=" + ALLTRIM(STR(THIS.this_nEtiqFim, 14))
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, ChaveRegistro, Operacao, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("SigPrRet") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(LEFT(loc_cDetalhe, 500)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

