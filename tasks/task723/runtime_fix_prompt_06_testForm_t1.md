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
[2026-10-31 15:46:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-31 15:46:54] [INFO] Config FPW: (nao fornecido)
[2026-10-31 15:46:54] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-31 15:46:54] [INFO] Timeout: 300 segundos
[2026-10-31 15:46:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rrfzrhnx.prg
[2026-10-31 15:46:54] [INFO] Conteudo do wrapper:
[2026-10-31 15:46:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpDoc', 'C:\4c\tasks\task723\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpDoc', 'C:\4c\tasks\task723\logs\06_testForm.log'
QUIT

[2026-10-31 15:46:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rrfzrhnx.prg
[2026-10-31 15:46:54] [INFO] VFP output esperado em: C:\4c\tasks\task723\vfp_output.txt
[2026-10-31 15:46:54] [INFO] Executando Visual FoxPro 9...
[2026-10-31 15:46:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rrfzrhnx.prg
[2026-10-31 15:46:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rrfzrhnx.prg
[2026-10-31 15:46:54] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpDoc
Inicio: 31/10/2026 15:46:54

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - Excecao ao criar objeto:
     Mensagem: Function argument value, type, or count is invalid.
     Codigo: 11
     Linha: 111

=== RESULTADO DO TESTE ===
Fim: 31/10/2026 15:47:12
Duracao: 18 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-31 15:47:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-31 15:47:12] [INFO] VFP9 finalizado em 18.1530933 segundos
[2026-10-31 15:47:12] [INFO] Exit Code: 
[2026-10-31 15:47:12] [INFO] 
[2026-10-31 15:47:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-31 15:47:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rrfzrhnx.prg
[2026-10-31 15:47:12] [INFO] 
[2026-10-31 15:47:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-31 15:47:12] [INFO] * Auto-generated wrapper for parameters
[2026-10-31 15:47:12] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-31 15:47:12] [INFO] * Parameters: 'FormSigOpDoc', 'C:\4c\tasks\task723\logs\06_testForm.log'
[2026-10-31 15:47:12] [INFO] 
[2026-10-31 15:47:12] [INFO] * Anti-dialog protections for unattended execution
[2026-10-31 15:47:12] [INFO] SET SAFETY OFF
[2026-10-31 15:47:12] [INFO] SET RESOURCE OFF
[2026-10-31 15:47:12] [INFO] SET TALK OFF
[2026-10-31 15:47:12] [INFO] SET NOTIFY OFF
[2026-10-31 15:47:12] [INFO] SYS(2335, 0)
[2026-10-31 15:47:12] [INFO] 
[2026-10-31 15:47:12] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpDoc', 'C:\4c\tasks\task723\logs\06_testForm.log'
[2026-10-31 15:47:12] [INFO] QUIT
[2026-10-31 15:47:12] [INFO] 
[2026-10-31 15:47:12] [INFO] === Fim do Wrapper.prg ===
[2026-10-31 15:47:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDoc.prg):
*==============================================================================
* FormSigOpDoc.prg - Relacao de Arquivos e Documentos
* Herda de: FormBase
* Origem:  SIGOPDOC.SCX
* BO:      SigOpDocBO (SigOpArq)
*
* Form OPERACIONAL - dialogo FILHO, instanciado por outro form/BO passando a
* chave de amarracao e o modo de acesso (legado: DO FORM SigOpDoc WITH pKey,
* pEsc / Lparameters pKey, pEsc no Init). Layout FLAT - nao usa PageFrame
* Lista/Dados do padrao CRUD (regra do CLAUDE.md para forms OPERACIONAL).
*
* pKey (par_cChave)   -> this_cArqChaves: chave de 30 posicoes (EmpDopNums,
*                        CPros, IClis, etc.) que amarra os arquivos a um
*                        registro do form pai (grava em SigOpArq.fkChaves).
* pEsc (par_cEscolha) -> this_cEscolha: equivalente a ThisForm.pcEscolha no
*                        legado. So quando = "INSERIR"/"ALTERAR" os botoes de
*                        manutencao (Inserir/Excluir/Confirmar) ficam ativos;
*                        em qualquer outro valor a tela abre somente-leitura.
*
* FASE 4/8 - Grid de arquivos (grdArquivos) + botoes standalone de manutencao
* (Inserir/Abrir/Excluir/Abrir Diretorio) + CarregarLista/AjustarBotoesPorModo.
* FASE 5/8 - Painel de observacao/preview (Shape1/imgArqJpg/Say31/getObsArqs).
* FASE 6/8 - Campos de auditoria (getDatas/getUsuars/Say1/Say2) + a validacao
* de campo que o legado fazia nos eventos dos controles: ValidarArquivoSelecionado
* (o guard "Not Empty(lcArq) And File(lcArq)" que o legado repete em
* btnOpnArqs.Click / btnOpnDirs.Click / imgArqJpg.DblClick) e
* ValidarExtensaoImagem (o InList de .JPG/.ICO/.BMP/.JPEG que o legado repete
* em grdArquivos.AfterRowColChange / imgArqJpg.DblClick), mais os dois
* handlers que consomem essas validacoes e alimentam os campos criados aqui e
* na fase 5 - GradeAfterRowColChange (preview + Refresh dos tres campos de
* detalhe) e ImgArqJpgDblClick (zoom da imagem).
* NAO ha lookup neste form: o dump do SIGOPDOC.SCX nao casa nenhum padrao de
* busca do Framework legado (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
* mAddColuna) e comportamento.json traz temLookup = .F. em todos os 19
* metodos - o unico CreateObject do legado eh Shell.Application. Inventar
* lookup aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup
* que nao existem no original".
* FASE 7/8 - Bloco de saida (cmdBtnForm: CommandGroup Sair/Confirmar) +
* SalvarDados(). O legado liga crSigOpArq a um cursor COM BUFFERING
* (.poDataMgr.AddCursor) - btnInsArqs/btnExcArqs so editam o buffer local, e
* salvardados() eh quem de fato grava tudo no SQL Server
* (.poDataMgr.Update/.Commit, com .RollBack() se falhar). Na arquitetura
* nova esse buffering nao existe: BtnInsArqsClick/BtnExcArqsClick ja gravam
* direto via BO.Inserir()/BO.Excluir() (fase 4). O que ainda exigia
* confirmacao explicita era a edicao do campo Observacao
* (obj_4c_GetObsArqs, ligado a cursor_4c_Dados - cursor LOCAL/desconectado
* do servidor): SalvarDados() varre esse cursor e empurra cada linha para
* SigOpArq via BO.Atualizar(), que eh o equivalente funcional do
* Update()/Commit() do legado para este form.
* FASE 8/8 - Consolidacao: os hooks de transferencia Form<->BO (FormParaBO/
* BOParaForm), o controle unico da superficie editavel (HabilitarCampos), a
* limpeza do painel de detalhe (LimparCampos) e o nome canonico do botao de
* cancelar (BtnCancelarClick, que eh o btnSair Cancel=.T. do SCX).
*
* Dois defeitos de parida de funcional foram corrigidos aqui, ambos silenciosos:
*
* 1) cursor_4c_Dados chegava SOMENTE-LEITURA. O EditBox de observacao
*    (obj_4c_GetObsArqs) esta ligado a ele por ControlSource, e cursor de
*    SQLEXEC nasce read-only - o campo nao aceitava uma tecla e SalvarDados
*    nunca teria o que gravar, sem erro nenhum na tela (medido no VFP9:
*    REPLACE em cursor assim estoura erro 111 "Cannot update the cursor ...,
*    since it is read-only"). O legado liga crSigOpArq por .AddCursor, cursor
*    COM buffering e gravavel - a prova esta no proprio Init legado, que faz
*    "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])". Conserto em
*    SigOpDocBO.Buscar: SQLEXEC vai para alias temporario e o alias da grade
*    eh recriado com SELECT ... INTO CURSOR ... READWRITE.
*
* 2) A normalizacao "Set ObsArqs = Nvl(ObsArqs, [])" do Init legado nao tinha
*    sido migrada: coluna TEXT nula chega ao EditBox como .NULL. e eh isso que
*    o usuario le na tela (mesma familia do mRetiraNull do legado). Agora
*    acontece no BO.Buscar (todas as linhas) e em BOParaForm (linha corrente).
*==============================================================================

DEFINE CLASS FormSigOpDoc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (copiadas do SIGOPDOC.SCX - PILAR 1)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 640
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    AlwaysOnTop  = .T.
    BorderStyle  = 2
    WindowType   = 1
    DataSession  = 2
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    Caption      = "Rela" + CHR(231) + CHR(227) + "o de Arquivos e Documentos"

    *--------------------------------------------------------------------------
    * Propriedades de estado (equivalentes a ArqChaves/pcEscolha do legado)
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cArqChaves      = ""   && pKey  - chave de amarracao (fkChaves, 30 posicoes)
    this_cEscolha        = ""   && pEsc  - "INSERIR"/"ALTERAR"/outro (somente-leitura)

    *==========================================================================
    * Init - Recebe a chave de amarracao e o modo de acesso, cria o Business
    * Object e delega a montagem da tela ao FormBase.Init (que chama
    * THIS.InicializarForm()). Equivalente a "Lparameters pKey, pEsc" + o
    * guard "If Empty(pKey) Or Empty(pEsc)" do Init legado.
    *==========================================================================
    FUNCTION Init(par_cChave, par_cEscolha)
        THIS.this_cArqChaves = ALLTRIM(NVL(par_cChave, ""))
        THIS.this_cEscolha   = ALLTRIM(UPPER(NVL(par_cEscolha, "")))

        IF EMPTY(THIS.this_cArqChaves) OR EMPTY(THIS.this_cEscolha)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos para " + ;
                "abrir a rela" + CHR(231) + CHR(227) + "o de arquivos.", "Erro")
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject = CREATEOBJECT("SigOpDocBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SigOpDocBO.", "Erro")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form (chamado pelo
    * FormBase.Init). Deve retornar .T. em sucesso e .F. em falha.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarGrid()
            THIS.ConfigurarBotoesArquivos()
            THIS.ConfigurarPainelObservacao()
            THIS.ConfigurarCamposAuditoria()
            THIS.ConfigurarBotaoFechar()

            THIS.TornarControlesVisiveis(THIS)

            *-- Preview de imagem (img_4c_ImgArqJpg) nasce oculto de proposito
            *-- (legado: imgArqJpg.Visible=.f. no SCX) - so aparece quando o
            *-- arquivo da linha corrente da grade for .jpg/.ico/.bmp/.jpeg
            THIS.img_4c_ImgArqJpg.Visible = .F.

            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()

            *-- Legado: o Init termina com ".grdArquivos.Column1.SetFocus" +
            *-- ".grdArquivos.AfterRowColChange()" - a chamada explicita eh o
            *-- que deixa preview e campos de detalhe coerentes com a PRIMEIRA
            *-- linha, antes de o usuario mexer na grade.
            THIS.GradeAfterRowColChange(1)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpDoc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Cabecalho: Top=0 Left=0 Width=THIS.Width Height=80
    * BackColor=RGB(100,100,100) - identificado por BackColor+altura, nunca
    * pelo nome (regra do CLAUDE.md sobre deteccao de cabecalho).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = 769
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 0
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = 769
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 0
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade de arquivos vinculados (grdArquivos legado).
    * grd_4c_Dados: Top=96 Left=5 Width=810 Height=288, 1 coluna (Arquivos).
    * RecordMark/DeleteMark = .F. (regra de form OPERACIONAL). ControlSource/
    * Header1.Caption/Width sao definidos em CarregarLista() (DEPOIS do
    * RecordSource - Problema 2/48, RecordSource reseta ambos).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top             = 96
            .Left            = 5
            .Width           = 810
            .Height          = 288
            .FontName        = "Arial"
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .ReadOnly        = .T.
            .ScrollBars      = 2
            .ColumnCount     = 1
            .GridLineColor   = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle  = 2
            .Visible         = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .FontName   = "Verdana"
            .FontSize   = 8
            .Enabled    = .T.
            .Width      = 778
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .Visible    = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1.Header1
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Arquivos Relacionados [Incluindo Diret" + CHR(243) + ;
                "rio, Caminho de Rede, Mapeamento, etc]"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Legado: grdArquivos.AfterRowColChange - trocar de linha repinta o
        *-- preview da imagem e re-le os tres campos de detalhe. Aqui o uso de
        *-- AfterRowColChange eh o CORRETO (regra #46): nao ha filtro de coluna
        *-- e o que se carrega eh o DETALHE da linha corrente, nao validacao de
        *-- celula digitada - a Column1 eh ReadOnly nos dois sistemas.
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesArquivos - Botoes standalone ao lado da grade (Inserir/
    * Abrir/Excluir/Abrir Diretorio) + os dois shapes decorativos do bloco
    * (shpAlterar/Shape3). Standalone CommandButton com .Picture + Enabled
    * alternavel exige Themes=.T. + DisabledPicture (regra de icone-only nao
    * se aplica aqui - os 4 botoes tem Caption).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesArquivos()
        THIS.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
        WITH THIS.cmd_4c_BtnInsArqs
            .Top             = 96
            .Left            = 833
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Caption         = "Inserir Arquivo"
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
            .Themes          = .T.
            .PicturePosition = 7
            .ToolTipText     = "Inserir Um Link de Arquivo"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")

        THIS.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
        WITH THIS.cmd_4c_BtnOpnArqs
            .Top             = 172
            .Left            = 833
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Caption         = "Abrir Arquivo"
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            .Themes          = .T.
            .PicturePosition = 7
            .ToolTipText     = "Abrir Arquivo (Caso o Computado Suporte)"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")

        THIS.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
        WITH THIS.cmd_4c_BtnExcArqs
            .Top             = 96
            .Left            = 908
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Caption         = "Excluir Arquivo"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .PicturePosition = 7
            .ToolTipText     = "Excluir Um Link de Arquivo (N" + CHR(227) + ;
                "o Apaga o Arquivo Fisicamente)"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")

        THIS.AddObject("cmd_4c_BtnOpnDirs", "CommandButton")
        WITH THIS.cmd_4c_BtnOpnDirs
            .Top             = 172
            .Left            = 908
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Caption         = "Abrir Diret" + CHR(243) + "rio"
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
            .Themes          = .T.
            .PicturePosition = 7
            .ToolTipText     = "Abrir a Pasta Onde o Arquivo Est" + CHR(225) + " Gravado"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnOpnDirs, "Click", THIS, "BtnOpnDirsClick")

        *-- Shapes decorativos do bloco de botoes (shpAlterar/Shape3 legado)
        THIS.AddObject("shp_4c_ShpAlterar", "Shape")
        WITH THIS.shp_4c_ShpAlterar
            .Top           = 113
            .Left          = 822
            .Width         = 25
            .Height        = 31
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top           = 262
            .Left          = 823
            .Width         = 25
            .Height        = 31
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoFechar - cmdBtnForm (CommandGroup Sair/Confirmar) do SCX
    * legado. Buttons(1) = btnSair (Command1 no dump - Cancel=.T., fecha sem
    * gravar) e Buttons(2) = btnConfirmar (Command2 - grava a observacao
    * nao confirmado antes de fechar), na MESMA ordem de criacao do dump.
    *
    * Legado (cmdBtnForm): AutoSize=.T. ButtonCount=2 BackStyle=0
    *   BorderStyle=0 Value=0 Top=-2 Left=840 Width=160 Height=85
    *   SpecialEffect=1 BorderColor=136,189,188 Themes=.F.
    *   Command1 "btnSair": Top=5 Left=80 75x75, Tahoma 8 bold italic,
    *     Picture=cadastro_sair_60.jpg, Cancel=.T., Caption="Sair",
    *     ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
    *   Command2 "btnConfirmar": Top=5 Left=5 75x75, Tahoma 8 bold italic,
    *     Picture=cadastro_salvar_60.jpg, Caption="Confirmar",
    *     ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
    *
    * Os icones sao os do dump e existem em vbmp\ (nao ha palpite por
    * semelhanca semantica - regra #25).
    *
    * CommandGroup NAO tem ForeColor/FontName (regra #33): moram em cada
    * Buttons(N), configurados em WITH ANINHADO (1 nivel sobre collection
    * accessor - excecao segura, nao eh AddObject). A geometria dos botoes
    * vem ANTES da do grupo porque, com AutoSize=.T., eh o conteudo que
    * define o tamanho do grupo (5+75+75+5=160, 5+75+5=85 - bate com o
    * dump).
    *
    * Os dois botoes sao INTERNOS ao CommandGroup (Themes=.F. canonico do
    * Framework) - a regra de Themes=.T.+DisabledPicture eh so para botao
    * STANDALONE icone-only; aqui ambos tem Caption e um deles (Confirmar)
    * ainda recebe DisabledPicture por seguranca, igual ao padrao de
    * FormSigOpCot.
    *
    * btnConfirmar.Enabled eh alternado em AjustarBotoesPorModo (legado:
    * ".cmdBtnForm.btnConfirmar.Enabled = .f." fora de INSERIR/ALTERAR).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoFechar()
        THIS.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
        WITH THIS.cmg_4c_CmdBtnForm
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            *-- Buttons(1) = btnSair (Command1 no dump)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 80
                .Height          = 75
                .Width           = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Cancel          = .T.
                .Caption         = "Sair"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Visible         = .T.
            ENDWITH

            *-- Buttons(2) = btnConfirmar (Command2 no dump)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Caption         = "Confirmar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Visible         = .T.
            ENDWITH

            *-- Geometria do GRUPO depois da dos botoes - AutoSize=.T. usa o
            *-- conteudo para calcular Width/Height (bate com o dump: 160x85)
            .AutoSize = .T.
            .Top      = -2
            .Left     = 840
            .Width    = 160
            .Height   = 85
            .Visible  = .T.
        ENDWITH

        *-- Buttons(1) eh o btnSair do legado, que tem Cancel=.T. - ou seja, eh
        *-- o CANCELAR da tela; o handler canonico eh BtnCancelarClick
        BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.cmg_4c_CmdBtnForm.Buttons(2), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPainelObservacao - Preview da imagem (imgArqJpg legado) +
    * observacao sobre o arquivo corrente (Say31/getObsArqs legado).
    * shp_4c_Shape1: Top=392 Left=8 Width=395 Height=231 - moldura decorativa
    * em volta da area de preview (shp_4c_Shape1/shp_4c_Shape3 legado usam a
    * mesma moldura 3D - CommandButton/Shape nao tem FontName/propriedade de
    * texto, so BorderColor/FillColor - regra #33).
    * img_4c_ImgArqJpg: Top=394 Left=10 Width=391 Height=227, Visible=.F. -
    * so aparece quando a linha corrente da grade aponta para .jpg/.ico/.bmp/
    * .jpeg (grdArquivos.AfterRowColChange legado, fase 7/8). Picture NAO eh
    * ControlSource - eh atribuido em codigo a cada troca de linha.
    * lbl_4c_Label31 (Say31): Top=391 Left=411 - classe say sem Width/
    * Alignment no dump -> AutoSize=.F. + ForeColor=RGB(90,90,90) (regra #12/
    * #23, NUNCA inventar Width+Alignment=1).
    * obj_4c_GetObsArqs (getObsArqs/fwmemo): Top=407 Left=411 Width=580
    * Height=181, ControlSource=cursor_4c_Dados.ObsArqs (coluna TEXT/memo).
    * ReadOnly inicial=.T., alternado em AjustarBotoesPorModo junto com os
    * botoes de manutencao (legado: getObsArqs.When = InList(pcEscolha,
    * "INSERIR","ALTERAR")).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelObservacao()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 392
            .Left          = 8
            .Width         = 395
            .Height        = 231
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("img_4c_ImgArqJpg", "Image")
        WITH THIS.img_4c_ImgArqJpg
            .Top         = 394
            .Left        = 10
            .Width       = 391
            .Height      = 227
            .BackStyle   = 0
            .BorderStyle = 0
            .Stretch     = 1
            .Picture     = ""
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Visible     = .F.
        ENDWITH
        *-- Legado: imgArqJpg.DblClick abre o zoom da imagem corrente
        BINDEVENT(THIS.img_4c_ImgArqJpg, "DblClick", THIS, "ImgArqJpgDblClick")

        THIS.AddObject("lbl_4c_Label31", "Label")
        WITH THIS.lbl_4c_Label31
            .Top       = 391
            .Left      = 411
            .Width     = 162
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o Sobre o Arquivo"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_GetObsArqs", "EditBox")
        WITH THIS.obj_4c_GetObsArqs
            .Top          = 407
            .Left         = 411
            .Width        = 580
            .Height       = 181
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
            .ReadOnly     = .T.
            .ScrollBars   = 2
            .Visible      = .T.
        ENDWITH
        *-- ControlSource NAO vai aqui: este metodo roda ANTES de CarregarLista
        *-- criar cursor_4c_Dados, e ligar ControlSource a alias inexistente
        *-- estoura "Alias 'CURSOR_4C_DADOS' is not found" dentro do TRY do
        *-- InicializarForm - CREATEOBJECT devolveria .F. e a tela nunca
        *-- abriria (regra #41). O vinculo mora em VincularCamposDetalhe(),
        *-- chamado por CarregarLista com o cursor ja existente.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposAuditoria - Campos somente-leitura de quem/quando o
    * vinculo foi incluido (getUsuars/getDatas legado). Enabled=.F. SEMPRE
    * (legado: getUsuars.When/getDatas.When = Return .f. - nao alterna por
    * modo como getObsArqs, por isso NAO entram em AjustarBotoesPorModo).
    * txt_4c_Usuars (getUsuars): Top=595 Left=535 Width=130, ControlSource=
    * cursor_4c_Dados.Usuars.
    * txt_4c_Datas (getDatas): Top=595 Left=772 Width=143, ControlSource=
    * cursor_4c_Dados.Datas.
    * lbl_4c_Label1 (Say1) / lbl_4c_Label2 (Say2): classes say com Width no
    * dump -> AutoSize=.F. + Alignment=0 (regra #23), ForeColor=RGB(90,90,90).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposAuditoria()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 599
            .Left      = 414
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Usu" + CHR(225) + "rio de Inclus" + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Usuars", "TextBox")
        WITH THIS.txt_4c_Usuars
            .Top               = 595
            .Left              = 535
            .Width             = 130
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledForeColor = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Visible           = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 599
            .Left      = 667
            .Width     = 103
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Data de Inclus" + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Datas", "TextBox")
        WITH THIS.txt_4c_Datas
            .Top               = 595
            .Left              = 772
            .Width             = 143
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledForeColor = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Visible           = .T.
        ENDWITH
        *-- Mesma razao do painel de observacao: o ControlSource dos dois
        *-- campos vai em VincularCamposDetalhe(), com o cursor ja criado
        *-- (regra #41).
    ENDPROC

    *==========================================================================
    * VincularCamposDetalhe - Liga os tres campos de detalhe as colunas de
    * cursor_4c_Dados. Fica SEPARADO dos metodos Configurar*: estes rodam no
    * InicializarForm, ANTES de o cursor existir, e ControlSource de alias
    * ausente derruba o Init (medido no VFP9: "Alias 'CURSOR_4C_DADOS' is not
    * found" tanto em TextBox como em EditBox) - regra #41. Chamado por
    * CarregarLista, que eh o unico ponto onde o cursor esta garantido.
    * Idempotente: reatribuir o mesmo ControlSource nao tem efeito colateral.
    *==========================================================================
    PROTECTED PROCEDURE VincularCamposDetalhe()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.obj_4c_GetObsArqs.ControlSource = "cursor_4c_Dados.ObsArqs"
        THIS.txt_4c_Usuars.ControlSource     = "cursor_4c_Dados.Usuars"
        THIS.txt_4c_Datas.ControlSource      = "cursor_4c_Dados.Datas"
    ENDPROC

    *==========================================================================
    * ObterArquivoCorrente - Caminho do arquivo da linha corrente da grade.
    * Equivale ao "lcArq = Alltrim(crSigOpArq.Arquivos)" que o legado repete
    * em grdArquivos.AfterRowColChange, imgArqJpg.DblClick, btnOpnArqs.Click e
    * btnOpnDirs.Click. Devolve "" com o cursor ausente ou em EOF - no legado
    * a leitura em EOF trazia o registro em branco e caia no mesmo guard de
    * Empty(), entao o resultado eh o mesmo.
    *==========================================================================
    PROTECTED PROCEDURE ObterArquivoCorrente()
        LOCAL loc_cArquivo
        loc_cArquivo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cArquivo = ALLTRIM(NVL(cursor_4c_Dados.Arquivos, ""))
        ENDIF

        RETURN loc_cArquivo
    ENDPROC

    *==========================================================================
    * ValidarArquivoSelecionado - Guard "Not Empty(lcArq) And File(lcArq)" que
    * o legado escreve IDENTICO em tres lugares (btnOpnArqs.Click,
    * btnOpnDirs.Click e imgArqJpg.DblClick). Como SigOpArq guarda apenas o
    * ENDERECO do arquivo (caminho de rede/mapeamento), o vinculo pode existir
    * em banco e o arquivo ja ter sido movido ou apagado - por isso o legado
    * testa File() antes de entregar o caminho ao Shell.
    *==========================================================================
    PROTECTED PROCEDURE ValidarArquivoSelecionado(par_cArquivo)
        LOCAL loc_cArquivo
        loc_cArquivo = ALLTRIM(NVL(par_cArquivo, ""))

        RETURN !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
    ENDPROC

    *==========================================================================
    * ValidarExtensaoImagem - Teste de extensao que o legado escreve IDENTICO
    * em grdArquivos.AfterRowColChange e imgArqJpg.DblClick:
    *   InList(Alltrim(Upper(Substr(lcArq, At([.],lcArq), 5))), ;
    *          [.JPG], [.ICO], [.BMP], [.JPEG])
    * Transcrito literalmente, inclusive o At(".") - que pega o PRIMEIRO ponto
    * do caminho, nao o ultimo (regra #17: formula do legado se transcreve, nao
    * se reescreve). O unico acrescimo eh o guard "AT(...) > 0": sem ponto no
    * nome o legado chamaria SUBSTR() com posicao inicial zero, e nome sem
    * ponto nao casa nenhuma das quatro extensoes de qualquer forma - o
    * resultado eh o mesmo em todo caso em que o legado funciona.
    *==========================================================================
    PROTECTED PROCEDURE ValidarExtensaoImagem(par_cArquivo)
        LOCAL loc_cArquivo, loc_nPonto, loc_cExtensao
        loc_cArquivo = ALLTRIM(NVL(par_cArquivo, ""))

        IF EMPTY(loc_cArquivo)
            RETURN .F.
        ENDIF

        loc_nPonto = AT(".", loc_cArquivo)
        IF loc_nPonto <= 0
            RETURN .F.
        ENDIF

        loc_cExtensao = ALLTRIM(UPPER(SUBSTR(loc_cArquivo, loc_nPonto, 5)))

        RETURN INLIST(loc_cExtensao, ".JPG", ".ICO", ".BMP", ".JPEG")
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - grdArquivos.AfterRowColChange do legado: ao
    * trocar de linha, repinta o preview da imagem e re-le os tres campos de
    * detalhe ligados por ControlSource (txt_4c_Usuars/txt_4c_Datas criados
    * nesta fase e obj_4c_GetObsArqs criado na fase 5). Sem este handler os
    * campos ficam parados no primeiro registro e o preview nunca aparece -
    * popular o cursor nao repinta controle vinculado sozinho (regra #21).
    *
    * par_nColIndex eh declarado porque BINDEVENT exige a assinatura do evento
    * (regra #3), e NAO eh usado como filtro de proposito: o legado tambem nao
    * filtra, e o uso correto de AfterRowColChange eh exatamente este - carregar
    * o detalhe da linha corrente (regra #46).
    *
    * O teste de exibicao eh so a extensao, sem File(), igual ao legado: o
    * legado reserva o File() para o DblClick do zoom. Picture apontando para
    * arquivo inexistente nao estoura em VFP9 - apenas nao desenha (regra #25).
    * PUBLIC porque eh alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            *-- Sem linha corrente nao ha detalhe a exibir: limpar o painel em
            *-- vez de deixa-lo parado no registro que acabou de sair da grade
            *-- (acontece com a lista vazia e depois de excluir o ultimo
            *-- vinculo).
            THIS.LimparCampos()
            RETURN
        ENDIF

        *-- Carga do registro corrente no BO: eh ele que alimenta o painel de
        *-- detalhe (cursor -> BO -> controles), para a tela e a gravacao lerem
        *-- a MESMA fonte. CarregarDoCursor eh PUBLIC no BO (regra #51).
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        ENDIF

        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * ImgArqJpgDblClick - imgArqJpg.DblClick do legado:
    *   If Not Empty(lcArq) And File(lcArq) And InList(<extensao>, ...)
    *       Do Form SigOpZom With lcArq, [Arquivo : ] + lcArq
    *   EndIf
    * As duas condicoes viram as duas validacoes desta fase. PUBLIC porque eh
    * alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE ImgArqJpgDblClick()
        LOCAL loc_cArquivo
        loc_cArquivo = THIS.ObterArquivoCorrente()

        IF THIS.ValidarArquivoSelecionado(loc_cArquivo) AND ;
           THIS.ValidarExtensaoImagem(loc_cArquivo)
            THIS.AbrirFormZoomImagem(loc_cArquivo)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirFormZoomImagem - "Do Form SigOpZom With lcArq, [Arquivo : ] + lcArq"
    * do legado. DO FORM procura um .SCX, que nao existe no projeto novo (os
    * forms sao DEFINE CLASS em .prg), entao o dialogo filho eh aberto com
    * CREATEOBJECT do nome LITERAL - assim a classe tambem entra no indice de
    * carga sob demanda do config.prg.
    *
    * SigOpZom esta FORA do escopo desta task e ainda nao foi migrado: o
    * CREATEOBJECT vai guardado e a ausencia eh AVISADA ao usuario, em vez de
    * estourar "Class definition ... is not found". Quando o modulo for
    * migrado esta chamada passa a funcionar sem nenhuma alteracao aqui (mesmo
    * tratamento de FormSigMvSbn.AbrirFormZoomImagem).
    *
    * Show() fica FORA do TRY: form modal chamado dentro de TRY faz qualquer
    * erro de runtime da tela filha cair no CATCH do pai, derrubando a
    * referencia LOCAL e fechando a janela sozinha (regra #29).
    *==========================================================================
    PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo)
        LOCAL loc_oForm, loc_oErro

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, ;
                "Arquivo : " + ALLTRIM(par_cArquivo))
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + ;
                CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta " + ;
                "vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Popula cursor_4c_Dados via BO.Buscar(fkChaves) e
    * reconfigura RecordSource/ControlSource do grid. Width e Header1.Caption
    * sao reaplicados DEPOIS do RecordSource (Problema 2/48 - RecordSource
    * reseta ambos). GO TOP + Refresh no fim (regra #21/#48 - popular cursor
    * nao repinta a grade sozinho). PUBLIC - chamado direto pelo
    * TesteAutomatico (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cArqChaves)
        ENDIF

        IF loc_lSucesso AND USED("cursor_4c_Dados")
            THIS.grd_4c_Dados.RecordSource = ""
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.Arquivos"

            THIS.grd_4c_Dados.Column1.Width = 778
            THIS.grd_4c_Dados.Column1.Header1.Caption = "Arquivos Relacionados [Incluindo " + ;
                "Diret" + CHR(243) + "rio, Caminho de Rede, Mapeamento, etc]"

            *-- Vinculo dos campos de detalhe: aqui o cursor existe (regra #41)
            THIS.VincularCamposDetalhe()

            SELECT cursor_4c_Dados
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Transcricao do guard do Init legado:
    *
    *   If Not InList(.pcEscolha, [INSERIR], [ALTERAR])
    *       .shpAlterar.Visible = .f.
    *       .btnInsArqs.Visible = .f.
    *       .btnExcArqs.Visible = .f.
    *       .cmdBtnForm.btnConfirmar.Enabled = .f.
    *   EndIf
    *
    * Inserir/Excluir (e o shape decorativo shpAlterar ao lado deles) ficam
    * OCULTOS (Visible, nao so Enabled) fora do modo de manutencao - o
    * legado esconde, nao apenas desabilita. Confirmar fica DESABILITADO
    * (Enabled), nao oculto - o legado so cita .Enabled para esse botao.
    * Abrir Arquivo/Abrir Diretorio ficam sempre ativos (When = .T. no
    * legado) e shp_4c_Shape3 nunca eh citado no guard - nenhum dos dois
    * entra aqui. O campo de observacao (getObsArqs) segue o MESMO guard
    * (getObsArqs.When legado). PUBLIC - chamado direto pelo TesteAutomatico
    * (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPermiteManutencao
        loc_lPermiteManutencao = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        THIS.shp_4c_ShpAlterar.Visible            = loc_lPermiteManutencao
        THIS.cmd_4c_BtnInsArqs.Visible             = loc_lPermiteManutencao
        THIS.cmd_4c_BtnExcArqs.Visible             = loc_lPermiteManutencao
        THIS.cmg_4c_CmdBtnForm.Buttons(2).Enabled  = loc_lPermiteManutencao

        *-- A parte EDITAVEL fica num lugar so (HabilitarCampos), para o modo
        *-- nao ser decidido em dois lugares que podem divergir.
        THIS.HabilitarCampos(loc_lPermiteManutencao)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga a superficie EDITAVEL da tela. Neste form
    * ela eh uma so: o EditBox de observacao (getObsArqs legado, cujo
    * "When = InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])" eh exatamente
    * este guard). Os dois campos de auditoria (txt_4c_Usuars/txt_4c_Datas)
    * NAO entram: o legado os trava com "When -> Return .f." em todo modo, sem
    * alternar - por isso nascem Enabled=.F. no Configurar* e ficam assim.
    * A grade tambem nao: Column1.Text1.When do legado tambem eh "Return .f."
    * (o caminho do arquivo se escolhe no GETFILE, nao se digita na celula).
    *
    * Ponto UNICO de decisao, chamado por AjustarBotoesPorModo - que eh quem
    * conhece o modo (this_cEscolha). PUBLIC: chamado pelo harness de teste
    * automatico, que invoca os metodos de fora da classe (regra #3).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        *-- Parametro LOGICO omitido chega como .F. em VFP9; PCOUNT() distingue
        *-- "chamou sem argumento" de "pediu desabilitar"
        loc_lHabilitar = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", ;
            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"), par_lHabilitar)

        THIS.obj_4c_GetObsArqs.ReadOnly = !loc_lHabilitar

        RETURN loc_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera o painel de detalhe (preview + os tres campos
    * ligados por ControlSource) quando NAO ha linha corrente na grade: lista
    * vazia na abertura, ou exclusao do ultimo vinculo. Sem isto o painel fica
    * parado no registro que acabou de sair da grade - o usuario exclui o
    * arquivo, ve a grade esvaziar e continua lendo a observacao e o preview
    * dele (nao ha erro, nao ha log: so o dado errado na tela).
    *
    * O preview eh apagado em codigo (Picture nao eh ControlSource - eh
    * atribuido a cada troca de linha, legado grdArquivos.AfterRowColChange).
    * Os tres campos de detalhe sao ligados por ControlSource, entao em EOF
    * basta o Refresh que o legado ja fazia - atribuir .Value neles escreveria
    * DE VOLTA no cursor.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE LimparCampos"
    * e o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever sem o
    * modificador nao torna o metodo publico, so esconde que ele continua
    * protegido (medido no VFP9: PEMSTATUS(oForm,"LimparCampos",2) = .T. mesmo
    * sem o PROTECTED escrito, e a chamada de fora estoura "Property
    * LIMPARCAMPOS is not found"). Chamado so por THIS., de dentro da classe.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        *-- Legado: "Clear Resources" antes de trocar o Picture - libera a
        *-- imagem anterior do cache do VFP (sem isso o arquivo fica preso em
        *-- disco e uma troca de conteudo nao eh relida).
        CLEAR RESOURCES

        THIS.img_4c_ImgArqJpg.Picture = ""
        THIS.img_4c_ImgArqJpg.Visible = .F.

        *-- Legado: getDatas.Refresh / getUsuars.Refresh / getObsArqs.Refresh
        THIS.txt_4c_Usuars.Refresh()
        THIS.txt_4c_Datas.Refresh()
        THIS.obj_4c_GetObsArqs.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere o registro corrente da TELA para o Business
    * Object. Direcao form -> BO, usada por SalvarDados antes de gravar.
    *
    * O unico campo que o usuario edita eh a observacao (obj_4c_GetObsArqs):
    * ele eh lido do CONTROLE, nao do cursor, para capturar tambem a digitacao
    * que ainda nao foi descarregada pelo ControlSource (o clique em Confirmar
    * costuma tirar o foco e descarregar, mas confirmar por tecla nao) - e o
    * valor eh devolvido ao cursor com REPLACE, que eh o equivalente do
    * .poDataMgr.Update([crSigOpArq]) do legado empurrando o buffer.
    *
    * pkChaves / fkChaves / Arquivos / Usuars / Datas vem do CURSOR, nao dos
    * controles: sao somente-exibicao (o legado trava os tres com When->.f.) e
    * ler Datas do TextBox devolveria o tipo do controle, nao o DATETIME da
    * coluna - TTOD/comparacao com DATE estouraria erro 11 em runtime
    * (regra #16). A coluna do cursor eh garantidamente datetime.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
    * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
    * LimparCampos, acima). Chamado so por THIS.SalvarDados, de dentro da
    * classe - nada de fora precisa dele.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_cObs
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados") ;
           AND !EOF("cursor_4c_Dados")

            SELECT cursor_4c_Dados
            loc_cObs = TratarNulo(THIS.obj_4c_GetObsArqs.Value, "")

            *-- Descarrega a observacao digitada no cursor. O guard de
            *-- ReadOnly evita REPLACE em cursor nao gravavel (o BO ja entrega
            *-- cursor_4c_Dados READWRITE) e o de diferenca evita marcar a
            *-- linha quando nada mudou.
            IF !ISREADONLY("cursor_4c_Dados") ;
               AND TratarNulo(cursor_4c_Dados.ObsArqs, "") != loc_cObs
                REPLACE cursor_4c_Dados.ObsArqs WITH loc_cObs
            ENDIF

            WITH THIS.this_oBusinessObject
                .this_cPkChaves = ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, ""))
                .this_cArquivos = ALLTRIM(TratarNulo(cursor_4c_Dados.Arquivos, ""))
                .this_cObsArqs  = loc_cObs
                .this_cUsuars   = ALLTRIM(TratarNulo(cursor_4c_Dados.Usuars, ""))
                .this_dDatas    = TratarNulo(cursor_4c_Dados.Datas, {})

                *-- fkChaves eh a chave de amarracao que o form PAI passou no
                *-- Init: o cursor so a traz nas linhas ja gravadas, entao o
                *-- valor do form eh o fallback (nunca gravar em branco - eh a
                *-- coluna que liga o arquivo ao registro do pai).
                .this_cFkChaves = ALLTRIM(TratarNulo(cursor_4c_Dados.fkChaves, ""))
                IF EMPTY(.this_cFkChaves)
                    .this_cFkChaves = THIS.this_cArqChaves
                ENDIF
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere o registro do Business Object para a TELA.
    * Direcao BO -> form, usada por GradeAfterRowColChange a cada troca de
    * linha da grade e depois de incluir um vinculo novo.
    *
    * Os tres campos de detalhe sao ligados por ControlSource a
    * cursor_4c_Dados: a forma CERTA de "por o BO na tela" eh garantir o valor
    * no cursor e dar Refresh (atribuir .Value neles escreveria de volta no
    * cursor pelo ControlSource, e em coluna datetime/memo isso acabaria em
    * divergencia de tipo). O unico ajuste necessario eh o do legado -
    * "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])": coluna TEXT nula
    * chega ao EditBox como .NULL. e aparece assim para o usuario.
    *
    * O preview da imagem NAO tem ControlSource - eh atribuido em codigo, com
    * o mesmo criterio do legado (so a extensao, SEM File(): o legado reserva
    * o File() para o DblClick do zoom, e Picture apontando para arquivo
    * inexistente nao estoura em VFP9, apenas nao desenha - regra #25).
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm"
    * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
    * LimparCampos, acima). Chamado so por THIS.GradeAfterRowColChange, de
    * dentro da classe - nada de fora precisa dele.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.LimparCampos()
        ELSE
            SELECT cursor_4c_Dados

            *-- Legado: "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])"
            IF ISNULL(cursor_4c_Dados.ObsArqs) ;
               AND !ISREADONLY("cursor_4c_Dados")
                REPLACE cursor_4c_Dados.ObsArqs WITH ""
            ENDIF

            *-- Preview: o caminho vem do BO quando ele esta carregado (fonte
            *-- unica com a gravacao), e do cursor quando nao esta.
            IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
               AND !EMPTY(ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, "")))
                loc_cArquivo = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, ""))
            ELSE
                loc_cArquivo = THIS.ObterArquivoCorrente()
            ENDIF

            CLEAR RESOURCES

            THIS.img_4c_ImgArqJpg.Picture = ""
            THIS.img_4c_ImgArqJpg.Visible = .F.

            IF THIS.ValidarExtensaoImagem(loc_cArquivo)
                THIS.img_4c_ImgArqJpg.Picture = loc_cArquivo
                THIS.img_4c_ImgArqJpg.Visible = .T.
            ENDIF

            *-- Legado: getDatas.Refresh / getUsuars.Refresh / getObsArqs.Refresh
            THIS.txt_4c_Usuars.Refresh()
            THIS.txt_4c_Datas.Refresh()
            THIS.obj_4c_GetObsArqs.Refresh()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarDados - "salvardados" PROCEDURE do legado SIGOPDOC.SCX:
    *
    *   Local llOks
    *   llOks = .t.
    *   If Not ThisForm.poDataMgr.Update([crSigOpArq])
    *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *       llOks = .f.
    *   EndIf
    *   If llOks And (ThisForm.poDataMgr.Commit() < 1)
    *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *       llOks = .f.
    *   EndIf
    *   If Not llOks
    *       ThisForm.poDataMgr.RollBack()
    *   EndIf
    *   Return llOks
    *
    * O legado liga crSigOpArq a um cursor COM BUFFERING (.AddCursor): os
    * Inserts/Deletes de btnInsArqs/btnExcArqs so editam o buffer local, e
    * eh aqui - no clique de Confirmar - que .Update()/.Commit() de fato
    * grava tudo no SQL Server (desfazendo com .RollBack() se falhar).
    *
    * Na arquitetura nova esse buffering nao existe: BtnInsArqsClick/
    * BtnExcArqsClick ja gravam direto via BO.Inserir()/BO.Excluir() (fase
    * 4 - "equivalente ao legado, mas gravando direto"). O que continua
    * sujeito a confirmacao explicita eh a edicao do campo Observacao
    * (obj_4c_GetObsArqs), ligado por ControlSource a cursor_4c_Dados - um
    * cursor LOCAL (populado por SQLEXEC), desconectado do servidor: editar
    * ali muda o cursor na memoria, nao a tabela. Varrer o cursor e
    * empurrar cada linha para SigOpArq via BO.Atualizar() (que grava
    * Arquivos/ObsArqs/Usuars/Datas - regra #41-like, cada UPDATE confirma
    * por si so) eh o equivalente funcional do Update()/Commit() do legado.
    *
    * BO.Atualizar() ja exibe o proprio MsgErro com o texto do SQL Server em
    * caso de falha (igual a Inserir/Excluir/ExecutarExclusao) - nao
    * duplicar a mensagem aqui (regra #20: falha de gravacao ja eh
    * reportada por quem grava).
    *
    * PUBLIC: chamado por BtnConfirmarClick (BINDEVENT) e pelo harness.
    *==========================================================================
    PROCEDURE SalvarDados()
        LOCAL loc_lSucesso, loc_nRegistro

        loc_lSucesso = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados

            *-- FormParaBO primeiro, na linha CORRENTE: eh ele que descarrega
            *-- no cursor a observacao que esta na tela e ainda pode nao ter
            *-- passado pelo ControlSource (confirmar por tecla nao tira o foco
            *-- do EditBox). Sem isto a ultima digitacao do usuario se perde
            *-- SEM aviso - ele ve "salvo com sucesso" e o texto nao foi.
            THIS.FormParaBO()

            *-- O SCAN mexe no ponteiro; guardar para devolver a grade a linha
            *-- em que o usuario estava (COUNT/SCAN tem de repor o RECNO).
            loc_nRegistro = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))

            SELECT cursor_4c_Dados
            SCAN
                IF !(THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados") AND ;
                     THIS.this_oBusinessObject.Atualizar())
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            SELECT cursor_4c_Dados
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT("cursor_4c_Dados")
                GO loc_nRegistro
            ELSE
                GO TOP
            ENDIF

            *-- Repor o BO na linha corrente: o SCAN deixou nele o ULTIMO
            *-- registro do cursor, e quem ler o BO depois disso (BOParaForm,
            *-- auditoria) veria o registro errado.
            THIS.FormParaBO()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - btnSair.Click do legado ("ThisForm.Release"), que eh
    * o CANCELAR desta tela: o botao tem Cancel=.T. no SCX (o ESC aciona este
    * handler) e fecha SEM gravar a observacao digitada.
    *
    * NAO desfazer nada a mais: no legado crSigOpArq eh um cursor com
    * buffering que simplesmente nunca sofre Update()/Commit() por este
    * caminho; aqui cursor_4c_Dados eh local e eh liberado no Destroy, entao
    * fechar a tela ja descarta as edicoes nao confirmadas - o mesmo efeito do
    * .RollBack() do legado. As inclusoes e exclusoes de vinculo NAO sao
    * desfeitas porque elas ja gravaram direto (BtnInsArqsClick/
    * BtnExcArqsClick via BO.Inserir()/BO.Excluir()).
    * PUBLIC: chamado por BINDEVENT (regra #3) e pelo harness.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSairClick - Nome do OBJETO no legado (btnSair). Mantido como ponto de
    * entrada para quem referencia o nome do legado; a logica mora em
    * BtnCancelarClick, que eh o nome canonico desta acao no sistema novo.
    * PUBLIC: alvo de BINDEVENT (regra #3) e do harness de teste automatico.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - btnConfirmar.Click do legado:
    *
    *   If ThisForm.SalvarDados()
    *       ThisForm.Release
    *   Else
    *       Return .f.
    *   EndIf
    *
    * SalvarDados() ja exibe o proprio erro em caso de falha (via
    * BO.Atualizar) - retornar .F. aqui apenas mantem a tela aberta para o
    * usuario corrigir e tentar de novo, igual ao legado.
    * PUBLIC: chamado por BINDEVENT (regra #3) e pelo harness.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        IF THIS.SalvarDados()
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnInsArqsClick - Seleciona um arquivo via GETFILE() e grava o vinculo
    * (equivalente ao "Insert Into crSigOpArq" do legado, mas gravando direto
    * via BO.Inserir()). Recarrega a grade e posiciona no registro incluido.
    *==========================================================================
    PROCEDURE BtnInsArqsClick()
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
            "Sele" + CHR(231) + CHR(227) + "o de Arquivos")

        IF !EMPTY(loc_cArquivo)
            THIS.this_oBusinessObject.this_cPkChaves = ""
            THIS.this_oBusinessObject.this_cFkChaves = THIS.this_cArqChaves
            THIS.this_oBusinessObject.this_cArquivos = UPPER(loc_cArquivo)
            THIS.this_oBusinessObject.this_cObsArqs  = ""
            THIS.this_oBusinessObject.this_cUsuars   = ""
            THIS.this_oBusinessObject.this_dDatas    = {}

            IF THIS.this_oBusinessObject.Inserir()
                THIS.CarregarLista()
                IF USED("cursor_4c_Dados")
                    *-- Posiciona na linha recem-incluida (pela PK que o BO
                    *-- acabou de gerar), nao no fim do cursor: a lista nao
                    *-- volta do banco necessariamente na ordem de inclusao.
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, "")) == ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)
                    IF !FOUND()
                        GO BOTTOM
                    ENDIF
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                *-- Repintar o painel de detalhe TAMBEM aqui: a grade acabou de
                *-- ser reposicionada e Grid.Refresh nao dispara
                *-- AfterRowColChange (regra #21 - o metodo unico roda em todo
                *-- caminho que popula/reposiciona o cursor).
                THIS.GradeAfterRowColChange(1)
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOpnArqsClick - Abre o arquivo da linha corrente da grade via Shell
    * (equivalente ao legado, que usava Shell.Application.Open()).
    *==========================================================================
    PROCEDURE BtnOpnArqsClick()
        LOCAL loc_cArquivo, loc_oApp
        loc_cArquivo = THIS.ObterArquivoCorrente()

        IF THIS.ValidarArquivoSelecionado(loc_cArquivo)
            loc_oApp = CREATEOBJECT("Shell.Application")
            loc_oApp.Open(loc_cArquivo)
        ELSE
            MsgAviso("Arquivo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcArqsClick - Remove o vinculo do arquivo corrente (via BO.Excluir -
    * PUBLIC, regra #51). NAO apaga o arquivo fisico, so o vinculo em
    * SigOpArq (equivalente ao "Delete In crSigOpArq" do legado).
    *==========================================================================
    PROCEDURE BtnExcArqsClick()
        LOCAL loc_lConfirma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + ;
            CHR(237) + "nculo deste arquivo?" + CHR(13) + ;
            "(O arquivo f" + CHR(237) + "sico N" + CHR(227) + "O ser" + CHR(225) + ;
            " apagado)", "Confirmar")

        IF loc_lConfirma
            THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkChaves)

            IF THIS.this_oBusinessObject.Excluir()
                THIS.CarregarLista()
                *-- Mesma razao do BtnInsArqsClick: a linha que o painel de
                *-- detalhe exibia acabou de desaparecer (regra #21).
                THIS.GradeAfterRowColChange(1)
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOpnDirsClick - Abre o diretorio (JUSTPATH) onde o arquivo corrente
    * esta gravado, via Shell (equivalente ao legado).
    *==========================================================================
    PROCEDURE BtnOpnDirsClick()
        LOCAL loc_cArquivo, loc_oApp
        loc_cArquivo = THIS.ObterArquivoCorrente()

        IF THIS.ValidarArquivoSelecionado(loc_cArquivo)
            loc_oApp = CREATEOBJECT("Shell.Application")
            loc_oApp.Open(JUSTPATH(loc_cArquivo))
        ELSE
            MsgAviso("Arquivo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda a
    * hierarquia. Form flat sem containers flutuantes, portanto sem lista de
    * skip (a imagem de preview - imgArqJpg/img_4c_ImgArqJpg - nasce oculta
    * de proposito e sera tratada na fase que a criar).
    *==========================================================================
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

    *==========================================================================
    * Destroy - Libera o cursor de dados e o Business Object. DODEFAULT no
    * fim (FormBase.Destroy reconstroi o menu principal apos form modal).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDocBO.prg):
*==============================================================================
* SigOpDocBO.prg - Business Object para Relacao de Arquivos e Documentos
* Form OPERACIONAL - dialogo filho instanciado com DO FORM SigOpDoc WITH
* par_cChave, par_cEscolha (legado: Lparameters pKey, pEsc)
* Legado: SIGOPDOC.SCX
* Tabela principal: SigOpArq | PK: pkChaves (gerada por fUniqueIds())
* Chave de amarracao (fkChaves): recebida do form pai - EmpDopNums, CPros,
* IClis, etc., conforme a tela que abriu este dialogo
*==============================================================================

DEFINE CLASS SigOpDocBO AS BusinessBase

    *-- Propriedades de SigOpArq (registro corrente da grade de arquivos)
    this_cPkChaves = ""    && pkChaves  CHAR(20) NOT NULL - chave primaria (fUniqueIds)
    this_cFkChaves = ""    && fkChaves  CHAR(30)          - chave de amarracao ao registro pai
    this_cArquivos = ""    && Arquivos  CHAR(250) NOT NULL - caminho/nome do arquivo vinculado
    this_cObsArqs  = ""    && ObsArqs   TEXT             - observacao sobre o arquivo
    this_cUsuars   = ""    && Usuars    CHAR(10) NOT NULL - usuario que incluiu o vinculo
    this_dDatas    = {}    && Datas     DATETIME          - data/hora de inclusao do vinculo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigOpArq"
        THIS.this_cCampoChave = "pkChaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (pkChaves) para uso em
    * RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cPkChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas de SigOpArq (vindas do
    * cursor crSigOpArq/cursor_4c_Dados, uma linha = um arquivo vinculado)
    * para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #9 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cPkChaves = TratarNulo(pkChaves, "")
                THIS.this_cFkChaves = TratarNulo(fkChaves, "")
                THIS.this_cArquivos = TratarNulo(Arquivos, "")
                THIS.this_cObsArqs  = TratarNulo(ObsArqs, "")
                THIS.this_cUsuars   = TratarNulo(Usuars, "")
                THIS.this_dDatas    = TratarNulo(Datas, {})

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista os arquivos vinculados a chave de amarracao recebida do
    * form pai (fkChaves). Retorna cursor_4c_Dados com pkChaves/fkChaves/
    * Arquivos/ObsArqs/Usuars/Datas (regra #42 - chave char(30), PADR ao
    * montar o WHERE, nunca ALLTRIM nas partes). Equivalente a
    * "Select * From SigOpArq Where fkChaves = Padr(pKey, 30)" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), fkChaves C(30), ;
                        Arquivos C(250), ObsArqs M, Usuars C(10), Datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
                loc_cSQL = loc_cSQL + " FROM SigOpArq"
                loc_cSQL = loc_cSQL + " WHERE fkchaves = " + ;
                    EscaparSQL(PADR(ALLTRIM(NVL(par_cChave, "")), 30))

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    *-- Cursor de SQL pass-through nasce SOMENTE-LEITURA. O
                    *-- EditBox da observacao (getObsArqs) esta ligado a este
                    *-- cursor por ControlSource: sem READWRITE ele nao aceita
                    *-- uma tecla sequer e SalvarDados nunca teria o que gravar
                    *-- - e nao ha erro nenhum na tela, so o campo inerte.
                    *-- O legado liga crSigOpArq por .AddCursor (cursor COM
                    *-- buffering, gravavel - a prova esta no proprio Init,
                    *-- que faz "Update crSigOpArq Set ObsArqs = ..."), entao
                    *-- converter para READWRITE eh o que REPRODUZ o legado.
                    *-- SQLEXEC vai para alias TEMPORARIO porque derrubar o
                    *-- alias ligado ao Grid zera o ColumnCount.
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    *-- Legado, logo depois do Requery: "Update crSigOpArq Set
                    *-- ObsArqs = Nvl(ObsArqs, [])". Sem isto a coluna TEXT
                    *-- nula chega ao EditBox como .NULL. e eh isso que o
                    *-- usuario le na tela.
                    SELECT cursor_4c_Dados
                    SCAN FOR ISNULL(cursor_4c_Dados.ObsArqs)
                        REPLACE cursor_4c_Dados.ObsArqs WITH ""
                    ENDSCAN

                    *-- Legado: "Go Top In crSigOpArq"
                    SELECT cursor_4c_Dados
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar os arquivos vinculados:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo vinculo de arquivo em SigOpArq.
    * PK (pkChaves) gerada via fUniqueIds() se ainda nao preenchida -
    * equivalente a "fUniqueIds()" do btnInsArqs.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Usuars/Datas = usuario e data/hora da inclusao do vinculo
            *-- (equivalente a "Usuar, Datetime()" do legado)
            IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuars, "")))
                THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpArq ("
            loc_cSQL = loc_cSQL + "pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkChaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cFkChaves, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza vinculo de arquivo existente em SigOpArq
    * (por pkChaves). fkChaves nao muda depois de gravado - o UPDATE cobre
    * apenas os campos que a tela permite editar (Arquivos, ObsArqs).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpArq SET"
            loc_cSQL = loc_cSQL + " arquivos = " + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + " obsarqs = " + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas)
            loc_cSQL = loc_cSQL + " WHERE pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o vinculo de arquivo corrente de SigOpArq
    * (por pkChaves). PROTECTED (regra #51 - de fora sempre Excluir()).
    * Equivalente a "Delete In crSigOpArq" do btnExcArqs.Click legado, mas
    * gravando a exclusao direto no SQL Server (nao ha mais commit em lote).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                    " v" + CHR(237) + "nculo de arquivo selecionado para excluir."
            ELSE
                loc_cSQL = "DELETE FROM SigOpArq WHERE pkchaves = " + ;
                    EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

                IF USED("cursor_4c_Delete")
                    USE IN cursor_4c_Delete
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir o v" + CHR(237) + "nculo do arquivo:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

