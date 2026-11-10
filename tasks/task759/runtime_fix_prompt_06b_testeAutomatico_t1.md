# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-08 10:57:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-08 10:57:04] [INFO] Config FPW: (nao fornecido)
[2026-11-08 10:57:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 10:57:05] [INFO] Timeout: 300 segundos
[2026-11-08 10:57:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ri44auy1.prg
[2026-11-08 10:57:05] [INFO] Conteudo do wrapper:
[2026-11-08 10:57:06] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpLhi', 'C:\4c\tasks\task759', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLhi', 'C:\4c\tasks\task759', 'OPERACIONAL'
QUIT

[2026-11-08 10:57:06] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ri44auy1.prg
[2026-11-08 10:57:06] [INFO] VFP output esperado em: C:\4c\tasks\task759\vfp_output.txt
[2026-11-08 10:57:06] [INFO] Executando Visual FoxPro 9...
[2026-11-08 10:57:07] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ri44auy1.prg
[2026-11-08 10:57:07] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ri44auy1.prg
[2026-11-08 10:57:07] [INFO] Timeout configurado: 300 segundos
[2026-11-08 10:57:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-08 10:57:08] [INFO] VFP9 finalizado em 1.9238717 segundos
[2026-11-08 10:57:09] [INFO] Exit Code: 
[2026-11-08 10:57:09] [INFO] 
[2026-11-08 10:57:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-08 10:57:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ri44auy1.prg
[2026-11-08 10:57:10] [INFO] 
[2026-11-08 10:57:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-08 10:57:11] [INFO] * Auto-generated wrapper for parameters
[2026-11-08 10:57:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-08 10:57:11] [INFO] * Parameters: 'FormSigOpLhi', 'C:\4c\tasks\task759', 'OPERACIONAL'
[2026-11-08 10:57:12] [INFO] 
[2026-11-08 10:57:12] [INFO] * Anti-dialog protections for unattended execution
[2026-11-08 10:57:12] [INFO] SET SAFETY OFF
[2026-11-08 10:57:12] [INFO] SET RESOURCE OFF
[2026-11-08 10:57:13] [INFO] SET TALK OFF
[2026-11-08 10:57:13] [INFO] SET NOTIFY OFF
[2026-11-08 10:57:13] [INFO] SYS(2335, 0)
[2026-11-08 10:57:13] [INFO] 
[2026-11-08 10:57:14] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpLhi', 'C:\4c\tasks\task759', 'OPERACIONAL'
[2026-11-08 10:57:14] [INFO] QUIT
[2026-11-08 10:57:14] [INFO] 
[2026-11-08 10:57:15] [INFO] === Fim do Wrapper.prg ===
[2026-11-08 10:57:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpLhi",
  "timestamp": "20261108105708",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLhi.prg):
*==============================================================================
* FORMSIGOPLHI.PRG
* Dialogo modal de conferencia/edicao de Lancamentos em Conta Corrente
* Migrado de: SIGOPLHI.SCX (dialogo filho, aberto pelo Formpgr/PGRBO via
*             "Do Form SigOpLhi With ThisForm" - nao acessivel pelo menu)
*
* NATUREZA (ver cabecalho de SigOpLhiBO.prg):
*   O form PAI monta em memoria o cursor de lancamentos (TmpLanca no legado,
*   cursor_4c_Lancamentos aqui) e so entao abre este dialogo. O usuario
*   confere a lista e pode editar a coluna Historico; ao sair:
*     Confirma ("Ok")       -> ThisForm.Release (pai segue normalmente)
*     Cancela ("Encerrar")  -> this_oFormPai.CanceladoExterno = .T. + Release
*                              (pai aborta a baixa)
*
* ESTRUTURA: Form FLAT sem PageFrame e sem barra CRUD - o legado SIGOPLHI eh
* um dialogo modal de conferencia, nao um cadastro (ver NATUREZA acima). As
* fases anteriores entregaram a estrutura base (DEFINE CLASS, Init,
* InicializarForm, cabecalho), o grid de lancamentos (grd_4c_Dados, ligado a
* cursor_4c_Lancamentos), o label de aviso (lbl_4c_Label1) e os dois botoes do
* legado (cmd_4c_Confirma "Ok" / cmd_4c_Cancela "Encerrar").
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: o legado tem EXATAMENTE DOIS
* botoes (SIGOPLHI.Confirma e SIGOPLHI.Cancela, ambos BaseClass commandbutton
* soltos no form) e NENHUMA barra CRUD - o dump nao tem frmcadastro, nao tem
* Grupo_Op, nao tem pcEscolha e nao tem botao com verbo de registro. Os
* eventos portados nesta fase sao, portanto, os dois Click que o legado
* realmente tem, completados com o que falta para o contrato do dialogo
* fechar: a sincronia da linha corrente com o BO (para o Historico editado na
* Column3 chegar a this_cHists, que eh por onde o pai le o resultado) e a
* marcacao da flag de cancelamento no form PAI por QUALQUER um dos dois nomes
* possiveis - marcar so um faria o cancelamento ser perdido em silencio.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: fecham-se aqui os metodos de
* apoio que o contrato do dialogo pede, TODOS ancorados em superficie que o
* legado realmente tem:
*   CarregarLista()  - reproduz o fim do Init legado ("Select TmpLanca / Go
*                      Top / This.Refresh"). A grade do SIGOPLHI EH a lista do
*                      form (RecordSource = "TmpLanca"); PUBLIC porque o
*                      harness de teste a chama de fora (regra #3).
*   FormParaBO()     - leva a linha CORRENTE do cursor (inclusive o Historico
*                      que o usuario acabou de editar na Column3, a unica
*                      coluna sem ReadOnly no SCX) para as propriedades do BO.
*                      Eh por elas que o pai le o resultado do dialogo.
*   BOParaForm()     - leva o titulo montado pelo BO para o Caption e para os
*                      DOIS labels do cabecalho, exatamente como o Init legado
*                      ("cntSombra.lblSombra.Caption = ThisForm.Caption" e
*                      idem lblTitulo), e repinta a grade.
*   RepintarGrade()  - funil unico de repintura (regra #21a: popular/navegar
*                      cursor NAO repinta a grade sozinho).
*   BtnOkClick()     - Confirma.Click do legado (Caption "\<Ok").
*   BtnCancelarClick() - Cancela.Click do legado (Caption "Encerrar",
*                      Cancel = .T.), que aborta a baixa no form PAI. Os dois
*                      handlers sao nomeados pela ACAO/Caption, nao pelo Name
*                      do objeto legado.
*
* NOMES CANONICOS DE CADASTRO QUE NAO TEM ORIGEM NESTE LEGADO: BtnBuscarClick,
* BtnSalvarClick, HabilitarCampos, LimparCampos e AjustarBotoesPorModo. O dump
* de SIGOPLHI nao tem botao de busca, nao tem botao de gravar, nao tem
* pcEscolha/modo de edicao e nao tem Page1/Page2 - os UNICOS dois botoes do
* SCX sao Confirma e Cancela, ja portados. Criar esses cinco metodos exigiria
* INVENTAR superficie que o usuario do sistema legado nunca viu (viola o
* PILAR 1), por isso o que se entrega eh a superficie que o legado de fato
* tem. Pelo mesmo motivo nao se inventa Valid/validacao na Column3: no SCX a
* edicao do Historico eh ligacao DIRETA por ControlSource, sem validacao
* alguma (regra #46 - celula se valida no Valid do TextBox da Column, e aqui
* nao existe nenhum a portar).
*==============================================================================

DEFINE CLASS FormSigOpLhi AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity, transcritas de SIGOPLHI.SCX)
    Height       = 400
    Width        = 800
    Caption      = " "
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.

    *-- Business object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do form pai (legado: LParameters _Form)
    this_oFormPai          = .NULL. && referencia ao Formpgr que abriu este dialogo
    this_cAliasContexto    = ""     && alias do cursor de contexto (crSigCdPgr no legado)
    this_cAliasLancamentos = "cursor_4c_Lancamentos" && alias do cursor de lancamentos (TmpLanca no legado)
    this_lCursorPlaceholder = .F.    && .T. so quando ESTE form criou o cursor
                                     && de lancamentos (instanciacao isolada -
                                     && ver GarantirCursorLancamentos). Em uso
                                     && real o cursor pertence ao form PAI e
                                     && NUNCA deve ser fechado por aqui.

    *--------------------------------------------------------------------------
    * Init - Captura parametros do form pai e delega para FormBase.Init()
    * par_oFormPai          : referencia ao Formpgr (usado para CanceladoExterno)
    * par_cAliasContexto    : alias do cursor de contexto (SigCdPgr), ja aberto
    *                         pelo pai - usado so para montar o titulo do dialogo
    * par_cAliasLancamentos : alias do cursor de lancamentos a exibir/editar;
    *                         se omitido, usa o default this_cAliasLancamentos
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cAliasContexto, par_cAliasLancamentos)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_cAliasContexto) = "C" AND !EMPTY(par_cAliasContexto)
            THIS.this_cAliasContexto = par_cAliasContexto
        ENDIF

        IF VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos)
            THIS.this_cAliasLancamentos = par_cAliasLancamentos
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, monta o titulo do dialogo
    * (a partir do cursor de contexto, quando disponivel) e constroi a
    * estrutura visual basica (cabecalho + container dos botoes).
    * Chamado automaticamente por FormBase.Init().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLhiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigOpLhiBO", "FormSigOpLhi.InicializarForm")
            ELSE
                IF !EMPTY(THIS.this_cAliasContexto) AND USED(THIS.this_cAliasContexto)
                    THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_cAliasContexto)
                ENDIF

                IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
                    THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
                ELSE
                    THIS.Caption = "Lan" + CHR(231) + "amentos em Conta Corrente"
                ENDIF

                THIS.GarantirCursorLancamentos()

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarLabelInfo()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.CarregarLista()
                THIS.BOParaForm()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpLhi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado), com os
    * dois labels de titulo (sombra preta + titulo branco). Replica o titulo
    * montado pelo BO (SigOpLhiBO.MontarTitulo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top = 0
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize = .F.
            .WordWrap = .T.
            .Left = 10
            .Top = 18
            .Width = THIS.Width - 31
            .Height = 40
            .ForeColor = RGB(0, 0, 0)
            .Caption = THIS.Caption
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize = .F.
            .WordWrap = .T.
            .Left = 10
            .Top = 17
            .Width = THIS.Width - 31
            .Height = 46
            .ForeColor = RGB(255, 255, 255)
            .Caption = THIS.Caption
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Container com os dois botoes do legado: Confirma
    * ("\<Ok", Left=650) e Cancela ("Encerrar", Left=725). Geometria calculada
    * a partir do dump de SIGOPLHI.SCX, que posiciona os dois botoes direto no
    * form, lado direito, Top=3. Width/Height=75 (canonico dos botoes com
    * icone do framework) cabem dentro da faixa do cabecalho (Height=80),
    * por isso este container e criado DEPOIS de ConfigurarCabecalho - para
    * desenhar por cima da faixa (regra #11 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top = 3
            .Left = 645
            .Width = 150
            .Height = 75
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Confirma
            .Top = 0
            .Left = 5
            .Width = 75
            .Height = 75
            .Caption = "\<Ok"
            .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Cancel = .F.
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Cancela
            .Top = 0
            .Left = 80
            .Width = 75
            .Height = 75
            .Caption = "Encerrar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Cancel = .T.
            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirma, "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelInfo - Label1 do legado: aviso fixo acima do grid,
    * "Lancamentos que serao efetuados em Conta Corrente". Classe say
    * (AutoSize=.T. no SCX) - regra #23 do CLAUDE.md: AutoSize eh no-op em
    * Label criado por AddObject, entao transcrevemos Width/Height do dump
    * (263x15) com AutoSize=.F. explicito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelInfo()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .AutoSize = .F.
            .Alignment = 0
            .Left = 117
            .Top = 133
            .Width = 263
            .Height = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Lan" + CHR(231) + "amentos que ser" + CHR(227) + "o efetuados em Conta Corrente"
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grade do legado (SIGOPLHI.Grade), ligada ao cursor de
    * lancamentos (TmpLanca no legado, this_cAliasLancamentos aqui - default
    * "cursor_4c_Lancamentos"). 5 colunas, todas ReadOnly exceto Hists
    * (Column3, a unica coluna editavel no SCX - o usuario pode corrigir o
    * historico antes de confirmar). Geometria/larguras/captions EXATOS do
    * dump (Column1=Grupo/65, Column2=Conta/65, Column3=Historico/290,
    * Column4=Valor/83, Column5=Moe/25).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cAliasLancamentos

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top = 152
            .Left = 114
            .Width = 571
            .Height = 158
            .FontName = "Tahoma"
            .FontSize = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .DeleteMark = .F.
            .RecordMark = .F.
            .ScrollBars = 2
            .RowHeight = 17
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount = 5
            .RecordSource = loc_cAlias
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .ControlSource = loc_cAlias + ".Grupos"
            .Width = 65
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Grupo"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .ControlSource = loc_cAlias + ".Contas"
            .Width = 65
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Conta"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .ControlSource = loc_cAlias + ".Hists"
            .Width = 290
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Hist" + CHR(243) + "rico"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .ControlSource = loc_cAlias + ".Valor"
            .Width = 83
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Valor"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5
            .ControlSource = loc_cAlias + ".Moeda"
            .Width = 25
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Moe"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.grd_4c_Dados.Visible = .T.

        *-- Sincronia da linha corrente com o BO. O evento passa o indice da
        *-- coluna de DESTINO e o handler NAO filtra coluna: este eh o uso
        *-- correto de AfterRowColChange (carregar o detalhe da linha
        *-- corrente). Validacao de celula NAO vai aqui (CLAUDE.md regra #46)
        *-- e o legado nao tem nenhuma na Grade.Column3.
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorLancamentos - O cursor de lancamentos (TmpLanca no
    * legado) eh criado e populado pelo form PAI ANTES de abrir este dialogo
    * (ver cabecalho do arquivo). Este metodo so cria um placeholder com a
    * MESMA estrutura de colunas documentada em SigOpLhiBO.prg (cabecalho da
    * classe) quando o cursor ainda nao existe - instanciacao isolada
    * (gb_4c_ValidandoUI / teste automatico). Chamado ANTES de ConfigurarGrid:
    * ligar Column.ControlSource/Grid.RecordSource a um alias inexistente
    * derruba o Init com "Alias ... is not found" (regra #41 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCursorLancamentos()
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cAliasLancamentos

        IF !USED(loc_cAlias)
            CREATE CURSOR (loc_cAlias) ;
                (Grupos C(10), Contas C(10), Moeda C(3), Cotacaos N(14,4), ;
                 GrupoC C(10), ContaC C(10), MoedaC C(3), CotacaoC N(14,4), ;
                 Hists C(40), Valor N(12,2), ValPag N(12,2), Tipos C(1), ;
                 ValorC N(12,2), ValPagC N(12,2), Hist2s C(40))

            THIS.this_lCursorPlaceholder = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Reproduz o final do Init legado ("Select TmpLanca / Go
    * Top / This.Refresh"). A grade do SIGOPLHI (RecordSource = "TmpLanca") EH
    * a lista deste form - nao existe Page1/Page2 nem grade de detalhe para
    * confundir com ela.
    *
    * Eh o FUNIL de carga: todo caminho que (re)posiciona o cursor passa por
    * aqui e termina em RepintarGrade(), porque popular ou navegar o cursor NAO
    * repinta a grade sozinho (CLAUDE.md regra #21a) - a grade ficaria
    * visivelmente vazia com o cursor cheio, e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para o lado errado.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS devolve .T.
    * mesmo para metodo PROTECTED - a chamada entraria no branch e falharia em
    * runtime com "Property CARREGARLISTA is not found" (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cAlias, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasLancamentos

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.ContarLancamentos(loc_cAlias)
                ENDIF

                THIS.RepintarGrade()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor de lan" + CHR(231) + "amentos [" + loc_cAlias + ;
                    "] n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                    "FormSigOpLhi.CarregarLista")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGrade - Funil unico de repintura da grade (CLAUDE.md regra #21a).
    * NAO move o ponteiro do cursor: quem posiciona eh CarregarLista; este
    * metodo so manda a grade redesenhar o que o cursor ja tem. Guardado por
    * PEMSTATUS porque roda tambem a partir de BOParaForm, que o InicializarForm
    * pode alcancar antes de a grade existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RepintarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED(THIS.this_cAliasLancamentos)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transferencia FORM -> BO. Copia a linha CORRENTE do cursor
    * de lancamentos para as propriedades this_* do BO (SigOpLhiBO.
    * CarregarLinhaAtual), inclusive o Hists que o usuario acabou de editar na
    * Column3 do grid - unica coluna sem ReadOnly = .T. no SCX.
    *
    * Eh por essas propriedades que o resultado do dialogo fica disponivel ao
    * form PAI: no legado o pai le de volta "ThisForm.HistoricoCliente =
    * TmpLanca.Hists" depois do Release (ver cabecalho de SigOpLhiBO.prg).
    *
    * A leitura eh do CURSOR, nao do controle da Column: no SCX a Column3 esta
    * ligada ao cursor por ControlSource, e ao clicar num botao o foco sai da
    * celula e o valor digitado eh gravado no cursor pelo proprio VFP. Ler
    * Column3.Text1.Value em vez do cursor arriscaria pegar o valor de OUTRA
    * linha (o controle da coluna eh um so, compartilhado) e sobrescrever o
    * Historico certo pelo errado, em silencio.
    *
    * PROTECTED: eh hook declarado PROTECTED na FormBase, e em VFP9 o
    * PROTECTED da classe base PREVALECE (CLAUDE.md regra #51) - chamar de
    * fora estouraria "Property FORMPARABO is not found". Os chamadores sao
    * todos internos (GrdDadosAfterRowColChange e BtnOkClick).
    *
    * Preserva a area de trabalho corrente: o metodo roda durante a navegacao
    * do grid, e deixar outra area selecionada corromperia o que vem depois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cAlias, loc_cAliasAnterior, loc_lSucesso, loc_oErro
        loc_lSucesso       = .F.
        loc_cAlias         = THIS.this_cAliasLancamentos
        loc_cAliasAnterior = ALIAS()

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED(loc_cAlias)
                IF !EOF(loc_cAlias) AND !BOF(loc_cAlias)
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarLinhaAtual(loc_cAlias)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transferencia BO -> FORM. Leva o titulo montado pelo BO
    * (SigOpLhiBO.MontarTitulo, "Lancamentos para <Dopes> - <MascNum>") para o
    * Caption do form e para os DOIS labels do cabecalho, reproduzindo o Init
    * legado:
    *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    * e fecha repintando a grade pelo funil unico (regra #21a).
    *
    * Titulo vazio NAO sobrescreve o Caption ja montado pelo InicializarForm -
    * o dialogo pode ser aberto sem o cursor de contexto (instanciacao isolada),
    * e nesse caso o fallback generico deve permanecer.
    *
    * PROTECTED pelo mesmo motivo do FormParaBO (hook PROTECTED na FormBase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cTitulo, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
                    THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
                ENDIF
            ENDIF

            loc_cTitulo = THIS.Caption

            IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
            ENDIF

            THIS.RepintarGrade()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Mantem a linha corrente do BO em sincronia
    * com a linha corrente do grid. Este eh o uso CORRETO de
    * AfterRowColChange (carregar o detalhe da linha corrente); validacao de
    * CELULA nao entra aqui - a regra #46 do CLAUDE.md manda valida-la no
    * Valid do TextBox da Column, e o legado nao tem Valid algum na
    * Grade.Column3 (a edicao do Historico eh ligacao direta por
    * ControlSource, sem validacao), por isso nada de validacao eh inventado.
    *
    * Como o evento passa o indice da coluna de DESTINO, o parametro eh
    * declarado (CLAUDE.md regra #3: handler de BINDEVENT tem de declarar os
    * parametros do evento) - e NAO eh usado para filtrar coluna, justamente
    * porque a sincronia vale para qualquer celula para a qual o usuario va.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarCanceladoNoPai - Reproduz o "ThisForm.ParentForm.CanceladoExterno
    * = .T." do Cancela.Click legado.
    *
    * O nome da flag no pai pode ser o do legado (CanceladoExterno) ou o
    * migrado (this_lCanceladoExterno, prefixo this_ do PILAR 3), e marcar so
    * um dos dois faria o cancelamento ser PERDIDO EM SILENCIO quando o pai
    * usa o outro - com o pai seguindo a baixa que o usuario acabou de
    * cancelar. Por isso marca TODA flag que o pai expoe; nao expondo
    * nenhuma, cria a do legado com AddProperty, para a informacao nao se
    * perder. Falha de verdade (objeto sem AddProperty) eh reportada - CATCH
    * nunca silencioso (CLAUDE.md regra #9).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarCanceladoNoPai()
        LOCAL loc_lMarcou, loc_oErro
        loc_lMarcou = .F.

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "this_lCanceladoExterno", 5)
                    THIS.this_oFormPai.this_lCanceladoExterno = .T.
                    loc_lMarcou = .T.
                ENDIF

                IF PEMSTATUS(THIS.this_oFormPai, "CanceladoExterno", 5)
                    THIS.this_oFormPai.CanceladoExterno = .T.
                    loc_lMarcou = .T.
                ENDIF

                IF !loc_lMarcou
                    THIS.this_oFormPai.AddProperty("CanceladoExterno", .T.)
                    loc_lMarcou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em MarcarCanceladoNoPai")
        ENDTRY

        RETURN loc_lMarcou
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - Confirma.Click do legado ("ThisForm.Release"), botao de
    * Caption "\<Ok". Antes de liberar, o FormParaBO leva a linha corrente do
    * cursor para o BO - eh assim que o Historico editado na Column3 chega a
    * this_cHists, por onde o pai le o resultado - e o total de lancamentos eh
    * recontado. O cursor em si nao precisa de gravacao: o grid esta ligado
    * DIRETO a ele por ControlSource e o cursor pertence ao form PAI, que segue
    * o fluxo normal depois do Release (ver cabecalho deste arquivo).
    * A flag de cancelamento eh explicitamente desligada - sair pelo "Ok" eh
    * o oposto de sair pelo "Encerrar".
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        THIS.FormParaBO()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCanceladoExterno = .F.
            THIS.this_oBusinessObject.ContarLancamentos(THIS.this_cAliasLancamentos)
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela.Click do legado: marca a flag de cancelamento
    * no form PAI (para ele abortar a baixa) e libera o dialogo. O BO guarda o
    * espelho da flag (this_lCanceladoExterno), documentado no cabecalho de
    * SigOpLhiBO.prg. A linha corrente NAO eh sincronizada aqui: cancelar
    * descarta a edicao, nao a propaga.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.MarcarCanceladoNoPai()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCanceladoExterno = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Encerramento. Fecha o cursor de lancamentos SOMENTE quando foi
    * este form que o criou (GarantirCursorLancamentos, caminho de instanciacao
    * isolada): em uso real o cursor eh o TmpLanca do form PAI, que continua a
    * le-lo DEPOIS do Release para saber o Historico confirmado - fechar aqui
    * tiraria do pai o resultado do dialogo, em silencio.
    *
    * DODEFAULT() por ULTIMO: eh o FormBase.Destroy que reconstroi os popups do
    * menu principal depois de um form modal fechar; sem ele o menu encolhe.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF THIS.this_lCursorPlaceholder AND USED(THIS.this_cAliasLancamentos)
            USE IN (THIS.this_cAliasLancamentos)
        ENDIF

        THIS.this_lCursorPlaceholder = .F.
        THIS.this_oFormPai           = .NULL.
        THIS.this_oBusinessObject    = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLhiBO.prg):
*==============================================================================
* SIGOPLHIBO.PRG
* Business Object para o dialogo de Lancamentos em Conta Corrente
* (SIGOPLHI - dialogo filho MODAL aberto pelo form pai SIGCDPGR via
*  "Do Form SigOpLhi With ThisForm", NAO acessivel direto pelo menu)
*
* Tabela de contexto : SigCdPgr (programacao de pagamento/recebimento)
* Chave Real (PK)    : cidchaves  CHAR(20)
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGCDPGR linhas 13197-13460):
*   O form PAI monta em memoria o cursor local TmpLanca com os lancamentos
*   que serao efetuados em Conta Corrente:
*
*     Create Cursor TmpLanca ( Grupos c(10), Contas c(10), Moeda c(3),
*                              Cotacaos n(14,4), GrupoC c(10), ContaC c(10),
*                              MoedaC c(3), CotacaoC n(14,4), Hists c(40),
*                              Valor n(12,2), ValPag n(12,2), Tipos c(1),
*                              ValorC n(12,2), ValPagC n(12,2), Hist2s c(40))
*     Index on Grupos + Contas + Moeda + Tipos + GrupoC + ContaC + MoedaC
*              + Hists + Hist2s Tag GruConMoe
*
*   e so entao abre este dialogo (somente quando !Eof() e
*   PgRecParam.MudaHists = 1). O usuario CONFERE a lista e pode EDITAR a
*   coluna Historico (Hists) - e a unica Column do grid sem ReadOnly = .T.
*   no SCX. Ao sair:
*     Confirma ("Ok")      -> ThisForm.Release (o pai segue e, quando
*                             crSigCdPac.UniHists = 1, le de volta
*                             ThisForm.HistoricoCliente = TmpLanca.Hists)
*     Cancela ("Encerrar") -> ThisForm.ParentForm.CanceladoExterno = .T.
*                             + ThisForm.Release (o pai aborta a baixa)
*
*   Portanto o destino de TODA escrita deste dialogo eh o CURSOR LOCAL do pai -
*   nao existe Insert Into / Update / Delete From / TableUpdate / AddCursor
*   sobre tabela do SQL Server em nenhum metodo do SIGOPLHI. O acesso remoto
*   do legado se resume a LEITURA de crSigCdPgr (Dopes + MascNum) para montar
*   o Caption. Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase (recusar
*   a operacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
*   inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a lista de
*   colunas vem do schema, nunca de adivinhacao).
*
* CAPTION DO LEGADO (Init do SIGOPLHI):
*   'Lancamentos para ' + Alltrim(crSigCdPgr.Dopes) + ' - '
*                       + Alltrim(crSigCdPgr.MascNum)
*   e o mesmo texto vai para cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
* ATENCAO AO DUMP DO SCX (divergencia herdada, confirmada no legado):
*   Grade.Column3.ControlSource       = "HISTS"  <- vale este (a Column manda)
*   Grade.Column3.Text1.ControlSource = "Nomes"  <- residuo: TmpLanca NAO tem
*                                                   coluna Nomes
*==============================================================================

DEFINE CLASS SigOpLhiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdPgr (crSigCdPgr no legado)
    * Somente leitura: alimenta o Caption / titulo do dialogo.
    * O sufixo "Pgr" existe porque SigCdPgr TAMBEM tem as colunas grupos e
    * contas, que colidiriam com as colunas homonimas de TmpLanca abaixo.
    *--------------------------------------------------------------------------
    this_cDopes             = ""   && dopes      CHAR(20)      - tipo de documento
    this_cMascNum           = ""   && mascnum    CHAR(6)       - numero mascarado
    this_cCidChaves         = ""   && cidchaves  CHAR(20)      - chave primaria real
    this_cEmps              = ""   && emps       CHAR(3)       - empresa
    this_nNumes             = 0    && numes      NUMERIC(6,0)  - numero do documento
    this_cGruposPgr         = ""   && grupos     CHAR(10)      - grupo da programacao
    this_cContasPgr         = ""   && contas     CHAR(10)      - conta da programacao
    this_cEmpDopNums        = ""   && empdopnums CHAR(29)      - chave posicional

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DO CURSOR DE LANCAMENTOS (TmpLanca)
    * Nomes espelhados coluna a coluna para eliminar divergencia de
    * nomenclatura entre Form e BO (CLAUDE.md / Pattern #177).
    * As colunas sem sufixo sao o lado principal do lancamento; as terminadas
    * em "C" sao a contrapartida.
    *--------------------------------------------------------------------------
    this_cGrupos            = ""   && Grupos     CHAR(10)      - grupo da conta (grid "Grupo")
    this_cContas            = ""   && Contas     CHAR(10)      - conta (grid "Conta")
    this_cMoeda             = ""   && Moeda      CHAR(3)       - moeda (grid "Moe")
    this_nCotacaos          = 0    && Cotacaos   NUMERIC(14,4) - cotacao da moeda
    this_cGrupoC            = ""   && GrupoC     CHAR(10)      - grupo da contrapartida
    this_cContaC            = ""   && ContaC     CHAR(10)      - conta da contrapartida
    this_cMoedaC            = ""   && MoedaC     CHAR(3)       - moeda da contrapartida
    this_nCotacaoC          = 0    && CotacaoC   NUMERIC(14,4) - cotacao da contrapartida
    this_cHists             = ""   && Hists      CHAR(40)      - historico (grid, EDITAVEL)
    this_cHist2s            = ""   && Hist2s     CHAR(40)      - historico complementar
    this_nValor             = 0    && Valor      NUMERIC(12,2) - valor (grid "Valor")
    this_nValPag            = 0    && ValPag     NUMERIC(12,2) - valor pago
    this_cTipos             = ""   && Tipos      CHAR(1)       - tipo do lancamento
    this_nValorC            = 0    && ValorC     NUMERIC(12,2) - valor da contrapartida
    this_nValPagC           = 0    && ValPagC    NUMERIC(12,2) - valor pago da contrapartida

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_cCursorLancamentos : alias migrado de TmpLanca. O cursor eh criado e
    *   populado pelo form PAI; este dialogo apenas o exibe e edita o Hists.
    * this_lCanceladoExterno  : espelha ThisForm.ParentForm.CanceladoExterno do
    *   legado - .T. quando o usuario saiu pelo botao Encerrar (Cancela).
    *--------------------------------------------------------------------------
    this_cCursorLancamentos = "cursor_4c_Lancamentos"
    this_cTituloDialogo     = ""
    this_lCanceladoExterno  = .F.
    this_nTotalLancamentos  = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este dialogo
    * nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de CONTEXTO, lida para montar o
    * titulo do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPgr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela de contexto (cidchaves).
    * PROTECTED por contrato da BusinessBase (CLAUDE.md regra #51): nunca
    * chamar de fora do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia o cursor de CONTEXTO (SigCdPgr, crSigCdPgr no
    * legado) para as propriedades this_c*/this_n* que identificam o registro
    * pai e alimentam o titulo do dialogo. Chamado pelo Form a partir do
    * cursor de contexto que o form PAI ja mantem aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_cMascNum    = TratarNulo(mascnum, "")
        THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
        THIS.this_cEmps       = TratarNulo(emps, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cGruposPgr  = TratarNulo(grupos, "")
        THIS.this_cContasPgr  = TratarNulo(contas, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        THIS.MontarTitulo()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarTitulo - Reproduz o Caption do Init legado:
    *   'Lancamentos para ' + Alltrim(Dopes) + ' - ' + Alltrim(MascNum)
    * Alimenta this_cTituloDialogo, usado pelo Form no Caption do form e nos
    * dois labels do cabecalho (lbl_4c_Sombra / lbl_4c_Titulo).
    *--------------------------------------------------------------------------
    PROCEDURE MontarTitulo()
        THIS.this_cTituloDialogo = "Lan" + CHR(231) + "amentos para " + ;
            ALLTRIM(THIS.this_cDopes) + " - " + ALLTRIM(THIS.this_cMascNum)

        RETURN THIS.this_cTituloDialogo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhaAtual - Copia a linha CORRENTE do cursor de lancamentos
    * (TmpLanca no legado) para as propriedades this_* da linha. O Grid
    * continua ligado DIRETO ao cursor via ControlSource - este metodo existe
    * para o Form consultar/validar a linha corrente fora do Grid (regra #46:
    * validacao de celula vai no Valid do TextBox da coluna, nunca em
    * AfterRowColChange).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLinhaAtual(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        THIS.this_cGrupos   = TratarNulo(Grupos, "")
        THIS.this_cContas   = TratarNulo(Contas, "")
        THIS.this_cMoeda    = TratarNulo(Moeda, "")
        THIS.this_nCotacaos = TratarNulo(Cotacaos, 0)
        THIS.this_cGrupoC   = TratarNulo(GrupoC, "")
        THIS.this_cContaC   = TratarNulo(ContaC, "")
        THIS.this_cMoedaC   = TratarNulo(MoedaC, "")
        THIS.this_nCotacaoC = TratarNulo(CotacaoC, 0)
        THIS.this_cHists    = TratarNulo(Hists, "")
        THIS.this_cHist2s   = TratarNulo(Hist2s, "")
        THIS.this_nValor    = TratarNulo(Valor, 0)
        THIS.this_nValPag   = TratarNulo(ValPag, 0)
        THIS.this_cTipos    = TratarNulo(Tipos, "")
        THIS.this_nValorC   = TratarNulo(ValorC, 0)
        THIS.this_nValPagC  = TratarNulo(ValPagC, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Grava o novo texto de Historico na linha CORRENTE do
    * cursor de lancamentos. Eh a UNICA coluna editavel do grid no legado
    * (Grade.Column3 sem ReadOnly = .T. no SCX) - Grupo/Conta/Valor/Moe sao
    * somente leitura (Column1/2/4/5 com ReadOnly = .T.).
    *--------------------------------------------------------------------------
    PROCEDURE GravarHistorico(par_cAliasLancamentos, par_cNovoHistorico)
        LOCAL loc_cAlias, loc_cValor

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)
        loc_cValor = IIF(VARTYPE(par_cNovoHistorico) = "C", par_cNovoHistorico, "")

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        REPLACE Hists WITH loc_cValor IN (loc_cAlias)
        THIS.this_cHists = loc_cValor

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ContarLancamentos - Total de linhas do cursor de lancamentos. O form PAI
    * so abre este dialogo quando !Eof() (ver cabecalho) - o Form usa este
    * metodo para confirmar que ha o que exibir antes de tornar o grid ativo.
    *--------------------------------------------------------------------------
    PROCEDURE ContarLancamentos(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias)
            THIS.this_nTotalLancamentos = 0
        ELSE
            THIS.this_nTotalLancamentos = RECCOUNT(loc_cAlias)
        ENDIF

        RETURN THIS.this_nTotalLancamentos
    ENDPROC

ENDDEFINE

