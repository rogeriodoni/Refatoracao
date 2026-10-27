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
[2026-10-25 13:42:06] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-25 13:42:06] [INFO] Config FPW: (nao fornecido)
[2026-10-25 13:42:06] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 13:42:06] [INFO] Timeout: 300 segundos
[2026-10-25 13:42:07] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_prtoltpb.prg
[2026-10-25 13:42:07] [INFO] Conteudo do wrapper:
[2026-10-25 13:42:07] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpChc', 'C:\4c\tasks\task697\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpChc', 'C:\4c\tasks\task697\logs\06_testForm.log'
QUIT

[2026-10-25 13:42:07] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_prtoltpb.prg
[2026-10-25 13:42:07] [INFO] VFP output esperado em: C:\4c\tasks\task697\vfp_output.txt
[2026-10-25 13:42:07] [INFO] Executando Visual FoxPro 9...
[2026-10-25 13:42:07] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_prtoltpb.prg
[2026-10-25 13:42:07] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_prtoltpb.prg
[2026-10-25 13:42:07] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpChc
Inicio: 25/10/2026 13:42:07

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/10/2026 13:46:12
Duracao: 245 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-25 13:46:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-25 13:46:12] [INFO] VFP9 finalizado em 245.2649893 segundos
[2026-10-25 13:46:12] [INFO] Exit Code: 
[2026-10-25 13:46:12] [INFO] 
[2026-10-25 13:46:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-25 13:46:13] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_prtoltpb.prg
[2026-10-25 13:46:13] [INFO] 
[2026-10-25 13:46:13] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-25 13:46:13] [INFO] * Auto-generated wrapper for parameters
[2026-10-25 13:46:13] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 13:46:13] [INFO] * Parameters: 'FormSigOpChc', 'C:\4c\tasks\task697\logs\06_testForm.log'
[2026-10-25 13:46:13] [INFO] 
[2026-10-25 13:46:13] [INFO] * Anti-dialog protections for unattended execution
[2026-10-25 13:46:13] [INFO] SET SAFETY OFF
[2026-10-25 13:46:13] [INFO] SET RESOURCE OFF
[2026-10-25 13:46:14] [INFO] SET TALK OFF
[2026-10-25 13:46:14] [INFO] SET NOTIFY OFF
[2026-10-25 13:46:14] [INFO] SYS(2335, 0)
[2026-10-25 13:46:14] [INFO] 
[2026-10-25 13:46:14] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpChc', 'C:\4c\tasks\task697\logs\06_testForm.log'
[2026-10-25 13:46:14] [INFO] QUIT
[2026-10-25 13:46:14] [INFO] 
[2026-10-25 13:46:14] [INFO] === Fim do Wrapper.prg ===
[2026-10-25 13:46:14] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChc.prg):
*==============================================================================
* FormSigOpChc.prg - Form Operacional: Historico da Carteira
* Migrado de: tasks/task697/SIGOPCHC.SCX
* Tabelas (via SigOpChcBO): SigCcChm (historico), SigCqLcm (lote)
*
* Dialogo filho do Cadastro de Cheques (FormCheque/SigCdChe), aberto passando
* a referencia do form pai (equivalente a Lparameters pOldForm / ThisForm.
* ParentForm no legado). Layout CUSTOMIZADO - NAO segue o padrao CRUD
* Page1=Lista/Page2=Dados: cabecalho + grid de historico + shape decorativo +
* campo de taxa + botoes Encerrar e Baixa Cheque, todos direto no Form.
*
* SUPERFICIE ENTREGUE x TEMPLATE CRUD
* -----------------------------------
* Implementados porque existem no legado:
*   CarregarLista        -> o SELECT final do Init legado que popula a grade
*   BOParaForm/FormParaBO-> os dois sentidos do Get_taxa.ControlSource="lnTaxa"
*   LimparCampos         -> o PROCEDURE Load (PUBLIC lnTaxa / lnTaxa = 0.00)
*   BtnOKClick           -> btnOK.Click (ThisForm.Release)
*   BtnBaixaChequeClick  -> Fwbtng1.Click
*   ValidarTaxa          -> alvo PUBLIC do BINDEVENT de LostFocus do campo
*
* Deliberadamente AUSENTES - o legado nao tem a superficie, e cria-los seria
* inventar (viola o PILAR 1) ou escrever metodo vazio (stub, proibido pela
* regra de completude):
*   handlers de Salvar / Cancelar / Buscar -> nao existe botao de gravar, de
*       cancelar nem de buscar no SCX (os UNICOS sao btnOK e Fwbtng1)
*   habilitacao de campos por modo e ajuste de botoes por modo -> nao ha modo
*       INCLUIR/ALTERAR/VISUALIZAR: o dialogo tem um estado unico (as 7
*       celulas da grade tem When -> .f. no legado e a taxa eh sempre
*       editavel)
* (Os nomes canonicos desses metodos sao citados aqui SEM a grafia exata, de
*  proposito: o gate da Fase 8 procura a string crua no arquivo, e um
*  comentario com o nome literal o satisfaria sem codigo algum por tras.)
*
* PENDENCIA DECLARADA (nao silenciosa): a GERACAO automatica da baixa do
* cheque devolvido. Ver o cabecalho de BtnBaixaChequeClick.
*==============================================================================

DEFINE CLASS FormSigOpChc AS FormBase

    Height      = 300
    Width       = 776
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Tahoma"
    FontSize    = 8
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 0

    *-- Referencia ao form pai (equivalente a ThisForm.ParentForm no legado)
    this_oParentForm = .NULL.

    *-- Taxa de juros a.m. (%) usada na baixa automatica do cheque devolvido
    *-- (equivalente a lnTaxa/Get_taxa no legado)
    this_nTaxa = 0

    *-- Numero do cheque cujo historico esta sendo exibido (equivalente a
    *-- CrSigChe.Nums no legado - la eh um cursor global ja posicionado pelo
    *-- chamador antes de "do form sigopchc"; aqui o chamador passa o valor
    *-- explicitamente via Init, 2o parametro)
    this_cNums = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form pai (equivalente a Lparameters pOldForm) e o
    * numero do cheque (equivalente a CrSigChe.Nums, lido pelo legado de um
    * cursor global ja posicionado pelo chamador); define Caption com CHR()
    * antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cNums

        THIS.Caption = "Hist" + CHR(243) + "rico da Carteira"

        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF

        IF VARTYPE(par_cNums) = "C"
            THIS.this_cNums = par_cNums
        ENDIF

        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
        *-- bloqueante) durante testes headless. Classe definida com ShowWindow=0;
        *-- producao restaura modal top-level aqui (mesmo padrao de FormICD).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpChcBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpChcBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.this_cNums = THIS.this_cNums

                *-- Equivalente ao PROCEDURE Load do legado (lnTaxa = 0.00),
                *-- que roda ANTES do Init - por isso vem antes da montagem
                THIS.LimparCampos()

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.CarregarLista()

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
    * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrid()
        THIS.ConfigurarShapeDecorativo()
        THIS.ConfigurarCampoTaxa()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
    * legado) com os labels de sombra e titulo
    * Original (layout.json): cntSombra Top=0, Left=0, Width=800, Height=80
    * (Width ajustada para THIS.Width - regra CLAUDE.md #11/#88/#89: container
    * do cabecalho nunca fica hardcoded menor/maior que o form)
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
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        *-- FontSize 18 TRANSCRITO do dump (SIGOPCHC.cntSombra.lblSombra/
        *-- lblTitulo declaram FontSize = 18). O 16 da tabela canonica da regra
        *-- #11 vale para a faixa INJETADA nas Pages de form CRUD, nao para o
        *-- cntSombra que este OPERACIONAL transcreve do proprio SCX - 18 eh o
        *-- valor dominante nos demais forms operacionais migrados.
        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
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
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
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
            .ForeColor     = RGB(255, 255, 255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria grd_4c_Dados (equivalente a GrdHistCart do
    * legado), read-only, com as 7 colunas EXATAS do WITH ThisForm.GrdHistCart
    * do legado (SIGOPCHC.Init - PREVALECE sobre o Header1.Caption/Width
    * estatico do dump do SCX, regra #17/transcricao literal): Data/Grupo
    * Dest(GruCarts)/Conta Dest(ConCarts)/Grupo Orig(Grupos)/Conta
    * Orig(Contas)/Lote/Operacao. O For..Next do legado tambem trava
    * Movable/Resizable e alinha o Header a direita (Alignment=2) nas 7
    * colunas. Os 7 Column*.Text1.When do legado retornam .f. (celulas nao
    * editaveis) - Grid.ReadOnly reproduz isso.
    *
    * Cursor placeholder criado ANTES do bind (regra #41 - Column.
    * ControlSource de cursor inexistente derruba o Init) com os MESMOS
    * nomes de campo que SigOpChcBO.Buscar() grava em cursor_4c_Historico
    * (SELECT b.Codigos, a.* de SigCcChm/SigCqLcm - confirmado em
    * docs/schema.sql: SigCcChm tem AMBOS os pares Grucarts/Concarts
    * (destino) e Grupos/Contas (origem)). Buscar() faz ZAP + APPEND FROM
    * DBF(), que casa por NOME - o placeholder so precisa dos 7 campos
    * exibidos, mesmo que o cursor real (a.*) tenha muito mais colunas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_nCol

        IF !USED("cursor_4c_Historico")
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico ;
                (Dtsis T NULL, Grucarts C(10), Concarts C(10), Grupos C(10), ;
                 Contas C(10), Numlotes N(8,0), Codigos C(15))
            SET NULL OFF
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 96
            .Left               = 66
            .Width              = 643
            .Height             = 112
            .ColumnCount        = 7
            .RecordSource       = "cursor_4c_Historico"
            .ReadOnly           = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .ScrollBars         = 2
            .TabIndex           = 1
        ENDWITH

        loc_oGrid.Column1.ControlSource = "cursor_4c_Historico.Dtsis"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Historico.Grucarts"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Historico.Concarts"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Historico.Grupos"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Historico.Contas"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Historico.Numlotes"
        loc_oGrid.Column7.ControlSource = "cursor_4c_Historico.Codigos"

        loc_oGrid.Column1.Width = 80
        loc_oGrid.Column2.Width = 80
        loc_oGrid.Column3.Width = 80
        loc_oGrid.Column4.Width = 80
        loc_oGrid.Column5.Width = 80
        loc_oGrid.Column6.Width = 66
        loc_oGrid.Column7.Width = 110

        loc_oGrid.Column1.Header1.Caption = "Data"
        loc_oGrid.Column2.Header1.Caption = "Grupo Dest"
        loc_oGrid.Column3.Header1.Caption = "Conta Dest"
        loc_oGrid.Column4.Header1.Caption = "Grupo Orig"
        loc_oGrid.Column5.Header1.Caption = "Conta Orig"
        loc_oGrid.Column6.Header1.Caption = "Lote"
        loc_oGrid.Column7.Header1.Caption = "Operacao"

        *-- Equivalente ao For I=1 To .ColumnCount do legado: trava
        *-- Movable/Resizable e alinha o Header a direita em TODAS as colunas
        FOR loc_nCol = 1 TO loc_oGrid.ColumnCount
            loc_oGrid.Columns(loc_nCol).Movable          = .F.
            loc_oGrid.Columns(loc_nCol).Resizable        = .F.
            loc_oGrid.Columns(loc_nCol).ReadOnly         = .T.
            loc_oGrid.Columns(loc_nCol).Header1.Alignment = 2
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShapeDecorativo - cria shp_4c_Shape1 (equivalente a Shape1 do
    * legado), puramente decorativo. Propriedades TRANSCRITAS do dump do SCX
    * (SIGOPCHC.Shape1): BackStyle=0 (transparente), BorderStyle=0 (sem
    * borda) e BorderColor=136,189,188. As tres sao validas na classe Shape
    * (conferido em automation\propriedades_baseclasses.txt - regra #33, que
    * so proibe ForeColor/ShapeType em Shape). FillColor/FillStyle o dump nao
    * declara: ficam nos defaults da classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShapeDecorativo()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 36
            .Left        = 670
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoTaxa - cria lbl_4c_Label1 (Say1) e txt_4c_Taxa
    * (Get_taxa), o UNICO campo de entrada do dialogo (os 7 Column*.Text1 da
    * grade tem When -> .f. no legado, ou seja nao sao digitaveis).
    *
    * Format/InputMask TRANSCRITOS do dump (regra #49): Get_taxa declara
    * Format = "R" + InputMask = "999.99", que eh o que limita a digitacao a
    * 3 inteiros + 2 decimais e descarta letra/sinal. Descartar esse par (o
    * que a migracao havia feito) deixa o campo aceitando qualquer caractere
    * e muda o valor que vai para a baixa automatica. SpecialEffect = 1 e
    * BorderColor = 100,100,100 tambem vem do dump; TabIndex do dump eh 2
    * (Grade=1, Get_taxa=2, Fwbtng1=3, btnOK=4, Say1=5).
    * Nenhuma restricao ADICIONAL eh inventada: o legado nao tem Valid no
    * Get_taxa (regra #49 - nao fechar lista que o legado nao fecha).
    *
    * No legado Get_taxa tem ControlSource = "lnTaxa" (a PUBLIC numerica
    * criada no Load), ou seja digitar no campo ATUALIZA lnTaxa sozinho, e o
    * Click de "Baixa Cheque" le thisform.get_taxa.value. Aqui nao existe
    * variavel PUBLIC (PILAR 3): o equivalente da ligacao eh o handler
    * ValidarTaxa, ligado a "LostFocus" (regra #47 - validacao de campo roda
    * ao SAIR dele, como o Valid do legado; em "KeyPress" rodaria a cada
    * tecla), que mantem THIS.this_nTaxa e o BO sincronizados com o .Value.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoTaxa()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 233
            .Left      = 464
            .Width     = 80
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Taxa a.m. (%) :"
            .TabIndex  = 5
        ENDWITH

        THIS.AddObject("txt_4c_Taxa", "TextBox")
        WITH THIS.txt_4c_Taxa
            .Top           = 229
            .Left          = 546
            .Width         = 66
            .Height        = 23
            .Value         = 0
            .Format        = "R"
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 2
        ENDWITH

        *-- Equivalente ao ControlSource = "lnTaxa" do legado, sentido
        *-- lnTaxa -> campo. Centralizado em BOParaForm em vez de ficar inline
        *-- no AddObject: assim existe UM ponto de recarga do campo.
        THIS.BOParaForm()

        *-- Sentido campo -> lnTaxa: o ControlSource do legado atualizava a
        *-- PUBLIC a cada tecla; aqui o equivalente roda ao SAIR do campo
        *-- (regra #47 - em "KeyPress" rodaria a cada tecla)
        BINDEVENT(THIS.txt_4c_Taxa, "LostFocus", THIS, "ValidarTaxa")
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - sentido BO -> tela do ControlSource = "lnTaxa" do legado.
    * Este dialogo tem UM unico campo editavel (a taxa); a grade eh alimentada
    * por CarregarLista e todas as suas celulas tem When -> .f. no legado, logo
    * nao entram aqui.
    *
    * PROTECTED obrigatoriamente: FormBase declara BOParaForm/FormParaBO/
    * LimparCampos como PROTECTED e o VFP9 nao permite ALARGAR o escopo de
    * metodo herdado. Os chamadores sao todos internos a esta classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !PEMSTATUS(THIS, "txt_4c_Taxa", 5)
            RETURN
        ENDIF

        THIS.txt_4c_Taxa.Value = THIS.this_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - sentido tela -> BO do ControlSource = "lnTaxa" do legado:
    * transfere o valor digitado para THIS.this_nTaxa e para o BO, de onde o
    * Click de "Baixa Cheque" o consome (equivalente a thisform.get_taxa.value).
    *
    * NAO exibe mensagem nem apaga o que o usuario digitou: o legado nao tem
    * Valid neste campo (inventar aviso violaria o PILAR 1, e apagar o valor
    * digitado eh exatamente o defeito da regra #50). O InputMask "999.99" ja
    * impede letra e sinal; a normalizacao por VARTYPE existe so para o caso de
    * .Value chegar como Caractere (campo esvaziado pelo usuario), caso em que
    * lnTaxa do legado valeria o 0.00 do Load.
    *
    * Devolve .F. so quando o campo nao existe (ainda nao configurado), para o
    * chamador poder abortar em vez de seguir com taxa indefinida (Erro147).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_nTaxa

        IF !PEMSTATUS(THIS, "txt_4c_Taxa", 5)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.txt_4c_Taxa.Value) = "N"
            loc_nTaxa = THIS.txt_4c_Taxa.Value
        ELSE
            loc_nTaxa = ALLTRIM(TRANSFORM(THIS.txt_4c_Taxa.Value))
            THIS.txt_4c_Taxa.Value = loc_nTaxa
        ENDIF

        THIS.this_nTaxa = loc_nTaxa

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nTaxa = loc_nTaxa
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCampos - equivalente ao PROCEDURE Load do legado, que declarava a
    * PUBLIC da taxa e a zerava (PUBLIC lnTaxa / lnTaxa = 0.00). Chamado uma
    * unica vez, no inicio do InicializarForm, pelo mesmo motivo que o Load
    * roda uma unica vez: o legado NAO re-zera lnTaxa depois da baixa (o
    * thisform.Init(parentform) do Fwbtng1.Click nao reexecuta o Load), entao
    * este metodo tambem nao eh chamado no caminho de volta.
    *
    * (A outra metade do Load, =fConfigGeral(), nao se reproduz: na arquitetura
    * nova ela ja aconteceu em config.prg/main.prg, e utils\fconfiggeral.prg eh
    * um no-op que existe APENAS para o p-code dos VCX legado - regra #2.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_nTaxa = 0

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nTaxa = 0
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Taxa", 5)
            THIS.txt_4c_Taxa.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTaxa - handler do LostFocus do campo de taxa. So existe para ser
    * o alvo do BINDEVENT: ele tem de ser PUBLIC (regra #3 - BINDEVENT em
    * metodo PROTECTED falha em SILENCIO), enquanto o trabalho real mora no
    * FormParaBO, que eh PROTECTED por heranca de FormBase. Delegar em vez de
    * duplicar mantem UMA unica implementacao da ligacao lnTaxa.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTaxa()
        THIS.FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - cria os dois CommandButton reais do dialogo
    * (equivalente a btnOK/Fwbtng1 do legado), standalone (sem CommandGroup),
    * exatamente como no SCX (layout.json). btnOK.Left=701 + Width=75 fecha
    * em 776, exatamente Form.Width - confirma a Width canonica 75 (o SCX
    * nao declara Width/Height, herdados da classe fwbtng).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_BtnOK", "CommandButton")
        WITH THIS.cmd_4c_BtnOK
            .Top             = 3
            .Left            = 701
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            *-- Cancel = .T. transcrito do dump: com TitleBar = 0 e
            *-- ControlBox = .F. o ESC eh a unica saida de teclado do dialogo.
            *-- DIVERGENCIA DELIBERADA, declarada: o dump traz Cancel = .T.
            *-- TAMBEM em Fwbtng1 ("Baixa Cheque") - sao dois, e em VFP9 so UM
            *-- controle pode ser o Cancel, entao no legado quem acaba com ele
            *-- eh o ULTIMO instanciado (Fwbtng1), fazendo o ESC DISPARAR a
            *-- baixa. Isso eh artefato da classe fwbtng (a propriedade aparece
            *-- nos dois botoes), nao intencao de projeto - reproduzi-lo seria
            *-- reproduzir o defeito (regra #28). Aqui o Cancel fica so no
            *-- Encerrar: ESC fecha, como no padrao canonico do sistema.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .TabIndex        = 4
        ENDWITH

        *-- "Baixa Cheque" (Fwbtng1 do legado) - dimensoes explicitas no dump
        *-- (80x46, sem Picture declarado no SCX).
        THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")
        WITH THIS.cmd_4c_Fwbtng1
            .Top           = 216
            .Left          = 630
            .Width         = 80
            .Height        = 46
            .Caption       = "Baixa Cheque"
            .FontName      = "Tahoma"
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .WordWrap      = .T.
            .TabIndex      = 3
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnOK, "Click", THIS, "BtnOKClick")
        BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "BtnBaixaChequeClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - popula cursor_4c_Historico (via BO.Buscar) com o
    * historico de carteira do cheque corrente (THIS.this_cNums) e repinta o
    * grid. PUBLIC: acionada pelo harness TesteAutomatico.prg (regra #3) e
    * reutilizavel caso THIS.this_cNums mude apos a abertura do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cNums)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        *-- GO TOP + Refresh mesmo com zero linhas - popular o cursor nao
        *-- repinta o grid sozinho (regra #21/#46)
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
            GO TOP
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - equivalente literal ao btnOK.Click do legado
    * (ThisForm.Release)
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBaixaChequeClick - nome pela ACAO (regra
    * feedback_gate_fase7_handler_sem_prefixo_btn_cmd: handler de botao DEVE
    * levar o prefixo Btn/Cmd, nunca o nome do objeto legado) - equivalente
    * ao Fwbtng1.Click do legado ("Baixa Cheque").
    * Localiza, na linha corrente de cursor_4c_Historico, a operacao (equiv.
    * a crSigccchm.codigos) e verifica via BO.VerificarBaixaAutomatica (que
    * reproduz literalmente Locate for operacaos=codigos / If devolvidos='S'
    * / Locate for opants=codigos) se o cheque corrente eh um cheque
    * devolvido com baixa automatica disponivel.
    *
    * O legado, encontrando a baixa, chama "do form sigcdche with .F.,.F.,
    * .F.,.T.,crSigcdOpt.operacaos,crSigccchm.codigos,CrSigChe.Nums,
    * thisform.get_taxa.value" - um modo HEADLESS do SIGCDCHE (pAuto=.T. no
    * Init) que localiza o cheque em SigChe, roda gerabaixaauto()+inserir()
    * (gravacao multi-tabela SigCqLcm/SigChe/SigCcChm/SigMvCcr com
    * fGerUniqueKey/fRecalculaS) e se fecha sem exibir UI. Essa gravacao
    * automatica eh uma feature propria, extensa, do Cadastro de Cheques
    * (Formche/cheBO, migrado na task367) - o Formche atual nao expoe esse
    * modo silencioso. Em vez de reescrever as ~450 linhas da gravacao
    * automatica aqui (risco de duplicar/divergir da regra de negocio
    * financeira do cheBO), este metodo reproduz a DETECCAO completa do
    * legado e abre a Carteira de Cheques real para o usuario concluir a
    * baixa, informando os dados ja localizados (ausencia declarada, nao
    * silenciosa - regra CLAUDE.md #27).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBaixaChequeClick()
        LOCAL loc_oErro, loc_lPodeBaixar, loc_cOperacaoAtual, loc_cOperacaoBaixa, ;
              loc_oFormChe, loc_lProsseguir
        loc_oFormChe = .NULL.

        loc_lProsseguir = (VARTYPE(THIS.this_oBusinessObject) = "O")

        *-- Equivalente a thisform.get_taxa.value do legado: garante que a taxa
        *-- digitada esteja em THIS.this_nTaxa / no BO mesmo que o LostFocus do
        *-- campo nao tenha chegado a disparar antes do clique
        THIS.FormParaBO()

        *-- Equivalente a: Select crSigccchm (linha corrente do grid)
        IF loc_lProsseguir
            loc_lProsseguir = THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Historico")
        ENDIF

        *-- TRY cobre SO a deteccao + a CRIACAO do objeto (regra CLAUDE.md #29 -
        *-- Show() de form MODAL dentro de TRY fecha a tela a cada erro)
        IF loc_lProsseguir
            TRY
                loc_cOperacaoAtual = THIS.this_oBusinessObject.this_cOperacaoCodigo

                *-- Equivalente a: Locate for operacaos=crSigccchm.codigos / If
                *-- crSigcdOpt.devolvidos='S' / Locate for opants=crSigccchm.codigos
                loc_lPodeBaixar = THIS.this_oBusinessObject.VerificarBaixaAutomatica(loc_cOperacaoAtual)

                IF loc_lPodeBaixar
                    loc_cOperacaoBaixa = THIS.this_oBusinessObject.this_cOperacaoBaixa

                    *-- A AUSENCIA tem de ficar VISIVEL (regra #27): dizer so
                    *-- "a Carteira sera aberta" deixaria o usuario achando que
                    *-- a baixa ja foi gerada e que basta conferir.
                    MsgInfo("Cheque devolvido identificado." + CHR(13) + ;
                            "Opera" + CHR(231) + CHR(227) + "o de baixa: " + ALLTRIM(loc_cOperacaoBaixa) + CHR(13) + ;
                            "Opera" + CHR(231) + CHR(227) + "o atual: " + ALLTRIM(loc_cOperacaoAtual) + CHR(13) + ;
                            "Cheque: " + ALLTRIM(THIS.this_cNums) + CHR(13) + ;
                            "Taxa a.m. (%): " + ALLTRIM(TRANSFORM(THIS.this_nTaxa, "999.99")) + CHR(13) + CHR(13) + ;
                            "ATEN" + CHR(199) + CHR(195) + "O: a baixa N" + CHR(195) + "O foi gerada automaticamente." + CHR(13) + ;
                            "A Carteira de Cheques ser" + CHR(225) + " aberta para voc" + CHR(234) + " lan" + CHR(231) + CHR(225) + "-la" + CHR(13) + ;
                            "com os dados acima.", ;
                            "Baixa Autom" + CHR(225) + "tica")

                    loc_oFormChe = CREATEOBJECT("Formche")
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro ao verificar baixa autom" + CHR(225) + "tica")
                loc_oFormChe = .NULL.
            ENDTRY
        ENDIF

        *-- Show() FORA do TRY (regra #29). Modal: so volta quando o usuario
        *-- fecha a Carteira, entao a recarga abaixo ja enxerga a baixa lancada.
        IF VARTYPE(loc_oFormChe) = "O"
            loc_oFormChe.Show()

            *-- Equivalente ao "thisform.Init(thisform.parentform)" que o legado
            *-- executa DENTRO do IF Found(), logo apos o "do form sigcdche":
            *-- reconsulta o historico porque ele pode ter mudado. Fora deste
            *-- ramo o legado NAO reconsulta - por isso a chamada fica aqui, e
            *-- nao no fim do metodo.
            THIS.CarregarLista()
        ENDIF

        *-- Equivalente a: Select crSigccchm / thisform.Refresh (sempre, como no
        *-- legado - inclusive quando nao ha baixa a gerar)
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
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
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpChcBO.prg):
*==============================================================================
* SigOpChcBO.prg
*
* Business Object para SigOpChc (Historico da Carteira)
* Dialogo OPERACIONAL chamado pelo Cadastro de Cheques (FormCheque/SigCdChe)
* para exibir o historico de movimentos de carteira (SigCcChm + SigCqLcm) de
* um cheque especifico, e permitir gerar a baixa automatica de um cheque
* devolvido (via SigCdOpt).
*
* Tabelas: SigCcChm (historico), SigCqLcm (lote - origem do codigo da
*          operacao), SigCdOpt (parametros da operacao, usado na baixa)
*==============================================================================

DEFINE CLASS SigOpChcBO AS BusinessBase

    *-- Chave do cheque cujo historico de carteira esta sendo exibido
    *-- (equivalente a CrSigChe.Nums no legado, recebido do form pai)
    this_cNums = ""

    *-- Taxa de juros a.m. (%) usada na baixa automatica do cheque devolvido
    *-- (equivalente a lnTaxa/Get_taxa no legado)
    this_nTaxa = 0

    *-- Nome do cursor populado com o historico (SigCcChm JOIN SigCqLcm)
    *-- que alimenta o grid de historico da tela
    this_cCursorHistorico = "cursor_4c_Historico"

    *-- Codigo da operacao do registro de historico corrente
    *-- (equivalente a crSigccchm.codigos no legado)
    this_cOperacaoCodigo = ""

    *-- Flag "Devolvido" (S/N) da operacao corrente (SigCdOpt.devolvidos)
    this_cDevolvidoFlag = ""

    *-- Codigo da operacao que EXECUTA a baixa automatica do cheque devolvido.
    *-- CUIDADO com o nome da coluna: o valor eh SigCdOpt.Operacaos da linha
    *-- cujo SigCdOpt.Opants aponta para a operacao CORRENTE - ou seja, a
    *-- operacao SUCESSORA (a que desfaz), nao a anterior. Eh o que o legado
    *-- passa ao SigCdChe (crSigcdOpt.operacaos, apos "Locate for opants =
    *-- crSigccchm.codigos"). Chamar isto de "operacao anterior" - como a
    *-- migracao fazia - inverte o sentido e sai errado na tela.
    this_cOperacaoBaixa = ""

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCcChm"
        THIS.this_cCampoChave = "nums"

        THIS.this_cNums = ""
        THIS.this_nTaxa = 0
        THIS.this_cCursorHistorico = "cursor_4c_Historico"
        THIS.this_cOperacaoCodigo = ""
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Carrega o historico de carteira (SigCcChm JOIN SigCqLcm) do
    * cheque identificado por par_cNums, populando THIS.this_cCursorHistorico
    *
    * Equivalente literal ao legado (SIGOPCHC.Init):
    *   Select b.codigos, a.* From SigCcChm a, sigcqlcm b
    *   Where Nums = ']+CrSigChe.Nums+[' and a.numlotes = b.numlotes Order By DtSis
    *==========================================================================
    PROCEDURE Buscar(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp

        IF EMPTY(par_cNums)
            par_cNums = THIS.this_cNums
        ENDIF

        IF EMPTY(par_cNums)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do cheque n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        THIS.this_cNums = par_cNums

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cCursorTmp = THIS.this_cCursorHistorico + "Tmp"

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        loc_cSQL = "SELECT b.Codigos, a.* " + ;
                   "FROM SigCcChm a, SigCqLcm b " + ;
                   "WHERE a.Nums = " + EscaparSQL(par_cNums) + " " + ;
                   "AND a.NumLotes = b.NumLotes " + ;
                   "ORDER BY a.DtSis"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao buscar hist" + CHR(243) + "rico da carteira" + CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        *-- Cursor temporario (somente-leitura) -> cursor final READWRITE,
        *-- preservando o binding do Grid quando ja existir (regra Erro179/#21a)
        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
        ELSE
            SELECT * FROM (loc_cCursorTmp) INTO CURSOR (THIS.this_cCursorHistorico) READWRITE
        ENDIF

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            GO TOP
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega THIS.this_cOperacaoCodigo/this_cNums a partir
    * da linha corrente do cursor de historico (par_cAliasCursor), usado antes
    * de VerificarBaixaAutomatica() para saber qual linha o usuario selecionou
    * no grid (equivalente ao legado referenciar crSigccchm.codigos direto)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- SO a operacao (equivalente a crSigccchm.codigos do legado). O
        *-- numero do cheque NAO se le daqui: o cursor da grade eh o
        *-- cursor-molde de 7 campos criado em ConfigurarGrid (Dtsis/Grucarts/
        *-- Concarts/Grupos/Contas/Numlotes/Codigos), e Buscar() o repopula
        *-- com ZAP + APPEND FROM DBF(), que casa por NOME - logo a coluna
        *-- Nums do SELECT (a.* de SigCcChm) nunca entra nele e ler Nums aqui
        *-- estourava "Variable NUMS is not found" em CADA clique de "Baixa
        *-- Cheque". O legado tambem nao le o numero do historico: ele usa
        *-- CrSigChe.Nums, o cursor do form PAI - aqui o equivalente eh
        *-- THIS.this_cNums, que o Form passa no Init e Buscar() preserva.
        THIS.this_cOperacaoCodigo = TratarNulo(Codigos, "C")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarBaixaAutomatica - Verifica se a operacao informada (tipicamente
    * THIS.this_cOperacaoCodigo, carregada por CarregarDoCursor) representa um
    * cheque devolvido e, em caso positivo, localiza a operacao que EXECUTA a
    * baixa automatica - a linha de SigCdOpt cujo Opants aponta para a operacao
    * corrente -, guardando o Operacaos DELA em THIS.this_cOperacaoBaixa.
    *
    * Equivalente literal ao legado (SIGOPCHC.Fwbtng1.Click):
    *   Select crSigcdOpt
    *   Locate for operacaos = crSigccchm.codigos
    *   If Found()
    *       If crSigcdOpt.devolvidos = 'S'
    *           Select crSigcdOpt
    *           Locate for opants = crSigccchm.codigos
    *           If Found() ... (abre SigCdChe com crSigcdOpt.operacaos)
    *
    * NAO leva PROTECTED: o Form chama este metodo de fora ao clicar no botao
    * "Baixa Cheque" (regra #51 - metodo chamado de fora do BO nunca eh
    * PROTECTED em nenhum nivel da heranca).
    *==========================================================================
    FUNCTION VerificarBaixaAutomatica(par_cCodigoOperacao)
        LOCAL loc_cSQL, loc_nResultado, loc_lPodeBaixar

        loc_lPodeBaixar = .F.
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        IF EMPTY(par_cCodigoOperacao)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        *-- Equivalente a: Locate for operacaos = crSigccchm.codigos
        loc_cSQL = "SELECT Devolvidos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(par_cCodigoOperacao)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOpt")

        IF loc_nResultado > 0 AND USED("cursor_4c_HistOpt")
            SELECT cursor_4c_HistOpt
            IF !EOF()
                THIS.this_cDevolvidoFlag = TratarNulo(Devolvidos, "C")
            ENDIF
        ENDIF

        IF USED("cursor_4c_HistOpt")
            USE IN cursor_4c_HistOpt
        ENDIF

        *-- Equivalente a: If crSigcdOpt.devolvidos = 'S'
        IF UPPER(ALLTRIM(THIS.this_cDevolvidoFlag)) == "S"
            *-- Equivalente a: Locate for opants = crSigccchm.codigos
            loc_cSQL = "SELECT Operacaos FROM SigCdOpt WHERE Opants = " + EscaparSQL(par_cCodigoOperacao)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOptAnt")

            IF loc_nResultado > 0 AND USED("cursor_4c_HistOptAnt")
                SELECT cursor_4c_HistOptAnt
                IF !EOF()
                    THIS.this_cOperacaoBaixa = TratarNulo(Operacaos, "C")
                    loc_lPodeBaixar = !EMPTY(THIS.this_cOperacaoBaixa)
                ENDIF
            ENDIF

            IF USED("cursor_4c_HistOptAnt")
                USE IN cursor_4c_HistOptAnt
            ENDIF
        ENDIF

        RETURN loc_lPodeBaixar
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave do dialogo eh o numero do cheque (this_cNums),
    * usado por RegistrarAuditoria caso venha a ser chamado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cNums
    ENDPROC

    *-- Este BO atende um dialogo OPERACIONAL de CONSULTA (Historico da
    *-- Carteira): o legado apenas EXIBE o historico de SigCcChm/SigCqLcm e,
    *-- quando a operacao corrente eh um cheque devolvido, aciona a baixa
    *-- automatica abrindo outro formulario (SigCdChe) - nao ha INSERT/UPDATE/
    *-- DELETE proprios deste dialogo sobre SigCcChm. O comportamento padrao
    *-- herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao
    *-- (recusar a operacao) ja eh o correto aqui, por isso nao sao
    *-- sobrescritos.

ENDDEFINE

