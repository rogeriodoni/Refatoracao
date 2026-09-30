# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-26 01:39:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-26 01:39:04] [INFO] Config FPW: (nao fornecido)
[2026-09-26 01:39:04] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 01:39:04] [INFO] Timeout: 300 segundos
[2026-09-26 01:39:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_red20pt5.prg
[2026-09-26 01:39:04] [INFO] Conteudo do wrapper:
[2026-09-26 01:39:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrAop', 'C:\4c\tasks\task583\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrAop', 'C:\4c\tasks\task583\logs\06_testForm.log'
QUIT

[2026-09-26 01:39:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_red20pt5.prg
[2026-09-26 01:39:04] [INFO] VFP output esperado em: C:\4c\tasks\task583\vfp_output.txt
[2026-09-26 01:39:04] [INFO] Executando Visual FoxPro 9...
[2026-09-26 01:39:04] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_red20pt5.prg
[2026-09-26 01:39:04] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_red20pt5.prg
[2026-09-26 01:39:04] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrAop
Inicio: 26/09/2026 01:39:04

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 26/09/2026 01:42:19
Duracao: 195 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-26 01:42:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-26 01:42:20] [INFO] VFP9 finalizado em 195.9869962 segundos
[2026-09-26 01:42:20] [INFO] Exit Code: 
[2026-09-26 01:42:20] [INFO] 
[2026-09-26 01:42:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-26 01:42:20] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_red20pt5.prg
[2026-09-26 01:42:20] [INFO] 
[2026-09-26 01:42:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-26 01:42:20] [INFO] * Auto-generated wrapper for parameters
[2026-09-26 01:42:20] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 01:42:20] [INFO] * Parameters: 'FormSigPrAop', 'C:\4c\tasks\task583\logs\06_testForm.log'
[2026-09-26 01:42:20] [INFO] 
[2026-09-26 01:42:20] [INFO] * Anti-dialog protections for unattended execution
[2026-09-26 01:42:20] [INFO] SET SAFETY OFF
[2026-09-26 01:42:20] [INFO] SET RESOURCE OFF
[2026-09-26 01:42:20] [INFO] SET TALK OFF
[2026-09-26 01:42:20] [INFO] SET NOTIFY OFF
[2026-09-26 01:42:20] [INFO] SYS(2335, 0)
[2026-09-26 01:42:20] [INFO] 
[2026-09-26 01:42:20] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrAop', 'C:\4c\tasks\task583\logs\06_testForm.log'
[2026-09-26 01:42:20] [INFO] QUIT
[2026-09-26 01:42:20] [INFO] 
[2026-09-26 01:42:20] [INFO] === Fim do Wrapper.prg ===
[2026-09-26 01:42:20] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg):
*==============================================================================
* FormSigPrAop.prg - Form OPERACIONAL: Altera??o de Quantidade da O.P.
* Herda de: FormBase
* Migrado de: tasks/task583/SigPrAop.SCX (SIGPRAOP)
*
* Pilares:
*   UX   -> layout identico ao legado (grid de divisao de quantidade + campos
*           O.P./Produto/Observacoes), escalado para o canonico 1000x600
*           (legado eh 702x436 - ver analise.json desta task)
*   BD   -> SigOpPic/SigPdMvf/SigCdNec/SigCdPam via SigPrAopBO
*   CODE -> FormBase + SigPrAopBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Estrutura original: cntSombra (cabecalho) + Grade (grid de divisao de
* quantidade, 5 colunas) + Say1/Say2 (labels O.P./Produto) + Grupo_Conf
* (Confirmar/Encerrar) + Get_obss (observacoes, readonly) + Get_OP (digitacao
* da O.P.) + Get_Produto (readonly, preenchido pelo Valid de Get_OP)
*
* Fase 3/8: estrutura basica (DEFINE CLASS, Init, InicializarForm,
* ConfigurarPageFrame, cabecalho, Destroy).
* Fase 4/8: Grid (grd_4c_Dados, ligado a cursor_4c_DivOp do BO) + grupo de
* botoes Confirmar/Encerrar (cmg_4c_Grupo_Conf, equivalente ao Grupo_Conf do
* legado - este form NAO tem Incluir/Alterar/Excluir/Visualizar/Buscar nem
* Page1/Page2: o legado herda de "form" puro, e o unico par de botoes eh
* Confirmar (grava a divisao de quantidade) + Encerrar (fecha o form).
* Fase 5/8: labels + campo da O.P. + CarregarDados (parte de dados do
* Get_OP.Valid, delegada ao BO).
* Fase 6/8: campos restantes (Produto, Observacoes) e os eventos do unico campo
* digitavel da tela - Get_OP.Valid/LostFocus/When do legado, ligados por
* BINDEVENT em KeyPress/LostFocus/GotFocus (ValidarOP/PularParaGradeAposOP/
* TxtOPGotFocus). Este form NAO tem lookup/picker algum: o codigo fonte
* original nao tem CreateObject('fwbuscaext'/'fwBuscaSel'/'fwBuscaInt') nem
* sigacess() - a "busca" da O.P. eh a consulta SQL do proprio Valid, em
* SigCdNec/SigPdMvf/SigOpPic. Inventar picker aqui violaria o PILAR 1.
* Fase 7/8: eventos principais dos botoes do Grupo_Conf (Salva.Click/
 * Conf_Sair.Click do legado, ligados por BINDEVENT em Buttons(1)/Buttons(2))
 * e AfterRowColChange da grade (ThisForm.Get_obss.Refresh do legado). A parte
 * de GRAVACAO do Salva.Click ja estava implementada em SigPrAopBO.Atualizar()
 * desde a Fase 2 - BtnConfirmarClick so precisava chamar Salvar() (contrato
 * BusinessBase) e replicar a limpeza de campos que o legado faz no sucesso.
 * Fase 8/8: consolidacao. Auditados os 15 metodos/eventos do SCX legado um a um
 * contra o migrado - todos ja tinham equivalente real (nao ha o que acrescentar
 * sem INVENTAR). O checklist generico da fase (BtnSalvarClick/BtnCancelarClick/
 * FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/CarregarLista/
 * AjustarBotoesPorModo) eh convencao de form CRUD com Page1(Lista)/Page2(Dados)
 * e modo INCLUIR/ALTERAR: o SIGPRAOP nao tem nenhum dos dois - eh tela unica com
 * UM campo digitavel (a O.P.) que DISPARA a carga da grade, grade toda
 * somente-leitura menos a coluna Quantidade, e UM par de botoes
 * (Confirmar/Encerrar). Os equivalentes reais sao BtnConfirmarClick (grava),
 * BtnEncerrarClick (fecha) e CarregarDados (popula a grade).
 * Dois defeitos CORRIGIDOS nesta fase, ambos achados ao validar:
 *   1) ShowWindow atribuido em RUNTIME no Init. Medido no VFP9
 *      (automation\vfp_helpers\medir_showwindow.prg): a propriedade eh
 *      READ-ONLY em runtime, inclusive dentro do proprio Init. Como a
 *      atribuicao ficava no ramo "NAO estou em modo teste", ela NUNCA rodava
 *      sob o harness e SEMPRE rodaria em producao - CREATEOBJECT devolveria
 *      .F. e a tela nunca abriria pelo menu. Agora ShowWindow/WindowType sao
 *      definidos SO na declaracao da classe (1/1, convencao do projeto).
 *   2) BINDEVENT do LostFocus do Get_OP religado em "KeyPress" pelo
 *      CorretorAutomatico (LOSTFOCUS-LOOKUP): falso positivo - o criterio (d)
 *      do pattern trata como lookup todo handler cujo NOME termina em
 *      "LostFocus", e este form nao tem lookup nenhum. Handler renomeado pela
 *      ACAO (PularParaGradeAposOP), o que restaura o evento correto e torna o
 *      arquivo idempotente perante o corretor.
 * Verificado: COMPILE sem .ERR nos dois arquivos, CREATEOBJECT + Show() OK em
 * VFP9 -T, grade com as 5 colunas/larguras/captions do pColuna legado, cursor
 * de 12 campos igual ao Create Cursor Temp_DivOp, e os handlers auxiliares
 * chamados de fora da classe sem erro.
*==============================================================================
DEFINE CLASS FormSigPrAop AS FormBase

    *-- Propriedades visuais (legado 702x436, escalado para o canonico 1000x600)
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    *-- ShowWindow/WindowType so podem ser definidos AQUI, na classe: medido no
    *-- VFP9 (2026-09-26, automation\vfp_helpers\medir_showwindow.prg) que
    *-- ShowWindow eh READ-ONLY em runtime - atribuir em qualquer ponto, inclusive
    *-- dentro do proprio Init, estoura "Property SHOWWINDOW is read-only", o
    *-- CREATEOBJECT devolve .F. e o menu nao abre a tela. WindowType, ao
    *-- contrario, aceita atribuicao em runtime (eh o que o TestFormWrapper faz
    *-- para poder exibir a tela nao-modal no harness headless).
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    DataSession = 2

    *-- Referencia ao Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia do ValidarOP: o handler roda no KeyPress do
    *-- txt_4c_OP e a propria consulta move o foco (SetFocus na grade, no
    *-- LostFocus), o que pode reentrar no mesmo caminho. Sem a guarda a O.P.
    *-- seria consultada duas vezes por digitacao (ENTER seguido de TAB).
    this_lValidandoOP = .F.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."

        *-- NAO atribuir ShowWindow aqui: eh READ-ONLY em runtime (ver o
        *-- comentario na declaracao da classe). O harness headless nao precisa
        *-- de ajuste nenhum - o TestFormWrapper baixa WindowType para 0 por
        *-- conta propria antes do Show(), e ShowWindow so tem efeito no Show().
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAopBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrAopBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()

                THIS.TornarControlesVisiveis(THIS)

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
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * SIGPRAOP nao tem PageFrame Lista/Dados no legado (herda de "form" puro,
    * nao de frmcadastro) - o metodo eh mantido com este nome por conformidade
    * com o contrato do pipeline e delega para os configuradores especificos.
    * ConfigurarCabecalho() eh montado nesta fase; ConfigurarGrid()/
    * ConfigurarCampos()/ConfigurarBotoes() serao adicionados nas Fases 4-6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria o container escuro superior com as labels de
    * titulo (SIGPRAOP.cntSombra.lblSombra/lblTitulo do legado)
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
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255,255,255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria a grade de divisao de quantidade (SIGPRAOP.Grade
    * do legado, RecordSource="Temp_DivOp"). O cursor cursor_4c_DivOp ja
    * existe (vazio) neste ponto - THIS.this_oBusinessObject.CriarCursorItens()
    * roda dentro do Init do BO (chamado em InicializarForm ANTES deste
    * metodo) - sem isso o RecordSource travaria o Init (regra do cursor que
    * ainda nao existe).
    *
    * Colunas na ORDEM VISUAL do legado (ColumnOrder 1..5): Pedido (Dopes +
    * fGerMascara(Numes), somente leitura) / Cor (CodCors, somente leitura) /
    * Tam (CodTams, somente leitura) / Qtd.Atual (Qtds, somente leitura) /
    * Quantidade (QtdDivs, EDITAVEL - eh o campo que o usuario altera para
    * dividir a O.P., Grupo_Conf.Salva.Click grava esse valor de volta em
    * SigOpPic.Qtds/SeqDivs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "cursor_4c_DivOp"
        WITH loc_oGrid
            .Top           = 142
            .Left          = 50
            .Width         = 442
            .Height        = 207
            .FontName      = "Arial"
            .FontSize      = 8
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.

            .Column1.ControlSource   = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + ALLTRIM(fGerMascara(cursor_4c_DivOp.Numes))"
            .Column1.Width           = 180
            .Column1.Alignment       = 0
            .Column1.ReadOnly        = .T.
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.FontName        = "Arial"
            .Column1.FontSize        = 8
            .Column1.Header1.Caption = "Pedido"

            .Column2.ControlSource   = "cursor_4c_DivOp.CodCors"
            .Column2.Width           = 38
            .Column2.ReadOnly        = .T.
            .Column2.Movable         = .F.
            .Column2.Resizable       = .F.
            .Column2.FontName        = "Arial"
            .Column2.FontSize        = 8
            .Column2.Header1.Caption = "Cor"

            .Column3.ControlSource   = "cursor_4c_DivOp.CodTams"
            .Column3.Width           = 38
            .Column3.ReadOnly        = .T.
            .Column3.Movable         = .F.
            .Column3.Resizable       = .F.
            .Column3.FontName        = "Arial"
            .Column3.FontSize        = 8
            .Column3.Header1.Caption = "Tam"

            .Column4.ControlSource   = "cursor_4c_DivOp.Qtds"
            .Column4.Width           = 80
            .Column4.Alignment       = 1
            .Column4.InputMask       = "999,999.999"
            .Column4.ReadOnly        = .T.
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.FontName        = "Arial"
            .Column4.FontSize        = 8
            .Column4.Header1.Caption = "Qtd.Atual"

            .Column5.ControlSource   = "cursor_4c_DivOp.QtdDivs"
            .Column5.Width           = 80
            .Column5.Format          = "K"
            .Column5.ReadOnly        = .F.
            .Column5.Movable         = .F.
            .Column5.Resizable       = .F.
            .Column5.FontName        = "Arial"
            .Column5.FontSize        = 8
            .Column5.Header1.Caption = "Quantidade"
        ENDWITH

        *-- Legado: Grade.AfterRowColChange -> ThisForm.Get_obss.Refresh
        *-- (o EditBox de observacoes eh ligado por ControlSource direto ao
        *-- cursor - so precisa ser avisado para redesenhar ao mudar de linha)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria o grupo Confirmar/Encerrar (SIGPRAOP.Grupo_Conf
    * do legado). Top=-2/Left=544 posiciona o grupo flutuando SOBRE a faixa
    * do cabecalho (cnt_4c_Cabecalho, Top=0..80, ja criado por
    * ConfigurarPageFrame ANTES deste metodo - regra da faixa ser o PRIMEIRO
    * AddObject da tela, senao ela cobriria estes botoes).
    *
    * Confirmar (Buttons(1)) grava a divisao de quantidade em SigOpPic/
    * SigPdMvf (equivalente a Grupo_Conf.Salva.Click); Encerrar (Buttons(2))
    * fecha o form (equivalente a Grupo_Conf.Conf_Sair.Click). BINDEVENT dos
    * Click fica para a Fase 7-8, junto com o resto dos eventos do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_Grupo_Conf", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_Grupo_Conf
        WITH loc_oGrp
            .Top          = -2
            .Left         = 544
            .Width        = 160
            .Height       = 85
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .SpecialEffect = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                *-- DisabledPicture: CarregarDados alterna .Enabled deste botao
                *-- (legado: Get_OP.When desliga, Get_OP.Valid religa ao achar
                *-- a O.P.) - sem DisabledPicture o icone some no estado cinza
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                *-- "\<Confirmar" preserva a tecla de acesso Alt+C do legado
                .Caption    = "\<Confirmar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- Legado: Grupo_Conf.Salva.Click / Grupo_Conf.Conf_Sair.Click.
        *-- BINDEVENT no Buttons(N) individual (nao no CommandGroup inteiro) -
        *-- padrao ja adotado em outros forms OPERACIONAIS/REPORT do projeto.
        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria os campos de captura/exibicao da tela (SIGPRAOP.
    * Say1/Get_OP/Say2/Get_Produto/Get_obss do legado). Posicoes transcritas
    * EXATAS do dump (regiao acima e abaixo da grade, Top=142/Height=207 - ver
    * ConfigurarGrid): sem necessidade de offset porque o form manteve a
    * escala original de coordenadas do legado (703x436) dentro do canvas
    * 1000x600 (so o cabecalho usa THIS.Width para esticar a faixa).
    *
    * Say1/Say2 nao declaram Alignment no dump (classe "say" pura, AutoSize=.T.
    * por padrao no framework) -> Alignment=0 / AutoSize=.F. com Width fixo
    * (regra de label de dados: nunca inventar Alignment=1).
    *
    * txt_4c_OP (Get_OP): InputMask/MaxLength TRANSCRITOS do legado
    * (InputMask="999999999999", MaxLength=12) - digitacao da O.P.; a consulta
    * dispara em ENTER/TAB por ValidarOP (BINDEVENT no fim deste metodo), que
    * corta para os 10 digitos de SigOpPic.Nops como o Valid legado faz.
    *
    * txt_4c_Produto (Get_Produto): o legado NAO usa fwBuscaExt/sigacess aqui -
    * o campo eh so exibicao, preenchido por CarregarDados/BuscarItensPorOP a
    * partir de SigPdMvf.CodPds (Get_OP.Valid). O bloqueio de digitacao no
    * legado eh feito via PROCEDURE When / Return .f. (nunca recebe foco);
    * .ReadOnly = .T. reproduz o mesmo efeito pratico. NAO ha lookup F4/F5
    * neste form inteiro (nenhum CreateObject('fwbuscaext'/'fwBuscaSel') nem
    * sigacess() no codigo fonte original) - a "busca" da O.P. eh a propria
    * consulta SQL do Valid, ja implementada em CarregarDados (Fase 5).
    *
    * edt_4c_Obss (Get_obss): EditBox somente-leitura ligado por ControlSource
    * direto ao cursor da grade (cursor_4c_DivOp.Obss) - o VFP atualiza o
    * conteudo sozinho a cada mudanca de linha corrente, e AfterRowColChange
    * (Fase 7-8) so precisa dar THIS.edt_4c_Obss.Refresh() para redesenhar,
    * igual ao ThisForm.Get_obss.Refresh do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 93
            .Left      = 70
            .Width     = 31
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "O.P. :"
        ENDWITH

        THIS.AddObject("txt_4c_OP", "TextBox")
        WITH THIS.txt_4c_OP
            .Top        = 90
            .Left       = 107
            .Width      = 96
            .Height     = 23
            .InputMask  = "999999999999"
            .MaxLength  = 12
            .Value      = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 117
            .Left      = 50
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto :"
        ENDWITH

        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top      = 114
            .Left     = 107
            .Width    = 96
            .Height   = 23
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top               = 356
            .Left              = 48
            .Width             = 443
            .Height            = 70
            .ReadOnly          = .T.
            .ControlSource     = "cursor_4c_DivOp.Obss"
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Eventos do unico campo digitavel da tela (Get_OP do legado). Os
        *-- handlers sao PUBLIC de proposito: BINDEVENT com metodo PROTECTED
        *-- falha em silencio, e o harness de teste chama estes metodos de fora
        *-- da classe.
        *
        *-- Get_OP.Valid -> "KeyPress", NAO "LostFocus": BINDEVENT em "Valid"
        *-- nao dispara de forma confiavel em TextBox, e LostFocus dispara
        *-- SEMPRE (inclusive por SetFocus de outro controle), o que colocaria a
        *-- consulta SQL da O.P. em recursao. ENTER/TAB reproduzem o momento em
        *-- que o Valid do legado rodava (ao confirmar/sair do campo).
        BINDEVENT(THIS.txt_4c_OP, "KeyPress",  THIS, "TxtOPKeyPress")

        *-- Get_OP.LostFocus -> salto de foco para a coluna editavel da grade.
        *-- Este eh o UNICO evento do form que tem de ficar mesmo em LostFocus:
        *-- o legado salta o foco ao SAIR do campo, nao ao teclar. Nao ha lookup
        *-- aqui (o form nao tem FormBuscaAuxiliar), logo nao ha o risco de
        *-- recursao que motiva a regra "lookup nunca em LostFocus". O handler eh
        *-- nomeado pela ACAO (PularParaGradeAposOP) e nao pelo evento: handler
        *-- com nome terminando em "LostFocus" eh tratado como lookup pelo
        *-- CorretorAutomatico (LOSTFOCUS-LOOKUP, criterio (d) - so o NOME), que
        *-- religava este BINDEVENT em "KeyPress" - o que empilhava um segundo
        *-- handler de KeyPress no mesmo controle, passava dois argumentos a um
        *-- metodo sem parametros e disparava o salto de foco a cada tecla.
        BINDEVENT(THIS.txt_4c_OP, "LostFocus", THIS, "PularParaGradeAposOP")

        *-- Get_OP.When (ThisForm.Grupo_Conf.Salva.Enabled = .f.) -> GotFocus:
        *-- o When do legado roda ao ENTRAR no campo e desliga o Confirmar, que
        *-- o Valid religa ao localizar a O.P. BINDEVENT em "When" nao eh
        *-- confiavel (e o retorno do delegate eh descartado), mas GotFocus
        *-- ocorre no mesmo instante pratico e o efeito colateral eh o mesmo.
        BINDEVENT(THIS.txt_4c_OP, "GotFocus",  THIS, "TxtOPGotFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOPGotFocus - Transcreve o PROCEDURE When do Get_OP legado:
    *
    *   ThisForm.Grupo_Conf.Salva.Enabled = .f.
    *
    * Ao voltar para o campo da O.P. o Confirmar eh desligado; CarregarDados o
    * religa quando a O.P. eh localizada (this_lOPLocalizada). Impede gravar a
    * divisao de uma O.P. que o usuario acabou de trocar sem reconsultar.
    *--------------------------------------------------------------------------
    PROCEDURE TxtOPGotFocus()
        IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
            THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOPKeyPress - dispara a validacao da O.P. em ENTER/TAB (o momento em
    * que o Valid do Get_OP legado rodava). F4/F5 NAO tem funcao neste campo:
    * o form inteiro nao possui lookup/picker (nenhum CreateObject('fwbuscaext'
    * /'fwBuscaSel'/'fwBuscaInt') nem sigacess() no codigo fonte original) - a
    * "busca" da O.P. eh a propria consulta SQL do Valid, em SigCdNec/SigPdMvf/
    * SigOpPic. Inventar um picker aqui violaria o PILAR 1.
    *
    * Os DOIS parametros do evento sao obrigatorios na assinatura: handler de
    * KeyPress que nao os declara falha em runtime ("No PARAMETER statement is
    * found"). Declarados aqui na propria PROCEDURE - acrescentar tambem um
    * LPARAMETERS seria declaracao duplicada.
    *--------------------------------------------------------------------------
    PROCEDURE TxtOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) = "N" AND (par_nKeyCode = 13 OR par_nKeyCode = 9)
            THIS.ValidarOP()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PularParaGradeAposOP - Transcreve o PROCEDURE LostFocus do Get_OP legado
    * (nomeado pela ACAO, nao pelo evento - ver o BINDEVENT em ConfigurarCampos):
    *
    *   If Not Empty(This.Value) And Not Eof('Temp_divOp')
    *       ThisForm.Grade.Column2.Text1.SetFocus
    *   EndIf
    *
    * O legado renomeia as colunas da grade: o objeto chamado "Column2" no SCX
    * eh a coluna DECLARADA em 3o lugar, ControlSource Temp_DivOp.QtdDivs,
    * ColumnOrder = 5 - a unica editavel (as demais tem ReadOnly = .T. e
    * When -> Return .f.). No migrado, que segue a ordem VISUAL, ela eh a
    * Column5. Conferido no dump: Column3.Name = "Column2" / .Format = "K" /
    * sem ReadOnly, e Grade.Column2.Text1.When = On Key Label 'ENTER'.
    *
    * Este handler NAO consulta nada (a consulta fica no KeyPress): LostFocus
    * dispara sempre, e chamar SQL daqui entraria em recursao.
    *--------------------------------------------------------------------------
    PROCEDURE PularParaGradeAposOP()
        LOCAL loc_oBO, loc_cCursor

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorItens

        IF !EMPTY(THIS.txt_4c_OP.Value) AND USED(loc_cCursor) AND !EOF(loc_cCursor) ;
           AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                THIS.grd_4c_Dados.Column5.Text1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOP - Transcreve a parte de CAMPO do PROCEDURE Valid do Get_OP
    * legado (a parte de DADOS mora em CarregarDados/BO.BuscarItensPorOP):
    *
    *   Zap In Temp_DivOp                      -> CarregarDados(0) esvazia a grade
    *   If Empty(This.Value) / Return          -> sai sem avisar nada
    *   If Len(Alltrim(This.Value)) > 10       -\ a coluna SigOpPic.Nops eh
    *       This.Value = Right(This.Value, 10) -/ numeric(10) e o InputMask do
    *                                             campo aceita 12 digitos: o
    *                                             legado corta os excedentes A
    *                                             ESQUERDA, no proprio campo
    *   lnOp = Val( This.Value )               -> par_nNops de CarregarDados
    *
    * O legado NAO valida faixa nem exige minimo de digitos - transcricao
    * literal, sem guard inventado.
    *
    * PUBLIC de proposito (BINDEVENT + harness de teste chamam de fora).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOP()
        LOCAL loc_cValor, loc_lRet

        loc_lRet = .F.

        *-- Guarda de reentrancia: a consulta move o foco (LostFocus -> SetFocus
        *-- na grade) e o proprio campo pode reentrar aqui antes de terminar
        IF THIS.this_lValidandoOP
            RETURN .F.
        ENDIF

        THIS.this_lValidandoOP = .T.

        *-- Legado: Zap In Temp_DivOp acontece ANTES do teste de vazio, portanto
        *-- limpar o campo e sair tambem esvazia a grade (CarregarDados(0))
        loc_cValor = ALLTRIM(THIS.txt_4c_OP.Value)

        IF EMPTY(loc_cValor)
            loc_lRet = THIS.CarregarDados(0)
        ELSE
            *-- Legado: If (Len(Alltrim(This.Value)) > 10) / This.Value = Right(This.Value, 10)
            IF LEN(loc_cValor) > 10
                loc_cValor = RIGHT(loc_cValor, 10)
                THIS.txt_4c_OP.Value = loc_cValor
            ENDIF

            *-- Legado: lnOp = Val( This.Value )
            loc_lRet = THIS.CarregarDados(VAL(loc_cValor))
        ENDIF

        THIS.this_lValidandoOP = .F.

        RETURN loc_lRet
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula a grade de divisao de quantidade a partir de uma
    * O.P. Transcreve o PROCEDURE Valid do Get_OP legado:
    *
    *   Zap In Temp_DivOp                      -> BuscarItensPorOP recria o cursor
    *   If Empty(This.Value) / Return          -> par_nNops = 0 apenas esvazia
    *   CursorQuery SigCdNec ... ChkSubn       -\
    *   CursorQuery SigPdMvf ... CodPds        -+-> BuscarItensPorOP (no BO)
    *   Scan SigOpPic / Insert Into Temp_DivOp -/
    *   ThisForm.Get_Produto.Value = CodPds    -> espelha this_cCodProduto
    *   Grupo_Conf.Salva.Enabled = .t.         -> Buttons(1).Enabled
    *   Messagebox 'O.P. Ja Foi Encerrada!!!'  -\
    *   Messagebox 'O.P. Nao Localizada!!!'    -+-> this_cMensagemErro do BO
    *   This.Value = ''                        -> limpa Get_OP no insucesso
    *   ThisForm.Grade.Refresh                 -> GO TOP + grd_4c_Dados.Refresh
    *
    * As duas mensagens do legado so aparecem com O.P. informada: digitar vazio
    * e sair apenas limpa a grade, sem avisar (mesmo comportamento do Valid).
    *
    * PUBLIC de proposito: o harness de teste chama CarregarDados() de fora da
    * classe, e metodo PROTECTED falharia em runtime mesmo passando no PEMSTATUS.
    *
    * Os acessos a txt_4c_Produto/txt_4c_OP/cmg_4c_Grupo_Conf/grd_4c_Dados
    * ficam sob PEMSTATUS defensivamente (o harness de teste pode chamar este
    * metodo em cenarios onde ConfigurarCampos/ConfigurarBotoes/ConfigurarGrid
    * ainda nao rodaram).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_nNops)
        LOCAL loc_nNops, loc_lSucesso, loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        loc_nNops = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        loc_lSucesso = loc_oBO.BuscarItensPorOP(loc_nNops)

        IF loc_lSucesso
            IF loc_oBO.this_lOPLocalizada
                *-- Legado: ThisForm.Get_Produto.Value = crSigPdMvf.CodPds
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.txt_4c_Produto.Value = loc_oBO.this_cCodProduto
                ENDIF
            ELSE
                *-- Legado: avisa (encerrada / nao localizada) e limpa o campo,
                *-- mas so quando alguma O.P. foi de fato digitada
                IF loc_nNops <> 0 AND !EMPTY(loc_oBO.this_cMensagemErro)
                    MsgAviso(loc_oBO.this_cMensagemErro, ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.txt_4c_Produto.Value = ""
                ENDIF
                IF loc_nNops <> 0 AND PEMSTATUS(THIS, "txt_4c_OP", 5)
                    THIS.txt_4c_OP.Value = ""
                ENDIF
            ENDIF
        ELSE
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os " + ;
                    "itens da O.P." + CHR(13) + loc_oBO.this_cMensagemErro, ;
                    "Erro em CarregarDados")
        ENDIF

        *-- Legado: Grupo_Conf.Salva.Enabled = .t. no ramo de sucesso (o When do
        *-- Get_OP ja havia desligado), portanto o botao so vale com itens carregados
        IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
            THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = loc_oBO.this_lOPLocalizada
        ENDIF

        *-- Legado: Select Temp_DivOp / Go Top / ThisForm.Grade.Refresh
        *-- Popular o cursor NAO repinta a grade sozinho
        IF USED(loc_oBO.this_cCursorItens)
            SELECT (loc_oBO.this_cCursorItens)
            GO TOP
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Transcreve o PROCEDURE Salva.Click do Grupo_Conf
    * legado. A parte de GRAVACAO (UPDATE SigOpPic/SigPdMvf + Commit,
    * inclusive o guard "lnOp = Val(Get_OP.Value) / If (lnOp = 0) / Return 0")
    * ja esta implementada em SigPrAopBO.Atualizar() desde a Fase 2 - este
    * metodo so precisa acionar o contrato BusinessBase (EditarRegistro() +
    * Salvar()) e replicar a limpeza feita no SUCESSO do Click legado:
    *
    *   ThisForm.Get_Op.SetFocus / ThisForm.Refresh                    -\
    *   ThisForm.Get_Op.Value = ' ' / ThisForm.Get_Produto.Value = ''  -+-> abaixo
    *   ThisForm.Grupo_Conf.Salva.Enabled = .f.                        -/
    *
    * BusinessBase.Salvar() exige this_lEmEdicao = .T. (senao recusa com
    * "Nao esta em modo de edicao" - regra do contrato da base); este form nao
    * tem Incluir/Alterar separados, entao EditarRegistro() eh chamado aqui,
    * imediatamente antes de Salvar() - a gravacao eh sempre uma redistribuicao
    * de linhas JA existentes em SigOpPic, nunca um novo registro.
    *
    * BO.Salvar()/Atualizar() ja exibem a falha sozinhos (BusinessBase.
    * ExibirFalha) em caso de erro - nenhum ELSE necessario aqui (regra #20).
    *
    * PUBLIC de proposito: BINDEVENT chama este metodo, e metodo PROTECTED
    * falha em silencio (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oBO, loc_lSucesso

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.EditarRegistro()

        loc_lSucesso = loc_oBO.Salvar()

        IF loc_lSucesso
            IF PEMSTATUS(THIS, "txt_4c_OP", 5)
                THIS.txt_4c_OP.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                THIS.txt_4c_Produto.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
                THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = .F.
            ENDIF
            *-- Legado: ThisForm.Refresh (Zap In Temp_DivOp ja rodou dentro de
            *-- Atualizar() no sucesso) - grade e observacoes precisam ser
            *-- avisadas para redesenhar vazias (regra: popular/esvaziar cursor
            *-- nao repinta o grid sozinho)
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_Obss", 5)
                THIS.edt_4c_Obss.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_OP", 5)
                THIS.txt_4c_OP.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Transcreve o PROCEDURE Conf_Sair.Click do Grupo_Conf
    * legado (ThisForm.Release). O "On Key Label ENTER" do legado apenas limpa
    * um keyboard trap global de ENTER que o MENU CHAMADOR configurava antes de
    * abrir este form modal (unico outro uso de ON KEY LABEL no codigo fonte
    * original, no When da coluna editavel da grade) - o sistema novo nao usa
    * ON KEY LABEL global, entao nao ha trap para limpar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Transcreve o PROCEDURE AfterRowColChange da Grade
    * legada: ThisForm.Get_obss.Refresh. O EditBox edt_4c_Obss ja esta ligado
    * por ControlSource direto ao cursor da grade (cursor_4c_DivOp.Obss) - so
    * precisa ser avisado para redesenhar ao mudar de linha/coluna corrente.
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5)
            THIS.edt_4c_Obss.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form (sem Visible=.F. condicional
    * no legado - todos os controles de SIGPRAOP sao permanentes na tela)
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
    * Destroy - libera a referencia ao Business Object. SigPrAopBO.Destroy()
    * (disparado automaticamente pelo VFP ao zerar a ultima referencia) libera
    * os cursores de trabalho abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*============================================================================
* SigPrAopBO.prg - Business Object para Altera??o de Quantidade da O.P.
*
* Tabela principal : SigOpPic  (PK: cIdChaves char(20))
* Tabelas relacionadas:
*   - SigCdNec (EmpDNps = _Empr + DoppPads + Str(Nops,10)) -> ChkSubn (O.P. encerrada?)
*   - SigPdMvf (Nops, cIdChaves, CodPds, Qtds) -> produto e saldo total da O.P.
*   - SigCdPam (DoppPads, MascNums) -> parametros do sistema
*
* Form OPERACIONAL: permite dividir a quantidade de itens (Dopes+Numes) de
* uma Ordem de Producao ja liberada em novas sequencias (SeqDivs), gravando
* de volta em SigOpPic e atualizando o saldo total em SigPdMvf.
*
* O legado (Grupo_Conf.Salva.Click) NUNCA insere um novo registro em SigOpPic
* ou SigPdMvf - ele apenas redistribui a quantidade Qtds/SeqDivs entre linhas
* JA existentes (criadas em outro processo, fora deste form). Por isso este BO
* nao sobrescreve Inserir(): o comportamento padrao herdado de BusinessBase
* (recusar a operacao) ja eh o correto para esta entidade neste form.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) + carga de itens
*                da O.P. (BuscarItensPorOP, equivalente ao Get_OP.Valid legado)
*============================================================================

DEFINE CLASS SigPrAopBO AS BusinessBase

    *==========================================================================
    * Propriedades de cabecalho - digitadas/exibidas nos campos Get_OP/Get_Produto
    *==========================================================================
    this_nNops        = 0     && numeric(10) - Numero da O.P. (Get_OP.Value)
    this_cCodProduto  = ""    && char(10)    - Codigo do produto (SigPdMvf.CodPds, exibido em Get_Produto)

    *==========================================================================
    * Propriedades de estado - resultado da validacao da O.P. digitada
    *==========================================================================
    this_lOPLocalizada = .F.  && .T. quando a O.P. foi encontrada em SigCdNec e esta liberada
    this_lOPEncerrada  = .F.  && .T. quando SigCdNec.ChkSubn indica O.P. ja encerrada

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init
    *==========================================================================
    this_cDoppPads = ""       && char(20)     - Grupo/departamento padrao (SigCdPam.DoppPads), usado para montar EmpDNps
    this_nMascNums = 0        && numeric(1,0) - Tipo de mascara de numeracao (SigCdPam.MascNums), usado na formatacao do Pedido na grade

    *==========================================================================
    * Cursor de trabalho - grade de divisao de quantidade (equivalente ao
    * Temp_DivOp do legado). Criado/populado por BuscarItensPorOP().
    *==========================================================================
    this_cCursorItens = "cursor_4c_DivOp"

    *==========================================================================
    * Propriedades de item - espelham TODAS as colunas de SigOpPic usadas
    * neste form. Populadas por CarregarDoCursor() a partir de uma linha do
    * cursor (chave primaria = this_cIdChaves, casa com this_cCampoChave).
    *==========================================================================
    this_cIdChaves = ""       && char(20)     - SigOpPic.cIdChaves (PK)
    this_cDopes    = ""       && char(20)     - SigOpPic.Dopes
    this_nNumes    = 0        && numeric(6,0) - SigOpPic.Numes
    this_nQtds     = 0        && numeric(9,3) - SigOpPic.Qtds
    this_nSeqDivs  = 0        && numeric(3,0) - SigOpPic.SeqDivs
    this_dDataEs   = {}       && datetime     - SigOpPic.DataEs
    this_cObs      = ""       && text/memo    - SigOpPic.Obss
    this_cCpros    = ""       && char(14)     - SigOpPic.Cpros
    this_cCodCors  = ""       && char(4)      - SigOpPic.CodCors
    this_cCodTams  = ""       && char(4)      - SigOpPic.CodTams
    this_nCitens   = 0        && numeric(10,0)- SigOpPic.Citens

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela, chave primaria
    * e parametros do sistema (SigCdPam.DoppPads/MascNums), equivalente ao
    * ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crSigCdPam', ...) do legado.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cIdChaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, "SELECT DoppPads, MascNums FROM SigCdPam", "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads = PADR(TratarNulo(cursor_4c_SigCdPam.DoppPads, ""), 20)
                    THIS.this_nMascNums = TratarNulo(cursor_4c_SigCdPam.MascNums, 0)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario digitar uma O.P. valida em BuscarItensPorOP)
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor local de divisao de
    * quantidade. Estrutura TRANSCRITA do legado (Create Cursor Temp_DivOp,
    * PROCEDURE Load do SIGPRAOP): mesma ordem, tipos e tamanhos de campo em
    * TODOS os lugares onde o cursor eh criado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado: o
    * legado tambem faz "Zap In Temp_DivOp" no inicio do Get_OP.Valid, e por um
    * motivo que vale igual aqui - fechar o alias DERRUBA o binding de quem
    * aponta para ele (grd_4c_Dados.RecordSource + as 5 Column.ControlSource +
    * edt_4c_Obss.ControlSource, todos ligados em InicializarForm). Recriando,
    * o usuario digitava a O.P. e a grade ficava permanentemente vazia mesmo
    * com o cursor cheio - sem erro e sem log, porque o CREATE CURSOR funciona.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_DivOp")
            *-- Legado: Zap In Temp_DivOp (preserva a estrutura e o binding).
            *
            *-- SET SAFETY OFF em volta eh OBRIGATORIO, nao precaucao: com
            *-- SAFETY ON o ZAP abre o dialogo modal "Zap ... Are you sure?" e
            *-- CONGELA a tela. O form eh DataSession = 2, e SET SAFETY eh
            *-- escopado por data session: medido no VFP9 (2026-09-26), dentro
            *-- da datasession privada o SAFETY vale ON mesmo com SET SAFETY OFF
            *-- no main.prg - mesmo mecanismo que reseta SET DATE/CENTURY ali.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_DivOp
            ZAP IN cursor_4c_DivOp
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_DivOp (Qtds N(12,3), QtdDivs N(12,3), Dopes C(20), Numes N(6), ;
                Dataes D NULL, Obss M NULL, Nops N(10), SeqDivs N(3), Cpros C(10), CodCors C(4), ;
                CodTams C(4), Citens N(10))
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarItensPorOP - Valida a O.P. digitada e carrega os itens no cursor
    * de trabalho. Equivalente ao PROCEDURE Valid do Get_OP no legado:
    *   - monta EmpDNps = _Empr + DoppPads + Str(Nops,10) (chave POSICIONAL:
    *     as partes NAO sao ALLTRIM'adas, o padding faz parte da chave)
    *   - consulta SigCdNec por EmpDNps: se nao achar ou estiver encerrada
    *     (ChkSubn), preenche mensagem de erro e retorna sem carregar nada
    *   - achando e nao encerrada, busca o produto em SigPdMvf e os itens
    *     da O.P. em SigOpPic, populando cursor_4c_DivOp com QtdDivs = Qtds
    *     (valor inicial igual ao atual) e SeqDivs sequencial (Citens local)
    *
    * Retorno: .T. quando a consulta foi executada sem erro tecnico (mesmo
    * que a O.P. nao exista ou esteja encerrada - nesses casos this_cMensagemErro
    * e this_lOPEncerrada/this_lOPLocalizada indicam o motivo); .F. em erro
    * tecnico (falha de conexao/SQL).
    *==========================================================================
    PROCEDURE BuscarItensPorOP(par_nNops)
        LOCAL loc_lSucesso, loc_cPEdn, loc_nResultado, loc_nCItem, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lOPLocalizada = .F.
        THIS.this_lOPEncerrada  = .F.
        THIS.this_cCodProduto   = ""
        THIS.this_nNops         = 0

        THIS.CriarCursorItens()

        IF VARTYPE(par_nNops) != "N" OR par_nNops = 0
            RETURN .T.
        ENDIF

        TRY
            loc_cPEdn = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(THIS.this_cDoppPads, 20) + STR(par_nNops, 10)

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                "cursor_4c_SigCdNec")

            IF loc_nResultado > 0 AND USED("cursor_4c_SigCdNec") AND !EOF("cursor_4c_SigCdNec")

                IF !cursor_4c_SigCdNec.ChkSubn
                    THIS.this_lOPLocalizada = .T.
                    THIS.this_nNops         = par_nNops

                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                        "cursor_4c_SigPdMvfOp")
                    IF USED("cursor_4c_SigPdMvfOp") AND !EOF("cursor_4c_SigPdMvfOp")
                        THIS.this_cCodProduto = TratarNulo(cursor_4c_SigPdMvfOp.CodPds, "")
                    ENDIF
                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF

                    IF USED("cursor_4c_SigOpPicOp")
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes, Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, Citens " + ;
                        "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0), ;
                        "cursor_4c_SigOpPicOp")

                    loc_nCItem = 1
                    IF USED("cursor_4c_SigOpPicOp")
                        SELECT cursor_4c_SigOpPicOp
                        SCAN
                            INSERT INTO cursor_4c_DivOp ;
                                (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, Citens) ;
                                VALUES ( ;
                                    cursor_4c_SigOpPicOp.Dopes, cursor_4c_SigOpPicOp.Numes, cursor_4c_SigOpPicOp.Qtds, ;
                                    cursor_4c_SigOpPicOp.Qtds, cursor_4c_SigOpPicOp.DataEs, cursor_4c_SigOpPicOp.Obss, ;
                                    par_nNops, loc_nCItem, cursor_4c_SigOpPicOp.Cpros, cursor_4c_SigOpPicOp.CodCors, ;
                                    cursor_4c_SigOpPicOp.CodTams, cursor_4c_SigOpPicOp.Citens)
                            loc_nCItem = loc_nCItem + 1
                        ENDSCAN
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_lOPEncerrada  = .T.
                    THIS.this_cMensagemErro = "O.P. J" + CHR(225) + " Foi Encerrada!!!"
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada!!!"
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpPic
    * (identificada por cIdChaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves = TratarNulo(cIdChaves, "")
        THIS.this_nNops     = TratarNulo(Nops, 0)
        THIS.this_cDopes    = TratarNulo(Dopes, "")
        THIS.this_nNumes    = TratarNulo(Numes, 0)
        THIS.this_nQtds     = TratarNulo(Qtds, 0)
        THIS.this_nSeqDivs  = TratarNulo(SeqDivs, 0)
        THIS.this_dDataEs   = ConverterParaData(DataEs)
        THIS.this_cObs      = TratarNulo(Obss, "")
        THIS.this_cCpros    = TratarNulo(Cpros, "")
        THIS.this_cCodCors  = TratarNulo(CodCors, "")
        THIS.this_cCodTams  = TratarNulo(CodTams, "")
        THIS.this_nCitens   = TratarNulo(Citens, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria.
    * Durante Atualizar(), this_cIdChaves eh reposicionado a cada UPDATE bem
    * sucedido (SigOpPic ou SigPdMvf), de forma que RegistrarAuditoria()
    * sempre registre a linha que acabou de ser gravada.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Atualizar - Confirma a divisao de quantidade (Grupo_Conf.Salva.Click do
    * legado). Passos, na mesma ordem do legado:
    *   1) Recarrega os itens ATUAIS da O.P. (cursor_4c_SigOpPicAtu)
    *   2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local)
    *   3) Para cada linha de cursor_4c_DivOp, localiza o primeiro item com
    *      mesmo Dopes+Numes e SeqDivs=0 e grava Qtds/SeqDivs nele
    *   4) Recalcula o saldo total (Sum Qtds) e grava em SigPdMvf
    *   5) Commit (ou Rollback se qualquer passo falhar) - transacao manual,
    *      equivalente ao ThisForm.poDataMgr.Commit() do legado
    *
    * SET EXACT OFF durante o processamento: os SEEKs usam apenas PARTE da
    * chave composta do indice local (Nops, ou Nops+Citens) - com SET EXACT
    * ON (config.prg) o SEEK exigiria a chave INTEIRA e nunca casaria.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_nOP, loc_cSQL, loc_oErro, loc_cSetExactAnt
        LOCAL loc_nQtdDivs, loc_nSeqDivs, loc_nCitens, loc_cDopes, loc_nNumes
        LOCAL loc_nQtdTotal, loc_cChaveAtual

        loc_lSucesso = .F.
        loc_lOk      = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_nNops = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_DivOp") OR RECCOUNT("cursor_4c_DivOp") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " itens para gravar."
            RETURN .F.
        ENDIF

        loc_nOP = THIS.this_nNops

        TRY
            loc_cSetExactAnt = SET("EXACT")
            SET EXACT OFF

            *-- 1) Recarrega os itens ATUAIS da O.P. direto do banco
            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens FROM SigOpPic " + ;
                "WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), "cursor_4c_SigOpPicAtu")

            IF !USED("cursor_4c_SigOpPicAtu")
                THIS.this_cMensagemErro = "Falha ao consultar os itens da O.P."
                loc_lOk = .F.
            ENDIF

            *-- 2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local),
            *--    reproduzindo o Scan While Nops=lnOp / Replace SeqDivs With 0
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                INDEX ON STR(Nops, 10) + STR(Citens, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops
                SEEK STR(loc_nOP, 10)
                SCAN WHILE loc_lOk AND Nops = loc_nOP
                    loc_cChaveAtual = cIdChaves
                    REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicAtu

                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 1)")
                        loc_lOk = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 3) Distribui a quantidade de cada linha do grid (cursor_4c_DivOp) no
            *--    primeiro item da O.P. com mesmo Dopes+Numes ainda com SeqDivs=0
            IF loc_lOk
                SELECT cursor_4c_DivOp
                SCAN WHILE loc_lOk
                    loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                    loc_nSeqDivs = cursor_4c_DivOp.SeqDivs
                    loc_nCitens  = cursor_4c_DivOp.Citens
                    loc_cDopes   = cursor_4c_DivOp.Dopes
                    loc_nNumes   = cursor_4c_DivOp.Numes
                    loc_cChaveAtual = ""

                    SELECT cursor_4c_SigOpPicAtu
                    SET ORDER TO Nops ASCENDING
                    SEEK STR(loc_nOP, 10) + STR(loc_nCitens, 10)
                    SCAN FOR Nops = loc_nOP AND Citens = loc_nCitens
                        IF (Dopes + STR(Numes, 6) = loc_cDopes + STR(loc_nNumes, 6)) AND SeqDivs = 0
                            REPLACE Qtds WITH loc_nQtdDivs, SeqDivs WITH loc_nSeqDivs IN cursor_4c_SigOpPicAtu
                            loc_cChaveAtual = cIdChaves
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !EMPTY(loc_cChaveAtual)
                        loc_cSQL = "UPDATE SigOpPic SET Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                   ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 2)")
                            loc_lOk = .F.
                        ELSE
                            THIS.this_cIdChaves = loc_cChaveAtual
                            THIS.RegistrarAuditoria("ATUALIZAR")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_DivOp
                ENDSCAN
            ENDIF

            *-- 4) Recalcula o saldo total da O.P. (Sum Qtds To lnQtd do legado)
            *--    e grava em SigPdMvf
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                SUM Qtds TO loc_nQtdTotal

                IF USED("cursor_4c_SigPdMvfAtu")
                    USE IN cursor_4c_SigPdMvfAtu
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT Nops, cIdChaves FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), ;
                    "cursor_4c_SigPdMvfAtu")

                IF USED("cursor_4c_SigPdMvfAtu")
                    SELECT cursor_4c_SigPdMvfAtu
                    INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                    SET ORDER TO Nops DESCENDING
                    IF SEEK(STR(loc_nOP, 10))
                        loc_cSQL = "UPDATE SigPdMvf SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal, 3) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(cursor_4c_SigPdMvfAtu.cIdChaves)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigPdMvf)")
                            loc_lOk = .F.
                        ELSE
                            *-- Auditoria com a tabela correta (SigPdMvf), restaurando
                            *-- this_cTabela = "SigOpPic" logo em seguida
                            THIS.this_cTabela   = "SigPdMvf"
                            THIS.this_cIdChaves = cursor_4c_SigPdMvfAtu.cIdChaves
                            THIS.RegistrarAuditoria("ATUALIZAR")
                            THIS.this_cTabela   = "SigOpPic"
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- 5) Commit ou rollback da transacao manual
            IF loc_lOk
                SQLCOMMIT(gnConnHandle)
                ZAP IN cursor_4c_DivOp
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            IF USED("cursor_4c_SigPdMvfAtu")
                USE IN cursor_4c_SigPdMvfAtu
            ENDIF

            SET EXACT &loc_cSetExactAnt.

        CATCH TO loc_oErro
            IF VARTYPE(loc_cSetExactAnt) = "C" AND !EMPTY(loc_cSetExactAnt)
                SET EXACT &loc_cSetExactAnt.
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_DivOp")
            USE IN cursor_4c_DivOp
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdNec")
            USE IN cursor_4c_SigCdNec
        ENDIF
        IF USED("cursor_4c_SigPdMvfOp")
            USE IN cursor_4c_SigPdMvfOp
        ENDIF
        IF USED("cursor_4c_SigOpPicOp")
            USE IN cursor_4c_SigOpPicOp
        ENDIF
        IF USED("cursor_4c_SigOpPicAtu")
            USE IN cursor_4c_SigOpPicAtu
        ENDIF
        IF USED("cursor_4c_SigPdMvfAtu")
            USE IN cursor_4c_SigPdMvfAtu
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

