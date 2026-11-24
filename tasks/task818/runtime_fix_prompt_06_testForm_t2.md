# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopvdi
Erro: Cannot add this object to a Grid.


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopvdi
Erro: Cannot add this object to a Grid.


### LOG DA ETAPA (06_testForm):
[2026-11-19 13:11:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-19 13:11:23] [INFO] Config FPW: (nao fornecido)
[2026-11-19 13:11:24] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-19 13:11:24] [INFO] Timeout: 300 segundos
[2026-11-19 13:11:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lpd2djnl.prg
[2026-11-19 13:11:25] [INFO] Conteudo do wrapper:
[2026-11-19 13:11:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpVdi', 'C:\4c\tasks\task818\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpVdi', 'C:\4c\tasks\task818\logs\06_testForm.log'
QUIT

[2026-11-19 13:11:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lpd2djnl.prg
[2026-11-19 13:11:25] [INFO] VFP output esperado em: C:\4c\tasks\task818\vfp_output.txt
[2026-11-19 13:11:26] [INFO] Executando Visual FoxPro 9...
[2026-11-19 13:11:26] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lpd2djnl.prg
[2026-11-19 13:11:26] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lpd2djnl.prg
[2026-11-19 13:11:27] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpVdi
Inicio: 19/11/2026 13:11:28

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 19/11/2026 13:12:37
Duracao: 69 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-19 13:12:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-19 13:12:39] [INFO] VFP9 finalizado em 72.6028943 segundos
[2026-11-19 13:12:39] [INFO] Exit Code: 
[2026-11-19 13:12:39] [INFO] 
[2026-11-19 13:12:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-19 13:12:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lpd2djnl.prg
[2026-11-19 13:12:40] [INFO] 
[2026-11-19 13:12:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-19 13:12:41] [INFO] * Auto-generated wrapper for parameters
[2026-11-19 13:12:41] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-19 13:12:41] [INFO] * Parameters: 'FormSigOpVdi', 'C:\4c\tasks\task818\logs\06_testForm.log'
[2026-11-19 13:12:42] [INFO] 
[2026-11-19 13:12:42] [INFO] * Anti-dialog protections for unattended execution
[2026-11-19 13:12:42] [INFO] SET SAFETY OFF
[2026-11-19 13:12:43] [INFO] SET RESOURCE OFF
[2026-11-19 13:12:43] [INFO] SET TALK OFF
[2026-11-19 13:12:43] [INFO] SET NOTIFY OFF
[2026-11-19 13:12:44] [INFO] SYS(2335, 0)
[2026-11-19 13:12:44] [INFO] 
[2026-11-19 13:12:44] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpVdi', 'C:\4c\tasks\task818\logs\06_testForm.log'
[2026-11-19 13:12:44] [INFO] QUIT
[2026-11-19 13:12:45] [INFO] 
[2026-11-19 13:12:45] [INFO] === Fim do Wrapper.prg ===
[2026-11-19 13:12:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.prg):
*------------------------------------------------------------------------------
* FormSigOpVdi.prg - Form Operacional: Pesquisa Detalhada (vendas x cadastro)
* Herda de FormBase
* Migrado de SIGOPVDI.SCX
*
* Form OPERACIONAL com PageFrame interno de 2 paginas (pgfPrincipal no
* legado -> pgf_4c_Paginas): Page1 = pgFiltros (filtros de periodo/moeda/
* grupo de venda/subgrupo + grades de marcacao de empresas/tipos de
* operacao/grande grupo/grupo/operacoes) e Page2 = pgDados (resultado -
* PageFrame interno pgResults com 3 abas: Detalhamento/Totais por Empresa/
* Totais por Vendedora). Tabs=.F. nas duas - a navegacao entre Page1/Page2
* e feita pelos botoes cmgFiltros.btnConsultar / pgDados.cmgRetornar, nao
* por clique nas abas.
*
* pgf_4c_Paginas.Top=-1 (NAO eh o deslocamento -29 do padrao CRUD - regra
* #11 e o PageFrame.Top=-29 nao se aplicam aqui: este form nao eh
* frmcadastro, e o legado so usa -1 para cobrir 1px de borda).
*
* FASE 3/8 - ESTRUTURA BASE: casca do form (propriedades visuais EXATAS do
* SCX - DataSession=2, Height=700, Width=1300, BorderStyle=2, ControlBox=.F.,
* Closable=.F., TitleBar=0) + pgf_4c_Paginas (2 paginas, geometria exata do
* dump) + o cabecalho cinza superior (cnt_4c_Sombra + lbl_4c_LblSombra +
* lbl_4c_LblTitulo), que no dump legado existe SO dentro de pgFiltros (Page1)
* - diferente do padrao CRUD que replica a faixa nas duas paginas (regra
* #11, decisao exclusiva de forms frmcadastro) - e o PageFrame interno
* pgf_4c_Resultados (3 paginas, so a casca, sem grades ainda).
*
* FASES CONCLUIDAS:
*   Fase 4: grades de marcacao (empresas/tipos/grande grupo/grupo/operacoes)
*           e o grupo de botoes de filtro (cmgFiltros -> cmg_4c_Filtros)
*   Fase 5 - PARTE 1/2: campos de Periodo (getDcI/getDcF) e Moeda de
*           Conversao (getCMoes/getDMoes), com BOParaFormFiltros() +
*           sincronizacao por LostFocus.
*   Fase 6 (ESTA FASE): campos de Grupo de Venda (getCdGrVda/getDsGrVda ->
*           txt_4c_CdGrVda/txt_4c_DsGrVda) e Subgrupo (get_cd_sgrupo/
*           get_ds_sgrupo -> txt_4c__cd_sgrupo/txt_4c__ds_sgrupo) + os 3
*           lookups fwbuscaext (Moeda/SigCdMoe, Grupo de Venda/SigCdCol,
*           Subgrupo/SigCdPsg) via FormBuscaAuxiliar, instalados no
*           LostFocus de cada campo de codigo/descricao (regra #47).
*
* FASES SEGUINTES:
*   Fase 7: grades de resultado (pgRes01/02/03 -> grd_4c_Dados1/2/3) +
*           botoes de navegacao/exportacao + eventos
*   Fase 8: consolidacao (Processamento() do legado -> THIS.this_oBusinessObject.
*           Processar(), FormParaBO completo dos filtros)
*------------------------------------------------------------------------------
DEFINE CLASS FormSigOpVdi AS FormBase

    *-- Propriedades visuais (SIGOPVDI.SCX, SECAO 2 "PROPRIEDADES DE: SIGOPVDI")
    this_cMensagemErro = ""
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Height       = 700
    Width        = 1300
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = "Pesquisa Detalhada"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    SizeBox      = .F.
    ZoomBox      = .F.
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia (regra #37/#47): o picker FormBuscaAuxiliar eh
    *-- MODAL e tira o foco do campo que o chamou, o que redispara o proprio
    *-- LostFocus. Compartilhada pelos 3 lookups da Pagina 1 (Moeda/Grupo de
    *-- Venda/Subgrupo) porque so um pode estar com foco por vez.
    this_lEmLookupFiltro = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpVdiBO")

            THIS.ConfigurarPageFrame()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oBusinessObject.CarregarFiltrosIniciais()
                THIS.CarregarDados()
            ENDIF

            THIS.BOParaFormFiltros()

            THIS.ConfigurarBindEventsFiltros()

            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - pgfPrincipal do legado -> pgf_4c_Paginas (2
    * paginas: Page1=Filtros, Page2=Dados). Geometria EXATA do dump
    * (SECAO 2 "PROPRIEDADES DE: SIGOPVDI.pgfPrincipal").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top         = -1
            .Left        = 0
            .Width       = 1301
            .Height      = 705
            .PageCount   = 2
            .Tabs        = .F.
            .BorderWidth = 0
            *-- O dump legado tambem declara TabStyle = 0, que NAO pode ser
            *-- transcrito: medido no VFP9 neste proprio PageFrame,
            *-- .TabStyle estoura "Property TABSTYLE is read-only" em
            *-- runtime, o erro cai no TRY do InicializarForm, CREATEOBJECT
            *-- devolve .F. e a tela NAO abre. Sem perda de fidelidade: 0 ja
            *-- e o default e, com Tabs = .F., nenhuma aba e desenhada.
            *-- BorderWidth, ao contrario, E gravavel (medido: default 1,
            *-- legado 0) - por isso continua transcrita acima.
        ENDWITH

        THIS.ConfigurarPaginaFiltros()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaFiltros - Page1 (pgFiltros no legado). Nesta fase: so
    * o fundo padrao e o cabecalho cinza (cntSombra -> cnt_4c_Sombra), que no
    * dump legado existe SOMENTE nesta pagina (NAO replicar em pgDados -
    * diferente do padrao CRUD da regra #11, que nao se aplica a este form).
    *
    * As grades de marcacao, os campos de filtro e o grupo de botoes
    * cmgFiltros entram nas Fases 4/5/6 - nenhum deles e criado aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            loc_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- cntSombra: Top=1 Left=0 Width=1308 Height=80 BackColor=100,100,100
        loc_oPag.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPag.cnt_4c_Sombra
            .Top         = 1
            .Left        = 0
            .Width       = 1308
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            *-- lblSombra: Top=25 Left=10 Width=769 Height=40 Tahoma 18 Bold
            *-- ForeColor=0,0,0 (fundo da sombra do titulo)
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(0, 0, 0)
                *-- Caption vem de THIS.Caption, nao do texto estatico
                *-- ("Cadastro de Testes") que sobrou no dump do SCX.
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            *-- lblTitulo: Top=24 Left=10 Width=769 Height=46 Tahoma 18 Bold
            *-- ForeColor=255,255,255 (texto branco por cima da sombra)
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        THIS.ConfigurarGradesMarcacao(loc_oPag)
        THIS.ConfigurarCamposFiltro(loc_oPag)

        *-- txt_4c_CfgGrade (getCfgGrade no legado): Top=673, FORA da area
        *-- normalmente visitada do formulario - guarda em memoria a string
        *-- de largura/visibilidade das colunas de grd_4c_Dados1 (regra de
        *-- AcertaColunas, Fase 7). Nao tem uso direto pelo usuario comum.
        loc_oPag.AddObject("txt_4c_CfgGrade", "TextBox")
        WITH loc_oPag.txt_4c_CfgGrade
            .Top     = 673
            .Left    = 9
            .Width   = 1297
            .Height  = 23
            .Value   = ""
            *-- getCfgGrade.When do legado e "Return .f.": o campo nunca
            *-- recebe foco nem aceita digitacao - e area de armazenamento
            *-- de AcertaColunas, e texto digitado ali corromperia a
            *-- largura/visibilidade das 35 colunas de grd_4c_Dados1.
            *-- ReadOnly (convencao do projeto para When -> .f.) + TabStop
            *-- = .F. para o Tab nao parar nele.
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible = .T.
        ENDWITH

        *-- Page NAO tem a propriedade Visible (a Page e exibida pelo
        *-- ActivePage do PageFrame). Atribuir estoura "Property VISIBLE
        *-- is not found" dentro do InicializarForm e a tela nao abre.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposFiltro - Campos de filtro da Pagina 1. Periodo
    * (getDcI/getDcF -> txt_4c_DataIni/txt_4c_DataFim) e Moeda de Conversao
    * (getCMoes/getDMoes -> txt_4c_CodMoeda/txt_4c_DescMoeda) vieram na
    * Fase 5 - Parte 1. Grupo de Venda (getCdGrVda/getDsGrVda ->
    * txt_4c_CdGrVda/txt_4c_DsGrVda) e Subgrupo (get_cd_sgrupo/get_ds_sgrupo
    * -> txt_4c__cd_sgrupo/txt_4c__ds_sgrupo) sao desta fase (Fase 6 -
    * Parte 2/2): os 3 campos de codigo (Moeda/Grupo de Venda/Subgrupo) tem
    * lookup fwbuscaext no legado (SigCdMoe/SigCdCol/SigCdPsg), instalado
    * via FormBuscaAuxiliar nos handlers de LostFocus logo abaixo deste
    * metodo (regra #47 - lookup em LostFocus, nunca em KeyPress sem testar
    * a tecla).
    *
    * Nenhum destes campos leva compensacao de +29 no Top (regra #11 nao se
    * aplica a este form - ver nota em pgf_4c_Paginas.Top no cabecalho):
    * Top/Left sao transcritos EXATOS do dump (layout.json).
    *
    * Say1/Say3/Say11/Say14 (classe "say" do legado, sem Width/Alignment no
    * dump de Say1/Say3) seguem a regra #23: .Alignment = 0 + .AutoSize =
    * .F. + Width calculada para caber o texto. Say11/Say14 JA declaram
    * Width no dump (AutoSize = .T. no SCX, mas regra #23 - AutoSize eh
    * no-op em Label criado por AddObject) - Width transcrita literal.
    * Label2 ("at?") ja declara Width/Height no dump - transcrito literal.
    *
    * Format/InputMask (regra #49) transcritos do dump: getCMoes/getDMoes =
    * "!" (forca maiuscula); getCdGrVda/getDsGrVda = "K" (seleciona ao
    * entrar); get_cd_sgrupo/get_ds_sgrupo = "K!" (seleciona + maiuscula).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro(par_oPag)

        *-- lbl_4c_Periodo (Say1): "Periodo :" - Left=457, campo em 506 (49px de vao)
        par_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH par_oPag.lbl_4c_Periodo
            .Top       = 111
            .Left      = 457
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DataIni (getDcI): data inicial do periodo
        par_oPag.AddObject("txt_4c_DataIni", "TextBox")
        WITH par_oPag.txt_4c_DataIni
            .Top     = 107
            .Left    = 506
            .Width   = 70
            .Height  = 23
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_4c_At (Label2): "at?" - Left/Width/Height EXATOS do dump
        par_oPag.AddObject("lbl_4c_At", "Label")
        WITH par_oPag.lbl_4c_At
            .Top       = 111
            .Left      = 592
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DataFim (getDcF): data final do periodo
        par_oPag.AddObject("txt_4c_DataFim", "TextBox")
        WITH par_oPag.txt_4c_DataFim
            .Top     = 107
            .Left    = 617
            .Width   = 70
            .Height  = 23
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_4c_MoedaConversao (Say3): "Moeda Conversao :" - Left=406, campo em 506
        par_oPag.AddObject("lbl_4c_MoedaConversao", "Label")
        WITH par_oPag.lbl_4c_MoedaConversao
            .Top       = 137
            .Left      = 406
            .Width     = 96
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Convers" + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CodMoeda (getCMoes): codigo da moeda de conversao
        *-- (CMoes char(3)). Lookup fwbuscaext (SigCdMoe) instalado no
        *-- LostFocus (THIS.AbrirLookupMoeda, logo abaixo).
        par_oPag.AddObject("txt_4c_CodMoeda", "TextBox")
        WITH par_oPag.txt_4c_CodMoeda
            .Top       = 133
            .Left      = 506
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Format    = "!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DescMoeda (getDMoes): descricao da moeda - o legado
        *-- tambem faz lookup por aqui digitando a descricao (getDMoes.Valid
        *-- com busca por DMoes), por isso NAO e ReadOnly.
        par_oPag.AddObject("txt_4c_DescMoeda", "TextBox")
        WITH par_oPag.txt_4c_DescMoeda
            .Top       = 133
            .Left      = 540
            .Width     = 385
            .Height    = 23
            .MaxLength = 15
            .Format    = "!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_GrupoVenda (Say14): "Grupo de Venda :" - Left=416, campo em 506
        par_oPag.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH par_oPag.lbl_4c_GrupoVenda
            .Top       = 190
            .Left      = 416
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo de Venda :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CdGrVda (getCdGrVda): codigo do Grupo de Venda (SigCdCol.Colecoes char(10))
        par_oPag.AddObject("txt_4c_CdGrVda", "TextBox")
        WITH par_oPag.txt_4c_CdGrVda
            .Top       = 186
            .Left      = 506
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .Format    = "K"
            .Alignment = 0
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DsGrVda (getDsGrVda): descricao do Grupo de Venda (SigCdCol.Descs char(40))
        par_oPag.AddObject("txt_4c_DsGrVda", "TextBox")
        WITH par_oPag.txt_4c_DsGrVda
            .Top       = 186
            .Left      = 591
            .Width     = 334
            .Height    = 23
            .MaxLength = 40
            .Format    = "K"
            .Alignment = 3
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Subgrupo (Say11): "Subgrupo :" - Left=447, campo em 506
        par_oPag.AddObject("lbl_4c_Subgrupo", "Label")
        WITH par_oPag.lbl_4c_Subgrupo
            .Top       = 163
            .Left      = 447
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Subgrupo :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__cd_sgrupo (get_cd_sgrupo): codigo do Subgrupo (SigCdPsg.codigos char(6))
        par_oPag.AddObject("txt_4c__cd_sgrupo", "TextBox")
        WITH par_oPag.txt_4c__cd_sgrupo
            .Top       = 159
            .Left      = 506
            .Width     = 52
            .Height    = 23
            .MaxLength = 6
            .Format    = "K!"
            .Alignment = 0
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__ds_sgrupo (get_ds_sgrupo): descricao do Subgrupo (SigCdPsg.descricaos char(20))
        par_oPag.AddObject("txt_4c__ds_sgrupo", "TextBox")
        WITH par_oPag.txt_4c__ds_sgrupo
            .Top       = 159
            .Left      = 561
            .Width     = 364
            .Height    = 23
            .MaxLength = 20
            .Format    = "K!"
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaFormFiltros - copia os filtros de Periodo/Moeda do BO para os
    * campos da Pagina 1. Chamado no InicializarForm (apos
    * CarregarFiltrosIniciais, que resolve a moeda padrao via SQL) e tambem
    * disponivel para re-sincronizar apos qualquer troca feita por codigo.
    *
    * PUBLIC (regra #51): pode ser chamado de fora pelo harness de teste.
    *==========================================================================
    PROCEDURE BOParaFormFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DataIni.Value   = THIS.this_oBusinessObject.this_dDataIni
        loc_oPag.txt_4c_DataFim.Value   = THIS.this_oBusinessObject.this_dDataFim
        loc_oPag.txt_4c_CodMoeda.Value  = THIS.this_oBusinessObject.this_cMoeda
        loc_oPag.txt_4c_DescMoeda.Value = THIS.this_oBusinessObject.this_cDescMoeda
        loc_oPag.txt_4c_CdGrVda.Value   = THIS.this_oBusinessObject.this_cGrupoVenda
        loc_oPag.txt_4c_DsGrVda.Value   = THIS.this_oBusinessObject.this_cDescGrupoVenda
        loc_oPag.txt_4c__cd_sgrupo.Value = THIS.this_oBusinessObject.this_cSubGrupo
        loc_oPag.txt_4c__ds_sgrupo.Value = THIS.this_oBusinessObject.this_cDescSubGrupo
    ENDPROC

    *==========================================================================
    * LostFocus dos campos de Periodo/Moeda - sincronizam o valor digitado de
    * volta para as properties do BO, que sao a fonte lida por
    * BtnConsultarClick (THIS.this_oBusinessObject.this_dDataIni/this_dDataFim/
    * this_cMoeda). ConverterParaData normaliza DATE/DATETIME/CHAR (regra #16
    * - TTOD so aceita DATETIME e o .Value de TextBox nasce DATE).
    *==========================================================================
    PROCEDURE TxtDataIniLostFocus()
        THIS.this_oBusinessObject.this_dDataIni = ConverterParaData(THIS.pgf_4c_Paginas.Page1.txt_4c_DataIni.Value)
    ENDPROC

    PROCEDURE TxtDataFimLostFocus()
        THIS.this_oBusinessObject.this_dDataFim = ConverterParaData(THIS.pgf_4c_Paginas.Page1.txt_4c_DataFim.Value)
    ENDPROC

    *==========================================================================
    * TxtCodMoedaLostFocus / TxtDescMoedaLostFocus - sincronizam o codigo/
    * descricao digitados com o BO e resolvem via lookup fwbuscaext
    * (SigCdMoe no legado -> FormBuscaAuxiliar, THIS.AbrirLookupMoeda).
    *
    * Guarda de reentrancia (regra #37/#47, this_lEmLookupFiltro): o picker
    * e MODAL e tira o foco do campo, o que redispara o proprio LostFocus.
    * O corpo mora no metodo *Exec para a flag ser SEMPRE liberada, mesmo
    * nos RETURN antecipados de dentro dele.
    *==========================================================================
    PROCEDURE TxtCodMoedaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCodMoedaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCodMoedaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_CodMoeda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_CodMoeda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_CodMoeda.Value)
            loc_oPag.txt_4c_DescMoeda.Value = ""
            THIS.this_oBusinessObject.this_cMoeda     = ""
            THIS.this_oBusinessObject.this_cDescMoeda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda("CMoes", loc_oPag.txt_4c_CodMoeda.Value)
    ENDPROC

    PROCEDURE TxtDescMoedaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDescMoedaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDescMoedaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DescMoeda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_DescMoeda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_DescMoeda.Value)
            loc_oPag.txt_4c_CodMoeda.Value = ""
            THIS.this_oBusinessObject.this_cMoeda     = ""
            THIS.this_oBusinessObject.this_cDescMoeda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda("DMoes", loc_oPag.txt_4c_DescMoeda.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupMoeda - fwbuscaext(SigCdMoe) do legado -> FormBuscaAuxiliar.
    * par_cCampoBusca - "CMoes" (busca por codigo) ou "DMoes" (busca por
    * descricao), conforme o campo que disparou o LostFocus.
    *
    * O Init de FormBuscaAuxiliar JA tenta o match EXATO (regra #37):
    * achando 1 registro, resolve sozinho (this_lAchouRegistro +
    * this_lSelecionou) sem exibir dialogo - por isso NAO ha SQLEXEC proprio
    * de pre-checagem aqui (regra #37 - duplicar a checagem so cria caminho
    * para divergir). Universo vazio NUNCA avisa nem apaga o digitado
    * (regra #50) - so abre o picker, que ja mostra a lista completa.
    *==========================================================================
    PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValorBusca, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    loc_oPag.txt_4c_CodMoeda.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                    loc_oPag.txt_4c_DescMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                    THIS.this_oBusinessObject.this_cMoeda     = loc_oPag.txt_4c_CodMoeda.Value
                    THIS.this_oBusinessObject.this_cDescMoeda = loc_oPag.txt_4c_DescMoeda.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdGrVdaLostFocus / TxtDsGrVdaLostFocus - sincronizam o Grupo de
    * Venda digitado com o BO e resolvem via lookup fwbuscaext (SigCdCol no
    * legado -> FormBuscaAuxiliar, THIS.AbrirLookupGrupoVenda). Mesma guarda
    * de reentrancia de TxtCodMoedaLostFocus (this_lEmLookupFiltro).
    *==========================================================================
    PROCEDURE TxtCdGrVdaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCdGrVdaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCdGrVdaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_CdGrVda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_CdGrVda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_CdGrVda.Value)
            loc_oPag.txt_4c_DsGrVda.Value = ""
            THIS.this_oBusinessObject.this_cGrupoVenda     = ""
            THIS.this_oBusinessObject.this_cDescGrupoVenda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoVenda("Colecoes", loc_oPag.txt_4c_CdGrVda.Value)
    ENDPROC

    PROCEDURE TxtDsGrVdaLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDsGrVdaLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDsGrVdaLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c_DsGrVda.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c_DsGrVda.Value, "")))

        IF EMPTY(loc_oPag.txt_4c_DsGrVda.Value)
            loc_oPag.txt_4c_CdGrVda.Value = ""
            THIS.this_oBusinessObject.this_cGrupoVenda     = ""
            THIS.this_oBusinessObject.this_cDescGrupoVenda = ""
            RETURN
        ENDIF

        THIS.AbrirLookupGrupoVenda("Descs", loc_oPag.txt_4c_DsGrVda.Value)
    ENDPROC

    *==========================================================================
    * TxtDsGrVdaGotFocus - equivalente ao When do legado em getDsGrVda
    * (Return Empty(This.Parent.getCdGrVda.Value)): a descricao so e
    * editavel enquanto o codigo estiver vazio - com codigo preenchido, o
    * campo serve so para EXIBIR o que o lookup do codigo resolveu, e o
    * foco volta para o campo de codigo.
    *==========================================================================
    PROCEDURE TxtDsGrVdaGotFocus()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(loc_oPag.txt_4c_CdGrVda.Value)
            loc_oPag.txt_4c_CdGrVda.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoVenda - fwbuscaext(SigCdCol) do legado ->
    * FormBuscaAuxiliar. par_cCampoBusca - "Colecoes" (busca por codigo) ou
    * "Descs" (busca por descricao). Mesmo contrato de AbrirLookupMoeda
    * (regra #37/#50).
    *==========================================================================
    PROCEDURE AbrirLookupGrupoVenda(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaGrVda", par_cCampoBusca, par_cValorBusca, ;
                "Grupo de Venda", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVda")
                    loc_oPag.txt_4c_CdGrVda.Value = ALLTRIM(cursor_4c_BuscaGrVda.Colecoes)
                    loc_oPag.txt_4c_DsGrVda.Value = ALLTRIM(cursor_4c_BuscaGrVda.Descs)
                    THIS.this_oBusinessObject.this_cGrupoVenda     = loc_oPag.txt_4c_CdGrVda.Value
                    THIS.this_oBusinessObject.this_cDescGrupoVenda = loc_oPag.txt_4c_DsGrVda.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrVda")
                USE IN cursor_4c_BuscaGrVda
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupoVenda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdSgrupoLostFocus / TxtDsSgrupoLostFocus - sincronizam o Subgrupo
    * digitado com o BO e resolvem via lookup fwbuscaext (SigCdPsg no
    * legado -> FormBuscaAuxiliar, THIS.AbrirLookupSubgrupo). O legado nao
    * passa filtro de Grupo (lcCgru = [] no Valid original) - a busca e
    * SEMPRE pelo universo inteiro de SigCdPsg, igual ao legado.
    *==========================================================================
    PROCEDURE TxtCdSgrupoLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtCdSgrupoLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtCdSgrupoLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c__cd_sgrupo.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c__cd_sgrupo.Value, "")))

        IF EMPTY(loc_oPag.txt_4c__cd_sgrupo.Value)
            loc_oPag.txt_4c__ds_sgrupo.Value = ""
            THIS.this_oBusinessObject.this_cSubGrupo     = ""
            THIS.this_oBusinessObject.this_cDescSubGrupo = ""
            RETURN
        ENDIF

        THIS.AbrirLookupSubgrupo("Codigos", loc_oPag.txt_4c__cd_sgrupo.Value)
    ENDPROC

    PROCEDURE TxtDsSgrupoLostFocus()
        IF THIS.this_lEmLookupFiltro
            RETURN
        ENDIF
        THIS.this_lEmLookupFiltro = .T.
        THIS.TxtDsSgrupoLostFocusExec()
        THIS.this_lEmLookupFiltro = .F.
    ENDPROC

    PROTECTED PROCEDURE TxtDsSgrupoLostFocusExec()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.txt_4c__ds_sgrupo.Value = UPPER(ALLTRIM(NVL(loc_oPag.txt_4c__ds_sgrupo.Value, "")))

        IF EMPTY(loc_oPag.txt_4c__ds_sgrupo.Value)
            loc_oPag.txt_4c__cd_sgrupo.Value = ""
            THIS.this_oBusinessObject.this_cSubGrupo     = ""
            THIS.this_oBusinessObject.this_cDescSubGrupo = ""
            RETURN
        ENDIF

        THIS.AbrirLookupSubgrupo("Descricaos", loc_oPag.txt_4c__ds_sgrupo.Value)
    ENDPROC

    *==========================================================================
    * AbrirLookupSubgrupo - fwbuscaext(SigCdPsg) do legado ->
    * FormBuscaAuxiliar. par_cCampoBusca - "Codigos" (busca por codigo) ou
    * "Descricaos" (busca por descricao). Mesmo contrato de
    * AbrirLookupMoeda/AbrirLookupGrupoVenda (regra #37/#50).
    *==========================================================================
    PROCEDURE AbrirLookupSubgrupo(par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oPag, loc_oBusca, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSubgrupo", par_cCampoBusca, par_cValorBusca, ;
                "Sub-Grupos", .F., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "Sub-Grupo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSubgrupo")
                    loc_oPag.txt_4c__cd_sgrupo.Value = ALLTRIM(cursor_4c_BuscaSubgrupo.Codigos)
                    loc_oPag.txt_4c__ds_sgrupo.Value = ALLTRIM(cursor_4c_BuscaSubgrupo.Descricaos)
                    THIS.this_oBusinessObject.this_cSubGrupo     = loc_oPag.txt_4c__cd_sgrupo.Value
                    THIS.this_oBusinessObject.this_cDescSubGrupo = loc_oPag.txt_4c__ds_sgrupo.Value
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSubgrupo")
                USE IN cursor_4c_BuscaSubgrupo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupSubgrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGradesMarcacao - Grades de marcacao da Pagina 1 (empresas,
    * tipos de operacao, grande grupo, grupo de produtos, operacoes) + os
    * botoes que marcam/desmarcam em lote + o grupo Consultar/Sair
    * (cmgFiltros no legado). Cria so a CASCA dos grids (sem RecordSource -
    * os cursores ainda nao existem aqui): THIS.CarregarDados() liga
    * o RecordSource depois que this_oBusinessObject.CarregarFiltrosIniciais()
    * roda (regra #41 - ControlSource antes do cursor existir derruba o Init).
    *
    * Nomes dos grids NAO seguem mapeamento.json (que colide os 5 grids em
    * "grd_4c_Dados" - mapeamento gerado automaticamente por classe-base,
    * sem distinguir irmaos): usar os nomes conceituais, os mesmos dos
    * cursores do BO (cursor_4c_Empresas/TiposOperacao/GrandeGrupo/
    * GrupoProduto/Operacoes).
    *==========================================================================
    * O CheckBox de LINHA de cada grade NAO nasce aqui: criar
    * Column1.AddObject("Check1","CheckBox") neste ponto estoura
    * "Error with CHECK1 - Value : Data type mismatch" e a tela nao abre,
    * porque o Grid sem RecordSource se auto-liga ao alias CORRENTE quando o
    * ColumnCount e definido. O CheckBox e instalado no funil CarregarDados,
    * depois do bind - ver o comentario la.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradesMarcacao(par_oPag)

        *-- grd_4c_Empresas (grdEmps no legado): marcacao (Imps) + Cod (cemps)
        *-- + Empresa (razas). O CheckBox desta grade NAO leva BINDEVENT - no
        *-- legado os 4 handlers de grdEmps.Column1.Check1 estao COMENTADOS
        *-- no SCX, ou seja o toggle individual da celula e NATIVO
        *-- (Column1.ReadOnly = .F.) e a marcacao em lote vem de
        *-- cmg_4c_Empresas e chk_4c_Ck_MarcaEmp.
        par_oPag.AddObject("grd_4c_Empresas", "Grid")
        WITH par_oPag.grd_4c_Empresas
            .Top               = 238
            .Left              = 71
            .Width             = 318
            .Height            = 410
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .ForeColor         = RGB(0, 0, 0)
            .GridLineColor     = RGB(238, 238, 238)
            *-- Grid.ReadOnly ANTES dos Column.ReadOnly (regra #18): o do grid
            *-- propaga para as colunas e sobrescreveria o que vem depois.
            *-- .F. transcrito do montagrades legado (grdEmps e a UNICA das 5
            *-- grades cuja Column1 e editavel nativamente - as outras 4
            *-- travam Column1 e alternam so pelos handlers com NODEFAULT).
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH
        WITH par_oPag.grd_4c_Empresas.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Empresas.Column1.Header1.ForeColor = RGB(90, 90, 90)
        *-- Column2/Column3: "For I=2 To .ColumnCount" do montagrades legado
        WITH par_oPag.grd_4c_Empresas.Column2
            .Width     = 33
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column2.Header1.Caption   = "Cod."
        par_oPag.grd_4c_Empresas.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Empresas.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Empresas.Column3
            .Width     = 247
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_Empresas.Column3.Header1.Caption   = "Empresa"
        par_oPag.grd_4c_Empresas.Column3.Header1.Alignment = 2
        par_oPag.grd_4c_Empresas.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmg_4c_Empresas (cmdEmps no legado): Marcar/Desmarcar Tudo de Empresas
        par_oPag.AddObject("cmg_4c_Empresas", "CommandGroup")
        WITH par_oPag.cmg_4c_Empresas
            .Top         = 382
            .Left        = 388
            .Width       = 50
            .Height      = 91
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            WITH .Buttons(1)
                .Top         = 1
                .Left        = 4
                .Width       = 45
                .Height      = 45
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Caption     = ""
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .ToolTipText = "Marcar Todas as Empresas"
                .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            ENDWITH
            WITH .Buttons(2)
                .Top         = 46
                .Left        = 4
                .Width       = 45
                .Height      = 45
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .Caption     = ""
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .ToolTipText = "Desmarcar Todas as Empresas"
                .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado) - Top/Left EXATOS do
        *-- SCX (Left = -2, quase fora da pagina - transcrito fielmente,
        *-- regra #28/PILAR 1: nao inventar posicao nova)
        par_oPag.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
        WITH par_oPag.chk_4c_Ck_MarcaEmp
            .Top       = 314
            .Left      = -2
            .Width     = 13
            .Height    = 16
            .Alignment = 0
            .Caption   = ""
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        *-- grd_4c_Tipos (grdTipo no legado): marcacao (nMarcas) + Tipo de Operacao
        par_oPag.AddObject("grd_4c_Tipos", "Grid")
        WITH par_oPag.grd_4c_Tipos
            .Top            = 238
            .Left           = 469
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 244)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_Tipos.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Tipos.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Tipos.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Tipos.Column2
            .Width     = 282
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Tipos.Column2.Header1.Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
        par_oPag.grd_4c_Tipos.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Tipos.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarca / cmd_4c_BtnDesmarca: marca/desmarca TODOS os
        *-- Tipos de Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no
        *-- legado - coluna de botoes a direita de grd_4c_Tipos)
        par_oPag.AddObject("cmd_4c_BtnMarca", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarca
            .Top         = 286
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar Tudo"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesmarca", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesmarca
            .Top         = 331
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- cmd_4c_Command1 / cmd_4c_Command2: marca/desmarca so as
        *-- Operacoes do Tipo de Operacao CORRENTE em grd_4c_Tipos
        *-- (Command1/Command2 no legado, mesma coluna, mais abaixo)
        par_oPag.AddObject("cmd_4c_Command1", "CommandButton")
        WITH par_oPag.cmd_4c_Command1
            .Top         = 489
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar Tudo"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Command2", "CommandButton")
        WITH par_oPag.cmd_4c_Command2
            .Top         = 534
            .Left        = 796
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_GrandeGrupo (grdMercs no legado): marcacao (nMarcas) + Grande Grupo
        par_oPag.AddObject("grd_4c_GrandeGrupo", "Grid")
        WITH par_oPag.grd_4c_GrandeGrupo
            .Top            = 238
            .Left           = 880
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_GrandeGrupo.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrandeGrupo.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_GrandeGrupo.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrandeGrupo.Column2
            .Width     = 283
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Caption   = "Grande Grupo"
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_GrandeGrupo.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarGde / cmd_4c_BtnDesGde: marca/desmarca TODO o
        *-- Grande Grupo (e em cascata o Grupo de Produto - BtnMarGdeClick/
        *-- BtnDesGdeClick)
        par_oPag.AddObject("cmd_4c_BtnMarGde", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarGde
            .Top         = 286
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesGde", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesGde
            .Top         = 331
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_GrupoProduto (grdCGrus no legado): marcacao (nMarcas) + Gde + Grupo de Produto
        par_oPag.AddObject("grd_4c_GrupoProduto", "Grid")
        WITH par_oPag.grd_4c_GrupoProduto
            .Top            = 446
            .Left           = 880
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 3
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_GrupoProduto.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_GrupoProduto.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrupoProduto.Column2
            .Width     = 30
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.Caption   = "Gde"
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_GrupoProduto.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_GrupoProduto.Column3
            .Width     = 252
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.Caption   = "Grupo de Produto"
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.Alignment = 2
        par_oPag.grd_4c_GrupoProduto.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmd_4c_BtnMarGrp / cmd_4c_BtnDesGrp: marca/desmarca o Grupo de
        *-- Produto (btnMarGrp so marca onde o Grande Grupo pai ja esta
        *-- marcado - igual ao legado)
        par_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMarGrp
            .Top         = 489
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Selecionar"
            .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
        WITH par_oPag.cmd_4c_BtnDesGrp
            .Top         = 534
            .Left        = 1207
            .Width       = 45
            .Height      = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Caption     = ""
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
            *-- com .Picture nao renderiza o icone com Themes = .F.
            *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
            *-- canonico do projeto para botao solto; Buttons(N) de
            *-- CommandGroup continuam com .F.
            .Themes      = .T.
            .TabStop     = .F.
            .ToolTipText = "Desmarcar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible = .T.
        ENDWITH

        *-- grd_4c_Operacoes (GrdOpera no legado): marcacao (nMarcas) + Operacoes (Dopes)
        par_oPag.AddObject("grd_4c_Operacoes", "Grid")
        WITH par_oPag.grd_4c_Operacoes
            .Top            = 446
            .Left           = 470
            .Width          = 323
            .Height         = 196
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 244)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
            .RecordMark   = .F.
        ENDWITH
        WITH par_oPag.grd_4c_Operacoes.Column1
            .Width     = 18
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
            *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
            *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Operacoes.Column1.Header1.Caption   = ""
        par_oPag.grd_4c_Operacoes.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH par_oPag.grd_4c_Operacoes.Column2
            .Width     = 282
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        par_oPag.grd_4c_Operacoes.Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
        par_oPag.grd_4c_Operacoes.Column2.Header1.Alignment = 2
        par_oPag.grd_4c_Operacoes.Column2.Header1.ForeColor = RGB(90, 90, 90)

        *-- cmg_4c_Filtros (cmgFiltros no legado): Consultar / Sair
        par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
        WITH par_oPag.cmg_4c_Filtros
            .Top         = -1
            .Left        = 1135
            .Width       = 173
            .Height      = 110
            .ButtonCount = 2
            .Value       = 0
            WITH .Buttons(1)
                .Top         = 5
                .Left        = 11
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "\<Consultar"
                .ToolTipText = "Consultar Usando os Filtros Informados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            ENDWITH
            WITH .Buttons(2)
                .Top         = 5
                .Left        = 87
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Cancel      = .T.
                .Caption     = "\<Sair"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL unico de bind + repintura das 5 grades de
    * marcacao. Equivalente ao montagrades() do legado, que faz exatamente
    * este bind para grdTipo/grdOpera/grdMercs/grdCGrus/grdEmps.
    *
    * A ORDEM abaixo e OBRIGATORIA e foi medida no VFP9:
    *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
    *   AddObject do CheckBox (+ .Value = 0) -> Sparse + CurrentControl ->
    *   Grid.ReadOnly -> Column.ReadOnly -> Width -> Header1.Caption
    *
    * Por que o CheckBox NAO pode nascer em ConfigurarGradesMarcacao: Grid
    * sem RecordSource atribuida se liga sozinho ao alias CORRENTE no momento
    * em que o ColumnCount e definido. Com isso a Column1 herda o
    * ControlSource de uma coluna qualquer desse alias; se ela for CHARACTER,
    * o Column1.AddObject("Check1","CheckBox") estoura no PROPRIO AddObject
    * com "Error with CHECK1 - Value : Data type mismatch", o erro cai no TRY
    * do InicializarForm, CREATEOBJECT devolve .F. e a TELA NAO ABRE - sem
    * erro visivel e compilando limpo (medido no probe desta fase).
    *
    * E por que o funil, e nao o ConfigurarGrid: fechar/recriar o alias que e
    * RecordSource do Grid DESTROI o objeto posto por Column.AddObject (a
    * Column volta a desenhar o Text1 e o usuario ve 0/1 cru, sem como
    * marcar). Por isso a instalacao do CheckBox e IDEMPOTENTE
    * (GarantirCheckBoxColuna) e os BINDEVENT vao JUNTO com ela - objeto
    * recriado e outro objeto, e as ligacoes do anterior morreram com ele.
    *
    * Fecha cada grade com GO TOP + Refresh: popular o cursor NAO repinta a
    * grade sozinho.
    *
    * As grades de RESULTADO (pgRes01/02/03 -> grd_4c_Dados1/2/3), que no
    * legado sao ligadas pelo MESMO montagrades, entram na Fase 7 - e o bind
    * delas vem para este mesmo funil.
    *==========================================================================
    *-- PUBLIC (nao PROTECTED): e o funil de repintura, chamado de fora pelo
    *-- harness de teste e pelos caminhos de recarga.
    PROCEDURE CarregarDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Empresas: a UNICA das 5 cuja Column1 e editavel nativamente
        *-- (montagrades legado: grdEmps.Column1.ReadOnly = .F.)
        IF USED("cursor_4c_Empresas")
            WITH loc_oPag.grd_4c_Empresas
                .ColumnCount             = 3
                .RecordSource            = "cursor_4c_Empresas"
                .Column1.ControlSource   = "cursor_4c_Empresas.Imps"
                .Column2.ControlSource   = "cursor_4c_Empresas.cemps"
                .Column3.ControlSource   = "cursor_4c_Empresas.razas"
            ENDWITH
            *-- sem prefixo de handler: no SCX legado os 4 handlers de
            *-- grdEmps.Column1.Check1 estao COMENTADOS, ou seja o toggle
            *-- individual e nativo (Column1.ReadOnly = .F.) e a marcacao em
            *-- lote vem de cmg_4c_Empresas / chk_4c_Ck_MarcaEmp.
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Empresas.Column1, "", .F., .F.)
            WITH loc_oPag.grd_4c_Empresas
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .ReadOnly                 = .F.
                .Column1.ReadOnly         = .F.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.
                .Column1.Width            = 15
                .Column2.Width            = 33
                .Column3.Width            = 247
                .Column2.Header1.Caption  = "Cod."
                .Column3.Header1.Caption  = "Empresa"
            ENDWITH
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF

        *-- Tipos de Operacao
        IF USED("cursor_4c_TiposOperacao")
            WITH loc_oPag.grd_4c_Tipos
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_TiposOperacao"
                .Column1.ControlSource   = "cursor_4c_TiposOperacao.nMarcas"
                .Column2.ControlSource   = "cursor_4c_TiposOperacao.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Tipos.Column1, "ChkTipo", .T., .T.)
            WITH loc_oPag.grd_4c_Tipos
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 282
                .Column2.Header1.Caption  = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF

        *-- Grande Grupo
        IF USED("cursor_4c_GrandeGrupo")
            WITH loc_oPag.grd_4c_GrandeGrupo
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_GrandeGrupo"
                .Column1.ControlSource   = "cursor_4c_GrandeGrupo.nMarcas"
                .Column2.ControlSource   = "cursor_4c_GrandeGrupo.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrandeGrupo.Column1, "ChkGrandeGrupo", .T., .F.)
            WITH loc_oPag.grd_4c_GrandeGrupo
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 283
                .Column2.Header1.Caption  = "Grande Grupo"
            ENDWITH
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF

        *-- Grupo de Produto
        IF USED("cursor_4c_GrupoProduto")
            WITH loc_oPag.grd_4c_GrupoProduto
                .ColumnCount             = 3
                .RecordSource            = "cursor_4c_GrupoProduto"
                .Column1.ControlSource   = "cursor_4c_GrupoProduto.nMarcas"
                .Column2.ControlSource   = "cursor_4c_GrupoProduto.Mercs"
                .Column3.ControlSource   = "cursor_4c_GrupoProduto.CDescricaos"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrupoProduto.Column1, "ChkGrupoProduto", .T., .F.)
            WITH loc_oPag.grd_4c_GrupoProduto
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column3.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 30
                .Column3.Width            = 252
                .Column2.Header1.Caption  = "Gde"
                .Column3.Header1.Caption  = "Grupo de Produto"
            ENDWITH
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF

        *-- Operacoes
        IF USED("cursor_4c_Operacoes")
            WITH loc_oPag.grd_4c_Operacoes
                .ColumnCount             = 2
                .RecordSource            = "cursor_4c_Operacoes"
                .Column1.ControlSource   = "cursor_4c_Operacoes.nMarcas"
                .Column2.ControlSource   = "cursor_4c_Operacoes.Dopes"
            ENDWITH
            THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Operacoes.Column1, "ChkOperacao", .T., .T.)
            WITH loc_oPag.grd_4c_Operacoes
                .Column1.Sparse           = .F.
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Alignment = 0
                .Column1.Check1.ReadOnly  = .F.
                .Column1.Check1.Visible   = .T.
                .Column1.Check1.Top       = 9
                .Column1.Check1.Left      = 2
                .Column1.Check1.Height    = 17
                .Column1.Check1.Width     = 22
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Column1.CurrentControl   = "Check1"
                .Column1.ReadOnly         = .T.
                .Column2.ReadOnly         = .T.
                .Column1.Width            = 18
                .Column2.Width            = 282
                .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(245) + "es"
            ENDWITH
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxColuna - instalador IDEMPOTENTE do CheckBox de marcacao
    * de uma Column de Grid. Chamado SO depois de RecordSource/ControlSource
    * estarem ligados (ver comentario de CarregarDados).
    *
    *   par_oColuna    - a Column que recebe o controle
    *   par_cPrefixo   - prefixo dos handlers de alternancia ("ChkTipo", ...);
    *                    vazio = coluna com toggle NATIVO, sem BINDEVENT
    *   par_lGeometria - transcreve Top/Left/Width/Height/Alignment do SCX
    *   par_lBackColor - transcreve BackColor branco do SCX
    *
    * Sai sem fazer nada se o controle ainda existe: AddObject repetido com o
    * mesmo nome estoura "Object CHECK1 is already defined". Os BINDEVENT vao
    * JUNTO porque um objeto recriado e outro objeto - sem religar, os quatro
    * handlers de alternancia ficam MUDOS (o CheckBox aparece e nao alterna).
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxColuna(par_oColuna, par_cPrefixo, par_lGeometria, par_lBackColor)
        IF PEMSTATUS(par_oColuna, "Check1", 5)
            RETURN
        ENDIF

        par_oColuna.AddObject("Check1", "CheckBox")

        WITH par_oColuna.Check1
            .Caption   = ""
            *-- .Value NUMERICO (nunca .F.): a Column esta ligada a coluna
            *-- numerica de marcacao e CheckBox logico daria type mismatch.
            .Value     = 0
            .ForeColor = RGB(0, 0, 0)
            IF par_lGeometria
                .Top       = 23
                .Left      = 35
                .Width     = 60
                .Height    = 17
                .Alignment = 0
            ENDIF
            IF par_lBackColor
                .BackColor = RGB(255, 255, 255)
            ENDIF
            .Visible   = .T.
        ENDWITH

        IF !EMPTY(par_cPrefixo)
            *-- Os 4 handlers do legado: Click/MouseDown so SUPRIMEM o toggle
            *-- nativo (NODEFAULT) e MouseUp delega ao KeyPress, que e quem
            *-- faz o REPLACE e o Refresh.
            BINDEVENT(par_oColuna.Check1, "KeyPress",  THIS, par_cPrefixo + "KeyPress")
            BINDEVENT(par_oColuna.Check1, "MouseUp",   THIS, par_cPrefixo + "MouseUp")
            BINDEVENT(par_oColuna.Check1, "MouseDown", THIS, par_cPrefixo + "MouseDown")
            BINDEVENT(par_oColuna.Check1, "Click",     THIS, par_cPrefixo + "Click")
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsFiltros - BINDEVENTs dos botoes e grupos de
    * marcar/desmarcar/consultar/sair da pagina de filtros.
    *
    * Os BINDEVENT dos CheckBox de LINHA das grades NAO moram aqui: eles vao
    * dentro de GarantirCheckBoxColuna, junto com o AddObject que cria o
    * controle. Motivo: o controle de Column pode ser destruido quando o
    * alias do RecordSource e fechado/recriado, e o objeto reinstalado e
    * OUTRO objeto - religar fora do instalador deixaria os handlers mudos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Botoes em lote
        BINDEVENT(loc_oPag.cmd_4c_BtnMarca,    "Click", THIS, "BtnMarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesmarca, "Click", THIS, "BtnDesmarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_Command1,    "Click", THIS, "Command1Click")
        BINDEVENT(loc_oPag.cmd_4c_Command2,    "Click", THIS, "Command2Click")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGde,   "Click", THIS, "BtnMarGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGde,   "Click", THIS, "BtnDesGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGrp,   "Click", THIS, "BtnMarGrpClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGrp,   "Click", THIS, "BtnDesGrpClick")

        *-- Empresas (marcar/desmarcar tudo)
        BINDEVENT(loc_oPag.cmg_4c_Empresas,     "Click", THIS, "CmdEmpsClick")
        BINDEVENT(loc_oPag.chk_4c_Ck_MarcaEmp, "Click", THIS, "CkMarcaEmpClick")

        *-- Consultar / Sair
        BINDEVENT(loc_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")

        *-- Periodo (Fase 5 - Parte 1)
        BINDEVENT(loc_oPag.txt_4c_DataIni,  "LostFocus", THIS, "TxtDataIniLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DataFim,  "LostFocus", THIS, "TxtDataFimLostFocus")

        *-- Moeda de Conversao - lookup fwbuscaext(SigCdMoe) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c_CodMoeda,  "LostFocus", THIS, "TxtCodMoedaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DescMoeda, "LostFocus", THIS, "TxtDescMoedaLostFocus")

        *-- Grupo de Venda - lookup fwbuscaext(SigCdCol) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c_CdGrVda, "LostFocus", THIS, "TxtCdGrVdaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DsGrVda, "LostFocus", THIS, "TxtDsGrVdaLostFocus")
        BINDEVENT(loc_oPag.txt_4c_DsGrVda, "GotFocus",  THIS, "TxtDsGrVdaGotFocus")

        *-- Subgrupo - lookup fwbuscaext(SigCdPsg) (Fase 6)
        BINDEVENT(loc_oPag.txt_4c__cd_sgrupo, "LostFocus", THIS, "TxtCdSgrupoLostFocus")
        BINDEVENT(loc_oPag.txt_4c__ds_sgrupo, "LostFocus", THIS, "TxtDsSgrupoLostFocus")

        *-- Tipo de Operacao corrente FILTRA a grade de Operacoes
        *-- (grdTipo.AfterRowColChange no legado)
        BINDEVENT(loc_oPag.grd_4c_Tipos, "AfterRowColChange", THIS, "GrdTiposAfterRowColChange")
    ENDPROC

    *==========================================================================
    * GrdTiposAfterRowColChange - grdTipo.AfterRowColChange no legado:
    *
    *   Select CrOpera
    *   Set Key To crTpOpe.Codigos
    *   Go Top
    *   This.parent.GrdOpera.Refresh
    *   Select crTpOpe
    *
    * Ao trocar de linha na grade de TIPOS, a grade de OPERACOES passa a
    * mostrar SOMENTE as operacoes daquele tipo. O SET KEY depende da TAG
    * IdxTipoOps (criada em BO.CarregarFiltrosIniciais, igual ao Init
    * legado); o SET ORDER explicito abaixo NAO esta no legado - la o tag
    * recem-criado ainda e o controlador - mas aqui garante o resultado
    * mesmo que algum outro ponto troque a ordem do cursor.
    *
    * Chave de UM campo NUMERICO inteiro (SigCdOpe.tipoops numeric(2,0) x
    * SigCdTom.codigos numeric(2,0)): e match EXATO de chave COMPLETA,
    * portanto imune ao SET EXACT ON global do config.prg (a armadilha
    * medida vale para SET KEY com valor PARCIAL de chave composta).
    *
    * Os filtros do Consultar continuam enxergando o cursor INTEIRO: o
    * BO monta a lista de operacoes marcadas com SQL SELECT, e SELECT do
    * VFP9 ignora SET KEY/SET FILTER (medido) - mesma razao pela qual o
    * legado podia conviver com este SET KEY permanente.
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - regra #3. A
    * assinatura declara o parametro que AfterRowColChange passa.
    *==========================================================================
    PROCEDURE GrdTiposAfterRowColChange(par_nColIndex)
        LOCAL loc_oPag, loc_oErro

        IF !USED("cursor_4c_Operacoes") OR !USED("cursor_4c_TiposOperacao")
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- TRY sem RETURN dentro (regra #1): o handler roda a CADA troca de
        *-- linha e fora de qualquer TRY do chamador - sem isto, cursor sem
        *-- a TAG IdxTipoOps viraria Program Error cru a cada clique.
        TRY
            SELECT cursor_4c_Operacoes
            SET ORDER TO TAG IdxTipoOps
            SET KEY TO cursor_4c_TiposOperacao.Codigos
            GO TOP

            loc_oPag.grd_4c_Operacoes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao filtrar Opera" + CHR(231) + CHR(245) + "es")
        ENDTRY

        SELECT cursor_4c_TiposOperacao
    ENDPROC

    *==========================================================================
    * GRADE TIPOS DE OPERACAO - checkbox Column1 (grdTipo.Column1.Check1 no
    * legado). Ao marcar/desmarcar um Tipo, cascateia para as Operacoes
    * (cursor_4c_Operacoes.nMarcas) daquele Tipo - igual ao legado.
    *==========================================================================
    PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_TiposOperacao")
                REPLACE cursor_4c_TiposOperacao.nMarcas WITH IIF(cursor_4c_TiposOperacao.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_Tipos.Refresh()
                IF USED("cursor_4c_Operacoes")
                    UPDATE cursor_4c_Operacoes SET nMarcas = cursor_4c_TiposOperacao.nMarcas ;
                        WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
                    loc_oPag.grd_4c_Operacoes.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkTipoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkTipoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE GRANDE GRUPO - checkbox Column1 (grdMercs.Column1.Check1 no
    * legado). Ao marcar/desmarcar um Grande Grupo, cascateia para o Grupo
    * de Produto filho (cursor_4c_GrupoProduto.nMarcas) - igual ao legado.
    *==========================================================================
    PROCEDURE ChkGrandeGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_GrandeGrupo")
                REPLACE cursor_4c_GrandeGrupo.nMarcas WITH IIF(cursor_4c_GrandeGrupo.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_GrandeGrupo.Refresh()
                IF USED("cursor_4c_GrupoProduto")
                    UPDATE cursor_4c_GrupoProduto SET nMarcas = cursor_4c_GrandeGrupo.nMarcas ;
                        WHERE Mercs = cursor_4c_GrandeGrupo.Codigos
                    loc_oPag.grd_4c_GrupoProduto.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkGrandeGrupoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkGrandeGrupoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrandeGrupoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrandeGrupoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE GRUPO DE PRODUTO - checkbox Column1 (grdCGrus.Column1.Check1 no
    * legado). Ao MARCAR um Grupo de Produto, exige que o Grande Grupo pai
    * (cursor_4c_GrandeGrupo) ja esteja marcado - senao desfaz e avisa,
    * igual ao legado.
    *==========================================================================
    PROCEDURE ChkGrupoProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cMercsPai
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_GrupoProduto")
                REPLACE cursor_4c_GrupoProduto.nMarcas WITH IIF(cursor_4c_GrupoProduto.nMarcas = 0, 1, 0)

                IF cursor_4c_GrupoProduto.nMarcas = 1 AND USED("cursor_4c_GrandeGrupo")
                    loc_cMercsPai = cursor_4c_GrupoProduto.Mercs
                    SELECT cursor_4c_GrandeGrupo
                    LOCATE FOR Codigos = loc_cMercsPai
                    IF !FOUND() OR cursor_4c_GrandeGrupo.nMarcas = 0
                        SELECT cursor_4c_GrupoProduto
                        REPLACE nMarcas WITH 0
                        MsgAviso("O Grande Grupo " + CHR(34) + ALLTRIM(loc_cMercsPai) + CHR(34) + " N" + CHR(227) + "o Foi Selecionado." + CHR(13) + ;
                            "Para Selecionar Esse Grupo, Ajuste o Grande Grupo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                    ENDIF
                ENDIF

                SELECT cursor_4c_GrupoProduto
                loc_oPag.grd_4c_GrupoProduto.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkGrupoProdutoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkGrupoProdutoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrupoProdutoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkGrupoProdutoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRADE OPERACOES - checkbox Column1 (GrdOpera.Column1.Check1 no legado)
    *==========================================================================
    PROCEDURE ChkOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 32)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF USED("cursor_4c_Operacoes")
                REPLACE cursor_4c_Operacoes.nMarcas WITH IIF(cursor_4c_Operacoes.nMarcas = 0, 1, 0)
                loc_oPag.grd_4c_Operacoes.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkOperacaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkOperacaoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkOperacaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkOperacaoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * Command1Click / Command2Click - marcam/desmarcam so as Operacoes do
    * Tipo de Operacao CORRENTE em grd_4c_Tipos (Command1/Command2 no legado)
    *==========================================================================
    PROCEDURE Command1Click()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_Operacoes SET nMarcas = 1 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Command2Click()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_Operacoes SET nMarcas = 0 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarcaClick / BtnDesmarcaClick - marcam/desmarcam TODOS os Tipos de
    * Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no legado)
    *==========================================================================
    PROCEDURE BtnMarcaClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_TiposOperacao SET nMarcas = 1
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF
        IF USED("cursor_4c_Operacoes")
            UPDATE cursor_4c_Operacoes SET nMarcas = 1
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcaClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_TiposOperacao")
            UPDATE cursor_4c_TiposOperacao SET nMarcas = 0
            GO TOP IN cursor_4c_TiposOperacao
            loc_oPag.grd_4c_Tipos.Refresh()
        ENDIF
        IF USED("cursor_4c_Operacoes")
            UPDATE cursor_4c_Operacoes SET nMarcas = 0
            GO TOP IN cursor_4c_Operacoes
            loc_oPag.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarGdeClick / BtnDesGdeClick - marcam/desmarcam TODO o Grande Grupo
    * e TODO o Grupo de Produto (btnMarGde/btnDesGde no legado)
    *==========================================================================
    PROCEDURE BtnMarGdeClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrandeGrupo SET nMarcas = 1
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 1
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGdeClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrandeGrupo SET nMarcas = 0
            GO TOP IN cursor_4c_GrandeGrupo
            loc_oPag.grd_4c_GrandeGrupo.Refresh()
        ENDIF
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarGrpClick / BtnDesGrpClick - marcam/desmarcam o Grupo de Produto
    * (btnMarGrp/btnDesGrp no legado). Marcar so afeta linhas cujo Grande
    * Grupo pai JA ESTA marcado (igual ao legado).
    *==========================================================================
    PROCEDURE BtnMarGrpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrupoProduto") AND USED("cursor_4c_GrandeGrupo")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 1 ;
                WHERE Mercs IN (SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1)
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGrpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_GrupoProduto")
            UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
            GO TOP IN cursor_4c_GrupoProduto
            loc_oPag.grd_4c_GrupoProduto.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEmpsClick - cmg_4c_Empresas (cmdEmps no legado): Buttons(1) marca
    * Imps = 1 em todas as Empresas, Buttons(2) desmarca (Imps = 0).
    * O legado escreve "Set Imps = (This.Value = 1)" porque la a coluna eh
    * bit/logica; aqui Imps eh NUMERICA (CheckBox.Value eh numerico), por
    * isso o IIF explicito - atribuir o Logico direto estoura type mismatch.
    *==========================================================================
    PROCEDURE CmdEmpsClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Empresas")
            UPDATE cursor_4c_Empresas SET Imps = IIF(loc_oPag.cmg_4c_Empresas.Value = 1, 1, 0)
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CkMarcaEmpClick - chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado): marca/
    * desmarca TODAS as Empresas de uma vez
    *==========================================================================
    PROCEDURE CkMarcaEmpClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_Empresas")
            *-- Imps eh NUMERICA (CheckBox.Value eh numerico): 1/0, nao .T./.F.
            IF loc_oPag.chk_4c_Ck_MarcaEmp.Value = 1
                REPLACE ALL Imps WITH 1 IN cursor_4c_Empresas
            ELSE
                REPLACE ALL Imps WITH 0 IN cursor_4c_Empresas
            ENDIF
            GO TOP IN cursor_4c_Empresas
            loc_oPag.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgFiltrosClick - cmg_4c_Filtros (cmgFiltros no legado): Buttons(1)
    * "Consultar" valida o periodo e dispara a consulta; Buttons(2) "Sair"
    * encerra o form.
    *==========================================================================
    PROCEDURE CmgFiltrosClick()
        DO CASE
            CASE THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros.Value = 1
                THIS.BtnConsultarClick()
            CASE THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros.Value = 2
                THIS.BtnSairClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnConsultarClick - Buttons(1) "Consultar" (btnConsultar no legado).
    * Valida periodo/moeda/Tipo de Operacao marcado/Grande Grupo marcado
    * (mesmas guardas do btnConsultar.Click legado) e dispara a consulta
    * (Processamento() do legado -> THIS.this_oBusinessObject.Processar()).
    *
    * Apos o sucesso, reproduz o fim de Processamento(): optValor1.Value=3
    * ("Sem Filtro"), THIS.Filtros(1,3) (ordem/refresh de grd_4c_Dados1),
    * ActivePage=2 (Pagina de Dados), pgf_4c_Resultados.ActivePage=1
    * (Detalhamento) e a atualizacao do painel lateral (equivalente ao
    * grdDados1.AfterRowColChange() chamado a mao no fim do legado).
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oPag, loc_dIni, loc_dFim, loc_lSucesso

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_dIni = THIS.this_oBusinessObject.this_dDataIni
        loc_dFim = THIS.this_oBusinessObject.this_dDataFim

        IF EMPTY(loc_dIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dFim)
            MsgAviso("A Data Final N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF loc_dIni > loc_dFim
            MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cMoeda)
            MsgAviso("A Moeda Para Convers" + CHR(227) + "o Precisa Ser Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_TiposOperacao")
            SELECT CCodigos FROM cursor_4c_TiposOperacao WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaTipos
            IF RECCOUNT("cursor_4c_VerificaTipos") = 0
                USE IN cursor_4c_VerificaTipos
                MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
                RETURN .F.
            ENDIF
            USE IN cursor_4c_VerificaTipos
        ENDIF

        IF USED("cursor_4c_GrandeGrupo")
            SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaGde
            IF RECCOUNT("cursor_4c_VerificaGde") = 0
                USE IN cursor_4c_VerificaGde
                MsgAviso("Nenhum Grande Grupo Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
                RETURN .F.
            ENDIF
            USE IN cursor_4c_VerificaGde
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dIni, loc_dFim, ;
            THIS.this_oBusinessObject.this_cMoeda, THIS.this_oBusinessObject.this_cGrupoVenda, ;
            THIS.this_oBusinessObject.this_cSubGrupo)

        IF loc_lSucesso
            THIS.this_oBusinessObject.this_nTipoValor = 3
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.optValor1.Value = 3
            THIS.Filtros(1, 3)

            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage = 1

            THIS.AtualizarPainelDetalheRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSairClick - Buttons(2) "Sair" (btnSair no legado, Cancel=.T. ->
    * ESC). Persiste a configuracao de colunas de grd_4c_Dados1
    * (AcertaColunas('GRAVAR')) antes de fechar, igual ao legado.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.AcertaColunas("GRAVAR")
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 (pgDados no legado). PageFrame interno
    * pgResults -> pgf_4c_Resultados (3 paginas: Detalhamento/Totais por
    * Empresa/Totais por Vendedora) + os botoes de navegacao/exportacao
    * (cmgRetornar/btnExportar/btnExcel), que no legado ficam direto em
    * pgDados, FORA do PageFrame interno (por isso aparecem nas 3 abas).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            loc_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- pgResults: Top=2 Left=-1 Width=1304 Height=600 PageCount=3
        loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
        WITH loc_oPag.pgf_4c_Resultados
            .Top       = 2
            .Left      = -1
            .Width     = 1304
            .Height    = 600
            .PageCount = 3
            .Visible   = .T.
        ENDWITH

        THIS.ConfigurarAbaDetalhamento(loc_oPag.pgf_4c_Resultados.Page1)
        THIS.ConfigurarAbaTotalEmpresa(loc_oPag.pgf_4c_Resultados.Page2)
        THIS.ConfigurarAbaTotalVendedora(loc_oPag.pgf_4c_Resultados.Page3)

        *-- cmgRetornar (cmgRetornar no legado): volta para a Pagina 1
        *-- (Filtros)
        loc_oPag.AddObject("cmg_4c_Retornar", "CommandGroup")
        WITH loc_oPag.cmg_4c_Retornar
            .Top         = 62
            .Left        = 1193
            .Width       = 80
            .Height      = 80
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Cancel      = .T.
                .Caption     = "Retornar"
                .ToolTipText = "Retornar aos Filtros"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- btnExportar / btnExcel (fwbtng no legado): exportam o resultado
        *-- da ABA CORRENTE de pgf_4c_Resultados para TXT/XLS
        loc_oPag.AddObject("cmd_4c_Exportar", "CommandButton")
        WITH loc_oPag.cmd_4c_Exportar
            .Top         = 62
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Exporta TXT"
            .ToolTipText = "Gerar TXT Tabulado Para Importa" + CHR(231) + CHR(227) + "o em Excel"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oPag.AddObject("cmd_4c_Excel", "CommandButton")
        WITH loc_oPag.cmd_4c_Excel
            .Top         = 62
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Exporta XLS"
            .ToolTipText = "Gerar Planilha XLS"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarBindEventsResultados()

        *-- Page NAO tem a propriedade Visible (a Page e exibida pelo
        *-- ActivePage do PageFrame). Atribuir estoura "Property VISIBLE
        *-- is not found" dentro do InicializarForm e a tela nao abre.
    ENDPROC

    *==========================================================================
    * ConfigurarAbaDetalhamento - pgRes01 (Detalhamento dos Produtos):
    * grd_4c_Dados1 (35 colunas, ControlSource/Width/Alignment EXATOS do
    * dump - SECAO 2, nao do runtime GradePadrao(), que esta desatualizado
    * em relacao ao SCX - ver GradePadrao() mais abaixo) + o painel lateral
    * (imagem, observacao, preco atual, desconto/acrescimo, busca por
    * codigo, filtro positivas/negativas/sem-filtro) + os botoes de acao
    * (Restaurar Grade, Cadastro do Produto, Movimento, Subniveis, Conta,
    * Visualizar, Imprimir).
    *
    * Cursor_4c_Detalhe (crPgRes01) JA EXISTE neste ponto - criado pelo
    * Init() do BO (CriarCursoresResultado), chamado ANTES de
    * ConfigurarPageFrame em InicializarForm. Por isso o bind
    * (RecordSource/ControlSource) pode ser feito aqui, direto, sem o funil
    * deferido que as grades de filtro da Pagina 1 precisam (regra #41) -
    * BtnConsultarClick so faz ZAP+INSERT no MESMO cursor (nunca fecha/
    * reabre o alias), entao o RecordSource nunca se perde.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaDetalhamento(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(35)
        DIMENSION loc_aCaption(35)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Movimenta" + CHR(231) + CHR(227) + "o"
        loc_aLargura( 2) = 150
        loc_aCaption( 3) = "C" + CHR(243) + "digo"
        loc_aLargura( 3) =  55
        loc_aCaption( 4) = "Data"
        loc_aLargura( 4) =  71
        loc_aCaption( 5) = "Vendedora"
        loc_aLargura( 5) =  80
        loc_aCaption( 6) = "Barra"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Produto"
        loc_aLargura( 7) = 110
        loc_aCaption( 8) = "Descri" + CHR(231) + CHR(227) + "o do Produto"
        loc_aLargura( 8) = 296
        loc_aCaption( 9) = "Cor"
        loc_aLargura( 9) =  35
        loc_aCaption(10) = "Tam"
        loc_aLargura(10) =  35
        loc_aCaption(11) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura(11) = 100
        loc_aCaption(12) = "% Dif."
        loc_aLargura(12) =  70
        loc_aCaption(13) = "Valor do Cadastro"
        loc_aLargura(13) =  95
        loc_aCaption(14) = "Venda Unit" + CHR(225) + "rio"
        loc_aLargura(14) =  95
        loc_aCaption(15) = "Quantidade"
        loc_aLargura(15) = 100
        loc_aCaption(16) = "Total"
        loc_aLargura(16) =  95
        loc_aCaption(17) = "Custo do Cadastro"
        loc_aLargura(17) = 100
        loc_aCaption(18) = "Fornecedor"
        loc_aLargura(18) =  90
        loc_aCaption(19) = "Nome do Fornecedor"
        loc_aLargura(19) = 290
        loc_aCaption(20) = "Refer" + CHR(234) + "ncia"
        loc_aLargura(20) = 150
        loc_aCaption(21) = "Gde"
        loc_aLargura(21) =  30
        loc_aCaption(22) = "Grp"
        loc_aLargura(22) =  30
        loc_aCaption(23) = "Subgrupo"
        loc_aLargura(23) = 220
        loc_aCaption(24) = "Ope"
        loc_aLargura(24) =  30
        loc_aCaption(25) = "Cliente"
        loc_aLargura(25) =  80
        loc_aCaption(26) = "Nome do Cliente"
        loc_aLargura(26) = 290
        loc_aCaption(27) = "Parcelas"
        loc_aLargura(27) =  50
        loc_aCaption(28) = "Condi" + CHR(231) + CHR(245) + "es de Pagamento"
        loc_aLargura(28) = 200
        loc_aCaption(29) = "Margem"
        loc_aLargura(29) = 100
        loc_aCaption(30) = "Total Movimenta" + CHR(231) + CHR(227) + "o"
        loc_aLargura(30) = 110
        loc_aCaption(31) = "Local"
        loc_aLargura(31) =  80
        loc_aCaption(32) = "Equivalente"
        loc_aLargura(32) = 110
        loc_aCaption(33) = "Categoria"
        loc_aLargura(33) =  60
        loc_aCaption(34) = "Nome Vendedora"
        loc_aLargura(34) = 204
        loc_aCaption(35) = "Desc. Categoria"
        loc_aLargura(35) = 140

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados1", "Grid")
        WITH par_oPag.grd_4c_Dados1
            .Top               = 320
            .Left              = 4
            .Width             = 1292
            .Height            = 251
            .ColumnCount       = 35
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            *-- RecordSource ANTES do ControlSource (regra #41) - o cursor
            *-- ja existe (CriarCursoresResultado roda no Init do BO).
            .RecordSource      = "cursor_4c_Detalhe"
            .Column1.ControlSource  = "cursor_4c_Detalhe.Empresa"
            .Column2.ControlSource  = "cursor_4c_Detalhe.Movimentacao"
            .Column3.ControlSource  = "cursor_4c_Detalhe.Numero"
            .Column4.ControlSource  = "IIF(EMPTY(cursor_4c_Detalhe.Data_Venda), SPACE(10), DTOC(cursor_4c_Detalhe.Data_Venda))"
            .Column5.ControlSource  = "cursor_4c_Detalhe.Codigo_Vendedora"
            .Column6.ControlSource  = "cursor_4c_Detalhe.Barras"
            .Column7.ControlSource  = "cursor_4c_Detalhe.Codigo_Item"
            .Column8.ControlSource  = "cursor_4c_Detalhe.Desc_Item"
            .Column9.ControlSource  = "cursor_4c_Detalhe.Cor"
            .Column10.ControlSource = "cursor_4c_Detalhe.Tamanho"
            .Column11.ControlSource = "cursor_4c_Detalhe.Valor_Diferenca"
            .Column12.ControlSource = "ALLTRIM(cursor_4c_Detalhe.Pct_Dif_Chr)"
            .Column13.ControlSource = "cursor_4c_Detalhe.Venda_Cadastro"
            .Column14.ControlSource = "cursor_4c_Detalhe.Val_Unitario"
            .Column15.ControlSource = "cursor_4c_Detalhe.Quantidade"
            .Column16.ControlSource = "cursor_4c_Detalhe.Total"
            .Column17.ControlSource = "cursor_4c_Detalhe.Custo_Cadastro"
            .Column18.ControlSource = "cursor_4c_Detalhe.Cod_Fornecedor"
            .Column19.ControlSource = "cursor_4c_Detalhe.Nome_Fornecedor"
            .Column20.ControlSource = "cursor_4c_Detalhe.Ref_Fornecedor"
            .Column21.ControlSource = "cursor_4c_Detalhe.Gde_Grupo"
            .Column22.ControlSource = "cursor_4c_Detalhe.Grupo"
            .Column23.ControlSource = "cursor_4c_Detalhe.SubGrupo"
            .Column24.ControlSource = "cursor_4c_Detalhe.Operacao"
            .Column25.ControlSource = "cursor_4c_Detalhe.Cod_Cliente"
            .Column26.ControlSource = "cursor_4c_Detalhe.Nome_Cliente"
            .Column27.ControlSource = "cursor_4c_Detalhe.Parcelas"
            .Column28.ControlSource = "cursor_4c_Detalhe.Cond_Pagto"
            .Column29.ControlSource = "cursor_4c_Detalhe.Markup"
            .Column30.ControlSource = "cursor_4c_Detalhe.Total_Geral"
            .Column31.ControlSource = "cursor_4c_Detalhe.Local_Itn"
            .Column32.ControlSource = "cursor_4c_Detalhe.Equivalente"
            .Column33.ControlSource = "cursor_4c_Detalhe.Categoria"
            .Column34.ControlSource = "cursor_4c_Detalhe.Nome_Vendedora"
            .Column35.ControlSource = "cursor_4c_Detalhe.Desc_Categoria"

            .Column4.Alignment  = 2
            .Column12.Alignment = 1
            .Column24.Alignment = 2
            .Column27.Alignment = 1

            *-- Codigo_Item (7) e Equivalente (32): estilo "link" do legado
            *-- (FontBold+Underline+azul). O clique e de verdade: o DblClick
            *-- do Text1 das duas colunas abre a Pesquisa Global de Produtos
            *-- filtrada pelo codigo da celula (ver
            *-- ConfigurarBindEventsResultados / AbrirPesquisaGlobalProduto),
            *-- igual ao legado.
            .Column7.FontBold       = .T.
            .Column7.FontUnderline  = .T.
            .Column7.ForeColor      = RGB(0, 0, 255)
            .Column32.FontBold      = .T.
            .Column32.FontUnderline = .T.
            .Column32.ForeColor     = RGB(0, 0, 255)

            FOR loc_nCol = 1 TO 35
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados1, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), ;
                    INLIST(loc_nCol, 11, 13, 14, 15, 16, 17, 29, 30))
            ENDFOR

            *-- Linhas de TOTAL (Ordem <> 'A') em amarelo+negrito; Valor da
            *-- Diferenca/% Dif. (11/12) ficam SEMPRE amarelos, mesmo nas
            *-- linhas normais
            .SetAll("DynamicBackColor", "IIF(cursor_4c_Detalhe.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_Detalhe.Ordem <> 'A'", "Column")
            .Column11.DynamicBackColor = "RGB(255,255,240)"
            .Column12.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH

        *-- Restaura largura/visibilidade salvas em txt_4c_CfgGrade (se
        *-- houver) - equivalente a ThisForm.AcertaColunas([LER]) no fim de
        *-- montagrades() legado
        THIS.AcertaColunas("LER")

        *-- getObsItn (observacao do item - EditBox memo, so exibicao)
        par_oPag.AddObject("obj_4c_ObsItem", "EditBox")
        WITH par_oPag.obj_4c_ObsItem
            .Top       = 20
            .Left      = 5
            .Width     = 312
            .Height    = 172
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say3 "Observacao do Item"
        par_oPag.AddObject("lbl_4c_ObsItem", "Label")
        WITH par_oPag.lbl_4c_ObsItem
            .Top       = 4
            .Left      = 6
            .Width     = 100
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do " + CHR(205) + "tem"
            .Visible   = .T.
        ENDWITH

        *-- Say1 "Preco Atual do Item" + getVdaCadastro (so exibicao)
        par_oPag.AddObject("lbl_4c_PrecoAtual", "Label")
        WITH par_oPag.lbl_4c_PrecoAtual
            .Top       = 200
            .Left      = 5
            .Width     = 97
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o Atual do Item"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_VdaCadastro", "TextBox")
        WITH par_oPag.txt_4c_VdaCadastro
            .Top       = 216
            .Left      = 5
            .Width     = 128
            .Height    = 23
            .ReadOnly  = .T.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say4 "Desconto/Acrescimo" + getDesc_Acres (so exibicao)
        par_oPag.AddObject("lbl_4c_DescAcres", "Label")
        WITH par_oPag.lbl_4c_DescAcres
            .Top       = 245
            .Left      = 5
            .Width     = 99
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desconto/Acr" + CHR(233) + "scimo"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DescAcres", "TextBox")
        WITH par_oPag.txt_4c_DescAcres
            .Top       = 261
            .Left      = 5
            .Width     = 128
            .Height    = 23
            .ReadOnly  = .T.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say2 "Buscar Codigo" + getBusca (busca Numero da venda na grade)
        par_oPag.AddObject("lbl_4c_Busca", "Label")
        WITH par_oPag.lbl_4c_Busca
            .Top       = 245
            .Left      = 164
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Buscar C" + CHR(243) + "digo"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Busca", "TextBox")
        WITH par_oPag.txt_4c_Busca
            .Top       = 261
            .Left      = 164
            .Width     = 82
            .Height    = 23
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- lblDespDRE "Diferencas :" + optValor1 (Positivas/Negativas/Sem Filtro)
        par_oPag.AddObject("lbl_4c_Diferencas", "Label")
        WITH par_oPag.lbl_4c_Diferencas
            .Top       = 297
            .Left      = 17
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Diferen" + CHR(231) + "as :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("obj_4c_OptValor1", "OptionGroup")
        WITH par_oPag.obj_4c_OptValor1
            .Top         = 292
            .Left        = 76
            .Width        = 226
            .Height      = 25
            .ButtonCount = 3
            .Value       = 3
            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Positivas"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top       = 5
                .Left      = 77
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Negativas"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top       = 5
                .Left      = 156
                .Width     = 65
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sem Filtro"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- ImgFigJpg - imagem do produto da linha corrente (DblClick = zoom)
        par_oPag.AddObject("img_4c_Figura", "Image")
        WITH par_oPag.img_4c_Figura
            .Top         = 2
            .Left        = 327
            .Width       = 621
            .Height      = 318
            .Stretch     = 1
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Visible     = .F.
        ENDWITH

        *-- btnRestaurar - restaura largura/visibilidade padrao da grade
        par_oPag.AddObject("cmd_4c_Restaurar", "CommandButton")
        WITH par_oPag.cmd_4c_Restaurar
            .Top         = 113
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "Restaurar Grade"
            .ToolTipText = "Restaura as Colunas da Grade Para o Padr" + CHR(227) + "o Original"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- btnProduto - abre o cadastro do produto
        par_oPag.AddObject("cmd_4c_Produto", "CommandButton")
        WITH par_oPag.cmd_4c_Produto
            .Top         = 113
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Cadastro"
            .ToolTipText = "Cadastro do Produto"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- cmdOperacao/btnOperacao - abre a tela de movimentacao da venda
        par_oPag.AddObject("cmg_4c_Operacao", "CommandGroup")
        WITH par_oPag.cmg_4c_Operacao
            .Top         = 113
            .Left        = 1193
            .Width       = 80
            .Height      = 100
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "Movimento"
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Picture     = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- SubNiveis - abre a tela de subniveis da venda
        par_oPag.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH par_oPag.cmd_4c_SubNiveis
            .Top         = 190
            .Left        = 1192
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "\<Subn" + CHR(237) + "veis"
            .ToolTipText = "Subn" + CHR(237) + "veis"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- CmdConta - abre o cadastro da conta/cliente
        par_oPag.AddObject("cmd_4c_Conta", "CommandButton")
        WITH par_oPag.cmd_4c_Conta
            .Top         = 190
            .Left        = 1116
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Conta"
            .ToolTipText = "Cadastro do Produto"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
            .Visible     = .T.
        ENDWITH

        *-- btnVisualizar / BtnImprimir - preview/impressao do relatorio de
        *-- embalagem (SigOpPck). O form legado monta a consulta a partir do
        *-- cursor_4c_Detalhe JA filtrado em tela; o form novo FormSigOpPck
        *-- (ja migrado, OPERACIONAL) tem filtros proprios independentes -
        *-- nao ha API publica para injetar o recorte atual nele. Por isso
        *-- estes botoes abrem o FormSigOpPck para o usuario refazer o
        *-- filtro la, em vez de reproduzir o INDEX ON/REPORT FORM direto
        *-- sobre cursor_4c_Detalhe (seria preciso duplicar o FRX e a
        *-- logica de filtro, que ja pertencem aquele form).
        par_oPag.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH par_oPag.cmd_4c_Visualizar
            .Top         = 190
            .Left        = 1040
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Visualizar"
            .ToolTipText = "Visualizar Etiquetas de Embalagem"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_video_60.jpg"
            .Visible     = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH par_oPag.cmd_4c_Imprimir
            .Top         = 190
            .Left        = 964
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Caption     = "Imprimir"
            .ToolTipText = "Imprimir Etiquetas de Embalagem"
            .PicturePosition = 13
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarColunaResultado - Aplica no indice loc_nCol da grade de
    * resultado a largura/caption padrao + a mascara numerica (999,999,999.99)
    * nas colunas que o legado marca como numericas. Compartilhado por
    * grd_4c_Dados1/2/3 (par_oGrid identifica a grade).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarColunaResultado(par_oGrid, par_nIndice, par_cCaption, par_nLargura, par_lNumerica)
        LOCAL loc_cCol, loc_oColuna
        loc_cCol    = TRANSFORM(par_nIndice)
        loc_oColuna = EVALUATE("par_oGrid.Column" + loc_cCol)

        loc_oColuna.ReadOnly          = .T.
        loc_oColuna.Width             = par_nLargura
        loc_oColuna.Header1.Caption   = par_cCaption
        loc_oColuna.Header1.FontBold  = .T.
        loc_oColuna.Header1.Alignment = 2
        loc_oColuna.Header1.ForeColor = RGB(90, 90, 90)

        IF PCOUNT() >= 5 AND par_lNumerica
            loc_oColuna.InputMask = "999,999,999.99"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarAbaTotalEmpresa - pgRes02 (Totais por Empresa): grd_4c_Dados2
    * (10 colunas, cursor_4c_TotalEmpresa). O legado NAO define Width por
    * coluna aqui (soh ControlSource/ReadOnly/InputMask em montagrades) -
    * os valores abaixo vem do design-time do SCX (SECAO 2).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaTotalEmpresa(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(10)
        DIMENSION loc_aCaption(10)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Descritivo"
        loc_aLargura( 2) = 150
        loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura( 3) = 100
        loc_aCaption( 4) = "% Dif."
        loc_aLargura( 4) =  45
        loc_aCaption( 5) = "Valor do Cadastro"
        loc_aLargura( 5) = 100
        loc_aCaption( 6) = "Quantidade"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Total de Vendas"
        loc_aLargura( 7) = 100
        loc_aCaption( 8) = "Custo do Cadastro"
        loc_aLargura( 8) = 100
        loc_aCaption( 9) = "Ticket M" + CHR(233) + "dio"
        loc_aLargura( 9) = 100
        loc_aCaption(10) = "Margem"
        loc_aLargura(10) = 100

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados2", "Grid")
        WITH par_oPag.grd_4c_Dados2
            .Top               = 137
            .Left              = 4
            .Width             = 1292
            .Height            = 431
            .ColumnCount       = 10
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "cursor_4c_TotalEmpresa"
            .Column1.ControlSource  = "cursor_4c_TotalEmpresa.Empresa"
            .Column2.ControlSource  = "cursor_4c_TotalEmpresa.Movimentacao"
            .Column3.ControlSource  = "cursor_4c_TotalEmpresa.Valor_Diferenca"
            .Column4.ControlSource  = "cursor_4c_TotalEmpresa.Perc_Diferenca"
            .Column5.ControlSource  = "cursor_4c_TotalEmpresa.Venda_Cadastro"
            .Column6.ControlSource  = "cursor_4c_TotalEmpresa.Quantidade"
            .Column7.ControlSource  = "cursor_4c_TotalEmpresa.Total"
            .Column8.ControlSource  = "cursor_4c_TotalEmpresa.Custo_Cadastro"
            .Column9.ControlSource  = "cursor_4c_TotalEmpresa.Tkt_Medio"
            .Column10.ControlSource = "cursor_4c_TotalEmpresa.Markup"

            FOR loc_nCol = 1 TO 10
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados2, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
            ENDFOR

            .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalEmpresa.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_TotalEmpresa.Ordem <> 'A'", "Column")
            .Column3.DynamicBackColor = "RGB(255,255,240)"
            .Column4.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaTotalVendedora - pgRes03 (Totais por Vendedora):
    * grd_4c_Dados3 (10 colunas, cursor_4c_TotalVendedora)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaTotalVendedora(par_oPag)
        LOCAL loc_nCol
        DIMENSION loc_aLargura(10)
        DIMENSION loc_aCaption(10)

        loc_aCaption( 1) = "Emp"
        loc_aLargura( 1) =  31
        loc_aCaption( 2) = "Vendedora"
        loc_aLargura( 2) = 100
        loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
        loc_aLargura( 3) = 100
        loc_aCaption( 4) = "% Dif."
        loc_aLargura( 4) =  45
        loc_aCaption( 5) = "Valor do Cadastro"
        loc_aLargura( 5) = 100
        loc_aCaption( 6) = "Quantidade"
        loc_aLargura( 6) = 100
        loc_aCaption( 7) = "Total de Vendas"
        loc_aLargura( 7) = 100
        loc_aCaption( 8) = "Custo do Cadastro"
        loc_aLargura( 8) = 100
        loc_aCaption( 9) = "Ticket M" + CHR(233) + "dio"
        loc_aLargura( 9) = 100
        loc_aCaption(10) = "Margem"
        loc_aLargura(10) = 100

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        par_oPag.AddObject("grd_4c_Dados3", "Grid")
        WITH par_oPag.grd_4c_Dados3
            .Top               = 137
            .Left              = 4
            .Width             = 1292
            .Height            = 431
            .ColumnCount       = 10
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "cursor_4c_TotalVendedora"
            .Column1.ControlSource  = "cursor_4c_TotalVendedora.Empresa"
            .Column2.ControlSource  = "cursor_4c_TotalVendedora.Codigo_Vendedora"
            .Column3.ControlSource  = "cursor_4c_TotalVendedora.Valor_Diferenca"
            .Column4.ControlSource  = "cursor_4c_TotalVendedora.Perc_Diferenca"
            .Column5.ControlSource  = "cursor_4c_TotalVendedora.Venda_Cadastro"
            .Column6.ControlSource  = "cursor_4c_TotalVendedora.Quantidade"
            .Column7.ControlSource  = "cursor_4c_TotalVendedora.Total"
            .Column8.ControlSource  = "cursor_4c_TotalVendedora.Custo_Cadastro"
            .Column9.ControlSource  = "cursor_4c_TotalVendedora.Tkt_Medio"
            .Column10.ControlSource = "cursor_4c_TotalVendedora.Markup"

            FOR loc_nCol = 1 TO 10
                THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados3, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
            ENDFOR

            .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalVendedora.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
            .SetAll("DynamicFontBold",  "cursor_4c_TotalVendedora.Ordem <> 'A'", "Column")
            .Column3.DynamicBackColor = "RGB(255,255,240)"
            .Column4.DynamicBackColor = "RGB(255,255,240)"

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsResultados - BINDEVENTs da Pagina de Dados
    * (grades de resultado + painel lateral + botoes de acao/navegacao/
    * exportacao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsResultados()
        LOCAL loc_oPagDados, loc_oPagRes01, loc_oPagRes02, loc_oPagRes03, loc_nCol
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        loc_oPagRes01 = loc_oPagDados.pgf_4c_Resultados.Page1
        loc_oPagRes02 = loc_oPagDados.pgf_4c_Resultados.Page2
        loc_oPagRes03 = loc_oPagDados.pgf_4c_Resultados.Page3

        BINDEVENT(loc_oPagRes01.grd_4c_Dados1, "AfterRowColChange", THIS, "Grd1AfterRowColChange")
        BINDEVENT(loc_oPagRes01.img_4c_Figura, "DblClick", THIS, "ImgFiguraDblClick")

        *-- grdDados2.AfterRowColChange / grdDados3.AfterRowColChange no
        *-- legado: os dois repintam o painel lateral da pgRes01 (imagem +
        *-- Observacao do Item) a partir de crPgRes01 - exatamente o que
        *-- AtualizarPainelDetalheRegistro faz sobre cursor_4c_Detalhe.
        BINDEVENT(loc_oPagRes02.grd_4c_Dados2, "AfterRowColChange", THIS, "Grd2AfterRowColChange")
        BINDEVENT(loc_oPagRes03.grd_4c_Dados3, "AfterRowColChange", THIS, "Grd3AfterRowColChange")

        *-- grdDados1.Column<N>.Resize no legado (Columns 1 a 30 e 32 - as
        *-- colunas 31, 33, 34 e 35 NAO tem o evento no SCX, e esta lista
        *-- reproduz isso): arrastar a borda ate largura zero pergunta se o
        *-- usuario quer OCULTAR a coluna.
        FOR loc_nCol = 1 TO 32
            IF loc_nCol <= 30 OR loc_nCol = 32
                BINDEVENT(EVALUATE("loc_oPagRes01.grd_4c_Dados1.Column" + TRANSFORM(loc_nCol)), ;
                    "Resize", THIS, "Grd1ColunaResize")
            ENDIF
        ENDFOR

        *-- grdDados1.Column7.Text1.DblClick / Column32.Text1.DblClick no
        *-- legado: abre a Pesquisa Global de Produtos filtrada pelo codigo
        *-- da celula (Produto na 7, Equivalente na 32).
        BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column7.Text1,  "DblClick", THIS, "Grd1Coluna7DblClick")
        BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column32.Text1, "DblClick", THIS, "Grd1Coluna32DblClick")

        BINDEVENT(loc_oPagRes01.txt_4c_Busca, "GotFocus",  THIS, "TxtBuscaGotFocus")
        BINDEVENT(loc_oPagRes01.txt_4c_Busca, "LostFocus", THIS, "TxtBuscaLostFocus")

        BINDEVENT(loc_oPagRes01.obj_4c_OptValor1, "InteractiveChange", THIS, "OptValor1InteractiveChange")

        BINDEVENT(loc_oPagRes01.cmd_4c_Restaurar,  "Click", THIS, "BtnRestaurarClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Produto,    "Click", THIS, "BtnProdutoClick")
        BINDEVENT(loc_oPagRes01.cmg_4c_Operacao,   "Click", THIS, "CmgOperacaoClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_SubNiveis,  "Click", THIS, "BtnSubNiveisClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Conta,      "Click", THIS, "BtnContaClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagRes01.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")

        BINDEVENT(loc_oPagDados.cmg_4c_Retornar, "Click", THIS, "BtnRetornarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_Exportar, "Click", THIS, "BtnExportarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_Excel,    "Click", THIS, "BtnExcelClick")
    ENDPROC

    *==========================================================================
    * Grd1AfterRowColChange / AtualizarPainelDetalheRegistro - troca de
    * linha/coluna em grd_4c_Dados1 (grdDados1.AfterRowColChange no legado):
    * atualiza a imagem do produto + o painel lateral (Observacao,
    * Desconto/Acrescimo, Preco Atual) a partir da linha corrente. Toda a
    * leitura do cursor passa por BO.CarregarDoCursor (regra: CarregarDoCursor
    * eh a FONTE UNICA) - os botoes de acao abaixo (Movimento/Subniveis/
    * Conta/Produto) leem as properties this_cReg*/this_nReg* resultantes,
    * nunca o cursor direto.
    *==========================================================================
    PROCEDURE Grd1AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    *==========================================================================
    * Grd2AfterRowColChange / Grd3AfterRowColChange - grdDados2 e grdDados3
    * no legado tem o MESMO corpo de grdDados1.AfterRowColChange: as duas
    * grades de TOTAIS repintam o painel lateral da aba de Detalhamento
    * (imagem do produto + Observacao do Item) lendo crPgRes01, nao o
    * proprio cursor de totais. Transcricao fiel: delegam ao mesmo metodo.
    * PUBLIC por serem alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE Grd2AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    PROCEDURE Grd3AfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelDetalheRegistro()
    ENDPROC

    *==========================================================================
    * Grd1ColunaResize - grdDados1.Column<N>.Resize no legado:
    *
    *   lcHea = Alltrim(This.Header1.Caption)
    *   If (This.Width = 0) And (MessageBox([Deseja Ocultar a Coluna "] + ;
    *       lcHea + [" da Grade?], 4+32+256, [Ocultar Colunas]) = 6)
    *       This.Visible = .f.
    *   EndIf
    *
    * O legado repete esse corpo em 31 Column.Resize identicos; aqui um
    * UNICO delegate atende todos os BINDEVENT. Como o corpo so age quando
    * This.Width = 0, identificar a coluna pela LARGURA ZERO e equivalente
    * a identifica-la pelo "This" do legado - e dispensa AEVENTS (cuja
    * consulta por objeto de origem nao resolve o emissor do evento
    * corrente). O laco cobre as MESMAS colunas que o SCX vincula (1 a 30
    * e 32); 31, 33, 34 e 35 ficam de fora, como no legado.
    *
    * MsgConfirma devolve LOGICO (regra #7) - nunca comparar com 6.
    *==========================================================================
    PROCEDURE Grd1ColunaResize()
        LOCAL loc_oGrid, loc_nCol, loc_oColuna, loc_cHeader

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1

        FOR loc_nCol = 1 TO 32
            IF loc_nCol <= 30 OR loc_nCol = 32
                loc_oColuna = EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol))

                IF loc_oColuna.Visible AND loc_oColuna.Width = 0
                    loc_cHeader = ALLTRIM(loc_oColuna.Header1.Caption)
                    IF MsgConfirma("Deseja Ocultar a Coluna " + CHR(34) + loc_cHeader + CHR(34) + ;
                            " da Grade?", "Ocultar Colunas")
                        loc_oColuna.Visible = .F.
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Grd1Coluna7DblClick / Grd1Coluna32DblClick - DblClick de
    * grdDados1.Column7.Text1 (Produto) e .Column32.Text1 (Equivalente) no
    * legado. Os dois tem o MESMO corpo: abrem a Pesquisa Global de
    * Produtos ja filtrada pelo codigo da celula.
    *
    * O codigo vem das properties this_cReg* do BO (alimentadas por
    * CarregarDoCursor no AfterRowColChange da propria grade), e nao de
    * Text1.Value: dentro da Column o Text1 so carrega o valor da celula
    * ATIVA, e o DblClick pode chegar antes do foco assentar na celula.
    * PUBLIC por serem alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE Grd1Coluna7DblClick()
        THIS.AbrirPesquisaGlobalProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRegCodigoItem, "")))
    ENDPROC

    PROCEDURE Grd1Coluna32DblClick()
        THIS.AbrirPesquisaGlobalProduto(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRegEquivalente, "")))
    ENDPROC

    *==========================================================================
    * AbrirPesquisaGlobalProduto - corpo comum dos dois DblClick acima.
    * Legado (dump, Column7.Text1.DblClick):
    *
    *   Do Form SigOpCgp.Scx Name ThisForm.poObjExt1 Linked With [SigOpCgp] NoShow
    *   .fld_principal.Pag_Consulta.Commandgroup1.Command1.Click()          (Limpar Filtros)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_inicial.Value = Padr(This.Value, 14)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_final.Value   = Padr(This.Value, 14)
    *   .fld_principal.Pag_Consulta.grp_operacao.cmd_consulta.Click()       (Consultar)
    *
    * Formsigopcgp (ja migrado) expoe o mesmo fluxo por metodos PUBLIC -
    * GrpLimparFiltrosClick()/BtnConsultarClick() -, usados aqui no lugar
    * de simular clique em CommandGroup/Buttons; mesmo padrao canonico de
    * Formsigprite.GrdItensColumn2DblClick.
    *
    * A guarda goSistema.ConsultaAberta do legado (instancia unica da
    * pesquisa, guardada em poObjExt1 entre chamadas) nao tem contrapartida
    * no sistema novo: Formsigopcgp e MODAL (WindowType = 1), entao o
    * proprio Show() ja impede abrir uma segunda - a mesma leitura ja
    * registrada em FormSigOpPck.
    *
    * PADR(..., 14) e o tamanho do legado (SigCdPro.cpros char(14)).
    *==========================================================================
    PROTECTED PROCEDURE AbrirPesquisaGlobalProduto(par_cCodigoProduto)
        LOCAL loc_oForm, loc_oPag, loc_oException
        loc_oForm = .NULL.

        IF EMPTY(par_cCodigoProduto)
            RETURN
        ENDIF

        TRY
            GarantirClasse("Formsigopcgp")
            loc_oForm = CREATEOBJECT("Formsigopcgp")
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro ao abrir Pesquisa Global de Produtos")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.GrpLimparFiltrosClick()

            loc_oPag = loc_oForm.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
            loc_oPag.txt_4c_ProdutoI.Value = PADR(par_cCodigoProduto, 14)
            loc_oPag.txt_4c_ProdutoF.Value = PADR(par_cCodigoProduto, 14)

            loc_oForm.BtnConsultarClick()
            loc_oForm.Show()
        ENDIF
    ENDPROC

    PROCEDURE AtualizarPainelDetalheRegistro()
        LOCAL loc_oPagRes01, loc_cArquivoImagem

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Detalhe")

        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1

        loc_cArquivoImagem = THIS.this_oBusinessObject.ExtrairImagemRegistro()
        IF !EMPTY(loc_cArquivoImagem)
            loc_oPagRes01.img_4c_Figura.Picture = loc_cArquivoImagem
            loc_oPagRes01.img_4c_Figura.Visible = .T.
        ELSE
            loc_oPagRes01.img_4c_Figura.Picture = ""
            loc_oPagRes01.img_4c_Figura.Visible = .F.
        ENDIF

        loc_oPagRes01.obj_4c_ObsItem.Value     = THIS.this_oBusinessObject.this_cRegObsItem
        loc_oPagRes01.txt_4c_DescAcres.Value    = THIS.this_oBusinessObject.this_nRegDescAcres
        loc_oPagRes01.txt_4c_VdaCadastro.Value  = THIS.this_oBusinessObject.this_nRegVendaCadastroR
    ENDPROC

    *==========================================================================
    * ImgFiguraDblClick - ImgFigJpg.DblClick no legado abre o form
    * SigOpZom (zoom da imagem), que AINDA NAO EXISTE no acervo migrado -
    * dependencia fora do escopo desta task (mesmo padrao ja registrado em
    * FormSigMvExp.prg para FormSigMvCab: nao-port AUDITAVEL, nao
    * silencioso). Em vez de um zoom mudo, abrimos o JPG temporario no
    * visualizador padrao do Windows (RUN nativo, sem DECLARE DLL) - a
    * mesma imagem, em tamanho de tela inteira.
    *==========================================================================
    PROCEDURE ImgFiguraDblClick()
        LOCAL loc_cArquivo, loc_cComando

        loc_cArquivo = THIS.this_oBusinessObject.ExtrairImagemRegistro()

        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            loc_cComando = 'cmd /c start "" "' + loc_cArquivo + '"'
            RUN /N7 (loc_cComando)
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtBuscaGotFocus / TxtBuscaLostFocus - getBusca no legado (busca o
    * Numero da venda digitado dentro de grd_4c_Dados1). O legado usa
    * GotFocus para guardar o valor anterior (This.Tag) e Valid para
    * comparar e fazer o LOCATE - como Valid de TextBox nao eh confiavel no
    * projeto, as duas acoes ficam no LostFocus (ao sair do campo).
    *==========================================================================
    PROCEDURE TxtBuscaGotFocus()
        LOCAL loc_oPagRes01
        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
        loc_oPagRes01.txt_4c_Busca.Tag = PADR(ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, "")), 10)
    ENDPROC

    PROCEDURE TxtBuscaLostFocus()
        LOCAL loc_oPagRes01, loc_cValor

        loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
        loc_cValor    = ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, ""))

        IF !EMPTY(loc_cValor)
            IF PADR(loc_oPagRes01.txt_4c_Busca.Tag, 10) != PADR(loc_cValor, 10) AND USED("cursor_4c_Detalhe")
                SELECT cursor_4c_Detalhe
                GO TOP
                LOCATE FOR Numero = VAL(loc_cValor)
            ENDIF
            loc_oPagRes01.grd_4c_Dados1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * OptValor1InteractiveChange - optValor1 (Positivas/Negativas/Sem
    * Filtro) no legado chama Filtros(1, This.Value) a cada troca.
    *==========================================================================
    PROCEDURE OptValor1InteractiveChange()
        LOCAL loc_nValor
        loc_nValor = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.obj_4c_OptValor1.Value
        THIS.this_oBusinessObject.this_nTipoValor = loc_nValor
        THIS.Filtros(1, loc_nValor)
    ENDPROC

    *==========================================================================
    * Filtros - filtros(pPag,pOrd) no legado: troca a ordenacao de
    * cursor_4c_Detalhe para a TAG Ordem<N> correspondente (Ordem1 =
    * Positivas, Ordem2 = Negativas, Ordem3 = Sem Filtro - criadas em
    * BO.CriarCursoresResultado) e repinta grd_4c_Dados1.
    *==========================================================================
    PROCEDURE Filtros(par_nPagina, par_nOrdem)
        LOCAL loc_oPagRes01

        IF par_nPagina = 1
            IF USED("cursor_4c_Detalhe")
                SELECT cursor_4c_Detalhe
                SET ORDER TO ("Ordem" + TRANSFORM(par_nOrdem))
                GO TOP
            ENDIF
            loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
            loc_oPagRes01.grd_4c_Dados1.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRestaurarClick - btnRestaurar.Click no legado: confirma, restaura
    * a largura/visibilidade padrao (GradePadrao) e persiste
    * (AcertaColunas('GRAVAR')).
    *==========================================================================
    PROCEDURE BtnRestaurarClick()
        IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")
            THIS.GradePadrao()
            THIS.AcertaColunas("GRAVAR")
        ENDIF
    ENDPROC

    *==========================================================================
    * GradePadrao - gradepadrao() no legado: largura/visibilidade padrao de
    * grd_4c_Dados1. O array hardcoded do legado (laGrd) so cobre as
    * colunas 1 a 30 - as colunas 31 a 35 (Local/Equivalente/Categoria/
    * Nome Vendedora/Desc. Categoria) foram acrescentadas ao SCX DEPOIS
    * deste metodo ter sido escrito e o array NUNCA foi atualizado (regra
    * #14 - SCX mais novo que o codigo que o acompanha). Para essas 5,
    * mantemos a largura atual (a do design-time) em vez de reproduzir a
    * leitura de um elemento do array nunca inicializado pelo legado.
    *==========================================================================
    PROCEDURE GradePadrao()
        LOCAL loc_oGrid, loc_nCnt, loc_cCol
        DIMENSION loc_aLargura(30)
        loc_aLargura( 1) =  31
        loc_aLargura( 2) = 150
        loc_aLargura( 3) =  55
        loc_aLargura( 4) =  71
        loc_aLargura( 5) =  80
        loc_aLargura( 6) =  80
        loc_aLargura( 7) = 110
        loc_aLargura( 8) = 296
        loc_aLargura( 9) =  35
        loc_aLargura(10) =  35
        loc_aLargura(11) = 100
        loc_aLargura(12) =  70
        loc_aLargura(13) =  95
        loc_aLargura(14) =  95
        loc_aLargura(15) = 100
        loc_aLargura(16) =  95
        loc_aLargura(17) = 100
        loc_aLargura(18) =  90
        loc_aLargura(19) = 290
        loc_aLargura(20) = 150
        loc_aLargura(21) =  30
        loc_aLargura(22) =  30
        loc_aLargura(23) = 220
        loc_aLargura(24) =  30
        loc_aLargura(25) =  80
        loc_aLargura(26) = 290
        loc_aLargura(27) =  50
        loc_aLargura(28) = 200
        loc_aLargura(29) = 100
        loc_aLargura(30) = 110

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1

        FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
            loc_cCol = TRANSFORM(loc_nCnt)
            IF loc_nCnt <= 30
                STORE loc_aLargura(loc_nCnt) TO ("loc_oGrid.Column" + loc_cCol + ".Width")
            ENDIF
            STORE .T. TO ("loc_oGrid.Column" + loc_cCol + ".Visible")
        ENDFOR

        loc_oGrid.Refresh()
    ENDPROC

    *==========================================================================
    * AcertaColunas - acertacolunas(pTip) no legado: persiste (GRAVAR) ou
    * restaura (LER) a largura/visibilidade de cada coluna de
    * grd_4c_Dados1 num bloco de 5 caracteres por coluna (3 = largura, 1 =
    * visivel, 1 = reservado), guardado em txt_4c_CfgGrade.Value - string
    * em memoria, nunca persistida em banco (igual ao legado: getCfgGrade
    * eh so um TextBox do form).
    *==========================================================================
    PROCEDURE AcertaColunas(par_cTipo)
        LOCAL loc_oGrid, loc_oTxtCfg, loc_cStr, loc_nCnt, loc_cCol, loc_cBlo, loc_nWid, loc_lVis, loc_nPos

        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1
        loc_oTxtCfg = THIS.pgf_4c_Paginas.Page1.txt_4c_CfgGrade

        IF UPPER(ALLTRIM(NVL(par_cTipo, ""))) == "LER"
            loc_cStr = loc_oTxtCfg.Value

            IF EMPTY(loc_cStr)
                RETURN
            ENDIF

            loc_nPos = 1
            FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
                loc_cBlo = SUBSTR(loc_cStr, loc_nPos, 5)
                loc_nWid = INT(VAL(SUBSTR(loc_cBlo, 1, 3)))
                loc_lVis = !(SUBSTR(loc_cBlo, 4, 1) == "0")
                loc_cCol = TRANSFORM(loc_nCnt)

                IF loc_nWid > 0
                    STORE loc_nWid TO ("loc_oGrid.Column" + loc_cCol + ".Width")
                ENDIF
                STORE loc_lVis TO ("loc_oGrid.Column" + loc_cCol + ".Visible")

                loc_nPos = loc_nPos + 5
            ENDFOR
        ELSE
            loc_cStr = ""
            FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
                loc_cCol = TRANSFORM(loc_nCnt)
                loc_cStr = loc_cStr + PADL(TRANSFORM(EVALUATE("loc_oGrid.Column" + loc_cCol + ".Width")), 3, "0") + ;
                    IIF(EVALUATE("loc_oGrid.Column" + loc_cCol + ".Visible"), "1", "0") + " "
            ENDFOR
            loc_oTxtCfg.Value = loc_cStr
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProdutoClick - btnProduto.Click no legado: abre o cadastro do
    * produto da linha corrente. FormProduto (ja migrado) e' standalone -
    * nao tem API publica para abrir direto num codigo especifico (o
    * legado usava Do Form ... Linked With, que nao existe mais - PILAR 3).
    * Abrimos o cadastro completo; o usuario busca o codigo (ja' visivel
    * no painel/grade) manualmente.
    *==========================================================================
    PROCEDURE BtnProdutoClick()
        LOCAL loc_oForm, loc_oException

        IF EMPTY(THIS.this_oBusinessObject.this_cRegCodigoItem)
            RETURN
        ENDIF

        TRY
            GarantirClasse("FormProduto")
            loc_oForm = CREATEOBJECT("FormProduto")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Produtos" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnProdutoClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgOperacaoClick - cmdOperacao.btnOperacao.Valid no legado: identifica
    * se a Movimentacao da linha corrente e' uma Operacao (SigCdOpe, abre
    * FormSigMvExp) ou um Pedido (SigCdOpd, abre FormSigMvPdt). A decisao +
    * a mensagem de guarda (registro invalido) ficam no BO
    * (ObterFormularioOperacaoRegistro, que o Form chama por valor-BYREF -
    * regra "@" obrigatoria, VFP9 passa por valor por default).
    *==========================================================================
    PROCEDURE CmgOperacaoClick()
        LOCAL loc_cFormulario, loc_cMensagem, loc_oForm, loc_oException

        loc_cMensagem   = ""
        loc_cFormulario = THIS.this_oBusinessObject.ObterFormularioOperacaoRegistro(@loc_cMensagem)

        IF !EMPTY(loc_cMensagem)
            MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1.SetFocus()
        ENDIF

        IF EMPTY(loc_cFormulario)
            RETURN
        ENDIF

        TRY
            DO CASE
                CASE loc_cFormulario == "SigMvExp"
                    GarantirClasse("FormSigMvExp")
                    loc_oForm = CREATEOBJECT("FormSigMvExp", THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                        "C", THIS.this_oBusinessObject.this_nRegNumero, THIS.this_oBusinessObject.this_cRegEmpresa, .T.)
                CASE loc_cFormulario == "SigMvPdt"
                    GarantirClasse("FormSigMvPdt")
                    loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                        "C", THIS.this_oBusinessObject.this_nRegNumero, THIS.this_oBusinessObject.this_cRegEmpresa, .T.)
            ENDCASE
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em CmgOperacaoClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSubNiveisClick - SubNiveis.Click no legado: abre a tela de
    * subniveis da venda corrente.
    *==========================================================================
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_oForm, loc_oException

        TRY
            GarantirClasse("FormSigMvSbn")
            loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, ;
                THIS.this_oBusinessObject.this_cRegEmpresa, ;
                THIS.this_oBusinessObject.this_cRegMovimentacao, ;
                THIS.this_oBusinessObject.this_nRegNumero)
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnSubNiveisClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnContaClick - CmdConta.Click no legado: abre o cadastro da conta/
    * cliente da venda. FormCTA (ja migrado, equivalente de SIGCDCTA) e'
    * standalone - mesma limitacao de BtnProdutoClick (sem API para abrir
    * direto num codigo).
    *==========================================================================
    PROCEDURE BtnContaClick()
        LOCAL loc_oForm, loc_oException

        IF EMPTY(THIS.this_oBusinessObject.this_cRegCodCliente)
            MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta!!!", "Dados Incompletos")
            RETURN
        ENDIF

        TRY
            GarantirClasse("FormCTA")
            loc_oForm = CREATEOBJECT("FormCTA")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Contas" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em BtnContaClick")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick / BtnImprimirClick - btnVisualizar.Click /
    * BtnImprimir.Click no legado: preview/impressao do relatorio de
    * embalagem (Report Form SigOpPck sobre um recorte INDEXADO/FILTRADO
    * de crPgRes01). O form novo equivalente (FormSigOpPck, OPERACIONAL, ja
    * migrado) tem FILTROS PROPRIOS e independentes - nao ha API publica
    * para injetar o recorte atual de cursor_4c_Detalhe nele (duplicar o
    * FRX e a logica de filtro aqui recriaria, fora de contexto, o que
    * aquele form ja faz). Por isso estes botoes abrem o FormSigOpPck para
    * o usuario refazer o filtro la.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.AbrirFormSigOpPck()
    ENDPROC

    PROCEDURE BtnImprimirClick()
        THIS.AbrirFormSigOpPck()
    ENDPROC

    PROTECTED PROCEDURE AbrirFormSigOpPck()
        LOCAL loc_oForm, loc_oException

        TRY
            GarantirClasse("FormSigOpPck")
            loc_oForm = CREATEOBJECT("FormSigOpPck")

            IF VARTYPE(loc_oForm) != "O"
                MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Etiquetas de Embalagem" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oException
            MsgErro(loc_oException.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oException.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oException.Procedure, "Erro em AbrirFormSigOpPck")
            RETURN
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRetornarClick - btnRetornar.Click no legado (cmgRetornar): volta
    * para a Pagina 1 (Filtros).
    *==========================================================================
    PROCEDURE BtnRetornarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *==========================================================================
    * BtnExportarClick / BtnExcelClick - btnExportar.Click / btnExcel.Click
    * no legado.
    *==========================================================================
    PROCEDURE BtnExportarClick()
        THIS.GerarTXT()
    ENDPROC

    PROCEDURE BtnExcelClick()
        THIS.GerarXLS()
    ENDPROC

    *==========================================================================
    * FLimpa - flimpa(pVal,pTip) no legado: formata um valor para linha de
    * TXT tabulado (C = remove TAB/LF/CR; N = formata com separador de
    * milhar), sempre terminando com CHR(9) (tabulacao, separador de
    * coluna).
    *==========================================================================
    PROCEDURE FLimpa(par_uValor, par_cTipo)
        LOCAL loc_cTipo, loc_cRetorno
        loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "N")

        DO CASE
            CASE loc_cTipo = "C"
                loc_cRetorno = STRTRAN(STRTRAN(STRTRAN(TratarNulo(par_uValor, ""), CHR(9), ""), CHR(10), ""), CHR(13), "")
            CASE loc_cTipo = "N"
                loc_cRetorno = ALLTRIM(TRANSFORM(TratarNulo(par_uValor, 0), "999,999,999,999.99"))
            OTHERWISE
                loc_cRetorno = ""
        ENDCASE

        RETURN loc_cRetorno + CHR(9)
    ENDPROC

    *==========================================================================
    * GerarTXT - gerartxt() no legado: exporta a aba CORRENTE de
    * pgf_4c_Resultados (Detalhamento/Totais por Empresa/Totais por
    * Vendedora) para TXT tabulado, com cabecalho de colunas.
    *==========================================================================
    PROCEDURE GerarTXT()
        LOCAL loc_cArquivo, loc_nPagina, loc_cStr

        loc_cArquivo = GETFILE("TXT", "Nome do Arquivo", "OK", 0, "Gerar Arquivo Separado Por Tabula" + CHR(231) + CHR(245) + "es")

        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        STRTOFILE("", loc_cArquivo)

        loc_nPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage

        IF !INLIST(loc_nPagina, 1, 2, 3)
            RETURN
        ENDIF

        DO CASE
            CASE loc_nPagina = 1
                loc_cStr = "Empresa" + CHR(9) + "C" + CHR(243) + "digo" + CHR(9) + "Data" + CHR(9) + "Vendedora" + CHR(9) + ;
                    "Barra" + CHR(9) + "Produto" + CHR(9) + "Descri" + CHR(231) + CHR(227) + "o do Produto" + CHR(9) + ;
                    "Cor" + CHR(9) + "Tamanho" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Venda Unit" + CHR(225) + "rio" + CHR(9) + ;
                    "Margem" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + "% Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "Valor do Cadastro" + CHR(9) + "Total" + CHR(9) + "Parcelas" + CHR(9) + "Condi" + CHR(231) + CHR(245) + "es de Pagamento" + CHR(9) + ;
                    "Cliente" + CHR(9) + "Nome do Cliente" + CHR(9) + "Fornecedor" + CHR(9) + "Nome do Fornecedor" + CHR(9) + ;
                    "Subgrupo" + CHR(9) + "Refer" + CHR(234) + "ncia" + CHR(9) + "Gde Grupo" + CHR(9) + "Grupo" + CHR(9) + ;
                    "Quantidade" + CHR(9) + "Movimenta" + CHR(231) + CHR(227) + "o" + CHR(9) + "Opera" + CHR(231) + CHR(227) + "o" + CHR(9)
                SELECT cursor_4c_Detalhe
            CASE loc_nPagina = 2
                loc_cStr = "Empresa" + CHR(9) + "Descritivo" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
                    "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
                SELECT cursor_4c_TotalEmpresa
            CASE loc_nPagina = 3
                loc_cStr = "Empresa" + CHR(9) + "Vendedora" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
                    "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
                    "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
                SELECT cursor_4c_TotalVendedora
        ENDCASE

        loc_cStr = loc_cStr + CHR(13)
        STRTOFILE(loc_cStr, loc_cArquivo, 1)

        SCAN
            loc_cStr = ""
            DO CASE
                CASE loc_nPagina = 1
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Empresa, "C") + ;
                        THIS.FLimpa(STR(cursor_4c_Detalhe.Numero, 10), "C") + ;
                        THIS.FLimpa(DTOC(cursor_4c_Detalhe.Data_Venda), "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Codigo_Vendedora, "C") + ;
                        THIS.FLimpa(STR(cursor_4c_Detalhe.Barras, 14), "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Codigo_Item, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Equivalente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Desc_Item, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Tamanho, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Val_Unitario, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Markup, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Parcelas, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cond_Pagto, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cod_Cliente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Nome_Cliente, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Cod_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Nome_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.SubGrupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Ref_Fornecedor, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Gde_Grupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Grupo, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Movimentacao, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Operacao, "C") + ;
                        THIS.FLimpa(cursor_4c_Detalhe.Local_Itn, "C")
                CASE loc_nPagina = 2
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Empresa, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Movimentacao, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalEmpresa.Tkt_Medio, "N")
                CASE loc_nPagina = 3
                    loc_cStr = loc_cStr + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Empresa, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Codigo_Vendedora, "C") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Valor_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Perc_Diferenca, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Venda_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Quantidade, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Total, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Custo_Cadastro, "N") + ;
                        THIS.FLimpa(cursor_4c_TotalVendedora.Tkt_Medio, "N")
            ENDCASE

            loc_cStr = loc_cStr + CHR(13)
            STRTOFILE(loc_cStr, loc_cArquivo, 1)
        ENDSCAN

        MsgInfo("O Arquivo " + CHR(34) + ALLTRIM(loc_cArquivo) + CHR(34) + " Foi Gerado!!!", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
    ENDPROC

    *==========================================================================
    * GerarXLS - gerarxls() no legado: exporta a aba CORRENTE de
    * pgf_4c_Resultados para XLS (COPY TO ... TYPE XL5).
    *==========================================================================
    PROCEDURE GerarXLS()
        LOCAL loc_cArquivo, loc_nPagina

        loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")

        IF EMPTY(loc_cArquivo) OR !fVerificaPasta(loc_cArquivo, 2)
            RETURN
        ENDIF

        loc_nPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.ActivePage

        IF USED("cursor_4c_Excel")
            USE IN cursor_4c_Excel
        ENDIF

        DO CASE
            CASE loc_nPagina = 1
                *-- Local_Itn nao faz parte do SELECT do legado (ver
                *-- gerarxls() - Tam_De/Tam_Para sim) - transcrito literal.
                *-- Nomes de Movimentacao de TOTAL conforme gravados pelo
                *-- proprio BO (MontarResultadoDetalhe: "TOTAL DE ENTRADAS"/
                *-- "TOTAL DE SAIDAS", sem acento - regra de comparacao
                *-- exact-safe via ALLTRIM em vez do literal com padding
                *-- fixo do dump legado).
                SELECT Empresa, Numero, Data_Venda, Codigo_Vendedora, Barras, ;
                       Tipo, Codigo_Item, Desc_Item, Equivalente, Cor, Tamanho, ;
                       Tam_De, Tam_Para, Custo_Cadastro, ;
                       Val_Unitario, Markup, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Total, Parcelas, Cond_Pagto, Cod_Cliente, ;
                       Nome_Cliente, Cod_Fornecedor, Nome_Fornecedor, SubGrupo, ;
                       Ref_Fornecedor, Gde_Grupo, Grupo, Quantidade, Movimentacao ;
                  FROM cursor_4c_Detalhe ;
                 WHERE !INLIST(ALLTRIM(Movimentacao), "TOTAL DE ENTRADAS", "TOTAL DE SAIDAS") ;
                 ORDER BY Empresa, Ordem, Data_Venda, Movimentacao, Numero, Item ;
                  INTO CURSOR cursor_4c_Excel
            CASE loc_nPagina = 2
                SELECT Empresa, Movimentacao, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
                  FROM cursor_4c_TotalEmpresa ;
                 ORDER BY Empresa, Ordem, Movimentacao ;
                  INTO CURSOR cursor_4c_Excel
            CASE loc_nPagina = 3
                SELECT Empresa, Codigo_Vendedora, Valor_Diferenca, Perc_Diferenca, ;
                       Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
                  FROM cursor_4c_TotalVendedora ;
                 ORDER BY Empresa, Ordem, Codigo_Vendedora ;
                  INTO CURSOR cursor_4c_Excel
            OTHERWISE
                RETURN
        ENDCASE

        SELECT cursor_4c_Excel
        COPY TO (loc_cArquivo) TYPE XL5
        USE IN cursor_4c_Excel

        MsgInfo("O Arquivo " + CHR(34) + ALLTRIM(loc_cArquivo) + CHR(34) + " Foi Gerado!!!", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
    ENDPROC

    *==========================================================================
    * DESTROY - Destrutor. FormBase.Destroy ja cuida da liberacao do BO e do
    * fix de menu-shrinks (Erro58) - esta subclasse so precisa encadear.
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpVdiBO.prg):
*------------------------------------------------------------------------------
* SigOpVdiBO - Business Object de "Pesquisa Detalhada" (vendas x cadastro)
* Baseado no formulario legado SIGOPVDI (SigOpVdi.SCX)
*
* Form OPERACIONAL de CONSULTA (sem INSERT/UPDATE/DELETE no legado): o
* Init() legado so monta cursores auxiliares de filtro (empresas, tipos de
* operacao, grande grupo, grupo de produtos, operacoes, moedas) e os
* resultados finais (crPgRes01/crPgRes02/crPgRes03) sao populados por
* Processamento() a partir dos filtros da Pagina 1. Nao ha tabela/PK
* principal - this_cTabela/this_cCampoChave ficam vazios de proposito.
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdiBO AS BusinessBase

    *-- Filtros de periodo (Get_DcI / Get_DcF)
    this_dDataIni = {}
    this_dDataFim = {}

    *-- Filtro de moeda de conversao (getCMoes / getDMoes)
    this_cMoeda     = ""
    this_cDescMoeda = ""

    *-- Filtro de grupo de venda / colecao (getCdGrVda / getDsGrVda)
    this_cGrupoVenda     = ""
    this_cDescGrupoVenda = ""

    *-- Filtro de subgrupo (get_cd_sgrupo / get_ds_sgrupo)
    this_cSubGrupo     = ""
    this_cDescSubGrupo = ""

    *-- Configuracao de larguras/colunas da grade (getCfgGrade - uso restrito ao usuario 4CONTROL)
    this_cConfigGrade = ""

    *-- Listas de codigos marcados nas grades de filtro da Pagina 1 (concatenadas
    *-- separadas por virgula, alimentadas a partir de crSigCdEmp/crTpOpe/
    *-- crGrdGpr/crGrdGru/crOpera - usadas para montar o WHERE de Processamento)
    this_cFiltroEmpresas     = ""
    this_cFiltroTipos        = ""
    this_cFiltroGrandeGrupo  = ""
    this_cFiltroGrupoProduto = ""
    this_cFiltroOperacoes    = ""

    *-- optValor1 (Pagina de resultados - ButtonCount=3): indice 1-based do
    *-- OptionGroup, nunca booleano (regra #188)
    this_nTipoValor = 1

    *==========================================================================
    * REGISTRO CORRENTE da grade de resultados (o "crPgRes01" sobre o qual o
    * legado opera depois que o usuario escolhe uma linha).
    *
    * No SCX legado SEIS pontos diferentes leem a linha corrente DIRETO do
    * cursor (grdDados1.AfterRowColChange, ImgFigJpg.Click, btnProduto.Click,
    * CmdConta.Click, SubNiveis.Click e cmdOperacao.btnOperacao.Valid), cada um
    * repetindo o seu proprio Nvl()/Empty(). Aqui essa leitura fica concentrada
    * em CarregarDoCursor(), que eh a fonte UNICA: o Form le estas properties e
    * nao toca no cursor.
    *==========================================================================
    this_cRegEmpresa         = ""
    this_cRegMovimentacao    = ""
    this_nRegNumero          = 0
    this_nRegItem            = 0
    this_dRegDataVenda       = {}
    this_cRegCodigoItem      = ""
    this_cRegDescItem        = ""
    this_cRegEquivalente     = ""
    this_cRegGdeGrupo        = ""
    this_cRegGrupo           = ""
    this_cRegSubGrupo        = ""
    this_cRegCodCliente      = ""
    this_cRegNomeCliente     = ""
    this_cRegCodVendedora    = ""
    this_cRegObsItem         = ""
    this_nRegDescAcres       = 0
    this_nRegVendaCadastroR  = 0
    this_mRegImagem          = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject. Form de consulta pura: nao ha
    * tabela/campo-chave (confirmado em analise.json: "tabela": "", "cursorName": "").
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.AplicarFiltrosPadrao()
            THIS.CriarCursoresResultado()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros, transcritos do
    * bloco de defaults do Init do SCX legado (dentro do "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .pgfPrincipal.pgFiltros.getDcI.Value = Date()
    *   .pgfPrincipal.pgFiltros.getDcF.Value = Date()
    *
    * A moeda padrao (getCMoes/getDMoes) vem do primeiro registro de
    * "Select CMoes, DMoes, nOrdRels From SigCdMoe Order By nOrdRels" (SQL,
    * depende de gnConnHandle) - carregada por metodo proprio em fase
    * posterior, nao aqui. Demais filtros (empresas/tipos/grande grupo/
    * grupo/operacoes/subgrupo) nascem vazios, que no legado significa
    * "nenhuma restricao adicional alem do que a grade de marcacao define".
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_dDataIni = DATE()
        THIS.this_dDataFim = DATE()
        THIS.this_cMoeda     = ""
        THIS.this_cDescMoeda = ""
        THIS.this_cGrupoVenda     = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cSubGrupo     = ""
        THIS.this_cDescSubGrupo = ""
        THIS.this_cConfigGrade = ""
        THIS.this_cFiltroEmpresas     = ""
        THIS.this_cFiltroTipos        = ""
        THIS.this_cFiltroGrandeGrupo  = ""
        THIS.this_cFiltroGrupoProduto = ""
        THIS.this_cFiltroOperacoes    = ""
        THIS.this_nTipoValor = 1

        RETURN .T.
    ENDPROC

    *==========================================================================
    * METODOS DE DADOS (equivalentes de CRUD para este form de CONSULTA)
    *
    * SIGOPVDI nao tem INSERT/UPDATE/DELETE no legado (confirmado em
    * analise.json: "tabela": "" e no dump do codigo fonte, que so Le dados
    * para montar o relatorio). Por isso Inserir()/Atualizar()/
    * ExecutarExclusao() NAO sao sobrescritos aqui - o comportamento padrao
    * herdado de BusinessBase ja eh o correto (recusar a operacao).
    *
    * Os metodos abaixo transcrevem, com a mesma estrutura e nomes do
    * legado, as rotinas de carga/filtro/calculo que sao a "logica de
    * negocio" real deste form (SigOpVdi.SCX):
    *   acertacolunas    -> fica no Form (Fase 3+, eh persistencia de Grid)
    *   buscaantigos     -> THIS.BuscarDadosAntigos()
    *   filgdegrupo      -> THIS.FiltrarGrandeGrupo()
    *   filgrupo         -> THIS.FiltrarGrupo()
    *   flimpa           -> fica no Form (Fase 3+, eh formatacao de exportacao)
    *   gerartxt/gerarxls-> ficam no Form (Fase 3+, sao exportacao/UI)
    *   gradepadrao      -> fica no Form (Fase 3+, eh largura de Grid)
    *   limpaemps        -> THIS.LimparEmpresasSemAcesso() (ver nota na Processar)
    *   montaemps        -> THIS.MontarFiltroEmpresas()
    *   montagrades      -> fica no Form (Fase 3+, eh bind de Grid)
    *   montapgres01     -> THIS.MontarResultadoDetalhe()
    *   montapgres02     -> THIS.MontarResultadoPorEmpresa()
    *   montapgres03     -> THIS.MontarResultadoPorVendedora()
    *   processamento    -> THIS.Processar() (orquestrador, sem UI)
    *   Init (SCX)       -> THIS.CarregarFiltrosIniciais()
    *   Load (SCX)       -> THIS.CriarCursoresResultado() (chamado no Init do BO)
    *
    * Nomes de cursor (CREATE CURSOR/SQLEXEC) usados por estes metodos -
    * MANTER estes nomes ao ligar os Grids no Form (Fase 3+):
    *   cursor_4c_TiposOperacao  (crTpOpe)   - nMarcas, CCodigos, Codigos, CDescricaos
    *   cursor_4c_GrandeGrupo    (crGrdGpr)  - nMarcas, Codigos, CDescricaos
    *   cursor_4c_GrupoProduto   (crGrdGru)  - nMarcas, Mercs, Codigos, CDescricaos
    *   cursor_4c_Operacoes      (crOpera)   - nMarcas, * (SigCdOpe), inclui Dopes/TipoOps
    *   cursor_4c_Empresas       (crSigCdEmp)- Imps, cemps, razas
    *   cursor_4c_GrupoAcesso    (crSigCdGre)- GruEmps, Tipos (paridade, sem consumo identificado)
    *   cursor_4c_Bruto          (crCursor1) - resultado da consulta principal
    *   cursor_4c_Detalhe        (crPgRes01) - grade "Detalhamento dos Produtos"
    *   cursor_4c_TotalEmpresa   (crPgRes02) - grade "Totais por Empresa"
    *   cursor_4c_TotalVendedora (crPgRes03) - grade "Totais por Vendedora"
    *==========================================================================

    *--------------------------------------------------------------------------
    * CriarCursoresResultado - Cria os cursores de resultado (equivalente ao
    * metodo Load() do SCX legado, que roda automaticamente apos o Init).
    * Chamado pelo proprio Init() deste BO - nao depende de conexao SQL.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresResultado()
        IF USED("cursor_4c_Detalhe")
            USE IN cursor_4c_Detalhe
        ENDIF
        IF USED("cursor_4c_TotalEmpresa")
            USE IN cursor_4c_TotalEmpresa
        ENDIF
        IF USED("cursor_4c_TotalVendedora")
            USE IN cursor_4c_TotalVendedora
        ENDIF

        *-- SigMvCab.Datas (origem de Data_Venda, SigOpVdiBO.prg:1179) e
        *-- NULLABLE no schema (docs/schema.sql) - sem SET NULL ON a
        *-- INSERT INTO...FROM MEMVAR (linha 822) estoura "Field DATA_VENDA
        *-- does not accept null values" quando a venda vem sem data.
        SET NULL ON
        CREATE CURSOR cursor_4c_Detalhe (Ordem C(1), Filtro N(1), Empresa C(3), Movimentacao C(20), ;
            Numero N(6), Data_Venda D, Codigo_Vendedora C(10), Item N(10), Tipo C(1), ;
            Codigo_Item C(14), Desc_Item C(40), Obs_Item M, Quantidade N(16,2), ;
            Val_Unitario N(16,2), Total N(16,2), Total_Geral N(16,2), Moeda C(3), ;
            Operacao C(1), Barras N(14), Gde_Grupo C(3), Grupo C(3), SubGrupo C(30), ;
            Custo_Cadastro N(16,2), Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), ;
            Moe_Vda_Cadastro C(3), Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), ;
            Nome_Cliente C(50), Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), ;
            Ref_Fornecedor C(20), Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), ;
            Parcelas N(3), Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), ;
            Local_Itn C(10), Equivalente C(14), Nome_Vendedora C(40), Categoria C(6), ;
            Desc_Categoria C(40), Descritivo C(45), Local C(10), Qtde N(12,0), Colecao C(60), ;
            Destino C(3), ContaOrigem C(10), Tam_De C(3), Tam_Para C(3))
        SET NULL OFF

        SELECT cursor_4c_Detalhe
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3

        SELECT * FROM cursor_4c_Detalhe INTO CURSOR cursor_4c_TotalEmpresa READWRITE
        SELECT cursor_4c_TotalEmpresa
        INDEX ON Empresa + Ordem + Movimentacao TAG Ordem

        SELECT * FROM cursor_4c_Detalhe INTO CURSOR cursor_4c_TotalVendedora READWRITE
        SELECT cursor_4c_TotalVendedora
        INDEX ON Empresa + Ordem + Codigo_Vendedora TAG Ordem

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFiltrosIniciais - Popula os cursores das grades de filtro da
    * Pagina 1 (equivalente ao bloco SQL do Init() do SCX legado). Depende
    * de gnConnHandle - o Form deve chamar isto fora do modo de teste de UI
    * (gb_4c_ValidandoUI), igual aos demais forms do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFiltrosIniciais()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        *-- 1) Tipos de Operacao (crTpOpe) - nasce com nMarcas = 0
        IF loc_lResultado
            loc_cSQL = "SELECT Codigos, Descrs, GerGdmis FROM SigCdTom"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOpBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Tipos de Opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_TiposOperacao")
                    USE IN cursor_4c_TiposOperacao
                ENDIF
                SELECT 0 AS nMarcas, STR(a.Codigos, 2) AS CCodigos, a.Codigos, ;
                       PADR(STR(a.Codigos, 2) + "-" + a.Descrs, 50) AS CDescricaos ;
                  FROM cursor_4c_TiposOpBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_TiposOperacao READWRITE
                USE IN cursor_4c_TiposOpBruto
            ENDIF
        ENDIF

        *-- 2) Grande Grupo de Produtos (crGrdGpr) - nasce com nMarcas = 1
        IF loc_lResultado
            loc_cSQL = "SELECT Codigos, Descs FROM SigCdGpr"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GdeGrupoBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Grande Grupo de Produtos." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_GrandeGrupo")
                    USE IN cursor_4c_GrandeGrupo
                ENDIF
                SELECT 1 AS nMarcas, a.Codigos, a.Codigos + "-" + a.Descs AS CDescricaos ;
                  FROM cursor_4c_GdeGrupoBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_GrandeGrupo READWRITE
                USE IN cursor_4c_GdeGrupoBruto
            ENDIF
        ENDIF

        *-- 3) Grupo de Produtos (crGrdGru) - nasce com nMarcas = 1
        IF loc_lResultado
            loc_cSQL = "SELECT Mercs, CGrus AS Codigos, DGrus AS Descs FROM SigCdGrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Grupo de Produtos." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_GrupoProduto")
                    USE IN cursor_4c_GrupoProduto
                ENDIF
                SELECT 1 AS nMarcas, a.Mercs, a.Codigos, a.Codigos + "-" + a.Descs AS CDescricaos ;
                  FROM cursor_4c_GrupoBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_GrupoProduto READWRITE
                USE IN cursor_4c_GrupoBruto
            ENDIF
        ENDIF

        *-- 4) Operacoes (crOpera) - nasce com nMarcas = 0
        *-- Cursor de SQLEXEC nasce SOMENTE-LEITURA: a Column1 deste cursor
        *-- hospeda um CheckBox (grd_4c_Operacoes) e os handlers de marcacao
        *-- fazem REPLACE/UPDATE em nMarcas. Por isso o SQLEXEC vai para um
        *-- alias TEMPORARIO e o cursor final eh convertido com READWRITE,
        *-- igual aos itens 1 a 3 acima.
        IF loc_lResultado
            IF USED("cursor_4c_OperacoesBruto")
                USE IN cursor_4c_OperacoesBruto
            ENDIF
            loc_cSQL = "SELECT 0 AS nMarcas, * FROM SigCdOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF
                SELECT * ;
                  FROM cursor_4c_OperacoesBruto ;
                  INTO CURSOR cursor_4c_Operacoes READWRITE
                USE IN cursor_4c_OperacoesBruto
                SELECT cursor_4c_Operacoes
                INDEX ON Dopes TAG Dopes
                INDEX ON TipoOps TAG IdxTipoOps
                GO TOP
            ENDIF
        ENDIF

        *-- 5) Empresas (crSigCdEmp) - restrito pelo acesso do usuario
        *-- (SigCdAce), exceto para o usuario tecnico 4CONTROL
        IF loc_lResultado
            *-- Mesma conversao para READWRITE do item 4: a Column1 de
            *-- grd_4c_Empresas eh um CheckBox EDITAVEL (no legado o
            *-- montagrades deixa grdEmps.Column1.ReadOnly = .F.) e o
            *-- cmg_4c_Empresas / chk_4c_Ck_MarcaEmp fazem UPDATE em Imps.
            *-- "0 AS Imps" (numerico), nao CONVERT(bit,0): CheckBox.Value
            *-- eh NUMERICO - bit chegaria como Logico e o IIF/comparacao
            *-- com 1 dos handlers estouraria type mismatch.
            IF USED("cursor_4c_EmpresasBruto")
                USE IN cursor_4c_EmpresasBruto
            ENDIF
            loc_cSQL = "SELECT 0 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Empresas." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Empresas")
                    USE IN cursor_4c_Empresas
                ENDIF
                SELECT * ;
                  FROM cursor_4c_EmpresasBruto ;
                  INTO CURSOR cursor_4c_Empresas READWRITE
                USE IN cursor_4c_EmpresasBruto
                IF UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) <> "4CONTROL"
                    loc_cSQL = "SELECT 0 AS Imps, a.emps AS cemps, b.razas " + ;
                               "FROM SigCdAce a INNER JOIN SigCdEmp b ON a.emps = b.cemps " + ;
                               "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasAcesso")
                    IF loc_nResultado < 0
                        MsgErro("Falha ao carregar Empresas por acesso." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                        loc_lResultado = .F.
                    ELSE
                        IF RECCOUNT("cursor_4c_EmpresasAcesso") > 0
                            SELECT cursor_4c_Empresas
                            ZAP
                            SELECT cursor_4c_EmpresasAcesso
                            SCAN
                                SCATTER MEMVAR
                                SELECT cursor_4c_Empresas
                                APPEND BLANK
                                GATHER MEMVAR
                                SELECT cursor_4c_EmpresasAcesso
                            ENDSCAN
                        ENDIF
                        USE IN cursor_4c_EmpresasAcesso
                    ENDIF
                ENDIF
                IF loc_lResultado
                    SELECT cursor_4c_Empresas
                    INDEX ON cemps TAG cemps
                    GO TOP
                ENDIF
            ENDIF
        ENDIF

        *-- 6) Moeda padrao de conversao - primeiro registro de SigCdMoe
        *-- ordenado por nOrdRels
        IF loc_lResultado
            loc_cSQL = "SELECT CMoes, DMoes, nOrdRels FROM SigCdMoe ORDER BY nOrdRels"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Moeda padr" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF RECCOUNT("cursor_4c_MoedaBruto") > 0
                    GO TOP IN cursor_4c_MoedaBruto
                    THIS.this_cMoeda     = ALLTRIM(cursor_4c_MoedaBruto.CMoes)
                    THIS.this_cDescMoeda = ALLTRIM(cursor_4c_MoedaBruto.DMoes)
                ENDIF
                USE IN cursor_4c_MoedaBruto
            ENDIF
        ENDIF

        *-- 7) Grupos de empresa com acesso (crSigCdGre) - mantido para
        *-- paridade com o Init legado; sem consumo direto identificado no
        *-- dump deste form (possivelmente usado pela classe-base do VCX).
        *-- Falha aqui NAO bloqueia o carregamento dos demais filtros.
        IF loc_lResultado
            IF USED("cursor_4c_GrupoAcesso")
                USE IN cursor_4c_GrupoAcesso
            ENDIF
            loc_cSQL = "SELECT DISTINCT a.grupo AS GruEmps, b.tipos " + ;
                       "FROM SigCdEmp a, SigCdGre b " + ;
                       "WHERE a.grupo = b.grupo AND a.cemps IN " + ;
                       "(SELECT g.emps FROM SigCdAce g WHERE g.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoAcesso")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarFiltroEmpresas - Equivalente a montaemps() do legado. Le o
    * cursor de empresas marcadas (Imps <> 0) e devolve o fragmento SQL
    * (" AND c.Emps = ..." / " AND c.Emps IN (...)") a concatenar na
    * consulta principal. Devolve "" quando nenhuma empresa esta marcada
    * (= nenhum filtro adicional, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE MontarFiltroEmpresas(par_cCursorEmpresas)
        LOCAL loc_cFiltro, loc_cVirgula

        loc_cFiltro = ""

        IF PCOUNT() < 1 OR EMPTY(par_cCursorEmpresas)
            par_cCursorEmpresas = "cursor_4c_Empresas"
        ENDIF

        IF USED(par_cCursorEmpresas)
            *-- "Imps <> 0" e nao "Imps": a coluna eh NUMERICA (CheckBox.Value
            *-- eh numerico) e VFP exige expressao LOGICA no WHERE.
            SELECT cemps FROM (par_cCursorEmpresas) WHERE Imps <> 0 INTO CURSOR cursor_4c_EmpsMarcadas

            IF USED("cursor_4c_EmpsMarcadas")
                DO CASE
                    CASE RECCOUNT("cursor_4c_EmpsMarcadas") = 1
                        loc_cFiltro = " AND c.Emps = " + EscaparSQL(ALLTRIM(cursor_4c_EmpsMarcadas.cemps))
                    CASE RECCOUNT("cursor_4c_EmpsMarcadas") > 1
                        loc_cFiltro = " AND c.Emps IN ("
                        loc_cVirgula = ""
                        SELECT cursor_4c_EmpsMarcadas
                        SCAN
                            loc_cFiltro = loc_cFiltro + loc_cVirgula + EscaparSQL(ALLTRIM(cemps))
                            loc_cVirgula = ", "
                        ENDSCAN
                        loc_cFiltro = loc_cFiltro + ")"
                ENDCASE
                USE IN cursor_4c_EmpsMarcadas
            ENDIF
        ENDIF

        RETURN loc_cFiltro
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarGrandeGrupo - Equivalente a filgdegrupo() do legado. Exclui de
    * par_cCursorDados as linhas cujo Gde_Grupo esta DESMARCADO na grade de
    * filtro (par_cCursorFiltro). Se nada estiver desmarcado, nao filtra
    * nada (mesma regra do legado).
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarGrandeGrupo(par_cCursorDados, par_cCursorFiltro)
        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF
        IF PCOUNT() < 2 OR EMPTY(par_cCursorFiltro)
            par_cCursorFiltro = "cursor_4c_GrandeGrupo"
        ENDIF

        IF !USED(par_cCursorFiltro) OR !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        SELECT (par_cCursorFiltro)
        LOCATE FOR nMarcas = 0
        IF EOF()
            RETURN .T.
        ENDIF

        SELECT Codigos FROM (par_cCursorFiltro) WHERE nMarcas = 0 INTO CURSOR cursor_4c_NaoMarcados
        SELECT cursor_4c_NaoMarcados
        SCAN
            DELETE FROM (par_cCursorDados) WHERE Gde_Grupo = cursor_4c_NaoMarcados.Codigos
        ENDSCAN
        USE IN cursor_4c_NaoMarcados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarGrupo - Equivalente a filgrupo() do legado. Exclui de
    * par_cCursorDados as linhas cujo Grupo esta DESMARCADO na grade de
    * filtro (par_cCursorFiltro).
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarGrupo(par_cCursorDados, par_cCursorFiltro)
        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF
        IF PCOUNT() < 2 OR EMPTY(par_cCursorFiltro)
            par_cCursorFiltro = "cursor_4c_GrupoProduto"
        ENDIF

        IF !USED(par_cCursorFiltro) OR !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        SELECT (par_cCursorFiltro)
        LOCATE FOR nMarcas = 0
        IF EOF()
            RETURN .T.
        ENDIF

        SELECT Codigos FROM (par_cCursorFiltro) WHERE nMarcas = 0 INTO CURSOR cursor_4c_NaoMarcados
        SELECT cursor_4c_NaoMarcados
        SCAN
            DELETE FROM (par_cCursorDados) WHERE Grupo = cursor_4c_NaoMarcados.Codigos
        ENDSCAN
        USE IN cursor_4c_NaoMarcados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparEmpresasSemAcesso - Equivalente a limpaemps() do legado. Exclui
    * de par_cCursorDados as linhas de empresas que o usuario logado nao
    * tem acesso (SigCdAce). NAO e chamado por THIS.Processar() - no
    * Processamento() legado esta chamada esta COMENTADA
    * ("*ThisForm.LimpaEmps([crCursor1])"), ou seja, desativada em producao.
    * Mantido aqui so para paridade com o metodo nomeado do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparEmpresasSemAcesso(par_cCursorDados)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF

        IF UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) <> "4CONTROL"
            loc_cSQL = "SELECT e.cemps AS Cemps FROM SigCdEmp e " + ;
                       "WHERE e.cemps NOT IN (SELECT a.emps FROM SigCdAce a WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsSemAcesso")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                IF USED(par_cCursorDados)
                    SELECT cursor_4c_EmpsSemAcesso
                    SCAN
                        DELETE FROM (par_cCursorDados) WHERE Empresa = cursor_4c_EmpsSemAcesso.Cemps
                    ENDSCAN
                ENDIF
                USE IN cursor_4c_EmpsSemAcesso
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDadosAntigos - Equivalente a buscaantigos() do legado. Para
    * cada linha de par_cCursorDados, busca o cadastro do produto (SigCdPrc)
    * e do tamanho (SigPrTa2) vigentes NA DATA DA VENDA, e sobrescreve os
    * campos de custo/venda/markup/fornecedor com esses valores historicos
    * quando encontrados (o cadastro atual do produto pode ter mudado desde
    * a venda).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDadosAntigos(par_cCursorDados)
        LOCAL loc_lResultado, loc_cProduto, loc_cTamanho, loc_dDataRef, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF

        IF !USED(par_cCursorDados)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorDados)
        SCAN
            loc_cProduto = NVL(Codigo_Item, "")
            loc_cTamanho = NVL(Tamanho, "")
            loc_dDataRef = NVL(Data_Venda, DATETIME())

            loc_cSQL = "SELECT TOP 1 p.Mercs AS Gde_Grupo, p.CGrus AS Grupo, p.SGrus AS SubGrupo, " + ;
                       "p.CustoFs AS Custo_Cadastro, p.MoeCusfs AS Moe_Cus_Cadastro, " + ;
                       "p.MarkupA AS Markup_Cadastro, p.Reffs AS Ref_Fornecedor, " + ;
                       "p.PVens AS Venda_Cadastro, p.PVens AS Desc_Acres, p.PVens AS Venda_CadastroR, " + ;
                       "p.Moevs AS Moe_Vda_Cadastro, p.FigJpgs AS Imagem, p.IFors AS Cod_Fornecedor " + ;
                       "FROM SigCdPrc p " + ;
                       "WHERE p.CPros = " + EscaparSQL(loc_cProduto) + ;
                       " AND p.DataAlts >= " + FormatarDataSQL(loc_dDataRef) + ;
                       " ORDER BY p.DataAlts DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Antigo")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Antigo") > 0
                    GO TOP IN cursor_4c_Antigo
                    REPLACE Gde_Grupo        WITH cursor_4c_Antigo.Gde_Grupo, ;
                            Grupo            WITH cursor_4c_Antigo.Grupo, ;
                            SubGrupo         WITH cursor_4c_Antigo.SubGrupo, ;
                            Custo_Cadastro   WITH cursor_4c_Antigo.Custo_Cadastro, ;
                            Moe_Cus_Cadastro WITH cursor_4c_Antigo.Moe_Cus_Cadastro, ;
                            Markup_Cadastro  WITH cursor_4c_Antigo.Markup_Cadastro, ;
                            Ref_Fornecedor   WITH cursor_4c_Antigo.Ref_Fornecedor, ;
                            Venda_Cadastro   WITH cursor_4c_Antigo.Venda_Cadastro, ;
                            Desc_Acres       WITH cursor_4c_Antigo.Desc_Acres, ;
                            Venda_CadastroR  WITH cursor_4c_Antigo.Venda_CadastroR, ;
                            Moe_Vda_Cadastro WITH cursor_4c_Antigo.Moe_Vda_Cadastro, ;
                            Imagem           WITH cursor_4c_Antigo.Imagem, ;
                            Cod_Fornecedor   WITH cursor_4c_Antigo.Cod_Fornecedor ;
                            IN (par_cCursorDados)

                    loc_cSQL = "SELECT TOP 1 t.Percs AS Markup_Tamanho, t.Valor AS Valor_Tamanho, " + ;
                               "t.PesoMs AS Peso_Tamanho " + ;
                               "FROM SigPrTa2 t " + ;
                               "WHERE t.CPros = " + EscaparSQL(loc_cProduto) + ;
                               " AND t.CodTams = " + EscaparSQL(loc_cTamanho) + ;
                               " AND t.DataAlts >= " + FormatarDataSQL(loc_dDataRef) + ;
                               " ORDER BY t.DataAlts DESC"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AntigoTam")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AntigoTam") > 0
                        GO TOP IN cursor_4c_AntigoTam
                        REPLACE Markup_Tamanho WITH cursor_4c_AntigoTam.Markup_Tamanho, ;
                                Valor_Tamanho  WITH cursor_4c_AntigoTam.Valor_Tamanho, ;
                                Peso_Tamanho   WITH cursor_4c_AntigoTam.Peso_Tamanho ;
                                IN (par_cCursorDados)
                    ENDIF
                    IF USED("cursor_4c_AntigoTam")
                        USE IN cursor_4c_AntigoTam
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Antigo")
                    USE IN cursor_4c_Antigo
                ENDIF
            ENDIF

            SELECT (par_cCursorDados)
        ENDSCAN

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoDetalhe - Equivalente a montapgres01() do legado.
    * Converte cada linha de cursor_4c_Bruto para a moeda par_cMoeda,
    * calcula parcelas/condicao de pagamento, aplica a regra de
    * acrescimo/desconto por numero de parcelas (regra fixa do cliente que
    * usa este relatorio - grupos "JOI" e "REL") e grava em
    * cursor_4c_Detalhe. No final, gera as linhas de totais (Filtro 1/2/3).
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoDetalhe(par_cMoeda)
        LOCAL loc_lResultado, loc_nCotacaoRef, loc_nCotacaoOutra, loc_cEdn, loc_cSQL, loc_nResultado
        LOCAL loc_cPontoAnt, loc_cSeparadorAnt, loc_cCondPagto, loc_cVirgula, loc_lEntrada
        LOCAL loc_nParcelas, loc_nDiferenca, loc_nAdicional, loc_nFiltro, loc_cCondicao
        LOCAL loc_cMovimento, loc_nMarkupTot, loc_nPercTot
        loc_lResultado = .T.

        IF !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_Bruto")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Detalhe
        SET ORDER TO
        ZAP

        SELECT cursor_4c_Bruto
        SCAN
            SCATTER MEMVAR MEMO

            loc_nCotacaoRef = fBuscarCotacao(par_cMoeda, m.Data_Venda, gnConnHandle)

            m.Ordem            = "A"
            m.Moeda            = NVL(m.Moeda, par_cMoeda)
            m.Moeda            = IIF(EMPTY(m.Moeda), par_cMoeda, m.Moeda)
            m.Quantidade       = NVL(m.Quantidade, 0.00)
            m.Val_Unitario     = NVL(m.Val_Unitario, 0.00)
            m.Total            = NVL(m.Total, 0.00)
            m.Custo_Cadastro   = NVL(m.Custo_Cadastro, 0.00)
            m.Moe_Cus_Cadastro = NVL(m.Moe_Cus_Cadastro, par_cMoeda)
            m.Moe_Cus_Cadastro = IIF(EMPTY(m.Moe_Cus_Cadastro), par_cMoeda, m.Moe_Cus_Cadastro)
            m.Venda_Cadastro   = NVL(m.Venda_Cadastro, 0.00)
            m.Moe_Vda_Cadastro = NVL(m.Moe_Vda_Cadastro, par_cMoeda)
            m.Moe_Vda_Cadastro = IIF(EMPTY(m.Moe_Vda_Cadastro), par_cMoeda, m.Moe_Vda_Cadastro)
            m.Valor_Tamanho    = NVL(m.Valor_Tamanho, 0.00)

            IF !EMPTY(m.Valor_Tamanho)
                m.Venda_Cadastro = m.Valor_Tamanho
            ENDIF

            IF par_cMoeda <> m.Moeda
                loc_nCotacaoOutra = fBuscarCotacao(m.Moeda, m.Data_Venda, gnConnHandle)
                m.Val_Unitario = ROUND((m.Val_Unitario * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
                m.Total        = ROUND((m.Total        * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            IF par_cMoeda <> m.Moe_Cus_Cadastro
                loc_nCotacaoOutra = fBuscarCotacao(m.Moe_Cus_Cadastro, m.Data_Venda, gnConnHandle)
                m.Custo_Cadastro = ROUND((m.Custo_Cadastro * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            IF par_cMoeda <> m.Moe_Vda_Cadastro
                loc_nCotacaoOutra = fBuscarCotacao(m.Moe_Vda_Cadastro, m.Data_Venda, gnConnHandle)
                m.Venda_Cadastro = ROUND((m.Venda_Cadastro * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            m.Desc_Acres      = 0
            m.Venda_CadastroR = m.Venda_Cadastro

            *-- Chave posicional (char(3)+char(20)+str(6) = char(29), igual
            *-- a SigMvPar.EmpDopNums) - NUNCA usar ALLTRIM aqui (regra #42)
            loc_cEdn = m.Empresa + m.Movimentacao + STR(m.Numero, 6)

            loc_cSQL = "SELECT p.EmpDopNums, p.FPags, p.TParcs, p.Datas, p.Vencs, f.Infos " + ;
                       "FROM SigMvPar p, SigOpFp f " + ;
                       "WHERE p.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND p.FPags = f.FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parcelas")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                loc_lEntrada = .F.
                *-- Verifica se alguma parcela foi para o dia da venda (ENTRADA) OU
                *-- se foi cartao de credito - considera A VISTA tambem (Infos = "T")
                SELECT * FROM cursor_4c_Parcelas WHERE TTOD(Datas) = TTOD(Vencs) OR Infos = "T" INTO CURSOR cursor_4c_Entradas
                GO TOP IN cursor_4c_Entradas
                IF !EOF("cursor_4c_Entradas")
                    loc_lEntrada = .T.
                ENDIF
                IF USED("cursor_4c_Entradas")
                    USE IN cursor_4c_Entradas
                ENDIF

                SELECT DISTINCT FPags FROM cursor_4c_Parcelas ORDER BY FPags INTO CURSOR cursor_4c_FormasPagto
                loc_cCondPagto = ""
                loc_cVirgula   = ""
                SELECT cursor_4c_FormasPagto
                SCAN
                    loc_cCondPagto = ALLTRIM(loc_cCondPagto) + loc_cVirgula + ALLTRIM(FPags)
                    loc_cVirgula   = " / "
                ENDSCAN
                USE IN cursor_4c_FormasPagto

                SELECT MAX(TParcs) AS TParcs FROM cursor_4c_Parcelas INTO CURSOR cursor_4c_MaxParcelas
                m.Parcelas   = NVL(cursor_4c_MaxParcelas.TParcs, 0)
                m.Cond_Pagto = loc_cCondPagto
                USE IN cursor_4c_MaxParcelas
                USE IN cursor_4c_Parcelas

                *-- Calculo de acrescimo/desconto por numero de parcelas - regra
                *-- fixa do cliente que usa este relatorio (unico que usa). Caso
                *-- outro cliente venha a usar, mover para parametro do sistema.
                *-- Grupo "JOI": acrescenta 2% ao valor de cadastro por parcela
                IF m.Gde_Grupo = "JOI"
                    IF m.Parcelas > 1
                        loc_nParcelas = IIF(loc_lEntrada, 1, 0)
                        FOR loc_nAdicional = 1 TO (m.Parcelas - loc_nParcelas)
                            loc_nDiferenca   = ((m.Venda_Cadastro * 2) / 100)
                            m.Venda_Cadastro = m.Venda_Cadastro + loc_nDiferenca
                            m.Desc_Acres     = m.Desc_Acres     + loc_nDiferenca
                        ENDFOR
                    ENDIF
                ENDIF

                *-- Grupo "REL": desconta 10% se 1 parcela, ou 5% de 2 a 5 parcelas
                IF m.Gde_Grupo = "REL"
                    IF m.Parcelas = 1
                        loc_nDiferenca   = ((m.Venda_Cadastro * 10) / 100)
                        m.Venda_Cadastro = m.Venda_Cadastro - loc_nDiferenca
                        m.Desc_Acres     = m.Desc_Acres     - loc_nDiferenca
                    ENDIF
                    IF BETWEEN(m.Parcelas, 2, 5)
                        loc_nDiferenca   = ((m.Venda_Cadastro * 5) / 100)
                        m.Venda_Cadastro = m.Venda_Cadastro - loc_nDiferenca
                        m.Desc_Acres     = m.Desc_Acres     - loc_nDiferenca
                    ENDIF
                ENDIF
            ENDIF

            m.Barras          = IIF(EMPTY(m.Barra_Individual), NVL(m.Barra_Geral, 0), NVL(m.Barra_Individual, 0))
            m.Imagem          = NVL(m.Imagem, "")
            m.Tamanho         = NVL(m.Tamanho, "")
            m.Cor             = NVL(m.Cor, "")
            m.Cod_Fornecedor  = NVL(m.Cod_Fornecedor, "")
            m.Nome_Fornecedor = NVL(m.Nome_Fornecedor, "")
            m.Obs_Item        = NVL(m.Obs_Item, "")
            m.Tipo            = NVL(m.Tipo, "")
            m.Item            = NVL(m.Item, 0)
            m.Valor_Diferenca = m.Val_Unitario - m.Venda_Cadastro
            m.Markup          = ROUND(IIF(EMPTY(m.Custo_Cadastro), 0, m.Val_Unitario / m.Custo_Cadastro), 2)
            m.Perc_Diferenca  = ROUND(IIF(EMPTY(m.Venda_Cadastro), 0, (100 - ((m.Val_Unitario / m.Venda_Cadastro) * 100)) * -1), 2)
            m.Codigo_Item     = NVL(m.Codigo_Item, "")
            m.Equivalente     = NVL(m.Equivalente, "")
            m.Desc_Item       = NVL(m.Desc_Item, "")
            m.Operacao        = NVL(m.Operacao, "O")
            m.Gde_Grupo       = NVL(m.Gde_Grupo, "")
            m.Grupo           = NVL(m.Grupo, "")
            m.SubGrupo        = ALLTRIM(NVL(m.SubDescrs, "")) + IIF(EMPTY(NVL(m.SubGrupo, "")), "", " (" + ALLTRIM(NVL(m.SubGrupo, "")) + ")")
            m.Ref_Fornecedor  = NVL(m.Ref_Fornecedor, "")
            m.Cod_Cliente     = NVL(m.Cod_Cliente, "")
            m.Nome_Cliente    = NVL(m.Nome_Cliente, "")
            m.Nome_Vendedora  = NVL(m.Nome_Vendedora, "")
            m.Categoria       = NVL(m.Categoria, "")
            m.Desc_Categoria  = NVL(m.Desc_Categoria, "")

            loc_cPontoAnt     = SET("POINT")
            loc_cSeparadorAnt = SET("SEPARATOR")
            SET POINT TO ","
            SET SEPARATOR TO "."
            m.Pct_Dif_Chr = TRANSFORM(m.Perc_Diferenca, "999,999,999.99")
            SET POINT     TO (loc_cPontoAnt)
            SET SEPARATOR TO (loc_cSeparadorAnt)

            INSERT INTO cursor_4c_Detalhe FROM MEMVAR

            SELECT cursor_4c_Bruto
        ENDSCAN

        *-- Total geral de cada venda (soma de todos os itens; saida soma
        *-- positivo, entrada soma negativo)
        UPDATE cursor_4c_Detalhe SET Total_Geral = 0

        SELECT Empresa, Movimentacao, Numero, SUM(Total * IIF(Operacao = "E", -1, 1)) AS Total ;
          FROM cursor_4c_Detalhe ;
         GROUP BY Empresa, Movimentacao, Numero ;
          INTO CURSOR cursor_4c_TotalPorVenda

        SELECT cursor_4c_TotalPorVenda
        SCAN
            UPDATE cursor_4c_Detalhe ;
               SET Total_Geral = cursor_4c_TotalPorVenda.Total ;
             WHERE Empresa = cursor_4c_TotalPorVenda.Empresa AND ;
                   Movimentacao = cursor_4c_TotalPorVenda.Movimentacao AND ;
                   Numero = cursor_4c_TotalPorVenda.Numero
        ENDSCAN
        USE IN cursor_4c_TotalPorVenda

        *-- Linhas de totais (Filtro 1 = acima do cadastro, 2 = abaixo, 3 =
        *-- geral), que entram no MESMO cursor de detalhe sem item vinculado
        *-- - usadas pelos indices Ordem1/Ordem2/Ordem3
        SELECT * FROM cursor_4c_Detalhe WHERE .F. INTO CURSOR cursor_4c_TotaisTmp READWRITE

        FOR loc_nFiltro = 1 TO 3
            DO CASE
                CASE loc_nFiltro = 1
                    loc_cCondicao = "Perc_Diferenca > 0"
                CASE loc_nFiltro = 2
                    loc_cCondicao = "Perc_Diferenca < 0"
                OTHERWISE
                    loc_cCondicao = ".T."
            ENDCASE

            SELECT Empresa, ;
                   Operacao AS Ordem, ;
                   SUM(Quantidade * IIF(Operacao = "E", -1, 1)) AS Quantidade, ;
                   SUM(Total * IIF(Operacao = "E", -1, 1)) AS Total, ;
                   SUM((Custo_Cadastro * Quantidade)  * IIF(Operacao = "E", -1, 1)) AS Custo_Cadastro, ;
                   SUM((Venda_Cadastro * Quantidade)  * IIF(Operacao = "E", -1, 1)) AS Venda_Cadastro, ;
                   SUM((Valor_Diferenca * Quantidade) * IIF(Operacao = "E", -1, 1)) AS Valor_Diferenca ;
              FROM cursor_4c_Detalhe ;
             WHERE &loc_cCondicao. ;
             GROUP BY 1, 2 ;
             ORDER BY 1, 2 ;
              INTO CURSOR cursor_4c_SubTotal

            SELECT cursor_4c_SubTotal
            SCAN
                loc_cMovimento = "TOTAL DE " + IIF(cursor_4c_SubTotal.Ordem = "E", "ENTRADAS", "SAIDAS")
                loc_nMarkupTot = IIF(EMPTY(cursor_4c_SubTotal.Custo_Cadastro), 0, cursor_4c_SubTotal.Total / cursor_4c_SubTotal.Custo_Cadastro)
                loc_nPercTot   = IIF(EMPTY(cursor_4c_SubTotal.Venda_Cadastro), 0, (100 - ((cursor_4c_SubTotal.Total / cursor_4c_SubTotal.Venda_Cadastro) * 100)) * -1)

                INSERT INTO cursor_4c_TotaisTmp (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                  Valor_Diferenca, Markup, Perc_Diferenca) ;
                                          VALUES (loc_nFiltro, loc_cMovimento, cursor_4c_SubTotal.Empresa, cursor_4c_SubTotal.Ordem, cursor_4c_SubTotal.Quantidade, cursor_4c_SubTotal.Total, ;
                                                  cursor_4c_SubTotal.Custo_Cadastro, cursor_4c_SubTotal.Venda_Cadastro, cursor_4c_SubTotal.Valor_Diferenca, ;
                                                  loc_nMarkupTot, loc_nPercTot)
            ENDSCAN
            USE IN cursor_4c_SubTotal
        ENDFOR

        SELECT cursor_4c_TotaisTmp
        SCAN
            INSERT INTO cursor_4c_Detalhe (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                            Valor_Diferenca, Markup, Perc_Diferenca) ;
                                    VALUES (cursor_4c_TotaisTmp.Filtro, cursor_4c_TotaisTmp.Movimentacao, cursor_4c_TotaisTmp.Empresa, cursor_4c_TotaisTmp.Ordem, ;
                                            cursor_4c_TotaisTmp.Quantidade, cursor_4c_TotaisTmp.Total, cursor_4c_TotaisTmp.Custo_Cadastro, cursor_4c_TotaisTmp.Venda_Cadastro, ;
                                            cursor_4c_TotaisTmp.Valor_Diferenca, cursor_4c_TotaisTmp.Markup, cursor_4c_TotaisTmp.Perc_Diferenca)
        ENDSCAN
        USE IN cursor_4c_TotaisTmp

        SELECT cursor_4c_Detalhe
        GO TOP

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoPorEmpresa - Equivalente a montapgres02() do legado.
    * Agrega as linhas de totais gerais (Filtro = 3) de cursor_4c_Detalhe
    * por Empresa, calculando Ticket Medio e Markup, e grava em
    * cursor_4c_TotalEmpresa. Inclui uma linha de total geral (todas as
    * empresas, marcada com Empresa = CHR(255) / Ordem = "T").
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoPorEmpresa()
        LOCAL loc_nQtdeVendas, loc_nPercTot, loc_nTktMedioTot

        IF !USED("cursor_4c_TotalEmpresa") OR !USED("cursor_4c_Detalhe")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_TotalEmpresa
        SET ORDER TO
        ZAP

        SELECT * FROM cursor_4c_Detalhe WHERE Filtro = 3 INTO CURSOR cursor_4c_DetalheFiltro3

        SELECT cursor_4c_DetalheFiltro3
        SCAN
            SCATTER MEMVAR MEMO

            SELECT DISTINCT Empresa, Movimentacao, Numero ;
              FROM cursor_4c_Detalhe ;
             WHERE Ordem = "A" AND Empresa = m.Empresa ;
              INTO CURSOR cursor_4c_AgrupamentoVendas
            loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
            USE IN cursor_4c_AgrupamentoVendas

            m.Tkt_Medio = IIF(loc_nQtdeVendas > 0, m.Total / loc_nQtdeVendas, 0)
            m.Markup    = IIF(EMPTY(m.Custo_Cadastro), 0, m.Total / m.Custo_Cadastro)
            m.Ordem     = "A"

            INSERT INTO cursor_4c_TotalEmpresa FROM MEMVAR

            SELECT cursor_4c_DetalheFiltro3
        ENDSCAN
        USE IN cursor_4c_DetalheFiltro3

        SELECT CHR(255) AS Empresa, ;
               "T" AS Ordem, ;
               SUM(Quantidade) AS Quantidade, ;
               SUM(Total) AS Total, ;
               SUM(Custo_Cadastro)  AS Custo_Cadastro, ;
               SUM(Venda_Cadastro)  AS Venda_Cadastro, ;
               SUM(Valor_Diferenca) AS Valor_Diferenca ;
          FROM cursor_4c_TotalEmpresa ;
         GROUP BY 1, 2 ;
         ORDER BY 1, 2 ;
          INTO CURSOR cursor_4c_TotalGeralEmpresa

        SELECT cursor_4c_TotalGeralEmpresa
        SCAN
            loc_nPercTot = IIF(EMPTY(cursor_4c_TotalGeralEmpresa.Venda_Cadastro), 0, (100 - ((cursor_4c_TotalGeralEmpresa.Total / cursor_4c_TotalGeralEmpresa.Venda_Cadastro) * 100)) * -1)

            SELECT DISTINCT Empresa, Movimentacao, Numero ;
              FROM cursor_4c_Detalhe ;
             WHERE Ordem = "A" ;
              INTO CURSOR cursor_4c_AgrupamentoVendas
            loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
            USE IN cursor_4c_AgrupamentoVendas

            loc_nTktMedioTot = IIF(loc_nQtdeVendas > 0, cursor_4c_TotalGeralEmpresa.Total / loc_nQtdeVendas, 0)

            INSERT INTO cursor_4c_TotalEmpresa (Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                 Valor_Diferenca, Markup, Perc_Diferenca, Tkt_Medio) ;
                                         VALUES (cursor_4c_TotalGeralEmpresa.Empresa, cursor_4c_TotalGeralEmpresa.Ordem, cursor_4c_TotalGeralEmpresa.Quantidade, cursor_4c_TotalGeralEmpresa.Total, ;
                                                 cursor_4c_TotalGeralEmpresa.Custo_Cadastro, cursor_4c_TotalGeralEmpresa.Venda_Cadastro, cursor_4c_TotalGeralEmpresa.Valor_Diferenca, ;
                                                 0, loc_nPercTot, loc_nTktMedioTot)
        ENDSCAN
        USE IN cursor_4c_TotalGeralEmpresa

        SELECT cursor_4c_TotalEmpresa
        SET ORDER TO Ordem
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoPorVendedora - Equivalente a montapgres03() do legado.
    * Agrega cursor_4c_Detalhe (Ordem = "A") por Empresa+Vendedora e faz
    * UNION ALL com as linhas de total por empresa (Ordem = "A" de
    * cursor_4c_TotalEmpresa), gravando o resultado em
    * cursor_4c_TotalVendedora.
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoPorVendedora()
        LOCAL loc_nMarkup, loc_nPerc, loc_nQtdeVendas, loc_nTktMedio

        IF !USED("cursor_4c_TotalVendedora") OR !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_TotalEmpresa")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_TotalVendedora
        SET ORDER TO
        ZAP

        SELECT Empresa, ;
               Codigo_Vendedora, ;
               "A" AS Ordem, ;
               SUM(Quantidade) AS Quantidade, ;
               SUM(Total) AS Total, ;
               SUM(Custo_Cadastro * Quantidade) AS Custo_Cadastro, ;
               SUM(Venda_Cadastro * Quantidade) AS Venda_Cadastro, ;
               SUM(Val_Unitario   * Quantidade) AS Val_Unitario, ;
               SUM(Valor_Diferenca) AS Valor_Diferenca, ;
               0000000000000.00 AS Tkt_Medio ;
          FROM cursor_4c_Detalhe ;
         WHERE Ordem = "A" ;
         GROUP BY 1, 2 ;
         UNION ALL ;
        SELECT Empresa, ;
               Codigo_Vendedora, ;
               "Z" AS Ordem, ;
               Quantidade, ;
               Total, ;
               Custo_Cadastro, ;
               Venda_Cadastro, ;
               Val_Unitario, ;
               Valor_Diferenca, ;
               Tkt_Medio ;
          FROM cursor_4c_TotalEmpresa ;
         WHERE Ordem = "A" ;
          INTO CURSOR cursor_4c_TotalVendPreparo READWRITE

        SELECT cursor_4c_TotalVendPreparo
        INDEX ON Empresa + Ordem + Codigo_Vendedora TAG Ordem

        SELECT cursor_4c_TotalVendPreparo
        SCAN
            loc_nMarkup = ROUND(IIF(EMPTY(Custo_Cadastro), 0, Val_Unitario / Custo_Cadastro), 2)
            loc_nPerc   = IIF(EMPTY(Venda_Cadastro), 0, (100 - ((Total / Venda_Cadastro) * 100)) * -1)

            IF Ordem = "A"
                SELECT DISTINCT Empresa, Movimentacao, Numero ;
                  FROM cursor_4c_Detalhe ;
                 WHERE Ordem = "A" AND ;
                       Empresa = cursor_4c_TotalVendPreparo.Empresa AND ;
                       Codigo_Vendedora = cursor_4c_TotalVendPreparo.Codigo_Vendedora ;
                  INTO CURSOR cursor_4c_AgrupamentoVendas
                loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
                USE IN cursor_4c_AgrupamentoVendas

                loc_nTktMedio = IIF(loc_nQtdeVendas > 0, cursor_4c_TotalVendPreparo.Total / loc_nQtdeVendas, 0)
            ELSE
                loc_nTktMedio = cursor_4c_TotalVendPreparo.Tkt_Medio
            ENDIF

            INSERT INTO cursor_4c_TotalVendedora (Empresa, Codigo_Vendedora, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                   Valor_Diferenca, Markup, Perc_Diferenca, Tkt_Medio) ;
                                           VALUES (cursor_4c_TotalVendPreparo.Empresa, cursor_4c_TotalVendPreparo.Codigo_Vendedora, cursor_4c_TotalVendPreparo.Ordem, cursor_4c_TotalVendPreparo.Quantidade, ;
                                                   cursor_4c_TotalVendPreparo.Total, cursor_4c_TotalVendPreparo.Custo_Cadastro, cursor_4c_TotalVendPreparo.Venda_Cadastro, cursor_4c_TotalVendPreparo.Valor_Diferenca, ;
                                                   loc_nMarkup, loc_nPerc, loc_nTktMedio)

            SELECT cursor_4c_TotalVendPreparo
        ENDSCAN
        USE IN cursor_4c_TotalVendPreparo

        SELECT cursor_4c_TotalVendedora
        SET ORDER TO Ordem
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Equivalente a processamento() do legado (orquestrador).
    * Sem nenhuma chamada de UI (progressbar/Refresh/ActivePage) - isso fica
    * a cargo do Form (Fase 3+), que deve trocar para a pagina de resultados
    * e posicionar a grade (optValor1.Value = 3 + Filtros(1,3) do legado)
    * depois de receber .T. aqui.
    *
    * par_cCursorEmpresas/Tipos/Operacoes/GrandeGrupo/GrupoProduto - aliases
    * dos cursores das grades de filtro da Pagina 1 (omitir para usar os
    * nomes padrao: cursor_4c_Empresas/TiposOperacao/Operacoes/GrandeGrupo/
    * GrupoProduto, que sao os mesmos criados por CarregarFiltrosIniciais).
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_dDataIni, par_dDataFim, par_cMoeda, par_cColecao, par_cSubGrupo, ;
                         par_cCursorEmpresas, par_cCursorTipos, par_cCursorOperacoes, ;
                         par_cCursorGrandeGrupo, par_cCursorGrupoProduto)
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cDataIniSQL, loc_cDataFimSQL, loc_dDataFimCompleta
        LOCAL loc_cWhereTipos, loc_cWhereOperacoes, loc_cWhereEmpresas, loc_cVirgula

        IF PCOUNT() < 6 OR EMPTY(par_cCursorEmpresas)
            par_cCursorEmpresas = "cursor_4c_Empresas"
        ENDIF
        IF PCOUNT() < 7 OR EMPTY(par_cCursorTipos)
            par_cCursorTipos = "cursor_4c_TiposOperacao"
        ENDIF
        IF PCOUNT() < 8 OR EMPTY(par_cCursorOperacoes)
            par_cCursorOperacoes = "cursor_4c_Operacoes"
        ENDIF
        IF PCOUNT() < 9 OR EMPTY(par_cCursorGrandeGrupo)
            par_cCursorGrandeGrupo = "cursor_4c_GrandeGrupo"
        ENDIF
        IF PCOUNT() < 10 OR EMPTY(par_cCursorGrupoProduto)
            par_cCursorGrupoProduto = "cursor_4c_GrupoProduto"
        ENDIF

        IF !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_TotalEmpresa") OR !USED("cursor_4c_TotalVendedora")
            THIS.CriarCursoresResultado()
        ENDIF

        IF USED("cursor_4c_Bruto")
            USE IN cursor_4c_Bruto
        ENDIF

        SELECT cursor_4c_Detalhe
        ZAP
        SELECT cursor_4c_TotalEmpresa
        ZAP
        SELECT cursor_4c_TotalVendedora
        ZAP

        *-- Tipos de Operacao marcados (equivalente ao bloco em linha do
        *-- Processamento legado)
        loc_cWhereTipos = ""
        IF USED(par_cCursorTipos)
            SELECT CCodigos FROM (par_cCursorTipos) WHERE nMarcas = 1 INTO CURSOR cursor_4c_TiposMarcados
            DO CASE
                CASE RECCOUNT("cursor_4c_TiposMarcados") = 1
                    loc_cWhereTipos = "o.TipoOps = " + ALLTRIM(cursor_4c_TiposMarcados.CCodigos)
                CASE RECCOUNT("cursor_4c_TiposMarcados") > 1
                    loc_cWhereTipos = "o.TipoOps IN ("
                    loc_cVirgula = ""
                    SELECT cursor_4c_TiposMarcados
                    SCAN
                        loc_cWhereTipos = loc_cWhereTipos + loc_cVirgula + ALLTRIM(CCodigos)
                        loc_cVirgula = ", "
                    ENDSCAN
                    loc_cWhereTipos = loc_cWhereTipos + ")"
            ENDCASE
            USE IN cursor_4c_TiposMarcados
        ENDIF

        IF EMPTY(loc_cWhereTipos)
            MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        *-- Operacoes marcadas (c.Dopes) - sem marcacao = sem filtro adicional
        loc_cWhereOperacoes = ""
        IF USED(par_cCursorOperacoes)
            SELECT Dopes FROM (par_cCursorOperacoes) WHERE nMarcas = 1 INTO CURSOR cursor_4c_OperacoesMarcadas
            DO CASE
                CASE RECCOUNT("cursor_4c_OperacoesMarcadas") = 1
                    loc_cWhereOperacoes = " AND c.Dopes = " + EscaparSQL(cursor_4c_OperacoesMarcadas.Dopes)
                CASE RECCOUNT("cursor_4c_OperacoesMarcadas") > 1
                    loc_cWhereOperacoes = " AND c.Dopes IN ("
                    loc_cVirgula = ""
                    SELECT cursor_4c_OperacoesMarcadas
                    SCAN
                        loc_cWhereOperacoes = loc_cWhereOperacoes + loc_cVirgula + EscaparSQL(Dopes)
                        loc_cVirgula = ", "
                    ENDSCAN
                    loc_cWhereOperacoes = loc_cWhereOperacoes + ")"
            ENDCASE
            USE IN cursor_4c_OperacoesMarcadas
        ENDIF

        loc_cWhereEmpresas = THIS.MontarFiltroEmpresas(par_cCursorEmpresas)

        loc_cDataIniSQL = FormatarDataSQL(par_dDataIni)
        loc_dDataFimCompleta = DATETIME(YEAR(par_dDataFim), MONTH(par_dDataFim), DAY(par_dDataFim), 23, 59, 59)
        loc_cDataFimSQL = FormatarDataSQL(loc_dDataFimCompleta)

        *-- Consulta principal (crCursor1 do legado) - detalhamento de venda
        *-- x cadastro do produto na data da venda
        loc_cSQL = "SELECT c.Emps AS Empresa, " + ;
                   "c.Dopes AS Movimentacao, " + ;
                   "c.Numes AS Numero, " + ;
                   "c.Datas AS Data_Venda, " + ;
                   "c.Vends AS Codigo_Vendedora, " + ;
                   "c3.RClis AS Nome_Vendedora, " + ;
                   "c.Valos AS Total_Geral, " + ;
                   "i.CItens AS Item, " + ;
                   "i.opers AS Tipo, " + ;
                   "i.CPros AS Codigo_Item, " + ;
                   "p.cproeqs AS Equivalente, " + ;
                   "i.DPros AS Desc_Item, " + ;
                   "i.Obs AS Obs_Item, " + ;
                   "i.Qtds AS Quantidade, " + ;
                   "i.Units AS Val_Unitario, " + ;
                   "i.Totas AS Total, " + ;
                   "i.Moedas AS Moeda, " + ;
                   "i.Opers AS Operacao, " + ;
                   "i.Codbarras AS Barra_Geral, " + ;
                   "s.CodBarras AS Barra_Individual, " + ;
                   "p.Mercs AS Gde_Grupo, " + ;
                   "p.CGrus AS Grupo, " + ;
                   "p.SGrus AS SubGrupo, " + ;
                   "sg.Descricaos AS SubDescrs, " + ;
                   "p.CustoFs AS Custo_Cadastro, " + ;
                   "p.MoeCusfs AS Moe_Cus_Cadastro, " + ;
                   "p.MarkupA AS Markup_Cadastro, " + ;
                   "p.Reffs AS Ref_Fornecedor, " + ;
                   "p.PVens AS Venda_Cadastro, " + ;
                   "p.PVens AS Desc_Acres, " + ;
                   "p.PVens AS Venda_CadastroR, " + ;
                   "p.Moevs AS Moe_Vda_Cadastro, " + ;
                   "p.FigJpgs AS Imagem, " + ;
                   "p.Categoria, " + ;
                   "g.Descs AS Desc_Categoria, " + ;
                   "s.CodTams AS Tamanho, " + ;
                   "s.CodCors AS Cor, " + ;
                   "t.Percs AS Markup_Tamanho, " + ;
                   "t.Valor AS Valor_Tamanho, " + ;
                   "t.PesoMs AS Peso_Tamanho, " + ;
                   "p.IFors AS Cod_Fornecedor, " + ;
                   "c2.RClis AS Nome_Fornecedor, " + ;
                   "c.ContaDs AS Cod_Cliente, " + ;
                   "c1.RClis AS Nome_Cliente, " + ;
                   "ISNULL(p.dpro2s,'') AS Descritivo, " + ;
                   "c.ContaOs AS ContaOrigem, " + ;
                   "RTRIM(ISNULL(p.colecoes,'')) + ' - ' + ISNULL(co.descs,'') AS Colecoes, " + ;
                   "i.localos AS LocalItn, " + ;
                   "ISNULL(b.tamde,'') AS tam_de, " + ;
                   "ISNULL(b.tampara,'') AS tam_para " + ;
              "FROM SigMvCab c " + ;
              "LEFT JOIN SigCdOpe o ON c.Dopes = o.Dopes " + ;
              "LEFT JOIN SigMvItn i ON c.EmpDopNums = i.EmpDopNums " + ;
              "LEFT JOIN SigMvIts s ON i.EmpDopNums = s.EmpDopNums AND i.CItens = s.CItens AND s.cpros = i.cpros " + ;
              "LEFT JOIN SigMvItp b ON i.EmpDopNums = b.EmpDopNums AND i.CItens = b.CItens " + ;
              "LEFT JOIN SigPrTam t ON s.CPros = t.CPros AND s.CodTams = t.CodTams " + ;
              "LEFT JOIN SigCdPro p ON i.CPros = p.CPros " + ;
              "LEFT JOIN SigCdCtg g ON g.Cods = p.Categoria " + ;
              "LEFT JOIN SigCdCli c1 ON c1.ICLis = c.ContaDs " + ;
              "LEFT JOIN SigCdCli c2 ON c2.ICLis = p.IFors " + ;
              "LEFT JOIN SigCdPsg sg ON sg.CGruCods = p.CGrus + p.SGrus " + ;
              "LEFT JOIN SigCdCli c3 ON c3.ICLis = c.Vends " + ;
              "LEFT JOIN SigCdCol co ON p.colecoes = co.colecoes " + ;
              "WHERE " + loc_cWhereTipos + " AND " + ;
              "c.Datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL + " AND " + ;
              "p.CPros IS NOT NULL" + loc_cWhereEmpresas + ;
              IIF(!EMPTY(par_cColecao), " AND p.Colecoes = " + EscaparSQL(par_cColecao), "") + ;
              IIF(!EMPTY(par_cSubGrupo), " AND p.Sgrus = " + EscaparSQL(par_cSubGrupo), "") + ;
              loc_cWhereOperacoes

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Bruto")
        IF loc_nResultado < 0
            MsgErro("Falha ao consultar vendas no per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Reaproveita dados de cadastro do produto na data da venda, quando
        *-- o cadastro atual nao traz informacao (produto alterado depois)
        IF !THIS.BuscarDadosAntigos("cursor_4c_Bruto")
            RETURN .F.
        ENDIF

        *-- Filtros de Grande Grupo e Grupo de Produto (exclui o que foi
        *-- desmarcado nas grades de filtro)
        THIS.FiltrarGrandeGrupo("cursor_4c_Bruto", par_cCursorGrandeGrupo)
        THIS.FiltrarGrupo("cursor_4c_Bruto", par_cCursorGrupoProduto)

        *-- Limpeza de empresas sem acesso: o Processamento legado tem esta
        *-- chamada COMENTADA ("*ThisForm.LimpaEmps([crCursor1])") - mantida
        *-- desativada aqui tambem, por fidelidade ao comportamento real
        * THIS.LimparEmpresasSemAcesso("cursor_4c_Bruto")

        IF !THIS.MontarResultadoDetalhe(par_cMoeda)
            RETURN .F.
        ENDIF

        IF !THIS.MontarResultadoPorEmpresa()
            RETURN .F.
        ENDIF

        IF !THIS.MontarResultadoPorVendedora()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a LINHA CORRENTE do cursor de resultados para as
    * properties this_cReg*/this_nReg*/this_dReg*/this_mReg*.
    *
    * Equivale ao que o legado faz espalhado em seis lugares sobre crPgRes01:
    *
    *   grdDados1.AfterRowColChange
    *       .getObsItn.Value      = Nvl(crPgRes01.Obs_Item, [])
    *       .getDesc_Acres.Value  = crPgRes01.Desc_Acres
    *       .getVdaCadastro.Value = crPgRes01.Venda_CadastroR
    *       (+ a figura, que sai por ExtrairImagemRegistro())
    *   ImgFigJpg.Click      -> Codigo_Item, Desc_Item, Grupo, SubGrupo
    *   btnProduto.Click     -> Codigo_Item
    *   CmdConta.Click       -> Cod_Cliente
    *   SubNiveis.Click      -> Empresa, Movimentacao, Numero
    *   cmdOperacao.btnOperacao.Valid -> Empresa, Movimentacao, Numero
    *
    * par_cAliasCursor eh opcional: sem ele vale "cursor_4c_Detalhe" (crPgRes01).
    * As grades de totais (cursor_4c_TotalEmpresa / cursor_4c_TotalVendedora)
    * tem a MESMA estrutura (sao derivadas por SELECT * no CriarCursoresResultado),
    * por isso o mesmo metodo atende as tres.
    *
    * Devolve .F. e LIMPA as properties quando nao ha linha corrente - assim o
    * Form nunca exibe no painel lateral o dado da linha anterior, e os botoes
    * de acao enxergam campo vazio, que eh exatamente a condicao que o legado
    * testa com Empty(crPgRes01.Empresa) / Not Eof([crPgRes01]).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_nAreaAnterior

        loc_lResultado = .F.

        IF PCOUNT() < 1 OR VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            par_cAliasCursor = "cursor_4c_Detalhe"
        ENDIF

        *-- Sem cursor aberto, ou cursor posicionado em BOF/EOF (grade vazia ou
        *-- linha fantasma), nao ha registro corrente: limpa e sai.
        IF !USED(par_cAliasCursor)
            THIS.LimparRegistroCorrente()
        ELSE
            loc_nAreaAnterior = SELECT()
            SELECT (par_cAliasCursor)

            IF EOF() OR BOF() OR RECCOUNT() = 0
                THIS.LimparRegistroCorrente()
            ELSE
                *-- Problema 9: com alias dinamico, SELECT (alias) primeiro e
                *-- campo acessado DIRETO - "campo" eh sintaxe invalida.
                THIS.this_cRegEmpresa        = ALLTRIM(TratarNulo(Empresa, ""))
                THIS.this_cRegMovimentacao   = ALLTRIM(TratarNulo(Movimentacao, ""))
                THIS.this_nRegNumero         = TratarNulo(Numero, 0)
                THIS.this_nRegItem           = TratarNulo(Item, 0)
                THIS.this_dRegDataVenda      = ConverterParaData(Data_Venda)
                THIS.this_cRegCodigoItem     = ALLTRIM(TratarNulo(Codigo_Item, ""))
                THIS.this_cRegDescItem       = ALLTRIM(TratarNulo(Desc_Item, ""))
                THIS.this_cRegEquivalente    = ALLTRIM(TratarNulo(Equivalente, ""))
                THIS.this_cRegGdeGrupo       = ALLTRIM(TratarNulo(Gde_Grupo, ""))
                THIS.this_cRegGrupo          = ALLTRIM(TratarNulo(Grupo, ""))
                THIS.this_cRegSubGrupo       = ALLTRIM(TratarNulo(SubGrupo, ""))
                THIS.this_cRegCodCliente     = ALLTRIM(TratarNulo(Cod_Cliente, ""))
                THIS.this_cRegNomeCliente    = ALLTRIM(TratarNulo(Nome_Cliente, ""))
                THIS.this_cRegCodVendedora   = ALLTRIM(TratarNulo(Codigo_Vendedora, ""))

                *-- Obs_Item eh MEMO: o legado usa Nvl(..., []) justamente porque
                *-- vem NULL do SigMvItn.Obs. Sem ALLTRIM, para preservar a
                *-- formatacao que o usuario digitou no pedido.
                THIS.this_cRegObsItem        = TratarNulo(Obs_Item, "")

                THIS.this_nRegDescAcres      = TratarNulo(Desc_Acres, 0)
                THIS.this_nRegVendaCadastroR = TratarNulo(Venda_CadastroR, 0)
                THIS.this_mRegImagem         = TratarNulo(Imagem, "")

                loc_lResultado = .T.
            ENDIF

            *-- Repoe a area de trabalho: quem chama eh o AfterRowColChange de
            *-- um Grid, e trocar o alias corrente por baixo dele desposiciona
            *-- outras grades ligadas a cursores irmaos.
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparRegistroCorrente - Zera as properties do registro corrente.
    * Usado por CarregarDoCursor() quando nao ha linha valida.
    *--------------------------------------------------------------------------
    PROCEDURE LimparRegistroCorrente()
        THIS.this_cRegEmpresa        = ""
        THIS.this_cRegMovimentacao   = ""
        THIS.this_nRegNumero         = 0
        THIS.this_nRegItem           = 0
        THIS.this_dRegDataVenda      = {}
        THIS.this_cRegCodigoItem     = ""
        THIS.this_cRegDescItem       = ""
        THIS.this_cRegEquivalente    = ""
        THIS.this_cRegGdeGrupo       = ""
        THIS.this_cRegGrupo          = ""
        THIS.this_cRegSubGrupo       = ""
        THIS.this_cRegCodCliente     = ""
        THIS.this_cRegNomeCliente    = ""
        THIS.this_cRegCodVendedora   = ""
        THIS.this_cRegObsItem        = ""
        THIS.this_nRegDescAcres      = 0
        THIS.this_nRegVendaCadastroR = 0
        THIS.this_mRegImagem         = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairImagemRegistro - Gera o arquivo .jpg temporario da figura do
    * registro corrente e devolve o caminho; devolve "" quando nao ha figura.
    *
    * Transcricao do bloco que o legado repete em grdDados1.AfterRowColChange
    * e em ImgFigJpg.Click:
    *
    *   lcArq = Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    *   If Not Empty(crPgRes01.Imagem) And Not IsNull(crPgRes01.Imagem)
    *       lcFoto = Strconv(Strtran(Strtran(Strtran(crPgRes01.Imagem,
    *                [data:image/png;base64,],[]),[data:image/jpeg;base64,],[]),
    *                [data:image/jpg;base64,],[]), 14)
    *       If (StrToFile(lcFoto, lcArq) > 0)
    *           .ImgFigJpg.Picture = (lcArq)
    *
    * SigCdPro.figjpgs guarda base64 (eventualmente com o prefixo data URI), e
    * por isso o STRCONV(..., 14) acontece UMA unica vez aqui - o mesmo padrao
    * de sigrecgpBO e sigtosenBO. Decodificar de novo o resultado corromperia o
    * JPEG, que a essa altura ja eh binario.
    *
    * O prefixo do nome do arquivo vem de go_4c_Sistema.Sys2015Tmp; a leitura
    * eh cercada por PEMSTATUS porque go_4c_Sistema eh objeto Empty e ler
    * membro ausente estoura em runtime.
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ExtrairImagemRegistro()
        LOCAL loc_cArquivo, loc_cFoto, loc_cPrefixo, loc_nBytes, loc_cRetorno

        loc_cRetorno = ""

        IF !ISNULL(THIS.this_mRegImagem) AND !EMPTY(THIS.this_mRegImagem)
            loc_cPrefixo = "4c_tmp_"
            IF TYPE("go_4c_Sistema") = "O"
                IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
                    loc_cPrefixo = go_4c_Sistema.Sys2015Tmp
                ENDIF
            ENDIF

            loc_cArquivo = ADDBS(SYS(2023)) + loc_cPrefixo + SYS(2015) + ".jpg"

            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                THIS.this_mRegImagem, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            loc_nBytes = STRTOFILE(loc_cFoto, loc_cArquivo)
            IF loc_nBytes > 0
                loc_cRetorno = loc_cArquivo
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTituloZoomRegistro / ObterSubtituloZoomRegistro - Legendas que o
    * legado monta ao abrir o zoom da figura (ImgFigJpg.Click):
    *
    *   Do Form SigOpZom With lcArq, ;
    *        [Produto : ] + Alltrim(crPgRes01.Codigo_Item) + [ - ] + Alltrim(crPgRes01.Desc_Item), ;
    *        [Grupo : ]   + crPgRes01.Grupo + [ - SubGrupo : ] + crPgRes01.SubGrupo
    *
    * PUBLIC (regra #51): o Form chama estes metodos de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ObterTituloZoomRegistro()
        RETURN "Produto : " + THIS.this_cRegCodigoItem + " - " + THIS.this_cRegDescItem
    ENDPROC

    PROCEDURE ObterSubtituloZoomRegistro()
        RETURN "Grupo : " + THIS.this_cRegGrupo + " - SubGrupo : " + THIS.this_cRegSubGrupo
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFormularioOperacaoRegistro - Decide QUAL tela de movimentacao abrir
    * para o registro corrente, transcrevendo cmdOperacao.btnOperacao.Valid:
    *
    *   lcQuery = [Select Dopes From SigCdOpe Where Dopes = '] + crPgRes01.Movimentacao + [']
    *   ... If Not Eof([TmpOpe]) -> Do Form SigMvExp
    *   senao
    *   lcQuery = [Select Dopps From SigCdOpd Where Dopps = '] + crPgRes01.Movimentacao + [']
    *   ... If Not Eof([TmpOpe]) -> Do Form SigMvPdt
    *
    * Devolve "SigMvExp", "SigMvPdt" ou "" (movimentacao nao cadastrada em
    * nenhuma das duas tabelas - no legado o botao simplesmente nao abre nada).
    * O par_cMensagem volta preenchido quando ha o que avisar ao usuario; eh
    * BYREF, e por isso o Form precisa chamar com "@" (VFP9 passa por valor).
    *
    * A guarda de registro valido eh a MESMA do legado (Empty nos tres campos
    * da chave), agora lendo as properties que CarregarDoCursor() alimentou.
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ObterFormularioOperacaoRegistro(par_cMensagem)
        LOCAL loc_cRetorno, loc_cSQL, loc_nResultado, loc_lSegue

        loc_cRetorno   = ""
        par_cMensagem  = ""
        loc_lSegue     = .T.

        IF EMPTY(THIS.this_cRegEmpresa) OR EMPTY(THIS.this_cRegMovimentacao) ;
                OR THIS.this_nRegNumero = 0
            par_cMensagem = "Selecione Um Registro V" + CHR(225) + "lido Na Grade de " + ;
                            "Itens!!!"
            loc_lSegue = .F.
        ENDIF

        IF loc_lSegue
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(THIS.this_cRegMovimentacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado < 0
                par_cMensagem = "Falha ao identificar a opera" + CHR(231) + CHR(227) + "o " + ;
                                THIS.this_cRegMovimentacao + "." + CHR(13) + CapturarErroSQL()
                loc_lSegue = .F.
            ENDIF
        ENDIF

        IF loc_lSegue
            SELECT cursor_4c_Operacao
            GO TOP
            IF !EOF("cursor_4c_Operacao")
                loc_cRetorno = "SigMvExp"
            ENDIF
            USE IN cursor_4c_Operacao
        ENDIF

        *-- Nao estando em SigCdOpe, o legado tenta SigCdOpd (operacoes de
        *-- pedido) e abre a tela SigMvPdt.
        IF loc_lSegue AND EMPTY(loc_cRetorno)
            loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + ;
                       EscaparSQL(THIS.this_cRegMovimentacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado < 0
                par_cMensagem = "Falha ao identificar a opera" + CHR(231) + CHR(227) + "o " + ;
                                THIS.this_cRegMovimentacao + "." + CHR(13) + CapturarErroSQL()
            ELSE
                SELECT cursor_4c_Operacao
                GO TOP
                IF !EOF("cursor_4c_Operacao")
                    loc_cRetorno = "SigMvPdt"
                ENDIF
                USE IN cursor_4c_Operacao
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro corrente, no formato EmpDopNums
    * que o SigMvCab/SigMvItn/SigMvPec usam (regra #42): chave POSICIONAL de
    * char(29) = Emps char(3) + Dopes char(20) + Str(Numes, 6).
    *
    * O padding FAZ PARTE da chave: as properties guardam o valor com ALLTRIM
    * (CarregarDoCursor), entao o PADR explicito aqui eh obrigatorio - ALLTRIM
    * nas partes interiores produziria uma chave curta que nunca casa, e a
    * consulta devolveria ZERO linha sem erro nenhum.
    *
    * PROTECTED: segue a visibilidade de BusinessBase (regra #51) - o Form usa
    * as properties this_cReg*, nunca este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cRegEmpresa, 3) + ;
               PADR(THIS.this_cRegMovimentacao, 20) + ;
               STR(THIS.this_nRegNumero, 6)
    ENDPROC

ENDDEFINE

