# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-07 09:57:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 09:57:45] [INFO] Config FPW: (nao fornecido)
[2026-10-07 09:57:46] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 09:57:46] [INFO] Timeout: 300 segundos
[2026-10-07 09:57:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_f4dmpfic.prg
[2026-10-07 09:57:46] [INFO] Conteudo do wrapper:
[2026-10-07 09:57:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRIBL', 'C:\4c\tasks\task623\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIBL', 'C:\4c\tasks\task623\logs\06_testForm.log'
QUIT

[2026-10-07 09:57:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_f4dmpfic.prg
[2026-10-07 09:57:46] [INFO] VFP output esperado em: C:\4c\tasks\task623\vfp_output.txt
[2026-10-07 09:57:46] [INFO] Executando Visual FoxPro 9...
[2026-10-07 09:57:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_f4dmpfic.prg
[2026-10-07 09:57:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_f4dmpfic.prg
[2026-10-07 09:57:46] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRIBL
Inicio: 07/10/2026 09:57:46

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 10:01:30
Duracao: 224 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 10:01:31] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 10:01:31] [INFO] VFP9 finalizado em 224.830877 segundos
[2026-10-07 10:01:31] [INFO] Exit Code: 
[2026-10-07 10:01:31] [INFO] 
[2026-10-07 10:01:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 10:01:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_f4dmpfic.prg
[2026-10-07 10:01:31] [INFO] 
[2026-10-07 10:01:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 10:01:31] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 10:01:31] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 10:01:31] [INFO] * Parameters: 'FormSIGPRIBL', 'C:\4c\tasks\task623\logs\06_testForm.log'
[2026-10-07 10:01:31] [INFO] 
[2026-10-07 10:01:31] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 10:01:31] [INFO] SET SAFETY OFF
[2026-10-07 10:01:31] [INFO] SET RESOURCE OFF
[2026-10-07 10:01:31] [INFO] SET TALK OFF
[2026-10-07 10:01:31] [INFO] SET NOTIFY OFF
[2026-10-07 10:01:31] [INFO] SYS(2335, 0)
[2026-10-07 10:01:31] [INFO] 
[2026-10-07 10:01:31] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIBL', 'C:\4c\tasks\task623\logs\06_testForm.log'
[2026-10-07 10:01:31] [INFO] QUIT
[2026-10-07 10:01:31] [INFO] 
[2026-10-07 10:01:31] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 10:01:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg):
*==============================================================================
* FormSIGPRIBL.prg - Impressao de Boleto Bancario
* Origem: SIGPRIBL.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (form flat - sem PageFrame, sem grid no legado;
*       unico container e a faixa de cabecalho cntSombra)
*==============================================================================

DEFINE CLASS FormSIGPRIBL AS FormBase

    Width       = 1000
    Height      = 400
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ShowTips    = .T.
    WindowType  = 1
    Caption     = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"

    *-- lcChave1 do legado: chave do movimento (Emps+Dopes+Numes) para o qual
    *-- o boleto esta sendo impresso. Vazio = usa TprMvCab ja populado pelo
    *-- form chamador antes de abrir este form.
    this_cChave1 = ""

    *-- pcNform1 do legado: controle do form chamador, reabilitado ao encerrar
    *-- (nao eh o form pai inteiro - no legado eh so o controle referenciado)
    this_oControleChamador = .NULL.

    *-- fpags (char(12)) atualmente carregado em txt_4c_FPags/this_oBusinessObject
    this_cFPagsSel = ""

    *-- Guarda de reentrancia do picker de lookup: Show() de form MODAL bloqueia
    *-- e o foco sai/volta do campo, podendo re-disparar o handler e empilhar um
    *-- segundo picker por cima do primeiro.
    this_lLookupAberto = .F.

    *==========================================================================
    * Init - recebe chave do movimento e controle do form chamador
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cChave1, par_oControleChamador

        LOCAL loc_oErro
        TRY
            THIS.this_cChave1 = IIF(TYPE("par_cChave1") = "C", par_cChave1, "")
            IF VARTYPE(par_oControleChamador) = "O"
                THIS.this_oControleChamador = par_oControleChamador
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria o Business Object, a faixa de cabecalho (unico
    * container do legado) e os campos/CommandGroup do form (ConfigurarPagina-
    * Lista). Form OPERACIONAL flat: sem PageFrame e sem grid, tudo direto em
    * THIS.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIBLBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()

                *-- Ordem de tabulacao transcrita do TabIndex do SCX. Tem de
                *-- rodar DEPOIS de todos os AddObject de ConfigurarPaginaLista
                *-- /ConfigurarPageFrame, senao a atribuicao cai em controle que
                *-- ainda nao existe.
                THIS.ConfigurarPaginaDados()

                *-- Cursor auxiliar de movimentos a imprimir (regra: mesma
                *-- estrutura/ordem de campos em TODO CREATE CURSOR TprMvCab)
                IF !USED("TprMvCab")
                    CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
                ENDIF

                THIS.AtualizaBoleto("")

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SIGPRIBLBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Cabecalho equivalente ao cntSombra original
    * Original: Top=0, Left=0, Width=1020, Height=80, BackColor=100,100,100
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis os controles do container,
    * recursivo (Pages de PageFrame e Controls de Container)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Ponto de entrada canonico do funil multi-fase.
    * Form OPERACIONAL flat (sem PageFrame/Page1/Page2 no legado): delega para
    * ConfigurarPageFrame(), que cria os campos e o CommandGroup diretamente em
    * THIS. Guard por PEMSTATUS evita duplicar objetos em caso de reentrada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF !PEMSTATUS(THIS, "txt_4c_FPags", 5)
            THIS.ConfigurarPageFrame()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL FLAT: o legado SIGPRIBL.SCX nao
    * tem PageFrame nem Page2 (11 objetos ao todo, todos filhos DIRETOS do
    * form), entao os campos de dados - txt_4c_FPags / txt_4c_Locals /
    * obj_4c_GetTxtCds e seus labels - sao criados em ConfigurarPageFrame().
    *
    * O que sobra para este metodo eh a ORDEM DE TABULACAO: o SCX declara
    * TabIndex nos 8 controles e o migrador descartou. Com AddObject o VFP9
    * numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a ordem
    * do legado - nao da erro, nao entra em log e nao aparece em screenshot,
    * so o Tab andando na ordem errada.
    *
    * TabIndex eh gravavel em runtime, e as atribuicoes tem de ser feitas em
    * ordem ASCENDENTE e DEPOIS de todos os AddObject: cada atribuicao poe o
    * controle na posicao pedida e empurra os demais para tras.
    *
    * TabIndex transcrito do dump (SECAO 2 de SIGPRIBL_form_codigo_fonte.txt):
    *   Label2 = 1 | getFPags = 2 | Label3 = 3 | getLocals = 4
    *   Label31 = 5 | getTxtCds = 6 | lblAviso = 7 | cmdGImprimir = 8
    * Sem empate entre os focalizaveis - o SCX deste form nao repete TabIndex.
    *==========================================================================
    PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            THIS.lbl_4c_Label2.TabIndex       = 1
            THIS.txt_4c_FPags.TabIndex        = 2
            THIS.lbl_4c_Label3.TabIndex       = 3
            THIS.txt_4c_Locals.TabIndex       = 4
            THIS.lbl_4c_Label31.TabIndex      = 5
            THIS.obj_4c_GetTxtCds.TabIndex    = 6
            THIS.lbl_4c_LblAviso.TabIndex     = 7
            THIS.obj_4c_CmdGImprimir.TabIndex = 8

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Ponto de entrada canonico do funil multi-fase.
    * Form OPERACIONAL flat: nao ha paginas para alternar - recarrega a
    * configuracao do boleto atualmente selecionado.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.AtualizaBoleto(THIS.this_cFPagsSel)
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria campos (Label2/getFPags/Label3/getLocals/
    * Label31/getTxtCds/lblAviso) e o CommandGroup cmdGImprimir (Imprimir +
    * Encerrar), direto em THIS (form flat, sem PageFrame no legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .BorderStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
                .Height    = 15
                .Left      = 82
                .Top       = 93
                .Width     = 124
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_FPags", "TextBox")
            WITH THIS.txt_4c_FPags
                .FontName  = "Tahoma"
                .Left      = 84
                .MaxLength = 12
                .Top       = 110
                .Width     = 94
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .Visible   = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_FPags, "KeyPress", THIS, "TxtFPagsKeyPress")
            BINDEVENT(THIS.txt_4c_FPags, "DblClick", THIS, "TxtFPagsDblClick")

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .BorderStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Local de Pagamento "
                .Height    = 15
                .Left      = 82
                .Top       = 151
                .Width     = 104
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Locals", "TextBox")
            WITH THIS.txt_4c_Locals
                .FontName  = "Tahoma"
                .Format    = "K"
                .Left      = 84
                .MaxLength = 100
                .Top       = 168
                .Width     = 798
                .Height    = 69
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label31", "Label")
            WITH THIS.lbl_4c_Label31
                .AutoSize  = .F.
                .BorderStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Texto de Responsabilidade do Cedente "
                .Height    = 15
                .Left      = 82
                .Top       = 251
                .Width     = 196
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
            WITH THIS.obj_4c_GetTxtCds
                .FontName  = "Tahoma"
                .Left      = 84
                .Top       = 268
                .Width     = 798
                .Height    = 69
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblAviso", "Label")
            WITH THIS.lbl_4c_LblAviso
                .AutoSize  = .F.
                .BorderStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Existe Configura" + CHR(231) + CHR(227) + "o de Boleto"
                .Left      = 89
                .Top       = 351
                .Width     = 213
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_CmdGImprimir", "CommandGroup")
            WITH THIS.obj_4c_CmdGImprimir
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderColor   = RGB(136, 189, 188)
                .Value         = 1
                .Height        = 88
                .Left          = 835
                .SpecialEffect = 1
                .Top           = -2
                .Width         = 173
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 11
                    .Height      = 75
                    .Width       = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Caption     = "\<Imprimir"
                    .ToolTipText = "Imprimir"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                    .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .Enabled     = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top         = 5
                    .Left        = 87
                    .Height      = 75
                    .Width       = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Caption     = "Encerrar"
                    .ToolTipText = "[ESC] Sair"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                    .Cancel      = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(1), "Click", THIS, "CmdImprimirClick")
            BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(2), "Click", THIS, "CmdSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizaBoleto - Recarrega a configuracao de SigCnFBl pela condicao de
    * pagamento informada e habilita/desabilita os campos e o botao Imprimir
    * conforme exista ou nao configuracao cadastrada (AtualizaBoleto do
    * legado). Retorna .T. se encontrou configuracao para par_cCond.
    *==========================================================================
    PROCEDURE AtualizaBoleto(par_cCond)
        LOCAL loc_cFPags, loc_lAchou, loc_oErro
        loc_lAchou = .F.
        TRY
            loc_cFPags = PADR(NVL(par_cCond, ""), 12)
            THIS.this_cFPagsSel = ALLTRIM(loc_cFPags)

            IF !EMPTY(THIS.this_cFPagsSel)
                loc_lAchou = THIS.this_oBusinessObject.CarregarPorFPags(loc_cFPags)
            ENDIF

            IF loc_lAchou
                THIS.this_oBusinessObject.EditarRegistro()

                THIS.txt_4c_Locals.Enabled = .T.
                THIS.txt_4c_Locals.Value   = NVL(THIS.this_oBusinessObject.this_cLocals, "")
                THIS.txt_4c_Locals.Refresh()

                THIS.obj_4c_GetTxtCds.Enabled = .T.
                THIS.obj_4c_GetTxtCds.Value   = NVL(THIS.this_oBusinessObject.this_cTxtCds, "")
                THIS.obj_4c_GetTxtCds.Refresh()

                THIS.lbl_4c_LblAviso.Visible = .F.

                THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .T.
                THIS.obj_4c_CmdGImprimir.Refresh()
            ELSE
                THIS.txt_4c_Locals.Value   = ""
                THIS.txt_4c_Locals.Enabled = .F.
                THIS.txt_4c_Locals.Refresh()

                THIS.obj_4c_GetTxtCds.Value   = ""
                THIS.obj_4c_GetTxtCds.Enabled = .F.
                THIS.obj_4c_GetTxtCds.Refresh()

                THIS.lbl_4c_LblAviso.Visible = .T.

                THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
                THIS.obj_4c_CmdGImprimir.Value = 2
                THIS.obj_4c_CmdGImprimir.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em AtualizaBoleto")
        ENDTRY

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * TxtFPagsKeyPress - Handler do campo Condicao de Pagamento (getFPags do
    * legado). Enter/Tab/F4: busca exata por fpags; achando, recarrega o
    * boleto; nao achando, abre o picker (fwBuscaExt do legado).
    *
    * BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, por isso
    * o Valid do legado vive aqui (Enter/Tab = sair do campo) mais o F4, e no
    * TxtFPagsDblClick. O When do legado eh so um NoDefault, que nao nega foco
    * nem altera comportamento - nada a transcrever.
    *
    * ORDEM invertida em relacao ao legado, DE PROPOSITO: o legado chama o
    * picker primeiro (cujo Init resolve o match exato) e so depois
    * AtualizaBoleto; aqui AtualizaBoleto roda primeiro e o picker so abre se
    * ela nao achou. O resultado visto pelo usuario eh o mesmo - codigo valido
    * carrega sem abrir dialogo nenhum (regra #37: Show() SO se nao resolveu),
    * prefixo invalido abre o picker filtrado por LIKE - e evita uma segunda
    * consulta. Nao "consertar" reordenando.
    *==========================================================================
    PROCEDURE TxtFPagsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_cVal, loc_lAchou, loc_lProcessar, loc_oErro
        loc_lProcessar = .T.
        loc_lAchou     = .T.

        IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_FPags.Value, "")))
            THIS.AtualizaBoleto("")
            loc_lProcessar = .F.
        ENDIF

        IF loc_lProcessar
            TRY
                loc_cVal  = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
                loc_lAchou = THIS.AtualizaBoleto(loc_cVal)
                IF loc_lAchou
                    THIS.txt_4c_FPags.Value = THIS.this_cFPagsSel
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao validar Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                loc_lAchou = .T.
            ENDTRY

            IF !loc_lAchou
                THIS.AbrirLookupFPags()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtFPagsDblClick - getFPags do legado. Duplo clique abre o mesmo picker
    * do F4/Enter/Tab (padrao canonico de lookup do projeto).
    *==========================================================================
    PROCEDURE TxtFPagsDblClick()
        IF THIS.txt_4c_FPags.Enabled
            THIS.AbrirLookupFPags()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupFPags - Picker de condicoes de pagamento (SigCnFBl).
    *
    * Legado (getFPags.Valid):
    *   loLista = CreateObject('fwBuscaExt', ...pnIdConn, 'SigCnFBl',
    *                          'crListaRemota', 'FPags', This.Value, 'Selecao', .t.)
    *   If Not loLista.plAchouRegistro
    *       loLista.mAddColuna('FPags', '', 'Condicao')
    *       loLista.Show()
    *   EndIf
    *   This.Value = Iif(Lastkey()=27, '', crListaRemota.FPags)
    *   Use In crListaRemota
    *   ThisForm.AtualizaBoleto(This.Value)
    *
    * Contrato FormBuscaAuxiliar (regras #36/#37 do CLAUDE.md):
    *   - 1o argumento eh o HANDLE da conexao (gnConnHandle), NUNCA a tabela
    *   - Show() SO quando this_lAchouRegistro = .F. (o Init ja resolve o match
    *     exato de 1 registro, exatamente como o plAchouRegistro do fwBuscaExt)
    *   - leitura do cursor SO sob a guarda this_lSelecionou, e ANTES do
    *     Release() do picker
    *
    * O 7o argumento .t. que o legado passa ao fwBuscaExt NAO foi transcrito:
    * em FormBuscaAuxiliar essa posicao eh par_lBuscaExata, parametro de outra
    * semantica (hoje inerte, mas se vier a valer "so match exato" o picker
    * abriria vazio para prefixo digitado - o defeito do Erro114). Falso
    * cognato: mesma posicao, contrato diferente.
    *
    * UMA unica coluna, transcrita do dump: o legado NAO exibe clocals no
    * picker (char(100) nao cabe na janela de 374px) - nao acrescentar coluna
    * que ele nao tem (PILAR 1).
    *
    * Cancelar (ESC / Cancela / X) LIMPA o campo e zera a configuracao exibida,
    * transcrevendo o Iif(Lastkey()=27, '', ...) do legado. Isto NAO eh a
    * atribuicao-fora-da-guarda que a regra #37 proibe: ali zerar eh efeito
    * colateral acidental, aqui eh o comportamento DELIBERADO do legado - a
    * condicao de pagamento invalida nao pode ficar no campo com a tela
    * mostrando os dados da anterior.
    *==========================================================================
    PROCEDURE AbrirLookupFPags()
        LOCAL loc_cVal, loc_oLookup, loc_lSelecionou, loc_cEscolhido, loc_oErro

        *-- Guarda de reentrancia ANTES do TRY (regra #1: nenhum RETURN dentro
        *-- de TRY/CATCH)
        IF THIS.this_lLookupAberto
            RETURN
        ENDIF
        THIS.this_lLookupAberto = .T.

        loc_lSelecionou = .F.
        loc_cEscolhido  = ""

        TRY
            loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))

            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCnFBl", "cursor_4c_BuscaFPags", "fpags", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oLookup) = "O"
                IF !loc_oLookup.this_lAchouRegistro
                    loc_oLookup.mAddColuna("fpags", "", "Condi" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                ENDIF

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
                    SELECT cursor_4c_BuscaFPags
                    IF !EOF("cursor_4c_BuscaFPags")
                        loc_cEscolhido  = ALLTRIM(NVL(cursor_4c_BuscaFPags.fpags, ""))
                        loc_lSelecionou = .T.
                    ENDIF
                ENDIF

                loc_oLookup.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF

            *-- Legado: valor vem do cursor quando escolheu, VAZIO no cancelamento
            THIS.txt_4c_FPags.Value = IIF(loc_lSelecionou, loc_cEscolhido, "")
            THIS.txt_4c_FPags.Refresh()

            *-- Legado: AtualizaBoleto roda em AMBOS os caminhos (recarrega a
            *-- configuracao escolhida, ou apaga os campos quando cancelou)
            THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir busca de Condi" + CHR(231) + CHR(227) + "o")
        ENDTRY

        *-- Libera a guarda tambem quando o CATCH disparou
        THIS.this_lLookupAberto = .F.
    ENDPROC
    *==========================================================================
    * CmdImprimirClick - cmdImprimir.Click do legado: confirma, grava Local de
    * Pagamento/Texto do Cedente editados, confere impressora, e para cada
    * movimento em TprMvCab monta o boleto (SigMvCab/SigMvPar/SigCdOpe/
    * SigOpCdc/SigMvNfi/SigCdCli/SigOpFp) e chama a rotina de impressao
    * matricial SigPrIbl.
    *==========================================================================
    PROCEDURE CmdImprimirClick()
        LOCAL loc_lProsseguir, loc_lTemImpressora, loc_i, loc_cChave1, loc_nParcel, loc_lTaOk
        LOCAL loc_cSQL, loc_nRet, loc_cFonteP, loc_cFonteG, loc_nTamFolha
        LOCAL loc_cContaCli, loc_xVenc, loc_cNumDoc, loc_nNfiscals, loc_lBoletoHabilitado
        LOCAL loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob, loc_oErro
        LOCAL ARRAY loc_aPrinters[1]

        IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s) Banc" + CHR(225) + "rio(s)?")
            *-- Legado: ThisForm.getLocals.SetFocus. SetFocus em controle com
            *-- Enabled = .F. estoura em VFP9; no legado isso nunca acontecia
            *-- porque cmdImprimir fica desabilitado junto com getLocals quando
            *-- nao ha configuracao de boleto, tornando este caminho inalcancavel.
            IF THIS.txt_4c_Locals.Enabled
                THIS.txt_4c_Locals.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF EMPTY(THIS.this_cFPagsSel) OR !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
            MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
                CHR(225) + "lida antes de imprimir.", "Aviso")
            RETURN
        ENDIF

        loc_lProsseguir = .T.
        THIS.LockScreen = .T.
        TRY
            *-- Grava Local de Pagamento/Texto do Cedente editados de volta em SigCnFBl
            THIS.this_oBusinessObject.this_cLocals = THIS.txt_4c_Locals.Value
            THIS.this_oBusinessObject.this_cTxtCds = THIS.obj_4c_GetTxtCds.Value

            IF !THIS.this_oBusinessObject.Salvar()
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                ENDIF
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_lTemImpressora = .F.
                IF APRINTERS(loc_aPrinters) > 0
                    FOR loc_i = 1 TO ALEN(loc_aPrinters, 1)
                        IF UPPER(ALLTRIM(loc_aPrinters[loc_i, 1])) == ;
                           UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cNomeImps))
                            loc_lTemImpressora = .T.
                            EXIT
                        ENDIF
                    ENDFOR
                ENDIF
                IF !loc_lTemImpressora
                    MsgAviso("Nenhuma Impressora de Boleto Configurada ou Instalada.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Carrega movimento recebido na abertura do form (se houver)
                IF !EMPTY(THIS.this_cChave1)
                    IF !USED("TprMvCab")
                        CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
                    ENDIF
                    SELECT TprMvCab
                    ZAP
                    INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
                        (SUBSTR(THIS.this_cChave1, 1, 3), ;
                         SUBSTR(THIS.this_cChave1, 4, 20), ;
                         INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
                ENDIF

                IF USED("Crdados")
                    USE IN Crdados
                ENDIF
                SET NULL ON
                CREATE CURSOR Crdados ( ;
                    clocal  C(100), ;
                    vencs   C(12), ;
                    datdoc  D, ;
                    numdoc  C(8), ;
                    valor   N(14,2), ;
                    razaos  C(50), ;
                    cpfs    C(20), ;
                    endcobs C(80), ;
                    baicobs C(20), ;
                    cidcobs C(20), ;
                    estcobs C(2), ;
                    cepcobs C(9), ;
                    texto   M ;
                )
                SET NULL OFF

                *-- Fontes de impressao conforme configuracao do boleto
                IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFontePdrs, "")))
                    loc_cFonteP = ""
                    loc_cFonteG = ""
                ELSE
                    IF NVL(THIS.this_oBusinessObject.this_nTamFontes, 0) = 0
                        loc_cFonteP = "Font '" + ALLTRIM(THIS.this_oBusinessObject.this_cFontePdrs) + "',9"
                        loc_cFonteG = "Font '" + ALLTRIM(THIS.this_oBusinessObject.this_cFontePdrs) + "',11"
                    ELSE
                        loc_cFonteP = "Font '" + ALLTRIM(THIS.this_oBusinessObject.this_cFontePdrs) + "'," + ;
                                      ALLTRIM(STR(THIS.this_oBusinessObject.this_nTamFontes, 3))
                        loc_cFonteG = "Font '" + ALLTRIM(THIS.this_oBusinessObject.this_cFontePdrs) + "'," + ;
                                      ALLTRIM(STR(THIS.this_oBusinessObject.this_nTamFontes + 2, 3))
                    ENDIF
                ENDIF
                loc_nTamFolha = VAL(ALLTRIM(SUBSTR(THIS.this_oBusinessObject.this_cTamFolha, ;
                                    AT("/", THIS.this_oBusinessObject.this_cTamFolha, 1) + 1, ;
                                    AT("/", THIS.this_oBusinessObject.this_cTamFolha, 2) - ;
                                    AT("/", THIS.this_oBusinessObject.this_cTamFolha, 1) - 1)))

                *-- Itera os movimentos a imprimir
                SELECT TprMvCab
                GO TOP
                SCAN
                    loc_cChave1 = TprMvCab.Emps + TprMvCab.Dopes + STR(TprMvCab.Numes, 6)
                    loc_nParcel = NVL(TprMvCab.Parcs, 0)
                    IF VARTYPE(loc_nParcel) != "N"
                        loc_nParcel = 0
                    ENDIF

                    loc_cSQL = "SELECT TOP 1 emps, dopes, numes, contaos, contads" + ;
                               " FROM SigMvCab WHERE empdopnums = " + EscaparSQL(loc_cChave1)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                    IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
                        MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                            "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                        LOOP
                    ENDIF

                    loc_cSQL = "SELECT emps, dopes, numes, parcs, fpags, vencs, datas, valos" + ;
                               " FROM SigMvPar WHERE empdopnums = " + EscaparSQL(loc_cChave1) + ;
                               " ORDER BY parcs"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
                    IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
                        MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_MvPar")
                            USE IN cursor_4c_MvPar
                        ENDIF
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                        LOOP
                    ENDIF

                    *-- Operacao habilitada para impressao de boleto (SigCdOpe+SigOpCdc)
                    loc_lBoletoHabilitado = .F.
                    loc_nNfiscals = 0
                    loc_cSQL = "SELECT TOP 1 dopes, nfiscals FROM SigCdOpe WHERE dopes = " + ;
                               EscaparSQL(cursor_4c_MvPar.Dopes)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                    IF loc_nRet > 0 AND USED("cursor_4c_Ope") AND RECCOUNT("cursor_4c_Ope") > 0
                        loc_nNfiscals = NVL(cursor_4c_Ope.Nfiscals, 0)
                        loc_cSQL = "SELECT TOP 1 dopes, impbols FROM SigOpCdc WHERE dopes = " + ;
                                   EscaparSQL(cursor_4c_MvPar.Dopes)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
                        IF loc_nRet > 0 AND USED("cursor_4c_OpCdc") AND RECCOUNT("cursor_4c_OpCdc") > 0 ;
                           AND NVL(cursor_4c_OpCdc.ImpBols, 0) = 1
                            loc_lBoletoHabilitado = .T.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_OpCdc")
                        USE IN cursor_4c_OpCdc
                    ENDIF
                    IF USED("cursor_4c_Ope")
                        USE IN cursor_4c_Ope
                    ENDIF

                    IF !loc_lBoletoHabilitado
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o sem Impress" + CHR(227) + ;
                            "o de Boleto Banc" + CHR(225) + "rio Habilitado.", "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_MvPar")
                            USE IN cursor_4c_MvPar
                        ENDIF
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                        LOOP
                    ENDIF

                    loc_cSQL = "SELECT TOP 1 NFis FROM SigMvNfi WHERE empdopnums = " + EscaparSQL(loc_cChave1)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
                    IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
                        MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                            "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_MvNfi")
                            USE IN cursor_4c_MvNfi
                        ENDIF
                        IF USED("cursor_4c_MvPar")
                            USE IN cursor_4c_MvPar
                        ENDIF
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                        LOOP
                    ENDIF

                    *-- Cursor/indice do template de posicoes de impressao
                    IF USED("TmpImprime")
                        USE IN TmpImprime
                    ENDIF
                    CREATE CURSOR TmpImprime ( ;
                        Linha    N(6,2), ;
                        Coluna   N(6,2), ;
                        Conteudo C(100), ;
                        Style    C(3), ;
                        fontname C(64), ;
                        fontsize I, ;
                        linesize N(6,2), ;
                        nheight  N(6,2) ;
                    )
                    INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem

                    SELECT cursor_4c_MvCab
                    loc_cContaCli = IIF(loc_nNfiscals = 1, cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)

                    loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs, Endes, EndCobs, Bairs, BaiCobs," + ;
                               " Cidas, CidCobs, Estas, EstCobs, Ceps, CepCobs" + ;
                               " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                    SELECT Crdados
                    ZAP

                    SELECT cursor_4c_MvPar
                    GO TOP
                    SCAN
                        loc_lTaOk = .T.
                        IF loc_nParcel > 0 AND cursor_4c_MvPar.Parcs != loc_nParcel
                            loc_lTaOk = .F.
                        ENDIF

                        IF loc_lTaOk
                            loc_cSQL = "SELECT TOP 1 Fpags, ImpBols, ImpNotas FROM SigOpFp WHERE Fpags = " + ;
                                       EscaparSQL(cursor_4c_MvPar.Fpags)
                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")

                            IF loc_nRet > 0 AND USED("cursor_4c_OpFp") AND RECCOUNT("cursor_4c_OpFp") > 0 ;
                               AND NVL(cursor_4c_OpFp.ImpBols, 0) = 1

                                IF USED("TmpImprime")
                                    SELECT TmpImprime
                                    ZAP
                                ENDIF

                                IF NVL(cursor_4c_OpFp.ImpNotas, 0) = 1
                                    loc_xVenc = DTOC(cursor_4c_MvPar.Vencs)
                                ELSE
                                    loc_xVenc = ALLTRIM(NVL(cursor_4c_MvPar.FPags, ""))
                                ENDIF

                                *-- Legado: CrtmpNfis.NFis + '-' + Str(Crtmppar.parcs,1) - SEM
                                *-- AllTrim. SigMvNfi.nfis eh char(6), mais "-" mais 1 digito da
                                *-- EXATAMENTE os 8 de Crdados.numdoc C(8): a largura do destino
                                *-- prova que o campo eh POSICIONAL e o padding faz parte dele
                                *-- (CLAUDE.md regra #42). AllTrim encurtaria o numero do
                                *-- documento impresso no boleto.
                                loc_cNumDoc = NVL(cursor_4c_MvNfi.NFis, "") + "-" + ;
                                              STR(NVL(cursor_4c_MvPar.Parcs, 0), 1)

                                IF USED("cursor_4c_Cli") AND RECCOUNT("cursor_4c_Cli") > 0
                                    loc_cEndCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EndCobs, ""))), ;
                                        cursor_4c_Cli.EndCobs, cursor_4c_Cli.Endes)
                                    loc_cBaiCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.BaiCobs, ""))), ;
                                        cursor_4c_Cli.BaiCobs, cursor_4c_Cli.Bairs)
                                    loc_cCidCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CidCobs, ""))), ;
                                        cursor_4c_Cli.CidCobs, cursor_4c_Cli.Cidas)
                                    loc_cEstCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EstCobs, ""))), ;
                                        cursor_4c_Cli.EstCobs, cursor_4c_Cli.Estas)
                                    loc_cCepCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CepCobs, ""))), ;
                                        cursor_4c_Cli.CepCobs, cursor_4c_Cli.Ceps)

                                    INSERT INTO Crdados VALUES ( ;
                                        THIS.this_oBusinessObject.this_cLocals, loc_xVenc, cursor_4c_MvPar.Datas, ;
                                        loc_cNumDoc, cursor_4c_MvPar.Valos, cursor_4c_Cli.Razaos, cursor_4c_Cli.Cpfs, ;
                                        loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob, ;
                                        THIS.this_oBusinessObject.this_cTxtCds)
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_OpFp")
                                USE IN cursor_4c_OpFp
                            ENDIF
                        ENDIF
                    ENDSCAN

                    *-- ATENCAO: as 13 linhas de posicao e a chamada da rotina de
                    *-- impressao rodam UMA VEZ POR MOVIMENTO, DEPOIS do EndScan das
                    *-- parcelas - exatamente onde o legado as tem (cmdImprimir.Click:
                    *-- o EndScan de CrTmpPar fecha e so entao vem os ThisForm.GrDetalhe
                    *-- e o "do SigPrIbl"). Crdados chega aqui com TODAS as parcelas
                    *-- acumuladas e eh impresso de uma vez. NUNCA mover para dentro do
                    *-- SCAN: ali SigPrIbl seria chamado uma vez por parcela sobre um
                    *-- Crdados que cresce a cada volta, reimprimindo os boletos das
                    *-- parcelas anteriores (a 1a sairia N vezes) - sem erro e sem log.
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnLocals,  THIS.this_oBusinessObject.this_nClLocals,  "Crdados.clocal",  "", 60, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnDtVencs, THIS.this_oBusinessObject.this_nClDtVencs, "Crdados.vencs",   "", 9,  1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnDtDocs,  THIS.this_oBusinessObject.this_nClDtDocs,  "Dtoc(Crdados.datdoc)", "", 9, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnNrDocs,  THIS.this_oBusinessObject.this_nClNrDocs,  "Crdados.numdoc",  "", 9,  1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnVlDocs,  THIS.this_oBusinessObject.this_nClVlDocs,  "Transform(Crdados.valor,'@Z 999,999,999.99')", "", 15, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnRazClis, THIS.this_oBusinessObject.this_nClRazClis, "AllTrim(Crdados.razaos)",  "", 50, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnCgcClis, THIS.this_oBusinessObject.this_nClCgcClis, "AllTrim(Crdados.cpfs)",    "", 20, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnEndCobs, THIS.this_oBusinessObject.this_nClEndCobs, "AllTrim(Crdados.endcobs)", "", 80, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnBaiCobs, THIS.this_oBusinessObject.this_nClBaiCobs, "AllTrim(Crdados.baicobs)", "", 20, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnCidCobs, THIS.this_oBusinessObject.this_nClCidCobs, "AllTrim(Crdados.cidcobs)", "", 20, 1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnEstCobs, THIS.this_oBusinessObject.this_nClEstCobs, "AllTrim(Crdados.estcobs)", "", 2,  1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnCepCobs, THIS.this_oBusinessObject.this_nClCepCobs, "AllTrim(Crdados.cepcobs)", "", 9,  1)
                    THIS.GrDetalhe(THIS.this_oBusinessObject.this_nLnTxtCds,  THIS.this_oBusinessObject.this_nClTxtCds,  "Crdados.texto",   "", 60, 6)

                    *-- Rotina de impressao matricial do legado (nao portada - CLAUDE.md
                    *-- regra #27: ausencia tem de ficar visivel, nao escondida por um
                    *-- stub que "finge" ter impresso).
                    DO SigPrIbl WITH "tmpimprime", ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cNomeImps), ;
                        "to printer noconsole", 0, loc_nTamFolha, 0, 0, "crdados", 17

                    IF USED("cursor_4c_Cli")
                        USE IN cursor_4c_Cli
                    ENDIF
                    IF USED("cursor_4c_MvNfi")
                        USE IN cursor_4c_MvNfi
                    ENDIF
                    IF USED("cursor_4c_MvPar")
                        USE IN cursor_4c_MvPar
                    ENDIF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
        ENDTRY

        THIS.LockScreen = .F.
        IF loc_lProsseguir
            IF VARTYPE(THIS.this_oControleChamador) = "O"
                THIS.this_oControleChamador.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdSaidaClick - cmdSaida.Click do legado: confirma abandono se a
    * impressao ainda estiver habilitada, reabilita o controle do form
    * chamador e encerra.
    *==========================================================================
    PROCEDURE CmdSaidaClick()
        LOCAL loc_lPodeFechar, loc_oErro
        loc_lPodeFechar = .F.
        TRY
            IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
                loc_lPodeFechar = .T.
            ELSE
                loc_lPodeFechar = MsgConfirma("Deseja Abandonar as Impress" + CHR(245) + "es do Boleto?")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao sair")
        ENDTRY

        IF loc_lPodeFechar
            IF VARTYPE(THIS.this_oControleChamador) = "O"
                THIS.this_oControleChamador.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrDetalhe - grdetalhe do legado: insere uma linha de posicao/conteudo no
    * cursor TmpImprime, usado pela rotina de impressao matricial.
    *==========================================================================
    PROCEDURE GrDetalhe(par_nLinha, par_nColuna, par_cDetalhe, par_cEstilo, par_nLineSize, par_nHeight)
        LOCAL loc_nLinha, loc_nColuna, loc_cDetalhe, loc_cEstilo, loc_oErro
        TRY
            loc_nLinha   = IIF(VARTYPE(par_nLinha)   = "N", par_nLinha,   0)
            loc_nColuna  = IIF(VARTYPE(par_nColuna)  = "N", par_nColuna,  0)
            loc_cDetalhe = IIF(VARTYPE(par_cDetalhe) = "C", par_cDetalhe, "")
            loc_cEstilo  = IIF(VARTYPE(par_cEstilo)  = "C", par_cEstilo,  "X")
            IF EMPTY(loc_cEstilo)
                loc_cEstilo = "X"
            ENDIF

            IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
                IF USED("TmpImprime")
                    INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                        VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Ponto de entrada canonico do funil multi-fase. Form
    * OPERACIONAL flat: recarrega a configuracao do boleto atualmente
    * selecionado.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Form OPERACIONAL flat: captura o fpags digitado.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            THIS.this_cFPagsSel = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula os campos a partir do this_oBusinessObject carregado.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_FPags.Value     = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFPags, ""))
            THIS.txt_4c_Locals.Value    = NVL(THIS.this_oBusinessObject.this_cLocals, "")
            THIS.obj_4c_GetTxtCds.Value = NVL(THIS.this_oBusinessObject.this_cTxtCds, "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis e o botao
    * Imprimir conforme exista configuracao de boleto carregada.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oErro
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            THIS.txt_4c_Locals.Enabled    = loc_lHabilitar
            THIS.obj_4c_GetTxtCds.Enabled = loc_lHabilitar
            THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = loc_lHabilitar
            IF !loc_lHabilitar
                THIS.obj_4c_CmdGImprimir.Value = 2
            ENDIF
            THIS.obj_4c_CmdGImprimir.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa a selecao corrente (equivalente a nao ter nenhuma
    * configuracao de boleto carregada).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.this_cFPagsSel        = ""
            THIS.txt_4c_FPags.Value    = ""
            THIS.txt_4c_Locals.Value   = ""
            THIS.txt_4c_Locals.Enabled = .F.
            THIS.obj_4c_GetTxtCds.Value   = ""
            THIS.obj_4c_GetTxtCds.Enabled = .F.
            THIS.lbl_4c_LblAviso.Visible  = .T.
            THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
            THIS.obj_4c_CmdGImprimir.Value = 2
            THIS.obj_4c_CmdGImprimir.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL flat: o "modo" eh determinado por
    * existir ou nao configuracao de boleto carregada para o fpags atual.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lTemConfig, loc_oErro
        TRY
            loc_lTemConfig = !EMPTY(THIS.this_cFPagsSel) AND THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
            THIS.lbl_4c_LblAviso.Visible = !loc_lTemConfig
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Ponto de entrada canonico do funil multi-fase. Form
    * OPERACIONAL de impressao de boleto: a acao "Incluir/Confirmar" eh a
    * propria impressao - delega para CmdImprimirClick.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        IF EMPTY(THIS.this_cFPagsSel) OR !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
            MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
                CHR(225) + "lida antes de imprimir.", "Aviso")
            THIS.txt_4c_FPags.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.CmdImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Incluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Ponto de entrada canonico do funil multi-fase. Form
    * OPERACIONAL: "Alterar" recarrega a configuracao do boleto selecionado e
    * foca o campo de Local de Pagamento para edicao.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        IF EMPTY(THIS.this_cFPagsSel)
            MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de alterar.", "Aviso")
            THIS.txt_4c_FPags.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            IF THIS.txt_4c_Locals.Enabled
                THIS.txt_4c_Locals.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Alterar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Ponto de entrada canonico do funil multi-fase.
    * "Visualizar" abre o picker de condicoes de pagamento cadastradas.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AbrirLookupFPags()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Visualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Ponto de entrada canonico do funil multi-fase.
    * "Excluir" limpa a selecao corrente (nao afeta dados persistidos).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        IF EMPTY(THIS.this_cFPagsSel)
            RETURN
        ENDIF
        IF !MsgConfirma("Deseja limpar a Condi" + CHR(231) + CHR(227) + "o de Pagamento selecionada?")
            RETURN
        ENDIF

        TRY
            THIS.LimparCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Excluir")
        ENDTRY

        THIS.txt_4c_FPags.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Ponto de entrada canonico do funil multi-fase. Abre o
    * picker de condicoes de pagamento.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AbrirLookupFPags()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Buscar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Ponto de entrada canonico do funil multi-fase.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.CmdSaidaClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva Local de Pagamento/Texto do Cedente editados sem
    * disparar a impressao (uso do funil multi-fase/testes).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        IF EMPTY(THIS.this_cFPagsSel)
            MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de salvar.", "Aviso")
            THIS.txt_4c_FPags.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.this_cLocals = THIS.txt_4c_Locals.Value
            THIS.this_oBusinessObject.this_cTxtCds = THIS.obj_4c_GetTxtCds.Value

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Dados salvos com sucesso.", "Salvo")
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("Falha ao salvar. Verifique a conex" + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao Salvar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Ponto de entrada canonico do funil multi-fase.
    * Restaura os valores gravados (descarta edicao em andamento).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cFPagsSel)
                THIS.LimparCampos()
            ELSE
                THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Cancelar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - reabilita o controle do form chamador (pcNform1 do legado) e
    * libera os cursores auxiliares de impressao
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oControleChamador) = "O"
                THIS.this_oControleChamador.Enabled = .T.
            ENDIF
            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF
            IF USED("Crdados")
                USE IN Crdados
            ENDIF
            IF USED("TmpImprime")
                USE IN TmpImprime
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*====================================================================
* SIGPRIBLBO.prg
*
* Business Object para Impressao de Boleto Bancario (form OPERACIONAL)
* Tabela: SigCnFBl (Configuracao de Impressao de Boleto Bancario)
* Chave: cidchaves char(20) - PK
* Busca: fpags char(12) - Condicao de Pagamento (campo digitado na tela)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCnFBl)
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cFPags     = ""    && fpags char(12) - condicao de pagamento (chave de busca)
    this_cEmps      = ""    && cemps char(3)
    this_dDatas     = {}    && ddatas datetime
    this_cHoras     = ""    && choras char(8)
    this_cUsuarios  = ""    && cusuarios char(20)
    this_cTxtCds    = ""    && ctxtcds text - texto de responsabilidade do cedente
    this_cLocals    = ""    && clocals char(100) - local de pagamento
    this_nLnLocals  = 0     && nlnlocals numeric(5,2)
    this_nClLocals  = 0     && ncllocals numeric(5,2)
    this_nLnDtVencs = 0     && nlndtvencs numeric(5,2)
    this_nClDtVencs = 0     && ncldtvencs numeric(5,2)
    this_nLnDtDocs  = 0     && nlndtdocs numeric(5,2)
    this_nClDtDocs  = 0     && ncldtdocs numeric(5,2)
    this_nLnNrDocs  = 0     && nlnnrdocs numeric(5,2)
    this_nClNrDocs  = 0     && nclnrdocs numeric(5,2)
    this_nLnVlDocs  = 0     && nlnvldocs numeric(5,2)
    this_nClVlDocs  = 0     && nclvldocs numeric(5,2)
    this_nLnTxtCds  = 0     && nlntxtcds numeric(5,2)
    this_nClTxtCds  = 0     && ncltxtcds numeric(5,2)
    this_nTxtLins   = 0     && ntxtlins numeric(3,0)
    this_nTxtCols   = 0     && ntxtcols numeric(3,0)
    this_nLnRazClis = 0     && nlnrazclis numeric(5,2)
    this_nClRazClis = 0     && nclrazclis numeric(5,2)
    this_nLnEndCobs = 0     && nlnendcobs numeric(5,2)
    this_nClEndCobs = 0     && nclendcobs numeric(5,2)
    this_nLnCgcClis = 0     && nlncgcclis numeric(5,2)
    this_nClCgcClis = 0     && nclcgcclis numeric(5,2)
    this_nLnBaiCobs = 0     && nlnbaicobs numeric(5,2)
    this_nClBaiCobs = 0     && nclbaicobs numeric(5,2)
    this_nLnCidCobs = 0     && nlncidcobs numeric(5,2)
    this_nClCidCobs = 0     && nclcidcobs numeric(5,2)
    this_nLnEstCobs = 0     && nlnestcobs numeric(5,2)
    this_nClEstCobs = 0     && nclestcobs numeric(5,2)
    this_nLnCepCobs = 0     && nlncepcobs numeric(5,2)
    this_nClCepCobs = 0     && nclcepcobs numeric(5,2)
    this_cNomeImps  = ""    && cnomeimps char(128) - nome da impressora
    this_cFontePdrs = ""    && cfontepdrs char(128) - fonte padrao
    this_nTamFontes = 0     && ntamfontes numeric(3,0)
    this_cTamFolha  = ""    && ctamfolha char(50)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCnFBl"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRIBLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves eh a PK fisica (char(20)) de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "")
            THIS.this_cFPags     = TratarNulo(fpags,      "")
            THIS.this_cEmps      = TratarNulo(cemps,      "")
            THIS.this_dDatas     = TratarNulo(ddatas,     {})
            THIS.this_cHoras     = TratarNulo(choras,     "")
            THIS.this_cUsuarios  = TratarNulo(cusuarios,  "")
            THIS.this_cTxtCds    = TratarNulo(ctxtcds,    "")
            THIS.this_cLocals    = TratarNulo(clocals,    "")
            THIS.this_nLnLocals  = TratarNulo(nlnlocals,  0)
            THIS.this_nClLocals  = TratarNulo(ncllocals,  0)
            THIS.this_nLnDtVencs = TratarNulo(nlndtvencs, 0)
            THIS.this_nClDtVencs = TratarNulo(ncldtvencs, 0)
            THIS.this_nLnDtDocs  = TratarNulo(nlndtdocs,  0)
            THIS.this_nClDtDocs  = TratarNulo(ncldtdocs,  0)
            THIS.this_nLnNrDocs  = TratarNulo(nlnnrdocs,  0)
            THIS.this_nClNrDocs  = TratarNulo(nclnrdocs,  0)
            THIS.this_nLnVlDocs  = TratarNulo(nlnvldocs,  0)
            THIS.this_nClVlDocs  = TratarNulo(nclvldocs,  0)
            THIS.this_nLnTxtCds  = TratarNulo(nlntxtcds,  0)
            THIS.this_nClTxtCds  = TratarNulo(ncltxtcds,  0)
            THIS.this_nTxtLins   = TratarNulo(ntxtlins,   0)
            THIS.this_nTxtCols   = TratarNulo(ntxtcols,   0)
            THIS.this_nLnRazClis = TratarNulo(nlnrazclis, 0)
            THIS.this_nClRazClis = TratarNulo(nclrazclis, 0)
            THIS.this_nLnEndCobs = TratarNulo(nlnendcobs, 0)
            THIS.this_nClEndCobs = TratarNulo(nclendcobs, 0)
            THIS.this_nLnCgcClis = TratarNulo(nlncgcclis, 0)
            THIS.this_nClCgcClis = TratarNulo(nclcgcclis, 0)
            THIS.this_nLnBaiCobs = TratarNulo(nlnbaicobs, 0)
            THIS.this_nClBaiCobs = TratarNulo(nclbaicobs, 0)
            THIS.this_nLnCidCobs = TratarNulo(nlncidcobs, 0)
            THIS.this_nClCidCobs = TratarNulo(nclcidcobs, 0)
            THIS.this_nLnEstCobs = TratarNulo(nlnestcobs, 0)
            THIS.this_nClEstCobs = TratarNulo(nclestcobs, 0)
            THIS.this_nLnCepCobs = TratarNulo(nlncepcobs, 0)
            THIS.this_nClCepCobs = TratarNulo(nclcepcobs, 0)
            THIS.this_cNomeImps  = TratarNulo(cnomeimps,  "")
            THIS.this_cFontePdrs = TratarNulo(cfontepdrs, "")
            THIS.this_nTamFontes = TratarNulo(ntamfontes, 0)
            THIS.this_cTamFolha  = TratarNulo(ctamfolha,  "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorFPags - Carrega configuracao de boleto pela condicao de
    * pagamento (fpags eh o campo de busca digitado na tela; cidchaves eh a
    * PK fisica Fortyus, gerada so no Inserir)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorFPags(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha" + ;
                       " FROM SigCnFBl WHERE fpags = " + EscaparSQL(par_cFPags)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo na tabela SigCnFBl
    * cidchaves eh a PK fisica Fortyus - gerada aqui, nunca vazia (regra #22)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = PADR(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCnFBl" + ;
                       " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo na tabela SigCnFBl (cidchaves eh a chave,
    * nunca alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " fpags = "      + EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       " cemps = "      + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       " ddatas = "     + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " choras = "     + EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       " cusuarios = "  + EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       " ctxtcds = "    + EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       " clocals = "    + EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       " nlnlocals = "  + FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       " ncllocals = "  + FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       " nlndtdocs = "  + FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       " ncldtdocs = "  + FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       " nlnnrdocs = "  + FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       " nclnrdocs = "  + FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       " nlnvldocs = "  + FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       " nclvldocs = "  + FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       " nlntxtcds = "  + FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       " ncltxtcds = "  + FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       " ntxtlins = "   + FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       " ntxtcols = "   + FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       " nclrazclis = " + FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       " nclendcobs = " + FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       " nclestcobs = " + FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       " cnomeimps = "  + EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       " cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       " ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       " ctamfolha = "  + EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

