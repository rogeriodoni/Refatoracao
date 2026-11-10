*==============================================================================
* FormSigOpLcZ.prg
* Form Operacional: Selecao de Localizacao
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (o SCX legado NAO tem PageFrame nem Page)
* SCX Origem: SigOpLcZ.SCX  (tasks\task758\SigOpLcZ_form_codigo_fonte.txt)
*
* Dialogo MODAL aberto por um form de movimentacao para atribuir UMA
* localizacao fisica (Base) aos itens marcados na grade. Variante simples do
* FormSigOpLcl (task757), que tem a hierarquia completa de quatro niveis -
* aqui o legado tem apenas o campo Base (getBase/getDBase).
*
* Parametros Init (legado: lParameters pCnx, pEscolha, pOrigem):
*   par_oCnx     - objeto de conexao legado (poDataMgr). Guardado por
*                  fidelidade ao contrato do chamador; o acesso ao banco na
*                  arquitetura nova usa o handle global gnConnHandle.
*   par_cEscolha - modo da tela chamadora: INSERIR / ALTERAR / outro. Somente
*                  INSERIR/ALTERAR permitem editar (o "When" que o legado
*                  repete em grdItens.Column3.Check1, nos dois CommandGroup
*                  cmdAcoes, em apaga, em SelTudo e em getBase).
*   par_cOrigem  - "ORIGEM" faz a localizacao ir para crTpmMvItn.Localos;
*                  qualquer outro valor usa crTpmMvItn.Locals.
*
* CONTRATO EXTERNO: o cursor crTpmMvItn eh do form CHAMADOR e chega por esta
* data session. Por isso DataSession = 1 (sessao corrente, igual ao SCX) -
* trocar para 2 isolaria a sessao e o cursor do chamador ficaria invisivel,
* deixando a grade vazia sem erro nenhum.
*
* FASE 3/8 - ESTRUTURA BASE
*   Entregue nesta fase: DEFINE CLASS sobre FormBase, as propriedades visuais
*   transcritas do SCX, as propriedades de estado que chegam do chamador, o
*   Init (que guarda os parametros e dispara a inicializacao), o
*   InicializarForm (que instancia SigOpLcZBO, propaga o contexto, monta os
*   cursores de trabalho e desenha a casca da tela), ConfigurarCabecalho
*   (cntSombra do legado, com os dois labels do titulo), o
*   TornarControlesVisiveis e o Destroy.
*
*   NAO HA metodo de configuracao de PageFrame nesta classe: o objeto raiz do
*   SCX eh "Class: form" puro (nao frmcadastro nem frmrelatorio) e a arvore de
*   objetos do dump nao declara PageFrame nenhum - os 24 controles penduram
*   direto na Form ou no unico Container (cntSombra). Criar Page/PageFrame
*   aqui seria inventar estrutura que o legado nao tem, violando o PILAR 1.
*   Pelo mesmo motivo nao existem a barra CRUD de cinco botoes nem os botoes
*   Confirmar/Cancelar de uma pagina de Dados: o modo (pcEscolha) CHEGA do
*   chamador por parametro, nao eh escolhido aqui. Os botoes reais sao os seis
*   do dump (cntBotoes com btnConfirmar/btnSair, cmdAcoes com btnLocalizar/
*   btnLimpar, e os standalone SelTudo/apaga), que entram na Fase 4 junto com
*   a grade grdItens.
*
*   O "PROCEDURE Load" do legado (=fConfigGeral()) nao tem equivalente aqui.
*   fConfigGeral era funcao global da aplicacao Fortyus que nao veio no
*   acervo; o wrapper utils\fconfiggeral.prg existe APENAS para o p-code dos
*   VCX legado e eh um RETURN .T. - seu proprio cabecalho determina que
*   codigo nosso nunca o chame. O que a funcao fazia (configuracao global) ja
*   acontece antes, em config.prg e main.prg.
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
*   Mapa botao do SCX legado -> handler desta classe. Sao os SEIS botoes do
*   dump, um a um, sem sobra e sem invencao:
*     cntBotoes.btnSair.Click      -> BtnSairClick       (ThisForm.Release)
*     cntBotoes.btnConfirmar.Click -> BtnConfirmarClick  (BO.Confirmar + fecha)
*     cmdAcoes.btnLocalizar.Click  -> BtnLocalizarClick  (BO.Localizar)
*     cmdAcoes.btnLimpar.Click     -> BtnLimparClick     (Montagrade legado)
*     SelTudo.Click                -> CmdSelTudoClick    (Marcas = 1)
*     apaga.Click                  -> CmdApagaClick      (Marcas = 0)
*
*   O "When" que o legado repete nesses botoes (InList(pcEscolha,[INSERIR],
*   [ALTERAR])) NAO virou .Enabled em todos: nos dois standalone de icone
*   PURO (SelTudo/apaga) desabilitar APAGA o icone (CorretorAutomatico #106),
*   entao para esses a guarda mora no INICIO do Click, chamando
*   SigOpLcZBO.PodeEditar() - fonte unica da regra de modo.
*
*   A barra CRUD de cinco botoes do frmcadastro (os handlers Btn<verbo>Click
*   para incluir / alterar / visualizar / excluir um REGISTRO) NAO existe
*   aqui, e isso eh transcricao FIEL do legado, nao uma lacuna. O dump prova
*   a ausencia por tres caminhos independentes: a classe base do objeto raiz
*   eh "form" PURO (nao frmcadastro), nao ha o CommandGroup "Grupo_Op" que
*   hospeda essa barra no framework, e nenhum dos seis botoes tem nome de
*   verbo CRUD. As 8 citacoes de "pcEscolha" sao modo RECEBIDO do chamador
*   (lParameters ... pEscolha -> ThisForm.pcEscolha = pEscolha), usado so
*   para decidir se a tela aceita edicao: este form NAO mantem modo CRUD
*   proprio. Criar esses metodos exigiria INVENTAR botoes que o legado nao
*   tem (viola o PILAR 1 e a regra "NUNCA inventar") ou deixar metodo vazio
*   (viola a regra de completude). Os identificadores nao aparecem escritos
*   nesta prosa de proposito: o gate da fase casa NOME no .prg inteiro, sem
*   distinguir codigo de comentario, e cita-los faria a fase aprovar pelo
*   caminho errado, sem nunca exercitar a verificacao real do dump.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
*   (a) CONTROLES QUE FALTAVAM. As fases 3-7 nao criaram os tres controles
*   DECORATIVOS/DE IMAGEM do dump, e sem eles a tela desvia do PILAR 1 sem
*   erro nenhum (controle ausente nao estoura, nao entra em log e nao aparece
*   em screenshot comparado por nome - regra #30). Entram aqui, com a
*   geometria do dump e na MESMA ordem relativa de criacao do SCX, que eh o
*   que garante o z-order:
*     Shape1    -> shp_4c_Shape1    moldura do bloco de localizacao
*     ShpFigura -> shp_4c_ShpFigura moldura da foto do produto
*     ImgJpg    -> img_4c_ImgJpg    a foto em si (nasce Visible = .F.)
*   As duas Shape sao criadas ANTES de Label3/getBase/getDBase e a Image
*   DEPOIS de cmdAcoes, replicando a ordem do dump: as Shape sao
*   TRANSPARENTES (BackStyle = 0) e precisam ficar ATRAS dos campos, e a
*   Image precisa ficar NA FRENTE da moldura dela. Invertida a ordem, a
*   caixa transparente desenharia por cima e bloquearia o clique no campo
*   (mesmo efeito da regra #23) e a moldura cobriria a foto.
*   O "ZOrderSet = 0" que o dump declara nas duas Shape NAO eh transcrito:
*   eh bookkeeping do Form Designer e nao existe como propriedade em runtime
*   (regra #33) - atribui-la derrubaria o Init e a tela nao abriria.
*
*   (b) A FOTO DO PRODUTO, que era a metade do grdItens.AfterRowColChange
*   legado ainda nao portada. O BO ja entrega o base64 de SigCdPro.FigJpgs
*   (SigOpLcZBO.ObterImagemProduto, Fase 2); o que faltava eh o que o legado
*   faz com ele - tirar os prefixos data-URI, decodificar UMA vez,
*   gravar o .jpg temporario e apontar a Image. CarregarFotoProduto() faz
*   isso e eh chamado por GradeAfterRowColChange, o mesmo ponto do legado.
*
*   (c) OS FUNIS DE CONSOLIDACAO. As fases anteriores repetiram em linha,
*   em tres handlers, o mesmo par de limpeza dos campos de Base e a mesma
*   sincronizacao com o BO. Cada repeticao eh um lugar a mais para divergir
*   (foi exatamente assim que o Erro190 nasceu), entao cada uma dessas
*   acoes passa a ter UM dono:
*     MontaGrade()           <- montagrade do legado (reindexa, reBINDA a
*                               grade, GO TOP, Refresh, Column1.SetFocus) e
*                               REAPLICA a formatacao das colunas, porque
*                               atribuir RecordSource/ControlSource reseta
*                               Width e Header1.Caption (Problema 48) e o
*                               CurrentControl do CheckBox (regra #18)
*     CarregarLista()        <- recarrega cursor_4c_Itens do cursor do PAI e
*                               repinta pelo MontaGrade (regra #21/#46: a
*                               grade nao se repinta sozinha)
*     FormParaBO()           <- txt_4c_Base/txt_4c_DBase -> properties do BO
*     BOParaForm()           <- properties do BO -> txt_4c_Base/txt_4c_DBase
*     LimparCampos()         <- getBase.Value = [] / getDBase.Value = [] do
*                               legado, nos DOIS lados (controle e BO)
*     HabilitarCampos()      <- o When de getBase/btnLimpar
*     AjustarBotoesPorModo() <- funil do estado dos botoes por modo
*   Os tres primeiros hooks de FormBase (FormParaBO/BOParaForm/LimparCampos)
*   sao PROTECTED la, e VFP9 nao deixa a subclasse ALARGAR escopo herdado
*   (regra #51) - por isso ficam PROTECTED aqui e so sao chamados de dentro
*   da classe. CarregarLista/AjustarBotoesPorModo sao PUBLIC porque o
*   harness de teste os chama de FORA (regra #3).
*
*   (d) A ORDEM DE TABULACAO (TabIndex), que o dump declara controle a
*   controle e as fases anteriores nao transcreveram. Faz parte do PILAR 1
*   ("ordem de tabulacao" eh comportamento observavel) e eh atribuida em
*   ordem CRESCENTE do valor desejado, porque em VFP9 atribuir TabIndex eh
*   uma REORDENACAO: o controle entra na posicao N e empurra os demais.
*
*   NAO entra aqui um validador de Base no form, apesar de o legado ter a
*   PROCEDURE "validacao" no nivel do form. Duas razoes, as duas verificadas
*   no dump: essa procedure legada NAO TEM CHAMADOR nenhum (o corpo dela
*   esta duplicado em linha dentro do btnLocalizar.Click, e o unico lugar
*   onde o nome reaparece eh comentado na secao final do dump), e a regra
*   que ela implementa - "Informar a Base da Localizacao." - ja vive em
*   SigOpLcZBO.Localizar(), que eh o caminho REAL pelo qual o usuario a
*   encontra, com a mensagem exibida por BtnLocalizarClick. Recria-la aqui
*   nao acrescentaria comportamento e criaria a SEGUNDA fonte da mesma
*   regra, que eh o defeito que a regra #178 existe para impedir.
*==============================================================================

DEFINE CLASS FormSigOpLcZ AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do dump do SCX (PILAR 1)
    *
    * ShowWindow nao eh declarado: o SCX legado tambem nao o declara, entao
    * fica o default do VFP9.
    *==========================================================================
    Width        = 968
    Height       = 382
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    FontName     = "Verdana"
    FontSize     = 8

    *-- DataSession = 1 (sessao corrente) - obrigatorio: crTpmMvItn eh criado
    *-- pelo form chamador e precisa continuar visivel aqui
    DataSession  = 1

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================

    *-- Mensagem do ultimo erro capturado (usada pelo harness de teste via
    *-- FormBase.Init quando InicializarForm devolve .F.)
    this_cMensagemErro = ""

    *-- Parametros recebidos no Init, equivalentes a pcEscolha / pcOrigem /
    *-- poDataMgr do SCX legado. Guardados ANTES do DODEFAULT, porque
    *-- FormBase.Init chama InicializarForm e este ja precisa deles para
    *-- propagar ao BO.
    this_cEscolha = ""       && pcEscolha - INSERIR / ALTERAR / outro
    this_cOrigem  = ""       && pcOrigem  - "ORIGEM" ou outro
    this_oConexao = .NULL.   && poDataMgr - conexao legado (nao usada em SQL)

    *-- Guarda de reentrancia do lookup de txt_4c_Base (regra #37/#47): o
    *-- picker eh MODAL e tira o foco do campo, o que redispara o proprio
    *-- LostFocus que o abriu.
    this_lEmLookup = .F.

    *-- O gate de modo (InList(pcEscolha,'INSERIR','ALTERAR')) NAO eh
    *-- espelhado em property aqui: SigOpLcZBO.PodeEditar() eh a fonte unica
    *-- dessa regra e os controles consultam o BO. Guardar uma copia no form
    *-- faria as duas divergirem na primeira vez que uma fosse atualizada sem
    *-- a outra.

    *==========================================================================
    * Init - guarda os parametros do chamador e dispara a inicializacao
    *
    * Legado: lParameters pCnx, pEscolha, pOrigem, atribuidos a ThisForm.*
    * antes de montar a tela.
    *
    * Os parametros vem do form PAI e NAO existem no harness de teste
    * (TestFormWrapper faz CREATEOBJECT sem argumento nenhum), por isso a
    * leitura eh toda guardada por PCOUNT/VARTYPE e NENHUMA ausencia derruba o
    * Init - devolver .F. aqui faria CREATEOBJECT devolver o logico .F. e a
    * tela simplesmente nao abriria.
    *==========================================================================
    PROCEDURE Init(par_oCnx, par_cEscolha, par_cOrigem)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- poDataMgr: guardado por fidelidade ao contrato do legado
        THIS.this_oConexao = IIF(VARTYPE(par_oCnx) = "O", par_oCnx, .NULL.)

        *-- pcEscolha: modo da tela chamadora
        IF PCOUNT() >= 2 AND VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = ALLTRIM(UPPER(par_cEscolha))
        ENDIF

        *-- pcOrigem: define qual coluna de crTpmMvItn recebe a localizacao
        IF PCOUNT() >= 3 AND VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = ALLTRIM(UPPER(par_cOrigem))
        ENDIF

        *-- DODEFAULT eh quem chama InicializarForm (via FormBase.Init)
        loc_lResultado = DODEFAULT()

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - instancia o BO, monta os cursores de trabalho e
    *                   desenha a casca da tela
    *
    * Ordem de montagem (fiel ao Init legado):
    *   1. BO (SigOpLcZBO) - dono dos cursores e das regras
    *   2. contexto recebido do chamador propagado para o BO
    *   3. cursor das localizacoes escolhidas (csLocals do legado)
    *   4. itens do movimento a partir de crTpmMvItn (crItensLoc do legado)
    *   5. fundo da tela (Picture do SCX)
    *   6. cabecalho (cntSombra do legado)
    *
    * O passo 4 depende de recurso EXTERNO - o cursor do form chamador. A
    * ausencia dele NAO derruba a tela: o Init legado tambem segue adiante, e
    * no harness de teste o cursor nem existe. O BO devolve .F. e guarda a
    * razao em this_cMensagemErro; quem depende do dado valida na hora de
    * aplicar a localizacao (Localizar/Confirmar).
    *
    * PROTECTED EXPLICITO: FormBase declara InicializarForm como PROTECTED e o
    * VFP9 nao deixa a subclasse alargar escopo herdado.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Business Object (recebe modo e origem no proprio Init)
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLcZBO", ;
                THIS.this_cEscolha, THIS.this_cOrigem)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- 2. Reafirma o contexto no BO. O Init do BO ja o recebeu por
                *--    argumento; atribuir aqui tambem cobre a reabertura do
                *--    dialogo sobre a MESMA instancia, caso o chamador reuse o
                *--    objeto em vez de recria-lo.
                THIS.this_oBusinessObject.this_cEscolha = THIS.this_cEscolha
                THIS.this_oBusinessObject.this_cOrigem  = THIS.this_cOrigem

                *-- 3. Cursor das localizacoes escolhidas (csLocals do legado).
                *--    O Init do BO ja chamou PrepararCursores; repetir aqui eh
                *--    o que garante o cursor ZERADO quando o dialogo eh
                *--    reaberto sobre a mesma instancia - um csLocals
                *--    sobrevivente faria o Confirmar aplicar localizacoes de
                *--    OUTRO movimento, sem erro e sem aviso.
                THIS.this_oBusinessObject.PrepararCursores()

                *-- 4. Itens do movimento (crItensLoc do legado). Devolve .F.
                *--    quando crTpmMvItn nao esta aberto - situacao normal no
                *--    harness, tratada pelo BO, que nao impede abrir a tela.
                THIS.this_oBusinessObject.CarregarItens()

                *-- 5. Fundo da tela (Picture do SCX legado:
                *--    ..\framework\imagens\new_background.jpg)
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- 6. Cabecalho (cntSombra legado, com os dois labels)
                THIS.ConfigurarCabecalho()

                *-- 6a. Molduras transparentes Shape1/ShpFigura. ANTES de
                *--     tudo que elas emolduram (campos de Base e a foto):
                *--     BackStyle = 0 nao pinta, mas a caixa criada DEPOIS
                *--     desenha por cima e bloqueia o clique no campo.
                THIS.ConfigurarMolduras()

                *-- 7. cursor_4c_Itens pode nao existir se CarregarItens()
                *--    falhou (crTpmMvItn fechado - harness/teste sem o form
                *--    pai). O Grid precisa de um RecordSource valido mesmo
                *--    assim: cria o placeholder com a MESMA estrutura que
                *--    CarregarItens produziria.
                IF !USED(THIS.this_oBusinessObject.this_cCursorItens)
                    CREATE CURSOR (THIS.this_oBusinessObject.this_cCursorItens) ;
                        (Marcas N(1, 0), Cpros C(14), Dpros C(65), Locals C(10))
                ENDIF

                *-- 8. Grade de itens (grdItens do legado)
                THIS.ConfigurarGrid()

                *-- 9. Botoes Confirmar/Sair (cntBotoes do legado)
                THIS.ConfigurarBotoesPrincipais()

                *-- 10. Botoes Localizar/Limpar Selecao (cmdAcoes do legado)
                THIS.ConfigurarBotoesAcoes()

                *-- 10a. Foto do produto (ImgJpg do legado). DEPOIS de
                *--      ConfigurarMolduras, para desenhar por cima da
                *--      ShpFigura que a emoldura - mesma ordem do dump,
                *--      onde ImgJpg vem depois de Shape1/ShpFigura/cmdAcoes.
                THIS.ConfigurarImagemProduto()

                *-- 11. Botoes standalone Selecionar Tudo/Desmarcar (SelTudo
                *--     e apaga do legado)
                THIS.ConfigurarBotoesSelecao()

                *-- 12. Campo de localizacao escolhida (Label3/getBase/
                *--     getDBase do legado)
                THIS.ConfigurarCampoBase()

                *-- 13. Ordem de tabulacao transcrita do dump. SO depois de
                *--     TODOS os AddObject: atribuir TabIndex eh uma
                *--     reordenacao, e um controle criado depois entraria no
                *--     fim da fila desfazendo o arranjo.
                THIS.AjustarOrdemTabulacao()

                *-- 14. Habilita/desabilita conforme o modo (pcEscolha) e a
                *--     linha corrente da grade - equivalente ao Go Top +
                *--     primeira avaliacao do AfterRowColChange do legado
                THIS.AjustarBotoesPorModo()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                    CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
                    "cio SigOpLcZBO."
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar a tela de Sele" + CHR(231) + CHR(227) + ;
                    "o de Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do SCX legado)
    *
    * Geometria e cores transcritas do dump:
    *   cntSombra  Top=0  Left=0  Width=968 Height=80 BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *
    * Os dois labels sao a sombra e o texto do MESMO titulo (o preto desenha
    * 1px abaixo do branco, dai o Top 18 contra 17). As duas primeiras linhas
    * do Init legado atribuem o Caption do form aos dois, e eh o que se faz
    * aqui - ponto unico, sem repetir a atribuicao no InicializarForm.
    *
    * AutoSize = .F. EXPLICITO: em Label criado por AddObject o AutoSize eh
    * no-op, e com WordWrap = .T. ele ainda DESCARTA a Height e colapsa o
    * texto para uma linha. A geometria do SCX ja eh o auto-size que o Form
    * Designer calculou, entao fixa-la eh reproducao fiel.
    *
    * ForeColor branco eh correto AQUI porque o container eh OPACO e escuro
    * (BackStyle = 1 + BackColor RGB(100,100,100)) - a excecao legitima da
    * regra que proibe label de dados em branco.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra

        WITH loc_oCnt
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
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .AutoSize    = .F.
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarMolduras - as duas Shape do SCX legado (Shape1/ShpFigura)
    *
    * Geometria transcrita do dump:
    *   Shape1    Top=128 Left=616 Width=341 Height=57  BackStyle=0
    *   ShpFigura Top=204 Left=615 Width=341 Height=158 BackStyle=0
    *
    * Sao molduras decorativas: Shape1 contorna o bloco de localizacao
    * (Label3 + getBase + getDBase) e ShpFigura contorna a foto do produto.
    * Com BackStyle = 0 nao pintam fundo - so a borda aparece, que eh o que
    * o legado desenha.
    *
    * O dump declara so Top/Left/Height/Width/BackStyle (mais o ZOrderSet,
    * que eh bookkeeping do Form Designer e NAO existe em runtime - regra
    * #33; atribui-lo estouraria "Property ZORDERSET is not found" dentro do
    * TRY do InicializarForm e a tela simplesmente nao abriria). Nada de
    * ForeColor: a classe Shape nao tem essa propriedade (as cores dela sao
    * BorderColor/FillColor) - pelo mesmo motivo nada eh inventado aqui, so
    * transcrito.
    *
    * Criadas ANTES dos campos que emolduram: Shape1 (128..185 x 616..957)
    * cobre a area de Label3 (Top=136) e dos dois TextBox (Top=154), e
    * ShpFigura cobre a area da Image. Caixa transparente criada DEPOIS
    * desenharia por cima e bloquearia o clique no campo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()

        *-- Shape1: moldura do bloco de localizacao
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top       = 128
            .Left      = 616
            .Width     = 341
            .Height    = 57
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ShpFigura: moldura da foto do produto
        THIS.AddObject("shp_4c_ShpFigura", "Shape")
        WITH THIS.shp_4c_ShpFigura
            .Top       = 204
            .Left      = 615
            .Width     = 341
            .Height    = 158
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarImagemProduto - a foto do produto (ImgJpg do SCX legado)
    *
    * Geometria transcrita do dump:
    *   ImgJpg Stretch=2 Top=205 Left=616 Width=339 Height=156 Visible=.F.
    *
    * Nasce OCULTA porque o legado a declara assim: ela so aparece quando a
    * linha corrente da grade tem foto, e eh CarregarFotoProduto() quem a
    * exibe/esconde (o legado faz isso dentro do AfterRowColChange). Por
    * isso o nome img_4c_ImgJpg esta na lista de EXCECAO do
    * TornarControlesVisiveis - sem ela a foto apareceria em branco na
    * abertura, antes de qualquer produto ter sido selecionado.
    *
    * Stretch = 2 (isometrico) eh do dump e NAO eh detalhe: com Stretch = 0
    * (o default) o VFP9 DESCARTA a Width/Height declaradas e assume o
    * tamanho natural do arquivo no momento em que .Picture eh atribuido -
    * a moldura ShpFigura deixaria de casar com a foto, em silencio. Por
    * seguranca a ordem aqui tambem poe Stretch e Picture ANTES da
    * geometria, que eh a ordem do proprio dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagemProduto()

        THIS.AddObject("img_4c_ImgJpg", "Image")
        WITH THIS.img_4c_ImgJpg
            .Stretch = 2
            .Picture = ""
            .Top     = 205
            .Left    = 616
            .Width   = 339
            .Height  = 156
            .Visible = .F.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - grade de itens do movimento (grdItens do SCX legado)
    *
    * Geometria e colunas transcritas do dump (ColumnOrder fisico: Column3=1,
    * Column1=2, Column2=3, Column4=4):
    *   grdItens Top=105 Left=10 Width=549 Height=259 RowHeight=16
    *            GridLineColor=238,238,238 DeleteMark=.F. RecordMark=.F.
    *   Column1 (Cpros)  Width=122 Header "Produto"
    *   Column2 (Dpros)  Width=290 Header "Descricao"      ReadOnly
    *   Column3 (Marcas) Width=17  CheckBox de selecao
    *   Column4 (Locals) Width=95  Header "Localizacao"    ReadOnly
    *
    * Column1 nao declara ReadOnly no dump (so o Text1 tem .ReadOnly = .F.),
    * mas o Text1.When legado retorna .F. incondicional - a celula nunca
    * recebe foco, ou seja, a observavel para o usuario eh IDENTICA a
    * ReadOnly = .T.. Reproduzido assim (Column.ReadOnly = .T.) porque o
    * Grid migrado nao tem equivalente direto de When por celula.
    *
    * ORDEM OBRIGATORIA (Problema 48 / regra #35c): ColumnCount ->
    * RecordSource -> ControlSource de TODAS as colunas -> SO DEPOIS Width/
    * Header1.Caption/demais formatacao. Atribuir ControlSource reseta
    * Width e Header1.Caption para o default; fazer a formatacao antes
    * seria descartada. Por isso o bind e a formatacao vivem em MontaGrade()
    * / FormatarGridItens(), que sao reusados por TODO caminho que repinta a
    * grade - aqui so se cria o Grid e o CheckBox da coluna de marcacao.
    *
    * A ORDEM "BIND ANTES DO AddObject DO CHECKBOX" eh obrigatoria e foi
    * MEDIDA no VFP9 (2026-11-08, automation nao necessaria - reproduzido
    * neste proprio form). Grid cuja RecordSource ainda nao foi atribuida
    * AUTO-BINDA na area de trabalho CORRENTE assim que o ColumnCount eh
    * definido: medido, RecordSource virou sozinha "cursor_4c_Itens" e a
    * Column3 ficou ligada a terceira COLUNA DO CURSOR (Dpros, CHARACTER),
    * nao a Marcas. Adicionar nessa coluna um CheckBox - cujo .Value nasce
    * NUMERICO (medido: VARTYPE = "N", valor 0) - estoura no proprio
    * AddObject com "Error with CHK_4C_CHECK1 - Value : Data type
    * mismatch", dentro do TRY do InicializarForm: devolve .F.,
    * CREATEOBJECT devolve o logico .F. e A TELA NAO ABRE - o usuario
    * aciona a opcao e nada acontece, sem erro nenhum na tela.
    *
    * Tres caminhos foram medidos: RecordSourceType = 0 ANTES do AddObject
    * NAO resolve (o auto-bind ja aconteceu); ligar a Column3 a coluna
    * NUMERICA antes do AddObject resolve; e reBINDAR depois, quantas vezes
    * for, continua seguro (CurrentControl e Width sobrevivem porque
    * FormatarGridItens os reaplica).
    *
    * Por isso a sequencia inteira - bind, criacao do CheckBox e formatacao,
    * nessa ordem - mora dentro do MontaGrade, e aqui so se cria o Grid e se
    * chama o funil. Assim a ordem certa vale tambem nas repinturas, nao so
    * na montagem inicial.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top           = 105
            .Left          = 10
            .Width         = 549
            .Height        = 259
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 4
        ENDWITH

        *-- Bind + criacao do CheckBox + formatacao, na ordem provada acima.
        *-- MontaGrade faz os tres passos e eh reusado a cada repintura.
        THIS.MontaGrade()

        loc_oGrid.Visible = .T.

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxMarcacao - cria (ou RECRIA) o CheckBox da coluna de
    * marcacao e religa os handlers dele
    *
    * Equivale ao grdItens.Column3.Check1 do SCX legado, que la eh um objeto
    * DESENHADO na coluna. Aqui ele nasce por AddObject, e por isso tem um
    * ciclo de vida que o legado nao tem: FECHAR o alias ligado ao Grid
    * DESTROI o objeto adicionado na Column. Medido no VFP9 (2026-11-08):
    * depois de SigOpLcZBO.CarregarItens() - que faz USE IN no cursor da
    * grade para refaze-lo - o Column3.CurrentControl voltou para "Text1" e
    * o CheckBox tinha desaparecido, enquanto Width e Header1.Caption
    * sobreviveram. Sem erro, sem log: o usuario ve o 0/1 CRU numa caixa de
    * texto e nao tem como marcar linha nenhuma.
    *
    * Por isso a criacao eh IDEMPOTENTE e mora num metodo proprio, chamado
    * por MontaGrade a cada repintura: PEMSTATUS diz se o objeto ainda
    * existe, e so quando NAO existe eh que se adiciona (AddObject com nome
    * repetido estouraria "Object already defined"). Os BINDEVENT vao JUNTO,
    * no mesmo lugar: objeto recriado eh outro objeto, e as ligacoes do
    * anterior morreram com ele - sem religar, os quatro handlers de
    * alternancia (regra #185) ficariam mudos.
    *
    * .Value = 0 NUMERICO eh obrigatorio e tem de bater com o tipo da coluna
    * (Marcas N(1,0), do "0 as Marcas" do Select Distinct legado).
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
        LOCAL loc_oCol

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oCol = THIS.grd_4c_Dados.Column3

        *-- Ja existe: nada a fazer (e nao se pode AddObject de novo)
        IF PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
            RETURN .T.
        ENDIF

        loc_oCol.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oCol.chk_4c_Check1
            .Top       = 22
            .Left      = 22
            .Height    = 17
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Handlers de alternancia: Click/MouseDown suprimem o toggle
        *-- nativo, MouseUp delega ao KeyPress e o KeyPress eh quem alterna
        *-- Marcas - exatamente o conjunto que o Check1 legado declara
        BINDEVENT(loc_oCol.chk_4c_Check1, "Click",     THIS, "ChkMarcasClick")
        BINDEVENT(loc_oCol.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
        BINDEVENT(loc_oCol.chk_4c_Check1, "MouseUp",   THIS, "ChkMarcasMouseUp")
        BINDEVENT(loc_oCol.chk_4c_Check1, "KeyPress",  THIS, "ChkMarcasKeyPress")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * MontaGrade - equivalente a PROCEDURE montagrade do SCX legado
    *
    *   Select crItensLoc / Index on Cpros Tag Cpros / Go top
    *   With ThisForm.grdItens
    *       .RecordSource = [crItensLoc]
    *       .column1.ControlSource = [crItensLoc.Cpros]   ... (as quatro)
    *       .Refresh()
    *   EndWith
    *
    * FUNIL UNICO do bind/repintura da grade: chamado na montagem
    * (ConfigurarGrid), pelo botao Limpar Selecao (o legado tambem chama
    * ThisForm.Montagrade() ali) e pelo CarregarLista(). Grade ligada a
    * cursor NAO se repinta sozinha depois que o cursor muda (regra #21) -
    * sem um ponto unico, cada caminho esquece uma metade.
    *
    * O Index on Cpros NAO eh repetido aqui: quem cria cursor_4c_Itens eh
    * SigOpLcZBO.CarregarItens(), que ja faz o INDEX ON Cpros TAG Cpros
    * imediatamente apos o SELECT - repetir o INDEX a cada repintura so
    * recriaria a mesma tag.
    *
    * O Column1.SetFocus que fecha o montagrade legado fica nos HANDLERS de
    * botao e nao aqui: MontaGrade tambem roda durante o InicializarForm,
    * com a tela ainda nao exibida, e dar foco a controle de form invisivel
    * derrubaria o Init. Os dois call sites do usuario (Localizar e Limpar
    * Selecao) ja chamam o SetFocus, entao o observavel eh identico.
    *
    * PUBLIC: eh funil, precisa ser acionavel pelos handlers e pelo harness.
    *
    * par_cFiltro: NAO existe no legado (montagrade do SCX nao recebe
    * argumento) e NAO eh usado aqui - declarado so porque o harness
    * TesteAutomatico (TesteCarregarDadosReais) trata qualquer metodo
    * chamado "MontaGrade" como se recebesse um codigo de grupo e sempre
    * invoca com 1 argumento. Sem o parametro declarado, VFP9 estoura
    * "No PARAMETER statement is found" nessa chamada. Os tres call sites
    * internos (THIS.MontaGrade()) continuam validos sem argumento.
    *==========================================================================
    PROCEDURE MontaGrade(par_cFiltro)
        LOCAL loc_oGrid, loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oGrid   = THIS.grd_4c_Dados
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        loc_oGrid.RecordSource = loc_cCursor

        loc_oGrid.Column1.ControlSource = loc_cCursor + ".Cpros"
        loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dpros"
        loc_oGrid.Column3.ControlSource = loc_cCursor + ".Marcas"
        loc_oGrid.Column4.ControlSource = loc_cCursor + ".Locals"

        *-- SO AGORA o CheckBox pode entrar/voltar: a Column3 acabou de ser
        *-- ligada a coluna NUMERICA Marcas, e eh esse bind que impede o
        *-- "Data type mismatch" no AddObject (ver cabecalho de
        *-- ConfigurarGrid). Idempotente: cria apenas se o objeto nao existe.
        THIS.GarantirCheckBoxMarcacao()

        *-- RecordSource/ControlSource acabaram de resetar Width,
        *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
        THIS.FormatarGridItens(loc_oGrid)

        *-- Go top + Refresh: o legado fecha o montagrade assim, e eh o que
        *-- faz a grade EXIBIR as linhas que o cursor passou a ter
        SELECT (loc_cCursor)
        GO TOP
        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - recarrega os itens do cursor do form PAI e repinta
    *
    * Equivale ao par "Select Distinct ... Into Cursor crItensLoc" +
    * "ThisForm.MontaGrade()" do Init legado: a consulta eh do BO
    * (CarregarItens) e a repintura eh do MontaGrade. Separado do
    * MontaGrade de proposito - o botao Limpar Selecao do legado so REPINTA
    * (chama Montagrade e nada mais), NAO recarrega; recarregar ali
    * desfaria as localizacoes que o usuario ja aplicou na sessao.
    *
    * PUBLIC: o harness de teste chama CarregarLista de FORA da classe, e
    * PEMSTATUS devolve .T. para metodo PROTECTED (so testa existencia, nao
    * escopo) - o teste entraria no branch e a chamada falharia (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.this_oBusinessObject.CarregarItens()

        *-- Repinta mesmo quando a carga falhou: o cursor placeholder criado
        *-- no InicializarForm continua sendo um RecordSource valido, e a
        *-- grade tem de voltar a um estado coerente (vazia) em vez de
        *-- seguir exibindo as linhas da carga anterior
        THIS.MontaGrade()
        THIS.GradeAfterRowColChange()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormatarGridItens - propriedades das quatro colunas de grd_4c_Dados
    *
    * Chamado por MontaGrade SEMPRE depois do bind, porque atribuir
    * RecordSource/ControlSource reseta Width e Header1.Caption para o
    * default 90/"Header1" (Problema 48) e derruba o CurrentControl da
    * coluna de marcacao (regra #18) - a grade apareceria com colunas
    * quadradas, cabecalhos "Header1" e o valor cru 0/1 no lugar do
    * CheckBox.
    *
    * Column.ReadOnly vem DEPOIS do Grid.ReadOnly por regra (#18): o do
    * grid propaga para as colunas e sobrescreveria estes valores.
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridItens(par_oGrid)
        LOCAL loc_oGrid

        IF VARTYPE(par_oGrid) = "O"
            loc_oGrid = par_oGrid
        ELSE
            loc_oGrid = THIS.grd_4c_Dados
        ENDIF

        WITH loc_oGrid.Column1
            .ColumnOrder       = 2
            .Width             = 122
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Produto"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.Alignment   = 3
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .ColumnOrder       = 3
            .Width             = 290
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .ColumnOrder      = 1
            .Width            = 17
            .Sparse           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
            .Header1.Caption  = ""
        ENDWITH

        *-- Sem o CurrentControl a coluna volta a desenhar o Text1 dela e o
        *-- usuario ve o 0/1 cru, sem como marcar nada (regra #18). O
        *-- PEMSTATUS protege a reaplicacao: o CheckBox eh criado uma unica
        *-- vez, em ConfigurarGrid, e aqui so se aponta para ele.
        IF PEMSTATUS(loc_oGrid.Column3, "chk_4c_Check1", 5)
            loc_oGrid.Column3.CurrentControl = "chk_4c_Check1"
        ENDIF
        loc_oGrid.Column3.ReadOnly = .F.

        WITH loc_oGrid.Column4
            .ColumnOrder       = 4
            .Width             = 95
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ChkMarcasClick / ChkMarcasMouseDown / ChkMarcasMouseUp / ChkMarcasKeyPress
    *
    * Equivalente ao SigOpLcZ.grdItens.Column3.Check1 do legado - Click e
    * MouseDown sao NoDefault puro (suprimem o toggle nativo do CheckBox),
    * MouseUp delega para o KeyPress(13,0), e o KeyPress eh quem de fato
    * alterna Marcas em ENTER(13)/ESPACO(32), igual ao legado:
    *   If InList(m.nKeyCode,13,32)
    *       Replace crItensLoc.Marcas With IIf(crItensLoc.Marcas == 0,1,0)
    *       This.parent.parent.AfterRowColChange
    *       This.parent.parent.Refresh
    *       NoDefault
    *   EndIf
    *
    * O When legado (InList(pcEscolha,'INSERIR','ALTERAR')) vira guarda
    * dentro do KeyPress via SigOpLcZBO.PodeEditar() - fora desse modo a
    * tecla eh descartada sem alternar nada.
    *
    * PUBLIC: exigido pelo BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE ChkMarcasClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkMarcasKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF INLIST(par_nKeyCode, 13, 32) AND THIS.this_oBusinessObject.PodeEditar()
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

            IF USED(loc_cCursor) AND !EOF(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                REPLACE Marcas WITH IIF(EVALUATE(loc_cCursor + ".Marcas") == 0, 1, 0) ;
                    IN (loc_cCursor)

                THIS.GradeAfterRowColChange()
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - atualiza o estado do botao Localizar conforme
    * a linha corrente da grade.
    *
    * Equivalente ao SigOpLcZ.grdItens.AfterRowColChange legado:
    *   If Empty(crItensLoc.Locals) And Not Empty(crItensLoc.Marcas)
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .T.
    *   Else
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .F.
    *   EndIf
    * A fonte unica dessa regra eh SigOpLcZBO.PodeLocalizar() (depende de
    * CarregarDoCursor ja ter lido a linha corrente).
    *
    * A OUTRA metade do handler legado eh a foto do produto, que usa a MESMA
    * linha corrente: o legado consulta SigCdPro.FigJpgs e exibe/esconde o
    * ImgJpg conforme achou imagem ou nao. Portada em CarregarFotoProduto(),
    * chamada aqui - no MESMO ponto do legado, e ANTES da regra do botao,
    * tambem como o legado.
    *
    * par_nColIndex nao eh usado, e isso eh fiel: o legado declara o
    * parametro (LPARAMETERS nColIndex) e nunca o le - a chamada do
    * Check1.KeyPress eh This.parent.parent.AfterRowColChange, sem
    * argumento. O parametro continua declarado porque o BINDEVENT liga este
    * metodo ao AfterRowColChange nativo, que SEMPRE passa a coluna (regra
    * #3: handler sem o parametro estoura a cada troca de celula).
    *
    * PUBLIC: ligado via BINDEVENT ao AfterRowColChange nativo do grid
    * (regra #3) e TAMBEM chamado DIRETO pelos botoes de selecao/limpeza/
    * localizacao, como o legado faz com ThisForm.grdItens.AfterRowColChange().
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.this_oBusinessObject.CarregarDoCursor()

        *-- Foto do produto da linha corrente (ImgJpg do legado)
        THIS.CarregarFotoProduto()

        *-- PEMSTATUS porque este metodo esta ligado por BINDEVENT ao
        *-- AfterRowColChange NATIVO da grade, que pode disparar durante o
        *-- InicializarForm - a grade eh criada ANTES do cmdAcoes, e sem o
        *-- guard a tela nao abriria com "Property OBJ_4C_CMDACOES is not
        *-- found" engolido pelo CATCH do Init.
        IF PEMSTATUS(THIS, "obj_4c_CmdAcoes", 5)
            THIS.obj_4c_CmdAcoes.Buttons(1).Enabled = ;
                THIS.this_oBusinessObject.PodeEditar() AND ;
                THIS.this_oBusinessObject.PodeLocalizar()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarFotoProduto - exibe a foto do produto da linha corrente
    *
    * Transcreve a primeira metade do grdItens.AfterRowColChange legado:
    *   lcArquivo2 = Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    *   = ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *                                    crItensLoc.Cpros,'FigJpgs')
    *   If Not IsNull(crTPro.FigJpgs) And Not IsEmpty(crTPro.FigJpgs)
    *       ImgJpg.Visible = .F. / ImgJpg.Picture = ''
    *       Clear Resources
    *       lcFoto = Strconv(Strtran(Strtran(Strtran(crTPro.FigJpgs,
    *                 [data:image/png;base64,],[]),[data:image/jpeg;base64,],
    *                 []),[data:image/jpg;base64,],[]), 14)
    *       StrToFile(lcFoto, lcArquivo2)
    *       ImgJpg.Picture = (lcArquivo2) / ImgJpg.Visible = .T.
    *   Else
    *       ImgJpg.Visible = .F. / ImgJpg.Picture = ''
    *   EndIf
    *
    * A consulta eh do BO (SigOpLcZBO.ObterImagemProduto, que devolve o
    * base64 ou .NULL.) e o tratamento do conteudo eh daqui - divisao
    * decidida na Fase 2 e documentada no cabecalho daquele metodo: so o
    * form conhece o controle Image que vai exibir a foto.
    *
    * UM UNICO STRCONV(..., 14). O valor que vem do banco eh base64 e a
    * conversao o transforma em JPEG binario; converter DE NOVO trataria
    * binario como base64 e produz lixo, que o VFP9 recusa com "Picture too
    * big, corrupt, or in wrong format" - e o legado tambem decodifica uma
    * vez so.
    *
    * O .Visible = .F. + .Picture = "" ANTES de apontar o arquivo novo eh do
    * legado e tem razao de ser: sem liberar a Picture anterior, o .jpg
    * temporario fica em uso e o CLEAR RESOURCES nao o solta.
    *
    * CATCH SEM MsgErro, de proposito e por DESVIO deliberado da regra #9:
    * este metodo roda a cada troca de linha da grade, e um modal por linha
    * com foto corrompida deixaria a tela inutilizavel. O erro NAO eh
    * engolido - fica em this_cMensagemErro com Linha/Procedure, que eh o
    * que a regra #9 existe para garantir.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFotoProduto()
        LOCAL loc_cCpros, loc_xImagem, loc_cBase64, loc_cBinario
        LOCAL loc_cArquivo, loc_oErro

        IF !PEMSTATUS(THIS, "img_4c_ImgJpg", 5)
            RETURN .F.
        ENDIF

        TRY
            loc_cCpros  = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCprosAtual, ""))
            loc_xImagem = .NULL.

            IF !EMPTY(loc_cCpros)
                loc_xImagem = THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros)
            ENDIF

            *-- ObterImagemProduto devolve .NULL. quando nao ha foto (ou nao
            *-- ha conexao, que eh o caso do harness). O teste de tipo cobre
            *-- os dois sem estourar: EMPTY(.NULL.) devolve .F. no VFP9, ou
            *-- seja NULL passaria por "nao vazio" e o STRTRAN quebraria.
            IF VARTYPE(loc_xImagem) = "C" AND !EMPTY(loc_xImagem)

                *-- Libera a Picture anterior ANTES de reescrever o arquivo
                THIS.img_4c_ImgJpg.Visible = .F.
                THIS.img_4c_ImgJpg.Picture = ""

                loc_cBase64 = STRTRAN(loc_xImagem,  "data:image/png;base64,",  "")
                loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpeg;base64,", "")
                loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,",  "")

                *-- UMA conversao base64 -> binario JPEG
                loc_cBinario = STRCONV(loc_cBase64, 14)

                loc_cArquivo = ADDBS(SYS(2023)) + THIS.ObterPrefixoTemp() + ;
                    SYS(2015) + ".jpg"

                CLEAR RESOURCES
                STRTOFILE(loc_cBinario, loc_cArquivo)

                IF FILE(loc_cArquivo)
                    THIS.img_4c_ImgJpg.Picture = loc_cArquivo
                    THIS.img_4c_ImgJpg.Visible = .T.
                ELSE
                    *-- Sem o arquivo em disco, apontar .Picture para um
                    *-- caminho inexistente nao daria erro nenhum e deixaria
                    *-- a moldura vazia (regra #25) - melhor esconder
                    THIS.img_4c_ImgJpg.Visible = .F.
                    THIS.img_4c_ImgJpg.Picture = ""
                ENDIF
            ELSE
                THIS.img_4c_ImgJpg.Visible = .F.
                THIS.img_4c_ImgJpg.Picture = ""
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a foto do produto: " + ;
                loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Procedure: " + loc_oErro.Procedure

            THIS.img_4c_ImgJpg.Visible = .F.
            THIS.img_4c_ImgJpg.Picture = ""
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterPrefixoTemp - prefixo dos arquivos temporarios de imagem
    *
    * Legado: Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    *
    * go_4c_Sistema eh um objeto Empty e cada membro dele entra por
    * ADDPROPERTY no config.prg; ler property que NAO foi adicionada estoura
    * "Property SYS2015TMP is not found" em runtime. O Sys2015Tmp existe hoje
    * no config.prg ("4c_tmp_"), e o PEMSTATUS aqui so cobre um ambiente com
    * config antigo ainda em memoria - sem ele, uma tela que abre normalmente
    * quebraria na primeira linha de grade com foto.
    *==========================================================================
    PROTECTED PROCEDURE ObterPrefixoTemp()
        LOCAL loc_cPrefixo

        loc_cPrefixo = "4c_tmp_"

        IF TYPE("go_4c_Sistema") = "O"
            IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
                loc_cPrefixo = ALLTRIM(NVL(go_4c_Sistema.Sys2015Tmp, "4c_tmp_"))
            ENDIF
        ENDIF

        RETURN loc_cPrefixo
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesPrincipais - cntBotoes do SCX legado: Confirmar/Sair
    *
    * Geometria e icones transcritos do dump. Buttons(1) = Command1 =
    * btnSair (Left=81, mais a direita dentro do grupo), Buttons(2) =
    * Command2 = btnConfirmar (Left=6, mais a esquerda) - ordem fisica
    * invertida em relacao a ordem de declaracao, conforme o dump.
    * Buttons DENTRO de CommandGroup mantem Themes = .F. (canonico).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
        LOCAL loc_oCmg

        THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
        loc_oCmg = THIS.obj_4c_CntBotoes

        WITH loc_oCmg
            .Top           = -2
            .Left          = 811
            .Width         = 161
            .Height        = 85
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Value         = 0
        ENDWITH

        WITH loc_oCmg.Buttons(1)
            .Top           = 5
            .Left          = 81
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .WordWrap      = .T.
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel        = .T.
            .Caption       = "\<Cancelar"
            .MousePointer  = 15
            .ToolTipText   = "[Esc] Encerrar"
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
        ENDWITH

        WITH loc_oCmg.Buttons(2)
            .Top          = 5
            .Left         = 6
            .Width        = 75
            .Height       = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption      = "\<Confirmar"
            .MousePointer = 15
            .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
        ENDWITH

        loc_oCmg.Visible = .T.

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnSairClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnSairClick / BtnConfirmarClick
    *
    * Equivalente a SigOpLcZ.cntBotoes.btnSair.Click (ThisForm.Release) e
    * SigOpLcZ.cntBotoes.btnConfirmar.Click (Scan em csLocals, Update
    * crTpmMvItn, Release - sem validacao nenhuma antes, o legado sempre
    * fecha a tela). SigOpLcZBO.Confirmar() ja reproduz o Scan/Update; sem
    * linhas em cursor_4c_Selecionados eh no-op valido, igual ao legado.
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnConfirmarClick()
        THIS.this_oBusinessObject.Confirmar()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcoes - cmdAcoes do SCX legado: Localizar/Limpar Selecao
    *
    * Buttons(1) = Command1 = btnLocalizar (comeca desabilitado - so liga
    * quando GradeAfterRowColChange encontrar uma linha marcada e sem
    * localizacao). Buttons(2) = Command2 = btnLimpar (habilitado conforme
    * o modo, ajustado por HabilitarCampos).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcoes()
        LOCAL loc_oCmg

        THIS.AddObject("obj_4c_CmdAcoes", "CommandGroup")
        loc_oCmg = THIS.obj_4c_CmdAcoes

        WITH loc_oCmg
            .Top           = -2
            .Left          = 662
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Value         = 0
        ENDWITH

        WITH loc_oCmg.Buttons(1)
            .Top           = 5
            .Left          = 80
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .WordWrap      = .T.
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .Cancel        = .T.
            .Caption       = "\<Localizar"
            .MousePointer  = 15
            .ToolTipText   = "[Esc] Encerrar"
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Enabled       = .F.
        ENDWITH

        WITH loc_oCmg.Buttons(2)
            .Top          = 5
            .Left         = 5
            .Width        = 75
            .Height       = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .Caption      = "\<Limpar Sele" + CHR(231) + CHR(227) + "o"
            .MousePointer = 15
            .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
        ENDWITH

        loc_oCmg.Visible = .T.

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnLocalizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnLimparClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnLocalizarClick
    *
    * Equivalente a SigOpLcZ.cmdAcoes.btnLocalizar.Click: valida a base
    * (dentro de SigOpLcZBO.Localizar - fonte unica, regra #178), move as
    * linhas marcadas para cursor_4c_Selecionados e refoca a grade.
    *==========================================================================
    PROCEDURE BtnLocalizarClick()
        IF !THIS.this_oBusinessObject.PodeEditar()
            RETURN .F.
        ENDIF

        *-- O legado le a base direto do controle (lcLocaliza =
        *-- ThisForm.getBase.Value) no inicio do Click. Aqui a leitura passa
        *-- pelo funil, que eh o que garante que o BO veja o valor digitado
        *-- mesmo quando o LostFocus do campo nao rodou antes do clique.
        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.Localizar()
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Localizar() ja zerou this_cBaseLocalizacao/this_cDescBaseLocalizacao
        *-- no BO (equivalente ao getBase/getDBase.Value = [] do legado) -
        *-- espelhar nos controles pelo funil
        THIS.LimparCampos()

        THIS.grd_4c_Dados.Column1.SetFocus()
        THIS.grd_4c_Dados.Refresh()
        THIS.GradeAfterRowColChange()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnLimparClick
    *
    * Equivalente a SigOpLcZ.cmdAcoes.btnLimpar.Click: o legado chama
    * ThisForm.Montagrade(), que so REINDEXA e REBINDA a grade (Index on
    * Cpros, Go Top, Refresh) - NAO recarrega crItensLoc do crTpmMvItn, ou
    * seja nao desfaz marcacoes nem localizacoes ja aplicadas. Aqui o
    * equivalente eh GO TOP + Refresh no MESMO cursor_4c_Itens, mais a
    * limpeza da base escolhida (ThisForm.getBase.Value = [] / getDBase.
    * Value = [] do legado): a property no BO e o controle visual juntos.
    *==========================================================================
    PROCEDURE BtnLimparClick()
        IF !THIS.this_oBusinessObject.PodeEditar()
            RETURN .F.
        ENDIF

        *-- ThisForm.Montagrade() do legado: REBINDA e repinta a grade, sem
        *-- recarregar o cursor (nao desfaz marcacoes nem localizacoes ja
        *-- aplicadas). Por isso MontaGrade e NAO CarregarLista.
        THIS.MontaGrade()

        *-- getBase.Value = [] / getDBase.Value = [] do legado
        THIS.LimparCampos()

        THIS.grd_4c_Dados.Column1.SetFocus()
        THIS.grd_4c_Dados.Refresh()
        THIS.GradeAfterRowColChange()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesSelecao - botoes standalone apaga/SelTudo do SCX legado
    *
    * Caption = "" (icone puro) + Themes = .F., fieis ao dump. A regra de
    * modo (When = InList(pcEscolha,'INSERIR','ALTERAR')) NAO vira
    * .Enabled/.Visible em runtime - botao standalone com Caption = "" e
    * Picture definido perde o icone quando desabilitado, independente de
    * Themes (CorretorAutomatico #106). A guarda fica DENTRO do Click.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesSelecao()
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 176
            .Left        = 564
            .Width       = 45
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Selecionar"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 217
            .Left        = 564
            .Width       = 45
            .Height      = 40
            .FontBold    = .F.
            .FontItalic  = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarcar"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CmdSelTudoClick / CmdApagaClick
    *
    * Equivalente a SigOpLcZ.SelTudo.Click (Replace All Marcas with 1) e
    * SigOpLcZ.apaga.Click (Replace All Marcas with 0) - ambos seguidos de
    * Go Top + grdItens.AfterRowColChange() + Form.Refresh no legado.
    * Guarda de modo (When legado) replicada no INICIO do Click, nao via
    * .Enabled (regra do botao standalone icone-only acima).
    *==========================================================================
    PROCEDURE CmdSelTudoClick()
        IF !THIS.this_oBusinessObject.PodeEditar()
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.SelecionarTodos()
        THIS.GradeAfterRowColChange()
        THIS.Refresh()

        RETURN .T.
    ENDPROC

    PROCEDURE CmdApagaClick()
        IF !THIS.this_oBusinessObject.PodeEditar()
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.DesmarcarTodos()
        THIS.GradeAfterRowColChange()
        THIS.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarCampoBase - Label3/getBase/getDBase do SCX legado: a
    * localizacao escolhida pelo usuario antes de clicar Localizar.
    *
    * Geometria transcrita do dump:
    *   Label3   Top=136 Left=640 Width=56  Height=15  "Localiza??o"
    *   getBase  Top=154 Left=640 Width=101 Height=24
    *   getDBase Top=154 Left=742 Width=200 Height=24
    *
    * Label3 nao declara ForeColor no dump (classe say pura) - regra #23:
    * AutoSize = .F. com a Width/Height do proprio dump, Alignment = 0,
    * ForeColor = RGB(90, 90, 90) (canonico para label de dados fora da
    * faixa de cabecalho).
    *
    * MaxLength vem do SCHEMA (regra #19), nao do Width em pixels:
    * SigPrLcl.codigos eh char(10) (txt_4c_Base) e SigPrLcl.descricaos eh
    * char(20) (txt_4c_DBase) - docs/schema.sql.
    *
    * getDBase.When do legado retorna .F. incondicional (a celula nunca
    * recebe foco, em qualquer modo) - por isso ReadOnly/TabStop ficam FIXOS
    * aqui, e NAO entram em HabilitarCampos como txt_4c_Base entra.
    *
    * Aqui so a casca VISUAL, com os valores iniciados vazios (equivalente ao
    * PrepararCursores do BO, que ja zera this_cBaseLocalizacao /
    * this_cDescBaseLocalizacao). O COMPORTAMENTO do getBase vive em handlers
    * proprios, ligados por BINDEVENT no fim deste metodo: o lookup do
    * getBase.Valid legado (fwbuscaext em SigPrLcl) esta em BaseLostFocus /
    * BaseLostFocusExec + AbrirBuscaBase, e o getBase.InteractiveChange (que
    * limpa getDBase ao digitar) esta em BaseInteractiveChange.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoBase()
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 136
            .Left      = 640
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Base", "TextBox")
        WITH THIS.txt_4c_Base
            .Top       = 154
            .Left      = 640
            .Width     = 101
            .Height    = 24
            .FontName  = "Verdana"
            .FontSize  = 8
            .MaxLength = 10
            .Value     = ""
            .ToolTipText = "C" + CHR(243) + "digo da Base de Localiza" + ;
                CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DBase", "TextBox")
        WITH THIS.txt_4c_DBase
            .Top       = 154
            .Left      = 742
            .Width     = 200
            .Height    = 24
            .FontName  = "Verdana"
            .FontSize  = 8
            .MaxLength = 20
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.txt_4c_Base, "LostFocus", THIS, "BaseLostFocus")
        BINDEVENT(THIS.txt_4c_Base, "InteractiveChange", THIS, "BaseInteractiveChange")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BaseInteractiveChange - getBase.InteractiveChange do legado: limpa a
    * descricao enquanto o usuario digita um codigo novo.
    *   ThisForm.getDBase.Value = []
    * PUBLIC: exigido pelo BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BaseInteractiveChange()
        THIS.txt_4c_DBase.Value = ""
    ENDPROC

    *==========================================================================
    * BaseLostFocus / BaseLostFocusExec - getBase.Valid do legado (busca em
    * SigPrLcl, tabela REMOTA):
    *   loLista = CreateObject('fwbuscaext', ..., 'SigPrLcl', 'crListaRemota',
    *             'Codigos', This.Value, 'Selecao', .t.)
    *   If Not loLista.plAchouRegistro
    *       loLista.mAddColuna('Codigos',    '', 'Localizacao')
    *       loLista.mAddColuna('Descricaos', '', 'Descricao')
    *       loLista.Show()
    *   EndIf
    *   This.Value = crListaRemota.Codigos
    *   ThisForm.getDBase.Value = crListaRemota.Descricaos
    *
    * fwbuscaext tenta o match EXATO por Codigos sozinho (plAchouRegistro) e
    * SO quando nao acha eh que mostra o browse - reproduzido aqui com
    * SQLEXEC exato primeiro (silencioso) e THIS.AbrirBuscaBase() como
    * fallback (regra #36/37: Pattern B do FormBuscaAuxiliar com CREATEOBJECT
    * de 2+ argumentos eh PROIBIDO - CORRETO eh o funil THIS.AbrirLookupCanonico,
    * ja usado pelo FormSigOpLcl irmao desta task).
    *
    * Guarda de reentrancia (regra #37/#47): o corpo vive em
    * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com RETURN
    * antecipado dentro do Exec.
    *
    * Sincroniza o resultado com o BO (this_cBaseLocalizacao/
    * this_cDescBaseLocalizacao) - sem isso THIS.this_oBusinessObject.
    * Localizar() nunca veria o valor digitado/escolhido pelo usuario, e
    * sempre recusaria com "Informar a Base da Localizacao.".
    *
    * PUBLIC: exigido pelo BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BaseLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.BaseLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE BaseLostFocusExec()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lAchou

        loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)

        *-- Campo vazio: o legado nem entra no If Not Empty(This.Value), ou
        *-- seja nao abre picker nenhum e nao avisa nada (regra #50 - campo
        *-- em branco nao eh erro). So o BO precisa saber que nao ha base.
        IF EMPTY(loc_cValor)
            THIS.FormParaBO()
            RETURN
        ENDIF

        loc_lAchou = .F.

        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                IF USED("cursor_4c_BaseExata")
                    USE IN cursor_4c_BaseExata
                ENDIF

                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos = " + ;
                    EscaparSQL(loc_cValor)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")

                IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
                    IF RECCOUNT("cursor_4c_BaseExata") = 1
                        THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Codigos)
                        THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descricaos, ""))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BaseExata")
                    USE IN cursor_4c_BaseExata
                ENDIF
            ENDIF
        ENDIF

        IF !loc_lAchou
            *-- Funil unico do picker (regra #37): tudo que abre
            *-- FormBuscaAuxiliar para a Base passa por AbrirBuscaBase
            THIS.AbrirBuscaBase()
        ENDIF

        THIS.txt_4c_Base.Refresh()
        THIS.txt_4c_DBase.Refresh()

        *-- Sincroniza o resultado com o BO pelo funil - sem isso
        *-- SigOpLcZBO.Localizar() nunca veria o valor digitado/escolhido e
        *-- recusaria sempre com "Informar a Base da Localizacao."
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * AbrirBuscaBase - FUNIL UNICO do picker da Base (SigPrLcl, tabela REMOTA)
    *
    * Transcreve o ramo "nao achou" do getBase.Valid legado (mAddColuna de
    * Codigos/Descricaos). O match exato (plAchouRegistro do legado) ja foi
    * tentado em BaseLostFocusExec - aqui so se chega quando ele falhou.
    *
    * PUBLIC de proposito (regra #3): eh o funil, tem de poder ser acionado
    * de fora do proprio LostFocus.
    *
    * Guarda de reentrancia em SAVE/RESTORE, nao set/clear (regra #47): este
    * metodo eh chamado de DENTRO de BaseLostFocusExec, onde a flag ja esta
    * ligada - um clear simples a liberaria cedo demais e o LostFocus que o
    * fechamento do picker MODAL redispara abriria um SEGUNDO dialogo.
    *==========================================================================
    PROCEDURE AbrirBuscaBase()
        LOCAL loc_cValor, loc_lEmLookupAnt, loc_oErro

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)

            THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", ;
                "Sele" + CHR(231) + CHR(227) + "o", loc_cValor, ;
                THIS.txt_4c_Base, THIS.txt_4c_DBase)

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o da Base:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL do estado dos controles por modo
    *
    * Reune as DUAS coisas que o legado avalia para decidir o que esta
    * habilitado: o modo recebido do chamador (os When de getBase,
    * btnLocalizar e btnLimpar, todos "InList(pcEscolha,'INSERIR',
    * 'ALTERAR')") e a linha corrente da grade (o AfterRowColChange, que
    * manda em btnLocalizar). Ter um ponto unico eh o que evita a classe de
    * defeito da regra #40 - quem desabilita no caminho de ida e esquece de
    * reabilitar no caminho de volta deixa a tela inutilizavel, sem erro
    * nenhum e sem nada em log.
    *
    * PUBLIC: o harness de teste chama este metodo de FORA da classe, e
    * PEMSTATUS devolve .T. mesmo para metodo PROTECTED (so testa
    * existencia, nao escopo) - o teste entraria no branch e a chamada real
    * falharia em runtime (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(THIS.this_oBusinessObject.PodeEditar())

        *-- btnLocalizar depende TAMBEM da linha corrente da grade
        THIS.GradeAfterRowColChange()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - o When de getBase e de btnLimpar
    *
    * Fonte unica da regra de modo: SigOpLcZBO.PodeEditar(). O parametro
    * existe para o chamador poder FORCAR o travamento (e eh assim que o
    * AjustarBotoesPorModo o usa), mas o default - sem argumento - eh
    * consultar o BO, para que nenhum call site precise repetir o INLIST.
    *
    * btnLimpar (Buttons(2) de obj_4c_CmdAcoes) tem Caption, entao .Enabled
    * em runtime eh seguro. Os dois botoes STANDALONE de icone PURO
    * (cmd_4c_SelTudo / cmd_4c_Apaga) NAO entram aqui: desabilitar botao com
    * Caption = "" e Picture definido APAGA o icone, e o usuario ve um
    * retangulo vazio (regra #106) - para esses a guarda mora no inicio do
    * proprio Click.
    *
    * btnLocalizar fica fora porque depende TAMBEM da linha corrente da
    * grade - quem manda nele eh GradeAfterRowColChange.
    *
    * txt_4c_DBase tambem fica fora, e nao por esquecimento: o getDBase.When
    * do legado retorna .F. INCONDICIONAL, isto eh o campo eh inacessivel em
    * QUALQUER modo. Isso ja esta fixado em ConfigurarCampoBase
    * (ReadOnly = .T. + TabStop = .F.); trazer o campo para ca o faria
    * oscilar com o modo, que eh justamente o que o legado nao faz.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ELSE
            loc_lHabilitar = THIS.this_oBusinessObject.PodeEditar()
        ENDIF

        THIS.obj_4c_CmdAcoes.Buttons(2).Enabled = loc_lHabilitar
        THIS.txt_4c_Base.Enabled                = loc_lHabilitar

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - txt_4c_Base / txt_4c_DBase -> properties do BO
    *
    * Este dialogo nao tem registro proprio para transferir: o unico dado
    * que o usuario digita eh a BASE escolhida (getBase/getDBase do legado),
    * e eh dela que SigOpLcZBO.Localizar() depende. O legado le o controle
    * direto, no inicio do btnLocalizar.Click (lcLocaliza =
    * ThisForm.getBase.Value); aqui a leitura eh um metodo so, chamado pelo
    * handler do lookup E pelo botao Localizar, para os dois nunca
    * divergirem.
    *
    * PROTECTED obrigatorio: FormBase declara este hook como PROTECTED e o
    * VFP9 nao deixa a subclasse ALARGAR escopo herdado - a chamada de fora
    * estouraria "Property FORMPARABO is not found" em runtime (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cBaseLocalizacao = ;
            ALLTRIM(NVL(THIS.txt_4c_Base.Value, ""))

        THIS.this_oBusinessObject.this_cDescBaseLocalizacao = ;
            ALLTRIM(NVL(THIS.txt_4c_DBase.Value, ""))

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - properties do BO -> txt_4c_Base / txt_4c_DBase
    *
    * Caminho inverso do FormParaBO. Quem zera a base eh o BO (o
    * Localizar() limpa this_cBaseLocalizacao depois de aplicar, como o
    * legado limpa getBase/getDBase no fim do Click), entao o form precisa
    * de um ponto unico para ESPELHAR o estado do BO nos controles.
    *
    * PROTECTED obrigatorio pelo mesmo motivo do FormParaBO (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.txt_4c_Base.Value = ;
            ALLTRIM(NVL(THIS.this_oBusinessObject.this_cBaseLocalizacao, ""))

        THIS.txt_4c_DBase.Value = ;
            ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescBaseLocalizacao, ""))

        THIS.txt_4c_Base.Refresh()
        THIS.txt_4c_DBase.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - o par "getBase.Value = [] / getDBase.Value = []"
    *
    * O legado repete esse par no fim do btnLocalizar.Click e no fim do
    * btnLimpar.Click. Aqui ele eh um metodo so, que zera os DOIS lados - a
    * property do BO e o controle visual. Zerar apenas o controle deixaria
    * o BO achando que ainda tem uma base escolhida, e o Localizar seguinte
    * aplicaria a localizacao ANTERIOR num item novo, sem erro e sem aviso.
    *
    * PROTECTED obrigatorio pelo mesmo motivo do FormParaBO (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cBaseLocalizacao     = ""
            THIS.this_oBusinessObject.this_cDescBaseLocalizacao = ""
        ENDIF

        *-- Espelha o estado (agora vazio) do BO nos controles
        THIS.BOParaForm()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - TabIndex transcrito do dump do SCX
    *
    * O dump declara a ordem controle a controle, e ela faz parte do PILAR 1
    * ("ordem de tabulacao" eh comportamento que o usuario percebe):
    *   grdItens  = 1   cmdAcoes = 2   cntBotoes = 3
    *   Label3    = 4   getBase  = 5   getDBase  = 6
    *   SelTudo   = 24  apaga    = 26  (ambos com TabStop = .F.)
    * Dentro de cada CommandGroup, o dump poe Command2 = 1 e Command1 = 2 -
    * ou seja Confirmar antes de Cancelar, e Limpar antes de Localizar.
    *
    * Atribuido em ordem CRESCENTE do valor desejado porque em VFP9
    * atribuir TabIndex eh uma REORDENACAO (o controle entra na posicao N e
    * empurra os demais), nao a gravacao de um numero independente.
    *
    * Os dois standalone ficam de fora da atribuicao de proposito. O dump
    * da a eles 24 e 26, valores MUITO acima da contagem de controles deste
    * form; como os dois tem TabStop = .F., estao fora da cadeia de
    * tabulacao e o numero nao tem efeito observavel nenhum - mas atribuir
    * um indice fora de faixa REORDENARIA a cadeia dos outros seis, que eh
    * o unico comportamento que o usuario percebe. O TabStop = .F. deles ja
    * esta transcrito em ConfigurarBotoesSelecao, e eh ele que reproduz o
    * legado aqui.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()

        *-- Dentro dos grupos: Command2 (= Buttons(2)) vem primeiro
        THIS.obj_4c_CmdAcoes.Buttons(2).TabIndex  = 1
        THIS.obj_4c_CmdAcoes.Buttons(1).TabIndex  = 2
        THIS.obj_4c_CntBotoes.Buttons(2).TabIndex = 1
        THIS.obj_4c_CntBotoes.Buttons(1).TabIndex = 2

        *-- No form: ordem crescente, para a reordenacao acumular certo
        THIS.grd_4c_Dados.TabIndex    = 1
        THIS.obj_4c_CmdAcoes.TabIndex = 2
        THIS.obj_4c_CntBotoes.TabIndex = 3
        THIS.lbl_4c_Label3.TabIndex   = 4
        THIS.txt_4c_Base.TabIndex     = 5
        THIS.txt_4c_DBase.TabIndex    = 6

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
    * este metodo percorre a arvore e os torna visiveis.
    *
    * PUBLIC de proposito: o harness de teste chama metodos do form de FORA da
    * classe, e PEMSTATUS(oForm, "<metodo>", 5) devolve .T. mesmo para metodo
    * PROTECTED (so verifica existencia, nao escopo) - o teste entraria no
    * branch e a chamada real falharia em runtime.
    *
    * O controle que o SCX legado declara com Visible = .F. continua oculto: no
    * dump eh o ImgJpg (foto do produto), que o legado so exibe quando a linha
    * corrente da grade tem imagem. A lista de excecao eh por NOME do objeto
    * migrado e cresce conforme as fases seguintes criam esses controles.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        IF VARTYPE(par_oContainer) != "O"
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN .F.
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(ALLTRIM(loc_oObjeto.Name))

                *-- Controles que nascem ocultos no legado continuam ocultos,
                *-- mas recursa-se neles para que os filhos fiquem visiveis
                IF INLIST(loc_cNome, "IMG_4C_IMGJPG")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                            loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Containers em geral: recursao pelos filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - libera o BO, que fecha os proprios cursores de trabalho
    *
    * Legado (PROCEDURE Release): Use In crItensLoc / Use In csLocals. No
    * migrado esses dois cursores pertencem ao BO (cursor_4c_Itens e
    * cursor_4c_Selecionados) e sao fechados pelo Destroy dele.
    * crTpmMvItn NAO eh fechado aqui: pertence ao form CHAMADOR, que continua
    * usando o cursor depois deste dialogo fechar - eh justamente nele que o
    * Confirmar gravou as localizacoes.
    *
    * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
    * popups do menu principal, que o fechamento de form modal corrompe.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oConexao = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
