# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 7/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-14 20:36:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-14 20:36:40] [INFO] Config FPW: (nao fornecido)
[2026-10-14 20:36:40] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-14 20:36:40] [INFO] Timeout: 300 segundos
[2026-10-14 20:36:40] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ymkfoqeq.prg
[2026-10-14 20:36:40] [INFO] Conteudo do wrapper:
[2026-10-14 20:36:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task629\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task629\logs\06_testForm.log'
QUIT

[2026-10-14 20:36:40] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ymkfoqeq.prg
[2026-10-14 20:36:40] [INFO] VFP output esperado em: C:\4c\tasks\task629\vfp_output.txt
[2026-10-14 20:36:40] [INFO] Executando Visual FoxPro 9...
[2026-10-14 20:36:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ymkfoqeq.prg
[2026-10-14 20:36:40] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ymkfoqeq.prg
[2026-10-14 20:36:40] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRIMP
Inicio: 14/10/2026 20:36:40

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 14/10/2026 20:39:46
Duracao: 186 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-14 20:39:47] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-14 20:39:47] [INFO] VFP9 finalizado em 186.4724486 segundos
[2026-10-14 20:39:47] [INFO] Exit Code: 
[2026-10-14 20:39:47] [INFO] 
[2026-10-14 20:39:47] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-14 20:39:47] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ymkfoqeq.prg
[2026-10-14 20:39:47] [INFO] 
[2026-10-14 20:39:47] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-14 20:39:47] [INFO] * Auto-generated wrapper for parameters
[2026-10-14 20:39:47] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-14 20:39:47] [INFO] * Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task629\logs\06_testForm.log'
[2026-10-14 20:39:47] [INFO] 
[2026-10-14 20:39:47] [INFO] * Anti-dialog protections for unattended execution
[2026-10-14 20:39:47] [INFO] SET SAFETY OFF
[2026-10-14 20:39:47] [INFO] SET RESOURCE OFF
[2026-10-14 20:39:47] [INFO] SET TALK OFF
[2026-10-14 20:39:47] [INFO] SET NOTIFY OFF
[2026-10-14 20:39:47] [INFO] SYS(2335, 0)
[2026-10-14 20:39:47] [INFO] 
[2026-10-14 20:39:47] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task629\logs\06_testForm.log'
[2026-10-14 20:39:47] [INFO] QUIT
[2026-10-14 20:39:47] [INFO] 
[2026-10-14 20:39:47] [INFO] === Fim do Wrapper.prg ===
[2026-10-14 20:39:47] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg):
*==============================================================================
* FormSIGPRIMP.prg
* Form: Importacao de dados (Movimentacao de Estoque a partir de arquivo .TXT)
* Herda de: FormBase
* Tipo: OPERACIONAL - layout PLANO (sem PageFrame): o legado (SIGPRIMP.SCX) nao
*       tem PageFrame - cabecalho + textbox de arquivo + listbox de arquivos
*       disponiveis + botoes de acao (Visualizar/Imprimir/Movimentar/Encerrar),
*       todos filhos diretos do form (sem container de botoes).
* SCX Origem: SIGPRIMP.SCX (tasks\task629\SIGPRIMP_form_codigo_fonte.txt)
*
* Estrutura: DEFINE CLASS, Init/InicializarForm, cabecalho (cntSombra), area
* de arquivos (Shape2/Label/TextBox/ListBox) e botoes de acao (Shape1/
* Cancela/Visualizar/Imprimir/BtnMovEst) - todos filhos diretos do form.
*
* SEM LOOKUP: SIGPRIMP.SCX nao tem campo algum com busca auxiliar - a varredura
* do dump por fwBuscaExt/fwBuscaSel/fwBuscaInt/mAddColuna/sigacess()/Acesso*()
* devolve ZERO ocorrencia. O unico campo da tela (Get_Arquivo) apenas EXIBE o
* diretorio de importacao lido de SigCdPam e tem "PROCEDURE When / Return .f."
* no legado, isto eh, nao aceita digitacao - campo somente-leitura nao tem onde
* receber codigo para um picker resolver. Criar FormBuscaAuxiliar aqui seria
* inventar tabela de lookup que o original nunca consulta (viola os PILARES 1
* e 2 e a regra "NUNCA inventar tabelas de lookup").
*
* REGRA DOS CAMPOS (entra nesta fase junto com eles): o legado condiciona o
* botao "Moviment. de Estoque" ao campo de arquivo -
* "btnMovEst.PROCEDURE When / Return !Empty(thisform.get_Arquivo.Value)": com o
* diretorio em branco o botao fica DESABILITADO, nao apenas inerte. Reproduzido
* por ValidarArquivoImportacao() (a regra) + AtualizarEstadoBotoes() (o efeito
* visual do When), chamados no funil de carga, no fim do InicializarForm e no
* retorno do processamento (regra #40 - quem desabilita tem de reabilitar).
*
* HOOKS DE TRANSFERENCIA (FormParaBO/BOParaForm): existem de verdade neste
* form, embora o legado nao lhes de nome. O Init do SCX faz
* "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" - isso eh BOParaForm()
* literal (property do BO -> campo da tela); e o btnMovEst.Click le o
* diretorio de volta e monta "lcArq = lcDirImport + Alltrim(laArq(lnPrc,1))"
* para entregar ao MovEst - isso eh FormParaBO() (campo da tela -> property do
* BO). Esta fase so os CONSOLIDA num ponto unico de recarga: antes as duas
* atribuicoes estavam inline em CarregarListaArquivos e em BtnMovEstClick.
*
* NOMES CANONICOS DE CRUD QUE NAO TEM EQUIVALENTE AQUI (o legado nao tem CRUD -
* nem frmcadastro, nem Grupo_Op, nem pcEscolha, nem Incluir/Alterar/Excluir -
* e criar metodo vazio eh proibido pela regra de completude):
*   HabilitarCampos(par_lHabilitar) - nao ha campo editavel para habilitar: o
*     unico TextBox eh somente-leitura por construcao ("Get_Arquivo.When /
*     Return .f.") e o ListBox so aceita selecao. Quem decide o que esta ativo
*     eh AtualizarEstadoBotoes(), que reproduz o When do btnMovEst.
*   LimparCampos() - o legado DECIDIU nao limpar: a linha que zeraria o campo
*     esta COMENTADA no fim do movest ("*!* thisform.get_Arquivo.Value = []").
*     Limpar aqui divergiria do comportamento original (PILAR 1); o diretorio
*     de importacao eh fixo e vem de SigCdPam, nao eh dado de digitacao.
*   AjustarBotoesPorModo() - nao existe modo (LISTA/INCLUIR/ALTERAR/
*     VISUALIZAR/EXCLUIR) nesta tela. O equivalente real eh
*     AtualizarEstadoBotoes(), chamado no funil de carga, no fim do
*     InicializarForm e no retorno do processamento (regra #40).
*   BtnBuscarClick / BtnSalvarClick - o SCX tem exatamente tres botoes ativos:
*     btnMovEst (a acao, -> BtnMovEstClick), Cancela (-> BtnCancelarClick) e os
*     dois ocultos Visualizar/Imprimir. Nao ha botao de busca nem de gravar
*     registro; a gravacao eh o proprio processamento do arquivo.
*
* NAO-PORT DELIBERADO: PROCEDURE Load do legado so chama =fConfigGeral()
* (funcao GLOBAL legada que nao veio no acervo). O wrapper NO-OP em
* utils\fconfiggeral.prg existe so para o p-code de VCX legado continuar
* resolvendo o nome - este form herda direto de "form" (BaseClass), sem
* VCX nenhum, entao nem o wrapper eh alcancado. O que fConfigGeral fazia
* (config global) ja ocorre antes deste form abrir via config.prg/main.prg/
* SIGPRIMPBO.CarregarParametrosSistema(). Mesmo padrao de FormSigPrEop.prg/
* FormSigPrCar.prg/FormSigMvExp.prg.
*==============================================================================

DEFINE CLASS FormSIGPRIMP AS FormBase

    *-- Dimensoes e comportamento exatos do original (SIGPRIMP.SCX: 1000x330)
    Width        = 1000
    Height       = 330
    Caption      = "Importa" + CHR(231) + CHR(227) + "o de dados"
    AutoCenter   = .T.
    DataSession  = 2
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    *-- SCX: Closable = .F. / Movable = .F. / ClipControls = .F. Com TitleBar = 0
    *-- nao ha caixa de fechar nem barra para arrastar, mas Closable = .F. e' o
    *-- que impede fechar por Ctrl+F4 - no legado a saida e' sempre o botao
    *-- Encerrar (Cancela, com Cancel = .T.). THIS.Release() nao e' afetado.
    *-- ShowTips = .T. do SCX nao se repete: ja vem herdado de FormBase.
    *-- A saida ("Cancela" no legado, Caption="Encerrar") tem handler
    *-- BtnCancelarClick - nome canonico (Btn*Click), nao o nome do objeto
    *-- legado (regra PILAR 3 + gate da Fase 7, piso de handlers por prefixo).
    Closable     = .F.
    Movable      = .F.
    ClipControls = .F.
    Themes       = .F.
    WindowType   = 1
    ShowWindow   = 1

    *==========================================================================
    * Init - o PROCEDURE Init do SCX legado nao recebe parametros
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria o Business Object e monta a estrutura visual
    * completa (cabecalho, area de arquivos e botoes de acao), carrega os
    * parametros do sistema e a lista de .TXT disponiveis, e aplica a regra do
    * When do legado sobre o botao de movimentacao (AtualizarEstadoBotoes).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRIMPBO." + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF

            *-- Le SigCdPam e lista os .TXT do diretorio de importacao (Init do
            *-- legado). O guard de modo teste/validacao de UI (sem conexao SQL)
            *-- mora DENTRO de CarregarLista(), que eh o funil unico de carga.
            THIS.CarregarLista()

            THIS.TornarControlesVisiveis(THIS)

            *-- Efeito do "btnMovEst.When" do legado: o botao de movimentacao
            *-- fica habilitado so se o campo de arquivo estiver preenchido.
            THIS.AtualizarEstadoBotoes()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame): o legado
    * (SIGPRIMP.SCX) nao declara PageFrame nenhum - so aplica fonte padrao
    * equivalente ao container raiz. Metodo mantido para compatibilidade com a
    * validacao textual do pipeline de migracao (Fase 3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra a montagem da "pagina" unica do form
    * OPERACIONAL (cabecalho + arquivo + lista + botoes de acao). Equivale a
    * Page1 (Lista) dos forms CRUD. Este form NAO tem Grid/CRUD (SIGPRIMP.SCX
    * nao declara PageFrame nem grade de registros - a "lista" do legado eh o
    * ListBox de arquivos .TXT disponiveis para importacao, e as "acoes" sao
    * Visualizar/Imprimir/Movimentar Estoque/Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaArquivos()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *==========================================================================
    * ConfigurarAreaArquivos - Shape2 (moldura decorativa), label "Arquivos
    * Importacao :", TextBox com o diretorio de importacao (somente leitura -
    * equivalente ao Get_Arquivo.When que sempre retorna .F. no legado) e o
    * ListBox com os arquivos .TXT disponiveis (Arquivos no legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaArquivos()
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 7
            .Left        = 4
            .Width       = 758
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
            .Left      = 310
            .Top       = 111
            *-- Say4 do SCX e' classe "say" (AutoSize=.T./Alignment=0) e nao
            *-- declara Width. Regra #23: AutoSize e' no-op em Label criado por
            *-- AddObject, logo a Width vai explicita. Medido no VFP9
            *-- (automation\medir_fase5_sigprimp.prg): o caption em Tahoma 8
            *-- bold mede 126 px - com 125 a legenda era CORTADA. 130 e' o vao
            *-- exato ate o TextBox (310 -> 440), sem invadi-lo.
            .Width     = 130
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 21
            .Left          = 440
            .Top           = 108
            .Width         = 250
            .Margin        = 0
            .SpecialEffect = 1
            .TabIndex      = 4
            .BorderColor   = RGB(100, 100, 100)
            *-- "SIGPRIMP.Get_Arquivo / PROCEDURE When / Return .f." do dump: no
            *-- legado o campo NUNCA recebe foco - ele so EXIBE o diretorio de
            *-- importacao que o Init le de SigCdPam. ReadOnly impede a edicao e
            *-- TabStop = .F. reproduz o salto do controle na ordem de
            *-- tabulacao, que eh o efeito do When devolvendo .F.
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = ""
            .Height        = 169
            .Left          = 402
            .Top           = 130
            .Width         = 288
            .Sorted        = .T.
            .TabIndex      = 6
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes de acao do form (Cancela/Encerrar,
    * Visualizar, Imprimir, btnMovEst). Visualizar/Imprimir permanecem com
    * Visible = .F. (igual ao Init do legado - "Thisform.imprimir.Visible = .f."
    * / "Thisform.visualizar.Visible = .f.") e nunca sao reativados em nenhum
    * ponto do dump original: o Click deles referencia um container
    * "opEstoque" que nao existe em SIGPRIMP.SCX (codigo morto herdado do
    * template Fortyus, inalcancavel porque os botoes ficam sempre ocultos).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        *-- Shape1 do legado: moldura decorativa sobre a area dos 4 botoes de
        *-- acao (Left=773..1002 cobre BtnMovEst/Visualizar/Imprimir/Cancela).
        *-- BackStyle=0 + BorderStyle=0 (transparente) - igual ao Shape2.
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -12
            .Left        = 773
            .Width       = 229
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 925
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .PicturePosition = 13
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")

        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top               = 3
            .Left              = 775
            .Height            = 75
            .Width             = 75
            .WordWrap          = .F.
            .Picture           = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Themes            = .T.
            .Caption           = "\<Video"
            .Enabled           = .T.
            .PicturePosition   = 13
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top               = 3
            .Left              = 850
            .Height            = 75
            .Width             = 75
            .Picture           = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Themes            = .T.
            .Caption           = "\<Impressora "
            .Enabled           = .T.
            .PicturePosition   = 13
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
        WITH THIS.cmd_4c_BtnMovEst
            .Top             = 3
            .Left            = 700
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .Themes          = .T.
            .Caption         = "Moviment. de Estoque"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .PicturePosition = 7
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnMovEst, "Click", THIS, "BtnMovEstClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de carga da "lista" deste form OPERACIONAL (o
    * ListBox de arquivos .TXT disponiveis; nao ha Grid nem registros de CRUD).
    * Concentra o guard de ambiente: em validacao de UI / modo teste nao ha
    * conexao SQL, e CarregarParametrosSistema() faz SQLEXEC em SigCdPam.
    *
    * PUBLIC de proposito: o harness (TesteAutomatico.prg) chama
    * THIS.oForm.CarregarLista() de FORA da classe - metodo PROTECTED passaria
    * o PEMSTATUS(...,5) e falharia na chamada real (regra #3/#51).
    *==========================================================================
    PROCEDURE CarregarLista()
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            *-- Sem banco: a tela fica montada e vazia, como o legado ficaria
            *-- se o diretorio de importacao estivesse em branco. O estado dos
            *-- botoes continua sendo decidido pelo When reproduzido.
            THIS.AtualizarEstadoBotoes()
            RETURN .F.
        ENDIF

        RETURN THIS.CarregarListaArquivos()
    ENDPROC

    *==========================================================================
    * CarregarListaArquivos - Le SigCdPam (CarregarParametrosSistema do BO),
    * exibe o diretorio de importacao no txt_4c_Arquivo (via BOParaForm) e
    * lista os .TXT disponiveis no obj_4c_Arquivos. Equivalente ao final do
    * PROCEDURE Init do legado (linhas 699-715 do dump).
    *
    * Entrar por aqui pressupoe conexao SQL ativa - o guard de ambiente esta em
    * CarregarLista(), que eh o ponto de entrada.
    *==========================================================================
    PROTECTED PROCEDURE CarregarListaArquivos()
        *-- LOCAL com subscrito JA declara ARRAY: medido no VFP9 2026-10-14
        *-- (automation\medir_fase8_localarray.prg) - "LOCAL loc_aArq[1]"
        *-- misturado com escalares devolve TYPE "C" e ADIR preenche
        *-- normalmente, identico a "LOCAL ARRAY". Quem estoura
        *-- "'LOC_AARQ' is not an array" eh "LOCAL loc_aArq" SEM o subscrito.
        LOCAL loc_aArq[1], loc_nArq, loc_nPrc

        IF !THIS.this_oBusinessObject.CarregarParametrosSistema()
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        *-- "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" do Init legado
        THIS.BOParaForm()

        THIS.obj_4c_Arquivos.Clear()

        loc_nArq = ADIR(loc_aArq, ALLTRIM(THIS.this_oBusinessObject.this_cDirImport) + "*.TXT")
        IF loc_nArq > 0
            FOR loc_nPrc = 1 TO loc_nArq
                THIS.obj_4c_Arquivos.AddItem(ALLTRIM(loc_aArq[loc_nPrc, 1]))
            ENDFOR
        ENDIF

        *-- O campo acabou de mudar: reavalia o When do legado sobre o botao.
        THIS.AtualizarEstadoBotoes()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarArquivoImportacao - Transcricao do guard que o legado mantem sobre
    * o campo de arquivo:
    *
    *     SIGPRIMP.btnMovEst / PROCEDURE When
    *     Return !Empty(thisform.get_Arquivo.Value)
    *
    * Sem o diretorio de importacao preenchido (SigCdPam.DirImports) nao ha o
    * que varrer: o legado nem deixa o botao "Moviment. de Estoque" ativo.
    * PUBLIC de proposito - eh chamado pelo handler do Click, por
    * AtualizarEstadoBotoes e de FORA da classe pelas checagens do pipeline
    * (metodo PROTECTED falharia em runtime - regra #51).
    *==========================================================================
    PROCEDURE ValidarArquivoImportacao()
        LOCAL loc_cDirImport

        IF VARTYPE(THIS.txt_4c_Arquivo) != "O"
            RETURN .F.
        ENDIF

        *-- Fonte unica eh o TEXTBOX, nao a property do BO: eh o .Value que o
        *-- legado le no When (e eh dele que BtnMovEstClick monta o caminho).
        loc_cDirImport = ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))

        RETURN !EMPTY(loc_cDirImport)
    ENDPROC

    *==========================================================================
    * AtualizarEstadoBotoes - Aplica na tela o resultado do When do legado.
    * O VFP9 reavalia o When a cada tentativa de foco; o migrado liga o guard ao
    * .Enabled do botao e o atualiza em TODO caminho que mexe no campo (carga
    * inicial, fim do InicializarForm e retorno do processamento) - sem isso o
    * usuario clicaria num botao ativo que nao faz nada, sem retorno nenhum.
    * O botao tem Caption + Themes = .T. + DisabledPicture, entao continua
    * desenhando o icone quando desabilitado.
    *==========================================================================
    PROCEDURE AtualizarEstadoBotoes()
        IF VARTYPE(THIS.cmd_4c_BtnMovEst) != "O"
            RETURN
        ENDIF

        THIS.cmd_4c_BtnMovEst.Enabled = THIS.ValidarArquivoImportacao()
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere BO -> Form. Transcricao do bloco do Init legado
    * que exibe o diretorio de importacao na tela:
    *
    *     SIGPRIMP / PROCEDURE Init
    *     Thisform.get_Arquivo.Value = crSigCdPam.DirImports
    *
    * (crSigCdPam eh o cursor de SigCdPam, que nesta arquitetura virou
    * SIGPRIMPBO.CarregarParametrosSistema -> this_cDirImport.)
    *
    * Reavalia o estado dos botoes no fim porque o campo que o When do legado
    * consulta ACABOU de mudar - sem isso o botao de movimentacao ficaria
    * cinza mesmo com o diretorio preenchido.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm" e
    * o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador aqui
    * nao tornaria o metodo publico, so esconderia que ele segue protegido.
    * Medido em 2026-10-14 (automation\probe_fase8_sigprimp.prg): declarado sem
    * PROTECTED, PEMSTATUS(...,2) ainda devolve .T. e a chamada de FORA da
    * classe estoura "Property BOPARAFORM is not found". Chamar sempre por
    * THIS. de dentro da classe (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDirImport, ""))
            loc_lSucesso = .T.
        ENDIF

        THIS.AtualizarEstadoBotoes()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere Form -> BO. Equivalente ao inicio do
    * btnMovEst.Click do legado, que le o diretorio de volta e monta o caminho
    * do arquivo que vai ser entregue ao processamento:
    *
    *     SIGPRIMP.btnMovEst / PROCEDURE Click
    *     lcDirImport = Alltrim(crSigCdPam.DirImports)
    *     lcArq = lcDirImport + Alltrim(laArq(lnPrc, 1))
    *     llOk = ThisForm.MovEst(lcArq)
    *
    * par_cArquivo - caminho completo do .TXT da volta corrente do laco.
    *
    * SEM o argumento, APENAS o diretorio eh sincronizado e this_cArquivo fica
    * INTACTO. Isso nao eh detalhe: FormBase.Salvar() chama THIS.FormParaBO()
    * sem argumento nenhum, e zerar this_cArquivo ali apagaria o arquivo em
    * processamento no meio do caminho - o BO receberia caminho vazio e
    * recusaria a importacao com "Informe o arquivo a importar.".
    *
    * A FONTE do diretorio eh o TEXTBOX, nao a property do BO: eh o .Value que
    * o When do legado consulta, e eh dele que o caminho do arquivo foi montado
    * em BtnMovEstClick (mesmo criterio de fonte unica de
    * ValidarArquivoImportacao).
    *
    * Retorno LOGICO de proposito: o chamador tem de ABORTAR o processamento
    * quando a transferencia falha - hook de transferencia que devolve sempre
    * .T. (ou nada) deixa o fluxo seguir com property errada e o BO gravaria em
    * cima de dado invalido, calado.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de BOParaForm (escopo herdado de
    * FormBase; o VFP9 nao deixa alargar).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO(par_cArquivo)
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_Arquivo) = "O"

            THIS.this_oBusinessObject.this_cDirImport = ;
                ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))

            IF VARTYPE(par_cArquivo) = "C"
                loc_cArquivo = ALLTRIM(par_cArquivo)
                THIS.this_oBusinessObject.this_cArquivo = loc_cArquivo

                *-- Com arquivo informado, a transferencia so vale se ele
                *-- existir: o legado monta o caminho a partir do que o ADir
                *-- devolveu, logo um caminho inexistente aqui significa que o
                *-- arquivo saiu do diretorio entre a listagem e o
                *-- processamento.
                loc_lSucesso = !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            ELSE
                *-- Sincronizacao do diretorio apenas - nada a validar.
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - Botao Encerrar (Cancela no legado: "ThisForm.Release").
    * Nome segue o padrao canonico PROCEDURE (Cmd|Btn)\w*Click do projeto -
    * nao herdar o nome do objeto legado (regra PILAR 3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnMovEstClick - Processa TODOS os .TXT do diretorio de importacao
    * (btnMovEst.Click do legado): para cada arquivo chama o BO.Inserir()
    * (equivalente a ThisForm.MovEst(lcArq)); em caso de sucesso move o
    * arquivo para a subpasta "OK\" e remove da lista. O guard de habilitacao
    * do legado (PROCEDURE When: "Return !Empty(thisform.get_Arquivo.Value)")
    * vira o IF EMPTY no inicio do metodo.
    *==========================================================================
    PROCEDURE BtnMovEstClick()
        LOCAL loc_cDirImport, loc_aArq[1], loc_nArq, loc_nPrc, loc_cArq, ;
            loc_lOk, loc_cPastaOk, loc_cDestino, loc_cNomeArq

        *-- Mesmo guard do "btnMovEst.When" do legado: o .Enabled ja impede o
        *-- clique, mas tecla de atalho/Enter tambem chega ao Click.
        IF !THIS.ValidarArquivoImportacao()
            RETURN
        ENDIF

        loc_cDirImport = ALLTRIM(THIS.txt_4c_Arquivo.Value)

        loc_nArq = ADIR(loc_aArq, loc_cDirImport + "*.TXT")
        IF loc_nArq > 0
            FOR loc_nPrc = 1 TO loc_nArq
                WAIT WINDOW "Processando Arquivo " + ALLTRIM(STR(loc_nPrc)) + ;
                    " de " + ALLTRIM(STR(loc_nArq)) NOWAIT NOCLEAR

                loc_cNomeArq = ALLTRIM(loc_aArq[loc_nPrc, 1])
                loc_cArq     = loc_cDirImport + loc_cNomeArq
                loc_cDestino = ""

                *-- Transferencia Form -> BO num ponto unico. Falhando (arquivo
                *-- saiu do diretorio entre a listagem e agora), pula para o
                *-- proximo em vez de mandar o BO abrir caminho inexistente.
                IF !THIS.FormParaBO(loc_cArq)
                    LOOP
                ENDIF

                loc_lOk = THIS.this_oBusinessObject.Inserir()

                IF loc_lOk
                    loc_cPastaOk = loc_cDirImport + "OK\"
                    IF !DIRECTORY(loc_cPastaOk)
                        MKDIR (loc_cPastaOk)
                    ENDIF
                    IF DIRECTORY(loc_cPastaOk)
                        loc_cDestino = loc_cPastaOk + loc_cNomeArq
                        COPY FILE (loc_cArq) TO (loc_cDestino)
                    ENDIF
                    IF !EMPTY(loc_cDestino) AND FILE(loc_cDestino)
                        DELETE FILE (loc_cArq)
                        *-- O legado remove por POSICAO ("Arquivos.RemoveItem(
                        *-- lnPrc - lnDel)"), o que casa com a ordem do ADir -
                        *-- mas o ListBox tem "Sorted = .T." no SCX, entao a
                        *-- ordem EXIBIDA eh alfabetica e a posicao do ADir
                        *-- aponta para outra linha: o arquivo processado fica
                        *-- na lista e um nao-processado desaparece dela. Defeito
                        *-- HERDADO (regra #28); conserto registrado aqui -
                        *-- remover pelo NOME entrega o efeito que o legado
                        *-- evidentemente pretendia, sem depender da ordenacao.
                        THIS.RemoverArquivoDaLista(loc_cNomeArq)
                    ENDIF
                    THIS.obj_4c_Arquivos.Refresh()
                ENDIF
            ENDFOR
        ELSE
            *-- Legado: Messagebox([Nenhum arquivo para importar.],64,[Aviso]) - o
            *-- icone 64 eh INFORMACAO (MsgInfo), nao aviso (48); o titulo do legado
            *-- eh "Aviso" mesmo assim. Transcrito literal.
            MsgInfo("Nenhum arquivo para importar.", "Aviso")
        ENDIF

        *-- Funil de volta (regra #40): reavalia o When apos o processamento.
        THIS.AtualizarEstadoBotoes()
    ENDPROC

    *==========================================================================
    * RemoverArquivoDaLista - Tira do obj_4c_Arquivos a linha cujo texto eh o
    * nome do arquivo informado. Substitui o RemoveItem por POSICAO do legado,
    * que nao funciona com o "Sorted = .T." que o proprio SCX declara no
    * ListBox (ver comentario em BtnMovEstClick).
    *
    * Varre de BAIXO para CIMA: RemoveItem reindexa as linhas seguintes, e
    * percorrer na ordem crescente pularia a linha logo abaixo da removida.
    *==========================================================================
    PROCEDURE RemoverArquivoDaLista(par_cNomeArq)
        LOCAL loc_nI, loc_cAlvo

        IF VARTYPE(THIS.obj_4c_Arquivos) != "O" OR VARTYPE(par_cNomeArq) != "C"
            RETURN .F.
        ENDIF

        loc_cAlvo = UPPER(ALLTRIM(par_cNomeArq))

        FOR loc_nI = THIS.obj_4c_Arquivos.ListCount TO 1 STEP -1
            IF UPPER(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_nI))) == loc_cAlvo
                THIS.obj_4c_Arquivos.RemoveItem(loc_nI)
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cabecalho escuro (cntSombra no legado)
    *==========================================================================
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
            .Caption   = THIS.Caption
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width
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
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top         = 17
            .Width       = THIS.Width
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - este form OPERACIONAL tem uma unica "pagina" (par_nPagina
    * = 1). Mantido para compatibilidade com o padrao do pipeline de migracao.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina != 1
            RETURN
        ENDIF
        THIS.Enabled = .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao). cmd_4c_Visualizar
    * e cmd_4c_Imprimir ficam FORA do loop: o legado os mantem Visible = .F.
    * para sempre (Init: "Thisform.imprimir.Visible = .f." / "Thisform.
    * visualizar.Visible = .f.", nunca revertido em nenhum ponto do dump).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_VISUALIZAR", "CMD_4C_IMPRIMIR")
                    *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera referencia do Business Object
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIMPBO.prg):
*==============================================================================
* SIGPRIMPBO.prg
*
* Business Object para SIGPRIMP (Importacao de Dados - Movimentacao de Estoque)
* Form OPERACIONAL: le arquivos .TXT (layout fixo, delimitado por "|") do
* diretorio configurado em SigCdPam.DirImports e grava cada arquivo como uma
* nova movimentacao (SigMvCab/SigMvItn/SigMvIts/SigMvMov).
*
* Tabelas envolvidas: SigCdPam (parametros), SigCdOpe (operacao), SigCdEmp
*                      (empresa), SigCdCli (contas origem/destino/vendedor),
*                      SigCdPro (produto), SigCdCor (cor), SigCdTam (tamanho),
*                      SigMvCab/SigMvItn/SigMvIts/SigMvMov (gravacao final)
*
* Origem: tasks\task629\SIGPRIMP_form_codigo_fonte.txt (PROCEDURE movest/Init)
*==============================================================================

DEFINE CLASS SIGPRIMPBO AS BusinessBase

    *-- Parametros do sistema, carregados de SigCdPam (crSigCdPam no legado)
    this_cMoedaPs    = ""           && Moeda padrao do sistema (SigCdPam.MoedaPs)
    this_nMascNums   = 0             && Tipo de mascara de numeracao (SigCdPam.MascNums numeric(1,0)) - lido pelo SELECT do legado, nao usado na logica do movest()
    this_cDirImport  = ""           && Diretorio de importacao (SigCdPam.DirImports)

    *-- Arquivo corrente sendo importado (Get_Arquivo.Value / lcArq do legado)
    this_cArquivo    = ""           && Caminho completo do arquivo .TXT selecionado

    *-- Cabecalho da movimentacao gerada (crSigMvCab/_Inicio/_IniLet/_pData)
    this_cEmps          = ""        && Codigo da empresa do movimento (crImpMvCab.Emps)
    this_cDopes         = ""        && Codigo da operacao/movimentacao (crImpMvCab.Dopes)
    this_nNumes         = 0         && Numero do movimento gerado (_Inicio / crSigMvCab.Numes)
    this_cNumeroFormatado = ""      && Numero formatado conforme mascara (_IniLet / fGerMascara)
    this_dDataTransacao = {}        && Data/hora da geracao do movimento (_pData / GetDatetime)
    this_dDataMovimento = {}        && Data da movimentacao informada no arquivo (crImpMvCab.Datas)
    this_cGrupoVendedor = ""        && Grupo do vendedor, 10 chars (lcGruVend / SigCdOpe.GrVends)
    this_cChaveEmpDopNums = ""      && Chave posicional Emps+Dopes+Str(Numes,6) (lcEDN)
    this_cCidChaves     = ""        && Chave unica Fortyus do cabecalho (fUniqueIds())

    *-- Dados da operacao (crSigCdOpe)
    this_nNdopes            = 0     && SigCdOpe.NDopes numeric(4,0) - lido pelo SELECT do legado, nao usado na logica do movest()
    this_nNumeras           = 0     && Tipo de numeracao da operacao (SigCdOpe.Numeras numeric(1,0))
    this_nCompensas         = 0     && Percentual de compensacao (SigCdOpe.vCompensas numeric(5,2))
    this_cMoedaOperacao     = ""    && Moeda da operacao (lcMoeOpe / SigCdOpe.Cmoes)
    this_nCotacaoMovimento  = 0     && Cotacao da moeda do movimento (lnCotMov / fBuscarCotacao)

    *-- Contas/empresa referenciadas pelo cabecalho do arquivo
    this_cRazaoOrigem    = ""       && Razao social da conta de origem (crSigCdCli.Rclis)
    this_cRazaoDestino   = ""       && Razao social da conta de destino (crSigCdCli.Rclis)
    this_cRazaoVendedor  = ""       && Razao social do vendedor (crSigCdCli.Rclis)

    *-- Item da movimentacao corrente, lido linha a linha do arquivo (crImpMvCab
    *-- no SCAN / Scatter Memo Memvar). Layout fixo do arquivo .TXT importado:
    this_cTipoRegistro   = ""       && TPREGS C(5) - Tipo de Registro (fixo "MVITN")
    this_cOpers          = ""       && OPERS C(1) - Tipo de Movimento: E = entrada; S = saida
    this_nCitens         = 0        && CITENS C(4) - Codigo de Sequencia do Item (Val())
    this_nCodBarras      = 0        && CODBARRAS C(14) - Codigo de Barras do Item (Val())
    this_cCpros          = ""       && CPROS C(14) - Codigo do Item
    this_cDpros          = ""       && DPROS C(40) - Descricao do Item
    this_cObs            = ""       && OBS C(250) - Observacao de detalhamento do item
    this_cMoedas         = ""       && MOEDAS C(3) - Moeda de Precificacao do Item
    this_cMoevs          = ""       && MOEVS C(3) - Moeda de Venda do Item
    this_nMoevals        = 0        && MOEVALS N(15,6) - Indice de Cotacao da moeda
    this_nQtds           = 0        && QTDS N(15,3) - Quantidade do Item
    this_cCunis          = ""       && CUNIS C(3) - Codigo da Unidade de Medida
    this_nPesos          = 0        && PESOS N(15,3) - Quantidade auxiliar (segunda medida)
    this_cCunips         = ""       && CUNIPS C(3) - Codigo da Unidade Auxiliar de Medida
    this_nFators         = 0        && FATORS N(15,3) - Fator Multiplicador de Quantidade
    this_nUnits          = 0        && UNITS N(15,6) - Valor Unitario do Item
    this_nTotas          = 0        && TOTAS N(15,2) - Valor Total do Item
    this_nValdescs       = 0        && VALDESCS N(15,2) - Valor de Desconto no Item
    this_nValbases       = 0        && VALBASES N(15,2) - Valor de Base de Calculo do Item
    this_cSitribs        = ""       && SITRIBS C(2) - Situacao Tributaria do Item
    this_cTpipis         = ""       && TPIPIS C(1) - Tipo de Tributacao de IPI
    this_nBcipis         = 0        && BCIPIS N(15,2) - Base de Calculo de IPI
    this_nBaseipi2s      = 0        && BASEIPI2S N(15,2) - Base de Calculo de IPI Isento
    this_nBaseipi3s      = 0        && BASEIPI3S N(15,2) - Base de Calculo de IPI Outros
    this_nAliqs          = 0        && ALIQS N(15,2) - Aliquota de IPI
    this_nValipis        = 0        && VALIPIS N(15,2) - Valor de IPI
    this_cSittricms      = ""       && SITTRICMS C(3) - Tipo de Tributacao de ICMS
    this_nBaseicms       = 0        && BASEICMS N(15,2) - Base de Calculo de ICMS
    this_nBaseicm2s      = 0        && BASEICM2S N(15,2) - Base de Calculo de ICMS Isento
    this_nBaseicm3s      = 0        && BASEICM3S N(15,2) - Base de Calculo de ICMS Outros
    this_nAliqicms       = 0        && ALIQICMS N(15,2) - Aliquota de ICMS
    this_nIcms           = 0        && ICMS N(15,2) - Valor de ICMS
    this_cCfops          = ""       && CFOPS C(10) - CFOP de Substituicao Tributaria
    this_nBcicmss        = 0        && BCICMSS N(15,2) - Base de ICMS de Substituicao Tributaria
    this_nIcmss          = 0        && ICMSS N(15,2) - Valor de ICMS de Substituicao Tributaria
    this_nAliqpis        = 0        && ALIQPIS N(15,2) - Aliquota de PIS
    this_nVpis           = 0        && VPIS N(15,2) - Valor de PIS
    this_nAliqcofs       = 0        && ALIQCOFS N(15,2) - Aliquota de COFINS
    this_nVcofins        = 0        && VCOFINS N(15,2) - Valor de COFINS
    this_nIss            = 0        && ISS N(15,2) - Valor de ISS
    this_nIrrf           = 0        && IRRF N(15,2) - Valor de IRRF
    this_nInss           = 0        && INSS N(15,2) - Valor de INSS
    this_nCssl           = 0        && CSSL N(15,2) - Valor de CSSL
    this_nAliqiis        = 0        && ALIQIIS N(15,2) - Aliquota de Imposto de Importacao
    this_nTaxaiis        = 0        && TAXAIIS N(15,2) - Valor de Imposto de Importacao
    this_nNadis          = 0        && NADIS N(3,0) - Numero de Adicao de Importacao
    this_nNiadis         = 0        && NIADIS N(3,0) - Item de Adicao de Importacao
    this_cCodfabs        = ""       && CODFABS C(60) - Codigo do Fabricante Estrangeiro
    this_cOrigmercs      = ""       && ORIGMERCS C(1) - Origem da Mercadoria do Item
    this_cGruorigs       = ""       && GRUORIGS C(10) - Grupo de Origem da Movimentacao
    this_cConorigs       = ""       && CONORIGS C(10) - Conta de Origem da Movimentacao
    this_cGrudests       = ""       && GRUDESTS C(10) - Grupo de Destino da Movimentacao
    this_cCondests       = ""       && CONDESTS C(10) - Conta de Destino da Movimentacao
    this_cVends          = ""       && VENDS C(10) - Codigo do Vendedor
    this_cCodcors        = ""       && CODCORS C(4) - Codigo da Cor do Item
    this_cCodtams        = ""       && CODTAMS C(4) - Codigo do Tamanho do Item
    this_cObses          = ""       && OBSES C(250) - Observacao da movimentacao (cabecalho)

    *-- Totais por moeda, acumulados durante a importacao (TmpTotal do legado)
    this_nValorTotalMovimento = 0   && Valor total acumulado do movimento (lnValtot)

    *-- Controle/resultado do ultimo processamento de arquivo (llOk/lcMsg)
    this_lImportacaoOk        = .F. && Resultado da ultima importacao processada
    this_cMensagemImportacao  = ""  && Motivo de erro/cancelamento da importacao (lcMsg)

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Tabela/chave do CABECALHO da movimentacao: eh a primeira tabela
        *-- registrada no AddCursor do legado ('SigMvCab', 'CidChaves', ...)
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Le SigCdPam (crSigCdPam no Init do legado) e
    * popula os parametros usados pelo processamento. O Form deve chamar este
    * metodo no proprio Init, antes de listar os arquivos do diretorio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_nResultado, loc_lSucesso

        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT moedaps, mascnums, dirimports FROM SigCdPam", "cursor_4c_SigCdPam")

        IF loc_nResultado < 0 OR EOF("cursor_4c_SigCdPam")
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdPam)" + ;
                CHR(13) + CapturarErroSQL()
            loc_lSucesso = .F.
        ELSE
            THIS.this_cMoedaPs   = ALLTRIM(NVL(cursor_4c_SigCdPam.moedaps, ""))
            THIS.this_nMascNums  = NVL(cursor_4c_SigCdPam.mascnums, 0)
            THIS.this_cDirImport = ALLTRIM(NVL(cursor_4c_SigCdPam.dirimports, ""))
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega UMA linha do cursor de importacao (layout fixo
    * do arquivo .TXT, 59 campos - ver comentario do Create Cursor em Inserir())
    * para as propriedades this_*. Equivale ao "Select crImpMvCab / Scatter Memo
    * Memvar" do legado, feito a cada volta do SCAN.
    *
    * Como todo campo do layout se repete em TODA linha do arquivo (o arquivo eh
    * uma linha por ITEM, com os dados do CABECALHO repetidos), a MESMA chamada
    * serve tanto para ler a 1a linha (dados do cabecalho) quanto cada item.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cTipoRegistro  = TratarNulo(TPREGS, "")
        THIS.this_cEmps          = TratarNulo(EMPS, "")
        THIS.this_cDopes         = TratarNulo(DOPES, "")
        THIS.this_cOpers         = TratarNulo(OPERS, "")
        THIS.this_nCitens        = VAL(TratarNulo(CITENS, ""))
        THIS.this_nCodBarras     = VAL(TratarNulo(CODBARRAS, ""))
        THIS.this_cCpros         = TratarNulo(CPROS, "")
        THIS.this_cDpros         = TratarNulo(DPROS, "")
        THIS.this_cObs           = TratarNulo(OBS, "")
        THIS.this_cMoedas        = TratarNulo(MOEDAS, "")
        THIS.this_cMoevs         = TratarNulo(MOEVS, "")
        THIS.this_nMoevals       = TratarNulo(MOEVALS, 0)
        THIS.this_nQtds          = TratarNulo(QTDS, 0)
        THIS.this_cCunis         = TratarNulo(CUNIS, "")
        THIS.this_nPesos         = TratarNulo(PESOS, 0)
        THIS.this_cCunips        = TratarNulo(CUNIPS, "")
        THIS.this_nFators        = TratarNulo(FATORS, 0)
        THIS.this_nUnits         = TratarNulo(UNITS, 0)
        THIS.this_nTotas         = TratarNulo(TOTAS, 0)
        THIS.this_nValdescs      = TratarNulo(VALDESCS, 0)
        THIS.this_nValbases      = TratarNulo(VALBASES, 0)
        THIS.this_cSitribs       = TratarNulo(SITRIBS, "")
        THIS.this_cTpipis        = TratarNulo(TPIPIS, "")
        THIS.this_nBcipis        = TratarNulo(BCIPIS, 0)
        THIS.this_nBaseipi2s     = TratarNulo(BASEIPI2S, 0)
        THIS.this_nBaseipi3s     = TratarNulo(BASEIPI3S, 0)
        THIS.this_nAliqs         = TratarNulo(ALIQS, 0)
        THIS.this_nValipis       = TratarNulo(VALIPIS, 0)
        THIS.this_cSittricms     = TratarNulo(SITTRICMS, "")
        THIS.this_nBaseicms      = TratarNulo(BASEICMS, 0)
        THIS.this_nBaseicm2s     = TratarNulo(BASEICM2S, 0)
        THIS.this_nBaseicm3s     = TratarNulo(BASEICM3S, 0)
        THIS.this_nAliqicms      = TratarNulo(ALIQICMS, 0)
        THIS.this_nIcms          = TratarNulo(ICMS, 0)
        THIS.this_cCfops         = TratarNulo(CFOPS, "")
        THIS.this_nBcicmss       = TratarNulo(BCICMSS, 0)
        THIS.this_nIcmss         = TratarNulo(ICMSS, 0)
        THIS.this_nAliqpis       = TratarNulo(ALIQPIS, 0)
        THIS.this_nVpis          = TratarNulo(VPIS, 0)
        THIS.this_nAliqcofs      = TratarNulo(ALIQCOFS, 0)
        THIS.this_nVcofins       = TratarNulo(VCOFINS, 0)
        THIS.this_nIss           = TratarNulo(ISS, 0)
        THIS.this_nIrrf          = TratarNulo(IRRF, 0)
        THIS.this_nInss          = TratarNulo(INSS, 0)
        THIS.this_nCssl          = TratarNulo(CSSL, 0)
        THIS.this_nAliqiis       = TratarNulo(ALIQIIS, 0)
        THIS.this_nTaxaiis       = TratarNulo(TAXAIIS, 0)
        THIS.this_nNadis         = TratarNulo(NADIS, 0)
        THIS.this_nNiadis        = TratarNulo(NIADIS, 0)
        THIS.this_cCodfabs       = TratarNulo(CODFABS, "")
        THIS.this_cOrigmercs     = TratarNulo(ORIGMERCS, "")
        THIS.this_cGruorigs      = TratarNulo(GRUORIGS, "")
        THIS.this_cConorigs      = TratarNulo(CONORIGS, "")
        THIS.this_cGrudests      = TratarNulo(GRUDESTS, "")
        THIS.this_cCondests      = TratarNulo(CONDESTS, "")
        THIS.this_dDataMovimento = TratarNulo(DATAS, {})
        THIS.this_cVends         = TratarNulo(VENDS, "")
        THIS.this_cCodcors       = TratarNulo(CODCORS, "")
        THIS.this_cCodtams       = TratarNulo(CODTAMS, "")
        THIS.this_cObses         = TratarNulo(OBSES, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave Fortyus do cabecalho da movimentacao gravada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarInsertCompleto - Monta "INSERT INTO T (cols) VALUES (exprs)"
    * cobrindo TODA coluna da tabela (regra CLAUDE.md #22): coluna citada em
    * par_cOverrides recebe a expressao SQL informada; toda coluna NAO citada
    * recebe o "valor em branco" do proprio tipo - o mesmo valor que o
    * AddCursor/Scatter do legado deixava quando o Insert do SCX nao tocava
    * naquele campo (SigMvCab/SigMvItn tem long demais - 138/150 colunas - para
    * listar uma a uma sem risco de esquecer alguma NOT NULL).
    *
    * par_cTabela    - nome da tabela
    * par_cOverrides - "col=<expr SQL>|col=<expr SQL>|..." (col sem aspas,
    *                  expr ja no formato final de SQL Server)
    *
    * Devolve "" se nao conseguir ler as colunas (o chamador aborta).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarInsertCompleto(par_cTabela, par_cOverrides)
        LOCAL loc_cTab, loc_cCols, loc_cExprs, loc_cCol, loc_cTipo, loc_cNulo, ;
            loc_cOvr, loc_nPos, loc_cValor, loc_nResultado, loc_cSQL, ;
            loc_nUsados, loc_nPedidos, loc_cDefault

        loc_cTab = ALLTRIM(par_cTabela)

        IF USED("cursor_4c_ColsIns")
            USE IN cursor_4c_ColsIns
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME AS col, DATA_TYPE AS tipo, IS_NULLABLE AS nulavel" + ;
            " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = " + EscaparSQL(loc_cTab) + ;
            " ORDER BY ORDINAL_POSITION", "cursor_4c_ColsIns")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ColsIns") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler as colunas de " + loc_cTab + ":" + CHR(13) + CapturarErroSQL()
            RETURN ""
        ENDIF

        loc_cCols   = ""
        loc_cExprs  = ""
        loc_nUsados = 0

        SELECT cursor_4c_ColsIns
        SCAN
            loc_cCol  = ALLTRIM(cursor_4c_ColsIns.col)
            loc_cTipo = LOWER(ALLTRIM(cursor_4c_ColsIns.tipo))
            loc_cNulo = ALLTRIM(cursor_4c_ColsIns.nulavel)

            loc_cOvr = "|" + ALLTRIM(NVL(par_cOverrides, "")) + "|"
            loc_nPos = AT("|" + LOWER(loc_cCol) + "=", LOWER(loc_cOvr))

            IF loc_nPos > 0
                loc_cValor  = SUBSTR(loc_cOvr, loc_nPos + LEN(loc_cCol) + 2)
                loc_cValor  = LEFT(loc_cValor, AT("|", loc_cValor) - 1)
                loc_nUsados = loc_nUsados + 1
            ELSE
                DO CASE
                    CASE INLIST(loc_cTipo, "char", "varchar", "nchar", "nvarchar", "text", "ntext")
                        loc_cDefault = EscaparSQL("")
                    CASE INLIST(loc_cTipo, "numeric", "decimal", "int", "smallint", "tinyint", ;
                            "bigint", "float", "real", "money", "smallmoney", "bit")
                        loc_cDefault = "0"
                    CASE INLIST(loc_cTipo, "datetime", "smalldatetime", "date")
                        IF UPPER(loc_cNulo) = "YES"
                            loc_cDefault = "NULL"
                        ELSE
                            loc_cDefault = "'19000101'"
                        ENDIF
                    CASE loc_cTipo = "uniqueidentifier"
                        loc_cDefault = "NEWID()"
                    OTHERWISE
                        loc_cDefault = "NULL"
                ENDCASE
                loc_cValor = loc_cDefault
            ENDIF

            loc_cCols  = loc_cCols  + IIF(EMPTY(loc_cCols),  "", ", ") + loc_cCol
            loc_cExprs = loc_cExprs + IIF(EMPTY(loc_cExprs), "", ", ") + loc_cValor
        ENDSCAN

        IF USED("cursor_4c_ColsIns")
            USE IN cursor_4c_ColsIns
        ENDIF

        *-- Cada override precisa ter casado com uma coluna REAL - senao uma
        *-- grafia errada vira gravacao calada em coluna nenhuma (regra #22).
        loc_nPedidos = 0
        IF !EMPTY(NVL(par_cOverrides, ""))
            loc_nPedidos = OCCURS("|", ALLTRIM(par_cOverrides)) + 1
        ENDIF

        IF loc_nUsados < loc_nPedidos
            THIS.this_cMensagemErro = "Inser" + CHR(231) + CHR(227) + "o em " + loc_cTab + ;
                ": " + TRANSFORM(loc_nPedidos - loc_nUsados) + " de " + TRANSFORM(loc_nPedidos) + ;
                " campos informados n" + CHR(227) + "o existem na tabela." + CHR(13) + ;
                ALLTRIM(par_cOverrides)
            RETURN ""
        ENDIF

        loc_cSQL = "INSERT INTO " + loc_cTab + " (" + loc_cCols + ") VALUES (" + loc_cExprs + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Processa UM arquivo de importacao (THIS.this_cArquivo) e grava
    * a movimentacao de estoque correspondente. Equivalente ao PROCEDURE movest
    * do legado (SIGPRIMP.SCX), transcrito linha a linha (regra #17) e adaptado
    * para gravar via SQLEXEC/SQL Server em vez de cursores remotos bufferizados
    * (poDataMgr.AddCursor/.Update/.Commit/.RollBack do fSqlConector legado).
    *
    * Os 4 INSERT do cabecalho/item/sub-item/totais vao num UNICO SQLEXEC, com
    * controle de transacao em T-SQL (SAVE TRANSACTION + THROW), porque BEGIN/
    * COMMIT via SQLEXEC separados NAO dao atomicidade nesta conexao (ela nasce
    * com Transactions=2 e @@TRANCOUNT ja vale 1 - ver ProdutoBO.CopiarProduto).
    *
    * Atualizar() continua herdado de BusinessBase: o movest() do legado so
    * GRAVA movimentos novos (Insert Into) - nao existe fluxo de alteracao de
    * um SigMvCab ja importado, entao o comportamento padrao de Atualizar() ja
    * eh o correto para este BO.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cArq, loc_lOk, loc_cMsg, loc_nResultado, loc_cSQL, loc_oErro, ;
            loc_cEmps, loc_cDopes, loc_dDataMovimento, loc_cGruOrigs, loc_cConOrigs, ;
            loc_cGruDests, loc_cConDests, loc_cVends, loc_cObses, loc_nTentativas, ;
            loc_nCandidato, loc_cChaveTeste, loc_lNumeroNovo, loc_nInicio, loc_cMascara, ;
            loc_dDataGeracao, loc_cGruVend, loc_cChaveEDN, loc_cCidChaves, loc_cLote, ;
            loc_cOvr, loc_nValorTotalMovimento, loc_nCotItn, loc_cMoedaItem, ;
            loc_nUnitsItem, loc_nTotasItem, loc_cCidChavesItem, loc_lItemTemSubItem, ;
            loc_cCidChavesIts

        loc_lOk  = .T.
        loc_cMsg = ""
        loc_cArq = ALLTRIM(NVL(THIS.this_cArquivo, ""))

        THIS.this_cMensagemErro       = ""
        THIS.this_lErroExibido        = .F.
        THIS.this_lImportacaoOk       = .F.
        THIS.this_cMensagemImportacao = ""

        IF EMPTY(loc_cArq)
            THIS.this_cMensagemErro = "Informe o arquivo a importar."
            THIS.ExibirFalha("Importa" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Checagem de espaco no caminho do arquivo (comentario do legado:
        *-- "Tiago - Checagem de espaco no caminho do arquivo para nao dar erro")
        IF AT(" ", loc_cArq) > 0
            THIS.this_cMensagemErro = "Arquivo '" + loc_cArq + "' Inv" + CHR(225) + "lido! " + ;
                "Verifique se o caminho possui espa" + CHR(231) + "os em branco!"
            THIS.ExibirFalha("Sele" + CHR(231) + CHR(227) + "o de Arquivo")
            RETURN .F.
        ENDIF

        *-- Layout fixo do arquivo .TXT importado (57 campos do legado + os
        *-- dois que o dump cita no final do Create Cursor: CODCORS/CODTAMS/
        *-- OBSES). A ORDEM tem de ser EXATA - APPEND FROM DELIMITED casa por
        *-- POSICAO, nao por nome.
        IF USED("cursor_4c_ImpMvCab")
            USE IN cursor_4c_ImpMvCab
        ENDIF
        CREATE CURSOR cursor_4c_ImpMvCab (TPREGS C(5), EMPS C(3), DOPES C(20), OPERS C(1), ;
            CITENS C(4), CODBARRAS C(14), CPROS C(14), DPROS C(40), OBS C(250), MOEDAS C(3), ;
            MOEVS C(3), MOEVALS N(15,6), QTDS N(15,3), CUNIS C(3), PESOS N(15,3), CUNIPS C(3), ;
            FATORS N(15,3), UNITS N(15,6), TOTAS N(15,2), VALDESCS N(15,2), VALBASES N(15,2), ;
            SITRIBS C(2), TPIPIS C(1), BCIPIS N(15,2), BASEIPI2S N(15,2), BASEIPI3S N(15,2), ;
            ALIQS N(15,2), VALIPIS N(15,2), SITTRICMS C(3), BASEICMS N(15,2), BASEICM2S N(15,2), ;
            BASEICM3S N(15,2), ALIQICMS N(15,2), ICMS N(15,2), CFOPS C(10), BCICMSS N(15,2), ;
            ICMSS N(15,2), ALIQPIS N(15,2), VPIS N(15,2), ALIQCOFS N(15,2), VCOFINS N(15,2), ;
            ISS N(15,2), IRRF N(15,2), INSS N(15,2), CSSL N(15,2), ALIQIIS N(15,2), ;
            TAXAIIS N(15,2), NADIS N(3), NIADIS N(3), CODFABS C(60), ORIGMERCS C(1), ;
            GRUORIGS C(10), CONORIGS C(10), GRUDESTS C(10), CONDESTS C(10), DATAS D, ;
            VENDS C(10), CODCORS C(4), CODTAMS C(4), OBSES C(250))

        SELECT cursor_4c_ImpMvCab
        APPEND FROM (loc_cArq) DELIMITED WITH CHARACTER '|'
        GO TOP

        IF EOF("cursor_4c_ImpMvCab") OR UPPER(ALLTRIM(cursor_4c_ImpMvCab.TPREGS)) != "MVITN"
            THIS.this_cMensagemErro = "Arquivo '" + loc_cArq + "' inv" + CHR(225) + ;
                "lido para importa" + CHR(231) + CHR(227) + "o de movimenta" + CHR(231) + ;
                CHR(245) + "es"
            IF USED("cursor_4c_ImpMvCab")
                USE IN cursor_4c_ImpMvCab
            ENDIF
            THIS.ExibirFalha("Importa" + CHR(231) + CHR(227) + "o cancelada")
            RETURN .F.
        ENDIF

        *-- Dados do CABECALHO: repetidos em toda linha do arquivo - usar a 1a
        THIS.CarregarDoCursor("cursor_4c_ImpMvCab")
        loc_cEmps          = THIS.this_cEmps
        loc_cDopes         = THIS.this_cDopes
        loc_dDataMovimento = THIS.this_dDataMovimento
        loc_cGruOrigs      = THIS.this_cGruorigs
        loc_cConOrigs      = THIS.this_cConorigs
        loc_cGruDests      = THIS.this_cGrudests
        loc_cConDests      = THIS.this_cCondests
        loc_cVends         = THIS.this_cVends
        loc_cObses         = THIS.this_cObses

        *-- Operacao (SigCdOpe) - sem ela nao ha mascara/moeda/numeracao
        IF USED("cursor_4c_SigCdOpe")
            USE IN cursor_4c_SigCdOpe
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT dopes, ndopes, numeras, vcompensas, grvends, cmoes FROM SigCdOpe" + ;
            " WHERE dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_SigCdOpe")
        IF loc_nResultado < 0
            loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdOpe)" + CHR(13) + CapturarErroSQL()
            loc_lOk  = .F.
        ELSE
            IF EOF("cursor_4c_SigCdOpe")
                loc_cMsg = "Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o configurada no sistema."
                loc_lOk  = .F.
            ELSE
                THIS.this_nNdopes       = NVL(cursor_4c_SigCdOpe.ndopes, 0)
                THIS.this_nNumeras      = NVL(cursor_4c_SigCdOpe.numeras, 0)
                THIS.this_nCompensas    = NVL(cursor_4c_SigCdOpe.vcompensas, 0)
                THIS.this_cMoedaOperacao = ALLTRIM(NVL(cursor_4c_SigCdOpe.cmoes, ""))
                loc_cGruVend             = LEFT(ALLTRIM(NVL(cursor_4c_SigCdOpe.grvends, "")) + SPACE(10), 10)
            ENDIF
        ENDIF
        IF USED("cursor_4c_SigCdOpe")
            USE IN cursor_4c_SigCdOpe
        ENDIF

        *-- Empresa (SigCdEmp.Cemps - regra do projeto: Cemps/Razas, nunca Cemps)
        IF loc_lOk
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps), "cursor_4c_SigCdEmp")
            IF loc_nResultado < 0
                loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdEmp)" + CHR(13) + CapturarErroSQL()
                loc_lOk  = .F.
            ELSE
                IF EOF("cursor_4c_SigCdEmp")
                    loc_cMsg = "Empresa n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
        ENDIF

        *-- Conta de origem (SigCdCli)
        IF loc_lOk
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConOrigs), "cursor_4c_SigCdCli")
            IF loc_nResultado < 0
                loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdCli)" + CHR(13) + CapturarErroSQL()
                loc_lOk  = .F.
            ELSE
                IF EOF("cursor_4c_SigCdCli")
                    loc_cMsg = "Conta de origem n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ELSE
                    THIS.this_cRazaoOrigem = ALLTRIM(NVL(cursor_4c_SigCdCli.rclis, ""))
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
        ENDIF

        *-- Conta de destino (SigCdCli)
        IF loc_lOk
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConDests), "cursor_4c_SigCdCli")
            IF loc_nResultado < 0
                loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdCli)" + CHR(13) + CapturarErroSQL()
                loc_lOk  = .F.
            ELSE
                IF EOF("cursor_4c_SigCdCli")
                    loc_cMsg = "Conta de destino n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ELSE
                    THIS.this_cRazaoDestino = ALLTRIM(NVL(cursor_4c_SigCdCli.rclis, ""))
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
        ENDIF

        *-- Vendedor (SigCdCli)
        IF loc_lOk
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVends), "cursor_4c_SigCdCli")
            IF loc_nResultado < 0
                loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdCli)" + CHR(13) + CapturarErroSQL()
                loc_lOk  = .F.
            ELSE
                IF EOF("cursor_4c_SigCdCli")
                    loc_cMsg = "Conta de vendedor n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ELSE
                    THIS.this_cRazaoVendedor = ALLTRIM(NVL(cursor_4c_SigCdCli.rclis, ""))
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
        ENDIF

        loc_cLote = ""

        IF loc_lOk
            *-- Totais por moeda, acumulados durante a importacao (TmpTotal do
            *-- legado) - cursor de TRABALHO, nunca vai para o banco direto;
            *-- vira linhas de SigMvMov so no fim, via MontarInsertCompleto.
            IF USED("cursor_4c_TmpTotal")
                USE IN cursor_4c_TmpTotal
            ENDIF
            CREATE CURSOR cursor_4c_TmpTotal (Moeds C(3), Valtots N(12,2), Valitens N(12,2), ;
                Valdifs N(12,2), PorcDifs N(12,4), Tipos C(1), Coefs N(6,3), Teors N(6,3), ;
                Qtdes N(10,3), Mobras N(10,2), nSinals N(3), MoeVals N(12,5))
            INDEX ON Moeds TAG Moeds

            *-- Numeracao do movimento
            loc_lNumeroNovo = .T.
            loc_nInicio     = 0

            IF THIS.this_nNumeras = 5
                *-- Numeracao aleatoria: sorteia e confere duplicidade direto no
                *-- banco (ChkRegister do legado NAO existe nesta arquitetura -
                *-- regra do projeto: SELECT COUNT(*) no lugar do metodo do
                *-- fSqlConector legado).
                loc_nTentativas = 0
                DO WHILE loc_nInicio = 0 AND loc_nTentativas < 50
                    loc_nTentativas = loc_nTentativas + 1
                    loc_nCandidato  = INT(RAND() * 899999) + 100000
                    loc_cChaveTeste = PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nCandidato, 6)

                    IF USED("cursor_4c_ChkDup")
                        USE IN cursor_4c_ChkDup
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE empdopnums = " + ;
                        EscaparSQL(loc_cChaveTeste), "cursor_4c_ChkDup")
                    IF NVL(cursor_4c_ChkDup.nExiste, 0) = 0
                        loc_nInicio = loc_nCandidato
                    ENDIF
                    IF USED("cursor_4c_ChkDup")
                        USE IN cursor_4c_ChkDup
                    ENDIF
                ENDDO
                loc_lNumeroNovo = .F.

                IF loc_nInicio = 0
                    loc_cMsg = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar numera" + ;
                        CHR(231) + CHR(227) + "o " + CHR(250) + "nica para a movimenta" + ;
                        CHR(231) + CHR(227) + "o."
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk AND loc_lNumeroNovo AND THIS.this_nNumeras != 2
                loc_nInicio = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
            ENDIF
        ENDIF

        IF loc_lOk
            loc_cMascara     = ALLTRIM(fGerMascara(loc_nInicio))
            loc_dDataGeracao = DATETIME()
            loc_cChaveEDN    = PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nInicio, 6)
            loc_cCidChaves   = fUniqueIds()
            THIS.this_nNumes              = loc_nInicio
            THIS.this_cNumeroFormatado    = loc_cMascara
            THIS.this_dDataTransacao      = loc_dDataGeracao
            THIS.this_cChaveEmpDopNums    = loc_cChaveEDN
            THIS.this_cCidChaves          = loc_cCidChaves
            THIS.this_cGrupoVendedor      = loc_cGruVend

            *-- 1) Cabecalho da movimentacao (SigMvCab) - 24 colunas explicitas
            *--    do Insert Into do legado; o resto vem em branco/zero via
            *--    MontarInsertCompleto (regra #22).
            loc_cOvr = "emps="       + EscaparSQL(loc_cEmps) + ;
                "|dopes="            + EscaparSQL(loc_cDopes) + ;
                "|numes="            + FormatarNumeroSQL(loc_nInicio, 0) + ;
                "|usuars="           + EscaparSQL(LEFT(ALLTRIM(NVL(gc_4c_UsuarioLogado, "")) + SPACE(10), 10)) + ;
                "|datars=GETDATE()" + ;
                "|datas="            + FormatarDataSQL(loc_dDataMovimento) + ;
                "|transps=0" + ;
                "|mascnum="          + EscaparSQL(loc_cMascara) + ;
                "|tabds="            + EscaparSQL("") + ;
                "|lprecos="          + EscaparSQL("") + ;
                "|cidchaves="        + EscaparSQL(loc_cCidChaves) + ;
                "|empdopnums="       + EscaparSQL(loc_cChaveEDN) + ;
                "|dgopes="           + EscaparSQL("") + ;
                "|vcompensas="       + FormatarNumeroSQL(THIS.this_nCompensas, 2) + ;
                "|grupoos="          + EscaparSQL(loc_cGruOrigs) + ;
                "|contaos="          + EscaparSQL(loc_cConOrigs) + ;
                "|grupods="          + EscaparSQL(loc_cGruDests) + ;
                "|contads="          + EscaparSQL(loc_cConDests) + ;
                "|grvends="          + EscaparSQL(loc_cGruVend) + ;
                "|vends="            + EscaparSQL(loc_cVends) + ;
                "|grresps="          + EscaparSQL(loc_cGruVend) + ;
                "|resps="            + EscaparSQL(loc_cVends) + ;
                "|obses="            + EscaparSQL(loc_cObses) + ;
                "|datatrans=GETDATE()"

            loc_cSQL = THIS.MontarInsertCompleto("SigMvCab", loc_cOvr)
            IF EMPTY(loc_cSQL)
                loc_lOk  = .F.
                loc_cMsg = THIS.this_cMensagemErro
            ELSE
                loc_cLote = loc_cLote + loc_cSQL + ";" + CHR(13) + CHR(10)
            ENDIF
        ENDIF

        *-- Moeda/cotacao da operacao
        IF loc_lOk
            loc_nValorTotalMovimento = 0

            THIS.this_nCotacaoMovimento = fBuscarCotacao( ;
                IIF(!EMPTY(THIS.this_cMoedaOperacao), THIS.this_cMoedaOperacao, THIS.this_cMoedaPs), ;
                loc_dDataMovimento, gnConnHandle)

            IF !EMPTY(THIS.this_cMoedaOperacao)
                IF !SEEK(THIS.this_cMoedaOperacao, "cursor_4c_TmpTotal", "Moeds")
                    INSERT INTO cursor_4c_TmpTotal (Moeds, Moevals) ;
                        VALUES (THIS.this_cMoedaOperacao, THIS.this_nCotacaoMovimento)
                ELSE
                    THIS.this_nCotacaoMovimento = cursor_4c_TmpTotal.Moevals
                ENDIF
            ENDIF

            *-- 2) Itens da movimentacao (SigMvItn), um por linha do arquivo
            SELECT cursor_4c_ImpMvCab
            SCAN
                IF !loc_lOk
                    EXIT
                ENDIF

                THIS.CarregarDoCursor("cursor_4c_ImpMvCab")

                IF USED("cursor_4c_SigCdPro")
                    USE IN cursor_4c_SigCdPro
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(THIS.this_cCpros), ;
                    "cursor_4c_SigCdPro")
                IF loc_nResultado < 0
                    loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdPro)" + CHR(13) + CapturarErroSQL()
                    loc_lOk  = .F.
                ELSE
                    IF EOF("cursor_4c_SigCdPro")
                        loc_cMsg = "Produto " + ALLTRIM(THIS.this_cCpros) + " n" + CHR(227) + "o cadastrado."
                        loc_lOk  = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigCdPro")
                    USE IN cursor_4c_SigCdPro
                ENDIF

                IF !loc_lOk
                    EXIT
                ENDIF

                loc_cCidChavesItem = fUniqueIds()

                loc_nCotItn = IIF(!EMPTY(THIS.this_nMoevals), THIS.this_nMoevals, ;
                    fBuscarCotacao(THIS.this_cMoedas, THIS.this_dDataMovimento, gnConnHandle))

                IF !EMPTY(THIS.this_cMoedas)
                    IF !SEEK(THIS.this_cMoedas, "cursor_4c_TmpTotal", "Moeds")
                        INSERT INTO cursor_4c_TmpTotal (Moeds, Moevals) ;
                            VALUES (THIS.this_cMoedas, THIS.this_nMoevals)
                    ENDIF
                ENDIF

                loc_cMoedaItem  = THIS.this_cMoedas
                loc_nUnitsItem  = THIS.this_nUnits
                loc_nTotasItem  = THIS.this_nTotas

                IF !EMPTY(THIS.this_cMoedaOperacao) AND THIS.this_cMoedaOperacao != loc_cMoedaItem
                    loc_nUnitsItem = loc_nUnitsItem * loc_nCotItn / THIS.this_nCotacaoMovimento
                    loc_nTotasItem = loc_nTotasItem * loc_nCotItn / THIS.this_nCotacaoMovimento
                    loc_cMoedaItem = THIS.this_cMoedaOperacao
                ENDIF

                loc_nValorTotalMovimento = loc_nValorTotalMovimento + ;
                    IIF(THIS.this_cMoedaOperacao != loc_cMoedaItem, ;
                        (loc_nTotasItem * THIS.this_nMoevals) / THIS.this_nCotacaoMovimento, ;
                        loc_nTotasItem)

                loc_cOvr = "emps="      + EscaparSQL(THIS.this_cEmps) + ;
                    "|dopes="           + EscaparSQL(THIS.this_cDopes) + ;
                    "|opers="           + EscaparSQL(THIS.this_cOpers) + ;
                    "|citens="          + FormatarNumeroSQL(THIS.this_nCitens, 0) + ;
                    "|codbarras="       + FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ;
                    "|cpros="           + EscaparSQL(THIS.this_cCpros) + ;
                    "|dpros="           + EscaparSQL(THIS.this_cDpros) + ;
                    "|obs="             + EscaparSQL(THIS.this_cObs) + ;
                    "|moedas="          + EscaparSQL(loc_cMoedaItem) + ;
                    "|moevs="           + EscaparSQL(THIS.this_cMoevs) + ;
                    "|moevals="         + FormatarNumeroSQL(THIS.this_nMoevals, 6) + ;
                    "|qtds="            + FormatarNumeroSQL(THIS.this_nQtds, 3) + ;
                    "|cunis="           + EscaparSQL(THIS.this_cCunis) + ;
                    "|pesos="           + FormatarNumeroSQL(THIS.this_nPesos, 3) + ;
                    "|cunips="          + EscaparSQL(THIS.this_cCunips) + ;
                    "|fators="          + FormatarNumeroSQL(THIS.this_nFators, 3) + ;
                    "|units="           + FormatarNumeroSQL(loc_nUnitsItem, 6) + ;
                    "|totas="           + FormatarNumeroSQL(loc_nTotasItem, 2) + ;
                    "|valdescs="        + FormatarNumeroSQL(THIS.this_nValdescs, 2) + ;
                    "|valbases="        + FormatarNumeroSQL(THIS.this_nValbases, 2) + ;
                    "|sitribs="         + EscaparSQL(THIS.this_cSitribs) + ;
                    "|tpipis="          + EscaparSQL(THIS.this_cTpipis) + ;
                    "|bcipis="          + FormatarNumeroSQL(THIS.this_nBcipis, 2) + ;
                    "|baseipi2s="       + FormatarNumeroSQL(THIS.this_nBaseipi2s, 2) + ;
                    "|baseipi3s="       + FormatarNumeroSQL(THIS.this_nBaseipi3s, 2) + ;
                    "|aliqs="           + FormatarNumeroSQL(THIS.this_nAliqs, 2) + ;
                    "|valipis="         + FormatarNumeroSQL(THIS.this_nValipis, 2) + ;
                    "|sittricms="       + EscaparSQL(THIS.this_cSittricms) + ;
                    "|baseicms="        + FormatarNumeroSQL(THIS.this_nBaseicms, 2) + ;
                    "|baseicm2s="       + FormatarNumeroSQL(THIS.this_nBaseicm2s, 2) + ;
                    "|baseicm3s="       + FormatarNumeroSQL(THIS.this_nBaseicm3s, 2) + ;
                    "|aliqicms="        + FormatarNumeroSQL(THIS.this_nAliqicms, 2) + ;
                    "|icms="            + FormatarNumeroSQL(THIS.this_nIcms, 2) + ;
                    "|cfops="           + EscaparSQL(THIS.this_cCfops) + ;
                    "|bcicmss="         + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ;
                    "|icmss="           + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ;
                    "|aliqpis="         + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ;
                    "|vpis="            + FormatarNumeroSQL(THIS.this_nVpis, 2) + ;
                    "|aliqcofs="        + FormatarNumeroSQL(THIS.this_nAliqcofs, 2) + ;
                    "|vcofins="         + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ;
                    "|iss="             + FormatarNumeroSQL(THIS.this_nIss, 2) + ;
                    "|irrf="            + FormatarNumeroSQL(THIS.this_nIrrf, 2) + ;
                    "|inss="            + FormatarNumeroSQL(THIS.this_nInss, 2) + ;
                    "|cssl="            + FormatarNumeroSQL(THIS.this_nCssl, 2) + ;
                    "|aliqiis="         + FormatarNumeroSQL(THIS.this_nAliqiis, 2) + ;
                    "|taxaiis="         + FormatarNumeroSQL(THIS.this_nTaxaiis, 2) + ;
                    "|nadis="           + FormatarNumeroSQL(THIS.this_nNadis, 0) + ;
                    "|niadis="          + FormatarNumeroSQL(THIS.this_nNiadis, 0) + ;
                    "|codfabs="         + EscaparSQL(THIS.this_cCodfabs) + ;
                    "|origmercs="       + EscaparSQL(THIS.this_cOrigmercs) + ;
                    "|numes="           + FormatarNumeroSQL(loc_nInicio, 0) + ;
                    "|empdopnums="      + EscaparSQL(loc_cChaveEDN) + ;
                    "|cidchaves="       + EscaparSQL(loc_cCidChavesItem) + ;
                    "|unit2s="          + FormatarNumeroSQL(loc_nUnitsItem, 6) + ;
                    "|univals="         + FormatarNumeroSQL(loc_nUnitsItem, 6)

                loc_cSQL = THIS.MontarInsertCompleto("SigMvItn", loc_cOvr)
                IF EMPTY(loc_cSQL)
                    loc_lOk  = .F.
                    loc_cMsg = THIS.this_cMensagemErro
                    EXIT
                ENDIF
                loc_cLote = loc_cLote + loc_cSQL + ";" + CHR(13) + CHR(10)

                *-- 3) Sub-item de cor/tamanho (SigMvIts), so quando informado
                loc_lItemTemSubItem = !EMPTY(THIS.this_cCodcors) OR !EMPTY(THIS.this_cCodtams)
                IF loc_lItemTemSubItem
                    IF !EMPTY(THIS.this_cCodcors)
                        IF USED("cursor_4c_SigCdCor")
                            USE IN cursor_4c_SigCdCor
                        ENDIF
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(THIS.this_cCodcors), ;
                            "cursor_4c_SigCdCor")
                        IF loc_nResultado < 0
                            loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdCor)" + CHR(13) + CapturarErroSQL()
                            loc_lOk  = .F.
                        ELSE
                            IF EOF("cursor_4c_SigCdCor")
                                loc_cMsg = "Cor " + ALLTRIM(THIS.this_cCodcors) + " n" + CHR(227) + "o cadastrada."
                                loc_lOk  = .F.
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_SigCdCor")
                            USE IN cursor_4c_SigCdCor
                        ENDIF
                    ENDIF

                    IF loc_lOk AND !EMPTY(THIS.this_cCodtams)
                        IF USED("cursor_4c_SigCdTam")
                            USE IN cursor_4c_SigCdTam
                        ENDIF
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(THIS.this_cCodtams), ;
                            "cursor_4c_SigCdTam")
                        IF loc_nResultado < 0
                            loc_cMsg = "Favor Reinicializar o Processo!!! (SigCdTam)" + CHR(13) + CapturarErroSQL()
                            loc_lOk  = .F.
                        ELSE
                            IF EOF("cursor_4c_SigCdTam")
                                loc_cMsg = "Tamanho " + ALLTRIM(THIS.this_cCodtams) + " n" + CHR(227) + "o cadastrado."
                                loc_lOk  = .F.
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_SigCdTam")
                            USE IN cursor_4c_SigCdTam
                        ENDIF
                    ENDIF

                    IF !loc_lOk
                        EXIT
                    ENDIF

                    loc_cCidChavesIts = fUniqueIds()

                    loc_cOvr = "citens="  + FormatarNumeroSQL(THIS.this_nCitens, 0) + ;
                        "|emps="          + EscaparSQL(THIS.this_cEmps) + ;
                        "|dopes="         + EscaparSQL(THIS.this_cDopes) + ;
                        "|numes="         + FormatarNumeroSQL(loc_nInicio, 0) + ;
                        "|cpros="         + EscaparSQL(THIS.this_cCpros) + ;
                        "|codtams="       + EscaparSQL(THIS.this_cCodtams) + ;
                        "|codcors="       + EscaparSQL(THIS.this_cCodcors) + ;
                        "|qtds="          + FormatarNumeroSQL(THIS.this_nQtds, 3) + ;
                        "|qtdembs="       + FormatarNumeroSQL(1, 1) + ;
                        "|codbarras="     + FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ;
                        "|pesos="         + FormatarNumeroSQL(THIS.this_nPesos, 3) + ;
                        "|cidchaves="     + EscaparSQL(loc_cCidChavesIts) + ;
                        "|empdopnums="    + EscaparSQL(loc_cChaveEDN)

                    loc_cSQL = THIS.MontarInsertCompleto("SigMvIts", loc_cOvr)
                    IF EMPTY(loc_cSQL)
                        loc_lOk  = .F.
                        loc_cMsg = THIS.this_cMensagemErro
                        EXIT
                    ENDIF
                    loc_cLote = loc_cLote + loc_cSQL + ";" + CHR(13) + CHR(10)
                ENDIF
            ENDSCAN

            *-- 4) Totais por moeda (SigMvMov) + fechamento do Valos/ValInis
            IF loc_lOk
                SELECT cursor_4c_TmpTotal
                SCAN
                    IF !EMPTY(cursor_4c_TmpTotal.Moeds) AND !EMPTY(cursor_4c_TmpTotal.MoeVals)
                        loc_cOvr = "emps="   + EscaparSQL(loc_cEmps) + ;
                            "|dopes="        + EscaparSQL(loc_cDopes) + ;
                            "|numes="        + FormatarNumeroSQL(loc_nInicio, 0) + ;
                            "|moeds="        + EscaparSQL(ALLTRIM(cursor_4c_TmpTotal.Moeds)) + ;
                            "|valtots="      + FormatarNumeroSQL(cursor_4c_TmpTotal.Valtots, 2) + ;
                            "|valitens="     + FormatarNumeroSQL(cursor_4c_TmpTotal.Valitens, 2) + ;
                            "|valdifs="      + FormatarNumeroSQL(cursor_4c_TmpTotal.Valdifs, 2) + ;
                            "|porcdifs="     + FormatarNumeroSQL(cursor_4c_TmpTotal.PorcDifs, 4) + ;
                            "|tipos="        + EscaparSQL(cursor_4c_TmpTotal.Tipos) + ;
                            "|datatrans=GETDATE()" + ;
                            "|coefs="        + FormatarNumeroSQL(cursor_4c_TmpTotal.Coefs, 3) + ;
                            "|teors="        + FormatarNumeroSQL(cursor_4c_TmpTotal.Teors, 3) + ;
                            "|qtdes="        + FormatarNumeroSQL(cursor_4c_TmpTotal.Qtdes, 3) + ;
                            "|mobras="       + FormatarNumeroSQL(cursor_4c_TmpTotal.Mobras, 2) + ;
                            "|nsinals="      + FormatarNumeroSQL(cursor_4c_TmpTotal.nSinals, 0) + ;
                            "|empdopnums="   + EscaparSQL(loc_cChaveEDN) + ;
                            "|cidchaves="    + EscaparSQL(fUniqueIds()) + ;
                            "|dtalts=GETDATE()" + ;
                            "|moevals="      + FormatarNumeroSQL(cursor_4c_TmpTotal.MoeVals, 6)

                        loc_cSQL = THIS.MontarInsertCompleto("SigMvMov", loc_cOvr)
                        IF EMPTY(loc_cSQL)
                            loc_lOk  = .F.
                            loc_cMsg = THIS.this_cMensagemErro
                            EXIT
                        ENDIF
                        loc_cLote = loc_cLote + loc_cSQL + ";" + CHR(13) + CHR(10)
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lOk
                THIS.this_nValorTotalMovimento = loc_nValorTotalMovimento
                loc_cLote = loc_cLote + ;
                    "UPDATE SigMvCab SET valos = " + FormatarNumeroSQL(loc_nValorTotalMovimento, 2) + ;
                    ", valinis = " + FormatarNumeroSQL(loc_nValorTotalMovimento, 2) + ;
                    " WHERE cidchaves = " + EscaparSQL(loc_cCidChaves) + ";" + CHR(13) + CHR(10)
            ENDIF
        ENDIF

        IF USED("cursor_4c_TmpTotal")
            USE IN cursor_4c_TmpTotal
        ENDIF
        IF USED("cursor_4c_ImpMvCab")
            USE IN cursor_4c_ImpMvCab
        ENDIF

        *-- ============ EXECUCAO ATOMICA DO LOTE ============
        IF loc_lOk AND !EMPTY(loc_cLote)
            TRY
                loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                    "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                    "ELSE SAVE TRANSACTION Imp4c;" + CHR(13) + CHR(10) + ;
                    "BEGIN TRY" + CHR(13) + CHR(10) + ;
                    loc_cLote + ;
                    "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                    "END TRY" + CHR(13) + CHR(10) + ;
                    "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                    "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Imp4c; END;" + CHR(13) + CHR(10) + ;
                    "THROW;" + CHR(13) + CHR(10) + ;
                    "END CATCH"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cMsg = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()
                    loc_lOk  = .F.
                ENDIF
            CATCH TO loc_oErro
                loc_cMsg = loc_oErro.Message
                loc_lOk  = .F.
            ENDTRY
        ELSE
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            THIS.RegistrarAuditoria("INSERT")
            =fGravarLog("T", loc_cDopes, "INSERIR", ;
                loc_cEmps + "-" + ALLTRIM(loc_cDopes) + "-" + ALLTRIM(STR(loc_nInicio, 6)))

            THIS.this_lImportacaoOk       = .T.
            THIS.this_cMensagemImportacao = "Arquivo '" + loc_cArq + "' importado!"
            MsgInfo(THIS.this_cMensagemImportacao, "Importa" + CHR(231) + CHR(227) + "o conclu" + CHR(237) + "da")
        ELSE
            THIS.this_lImportacaoOk       = .F.
            THIS.this_cMensagemImportacao = loc_cMsg
            THIS.this_cMensagemErro       = loc_cMsg
            =fGravarLog("T", "SIGPRIMP", "ERRO", loc_cArq + " - " + loc_cMsg)
            THIS.ExibirFalha("Importa" + CHR(231) + CHR(227) + "o cancelada")
        ENDIF

        RETURN loc_lOk
    ENDPROC

ENDDEFINE

