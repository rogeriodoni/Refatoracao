# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-28 16:16:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 16:16:57] [INFO] Config FPW: (nao fornecido)
[2026-09-28 16:16:57] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 16:16:57] [INFO] Timeout: 300 segundos
[2026-09-28 16:16:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahk1li2r.prg
[2026-09-28 16:16:57] [INFO] Conteudo do wrapper:
[2026-09-28 16:16:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrEtq', 'C:\4c\tasks\task609\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEtq', 'C:\4c\tasks\task609\logs\06_testForm.log'
QUIT

[2026-09-28 16:16:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahk1li2r.prg
[2026-09-28 16:16:57] [INFO] VFP output esperado em: C:\4c\tasks\task609\vfp_output.txt
[2026-09-28 16:16:57] [INFO] Executando Visual FoxPro 9...
[2026-09-28 16:16:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahk1li2r.prg
[2026-09-28 16:16:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahk1li2r.prg
[2026-09-28 16:16:57] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrEtq
Inicio: 28/09/2026 16:16:58

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 16:20:09
Duracao: 191 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 16:20:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 16:20:09] [INFO] VFP9 finalizado em 191.9270022 segundos
[2026-09-28 16:20:09] [INFO] Exit Code: 
[2026-09-28 16:20:09] [INFO] 
[2026-09-28 16:20:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 16:20:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahk1li2r.prg
[2026-09-28 16:20:09] [INFO] 
[2026-09-28 16:20:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 16:20:09] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 16:20:09] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 16:20:09] [INFO] * Parameters: 'FormSigPrEtq', 'C:\4c\tasks\task609\logs\06_testForm.log'
[2026-09-28 16:20:09] [INFO] 
[2026-09-28 16:20:09] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 16:20:09] [INFO] SET SAFETY OFF
[2026-09-28 16:20:09] [INFO] SET RESOURCE OFF
[2026-09-28 16:20:09] [INFO] SET TALK OFF
[2026-09-28 16:20:09] [INFO] SET NOTIFY OFF
[2026-09-28 16:20:09] [INFO] SYS(2335, 0)
[2026-09-28 16:20:09] [INFO] 
[2026-09-28 16:20:09] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEtq', 'C:\4c\tasks\task609\logs\06_testForm.log'
[2026-09-28 16:20:09] [INFO] QUIT
[2026-09-28 16:20:09] [INFO] 
[2026-09-28 16:20:09] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 16:20:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg):
*------------------------------------------------------------------------------
* FormSigPrEtq.prg - Form Operacional: Impressao de Etiquetas Selecionadas
* Herda de FormBase
* Migrado de SIGPRETQ.SCX
* Legado: raiz "form" generico, SEM PageFrame (nenhum BaseClass: pageframe na
* arvore de objetos do dump) - layout FLAT COM CONTAINER (cntSombra +
* Cnt_Impressora). Nao existe Page1/Page2 a reproduzir: os demais controles
* (grid, option groups, campos, botoes) entram direto sobre THIS nas
* proximas fases.
* Tabela de referencia: SigCdPro (produtos que recebem etiqueta)
*
* SUPERFICIE DE ACAO (o legado NAO tem CRUD): os unicos botoes do SCX sao
* btnCarregar (carrega itens da movimentacao), btnexcluir (remove a linha
* corrente da grade) e o CommandGroup BTNREPORT, com Imprimir e Encerrar.
* Nao existe no legado botao de Salvar, de Cancelar nem de Buscar, nao ha
* Page1(Lista)/Page2(Dados) e nao ha modo de edicao: a tela monta uma
* selecao de etiquetas em cursor local e a envia para a impressora. Os
* metodos correspondentes a esses botoes inexistentes NAO foram criados -
* inventa-los violaria o PILAR 1 e a regra "NUNCA inventar", e cria-los
* vazios violaria a regra de completude.
*
* O que a consolidacao final acrescentou (cada item eh comportamento do Init
* legado que faltava, nao convencao nova):
*   - BOParaForm/CarregarParametrosPadrao: os defaults de SigCdPam (ImpEtis,
*     AjVerts, AjHorzs) e SigCdPac (AjDens, AjVelos, EtqSeps) chegam aos
*     controles. Antes os spinners abriam com constantes cravadas no codigo e
*     SigPrEtqBO.CarregarParametrosImpressao nunca era chamado.
*   - AplicarAcessosUsuario: as seis chamadas fChecaAcesso('SigPrEtq', ...)
*     que travam os ajustes finos e o tipo de etiqueta.
*   - HabilitarCampos: aplica esse teto de permissao e libera o botao
*     Imprimir so com tipo de etiqueta E impressora disponiveis
*     (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)).
*   - FormParaBO: o bloco de leitura de controles que abre o BTNREPORT.Click.
*   - CriarCursorImpressorasWindows: passou a casar as impressoras do Windows
*     com as de ETIQUETA autorizadas ao usuario (SigCdmp.nTpImpres = 2 via
*     SigSyImp/SigCdAcG). Antes listava TODAS as impressoras do Windows.
*   - CarregarLista/LimparCampos: centralizam o "Go Top + Append Blank +
*     Grade.Refresh" e o reset pos-impressao que estavam repetidos.
*------------------------------------------------------------------------------
DEFINE CLASS FormSigPrEtq AS FormBase

    *-- Propriedades visuais identicas ao original SIGPRETQ.SCX
    this_cMensagemErro = ""
    Height      = 700
    Width       = 833
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Permissoes do usuario logado (fChecaAcesso('SigPrEtq', <parametro>) no
    *-- Init legado). Guardadas como property para que HabilitarCampos() nunca
    *-- LIBERE um controle que o acesso do usuario mantem bloqueado - o teto de
    *-- permissao vale em qualquer estado da tela.
    this_lAcVertical    = .T.   && fChecaAcesso('SigPrEtq', 'VERTICAL')
    this_lAcHorizontal  = .T.   && fChecaAcesso('SigPrEtq', 'HORIZONTAL')
    this_lAcDensidade   = .T.   && fChecaAcesso('SigPrEtq', 'DENSIDADE')
    this_lAcVelocidade  = .T.   && fChecaAcesso('SigPrEtq', 'VELOCIDADE')
    this_lAcTipo        = .T.   && fChecaAcesso('SigPrEtq', 'TIPO')

    *-- Contagens usadas pelo legado para liberar o botao Imprimir
    *-- (BtnReport.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0))
    this_nTotalTipos      = 0
    this_nTotalImpressoras = 0

    *-- Foco inicial na grade ja aplicado? (ver Activate)
    this_lFocoAplicado = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")

            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaDados()
            THIS.CriarCursorDados()
            THIS.ConfigurarGridEtiquetas()
            THIS.ConfigurarLookupsGrade()
            THIS.ConfigurarBotoesGrade()
            THIS.CriarCursorImpressorasWindows()
            THIS.ConfigurarCamposImpressao()
            THIS.PopularOpcoesTipoEtiqueta()
            THIS.ConfigurarBotaoRelatorio()
            THIS.TornarControlesVisiveis()

            *-- Consolidacao final (ordem do Init legado, apos montar a tela):
            *-- 1) parametros de SigCdPam/SigCdPac chegam aos controles;
            *-- 2) fChecaAcesso trava os ajustes finos que o usuario nao pode
            *--    alterar e HabilitarCampos aplica esse teto + libera/bloqueia
            *--    o botao Imprimir conforme (tipos <> 0 And impressoras <> 0);
            *-- 3) a grade recebe a linha em branco e o Refresh que o legado
            *--    sempre faz (regra CLAUDE.md #21a).
            THIS.BOParaForm()
            THIS.AplicarAcessosUsuario()
            THIS.HabilitarCampos(.T.)
            THIS.CarregarLista()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Inicializar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi a faixa de cabecalho (cntSombra no
    * legado -> cnt_4c_Sombra no mapeamento.json). Este form OPERACIONAL nao
    * tem PageFrame nenhum no SCX legado (regra CLAUDE.md - "NUNCA inventar"
    * estrutura que o legado nao tem): o metodo mantem o nome pelo padrao ja
    * adotado nos demais forms FLAT (ver FormSIGMDETQ), mas so monta a faixa
    * superior. Grid, OptionGroups, Cnt_Impressora e botoes entram direto
    * sobre THIS nas proximas fases (4 a 8).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Campos principais (Parte 1/2): bloco de Lista de
    * Precos (Label2/chkLista/Get_lpreco/getLPreco2) e bloco de Movimentacao
    * (Label4/chkOperacoes/Label5/Label6/Label7/getEmps/getDopes/getNumes),
    * alem do titulo da grade (lbl_titulo). Sao os campos ja referenciados por
    * CarregarDados()/BtnCarregarClick() (Fase 4) - sem eles o Init ja
    * compilava, mas a tela abria sem nenhum campo de captura, e clicar em
    * Carregar estourava "Property TXT_4C_EMPS is not found" (regra
    * CLAUDE.md #33 - propriedade que a classe/form nao tem so estoura em
    * runtime). Bloco de Opt_Tipo/Cnt_Impressora/opcoes de relatorio fica
    * para a Fase 6 (Parte 2).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Say2 "Lista de Precos" (mnemonico \< do legado preservado)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 86
            .Left      = 20
            .Width     = 130
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "\<Lista de Pre" + CHR(231) + "os"
            .Visible   = .T.
        ENDWITH

        *-- chkLista "Carrega Itens" (Value=1 = marcado por default, legado)
        THIS.AddObject("chk_4c_ChkLista", "CheckBox")
        WITH THIS.chk_4c_ChkLista
            .Top       = 102
            .Left      = 24
            .Width     = 100
            .Height    = 15
            .Caption   = "Carrega " + CHR(205) + "tens"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = IIF(THIS.this_oBusinessObject.this_lCarregaItensLista, 1, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkLista, "Click", THIS, "ChkListaClick")

        *-- Get_lpreco - lookup fwbuscaext(SigCdLpc, LPrecos) - lista principal
        THIS.AddObject("txt_4c_Lpreco", "TextBox")
        WITH THIS.txt_4c_Lpreco
            .Top       = 105
            .Left      = 132
            .Width     = 294
            .Height    = 22
            .MaxLength = 30
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "Txt4cLprecoKeyPress")

        *-- getLPreco2 - lookup fwbuscaext(SigCdLpc, LPrecos) - lista secundaria
        THIS.AddObject("txt_4c_LPreco2", "TextBox")
        WITH THIS.txt_4c_LPreco2
            .Top       = 128
            .Left      = 132
            .Width     = 294
            .Height    = 22
            .MaxLength = 30
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "Txt4cLPreco2KeyPress")

        *-- Label4 "Movimentacoes"
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 154
            .Left      = 20
            .Width     = 130
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
            .Visible   = .T.
        ENDWITH

        *-- chkOperacoes "Carrega Itens" (Value=1 = marcado por default, legado)
        THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
        WITH THIS.chk_4c_ChkOperacoes
            .Top       = 169
            .Left      = 24
            .Width     = 100
            .Height    = 15
            .Caption   = "Carrega " + CHR(205) + "tens"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = IIF(THIS.this_oBusinessObject.this_lCarregaItensOperacao, 1, 0)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkOperacoes, "Click", THIS, "ChkOperacoesClick")

        *-- Label5 "Emp" / Label6 "Movimentacao" / Label7 "Codigo"
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 161
            .Left      = 132
            .Width     = 40
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Emp"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 161
            .Left      = 165
            .Width     = 110
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 161
            .Left      = 317
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo"
            .Visible   = .T.
        ENDWITH

        *-- getEmps - fAcessoEmpresa lookup (SigCdEmp.Cemps, char(3))
        THIS.AddObject("txt_4c_Emps", "TextBox")
        WITH THIS.txt_4c_Emps
            .Top       = 174
            .Left      = 132
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "Txt4cEmpsKeyPress")

        *-- getDopes - fAcessoMovmto lookup (SigCdOpe.Dopes, char(20))
        THIS.AddObject("txt_4c_Dopes", "TextBox")
        WITH THIS.txt_4c_Dopes
            .Top       = 174
            .Left      = 165
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "Txt4cDopesKeyPress")

        *-- getNumes - numero da movimentacao (numerico, legado usa Str(...,6))
        THIS.AddObject("txt_4c_Numes", "TextBox")
        WITH THIS.txt_4c_Numes
            .Top        = 174
            .Left       = 317
            .Width      = 52
            .Height     = 23
            .Value      = 0
            .InputMask  = "999999"
            .Format     = "9"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- lbl_titulo (\<Etiquetas Selecionadas) - titulo de secao da grade
        THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
        WITH THIS.lbl_4c_Lbl_titulo
            .Top       = 203
            .Left      = 10
            .Width     = 200
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "\<Etiquetas Selecionadas"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ChkListaClick / ChkOperacoesClick - Espelham o CheckBox.Value (numerico)
    * na property logical correspondente do BO (regra CLAUDE.md - CheckBox
    * Value nunca vai direto para prop LOGICAL sem conversao explicita).
    * PUBLIC: bindado via BINDEVENT.
    *==========================================================================
    PROCEDURE ChkListaClick()
        THIS.this_oBusinessObject.this_lCarregaItensLista = (THIS.chk_4c_ChkLista.Value = 1)
    ENDPROC

    PROCEDURE ChkOperacoesClick()
        THIS.this_oBusinessObject.this_lCarregaItensOperacao = (THIS.chk_4c_ChkOperacoes.Value = 1)
    ENDPROC

    *==========================================================================
    * Txt4cLprecoKeyPress - Lookup da Lista de Precos principal (Get_lpreco no
    * legado). Transcricao do Get_lpreco.Valid: resolve o codigo digitado
    * contra SigCdLpc (fwbuscaext no legado -> FormBuscaAuxiliar/
    * AbrirLookupCanonico aqui), e ao final SEMPRE reconstroi a grade de
    * etiquetas a partir da lista resolvida (mesmo bloco de CarregarDados()).
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE Txt4cLprecoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Lpreco.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarListaPreco(loc_cValor)
            IF !THIS.AbrirLookupCanonico("SigCdLpc", "LPrecos", "LPrecos", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Lista de Pre" + CHR(231) + "os", ;
                    loc_cValor, THIS.txt_4c_Lpreco, .NULL.)
                *-- Legado: This.Value = Iif(Lastkey()=27, '', crListaRemota.LPrecos)
                THIS.txt_4c_Lpreco.Value = ""
            ENDIF
        ENDIF

        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * Txt4cLPreco2KeyPress - Lookup da Lista de Precos secundaria (getLPreco2
    * no legado). Transcricao do getLPreco2.Valid: so resolve o valor, sem
    * disparar carga da grade (o legado nao tem esse bloco nesse campo).
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE Txt4cLPreco2KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_LPreco2.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarListaPreco(loc_cValor)
            IF !THIS.AbrirLookupCanonico("SigCdLpc", "LPrecos", "LPrecos", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Lista de Pre" + CHR(231) + "os", ;
                    loc_cValor, THIS.txt_4c_LPreco2, .NULL.)
                THIS.txt_4c_LPreco2.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Txt4cEmpsKeyPress - Lookup/validacao de Empresa (getEmps no legado,
    * fAcessoEmpresa(Usuar,'C',...) - funcao global NAO PORTADA, ver licao
    * aprendida feedback_facessoempresa_nao_portada). Substitui por
    * BO.ValidarEmpresa + AbrirLookupCanonico sobre SigCdEmp.
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE Txt4cEmpsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarEmpresa(loc_cValor)
            IF !THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
                    loc_cValor, THIS.txt_4c_Emps, .NULL.)
                THIS.txt_4c_Emps.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Txt4cDopesKeyPress - Lookup/validacao de Operacao (getDopes no legado,
    * fAcessoMovmto(Usuar,...) - funcao global NAO PORTADA, mesma familia da
    * licao fAcessoEmpresa). Substitui por BO.ValidarOperacao +
    * AbrirLookupCanonico sobre SigCdOpe. SigCdOpe eh single-column (regra
    * CLAUDE.md - "SigCdOpe eh single-column: NUNCA usar descrs/Descrs"): o
    * mesmo campo Dopes eh passado como codigo E descricao do helper.
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE Txt4cDopesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF par_nKeyCode = 115 OR !THIS.this_oBusinessObject.ValidarOperacao(loc_cValor)
            IF !THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
                    loc_cValor, THIS.txt_4c_Dopes, .NULL.)
                THIS.txt_4c_Dopes.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CriarCursorDados - Cria o cursor da grade de etiquetas selecionadas
    * (equivalente ao dbImpressao criado no Load() do form legado). Mantido
    * em metodo proprio (nao dentro do Load/Init) porque o novo sistema nao
    * separa Load de Init - a estrutura do cursor precisa existir ANTES do
    * ConfigurarGridEtiquetas() fazer o bind do Grid (regra CLAUDE.md #41:
    * Column.ControlSource de cursor que ainda nao existe derruba o Init).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorDados()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            Cpros      C(14), ;
            DPros      C(40), ;
            Reffs      C(40), ;
            Qtds       N(10,3), ;
            QtdeEtiq   N(10,3), ;
            Pedido     C(30), ;
            Obs        C(10), ;
            PVens      N(12,2), ;
            PrecoDe    N(12,2), ;
            Parcelas   N(2,0), ;
            Cpros2     C(14), ;
            Cpros3     C(14), ;
            Cpros4     C(14), ;
            empos      C(3), ;
            empdopnums C(29), ;
            citens     N(10), ;
            Pesos      N(12,2), ;
            CodTams    C(4), ;
            DPro2s     C(45))
        SET NULL OFF

        INDEX ON Cpros TAG Cpros
        INDEX ON RECNO() TAG Registros
        SET ORDER TO
        APPEND BLANK
    ENDPROC

    *==========================================================================
    * ConfigurarGridEtiquetas - Monta o Grd_Etiqueta legado (grd_4c_Dados),
    * com as 7 colunas e a ordem visual exata do SCX (ColumnOrder: cpros=1,
    * DPro2s=2, dpros=3, qtds=4, parcelas=5, PVens=6, PrecoDe=7).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridEtiquetas()
        THIS.AddObject("grd_4c_Dados", "GridBase")
        WITH THIS.grd_4c_Dados
            .Top          = 216
            .Left         = 12
            .Width        = 818
            .Height       = 157
            .ColumnCount  = 7
            .RecordSource = "cursor_4c_Dados"
            .FontName     = "Tahoma"
            .FontSize     = 8
            .HeaderHeight = 17
            .RowHeight    = 17
            .ScrollBars   = 2
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .Visible      = .T.

            WITH .Column1
                .ControlSource     = "cursor_4c_Dados.Cpros"
                .Width             = 110
                .ColumnOrder       = 1
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column2
                .ControlSource     = "cursor_4c_Dados.DPros"
                .Width             = 270
                .ColumnOrder       = 3
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column3
                .ControlSource     = "cursor_4c_Dados.Qtds"
                .Width             = 65
                .ColumnOrder       = 4
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Format            = "999,999.99"
                .InputMask         = "999,999.99"
                .Header1.Caption   = "Quantidade"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column4
                .ControlSource     = "cursor_4c_Dados.DPro2s"
                .Width             = 135
                .ColumnOrder       = 2
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column5
                .ControlSource     = "cursor_4c_Dados.Parcelas"
                .Width             = 60
                .ColumnOrder       = 5
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Parcelas"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column6
                .ControlSource     = "cursor_4c_Dados.PVens"
                .Width             = 70
                .ColumnOrder       = 6
                .Movable           = .F.
                .Resizable         = .F.
                .Enabled           = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Pre" + CHR(231) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column7
                .ControlSource     = "cursor_4c_Dados.PrecoDe"
                .Width             = 70
                .ColumnOrder       = 7
                .Movable           = .F.
                .Resizable         = .F.
                .Enabled           = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Header1.Caption   = "Pre" + CHR(231) + "o De"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarLookupsGrade - Registra os BINDEVENT de KeyPress das colunas
    * editaveis do grd_4c_Dados (col_cpros/col_dpros/col_qtds/col_DPro2s no
    * legado). Colunas de Grid ja nascem com um Text1 default (nao precisa
    * AddObject - regra CLAUDE.md #18 so vale para controle CUSTOM tipo
    * CheckBox/ComboBox/OptionGroup).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookupsGrade()
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ValidarProdutoGrid")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "ValidarDescricaoGrid")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "ValidarQtdGrid")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "ValidarDescritivoGrid")
    ENDPROC

    *==========================================================================
    * ValidarProdutoGrid - Coluna Produto da grade (col_cpros.txt_cpros no
    * legado). Transcricao do Valid legado: resolve EAN13/codigo de barras,
    * bloqueia produto com etiqueta individual, resolve por lookup
    * (fwbuscaext -> AbrirLookupCanonico) e aplica peso/preco/lista de
    * precos na linha corrente do cursor de grade.
    * Nota: o legado tambem chama fVerificarBarras(_Prod) - funcao global
    * NAO PORTADA (SIGFUNCS.PRG). O resultado dela e combinado com "OR
    * Len(_Prod) <= 14" antes de decidir buscar por CBars; como CPros eh
    * char(14), essa segunda condicao e sempre verdadeira para um valor de
    * produto valido e por isso a busca por codigo de barras SEMPRE
    * executa - o wrapper de fVerificarBarras fica sem efeito pratico e foi
    * omitido (regra CLAUDE.md #27, categoria "no-op documentado").
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarProdutoGrid
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCursor, loc_cProd, loc_nCod, loc_cUnidade, ;
              loc_cCodResolvido, loc_nValLista, loc_nValDeLista

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cProd   = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)

        IF EMPTY(loc_cProd)
            THIS.grd_4c_Dados.Column2.Text1.Value = ""
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        *-- Legado: valor puramente numerico pode ser o EAN13 do produto.
        loc_nCod = INT(VAL(loc_cProd))
        IF loc_nCod > 0 AND THIS.this_oBusinessObject.BuscarProdutoPorEan13(loc_nCod, "cursor_4c_ProdEan13Grid")
            SELECT cursor_4c_ProdEan13Grid
            loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
        ENDIF

        *-- Busca por codigo de barras interno (ver nota do cabecalho sobre
        *-- fVerificarBarras - este bloco SEMPRE roda para CPros char(14)).
        loc_nCod = INT(VAL(loc_cProd))
        IF THIS.this_oBusinessObject.BuscarProdutoPorCodigoBarras(loc_nCod, "cursor_4c_ProdBarrasGrid")
            SELECT cursor_4c_ProdBarrasGrid
            loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
        ELSE
            MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!!", "")
            RETURN
        ENDIF

        *-- Unidade com etiqueta individual bloqueia impressao em lote.
        IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdUnidGrid")
            SELECT cursor_4c_ProdUnidGrid
            loc_cUnidade = ALLTRIM(TratarNulo(CUnis, ""))
            IF !EMPTY(loc_cUnidade) AND THIS.this_oBusinessObject.VerificarUnidadeEtiquetaIndividual(loc_cUnidade)
                MsgAviso("Unidade do Produto (" + loc_cUnidade + ") Utiliza Etiqueta Individual !!!" + CHR(13) + ;
                         "Utilize o M" + CHR(243) + "dulo de Reimpress" + CHR(227) + "o de Etiquetas Individuais !!!", "")
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Refresh()
                RETURN
            ENDIF
        ENDIF

        *-- Lookup (fwbuscaext no legado) - so quando nao ha match unico direto.
        IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdLookupGrid") AND ;
           RECCOUNT("cursor_4c_ProdLookupGrid") = 1
            SELECT cursor_4c_ProdLookupGrid
            THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
            THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
            THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
        ELSE
            IF THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cProd, ;
                    THIS.grd_4c_Dados.Column1.Text1, THIS.grd_4c_Dados.Column2.Text1)
                IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivoGrid")
                    SELECT cursor_4c_ProdDescritivoGrid
                    THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
                ENDIF
            ELSE
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Column4.Text1.Value = ""
            ENDIF
        ENDIF

        *-- Aplica peso/preco do produto na linha corrente do cursor de grade.
        loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
        IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
           THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPrecoGrid")
            SELECT cursor_4c_ProdPrecoGrid
            SELECT (loc_cCursor)
            REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PesoMs, 0), ;
                    PVens   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PVens, 0), ;
                    PrecoDe WITH TratarNulo(cursor_4c_ProdPrecoGrid.PrecoDe, 0)
        ENDIF

        *-- Lista de precos aplicada quando chkLista NAO esta marcado.
        IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND ;
           !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
           THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodResolvido, "cursor_4c_PrecoListaGrid")
            SELECT cursor_4c_PrecoListaGrid
            GO TOP
            loc_nValLista   = PVens
            loc_nValDeLista = PrecoDe
            IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
               THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdListaVencGrid")
                SELECT cursor_4c_ProdListaVencGrid
                loc_nValLista   = PVens
                loc_nValDeLista = PrecoDe
            ENDIF
            SELECT (loc_cCursor)
            REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
                    PVens   WITH loc_nValLista, ;
                    PrecoDe WITH loc_nValDeLista
        ENDIF

        IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
            THIS.grd_4c_Dados.Column3.Text1.Value = 1
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDescricaoGrid - Coluna Descricao da grade (col_dpros.txt_dpros
    * no legado). Transcricao do Valid legado: resolve por match exato de
    * DPros e, sem match unico, por lookup (fwbuscaext ->
    * AbrirLookupCanonico). A navegacao "Keyboard '{ENTER}'" do legado (foco
    * automatico) nao tem equivalente direto e foi omitida - eh conveniencia
    * de UI, nao regra de negocio (regra CLAUDE.md #17 se aplica a formula/
    * fluxo, nao a atalho de teclado).
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarDescricaoGrid
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCursor, loc_cDesc, loc_cCodResolvido

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cDesc   = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)

        IF EMPTY(loc_cDesc)
            THIS.grd_4c_Dados.Column1.Text1.Value = ""
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarProdutoPorDescricao(loc_cDesc, "cursor_4c_ProdDescGrid") AND ;
           RECCOUNT("cursor_4c_ProdDescGrid") = 1
            SELECT cursor_4c_ProdDescGrid
            THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
            THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
            THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
        ELSE
            IF THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDesc, ;
                    THIS.grd_4c_Dados.Column2.Text1, THIS.grd_4c_Dados.Column1.Text1)
                IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivo2Grid")
                    SELECT cursor_4c_ProdDescritivo2Grid
                    THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
                ENDIF
            ELSE
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Column4.Text1.Value = ""
            ENDIF
        ENDIF

        loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
        IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
           THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso2Grid")
            SELECT cursor_4c_ProdPeso2Grid
            SELECT (loc_cCursor)
            REPLACE Pesos WITH TratarNulo(cursor_4c_ProdPeso2Grid.PesoMs, 0)
        ENDIF

        IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
            THIS.grd_4c_Dados.Column3.Text1.Value = 1
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDescritivoGrid - Coluna Referencia Fornecedor da grade
    * (col_DPro2s.Text1 no legado, ControlSource -> Reffs no cursor, mas a
    * busca do legado eh feita pelo campo Dpro2s do produto). Transcricao do
    * Valid legado: resolve por match exato de Dpro2s e, sem match unico,
    * por lookup (fwbuscaext -> AbrirLookupCanonico).
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarDescritivoGrid
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCursor, loc_cDescritivo, loc_cCodResolvido

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
        loc_cDescritivo = ALLTRIM(THIS.grd_4c_Dados.Column4.Text1.Value)

        IF EMPTY(loc_cDescritivo)
            THIS.grd_4c_Dados.Column1.Text1.Value = ""
            THIS.grd_4c_Dados.Column2.Text1.Value = ""
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarProdutoPorDescritivo(loc_cDescritivo, "cursor_4c_ProdDescrvGrid") AND ;
           RECCOUNT("cursor_4c_ProdDescrvGrid") = 1
            SELECT cursor_4c_ProdDescrvGrid
            THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
            THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
            THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
        ELSE
            IF THIS.AbrirLookupCanonico("SigCdPro", "Dpro2s", "CPros", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDescritivo, ;
                    THIS.grd_4c_Dados.Column4.Text1, THIS.grd_4c_Dados.Column1.Text1)
                IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescricao3Grid")
                    SELECT cursor_4c_ProdDescricao3Grid
                    THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
                ENDIF
            ELSE
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Column4.Text1.Value = ""
            ENDIF
        ENDIF

        loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
        IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
           THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso3Grid")
            SELECT cursor_4c_ProdPeso3Grid
            SELECT (loc_cCursor)
            REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PesoMs, 0), ;
                    PVens   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PVens, 0), ;
                    PrecoDe WITH TratarNulo(cursor_4c_ProdPeso3Grid.PrecoDe, 0)
        ENDIF

        IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
            THIS.grd_4c_Dados.Column3.Text1.Value = 1
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarQtdGrid - Coluna Quantidade da grade (col_qtds.txt_qtds no
    * legado). Transcricao do Valid legado: so processa em ENTER (o legado
    * checa Lastkey()=9/15 para saltar foco a controles que nao existem
    * ainda nesta fase - Opt_Preco/BtnReport.Sair - ramos inalcancaveis, ja
    * que o guard inicial "If Lastkey()<>13 Return" filtra tudo que nao seja
    * Enter antes deles). Mantem sempre uma linha em branco no final para
    * digitacao (legado: Set Order To Cpros + Seek(Space(14))).
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarQtdGrid
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCursor, loc_cProduto, loc_nApurado, loc_cChave

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        loc_cProduto = PADR(Cpros, 14)
        loc_nApurado = Qtds

        IF EMPTY(loc_cProduto)
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cProduto), "cursor_4c_ProdValidaQtdGrid")
            MsgAviso("Produto Inv" + CHR(225) + "lido!!!", "")
            RETURN
        ENDIF

        IF loc_nApurado <= 0
            MsgAviso("Valor Apurado Inv" + CHR(225) + "lido!!!", "")
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        SET ORDER TO Cpros
        loc_cChave = SPACE(14)
        IF !SEEK(loc_cChave)
            APPEND BLANK
        ENDIF
        SET ORDER TO

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesGrade - Botoes de acao da grade de etiquetas
    * (btnCarregar/btnexcluir no legado - icones-only, SEM CommandGroup).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
        THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
        WITH THIS.cmd_4c_BtnCarregar
            .Top             = 159
            .Left            = 373
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Themes          = .T.
            .ToolTipText     = "Carregar Itens"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")

        THIS.AddObject("cmd_4c_Btnexcluir", "CommandButton")
        WITH THIS.cmd_4c_Btnexcluir
            .Top             = 374
            .Left            = 21
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Themes          = .T.
            .ToolTipText     = "Excluir item"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirItemClick")
    ENDPROC

    *==========================================================================
    * CriarCursorImpressorasWindows - Popula o cursor crImpreV (RowSource do
    * Get_Printer/cbo_4c_Get_Printer) com as impressoras Windows instaladas
    * na estacao. Precisa existir ANTES do ComboBox ser criado (regra
    * CLAUDE.md #41 - ControlSource/RowSource de cursor inexistente derruba
    * o Init).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorImpressorasWindows()
        LOCAL loc_nImp, loc_nTotal, loc_cAliasAut, loc_lTemAutorizadas, loc_oErro
        LOCAL ARRAY loc_aImpressoras[1, 2]

        *-- crImpre: impressoras instaladas no Windows (legado: Create Cursor
        *-- crImpre + laPrinters de APrinters()).
        IF USED("crImpre")
            USE IN crImpre
        ENDIF
        CREATE CURSOR crImpre (Impres C(60))

        loc_nTotal = APRINTERS(loc_aImpressoras)
        IF loc_nTotal > 0
            FOR loc_nImp = 1 TO loc_nTotal
                INSERT INTO crImpre (Impres) VALUES (UPPER(loc_aImpressoras[loc_nImp, 1]))
            ENDFOR
        ENDIF

        *-- crSigCdmp: impressoras de ETIQUETA (SigCdmp.nTpImpres = 2) que o
        *-- usuario pode usar - por acesso direto (SigSyImp) ou por grupo
        *-- (SigCdAcG). Legado: quando o UNION ALL nao devolve linha nenhuma,
        *-- ele repete a consulta SEM restricao de acesso.
        loc_cAliasAut      = "cursor_4c_ImpAutTmp"
        loc_lTemAutorizadas = .F.

        TRY
            IF USED("crSigCdmp")
                USE IN crSigCdmp
            ENDIF

            IF THIS.this_oBusinessObject.BuscarImpressorasAutorizadas(gc_4c_UsuarioLogado, loc_cAliasAut) ;
               AND RECCOUNT(loc_cAliasAut) > 0

                SELECT DISTINCT Impres FROM (loc_cAliasAut) ;
                    ORDER BY Impres INTO CURSOR crSigCdmp READWRITE
                loc_lTemAutorizadas = .T.
            ELSE
                IF THIS.this_oBusinessObject.BuscarImpressorasEtiqueta("crSigCdmp") ;
                   AND RECCOUNT("crSigCdmp") > 0
                    loc_lTemAutorizadas = .T.
                ENDIF
            ENDIF

            IF USED(loc_cAliasAut)
                USE IN (loc_cAliasAut)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Listar Impressoras")
        ENDTRY

        *-- crImpreV: par "impressora do sistema x impressora do Windows".
        *-- Estrutura FIXA nos dois caminhos (regra do CREATE CURSOR com ordem
        *-- identica em todos os locais): IDupla eh a coluna 1 e portanto o
        *-- texto exibido pelo ComboBox; Impres eh o nome Windows que vai para
        *-- a impressao; ImpresS eh o nome de sistema usado no ajuste fino.
        IF USED("cursor_4c_ImpPar")
            USE IN cursor_4c_ImpPar
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_ImpPar (IDupla C(66), Impres C(60), ImpresS C(60))
        SET NULL OFF

        IF loc_lTemAutorizadas
            *-- Legado: casa as duas listas por conter-um-ao-outro (o nome
            *-- cadastrado costuma ser um prefixo do nome instalado).
            SELECT crSigCdmp
            SCAN
                SELECT crImpre
                SCAN
                    IF ALLTRIM(UPPER(crSigCdmp.Impres)) $ ALLTRIM(UPPER(crImpre.Impres)) ;
                       OR ALLTRIM(UPPER(crImpre.Impres)) $ ALLTRIM(UPPER(crSigCdmp.Impres))

                        INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
                            PADR(ALLTRIM(crSigCdmp.Impres), 15) + " " + ALLTRIM(crImpre.Impres), ;
                            crImpre.Impres, ;
                            crSigCdmp.Impres)
                    ENDIF
                    SELECT crImpre
                ENDSCAN
                SELECT crSigCdmp
            ENDSCAN

            *-- Legado: com mais de um par casado, a lista ganha uma linha em
            *-- BRANCO que, pela ordenacao por IDupla, fica em PRIMEIRO - a
            *-- tela abre sem impressora escolhida e obriga a escolha
            *-- explicita ("se houver mais de uma impressora na lista,
            *-- posiciona em impressora em branco").
            IF RECCOUNT("cursor_4c_ImpPar") > 1
                INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ("", "", "")
            ENDIF
        ENDIF

        *-- Sem banco (modo de teste/validacao de UI) ou sem nenhum par casado,
        *-- a tela ainda precisa listar as impressoras do Windows - caso
        *-- contrario o ComboBox abre vazio e nao ha como imprimir.
        IF RECCOUNT("cursor_4c_ImpPar") = 0
            SELECT crImpre
            SCAN
                INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
                    ALLTRIM(crImpre.Impres), crImpre.Impres, crImpre.Impres)
            ENDSCAN
        ENDIF

        IF USED("crImpreV")
            USE IN crImpreV
        ENDIF
        SELECT IDupla, Impres, ImpresS FROM cursor_4c_ImpPar ;
            ORDER BY IDupla INTO CURSOR crImpreV READWRITE

        IF USED("cursor_4c_ImpPar")
            USE IN cursor_4c_ImpPar
        ENDIF
        IF USED("crImpre")
            USE IN crImpre
        ENDIF
        IF USED("crSigCdmp")
            USE IN crSigCdmp
        ENDIF

        *-- Legado: lnImp = Reccount('crImpreV') - alimenta o Enabled do botao
        *-- Imprimir (ver HabilitarCampos).
        THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")

        SELECT crImpreV
        GO TOP
    ENDPROC

    *==========================================================================
    * ConfigurarCamposImpressao - Campos restantes do form (Parte 2/2):
    * tipo de etiqueta, ajustes da impressora Zebra/Allegro, impressora
    * alternativa Windows/Sistema e opcoes de impressao (separador, ordem,
    * peso, composicao, preco). Transcricao 1:1 das propriedades visuais do
    * SCX legado - a populacao dinamica de Opt_Tipo a partir de SigCdTpe
    * (BuscarTiposEtiquetaAtivos, ja disponivel no BO) fica para a fase que
    * amarra o fluxo de impressao (BTNREPORT), que tambem nao foi criado
    * ainda nesta fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposImpressao()

        *-- Shape3 - moldura decorativa em volta do bloco Impressora
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top           = 431
            .Left          = 260
            .Height        = 106
            .Width         = 254
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Opt_Tipo - tipo de etiqueta (populado dinamicamente em fase futura)
        THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
        WITH THIS.obj_4c_Opt_Tipo
            .Top           = 431
            .Left          = 13
            .Width         = 240
            .Height        = 182
            .ButtonCount   = 1
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nTipoEtiqueta
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Rabicho"
                .Top       = 10
                .Left      = 9
                .Width     = 197
                .Height    = 16
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Tag       = "1"
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 415
            .Left      = 23
            .Width     = 99
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo de Etiqueta"
            .Visible   = .T.
        ENDWITH

        *-- Cnt_Impressora - ajustes da impressora de etiqueta (Zebra/Allegro)
        *-- Cnt_Impressora - CUIDADO: AddObject dos filhos fica FORA do WITH do
        *-- container (regra CLAUDE.md - "WITH aninhado em Container/Label/
        *-- CommandGroup AddObject" - WITH THIS.cnt_X / .AddObject(filho) /
        *-- WITH .filho (2+ niveis relativos) ignora propriedade em silencio).
        *-- Cada filho recebe WITH proprio com o CAMINHO COMPLETO.
        THIS.AddObject("cnt_4c__Impressora", "Container")
        WITH THIS.cnt_4c__Impressora
            .Top       = 539
            .Left      = 260
            .Width     = 254
            .Height    = 74
            .BackStyle = 0
            .Visible   = .T.

            .AddObject("obj_4c_Opcao_imp", "OptionGroup")
            .AddObject("lbl_4c_Label2", "Label")
            .AddObject("lbl_4c_Label3", "Label")
            .AddObject("obj_4c_Spn_AjVerts", "Spinner")
            .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
            .AddObject("obj_4c_Spn_AjDenss", "Spinner")
            .AddObject("obj_4c_Spn_AjVelos", "Spinner")
            .AddObject("lbl_4c_Label1", "Label")
            .AddObject("lbl_4c_Label20", "Label")
        ENDWITH

        WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
            .Top         = 3
            .Left        = 5
            .Width       = 241
            .Height      = 24
            .ButtonCount = 3
            .Value       = THIS.this_oBusinessObject.this_nOpcaoImp
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Allegro"
                .Top       = 4
                .Left      = 2
                .Width     = 51
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Zebra ZPL"
                .Top       = 4
                .Left      = 75
                .Width     = 66
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Zebra EPL"
                .Top       = 4
                .Left      = 164
                .Width     = 66
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "InteractiveChange", THIS, "OpcaoImpInteractiveChange")

        WITH THIS.cnt_4c__Impressora.lbl_4c_Label2
            .Top       = 29
            .Left      = 10
            .Width     = 33
            .Height    = 13
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 7
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vertical"
            .Visible   = .T.
        ENDWITH

        WITH THIS.cnt_4c__Impressora.lbl_4c_Label3
            .Top       = 29
            .Left      = 69
            .Width     = 43
            .Height    = 13
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 7
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Horizontal"
            .Visible   = .T.
        ENDWITH

        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts
            .Top               = 42
            .Left              = 10
            .Width             = 56
            .Height            = 26
            .KeyboardLowValue  = 0
            .KeyboardHighValue = 999
            .SpinnerLowValue   = 0.00
            .SpinnerHighValue  = 999.00
            .FontName          = "Tahoma"
            .Value             = THIS.this_oBusinessObject.this_nAjVerts
            .Visible           = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts, "InteractiveChange", THIS, "SpnAjVertsInteractiveChange")

        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs
            .Top               = 42
            .Left              = 69
            .Width             = 56
            .Height            = 26
            .KeyboardLowValue  = -999
            .KeyboardHighValue = 999
            .SpinnerLowValue   = -999.00
            .SpinnerHighValue  = 999.00
            .FontName          = "Tahoma"
            .Value             = THIS.this_oBusinessObject.this_nAjHorzs
            .Visible           = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs, "InteractiveChange", THIS, "SpnAjHorzsInteractiveChange")

        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss
            .Top               = 42
            .Left              = 128
            .Width             = 56
            .Height            = 26
            .KeyboardLowValue  = 1
            .KeyboardHighValue = 20
            .SpinnerLowValue   = 1.00
            .SpinnerHighValue  = 20.00
            .FontName          = "Tahoma"
            .Value             = 20
            .Visible           = .T.
        ENDWITH
        THIS.this_oBusinessObject.this_nAjDenss = 20
        BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss, "InteractiveChange", THIS, "SpnAjDenssInteractiveChange")

        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos
            .Top               = 42
            .Left              = 188
            .Width             = 54
            .Height            = 26
            .KeyboardLowValue  = 1
            .KeyboardHighValue = 3
            .SpinnerLowValue   = 1.00
            .SpinnerHighValue  = 3.00
            .FontName          = "Tahoma"
            *-- Legado: spn_AjVelos = Iif(Empty(crSigCdPac.AjVelos), 01, ...),
            *-- ou seja, o default SEM parametro cadastrado eh 1, nao o teto da
            *-- faixa. BOParaForm sobrepoe com o valor de SigCdPac quando ha
            *-- banco (ver CarregarParametrosPadrao).
            .Value             = 1
            .Visible           = .T.
        ENDWITH
        THIS.this_oBusinessObject.this_nAjVelos = 1
        BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos, "InteractiveChange", THIS, "SpnAjVelosInteractiveChange")

        WITH THIS.cnt_4c__Impressora.lbl_4c_Label1
            .Top       = 29
            .Left      = 128
            .Width     = 60
            .Height    = 13
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 7
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Densidade"
            .Visible   = .T.
        ENDWITH

        WITH THIS.cnt_4c__Impressora.lbl_4c_Label20
            .Top       = 30
            .Left      = 188
            .Width     = 60
            .Height    = 13
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 7
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Velocidade"
            .Visible   = .T.
        ENDWITH

        *-- Opt_Impressora - impressora alternativa (OCULTA por padrao no
        *-- legado - Visible = .F. no SCX, e o InteractiveChange dela vem
        *-- COMENTADO no proprio legado - regra CLAUDE.md: transcrever fiel).
        THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
        WITH THIS.obj_4c_Opt_Impressora
            .Top           = 431
            .Left          = 260
            .Width         = 254
            .Height        = 47
            .ButtonCount   = 1
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
                .Top       = 52
                .Left      = 9
                .Width     = 210
                .Height    = 16
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 415
            .Left      = 271
            .Width     = 74
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impressora"
            .Visible   = .T.
        ENDWITH

        *-- opt_separador - imprime separadora de etiquetas
        THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
        WITH THIS.obj_4c_Opt_separador
            .Top           = 412
            .Left          = 601
            .Width         = 198
            .Height        = 25
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nSeparador
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 70
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_Opt_separador, "InteractiveChange", THIS, "OptSeparadorInteractiveChange")

        THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
        WITH THIS.lbl_4c_Lbl_Separador
            .Top       = 417
            .Left      = 532
            .Width     = 65
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Separadora :"
            .Visible   = .T.
        ENDWITH

        *-- OptOrdem - ordem de impressao
        THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
        WITH THIS.obj_4c_OptOrdem
            .Top           = 589
            .Left          = 601
            .Width         = 198
            .Height        = 25
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nOrdem
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Produto"
                .Top       = 4
                .Left      = 5
                .Width     = 56
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Nenhuma"
                .Top       = 4
                .Left      = 70
                .Width     = 63
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemInteractiveChange")

        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Top       = 594
            .Left      = 556
            .Width     = 41
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ordem :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top       = 440
            .Left      = 561
            .Width     = 36
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- opt_peso - imprime peso na etiqueta
        THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
        WITH THIS.obj_4c_Opt_peso
            .Top           = 535
            .Left          = 601
            .Width         = 198
            .Height        = 25
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nPeso
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 70
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_Opt_peso, "InteractiveChange", THIS, "OptPesoInteractiveChange")

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top       = 540
            .Left      = 565
            .Width     = 32
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Peso :"
            .Visible   = .T.
        ENDWITH

        *-- optCompos - imprime composicao na etiqueta
        THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
        WITH THIS.obj_4c_OptCompos
            .Top           = 562
            .Left          = 601
            .Width         = 198
            .Height        = 25
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nComposicao
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 70
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_OptCompos, "InteractiveChange", THIS, "OptComposInteractiveChange")

        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top       = 567
            .Left      = 531
            .Width     = 66
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- Get_Printer - impressora Windows destino (RowSource = crImpreV)
        THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
        WITH THIS.cbo_4c_Get_Printer
            .Top            = 453
            .Left           = 268
            .Width          = 239
            .Height         = 23
            .Style          = 2
            .SpecialEffect  = 1
            .BoundColumn    = 1
            .RowSourceType  = 2
            .RowSource      = "crImpreV"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Visible        = .T.
        ENDWITH
        IF RECCOUNT("crImpreV") > 0
            THIS.cbo_4c_Get_Printer.ListIndex = 1
            THIS.this_oBusinessObject.this_cImpressora = ALLTRIM(crImpreV.Impres)
        ENDIF
        BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")

        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top       = 437
            .Left      = 270
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Sistema"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .Top       = 437
            .Left      = 383
            .Width     = 52
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Windows"
            .Visible   = .T.
        ENDWITH

        *-- opt_Preco - modalidade de preco impresso na etiqueta
        THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
        WITH THIS.obj_4c_Opt_Preco
            .Top           = 439
            .Left          = 601
            .Width         = 198
            .Height        = 95
            .ButtonCount   = 6
            .AutoSize      = .F.
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = THIS.this_oBusinessObject.this_nPreco
            .Visible       = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Top       = 7
                .Left      = 8
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 7
                .Left      = 61
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ideal"
                .Top       = 28
                .Left      = 8
                .Width     = 42
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Atual"
                .Top       = 28
                .Left      = 61
                .Width     = 43
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Pre" + CHR(231) + "o DE \ Por"
                .Top       = 51
                .Left      = 8
                .Width     = 87
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Parcelamento"
                .Top       = 73
                .Left      = 8
                .Width     = 83
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")
    ENDPROC

    *==========================================================================
    * PopularOpcoesTipoEtiqueta - Popula dinamicamente o obj_4c_Opt_Tipo a
    * partir de SigCdTpe (tipos de etiqueta ativos), transcricao literal do
    * bloco "With .Opt_Tipo" do Init legado (regra CLAUDE.md #17 - fluxo de
    * negocio se transcreve, nao se reescreve). Sem tipos ativos, mantem o
    * fallback estatico "Rabicho" ja criado por ConfigurarCamposImpressao().
    * Precisa rodar ANTES de qualquer impressao: eh o .Tag de cada Buttons(N)
    * que BtnProcessarImpressaoClick le para resolver o tipo de etiqueta (nTipos).
    *==========================================================================
    PROTECTED PROCEDURE PopularOpcoesTipoEtiqueta()
        LOCAL loc_cAliasPam, loc_cAliasTipos, loc_nMaxPadrao, loc_nTotal, ;
              loc_nI, loc_nTipoPadrao, loc_nHeight, loc_nTop

        loc_cAliasPam = "cursor_4c_Pam"
        IF !USED(loc_cAliasPam)
            THIS.this_oBusinessObject.CarregarParametrosEtiqueta(loc_cAliasPam)
        ENDIF

        loc_nMaxPadrao = 7
        IF USED(loc_cAliasPam)
            SELECT (loc_cAliasPam)
            GO TOP
            loc_nMaxPadrao = MAX(TratarNulo(nMaxTpEtis, 0), 7)
        ENDIF

        loc_cAliasTipos = "cursor_4c_TiposEtiqueta"
        IF !THIS.this_oBusinessObject.BuscarTiposEtiquetaAtivos(loc_cAliasTipos)
            THIS.this_nTotalTipos = 0
            RETURN
        ENDIF

        SELECT (loc_cAliasTipos)
        loc_nTotal = RECCOUNT()

        *-- Legado: lnTipos alimenta o Enabled do botao Imprimir
        *-- (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)) e o Enabled do
        *-- proprio Opt_Tipo (.Enabled = (lnTipos > 1)) - ver HabilitarCampos.
        THIS.this_nTotalTipos = loc_nTotal

        IF loc_nTotal = 0
            USE IN (loc_cAliasTipos)
            RETURN
        ENDIF

        WITH THIS.obj_4c_Opt_Tipo
            loc_nTipoPadrao = 1
            .ButtonCount    = MIN(loc_nTotal, loc_nMaxPadrao)
            loc_nHeight     = 15
            loc_nTop        = 10

            SELECT (loc_cAliasTipos)
            GO TOP
            FOR loc_nI = 1 TO THIS.obj_4c_Opt_Tipo.ButtonCount
                IF USED(loc_cAliasPam) AND TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0) = cursor_4c_Pam.TpEtiPads
                    loc_nTipoPadrao = loc_nI
                ENDIF

                WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
                    .AutoSize  = .F.
                    .Width     = 197
                    .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ALLTRIM(TratarNulo(cursor_4c_TiposEtiqueta.cEtiquetas, ""))
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Tag       = ALLTRIM(STR(TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0)))
                    .Top       = loc_nTop
                    .BackStyle = 0
                ENDWITH

                loc_nTop    = loc_nTop + 20
                loc_nHeight = loc_nHeight + 20

                SELECT (loc_cAliasTipos)
                SKIP
            ENDFOR

            .Enabled = (loc_nTotal > 1)
            .Height  = loc_nHeight
            .Value   = loc_nTipoPadrao
        ENDWITH

        THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value

        IF USED(loc_cAliasTipos)
            USE IN (loc_cAliasTipos)
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoRelatorio - Monta o BTNREPORT legado (obj_4c_BTNREPORT):
    * CommandGroup com 2 botoes - Imprime (dispara a impressao das etiquetas
    * selecionadas) e Sair (encerra o form). Transcricao literal das
    * propriedades do SCX (Top/Left/Width/Height/Picture/Caption).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoRelatorio()
        THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
        WITH THIS.obj_4c_BTNREPORT
            .Top           = -2
            .Left          = 676
            .Width         = 161
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption         = "\<Imprimir"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 81
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption         = "Encerrar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnProcessarImpressaoClick")
        BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * Handlers de sincronizacao BO <-> OptionGroup/Spinner/ComboBox das
    * opcoes de impressao. PUBLIC: bindados via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE OptTipoInteractiveChange()
        THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value
    ENDPROC

    PROCEDURE OpcaoImpInteractiveChange()
        THIS.this_oBusinessObject.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
    ENDPROC

    PROCEDURE SpnAjVertsInteractiveChange()
        THIS.this_oBusinessObject.this_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
    ENDPROC

    PROCEDURE SpnAjHorzsInteractiveChange()
        THIS.this_oBusinessObject.this_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
    ENDPROC

    PROCEDURE SpnAjDenssInteractiveChange()
        THIS.this_oBusinessObject.this_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
    ENDPROC

    PROCEDURE SpnAjVelosInteractiveChange()
        THIS.this_oBusinessObject.this_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
    ENDPROC

    PROCEDURE OptSeparadorInteractiveChange()
        THIS.this_oBusinessObject.this_nSeparador = THIS.obj_4c_Opt_separador.Value
    ENDPROC

    PROCEDURE OptOrdemInteractiveChange()
        THIS.this_oBusinessObject.this_nOrdem = THIS.obj_4c_OptOrdem.Value
    ENDPROC

    PROCEDURE OptPesoInteractiveChange()
        THIS.this_oBusinessObject.this_nPeso = THIS.obj_4c_Opt_peso.Value
    ENDPROC

    PROCEDURE OptComposInteractiveChange()
        THIS.this_oBusinessObject.this_nComposicao = THIS.obj_4c_OptCompos.Value
    ENDPROC

    PROCEDURE OptPrecoInteractiveChange()
        THIS.this_oBusinessObject.this_nPreco = THIS.obj_4c_Opt_Preco.Value
    ENDPROC

    PROCEDURE GetPrinterInteractiveChange()
        *-- Legado (Get_Printer.InteractiveChange): le a COLUNA do cursor de
        *-- RowSource, nunca o texto exibido - a coluna 1 de crImpreV eh o par
        *-- "sistema + windows" (IDupla), que nao eh nome de impressora.
        THIS.this_oBusinessObject.this_cImpressora = THIS.ObterImpressoraSelecionada()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de topo do form.
    * Os filhos de cnt_4c_Sombra ja nascem Visible = .T. no proprio AddObject
    * (ver ConfigurarPageFrame); este metodo cobre os demais controles de
    * topo criados nas proximas fases direto sobre THIS.
    * EXCECAO: obj_4c_Opt_Impressora fica de fora do loop - o legado
    * declara Visible = .F. no SCX (impressora alternativa nao usada por
    * default, InteractiveChange dela vem COMENTADO no proprio legado) e
    * nao ha nenhum ponto do form que a torne visivel depois.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                IF UPPER(loc_oCtrl.Name) == "OBJ_4C_OPT_IMPRESSORA"
                    LOOP
                ENDIF
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CarregarDados - Popula a grade de etiquetas com os itens de uma LISTA DE
    * PRECOS (SigCdLpi). Transcricao do bloco de CARGA do Get_lpreco.Valid
    * legado (a parte do picker de selecao da lista fica no handler de lookup
    * da Fase 6, que chama este metodo passando o valor escolhido):
    *   - confirma antes de refazer a selecao quando a grade ja tem etiqueta;
    *   - ZAPa a grade e varre os itens da lista;
    *   - para item com vigencia VENCIDA, troca preco/preco-de pelo preco
    *     corrente do produto (SigCdPro).
    * Regra CLAUDE.md #17: criterio/fluxo de negocio se TRANSCREVE, nao se
    * reescreve.
    * par_cListaPreco: lista a carregar. Ausente/vazio -> le o TextBox da tela
    * (como o legado faz com This.Value) e, na falta dele, a property do BO.
    * PUBLIC: chamado pelo handler de lookup do campo Lista de Precos e de fora
    * da classe pelo harness de teste (regra CLAUDE.md #3).
    *==========================================================================
    FUNCTION CarregarDados(par_cListaPreco)
        LOCAL loc_cCursor, loc_cLista, loc_cAliasItens, loc_cAliasProd, ;
              loc_lRefazer, loc_nQtdSelecionadas, loc_lCarregaLista, ;
              loc_nVal, loc_nValDe, loc_cCodProd, loc_cDescProd, ;
              loc_cListaItem, loc_dVencIni, loc_dVencFim, ;
              loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
            loc_cAliasItens = "cursor_4c_ItensListaCarga"
            loc_cAliasProd  = "cursor_4c_ProdutoVencidoCarga"

            *-- Lista de precos: o legado le o proprio TextBox (This.Value).
            loc_cLista = ""
            IF VARTYPE(par_cListaPreco) = "C" AND !EMPTY(par_cListaPreco)
                loc_cLista = ALLTRIM(par_cListaPreco)
            ELSE
                IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
                    loc_cLista = ALLTRIM(THIS.txt_4c_Lpreco.Value)
                ENDIF
                IF EMPTY(loc_cLista)
                    loc_cLista = ALLTRIM(THIS.this_oBusinessObject.this_cLPreco)
                ENDIF
            ENDIF

            *-- Legado: o bloco de carga INTEIRO vive dentro de
            *-- "If Not Empty(This.Value)" - sem lista informada, nada acontece.
            IF !EMPTY(loc_cLista) AND USED(loc_cCursor)

                *-- "Existem Etiquetas na Grade! Deseja Refazer a Selecao?"
                *-- MsgConfirma devolve LOGICAL (regra CLAUDE.md #7).
                loc_lRefazer = .T.
                SELECT (loc_cCursor)
                COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
                IF loc_nQtdSelecionadas > 0
                    loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + ;
                                               CHR(231) + CHR(227) + "o?", ;
                                               "Aten" + CHR(231) + CHR(227) + "o!!!")
                ENDIF

                IF loc_lRefazer
                    SELECT (loc_cCursor)
                    ZAP

                    *-- Legado: If (ThisForm.chkLista.Value = 1)
                    loc_lCarregaLista = THIS.this_oBusinessObject.this_lCarregaItensLista
                    IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
                        loc_lCarregaLista = (THIS.chk_4c_ChkLista.Value = 1)
                    ENDIF

                    IF loc_lCarregaLista AND ;
                       THIS.this_oBusinessObject.BuscarItensListaPreco(loc_cLista, loc_cAliasItens)

                        SELECT (loc_cAliasItens)
                        SCAN
                            loc_cCodProd   = TratarNulo(CPros, "")
                            loc_cDescProd  = TratarNulo(DPros, "")
                            loc_cListaItem = TratarNulo(LPrecos, "")
                            loc_nVal       = TratarNulo(PVens, 0)
                            loc_nValDe     = TratarNulo(PrecoDe, 0)

                            *-- Vigencia do preco da lista. Data nula = lista sem
                            *-- prazo: cai DENTRO da vigencia e NAO troca o preco
                            *-- (mesmo efeito do legado, que nunca recebia nulo
                            *-- porque lia a tabela local via CursorQuery).
                            loc_dVencIni = TratarNulo(VencIs, DATETIME())
                            loc_dVencFim = TratarNulo(VencFs, DATETIME())

                            IF !BETWEEN(DATETIME(), loc_dVencIni, loc_dVencFim) AND ;
                               !EMPTY(loc_cCodProd) AND ;
                               THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodProd), loc_cAliasProd)

                                SELECT (loc_cAliasProd)
                                GO TOP
                                loc_nVal   = TratarNulo(PVens, 0)
                                loc_nValDe = TratarNulo(PrecoDe, 0)
                            ENDIF

                            *-- Legado: Insert Into dbImpressao (Cpros, DPros,
                            *-- Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe).
                            *-- Qtds/QtdeEtiq = 1 (uma etiqueta por item da
                            *-- lista) e Obs = codigo da lista aplicada.
                            SELECT (loc_cCursor)
                            APPEND BLANK
                            REPLACE Cpros    WITH loc_cCodProd, ;
                                    DPros    WITH loc_cDescProd, ;
                                    Qtds     WITH 1, ;
                                    QtdeEtiq WITH 1, ;
                                    Obs      WITH loc_cListaItem, ;
                                    PVens    WITH loc_nVal, ;
                                    empos    WITH go_4c_Sistema.cCodEmpresa, ;
                                    PrecoDe  WITH loc_nValDe

                            SELECT (loc_cAliasItens)
                        ENDSCAN
                    ENDIF
                ENDIF

                *-- Linha em branco obrigatoria + Go Top + Refresh: regra
                *-- CLAUDE.md #21(a), centralizada em CarregarLista para nao
                *-- ficar de fora de nenhum caminho que mexe no cursor.
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

            IF USED(loc_cAliasItens)
                USE IN (loc_cAliasItens)
            ENDIF
            IF USED(loc_cAliasProd)
                USE IN (loc_cAliasProd)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar Etiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnCarregarClick - Carrega para a grade de etiquetas os itens da
    * movimentacao informada (Empresa+Operacao+Codigo -> chave posicional
    * EmpDopNums), aplicando a lista de precos quando configurado.
    * Transcricao literal do btnCarregar.Click do legado (regra CLAUDE.md
    * #17 - formula/fluxo de negocio nunca se reescreve).
    * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnCarregarClick()
        LOCAL loc_cCursor, loc_cEmpDopNums, loc_cAliasItens, loc_lRefazer, ;
              loc_nQtdSelecionadas, loc_cCodItem, loc_cDescItem, loc_nQtdItem, ;
              loc_nCitemItem, loc_nVenda, loc_nPrecoDeVal, loc_nPeso, ;
              loc_cCodScan, loc_nValLista, loc_nValDeLista

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF EMPTY(THIS.txt_4c_Emps.Value)
            MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
            THIS.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Dopes.Value)
            MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!", "Dados Incompletos")
            THIS.txt_4c_Dopes.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Numes.Value)
            MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!", "Dados Incompletos")
            THIS.txt_4c_Numes.SetFocus()
            RETURN
        ENDIF

        loc_cEmpDopNums = PADR(ALLTRIM(THIS.txt_4c_Emps.Value), 3) + ;
                           PADR(ALLTRIM(THIS.txt_4c_Dopes.Value), 20) + ;
                           STR(THIS.txt_4c_Numes.Value, 6)

        loc_cAliasItens = "cursor_4c_ItensMovimentoCarga"
        IF !THIS.this_oBusinessObject.BuscarItensMovimento(loc_cEmpDopNums, loc_cAliasItens)
            MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + "o Possui Itens a Serem Carregados!!!", "Dados Incorretos")
            THIS.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF

        loc_lRefazer = .T.
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
            IF loc_nQtdSelecionadas > 0
                loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF
        ENDIF

        IF loc_lRefazer
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
            ENDIF

            IF THIS.chk_4c_ChkOperacoes.Value = 1 AND USED(loc_cAliasItens)
                SELECT (loc_cAliasItens)
                SCAN
                    loc_cCodItem    = TratarNulo(CPros, "")
                    loc_cDescItem   = TratarNulo(DPros, "")
                    loc_nQtdItem    = TratarNulo(Qtds, 0)
                    loc_nCitemItem  = TratarNulo(Citens, 0)

                    loc_nVenda      = 0
                    loc_nPrecoDeVal = 0
                    loc_nPeso       = 0

                    IF !EMPTY(loc_cCodItem) AND THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodItem), "cursor_4c_ProdutoCarga")
                        SELECT cursor_4c_ProdutoCarga
                        IF NVL(PVens, 0) > 0
                            loc_nVenda = PVens
                        ENDIF
                        IF NVL(PrecoDe, 0) > 0
                            loc_nPrecoDeVal = PrecoDe
                        ENDIF
                        IF NVL(PesoMs, 0) > 0
                            loc_nPeso = PesoMs
                        ENDIF
                    ENDIF

                    SELECT (loc_cCursor)
                    APPEND BLANK
                    REPLACE Cpros      WITH loc_cCodItem, ;
                            DPros      WITH loc_cDescItem, ;
                            Qtds       WITH loc_nQtdItem, ;
                            QtdeEtiq   WITH loc_nQtdItem, ;
                            Obs        WITH loc_cEmpDopNums, ;
                            PVens      WITH loc_nVenda, ;
                            empos      WITH go_4c_Sistema.cCodEmpresa, ;
                            empdopnums WITH loc_cEmpDopNums, ;
                            citens     WITH loc_nCitemItem, ;
                            Pesos      WITH loc_nPeso, ;
                            PrecoDe    WITH loc_nPrecoDeVal

                    SELECT (loc_cAliasItens)
                ENDSCAN
            ENDIF
        ENDIF

        IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            SCAN
                loc_cCodScan = ALLTRIM(TratarNulo(Cpros, ""))

                IF !EMPTY(loc_cCodScan) AND ;
                   THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodScan, "cursor_4c_ItemListaCarga")

                    SELECT cursor_4c_ItemListaCarga
                    GO TOP
                    loc_nValLista   = PVens
                    loc_nValDeLista = PrecoDe

                    IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
                       THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodScan, "cursor_4c_ProdutoListaCarga")
                        SELECT cursor_4c_ProdutoListaCarga
                        loc_nValLista   = PVens
                        loc_nValDeLista = PrecoDe
                    ENDIF

                    SELECT (loc_cCursor)
                    REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
                            PVens   WITH loc_nValLista, ;
                            PrecoDe WITH loc_nValDeLista
                ENDIF
            ENDSCAN
        ENDIF

        *-- Linha em branco obrigatoria + Go Top + Refresh (regra CLAUDE.md
        *-- #21a), centralizados em CarregarLista.
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnExcluirItemClick - Remove o item corrente da grade de etiquetas.
    * Transcricao literal do btnexcluir.Click do legado.
    * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnExcluirItemClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            DELETE
            *-- Legado: Locate For .f. tira o ponteiro da linha excluida sem
            *-- depender de SET DELETED.
            LOCATE FOR .F.

            *-- Linha em branco obrigatoria + Go Top + Refresh (CLAUDE.md #21a)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarImpressaoClick - Botao principal do form (BTNREPORT.Imprime no legado):
    * confirma, remove itens sem quantidade apurada, reordena a grade (por
    * Codigo ou por ordem de digitacao) e dispara a impressao fisica das
    * etiquetas. Transcricao literal do fluxo do legado (regra CLAUDE.md #17)
    * - inclusive o SINAL/ordem das validacoes e o criterio de reordenacao
    * via cursor auxiliar (Scatter/Insert), que o legado usa para fisicamente
    * fixar a sequencia de impressao antes de varrer a grade.
    * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnProcessarImpressaoClick()
        LOCAL loc_cCursor, loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
              loc_nTipoSel, loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
              loc_nAjDenss, loc_nAjVelos, loc_cNomeImpressora, loc_cLp1, loc_cLp2, ;
              loc_cBop, loc_cAliasOpe, loc_cAliasOrdenado

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        *-- Recolhe a tela inteira para o BO de uma vez so (equivale ao bloco
        *-- de leitura de controles que abre o BTNREPORT.Click legado) e le
        *-- dali - assim a impressao e a auditoria enxergam exatamente os
        *-- mesmos valores.
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        loc_nImpPreco = THIS.this_oBusinessObject.this_nPreco
        loc_lImpSepar = (THIS.this_oBusinessObject.this_nSeparador = 1)
        loc_lImpPeso  = (THIS.this_oBusinessObject.this_nPeso = 1)
        loc_lCompo    = (THIS.this_oBusinessObject.this_nComposicao = 1)

        *-- O TIPO de etiqueta que vai para a impressora nao eh o indice do
        *-- botao: eh o codigo em .Tag (SigCdTpe.nTipos) do botao selecionado.
        loc_nTipoSel = THIS.this_oBusinessObject.this_nTipoEtiqueta
        loc_nTpEti   = INT(VAL(TratarNulo(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoSel).Tag, "0")))

        loc_nTpImp   = THIS.this_oBusinessObject.this_nOpcaoImp
        loc_nAjVerts = THIS.this_oBusinessObject.this_nAjVerts
        loc_nAjHorzs = THIS.this_oBusinessObject.this_nAjHorzs
        loc_nAjDenss = THIS.this_oBusinessObject.this_nAjDenss
        loc_nAjVelos = THIS.this_oBusinessObject.this_nAjVelos

        *-- Legado: nome da impressora vem da linha corrente de crImpreV
        *-- (crImpreV.impres), nao do texto exibido no ComboBox.
        loc_cNomeImpressora = THIS.this_oBusinessObject.this_cImpressora

        loc_cLp1 = THIS.this_oBusinessObject.this_cLPreco
        loc_cLp2 = THIS.this_oBusinessObject.this_cLPreco2

        CLEAR TYPEAHEAD

        IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o de Etiquetas ?", "")
            RETURN
        ENDIF

        *-- Legado: remove da grade os itens sem quantidade apurada e
        *-- reordena fisicamente (Codigo ou ordem de digitacao) ANTES de
        *-- imprimir, refazendo o cursor via cursor auxiliar (crOrdenado).
        SELECT (loc_cCursor)
        DELETE FOR Qtds <= 0

        loc_cAliasOrdenado = "cursor_4c_Ordenado"
        IF USED(loc_cAliasOrdenado)
            USE IN (loc_cAliasOrdenado)
        ENDIF
        SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cAliasOrdenado) READWRITE

        SELECT (loc_cCursor)
        IF THIS.this_oBusinessObject.this_nOrdem = 1
            SET ORDER TO Cpros
        ELSE
            SET ORDER TO Registros
        ENDIF

        SELECT (loc_cCursor)
        SCAN
            SCATTER MEMVAR MEMO
            INSERT INTO (loc_cAliasOrdenado) FROM MEMVAR
        ENDSCAN

        SELECT (loc_cCursor)
        ZAP

        SELECT (loc_cAliasOrdenado)
        SCAN
            SCATTER MEMVAR MEMO
            INSERT INTO (loc_cCursor) FROM MEMVAR
        ENDSCAN
        USE IN (loc_cAliasOrdenado)

        SELECT (loc_cCursor)
        SET ORDER TO

        *-- Legado: lcBop = numero curto da operacao (SigCdOpe.NDopes) +
        *-- numero da movimentacao - referencia de impressao.
        loc_cBop = ""
        IF !EMPTY(THIS.this_oBusinessObject.this_cDopes) AND !EMPTY(THIS.txt_4c_Numes.Value)
            loc_cAliasOpe = "cursor_4c_OperacaoBop"
            IF THIS.this_oBusinessObject.BuscarOperacaoNumero(THIS.this_oBusinessObject.this_cDopes, loc_cAliasOpe)
                SELECT (loc_cAliasOpe)
                IF !EMPTY(TratarNulo(NDopes, ""))
                    loc_cBop = PADL(ALLTRIM(TratarNulo(NDopes, "")), 4, "0") + ;
                               PADL(THIS.this_oBusinessObject.this_cNumes, 6, "0")
                ENDIF
                USE IN (loc_cAliasOpe)
            ENDIF
        ENDIF

        *-- A impressao eh demorada: tranca a superficie de captura para o
        *-- usuario nao alterar a grade no meio do processo. NUNCA THIS.Enabled
        *-- - o form eh modal e sem TitleBar, trancar tudo o deixaria sem saida.
        THIS.HabilitarCampos(.F.)

        IF !THIS.this_oBusinessObject.ImprimirEtiquetas(loc_nImpPreco, loc_lImpSepar, loc_nTpEti, ;
                loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, ;
                loc_cNomeImpressora, loc_lImpPeso, loc_cBop, loc_cLp1, loc_cLp2, loc_lCompo)
            THIS.HabilitarCampos(.T.)
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Falha na Impress" + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.HabilitarCampos(.T.)

        MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", "")

        *-- Reset pos-impressao do legado: limpa a Lista de Precos e esvazia a
        *-- grade, mantendo a linha em branco (LimparCampos ja chama
        *-- CarregarLista).
        THIS.LimparCampos()

        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o form (BTNREPORT.Sair no legado: ThisForm.
    * Release). PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarParametrosPadrao - Le SigCdPam (parametros gerais de etiqueta) e
    * SigCdPac (ajustes de impressao) e guarda os valores nas properties do BO.
    * Transcricao do bloco "With Thisform.Cnt_Impressora" do Init legado, que
    * alimenta os spinners/opcoes a partir desses dois cursores:
    *   Opcao_Imp.Value = Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
    *   Spn_AjVerts     = crSigCdPam.AjVerts
    *   Spn_AjHorzs     = crSigCdPam.AjHorzs
    *   spn_AjDenss     = Iif(Empty(crSigCdPac.AjDens),  20, crSigCdPac.AjDens)
    *   spn_AjVelos     = Iif(Empty(crSigCdPac.AjVelos), 01, crSigCdPac.AjVelos)
    *   opt_separador   = crSigCdPac.EtqSeps
    * Sem banco disponivel (modo de teste/validacao de UI) as properties ficam
    * com o default declarado no BO - a tela abre igual, so sem os parametros.
    *==========================================================================
    PROTECTED PROCEDURE CarregarParametrosPadrao()
        LOCAL loc_oBO, loc_cAliasPam, loc_cAliasPac, loc_nImpEtis, loc_nSep, loc_oErro

        loc_oBO       = THIS.this_oBusinessObject
        loc_cAliasPam = "cursor_4c_Pam"
        loc_cAliasPac = "cursor_4c_Pac"

        TRY
            IF !USED(loc_cAliasPam)
                loc_oBO.CarregarParametrosEtiqueta(loc_cAliasPam)
            ENDIF

            IF USED(loc_cAliasPam) AND RECCOUNT(loc_cAliasPam) > 0
                SELECT (loc_cAliasPam)
                GO TOP

                *-- Legado: Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
                loc_nImpEtis = TratarNulo(ImpEtis, 0)
                loc_oBO.this_nOpcaoImp = IIF(loc_nImpEtis <> 0, loc_nImpEtis, 1)

                loc_oBO.this_nAjVerts = TratarNulo(AjVerts, 0)
                loc_oBO.this_nAjHorzs = TratarNulo(AjHorzs, 0)
            ENDIF

            IF !USED(loc_cAliasPac)
                loc_oBO.CarregarParametrosImpressao(loc_cAliasPac)
            ENDIF

            IF USED(loc_cAliasPac) AND RECCOUNT(loc_cAliasPac) > 0
                SELECT (loc_cAliasPac)
                GO TOP

                *-- Legado: Iif(Empty(<col>), <default>, <col>)
                loc_oBO.this_nAjDenss = IIF(EMPTY(TratarNulo(AjDens, 0)), 20, TratarNulo(AjDens, 0))
                loc_oBO.this_nAjVelos = IIF(EMPTY(TratarNulo(AjVelos, 0)), 1, TratarNulo(AjVelos, 0))

                *-- opt_separador tem 2 botoes: valor fora da faixa derruba o
                *-- OptionGroup, entao so aplica o parametro quando ele eh um
                *-- indice valido (o legado atribui cru porque o SCX dele nasce
                *-- com a mesma quantidade de botoes).
                loc_nSep = TratarNulo(EtqSeps, 0)
                IF BETWEEN(loc_nSep, 1, THIS.obj_4c_Opt_separador.ButtonCount)
                    loc_oBO.this_nSeparador = loc_nSep
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Par" + CHR(226) + "metros de Etiqueta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Espelha as properties do BO nos controles da tela. Alem do
    * espelhamento, dispara CarregarParametrosPadrao() para que os defaults de
    * SigCdPam/SigCdPac cheguem aos controles ANTES de o usuario ver a tela -
    * eh esse bloco do Init legado que define ajuste vertical/horizontal,
    * densidade, velocidade, impressora especial e separadora.
    * PROTECTED: FormBase declara o hook como PROTECTED e VFP9 nao permite a
    * subclasse ALARGAR o escopo - omitir o modificador nao tornaria publico.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            THIS.CarregarParametrosPadrao()

            *-- Bloco Lista de Precos
            THIS.txt_4c_Lpreco.Value       = loc_oBO.this_cLPreco
            THIS.txt_4c_LPreco2.Value      = loc_oBO.this_cLPreco2
            THIS.chk_4c_ChkLista.Value     = IIF(loc_oBO.this_lCarregaItensLista, 1, 0)
            THIS.chk_4c_ChkOperacoes.Value = IIF(loc_oBO.this_lCarregaItensOperacao, 1, 0)

            *-- Bloco Movimentacao. txt_4c_Numes eh NUMERICO (o legado o usa em
            *-- Str(...,6) para montar a chave EmpDopNums), entao a property
            *-- character do BO volta pelo VAL - nunca por atribuicao direta.
            THIS.txt_4c_Emps.Value  = loc_oBO.this_cEmps
            THIS.txt_4c_Dopes.Value = loc_oBO.this_cDopes
            THIS.txt_4c_Numes.Value = VAL(loc_oBO.this_cNumes)

            *-- Opcoes de impressao (OptionGroup.Value eh SEMPRE o INDICE do
            *-- botao: valor fora de 1..ButtonCount derruba o controle).
            THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Tipo,        loc_oBO.this_nTipoEtiqueta)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Impressora,  loc_oBO.this_nTipoImpressora)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_separador,   loc_oBO.this_nSeparador)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_OptOrdem,        loc_oBO.this_nOrdem)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_peso,        loc_oBO.this_nPeso)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_OptCompos,       loc_oBO.this_nComposicao)
            THIS.AplicarValorOptionGroup(THIS.obj_4c_Opt_Preco,       loc_oBO.this_nPreco)
            THIS.AplicarValorOptionGroup(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, loc_oBO.this_nOpcaoImp)

            *-- Ajustes finos da impressora de etiqueta
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjVerts
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjHorzs
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjDenss
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjVelos

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Exibir Par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AplicarValorOptionGroup - Atribui o indice a um OptionGroup so quando ele
    * cabe em 1..ButtonCount. OptionGroup.Value eh SEMPRE numerico e indice de
    * botao; valor fora da faixa (tipico de parametro do banco gravado com 0 ou
    * com mais opcoes do que a tela tem) estoura em runtime.
    *==========================================================================
    PROTECTED PROCEDURE AplicarValorOptionGroup(par_oGrupo, par_nValor)
        IF VARTYPE(par_oGrupo) != "O" OR VARTYPE(par_nValor) != "N"
            RETURN
        ENDIF

        IF BETWEEN(par_nValor, 1, par_oGrupo.ButtonCount)
            par_oGrupo.Value = par_nValor
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Recolhe os valores da tela para as properties do BO. Espelha
    * exatamente o bloco de leitura de controles do BTNREPORT.Click legado
    * (Opt_Preco/Opt_Separador/Opt_Peso/optCompos/Opt_Tipo/Cnt_Impressora/
    * get_Printer/get_lpreco/getLPreco2), acrescido dos campos de movimentacao
    * e da chave posicional EmpDopNums.
    * PROTECTED pelo mesmo motivo de BOParaForm (hook declarado em FormBase).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro, loc_nTipoSel

        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            *-- Listas de preco e flags de carga
            loc_oBO.this_cLPreco  = ALLTRIM(THIS.txt_4c_Lpreco.Value)
            loc_oBO.this_cLPreco2 = ALLTRIM(THIS.txt_4c_LPreco2.Value)
            loc_oBO.this_lCarregaItensLista    = (THIS.chk_4c_ChkLista.Value = 1)
            loc_oBO.this_lCarregaItensOperacao = (THIS.chk_4c_ChkOperacoes.Value = 1)

            *-- Movimentacao. TRANSFORM porque txt_4c_Numes eh numerico e
            *-- ALLTRIM sobre numerico dispara erro 11 em runtime.
            loc_oBO.this_cEmps  = ALLTRIM(THIS.txt_4c_Emps.Value)
            loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
            loc_oBO.this_cNumes = ALLTRIM(TRANSFORM(THIS.txt_4c_Numes.Value))

            *-- Chave POSICIONAL Emps(3) + Dopes(20) + Str(Numes,6) = char(29).
            *-- PADR explicito: ALLTRIM nas PARTES encurta a chave e a consulta
            *-- devolve zero linha em silencio (regra CLAUDE.md #42).
            IF EMPTY(loc_oBO.this_cEmps) AND EMPTY(loc_oBO.this_cDopes)
                loc_oBO.this_cEmpDopNums = ""
            ELSE
                loc_oBO.this_cEmpDopNums = PADR(loc_oBO.this_cEmps, 3) + ;
                                           PADR(loc_oBO.this_cDopes, 20) + ;
                                           STR(THIS.txt_4c_Numes.Value, 6)
            ENDIF

            *-- Opcoes de impressao (indice do botao selecionado)
            loc_oBO.this_nPreco          = THIS.obj_4c_Opt_Preco.Value
            loc_oBO.this_nSeparador      = THIS.obj_4c_Opt_separador.Value
            loc_oBO.this_nPeso           = THIS.obj_4c_Opt_peso.Value
            loc_oBO.this_nComposicao     = THIS.obj_4c_OptCompos.Value
            loc_oBO.this_nOrdem          = THIS.obj_4c_OptOrdem.Value
            loc_oBO.this_nTipoEtiqueta   = THIS.obj_4c_Opt_Tipo.Value
            loc_oBO.this_nTipoImpressora = THIS.obj_4c_Opt_Impressora.Value

            *-- Cnt_Impressora
            loc_oBO.this_nOpcaoImp = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
            loc_oBO.this_nAjVerts  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
            loc_oBO.this_nAjHorzs  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
            loc_oBO.this_nAjDenss  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
            loc_oBO.this_nAjVelos  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value

            *-- Impressora Windows escolhida no ComboBox. O legado le a COLUNA
            *-- do cursor (crImpreV.impres), nunca o texto exibido - a coluna 1
            *-- do RowSource eh o par "sistema + windows" (IDupla).
            loc_oBO.this_cImpressora = THIS.ObterImpressoraSelecionada()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Ler os Dados da Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterImpressoraSelecionada - Nome Windows da impressora escolhida no
    * ComboBox (legado: "lcNomeImp = crImpreV.impres", lido da LINHA CORRENTE
    * do cursor de RowSource, nao do texto do controle).
    *==========================================================================
    PROTECTED FUNCTION ObterImpressoraSelecionada()
        LOCAL loc_cNome

        loc_cNome = ""
        IF USED("crImpreV") AND RECCOUNT("crImpreV") > 0
            SELECT crImpreV
            IF BETWEEN(THIS.cbo_4c_Get_Printer.ListIndex, 1, RECCOUNT("crImpreV"))
                GO (THIS.cbo_4c_Get_Printer.ListIndex)
            ENDIF
            loc_cNome = ALLTRIM(TratarNulo(crImpreV.Impres, ""))
        ENDIF

        RETURN loc_cNome
    ENDFUNC

    *==========================================================================
    * AplicarAcessosUsuario - Le as permissoes do usuario logado para os
    * ajustes finos da impressora e para o tipo de etiqueta. Transcricao das
    * seis chamadas fChecaAcesso do Init legado:
    *   .spn_AjVerts.Enabled = fChecaAcesso([SigPrEtq], [VERTICAL])   (e irmas)
    *   .opt_Tipo.Enabled    = fChecaAcesso([SigPrEtq], [TIPO])
    * fChecaAcesso mora no framework legado (Framework\sigacess.PRG, carregado
    * por config.prg) e abre conexao propria: TRY aninhado garante que a tela
    * ainda abra num ambiente sem banco, assumindo o default permissivo das
    * properties (mesmo padrao de SIGREADSBO.Init).
    *==========================================================================
    PROTECTED PROCEDURE AplicarAcessosUsuario()
        LOCAL loc_oErroAcesso

        TRY
            THIS.this_lAcVertical   = fChecaAcesso("SigPrEtq", "VERTICAL")
            THIS.this_lAcHorizontal = fChecaAcesso("SigPrEtq", "HORIZONTAL")
            THIS.this_lAcDensidade  = fChecaAcesso("SigPrEtq", "DENSIDADE")
            THIS.this_lAcVelocidade = fChecaAcesso("SigPrEtq", "VELOCIDADE")
            THIS.this_lAcTipo       = fChecaAcesso("SigPrEtq", "TIPO")
        CATCH TO loc_oErroAcesso
            MsgErro(loc_oErroAcesso.Message, "fChecaAcesso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga a superficie de captura da tela. Este form
    * OPERACIONAL nao tem modo INCLUIR/ALTERAR (o legado nao tem Page2 nem
    * botao de Salvar/Cancelar): o parametro serve para TRANCAR a tela durante
    * a impressao, que eh demorada, e destrancar no fim.
    * O teto de permissao do usuario (AplicarAcessosUsuario) e a disponibilidade
    * de tipos/impressoras sao respeitados SEMPRE - par_lHabilitar = .T. nunca
    * libera o que o legado mantem bloqueado:
    *   BtnReport.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)
    *   BtnReport.Value           = Iif(.Imprime.Enabled, 1, 2)
    * NUNCA mexer em THIS.Enabled: o form eh modal (WindowType = 1) sem
    * TitleBar, e desabilitar o form inteiro deixaria o usuario sem saida.
    * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lLiga, loc_lTemImpressao

        loc_lLiga = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- Captura de lista de precos e de movimentacao
        THIS.txt_4c_Lpreco.Enabled       = loc_lLiga
        THIS.txt_4c_LPreco2.Enabled      = loc_lLiga
        THIS.chk_4c_ChkLista.Enabled     = loc_lLiga
        THIS.chk_4c_ChkOperacoes.Enabled = loc_lLiga
        THIS.txt_4c_Emps.Enabled         = loc_lLiga
        THIS.txt_4c_Dopes.Enabled        = loc_lLiga
        THIS.txt_4c_Numes.Enabled        = loc_lLiga
        THIS.cmd_4c_BtnCarregar.Enabled  = loc_lLiga

        *-- Grade de etiquetas e exclusao de item
        THIS.grd_4c_Dados.Enabled        = loc_lLiga
        THIS.cmd_4c_Btnexcluir.Enabled   = loc_lLiga

        *-- Opcoes de impressao
        THIS.obj_4c_Opt_separador.Enabled = loc_lLiga
        THIS.obj_4c_OptOrdem.Enabled      = loc_lLiga
        THIS.obj_4c_Opt_peso.Enabled      = loc_lLiga
        THIS.obj_4c_OptCompos.Enabled     = loc_lLiga
        THIS.obj_4c_Opt_Preco.Enabled     = loc_lLiga
        THIS.cbo_4c_Get_Printer.Enabled   = loc_lLiga
        THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Enabled = loc_lLiga

        *-- Legado: o tipo de etiqueta so fica ativo com mais de uma opcao
        *-- (.Enabled = (lnTipos > 1) em PopularOpcoesTipoEtiqueta) e ainda
        *-- depende da permissao TIPO.
        THIS.obj_4c_Opt_Tipo.Enabled = (loc_lLiga AND THIS.this_lAcTipo AND THIS.this_nTotalTipos > 1)

        *-- Ajustes finos: permissao por parametro (fChecaAcesso)
        THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Enabled = (loc_lLiga AND THIS.this_lAcVertical)
        THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Enabled = (loc_lLiga AND THIS.this_lAcHorizontal)
        THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Enabled = (loc_lLiga AND THIS.this_lAcDensidade)
        THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Enabled = (loc_lLiga AND THIS.this_lAcVelocidade)

        *-- Botao Imprimir: so com tipo de etiqueta E impressora disponiveis.
        loc_lTemImpressao = (THIS.this_nTotalTipos <> 0 AND THIS.this_nTotalImpressoras <> 0)
        THIS.obj_4c_BTNREPORT.Buttons(1).Enabled = (loc_lLiga AND loc_lTemImpressao)

        *-- Legado: o foco do CommandGroup cai no Encerrar quando nao ha o que
        *-- imprimir. Encerrar NUNCA eh desabilitado - eh a unica saida da tela.
        THIS.obj_4c_BTNREPORT.Buttons(2).Enabled = .T.
        THIS.obj_4c_BTNREPORT.Value = IIF(THIS.obj_4c_BTNREPORT.Buttons(1).Enabled, 1, 2)
    ENDPROC

    *==========================================================================
    * LimparCampos - Reset pos-impressao, exatamente o que o legado faz no fim
    * do BTNREPORT.Click: limpa a Lista de Precos principal e esvazia a grade
    * de etiquetas, deixando a linha em branco que o Grid precisa para aceitar
    * digitacao.
    * NAO limpa getLPreco2 nem Empresa/Operacao/Codigo: o legado os PRESERVA
    * para que o usuario emita a proxima remessa da mesma movimentacao sem
    * redigitar (regra CLAUDE.md #17 - criterio do legado se transcreve).
    * PROTECTED pelo mesmo motivo de FormParaBO/BOParaForm (hook de FormBase).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_cCursor

        THIS.txt_4c_Lpreco.Value = ""
        THIS.this_oBusinessObject.this_cLPreco = ""

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            ZAP
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * CarregarLista - Fecha CADA caminho que popula a grade de etiquetas:
    * garante a linha em branco que o legado sempre mantem em dbImpressao,
    * reposiciona no topo e repinta o Grid.
    * Popular o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a): o
    * legado encerra cada carga com "Go Top In dbImpressao" + "Grade.Refresh",
    * e esse par vive aqui para nao ser esquecido em nenhum dos quatro
    * caminhos que mexem no cursor (carga por lista de precos, carga por
    * movimentacao, exclusao de item e reset pos-impressao).
    * PUBLIC: chamado de fora da classe pelo harness de teste (CLAUDE.md #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)

            *-- Legado: "Go Top In dbImpressao / If Eof() / Append Blank".
            *-- O teste eh EOF() DEPOIS do GO TOP, nao RECCOUNT(): RECCOUNT
            *-- conta tambem os registros marcados para exclusao, entao logo
            *-- apos um DELETE a grade pode ficar sem NENHUMA linha visivel
            *-- com RECCOUNT ainda positivo - e sem linha o Grid nao aceita
            *-- digitacao no campo Produto.
            GO TOP
            IF EOF()
                APPEND BLANK
                GO TOP
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Activate - Legado: o Init termina com
    * ".Grd_Etiqueta.Col_cpros.SetFocus", deixando o cursor do teclado no
    * campo Produto da grade. SetFocus so vale com a tela ja visivel, por isso
    * roda no Activate e uma unica vez (this_lFocoAplicado), para nao roubar o
    * foco toda vez que a tela volta ao topo depois de um dialogo.
    *==========================================================================
    PROCEDURE Activate()
        DODEFAULT()

        IF !THIS.this_lFocoAplicado
            THIS.this_lFocoAplicado = .T.

            *-- Guarda em vez de TRY/CATCH: SetFocus em controle invisivel ou
            *-- desabilitado eh erro de runtime, e aqui as tres condicoes sao
            *-- verificaveis de antemao. Com a grade posicionada no topo
            *-- (CarregarLista) o foco cai na coluna 1, que eh o campo Produto
            *-- (col_cpros do legado).
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores locais antes de encerrar o form
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("crImpreV")
            USE IN crImpreV
        ENDIF
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_Pac")
            USE IN cursor_4c_Pac
        ENDIF
        IF USED("crImpre")
            USE IN crImpre
        ENDIF
        IF USED("crSigCdmp")
            USE IN crSigCdmp
        ENDIF
        IF USED("cursor_4c_ImpPar")
            USE IN cursor_4c_ImpPar
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
* Origem legado: SIGPRETQ.SCX (form OPERACIONAL, sem CRUD proprio)
* Tabela de referencia: SigCdPro (produtos que recebem etiqueta)
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao da movimentacao (getEmps / getDopes / getNumes)
    this_cEmps            = ""   && Empresa (SigCdEmp.Cemps, char(3))
    this_cDopes           = ""   && Operacao de movimento (SigCdOpe.Dopes)
    this_cNumes           = ""   && Numero da movimentacao

    *-- Listas de preco (getLPreco / getLPreco2 - lookup SigCdLpc.LPrecos)
    this_cLPreco          = ""   && Lista de preco principal
    this_cLPreco2         = ""   && Lista de preco secundaria

    *-- Flags de carga de itens (chkLista / chkOperacoes)
    this_lCarregaItensLista     = .T.   && Carrega itens da Lista de Precos
    this_lCarregaItensOperacao  = .T.   && Carrega itens da Movimentacao

    *-- Opcoes de impressao de etiqueta (OptionGroups - valor = indice do botao)
    this_nTipoEtiqueta    = 1    && Opt_Tipo (tipo de etiqueta)
    this_nTipoImpressora  = 1    && Opt_Impressora (impressora especial)
    this_nOpcaoImp        = 1    && Cnt_Impressora.Opcao_imp
    this_nSeparador       = 1    && opt_separador
    this_nOrdem           = 1    && OptOrdem
    this_nPeso            = 1    && opt_peso
    this_nComposicao      = 1    && optCompos
    this_nPreco           = 1    && opt_Preco

    *-- Ajustes finos de impressao (Cnt_Impressora.Spn_*)
    this_nAjVerts         = 0    && Ajuste vertical
    this_nAjHorzs         = 0    && Ajuste horizontal
    this_nAjDenss         = 0    && Ajuste de densidade
    this_nAjVelos         = 0    && Ajuste de velocidade

    *-- Impressora do sistema Windows (Get_Printer - combobox)
    this_cImpressora      = ""

    *-- Controle interno / grade de etiquetas (dbImpressao no legado)
    this_cCursorDados     = "cursor_4c_Dados"
    this_lResultadoOk     = .F.
    this_cMensagemErro    = ""

    *-- Espelho da linha corrente do cursor de grade (dbImpressao no legado)
    *-- Preenchido por CarregarDoCursor() - mesma ordem/nomes do CREATE CURSOR
    *-- dbImpressao declarado no Load() do form legado.
    this_cCpros           = ""   && Codigo do produto (SigCdPro.CPros, char(14))
    this_cDPros           = ""   && Descricao do produto
    this_cReffs           = ""   && Referencia do fornecedor
    this_nQtds            = 0    && Quantidade apurada
    this_nQtdeEtiq        = 0    && Quantidade de etiquetas a imprimir
    this_cPedido          = ""   && Pedido/origem do item (Obs de lista de preco)
    this_cObs             = ""   && Observacao (lista de preco aplicada)
    this_nPVens           = 0    && Preco de venda
    this_nPrecoDe         = 0    && Preco "De" (preco cheio antes do desconto)
    this_nParcelas        = 0    && Numero de parcelas
    this_cCpros2          = ""   && Produto complementar 2 (combo/kit)
    this_cCpros3          = ""   && Produto complementar 3
    this_cCpros4          = ""   && Produto complementar 4
    this_cEmpos           = ""   && Empresa de origem do item
    this_cEmpDopNums      = ""   && Chave posicional Emps+Dopes+Numes (char(29))
    this_nCitens          = 0    && Numero do item na movimentacao (SigMvItn.Citens)
    this_nPesos           = 0    && Peso do produto (SigCdPro.PesoMs)
    this_cCodTams         = ""   && Codigo do tamanho (SigCdPro.CodTams)
    this_cDPro2s          = ""   && Descritivo do produto (SigCdPro.Dpro2s)

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    * CarregarDoCursor - Mapeia uma linha do cursor de grade de etiquetas
    * (equivalente ao dbImpressao do legado) para as properties this_*.
    * par_cAliasCursor: alias do cursor posicionado na linha a carregar.
    *============================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCpros          = TratarNulo(Cpros, "")
        THIS.this_cDPros          = TratarNulo(DPros, "")
        THIS.this_cReffs          = TratarNulo(Reffs, "")
        THIS.this_nQtds           = TratarNulo(Qtds, 0)
        THIS.this_nQtdeEtiq       = TratarNulo(QtdeEtiq, 0)
        THIS.this_cPedido         = TratarNulo(Pedido, "")
        THIS.this_cObs            = TratarNulo(Obs, "")
        THIS.this_nPVens          = TratarNulo(PVens, 0)
        THIS.this_nPrecoDe        = TratarNulo(PrecoDe, 0)
        THIS.this_nParcelas       = TratarNulo(Parcelas, 0)
        THIS.this_cCpros2         = TratarNulo(Cpros2, "")
        THIS.this_cCpros3         = TratarNulo(Cpros3, "")
        THIS.this_cCpros4         = TratarNulo(Cpros4, "")
        THIS.this_cEmpos          = TratarNulo(empos, "")
        THIS.this_cEmpDopNums     = TratarNulo(empdopnums, "")
        THIS.this_nCitens         = TratarNulo(citens, 0)
        THIS.this_nPesos          = TratarNulo(Pesos, 0)
        THIS.this_cCodTams        = TratarNulo(CodTams, "")
        THIS.this_cDPro2s         = TratarNulo(DPro2s, "")

        RETURN .T.
    ENDFUNC

    *============================================================================
    * ObterChavePrimaria - Chave da linha corrente da grade (produto)
    *============================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *============================================================================
    * Este BO NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
    *
    * O legado nao grava a selecao de etiquetas via INSERT/UPDATE/DELETE de
    * registro: dbImpressao eh um cursor 100% em memoria, populado a partir de
    * SigMvItn/SigCdLpi (metodos BuscarItensMovimento/BuscarItensListaPreco
    * abaixo) e a "gravacao" da tela eh a rotina de impressao de etiqueta
    * (SigOpEtq no legado) seguida de Commit() da conexao - nao um Salvar()
    * de registro no padrao FormBase/BusinessBase. Como este BO nunca chama
    * THIS.Salvar()/THIS.Excluir(), o comportamento padrao herdado de
    * BusinessBase ja eh o correto.
    *============================================================================

    *============================================================================
    * CarregarParametrosEtiqueta - Carrega SigCdPam (parametros gerais de
    * etiqueta) no cursor de destino. Equivale ao 1o CursorQuery do Init legado.
    *============================================================================
    FUNCTION CarregarParametrosEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pam")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, " + ;
                   "AjVerts, AjHorzs, TpCBars, GrPadClis, GrPadVens FROM SigCdPam"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * CarregarParametrosImpressao - Carrega SigCdPac (ajuste de impressao/
    * separador de etiqueta) no cursor de destino.
    *============================================================================
    FUNCTION CarregarParametrosImpressao(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pac")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarTiposEtiquetaAtivos - Tipos de etiqueta ativos (SigCdTpe), na
    * mesma ordem usada pelo legado para montar o Opt_Tipo (cOrdems+cEtiquetas).
    *============================================================================
    FUNCTION BuscarTiposEtiquetaAtivos(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_TiposEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems FROM SigCdTpe " + ;
                   "WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasAutorizadas - Impressoras de etiqueta (nTpImpres = 2)
    * liberadas para o usuario, por acesso direto (SigSyImp) ou por grupo
    * (SigCdAcG). Transcricao literal do UNION ALL do Init legado.
    *============================================================================
    FUNCTION BuscarImpressorasAutorizadas(par_cUsuario, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_cUsuario

        IF VARTYPE(par_cUsuario) != "C" OR EMPTY(par_cUsuario)
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasAutorizadas")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cUsuario = EscaparSQL(ALLTRIM(par_cUsuario))

        loc_cSQL = "SELECT b.Impres FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + loc_cUsuario + " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                   "UNION ALL " + ;
                   "SELECT c.Impres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + loc_cUsuario + " AND a.Grupos = b.GrAcess " + ;
                   "AND b.CImps = c.Impres AND c.nTpImpres = 2"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasEtiqueta - Todas as impressoras de etiqueta cadastradas
    * (SigCdmp.nTpImpres = 2), sem filtro de usuario. Transcricao do FALLBACK
    * do Init legado: quando o UNION ALL de BuscarImpressorasAutorizadas nao
    * devolve nenhuma linha, o legado repete a consulta sem restricao de
    * acesso ("Select Distinct Impres From SigCdmp Where nTpImpres = 2
    * Order By Impres") em vez de deixar a lista vazia.
    *============================================================================
    FUNCTION BuscarImpressorasEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                   "WHERE nTpImpres = 2 ORDER BY Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorEan13 - Localiza produto pelo codigo de barras EAN13.
    *============================================================================
    FUNCTION BuscarProdutoPorEan13(par_nEan, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nEan) != "N" OR par_nEan <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigoBarras - Localiza produto pelo codigo de barras
    * interno (CBars), usado quando o valor digitado nao eh um EAN13 valido.
    *============================================================================
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nCodigo) != "N" OR par_nCodigo <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(par_nCodigo, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigo - Localiza produto pelo codigo (CPros).
    *============================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescricao - Localiza produto pela descricao (DPros).
    *============================================================================
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescricao) != "C" OR EMPTY(par_cDescricao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE DPros = " + EscaparSQL(ALLTRIM(par_cDescricao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescritivo - Localiza produto pelo descritivo (Dpro2s,
    * usado como "Referencia Fornecedor"/descritivo no grid de etiquetas).
    *============================================================================
    FUNCTION BuscarProdutoPorDescritivo(par_cDescritivo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescritivo) != "C" OR EMPTY(par_cDescritivo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(ALLTRIM(par_cDescritivo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * VerificarUnidadeEtiquetaIndividual - .T. quando a unidade do produto
    * usa etiqueta individual e NAO permite duplicidade (Etiqs = 'S' e
    * EtiqDups <> 1) - nesse caso o legado bloqueia a impressao em lote.
    *============================================================================
    FUNCTION VerificarUnidadeEtiquetaIndividual(par_cCodUnidade)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lBloqueia

        loc_lBloqueia = .F.

        IF VARTYPE(par_cCodUnidade) != "C" OR EMPTY(par_cCodUnidade)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_UnidadeEtiqueta"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCodUnidade))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0
            SELECT (loc_cAlias)
            loc_lBloqueia = (ALLTRIM(UPPER(TratarNulo(Etiqs, ""))) == "S") AND (TratarNulo(EtiqDups, 0) <> 1)
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lBloqueia
    ENDFUNC

    *============================================================================
    * BuscarItensMovimento - Itens da movimentacao (SigMvItn) para a chave
    * posicional EmpDopNums (Emps char(3) + Dopes char(20) + Numes STR(,6)),
    * usada pelo botao "Carregar" quando chkOperacoes esta marcado.
    *============================================================================
    FUNCTION BuscarItensMovimento(par_cEmpDopNums, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cEmpDopNums) != "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensMovimento")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        *-- Chave POSICIONAL (Emps+Dopes+Numes) - NAO fazer ALLTRIM nas partes
        *-- que compoem par_cEmpDopNums; o padding faz parte da chave.
        loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens FROM SigMvItn " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarItensListaPreco - Itens de uma lista de precos (SigCdLpi), usada
    * pelo botao "Carregar"/Valid de Get_lpreco quando chkLista esta marcado.
    *============================================================================
    FUNCTION BuscarItensListaPreco(par_cListaPreco, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            THIS.this_cMensagemErro = "Lista de pre" + CHR(231) + "os n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensListaPreco")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarPrecoItemListaPreco - Preco de um produto especifico dentro de
    * uma lista de precos (usado nos Valid dos campos da grade).
    *============================================================================
    FUNCTION BuscarPrecoItemListaPreco(par_cListaPreco, par_cCodProduto, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco) ;
           OR VARTYPE(par_cCodProduto) != "C" OR EMPTY(par_cCodProduto)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_PrecoItemLista")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30)) + ;
                   " AND CPros = " + EscaparSQL(PADR(ALLTRIM(par_cCodProduto), 14))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarListaPreco - Confere se a lista de precos existe (SigCdLpc),
    * usado no Valid de Get_lpreco/getLPreco2 antes de abrir o picker.
    *============================================================================
    FUNCTION ValidarListaPreco(par_cListaPreco)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaListaPreco"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * BuscarOperacaoNumero - Le o NDopes (numero curto da operacao) de
    * SigCdOpe, usado para montar o "lcBop" (chave de impressao) antes de
    * chamar a rotina de impressao de etiqueta.
    *============================================================================
    FUNCTION BuscarOperacaoNumero(par_cCodOperacao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodOperacao) != "C" OR EMPTY(par_cCodOperacao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_OperacaoNumero")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodOperacao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarOperacao - Confere se o codigo de operacao existe em SigCdOpe.
    * Substitui a chamada legado a fAcessoMovmto() (funcao global nao portada).
    *============================================================================
    FUNCTION ValidarOperacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaOperacao"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ValidarEmpresa - Confere se o codigo de empresa existe em SigCdEmp.
    * Substitui a chamada legado a fAcessoEmpresa() (funcao global nao
    * portada - ver licao aprendida sobre fAcessoEmpresa).
    *============================================================================
    FUNCTION ValidarEmpresa(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaEmpresa"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ImprimirEtiquetas - Envia para impressao as etiquetas selecionadas na
    * grade (cursor_4c_Dados). O motor de impressao do legado (SigOpEtq, em
    * SIGFUNCS.PRG) gera comandos proprietarios ZPL/EPL/Allegro para
    * impressoras termicas especificas e NAO esta no acervo migrado (mesma
    * familia da licao "funcao global do legado nao portada" - regra
    * CLAUDE.md #27). Como o retorno de SigOpEtq eh descartado pelo legado
    * (=SigOpEtq(...)) e o fluxo segue para "Impressao Concluida!!!"
    * seja qual for o resultado interno dela, este metodo substitui por uma
    * impressao de texto generica e FUNCIONAL (via SET DEVICE TO PRINTER),
    * respeitando quantidade por item (QtdeEtiq), impressora selecionada,
    * exibicao de preco e peso, e separador entre etiquetas - sem reproduzir
    * o layout proprietario exato (codigo de barras/posicionamento termico)
    * que so existe no motor original.
    *============================================================================
    FUNCTION ImprimirEtiquetas(par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
            par_nAjVerts, par_nAjHorzs, par_nAjDenss, par_nAjVelos, par_cNomeImpressora, ;
            par_lImpPeso, par_cBop, par_cLp1, par_cLp2, par_lCompo)

        LOCAL loc_cCursor, loc_nCopia, loc_nQtdImpressa, loc_lSucesso, loc_oErro

        loc_lSucesso    = .F.
        loc_nQtdImpressa = 0
        loc_cCursor     = THIS.this_cCursorDados

        IF !USED(loc_cCursor)
            THIS.this_cMensagemErro = "Nenhuma etiqueta selecionada para impress" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            IF !EMPTY(par_cNomeImpressora)
                SET PRINTER TO NAME (par_cNomeImpressora)
            ENDIF

            SET DEVICE TO PRINTER
            SET PRINT ON

            SELECT (loc_cCursor)
            SCAN FOR !EMPTY(Cpros) AND QtdeEtiq > 0
                FOR loc_nCopia = 1 TO QtdeEtiq
                    @ PROW() + 1, 0 SAY PADR(ALLTRIM(Cpros), 14) + "  " + ALLTRIM(TratarNulo(DPros, ""))

                    IF INLIST(par_nImpPreco, 1, 3, 4)
                        @ PROW() + 1, 4 SAY "R$ " + TRANSFORM(PVens, "999,999.99")
                    ENDIF

                    IF par_lImpPeso AND TratarNulo(Pesos, 0) > 0
                        @ PROW() + 1, 4 SAY "Peso: " + TRANSFORM(Pesos, "999,999.999") + " Kg"
                    ENDIF

                    IF par_lCompo AND !EMPTY(TratarNulo(DPro2s, ""))
                        @ PROW() + 1, 4 SAY ALLTRIM(DPro2s)
                    ENDIF

                    IF !EMPTY(par_cBop)
                        @ PROW() + 1, 4 SAY "Ref: " + par_cBop
                    ENDIF

                    IF par_lImpSepar
                        @ PROW() + 1, 0 SAY REPLICATE("-", 40)
                    ENDIF

                    loc_nQtdImpressa = loc_nQtdImpressa + 1
                ENDFOR
                SELECT (loc_cCursor)
            ENDSCAN

            SET PRINT OFF
            SET DEVICE TO SCREEN

            IF loc_nQtdImpressa = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta com quantidade apurada para imprimir."
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            SET PRINT OFF
            SET DEVICE TO SCREEN
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

