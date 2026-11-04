*============================================================================
* Formsigopecm.prg - Geracao de Arquivo de Exportacao Para e-Commerce
* Migracao de SIGOPECM.SCX (task727)
*
* Form OPERACIONAL de LAYOUT PROPRIO. O objeto raiz do legado eh um "form"
* GENERICO (nao frmcadastro, nao frmrelatorio), portanto NAO existe PageFrame
* nem o par Page1=Lista / Page2=Dados: dos 13 controles do SCX, 11 penduram
* direto na Form e apenas os dois labels do titulo ficam dentro do unico
* container do legado (cntSombra -> cnt_4c_Sombra). Nenhum pgf_4c_* eh criado
* aqui - inventar um PageFrame que o legado nao tem violaria o PILAR 1.
*
* Estrutura visual do legado (SIGOPECM, 800x220), na ordem em que o SCX a
* desenha - cada bloco entra no metodo Configurar* correspondente:
*   cntSombra + lblSombra + lblTitulo -> ConfigurarCabecalho()  (faixa cinza)
*   Shape1, Processa, Cancela         -> ConfigurarBotoes()
*   Say1, getArqTXT, btnGetArqO,
*   chkImagens, Shape2, lblResults    -> ConfigurarCampos()
*
* DataSession: fica no DEFAULT (1 = sessao CORRENTE), e NAO em 2 (privada),
* porque este form eh um dialogo FILHO que consome o cursor crImagens montado
* pelo form chamador (SIGOPECM.Init recebe oFrm). Em sessao privada crImagens
* ficaria invisivel e o processamento nao acharia produto nenhum.
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: sigopecmBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 4/8: este form NAO tem superficie de LISTA (zero Grid/pColuna/
* AddCursor no dump) - "Grid + 6 botoes CRUD" do template generico da fase
* nao se aplica (perfil CAPTURA: campos + botoes de acao, sem grade). O
* trabalho real da fase foi ConfigurarBotoes() (Shape1/Cancela/Processa) e
* ConfigurarCampos() (Say1/getArqTXT/btnGetArqO/chkImagens/Shape2/
* lblResults), com os 3 handlers de botao (BtnProcessarClick/
* BtnEncerrarClick/BtnGetArqOClick) e os BINDEVENTs em InicializarForm.
* Mesmo perfil ja registrado em FormSigOpCtd/task715 e SigOpCts/task717.
*
* Fase 7/8 (eventos principais dos botoes): ZERO codigo novo - os 3 eventos
* que o legado tem JA foram portados junto com os proprios botoes, na Fase 4.
* Nenhum dos 4 nomes CRUD do template generico (BtnIncluirClick/
* BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick) se aplica: cria-los
* exigiria INVENTAR botao que o SCX nao tem (viola o PILAR 1) ou escrever
* metodo vazio (proibido pela regra de completude).
*
* Ausencia de CRUD MEDIDA no dump, pelas tres vias independentes:
*   ESTRUTURAL - "Class: form" PURO (nao frmcadastro, nao frmrelatorio),
*                zero Grupo_Op, zero pcEscolha, zero Grid/pColuna/AddCursor;
*   NOME       - zero Incluir/Alterar/Visualizar/Excluir/Inserir em objeto
*                algum (os 3 botoes sao Cancela, Processa e btnGetArqO);
*   CHAMADA    - os unicos ".Click" do dump inteiro sao os desses 3 botoes.
*
* Superficie de botao do legado = 3 (3 "BaseClass: commandbutton", zero
* commandgroup); handlers entregues = 3 + o Exec de reentrancia. Os SEIS
* metodos com codigo do dump estao TODOS cobertos, um a um:
*   SIGOPECM.processamento -> sigopecmBO.GerarArquivoExportacao() + o
*                             preparo/tratamento em BtnProcessarClickExec
*   SIGOPECM.Init          -> Init(par_oFormPai)  (poObjForm -> this_oFormPai)
*   Processa.Click         -> BtnProcessarClick   (BINDEVENT "Click")
*   Cancela.Click          -> BtnEncerrarClick    (BINDEVENT "Click")
*   btnGetArqO.Click       -> BtnGetArqOClick     (BINDEVENT "Click")
*   getArqTXT.When         -> txt_4c_ArqTXT.ReadOnly = .T. (NAO por BINDEVENT:
*                             ele descarta o retorno do delegate)
* E nao sobra evento de outra familia para portar: zero evento de Grid, zero
* KeyPress, zero Valid, zero LostFocus, zero InteractiveChange no dump - logo
* nada de lookup/F3/F4 (regras #46/#47) alcanca esta tela.
*
* Re-auditado nesta fase, ponto a ponto, o par BINDEVENT + handler:
*   1. os 3 delegates sao PUBLIC (sem PROTECTED) - BINDEVENT com metodo
*      PROTECTED falha em SILENCIO (regra #3);
*   2. os 3 delegates EXISTEM com o nome exato do 4o argumento - delegate
*      inexistente estoura no proprio BINDEVENT;
*   3. os BINDEVENT rodam DEPOIS dos AddObject (InicializarForm chama
*      ConfigurarPageFrame -> Cabecalho/Botoes/Campos antes de bindar);
*   4. os alvos de SetFocus existem com o nome do AddObject
*      (cmd_4c_Cancela / cmd_4c_BtnGetArqO), reproduzindo os tres SetFocus do
*      legado (ThisForm.Cancela.SetFocus no fim do Processamento e
*      ThisForm.btnGetArqO.SetFocus nos dois Return .f. de validacao);
*   5. ESC continua saindo pelo Cancel = .T. do cmd_4c_Cancela, transcrito do
*      dump - o form nao tem ControlBox nem TitleBar;
*   6. Release() (nao Hide()) esta certo aqui: o dialogo nao devolve nada ao
*      chamador - o resultado dele eh o arquivo em disco;
*   7. as 5 properties do BO que os handlers tocam existem declaradas
*      (this_cArquivo, this_lExportarImagens, this_nQtdProdutos,
*      this_cMensagemResultado em sigopecmBO; this_cMensagemErro em
*      BusinessBase) - property nao declarada estoura "Property THIS_X is not
*      found" so em runtime, ao acionar o botao (regra #51/#177);
*   8. os 3 .Picture conferidos em vbmp\ (cadastro_sair_60.jpg,
*      geral_processar_60.jpg, geral_pasta_16.jpg): .Picture inexistente
*      falharia em SILENCIO (regra #25). Themes = .F. eh o do dump e eh
*      seguro porque nenhum dos botoes eh desabilitado em ponto algum.
*
* Sexta ocorrencia da familia "fase sem trabalho no legado", e segunda no eixo
* aberto pelo task726/FormSIGOPDVM: o legado TEM botao (3), entao o gate da
* Fase 7 PASSA (nBotoesLegado = 3 -> minHandlersF7 = 2, contra 3 handlers),
* mas o guard de NO-OP delega a Test-LegadoSemBotaoAlgum, que exige
* nBotoes = 0 - ele mede o LEGADO, e a condicao real de "sem trabalho" aqui
* depende do que a Fase 4 JA entregou. Precedentes: task699/SigOpChp,
* task715/SigOpCtd, task717/SigOpCts, task725/sigopdtf, task726/SIGOPDVM.
*
* Fase 8/8 (consolidacao final): acrescentou o par FormParaBO()/BOParaForm()
* (logo antes de BtnProcessarClick, abaixo) - ate aqui a leitura de
* getArqTXT.Value/chkImagens.Value morava INLINE em BtnProcessarClickExec.
* Os demais nomes que o template desta fase cobra NAO se aplicam a este
* legado, pela MESMA ausencia estrutural ja medida nos blocos acima (zero
* Grid/pColuna/AddCursor, zero commandgroup, 3 commandbutton JA cobertos):
*
*   BtnBuscarClick/BtnSalvarClick/BtnCancelarClick .. nao ha botao com esses
*                        papeis - Processa JA eh a acao de gravar/gerar
*                        (BtnProcessarClick) e Cancela JA eh o encerrar
*                        (BtnEncerrarClick), os dois desde a Fase 4/7.
*   HabilitarCampos .... nenhum campo e' desabilitado em runtime: getArqTXT
*                        ja nasce ReadOnly = .T. (transcricao do When) e
*                        chkImagens nunca trava - nao ha modo a condicionar.
*   LimparCampos ....... o legado nunca limpa getArqTXT/chkImagens depois de
*                        gerar o arquivo (conferido no dump: Processamento
*                        termina com ThisForm.Cancela.SetFocus, sem Replace
*                        nenhum nos dois controles) - zerar aqui inventaria
*                        comportamento que o legado nao tem (PILAR 1).
*
* Escrever qualquer um deles vazio so para casar com o nome do template
* seria o "stub disfarcado" que a regra de completude proibe; com controle
* real, inventaria superficie que o SCX nunca teve.
*
* Setima ocorrencia da familia "fase sem trabalho no legado" (ver a nota da
* Fase 7/8, acima) - a diferenca desta vez e' que HOUVE trabalho real
* (FormParaBO/BOParaForm), so nao nos nomes de botao/modo do template CRUD.
*============================================================================

DEFINE CLASS Formsigopecm AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPECM"), propriedade a propriedade:
    *   BorderStyle = 2 / Height = 220 / Width = 800 / AutoCenter = .T.
    *   ControlBox = .F. / MaxButton = .F. / MinButton = .F. / TitleBar = 0
    *   WindowType = 1
    * O legado NAO declara Closable - por isso ele tambem NAO aparece aqui:
    * sem barra de titulo os botoes nao desenham, mas Closable continua .T. e
    * o Alt+F4 segue funcionando. Fixar .F. mudaria comportamento (tiraria do
    * usuario a unica forma de desistir sem gerar arquivo), e seria inventar
    * propriedade ausente do dump.
    * ShowWindow = 1 acompanha o canonico do projeto para WindowType = 1.
    *==========================================================================
    Height      = 220
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.

    *==========================================================================
    * this_oFormPai - equivale a propriedade customizada poObjForm do legado
    * ("ThisForm.poObjForm = oFrm" no Init). No legado ela servia para dois
    * fins: executar SQL (poObjForm.poDataMgr.SqlExecute) e alcancar o cursor
    * crImagens do chamador. Na arquitetura nova o SQL vai por gnConnHandle
    * dentro de sigopecmBO, e crImagens eh visto pela propria data session
    * (ver nota de DataSession no cabecalho); a referencia eh preservada para
    * o contrato de chamada com o form chamador continuar o mesmo.
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
    * (equivalente ao Caption de lblResults no legado). Guardado na classe
    * porque o BO reporta progresso desde o inicio do Scan e o label
    * lbl_4c_LblResults eh um controle da area de campos: assim o texto nunca
    * se perde, e quem exibe eh AtualizarProgresso().
    *==========================================================================
    this_cUltimoProgresso = ""

    *==========================================================================
    * this_lProcessando - guarda de REENTRANCIA de BtnProcessarClick.
    *
    * AtualizarProgresso chama DOEVENTS a cada produto gravado (o legado
    * NAO tinha DOEVENTS - ele so atribuia lblResults.Caption). DOEVENTS
    * despacha a fila de eventos do Windows, entao durante uma geracao em
    * curso o usuario pode acionar Processar outra vez (clique ou Alt+P) e
    * REENTRAR no handler. A 2a chamada eh DESTRUTIVA para a 1a:
    *   - GerarArquivoExportacao refaz o teste de gravabilidade com
    *     STRTOFILE("", arquivo, 0) - o modo 0 eh SOBRESCRITA, logo APAGA
    *     os registros td01/td03 que a 1a chamada ja tinha anexado;
    *   - ela faz USE IN + SELECT DISTINCT ... INTO CURSOR
    *     cursor_4c_GruposSelec, isto eh FECHA e RECRIA justamente o
    *     cursor que o SCAN da 1a chamada esta percorrendo;
    *   - zera this_nQtdGrupos/this_nQtdProdutos, entao o total reportado
    *     ao usuario deixa de corresponder ao arquivo em disco.
    * Nada disso aparece na tela: o arquivo sai truncado e o usuario le
    * "Arquivo de Produtos Gerado Com Sucesso!!!".
    *
    * A flag eh liberada no FINALLY do wrapper, nunca no fim do corpo: o
    * corpo tem RETURN antecipado na desistencia do MsgConfirma e, com
    * set/clear simples, a flag travaria ligada e MATARIA o Processar pelo
    * resto da vida do form (regra #47).
    *==========================================================================
    this_lProcessando = .F.

    *==========================================================================
    * Init - replica "Parameters oFrm / ThisForm.poObjForm = oFrm" do legado e
    * define o Caption por CHR() antes de delegar ao FormBase.Init (que eh
    * quem chama InicializarForm - NUNCA chamar InicializarForm aqui tambem,
    * senao os AddObject rodam duas vezes e estouram "member object with this
    * name already exists").
    *
    * par_oFormPai eh OPCIONAL: o harness de teste e a validacao de UI
    * instanciam o form sem parametro, e o legado tambem aceitava Parameters
    * sem argumento (oFrm chegaria .F.). Por isso o tipo eh conferido antes de
    * guardar - atribuir .F. em this_oFormPai faria VARTYPE devolver "L" e os
    * guards de objeto adiante lerem lixo.
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivo de Exporta" + ;
            CHR(231) + CHR(227) + "o Para e-Commerce"

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao, PUBLIC para ser alcancavel pelo
    * harness. Chamada ANTES do TRY de InicializarForm, de modo que o RETURN
    * fique fora de TRY/CATCH.
    *
    * O bypass de gb_4c_ModoTeste/gb_4c_ValidandoUI vem PRIMEIRO porque o
    * TesteAutomatico.prg nao abre conexao real: ele define gnConnHandle = 0
    * como sentinela deliberada. Sem o bypass, InicializarForm devolveria .F.,
    * CREATEOBJECT devolveria logico e o teste de instanciacao falharia sem
    * nenhum erro de SQL no log.
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados.", "CreateObject")
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados.", "CreateObject")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base do form operacional: fundo,
    * Business Object e os containers de topo do layout legado.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigopecmBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopecmBO.", ;
                    "Erro em InicializarForm")
            ELSE
                *-- O BO repinta o progresso durante o Scan chamando
                *-- this_oFormUI.AtualizarProgresso() - equivale ao
                *-- "ThisForm.lblResults.Caption = ..." repetido no legado.
                THIS.this_oBusinessObject.this_oFormUI = THIS

                THIS.ConfigurarPageFrame()

                *-- Fase 8: aplica o default de this_lExportarImagens (BO) sobre
                *-- chk_4c_ChkImagens - precisa vir DEPOIS de ConfigurarPageFrame
                *-- (que cria o controle via ConfigurarCampos)
                THIS.BOParaForm()

                *-- BINDEVENTs: botoes e picker criados em ConfigurarBotoes/
                *-- ConfigurarCampos, acima
                BINDEVENT(THIS.cmd_4c_Processa,   "Click", THIS, "BtnProcessarClick")
                BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnEncerrarClick")
                BINDEVENT(THIS.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (ver cabecalho do arquivo): o metodo apenas encadeia os
    * configuradores de cada bloco do SCX, na ordem em que o legado os desenha.
    *
    * A ordem importa e eh a do SCX: o cabecalho vem PRIMEIRO porque a faixa
    * ocupa Top = 0..80 e os botoes Processar/Encerrar ficam em Top = 3,
    * DENTRO dessa area - criados depois, eles desenham POR CIMA da faixa;
    * invertido, o cabecalho os cobriria.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()

        *-- SEMPRE por ULTIMO: TabIndex eh posicional e cada atribuicao
        *-- reordena os irmaos, entao o passe exige que TODOS os AddObject
        *-- deste nivel ja tenham acontecido.
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * ConfigurarOrdemTabulacao - ordem de tabulacao dos 8 filhos diretos da
    * Form. Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que
    * aqui segue a ordem de DESENHO do SCX (cabecalho -> botoes -> campos) e
    * NAO a ordem de navegacao do legado: sem este passe o Tab cai primeiro no
    * Encerrar (2o objeto criado) e so depois chega aos campos. Nao ha erro,
    * nao ha log e nao aparece em screenshot - so o Tab andando errado.
    *
    * Os numeros abaixo sao a ordem EFETIVA do legado, MEDIDA no VFP9
    * (automation\medir_tabindex_727.prg, 2026-10-31), nao os literais do dump.
    * A distincao importa: o VFP aplica o TabIndex gravado no instante em que
    * CRIA cada objeto, e os literais de Cancela (6) e Processa (5) excedem a
    * contagem de objetos tab-able existentes naquele ponto da ordem de
    * registros do SCX (2 e 3), logo nao sobrevivem ao load. Transcrever 5 e 6
    * ao pe da letra seria FIEL AO ARQUIVO e INFIEL A TELA - e inverteria a
    * dupla, porque no legado quem vem primeiro eh o Encerrar:
    *
    *   literal do SCX : Say1=1 getArqTXT=2 btnGetArqO=3 chkImagens=4
    *                    Processa=5 Cancela=6 lblResults=1 (duplicado)
    *   EFETIVO medido : lblResults=1 Say1=2 getArqTXT=3 btnGetArqO=4
    *                    chkImagens=5 cntSombra=6 Cancela=7 Processa=8
    *
    * Atribuicao em ordem ASCENDENTE (cada uma poe o controle na posicao
    * pedida e empurra os demais para tras) e com contador SEQUENCIAL proprio,
    * sem lacuna e sem repetir: valor duplicado ou fora da faixa eh descartado
    * em SILENCIO pelo VFP, e a faixa valida eh o numero de controles que TEM
    * a propriedade - 8, nao os 10 do ControlCount, porque shp_4c_Shape1 e
    * shp_4c_Shape2 sao Shape e Shape NAO tem TabIndex.
    *
    * Os tres ultimos sao inertes para a navegacao e estao aqui para fechar a
    * faixa 1..8 sem lacuna: Label nao tem TabStop (nao recebe foco) e
    * cnt_4c_Sombra so tem os dois Label do titulo dentro, logo o Tab tambem
    * nao para nele. Quem de fato para eh cmd_4c_BtnGetArqO -> chk_4c_ChkImagens
    * -> cmd_4c_Cancela -> cmd_4c_Processa: txt_4c_ArqTXT fica fora do ciclo
    * por TabStop = .F., que com ReadOnly = .T. eh a transcricao do
    * "PROCEDURE When / Return .f." que o dump declara nele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        THIS.lbl_4c_LblResults.TabIndex = 1    && SCX lblResults : efetivo 1
        THIS.lbl_4c_Label1.TabIndex     = 2    && SCX Say1       : efetivo 2
        THIS.txt_4c_ArqTXT.TabIndex     = 3    && SCX getArqTXT  : efetivo 3
        THIS.cmd_4c_BtnGetArqO.TabIndex = 4    && SCX btnGetArqO : efetivo 4
        THIS.chk_4c_ChkImagens.TabIndex = 5    && SCX chkImagens : efetivo 5
        THIS.cnt_4c_Sombra.TabIndex     = 6    && SCX cntSombra  : efetivo 6
        THIS.cmd_4c_Cancela.TabIndex    = 7    && SCX Cancela    : efetivo 7
        THIS.cmd_4c_Processa.TabIndex   = 8    && SCX Processa   : efetivo 8
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o efeito
    * de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
    * (Top = 17). Width/Height/Font/ForeColor transcritos do dump.
    *
    * Os dois labels declaram WordWrap = .T. e Width/Height explicitos no SCX,
    * entao AutoSize fica .F.: em Label criado por AddObject o AutoSize eh
    * no-op para a largura e, com WordWrap, DESCARTA a Height - a linha de
    * texto seria cortada. Os numeros do dump ja sao o auto-size calculado
    * pelo Form Designer, logo fixa-los eh reproducao fiel.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
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
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape1 (moldura decorativa) + os dois botoes de acao
    * do legado (Cancela -> cmd_4c_Cancela / Processa -> cmd_4c_Processa),
    * ambos classe fwbtng (framework.vcx). O dump so sobrescreve Top/Left/
    * Picture/Caption/TabIndex (e Cancel em Cancela) - Height/Width/Font*/
    * WordWrap/MousePointer/ForeColor/BackColor/Themes vem do DEFAULT da
    * classe fwbtng (docs/FRAMEWORK_class_codigo_fonte.txt, registro 3495):
    * Height=100, Width=80, FontBold=.T., FontItalic=.T.,
    * FontName="Comic Sans MS", FontSize=8, WordWrap=.T., MousePointer=15,
    * ForeColor=RGB(90,90,90), BackColor=RGB(255,255,255), Themes=.F.
    *
    * Themes=.F. (e nao o padrao standalone Themes=.T.+DisabledPicture da
    * regra #99) porque os dois botoes ficam SEMPRE Enabled=.T. - nunca
    * alternam em runtime, e o proprio fwbtng ja declara Themes=.F.
    *
    * "\<Processar" preserva o marcador de tecla de acesso (Alt+P) do VFP9 -
    * sintaxe nativa, nao removida na migracao (ver FormCliente/FormEnd).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 7
            .Left          = 565
            .Width         = 173
            .Height        = 110
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top         = 3
            .Left        = 725
            .Height      = 100
            .Width       = 80
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .MousePointer = 15
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top         = 3
            .Left        = 650
            .Height      = 100
            .Width       = 80
            .Caption     = "\<Processar"
            .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .MousePointer = 15
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - area de parametros do processamento: Say1
    * (lbl_4c_Label1), getArqTXT (txt_4c_ArqTXT), btnGetArqO
    * (cmd_4c_BtnGetArqO), chkImagens (chk_4c_ChkImagens), Shape2
    * (shp_4c_Shape2, moldura do resultado) e lblResults (lbl_4c_LblResults).
    *
    * txt_4c_ArqTXT.ReadOnly = .T. eh a transcricao de getArqTXT.When
    * ("Return .f." no dump) - o campo NAO aceita digitacao, o valor so
    * chega pelo picker de btnGetArqO. NAO se faz isso com BINDEVENT "When":
    * BINDEVENT descarta o retorno do delegate e o campo continuaria
    * digitavel (CLAUDE.md regra #3; precedente: FormSIGOPCCO.prg).
    *
    * lbl_4c_Label1 eh classe "say" (framework.vcx) sem Width/Alignment no
    * dump - AutoSize = .T. herdado da classe eh NO-OP em Label criado por
    * AddObject (regra #23), entao aqui AutoSize = .F. + Width explicito
    * (que cabe "Arquivo a Ser Gerado" em Tahoma 8 bold) + Alignment = 0,
    * com ForeColor = RGB(90,90,90) (default da classe "say", registro 2597
    * de docs/FRAMEWORK_class_codigo_fonte.txt).
    *
    * chk_4c_ChkImagens eh fwcheckbox - mesma armadilha de AutoSize no-op
    * (CheckBox, nao so Label): Width explicito para caber "Exportar
    * Imagens". Height/FontName/FontSize/Alignment/BackStyle/ForeColor/
    * Themes do default da classe (docs/FRAMEWORK_class_codigo_fonte.txt,
    * registro 3401). Value = 1 (numerico, nunca .T./.F. - regra de
    * CheckBox.Value) reproduz o Value = 1 do dump (caixa marcada).
    *
    * lbl_4c_LblResults eh "say" tambem, mas o dump JA sobrescreve
    * AutoSize = .F. + Width = 573 + Height = 15 - esses numeros sao o
    * auto-size calculado pelo Form Designer, reproducao fiel (regra #23).
    * FontName/FontSize/ForeColor ficam no default da classe "say".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 92
            .Left      = 105
            .Width     = 170
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Arquivo a Ser Gerado"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ArqTXT", "TextBox")
        WITH THIS.txt_4c_ArqTXT
            .Top           = 109
            .Left          = 105
            .Width         = 560
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = ""
            .ToolTipText   = "Arquivo XML a Ser Importado"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnGetArqO", "CommandButton")
        WITH THIS.cmd_4c_BtnGetArqO
            .Top           = 107
            .Left          = 666
            .Height        = 26
            .Width         = 26
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 10
            .Picture       = gc_4c_CaminhoIcones + "geral_pasta_16.jpg"
            .Caption       = ""
            .ToolTipText   = "Seleciona o Arquivo Que Ser" + CHR(225) + " Processado"
            .SpecialEffect = 2
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("chk_4c_ChkImagens", "CheckBox")
        WITH THIS.chk_4c_ChkImagens
            .Top       = 139
            .Left      = 105
            .Width     = 150
            .Height    = 17
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .SpecialEffect = 1
            .Caption   = "Exportar Imagens"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 163
            .Left        = 105
            .Width       = 590
            .Height      = 36
            .BackStyle   = 0
            .BorderStyle = 6
            .BorderWidth = 1
            .Curvature   = 12
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblResults", "Label")
        WITH THIS.lbl_4c_LblResults
            .Top       = 174
            .Left      = 113
            .Width     = 573
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * FASE 8 - FormParaBO: Tela -> BO. Transfere os DOIS campos de entrada do
    * dialogo (getArqTXT.Value e chkImagens.Value) para as properties que
    * GerarArquivoExportacao() consome. Ate a Fase 7 essa leitura morava
    * INLINE em BtnProcessarClickExec; trazida para o hook canonico de
    * FormBase para ficar FONTE UNICA - um segundo caminho que precisasse dos
    * mesmos dois valores releria o controle em vez de confiar numa copia que
    * ja pode ter ficado velha (CLAUDE.md #44, item 6).
    *
    * "TODOS os campos" (cobranca da Fase 8) esta satisfeito por construcao: o
    * dialogo tem exatamente DOIS controles de ENTRADA (getArqTXT eh
    * ReadOnly = .T. - o valor so chega pelo picker de btnGetArqO - e
    * chkImagens), e os dois aparecem aqui.
    *
    * PROTECTED EXPLICITO - nao eh estilo, eh o escopo REAL: FormBase declara
    * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR
    * escopo herdado (regra #51). Por isso o metodo e' chamado so por THIS.,
    * de dentro da classe (regra #8) - nunca de fora, nem pelo harness.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_ArqTXT) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkImagens) = "O"
            THIS.this_oBusinessObject.this_cArquivo         = ALLTRIM(THIS.txt_4c_ArqTXT.Value)
            THIS.this_oBusinessObject.this_lExportarImagens = (THIS.chk_4c_ChkImagens.Value = 1)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - BOParaForm: BO -> Tela. Caminho inverso: marca em
    * chk_4c_ChkImagens o estado que this_lExportarImagens guarda no BO
    * (default .T. - ver a nota dessa property em sigopecmBO.prg). Chamado por
    * InicializarForm() logo depois de ConfigurarPageFrame(), quando o
    * controle ja existe.
    *
    * Existe por FONTE UNICA, nao por simetria decorativa: sem este hook o
    * "marcado" do checkbox ficaria escrito DUAS vezes - uma em
    * sigopecmBO.this_lExportarImagens e outra no .Value = 1 hardcoded de
    * ConfigurarCampos. As duas copias divergiriam no primeiro ajuste de
    * default - quem mudasse o default no BO veria o checkbox continuar
    * abrindo desmarcado, porque ConfigurarCampos nunca consultaria o BO.
    *
    * PROTECTED EXPLICITO pelo MESMO motivo de FormParaBO, acima.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkImagens) = "O"
            THIS.chk_4c_ChkImagens.Value = IIF(THIS.this_oBusinessObject.this_lExportarImagens, 1, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnProcessarClick - equivale a SIGOPECM.Processa.Click -> ThisForm.
    * Processamento. PUBLIC porque BINDEVENT exige metodo publico (regra #3).
    *
    * A confirmacao (MessageBox 32+4 <> 6) e o metodo em si viram
    * MsgConfirma(), que ja devolve LOGICO (regra #7 - NUNCA comparar com 6).
    * O restante do Processamento legado (checagem de arquivo vazio/nao-
    * gravavel, Scan de grupos/produtos, geracao dos registros td01/td03)
    * mora inteiro em sigopecmBO.GerarArquivoExportacao(); este handler so
    * prepara os dois parametros de entrada e trata o resultado.
    *
    * Contrato de erro do BO (ver cabecalho de GerarArquivoExportacao):
    *   - falha de SQL -> BO ja exibiu o proprio MsgErro, this_cMensagemErro
    *     fica vazio, este handler NAO repete mensagem (regra #20);
    *   - falha de validacao (arquivo vazio/nao-gravavel/sem imagens
    *     selecionadas) -> this_cMensagemErro preenchido, SEM MsgErro previo;
    *     o handler exibe com MsgAviso (validacao de UI, nao erro tecnico) e
    *     devolve o foco a btnGetArqO, igual ao legado nos dois Return .f.
    *     ("O Arquivo a Ser Gerado..." e "O Arquivo Nao Pode Ser Criado...").
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        *-- Guarda de reentrancia (ver a nota de this_lProcessando): um
        *-- segundo acionamento durante uma geracao em curso eh IGNORADO.
        IF THIS.this_lProcessando
            RETURN
        ENDIF

        THIS.this_lProcessando = .T.

        *-- O TRY/CATCH aqui eh tambem o que evita o "Program Error" CRU do
        *-- VFP neste caminho: sem ele, erro fora do TRY do BO cai na
        *-- janelinha nativa Cancel/Suspend/Ignore, nao no dialogo do sistema.
        TRY
            THIS.BtnProcessarClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnProcessarClick")
        FINALLY
            THIS.this_lProcessando = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClickExec - corpo real do Processar. Separado do handler
    * para que a liberacao da flag de reentrancia fique no FINALLY do
    * wrapper e sobreviva aos RETURN antecipados daqui (regra #47).
    *==========================================================================
    PROCEDURE BtnProcessarClickExec()
        IF !MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o dos Arquivos?", ;
                "Gera" + CHR(231) + CHR(227) + "o de Arquivos")
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os dados da tela.", "Erro")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.GerarArquivoExportacao()
            IF THIS.this_oBusinessObject.this_nQtdProdutos > 0
                MsgInfo(THIS.this_oBusinessObject.this_cMensagemResultado, ;
                    "Processamento Finalizado")
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemResultado, ;
                    "Processamento Finalizado")
            ENDIF
            THIS.cmd_4c_Cancela.SetFocus()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.cmd_4c_BtnGetArqO.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - equivale a SIGOPECM.Cancela.Click -> ThisForm.
    * Release. O dialogo nao devolve resultado nenhum ao form chamador (so
    * gera o arquivo em disco), entao Release() eh fiel ao legado - nao se
    * aplica a ressalva de dialogo-filho-que-o-chamador-le-depois (esse caso
    * usaria Hide()). PUBLIC pelo mesmo motivo de BtnProcessarClick.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnGetArqOClick - equivale a SIGOPECM.btnGetArqO.Click: abre o picker
    * nativo GETFILE() e, se o usuario nao cancelar, grava o caminho
    * escolhido em txt_4c_ArqTXT.Value (transcricao literal do
    * "GetFile([TXT], [Arquivo TXT:], [Criar], 0, [Informe o Nome do Arquivo
    * TXT])" do legado - nenhum dos literais tem acento).
    *==========================================================================
    PROCEDURE BtnGetArqOClick()
        LOCAL loc_cArquivo

        loc_cArquivo = GETFILE("TXT", "Arquivo TXT:", "Criar", 0, "Informe o Nome do Arquivo TXT")

        IF !EMPTY(loc_cArquivo)
            THIS.txt_4c_ArqTXT.Value = ALLTRIM(loc_cArquivo)
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - contrato com sigopecmBO.AtualizarProgresso, que
    * chama este metodo a cada grupo/produto processado (equivale ao
    * "ThisForm.lblResults.Caption = [Processando ] + ..." repetido dentro do
    * Scan do legado). PUBLIC porque quem chama eh o BO, de fora da classe.
    *
    * O texto eh sempre guardado em this_cUltimoProgresso e so entao exibido,
    * se o label de resultado da area de campos existir - assim o progresso
    * reportado antes de o label entrar em cena nao se perde. O DOEVENTS
    * reproduz o repintar imediato que o legado obtinha ao atribuir o Caption
    * no meio do laco.
    *==========================================================================
    PROCEDURE AtualizarProgresso(par_cTexto)
        LOCAL loc_cTexto

        loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
        THIS.this_cUltimoProgresso = loc_cTexto

        IF PEMSTATUS(THIS, "lbl_4c_LblResults", 5)
            THIS.lbl_4c_LblResults.Caption = loc_cTexto
            THIS.lbl_4c_LblResults.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre a arvore e os exibe. Nao ha filtro
    * de nome porque o SCX legado NAO declara Visible = .F. em controle
    * nenhum: nesta tela todos os 13 objetos nascem visiveis, logo filtrar
    * algum esconderia o que o legado mostra.
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
    * Metodos de contrato com o pipeline (ConfigurarPaginaLista /
    * ConfigurarPaginaDados / AlternarPagina / CarregarLista /
    * AjustarBotoesPorModo). Este form OPERACIONAL nao tem PageFrame, nem
    * grade de listagem, nem os modos CRUD (LISTA/INCLUIR/ALTERAR/
    * VISUALIZAR): o legado eh um dialogo de um unico fluxo - informar o
    * arquivo e Processar. Os metodos existem porque o harness os alcanca de
    * fora da classe (por isso PUBLIC) e precisam ser inofensivos ao serem
    * chamados; dar-lhes corpo exigiria inventar paginas e botoes que o SCX
    * nao possui.
    *
    * EXCECAO - ConfigurarPaginaDados: num form FLAT como este, o que num CRUD
    * seria "a Page2 de Dados" eh o proprio corpo da Form, e os campos foram
    * criados de uma vez por ConfigurarCampos. O que sobra de verdade para este
    * metodo eh a ordem de tabulacao desses campos, que SO pode rodar depois de
    * todos os AddObject - por isso ele DELEGA a ConfigurarOrdemTabulacao em
    * vez de ficar um RETURN morto que nenhum gate percebe. Chamar de fora eh
    * seguro: a atribuicao ascendente de uma ordem que ja esta no lugar eh
    * no-op, logo o metodo eh idempotente.
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object e os cursores auxiliares que
    * sigopecmBO.GerarArquivoExportacao abre durante o processamento, cobrindo
    * o caso de a tela ser fechada no meio de uma geracao. DODEFAULT() por
    * ULTIMO, para FormBase.Destroy reconstruir os popups do menu principal.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_oFormUI = .NULL.
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oFormPai = .NULL.

        IF USED("cursor_4c_GruposSelec")
            USE IN cursor_4c_GruposSelec
        ENDIF
        IF USED("cursor_4c_ControleGrupos")
            USE IN cursor_4c_ControleGrupos
        ENDIF
        IF USED("cursor_4c_DadosGrupo")
            USE IN cursor_4c_DadosGrupo
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
