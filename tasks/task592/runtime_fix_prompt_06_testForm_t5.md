# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 5/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-27 02:03:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-27 02:03:31] [INFO] Config FPW: (nao fornecido)
[2026-09-27 02:03:31] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 02:03:31] [INFO] Timeout: 300 segundos
[2026-09-27 02:03:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eibmd3f0.prg
[2026-09-27 02:03:31] [INFO] Conteudo do wrapper:
[2026-09-27 02:03:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRCNB', 'C:\4c\tasks\task592\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRCNB', 'C:\4c\tasks\task592\logs\06_testForm.log'
QUIT

[2026-09-27 02:03:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eibmd3f0.prg
[2026-09-27 02:03:31] [INFO] VFP output esperado em: C:\4c\tasks\task592\vfp_output.txt
[2026-09-27 02:03:31] [INFO] Executando Visual FoxPro 9...
[2026-09-27 02:03:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eibmd3f0.prg
[2026-09-27 02:03:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eibmd3f0.prg
[2026-09-27 02:03:31] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRCNB
Inicio: 27/09/2026 02:03:32

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 27/09/2026 02:06:50
Duracao: 198 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-27 02:06:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-27 02:06:50] [INFO] VFP9 finalizado em 198.8822545 segundos
[2026-09-27 02:06:50] [INFO] Exit Code: 
[2026-09-27 02:06:50] [INFO] 
[2026-09-27 02:06:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-27 02:06:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eibmd3f0.prg
[2026-09-27 02:06:50] [INFO] 
[2026-09-27 02:06:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-27 02:06:50] [INFO] * Auto-generated wrapper for parameters
[2026-09-27 02:06:50] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 02:06:50] [INFO] * Parameters: 'FormSIGPRCNB', 'C:\4c\tasks\task592\logs\06_testForm.log'
[2026-09-27 02:06:50] [INFO] 
[2026-09-27 02:06:50] [INFO] * Anti-dialog protections for unattended execution
[2026-09-27 02:06:50] [INFO] SET SAFETY OFF
[2026-09-27 02:06:50] [INFO] SET RESOURCE OFF
[2026-09-27 02:06:50] [INFO] SET TALK OFF
[2026-09-27 02:06:50] [INFO] SET NOTIFY OFF
[2026-09-27 02:06:50] [INFO] SYS(2335, 0)
[2026-09-27 02:06:50] [INFO] 
[2026-09-27 02:06:50] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRCNB', 'C:\4c\tasks\task592\logs\06_testForm.log'
[2026-09-27 02:06:50] [INFO] QUIT
[2026-09-27 02:06:50] [INFO] 
[2026-09-27 02:06:50] [INFO] === Fim do Wrapper.prg ===
[2026-09-27 02:06:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg):
*==============================================================================
* FormSIGPRCNB.prg - Form Operacional: Geracao de Arquivos CNAB - Recebimentos
* Migrado de SIGPRCNB.SCX
* Herda de FormBase
* Tabela principal: SigPcOol (log de processamento CNAB)
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigPcOol, SigCdOpe, SigCdCli, SigCdEmp, SigCdCeb, etc.)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCNBBO)
*
* Form OPERACIONAL: NAO segue padrao Page1=Lista/Page2=Dados de cadastro CRUD.
* Page1 = Filtro (criterios de selecao + grade de operacoes a processar)
* Page2 = Dados  (grade dos titulos processados + acoes de geracao de CNAB/boleto)
*
* FASE 4/8: Grid de operacoes (grdope) + botoes reais da Page1 (Processar/
* Encerrar/Marcar Tudo/Desmarcar Tudo) e AlternarPagina(). Campos de filtro
* (Empresa/Periodo/Conta/Titulo Banco) ficam para as Fases 5-6; BINDEVENTs e
* logica de negocio (validacoes do Processar, geracao do CNAB) para as
* Fases 7-8.
*
* FASE 5/8: Page2 (Dados) - faixa do cabecalho (regra #11, nas duas
* paginas) + primeiro grupo de campos "principais" de pgdados (Say12/
* spndias/Say1 - "Protestar apos <N> dias", ja com property no BO
* this_nDiasProtesto). O aviso de endereco longo (Say2/Botao1), a grade de
* titulos (grdope 8 colunas) e os botoes de acao de Page2 (cmdTestaPos/
* Commandgroup1/Commandgroup2) ficam para a Fase 6.
*
* FASE 6/8: Campos restantes da Page1 (Empresa/Periodo/Banco-Conta/Titulo
* Banco) + lookups completos via FormBuscaAuxiliar (fAcessoEmpresa/
* fAcessoContas nao portadas). BINDEVENTs registrados em
* ConfigurarBindEventsFiltro(). Wiring dos botoes Processar/Marcar/
* Desmarcar/Encerrar e geracao do CNAB ficou para as Fases 7-8.
*
* FASE 7/8: Eventos principais dos botoes ja construidos - Processar
* (THIS.ProcessarTitulos(), transcrito de PROCEDURE processamento do
* legado), Encerrar, Marcar/Desmarcar Tudo (Page1), e o "round-trip" da
* Page2: grade de titulos (grd_4c_Titulos, 8 colunas + DynamicForeColor
* para EndErro), Marcar/Desmarcar Tudo dos titulos, checkbox individual
* (guard EndErro=1, equivalente ao Column1.Check1.When do legado) e Voltar
* (cmd_4c_Encerrar de Page2, que reaproveita o Caption/Picture "Encerrar"
* do legado mas volta para o filtro, nao fecha o form). O aviso de
* endereco longo (Say2/Botao1) foi reposicionado para LOGO ABAIXO do grupo
* "Protestar apos" (regra #11/#39 - a faixa do cabecalho ocupa o lugar que
* ele tinha no legado).
*
* FASE 8/8: obj_4c_Comandos (Commandgroup1 no legado - Gerar CNAB/
* Relatorio/Boleto) adicionado em cnt_4c_BotoesAcao da Page2, com os 3
* Click handlers (BtnGerarCnabClick/BtnRelatorioCnabClick/BtnBoletoClick)
* e ExecutarReportForm (Pattern #117). A geracao do arquivo CNAB (dispatch
* por banco do convenio - Brasil/Itau/Bradesco/Santander240 - layouts
* Brasil6/Itau240/Santander eram DEAD CODE no legado, nunca chamados por
* nenhum botao nem pelo dispatcher, e por isso nao foram portados) e o
* calculo do boleto (nosso numero/codigo de barras/linha digitavel, Mod10/
* Mod11 padrao FEBRABAN - fCalcMod10/fCalcMod11BB/fCalcMod11B7/fGerBar2de5
* em utils/functions.prg, fontes legados ausentes do acervo, regra
* CLAUDE.md #27) ficam no SIGPRCNBBO (GerarArquivoCnab/GerarCnabBrasil/
* GerarCnabItau/GerarCnabBradesco/GerarCnabSantander240/ImprimirBoleto).
* Os relatorios de preview (SigReCnb/SigReBlqBB/SigReBlqSt/SigReBlqBra)
* NAO tem FRX no acervo (sigrecnb/BloquetoBB2/BloquetoSt/BloquetoBra do
* legado nunca foram extraidos) - ExecutarReportForm mostra o aviso
* padrao "arquivo de relatorio nao encontrado" em vez de preview vazio;
* toda a preparacao de dados (cursor_4c_Titulos/cursor_4c_Boletos, calculo
* de barra/DV) fica pronta para quando o FRX for portado.
*==============================================================================

DEFINE CLASS FormSIGPRCNB AS FormBase

    *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

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
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCNBBO")

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                            "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()
                    THIS.ConfigurarBindEventsFiltro()
                    THIS.ConfigurarBindEventsPrincipais()
                    THIS.CarregarOperacoes()
                    THIS.TornarControlesVisiveis()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas (Filtro/Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Filtro"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Dados"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Filtro)
    * Fase 4/8: faixa do cabecalho + botoes reais (Processar/Encerrar/Marcar
    * Tudo/Desmarcar Tudo) + grade de selecao de operacoes (grdope no
    * legado). Campos de filtro (empresa, periodo, banco/conta, titulo
    * banco) vem nas Fases 5-6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab, loc_oGrid

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
        *-- containers de botao ficam em Top=29..33 (dentro da faixa) e tem
        *-- de ser criados DEPOIS para desenhar por cima.
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0,0,0)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255,255,255)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH
        ENDWITH

        *-- Container de botoes (Processar/Encerrar - cmdTestaPos no legado)
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 27
            .Left        =  542
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0

            *-- cmd_4c_Processar (Command1/btnProcessar no legado)
            .AddObject("cmd_4c_Processar", "CommandButton")
            WITH .cmd_4c_Processar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "Processar"
                .ToolTipText     = "Processar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
            ENDWITH

            *-- cmd_4c_Encerrar (Command2/btnsair no legado)
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ToolTipText     = "[ESC] Encerrar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Container Marcar/Desmarcar Tudo (Commandgroup2/btnmarca+btndesmarca no legado)
        loc_oPag.AddObject("cnt_4c_Marca", "Container")
        WITH loc_oPag.cnt_4c_Marca
            .Top         = 344
            .Left        = 563
            .Width       = 50
            .Height      = 91
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("cmd_4c_MarcarTudo", "CommandButton")
            WITH .cmd_4c_MarcarTudo
                .Top           = 5
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 7
                .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Marcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
            WITH .cmd_4c_DesmarcarTudo
                .Top           = 46
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Grupo "Operacoes :" (Label1) + filtro Processados/Ja Processadas
        *-- (optProcessados no legado, Top=95 -> 124 com compensacao +29).
        loc_oPag.AddObject("lbl_4c_Operacoes", "Label")
        WITH loc_oPag.lbl_4c_Operacoes
            .Top       = 125
            .Left      = 279
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es :"
        ENDWITH

        loc_oPag.AddObject("obj_4c_Processados", "OptionGroup")
        WITH loc_oPag.obj_4c_Processados
            .Top         = 124
            .Left        = 344
            .Width       = 235
            .Height      = 19
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 1

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .ForeColor = RGB(90,90,90)
                .Left      = 5
                .Top       = 2
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .ForeColor = RGB(90,90,90)
                .Left      = 126
                .Top       = 2
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Empresa (Say4 + get_cd_empresa + get_ds_empresa no legado)
        loc_oPag.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag.lbl_4c_Empresa
            .Top       = 152
            .Left      = 297
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Empresa :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_CodEmpresa
            .Top           = 149
            .Left          = 349
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        loc_oPag.AddObject("txt_4c_NomeEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_NomeEmpresa
            .Top           = 149
            .Left          = 383
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Periodo (Say3 + Get_Datai + Say6 "ate" + Get_Dataf + optPeriodo)
        loc_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPag.lbl_4c_Periodo
            .Top       = 180
            .Left      = 302
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Per" + CHR(237) + "odo :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPag.txt_4c_DataInicial
            .Top           = 177
            .Left          = 349
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .Value         = {}
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPag.lbl_4c_Ate
            .Top       = 180
            .Left      = 434
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPag.txt_4c_DataFinal
            .Top           = 177
            .Left          = 457
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .Value         = {}
        ENDWITH

        loc_oPag.AddObject("obj_4c_Periodo", "OptionGroup")
        WITH loc_oPag.obj_4c_Periodo
            .Top         = 175
            .Left        = 544
            .Width       = 168
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 1

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Vencimento"
                .ForeColor = RGB(90,90,90)
                .Left      = 5
                .Top       = 5
                .Width     = 73
                .Height    = 15
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o"
                .ForeColor = RGB(90,90,90)
                .Left      = 96
                .Top       = 5
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Banco/Conta (Say2 + get_cd_car_conta + get_ds_car_conta)
        loc_oPag.AddObject("lbl_4c_Banco", "Label")
        WITH loc_oPag.lbl_4c_Banco
            .Top       = 209
            .Left      = 309
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Banco :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodConta", "TextBox")
        WITH loc_oPag.txt_4c_CodConta
            .Top           = 205
            .Left          = 349
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        loc_oPag.AddObject("txt_4c_NomeConta", "TextBox")
        WITH loc_oPag.txt_4c_NomeConta
            .Top           = 205
            .Left          = 430
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Titulo Banco (Say12 + Get_titban -> lookup em SigOpFp.Fpags)
        loc_oPag.AddObject("lbl_4c_TituloBanco", "Label")
        WITH loc_oPag.lbl_4c_TituloBanco
            .Top       = 235
            .Left      = 280
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "T" + CHR(237) + "tulo Banco : "
        ENDWITH

        loc_oPag.AddObject("txt_4c_TituloBanco", "TextBox")
        WITH loc_oPag.txt_4c_TituloBanco
            .Top           = 232
            .Left          = 348
            .Width         = 94
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 12
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Label "Operacao :" (Say1), ao lado esquerdo da grade
        loc_oPag.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPag.lbl_4c_Operacao
            .Top       = 263
            .Left      = 291
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        *-- Cursor placeholder da grade de operacoes (regra #41: o ControlSource
        *-- das colunas nao pode apontar para cursor que ainda nao existe).
        *-- Estrutura identica a THIS.CarregarOperacoes(), que substitui o
        *-- conteudo pelo resultado real do SQLEXEC.
        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Operacoes (Dopes C(20) NULL, Marca L NULL)
        SET NULL OFF

        *-- Grade de selecao de operacoes (grdope no legado, Pagina Filtro)
        loc_oPag.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrid = loc_oPag.grd_4c_Operacoes

        *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
        *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
        *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
        *-- 'Unknown member COLUMN1'.
        loc_oGrid.ColumnCount  = 2
        loc_oGrid.RecordSource = "cursor_4c_Operacoes"

        WITH loc_oGrid
            .Top               = 261
            .Left              = 350
            .Width             = 202
            .Height            = 344
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 3
            .GridLineColor     = RGB(238,238,238)
            .ScrollBars        = 2
            .Themes            = .F.

            *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
            *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
            *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
            *-- controle novo com um campo Character e estoura "Data type
            *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
            *-- ControlSource definitivo).
            .Column1.ControlSource = ""
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            .Column1.CurrentControl = "chk_4c_Marca"
            WITH .Column1.chk_4c_Marca
                .Caption   = ""
                .BackColor = RGB(255,255,255)
            ENDWITH

            .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
            .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"

            *-- Largura/legenda reaplicadas DEPOIS do RecordSource/ControlSource
            *-- (ambos resetam Column.Width e Header1.Caption - Problema 48)
            .Column1.Width          = 18
            .Column1.Movable        = .F.
            .Column1.Resizable      = .F.
            .Column1.Sparse         = .F.
            .Column1.ReadOnly       = .F.
            .Column1.Header1.Caption = ""

            .Column2.Width          = 150
            .Column2.Movable        = .F.
            .Column2.Resizable      = .F.
            .Column2.ReadOnly       = .T.
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)
    * Fase 5/8: faixa do cabecalho (regra #11 - nas DUAS paginas, PRIMEIRO
    * AddObject da pagina) + primeiros 50% dos campos "principais" de
    * pgdados (Say12/spndias/Say1 - "Protestar apos <N> dias", que ja tem
    * property no BO: this_nDiasProtesto). O aviso de endereco longo
    * (Say2/Botao1), a grade de titulos (grdope, 8 colunas) e os botoes de
    * acao (cmdTestaPos/Commandgroup1/Commandgroup2) ficam para a Fase 6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab, loc_oGridTit

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
        *-- containers de botao (cnt_4c_BotoesAcao, Top=27..112) ficam DENTRO
        *-- da area da faixa (Top=29..109) e tem de ser criados DEPOIS para
        *-- desenhar por cima (excecao da regra: barra de acao do topo com
        *-- Top 20..55 e Height 60..100 fica POR CIMA, sem ser deslocada).
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0,0,0)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255,255,255)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH
        ENDWITH

        *-- Container de botoes de acao (Encerrar / Gerar CNAB / Relatorio / Boleto)
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 27
            .Left        = 692
            .Width       = 310
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0

            *-- cmd_4c_Encerrar (btnsair/cmdTestaPos no legado) - Caption e
            *-- Picture IDENTICOS ao Encerrar da Pagina Lista (mesmo icone
            *-- "sair"), mas a acao real eh VOLTAR para o filtro
            *-- (thisform.pgfprincipal.ActivePage=1) - o legado usa essa
            *-- legenda mesmo a acao nao fechando o form; PILAR 1 manda
            *-- preservar, nao "corrigir" para "Voltar".
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ToolTipText     = "[ESC] Encerrar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
            ENDWITH

            *-- obj_4c_Comandos (Commandgroup1 no legado: Gerar CNAB/Relatorio/
            *-- Boleto). Fica a esquerda do Encerrar (Left relativo 0..225),
            *-- igual ao legado (Commandgroup1.Left=692 < cmdTestaPos.Left=917).
            .AddObject("obj_4c_Comandos", "CommandGroup")
            WITH .obj_4c_Comandos
                .Top          = 5
                .Left         = 0
                .Width        = 225
                .Height       = 75
                .BackStyle    = 0
                .ButtonCount  = 3

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                    .Caption         = "Gerar CNAB"
                    .ToolTipText     = "Gerar CNAB"
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_video_60.jpg"
                    .Caption         = "Relat" + CHR(243) + "rio"
                    .ToolTipText     = "Relat" + CHR(243) + "rio"
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 155
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                    .Caption         = "Boleto"
                    .ToolTipText     = "Boleto"
                    .Enabled         = .F.
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        *-- "Protestar apos <N> dias" (Say12 + spndias + Say1 no legado,
        *-- Top=98..103 original - reposicionado para Top=120, abaixo da
        *-- faixa de cabecalho recem-adicionada, regra #11 re-layout).
        *-- this_nDiasProtesto (BO) ja existe com default 5, igual ao
        *-- spndias.Value implicito do legado.
        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .Top       = 124
            .Left      = 370
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Protestar ap" + CHR(243) + "s :"
        ENDWITH

        loc_oPag.AddObject("spn_4c_DiasProtesto", "Spinner")
        WITH loc_oPag.spn_4c_DiasProtesto
            .Top          = 120
            .Left         = 451
            .Width        = 45
            .Height       = 24
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpinnerLowValue  = 0
            .SpinnerHighValue = 999
            .Increment    = 1
            .Value        = 5
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 124
            .Left      = 501
            .Width     = 21
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "dias"
        ENDWITH

        *-- Aviso de endereco longo (Say2/Botao1 no legado, raw Top=14/15 -
        *-- ficava ACIMA do grupo "Protestar apos" no SCX original). Com a
        *-- faixa do cabecalho ocupando Top 29..109 (regra #11), o aviso foi
        *-- reposicionado para LOGO ABAIXO do grupo de dias (que fecha em
        *-- Top=139), preservando os dois controles sem sobrepor nada -
        *-- re-layout de pagina cheia (regra #11/#39), nao invencao de novo
        *-- elemento.
        loc_oPag.AddObject("lbl_4c_AvisoEndereco", "Label")
        WITH loc_oPag.lbl_4c_AvisoEndereco
            .Top       = 154
            .Left      = 390
            .Width     = 238
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255,0,0)
            .Caption   = "Endere" + CHR(231) + "os com tamanho maior que 40 caracteres"
        ENDWITH

        *-- Botao1 no legado eh so uma caixinha vermelha decorativa (When
        *-- sempre .F. - nunca recebe foco/clique), legenda de cor ao lado
        *-- do aviso acima.
        loc_oPag.AddObject("txt_4c_AvisoCor", "TextBox")
        WITH loc_oPag.txt_4c_AvisoCor
            .Top           = 153
            .Left          = 370
            .Width         = 17
            .Height        = 16
            .SpecialEffect = 1
            .BackColor     = RGB(255,0,0)
            .BorderColor   = RGB(255,0,0)
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- Cursor placeholder da grade de titulos (regra #41 - ControlSource
        *-- nao pode apontar para cursor que ainda nao existe). Estrutura
        *-- identica ao resultado do SQLEXEC de THIS.ProcessarTitulos()
        *-- (mesmos nomes/tipos do "crFiltro" do legado).
        IF USED("cursor_4c_Titulos")
            USE IN cursor_4c_Titulos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Titulos (Marca L NULL, Titulos C(10) NULL, Dopes C(20) NULL, ;
            Numes N(6,0) NULL, RClis C(50) NULL, Vencs T NULL, Fpags C(12) NULL, Valos N(11,2) NULL, ;
            Datas T NULL, Vpags N(11,2) NULL, IClis C(10) NULL, Endes C(60) NULL, Cidas C(30) NULL, ;
            Estas C(2) NULL, Nums C(10) NULL, Compls C(50) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
            Cpfs C(20) NULL, Emps C(3) NULL, EmpDopNums C(29) NULL, Nopers N(7,0) NULL, Razaos C(50) NULL, ;
            EndCobs C(80) NULL, CepCobs C(9) NULL, EstCobs C(2) NULL, BaiCobs C(20) NULL, CidCobs C(20) NULL, ;
            EndErro N(1,0) NULL)
        SET NULL OFF

        *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
        *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
        *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
        *-- estrutura do legado, nao a ordem de criacao das colunas).
        loc_oPag.AddObject("grd_4c_Titulos", "Grid")
        loc_oGridTit = loc_oPag.grd_4c_Titulos

        *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
        *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
        *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
        *-- 'Unknown member COLUMN1'.
        loc_oGridTit.ColumnCount  = 8
        loc_oGridTit.RecordSource = "cursor_4c_Titulos"

        WITH loc_oGridTit
            .Top               = 180
            .Left              = 7
            .Width             = 981
            .Height            = 382
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLineColor     = RGB(238,238,238)
            .ScrollBars        = 2
            .Themes            = .F.

            *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
            *-- adicionar o CheckBox (regra #18).
            .Column1.ControlSource = ""
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            .Column1.CurrentControl = "chk_4c_Marca"
            WITH .Column1.chk_4c_Marca
                .Caption   = ""
                .BackColor = RGB(255,255,255)
            ENDWITH

            .Column1.ControlSource = "cursor_4c_Titulos.Marca"
            .Column2.ControlSource = "cursor_4c_Titulos.Dopes"
            .Column3.ControlSource = "cursor_4c_Titulos.Numes"
            .Column4.ControlSource = "cursor_4c_Titulos.RClis"
            .Column5.ControlSource = "cursor_4c_Titulos.Vencs"
            .Column6.ControlSource = "cursor_4c_Titulos.Fpags"
            .Column7.ControlSource = "cursor_4c_Titulos.Valos"
            .Column8.ControlSource = "cursor_4c_Titulos.Titulos"

            .Column1.Width           = 16
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.Sparse         = .F.
            .Column1.ReadOnly        = .F.
            .Column1.Header1.Caption = ""
        ENDWITH

        *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
        *-- ControlSource (Problema 48 - ambos resetam Column.Width e
        *-- Header1.Caption).
        THIS.FormatarGridTitulos(loc_oGridTit)

        *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
        *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
        *-- Pagina Filtro.
        loc_oPag.AddObject("cnt_4c_Marca", "Container")
        WITH loc_oPag.cnt_4c_Marca
            .Top         = 570
            .Left        = 7
            .Width       = 92
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("cmd_4c_MarcarTudo", "CommandButton")
            WITH .cmd_4c_MarcarTudo
                .Top           = 5
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 7
                .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Marcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
            WITH .cmd_4c_DesmarcarTudo
                .Top           = 5
                .Left          = 45
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarGridTitulos - Reaplica largura/legenda/ordem/cor dinamica das
    * colunas da grade de titulos. Chamado apos QUALQUER atribuicao de
    * RecordSource/ControlSource (Problema 48 - ambos resetam Column.Width e
    * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
    * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
        WITH par_oGrid
            .Column1.Width           = 16
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.Sparse          = .F.
            .Column1.ReadOnly        = .F.
            .Column1.ColumnOrder     = 1
            .Column1.Header1.Caption = ""

            .Column2.Width             = 150
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.ColumnOrder       = 3
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"

            .Column3.Width             = 52
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.ColumnOrder       = 4
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "C" + CHR(243) + "digo"

            .Column4.Width             = 400
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.ColumnOrder       = 5
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Cliente"

            .Column5.Width             = 72
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.ColumnOrder       = 6
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Vencimento"

            .Column6.Width             = 87
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.ColumnOrder       = 7
            .Column6.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Forma Pagto"

            .Column7.Width             = 100
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.ColumnOrder       = 8
            .Column7.Header1.Alignment = 2
            .Column7.Header1.Caption   = "Valor"

            .Column8.Movable           = .F.
            .Column8.Resizable         = .F.
            .Column8.ReadOnly          = .T.
            .Column8.ColumnOrder       = 2
            .Column8.Header1.Alignment = 2
            .Column8.Header1.Caption   = "T" + CHR(237) + "tulo"

            .SetAll("DynamicForeColor", "IIF(cursor_4c_Titulos.EndErro = 1, RGB(255,0,0), RGB(0,0,0))", "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
    * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
    * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
    * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
    * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
    * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
    *==========================================================================
    PROTECTED PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
                       "FROM SigCdOpe" + CHR(13) + ;
                       "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
                       "ORDER BY Dopes"

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF

                SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE

                IF USED("cursor_4c_OperacoesTmp")
                    USE IN cursor_4c_OperacoesTmp
                ENDIF

                IF RECCOUNT("cursor_4c_Operacoes") > 0
                    SELECT cursor_4c_Operacoes
                    GO TOP
                ENDIF

                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"

                *-- RecordSource reatribuido faz o Grid auto-bindar as colunas
                *-- pela ordem dos campos do cursor, ignorando o ControlSource
                *-- anterior - redefinir explicitamente (regra GRID-RECORDSOURCE-AUTOBIND).
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column1.ControlSource = "cursor_4c_Operacoes.Marca"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"

                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsFiltro - Registra os BINDEVENTs dos campos de filtro
    * da Page1 (Empresa/Periodo/Banco-Conta/Titulo Banco). Handlers PUBLIC
    * (regra #3 - BINDEVENT falha silenciosamente em metodo PROTECTED).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsFiltro()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Empresa
        BINDEVENT(loc_oPag.txt_4c_CodEmpresa,  "KeyPress", THIS, "ValidarCodEmpresa")
        BINDEVENT(loc_oPag.txt_4c_NomeEmpresa, "KeyPress", THIS, "ValidarNomEmpresa")

        *-- Periodo (validacao de intervalo de datas)
        BINDEVENT(loc_oPag.txt_4c_DataFinal,   "KeyPress", THIS, "ValidarDataFinal")

        *-- Banco/Conta
        BINDEVENT(loc_oPag.txt_4c_CodConta,    "KeyPress", THIS, "ValidarCodConta")
        BINDEVENT(loc_oPag.txt_4c_NomeConta,   "KeyPress", THIS, "ValidarNomConta")

        *-- Titulo Banco (SigOpFp.Fpags)
        BINDEVENT(loc_oPag.txt_4c_TituloBanco, "KeyPress", THIS, "ValidarTituloBanco")
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsPrincipais - Registra os BINDEVENTs dos botoes
    * principais (Processar/Encerrar/Marcar/Desmarcar da Pagina Filtro e
    * Voltar/Marcar/Desmarcar da Pagina Dados). Handlers PUBLIC (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsPrincipais()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Processar,    "Click", THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Encerrar,     "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_MarcarTudo,    "Click", THIS, "BtnMarcarTudoClick")
        BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_DesmarcarTudo, "Click", THIS, "BtnDesmarcarTudoClick")

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
        BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
        BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
        BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")

        *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3), "Click", THIS, "BtnBoletoClick")
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - cmdTestaPos.btnProcessar.Click no legado. Valida
    * Empresa/Periodo/Conta obrigatorios e exige ao menos 1 operacao marcada
    * antes de consultar os titulos em aberto.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPag, loc_nCont

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
            MsgAviso("Empresa inv" + CHR(225) + "lida", "Aviso")
            loc_oPag.txt_4c_CodEmpresa.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_oPag.txt_4c_DataInicial.Value) OR EMPTY(loc_oPag.txt_4c_DataFinal.Value)
            MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido", "Aviso")
            loc_oPag.txt_4c_DataInicial.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
            MsgAviso("Banco inv" + CHR(225) + "lido", "Aviso")
            loc_oPag.txt_4c_CodConta.SetFocus()
            RETURN
        ENDIF

        loc_nCont = 0
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            COUNT FOR Marca TO loc_nCont
        ENDIF
        IF loc_nCont = 0
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
            RETURN
        ENDIF

        THIS.ProcessarTitulos()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnMarcarTudoClick/BtnDesmarcarTudoClick - Commandgroup2.btnmarca/
    * btndesmarca.Click (Pagina Filtro) no legado - marca/desmarca TODAS as
    * operacoes do grid de filtro, sem excecao (igual ao legado).
    *==========================================================================
    PROCEDURE BtnMarcarTudoClick()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL Marca WITH .T.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
    ENDPROC

    PROCEDURE BtnDesmarcarTudoClick()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL Marca WITH .F.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
    ENDPROC

    *==========================================================================
    * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
    * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
    * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
    * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
    * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
    * ausencia de filtro pela conta/carteira na consulta (o legado le
    * get_cd_car_conta so para validar preenchimento, e aplica a conta
    * apenas na geracao do CNAB, fase 8).
    *==========================================================================
    PROTECTED PROCEDURE ProcessarTitulos()
        LOCAL loc_oPag, loc_cListaOperacoes, loc_cEmpresa, loc_dIni, loc_dFim, loc_nPeriodo, ;
              loc_lNaoProcessados, loc_cCampoData, loc_cNotIn, loc_cSQL, loc_nResultado, ;
              loc_lSucesso, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        loc_oPag             = THIS.pgf_4c_Paginas.Page1
        loc_cEmpresa         = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
        loc_dIni             = loc_oPag.txt_4c_DataInicial.Value
        loc_dFim             = loc_oPag.txt_4c_DataFinal.Value
        loc_nPeriodo         = loc_oPag.obj_4c_Periodo.Value          && 1=Vencimento, 2=Emissao
        loc_lNaoProcessados  = (loc_oPag.obj_4c_Processados.Value = 1) && 1=Nao Processadas, 2=Ja Processadas

        *-- Lista das operacoes marcadas - IN-list de coluna CHAR unica
        *-- (compara com blank-padding ANSI no SQL Server); NAO eh a chave
        *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
        loc_cListaOperacoes = "("
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            SCAN FOR Marca
                loc_cListaOperacoes = loc_cListaOperacoes + ;
                    IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
            ENDSCAN
        ENDIF
        loc_cListaOperacoes = loc_cListaOperacoes + ")"

        loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
        loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")

        TRY
            loc_cSQL = ;
                "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
                "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
                "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
                "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
                "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
                "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
                "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
                "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
                "            ELSE 0 END AS EndErro" + CHR(13) + ;
                "FROM SigMvPar a" + CHR(13) + ;
                "INNER JOIN SigOpFp b ON a.fpags = b.fpags" + CHR(13) + ;
                "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums" + CHR(13) + ;
                "LEFT JOIN SigCdCli d ON c.contads = d.iclis" + CHR(13) + ;
                "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers" + CHR(13) + ;
                "WHERE b.infos = 'B' AND a.vpags = 0" + CHR(13) + ;
                "  AND " + loc_cCampoData + " BETWEEN " + FormatarDataSQL(loc_dIni) + " AND " + FormatarDataSQL(loc_dFim) + CHR(13) + ;
                "  AND e.opers = 'C'" + CHR(13) + ;
                "  AND c.emps = " + EscaparSQL(loc_cEmpresa) + CHR(13) + ;
                "  AND a.dopes IN " + loc_cListaOperacoes + CHR(13) + ;
                "  AND a.empdopnums + e.titulos " + loc_cNotIn + "IN (" + CHR(13) + ;
                "      SELECT f.empdopnums + SUBSTRING(f.dopeds, 1, 10)" + CHR(13) + ;
                "      FROM SigPcOoL f" + CHR(13) + ;
                "      WHERE f.tipos = 'SIGPRCNB')" + CHR(13) + ;
                "ORDER BY a.dopes, a.numes, a.parcs"

            IF USED("cursor_4c_TitulosTmp")
                USE IN cursor_4c_TitulosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitulosTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Titulos")
                    USE IN cursor_4c_Titulos
                ENDIF

                SELECT * FROM cursor_4c_TitulosTmp INTO CURSOR cursor_4c_Titulos READWRITE

                IF USED("cursor_4c_TitulosTmp")
                    USE IN cursor_4c_TitulosTmp
                ENDIF

                IF RECCOUNT("cursor_4c_Titulos") = 0
                    MsgAviso("Nenhum dado foi encontrado", "Aviso")
                ELSE
                    SELECT cursor_4c_Titulos
                    REPLACE ALL Marca WITH .F. FOR EndErro = 1
                    GO TOP

                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
                    loc_oGrid.ColumnCount = 8
                    loc_oGrid.RecordSource         = "cursor_4c_Titulos"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
                    THIS.FormatarGridTitulos(loc_oGrid)
                    loc_oGrid.Refresh()

                    THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                    THIS.pgf_4c_Paginas.Page2.Enabled = .T.

                    *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
                    *-- 1468): Boleto so comeca habilitado quando o filtro eh
                    *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
                    *-- Santander240 forcam .T. depois de gerar com sucesso.
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
                        (loc_oPag.obj_4c_Processados.Value = 2)

                    THIS.AlternarPagina(2)
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Erro ao processar os t" + CHR(237) + "tulos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro ProcessarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnVoltarClick - cmdTestaPos.btnsair.Click (Pagina Dados) no legado:
    * limpa o RecordSource do grid, reabilita o filtro e volta para a Lista.
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
        loc_oGrid.RecordSource = ""
        loc_oGrid.Refresh()

        THIS.pgf_4c_Paginas.Page1.Enabled = .T.
        THIS.pgf_4c_Paginas.Page2.Enabled = .F.
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
    * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
    * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
    * "Marcar Tudo" bypassa o guard do checkbox individual).
    *==========================================================================
    PROCEDURE BtnMarcarTudoTitulosClick()
        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            REPLACE ALL Marca WITH .T.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
    ENDPROC

    PROCEDURE BtnDesmarcarTudoTitulosClick()
        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            REPLACE ALL Marca WITH .F.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
    ENDPROC

    *==========================================================================
    * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
    * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
    * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
    * revertemos quando a linha estiver marcada como EndErro=1.
    *==========================================================================
    PROCEDURE ChkTituloMarcaClick()
        IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
            IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca
                REPLACE cursor_4c_Titulos.Marca WITH .F.
                MsgAviso("Este t" + CHR(237) + "tulo tem endere" + CHR(231) + "o com mais de 40 caracteres e n" + CHR(227) + "o pode ser selecionado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarReportForm (Pattern #117) - executa REPORT FORM com guard
    * IF FILE() + isolamento de locale (SET POINT/SEPARATOR) + REPORTBEHAVIOR
    * 80 durante o REPORT FORM. par_cModo: "PREVIEW" | "PRINTER_PROMPT".
    * par_cCursorDados: opcional - se informado e cursor estiver vazio/
    * inexistente, mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O layout deste relat" + CHR(243) + "rio n" + CHR(227) + "o veio no acervo do sistema legado.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnGerarCnabClick - Commandgroup1.btncnab.Click no legado ("thisform.
    * geracnab([A])"). Gera o arquivo de remessa bancaria com os titulos
    * marcados. Quando o banco eh Brasil (001), o BO ja dispara a impressao
    * automatica do boleto (regra fiel ao legado - o BO chama sua propria
    * rotina ImprimirBoleto dentro de GerarCnabBrasil); aqui so falta exibir
    * o preview se o BO deixou um cursor pronto.
    *==========================================================================
    PROCEDURE BtnGerarCnabClick()
        LOCAL loc_oPag, loc_lSucesso

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoCnab( ;
            "cursor_4c_Titulos", ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_TituloBanco.Value))

        IF loc_lSucesso AND INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "001", "033", "353")
            loc_oPag.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = .T.
        ENDIF

        *-- GerarCnabBrasil (no BO) ja chamou sua propria rotina interna
        *-- ImprimirBoleto(.F.) - se deixou cursor pronto, exibe o preview
        *-- aqui (camada de UI).
        IF !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
            THIS.ExibirPreviewBoleto()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRelatorioCnabClick - Commandgroup1.btnrelatorio.Click no legado
    * ("thisform.geracnab([V])"): preview do relatorio com os titulos
    * marcados (Report Form sigrecnb no legado -> SigReCnb no novo sistema).
    *==========================================================================
    PROCEDURE BtnRelatorioCnabClick()
        LOCAL loc_nMarcados

        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            COUNT FOR Marca TO loc_nMarcados
        ELSE
            loc_nMarcados = 0
        ENDIF

        IF loc_nMarcados = 0
            MsgAviso("Nenhum registro foi selecionado", "Aviso")
            RETURN
        ENDIF

        THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
    ENDPROC

    *==========================================================================
    * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.
    * geracnab([I])" + "thisform.impboleto(.T.)"): reimpressao do boleto dos
    * titulos marcados, reaproveitando o Nosso Numero da ultima geracao
    * gravada em SigPcOol (par_lReimpressao = .T.).
    *==========================================================================
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.this_oBusinessObject.ImprimirBoleto( ;
            "cursor_4c_Titulos", .T., ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value))

        IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
            THIS.ExibirPreviewBoleto()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirPreviewBoleto - escolhe o layout de boleto pelo banco do
    * convenio (BloquetoBB2/BloquetoSt/BloquetoBra no legado -> SigReBlqBB/
    * SigReBlqSt/SigReBlqBra no novo sistema) e limpa as imagens de barra
    * temporarias apos a impressao (igual ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ExibirPreviewBoleto()
        LOCAL loc_cRelatorio, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBoleto

        DO CASE
            CASE THIS.this_oBusinessObject.this_cBancoConvenio == "001"
                loc_cRelatorio = "SigReBlqBB"
            CASE INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "033", "353")
                loc_cRelatorio = "SigReBlqSt"
            CASE THIS.this_oBusinessObject.this_cBancoConvenio == "237"
                loc_cRelatorio = "SigReBlqBra"
            OTHERWISE
                loc_cRelatorio = ""
        ENDCASE

        IF !EMPTY(loc_cRelatorio)
            THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW", loc_cCursor)
        ENDIF

        THIS.this_oBusinessObject.LimparImagensBarras(loc_cCursor)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.this_oBusinessObject.this_cCursorBoleto = ""
    ENDPROC

    *==========================================================================
    * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
    * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
    * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
    * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
    * em SigCdEmp).
    *==========================================================================
    PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)

        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_NomeEmpresa.Value = ""
            loc_oPag.txt_4c_NomeEmpresa.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpresaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
                SELECT cursor_4c_EmpresaVal
                loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
                loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpresaVal")
                USE IN cursor_4c_EmpresaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ValidarNomEmpresa - KeyPress em txt_4c_NomeEmpresa (get_ds_empresa no
    * legado). So age quando o codigo esta vazio (When: Empty(get_cd_empresa)).
    *==========================================================================
    PROCEDURE ValidarNomEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_CodEmpresa.Value = ""
            loc_oPag.txt_4c_CodEmpresa.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpresaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
                SELECT cursor_4c_EmpresaVal
                loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
                loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpresaVal")
                USE IN cursor_4c_EmpresaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp (substitui
    * fAcessoEmpresa modo lookup - funcao NAO portada, ver CLAUDE.md).
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpresa")
                    USE IN cursor_4c_BuscaEmpresa
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpresa")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                        SELECT cursor_4c_BuscaEmpresa
                        loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                        loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ValidarDataFinal - KeyPress em txt_4c_DataFinal (Get_Dataf.Valid no
    * legado): data final nao pode ser menor que a inicial.
    *==========================================================================
    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(loc_oPag.txt_4c_DataInicial.Value) ;
                AND !EMPTY(loc_oPag.txt_4c_DataFinal.Value) ;
                AND loc_oPag.txt_4c_DataFinal.Value < loc_oPag.txt_4c_DataInicial.Value
            MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_DataFinal.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
    * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
    * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
    * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
    *==========================================================================
    PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)

        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_NomeConta.Value = ""
            loc_oPag.txt_4c_NomeConta.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_ContaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
                SELECT cursor_4c_ContaVal
                loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
                loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
            ELSE
                MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
                loc_oPag.txt_4c_CodConta.Value  = ""
                loc_oPag.txt_4c_NomeConta.Value = ""
            ENDIF
            IF USED("cursor_4c_ContaVal")
                USE IN cursor_4c_ContaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * ValidarNomConta - KeyPress em txt_4c_NomeConta (get_ds_car_conta no
    * legado). So age quando o codigo esta vazio (When: IsEmpty(get_cd_car_conta)).
    *==========================================================================
    PROCEDURE ValidarNomConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_CodConta.Value = ""
            loc_oPag.txt_4c_CodConta.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_ContaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
                SELECT cursor_4c_ContaVal
                loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
                loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
            ELSE
                THIS.AbrirBuscaConta()
            ENDIF
            IF USED("cursor_4c_ContaVal")
                USE IN cursor_4c_ContaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - picker por IClis/RClis em SigCdCli (conta/carteira do
    * banco - substitui fAcessoContas, que NAO deve ser usada para lookup UX).
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Conta"

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY IClis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
                    "cursor_4c_BuscaConta")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
                MsgAviso("Nenhuma conta encontrada.", "Conta")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * ValidarTituloBanco - KeyPress em txt_4c_TituloBanco (Get_titban no
    * legado). Enter/Tab/F4 -> SEEK exato em SigOpFp.Fpags (mesmo filtro do
    * legado: Situas in ('R','A') And Infos = 'K'); miss abre o picker
    * (fwBuscaSel legado -> FormBuscaAuxiliar canonico, tabela single-column
    * como SigCdOpe - so existe o campo Fpags, sem descricao textual).
    *==========================================================================
    PROCEDURE ValidarTituloBanco(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaTituloBanco()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
                " AND Situas IN ('R','A') AND Infos = 'K'", ;
                "cursor_4c_TituloBancoVal")
            IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
                SELECT cursor_4c_TituloBancoVal
                loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
            ELSE
                THIS.AbrirBuscaTituloBanco()
            ENDIF
            IF USED("cursor_4c_TituloBancoVal")
                USE IN cursor_4c_TituloBancoVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_TituloBanco.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaTituloBanco - picker por Fpags em SigOpFp (Formas de
    * Pagamento), mesmo filtro do legado (Situas in ('R','A') And Infos='K').
    * Single-column, igual SigCdOpe (regra CLAUDE.md) - o legado so exibe o
    * codigo (AddColuna('FPags', ...)), sem coluna de descricao.
    *==========================================================================
    PROCEDURE AbrirBuscaTituloBanco()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
        loc_cTitulo = "Formas de Pagamento"

        IF USED("cursor_4c_BuscaTituloBanco")
            USE IN cursor_4c_BuscaTituloBanco
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
            ELSE
                loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
                           "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
                           "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Fpags"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaTituloBanco")
                    USE IN cursor_4c_BuscaTituloBanco
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
                    "cursor_4c_BuscaTituloBanco")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
                MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
                        SELECT cursor_4c_BuscaTituloBanco
                        loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaTituloBanco")
            USE IN cursor_4c_BuscaTituloBanco
        ENDIF
        loc_oPag.txt_4c_TituloBanco.Refresh
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre a pagina de Filtro (1) e a de Dados (2).
    * Usado pelo fluxo Processar->Dados e pelo retorno Dados->Filtro (regra de
    * negocio de quando alternar fica para as Fases 7-8).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles ja criados
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oP1, loc_oP2

        THIS.pgf_4c_Paginas.Visible = .T.

        loc_oP1 = THIS.pgf_4c_Paginas.Page1
        loc_oP1.cnt_4c_Cabecalho.Visible                       = .T.
        loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
        loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
        loc_oP1.cnt_4c_Botoes.Visible                          = .T.
        loc_oP1.cnt_4c_Botoes.cmd_4c_Processar.Visible         = .T.
        loc_oP1.cnt_4c_Botoes.cmd_4c_Encerrar.Visible          = .T.
        loc_oP1.cnt_4c_Marca.Visible                           = .T.
        loc_oP1.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
        loc_oP1.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
        loc_oP1.lbl_4c_Operacoes.Visible                       = .T.
        loc_oP1.obj_4c_Processados.Visible                     = .T.
        loc_oP1.lbl_4c_Empresa.Visible                         = .T.
        loc_oP1.txt_4c_CodEmpresa.Visible                      = .T.
        loc_oP1.txt_4c_NomeEmpresa.Visible                     = .T.
        loc_oP1.lbl_4c_Periodo.Visible                         = .T.
        loc_oP1.txt_4c_DataInicial.Visible                     = .T.
        loc_oP1.lbl_4c_Ate.Visible                             = .T.
        loc_oP1.txt_4c_DataFinal.Visible                       = .T.
        loc_oP1.obj_4c_Periodo.Visible                         = .T.
        loc_oP1.lbl_4c_Banco.Visible                           = .T.
        loc_oP1.txt_4c_CodConta.Visible                        = .T.
        loc_oP1.txt_4c_NomeConta.Visible                       = .T.
        loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
        loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
        loc_oP1.lbl_4c_Operacao.Visible                        = .T.
        loc_oP1.grd_4c_Operacoes.Visible                       = .T.

        loc_oP2 = THIS.pgf_4c_Paginas.Page2
        loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
        loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
        loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
        loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
        loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
        loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
        loc_oP2.lbl_4c_Label12.Visible                         = .T.
        loc_oP2.spn_4c_DiasProtesto.Visible                    = .T.
        loc_oP2.lbl_4c_Label1.Visible                          = .T.
        loc_oP2.lbl_4c_AvisoEndereco.Visible                   = .T.
        loc_oP2.txt_4c_AvisoCor.Visible                        = .T.
        loc_oP2.grd_4c_Titulos.Visible                         = .T.
        loc_oP2.cnt_4c_Marca.Visible                           = .T.
        loc_oP2.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
        loc_oP2.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
    ENDPROC

    *==========================================================================
    * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCNBBO.prg):
*============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB (remessa
* bancaria) e emissao de boletos/relatorio dos titulos selecionados
*
* Origem legado: SIGPRCNB.SCX ("Geracao de Arquivos CNAB")
* Form OPERACIONAL: pagina de Filtros (empresa, periodo, conta/carteira,
* titulo do banco, operacoes a processar) + pagina de Dados (grade de
* titulos em aberto, com selecao individual e geracao do arquivo CNAB nos
* layouts Bradesco/Itau/Itau240/Brasil/Brasil6/Santander/Santander240).
*
* Tabela de controle: SigPcOol - a cada arquivo CNAB gerado o legado grava
* um registro de controle (Tipos = 'SIGPRCNB', Processos = 'CNAB') usado
* para NAO reprocessar o mesmo titulo numa proxima geracao (subquery
* "EmpDopNums + titulos NOT IN (Select ... From SigPcOol ...)" em
* PROCEDURE processamento). Nao ha tela de cadastro para SigPcOol - o
* "CRUD" deste BO eh o proprio processo de geracao do arquivo.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro - espelham os campos da pagina Filtros
    * (Thisform.pgfprincipal.pgfiltro no legado)
    *==========================================================================
    this_cCodEmpresa        = ""   && get_cd_empresa - SigCdEmp.Cemps char(3)
    this_cNomeEmpresa       = ""   && get_ds_empresa  - SigCdEmp.RazSocs (somente exibicao)
    this_dDataInicial       = {}   && Get_Datai - inicio do periodo (vencimento ou emissao)
    this_dDataFinal         = {}   && Get_Dataf - fim do periodo
    this_cContaCarteira     = ""   && get_cd_car_conta - SigCdCli.IClis (conta/carteira do banco)
    this_cContaCarteiraDesc = ""   && get_ds_car_conta - SigCdCli.RClis (somente exibicao)
    this_nProcessados       = 1    && optProcessados.Value: 1=Nao Processados, 2=Ja Processadas
    this_nPeriodo           = 1    && optPeriodo.Value: 1=Vencimento, 2=Emissao
    this_cTituloBanco       = ""   && Get_titban - texto gravado no arquivo/boleto (nao persistido)
    this_nDiasProtesto      = 5    && spndias.Value - dias p/ protesto (default SigCdCeb.DiasProts)
    this_cOperacoesMarcadas = ""   && lista "(dopes1,dopes2,...)" das operacoes (SigCdOpe) marcadas
                                    && no grid de filtro (crSigCdOpe.marca), usada no IN() do SQL

    *==========================================================================
    * Propriedades de apoio a geracao do arquivo CNAB / boleto (Fase 8) -
    * estado transitorio calculado por ObterDadosEmpresa/ObterConvenio e
    * consumido por GerarCnab*/ImprimirBoleto/pelo Form (nao persistido).
    *==========================================================================
    this_cCodEmpresaAtual    = ""  && empresa da geracao em curso (Get_Cd_Empresa)
    this_cContaCarteiraAtual = ""  && conta/carteira da geracao em curso (get_cd_car_conta)
    this_cRazSocsEmpresa     = ""  && SigCdEmp.RazSocs da empresa (cabecalho do CNAB)
    this_cCgcsEmpresa        = ""  && SigCdEmp.Cgcs da empresa (cabecalho do CNAB)
    this_cBancoConvenio      = ""  && SigCdCeb.NBancos do convenio da conta (dispatch de layout)
    this_nDiasProtestoConvenio = 0 && SigCdCeb.DiasProts do convenio (default do spinner de dias)
    this_cUltimoArquivoGerado  = "" && caminho do ultimo arquivo CNAB gravado (mensagem de sucesso)
    this_cCursorBoleto         = "" && alias do cursor pronto para o REPORT FORM do boleto (Form imprime)

    *==========================================================================
    * Propriedades do registro de controle gravado em SigPcOol a cada
    * arquivo CNAB gerado ("Insert Into crSigPcOol ..." nos metodos
    * cnabbradesco/cnabitau/cnabbrasil/cnabbrasil6/cnabsantander/
    * cnabsantander240/cnabitau240). Regra CLAUDE.md #22: TODAS as colunas
    * NOT NULL da tabela precisam de property, mesmo as que o legado nunca
    * cita (empds/edndests/nopers - existiam so no registro em branco do
    * AddCursor do legado).
    *==========================================================================
    this_cTipos       = "SIGPRCNB" && tipos       char(10)      NOT NULL - identificador fixo do processo
    this_cEmps        = ""         && emps        char(3)       NOT NULL - empresa do titulo (crFiltro2.Emps)
    this_cDopes       = ""         && dopes       char(20)      NOT NULL - documento/operacao (crFiltro2.Dopes)
    this_nNumes       = 0          && numes       numeric(6,0)  NOT NULL - numero do titulo (crFiltro2.Numes)
    this_cEmpDs       = ""         && empds       char(3)       NOT NULL - nao citado no INSERT legado
    this_cDopeDs      = ""         && dopeds      char(20)      NOT NULL - titulo do banco (crFiltro2.Titulos)
    this_nNumeDs      = 0          && numeds      numeric(11,0) NOT NULL - sequencial do arquivo (lcSeqNum)
    this_dDatas       = {}         && datas       datetime      NULL     - data/hora da geracao (Datetime())
    this_cUsuars      = ""         && usuars      char(10)      NOT NULL - usuario logado (Usuar)
    this_cProdutos    = ""         && produtos    text          NULL     - conteudo do arquivo CNAB (lcStr)
    this_cCidChaves   = ""         && cidchaves   char(20)      NOT NULL - PK Fortyus (fUniqueIds())
    this_cEndDests    = ""         && edndests    char(29)      NOT NULL - nao citado no INSERT legado
    this_cEmpDopNums  = ""         && empdopnums  char(29)      NOT NULL - chave do titulo (crFiltro2.EmpDopNums)
    this_cProcessos   = "CNAB"     && processos   char(20)      NOT NULL - identificador fixo do lote
    this_nNopers      = 0          && nopers      numeric(9,0)  NOT NULL - nao citado no INSERT legado

    *==========================================================================
    * Init - Business Object com tabela de controle SigPcOol (sem tela de
    * cadastro - a chave e o campo chave sao usados apenas pelo mecanismo
    * de auditoria/DataAccess herdado de BusinessBase).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPcOol"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves (PK Fortyus) do registro de
    * controle atual, usado por RegistrarAuditoria() e por Atualizar()/
    * ExecutarExclusao() no WHERE.
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - carrega as propriedades a partir de um cursor com as
    * colunas de SigPcOoL (SELECT * FROM SigPcOoL ou cursor equivalente).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    * REGRA CRITICA (TratarNulo): o 2o argumento eh o VALOR PADRAO da coluna,
    * NUNCA um codigo de tipo - "" para char/text, 0 para numeric, {} para
    * datetime (memoria feedback_tratarnulo_2o_arg_eh_valor_padrao).
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipos       = TratarNulo(tipos,      "")
                THIS.this_cEmps        = TratarNulo(emps,       "")
                THIS.this_cDopes       = TratarNulo(dopes,      "")
                THIS.this_nNumes       = TratarNulo(numes,      0)
                THIS.this_cEmpDs       = TratarNulo(empds,      "")
                THIS.this_cDopeDs      = TratarNulo(dopeds,     "")
                THIS.this_nNumeDs      = TratarNulo(numeds,     0)
                THIS.this_dDatas       = TratarNulo(datas,      {})
                THIS.this_cUsuars      = TratarNulo(usuars,     "")
                THIS.this_cProdutos    = TratarNulo(produtos,   "")
                THIS.this_cCidChaves   = TratarNulo(cidchaves,  "")
                THIS.this_cEndDests    = TratarNulo(edndests,   "")
                THIS.this_cEmpDopNums  = TratarNulo(empdopnums, "")
                THIS.this_cProcessos   = TratarNulo(processos,  "")
                THIS.this_nNopers      = TratarNulo(nopers,     0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - grava UM registro de controle em SigPcOoL. Eh chamado uma vez
    * por titulo processado no arquivo CNAB (mesmo padrao do legado, que
    * executa "Insert Into crSigPcOol ... Values (..., fUniqueIds(), ...)"
    * dentro do Scan de cada layout bancario - cnabbradesco/cnabitau/
    * cnabbrasil/cnabbrasil6/cnabsantander/cnabsantander240/cnabitau240).
    *
    * cidchaves (PK Fortyus, regra CLAUDE.md #22) e datas SAO GERADOS AQUI,
    * sempre, e sobrescrevem qualquer valor que a chamadora tenha setado -
    * cada Inserir() eh um registro NOVO e distinto, igual ao legado gerar
    * fUniqueIds()/Datetime() a cada volta do loop. Reaproveitar a chave
    * entre duas chamadas faria a segunda colidir no indice unico.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_dDatas     = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds,
                    dopeds, numeds, datas, usuars, produtos, cidchaves,
                    edndests, empdopnums, processos, nopers)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>,
                    <<EscaparSQL(THIS.this_cDopeDs)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumeDs, 0)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cProdutos)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cEndDests)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cProcessos)>>,
                    <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza o registro de controle existente (localizado por
    * cidchaves). O legado nunca faz UPDATE em SigPcOol (soh Insert +
    * TableUpdate), mas o contrato de BusinessBase.Salvar() exige o metodo
    * para o caminho ALTERAR de um registro ja carregado via CarregarDoCursor.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPcOoL
                SET tipos      = <<EscaparSQL(THIS.this_cTipos)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    dopes      = <<EscaparSQL(THIS.this_cDopes)>>,
                    numes      = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>,
                    dopeds     = <<EscaparSQL(THIS.this_cDopeDs)>>,
                    numeds     = <<FormatarNumeroSQL(THIS.this_nNumeDs, 0)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    produtos   = <<EscaparSQL(THIS.this_cProdutos)>>,
                    edndests   = <<EscaparSQL(THIS.this_cEndDests)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    processos  = <<EscaparSQL(THIS.this_cProcessos)>>,
                    nopers     = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - exclui o registro de controle localizado por
    * cidchaves. Sem dependencias a checar (SigPcOoL nao eh referenciada por
    * FK de outra tabela do schema) - eh so o historico de arquivos gerados.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPcOoL WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro de controle CNAB:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "SIGPRCNBBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosEmpresa - carrega Razao Social/CNPJ da empresa filtrada
    * (Thisform.poDataMgr.CursorQuery('SigCdEmp', 'crEmpresa', ...) dentro de
    * PROCEDURE geracnab no legado). Exige RazSocs e Cgcs preenchidos - sem
    * eles nao ha como montar o cabecalho do arquivo CNAB.
    *==========================================================================
    PROTECTED FUNCTION ObterDadosEmpresa(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_EmpCnab")
                USE IN cursor_4c_EmpCnab
            ENDIF

            loc_cSQL = "SELECT RazSocs, Cgcs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCnab")

            IF loc_nResultado > 0 AND USED("cursor_4c_EmpCnab") AND !EOF("cursor_4c_EmpCnab") ;
                    AND !EMPTY(ALLTRIM(NVL(cursor_4c_EmpCnab.RazSocs, ""))) ;
                    AND !EMPTY(ALLTRIM(NVL(cursor_4c_EmpCnab.Cgcs, "")))
                THIS.this_cRazSocsEmpresa = ALLTRIM(cursor_4c_EmpCnab.RazSocs)
                THIS.this_cCgcsEmpresa    = ALLTRIM(cursor_4c_EmpCnab.Cgcs)
                loc_lSucesso = .T.
            ELSE
                MsgAviso("N" + CHR(227) + "o Foi Encontrada a Raz" + CHR(227) + "o Social e/ou o CNPJ da Empresa [" + ;
                    par_cEmpresa + "]" + CHR(13) + ;
                    "Complete os Dados no Cadastro de Empresas e Tente Novamente!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF

            IF USED("cursor_4c_EmpCnab")
                USE IN cursor_4c_EmpCnab
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.ObterDadosEmpresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterConvenio - localiza o convenio bancario (SigCdCeb) da conta/
    * carteira selecionada (Thisform.poDataMgr.CursorQuery('SigCdCli',...) +
    * SqlExecute em SigCdCeb no legado). Mantem cursor_4c_Convenio ABERTO ate
    * o fim da geracao - os metodos GerarCnab*/ImprimirBoleto leem varios
    * campos dele qualificando o alias diretamente (cursor_4c_Convenio.xxx),
    * igual ao legado referenciar crConvenio.xxx sem depender da area ativa.
    *==========================================================================
    PROTECTED FUNCTION ObterConvenio(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGrupo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GrupoConta")
                USE IN cursor_4c_GrupoConta
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta), ;
                "cursor_4c_GrupoConta")

            loc_cGrupo = ""
            IF loc_nResultado > 0 AND USED("cursor_4c_GrupoConta") AND !EOF("cursor_4c_GrupoConta")
                loc_cGrupo = ALLTRIM(cursor_4c_GrupoConta.Grupos)
            ENDIF
            IF USED("cursor_4c_GrupoConta")
                USE IN cursor_4c_GrupoConta
            ENDIF

            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdCeb" + CHR(13) + ;
                       "WHERE GruContas = " + EscaparSQL(loc_cGrupo + par_cConta) + CHR(13) + ;
                       "  AND NAgencias <> SPACE(6)" + CHR(13) + ;
                       "  AND Convenios <> SPACE(9)" + CHR(13) + ;
                       "ORDER BY NAgencias, Convenios"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio")

            IF loc_nResultado > 0 AND USED("cursor_4c_Convenio") AND !EOF("cursor_4c_Convenio")
                GO TOP IN cursor_4c_Convenio
                THIS.this_cBancoConvenio        = ALLTRIM(cursor_4c_Convenio.NBancos)
                THIS.this_nDiasProtestoConvenio = IIF(EMPTY(NVL(cursor_4c_Convenio.DiasProts, 0)), 5, cursor_4c_Convenio.DiasProts)
                loc_lSucesso = .T.
            ELSE
                MsgAviso("N" + CHR(227) + "o Foi Encontrado o N" + CHR(250) + "mero da Ag" + CHR(234) + "ncia e/ou o C" + CHR(243) + ;
                    "digo do Conv" + CHR(234) + "nio Para" + CHR(13) + ;
                    "o Banco [" + par_cConta + "]!!! Complete os Dados no Cadastro de Contas!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.ObterConvenio")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarArquivoCnab - PROCEDURE geracnab(pTipo='A') no legado: gera o
    * arquivo de remessa bancaria (layout Bradesco/Itau/Brasil/Santander240
    * conforme o banco do convenio da conta/carteira) com os titulos
    * marcados no cursor de titulos da Pagina Dados. Chamado pelo botao
    * "Gerar CNAB".
    *
    * par_cCursorTitulos - alias do cursor de titulos (cursor_4c_Titulos),
    *   com coluna Marca indicando selecao e EndErro=1 ja desmarcado pelo
    *   Form (regra #21b/#42 - guardas de validacao sao parte da regra).
    *==========================================================================
    FUNCTION GerarArquivoCnab(par_cCursorTitulos, par_cEmpresa, par_cConta, par_cTituloBanco)
        LOCAL loc_nMarcados, loc_lSucesso, loc_cArquivoItau
        loc_lSucesso = .F.

        THIS.this_cCodEmpresaAtual    = par_cEmpresa
        THIS.this_cContaCarteiraAtual = par_cConta

        IF !USED(par_cCursorTitulos)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorTitulos)
        COUNT FOR Marca TO loc_nMarcados
        IF loc_nMarcados = 0
            MsgAviso("Nenhum registro foi selecionado", "Aviso")
            RETURN .F.
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(par_cTituloBanco, "")))
            IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?", "Aviso")
                RETURN .F.
            ENDIF
        ELSE
            IF !MsgConfirma("O campo " + CHR(34) + "T" + CHR(237) + "tulo Banco" + CHR(34) + ;
                    " n" + CHR(227) + "o foi preenchido. Continuar?", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        IF !THIS.ObterDadosEmpresa(par_cEmpresa)
            RETURN .F.
        ENDIF

        IF !THIS.ObterConvenio(par_cConta)
            RETURN .F.
        ENDIF

        DO CASE
            CASE THIS.this_cBancoConvenio == "001"
                loc_lSucesso = THIS.GerarCnabBrasil(par_cCursorTitulos, par_cTituloBanco)

            CASE THIS.this_cBancoConvenio == "341"
                loc_cArquivoItau = GETFILE("txt", "Arquivo", "OK", 0, "Arquivo CNAB")
                IF EMPTY(loc_cArquivoItau)
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.GerarCnabItau(par_cCursorTitulos, par_cTituloBanco, loc_cArquivoItau)
                ENDIF

            CASE THIS.this_cBancoConvenio == "237"
                loc_lSucesso = THIS.GerarCnabBradesco(par_cCursorTitulos, par_cTituloBanco)

            CASE INLIST(THIS.this_cBancoConvenio, "033", "353")
                loc_lSucesso = THIS.GerarCnabSantander240(par_cCursorTitulos, par_cTituloBanco)

            OTHERWISE
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " layout de CNAB configurado para o banco [" + ;
                    THIS.this_cBancoConvenio + "].", "Aviso")
                loc_lSucesso = .F.
        ENDCASE

        IF USED("cursor_4c_Convenio")
            USE IN cursor_4c_Convenio
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabBrasil - PROCEDURE cnabbrasil no legado (CNAB 400 - Banco do
    * Brasil, convenio NBancos='001'). Ao final, dispara automaticamente a
    * impressao do boleto (ImprimirBoleto .F.) - igual ao legado ("thisform.
    * impboleto(.F.)" na ultima linha de cnabbrasil).
    *==========================================================================
    PROTECTED FUNCTION GerarCnabBrasil(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cBanco, loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, ;
              loc_cRazBco, loc_cDat, loc_cPri, loc_cProt, loc_cCdC, loc_cTpCtArq, loc_cTpCtBol, ;
              loc_cEnv, loc_cArq, loc_cChr, loc_cStr, loc_nSeq, loc_cSeq, loc_nSeqNum, ;
              loc_cVenc, loc_cValor, loc_nMora, loc_cMora, loc_cCgcCli, loc_cTpCgcCli, loc_cNome, ;
              loc_cEnde, loc_cBair, loc_cCep, loc_cCida, loc_cEsta, loc_cNumTit, loc_lSucesso, ;
              loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cBanco   = PADL(ALLTRIM(cursor_4c_Convenio.NBancos), 3, "0")
            loc_cCnv     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 3, "0")
            loc_cAge     = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
            loc_cBco     = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas) + PADL(cursor_4c_Convenio.DigiAgen, 1, "0"), ".-", ""), 9, "0")
            loc_cRaz     = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc     = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc   = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRazBco  = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cPri     = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
            loc_cProt    = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
            loc_cProt    = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(STR(loc_cProt)), 2, "0"))
            loc_cCdC     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 7, "0")
            loc_cTpCtArq = ALLTRIM(cursor_4c_Convenio.TpCtArqs)
            loc_cTpCtBol = ALLTRIM(cursor_4c_Convenio.TpCtBols)
            loc_cEnv     = PADL(TRANSFORM(fGerUniqueKey("BRASILENV")), 7, "0")
            loc_cArq     = ALLTRIM(cursor_4c_Convenio.ArqCnabs) + loc_cEnv + ".REM"
            loc_cChr     = CHR(13) + CHR(10)

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA" + SPACE(7) + loc_cAge + loc_cBco + SPACE(6) + ;
                       loc_cRaz + "001BANCO DO BRASIL" + loc_cDat + loc_cEnv + SPACE(22) + loc_cCdC + SPACE(258) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(5) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_nSeqNum   = fGerUniqueKey("BBNOSSONUM")
                loc_cSeq      = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_nMora     = ROUND((cursor_4c_CnabDet.Valos * 0.23) / 100, 2)
                loc_cMora     = PADL(CHRTRAN(STR(loc_nMora, 11, 2), ",.", ""), 13, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 37)
                loc_cNome     = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 37)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + " " + ALLTRIM(cursor_4c_CnabDet.Nums) + " " + ALLTRIM(cursor_4c_CnabDet.Compls), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF
                loc_cEnde   = PADR(CHRTRAN(loc_cEnde, "/.-,", ""), 40)
                loc_cNumTit = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cStr = "7" + loc_cTpCgc + loc_cCgc + loc_cAge + loc_cBco + loc_cCdC + PADR(loc_cNumTit, 25) + ;
                           loc_cCdC + PADL(loc_nSeqNum, 10, "0") + "00" + "00" + SPACE(3) + " " + SPACE(3) + ;
                           loc_cTpCtBol + "0" + "000000" + SPACE(5) + loc_cTpCtArq + "01" + PADR(loc_cNumTit, 10) + ;
                           loc_cVenc + loc_cValor + "001" + "0000" + " " + "01" + "N" + loc_cDat + loc_cPri + "00" + ;
                           loc_cMora + "000000" + "0000000000000" + "0000000000000" + "0000000000000" + loc_cTpCgcCli + ;
                           loc_cCgcCli + UPPER(loc_cNome) + "   " + UPPER(loc_cEnde) + UPPER(loc_cBair) + loc_cCep + ;
                           UPPER(loc_cCida) + UPPER(loc_cEsta) + SPACE(40) + "  " + " " + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                REPLACE SeqNums WITH PADL(loc_nSeqNum, 5, "0") IN cursor_4c_CnabDet

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " Gerado Com Sucesso!!!", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            *-- cursor_4c_CnabDet NAO eh fechado aqui de proposito: ja tem
            *-- SeqNums preenchido pelo SCAN acima, e ImprimirBoleto (chamado
            *-- logo abaixo, fora do TRY) reusa esse mesmo cursor - igual ao
            *-- legado, que reaproveita a MESMA crFiltro2 entre cnabbrasil e
            *-- impboleto (thisform.impboleto(.F.) na ultima linha).
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabBrasil")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.ImprimirBoleto("cursor_4c_CnabDet", .F.)
        ENDIF

        IF USED("cursor_4c_CnabDet")
            USE IN cursor_4c_CnabDet
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabItau - PROCEDURE cnabitau no legado (CNAB 400 - Itau, convenio
    * NBancos='341'). par_cArquivo vem do GETFILE() escolhido pelo usuario no
    * dispatcher (GerarArquivoCnab) - igual ao legado, que pede o arquivo
    * ANTES de chamar Thisform.CnabItau().
    *==========================================================================
    PROTECTED FUNCTION GerarCnabItau(par_cCursorTitulos, par_cTituloBanco, par_cArquivo)
        LOCAL loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, loc_cRazBco, ;
              loc_cDat, loc_cProt, loc_cStr, loc_nSeq, loc_cSeq, loc_cVenc, loc_cValor, ;
              loc_cCgcCli, loc_cTpCgcCli, loc_cNome, loc_cEnde, loc_cBair, loc_cCep, loc_cCida, ;
              loc_cEsta, loc_cNumTit, loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cCnv    = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 8, "0")
            loc_cAge    = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 4, "0")
            loc_cBco    = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 5, "0") + cursor_4c_Convenio.DigiAgen
            loc_cRaz    = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc    = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc  = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRazBco = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cProt   = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
            loc_cProt   = PADL(ALLTRIM(STR(loc_cProt)), 2, "0")

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + loc_cAge + "00" + loc_cBco + SPACE(8) + ;
                       loc_cRaz + "341" + loc_cRazBco + loc_cDat + SPACE(294) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, par_cArquivo, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT * FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_cSeq      = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 30)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + "," + cursor_4c_CnabDet.Nums, 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 12)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF
                loc_cNumTit = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cStr = "1" + loc_cTpCgc + loc_cCgc + loc_cAge + "00" + loc_cBco + SPACE(4) + "0000" + ;
                           PADR(loc_cNumTit, 25) + loc_cNumTit + "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
                           PADR(loc_cNumTit, 10) + loc_cVenc + loc_cValor + "341" + "00000" + "01" + "A" + loc_cDat + ;
                           "81" + "19" + "0000000000000" + "000000" + "0000000000000" + "0000000000000" + ;
                           "0000000000000" + loc_cTpCgcCli + loc_cCgcCli + loc_cNome + SPACE(10) + loc_cEnde + ;
                           loc_cBair + loc_cCep + loc_cCida + loc_cEsta + SPACE(30) + SPACE(4) + "000000" + ;
                           loc_cProt + " " + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, par_cArquivo, 1)

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = 0
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, par_cArquivo, 1)

            IF FILE(par_cArquivo)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = par_cArquivo
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(par_cArquivo) + CHR(34) + " gerado com sucesso.", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabItau")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabBradesco - PROCEDURE cnabbradesco no legado (CNAB 400 -
    * Bradesco, convenio NBancos='237'). "Nosso Numero" so eh calculado
    * quando BcoImprime<>1 (cliente emite o boleto, nao o banco) - igual ao
    * legado (bloco "If lcBol = [2]").
    *==========================================================================
    PROTECTED FUNCTION GerarCnabBradesco(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cBcn, loc_cCnv, loc_cAge, loc_cBco, loc_cRaz, loc_cCgc, loc_cTpCgc, loc_cRbc, ;
              loc_cDat, loc_cEnv, loc_nMor, loc_cPri, loc_cPrt, loc_cCdC, loc_cDig, loc_cArq, loc_cChr, ;
              loc_cCar, loc_cBol, loc_cStr, loc_nSeq, loc_cSeq, loc_nSeqNum, loc_cVenc, loc_cValor, ;
              loc_cMor, loc_cCpf, loc_cTpCgcCli, loc_cNome, loc_cEnde, loc_cCep, loc_cNtt, loc_cNossoNum, ;
              loc_cDV, loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cBcn  = PADL(ALLTRIM(cursor_4c_Convenio.NBancos), 3, "0")
            loc_cCnv  = "009"
            loc_cAge  = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
            loc_cBco  = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 7, "0") + PADL(cursor_4c_Convenio.DigiAgen, 1, "0")
            loc_cRaz  = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc  = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 14, "0")
            loc_cTpCgc = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "01", "02")
            loc_cRbc  = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 15)
            loc_cDat  = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
            loc_cEnv  = PADL(TRANSFORM(fGerUniqueKey("BRADESCOENV")), 7, "0")
            loc_nMor  = IIF(EMPTY(cursor_4c_Convenio.Moras), 0.17, cursor_4c_Convenio.Moras)
            loc_cPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
            loc_cPrt  = PADL(IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio), 2, "0")
            loc_cPrt  = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(loc_cPrt), 2, "0"))
            loc_cCdC  = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 20, "0")
            loc_cDig  = IIF(VAL(SUBSTR(loc_cEnv, 6, 2)) = 0, TRANSFORM(VAL(SUBSTR(loc_cEnv, 6, 2)) + 1, "@L 99"), TRANSFORM(VAL(SUBSTR(loc_cEnv, 6, 2)), "@L 99"))
            loc_cArq  = "CB" + SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + loc_cDig + ".REM"
            loc_cChr  = CHR(13) + CHR(10)
            loc_cCar  = PADL(ALLTRIM(cursor_4c_Convenio.TpCtBols), 2, "0")
            loc_cBol  = IIF(cursor_4c_Convenio.BcoImprime = 1, "1", "2")

            loc_cStr = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + loc_cCdC + loc_cRaz + loc_cBcn + ;
                       loc_cRbc + loc_cDat + SPACE(8) + "MX" + loc_cEnv + SPACE(277) + "000001"

            loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(11) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeq = 2
            SELECT cursor_4c_CnabDet
            SCAN
                loc_nSeqNum = fGerUniqueKey("BRNOSSONUM")
                REPLACE SeqNums WITH PADL(loc_nSeqNum, 11, "0") IN cursor_4c_CnabDet

                loc_cSeq   = TRANSFORM(loc_nSeq, "@L 999999")
                loc_cVenc  = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 9, 2)
                loc_cValor = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 13, "0")
                loc_cMor   = PADL(CHRTRAN(STR(ROUND((cursor_4c_CnabDet.Valos * loc_nMor) / 100, 2), 11, 2), ",.", ""), 13, "0")
                loc_cCpf   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 14, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "01", "02")
                loc_cNome  = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 40)
                loc_cNome  = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 40)
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + " " + cursor_4c_CnabDet.Nums, 40)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                ENDIF
                loc_cEnde = PADR(CHRTRAN(loc_cEnde, "/.-,", ""), 40)
                loc_cNtt  = PADL(CHRTRAN(cursor_4c_CnabDet.Titulos, "/", ""), 8, "0")

                loc_cNossoNum = "00000000000"
                loc_cDV       = "0"
                IF loc_cBol == "2"
                    loc_cNossoNum = PADL(cursor_4c_CnabDet.SeqNums, 11, "0")
                    loc_cDV       = fCalcMod11B7(loc_cCar + loc_cNossoNum)
                ENDIF

                loc_cStr = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
                           "0" + loc_cCnv + loc_cAge + loc_cBco + PADR(loc_cNtt, 25) + "   " + "2" + "0200" + ;
                           loc_cNossoNum + loc_cDV + "0000000000" + loc_cBol + " " + SPACE(10) + " " + "2" + ;
                           "  " + "01" + PADR(loc_cNtt, 10) + loc_cVenc + loc_cValor + "000" + "00000" + "01" + ;
                           "N" + loc_cDat + loc_cPri + loc_cPrt + loc_cMor + "000000" + "0000000000000" + ;
                           "0000000000000" + "0000000000000" + loc_cTpCgcCli + loc_cCpf + loc_cNome + loc_cEnde + ;
                           SPACE(12) + loc_cCep + SPACE(60) + loc_cSeq

                loc_cStr = fLimpaTexto(loc_cStr) + loc_cChr
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF

                loc_nSeq = loc_nSeq + 1
            ENDSCAN

            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "9" + SPACE(393) + loc_cSeq + loc_cChr
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " Gerado Com Sucesso!!!", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabBradesco")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GerarCnabSantander240 - PROCEDURE cnabsantander240 no legado (CNAB 240
    * - Santander, convenio NBancos IN ('033','353')). Layout multi-segmento:
    * Header arquivo, Header lote, Detalhe P + Q por titulo, Trailer lote,
    * Trailer arquivo.
    *==========================================================================
    PROTECTED FUNCTION GerarCnabSantander240(par_cCursorTitulos, par_cTituloBanco)
        LOCAL loc_cCnv, loc_cAge, loc_cDigA, loc_cCtaC, loc_cDigC, loc_cCta, loc_cRaz, loc_cCgc, ;
              loc_cTpCgc, loc_cRazBco, loc_cDat, loc_cEnv, loc_cArq, loc_nLot, loc_cLot, loc_nSeq, ;
              loc_cSeq, loc_cStr, loc_nSeqL, loc_cSeqL, loc_cNumes, loc_cVenc, loc_cValor, loc_cCgcCli, ;
              loc_cTpCgcCli, loc_cNome, loc_nMora, loc_cMora, loc_cEnde, loc_cBair, loc_cCep, loc_cCida, ;
              loc_cEsta, loc_cNumTit, loc_cChave, loc_nSeqNum, loc_cDV, loc_cNossoNum, loc_lSucesso, ;
              loc_lManual, loc_oErro
        loc_lSucesso = .T.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            loc_cCnv    = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 11, "0")
            loc_cAge    = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 4, "0")
            loc_cDigA   = ALLTRIM(cursor_4c_Convenio.DigiAgen)
            loc_cCtaC   = ALLTRIM(CHRTRAN(cursor_4c_Convenio.Contas, ".-", ""))
            loc_cDigC   = RIGHT(loc_cCtaC, 1)
            loc_cCta    = PADL(LEFT(loc_cCtaC, LEN(loc_cCtaC) - 1), 9, "0")
            loc_cRaz    = PADR(THIS.this_cRazSocsEmpresa, 30)
            loc_cCgc    = PADL(CHRTRAN(CHRTRAN(CHRTRAN(THIS.this_cCgcsEmpresa, "/", ""), ".", ""), "-", ""), 15, "0")
            loc_cTpCgc  = IIF(LEN(CHRTRAN(THIS.this_cCgcsEmpresa, "/.-", "")) = 11, "1", "2")
            loc_cRazBco = PADR(ALLTRIM(cursor_4c_Convenio.Bancos), 30)
            loc_cDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
            loc_cEnv    = PADL(TRANSFORM(fGerUniqueKey("SANTANDERENV")), 8, "0")
            loc_cArq    = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
            loc_cArq    = STRTRAN(loc_cArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + loc_cEnv + ".REM", "\\", "\")

            loc_nLot = 0
            loc_cLot = TRANSFORM(loc_nLot, "@L 9999")
            loc_nSeq = 1

            *-- Registro Header de arquivo
            loc_cStr = "033" + loc_cLot + "0" + SPACE(8) + loc_cTpCgc + loc_cCgc + loc_cAge + loc_cCnv + ;
                       SPACE(25) + loc_cRaz + loc_cRazBco + SPACE(10) + "1" + loc_cDat + SPACE(6) + ;
                       SUBSTR(loc_cEnv, 3) + "040" + SPACE(74)

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 0)

            *-- Registro Header de lote
            loc_nLot = loc_nLot + 1
            loc_cLot = TRANSFORM(loc_nLot, "@L 9999")
            loc_nSeq = loc_nSeq + 1

            loc_cStr = "033" + loc_cLot + "1" + "R" + "01" + SPACE(2) + "030" + " " + loc_cTpCgc + loc_cCgc + ;
                       SPACE(20) + loc_cAge + loc_cCnv + SPACE(5) + loc_cRaz + SPACE(40) + SPACE(40) + loc_cEnv + ;
                       loc_cDat + SPACE(41)

            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
            SELECT *, SPACE(5) AS SeqNums FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_CnabDet READWRITE

            loc_nSeqL = 0
            SELECT cursor_4c_CnabDet
            SCAN
                loc_cNumes    = TRANSFORM(cursor_4c_CnabDet.Numes, "@L 9999999999")
                loc_cVenc     = SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 1, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 4, 2) + SUBSTR(DTOC(cursor_4c_CnabDet.Vencs), 7, 4)
                loc_cValor    = PADL(CHRTRAN(STR(cursor_4c_CnabDet.Valos, 11, 2), ",.", ""), 15, "0")
                loc_cCgcCli   = PADL(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-,", ""), 15, "0")
                loc_cTpCgcCli = IIF(LEN(CHRTRAN(cursor_4c_CnabDet.Cpfs, "/.-", "")) = 11, "1", "2")
                loc_cNome     = PADR(IIF(EMPTY(cursor_4c_CnabDet.Razaos), cursor_4c_CnabDet.RClis, cursor_4c_CnabDet.Razaos), 40)
                loc_nMora     = IIF(cursor_4c_Convenio.Moras = 0, 0.33, cursor_4c_Convenio.Moras)
                loc_nMora     = ROUND((cursor_4c_CnabDet.Valos * loc_nMora) / 100, 2)
                loc_cMora     = PADL(CHRTRAN(STR(loc_nMora, 11, 2), ",.", ""), 15, "0")
                IF EMPTY(cursor_4c_CnabDet.EndCobs) OR EMPTY(cursor_4c_CnabDet.CepCobs) OR EMPTY(cursor_4c_CnabDet.EstCobs) ;
                        OR EMPTY(cursor_4c_CnabDet.BaiCobs) OR EMPTY(cursor_4c_CnabDet.CidCobs)
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.Endes) + "," + cursor_4c_CnabDet.Nums, 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.Bairs, 15)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.Ceps, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.Cidas, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.Estas, 2)
                ELSE
                    loc_cEnde = PADR(ALLTRIM(cursor_4c_CnabDet.EndCobs), 40)
                    loc_cBair = PADR(cursor_4c_CnabDet.BaiCobs, 15)
                    loc_cCep  = PADL(CHRTRAN(cursor_4c_CnabDet.CepCobs, ".-", ""), 8, "0")
                    loc_cCida = PADR(cursor_4c_CnabDet.CidCobs, 15)
                    loc_cEsta = PADR(cursor_4c_CnabDet.EstCobs, 2)
                ENDIF

                loc_cNumTit = PADL(ALLTRIM(STRTRAN(cursor_4c_CnabDet.Titulos, "/", "")), 15, "0")
                loc_cChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_CnabDet.Titulos, "/", "")), 15) + loc_cNumes

                loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")

                loc_nSeqNum   = fGerUniqueKey("STNOSSONUM")
                loc_cDV       = fCalcMod11BB(PADL(loc_nSeqNum, 7, "0"), cursor_4c_Convenio.NBancos)
                loc_cNossoNum = PADL(loc_nSeqNum, 12, "0") + loc_cDV

                *-- Detalhe P
                loc_nSeqL = loc_nSeqL + 1
                loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 99999")
                loc_nSeq  = loc_nSeq + 1

                loc_cStr = "033" + loc_cLot + "3" + loc_cSeqL + "P" + " " + "01" + loc_cAge + loc_cDigA + ;
                           loc_cCta + loc_cDigC + loc_cCta + loc_cDigC + "  " + loc_cNossoNum + "5" + "1" + "1" + ;
                           " " + " " + loc_cNumTit + loc_cVenc + loc_cValor + loc_cAge + loc_cDigA + " " + "02" + ;
                           "N" + loc_cDat + "1" + loc_cVenc + loc_cMora + "0" + "00000000" + "000000000000000" + ;
                           "000000000000000" + "000000000000000" + loc_cChave + "0" + "00" + "2" + "0" + "00" + ;
                           "00" + SPACE(11)

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                *-- Detalhe Q
                loc_nSeq  = loc_nSeq + 1
                loc_nSeqL = loc_nSeqL + 1
                loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 99999")

                loc_cStr = "033" + loc_cLot + "3" + loc_cSeqL + "Q" + " " + "01" + loc_cTpCgcCli + loc_cCgcCli + ;
                           loc_cNome + loc_cEnde + loc_cBair + loc_cCep + loc_cCida + loc_cEsta + "0" + ;
                           "000000000000000" + SPACE(40) + "000" + "000" + "000" + "000" + SPACE(19)

                loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
                = STRTOFILE(loc_cStr, loc_cArq, 1)

                REPLACE SeqNums WITH PADL(loc_nSeqNum, 5, "0") IN cursor_4c_CnabDet

                THIS.this_cEmps       = cursor_4c_CnabDet.Emps
                THIS.this_cDopes      = cursor_4c_CnabDet.Dopes
                THIS.this_nNumes      = cursor_4c_CnabDet.Numes
                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                THIS.this_cProdutos   = loc_cStr
                THIS.this_cEmpDopNums = cursor_4c_CnabDet.EmpDopNums
                THIS.this_cDopeDs     = cursor_4c_CnabDet.Titulos
                THIS.this_nNumeDs     = loc_nSeqNum
                IF !THIS.Inserir()
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- Trailer de lote
            loc_nSeq  = loc_nSeq + 1
            loc_nSeqL = loc_nSeqL + 1
            loc_cSeqL = TRANSFORM(loc_nSeqL, "@L 999999")
            loc_cStr = "033" + loc_cLot + "5" + SPACE(9) + loc_cSeqL + SPACE(217)
            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            *-- Trailer de arquivo
            loc_nSeq = loc_nSeq + 1
            loc_cSeq = TRANSFORM(loc_nSeq, "@L 999999")
            loc_cStr = "033" + "9999" + "9" + SPACE(9) + "000001" + loc_cSeq + SPACE(211)
            loc_cStr = fLimpaTexto(loc_cStr) + CHR(13) + CHR(10)
            = STRTOFILE(loc_cStr, loc_cArq, 1)

            IF FILE(loc_cArq)
                IF loc_lSucesso
                    loc_lSucesso = THIS.AtualizarTitulosBancoSigMvCcr("cursor_4c_CnabDet", par_cTituloBanco)
                ENDIF

                IF loc_lManual
                    IF loc_lSucesso
                        = SQLCOMMIT(gnConnHandle)
                    ELSE
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUltimoArquivoGerado = FULLPATH(loc_cArq)
                    MsgAviso("Arquivo " + CHR(34) + ALLTRIM(loc_cArq) + CHR(34) + " gerado com sucesso.", "Aviso")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_CnabDet")
                USE IN cursor_4c_CnabDet
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.GerarCnabSantander240")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarTitulosBancoSigMvCcr - grava o "Titulo do Banco" (par_cTitulo
    * Banco) em SigMvCcr.TitBans para cada titulo do lote gerado, com
    * confirmacao de sobrescrita quando ja existe um valor - identico nos 4
    * layouts do legado (cnabbradesco/cnabitau/cnabbrasil/cnabsantander240).
    *==========================================================================
    PROTECTED FUNCTION AtualizarTitulosBancoSigMvCcr(par_cCursorDetalhe, par_cTituloBanco)
        LOCAL loc_lOk, loc_lAtu, loc_cSQL, loc_nResultado, loc_cEmpDopNums, loc_nNopers, loc_oErro
        loc_lOk = .T.

        TRY
            SELECT (par_cCursorDetalhe)
            SCAN
                loc_lAtu        = .T.
                loc_cEmpDopNums = EVALUATE(par_cCursorDetalhe + ".EmpDopNums")
                loc_nNopers     = EVALUATE(par_cCursorDetalhe + ".Nopers")

                IF USED("cursor_4c_TitBanAtual")
                    USE IN cursor_4c_TitBanAtual
                ENDIF
                loc_cSQL = "SELECT Titulos, TitBans FROM SigMvCcr" + CHR(13) + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + CHR(13) + ;
                           "  AND Nopers = " + FormatarNumeroSQL(loc_nNopers, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanAtual")

                IF loc_nResultado > 0 AND USED("cursor_4c_TitBanAtual") AND !EOF("cursor_4c_TitBanAtual")
                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_TitBanAtual.TitBans, "")))
                        loc_lAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + ALLTRIM(cursor_4c_TitBanAtual.Titulos) + CHR(34) + ;
                            " J" + CHR(225) + " Possui T" + CHR(237) + "tulo do Banco Preenchido." + CHR(13) + ;
                            "Deseja Sobrescrever o T" + CHR(237) + "tulo?", "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TitBanAtual")
                    USE IN cursor_4c_TitBanAtual
                ENDIF

                IF loc_lAtu
                    loc_cSQL = "UPDATE SigMvCcr SET TitBans = " + EscaparSQL(par_cTituloBanco) + CHR(13) + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + CHR(13) + ;
                               "  AND Nopers = " + FormatarNumeroSQL(loc_nNopers, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        MostrarErro("Falha ao gravar o T" + CHR(237) + "tulo do Banco:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT (par_cCursorDetalhe)
            ENDSCAN
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRCNBBO.AtualizarTitulosBancoSigMvCcr")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ImprimirBoleto - PROCEDURE impboleto(pReimp) no legado: calcula os
    * campos do boleto (nosso numero, codigo de barras, linha digitavel)
    * para os titulos marcados e monta cursor_4c_Boletos para a impressao
    * (o REPORT FORM fica a cargo do Form, que escolhe o layout pelo banco
    * do convenio via THIS.this_cBancoConvenio).
    *
    * par_lReimpressao - .T. reutiliza o NumeDs da ULTIMA geracao gravada em
    *   SigPcOol para cada titulo (reimpressao de um boleto ja enviado ao
    *   banco - botao "Boleto"); .F. usa o SeqNums que acabou de ser gravado
    *   por GerarCnabBrasil (chamado automaticamente ao final da geracao).
    * par_cEmpresa/par_cConta - opcionais; se informados, sobrescrevem
    *   this_cCodEmpresaAtual/this_cContaCarteiraAtual (uso standalone via
    *   botao "Boleto", sem GerarArquivoCnab ter rodado antes).
    *
    * Suporta apenas os bancos que o legado emite boleto (001/033/353/237) -
    * Itau (341) so gera arquivo de remessa, sem boleto (fiel ao legado).
    *==========================================================================
    FUNCTION ImprimirBoleto(par_cCursorTitulos, par_lReimpressao, par_cEmpresa, par_cConta)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cNossoNum, loc_cFator, loc_cValor, loc_cBarra, ;
              loc_cDV, loc_cArqBMP, loc_cCampo1, loc_cDv1, loc_cCampo2, loc_cDv2, loc_cCampo3, loc_cDv3, ;
              loc_cNrDigit, loc_cCnv, loc_cAg, loc_cCar, loc_cCta, loc_cDig, loc_cLivre, loc_nMor, ;
              loc_cMora, loc_cInt1, loc_cInt2, loc_cInt7, loc_cProt, loc_cPri, loc_cNome, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cCursorBoleto = ""

        IF VARTYPE(par_cEmpresa) == "C" AND !EMPTY(par_cEmpresa)
            THIS.this_cCodEmpresaAtual = par_cEmpresa
        ENDIF
        IF VARTYPE(par_cConta) == "C" AND !EMPTY(par_cConta)
            THIS.this_cContaCarteiraAtual = par_cConta
        ENDIF

        IF !USED(par_cCursorTitulos)
            RETURN .F.
        ENDIF

        IF !THIS.ObterDadosEmpresa(THIS.this_cCodEmpresaAtual)
            RETURN .F.
        ENDIF
        IF !THIS.ObterConvenio(THIS.this_cContaCarteiraAtual)
            RETURN .F.
        ENDIF

        IF !INLIST(THIS.this_cBancoConvenio, "001", "033", "353", "237")
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " layout de boleto para o banco [" + THIS.this_cBancoConvenio + "].", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Boletos")
                USE IN cursor_4c_Boletos
            ENDIF
            SELECT *, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, THIS.this_cRazSocsEmpresa AS Cedente, ;
                   SPACE(50) AS NomeCli, SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
                   SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, SPACE(70) AS Instr7, ;
                   SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
                   SPACE(2) AS Carteira ;
                FROM (par_cCursorTitulos) WHERE Marca INTO CURSOR cursor_4c_Boletos READWRITE

            *-- Fonte com titulos ja processados (cursor_4c_CnabDet, chamada
            *-- automatica ao final de GerarCnabBrasil) ja tem SeqNums
            *-- preenchido pela geracao; fonte crua (cursor_4c_Titulos, botao
            *-- "Boleto" standalone) ainda nao tem essa coluna - adicionar
            *-- vazia evita erro de coluna duplicada no SELECT * acima.
            IF TYPE("cursor_4c_Boletos.SeqNums") != "C"
                ALTER TABLE cursor_4c_Boletos ADD COLUMN SeqNums C(12)
                REPLACE ALL SeqNums WITH SPACE(12) IN cursor_4c_Boletos
            ENDIF

            IF RECCOUNT("cursor_4c_Boletos") = 0
                MsgAviso("Nenhum registro foi selecionado", "Aviso")
                IF USED("cursor_4c_Boletos")
                    USE IN cursor_4c_Boletos
                ENDIF
                RETURN .F.
            ENDIF

            loc_cCnv     = PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 7, "0")
            loc_lSucesso = .T.

            SELECT cursor_4c_Boletos
            SCAN
                IF par_lReimpressao
                    IF USED("cursor_4c_TmpPcOol")
                        USE IN cursor_4c_TmpPcOol
                    ENDIF
                    loc_cSQL = "SELECT TOP 1 NumeDs FROM SigPcOol" + CHR(13) + ;
                               "WHERE Processos = 'CNAB' AND DopeDs = " + EscaparSQL(cursor_4c_Boletos.Titulos) + CHR(13) + ;
                               "ORDER BY Datas DESC"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPcOol")
                    IF loc_nResultado < 1 OR !USED("cursor_4c_TmpPcOol") OR EOF("cursor_4c_TmpPcOol")
                        MostrarErro("N" + CHR(227) + "o foi encontrada gera" + CHR(231) + CHR(227) + "o anterior deste t" + CHR(237) + "tulo.", "Boleto")
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                    REPLACE SeqNums WITH PADL(ALLTRIM(STR(cursor_4c_TmpPcOol.NumeDs)), 5, "0") IN cursor_4c_Boletos
                ENDIF

                loc_cNossoNum = ""

                DO CASE
                CASE THIS.this_cBancoConvenio == "001"
                    loc_cNossoNum = loc_cCnv + PADL(cursor_4c_Boletos.SeqNums, 10, "0")
                    loc_cFator = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Boletos.Vencs) - CTOD("03/07/2000")))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cBarra = "0019" + loc_cFator + loc_cValor + "000000" + loc_cNossoNum + "17"
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos)

                    loc_cNossoNum = loc_cCnv + PADL(cursor_4c_Boletos.SeqNums, 10, "0")
                    loc_cBarra = "0019" + loc_cDV + loc_cFator + loc_cValor + "000000" + loc_cNossoNum + "17"
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 10, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "001900000"
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cBarra, 25, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cBarra, 35, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH loc_cNrDigit IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH LEFT(ALLTRIM(cursor_4c_Convenio.NAgencias), 4) + "-" + ;
                            RIGHT(ALLTRIM(cursor_4c_Convenio.NAgencias), 1) + "/" + ;
                            ALLTRIM(CHRTRAN(cursor_4c_Convenio.Contas, ".-", "")) + "-" + ;
                            PADL(cursor_4c_Convenio.DigiAgen, 1, "0") IN cursor_4c_Boletos

                    IF VARTYPE(cursor_4c_Convenio.MsgMulta) = "N" AND cursor_4c_Convenio.MsgMulta = 1
                        REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + "S 1 DIA DE VENCIMENTO " IN cursor_4c_Boletos
                    ENDIF

                CASE INLIST(THIS.this_cBancoConvenio, "033", "353")
                    loc_cNossoNum = PADL(cursor_4c_Boletos.SeqNums, 12, "0")
                    loc_cDV       = fCalcMod11BB(loc_cNossoNum, cursor_4c_Convenio.NBancos)
                    loc_cNossoNum = loc_cNossoNum + loc_cDV

                    loc_cFator = PADL(ALLTRIM(STR(TTOD(cursor_4c_Boletos.Vencs) - CTOD("07/10/1997"))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cBarra = "0339" + loc_cFator + loc_cValor + "9" + loc_cCnv + loc_cNossoNum + "0" + "101"
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos, "DVB")

                    loc_cBarra = "0339" + loc_cDV + loc_cFator + loc_cValor + "9" + loc_cCnv + loc_cNossoNum + "0" + "101"
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 12, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "03399" + SUBSTR(loc_cCnv, 1, 4)
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cBarra, 25, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cBarra, 35, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH ALLTRIM(loc_cNrDigit) IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.NAgencias) + "/" + loc_cCnv IN cursor_4c_Boletos
                    REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + DTOC(TTOD(cursor_4c_Boletos.Vencs) + 6) IN cursor_4c_Boletos

                CASE THIS.this_cBancoConvenio == "237"
                    IF USED("cursor_4c_TmpPcOol") AND !EOF("cursor_4c_TmpPcOol")
                        REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(cursor_4c_TmpPcOol.NumeDs, "@R 99999999999")), 11, "0") IN cursor_4c_Boletos
                    ENDIF
                    loc_cFator = PADL(ALLTRIM(STR(TTOD(cursor_4c_Boletos.Vencs) - CTOD("07/10/1997"))), 4, "0")
                    loc_cValor = PADL(CHRTRAN(STR(cursor_4c_Boletos.Valos, 8, 2), ",.", ""), 10, "0")
                    loc_cAg    = PADL(LEFT(ALLTRIM(cursor_4c_Convenio.NAgencias), 4), 4, "0")
                    loc_cCar   = PADL(ALLTRIM(cursor_4c_Convenio.TpCtBols), 2, "0")
                    loc_cCta   = PADL(CHRTRAN(ALLTRIM(cursor_4c_Convenio.Contas), ".-", ""), 7, "0")
                    loc_cDig   = ALLTRIM(cursor_4c_Convenio.DigiAgen)
                    loc_cNossoNum = PADL(cursor_4c_Boletos.SeqNums, 11, "0")
                    loc_cDV       = fCalcMod11B7(loc_cCar + loc_cNossoNum)
                    loc_cNossoNum = loc_cNossoNum + loc_cDV

                    loc_cLivre = loc_cAg + loc_cCar + SUBSTR(loc_cNossoNum, 1, 11) + loc_cCta + "0"
                    loc_cBarra = "2379" + loc_cFator + loc_cValor + loc_cLivre
                    loc_cDV    = fCalcMod11BB(loc_cBarra, cursor_4c_Convenio.NBancos, "DVB")

                    loc_cBarra = "2379" + loc_cDV + loc_cFator + loc_cValor + loc_cLivre
                    REPLACE nBarras WITH loc_cBarra IN cursor_4c_Boletos

                    loc_cArqBMP = "img_barra_" + PADL(cursor_4c_Boletos.SeqNums, 11, "0") + ".bmp"
                    = fGerBar2de5(ADDBS(SYS(2023)) + loc_cArqBMP, loc_cBarra)
                    REPLACE ImgBarra WITH loc_cArqBMP IN cursor_4c_Boletos

                    loc_cCampo1  = "2379" + SUBSTR(loc_cLivre, 1, 5)
                    loc_cDv1     = fCalcMod10(loc_cCampo1)
                    loc_cCampo2  = SUBSTR(loc_cLivre, 6, 10)
                    loc_cDv2     = fCalcMod10(loc_cCampo2)
                    loc_cCampo3  = SUBSTR(loc_cLivre, 16, 10)
                    loc_cDv3     = fCalcMod10(loc_cCampo3)
                    loc_cNrDigit = loc_cCampo1 + loc_cDv1 + loc_cCampo2 + loc_cDv2 + loc_cCampo3 + loc_cDv3 + loc_cDV + loc_cFator + loc_cValor
                    REPLACE NrDigit WITH loc_cNrDigit IN cursor_4c_Boletos
                    REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.NAgencias) + "/" + loc_cCta + "-" + loc_cDig IN cursor_4c_Boletos
                    REPLACE Carteira WITH loc_cCar IN cursor_4c_Boletos
                ENDCASE

                REPLACE NossoNum WITH loc_cNossoNum, ;
                        cTitulos WITH PADL(CHRTRAN(cursor_4c_Boletos.Titulos, "/", ""), 8, "0") IN cursor_4c_Boletos

                loc_cNome = PADR(IIF(EMPTY(cursor_4c_Boletos.Razaos), cursor_4c_Boletos.RClis, cursor_4c_Boletos.Razaos), 37)
                loc_cNome = PADR(CHRTRAN(loc_cNome, "/.-,", ""), 37)
                REPLACE NomeCli WITH loc_cNome IN cursor_4c_Boletos

                IF !(EMPTY(cursor_4c_Boletos.EndCobs) OR EMPTY(cursor_4c_Boletos.CepCobs) OR EMPTY(cursor_4c_Boletos.EstCobs) ;
                        OR EMPTY(cursor_4c_Boletos.BaiCobs) OR EMPTY(cursor_4c_Boletos.CidCobs))
                    REPLACE Endes WITH ALLTRIM(cursor_4c_Boletos.EndCobs), ;
                            Bairs WITH cursor_4c_Boletos.BaiCobs, ;
                            Ceps  WITH cursor_4c_Boletos.CepCobs, ;
                            Cidas WITH cursor_4c_Boletos.CidCobs, ;
                            Estas WITH cursor_4c_Boletos.EstCobs IN cursor_4c_Boletos
                ENDIF

                loc_cPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Instrus)), "00", cursor_4c_Convenio.Instrus), 2, "0")
                loc_cProt = IIF(THIS.this_nDiasProtestoConvenio = 0, 5, THIS.this_nDiasProtestoConvenio)
                loc_cProt = IIF(loc_cPri == "00", "00", PADL(ALLTRIM(STR(loc_cProt)), 2, "0"))
                loc_nMor  = IIF(EMPTY(cursor_4c_Convenio.Moras), 0.23, cursor_4c_Convenio.Moras)
                loc_cMora = STR(ROUND((cursor_4c_Boletos.Valos * loc_nMor) / 100, 2), 8, 2)
                loc_cInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(loc_cMora) + " AO DIA."
                loc_cInt2 = "PROTESTAR NO " + loc_cProt + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
                loc_cInt7 = IIF(THIS.this_cBancoConvenio == "237", ;
                    "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
                    "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")

                IF VARTYPE(cursor_4c_Convenio.MsgMulta) = "N" AND cursor_4c_Convenio.MsgMulta = 1
                    loc_cInt2 = ""
                ENDIF

                REPLACE Instr1 WITH loc_cInt1, ;
                        Instr2 WITH loc_cInt2, ;
                        Instr7 WITH loc_cInt7 IN cursor_4c_Boletos

                IF USED("cursor_4c_TmpPcOol")
                    USE IN cursor_4c_TmpPcOol
                ENDIF
                SELECT cursor_4c_Boletos
            ENDSCAN

            IF loc_lSucesso
                GO TOP IN cursor_4c_Boletos
                THIS.this_cCursorBoleto = "cursor_4c_Boletos"
            ELSE
                IF USED("cursor_4c_Boletos")
                    USE IN cursor_4c_Boletos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "SIGPRCNBBO.ImprimirBoleto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LimparImagensBarras - apaga os .bmp temporarios gerados por
    * ImprimirBoleto apos a impressao (igual ao legado - "Deleta as imagens
    * dos barras gerados" ao final de impboleto). Chamado pelo Form DEPOIS
    * do REPORT FORM do boleto.
    *==========================================================================
    FUNCTION LimparImagensBarras(par_cCursorBoletos)
        LOCAL loc_cArqBMP

        IF USED(par_cCursorBoletos)
            SELECT (par_cCursorBoletos)
            SCAN
                loc_cArqBMP = ADDBS(SYS(2023)) + ALLTRIM(NVL(EVALUATE(par_cCursorBoletos + ".ImgBarra"), ""))
                IF !EMPTY(ALLTRIM(NVL(EVALUATE(par_cCursorBoletos + ".ImgBarra"), ""))) AND FILE(loc_cArqBMP)
                    ERASE (loc_cArqBMP)
                ENDIF
            ENDSCAN
        ENDIF
    ENDFUNC

ENDDEFINE

