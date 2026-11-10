*==============================================================================
* FormSigOpNch.prg - Form Operacional: Numeracao de Cheques
* Migrado de: tasks/task770/SigOpNch.SCX  (classe legado SIGOPNCH)
* Business Object: SigOpNchBO  (tabelas SigOpFp / SigSySeq)
*
* Tela de MANUTENCAO do proximo numero de cheque por conta bancaria. Layout
* CUSTOMIZADO - NAO segue o padrao CRUD Page1=Lista/Page2=Dados: o legado nao
* herda de frmcadastro (o objeto raiz do SCX eh um "form" generico) e nao
* declara PageFrame nenhum. Toda a tela eh uma faixa de cabecalho, uma grade
* unica e dois botoes pendurados direto no Form.
*
* O QUE ESTE ARQUIVO ENTREGA
* --------------------------
*   DEFINE CLASS + propriedades visuais transcritas do dump do SCX
*   Init                  -> Caption com CHR() + delegacao ao FormBase
*   ValidarParametros     -> a guarda de conexao do Init legado
*                            (If Not .poDatamgr.pnIdconn>0 / Messagebox /
*                             Return .f.), com bypass de teste/validacao
*   InicializarForm       -> instancia o BO, pinta o fundo, cria o cursor da
*                            grade (o PROCEDURE Load legado), monta a tela na
*                            ORDEM do dump e dispara a carga
*   ConfigurarCabecalho   -> cnt_4c_Sombra + os dois labels (cntSombra do
*                            legado), com o Caption propagado como no Init
*   ConfigurarDecoracao   -> shp_4c_Shape1, a moldura transparente do SCX
*   ConfigurarGrade       -> grd_4c_Dados, 5 colunas (SIGOPNCH.Grade)
*   ConfigurarBotoesAcao  -> cmd_4c_Confirmar (btnAlterar do dump) e
*                            cmd_4c_Encerrar (btnCancelar), soltos no Form
*   CarregarLista         -> funil para CarregarGrade
*   CarregarGrade         -> a carga do Init legado (via BO.CarregarDados) e
*                            o vinculo da grade ao cursor do BO
*   BtnConfirmarClick     -> SIGOPNCH.btnAlterar.Click - ACIONA a gravacao em
*                            SigSySeq (via BO.GravarNumeracao) e encerra
*   BtnEncerrarClick      -> SIGOPNCH.btnCancelar.Click - ThisForm.Release
*   Activate              -> o ".Column5.SetFocus" do fim do Init legado
*   TornarControlesVisiveis -> AddObject nasce com Visible = .F.
*   Destroy               -> libera o BO e delega ao FormBase
*
* Esta FASE FINAL acrescenta os eventos auxiliares que faltavam - a validacao
* da CELULA do proximo cheque (SIGOPNCH.Grade.Column5.Text1.Valid + When), que
* eh quem MARCA a linha como alterada e portanto quem decide o que o Confirmar
* grava. Ela nao eh evento de botao: pela regra #46 mora no Valid de um TextBox
* instalado na Column (Column.AddObject + CurrentControl + Sparse = .F.), nunca
* em AfterRowColChange - cujo nColIndex eh a coluna de DESTINO e que, por isso,
* validaria a linha para onde o usuario FOI, nao a que ele editou:
*
*   TextBoxChequeSigOpNch_4c -> subclasse de TextBox com When/Valid EMBUTIDOS,
*                            definida no fim deste arquivo e instalada na
*                            Column5, a unica celula editavel da tela
*   InstalarCelulaCheque  -> AddObject + CurrentControl + Sparse = .F. na
*                            Column5; refeito a cada rebind da grade, porque
*                            mexer em RecordSource RECRIA os objetos Column e
*                            leva junto o controle instalado
*   CelulaChequeWhen      -> SIGOPNCH.Grade.Column5.Text1.When - guarda o valor
*                            anterior em this_nAntChqVal
*   CelulaChequeValid     -> SIGOPNCH.Grade.Column5.Text1.Valid - recusa numero
*                            invalido (restaura e devolve 0, o que PRENDE o
*                            foco na celula) e MARCA a linha quando o numero
*                            mudou. Fecha o circuito da gravacao: sem ele nada
*                            escreve Marcas, o "Scan For Marcas" do BO nao
*                            acha linha e o Confirmar encerraria sem gravar
*   FormParaBO            -> linha corrente da grade + valor DIGITADO -> BO
*   BOParaForm            -> BO -> celula; eh o "This.Value = nAntChqVal" do
*                            legado, com o BO como FONTE UNICA do numero em
*                            vez de a UI guardar regra propria (PILAR 3)
*   BtnCancelarClick      -> segundo nome de entrada do MESMO Click de
*                            SIGOPNCH.btnCancelar (ver o comentario do metodo)
*
* Deliberadamente AUSENTES - o legado nao tem a superficie, e cria-los seria
* inventar (viola o PILAR 1) ou escrever metodo vazio (proibido pela regra de
* completude):
*   PageFrame / paginas e a navegacao entre elas -> o SCX nao declara nenhum
*       objeto de BaseClass pageframe; nao ha Lista/Dados a alternar
*   modos INCLUIR/ALTERAR/VISUALIZAR e habilitacao de campos por modo -> a
*       tela tem UM estado unico: as quatro primeiras celulas da grade tem
*       When -> .f. no legado e a quinta eh sempre editavel
*   containers de botao -> no SCX os dois CommandButton (btnAlterar/
*       btnCancelar) penduram DIRETO no Form, sem container agrupador
*   HabilitarCampos / LimparCampos / AjustarBotoesPorModo -> nomes de form
*       CRUD, que governam campos por MODO. Esta tela nao tem modo, seu unico
*       campo editavel esta SEMPRE habilitado e a grade eh recarregada do
*       banco a cada abertura pela propria CarregarGrade
*   BtnBuscarClick / BtnSalvarClick / BtnIncluirClick e irmaos -> o SCX
*       declara DOIS CommandButton, e nenhum deles eh busca ou CRUD; o que
*       grava eh o Confirmar, ja entregue como BtnConfirmarClick
*
* poDataMgr do legado (CreateObject('fSqlConector',...) + AddCursor/Requery/
* UpDate/Commit/RollBack) NAO tem equivalente aqui de proposito (PILAR 3): o
* acesso a dados mora no SigOpNchBO / DataAccess.
*==============================================================================

DEFINE CLASS FormSigOpNch AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais TRANSCRITAS do dump (SECAO 2, "PROPRIEDADES DE:
    * SIGOPNCH"). Caption fica no Init porque leva acento e esta classe nao
    * pode ter literal acentuado (regra #4).
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Height       = 370
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowTips     = .T.
    ClipControls = .F.
    ControlBox   = .F.
    Closable     = .F.
    TitleBar     = 0

    *-- MaxButton/MinButton = .F. acompanham TitleBar = 0 + ControlBox = .F.:
    *-- sem barra de titulo nao ha onde desenhar os botoes, e o FormBase os
    *-- declara .T.. Nao eh invencao de UX - eh coerencia com o dump, que
    *-- tambem nao os declara justamente porque ficaram irrelevantes.
    MaxButton    = .F.
    MinButton    = .F.

    *-- DataSession = 2 TRANSCRITO do dump: os cursores desta tela (as formas
    *-- de pagamento, a sequencia de numeros e a propria grade) vivem numa
    *-- sessao privada, como no legado. FormBase.Init repoe SET DATE BRITISH /
    *-- CENTURY ON / SAFETY OFF, que a sessao privada reseta para o default do
    *-- VFP (regra #9.4) - por isso Init() DEVE chamar DODEFAULT().
    DataSession  = 2

    FontName     = "Tahoma"
    FontSize     = 8

    *-- Dialogo modal top-level, como o legado (TitleBar = 0, Closable = .F.,
    *-- aberto pelo menu e sem barra onde fechar)
    WindowType   = 1
    ShowWindow   = 1

    *--------------------------------------------------------------------------
    * this_nAntChqVal - equivalente a ThisForm.nAntChqVal do legado (declarada
    * em RESERVED3/ClassInfo e zerada no Init). Guarda o numero de cheque que
    * a celula tinha ANTES da digitacao: o When da coluna do numero grava nela
    * (Thisform.nAntChqVal = This.Value) e o Valid a usa para restaurar o
    * valor quando a digitacao eh invalida e para decidir se a linha foi de
    * fato alterada. Declarada nesta fase porque eh estado da classe; quem a
    * le e escreve entra com a grade, na fase seguinte.
    *--------------------------------------------------------------------------
    this_nAntChqVal = 0

    *--------------------------------------------------------------------------
    * this_lFocoInicialDado - trava de uma-vez-so para o foco inicial.
    *
    * O Init legado termina com "With ThisForm.Grade / .Refresh /
    * .Column5.SetFocus / EndWith", isto eh, a tela abre com o cursor
    * piscando na coluna do proximo cheque - a UNICA coluna digitavel. Esse
    * SetFocus NAO pode sair do InicializarForm: ele roda ANTES do Show e o
    * VFP recusa foco em controle de form que ainda nao apareceu. O lugar
    * certo eh o Activate, que dispara a cada volta de foco a tela - esta
    * flag eh o que faz o foco ser dado so na PRIMEIRA vez, para nao
    * sequestrar o cursor do usuario toda vez que ele dispensa um dialogo.
    *--------------------------------------------------------------------------
    this_lFocoInicialDado = .F.

    *--------------------------------------------------------------------------
    * Init - define o Caption (acentos via CHR(), regra #4) e delega ao
    * FormBase, que chama InicializarForm.
    *
    * Apenas Caption + DODEFAULT(): chamar THIS.InicializarForm() aqui faria a
    * montagem rodar DUAS vezes e o segundo AddObject estouraria "a member
    * object with this name already exists".
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Numera" + CHR(231) + CHR(227) + "o de Cheques"

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - a guarda de conexao do Init legado:
    *
    *   .poDatamgr = CreateObject('fSqlConector', thisform.Name)
    *   If Not .poDatamgr.pnIdconn > 0
    *       Messagebox('Impossivel Efetuar Conexao com Servidor de Banco de
    *                   Dados.', (0+48), 'Erro')
    *       Return(.f.)
    *   Endif
    *
    * PUBLIC de proposito: o harness TesteAutomatico.prg alcanca metodos do
    * form de FORA da classe, e PROTECTED falharia em runtime (regra #3).
    *
    * O bypass de teste/validacao vem ANTES da checagem: TesteAutomatico.prg
    * define gnConnHandle = 0 como SENTINELA (nao tenta conexao real, para nao
    * pagar o timeout TCP), e ValidarUIFidelity.prg define gnConnHandle = -1.
    * Sem o bypass, a guarda devolveria .F. SEMPRE nessas etapas, o
    * InicializarForm devolveria .F. e CREATEOBJECT("FormSigOpNch") devolveria
    * .F. em vez de objeto - reprovando a instanciacao por um erro que nao
    * existe.
    *--------------------------------------------------------------------------
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
                        "o com Servidor de Banco de Dados.", "Erro")
                loc_lValido = .F.

            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                        "o com Servidor de Banco de Dados.", "Erro")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base deste form OPERACIONAL.
    *
    * NAO existe "IF gb_4c_ValidandoUI / RETURN" no topo: esse gate pularia a
    * montagem visual inteira e tornaria qualquer diferenca de UI Fidelity
    * irrecuperavel, porque o metodo que escreve a propriedade nunca rodaria
    * durante a validacao. O bypass de SQL/rede fica onde o SQL esta - aqui,
    * nesta fase, nada depende de rede: o cabecalho eh AddObject puro e o
    * cursor da grade eh CREATE CURSOR local.
    *
    * O RETURN da guarda fica FORA de qualquer TRY (regra #1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Equivalente a Thisform.nAntChqVal = 0 do Init legado
            THIS.this_nAntChqVal = 0

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpNchBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio " + ;
                        "SigOpNchBO.", "Erro em InicializarForm")
            ELSE
                *-- Picture = ..\framework\imagens\new_background.jpg no dump.
                *-- No sistema novo a imagem vive em vbmp\, resolvida por
                *-- gc_4c_CaminhoIcones - nunca reconstruir o caminho a partir
                *-- de gc_4c_CaminhoBase (regra do Pattern #156/#170).
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarCabecalho()

                *-- Equivalente literal as duas primeiras linhas do Init
                *-- legado:
                *--   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
                *--   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Equivalente ao PROCEDURE Load legado, que roda ANTES do
                *-- Init e cria o cursor da grade:
                *--   Create Cursor csCheques (FPags C(12), Bancos C(3),
                *--       Agencias C(4), NContas C(10), Cheques N(6),
                *--       Marcas L(1))
                *--   Index On Fpags Tag FPags
                *-- Mora no BO (SigOpNchBO.CriarCursorCheques, que transcreve
                *-- essa estrutura campo a campo) e eh criado JA NESTA FASE
                *-- porque a grade da fase seguinte liga ControlSource nele -
                *-- e ControlSource de cursor inexistente derruba o Init
                *-- inteiro com "Alias not found" (regra #41).
                *--
                *-- A outra metade do Load legado, =fConfigGeral(), nao se
                *-- reproduz: na arquitetura nova a configuracao global ja
                *-- aconteceu em config.prg/main.prg, e utils\fconfiggeral.prg
                *-- eh um no-op que existe APENAS para o p-code dos VCX legado.
                IF !THIS.this_oBusinessObject.CriarCursorCheques()
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel preparar a grade de cheques.", ;
                            "Erro em InicializarForm")
                ELSE
                    *-- Ordem dos AddObject = ordem dos objetos no dump
                    *-- (cntSombra -> Shape1 -> Grade -> btnAlterar ->
                    *-- btnCancelar). Nao eh estetica, sao duas regras de
                    *-- z-order: Shape1 eh BackStyle = 0 / BorderStyle = 0,
                    *-- ou seja uma caixa TRANSPARENTE de 173x110 - criada
                    *-- depois da grade ou dos botoes, bloquearia o clique de
                    *-- quem ficasse por baixo (mesma armadilha da caixa
                    *-- larga de Label, regra #23); e o cabecalho, criado em
                    *-- ConfigurarCabecalho logo acima, COBRIRIA os dois
                    *-- botoes se viesse depois, porque eles ficam em
                    *-- Top = 3..78, dentro da faixa de 80px (regra #11).
                    THIS.ConfigurarDecoracao()
                    THIS.ConfigurarGrade()
                    THIS.ConfigurarBotoesAcao()

                    *-- AddObject cria todo controle com Visible = .F.
                    THIS.TornarControlesVisiveis(THIS)

                    *-- Carga DEPOIS de tornar visivel: Refresh em controle
                    *-- invisivel nao pinta (regra #21/#46), e a grade ficaria
                    *-- vazia com o cursor cheio.
                    *--
                    *-- O retorno NAO aborta a abertura: grade sem linha eh
                    *-- estado legitimo (nenhuma forma de pagamento tipo
                    *-- cheque com conta bancaria configurada) e o BO ja
                    *-- exibiu a falha, se houve SQL que falhou - o form
                    *-- continua utilizavel para fechar.
                    THIS.CarregarLista()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (cntSombra do legado) com os
    * dois labels sobrepostos que formam o titulo com sombra: lbl_4c_LblSombra
    * (preto, Top = 18) desenhado PRIMEIRO e lbl_4c_LblTitulo (branco,
    * Top = 17) por cima, deslocado 1px - a ordem dos AddObject eh o que
    * produz o efeito; invertida, o titulo branco ficaria por baixo.
    *
    * Dump (SIGOPNCH.cntSombra): Top = 0, Left = 0, Width = 804, Height = 80,
    * BorderWidth = 0, BackColor = 100,100,100.
    *
    * Width = THIS.Width (800) em vez do literal 804: o Form Designer desenhou
    * o container 4px MAIS LARGO que a propria janela (SIGOPNCH.Width = 800),
    * artefato ja catalogado - container de cabecalho nunca fica hardcoded
    * diferente do form (regra #11/#88/#89). Os labels, ao contrario, cabem na
    * area visivel (Left 10 + Width 769 = 779 < 800) e por isso ficam com o
    * literal do dump, sem risco de serem recortados (regra #30).
    *
    * BackStyle = 1 explicito: a faixa precisa ser OPACA para o cinza
    * RGB(100,100,100) aparecer por tras do titulo branco; transparente, o
    * cabecalho sumiria sobre o fundo claro do form.
    *--------------------------------------------------------------------------
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
        ENDWITH

        *-- FontSize 18 TRANSCRITO do dump (lblSombra/lblTitulo declaram
        *-- FontSize = 18). O 16 da tabela canonica da regra #11 vale para a
        *-- faixa INJETADA nas Pages de form CRUD, nao para o cntSombra que
        *-- este OPERACIONAL transcreve do proprio SCX.
        *--
        *-- AutoSize = .F. explicito com Width E Height do dump: em Label
        *-- criado por AddObject o auto-size fica ADIADO ate o controle ficar
        *-- visivel, e com WordWrap = .T. ele DESCARTA a Height e colapsa o
        *-- texto para uma linha (regra #23). Os 769x40 / 769x46 do SCX JA SAO
        *-- o auto-size que o Form Designer calculou - fixa-los eh reproducao
        *-- fiel, nao desvio do PILAR 1.
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
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        *-- ToolTipText = "Titulo do Relatorio" TRANSCRITO do dump (o texto eh
        *-- da classe de cabecalho reusada pelo Framework legado, nao deste
        *-- form - mas eh o que o usuario ve ao parar o mouse sobre o titulo).
        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize      = .F.
            .Top           = 17
            .Left          = 10
            .Width         = 769
            .Height        = 46
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255, 255, 255)
            .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados por AddObject (que nascem com Visible = .F.).
    *
    * SEM lista de excecao: este form nao tem container flutuante nem controle
    * que o SCX declare Visible = .F. - todos os objetos do dump sao visiveis.
    * Se alguma fase seguinte acrescentar controle que nasce oculto, o nome
    * dele tem de ser filtrado aqui, senao esta varredura o expoe.
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
    * ConfigurarDecoracao - shp_4c_Shape1 (SIGOPNCH.Shape1 do dump).
    *
    * Dump: Top = 7, Left = 612, Width = 173, Height = 110, BackStyle = 0,
    * BorderStyle = 0, BorderColor = 136,189,188.
    *
    * Com BackStyle = 0 (sem preenchimento) E BorderStyle = 0 (sem traco) a
    * figura nao DESENHA nada, e o BorderColor fica inerte: eh moldura morta
    * que o Form Designer deixou no SCX atras dos dois botoes. Esta aqui por
    * fidelidade (PILAR 1) - omitida, o ValidarUIFidelity acusa objeto
    * ausente -, e por isso mesmo nao se "conserta" dando borda a ela.
    *
    * BorderColor transcrito mesmo sem efeito visivel porque a propriedade
    * EXISTE em Shape; ForeColor eh que NAO existe (regra #33), e por isso
    * nao aparece aqui - o dump do legado tambem nunca a declara.
    *
    * Left 612 + Width 173 = 785 < 800 (Form.Width) e Top 7 + Height 110 =
    * 117 < 370: a figura cabe inteira na area visivel, nao ha recorte
    * (regra #30).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDecoracao()
        THIS.AddObject("shp_4c_Shape1", "Shape")

        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 612
            .Width       = 173
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grd_4c_Dados (SIGOPNCH.Grade do dump, classe fwgrade
    * de framework.vcx): a UNICA lista da tela. Uma linha por forma de
    * pagamento tipo cheque com conta bancaria, e o proximo numero de cheque
    * editavel na ultima coluna.
    *
    * Dump (SIGOPNCH.Grade): ColumnCount = 5, Top = 104, Left = 183,
    * Width = 434, Height = 238, RowHeight = 16, FontName = "Tahoma",
    * FontSize = 8. As cinco larguras do dump (123 + 35 + 55 + 80 + 105)
    * somam 398 e cabem nos 434 do grid.
    *
    * SO a estrutura visual: RecordSource/ControlSource ficam em
    * CarregarGrade, unico ponto de vinculo. Nao eh preferencia de
    * organizacao - mexer em RecordSource RECRIA os objetos Column e devolve
    * Width ao default 90, zera Header1.Caption e faz o ReadOnly da coluna
    * voltar a herdar o do Grid (Problema 48 do FormCor), entao o que fosse
    * ligado aqui se perderia na primeira carga.
    *
    * O .ReadOnly do GRID vem ANTES do das colunas: o do grid PROPAGA e
    * sobrescreveria o delas. .F. aqui porque a Column5 (proximo cheque) eh
    * editavel no legado; as outras quatro recebem .ReadOnly = .T., que eh
    * como o dump as declara.
    *
    * Essas quatro trazem a MESMA intencao dita duas vezes no legado:
    * Column.ReadOnly = .T. no dump E um When devolvendo .f. no Text1.
    * Reproduzida pelo ReadOnly da coluna e do Text1 - nao ha metodo When a
    * portar, porque ele nao faz nada alem de recusar o foco.
    *
    * DeleteMark/RecordMark = .F. sao obrigatorios em grade de form
    * OPERACIONAL (sem eles aparecem as barras de marcacao na lateral
    * esquerda, que o legado nao tem). As cores e o HighlightStyle vem da
    * classe fwgrade, que NAO existe nesta arquitetura: aqui o objeto eh um
    * Grid puro, logo o que a classe dava de graca tem de ser escrito
    * (valores em docs/framework_frmcadastro_layout.md). Ja o FontName
    * "Tahoma" do dump PREVALECE sobre o "Verdana" canonico - eh override
    * explicito do proprio SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top                = 104
            .Left               = 183
            .Width              = 434
            .Height             = 238
            .ColumnCount        = 5
            .FontName           = "Tahoma"
            .FontSize           = 8
            .RowHeight          = 16
            .ScrollBars         = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            *-- ANTES das colunas: Grid.ReadOnly propaga para elas
            .ReadOnly           = .F.
        ENDWITH

        *-- Column1 "Forma de Pagamento" (csCheques.FPags -> SigOpFp.fpags,
        *-- char(12)) - travada no legado
        WITH THIS.grd_4c_Dados.Column1
            .Width     = 123
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Forma de Pagamento"
            .ForeColor = RGB(36, 84, 155)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column1.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 "Bco." (csCheques.Bancos -> SigOpFp.bancos, char(3)) -
        *-- travada no legado
        WITH THIS.grd_4c_Dados.Column2
            .Width     = 35
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Bco."
            .ForeColor = RGB(36, 84, 155)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column2.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 "Agencia" (csCheques.Agencias -> SigOpFp.agencias,
        *-- char(4)) - travada no legado
        WITH THIS.grd_4c_Dados.Column3
            .Width     = 55
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Ag" + CHR(234) + "ncia"
            .ForeColor = RGB(36, 84, 155)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column3.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 "Conta" (csCheques.NContas -> SigOpFp.ncontas,
        *-- char(10)) - travada no legado
        WITH THIS.grd_4c_Dados.Column4
            .Width     = 80
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Conta"
            .ForeColor = RGB(36, 84, 155)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column4.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Proximo Chq." (csCheques.Cheques, N(6)) - a UNICA
        *-- coluna editavel: o dump NAO declara ReadOnly nela, e eh o unico
        *-- Text1 do form com Valid/When (a validacao do numero e a guarda
        *-- do valor anterior, que entram na fase de eventos).
        *--
        *-- InputMask = "999999" TRANSCRITO do dump: define o que o usuario
        *-- consegue digitar e, por consequencia, o que eh GRAVADO - nunca
        *-- descartar (regra #49). Casa com Cheques N(6) do cursor e com
        *-- SigSySeq.conteudo numeric(13,0) no destino.
        WITH THIS.grd_4c_Dados.Column5
            .Width     = 105
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Dados.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Pr" + CHR(243) + "ximo Chq."
            .ForeColor = RGB(36, 84, 155)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column5.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .InputMask   = "999999"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - os dois CommandButton que o legado pendura
    * DIRETO no Form (SIGOPNCH.btnAlterar e SIGOPNCH.btnCancelar, classe
    * fwbtng): Confirmar, que grava, e Encerrar, que fecha. NAO existe
    * container agrupador no SCX e nao se inventa um - esta tela nao tem
    * cnt_4c_Botoes/cnt_4c_Saida, que sao do padrao CRUD.
    *
    * Pela mesma razao NAO ha aqui os cinco botoes CRUD (Incluir/Visualizar/
    * Alterar/Excluir/Buscar): o legado nao tem nenhum deles, nao tem modo
    * de edicao e nao tem par de paginas Lista/Dados a alternar - a tela
    * inteira eh a grade mais estes dois botoes. Acrescenta-los seria
    * inventar superficie que o usuario nunca viu (viola o PILAR 1), e
    * dar-lhes corpo vazio seria o stub disfarcado que a regra de
    * completude proibe.
    *
    * Dump: btnAlterar Top = 3, Left = 650, Picture =
    * cadastro_salvar_60.jpg, Caption = "\<Confirmar"; btnCancelar Top = 3,
    * Left = 725, Picture = cadastro_sair_60.jpg, Cancel = .T.,
    * Caption = "Encerrar".
    *
    * Width/Height nao aparecem no dump porque vem da classe fwbtng (75x75,
    * docs/framework_frmcadastro_layout.md) - e a aritmetica do proprio dump
    * confirma: 650 + 75 = 725, o Left exato do botao seguinte, e
    * 725 + 75 = 800 = Form.Width. Fonte, cores, SpecialEffect,
    * PicturePosition e MousePointer tem a mesma origem; com CommandButton
    * puro no lugar da classe, o que ela dava de graca tem de ser escrito.
    *
    * Themes = .T. + DisabledPicture: CommandButton SOLTO (fora de
    * CommandGroup) com .Picture NAO desenha o icone quando Themes = .F. e
    * Enabled = .F. - o botao viraria um retangulo com so o texto
    * (Pattern #99). Botao DENTRO de CommandGroup, ao contrario, mantem
    * Themes = .F.
    *
    * O Caption "\<Confirmar" eh transcrito COM o "\<": aquilo eh o marcador
    * de tecla de atalho do VFP (ALT+C), nao lixo do dump - retira-lo
    * mataria o atalho que o usuario usa hoje.
    *
    * Cancel = .T. no Encerrar tambem eh transcricao, e nao detalhe: eh ele
    * que faz o ESC fechar a tela. Como o form tem TitleBar = 0 /
    * ControlBox = .F. / Closable = .F., este botao eh a UNICA saida, e sem
    * o Cancel o ESC ficaria morto.
    *
    * NOME PELA ACAO, nunca pelo Name do objeto legado. O SCX chama o primeiro
    * botao de "btnAlterar", mas o Caption que o usuario le eh "\<Confirmar" e
    * o corpo do Click GRAVA (UpDate + Commit em crAutoriza) e encerra a tela:
    * o Name legado MENTE, igual ao "btnSair" que gravava no SIGMVVDE. Por
    * isso os objetos sao cmd_4c_Confirmar / cmd_4c_Encerrar e os handlers
    * BtnConfirmarClick / BtnEncerrarClick - herdar o nome do legado violaria
    * o PILAR 3 (nomes do migrado obrigatoriamente diferentes) e esconderia de
    * quem le que este botao eh o UNICO ponto de gravacao da tela.
    *
    * E ele nao eh o "Alterar" da barra CRUD do frmcadastro: aquele troca o
    * form para o modo de edicao, este COMMITA e fecha. Esta tela nao tem modo
    * (o dump nao tem pcEscolha), nao tem par de paginas Lista/Dados e nao tem
    * irmao Incluir/Visualizar/Excluir algum.
    *
    * BINDEVENT so AGORA, com os dois handlers ja escritos mais abaixo: bind
    * apontando para metodo inexistente estoura no PROPRIO BINDEVENT, dentro
    * do Init, e a tela nao abriria. Os handlers sao PUBLIC (sem PROTECTED) -
    * com metodo PROTECTED o BINDEVENT falha em SILENCIO (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()

        *-- btnAlterar (fwbtng) - "Confirmar": grava as linhas marcadas
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Confirmar"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- btnCancelar (fwbtng) - "Encerrar": fecha a tela sem gravar
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - funil UNICO de carga e vinculo da grade. Transcreve o
    * trecho final do Init legado:
    *
    *   (o Scan que monta csCheques - hoje SigOpNchBO.CarregarDados)
    *   Select csCheques
    *   Go Top
    *   With ThisForm.Grade
    *       .Refresh
    *       .Column5.SetFocus
    *   EndWith
    *
    * Ordem OBRIGATORIA: RecordSource -> ControlSource -> Width ->
    * Header1.Caption -> ReadOnly da coluna. Mexer em RecordSource RECRIA os
    * objetos Column: a Width volta ao default 90, o Header1.Caption eh
    * zerado e o ReadOnly da coluna volta a herdar o do Grid - por isso os
    * tres sao reaplicados AQUI, e nao apenas em ConfigurarGrade
    * (Problema 48 do FormCor). O InputMask da coluna editavel entra na
    * mesma lista por ser FUNCIONAL: perdido, o campo passaria a aceitar
    * mais de 6 digitos (regra #49).
    *
    * RecordSource fica FORA do WITH do grid: dentro do MESMO WITH que
    * acabou de atribui-lo, acessar .Column1 estoura "Unknown member
    * COLUMN1", porque os objetos acabaram de ser recriados.
    *
    * O SetFocus do legado NAO vem para ca: InicializarForm roda ANTES do
    * Show e o VFP recusa foco em controle de form que ainda nao apareceu.
    * Ele mora no Activate, guardado por this_lFocoInicialDado.
    *
    * PUBLIC de proposito (regras #3/#51): o harness de teste chama
    * CarregarLista/CarregarGrade de FORA da classe, e PEMSTATUS(...,5)
    * devolve .T. tambem para metodo PROTECTED - o teste entraria no branch
    * e a chamada falharia em runtime.
    *
    * Bypass de SQL em modo teste/ValidarUIFidelity: CarregarDados do BO faz
    * SQLEXEC em SigOpFp/SigSySeq, inalcancavel em instanciacao headless. A
    * grade fica com a estrutura montada e LIGADA ao cursor vazio que
    * InicializarForm criou - basta para a validacao de UI, e em nenhum
    * cenario a grade fica sem RecordSource (grade sem RecordSource vira um
    * retangulo branco, sem cabecalho e sem coluna).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_cCursor, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                               (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

            IF !loc_lBypassTeste
                THIS.this_oBusinessObject.CarregarDados()
            ENDIF

            IF USED(loc_cCursor)
                *-- FORA do WITH (ver cabecalho): recria os objetos Column
                THIS.grd_4c_Dados.RecordSource = loc_cCursor

                *-- Mapeamento coluna -> campo transcrito do dump, que liga
                *-- por csCheques.<campo>; aqui pelo cursor do BO, que
                *-- reproduz a MESMA estrutura campo a campo
                *-- (SigOpNchBO.CriarCursorCheques)
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = loc_cCursor + ".FPags"
                    .Column2.ControlSource = loc_cCursor + ".Bancos"
                    .Column3.ControlSource = loc_cCursor + ".Agencias"
                    .Column4.ControlSource = loc_cCursor + ".NContas"
                    .Column5.ControlSource = loc_cCursor + ".Cheques"
                ENDWITH

                *-- Marcas (L(1), 6o campo do cursor) NAO ganha coluna: o
                *-- legado tem ColumnCount = 5 e usa Marcas apenas como flag
                *-- interna de "linha tocada pelo usuario", lida pelo
                *-- Confirmar. Uma 6a coluna exporia na tela um controle que
                *-- o legado nao tem.

                WITH THIS.grd_4c_Dados
                    .Column1.Width = 123
                    .Column2.Width = 35
                    .Column3.Width = 55
                    .Column4.Width = 80
                    .Column5.Width = 105

                    .Column1.Header1.Caption = "Forma de Pagamento"
                    .Column2.Header1.Caption = "Bco."
                    .Column3.Header1.Caption = "Ag" + CHR(234) + "ncia"
                    .Column4.Header1.Caption = "Conta"
                    .Column5.Header1.Caption = "Pr" + CHR(243) + "ximo Chq."

                    *-- Reafirma, DEPOIS do RecordSource, a unica regra de
                    *-- edicao do legado: so a coluna do proximo cheque
                    *-- aceita digitacao. As outras quatro declaram
                    *-- ReadOnly = .T. no dump e um When devolvendo .f. no
                    *-- Text1.
                    .Column1.ReadOnly = .T.
                    .Column2.ReadOnly = .T.
                    .Column3.ReadOnly = .T.
                    .Column4.ReadOnly = .T.
                    .Column5.ReadOnly = .F.

                    *-- InputMask do dump: funcional, limita o que eh
                    *-- digitado e, por consequencia, gravado
                    .Column5.Text1.InputMask = "999999"
                    .Column5.Text1.ReadOnly  = .F.
                ENDWITH

                *-- A celula COM EVENTO da Column5 vai AQUI, depois do
                *-- RecordSource: ele RECRIA os objetos Column e levaria
                *-- junto qualquer controle instalado antes (por isso o
                *-- metodo eh idempotente e roda em TODA carga, nao uma vez
                *-- so no InicializarForm).
                THIS.InstalarCelulaCheque(THIS.grd_4c_Dados)

                *-- Legado: "Select csCheques / Go Top" ANTES do
                *-- "Grade.Refresh" - popular o cursor nao repinta a grade
                *-- sozinho (regra #21a), e sem o Go Top a linha corrente
                *-- ficaria onde o Scan do BO a deixou
                SELECT (loc_cCursor)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - nome canonico de carga do projeto; funil unico para
    * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness de teste chama de
    * fora da classe - regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - transcricao de SIGOPNCH.btnAlterar.Click, o UNICO
    * ponto de gravacao desta tela.
    *
    * Legado, na ordem:
    *
    *   Select csCheques
    *   Scan For Marcas
    *       If !IsEmpty(csCheques.Cheques)
    *           lcChave = PADR(Bancos + Agencias + NContas, 25)
    *           Locate em crAutoriza For valor = lcChave
    *             achou     -> Replace Conteudo With csCheques.Cheques - 1
    *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
    *                          Values (lcChave, csCheques.Cheques - 1)
    *       Endif
    *   EndScan
    *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
    *   If Not m.lnErro1 > 0
    *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.', 48)
    *   EndIf
    *   ThisForm.Release
    *
    * O LACO, a chave POSICIONAL de 25 (regra #42), o "- 1", o
    * update-ou-insert e a transacao (UpDate/Commit/RollBack) vivem INTEIROS
    * em SigOpNchBO.GravarNumeracao - o poDataMgr do legado nao se reproduz
    * aqui de proposito (PILAR 3): o acesso a dados mora no BO/DataAccess.
    * Este handler eh o GATILHO, e isso eh tudo o que ele faz.
    *
    * NAO ha "Valid da celula" a chamar antes: ao clicar o botao (ou disparar
    * o ALT+C do Caption) o foco SAI da Column5, e o VFP roda o Valid dela
    * ANTES do Click - era assim que o legado contava com a linha ja marcada.
    * Forcar um SetFocus aqui seria inventar passo que o legado nao tem.
    *
    * A mensagem de erro eh a do legado, LITERAL, e so aparece quando o BO
    * ainda nao exibiu nada (regra #20: GravarNumeracao ja reporta a falha e
    * marca this_lErroExibido - sem a guarda o usuario levaria o mesmo erro
    * duas vezes).
    *
    * O Release eh INCONDICIONAL, como no legado: la o "ThisForm.Release" eh a
    * ultima linha do Click, FORA de qualquer IF, logo a tela encerra mesmo
    * quando a gravacao falhou - o dialogo de erro aparece ANTES. Manter a
    * tela aberta depois do erro seria comportamento NOVO (viola o PILAR 1),
    * por mais tentador que pareca. E ele fica FORA do TRY, com a chamada do
    * BO dentro: nada de RETURN/saida dentro de TRY/CATCH (regra #1), e o
    * encerramento precisa valer tambem no caminho do CATCH.
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT, que falha em SILENCIO com
    * metodo PROTECTED (regra #3), e metodo chamado de fora da classe nunca
    * pode ser protegido (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cCursor, loc_lGravou, loc_oErro

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
            loc_lGravou = THIS.this_oBusinessObject.GravarNumeracao(loc_cCursor)

            IF !loc_lGravou AND !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados " + ;
                        "do Cadastro de Opera" + CHR(231) + CHR(245) + "es.", ;
                        "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.BtnConfirmarClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - transcricao de SIGOPNCH.btnCancelar.Click, que eh uma
    * linha so:
    *
    *   ThisForm.Release
    *
    * Nada mais: o legado NAO pergunta "descartar as alteracoes?" e NAO
    * desfaz nada. As edicoes vivem no cursor LOCAL csCheques, que morre junto
    * com a tela, entao fechar JA eh o descarte - e inventar uma confirmacao
    * que o usuario nunca viu violaria o PILAR 1.
    *
    * Release, e nao Hide: este form eh de topo, aberto pelo menu, e nao
    * devolve resultado a chamador nenhum - Hide so se aplica a dialogo filho
    * cujo pai le algo depois de fechar.
    *
    * Sem TRY/CATCH: o corpo eh uma unica chamada sem caminho de falha a
    * tratar, e um CATCH aqui jogaria um dialogo de erro em cima de uma tela
    * que o usuario acabou de mandar fechar.
    *
    * Este eh tambem o destino do ESC - cmd_4c_Encerrar tem Cancel = .T.
    * (transcrito do dump) - e, com TitleBar = 0 / ControlBox = .F. /
    * Closable = .F., eh a UNICA saida da tela.
    *
    * PUBLIC pelo mesmo motivo do irmao (alvo de BINDEVENT - regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * InstalarCelulaCheque - poe TextBoxChequeSigOpNch_4c na Column5, a UNICA
    * celula que o legado dota de evento (Valid + When). As outras quatro
    * colunas seguem com o Text1 nativo: o dump so lhes da "When / Return .f.",
    * que eh recusa de foco - ja reproduzida pelo ReadOnly da coluna e do Text1
    * em ConfigurarGrade. Instalar celula nelas seria acrescentar superficie
    * que o legado nao tem (PILAR 1).
    *
    * As TRES linhas finais sao obrigatorias JUNTAS (regra #18):
    *     AddObject      - cria o objeto, mas a coluna segue desenhando o Text1
    *     CurrentControl - eh o que faz a coluna DESENHAR o novo controle
    *     Sparse = .F.   - senao ele so aparece na linha ATIVA
    * Faltando o CurrentControl, o controle existe, responde a PEMSTATUS e
    * NUNCA aparece - e o Valid nunca roda, sem erro e sem log.
    *
    * Column.ReadOnly por ULTIMO: o ReadOnly do GRID propaga para as colunas e
    * sobrescreveria este (regra #18).
    *
    * As propriedades de Text1 do dump sao REAPLICADAS aqui porque
    * ConfigurarGrade as escreveu no .Text1, que nesta coluna deixou de ser o
    * controle exibido - sem repetir, a celula sairia com borda, margem e fonte
    * diferentes das outras quatro. O InputMask = "999999" entra na lista por
    * ser FUNCIONAL: a mascara da COLUNA nao chega ao TextBox instalado, e
    * perdida ela o campo passaria a aceitar mais de 6 digitos (regra #49).
    *
    * IDEMPOTENTE (guard PEMSTATUS): eh chamado de CarregarGrade, que roda em
    * toda carga, e AddObject com nome repetido estoura "Object ... is already
    * defined" e derrubaria a tela.
    *
    * O .Value = 0 so na CRIACAO: nascido assim o controle eh NUMERICO desde o
    * inicio (TextBox nasce com .Value = "" caractere, e o When compararia
    * tipos diferentes). Na reinstalacao ele NAO se repete - ali o controle ja
    * eh o CurrentControl da coluna, logo esta ligado ao ControlSource, e
    * atribuir .Value sujaria o registro corrente do cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InstalarCelulaCheque(par_oGrade)
        LOCAL loc_lSucesso, loc_oColuna, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_oGrade) != "O"
            RETURN .F.
        ENDIF

        TRY
            IF par_oGrade.ColumnCount >= 5
                loc_oColuna = par_oGrade.Columns(5)

                IF !PEMSTATUS(loc_oColuna, "txt_4c_Celula", 5)
                    loc_oColuna.AddObject("txt_4c_Celula", "TextBoxChequeSigOpNch_4c")
                    loc_oColuna.txt_4c_Celula.Value = 0
                ENDIF

                *-- Text1 do dump (SIGOPNCH.Grade.Column5.Text1), celula a celula
                WITH loc_oColuna.txt_4c_Celula
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .InputMask   = "999999"
                    .ReadOnly    = .F.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .Visible     = .T.
                ENDWITH

                *-- Sem estas duas a celula nao aparece / aparece so na linha ativa
                loc_oColuna.CurrentControl = "txt_4c_Celula"
                loc_oColuna.Sparse         = .F.

                *-- DEPOIS do Grid.ReadOnly, que propaga para as colunas
                loc_oColuna.ReadOnly       = .F.

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.InstalarCelulaCheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaChequeWhen - transcricao de SIGOPNCH.Grade.Column5.Text1.When:
    *
    *   Thisform.nAntChqVal = This.Value
    *   Return( .T. )
    *
    * Guarda o numero que a celula tinha ANTES da digitacao. Eh o unico ponto
    * que escreve this_nAntChqVal, e o Valid depende dele para duas coisas:
    * restaurar o valor quando a digitacao eh invalida e decidir se a linha de
    * fato mudou (e portanto se deve ser marcada para gravacao).
    *
    * O When devolve .T. SEMPRE, como o legado: aqui ele nao eh porta de
    * entrada - quem recusa a edicao das outras colunas eh o ReadOnly delas.
    *
    * O guard de VARTYPE existe porque a celula pode ser visitada com a grade
    * ainda sem linha (cursor vazio): ali o .Value do controle eh o 0 de
    * nascimento, e nao ha anterior real a guardar.
    *
    * PUBLIC (sem PROTECTED): eh chamado de FORA da classe do form - pela
    * subclasse do TextBox - e metodo PROTECTED falharia em runtime com
    * "Property ... is not found" (regras #3 e #51).
    *--------------------------------------------------------------------------
    PROCEDURE CelulaChequeWhen(par_oTxt)
        IF VARTYPE(par_oTxt) = "O" AND VARTYPE(par_oTxt.Value) = "N"
            THIS.this_nAntChqVal = par_oTxt.Value
        ELSE
            THIS.this_nAntChqVal = 0
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaChequeValid - transcricao de SIGOPNCH.Grade.Column5.Text1.Valid:
    *
    *   If This.Value < 0
    *       MessageBox("Numero do Cheque Invalido.", 48, "")
    *       This.Value = Thisform.nAntChqVal
    *       Return 0
    *   EndIf
    *
    *   If This.Value # Thisform.nAntChqVal
    *       Select csCheques
    *       Replace csCheques.Marcas With .T.
    *   EndIf
    *
    * Este metodo FECHA O CIRCUITO da tela: Marcas eh a flag que o
    * "Scan For Marcas" do Confirmar le, entao sem ele nenhuma linha seria
    * gravada por mais que o usuario digitasse.
    *
    * O valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor - o
    * ControlSource da coluna so escreve depois de o Valid passar (regra #46).
    * Ler o cursor aqui validaria o valor ANTIGO; por isso FormParaBO recebe a
    * celula e deixa que ela PREVALECA sobre o que esta gravado na linha.
    *
    * Quem decide se o numero presta eh o BO (ValidarNumeroCheque), nao a
    * tela: a regra - e a mensagem - sao de negocio e tem fonte unica, a mesma
    * que GravarNumeracao consulta antes de montar o lote. Duplicar o
    * "If This.Value < 0" aqui criaria um segundo lugar para a regra divergir.
    *
    * MsgAviso, e nao MsgErro: o legado usa MessageBox com icone 48
    * (exclamacao), que eh validacao de entrada do usuario - MsgErro abre o
    * dialogo vermelho, reservado a excecao tecnica. O titulo vazio do legado
    * vira o canonico "Atencao" do projeto (MsgAviso com titulo vazio).
    *
    * RETURN 0 (numerico) no caminho invalido eh o que PRENDE o foco na celula,
    * obrigando o usuario a corrigir - exatamente o "Return 0" do legado. Nao
    * ha laco de dialogo: o valor acabou de ser restaurado para o anterior, que
    * por construcao eh valido, entao a proxima saida da celula passa.
    *
    * O 0 eh devolvido FORA do TRY, por flag (regra #1) - e a flag nasce .T.
    * para que uma falha inesperada NAO prenda o usuario na celula.
    *
    * PUBLIC pelo mesmo motivo do irmao (chamado pela subclasse do TextBox, de
    * fora da classe do form - regras #3 e #51).
    *--------------------------------------------------------------------------
    PROCEDURE CelulaChequeValid(par_oTxt)
        LOCAL loc_uRetorno, loc_nDigitado, loc_oBO, loc_oErro

        loc_uRetorno = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O" ;
                    AND THIS.FormParaBO(par_oTxt)

                loc_nDigitado = loc_oBO.this_nProxCheque

                IF !loc_oBO.ValidarNumeroCheque(loc_nDigitado)
                    MsgAviso(loc_oBO.this_cMensagemErro, "")

                    *-- "This.Value = Thisform.nAntChqVal": o BO volta ao
                    *-- numero anterior e BOParaForm espelha na celula. O
                    *-- CURSOR nao eh tocado - ele ainda tem o valor antigo,
                    *-- porque o ControlSource so grava apos um Valid que
                    *-- passe, e eh justamente esse que esta sendo recusado.
                    loc_oBO.this_nProxCheque = THIS.this_nAntChqVal
                    loc_oBO.this_nConteudo   = THIS.this_nAntChqVal - 1

                    THIS.BOParaForm(par_oTxt)

                    loc_uRetorno = 0
                ELSE
                    *-- "If This.Value # Thisform.nAntChqVal": so a linha que
                    *-- o usuario de fato mudou eh marcada. Sem a comparacao,
                    *-- apenas passar o foco pela celula marcaria a linha e o
                    *-- Confirmar regravaria contas que ninguem editou.
                    IF loc_nDigitado != THIS.this_nAntChqVal
                        loc_oBO.MarcarChequeAlterado(loc_oBO.this_cCursorCheques)
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.CelulaChequeValid")
        ENDTRY

        RETURN loc_uRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere para o BO o que esta na TELA.
    *
    * A superficie editavel desta tela eh UMA so: a celula "Proximo Chq." da
    * linha corrente da grade. Entao o mapeamento eh a linha corrente de
    * cursor_4c_Cheques (identidade da conta: FPags / Bancos / Agencias /
    * NContas) MAIS o numero que esta na celula.
    *
    * A identidade vem de BO.CarregarChequeDoCursor, que ja monta a chave
    * POSICIONAL de 25 (regra #42) e deriva this_nConteudo - fonte unica, a
    * mesma que o Confirmar usa. O que este metodo acrescenta eh o valor
    * DIGITADO: durante o Valid ele ainda nao chegou ao cursor (o ControlSource
    * so grava depois), entao a celula PREVALECE sobre a coluna quando ela eh
    * passada. Chamado sem a celula, fica valendo o que o cursor tem - que eh o
    * estado ja confirmado da linha.
    *
    * NAO existem aqui os dezenas de campos de um FormParaBO de cadastro: o
    * SCX nao declara TextBox/ComboBox/CheckBox nenhum fora da grade. Inventar
    * campos para a tela "parecer" um CRUD violaria o PILAR 1.
    *
    * PROTECTED, e nao PUBLIC: FormBase declara este hook PROTECTED, e em VFP9
    * o override NAO alarga o escopo - o metodo fica protegido mesmo escrito sem
    * modificador (regra #51). Declarado assim explicitamente para o codigo
    * dizer a verdade sobre o proprio escopo. O unico chamador eh o Valid da
    * celula, que roda DENTRO da classe, entao nada quebra; um harness que
    * precise exercita-lo tem de subclassar o form, como ja fazem os probes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO(par_oTxt)
        LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_cCursor = loc_oBO.this_cCursorCheques

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    *-- identidade da conta + numero JA gravado na linha
                    loc_lSucesso = loc_oBO.CarregarChequeDoCursor(loc_cCursor)

                    IF loc_lSucesso AND VARTYPE(par_oTxt) = "O"
                        IF VARTYPE(par_oTxt.Value) = "N"
                            loc_oBO.this_nProxCheque = par_oTxt.Value

                            *-- SigSySeq.conteudo = ULTIMO emitido = proximo - 1
                            *-- (a mesma derivacao de CarregarChequeDoCursor,
                            *-- refeita porque o numero acabou de mudar)
                            loc_oBO.this_nConteudo = par_oTxt.Value - 1
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha na TELA o que esta no BO.
    *
    * Reciproco de FormParaBO, e com a mesma superficie unica: escreve
    * this_nProxCheque na celula "Proximo Chq.". Eh o
    * "This.Value = Thisform.nAntChqVal" do Valid legado, com uma diferenca de
    * ARQUITETURA e nenhuma de comportamento: quem guarda o numero eh o BO, e a
    * tela so espelha (PILAR 3) - o form nao mantem regra propria.
    *
    * NAO toca no cursor de proposito. O unico chamador real eh o caminho de
    * recusa do Valid, onde o cursor AINDA tem o valor antigo e correto: o
    * ControlSource so grava depois de um Valid que passe, e eh exatamente esse
    * que esta sendo recusado. Escrever no cursor aqui gravaria o mesmo valor
    * por dois caminhos diferentes.
    *
    * A celula pode vir por parametro (o caminho do Valid, que ja a tem em
    * maos) ou ser resolvida na Column5 - assim o metodo tambem funciona
    * chamado de fora, sem argumento. A resolucao eh guardada por PEMSTATUS
    * porque a celula so existe depois de InstalarCelulaCheque, e esse so roda
    * quando a grade tem cursor.
    *
    * PROTECTED pelo mesmo motivo do irmao: o hook eh PROTECTED em FormBase e o
    * override nao alarga o escopo (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm(par_oTxt)
        LOCAL loc_lSucesso, loc_oBO, loc_oCelula, loc_oColuna, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oBO     = THIS.this_oBusinessObject
            loc_oCelula = .NULL.

            IF VARTYPE(par_oTxt) = "O"
                loc_oCelula = par_oTxt
            ELSE
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
                   THIS.grd_4c_Dados.ColumnCount >= 5

                    loc_oColuna = THIS.grd_4c_Dados.Columns(5)

                    IF PEMSTATUS(loc_oColuna, "txt_4c_Celula", 5)
                        loc_oCelula = loc_oColuna.txt_4c_Celula
                    ENDIF
                ENDIF
            ENDIF

            IF VARTYPE(loc_oBO) = "O" AND VARTYPE(loc_oCelula) = "O"
                loc_oCelula.Value = loc_oBO.this_nProxCheque
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNch.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - a MESMA acao de BtnEncerrarClick, e de proposito o
    * mesmo corpo em um funil so.
    *
    * O objeto do legado chama-se "btnCancelar" e seu Click eh uma linha so
    * (ThisForm.Release); o Caption que o usuario le eh "Encerrar", e eh dele
    * que sai o nome canonico do projeto para esse botao - cmd_4c_Encerrar /
    * BtnEncerrarClick (regra #10). Os dois nomes descrevem corretamente a
    * mesma acao: abandonar sem gravar. Diferente do irmao btnAlterar, cujo
    * nome MENTE (ele grava, e por isso virou Confirmar), aqui nao ha
    * ambiguidade a desfazer.
    *
    * Mantidos os DOIS nomes, com UM corpo: BtnEncerrarClick eh o que o
    * BINDEVENT liga ao botao - seguir o Caption eh o que o projeto padroniza -
    * e este eh o nome pelo qual o Click de SIGOPNCH.btnCancelar eh procurado
    * por quem vem do legado. Duplicar a linha nos dois, em vez de encadear,
    * criaria duas versoes para divergir no primeiro ajuste.
    *
    * PUBLIC (sem PROTECTED): eh ponto de entrada chamado de fora da classe
    * (regras #3 e #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - da o foco inicial a coluna digitavel, uma UNICA vez.
    *
    * Legado, ultima linha do Init: "With ThisForm.Grade / .Refresh /
    * .Column5.SetFocus / EndWith" - a tela abre com o cursor piscando na
    * coluna do proximo cheque, a unica digitavel. Esse SetFocus nao pode
    * ficar em InicializarForm, que roda ANTES do Show: o VFP recusa foco em
    * controle de form que ainda nao apareceu. No Activate o form ja esta
    * visivel, e this_lFocoInicialDado faz o foco ser dado so na PRIMEIRA
    * ativacao - sem a flag, cada volta de foco a tela (ao dispensar um
    * dialogo, por exemplo) arrancaria o cursor do usuario de onde ele
    * estava e o jogaria de volta na coluna 5.
    *
    * Tres guardas, nenhuma decorativa: PEMSTATUS porque o Activate pode
    * disparar com a montagem incompleta se o InicializarForm tiver falhado;
    * ColumnCount >= 5 porque um rebind futuro poderia reduzir a grade; e
    * !EOF porque SetFocus em grade SEM LINHA nao tem celula onde pousar.
    * Com as guardas no lugar nao ha excecao a capturar - e por isso nao ha
    * TRY/CATCH aqui: um CATCH neste ponto jogaria um dialogo de erro em
    * cima da tela recem-aberta por causa de um detalhe de foco.
    *
    * DODEFAULT() na PRIMEIRA linha: o comportamento padrao de Activate tem
    * de acontecer antes de mexer no foco.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        LOCAL loc_cCursor

        DODEFAULT()

        IF !THIS.this_lFocoInicialDado AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.this_lFocoInicialDado = .T.

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.ColumnCount >= 5 ;
                    AND USED(loc_cCursor) AND !EOF(loc_cCursor)
                THIS.grd_4c_Dados.Column5.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera o BO (que fecha no proprio Destroy os cursores que
    * abriu) e delega ao FormBase.
    *
    * DODEFAULT() na ULTIMA linha eh obrigatorio: FormBase.Destroy reconstroi
    * os popups do menu principal, e sem ele o menu do sistema aparece
    * encolhido depois de fechar esta tela (Pattern #145).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


*==============================================================================
* TextBoxChequeSigOpNch_4c - a celula COM EVENTO da Column5 (Proximo Chq.)
*
* Transcreve os DOIS metodos que o legado pendura em
* SIGOPNCH.Grade.Column5.Text1 - e so nessa celula: as outras quatro colunas
* tem apenas "When / Return .f.", que eh recusa de foco ja reproduzida pelo
* ReadOnly da coluna, sem metodo a portar.
*
* POR QUE SUBCLASSE E NAO BINDEVENT: BINDEVENT em evento de TextBox dentro de
* Column nao dispara de forma confiavel no VFP9 - eh a razao de existir
* classes\TextBoxGridLookup.prg, que documenta isso no proprio cabecalho. O
* caminho canonico do projeto (regra #46, referencia FormLpr) eh um TextBox
* subclasse com o evento EMBUTIDO delegando a metodo PUBLIC do form.
*
* Os dois metodos sao finos de proposito: so delegam. A regra de negocio
* (validar o numero, restaurar o anterior, marcar a linha) mora no form e no
* BO, nunca na classe do controle - assim o mesmo comportamento continua
* alcancavel pelo harness de teste, que nao tem como simular digitacao.
*
* O guard PEMSTATUS existe porque esta classe eh instalada por AddObject numa
* Column: se um rebind futuro recriar a coluna enquanto o form esta sendo
* liberado, THISFORM pode ja nao ter os metodos - sem o guard, o Valid
* estouraria "Property ... is not found" em cima de uma tela que esta
* fechando.
*
* O Valid devolve o que o form devolver, SEM normalizar para logico: o legado
* devolve 0 (numerico) para PRENDER o foco na celula quando o numero eh
* invalido, e converter esse 0 em .F. mudaria o comportamento - em VFP9 o
* .F. tambem retem o foco, mas descarta a diferenca semantica e, sobretudo,
* faria o retorno deixar de ser transcricao.
*==============================================================================
DEFINE CLASS TextBoxChequeSigOpNch_4c AS TextBox

    *-- Legado: PROCEDURE When / Thisform.nAntChqVal = This.Value / Return(.T.)
    PROCEDURE When()
        LOCAL loc_lRetorno

        loc_lRetorno = .T.

        IF PEMSTATUS(THISFORM, "CelulaChequeWhen", 5)
            loc_lRetorno = THISFORM.CelulaChequeWhen(THIS)
        ENDIF

        RETURN loc_lRetorno
    ENDPROC

    *-- Legado: PROCEDURE Valid (ver FormSigOpNch.CelulaChequeValid)
    PROCEDURE Valid()
        LOCAL loc_uRetorno

        loc_uRetorno = .T.

        IF PEMSTATUS(THISFORM, "CelulaChequeValid", 5)
            loc_uRetorno = THISFORM.CelulaChequeValid(THIS)
        ENDIF

        RETURN loc_uRetorno
    ENDPROC

ENDDEFINE
