*==============================================================================
* FORMSIGOPSAT.PRG
* Form OPERACIONAL - Integracao com o aparelho SAT-CF-e (legado SIGOPSAT.SCX)
* Herda de: FormBase
*
* O legado SIGOPSAT.SCX nao possui DataEnvironment ligado a tabela nem
* CommandButton/CommandGroup algum (dump tasks\task798\sigopsat_form_codigo_
* fonte.txt): e uma tela servidora que, ao abrir, associa a assinatura do AC
* no equipamento e entra num laco lendo os arquivos XML de requisicao
* depositados pelo PDV em <dirresta>\Req\, despachando cada comando para a
* SAT.dll e gravando o retorno em <dirresta>\Resp\. Nao ha Insert/Update/
* Delete, nao ha AddCursor nem TABLEUPDATE (ver cabecalho de sigopsatBO.prg).
*
* So 2 controles no dump (tasks\task798\layout.json): Label2 (titulo fixo,
* "Integracao com o aparelho SAT") e Label1 (rotulo de status/progresso do
* laco, Caption="" no desenho - preenchido em runtime pelo
* this_cMensagemStatus do BO, ex.: "<ESC> para interromper..."). Sem grid,
* sem Pagina Lista/Dados, sem PageFrame e sem qualquer botao CRUD.
*
* Por isso este form NAO segue o padrao Page1=Lista/Page2=Dados do CRUD:
* o nome ConfigurarPageFrame() foi preservado so por compatibilidade com o
* pipeline de migracao multi-fase (mesmo padrao documentado em
* Formsigprico.prg para OPERACIONAL flat) - nao existe PageFrame real aqui.
*
* FASE 3/8: estrutura base - DEFINE CLASS, Init(), InicializarForm() (cria o
* BO e executa a carga de conexao - as duas consultas SELECT do Init legado,
* via sigopsatBO.CarregarParametros()) e Destroy().
*
* FASE 4/8: "Grid e botoes CRUD" NAO SE APLICA - o dump do legado
* (tasks\task798\sigopsat_form_codigo_fonte.txt, comportamento.json,
* layout.json) nao declara Grid, DataEnvironment ligado a tabela nem um
* unico CommandButton/CommandGroup - "o legado SIGOPSAT nao possui
* DataEnvironment ligado a tabela nem CommandButton/CommandGroup algum" (ver
* paragrafo acima). Gerar ConfigurarPaginaLista() com grd_4c_Dados + 6
* botoes CRUD inventaria funcionalidade que o legado nao tem, violando o
* PILAR 1 (mesmo criterio documentado no cabecalho de Formsigprico.prg para
* OPERACIONAL flat sem CRUD). O que a Fase 4 entregou de verdade foi o que a
* Fase 3 ainda nao tinha implementado: os 2 Labels do dump (lbl_4c_Label2 - titulo fixo,
* lbl_4c_Label1 - rotulo de status do laco) e as propriedades visuais do
* FORM que o SCX legado declara (BorderStyle/ControlBox/MaxButton/MinButton/
* KeyPreview/TitleBar/AlwaysOnTop/AutoCenter/Picture/DataSession).
*
* FASE 8/8 (esta fase): "BtnBuscarClick/BtnSalvarClick/FormParaBO/BOParaForm/
* CarregarLista/AjustarBotoesPorModo" do template generico de fase 8 TAMBEM
* NAO SE APLICAM - sao metodos de form CRUD (Lista/Dados/botoes) e o
* SIGOPSAT nao tem nenhum dos dois. O que esta fase entrega de verdade eh o
* unico comportamento real que faltava: o laco de processamento do
* lerarquivos legado (DECLARE DLL de SAT.dll, leitura de Req\, despacho para
* a DLL e gravacao em Resp\), em Lerarquivos() abaixo, chamado por Init()
* depois que InicializarForm() carrega empresa+parametros com sucesso - fiel
* a ordem do Init legado (thisform.Visible=.T. / Refresh / lerarquivos() /
* Release(), todos ANTES de qualquer Show() externo).
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS Formsigopsat AS FormBase

    *-- DataSession = 2 (dump: "DataSession = 2") - sessao privada. Seguro
    *-- aqui porque Init() chama DODEFAULT() incondicionalmente (FormBase.Init
    *-- reaplica SET DATE TO BRITISH + SET CENTURY ON - regra #9.4) e os dois
    *-- cursores de apoio (cursor_4c_Empresa/cursor_4c_Parametros) sao
    *-- criados e lidos dentro do proprio form, nunca compartilhados.
    DataSession = 2

    Width      = 417
    Height     = 147
    Caption    = "Integra" + CHR(231) + CHR(227) + "o Aparelho SAT"

    *-- Propriedades visuais do SIGOPSAT legado (Secao 2 do dump) - tela
    *-- servidora, sem barra de titulo e sem como o usuario fechar pelo X:
    *-- o encerramento eh pelo proprio laco de processamento (ESC), nao por
    *-- controle de janela.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    AlwaysOnTop = .T.
    AutoCenter  = .T.
    FontBold    = .F.

    *-- ShowWindow: FIXO na classe (READ-ONLY em runtime nesta instalacao do
    *-- VFP9 - mesma medicao registrada em Formsigprico.prg). Declarar "= 1"
    *-- aqui evita que o CorretorAutomatico (pattern #29, SHOWWINDOW_AUSENTE)
    *-- injete uma segunda declaracao na mesma DEFINE CLASS.
    ShowWindow = 1

    *-- WindowType: canonico do projeto (padrao de operacionais\). O SCX
    *-- legado nao declara WindowType, mas o modo de abertura do menu.prg
    *-- (CREATEOBJECT + variavel LOCAL + Show()) exige modal (=1) - em
    *-- modeless o Show() retorna na hora, a referencia cai e o form eh
    *-- destruido antes do usuario ver qualquer coisa.
    WindowType = 1

    *-- Business Object (integracao SAT - sem tabela, ver sigopsatBO.prg)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
    * Em modo teste: rebaixa para modeless + invisivel, para o VFP9 -T headless
    * nao pendurar tentando exibir form modal. So WindowType aceita escrita em
    * runtime (ShowWindow eh read-only - ver comentario na declaracao da
    * classe). Mesma protecao canonica de Formsigprico.prg.
    *
    * Depois do DODEFAULT() (que executa InicializarForm() + AtualizarEstado-
    * Controles() via FormBase.Init()), reproduz o FIM do Init legado:
    *   thisform.Visible = .t.
    *   thisform.Refresh
    *   =thisform.lerarquivos()
    *   =thisform.Release()
    * nesta ordem e dentro do proprio Init - por isso AbrirFormsigopsat() em
    * menu.prg NAO chama .Show() depois do CREATEOBJECT: quando ele retorna,
    * a tela ja rodou o laco inteiro (ate ESC) e ja se liberou.
    *
    * Pulado em modo de teste/validacao de UI: o laco e INFINITO ate ESC (ou
    * ate a fila de Req\ nunca ter arquivo, o que da no mesmo em estacao sem
    * o PDV) - rodar isso no pipeline headless penduraria o VFP9 -T.
    *--------------------------------------------------------------------------
        LOCAL loc_lModoTeste

        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                         (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
            THIS.Visible    = .F.
        ENDIF

        IF !DODEFAULT()
            RETURN .F.
        ENDIF

        IF !loc_lModoTeste
            THIS.Visible = .T.
            THIS.Refresh()
            THIS.Lerarquivos()
            THIS.Release()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Lerarquivos - laco de integracao com o aparelho SAT-CF-e. Transcricao
    * literal de SIGOPSAT.lerarquivos (tasks\task798\sigopsat_form_codigo_
    * fonte.txt:128-208), na mesma ordem:
    *
    *   1. Declara as 8 funcoes de SAT.dll (sigopsatBO.DeclararFuncoesSAT)
    *   2. Associa a assinatura do AC uma unica vez, antes do laco
    *      (sigopsatBO.AssociarAssinaturaAC)
    *   3. Arma o trap de ESC e exibe o rotulo de status
    *   4. "Do While !llParar": a cada volta, processa TODA a fila de Req\
    *      (sigopsatBO.ProcessarFilaRequisicoes) - sem pausa/DOEVENTS, igual
    *      ao legado (o legado tambem busy-loopa)
    *
    * "Set Step On" do legado (abre o debugger do VFP) e "Do pEncerrar" (ver
    * comentario perto do final) sao OMITIDOS de proposito - ver abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Lerarquivos()
        LOCAL loc_lParar, loc_oErro

        loc_lParar = .F.

        THIS.this_oBusinessObject.DeclararFuncoesSAT()
        THIS.this_oBusinessObject.AssociarAssinaturaAC()

        SET ESCAPE ON
        ON ESCAPE loc_lParar = .T.

        THIS.lbl_4c_Label1.Caption = "<ESC> para interromper..."
        THIS.Refresh()

        TRY
            DO WHILE !loc_lParar
                THIS.this_oBusinessObject.ProcessarFilaRequisicoes()
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao processar integra" + CHR(231) + CHR(227) + "o SAT")
        ENDTRY

        SET ESCAPE OFF
        ON ESCAPE

        IF loc_lParar
            MsgAviso("Processamento Interrompido...", "Aten" + CHR(231) + CHR(227) + "o")
            fGravarLog("S", "SIGOPSAT", "SAIR", "Processamento Interrompido...")
            *-- Legado tambem chama "Do pEncerrar" aqui - rotina GLOBAL do
            *-- Fortyus (sig.prg/SIGFUNCS.PRG) que nao veio no acervo, e cujo
            *-- escopo real e desconhecido (nome sugere encerrar o processo/
            *-- sessao do PDV, nao so esta tela - diferente do form, que
            *-- qualquer jeito ja se libera no THIS.Release() chamado pelo
            *-- Init() logo depois desta PROCEDURE retornar). Chamar "DO
            *-- pEncerrar" sem definicao reproduziria o mesmo defeito ja
            *-- existente em Formsigtosen.prg:146/1383 (idem, sem
            *-- pencerrar.prg em utils\) - e inventar o PROCEDURE aqui seria
            *-- adivinhar um encerramento que pode ir alem desta tela, pior
            *-- do que nao fazer nada (regra #27 do CLAUDE.md).
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e executa a carga de conexao
    * (as duas consultas do Init legado: empresa logada em SigCdEmp e
    * parametros do sistema em SigCdPac - ver sigopsatBO.CarregarParametros()).
    *
    * Em modo de teste/validacao de UI (sem gnConnHandle) a carga remota eh
    * pulada - mesmo padrao das licoes de FormCor (gb_4c_ValidandoUI) - para
    * que o form continue instanciavel sem conexao.
    *
    * Falha na carga ABORTA a abertura (loc_lSucesso = .F.), reproduzindo o
    * "Favor Reinicializar o Processo!!!" + Return .f. do Init legado: sem
    * empresa nao ha CNPJ/assinatura do AC, e sem SigCdPac nao ha diretorio
    * de onde ler a requisicao do PDV.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lPularCarga

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopsatBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopsatBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()

                loc_lPularCarga = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                   (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

                IF loc_lPularCarga
                    loc_lSucesso = .T.
                ELSE
                    IF THIS.this_oBusinessObject.CarregarParametros()
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Favor Reinicializar o Processo!!!"), ;
                            "Erro ao Inicializar Formsigopsat")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar Formsigopsat")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador do layout. SEM PageFrame real: o
    * legado SIGOPSAT e um Form flat, sem abas e sem Pagina Lista/Dados.
    * Nome preservado so por compatibilidade com o pipeline de migracao
    * multi-fase (mesmo padrao de Formsigprico.prg) - nao existe PageFrame
    * real aqui.
    *
    * Monta o fundo (textura canonica do projeto) e os 2 Labels do dump
    * (Secao 2 de tasks\task798\sigopsat_form_codigo_fonte.txt), transcritos
    * LITERALMENTE (Top/Left/Width/Height/Font/Cor/Alignment):
    *
    *   Label2 (titulo fixo)   -> lbl_4c_Label2
    *   Label1 (status do laco, Caption="" no desenho - preenchido em
    *           runtime por THIS.Lerarquivos() com "<ESC> para
    *           interromper...", igual ao legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Textura de fundo canonica (mesma usada por FormCol/Formcrf/FormEmn
        *-- para "..\framework\imagens\new_background.jpg" do legado).
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top        = 63
            .Left       = 106
            .Width      = 205
            .Height     = 20
            .Alignment  = 2
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .BackStyle  = 0
            .BorderStyle = 0
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 234)
            .Caption    = "Integra" + CHR(231) + CHR(227) + "o com o aparelho SAT"
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top        = 114
            .Left       = 16
            .Width      = 387
            .Height     = 20
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontBold   = .T.
            .BackStyle  = 0
            .BorderStyle = 0
            .ForeColor  = RGB(36, 84, 155)
            .BackColor  = RGB(255, 255, 234)
            .Caption    = ""
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
