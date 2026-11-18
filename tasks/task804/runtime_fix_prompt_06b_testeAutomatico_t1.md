# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[17/11/2026 08:24:30 PM] Erro: Erro em SigOpSnoBO.ListarSubNiveis:Connection handle is invalid.
[17/11/2026 08:24:30 PM] Erro: Erro em SigOpSnoBO.ListarSubSubNiveis:Connection handle is invalid.
[17/11/2026 08:24:30 PM] Erro: Erro em SigOpSnoBO.ListarSubNiveis:Connection handle is invalid.
[17/11/2026 08:24:30 PM] Erro: Erro em SigOpSnoBO.ListarSubSubNiveis:Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-17 20:24:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-17 20:24:30] [INFO] Config FPW: (nao fornecido)
[2026-11-17 20:24:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-17 20:24:30] [INFO] Timeout: 300 segundos
[2026-11-17 20:24:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tuy3iwy5.prg
[2026-11-17 20:24:30] [INFO] Conteudo do wrapper:
[2026-11-17 20:24:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpSno', 'C:\4c\tasks\task804', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpSno', 'C:\4c\tasks\task804', 'OPERACIONAL'
QUIT

[2026-11-17 20:24:30] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tuy3iwy5.prg
[2026-11-17 20:24:30] [INFO] VFP output esperado em: C:\4c\tasks\task804\vfp_output.txt
[2026-11-17 20:24:30] [INFO] Executando Visual FoxPro 9...
[2026-11-17 20:24:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tuy3iwy5.prg
[2026-11-17 20:24:30] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tuy3iwy5.prg
[2026-11-17 20:24:30] [INFO] Timeout configurado: 300 segundos
[2026-11-17 20:24:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-17 20:24:30] [INFO] VFP9 finalizado em 0.5013502 segundos
[2026-11-17 20:24:30] [INFO] Exit Code: 
[2026-11-17 20:24:30] [INFO] 
[2026-11-17 20:24:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-17 20:24:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tuy3iwy5.prg
[2026-11-17 20:24:30] [INFO] 
[2026-11-17 20:24:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-17 20:24:30] [INFO] * Auto-generated wrapper for parameters
[2026-11-17 20:24:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-17 20:24:30] [INFO] * Parameters: 'FormSigOpSno', 'C:\4c\tasks\task804', 'OPERACIONAL'
[2026-11-17 20:24:30] [INFO] 
[2026-11-17 20:24:30] [INFO] * Anti-dialog protections for unattended execution
[2026-11-17 20:24:30] [INFO] SET SAFETY OFF
[2026-11-17 20:24:30] [INFO] SET RESOURCE OFF
[2026-11-17 20:24:30] [INFO] SET TALK OFF
[2026-11-17 20:24:30] [INFO] SET NOTIFY OFF
[2026-11-17 20:24:30] [INFO] SYS(2335, 0)
[2026-11-17 20:24:30] [INFO] 
[2026-11-17 20:24:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpSno', 'C:\4c\tasks\task804', 'OPERACIONAL'
[2026-11-17 20:24:30] [INFO] QUIT
[2026-11-17 20:24:30] [INFO] 
[2026-11-17 20:24:30] [INFO] === Fim do Wrapper.prg ===
[2026-11-17 20:24:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpSno",
  "timestamp": "20261117202430",
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
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPCELULASNO) | KeyPress handlers: 6 (CHKCBXPAGOSKEYPRESS, CHKCKATCTAKEYPRESS, CHKOBRIGSKEYPRESS, CHKPGSUBNNSKEYPRESS, CHKTSTATUSKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSno.prg):
*==============================================================================
* FormSigOpSno.prg - Sub-Niveis da Operacao (popup do cadastro de Operacoes)
* Original: SIGOPSNO.SCX
* Form operacional sem PageFrame: aberto pelo form pai de Operacoes (SigCdOpe),
* gerencia os Sub-Niveis (SigOpCsn) e os Sub-Sub-Niveis (SigOpOss) de uma
* operacao. Pode ser chamado em modo direto (lista os sub-niveis da operacao
* pai) ou em modo inverso (lista as operacoes que usam a pai como sub-nivel).
*==============================================================================
DEFINE CLASS FormSigOpSno AS FormBase

    *-- Referencia ao form pai (desabilitado enquanto este form esta aberto)
    this_oParentForm = .NULL.

    *-- Codigo da operacao pai (SigCdOpe.Dopes) cujos sub-niveis sao geridos aqui
    this_cOperacaoPai = ""

    *-- Modo de chamada do form pai (INSERIR/ALTERAR/VISUALIZAR) - decide a
    *-- visibilidade dos botoes Inserir/Excluir (equivalente a pcEscolha do legado)
    this_cEscolha = ""

    *-- .T. = chamado a partir da tela do Sub-Nivel (a grade passa a listar as
    *-- operacoes que usam a operacao pai como sub-nivel); .F. = chamado a
    *-- partir da Operacao (a grade lista os sub-niveis da operacao pai).
    *-- Equivalente a plInverte do legado.
    this_lModoInverso = .F.

    *-- .T. quando algum lookup de celula da grade alterou dado (equivalente
    *-- ao ThisForm.lHouveAlt do legado, setado nos Valid de Column1/7/8 de
    *-- grd_4c_SubN e de Column1 de grd_4c_SubS) - consultado pelo botao
    *-- Encerrar para decidir se ha algo a persistir.
    this_lHouveAlt = .F.

    *-- Equivalentes a ThisForm.lHouveIns/lHouveExcl do legado - junto com
    *-- this_lHouveAlt, decidem se cmd_4c_Sair tem alguma coisa a gravar.
    this_lHouveIns  = .F.
    this_lHouveExcl = .F.

    *-- Listas separadas por "|" com os cidchaves de linhas criadas NESTA
    *-- sessao (ainda nao persistidas) - decide Inserir/NovoRegistro() x
    *-- Atualizar/EditarRegistro() no funil de gravacao do Encerrar. Sem
    *-- buffer de VFP (view remota com TableUpdate), e preciso rastrear isso
    *-- manualmente: aqui nao ha como distinguir "linha nova" de "linha
    *-- carregada do banco" so pelo conteudo do cursor.
    this_cCidChavesNovas         = ""    && grd_4c_SubN / cursor_4c_SubNiveis (SigOpCsn)
    this_cCidChavesOssNovas      = ""    && grd_4c_SubS / cursor_4c_SubSubNiveis (SigOpOss)

    *-- Snapshot dos cidchaves de SigOpOss que JA existiam no banco quando o
    *-- form abriu (capturado em CarregarDados) - usado no Encerrar para
    *-- saber se uma linha agora em branco/excluida precisa de DELETE no SQL
    *-- Server ou so foi descartada localmente (nunca foi gravada).
    this_cCidChavesOssOriginais  = ""

    *-- Propriedades visuais (replicadas do SIGOPSNO.SCX)
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Height       = 430
    Width        = 620
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Movable      = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Verdana"
    FontSize     = 8
    MaxButton    = .F.

    *==========================================================================
    * Init - Recebe o form pai e o contexto de chamada, desabilita o pai
    * enquanto o popup estiver aberto.
    * par_oParentForm  : referencia ao form de Operacoes (SigCdOpe) que abriu
    *                     este popup
    * par_cOperacaoPai  : codigo da operacao pai (SigCdOpe.Dopes)
    * par_cEscolha      : modo do form pai (INSERIR/ALTERAR/VISUALIZAR)
    * par_lModoInverso  : .T. = modo inverso (ver this_lModoInverso)
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_cOperacaoPai, par_cEscolha, par_lModoInverso)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
                THIS.this_oParentForm         = par_oParentForm
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
            THIS.this_cEscolha     = IIF(VARTYPE(par_cEscolha)     = "C", par_cEscolha,     "")
            THIS.this_lModoInverso = IIF(VARTYPE(par_lModoInverso) = "L", par_lModoInverso, .F.)

            *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY do DataSession=2)
            *-- e em seguida THIS.InicializarForm()
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Sub-N" + CHR(237) + "veis da Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e a interface do usuario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_cTitulo, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET
            *-- DELETED nao herda o SET DELETED ON do config.prg. Sem repor
            *-- aqui, o DELETE local de CmdExcluirClick marca a linha mas ela
            *-- continua aparecendo em grd_4c_SubN (o Skip/Skip-1 do legado so
            *-- funciona com DELETED ON) - usuario clica Excluir e nada muda
            *-- na tela.
            SET DELETED ON

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpSnoBO")
            THIS.ForeColor            = RGB(36, 84, 155)

            *-- Titulo baseado na operacao pai e no modo (direto/inverso),
            *-- igual ao legado (lcOperacao = crSigCdOpe.Dopes no Init do SCX)
            IF THIS.this_lModoInverso
                loc_cTitulo = "Opera" + CHR(231) + CHR(245) + "es do Sub-N" + CHR(237) + "vel " + ;
                              ALLTRIM(PROPER(THIS.this_cOperacaoPai))
            ELSE
                loc_cTitulo = "Subn" + CHR(237) + "veis da Opera" + CHR(231) + CHR(227) + "o " + ;
                              ALLTRIM(PROPER(THIS.this_cOperacaoPai))
            ENDIF
            THIS.Caption = loc_cTitulo

            *-- Fundo do form (new_background.jpg do legado, pasta vbmp)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Cria containers e controles base
            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Fase 4: grades de Sub-Nivel/Sub-Sub-Nivel (estrutura, sem bind)
            *-- e os botoes Inserir/Excluir/Encerrar + separador. Top=3..36 cai
            *-- DENTRO da area do cabecalho (Top=0..80 - regra #11), por isso
            *-- sao criados DEPOIS dele, para desenhar por cima.
            THIS.ConfigurarGradeSubN()
            THIS.ConfigurarGradeSubS()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarLegendas()

            *-- Fase 6: liga os eventos dos CheckBox O/P/C/S/T da grade de
            *-- sub-niveis e o AfterRowColChange mestre-detalhe. Vai DEPOIS
            *-- de ConfigurarGradeSubN/SubS (os controles tem de existir) e
            *-- ANTES de CarregarDados - religar apos a carga duplicaria o
            *-- handler e o toggle se anularia.
            THIS.ConfigurarBINDEVENTs()

            THIS.TornarControlesVisiveis(THIS)

            *-- Fase 4: funil unico de carga - religa as duas grades ao
            *-- resultado do BO e repinta (regra #21)
            THIS.CarregarDados()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria os containers base do form operacional
    * Form OPERACIONAL sem PageFrame (SIGOPSNO legado eh single-page)
    * Fase 3: apenas o cabecalho (cnt_4c_Cabecalho)
    * Fase 4: GradeSubN, GradeSubS, os botoes Inserir/Excluir/Encerrar e o
    *         Shape separador (shp_4c_Separador)
    * Fase 5: labels de legenda (Say1 a Say5) - ver ConfigurarLegendas()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            *-- Cabecalho escuro (cntSombra do legado: Top=0, W=800, H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 20
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 20
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGradeSubN - grd_4c_SubN (mapeamento.json: SIGOPSNO.GradeSubN)
    * 9 colunas transcritas do dump (tasks\task804\SigOpSno_form_codigo_fonte.
    * txt). Colunas 3/4/5/6/9 sao CheckBox de grade (flags O/P/C/S/T); as
    * demais sao TextBox.
    *
    * SO propriedade que NAO depende de dado (regra #41): geometria,
    * ColumnCount, Movable/Resizable/ReadOnly, fontes, cores e InputMask. O
    * bind (RecordSource/ControlSource/Width/Header1.Caption) mora em
    * VincularGradeSubN(), chamado pelo funil CarregarDados().
    *
    * Column3/4/5/6/9 tem Check1 no dump mas so Column9 declara
    * CurrentControl="Check1" explicitamente - sem o CurrentControl nos
    * demais a coluna continua desenhando o Text1 e o CheckBox nunca aparece
    * (regra #18). Os cinco recebem CurrentControl + Sparse = .F. aqui.
    *
    * RecordMark/DeleteMark = .F. (regra do projeto para Grid criado por
    * AddObject em form OPERACIONAL).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeSubN()
        THIS.AddObject("grd_4c_SubN", "Grid")

        WITH THIS.grd_4c_SubN
            .Top           = 173
            .Left          = 7
            .Width         = 394
            .Height        = 238
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 9
        ENDWITH

        *-- Column1 - Operacao Sub-Nivel (editavel: codigo digitado p/ Inserir)
        WITH THIS.grd_4c_SubN.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 150
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o Sub-N" + CHR(237) + "vel"
            .Header1.ForeColor = RGB(255, 0, 0)
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)

            *-- Lookup de Operacao (legado: fwBuscaExt contra SigCdOpe) -
            *-- celula com When/Valid/LostFocus embutidos (regra #18/#46),
            *-- instalada POR CIMA do Text1 (CurrentControl)
            .AddObject("txt_4c_Operacao", "TextBoxCelulaSno_4c")
            .txt_4c_Operacao.this_cCelula = "OPERACAO"
            .CurrentControl = "txt_4c_Operacao"
            .Sparse         = .F.
        ENDWITH

        *-- Column2 - # (nDopes, numero sequencial da operacao) - ReadOnly
        WITH THIS.grd_4c_SubN.Column2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 38
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "9999"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "  #  "
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 - "O" = Obrigatorio (CheckBox)
        WITH THIS.grd_4c_SubN.Column3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 21
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .BackColor = RGB(255, 125, 125)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "O"
        ENDWITH
        THIS.grd_4c_SubN.Column3.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_SubN.Column3.Check1
            .Top       = 30
            .Left      = 5
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 125, 125)
        ENDWITH
        THIS.grd_4c_SubN.Column3.CurrentControl = "Check1"

        *-- Column4 - "P" = Baixa SubNivel do SubNivel c/Pago (CheckBox)
        WITH THIS.grd_4c_SubN.Column4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 21
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .BackColor = RGB(204, 230, 255)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "P"
            .Header1.ForeColor = RGB(0, 128, 255)
        ENDWITH
        THIS.grd_4c_SubN.Column4.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_SubN.Column4.Check1
            .Top       = 30
            .Left      = 7
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(204, 230, 255)
        ENDWITH
        THIS.grd_4c_SubN.Column4.CurrentControl = "Check1"

        *-- Column5 - "C" = Cancela Baixa SubNivel do SubNivel c/Pago (CheckBox)
        WITH THIS.grd_4c_SubN.Column5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 21
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .BackColor = RGB(255, 203, 151)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "C"
            .Header1.ForeColor = RGB(255, 128, 0)
        ENDWITH
        THIS.grd_4c_SubN.Column5.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_SubN.Column5.Check1
            .Top       = 30
            .Left      = 4
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 203, 151)
        ENDWITH
        THIS.grd_4c_SubN.Column5.CurrentControl = "Check1"

        *-- Column6 - "S" = Controle de Status (Aprovado/Reprovado) (CheckBox)
        WITH THIS.grd_4c_SubN.Column6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 21
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .BackColor = RGB(255, 230, 255)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "S"
        ENDWITH
        THIS.grd_4c_SubN.Column6.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_SubN.Column6.Check1
            .Top       = 31
            .Left      = 5
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .BackColor = RGB(255, 230, 255)
        ENDWITH
        THIS.grd_4c_SubN.Column6.CurrentControl = "Check1"

        *-- Column7 - Obs (codigo da observacao, numeric(3,0), TextBox)
        WITH THIS.grd_4c_SubN.Column7
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 8
            .Width       = 31
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .InputMask   = "999"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Obs"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.InputMask   = "999"
            .Text1.Margin      = 0
            .Text1.MaxLength   = 3
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)

            *-- Lookup de Observacao (legado: fwBuscaExt contra SigCdObs) -
            *-- celula com Valid embutido (regra #18/#46)
            .AddObject("txt_4c_Obs", "TextBoxCelulaSno_4c")
            .txt_4c_Obs.this_cCelula = "OBS"
            .txt_4c_Obs.InputMask    = "999"
            .CurrentControl = "txt_4c_Obs"
            .Sparse         = .F.
        ENDWITH

        *-- Column8 - Tp.Fat (tipo de faturamento, char(3), TextBox)
        WITH THIS.grd_4c_SubN.Column8
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 9
            .Width       = 31
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Tp.Fat"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)

            *-- Lookup de Tipo de Faturamento (legado: fwBuscaExt contra
            *-- SigCdTif) - celula com Valid embutido (regra #18/#46)
            .AddObject("txt_4c_TpFat", "TextBoxCelulaSno_4c")
            .txt_4c_TpFat.this_cCelula = "TPFAT"
            .txt_4c_TpFat.MaxLength    = 3
            .CurrentControl = "txt_4c_TpFat"
            .Sparse         = .F.
        ENDWITH

        *-- Column9 - "T" = Atualiza Grupo/Conta de Origem conforme SubNivel
        *-- (CheckBox - dump ja declara CurrentControl="Check1" para esta)
        WITH THIS.grd_4c_SubN.Column9
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 7
            .Width       = 21
            .Movable     = .F.
            .Resizable   = .F.
            .Sparse      = .F.
            .BackColor   = RGB(128, 255, 0)
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "T"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(128, 255, 0)
        ENDWITH
        THIS.grd_4c_SubN.Column9.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_SubN.Column9.Check1
            .Top       = 27
            .Left      = 4
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
        ENDWITH
        THIS.grd_4c_SubN.Column9.CurrentControl = "Check1"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGradeSubS - grd_4c_SubS (mapeamento.json: SIGOPSNO.GradeSubS)
    * 1 coluna, lista os sub-sub-niveis (SigOpOss.Dopess) do sub-nivel
    * CORRENTE da grade acima. O filtro por linha corrente (Set Key To) eh
    * feito no AfterRowColChange - Fase 8; aqui so a estrutura (regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeSubS()
        THIS.AddObject("grd_4c_SubS", "Grid")

        WITH THIS.grd_4c_SubS
            .Top           = 173
            .Left          = 410
            .Width         = 182
            .Height        = 238
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 2
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 1
        ENDWITH

        WITH THIS.grd_4c_SubS.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 150
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Sub-N" + CHR(237) + "vel do Sub-N" + CHR(237) + "vel"
            .Header1.ForeColor = RGB(255, 0, 0)
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)

            *-- Lookup de Sub-Sub-Nivel (legado: fwBuscaInt local restrito
            *-- as operacoes que usam o sub-nivel corrente como filho) -
            *-- celula com When/Valid/LostFocus embutidos (regra #18/#46)
            .AddObject("txt_4c_SubSub", "TextBoxCelulaSno_4c")
            .txt_4c_SubSub.this_cCelula = "SUBSUB"
            .CurrentControl = "txt_4c_SubSub"
            .Sparse         = .F.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarLegendas - lbl_4c_Label1 a lbl_4c_Label5 (mapeamento.json:
    * Say1 a Say5). Explicam o significado das colunas O/P/C/S/T de
    * grd_4c_SubN. Classe "say" do legado NAO declara Width/Alignment
    * (regra #23): AutoSize=.T. e no-op em Label criado por AddObject, por
    * isso aqui vai Alignment=0 (esquerda, igual ao legado) + Width explicita
    * que caiba o texto - a area (Top=94..166) fica livre, acima das grades
    * (Top=173), sem risco de sobreposicao mesmo com Width generosa.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLegendas()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 7
            .Top       = 94
            .Width     = 300
            .Height    = 14
            .ForeColor = RGB(216, 39, 70)
            .Caption   = "O = Obrigat" + CHR(243) + "rio"
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 7
            .Top       = 108
            .Width     = 400
            .Height    = 14
            .ForeColor = RGB(0, 128, 255)
            .Caption   = "P = Bx SubNivel do SubNivel c/Pago"
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 7
            .Top       = 122
            .Width     = 450
            .Height    = 14
            .ForeColor = RGB(255, 128, 64)
            .Caption   = "C = Cancela Bx SubNivel do SubNivel c/Pago"
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 7
            .Top       = 137
            .Width     = 450
            .Height    = 14
            .ForeColor = RGB(255, 128, 255)
            .Caption   = "S = Controle de Status (Aprovado/Reprovado)"
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Left      = 7
            .Top       = 152
            .Width     = 550
            .Height    = 14
            .ForeColor = RGB(128, 255, 0)
            .Caption   = "T = Atualiza o Grupo e Conta de Origem conforme o SubNivel"
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VincularGradeSubN - liga grd_4c_SubN a cursor_4c_SubNiveis
    *
    * Column1 muda de sentido conforme o modo (regra #41/Problema 48: a
    * largura/caption sao reaplicadas DEPOIS do bind, porque RecordSource as
    * reseta):
    *   - modo DIRETO:  Column1 mostra o CODIGO do sub-nivel (cnivels)
    *   - modo INVERSO: Column1 mostra a OPERACAO que usa esta como sub-nivel
    *     (cdopes) - o cursor traz as duas colunas sempre (SigOpSnoBO.
    *     ListarSubNiveis faz o JOIN com SigCdOpe nos dois modos).
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeSubN()
        LOCAL loc_cColuna1

        IF !USED("cursor_4c_SubNiveis")
            RETURN .F.
        ENDIF

        loc_cColuna1 = IIF(THIS.this_lModoInverso, "cdopes", "cnivels")

        WITH THIS.grd_4c_SubN
            .RecordSource          = ""
            .RecordSource          = "cursor_4c_SubNiveis"
            .Column1.ControlSource = "cursor_4c_SubNiveis." + loc_cColuna1
            .Column2.ControlSource = "cursor_4c_SubNiveis.ndopes"
            .Column3.ControlSource = "cursor_4c_SubNiveis.obrigs"
            .Column4.ControlSource = "cursor_4c_SubNiveis.pgsubnns"
            .Column5.ControlSource = "cursor_4c_SubNiveis.cbxpagos"
            .Column6.ControlSource = "cursor_4c_SubNiveis.tstatus"
            .Column7.ControlSource = "cursor_4c_SubNiveis.codobs"
            .Column8.ControlSource = "cursor_4c_SubNiveis.tpfats"
            .Column9.ControlSource = "cursor_4c_SubNiveis.ckatcta"

            *-- Reaplicar largura/cabecalho DEPOIS do bind (RecordSource reseta)
            .Column1.Width = 150
            .Column2.Width = 38
            .Column3.Width = 21
            .Column4.Width = 21
            .Column5.Width = 21
            .Column6.Width = 21
            .Column7.Width = 31
            .Column8.Width = 31
            .Column9.Width = 21

            .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o Sub-N" + CHR(237) + "vel"
            .Column2.Header1.Caption = "  #  "
            .Column3.Header1.Caption = "O"
            .Column4.Header1.Caption = "P"
            .Column5.Header1.Caption = "C"
            .Column6.Header1.Caption = "S"
            .Column7.Header1.Caption = "Obs"
            .Column8.Header1.Caption = "Tp.Fat"
            .Column9.Header1.Caption = "T"

            *-- CurrentControl/Sparse tambem sao resetados pelo rebind -
            *-- reaplicar (regra #18/Problema 48, idempotente)
            .Column1.CurrentControl = "txt_4c_Operacao"
            .Column1.Sparse         = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Column3.CurrentControl = "Check1"
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Column4.CurrentControl = "Check1"
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Column5.CurrentControl = "Check1"
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Column6.CurrentControl = "Check1"
            .Column7.CurrentControl = "txt_4c_Obs"
            .Column7.Sparse         = .F.
            .Column8.CurrentControl = "txt_4c_TpFat"
            .Column8.Sparse         = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Column9.CurrentControl = "Check1"
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VincularGradeSubS - liga grd_4c_SubS a cursor_4c_SubSubNiveis
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeSubS()
        IF !USED("cursor_4c_SubSubNiveis")
            RETURN .F.
        ENDIF

        WITH THIS.grd_4c_SubS
            .RecordSource          = ""
            .RecordSource          = "cursor_4c_SubSubNiveis"
            .Column1.ControlSource = "cursor_4c_SubSubNiveis.dopess"

            .Column1.Width           = 150
            .Column1.Header1.Caption = "Sub-N" + CHR(237) + "vel do Sub-N" + CHR(237) + "vel"

            *-- CurrentControl/Sparse resetados pelo rebind - reaplicar
            *-- (regra #18/Problema 48, idempotente)
            .Column1.CurrentControl = "txt_4c_SubSub"
            .Column1.Sparse         = .F.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmd_4c_Inserir / cmd_4c_Excluir / cmd_4c_Sair +
    * shp_4c_Separador (mapeamento.json: cmdInserir/cmdExcluir/cmdSair/
    * Shape1). Geometria/Picture/Caption transcritos do dump; propriedades
    * comuns vem da classe fwbtng do Framework legado (Width=80, Height=100,
    * FontBold=.T., FontItalic=.T., FontName="Comic Sans MS", FontSize=8,
    * WordWrap=.T., MousePointer=15, ForeColor=RGB(90,90,90),
    * BackColor=RGB(255,255,255), Themes=.F. - docs\FRAMEWORK_class_codigo_
    * fonte.txt).
    *
    * Visibilidade/Enabled de Inserir/Excluir e a posicao/largura do
    * separador sao TRANSCRITAS do Init legado (nao sao Click - ficam aqui
    * porque sao estado inicial, calculado a partir de this_cEscolha/
    * this_lModoInverso, ja conhecidos neste ponto). Click dos tres botoes
    * fica para fase posterior (nenhum metodo vazio - regra de completude).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lMostraInserirExcluir

        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top         = 3
            .Left        = 394
            .Width        = 80
            .Height       = 100
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes           = .T.
            .TabIndex     = 9
            .Caption      = "Inserir"
            IF FILE(gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            ENDIF
        ENDWITH

        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top          = 3
            .Left         = 469
            .Width        = 80
            .Height       = 100
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes           = .T.
            .TabIndex     = 7
            .Caption      = "Excluir"
            IF FILE(gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            ENDIF
        ENDWITH

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top          = 3
            .Left         = 544
            .Width        = 75
            .Height       = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes           = .T.
            .Cancel       = .T.
            .TabIndex     = 8
            .Caption      = "Encerrar"
            IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDIF
        ENDWITH

        THIS.AddObject("shp_4c_Separador", "Shape")
        WITH THIS.shp_4c_Separador
            .Top         = 7
            .Height      = 29
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        IF THIS.this_lModoInverso
            *-- Modo inverso (legado: .cmdInserir.Visible = .f. / .Enabled = .f.
            *-- / .cmdExcluir.Visible = .f. / .Enabled = .f.)
            THIS.cmd_4c_Inserir.Visible = .F.
            THIS.cmd_4c_Inserir.Enabled = .F.
            THIS.cmd_4c_Excluir.Visible = .F.
            THIS.cmd_4c_Excluir.Enabled = .F.

            THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
            THIS.shp_4c_Separador.Width = THIS.cmd_4c_Sair.Width + 10
        ELSE
            *-- Modo direto: Type('Thisform.PcEscolha') # 'C' do legado
            *-- corresponde aqui a this_cEscolha vazio (Init preserva .F./
            *-- ausencia de parametro como "")
            loc_lMostraInserirExcluir = EMPTY(THIS.this_cEscolha) OR ;
                INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

            THIS.cmd_4c_Inserir.Visible = fChecaAcesso("SigOpSno", "INSERIR") AND loc_lMostraInserirExcluir
            THIS.cmd_4c_Inserir.Enabled = THIS.cmd_4c_Inserir.Visible

            THIS.cmd_4c_Excluir.Visible = fChecaAcesso("SigOpSno", "EXCLUIR") AND loc_lMostraInserirExcluir
            THIS.cmd_4c_Excluir.Enabled = THIS.cmd_4c_Excluir.Visible

            DO CASE
            CASE THIS.cmd_4c_Inserir.Visible
                THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
                THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
            CASE THIS.cmd_4c_Excluir.Visible
                THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
                THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
            OTHERWISE
                THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
                THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
            ENDCASE
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - funil UNICO de carga (regra #21), PUBLIC: o harness de
    * teste automatizado procura este nome via PEMSTATUS. Popula as duas
    * grades a partir do BO e repinta (Select ... Go Top + Refresh), igual
    * ao "ThisForm.GradeSubN.AfterRowColChange()" final do Init legado
    * (sem o filtro por linha - esse mora no AfterRowColChange, Fase 8).
    * Devolve .F. sem estourar quando o BO ainda nao existe (gb_4c_ValidandoUI);
    * nao impede o form de abrir.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cAliasAnterior
        loc_lSucesso = .F.

        *-- Reset do estado de rastreamento (regra: CarregarDados eh o funil
        *-- unico de carga - mesmo chamado uma unica vez hoje, o reset evita
        *-- estado velho sobreviver caso o metodo volte a ser chamado)
        THIS.this_lHouveAlt              = .F.
        THIS.this_lHouveIns               = .F.
        THIS.this_lHouveExcl              = .F.
        THIS.this_cCidChavesNovas         = ""
        THIS.this_cCidChavesOssNovas      = ""
        THIS.this_cCidChavesOssOriginais  = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                IF THIS.this_oBusinessObject.ListarSubNiveis(THIS.this_cOperacaoPai, ;
                       THIS.this_lModoInverso)
                    THIS.VincularGradeSubN()
                    IF USED("cursor_4c_SubNiveis")
                        SELECT cursor_4c_SubNiveis
                        GO TOP
                    ENDIF
                ENDIF

                IF THIS.this_oBusinessObject.ListarSubSubNiveis(THIS.this_cOperacaoPai)
                    THIS.VincularGradeSubS()
                    IF USED("cursor_4c_SubSubNiveis")
                        SELECT cursor_4c_SubSubNiveis
                        GO TOP

                        *-- Snapshot dos cidchaves ja gravados no banco
                        *-- (usado por PersistirSubSubNiveis no Encerrar)
                        loc_cAliasAnterior = ALIAS()
                        SELECT cursor_4c_SubSubNiveis
                        SCAN
                            IF !EMPTY(ALLTRIM(NVL(cidchaves, "")))
                                THIS.this_cCidChavesOssOriginais = ;
                                    THIS.this_cCidChavesOssOriginais + "|" + ALLTRIM(cidchaves)
                            ENDIF
                        ENDSCAN
                        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                            SELECT (loc_cAliasAnterior)
                        ENDIF
                    ENDIF
                ENDIF

                THIS.Refresh()
                IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
                    THIS.grd_4c_SubN.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "grd_4c_SubS", 5)
                    THIS.grd_4c_SubS.Refresh()
                ENDIF

                *-- Legado: o Init termina com ThisForm.GradeSubN.
                *-- AfterRowColChange() - escopa a grade de sub-sub-niveis
                *-- ao sub-nivel da PRIMEIRA linha ja na abertura. Sem esta
                *-- chamada a grade da direita abriria listando os sub-sub-
                *-- niveis de TODOS os sub-niveis da operacao.
                THIS.GradeSubNAfterRowColChange(1)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CelulaSnoEditavel - When das celulas de lookup instaladas em
    * txt_4c_Operacao/txt_4c_Obs/txt_4c_TpFat (grd_4c_SubN) e txt_4c_SubSub
    * (grd_4c_SubS), chamado por TextBoxCelulaSno_4c.When() (textboxgrid
    * lookup.PRG). PUBLIC - a classe delega via THISFORM (regra #46).
    *==========================================================================
    PROCEDURE CelulaSnoEditavel(par_cCelula, par_oTxt)
        DO CASE
        CASE par_cCelula == "OPERACAO"
            *-- Legado (GradeSubN.Column1.Text1.When): Return (crSigOpCsn.
            *-- cDopes = crSigCdOpe.Dopes) And IsEmpty(crSigOpCsn.cNivels) -
            *-- so editavel enquanto a linha ainda nao tem sub-nivel
            *-- definido. No modo inverso Inserir fica desabilitado
            *-- (ConfigurarBotoes), entao nunca ha linha nova para editar.
            IF THIS.this_lModoInverso OR !USED("cursor_4c_SubNiveis")
                RETURN .F.
            ENDIF
            RETURN ALLTRIM(cursor_4c_SubNiveis.cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
                   AND EMPTY(cursor_4c_SubNiveis.cnivels)

        CASE par_cCelula == "SUBSUB"
            *-- Legado (GradeSubS.Column1.Text1.When): Return Not IsEmpty(
            *-- crSigOpCsn.cNivels) - a linha mestre de grd_4c_SubN (sub-
            *-- nivel corrente) precisa ja ter um codigo de operacao.
            IF !USED("cursor_4c_SubNiveis")
                RETURN .F.
            ENDIF
            RETURN !EMPTY(cursor_4c_SubNiveis.cnivels)
        ENDCASE

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarCelulaSnoExec - Valid das celulas de lookup (regra #46: valida
    * na saida da CELULA, nunca em AfterRowColChange). Recebe o proprio
    * TextBox - dentro do Valid o valor digitado esta em par_oTxt.Value e
    * AINDA NAO chegou ao cursor da grade (regra #46).
    *==========================================================================
    PROCEDURE ValidarCelulaSnoExec(par_cCelula, par_oTxt)
        DO CASE
        CASE par_cCelula == "OPERACAO" OR par_cCelula == "TPFAT"
            IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, "")))
                RETURN .T.
            ENDIF

        CASE par_cCelula == "OBS"
            IF NVL(par_oTxt.Value, 0) = 0
                RETURN .T.
            ENDIF

        CASE par_cCelula == "SUBSUB"
            IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) OR !USED("cursor_4c_SubNiveis") ;
               OR EMPTY(ALLTRIM(cursor_4c_SubNiveis.cnivels))
                RETURN .T.
            ENDIF
        ENDCASE

        THIS.ResolverLookupCelulaSno(par_cCelula, par_oTxt)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AbrirLookupCelulaSno - F4/F5/duplo clique (afordancia do sistema novo,
    * padrao dos demais lookups de grade do projeto) - abre o picker direto,
    * mesmo com o campo vazio (mostra o universo inteiro).
    *==========================================================================
    PROCEDURE AbrirLookupCelulaSno(par_cCelula, par_oTxt)
        IF par_cCelula == "SUBSUB"
            IF !USED("cursor_4c_SubNiveis") OR EMPTY(ALLTRIM(cursor_4c_SubNiveis.cnivels))
                RETURN
            ENDIF
        ENDIF

        THIS.ResolverLookupCelulaSno(par_cCelula, par_oTxt)
        par_oTxt.Refresh()
    ENDPROC

    *==========================================================================
    * ResolverLookupCelulaSno - corpo comum do Valid e do F4/F5/duplo clique.
    * Tenta o match exato (o Init de FormBuscaAuxiliar ja faz isso - regra
    * #37) e, nao achando, mostra o picker; so atribui par_oTxt.Value sob a
    * guarda this_lSelecionou (regra #37 - nunca fora dela, senao o campo
    * digitado eh zerado quando o usuario cancela).
    *==========================================================================
    PROTECTED PROCEDURE ResolverLookupCelulaSno(par_cCelula, par_oTxt)
        LOCAL loc_cValor, loc_oBusca, loc_cDopesMestre

        loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, "")))

        DO CASE
        CASE par_cCelula == "OPERACAO"
            *-- Legado: fwBuscaExt contra SigCdOpe (Dopes/nDopes)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
                "cursor_4c_BuscaOperSub", "Dopes", loc_cValor, ;
                "Cadastro de Opera" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Ndopes", "", " # ")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperSub")
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperSub.Dopes)
                    *-- Column2 ("#") da grade espelha o ndopes da operacao
                    *-- ESCOLHIDA agora, nao o que veio do JOIN no load inicial
                    IF USED("cursor_4c_SubNiveis")
                        REPLACE cursor_4c_SubNiveis.ndopes WITH NVL(cursor_4c_BuscaOperSub.Ndopes, 0)
                    ENDIF
                    THIS.this_lHouveAlt = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaOperSub")
                USE IN cursor_4c_BuscaOperSub
            ENDIF

        CASE par_cCelula == "OBS"
            *-- Legado: fwBuscaExt contra SigCdObs (Codigos/Observas - mas
            *-- Observas eh MEMO; a grade do picker usa descrs char(80), a
            *-- descricao canonica da tabela, para exibir sem os cuidados de
            *-- memo-em-grid que o legado fazia so com MLine() na coluna)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdObs", ;
                "cursor_4c_BuscaObsSno", "Codigos", loc_cValor, ;
                "Cadastro de Observa" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsSno")
                    par_oTxt.Value = NVL(cursor_4c_BuscaObsSno.Codigos, 0)
                    THIS.this_lHouveAlt = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaObsSno")
                USE IN cursor_4c_BuscaObsSno
            ENDIF

        CASE par_cCelula == "TPFAT"
            *-- Legado: fwBuscaExt contra SigCdTif (Codigos/Descricaos)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTif", ;
                "cursor_4c_BuscaTifSno", "Codigos", loc_cValor, ;
                "Cadastro de Tipo de Faturamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTifSno")
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTifSno.Codigos)
                    THIS.this_lHouveAlt = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaTifSno")
                USE IN cursor_4c_BuscaTifSno
            ENDIF

        CASE par_cCelula == "SUBSUB"
            *-- Legado: lcDopes = crSigOpCsn.cNivels (sub-nivel CORRENTE na
            *-- grade mestre) + Select cDopes From SigOpCsn Where cNivels =
            *-- lcDopes, e o typed value eh buscado NESSE universo (fwBuscaInt
            *-- local) - aqui via FormBuscaAuxiliar + par_cFiltro (regra #36)
            IF !USED("cursor_4c_SubNiveis")
                RETURN
            ENDIF
            loc_cDopesMestre = ALLTRIM(cursor_4c_SubNiveis.cnivels)
            IF EMPTY(loc_cDopesMestre)
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpCsn", ;
                "cursor_4c_BuscaSubSub", "cdopes", loc_cValor, ;
                "Sub-N" + CHR(237) + "veis", .F., .F., ;
                "cnivels = " + EscaparSQL(loc_cDopesMestre))

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cdopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSubSub")
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaSubSub.cdopes)
                    THIS.this_lHouveAlt = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaSubSub")
                USE IN cursor_4c_BuscaSubSub
            ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * CelulaSnoLostFocusExec - LostFocus das celulas de lookup.
    *   OPERACAO - legado: If IsEmpty(This.Value) / ThisForm.cmdSair.SetFocus
    *     (linha ficou sem sub-nivel - foca o botao de saida).
    *   SUBSUB   - legado: garante uma linha vazia em crSigOpOss (Append
    *     Blank com cDopes/cNivels/CidChaves da linha mestre) para o usuario
    *     continuar incluindo sub-sub-niveis sem reclicar em Inserir.
    *==========================================================================
    PROCEDURE CelulaSnoLostFocusExec(par_cCelula, par_oTxt)
        LOCAL loc_cDopesMestre, loc_cNivelsMestre, loc_cAliasAnterior, loc_cNovoId

        DO CASE
        CASE par_cCelula == "OPERACAO"
            IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
                THIS.cmd_4c_Sair.SetFocus()
            ENDIF

        CASE par_cCelula == "SUBSUB"
            IF !EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND USED("cursor_4c_SubNiveis") ;
               AND USED("cursor_4c_SubSubNiveis")
                loc_cDopesMestre  = ALLTRIM(cursor_4c_SubNiveis.cdopes)
                loc_cNivelsMestre = ALLTRIM(cursor_4c_SubNiveis.cnivels)

                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_SubSubNiveis
                LOCATE FOR ALLTRIM(cnivels) == loc_cNivelsMestre AND EMPTY(dopess)
                IF !FOUND()
                    loc_cNovoId = fUniqueIds()
                    APPEND BLANK
                    REPLACE cdopes    WITH loc_cDopesMestre, ;
                            cnivels   WITH loc_cNivelsMestre, ;
                            cidchaves WITH loc_cNovoId
                    THIS.this_cCidChavesOssNovas = THIS.this_cCidChavesOssNovas + "|" + loc_cNovoId
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                THIS.grd_4c_SubS.Refresh()
            ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Fase 6: liga os eventos dos controles criados
    * nas fases anteriores aos metodos PUBLIC deste form.
    *
    * As celulas de LOOKUP (Column1/7/8 de grd_4c_SubN e Column1 de
    * grd_4c_SubS) NAO entram aqui: BINDEVENT em When/Valid/LostFocus de
    * TextBox de Column nao eh confiavel (regra #46), por isso esses eventos
    * moram na classe TextBoxCelulaSno_4c, que delega para
    * CelulaSnoEditavel/ValidarCelulaSnoExec/CelulaSnoLostFocusExec.
    *
    * O que se liga por BINDEVENT:
    *   1) Os CheckBox das colunas O/P/C/S/T de grd_4c_SubN. O legado
    *      SUPRIME o toggle nativo (Click/MouseUp = NoDefault) e alterna o
    *      valor por codigo no MouseDown e no KeyPress (13/32) - sem isso a
    *      marca fica inerte (CLAUDE.md, grid checkbox toggle). Transcrito
    *      do dump: nos cinco CheckBox eh o MouseDown que alterna, NAO o
    *      MouseUp.
    *   2) O AfterRowColChange de grd_4c_SubN, que escopa a grade de
    *      sub-sub-niveis ao sub-nivel da linha corrente - uso legitimo do
    *      evento (mestre-detalhe, regra #46), nao validacao de celula.
    *
    * Chamado UMA unica vez (InicializarForm). Os objetos Check1 sobrevivem
    * ao rebind de RecordSource feito em VincularGradeSubN (so reatribuir
    * ColumnCount recria as Columns - regra #183), entao religar depois da
    * carga duplicaria o handler e o toggle se anularia.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Botoes principais (cmd_4c_Inserir/Excluir/Sair, criados por
        *-- AddObject - sem BINDEVENT o Click deles nunca dispara)
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "CmdSairClick")

        *-- Column3 "O" = Obrigatorio (SigOpCsn.obrigs)
        BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "MouseDown", THIS, "ChkObrigsMouseDown")
        BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "MouseUp",   THIS, "ChkObrigsMouseUp")
        BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "Click",     THIS, "ChkObrigsClick")
        BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "KeyPress",  THIS, "ChkObrigsKeyPress")

        *-- Column4 "P" = Baixa SubNivel do SubNivel c/Pago (SigOpCsn.pgsubnns)
        BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "MouseDown", THIS, "ChkPgSubNnsMouseDown")
        BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "MouseUp",   THIS, "ChkPgSubNnsMouseUp")
        BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "Click",     THIS, "ChkPgSubNnsClick")
        BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "KeyPress",  THIS, "ChkPgSubNnsKeyPress")

        *-- Column5 "C" = Cancela Baixa SubNivel c/Pago (SigOpCsn.cbxpagos)
        BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "MouseDown", THIS, "ChkCbxPagosMouseDown")
        BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "MouseUp",   THIS, "ChkCbxPagosMouseUp")
        BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "Click",     THIS, "ChkCbxPagosClick")
        BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "KeyPress",  THIS, "ChkCbxPagosKeyPress")

        *-- Column6 "S" = Controle de Status Aprovado/Reprovado (SigOpCsn.tstatus)
        BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "MouseDown", THIS, "ChkTStatusMouseDown")
        BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "MouseUp",   THIS, "ChkTStatusMouseUp")
        BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "Click",     THIS, "ChkTStatusClick")
        BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "KeyPress",  THIS, "ChkTStatusKeyPress")

        *-- Column9 "T" = Atualiza Grupo/Conta de Origem (SigOpCsn.ckatcta)
        BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "MouseDown", THIS, "ChkCkAtCtaMouseDown")
        BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "MouseUp",   THIS, "ChkCkAtCtaMouseUp")
        BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "Click",     THIS, "ChkCkAtCtaClick")
        BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "KeyPress",  THIS, "ChkCkAtCtaKeyPress")

        *-- Grade de sub-niveis: troca de linha reescopa a grade de
        *-- sub-sub-niveis (legado: GradeSubN.AfterRowColChange)
        BINDEVENT(THIS.grd_4c_SubN, "AfterRowColChange", THIS, "GradeSubNAfterRowColChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AlternarMarcaSubN - Alterna 0<->1 a coluna numeric(1,0) da linha
    * corrente de cursor_4c_SubNiveis e repinta a grade.
    *
    * Legado (os cinco CheckBox de grd_4c_SubN, MouseDown e KeyPress):
    *     ThisForm.lHouveAlt = .t.
    *     m.<col> = Iif(crSigOpCsn.<col>=1, 0, 1)
    *     Select crSigOpCsn
    *     Gather Memvar Fields <col>
    *     ThisForm.GradeSubN.Refresh
    *
    * As cinco colunas sao numeric(1,0) NOT NULL no schema (SigOpCsn) - o
    * valor alternado eh NUMERICO, nunca logico. REPLACE (expr) WITH aceita
    * name expression em VFP9, e eh a unica forma correta de gravar campo de
    * cursor escolhido em tempo de execucao (STORE TO () falha em campo).
    *
    * O legado NAO condiciona o toggle ao modo: a marca alterna mesmo em
    * VISUALIZAR, e eh o botao Encerrar que decide se grava (ele so persiste
    * quando Inserir ou Excluir estao visiveis). Transcrito assim de
    * proposito - nao acrescentar guard de modo aqui.
    *
    * par_cCampo : nome da coluna do cursor (obrigs/pgsubnns/cbxpagos/
    *              tstatus/ckatcta)
    *==========================================================================
    PROCEDURE AlternarMarcaSubN(par_cCampo)
        LOCAL loc_cAliasAnterior, loc_lFeito, loc_oErro

        loc_lFeito = .F.

        TRY
            IF VARTYPE(par_cCampo) = "C" AND !EMPTY(par_cCampo) ;
               AND USED("cursor_4c_SubNiveis")

                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_SubNiveis

                IF !EOF() AND !BOF()
                    THIS.this_lHouveAlt = .T.
                    REPLACE (par_cCampo) WITH IIF(NVL(EVALUATE(par_cCampo), 0) = 1, 0, 1)
                    loc_lFeito = .T.
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                IF loc_lFeito AND PEMSTATUS(THIS, "grd_4c_SubN", 5)
                    THIS.grd_4c_SubN.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AlternarMarcaSubN")
        ENDTRY

        RETURN loc_lFeito
    ENDPROC

    *==========================================================================
    * Handlers dos CheckBox das colunas O/P/C/S/T de grd_4c_SubN.
    * Um quarteto por coluna porque BINDEVENT nao informa qual controle
    * disparou - os quatro delegam ao funil AlternarMarcaSubN.
    * MouseDown alterna; MouseUp e Click apenas SUPRIMEM o toggle nativo
    * (NODEFAULT), senao o valor alternaria duas vezes e nada mudaria.
    * KeyPress alterna em ENTER(13) e ESPACO(32), igual ao legado.
    *==========================================================================

    *-- Column3 "O" = Obrigatorio
    PROCEDURE ChkObrigsMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaSubN("obrigs")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkObrigsMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkObrigsClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkObrigsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaSubN("obrigs")
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Column4 "P" = Baixa SubNivel do SubNivel c/Pago
    PROCEDURE ChkPgSubNnsMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaSubN("pgsubnns")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkPgSubNnsMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkPgSubNnsClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkPgSubNnsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaSubN("pgsubnns")
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Column5 "C" = Cancela Baixa SubNivel do SubNivel c/Pago
    PROCEDURE ChkCbxPagosMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaSubN("cbxpagos")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCbxPagosMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCbxPagosClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCbxPagosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaSubN("cbxpagos")
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Column6 "S" = Controle de Status (Aprovado/Reprovado)
    PROCEDURE ChkTStatusMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaSubN("tstatus")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTStatusMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTStatusClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaSubN("tstatus")
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Column9 "T" = Atualiza Grupo e Conta de Origem conforme o SubNivel
    PROCEDURE ChkCkAtCtaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaSubN("ckatcta")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCkAtCtaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCkAtCtaClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCkAtCtaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaSubN("ckatcta")
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeSubNAfterRowColChange - escopa grd_4c_SubS ao sub-nivel da linha
    * corrente de grd_4c_SubN (mestre-detalhe). Uso LEGITIMO de
    * AfterRowColChange (regra #46): nao valida celula nenhuma, so reage a
    * troca de linha - por isso NAO filtra por par_nColIndex.
    *
    * Legado (GradeSubN.AfterRowColChange):
    *     Select CrSigOpOss
    *     Set Order To
    *     Set Order To cNivels
    *     Locate For cNivels = crSigOpCsn.cNivels
    *     If Eof()
    *         Append Blank
    *         Replace cNivels With ..., cDopes With ..., CidChaves with fUniqueIds()
    *     Endif
    *     Set Key To crSigOpCsn.cNivels
    *     Go Top
    *     ThisForm.GradeSubS.Refresh
    *     Select CrSigOpCsn
    *
    * O "Set Order To" sem argumento ANTES do "Set Order To cNivels" eh o que
    * derruba o SET KEY da linha anterior - sem ele o LOCATE sairia escopado
    * pelo filtro antigo e sempre cairia em Eof(), inserindo uma linha em
    * branco a cada troca de linha. A chave passada ao SET KEY eh o cnivels
    * INTEIRO (char(20) do cursor), nao um prefixo: com SET EXACT ON ligado
    * no config.prg, chave parcial devolveria zero linhas.
    *
    * O APPEND BLANK grava so no cursor local (a persistencia eh do Encerrar).
    *==========================================================================
    PROCEDURE GradeSubNAfterRowColChange(par_nColIndex)
        LOCAL loc_cNivelsMestre, loc_cDopesMestre, loc_oErro, loc_cNovoId

        TRY
            IF USED("cursor_4c_SubNiveis") AND USED("cursor_4c_SubSubNiveis")
                SELECT cursor_4c_SubNiveis
                IF !EOF() AND !BOF()
                    loc_cNivelsMestre = cursor_4c_SubNiveis.cnivels
                    loc_cDopesMestre  = cursor_4c_SubNiveis.cdopes

                    SELECT cursor_4c_SubSubNiveis
                    SET ORDER TO
                    SET ORDER TO cnivels
                    LOCATE FOR cnivels = loc_cNivelsMestre
                    IF EOF()
                        loc_cNovoId = fUniqueIds()
                        APPEND BLANK
                        REPLACE cnivels   WITH loc_cNivelsMestre, ;
                                cdopes    WITH loc_cDopesMestre,  ;
                                cidchaves WITH loc_cNovoId
                        THIS.this_cCidChavesOssNovas = THIS.this_cCidChavesOssNovas + "|" + loc_cNovoId
                    ENDIF
                    SET KEY TO loc_cNivelsMestre
                    GO TOP

                    IF PEMSTATUS(THIS, "grd_4c_SubS", 5)
                        THIS.grd_4c_SubS.Refresh()
                    ENDIF

                    SELECT cursor_4c_SubNiveis
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GradeSubNAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdInserirClick - cmd_4c_Inserir.Click (so visivel em modo direto -
    * ConfigurarBotoes). Transcrito do legado:
    *     Thisform.lHouveIns = .T.
    *     Select crSigOpCsn
    *     Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
    *     If Eof()
    *         Insert Into crSigOpCsn (cDopes, CidChaves) Values (crSigCdOpe.
    *             Dopes, fUniqueIds())
    *     Endif
    *     Thisform.GradeSubN.Column1.SetFocus
    *
    * So cria a linha em BRANCO no cursor LOCAL - igual ao legado (view
    * buferizada), a gravacao no SQL Server so acontece no Encerrar
    * (PersistirSubNiveis). A linha nova entra em this_cCidChavesNovas para
    * o funil de gravacao saber que eh INSERT, nao UPDATE.
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro

        TRY
            IF USED("cursor_4c_SubNiveis")
                THIS.this_lHouveIns = .T.

                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_SubNiveis

                LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) AND EMPTY(cnivels)
                IF !FOUND()
                    loc_cCidChaves = fUniqueIds()
                    APPEND BLANK
                    REPLACE cdopes    WITH THIS.this_cOperacaoPai, ;
                            cidchaves WITH loc_cCidChaves
                    THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + "|" + loc_cCidChaves
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
                    THIS.grd_4c_SubN.Refresh()
                    THIS.grd_4c_SubN.SetFocus()
                    THIS.grd_4c_SubN.ActiveColumn = 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - cmd_4c_Excluir.Click (so visivel em modo direto).
    * Transcrito do legado:
    *     Select crSigOpCsn
    *     If Not Eof() And (crSigOpCsn.cDopes = crSigCdOpe.Dopes)
    *         Thisform.lHouveExcl = .T.
    *         Delete
    *         Skip
    *         Skip - 1
    *     Endif
    *     Thisform.GradeSubN.Refresh
    *
    * So marca a linha corrente como excluida no cursor LOCAL (SET DELETED
    * ON, fixado pelo FormBase para DataSession=2, esconde a linha da grade
    * de imediato) - o DELETE efetivo no SQL Server so acontece no Encerrar
    * (PersistirSubNiveis), e so quando a linha ja existia no banco (linha
    * nova excluida antes de salvar so some, sem SQL nenhum).
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_SubNiveis")
                SELECT cursor_4c_SubNiveis
                IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
                    THIS.this_lHouveExcl = .T.
                    DELETE
                    SKIP
                    SKIP -1
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
                THIS.grd_4c_SubN.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSairClick - cmd_4c_Sair.Click (Cancel = .T. - tambem dispara no ESC).
    * Transcrito do legado:
    *     If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
    *         If (Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt)
    *             Select CrSigOpOss / Set Order To / Delete For DopeSS = ' '
    *             ... TableUpdate('crSigOpCsn') + TableUpdate('crSigOpOss') +
    *                 Commit, com RollBack e MessageBox se qualquer etapa falhar
    *         Endif
    *     ENDIF
    *     Thisform.ParentForm.Enabled = .T.
    *     Thisform.mCtrlBotoes(.T.)
    *     ThisForm.Release
    *
    * "Thisform.ParentForm.Enabled = .T." e o reabilitar do pai ja sao feitos
    * no Destroy() deste form (chamado por Release()); "mCtrlBotoes(.T.)" do
    * legado reabilita BOTOES especificos do pai porque la o pai so ficava
    * com os controles desabilitados individualmente - aqui o Init ja
    * desabilita o FORM PAI INTEIRO (This.this_oParentForm.Enabled = .F.),
    * entao reabilitar o form basta, sem metodo equivalente a chamar.
    *
    * Modo VISUALIZAR/inverso (Inserir e Excluir ambos invisiveis): o legado
    * NAO persiste nada, so fecha - mesmo que o usuario tenha mexido nos
    * CheckBox (this_lHouveAlt), que alternam independente do modo.
    *==========================================================================
    PROCEDURE CmdSairClick()
        LOCAL loc_lPrecisaPersistir, loc_lSucesso, loc_cAliasAnterior, loc_oErro

        loc_lSucesso = .T.

        TRY
            IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
                loc_lPrecisaPersistir = THIS.this_lHouveExcl OR THIS.this_lHouveIns OR THIS.this_lHouveAlt

                IF loc_lPrecisaPersistir
                    *-- Legado: Select CrSigOpOss / Set Order To / Delete For
                    *-- DopeSS = ' ' - descarta sub-sub-niveis cujo codigo
                    *-- nunca foi preenchido (novos abandonados ou existentes
                    *-- que o usuario apagou), ANTES de persistir
                    IF USED("cursor_4c_SubSubNiveis")
                        loc_cAliasAnterior = ALIAS()
                        SELECT cursor_4c_SubSubNiveis
                        SET ORDER TO
                        DELETE FOR EMPTY(ALLTRIM(NVL(dopess, "")))
                        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                            SELECT (loc_cAliasAnterior)
                        ENDIF
                    ENDIF

                    loc_lSucesso = THIS.PersistirSubNiveis() AND THIS.PersistirSubSubNiveis()

                    IF !loc_lSucesso
                        MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados do Cadastro de " + ;
                            "Opera" + CHR(231) + CHR(245) + "es.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdSairClick")
        ENDTRY

        *-- So fecha se a gravacao deu certo (ou nao havia nada a gravar) -
        *-- em erro, o usuario pode corrigir o dado e tentar de novo
        IF loc_lSucesso
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * PersistirSubNiveis - grava no SQL Server as linhas de cursor_4c_
    * SubNiveis (SigOpCsn) alteradas nesta sessao - exclusoes primeiro,
    * depois inclusoes/atualizacoes. Chamado so por CmdSairClick.
    *
    * Sem buffer de VFP (sem TableUpdate), a persistencia eh linha-a-linha
    * via SQLEXEC (this_oBusinessObject.Salvar/Excluir) em vez de duas
    * chamadas em bloco - o resultado final (tudo gravado, ou erro reportado
    * e NADA de novo persistido a partir do ponto de falha) eh equivalente.
    *
    * Transcricao fiel ao legado (regra #17): o Encerrar legado NAO filtra
    * linhas de SigOpCsn com cnivels em branco antes de gravar - so filtra
    * SigOpOss (feito em CmdSairClick, antes de chamar este metodo).
    *==========================================================================
    PROTECTED PROCEDURE PersistirSubNiveis()
        LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_lNovo, loc_cDeletedStatus

        loc_lSucesso = .T.

        IF !USED("cursor_4c_SubNiveis")
            RETURN .T.
        ENDIF

        loc_cAliasAnterior = ALIAS()
        SELECT cursor_4c_SubNiveis

        *-- Exclusoes - so chama Excluir() no banco quando a linha ja
        *-- existia antes desta sessao (linha nova excluida sem nunca ter
        *-- sido gravada so some do cursor local, sem SQL). Com SET DELETED
        *-- ON (InicializarForm), SCAN pula as linhas marcadas ANTES mesmo de
        *-- avaliar o FOR - abrir mao disso temporariamente para alcancar as
        *-- linhas excluidas (mesmo padrao de PersistirSubSubNiveis).
        loc_cDeletedStatus = SET("DELETED")
        SET DELETED OFF
        SCAN FOR DELETED()
            loc_cCidChaves = ALLTRIM(cidchaves)
            IF !EMPTY(loc_cCidChaves) AND ;
               !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
                THIS.this_oBusinessObject.this_cCidChaves = loc_cCidChaves
                IF !THIS.this_oBusinessObject.Excluir()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        ENDSCAN
        SET DELETED &loc_cDeletedStatus

        *-- Inclusoes/atualizacoes das linhas vivas
        SCAN FOR !DELETED()
            loc_cCidChaves = ALLTRIM(cidchaves)
            loc_lNovo      = ("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))

            WITH THIS.this_oBusinessObject
                .this_cCidChaves  = loc_cCidChaves
                .this_cCDopes     = ALLTRIM(cursor_4c_SubNiveis.cdopes)
                .this_cCNivels    = ALLTRIM(cursor_4c_SubNiveis.cnivels)
                .this_nObrigs     = NVL(cursor_4c_SubNiveis.obrigs, 0)
                .this_nPgSubNNs   = NVL(cursor_4c_SubNiveis.pgsubnns, 0)
                .this_nCBxPagos   = NVL(cursor_4c_SubNiveis.cbxpagos, 0)
                .this_nTStatus    = NVL(cursor_4c_SubNiveis.tstatus, 0)
                .this_nCkAtCta    = NVL(cursor_4c_SubNiveis.ckatcta, 0)
                .this_nTrfCtaDSor = NVL(cursor_4c_SubNiveis.trfctadsor, 0)
                .this_nCodObs     = NVL(cursor_4c_SubNiveis.codobs, 0)
                .this_cTpFats     = ALLTRIM(NVL(cursor_4c_SubNiveis.tpfats, ""))
            ENDWITH

            IF loc_lNovo
                THIS.this_oBusinessObject.NovoRegistro()
            ELSE
                THIS.this_oBusinessObject.EditarRegistro()
            ENDIF

            IF !THIS.this_oBusinessObject.Salvar()
                loc_lSucesso = .F.
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PersistirSubSubNiveis - grava no SQL Server as linhas de cursor_4c_
    * SubSubNiveis (SigOpOss) alteradas nesta sessao. Chamado so por
    * CmdSairClick, DEPOIS do "Delete For Empty(dopess)" que descarta as
    * linhas em branco (feito em CmdSairClick).
    *
    * Nao ha botao de exclusao individual para grd_4c_SubS no legado - a
    * UNICA forma de remover um sub-sub-nivel eh apagar o codigo digitado
    * (fica com dopess em branco), por isso a exclusao aqui so trata linhas
    * que o "Delete For Empty(dopess)" marcou E que ja existiam no banco
    * (this_cCidChavesOssOriginais); linha nova descartada em branco nunca
    * chega a existir no SQL Server.
    *==========================================================================
    PROTECTED PROCEDURE PersistirSubSubNiveis()
        LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_cDeletedStatus

        loc_lSucesso = .T.

        IF !USED("cursor_4c_SubSubNiveis")
            RETURN .T.
        ENDIF

        loc_cAliasAnterior = ALIAS()
        SELECT cursor_4c_SubSubNiveis

        *-- Exclusoes - as linhas marcadas Delete (dopess em branco) ficam
        *-- escondidas do SCAN normal por SET DELETED ON; abrir mao disso
        *-- temporariamente so para varrer as marcadas
        loc_cDeletedStatus = SET("DELETED")
        SET DELETED OFF
        SCAN FOR DELETED()
            loc_cCidChaves = ALLTRIM(cidchaves)
            IF !EMPTY(loc_cCidChaves) AND ;
               ("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesOssOriginais + "|")) AND ;
               !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesOssNovas + "|"))
                THIS.this_oBusinessObject.this_cCidChavesOss = loc_cCidChaves
                IF !THIS.this_oBusinessObject.ExcluirSubSubNivel()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        ENDSCAN
        SET DELETED &loc_cDeletedStatus

        *-- Inclusoes/atualizacoes das linhas vivas (dopess preenchido)
        SCAN FOR !DELETED()
            loc_cCidChaves = ALLTRIM(cidchaves)

            WITH THIS.this_oBusinessObject
                .this_cCidChavesOss = loc_cCidChaves
                .this_cCDopesOss    = ALLTRIM(cursor_4c_SubSubNiveis.cdopes)
                .this_cCNivelsOss   = ALLTRIM(cursor_4c_SubSubNiveis.cnivels)
                .this_cDopess       = ALLTRIM(cursor_4c_SubSubNiveis.dopess)
            ENDWITH

            IF "|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesOssNovas + "|")
                IF !THIS.this_oBusinessObject.InserirSubSubNivel()
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                IF !THIS.this_oBusinessObject.AtualizarSubSubNivel()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Este form nao possui containers flutuantes (sem filtro de excecao)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita o form pai ao fechar este popup
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
            THIS.this_oParentForm         = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSnoBO.prg):
*==============================================================================
* SigOpSnoBO.prg - Business Object para Sub-Niveis da Operacao
* Tabela principal: SigOpCsn | PK: cidchaves
* Tabela secundaria: SigOpOss (Sub-Sub-Nivel por Sub-Nivel) | PK: cidchaves
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpSnoBO AS BusinessBase

    *-- Propriedades da entidade principal (mapeamento para tabela SigOpCsn)
    *-- PK
    this_cCidChaves     = ""    && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Chaves de relacionamento
    this_cCDopes        = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai)
    this_cCNivels       = ""    && cnivels char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada como sub-nivel)

    *-- Flags / controles (numeric(1,0)) - ver CheckBox das colunas O/P/C/S/T da grade
    this_nObrigs        = 0     && obrigs numeric(1,0) NOT NULL - "O" = Obrigatorio
    this_nPgSubNNs      = 0     && pgsubnns numeric(1,0) NOT NULL - "P" = Bx SubNivel do SubNivel c/Pago
    this_nCBxPagos      = 0     && cbxpagos numeric(1,0) NOT NULL - "C" = Cancela Bx SubNivel do SubNivel c/Pago
    this_nTStatus       = 0     && tstatus numeric(1,0) NOT NULL - "S" = Controle de Status (Aprovado/Reprovado)
    this_nCkAtCta       = 0     && ckatcta numeric(1,0) NOT NULL - "T" = Atualiza o Grupo e Conta de Origem conforme o SubNivel
    this_nTrfCtaDSor    = 0     && trfctadsor numeric(1,0) NOT NULL - sem controle na tela (grava 0 - regra de INSERT NOT NULL)

    *-- Lookups
    this_nCodObs        = 0     && codobs numeric(3,0) NOT NULL - FK SigCdObs.Codigos (Observacao)
    this_cTpFats        = ""    && tpfats char(3) NOT NULL - FK SigCdTif.Codigos (Tipo de Faturamento)

    *-- Campo de exibicao (JOIN com SigCdOpe, somente leitura, nao persiste em SigOpCsn)
    this_nNDopes        = 0     && SigCdOpe.ndopes - numero sequencial da operacao (exibido no modo inverso)

    *-- Propriedades da entidade secundaria (tabela SigOpOss - sub-sub-nivel por sub-nivel)
    this_cCidChavesOss  = ""    && cidchaves char(20) NOT NULL - PK de SigOpOss (gerada com fUniqueIds())
    this_cCDopesOss     = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai, copiado de this_cCDopes)
    this_cCNivelsOss    = ""    && cnivels char(20) NOT NULL - FK copiado de this_cCNivels (sub-nivel ao qual pertence)
    this_cDopess        = ""    && dopess char(20) NOT NULL - FK SigCdOpe.dopes (sub-sub-nivel)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpCsn"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do sub-nivel a partir de um
    * cursor posicionado em uma linha de SigOpCsn (ou de um SELECT que inclua
    * as mesmas colunas + o campo de exibicao opcional "ndopes", vindo do
    * JOIN com SigCdOpe)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCDopes     = TratarNulo(cdopes,     "C")
                THIS.this_cCNivels    = TratarNulo(cnivels,    "C")
                THIS.this_nObrigs     = TratarNulo(obrigs,     "N")
                THIS.this_nPgSubNNs   = TratarNulo(pgsubnns,   "N")
                THIS.this_nCBxPagos   = TratarNulo(cbxpagos,   "N")
                THIS.this_nTStatus    = TratarNulo(tstatus,    "N")
                THIS.this_nCkAtCta    = TratarNulo(ckatcta,    "N")
                THIS.this_nTrfCtaDSor = TratarNulo(trfctadsor, "N")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cTpFats     = TratarNulo(tpfats,     "C")

                *-- Campo de exibicao vindo do JOIN com SigCdOpe (presente so
                *-- quando o SELECT que populou o cursor o incluiu)
                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNDopes = TratarNulo(ndopes, "N")
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui um novo sub-nivel (linha de SigOpCsn) no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o 2o registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpCsn" + ;
                       " (cdopes, cnivels, cidchaves, obrigs, cbxpagos, codobs," + ;
                       "  pgsubnns, tstatus, tpfats, ckatcta, trfctadsor)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTStatus, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTpFats) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSno")
                USE IN cursor_4c_InsSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um sub-nivel (linha de SigOpCsn) existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpCsn SET" + ;
                       " cdopes     = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels    = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " obrigs     = " + FormatarNumeroSQL(THIS.this_nObrigs, 0) + "," + ;
                       " cbxpagos   = " + FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + "," + ;
                       " codobs     = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + "," + ;
                       " pgsubnns   = " + FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + "," + ;
                       " tstatus    = " + FormatarNumeroSQL(THIS.this_nTStatus, 0) + "," + ;
                       " tpfats     = " + EscaparSQL(THIS.this_cTpFats) + "," + ;
                       " ckatcta    = " + FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + "," + ;
                       " trfctadsor = " + FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSno")
                USE IN cursor_4c_UpdSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove um sub-nivel (linha de SigOpCsn) do banco.
    * Remove TAMBEM os sub-sub-niveis (SigOpOss) que dependem dele, pois o
    * legado permite excluir o sub-nivel so quando ele ainda eh o corrente na
    * grade (cmdExcluir.Click do SCX) e nao deixa registros orfaos em SigOpOss.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves IN (" + ;
                       " SELECT cidchaves FROM SigOpCsn WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOssDep")
            IF USED("cursor_4c_DelOssDep")
                USE IN cursor_4c_DelOssDep
            ENDIF

            loc_cSQL = "DELETE FROM SigOpCsn" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSno")
                USE IN cursor_4c_DelSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSubNiveis - Popula cursor_4c_SubNiveis com os sub-niveis da
    * operacao (modo direto, equivalente ao legado "ReQuery('crSigOpCsn')"
    * filtrado por cdopes) ou com as operacoes que usam a operacao como
    * sub-nivel (modo inverso, equivalente ao "lcSql = Select a.*,b.nDopes
    * From SigOpCsn a Inner Join SigCdOpe b ... Where a.cNivels = ...").
    *
    * O JOIN com SigCdOpe traz ndopes (Column2 "#" da grade) da OPERACAO QUE
    * VARIA linha a linha - cnivels no modo direto (a coluna que o usuario
    * escolhe via lookup em cada sub-nivel), cdopes no modo inverso -, NUNCA
    * da coluna fixa pelo filtro WHERE. Juntar sempre por a.cdopes faria toda
    * linha, em modo direto, mostrar o ndopes da OPERACAO PAI repetido (pai
    * eh fixo pelo WHERE), em vez do ndopes de cada sub-nivel escolhido.
    * LEFT JOIN (nao INNER): linha com a coluna variavel ainda vazia (recem
    * inserida, antes do lookup) nao pode desaparecer do cursor.
    * Cursor READWRITE (regra sobre Grid com coluna editavel): as colunas O/
    * P/C/S/T sao CheckBox de grade e o codigo/observacao/tipo de fat. sao
    * TextBox editaveis na grade.
    *--------------------------------------------------------------------------
    FUNCTION ListarSubNiveis(par_cOperacaoPai, par_lModoInverso)
        LOCAL loc_cOperacaoPai, loc_lInverso, loc_cCampoFiltro, loc_cCampoJoin, ;
              loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
        loc_lInverso     = IIF(VARTYPE(par_lModoInverso) = "L", par_lModoInverso, .F.)
        loc_cCampoFiltro = IIF(loc_lInverso, "a.cnivels", "a.cdopes")
        loc_cCampoJoin   = IIF(loc_lInverso, "a.cdopes", "a.cnivels")

        TRY
            loc_cSQL = "SELECT a.*, b.ndopes AS ndopes" + ;
                       " FROM SigOpCsn a LEFT JOIN SigCdOpe b ON " + loc_cCampoJoin + " = b.dopes" + ;
                       " WHERE " + loc_cCampoFiltro + " = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cnivels"

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubNiveis")
                    USE IN cursor_4c_SubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubNivTmp INTO CURSOR cursor_4c_SubNiveis READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarSubSubNiveis - Popula cursor_4c_SubSubNiveis com os sub-sub-niveis
    * (SigOpOss) da operacao, equivalente ao legado "lcSql = Select * From
    * SigOpOss Where cDopes = ...", igual nos dois modos (direto/inverso).
    * Cursor READWRITE: a grade de sub-sub-niveis recebe linhas novas via
    * Append Blank no AfterRowColChange da grade de sub-niveis (Fase 8).
    *--------------------------------------------------------------------------
    FUNCTION ListarSubSubNiveis(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        TRY
            loc_cSQL = "SELECT * FROM SigOpOss" + ;
                       " WHERE cdopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubSubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubSubNiveis")
                    USE IN cursor_4c_SubSubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubSubNivTmp INTO CURSOR cursor_4c_SubSubNiveis READWRITE
                INDEX ON cnivels TAG cnivels
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSubSubNivelDoCursor - Carrega as propriedades do sub-sub-nivel
    * (SigOpOss) a partir de um cursor posicionado numa linha dessa tabela.
    * PUBLIC: chamado diretamente pelo Form (padrao operacional, regra do
    * cabecalho de BusinessBase sobre Inserir/Atualizar/Oss serem chamados
    * de fora em telas que nao seguem o fluxo unico de FormParaBO/BOParaForm).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubSubNivelDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChavesOss = TratarNulo(cidchaves, "C")
                THIS.this_cCDopesOss    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivelsOss   = TratarNulo(cnivels,   "C")
                THIS.this_cDopess       = TratarNulo(dopess,    "C")
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirSubSubNivel - Inclui um novo sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE InserirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChavesOss)
                THIS.this_cCidChavesOss = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpOss (cdopes, cidchaves, cnivels, dopess)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCidChavesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCNivelsOss) + ", " + ;
                       EscaparSQL(THIS.this_cDopess) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsOss")
                USE IN cursor_4c_InsOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.InserirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSubSubNivel - Atualiza o sub-sub-nivel (dopess) de uma linha
    * de SigOpOss ja existente. O legado (view remota com buffer) nao
    * precisa disso - o TableUpdate final grava o valor corrente da linha,
    * nova ou editada, da mesma forma. Sem view buferizada, a linha editada
    * (cidchaves ja gravado antes) exige UPDATE explicito - so INSERT
    * duplicaria a linha com o mesmo cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOss SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopesOss) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivelsOss) + "," + ;
                       " dopess  = " + EscaparSQL(THIS.this_cDopess) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdOss")
                USE IN cursor_4c_UpdOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.AtualizarSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirSubSubNivel - Remove um sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelOss")
                USE IN cursor_4c_DelOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExcluirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

