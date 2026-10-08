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
[2026-10-07 00:45:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 00:45:56] [INFO] Config FPW: (nao fornecido)
[2026-10-07 00:45:56] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 00:45:56] [INFO] Timeout: 300 segundos
[2026-10-07 00:45:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kwm0pzjl.prg
[2026-10-07 00:45:56] [INFO] Conteudo do wrapper:
[2026-10-07 00:45:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGmi', 'C:\4c\tasks\task619\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGmi', 'C:\4c\tasks\task619\logs\06_testForm.log'
QUIT

[2026-10-07 00:45:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kwm0pzjl.prg
[2026-10-07 00:45:56] [INFO] VFP output esperado em: C:\4c\tasks\task619\vfp_output.txt
[2026-10-07 00:45:56] [INFO] Executando Visual FoxPro 9...
[2026-10-07 00:45:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kwm0pzjl.prg
[2026-10-07 00:45:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kwm0pzjl.prg
[2026-10-07 00:45:56] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGmi
Inicio: 07/10/2026 00:45:56

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 00:49:07
Duracao: 191 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 00:49:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 00:49:07] [INFO] VFP9 finalizado em 190.6702114 segundos
[2026-10-07 00:49:07] [INFO] Exit Code: 
[2026-10-07 00:49:07] [INFO] 
[2026-10-07 00:49:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 00:49:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kwm0pzjl.prg
[2026-10-07 00:49:07] [INFO] 
[2026-10-07 00:49:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 00:49:07] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 00:49:07] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 00:49:07] [INFO] * Parameters: 'FormSigPrGmi', 'C:\4c\tasks\task619\logs\06_testForm.log'
[2026-10-07 00:49:07] [INFO] 
[2026-10-07 00:49:07] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 00:49:07] [INFO] SET SAFETY OFF
[2026-10-07 00:49:07] [INFO] SET RESOURCE OFF
[2026-10-07 00:49:07] [INFO] SET TALK OFF
[2026-10-07 00:49:07] [INFO] SET NOTIFY OFF
[2026-10-07 00:49:07] [INFO] SYS(2335, 0)
[2026-10-07 00:49:07] [INFO] 
[2026-10-07 00:49:07] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGmi', 'C:\4c\tasks\task619\logs\06_testForm.log'
[2026-10-07 00:49:07] [INFO] QUIT
[2026-10-07 00:49:07] [INFO] 
[2026-10-07 00:49:07] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 00:49:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg):
*==============================================================================
* FormSigPrGmi.prg - Geracao de Pedido de Estoque Minimo
*==============================================================================
* Herda de: FormBase
* BO: SigPrGmiBO
* Legado: SIGPRGMI.SCX
* Tipo: OPERACIONAL (form PLANO sem PageFrame: os 23 objetos do dump sao
*       filhos diretos de SIGPRGMI ou de cntSombra - sem Pagina.Lista/Dados)
*
* Tela de CRITERIOS para geracao de pedido de estoque minimo (Empresa/Grupo
* de Estoque/Conta de Estoque/Linha de Producao/Somente Negativos/Data de
* Geracao). Nao ha cadastro de registro unico nem grade na tela - o botao
* Processar (SigPrGmiBO.Inserir, ja implementado nas Fases 1-2) dispara a
* geracao de pedidos (SigMvCab/SigMvItn) a partir dos criterios informados.
* Aberto diretamente via menu.prg (nao recebe form pai, diferente de
* FormSigPrGlp/FormSigPrGlx).
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
* InicializarForm, cabecalho cnt_4c_Sombra). Fase 4 - shp_4c_Shape1 +
* botoes de acao cmd_4c_Processa/cmd_4c_Encerrar (sem grid/CRUD, legado nao
* tem grade). Fase 5 - primeira metade dos campos de criterio (as 3
* primeiras linhas da tela: Empresa, Grupo de Estoque e Conta de Estoque =
* 6 dos 10 TextBox do legado) + AjustarOrdemTabulacao() com o TabIndex do
* SCX. Roteiro das proximas fases em ConfigurarPageFrame().
*==============================================================================

DEFINE CLASS FormSigPrGmi AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRGMI.SCX: Width=800, Height=292 - dump de
    * layout.json. Botoes Cancela/Processa classe "fwbtng" chegam a
    * Left=723/648 sem Width/Height proprios no dump (herdados da classe) -
    * com Width=75 canonico do projeto, Cancela (723+75=798) encaixa dentro
    * dos 800px do form, confirmando o tamanho padrao de botao do framework)
    *--------------------------------------------------------------------------
    Width        = 800
    Height       = 292
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo"

    *--------------------------------------------------------------------------
    * Init - Cria o Business Object ANTES do DODEFAULT(), para que
    * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
    * encontre pronto.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGmiBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Gera" + CHR(231) + CHR(227) + "o de Pedido de " + ;
                "Estoque M" + CHR(237) + "nimo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - form standalone (sem form pai para reabilitar); encadeia
    * direto para FormBase.Destroy() (libera this_oBusinessObject e
    * restaura o menu principal).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Business Object ja foi criado em Init(); aqui monta
    * a moldura visual (fundo + cabecalho). Os campos, botoes de acao e
    * eventos entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGmiBO.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Data de Geracao nasce com o default do Init legado
                *-- (Date() - 7), e os demais criterios em branco
                THIS.BOParaForm()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGmi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGMI nao
    * tem PageFrame no legado (layout flat) - o nome do metodo eh mantido
    * apenas como ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGlp/FormSigPrGlo).
    *
    * Historico de montagem (migracao multi-fase, todas CONCLUIDAS):
    *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
    *   Fase 4 (feita) - ConfigurarBotoesAcao(): shp_4c_Shape1 decorativo +
    *                     os 2 botoes de acao standalone (cmd_4c_Processa/
    *                     cmd_4c_Encerrar) - este form NAO tem grid nem
    *                     PageFrame de Lista/Dados (zero grades no dump).
    *                     BINDEVENT dos dois botoes registrado no fim do
    *                     proprio ConfigurarBotoesAcao (os handlers
    *                     BtnProcessaClick/BtnEncerrarClick existem)
    *   Fase 5 (feita) - ConfigurarCamposCriteriosParte1(): as 3 PRIMEIRAS
    *                     linhas de criterio do legado - Empresa
    *                     (txt_4c__cd_empresa/txt_4c__ds_empresa), Grupo de
    *                     Estoque (txt_4c__Cd_GrEstoque/txt_4c__Ds_GrEstoque)
    *                     e Conta de Estoque (txt_4c__cd_estoque/
    *                     txt_4c__ds_estoque) = 6 dos 10 TextBox do dump.
    *                     Mais AjustarOrdemTabulacao() com o TabIndex 2..7
    *                     que o SCX declara para esses campos
    *   Fase 6 (feita) - as 3 linhas restantes: Linha de Producao
    *                     (txt_4c_Linha/txt_4c_DLinha - lookup completo via
    *                     AbrirLookupCanonico/SigCdLin, substitui o
    *                     fwBuscaSel legado), Somente Negativos
    *                     (txt_4c_Negativo - dump declara Format "K", NAO
    *                     "M" - regra CLAUDE.md #13 "transcrever, nunca
    *                     inventar": a restricao S/N e feita por KeyPress,
    *                     equivalente ao "Return Inlist(...)" do Valid
    *                     legado) e Data de Geracao (txt_4c_Datai); estende
    *                     AjustarOrdemTabulacao() com o TabIndex 8..11
    *   Fase 7 (feita) - eventos via KeyPress (Enter/Tab/F4 - mesmo padrao
    *                     de LinhaKeyPress/DLinhaKeyPress) de Empresa (lookup
    *                     canonico em SigCdEmp - fAcessoEmpresa NAO existe no
    *                     projeto), Grupo de Estoque (fAcessoContab -> ja
    *                     ported em utils\functions.prg, chamado DIRETO como
    *                     no legado) e Conta de Estoque (fAcessoContas ->
    *                     idem, com o Grupo corrente como filtro)
    *   Fase 8 (feita) - BtnProcessaClick (NovoRegistro+FormParaBO+Salvar do
    *                     BO, exibe this_cNumeroPedido/this_nItensGerados ao
    *                     final) e BtnEncerrarClick (Release); FormParaBO/
    *                     BOParaForm/LimparCampos/FocarCampoValidacao.
    *                     NAO existem CarregarLista()/AjustarBotoesPorModo()/
    *                     HabilitarCampos()/BtnSalvarClick()/BtnBuscarClick():
    *                     o legado nao tem grade nem CRUD (so dois botoes,
    *                     Processar e Encerrar) - inventa-los seria desvio do
    *                     PILAR 1. Verificado por TestSigPrGmiF8.prg
    *                     (instancia o form, confere os 11 BINDEVENT, o escopo
    *                     PUBLIC dos 9 handlers de KeyPress, as 10 properties
    *                     do FormParaBO e o this_cCampoFoco da validacao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarCamposCriteriosParte1()
        THIS.ConfigurarCamposCriteriosParte2()

        *-- Por ULTIMO: TabIndex so pode ser ajustado depois de TODOS os
        *-- AddObject (cada atribuicao empurra os demais controles para tras)
        THIS.AjustarOrdemTabulacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (layout.json): cntSombra Top=0, Left=0, Width=864, Height=80,
    * BackColor=RGB(100,100,100) - os valores de lblSombra/lblTitulo/
    * dimensoes do container sao os defaults da classe cntSombra do
    * framework.vcx (confirmado pelo Caption de dump "Cadastro de Testes",
    * texto generico da classe que o Init legado substitui em runtime) - por
    * isso Width usa THIS.Width (canonico do projeto) em vez do literal 864.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar,
    * posicionados diretamente no form (fora de container), EXATAMENTE como
    * no SIGPRGMI.SCX original (Shape1/Processa/Cancela - layout.json).
    * Padrao canonico do projeto para este par de botoes (ver
    * FormSIGMVCMV.ConfigurarBotoesAcao): Width/Height=75, Themes=.T. +
    * DisabledPicture (botao standalone com Picture precisa dos dois para
    * o icone renderizar quando Enabled=.F. - regra CLAUDE.md).
    *
    * BINDEVENT dos dois botoes feito no FIM deste metodo, apontando para
    * BtnProcessaClick/BtnEncerrarClick (PUBLIC - regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = 7
                .Left          = 698
                .Width         = 46
                .Height        = 41
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Processa", "CommandButton")
            WITH THIS.cmd_4c_Processa
                .Top             = 4
                .Left            = 648
                .Height          = 75
                .Width           = 75
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "\<Processar"
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 4
                .Left = 5
                .Height          = 75
                .Width           = 75
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCriteriosParte1 - Fase 5/8: primeira metade dos campos
    * de criterio, criados DIRETO no form (layout flat do SIGPRGMI.SCX - sem
    * PageFrame, logo SEM a compensacao de +29, que so vale para controle
    * dentro de Page com Top=-29).
    *
    * As 6 linhas de criterio do legado foram divididas ao meio por LINHA da
    * tela (cada linha = codigo + descricao):
    *   Fase 5 (aqui) - Empresa (Top=113), Grupo de Estoque (Top=138) e
    *                   Conta de Estoque (Top=163) = 6 dos 10 TextBox
    *   Fase 6        - Linha de Producao (Top=188), Somente Negativos
    *                   (Top=213) e Data de Geracao (Top=238)
    *
    * TODAS as propriedades vem do dump SigPrGmi_form_codigo_fonte.txt
    * (secoes "PROPRIEDADES DE"), nao do layout.json - o dump traz Format/
    * InputMask/MaxLength/FontName que o layout.json nao tem. O SCX grava
    * APENAS o que difere do default da classe, entao o que ele nao declara
    * fica no default do VFP - medido em 2026-10-06 com
    * automation\medir_textbox_default_font.prg (TextBox via AddObject):
    * FontSize=9, SpecialEffect=0, BorderStyle=1, BackStyle=1, Alignment=3.
    * Por isso FontSize=9 vale para os seis campos (inclusive os de descricao,
    * que nao declaram FontSize) e NAO se escreve SpecialEffect=1 nem
    * BorderColor - o legado nao tem nenhum dos dois.
    *
    * Format = "K" (seleciona o conteudo ao entrar no campo) - NAO "K!": o
    * legado nao forca maiuscula em campo nenhum deste form. O "K" tambem
    * garante que o InputMask siga sendo mascara de digitacao, e nao lista de
    * valores validos (isso seria Format com "M" - regra CLAUDE.md #24).
    *
    * MaxLength transcrito do dump, que nunca excede a coluna do schema
    * (conferido em docs\schema.sql, UTF-16 lido com Get-Content -Raw):
    *   Empresa          -> SigCdEmp.cemps   char(3)  / Razas  char(40)  [3/40]
    *   Grupo de Estoque -> SigCdGcr.codigos char(10) / descrs char(40)  [10/20]
    *   Conta de Estoque -> SigCdCli.IClis   char(10) / RClis  char(50)  [10/40]
    * Nos dois campos de descricao o legado mostra MENOS que a coluna (20 e
    * 40) - eh truncamento de EXIBICAO do legado e fica como esta (PILAR 1);
    * esses campos sao criterio de filtro, nunca sao gravados.
    *
    * Os lookups de cada campo (Fase 7, ja implementados) usam as funcoes
    * do projeto que correspondem as do legado: fAcessoEmpresa -> SigCdEmp,
    * fAcessoContab -> SigCdGcr (grupos contabeis) e fAcessoContas ->
    * SigCdCli (contas). BINDEVENT so entra la, junto dos handlers - apontar
    * SigCdCli (contas) - BINDEVENT registrado no fim deste metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCriteriosParte1()
        LOCAL loc_oErro

        TRY
            *-- Linha 1: Empresa (legado lbl_empresa / get_cd_empresa / get_ds_empresa)
            THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
            WITH THIS.lbl_4c_Lbl_empresa
                .Caption   = "Empresa : "
                .Top       = 118
                .Left      = 211
                .Width     = 53
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_cd_empresa: codigo da empresa (SigCdEmp.cemps char(3))
            THIS.AddObject("txt_4c__cd_empresa", "TextBox")
            WITH THIS.txt_4c__cd_empresa
                .Top           = 113
                .Left          = 268
                .Width         = 31
                .Height        = 25
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .Format        = "K"
                .InputMask     = "XXX"
                .MaxLength     = 3
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ForeColor     = RGB(0, 0, 0)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- get_ds_empresa: razao social (SigCdEmp.Razas char(40))
            THIS.AddObject("txt_4c__ds_empresa", "TextBox")
            WITH THIS.txt_4c__ds_empresa
                .Top       = 113
                .Left      = 348
                .Width     = 290
                .Height    = 25
                .FontName  = "Courier New"
                .FontSize  = 9
                .Format    = "K"
                .MaxLength = 40
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Linha 2: Grupo de Estoque (legado Say1 / get_Cd_GrEstoque / get_Ds_GrEstoque)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Caption   = "Grupo de Estoque : "
                .Top       = 142
                .Left      = 166
                .Width     = 98
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_Cd_GrEstoque: codigo do grupo contabil (SigCdGcr.codigos char(10))
            THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
            WITH THIS.txt_4c__Cd_GrEstoque
                .Top       = 138
                .Left      = 268
                .Width     = 80
                .Height    = 25
                .FontName  = "Courier New"
                .FontSize  = 9
                .Format    = "K"
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- get_Ds_GrEstoque: descricao do grupo contabil (SigCdGcr.descrs char(40))
            THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
            WITH THIS.txt_4c__Ds_GrEstoque
                .Top       = 138
                .Left      = 348
                .Width     = 150
                .Height    = 25
                .FontName  = "Courier New"
                .FontSize  = 9
                .Format    = "K"
                .MaxLength = 20
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Linha 3: Conta de Estoque (legado lbl_estoque / get_cd_estoque / get_ds_estoque)
            THIS.AddObject("lbl_4c_Lbl_estoque", "Label")
            WITH THIS.lbl_4c_Lbl_estoque
                .Caption   = "Estoque : "
                .Top       = 168
                .Left      = 213
                .Width     = 51
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_cd_estoque: codigo da conta de estoque (SigCdCli.IClis char(10))
            THIS.AddObject("txt_4c__cd_estoque", "TextBox")
            WITH THIS.txt_4c__cd_estoque
                .Top           = 163
                .Left          = 268
                .Width         = 80
                .Height        = 25
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .Format        = "K"
                .InputMask     = ""
                .MaxLength     = 10
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ForeColor     = RGB(0, 0, 0)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- get_ds_estoque: descricao da conta de estoque (SigCdCli.RClis char(50))
            THIS.AddObject("txt_4c__ds_estoque", "TextBox")
            WITH THIS.txt_4c__ds_estoque
                .Top       = 163
                .Left      = 348
                .Width     = 290
                .Height    = 25
                .FontName  = "Courier New"
                .FontSize  = 9
                .Format    = "K"
                .MaxLength = 40
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- BINDEVENT: F4 abre o lookup direto; Enter/Tab disparam a
            *-- validacao (equivalente ao PROCEDURE Valid do legado, que roda
            *-- ao sair do campo). PUBLIC obrigatorio - BINDEVENT falha em
            *-- silencio com metodo PROTECTED (regra CLAUDE.md #3).
            BINDEVENT(THIS.txt_4c__cd_empresa, "KeyPress", THIS, "CdEmpresaKeyPress")
            BINDEVENT(THIS.txt_4c__ds_empresa, "KeyPress", THIS, "DsEmpresaKeyPress")
            BINDEVENT(THIS.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "CdGrEstoqueKeyPress")
            BINDEVENT(THIS.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "DsGrEstoqueKeyPress")
            BINDEVENT(THIS.txt_4c__cd_estoque, "KeyPress", THIS, "CdEstoqueKeyPress")
            BINDEVENT(THIS.txt_4c__ds_estoque, "KeyPress", THIS, "DsEstoqueKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarCamposCriteriosParte1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCriteriosParte2 - Fase 6/8: as 3 linhas RESTANTES de
    * criterio do legado, criadas DIRETO no form (mesmo layout flat, sem
    * compensacao de +29 - ver ConfigurarCamposCriteriosParte1):
    *   - Linha de Producao (Say2/Get_Linha/Get_DLinha, Top=188/193) - UNICO
    *     lookup desta fase (os demais - Empresa/Grupo/Conta - entraram na
    *     Fase 7, com AbrirLookupCanonico/fAcessoContab/fAcessoContas)
    *   - Somente Negativos (Say3/Get_negativo/Say4, Top=213/217/218)
    *   - Data de Geracao (Say_Conta/Get_Datai, Top=238/243)
    *
    * MaxLength conferido em docs\schema.sql (UTF-16, Get-Content -Raw):
    *   SigCdLin.linhas char(10) / descs char(40) - bate com o dump
    *   (MaxLength=10 e 40 respectivamente, sem truncamento de exibicao).
    *
    * Get_Linha/Get_DLinha no dump trazem conjuntos de propriedades
    * DIFERENTES (mesma distincao medida na Fase 5): Get_Linha declara o
    * bloco COMPLETO (FontBold/FontItalic/Alignment/BackStyle/BorderStyle/
    * SpecialEffect/ForeColor/InputMask - igual a get_cd_estoque), Get_DLinha
    * so o bloco LEVE (FontName/Format/MaxLength - igual a get_ds_estoque);
    * os WITH abaixo replicam cada um com o bloco correspondente.
    *
    * Get_negativo: o dump declara Format = "K" (selecionar ao entrar), NAO
    * "K!" nem "KM" - NAO ha InputMask no SCX. A regra CLAUDE.md #24 (Format
    * com M = multiple choice) NAO se aplica aqui porque o legado nao usa M
    * para este campo; a restricao a S/N vem do PROCEDURE Valid
    * ("Return Inlist(This.Value, "S","N")"), transcrita como handler de
    * KeyPress (NegativoKeyPress) com NODEFAULT - exatamente o efeito de um
    * Valid que devolve .F. (mantem o foco no campo).
    *
    * Get_Datai (classe fwget, Alignment=3 explicito no dump) segue o padrao
    * canonico de campo de data do projeto (FormSigPrFem.txt_4c_Datai):
    * Format="K", BackStyle=1, BorderStyle=1, SpecialEffect=1,
    * BorderColor=RGB(100,100,100), ForeColor=RGB(0,0,0). O valor Date()-7
    * que o Init legado atribui (ThisForm.Get_Datai.Value = Date() - 7) fica
    * para a Fase 8 (BOParaForm do modo INCLUIR) - aqui o controle nasce com
    * {} (Value declarado no dump), igual aos demais campos desta fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCriteriosParte2()
        LOCAL loc_oErro

        TRY
            *-- Linha 4: Linha de Producao (legado Say2 / Get_Linha / Get_DLinha)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Caption   = "Linha de Produ" + CHR(231) + CHR(227) + "o : "
                .Top       = 193
                .Left      = 164
                .Width     = 100
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Linha: codigo da linha de producao (SigCdLin.Linhas char(10))
            THIS.AddObject("txt_4c_Linha", "TextBox")
            WITH THIS.txt_4c_Linha
                .Top           = 188
                .Left          = 268
                .Width         = 80
                .Height        = 25
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .Format        = "K"
                .InputMask     = ""
                .MaxLength     = 10
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ForeColor     = RGB(0, 0, 0)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Get_DLinha: descricao da linha de producao (SigCdLin.Descs char(40))
            THIS.AddObject("txt_4c_DLinha", "TextBox")
            WITH THIS.txt_4c_DLinha
                .Top       = 188
                .Left      = 348
                .Width     = 290
                .Height    = 25
                .FontName  = "Courier New"
                .FontSize  = 9
                .Format    = "K"
                .MaxLength = 40
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- BINDEVENT: F4 abre o lookup direto; Enter/Tab disparam a
            *-- validacao (equivalente ao PROCEDURE Valid do legado, que roda
            *-- ao sair do campo). PUBLIC obrigatorio - BINDEVENT falha em
            *-- silencio com metodo PROTECTED (regra CLAUDE.md #3).
            BINDEVENT(THIS.txt_4c_Linha, "KeyPress", THIS, "LinhaKeyPress")
            BINDEVENT(THIS.txt_4c_DLinha, "KeyPress", THIS, "DLinhaKeyPress")

            *-- Linha 5: Somente Negativos (legado Say3 / Get_negativo / Say4)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Caption   = "Somente Negativos :"
                .Top       = 218
                .Left      = 162
                .Width     = 102
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_negativo: "S" ou "N" (char(1), sem coluna propria - vai
            *-- para SigMvEst via criterio de filtro, nunca eh gravado)
            THIS.AddObject("txt_4c_Negativo", "TextBox")
            WITH THIS.txt_4c_Negativo
                .Top        = 213
                .Left       = 268
                .Width      = 17
                .Height     = 25
                .FontName   = "Courier New"
                .FontSize   = 9
                .FontBold   = .F.
                .FontItalic = .F.
                .Alignment  = 0
                .BackStyle  = 1
                .BorderStyle = 1
                .Format     = "K"
                .MaxLength  = 1
                .Value      = ""
                .Visible    = .T.
            ENDWITH

            BINDEVENT(THIS.txt_4c_Negativo, "KeyPress", THIS, "NegativoKeyPress")

            *-- "< S / N >" - UNICO label do form com FontBold=.T. no dump
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Caption   = "< S / N >"
                .Top       = 217
                .Left      = 292
                .Width     = 52
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Linha 6: Data de Geracao (legado Say_Conta / Get_Datai)
            THIS.AddObject("lbl_4c__Conta", "Label")
            WITH THIS.lbl_4c__Conta
                .Caption   = "Data Gera" + CHR(231) + CHR(227) + "o :"
                .Top       = 243
                .Left      = 189
                .Width     = 75
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Datai: classe fwget (Alignment=3 explicito no dump) -
            *-- padrao canonico de campo de data do projeto (FormSigPrFem)
            THIS.AddObject("txt_4c_Datai", "TextBox")
            WITH THIS.txt_4c_Datai
                .Top           = 238
                .Left          = 268
                .Width         = 82
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .BackStyle     = 1
                .BorderStyle   = 1
                .Value         = {}
                .Format        = "K"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarCamposCriteriosParte2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CdEmpresaKeyPress / DsEmpresaKeyPress - Handlers de KeyPress de Empresa
    * (BINDEVENT exige PUBLIC - regra CLAUDE.md #3). Transcricao de
    * SIGPRGMI.get_cd_empresa.Valid / get_ds_empresa.Valid: os dois chamavam
    * "fAcessoEmpresa(Usuar,'C'|'D',This.value,...)", funcao que NAO foi
    * portada para o projeto (ver CLAUDE.md/memoria) - substituicao canonica:
    * match exato em SigCdEmp (Cemps/Razas) e, sem match, AbrirLookupCanonico
    * (FormBuscaAuxiliar) com o valor digitado como filtro de prefixo.
    *--------------------------------------------------------------------------
    PROCEDURE CdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa("C")
        ENDIF
    ENDPROC

    PROCEDURE DsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(ALLTRIM(THIS.txt_4c__ds_empresa.Value))
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa("D")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - par_cModo "C" (codigo, txt_4c__cd_empresa) ou "D"
    * (descricao, txt_4c__ds_empresa). Vazio limpa os dois campos; preenchido
    * tenta match exato em SigCdEmp e, sem match, abre o mesmo lookup do F4.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_cModo)
        LOCAL loc_cValor, loc_cCampo, loc_cSQL, loc_nResultado, loc_oErro

        IF VARTYPE(THIS.txt_4c__cd_empresa) != "O" OR VARTYPE(THIS.txt_4c__ds_empresa) != "O"
            RETURN
        ENDIF

        TRY
            IF par_cModo = "C"
                loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
            ELSE
                loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
            ENDIF

            IF EMPTY(loc_cValor)
                THIS.txt_4c__cd_empresa.Value = ""
                THIS.txt_4c__ds_empresa.Value = ""
            ELSE
                IF USED("cursor_4c_EmpresaVal")
                    USE IN cursor_4c_EmpresaVal
                ENDIF

                loc_cCampo = IIF(par_cModo = "C", "Cemps", "Razas")
                loc_cSQL   = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + loc_cCampo + " = " + EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaVal")

                IF loc_nResultado > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
                    SELECT cursor_4c_EmpresaVal
                    THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
                    THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
                ELSE
                    THIS.AbrirLookupEmpresa(loc_cValor)
                ENDIF

                IF USED("cursor_4c_EmpresaVal")
                    USE IN cursor_4c_EmpresaVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Lookup de Empresa via AbrirLookupCanonico (helper
    * de FormBase, Pattern A) - substitui o fwBuscaExt/fAcessoEmpresa legado,
    * que nao foi portado, em SigCdEmp (Cemps/Razas).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa(par_cValorFiltro)
        IF VARTYPE(THIS.txt_4c__cd_empresa) != "O" OR VARTYPE(THIS.txt_4c__ds_empresa) != "O"
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValorFiltro, ;
            THIS.txt_4c__cd_empresa, THIS.txt_4c__ds_empresa)
    ENDPROC

    *--------------------------------------------------------------------------
    * CdGrEstoqueKeyPress / DsGrEstoqueKeyPress - Handlers de KeyPress do
    * Grupo de Estoque (BINDEVENT exige PUBLIC - regra CLAUDE.md #3).
    * Transcricao de SIGPRGMI.get_Cd_GrEstoque.Valid / get_Ds_GrEstoque.Valid:
    * os dois chamam fAcessoContab (ja portada em utils\functions.prg) DIRETO,
    * passando os proprios TextBox de codigo/descricao para a funcao
    * preencher - igual ao padrao ja usado em FormSigPrCtr.ValidarGrupoAcesso.
    *--------------------------------------------------------------------------
    PROCEDURE CdGrEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarGrEstoque("C")
        ENDIF
    ENDPROC

    PROCEDURE DsGrEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarGrEstoque("D")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrEstoque - par_cModo "C" (txt_4c__Cd_GrEstoque) ou "D"
    * (txt_4c__Ds_GrEstoque). Campo vazio limpa o PAR (igual ao legado);
    * preenchido delega a fAcessoContab, que resolve o match e, sem achar,
    * abre o FormBuscaSimples - ela mesma preenche os dois TextBox.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrEstoque(par_cModo)
        LOCAL loc_cConta, loc_oErro

        IF VARTYPE(THIS.txt_4c__Cd_GrEstoque) != "O" OR VARTYPE(THIS.txt_4c__Ds_GrEstoque) != "O"
            RETURN
        ENDIF

        TRY
            loc_cConta = ALLTRIM(THIS.txt_4c__cd_estoque.Value)

            IF par_cModo = "C"
                IF !EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
                    fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value), ;
                        THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, loc_cConta)
                ELSE
                    THIS.txt_4c__Ds_GrEstoque.Value = ""
                ENDIF
            ELSE
                IF !EMPTY(ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value))
                    fAcessoContab(gc_4c_UsuarioLogado, "D", ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value), ;
                        THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, loc_cConta)
                ELSE
                    THIS.txt_4c__Cd_GrEstoque.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CdEstoqueKeyPress / DsEstoqueKeyPress - Handlers de KeyPress da Conta de
    * Estoque (BINDEVENT exige PUBLIC - regra CLAUDE.md #3). Transcricao de
    * SIGPRGMI.get_cd_estoque.Valid / get_ds_estoque.Valid: os dois chamam
    * fAcessoContas (ja portada em utils\functions.prg) com o Grupo de
    * Estoque corrente como filtro - igual ao padrao ja usado em
    * FormSigPrCtr.ValidarContaFornecedor/ValidarDescricaoConta.
    *--------------------------------------------------------------------------
    PROCEDURE CdEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarEstoque("C")
        ENDIF
    ENDPROC

    PROCEDURE DsEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarEstoque("D")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEstoque - par_cModo "C" (txt_4c__cd_estoque) ou "D"
    * (txt_4c__ds_estoque). Campo vazio limpa o PAR; preenchido delega a
    * fAcessoContas - achando sem acesso/match, exibe "Acesso Negado !!" (MsgAviso - icone 48 do legado) e
    * limpa os dois campos (transcricao do Messagebox+Value="" legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEstoque(par_cModo)
        LOCAL loc_cGrupo, loc_oErro

        IF VARTYPE(THIS.txt_4c__cd_estoque) != "O" OR VARTYPE(THIS.txt_4c__ds_estoque) != "O"
            RETURN
        ENDIF

        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)

            IF par_cModo = "C"
                IF !EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value))
                    IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(THIS.txt_4c__cd_estoque.Value), ;
                            THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque)
                        MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
                        THIS.txt_4c__cd_estoque.Value = ""
                        THIS.txt_4c__ds_estoque.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c__ds_estoque.Value = ""
                ENDIF
            ELSE
                IF !EMPTY(ALLTRIM(THIS.txt_4c__ds_estoque.Value))
                    IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(THIS.txt_4c__ds_estoque.Value), ;
                            THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque)
                        MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
                        THIS.txt_4c__ds_estoque.Value = ""
                        THIS.txt_4c__cd_estoque.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c__cd_estoque.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LinhaKeyPress / DLinhaKeyPress - Handlers de KeyPress (BINDEVENT exige
    * PUBLIC - regra CLAUDE.md #3). F4(115) abre o lookup direto;
    * Enter(13)/Tab(9) disparam a validacao por match exato - equivalente ao
    * PROCEDURE Valid do legado (Get_Linha/Get_DLinha), que roda ao sair do
    * campo.
    *--------------------------------------------------------------------------
    PROCEDURE LinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupLinha(ALLTRIM(THIS.txt_4c_Linha.Value))
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarLinha()
        ENDIF
    ENDPROC

    PROCEDURE DLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupLinha(ALLTRIM(THIS.txt_4c_DLinha.Value))
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDLinha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLinha - Transcricao de SIGPRGMI.Get_Linha.Valid: campo vazio
    * limpa os dois campos (codigo + descricao); preenchido tenta match
    * exato em SigCdLin.Linhas (equivalente ao "Select crSigCdLin / Set
    * Order to Linhas / Seek(This.Value)" legado) e, sem match, abre o
    * mesmo lookup que o F4 (equivalente ao fwBuscaSel do legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLinha()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro

        IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
            RETURN
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Linha.Value)
            IF EMPTY(loc_cValor)
                THIS.txt_4c_Linha.Value  = ""
                THIS.txt_4c_DLinha.Value = ""
            ELSE
                IF USED("cursor_4c_LinhaVal")
                    USE IN cursor_4c_LinhaVal
                ENDIF
                loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
                IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
                    SELECT cursor_4c_LinhaVal
                    THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
                    THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
                ELSE
                    THIS.AbrirLookupLinha(loc_cValor)
                ENDIF
                IF USED("cursor_4c_LinhaVal")
                    USE IN cursor_4c_LinhaVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDLinha - Transcricao de SIGPRGMI.Get_DLinha.Valid: mesma logica
    * de ValidarLinha, so que o match exato eh por SigCdLin.Descs
    * (equivalente ao "Set Order to Descs" legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDLinha()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro

        IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
            RETURN
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_DLinha.Value)
            IF EMPTY(loc_cValor)
                THIS.txt_4c_Linha.Value  = ""
                THIS.txt_4c_DLinha.Value = ""
            ELSE
                IF USED("cursor_4c_LinhaVal")
                    USE IN cursor_4c_LinhaVal
                ENDIF
                loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Descs = " + EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
                IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
                    SELECT cursor_4c_LinhaVal
                    THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
                    THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
                ELSE
                    THIS.AbrirLookupLinha(loc_cValor)
                ENDIF
                IF USED("cursor_4c_LinhaVal")
                    USE IN cursor_4c_LinhaVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLinha - Lookup de Linha de Producao via AbrirLookupCanonico
    * (helper de FormBase, Pattern A - substitui o fwBuscaSel legado em
    * crSigCdLin). Picker UNICO usado pelos dois campos (Linha/DLinha),
    * igual ao legado onde os dois Valid abrem o MESMO fwBuscaSel e
    * preenchem os dois campos ao selecionar.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLinha(par_cValorFiltro)
        IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdLin", "Linhas", "Descs", ;
            "Linhas de Produ" + CHR(231) + CHR(227) + "o", par_cValorFiltro, ;
            THIS.txt_4c_Linha, THIS.txt_4c_DLinha)
    ENDPROC

    *--------------------------------------------------------------------------
    * NegativoKeyPress - Handler de KeyPress de txt_4c_Negativo (BINDEVENT
    * exige PUBLIC - regra CLAUDE.md #3). Transcricao do PROCEDURE Valid
    * legado ("Return Inlist(This.Value, "S","N")"): em VFP, Valid devolvendo
    * .F. mantem o foco no campo - aqui reproduzido bloqueando Enter/Tab com
    * NODEFAULT quando o valor digitado nao eh "S" nem "N".
    *--------------------------------------------------------------------------
    PROCEDURE NegativoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !INLIST(THIS.txt_4c_Negativo.Value, "S", "N")
                MsgAviso("Valor inv" + CHR(225) + "lido. Informe S ou N.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                NODEFAULT
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarOrdemTabulacao - Reproduz o TabIndex que o SIGPRGMI.SCX declara.
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que aqui
    * poria os botoes Processar/Encerrar (criados na Fase 4) ANTES dos campos
    * - divergencia que nao da erro, nao entra em log e nao aparece em
    * screenshot: so o Tab andando na ordem errada.
    *
    * TabIndex eh gravavel em runtime, e a atribuicao tem de ser feita em
    * ordem ASCENDENTE e DEPOIS de todos os AddObject - cada atribuicao poe o
    * controle na posicao pedida e empurra os demais para tras.
    *
    * Numera SO os focalizaveis: Label tem TabIndex mas nao tem TabStop (nao
    * recebe foco), entao transcrever o TabIndex dos 9 labels do dump seria
    * inerte e ainda embaralharia a sequencia dos campos. Os botoes nao
    * declaram TabIndex no dump (ficam no default da classe), por isso nao
    * aparecem aqui.
    *
    * Valores do dump (focalizaveis desta fase): get_cd_empresa=2,
    * get_ds_empresa=3, get_Cd_GrEstoque=4, get_Ds_GrEstoque=5,
    * get_cd_estoque=6, get_ds_estoque=7, Get_Linha=8, Get_DLinha=9,
    * Get_negativo=10, Get_Datai=11 (Fase 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c__cd_empresa.TabIndex   = 2
            THIS.txt_4c__ds_empresa.TabIndex   = 3
            THIS.txt_4c__Cd_GrEstoque.TabIndex = 4
            THIS.txt_4c__Ds_GrEstoque.TabIndex = 5
            THIS.txt_4c__cd_estoque.TabIndex   = 6
            THIS.txt_4c__ds_estoque.TabIndex   = 7
            THIS.txt_4c_Linha.TabIndex         = 8
            THIS.txt_4c_DLinha.TabIndex        = 9
            THIS.txt_4c_Negativo.TabIndex      = 10
            THIS.txt_4c_Datai.TabIndex         = 11
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessaClick - botao "Processar" (SIGPRGMI.Processa.Click).
    * Sobe os criterios da tela para o BO (FormParaBO) e delega toda a
    * validacao/geracao a SigPrGmiBO.Salvar() (BusinessBase), que chama
    * ValidarDados() e, passando, Inserir() (transcricao do Click legado,
    * ja implementada nas Fases 1-2). Regra CLAUDE.md #20 - o BusinessBase
    * ja exibe a falha sozinho; o form so completa com o foco no campo que a
    * validacao recusou (this_cCampoFoco).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessaClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.NovoRegistro()

            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Pedido de Estoque M" + CHR(237) + "nimo gerado com sucesso!" + CHR(13) + ;
                        "Itens gerados: " + TRANSFORM(THIS.this_oBusinessObject.this_nItensGerados) + CHR(13) + ;
                        "N" + CHR(250) + "mero do Pedido: " + THIS.this_oBusinessObject.this_cNumeroPedido, ;
                        "Confirmar")
                    THIS.LimparCampos()
                ELSE
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o pedido.", "Confirmar")
                    ENDIF
                    THIS.FocarCampoValidacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - botao "Encerrar" (SIGPRGMI.Cancela.Click:
    * "ThisForm.Release"). Release() fica FORA de qualquer TRY (regra
    * CLAUDE.md #1) - liberar o proprio form de dentro do bloco derrubaria a
    * pilha de execucao dentro dele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere os criterios da tela para o Business Object,
    * imediatamente antes de THIS.this_oBusinessObject.Salvar().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            WITH THIS.this_oBusinessObject
                .this_cCdEmpresa   = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
                .this_cDsEmpresa   = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
                .this_cCdGrEstoque = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
                .this_cDsGrEstoque = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
                .this_cCdEstoque   = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
                .this_cDsEstoque   = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
                .this_cLinha       = ALLTRIM(THIS.txt_4c_Linha.Value)
                .this_cDLinha      = ALLTRIM(THIS.txt_4c_DLinha.Value)
                .this_cNegativo    = ALLTRIM(THIS.txt_4c_Negativo.Value)
                .this_dDatai       = ConverterParaData(THIS.txt_4c_Datai.Value)
            ENDWITH
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Estado inicial da tela. this_dDatai do BO comeca em
    * DATE() (SigPrGmiBO.Init, usado como sentinela interno de Inserir()) -
    * o campo de tela transcreve o Init legado ("ThisForm.Get_Datai.Value =
    * Date() - 7"), que eh um default de FILTRO, nao o valor que o BO guarda;
    * FormParaBO sobe de volta o que o usuario deixar na tela antes de
    * Processar. Os demais criterios nascem em branco (sem registro corrente
    * neste form - ele so dispara um processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c__cd_empresa.Value   = ""
            THIS.txt_4c__ds_empresa.Value   = ""
            THIS.txt_4c__Cd_GrEstoque.Value = ""
            THIS.txt_4c__Ds_GrEstoque.Value = ""
            THIS.txt_4c__cd_estoque.Value   = ""
            THIS.txt_4c__ds_estoque.Value   = ""
            THIS.txt_4c_Linha.Value         = ""
            THIS.txt_4c_DLinha.Value        = ""
            THIS.txt_4c_Negativo.Value      = "N"
            THIS.txt_4c_Datai.Value         = DATE() - 7
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reinicia a tela de criterios apos um Processar com
    * sucesso, para a proxima geracao (este form nao tem conceito de
    * registro/edicao - cada clique em Processar eh autonomo, sem vinculo
    * com o anterior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            THIS.BOParaForm()
            THIS.txt_4c__cd_empresa.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarCampoValidacao - Leva o foco para o campo que SigPrGmiBO.
    * ValidarDados() recusou (this_cCampoFoco). Regra CLAUDE.md #34:
    * alcancar membro por NOME exige EVALUATE, nunca Controls(nome).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarCampoValidacao()
        LOCAL loc_cCampo, loc_oCampo, loc_oErro

        TRY
            loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)

            IF !EMPTY(loc_cCampo) AND TYPE("THIS." + loc_cCampo) = "O"
                *-- Regra #34: membro por NOME so via EVALUATE, e o resultado
                *-- precisa de variavel - VFP9 nao aceita EVALUATE(...).SetFocus()
                loc_oCampo = EVALUATE("THIS." + loc_cCampo)
                IF VARTYPE(loc_oCampo) = "O"
                    loc_oCampo.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Foco e so uma conveniencia de UX (a mensagem de validacao ja
            *-- foi exibida pelo BO) - regra CLAUDE.md #9 exige MsgErro no
            *-- minimo, mesmo aqui.
            MsgErro(loc_oErro.Message, "Erro em FocarCampoValidacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis recursivamente todos os
    * controles do form. SIGPRGMI nao tem containers flutuantes (nenhum
    * Container com Visible=.F. toggled por botao no dump) - por isso nao
    * ha lista de exclusao (diferente de FormSigPrGlp).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):
*============================================================================
* SigPrGmiBO.prg - Business Object para Geracao de Pedido de Estoque Minimo
*
* Form legado: SIGPRGMI (form generico, OPERACIONAL - sem CRUD de registro)
* Tabelas manipuladas pelo processamento (Processa.Click do legado):
*   SigMvCab  (cabecalho do movimento/pedido gerado)
*   SigMvItn  (itens do movimento/pedido gerado)
*   SigCdLin  (linhas de producao - lookup)
*   SigCdEmp  (empresas - lookup, Cemps/Razas)
*   SigCdCli  (contas de estoque / grupos de estoque - lookup via fAcessoContas/fAcessoContab)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor/ValidarDados/Inserir/
*                ObterChavePrimaria/RegistrarAuditoria + logica real do
*                Processa.Click legado (geracao do pedido de estoque minimo)
*
* NOTA DE ARQUITETURA - Inserir()/Atualizar():
* Este processo SO GERA pedidos novos (SigMvCab/SigMvItn); o legado nao tem
* equivalente de "alterar" um pedido ja gerado atraves desta tela. O form
* (Fase 3+) chama NovoRegistro() + FormParaBO() + Salvar() a cada clique em
* "Processar" - this_lNovoRegistro fica sempre .T., entao Salvar() sempre
* delega a Inserir() (nunca a Atualizar()). Por isso Atualizar() e
* ExecutarExclusao() permanecem SEM override: o comportamento padrao herdado
* de BusinessBase (recusar a operacao) ja eh o correto, porque esses dois
* caminhos nunca sao acionados por este form.
*============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *==========================================================================
    * Propriedades - criterios de filtro/processamento (Get_* do form legado)
    * Este form NAO cadastra um registro unico: ele dispara um PROCESSAMENTO
    * (geracao de pedido de estoque minimo) a partir destes criterios.
    *==========================================================================
    this_cCdEmpresa   = ""    && char(3)  - Codigo da empresa (SigCdEmp.Cemps)
    this_cDsEmpresa   = ""    && char(40) - Descricao da empresa (SigCdEmp.Razas, exibicao)

    this_cCdGrEstoque = ""    && char     - Codigo do Grupo de Estoque (SigCdCli, lookup fAcessoContab)
    this_cDsGrEstoque = ""    && char     - Descricao do Grupo de Estoque (exibicao)

    this_cCdEstoque   = ""    && char     - Codigo da Conta de Estoque (SigCdCli, lookup fAcessoContas)
    this_cDsEstoque   = ""    && char     - Descricao da Conta de Estoque (exibicao)

    this_cLinha       = ""    && char     - Codigo da Linha de Producao (SigCdLin.Linhas)
    this_cDLinha      = ""    && char     - Descricao da Linha de Producao (SigCdLin.Descs)

    this_cNegativo    = "N"   && char(1)  - Somente Negativos (S/N)
    this_dDatai       = {}    && date     - Data de Geracao do pedido

    *==========================================================================
    * Resultado do lookup de Linha (SigCdLin.Pedidos) - a operacao usada para
    * gerar os pedidos (equivalente a "lcOperacao" do Processa.Click legado).
    * Resolvido em CarregarDoCursor() (apos picker) e revalidado em
    * ValidarDados() (o legado faz a MESMA conferencia de novo no Click, sem
    * confiar no que a tela ja tinha resolvido no Valid).
    *==========================================================================
    this_cOperacaoGerada = ""   && char(20) - SigCdLin.Pedidos da linha escolhida

    *==========================================================================
    * Propriedade de controle de UI (consistente com ProdutoBO/outros BOs do
    * projeto): o form faz SetFocus no controle indicado quando ValidarDados
    * recusa a operacao.
    *==========================================================================
    this_cCampoFoco = ""

    *==========================================================================
    * Propriedade interna de auditoria - a chave do cabecalho (SigMvCab.
    * CidChaves) RECEM-GERADO, usada por ObterChavePrimaria()/
    * RegistrarAuditoria() dentro do laco de Inserir() (mais de um cabecalho
    * pode ser gerado numa unica execucao - um por fornecedor distinto).
    *==========================================================================
    this_cCidChavesAtual = ""

    *==========================================================================
    * Propriedades de controle do processamento (resultado da ultima execucao)
    *==========================================================================
    this_nItensGerados = 0    && Quantidade de itens incluidos no(s) pedido(s) gerado(s)
    this_cNumeroPedido  = ""  && Numero (Numes) do ULTIMO cabecalho gerado na ultima execucao

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_dDatai      = DATE()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do ULTIMO cabecalho (SigMvCab.CidChaves)
    * gravado por Inserir(); usada por RegistrarAuditoria(), chamado DENTRO do
    * laco de geracao (um registro de auditoria por cabecalho criado, ja que
    * um unico Processar pode gerar varios cabecalhos - um por fornecedor).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega o resultado do picker/seek de Linha de
    * Producao (cursor com as colunas Linhas/Descs/Pedidos de SigCdLin,
    * equivalente ao "This.Parent.Get_Linha.Value = crSigCdLin.Linhas /
    * This.Parent.Get_dLinha.Value = crSigCdLin.Descs" do Get_Linha.Valid /
    * Get_DLinha.Valid legado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cLinha          = PADR(ALLTRIM(TratarNulo(Linhas, "")), 10)
                THIS.this_cDLinha         = ALLTRIM(TratarNulo(Descs, ""))
                THIS.this_cOperacaoGerada = PADR(ALLTRIM(TratarNulo(Pedidos, "")), 20)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDados - transcricao dos IsEmpty()/Seek() do inicio do
    * Processa.Click legado. O legado usa Messagebox()+SetFocus; aqui
    * this_cMensagemErro + this_cCampoFoco (o form faz o SetFocus) - quem
    * EXIBE a mensagem eh BusinessBase.Salvar()/ExibirFalha (regra do
    * CLAUDE.md: falha nunca eh muda).
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cLinha, loc_nResultado, loc_oErro

        loc_lValido = .T.
        THIS.this_cCampoFoco = ""

        IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa..."
            THIS.this_cCampoFoco    = "txt_4c__cd_empresa"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo..."
            THIS.this_cCampoFoco    = "txt_4c__Cd_GrEstoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta..."
            THIS.this_cCampoFoco    = "txt_4c__cd_estoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha..."
            THIS.this_cCampoFoco    = "txt_4c_Linha"
            loc_lValido = .F.
        ENDIF

        *-- Select crSigCdLin / Set Order to Linhas / If !Seek(lcLinha) ...
        *-- Endif / If IsEmpty(crSigCdLin.Pedidos) ... Endif - revalidado aqui
        *-- sem confiar no que o picker/Valid ja tinha resolvido.
        *-- TRY/CATCH proprio: SQLEXEC com gnConnHandle invalido DISPARA
        *-- excecao em vez de devolver -1 (nao chegaria no IF abaixo).
        IF loc_lValido
            loc_cLinha = PADR(ALLTRIM(THIS.this_cLinha), 10)

            TRY
                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descs, linhas, pedidos FROM SigCdLin WHERE linhas = " + ;
                    EscaparSQL(loc_cLinha), "cursor_4c_LinhaChk")

                IF loc_nResultado < 0 OR !USED("cursor_4c_LinhaChk") OR EOF("cursor_4c_LinhaChk")
                    THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                        CHR(227) + "o est" + CHR(225) + " cadastrada..."
                    THIS.this_cCampoFoco    = "txt_4c_Linha"
                    loc_lValido = .F.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LinhaChk.pedidos, "")))
                        THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                            CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada..."
                        THIS.this_cCampoFoco    = "txt_4c_Linha"
                        loc_lValido = .F.
                    ELSE
                        THIS.this_cOperacaoGerada = PADR(ALLTRIM(cursor_4c_LinhaChk.pedidos), 20)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                THIS.this_cCampoFoco    = "txt_4c_Linha"
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - transcricao de SIGPRGMI.Processa.Click. Gera o(s) pedido(s)
    * de estoque minimo (SigMvCab/SigMvItn) a partir dos criterios (Empresa/
    * Grupo/Conta/Linha/Negativo/Data) ja validados por ValidarDados().
    *
    * Arquitetura: os cabecalhos/itens sao acumulados em cursores LOCAIS com
    * a estrutura COMPLETA das tabelas reais (AbrirCursorTabela), igual ao
    * padrao ja usado em SigPrGlxBO/SigPrGlpBO - garante cobertura de TODA
    * coluna NOT NULL sem enumerar ~140 colunas a mao (regra #22 do
    * CLAUDE.md) - e so ao final sao persistidos via PersistirCursor +
    * SQLCOMMIT/SQLROLLBACK (a conexao nasce em modo manual - Transactions=2
    * - sem nenhum commit implicito; ver memoria feedback_conexao_sql_
    * transactions_2_sem_commit).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lErro, loc_cEmpresa, loc_cGrupo, loc_cConta, loc_cLinha, ;
            loc_cOperacao, loc_dData, loc_cSQL, loc_cChaveEst, ;
            loc_cFornece, loc_nItens, loc_nNumero, loc_cEmpDopNums, loc_cGruOrigs, ;
            loc_nOpers, loc_nTotalReg, loc_oProg, loc_oErro

        loc_lErro = .F.
        THIS.this_nItensGerados = 0
        THIS.this_cNumeroPedido = ""

        loc_cEmpresa  = PADR(ALLTRIM(THIS.this_cCdEmpresa), 3)
        loc_cGrupo    = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
        loc_cConta    = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
        loc_cLinha    = PADR(ALLTRIM(THIS.this_cLinha), 10)
        loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacaoGerada), 20)
        loc_dData     = THIS.this_dDatai

        TRY
            *-- 1) monta crTemp1/crTemp2 (ou crTemp3) e TmpMinimo, conforme o
            *-- criterio "Somente Negativos"
            IF UPPER(ALLTRIM(THIS.this_cNegativo)) != "S"

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.QMins, P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < P.QMins" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1 AND P.QMins > 0"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp1", "crTemp1")
                    loc_lErro = .T.
                ENDIF

                *-- Chave POSICIONAL (regra #42 do CLAUDE.md): empgruests eh
                *-- char(23) = emps(3)+grupos(10)+estos(10) - PADR explicito,
                *-- nunca ALLTRIM/concatenacao direta das partes.
                IF !loc_lErro
                    loc_cChaveEst = PADR(loc_cEmpresa, 3) + PADR(loc_cGrupo, 10) + PADR(loc_cConta, 10)

                    loc_cSQL = "SELECT CPros, QMins, IFors, PVens, Moevs, Dpros " + ;
                        "FROM SigCdPro " + ;
                        "WHERE Linhas = " + EscaparSQL(loc_cLinha) + ;
                        " AND QMins > 0 AND Situas = 1" + ;
                        " AND " + EscaparSQL(loc_cChaveEst) + " + CPros NOT IN " + ;
                        "(SELECT empgruests + CPros FROM SigMvEst)"

                    IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp2", "crTemp2")
                        loc_lErro = .T.
                    ENDIF
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, QMins, QMins - SQtds AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp1 ;
                        WHERE Emps = m.loc_cEmpresa AND Grupos = m.loc_cGrupo AND Estos = m.loc_cConta ;
                            AND SQtds < QMins AND QMins > 0 ;
                        UNION ALL ;
                        SELECT PADR(m.loc_cEmpresa, 3) AS Emps, PADR(m.loc_cGrupo, 10) AS Grupos, ;
                                PADR(m.loc_cConta, 10) AS Estos, CPros, 00000000.000 AS SQtds, ;
                                QMins, QMins AS DifProds, IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp2 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ELSE

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < 0" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp3", "crTemp3")
                    loc_lErro = .T.
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, 0 AS QMins, ABS(SQtds) AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp3 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ENDIF

            IF !loc_lErro
                SELECT cursor_4c_Minimo
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 2) TmpPedidos (producao ja em andamento) e TmpProd (saldo que
            *-- realmente falta produzir)
            IF !loc_lErro
                loc_cSQL = "SELECT I.CPros, I.Qtds, I.QtBxProds " + ;
                    "FROM SigMvCab E, SigMvItn I, SigCdOpe O " + ;
                    "WHERE E.Dopes = O.Dopes AND E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND (O.Globalizas = 1 OR O.Globalizas = 2)" + ;
                    " AND E.Grupods = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Contads = " + EscaparSQL(loc_cConta) + ;
                    " AND E.EmpDopNums = I.EmpDopNums"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp4", "crTemp4")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF USED("cursor_4c_Pedidos")
                    USE IN cursor_4c_Pedidos
                ENDIF

                SELECT CPros, SUM(Qtds - QtBxProds) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY CPros ;
                    INTO CURSOR cursor_4c_Pedidos READWRITE

                SELECT cursor_4c_Pedidos
                INDEX ON CPros TAG CPros

                SELECT cursor_4c_Minimo
                INDEX ON IFors + CPros TAG ForProd

                IF USED("cursor_4c_Prod")
                    USE IN cursor_4c_Prod
                ENDIF

                SELECT M.CPros, M.IFors, M.PVens, M.Moevs, M.Dpros, ;
                        M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                    FROM cursor_4c_Minimo M LEFT JOIN cursor_4c_Pedidos P ON M.CPros = P.CPros ;
                    WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                    INTO CURSOR cursor_4c_Prod READWRITE

                SELECT cursor_4c_Prod
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ELSE
                    INDEX ON IFors + CPros TAG ForProd
                    COUNT TO loc_nTotalReg
                ENDIF
            ENDIF

            *-- 3) cursores destino (cabecalho/itens) com a estrutura REAL e
            *-- COMPLETA das tabelas - nasce vazio, igual ao "Select crXxx /
            *-- Zap" do topo do processamento legado
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 4) laco principal - um cabecalho por fornecedor (IFors)
            *-- distinto, itens sequenciais dentro de cada cabecalho
            IF !loc_lErro
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
                loc_oProg.Show()

                loc_cFornece = REPLICATE(CHR(255), 10)
                loc_nItens   = 0
                loc_nNumero  = 0
                loc_nOpers   = 0

                SELECT cursor_4c_Prod
                SCAN
                    loc_oProg.Update(.T.)

                    IF loc_cFornece != cursor_4c_Prod.IFors
                        loc_nNumero  = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                        loc_cFornece = cursor_4c_Prod.IFors

                        IF loc_nNumero = 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + ;
                                CHR(250) + "mero do pedido."
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_SigCdOpe")
                            USE IN cursor_4c_SigCdOpe
                        ENDIF

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Dopes, GruOrigs, Opers FROM SigCdOpe WHERE Dopes = " + ;
                                EscaparSQL(loc_cOperacao), "cursor_4c_SigCdOpe", "crSigCdOpe")
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        loc_cGruOrigs = "ESTOQUE"
                        loc_nOpers    = 0
                        IF USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe")
                            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_SigCdOpe.GruOrigs, "")))
                                loc_cGruOrigs = ALLTRIM(cursor_4c_SigCdOpe.GruOrigs)
                            ENDIF
                            loc_nOpers = TratarNulo(cursor_4c_SigCdOpe.Opers, 0)
                        ENDIF

                        *-- EmpDopNums eh chave POSICIONAL (regra #42): char(29)
                        *-- = emps(3) + dopes(20) + Str(numes,6) - PADR explicito.
                        loc_cEmpDopNums = PADR(loc_cEmpresa, 3) + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)

                        SELECT cursor_4c_MvCab
                        APPEND BLANK
                        REPLACE Emps       WITH loc_cEmpresa, ;
                                Dopes      WITH PADR(loc_cOperacao, 20), ;
                                Numes      WITH loc_nNumero, ;
                                Datas      WITH loc_dData, ;
                                Datars     WITH loc_dData, ;
                                MascNum    WITH ALLTRIM(fGerMascara(loc_nNumero)), ;
                                Grupoos    WITH PADR(loc_cGruOrigs, 10), ;
                                Contaos    WITH PADR(loc_cFornece, 10), ;
                                Grupods    WITH PADR(loc_cGrupo, 10), ;
                                Contads    WITH PADR(loc_cConta, 10), ;
                                Usuars     WITH PADR(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")), 10), ;
                                EmpDopNums WITH loc_cEmpDopNums, ;
                                CidChaves  WITH fUniqueIds(), ;
                                DtAlts     WITH DATE()

                        THIS.this_cCidChavesAtual = ALLTRIM(cursor_4c_MvCab.CidChaves)
                        THIS.RegistrarAuditoria("INSERT")
                        THIS.this_cNumeroPedido = TRANSFORM(loc_nNumero)

                        loc_nItens = 0
                    ENDIF

                    loc_nItens = loc_nItens + 1

                    SELECT cursor_4c_MvItn
                    APPEND BLANK
                    REPLACE Emps       WITH loc_cEmpresa, ;
                            Dopes      WITH PADR(loc_cOperacao, 20), ;
                            Numes      WITH loc_nNumero, ;
                            CItens     WITH loc_nItens, ;
                            CPros      WITH cursor_4c_Prod.CPros, ;
                            Qtds       WITH cursor_4c_Prod.Qtds, ;
                            Units      WITH cursor_4c_Prod.PVens, ;
                            Moedas     WITH cursor_4c_Prod.Moevs, ;
                            opers      WITH IIF(loc_nOpers = 1, "E", "S"), ;
                            totas      WITH (cursor_4c_Prod.Qtds * cursor_4c_Prod.PVens), ;
                            dpros      WITH cursor_4c_Prod.Dpros, ;
                            EmpDopNums WITH loc_cEmpDopNums, ;
                            CidChaves  WITH fUniqueIds(), ;
                            DtAlts     WITH DATE()

                    SELECT cursor_4c_MvCab
                    REPLACE ValInis WITH ValInis + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            Valos   WITH Valos   + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            DtAlts  WITH DATE()

                    THIS.this_nItensGerados = THIS.this_nItensGerados + 1

                    SELECT cursor_4c_Prod
                ENDSCAN

                loc_oProg.Complete(.T.)
                loc_oProg = .NULL.
            ENDIF

            *-- 5) persiste os dois cursores locais nas tabelas reais e fecha
            *-- a transacao manual (Transactions = 2) - um unico commit cobre
            *-- os dois PersistirCursor + os RegistrarAuditoria do laco acima
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Commit) " + CapturarErroSQL()
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF loc_lErro
                = SQLROLLBACK(gnConnHandle)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lErro = .T.
            = SQLROLLBACK(gnConnHandle)
        ENDTRY

        *-- limpeza dos cursores temporarios (regra #1: fora do TRY/CATCH so
        *-- por causa do RETURN; aqui eh so organizacao)
        IF USED("cursor_4c_Temp1")
            USE IN cursor_4c_Temp1
        ENDIF
        IF USED("cursor_4c_Temp2")
            USE IN cursor_4c_Temp2
        ENDIF
        IF USED("cursor_4c_Temp3")
            USE IN cursor_4c_Temp3
        ENDIF
        IF USED("cursor_4c_Temp4")
            USE IN cursor_4c_Temp4
        ENDIF
        IF USED("cursor_4c_Minimo")
            USE IN cursor_4c_Minimo
        ENDIF
        IF USED("cursor_4c_Pedidos")
            USE IN cursor_4c_Pedidos
        ENDIF
        IF USED("cursor_4c_Prod")
            USE IN cursor_4c_Prod
        ENDIF
        IF USED("cursor_4c_SigCdOpe")
            USE IN cursor_4c_SigCdOpe
        ENDIF
        IF USED("cursor_4c_MvCab")
            USE IN cursor_4c_MvCab
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF

        RETURN !loc_lErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC pass-through preservando a area de trabalho
    * corrente (o chamador pode estar no meio de um SCAN de outro cursor).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada - garante que PersistirCursor()
    * cubra toda coluna NOT NULL da tabela destino (regra #22 do CLAUDE.md).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas. Mesmo helper generico ja usado
    * em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor (que AbrirCursorTabela criou com a estrutura completa da
    * tabela). Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

