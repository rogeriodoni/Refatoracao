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
[2026-10-29 19:39:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-29 19:39:57] [INFO] Config FPW: (nao fornecido)
[2026-10-29 19:39:57] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-29 19:39:57] [INFO] Timeout: 300 segundos
[2026-10-29 19:39:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_snh3hywh.prg
[2026-10-29 19:39:57] [INFO] Conteudo do wrapper:
[2026-10-29 19:39:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigopcim', 'C:\4c\tasks\task701\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcim', 'C:\4c\tasks\task701\logs\06_testForm.log'
QUIT

[2026-10-29 19:39:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_snh3hywh.prg
[2026-10-29 19:39:57] [INFO] VFP output esperado em: C:\4c\tasks\task701\vfp_output.txt
[2026-10-29 19:39:57] [INFO] Executando Visual FoxPro 9...
[2026-10-29 19:39:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_snh3hywh.prg
[2026-10-29 19:39:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_snh3hywh.prg
[2026-10-29 19:39:57] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigopcim
Inicio: 29/10/2026 19:39:57

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - Excecao ao criar objeto:
     Mensagem: Class definition FORMSIGOPCIM is not found.
     Codigo: 1733
     Linha: 166

=== RESULTADO DO TESTE ===
Fim: 29/10/2026 19:40:15
Duracao: 18 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-29 19:40:15] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-29 19:40:15] [INFO] VFP9 finalizado em 17.8173525 segundos
[2026-10-29 19:40:15] [INFO] Exit Code: 
[2026-10-29 19:40:15] [INFO] 
[2026-10-29 19:40:15] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-29 19:40:15] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_snh3hywh.prg
[2026-10-29 19:40:15] [INFO] 
[2026-10-29 19:40:15] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-29 19:40:15] [INFO] * Auto-generated wrapper for parameters
[2026-10-29 19:40:15] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-29 19:40:15] [INFO] * Parameters: 'Formsigopcim', 'C:\4c\tasks\task701\logs\06_testForm.log'
[2026-10-29 19:40:15] [INFO] 
[2026-10-29 19:40:15] [INFO] * Anti-dialog protections for unattended execution
[2026-10-29 19:40:15] [INFO] SET SAFETY OFF
[2026-10-29 19:40:15] [INFO] SET RESOURCE OFF
[2026-10-29 19:40:15] [INFO] SET TALK OFF
[2026-10-29 19:40:15] [INFO] SET NOTIFY OFF
[2026-10-29 19:40:15] [INFO] SYS(2335, 0)
[2026-10-29 19:40:15] [INFO] 
[2026-10-29 19:40:15] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcim', 'C:\4c\tasks\task701\logs\06_testForm.log'
[2026-10-29 19:40:15] [INFO] QUIT
[2026-10-29 19:40:15] [INFO] 
[2026-10-29 19:40:15] [INFO] === Fim do Wrapper.prg ===
[2026-10-29 19:40:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcim.prg):
*==============================================================================
* Formsigopcim.prg - Consulta/Exclusao de Imagem (Leitura de Codigo de Barras)
* Origem: SIGOPCIM.SCX (tasks/task701)
* Herda de: FormBase
* Tipo: OPERACIONAL (form filho/modal) - leitura de barras para consulta da
*       imagem/dados do produto ou exclusao de leituras do inventario.
*       Aberto pelo form pai com: CREATEOBJECT("Formsigopcim", lExcluir, oFormPai)
*       Layout: FLAT (sem PageFrame) - o legado SIGOPCIM e dialogo unico modal
*       (WindowType=1, 800x320): cabecalho + campos de consulta (Barra/
*       Produto/Descricao/Peso/Linha) + imagem do produto + grid de historico
*       de leituras (CrInvH) + botao Excluiitem (so visivel em modo exclusao)
*       + botao Saida.
*
* Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init() que
* recebe os parametros do form chamador - equivalente ao "Parameters
* lExcluir, OldForm" do legado -, InicializarForm(), Destroy()) e o
* cabecalho (cnt_4c_Sombra com os dois labels sobrepostos), com geometria
* TRANSCRITA do dump.
*
* Fase 4/8 - GRID + BOTOES: o legado SIGOPCIM NAO e um cadastro CRUD (nao
* tem Incluir/Alterar/Visualizar/Buscar) - e um dialogo filho que mostra o
* HISTORICO de leituras de barras (Grade/CrInvH) e so tem dois botoes reais:
* Excluiitem (so visivel em modo exclusao) e Saida. Portanto esta fase
* acrescenta: grd_4c_Dados (grid, 5 colunas, equivalente a Grade/CrInvH),
* cursor_4c_Historico (clone do cursor GLOBAL "Historico" que o form PAI
* mantem aberto - fallback cria vazio para teste/validacao de UI) e
* cursor_4c_InvH (equivalente a CrInvH, clone vazio de cursor_4c_Historico),
* MontaGrade() (equivalente a THISFORM.AcertaGrade() do legado) e os
* botoes cmd_4c_Excluiitem/cmd_4c_Saida com os Click completos. Campos de
* consulta (Get_Barra/Get_Produto/...) e imagem entram nas fases 5 e 6;
* consolidacao final na Fase 8.
*
* Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1): ConfigurarCampos() com a primeira
* metade dos campos de consulta do dump (ordem do SCX: Get_Descricao,
* Get_Barra, Get_Produto, Get_Peso, Get_Linha) - txt_4c_Barra (entrada,
* TabIndex 1), txt_4c_Produto (entrada, TabIndex 2) e txt_4c_Descricao
* (exibicao, ReadOnly - equivalente ao "When / Return(.F.)" do legado) com
* os respectivos labels (lbl_4c_Label5/lbl_4c_Lbl_produto/
* lbl_4c_Lbl_descricao). Get_Peso/Get_Linha, a imagem (ShpFigura/ImgJpg) e
* a logica de Valid/When/LostFocus (lookups fwBuscaExt/SqlExecute) entram
* na Fase 6.
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: txt_4c_Peso/txt_4c_Linha (campos
* de EXIBICAO - "When / Return(.F.)" no legado, aqui .ReadOnly = .T.) e a
* imagem do produto (shp_4c_ShpFigura/img_4c_ImgJpg). BINDEVENT completo
* dos campos de entrada: txt_4c_Barra usa GotFocus (equivalente ao When -
* reposiciona cursor_4c_InvH e trata a leitora serial) e LostFocus
* (equivalente a Valid+LostFocus combinados - consulta SigOpEtq via
* sigopcimBO.ConsultarBarra/ConsultarProduto, atualiza cursor_4c_InvH a
* partir de cursor_4c_Historico/SigIvTrH, decodifica a foto e devolve o
* foco a grade). txt_4c_Produto usa LostFocus com o picker FormBuscaAuxiliar
* (equivalente ao CreateObject('fwBuscaExt',...) do legado, regra CLAUDE.md
* #37) e fica habilitado so quando Barra esta vazio (equivalente ao When
* "Return(Empty(ThisForm.Get_Barra.Value))"). Consolidacao final na Fase 8.
*
* Fase 7/8 - EVENTOS PRINCIPAIS: o SIGOPCIM NAO tem superficie CRUD alguma,
* entao os nomes canonicos BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick NAO existem aqui - cria-los seria
* INVENTAR botoes que o legado nao tem (viola o PILAR 1) ou deixar quatro
* metodos vazios (proibido pela regra de completude). Medido no dump
* tasks/task701/sigopcim_form_codigo_fonte.txt: ZERO ocorrencias de
* "frmcadastro" (a classe base nao eh o cadastro do framework - o SCX herda
* de "form" puro), ZERO de "Grupo_Op" (nao ha a barra CRUD do framework),
* ZERO de "pcEscolha" (nao ha variavel de modo INSERIR/ALTERAR/PROCURAR) e
* ZERO de "<verbo>.Click". Os UNICOS dois botoes do legado sao Excluiitem e
* Saida (dois objetos BaseClass commandbutton no layout.json), e os eventos
* principais deles sao CmdExcluiitemClick/CmdSaidaClick - ja completos.
*
* Esta fase AUDITOU esses dois Click contra o dump e corrigiu duas
* divergencias que estouravam em RUNTIME (detalhe no comentario de cada
* sitio): (1) CmdExcluiitemClick limpava txt_4c_Barra com "" - o legado faz
* isso, mas aqui o controle nasce NUMERICO (Value = 0 no SCX) e cbars eh
* numeric(14,0), entao o tipo caractere quebrava o SEEK de toda leitura
* seguinte; agora limpa com 0. (2) o SEEK por produto usava o valor TRIMADO
* contra o indice "cpros" char(14) - com SET EXACT ON (config.prg) ele falha
* sempre; agora usa PADR(...,14), no handler e no AtualizarCrInvHPorProduto.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Quatro blocos que o
* legado JA TEM, espalhados e duplicados pelo migrador, viraram metodo unico
* - cada um deles e' a transcricao de um trecho que o SCX repete literalmente:
*
*   CarregarLista()        <- "Select CrInvH / Update CrInvH Set Obs =
*                             Nvl(Obs,'') / ThisForm.AcertaGrade() /
*                             Select CrInvH / Go Top", o rodape IDENTICO dos
*                             DOIS Valid (Get_Barra e Get_Produto). Popular o
*                             cursor NAO repinta a grade (regra CLAUDE.md
*                             #21a/#46) - por isso o funil unico, chamado em
*                             cada caminho que mexe no cursor da grade.
*   BOParaForm()           <- "Get_Produto.Value = TmpPro.CPros /
*                             Get_Descricao.Value = TmpPro.DPros /
*                             Get_Peso.Value = ... / Get_Linha.Value = ...",
*                             bloco que os dois Valid repetem.
*   FormParaBO()           <- a transferencia inversa (os dois campos de
*                             ENTRADA da tela para as properties do BO), que
*                             antes so existia como argumento solto de cada
*                             chamada.
*   AjustarBotoesPorModo() <- "ExcluiItem.Visible = Excluir / Shape2.Visible =
*                             Excluir / Shape3.Visible = !Excluir", as MESMAS
*                             tres linhas em TRES lugares do legado (Init,
*                             Valid de Get_Barra, Valid de Get_Produto).
*
* Mais tres consertos de fidelidade que a consolidacao expos:
*
*   (a) o FIM do Init legado nunca foi migrado - "Select Historico / Go Bottom
*       / Go Top" e a limpeza do campo Barra com o foco nele. O SetFocus vai
*       no Activate, nao no Init: antes de a tela estar visivel ele estoura
*       (padrao do projeto, ver FormSigMvMen).
*   (b) "ThisForm.Grade.RecordSource = ''" que o legado executa ANTES de
*       reconstruir CrInvH. O ramo de fallback FECHA e RECRIA esse cursor, e
*       derrubar um alias ligado ao Grid zera o ColumnCount dele (a grade vira
*       um retangulo branco, sem erro e sem log).
*   (c) a falha de CONEXAO das consultas de barra/produto era engolida. O
*       legado exibe "Favor reinicializar o processo !!!" e ABORTA o Valid
*       (Return(.F.)); o BO agora distingue "nao achei" (que NAO e erro) de
*       "a consulta falhou" com this_lFalhaConexao, e a tela aborta a leitura.
*       Pelo mesmo motivo a property do codigo de barras no BO passou a ser
*       NUMERICA (this_nBarra): cbars e numeric(14,0) no schema e o SCX declara
*       o TextBox com Value = 0 - guardar char exigiria STR/VAL nos dois
*       sentidos e qualquer SEEK no indice numerico com chave caractere
*       estouraria, a mesma armadilha que a Fase 7 corrigiu no controle.
*
* Os nomes canonicos de form CRUD - os Btn<verbo>Click da barra de cadastro,
* o par gravar/descartar da Page2 de Dados e o ajuste de campos por modo de
* edicao - NAO existem nesta tela e nao foram criados. Medido no dump
* tasks/task701/sigopcim_form_codigo_fonte.txt: ZERO ocorrencias de
* "frmcadastro", "Grupo_Op" e "pcEscolha", e ZERO de objeto/metodo de gravar
* (nao ha botao de gravacao, nem Page1/Page2, nem modo de edicao cancelavel).
* O SCX tem DOIS botoes - Excluiitem e Saida -, ambos com handler completo.
* Inventa-los violaria o PILAR 1; cria-los vazios violaria a regra de
* completude. O unico ajuste de habilitacao que o legado tem e' o When de
* Get_Produto ("Return(Empty(ThisForm.Get_Barra.Value))") - esse esta em
* HabilitarCampos(), que substitui o AtualizarEstadoProduto das fases
* anteriores (mesmo corpo, nome canonico).
*==============================================================================

DEFINE CLASS Formsigopcim AS FormBase

    Height       = 320
    Width        = 800
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 0
    BorderStyle  = 2
    AutoCenter   = .T.
    FontSize     = 9

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form chamador (equivalente a "Parameters
    *-- lExcluir, OldForm" do PROCEDURE Init legado)
    this_lExcluir    = .F.    && .T. = modo "Exclusao de Barras" / .F. = "Consulta Imagem"
    this_oParentForm = .NULL. && form pai - expoe TipoLeitora/LeituraSerial/ReadComm (fases 6-7)

    *-- Guarda de reentrancia do picker de produto (regra CLAUDE.md #37/#47 -
    *-- FormBuscaAuxiliar e modal e tira o foco, o que pode redisparar o
    *-- proprio LostFocus que o abriu)
    this_lEmLookupProduto = .F.

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador e define o Caption com CHR()
    * antes de delegar ao FormBase. Equivalente a:
    *   "Parameters lExcluir, OldForm"
    *   "ThisForm.ParentForm = OldForm"
    *   "ThisForm.Excluir    = lExcluir"
    *   "ThisForm.Caption    = Iif(lExcluir,'Exclusao de Barras','Consulta Imagem')"
    * do PROCEDURE Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lExcluir, par_oParentForm)
        THIS.this_lExcluir    = IIF(VARTYPE(par_lExcluir) = "L", par_lExcluir, .F.)
        THIS.this_oParentForm = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)

        THIS.Caption = IIF(THIS.this_lExcluir, ;
            "Exclus" + CHR(227) + "o de Barras", ;
            "Consulta Imagem")

        *-- WindowType=1 (modal) causaria TIMEOUT em VFP9 -T. Classe definida
        *-- com WindowType=0; producao restaura para modal aqui, fora de
        *-- teste/validacao de UI (mesmo padrao de FormSIGOPCCO).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopcimBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopcimBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                *-- "ExcluiItem/Shape2/Shape3.Visible" do Init legado. Vem
                *-- DEPOIS do TornarControlesVisiveis de proposito: esses tres
                *-- nomes estao na lista de excecao dele justamente para que
                *-- quem decide a visibilidade seja o modo, nao a varredura.
                THIS.AjustarBotoesPorModo()

                *-- FIM do Init legado, que as fases anteriores descartaram:
                *--   Select Historico / Go Bottom / Go Top
                *--   ThisForm.Get_Barra.Value = ''
                *-- (o SetFocus que fecha o Init legado esta no Activate -
                *-- antes de a tela estar visivel ele estoura).
                IF USED("cursor_4c_Historico")
                    SELECT cursor_4c_Historico
                    GO BOTTOM
                    GO TOP
                ENDIF

                *-- 0, nunca "": o controle e NUMERICO (ver CmdExcluiitemClick)
                THIS.txt_4c_Barra.Value = 0
                THIS.HabilitarCampos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPCIM e flat, sem Page1=Lista/
    * Page2=Dados); o nome e mantido por conformidade com o contrato do
    * pipeline multi-fase. Os helpers de campos de consulta/imagem
    * (ConfigurarCampos / ConfigurarImagem) entram nas Fases 5 e 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarImagem()
        THIS.ConfigurarCursorHistorico()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - campos de consulta criados DIRETO no form (layout
    * FLAT, sem container - igual ao legado). Geometria TRANSCRITA do dump
    * (Top/Left/Width/Height/Font/Format/MaxLength EXATOS). Os labels sao da
    * classe "say" do Framework (AutoSize=.T. no dump, sem Width/Alignment
    * declarados) - por isso aqui usam .AutoSize = .F. + Width/Height
    * TRANSCRITOS do SCX e .ForeColor = RGB(90,90,90) (regra CLAUDE.md #12 e
    * #23 - o dump nao declara ForeColor nem Width/Alignment para a classe
    * say "pura").
    *
    * txt_4c_Barra e txt_4c_Produto sao os campos de ENTRADA reais (TabIndex
    * 1 e 2 no dump - ja referenciados por GradeAfterRowColChange() e
    * CmdExcluiitemClick() desde a Fase 4). txt_4c_Descricao e campo de
    * EXIBICAO: o legado declara "PROCEDURE When / Return(.F.)" em
    * Get_Descricao, ou seja o campo nunca recebe foco - equivalente a
    * .ReadOnly = .T. aqui (so e preenchido pelos lookups de Barra/Produto,
    * que entram na Fase 6 junto com Get_Peso/Get_Linha e a imagem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Say5 / Get_Barra ("Barra :")
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 96
            .Left      = 54
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Barra :"
        ENDWITH

        THIS.AddObject("txt_4c_Barra", "TextBox")
        WITH THIS.txt_4c_Barra
            .Top           = 92
            .Left          = 94
            .Width         = 108
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 3
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "99999999999999"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .TabIndex      = 1
        ENDWITH

        *-- lbl_produto / Get_Produto ("Produto :")
        THIS.AddObject("lbl_4c_Lbl_produto", "Label")
        WITH THIS.lbl_4c_Lbl_produto
            .Top       = 121
            .Left      = 42
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
            .Top           = 117
            .Left          = 94
            .Width         = 108
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K!"
            .MaxLength     = 14
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .TabIndex      = 2
        ENDWITH

        *-- lbl_descricao / Get_Descricao ("Descricao :") - campo de EXIBICAO
        THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
        WITH THIS.lbl_4c_Lbl_descricao
            .Top       = 146
            .Left      = 34
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c_Descricao", "TextBox")
        WITH THIS.txt_4c_Descricao
            .Top           = 142
            .Left          = 94
            .Width         = 290
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K!"
            .MaxLength     = 40
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .TabIndex      = 3
            .ReadOnly      = .T.
        ENDWITH

        *-- lbl_peso_medio / Get_Peso ("Peso :") - campo de EXIBICAO (When /
        *-- Return(.F.) no legado - nunca recebe foco, so e preenchido pelos
        *-- lookups de Barra/Produto)
        THIS.AddObject("lbl_4c_Lbl_peso_medio", "Label")
        WITH THIS.lbl_4c_Lbl_peso_medio
            .Top       = 171
            .Left      = 57
            .Width     = 32
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Peso :"
        ENDWITH

        THIS.AddObject("txt_4c_Peso", "TextBox")
        WITH THIS.txt_4c_Peso
            .Top           = 167
            .Left          = 94
            .Width         = 52
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 3
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K!"
            .MaxLength     = 10
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .TabIndex      = 4
            .ReadOnly      = .T.
        ENDWITH

        *-- Say1 / Get_Linha ("Linha :") - campo de EXIBICAO (When /
        *-- Return(.F.) no legado)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 196
            .Left      = 55
            .Width     = 34
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Linha :"
        ENDWITH

        THIS.AddObject("txt_4c_Linha", "TextBox")
        WITH THIS.txt_4c_Linha
            .Top           = 192
            .Left          = 94
            .Width         = 290
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K!"
            .MaxLength     = 40
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .TabIndex      = 5
            .ReadOnly      = .T.
        ENDWITH

        *-- BINDEVENT dos campos de entrada (Barra/Produto). txt_4c_Barra usa
        *-- GotFocus (equivalente ao When) e LostFocus (equivalente a Valid+
        *-- LostFocus combinados); txt_4c_Produto usa so LostFocus (o picker
        *-- fwBuscaExt do legado roda no Valid, e o LostFocus so navega para
        *-- a grade - aqui os dois ficam no mesmo handler, regra CLAUDE.md
        *-- "BINDEVENT Valid nao funciona em TextBox").
        BINDEVENT(THIS.txt_4c_Barra, "GotFocus", THIS, "ValidarAcessoBarra")
        BINDEVENT(THIS.txt_4c_Barra, "LostFocus", THIS, "ValidarBarra")
        BINDEVENT(THIS.txt_4c_Produto, "LostFocus", THIS, "ValidarProduto")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarImagem - ShpFigura (moldura decorativa, sempre visivel) e
    * ImgJpg (foto do produto, oculta por padrao - so aparece quando a foto
    * decodificada em AtualizarImagem() existe). Geometria TRANSCRITA do
    * dump: SIGOPCIM.ShpFigura/ImgJpg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarImagem()
        THIS.AddObject("shp_4c_ShpFigura", "Shape")
        WITH THIS.shp_4c_ShpFigura
            .Top           = 86
            .Left          = 402
            .Width         = 208
            .Height        = 128
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("img_4c_ImgJpg", "Image")
        WITH THIS.img_4c_ImgJpg
            .Top     = 90
            .Left    = 405
            .Width   = 201
            .Height  = 121
            .Stretch = 1
            .Picture = ""
            .Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararLeitoraParaFoco - equivalente ao PROCEDURE When de Get_Barra:
    * ao receber o foco, reposiciona cursor_4c_InvH no fim (equivalente a
    * "Select CrInvH / Go Bottom") e trata a leitora serial - se configurada
    * (THIS.this_oParentForm.TipoLeitora = "S"), garante a porta aberta; caso
    * contrario, "Set Confirm On" (comportamento padrao do legado quando nao
    * ha leitora serial). As properties TipoLeitora/LeituraSerial/ReadComm
    * pertencem ao form PAI (balanco/contagem de estoque) - guardas com
    * PEMSTATUS porque esse form pai pode nao existir fora do fluxo real
    * (modo teste/validacao de UI).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararLeitoraParaFoco()
        IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "TipoLeitora", 5) ;
                AND THIS.this_oParentForm.TipoLeitora = "S"
            IF PEMSTATUS(THIS.this_oParentForm, "LeituraSerial", 5) AND EMPTY(THIS.this_oParentForm.LeituraSerial)
                THIS.AbrirPortaSerialSeNecessario()
            ENDIF
        ELSE
            SET CONFIRM ON
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirPortaSerialSeNecessario - equivalente ao bloco comum de abertura
    * da porta serial (ReadComm.Ole_Comm.PortOpen) presente em When/Valid/
    * LostFocus de Get_Barra no legado. O controle OLE do leitor nao existe
    * fora do fluxo real de balanco - por isso a guarda com PEMSTATUS/VARTYPE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirPortaSerialSeNecessario()
        IF PEMSTATUS(THIS.this_oParentForm, "ReadComm", 5) AND VARTYPE(THIS.this_oParentForm.ReadComm) = "O"
            IF !THIS.this_oParentForm.ReadComm.Ole_Comm.PortOpen AND !THIS.this_oParentForm.ReadComm.PortaError
                THIS.this_oParentForm.ReadComm.Ole_Comm.PortOpen = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsumirLeituraSerial - equivalente ao bloco comum de Valid/LostFocus
    * de Get_Barra: se a leitora e serial e ja chegou dado no buffer do form
    * pai (LeituraSerial), consome para o controle recebido; senao, garante
    * a porta aberta para a proxima leitura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConsumirLeituraSerial(par_oTxt)
        IF VARTYPE(THIS.this_oParentForm) != "O" OR !PEMSTATUS(THIS.this_oParentForm, "TipoLeitora", 5)
            RETURN
        ENDIF
        IF THIS.this_oParentForm.TipoLeitora != "S"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.this_oParentForm, "LeituraSerial", 5)
            RETURN
        ENDIF

        IF EMPTY(THIS.this_oParentForm.LeituraSerial)
            THIS.AbrirPortaSerialSeNecessario()
        ELSE
            IF VARTYPE(par_oTxt) = "O"
                par_oTxt.Value = THIS.this_oParentForm.LeituraSerial
                par_oTxt.Refresh()
            ENDIF
            THIS.this_oParentForm.LeituraSerial = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAcessoBarra - BINDEVENT "GotFocus" de txt_4c_Barra (equivalente
    * ao PROCEDURE When legado de Get_Barra). GotFocus nao passa parametro.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAcessoBarra()
        IF USED("cursor_4c_InvH")
            SELECT cursor_4c_InvH
            GO BOTTOM
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.PrepararLeitoraParaFoco()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarra - BINDEVENT "LostFocus" de txt_4c_Barra: combina o
    * PROCEDURE Valid (consulta SigOpEtq/SigCdPro/SigCdLin, atualiza
    * cursor_4c_InvH, decodifica a foto, limpa o campo para a proxima
    * leitura) com o PROCEDURE LostFocus separado do legado (devolve o foco
    * a grade). LASTKEY() = 27 reproduz o "If LastKey() # 27" do legado -
    * ESC cancela a leitura sem limpar o campo nem avancar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarBarra()
        LOCAL loc_nBarra, loc_nPeso, loc_oErro, loc_lEsc, loc_lProsseguir

        loc_lEsc        = (LASTKEY() = 27)
        loc_lProsseguir = .T.

        THIS.ConsumirLeituraSerial(THIS.txt_4c_Barra)

        IF !EMPTY(THIS.txt_4c_Barra.Value)
            THIS.AjustarBotoesPorModo()

            THIS.FormParaBO()
            loc_nBarra = THIS.this_oBusinessObject.this_nBarra

            TRY
                THIS.this_oBusinessObject.ConsultarBarra(loc_nBarra)

                *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1 / MessageBox(
                *-- 'Favor reinicializar o processo !!!') / Return(.F.)" do
                *-- legado. Sem RETURN aqui: regra CLAUDE.md #1 proibe RETURN
                *-- dentro de TRY/CATCH - o early-exit vira flag.
                IF THIS.this_oBusinessObject.this_lFalhaConexao
                    MostrarErro("Favor reinicializar o processo !!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpBar)")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir AND THIS.this_oBusinessObject.this_lBarraLocalizada
                    *-- O peso exibido e o da ETIQUETA (SigOpEtq.Pesos), e a
                    *-- consulta do produto logo abaixo ZERA this_nPeso (o
                    *-- legado faz igual: no Valid de Get_Produto o peso vai a
                    *-- 0). Guardar antes e repor depois mantem o
                    *-- "Get_Peso.Value = TmpBar.Pesos" do legado com UM unico
                    *-- BOParaForm servindo aos dois fluxos.
                    loc_nPeso = THIS.this_oBusinessObject.this_nPeso

                    *-- NESTE fluxo o legado consulta o produto com
                    *-- CursorQuery('SigCdPro','TmpPro',...) e CursorQuery(
                    *-- 'SigCdLin','TmpLinha',...) SEM NENHUM teste de
                    *-- resultado - o "Favor reinicializar o processo !!!
                    *-- (TmpPro)" so existe no Valid de Get_Produto, onde a
                    *-- consulta e um SqlExecute guardado por "< 1".
                    *-- Repetir a abortagem aqui seria INVENTAR regra: com a
                    *-- consulta do produto falhando, o legado segue adiante e
                    *-- ainda registra a barra lida na grade, e perder isso
                    *-- impediria a leitura de continuar.
                    THIS.this_oBusinessObject.ConsultarProduto( ;
                        THIS.this_oBusinessObject.this_cProduto)

                    THIS.this_oBusinessObject.this_nPeso = loc_nPeso
                    THIS.BOParaForm()
                ENDIF

                IF loc_lProsseguir
                    THIS.AtualizarCrInvHPorBarra(loc_nBarra)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarBarra")
            ENDTRY

            IF loc_lProsseguir AND !loc_lEsc AND !THIS.this_lExcluir
                THIS.txt_4c_Barra.Value = 0
                THIS.Refresh()
                THIS.ConsumirLeituraSerial(THIS.txt_4c_Barra)
            ENDIF
        ENDIF

        THIS.HabilitarCampos()

        *-- equivalente ao PROCEDURE LostFocus separado do legado
        THIS.ConsumirLeituraSerial(THIS.txt_4c_Barra)
        IF !EMPTY(THIS.txt_4c_Barra.Value)
            THIS.grd_4c_Dados.ActiveColumn = 1
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - o UNICO ajuste de habilitacao que o legado tem: o
    * "PROCEDURE When / Return(Empty(ThisForm.Get_Barra.Value))" de
    * Get_Produto - o campo Produto so e alcancavel quando Barra esta vazio
    * (sao as duas entradas ALTERNATIVAS de consulta desta tela).
    *
    * Nao recebe parametro de modo porque o legado nao tem modo: nao ha
    * Page2 de Dados nem ciclo de edicao - os outros campos (Descricao/Peso/
    * Linha) sao de EXIBICAO em TODO momento ("When / Return(.F.)" no SCX,
    * ja transcrito como .ReadOnly = .T. na Fase 6).
    *
    * PUBLIC (sem PROTECTED): o harness chama metodo de form de FORA da
    * classe, e PEMSTATUS(oForm, "<metodo>", 5) devolve .T. mesmo para
    * PROTECTED - o teste entra no branch e a chamada estoura em runtime
    * (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        THIS.txt_4c_Produto.Enabled = EMPTY(THIS.txt_4c_Barra.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - as MESMAS tres linhas que o legado repete em TRES
    * lugares (Init, Valid de Get_Barra e Valid de Get_Produto):
    *   ThisForm.ExcluiItem.Visible = ThisForm.Excluir
    *   ThisForm.Shape2.Visible     = ThisForm.Excluir
    *   ThisForm.Shape3.Visible     = !ThisForm.Excluir
    * "Modo" aqui e o par Consulta Imagem / Exclusao de Barras recebido do
    * form chamador (this_lExcluir), NAO o modo de edicao de um cadastro -
    * esta tela nao tem nenhum.
    *
    * Os tres nomes estao na lista de excecao do TornarControlesVisiveis: a
    * visibilidade deles e decidida AQUI e no CmdExcluiitemClick (que esconde
    * o botao quando a grade esvazia), nunca pela varredura que forca
    * Visible = .T. em tudo.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.cmd_4c_Excluiitem.Visible = THIS.this_lExcluir
        THIS.shp_4c_Shape2.Visible     = THIS.this_lExcluir
        THIS.shp_4c_Shape3.Visible     = !THIS.this_lExcluir
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProduto - BINDEVENT "LostFocus" de txt_4c_Produto. Wrapper FINO
    * que liga/desliga a guarda de reentrancia (regra CLAUDE.md #47: o corpo
    * tem RETURN antecipado, entao o set/clear mora no wrapper e nao no corpo,
    * senao a flag trava ligada e MATA o lookup pelo resto da vida do form).
    * O trabalho esta em ValidarProdutoExec.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarProduto()
        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF

        THIS.this_lEmLookupProduto = .T.
        THIS.ValidarProdutoExec()
        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProdutoExec - corpo do Valid de Get_Produto: chama o funil do
    * picker (AbrirBuscaProduto, equivalente ao CreateObject('fwBuscaExt',...)
    * legado), consulta SigCdPro/SigCdLin, atualiza cursor_4c_InvH a partir de
    * Historico/SigIvTrH e decodifica a foto; no fim reproduz o PROCEDURE
    * LostFocus separado do legado, que SEMPRE devolve o foco a grade mesmo
    * sem produto valido ("ThisForm.Grade.Column1.SetFocus", sem guarda).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarProdutoExec()
        LOCAL loc_oErro, loc_lProsseguir

        loc_lProsseguir = .T.

        IF !EMPTY(THIS.txt_4c_Produto.Value)
            THIS.AbrirBuscaProduto()

            IF !EMPTY(THIS.txt_4c_Produto.Value)
                THIS.AjustarBotoesPorModo()

                THIS.FormParaBO()

                TRY
                    THIS.this_oBusinessObject.ConsultarProduto( ;
                        THIS.this_oBusinessObject.this_cProduto)

                    *-- "If ...SqlExecute(lStrQuery,'TmpPro') < 1 / MessageBox(
                    *-- 'Favor reinicializar o processo !!!') / Return(.F.)" do
                    *-- legado (flag em vez de RETURN - regra CLAUDE.md #1).
                    IF THIS.this_oBusinessObject.this_lFalhaConexao
                        MostrarErro("Favor reinicializar o processo !!!", ;
                            "Falha na Conex" + CHR(227) + "o (TmpPro)")
                        loc_lProsseguir = .F.
                    ENDIF

                    IF loc_lProsseguir AND THIS.this_oBusinessObject.this_lProdutoLocalizado
                        *-- ConsultarProduto deixa this_nPeso = 0, que e
                        *-- exatamente o "ThisForm.Get_Peso.Value = 0" do
                        *-- legado neste fluxo: o peso pertence a ETIQUETA, nao
                        *-- ao produto, e aqui nao houve leitura de barra.
                        THIS.BOParaForm()
                    ENDIF

                    IF loc_lProsseguir
                        THIS.AtualizarCrInvHPorProduto(ALLTRIM(THIS.txt_4c_Produto.Value))
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message + CHR(13) + ;
                            "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarProdutoExec")
                ENDTRY
            ENDIF
        ENDIF

        THIS.HabilitarCampos()

        *-- equivalente ao PROCEDURE LostFocus separado do legado (sem guarda)
        THIS.grd_4c_Dados.ActiveColumn = 1
        THIS.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProduto - FUNIL do picker de produto, equivalente ao
    * "CreateObject('fwBuscaExt', <conn>, 'SigCdPro', 'CrProds', 'CPros',
    * This.Value, 'Produtos', 1000)" + mAddColuna('CPros')/mAddColuna('DPros')
    * + Show() do Valid de Get_Produto, e ao bloco
    * "If LastKey() <> 27 And Used('CrProds') / This.Value = CrProds.CPros /
    * Get_Descricao.Value = CrProds.DPros / Else / ambos = '' / EndIf".
    *
    * Contrato do FormBuscaAuxiliar (regra CLAUDE.md #36/#37): 1o argumento e
    * o HANDLE da conexao; o Init ja tenta o match EXATO, entao Show() so e
    * chamado quando this_lAchouRegistro esta .F., e a atribuicao do valor so
    * acontece sob a guarda this_lSelecionou.
    *
    * A guarda de reentrancia aqui e SAVE/RESTORE (nao set/clear): este metodo
    * e chamado de DENTRO de ValidarProdutoExec, que ja ligou a flag - um
    * clear simples a liberaria cedo demais e o LostFocus que o picker modal
    * redispara abriria um segundo dialogo (regra CLAUDE.md #47).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oBusca, loc_oErro, loc_lEmLookupAnt

        loc_lEmLookupAnt           = THIS.this_lEmLookupProduto
        THIS.this_lEmLookupProduto = .T.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "CPros", ;
                ALLTRIM(THIS.txt_4c_Produto.Value), "Produtos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    SELECT cursor_4c_BuscaProduto
                    THIS.txt_4c_Produto.Value   = ALLTRIM(cursor_4c_BuscaProduto.CPros)
                    THIS.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_BuscaProduto.DPros)
                ELSE
                    THIS.txt_4c_Produto.Value   = ""
                    THIS.txt_4c_Descricao.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaProduto")
                    USE IN cursor_4c_BuscaProduto
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em AbrirBuscaProduto")
        ENDTRY

        THIS.this_lEmLookupProduto = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarImagem - equivalente ao bloco "With ThisForm / .ImgJpg.Visible
    * = .F. / .ImgJpg.Picture = '' / Clear Resources / If !Empty(FigJpgs)...
    * EndWith" presente nos Valid de Get_Barra/Get_Produto: decodifica a foto
    * (sigopcimBO.DecodificarEGravarFoto) para um arquivo temporario, exibe e
    * remove o arquivo (a imagem fica em memoria apos .Picture ser atribuido).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarImagem(par_mFigJpgs)
        LOCAL loc_cArquivo

        loc_cArquivo = SYS(2023) + "\TempCon.jpg"

        THIS.img_4c_ImgJpg.Visible = .F.
        THIS.img_4c_ImgJpg.Picture = ""
        CLEAR RESOURCES

        IF THIS.this_oBusinessObject.DecodificarEGravarFoto(par_mFigJpgs, loc_cArquivo)
            THIS.img_4c_ImgJpg.Visible = .T.
            THIS.img_4c_ImgJpg.Picture = loc_cArquivo
        ENDIF

        IF FILE(loc_cArquivo)
            DELETE FILE (loc_cArquivo)
        ENDIF

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCrInvHPorBarra - equivalente ao bloco final do Valid de
    * Get_Barra: garante que a barra lida esteja em cursor_4c_InvH, vinda de
    * cursor_4c_Historico (leituras anteriores desta sessao) ou, na
    * ausencia, do inventario em SigIvTrH (primeira leitura desta barra no
    * balanco ativo - CrSigCdBal e cursor GLOBAL do processo de balanco,
    * mantido pelo form pai).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCrInvHPorBarra(par_nBarra)
        LOCAL loc_cEmpresa, loc_nCodBalanco, loc_nResultado

        THIS.DesvincularGrade()

        IF !SEEK(par_nBarra, "cursor_4c_InvH", "cbars")
            IF SEEK(par_nBarra, "cursor_4c_Historico", "cbars")
                SELECT cursor_4c_Historico
                SCATTER MEMVAR MEMO
                INSERT INTO cursor_4c_InvH FROM MEMVAR
            ELSE
                loc_cEmpresa    = ""
                loc_nCodBalanco = 0
                IF USED("crSigCdBal")
                    loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
                    loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)
                ENDIF

                loc_nResultado = THIS.this_oBusinessObject.ConsultarInventarioPorBarra( ;
                    loc_cEmpresa, loc_nCodBalanco, par_nBarra, "cursor_4c_InvHTmp")

                IF loc_nResultado < 1
                    MostrarErro("Favor reinicializar o processo !!!", ;
                        "Falha na Conex" + CHR(227) + "o (CrInvH)")
                    IF USED("cursor_4c_InvHTmp")
                        USE IN cursor_4c_InvHTmp
                    ENDIF
                    *-- a grade foi desvinculada no inicio deste metodo e o
                    *-- cursor nao mudou: religar antes de abortar, senao ela
                    *-- fica em branco pelo resto da vida do form (regra
                    *-- CLAUDE.md #21a)
                    THIS.CarregarLista()
                    RETURN
                ENDIF

                IF USED("cursor_4c_InvH")
                    USE IN cursor_4c_InvH
                ENDIF
                SELECT * FROM cursor_4c_InvHTmp INTO CURSOR cursor_4c_InvH READWRITE
                IF USED("cursor_4c_InvHTmp")
                    USE IN cursor_4c_InvHTmp
                ENDIF

                SELECT cursor_4c_InvH
                INDEX ON cbars TAG cbars
                INDEX ON cpros TAG cpros
                GO TOP
            ENDIF
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCrInvHPorProduto - equivalente ao bloco final do Valid de
    * Get_Produto: garante que TODAS as leituras deste produto estejam em
    * cursor_4c_InvH (Scan sobre Historico filtrado por CPros - um produto
    * pode ter varias barras lidas), ou, na ausencia, consulta SigIvTrH.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCrInvHPorProduto(par_cProduto)
        LOCAL loc_cEmpresa, loc_nCodBalanco, loc_nResultado, loc_cChave

        *-- SET EXACT ON (config.prg) faz o SEEK exigir a chave INTEIRA, e o
        *-- indice "cpros" eh char(14) (SigIvTrh.cpros) enquanto o chamador
        *-- passa o codigo TRIMADO - sem o PADR o SEEK falha SEMPRE e cada
        *-- LostFocus do campo Produto reinsere as mesmas leituras no cursor
        *-- da grade (linhas duplicadas). O WHERE do SELECT abaixo nao
        *-- precisa (SQL do VFP segue SET ANSI, que esta OFF).
        loc_cChave = PADR(ALLTRIM(par_cProduto), 14)

        THIS.DesvincularGrade()

        IF !SEEK(loc_cChave, "cursor_4c_InvH", "cpros")
            SELECT * FROM cursor_4c_Historico WHERE cpros = m.par_cProduto INTO CURSOR cursor_4c_TmpHistorico
            SELECT cursor_4c_TmpHistorico
            GO TOP

            IF !EOF()
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_InvH FROM MEMVAR
                    SELECT cursor_4c_TmpHistorico
                ENDSCAN
            ELSE
                loc_cEmpresa    = ""
                loc_nCodBalanco = 0
                IF USED("crSigCdBal")
                    loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
                    loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)
                ENDIF

                loc_nResultado = THIS.this_oBusinessObject.ConsultarInventarioPorProduto( ;
                    loc_cEmpresa, loc_nCodBalanco, par_cProduto, "cursor_4c_InvHTmp")

                IF loc_nResultado < 1
                    MostrarErro("Favor reinicializar o processo !!!", ;
                        "Falha na Conex" + CHR(227) + "o (CrInvH)")
                    IF USED("cursor_4c_InvHTmp")
                        USE IN cursor_4c_InvHTmp
                    ENDIF
                    IF USED("cursor_4c_TmpHistorico")
                        USE IN cursor_4c_TmpHistorico
                    ENDIF
                    *-- religa a grade antes de abortar (ver o gemeo em
                    *-- AtualizarCrInvHPorBarra)
                    THIS.CarregarLista()
                    RETURN
                ENDIF

                IF USED("cursor_4c_InvH")
                    USE IN cursor_4c_InvH
                ENDIF
                SELECT * FROM cursor_4c_InvHTmp INTO CURSOR cursor_4c_InvH READWRITE
                IF USED("cursor_4c_InvHTmp")
                    USE IN cursor_4c_InvHTmp
                ENDIF

                SELECT cursor_4c_InvH
                INDEX ON cbars TAG cbars
                INDEX ON cpros TAG cpros
                GO TOP
            ENDIF

            IF USED("cursor_4c_TmpHistorico")
                USE IN cursor_4c_TmpHistorico
            ENDIF
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCursorHistorico - "Historico" e cursor GLOBAL do processo de
    * contagem/balanco de estoque (SigIvTrh), aberto pelo form PAI
    * (THIS.this_oParentForm) ANTES de instanciar este dialogo - e o que o
    * legado faz: "Select * From Historico Where .F. Into Cursor CrInvH
    * ReadWrite" no Init clona a ESTRUTURA dele, nunca cria o cursor do zero.
    * Fallback (modo teste/validacao de UI, sem form pai real): cria vazio
    * com a estrutura de SigIvTrh e indexado, para o form instanciar sem
    * erro mesmo fora do fluxo real de contagem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCursorHistorico()
        IF !USED("cursor_4c_Historico")
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico ;
                (cbars N(14,0), cidchaves C(20), codcors C(4), codigos N(4,0), ;
                 codtams C(4), contas C(10), cpros C(14), datas T, datatrans T, ;
                 emps C(3), localis C(10), locals C(10), ntrans N(6,0), obs M, ;
                 ocors C(10), pesreals N(8,2), qtds N(11,3), tipos N(1,0), ;
                 usuars C(10), pesos N(12,3), coletas C(1))
            SET NULL OFF
            SELECT cursor_4c_Historico
            INDEX ON cbars TAG cbars
            INDEX ON cpros TAG cpros
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (Grade do legado), com 5 colunas e a
    * coluna Observacao usando EditBox (equivalente ao fwmemo1 do legado,
    * regra CLAUDE.md #18 - Column.AddObject exige CurrentControl). O cursor
    * cursor_4c_InvH (CrInvH) e clone VAZIO de cursor_4c_Historico - populado
    * linha a linha nos Valid de Get_Barra/Get_Produto (Fase 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        IF USED("cursor_4c_InvH")
            USE IN cursor_4c_InvH
        ENDIF
        SELECT * FROM cursor_4c_Historico WHERE .F. INTO CURSOR cursor_4c_InvH READWRITE
        SELECT cursor_4c_InvH
        INDEX ON cbars TAG cbars
        INDEX ON cpros TAG cpros
        GO TOP

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 219
            .Left              = 14
            .Width             = 632
            .Height            = 88
            .ColumnCount       = 5
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .RowHeight         = 17
            .ScrollBars        = 0
            .GridLineColor     = RGB(238, 238, 238)
        ENDWITH

        *-- O bind (RecordSource + ControlSource de cada Column) vem ANTES do
        *-- AddObject do EditBox. Sem RecordSource explicito o Grid resolve a
        *-- fonte pela AREA DE TRABALHO CORRENTE e auto-liga as 5 primeiras
        *-- colunas do cursor na ordem do CREATE CURSOR - Column4 cai em
        *-- "codigos N(4,0)". Acrescentar um EditBox (cujo .Value nasce
        *-- CARACTERE) a uma coluna ligada a campo NUMERICO estoura
        *-- "Error with EDT_4C_OBS - Value : Data type mismatch" dentro do
        *-- TRY de InicializarForm: CREATEOBJECT devolve .F. e a tela NAO ABRE.
        *-- Com o bind feito antes, Column4 ja esta em "cursor_4c_InvH.obs"
        *-- (campo Memo) e o EditBox e compativel.
        THIS.MontaGrade()

        WITH THIS.grd_4c_Dados.Column4
            .AddObject("edt_4c_Obs", "EditBox")
            *-- NUNCA definir .ControlSource no CONTROLE da coluna: quem
            *-- manda e o ControlSource da Column (ja em "cursor_4c_InvH.obs"
            *-- pelo MontaGrade acima). Duplicar aqui estoura "Parent object
            *-- will not allow this property setting" e a tela nao abre
            *-- (mesma regra do CheckBox em Column - erro 1767).
            WITH .edt_4c_Obs
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Left        = 7
                .Top         = 24
                .ReadOnly    = .T.
            ENDWITH
            *-- regra CLAUDE.md #18: sem CurrentControl a Column continua
            *-- desenhando o Text1 dela; sem Sparse = .F. o EditBox so
            *-- aparece na linha ativa.
            .CurrentControl = "edt_4c_Obs"
            .Sparse         = .F.
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade - equivalente a THISFORM.AcertaGrade() do legado: reconecta
    * grd_4c_Dados a cursor_4c_InvH. Chamado agora (bind inicial) e sera
    * chamado de novo na Fase 6 depois de inserir linha nova no cursor.
    * RecordSource reseta Width/Header1.Caption (CLAUDE.md "Grade perde
    * cabecalhos apos RecordSource") - por isso ControlSource/Width/Header
    * sao reaplicados NESTA ORDEM, sempre DEPOIS do RecordSource.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontaGrade()
        THIS.grd_4c_Dados.RecordSource = ""
        THIS.grd_4c_Dados.ColumnCount = 3
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_InvH"

        WITH THIS.grd_4c_Dados
            .Column1.ControlSource = "cursor_4c_InvH.cbars"
            .Column2.ControlSource = "cursor_4c_InvH.localis"
            .Column3.ControlSource = "cursor_4c_InvH.ocors"
            .Column4.ControlSource = "cursor_4c_InvH.obs"
            .Column5.ControlSource = "cursor_4c_InvH.pesreals"

            .Column1.ReadOnly  = .T.
            .Column1.Movable   = .F.
            .Column1.Resizable = .T.
            .Column2.ReadOnly  = .T.
            .Column3.ReadOnly  = .T.
            .Column4.ReadOnly  = .T.
            .Column4.Sparse    = .F.
            .Column5.ReadOnly  = .T.
            .Column5.InputMask = "9999.99"

            *-- RecordSource reseta CurrentControl (volta a "Text1"), entao o
            *-- EditBox da coluna Observacao tem de ser REARMADO a cada
            *-- rebind. PEMSTATUS porque a 1a chamada vem de ConfigurarGrid,
            *-- ANTES de o EditBox existir (e ela que faz o bind inicial).
            IF PEMSTATUS(.Column4, "edt_4c_Obs", 5)
                .Column4.CurrentControl = "edt_4c_Obs"
                .Column4.Sparse         = .F.
            ENDIF

            .Column1.Width = 108
            .Column2.Width = 75
            .Column3.Width = 75
            .Column4.Width = 285
            .Column5.Width = 70

            .Column1.Header1.Caption   = "Barras"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(36, 84, 155)
            .Column2.Header1.Caption   = "Local"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(36, 84, 155)
            .Column3.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(36, 84, 155)
            .Column4.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(36, 84, 155)
            .Column5.Header1.Caption   = "Peso Real"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(36, 84, 155)

            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * DesvincularGrade - "ThisForm.Grade.RecordSource = ''" que o legado
    * executa ANTES do bloco que (re)constroi CrInvH, nos DOIS Valid. Nao e
    * cosmetico: no ramo de fallback o cursor da grade e FECHADO e RECRIADO, e
    * derrubar um alias que esta ligado a um Grid zera o ColumnCount dele - a
    * grade vira um retangulo branco sem cabecalho e sem coluna, sem erro, sem
    * log e sem excecao, e fica assim pelo resto da vida do form porque nada
    * rebinda depois. Quem religa e CarregarLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesvincularGrade()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.RecordSource = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL unico de carga/repintura da grade. Transcreve o
    * rodape IDENTICO dos dois Valid do legado:
    *   Select CrInvH
    *   Update CrInvH Set Obs = Nvl(Obs,'')
    *   ThisForm.AcertaGrade()
    *   Select CrInvH
    *   Go Top
    *
    * Popular o cursor NAO repinta a grade (regra CLAUDE.md #21a): sem o
    * GO TOP + Refresh no fim de TODO caminho que mexe no cursor, a grade fica
    * visualmente vazia com o cursor cheio - e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/permissao. Por isso aqui, e nao
    * copiado em cada chamador: os caminhos que mexem no cursor sao a leitura
    * de barra, a consulta por produto, a exclusao de item e a abertura.
    *
    * O UPDATE do Obs vem junto porque e' a MESMA linha do legado: a coluna
    * obs de SigIvTrh e "text NULL", e o EditBox da coluna Observacao da grade
    * nao aceita .NULL. - trocar por string vazia e o que o legado faz.
    *
    * Devolve .T./.F. (houve cursor para carregar) - o chamador nao e obrigado
    * a testar, mas o retorno existe para o teste automatizado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_InvH")
            SELECT cursor_4c_InvH
            UPDATE cursor_4c_InvH SET obs = NVL(obs, "")

            THIS.MontaGrade()

            SELECT cursor_4c_InvH
            GO TOP

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere os dois campos de ENTRADA da tela para as
    * properties do BO. Sao os dois unicos campos digitaveis do SCX: Get_Barra
    * (numerico, InputMask "99999999999999") e Get_Produto (char(14)); os
    * outros tres sao de EXIBICAO ("When / Return(.F.)" no legado).
    *
    * No legado esta transferencia aparece como o proprio "This.Value" dentro
    * de cada consulta do Valid ("Where CBars = ]+This.Value" e
    * "Where CPros = ']+This.Value+['"); aqui ela ganha ponto UNICO, para os
    * dois fluxos lerem a mesma normalizacao e para existir um lugar de
    * recarga. A property do codigo de barras e NUMERICA (this_nBarra - cbars
    * e numeric(14,0) no schema), por isso nada de STR/VAL no caminho.
    *
    * PROTECTED EXPLICITO, e nao por estilo: FormBase ja declara
    * "PROTECTED PROCEDURE FormParaBO" e em VFP9 a subclasse NAO ALARGA esse
    * escopo - escrever sem o modificador nao torna o metodo publico, so
    * esconde de quem le que ele continua protegido. Medido no VFP9 nesta
    * task: PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. (protegido) mesmo
    * com a subclasse declarando sem PROTECTED, e chamar de fora estoura
    * "Property FORMPARABO is not found". Uso so por THIS., de dentro da
    * classe; harness que precise exercitar isso tem de usar uma SUBCLASSE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            *-- VARTYPE porque o legado chega a atribuir "" ao campo Barra
            *-- (ver CmdExcluiitemClick): se algum caminho o tornar caractere,
            *-- a conversao evita gravar texto numa property numerica.
            loc_oBO.this_nBarra = IIF(VARTYPE(THIS.txt_4c_Barra.Value) = "N", ;
                THIS.txt_4c_Barra.Value, ;
                VAL(TRANSFORM(THIS.txt_4c_Barra.Value)))

            loc_oBO.this_cProduto = ALLTRIM(THIS.txt_4c_Produto.Value)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere o resultado da consulta (properties do BO) para
    * os campos de EXIBICAO e para a foto. Transcreve o bloco que os dois
    * Valid do legado repetem:
    *   ThisForm.Get_Produto.Value   = TmpPro.CPros
    *   ThisForm.Get_Descricao.Value = TmpPro.DPros
    *   ThisForm.Get_Peso.Value      = TmpBar.Pesos   (0 no fluxo do produto)
    *   ThisForm.Get_Linha.Value     = TmpLinha.Descs
    * seguido do bloco da imagem (ImgJpg), que esta em AtualizarImagem().
    *
    * O PESO e do chamador: ConsultarProduto zera this_nPeso (igual ao
    * "Get_Peso.Value = 0" do legado no fluxo por produto), e o fluxo por
    * barra repoe o peso da etiqueta ANTES de chamar este metodo.
    *
    * A DESCRICAO: no fluxo por produto o legado nao reatribui Get_Descricao
    * depois da consulta - o picker ja a tinha posto, a partir de CrProds.DPros.
    * Escrever aqui e equivalente porque this_cDescricao vem de a.DPros da
    * MESMA SigCdPro, para o MESMO CPros; e so roda com o produto localizado.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
    * HERANCA (FormBase declara "PROTECTED PROCEDURE BOParaForm"), nao deste
    * arquivo, e remover o modificador nao alarga nada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            THIS.txt_4c_Produto.Value   = ALLTRIM(loc_oBO.this_cProduto)
            THIS.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cDescricao)
            THIS.txt_4c_Peso.Value      = loc_oBO.this_nPeso
            THIS.txt_4c_Linha.Value     = ALLTRIM(loc_oBO.this_cLinha)

            THIS.AtualizarImagem(loc_oBO.this_mFigJpgs)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - "ThisForm.Get_Barra.SetFocus" que FECHA o Init legado. No
    * Init do migrado ele nao pega: o controle ainda nao esta na tela. Vem no
    * Activate (dispara toda vez que o dialogo ganha foco, o que e inofensivo
    * - SetFocus e idempotente), com TRY porque SetFocus em controle invisivel
    * ou desabilitado estoura e Activate nao tem chamador que trate o erro:
    * sem o TRY o usuario veria o "Program Error" CRU do VFP (regra #38).
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Barra", 5)
                IF THIS.txt_4c_Barra.Visible AND THIS.txt_4c_Barra.Enabled
                    THIS.txt_4c_Barra.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - equivalente ao PROCEDURE AfterRowColChange da
    * Grade legado: fora do modo Excluir, o foco volta para o campo Barra
    * apos navegar na grade. txt_4c_Barra e criado na Fase 5.
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF !THIS.this_lExcluir
            THIS.txt_4c_Barra.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cmd_4c_Excluiitem (so visivel em modo exclusao) e
    * cmd_4c_Saida, com a geometria/Picture EXATAS do dump. shp_4c_Shape2/
    * shp_4c_Shape3 sao os quadros decorativos que alternam com Excluiitem
    * (mesmo toggle de modo Excluir no Init legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 7
            .Left          = 625
            .Width         = 159
            .Height        = 79
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = THIS.this_lExcluir
        ENDWITH

        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top           = 7
            .Left          = 707
            .Width         = 77
            .Height        = 79
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = !THIS.this_lExcluir
        ENDWITH

        THIS.AddObject("cmd_4c_Excluiitem", "CommandButton")
        WITH THIS.cmd_4c_Excluiitem
            .Top        = 3
            .Left       = 649
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Caption    = "\<Excluir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = THIS.this_lExcluir
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Excluiitem, "Click", THIS, "CmdExcluiitemClick")

        THIS.AddObject("cmd_4c_Saida", "CommandButton")
        WITH THIS.cmd_4c_Saida
            .Top         = 3
            .Left        = 724
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = "Sa" + CHR(237) + "da"
            .ToolTipText = "[ESC]"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "CmdSaidaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluiitemClick - equivalente ao PROCEDURE Click do Excluiitem
    * legado: remove o item corrente (por produto, quando a leitura foi por
    * produto, ou por barra) de cursor_4c_Historico/cursor_4c_InvH. Usa
    * txt_4c_Barra/txt_4c_Produto, criados na Fase 5.
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluiitemClick()
        LOCAL loc_nRecno, loc_cProduto

        *-- A chave do indice "cpros" eh char(14) (SigIvTrh.cpros), e o valor
        *-- do TextBox vem TRIMADO do picker. config.prg liga SET EXACT ON
        *-- globalmente, e com EXACT ON o SEEK exige a chave INTEIRA - com o
        *-- valor trimado ele falha SEMPRE, o IF abaixo entra e o handler
        *-- INSERE uma copia duplicada no cursor GLOBAL Historico (que o form
        *-- pai continua usando depois deste dialogo fechar). PADR para a
        *-- largura da coluna reproduz o match que o legado tinha com
        *-- EXACT OFF. O WHERE do DELETE abaixo nao precisa (SQL do VFP segue
        *-- SET ANSI, que esta OFF), mas usa o mesmo valor por coerencia.
        loc_cProduto = PADR(ALLTRIM(THIS.txt_4c_Produto.Value), 14)

        SELECT cursor_4c_InvH

        DO CASE
            CASE EMPTY(THIS.txt_4c_Barra.Value) AND !EMPTY(THIS.txt_4c_Produto.Value)
                SELECT cursor_4c_Historico
                IF !SEEK(loc_cProduto, "cursor_4c_Historico", "cpros")
                    SELECT cursor_4c_InvH
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_Historico FROM MEMVAR
                ENDIF
                SELECT cursor_4c_Historico
                GO TOP
                DELETE FROM cursor_4c_Historico WHERE cpros = m.loc_cProduto
                SELECT cursor_4c_Historico
                GO TOP
                SELECT cursor_4c_InvH
                DELETE FROM cursor_4c_InvH

            CASE !EMPTY(THIS.txt_4c_Barra.Value)
                IF !SEEK(cursor_4c_InvH.cbars, "cursor_4c_Historico", "cbars")
                    SELECT cursor_4c_InvH
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_Historico FROM MEMVAR
                ENDIF
                SELECT cursor_4c_Historico
                loc_nRecno = RECNO("cursor_4c_Historico")
                GO TOP
                GO loc_nRecno
                DELETE IN cursor_4c_Historico
                SELECT cursor_4c_InvH
                DELETE IN cursor_4c_InvH

            OTHERWISE
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Refresh()
                THIS.Refresh()
                *-- txt_4c_Barra nasce NUMERICO (.Value = 0, transcrito do
                *-- dump: "Get_Barra / Value = 0 / InputMask =
                *-- 99999999999999"). O legado limpa com '' e por isso o
                *-- controle dele VIRA caractere no meio da sessao - aqui nao
                *-- da para copiar isso: cbars eh numeric(14,0) e o
                *-- AtualizarCrInvHPorBarra faz SEEK nesse indice, que estoura
                *-- "Operator/operand type mismatch" com chave caractere.
                *-- Zerar mantem o tipo e o mesmo EMPTY() do legado.
                THIS.txt_4c_Barra.Value = 0
                THIS.txt_4c_Barra.SetFocus()
                RETURN
        ENDCASE

        SELECT cursor_4c_InvH
        GO BOTTOM
        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.Refresh()
        THIS.Refresh()
        *-- mesma razao do bloco OTHERWISE: zerar, nunca "" (tipo NUMERICO)
        THIS.txt_4c_Barra.Value = 0
        *-- Barra zerado reabre o campo Produto (When do legado)
        THIS.HabilitarCampos()

        IF EOF("cursor_4c_InvH")
            *-- grade vazia: o legado esconde o botao de excluir e volta o
            *-- quadro de consulta, INDEPENDENTE do modo - por isso as tres
            *-- linhas literais aqui, e nao AjustarBotoesPorModo() (que
            *-- reporia Visible = this_lExcluir e traria o botao de volta
            *-- sobre uma grade sem nenhuma linha para excluir).
            THIS.cmd_4c_Excluiitem.Visible = .F.
            THIS.shp_4c_Shape2.Visible     = .F.
            THIS.shp_4c_Shape3.Visible     = .T.
            THIS.txt_4c_Barra.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSaidaClick - equivalente ao PROCEDURE Click do botao Sa?da legado.
    * NAO fecha cursor_4c_Historico - e global, continua aberto no form pai.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSaidaClick()
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
            SET ORDER TO
            GO BOTTOM
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPCIM.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visivel recursivamente os controles do
    * container recebido (AddObject cria com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_cNome

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                loc_cNome = UPPER(loc_oControl.Name)

                *-- Controles com visibilidade condicional ao modo Excluir -
                *-- quem decide e ConfigurarBotoes()/CmdExcluiitemClick(),
                *-- NUNCA forcar Visible=.T. aqui (regra dos containers/
                *-- controles flutuantes do form OPERACIONAL).
                IF INLIST(loc_cNome, "CMD_4C_EXCLUIITEM", "SHP_4C_SHAPE2", "SHP_4C_SHAPE3", "IMG_4C_IMGJPG")
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
    * Destroy - FormBase.Destroy ja libera this_oBusinessObject e restaura o
    * menu do sistema. cursor_4c_InvH e de uso exclusivo deste dialogo e e
    * fechado aqui; cursor_4c_Historico e GLOBAL (o form pai continua
    * usando-o depois que este form fecha - o proprio CmdSaidaClick legado
    * so reposiciona, nunca fecha) e por isso NAO e fechado aqui. Fechamento
    * dos cursores temporarios de lookup (TmpBar/TmpPro/TmpLinha) entra na
    * Fase 6, quando esses cursores passam a existir.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_InvH")
            USE IN cursor_4c_InvH
        ENDIF
        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        IF USED("cursor_4c_TmpHistorico")
            USE IN cursor_4c_TmpHistorico
        ENDIF
        IF USED("cursor_4c_InvHTmp")
            USE IN cursor_4c_InvHTmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcimBO.prg):
*==============================================================================
* sigopcimBO.prg - Business Object para Consulta/Exclusao de Imagem (Leitura de Barras)
* Tabela principal: Historico (cursor local de leitura de codigos de barras)
* Cursor de grade: CrInvH (Barras/Local/Ocorrencia/Observacao/Peso Real)
* Form original: SIGOPCIM.scx (Consulta Imagem / Exclusao de Barras)
*==============================================================================

DEFINE CLASS sigopcimBO AS BusinessBase

    *-- Codigo de barras lido/digitado (Get_Barra). NUMERICO: medido no
    *-- docs/schema.sql, SigOpEtq.cbars e SigIvTrh.cbars sao numeric(14,0), e o
    *-- proprio SCX declara "Get_Barra / Value = 0 / InputMask =
    *-- 99999999999999" - ou seja a tela tambem digita numero. Guardar como
    *-- char obrigaria a converter nos dois sentidos (STR na ida, VAL na volta)
    *-- numa chave de 14 digitos, e qualquer SEEK no indice "cbars" (que e
    *-- numerico) com chave caractere estoura "Operator/operand type
    *-- mismatch" - a MESMA armadilha que a Fase 7 corrigiu no TextBox.
    this_nBarra      = 0     && numeric(14,0)  SigOpEtq.cbars / SigIvTrh.cbars

    *-- Produto associado a barra (Get_Produto) - FK SigCdPro.CPros
    this_cProduto    = ""    && char(20)  Codigo do Produto (FK SigCdPro.CPros)

    *-- Descricao do produto (Get_Descricao) - somente exibicao, vem do lookup
    this_cDescricao  = ""    && char(60)  Descricao do Produto (FK SigCdPro.DPros)

    *-- Peso medio/real associado a barra (Get_Peso)
    this_nPeso       = 0     && numeric(10,3)  Peso do item

    *-- Linha de producao associada a barra (Get_Linha)
    this_cLinha      = ""    && char(40)  Linha / observacao associada ao item

    *-- Colunas do registro de Historico/CrInvH (cursor_4c_Dados da grade)
    this_cLocal        = ""    && char(10)  Historico.Localis - local da leitura
    this_cOcorrencia   = ""    && char(10)  Historico.Ocors   - ocorrencia do item
    this_mObs          = ""    && memo      Historico.Obs     - observacao do item
    this_nPesoReal     = 0     && numeric(8,2) Historico.PesReals - peso real lido

    *-- Foto do produto (SigCdPro.FigJpgs), usada so para gerar o arquivo .jpg
    *-- temporario exibido em ImgJpg - nunca persistida pelo BO.
    this_mFigJpgs      = ""

    *-- Flags de resultado das consultas (Valid de Get_Barra/Get_Produto)
    this_lBarraLocalizada    = .F.   && .T. quando SigOpEtq achou o CBars
    this_lProdutoLocalizado  = .F.   && .T. quando SigCdPro achou o CPros

    *-- .T. quando o SQLEXEC da consulta falhou (equivalente ao
    *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1" do legado, que exibe
    *-- "Favor reinicializar o processo !!!" e ABORTA o Valid com Return(.F.)).
    *-- Nao da para sinalizar isso pelo retorno da funcao: ela ja devolve .T.
    *-- tambem quando a consulta roda e nao acha nada, que NAO e erro (regra
    *-- CLAUDE.md #50 - universo vazio nao e erro). Zero linha e falha de
    *-- conexao sao resultados DIFERENTES e o legado os trata diferente.
    this_lFalhaConexao       = .F.   && .T. quando SQLEXEC devolveu < 1

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "Historico"
        THIS.this_cCampoChave = "CBars"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - CBars (Historico/CrInvH.CBars) e a chave logica do
    * item de leitura; na ausencia de barra (modo so-por-produto), a chave
    * passa a ser o codigo do produto (CPros), igual ao Case do Excluiitem.Click
    * legado (Empty(Get_Barra.Value) And !Empty(Get_Produto.Value)).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        *-- A chave da auditoria e CARACTERE (RegistrarAuditoria a concatena na
        *-- string do INSERT), por isso o STR aqui - a property segue numerica.
        IF THIS.this_nBarra != 0
            RETURN ALLTRIM(STR(THIS.this_nBarra, 14))
        ENDIF
        RETURN ALLTRIM(THIS.this_cProduto)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia uma linha de Historico/CrInvH (par_cAliasCursor)
    * para as properties do BO. E o shape da grade (Barras/Local/Ocorrencia/
    * Observacao/Peso Real), nao o shape dos lookups de Barra/Produto - esses
    * tem metodo proprio (ConsultarBarra/ConsultarProduto) porque vem de
    * tabelas diferentes (SigOpEtq/SigCdPro) com colunas diferentes.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * CBars e numeric(14,0) no schema e a property e numerica (ver
    * this_nBarra) - nada de converter para char no caminho.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nBarra      = TratarNulo(cbars, 0)
                THIS.this_cProduto    = TratarNulo(cpros, "")
                THIS.this_cLocal      = TratarNulo(localis, "")
                THIS.this_cOcorrencia = TratarNulo(ocors, "")
                THIS.this_mObs        = TratarNulo(obs, "")
                THIS.this_nPesoReal   = TratarNulo(pesreals, 0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarBarra - replica o 1o SQLEXEC do Valid de Get_Barra: busca a
    * etiqueta em SigOpEtq pelo codigo de barras. Achando, preenche o Produto
    * e o Peso que a tela espelha; sem achar, so desliga o flag de localizacao
    * (o legado, nesse caso, simplesmente nao atualiza os campos - regra
    * CLAUDE.md #50, universo vazio nao e erro).
    *==========================================================================
    FUNCTION ConsultarBarra(par_nCbars)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lBarraLocalizada = .F.
        THIS.this_lFalhaConexao    = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT CBars, CPros, Pesos FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_CimEtq")

                *-- mesmo criterio do legado ("SqlExecute(...) < 1"). A
                *-- atribuicao fica DENTRO da guarda de conexao: sem handle o
                *-- loc_nResultado nunca e atribuido (nasce .F. logico) e
                *-- compara-lo com 1 estouraria "Operator/operand type
                *-- mismatch" justamente em modo teste/validacao de UI.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimEtq") AND RECCOUNT("cursor_4c_CimEtq") > 0
                    SELECT cursor_4c_CimEtq
                    GO TOP

                    THIS.this_lBarraLocalizada = .T.
                    THIS.this_nBarra   = TratarNulo(CBars, 0)
                    THIS.this_cProduto = TratarNulo(CPros, "")
                    THIS.this_nPeso    = TratarNulo(Pesos, 0)
                ENDIF

                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarProduto - replica o SQLEXEC do Valid de Get_Produto: busca o
    * produto em SigCdPro, com a descricao da linha via Left Join SigCdLin
    * (mesma consulta do legado: a.CPros,a.Linhas,a.FigJpgs,b.Descs). Achando,
    * preenche Linha (Descs) e a foto (FigJpgs, para DecodificarEGravarFoto);
    * Peso fica zerado, igual ao legado (ThisForm.Get_Peso.Value = 0).
    *
    * this_cDescricao (a.DPros) tambem e preenchido aqui - e o mesmo SigCdPro
    * que o fluxo de Get_Barra.Valid consulta (lcConsulta = CursorQuery(
    * 'SigCdPro','TmpPro','CPros',...,'CPros,DPros,Linhas,FigJpgs')), so que
    * o legado faz isso em DUAS CursorQuery separadas (SigCdPro + SigCdLin);
    * aqui as duas foram unificadas num LEFT JOIN so. O Form (fluxo de
    * Get_Produto) e quem decide SE usa this_cDescricao - o legado nunca
    * atualiza Get_Descricao.Value no Valid de Get_Produto, so no de
    * Get_Barra.
    *==========================================================================
    FUNCTION ConsultarProduto(par_cCodProduto)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lProdutoLocalizado = .F.
        THIS.this_lFalhaConexao      = .F.

        *-- Limpa o que esta consulta PRODUZ, antes de consultar. Nao e zelo:
        *-- no fluxo da BARRA o legado le TmpPro/TmpLinha SEM guarda de EOF
        *-- ("Get_Produto.Value = TmpPro.CPros / Get_Descricao.Value =
        *-- TmpPro.DPros / ..."), ou seja com o produto AUSENTE ele atribui o
        *-- valor vazio do cursor e a tela LIMPA. Sem este reset as properties
        *-- guardariam o resultado da leitura ANTERIOR, e o usuario veria a
        *-- descricao e a FOTO do produto antigo associadas a barra nova -
        *-- divergencia silenciosa, sem erro nenhum.
        THIS.this_cProduto   = ""
        THIS.this_cDescricao = ""
        THIS.this_nPeso      = 0
        THIS.this_cLinha     = ""
        THIS.this_mFigJpgs   = ""

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.CPros, a.DPros, a.Linhas, a.FigJpgs, b.Descs " + ;
                    "FROM SigCdPro a LEFT JOIN SigCdLin b ON b.Linhas = a.Linhas " + ;
                    "WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    "cursor_4c_CimPro")

                *-- mesmo criterio do legado ("SqlExecute(...,'TmpPro') < 1");
                *-- DENTRO da guarda de conexao pelo mesmo motivo de
                *-- ConsultarBarra.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimPro") AND RECCOUNT("cursor_4c_CimPro") > 0
                    SELECT cursor_4c_CimPro
                    GO TOP

                    THIS.this_lProdutoLocalizado = .T.
                    THIS.this_cProduto   = TratarNulo(CPros, "")
                    THIS.this_cDescricao = TratarNulo(DPros, "")
                    THIS.this_nPeso      = 0
                    THIS.this_cLinha     = TratarNulo(Descs, "")
                    THIS.this_mFigJpgs   = TratarNulo(FigJpgs, "")
                ENDIF

                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorBarra - replica o fallback de SigIvTrH do Valid de
    * Get_Barra, usado quando o item nao esta em CrInvH nem em Historico:
    * Select * From SigIvTrH Where Emps = <emp> And Codigos = <balanco> And
    * CBars = <barra>. par_cCursorDestino recebe o resultado (0 ou 1 linha);
    * quem monta Emps/Codigos e o Form, a partir do cursor global do balanco
    * ativo (CrSigCdBal no legado) - este BO nao conhece esse cursor.
    *==========================================================================
    FUNCTION ConsultarInventarioPorBarra(par_cEmpresa, par_nCodigoBalanco, par_nCbars, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorProduto - mesmo fallback do ConsultarInventarioPor
    * Barra, mas pelo CPros (Valid de Get_Produto quando !Seek(This.Value,
    * 'CrInvH','CPros')).
    *==========================================================================
    FUNCTION ConsultarInventarioPorProduto(par_cEmpresa, par_nCodigoBalanco, par_cCodProduto, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * DecodificarEGravarFoto - replica a decodificacao da foto do produto (bloco
    * dentro do With ThisForm do Valid de Get_Barra/Get_Produto): remove os tres
    * prefixos "data:image/..." e decodifica o Base64 restante UMA UNICA VEZ
    * (Strconv(...,14) - decodificar duas vezes corrompe o JPEG, o binario
    * resultante nao e base64). Grava o JPEG binario direto em par_cCaminho
    * Destino; quem exibe (Image.Picture) e apaga o arquivo depois e o Form.
    *==========================================================================
    FUNCTION DecodificarEGravarFoto(par_mFigJpgs, par_cCaminhoDestino)
        LOCAL loc_cFoto, loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_mFigJpgs) AND !ISNULL(par_mFigJpgs)
            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(par_mFigJpgs, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            IF STRTOFILE(loc_cFoto, par_cCaminhoDestino) > 0
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito. O
    * SIGOPCIM legado nunca grava em tabela SQL Server nenhuma: as unicas
    * escritas do form (Excluiitem.Click) sao Insert/Delete em cursores VFP
    * locais (Historico/CrInvH), que o Form ja recebe abertos do ParentForm -
    * nao ha chave SQL para gravar nem auditoria de banco para registrar.
    * O comportamento padrao herdado de BusinessBase (recusar a operacao com
    * mensagem) ja e o correto para esta entidade.
    *==========================================================================

ENDDEFINE

