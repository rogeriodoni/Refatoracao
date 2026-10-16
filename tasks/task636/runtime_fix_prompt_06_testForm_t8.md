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
[2026-10-16 06:19:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-16 06:19:42] [INFO] Config FPW: (nao fornecido)
[2026-10-16 06:19:42] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-16 06:19:42] [INFO] Timeout: 300 segundos
[2026-10-16 06:19:42] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_e3xisnru.prg
[2026-10-16 06:19:42] [INFO] Conteudo do wrapper:
[2026-10-16 06:19:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprmdp', 'C:\4c\tasks\task636\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprmdp', 'C:\4c\tasks\task636\logs\06_testForm.log'
QUIT

[2026-10-16 06:19:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_e3xisnru.prg
[2026-10-16 06:19:42] [INFO] VFP output esperado em: C:\4c\tasks\task636\vfp_output.txt
[2026-10-16 06:19:42] [INFO] Executando Visual FoxPro 9...
[2026-10-16 06:19:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_e3xisnru.prg
[2026-10-16 06:19:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_e3xisnru.prg
[2026-10-16 06:19:42] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprmdp
Inicio: 16/10/2026 06:19:43

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 16/10/2026 06:22:53
Duracao: 190 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-16 06:22:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-16 06:22:53] [INFO] VFP9 finalizado em 190.2710849 segundos
[2026-10-16 06:22:53] [INFO] Exit Code: 
[2026-10-16 06:22:53] [INFO] 
[2026-10-16 06:22:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-16 06:22:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_e3xisnru.prg
[2026-10-16 06:22:53] [INFO] 
[2026-10-16 06:22:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-16 06:22:53] [INFO] * Auto-generated wrapper for parameters
[2026-10-16 06:22:53] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-16 06:22:53] [INFO] * Parameters: 'Formsigprmdp', 'C:\4c\tasks\task636\logs\06_testForm.log'
[2026-10-16 06:22:53] [INFO] 
[2026-10-16 06:22:53] [INFO] * Anti-dialog protections for unattended execution
[2026-10-16 06:22:53] [INFO] SET SAFETY OFF
[2026-10-16 06:22:53] [INFO] SET RESOURCE OFF
[2026-10-16 06:22:53] [INFO] SET TALK OFF
[2026-10-16 06:22:53] [INFO] SET NOTIFY OFF
[2026-10-16 06:22:53] [INFO] SYS(2335, 0)
[2026-10-16 06:22:53] [INFO] 
[2026-10-16 06:22:53] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprmdp', 'C:\4c\tasks\task636\logs\06_testForm.log'
[2026-10-16 06:22:53] [INFO] QUIT
[2026-10-16 06:22:53] [INFO] 
[2026-10-16 06:22:53] [INFO] === Fim do Wrapper.prg ===
[2026-10-16 06:22:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg):
*------------------------------------------------------------------------------
* Formsigprmdp.prg - Form Operacional: Substituicao de Referencias de Produtos
* Migrado de: tasks/task636/sigprmdp.SCX
* Tabela principal (fila de recalculo de custo): SigOpClC
*
* FASE 8/8 (FINAL) - liga e implementa os 3 botoes de acao principal via
* BINDEVENT em RegistrarEventos(): cmd_4c_BtnProcessar -> BtnProcessarClick
* (motor de substituicao, delega o SQL para sigprmdpBO.ProcessarPar/
* ValidarParSubstituicao), cmd_4c_Exporta -> ExportaClick (importacao de
* pares via planilha XLS) e cmd_4c_BtnSair -> BtnEncerrarClick (Release).
* O SCX legado NAO tem botao Salvar/Cancelar/Buscar/Alterar/Visualizar
* (form OPERACIONAL, sem modos CRUD) - esses handlers permanecem no-op,
* documentados individualmente. FormParaBO/BOParaForm ganham sentido real
* aqui: copiam o par da linha corrente de cursor_4c_Dados <-> as properties
* this_cProsAnt/this_cProsNov/this_nBarraAnt/this_lFlag do BO.
*
* Fases anteriores: ConfigurarCampos() completa o container cnt_4c_Result
* (cntResult do legado) com o painel de progresso (lbl_4c_Label1
* "Progresso :" + cnt_4c_Barra/shp_4c_ShpBarra/lbl_4c_LblPorcento) e o
* bloco Produto/Arquivo (Fase 5). ConfigurarGrid() tem o UNICO lookup deste
* form (legado: SIGPRMDP.Grade.Column1.Text1.Valid, fwBuscaExt contra
* SigCdPro), instalado via Column.AddObject("txt_4c_CelCprosAnt",
* "TextBoxProdutoAntMdp_4c") + CurrentControl + Sparse (regra #18), com o
* corpo em ValidarCProsAntGridExec (regra #46: Valid do TextBox da coluna,
* nunca AfterRowColChange).
*
* GAP DOCUMENTADO (regra #27): o motor de substituicao do legado varria
* QUALQUER tabela/coluna catalogada no arquivo LOCAL ArqDBF.DBF (FoxPro,
* Sys(5)+Sys(2003)+'\ArqDBF.dbf') e descobria a chave primaria via a view
* vindsql - nenhum dos dois existe no SQL Server (confirmado contra
* docs/schema.sql). sigprmdpBO.MapearTabelasAlvo() reproduz o MESMO filtro
* (mesma lista de 14 nomes de coluna, mesmo limite de tamanho 10/14,
* mesmas exclusoes) via INFORMATION_SCHEMA.COLUMNS, lido do schema REAL e
* atual em vez de um catalogo local que podia estar desatualizado. As
* funcoes globais fRecalculaP()/fRecalculaC() (recalculo de custo/estoque)
* tambem nao vieram no acervo - ProcessarPar() enfileira em SigOpClC para
* recalculo externo em vez de tentar reproduzir o calculo, e NUNCA
* exclui linhas de SigMvEst (a exclusao no legado so era segura porque
* fRecalculaP recriava o saldo sob o codigo novo) - o Form avisa o usuario
* quando ha saldo de SigMvEst aguardando revisao manual.
*------------------------------------------------------------------------------

DEFINE CLASS Formsigprmdp AS FormBase

    Height      = 270
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    KeyPreview  = .T.
    Themes      = .F.
    DataSession = 2

    *-- Flags espelhando as propriedades customizadas do SCX legado
    *-- (ThisForm.Checkcadpro / Manterbarra / Calculacusto). Checkcadpro e
    *-- NomeForm chegam por parametro do Init; Calculacusto e lido do banco
    *-- (SigCdPaC.CalcCustos) na Fase 4, junto com o restante do Load legado.
    this_lCheckCadPro  = .F.
    this_lManterBarra  = .F.
    this_lCalculaCusto = .T.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() e replica os parametros do Init legado
    * (Lparameters pCheckCad, lcNomeFrm1) antes de delegar ao FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lCheckCadPro, par_cNomeForm)
        LOCAL loc_cNomeForm

        THIS.Caption = "Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos"

        THIS.this_lCheckCadPro = (VARTYPE(par_lCheckCadPro) = "L" AND par_lCheckCadPro)

        *-- Legado: lcNomeFrm1 = Upper(Iif(Type('lcNomeFrm1')=='C' And Not Empty(lcNomeFrm1),lcNomeFrm1,ThisForm.Name))
        *-- ThisForm.Manterbarra = (lcNomeFrm1 = 'SIGPRMDPB'). Nao renomeamos
        *-- THIS.Name (renomear Form em runtime nao faz parte da arquitetura
        *-- nova) - so a flag de comportamento e preservada.
        loc_cNomeForm = UPPER(IIF(VARTYPE(par_cNomeForm) = "C" AND !EMPTY(par_cNomeForm), par_cNomeForm, THIS.Name))
        THIS.this_lManterBarra = (loc_cNomeForm == "SIGPRMDPB")

        *-- ShowWindow=0 na classe evitaria travar em VFP9 -T (top-level window
        *-- bloqueante) durante testes automatizados; producao restaura modal aqui.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprmdpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprmdpBO.", ;
                        "Erro em InicializarForm")
            ELSE
                *-- Propaga as flags resolvidas no Init() (par_lCheckCadPro/
                *-- nome do form) para o BO - ValidarParSubstituicao/
                *-- ProcessarPar leem a COPIA do BO, nao a do Form.
                THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
                THIS.this_oBusinessObject.this_lManterBarra = THIS.this_lManterBarra

                *-- Legado (Load): "lcQuery = Select CalcCustos From SigCdPaC
                *-- Order By CalcCustos" + "Thisform.CalculaCusto =
                *-- (CrSigCdPac.CalcCustos <> 3)".
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF USED("cursor_4c_Pac")
                        USE IN cursor_4c_Pac
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos", "cursor_4c_Pac") > 0 ;
                       AND USED("cursor_4c_Pac") AND RECCOUNT("cursor_4c_Pac") > 0
                        THIS.this_lCalculaCusto = (TratarNulo(cursor_4c_Pac.CalcCustos, 0) != 3)
                    ENDIF
                    IF USED("cursor_4c_Pac")
                        USE IN cursor_4c_Pac
                    ENDIF
                ENDIF
                THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto

                *-- Cursor local da grade de edicao (equivalente a csContas do
                *-- Load legado) - tem de existir ANTES de ConfigurarPageFrame
                *-- montar o Grid (regra #41: ControlSource de cursor
                *-- inexistente derruba o Init).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
                INDEX ON CprosAnt + CprosNov TAG Duplica
                INDEX ON CprosAnt TAG CprosAnt
                INDEX ON CprosNov TAG CprosNov
                SET ORDER TO
                INSERT INTO cursor_4c_Dados (CprosAnt, CprosNov) VALUES ("", "")

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)
                THIS.RegistrarEventos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (legado herda de "form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados); o metodo so encadeia os
    * configuradores especificos, na ordem em que o SCX desenha os controles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria o container escuro superior (cntSombra do
    * legado) com os dois labels de titulo (sombra preta + titulo branco).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0,0,0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255,255,255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Shape1 (decorativo, BackStyle=0 + BorderStyle=0 no
    * legado = sem renderizacao, transcrito fielmente) e os 5 botoes de
    * acao do form, todos filhos DIRETOS de THIS (o SCX legado nao os
    * agrupa em CommandGroup/Container). Ordem de criacao segue a arvore do
    * SCX: Shape1, btnSair, btnProcessar, btnExcluir, btnIncluir, Exporta -
    * TODOS depois de ConfigurarCabecalho(), porque Top=3..78 cai DENTRO da
    * faixa do cabecalho (Top=0..80) e precisa desenhar por cima dela
    * (regra #11/#29). Handlers de Click sao ligados nas Fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 502
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top        = 3
            .Left       = 725
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH THIS.cmd_4c_BtnProcessar
            .Top        = 3
            .Left       = 650
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption    = "\<Processar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH THIS.cmd_4c_BtnExcluir
            .Top        = 3
            .Left       = 500
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Caption    = "\<Excluir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
        WITH THIS.cmd_4c_BtnIncluir
            .Top        = 3
            .Left       = 425
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .Caption    = "\<Incluir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Exporta", "CommandButton")
        WITH THIS.cmd_4c_Exporta
            .Top        = 3
            .Left       = 575
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "importar_72.png"
            .Caption    = "\<Importar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (Grade do legado): grid de edicao local
    * dos pares Codigo Original/Novo Codigo, ligado a cursor_4c_Dados
    * (criado em InicializarForm, antes de ConfigurarPageFrame). Colunas
    * simples, sem AddObject de controle customizado (Text1/Header1 nativos,
    * igual ao legado). RecordSource por ultimo, depois de Width/Header -
    * aqui nao ha CarregarLista que rebinde depois (grade de edicao local,
    * nao consulta SQL), entao a ordem nao sofre o reset da regra #41/
    * Problema 48.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        *-- RecordSource/ColumnCount ANTES da configuracao das colunas (regra
        *-- #41/Problema 48): mexer neles DEPOIS reseta Width/Header/
        *-- CurrentControl das colunas ja configuradas.
        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount  = 2

        WITH loc_oGrid
            .Top               = 101
            .Left              = 147
            .Width             = 269
            .Height            = 148
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 18
            .RowHeight         = 18
            .ScrollBars        = 2
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width             = 118
            .ReadOnly          = .F.
            .Header1.Caption   = "C" + CHR(243) + "digo Original"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Dados.CprosAnt"
        ENDWITH

        *-- Lookup de produto (legado: Column1.Text1.Valid, com Checkcadpro=.F.
        *-- chama fwBuscaExt contra SigCdPro). Column.AddObject sozinho NAO
        *-- exibe o controle - precisa de CurrentControl + Sparse (regra #18);
        *-- a validacao mora no Valid do TextBox da coluna (regra #46), NUNCA
        *-- em AfterRowColChange.
        loc_oGrid.Column1.AddObject("txt_4c_CelCprosAnt", "TextBoxProdutoAntMdp_4c")
        loc_oGrid.Column1.CurrentControl = "txt_4c_CelCprosAnt"
        loc_oGrid.Column1.Sparse         = .F.

        WITH loc_oGrid.Column2
            .Width             = 118
            .ReadOnly          = .F.
            .Header1.Caption   = "Novo C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Dados.CprosNov"
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
            WITH loc_oGrid.Column2.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cnt_4c_Result (cntResult do legado): painel que
    * exibe o produto/arquivo em processamento durante btnProcessar.Click.
    * Fica OCULTO por padrao (replica ThisForm.cntResult.Visible = .f. do
    * Init legado - por isso TornarControlesVisiveis filtra este container,
    * ver PROCEDURE TornarControlesVisiveis) e so e exibido explicitamente
    * no inicio do processamento (Fase 7-8).
    *
    * Produto (lbl_4c_Label2 + txt_4c_Cpros), Arquivo/Campo (lbl_4c_Label5 +
    * txt_4c_Arquivo) e, desde a Fase 6, o painel de progresso (lbl_4c_Label1
    * "Progresso :" + cnt_4c_Barra com shp_4c_ShpBarra/lbl_4c_LblPorcento).
    * Ambos os TextBoxes sao ReadOnly: o legado so os preenche por codigo
    * durante o loop de processamento (ThisForm.Grade / controlesReferenciados
    * "Get_Cpros" em btnProcessar.Click) - nao ha Valid/evento de digitacao
    * para eles em comportamento.json.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oResult

        THIS.AddObject("cnt_4c_Result", "Container")
        loc_oResult = THIS.cnt_4c_Result
        WITH loc_oResult
            .Top         = 101
            .Left        = 440
            .Width       = 213
            .Height      = 146
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH

        loc_oResult.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oResult.lbl_4c_Label2
            .Top       = 2
            .Left      = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto : "
        ENDWITH

        loc_oResult.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oResult.txt_4c_Cpros
            .Top      = 19
            .Left     = 5
            .Width    = 108
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        loc_oResult.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oResult.lbl_4c_Label5
            .Top       = 45
            .Left      = 7
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Arquivo/Campo :"
        ENDWITH

        loc_oResult.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oResult.txt_4c_Arquivo
            .Top      = 62
            .Left     = 4
            .Width    = 204
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        *-- Painel de progresso (Say1 "Progresso :" + cntBarra/shpBarra/
        *-- lblPorcento do legado) - atualizado pelo loop de processamento
        *-- (btnProcessar.Click, Fase 7-8) via
        *-- this_oBusinessObject.this_nProgresso/this_cProdutoAtual/
        *-- this_cArquivoAtual.
        loc_oResult.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oResult.lbl_4c_Label1
            .Top       = 100
            .Left      = 7
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Progresso :"
        ENDWITH

        loc_oResult.AddObject("cnt_4c_Barra", "Container")
        WITH loc_oResult.cnt_4c_Barra
            .Top         = 116
            .Left        = 5
            .Width       = 202
            .Height      = 21
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oResult.cnt_4c_Barra.AddObject("shp_4c_ShpBarra", "Shape")
        WITH loc_oResult.cnt_4c_Barra.shp_4c_ShpBarra
            .Top         = 1
            .Left        = 1
            .Height      = 19
            .Width       = 200
            .BackColor   = RGB(0, 128, 0)
            .BorderColor = RGB(100, 100, 100)
        ENDWITH

        loc_oResult.cnt_4c_Barra.AddObject("lbl_4c_LblPorcento", "Label")
        WITH loc_oResult.cnt_4c_Barra.lbl_4c_LblPorcento
            .Top       = 4
            .Left      = 93
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .Caption   = "0 %"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCProsAntGridExec - Valid da celula "Codigo Original" (Column1)
    * da grade de pares (legado: SIGPRMDP.Grade.Column1.Text1.Valid).
    * par_oTxt eh o TextBox da coluna: dentro do Valid o valor digitado esta
    * em par_oTxt.Value e AINDA NAO chegou ao cursor (regra #46).
    *
    * Legado: "If Not ThisForm.Checkcadpro" - com this_lCheckCadPro = .T.
    * (modo que aceita codigo de produto ainda nao cadastrado em SigCdPro),
    * a validacao eh pulada e o codigo digitado fica como esta.
    *--------------------------------------------------------------------------
    FUNCTION ValidarCProsAntGridExec(par_oTxt)
        LOCAL loc_oBusca, loc_cCpros, loc_oErro

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        IF THIS.this_lCheckCadPro
            RETURN .T.
        ENDIF

        loc_cCpros = ALLTRIM(IIF(VARTYPE(par_oTxt) = "O", par_oTxt.Value, cursor_4c_Dados.CprosAnt))

        *-- Legado: "Else / This.Value = ''" - campo vazio nao abre lookup.
        IF EMPTY(loc_cCpros)
            IF VARTYPE(par_oTxt) = "O"
                par_oTxt.Value = ""
            ENDIF
            SELECT cursor_4c_Dados
            REPLACE CprosAnt WITH "" IN cursor_4c_Dados
            RETURN .T.
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdMdp", "Cpros", loc_cCpros, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init ja resolveu o match exato; so abre o picker se nao achou
                *-- (regra #37) - sem MsgAviso nem clear do digitado (regra #50)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdMdp")
                    IF RECCOUNT("cursor_4c_BuscaProdMdp") > 0
                        SELECT cursor_4c_BuscaProdMdp
                        loc_cCpros = ALLTRIM(cursor_4c_BuscaProdMdp.Cpros)
                        SELECT cursor_4c_Dados
                        REPLACE CprosAnt WITH loc_cCpros IN cursor_4c_Dados
                        *-- O codigo escolhido tem de voltar para a CELULA tambem,
                        *-- senao o texto digitado sobrescreve o cursor (regra #46)
                        IF VARTYPE(par_oTxt) = "O"
                            par_oTxt.Value = loc_cCpros
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigprmdp.ValidarCProsAntGridExec")
        ENDTRY

        IF USED("cursor_4c_BuscaProdMdp")
            USE IN cursor_4c_BuscaProdMdp
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarEventos - vincula eventos dos controles via BINDEVENT.
    * Liga os 2 botoes de manutencao da grade local (cmd_4c_BtnIncluir/
    * cmd_4c_BtnExcluir) e, desde a Fase 8, os 3 botoes de acao principal:
    * cmd_4c_BtnProcessar (btnProcessar.Click legado), cmd_4c_Exporta
    * (Exporta.Click legado - o nome do objeto e "Exporta" mas a Caption e o
    * comportamento sao de IMPORTACAO, mantidos fieis ao legado) e
    * cmd_4c_BtnSair (btnSair.Click legado -> ThisForm.Release). Nao ha
    * botoes Alterar/Visualizar no SCX legado (form OPERACIONAL, sem modos
    * CRUD). TesteAutomatico.prg tambem chama BtnIncluirClick()/
    * BtnExcluirClick() direto no form, sem depender deste BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()
        BINDEVENT(THIS.cmd_4c_BtnIncluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Exporta, "Click", THIS, "ExportaClick")
        BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: cnt_4c_Result (painel de progresso, criado na
    * Fase 5) replica o "ThisForm.cntResult.Visible = .f." do Init legado -
    * fica oculto por padrao e so aparece durante o processamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) = "CNT_4C_RESULT"
                    LOOP
                ENDIF
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
    * ConfigurarPaginaLista - form OPERACIONAL sem Page1=Lista; o grid de
    * pares de substituicao (grd_4c_Dados/cursor_4c_Dados) e criado direto
    * no form em ConfigurarGrid() (Fase 4). Metodo mantido apenas por
    * conformidade de contrato com o pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - form OPERACIONAL sem Page2=Dados separada.
    * Metodo mantido apenas por conformidade de contrato com o pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - form OPERACIONAL sem PageFrame; nao ha alternancia
    * entre paginas. par_nPagina eh ignorado.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - form OPERACIONAL sem grid de registros do banco.
    * cursor_4c_Dados eh grade de EDICAO local (pares a trocar), populada
    * por BtnIncluirClick/Exporta, nao por uma consulta de listagem.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - form OPERACIONAL sem modos CRUD
    * (LISTA/INCLUIR/ALTERAR/VISUALIZAR). Metodo mantido por conformidade.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Append Blank em cursor_4c_Dados (legado: btnIncluir.
    * Click), so quando a ultima linha ja tem os dois codigos preenchidos -
    * evita acumular linhas vazias ao clicar repetidamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF !EMPTY(CprosAnt) AND !EMPTY(CprosNov)
            APPEND BLANK
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - nao ha botao Alterar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - nao ha botao Visualizar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Delete na linha corrente de cursor_4c_Dados (legado:
    * btnExcluir.Click). Sem confirmacao e sem PACK, igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        DELETE

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - nao ha botao Buscar no layout do SCX legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - nao ha botao "Salvar" no SCX legado; a acao principal
    * deste form e "Processar" (btnProcessar.Click -> BtnProcessarClick(),
    * ligado em RegistrarEventos a cmd_4c_BtnProcessar). Mantido no-op por
    * conformidade de contrato com o pipeline (padrao CRUD).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nao ha botao "Cancelar" no SCX legado; fechar a
    * tela e feito por btnSair.Click -> BtnEncerrarClick() (cmd_4c_BtnSair).
    * Mantido no-op por conformidade de contrato com o pipeline (padrao CRUD).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - legado: SIGPRMDP.btnSair.Click = "ThisForm.Release".
    * Ligado a cmd_4c_BtnSair em RegistrarEventos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - legado: SIGPRMDP.btnProcessar.Click. Valida TODOS
    * os pares da grade (mesma ordem de checagens do Scan csContas legado),
    * pede confirmacao e so entao processa par a par via
    * this_oBusinessObject.ProcessarPar() (motor de substituicao multi-
    * tabela, BO), atualizando o painel de progresso (cnt_4c_Result) a cada
    * par concluido. Para no primeiro par que falhar, igual ao legado
    * (Exit do Scan quando lnErro < 1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_nErro, loc_nTotal, loc_nFeito, loc_lTudoOk, ;
              loc_cProsAnt, loc_cProsNov, loc_nI
        LOCAL ARRAY loc_aPendAnt[1], loc_aPendNov[1]

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP
        IF EOF()
            MsgAviso("N" + CHR(227) + "o Existem Contas a Serem Processadas!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
            RETURN
        ENDIF

        *-- Validacao de TODOS os pares antes de perguntar confirmacao
        *-- (legado: primeiro Scan do btnProcessar.Click so valida e sai com
        *-- Return no primeiro erro, sem perguntar nada ainda).
        SELECT cursor_4c_Dados
        SCAN
            loc_nErro = THIS.this_oBusinessObject.ValidarParSubstituicao( ;
                cursor_4c_Dados.CprosAnt, cursor_4c_Dados.CprosNov)

            DO CASE
            CASE loc_nErro = 1
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga Inv" + CHR(225) + "lida!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            CASE loc_nErro = 2
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antigo Sem Barra !!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            CASE loc_nErro = 3
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Nova Inv" + CHR(225) + "lida!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            CASE loc_nErro = 4
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
                    "ncia Nova Com o Mesmo C" + CHR(243) + "digo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            CASE loc_nErro = 5
                MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
                    "ncia Nova com Controle de Estoque diferente!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
                RETURN
            ENDCASE

            *-- BarraAnt resolvido pela validacao (regra BOParaForm: a
            *-- property do BO e a FONTE, a linha do grid so espelha)
            THIS.BOParaForm()
        ENDSCAN

        IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
            "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
            THIS.cmd_4c_BtnSair.SetFocus()
            RETURN
        ENDIF

        THIS.HabilitarCampos(.F.)
        THIS.cnt_4c_Result.Visible = .T.
        THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = 0
        THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"

        SELECT cursor_4c_Dados
        GO TOP
        loc_nTotal  = RECCOUNT()
        loc_nFeito  = 0
        loc_lTudoOk = .T.

        SCAN
            loc_cProsAnt = cursor_4c_Dados.CprosAnt
            loc_cProsNov = cursor_4c_Dados.CprosNov

            THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(loc_cProsAnt)
            THIS.cnt_4c_Result.Refresh()

            IF THIS.this_oBusinessObject.ProcessarPar(loc_cProsAnt, loc_cProsNov)
                REPLACE Flag WITH .T. IN cursor_4c_Dados
                =fGravarLog("C", THIS.Name, "INSERIR", ;
                    "DE:" + ALLTRIM(loc_cProsAnt) + " PARA:" + ALLTRIM(loc_cProsNov), ;
                    TratarNulo(gc_4c_UsuarioLogado, ""))
            ELSE
                loc_lTudoOk = .F.
            ENDIF

            loc_nFeito = loc_nFeito + 1
            THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = INT((loc_nFeito * 100) / loc_nTotal) * 2
            THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
                ALLTRIM(STR(INT((loc_nFeito * 100) / loc_nTotal))) + " %"
            THIS.cnt_4c_Result.cnt_4c_Barra.Refresh()

            IF !loc_lTudoOk
                EXIT
            ENDIF
        ENDSCAN

        THIS.cnt_4c_Result.Visible = .F.
        THIS.HabilitarCampos(.T.)

        IF loc_lTudoOk
            THIS.LimparCampos()
            MsgInfo("Todos Os Produtos Foram Alterados!!!", "Processamento Encerrado!!!")
        ELSE
            *-- legado: "Delete For flag" (remove so as linhas JA processadas,
            *-- mantendo as ainda nao processadas para reprocessar). Reconstrucao via
            *-- array em vez de DELETE+SET DELETED (DataSession=2 nasce com
            *-- SET DELETED OFF e nao herda o SET global - regra #9.4).
            loc_nI = 0
            SELECT cursor_4c_Dados
            SCAN FOR !Flag
                loc_nI = loc_nI + 1
                DIMENSION loc_aPendAnt[loc_nI], loc_aPendNov[loc_nI]
                loc_aPendAnt[loc_nI] = cursor_4c_Dados.CprosAnt
                loc_aPendNov[loc_nI] = cursor_4c_Dados.CprosNov
            ENDSCAN

            SELECT cursor_4c_Dados
            ZAP
            IF loc_nI = 0
                APPEND BLANK
            ELSE
                FOR loc_nI = 1 TO ALEN(loc_aPendAnt, 1)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_aPendAnt[loc_nI], ;
                            CprosNov WITH loc_aPendNov[loc_nI] IN cursor_4c_Dados
                ENDFOR
            ENDIF
            GO TOP

            MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", "Reprocessar!!!")
        ENDIF

        IF THIS.this_oBusinessObject.this_lSigMvEstPendente
            MsgAviso("Saldos de estoque (SigMvEst) ligados a este par precisam de revis" + ;
                CHR(227) + "o manual - o recalculo autom" + CHR(225) + "tico dessa tabela n" + ;
                CHR(227) + "o foi portado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportaClick - legado: SIGPRMDP.Exporta.Click (nome do objeto e
    * "Exporta", mas Caption/comportamento sao de IMPORTACAO de planilha XLS
    * com pares Codigo Original/Novo Codigo - mantido fiel ao legado, so o
    * nome do objeto migrado e que segue o PILAR 3). Ligado a cmd_4c_Exporta
    * em RegistrarEventos.
    *--------------------------------------------------------------------------
    PROCEDURE ExportaClick()
        LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_cProsAnt, loc_cProsNov, ;
              loc_nTotal, loc_nFeito

        loc_cArquivo = GETFILE("XLS")
        IF EMPTY(loc_cArquivo)
            MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !FILE(loc_cArquivo)
            MsgAviso("O arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
                "n" + CHR(227) + "o foi encontrado ou o acesso foi negado!!! Verifique!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF USED("cursor_4c_Importa")
            USE IN cursor_4c_Importa
        ENDIF
        CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
        INDEX ON CprosAnt TAG CprosAnt

        SELECT cursor_4c_Importa
        APPEND FROM (loc_cArquivo) TYPE XLS

        loc_nTotal = RECCOUNT("cursor_4c_Importa")
        loc_nFeito = 0

        SELECT cursor_4c_Importa
        SCAN
            loc_nFeito = loc_nFeito + 1
            WAIT WINDOW "Aguarde Importando Produtos !" + STR(loc_nTotal - loc_nFeito) NOWAIT

            loc_cProsAnt = TratarNulo(cursor_4c_Importa.CprosAnt, "")
            loc_cProsNov = TratarNulo(cursor_4c_Importa.CprosNov, "")

            IF EMPTY(loc_cProsAnt) OR EMPTY(loc_cProsNov) OR ;
               UPPER(ALLTRIM(loc_cProsAnt)) == UPPER(ALLTRIM(loc_cProsNov))
                LOOP
            ENDIF

            IF !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(loc_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTmpPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ImpTmpPro") OR RECCOUNT("cursor_4c_ImpTmpPro") = 0
                    IF USED("cursor_4c_ImpTmpPro")
                        USE IN cursor_4c_ImpTmpPro
                    ENDIF
                    LOOP
                ENDIF
                USE IN cursor_4c_ImpTmpPro
            ENDIF

            *-- Duplicata eh checada pela chave POSICIONAL (CprosAnt+CprosNov,
            *-- os dois C(14)) - NUNCA ALLTRIM aqui, senao o SEEK nunca casa
            *-- (regra #42).
            IF !SEEK(loc_cProsAnt + loc_cProsNov, "cursor_4c_Dados", "Duplica")
                SELECT cursor_4c_Dados
                APPEND BLANK
                REPLACE CprosAnt WITH loc_cProsAnt, CprosNov WITH loc_cProsNov IN cursor_4c_Dados
            ENDIF
        ENDSCAN

        SELECT cursor_4c_Dados
        GO BOTTOM
        THIS.grd_4c_Dados.Refresh()
        WAIT CLEAR

        USE IN cursor_4c_Importa
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia o par da linha CORRENTE de cursor_4c_Dados para
    * this_oBusinessObject (usado antes de validar/processar o par).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cProsAnt  = cursor_4c_Dados.CprosAnt
        THIS.this_oBusinessObject.this_cProsNov  = cursor_4c_Dados.CprosNov
        THIS.this_oBusinessObject.this_lFlag     = cursor_4c_Dados.Flag
        THIS.this_oBusinessObject.this_nBarraAnt = cursor_4c_Dados.BarraAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - grava de volta na linha CORRENTE de cursor_4c_Dados o que
    * this_oBusinessObject resolveu (BarraAnt/Flag) - usado apos
    * ValidarParSubstituicao() (legado: "Replace BarraAnt With CrTmpPro.Cbars
    * in CsContas").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        REPLACE BarraAnt WITH THIS.this_oBusinessObject.this_nBarraAnt, ;
                Flag      WITH THIS.this_oBusinessObject.this_lFlag IN cursor_4c_Dados
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - trava a grade e os 5 botoes de acao durante o
    * processamento (BtnProcessarClick), para o usuario nao reentrar no meio
    * do lote. cmd_4c_BtnSair fica de fora de proposito (permanece
    * acionavel). Nao ha equivalente disso no legado (a modal do
    * MessageBox bloqueava a interacao) - e so uma salvaguarda de UX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = (VARTYPE(par_lHabilitar) != "L" OR par_lHabilitar)

        THIS.grd_4c_Dados.Enabled        = loc_lHabilitar
        THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHabilitar
        THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHabilitar
        THIS.cmd_4c_BtnProcessar.Enabled = loc_lHabilitar
        THIS.cmd_4c_Exporta.Enabled      = loc_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - reseta a grade de pares para 1 linha vazia (legado, no
    * sucesso do btnProcessar.Click: "Set Order To / Zap / Append Blank").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        ZAP
        APPEND BLANK
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form. cursor_4c_Dados eh a grade
    * de edicao (vive por toda a sessao do form); cursor_4c_Importa eh
    * aberto/fechado dentro de ExportaClick() e cursor_4c_Campos dentro de
    * sigprmdpBO.ProcessarPar() - os guards aqui so cobrem o caso de o form
    * ser fechado no meio de uma dessas operacoes (TRY/CATCH quebrado a
    * meio-caminho).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Importa")
            USE IN cursor_4c_Importa
        ENDIF
        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* Classe  : sigprmdpBO
* Herda de: BusinessBase
* Descricao: BO para substituicao de referencias (codigos) de produtos.
*            Valida pares CprosAnt/CprosNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF, alem de
*            registrar controle de recalculo de custo em SigOpClC.
*            Form OPERACIONAL - sem Lista/Page1/Buscar(); this_cTabela so
*            identifica SigOpClC, unica tabela gravada por Inserir/Atualizar.
*==============================================================================
DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Flags de configuracao do processamento (legado: checkcadpro/manterbarra/calculacusto)
    this_lCheckCadPro   = .F.   && Pula a validacao do codigo de produto contra SigCdPro
    this_lManterBarra   = .F.   && Mantem o codigo de barras do produto antigo no produto novo
    this_lCalculaCusto  = .T.   && Recalcula custo (legado le de SigCdPaC.CalcCustos <> 3)

    *-- Estado do progresso (lido pelo Form para atualizar UI - cntResult/cntBarra)
    this_cArquivoAtual  = ""    && Arquivo/campo em processamento (getArquivo.Value)
    this_cProdutoAtual  = ""    && Produto em processamento (Get_Cpros.Value)
    this_nProgresso     = 0     && Progresso 0-100 (lblPorcento.Caption / shpBarra.Width)

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath    = ""

    *-- Par corrente de produtos (usado por CarregarDoCursor - espelha o cursor
    *-- da grade csContas: CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
    this_cProsAnt       = ""    && Codigo de referencia antigo (SigCdPro.Cpros, char(14))
    this_cProsNov       = ""    && Codigo de referencia novo (SigCdPro.Cpros, char(14))
    this_lFlag          = .F.   && Linha ja processada com sucesso (csContas.Flag)
    this_nBarraAnt      = 0     && Codigo de barras do produto antigo (SigCdPro.Cbars)

    *-- Dados do registro de controle de custo gerado no processamento (tabela
    *-- SigOpClC, unica tabela gravada diretamente por este BO - Inserir/Atualizar)
    this_cCidChaves     = ""    && Chave unica do registro (SigOpClC.cidchaves, PK)
    this_cCpros         = ""    && Codigo do produto enfileirado p/ recalculo (SigOpClC.cpros)
    this_cEmps          = ""    && Empresa do registro de custo (SigOpClC.emps)
    this_cEmpCpros      = ""    && Empresa + codigo do produto (SigOpClC.empcpros)
    this_dDatas         = {}    && Data base do recalculo de custo (SigOpClC.datas)
    this_cUsuars        = ""    && Usuario que gerou o registro (SigOpClC.usuars)

    *-- .T. quando o par processado tinha linha(s) em SigMvEst referenciando
    *-- o codigo antigo (ver ProcessarPar - regra #27: fRecalculaP/fRecalculaC
    *-- nao vieram no acervo, e SigMvEst nao e tocado sem elas). O Form usa
    *-- esta flag para avisar o usuario que o saldo precisa de revisao manual.
    this_lSigMvEstPendente = .F.

    *--------------------------------------------------------------------------
    * Init - sem Buscar()/this_oDataAccess (form OPERACIONAL, sem Lista/Page1).
    * this_cTabela/this_cCampoChave apontam para SigOpClC so porque e a UNICA
    * tabela que Inserir()/Atualizar() gravam diretamente (fila de recalculo
    * de custo) - usados por RegistrarAuditoria() para montar o log.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor da
    * grade de pares de substituicao (equivalente a csContas do legado).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProsAnt  = TratarNulo(CprosAnt,  "")
                THIS.this_cProsNov  = TratarNulo(CprosNov,  "")
                THIS.this_lFlag     = TratarNulo(Flag,      .F.)
                THIS.this_nBarraAnt = TratarNulo(BarraAnt,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigprmdpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava na fila de recalculo de custo (tabela SigOpClC), um
    * registro por produto/empresa cujo custo precisa ser reprocessado apos a
    * substituicao de referencia (legado: Insert Into CrSigOpClC no btnProcessar).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpClC (cidchaves, cpros, datas, empcpros, emps, usuars)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigprmdpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente da fila de recalculo de custo
    * (SigOpClC), localizado pela chave unica this_cCidChaves.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpClC
                SET cpros    = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    empcpros = <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    emps     = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprmdpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave real do registro gravado por Inserir/Atualizar
    * (SigOpClC.cidchaves), usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParSubstituicao - replica as 4 validacoes do SCAN csContas do
    * btnProcessar.Click legado, na MESMA ordem. Devolve um codigo em vez de
    * exibir a mensagem/posicionar o foco - isso e decisao do FORM (camadas).
    * Grava THIS.this_nBarraAnt quando acha o produto antigo em SigCdPro
    * (equivalente a "Replace BarraAnt With CrTmpPro.Cbars in CsContas").
    *
    * Retorno:
    *   0 = par valido
    *   1 = codigo antigo vazio, ou nao cadastrado em SigCdPro (e
    *       this_lCheckCadPro = .F.)
    *   2 = produto antigo sem codigo de barras (so quando this_lManterBarra)
    *   3 = codigo novo vazio
    *   4 = codigo antigo e novo iguais
    *   5 = grupos do produto antigo/novo com controle de estoque (Cestoqs)
    *       diferentes
    *--------------------------------------------------------------------------
    FUNCTION ValidarParSubstituicao(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado, loc_nRetorno, loc_lProsseguir
        loc_nRetorno = 0
        loc_lProsseguir = .T.
        THIS.this_nBarraAnt = 0

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            IF EMPTY(par_cProsAnt)
                loc_nRetorno = 1
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ValPro") OR RECCOUNT("cursor_4c_ValPro") = 0
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    loc_nRetorno = 1
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_nBarraAnt = TratarNulo(cursor_4c_ValPro.Cbars, 0)
                    USE IN cursor_4c_ValPro
                ENDIF
            ENDIF

            IF loc_lProsseguir AND THIS.this_lManterBarra AND THIS.this_nBarraAnt = 0
                loc_nRetorno = 2
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(par_cProsNov)
                loc_nRetorno = 3
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND UPPER(ALLTRIM(par_cProsAnt)) == UPPER(ALLTRIM(par_cProsNov))
                loc_nRetorno = 4
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Grupos com controle de estoque (Cestoqs) diferentes entre o
                *-- produto novo e o antigo bloqueiam a troca (legado: LocalPro/
                *-- LocalPro2, Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b)
                loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                    loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2")
                    IF USED("cursor_4c_LocalPro2")
                        IF RECCOUNT("cursor_4c_LocalPro2") > 0 AND ;
                           cursor_4c_LocalPro2.Cestoqs != cursor_4c_LocalPro.Cestoqs
                            loc_nRetorno = 5
                        ENDIF
                        USE IN cursor_4c_LocalPro2
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar par de refer" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ValidarParSubstituicao")
            loc_nRetorno = 1
        ENDTRY

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * MapearTabelasAlvo - Equivalente ao
    *     Select Arquivos, Campos From ArqDBF
    *     Where (Tamanhos=10 Or Tamanhos=14) And Upper(Tipos)='C' And
    *           Arquivos not in (...) And InList(Alltrim(Campos), <14 nomes>)
    * do btnProcessar.Click legado. ArqDBF.DBF era um CATALOGO LOCAL do FoxPro
    * (Sys(5)+Sys(2003)+'\ArqDBF.dbf') - nao existe no SQL Server (regra #14:
    * so o schema.sql/INFORMATION_SCHEMA decide, nunca arquivo local). A MESMA
    * lista de nomes de coluna e o MESMO filtro de tamanho sao aplicados aqui
    * contra o metadado REAL e ATUAL do banco, em vez de um catalogo que podia
    * estar desatualizado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MapearTabelasAlvo()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        TEXT TO loc_cSQL NOSHOW
            SELECT TABLE_NAME AS Arquivos, COLUMN_NAME AS Campos
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE DATA_TYPE IN ('char', 'varchar')
              AND CHARACTER_MAXIMUM_LENGTH IN (10, 14)
              AND UPPER(COLUMN_NAME) IN ('CMATS','CODCONPADS','CODPDS','CODPROPADS',
                  'CPROS','PRODUTO','PRODUTOS','CPROEQS','MATPRINCS','MATS',
                  'MATSUBS','CODGARRAS','OUROS','BRILHANTES')
              AND UPPER(TABLE_NAME) NOT IN ('SIGTEMPD','SIGTEMPC','SIGTEMPR')
            ORDER BY TABLE_NAME
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Campos")
        IF loc_nResultado < 0
            MostrarErro("Erro ao mapear tabelas com refer" + CHR(234) + "ncia a produto:" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteReferencia - .T. se existe ao menos 1 linha de par_cTabela com
    * par_cColuna = par_cValor. Equivalente ao
    *     ThisForm.PodataMgr.CursorQuery('SigCdPro','CrTmpPro','Cpros', ... )
    * e ao padrao "Select X From Y Where Y.X = 'valor' / Reccount(...) > 0"
    * repetido no btnProcessar.Click legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteReferencia(par_cTabela, par_cColuna, par_cValor)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        loc_cSQL = "SELECT TOP 1 " + par_cColuna + " FROM " + par_cTabela + ;
            " WHERE " + par_cColuna + " = " + EscaparSQL(LEFT(ALLTRIM(par_cValor), 14))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Existe")
        IF loc_nResultado > 0 AND USED("cursor_4c_Existe")
            loc_lExiste = (RECCOUNT("cursor_4c_Existe") > 0)
        ENDIF
        IF USED("cursor_4c_Existe")
            USE IN cursor_4c_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnfileirarRecalculoPorPar - Equivalente ao bloco final do legado
    * ("If Used('TmpCustPro') And Thisform.Calculacusto / Scan / Insert Into
    * CrSigOpClC (...) "). TmpCustPro era populado DENTRO de fRecalculaC
    * (funcao global do Fortyus que nao veio no acervo - regra #27); como nao
    * ha como reproduzir o calculo em si, enfileiramos para recalculo externo
    * TODA empresa que tem movimento historico (SigMvHst) para o codigo
    * antigo OU o novo - e' o mesmo universo (Emps) que o legado varria via
    * fRecalculaP/fRecalculaC para montar TmpCustPro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado

        IF !THIS.this_lCalculaCusto
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT Emps FROM SigMvHst WHERE Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14)) + " OR Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsRecalc")
            IF loc_nResultado > 0 AND USED("cursor_4c_EmpsRecalc")
                SELECT cursor_4c_EmpsRecalc
                SCAN
                    THIS.this_cEmps   = TratarNulo(cursor_4c_EmpsRecalc.Emps, "")
                    THIS.this_dDatas  = DATE()
                    THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsAnt)
                    THIS.Inserir()

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsNov)
                    THIS.Inserir()
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao enfileirar recalculo de custo:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.EnfileirarRecalculoPorPar")
        ENDTRY

        IF USED("cursor_4c_EmpsRecalc")
            USE IN cursor_4c_EmpsRecalc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPar - substitui par_cProsAnt por par_cProsNov em todas as
    * tabelas mapeadas por MapearTabelasAlvo() (equivalente ao "Select
    * Arquivos,Campos" + Scan do btnProcessar.Click legado).
    *
    * Casos especiais transcritos literalmente do legado:
    *   SIGPRPRT          -> nunca atualizado (Loop incondicional).
    *   SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT -> quando o codigo NOVO ja existe
    *     como produto cadastrado em SigCdPro: se for SigCdPro.Cpros e
    *     this_lManterBarra, transfere o codigo de barras (Cbars) do antigo
    *     para o novo em vez de renomear; senao, se o codigo ANTIGO tambem
    *     existir como produto distinto, pula a troca (preserva os dois
    *     registros); caso contrario segue para o UPDATE generico.
    *   SIGMVHST/SIGMVEST -> NAO recebem UPDATE/DELETE aqui. O legado dispara
    *     fRecalculaP()/fRecalculaC() (recalculo de custo/estoque) e, so para
    *     SIGMVEST, exclui as linhas do saldo antigo (a recriacao sob o
    *     codigo novo acontecia DENTRO de fRecalculaP). Essas duas funcoes
    *     globais do Fortyus NAO vieram no acervo (regra #27) - excluir
    *     SIGMVEST sem a recriacao destruiria saldo de estoque em SILENCIO,
    *     o que e pior que nao fazer nada. Em vez disso: SigMvHst participa
    *     do UPDATE generico (o legado tambem faz isso - o bloco SIGMVHST
    *     cai no Else por nao ter "Loop"); SigMvEst e so verificado (seta a
    *     flag de alerta correspondente) para o FORM avisar o usuario.
    *
    * Toda a troca das demais tabelas vai num UNICO SQLEXEC (lote T-SQL com
    * SAVE TRANSACTION) - BEGIN/COMMIT em chamadas SEPARADAS de SQLEXEC NAO
    * dao atomicidade nesta conexao (Transactions=2, @@TRANCOUNT ja nasce 1,
    * ver Erro188/ProdutoBO.CopiarProduto).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cProsAntSQL, loc_cProsNovSQL, loc_cLote, loc_cSQL, ;
              loc_cTabela, loc_cColuna, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        loc_cProsAntSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
        loc_cProsNovSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
        THIS.this_lSigMvEstPendente = .F.
        THIS.this_cMensagemErro = ""

        IF !THIS.MapearTabelasAlvo()
            RETURN .F.
        ENDIF

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            loc_cLote = ""

            SELECT cursor_4c_Campos
            SCAN
                loc_cTabela = ALLTRIM(cursor_4c_Campos.Arquivos)
                loc_cColuna = ALLTRIM(cursor_4c_Campos.Campos)

                IF UPPER(loc_cTabela) == "SIGPRPRT"
                    LOOP
                ENDIF

                IF UPPER(loc_cTabela) == "SIGMVEST"
                    THIS.this_lSigMvEstPendente = THIS.this_lSigMvEstPendente OR ;
                        THIS.ExisteReferencia(loc_cTabela, loc_cColuna, par_cProsAnt)
                    LOOP
                ENDIF

                IF INLIST(UPPER(loc_cTabela), "SIGCDPRO", "SIGPRCPO", "SIGCDPRF", "SIGCDPFT") ;
                   AND THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsNov)

                    IF UPPER(loc_cTabela) == "SIGCDPRO" AND UPPER(loc_cColuna) == "CPROS" ;
                       AND THIS.this_lManterBarra
                        loc_cLote = loc_cLote + ;
                            "UPDATE SigCdPro SET Cbars = " + FormatarNumeroSQL(THIS.this_nBarraAnt, 0) + ;
                            " WHERE Cpros = " + loc_cProsNovSQL + "; " + ;
                            "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + loc_cProsAntSQL + "; "
                        LOOP
                    ENDIF

                    IF THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsAnt)
                        *-- codigo antigo TAMBEM existe como produto distinto -
                        *-- preserva os dois, nao mexe nesta coluna
                        LOOP
                    ENDIF
                ENDIF

                *-- UPDATE generico (legado: Update <tabela> Set <coluna> =
                *-- 'novo' Where <coluna> = 'antigo' - com ou sem chave
                *-- primaria o resultado final e o mesmo conjunto de linhas)
                loc_cLote = loc_cLote + ;
                    "UPDATE " + loc_cTabela + " SET " + loc_cColuna + " = " + loc_cProsNovSQL + ;
                    " WHERE " + loc_cColuna + " = " + loc_cProsAntSQL + "; "
            ENDSCAN

            IF !EMPTY(loc_cLote)
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SET NOCOUNT ON;
                    DECLARE @nivel4c int = @@TRANCOUNT;
                    IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Mdp4c;
                    BEGIN TRY
                        <<loc_cLote>>
                        IF @nivel4c = 0 COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        IF @nivel4c = 0
                            BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION END
                        ELSE
                            BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Mdp4c END;
                        THROW;
                    END CATCH
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar refer" + CHR(234) + "ncias de produto:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao processar substitui" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ProcessarPar")
        ENDTRY

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

