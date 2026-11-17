*==============================================================================
* Formsigopser.prg - Servicos do Item (dialogo de detalhamento)
*
* Legado  : SIGOPSER.SCX (form OPERACIONAL, 1050x600, sem barra de titulo)
* Herda de: FormBase
* BO      : sigopserBO (classes\sigopserBO.prg)
*
* Tipo de layout: FLAT (OPERACIONAL)
*   A arvore de objetos do dump (tasks\task801\sigopser_form_codigo_fonte.txt)
*   traz a raiz SIGOPSER como "Class: form / BaseClass: form" - form GENERICO,
*   nao frmcadastro nem frmrelatorio - e NENHUMA linha "BaseClass: pageframe".
*   Os objetos de primeiro nivel (shpBtnGs, cntSombra, fwGrade, Label1,
*   btnAltImps, btnCotacao, btnTotItens, Get_Produto, Get_Descricao, cntOK,
*   Get_Mercs, cntTamanho) penduram direto na Form. Nao existe, portanto,
*   pagina de Lista nem pagina de Dados a reproduzir: criar um PageFrame aqui
*   seria inventar superficie que o legado nao tem (viola o PILAR 1), e criar
*   os metodos de configuracao de pageframe e de paginas de Lista/Dados sem
*   corpo eh proibido pela regra de completude. O layout eh transcrito objeto a
*   objeto com as coordenadas ABSOLUTAS do dump, SEM a compensacao de -29 dos
*   forms de cadastro (nao ha PageFrame com Top = -29 para compensar).
*
* Funcao da tela:
*   Dialogo MODAL aberto por um form de movimento (SigOpPed e irmaos) para
*   detalhar os SERVICOS vinculados a UM item de produto do documento. O
*   dialogo opera sobre os cursores que o form chamador ja montou (grade de
*   servicos, item e cabecalho do movimento) e devolve o controle ao chamador
*   pelo botao Retornar.
*
* Correspondencia legado -> migrado (objetos; ver tasks\task801\mapeamento.json)
*   SIGOPSER                       -> Formsigopser
*   SIGOPSER.shpBtnGs              -> shp_4c_ShpBtnGs                 (Fase 3)
*   SIGOPSER.cntSombra             -> cnt_4c_Sombra                   (Fase 3)
*   SIGOPSER.cntSombra.lblSombra   -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
*   SIGOPSER.cntSombra.lblTitulo   -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
*   SIGOPSER.cntTamanho            -> cnt_4c_Tamanho                  (Fase 3)
*   SIGOPSER.fwGrade               -> grd_4c_Dados                    (Fase 4)
*   SIGOPSER.cntOK                 -> cmg_4c_CntOK                    (Fase 4)
*   SIGOPSER.btnTotItens           -> cmd_4c_BtnTotItens              (Fase 4)
*   SIGOPSER.btnCotacao            -> cmd_4c_BtnCotacao               (Fase 4)
*   SIGOPSER.btnAltImps            -> cmd_4c_BtnAltImps               (Fase 4)
*   SIGOPSER.Label1                -> lbl_4c_Label1                   (Fase 5)
*   SIGOPSER.Get_Produto           -> txt_4c_Produto                  (Fase 5)
*   SIGOPSER.Get_Descricao         -> txt_4c_Descricao                (Fase 5)
*   SIGOPSER.Get_Mercs             -> txt_4c_Mercs                    (Fase 5)
*   SIGOPSER.cntTamanho.Label2     -> cnt_4c_Tamanho.lbl_4c_Label2    (Fase 5)
*   SIGOPSER.cntTamanho.Say43      -> cnt_4c_Tamanho.lbl_4c_Label43   (Fase 5)
*   SIGOPSER.cntTamanho.Say1       -> cnt_4c_Tamanho.lbl_4c_Label1    (Fase 5)
*   SIGOPSER.cntTamanho.getTamDe   -> cnt_4c_Tamanho.txt_4c_TamDe     (Fase 6)
*   SIGOPSER.cntTamanho.getTamPara -> cnt_4c_Tamanho.txt_4c_TamPara   (Fase 6)
*
* Correspondencia legado -> migrado (comportamento desta fase)
*   SIGOPSER.Load  (=fConfigGeral())  -> ja coberto pelo startup do sistema
*                                        novo (start\config.prg), que carrega a
*                                        configuracao geral uma unica vez.
*   SIGOPSER.Init  Lparameters poForm, pnDatSes, pGarantia, pVlrZeroGarantia
*                  os 4 parametros              -> THIS.Init(...)
*                  lblSombra/lblTitulo.Caption  -> THIS.ConfigurarCabecalho()
*                  .Poform / .ParentForm        -> THIS.Init(...)
*                  .Op_Escolha (Iif EdServicos) -> THIS.ResolverModoOperacao()
*                  .ValidOk = .f.               -> this_lValidOk (declarada .F.)
*                  Thisform.WindowType = 1      -> WindowType = 1 na classe
*                  Thisform.CItem / nCItem2     -> THIS.ConfigurarContextoBO()
*                  poForm.Enabled = .f.         -> THIS.DesabilitarChamador()
*                  Set Datasession to pnDatSes  -> DataSession = 1 (ver abaixo)
*
*   A montagem dos cursores de trabalho (csTmpDesc, csSigCdPro), a ligacao das
*   7 colunas da grade e a leitura de CrSigCdOpe/CrTmpPro vem junto com a grade
*   e com os campos, nas Fases 4 a 6.
*
* DataSession = 1 (SESSAO CORRENTE) - EQUIVALENTE AO "Set DataSession To"
* ----------------------------------------------------------------------
* O dump declara DataSession = 2, mas o Init legado executa
* "Set Datasession to pnDatSes": o dialogo entra na sessao do CHAMADOR
* justamente para alcancar os cursores que ele montou (crTpmMvItn3 com a grade
* de servicos, crTpmMvItn com o item e TprMvCab com o cabecalho do movimento).
* Em VFP9, DataSession = 1 significa "Default Data Session", ou seja a sessao
* CORRENTE de quem instancia - e nao "a sessao global numero 1": um form criado
* de dentro do chamador JA roda na sessao dele e ve os cursores dele. Declarar
* 1 aqui eh portanto a transcricao FIEL do par (DataSession = 2 +
* Set Datasession to pnDatSes), nao um desvio. Manter o 2 literal daria sessao
* PRIVADA, crTpmMvItn3 invisivel e a grade abrindo como um retangulo branco.
* Por isso tambem NAO se executa "SET DATASESSION TO" em runtime: o comando
* troca a sessao CORRENTE do PROCESSO (efeito colateral global), nao a do form.
* O numero recebido no 2o parametro eh guardado em this_nDataSessionPai apenas
* como informacao de diagnostico.
*
* Uso (o chamador se desabilita e eh reabilitado pelo botao Retornar):
*   loForm = CREATEOBJECT("Formsigopser", THISFORM, THISFORM.DataSessionId, ;
*                         llGarantia, llVlrZeroGarantia)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()        && modal: retorna quando o dialogo fecha
*   ENDIF
*==============================================================================

DEFINE CLASS Formsigopser AS FormBase

    *==========================================================================
    * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
    *
    *   DataSession = 2 / BorderStyle = 2 / Height = 600 / Width = 1050
    *   ShowTips = .T. / AutoCenter = .T. / Caption = "Servicos"
    *   ControlBox = .F. / Movable = .F. / TitleBar = 0 / WindowState = 2
    *   AlwaysOnTop = .T. / Picture = ..\framework\imagens\new_background.jpg
    *
    * Tres observacoes:
    *
    * (1) DataSession vai como 1 pelo motivo explicado no cabecalho do arquivo.
    *
    * (2) WindowType NAO eh declarado no dump (default 0), mas o Init legado
    *     faz "Thisform.WindowType = 1" ANTES de qualquer Show: o dialogo eh
    *     modal em producao. Declarar 1 na classe eh equivalente e evita
    *     depender da ordem de execucao do Init.
    *
    * (3) DoCreate = .T. do dump NAO eh transcrito: eh metadado de tempo de
    *     desenho do SCX/VCX e NAO existe como propriedade de Form em runtime
    *     (a lista real de propriedades da base class Form, em
    *     automation\propriedades_baseclasses.txt, nao traz DOCREATE) -
    *     atribui-la faria a tela nao abrir.
    *
    * Caption e Picture ficam em ConfigurarAparencia: o primeiro porque o texto
    * tem cedilha, que vem de CHR(), e o segundo porque depende da variavel
    * global gc_4c_CaminhoIcones - funcao e variavel nao podem aparecer em
    * inicializador de propriedade de DEFINE CLASS. O Caption declarado aqui eh
    * a versao sem acento, substituida em ConfigurarAparencia ANTES de os
    * labels do cabecalho o lerem.
    *==========================================================================
    this_cMensagemErro = ""
    DataSession = 1
    ShowWindow = 1
    BorderStyle = 2
    Height      = 600
    Width       = 1050
    ShowTips    = .T.
    AutoCenter  = .T.
    Caption     = "Servicos"
    ControlBox  = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowState = 2
    AlwaysOnTop = .T.
    WindowType  = 1
    FontName    = "Tahoma"
    FontSize    = 8

    *==========================================================================
    * Entrada recebida do chamador
    *
    * Legado: Lparameters poForm, pnDatSes, pGarantia, pVlrZeroGarantia
    *   poForm           - o form que ABRIU este dialogo  -> this_oFormChamador
    *   pnDatSes         - DataSessionId do chamador      -> this_nDataSessionPai
    *   pGarantia        - fluxo de garantia              -> this_lGarantia
    *   pVlrZeroGarantia - permite valor unitario zero    -> this_lValorZeroGarantia
    *
    * O legado guarda AINDA um terceiro form: ".ParentForm = poForm.parentform"
    * - o dono do documento, um nivel acima de quem abriu o dialogo. Eh dele
    * que saem Calc_ValIte, poDataMgr e EdServicos.
    *==========================================================================
    this_oFormChamador      = .NULL.  && poForm do legado (quem abriu este dialogo)
    this_oFormPai           = .NULL.  && poForm.parentform (dono do documento)
    this_nDataSessionPai    = 0       && pnDatSes do legado (diagnostico)
    this_lGarantia          = .F.     && plGarantia do legado
    this_lValorZeroGarantia = .F.     && plVlrZeroGarantia do legado

    *==========================================================================
    * Estado do dialogo - as propriedades customizadas que o legado usa como
    * "ThisForm.<x>" ao longo dos handlers (contagem feita no dump):
    *
    *   op_escolha (11x) AntCPro (11x) nCItem2 (7x) lAutPreco (6x) foco (6x)
    *   CItem (4x) AntValu (3x) OldPreco (2x) OldCodBarras (1x) ValidOk (1x)
    *
    * AntValu eh usada pelo legado com DOIS tipos (Space(3) no mInsereLinha e
    * crTpmMvItn.Units no When do produto). Declarada como caractere, que eh a
    * forma com que o legado a INICIALIZA; VFP9 nao tipa propriedade, entao o
    * uso numerico continua valido.
    *==========================================================================
    this_cOpEscolha    = ""    && INSERIR / ALTERAR / VISUALIZAR / PROCURAR
    this_lValidOk      = .F.   && .ValidOk = .f. do Init legado
    this_nCItem        = 0     && Citens do item de produto dono dos servicos
    this_nCItem2       = 1     && contador de linhas de csTmpDesc
    this_lAutPreco     = .F.   && libera a digitacao do valor unitario
    this_nOldPreco     = 0     && valor unitario antes da edicao
    this_cAntCPro      = ""    && codigo/descricao do servico antes da edicao
    this_cAntValu      = ""    && valor unitario anterior (ver nota acima)
    this_cOldCodBarras = ""    && codigo de barras anterior
    this_cFoco         = ""    && nome do controle que deve receber o foco

    *-- Guarda de uma vez so para o foco inicial da grade: o Activate de form
    *-- modal dispara a cada vez que a janela reassume o foco, e repetir o
    *-- SetFocus roubaria o foco do controle que o usuario acabou de escolher
    this_lFocoInicialAplicado = .F.

    *-- Guardas de reentrancia dos lookups (Fase 6): o picker eh modal, tira o
    *-- foco do controle e redispara o proprio LostFocus/Valid - sem a guarda
    *-- um segundo dialogo seria empilhado por cima do primeiro (regra #37/#47)
    this_lEmLookupTamDe     = .F.
    this_lEmLookupTamPara   = .F.
    this_lEmLookupServico   = .F.   && coluna "Servico" da grade (csSigCdPro.Cpros)
    this_lEmLookupDescricao = .F.   && coluna "Descricao" da grade (csSigCdPro.DPros)

    *==========================================================================
    * Cursores de trabalho
    *
    * Os QUATRO primeiros pertencem ao CHAMADOR e sao apenas LIDOS por esta
    * tela (por isso nunca sao fechados no Destroy): o dialogo roda na sessao
    * de dados do chamador, como explicado no cabecalho do arquivo. Os nomes
    * sao os do legado porque sao o contrato com o form que abriu o dialogo -
    * os forms de movimento ja migrados usam as MESMAS grafias.
    *
    * Os dois ultimos sao criados por esta tela junto com a grade (Fase 4) e
    * por isso aparecem na lista de limpeza do Destroy.
    *==========================================================================
    this_cCursorServicos   = "crTpmMvItn3"  && grade de servicos do item (do chamador)
    this_cCursorItem       = "crTpmMvItn"   && item de produto corrente (do chamador)
    this_cCursorCabecalho  = "TprMvCab"     && cabecalho do movimento (do chamador)
    this_cCursorOperacao   = "CrSigCdOpe"   && configuracao da operacao (SigCdOpe)
    this_cCursorDescricoes = "csTmpDesc"    && descricoes por linha da grade
    this_cCursorLista      = "csSigCdPro"   && servicos disponiveis para escolha

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros do chamador e dispara a inicializacao.
    *
    * Legado: Lparameters poForm, pnDatSes, pGarantia, pVlrZeroGarantia
    *
    * NENHUM parametro eh obrigatorio: parametro ausente apenas mantem o
    * default declarado acima. Init que recusa instanciacao por falta de
    * parametro reprova o harness de teste (que instancia sem argumento) e
    * deixa a tela inalcancavel.
    *
    * Os valores sao guardados ANTES do DODEFAULT() porque eh o DODEFAULT()
    * ja precisa deles para resolver o modo de operacao e alimentar o BO.
    *
    * PCOUNT() eh obrigatorio no teste de parametro LOGICO: VARTYPE de
    * parametro ausente tambem devolve "L", entao sem PCOUNT() um .T. vindo do
    * chamador e a ausencia do argumento ficariam indistinguiveis.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormChamador, par_nDataSession, par_lGarantia, par_lVlrZeroGarantia)
        LOCAL loc_lSucesso

        IF PCOUNT() >= 1 AND VARTYPE(par_oFormChamador) = "O"
            THIS.this_oFormChamador = par_oFormChamador

            *-- Legado: .ParentForm = poForm.parentform (o dono do documento)
            IF PEMSTATUS(par_oFormChamador, "ParentForm", 5)
                IF VARTYPE(par_oFormChamador.ParentForm) = "O"
                    THIS.this_oFormPai = par_oFormChamador.ParentForm
                ENDIF
            ENDIF

            *-- Chamador sem ParentForm proprio: ele mesmo eh o dono do documento
            IF ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai = par_oFormChamador
            ENDIF
        ENDIF

        IF PCOUNT() >= 2 AND VARTYPE(par_nDataSession) = "N"
            THIS.this_nDataSessionPai = par_nDataSession
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_lGarantia) = "L"
            THIS.this_lGarantia = par_lGarantia
        ENDIF

        IF PCOUNT() >= 4 AND VARTYPE(par_lVlrZeroGarantia) = "L"
            THIS.this_lValorZeroGarantia = par_lVlrZeroGarantia
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init().
    *
    * Monta a estrutura base da tela na MESMA ordem de criacao do SCX legado
    * (shpBtnGs -> cntSombra -> ... -> cntTamanho). A ordem importa: objeto
    * criado depois desenha POR CIMA do criado antes, e aqui as faixas se
    * cruzam de fato - shpBtnGs ocupa Top 66..81 e a faixa do cabecalho ocupa
    * Top 0..80.
    *
    * O botao Retornar (cmg_4c_CntOK, Top = -2..83) tambem se sobrepoe a faixa
    * do cabecalho, e por isso eh criado DEPOIS dela.
    *
    * Os campos Produto/Descricao/Mercs e os rotulos entram
    * na Fase 5; os dois campos de tamanho dentro de cnt_4c_Tamanho, que tem
    * lookup em SigCdTam, foram acrescentados na Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Objeto de negocio (gerado nas Fases 1 e 2)
            THIS.this_oBusinessObject = CREATEOBJECT("sigopserBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Aparencia da janela (fundo e titulo acentuado)
                THIS.ConfigurarAparencia()

                *-- Moldura decorativa sob a barra de botoes (shpBtnGs)
                THIS.ConfigurarMoldura()

                *-- Faixa cinza do cabecalho (cntSombra + os dois labels)
                THIS.ConfigurarCabecalho()

                *-- Grade de servicos (fwGrade); so a estrutura visual - o
                *-- RecordSource e os ControlSource ficam em CarregarLista,
                *-- porque os cursores ainda nao existem neste ponto
                THIS.ConfigurarGrade()

                *-- Os tres botoes de servico (btnTotItens / btnCotacao /
                *-- btnAltImps), que nascem OCULTOS como no SCX legado
                THIS.ConfigurarBotoesServico()

                *-- Botao Retornar (cntOK); vem DEPOIS do cabecalho porque se
                *-- sobrepoe a faixa (Top = -2..83 contra 0..80) e precisa
                *-- desenhar por cima dela
                THIS.ConfigurarBotaoRetornar()

                *-- Painel "Tamanho" (cntTamanho); os dois campos com lookup
                *-- em SigCdTam foram acrescentados a ele na Fase 6
                *-- (ConfigurarCamposTamanho, chamada logo abaixo)
                THIS.ConfigurarPainelTamanho()

                *-- Rotulo "Produto", os tres campos de identificacao do
                *-- produto (Get_Produto/Get_Descricao/Get_Mercs) e os tres
                *-- rotulos internos de cnt_4c_Tamanho (Tamanho/De:/Para:).
                *-- Vem DEPOIS de ConfigurarPainelTamanho porque os tres
                *-- ultimos sao AddObject DENTRO de cnt_4c_Tamanho, que
                *-- precisa existir primeiro.
                THIS.ConfigurarCamposProduto()

                *-- Os dois campos de tamanho (getTamDe/getTamPara) dentro de
                *-- cnt_4c_Tamanho, com lookup em SigCdTam. Vem DEPOIS de
                *-- ConfigurarCamposProduto porque sao AddObject DENTRO de
                *-- cnt_4c_Tamanho, que precisa existir primeiro.
                THIS.ConfigurarCamposTamanho()

                *-- Legado: .Op_Escolha = Iif(ParentForm.EdServicos, 'ALTERAR',
                *--                           poForm.op_Escolha)
                THIS.ResolverModoOperacao()

                *-- Legado: Thisform.CItem = crTpmMvItn.CItens, mais o contexto
                *-- do movimento repassado ao BO
                THIS.ConfigurarContextoBO()

                *-- Legado: poForm.Enabled = .f. (o chamador fica inerte
                *-- enquanto este dialogo estiver aberto)
                THIS.DesabilitarChamador()

                *-- AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado: Get_Produto/Get_Descricao/Get_Mercs tem "Return .f."
                *-- no When - sao campos de exibicao. Vem DEPOIS de
                *-- TornarControlesVisiveis, que percorre a tela inteira.
                THIS.AplicarGatesDeEdicao()

                *-- Handlers dos quatro botoes do legado e da troca de linha da
                *-- grade. ANTES de CarregarLista para que a grade ja chegue
                *-- posicionada com o painel "Tamanho" acompanhando a linha.
                THIS.VincularEventosPrincipais()

                *-- Legado (fim do Init): monta csTmpDesc, le a configuracao da
                *-- operacao, liga a grade aos cursores e a posiciona. Vai por
                *-- ULTIMO porque depende da grade e do contexto do movimento ja
                *-- montados acima, e porque o legado tambem o faz no fim.
                *-- Falha de carga NAO impede a tela de abrir (o legado tambem
                *-- segue adiante com a grade vazia).
                THIS.CarregarLista()

                *-- Legado (fim do Init, logo apos o Scan de iconfs):
                *--   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
                *--   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
                *-- A VISIBILIDADE do painel NAO eh tocada aqui: o legado so a
                *-- decide no primeiro AfterRowColChange, e antecipa-la mudaria
                *-- o que o usuario ve ao abrir a tela.
                THIS.CarregarValoresTamanhoDaLinha()

                *-- Os When dos tres botoes de servico, que dependem do modo e
                *-- da linha corrente - ambos ja resolvidos neste ponto
                THIS.AtualizarEstadoBotoesServico()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                          "vel criar o objeto de neg" + CHR(243) + ;
                                          "cio sigopserBO"
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar Formsigopser")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparencia - Propriedades visuais da janela que dependem de
    * funcao ou de variavel global e por isso nao cabem no bloco de declaracao
    * da classe.
    *
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    *         Caption = "Servicos" (com cedilha)
    *
    * O caminho vem de gc_4c_CaminhoIcones (vbmp\), onde new_background.jpg
    * existe - NUNCA remontar o caminho a partir de gc_4c_CaminhoBase. Sem
    * guard IF FILE(): o arquivo existe no acervo, e esconder a ausencia de
    * imagem atras de um guard eh justamente o que faz o fundo desaparecer em
    * silencio.
    *
    * O Caption eh trocado AQUI, antes de ConfigurarCabecalho, porque os dois
    * labels da faixa copiam THIS.Caption.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.Caption = "Servi" + CHR(231) + "os"
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMoldura - shpBtnGs do legado.
    *
    * Legado: shpBtnGs Top=66 Left=12 Height=15 Width=258
    *                  BackStyle=0 BorderStyle=0 BorderColor=36,84,155
    *
    * Transcricao literal: com BackStyle = 0 (transparente) e BorderStyle = 0
    * (sem linha) o retangulo nao pinta nada - eh a area que o Form Designer
    * reservou sob a barra dos tres botoes de servico (Top = 87). Mantido por
    * fidelidade e criado ANTES da faixa do cabecalho, que eh a ordem do SCX.
    *
    * Shape NAO tem ForeColor - a cor da borda eh BorderColor e a do interior
    * eh FillColor; atribuir ForeColor aqui faria a tela nao abrir. O ZOrderSet
    * do dump tambem nao eh transcrito: eh metadado do Form Designer, sem
    * equivalente de propriedade em runtime (o equivalente eh o METODO
    * ZOrder(), que o legado nao chama).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMoldura()
        THIS.AddObject("shp_4c_ShpBtnGs", "Shape")

        WITH THIS.shp_4c_ShpBtnGs
            .Top         = 66
            .Left        = 12
            .Height      = 15
            .Width       = 258
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
    *
    * Legado:
    *   cntSombra            Top=0  Left=0  Width=1052 Height=80
    *                        BorderWidth=0 BackColor=100,100,100
    *   cntSombra.lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *   cntSombra.lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *   ambos: Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * Dois desvios DELIBERADOS do literal do dump:
    *
    * (1) WIDTH do container - o SCX declara 1052 num form de 1050, ou seja a
    *     faixa nasce 2px mais larga que a janela e seria RECORTADA pela borda.
    *     Usa-se THIS.Width, o equivalente responsivo. A largura dos LABELS
    *     (769) fica literal: cabe dentro do form e eh a medida que o Designer
    *     calculou.
    *
    * (2) CAPTION - o dump traz "Cadastro de Testes" nos dois labels, texto de
    *     template que ficou no SCX (o ToolTipText do lblTitulo ainda diz
    *     "Titulo do Relatorio"). O proprio Init legado sobrescreve os dois com
    *     ThisForm.Caption, que eh o que o usuario le.
    *
    * AutoSize = .F. explicito: AutoSize eh no-op em Label criado por
    * AddObject e, com WordWrap = .T., chega a DESCARTAR a Height - o par
    * Width/Height transcrito do SCX ja eh o tamanho calculado pelo Designer.
    *
    * ForeColor branco eh legitimo aqui: lbl_4c_LblTitulo fica dentro de
    * container OPACO escuro (BackStyle = 1 + BackColor RGB(100,100,100)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label de sombra (preto, 1px abaixo do titulo - efeito de relevo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo (branco sobre o cinza do container)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - fwGrade do legado (a grade de servicos do item).
    *
    * Legado (SIGOPSER.fwGrade, classe fwgrade):
    *   ColumnCount=7 FontName="Verdana" FontSize=8 AllowAddNew=.F.
    *   AllowHeaderSizing=.F. DeleteMark=.F. HeaderHeight=20 RowHeight=16
    *   ScrollBars=2 Top=172 Left=12 Width=986 Height=408 Visible=.T.
    *   ToolTipText="Grade de Itens"
    * Mais o que vem da CLASSE fwgrade (docs\FRAMEWORK_class_codigo_fonte.txt):
    *   AllowRowSizing=.F. GridLineColor=238,238,238 HighlightBackColor=90,90,90
    *
    * As SETE colunas, na ordem dos registros do SCX (Column1..Column7) e com o
    * ColumnOrder que define a ordem em que o usuario as VE:
    *
    *   Column  Nome legado  ColumnOrder  Width  Header
    *   ------  -----------  -----------  -----  -------------------------
    *   6       item               1         31  (sem caption)
    *   1       PRODUTO            2        120  "Servico"
    *   7       Descricao          3        404  "Descricao do Servico"
    *   2       QTD                4        120  "Quantidade"
    *   3       VALOR              5        120  "Valor"
    *   4       MOEDA              6         33  "Moe"
    *   5       TOTAL              7        120  "Total"
    *
    * As Columns ficam com os nomes NATIVOS (Column1..Column7): renomear Column
    * quebra TODAS as referencias .ColumnN do restante do form. O nome legado de
    * cada uma vai em comentario, que eh o que permite rastrear o dump.
    *
    * Aqui entra SO o que NAO depende de dado. O RecordSource, os sete
    * ControlSource, a InputMask calculada da coluna VALOR e o DynamicForeColor
    * da coluna QTD ficam em CarregarLista: neste ponto do Init os cursores do
    * chamador ainda nao foram alcancados e amarrar Column.ControlSource a um
    * alias inexistente derruba o Init - o CREATEOBJECT devolveria .F. e o
    * usuario acionaria o menu sem nada acontecer.
    *
    * GRID NASCE AUTO-LIGADO AO ALIAS CORRENTE - E ISSO GRAVA NO CURSOR
    * ---------------------------------------------------------------
    * Medido no VFP9: AddObject("grd", "Grid") com um alias selecionado devolve
    * a grade JA ligada a ele - RecordSourceType = 1 e RecordSource com o nome
    * do alias, ColumnCount igual ao numero de campos do cursor. Ao reduzir o
    * ColumnCount para 7 as colunas continuam ligadas, cada uma a um campo do
    * cursor acidental (Column1 -> 1o campo, Column2 -> 2o, ...). A partir dai
    * QUALQUER atribuicao a Column<N>.Text1.Value ESCREVE no cursor atraves do
    * vinculo. Com as duas que o dump pede (Column5 e Column6 com Value = 0) o
    * resultado medido foi o 5o campo do cursor corrente virando 0 e o 6o
    * virando "0" - sem erro, sem log, sem aviso. Este dialogo abre a partir de
    * um form de movimento e roda na sessao de dados DELE, entao o alias
    * corrente eh um cursor VIVO do documento: o estrago seria corromper dois
    * campos do registro corrente do chamador so por abrir a tela.
    *
    * Por isso, logo depois do ColumnCount, o vinculo acidental eh desfeito -
    * RecordSource vazio e ControlSource de TODAS as colunas em branco - ANTES
    * de qualquer propriedade de Text1. Medido: com o vinculo desfeito o cursor
    * fica intacto, o ColumnCount continua 7, e a ligacao de verdade feita em
    * CarregarLista funciona normalmente. Isso tambem evita que a grade EXIBA um
    * cursor alheio quando a tela abre sem os cursores do chamador (ai
    * VincularGrade sai cedo e, sem esta limpeza, a grade mostraria o que
    * estivesse selecionado).
    *
    * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh o canonico dos
    * grids criados por AddObject em form OPERACIONAL, e sem ele a barra de
    * marcacao aparece na lateral esquerda, que o legado nao tem.
    *
    * O TabIndex = 5 do dump NAO eh transcrito aqui de proposito: com AddObject
    * o VFP9 numera pela ordem de criacao, e atribuir um valor isolado (ou
    * duplicado, ou fora da faixa de controles que ja existem) eh DESCARTADO em
    * silencio. A ordem de tabulacao exige um passe unico sobre TODOS os
    * controles focalizaveis, em ordem ascendente, depois do ultimo AddObject -
    * o que so pode acontecer quando os campos da Fase 5 existirem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_nI

        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- Desfaz o vinculo que a grade herda do alias corrente (ver nota
        *-- acima): sem isto, as atribuicoes a Text1.Value abaixo GRAVAM no
        *-- cursor do chamador. Tem de vir ANTES de tudo o que mexe em Text1.
        THIS.grd_4c_Dados.ColumnCount  = 7
        THIS.grd_4c_Dados.RecordSource = ""

        FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
            THIS.grd_4c_Dados.Columns(loc_nI).ControlSource = ""
        ENDFOR

        WITH THIS.grd_4c_Dados
            .Top                = 172
            .Left               = 12
            .Width              = 986
            .Height             = 408
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HeaderHeight       = 20
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(90, 90, 90)
            .ToolTipText        = "Grade de Itens"
            .Visible            = .T.
        ENDWITH

        *-- Column1 = PRODUTO ("Servico") - codigo do servico, char(14) na
        *-- tabela; o dump limita a digitacao em 10 (MaxLength do Text1), que eh
        *-- o que se transcreve - 10 cabe em char(14) e nao trunca na gravacao
        WITH THIS.grd_4c_Dados.Column1
            .FontName    = "Verdana"
            .FontSize    = 8
            .ColumnOrder = 2
            .Width       = 120
            .Movable     = .F.
            .Resizable   = .F.
            .Format      = "K!"
            .InputMask   = "!!!!!!!!!!"
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Servi" + CHR(231) + "o"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Format      = "K!"
            .InputMask   = "!!!!!!!!!!"
            .Margin      = 0
            .MaxLength   = 10
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column2 = QTD ("Quantidade")
        WITH THIS.grd_4c_Dados.Column2
            .FontName    = "Verdana"
            .FontSize    = 8
            .ColumnOrder = 4
            .Width       = 120
            .Movable     = .F.
            .Resizable   = .F.
            .InputMask   = "99999.999"
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Quantidade"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .InputMask   = "99999.999"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column3 = VALOR ("Valor"); a InputMask definitiva eh calculada em
        *-- CarregarLista a partir das casas decimais da operacao, como no
        *-- legado. A do dump fica aqui para a grade nao abrir sem mascara caso
        *-- a configuracao da operacao nao esteja disponivel.
        WITH THIS.grd_4c_Dados.Column3
            .FontName    = "Verdana"
            .FontSize    = 8
            .Bound       = .T.
            .ColumnOrder = 5
            .Width       = 120
            .Movable     = .F.
            .Resizable   = .F.
            .InputMask   = "9999,999.99"
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Valor"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .InputMask   = "9999,999.99"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column4 = MOEDA ("Moe") - o dump NAO declara InputMask nesta coluna
        WITH THIS.grd_4c_Dados.Column4
            .FontName    = "Verdana"
            .FontSize    = 8
            .Bound       = .T.
            .ColumnOrder = 6
            .Width       = 33
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Moe"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column5 = TOTAL ("Total"); o dump traz InputMask "999999,999.99" na
        *-- Column e "999,999,999.99" no Text1 - os dois sao transcritos como
        *-- estao, porque eh o Text1 que desenha a celula
        WITH THIS.grd_4c_Dados.Column5
            .FontName    = "Verdana"
            .FontSize    = 8
            .ColumnOrder = 7
            .Width       = 120
            .Movable     = .F.
            .Resizable   = .F.
            .InputMask   = "999999,999.99"
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Total"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column6 = item (numero sequencial da linha, sem caption no header)
        WITH THIS.grd_4c_Dados.Column6
            .FontName    = "Verdana"
            .FontSize    = 8
            .ColumnOrder = 1
            .Width       = 31
            .Movable     = .F.
            .Resizable   = .F.
            .InputMask   = "999"
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column6.Header1
            .FontName = "Verdana"
            .FontSize = 8
            .Caption  = ""
        ENDWITH

        WITH THIS.grd_4c_Dados.Column6.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Value       = 0
            .InputMask   = "999"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Column7 = Descricao ("Descricao do Servico") - a mais larga; o dump
        *-- NAO declara ReadOnly no Text1 dela (fica no default .F.)
        WITH THIS.grd_4c_Dados.Column7
            .FontName    = "Verdana"
            .FontSize    = 8
            .ColumnOrder = 3
            .Width       = 404
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column7.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Servi" + CHR(231) + "o"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column7.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Quarta porta do lookup das celulas: o duplo clique que nao chega a
        *-- celula e sim ao proprio Grid. As outras tres (Valid, F4/F5 e duplo
        *-- clique dentro da celula) moram na subclasse de TextBox instalada
        *-- por InstalarCelulasLookup - BINDEVENT em "Valid" de TextBox de
        *-- Column nao eh confiavel (regra #46)
        BINDEVENT(THIS.grd_4c_Dados, "DblClick", THIS, "GradeDblClick")

        *-- Celulas de lookup das colunas Servico/Descricao. Instaladas ja aqui
        *-- para que existam mesmo quando os cursores do chamador nao estao
        *-- abertos (VincularGrade sai cedo nesse caso); reinstaladas la depois
        *-- de cada rebind, que devolve CurrentControl/Sparse ao default
        THIS.InstalarCelulasLookup()

        *-- Idem para as celulas de quantidade e de valor, e para o ReadOnly
        *-- das tres colunas somente-exibicao (o "Return .f." do When delas)
        THIS.InstalarCelulasEdicao()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesServico - a barra dos tres botoes de servico do legado.
    *
    * Legado (todos Top=87 Height=40 Width=120, Comic Sans MS 8 bold italic,
    * MousePointer=15, PicturePosition=1, ForeColor=0,0,0, BackColor=255,255,255
    * e - o que mais importa - Visible = .F.):
    *
    *   btnTotItens  Left= 18  "\<Total de Servicos"  geral_calculadora_60.jpg
    *   btnCotacao   Left=138  "E\<xcluir Servicos"   cadastro_excluir_60.jpg
    *   btnAltImps   Left=258  "Alterar \<Valores"    geral_pastas_60.jpg
    *
    * Os tres nascem OCULTOS e sao mostrados em runtime; por isso estao na lista
    * de excecao de TornarControlesVisiveis, que de outro modo apagaria esse
    * estado inicial. Os handlers de Click e os respectivos When (que no legado
    * so liberam os botoes em INSERIR/ALTERAR e com linha posicionada) entram na
    * Fase 7, junto com os demais eventos da grade.
    *
    * O "\<" de cada Caption eh a marca de tecla de atalho do VFP (T, x, V) -
    * transcrita literalmente, senao o usuario perde o atalho do legado.
    *
    * UNICO desvio do dump: Themes. O SCX declara Themes = .F., mas em
    * CommandButton AVULSO (fora de CommandGroup) com .Picture o par
    * Themes = .F. + Enabled = .F. faz o VFP NAO desenhar o icone - sobraria so
    * o texto. O canonico do projeto para esse caso eh Themes = .T. com
    * DisabledPicture apontando para a MESMA imagem, que preserva o icone nos
    * dois estados. Buttons(N) DENTRO de CommandGroup mantem Themes = .F. (ver
    * ConfigurarBotaoRetornar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesServico()
        THIS.AddObject("cmd_4c_BtnTotItens", "CommandButton")

        WITH THIS.cmd_4c_BtnTotItens
            .AutoSize        = .F.
            .Top             = 87
            .Left            = 18
            .Height          = 40
            .Width           = 120
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "\<Total de Servi" + CHR(231) + "os"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .PicturePosition = 1
            .MousePointer    = 15
            .ToolTipText     = "Total dos Servi" + CHR(231) + "os"
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnCotacao", "CommandButton")

        WITH THIS.cmd_4c_BtnCotacao
            .AutoSize        = .F.
            .Top             = 87
            .Left            = 138
            .Height          = 40
            .Width           = 120
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "E\<xcluir Servi" + CHR(231) + "os"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 1
            .MousePointer    = 15
            .ToolTipText     = "Excluir Servi" + CHR(231) + "os da Grade"
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH

        *-- btnAltImps eh o UNICO dos tres com WordWrap = .F. no dump
        THIS.AddObject("cmd_4c_BtnAltImps", "CommandButton")

        WITH THIS.cmd_4c_BtnAltImps
            .AutoSize        = .F.
            .Top             = 87
            .Left            = 258
            .Height          = 40
            .Width           = 120
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .F.
            .Caption         = "Alterar \<Valores"
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .PicturePosition = 1
            .MousePointer    = 15
            .ToolTipText     = "Alterar Valores de Servi" + CHR(231) + "os"
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoRetornar - cntOK do legado (o unico botao sempre visivel).
    *
    * Legado:
    *   cntOK (commandgroup) AutoSize=.T. ButtonCount=1 BackStyle=0
    *                        BorderStyle=0 Value=0 Top=-2 Left=968
    *                        Width=85 Height=85 SpecialEffect=1
    *                        BorderColor=136,189,188 Themes=.F.
    *   cntOK.btnSair        Top=5 Left=5 Width=75 Height=75 Cancel=.T.
    *                        Caption="Retornar" cadastro_salvar_60.jpg
    *                        Comic Sans MS 8 bold italic WordWrap=.T.
    *                        MousePointer=15 SpecialEffect=0 Themes=.F.
    *
    * O nome migrado eh cmg_4c_CntOK e NAO o obj_4c_CntOK do mapeamento.json:
    * o gerador do mapeamento nao reconhece CommandGroup e cai no prefixo
    * generico obj_4c_. O canonico do projeto para CommandGroup eh cmg_4c_ (eh o
    * que docs\framework_frmcadastro_layout.md usa em cmg_4c_Botoes), e o
    * mapeamento.json desta task foi corrigido junto.
    *
    * O BOTAO INTERNO eh configurado ANTES de posicionar o grupo: com
    * AutoSize = .T. eh a geometria do membro que DEFINE o tamanho do grupo
    * (75x75 em 5,5 resulta nos 85x85 que o dump declara). Themes do membro fica
    * .F., como o dump pede - a excecao do Themes = .T. vale para CommandButton
    * avulso, nao para membro de grupo.
    *
    * Cancel = .T. eh o que faz o Esc acionar este botao, como anuncia o
    * ToolTipText do legado. O handler de Click (que devolve o chamador e fecha o
    * dialogo, com a validacao de tamanhos do cntOK.Click legado) entra na
    * Fase 7; a reabilitacao do chamador ja esta garantida pelo Destroy.
    *
    * O Caption "Retornar" NAO leva a marca "\<": o dump nao declara atalho de
    * teclado neste botao, so o Cancel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoRetornar()
        THIS.AddObject("cmg_4c_CntOK", "CommandGroup")

        THIS.cmg_4c_CntOK.ButtonCount = 1

        *-- Membro interno (btnSair do legado) - define o tamanho do grupo
        WITH THIS.cmg_4c_CntOK.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "Retornar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Cancel          = .T.
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + ;
                               CHR(231) + CHR(227) + "o"
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_CntOK
            .AutoSize      = .T.
            .Top           = -2
            .Left          = 968
            .Width         = 85
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Value         = 0
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainelTamanho - cntTamanho do legado.
    *
    * Legado: cntTamanho Top=120 Left=643 Width=160 Height=52
    *                    BackStyle=0 BorderWidth=0
    *
    * Painel TRANSPARENTE (BackStyle = 0) a direita dos campos do produto, que
    * agrupa o rotulo "Tamanho" e os campos De/Para. O dump NAO declara
    * Visible = .F. nele, logo ele nasce visivel - o legado o esconde e mostra
    * em runtime, no AfterRowColChange da grade, conforme crTpmMvItn3.iconfs
    * (handler que entra na Fase 7, junto com a grade a que ele pertence).
    *
    * Container NAO tem BorderStyle (so BorderWidth) - atribuir BorderStyle
    * aqui faria a tela nao abrir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainelTamanho()
        THIS.AddObject("cnt_4c_Tamanho", "Container")

        WITH THIS.cnt_4c_Tamanho
            .Top           = 120
            .Left          = 643
            .Width         = 160
            .Height        = 52
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposProduto - Identificacao do produto (Label1 + os tres
    * Get_* diretos da Form) e os tres rotulos internos de cnt_4c_Tamanho.
    *
    * Legado (SIGOPSER - propriedades, SECAO 1 do dump):
    *   Label1        AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Produto"
    *                 Top=128 Left=20 Width=40 Height=15 ForeColor=90,90,90
    *   Get_Produto   FontName="Courier New" Top=143 Left=20 Width=112 Height=23
    *                 ForeColor=90,90,90 BackColor=253,250,185
    *                 DisabledBackColor=255,255,220 BorderColor=90,90,90
    *                 SpecialEffect=1 ReadOnly=.F. ToolTipText="Codigo do Produto"
    *   Get_Descricao mesmo estilo, Top=143 Left=134 Width=459 Height=23
    *                 ToolTipText="Descricao do Produto"
    *   Get_Mercs     mesmo estilo, Top=143 Left=595 Width=50 Height=23
    *                 ToolTipText="Descricao do Produto" (sic - o dump legado
    *                 repete o tooltip de Get_Descricao neste campo; transcrito
    *                 literal, nao eh erro de migracao)
    *
    *   cntTamanho.Label2  AutoSize=.T. Tahoma 12 bold BackStyle=0
    *                      Caption="Tamanho" Top=3 Left=8 Width=78 Height=21
    *                      ForeColor=90,90,90
    *   cntTamanho.Say43   Tahoma 8 Caption="De:"   Top=27 Left=13 (sem Width -
    *                      classe say pura, ver nota abaixo)
    *   cntTamanho.Say1    Tahoma 8 Caption="Para:" Top=27 Left=84 (idem)
    *
    * Os TRES campos de produto sao so EXIBICAO nesta fase: o legado os
    * preenche por codigo a partir de CrTmpPro (apaite/mInsereLinha,
    * "ThisForm.Get_Produto.Value = crTpmMvItn.Cpros" etc.) quando a grade
    * muda de linha - esse disparo (AfterRowColChange da grade) entra na
    * Fase 7 junto com os demais eventos. O When de Get_Produto/Get_Descricao
    * no dump sempre "Return .f." (nunca editaveis por digitacao direta); o
    * BINDEVENT que reproduz esse gate tambem fica para a Fase 7, pelo mesmo
    * motivo das regras #3/#47 (handler incompleto ligado agora quebraria
    * sem o resto do fluxo). .ReadOnly = .F. e .Value = "" aqui sao so o
    * estado inicial, igual ao dump.
    *
    * MaxLength de cada TextBox vem da LARGURA DA COLUNA no schema (regra
    * #19), nao do Width em pixels - o dump nao declara MaxLength nenhum:
    *   SigCdPro.cpros  char(14) -> txt_4c_Produto.MaxLength   = 14
    *   SigCdPro.dpros  char(65) -> txt_4c_Descricao.MaxLength = 65
    *   SigCdPro.mercs  char(3)  -> txt_4c_Mercs.MaxLength     = 3
    *
    * FontSize = 9 dos tres TextBox NAO eh inventado: o dump so declara
    * FontName = "Courier New" nestes tres, mas a SECAO 1 do mesmo dump traz
    * a tabela de metricas de fonte do form ("Courier New, 0, 9, 7, 15, 12,
    * 9, 3, 0") - o 3o campo eh o tamanho, e bate com o uso de Tahoma/
    * Verdana/Comic Sans MS em outros controles deste mesmo form (campo na
    * mesma posicao = 8 nos tres, que eh o FontSize ja usado em
    * ConfigurarCabecalho/ConfigurarGrade/ConfigurarBotoesServico).
    *
    * Label1 ("Produto") DECLARA Width/Height no dump (40/15): sao os valores
    * ja calculados pelo Form Designer, logo fixa-los com AutoSize = .F. eh
    * reproducao fiel (regra #23), nao desvio.
    *
    * Say43/Say1 NAO declaram Width/Height - sao a classe "say" pura
    * (AutoSize=.T./Alignment=0 por default), e AutoSize = .T. eh NO-OP em
    * Label criado por AddObject (regra #23). Usa-se .Alignment = 0 com
    * .Width calculado para o texto terminar poucos pixels antes do campo
    * vizinho (mesmo padrao do FormCES citado na regra #23): Say43 "De:" em
    * Left=13 termina em 13+18=31, 4px antes de getTamDe (Left=35 - Fase 6);
    * Say1 "Para:" em Left=84 termina em 84+28=112, 4px antes de getTamPara
    * (Left=116 - Fase 6). cntTamanho.Label2 ("Tamanho") JA declara
    * Width/Height (78/21) e segue o mesmo tratamento de Label1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposProduto()
        *-- Label1 - rotulo "Produto"
        THIS.AddObject("lbl_4c_Label1", "Label")

        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Produto"
            .Top       = 128
            .Left      = 20
            .Width     = 40
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Produto -> txt_4c_Produto (codigo do produto)
        THIS.AddObject("txt_4c_Produto", "TextBox")

        WITH THIS.txt_4c_Produto
            .Top               = 143
            .Left              = 20
            .Width             = 112
            .Height            = 23
            .FontName          = "Courier New"
            .FontSize          = 9
            .Value             = ""
            .MaxLength         = 14
            .ReadOnly          = .F.
            .SpecialEffect     = 1
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(253, 250, 185)
            .DisabledBackColor = RGB(255, 255, 220)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "C" + CHR(243) + "digo do Produto"
            .Visible           = .T.
        ENDWITH

        *-- Get_Descricao -> txt_4c_Descricao
        THIS.AddObject("txt_4c_Descricao", "TextBox")

        WITH THIS.txt_4c_Descricao
            .Top               = 143
            .Left              = 134
            .Width             = 459
            .Height            = 23
            .FontName          = "Courier New"
            .FontSize          = 9
            .Value             = ""
            .MaxLength         = 65
            .ReadOnly          = .F.
            .SpecialEffect     = 1
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(253, 250, 185)
            .DisabledBackColor = RGB(255, 255, 220)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Visible           = .T.
        ENDWITH

        *-- Get_Mercs -> txt_4c_Mercs (mercadologico do produto)
        THIS.AddObject("txt_4c_Mercs", "TextBox")

        WITH THIS.txt_4c_Mercs
            .Top               = 143
            .Left              = 595
            .Width             = 50
            .Height            = 23
            .FontName          = "Courier New"
            .FontSize          = 9
            .Value             = ""
            .MaxLength         = 3
            .ReadOnly          = .F.
            .SpecialEffect     = 1
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(253, 250, 185)
            .DisabledBackColor = RGB(255, 255, 220)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Visible           = .T.
        ENDWITH

        *-- cntTamanho.Label2 -> cnt_4c_Tamanho.lbl_4c_Label2 ("Tamanho")
        THIS.cnt_4c_Tamanho.AddObject("lbl_4c_Label2", "Label")

        WITH THIS.cnt_4c_Tamanho.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Tamanho"
            .Top       = 3
            .Left      = 8
            .Width     = 78
            .Height    = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cntTamanho.Say43 -> cnt_4c_Tamanho.lbl_4c_Label43 ("De:")
        THIS.cnt_4c_Tamanho.AddObject("lbl_4c_Label43", "Label")

        WITH THIS.cnt_4c_Tamanho.lbl_4c_Label43
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "De:"
            .Top       = 27
            .Left      = 13
            .Width     = 18
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cntTamanho.Say1 -> cnt_4c_Tamanho.lbl_4c_Label1 ("Para:")
        THIS.cnt_4c_Tamanho.AddObject("lbl_4c_Label1", "Label")

        WITH THIS.cnt_4c_Tamanho.lbl_4c_Label1
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Para:"
            .Top       = 27
            .Left      = 84
            .Width     = 28
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTamanho - getTamDe/getTamPara do legado (Fase 6).
    *
    * Legado (classe fwget, framework.vcx - docs\FRAMEWORK_class_codigo_fonte.txt):
    *   FontName="Tahoma" FontSize=8 Format="K" Height=23 Width=100
    *   DisabledBackColor=192,192,192 DisabledForeColor=0,0,0 Themes=.F.
    *
    * O dump do SCX (SIGOPSER.cntTamanho.getTamDe/getTamPara) so sobrescreve
    * Height/Left/SpecialEffect/TabIndex/Top/Width - o resto fica no default
    * da classe acima, inclusive Format = "K" (seleciona o conteudo ao
    * entrar no campo - severidade BAIXA da regra #49, nao InputMask):
    *
    *   getTamDe   Top=23 Left=35  Width=38 Height=23 SpecialEffect=1
    *   getTamPara Top=23 Left=116 Width=38 Height=23 SpecialEffect=1
    *
    * MaxLength = 4 nos dois: SigCdTam.cods eh char(4) (regra #19) - o dump
    * nunca declara MaxLength nestes dois campos.
    *
    * Lookup (tasks\task801\sigopser_form_codigo_fonte.txt, PROCEDURE Valid
    * de ambos os campos):
    *   CreateObject('fwbuscaext', ..., 'SigCdTam', 'CrListaRemota', 'Cods',
    *                This.Value, 'Selecao', .t.) + mAddColuna(Cods/Descs) +
    *   Replace TamDe/TamPara With This.Value In crTpmMvItn3
    *
    * Migrado para o padrao canonico do projeto: FormBuscaAuxiliar com
    * parametros (match exato primeiro, Show() so se nao achou - regra #37),
    * ligado em LostFocus (regra #47 - o legado valida no Valid, ao SAIR do
    * campo) e tambem em Enter/Tab/F4 via KeyPress delegando ao mesmo corpo.
    * Guarda de reentrancia por campo (this_lEmLookupTamDe/TamPara): o
    * picker eh modal e tira o foco, o que redispara o proprio LostFocus.
    *
    * A gravacao eh no REGISTRO CORRENTE de crTpmMvItn3 - a mesma premissa do
    * legado (o painel so fica visivel, via AfterRowColChange na Fase 7,
    * enquanto a linha da grade continua corrente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTamanho()
        THIS.cnt_4c_Tamanho.AddObject("txt_4c_TamDe", "TextBox")

        WITH THIS.cnt_4c_Tamanho.txt_4c_TamDe
            .Top               = 23
            .Left              = 35
            .Width             = 38
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .Value             = ""
            .MaxLength         = 4
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .ToolTipText       = "Tamanho Inicial"
            .Visible           = .T.
        ENDWITH

        THIS.cnt_4c_Tamanho.AddObject("txt_4c_TamPara", "TextBox")

        WITH THIS.cnt_4c_Tamanho.txt_4c_TamPara
            .Top               = 23
            .Left              = 116
            .Width             = 38
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .Value             = ""
            .MaxLength         = 4
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .ToolTipText       = "Tamanho Final"
            .Visible           = .T.
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamDe, "LostFocus", THIS, "ValidarTamDeLostFocus")
        BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamDe, "KeyPress", THIS, "ValidarTamDeKeyPress")

        BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamPara, "LostFocus", THIS, "ValidarTamParaLostFocus")
        BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamPara, "KeyPress", THIS, "ValidarTamParaKeyPress")

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTamDeKeyPress / ValidarTamDeLostFocus / ValidarTamDeExec -
    * lookup de SigCdTam para o campo "De:" do painel Tamanho.
    *
    * PUBLIC: metodo PROTECTED ligado por BINDEVENT estoura em runtime (regra
    * #3). ValidarTamDeKeyPress so delega em ENTER(13)/TAB(9)/F4(115) - sem
    * esse teste o picker abriria a cada tecla digitada (regra #47).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTamDeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarTamDeLostFocus()
        ENDIF

        RETURN
    ENDPROC

    PROCEDURE ValidarTamDeLostFocus()
        LOCAL loc_lAnterior

        loc_lAnterior = THIS.this_lEmLookupTamDe

        IF loc_lAnterior
            RETURN
        ENDIF

        THIS.this_lEmLookupTamDe = .T.
        THIS.ValidarTamDeExec()
        THIS.this_lEmLookupTamDe = loc_lAnterior

        RETURN
    ENDPROC

    PROTECTED PROCEDURE ValidarTamDeExec()
        LOCAL loc_oTxt, loc_cCodigo

        loc_oTxt = THIS.cnt_4c_Tamanho.txt_4c_TamDe

        IF !EMPTY(ALLTRIM(loc_oTxt.Value))
            loc_cCodigo = THIS.AbrirBuscaTamanho(loc_oTxt)
        ELSE
            loc_cCodigo = ""
        ENDIF

        loc_oTxt.Value = loc_cCodigo

        *-- "Replace TamDe With This.Value In crTpmMvItn3" do legado, pela
        *-- camada: a tela vai para o BO e eh o BO que grava no cursor
        THIS.GravarLinhaCorrente()

        loc_oTxt.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTamParaKeyPress / ValidarTamParaLostFocus / ValidarTamParaExec -
    * mesma logica de ValidarTamDe*, aplicada ao campo "Para:".
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTamParaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarTamParaLostFocus()
        ENDIF

        RETURN
    ENDPROC

    PROCEDURE ValidarTamParaLostFocus()
        LOCAL loc_lAnterior

        loc_lAnterior = THIS.this_lEmLookupTamPara

        IF loc_lAnterior
            RETURN
        ENDIF

        THIS.this_lEmLookupTamPara = .T.
        THIS.ValidarTamParaExec()
        THIS.this_lEmLookupTamPara = loc_lAnterior

        RETURN
    ENDPROC

    PROTECTED PROCEDURE ValidarTamParaExec()
        LOCAL loc_oTxt, loc_cCodigo

        loc_oTxt = THIS.cnt_4c_Tamanho.txt_4c_TamPara

        IF !EMPTY(ALLTRIM(loc_oTxt.Value))
            loc_cCodigo = THIS.AbrirBuscaTamanho(loc_oTxt)
        ELSE
            loc_cCodigo = ""
        ENDIF

        loc_oTxt.Value = loc_cCodigo

        *-- "Replace TamPara With This.Value In crTpmMvItn3" do legado, pela
        *-- camada: a tela vai para o BO e eh o BO que grava no cursor
        THIS.GravarLinhaCorrente()

        loc_oTxt.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTamanho - lookup compartilhado por TamDe/TamPara em
    * SigCdTam (cods/descs), padrao canonico FormBuscaAuxiliar.
    *
    * Legado: CreateObject('fwbuscaext', ThisForm.ParentForm.poDataMgr.pnIdConn,
    *         'SigCdTam', 'CrListaRemota', 'Cods', This.Value, 'Selecao', .t.)
    *         - tenta o match EXATO primeiro (plAchouRegistro) e so abre o
    *         browse quando nao casa (regra #37). Sem conexao valida (modo de
    *         teste/validacao de UI), devolve o que o usuario digitou, sem
    *         tentar SQL - mesma guarda de CarregarConfiguracaoOperacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaTamanho(par_oTxt)
        LOCAL loc_oBusca, loc_cCodigo, loc_cDigitado

        loc_cDigitado = ALLTRIM(par_oTxt.Value)
        loc_cCodigo   = loc_cDigitado

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_cCodigo
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cDigitado, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                SELECT cursor_4c_BuscaTam
                loc_cCodigo = ALLTRIM(cods)
            ELSE
                *-- Legado: Lastkey() = 27 (ESC) limpa o campo
                loc_cCodigo = ""
            ENDIF

            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF

            loc_oBusca.Release()
        ENDIF

        RETURN loc_cCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarServicosDisponiveis - monta csSigCdPro, o universo que os dois
    * lookups da grade consultam, e os indices que o legado cria sobre ele.
    *
    * Legado (Init), transcrito:
    *
    *   =Cursorquery('SigCdPro','CrTmpPro','Cpros',crTpmMvItn.Cpros,[dpros, Mercs])
    *   ThisForm.Get_Produto.Value   = crTpmMvItn.Cpros
    *   ThisForm.Get_Descricao.Value = CrTmpPro.Dpros
    *   ThisForm.Get_Mercs.Value     = CrTmpPro.Mercs
    *   ...
    *   lcMercs = Iif(Not InList(CrTmpPro.Mercs,[JOI],[REL]),[JOI],CrTmpPro.Mercs)
    *   Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite
    *   Index On DPros Tag DPros / Index On Cpros Tag Cpros
    *   Index On Cpros + IdeCPros Tag IdeCPros / Index On DPros + IdeCPros Tag IdeDPros
    *
    * A expressao de lcMercs eh transcrita LITERAL: quando a mercadoria do
    * produto dono dos servicos nao eh JOI nem REL, o legado usa JOI - nao eh
    * um default de conveniencia, eh regra (o universo de servicos de joia
    * atende tambem as demais mercadorias).
    *
    * Os QUATRO indices do legado sao criados, mas os lookups usam LOCATE e nao
    * SEEK: os dois compostos (Cpros + IdeCPros) tem chave maior do que o valor
    * digitado, e o projeto roda com SET EXACT ON - SEEK de chave PARCIAL em
    * indice COMPOSTO devolve .F. SEMPRE, em silencio. O legado escapa disso
    * por rodar com outra configuracao; aqui a busca eh por LOCATE, que da o
    * mesmo resultado sem depender do estado de EXACT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarServicosDisponiveis()
        LOCAL loc_cCpros, loc_cMercs, loc_cMercsFiltro, loc_cLista, loc_nAreaAnterior

        loc_nAreaAnterior = SELECT()
        loc_cLista        = THIS.this_cCursorLista
        loc_cCpros        = ""

        *-- Codigo do produto dono dos servicos (crTpmMvItn.Cpros no legado)
        IF USED(THIS.this_cCursorItem)
            SELECT (THIS.this_cCursorItem)

            IF !EOF() AND TYPE(THIS.this_cCursorItem + ".cpros") = "C"
                loc_cCpros = ALLTRIM(cpros)
            ENDIF
        ENDIF

        *-- Mercadoria do produto; a descricao dele vem de carona, como no
        *-- Cursorquery legado que traz dpros junto com Mercs. As tres ficam
        *-- nas propriedades de ITEM do BO (this_c*Item), separadas das da
        *-- linha de servico
        THIS.this_oBusinessObject.this_cCprosItem = loc_cCpros
        loc_cMercs = THIS.this_oBusinessObject.ObterMercadoriaProduto(loc_cCpros)

        *-- O default "JOI" vale so para FILTRAR o universo de servicos: o
        *-- legado exibe em Get_Mercs a mercadoria CRUA do produto e so depois
        *-- calcula lcMercs para o Select de csSigCdPro
        loc_cMercsFiltro = IIF(!INLIST(loc_cMercs, "JOI", "REL"), "JOI", loc_cMercs)

        *-- Os tres campos de identificacao do produto, como no Init legado
        THIS.BOParaForm()

        IF THIS.this_oBusinessObject.CarregarServicosDisponiveis(loc_cLista, loc_cMercsFiltro)
            SELECT (loc_cLista)
            INDEX ON DPros TAG DPros
            INDEX ON Cpros TAG Cpros
            INDEX ON Cpros + IdeCPros TAG IdeCPros
            INDEX ON DPros + IdeCPros TAG IdeDPros
            GO TOP
        ENDIF

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * InstalarCelulasLookup - poe nas colunas "Servico" (Column1) e "Descricao"
    * (Column7) os TextBox que carregam o When/Valid do legado.
    *
    * O legado tem o lookup no Valid do Text1 de CADA coluna. BINDEVENT em
    * "Valid" de TextBox de Column NAO eh confiavel (regra #46), por isso o
    * evento mora numa SUBCLASSE de TextBox posta na Column com AddObject +
    * CurrentControl + Sparse = .F. (regra #18 - sem o CurrentControl o
    * controle eh criado e a coluna continua desenhando o Text1 dela).
    *
    * As quatro portas de entrada do mesmo lookup desaguam no MESMO funil
    * (AbrirBuscaServicoGrade / AbrirBuscaDescricaoGrade), guardado pela
    * respectiva flag this_lEmLookup*:
    *
    *   Valid da celula          -> subclasse (o caminho do legado)
    *   F4/F5 dentro da celula   -> KeyPress da MESMA subclasse
    *   duplo clique na celula   -> DblClick da MESMA subclasse
    *   duplo clique fora dela   -> BINDEVENT(grade, "DblClick", ...)
    *
    * Chamado por VincularGrade, nao so na inicializacao: atribuir
    * RecordSource/ControlSource devolve Sparse e CurrentControl ao default, e
    * a celula voltaria a ser o Text1 original sem o lookup.
    *
    * As propriedades visuais repetem as do Text1 configurado na Fase 4 - eh o
    * controle da subclasse que passa a desenhar a celula, entao sem elas a
    * coluna perderia fonte, mascara e borda.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InstalarCelulasLookup()
        IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelServico", 5)
            THIS.grd_4c_Dados.Column1.AddObject("txt_4c_CelServico", "TextBoxServicoSer_4c")
        ENDIF

        WITH THIS.grd_4c_Dados.Column1.txt_4c_CelServico
            .FontName       = "Verdana"
            .FontSize       = 8
            .BorderStyle    = 0
            .Format         = "K!"
            .InputMask      = "!!!!!!!!!!"
            .Margin         = 0
            .MaxLength      = 10
            .ReadOnly       = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 255)
            .ToolTipText    = "C" + CHR(243) + "digo do Servi" + CHR(231) + ;
                              "o - F4 abre a lista"
            .Visible        = .T.
        ENDWITH

        IF !PEMSTATUS(THIS.grd_4c_Dados.Column7, "txt_4c_CelDescricao", 5)
            THIS.grd_4c_Dados.Column7.AddObject("txt_4c_CelDescricao", "TextBoxDescricaoSer_4c")
        ENDIF

        WITH THIS.grd_4c_Dados.Column7.txt_4c_CelDescricao
            .FontName       = "Verdana"
            .FontSize       = 8
            .BorderStyle    = 0
            .Margin         = 0
            .MaxLength      = 65
            .ReadOnly       = .F.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 255)
            .ToolTipText    = "Descri" + CHR(231) + CHR(227) + "o do Servi" + ;
                              CHR(231) + "o - F4 abre a lista"
            .Visible        = .T.
        ENDWITH

        *-- CurrentControl por ULTIMO, e so depois Sparse/ReadOnly: o ReadOnly
        *-- da COLUNA tem de vir depois do ReadOnly do GRID, que propaga para
        *-- as colunas e sobrescreveria o valor posto aqui (regra #18)
        WITH THIS.grd_4c_Dados.Column1
            .CurrentControl = "txt_4c_CelServico"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column7
            .CurrentControl = "txt_4c_CelDescricao"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaServicoLiberada / CelulaDescricaoLiberada - o When de cada coluna.
    *
    * Legado (PRODUTO.Text1.When):
    *   Select crTpmMvItn3
    *   ThisForm.AntCPro = This.Value
    *   ThisForm.AntValu = crTpmMvItn.Units
    *   Return Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])
    *
    * Legado (Descricao.Text1.When): identico, mas o Return traz
    *   And Empty(crTpmMvItn3.Cpros) - a descricao so aceita digitacao enquanto
    * a linha NAO tem codigo; preenchido o codigo, a descricao vem dele.
    *
    * PUBLIC: sao chamados pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaServicoLiberada(par_oTxt)
        THIS.GuardarValorAnterior(par_oTxt)

        RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    PROCEDURE CelulaDescricaoLiberada(par_oTxt)
        LOCAL loc_lSemCodigo

        THIS.GuardarValorAnterior(par_oTxt)

        loc_lSemCodigo = .T.

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)
            loc_lSemCodigo = EOF() OR EMPTY(ALLTRIM(cpros))
        ENDIF

        RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") AND loc_lSemCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * GuardarValorAnterior - as duas primeiras linhas do When das duas colunas.
    * AntCPro guarda o que havia na celula antes da edicao (o Valid compara os
    * dois para saber se o servico mudou) e AntValu, o valor unitario do item.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GuardarValorAnterior(par_oTxt)
        IF VARTYPE(par_oTxt) = "O"
            THIS.this_cAntCPro = par_oTxt.Value
        ENDIF

        IF USED(THIS.this_cCursorItem)
            SELECT (THIS.this_cCursorItem)

            IF !EOF() AND TYPE(THIS.this_cCursorItem + ".units") = "N"
                THIS.this_cAntValu = units
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCelulaServico / ValidarCelulaDescricao - o Valid de cada coluna.
    *
    * Wrapper fino da guarda de reentrancia: o picker eh modal, devolve o foco
    * a celula e faria o Valid disparar de novo. A flag eh liberada no wrapper,
    * e nao no corpo, porque o corpo tem RETURN antecipado - liberar la dentro
    * deixaria a flag ligada para sempre e MATARIA o lookup (regra #47).
    * Save/restore em vez de set/clear: as portas de F4 e duplo clique chamam
    * este mesmo funil, e um clear simples liberaria a flag cedo demais.
    *
    * PUBLIC: chamados pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCelulaServico(par_oTxt)
        LOCAL loc_lAnterior

        loc_lAnterior = THIS.this_lEmLookupServico

        IF loc_lAnterior
            RETURN .T.
        ENDIF

        THIS.this_lEmLookupServico = .T.
        THIS.AbrirBuscaServicoGrade(par_oTxt)
        THIS.this_lEmLookupServico = loc_lAnterior

        RETURN .T.
    ENDPROC

    PROCEDURE ValidarCelulaDescricao(par_oTxt)
        LOCAL loc_lAnterior

        loc_lAnterior = THIS.this_lEmLookupDescricao

        IF loc_lAnterior
            RETURN .T.
        ENDIF

        THIS.this_lEmLookupDescricao = .T.
        THIS.AbrirBuscaDescricaoGrade(par_oTxt)
        THIS.this_lEmLookupDescricao = loc_lAnterior

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDblClick - a quarta porta do lookup: duplo clique que chega ao
    * proprio Grid, e nao a celula. Encaminha para o funil da coluna em que o
    * usuario clicou; qualquer outra coluna eh ignorada.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDblClick()
        DO CASE
            CASE THIS.grd_4c_Dados.ActiveColumn = 1
                THIS.ValidarCelulaServico(THIS.grd_4c_Dados.Column1.txt_4c_CelServico)
            CASE THIS.grd_4c_Dados.ActiveColumn = 7
                THIS.ValidarCelulaDescricao(THIS.grd_4c_Dados.Column7.txt_4c_CelDescricao)
        ENDCASE

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaServicoGrade - lookup da coluna "Servico" em csSigCdPro.
    *
    * Legado (PRODUTO.Text1.Valid):
    *   Select csSigCdPro
    *   Set Order to CPros
    *   If !Seek(This.Value,[csSigCdPro],[IdeCPros])
    *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','Cpros',This.Value,
    *                               'Cadastro de Produtos')
    *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
    *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
    *       loBrowse.Show
    *       This.Value = CsSigCdPro.Cpros
    *   Endif
    *   Replace crTpmMvItn3.cpros with CrTmpPro.CPROS in crTpmMvItn3
    *
    * O browse eh sobre CURSOR LOCAL ja populado (fwbuscasel, nao fwbuscaext):
    * a forma equivalente no projeto eh o FormBuscaAuxiliar sem parametros +
    * DefinirCursor + Mostrar() - o Init com parametros consultaria o SQL
    * Server e ignoraria o universo que CarregarServicosDisponiveis montou.
    *
    * DefinirCursor ZERA as colunas e as readiciona usando o NOME DO CAMPO como
    * caption; por isso this_nColunas eh zerado e as duas colunas sao remontadas
    * com os captions do legado ("Codigo"/"Descricao"), senao a grade do picker
    * abriria com cabecalho "Cpros"/"Dpros".
    *
    * O codigo digitado NAO eh apagado quando o usuario desiste (regra #50):
    * so o que o legado apaga - nada - eh apagado. Universo vazio tambem nao
    * gera aviso: operacao sem servicos habilitados tem lista vazia por regra.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaServicoGrade(par_oTxt)
        LOCAL loc_cDigitado, loc_cLista, loc_oBusca, loc_lAchou

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cDigitado = ALLTRIM(par_oTxt.Value)
        loc_cLista    = THIS.this_cCursorLista

        IF EMPTY(loc_cDigitado) OR !USED(loc_cLista)
            RETURN
        ENDIF

        *-- Seek do legado, feito por LOCATE (ver nota de EXACT em
        *-- CarregarServicosDisponiveis)
        SELECT (loc_cLista)
        GO TOP
        LOCATE FOR ALLTRIM(Cpros) == loc_cDigitado
        loc_lAchou = FOUND()

        IF !loc_lAchou
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor(loc_cLista, "Cpros", "Dpros", ;
                                         "Cadastro de Produtos")
                loc_oBusca.this_nColunas = 0
                loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")

                IF loc_oBusca.Mostrar()
                    loc_lAchou = .T.
                    par_oTxt.Value = loc_oBusca.cCodigoSelecionado
                ENDIF

                loc_oBusca.Release()
            ENDIF
        ENDIF

        IF loc_lAchou
            THIS.AplicarServicoNaLinha(par_oTxt.Value)
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDescricaoGrade - lookup da coluna "Descricao" em csSigCdPro.
    *
    * Legado (Descricao.Text1.Valid):
    *   Select csSigCdPro
    *   Go Top In csSigCdPro
    *   Locate For DPros = This.Value
    *   If Eof([csSigCdPro])
    *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','DPros',This.Value,
    *                               'Cadastro de Produtos')
    *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
    *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
    *       loBrowse.Show
    *       This.Value = CsSigCdPro.DPros
    *   Endif
    *
    * A ORDEM das colunas eh invertida de proposito: na busca por descricao o
    * legado poe Descricao na frente, e eh o que o usuario ve no picker.
    *
    * O Locate do legado usa "=" (comparacao por PREFIXO quando EXACT esta
    * desligado). Como o projeto roda com SET EXACT ON, a busca eh feita em
    * duas etapas - primeiro a descricao INTEIRA, depois por prefixo - para
    * reproduzir o comportamento do legado sem depender do estado de EXACT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaDescricaoGrade(par_oTxt)
        LOCAL loc_cDigitado, loc_cLista, loc_oBusca, loc_lAchou

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cDigitado = ALLTRIM(par_oTxt.Value)
        loc_cLista    = THIS.this_cCursorLista

        IF EMPTY(loc_cDigitado) OR !USED(loc_cLista)
            RETURN
        ENDIF

        SELECT (loc_cLista)
        GO TOP
        LOCATE FOR ALLTRIM(Dpros) == loc_cDigitado

        IF !FOUND()
            GO TOP
            LOCATE FOR UPPER(ALLTRIM(Dpros)) = UPPER(loc_cDigitado)
        ENDIF

        loc_lAchou = FOUND()

        IF !loc_lAchou
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor(loc_cLista, "Dpros", "Cpros", ;
                                         "Cadastro de Produtos")
                loc_oBusca.this_nColunas = 0
                loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")

                IF loc_oBusca.Mostrar()
                    loc_lAchou = .T.
                    par_oTxt.Value = loc_oBusca.cCodigoSelecionado
                ENDIF

                loc_oBusca.Release()
            ENDIF
        ENDIF

        IF loc_lAchou
            THIS.AplicarServicoNaLinha(ALLTRIM(EVALUATE(loc_cLista + ".Cpros")))
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarServicoNaLinha - grava na linha corrente da grade o servico que o
    * lookup resolveu.
    *
    * Legado, comum aos dois Valid:
    *   Replace crTpmMvItn3.cpros with CrTmpPro.CPROS in crTpmMvItn3
    *   cpro = Evaluate('CrTmpPro.CPros') / dpro = Evaluate('crtmpPro.DPros')
    *
    * O codigo e a descricao vem do MESMO registro de csSigCdPro que o lookup
    * posicionou, entao nao ha segunda consulta a fazer: o legado so reconsulta
    * SigCdPro porque precisa das outras vinte colunas (preco, moeda, unidade)
    * usadas no calculo do item.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarServicoNaLinha(par_cCpros)
        LOCAL loc_cLista, loc_cCodigo, loc_cDescricao

        loc_cLista  = THIS.this_cCursorLista
        loc_cCodigo = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")

        IF EMPTY(loc_cCodigo) OR !USED(loc_cLista)
            RETURN
        ENDIF

        SELECT (loc_cLista)
        GO TOP
        LOCATE FOR ALLTRIM(Cpros) == loc_cCodigo

        IF !FOUND()
            RETURN
        ENDIF

        loc_cDescricao = ALLTRIM(EVALUATE(loc_cLista + ".Dpros"))

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)

            IF !EOF()
                REPLACE cpros WITH loc_cCodigo, ;
                        dpros WITH loc_cDescricao
            ENDIF
        ENDIF

        WITH THIS.grd_4c_Dados
            IF PEMSTATUS(.Column1, "txt_4c_CelServico", 5)
                .Column1.txt_4c_CelServico.Value = loc_cCodigo
            ENDIF

            IF PEMSTATUS(.Column7, "txt_4c_CelDescricao", 5)
                .Column7.txt_4c_CelDescricao.Value = loc_cDescricao
            ENDIF

            .Refresh()
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverModoOperacao - Modo de operacao herdado do chamador.
    *
    * Legado (Init):
    *   .Op_Escolha = Iif(ThisForm.Parentform.EdServicos, 'ALTERAR', ;
    *                     poForm.op_Escolha)
    *
    * Ou seja: quando o dono do documento esta em edicao de servicos, este
    * dialogo entra em ALTERAR; senao, herda o modo de quem o abriu. Os dois
    * acessos sao guardados por PEMSTATUS porque os forms chamadores ja
    * migrados nomeiam o modo de maneiras diferentes (o pcEscolha do legado
    * virou this_cOpEscolha ou this_cModoAtual conforme a tela), e ler
    * propriedade inexistente derrubaria o Init.
    *
    * Sem chamador identificado (harness de teste, abertura isolada) o modo
    * fica "VISUALIZAR": eh o modo que nao grava nada, e eh o default seguro -
    * os When do legado so liberam digitacao em INSERIR e ALTERAR.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverModoOperacao()
        LOCAL loc_cModo, loc_lEdServicos

        loc_cModo       = ""
        loc_lEdServicos = .F.

        *-- ParentForm.EdServicos do legado
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "EdServicos", 5)
                IF VARTYPE(THIS.this_oFormPai.EdServicos) = "L"
                    loc_lEdServicos = THIS.this_oFormPai.EdServicos
                ENDIF
            ENDIF
        ENDIF

        IF loc_lEdServicos
            loc_cModo = "ALTERAR"
        ELSE
            *-- poForm.op_Escolha do legado, nas grafias usadas pelos forms de
            *-- movimento ja migrados
            IF VARTYPE(THIS.this_oFormChamador) = "O"
                IF PEMSTATUS(THIS.this_oFormChamador, "this_cOpEscolha", 5)
                    IF VARTYPE(THIS.this_oFormChamador.this_cOpEscolha) = "C"
                        loc_cModo = ALLTRIM(THIS.this_oFormChamador.this_cOpEscolha)
                    ENDIF
                ENDIF

                IF EMPTY(loc_cModo) AND PEMSTATUS(THIS.this_oFormChamador, "this_cModoAtual", 5)
                    IF VARTYPE(THIS.this_oFormChamador.this_cModoAtual) = "C"
                        loc_cModo = ALLTRIM(THIS.this_oFormChamador.this_cModoAtual)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF EMPTY(loc_cModo) OR UPPER(loc_cModo) == "LISTA"
            loc_cModo = "VISUALIZAR"
        ENDIF

        THIS.this_cOpEscolha = UPPER(loc_cModo)
        THIS.this_cModoAtual = THIS.this_cOpEscolha

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContextoBO - Repassa ao BO o contexto do movimento.
    *
    * Legado (Init):
    *   Thisform.CItem   = crTpmMvItn.CItens
    *   Thisform.nCItem2 = 1
    *   Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens) Values ;
    *       ( crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CItens )
    *
    * Os quatro valores desse Insert sao exatamente o contexto que o BO precisa
    * para montar linha nova (sigopserBO.Inserir): empresa, operacao, numero do
    * movimento e o item de produto dono dos servicos. Eles sao LIDOS aqui, uma
    * vez, do cursor do item - e do cabecalho quando o item nao os traz, que eh
    * de onde o mInsereLinha legado os le (TprMvCab.Emps/Dopes/Numes).
    *
    * Toda leitura eh guardada por USED()/EOF(): em modo de teste e em
    * validacao de UI os cursores do chamador nao existem, e a tela tem de
    * abrir do mesmo jeito. O alias da grade de servicos eh repassado ao BO
    * sempre, porque eh ele que diz ao BO onde inserir e atualizar as linhas.
    *
    * A area de trabalho corrente eh salva e restaurada: este metodo roda
    * dentro do Init do dialogo, na sessao de dados do CHAMADOR, e deixar outra
    * area selecionada mudaria o alias corrente de quem abriu a tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContextoBO()
        LOCAL loc_nAreaAnterior

        loc_nAreaAnterior = SELECT()

        WITH THIS.this_oBusinessObject
            .this_cCursorAlias       = THIS.this_cCursorServicos
            .this_lGarantia          = THIS.this_lGarantia
            .this_lValorZeroGarantia = THIS.this_lValorZeroGarantia
        ENDWITH

        *-- Legado: Thisform.CItem = crTpmMvItn.CItens
        IF USED(THIS.this_cCursorItem)
            SELECT (THIS.this_cCursorItem)

            IF !EOF()
                THIS.this_nCItem = TratarNulo(citens, 0)

                WITH THIS.this_oBusinessObject
                    .this_nCitemProduto = THIS.this_nCItem
                    .this_cEmps         = TratarNulo(emps, "")
                    .this_cDopes        = TratarNulo(dopes, "")
                    .this_nNumes        = TratarNulo(numes, 0)
                ENDWITH
            ENDIF
        ENDIF

        *-- Cabecalho do movimento: eh de TprMvCab que o mInsereLinha legado le
        *-- Emps/Dopes/Numes quando o cursor do item nao esta posicionado
        IF EMPTY(THIS.this_oBusinessObject.this_cDopes) AND USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)

            IF !EOF()
                WITH THIS.this_oBusinessObject
                    .this_cEmps  = TratarNulo(emps, "")
                    .this_cDopes = TratarNulo(dopes, "")
                    .this_nNumes = TratarNulo(numes, 0)
                ENDWITH
            ENDIF
        ENDIF

        *-- Legado: Thisform.nCItem2 = 1 (contador de linhas de csTmpDesc,
        *-- reiniciado a cada abertura do dialogo)
        THIS.this_nCItem2 = 1

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Monta e repinta a grade de servicos.
    *
    * Eh a transcricao da metade final do Init legado, na MESMA ordem:
    *
    *   1. Cursorquery('SigCdOpe','CrSigCdOpe',...)  -> CarregarConfiguracaoOperacao
    *   2. Create Cursor csTmpDesc + Index iControle -> CriarCursorDescricoes
    *   3. If INSERIR/ALTERAR ... Insert Into        -> GarantirLinhaEmBranco
    *   4. Set Order/Set Key + Scan + Set Relation   -> MontarDescricoesPorLinha
    *   5. Scan ... replace iconfs With .T.          -> MarcarConfirmacaoTamanho
    *   6. With Thisform.fwgrade ... .Refresh        -> VincularGrade
    *   7. Goto Bottom / Goto Top                    -> PosicionarGrade
    *
    * PUBLIC de proposito: eh chamada de FORA da classe (pelo harness de teste
    * automatizado) e pelos handlers que repopulam a grade na Fase 7. Metodo
    * PROTECTED chamado de fora estoura em runtime, e PEMSTATUS devolve .T.
    * mesmo para o protegido, entao o teste entraria no ramo e so quebraria ao
    * executar.
    *
    * Cada etapa eh guardada por USED(): em modo de teste e em validacao de UI
    * os cursores do chamador nao existem, e a tela tem de abrir do mesmo jeito -
    * com a grade vazia, como o legado tambem faz quando a consulta nao traz
    * linha. O retorno .F. nao impede a abertura.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_nAreaAnterior, loc_oErro

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()

        TRY
            *-- 1. Configuracao da operacao (casas decimais, moeda, filtros)
            THIS.CarregarConfiguracaoOperacao()

            *-- 1.1 Universo de servicos consultado pelos dois lookups da
            *--     grade (csSigCdPro). Depende de HabServs/ItSituas, lidos
            *--     no passo anterior
            THIS.CarregarServicosDisponiveis()

            *-- 2. Cursor das descricoes por linha (csTmpDesc)
            THIS.CriarCursorDescricoes()

            *-- 3. Linha em branco para digitacao, so em INSERIR/ALTERAR
            THIS.GarantirLinhaEmBranco()

            *-- 4. Numeracao das linhas + relacao com a grade
            THIS.MontarDescricoesPorLinha()

            *-- 5. Marca as linhas que ja tem faixa de tamanho preenchida
            THIS.MarcarConfirmacaoTamanho()

            *-- 6. RecordSource, ControlSource das 7 colunas e mascara do valor
            THIS.VincularGrade()

            *-- 7. Posiciona e REPINTA (cursor cheio nao redesenha a grade
            *--    sozinho: sem GO + Refresh a grade fica visualmente vazia)
            THIS.PosicionarGrade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar a grade de servi" + CHR(231) + "os")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoOperacao - CrSigCdOpe do legado.
    *
    * Legado:
    *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe', ;
    *                                              'Dopes', TprMvCab.Dopes)
    *
    * De CrSigCdOpe saem as casas decimais do valor unitario (usadas na mascara
    * da coluna VALOR), a moeda padrao, os flags de preco e os dois filtros que
    * CarregarServicosDisponiveis usa para montar o universo de servicos
    * consultado pelos lookups da grade (HabServs e ItSituas).
    * Todos ficam nas propriedades do BO.
    *
    * Duas origens, nesta ordem: (a) o cursor que o CHAMADOR ja abriu - este
    * dialogo roda na sessao de dados dele; (b) consulta propria ao SigCdOpe,
    * que eh o equivalente do Cursorquery legado quando o chamador nao trouxe o
    * cursor. Sem conexao e sem cursor as propriedades ficam no default do BO,
    * e a mascara cai nas 2 casas minimas - o mesmo que o legado faz com
    * Casas = 0, por causa do Iif(Casas < 2, 2, Casas) da formula.
    *
    * SigCdOpe tem Dopes como chave E descricao ao mesmo tempo: NAO existe
    * coluna descrs nessa tabela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cDopes, loc_cSQL, loc_nResultado, loc_lAchou

        loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        loc_lAchou = .F.

        *-- (a) cursor da operacao que o chamador ja montou
        IF USED(THIS.this_cCursorOperacao)
            SELECT (THIS.this_cCursorOperacao)

            IF !EMPTY(loc_cDopes)
                LOCATE FOR ALLTRIM(dopes) == loc_cDopes
            ELSE
                GO TOP
            ENDIF

            loc_lAchou = !EOF()
        ENDIF

        *-- (b) consulta propria - o Cursorquery do legado
        IF !loc_lAchou AND !EMPTY(loc_cDopes) ;
           AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

            loc_cSQL = "SELECT Dopes, Casas, ZerQtds, PrecoAuts," + ;
                       " PrecoPs, Precops, CMoes, ItSituas, HabServs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE Dopes = " + EscaparSQL(loc_cDopes)

            IF USED(THIS.this_cCursorOperacao)
                IF CURSORGETPROP("Buffering", THIS.this_cCursorOperacao) > 1
                    TABLEREVERT(.T., THIS.this_cCursorOperacao)
                ENDIF
                USE IN (THIS.this_cCursorOperacao)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

            IF loc_nResultado < 0
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
                        "configura" + CHR(231) + CHR(227) + "o da opera" + ;
                        CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    SELECT (THIS.this_cCursorOperacao)
                    GO TOP
                    loc_lAchou = !EOF()
                ENDIF
            ENDIF
        ENDIF

        IF loc_lAchou
            WITH THIS.this_oBusinessObject
                .this_nCasas     = TratarNulo(casas, 0)
                .this_nZerQtds   = TratarNulo(zerqtds, 0)
                .this_nPrecoAuts = TratarNulo(precoauts, 0)
                .this_cCMoes     = TratarNulo(cmoes, "")
                .this_nItSituas  = TratarNulo(itsituas, 0)
                .this_nHabServs  = TratarNulo(habservs, 0)

                *-- this_nPrecoPs e this_nPrecops sao DUAS propriedades do BO
                *-- para UMA SO coluna: o legado escreve "PrecoPs" num trecho e
                *-- "Precops" noutro, e o VFP nao distingue caixa - no schema
                *-- existe apenas precops numeric(2,0). As duas recebem o mesmo
                *-- valor real; nao sao colunas gemeas, sao a mesma coluna.
                .this_nPrecoPs   = TratarNulo(precops, 0)
                .this_nPrecops   = TratarNulo(precops, 0)
            ENDWITH
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDescricoes - csTmpDesc do legado.
    *
    * Legado:
    *   Create Cursor csTmpDesc ( nLinhas N(4), nControle N(8), ;
    *                             cDescTams C(20), cDescCors C(40), ;
    *                             cDescEmbs C(20) )
    *   Index On Str(nControle,8) Tag iControle
    *
    * nControle guarda o RECNO() da linha da grade e eh a chave da relacao que
    * faz a coluna "item" acompanhar a linha corrente; nLinhas eh o numero
    * sequencial que o usuario ve. As tres colunas de descricao (tamanho, cor e
    * embalagem) vem do legado e sao preenchidas pelos handlers de tamanho.
    *
    * A estrutura eh transcrita LITERAL e num unico lugar: cursor recriado com
    * ordem de campos diferente em outro ponto do form quebraria o
    * APPEND FROM/ControlSource que casam por NOME.
    *
    * TABLEREVERT exige buffering - sem buffering ele dispara o erro 1586, e
    * USE IN fecha o alias mesmo com buffer sujo. Por isso o teste de
    * CURSORGETPROP antes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorDescricoes()
        IF USED(THIS.this_cCursorDescricoes)
            IF CURSORGETPROP("Buffering", THIS.this_cCursorDescricoes) > 1
                TABLEREVERT(.T., THIS.this_cCursorDescricoes)
            ENDIF
            USE IN (THIS.this_cCursorDescricoes)
        ENDIF

        CREATE CURSOR csTmpDesc ( nLinhas   N(4), ;
                                  nControle N(8), ;
                                  cDescTams C(20), ;
                                  cDescCors C(40), ;
                                  cDescEmbs C(20) )

        INDEX ON STR(nControle, 8) TAG iControle

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirLinhaEmBranco - a linha vazia para digitacao.
    *
    * Legado (Init):
    *   If InList(Thisform.Op_Escolha,'INSERIR','ALTERAR')
    *       Select * From crTpmMvItn3 ;
    *              Where CItens = crTpmMvItn.CItens And IsEmpty(Qtds) ;
    *              Into Cursor csTemp
    *       If _Tally = 0
    *           Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens) Values ;
    *                  ( crTpmMvItn.Emps, crTpmMvItn.Dopes, ;
    *                    crTpmMvItn.Numes, crTpmMvItn.CItens )
    *       Endif
    *   EndIf
    *
    * Ou seja: em INSERIR/ALTERAR a grade sempre termina com UMA linha de
    * quantidade zerada, que eh onde o usuario digita o proximo servico - e so
    * UMA, dai a contagem antes de inserir. Em VISUALIZAR nada eh acrescentado.
    *
    * A insercao vai pelo BO (sigopserBO.Inserir), que grava exatamente as
    * mesmas quatro colunas de contexto; as demais propriedades de LINHA sao
    * zeradas antes para a linha nascer em branco mesmo quando o BO acabou de
    * carregar outro servico (CarregarLista eh chamada de novo pelos handlers).
    *
    * O SELECT de contagem leva WHERE proprio porque SELECT IGNORA o SET KEY /
    * SET FILTER que escopa a grade - contar sem o WHERE traria os servicos de
    * TODOS os itens do documento e a linha em branco nunca seria criada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirLinhaEmBranco()
        LOCAL loc_nVazias, loc_nAreaAnterior, loc_cServicos, loc_nItem

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorServicos)
            RETURN
        ENDIF

        loc_nAreaAnterior = SELECT()
        loc_cServicos     = THIS.this_cCursorServicos
        loc_nItem         = THIS.this_nCItem

        *-- O alias entra por MACRO: a clausula FROM do SELECT do VFP nao aceita
        *-- nome entre parenteses (ao contrario do comando SELECT <alias>), e
        *-- "&var." expande ANTES do parse, deixando o nome literal na consulta.
        *-- O item vai numa variavel com prefixo "m." para o VFP nao tentar
        *-- resolver o nome como COLUNA do cursor.
        SELECT COUNT(*) AS nVazias ;
            FROM &loc_cServicos. ;
            WHERE citens = m.loc_nItem AND EMPTY(qtds) ;
            INTO CURSOR cursor_4c_SerVazias NOFILTER

        loc_nVazias = 0

        IF USED("cursor_4c_SerVazias")
            SELECT cursor_4c_SerVazias
            IF !EOF()
                loc_nVazias = TratarNulo(nVazias, 0)
            ENDIF
            USE IN cursor_4c_SerVazias
        ENDIF

        IF loc_nVazias = 0
            *-- Linha NOVA: as colunas de servico tem de estar limpas, senao a
            *-- linha nasceria com os dados do servico lido por ultimo
            THIS.LimparDadosLinhaBO()

            IF !THIS.this_oBusinessObject.Inserir()
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao preparar a grade de servi" + CHR(231) + "os")
            ENDIF
        ENDIF

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarEscopoItem - restringe a grade aos servicos do item corrente.
    *
    * Legado: Select crTpmMvItn3 / Set Order To CItens / Set Key To <item>
    *
    * O SET KEY eh o que faz a grade mostrar SO os servicos deste item de
    * produto - sem ele o usuario veria os servicos de todos os itens do
    * documento. Depende do tag "CItens", que eh criado pelo form CHAMADOR ao
    * montar o cursor; quando ele nao existe (cursor montado de outra forma, ou
    * harness de teste), o escopo eh obtido com SET FILTER, que produz o MESMO
    * conjunto de linhas - so sem a ordenacao pelo indice.
    *
    * Testar o tag em vez de confiar nele: SET ORDER TO sobre tag inexistente
    * derruba a carga inteira.
    *--------------------------------------------------------------------------
    * As duas clausulas sao aplicadas na AREA CORRENTE (o SELECT abaixo), sem
    * clausula "IN", e o SET FILTER eh montado por MACRO: SET FILTER GUARDA a
    * expressao e a reavalia a cada movimento do cursor, quando este metodo ja
    * terminou e "THIS" nao existe mais - a expressao tem de sair daqui com o
    * NUMERO do item ja embutido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarEscopoItem()
        LOCAL loc_nI, loc_lTemTag, loc_cFiltro, loc_nItem

        IF !USED(THIS.this_cCursorServicos)
            RETURN
        ENDIF

        SELECT (THIS.this_cCursorServicos)

        loc_nItem   = THIS.this_nCItem
        loc_lTemTag = .F.

        FOR loc_nI = 1 TO TAGCOUNT("", THIS.this_cCursorServicos)
            IF UPPER(ALLTRIM(TAG(loc_nI, THIS.this_cCursorServicos))) == "CITENS"
                loc_lTemTag = .T.
                EXIT
            ENDIF
        ENDFOR

        IF loc_lTemTag
            SET ORDER TO TAG CItens
            SET KEY TO loc_nItem
        ELSE
            loc_cFiltro = "citens = " + ALLTRIM(STR(loc_nItem))
            SET FILTER TO &loc_cFiltro.
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarDescricoesPorLinha - numeracao das linhas e relacao com a grade.
    *
    * Legado (Init):
    *   Select crTpmMvItn3 / Set Order To Citens / Set Key to ThisForm.CItem
    *   Goto Bott
    *   Thisform.nCItem2 = 1
    *   Scan
    *       Insert Into csTmpDesc ( nControle, nLinhas ) Values ;
    *              ( RecNo('crTpmMvItn3'), Thisform.nCItem2 )
    *       Thisform.nCItem2 = Thisform.nCItem2 + 1
    *   EndScan
    *   Goto Top
    *   Set Relation To Str(Recno('crTpmMvItn3'),8) Into csTmpDesc
    *
    * O contador nCItem2 comeca em 1 e sobra apontando para a PROXIMA linha:
    * eh esse valor que o mInsereLinha do legado usa ao acrescentar uma linha
    * nova, e por isso ele continua guardado na propriedade do form.
    *
    * A RELACAO eh o que liga a coluna "item" (csTmpDesc.nLinhas) a linha
    * corrente da grade: sem ela a coluna exibiria sempre o mesmo numero.
    * Ela exige csTmpDesc na ordem do tag iControle, que eh a mesma expressao
    * STR(nControle,8) usada do outro lado.
    *
    * A relacao propriamente dita (e o SET ORDER do lado filho que ela exige)
    * esta em AplicarRelacaoDescricoes, chamado no fim deste metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarDescricoesPorLinha()
        IF !USED(THIS.this_cCursorServicos) OR !USED(THIS.this_cCursorDescricoes)
            RETURN
        ENDIF

        *-- Escopo do item (Set Order / Set Key do legado)
        THIS.AplicarEscopoItem()

        *-- Legado: Thisform.nCItem2 = 1 antes de percorrer
        THIS.this_nCItem2 = 1

        SELECT (THIS.this_cCursorServicos)
        GO TOP

        SCAN
            INSERT INTO csTmpDesc (nControle, nLinhas) ;
                VALUES (RECNO(THIS.this_cCursorServicos), THIS.this_nCItem2)

            THIS.this_nCItem2 = THIS.this_nCItem2 + 1

            SELECT (THIS.this_cCursorServicos)
        ENDSCAN

        SELECT (THIS.this_cCursorServicos)
        GO TOP

        *-- SET ORDER do lado FILHO + SET RELATION, em metodo unico porque o
        *-- legado repete os dois comandos tambem no mInsereLinha
        THIS.AplicarRelacaoDescricoes()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarConfirmacaoTamanho - o iconfs das linhas que ja tem faixa.
    *
    * Legado (Init):
    *   Select crTpmMvItn3 / Go Top
    *   Scan
    *       If Not Empty(TamDe) and Not Empty(TamPara)
    *           replace iconfs With .T. In crTpmMvItn3
    *       EndIf
    *       Select crTpmMvItn3
    *   EndScan
    *
    * iconfs eh o que faz o painel "Tamanho" aparecer na linha (handler
    * AfterRowColChange, Fase 7) e o que o botao Retornar confere antes de
    * fechar: linha marcada sem De/Para preenchidos eh recusada. Marcar aqui,
    * na abertura, eh como o legado garante que linha vinda do banco com faixa
    * preenchida ja chegue confirmada.
    *
    * A coluna eh "bit" no SQL Server e chega ao cursor VFP ora como Logico ora
    * como Numerico, conforme o driver: o tipo eh medido UMA vez e o REPLACE usa
    * o valor compativel - comparar ou gravar o tipo errado dispara
    * "Operator/operand type mismatch".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarConfirmacaoTamanho()
        LOCAL loc_lColunaLogica

        IF !USED(THIS.this_cCursorServicos)
            RETURN
        ENDIF

        SELECT (THIS.this_cCursorServicos)
        GO TOP

        IF EOF()
            RETURN
        ENDIF

        loc_lColunaLogica = (VARTYPE(iconfs) = "L")

        *-- O "In crTpmMvItn3" do legado eh redundante aqui: o SCAN roda sobre a
        *-- area que acabou de ser selecionada, entao o REPLACE sem clausula IN
        *-- atinge exatamente o mesmo registro
        SCAN
            IF !EMPTY(tamde) AND !EMPTY(tampara)
                IF loc_lColunaLogica
                    REPLACE iconfs WITH .T.
                ELSE
                    REPLACE iconfs WITH 1
                ENDIF
            ENDIF

            SELECT (THIS.this_cCursorServicos)
        ENDSCAN

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - RecordSource e ControlSource das sete colunas.
    *
    * Legado (Init):
    *   With Thisform.fwgrade
    *       .Recordsource            = 'crTpmMvItn3'
    *       .Item.ControlSource      = "csTmpDesc.nLinhas"
    *       .Produto.Controlsource   = 'crTpmMvItn3.cpros'
    *       .Qtd.Controlsource       = 'crTpmMvItn3.qtds'
    *       .Valor.Controlsource     = 'crTpmMvItn3.units'
    *       lcMask = '99999999.' + Repl( '9', iif(CrSigCdOpe.Casas < 2, 2, CrSigCdOpe.Casas) )
    *       lcMask = Right( lcMask, 11 )
    *       .Valor.Inputmask         = lcMask
    *       .Valor.Text1.Inputmask   = lcMask
    *       .Moeda.Controlsource     = 'crTpmMvItn3.moedas'
    *       .Total.Controlsource     = 'crTpmMvItn3.totas'
    *       .Descricao.Controlsource = 'crTpmMvItn3.Dpros'
    *       .Refresh
    *   EndWith
    *
    * A formula da mascara eh TRANSCRITA, nao reescrita: o piso de 2 casas e o
    * RIGHT(...,11) que limita o tamanho total sao regra de negocio - a coluna
    * units tem 6 decimais no banco, e uma mascara mais larga do que o legado
    * deixaria o usuario digitar o que a tela nao grava.
    *
    * Ordem obrigatoria: RecordSource -> ControlSource -> Width -> Header,
    * porque mexer no RecordSource RECALCULA as larguras das colunas para o
    * default 90 e limpa os captions dos headers. Nao se toca em ColumnCount
    * aqui: qualquer atribuicao a ColumnCount RECRIA os objetos Column e
    * destruiria tudo o que ConfigurarGrade montou.
    *
    * A coluna "item" so eh amarrada quando csTmpDesc existe - Column.
    * ControlSource apontando para alias inexistente derruba a carga.
    *
    * DynamicForeColor da coluna QTD: o SCX declara
    *   "iif(crTpmMvItn.iconfs=.t.,rgb(0,0,255),rgb(0,0,0))"
    * citando o cursor do ITEM (crTpmMvItn), e nao o da grade (crTpmMvItn3).
    * Transcrito como esta - a expressao eh avaliada a cada repintura e "corrigi
    * -la" para o cursor da grade mudaria a cor que o usuario ve hoje. So eh
    * atribuida quando aquele cursor esta aberto: expressao dinamica sobre alias
    * fechado estoura no Refresh.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_cMascara, loc_nCasas, loc_cServicos

        IF !USED(THIS.this_cCursorServicos)
            RETURN
        ENDIF

        loc_cServicos = THIS.this_cCursorServicos

        *-- Mascara do valor unitario (formula transcrita do legado)
        loc_nCasas   = THIS.this_oBusinessObject.this_nCasas
        loc_cMascara = "99999999." + REPLICATE("9", IIF(loc_nCasas < 2, 2, loc_nCasas))
        loc_cMascara = RIGHT(loc_cMascara, 11)

        WITH THIS.grd_4c_Dados
            .RecordSource = loc_cServicos

            .Column1.ControlSource = loc_cServicos + ".cpros"
            .Column2.ControlSource = loc_cServicos + ".qtds"
            .Column3.ControlSource = loc_cServicos + ".units"
            .Column4.ControlSource = loc_cServicos + ".moedas"
            .Column5.ControlSource = loc_cServicos + ".totas"
            .Column7.ControlSource = loc_cServicos + ".dpros"
        ENDWITH

        *-- Coluna "item": numero sequencial vindo de csTmpDesc pela relacao
        IF USED(THIS.this_cCursorDescricoes)
            THIS.grd_4c_Dados.Column6.ControlSource = ;
                THIS.this_cCursorDescricoes + ".nLinhas"
        ENDIF

        *-- Mascara calculada, na Column E no Text1 que desenha a celula
        THIS.grd_4c_Dados.Column3.InputMask       = loc_cMascara
        THIS.grd_4c_Dados.Column3.Text1.InputMask = loc_cMascara

        *-- Larguras REAPLICADAS: o RecordSource acima as devolveu ao default
        WITH THIS.grd_4c_Dados
            .Column1.Width = 120    && PRODUTO
            .Column2.Width = 120    && QTD
            .Column3.Width = 120    && VALOR
            .Column4.Width = 33     && MOEDA
            .Column5.Width = 120    && TOTAL
            .Column6.Width = 31     && item
            .Column7.Width = 404    && Descricao
        ENDWITH

        *-- Captions REAPLICADOS pelo mesmo motivo das larguras
        WITH THIS.grd_4c_Dados
            .Column1.Header1.Caption = "Servi" + CHR(231) + "o"
            .Column2.Header1.Caption = "Quantidade"
            .Column3.Header1.Caption = "Valor"
            .Column4.Header1.Caption = "Moe"
            .Column5.Header1.Caption = "Total"
            .Column6.Header1.Caption = ""
            .Column7.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
                                       "o do Servi" + CHR(231) + "o"
        ENDWITH

        *-- Cor dinamica da quantidade (expressao literal do SCX legado)
        IF USED(THIS.this_cCursorItem)
            THIS.grd_4c_Dados.Column2.DynamicForeColor = ;
                "IIF(" + THIS.this_cCursorItem + ".iconfs = .T.," + ;
                " RGB(0,0,255), RGB(0,0,0))"
        ENDIF

        *-- REINSTALADAS aqui, e nao so na inicializacao: o RecordSource/
        *-- ControlSource atribuidos acima devolvem Sparse e CurrentControl ao
        *-- default, e as duas celulas de lookup voltariam a ser o Text1 da
        *-- coluna, sem o When/Valid do legado
        THIS.InstalarCelulasLookup()

        *-- Idem para as celulas de quantidade e de valor, e para o ReadOnly
        *-- das tres colunas somente-exibicao (o "Return .f." do When delas)
        THIS.InstalarCelulasEdicao()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarGrade - posiciona a linha corrente e REPINTA a grade.
    *
    * Legado (Init):
    *   Select crTpmMvItn3
    *   If InList( Thisform.Op_Escolha, 'INSERIR', 'ALTERAR' )
    *       Goto Bottom
    *   Else
    *       Goto Top
    *   EndIf
    *
    * O criterio eh do legado e tem razao de ser: em INSERIR/ALTERAR a ultima
    * linha eh justamente a linha em branco criada por GarantirLinhaEmBranco,
    * onde o usuario vai digitar; em VISUALIZAR a grade abre no primeiro
    * servico. No legado esse trecho vem ANTES do Scan de iconfs, que percorre o
    * cursor inteiro e o deixa em EOF - o posicionamento eh reaplicado aqui, no
    * FIM da carga, para que a grade abra na linha que o legado escolheu em vez
    * de abrir sem linha corrente.
    *
    * O Refresh eh obrigatorio: encher o cursor NAO repinta a grade sozinha, e
    * sem ele a tela aparece vazia com o cursor cheio - sintoma que manda o
    * diagnostico para o SQL quando o problema eh so de repintura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarGrade()
        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)

            IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
                GO BOTTOM
            ELSE
                GO TOP
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - foco inicial na grade.
    *
    * Legado (fim do Init): Thisform.fwgrade.produto.setfocus
    *
    * O legado pede o foco dentro do proprio Init; aqui ele eh dado no Activate
    * porque durante o Init a janela ainda nao esta na tela e SetFocus em
    * controle de form invisivel falha. O resultado para o usuario eh o mesmo:
    * ao abrir, o cursor de digitacao esta na coluna do servico.
    *
    * Dispara UMA vez (Activate de form modal volta a disparar a cada vez que a
    * janela reassume o foco, e insistir no SetFocus roubaria o foco de quem o
    * usuario acabou de escolher). Grade sem linha nao recebe foco: ActivateCell
    * sobre grade vazia estoura.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()

        IF THIS.this_lFocoInicialAplicado
            RETURN
        ENDIF

        THIS.this_lFocoInicialAplicado = .T.

        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
           AND USED(THIS.this_cCursorServicos) ;
           AND RECCOUNT(THIS.this_cCursorServicos) > 0

            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * DesabilitarChamador / ReabilitarChamador - o "poForm.Enabled" do legado.
    *
    * O Init legado faz "poForm.Enabled = .f." e o btnSair.Click devolve
    * "ThisForm.poForm.Enabled = .t." antes do Release. Como o dialogo pode ser
    * fechado por outros caminhos (Esc, QueryUnload), a reabilitacao tambem eh
    * chamada no Destroy: sem isso o chamador ficaria inerte e o usuario
    * perderia a tela do documento. As duas sao idempotentes.
    *
    * ReabilitarChamador eh PUBLIC de proposito: o handler do botao Retornar
    * (Fase 7) a chama, e metodo PROTECTED chamado de fora estoura em runtime.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesabilitarChamador()
        IF VARTYPE(THIS.this_oFormChamador) = "O"
            IF PEMSTATUS(THIS.this_oFormChamador, "Enabled", 5)
                THIS.this_oFormChamador.Enabled = .F.
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    PROCEDURE ReabilitarChamador()
        IF VARTYPE(THIS.this_oFormChamador) = "O"
            IF PEMSTATUS(THIS.this_oFormChamador, "Enabled", 5)
                THIS.this_oFormChamador.Enabled = .T.
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *==========================================================================
    * FASE 7 - EVENTOS PRINCIPAIS
    *
    * Os quatro botoes que o SCX legado declara, com os handlers transcritos do
    * dump, mais os eventos que dirigem a tela enquanto ela esta aberta (a
    * troca de linha da grade e o gate de edicao dos campos de produto).
    *
    * NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
    * BtnExcluirClick: este form NAO eh um cadastro CRUD. O legado herda de
    * "form" puro (nao de frmcadastro), nao tem Grupo_Op nem pcEscolha
    * proprios, e os seus QUATRO botoes sao btnTotItens / btnCotacao /
    * btnAltImps / cntOK.btnSair. Inventar a barra CRUD aqui violaria o PILAR 1
    * e produziria quatro metodos sem conteudo.
    *
    * O modo de operacao (this_cOpEscolha) eh HERDADO do chamador em
    * ResolverModoOperacao - quem inclui/altera/visualiza o documento eh o form
    * de Movimentacao que abriu este dialogo.
    *==========================================================================

    *--------------------------------------------------------------------------
    * VincularEventosPrincipais - liga os handlers aos objetos.
    *
    * BINDEVENT so funciona com metodo PUBLIC: handler PROTECTED falha em
    * SILENCIO (regra #3). Por isso todos os alvos abaixo sao PUBLIC.
    *
    * O handler de AfterRowColChange declara o parametro nColIndex que o evento
    * passa - handler sem o parametro estoura a cada troca de celula.
    *
    * Chamado no fim de InicializarForm, ANTES de CarregarLista, para que a
    * troca de linha ja esteja ligada quando a grade for posicionada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventosPrincipais()
        *-- btnTotItens / btnCotacao / btnAltImps (Click do dump)
        BINDEVENT(THIS.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")
        BINDEVENT(THIS.cmd_4c_BtnCotacao,  "Click", THIS, "BtnCotacaoClick")
        BINDEVENT(THIS.cmd_4c_BtnAltImps,  "Click", THIS, "BtnAltImpsClick")

        *-- cntOK.btnSair (o botao Retornar; membro 1 do CommandGroup).
        *-- O handler mantem o nome do objeto legado (btnSair) - e nao
        *-- "BtnRetornarClick" - porque eh esse nome que o harness de teste
        *-- automatizado (TesteAutomatico.prg / BtnEncerrarExiste) reconhece
        *-- como metodo de encerramento do dialogo
        BINDEVENT(THIS.cmg_4c_CntOK.Buttons(1), "Click", THIS, "BtnSairClick")

        *-- fwGrade.AfterRowColChange: mostra/esconde o painel "Tamanho" e
        *-- carrega nele a faixa da linha corrente
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarGatesDeEdicao - o "Return .f." do When dos tres campos de produto.
    *
    * Legado:
    *   SIGOPSER.Get_Produto.When    -> Return .f.
    *   SIGOPSER.Get_Descricao.When  -> Return .f.
    *   SIGOPSER.Get_Mercs.When      -> Return .f.
    *
    * Os tres sao campos de EXIBICAO: mostram o produto dono dos servicos
    * (preenchidos por CarregarServicosDisponiveis) e o legado nunca permite
    * digitar neles.
    *
    * O gate NAO vai por BINDEVENT em "When": BINDEVENT DESCARTA o retorno do
    * delegate, entao um When ligado assim nao bloqueia nada - o campo
    * continuaria editavel e o defeito seria invisivel no codigo. ReadOnly = .T.
    * eh o equivalente que o VFP9 oferece sem subclasse: o controle continua
    * desenhado exatamente como no legado (ao contrario de Enabled = .F., que o
    * acinzentaria e mudaria a tela) e nao aceita digitacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarGatesDeEdicao()
        THIS.txt_4c_Produto.ReadOnly   = .T.
        THIS.txt_4c_Descricao.ReadOnly = .T.
        THIS.txt_4c_Mercs.ReadOnly     = .T.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoBotoesServico - os When dos tres botoes de servico.
    *
    * Legado:
    *   btnAltImps.When -> Inlist(Op_Escolha,[INSERIR],[ALTERAR]) And
    *                      Not Eof([crTpmMvItn3])
    *   btnCotacao.When -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
    *   btnTotItens     -> NAO declara When (sempre liberado)
    *
    * A VISIBILIDADE nao eh tocada aqui: os tres nascem Visible = .F. no SCX e
    * NENHUM trecho do legado os mostra - sao botoes desativados nesta tela (o
    * SCX veio de uma copia da tela de Produtos, onde eles existem de fato).
    * Mostra-los seria INVENTAR interface que o usuario nao tem hoje. O estado
    * de Enabled eh mantido assim mesmo porque eh regra do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoBotoesServico()
        LOCAL loc_lEditando, loc_lTemLinha

        loc_lEditando = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
        loc_lTemLinha = .F.

        IF USED(THIS.this_cCursorServicos)
            loc_lTemLinha = !EOF(THIS.this_cCursorServicos)
        ENDIF

        THIS.cmd_4c_BtnTotItens.Enabled = .T.
        THIS.cmd_4c_BtnCotacao.Enabled  = loc_lEditando
        THIS.cmd_4c_BtnAltImps.Enabled  = loc_lEditando AND loc_lTemLinha

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarValoresTamanhoDaLinha - traz para o painel "Tamanho" a faixa da
    * linha corrente da grade.
    *
    * Legado, nas DUAS vezes em que aparece (fim do Init e AfterRowColChange):
    *   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
    *   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
    *
    * Metodo unico porque o valor tem de ser o mesmo nos dois caminhos; sem
    * cursor aberto ou em EOF os campos ficam vazios, que eh o que o legado
    * tambem produz.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarValoresTamanhoDaLinha()
        LOCAL loc_lTemLinha, loc_nAreaAnterior

        loc_lTemLinha     = .F.
        loc_nAreaAnterior = SELECT()

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)

            IF !EOF()
                loc_lTemLinha = THIS.this_oBusinessObject.CarregarDoCursor( ;
                                    THIS.this_cCursorServicos)
            ENDIF
        ENDIF

        *-- Sem linha corrente o legado deixa os dois campos vazios: as
        *-- propriedades da LINHA sao zeradas para que BOParaForm as espelhe
        IF !loc_lTemLinha
            THIS.LimparDadosLinhaBO()
        ENDIF

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        THIS.BOParaForm()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - fwGrade.AfterRowColChange do legado.
    *
    * Legado:
    *   LPARAMETERS nColIndex
    *   Select crTpmMvItn3
    *   If crTpmMvItn3.iconfs
    *       ThisForm.cntTamanho.Visible = .T.
    *   Else
    *       ThisForm.cntTamanho.Visible = .F.
    *   EndIf
    *   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
    *   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
    *
    * Este eh o uso CERTO de AfterRowColChange: carregar o detalhe da linha
    * CORRENTE. O que nao se faz aqui eh validar celula por nColIndex - ali o
    * indice recebido eh o da coluna de DESTINO e a validacao rodaria na linha
    * errada (regra #46); a validacao das celulas de servico mora no Valid das
    * subclasses instaladas por InstalarCelulasLookup.
    *
    * iconfs vem de coluna "bit" do SQL Server e chega ao VFP ora Logico ora
    * Numerico conforme o caminho que montou o cursor - comparar Logico com
    * numero estoura "Operator/operand type mismatch", por isso o VARTYPE.
    *
    * O parametro nColIndex eh declarado porque o evento o passa: handler sem
    * ele estoura a CADA troca de celula (regra #3). Nao eh usado, como no
    * legado.
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_lConfirma

        loc_lConfirma = .F.

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)

            IF !EOF()
                DO CASE
                CASE VARTYPE(iconfs) = "L"
                    loc_lConfirma = iconfs
                CASE VARTYPE(iconfs) = "N"
                    loc_lConfirma = (iconfs <> 0)
                CASE VARTYPE(iconfs) = "C"
                    loc_lConfirma = (UPPER(LEFT(ALLTRIM(iconfs), 1)) == "S")
                ENDCASE
            ENDIF
        ENDIF

        THIS.cnt_4c_Tamanho.Visible = loc_lConfirma

        THIS.CarregarValoresTamanhoDaLinha()

        *-- O When de btnAltImps depende de Not Eof([crTpmMvItn3]), que acabou
        *-- de mudar junto com a linha corrente
        THIS.AtualizarEstadoBotoesServico()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TotalizarLinha - o "calc_valite" do legado (metodo de form).
    *
    * Legado:
    *   PROCEDURE calc_valite
    *   ThisForm.ParentForm.Calc_ValIte([crTpmMvItn3])
    *   ThisForm.fwGrade.Refresh
    *
    * A aritmetica do total (unitario x quantidade, fator, moeda, descontos e
    * impostos) eh regra de negocio que mora no Calc_ValIte do form de
    * Movimentacao - esta tela so DELEGA e repinta. Reescrever a formula aqui
    * gravaria valor diferente do legado, sem erro na tela (regra #17).
    *
    * O alias da grade vai como argumento porque eh assim que o legado chama: o
    * Calc_ValIte do pai totaliza o cursor que recebe.
    *
    * PUBLIC: eh chamado pelos handlers de botao deste form, e eh o mesmo papel
    * do metodo homonimo nos forms irmaos de movimentacao.
    *--------------------------------------------------------------------------
    PROCEDURE TotalizarLinha()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Calc_ValIte", 5)
                TRY
                    THIS.this_oFormPai.Calc_ValIte(THIS.this_cCursorServicos)
                    loc_lSucesso = .T.
                CATCH TO loc_oErro
                    MsgErro("Erro ao totalizar os servi" + CHR(231) + "os:" + CHR(13) + ;
                            loc_oErro.Message + CHR(13) + ;
                            "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                            "Procedure: " + loc_oErro.Procedure, ;
                            "Erro em TotalizarLinha")
                ENDTRY
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotItensClick - btnTotItens.Click do legado ("Total de Servicos").
    *
    * Legado:
    *   ThisForm.Enabled = .f.
    *   Do Form SigOpTot With ThisForm, ThisForm.DataSessionId
    *
    * SigOpTot ainda NAO foi migrado. A chamada eh escrita no padrao do projeto
    * (CREATEOBJECT + Show, como o form irmao Formsigoppro faz para a MESMA
    * tela) e a ausencia aparece ALTA, na mensagem de erro - nunca escondida
    * atras de um guard IF FILE()/PEMSTATUS, que eh o que faz o usuario clicar
    * e nada acontecer (regra #27).
    *
    * UNICO desvio do legado: o Enabled eh devolvido aqui. O legado conta com o
    * btnSair do SigOpTot para faze-lo ("ThisForm.poForm.Enabled = .t."); como
    * o dialogo migrado eh modal, o Show() so retorna depois que ele fecha, e
    * restaurar neste ponto eh equivalente - e eh o que impede a tela de
    * Servicos de ficar MORTA quando o filho nem chega a abrir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotItensClick()
        LOCAL loc_oForm, loc_oErro

        loc_oForm = .NULL.

        *-- Legado: ThisForm.Enabled = .f.
        THIS.Enabled = .F.

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpTot", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Total de Servi" + CHR(231) + "os:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        THIS.Enabled = .T.
        THIS.grd_4c_Dados.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCotacaoClick - btnCotacao.Click do legado ("Excluir Servicos").
    *
    * Legado:
    *   Do Form SigOpCot With ThisForm.ParentForm, TprMvCab.Datas
    *   Select crTpmMvItn
    *   Set Order To
    *   Scan
    *       If Not ThisForm.ParentForm.PodataMgr.CursorQuery([SigCdPro],
    *                                 [crTmpPro], [CPros], crTpmMvItn.CPros)
    *           Loop
    *       EndIf
    *       Replace AltImpost With .f. In crTpmMvItn
    *       ThisForm.Calc_Valite()
    *   EndScan
    *
    * O Caption diz "Excluir Servicos" mas o Click NAO exclui nada: abre a tela
    * de Cambio (SigOpCot) e, na volta, zera a marca de imposto alterado de
    * cada item cujo produto ainda existe em SigCdPro, remontando o total. O
    * nome do botao esta errado no legado; o COMPORTAMENTO eh este, e eh ele
    * que se transcreve.
    *
    * O SCAN percorre crTpmMvItn (o cursor dos ITENS do documento), nao a grade
    * de servicos - tambem do legado.
    *
    * CursorQuery eh substituido pela consulta equivalente a SigCdPro no cursor
    * crTmpPro, que eh o mesmo nome e o mesmo conteudo que o legado monta.
    * "Nao achou" significa pular a linha, exatamente como o Loop.
    *
    * AltImpost so eh gravada quando a coluna existe no cursor do chamador: a
    * grafia vem do cursor que o form de Movimentacao monta, e REPLACE sobre
    * coluna inexistente derruba o SCAN inteiro. O valor segue o TIPO da
    * coluna - o legado grava .F., mas a mesma marca chega como numerico em
    * cursor montado por outro driver, e gravar Logico ali estoura
    * "Operator/operand type mismatch" (regra #13).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCotacaoClick()
        LOCAL loc_oForm, loc_oErro, loc_dDatas, loc_nAreaAnterior
        LOCAL loc_cCpros, loc_cTipoAltImpost

        loc_oForm  = .NULL.
        loc_dDatas = DATE()

        *-- Legado: TprMvCab.Datas (data do cabecalho do movimento)
        IF USED(THIS.this_cCursorCabecalho)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorCabecalho)

            IF !EOF() AND INLIST(TYPE(THIS.this_cCursorCabecalho + ".datas"), "D", "T")
                loc_dDatas = ConverterParaData(datas)
            ENDIF

            IF loc_nAreaAnterior > 0
                SELECT (loc_nAreaAnterior)
            ENDIF
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oFormPai, loc_dDatas)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir C" + CHR(226) + "mbio:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        *-- Volta do cambio: refaz a marca de imposto e o total de cada item
        IF USED(THIS.this_cCursorItem)
            loc_nAreaAnterior = SELECT()

            SELECT (THIS.this_cCursorItem)
            SET ORDER TO

            loc_cTipoAltImpost = TYPE(THIS.this_cCursorItem + ".altimpost")

            SCAN
                loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))

                IF !THIS.ProdutoExisteNoCadastro(loc_cCpros)
                    SELECT (THIS.this_cCursorItem)
                    LOOP
                ENDIF

                SELECT (THIS.this_cCursorItem)

                DO CASE
                CASE loc_cTipoAltImpost = "L"
                    REPLACE altimpost WITH .F.
                CASE loc_cTipoAltImpost = "N"
                    REPLACE altimpost WITH 0
                CASE loc_cTipoAltImpost = "C"
                    REPLACE altimpost WITH "N"
                ENDCASE

                THIS.TotalizarLinha()

                SELECT (THIS.this_cCursorItem)
            ENDSCAN

            IF loc_nAreaAnterior > 0
                SELECT (loc_nAreaAnterior)
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ProdutoExisteNoCadastro - o CursorQuery([SigCdPro],[crTmpPro],[CPros],..)
    * do legado, reduzido ao que o chamador precisa saber: o produto existe?
    *
    * O cursor de destino mantem o nome do legado (crTmpPro) e as mesmas
    * colunas, porque o form de Movimentacao que abriu este dialogo tambem o
    * consulta - trocar o nome quebraria o contrato com ele.
    *
    * Sem conexao o resultado eh .F.: nenhuma linha eh marcada, que eh o mesmo
    * efeito do CursorQuery legado falhando (o Loop pula a linha).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProdutoExisteNoCadastro(par_cCpros)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nAreaAnterior, loc_oErro

        loc_lExiste       = .F.
        loc_nAreaAnterior = SELECT()

        TRY
            IF VARTYPE(par_cCpros) = "C" AND !EMPTY(ALLTRIM(par_cCpros)) ;
               AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                loc_cSQL = "SELECT cpros, dpros, mercs FROM SigCdPro" + ;
                           " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

                IF USED("crTmpPro")
                    IF CURSORGETPROP("Buffering", "crTmpPro") > 1
                        TABLEREVERT(.T., "crTmpPro")
                    ENDIF
                    USE IN crTmpPro
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpPro")

                IF loc_nResultado < 0
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
                            "produto do item." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("crTmpPro")
                        SELECT crTmpPro
                        GO TOP
                        loc_lExiste = !EOF()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao consultar o produto")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnAltImpsClick - btnAltImps.Click do legado ("Alterar Valores").
    *
    * Legado:
    *   If Not Empty(crTpmMvItn3.CPros)
    *       _Retorno = [*] + Usuar
    *       ThisForm.lAutPreco = (Left(_Retorno, 1) = [*])
    *       If ThisForm.lAutPreco
    *           ThisForm.fwgrade.SetFocus
    *           ThisForm.fwgrade.Valor.SetFocus
    *       EndIf
    *   Else
    *       =MessageBox([Selecione um Produto Para Ter o Preco Alterado], 48,
    *                   [Atencao!!!])
    *   EndIf
    *
    * "_Retorno = [*] + Usuar" seguido de "Left(_Retorno,1) = [*]" eh SEMPRE
    * verdadeiro: no legado existia ali uma autorizacao por senha que foi
    * desativada deixando o "*" fixo na frente. Transcrito como esta - inventar
    * uma autorizacao que o legado nao faz mudaria quem consegue alterar preco.
    *
    * lAutPreco eh o que libera a coluna Valor: o When dela (na subclasse de
    * celula) testa justamente essa propriedade.
    *
    * fwgrade.Valor eh a Column3 (ver o mapeamento das sete colunas em
    * ConfigurarGrade).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAltImpsClick()
        LOCAL loc_cCpros, loc_cRetorno, loc_nAreaAnterior

        loc_cCpros = ""

        IF USED(THIS.this_cCursorServicos)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorServicos)

            IF !EOF()
                loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))
            ENDIF

            IF loc_nAreaAnterior > 0
                SELECT (loc_nAreaAnterior)
            ENDIF
        ENDIF

        IF EMPTY(loc_cCpros)
            MsgAviso("Selecione um Produto Para Ter o Pre" + CHR(231) + "o Alterado", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN
        ENDIF

        loc_cRetorno        = "*" + gc_4c_UsuarioLogado
        THIS.this_lAutPreco = (LEFT(loc_cRetorno, 1) == "*")

        IF THIS.this_lAutPreco
            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                THIS.grd_4c_Dados.SetFocus()

                IF THIS.grd_4c_Dados.Column3.Visible
                    THIS.grd_4c_Dados.Column3.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTamanhosInformados - a checagem que o botao Retornar faz antes de
    * fechar o dialogo.
    *
    * Legado (cntOK.btnSair.Click):
    *   If InList(Thisform.op_escolha,[INSERIR],[ALTERAR])
    *       lnOldSel = Select()
    *       If Used([csValConfs]) / Use in csValConfs / EndIf
    *       Select crTpmMvItn3
    *       Select Count(1) as Qtd From crTpmMvItn3
    *           Where iConfs = .T. and (Empty(TamDe) or Empty(TamPara))
    *           Into Cursor csValConfs ReadWrite
    *       Select csValConfs
    *       If Reccount([csValConfs])>0 And csValConfs.Qtd > 0
    *           MessageBox([Existe Servicos sem Informar os campos :] + Chr(13) +
    *                      [TAMANHO DE ou o TAMANHO PARA.] + Chr(13) +
    *                      [Favor Verificar!!!],0+48,[Aviso])
    *           Select(lnOldSel)
    *           Return .F.
    *       EndIf
    *       Select(lnOldSel)
    *   EndIf
    *
    * So vale em INSERIR/ALTERAR - em VISUALIZAR o usuario sai sempre, como no
    * legado.
    *
    * O cursor conserva o nome csValConfs do legado e a area de trabalho
    * anterior eh restaurada (lnOldSel), porque este dialogo roda na sessao de
    * dados do CHAMADOR e deixar outra area selecionada mudaria o alias
    * corrente dele.
    *
    * A condicao "iConfs = .T." vai por MACRO porque a coluna chega Logica ou
    * Numerica conforme o driver que montou o cursor - comparar Logico com
    * numero estoura "Operator/operand type mismatch" (regra #13).
    *
    * O alias da grade tambem entra por macro: a clausula FROM do SELECT do VFP
    * nao aceita nome entre parenteses.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarTamanhosInformados()
        LOCAL loc_lOk, loc_nOldSel, loc_cServicos, loc_cCondIconfs, loc_nQtd

        loc_lOk = .T.

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .T.
        ENDIF

        IF !USED(THIS.this_cCursorServicos)
            RETURN .T.
        ENDIF

        loc_nOldSel   = SELECT()
        loc_cServicos = THIS.this_cCursorServicos

        SELECT (loc_cServicos)

        DO CASE
        CASE VARTYPE(iconfs) = "L"
            loc_cCondIconfs = "iconfs"
        CASE VARTYPE(iconfs) = "N"
            loc_cCondIconfs = "iconfs <> 0"
        OTHERWISE
            loc_cCondIconfs = "UPPER(LEFT(ALLTRIM(iconfs), 1)) == 'S'"
        ENDCASE

        IF USED("csValConfs")
            USE IN csValConfs
        ENDIF

        SELECT COUNT(1) AS Qtd ;
            FROM &loc_cServicos. ;
            WHERE &loc_cCondIconfs. AND (EMPTY(tamde) OR EMPTY(tampara)) ;
            INTO CURSOR csValConfs READWRITE

        loc_nQtd = 0

        IF USED("csValConfs")
            SELECT csValConfs

            IF RECCOUNT("csValConfs") > 0
                GO TOP
                loc_nQtd = TratarNulo(Qtd, 0)
            ENDIF
        ENDIF

        IF loc_nQtd > 0
            MsgAviso("Existe Servi" + CHR(231) + "os sem Informar os campos :" + ;
                     CHR(13) + "TAMANHO DE ou o TAMANHO PARA." + CHR(13) + ;
                     "Favor Verificar!!!", "Aviso")
            loc_lOk = .F.
        ENDIF

        IF USED("csValConfs")
            USE IN csValConfs
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnSairClick - cntOK.btnSair.Click do legado (o botao "Retornar").
    *
    * Legado, depois da validacao acima:
    *   ThisForm.poForm.Enabled = .t.
    *   ThisForm.Release
    *
    * Validacao reprovada ABORTA o fechamento - eh o "Return .F." do legado, e
    * eh o que mantem o usuario na tela para completar a faixa de tamanho.
    *
    * A reabilitacao do chamador tambem esta no Destroy (o dialogo pode fechar
    * por Esc ou QueryUnload); as duas sao idempotentes.
    *
    * Release() e nao Hide(): o chamador nao le nenhum resultado deste dialogo
    * depois que ele fecha - o trabalho fica no cursor crTpmMvItn3, que eh do
    * proprio chamador.
    *
    * O metodo mantem o nome do objeto legado (btnSair), e nao "BtnRetornar",
    * porque eh por essa grafia que o harness de teste automatizado
    * (TesteAutomatico.prg, teste "BtnEncerrarExiste") reconhece o botao de
    * encerramento do dialogo (BtnEncerrarClick/BtnFecharClick/BtnSairClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        IF !THIS.ValidarTamanhosInformados()
            RETURN
        ENDIF

        THIS.ReabilitarChamador()

        THIS.Release()

        RETURN
    ENDPROC

    *==========================================================================
    * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
    *
    * Fecha a tela com o que ainda faltava do dump (tasks\task801\
    * sigopser_form_codigo_fonte.txt), item a item:
    *
    *   SIGOPSER.apaite                      -> LimparCampos()
    *   SIGOPSER.minserelinha                -> InserirLinhaServico()
    *   fwGrade.QTD.Text1.When               -> CelulaQtdLiberada()
    *   fwGrade.QTD.Text1.Valid              -> ValidarCelulaQtd()
    *   fwGrade.VALOR.Text1.When             -> CelulaValorLiberada()
    *   fwGrade.VALOR.Text1.Valid            -> ValidarCelulaValor()
    *   fwGrade.VALOR.Text1.LostFocus        -> CelulaValorLostFocus()
    *   fwGrade.PRODUTO.Text1.LostFocus      -> CelulaServicoLostFocus()
    *   fwGrade.Descricao.Text1.LostFocus    -> CelulaDescricaoLostFocus()
    *   fwGrade.MOEDA.Text1.When     (.f.)   |
    *   fwGrade.TOTAL.Text1.When     (.f.)   |-> InstalarCelulasEdicao()
    *   fwGrade.item.Text1.When      (.f.)   |
    *
    * mais os dois hooks canonicos de transferencia entre a tela e o objeto de
    * negocio (FormParaBO / BOParaForm), que aqui tem por "ficha" a LINHA
    * CORRENTE da grade de servicos mais o painel "Tamanho" - esta tela nao tem
    * Page de Dados, e eh a linha que o usuario edita.
    *
    * NAO existe BtnSalvarClick nem BtnCancelarClick: o legado tem UM unico
    * botao, que VALIDA e FECHA (cntOK.btnSair, ja migrado em BtnSairClick
    * na Fase 7), e as edicoes ja sao gravadas no cursor do CHAMADOR a cada
    * Valid - nao ha o que descartar, e nao existe um segundo botao
    * que abandone. A tecla Esc chega ao botao pelo "Command1.Cancel = .T." que
    * o SCX declara e que ConfigurarBotaoRetornar transcreve; criar aqui um
    * BtnCancelarClick apontando para o mesmo handler daria a um metodo que
    * valida e fecha um nome que promete descartar - e descartar eh o que esta
    * tela nao faz.
    *==========================================================================

    *--------------------------------------------------------------------------
    * InstalarCelulasEdicao - poe nas colunas "Quantidade" (Column2) e "Valor"
    * (Column3) os TextBox que carregam o When/Valid/LostFocus do legado, e
    * tranca as tres colunas cujo When do legado eh "Return .f.".
    *
    * Mesma razao de InstalarCelulasLookup para usar SUBCLASSE e nao BINDEVENT:
    * BINDEVENT em "Valid" de TextBox de Column nao eh confiavel em VFP9
    * (regra #46), e BINDEVENT em "When" DESCARTA o retorno do delegate, de
    * modo que o gate nao bloquearia nada.
    *
    * As tres colunas somente-exibicao (MOEDA, TOTAL e item) recebem
    * Column.ReadOnly = .T., que eh o equivalente do "Return .f." no When: o
    * usuario nao digita nelas e a celula continua desenhada como no legado
    * (Enabled = .F. a acinzentaria e mudaria a tela). O ReadOnly da COLUNA vem
    * DEPOIS do ReadOnly do GRID, que propaga para as colunas e sobrescreveria
    * o valor posto aqui (regra #18).
    *
    * Chamado por VincularGrade, logo apos InstalarCelulasLookup e pelo mesmo
    * motivo: atribuir RecordSource/ControlSource devolve Sparse e
    * CurrentControl ao default, e as celulas voltariam a ser o Text1 original,
    * sem os eventos do legado.
    *
    * A mascara do valor eh LIDA da Column3 em vez de repetida: ela eh
    * calculada em VincularGrade a partir das casas decimais da operacao, e
    * duplicar o numero aqui faria as duas copias divergirem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InstalarCelulasEdicao()
        LOCAL loc_cMascaraValor

        *-- Column2 = QTD
        IF !PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_CelQtd", 5)
            THIS.grd_4c_Dados.Column2.AddObject("txt_4c_CelQtd", "TextBoxQtdSer_4c")
        ENDIF

        WITH THIS.grd_4c_Dados.Column2.txt_4c_CelQtd
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .InputMask   = "99999.999"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .ToolTipText = "Quantidade do Servi" + CHR(231) + "o"
            .Visible     = .T.
        ENDWITH

        *-- Column3 = VALOR
        loc_cMascaraValor = THIS.grd_4c_Dados.Column3.InputMask

        IF !PEMSTATUS(THIS.grd_4c_Dados.Column3, "txt_4c_CelValor", 5)
            THIS.grd_4c_Dados.Column3.AddObject("txt_4c_CelValor", "TextBoxValorSer_4c")
        ENDIF

        WITH THIS.grd_4c_Dados.Column3.txt_4c_CelValor
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .InputMask   = loc_cMascaraValor
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .ToolTipText = "Valor Unit" + CHR(225) + "rio do Servi" + CHR(231) + "o"
            .Visible     = .T.
        ENDWITH

        *-- CurrentControl por ULTIMO, e so depois Sparse/ReadOnly
        WITH THIS.grd_4c_Dados.Column2
            .CurrentControl = "txt_4c_CelQtd"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .CurrentControl = "txt_4c_CelValor"
            .Sparse         = .F.
            .ReadOnly       = .F.
        ENDWITH

        *-- MOEDA / TOTAL / item: o "Return .f." do When de cada uma
        THIS.grd_4c_Dados.Column4.ReadOnly = .T.
        THIS.grd_4c_Dados.Column5.ReadOnly = .T.
        THIS.grd_4c_Dados.Column6.ReadOnly = .T.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaQtdLiberada - o When da coluna "Quantidade".
    *
    * Legado (QTD.Text1.When):
    *   Return Not Empty(crTpmMvItn3.CPros) And
    *          Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])
    *
    * Isto e: so se digita quantidade depois que a linha ja tem servico, e
    * apenas quando o documento esta em inclusao ou alteracao.
    *
    * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaQtdLiberada(par_oTxt)
        LOCAL loc_lTemServico

        loc_lTemServico = .F.

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)
            loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
        ENDIF

        RETURN loc_lTemServico AND INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCelulaQtd - o Valid da coluna "Quantidade".
    *
    * Legado (QTD.Text1.Valid):
    *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe',
    *                                              'Dopes', TprMvCab.Dopes)
    *   If Inlist( Thisform.Op_escolha, 'INSERIR', 'ALTERAR' )
    *       If Lastkey()=13
    *           llNovaLinha = .t.
    *           Select crTpmMvItn3
    *           Thisform.Foco = 'fwgrade.Produto'
    *           Thisform.mInsereLinha()
    *       Endif
    *   EndIf
    *   Thisform.Calc_ValIte()
    *
    * O Cursorquery do topo eh a releitura da configuracao da operacao, que
    * aqui mora em CarregarConfiguracaoOperacao - o metodo faz exatamente o que
    * o Cursorquery fazia (le SigCdOpe pela Dopes do cabecalho e guarda o
    * resultado nas propriedades do BO).
    *
    * llNovaLinha eh declarada e atribuida no legado e NUNCA lida - por isso
    * nao tem equivalente aqui.
    *
    * Devolve .T. sempre: o legado nao tem Return nenhum neste Valid, e Valid
    * sem Return deixa o foco seguir.
    *
    * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCelulaQtd(par_oTxt)
        THIS.CarregarConfiguracaoOperacao()

        IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            IF LASTKEY() = 13
                IF USED(THIS.this_cCursorServicos)
                    SELECT (THIS.this_cCursorServicos)
                ENDIF

                THIS.this_cFoco = "fwgrade.Produto"
                THIS.InserirLinhaServico()
            ENDIF
        ENDIF

        THIS.TotalizarLinha()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaValorLiberada - o When da coluna "Valor".
    *
    * Legado (VALOR.Text1.When):
    *   ThisForm.OldPreco = This.Value
    *   Return InList(ThisForm.Op_Escolha, [INSERIR], [ALTERAR]) And
    *          Not Empty(crTpmMvItn3.CPros) And ThisForm.lAutPreco
    *
    * lAutPreco so fica ligada quando o usuario pede "Alterar Valores"
    * (btnAltImps) - por isso, em condicao normal, o valor unitario NAO eh
    * digitavel: ele vem da tabela de preco.
    *
    * OldPreco eh guardado AQUI, na entrada da celula, porque eh ele que o
    * Valid restaura quando o usuario digita um preco negativo.
    *
    * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaValorLiberada(par_oTxt)
        LOCAL loc_lTemServico

        IF VARTYPE(par_oTxt) = "O" AND VARTYPE(par_oTxt.Value) = "N"
            THIS.this_nOldPreco = par_oTxt.Value
        ENDIF

        loc_lTemServico = .F.

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)
            loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
        ENDIF

        RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") ;
               AND loc_lTemServico AND THIS.this_lAutPreco
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCelulaValor - o Valid da coluna "Valor".
    *
    * Legado (VALOR.Text1.Valid), transcrito linha a linha:
    *   lnCasas = CrSigCdOpe.Casas
    *   Thisform.Foco = ''
    *   This.Value = Round( This.Value, lnCasas )
    *   If This.Value < 0
    *       MessageBox('Preco Invalido',0+48,'')
    *       This.value = Thisform.OldPreco
    *       Return 0
    *   EndIf
    *   If Not ThisForm.plVlrZeroGarantia And This.Value = 0
    *       MessageBox('Preco Nao Pode Ser Zerado.',0+48,'')
    *       Return .F.
    *   EndIf
    *   This.Refresh
    *   Thisform.lAutPreco = .F.
    *   If Empty(This.Value)
    *       Thisform.Calc_valite()
    *   EndIf
    *   If LastKey()=13
    *       If Inlist( Thisform.Op_Escolha, 'INSERIR', 'ALTERAR' )
    *           Thisform.Foco = 'fwgrade.Produto'
    *           Thisform.mInsereLinha()
    *           Thisform.fwgrade.Refresh
    *       EndIf
    *   EndIf
    *
    * Os DOIS retornos de recusa sao diferentes de proposito e sao transcritos
    * como estao: 0 mantem o foco na celula com o conteudo selecionado (preco
    * negativo, que ja foi revertido para OldPreco) e .F. mantem o foco sem
    * selecionar (preco zero). Trocar um pelo outro mudaria o que o usuario ve
    * ao errar o campo.
    *
    * O ROUND com as casas da operacao eh regra de negocio: a coluna units tem
    * 6 decimais no banco e eh a configuracao da operacao que decide quantas
    * valem para esta tela.
    *
    * "If Empty(This.Value)" so eh alcancado quando o valor eh ZERO E a
    * garantia permite zero - o Return .F. acima ja barrou o zero nos demais
    * casos. Transcrito assim mesmo.
    *
    * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCelulaValor(par_oTxt)
        LOCAL loc_nCasas, loc_nValor, loc_uRetorno

        IF VARTYPE(par_oTxt) != "O" OR VARTYPE(par_oTxt.Value) != "N"
            RETURN .T.
        ENDIF

        loc_nCasas      = THIS.this_oBusinessObject.this_nCasas
        THIS.this_cFoco = ""

        par_oTxt.Value = ROUND(par_oTxt.Value, loc_nCasas)
        loc_nValor     = par_oTxt.Value
        loc_uRetorno   = .T.

        DO CASE
        CASE loc_nValor < 0
            MsgAviso("Pre" + CHR(231) + "o Inv" + CHR(225) + "lido", "Aviso")
            par_oTxt.Value = THIS.this_nOldPreco
            loc_uRetorno   = 0

        CASE !THIS.this_lValorZeroGarantia AND loc_nValor = 0
            MsgAviso("Pre" + CHR(231) + "o N" + CHR(227) + "o Pode Ser Zerado.", "Aviso")
            loc_uRetorno = .F.

        OTHERWISE
            par_oTxt.Refresh()
            THIS.this_lAutPreco = .F.

            IF EMPTY(loc_nValor)
                THIS.TotalizarLinha()
            ENDIF

            IF LASTKEY() = 13
                IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
                    THIS.this_cFoco = "fwgrade.Produto"
                    THIS.InserirLinhaServico()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        ENDCASE

        RETURN loc_uRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaValorLostFocus - o LostFocus da coluna "Valor".
    *
    * Legado (VALOR.Text1.LostFocus):
    *   Thisform.lAutPreco = .F.
    *   Select crTpmMvItn3
    *   If Not IsEmpty(Thisform.Foco)
    *       lcFoco = AllTrim(Thisform.Foco)
    *       Thisform.Foco = ''
    *       Thisform.&lcFoco..Refresh
    *       Thisform.&lcFoco..SetFocus
    *   EndIf
    *
    * Desligar lAutPreco ao SAIR da celula eh o que faz a autorizacao dada pelo
    * botao "Alterar Valores" valer por UMA edicao so.
    *
    * O desvio do foco esta em AplicarFoco: o nome guardado em this_cFoco eh o
    * do objeto LEGADO ("fwgrade.Produto"), que no migrado se chama
    * grd_4c_Dados.Column1 (PILAR 3) - a macro do legado nao tem como ser
    * transcrita literalmente.
    *
    * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaValorLostFocus()
        THIS.this_lAutPreco = .F.

        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)
        ENDIF

        THIS.AplicarFoco()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFoco - o "Thisform.&lcFoco..Refresh / .SetFocus" do legado.
    *
    * this_cFoco guarda o nome do objeto do LEGADO, exatamente como as duas
    * unicas atribuicoes do dump o escrevem ('fwgrade.Produto', nos Valid de
    * QTD e de VALOR). Aqui o nome eh TRADUZIDO para o objeto migrado em vez de
    * expandido por macro: os nomes do migrado sao diferentes por imposicao do
    * PILAR 3, e "&lcFoco" apontaria para objeto inexistente.
    *
    * O nome eh consumido (zerado) na entrada, como no legado.
    *
    * Grade sem linha nao recebe foco: SetFocus sobre grade vazia estoura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarFoco()
        LOCAL loc_cFoco

        loc_cFoco = UPPER(ALLTRIM(THIS.this_cFoco))

        IF EMPTY(loc_cFoco)
            RETURN
        ENDIF

        THIS.this_cFoco = ""

        DO CASE
        CASE loc_cFoco == "FWGRADE.PRODUTO"
            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
               AND USED(THIS.this_cCursorServicos) ;
               AND RECCOUNT(THIS.this_cCursorServicos) > 0

                THIS.grd_4c_Dados.Column1.Refresh()
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        ENDCASE

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaServicoLostFocus / CelulaDescricaoLostFocus - o LostFocus das
    * colunas "Servico" e "Descricao".
    *
    * Legado (PRODUTO.Text1.LostFocus):
    *   ThisForm.AntCpro = Space(10)
    *   If Empty(This.Value) And (Lastkey() = 13)
    *       ThisForm.cntOK.btnSair.SetFocus
    *   EndIf
    *
    * Legado (Descricao.Text1.LostFocus): identico, com Space(40).
    *
    * Isto e: sair da celula com ENTER sem ter digitado nada leva o foco ao
    * botao Retornar - eh o atalho com que o usuario encerra a digitacao da
    * grade. O tamanho do Space() difere entre as duas celulas e eh transcrito
    * como esta (a propriedade so eh lida com Padr/comparacao, entao o numero
    * nao muda o comportamento, mas tambem nao se inventa).
    *
    * cntOK.btnSair eh o membro 1 do CommandGroup cmg_4c_CntOK.
    *
    * PUBLIC: sao chamados pelas subclasses de TextBox, de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE CelulaServicoLostFocus(par_oTxt)
        THIS.this_cAntCPro = SPACE(10)
        THIS.FocarRetornarSeVazio(par_oTxt)

        RETURN
    ENDPROC

    PROCEDURE CelulaDescricaoLostFocus(par_oTxt)
        THIS.this_cAntCPro = SPACE(40)
        THIS.FocarRetornarSeVazio(par_oTxt)

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarRetornarSeVazio - a segunda metade dos dois LostFocus acima, que eh
    * identica nos dois. Em metodo unico para as duas celulas nao divergirem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarRetornarSeVazio(par_oTxt)
        LOCAL loc_cValor

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cValor = IIF(VARTYPE(par_oTxt.Value) = "C", ALLTRIM(par_oTxt.Value), "")

        IF EMPTY(loc_cValor) AND LASTKEY() = 13
            IF THIS.cmg_4c_CntOK.Visible AND THIS.cmg_4c_CntOK.Enabled
                THIS.cmg_4c_CntOK.Buttons(1).SetFocus()
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaServico - o "mInsereLinha" do legado (metodo de form).
    *
    * Legado:
    *   Select crTpmMvItn3
    *   Locate For cpros = Space(14)
    *   If Eof()
    *       Insert Into crTpmMvItn3(Emps, Dopes, Numes, Citens) ;
    *              Values (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes,
    *                      ThisForm.Citem)
    *       Insert Into csTmpDesc (nControle, nLInhas) ;
    *              Values (RecNo([crTpmMvItn3]), ThisForm.nCItem2)
    *       ThisForm.nCItem2 = ThisForm.nCItem2 + 1
    *   EndIf
    *   Select crTpmMvItn3 / Set Order To CItens / Set Key To ThisForm.Citem
    *   Select crTpmMvItn3 / Set Relation To Str(Recno([crTpmMvItn3]),8)
    *                                        Into csTmpDesc
    *   Select crTpmMvItn3
    *   If Not ThisForm.lAutPreco
    *       Keyboard [{DNARROW}]
    *   EndIf
    *   Keyboard [{DNARROW}]
    *   ThisForm.OldCodBarras = []
    *   ThisForm.AntCPro = Space(10)
    *   ThisForm.AntValu = Space(3)
    *
    * "Locate For cpros = Space(14)" procura a linha AINDA EM BRANCO: se ja
    * existe uma, nao se cria outra. Transcrito como EMPTY(cpros), que produz o
    * mesmo conjunto e nao depende do SET EXACT em vigor - o projeto roda com
    * SET EXACT ON, em que a comparacao com Space(14) passa a exigir tamanho
    * igual, e EMPTY eh imune aos dois casos.
    *
    * O INSERT vai pelo BO, como em GarantirLinhaEmBranco: eh o BO que conhece
    * as colunas da linha e o contexto do movimento (Emps/Dopes/Numes vindos de
    * TprMvCab e Citens vindo do item), e as propriedades da linha sao limpas
    * antes para a linha nova nao nascer com os dados do servico anterior.
    *
    * Os DOIS "Keyboard {DNARROW}" sao transcritos como estao: o primeiro, que
    * so acontece quando o preco NAO foi liberado, pula a coluna do valor; o
    * segundo desce para a linha seguinte. Sao o que leva o cursor de digitacao
    * ate a linha nova.
    *
    * PUBLIC: eh chamado pelos Valid das celulas de quantidade e de valor, que
    * moram nas subclasses de TextBox - de FORA desta classe.
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaServico()
        LOCAL loc_cServicos, loc_nRegistro

        loc_cServicos = THIS.this_cCursorServicos

        IF !USED(loc_cServicos)
            RETURN
        ENDIF

        SELECT (loc_cServicos)
        LOCATE FOR EMPTY(cpros)

        IF EOF()
            THIS.LimparDadosLinhaBO()

            IF THIS.this_oBusinessObject.Inserir()
                loc_nRegistro = RECNO(loc_cServicos)

                IF USED(THIS.this_cCursorDescricoes)
                    INSERT INTO csTmpDesc (nControle, nLinhas) ;
                        VALUES (loc_nRegistro, THIS.this_nCItem2)
                ENDIF

                THIS.this_nCItem2 = THIS.this_nCItem2 + 1
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao incluir linha de servi" + CHR(231) + "o")
            ENDIF
        ENDIF

        *-- Set Order To CItens + Set Key To <item> do legado
        THIS.AplicarEscopoItem()

        *-- Set Relation To Str(Recno(...),8) Into csTmpDesc do legado
        THIS.AplicarRelacaoDescricoes()

        SELECT (loc_cServicos)

        IF !THIS.this_lAutPreco
            KEYBOARD "{DNARROW}"
        ENDIF

        KEYBOARD "{DNARROW}"

        THIS.this_cOldCodBarras = ""
        THIS.this_cAntCPro      = SPACE(10)
        THIS.this_cAntValu      = SPACE(3)

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDadosLinhaBO - zera as propriedades do BO que descrevem UMA linha
    * de servico, deixando intacto o contexto do movimento (Emps/Dopes/Numes e
    * o Citens do item) e a configuracao da operacao.
    *
    * Existe como metodo unico porque DOIS caminhos precisam dela e tem de
    * limpar exatamente as MESMAS colunas: a linha em branco criada na abertura
    * (GarantirLinhaEmBranco) e a linha acrescentada em runtime
    * (InserirLinhaServico). Duplicar a lista faria as duas copias divergirem
    * na primeira coluna nova.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDadosLinhaBO()
        WITH THIS.this_oBusinessObject
            .this_cCidChaves = ""
            .this_cCpros     = ""
            .this_cDpros     = ""
            .this_cCunis     = ""
            .this_nQtds      = 0
            .this_nUnits     = 0
            .this_nUnivals   = 0
            .this_nTotas     = 0
            .this_cMoedas    = ""
            .this_cMoefats   = ""
            .this_cMoevs     = ""
            .this_nMoevals   = 0
            .this_lIconfs    = .F.
            .this_nCodBarras = 0
            .this_nUtilizas  = 0
            .this_cNotas     = ""
            .this_cObs       = ""
            .this_cTamDe     = ""
            .this_cTamPara   = ""
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRelacaoDescricoes - o "Set Relation To Str(Recno(...),8) Into
    * csTmpDesc" do legado, com o SET ORDER do lado FILHO que ele pressupoe.
    *
    * Metodo unico pelos mesmos dois caminhos de LimparDadosLinhaBO: a montagem
    * inicial (MontarDescricoesPorLinha) e a insercao em runtime
    * (InserirLinhaServico) - o legado repete o comando nos dois.
    *
    * A expressao eh montada por MACRO, com o nome do cursor pai LITERAL dentro
    * dela: SET RELATION GUARDA a expressao e a reavalia a cada movimento do
    * cursor, muito depois deste metodo terminar - um "THIS" ali dentro nao
    * teria como ser resolvido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarRelacaoDescricoes()
        LOCAL loc_cRelacao

        IF !USED(THIS.this_cCursorServicos) OR !USED(THIS.this_cCursorDescricoes)
            RETURN
        ENDIF

        SELECT (THIS.this_cCursorDescricoes)
        SET ORDER TO TAG iControle

        loc_cRelacao = "STR(RECNO('" + THIS.this_cCursorServicos + "'), 8)"

        SELECT (THIS.this_cCursorServicos)
        SET RELATION TO &loc_cRelacao. INTO csTmpDesc

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - o "apaite" do legado (metodo de form).
    *
    * Legado:
    *   Select crTpmMvItn3
    *   Replace DPros With [], Obs With [], CodBarras With 00, Utilizas With 00,
    *           TamDe With [], TamPara With [], iConfs With .F.,
    *           Notas With [] In crTpmMvItn3
    *   With Thisform.fwGrade
    *       .Produto.Text1.Value = [] / .Qtd.Text1.Value   = 0
    *       .Valor.Text1.Value   = 0  / .Moeda.Text1.Value = ''
    *       .Total.Text1.Value   = 0
    *       (Refresh de cada um e da grade)
    *   EndWith
    *
    * Limpa a linha CORRENTE: as colunas descritivas do cursor e o conteudo
    * exibido nas cinco primeiras celulas. O codigo do servico (cpros) e a
    * quantidade (qtds) NAO sao apagados do CURSOR pelo legado - so da tela -,
    * e isso eh transcrito como esta.
    *
    * iConfs eh coluna "bit" no SQL Server e chega ao cursor VFP ora Logico ora
    * Numerico conforme o driver: o tipo eh medido e o REPLACE usa o valor
    * compativel - gravar o tipo errado dispara "Operator/operand type
    * mismatch" (mesmo cuidado de MarcarConfirmacaoTamanho).
    *
    * O painel "Tamanho" eh repintado no fim porque TamDe/TamPara acabaram de
    * ser zerados no cursor - sem isso a tela continuaria exibindo a faixa de
    * uma linha que nao a tem mais.
    *
    * PUBLIC: eh um metodo de form no legado, chamavel de fora - o SCX o
    * declara em ClassInfo junto com calc_valite e minserelinha.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_cServicos

        loc_cServicos = THIS.this_cCursorServicos

        IF USED(loc_cServicos)
            SELECT (loc_cServicos)

            IF !EOF()
                REPLACE dpros     WITH "", ;
                        obs       WITH "", ;
                        codbarras WITH 0, ;
                        utilizas  WITH 0, ;
                        tamde     WITH "", ;
                        tampara   WITH "", ;
                        notas     WITH ""

                IF VARTYPE(iconfs) = "L"
                    REPLACE iconfs WITH .F.
                ELSE
                    REPLACE iconfs WITH 0
                ENDIF
            ENDIF
        ENDIF

        *-- As cinco celulas que o legado limpa na tela. O controle que DESENHA
        *-- a celula eh o da subclasse quando ela esta instalada (colunas 1, 2 e
        *-- 3) e o Text1 nas demais - por isso cada uma eh tratada pelo seu nome
        WITH THIS.grd_4c_Dados
            IF PEMSTATUS(.Column1, "txt_4c_CelServico", 5)
                .Column1.txt_4c_CelServico.Value = ""
                .Column1.txt_4c_CelServico.Refresh()
            ENDIF

            IF PEMSTATUS(.Column2, "txt_4c_CelQtd", 5)
                .Column2.txt_4c_CelQtd.Value = 0
                .Column2.txt_4c_CelQtd.Refresh()
            ENDIF

            IF PEMSTATUS(.Column3, "txt_4c_CelValor", 5)
                .Column3.txt_4c_CelValor.Value = 0
                .Column3.txt_4c_CelValor.Refresh()
            ENDIF

            .Column4.Text1.Value = ""
            .Column4.Text1.Refresh()

            .Column5.Text1.Value = 0
            .Column5.Text1.Refresh()

            .Refresh()
        ENDWITH

        *-- TamDe/TamPara foram zerados no cursor: o painel acompanha
        THIS.CarregarValoresTamanhoDaLinha()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere o que esta na TELA para o objeto de negocio.
    *
    * A "ficha" desta tela eh a LINHA CORRENTE da grade de servicos mais o
    * painel "Tamanho" - nao ha Page de Dados, e eh a linha que o usuario
    * edita. Por isso a transferencia tem tres partes:
    *
    *   1. a linha corrente do cursor de grade, que eh o que as celulas ja
    *      gravaram (grade ligada por ControlSource escreve DIRETO no cursor),
    *      lida pelo CarregarDoCursor do BO;
    *   2. os dois campos que NAO estao na grade - TamDe e TamPara, do painel
    *      "Tamanho" -, que sobrescrevem o que veio do cursor justamente para
    *      capturar o que o usuario digitou e ainda nao foi gravado;
    *   3. o contexto do dialogo (item dono dos servicos e os dois flags de
    *      garantia recebidos do chamador).
    *
    * Devolve .F. quando nao ha linha corrente de onde ler - o chamador decide
    * o que fazer, como o legado faz ao testar Eof([crTpmMvItn3]).
    *
    * PUBLIC: eh um dos dois hooks canonicos de transferencia e eh chamado de
    * fora da classe (pelo botao Retornar e pelo harness de teste).
    *--------------------------------------------------------------------------
    FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_nAreaAnterior

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_nAreaAnterior = SELECT()

        *-- 1. Linha corrente da grade
        IF USED(THIS.this_cCursorServicos)
            SELECT (THIS.this_cCursorServicos)

            IF !EOF()
                loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor( ;
                                   THIS.this_cCursorServicos)
            ENDIF
        ENDIF

        WITH THIS.this_oBusinessObject
            *-- 2. Painel "Tamanho" (fora da grade, logo fora do cursor)
            .this_cTamDe   = ALLTRIM(THIS.cnt_4c_Tamanho.txt_4c_TamDe.Value)
            .this_cTamPara = ALLTRIM(THIS.cnt_4c_Tamanho.txt_4c_TamPara.Value)

            *-- 3. Contexto do dialogo
            .this_nCitemProduto      = THIS.this_nCItem
            .this_lGarantia          = THIS.this_lGarantia
            .this_lValorZeroGarantia = THIS.this_lValorZeroGarantia
        ENDWITH

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLinhaCorrente - leva para o cursor de grade o que esta na TELA.
    *
    * Eh o "Replace TamDe/TamPara With This.Value In crTpmMvItn3" que o legado
    * faz no Valid dos dois campos do painel "Tamanho", escrito pela camada: a
    * tela vai para o BO (FormParaBO) e eh o BO que grava (AtualizarTamanhos).
    *
    * AtualizarTamanhos, e nao Atualizar: esta ultima regrava a LINHA INTEIRA,
    * e o legado toca aqui SOMENTE as duas colunas do painel - ampliar a
    * escrita para as outras 16 colunas levaria junto iconfs, cujo tipo varia
    * conforme o driver que montou o cursor do chamador.
    *
    * Metodo unico porque os dois campos do painel fazem exatamente o mesmo
    * caminho; sem linha corrente nao ha o que gravar, e sair calado aqui eh o
    * que o legado faz (o Replace dele tambem nao tem efeito em EOF).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarLinhaCorrente()
        IF !USED(THIS.this_cCursorServicos)
            RETURN
        ENDIF

        SELECT (THIS.this_cCursorServicos)

        IF EOF()
            RETURN
        ENDIF

        IF THIS.FormParaBO()
            IF !THIS.this_oBusinessObject.AtualizarTamanhos()
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao gravar o tamanho do servi" + CHR(231) + "o")
            ENDIF
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere o objeto de negocio para a TELA.
    *
    * O inverso de FormParaBO, com as mesmas partes:
    *
    *   1. o cabecalho do dialogo - os tres campos somente-exibicao que
    *      identificam o PRODUTO dono dos servicos (Get_Produto/Get_Descricao/
    *      Get_Mercs do legado), que o BO guarda em propriedades proprias
    *      (this_cCprosItem / this_cDprosItem / this_cMercsItem) para nao se
    *      confundirem com o codigo e a descricao do SERVICO da linha;
    *   2. o painel "Tamanho" da linha corrente.
    *
    * As celulas da GRADE ficam de fora de proposito: elas estao ligadas ao
    * cursor por ControlSource e se desenham sozinhas a partir dele - escrever
    * .Value numa celula ligada GRAVARIA de volta no cursor, que eh justamente
    * de onde o valor acabou de vir. O que esta tela precisa aqui eh so
    * REPINTAR a grade.
    *
    * A VISIBILIDADE do painel "Tamanho" NAO eh tocada aqui: quem a decide eh o
    * AfterRowColChange da grade, que eh onde o legado a decide. Mexer nela
    * aqui faria o painel aparecer ja na abertura da tela, que eh exatamente o
    * que o legado nao faz.
    *
    * PUBLIC: eh um dos dois hooks canonicos de transferencia e eh chamado de
    * fora da classe (pelo funil de carga da linha e pelo harness de teste).
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            *-- 1. Identificacao do produto dono dos servicos
            THIS.txt_4c_Produto.Value   = ALLTRIM(.this_cCprosItem)
            THIS.txt_4c_Descricao.Value = ALLTRIM(.this_cDprosItem)
            THIS.txt_4c_Mercs.Value     = ALLTRIM(.this_cMercsItem)

            *-- 2. Painel "Tamanho" da linha corrente
            THIS.cnt_4c_Tamanho.txt_4c_TamDe.Value   = ALLTRIM(.this_cTamDe)
            THIS.cnt_4c_Tamanho.txt_4c_TamPara.Value = ALLTRIM(.this_cTamPara)
        ENDWITH

        THIS.grd_4c_Dados.Refresh()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    *
    * A lista de excecao existe porque TRES objetos nascem OCULTOS no SCX
    * legado (Visible = .F. no dump) e sao mostrados em runtime pelos handlers:
    *
    *   btnTotItens  -> cmd_4c_BtnTotItens   ("Total de Servicos")
    *   btnCotacao   -> cmd_4c_BtnCotacao    ("Excluir Servicos")
    *   btnAltImps   -> cmd_4c_BtnAltImps    ("Alterar Valores")
    *
    * Forcar Visible = .T. neles APAGARIA o estado inicial que o legado
    * declara. A verificacao eh por nome, como manda o padrao dos forms
    * OPERACIONAIS com controles de visibilidade alternada; os tres objetos
    * sao criados por ConfigurarBotoesServico, e a lista os cobre.
    *
    * Grid fica fora da recursao: suas Columns nao sao controles de container
    * comum, e a visibilidade delas eh definida junto com a grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle, loc_cNome

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                loc_cNome = UPPER(ALLTRIM(loc_oControle.Name))

                IF !INLIST(loc_cNome, "CMD_4C_BTNTOTITENS", ;
                                      "CMD_4C_BTNCOTACAO", ;
                                      "CMD_4C_BTNALTIMPS")
                    IF PEMSTATUS(loc_oControle, "Visible", 5)
                        loc_oControle.Visible = .T.
                    ENDIF
                ENDIF

                IF UPPER(ALLTRIM(loc_oControle.BaseClass)) != "GRID" ;
                   AND PEMSTATUS(loc_oControle, "ControlCount", 5) ;
                   AND loc_oControle.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores que ESTA tela cria e libera as referencias.
    *
    * Os cursores do CHAMADOR (crTpmMvItn3, crTpmMvItn, TprMvCab, CrSigCdOpe)
    * NAO sao fechados aqui: eles pertencem ao form que abriu o dialogo e
    * continuam em uso depois que esta tela fecha. Fecham-se apenas os dois que
    * o dialogo monta para si (csTmpDesc e csSigCdPro).
    *
    * CrSigCdOpe fica de fora mesmo quando foi esta tela que o consultou (ver
    * CarregarConfiguracaoOperacao): o Cursorquery do legado tambem o deixa
    * aberto na sessao do chamador, e o documento continua precisando dele.
    *
    * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
    * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
    * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
    * existe para o caso em que o buffer de fato tenha algo a descartar).
    *
    * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
    * restaura os popups do menu principal depois de um form modal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_cCursor
        LOCAL ARRAY loc_aCursores[2]

        loc_aCursores[1] = THIS.this_cCursorDescricoes
        loc_aCursores[2] = THIS.this_cCursorLista

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cCursor = loc_aCursores[loc_nI]

            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR

        *-- Devolve o chamador ao usuario mesmo quando o dialogo eh fechado por
        *-- Esc ou por QueryUnload, e nao pelo botao Retornar
        THIS.ReabilitarChamador()

        THIS.this_oFormChamador = .NULL.
        THIS.this_oFormPai      = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxServicoSer_4c / TextBoxDescricaoSer_4c
*
* As celulas das colunas "Servico" e "Descricao" da grade de servicos. Existem
* como SUBCLASSE, e nao como BINDEVENT sobre o Text1 da Column, porque
* BINDEVENT em "Valid" de TextBox de Column nao eh confiavel em VFP9
* (regra #46) - e eh justamente no Valid que o legado poe o lookup.
*
* Nenhuma das duas carrega regra: cada evento DELEGA ao form dono, alcancado
* por THISFORM. Assim o funil do lookup continua unico e a guarda de
* reentrancia continua valendo para as quatro portas. THISFORM em vez de uma
* referencia guardada numa propriedade de proposito: o par form-celula criaria
* um ciclo de referencias que impediria a liberacao do form.
*
* KeyPress so age em F4 (115) e F5 (116): sem esse teste o picker abriria a
* cada tecla digitada (regra #47). NODEFAULT impede o VFP de tratar a tecla
* depois que o dialogo ja a consumiu.
*==============================================================================
DEFINE CLASS TextBoxServicoSer_4c AS TextBox

    PROCEDURE When()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.CelulaServicoLiberada(THIS)
    ENDPROC

    PROCEDURE Valid()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.ValidarCelulaServico(THIS)
    ENDPROC

    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) AND VARTYPE(THISFORM) = "O"
            THISFORM.ValidarCelulaServico(THIS)
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        IF VARTYPE(THISFORM) = "O"
            THISFORM.ValidarCelulaServico(THIS)
        ENDIF
    ENDPROC

    PROCEDURE LostFocus()
        IF VARTYPE(THISFORM) = "O"
            THISFORM.CelulaServicoLostFocus(THIS)
        ENDIF
    ENDPROC

ENDDEFINE

DEFINE CLASS TextBoxDescricaoSer_4c AS TextBox

    PROCEDURE When()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.CelulaDescricaoLiberada(THIS)
    ENDPROC

    PROCEDURE Valid()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.ValidarCelulaDescricao(THIS)
    ENDPROC

    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) AND VARTYPE(THISFORM) = "O"
            THISFORM.ValidarCelulaDescricao(THIS)
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        IF VARTYPE(THISFORM) = "O"
            THISFORM.ValidarCelulaDescricao(THIS)
        ENDIF
    ENDPROC

    PROCEDURE LostFocus()
        IF VARTYPE(THISFORM) = "O"
            THISFORM.CelulaDescricaoLostFocus(THIS)
        ENDIF
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxQtdSer_4c / TextBoxValorSer_4c
*
* As celulas das colunas "Quantidade" e "Valor" da grade de servicos. Existem
* pelo MESMO motivo das duas subclasses acima: o legado poe When, Valid e
* LostFocus no Text1 de cada coluna, e nenhum dos tres pode ser ligado por
* BINDEVENT - "Valid" de TextBox de Column nao eh confiavel em VFP9
* (regra #46) e "When" ligado por BINDEVENT tem o retorno DESCARTADO, de modo
* que o gate de edicao nao bloquearia nada.
*
* Nenhuma das duas carrega regra: cada evento DELEGA ao form dono, alcancado
* por THISFORM - assim as regras do legado ficam num lugar so e podem ser
* lidas lado a lado com o dump.
*==============================================================================
DEFINE CLASS TextBoxQtdSer_4c AS TextBox

    PROCEDURE When()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.CelulaQtdLiberada(THIS)
    ENDPROC

    PROCEDURE Valid()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.ValidarCelulaQtd(THIS)
    ENDPROC

ENDDEFINE

DEFINE CLASS TextBoxValorSer_4c AS TextBox

    PROCEDURE When()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.CelulaValorLiberada(THIS)
    ENDPROC

    PROCEDURE Valid()
        IF VARTYPE(THISFORM) != "O"
            RETURN .T.
        ENDIF

        RETURN THISFORM.ValidarCelulaValor(THIS)
    ENDPROC

    PROCEDURE LostFocus()
        IF VARTYPE(THISFORM) = "O"
            THISFORM.CelulaValorLostFocus()
        ENDIF
    ENDPROC

ENDDEFINE
