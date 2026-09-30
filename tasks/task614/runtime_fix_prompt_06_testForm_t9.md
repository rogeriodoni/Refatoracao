# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 9/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-29 06:01:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-29 06:01:01] [INFO] Config FPW: (nao fornecido)
[2026-09-29 06:01:01] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 06:01:01] [INFO] Timeout: 300 segundos
[2026-09-29 06:01:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c4mew3iq.prg
[2026-09-29 06:01:01] [INFO] Conteudo do wrapper:
[2026-09-29 06:01:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGl2', 'C:\4c\tasks\task614\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGl2', 'C:\4c\tasks\task614\logs\06_testForm.log'
QUIT

[2026-09-29 06:01:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c4mew3iq.prg
[2026-09-29 06:01:01] [INFO] VFP output esperado em: C:\4c\tasks\task614\vfp_output.txt
[2026-09-29 06:01:01] [INFO] Executando Visual FoxPro 9...
[2026-09-29 06:01:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c4mew3iq.prg
[2026-09-29 06:01:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c4mew3iq.prg
[2026-09-29 06:01:01] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGl2
Inicio: 29/09/2026 06:01:01

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 29/09/2026 06:04:40
Duracao: 219 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-29 06:04:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-29 06:04:40] [INFO] VFP9 finalizado em 219.1176628 segundos
[2026-09-29 06:04:40] [INFO] Exit Code: 
[2026-09-29 06:04:40] [INFO] 
[2026-09-29 06:04:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-29 06:04:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c4mew3iq.prg
[2026-09-29 06:04:40] [INFO] 
[2026-09-29 06:04:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-29 06:04:40] [INFO] * Auto-generated wrapper for parameters
[2026-09-29 06:04:40] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 06:04:40] [INFO] * Parameters: 'FormSigPrGl2', 'C:\4c\tasks\task614\logs\06_testForm.log'
[2026-09-29 06:04:40] [INFO] 
[2026-09-29 06:04:41] [INFO] * Anti-dialog protections for unattended execution
[2026-09-29 06:04:41] [INFO] SET SAFETY OFF
[2026-09-29 06:04:41] [INFO] SET RESOURCE OFF
[2026-09-29 06:04:41] [INFO] SET TALK OFF
[2026-09-29 06:04:41] [INFO] SET NOTIFY OFF
[2026-09-29 06:04:41] [INFO] SYS(2335, 0)
[2026-09-29 06:04:41] [INFO] 
[2026-09-29 06:04:41] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGl2', 'C:\4c\tasks\task614\logs\06_testForm.log'
[2026-09-29 06:04:41] [INFO] QUIT
[2026-09-29 06:04:41] [INFO] 
[2026-09-29 06:04:41] [INFO] === Fim do Wrapper.prg ===
[2026-09-29 06:04:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg):
*==============================================================================
* FormSigPrGl2.prg - Operacoes Selecionadas (dialogo de processamento de OPs)
* Form operacional MODAL, aberto pelo formulario pai que lista as operacoes
* em aberto (equivalente ao "Do Form SigPrGl2 With ThisForm, ..." do legado).
* Original: SigPrGl2.SCX (form generico, layout FLAT - sem PageFrame
* Page1=Lista/Page2=Dados; duas grades empilhadas + campos de observacao)
*
*------------------------------------------------------------------------------
* CONSOLIDACAO (Fase 8) - superficie de metodos desta classe
*
* SIGPRGL2 e um DIALOGO MODAL de selecao e processamento, NAO um cadastro.
* O SCX legado herda de "form" generico (nao de frmcadastro) e tem
* exatamente 4 botoes: Processar, Encerrar, "apaga" (desmarca tudo) e
* SelTudo (marca tudo) - ver SECAO 1 do dump e analise.json
* (formType = OPERACIONAL). Por isso a superficie canonica de CRUD nao se
* aplica aqui, e cada ausencia abaixo corresponde a algo que o legado
* tambem nao possui:
*
*   BtnIncluir/BtnAlterar/BtnExcluir/BtnVisualizar/BtnBuscarClick
*       o dialogo nao cadastra nem pesquisa registro nenhum - a lista de
*       operacoes ja chega pronta do formulario pai, nos cursores
*       TmpCabec/TmpItens. Nao ha esses botoes no SCX.
*   BtnSalvarClick / FormParaBO
*       nao ha gravacao de entidade por tela. A unica escrita do legado
*       (INSERT em SigTempD + montagem de TmpFinal/TmpFinalg) vive em
*       SigPrGl2BO.ExecutarProcessamento, acionada por BtnProcessarClick.
*   BOParaForm
*       todos os controles de dados sao ligados por ControlSource DIRETO
*       aos cursores (o proprio Init legado faz isso), entao o VFP cobre
*       as duas direcoes do transporte. O unico estado que ainda precisa
*       de transporte explicito e o da LINHA corrente para as properties
*       do BO - feito em SincronizarBOComLinhaCorrente().
*   AlternarPagina / CarregarLista / AjustarBotoesPorModo / HabilitarCampos
*       nao ha PageFrame (layout FLAT) nem modos INCLUIR/ALTERAR/
*       VISUALIZAR. A carga inicial e CarregarDados() (trecho final do
*       Init legado) e a unica troca de estado de botao do legado esta na
*       cauda do Processar.Click (ThisForm.Enabled = .f. e, com reserva
*       automatica, Processar.Enabled = .f.), ja reproduzida em
*       BtnProcessarClick().
*   LimparCampos
*       os campos sao espelho dos cursores; o dialogo fecha ao terminar e
*       nao volta a um estado "em branco".
*
* BtnCancelarClick mantem o nome canonico do projeto e corresponde ao
* botao "Cancelar" do SCX, cuja Caption legada e "Encerrar".
*------------------------------------------------------------------------------
*==============================================================================
DEFINE CLASS FormSigPrGl2 AS FormBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/Datasessionid/Reserva/Emphpdr/Automatico/
    *-- Numerodaop/Pordestino do SIGPRGL2.SCX legado). Espelhadas tambem
    *-- aqui no Form (alem do BO) para os handlers de UI das proximas fases.
    this_oParentForm    = .NULL.  && Referencia ao form pai (lista de operacoes)
    this_nDataSessionId = 0       && DataSessionId do form pai (cursores TmpCabec/TmpItens vivem la)
    this_lReservaAuto   = .F.     && .T. quando a reserva de estoque e automatica
    this_nEmpHpdr        = 0      && Codigo do grupo/empresa padrao de geracao (Emphpdr)
    this_lAutomatico     = .F.    && .T. quando o processamento e automatico (sem interacao)
    this_cNumeroDaOp     = ""     && Numero da operacao de origem (Numerodaop)
    this_cPorDestino     = ""     && Destino da operacao (PorDestino)

    *-- Propriedades visuais (replicadas do SIGPRGL2.SCX - dialogo modal
    *-- sem barra de titulo, sem redimensionamento, sem botoes de sistema)
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2

    *--------------------------------------------------------------------------
    * Init - Recebe o contexto do formulario pai (mesma ordem de parametros
    * do PROCEDURE Init do legado, exceto pCnx: a conexao agora vem do
    * global gnConnHandle - regra "Global Variables" do projeto)
    *
    * par_oParentForm    : referencia ao form pai (equivalente a _ParentForm)
    * par_nDataSessionId : datasession do pai onde TmpCabec/TmpItens existem (_Data)
    * par_lReservaAuto   : .T. quando a reserva de estoque e automatica (_ReservaAuto)
    * par_nEmpHpdr       : grupo/empresa padrao de geracao (_nGerEmphPdr)
    * par_lAutomatico    : .T. quando o processamento e automatico (_Autom)
    * par_cNumeroDaOp    : numero da operacao de origem (_NumeroOp)
    * par_cPorDestino    : destino da operacao (ThisForm.ParentForm.PorDestino no legado)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSessionId, par_lReservaAuto, ;
            par_nEmpHpdr, par_lAutomatico, par_cNumeroDaOp, par_cPorDestino)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
                THIS.this_oParentForm         = par_oParentForm
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_nDataSessionId = IIF(VARTYPE(par_nDataSessionId) = "N", par_nDataSessionId, 0)
            THIS.this_lReservaAuto   = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
            THIS.this_nEmpHpdr       = IIF(VARTYPE(par_nEmpHpdr) = "N", par_nEmpHpdr, 0)
            THIS.this_lAutomatico    = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
            THIS.this_cNumeroDaOp    = IIF(VARTYPE(par_cNumeroDaOp) = "C", par_cNumeroDaOp, "")
            THIS.this_cPorDestino    = IIF(VARTYPE(par_cPorDestino) = "C", par_cPorDestino, "")

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrGl2BO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
            ELSE
                *-- Repassa o contexto recebido do pai para o BO (properties
                *-- ja declaradas em SigPrGl2BO, consumidas em ExecutarProcessamento)
                THIS.this_oBusinessObject.this_oParentForm    = THIS.this_oParentForm
                THIS.this_oBusinessObject.this_nDataSessionId = THIS.this_nDataSessionId
                THIS.this_oBusinessObject.this_lReservaAuto   = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_nEmpHpdr       = THIS.this_nEmpHpdr
                THIS.this_oBusinessObject.this_lAutomatico    = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_cNumeroDaOp    = THIS.this_cNumeroDaOp
                THIS.this_oBusinessObject.this_cPorDestino    = THIS.this_cPorDestino

                *-- DODEFAULT chama FormBase.Init (fix datas DataSession=2) + InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Opera" + CHR(231) + CHR(245) + "es Selecionadas")
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria a interface do usuario (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"

            *-- Fundo do form (new_background.jpg do legado)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Cria os containers base (Fase 3: apenas cabecalho)
            THIS.ConfigurarPageFrame()

            *-- Setar caption nos labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Fase 4: grades (GradeOperacao/GradeItens) e botoes reais do
            *-- form (Processar/Encerrar/Apaga/SelTudo). Este form OPERACIONAL
            *-- e FLAT (sem PageFrame Page1=Lista/Page2=Dados no legado - ver
            *-- analise.json formType=OPERACIONAL), por isso nao ha
            *-- ConfigurarPaginaLista/AlternarPagina nem botoes Incluir/
            *-- Alterar/Excluir/Visualizar/Buscar - o legado nao tem.
            THIS.ConfigurarGrids()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarCampos()

            *-- Tornar controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            *-- Fase 8: carga/sincronizacao inicial dos cursores (trecho
            *-- final do Init legado: filtro de TmpItens por EmpDopNum,
            *-- TmpCabec no topo e ThisForm.Refresh). Falha aqui NAO impede
            *-- a abertura do dialogo - CarregarDados ja reporta o erro.
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

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria os containers base do form operacional
    * Form OPERACIONAL sem PageFrame (SIGPRGL2 legado eh single-page, layout
    * FLAT com duas grades empilhadas - grades e botoes entram na Fase 4,
    * campos de observacao/cliente entram nas Fases 5-6)
    *--------------------------------------------------------------------------
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
                .BackColor   = RGB(100,100,100)
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
                .Width     = 769
                .ForeColor = RGB(0,0,0)
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
                .Width     = 769
                .ForeColor = RGB(255,255,255)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrids - Cria as duas grades do dialogo (GradeOperacao/
    * GradeItens do legado). Posicoes/tamanhos copiados de layout.json.
    *
    * TmpCabec/TmpItens sao cursores preparados pelo formulario PAI antes de
    * abrir este dialogo (equivalente ao AddCursor sem query do legado) - o
    * BO (SigPrGl2BO) ja assume acesso direto por alias (this_cCursorCabecalho
    * = "TmpCabec"/this_cCursorItens = "TmpItens"), sem SET DATASESSION, no
    * mesmo padrao ja usado no restante do projeto (ver Formsigmvitn.prg).
    * Se os cursores ainda nao existirem na sessao corrente (instanciacao
    * direta/teste sem o form pai que os popula), criamos versoes vazias com
    * a estrutura inferida dos campos ja referenciados em SigPrGl2BO
    * (CarregarDoCursor/ExecutarProcessamento) para a grade nao derrubar o
    * Init (regra CLAUDE.md #41 - ControlSource de cursor inexistente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("TmpCabec")
                CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6), ;
                    Datas D, Entregas D, Peso N(9,3), Contav C(10), Conta C(10), ;
                    DConta C(50), Obs M NULL, Notas C(6), GrupoOs C(10), ContaOs C(10), ;
                    GrupoDs C(10), ContaDs C(10), Jobs C(10))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                SET ORDER TO EmpDopNum
            ENDIF

            IF !USED("TmpItens")
                CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), ;
                    CodCors C(4), CodTams C(4), Linhas C(10), Citens N(10), Qtds N(10,3), ;
                    Saldo N(10,3), Peso N(9,3), Obs M NULL, Notas C(6), Dpros C(40), Reffs C(40))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON CPros TAG CPros
                SET ORDER TO EmpDopNum
            ENDIF

            *-- Ordem inicial da grade de cabecalho (equivalente ao Init de
            *-- Thisform.cOrdConta do legado) + cor default dos headers
            THIS.this_oBusinessObject.DefinirOrdemConta("")

            *----------------------------------------------------------------
            * grd_4c_Operacoes (GradeOperacao) - Top=155, Left=5, W=789, H=156
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_Operacoes", "Grid")
            loc_oGrid = THIS.grd_4c_Operacoes
            WITH loc_oGrid
                .Top          = 155
                .Left         = 5
                .Width        = 789
                .Height       = 156
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                *-- AllowHeaderSizing/AllowRowSizing/Panel/TabIndex
                *-- transcritos do SCX (a grade legada nao permite o usuario
                *-- redimensionar linha nem cabecalho). RowHeight vai DEPOIS
                *-- de FontName/FontSize - medido no VFP9: mexer na fonte do
                *-- Grid RECALCULA a RowHeight e descarta o valor do SCX
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Panel        = 1
                .TabIndex     = 2
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle = 2
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .FontName     = "Verdana"
                .FontSize     = 8
                .RowHeight    = 17
                .ColumnCount  = 10
                .RecordSource = "TmpCabec"
            ENDWITH

            *-- Column1: Flag (logical) - ControlSource logico faz o VFP9
            *-- gerar sozinho o Check1 da coluna (mesmo padrao ja usado em
            *-- FormCLC.prg CarregarGridOperacoes/Column8.Agrupar - NAO
            *-- criar CheckBox por AddObject aqui, o proprio VFP substitui
            *-- o Text1 por Check1 quando o campo ligado e logico)
            *-- ControlSource transcrito LITERALMENTE do With ThisForm.
            *-- GradeOperacao do Init legado. Tres colunas NAO sao ligacao
            *-- direta a coluna do cursor e por isso eram alvo facil de
            *-- "simplificacao" na migracao:
            *--   Column5 (Entrega) : Iif(IsNull(...), {}, ...) - a coluna
            *--       Entregas aceita NULL; sem o guard a celula exibe .NULL.
            *--   Column8 (Cliente) : liga em TmpCabec.Conta (CODIGO da
            *--       conta). Quem exibe a DESCRICAO e o getCliente/
            *--       txt_4c_Cliente, ligado em TmpCabec.DConta - as duas
            *--       ligacoes sao diferentes DE PROPOSITO.
            *--   Column9 (Obs)     : coluna MARCADORA - mostra "*" quando ha
            *--       observacao e " " quando nao ha (Verdana 12 bold
            *--       centralizado). O texto em si vai no edt_4c_ObsOperacao.
            loc_oGrid.Column1.ControlSource  = "TmpCabec.Flag"
            loc_oGrid.Column1.Sparse         = .F.
            loc_oGrid.Column2.ControlSource  = "TmpCabec.Dopes"
            loc_oGrid.Column3.ControlSource  = "TmpCabec.Numes"
            loc_oGrid.Column4.ControlSource  = "TmpCabec.Datas"
            loc_oGrid.Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
            loc_oGrid.Column6.ControlSource  = "TmpCabec.Peso"
            loc_oGrid.Column7.ControlSource  = "TmpCabec.Contav"
            loc_oGrid.Column8.ControlSource  = "TmpCabec.Conta"
            loc_oGrid.Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
            loc_oGrid.Column10.ControlSource = "TmpCabec.Notas"

            *-- Width + Header DEPOIS do ControlSource (RecordSource/
            *-- ControlSource resetam para o default 90/"Header1").
            *-- Larguras/Movable/Resizable/ReadOnly transcritos do SCX.
            loc_oGrid.Column1.Width           = 17
            loc_oGrid.Column1.ReadOnly        = .F.
            loc_oGrid.Column1.Header1.Caption = ""
            loc_oGrid.Column2.Width           = 156
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Width           = 70
            loc_oGrid.Column3.ReadOnly        = .T.
            loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + "mero"
            loc_oGrid.Column4.Width           = 70
            loc_oGrid.Column4.ReadOnly        = .T.
            loc_oGrid.Column4.Header1.Caption = "Emiss" + CHR(227) + "o"
            loc_oGrid.Column5.Width           = 70
            loc_oGrid.Column5.ReadOnly        = .T.
            loc_oGrid.Column5.Header1.Caption = "Entrega"
            loc_oGrid.Column6.Width           = 90
            loc_oGrid.Column6.ReadOnly        = .T.
            loc_oGrid.Column6.InputMask       = "999,999.99"
            loc_oGrid.Column6.Header1.Caption = "Peso"
            loc_oGrid.Column7.Width           = 90
            loc_oGrid.Column7.ReadOnly        = .T.
            loc_oGrid.Column7.Header1.Caption = "Respons" + CHR(225) + "vel"
            loc_oGrid.Column8.Width           = 90
            loc_oGrid.Column8.ReadOnly        = .T.
            loc_oGrid.Column8.Header1.Caption = "Cliente"
            loc_oGrid.Column9.Width           = 44
            loc_oGrid.Column9.ReadOnly        = .T.
            loc_oGrid.Column9.Alignment       = 2
            loc_oGrid.Column9.FontBold        = .T.
            loc_oGrid.Column9.FontSize        = 12
            loc_oGrid.Column9.Header1.Caption = "Obs"
            loc_oGrid.Column10.Width          = 52
            loc_oGrid.Column10.Header1.Caption = "Doc."

            *-- Colunas nao redimensionaveis/moveis (SCX: Movable=.F. +
            *-- Resizable=.F. em TODAS as colunas das duas grades)
            loc_oGrid.SetAll("Movable", .F., "Column")
            loc_oGrid.SetAll("Resizable", .F., "Column")

            *-- Header/Text1 das colunas (SCX declara Verdana 8, Alignment=2
            *-- e ForeColor 36,84,155 nos headers; Text1 sem borda/margem)
            loc_oGrid.SetAll("FontName", "Verdana", "Header")
            loc_oGrid.SetAll("FontSize", 8, "Header")
            loc_oGrid.SetAll("Alignment", 2, "Header")
            loc_oGrid.SetAll("ForeColor", RGB(36, 84, 155), "Header")
            loc_oGrid.SetAll("BorderStyle", 0, "TextBox")
            loc_oGrid.SetAll("Margin", 0, "TextBox")
            loc_oGrid.SetAll("ForeColor", RGB(0, 0, 0), "TextBox")
            loc_oGrid.SetAll("BackColor", RGB(255, 255, 255), "TextBox")

            *-- Column9.Text1 e a celula do marcador "*" (Verdana 12 bold
            *-- centralizado no SCX); Column10.Header1 e o unico header que
            *-- o SCX NAO declara com Verdana/ForeColor - fica no default
            loc_oGrid.Column9.Text1.FontBold  = .T.
            loc_oGrid.Column9.Text1.FontSize  = 12
            loc_oGrid.Column9.Text1.Alignment = 2
            loc_oGrid.Column10.Header1.FontName  = "Tahoma"
            loc_oGrid.Column10.Header1.FontSize  = 8
            loc_oGrid.Column10.Header1.ForeColor = RGB(0, 0, 0)

            *-- Cor inicial dos headers de ordenacao (EMPDOPNUM e o default)
            loc_oGrid.Column2.Header1.BackColor = RGB(220, 255, 220)
            loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)

            IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                loc_oGrid.Column1.Check1.Alignment = 2
                loc_oGrid.Column1.Check1.ReadOnly  = .F.
                loc_oGrid.Column1.Check1.Visible   = .T.
                BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "FlagCheckKeyPress")
                BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "FlagCheckMouseDown")
            ENDIF
            BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "Column2HeaderClick")
            BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "Column5HeaderClick")
            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeOperacoesAfterRowColChange")

            *----------------------------------------------------------------
            * grd_4c_Itens (GradeItens) - Top=339, Left=5, W=737, H=191
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_Itens", "Grid")
            loc_oGrid = THIS.grd_4c_Itens
            WITH loc_oGrid
                .Top          = 339
                .Left         = 5
                .Width        = 737
                .Height       = 191
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Panel        = 1
                .TabIndex     = 3
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle = 2
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .FontName     = "Verdana"
                .FontSize     = 8
                *-- RowHeight DEPOIS da fonte (ver nota na grade de cabecalho)
                .RowHeight    = 17
                .ReadOnly     = .T.
                .ColumnCount  = 8
                .RecordSource = "TmpItens"
            ENDWITH

            *-- ControlSource transcrito do With ThisForm.GradeItens do Init
            *-- legado. Column1 liga em Cpros (CODIGO do produto, nao a
            *-- descricao Dpros) e Column5 e a coluna MARCADORA de
            *-- observacao (mesmo padrao da Column9 da grade de cabecalho)
            loc_oGrid.Column1.ControlSource = "TmpItens.Cpros"
            loc_oGrid.Column2.ControlSource = "TmpItens.Qtds"
            loc_oGrid.Column3.ControlSource = "TmpItens.Saldo"
            loc_oGrid.Column4.ControlSource = "TmpItens.Peso"
            loc_oGrid.Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
            loc_oGrid.Column6.ControlSource = "TmpItens.CodCors"
            loc_oGrid.Column7.ControlSource = "TmpItens.CodTams"
            loc_oGrid.Column8.ControlSource = "TmpItens.Reffs"

            *-- Larguras do SCX. ColumnOrder tambem vem do SCX: a ordem
            *-- VISUAL do legado nao e a ordem de declaracao -
            *-- Produto, Ref. Fornecedor, Cor, Tam, Quantidade, Saldo,
            *-- Peso, Obs (Column1, 8, 6, 7, 2, 3, 4, 5)
            loc_oGrid.Column1.Width           = 120
            loc_oGrid.Column1.ReadOnly        = .T.
            loc_oGrid.Column1.Header1.Caption = "Produto"
            loc_oGrid.Column2.Width           = 90
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.Header1.Caption = "Quantidade"
            loc_oGrid.Column3.Width           = 118
            loc_oGrid.Column3.ReadOnly        = .T.
            loc_oGrid.Column3.Header1.Caption = "Saldo"
            loc_oGrid.Column4.Width           = 100
            loc_oGrid.Column4.ReadOnly        = .T.
            loc_oGrid.Column4.Header1.Caption = "Peso"
            loc_oGrid.Column5.Width           = 44
            loc_oGrid.Column5.ReadOnly        = .T.
            loc_oGrid.Column5.Alignment       = 2
            loc_oGrid.Column5.FontBold        = .T.
            loc_oGrid.Column5.FontSize        = 12
            loc_oGrid.Column5.Header1.Caption = "Obs"
            loc_oGrid.Column6.Width           = 38
            loc_oGrid.Column6.ReadOnly        = .T.
            loc_oGrid.Column6.Header1.Caption = "Cor"
            loc_oGrid.Column7.Width           = 38
            loc_oGrid.Column7.ReadOnly        = .T.
            loc_oGrid.Column7.Header1.Caption = "Tam"
            loc_oGrid.Column8.Width           = 150
            loc_oGrid.Column8.ReadOnly        = .T.
            loc_oGrid.Column8.Header1.Caption = "Ref. Fornecedor"

            loc_oGrid.Column8.ColumnOrder = 2
            loc_oGrid.Column6.ColumnOrder = 3
            loc_oGrid.Column7.ColumnOrder = 4
            loc_oGrid.Column2.ColumnOrder = 5
            loc_oGrid.Column3.ColumnOrder = 6
            loc_oGrid.Column4.ColumnOrder = 7
            loc_oGrid.Column5.ColumnOrder = 8

            loc_oGrid.SetAll("Movable", .F., "Column")
            loc_oGrid.SetAll("Resizable", .F., "Column")

            loc_oGrid.SetAll("FontName", "Verdana", "Header")
            loc_oGrid.SetAll("FontSize", 8, "Header")
            loc_oGrid.SetAll("Alignment", 2, "Header")
            loc_oGrid.SetAll("ForeColor", RGB(36, 84, 155), "Header")
            loc_oGrid.SetAll("BorderStyle", 0, "TextBox")
            loc_oGrid.SetAll("Margin", 0, "TextBox")
            loc_oGrid.SetAll("ForeColor", RGB(0, 0, 0), "TextBox")
            loc_oGrid.SetAll("BackColor", RGB(255, 255, 255), "TextBox")

            *-- Celula do marcador "*" e o unico header que o SCX nao
            *-- declara com Verdana/ForeColor (Column8 - "Ref. Fornecedor")
            loc_oGrid.Column5.Text1.FontBold  = .T.
            loc_oGrid.Column5.Text1.FontSize  = 12
            loc_oGrid.Column5.Text1.Alignment = 2
            loc_oGrid.Column8.Header1.FontName  = "Tahoma"
            loc_oGrid.Column8.Header1.FontSize  = 8
            loc_oGrid.Column8.Header1.ForeColor = RGB(0, 0, 0)

            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarGrids")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria o Shape decorativo e os 4 botoes reais do
    * dialogo (Processar/Cancelar-Encerrar/Apaga/SelTudo). SIGPRGL2.SCX nao
    * tem CommandGroup nenhum aqui - os 4 sao CommandButton soltos, filhos
    * diretos do form (mapeamento.json). Por isso levam Themes=.T. +
    * DisabledPicture (regra standalone CommandButton com Picture).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- Shape3 (decorativo, sem cor especial no dump) - Top=7,
            *-- Left=732, W=60, H=29
            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top        = 7
                .Left       = 732
                .Width      = 60
                .Height     = 29
                *-- SCX: BackStyle=0 (transparente), BorderStyle=0 e
                *-- BorderColor=136,189,188. Shape NAO tem ForeColor - a cor
                *-- mora em BorderColor/FillColor (CLAUDE.md regra #33)
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Processar - Top=3, Left=648, W=75, H=75
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top        = 3
                .Left       = 648
                .Width      = 75
                .Height     = 75
                .TabIndex   = 9
                .Caption    = "\<Processar"
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .PicturePosition = 13
                .MousePointer = 15
                .WordWrap   = .T.
                .AutoSize   = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_processar_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- Cancelar (Encerrar) - Top=3, Left=723, W=75, H=75
            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top        = 3
                .Left       = 723
                .Width      = 75
                .Height     = 75
                .TabIndex   = 10
                *-- SCX: Cancel = .T. (ESC fecha o dialogo pelo Encerrar)
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .PicturePosition = 13
                .MousePointer = 15
                .WordWrap   = .T.
                .AutoSize   = .F.
                IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- apaga (Desmarcar Todos) - icone-only, Top=358, Left=748, 40x40
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top        = 358
                .Left       = 748
                .Width      = 40
                .Height     = 40
                .Caption    = ""
                .TabIndex   = 8
                .ToolTipText = "Desmarca Tudo"
                .ForeColor  = RGB(36, 84, 155)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .MousePointer = 15
                IF FILE(gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

            *-- SelTudo (Selecionar Todas) - icone-only, Top=400, Left=748, 40x40
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top        = 400
                .Left       = 748
                .Width      = 40
                .Height     = 40
                .Caption    = ""
                .TabIndex   = 7
                .ToolTipText = "Seleciona Tudo"
                .ForeColor  = RGB(36, 84, 155)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .MousePointer = 15
                IF FILE(gc_4c_CaminhoIcones + "geral_selecionar_26.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Campos soltos do form (fora das grades): observacao
    * da operacao (ObsOperacao), campo de cliente (getCliente), label
    * "Cliente :" (Label6), label "Observacao do Item :" (Txt_ObsItens) e
    * observacao do item corrente (ObsItens). Nao ha lookup neste form -
    * getCliente e so leitura (When retorna .f. no legado, campo nunca
    * recebe foco/digitacao) e nenhum outro campo usa fwbuscaext/sigacess.
    * Posicoes/tamanhos copiados de layout.json. Controles ficam DIRETO no
    * form (SIGPRGL2 e FLAT - sem PageFrame/Page), refresh ja cabeado nos
    * handlers AfterRowColChange das duas grades (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oErro

        TRY
            *----------------------------------------------------------------
            * obj_4c_ObsOperacao (ObsOperacao) - Top=82, Left=5, W=602, H=70
            * Observacao do cabecalho da operacao corrente (TmpCabec.Obs)
            *----------------------------------------------------------------
            THIS.AddObject("edt_4c_ObsOperacao", "EditBox")
            WITH THIS.edt_4c_ObsOperacao
                .Top           = 82
                .Left          = 5
                .Width         = 602
                .Height        = 70
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .TabIndex      = 4
                .ControlSource = "TmpCabec.Obs"
                *-- SCX: NullDisplay = " ". TmpCabec.Obs aceita NULL e sem
                *-- isso a caixa exibe o literal .NULL. para o usuario
                .NullDisplay   = " "
                .Visible       = .T.
            ENDWITH

            *----------------------------------------------------------------
            * Label6 "Cliente :" - Top=317, Left=5, W=42, H=15
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_Cliente", "Label")
            WITH THIS.lbl_4c_Cliente
                .Top       = 317
                .Left      = 5
                .Width     = 42
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .TabIndex  = 13
                .Caption   = "Cliente :"
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------
            * getCliente (txt_4c_Cliente) - Top=313, Left=59, W=345, H=23
            * Espelha a descricao da conta da operacao corrente
            * (TmpCabec.DConta, mesma coluna da Column8 da grade). Legado
            * tem When retornando .f. (campo nunca recebe foco/digitacao) -
            * ReadOnly reproduz o mesmo comportamento sem bloquear o Refresh
            * feito em GradeOperacoesAfterRowColChange (Fase 4).
            *----------------------------------------------------------------
            THIS.AddObject("txt_4c_Cliente", "TextBox")
            WITH THIS.txt_4c_Cliente
                .Top           = 313
                .Left          = 59
                .Width         = 345
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .TabIndex      = 3
                .ControlSource = "TmpCabec.DConta"
                .ReadOnly      = .T.
                .TabStop       = .F.
                .Visible       = .T.
            ENDWITH

            *----------------------------------------------------------------
            * Txt_ObsItens "Observacao do Item : " - Top=532, Left=5, W=146,
            * H=15. Classe label pura no legado (AutoSize=.T. sem WordWrap) -
            * regra CLAUDE.md #23: AutoSize=.T. e no-op em Label criado por
            * AddObject, entao fixamos Width/Height explicitos do SCX em vez
            * de confiar no AutoSize.
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_ObsItens", "Label")
            WITH THIS.lbl_4c_ObsItens
                .Top       = 532
                .Left      = 5
                .Width     = 146
                .Height    = 15
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .TabIndex  = 1
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------
            * obj_4c_ObsItens (ObsItens) - Top=548, Left=5, W=737, H=47
            * Observacao do item corrente da grade de itens (TmpItens.Obs) -
            * ja referenciado via PEMSTATUS em GradeOperacoesAfterRowColChange
            * e GradeItensAfterRowColChange (Fase 4)
            *----------------------------------------------------------------
            THIS.AddObject("edt_4c_ObsItens", "EditBox")
            WITH THIS.edt_4c_ObsItens
                .Top           = 548
                .Left          = 5
                .Width         = 737
                .Height        = 47
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .TabIndex      = 6
                .ControlSource = "TmpItens.Obs"
                *-- SCX: NullDisplay = " " (TmpItens.Obs aceita NULL)
                .NullDisplay   = " "
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FlagCheckKeyPress/FlagCheckMouseDown - Column1 (Flag) do grd_4c_Operacoes.
    * Mesmo padrao ja comprovado em FormCLC.prg (OpeGerACheckKeyPress/
    * OpeGerACheckMouseDown): o Check1 e gerado automaticamente pelo VFP9
    * quando o ControlSource e logico, e o clique do mouse ja alterna o
    * valor nativamente - KeyPress cobre Enter/Espaco, MouseDown so garante
    * o Refresh apos o clique.
    *--------------------------------------------------------------------------
    PROCEDURE FlagCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("TmpCabec") AND !EOF("TmpCabec")
            IF par_nKeyCode = 13
                REPLACE Flag WITH .NOT. Flag IN TmpCabec
            ENDIF
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE FlagCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        IF USED("TmpCabec") AND !EOF("TmpCabec")
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Column2HeaderClick/Column5HeaderClick - alterna a ordem da grade de
    * cabecalho entre EMPDOPNUM (Column2 "Movimentacao") e ENTREGA (Column5
    * "Entrega"), colorindo o header ativo (transcrito de comportamento.json)
    *--------------------------------------------------------------------------
    PROCEDURE Column2HeaderClick()
        IF UPPER(ORDER("TmpCabec")) != "EMPDOPNUM"
            SELECT TmpCabec
            SET ORDER TO EmpDopNum
            GO TOP
            THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            WITH THIS.grd_4c_Operacoes
                .Column2.Header1.BackColor = RGB(220, 255, 220)
                .Column5.Header1.BackColor = RGB(192, 192, 192)
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    PROCEDURE Column5HeaderClick()
        IF UPPER(ORDER("TmpCabec")) != "ENTREGA"
            SELECT TmpCabec
            SET ORDER TO Entrega
            GO TOP
            THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            WITH THIS.grd_4c_Operacoes
                .Column2.Header1.BackColor = RGB(192, 192, 192)
                .Column5.Header1.BackColor = RGB(220, 255, 220)
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * mOrdemConta - Equivalente ao metodo legado chamado no Click/Activate do
    * PROPRIO form (comportamento.json). Reaplica a ordem corrente de
    * TmpCabec (via BO.DefinirOrdemConta) e, quando par_lTipo e .T., repinta
    * os headers de ordenacao (mesma paleta das Column*HeaderClick acima -
    * o dump original truncava a 2a metade do Do Case, mas a simetria com os
    * dois handlers de Header1.Click confirma as duas cores).
    *--------------------------------------------------------------------------
    PROCEDURE mOrdemConta(par_lTipo)
        THIS.this_oBusinessObject.DefinirOrdemConta(THIS.this_oBusinessObject.this_cOrdConta)

        IF par_lTipo
            WITH THIS.grd_4c_Operacoes
                IF UPPER(THIS.this_oBusinessObject.this_cOrdConta) = "EMPDOPNUM"
                    .Column2.Header1.BackColor = RGB(220, 255, 220)
                    .Column5.Header1.BackColor = RGB(192, 192, 192)
                ELSE
                    .Column2.Header1.BackColor = RGB(192, 192, 192)
                    .Column5.Header1.BackColor = RGB(220, 255, 220)
                ENDIF
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate/Click (eventos NATIVOS do form) - legado chama
    * Thisform.mOrdemConta(.t.) + GradeOperacao.Refresh nos dois eventos
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.mOrdemConta(.T.)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Click()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.mOrdemConta(.T.)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOperacoesAfterRowColChange - ao trocar de linha na grade de
    * cabecalho, refiltra TmpItens pela chave EmpDopNum da linha corrente e
    * atualiza os controles relacionados (transcrito de comportamento.json).
    * getCliente/ObsOperacao/ObsItens sao criados na Fase 5 (Campos) - os
    * PEMSTATUS evitam "Property nao encontrada" ate la.
    *--------------------------------------------------------------------------
    PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.Refresh()
                ENDIF

                *-- Espelha a nova linha corrente de TmpCabec nas properties
                *-- do BO (equivalente de BOParaForm neste dialogo - ver
                *-- SincronizarBOComLinhaCorrente). Nao altera a area de
                *-- trabalho: o legado termina este handler com TmpItens
                *-- selecionado.
                THIS.SincronizarBOComLinhaCorrente()
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_Cliente", 5)
                THIS.txt_4c_Cliente.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_ObsOperacao", 5)
                THIS.edt_4c_ObsOperacao.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_ObsItens", 5)
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GradeOperacoesAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - ao trocar de linha na grade de itens,
    * atualiza a observacao do item corrente (transcrito de comportamento.json)
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "edt_4c_ObsItens", 5)
            THIS.edt_4c_ObsItens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecaoOperacoes - Guarda de UI do botao Processar.
    *
    * O CRITERIO de negocio (ao menos 1 operacao marcada + todas as marcadas
    * pertencendo ao MESMO Job) mora em
    * SigPrGl2BO.ValidarSelecaoParaProcessamento, fonte UNICA da contagem.
    * O que este metodo acrescenta e o comportamento DE TELA que o legado
    * tinha no inicio do Processar.Click e que so existe no form:
    *
    *   Scan For Flag
    *       If lcJob <> TmpCabec.Jobs
    *           Messagebox([N..o e permitido gerar OPs de opera..es com Jobs
    *                       diferentes.],48,[Aviso])        && so avisa
    *           Return .f.
    *   EndScan
    *   If (_Contador = 0)
    *       =Messagebox('Nenhuma Opera..o Foi Selecionada!!!', 32, '')
    *       ThisForm.GradeOpera..o.Column1.SetFocus         && avisa E foca
    *       Return 0
    *   EndIf
    *
    * Os DOIS ramos avisam, mas so o da selecao vazia devolve o foco a coluna
    * do Flag - por isso consultamos THIS.this_oBusinessObject.
    * this_nOperacoesMarcadas (contagem ja apurada pelo BO) em vez de recontar
    * aqui ou de inferir o ramo pelo texto da mensagem.
    *
    * Retorna .T. quando a selecao esta valida e o processamento pode seguir.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecaoOperacoes()
        LOCAL loc_lValido, loc_cCursor, loc_oErro

        loc_lValido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.ValidarSelecaoParaProcessamento()
                    loc_lValido = .T.
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF

                    *-- Legado: so o ramo "Nenhuma Opera..o Foi Selecionada"
                    *-- devolve o foco a Column1 (coluna do Flag) da grade.
                    IF THIS.this_oBusinessObject.this_nOperacoesMarcadas = 0
                        *-- Transcricao literal do legado: Column1.SetFocus (foca
                        *-- a coluna do Flag NA LINHA CORRENTE - nao usar
                        *-- ActivateCell(1,1), que tambem moveria a linha).
                        *-- Grade sem linha nenhuma tambem cai neste ramo (zero
                        *-- marcadas): ali nao ha celula para focar, e insistir
                        *-- no SetFocus so trocaria o aviso do legado por um
                        *-- erro de runtime.
                        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCabecalho
                        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5) AND ;
                                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                            IF THIS.grd_4c_Operacoes.Visible AND ;
                                    THIS.grd_4c_Operacoes.Enabled AND ;
                                    THIS.grd_4c_Operacoes.ColumnCount >= 1
                                THIS.grd_4c_Operacoes.Column1.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarSelecaoOperacoes")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Click do botao Processar (equivalente ao Click de
    * 390 linhas do legado, ja reproduzido em SigPrGl2BO.ExecutarProcessamento
    * apos a validacao de SigPrGl2BO.ValidarSelecaoParaProcessamento).
    *
    * Cauda transcrita do legado (fim do Processar.Click):
    *   ThisForm.Enabled = .f.
    *   If ThisForm.Reserva
    *       ThisForm.Processar.Enabled = .f.
    *   EndIf
    *   If Not Empty(crSigCdPac.DopEsts)
    *       Do Form SigPrGlx With ThisForm, ThisForm.Datasessionid, ...
    *   Else
    *       Do Form SigPrGlp With ThisForm, ThisForm.Datasessionid, ...
    *   Endif
    *
    * SigPrGl2 NAO se libera aqui (so o Cancelar/Encerrar libera) - o dialogo
    * fica desabilitado atras da tela filha e e reabilitado por ela no
    * Destroy (mesmo padrao ja usado no proprio this_oParentForm.Enabled=.T.
    * do Destroy desta classe). this_lPossuiFabricacao (populado por
    * ExecutarProcessamento a partir de crSigCdPac.DopEsts) decide qual tela
    * filha abre. FormSigPrGlx/FormSigPrGlp compartilham a mesma DataSession
    * do pai e leem os cursores TmpFinal/TmpFinalg pelo nome LITERAL (por
    * isso SigPrGl2BO.ExecutarProcessamento monta esses cursores sem prefixo
    * cursor_4c_ - mesmo padrao ja usado em TmpCabec/TmpItens).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro, loc_lProsseguir, loc_oFilho

        loc_lProsseguir = .T.
        loc_oFilho      = .NULL.

        TRY
            *-- Guarda de entrada do legado (selecao vazia / Jobs diferentes),
            *-- incluindo o retorno de foco a Column1 no ramo da selecao vazia
            IF !THIS.ValidarSelecaoOperacoes()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.ExecutarProcessamento()
                    THIS.Enabled = .F.
                    IF THIS.this_lReservaAuto
                        THIS.cmd_4c_Processar.Enabled = .F.
                    ENDIF

                    IF THIS.this_oBusinessObject.this_lPossuiFabricacao
                        loc_oFilho = CREATEOBJECT("FormSigPrGlx", THIS, ;
                            THIS.this_nDataSessionId, THIS.this_lReservaAuto, ;
                            THIS.this_nEmpHpdr, THIS.this_lAutomatico, ;
                            VAL(THIS.this_cNumeroDaOp), THIS.this_cPorDestino)
                    ELSE
                        loc_oFilho = CREATEOBJECT("FormSigPrGlp", THIS, ;
                            THIS.this_nDataSessionId, THIS.this_lReservaAuto, ;
                            THIS.this_nEmpHpdr, THIS.this_lAutomatico, ;
                            VAL(THIS.this_cNumeroDaOp))
                    ENDIF

                    IF VARTYPE(loc_oFilho) = "O"
                        loc_oFilho.Show()
                    ELSE
                        *-- Falha ao criar a tela filha: devolve o dialogo ao
                        *-- usuario em vez de deixa-lo desabilitado para sempre
                        THIS.Enabled = .T.
                        IF THIS.this_lReservaAuto
                            THIS.cmd_4c_Processar.Enabled = .T.
                        ENDIF
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de gera" + CHR(231) + CHR(227) + "o de OPs.", "Erro ao Processar")
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnProcessarClick")
            THIS.Enabled = .T.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Click do botao Cancelar/Encerrar (legado: reabilita
    * o form pai e libera. Destroy() ja cobre a reabilitacao do pai - regra
    * "cobrir TODO caminho de fechamento, nao so o botao Cancelar")
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaClick - Click do botao "apaga" (Desmarcar Todas): Replace All
    * Flag With .f. In TmpCabec, via SigPrGl2BO.MarcarTodasOperacoes(.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodasOperacoes(.F.)
        ENDIF
        THIS.grd_4c_Operacoes.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Click do botao "SelTudo" (Selecionar Todas): Replace
    * All Flag With .t. In TmpCabec, via SigPrGl2BO.MarcarTodasOperacoes(.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodasOperacoes(.T.)
        ENDIF
        THIS.grd_4c_Operacoes.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carga/sincronizacao inicial dos cursores de trabalho.
    *
    * Transcricao LITERAL do trecho final do PROCEDURE Init do legado, que
    * roda depois de atribuir todos os ControlSource e e o que deixa a tela
    * utilizavel na abertura:
    *
    *   Select TmpItens
    *   Set Order To EmpDopNum
    *   Set Key To TmpCabec.Emps + TmpCabec.Dopes + Str(TmpCabec.Numes, 6)
    *   Go Top
    *
    *   Select TmpCabec
    *   Go Top
    *
    *   ThisForm.Refresh
    *
    * Sem esta carga as duas grades abrem ligadas aos cursores mas SEM o
    * filtro de itens aplicado e sem repintura - o sintoma seria "a grade de
    * itens mostra itens de outra operacao" / "a tela nao traz dados".
    *
    * Duas observacoes sobre a ORDEM, que e do legado e foi preservada:
    *  (a) SET KEY TO <expr> CONGELA o valor no momento do comando - nao
    *      reavalia a expressao quando TmpCabec se move. Medido no VFP9
    *      (2026-09-29, automation\ProbeGl2SetKey.prg): com TmpCabec na
    *      linha 2 no instante do SET KEY, o "Select TmpCabec / Go Top"
    *      seguinte leva o cabecalho para a linha 1 mas a grade de itens
    *      CONTINUA filtrada pela linha 2; e mover TmpCabec depois, sem
    *      refazer o SET KEY, nao muda o filtro. Ou seja, o filtro inicial
    *      depende de onde o formulario PAI deixou TmpCabec. Isso e
    *      comportamento do legado e foi mantido de proposito (PILAR 1):
    *      quem realinha o filtro com a linha efetivamente selecionada e o
    *      GradeOperacoesAfterRowColChange, na primeira troca de linha/
    *      coluna da grade. "Corrigir" aqui divergiria da tela legada.
    *  (b) a chave e POSICIONAL (Emps char(3) + Dopes char(20) + STR(Numes,6)
    *      = 29 caracteres): NAO usar ALLTRIM nas partes, senao a chave
    *      encurta, o SET KEY nunca casa e a grade de itens fica vazia SEM
    *      erro nenhum (CLAUDE.md regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP

                SELECT TmpCabec
                GO TOP

                *-- Espelha a linha corrente de TmpCabec nas properties do BO
                *-- (ObterChavePrimaria/auditoria dependem delas)
                THIS.SincronizarBOComLinhaCorrente()

                THIS.Refresh()
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

    *--------------------------------------------------------------------------
    * SincronizarBOComLinhaCorrente - Equivalente de BOParaForm/FormParaBO
    * neste dialogo.
    *
    * SIGPRGL2 nao tem o par FormParaBO/BOParaForm classico: TODOS os
    * controles de dados (as 10 colunas da grade de cabecalho, as 8 da grade
    * de itens, getCliente e as duas caixas de observacao) sao ligados por
    * ControlSource DIRETO aos cursores TmpCabec/TmpItens, exatamente como no
    * Init do legado - o proprio VFP faz as duas direcoes do transporte, e
    * nao ha campo digitavel cujo valor precise ser empurrado para o BO.
    *
    * O que ainda precisa de transporte explicito e o ESTADO DE LINHA do BO:
    * SigPrGl2BO.CarregarDoCursor mapeia a linha corrente de TmpCabec para as
    * properties this_cEmps/this_cDopes/this_nNumes/... e e delas que
    * ObterChavePrimaria() monta a chave EmpDopNum usada na auditoria. Sem
    * esta chamada essas properties ficariam nos valores iniciais e a chave
    * sairia em branco.
    *
    * Preserva a area de trabalho corrente: CarregarDoCursor faz SELECT no
    * cursor de cabecalho, e os chamadores (CarregarDados e o
    * AfterRowColChange da grade de operacoes) dependem de terminar com
    * TmpItens/TmpCabec selecionado como o legado deixava.
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarBOComLinhaCorrente()
        LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cCursor, loc_oErro
        loc_lSucesso      = .F.
        loc_cAliasAnterior = ALIAS()

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorCabecalho
                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND ;
                        !EOF(loc_cCursor) AND !BOF(loc_cCursor)
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SincronizarBOComLinhaCorrente")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (SIGPRGL2 nao possui containers flutuantes - sem filtros por nome)
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * Destroy - Reabilita o form pai e libera o Business Object ao fechar
    * (equivalente ao "ThisForm.ParentForm.Enabled = .t." do Cancelar.Click
    * legado, reproduzido aqui para cobrir TODO caminho de fechamento, nao
    * so o botao Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
            THIS.this_oParentForm         = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SIGPRGL2BO.PRG
* Business Object do formulario Operacoes Selecionadas (SigPrGl2)
* Origem legado: SigPrGl2.SCX (form generico, aberto via DO FORM pelo
* formulario pai que lista as operacoes, com cursores TmpCabec/TmpItens
* ja populados na DataSession do chamador)
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/Datasessionid/Reserva/Emphpdr/Automatico/
    *-- Numerodaop/Pordestino do SIGPRGL2.SCX legado)
    this_oParentForm      = .NULL.  && Referencia ao form pai (lista de operacoes)
    this_nDataSessionId   = 0       && DataSessionId do form pai (cursores TmpCabec/TmpItens vivem la)
    this_lReservaAuto     = .F.     && .T. quando a reserva de estoque e automatica
    this_nEmpHpdr         = 0       && Codigo do grupo/empresa padrao de geracao (Emphpdr)
    this_lAutomatico      = .F.     && .T. quando o processamento e automatico (sem interacao)
    this_cNumeroDaOp      = ""      && Numero da operacao de origem (Numerodaop)
    this_cPorDestino      = ""      && Destino da operacao (PorDestino)

    *-- Estado da grade de operacoes selecionaveis
    this_cOrdConta        = ""      && Ordem corrente da grade (EMPDOPNUM ou ENTREGA)

    *-- Resultado de ValidarSelecaoParaProcessamento(): quantidade de operacoes
    *-- marcadas (Flag) no cursor de cabecalho. Fonte UNICA da contagem - o form
    *-- le esta property para saber em QUAL ramo do Processar.Click legado a
    *-- validacao caiu (selecao vazia x Jobs diferentes), porque so o ramo da
    *-- selecao vazia devolvia o foco a Column1 da grade.
    this_nOperacoesMarcadas = 0

    *-- Nomes dos cursores de trabalho (populados pelo form pai antes de abrir este dialogo)
    this_cCursorCabecalho = "TmpCabec"  && Cabecalho das operacoes disponiveis para selecao
    this_cCursorItens     = "TmpItens"  && Itens da operacao corrente (filtrados por EmpDopNum)
    this_cCursorOperacoes = "TmpOper"   && Cursor auxiliar de operacoes (ChkObs/Reservas)

    *-- Campos do cabecalho da operacao corrente (mapeados de TmpCabec via CarregarDoCursor)
    this_lFlag     = .F.  && Operacao marcada para processamento
    this_cEmps     = ""   && Empresa da operacao
    this_cDopes    = ""   && Tipo de documento/operacao (Dopes)
    this_nNumes    = 0    && Numero da operacao
    this_dDatas    = {}   && Data de emissao
    this_dEntregas = {}   && Data de entrega
    this_nPeso     = 0    && Peso total da operacao
    this_cContav   = ""   && Codigo da conta (coluna Contav da grade)
    this_cConta    = ""   && Codigo da conta
    this_cDConta   = ""   && Descricao da conta (cliente/fornecedor)
    this_cObs      = ""   && Observacao do cabecalho
    this_cNotas    = ""   && Numero da nota
    this_cGrupoOs  = ""   && Grupo de origem
    this_cContaOs  = ""   && Conta de origem
    this_cGrupoDs  = ""   && Grupo de destino
    this_cContaDs  = ""   && Conta de destino
    this_cJobs     = ""   && Job da operacao

    *-- Resultado de ExecutarProcessamento(), consumido pelo form para decidir
    *-- qual tela filha abrir (SigPrGlx com fabricacao / SigPrGlp sem fabricacao)
    this_cCursorFinal      = "TmpFinal"   && Itens prontos para gerar OP
    this_cCursorFinalG     = "TmpFinalg"  && Itens agrupados (fabricacao)
    this_lPossuiFabricacao = .F.                    && .T. quando crSigCdPac.DopEsts exige geracao de OP de fabricacao

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao opera sobre uma unica tabela SQL Server: trabalha sobre
    * cursores temporarios ja preparados pelo formulario pai (TmpCabec/
    * TmpItens), por isso this_cTabela/this_cCampoChave ficam vazios.
    *
    * crSigCdPam/crSigCdPac sao cursores globais do Fortyus que o sistema
    * legado pre-carregava no login (GrupoEsts/ContaEsts/TransfRes e
    * DopEsts/GerPcps/nMeses, usados em ExecutarProcessamento). O sistema
    * novo nao faz esse pre-load, entao o BO os popula aqui - mesmo padrao
    * do ClienteBO (Erro118).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_nResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 GrupoEsts, ContaEsts, TransfRes FROM SigCdPam", "cursor_4c_Pam_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pam_Temp")
                    SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                    USE IN cursor_4c_Pam_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPam")
                CREATE CURSOR crSigCdPam (GrupoEsts C(10), ContaEsts C(10), TransfRes C(20))
                APPEND BLANK
            ENDIF

            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 DopEsts, GerPcps, nMeses FROM SigCdPac", "cursor_4c_Pac_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pac_Temp")
                    SELECT * FROM cursor_4c_Pac_Temp INTO CURSOR crSigCdPac READWRITE
                    USE IN cursor_4c_Pac_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPac")
                CREATE CURSOR crSigCdPac (DopEsts C(20), GerPcps N(1,0), nMeses N(2,0))
                APPEND BLANK
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Nota de arquitetura (Fase 2/8): este BO nao grava um registro de
    * entidade unica (nao ha Inserir/Atualizar/ExecutarExclusao classicos) -
    * SigPrGl2 e um dialogo de selecao/processamento que opera sobre
    * cursores TmpCabec/TmpItens/TmpOper ja preparados pelo formulario pai
    * (equivalente ao AddCursor sem query do legado). CarregarDoCursor()
    * mapeia a linha corrente de TmpCabec para as properties this_ do
    * cabecalho; a gravacao real do legado (INSERT em SigTempD) fica em
    * ExecutarProcessamento(), que reproduz o Click do botao Processar e
    * monta os cursores TmpFinal/TmpFinalG que as telas SigPrGlx/SigPrGlp
    * usam para gerar as OPs. O comportamento herdado de BusinessBase para
    * Inserir()/Atualizar()/ExecutarExclusao() ja e o correto aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de cabecalho
    * (TmpCabec) para as properties this_ desta classe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lFlag     = Flag
            THIS.this_cEmps     = TratarNulo(Emps, "")
            THIS.this_cDopes    = TratarNulo(Dopes, "")
            THIS.this_nNumes    = TratarNulo(Numes, 0)
            THIS.this_dDatas    = TratarNulo(Datas, {})
            THIS.this_dEntregas = TratarNulo(Entregas, {})
            THIS.this_nPeso     = TratarNulo(Peso, 0)
            THIS.this_cContav   = TratarNulo(Contav, "")
            THIS.this_cConta    = TratarNulo(Conta, "")
            THIS.this_cDConta   = TratarNulo(DConta, "")
            THIS.this_cObs      = TratarNulo(Obs, "")
            THIS.this_cNotas    = TratarNulo(Notas, "")
            THIS.this_cGrupoOs  = TratarNulo(GrupoOs, "")
            THIS.this_cContaOs  = TratarNulo(ContaOs, "")
            THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
            THIS.this_cContaDs  = TratarNulo(ContaDs, "")
            THIS.this_cJobs     = TratarNulo(Jobs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave EmpDopNum (Emps+Dopes+STR(Numes,6)) da
    * operacao corrente, montagem posicional identica a SigMvCab.EmpDopNums
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasOperacoes - Equivalente aos botoes SelTudo/apaga do legado
    * (Replace All Flag With <valor> In TmpCabec)
    *--------------------------------------------------------------------------
    FUNCTION MarcarTodasOperacoes(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            REPLACE ALL Flag WITH par_lMarcar
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DefinirOrdemConta - Equivalente ao mOrdemConta do legado (so a parte de
    * cursor - a cor dos headers da grade fica no form). Aceita apenas as
    * ordens EMPDOPNUM/ENTREGA; qualquer outro valor cai no default EmpDopNum
    *--------------------------------------------------------------------------
    FUNCTION DefinirOrdemConta(par_cOrdem)
        LOCAL loc_lSucesso, loc_cOrdem
        loc_lSucesso = .F.
        loc_cOrdem   = UPPER(TratarNulo(par_cOrdem, ""))

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                SET ORDER TO (loc_cOrdem)
                THIS.this_cOrdConta = loc_cOrdem
            ELSE
                SET ORDER TO EmpDopNum
                THIS.this_cOrdConta = UPPER(ORDER(THIS.this_cCursorCabecalho))
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarSelecaoParaProcessamento - Guarda inicial do Click do botao
    * Processar: exige ao menos 1 operacao marcada (Flag) e que todas as
    * marcadas pertencam ao MESMO Job (regra de negocio do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarSelecaoParaProcessamento()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso  = .T.
        loc_nContador = 0
        THIS.this_cMensagemErro      = ""
        THIS.this_nOperacoesMarcadas = 0

        IF !USED(THIS.this_cCursorCabecalho)
            THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorCabecalho)
        SET ORDER TO EmpDopNum
        GO TOP
        loc_cJob = Jobs
        SCAN FOR Flag
            loc_nContador = loc_nContador + 1
            IF loc_cJob != Jobs
                THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + CHR(231) + CHR(245) + "es com Jobs diferentes."
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDSCAN

        THIS.this_nOperacoesMarcadas = loc_nContador

        IF loc_lSucesso AND loc_nContador = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Replica o Click do botao "Processar" do legado
    * (SIGPRGL2.SCX): calcula o saldo em estoque disponivel para as
    * operacoes marcadas (Flag = .T.) em this_cCursorCabecalho/
    * this_cCursorItens, descontando o que ja esta reservado/fabricado, e
    * monta this_cCursorFinal (TmpFinal) - e, quando o parametro
    * de fabricacao esta configurado (crSigCdPac.DopEsts), tambem
    * this_cCursorFinalG (TmpFinalg) agrupado por produto -
    * prontos para as telas SigPrGlx (fabricacao) / SigPrGlp (sem
    * fabricacao) gerarem as OPs.
    *
    * Equivalencia com o legado: ThisForm.PodataMgr.SqlExecute(...) vira
    * SQLEXEC(gnConnHandle, ...); ThisForm.PodataMgr2.UpDate('CrSigTempd')
    * vira INSERT direto em SigTempD (linha a linha, na mesma transacao
    * manual que o commit/rollback do legado fazia); ThisForm.
    * poDataMgr.CursorQuery(...) vira SELECT ... INTO CURSOR equivalente;
    * _Empr vira go_4c_Sistema.cCodEmpresa (regra #Global Variables).
    *
    * A consulta de vendas (Selecao->Vendas, usada so quando
    * crSigCdPac.nMeses > 0) tinha no legado a coluna "opers" AMBIGUA -
    * vinda tanto de SigMvItn (char) quanto de SigCdOpe (numeric) sem
    * alias, o que so funcionava por coincidencia de resolucao do cliente
    * VFP. Aqui as duas vem explicitamente aliasadas (OpersOpe/OpersItn)
    * para no dar erro de tipo (numeric x char) na mesma expressao.
    *--------------------------------------------------------------------------
    FUNCTION ExecutarProcessamento()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_lManual, loc_oErro
        LOCAL loc_cCidQuerys, loc_cSQL, loc_nResultado
        LOCAL loc_cEdI, loc_cEdF, loc_cEdn, loc_nItn
        LOCAL loc_nProduzir, loc_nEstoque, loc_nXBaixa, loc_nSaldoBaixa
        LOCAL loc_dLimite, loc_lFlagCab

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_lManual     = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        THIS.this_cMensagemErro     = ""
        THIS.this_lPossuiFabricacao = .F.

        *-- 1) Preparando estoque disponivel: grava em SigTempD (staging) uma
        *-- linha por Grupo/Conta de estoque a considerar (TpCads <> 1) - ou,
        *-- na ausencia de qualquer um, a linha padrao de crSigCdPam
        TRY
            loc_cCidQuerys = fUniqueIds()

            loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCeg")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpCeg)"
                loc_lProsseguir = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lProsseguir = .F.
        ENDTRY

        IF loc_lProsseguir
            TRY
                IF RECCOUNT("cursor_4c_TmpCeg") > 0
                    SELECT cursor_4c_TmpCeg
                    SCAN
                        loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, Dpros, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(cursor_4c_TmpCeg.Grupos) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Contas) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_TmpCeg.Priors, 0) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Emps) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                            loc_lProsseguir = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ELSE
                    loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, Dpros, CidChaves, CidQuerys) VALUES (" + ;
                        EscaparSQL(crSigCdPam.GrupoEsts) + ", " + ;
                        EscaparSQL(crSigCdPam.ContaEsts) + ", " + ;
                        FormatarNumeroSQL(1, 0) + ", " + ;
                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                        EscaparSQL("") + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        EscaparSQL(loc_cCidQuerys) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        *-- 2) Estoque disponivel por Grupo/Estoque/Produto (equivalente ao
        *-- Union do legado, cruzando SigMvEst com o SigTempD recem-gravado)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' AND a.Emps = b.Emps AND a.Sqtds > 0"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEstoque")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpEstoque)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        *-- Limpa o staging gravado no passo 1 (equivalente a fSqlApagarTmp)
        IF loc_lProsseguir
            TRY
                SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))
                IF loc_lManual
                    = SQLCOMMIT(gnConnHandle)
                ENDIF
            CATCH TO loc_oErro
                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDTRY
        ENDIF

        *-- 3) Monta TmpSaldo (saldo por produto/cor/tamanho) e TmpSaldg
        *-- (saldo por grupo/estoque/produto/cor/tamanho), varrendo TmpEstoque
        IF loc_lProsseguir
            IF USED("cursor_4c_TmpSaldo")
                USE IN cursor_4c_TmpSaldo
            ENDIF
            IF USED("cursor_4c_TmpSaldg")
                USE IN cursor_4c_TmpSaldg
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams TAG CPros

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams + STR(Priors,2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro

            SELECT cursor_4c_TmpEstoque
            SCAN
                SELECT cursor_4c_TmpSaldo
                IF !SEEK(cursor_4c_TmpEstoque.Cpros + cursor_4c_TmpEstoque.CodCors + cursor_4c_TmpEstoque.CodTams)
                    INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                        VALUES (cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, cursor_4c_TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + cursor_4c_TmpEstoque.Sqtds, ;
                    Disps WITH Disps + cursor_4c_TmpEstoque.Sqtds IN cursor_4c_TmpSaldo

                INSERT INTO cursor_4c_TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps) ;
                    VALUES (cursor_4c_TmpEstoque.Grupos, cursor_4c_TmpEstoque.Estos, cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, ;
                        cursor_4c_TmpEstoque.CodTams, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.Priors, cursor_4c_TmpEstoque.Emps)

                *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                SELECT cursor_4c_TmpEstoque
            ENDSCAN
        ENDIF

        *-- 4) Reserva por transferencia em aberto (SigCdPam.TransfRes): abate
        *-- do saldo o que ja esta alocado em operacoes de transferencia em
        *-- aberto cuja operacao NAO controla estoque (SigCdOpe.Estoqs <> 1)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(crSigCdPam.TransfRes)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir AND !EMPTY(crSigCdPam.TransfRes) AND USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.Estoqs <> 1
            loc_cEdI = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(0, 6)
            loc_cEdF = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(999999, 6)

            TRY
                loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes FROM SigMvCab " + ;
                    "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " " + ;
                    "ORDER BY EmpDopNums"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEest")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEest)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir
                SELECT cursor_4c_TempEest
                SCAN
                    loc_cEdn = cursor_4c_TempEest.EmpDopNums

                    IF USED("cursor_4c_TempEestI")
                        USE IN cursor_4c_TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), "cursor_4c_TempEestI")

                    IF USED("cursor_4c_TempEestI")
                        SELECT cursor_4c_TempEestI
                        SCAN FOR (Qtds - QtBaixas) > 0
                            loc_nItn = cursor_4c_TempEestI.CItens

                            IF USED("cursor_4c_TempEsti2")
                                USE IN cursor_4c_TempEsti2
                            ENDIF
                            loc_cSQL = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEsti2")

                            IF !USED("cursor_4c_TempEsti2") OR EOF("cursor_4c_TempEsti2")
                                SELECT cursor_4c_TmpSaldo
                                IF !SEEK(cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldo (Cpros) VALUES (cursor_4c_TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)

                                SELECT cursor_4c_TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, Priors) ;
                                        VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, cursor_4c_TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)
                            ELSE
                                SELECT cursor_4c_TempEsti2
                                SCAN
                                    loc_nSaldoBaixa = cursor_4c_TempEsti2.Qtds - cursor_4c_TempEsti2.QtBaixas

                                    SELECT cursor_4c_TmpSaldo
                                    IF !SEEK(cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldo (Cpros, CodCors, CodTams) ;
                                            VALUES (cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    SELECT cursor_4c_TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors) ;
                                            VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, ;
                                            cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                                    SELECT cursor_4c_TempEsti2
                                ENDSCAN
                            ENDIF

                            *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                            SELECT cursor_4c_TempEestI
                        ENDSCAN
                    ENDIF

                    *-- SQLEXEC troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TempEest
                ENDSCAN
            ENDIF
        ENDIF

        *-- 5) Monta TmpFinal com os itens das operacoes marcadas, descontando
        *-- o estoque disponivel calculado acima
        IF loc_lProsseguir
            IF USED("TmpFinal")
                USE IN TmpFinal
            ENDIF
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), Peso N(9,3), ;
                Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, Obsps M NULL, ;
                Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), Linhas C(10), ;
                Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros

            SELECT (THIS.this_cCursorCabecalho)
            SET ORDER TO EmpDopNum

            SELECT (THIS.this_cCursorItens)
            SET KEY TO
            SET ORDER TO CPros
            SCAN
                SELECT (THIS.this_cCursorCabecalho)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Emps") + EVALUATE(THIS.this_cCursorItens + ".Dopes") + STR(EVALUATE(THIS.this_cCursorItens + ".Numes"), 6)
                loc_lFlagCab = Flag

                *-- SCAN/LOOP dependem da area CORRENTE, nao da area em que o
                *-- SCAN foi aberto - restaurar this_cCursorItens ANTES do LOOP
                SELECT (THIS.this_cCursorItens)
                IF !loc_lFlagCab
                    LOOP
                ENDIF

                SELECT (THIS.this_cCursorOperacoes)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Dopes")

                SELECT (THIS.this_cCursorItens)
                IF (Saldo > 0)
                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF (EVALUATE(THIS.this_cCursorOperacoes + ".ChkObs") <> 1 AND !EMPTY(Obs)) OR ;
                            !SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo") OR ;
                            EMPTY(crSigCdPam.TransfRes) OR (EVALUATE(THIS.this_cCursorOperacoes + ".Reservas") = 2 AND !THIS.this_lReservaAuto) OR ;
                            cursor_4c_TmpSaldo.Disps < 0
                        loc_nProduzir = Saldo
                    ELSE
                        = SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo")
                        loc_nEstoque = cursor_4c_TmpSaldo.Disps
                        IF (cursor_4c_TmpSaldo.Disps >= Saldo)
                            REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - Saldo
                        ELSE
                            loc_nProduzir = Saldo - cursor_4c_TmpSaldo.Disps
                            REPLACE cursor_4c_TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_SigCdPro")
                        USE IN cursor_4c_SigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(CPros), "cursor_4c_SigCdPro")

                    *-- SQLEXEC troca a area corrente - restaurar antes de ler os
                    *-- campos "soltos" (Emps/Dopes/Numes/...) abaixo, que se
                    *-- referem ao registro corrente de this_cCursorItens
                    SELECT (THIS.this_cCursorItens)

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
                            Obs, Datas, Entregas, CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                            Dpros, GrupoDs, ContaDs, Jobs) ;
                        VALUES (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Saldo - loc_nProduzir, ;
                            loc_nProduzir, TratarNulo(Obs, ""), TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Obs"), ""), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Datas"), {}), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Entregas"), {}), CodCors, CodTams, ;
                            Linhas, CItens, IIF(USED("cursor_4c_SigCdPro"), TratarNulo(cursor_4c_SigCdPro.Reffs, ""), ""), Notas, ;
                            Dpros, EVALUATE(THIS.this_cCursorCabecalho + ".Grupods"), EVALUATE(THIS.this_cCursorCabecalho + ".Contads"), ;
                            EVALUATE(THIS.this_cCursorCabecalho + ".Jobs"))

                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                    SELECT (THIS.this_cCursorItens)
                ENDIF
            ENDSCAN
        ENDIF

        *-- 6) Distribui a baixa apurada em TmpSaldo pelos grupos/estoques de
        *-- TmpSaldg (mesmo produto/cor/tamanho), na ordem de prioridade
        IF loc_lProsseguir
            SELECT cursor_4c_TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_nXBaixa = Saldo - Disps
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
                            REPLACE cursor_4c_TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN

                    *-- o SCAN interno deixou cursor_4c_TmpSaldg selecionado -
                    *-- restaurar antes do ENDSCAN externo
                    SELECT cursor_4c_TmpSaldo
                ENDIF
            ENDSCAN
        ENDIF

        *-- 7) Quando o parametro de fabricacao esta configurado
        *-- (crSigCdPac.DopEsts), apura tambem o saldo ja alocado em OPs de
        *-- fabricacao em aberto e monta TmpFinalG (agrupado por produto/
        *-- cor/tamanho) para a tela de fabricacao
        IF loc_lProsseguir AND !EMPTY(crSigCdPac.DopEsts)
            THIS.this_lPossuiFabricacao = .T.

            IF USED("cursor_4c_TmpFabr")
                USE IN cursor_4c_TmpFabr
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), CodCors C(4), CodTams C(4), Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            SET NULL OFF
            INDEX ON Cpros + CodCors + CodTams + STR(Priors,2) + STR(Nops,10) TAG Cpros

            TRY
                loc_cSQL = "SELECT a.Nops, a.Cpros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + " AND a.EmpDopNops = b.EmpDnps AND b.Chksubn = " + FormatarNumeroSQL(0, 0) + " " + ;
                    "AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " GROUP BY a.Nops, a.Cpros, a.CodCors, a.CodTams"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir AND USED("cursor_4c_TmpOpi")
                SELECT cursor_4c_TmpOpi
                SCAN
                    SELECT cursor_4c_TmpSaldo
                    IF !SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams)
                        INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams) ;
                            VALUES (cursor_4c_TmpOpi.CPros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams)
                    ENDIF
                    REPLACE Fabrs WITH Fabrs + cursor_4c_TmpOpi.Qtds, DispFs WITH DispFs + cursor_4c_TmpOpi.Qtds

                    INSERT INTO cursor_4c_TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) ;
                        VALUES (cursor_4c_TmpOpi.Nops, cursor_4c_TmpOpi.Cpros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams, cursor_4c_TmpOpi.Qtds, 0)

                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                    loc_cSQL = "SELECT GrupoDs FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(cursor_4c_TmpOpi.Nops, 0) + " ORDER BY CidChaves DESC"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF USED("cursor_4c_TmpMfas")
                        SELECT cursor_4c_TmpMfas
                        GO TOP
                        IF !EOF("cursor_4c_TmpMfas")
                            REPLACE Fases WITH cursor_4c_TmpMfas.GrupoDs IN cursor_4c_TmpFabr
                        ENDIF
                    ENDIF

                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams, "TmpFinal", "Cpros")
                        IF cursor_4c_TmpSaldo.Fabrs >= TmpFinal.Produzir
                            loc_nEstoque  = TmpFinal.Produzir
                            loc_nProduzir = 0
                            REPLACE cursor_4c_TmpSaldo.Dispfs WITH cursor_4c_TmpSaldo.Dispfs - TmpFinal.Produzir IN cursor_4c_TmpSaldo
                        ELSE
                            loc_nEstoque  = cursor_4c_TmpSaldo.Fabrs
                            loc_nProduzir = TmpFinal.Produzir - cursor_4c_TmpSaldo.Fabrs
                            REPLACE Dispfs WITH 0 IN cursor_4c_TmpSaldo
                        ENDIF
                        REPLACE Produzir WITH loc_nProduzir, Fabrs WITH loc_nEstoque IN TmpFinal
                    ENDIF

                    *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TmpOpi
                ENDSCAN

                SELECT cursor_4c_TmpSaldo
                SCAN
                    IF Fabrs # Dispfs
                        loc_nXBaixa = Fabrs - DispFs
                        SELECT cursor_4c_TmpFabr
                        SET ORDER TO Cpros
                        = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                        SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                            IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
                                REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa IN cursor_4c_TmpFabr
                                loc_nXBaixa = 0
                            ELSE
                                loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
                                REPLACE cursor_4c_TmpFabr.Disps WITH Qtds IN cursor_4c_TmpFabr
                            ENDIF
                        ENDSCAN

                        *-- o SCAN interno deixou cursor_4c_TmpFabr selecionado -
                        *-- restaurar antes do ENDSCAN externo
                        SELECT cursor_4c_TmpSaldo
                    ENDIF
                ENDSCAN

                IF USED("TmpFinalg")
                    USE IN TmpFinalg
                ENDIF
                CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), Linhas C(10), Qtds N(10,3), ;
                    Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), Produzir2 N(10,3), ;
                    TotVenda N(10,3), QtdMins N(10,3), KeySelM L, KeySelMP L, UsuLibs C(10))
                INDEX ON Cpros + CodCors + CodTams TAG Cpros

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
                SELECT Cpros, CodCors, CodTams, Linhas, SUM(Qtds) AS Qtds, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
                        SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs FROM TmpFinal ;
                    INTO CURSOR cursor_4c_Selecao GROUP BY Cpros, CodCors, CodTams, Linhas READWRITE

                IF crSigCdPac.nMeses > 0
                    loc_dLimite = GOMONTH(DATE(), -crSigCdPac.nmeses)

                    IF USED("cursor_4c_LocalEest")
                        USE IN cursor_4c_LocalEest
                    ENDIF
                    TRY
                        loc_cSQL = "SELECT a.cpros, a.qtds, b.Caixas, b.copers, b.opers AS OpersOpe, a.opers AS OpersItn " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND c.datas >= " + FormatarDataSQL(loc_dLimite) + " " + ;
                            "AND a.dopes = b.dopes AND b.tipoops IN (4,5)"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")
                    CATCH TO loc_oErro
                        THIS.this_cMensagemErro = loc_oErro.Message
                    ENDTRY

                    IF USED("cursor_4c_LocalEest")
                        IF USED("cursor_4c_Vendas")
                            USE IN cursor_4c_Vendas
                        ENDIF
                        SELECT cpros, SUM(qtds * IIF((Caixas = 1 AND copers = 1) OR (caixas <> 1 AND OpersOpe = 1) OR (caixas <> 1 AND OpersOpe = 3 AND OpersItn = "E"), 1, -1)) AS Qtds ;
                            FROM cursor_4c_LocalEest GROUP BY 1 INTO CURSOR cursor_4c_Vendas READWRITE
                        SELECT cursor_4c_Vendas
                        INDEX ON cpros TAG Cpros
                    ENDIF
                ENDIF

                SELECT TmpFinalg
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_Selecao
                SCAN
                    SCATTER MEMVAR
                    m.flag = "+"

                    IF USED("cursor_4c_SigCdProQtd")
                        USE IN cursor_4c_SigCdProQtd
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT QtMinFabs FROM SigCdPro WHERE Cpros = " + EscaparSQL(cursor_4c_Selecao.Cpros), "cursor_4c_SigCdProQtd")

                    m.QtdMins = 0
                    IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReservaAuto) OR (crSigCdPac.GerPcps <> 2 AND THIS.this_lReservaAuto)
                        IF USED("cursor_4c_SigCdProQtd") AND !EOF("cursor_4c_SigCdProQtd")
                            m.QtdMins = cursor_4c_SigCdProQtd.QtMinFabs
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Vendas") AND SEEK(m.Cpros, "cursor_4c_Vendas", "Cpros")
                        m.TotVenda = cursor_4c_Vendas.Qtds
                    ELSE
                        m.TotVenda = 0
                    ENDIF

                    m.Produzir2 = IIF(m.QtdMins > 0 AND m.produzir > 0 AND m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                    SELECT TmpFinalg
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- APPEND BLANK troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_Selecao
                ENDSCAN
            ENDIF
        ENDIF

        IF loc_lProsseguir
            SELECT (THIS.this_cCursorItens)
            SET ORDER TO EmpDopNum
            SET KEY TO EVALUATE(THIS.this_cCursorCabecalho + ".Emps") + EVALUATE(THIS.this_cCursorCabecalho + ".Dopes") + STR(EVALUATE(THIS.this_cCursorCabecalho + ".Numes"), 6)
            GO TOP

            THIS.this_cCursorFinal  = "TmpFinal"
            THIS.this_cCursorFinalG = "TmpFinalg"
            loc_lSucesso = .T.
        ELSE
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Favor reinicializar o processo."
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

