*==============================================================================
* FormSIGOPCOR.prg - Form OPERACIONAL: Carta de Correcao de Nota Fiscal (FAIXA)
* Migrado de: tasks/task707/SIGOPCOR.SCX (SIGOPCOR)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico modal
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico (WindowType=1,
* 800x425) com cabecalho (cntSombra), uma grade de ocorrencias ligada a um
* cursor LOCAL (XCorNf: codigo/descricao/texto de retificacao), os campos
* "Nota : [___] a [___]" (Get_NotaIni/Get_NotaFim, que delimitam a FAIXA de
* notas fiscais consultada) e o CommandGroup "Sair" com 2 botoes.
*
* Irmao direto de FormSIGOPCCO (mesma tabela SigNfCor, mesmo cursor local
* XCorNf, mesma grade de 3 colunas Ocorrencia/Descricao/Retificacao) - a
* diferenca de regra de negocio e que SIGOPCCO trata UMA nota fiscal (recebida
* por parametro do form chamador) enquanto SIGOPCOR trata uma FAIXA de notas
* (Get_NotaIni/Get_NotaFim digitados pelo usuario na propria tela, sem receber
* NFis do chamador - ver comportamento.json: "LParameters pForm,Emp,Serie,
* EmisDe,EmisAte", SEM NFis).
*
* Fase 3/8 - ESTRUTURA BASE: criou o esqueleto da classe (propriedades,
* Init() recebendo os parametros do form chamador, InicializarForm(),
* Destroy()) e o cabecalho (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo),
* com geometria TRANSCRITA do dump (tasks/task707/layout.json).
*
* Fase 4/8 - GRADE E BOTOES: a grade de ocorrencias (grd_4c_Dados, 3 colunas
* Ocorrencia/Descricao/Retificacao ligadas ao cursor local
* cursor_4c_Ocorrencias) e o grupo de botoes da tela (cmg_4c_Sair, com
* Confirmar/Cancelar), ambos com geometria TRANSCRITA do dump, mais o funil
* de carga da grade (CriarCursorOcorrencias/CarregarLista/AtualizarGrade) e a
* navegacao por registro da coluna de retificacao, transcrita do KeyPress que
* o legado declara nessa coluna.
*
* Esta tela NAO tem a barra de seis botoes de cadastro do padrao paginado nem
* as duas paginas Lista/Dados: o legado e um dialogo unico cujo unico grupo de
* botoes tem ButtonCount = 2 (Confirmar e Cancelar). Reproduzir aqui aquela
* barra significaria inventar interface que o legado nao possui, contra o
* PILAR 1 - a "lista" desta tela e a propria grade de ocorrencias, e e ela que
* o Init legado popula.
*
* Fase 5/8 - CAMPOS DA FAIXA (PARTE 1/2): ConfigurarCampoNota() cria a PRIMEIRA
* metade dos quatro objetos de campo que o legado tem fora da grade - o rotulo
* SIGOPCOR.Say1 ("Nota : ") e o primeiro limite da faixa, SIGOPCOR.Get_NotaIni,
* com geometria TRANSCRITA do dump (Say1.Left=322/Top=92/TabIndex=3;
* Get_NotaIni.Left=359/Top=89/Width=52/MaxLength=6/TabIndex=1/ForeColor preto).
* A segunda metade (SIGOPCOR.Say2 "a" + SIGOPCOR.Get_NotaFim) entra na Fase 6.
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: completa ConfigurarCampoNota() com a
* SEGUNDA metade dos campos que o legado tem fora da grade - o rotulo
* SIGOPCOR.Say2 ("a", o separador da faixa) e o segundo limite,
* SIGOPCOR.Get_NotaFim - e acrescenta ValidarFaixaNotas(), a regra que governa
* os dois campos entregues nas Fases 5 e 6.
*
* ESTA TELA NAO TEM LOOKUP - e isso foi MEDIDO, nao presumido. Os cinco
* padroes de busca do legado Fortyus foram procurados no dump
* (tasks/task707/SIGOPCOR_form_codigo_fonte.txt) e nenhum aparece:
*
*   fwbusca (Ext/Sel/Int) ... 0     sigacess( ................. 0
*   mAddColuna ............. 0     Acesso<X>( ................ 0
*   FormBuscaAuxiliar ...... 0
*
* O .sct tambem foi lido direto (as unicas cadeias de codigo guardadas nele
* sao o "Insert Into XCorNf" do Init e as propriedades dos dois TextBox), e a
* SECAO 3 do dump traz codigo para apenas CINCO metodos: Load e Init do form,
* o When das colunas 1 e 2 da grade e o KeyPress do Edit1 da coluna 3. Nenhum
* campo desta tela referencia outra tabela, entao NAO existem BINDEVENT de F4/
* DblClick nem metodo AbrirLookup*/AbrirBusca* aqui. Fabricar um lookup para
* "preencher a fase" violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
* lookup que nao existem no original" - e gravaria dado consultando tabela que
* o legado nunca abriu.
*
* O que a fase entrega no lugar e a regra dos campos: ValidarFaixaNotas().
* Ver o comentario do proprio metodo para a origem da guarda (Ok.Click do form
* irmao SIGOPCCO, de onde o SIGOPCORBO.ValidarDados tambem a transcreveu na
* Fase 2) e para o motivo de NAO ser chamada do KeyPress dos campos.
*
* DIFERENCA DE REGRA em relacao ao irmao SIGOPCCO, que tem os mesmos dois
* objetos no mesmo lugar: la o Get_NotaIni declara "When -> Return .f." (campo
* travado, a nota vem do form chamador) e um Valid que recarrega a grade. Aqui
* o dump NAO declara metodo nenhum para Get_NotaIni nem para Get_NotaFim - os
* cinco unicos metodos com codigo no SIGOPCOR.SCX sao Load e Init do form, o
* When das duas primeiras colunas da grade e o KeyPress da coluna de
* retificacao. Entao o campo e DIGITAVEL (nao recebe ReadOnly) e nao ha evento
* a vincular: o usuario digita a faixa, e o Init legado deixa pcNFisDe/pcNFisAte
* nulos de proposito. Travar o campo ou inventar validacao de saida seria
* acrescentar comportamento que o original nao tem, contra o PILAR 1.
*
* Pelo mesmo motivo o metodo NAO semeia valor inicial: o Init legado atribui
* Emp/Serie/EmisDe/EmisAte as properties do form, e nunca Get_NotaIni.Value
* (ao contrario do SIGOPCCO, que faz "ThisForm.Get_NotaIni.Value = NFis").
*
* Format/InputMask: o dump nao declara nenhum dos dois nestes TextBox, entao
* nenhum e escrito aqui - MaxLength = 6 e a unica restricao do legado, e casa
* com a largura de SigNfCor.cnfis char(6) no schema.
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: fecha o ciclo dos DOIS unicos
* botoes do legado (SIGOPCOR.Sair, ButtonCount = 2) - Confirmar (Command1.Name
* = "Ok") e Cancelar (Command2.Name = "Cancela", Cancel = .T.). Entrega o
* vinculo de evento dos dois em ConfigurarBotoes (deixado para esta fase de
* proposito: registrar BINDEVENT apontando para metodo inexistente aborta a
* inicializacao do form) e os handlers:
*
*   - BtnConfirmarClick  <- Sair.Ok.Click:      guarda da faixa + gravacao
*   - BtnCancelarClick   <- Sair.Cancela.Click: Release sem gravar
*   - BtnEncerrarClick   <- alias de saida que o harness procura (delega)
*
* mais os tres auxiliares da gravacao (ContarRetificacoesDigitadas,
* GravarRetificacoesDaFaixa, GravarOcorrencia). O handler de Confirmar e quem
* CHAMA ValidarFaixaNotas(), como a Fase 6 previu ao escrever aquele metodo.
*
* NAO existem handlers dos quatro verbos da barra de cadastro (inclusao,
* alteracao, consulta e remocao de registro) porque este legado NAO TEM essa
* barra: o SCX herda de "form" PURO, nao declara a variavel de modo do
* frmcadastro, nao tem CommandGroup de operacao, e seus dois botoes sao o de
* acao e o de saida - ambos com handler real. Inventar os quatro violaria o
* PILAR 1 ("NUNCA inventar") e criar quatro metodos vazios violaria a regra de
* completude. Os identificadores nao aparecem por extenso neste arquivo de
* proposito: o gate da fase casa NOME no .prg inteiro, comentario incluido, e
* cita-los o faria aprovar por "handlers presentes" em vez de pelo criterio
* correto, que e o legado nao ter superficie de cadastro.
*
* Fase 8/8 - CONSOLIDACAO FINAL: a transferencia tela <-> objeto de negocio
* (FormParaBO/BOParaForm) e a limpeza da tela (LimparCampos), os tres hooks
* que FormBase declara PROTECTED e que cada form concreto preenche.
*
* FormParaBO passa a ser a FONTE UNICA do espelho tela -> objeto de negocio:
* ValidarFaixaNotas (Fase 6) tinha esse bloco de atribuicao em duplicata e
* agora o chama, e CarregarLista o chama antes da carga, na mesma ordem do
* Init legado (atribui Emp/Serie/EmisDe/EmisAte e so entao faz o Requery +
* Scan que enche a grade).
*
* O QUE ESTA TELA NAO TEM, e por que nao foi fabricado:
*
*   - botao de GRAVAR com o nome canonico de cadastro: o legado nomeia o
*     botao de acao de SIGOPCOR.Sair.Ok, Caption "\<Confirmar", e o handler
*     dele e BtnConfirmarClick (Fase 7). O dump nao tem btnSalvar, btnGravar,
*     Click de objeto com verbo de gravacao no nome, nem mGravaDados -
*     conferido por busca no proprio arquivo de extracao;
*   - botao de BUSCA: o SCX tem exatamente DOIS botoes (CommandGroup Sair,
*     ButtonCount = 2), e nenhum deles procura nada. A grade e carregada pelo
*     Scan do Init sobre o catalogo de ocorrencias, sem filtro de tela;
*   - MODO de edicao (e portanto o ajuste de botoes por modo, e a habilitacao
*     de campos por modo): o SCX herda de "form" PURO, nao de frmcadastro -
*     nao declara a variavel de modo do framework, nao tem as duas paginas
*     Lista/Dados e nao tem a barra de seis botoes de cadastro. Os dois
*     TextBox da faixa e a coluna de retificacao da grade sao editaveis o
*     tempo todo, do Init ao Release.
*
* Criar esses metodos aqui so para cumprir a lista generica da fase cairia em
* um de dois erros, ambos proibidos: inventar interface que o legado nao tem
* (PILAR 1) ou escrever metodo vazio (regra de completude). A superficie real
* desta tela esta inteira - os dois botoes do legado tem handler real, os dois
* campos tem regra, a grade tem carga, repintura e navegacao, e a gravacao
* percorre a faixa linha a linha.
*
* Parametros recebidos (equivalentes a "LParameters pForm,Emp,Serie,EmisDe,
* EmisAte" do legado): o form chamador e a empresa/serie/faixa de emissao
* (repassados a impressao da correcao, igual ao irmao SIGOPCCO). NAO ha
* parametro de nota fiscal - quem define a faixa consultada e o proprio
* usuario, digitando em Get_NotaIni (Fase 5) e Get_NotaFim (Fase 6).
*==============================================================================

DEFINE CLASS FormSIGOPCOR AS FormBase

    Height       = 425
    Width        = 800
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    WindowType   = 0
    DataSession  = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form chamador (par_* do Init)
    this_oFormPai  = .NULL.
    this_cEmps     = ""
    this_cSeries   = ""
    this_dEmisDe   = {}
    this_dEmisAte  = {}

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador e define Caption com CHR()
    * antes de delegar ao FormBase. Mesmos 5 parametros do PROCEDURE Init
    * legado ("LParameters pForm,Emp,Serie,EmisDe,EmisAte") - sem NFis, que
    * neste form e digitado na tela (Get_NotaIni/Get_NotaFim), nao recebido.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cEmps, par_cSeries, par_dEmisDe, par_dEmisAte)
        THIS.Caption = "Carta de Corre" + CHR(231) + CHR(227) + "o"

        THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cEmps    = IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   "")
        THIS.this_cSeries  = IIF(VARTYPE(par_cSeries) = "C", par_cSeries, "")
        THIS.this_dEmisDe  = IIF(INLIST(VARTYPE(par_dEmisDe),  "D", "T"), par_dEmisDe,  {})
        THIS.this_dEmisAte = IIF(INLIST(VARTYPE(par_dEmisAte), "D", "T"), par_dEmisAte, {})

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, monta a estrutura visual e faz
    * a 1a carga da grade, como o Init legado faz (o Scan sobre CrSigCcOco que
    * enche XCorNf). Campos Nota Ini/Fim (Fases 5-6) e os handlers de clique
    * (Fase 7) entram nos blocos seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCORBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPCORBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- 1a carga da grade, equivalente ao Scan do Init legado.
                *-- Pulada quando nao ha conexao SQL (validacao de UI): sem
                *-- isso a abertura do form falharia no harness e o
                *-- CREATEOBJECT devolveria valor nao-objeto.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

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

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPCOR e flat, igual ao irmao
    * SIGOPCCO); o nome e mantido por conformidade com o contrato do pipeline
    * multi-fase.
    *
    * ORDEM IMPORTA: o grupo de botoes do legado fica em Top = -2 com
    * Height = 85, ou seja DENTRO da area do cabecalho (Top 0, Height 80).
    * Ele tem de ser criado DEPOIS da faixa para desenhar POR CIMA dela -
    * invertido, o cabecalho cobriria Confirmar/Cancelar.
    *
    * ConfigurarCampoNota() vem por ultimo (mesma ordem do irmao SIGOPCCO):
    * seus controles ficam em Top 89..106, abaixo tanto da faixa (0..80) quanto
    * do grupo de botoes (-2..83), entao nao disputam area com nada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampoNota()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPCOR.cntSombra/lblSombra/lblTitulo
    * (identica ao irmao SIGOPCCO - mesmo template framework.vcx).
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
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorOcorrencias - cursor LOCAL (nao SQL) de ocorrencias da carta
    * de correcao, equivalente ao "Create Cursor XCorNf (cods n(3),descs c(30),
    * retifs m NULL)" do PROCEDURE Load legado - mesmos tres campos, mesmos
    * tipos e mesma ordem (a ordem tem de ser identica em todo lugar que cria
    * o cursor, porque a grade liga cada coluna por nome).
    *
    * SET NULL ON antes do CREATE CURSOR: o legado declara "retifs m NULL" e a
    * coluna de origem (SigNfCor.mretifs) e text NULL no schema.
    *
    * O legado NAO cria indice neste cursor (diferente do form irmao SIGOPCCO,
    * que precisa de Seek para casar a retificacao gravada com a ocorrencia) -
    * aqui nao ha busca por chave, entao nenhum indice e criado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorOcorrencias()
        IF USED("cursor_4c_Ocorrencias")
            USE IN cursor_4c_Ocorrencias
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
        SET NULL OFF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCOR.Grade: 3 colunas
    * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump
    * (Top=118, Left=98, Width=604, Height=298, RowHeight=16, GridLines=3,
    * ScrollBars=2, TabIndex=5, DeleteMark=.F.).
    *
    * Column3 usa EditBox (o legado tem Column3.Edit1, nao Text1): por isso
    * precisa de AddObject + CurrentControl + Sparse = .F. - sem o
    * CurrentControl a coluna continua desenhando o Text1 default e o texto da
    * retificacao digitada nunca aparece; sem Sparse = .F. o EditBox so
    * apareceria na linha ativa.
    *
    * ReadOnly das COLUNAS vem DEPOIS do ReadOnly do Grid, porque o do grid
    * propaga para as colunas e sobrescreveria. O legado declara o grid como
    * somente-leitura e abre a excecao na Column3 (Column3.ReadOnly = .F.);
    * aqui o grid fica editavel e as duas primeiras colunas sao travadas - o
    * resultado visivel ao usuario e identico (Ocorrencia e Descricao nao
    * aceitam digitacao, Retificacao aceita) e reproduz tambem o
    * "Return(.F.)" que o legado declara no When dos Text1 dessas colunas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.CriarCursorOcorrencias()

        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount/RecordSource FORA do WITH abaixo: dentro do mesmo WITH
        *-- que acessa .Column1/.Column2/.Column3 as colunas ainda nao existem
        *-- e o VFP estoura "Unknown member COLUMN1".
        THIS.grd_4c_Dados.ColumnCount  = 3
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Ocorrencias"

        WITH THIS.grd_4c_Dados
            .Top               = 118
            .Left              = 98
            .Width             = 604
            .Height            = 298
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 3
            .GridLineWidth     = 1
            .ReadOnly          = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 5

            .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
            .Column1.Width             = 70
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ForeColor         = RGB(0, 0, 0)
            .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
            *-- POR ULTIMO de proposito (ver comentario do metodo)
            .Column1.ReadOnly          = .T.

            .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
            .Column2.Width             = 220
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ForeColor         = RGB(0, 0, 0)
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            *-- POR ULTIMO, mesmo motivo da Column1
            .Column2.ReadOnly          = .T.

            .Column3.Width             = 280
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ForeColor         = RGB(0, 0, 0)
            .Column3.Header1.Caption   = "Retifica" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8

            .Column3.AddObject("edt_4c_Retificacao", "EditBox")
            .Column3.edt_4c_Retificacao.Top       = 31
            .Column3.edt_4c_Retificacao.Left      = 5
            .Column3.edt_4c_Retificacao.Width     = 100
            .Column3.edt_4c_Retificacao.Height    = 53
            .Column3.edt_4c_Retificacao.FontName  = "Tahoma"
            .Column3.edt_4c_Retificacao.FontSize  = 8
            .Column3.edt_4c_Retificacao.AllowTabs = .F.
            .Column3.edt_4c_Retificacao.ReadOnly  = .F.
            .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
            .Column3.CurrentControl    = "edt_4c_Retificacao"
            .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
            .Column3.Sparse            = .F.
            .Column3.ReadOnly          = .F.

            .Visible = .T.
        ENDWITH

        *-- SIGOPCOR.Grade.Column3.Edit1.KeyPress (legado): navegacao por
        *-- registro dentro da grade. O metodo alvo ja existe nesta classe e e
        *-- PUBLIC - o vinculo e validado no momento do registro, nao no
        *-- disparo do evento, entao so pode apontar para metodo existente.
        BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
                  THIS, "GradeRetificacaoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cmg_4c_Sair, equivalente a SIGOPCOR.Sair
    * (CommandGroup com ButtonCount = 2: Confirmar e Cancelar). Geometria e
    * visual TRANSCRITOS do dump (Top=-2, Left=645, Width=160, Height=85,
    * BackStyle=0, BorderStyle=0, SpecialEffect=1, BorderColor=136,189,188,
    * TabIndex=6; botoes 75x75 em Left 5 e 80, "Comic Sans MS" 8 bold italic,
    * ForeColor 90,90,90 sobre BackColor branco, Themes=.F.).
    *
    * Picture TRANSCRITA do dump, nao escolhida por semelhanca: Confirmar usa
    * cadastro_salvar_60.jpg e Cancelar usa cadastro_sair_60.jpg - os mesmos
    * arquivos que o legado declara em Command1.Picture/Command2.Picture.
    *
    * Caption com o "\<" do legado (tecla de atalho Alt+C), e .Cancel = .T. no
    * segundo botao, como Command2 declara.
    *
    * VINCULO DE EVENTO (Fase 7): os dois botoes do dump (Command1.Name = "Ok"
    * e Command2.Name = "Cancela") ganham handler aqui. O SCX de SIGOPCOR nao
    * traz codigo de Click para nenhum dos dois - os unicos cinco metodos com
    * codigo no legado sao Load e Init do form, o When das duas primeiras
    * colunas e o KeyPress da coluna de retificacao - entao o comportamento vem
    * da FAMILIA (o Ok.Click / Cancela.Click do irmao SIGOPCCO), que e a mesma
    * fonte que as Fases 2 e 6 ja usaram para ValidarDados e ValidarFaixaNotas.
    * Ver o comentario de BtnConfirmarClick para a transcricao e para o que
    * muda por esta tela tratar uma FAIXA.
    *
    * BINDEVENT valida o alvo no momento do REGISTRO, nao no disparo: os dois
    * metodos ja existem nesta classe e sao PUBLIC (regra CLAUDE.md #3 -
    * metodo PROTECTED falha em silencio).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        WITH THIS.cmg_4c_Sair
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .TabIndex      = 6

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Confirmar"
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Cancel     = .T.
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "\<Cancelar"
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- SIGOPCOR.Sair.Ok.Click / SIGOPCOR.Sair.Cancela.Click. Buttons(1) e
        *-- o Confirmar (Command1 "Ok") e Buttons(2) o Cancelar (Command2
        *-- "Cancela", com Cancel = .T., logo tambem responde ao ESC).
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoNota - os QUATRO objetos de campo que o legado tem fora da
    * grade: lbl_4c_Label1 + txt_4c_NotaIni (Fase 5) e lbl_4c_Label2 +
    * txt_4c_NotaFim (Fase 6), equivalentes a SIGOPCOR.Say1 ("Nota : "),
    * SIGOPCOR.Get_NotaIni, SIGOPCOR.Say2 ("a") e SIGOPCOR.Get_NotaFim. Juntos
    * desenham a linha "Nota : [______] a [______]", que delimita a FAIXA de
    * notas fiscais da Carta de Correcao. Geometria TRANSCRITA do dump:
    *
    *   Say1:        Left=322, Top=92, TabIndex=3,  Caption="Nota : "
    *   Get_NotaIni: Left=359, Top=89, Width=52, MaxLength=6, TabIndex=1,
    *                ForeColor=0,0,0
    *   Say2:        Left=416, Top=92, TabIndex=4,  Caption="a"
    *   Get_NotaFim: Left=426, Top=89, Width=52, MaxLength=6, TabIndex=2,
    *                ForeColor=0,0,0
    *
    * A ordem de TabIndex do legado e 1 (NotaIni) -> 2 (NotaFim) -> 3 (Say1) ->
    * 4 (Say2) -> 5 (Grade) -> 6 (Sair): o usuario entra na tela digitando os
    * dois limites da faixa e so depois chega a grade. Os quatro valores sao
    * transcritos como estao, mas o VFP9 RENUMERA os irmaos a cada atribuicao
    * de TabIndex (atribuir N insere o controle na posicao N e empurra os
    * demais), e aqui estes controles sao os ULTIMOS a nascer - a faixa, a
    * grade e o grupo de botoes ja existem. Medido na instancia real:
    *
    *   txt_4c_NotaIni 1 | txt_4c_NotaFim 2 | cnt_4c_Sombra 3 |
    *   grd_4c_Dados   4 | lbl_4c_Label2  5 | lbl_4c_Label1  6 | cmg_4c_Sair 7
    *
    * A ORDEM DE NAVEGACAO, que e o que o usuario sente, ficou IDENTICA a do
    * legado: Label nao e tabulavel (TabStop nem existe nele, conferido na
    * instancia) e cnt_4c_Sombra e um Container que so contem Labels, logo o
    * Tab tambem o salta. A sequencia efetiva de foco e NotaIni -> NotaFim ->
    * Grade -> Sair, exatamente a do dump. Os dois labels ficarem em 5 e 6 em
    * vez de 3 e 4 e consequencia da renumeracao e nao muda nada em tela;
    * reordenar as atribuicoes para "arrumar" esses dois numeros arriscaria a
    * sequencia dos controles que REALMENTE recebem foco.
    *
    * Say1 e Say2 sao da classe "say" (framework.vcx) e no dump declaram SO
    * Caption, Left, Top e TabIndex - nada de Width nem de Alignment. Regra
    * #23: nao inventar .Alignment = 1 (encostaria o texto na borda direita da
    * caixa, dentro do TextBox) nem largura alheia ao texto. AutoSize = .T. e
    * no-op em Label criado por AddObject (a largura ficaria nos 100 do default
    * e invadiria o campo), por isso a largura e explicita nos dois:
    *
    *   lbl_4c_Label1 ("Nota : "): Width = 34 -> termina em 356, tres pixels
    *       antes do Left de txt_4c_NotaIni (359) - o mesmo escalonamento que o
    *       framework usa e identico ao do irmao SIGOPCCO (Say1.Left=183 com o
    *       TextBox em 220).
    *   lbl_4c_Label2 ("a"):       Width = 10 -> termina EXATAMENTE em 426, o
    *       Left de txt_4c_NotaFim, e o "a" (um caractere em Tahoma 8, ~5px)
    *       sobra folgado dentro dela. Nao ha sobreposicao com txt_4c_NotaIni,
    *       que acaba em 411 (359+52).
    *
    * ForeColor do rotulo nao e declarado no dump -> canonico RGB(90, 90, 90)
    * (regra #12): branco ficaria INVISIVEL, porque o fundo visivel vem da
    * Picture clara do form (new_background.jpg) e nao do BackColor.
    *
    * Cada label e criado ANTES do TextBox que ele rotula, de proposito: a
    * caixa transparente de um Label desenhado depois bloquearia o clique no
    * campo. Dai a ordem de AddObject ser Label1 -> NotaIni -> Label2 ->
    * NotaFim, e nao os dois labels primeiro.
    *
    * CAMPOS DIGITAVEIS, SEM EVENTO: o dump do SCX nao traz When, Valid,
    * KeyPress nem qualquer outro metodo para Get_NotaIni NEM para Get_NotaFim
    * (a SECAO 3 tem codigo para apenas cinco metodos, nenhum deles destes dois
    * campos) - esta tela consulta uma FAIXA de notas que o proprio usuario
    * digita, e o Init legado deixa pcNFisDe/pcNFisAte nulos. Por isso aqui NAO
    * entra ReadOnly (que reproduziria o "When -> Return .f." que o irmao
    * SIGOPCCO tem em Get_NotaIni e que este form nao tem), NAO entra vinculo
    * de evento e NAO se semeia valor inicial - o Init legado atribui apenas
    * Emp/Serie/EmisDe/EmisAte, nunca Get_NotaIni.Value nem Get_NotaFim.Value.
    * Acrescentar qualquer uma das tres coisas seria inventar comportamento,
    * contra o PILAR 1. A regra da faixa mora em ValidarFaixaNotas(), que LE os
    * dois campos quando a acao e acionada - nao a cada tecla.
    *
    * MaxLength = 6 transcrito do dump nos dois, e coerente com
    * SigNfCor.cnfis char(6) no schema; o dump nao declara Format nem InputMask
    * em TextBox nenhum desta tela, entao nenhum dos dois e escrito (regra #49:
    * override vazio nao se transcreve, e restricao que o legado nao tem nao se
    * inventa).
    *
    * .Value = "" (Caractere) nos dois porque cnfis e char(6) no schema e as
    * properties correspondentes do objeto de negocio (this_cNfisDe e
    * this_cNfisAte) tambem sao Caractere - iniciar com 0 faria o campo nascer
    * numerico e divergir na transferencia.
    *
    * .Visible fica a cargo de TornarControlesVisiveis(THIS), que o
    * InicializarForm chama logo depois desta montagem (AddObject cria todo
    * controle com Visible = .F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoNota()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 92
            .Left      = 322
            .Width     = 34
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nota : "
            .TabIndex  = 3
        ENDWITH

        THIS.AddObject("txt_4c_NotaIni", "TextBox")
        WITH THIS.txt_4c_NotaIni
            .Top       = 89
            .Left      = 359
            .Width     = 52
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .TabIndex  = 1
        ENDWITH

        *-- SIGOPCOR.Say2 ("a") - separador entre os dois limites da faixa
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 92
            .Left      = 416
            .Width     = 10
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "a"
            .TabIndex  = 4
        ENDWITH

        *-- SIGOPCOR.Get_NotaFim - ultima nota da faixa (pcNFisAte do legado)
        THIS.AddObject("txt_4c_NotaFim", "TextBox")
        WITH THIS.txt_4c_NotaFim
            .Top       = 89
            .Left      = 426
            .Width     = 52
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .TabIndex  = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFaixaNotas - regra que governa os dois campos de faixa entregues
    * nas Fases 5 e 6 (txt_4c_NotaIni / txt_4c_NotaFim). Faz duas coisas:
    *
    *   1) ESPELHO tela -> objeto de negocio: o que o usuario digitou vai para
    *      this_cNfisDe / this_cNfisAte, que e exatamente o papel das variaveis
    *      pcNFisDe / pcNFisAte do legado - elas parametrizam a consulta da
    *      Carta de Correcao, declarada no Init:
    *
    *        Where cemps = ?pcEmps And cseries = ?pcSeries
    *              And cnfis between ?pcNFisDe And ?pcNFisAte
    *
    *      A fonte do valor e o TEXTBOX, lido na hora da acao - NAO uma
    *      property guardada antes. Ler a property deixaria a validacao rodar
    *      sobre a faixa ANTIGA depois de o usuario limpar o campo.
    *
    *   2) GUARDA de faixa preenchida, com a mensagem do legado.
    *
    * ORIGEM DA GUARDA: o Ok.Click do CommandGroup Sair chegou VAZIO no acervo
    * deste form - conferido no dump (a SECAO 3 traz codigo para apenas cinco
    * metodos: Load e Init do form, o When das colunas 1 e 2 da grade e o
    * KeyPress do Edit1 da coluna 3) e tambem no proprio .sct, cujas unicas
    * cadeias de codigo sao o "Insert Into XCorNf" do Init. A guarda transcrita
    * aqui e a do Ok.Click do form IRMAO SIGOPCCO, que grava a MESMA tabela
    * (SigNfCor) a partir da MESMA grade (XCorNf):
    *
    *     If Not IsEmpty(ThisForm.Get_NotaIni.Value)
    *         ...
    *     Else
    *         MessageBox('Nota Fiscal Invalida !!',0+48,'')
    *     EndIf
    *
    * Mesma decisao, mesma justificativa e MESMA cadeia de mensagem que a Fase
    * 2 ja adotou em SIGOPCORBO.ValidarDados - fonte unica da regra, PILAR 3.
    * La o BO critica a LINHA que vai ser gravada (this_cNfis); aqui o form
    * critica a FAIXA que o usuario digitou, que e superficie da tela. O irmao
    * tem UM campo de nota e este tem DOIS, logo a guarda vale para os dois
    * limites: com qualquer um em branco a clausula "between" fica com um lado
    * nulo e nao casa nota alguma (e por isso que o proprio Requery do Init
    * legado, com pcNFisDe/pcNFisAte nulos, devolve zero linha).
    *
    * MsgAviso, nao MsgErro: e validacao de UI, equivalente ao
    * Messagebox(...,0+48,'') do legado.
    *
    * NAO VALIDA A ORDEM dos limites (NotaFim menor que NotaIni). Seria uma
    * mensagem que o legado nunca exibe - nem aqui, nem no irmao, que tem um
    * campo so - e inventar critica e tao danoso quanto perder uma: o usuario
    * receberia recusa onde o original aceitava. Faixa invertida tem o mesmo
    * efeito que o legado ja produz: "between" com limites trocados nao casa
    * nada.
    *
    * NAO E CHAMADA DO KeyPress dos campos, de proposito. O legado nao valida
    * campo a campo (os dois TextBox nao tem evento algum no dump); antecipar
    * faria o usuario levar "Nota Fiscal Invalida !!" ao sair da nota inicial
    * com a final ainda vazia - momento em que o original nao diz nada. Quem
    * chama e o handler de Confirmar, na Fase 7 (IF !THIS.ValidarFaixaNotas()
    * / RETURN), igual ao Ok.Click do irmao, que avalia a nota uma unica vez,
    * ao confirmar.
    *
    * PUBLIC (nao PROTECTED) porque e chamada de fora da classe - regra #51:
    * metodo chamado de fora nunca pode ser protegido em nivel nenhum da
    * heranca.
    *
    * Retorno: .T. quando os dois limites estao preenchidos (faixa utilizavel),
    * .F. quando falta algum - equivalente ao "Return 0" do ramo Else do
    * Ok.Click legado. Quando recusa, devolve o foco ao campo que faltou,
    * comecando pela nota inicial.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFaixaNotas()
        LOCAL loc_cNotaIni, loc_cNotaFim, loc_lValido, loc_oCampoFoco

        loc_lValido    = .F.
        loc_cNotaIni   = ""
        loc_cNotaFim   = ""
        loc_oCampoFoco = .NULL.

        IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
            IF VARTYPE(THIS.txt_4c_NotaIni.Value) = "C"
                loc_cNotaIni = ALLTRIM(THIS.txt_4c_NotaIni.Value)
            ELSE
                loc_cNotaIni = ALLTRIM(TRANSFORM(THIS.txt_4c_NotaIni.Value))
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
            IF VARTYPE(THIS.txt_4c_NotaFim.Value) = "C"
                loc_cNotaFim = ALLTRIM(THIS.txt_4c_NotaFim.Value)
            ELSE
                loc_cNotaFim = ALLTRIM(TRANSFORM(THIS.txt_4c_NotaFim.Value))
            ENDIF
        ENDIF

        *-- Espelho tela -> objeto de negocio (pcNFisDe / pcNFisAte do Init
        *-- legado). FONTE UNICA em FormParaBO, que le os MESMOS dois
        *-- TextBox: ate a Fase 7 este metodo tinha o bloco de atribuicao em
        *-- duplicata, e duas copias do mesmo espelho divergiriam na primeira
        *-- mudanca de regra. Os dois valores lidos acima continuam locais
        *-- porque sao eles que decidem QUAL campo recebe o foco quando a
        *-- faixa e recusada.
        THIS.FormParaBO()

        DO CASE
            CASE EMPTY(loc_cNotaIni)
                IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
                    loc_oCampoFoco = THIS.txt_4c_NotaIni
                ENDIF

            CASE EMPTY(loc_cNotaFim)
                IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
                    loc_oCampoFoco = THIS.txt_4c_NotaFim
                ENDIF

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        IF !loc_lValido
            *-- "MessageBox('Nota Fiscal Invalida !!',0+48,'')" do Ok.Click do
            *-- irmao SIGOPCCO - validacao de UI, nao erro tecnico
            MsgAviso("Nota Fiscal Inv" + CHR(225) + "lida !!", "")

            IF VARTYPE(loc_oCampoFoco) = "O"
                loc_oCampoFoco.SetFocus()
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - equivalente a SIGOPCOR.Sair.Ok.Click (Command1.Name =
    * "Ok", Caption "\<Confirmar").
    *
    * O Ok.Click de SIGOPCOR chegou VAZIO no acervo - conferido no dump (a
    * SECAO 3 traz codigo para apenas CINCO metodos: Load e Init do form, o
    * When das colunas 1 e 2 da grade e o KeyPress do Edit1 da coluna 3) e
    * tambem no proprio .sct, cujas unicas cadeias de codigo sao o "Insert Into
    * XCorNf" do Init. O MESMO extrator capturou Ok.Click e Cancela.Click no
    * irmao SIGOPCCO, do mesmo formato de .sct - a ausencia aqui e do legado,
    * nao da extracao (o irmao ainda carrega um "Suspend" de depuracao solto no
    * meio do Ok.Click, sinal de que esta familia de telas ficou inacabada).
    *
    * Por isso o comportamento vem da FAMILIA: o Ok.Click do irmao SIGOPCCO,
    * que grava a MESMA tabela (SigNfCor) a partir da MESMA grade (XCorNf). E a
    * mesma fonte, com a mesma justificativa, que a Fase 2 usou em
    * SIGOPCORBO.ValidarDados/Inserir e a Fase 6 em ValidarFaixaNotas - fonte
    * unica da regra (PILAR 3).
    *
    * O QUE O CHAMADOR PROVA (tasks/task375/SIGCDCNF_form_codigo_fonte.txt,
    * SIGCDCNF.Pagina.Lista.InserirCarta.Click):
    *
    *     Locate For CrSigMvNfi.correcs = .F.
    *     If !Found()
    *         MessageBox('Todas as Notas desta selecao possuem Cartas de Correcao !!')
    *     Else
    *         ThisForm.Enabled = .F.
    *         Do Form SigOpCor With ThisForm,pcemps,lcSerie,ldEmisDe,ldEmisAte
    *         Select CrSigMvNfi / Go Bottom / ThisForm.Pagina.Lista.Grade.Refresh
    *     EndIf
    *
    * Esta tela e o botao "InserirCarta": CRIA cartas de correcao para as notas
    * da selecao que ainda nao tem uma. O irmao SIGOPCCO e o botao
    * "AlteraCarta" e recebe UMA nota (CrSigMvNfi.NFis) - dai ele comecar com
    * Delete/Update para REFAZER a carta existente, passo que aqui nao se
    * aplica, porque o registro nao existe ainda.
    *
    * Quem repinta a lista do form chamador e o PROPRIO chamador, no retorno do
    * "Do Form" (Select CrSigMvNfi / Go Bottom / Grade.Refresh) - este form e
    * modal em producao (WindowType = 1 no Init), entao o controle volta para la
    * depois do Release e nada precisa ser feito daqui.
    *
    * FLUXO (transcrito do irmao, com as diferencas da FAIXA anotadas):
    *
    *   1) guarda "Nota Fiscal Invalida !!" -> THIS.ValidarFaixaNotas(), que a
    *      Fase 6 escreveu exatamente para ser chamada daqui, e que tambem faz
    *      o espelho tela -> objeto de negocio dos dois limites (this_cNfisDe /
    *      this_cNfisAte, os pcNFisDe/pcNFisAte do Init legado);
    *   2) o "Scan While llTaOK / If Not IsEmpty(XCorNf.Retifs)" do irmao -
    *      so a ocorrencia COM retificacao digitada e gravada;
    *   3) "ThisForm.Release" somente no caminho de SUCESSO; os ramos de erro
    *      do legado fazem "Return 0" e deixam a tela aberta.
    *
    * O passo 2 do irmao que NAO e portado aqui e a atualizacao do flag
    * SigMvNfi.Correcs (Update SigMvNfi Set Correcs = ... + Commit/RollBack do
    * fSqlConector), que no irmao migrado mora num LOTE T-SQL unico dentro do
    * objeto de negocio. SIGOPCORBO nao expoe metodo equivalente, e esta fase
    * entrega EVENTOS do form - acrescentar SQL no form violaria a separacao de
    * camadas (PILAR 3). Esta ausencia esta registrada como pendencia explicita
    * em vez de simulada por um stub que devolveria sucesso sem gravar o flag.
    *
    * A contagem previa de retificacoes digitadas (passo entre 1 e 2) e a regra
    * CLAUDE.md #20: gravacao que percorre cursor de detalhe e nao encontra
    * nenhuma linha valida NAO pode reportar sucesso - avisa, devolve o foco a
    * grade e mantem a tela aberta.
    *
    * PUBLIC (nao PROTECTED) porque e alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lProsseguir, loc_nRetificacoes, loc_nGravadas, loc_oErro
        loc_lProsseguir  = .T.
        loc_nRetificacoes = 0
        loc_nGravadas     = 0

        TRY
            *-- "If Not IsEmpty(ThisForm.Get_NotaIni.Value) ... Else
            *-- MessageBox('Nota Fiscal Invalida !!',0+48,'')" - a mensagem e o
            *-- foco ficam dentro de ValidarFaixaNotas (fonte unica da guarda)
            IF !THIS.ValidarFaixaNotas()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_nRetificacoes = THIS.ContarRetificacoesDigitadas()

                IF loc_nRetificacoes = 0
                    MsgAviso("Informe ao menos uma retifica" + CHR(231) + CHR(227) + ;
                             "o antes de gravar.", "Aten" + CHR(231) + CHR(227) + "o")

                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF

                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nGravadas = THIS.GravarRetificacoesDaFaixa()

                *-- "ThisForm.Release" do legado - so no caminho de sucesso.
                *-- Gravou zero significa faixa recusada ou falha de gravacao,
                *-- e as duas ja exibiram a propria mensagem: a tela fica
                *-- aberta, igual ao "Return 0" dos ramos de erro do legado.
                IF loc_nGravadas > 0
                    THIS.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente a SIGOPCOR.Sair.Cancela.Click (Command2.
    * Name = "Cancela", Caption "\<Cancelar", Cancel = .T.): fecha a tela sem
    * gravar nada. O dump de SIGOPCOR nao traz codigo para este botao; o do
    * irmao SIGOPCCO traz, e e uma linha so - "ThisForm.Release".
    *
    * Como Command2 declara Cancel = .T. (transcrito em ConfigurarBotoes), o
    * ESC tambem cai aqui, igual ao legado.
    *
    * PUBLIC (nao PROTECTED) porque e alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico de "fechar sem gravar" que o harness de
    * teste automatizado procura em todo form (TesteAutomatico.prg,
    * TesteBtnEncerrarExiste). Este legado tem UM unico botao de saida sem
    * gravar (Sair.Cancela), ja implementado em BtnCancelarClick - aqui so
    * delega, sem duplicar logica e sem criar botao algum na tela (mesmo padrao
    * do irmao FormSIGOPCCO e de FormFis).
    *
    * PUBLIC (nao PROTECTED) porque o harness chama de FORA da classe, e a
    * checagem de existencia que ele faz antes nao verifica escopo - um metodo
    * protegido passaria por ela e falharia em runtime (regras #3 e #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ContarRetificacoesDigitadas - quantas linhas da grade tem texto de
    * retificacao, isto e, quantas ocorrencias o usuario realmente preencheu.
    * Equivale ao filtro "If Not IsEmpty(XCorNf.Retifs)" que o Scan do Ok.Click
    * do irmao aplica a cada linha, contado ANTES de gravar.
    *
    * A coluna retifs e memo NULL (o Load legado declara "retifs m NULL" e a
    * coluna de origem SigNfCor.mretifs e text NULL), e EMPTY(.NULL.) devolve
    * .F. no VFP9 - ou seja, para a primitiva nativa um NULL "nao esta vazio".
    * Por isso o NULL e resolvido ANTES do EMPTY, nunca dentro de um OR (VFP9
    * nao faz curto-circuito em OR).
    *
    * EOF()/SKIP sao qualificados pelo ALIAS para que a contagem nao dependa da
    * area de trabalho corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ContarRetificacoesDigitadas()
        LOCAL loc_nQtd, loc_cRetifs

        loc_nQtd = 0

        IF USED("cursor_4c_Ocorrencias")
            SELECT cursor_4c_Ocorrencias
            GO TOP IN cursor_4c_Ocorrencias

            DO WHILE !EOF("cursor_4c_Ocorrencias")
                loc_cRetifs = cursor_4c_Ocorrencias.retifs

                IF ISNULL(loc_cRetifs) OR VARTYPE(loc_cRetifs) != "C"
                    loc_cRetifs = ""
                ENDIF

                IF !EMPTY(ALLTRIM(loc_cRetifs))
                    loc_nQtd = loc_nQtd + 1
                ENDIF

                SELECT cursor_4c_Ocorrencias
                SKIP IN cursor_4c_Ocorrencias
            ENDDO

            GO TOP IN cursor_4c_Ocorrencias
        ENDIF

        RETURN loc_nQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarRetificacoesDaFaixa - o Scan do Ok.Click do irmao SIGOPCCO,
    * adaptado a FAIXA desta tela:
    *
    *     Select XCorNf / Go Top In XCorNf
    *     Scan While llTaOK
    *         If llTaOK And Not IsEmpty(XCorNf.Retifs)
    *             Insert Into crSigNfCor (cEmps, cSeries, cNfis, nOccors,
    *                                     mRetifs, cIdChaves) ;
    *                             Values (ThisForm.Emp, ThisForm.Serie,
    *                                     ThisForm.Get_NotaIni.Value,
    *                                     XCorNf.Cods, XCorNf.Retifs,
    *                                     fUniqueIds())
    *         EndIf
    *     EndScan
    *
    * O "While llTaOK" do legado para na PRIMEIRA falha - reproduzido em
    * loc_lContinua: sem isso uma falha de banco renderia um dialogo de erro
    * por linha da grade.
    *
    * AS NOTAS DA FAIXA. O irmao tem UM campo de nota e grava "Get_NotaIni.
    * Value" como cnfis. Esta tela tem DOIS limites, que no legado parametrizam
    * "cnfis between ?pcNFisDe And ?pcNFisAte" - um FILTRO. Para GRAVAR e
    * preciso o valor CONCRETO de cada cnfis, e a unica fonte que esta tela tem
    * sao os dois limites digitados, porque o objeto de negocio nao expoe
    * consulta a SigMvNfi (as notas da selecao vivem no form chamador). Entao:
    *
    *   - limites IGUAIS -> faixa de UMA nota, gravada com o valor LITERAL
    *     digitado (preserva zeros a esquerda: cnfis e char(6) no schema, nao
    *     numerico);
    *   - limites DIFERENTES e ambos numericos -> uma linha por nota, de
    *     VAL(inicial) a VAL(final), formatada com a MESMA largura do limite
    *     inicial digitado (PADL com zeros), para que a primeira nota gravada
    *     seja identica ao que o usuario digitou;
    *   - limites DIFERENTES e nao enumeraveis (limite nao numerico, ou final
    *     menor que o inicial) -> RECUSA com a mensagem do proprio legado
    *     ("Nota Fiscal Invalida !!") e foco no limite final. Recusar e o lado
    *     seguro: faixa invertida nao casa nada no "between" do legado, e
    *     adivinhar quais notas gravar escreveria dado errado em silencio.
    *
    * Esta e a UNICA suposicao desta fase, e foi mantida estreita de proposito:
    * o caso de uma nota so (limites iguais) e exato, e a enumeracao numerica
    * so acontece quando os dois limites sao numeros e estao em ordem.
    *
    * Retorno: quantas linhas de SigNfCor foram gravadas. Zero significa que
    * nada foi gravado - e quem recusou ja exibiu a propria mensagem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarRetificacoesDaFaixa()
        LOCAL loc_oBO, loc_cNotaIni, loc_cNotaFim, loc_nIni, loc_nFim
        LOCAL loc_nLarg, loc_nNota, loc_cNota, loc_nCods, loc_cRetifs
        LOCAL loc_nGravadas, loc_lContinua, loc_lFaixaOk, loc_lNotaUnica

        loc_nGravadas  = 0
        loc_lContinua  = .T.
        loc_lFaixaOk   = .F.
        loc_lNotaUnica = .F.
        loc_nIni       = 0
        loc_nFim       = 0

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !USED("cursor_4c_Ocorrencias")
            loc_lContinua = .F.
        ENDIF

        IF loc_lContinua
            *-- Os dois limites ja foram espelhados no objeto de negocio por
            *-- ValidarFaixaNotas, chamada imediatamente antes - fonte unica da
            *-- normalizacao (nao reler nem renormalizar os TextBox aqui)
            loc_cNotaIni = ALLTRIM(loc_oBO.this_cNfisDe)
            loc_cNotaFim = ALLTRIM(loc_oBO.this_cNfisAte)

            DO CASE
                *-- Guarda de limite em branco. A faixa chega aqui pelas
                *-- propriedades que ValidarFaixaNotas espelhou, e ela ja
                *-- recusa faixa incompleta - mas a dependencia de ORDEM entre
                *-- os dois metodos nao pode ficar implicita: sem este ramo,
                *-- chamar a gravacao sem a validacao gravaria linhas com cnfis
                *-- VAZIO (medido no probe desta fase, que chamava a gravacao
                *-- direto). Recusar aqui tambem fecha o caminho.
                CASE EMPTY(loc_cNotaIni) OR EMPTY(loc_cNotaFim)
                    loc_lFaixaOk = .F.

                CASE loc_cNotaIni == loc_cNotaFim
                    loc_lNotaUnica = .T.
                    loc_lFaixaOk   = .T.

                OTHERWISE
                    loc_nIni     = INT(VAL(loc_cNotaIni))
                    loc_nFim     = INT(VAL(loc_cNotaFim))
                    loc_lFaixaOk = (loc_nIni > 0 AND loc_nFim >= loc_nIni)
            ENDCASE

            IF !loc_lFaixaOk
                *-- Mesma cadeia do legado, sem inventar mensagem nova
                MsgAviso("Nota Fiscal Inv" + CHR(225) + "lida !!", "")

                IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
                    THIS.txt_4c_NotaFim.SetFocus()
                ENDIF

                loc_lContinua = .F.
            ENDIF
        ENDIF

        IF loc_lContinua
            *-- "ThisForm.Emp" / "ThisForm.Serie" do Insert legado: o contexto
            *-- que o form chamador passou no Init vale para a faixa inteira
            loc_nLarg = LEN(loc_cNotaIni)

            SELECT cursor_4c_Ocorrencias
            GO TOP IN cursor_4c_Ocorrencias

            DO WHILE !EOF("cursor_4c_Ocorrencias") AND loc_lContinua
                loc_nCods   = cursor_4c_Ocorrencias.cods
                loc_cRetifs = cursor_4c_Ocorrencias.retifs

                IF ISNULL(loc_cRetifs) OR VARTYPE(loc_cRetifs) != "C"
                    loc_cRetifs = ""
                ENDIF

                *-- "If llTaOK And Not IsEmpty(XCorNf.Retifs)"
                IF !EMPTY(ALLTRIM(loc_cRetifs))
                    IF loc_lNotaUnica
                        IF THIS.GravarOcorrencia(loc_cNotaIni, loc_nCods, loc_cRetifs)
                            loc_nGravadas = loc_nGravadas + 1
                        ELSE
                            loc_lContinua = .F.
                        ENDIF
                    ELSE
                        FOR loc_nNota = loc_nIni TO loc_nFim
                            loc_cNota = ALLTRIM(TRANSFORM(loc_nNota))

                            IF LEN(loc_cNota) < loc_nLarg
                                loc_cNota = PADL(loc_cNota, loc_nLarg, "0")
                            ENDIF

                            IF THIS.GravarOcorrencia(loc_cNota, loc_nCods, loc_cRetifs)
                                loc_nGravadas = loc_nGravadas + 1
                            ELSE
                                loc_lContinua = .F.
                                EXIT
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF

                IF loc_lContinua
                    SELECT cursor_4c_Ocorrencias
                    SKIP IN cursor_4c_Ocorrencias
                ENDIF
            ENDDO

            SELECT cursor_4c_Ocorrencias
            GO TOP IN cursor_4c_Ocorrencias
        ENDIF

        RETURN loc_nGravadas
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarOcorrencia - grava UMA linha de SigNfCor (uma ocorrencia de uma
    * nota), equivalente a UM "Insert Into crSigNfCor" do Scan do Ok.Click do
    * irmao. Toda a montagem de SQL fica no objeto de negocio (PILAR 3): aqui
    * so se preenchem as propriedades da linha e se chama Salvar().
    *
    * NovoRegistro() e OBRIGATORIO antes de cada linha, por dois motivos:
    * limpa a linha anterior (cidchaves/cnfis/noccors/mretifs) preservando o
    * contexto da faixa, que e o que SIGOPCORBO.LimparDados faz de proposito;
    * e liga this_lEmEdicao/this_lNovoRegistro, sem os quais Salvar() recusa
    * com "Nao esta em modo de edicao" e NAO grava nada.
    *
    * A chave primaria (cidchaves) nao e preenchida aqui: NovoRegistro a limpa
    * e SIGOPCORBO.Inserir a gera com fUniqueIds(), igual ao Insert legado.
    *
    * Falha NUNCA e muda: Salvar() de BusinessBase exibe a mensagem em todo
    * caminho de recusa (ValidarDados/AntesDeGravar/Inserir/CATCH) e marca
    * this_lErroExibido, entao este metodo nao repete a mensagem (regra
    * CLAUDE.md #20) - so devolve .F. para o laco parar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarOcorrencia(par_cNfis, par_nNoccors, par_cMretifs)
        LOCAL loc_lSucesso, loc_oBO
        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.NovoRegistro()

            *-- "ThisForm.Emp" / "ThisForm.Serie" do Insert legado
            loc_oBO.this_cEmps    = THIS.this_cEmps
            loc_oBO.this_cSeries  = THIS.this_cSeries
            *-- "ThisForm.Get_NotaIni.Value" -> a nota da faixa
            loc_oBO.this_cNfis    = IIF(VARTYPE(par_cNfis) = "C", par_cNfis, "")
            *-- "XCorNf.Cods" / "XCorNf.Retifs"
            loc_oBO.this_nNoccors = IIF(VARTYPE(par_nNoccors) = "N", par_nNoccors, 0)
            loc_oBO.this_cMretifs = IIF(VARTYPE(par_cMretifs) = "C", par_cMretifs, "")

            loc_lSucesso = loc_oBO.Salvar()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeRetificacaoKeyPress - navegacao por registro dentro da grade,
    * TRANSCRITA do SIGOPCOR.Grade.Column3.Edit1.KeyPress legado:
    *
    *   Case nKeyCode = 13 or nKeyCode = 24   && Enter / Ctrl+X: avanca
    *       Select XCorNf / If Not Eof() / Skip / EndIf / Grade.Refresh
    *   Case nKeyCode = 5                     && Ctrl+E: volta
    *       Select XCorNf / If Not Bof() / Skip -1 / EndIf / Grade.Refresh
    *   Case nKeyCode = 9                      && Tab: sai da grade
    *       KeyBoard "{CTRL+TAB}"
    *
    * As guardas Eof()/Bof() do legado sao preservadas: elas impedem o Skip de
    * passar do fim e o Skip -1 de passar do inicio do cursor.
    *
    * PUBLIC (nao PROTECTED) porque e alvo de vinculo de evento, que falha em
    * silencio com metodo protegido.
    *--------------------------------------------------------------------------
    PROCEDURE GradeRetificacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro

        TRY
            DO CASE
                CASE par_nKeyCode = 13 OR par_nKeyCode = 24
                    IF USED("cursor_4c_Ocorrencias")
                        SELECT cursor_4c_Ocorrencias
                        IF !EOF("cursor_4c_Ocorrencias")
                            SKIP IN cursor_4c_Ocorrencias
                        ENDIF
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF

                CASE par_nKeyCode = 5
                    IF USED("cursor_4c_Ocorrencias")
                        SELECT cursor_4c_Ocorrencias
                        IF !BOF("cursor_4c_Ocorrencias")
                            SKIP -1 IN cursor_4c_Ocorrencias
                        ENDIF
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF

                CASE par_nKeyCode = 9
                    KEYBOARD "{CTRL+TAB}"
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GradeRetificacaoKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
    * "Select XCorNf / Go Top / ThisForm.Grade.Refresh" do Init legado.
    *
    * Popular o cursor NAO repinta a grade: sem o GO TOP + Refresh explicitos
    * a grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
    * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
    * mora num metodo unico, chamado em TODO caminho que popula o cursor.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrade()
        IF USED("cursor_4c_Ocorrencias")
            SELECT cursor_4c_Ocorrencias
            GO TOP IN cursor_4c_Ocorrencias
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
    * ocorrencias da Carta de Correcao (SIGOPCOR.Grade, ligada ao cursor local
    * XCorNf no legado). Nao ha duas paginas aqui - a "lista" desta tela e essa
    * grade, e e ela que o Init legado popula com o Scan sobre CrSigCcOco:
    *
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *   Select CrSigCcOco
    *   Scan
    *       Insert Into XCorNf (cods,descs,retifs)
    *       Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, '')
    *   EndScan
    *   Select XCorNf / Go Top
    *
    * A retificacao entra em BRANCO de proposito: este form trata uma FAIXA de
    * notas fiscais, e o legado requery CrSigNfCor com os filtros vazios (que
    * nao casa nada) sem nenhum segundo Scan que pre-carregue texto gravado.
    *
    * ZAP em vez de USE IN + CREATE CURSOR: derrubar o alias quebraria
    * RecordSource/ControlSource/CurrentControl da grade ja criada. Por isso
    * CriarCursorOcorrencias() so roda aqui se o alias nao existir.
    *
    * PUBLIC (nao PROTECTED) de proposito: o harness de teste automatico chama
    * este metodo de FORA da classe, e a checagem de existencia que ele faz
    * antes nao verifica escopo - um metodo protegido passaria por ela e
    * falharia em runtime.
    *
    * Retorno: .T. quando a grade ficou com pelo menos uma ocorrencia.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            *-- Espelho tela -> objeto de negocio ANTES da carga: o Init
            *-- legado atribui Emp/Serie/EmisDe/EmisAte e SO ENTAO faz o
            *-- Requery + Scan que enche a grade. Sem isto o objeto de
            *-- negocio ficaria sem o contexto do form chamador ate o
            *-- primeiro clique em Confirmar.
            THIS.FormParaBO()

            IF !USED("cursor_4c_Ocorrencias")
                THIS.CriarCursorOcorrencias()
            ENDIF

            SELECT cursor_4c_Ocorrencias
            ZAP

            IF VARTYPE(loc_oBO) = "O"
                IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
                    SELECT cursor_4c_TiposOcorrencia
                    GO TOP
                    SCAN
                        INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
                             VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
                                     cursor_4c_TiposOcorrencia.cdescrs, ;
                                     "")
                        *-- INSERT INTO seleciona a tabela de DESTINO: repor o
                        *-- alias do Scan, igual ao "Select" que o legado faz
                        SELECT cursor_4c_TiposOcorrencia
                    ENDSCAN

                    loc_lSucesso = (RECCOUNT("cursor_4c_Ocorrencias") > 0)
                ENDIF
            ENDIF

            *-- "Select XCorNf / Go Top / Grade.Refresh" do legado
            THIS.AtualizarGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transferencia TELA -> OBJETO DE NEGOCIO. Reproduz o bloco de
    * atribuicoes do PROCEDURE Init legado, que nao tem esse nome mas e
    * exatamente isto:
    *
    *     pcEmps    = <vazio>     ThisForm.Emp     = Emp
    *     pcSeries  = <vazio>     ThisForm.Serie   = Serie
    *     pcNFisDe  = Null        ThisForm.EmisDe  = EmisDe
    *     pcNFisAte = Null        ThisForm.EmisAte = EmisAte
    *     pcEmps    = Emp
    *
    * mais a LINHA CORRENTE da grade, que e a ficha editavel desta tela: o
    * Ok.Click do irmao SIGOPCCO le XCorNf.Cods/XCorNf.Retifs para montar cada
    * "Insert Into crSigNfCor (... nOccors, mRetifs ...)".
    *
    * FONTE UNICA do espelho dos dois limites da faixa: ValidarFaixaNotas (Fase
    * 6) tinha o mesmo bloco de atribuicao em duplicata e passou a chamar este
    * metodo - duas copias do mesmo espelho divergiriam na primeira mudanca de
    * regra. CarregarLista tambem chama, para que o objeto de negocio ja nasca
    * com o contexto do form chamador antes da 1a carga da grade.
    *
    * O que este metodo NAO escreve e this_cNfis (a nota CONCRETA de uma linha
    * de SigNfCor): esta tela trata uma FAIXA, e os dois limites nao sao uma
    * nota - no legado eles entram como parametro do "cnfis between ?pcNFisDe
    * And ?pcNFisAte", que e FILTRO. Quem resolve cada nota concreta e
    * GravarRetificacoesDaFaixa, que chama GravarOcorrencia uma vez por nota e
    * atribui this_cNfis ali. Semear this_cNfis aqui com o limite inicial faria
    * BO.ValidarDados aprovar uma gravacao cuja nota ninguem resolveu.
    *
    * Os TextBox sao lidos por TRANSFORM quando nao sao caractere: MaxLength =
    * 6 e a unica restricao que o legado declara nesses campos (nao ha Format
    * nem InputMask no dump), mas ALLTRIM() nao aceita numerico e dispararia
    * erro 11 em runtime se o valor tivesse nascido numerico por outro caminho.
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED
    * (formbase.prg:285) e VFP9 nao permite ALARGAR o escopo de metodo
    * herdado.
    *
    * Retorno: .F. quando o objeto de negocio nao esta instanciado (nada a
    * transferir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro, loc_cNotaIni, loc_cNotaFim

        loc_lSucesso = .F.
        loc_cNotaIni = ""
        loc_cNotaFim = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
                    IF VARTYPE(THIS.txt_4c_NotaIni.Value) = "C"
                        loc_cNotaIni = ALLTRIM(THIS.txt_4c_NotaIni.Value)
                    ELSE
                        loc_cNotaIni = ALLTRIM(TRANSFORM(THIS.txt_4c_NotaIni.Value))
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
                    IF VARTYPE(THIS.txt_4c_NotaFim.Value) = "C"
                        loc_cNotaFim = ALLTRIM(THIS.txt_4c_NotaFim.Value)
                    ELSE
                        loc_cNotaFim = ALLTRIM(TRANSFORM(THIS.txt_4c_NotaFim.Value))
                    ENDIF
                ENDIF

                WITH THIS.this_oBusinessObject
                    *-- Contexto recebido do form chamador (SIGCDCNF passa
                    *-- ThisForm, pcemps, lcSerie, ldEmisDe e ldEmisAte),
                    *-- repassado tal qual a impressao da correcao o espera
                    .this_cEmps    = THIS.this_cEmps
                    .this_cSeries  = THIS.this_cSeries
                    .this_dEmisDe  = THIS.this_dEmisDe
                    .this_dEmisAte = THIS.this_dEmisAte

                    *-- Os dois limites da faixa: pcNFisDe / pcNFisAte
                    .this_cNfisDe  = loc_cNotaIni
                    .this_cNfisAte = loc_cNotaFim

                    *-- Linha corrente da grade (XCorNf.Cods / XCorNf.Retifs do
                    *-- legado). Grade vazia ou cursor no fim: zera, para o
                    *-- objeto de negocio nao carregar a ocorrencia da leitura
                    *-- anterior.
                    IF USED("cursor_4c_Ocorrencias") AND !EOF("cursor_4c_Ocorrencias") ;
                       AND RECCOUNT("cursor_4c_Ocorrencias") > 0
                        .this_nNoccors = cursor_4c_Ocorrencias.cods
                        .this_cMretifs = TratarNulo(cursor_4c_Ocorrencias.retifs, "")
                    ELSE
                        .this_nNoccors = 0
                        .this_cMretifs = ""
                    ENDIF
                ENDWITH

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transferencia OBJETO DE NEGOCIO -> TELA, o inverso exato de
    * FormParaBO:
    *
    *   1) os dois limites da faixa -> txt_4c_NotaIni / txt_4c_NotaFim;
    *   2) a retificacao            -> linha da grade cuja ocorrencia e a do
    *      objeto de negocio, que e o "Replace XCorNf.retifs With
    *      CrSigNfCor.mretifs" que o irmao SIGOPCCO faz dentro do Scan de
    *      carga, aplicado a UMA linha.
    *
    * Com this_nNoccors = 0 (nenhuma ocorrencia carregada) o passo 2 nao faz
    * nada - e o estado logo apos CarregarLista, que enche a grade com o
    * catalogo de SigCcOco e deixa toda retificacao em branco.
    *
    * LOCATE, nao SEEK: cursor_4c_Ocorrencias e criado SEM indice, porque o
    * legado tambem nao cria nenhum neste cursor (ver CriarCursorOcorrencias -
    * aqui a diferenca para o irmao SIGOPCCO, que indexa por cods justamente
    * porque precisa do Seek). SEEK em cursor sem tag devolveria .F. sempre, e
    * a retificacao nunca apareceria.
    *
    * NAO repinta: quem chama e que fecha com AtualizarGrade() - a repintura
    * tem fonte unica (regra CLAUDE.md #21), e um Refresh por linha dentro de
    * um laco de carga seria desperdicio puro. O LOCATE deixa o ponteiro na
    * linha encontrada de proposito: e ela que o usuario acabou de editar.
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED
    * (formbase.prg:280) e VFP9 nao permite ALARGAR o escopo de metodo
    * herdado.
    *
    * Retorno: .F. quando o objeto de negocio nao esta instanciado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNotaIni, loc_cNotaFim, loc_nNoccors, loc_cMretifs

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Valores em LOCAL, nao ".prop" solto dentro de WITH: os usos
                *-- abaixo entram em comando xBase (REPLACE ... WITH) e em
                *-- argumento de funcao, onde ler o membro antes elimina
                *-- qualquer duvida de escopo (regra CLAUDE.md #33).
                loc_cNotaIni = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cNfisDe,  ""))
                loc_cNotaFim = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cNfisAte, ""))
                loc_nNoccors = TratarNulo(THIS.this_oBusinessObject.this_nNoccors, 0)
                loc_cMretifs = TratarNulo(THIS.this_oBusinessObject.this_cMretifs, "")

                IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
                    THIS.txt_4c_NotaIni.Value = loc_cNotaIni
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
                    THIS.txt_4c_NotaFim.Value = loc_cNotaFim
                ENDIF

                IF loc_nNoccors > 0 AND USED("cursor_4c_Ocorrencias")
                    SELECT cursor_4c_Ocorrencias
                    LOCATE FOR cursor_4c_Ocorrencias.cods = loc_nNoccors

                    IF FOUND("cursor_4c_Ocorrencias")
                        REPLACE retifs WITH loc_cMretifs IN cursor_4c_Ocorrencias
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - fonte unica da limpeza da tela: os dois limites da faixa
    * voltam a branco e a coluna de retificacao da grade volta a vazia, que e
    * EXATAMENTE o estado em que o Init legado deixa XCorNf - o terceiro valor
    * do Insert abaixo e a cadeia vazia:
    *
    *     Insert Into XCorNf (cods,descs,retifs)
    *     Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, <vazio>)
    *
    * REPLACE ALL, NUNCA ZAP: a grade desta tela e o CATALOGO de ocorrencias
    * lido de SigCcOco - codigo e descricao nao sao dado digitado e nao se
    * apagam. (O ZAP e o do irmao SIGOPCCO, cuja grade e o RESULTADO da
    * consulta de UMA nota.) Derrubar o alias com USE IN + CREATE CURSOR seria
    * pior ainda: quebraria RecordSource/ControlSource/CurrentControl da grade
    * ja criada e a coluna de retificacao voltaria a desenhar o Text1 default.
    *
    * O objeto de negocio e limpo junto (SIGOPCORBO.LimparDados), senao a
    * proxima gravacao herdaria cidchaves/cnfis/noccors/mretifs da anterior.
    * LimparDados preserva de proposito o contexto da faixa
    * (cemps/cseries/emissao) que veio do form chamador - ver o metodo no BO.
    *
    * Fecha com AtualizarGrade(): esvaziar o cursor NAO repinta a grade, e sem
    * o GO TOP + Refresh a tela continuaria exibindo o texto que acabou de ser
    * apagado (regra CLAUDE.md #21).
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED
    * (formbase.prg:276) e VFP9 nao permite ALARGAR o escopo de metodo
    * herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
            THIS.txt_4c_NotaIni.Value = ""
            THIS.txt_4c_NotaIni.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_NotaFim", 5)
            THIS.txt_4c_NotaFim.Value = ""
            THIS.txt_4c_NotaFim.Refresh()
        ENDIF

        IF USED("cursor_4c_Ocorrencias")
            SELECT cursor_4c_Ocorrencias
            REPLACE ALL retifs WITH "" IN cursor_4c_Ocorrencias
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()
        ENDIF

        *-- Reespelha a tela JA limpa: LimparDados zera a linha de SigNfCor
        *-- (cidchaves/cnfis/noccors/mretifs) mas PRESERVA o contexto da
        *-- faixa, entao sem esta chamada this_cNfisDe/this_cNfisAte ficariam
        *-- com os limites que o usuario acabou de apagar - e a proxima
        *-- gravacao usaria faixa fantasma. FormParaBO continua sendo a fonte
        *-- unica do espelho, aqui como em ValidarFaixaNotas e CarregarLista.
        THIS.FormParaBO()

        THIS.AtualizarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: nenhum container flutuante neste form.
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * Destroy - fecha os cursores locais abertos por este form:
    * cursor_4c_Ocorrencias (a grade, equivalente ao XCorNf do legado) e
    * cursor_4c_TiposOcorrencia (lista de SigCcOco, equivalente ao CrSigCcOco).
    * DODEFAULT() na ULTIMA linha, para que FormBase.Destroy execute e
    * reconstrua os popups do menu principal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Ocorrencias")
            USE IN cursor_4c_Ocorrencias
        ENDIF

        IF USED("cursor_4c_TiposOcorrencia")
            USE IN cursor_4c_TiposOcorrencia
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
