# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [25/09/2026 03:13:58 PM] Falha na Conexão (LocalTits): Favor Reinicializar o Processo!!!


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[25/09/2026 03:13:58 PM] Falha na Conexão (LocalTits): Favor Reinicializar o Processo!!!


### LOG DA ETAPA (06_testForm):
[2026-09-25 15:11:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 15:11:10] [INFO] Config FPW: (nao fornecido)
[2026-09-25 15:11:10] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 15:11:10] [INFO] Timeout: 300 segundos
[2026-09-25 15:11:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rwdcwvsh.prg
[2026-09-25 15:11:10] [INFO] Conteudo do wrapper:
[2026-09-25 15:11:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigmvtit', 'C:\4c\tasks\task579\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigmvtit', 'C:\4c\tasks\task579\logs\06_testForm.log'
QUIT

[2026-09-25 15:11:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rwdcwvsh.prg
[2026-09-25 15:11:10] [INFO] VFP output esperado em: C:\4c\tasks\task579\vfp_output.txt
[2026-09-25 15:11:10] [INFO] Executando Visual FoxPro 9...
[2026-09-25 15:11:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rwdcwvsh.prg
[2026-09-25 15:11:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rwdcwvsh.prg
[2026-09-25 15:11:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigmvtit
Inicio: 25/09/2026 15:11:10

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 25/09/2026 15:13:58
Duracao: 168 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-25 15:13:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-25 15:13:58] [INFO] VFP9 finalizado em 168.4867082 segundos
[2026-09-25 15:13:58] [INFO] Exit Code: 
[2026-09-25 15:13:58] [INFO] 
[2026-09-25 15:13:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 15:13:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rwdcwvsh.prg
[2026-09-25 15:13:58] [INFO] 
[2026-09-25 15:13:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 15:13:58] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 15:13:58] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 15:13:58] [INFO] * Parameters: 'Formsigmvtit', 'C:\4c\tasks\task579\logs\06_testForm.log'
[2026-09-25 15:13:58] [INFO] 
[2026-09-25 15:13:58] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 15:13:58] [INFO] SET SAFETY OFF
[2026-09-25 15:13:58] [INFO] SET RESOURCE OFF
[2026-09-25 15:13:58] [INFO] SET TALK OFF
[2026-09-25 15:13:58] [INFO] SET NOTIFY OFF
[2026-09-25 15:13:58] [INFO] SYS(2335, 0)
[2026-09-25 15:13:58] [INFO] 
[2026-09-25 15:13:58] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigmvtit', 'C:\4c\tasks\task579\logs\06_testForm.log'
[2026-09-25 15:13:58] [INFO] QUIT
[2026-09-25 15:13:58] [INFO] 
[2026-09-25 15:13:58] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 15:13:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvtit.prg):
*==============================================================================
* Formsigmvtit.prg - Titulos Gerados na Movimentacao
*==============================================================================
* Tipo: OPERACIONAL (layout FLAT, SEM PageFrame)
* Migrado de: SIGMVTIT.SCX
*
* Pilares:
*   UX   -> layout e comportamento o mais proximo possivel do legado (1000x600)
*   BD   -> SigMvCcr + SigCdGcr + SigCdCli (ver sigmvtitBO.prg)
*   CODE -> arquitetura em camadas (FormBase / sigmvtitBO)
*
* NOTA (paridade com o legado): o SIGMVTIT eh uma tela de CONSULTA (grid) dos
* titulos gerados numa movimentacao (Empresa+Operacao+Numero -> EmpDopNums) e
* o Opers do lancamento. Nao ha Inserir/Alterar/Excluir - o legado (raiz
* Class: form, SEM BaseClass: pageframe - ver tasks\task579\layout.json/
* sigmvtit_form_codigo_fonte.txt) usa layout proprio, com os controles direto
* na Form (grid + 2 textboxes de descricao + botao OK + botao Impressao), sem
* Page1(Lista)/Page2(Dados). Inventar PageFrame ou os 6 botoes CRUD canonicos
* violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade que o legado
* nao tem".
*
* FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedades de estado (espelham
* os parametros do Init legado - LParameters pEDN, pOpe - e as propriedades
* customizadas empresa/operacao/numero do form legado), Init()/
* InicializarForm()/Destroy(). O cabecalho (cntSombra no legado) ja entra
* aqui porque o dump do SCX TEM container - o ramo "FLAT sem container" do
* gate da Fase 3 nao se aplica; a prova de estrutura exigida eh
* AddObject("cnt_4c_...") + InicializarForm + CREATEOBJECT(BO).
*
* FASE 7/8 - "Eventos principais dos botoes" NAO se aplica no sentido
* literal de Incluir/Alterar/Visualizar/Excluir: o dump legado (SECAO 1 de
* sigmvtit_form_codigo_fonte.txt / layout.json) nao tem frmcadastro, nem
* Grupo_Op, nem PageFrame Lista/Dados - SIGMVTIT herda de `form` puro e
* declara EXATAMENTE 2 controles interativos (CommandButton): cmdSair
* ("OK") e iDoc ("Impressao"). Inventar BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick violaria o PILAR 1 (o usuario veria
* botoes que o legado nunca teve) e a regra de completude (ficariam vazios,
* ja que uma tela de CONSULTA nao tem o que Incluir/Alterar/Excluir). Os
* dois "eventos principais" reais deste form ja foram implementados na
* Fase 6: BtnSairClick() (equivalente a cmdSair.Click -> ThisForm.Release)
* e BtnIDocClick() (equivalente a iDoc.Click -> Do Form SigReIdt With...).
* O gate da Fase 7 trata exatamente este caso: legado sem CRUD valida pelo
* numero de botoes que o dump PROVA existir (2 CommandButton = 2 handlers
* reais, satisfaz o piso minHandlersF7) - mesma familia das excecoes ja
* documentadas para FormSigMvMen/FormSigMvExp (ver licoes "Gate da Fase 7
* exigia >=2 handlers" e "Gate da Fase 7: pcEscolha do form pai e
* Excluir.Click de grade nao sao CRUD" - olhar o DONO do nome, nao so o
* nome).
*
* FASE 8/8 - CONSOLIDACAO FINAL: o checklist generico desta fase
* (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick/
* FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/AjustarBotoesPorModo)
* eh convencao de form CRUD (Page1=Lista/Page2=Dados com modo INCLUIR/
* ALTERAR/EXCLUIR). SIGMVTIT nao tem nenhum desses - eh visualizador
* (legadoVisualizadorF8: sem CRUD, sem botao de gravar, TODOS os campos
* somente-leitura - grdTitulos.ColumnN.Text1 x7 + getDGrupos + getDContas
* tem "PROCEDURE When -> Return .f." no dump, ver comportamento.json).
* Inventar esses metodos violaria o PILAR 1 (usuario veria botoes/campos
* editaveis que o legado nunca teve) e a regra de completude (ficariam
* vazios, sem o que Buscar/Salvar/Cancelar numa tela que so consulta e
* imprime). A funcionalidade REAL de consolidacao ja esta implementada:
*   - CarregarLista()            -> SqlExecute do Init legado (Fase 3/4)
*   - AtualizarDescricoes()      -> AfterRowColChange (Fase 6, espelha o
*                                    BO->Form que FormParaBO/BOParaForm
*                                    fariam se houvesse campo editavel)
*   - BtnSairClick() (Encerrar)  -> cmdSair.Click = ThisForm.Release (F7)
*   - BtnIDocClick() (acao)      -> iDoc.Click = Do Form SigReIdt (F7)
*   - Destroy()                  -> ThisForm.poDataMgr.Release + libera
*                                    cursor_4c_Dados (consolidacao final)
* Mesma familia de excecao das licoes "Gate da Fase 8 exigia botao de
* acao que o legado nao tem" (SIGMVCTH/SIGMVSBN) - aqui com DOIS botoes
* de acao real (nao apenas Release), entao a dispensa passa pelo ramo
* $legadoVisualizadorF8 (nao pelo ramo "legadoSemAcao com 1 botao").
*
* CHAMADA (equivalente a DO FORM SigMvTit WITH pEDN, pOpe do legado):
*   loForm = CREATEOBJECT("Formsigmvtit", par_cEmpDopNums, par_cOpers)
*   loForm.Show()
*==============================================================================

DEFINE CLASS Formsigmvtit AS FormBase

    *-- Dimensoes e comportamento identicos ao legado (SIGMVTIT.SCX)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .T.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    WindowState  = 0
    DataSession  = 2

    *-- Parametros de abertura (LParameters pEDN, pOpe do Init legado).
    *-- this_cEmpDopNums e this_cOpers guardam os valores CRUS (sem ALLTRIM),
    *-- porque EmpDopNums eh chave POSICIONAL char(29) - ALLTRIM nas partes
    *-- quebra o SEEK/WHERE no BO (mesma familia do Erro177, ver
    *-- sigmvtitBO.prg.Buscar). this_cEmpresa/this_cOperacao/this_cNumero sao
    *-- so para exibicao (Caption), decompostos com Alltrim(Substr(...)) igual
    *-- ao Init legado.
    this_cEmpDopNums = ""    && pEDN - char(29): Empresa(3) + Operacao(20) + Numero(6)
    this_cOpers      = ""    && pOpe - char(1)
    this_cEmpresa    = ""    && Alltrim(Substr(pEDN, 01, 03))
    this_cOperacao   = ""    && Alltrim(Substr(pEDN, 04, 20))
    this_cNumero     = ""    && Alltrim(Substr(pEDN, 24, 06))

    *==========================================================================
    * Init - Recebe os parametros de abertura (equivalente a LParameters pEDN,
    * pOpe do legado), decompoe Empresa/Operacao/Numero e repassa para
    * FormBase.Init() (que chama InicializarForm() atraves de DODEFAULT()).
    *==========================================================================
    PROCEDURE Init(par_cEmpDopNums, par_cOpers)
        THIS.this_cEmpDopNums = IIF(TYPE("par_cEmpDopNums") = "C", par_cEmpDopNums, "")
        THIS.this_cOpers      = IIF(TYPE("par_cOpers") = "C", par_cOpers, "")

        THIS.this_cEmpresa  = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 01, 03))
        THIS.this_cOperacao = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 04, 20))
        THIS.this_cNumero   = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 24, 06))

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o Business Object, repassa a chave de
    * filtro, monta o Caption dinamico (igual ao Init legado) e cria o
    * cabecalho (Fase 3). Grid, textboxes de descricao e botoes entram nas
    * proximas fases.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("sigmvtitBO")

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Falha ao criar sigmvtitBO", "Erro")
        ELSE
            THIS.this_oBusinessObject.this_cEmpresa    = THIS.this_cEmpresa
            THIS.this_oBusinessObject.this_cOperacao   = THIS.this_cOperacao
            THIS.this_oBusinessObject.this_cNumero     = THIS.this_cNumero
            THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
            THIS.this_oBusinessObject.this_cOpers      = THIS.this_cOpers

            *-- Init legado: .Caption = [Titulos Gerados - Movimentacao : ] +
            *-- Empresa + [ / ] + Operacao + [ / ] + Numero
            THIS.Caption = "T" + CHR(237) + "tulos Gerados - Movimenta" + CHR(231) + CHR(227) + "o : " + ;
                THIS.this_cEmpresa + " / " + THIS.this_cOperacao + " / " + THIS.this_cNumero

            *-- Picture = ..\framework\imagens\new_background.jpg no legado -
            *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
            *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").
            IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            ENDIF

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPaginaLista()

            *-- Init legado: Return .f. quando SqlExecute(lcQuery, [LocalTits]) < 1
            *-- (erro OU zero linhas) - a tela NAO abre. Este form so eh chamado
            *-- a partir de uma movimentacao que ja gerou titulos, entao lista
            *-- vazia eh anomalia, nao caminho normal (ver CarregarLista).
            IF THIS.CarregarLista()
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria a grade de titulos (grdTitulos), os campos
    * de descricao readonly (getDGrupos/getDContas + labels) e os botoes OK
    * (cmdSair) e Impressao (iDoc), todos direto na Form (layout FLAT, sem
    * PageFrame/Page1/Page2 - regra ja fixada na Fase 3). Somente estrutura e
    * propriedades que NAO dependem de dado - RecordSource/ControlSource dos
    * campos do grid entram em CarregarLista (regra CLAUDE.md #41: Column.
    * ControlSource antes do cursor existir derruba o Init).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_nCol

        *-- Shape1 do legado - decorativo, atras do botao OK (BackStyle=0 +
        *-- BorderStyle=0 = sem preenchimento e sem borda, ou seja, invisivel
        *-- em runtime; migrado apenas por fidelidade estrutural ao SCX).
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 0
            .Left        = 923
            .Width       = 75
            .Height      = 79
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Grid de titulos (grdTitulos do legado)
        THIS.AddObject("grd_4c_Titulos", "Grid")
        WITH THIS.grd_4c_Titulos
            .Top           = 83
            .Left          = 6
            .Width         = 884
            .Height        = 467
            .ColumnCount   = 7
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .ReadOnly      = .T.
        ENDWITH

        *-- Propriedades comuns das 7 colunas (Width/Header1.Caption entram em
        *-- CarregarLista, DEPOIS do RecordSource - regra CLAUDE.md Problema 48)
        FOR loc_nCol = 1 TO 7
            WITH THIS.grd_4c_Titulos.Columns(loc_nCol)
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDFOR

        *-- Descricoes do grupo/conta da linha corrente (getDGrupos/getDContas
        *-- do legado) - somente exibicao, atualizadas em GrdTitulosAfterRowColChange
        *-- ReadOnly + TabStop = .F. reproduzem o "PROCEDURE When -> Return .f."
        *-- que o legado declara nos DOIS campos: no Framework Fortyus o When
        *-- devolvendo .F. impede o controle de receber foco, e eh por isso que
        *-- nenhum deles tem lookup - nao ha onde digitar codigo para um picker
        *-- resolver. NAO usar .Enabled = .F.: acinzentaria o texto, e o legado
        *-- exibe a descricao com a aparencia normal do fwget.
        THIS.AddObject("txt_4c_DGrupos", "TextBox")
        WITH THIS.txt_4c_DGrupos
            .Top           = 569
            .Left          = 6
            .Width         = 440
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
        ENDWITH

        THIS.AddObject("txt_4c_DContas", "TextBox")
        WITH THIS.txt_4c_DContas
            .Top           = 569
            .Left          = 450
            .Width         = 440
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 554
            .Left      = 6
            .Width     = 111
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 554
            .Left      = 450
            .Width     = 110
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        *-- Botao OK (cmdSair do legado) - fecha o form. Standalone com
        *-- .Picture exige .Themes = .T. + .DisabledPicture (regra CLAUDE.md
        *-- Pattern #99), mesmo o legado nao declarando Themes para este botao.
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 923
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
        ENDWITH

        *-- Botao de Impressao (iDoc do legado) - abre FormSigReIdt para o
        *-- titulo da linha corrente da grade
        THIS.AddObject("cmd_4c_IDoc", "CommandButton")
        WITH THIS.cmd_4c_IDoc
            .Top             = 3
            .Left            = 847
            .Width           = 75
            .Height          = 75
            .Caption         = "Im\<press" + CHR(227) + "o"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Alignment       = 2
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
            .ToolTipText     = "Impress" + CHR(227) + "o"
        ENDWITH

        BINDEVENT(THIS.grd_4c_Titulos, "AfterRowColChange", THIS, "GrdTitulosAfterRowColChange")
        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnSairClick")
        BINDEVENT(THIS.cmd_4c_IDoc,    "Click", THIS, "BtnIDocClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Executa sigmvtitBO.Buscar (equivalente a SqlExecute do
    * Init legado) e liga a grade ao cursor_4c_Dados. RecordSource reseta
    * Width/Header1.Caption das colunas (CLAUDE.md Problema 48) - por isso
    * essas duas propriedades sao reaplicadas AQUI, depois do RecordSource.
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums, THIS.this_cOpers)
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                loc_oGrid = THIS.grd_4c_Titulos

                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.titulos"
                loc_oGrid.Column2.ControlSource = "TTOD(cursor_4c_Dados.vencs)"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.hists"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column1.Header1.Caption = "T" + CHR(237) + "tulo"
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column2.Header1.Caption = "Vencimento"
                loc_oGrid.Column3.Width = 120
                loc_oGrid.Column3.Header1.Caption = "Valor"
                loc_oGrid.Column4.Width = 31
                loc_oGrid.Column4.Header1.Caption = "Moe"
                loc_oGrid.Column5.Width = 335
                loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
                loc_oGrid.Column6.Width = 90
                loc_oGrid.Column6.Header1.Caption = "Grupo"
                loc_oGrid.Column7.Width = 90
                loc_oGrid.Column7.Header1.Caption = "Conta"

                SELECT cursor_4c_Dados
                GO TOP
                loc_oGrid.Refresh()

                THIS.AtualizarDescricoes()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalTits)")
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Este form eh FLAT (sem PageFrame/Page1/Page2) - metodo
    * existe apenas por convencao (harness de teste/FormBase chamam por nome),
    * sem efeito. Mesmo padrao usado em outros forms OPERACIONAIS flat
    * (ex.: FormICO.AlternarPagina).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * AtualizarDescricoes - Espelha a linha corrente da grade nos textboxes de
    * descricao (AfterRowColChange do legado: getDGrupos/getDContas.Value =
    * LocalTits.DGrupos/DContas + Refresh).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarDescricoes
        LOCAL loc_lCarregou

        *-- PILAR 3: quem le o cursor eh o BO (sigmvtitBO.CarregarDoCursor
        *-- popula as 11 propriedades do registro corrente); o form so espelha.
        *-- Alem das duas descricoes exibidas aqui, isso deixa Dopcs/Titulos/
        *-- Numcs prontos para o botao de Impressao, que no legado tambem os
        *-- lia da MESMA linha corrente de LocalTits.
        loc_lCarregou = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            loc_lCarregou = THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        ENDIF

        IF loc_lCarregou
            THIS.txt_4c_DGrupos.Value = THIS.this_oBusinessObject.this_cDGrupos
            THIS.txt_4c_DContas.Value = THIS.this_oBusinessObject.this_cDContas
        ELSE
            THIS.txt_4c_DGrupos.Value = ""
            THIS.txt_4c_DContas.Value = ""
        ENDIF

        THIS.txt_4c_DGrupos.Refresh()
        THIS.txt_4c_DContas.Refresh()

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * GrdTitulosAfterRowColChange - PUBLIC (regra CLAUDE.md #3: BINDEVENT
    * exige metodo PUBLIC). Equivalente ao grdTitulos.AfterRowColChange legado.
    *==========================================================================
    PROCEDURE GrdTitulosAfterRowColChange(par_nColIndex)
        THIS.AtualizarDescricoes()
    ENDPROC

    *==========================================================================
    * BtnSairClick - PUBLIC (BINDEVENT). Equivalente a cmdSair.Click legado
    * (ThisForm.Release()).
    *==========================================================================
    PROCEDURE BtnSairClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIDocClick - PUBLIC (BINDEVENT). Equivalente a iDoc.Click legado:
    * If !Empty(ThisForm.Empresa) And !Empty(LocalTits.Dopcs) And
    * !Empty(LocalTits.titulos) -> Do Form SigReIdt With Thisform,
    * ThisForm.Empresa, LocalTits.Dopcs, LocalTits.titulos, LocalTits.Numcs, [].
    *==========================================================================
    PROCEDURE BtnIDocClick
        LOCAL loc_oForm, loc_oErro, loc_lPodeAbrir

        loc_oForm = .NULL.

        *-- O legado le LocalTits.Dopcs/titulos/Numcs DIRETO do cursor, sempre
        *-- na linha corrente. Reposicionar o BO aqui garante a mesma leitura
        *-- mesmo se o ponteiro tiver andado sem passar pelo AfterRowColChange.
        loc_lPodeAbrir = THIS.AtualizarDescricoes() AND ;
            !EMPTY(THIS.this_cEmpresa) AND ;
            !EMPTY(THIS.this_oBusinessObject.this_cDopcs) AND ;
            !EMPTY(THIS.this_oBusinessObject.this_cTitulos)

        IF loc_lPodeAbrir
            *-- Show() FICA FORA do TRY (regra CLAUDE.md #29): com form modal o
            *-- Show bloqueia, entao todo o uso da tela filha rodaria dentro do
            *-- TRY e qualquer erro de runtime la dentro saltaria para o CATCH,
            *-- derrubando a referencia LOCAL e fechando a tela sozinha.
            TRY
                loc_oForm = CREATEOBJECT("FormSigReIdt", THIS, THIS.this_cEmpresa, ;
                    THIS.this_oBusinessObject.this_cDopcs, ;
                    THIS.this_oBusinessObject.this_cTitulos, ;
                    THIS.this_oBusinessObject.this_nNumcs, "")
            CATCH TO loc_oErro
                MostrarErro("Erro ao abrir a impress" + CHR(227) + "o do documento:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Formsigmvtit.BtnIDocClick")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria a faixa de titulo (cntSombra no legado), com
    * os dois labels sobrepostos (sombra preta + titulo branco). Identico ao
    * padrao canonico do framework (CLAUDE.md regra #11/#12), exceto que este
    * form eh FLAT (sem PageFrame) - o container vai direto na Form, sem
    * compensacao de Top (+29 so se aplica dentro de Page).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top         = 18
            .Left        = 10
            .Width       = 769
            .Height      = 40
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(0, 0, 0)
            .Caption     = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
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
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis apos o
    * AddObject (que os cria com Visible = .F. por padrao), percorrendo
    * Containers/Pages recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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
    * Destroy - Equivalente ao Release legado (ThisForm.poDataMgr.Release +
    * DoDefault): libera o cursor da grade antes de devolver o controle a
    * FormBase. DODEFAULT() eh a ULTIMA linha - FormBase.Destroy reconstroi os
    * popups do menu principal, e sem ele o menu encolhe (Pattern #145).
    *==========================================================================
    PROCEDURE Destroy
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvtitBO.prg):
*==============================================================================
* sigmvtitBO.prg
*
* Business Object para Formsigmvtit (Titulos Gerados - Movimentacao)
* Tabela principal: SigMvCcr (contas a receber/pagar geradas por movimento)
* Joins: SigCdGcr (descricao do grupo), SigCdCli (descricao da conta)
*
* Form OPERACIONAL de CONSULTA: exibe, por Empresa+Operacao+Numero (chave
* EmpDopNums) e Opers, os titulos gerados na movimentacao. Nao ha
* Inserir/Atualizar/Excluir no legado (SIGMVTIT.SCX so consulta e imprime).
*==============================================================================

DEFINE CLASS sigmvtitBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (LParameters pEDN, pOpe do legado)
    this_cEmpresa    = ""    && Empresa: Alltrim(Substr(pEDN, 01, 03))
    this_cOperacao   = ""    && Operacao (Dopes): Alltrim(Substr(pEDN, 04, 20))
    this_cNumero     = ""    && Numero: Alltrim(Substr(pEDN, 24, 06))
    this_cEmpDopNums = ""    && pEDN completo - char(29), usado no WHERE a.EmpDopNums =
    this_cOpers      = ""    && pOpe - char(1), usado no WHERE a.Opers =

    *-- Propriedades de dados do registro corrente da grade (SigMvCcr + joins)
    this_cTitulos  = ""      && SigMvCcr.titulos char(10)
    this_dVencs    = {}      && SigMvCcr.vencs datetime -> exibido via Ttod()
    this_nValors   = 0       && SigMvCcr.valors numeric(11,2)
    this_cMoedas   = ""      && SigMvCcr.moedas char(3)
    this_cHists    = ""      && SigMvCcr.hists char(60)
    this_cGrupos   = ""      && SigMvCcr.grupos char(10)
    this_cDGrupos  = ""      && SigCdGcr.descrs char(40) (Left Join por Grupos = Codigos)
    this_cContas   = ""      && SigMvCcr.contas char(10)
    this_cDContas  = ""      && SigCdCli.rclis char(50) (Left Join por Contas = Iclis)
    this_cDopcs    = ""      && SigMvCcr.dopcs char(20) (usado no botao de impressao - iDoc)
    this_nNumcs    = 0       && SigMvCcr.numcs numeric(6,0) (usado no botao de impressao - iDoc)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        THIS.this_cTabela = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Popula cursor_4c_Dados com os titulos gerados na movimentacao
    *
    * Espelha literalmente a query do Init do legado (SIGMVTIT.SCX):
    *   Select a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos,
    *          b.Descrs as DGrupos, a.Contas, c.RClis as DContas, a.Dopcs, a.Numcs
    *   From SigMvCcr a
    *   Left Join SigCdGcr b On a.Grupos = b.Codigos
    *   Left Join SigCdCli c On a.Contas = c.IClis
    *   Where a.EmpDopNums = ?pEDN And a.Opers = ?pOpe
    *   Order By a.Vencs, a.Titulos, a.Grupos, a.Contas
    *
    * par_cEmpDopNums: chave POSICIONAL char(29) ja montada pelo form CHAMADOR
    * (Empresa char(3) + Operacao char(20) + Numero str(6)). NUNCA aplicar
    * ALLTRIM nela - o padding faz parte da chave (mesma familia do Erro177).
    *==========================================================================
    PROCEDURE Buscar(par_cEmpDopNums, par_cOpers)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    *-- vencs eh T (datetime), NAO D: SigMvCcr.vencs eh
                    *-- datetime no schema, e a grade liga a coluna via
                    *-- ControlSource = "TTOD(cursor_4c_Dados.vencs)". Com D
                    *-- aqui o TTOD receberia um DATE e estouraria o erro 11
                    *-- em runtime (regra CLAUDE.md #16) - o fallback tem de
                    *-- ter a MESMA estrutura que o SQLEXEC produz.
                    CREATE CURSOR cursor_4c_Dados (titulos C(10), vencs T, valors N(11,2), ;
                        moedas C(3), hists C(60), grupos C(10), dgrupos C(40), ;
                        contas C(10), dcontas C(50), dopcs C(20), numcs N(6,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT a.titulos, a.vencs, a.valors, a.moedas, a.hists, a.grupos, " + ;
                    "b.descrs AS dgrupos, a.contas, c.rclis AS dcontas, a.dopcs, a.numcs " + ;
                    "FROM SigMvCcr a " + ;
                    "LEFT JOIN SigCdGcr b ON a.grupos = b.codigos " + ;
                    "LEFT JOIN SigCdCli c ON a.contas = c.iclis " + ;
                    "WHERE a.empdopnums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
                    "AND a.opers = " + EscaparSQL(par_cOpers) + " " + ;
                    "ORDER BY a.vencs, a.titulos, a.grupos, a.contas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF
                ELSE
                    MostrarErro("Erro ao buscar t" + CHR(237) + "tulos gerados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvtitBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do registro corrente de
    * cursor_4c_Dados (equivalente ao AfterRowColChange do legado, que
    * espelhava LocalTits.DGrupos/DContas nos GETs de descricao)
    *
    * PUBLIC de proposito: BusinessBase.CarregarDoCursor eh PUBLIC e o form
    * chama este metodo de FORA da classe (AtualizarDescricoes). Declarar
    * PROTECTED aqui estreitaria a visibilidade da base e a chamada falharia em
    * RUNTIME com "Property CARREGARDOCURSOR is not found" - mesma armadilha da
    * regra CLAUDE.md #3 (PEMSTATUS so verifica existencia, nao escopo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_cTitulos  = TratarNulo(titulos,  "")
                    THIS.this_dVencs    = ConverterParaData(vencs)
                    THIS.this_nValors   = TratarNulo(valors,   0)
                    THIS.this_cMoedas   = TratarNulo(moedas,   "")
                    THIS.this_cHists    = TratarNulo(hists,    "")
                    THIS.this_cGrupos   = TratarNulo(grupos,   "")
                    THIS.this_cDGrupos  = TratarNulo(dgrupos,  "")
                    THIS.this_cContas   = TratarNulo(contas,   "")
                    THIS.this_cDContas  = TratarNulo(dcontas,  "")
                    THIS.this_cDopcs    = TratarNulo(dopcs,    "")
                    THIS.this_nNumcs    = TratarNulo(numcs,    0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvtitBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Identificador do registro corrente da grade, usado
    * apenas se algum dia a base chamar RegistrarAuditoria (form eh consulta,
    * nao grava nada por conta propria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGMVTIT eh um form de CONSULTA
    * (visualizador de titulos gerados na movimentacao, aberto via DO FORM
    * com Empresa/Operacao/Numero). O legado (SIGMVTIT.SCX) nao tem nenhum
    * INSERT/UPDATE/DELETE - so exibe a grade e imprime (botao iDoc chama
    * outro form, SigReIdt). O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto - nao ha necessidade de
    * sobrescrever esses tres metodos aqui.
    *==========================================================================

ENDDEFINE

