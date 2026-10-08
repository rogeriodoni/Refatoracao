*==============================================================================
* FORMSIGPRICO.PRG
* Form OPERACIONAL - Catalogo de Icones do Sistema (legado SIGPRICO.SCX)
* Herda de: FormBase
*
* O legado SIGPRICO.SCX nao possui DataEnvironment ligado a tabela, nao
* possui ControlSource em controle nenhum e nao possui um unico metodo com
* codigo ("Total de metodos/eventos com codigo: 0" no dump
* tasks\task624\sigprico_form_codigo_fonte.txt). Ele e composto exclusivamente
* por 24 controles Image (Image1..Image11, Image15..Image27 - a lacuna
* 12/13/14 nao existe no legado e sera reproduzida de proposito na Fase 4,
* PILAR 1) que exibem icones da pasta vbmp\: trata-se de uma tela de
* REFERENCIA VISUAL (catalogo/paleta de icones), sem PageFrame, sem
* Pagina Lista/Dados, sem grid e sem qualquer botao/CRUD.
*
* Por isso este form NAO segue o padrao Page1=Lista/Page2=Dados do CRUD
* nem o padrao de grids multiplos de outros OPERACIONAIS: o unico conteudo
* e o catalogo estatico de icones (sigpricoBO.this_cArqImageN /
* this_cObjImageN), a ser adicionado em ConfigurarPageFrame() na Fase 4.
* O nome ConfigurarPageFrame() foi preservado so por compatibilidade com o
* pipeline de migracao multi-fase (mesmo padrao documentado em
* FormICO.prg para OPERACIONAL flat) - nao existe PageFrame real aqui.
*
* Width/Height nao aparecem customizados no dump do legado (SCX ficou no
* default da classe "form" do VFP9) - os valores abaixo apenas enquadram
* os 24 icones (bbox real do catalogo: Left 0..258, Top 0..197, ver
* tasks\task624\layout.json) com margem, sem inventar funcionalidade
* visual que o legado nao declarou.
*
* FASES 5 A 7 (pipeline multi-fase): NAO APLICAVEIS a este form. O dump do
* legado (tasks\task624\analise.json/layout.json) nao declara "campos"
* (analise.json: campos=[], lookups=[], labels=[], grid.temGrid=false) nem
* Pagina Lista/Dados/PageFrame real - so os 24 Image ja entregues na Fase 4
* via ConfigurarPageFrame(). Criar ConfigurarPaginaDados() vazio seria stub
* disfarcado (proibido); inventar campo/lookup/grid que o legado nao tem
* violaria o PILAR 1. Idem para os eventos de botao da Fase 7: o legado nao
* tem CommandButton, nao tem CommandGroup e nao tem um unico ".Click"
* ("Total de metodos/eventos com codigo: 0" no proprio dump).
*
* FASE 8 (consolidacao final): tambem nao ha BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick (nao existe botao), nem FormParaBO/
* BOParaForm (nao existe nada digitavel para transferir), nem HabilitarCampos/
* LimparCampos/CarregarLista/AjustarBotoesPorModo (nao existe campo, lista nem
* modo CRUD). O trabalho REAL da Fase 8 aqui foi consolidar o ciclo de vida da
* janela, que estava na forma INSTAVEL - ver os comentarios de ShowWindow/
* WindowType na declaracao da classe e de Init() abaixo.
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS Formsigprico AS FormBase

    Width      = 300
    Height     = 260
    Caption    = "Form1"       && Caption EXATO do SCX legado (sigpricoBO.this_cCaptionLegado)

    *-- ShowWindow: FIXO na classe, nunca atribuido em runtime. ShowWindow eh
    *-- READ-ONLY em RUNTIME nesta instalacao do VFP9 (medido -
    *-- automation\medir_showwindow.txt: "Property SHOWWINDOW is read-only.",
    *-- inclusive dentro do proprio Init). E declarar 0 aqui NAO para em pe: o
    *-- CorretorAutomatico (SHOWWINDOW_AUSENTE, pattern #29) procura
    *-- literalmente "ShowWindow = 1" e, achando "= 0", INJETA uma SEGUNDA
    *-- declaracao na mesma DEFINE CLASS - medido nesta Fase 8 rodando o
    *-- corretor sobre uma COPIA deste arquivo: saiu "ShowWindow = 1" na linha
    *-- 43 convivendo com "ShowWindow = 0" na linha 48. Com "= 1" aqui o
    *-- corretor eh no-op e nao ha declaracao duplicada.
    ShowWindow = 1

    *-- WindowType: canonico do projeto (136 dos 149 forms de operacionais\
    *-- declaram 1). O SCX legado nao declara WindowType - mas transcrever essa
    *-- ausencia (= 0, modeless) QUEBRA a tela, porque o modo de abertura mudou
    *-- entre os sistemas: o menu.prg abre com CREATEOBJECT + variavel LOCAL +
    *-- Show(), e em modeless o Show() retorna na hora, o PROCEDURE termina, a
    *-- ultima referencia cai e o form eh destruido - pisca e some, sem erro,
    *-- sem log e sem entrada em gc_4c_ArquivoErroTeste. Ao contrario de
    *-- ShowWindow, WindowType ACEITA escrita em runtime (mesma medicao), e eh
    *-- so por isso que o Init abaixo pode rebaixar para 0 no caminho headless.
    WindowType = 1

    *-- Business Object (catalogo de icones - sem tabela, ver sigpricoBO.prg)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
    * Em modo teste: rebaixa para modeless + invisivel, para o VFP9 -T headless
    * nao pendurar tentando exibir form modal. So WindowType aceita escrita em
    * runtime - NAO tocar ShowWindow aqui (read-only; ver comentario na
    * declaracao da classe). Mesma protecao do padrao canonico Formsigprftp.
    *
    * O caminho de PRODUCAO nao atribui propriedade NENHUMA: os valores da
    * classe (ShowWindow = 1 / WindowType = 1) ja sao os de producao. Isso
    * elimina a armadilha de polaridade - atribuicao de propriedade dentro de
    * guard de modo roda exatamente no ramo que o harness NAO exercita, entao
    * um erro ali passa por todos os gates ("o form instancia") e so aparece
    * quando o usuario clica no menu. As DUAS polaridades foram medidas nesta
    * fase: automation\ProbeIcoF8Polaridades.prg -> probe_ico_f8_polaridades.txt.
    *
    * Nao existe override de Load(): o anterior pulava o Form.Load() builtin em
    * modo teste alegando que "ShowWindow=0 na definicao da classe" o faria
    * travar no headless. Com ShowWindow = 1 (canonico) essa premissa deixou de
    * existir, e medir mostrou que o Load() builtin roda limpo nas duas
    * polaridades - manter o override seria risco sem beneficio.
    *--------------------------------------------------------------------------
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
            THIS.Visible    = .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object do catalogo de icones.
    * A montagem dos 24 Image (ConfigurarPageFrame) e adicionada na Fase 4.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpricoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigpricoBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar Formsigprico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador do layout. SEM PageFrame real: o
    * legado SIGPRICO e um Form flat, sem abas e sem Pagina Lista/Dados.
    * Nome preservado so por compatibilidade com o pipeline de migracao
    * multi-fase (mesmo padrao de FormICO.prg).
    *
    * Monta os 24 controles Image do catalogo (Image1..Image11, Image15..
    * Image27 - a lacuna 12/13/14 nao existe no legado, PILAR 1), com
    * Top/Left/Width/Height/Stretch/Picture transcritos LITERALMENTE de
    * THIS.this_oBusinessObject.this_cArqImageN/this_cObjImageN (que por
    * sua vez vieram de tasks\task624\layout.json - ver comentario slot a
    * slot em sigpricoBO.prg). Nomes migrados seguem mapeamento.json:
    * sigprico.ImageN -> img_4c_ImageN.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        THIS.AdicionarIconeCatalogo("img_4c_Image1",  0,   0, loc_oBO.this_cArqImage1)
        THIS.AdicionarIconeCatalogo("img_4c_Image2",  18,   0, loc_oBO.this_cArqImage2)
        THIS.AdicionarIconeCatalogo("img_4c_Image3",  36,   0, loc_oBO.this_cArqImage3)
        THIS.AdicionarIconeCatalogo("img_4c_Image4",   1,  22, loc_oBO.this_cArqImage4)
        THIS.AdicionarIconeCatalogo("img_4c_Image5",   1,  44, loc_oBO.this_cArqImage5)
        THIS.AdicionarIconeCatalogo("img_4c_Image6",   1,  67, loc_oBO.this_cArqImage6)
        THIS.AdicionarIconeCatalogo("img_4c_Image7",   1,  90, loc_oBO.this_cArqImage7)
        THIS.AdicionarIconeCatalogo("img_4c_Image8",  24,  24, loc_oBO.this_cArqImage8)
        THIS.AdicionarIconeCatalogo("img_4c_Image9",  24,  53, loc_oBO.this_cArqImage9)
        THIS.AdicionarIconeCatalogo("img_4c_Image10", 24,  84, loc_oBO.this_cArqImage10)
        THIS.AdicionarIconeCatalogo("img_4c_Image11", 24, 116, loc_oBO.this_cArqImage11)
        THIS.AdicionarIconeCatalogo("img_4c_Image15", 47, 144, loc_oBO.this_cArqImage15)
        THIS.AdicionarIconeCatalogo("img_4c_Image16", 71,   5, loc_oBO.this_cArqImage16)
        THIS.AdicionarIconeCatalogo("img_4c_Image17", 94,  13, loc_oBO.this_cArqImage17)
        THIS.AdicionarIconeCatalogo("img_4c_Image18", 73,  33, loc_oBO.this_cArqImage18)
        THIS.AdicionarIconeCatalogo("img_4c_Image19", 117,  11, loc_oBO.this_cArqImage19)
        THIS.AdicionarIconeCatalogo("img_4c_Image20", 95,  44, loc_oBO.this_cArqImage20)
        THIS.AdicionarIconeCatalogo("img_4c_Image21", 121,  40, loc_oBO.this_cArqImage21)
        THIS.AdicionarIconeCatalogo("img_4c_Image22", 84,  96, loc_oBO.this_cArqImage22)
        THIS.AdicionarIconeCatalogo("img_4c_Image23", 108, 101, loc_oBO.this_cArqImage23)
        THIS.AdicionarIconeCatalogo("img_4c_Image24", 134, 106, loc_oBO.this_cArqImage24)
        THIS.AdicionarIconeCatalogo("img_4c_Image25", 84, 192, loc_oBO.this_cArqImage25)
        THIS.AdicionarIconeCatalogo("img_4c_Image26", 132, 204, loc_oBO.this_cArqImage26)
        THIS.AdicionarIconeCatalogo("img_4c_Image27", 180, 240, loc_oBO.this_cArqImage27)
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarIconeCatalogo - Cria um controle Image do catalogo. Width=18/
    * Height=17/Stretch=2 sao constantes em TODOS os 24 slots do SCX legado
    * (this_nWidthIcone/this_nHeightIcone/this_nStretchIcone em sigpricoBO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AdicionarIconeCatalogo(par_cNomeObjeto, par_nTop, par_nLeft, par_cArquivo)
        THIS.AddObject(par_cNomeObjeto, "Image")

        WITH EVALUATE("THIS." + par_cNomeObjeto)
            .Top     = par_nTop
            .Left    = par_nLeft
            .Width   = 18
            .Height  = 17
            .Stretch = 2
            .Picture = gc_4c_CaminhoIcones + par_cArquivo
            .Visible = .T.
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
