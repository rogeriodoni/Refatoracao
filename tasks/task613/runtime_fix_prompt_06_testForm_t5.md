# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 5/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-29 02:59:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-29 02:59:38] [INFO] Config FPW: (nao fornecido)
[2026-09-29 02:59:38] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 02:59:38] [INFO] Timeout: 300 segundos
[2026-09-29 02:59:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi2gsq4j.prg
[2026-09-29 02:59:38] [INFO] Conteudo do wrapper:
[2026-09-29 02:59:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGf2', 'C:\4c\tasks\task613\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf2', 'C:\4c\tasks\task613\logs\06_testForm.log'
QUIT

[2026-09-29 02:59:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi2gsq4j.prg
[2026-09-29 02:59:38] [INFO] VFP output esperado em: C:\4c\tasks\task613\vfp_output.txt
[2026-09-29 02:59:38] [INFO] Executando Visual FoxPro 9...
[2026-09-29 02:59:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi2gsq4j.prg
[2026-09-29 02:59:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi2gsq4j.prg
[2026-09-29 02:59:38] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGf2
Inicio: 29/09/2026 02:59:38

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 29/09/2026 03:02:55
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-29 03:02:56] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-29 03:02:56] [INFO] VFP9 finalizado em 197.9148916 segundos
[2026-09-29 03:02:56] [INFO] Exit Code: 
[2026-09-29 03:02:56] [INFO] 
[2026-09-29 03:02:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-29 03:02:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi2gsq4j.prg
[2026-09-29 03:02:56] [INFO] 
[2026-09-29 03:02:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-29 03:02:56] [INFO] * Auto-generated wrapper for parameters
[2026-09-29 03:02:56] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-29 03:02:56] [INFO] * Parameters: 'FormSigPrGf2', 'C:\4c\tasks\task613\logs\06_testForm.log'
[2026-09-29 03:02:56] [INFO] 
[2026-09-29 03:02:56] [INFO] * Anti-dialog protections for unattended execution
[2026-09-29 03:02:56] [INFO] SET SAFETY OFF
[2026-09-29 03:02:56] [INFO] SET RESOURCE OFF
[2026-09-29 03:02:56] [INFO] SET TALK OFF
[2026-09-29 03:02:56] [INFO] SET NOTIFY OFF
[2026-09-29 03:02:56] [INFO] SYS(2335, 0)
[2026-09-29 03:02:56] [INFO] 
[2026-09-29 03:02:56] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf2', 'C:\4c\tasks\task613\logs\06_testForm.log'
[2026-09-29 03:02:56] [INFO] QUIT
[2026-09-29 03:02:56] [INFO] 
[2026-09-29 03:02:56] [INFO] === Fim do Wrapper.prg ===
[2026-09-29 03:02:56] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg):
*==============================================================================
* FormSigPrGf2.prg - Grafico de Falha X Recuperacao Mensal (grafico filho)
*
* Origem legado: SIGPRGF2.SCX (task613)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: todos os objetos
*       sao filhos diretos de SIGPRGF2). Aberto pelo form pai FormSigPrGf1
*       (BtnProcessarClick, ja completo) via
*       CREATEOBJECT("FormSigPrGf2", THIS), depois de processar e deixar
*       pronto o cursor agregado por mes no alias GLOBAL "crRel1" (o legado
*       abria com "Do Form SigPrGf2 With ThisForm").
*
* BO: SigPrGf2BO (sem tabela propria - so agrega/formata o cursor de origem
*     recebido do form pai; ver SigPrGf2BO.PopularChaves/GerarGrafico)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, cabecalho)
* Atualizado em: Fase 4 - CommandGroup obj_4c_CmdgGrafico (Grafico/Encerrar).
*                BINDEVENT dos 2 botoes fica para a Fase 7/8, junto com
*                mGeraGrafico/Report Form/fechamento do form (mesmo padrao
*                de FormSigPrGf1.ConfigurarBotoesAcao).
* Atualizado em: Fase 5 - cnt_4c_Grf1 (container flutuante do dump legado,
*                Top=120/Left=17/Width=770/Height=429/BackColor=branco) com
*                obj_4c_OleGrafico1 (OleBoundControl, Top=19/Left=5/
*                Width=760/Height=390). Container comeca Visible=.F.
*                (transcrito do Init legado: ".cntGrf1.Visible = .f." antes
*                de mGeraGrafico e ".t." depois) e por isso eh filtrado em
*                TornarControlesVisiveis, mesmo padrao de FormSigReCmg
*                (cnt_4c_Grf1/cnt_4c_Grf2/cnt_4c_Aguarde sao flutuantes,
*                controlados pelo Init/eventos, nao pelo
*                TornarControlesVisiveis generico). .ControlSource NAO eh
*                setado aqui - o legado so faz
*                ".cntGrf1.oleGrafico1.ControlSource = 'crGrafico1.gGrafico1s'"
*                dentro de mGeraGrafico, depois que o cursor crGrafico1 (e o
*                registro correspondente) ja existe; setar antes estouraria
*                alias inexistente (mesma familia da regra de
*                Column.ControlSource antes do cursor existir). Fica para a
*                Fase 7/8, junto com o resto de mGeraGrafico.
* Atualizado em: Fase 6 - cnt_4c_Grf2 (container flutuante do dump legado,
*                Top=558/Left=559/Width=228/Height=35/BackColor=branco)
*                com lbl_4c_LblChave1 ("Grupo / Vendedor :") e
*                cbo_4c_CmbChave1 (ComboBox Style=2/ColumnCount=1/
*                FontName="Courier New"). Container comeca Visible=.F. e
*                fica filtrado em TornarControlesVisiveis, mesmo padrao de
*                cnt_4c_Grf1: o Init legado faz ".cntGrf2.Visible = .f."
*                tanto ANTES quanto DEPOIS de mGeraGrafico (o combo de
*                selecao de chave nunca aparece neste fluxo).
*
*                LOOKUPS: o SCX legado NAO tem lookup nenhum - zero
*                fwBuscaExt / fwBuscaSel / sigacess() / mAddColuna /
*                Acesso*() no dump inteiro (SigPrGf2_form_codigo_fonte.txt).
*                Esta tela eh um visualizador de grafico: o unico campo de
*                entrada eh o ComboBox Style=2 (dropdown LIST), que nao
*                aceita digitacao e cuja lista o proprio form monta a partir
*                do cursor de origem recebido do pai. Criar um
*                AbrirLookup*/FormBuscaAuxiliar aqui seria INVENTAR tabela de
*                lookup que o legado nao consulta - viola o PILAR 1 e a regra
*                "NUNCA inventar tabelas de lookup que nao existem no
*                original".
*
*                CAMPOS RESTANTES (ultimo container estatico do dump):
*                cnt_4c_Aguarde (Top=288/Left=312/Width=207/Height=49/
*                BorderWidth=5/BackColor=branco) com lbl_4c_Label1
*                ("Aguarde...", Verdana 10 bold, ForeColor=RGB(255,0,0)) e
*                lbl_4c_Label2 ("Processando Dados...", Verdana 10 bold
*                condensada). Com ele, TODOS os 14 objetos da arvore do SCX
*                legado estao criados.
*
*                COMPORTAMENTO DO CAMPO (o que substitui o lookup nesta
*                tela): os DOIS eventos que o legado tem no cmbChave1 -
*                Click e GotFocus - ligados por BINDEVENT, mais a guarda que
*                o legado aplica ao indice do combo antes de usa-lo
*                (ValidarLinhaChave, transcrita de "m.lnLinhaCmb1 =
*                Iif((Type('m.lnLinhaCmb1')=='N'.And.m.lnLinhaCmb1>0),
*                m.lnLinhaCmb1,1)" somada ao gate
*                "If .cntGrf2.cmbChave1.ListCount>0" do mGeraGrafico) e a
*                leitura do item selecionado (ObterChaveSelecionada,
*                transcrita de "m.lcChave1 =
*                .cntGrf2.cmbChave1.List(m.lnLinhaCmb1)").
*                CboChave1Click reproduz o Click legado inteiro: exibe
*                cnt_4c_Aguarde, Refresh/Draw, LockScreen, desabilita os
*                OleBoundControl, gera o grafico da chave escolhida
*                (SigPrGf2BO.GerarGrafico, ja completo desde a Fase 2),
*                devolve o foco ao combo e esconde o Aguarde.
*
*                O AddItem dos valores, o ListIndex=1 inicial, o
*                reposicionamento/redimensionamento dinamico do proprio
*                cntGrf2 (calculados a partir do tamanho dos valores de
*                crRel1.cEmps) e o DESENHO do MSGraph no OleBoundControl
*                (Append General + ControlSource + propriedades do chart)
*                ficam para a Fase 7/8, junto com o resto de mGeraGrafico e
*                com os Click dos 2 botoes de obj_4c_CmdgGrafico.
*
* Atualizado em: Fase 7/8 - fecha o mgeragrafico legado: PopularComboChaves()
*                (AddItem + reposicionamento de cnt_4c_Grf2, so na 1a chamada,
*                guardado pelo ListCount) e DesenharGrafico() (cursor LOCAL
*                cursor_4c_OleGrafico1 - equivalente a crGrafico1, com o
*                binario do OLE que o BO nao guarda - Append General +
*                ControlSource + toda a formatacao do MSGraph.Chart), ambos
*                por tras de MGeraGrafico() (fonte UNICA, chamada tanto por
*                ExecutarCargaInicial() - equivalente ao trecho do Init
*                legado que chama ".mGeraGrafico()" antes do Show() - quanto
*                por CboChave1Click(), que agora delega em vez de duplicar
*                Validar/Obter/Gerar). BINDEVENT dos 2 botoes de
*                obj_4c_CmdgGrafico: Buttons(1) "Grafico" -> BtnGraficoClick
*                (Report Form do registro atual do cache, igual ao
*                cmdImprimir.Click legado) e Buttons(2) "Encerrar" ->
*                BtnEncerrarClick (fecha o cursor do OLE, libera o form e
*                reabilita this_oFormPai, igual ao cmdSair.Click legado).
*                Medido no VFP9 (2026-09-29): fluxo pai->filho fim-a-fim
*                (crRel1 populado na sessao privada do pai, filho aberto com
*                CREATEOBJECT("FormSigPrGf2", <pai>)) prova o combo populado,
*                o BO gerando a serie certa e a troca de chave regenerando -
*                o unico ponto que a maquina de teste nao cobre eh o proprio
*                APPEND GENERAL CLASS "MSGraph.Chart", porque este ambiente
*                nao tem esse OLE server registrado (OLE error 0x800401f3);
*                por isso DesenharGrafico() isola o INSERT/APPEND GENERAL num
*                TRY proprio e desfaz a linha de cache se falhar - sem o
*                rollback, a mesma chave nunca mais tentaria desenhar (ficaria
*                para sempre com o cache "encontrado" e o gGrafico1s vazio).
*
* CONTRATO COM O FORM PAI (FormSigPrGf1, ja completo - ver o comentario acima
* de "CREATEOBJECT("FormSigPrGf2", THIS)" em FormSigPrGf1.BtnProcessarClick)
* --------------------------------------------------------------------------
* 1) CREATEOBJECT("FormSigPrGf2", <form pai>) - UM parametro, a referencia do
*    form pai (par_loForm1, mesmo nome do "loForm1" recebido pelo Init
*    legado). Sem parametro, THIS.this_oFormPai aponta para o proprio form
*    (equivalente a "Iif(Type('m.loForm1')=='O',m.loForm1,ThisForm)" do
*    legado).
* 2) THIS.DataSessionId = par_loForm1.DataSessionId ANTES do DODEFAULT() -
*    entra na MESMA sessao privada do pai (DataSession=2 dele) para enxergar
*    o cursor global "crRel1" que o pai populou antes de abrir este form.
* 3) WindowType = 0 (modeless, TRANSCRITO do legado - NAO trocar para 1): o
*    pai (FormSigPrGf1.BtnProcessarClick) so faz THIS.Enabled = .F. depois de
*    confirmar VARTYPE(...) = "O" do CREATEOBJECT e NUNCA chama .Show() no
*    filho - quem se mostra eh o proprio filho.
* 4) O legado mostra a tela no proprio Init (".Show()" dentro de
*    "With ThisForm"), por isso InicializarForm chama THIS.Show() ao final -
*    seguro aqui porque WindowType = 0 nao bloqueia (a regra do CLAUDE.md
*    sobre Show() modal dentro de TRY fechar a tela nao se aplica a form
*    modeless, so a WindowType = 1).
*==============================================================================

DEFINE CLASS FormSigPrGf2 AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRGF2.SCX: Width=800, Height=600 (layout.json) - dialogo de
    *-- grafico, sem necessidade de escalar para o canonico 1000x600 (esse
    *-- canonico vale para forms CRUD frmcadastro).
    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
    WindowType   = 0
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    BorderStyle  = 1

    *-- DataSession = 2 transcrito do SCX. So vale quando este form eh aberto
    *-- SEM form pai (this_oFormPai = THIS): nesse caso ganha sessao privada
    *-- propria. Quando ha form pai, Init() troca THIS.DataSessionId pela
    *-- sessao dele ANTES do DODEFAULT() - ver contrato no cabecalho.
    DataSession  = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia do form pai (poForm1 do legado). Reabilitado no Encerrar
    *-- (Fase 7/8, migracao de cmdSair.Click).
    this_oFormPai = .NULL.

    *-- Cache LOCAL do binario do grafico (MSGraph.Chart) por chave -
    *-- equivalente ao crGrafico1 do legado (gGrafico1s g(4)/cChave1s c(100)/
    *-- cempresas c(254)/ctitulo1s c(128)). O BO (this_oBusinessObject) so
    *-- guarda o TEXTO das series (this_cLabelsMeses/this_cSerieFalha/
    *-- this_cSerieRecuperacao) - o binario do OLE eh responsabilidade do
    *-- Form (PILAR 3: BO nao manipula OLE). Populado em DesenharGrafico().
    this_cCursorOleGrafico = "cursor_4c_OleGrafico1"

    *==========================================================================
    * Init - Recebe a referencia do form pai (par_loForm1, equivalente ao
    * "Lparameters loForm1" do legado) e assume a DataSessionId dele ANTES do
    * DODEFAULT(), para enxergar o cursor "crRel1" que o pai ja populou.
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_loForm1

        LOCAL loc_oErro

        TRY
            IF VARTYPE(par_loForm1) = "O"
                THIS.this_oFormPai = par_loForm1
                THIS.DataSessionId = par_loForm1.DataSessionId
            ELSE
                THIS.this_oFormPai = THIS
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO, aponta o cursor de origem (alias
    * GLOBAL "crRel1", equivalente ao crRel1 do legado - regra #22/PILAR 3: o
    * BO nao adivinha o nome, o Form eh quem sabe o contrato com o pai), monta
    * o cabecalho e exibe o form (equivalente ao ".Show()" dentro do
    * "With ThisForm" do Init legado).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCursorOrigem = "crRel1"

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                THIS.ExecutarCargaInicial()

                *-- Pulado em harness headless (gb_4c_ModoTeste/
                *-- gb_4c_ValidandoUI): sem janela de verdade o Show() de um
                *-- form modeless so faria o processo depender de uma UI que
                *-- nao existe no teste automatizado.
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND ;
                   !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.Show()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrGf2BO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrGf2.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGf2.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGF2 nao tem
    * PageFrame no legado (layout flat) - nome mantido apenas como ponto de
    * entrada arquitetural padrao (mesmo papel em FormSigPrGf1/FormFop).
    *
    * Roteiro das proximas fases:
    *   Fase 3 (feita) - ConfigurarCabecalho()
    *   Fase 4 (feita) - ConfigurarBotoesGrafico() (obj_4c_CmdgGrafico,
    *                      CommandGroup com 2 botoes: Grafico/Encerrar)
    *   Fase 5 (feita) - ConfigurarGrf1() (cnt_4c_Grf1 flutuante +
    *                      obj_4c_OleGrafico1)
    *   Fase 6 (esta)  - ConfigurarGrf2() (cnt_4c_Grf2 flutuante + combo
    *                      cbo_4c_CmbChave1 + lbl_4c_LblChave1),
    *                      ConfigurarAguarde() (cnt_4c_Aguarde + os 2 labels)
    *                      e ConfigurarEventos() (BINDEVENT Click/GotFocus do
    *                      combo - o legado nao tem lookup nenhum)
    *   Fase 7/8        - BINDEVENT dos 2 botoes de obj_4c_CmdgGrafico e
    *                      mGeraGrafico (carga do combo + desenho do MSGraph)
    *
    * ConfigurarEventos() vai por ULTIMO de proposito: BINDEVENT so resolve
    * referencia de objeto que JA existe, entao todo AddObject tem de ter
    * acontecido antes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesGrafico()
        THIS.ConfigurarGrf1()
        THIS.ConfigurarGrf2()
        THIS.ConfigurarAguarde()
        THIS.ConfigurarEventos()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado).
    *==========================================================================
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
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesGrafico - CommandGroup obj_4c_CmdgGrafico com os 2
    * botoes do legado (cmdgGrafico, ButtonCount=2): Buttons(1)=Grafico
    * (cmdImprimir, dispara Report Form SigPrGf1 - migracao na Fase 7/8) e
    * Buttons(2)=Encerrar (cmdSair, fecha o form e reabilita o pai). Geometria
    * e cores copiadas do dump (SigPrGf2_form_codigo_fonte.txt) -
    * Left=644/Top=-3/Width=160/Height=85 no grupo, botoes 75x75 em
    * Left=5/80. BINDEVENT do Click fica para a Fase 7/8 (junto com
    * mGeraGrafico/Report Form/fechamento), mesmo padrao de
    * FormSigPrGf1.ConfigurarBotoesAcao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesGrafico()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_CmdgGrafico", "CommandGroup")
            WITH THIS.obj_4c_CmdgGrafico
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Top           = -3
                .Left          = 644
                .Width         = 160
                .Height        = 85
                .Value         = 0
                .BorderColor   = RGB(136, 189, 188)
                .TabIndex      = 4
                .AutoSize      = .T.
                .Visible       = .T.

                WITH .Buttons(1)
                    *-- "\<Gr" + CHR(225) + "fico" - acelerador Alt+G do
                    *-- legado (Command1.Caption = "\<Gr醘ico" no dump,
                    *-- CHR(225)=a-acute corrompido na extracao em texto).
                    .Caption         = "\<Gr" + CHR(225) + "fico"
                    .Left            = 5
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                    .WordWrap        = .T.
                    .MousePointer    = 15
                ENDWITH

                WITH .Buttons(2)
                    *-- Cancel = .T. liga o ESC neste botao (nao tem
                    *-- acelerador "\<" no dump legado).
                    .Caption         = "Encerrar"
                    .Left            = 80
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .WordWrap        = .T.
                    .MousePointer    = 15
                    .Cancel          = .T.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesGrafico")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrf1 - cnt_4c_Grf1, container flutuante que hospeda o grafico
    * (obj_4c_OleGrafico1, OleBoundControl). Geometria e cores copiadas do
    * dump (SigPrGf2_form_codigo_fonte.txt): cntGrf1 Top=120/Left=17/
    * Width=770/Height=429/BackStyle=1/BackColor=branco; oleGrafico1 dentro
    * dele em Top=19/Left=5/Width=760/Height=390.
    *
    * Container comeca Visible=.F. (transcrito do Init legado -
    * ".cntGrf1.Visible = .f." ate mGeraGrafico terminar, ".t." depois) e por
    * isso NAO passa por TornarControlesVisiveis (ver filtro abaixo) - quem
    * vai alternar a visibilidade eh a logica de Init/mGeraGrafico da
    * Fase 7/8, igual ao padrao de FormSigReCmg.
    *
    * .ControlSource do OLE NAO eh setado aqui: o legado so faz
    * ".ControlSource = 'crGrafico1.gGrafico1s'" dentro de mGeraGrafico,
    * depois que o cursor crGrafico1 e o registro correspondente ja existem -
    * setar antes estouraria alias inexistente. Fica para a Fase 7/8.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrf1()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Grf1", "Container")
            WITH THIS.cnt_4c_Grf1
                .Top           = 120
                .Left          = 17
                .Width         = 770
                .Height        = 429
                .BackStyle     = 1
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.

                .AddObject("obj_4c_OleGrafico1", "OleBoundControl")
                WITH .obj_4c_OleGrafico1
                    .Top     = 19
                    .Left    = 5
                    .Width   = 760
                    .Height  = 390
                    .Visible = .T.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrf1")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrf2 - cnt_4c_Grf2, container flutuante que hospeda o combo de
    * selecao de chave do grafico (cbo_4c_CmbChave1 + lbl_4c_LblChave1).
    * Geometria e cores copiadas do dump (SigPrGf2_form_codigo_fonte.txt):
    * cntGrf2 Top=558/Left=559/Width=228/Height=35/BackStyle=1/BackColor=branco;
    * cmbChave1 Top=4/Left=129/Width=86/Height=25/Style=2 (dropdown list)/
    * ColumnCount=1/FontName="Courier New"; lblChave1 Top=9/Left=7/Width=94/
    * Height=15/AutoSize=.T./FontName="Tahoma"/FontSize=8/
    * ForeColor=RGB(90,90,90) (regra #12/canonico - Say sem ForeColor
    * declarado no legado, mas aqui o dump ja traz 90,90,90 explicito).
    *
    * Container comeca Visible=.F. (transcrito do Init legado -
    * ".cntGrf2.Visible = .f." tanto ANTES quanto DEPOIS de mGeraGrafico, isto
    * eh, o legado nunca exibe este container neste fluxo com uma unica
    * empresa/vendedor) e por isso NAO passa por TornarControlesVisiveis (ver
    * filtro abaixo), mesmo padrao de cnt_4c_Grf1/FormSigReCmg. Geometria e
    * conteudo do combo (AddItem/ListIndex/reposicionamento dinamico do
    * proprio cntGrf2) ficam para a Fase 7/8, dentro de mGeraGrafico - aqui
    * so a estrutura estatica do dump eh criada.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrf2()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Grf2", "Container")
            loc_oCnt = THIS.cnt_4c_Grf2
            WITH loc_oCnt
                .Top           = 558
                .Left          = 559
                .Width         = 228
                .Height        = 35
                .BackStyle     = 1
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            *-- .AddObject FORA do WITH do pai + WITH com caminho EXPLICITO
            *-- (nao ".filho" relativo) - WITH aninhado apos AddObject descarta
            *-- Caption/ForeColor em silencio (mesmo padrao de
            *-- ConfigurarCabecalho acima).
            loc_oCnt.AddObject("lbl_4c_LblChave1", "Label")
            WITH loc_oCnt.lbl_4c_LblChave1
                *-- .AutoSize = .F. embora o dump traga .T.: AutoSize eh no-op
                *-- em Label criado por AddObject (a Width fica no default 100)
                *-- e, com WordWrap, ainda DESCARTA a .Height. Width/Height
                *-- transcritos do SCX ja SAO o auto-size que o Form Designer
                *-- calculou, logo fixa-los eh reproducao fiel (regra #23).
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Grupo / Vendedor :"
                .Height    = 15
                .Left      = 7
                .Top       = 9
                .Width     = 94
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cbo_4c_CmbChave1", "ComboBox")
            WITH loc_oCnt.cbo_4c_CmbChave1
                .FontName    = "Courier New"
                .FontSize    = 9
                .ColumnCount = 1
                .Style       = 2
                .Height      = 25
                .Left        = 129
                .Top         = 4
                .Width       = 86
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrf2")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - cnt_4c_Aguarde, ultimo container estatico do dump
    * legado (cntAguarde): a caixinha branca "Aguarde... / Processando
    * Dados..." exibida enquanto o grafico eh gerado. Geometria e cores
    * copiadas do dump (SigPrGf2_form_codigo_fonte.txt): cntAguarde
    * Top=288/Left=312/Width=207/Height=49/BorderWidth=5/SpecialEffect=0/
    * BackColor=branco; Label1 "Aguarde..." Top=7/Left=69/Width=78/Height=18/
    * Verdana 10 bold/BackStyle=0/ForeColor=RGB(255,0,0); Label2 "Processando
    * Dados..." Top=24/Left=34/Width=159/Height=18/Verdana 10 bold/
    * FontCondense=.T./Alignment=0/BackStyle=0.
    *
    * Label2 NAO declara ForeColor no dump - canonico RGB(90,90,90)
    * (regra #12). Aqui os dois labels ficam sobre container OPACO branco,
    * entao ambos sao legiveis; RGB(90,90,90) mantem o padrao do projeto.
    *
    * Container comeca Visible=.F.: o Init legado o deixa .t. durante o
    * processamento e .f. ao terminar (".cntAguarde.Visible = .f." como
    * estado final), e o Click do combo faz o mesmo ciclo. Por isso NAO passa
    * por TornarControlesVisiveis - quem alterna eh CboChave1Click (e, na
    * Fase 7/8, o fluxo de Init/mGeraGrafico).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Aguarde", "Container")
            loc_oCnt = THIS.cnt_4c_Aguarde
            WITH loc_oCnt
                .Top           = 288
                .Left          = 312
                .Width         = 207
                .Height        = 49
                .BorderWidth   = 5
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            *-- .AddObject FORA do WITH do pai + WITH com caminho EXPLICITO
            *-- (nao ".filho" relativo) - WITH aninhado apos AddObject descarta
            *-- Caption/ForeColor em silencio.
            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                *-- .AutoSize = .F. embora o dump traga .T. (regra #23)
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Aguarde..."
                .Height    = 18
                .Left      = 69
                .Top       = 7
                .Width     = 78
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .AutoSize     = .F.
                .FontBold     = .T.
                .FontName     = "Verdana"
                .FontSize     = 10
                .FontCondense = .T.
                .Alignment    = 0
                .BackStyle    = 0
                .Caption      = "Processando Dados..."
                .Height       = 18
                .Left         = 34
                .Top          = 24
                .Width        = 159
                .ForeColor    = RGB(90, 90, 90)
                .Visible      = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - Liga por BINDEVENT os DOIS eventos que o SCX legado
    * tem no cmbChave1, e SO esses dois (o dump nao tem mais nenhum evento de
    * campo - zero Valid, zero KeyPress, zero LostFocus, zero lookup):
    *
    *   SIGPRGF2.cntGrf2.cmbChave1.Click    -> CboChave1Click
    *   SIGPRGF2.cntGrf2.cmbChave1.GotFocus -> CboChave1GotFocus
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
    * metodo PROTECTED. Nenhum dos dois eventos leva parametro, por isso os
    * handlers tambem nao declaram LPARAMETERS.
    *
    * Fase 7/8 (esta): BINDEVENT dos 2 botoes de obj_4c_CmdgGrafico -
    * Buttons(1) "Grafico" (cmdImprimir do legado) -> BtnGraficoClick,
    * Buttons(2) "Encerrar" (cmdSair do legado) -> BtnEncerrarClick.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "Click", ;
                THIS, "CboChave1Click")

            BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "GotFocus", ;
                THIS, "CboChave1GotFocus")

            BINDEVENT(THIS.obj_4c_CmdgGrafico.Buttons(1), "Click", ;
                THIS, "BtnGraficoClick")

            BINDEVENT(THIS.obj_4c_CmdgGrafico.Buttons(2), "Click", ;
                THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExecutarCargaInicial - Estados de visibilidade + primeira chamada de
    * MGeraGrafico(), equivalente ao trecho do Init legado entre o
    * "With ThisForm" e o ".Show()" final:
    *
    *   .cntAguarde.Visible = .t. / .cntGrf1.Visible = .f. /
    *   .cntGrf2.Visible = .f. / .cmdgGrafico.Visible = .f.
    *   .cntGrf2.cmbChave1.Clear
    *   .mGeraGrafico()
    *   .cntAguarde.Visible = .f. / .cntGrf1.Visible = .t. /
    *   .cntGrf2.Visible = .f. / .cmdgGrafico.Visible = .t.
    *   .cntGrf2.cmbChave1.ListIndex = 1
    *   .cntGrf2.cmbChave1.SetFocus
    *
    * DIVERGENCIA DELIBERADA: o legado intercala Refresh()/Show()/Draw() e
    * LockScreen .t./.f./.t. DUAS VEZES antes deste trecho, so para reduzir
    * flicker numa maquina antiga enquanto mostra a janela ainda com
    * "Aguarde..." antes de calcular o grafico. O estado VISIVEL final
    * (containers, combo populado no item 1, grafico desenhado) e o mesmo
    * se este metodo rodar por completo ANTES do THIS.Show() unico do
    * InicializarForm - por isso o dance de Show()/LockScreen intermediario
    * nao foi reproduzido (nao ha diferenca de ESTADO, so de flicker, sem
    * forma segura de testar flicker num harness headless). SetFocus final
    * do legado NAO eh chamado aqui: cnt_4c_Grf2 fica Visible = .F. nos dois
    * estados (ver comentario de ConfigurarGrf2 - o combo de selecao nunca
    * aparece neste fluxo) e SetFocus em controle dentro de container
    * invisivel estoura em runtime.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarCargaInicial()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible     = .T.
            THIS.cnt_4c_Grf1.Visible        = .F.
            THIS.cnt_4c_Grf2.Visible        = .F.
            THIS.obj_4c_CmdgGrafico.Visible = .F.

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear

            THIS.MGeraGrafico(1)

            THIS.cnt_4c_Aguarde.Visible     = .F.
            THIS.cnt_4c_Grf1.Visible        = .T.
            THIS.cnt_4c_Grf2.Visible        = .F.
            THIS.obj_4c_CmdgGrafico.Visible = .T.

            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarCargaInicial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PopularComboChaves - Preenche cbo_4c_CmbChave1 com as chaves distintas
    * do cursor de origem (this_oBusinessObject.PopularChaves(), Fase 1/2 ja
    * completa) e reposiciona/redimensiona cnt_4c_Grf2, replicando o bloco
    * "If Empty(.cntGrf2.cmbChave1.ListCount)" do mgeragrafico legado (linhas
    * 420-467 do dump). So roda de fato UMA vez por form (guard pelo proprio
    * ListCount) - chamadas seguintes de MGeraGrafico() so pulam este bloco,
    * igual ao "If Empty(...)" do legado.
    *
    * m.lnTmStr1 do legado (Len(laVendedor(1)), 1o elemento do array
    * Select Distinct SEM AllTrim - cEmps eh char de largura fixa, entao
    * todos os elementos tem o MESMO Len) vira aqui o MAIOR comprimento
    * entre as chaves ja TRIMADAS por PopularChaves (regra #22/PILAR 3: o BO
    * ja decidiu usar ALLTRIM na Fase 1/2, entao os comprimentos podem
    * variar) - o maior valor preserva o alinhamento em coluna do PadR
    * usado no AddItem.
    *==========================================================================
    PROTECTED PROCEDURE PopularComboChaves()
        LOCAL loc_oCnt, loc_oCombo, loc_oLabel, loc_nTamanho, loc_cAlias, loc_oErro

        loc_oCnt   = THIS.cnt_4c_Grf2
        loc_oCombo = loc_oCnt.cbo_4c_CmbChave1
        loc_oLabel = loc_oCnt.lbl_4c_LblChave1

        IF loc_oCombo.ListCount > 0
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.PopularChaves()
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorChaves

                loc_nTamanho = 1
                SELECT (loc_cAlias)
                SCAN
                    loc_nTamanho = MAX(loc_nTamanho, LEN(ALLTRIM(Chaves)))
                ENDSCAN

                *-- Legado: With .cntGrf2 / With .lblChave1 / .Left=5 / .Top=10
                loc_oLabel.Left = 5
                loc_oLabel.Top  = 10

                loc_oCombo.Clear
                loc_oCombo.Alignment         = 0
                loc_oCombo.ColumnCount       = 0
                loc_oCombo.ColumnLines       = .F.
                loc_oCombo.IncrementalSearch = .T.
                loc_oCombo.FontName          = "Courier New"
                loc_oCombo.FontSize          = 9
                loc_oCombo.RowSourceType     = 0
                loc_oCombo.Style             = 2
                loc_oCombo.ReadOnly          = .T.
                loc_oCombo.Format            = "K"
                loc_oCombo.Sorted            = .F.
                loc_oCombo.SpecialEffect     = 0
                loc_oCombo.Width             = (loc_nTamanho * 7 + 9) + 20
                loc_oCombo.Height            = 25
                loc_oCombo.Top               = 5
                loc_oCombo.Left              = 5 + loc_oLabel.Width

                SELECT (loc_cAlias)
                GO TOP
                SCAN
                    loc_oCombo.AddItem(PADR(ALLTRIM(Chaves), loc_nTamanho))
                ENDSCAN

                loc_oCnt.Height = loc_oCombo.Height + 10
                loc_oCnt.Width  = loc_oLabel.Width + loc_oCombo.Width + 10
                loc_oCnt.Top    = THIS.obj_4c_CmdgGrafico.Top - loc_oCnt.Height
                loc_oCnt.Left   = THIS.Width - loc_oCnt.Width - 5
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PopularComboChaves")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MGeraGrafico - Equivalente ao mgeragrafico legado (LParameters
    * lnLinhaCmb1): popula o combo de chaves na PRIMEIRA chamada
    * (PopularComboChaves, guardado pelo proprio ListCount), valida a linha
    * recebida (ValidarLinhaChave - gate "If .cntGrf2.cmbChave1.ListCount>0"
    * do legado), pede ao BO os dados da chave selecionada
    * (this_oBusinessObject.GerarGrafico) e, se OK, desenha o MSGraph.Chart
    * no OleBoundControl (DesenharGrafico).
    *
    * Fonte UNICA de geracao - chamado por ExecutarCargaInicial() (migracao
    * do ".mGeraGrafico()" dentro do Init legado) e por CboChave1Click()
    * (migracao do ".mGeraGrafico(.cntGrf2.cmbChave1.ListIndex)" dentro do
    * Click legado do combo), sem duplicar a logica nos dois lugares.
    *==========================================================================
    PROTECTED PROCEDURE MGeraGrafico(par_nLinha)
        LOCAL loc_nLinha, loc_cChave, loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            THIS.PopularComboChaves()

            loc_nLinha = THIS.ValidarLinhaChave(par_nLinha)

            IF loc_nLinha > 0
                loc_cChave = THIS.ObterChaveSelecionada(loc_nLinha)

                IF !EMPTY(loc_cChave)
                    IF THIS.this_oBusinessObject.GerarGrafico(loc_cChave)
                        loc_lResultado = THIS.DesenharGrafico()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em MGeraGrafico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DesenharGrafico - Renderiza o grafico (MSGraph.Chart) no
    * OleBoundControl para a chave que this_oBusinessObject.GerarGrafico() ja
    * calculou. Mantem this_cCursorOleGrafico ("cursor_4c_OleGrafico1"),
    * cache LOCAL do binario do grafico por chave - equivalente ao crGrafico1
    * do legado (gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
    * ctitulo1s c(128)). O BO nao guarda esse binario (PILAR 3: BO nao
    * manipula OLE) - so o texto (labels/series), ja em
    * this_oBusinessObject.this_cLabelsMeses/this_cSerieFalha/
    * this_cSerieRecuperacao.
    *
    * Transcricao de mgeragrafico legado (linhas 486-634 do dump): Locate
    * por chave no cursor de cache -> achou (cache hit) => so reposiciona o
    * registro corrente e faz Refresh (o ControlSource fixo em
    * "<cursor>.gGrafico1s" reflete o registro corrente); nao achou => monta
    * o General a partir das series do BO (mesmo layout Data() do legado:
    * lcStrg1+CRLF+lcStrg2+CRLF+lcStrg3 = this_cLabelsMeses/this_cSerieFalha/
    * this_cSerieRecuperacao) e aplica toda a formatacao do chart.
    *==========================================================================
    PROTECTED PROCEDURE DesenharGrafico()
        LOCAL loc_oBO, loc_oOle, loc_cChavePad, loc_cDataChart, loc_nGrupo, ;
              loc_nMes, loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle

        loc_lResultado = .F.
        loc_lFalhaOle  = .F.
        loc_oBO        = THIS.this_oBusinessObject
        loc_oOle       = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1

        TRY
            IF !USED(THIS.this_cCursorOleGrafico)
                CREATE CURSOR (THIS.this_cCursorOleGrafico) ;
                    (gGrafico1s G(4), cChave1s C(100), cEmpresas C(254), cTitulo1s C(128))
                INDEX ON cChave1s TAG cChave1s
            ENDIF

            loc_cChavePad = PADR(ALLTRIM(loc_oBO.this_cChaveAtual), 100)

            SELECT (THIS.this_cCursorOleGrafico)
            LOCATE FOR cChave1s == loc_cChavePad

            IF !FOUND()
                loc_cDataChart = loc_oBO.this_cLabelsMeses + CHR(13) + CHR(10) + ;
                    loc_oBO.this_cSerieFalha + CHR(13) + CHR(10) + ;
                    loc_oBO.this_cSerieRecuperacao

                *-- INSERT/APPEND GENERAL isolados num TRY proprio: se o OLE
                *-- server "MSGraph.Chart" nao estiver registrado na maquina
                *-- (medido: OLE error 0x800401f3 "Cadeia de caracteres de
                *-- classe invalida"), a linha de cache JA FOI inserida antes
                *-- do APPEND GENERAL estourar - sem desfazer, a PROXIMA
                *-- chamada para a MESMA chave acharia essa linha via LOCATE
                *-- (FOUND()=.T.) e trataria como cache HIT, nunca mais
                *-- tentando desenhar (gGrafico1s ficaria para sempre vazio,
                *-- sem erro nenhum). Por isso a linha eh apagada no CATCH.
                TRY
                    INSERT INTO (THIS.this_cCursorOleGrafico) (cChave1s, cTitulo1s, cEmpresas) ;
                        VALUES (loc_cChavePad, LEFT(loc_oBO.this_cTitulo1, 128), loc_oBO.this_cEmpresaAtual)

                    APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cDataChart)
                CATCH TO loc_oErroOle
                    loc_lFalhaOle = .T.

                    SELECT (THIS.this_cCursorOleGrafico)
                    LOCATE FOR cChave1s == loc_cChavePad
                    IF FOUND()
                        DELETE
                    ENDIF

                    loc_oBO.this_cMensagemErro = loc_oErroOle.Message
                ENDTRY
            ENDIF

            IF !FOUND() AND !loc_lFalhaOle
                *-- So chega aqui com o APPEND GENERAL acima OK: aplica o
                *-- ControlSource e toda a formatacao (Font/Interior/Border/
                *-- Axes/ChartGroups) do chart recem-criado.
                loc_oOle.ControlSource = THIS.this_cCursorOleGrafico + ".gGrafico1s"

                WITH loc_oOle
                    .AutoActivate    = 0
                    .AutoSize        = .T.
                    .Height          = .Height
                    .Left            = .Left
                    .Sizable         = .T.
                    .Stretch         = 2
                    .Top             = .Top
                    .Width           = .Width
                    .HasLegend       = .T.
                    .HasTitle        = .T.
                    .DisplayBlanksAs = 1
                    .HasAxis(2)      = .T.
                    .Type            = -4100
                    .SubType         = 1

                    WITH .ChartArea
                        .Font.Name        = "Arial"
                        .Font.Size        = 8
                        .Font.Bold        = .T.
                        .Font.Italic      = .F.
                        .Interior.Color   = RGB(255, 255, 255)
                        .Border.Color     = RGB(0, 0, 0)
                        .Border.LineStyle = 1
                        .Border.Weight    = 2
                        .Shadow           = .T.
                    ENDWITH

                    WITH .PlotArea
                        .Interior.Color = RGB(255, 255, 255)
                        .Border.Color   = RGB(0, 0, 0)
                    ENDWITH

                    WITH .ChartTitle
                        .Font.Name   = "Arial"
                        .Font.Size   = 9
                        .Font.Bold   = .T.
                        .Font.Italic = .F.
                        .Text        = loc_oBO.this_cTitulo1
                    ENDWITH

                    WITH .Legend
                        .Font.Name   = "Arial"
                        .Font.Size   = 8
                        .Font.Bold   = .T.
                        .Font.Italic = .F.
                        .Position    = 1
                        .Shadow      = .T.
                    ENDWITH

                    WITH .Axes(1)
                        .HasTitle               = .T.
                        .AxisTitle.Caption      = "Meses"
                        .AxisTitle.Font.Name    = "Arial"
                        .AxisTitle.Font.Size    = 8
                        .AxisTitle.Font.Bold    = .T.
                        .AxisTitle.Font.Italic  = .F.
                        .AxisTitle.Orientation  = 0
                        .ReversePlotOrder       = .F.
                        .TickLabels.Orientation = 0

                        WITH .TickLabels.Font
                            .Name          = "Small Fonts"
                            .Bold          = .F.
                            .Size          = 7
                            .Strikethrough = .F.
                            .Superscript   = .F.
                            .Subscript     = .F.
                            .OutlineFont   = .F.
                            .Shadow        = .F.
                        ENDWITH
                    ENDWITH

                    WITH .Axes(2)
                        .HasTitle                = .F.
                        .ReversePlotOrder        = .F.
                        .HasMajorGridLines       = .T.
                        .HasMinorGridlines       = .F.
                        .MinimumScaleIsAuto      = .T.
                        .MaximumScaleIsAuto      = .T.
                        .TickLabels.Orientation  = 0
                        .TickLabels.NumberFormat = "###,###,##0.00"

                        WITH .TickLabels.Font
                            .Name          = "Arial"
                            .Bold          = .T.
                            .Size          = 8
                            .Strikethrough = .F.
                            .Superscript   = .F.
                            .Subscript     = .F.
                            .OutlineFont   = .F.
                            .Shadow        = .F.
                        ENDWITH
                    ENDWITH

                    WITH .ChartGroups(1)
                        .HasSeriesLines = .F.
                        .GapWidth       = 10
                        .Overlap        = (.GapWidth / 2 * -1)

                        FOR loc_nGrupo = 1 TO loc_oBO.this_nTotalGrupos
                            IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ChartGroups(1).SeriesCollection(m.loc_nGrupo)") == "O"
                                WITH .SeriesCollection(loc_nGrupo)
                                    .ApplyDataLabels      = .T.
                                    .ApplyDataLabels.Type = 2

                                    FOR loc_nMes = 1 TO loc_oBO.this_nTotalMeses
                                        IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ChartGroups(1).SeriesCollection(m.loc_nGrupo).Points(m.loc_nMes).DataLabel") == "O"
                                            WITH .PointsDataLabel
                                                .Top          = .Top - 10
                                                .NumberFormat = "###,###,##0.00"
                                                .Font.Name    = "Arial"
                                                .Font.Size    = 8
                                                .Font.Bold    = .T.
                                                .Font.Shadow  = .F.
                                            ENDWITH
                                        ENDIF
                                    ENDFOR
                                ENDWITH
                            ENDIF
                        ENDFOR
                    ENDWITH

                    .Refresh
                ENDWITH
            ELSE
                IF !loc_lFalhaOle
                    *-- Cache HIT de verdade (achou na LOCATE original, antes
                    *-- do bloco de criacao acima rodar) - so reposiciona o
                    *-- ControlSource; o registro corrente ja esta certo.
                    loc_oOle.ControlSource = THIS.this_cCursorOleGrafico + ".gGrafico1s"
                ENDIF
            ENDIF

            IF !loc_lFalhaOle
                loc_oOle.Refresh
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em DesenharGrafico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarLinhaChave - Guarda que o legado aplica ao indice do combo antes
    * de usa-lo, transcrita do mGeraGrafico (duas linhas, nao uma):
    *
    *   m.lnLinhaCmb1 = Iif((Type('m.lnLinhaCmb1')=='N'.And.m.lnLinhaCmb1>0), ;
    *                        m.lnLinhaCmb1,1)
    *   ...
    *   If .cntGrf2.cmbChave1.ListCount>0
    *
    * Devolve 0 quando o combo ainda nao tem item nenhum (gate do ListCount:
    * nada a selecionar, nada a gerar) e, quando tem, o indice normalizado -
    * valor nao numerico ou <= 0 vira 1, exatamente como o Iif do legado.
    *
    * Sem TRY/CATCH de proposito: so le propriedades do proprio combo e faz
    * aritmetica; quem chama (CboChave1Click) ja roda dentro de TRY/CATCH.
    *==========================================================================
    PROCEDURE ValidarLinhaChave(par_nLinha)
        LOCAL loc_nLinha, loc_nTotal

        loc_nTotal = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount

        IF VARTYPE(loc_nTotal) != "N" OR loc_nTotal <= 0
            RETURN 0
        ENDIF

        loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" AND par_nLinha > 0, par_nLinha, 1)

        RETURN loc_nLinha
    ENDPROC

    *==========================================================================
    * ObterChaveSelecionada - Le o item do combo correspondente a linha ja
    * validada. Transcricao de "m.lcChave1 =
    * .cntGrf2.cmbChave1.List(m.lnLinhaCmb1)" do mGeraGrafico legado.
    *
    * O BETWEEN protege o .List() de indice fora de faixa - no legado esse
    * caso caia no "On Error m.llError = .f." que o mGeraGrafico instala e
    * seguia em silencio; aqui devolve string vazia e o chamador simplesmente
    * nao gera grafico, sem alterar valor nenhum.
    *
    * ALLTRIM aqui casa com o contrato do BO: os itens do combo sao gravados
    * com PadR (mGeraGrafico legado) e SigPrGf2BO.GerarGrafico compara com
    * ALLTRIM dos dois lados (ALLTRIM(cEmps) == ALLTRIM(par_cChave)).
    *==========================================================================
    PROCEDURE ObterChaveSelecionada(par_nLinha)
        LOCAL loc_cChave, loc_oCombo

        loc_cChave = ""
        loc_oCombo = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1

        IF VARTYPE(par_nLinha) = "N" AND BETWEEN(par_nLinha, 1, loc_oCombo.ListCount)
            loc_cChave = ALLTRIM(loc_oCombo.List(par_nLinha))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * CboChave1Click - Handler do Click do combo "Grupo / Vendedor :".
    * Transcricao do PROCEDURE Click legado (SIGPRGF2.cntGrf2.cmbChave1):
    *
    *   .cntAguarde.Visible = .t. / .Refresh / .Draw / .LockScreen = .t.
    *   .SetAll('Enabled',.f.,'Oleboundcontrol')
    *   .mGeraGrafico(.cntGrf2.cmbChave1.ListIndex)
    *   .cntGrf2.cmbChave1.SetFocus
    *   .cntAguarde.Visible = .f. / .Refresh / .Draw / .LockScreen = .f.
    *
    * A parte de DADOS do mGeraGrafico eh SigPrGf2BO.GerarGrafico (completo
    * desde a Fase 2); a parte de DESENHO (Append General + ControlSource do
    * OleBoundControl + propriedades do MSGraph) entra na Fase 7/8.
    *
    * PUBLIC (sem PROTECTED): exigencia do BINDEVENT.
    *
    * A mensagem de falha eh exibida DEPOIS do ENDTRY, com a tela ja
    * destravada - dialogo aberto com LockScreen = .T. deixa a janela
    * congelada por tras. O LockScreen = .F. mora no FINALLY para valer
    * tambem quando o CATCH dispara.
    *==========================================================================
    PROCEDURE CboChave1Click()
        LOCAL loc_cAviso, loc_oErro

        loc_cAviso = ""

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.Draw()
            THIS.LockScreen = .T.

            *-- Legado: .SetAll('Enabled',.f.,'Oleboundcontrol') - congela o
            *-- grafico atual enquanto o novo eh calculado.
            THIS.SetAll("Enabled", .F., "OleBoundControl")

            *-- Legado: .mGeraGrafico(.cntGrf2.cmbChave1.ListIndex) - fonte
            *-- unica com ExecutarCargaInicial() (ver MGeraGrafico acima).
            IF !THIS.MGeraGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
                loc_cAviso = THIS.this_oBusinessObject.this_cMensagemErro
            ENDIF

            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Refresh()
            THIS.Draw()

            *-- SetFocus so com o container visivel e o combo habilitado -
            *-- SetFocus em controle invisivel/desabilitado dispara erro.
            IF THIS.cnt_4c_Grf2.Visible AND ;
               THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Visible AND ;
               THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CboChave1Click")
        FINALLY
            THIS.LockScreen = .F.
        ENDTRY

        IF !EMPTY(loc_cAviso)
            MsgAviso(loc_cAviso, "Gr" + CHR(225) + "fico")
        ENDIF
    ENDPROC

    *==========================================================================
    * CboChave1GotFocus - Handler do GotFocus do combo. Transcricao literal do
    * PROCEDURE GotFocus legado, que tem UMA linha:
    *
    *   ThisForm.SetAll('Enabled',.f.,'Oleboundcontrol')
    *
    * PUBLIC (sem PROTECTED): exigencia do BINDEVENT.
    *==========================================================================
    PROCEDURE CboChave1GotFocus()
        LOCAL loc_oErro

        TRY
            THIS.SetAll("Enabled", .F., "OleBoundControl")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CboChave1GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnGraficoClick - Buttons(1) "Grafico" do obj_4c_CmdgGrafico. Transcricao
    * do cmdImprimir.Click legado:
    *
    *   Local lnRecno1
    *   With ThisForm
    *       .LockScreen = .t.
    *       m.lnRecno1 = RecNo('crGrafico1')
    *       Select ('crGrafico1')
    *       Report Form SigPrGf1 Next 1 To Printer Prompt Noconsole
    *       If BetWeen(m.lnRecno1,1,RecCount('crGrafico1'))
    *           GoTo m.lnRecno1 In ('crGrafico1')
    *       EndIf
    *       .cntGrf2.cmbChave1.SetFocus
    *       .Refresh / .Draw / .LockScreen = .f.
    *   EndWith
    *
    * crGrafico1 -> this_cCursorOleGrafico (cursor_4c_OleGrafico1, criado em
    * DesenharGrafico()). Guard IF FILE(...) antes do REPORT FORM (regra
    * CLAUDE.md sobre .Picture/.frx ausente falhar em silencio e sobre o
    * helper canonico de REPORT FORM) - SigPrGf1.frx nao existe no acervo
    * (nem em origem\, nem no historico do git): a impressao real so
    * funciona quando o arquivo for adicionado a
    * projeto\app\reports\SigPrGf1.frx; ate la o usuario ve o aviso
    * descritivo em vez de um erro cru do VFP ou, peor, silencio total.
    *==========================================================================
    PROCEDURE BtnGraficoClick()
        LOCAL loc_nRecnoAtual, loc_cFrx, loc_oErro

        TRY
            THIS.LockScreen = .T.

            loc_nRecnoAtual = RECNO(THIS.this_cCursorOleGrafico)

            SELECT (THIS.this_cCursorOleGrafico)

            loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")

            IF !FILE(loc_cFrx)
                MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + loc_cFrx, "Erro")
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigPrGf1") NEXT 1 TO PRINTER PROMPT NOCONSOLE
            ENDIF

            IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT(THIS.this_cCursorOleGrafico))
                GO loc_nRecnoAtual IN (THIS.this_cCursorOleGrafico)
            ENDIF

            *-- SetFocus so com o container visivel e o combo habilitado -
            *-- SetFocus em controle invisivel/desabilitado dispara erro.
            IF THIS.cnt_4c_Grf2.Visible AND ;
               THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Visible AND ;
               THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            ENDIF

            THIS.Refresh()
            THIS.Draw()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnGraficoClick")
        FINALLY
            THIS.LockScreen = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Buttons(2) "Encerrar" do obj_4c_CmdgGrafico.
    * Transcricao do cmdSair.Click legado:
    *
    *   With ThisForm
    *       .LockScreen = .t.
    *       .cntGrf1.oleGrafico1.ControlSource = ''
    *       If Used('crGrafico1')
    *           Use In ('crGrafico1')
    *       EndIf
    *       .Release / .Refresh / .LockScreen = .f.
    *       If Type('ThisForm.poForm1')=='O'
    *           .poForm1.LockScreen = .t.
    *           .poForm1.Enabled = .t.
    *           .poForm1.LockScreen = .f.
    *       EndIf
    *   EndWith
    *
    * poForm1 -> this_oFormPai. Guard adicional (!= THIS) para o caso deste
    * form ter sido aberto SEM form pai (Init: this_oFormPai = THIS quando
    * par_loForm1 nao eh objeto) - nesse caso nao ha ninguem para reabilitar.
    * crRel1 (cursor global do form pai) NAO eh fechado aqui - ver Destroy().
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""

            IF USED(THIS.this_cCursorOleGrafico)
                USE IN (THIS.this_cCursorOleGrafico)
            ENDIF

            THIS.Release()
            THIS.Refresh()
            THIS.LockScreen = .F.

            IF VARTYPE(THIS.this_oFormPai) = "O" AND !(THIS.this_oFormPai == THIS)
                THIS.this_oFormPai.LockScreen = .T.
                THIS.this_oFormPai.Enabled    = .T.
                THIS.this_oFormPai.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao)
    *
    * FILTRO: cnt_4c_Grf1/cnt_4c_Grf2/cnt_4c_Aguarde sao containers flutuantes
    * (Visible controlado pelo Init/mGeraGrafico e por CboChave1Click - ver
    * comentarios de ConfigurarGrf1/ConfigurarGrf2/ConfigurarAguarde), nao
    * pelo TornarControlesVisiveis generico. Mesmo padrao de FormSigReCmg.
    *
    * O skip RECURSA antes do LOOP: o LOOP preserva o Visible = .F. do
    * PROPRIO container (que eh o que se quer), mas os FILHOS dele precisam
    * ficar Visible = .T., senao o container aparece VAZIO quando o codigo o
    * exibe (CorretorAutomatico #109). Aqui os filhos ja nascem com
    * .Visible = .T. explicito nos Configurar*, e a recursao mantem isso
    * verdadeiro mesmo se algum filho for acrescentado sem o .Visible.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_GRF1", "CNT_4C_GRF2", "CNT_4C_AGUARDE")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
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

    *==========================================================================
    * Destroy - Fecha this_cCursorOleGrafico (cache local do binario do OLE -
    * BtnEncerrarClick ja fecha no fluxo normal, mas Destroy pode disparar por
    * outro caminho, ex.: pai chamando .Release() direto em vez do botao) e
    * solta a referencia do Business Object (SigPrGf2BO.Destroy() fecha
    * this_cCursorChaves/this_cCursorGrafico, cursores locais que nunca tocam
    * SQL Server). O cursor global "crRel1" NAO eh fechado aqui: quem o cria
    * eh o form pai (FormSigPrGf1), e eh ele quem o fecha no proprio Destroy -
    * fechar aqui derrubaria o cursor debaixo do pai se o usuario fechar o
    * grafico e processar outro periodo em seguida.
    *==========================================================================
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorOleGrafico) AND USED(THIS.this_cCursorOleGrafico)
            USE IN (THIS.this_cCursorOleGrafico)
        ENDIF

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*============================================================================
* SigPrGf2BO.prg - Business Object para "Grafico de Falha X Recuperacao
* Mensal" (SIGPRGF2)
*
* Form OPERACIONAL (SIGPRGF2 / FormSigPrGf2): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form pai (equivalente ao
* SIGPRGF1/FormSigPrGf1) que ja processou e deixou pronto um cursor agregado
* por mes (crRel1 no legado; normalmente SigPrGf1BO.this_cCursorResultado no
* sistema novo). O SIGPRGF2 nao processa dados novos contra o banco - ele so
* agrupa/formata o que ja veio no cursor de origem, monta as series do
* grafico (Falha/Recuperacao) por mes e mantem um cache por chave (empresa)
* para nao recalcular ao trocar no combo.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf2BO AS BusinessBase

    *==========================================================================
    * Cursor de origem (crRel1 do legado) - resultado agregado por mes,
    * fornecido pelo form pai. NAO e populado por este BO; apenas consultado
    * (Select Distinct .../ Scan While ... do mGeraGrafico legado).
    *==========================================================================
    this_cCursorOrigem = ""

    *==========================================================================
    * Cursor com as chaves distintas do cursor de origem, para popular o
    * combo "Grupo / Vendedor :" (cmbChave1 - equivalente a "Select Distinct
    * a.cEmps From crRel1 a Order By 1 Into Array laVendedor" do legado).
    * Usamos cursor em vez de ARRAY para nao depender de escopo de m.array.
    *==========================================================================
    this_cCursorChaves = ""

    *==========================================================================
    * Cursor cache dos graficos ja gerados por chave (equivalente a
    * crGrafico1: gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
    * ctitulo1s c(128)). A parte binaria do OLE (Append General ... Class
    * 'MSGraph.Chart') e responsabilidade do Form (glue com o OleBoundControl);
    * este BO cuida so da chave/titulos/series text-based.
    *==========================================================================
    this_cCursorGrafico = ""

    *==========================================================================
    * Chave (empresa) atualmente selecionada no combo (cChave1s do legado)
    *==========================================================================
    this_cChaveAtual = ""

    *==========================================================================
    * Titulos do grafico da chave atual (cTitulo1s/ctitulo2s do cursor de
    * origem - mGeraGrafico monta m.lcTitulo1 = AllTrim(cTitulo1s) + Chr(13)
    * + AllTrim(ctitulo2s))
    *==========================================================================
    this_cTitulo1      = ""
    this_cTitulo2      = ""
    this_cEmpresaAtual = ""

    *==========================================================================
    * Series do grafico (lnNgrupos fixo = 2: Falha e Recuperacao) e a
    * contagem de meses agregados na chave atual (lnNmeses)
    *==========================================================================
    this_nTotalGrupos = 2
    this_nTotalMeses  = 0

    *==========================================================================
    * Strings TAB-separadas com rotulos de mes e valores das duas series
    * (lcStrg1/lcStrg2/lcStrg3 do mGeraGrafico legado). O Form usa essas
    * strings para montar o Data() do Append General no OleBoundControl.
    *==========================================================================
    this_cLabelsMeses      = ""
    this_cSerieFalha       = ""
    this_cSerieRecuperacao = ""

    *==========================================================================
    * Flags de estado
    *==========================================================================
    this_lChaveEmCache  = .F.  && .T. quando a chave ja tinha grafico no cache (Locate achou)
    this_lGraficoGerado = .F.  && .T. quando ha dados validos para desenhar o grafico

    *==========================================================================
    * Init - Nao ha tabela proprietaria (form so exibe/agrega o que o form
    * pai processou), entao this_cTabela/this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho deste BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCursorChaves  = "cursor_4c_Chaves"
            THIS.this_cCursorGrafico = "cursor_4c_Grafico"

            THIS.this_nTotalGrupos = 2
            THIS.this_nTotalMeses  = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de arquitetura (Fase 2 - CRUD): SIGPRGF2 eh um VISUALIZADOR de
    * grafico (Falha X Recuperacao Mensal) que so agrega/formata o cursor de
    * origem (crRel1 no legado, this_cCursorOrigem aqui) recebido do form pai
    * (equivalente ao SigPrGf1). O dump do legado nao tem NENHUM Insert
    * Into/Update/Delete From contra tabela do SQL Server: o unico Insert Into
    * do metodo mgeragrafico grava no cursor LOCAL crGrafico1 (cache de
    * graficos ja montados por chave), que aqui vira THIS.this_cCursorGrafico
    * dentro de GerarGrafico(). CarregarDoCursor() mapeia as colunas desse
    * cache; Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos
    * neste BO porque o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para um BO sem tabela proprietaria.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia uma linha do cursor de cache de graficos
    * (this_cCursorGrafico, layout identico ao crGrafico1 legado) para as
    * propriedades do BO. Usado apos LOCATE/SEEK em GerarGrafico() ou por
    * quem precisar inspecionar uma linha ja posicionada do cache.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cChaveAtual      = ALLTRIM(TratarNulo(cChave1s, ""))
            THIS.this_cEmpresaAtual    = TratarNulo(cEmpresas, "")
            THIS.this_cTitulo1         = TratarNulo(cTitulo1s, "")
            THIS.this_cLabelsMeses     = TratarNulo(cLabelsMeses, "")
            THIS.this_cSerieFalha      = TratarNulo(cSerieFalha, "")
            THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
            THIS.this_nTotalMeses      = OCCURS(CHR(9), THIS.this_cLabelsMeses)

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do grafico atualmente selecionado (equivalente
    * ao cChave1s do cache legado). Nao ha tabela proprietaria neste BO; a
    * chave existe so para identificar a linha do cache de graficos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChaveAtual)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularChaves - Monta THIS.this_cCursorChaves com as chaves distintas do
    * cursor de origem (equivalente a "Select Distinct a.cEmps From crRel1
    * Order By 1 Into Array laVendedor" do mGeraGrafico legado). O Form usa
    * este cursor para popular o combo "Grupo / Vendedor :" (cmbChave1).
    *--------------------------------------------------------------------------
    PROCEDURE PopularChaves()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorChaves)
                    USE IN (THIS.this_cCursorChaves)
                ENDIF

                SELECT DISTINCT ALLTRIM(cEmps) AS Chaves ;
                    FROM (THIS.this_cCursorOrigem) ;
                    ORDER BY 1 ;
                    INTO CURSOR (THIS.this_cCursorChaves) READWRITE

                IF RECCOUNT(THIS.this_cCursorChaves) > 0
                    GO TOP IN (THIS.this_cCursorChaves)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Equivalente ao mGeraGrafico legado (parte de dados: o
    * desenho do OLE/MSGraph.Chart fica por conta do Form). Se a chave ja
    * esta no cache (this_cCursorGrafico), so recarrega as propriedades a
    * partir dele (LOCATE, igual ao "Locate For crGrafico1.cChave1s==..." do
    * legado). Senao, varre this_cCursorOrigem (equivalente ao "Scan While
    * crRel1.cEmps==m.lcChave1" do legado), monta os rotulos de mes e as duas
    * series (Falha/Recuperacao) separados por TAB e grava a linha nova no
    * cache - so entao Insert Into acontece, e sempre no cursor LOCAL, nunca
    * no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE GerarGrafico(par_cChave)
        LOCAL loc_lResultado, loc_oErro, loc_cChavePad, loc_cTitulo1, ;
              loc_cEmpresa, loc_cLabelsMeses, loc_cSerieFalha, ;
              loc_cSerieRecuperacao, loc_nMeses, loc_cPointAntigo, ;
              loc_cSeparAntigo

        loc_lResultado           = .F.
        THIS.this_lChaveEmCache  = .F.
        THIS.this_lGraficoGerado = .F.

        TRY
            IF EMPTY(par_cChave) OR !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada ou cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cChavePad = PADR(ALLTRIM(par_cChave), 100)
                THIS.this_cChaveAtual = ALLTRIM(par_cChave)

                IF !USED(THIS.this_cCursorGrafico)
                    CREATE CURSOR (THIS.this_cCursorGrafico) ;
                        (cChave1s C(100), cEmpresas C(254), cTitulo1s M, ;
                         cLabelsMeses M, cSerieFalha M, cSerieRecuperacao M)
                    INDEX ON cChave1s TAG cChave1s
                ENDIF

                SELECT (THIS.this_cCursorGrafico)
                LOCATE FOR cChave1s == loc_cChavePad

                IF FOUND()
                    THIS.this_lChaveEmCache     = .T.
                    THIS.this_cEmpresaAtual     = TratarNulo(cEmpresas, "")
                    THIS.this_cTitulo1          = TratarNulo(cTitulo1s, "")
                    * cTitulo2s nao existe no cache (crGrafico1 legado so guarda
                    * o titulo ja concatenado) - fica vazio ate a proxima geracao
                    THIS.this_cTitulo2          = ""
                    THIS.this_cLabelsMeses      = TratarNulo(cLabelsMeses, "")
                    THIS.this_cSerieFalha       = TratarNulo(cSerieFalha, "")
                    THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
                    THIS.this_nTotalMeses       = OCCURS(CHR(9), THIS.this_cLabelsMeses)
                    THIS.this_lGraficoGerado    = .T.
                    loc_lResultado = .T.
                ELSE
                    SELECT (THIS.this_cCursorOrigem)
                    LOCATE FOR ALLTRIM(cEmps) == ALLTRIM(par_cChave)

                    IF !FOUND()
                        THIS.this_cMensagemErro = "Nenhum registro encontrado para a chave [" + ALLTRIM(par_cChave) + "]."
                    ELSE
                        loc_cTitulo1 = ALLTRIM(cTitulo1s) + CHR(13) + ALLTRIM(cTitulo2s)
                        THIS.this_cTitulo2 = ALLTRIM(TratarNulo(cTitulo2s, ""))
                        loc_cEmpresa = TratarNulo(cEmpresas, "")

                        loc_cLabelsMeses      = ""
                        loc_cSerieFalha       = "Falha"
                        loc_cSerieRecuperacao = "Recupera" + CHR(231) + CHR(227) + "o"
                        loc_nMeses = 0

                        * Isolamento de locale igual ao mGeraGrafico legado -
                        * TRANSFORM abaixo usa picture fixa "999,999,999.99"
                        loc_cPointAntigo = SET("POINT")
                        loc_cSeparAntigo = SET("SEPARATOR")
                        SET POINT TO ","
                        SET SEPARATOR TO "."

                        TRY
                            SCAN WHILE ALLTRIM(cEmps) == ALLTRIM(par_cChave)
                                loc_nMeses = loc_nMeses + 1
                                loc_cLabelsMeses      = loc_cLabelsMeses + CHR(9) + ALLTRIM(TratarNulo(cStranomes, ""))
                                loc_cSerieFalha       = loc_cSerieFalha + CHR(9) + ALLTRIM(TRANSFORM(NVL(nFalhas, 0), "999,999,999.99"))
                                loc_cSerieRecuperacao = loc_cSerieRecuperacao + CHR(9) + ALLTRIM(TRANSFORM(NVL(nPesoccbs, 0), "999,999,999.99"))
                            ENDSCAN
                        FINALLY
                            SET POINT TO (loc_cPointAntigo)
                            SET SEPARATOR TO (loc_cSeparAntigo)
                        ENDTRY

                        SELECT (THIS.this_cCursorGrafico)
                        INSERT INTO (THIS.this_cCursorGrafico) ;
                            (cChave1s, cEmpresas, cTitulo1s, cLabelsMeses, cSerieFalha, cSerieRecuperacao) ;
                            VALUES (loc_cChavePad, loc_cEmpresa, loc_cTitulo1, loc_cLabelsMeses, loc_cSerieFalha, loc_cSerieRecuperacao)

                        THIS.this_cTitulo1          = loc_cTitulo1
                        THIS.this_cEmpresaAtual     = loc_cEmpresa
                        THIS.this_cLabelsMeses      = loc_cLabelsMeses
                        THIS.this_cSerieFalha       = loc_cSerieFalha
                        THIS.this_cSerieRecuperacao = loc_cSerieRecuperacao
                        THIS.this_nTotalMeses       = loc_nMeses
                        THIS.this_lChaveEmCache     = .F.
                        THIS.this_lGraficoGerado    = .T.
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais deste BO (nunca tocam SQL Server)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorChaves) AND USED(THIS.this_cCursorChaves)
            USE IN (THIS.this_cCursorChaves)
        ENDIF

        IF !EMPTY(THIS.this_cCursorGrafico) AND USED(THIS.this_cCursorGrafico)
            USE IN (THIS.this_cCursorGrafico)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

