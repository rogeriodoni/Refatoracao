# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: teste_resultado.json nao gerado (exit code 0). VFP pode ter crashado antes de escrever resultado.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 18:47:43] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 18:47:43] [INFO] Config FPW: (nao fornecido)
[2026-08-22 18:47:43] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:47:43] [INFO] Timeout: 300 segundos
[2026-08-22 18:47:43] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3aavb1b0.prg
[2026-08-22 18:47:43] [INFO] Conteudo do wrapper:
[2026-08-22 18:47:43] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
QUIT

[2026-08-22 18:47:43] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3aavb1b0.prg
[2026-08-22 18:47:43] [INFO] VFP output esperado em: C:\4c\tasks\task494\vfp_output.txt
[2026-08-22 18:47:43] [INFO] Executando Visual FoxPro 9...
[2026-08-22 18:47:43] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3aavb1b0.prg
[2026-08-22 18:47:43] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3aavb1b0.prg
[2026-08-22 18:47:43] [INFO] Timeout configurado: 300 segundos
[2026-08-22 18:49:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 18:49:11] [INFO] VFP9 finalizado em 87.5984851 segundos
[2026-08-22 18:49:11] [INFO] Exit Code: 
[2026-08-22 18:49:11] [INFO] 
[2026-08-22 18:49:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 18:49:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3aavb1b0.prg
[2026-08-22 18:49:11] [INFO] 
[2026-08-22 18:49:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 18:49:11] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 18:49:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:49:11] [INFO] * Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:49:11] [INFO] 
[2026-08-22 18:49:11] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 18:49:11] [INFO] SET SAFETY OFF
[2026-08-22 18:49:11] [INFO] SET RESOURCE OFF
[2026-08-22 18:49:11] [INFO] SET TALK OFF
[2026-08-22 18:49:11] [INFO] SET NOTIFY OFF
[2026-08-22 18:49:11] [INFO] SYS(2335, 0)
[2026-08-22 18:49:11] [INFO] 
[2026-08-22 18:49:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:49:11] [INFO] QUIT
[2026-08-22 18:49:11] [INFO] 
[2026-08-22 18:49:11] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 18:49:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-22 18:51:13] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 18:51:13] [INFO] Config FPW: (nao fornecido)
[2026-08-22 18:51:13] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:51:13] [INFO] Timeout: 300 segundos
[2026-08-22 18:51:13] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_brbhup1t.prg
[2026-08-22 18:51:13] [INFO] Conteudo do wrapper:
[2026-08-22 18:51:13] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
QUIT

[2026-08-22 18:51:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_brbhup1t.prg
[2026-08-22 18:51:13] [INFO] VFP output esperado em: C:\4c\tasks\task494\vfp_output.txt
[2026-08-22 18:51:13] [INFO] Executando Visual FoxPro 9...
[2026-08-22 18:51:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_brbhup1t.prg
[2026-08-22 18:51:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_brbhup1t.prg
[2026-08-22 18:51:13] [INFO] Timeout configurado: 300 segundos
[2026-08-22 18:52:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 18:52:55] [INFO] VFP9 finalizado em 102.1178424 segundos
[2026-08-22 18:52:55] [INFO] Exit Code: 
[2026-08-22 18:52:55] [INFO] 
[2026-08-22 18:52:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 18:52:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_brbhup1t.prg
[2026-08-22 18:52:55] [INFO] 
[2026-08-22 18:52:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 18:52:55] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 18:52:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:52:55] [INFO] * Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:52:55] [INFO] 
[2026-08-22 18:52:55] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 18:52:55] [INFO] SET SAFETY OFF
[2026-08-22 18:52:55] [INFO] SET RESOURCE OFF
[2026-08-22 18:52:55] [INFO] SET TALK OFF
[2026-08-22 18:52:55] [INFO] SET NOTIFY OFF
[2026-08-22 18:52:55] [INFO] SYS(2335, 0)
[2026-08-22 18:52:55] [INFO] 
[2026-08-22 18:52:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:52:55] [INFO] QUIT
[2026-08-22 18:52:55] [INFO] 
[2026-08-22 18:52:55] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 18:52:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-22 18:54:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 18:54:17] [INFO] Config FPW: (nao fornecido)
[2026-08-22 18:54:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:54:17] [INFO] Timeout: 300 segundos
[2026-08-22 18:54:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4kp2yxof.prg
[2026-08-22 18:54:17] [INFO] Conteudo do wrapper:
[2026-08-22 18:54:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
QUIT

[2026-08-22 18:54:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4kp2yxof.prg
[2026-08-22 18:54:17] [INFO] VFP output esperado em: C:\4c\tasks\task494\vfp_output.txt
[2026-08-22 18:54:17] [INFO] Executando Visual FoxPro 9...
[2026-08-22 18:54:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4kp2yxof.prg
[2026-08-22 18:54:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4kp2yxof.prg
[2026-08-22 18:54:17] [INFO] Timeout configurado: 300 segundos
[2026-08-22 18:58:01] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 18:58:01] [INFO] VFP9 finalizado em 223.8251539 segundos
[2026-08-22 18:58:01] [INFO] Exit Code: 
[2026-08-22 18:58:01] [INFO] 
[2026-08-22 18:58:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 18:58:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4kp2yxof.prg
[2026-08-22 18:58:01] [INFO] 
[2026-08-22 18:58:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 18:58:01] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 18:58:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 18:58:01] [INFO] * Parameters: 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:58:01] [INFO] 
[2026-08-22 18:58:01] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 18:58:01] [INFO] SET SAFETY OFF
[2026-08-22 18:58:01] [INFO] SET RESOURCE OFF
[2026-08-22 18:58:01] [INFO] SET TALK OFF
[2026-08-22 18:58:01] [INFO] SET NOTIFY OFF
[2026-08-22 18:58:01] [INFO] SYS(2335, 0)
[2026-08-22 18:58:01] [INFO] 
[2026-08-22 18:58:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpag', 'C:\4c\tasks\task494', 'CRUD'
[2026-08-22 18:58:01] [INFO] QUIT
[2026-08-22 18:58:01] [INFO] 
[2026-08-22 18:58:01] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 18:58:01] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formpag.prg):
*==============================================================================
* Formpag.prg - Cadastro de Condicoes de Pagamento
* Entidade : pag
* Tabela   : SigOpFp (PK: fpags char(12))
* BO       : pagBO.prg
*==============================================================================

DEFINE CLASS Formpag AS FormBase

    Height      = 623
    Width       = 1000
    Caption     = "Cadastro de Condi" + CHR(231) + CHR(245) + "es de Pagamento"
    DataSession = 2
    ShowWindow = 1
    WindowType = 1

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("pagBO")
            IF ISNULL(THIS.this_oBusinessObject) OR VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar pagBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.InicializarForm: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_oPgf
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            loc_oPgf = THIS.pgf_4c_Paginas
            WITH loc_oPgf
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .PageCount = 2
                .Visible   = .T.
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            loc_oPgf.ActivePage = 1
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPage, loc_oCnt, loc_oCntSaida, loc_oCntEsp, loc_oGrd, loc_oCol
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(1)
            loc_oPage.Caption = "Lista"

            && --- Container de botoes CRUD padrao ---
            loc_oPage.AddObject("cnt_4c_Botoes", "Container")
            loc_oCnt = loc_oPage.cnt_4c_Botoes
            WITH loc_oCnt
                .Top       = 29
                .Left      = 542
                .Width     = 370
                .Height    = 85
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Incluir
                .Caption = "Incluir"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

            loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Alterar
                .Caption = "Alterar"
                .Top     = 5
                .Left    = 85
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Visualizar
                .Caption = "Visualizar"
                .Top     = 5
                .Left    = 165
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Caption = "Excluir"
                .Top     = 5
                .Left    = 245
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Buscar
                .Caption = "Buscar"
                .Top     = 5
                .Left    = 325
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            && --- Container botoes especiais ---
            loc_oPage.AddObject("cnt_4c_BotoesEspeciais", "Container")
            loc_oCntEsp = loc_oPage.cnt_4c_BotoesEspeciais
            WITH loc_oCntEsp
                .Top       = 79
                .Left      = 0
                .Width     = 780
                .Height    = 60
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCntEsp.AddObject("cmd_4c_BtnExpXML", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_BtnExpXML
                .Caption = "Exportar"
                .Top     = 5
                .Left    = 24
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_BtnExpXML, "Click", THIS, "BtnExportarClick")

            loc_oCntEsp.AddObject("cmd_4c_BtnImpXML", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_BtnImpXML
                .Caption = "Importar"
                .Top     = 5
                .Left    = 144
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_BtnImpXML, "Click", THIS, "BtnImportarClick")

            loc_oCntEsp.AddObject("cmd_4c_CmdCopia", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_CmdCopia
                .Caption = "Copiar"
                .Top     = 5
                .Left    = 264
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_CmdCopia, "Click", THIS, "BtnCopiarClick")

            loc_oCntEsp.AddObject("cmd_4c_CmdfpMin", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_CmdfpMin
                .Caption = "M" + CHR(237) + "nimo"
                .Top     = 5
                .Left    = 384
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_CmdfpMin, "Click", THIS, "BtnMinimoClick")

            loc_oCntEsp.AddObject("cmd_4c_Cmdfpdpar", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_Cmdfpdpar
                .Caption = "Desconto"
                .Top     = 5
                .Left    = 504
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_Cmdfpdpar, "Click", THIS, "BtnDescontoClick")

            loc_oCntEsp.AddObject("cmd_4c_Bot_BIN", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_Bot_BIN
                .Caption = "BIN"
                .Top     = 5
                .Left    = 624
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_Bot_BIN, "Click", THIS, "BtnBINClick")

            && --- Container saida canonico ---
            loc_oPage.AddObject("cnt_4c_Saida", "Container")
            loc_oCntSaida = loc_oPage.cnt_4c_Saida
            WITH loc_oCntSaida
                .Top       = 29
                .Left      = 917
                .Width     = 90
                .Height    = 85
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCntSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCntSaida.cmd_4c_Encerrar
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            && --- Grid ---
            loc_oPage.AddObject("grd_4c_Lista", "Grid")
            loc_oGrd = loc_oPage.grd_4c_Lista
            WITH loc_oGrd
                .Top          = 130
                .Left         = 26
                .Width        = 890
                .Height       = 490
                .RecordSource = "cursor_4c_Dados"
                .ReadOnly     = .T.
                .ColumnCount  = 5
                .HeaderHeight = 22
                .RowHeight    = 18
                .GridLines    = 1
                .Visible      = .T.
            ENDWITH

            loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.fpags"
            loc_oGrd.Column1.Width           = 100

            loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column2.ControlSource   = "cursor_4c_Dados.descrs"
            loc_oGrd.Column2.Width           = 250

            loc_oGrd.Column3.Header1.Caption = "Moeda"
            loc_oGrd.Column3.ControlSource   = "cursor_4c_Dados.moefpgs"
            loc_oGrd.Column3.Width           = 60

            loc_oGrd.Column4.Header1.Caption = "Dias"
            loc_oGrd.Column4.ControlSource   = "cursor_4c_Dados.dias"
            loc_oGrd.Column4.Width           = 50

            loc_oGrd.Column5.Header1.Caption = "T.Venc"
            loc_oGrd.Column5.ControlSource   = "cursor_4c_Dados.tvens"
            loc_oGrd.Column5.Width           = 60

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPage, loc_oCntSalva, loc_oCntSaida2, loc_oPgf2
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPage.Caption = "Dados"

            && --- Cabecalho: Descricao ---
            loc_oPage.AddObject("lbl_4c_Descrs", "Label")
            WITH loc_oPage.lbl_4c_Descrs
                .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top      = 20
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Descrs", "TextBox")
            WITH loc_oPage.txt_4c_Descrs
                .Top       = 16
                .Left      = 112
                .Width     = 220
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Titulo ---
            loc_oPage.AddObject("lbl_4c_TitFPags", "Label")
            WITH loc_oPage.lbl_4c_TitFPags
                .Caption  = "T" + CHR(237) + "tulo :"
                .Top      = 20
                .Left     = 338
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_TitFPags", "TextBox")
            WITH loc_oPage.txt_4c_TitFPags
                .Top       = 16
                .Left      = 380
                .Width     = 220
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Forma ---
            loc_oPage.AddObject("lbl_4c_Forma", "Label")
            WITH loc_oPage.lbl_4c_Forma
                .Caption  = "Forma :"
                .Top      = 20
                .Left     = 605
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Forma", "TextBox")
            WITH loc_oPage.txt_4c_Forma
                .Top       = 16
                .Left      = 650
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Codigo / Nfpags / ModPagto ---
            loc_oPage.AddObject("lbl_4c_Fpags", "Label")
            WITH loc_oPage.lbl_4c_Fpags
                .Caption  = "C" + CHR(243) + "digo :"
                .Top      = 53
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPage.txt_4c_Codigo
                .Top       = 53
                .Left      = 112
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Nfpags", "Label")
            WITH loc_oPage.lbl_4c_Nfpags
                .Caption  = "Nro :"
                .Top      = 53
                .Left     = 215
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Nfpag", "TextBox")
            WITH loc_oPage.txt_4c_Nfpag
                .Top       = 53
                .Left      = 248
                .Width     = 40
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Modpagto", "Label")
            WITH loc_oPage.lbl_4c_Modpagto
                .Caption  = "Modalidade :"
                .Top      = 53
                .Left     = 300
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Modalidade", "TextBox")
            WITH loc_oPage.txt_4c_Modalidade
                .Top       = 53
                .Left      = 385
                .Width     = 232
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Grupo/Conta/DConta (debito) ---
            loc_oPage.AddObject("lbl_4c_GrpDs", "Label")
            WITH loc_oPage.lbl_4c_GrpDs
                .Caption  = "Grupo Deb. :"
                .Top      = 91
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPage.txt_4c_Grupo
                .Top       = 91
                .Left      = 90
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_CtaDs", "Label")
            WITH loc_oPage.lbl_4c_CtaDs
                .Caption  = "Conta :"
                .Top      = 91
                .Left     = 178
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPage.txt_4c_Conta
                .Top       = 91
                .Left      = 220
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_DctaDs", "Label")
            WITH loc_oPage.lbl_4c_DctaDs
                .Caption  = "Descr. Conta :"
                .Top      = 91
                .Left     = 305
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Dconta", "TextBox")
            WITH loc_oPage.txt_4c_Dconta
                .Top       = 91
                .Left      = 390
                .Width     = 290
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- OptionGroup Conta Mov ---
            loc_oPage.AddObject("obj_4c_Opt_ContaMov", "OptionGroup")
            WITH loc_oPage.obj_4c_Opt_ContaMov
                .Top         = 90
                .Left        = 479
                .Width       = 283
                .Height      = 23
                .ButtonCount = 4
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "D"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "C"
                    .Left = 71
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "T"
                    .Left = 142
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Caption = "O"
                    .Left = 213
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Botoes Salvar/Cancelar ---
            loc_oPage.AddObject("cnt_4c_Salva", "Container")
            WITH loc_oPage.cnt_4c_Salva
                .Top    = 29
                .Left   = 542
                .Width  = 160
                .Height = 85
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
            WITH loc_oPage.cnt_4c_Salva.cmd_4c_Salvar
                .Caption = "Salvar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

            loc_oPage.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 85
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            && --- Container saida pagina Dados ---
            loc_oPage.AddObject("cnt_4c_Saida2", "Container")
            loc_oCntSaida2 = loc_oPage.cnt_4c_Saida2
            WITH loc_oCntSaida2
                .Top    = 29
                .Left   = 917
                .Width  = 90
                .Height = 85
            ENDWITH

            loc_oCntSaida2.AddObject("cmd_4c_Encerrar2", "CommandButton")
            WITH loc_oCntSaida2.cmd_4c_Encerrar2
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntSaida2.cmd_4c_Encerrar2, "Click", THIS, "BtnEncerrarClick")

            && --- Inner PageFrame: pgf_4c_Dados ---
            loc_oPage.AddObject("pgf_4c_Dados", "PageFrame")
            loc_oPgf2 = loc_oPage.pgf_4c_Dados
            WITH loc_oPgf2
                .Top       = 120
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height - 120 + 29
                .Tabs      = .T.
                .PageCount = 2
                .Visible   = .T.
            ENDWITH

            loc_oPgf2.Pages(1).Caption = "Geral"
            loc_oPgf2.Pages(2).Caption = "Cart" + CHR(227) + "o/TEF"

            THIS.CriarPaginaGeral(loc_oPgf2.Pages(1))
            THIS.CriarPaginaCartaoTEF(loc_oPgf2.Pages(2))

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPaginaDados: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarPaginaGeral(par_oPage)
    *==========================================================================
        LOCAL loc_oPage
        loc_oPage = par_oPage
        TRY
            && --- Linha 1: Entrada, Dias, Parcelas, Tipo Uso ---
            loc_oPage.AddObject("lbl_g_Entrada", "Label")
            WITH loc_oPage.lbl_g_Entrada
                .Caption  = "Entrada :"
                .Top      = 8
                .Left     = 93
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Entrada", "TextBox")
            WITH loc_oPage.txt_4c_Entrada
                .Top       = 4
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_InterDias", "Label")
            WITH loc_oPage.lbl_g_InterDias
                .Caption  = "Intervalo de Dias :"
                .Top      = 34
                .Left     = 49
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dias", "TextBox")
            WITH loc_oPage.txt_4c_Dias
                .Top       = 30
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Parcelas", "Label")
            WITH loc_oPage.lbl_g_Parcelas
                .Caption  = "N" + CHR(250) + "mero de Parcelas :"
                .Top      = 59
                .Left     = 36
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Parcelas", "TextBox")
            WITH loc_oPage.txt_4c_Parcelas
                .Top       = 55
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TipoUso", "Label")
            WITH loc_oPage.lbl_g_TipoUso
                .Caption  = "Tipo de Uso :"
                .Top      = 84
                .Left     = 75
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c___formas", "TextBox")
            WITH loc_oPage.txt_4c__formas
                .Top       = 80
                .Left      = 144
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_TipoUsoH", "Label")
            WITH loc_oPage.lbl_g_TipoUsoH
                .Caption  = "[P/R/A/S/I]"
                .Top      = 84
                .Left     = 244
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            && --- Situacao ---
            loc_oPage.AddObject("lbl_g_Situa", "Label")
            WITH loc_oPage.lbl_g_Situa
                .Caption  = "Situa" + CHR(231) + CHR(227) + "o :"
                .Top      = 84
                .Left     = 640
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__Situa", "TextBox")
            WITH loc_oPage.txt_4c__Situa
                .Top       = 80
                .Left      = 700
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_VencDesc", "Label")
            WITH loc_oPage.lbl_g_VencDesc
                .Caption  = "Tipo Vencimento :"
                .Top      = 109
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dvenc", "TextBox")
            WITH loc_oPage.txt_4c__dvenc
                .Top       = 105
                .Left      = 177
                .Width     = 127
                .Height    = 23
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_VENC", "TextBox")
            WITH loc_oPage.txt_4c_VENC
                .Top       = 105
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Info", "Label")
            WITH loc_oPage.lbl_g_Info
                .Caption  = "Info. Complementar :"
                .Top      = 134
                .Left     = 35
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dinfo", "TextBox")
            WITH loc_oPage.txt_4c__dinfo
                .Top       = 130
                .Left      = 177
                .Width     = 127
                .Height    = 23
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_INFO", "TextBox")
            WITH loc_oPage.txt_4c_INFO
                .Top       = 130
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_DadObrig", "Label")
            WITH loc_oPage.lbl_g_DadObrig
                .Caption  = "Dados Obrigat" + CHR(243) + "rios :"
                .Top      = 159
                .Left     = 39
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ChqObrig", "TextBox")
            WITH loc_oPage.txt_4c_ChqObrig
                .Top       = 155
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_DadObrigH", "Label")
            WITH loc_oPage.lbl_g_DadObrigH
                .Caption  = "[S/N]"
                .Top      = 159
                .Left     = 181
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_EmpLanc", "Label")
            WITH loc_oPage.lbl_g_EmpLanc
                .Caption  = "Somente p/ Empresa :"
                .Top      = 184
                .Left     = 32
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_EmpLanc", "TextBox")
            WITH loc_oPage.txt_4c_EmpLanc
                .Top       = 180
                .Left      = 144
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_GrupoEmp", "Label")
            WITH loc_oPage.lbl_g_GrupoEmp
                .Caption  = "Grupo Empresarial :"
                .Top      = 210
                .Left     = 44
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_GrupoEmp", "TextBox")
            WITH loc_oPage.txt_4c_GrupoEmp
                .Top       = 206
                .Left      = 144
                .Width     = 115
                .Height    = 23
                .MaxLength = 15
                .Visible   = .T.
            ENDWITH

            && --- Mascara / Valor ---
            loc_oPage.AddObject("lbl_g_Mascara", "Label")
            WITH loc_oPage.lbl_g_Mascara
                .Caption  = "M" + CHR(225) + "scara :"
                .Top      = 236
                .Left     = 91
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Picture", "TextBox")
            WITH loc_oPage.txt_4c_Picture
                .Top       = 232
                .Left      = 144
                .Width     = 150
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Valor", "Label")
            WITH loc_oPage.lbl_g_Valor
                .Caption  = "Valor :"
                .Top      = 261
                .Left     = 107
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Valor", "TextBox")
            WITH loc_oPage.txt_4c_Valor
                .Top       = 257
                .Left      = 144
                .Width     = 95
                .Height    = 23
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Desconto", "Label")
            WITH loc_oPage.lbl_g_Desconto
                .Caption  = "Desconto Venda :"
                .Top      = 286
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Desconto", "TextBox")
            WITH loc_oPage.txt_4c_Desconto
                .Top       = 282
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_DescontoH", "Label")
            WITH loc_oPage.lbl_g_DescontoH
                .Caption  = "[%]"
                .Top      = 286
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Comissao", "Label")
            WITH loc_oPage.lbl_g_Comissao
                .Caption  = "Comiss" + CHR(227) + "o :"
                .Top      = 311
                .Left     = 86
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Comissao", "TextBox")
            WITH loc_oPage.txt_4c_Comissao
                .Top       = 307
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_ComissaoH", "Label")
            WITH loc_oPage.lbl_g_ComissaoH
                .Caption  = "[%]"
                .Top      = 311
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Encargos", "Label")
            WITH loc_oPage.lbl_g_Encargos
                .Caption  = "Enc. Financeiros :"
                .Top      = 336
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Encargos", "TextBox")
            WITH loc_oPage.txt_4c_Encargos
                .Top       = 332
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_EncargosH", "Label")
            WITH loc_oPage.lbl_g_EncargosH
                .Caption  = "[%]"
                .Top      = 336
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_PVaria", "Label")
            WITH loc_oPage.lbl_g_PVaria
                .Caption  = "Varia" + CHR(231) + CHR(227) + "o :"
                .Top      = 361
                .Left     = 90
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_PVaria", "TextBox")
            WITH loc_oPage.txt_4c_PVaria
                .Top       = 357
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_PVariaH", "Label")
            WITH loc_oPage.lbl_g_PVariaH
                .Caption  = "[%]"
                .Top      = 361
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Indice", "Label")
            WITH loc_oPage.lbl_g_Indice
                .Caption  = "Indice Cota" + CHR(231) + CHR(227) + "o :"
                .Top      = 386
                .Left     = 59
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Indice", "TextBox")
            WITH loc_oPage.txt_4c_Indice
                .Top       = 382
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 6
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TaxJuros", "Label")
            WITH loc_oPage.lbl_g_TaxJuros
                .Caption  = "Taxa de Juros :"
                .Top      = 411
                .Left     = 63
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_TaxJuros", "TextBox")
            WITH loc_oPage.txt_4c_TaxJuros
                .Top       = 407
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_TaxJurosH", "Label")
            WITH loc_oPage.lbl_g_TaxJurosH
                .Caption  = "[% dia]"
                .Top      = 411
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TolFecCx", "Label")
            WITH loc_oPage.lbl_g_TolFecCx
                .Caption  = "Toler" + CHR(226) + "ncia Fec. Caixa :"
                .Top      = 436
                .Left     = 28
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_TolFecCx", "TextBox")
            WITH loc_oPage.txt_4c_TolFecCx
                .Top       = 432
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH

            && --- Banco / Agencia / NConta ---
            loc_oPage.AddObject("lbl_g_Banco", "Label")
            WITH loc_oPage.lbl_g_Banco
                .Caption  = "Banco"
                .Top      = 182
                .Left     = 765
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Bancos", "TextBox")
            WITH loc_oPage.txt_4c_Bancos
                .Top       = 197
                .Left      = 765
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Agencia", "Label")
            WITH loc_oPage.lbl_g_Agencia
                .Caption  = "Ag" + CHR(234) + "ncia"
                .Top      = 182
                .Left     = 810
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Agencias", "TextBox")
            WITH loc_oPage.txt_4c_Agencias
                .Top       = 197
                .Left      = 810
                .Width     = 38
                .Height    = 21
                .MaxLength = 4
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_NConta", "Label")
            WITH loc_oPage.lbl_g_NConta
                .Caption  = "Conta"
                .Top      = 182
                .Left     = 861
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_NContas", "TextBox")
            WITH loc_oPage.txt_4c_NContas
                .Top       = 197
                .Left      = 861
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            && --- Especie NF ---
            loc_oPage.AddObject("lbl_g_EspecieNfs", "Label")
            WITH loc_oPage.lbl_g_EspecieNfs
                .Caption = "Esp" + CHR(233) + "cie :"
                .Top     = 396
                .Left    = 715
                .Width   = 45
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_EspecieNfs", "TextBox")
            WITH loc_oPage.txt_4c_EspecieNfs
                .Top       = 393
                .Left      = 765
                .Width     = 52
                .Height    = 21
                .MaxLength = 6
                .Visible   = .T.
            ENDWITH

            && --- OptionGroups coluna direita (479) ---
            loc_oPage.AddObject("lbl_g_ValPend", "Label")
            WITH loc_oPage.lbl_g_ValPend
                .Caption  = "Valor Pendente :"
                .Top      = 8
                .Left     = 393
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_valpend", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_valpend
                .Top         = 4
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_BxComis", "Label")
            WITH loc_oPage.lbl_g_BxComis
                .Caption  = "Credita Comiss" + CHR(227) + "o :"
                .Top      = 34
                .Left     = 383
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_BxComis", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_BxComis
                .Top         = 30
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Emichqs", "Label")
            WITH loc_oPage.lbl_g_Emichqs
                .Caption  = "Emite Cheque :"
                .Top      = 59
                .Left     = 400
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_Emichqs", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_Emichqs
                .Top         = 55
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpChqs", "Label")
            WITH loc_oPage.lbl_g_ImpChqs
                .Caption  = "Imprime Cheque :"
                .Top      = 84
                .Left     = 388
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_ImpChqs", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_ImpChqs
                .Top         = 80
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_OptFechm", "Label")
            WITH loc_oPage.lbl_g_OptFechm
                .Caption  = "Total Fechamento :"
                .Top      = 109
                .Left     = 380
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptFechm", "OptionGroup")
            WITH loc_oPage.obj_4c_OptFechm
                .Top         = 105
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg7", "Label")
            WITH loc_oPage.lbl_g_Optg7
                .Caption  = "M" + CHR(234) + "s Fechado :"
                .Top      = 134
                .Left     = 403
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup7", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup7
                .Top         = 130
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg10", "Label")
            WITH loc_oPage.lbl_g_Optg10
                .Caption  = "Agente Cobrador :"
                .Top      = 159
                .Left     = 383
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup10", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup10
                .Top         = 155
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Trocos", "Label")
            WITH loc_oPage.lbl_g_Trocos
                .Caption  = "Troco :"
                .Top      = 184
                .Left     = 439
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptTrocos", "OptionGroup")
            WITH loc_oPage.obj_4c_OptTrocos
                .Top         = 180
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg5", "Label")
            WITH loc_oPage.lbl_g_Optg5
                .Caption  = "Baixa Comiss" + CHR(227) + "o no Chq :"
                .Top      = 209
                .Left     = 355
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup5", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup5
                .Top         = 205
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg2", "Label")
            WITH loc_oPage.lbl_g_Optg2
                .Caption  = "Baixa Valor :"
                .Top      = 234
                .Left     = 413
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup2
                .Top         = 230
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg8", "Label")
            WITH loc_oPage.lbl_g_Optg8
                .Caption  = "Acumula :"
                .Top      = 259
                .Left     = 426
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup8", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup8
                .Top         = 255
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg3", "Label")
            WITH loc_oPage.lbl_g_Optg3
                .Caption  = "Itens Obrigat" + CHR(243) + "rios :"
                .Top      = 284
                .Left     = 367
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup3", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup3
                .Top         = 280
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg4", "Label")
            WITH loc_oPage.lbl_g_Optg4
                .Caption  = "Aprova" + CHR(231) + CHR(227) + "o :"
                .Top      = 309
                .Left     = 414
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup4", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup4
                .Top         = 305
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg12", "Label")
            WITH loc_oPage.lbl_g_Optg12
                .Caption  = "Detalha Fec. Caixa :"
                .Top      = 334
                .Left     = 375
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup12", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup12
                .Top         = 330
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpBols", "Label")
            WITH loc_oPage.lbl_g_ImpBols
                .Caption  = "Imprime Boleto Banc" + CHR(225) + "rio :"
                .Top      = 360
                .Left     = 351
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptImpBols", "OptionGroup")
            WITH loc_oPage.obj_4c_OptImpBols
                .Top         = 356
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpDups", "Label")
            WITH loc_oPage.lbl_g_ImpDups
                .Caption  = "Imprime Duplicata :"
                .Top      = 385
                .Left     = 381
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptImpDups", "OptionGroup")
            WITH loc_oPage.obj_4c_OptImpDups
                .Top         = 381
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg13", "Label")
            WITH loc_oPage.lbl_g_Optg13
                .Caption  = "Bloqueia Tab.Desconto :"
                .Top      = 411
                .Left     = 356
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup13", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup13
                .Top         = 407
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Liscongv", "Label")
            WITH loc_oPage.lbl_g_Liscongv
                .Caption  = "Exibe na Consulta Global :"
                .Top      = 437
                .Left     = 348
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Opt_Liscongv", "OptionGroup")
            WITH loc_oPage.obj_4c_Opt_Liscongv
                .Top         = 433
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Coluna 765 - Calculos ---
            loc_oPage.AddObject("lbl_g_CalcVenc", "Label")
            WITH loc_oPage.lbl_g_CalcVenc
                .Caption = "Calcula Vencimento :"
                .Top     = 8
                .Left    = 661
                .Width   = 101
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPage.obj_4c_Fwoption1
                .Top         = 4
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 115
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_CopChq", "Label")
            WITH loc_oPage.lbl_g_CopChq
                .Caption  = "C" + CHR(243) + "pia de Cheque :"
                .Top      = 34
                .Left     = 671
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup11", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup11
                .Top         = 30
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 115
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_LeitChq", "Label")
            WITH loc_oPage.lbl_g_LeitChq
                .Caption = "Leitura de Cheque :"
                .Top     = 59
                .Left    = 665
                .Width   = 97
                .Height  = 15
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptTpLeituras", "OptionGroup")
            WITH loc_oPage.obj_4c_OptTpLeituras
                .Top         = 55
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_OpcaoSNA", "Label")
            WITH loc_oPage.lbl_g_OpcaoSNA
                .Caption  = "Op" + CHR(231) + CHR(227) + "o :"
                .Top      = 84
                .Left     = 722
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OpcaoSNA", "OptionGroup")
            WITH loc_oPage.obj_4c_OpcaoSNA
                .Top         = 80
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Autentica", "Label")
            WITH loc_oPage.lbl_g_Autentica
                .Caption  = "Autentica" + CHR(231) + CHR(227) + "o :"
                .Top      = 109
                .Left     = 690
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup6", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup6
                .Top         = 105
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Observa", "Label")
            WITH loc_oPage.lbl_g_Observa
                .Caption  = "Observa" + CHR(231) + CHR(227) + "o :"
                .Top      = 134
                .Left     = 695
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptObserva", "OptionGroup")
            WITH loc_oPage.obj_4c_OptObserva
                .Top         = 130
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_emichqs2", "Label")
            WITH loc_oPage.lbl_g_emichqs2
                .Caption  = "Emiss" + CHR(227) + "o de Cheques :"
                .Top      = 201
                .Left     = 655
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup1
                .Top         = 155
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpCpChqs", "Label")
            WITH loc_oPage.lbl_g_ImpCpChqs
                .Caption  = "Imp. Cert. Cr" + CHR(233) + "dito :"
                .Top      = 159
                .Left     = 665
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg14", "Label")
            WITH loc_oPage.lbl_g_Optg14
                .Caption  = "Contabiliza Comiss" + CHR(227) + "o :"
                .Top      = 235
                .Left     = 653
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup14", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup14
                .Top         = 231
                .Left        = 765
                .Width       = 230
                .Height      = 63
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 0
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 0
                    .Top = 21
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 0
                    .Top = 42
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg15", "Label")
            WITH loc_oPage.lbl_g_Optg15
                .Caption  = "Checa Lim. Cr" + CHR(233) + "dito da Conta :"
                .Top      = 299
                .Left     = 616
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup15", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup15
                .Top         = 296
                .Left        = 765
                .Width       = 92
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 47
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg17", "Label")
            WITH loc_oPage.lbl_g_Optg17
                .Caption  = "Bloquia Uso B" + CHR(244) + "nus :"
                .Top      = 324
                .Left     = 666
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup17", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup17
                .Top         = 321
                .Left        = 765
                .Width       = 92
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 47
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg16", "Label")
            WITH loc_oPage.lbl_g_Optg16
                .Caption  = "Bloqueia Altera" + CHR(231) + CHR(227) + "o no Vcto :"
                .Top      = 349
                .Left     = 625
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup16", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup16
                .Top         = 346
                .Left        = 765
                .Width       = 230
                .Height      = 45
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 0
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 0
                    .Top = 15
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 0
                    .Top = 30
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CriarPaginaGeral: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarPaginaCartaoTEF(par_oPage)
    *==========================================================================
        LOCAL loc_oPage
        loc_oPage = par_oPage
        TRY
            && --- Texto Financiamento (EditBox) ---
            loc_oPage.AddObject("lbl_t_TxtFinanc", "Label")
            WITH loc_oPage.lbl_t_TxtFinanc
                .Caption  = "Texto Financiamento"
                .Top      = 5
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_EdtTxtFinanc", "EditBox")
            WITH loc_oPage.obj_4c_EdtTxtFinanc
                .Top     = 19
                .Left    = 520
                .Width   = 467
                .Height  = 142
                .Visible = .T.
            ENDWITH

            && --- Grupo/Conta credito cartao ---
            loc_oPage.AddObject("lbl_t_Grupo2", "Label")
            WITH loc_oPage.lbl_t_Grupo2
                .Caption  = "Grupo Cr" + CHR(233) + "d. :"
                .Top      = 175
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Grupo2", "TextBox")
            WITH loc_oPage.txt_4c_Grupo2
                .Top       = 172
                .Left      = 590
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Contao", "Label")
            WITH loc_oPage.lbl_t_Contao
                .Caption  = "Conta :"
                .Top      = 175
                .Left     = 680
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Contao", "TextBox")
            WITH loc_oPage.txt_4c_Contao
                .Top       = 172
                .Left      = 720
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Dcontao", "Label")
            WITH loc_oPage.lbl_t_Dcontao
                .Caption  = "Descr. :"
                .Top      = 175
                .Left     = 810
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dcontao", "TextBox")
            WITH loc_oPage.txt_4c_Dcontao
                .Top       = 172
                .Left      = 850
                .Width     = 130
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- Grupo/Conta taxa cartao ---
            loc_oPage.AddObject("lbl_t_GrTxCart", "Label")
            WITH loc_oPage.lbl_t_GrTxCart
                .Caption  = "Gr.Taxa Cart" + CHR(227) + "o :"
                .Top      = 200
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_GrTxCart", "TextBox")
            WITH loc_oPage.txt_4c_GrTxCart
                .Top       = 197
                .Left      = 610
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_CnTxCart", "Label")
            WITH loc_oPage.lbl_t_CnTxCart
                .Caption  = "Conta :"
                .Top      = 200
                .Left     = 700
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_CnTxCart", "TextBox")
            WITH loc_oPage.txt_4c_CnTxCart
                .Top       = 197
                .Left      = 740
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_DCnTxCart", "Label")
            WITH loc_oPage.lbl_t_DCnTxCart
                .Caption  = "Descr. :"
                .Top      = 200
                .Left     = 830
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_DCnTxCart", "TextBox")
            WITH loc_oPage.txt_4c_DCnTxCart
                .Top       = 197
                .Left      = 870
                .Width     = 110
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- Descricao Cartao ---
            loc_oPage.AddObject("lbl_t_Dcarts", "Label")
            WITH loc_oPage.lbl_t_Dcarts
                .Caption  = "Descri" + CHR(231) + CHR(227) + "o Cart" + CHR(227) + "o :"
                .Top      = 93
                .Left     = 74
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dcarts", "TextBox")
            WITH loc_oPage.txt_4c__dcarts
                .Top       = 90
                .Left      = 175
                .Width     = 200
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Carauts ---
            loc_oPage.AddObject("lbl_t_Carauts", "Label")
            WITH loc_oPage.lbl_t_Carauts
                .Caption  = "[1]Lojista / [2]Administradora / [E]scolher"
                .Top      = 198
                .Left     = 198
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__carauts", "TextBox")
            WITH loc_oPage.txt_4c__carauts
                .Top       = 195
                .Left      = 144
                .Width     = 50
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            && --- Maquina Automatica ---
            loc_oPage.AddObject("lbl_t_Autotef", "Label")
            WITH loc_oPage.lbl_t_Autotef
                .Caption  = "M" + CHR(225) + "quina Autom" + CHR(225) + "tica :"
                .Top      = 121
                .Left     = 59
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            && --- Intervalo de Parcelas ---
            loc_oPage.AddObject("lbl_t_ParIni", "Label")
            WITH loc_oPage.lbl_t_ParIni
                .Caption  = "Intervalo de Parcelas de :"
                .Top      = 121
                .Left     = 257
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ParIni", "TextBox")
            WITH loc_oPage.txt_4c_ParIni
                .Top       = 118
                .Left      = 390
                .Width     = 30
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_A", "Label")
            WITH loc_oPage.lbl_t_A
                .Caption  = CHR(224)
                .Top      = 121
                .Left     = 426
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ParFin", "TextBox")
            WITH loc_oPage.txt_4c_ParFin
                .Top       = 118
                .Left      = 435
                .Width     = 30
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            && --- Bandeira ---
            loc_oPage.AddObject("lbl_t_Band", "Label")
            WITH loc_oPage.lbl_t_Band
                .Caption  = "Bandeira :"
                .Top      = 146
                .Left     = 332
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Band", "TextBox")
            WITH loc_oPage.txt_4c_Band
                .Top       = 143
                .Left      = 390
                .Width     = 100
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            && --- Taxa Cartao ---
            loc_oPage.AddObject("lbl_t_Taxa", "Label")
            WITH loc_oPage.lbl_t_Taxa
                .Caption  = "Taxa Cart" + CHR(227) + "o :"
                .Top      = 146
                .Left     = 96
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Taxa", "TextBox")
            WITH loc_oPage.txt_4c_Taxa
                .Top       = 143
                .Left      = 163
                .Width     = 60
                .Height    = 21
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH

            && --- Prazo Para Pagamento ---
            loc_oPage.AddObject("lbl_t_Prazo", "Label")
            WITH loc_oPage.lbl_t_Prazo
                .Caption  = "Prazo Para Pagamento :"
                .Top      = 172
                .Left     = 47
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Prazo", "TextBox")
            WITH loc_oPage.txt_4c_Prazo
                .Top       = 169
                .Left      = 163
                .Width     = 50
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            && --- Valor Minimo Parcela ---
            loc_oPage.AddObject("lbl_t_VlrMinPar", "Label")
            WITH loc_oPage.lbl_t_VlrMinPar
                .Caption  = "Vlr. M" + CHR(237) + "n. Parcela :"
                .Top      = 220
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_VlrMinPar", "TextBox")
            WITH loc_oPage.txt_4c_VlrMinPar
                .Top       = 217
                .Left      = 163
                .Width     = 80
                .Height    = 21
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            && --- DigCartao, Garantia, Saque, CDC, Hists ---
            loc_oPage.AddObject("lbl_t_DigCartao", "Label")
            WITH loc_oPage.lbl_t_DigCartao
                .Caption  = "Dig. Cart" + CHR(227) + "o :"
                .Top      = 250
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_DigCartao", "TextBox")
            WITH loc_oPage.txt_4c_DigCartao
                .Top       = 247
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_DigCartH", "Label")
            WITH loc_oPage.lbl_t_DigCartH
                .Caption  = "[S/N]"
                .Top      = 250
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Garantia", "Label")
            WITH loc_oPage.lbl_t_Garantia
                .Caption  = "Garantia :"
                .Top      = 276
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Garantia", "TextBox")
            WITH loc_oPage.txt_4c_Garantia
                .Top       = 273
                .Left      = 115
                .Width     = 50
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_GarH", "Label")
            WITH loc_oPage.lbl_t_GarH
                .Caption  = "[S/N]"
                .Top      = 276
                .Left     = 171
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Saque", "Label")
            WITH loc_oPage.lbl_t_Saque
                .Caption  = "Saque :"
                .Top      = 302
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Saque", "TextBox")
            WITH loc_oPage.txt_4c_Saque
                .Top       = 299
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_SaqH", "Label")
            WITH loc_oPage.lbl_t_SaqH
                .Caption  = "[S/N]"
                .Top      = 302
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_CDC", "Label")
            WITH loc_oPage.lbl_t_CDC
                .Caption  = "CDC :"
                .Top      = 328
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_CDC", "TextBox")
            WITH loc_oPage.txt_4c_CDC
                .Top       = 325
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_CDCH", "Label")
            WITH loc_oPage.lbl_t_CDCH
                .Caption  = "[S/N]"
                .Top      = 328
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Hists", "Label")
            WITH loc_oPage.lbl_t_Hists
                .Caption  = "Hist" + CHR(243) + "rico :"
                .Top      = 355
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Hists", "TextBox")
            WITH loc_oPage.txt_4c_Hists
                .Top       = 352
                .Left      = 115
                .Width     = 200
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Adquirente, Finalz, Dfinalz ---
            loc_oPage.AddObject("lbl_t_Adquire", "Label")
            WITH loc_oPage.lbl_t_Adquire
                .Caption  = "Adquirente :"
                .Top      = 365
                .Left     = 598
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Adquire", "TextBox")
            WITH loc_oPage.txt_4c_Adquire
                .Top       = 362
                .Left      = 670
                .Width     = 80
                .Height    = 21
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Finalz", "Label")
            WITH loc_oPage.lbl_t_Finalz
                .Caption  = "Finalizadora Cupom Fiscal :"
                .Top      = 290
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Finalz", "TextBox")
            WITH loc_oPage.txt_4c_Finalz
                .Top       = 287
                .Left      = 670
                .Width     = 24
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dfinalz", "TextBox")
            WITH loc_oPage.txt_4c_Dfinalz
                .Top       = 287
                .Left      = 696
                .Width     = 100
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Cupom", "Label")
            WITH loc_oPage.lbl_t_Cupom
                .Caption  = "Cupom :"
                .Top      = 340
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Cupom", "TextBox")
            WITH loc_oPage.txt_4c_Cupom
                .Top       = 337
                .Left      = 590
                .Width     = 60
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Estab", "Label")
            WITH loc_oPage.lbl_t_Estab
                .Caption  = "C" + CHR(243) + "digo do Estabelecimento :"
                .Top      = 342
                .Left     = 522
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Estab", "TextBox")
            WITH loc_oPage.txt_4c_Estab
                .Top       = 355
                .Left      = 650
                .Width     = 60
                .Height    = 21
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Item", "Label")
            WITH loc_oPage.lbl_t_Item
                .Caption  = "Item :"
                .Top      = 380
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Item", "TextBox")
            WITH loc_oPage.txt_4c_Item
                .Top       = 377
                .Left      = 590
                .Width     = 80
                .Height    = 21
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Financ", "Label")
            WITH loc_oPage.lbl_t_Financ
                .Caption  = "Financiamento :"
                .Top      = 355
                .Left     = 87
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_TipoCartao", "Label")
            WITH loc_oPage.lbl_t_TipoCartao
                .Caption = "[C]r" + CHR(233) + "dito / [D]" + CHR(233) + "bito / [F]ininvest / [P]Cons.CDC Deb / [O]Cons CDC Cred"
                .Top     = 218
                .Left    = 198
                .Width   = 199
                .Height  = 24
                .Visible = .T.
            ENDWITH

            && OptionGroups TEF
            loc_oPage.AddObject("lbl_t_Optg2pg2", "Label")
            WITH loc_oPage.lbl_t_Optg2pg2
                .Caption  = "Local de Pesquisa do Cheque :"
                .Top      = 315
                .Left     = 512
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup2_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup2_p2
                .Top         = 386
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_CompVinc", "Label")
            WITH loc_oPage.lbl_t_CompVinc
                .Caption  = "Comprovante Vinculado :"
                .Top      = 240
                .Left     = 538
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup1_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup1_p2
                .Top         = 237
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Espelhos P2 de Page1 (somente exibicao, Enabled=.F.) ---
            loc_oPage.AddObject("lbl_t_Optg12_p2", "Label")
            WITH loc_oPage.lbl_t_Optg12_p2
                .Caption  = "Det. Fec. Cx :"
                .Top      = 407
                .Left     = 30
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup12_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup12_p2
                .Top         = 403
                .Left        = 170
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_Optg4_p2", "Label")
            WITH loc_oPage.lbl_t_Optg4_p2
                .Caption  = "Aprova" + CHR(231) + CHR(227) + "o :"
                .Top      = 415
                .Left     = 615
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup4_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup4_p2
                .Top         = 411
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_Optg3_p2", "Label")
            WITH loc_oPage.lbl_t_Optg3_p2
                .Caption  = "Itens Obrig. :"
                .Top      = 439
                .Left     = 615
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup3_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup3_p2
                .Top         = 435
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CriarPaginaCartaoTEF: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oConteiner)
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        TRY
            FOR loc_nI = 1 TO par_oConteiner.ControlCount
                loc_oCtrl = par_oConteiner.Controls(loc_nI)
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    IF !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_botoes", "cnt_4c_salva")
                        loc_oCtrl.Visible = .T.
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    IF loc_oCtrl.Visible AND !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_botoes", "cnt_4c_salva")
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro("Erro em TornarControlesVisiveis: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_oPgf1, loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            WITH THIS.this_oBusinessObject
                && Cabecalho
                .this_cFpags     = ALLTRIM(loc_oPage2.txt_4c_Codigo.Value)
                .this_cDescrs    = ALLTRIM(loc_oPage2.txt_4c_Descrs.Value)
                .this_cTitfpags  = ALLTRIM(loc_oPage2.txt_4c_TitFPags.Value)
                .this_cFormas    = ALLTRIM(loc_oPage2.txt_4c_Forma.Value)
                .this_cNfpags    = VAL(ALLTRIM(loc_oPage2.txt_4c_Nfpag.Value))
                .this_cModpagto  = ALLTRIM(loc_oPage2.txt_4c_Modalidade.Value)
                .this_cGrupods   = ALLTRIM(loc_oPage2.txt_4c_Grupo.Value)
                .this_cContads   = ALLTRIM(loc_oPage2.txt_4c_Conta.Value)
                .this_cDcontads  = ALLTRIM(loc_oPage2.txt_4c_Dconta.Value)
                .this_nOrides    = loc_oPage2.obj_4c_Opt_ContaMov.Value - 1

                && Pagina Geral
                .this_nEntradas  = ALLTRIM(loc_oP1.txt_4c_Entrada.Value)
                .this_nDias      = ALLTRIM(loc_oP1.txt_4c_Dias.Value)
                .this_nFparcs    = ALLTRIM(loc_oP1.txt_4c_Parcelas.Value)
                .this_cMoefpgs   = ALLTRIM(loc_oP1.txt_4c___formas.Value)
                .this_cSituas    = ALLTRIM(loc_oP1.txt_4c__Situa.Value)
                .this_cTvens     = ALLTRIM(loc_oP1.txt_4c_VENC.Value)
                .this_cInfos     = ALLTRIM(loc_oP1.txt_4c_INFO.Value)
                .this_cColdados  = ALLTRIM(loc_oP1.txt_4c_ChqObrig.Value)
                .this_cEmps      = ALLTRIM(loc_oP1.txt_4c_EmpLanc.Value)
                .this_cGrupoemp  = ALLTRIM(loc_oP1.txt_4c_GrupoEmp.Value)
                .this_cCpictures = ALLTRIM(loc_oP1.txt_4c_Picture.Value)
                .this_nVlrfpgs   = ALLTRIM(loc_oP1.txt_4c_Valor.Value)
                .this_nDescs     = ALLTRIM(loc_oP1.txt_4c_Desconto.Value)
                .this_nFpcomiss  = ALLTRIM(loc_oP1.txt_4c_Comissao.Value)
                .this_nEncargos  = ALLTRIM(loc_oP1.txt_4c_Encargos.Value)
                .this_nPvarias   = ALLTRIM(loc_oP1.txt_4c_PVaria.Value)
                .this_nIndices   = ALLTRIM(loc_oP1.txt_4c_Indice.Value)
                .this_nTaxjuros  = ALLTRIM(loc_oP1.txt_4c_TaxJuros.Value)
                .this_nTolfcxs   = ALLTRIM(loc_oP1.txt_4c_TolFecCx.Value)
                .this_cBancos    = ALLTRIM(loc_oP1.txt_4c_Bancos.Value)
                .this_cAgencias  = ALLTRIM(loc_oP1.txt_4c_Agencias.Value)
                .this_cNcontas   = ALLTRIM(loc_oP1.txt_4c_NContas.Value)
                .this_cEspecies  = ALLTRIM(loc_oP1.txt_4c_EspecieNfs.Value)
                .this_nValpends  = loc_oP1.obj_4c_Op_valpend.Value - 1
                .this_nBxcomis   = loc_oP1.obj_4c_Op_BxComis.Value - 1
                .this_nEmichqs   = loc_oP1.obj_4c_Op_Emichqs.Value - 1
                .this_nImpchqs   = loc_oP1.obj_4c_Op_ImpChqs.Value - 1
                .this_nImpbols   = loc_oP1.obj_4c_OptImpBols.Value - 1
                .this_nImpdups   = loc_oP1.obj_4c_OptImpDups.Value - 1
                .this_nBlqtabds  = loc_oP1.obj_4c_Optiongroup13.Value - 1
                .this_nLiscongv  = loc_oP1.obj_4c_Opt_Liscongv.Value - 1
                .this_nMesfec    = loc_oP1.obj_4c_Optiongroup7.Value - 1
                .this_nAgcobs    = loc_oP1.obj_4c_Optiongroup10.Value - 1
                .this_nTrocos    = loc_oP1.obj_4c_OptTrocos.Value - 1
                .this_nBxcomchqs = loc_oP1.obj_4c_Optiongroup5.Value - 1
                .this_nBaixas    = loc_oP1.obj_4c_Optiongroup2.Value - 1
                .this_nAcumulas  = loc_oP1.obj_4c_Optiongroup8.Value - 1
                .this_nItemobrigs = loc_oP1.obj_4c_Optiongroup3.Value - 1
                .this_nAprovas   = loc_oP1.obj_4c_Optiongroup4.Value - 1
                .this_nDetFecCxs = loc_oP1.obj_4c_Optiongroup12.Value - 1
                .this_nOptcredcta = loc_oP1.obj_4c_Fwoption1.Value - 1
                .this_nTpcheques = loc_oP1.obj_4c_Optiongroup11.Value - 1
                .this_nTpvencs   = loc_oP1.obj_4c_OptTpLeituras.Value - 1
                .this_nOpcsnas   = loc_oP1.obj_4c_OpcaoSNA.Value - 1
                .this_nAutenticas = loc_oP1.obj_4c_Optiongroup6.Value - 1
                .this_nObs       = loc_oP1.obj_4c_OptObserva.Value - 1
                .this_nGavetas   = loc_oP1.obj_4c_Optiongroup1.Value - 1
                .this_nRelmetvend = loc_oP1.obj_4c_Optiongroup14.Value - 1
                .this_nChklimcre = loc_oP1.obj_4c_Optiongroup15.Value - 1
                .this_nRelsomsub = loc_oP1.obj_4c_Optiongroup17.Value - 1
                .this_nBlqvctopar = loc_oP1.obj_4c_Optiongroup16.Value - 1
                .this_nImpbols   = loc_oP1.obj_4c_OptFechm.Value - 1

                && Pagina Cartao/TEF
                .this_cMfinancs  = loc_oP2.obj_4c_EdtTxtFinanc.Value
                .this_cGrupoos   = ALLTRIM(loc_oP2.txt_4c_Grupo2.Value)
                .this_cContaos   = ALLTRIM(loc_oP2.txt_4c_Contao.Value)
                .this_cDcontaos  = ALLTRIM(loc_oP2.txt_4c_Dcontao.Value)
                .this_cGrupobs   = ALLTRIM(loc_oP2.txt_4c_GrTxCart.Value)
                .this_cContabs   = ALLTRIM(loc_oP2.txt_4c_CnTxCart.Value)
                .this_cDcarts    = ALLTRIM(loc_oP2.txt_4c__dcarts.Value)
                .this_cCarauts   = ALLTRIM(loc_oP2.txt_4c__carauts.Value)
                .this_cParcini   = ALLTRIM(loc_oP2.txt_4c_ParIni.Value)
                .this_cParcfin   = ALLTRIM(loc_oP2.txt_4c_ParFin.Value)
                .this_cBandeira  = ALLTRIM(loc_oP2.txt_4c_Band.Value)
                .this_nTaxjuros  = ALLTRIM(loc_oP2.txt_4c_Taxa.Value)
                .this_nPrazos    = ALLTRIM(loc_oP2.txt_4c_Prazo.Value)
                .this_nVlrminpar = ALLTRIM(loc_oP2.txt_4c_VlrMinPar.Value)
                .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_DigCartao.Value)
                .this_cGarantias = ALLTRIM(loc_oP2.txt_4c_Garantia.Value)
                .this_cLsaque    = ALLTRIM(loc_oP2.txt_4c_Saque.Value)
                .this_cTcdc      = ALLTRIM(loc_oP2.txt_4c_CDC.Value)
                .this_cHists     = ALLTRIM(loc_oP2.txt_4c_Hists.Value)
                .this_cAdquirente = ALLTRIM(loc_oP2.txt_4c_Adquire.Value)
                .this_cOperacaoss = ALLTRIM(loc_oP2.txt_4c_Finalz.Value)
                .this_cOperacaoes = ALLTRIM(loc_oP2.txt_4c_Dfinalz.Value)
                .this_cCcupomnvs = ALLTRIM(loc_oP2.txt_4c_Cupom.Value)
                .this_cCodestabs = ALLTRIM(loc_oP2.txt_4c_Estab.Value)
                .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_Item.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            WITH THIS.this_oBusinessObject
                && Cabecalho
                loc_oPage2.txt_4c_Codigo.Value    = .this_cFpags
                loc_oPage2.txt_4c_Descrs.Value    = .this_cDescrs
                loc_oPage2.txt_4c_TitFPags.Value  = .this_cTitfpags
                loc_oPage2.txt_4c_Forma.Value     = .this_cFormas
                loc_oPage2.txt_4c_Nfpag.Value     = ALLTRIM(STR(.this_nNfpags))
                loc_oPage2.txt_4c_Modalidade.Value = .this_cModpagto
                loc_oPage2.txt_4c_Grupo.Value     = .this_cGrupods
                loc_oPage2.txt_4c_Conta.Value     = .this_cContads
                loc_oPage2.txt_4c_Dconta.Value    = .this_cDcontads
                loc_oPage2.obj_4c_Opt_ContaMov.Value = .this_nOrides + 1

                && Pagina Geral
                loc_oP1.txt_4c_Entrada.Value    = ALLTRIM(STR(.this_nEntradas))
                loc_oP1.txt_4c_Dias.Value       = ALLTRIM(STR(.this_nDias))
                loc_oP1.txt_4c_Parcelas.Value   = ALLTRIM(STR(.this_nFparcs))
                loc_oP1.txt_4c___formas.Value   = .this_cMoefpgs
                loc_oP1.txt_4c__Situa.Value     = .this_cSituas
                loc_oP1.txt_4c_VENC.Value       = .this_cTvens
                loc_oP1.txt_4c_INFO.Value       = .this_cInfos
                loc_oP1.txt_4c_ChqObrig.Value   = .this_cColdados
                loc_oP1.txt_4c_EmpLanc.Value    = .this_cEmps
                loc_oP1.txt_4c_GrupoEmp.Value   = .this_cGrupoemp
                loc_oP1.txt_4c_Picture.Value    = .this_cCpictures
                loc_oP1.txt_4c_Valor.Value      = ALLTRIM(STR(.this_nVlrfpgs, 14, 2))
                loc_oP1.txt_4c_Desconto.Value   = ALLTRIM(STR(.this_nDescs, 8, 2))
                loc_oP1.txt_4c_Comissao.Value   = ALLTRIM(STR(.this_nFpcomiss, 8, 2))
                loc_oP1.txt_4c_Encargos.Value   = ALLTRIM(STR(.this_nEncargos, 8, 2))
                loc_oP1.txt_4c_PVaria.Value     = ALLTRIM(STR(.this_nPvarias, 8, 2))
                loc_oP1.txt_4c_Indice.Value     = ALLTRIM(STR(.this_nIndices, 9, 3))
                loc_oP1.txt_4c_TaxJuros.Value   = ALLTRIM(STR(.this_nTaxjuros, 12, 4))
                loc_oP1.txt_4c_TolFecCx.Value   = ALLTRIM(STR(.this_nTolfcxs, 8, 2))
                loc_oP1.txt_4c_Bancos.Value     = .this_cBancos
                loc_oP1.txt_4c_Agencias.Value   = .this_cAgencias
                loc_oP1.txt_4c_NContas.Value    = .this_cNcontas
                loc_oP1.txt_4c_EspecieNfs.Value = .this_cEspecies
                loc_oP1.obj_4c_Op_valpend.Value = IIF(.this_nValpends = 0, 2, .this_nValpends + 1)
                loc_oP1.obj_4c_Op_BxComis.Value = IIF(.this_nBxcomis = 0, 2, .this_nBxcomis + 1)
                loc_oP1.obj_4c_Op_Emichqs.Value = IIF(.this_nEmichqs = 0, 2, .this_nEmichqs + 1)
                loc_oP1.obj_4c_Op_ImpChqs.Value = IIF(.this_nImpchqs = 0, 2, .this_nImpchqs + 1)
                loc_oP1.obj_4c_OptImpBols.Value = IIF(.this_nImpbols = 0, 2, .this_nImpbols + 1)
                loc_oP1.obj_4c_OptImpDups.Value = IIF(.this_nImpdups = 0, 2, .this_nImpdups + 1)
                loc_oP1.obj_4c_Optiongroup13.Value = IIF(.this_nBlqtabds = 0, 2, .this_nBlqtabds + 1)
                loc_oP1.obj_4c_Opt_Liscongv.Value = IIF(.this_nLiscongv = 0, 2, .this_nLiscongv + 1)
                loc_oP1.obj_4c_OptFechm.Value   = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
                loc_oP1.obj_4c_Optiongroup7.Value = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
                loc_oP1.obj_4c_Optiongroup10.Value = IIF(.this_nAgcobs = 0, 2, .this_nAgcobs + 1)
                loc_oP1.obj_4c_OptTrocos.Value  = IIF(.this_nTrocos = 0, 2, .this_nTrocos + 1)
                loc_oP1.obj_4c_Optiongroup5.Value = IIF(.this_nBxcomchqs = 0, 2, .this_nBxcomchqs + 1)
                loc_oP1.obj_4c_Optiongroup2.Value = IIF(.this_nBaixas = 0, 2, .this_nBaixas + 1)
                loc_oP1.obj_4c_Optiongroup8.Value = IIF(.this_nAcumulas = 0, 2, .this_nAcumulas + 1)
                loc_oP1.obj_4c_Optiongroup3.Value = IIF(.this_nItemobrigs = 0, 2, .this_nItemobrigs + 1)
                loc_oP1.obj_4c_Optiongroup4.Value = IIF(.this_nAprovas = 0, 2, .this_nAprovas + 1)
                loc_oP1.obj_4c_Optiongroup12.Value = IIF(.this_nDetFecCxs = 0, 2, .this_nDetFecCxs + 1)
                loc_oP1.obj_4c_Fwoption1.Value  = IIF(.this_nOptcredcta = 0, 2, .this_nOptcredcta + 1)
                loc_oP1.obj_4c_Optiongroup11.Value = IIF(.this_nTpcheques = 0, 2, .this_nTpcheques + 1)
                loc_oP1.obj_4c_OptTpLeituras.Value = IIF(.this_nTpvencs = 0, 2, .this_nTpvencs + 1)
                loc_oP1.obj_4c_OpcaoSNA.Value   = IIF(.this_nOpcsnas = 0, 2, .this_nOpcsnas + 1)
                loc_oP1.obj_4c_Optiongroup6.Value = IIF(.this_nAutenticas = 0, 2, .this_nAutenticas + 1)
                loc_oP1.obj_4c_OptObserva.Value = IIF(.this_nObs = 0, 2, .this_nObs + 1)
                loc_oP1.obj_4c_Optiongroup1.Value = IIF(.this_nGavetas = 0, 2, .this_nGavetas + 1)
                loc_oP1.obj_4c_Optiongroup14.Value = IIF(.this_nRelmetvend = 0, 2, .this_nRelmetvend + 1)
                loc_oP1.obj_4c_Optiongroup15.Value = IIF(.this_nChklimcre = 0, 2, .this_nChklimcre + 1)
                loc_oP1.obj_4c_Optiongroup17.Value = IIF(.this_nRelsomsub = 0, 2, .this_nRelsomsub + 1)
                loc_oP1.obj_4c_Optiongroup16.Value = IIF(.this_nBlqvctopar = 0, 2, .this_nBlqvctopar + 1)

                && Pagina Cartao/TEF
                loc_oP2.obj_4c_EdtTxtFinanc.Value = .this_cMfinancs
                loc_oP2.txt_4c_Grupo2.Value     = .this_cGrupoos
                loc_oP2.txt_4c_Contao.Value     = .this_cContaos
                loc_oP2.txt_4c_Dcontao.Value    = .this_cDcontaos
                loc_oP2.txt_4c_GrTxCart.Value   = .this_cGrupobs
                loc_oP2.txt_4c_CnTxCart.Value   = .this_cContabs
                loc_oP2.txt_4c__dcarts.Value    = .this_cDcarts
                loc_oP2.txt_4c__carauts.Value   = .this_cCarauts
                loc_oP2.txt_4c_ParIni.Value     = .this_cParcini
                loc_oP2.txt_4c_ParFin.Value     = .this_cParcfin
                loc_oP2.txt_4c_Band.Value       = .this_cBandeira
                loc_oP2.txt_4c_Taxa.Value       = ALLTRIM(STR(.this_nTaxjuros, 8, 2))
                loc_oP2.txt_4c_Prazo.Value      = ALLTRIM(STR(.this_nPrazos))
                loc_oP2.txt_4c_VlrMinPar.Value  = ALLTRIM(STR(.this_nVlrminpar, 14, 2))
                loc_oP2.txt_4c_DigCartao.Value  = .this_cCitems
                loc_oP2.txt_4c_Garantia.Value   = .this_cGarantias
                loc_oP2.txt_4c_Saque.Value      = .this_cLsaque
                loc_oP2.txt_4c_CDC.Value        = .this_cTcdc
                loc_oP2.txt_4c_Hists.Value      = .this_cHists
                loc_oP2.txt_4c_Adquire.Value    = .this_cAdquirente
                loc_oP2.txt_4c_Finalz.Value     = .this_cOperacaoss
                loc_oP2.txt_4c_Dfinalz.Value    = .this_cOperacaoes
                loc_oP2.txt_4c_Cupom.Value      = .this_cCcupomnvs
                loc_oP2.txt_4c_Estab.Value      = .this_cCodestabs
                loc_oP2.txt_4c_Item.Value       = .this_cCitems
                && Espelhos P2 (somente exibicao, refletem P1)
                loc_oP2.obj_4c_Optiongroup12_p2.Value = IIF(.this_nDetFecCxs = 0, 2, .this_nDetFecCxs + 1)
                loc_oP2.obj_4c_Optiongroup4_p2.Value  = IIF(.this_nAprovas = 0, 2, .this_nAprovas + 1)
                loc_oP2.obj_4c_Optiongroup3_p2.Value  = IIF(.this_nItemobrigs = 0, 2, .this_nItemobrigs + 1)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            && Cabecalho
            loc_oPage2.txt_4c_Codigo.Value    = ""
            loc_oPage2.txt_4c_Descrs.Value    = ""
            loc_oPage2.txt_4c_TitFPags.Value  = ""
            loc_oPage2.txt_4c_Forma.Value     = ""
            loc_oPage2.txt_4c_Nfpag.Value     = ""
            loc_oPage2.txt_4c_Modalidade.Value = ""
            loc_oPage2.txt_4c_Grupo.Value     = ""
            loc_oPage2.txt_4c_Conta.Value     = ""
            loc_oPage2.txt_4c_Dconta.Value    = ""
            loc_oPage2.obj_4c_Opt_ContaMov.Value = 1

            && Pagina Geral
            loc_oP1.txt_4c_Entrada.Value   = ""
            loc_oP1.txt_4c_Dias.Value      = ""
            loc_oP1.txt_4c_Parcelas.Value  = ""
            loc_oP1.txt_4c___formas.Value  = ""
            loc_oP1.txt_4c__Situa.Value    = ""
            loc_oP1.txt_4c_VENC.Value      = ""
            loc_oP1.txt_4c_INFO.Value      = ""
            loc_oP1.txt_4c_ChqObrig.Value  = ""
            loc_oP1.txt_4c_EmpLanc.Value   = ""
            loc_oP1.txt_4c_GrupoEmp.Value  = ""
            loc_oP1.txt_4c_Picture.Value   = ""
            loc_oP1.txt_4c_Valor.Value     = ""
            loc_oP1.txt_4c_Desconto.Value  = ""
            loc_oP1.txt_4c_Comissao.Value  = ""
            loc_oP1.txt_4c_Encargos.Value  = ""
            loc_oP1.txt_4c_PVaria.Value    = ""
            loc_oP1.txt_4c_Indice.Value    = ""
            loc_oP1.txt_4c_TaxJuros.Value  = ""
            loc_oP1.txt_4c_TolFecCx.Value  = ""
            loc_oP1.txt_4c_Bancos.Value    = ""
            loc_oP1.txt_4c_Agencias.Value  = ""
            loc_oP1.txt_4c_NContas.Value   = ""
            loc_oP1.txt_4c_EspecieNfs.Value = ""
            loc_oP1.obj_4c_Op_valpend.Value    = 1
            loc_oP1.obj_4c_Op_BxComis.Value    = 1
            loc_oP1.obj_4c_Op_Emichqs.Value    = 1
            loc_oP1.obj_4c_Op_ImpChqs.Value    = 1
            loc_oP1.obj_4c_OptImpBols.Value    = 1
            loc_oP1.obj_4c_OptImpDups.Value    = 1
            loc_oP1.obj_4c_Optiongroup13.Value = 1
            loc_oP1.obj_4c_Opt_Liscongv.Value  = 1
            loc_oP1.obj_4c_OptFechm.Value      = 1
            loc_oP1.obj_4c_Optiongroup7.Value  = 1
            loc_oP1.obj_4c_Optiongroup10.Value = 1
            loc_oP1.obj_4c_OptTrocos.Value     = 1
            loc_oP1.obj_4c_Optiongroup5.Value  = 1
            loc_oP1.obj_4c_Optiongroup2.Value  = 1
            loc_oP1.obj_4c_Optiongroup8.Value  = 1
            loc_oP1.obj_4c_Optiongroup3.Value  = 1
            loc_oP1.obj_4c_Optiongroup4.Value  = 1
            loc_oP1.obj_4c_Optiongroup12.Value = 1
            loc_oP1.obj_4c_Fwoption1.Value     = 1
            loc_oP1.obj_4c_Optiongroup11.Value = 1
            loc_oP1.obj_4c_OptTpLeituras.Value = 1
            loc_oP1.obj_4c_OpcaoSNA.Value      = 1
            loc_oP1.obj_4c_Optiongroup6.Value  = 1
            loc_oP1.obj_4c_OptObserva.Value    = 1
            loc_oP1.obj_4c_Optiongroup1.Value  = 1
            loc_oP1.obj_4c_Optiongroup14.Value = 1
            loc_oP1.obj_4c_Optiongroup15.Value = 1
            loc_oP1.obj_4c_Optiongroup17.Value = 1
            loc_oP1.obj_4c_Optiongroup16.Value = 1

            && Pagina Cartao/TEF
            loc_oP2.obj_4c_EdtTxtFinanc.Value = ""
            loc_oP2.txt_4c_Grupo2.Value    = ""
            loc_oP2.txt_4c_Contao.Value    = ""
            loc_oP2.txt_4c_Dcontao.Value   = ""
            loc_oP2.txt_4c_GrTxCart.Value  = ""
            loc_oP2.txt_4c_CnTxCart.Value  = ""
            loc_oP2.txt_4c__dcarts.Value   = ""
            loc_oP2.txt_4c__carauts.Value  = ""
            loc_oP2.txt_4c_ParIni.Value    = ""
            loc_oP2.txt_4c_ParFin.Value    = ""
            loc_oP2.txt_4c_Band.Value      = ""
            loc_oP2.txt_4c_Taxa.Value      = ""
            loc_oP2.txt_4c_Prazo.Value     = ""
            loc_oP2.txt_4c_VlrMinPar.Value = ""
            loc_oP2.txt_4c_DigCartao.Value = ""
            loc_oP2.txt_4c_Garantia.Value  = ""
            loc_oP2.txt_4c_Saque.Value     = ""
            loc_oP2.txt_4c_CDC.Value       = ""
            loc_oP2.txt_4c_Hists.Value     = ""
            loc_oP2.txt_4c_Adquire.Value   = ""
            loc_oP2.txt_4c_Finalz.Value    = ""
            loc_oP2.txt_4c_Dfinalz.Value   = ""
            loc_oP2.txt_4c_Cupom.Value     = ""
            loc_oP2.txt_4c_Estab.Value     = ""
            loc_oP2.txt_4c_Item.Value      = ""
            && Espelhos P2
            loc_oP2.obj_4c_Optiongroup12_p2.Value = 1
            loc_oP2.obj_4c_Optiongroup4_p2.Value  = 1
            loc_oP2.obj_4c_Optiongroup3_p2.Value  = 1
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2, loc_lReadOnly
        TRY
            loc_lReadOnly = !par_lHabilitar
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            && Cabecalho
            loc_oPage2.txt_4c_Codigo.ReadOnly    = loc_lReadOnly
            loc_oPage2.txt_4c_Descrs.ReadOnly    = loc_lReadOnly
            loc_oPage2.txt_4c_TitFPags.ReadOnly  = loc_lReadOnly
            loc_oPage2.txt_4c_Forma.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Nfpag.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Modalidade.ReadOnly = loc_lReadOnly
            loc_oPage2.txt_4c_Grupo.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Conta.ReadOnly     = loc_lReadOnly
            loc_oPage2.obj_4c_Opt_ContaMov.Enabled = par_lHabilitar

            && Pagina Geral
            loc_oP1.txt_4c_Entrada.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_Dias.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_Parcelas.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c___formas.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c__Situa.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_VENC.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_INFO.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_ChqObrig.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_EmpLanc.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_GrupoEmp.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Picture.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_Valor.ReadOnly     = loc_lReadOnly
            loc_oP1.txt_4c_Desconto.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Comissao.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Encargos.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_PVaria.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_Indice.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_TaxJuros.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_TolFecCx.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Bancos.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_Agencias.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_NContas.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_EspecieNfs.ReadOnly = loc_lReadOnly
            loc_oP1.obj_4c_Op_valpend.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_BxComis.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_Emichqs.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_ImpChqs.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_OptImpBols.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_OptImpDups.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup13.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Opt_Liscongv.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_OptFechm.Enabled      = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup7.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup10.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OptTrocos.Enabled     = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup5.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup2.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup8.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup3.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup4.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup12.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Fwoption1.Enabled     = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup11.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OptTpLeituras.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OpcaoSNA.Enabled      = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup6.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_OptObserva.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup1.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup14.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup15.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup17.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup16.Enabled = par_lHabilitar

            && Pagina Cartao/TEF
            loc_oP2.obj_4c_EdtTxtFinanc.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Grupo2.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Contao.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_GrTxCart.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_CnTxCart.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c__dcarts.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c__carauts.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_ParIni.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_ParFin.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Band.ReadOnly     = loc_lReadOnly
            loc_oP2.txt_4c_Taxa.ReadOnly     = loc_lReadOnly
            loc_oP2.txt_4c_Prazo.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_VlrMinPar.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_DigCartao.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Garantia.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Saque.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_CDC.ReadOnly      = loc_lReadOnly
            loc_oP2.txt_4c_Hists.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Adquire.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c_Finalz.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Dfinalz.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c_Cupom.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Estab.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Item.ReadOnly     = loc_lReadOnly
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
    *==========================================================================
        LOCAL loc_oPage1, loc_oPage2, loc_lEdicao
        TRY
            loc_oPage1 = THIS.pgf_4c_Paginas.Pages(1)
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_lEdicao = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")

            DO CASE
            CASE par_cModo = "LISTA"
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                loc_oPage2.cnt_4c_Salva.Visible = .F.
            CASE par_cModo = "INCLUIR" OR par_cModo = "ALTERAR"
                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_oPage2.cnt_4c_Salva.Visible = .T.
            CASE par_cModo = "VISUALIZAR"
                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_oPage2.cnt_4c_Salva.Visible = .F.
            ENDCASE

            THIS.HabilitarCampos(loc_lEdicao)
            THIS.this_cModoAtual = par_cModo
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                IF USED("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CarregarLista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.LimparCampos()
            THIS.this_oBusinessObject.this_lNovoRegistro = .T.
            THIS.AjustarBotoesPorModo("INCLUIR")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.AjustarBotoesPorModo("VISUALIZAR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.AjustarBotoesPorModo("ALTERAR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF MsgConfirma("Deseja excluir a condi" + CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir(loc_cCodigo)
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oBusca, loc_cCodigo, loc_cSQL
        loc_lResultado = .F.

        TRY
            && Pattern A: SQL no caller
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca") < 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Busca (fpags C(12), descrs C(30))
                SET NULL OFF
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.DefinirCursor("cursor_4c_Busca", "fpags", "descrs", "Busca de Condi" + CHR(231) + CHR(245) + "es de Pagamento")
                loc_oBusca.Mostrar()

                loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF !EMPTY(loc_cCodigo)
                    THIS.this_oBusinessObject.Buscar("fpags = '" + loc_cCodigo + "'")
                    IF USED("cursor_4c_Dados")
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnBuscarClick: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.this_lNovoRegistro
                loc_lResultado = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            IF loc_lResultado
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo("LISTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnSalvarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        TRY
            THIS.AjustarBotoesPorModo("LISTA")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnCancelarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnEncerrarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExportarClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de exportar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnExportarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnImportarClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de importar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnImportarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCopiarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodOrigem, loc_cCodDestino, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro de origem para copiar.", "Aviso")
            ELSE
                loc_cCodOrigem  = ALLTRIM(cursor_4c_Dados.fpags)
                loc_cCodDestino = INPUTBOX("Digite o c" + CHR(243) + "digo da nova condi" + CHR(231) + CHR(227) + "o:", "Copiar Condi" + CHR(231) + CHR(227) + "o", "")

                IF !EMPTY(ALLTRIM(loc_cCodDestino))
                    loc_cCodDestino = ALLTRIM(loc_cCodDestino)

                    && Verificar se destino ja existe
                    loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodDestino)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerDest") >= 0
                        IF cursor_4c_VerDest.qtd > 0
                            MsgAviso("C" + CHR(243) + "digo '" + loc_cCodDestino + "' j" + CHR(225) + " existe.")
                            IF USED("cursor_4c_VerDest")
                                USE IN cursor_4c_VerDest
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_VerDest")
                                USE IN cursor_4c_VerDest
                            ENDIF

                            && Copiar registro
                            loc_cSQL = "INSERT INTO SigOpFp SELECT " + ;
                                       EscaparSQL(loc_cCodDestino) + ", descrs, titfpags, formas, moefpgs, " + ;
                                       "infos, situas, codfpags, nfpags, modpagto, grupods, contads, dcontads, " + ;
                                       "orides, grupoos, contaos, dcontaos, grupobs, contabs, grupots, contats, " + ;
                                       "bancos, agencias, ncontas, tvens, carauts, coldados, hists, ccupomnvs, " + ;
                                       "operautos, operacaoss, operacaoes, cpictures, garantias, lcartao, lsaque, " + ;
                                       "opers, parcs, autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, " + ;
                                       "adquirente, emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
                                       "mfinancs, datatrans, aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, " + ;
                                       "emichqs, encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, " + ;
                                       "valpends, impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, " + ;
                                       "gavetas, tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
                                       "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
                                       "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, cnidtefs, " + ;
                                       "detfecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, chklimcre, relsomsub, " + ;
                                       "chkvalgar, chknccmov, arredonda, chkcachbk, chkuticach, autoriza, blqvctopar, " + ;
                                       "vlrminpar, vlrlimfpgs, optcredcta, relmetvend " + ;
                                       "FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodOrigem)

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult >= 0
                                THIS.CarregarLista()
                                MsgInfo("Condi" + CHR(231) + CHR(227) + "o '" + loc_cCodOrigem + "' copiada para '" + loc_cCodDestino + "'.", "Sucesso")
                                loc_lResultado = .T.
                            ELSE
                                MsgErro("Erro ao copiar: " + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                        ENDIF
                    ELSE
                        MsgErro("Erro ao verificar destino: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnCopiarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnMinimoClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de configurar m" + CHR(237) + "nimo n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnMinimoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnDescontoClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de desconto n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnDescontoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBINClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade BIN n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnBINClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF USED("cursor_4c_VerDest")
                USE IN cursor_4c_VerDest
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.Destroy: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\pagBO.prg):
*==============================================================================
* pagBO.prg - Business Object para Condicoes de Pagamento
* Tabela principal: SigOpFp
* Chave primaria  : fpags char(12)
* Tabelas filhas  : SigOpFpI (fpags), SigOpFpP (fpags)
*==============================================================================

DEFINE CLASS pagBO AS BusinessBase

    *-- Chave primaria
    this_cFpags         = ""   && char(12) fpags

    *-- Identificacao basica
    this_cDescrs        = ""   && char(30)  descrs
    this_cTitfpags      = ""   && char(30)  titfpags
    this_cFormas        = ""   && char(12)  formas
    this_cMoefpgs       = ""   && char(3)   moefpgs
    this_cInfos         = ""   && char(1)   infos
    this_cSituas        = ""   && char(1)   situas
    this_cCodfpags      = ""   && char(2)   codfpags
    this_nNfpags        = 0    && numeric(2,0) nfpags
    this_cModpagto      = ""   && char(10)  modpagto
    this_cGrupods       = ""   && char(10)  grupods
    this_cContads       = ""   && char(10)  contads
    this_cDcontads      = ""   && char(40)  dcontads
    this_nOrides        = 0    && numeric(1,0) orides
    this_cGrupoos       = ""   && char(10)  grupoos
    this_cContaos       = ""   && char(10)  contaos
    this_cDcontaos      = ""   && char(40)  dcontaos
    this_cGrupobs       = ""   && char(10)  grupobs
    this_cContabs       = ""   && char(10)  contabs
    this_cGrupots       = ""   && char(10)  grupots
    this_cContats       = ""   && char(10)  contats
    this_cBancos        = ""   && char(3)   bancos
    this_cAgencias      = ""   && char(4)   agencias
    this_cNcontas       = ""   && char(10)  ncontas
    this_cTvens         = ""   && char(1)   tvens
    this_cCarauts       = ""   && char(1)   carauts
    this_cColdados      = ""   && char(1)   coldados
    this_cHists         = ""   && char(30)  hists
    this_cCcupomnvs     = ""   && char(20)  ccupomnvs
    this_cOperautos     = ""   && char(12)  operautos
    this_cOperacaoss    = ""   && char(15)  operacaoss
    this_cOperacaoes    = ""   && char(15)  operacaoes
    this_cCpictures     = ""   && char(20)  cpictures
    this_cGarantias     = ""   && char(1)   garantias
    this_cLcartao       = ""   && char(1)   lcartao
    this_cLsaque        = ""   && char(1)   lsaque
    this_cOpers         = ""   && char(1)   opers
    this_cParcs         = ""   && char(1)   parcs
    this_cAutotef       = ""   && char(1)   autotef
    this_cTcdc          = ""   && char(1)   tcdc
    this_cPcheque       = ""   && char(45)  pcheque
    this_cDadchqs       = ""   && char(1)   dadchqs
    this_cCodestabs     = ""   && char(8)   codestabs
    this_cCitems        = ""   && char(11)  citems
    this_cDcarts        = ""   && char(30)  dcarts
    this_cAdquirente    = ""   && char(8)   adquirente
    this_cEmps          = ""   && char(3)   emps
    this_cParcfin       = ""   && char(2)   parcfin
    this_cParcini       = ""   && char(2)   parcini
    this_cBandeira      = ""   && char(20)  bandeira
    this_cCdcashback    = ""   && char(3)   cdcashback
    this_cEspecies      = ""   && char(6)   especies
    this_cGrupoemp      = ""   && char(15)  grupoemp
    this_cMfinancs      = ""   && memo       mfinancs
    this_dDatatrans     = {}   && datetime   datatrans (nullable)

    *-- Campos numericos
    this_nAprovas       = 0    && numeric(1,0)
    this_nItemobrigs    = 0    && numeric(1,0)
    this_nBxcomis       = 0    && numeric(1,0)
    this_nCpags         = 0    && numeric(2,0)
    this_nDesc2s        = 0    && numeric(5,2)
    this_nDescs         = 0    && numeric(5,2)
    this_nDias          = 0    && numeric(3,0)
    this_nEmichqs       = 0    && numeric(1,0)
    this_nEncargos      = 0    && numeric(5,2)
    this_nEntradas      = 0    && numeric(3,0)
    this_nFparcs        = 0    && numeric(2,0)
    this_nFpcomiss      = 0    && numeric(5,2)
    this_nImpbols       = 0    && numeric(1,0)
    this_nPrazos        = 0    && numeric(3,0)
    this_nTrocos        = 0    && numeric(1,0)
    this_nValpends      = 0    && numeric(1,0)
    this_nImpnotas      = 0    && numeric(1,0)
    this_nImpdups       = 0    && numeric(1,0)
    this_nObs           = 0    && numeric(1,0)
    this_nTphists       = 0    && numeric(1,0)
    this_nNcodfinzs     = 0    && numeric(2,0)
    this_nImpchqs       = 0    && numeric(1,0)
    this_nEmivales      = 0    && numeric(1,0)
    this_nGavetas       = 0    && numeric(1,0)
    this_nTpcheques     = 0    && numeric(1,0)
    this_nBaixas        = 0    && numeric(1,0)
    this_nBxcomchqs     = 0    && numeric(1,0)
    this_nAutenticas    = 0    && numeric(1,0)
    this_nMesfec        = 0    && numeric(1,0)
    this_nAcvchqs       = 0    && numeric(1,0)
    this_nAcumulas      = 0    && numeric(1,0)
    this_nPromos        = 0    && numeric(1,0)
    this_nAgcobs        = 0    && numeric(1,0)
    this_nTolfcxs       = 0    && numeric(5,2)
    this_nTpvencs       = 0    && numeric(1,0)
    this_nPvarias       = 0    && numeric(5,2)
    this_nIndices       = 0    && numeric(6,3)
    this_nLibcsens      = 0    && numeric(1,0)
    this_nImpcpchqs     = 0    && numeric(1,0)
    this_nBlqtabds      = 0    && numeric(1,0)
    this_nChkbins       = 0    && numeric(1,0)
    this_nChkfidels     = 0    && numeric(1,0)
    this_nNfinancs      = 0    && numeric(1,0)
    this_nOpcsnas       = 0    && numeric(1,0)
    this_nVlrfpgs       = 0    && numeric(11,2)
    this_nLiscongv      = 0    && numeric(1,0)
    this_nCnidtefs      = 0    && numeric(1,0)
    this_nDetFecCxs     = 0    && numeric(1,0)
    this_nTaxjuros      = 0    && numeric(8,4)
    this_nNdtcomis      = 0    && numeric(1,0)
    this_nChkcpf        = 0    && numeric(1,0)
    this_nLibctablq     = 0    && numeric(1,0)
    this_nNsu           = 0    && numeric(1,0)
    this_nChklimcre     = 0    && numeric(1,0)
    this_nRelsomsub     = 0    && numeric(1,0)
    this_nChkvalgar     = 0    && numeric(1,0)
    this_nChknccmov     = 0    && numeric(1,0)
    this_nArredonda     = 0    && numeric(1,0)
    this_nChkcachbk     = 0    && numeric(1,0)
    this_nChkuticach    = 0    && numeric(1,0)
    this_nAutoriza      = 0    && numeric(1,0)
    this_nBlqvctopar    = 0    && numeric(1,0)
    this_nVlrminpar     = 0    && numeric(11,2)
    this_nVlrlimfpgs    = 0    && numeric(12,2)
    this_nOptcredcta    = 0    && numeric(1,0)
    this_nRelmetvend    = 0    && numeric(1,0)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado    = DODEFAULT()
            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "fpags"
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Init: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cFpags)
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega cursor_4c_Dados para o grid
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                       "grupods, contads FROM SigOpFp ORDER BY fpags"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                           "grupods, contads FROM SigOpFp WHERE " + par_cFiltro + ;
                           " ORDER BY fpags"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        fpags   C(12), ;
                        descrs  C(30), ;
                        moefpgs C(3), ;
                        dias    N(3), ;
                        tvens   C(1), ;
                        infos   C(1), ;
                        grupods C(10), ;
                        contads C(10) )
                    SET NULL OFF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Buscar: " + loc_oErro.Message, "Erro")
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    fpags   C(12), ;
                    descrs  C(30), ;
                    moefpgs C(3), ;
                    dias    N(3), ;
                    tvens   C(1), ;
                    infos   C(1), ;
                    grupods C(10), ;
                    contads C(10) )
                SET NULL OFF
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo fpags
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cFpags)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(par_cFpags))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cFpags), "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags        = TratarNulo(fpags,        "C")
            THIS.this_cDescrs       = TratarNulo(descrs,       "C")
            THIS.this_cTitfpags     = TratarNulo(titfpags,     "C")
            THIS.this_cFormas       = TratarNulo(formas,       "C")
            THIS.this_cMoefpgs      = TratarNulo(moefpgs,      "C")
            THIS.this_cInfos        = TratarNulo(infos,        "C")
            THIS.this_cSituas       = TratarNulo(situas,       "C")
            THIS.this_cCodfpags     = TratarNulo(codfpags,     "C")
            THIS.this_nNfpags       = TratarNulo(nfpags,       "N")
            THIS.this_cModpagto     = TratarNulo(modpagto,     "C")
            THIS.this_cGrupods      = TratarNulo(grupods,      "C")
            THIS.this_cContads      = TratarNulo(contads,      "C")
            THIS.this_cDcontads     = TratarNulo(dcontads,     "C")
            THIS.this_nOrides       = TratarNulo(orides,       "N")
            THIS.this_cGrupoos      = TratarNulo(grupoos,      "C")
            THIS.this_cContaos      = TratarNulo(contaos,      "C")
            THIS.this_cDcontaos     = TratarNulo(dcontaos,     "C")
            THIS.this_cGrupobs      = TratarNulo(grupobs,      "C")
            THIS.this_cContabs      = TratarNulo(contabs,      "C")
            THIS.this_cGrupots      = TratarNulo(grupots,      "C")
            THIS.this_cContats      = TratarNulo(contats,      "C")
            THIS.this_cBancos       = TratarNulo(bancos,       "C")
            THIS.this_cAgencias     = TratarNulo(agencias,     "C")
            THIS.this_cNcontas      = TratarNulo(ncontas,      "C")
            THIS.this_cTvens        = TratarNulo(tvens,        "C")
            THIS.this_cCarauts      = TratarNulo(carauts,      "C")
            THIS.this_cColdados     = TratarNulo(coldados,     "C")
            THIS.this_cHists        = TratarNulo(hists,        "C")
            THIS.this_cCcupomnvs    = TratarNulo(ccupomnvs,    "C")
            THIS.this_cOperautos    = TratarNulo(operautos,    "C")
            THIS.this_cOperacaoss   = TratarNulo(operacaoss,   "C")
            THIS.this_cOperacaoes   = TratarNulo(operacaoes,   "C")
            THIS.this_cCpictures    = TratarNulo(cpictures,    "C")
            THIS.this_cGarantias    = TratarNulo(garantias,    "C")
            THIS.this_cLcartao      = TratarNulo(lcartao,      "C")
            THIS.this_cLsaque       = TratarNulo(lsaque,       "C")
            THIS.this_cOpers        = TratarNulo(opers,        "C")
            THIS.this_cParcs        = TratarNulo(parcs,        "C")
            THIS.this_cAutotef      = TratarNulo(autotef,      "C")
            THIS.this_cTcdc         = TratarNulo(tcdc,         "C")
            THIS.this_cPcheque      = TratarNulo(pcheque,      "C")
            THIS.this_cDadchqs      = TratarNulo(dadchqs,      "C")
            THIS.this_cCodestabs    = TratarNulo(codestabs,    "C")
            THIS.this_cCitems       = TratarNulo(citems,       "C")
            THIS.this_cDcarts       = TratarNulo(dcarts,       "C")
            THIS.this_cAdquirente   = TratarNulo(adquirente,   "C")
            THIS.this_cEmps         = TratarNulo(emps,         "C")
            THIS.this_cParcfin      = TratarNulo(parcfin,      "C")
            THIS.this_cParcini      = TratarNulo(parcini,      "C")
            THIS.this_cBandeira     = TratarNulo(bandeira,     "C")
            THIS.this_cCdcashback   = TratarNulo(cdcashback,   "C")
            THIS.this_cEspecies     = TratarNulo(especies,     "C")
            THIS.this_cGrupoemp     = TratarNulo(grupoemp,     "C")
            THIS.this_cMfinancs     = TratarNulo(mfinancs,     "M")
            THIS.this_nAprovas      = TratarNulo(aprovas,      "N")
            THIS.this_nItemobrigs   = TratarNulo(itemobrigs,   "N")
            THIS.this_nBxcomis      = TratarNulo(bxcomis,      "N")
            THIS.this_nCpags        = TratarNulo(cpags,        "N")
            THIS.this_nDesc2s       = TratarNulo(desc2s,       "N")
            THIS.this_nDescs        = TratarNulo(descs,        "N")
            THIS.this_nDias         = TratarNulo(dias,         "N")
            THIS.this_nEmichqs      = TratarNulo(emichqs,      "N")
            THIS.this_nEncargos     = TratarNulo(encargos,     "N")
            THIS.this_nEntradas     = TratarNulo(entradas,     "N")
            THIS.this_nFparcs       = TratarNulo(fparcs,       "N")
            THIS.this_nFpcomiss     = TratarNulo(fpcomiss,     "N")
            THIS.this_nImpbols      = TratarNulo(impbols,      "N")
            THIS.this_nPrazos       = TratarNulo(prazos,       "N")
            THIS.this_nTrocos       = TratarNulo(trocos,       "N")
            THIS.this_nValpends     = TratarNulo(valpends,     "N")
            THIS.this_nImpnotas     = TratarNulo(impnotas,     "N")
            THIS.this_nImpdups      = TratarNulo(impdups,      "N")
            THIS.this_nObs          = TratarNulo(obs,          "N")
            THIS.this_nTphists      = TratarNulo(tphists,      "N")
            THIS.this_nNcodfinzs    = TratarNulo(ncodfinzs,    "N")
            THIS.this_nImpchqs      = TratarNulo(impchqs,      "N")
            THIS.this_nEmivales     = TratarNulo(emivales,     "N")
            THIS.this_nGavetas      = TratarNulo(gavetas,      "N")
            THIS.this_nTpcheques    = TratarNulo(tpcheques,    "N")
            THIS.this_nBaixas       = TratarNulo(baixas,       "N")
            THIS.this_nBxcomchqs    = TratarNulo(bxcomchqs,    "N")
            THIS.this_nAutenticas   = TratarNulo(autenticas,   "N")
            THIS.this_nMesfec       = TratarNulo(mesfec,       "N")
            THIS.this_nAcvchqs      = TratarNulo(acvchqs,      "N")
            THIS.this_nAcumulas     = TratarNulo(acumulas,     "N")
            THIS.this_nPromos       = TratarNulo(promos,       "N")
            THIS.this_nAgcobs       = TratarNulo(agcobs,       "N")
            THIS.this_nTolfcxs      = TratarNulo(tolfcxs,      "N")
            THIS.this_nTpvencs      = TratarNulo(tpvencs,      "N")
            THIS.this_nPvarias      = TratarNulo(pvarias,      "N")
            THIS.this_nIndices      = TratarNulo(indices,      "N")
            THIS.this_nLibcsens     = TratarNulo(libcsens,     "N")
            THIS.this_nImpcpchqs    = TratarNulo(impcpchqs,    "N")
            THIS.this_nBlqtabds     = TratarNulo(blqtabds,     "N")
            THIS.this_nChkbins      = TratarNulo(chkbins,      "N")
            THIS.this_nChkfidels    = TratarNulo(chkfidels,    "N")
            THIS.this_nNfinancs     = TratarNulo(nfinancs,     "N")
            THIS.this_nOpcsnas      = TratarNulo(opcsnas,      "N")
            THIS.this_nVlrfpgs      = TratarNulo(vlrfpgs,      "N")
            THIS.this_nLiscongv     = TratarNulo(liscongv,     "N")
            THIS.this_nCnidtefs     = TratarNulo(cnidtefs,     "N")
            THIS.this_nDetFecCxs    = TratarNulo(DetFecCxs,    "N")
            THIS.this_nTaxjuros     = TratarNulo(taxjuros,     "N")
            THIS.this_nNdtcomis     = TratarNulo(ndtcomis,     "N")
            THIS.this_nChkcpf       = TratarNulo(chkcpf,       "N")
            THIS.this_nLibctablq    = TratarNulo(libctablq,    "N")
            THIS.this_nNsu          = TratarNulo(nsu,          "N")
            THIS.this_nChklimcre    = TratarNulo(chklimcre,    "N")
            THIS.this_nRelsomsub    = TratarNulo(relsomsub,    "N")
            THIS.this_nChkvalgar    = TratarNulo(chkvalgar,    "N")
            THIS.this_nChknccmov    = TratarNulo(chknccmov,    "N")
            THIS.this_nArredonda    = TratarNulo(arredonda,    "N")
            THIS.this_nChkcachbk    = TratarNulo(chkcachbk,    "N")
            THIS.this_nChkuticach   = TratarNulo(chkuticach,   "N")
            THIS.this_nAutoriza     = TratarNulo(autoriza,     "N")
            THIS.this_nBlqvctopar   = TratarNulo(blqvctopar,   "N")
            THIS.this_nVlrminpar    = TratarNulo(vlrminpar,    "N")
            THIS.this_nVlrlimfpgs   = TratarNulo(vlrlimfpgs,   "N")
            THIS.this_nOptcredcta   = TratarNulo(optcredcta,   "N")
            THIS.this_nRelmetvend   = TratarNulo(relmetvend,   "N")

            *-- datatrans (datetime, nullable)
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDatatrans = {}
            ELSE
                THIS.this_dDatatrans = datatrans
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarInsercao - Valida campos obrigatorios antes de inserir/atualizar
    *==========================================================================
    FUNCTION ValidarInsercao()
    *==========================================================================
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cFpags))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cInfos))
            MsgAviso("Tipo n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMoefpgs))
            MsgAviso("Moeda n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cFormas))
            MsgAviso("Forma n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "INSERT INTO SigOpFp (" + ;
                "fpags, descrs, titfpags, formas, moefpgs, infos, situas, codfpags, " + ;
                "nfpags, modpagto, grupods, contads, dcontads, orides, grupoos, contaos, " + ;
                "dcontaos, grupobs, contabs, grupots, contats, bancos, agencias, ncontas, " + ;
                "tvens, carauts, coldados, hists, ccupomnvs, operautos, operacaoss, " + ;
                "operacaoes, cpictures, garantias, lcartao, lsaque, opers, parcs, " + ;
                "autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, adquirente, " + ;
                "emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
                "mfinancs, datatrans, " + ;
                "aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, emichqs, " + ;
                "encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, valpends, " + ;
                "impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, gavetas, " + ;
                "tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
                "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
                "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, " + ;
                "cnidtefs, DetFecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, " + ;
                "chklimcre, relsomsub, chkvalgar, chknccmov, arredonda, chkcachbk, " + ;
                "chkuticach, autoriza, blqvctopar, vlrminpar, vlrlimfpgs, optcredcta, relmetvend" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cFpags)       + ", " + ;
                EscaparSQL(THIS.this_cDescrs)      + ", " + ;
                EscaparSQL(THIS.this_cTitfpags)    + ", " + ;
                EscaparSQL(THIS.this_cFormas)      + ", " + ;
                EscaparSQL(THIS.this_cMoefpgs)     + ", " + ;
                EscaparSQL(THIS.this_cInfos)       + ", " + ;
                EscaparSQL(THIS.this_cSituas)      + ", " + ;
                EscaparSQL(THIS.this_cCodfpags)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                EscaparSQL(THIS.this_cModpagto)    + ", " + ;
                EscaparSQL(THIS.this_cGrupods)     + ", " + ;
                EscaparSQL(THIS.this_cContads)     + ", " + ;
                EscaparSQL(THIS.this_cDcontads)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoos)     + ", " + ;
                EscaparSQL(THIS.this_cContaos)     + ", " + ;
                EscaparSQL(THIS.this_cDcontaos)    + ", " + ;
                EscaparSQL(THIS.this_cGrupobs)     + ", " + ;
                EscaparSQL(THIS.this_cContabs)     + ", " + ;
                EscaparSQL(THIS.this_cGrupots)     + ", " + ;
                EscaparSQL(THIS.this_cContats)     + ", " + ;
                EscaparSQL(THIS.this_cBancos)      + ", " + ;
                EscaparSQL(THIS.this_cAgencias)    + ", " + ;
                EscaparSQL(THIS.this_cNcontas)     + ", " + ;
                EscaparSQL(THIS.this_cTvens)       + ", " + ;
                EscaparSQL(THIS.this_cCarauts)     + ", " + ;
                EscaparSQL(THIS.this_cColdados)    + ", " + ;
                EscaparSQL(THIS.this_cHists)       + ", " + ;
                EscaparSQL(THIS.this_cCcupomnvs)   + ", " + ;
                EscaparSQL(THIS.this_cOperautos)   + ", " + ;
                EscaparSQL(THIS.this_cOperacaoss)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaoes)  + ", " + ;
                EscaparSQL(THIS.this_cCpictures)   + ", " + ;
                EscaparSQL(THIS.this_cGarantias)   + ", " + ;
                EscaparSQL(THIS.this_cLcartao)     + ", " + ;
                EscaparSQL(THIS.this_cLsaque)      + ", " + ;
                EscaparSQL(THIS.this_cOpers)       + ", " + ;
                EscaparSQL(THIS.this_cParcs)       + ", " + ;
                EscaparSQL(THIS.this_cAutotef)     + ", " + ;
                EscaparSQL(THIS.this_cTcdc)        + ", " + ;
                EscaparSQL(THIS.this_cPcheque)     + ", " + ;
                EscaparSQL(THIS.this_cDadchqs)     + ", " + ;
                EscaparSQL(THIS.this_cCodestabs)   + ", " + ;
                EscaparSQL(THIS.this_cCitems)      + ", " + ;
                EscaparSQL(THIS.this_cDcarts)      + ", " + ;
                EscaparSQL(THIS.this_cAdquirente)  + ", " + ;
                EscaparSQL(THIS.this_cEmps)        + ", " + ;
                EscaparSQL(THIS.this_cParcfin)     + ", " + ;
                EscaparSQL(THIS.this_cParcini)     + ", " + ;
                EscaparSQL(THIS.this_cBandeira)    + ", " + ;
                EscaparSQL(THIS.this_cCdcashback)  + ", " + ;
                EscaparSQL(THIS.this_cEspecies)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoemp)    + ", " + ;
                EscaparSQL(THIS.this_cMfinancs)    + ", " + ;
                loc_cDatatrans                          + ", " + ;
                FormatarNumeroSQL(THIS.this_nAprovas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nItemobrigs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomis)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpags)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesc2s)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nDescs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDias)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmichqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEncargos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nEntradas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFparcs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nFpcomiss)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrazos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTrocos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValpends)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpnotas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpdups)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nObs)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTphists)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcodfinzs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmivales)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nGavetas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpcheques) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaixas)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nMesfec)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcvchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcumulas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nPromos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgcobs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTolfcxs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpvencs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvarias)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndices)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibcsens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpcpchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqtabds)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkbins)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkfidels) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfinancs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpcsnas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrfpgs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLiscongv)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCnidtefs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nDetFecCxs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTaxjuros)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdtcomis)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcpf)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibctablq) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNsu)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nChklimcre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRelsomsub) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkvalgar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChknccmov) + ", " + ;
                FormatarNumeroSQL(THIS.this_nArredonda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcachbk) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nAutoriza)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrminpar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nRelmetvend)+ ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Inserir: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "UPDATE SigOpFp SET " + ;
                "descrs = "       + EscaparSQL(THIS.this_cDescrs)     + ", " + ;
                "titfpags = "     + EscaparSQL(THIS.this_cTitfpags)   + ", " + ;
                "formas = "       + EscaparSQL(THIS.this_cFormas)     + ", " + ;
                "moefpgs = "      + EscaparSQL(THIS.this_cMoefpgs)    + ", " + ;
                "infos = "        + EscaparSQL(THIS.this_cInfos)      + ", " + ;
                "situas = "       + EscaparSQL(THIS.this_cSituas)     + ", " + ;
                "codfpags = "     + EscaparSQL(THIS.this_cCodfpags)   + ", " + ;
                "nfpags = "       + FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                "modpagto = "     + EscaparSQL(THIS.this_cModpagto)   + ", " + ;
                "grupods = "      + EscaparSQL(THIS.this_cGrupods)    + ", " + ;
                "contads = "      + EscaparSQL(THIS.this_cContads)    + ", " + ;
                "dcontads = "     + EscaparSQL(THIS.this_cDcontads)   + ", " + ;
                "orides = "       + FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                "grupoos = "      + EscaparSQL(THIS.this_cGrupoos)    + ", " + ;
                "contaos = "      + EscaparSQL(THIS.this_cContaos)    + ", " + ;
                "dcontaos = "     + EscaparSQL(THIS.this_cDcontaos)   + ", " + ;
                "grupobs = "      + EscaparSQL(THIS.this_cGrupobs)    + ", " + ;
                "contabs = "      + EscaparSQL(THIS.this_cContabs)    + ", " + ;
                "grupots = "      + EscaparSQL(THIS.this_cGrupots)    + ", " + ;
                "contats = "      + EscaparSQL(THIS.this_cContats)    + ", " + ;
                "bancos = "       + EscaparSQL(THIS.this_cBancos)     + ", " + ;
                "agencias = "     + EscaparSQL(THIS.this_cAgencias)   + ", " + ;
                "ncontas = "      + EscaparSQL(THIS.this_cNcontas)    + ", " + ;
                "tvens = "        + EscaparSQL(THIS.this_cTvens)      + ", " + ;
                "carauts = "      + EscaparSQL(THIS.this_cCarauts)    + ", " + ;
                "coldados = "     + EscaparSQL(THIS.this_cColdados)   + ", " + ;
                "hists = "        + EscaparSQL(THIS.this_cHists)      + ", " + ;
                "ccupomnvs = "    + EscaparSQL(THIS.this_cCcupomnvs)  + ", " + ;
                "operautos = "    + EscaparSQL(THIS.this_cOperautos)  + ", " + ;
                "operacaoss = "   + EscaparSQL(THIS.this_cOperacaoss) + ", " + ;
                "operacaoes = "   + EscaparSQL(THIS.this_cOperacaoes) + ", " + ;
                "cpictures = "    + EscaparSQL(THIS.this_cCpictures)  + ", " + ;
                "garantias = "    + EscaparSQL(THIS.this_cGarantias)  + ", " + ;
                "lcartao = "      + EscaparSQL(THIS.this_cLcartao)    + ", " + ;
                "lsaque = "       + EscaparSQL(THIS.this_cLsaque)     + ", " + ;
                "opers = "        + EscaparSQL(THIS.this_cOpers)      + ", " + ;
                "parcs = "        + EscaparSQL(THIS.this_cParcs)      + ", " + ;
                "autotef = "      + EscaparSQL(THIS.this_cAutotef)    + ", " + ;
                "tcdc = "         + EscaparSQL(THIS.this_cTcdc)       + ", " + ;
                "pcheque = "      + EscaparSQL(THIS.this_cPcheque)    + ", " + ;
                "dadchqs = "      + EscaparSQL(THIS.this_cDadchqs)    + ", " + ;
                "codestabs = "    + EscaparSQL(THIS.this_cCodestabs)  + ", " + ;
                "citems = "       + EscaparSQL(THIS.this_cCitems)     + ", " + ;
                "dcarts = "       + EscaparSQL(THIS.this_cDcarts)     + ", " + ;
                "adquirente = "   + EscaparSQL(THIS.this_cAdquirente) + ", " + ;
                "emps = "         + EscaparSQL(THIS.this_cEmps)       + ", " + ;
                "parcfin = "      + EscaparSQL(THIS.this_cParcfin)    + ", " + ;
                "parcini = "      + EscaparSQL(THIS.this_cParcini)    + ", " + ;
                "bandeira = "     + EscaparSQL(THIS.this_cBandeira)   + ", " + ;
                "cdcashback = "   + EscaparSQL(THIS.this_cCdcashback) + ", " + ;
                "especies = "     + EscaparSQL(THIS.this_cEspecies)   + ", " + ;
                "grupoemp = "     + EscaparSQL(THIS.this_cGrupoemp)   + ", " + ;
                "mfinancs = "     + EscaparSQL(THIS.this_cMfinancs)   + ", " + ;
                "datatrans = "    + loc_cDatatrans                         + ", " + ;
                "aprovas = "      + FormatarNumeroSQL(THIS.this_nAprovas)  + ", " + ;
                "itemobrigs = "   + FormatarNumeroSQL(THIS.this_nItemobrigs) + ", " + ;
                "bxcomis = "      + FormatarNumeroSQL(THIS.this_nBxcomis)  + ", " + ;
                "cpags = "        + FormatarNumeroSQL(THIS.this_nCpags)    + ", " + ;
                "desc2s = "       + FormatarNumeroSQL(THIS.this_nDesc2s)   + ", " + ;
                "descs = "        + FormatarNumeroSQL(THIS.this_nDescs)    + ", " + ;
                "dias = "         + FormatarNumeroSQL(THIS.this_nDias)     + ", " + ;
                "emichqs = "      + FormatarNumeroSQL(THIS.this_nEmichqs)  + ", " + ;
                "encargos = "     + FormatarNumeroSQL(THIS.this_nEncargos) + ", " + ;
                "entradas = "     + FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                "fparcs = "       + FormatarNumeroSQL(THIS.this_nFparcs)   + ", " + ;
                "fpcomiss = "     + FormatarNumeroSQL(THIS.this_nFpcomiss) + ", " + ;
                "impbols = "      + FormatarNumeroSQL(THIS.this_nImpbols)  + ", " + ;
                "prazos = "       + FormatarNumeroSQL(THIS.this_nPrazos)   + ", " + ;
                "trocos = "       + FormatarNumeroSQL(THIS.this_nTrocos)   + ", " + ;
                "valpends = "     + FormatarNumeroSQL(THIS.this_nValpends) + ", " + ;
                "impnotas = "     + FormatarNumeroSQL(THIS.this_nImpnotas) + ", " + ;
                "impdups = "      + FormatarNumeroSQL(THIS.this_nImpdups)  + ", " + ;
                "obs = "          + FormatarNumeroSQL(THIS.this_nObs)      + ", " + ;
                "tphists = "      + FormatarNumeroSQL(THIS.this_nTphists)  + ", " + ;
                "ncodfinzs = "    + FormatarNumeroSQL(THIS.this_nNcodfinzs)+ ", " + ;
                "impchqs = "      + FormatarNumeroSQL(THIS.this_nImpchqs)  + ", " + ;
                "emivales = "     + FormatarNumeroSQL(THIS.this_nEmivales) + ", " + ;
                "gavetas = "      + FormatarNumeroSQL(THIS.this_nGavetas)  + ", " + ;
                "tpcheques = "    + FormatarNumeroSQL(THIS.this_nTpcheques)+ ", " + ;
                "baixas = "       + FormatarNumeroSQL(THIS.this_nBaixas)   + ", " + ;
                "bxcomchqs = "    + FormatarNumeroSQL(THIS.this_nBxcomchqs)+ ", " + ;
                "autenticas = "   + FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                "mesfec = "       + FormatarNumeroSQL(THIS.this_nMesfec)   + ", " + ;
                "acvchqs = "      + FormatarNumeroSQL(THIS.this_nAcvchqs)  + ", " + ;
                "acumulas = "     + FormatarNumeroSQL(THIS.this_nAcumulas) + ", " + ;
                "promos = "       + FormatarNumeroSQL(THIS.this_nPromos)   + ", " + ;
                "agcobs = "       + FormatarNumeroSQL(THIS.this_nAgcobs)   + ", " + ;
                "tolfcxs = "      + FormatarNumeroSQL(THIS.this_nTolfcxs)  + ", " + ;
                "tpvencs = "      + FormatarNumeroSQL(THIS.this_nTpvencs)  + ", " + ;
                "pvarias = "      + FormatarNumeroSQL(THIS.this_nPvarias)  + ", " + ;
                "indices = "      + FormatarNumeroSQL(THIS.this_nIndices)  + ", " + ;
                "libcsens = "     + FormatarNumeroSQL(THIS.this_nLibcsens) + ", " + ;
                "impcpchqs = "    + FormatarNumeroSQL(THIS.this_nImpcpchqs)+ ", " + ;
                "blqtabds = "     + FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                "chkbins = "      + FormatarNumeroSQL(THIS.this_nChkbins)  + ", " + ;
                "chkfidels = "    + FormatarNumeroSQL(THIS.this_nChkfidels)+ ", " + ;
                "nfinancs = "     + FormatarNumeroSQL(THIS.this_nNfinancs) + ", " + ;
                "opcsnas = "      + FormatarNumeroSQL(THIS.this_nOpcsnas)  + ", " + ;
                "vlrfpgs = "      + FormatarNumeroSQL(THIS.this_nVlrfpgs)  + ", " + ;
                "liscongv = "     + FormatarNumeroSQL(THIS.this_nLiscongv) + ", " + ;
                "cnidtefs = "     + FormatarNumeroSQL(THIS.this_nCnidtefs) + ", " + ;
                "DetFecCxs = "    + FormatarNumeroSQL(THIS.this_nDetFecCxs)+ ", " + ;
                "taxjuros = "     + FormatarNumeroSQL(THIS.this_nTaxjuros) + ", " + ;
                "ndtcomis = "     + FormatarNumeroSQL(THIS.this_nNdtcomis) + ", " + ;
                "chkcpf = "       + FormatarNumeroSQL(THIS.this_nChkcpf)   + ", " + ;
                "libctablq = "    + FormatarNumeroSQL(THIS.this_nLibctablq)+ ", " + ;
                "nsu = "          + FormatarNumeroSQL(THIS.this_nNsu)      + ", " + ;
                "chklimcre = "    + FormatarNumeroSQL(THIS.this_nChklimcre)+ ", " + ;
                "relsomsub = "    + FormatarNumeroSQL(THIS.this_nRelsomsub)+ ", " + ;
                "chkvalgar = "    + FormatarNumeroSQL(THIS.this_nChkvalgar)+ ", " + ;
                "chknccmov = "    + FormatarNumeroSQL(THIS.this_nChknccmov)+ ", " + ;
                "arredonda = "    + FormatarNumeroSQL(THIS.this_nArredonda)+ ", " + ;
                "chkcachbk = "    + FormatarNumeroSQL(THIS.this_nChkcachbk)+ ", " + ;
                "chkuticach = "   + FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                "autoriza = "     + FormatarNumeroSQL(THIS.this_nAutoriza) + ", " + ;
                "blqvctopar = "   + FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                "vlrminpar = "    + FormatarNumeroSQL(THIS.this_nVlrminpar)+ ", " + ;
                "vlrlimfpgs = "   + FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                "optcredcta = "   + FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                "relmetvend = "   + FormatarNumeroSQL(THIS.this_nRelmetvend)+ ;
                " WHERE fpags = " + EscaparSQL(THIS.this_cFpags)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Atualizar: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui o registro e suas filhas
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cFpags, loc_cSQLi, loc_cSQLp, loc_cSQLm
        LOCAL loc_nRi, loc_nRp, loc_nRm, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFpags = EscaparSQL(ALLTRIM(THIS.this_cFpags))

            *-- Exclui filha SigOpFpI
            loc_cSQLi = "DELETE FROM SigOpFpI WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelI")
                TABLEREVERT(.T., "cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            loc_nRi = SQLEXEC(gnConnHandle, loc_cSQLi, "cursor_4c_DelI")
            IF USED("cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            *-- Exclui filha SigOpFpP
            loc_cSQLp = "DELETE FROM SigOpFpP WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelP")
                TABLEREVERT(.T., "cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            loc_nRp = SQLEXEC(gnConnHandle, loc_cSQLp, "cursor_4c_DelP")
            IF USED("cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            *-- Exclui registro principal
            loc_cSQLm = "DELETE FROM SigOpFp WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelM")
                TABLEREVERT(.T., "cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            loc_nRm = SQLEXEC(gnConnHandle, loc_cSQLm, "cursor_4c_DelM")
            IF USED("cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            IF loc_nRm >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.ExecutarExclusao: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE

