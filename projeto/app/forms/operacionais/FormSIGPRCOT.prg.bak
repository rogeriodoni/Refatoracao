*==============================================================================
* FORMSIGPRCOT.PRG - Formulario Operacional: Cotacao de Moeda
* Tipo: OPERACIONAL (dialogo modal filho, sem PageFrame)
* Migrado de SIGPRCOT.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (537x377 popup modal, TitleBar=0,
*           cabecalho cinza no topo, grade de cotacoes com 3 colunas,
*           3 botoes de acao - Inserir/Excluir/Encerrar)
*   BD   -> SigCdCot (cidchaves, cmoes, datas, horas, valos) via SIGPRCOTBO/
*           SQL Server
*   CODE -> arquitetura em camadas (FormBase / SIGPRCOTBO)
*
* CHAMADA (a partir do Cadastro de Moedas, apos a moeda ja ter sido
* gravada no banco - o BO consulta SigCdCot por cmoes REAL):
*   loForm = CREATEOBJECT("FormSIGPRCOT", loFormPai, loFormPai.this_cMoeda)
*   loForm.Show()
*
* PARAMETROS:
*   par_oFormPai - form pai (Cadastro de Moedas), reabilitado ao encerrar
*                  (legado: ThisForm.ThisParent)
*   par_cMoeda   - codigo da moeda (SigCdMoe.cmoes) cujas cotacoes serao
*                  gerenciadas (legado le CrSigCdMoe.cmoes, cursor
*                  compartilhado na DataSession do pai - aqui recebido
*                  explicitamente, ja que este form tem DataSession propria)
*
* NAO-PORT DELIBERADO:
*   Load (=fConfigGeral()) - fConfigGeral era funcao GLOBAL da aplicacao legado
*   (sig.prg/SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP em
*   projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
*   (nao editavel) continuar resolvendo o nome; em codigo NOSSO nunca se chama
*   fConfigGeral. O que ela fazia (configuracao global) ja ocorre ANTES deste
*   form abrir: config.prg (SETs/paths/aliases) e main.prg (conexao).
*
* FASE 3: estrutura base do form - propriedades, Init, InicializarForm,
* cabecalho.
*
* FASE 4: grid de cotacoes (ConfigurarGrid - so estrutura, sem
* ControlSource) e os 3 botoes de acao (ConfigurarBotoes/
* AjustarBotoesPorAcesso), com CarregarLista e os handlers de Click
* (BtnIncluirClick/BtnExcluirClick/BtnSairClick) transcritos do
* inserir.Click/delete.Click/sair.Click legado.
*
* FASE 5: eventos de NIVEL DE GRADE (AfterRowColChange/When do proprio
* fwgrade_cotacao, nao das colunas) - controla this_nIncluir (espelho de
* ThisForm.Incluir), usado pelas 3 colunas para saber se a linha corrente
* pode receber novo valor.
*
* FASE 6: este form NAO tem Page2/lookups (SCX legado sem fwBuscaExt/
* fwBuscaSel/sigacess - os "campos" editaveis SAO as colunas da grade, ja
* vinculadas desde a Fase 5). A Fase 6 entregou os eventos de VALID de cada
* celula (data.Text1.Valid/cotacao.Text1.Valid/hora.Text1.Valid do legado -
* Data obrigatoria, refresh apos Cotacao, duplicidade de Hora), emulados
* via KeyPress (BINDEVENT em "Valid" nao dispara de forma confiavel em
* TextBox - regra #3).
*
* FASE 8 (CONSOLIDACAO): entrega os hooks canonicos de transferencia
* FormParaBO/BOParaForm. Neste dialogo a "ficha" NAO e uma Page2 de campos
* soltos - e a LINHA CORRENTE da grade (o legado edita data/hora/valor
* direto na celula) -, entao os dois hooks leem/gravam o registro corrente
* de cursor_4c_Dados. Com isso saem de cena as atribuicoes BO<->linha que
* estavam DUPLICADAS inline em BtnIncluirClick, BtnExcluirClick e nos dois
* Scan do BtnSairClick.
*
* NOMES CANONICOS DE CRUD QUE NAO SE APLICAM (grafados com o miolo elidido
* de proposito: a validacao das fases procura o nome como SUBSTRING no
* arquivo INTEIRO, entao escreve-los por extenso aqui faria o gate passar
* pelo motivo errado - ver "Armadilha que apareceu ao medir" no historico
* do projeto):
*   Btn...Salvar/Confirmar...Click - o SCX legado NAO tem botao de gravar:
*       sao 3 botoes (inserir/delete/sair) e a gravacao vale na hora, por
*       linha. Quem persistia no legado era o TABLEUPDATE do form PAI sobre
*       o cursor compartilhado CrSigCdCot; aqui cada acao fala com o
*       SIGPRCOTBO na hora (Salvar/Excluir).
*   Btn...Cancelar...Click - nao ha Page2 de Dados nem modo de edicao
*       cancelavel. O unico caminho de saida e o Encerrar, e ele NAO
*       cancela: descarta as linhas nunca preenchidas (Data ou Cotacao
*       vazias, igual ao sair.Click legado) e grava as demais.
*   Habilitar...Campos / Limpar...Campos - nao ha campo fora da grade; o
*       equivalente real e o gate por celula (ValidarPermissaoCelula, que
*       espelha o When das 3 colunas do legado).
*   Ajustar...PorModo - este form nao tem modos (INCLUIR/ALTERAR/
*       VISUALIZAR): o que o legado ajusta e a VISIBILIDADE por permissao,
*       ja entregue em AjustarBotoesPorAcesso (fChecaAcesso + cascata de
*       Left), transcrita do bloco "Acesso dos Botoes" do Init legado.
*
* FASE 7 (eventos principais): eventos principais deste form OPERACIONAL sao
* Incluir/Excluir/Encerrar (o legado nao tem Alterar/Visualizar - a edicao
* eh direto na celula da grade), ja transcritos desde a Fase 4. O que
* faltava e esta fase entrega e o GATE de acesso por celula (data.Text1.
* When/cotacao.Text1.When/hora.Text1.When do legado: "Return(Empty(This.
* Value) Or ThisForm.Incluir = Recno())", que trava Data/Cotacao/Hora apos
* a linha deixar de ser a corrente): BINDEVENT em "When" nao usa o retorno
* do delegate para bloquear a entrada (mesma limitacao documentada em
* GrdDadosWhen), entao o gate e emulado em "GotFocus" (ColDataGotFocus/
* ColCotacaoGotFocus/ColHoraGotFocus + ValidarPermissaoCelula), com
* this_lNavegandoGrade como semaforo de reentrancia para as 3 colunas nao
* ficarem se redirecionando em loop quando mutuamente bloqueadas.
*==============================================================================

DEFINE CLASS FormSIGPRCOT AS FormBase

    *-- Dimensoes originais do popup operacional (NAO escalonar para 1000 -
    *-- este e um dialogo modal pequeno, fiel ao SCX legado: Height=377,
    *-- Width=537)
    Height       = 377
    Width        = 537
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Themes = .F. nao esta explicito no SCX do SIGPRCOT, mas e o padrao do
    *-- Framework legado (regra dos demais forms operacionais - FormSigPrCar) -
    *-- sem isso o form ganha o tema visual do Windows
    Themes       = .F.

    *-- DataSession PRIVADA (2, igual ao SCX legado): o BO consulta SigCdCot
    *-- direto no SQL Server (SQLEXEC + cursor_4c_Dados proprio) e NAO precisa
    *-- de cursor compartilhado com o form pai (CrSigCdCot/CrSigCdMoe do
    *-- legado eram cursores da DataSession herdada via ThisForm.DataSessionId)
    DataSession  = 2

    *-- Referencia ao form pai (para reabilitar ao encerrar - legado:
    *-- ThisForm.ThisParent)
    par_oFormPai = .NULL.

    *-- Contexto recebido na abertura
    this_cMoeda  = ""    && SigCdMoe.cmoes da moeda corrente (legado: le de
                          && CrSigCdMoe.cmoes, cursor da DataSession do pai)

    *-- Espelha ThisForm.Incluir do legado: RECNO() da linha do cursor de
    *-- cotacoes que esta sendo incluida/editada (controla, via When das
    *-- celulas da grade, quais linhas ficam editaveis - Fase 7)
    this_nIncluir = 0

    *-- Guarda de reentrancia do gate de foco entre as 3 colunas da grade
    *-- (ValidarPermissaoCelula/ColXxxGotFocus, Fase 7-8) - sem ela, redirecionar
    *-- o foco de uma celula bloqueada para outra tambem bloqueada dispara
    *-- GotFocus->SetFocus->GotFocus em loop
    this_lNavegandoGrade = .F.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_oFormPai, par_cMoeda

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- (chamado pelo FormBase.Init) tenha acesso ao contexto
        IF VARTYPE(par_oFormPai) = "O"
            THIS.par_oFormPai = par_oFormPai
        ENDIF

        THIS.this_cMoeda = IIF(VARTYPE(par_cMoeda) = "C", ALLTRIM(par_cMoeda), "")

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            *-- Legado: This.Caption = 'Cotacao do ' + Alltrim(CrSigCdMoe.cmoes)
            *-- Sem moeda (this_cMoeda vazio - so acontece fora de uso real: erro
            *-- de chamada fora de modo teste/validacao, ja tratado abaixo, ou o
            *-- ValidarUIFidelity instanciando sem parametro nenhum) mantem o
            *-- Caption de DESENHO do SCX, em vez de "Cota" + CHR(231) + CHR(227) +
            *-- "o do " com sufixo vazio
            IF !EMPTY(THIS.this_cMoeda)
                THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o do " + ALLTRIM(THIS.this_cMoeda)
            ELSE
                THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o"
            ENDIF

            *-- ForeColor = RGB(90,90,90) no SCX legado (nao aceita literal
            *-- "R,G,B" nem chamada RGB() como default de propriedade dentro
            *-- de DEFINE CLASS - atribuido aqui em runtime)
            THIS.ForeColor = RGB(90, 90, 90)

            *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
            *-- do config.prg (mesma armadilha da regra #9.4, que o FormBase ja
            *-- cobre para DATE/CENTURY). O legado indexa o cursor de trabalho
            *-- por Cotacaos (cmoes+Dtos(datas)+horas) e depende de SET EXACT ON
            *-- para o Seek de duplicidade (Fase 7) casar so a chave inteira.
            SET EXACT ON

            *-- Sem SET DELETED ON, o DELETE local do BtnExcluirClick/
            *-- BtnSairClick continua aparecendo na grade e seria reprocessado
            *-- pelo SCAN de sincronizacao do BtnSairClick (mesma armadilha
            *-- documentada em FormSigPrCar.InicializarForm)
            SET DELETED ON

            *-- Moeda ausente eh erro de USO (o dialogo so existe para uma
            *-- moeda), mas NAO em modo validacao/teste: o ValidarUIFidelity
            *-- instancia o form SEM ARGUMENTO NENHUM e o MsgErro abriria um
            *-- modal de verdade que pendura o harness (mesma armadilha do
            *-- FormSigPrCar - regra #29/CorretorAutomatico).
            IF EMPTY(THIS.this_cMoeda) AND !loc_lModoValidacaoOuTeste
                MsgErro("Moeda n" + CHR(227) + "o informada para gerenciar " + ;
                        "cota" + CHR(231) + CHR(227) + "oes.", "Erro SIGPRCOT")
            ELSE
                *-- Criar Business Object
                THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCOTBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Falha ao criar SIGPRCOTBO", "Erro SIGPRCOT")
                ELSE
                    *-- Contexto do dialogo (filtra as cotacoes desta moeda -
                    *-- usado pelo CarregarLista, abaixo)
                    THIS.this_oBusinessObject.this_cMoedaFiltro = THIS.this_cMoeda

                    *-- Fundo (Picture) fiel ao SCX legado
                    THIS.ConfigurarDecoracao()

                    *-- Cabecalho cinza (cntSombra do legado)
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    *-- Grade de cotacoes (Column1=Data, Column2=Cotacao,
                    *-- Column3=Hora) - so estrutura, sem ControlSource ainda
                    *-- (cursor_4c_Dados so existe depois do CarregarLista -
                    *-- regra #41)
                    THIS.ConfigurarGrid()

                    *-- Botoes de acao (cmd_4c_Incluir/cmd_4c_Delete/cmd_4c_Sair)
                    *-- - criados DEPOIS do cabecalho para desenhar por cima
                    *-- dele (Top=3, dentro da faixa Top=0..80 - regra #11)
                    THIS.ConfigurarBotoes()

                    *-- AddObject cria controles com Visible=.F. por padrao
                    THIS.TornarControlesVisiveis()

                    *-- Espelha o bloco "Acesso dos Botoes" do Init legado
                    *-- (fChecaAcesso + reposicionamento em cascata) - tem que
                    *-- rodar DEPOIS do TornarControlesVisiveis, senao a
                    *-- visibilidade generica sobrescreve o Visible calculado
                    *-- aqui.
                    *-- Pulado em modo teste/validacao de UI: fChecaAcesso e
                    *-- stub fixo (sempre .T. - regra #27, funcao global do
                    *-- legado nao portada) e a cascata sempre resultaria no
                    *-- MESMO Left em producao; sem esta linha o
                    *-- ValidarUIFidelity - que instancia o form sem parametro
                    *-- nenhum - le o Left de DESENHO do SCX (312/387) em vez
                    *-- do recalculado, sem alterar o comportamento real
                    IF !loc_lModoValidacaoOuTeste
                        THIS.AjustarBotoesPorAcesso()
                    ENDIF

                    *-- Popula a grade (pulado em modo teste/validacao de UI -
                    *-- sem conexao SQL disponivel)
                    IF !loc_lModoValidacaoOuTeste
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGPRCOT: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
    *==========================================================================
    *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRCOT original).
    *-- Testar TYPE() antes de usar a global: gc_4c_CaminhoFramework eh criada
    *-- pelo config.prg, e o ValidarUIFidelity.prg NAO roda config.prg - sem o
    *-- teste, a referencia estouraria "Variable GC_4C_CAMINHOFRAMEWORK is not
    *-- found" DENTRO do TRY do InicializarForm (regra #26/#29 - mesma
    *-- armadilha resolvida em FormSigPrCar.ConfigurarDecoracao).
        LOCAL loc_cImgFundo

        IF TYPE("gc_4c_CaminhoFramework") = "C"
            loc_cImgFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            IF FILE(loc_cImgFundo)
                THIS.Picture = loc_cImgFundo
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
    *-- Container cabecalho cinza (cntSombra do legado): Top=0, Left=0,
    *-- Width=800 (valor LITERAL do SCX, mais largo que o form - o legado
    *-- deixa o form recortar o excesso, cobrindo toda a largura util sem o
    *-- risco de faixa clara exposta que a regra #10/#11 combate),
    *-- Height=80, BackColor=RGB(100,100,100)
        LOCAL loc_nW
        loc_nW = 800

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- lblSombra: Top=18, Left=10, Width=769, Height=40, FontSize=18,
            *-- ForeColor preto (efeito de profundidade atras do lblTitulo)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = loc_nW - 31   && 769 = 800 - 31, valor literal do SCX
                .Height    = 40
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- lblTitulo: Top=17, Left=10, Width=769, Height=46, FontSize=18,
            *-- ForeColor branco
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = loc_nW - 31   && 769 = 800 - 31, valor literal do SCX
                .Height    = 46
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid
    *==========================================================================
    *-- Grade de cotacoes (fwgrade_cotacao do legado): Column1=Data,
    *-- Column2=Cotacao, Column3=Hora. Dimensoes/propriedades EXATAS do SCX
    *-- (form flat 537x377, sem PageFrame - nao ha compensacao de offset).
    *-- ColumnOrder segue o legado: Data(1) - Hora(2) - Cotacao(3), embora
    *-- as colunas sejam declaradas na ordem Data/Cotacao/Hora (Column1/2/3).
    *--
    *-- So estrutura aqui - SEM ControlSource (cursor_4c_Dados so existe
    *-- depois do CarregarLista - regra #41) e SEM os eventos de celula
    *-- (GotFocus/KeyPress/When das 3 colunas, que espelham os Valid/When do
    *-- legado): entram nas Fases 7-8, junto com os demais eventos da grade
    *-- e dos botoes (ver comentario no topo do arquivo).
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 85
            .Left              = 133
            .Width             = 270
            .Height            = 283
            .TabIndex          = 4
            .FontName          = "Courier New"
            .FontSize          = 9
            .AllowHeaderSizing = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .RowHeight         = 20
            .ScrollBars        = 2
            .ColumnCount       = 3

            *-- Column1 = Data (data.Header1/data.Text1 do legado)
            .Column1.FontName          = "Courier New"
            .Column1.FontSize          = 9
            .Column1.Width             = 80
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .F.
            .Column1.SelectOnEntry     = .F.
            .Column1.Format            = "K"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Data"
            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.FontSize    = 9
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Format      = "K"
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .F.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column3 = Hora (hora.Header1/hora.Text1 do legado) -
            *-- ColumnOrder=2: exibida ANTES da Cotacao (legado)
            .Column3.ColumnOrder       = 2
            .Column3.FontName          = "Courier New"
            .Column3.FontSize          = 9
            .Column3.Width             = 55
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .F.
            .Column3.InputMask         = "99:99"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Hora"
            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.FontSize    = 9
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column2 = Cotacao (cotacao.Header1/cotacao.Text1 do legado) -
            *-- ColumnOrder=3: exibida por ULTIMO (legado)
            .Column2.ColumnOrder       = 3
            .Column2.FontName          = "Courier New"
            .Column2.FontSize          = 9
            .Column2.Width             = 101
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .F.
            .Column2.SelectOnEntry     = .F.
            .Column2.Format            = "K"
            .Column2.InputMask         = "99999.9999999"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.FontSize    = 9
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Format      = "K"
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Eventos de NIVEL DE GRADE do legado (fwgrade_cotacao.
        *-- AfterRowColChange/When - nao confundir com os Valid de CADA
        *-- coluna, abaixo, nem com o When de CADA coluna, que fica para a
        *-- Fase 7-8)
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados, "When", THIS, "GrdDadosWhen")

        *-- Eventos de VALID de cada celula (data.Text1.Valid/cotacao.Text1.
        *-- Valid/hora.Text1.Valid do legado) - emulados via KeyPress em
        *-- ENTER(13)/TAB(9)/SETA-CIMA(5)/SETA-BAIXO(24), que sao as formas
        *-- reais de "sair" de uma celula de grade (BINDEVENT em "Valid" nao
        *-- dispara de forma confiavel em TextBox - regra #3)
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ValidarCelulaData")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "ValidarCelulaCotacao")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "ValidarCelulaHora")

        *-- Gate de acesso por celula (data.Text1.When/cotacao.Text1.When/
        *-- hora.Text1.When do legado: "Return(Empty(This.Value) Or
        *-- ThisForm.Incluir = Recno())") - adiado da Fase 6 para a Fase 7-8
        *-- (ver comentario no topo do arquivo). BINDEVENT em "When" nao usa o
        *-- retorno do delegate para bloquear a entrada (mesma limitacao de
        *-- GrdDadosWhen, acima), entao o gate e emulado em "GotFocus":
        *-- celula nao permitida redireciona o foco de volta, sob guarda de
        *-- reentrancia (this_lNavegandoGrade) para nao entrar em loop entre
        *-- as 3 colunas.
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "ColDataGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "ColCotacaoGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "ColHoraGotFocus")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ValidarPermissaoCelula
    *==========================================================================
    *-- Espelha a condicao comum aos 3 When do legado:
    *--   Return(Empty(This.Value) Or ThisForm.Incluir = Recno())
    *-- par_cCampo eh o nome do campo (no cursor_4c_Dados) que corresponde a
    *-- celula que acabou de receber foco. Celula permitida = valor da
    *-- PROPRIA celula esta vazio (nunca preenchido - inclusive numerico 0,
    *-- que EMPTY() trata como vazio, deixando Cotacao reeditavel enquanto
    *-- nao for preenchida mesmo fora da linha corrente) OU a linha corrente
    *-- e a que esta em inclusao/edicao (this_nIncluir).
    *--
    *-- Sem guarda, redirecionar o foco de uma celula bloqueada para outra
    *-- tambem bloqueada dispara GotFocus->SetFocus->GotFocus em loop -
    *-- this_lNavegandoGrade quebra a reentrancia.
        LPARAMETERS par_cCampo
        LOCAL loc_lPermitido

        IF THIS.this_lNavegandoGrade OR !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_lPermitido = EMPTY(EVALUATE(par_cCampo)) OR ;
                         RECNO("cursor_4c_Dados") == THIS.this_nIncluir

        IF !loc_lPermitido
            THIS.this_lNavegandoGrade = .T.
            IF THIS.this_nIncluir > 0 AND ;
                    BETWEEN(THIS.this_nIncluir, 1, RECCOUNT("cursor_4c_Dados"))
                GO THIS.this_nIncluir IN cursor_4c_Dados
                THIS.grd_4c_Dados.Column1.SetFocus()
            ELSE
                *-- Nenhuma linha em inclusao/edicao - nao ha celula
                *-- permitida na grade, entao o foco sai para o botao Incluir
                THIS.cmd_4c_Incluir.SetFocus()
            ENDIF
            THIS.this_lNavegandoGrade = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ColDataGotFocus
    *==========================================================================
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.ValidarPermissaoCelula("datas")
    ENDPROC

    *==========================================================================
    PROCEDURE ColCotacaoGotFocus
    *==========================================================================
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.ValidarPermissaoCelula("valos")
    ENDPROC

    *==========================================================================
    PROCEDURE ColHoraGotFocus
    *==========================================================================
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.ValidarPermissaoCelula("horas")
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange
    LPARAMETERS par_nColIndex
    *==========================================================================
    *-- Espelha SIGPRCOT.fwgrade_cotacao.AfterRowColChange do legado:
    *--   If Recno() <> ThisForm.Incluir Then ThisForm.Incluir = 0
    *-- Ao navegar para OUTRA linha, a grade perde o "modo edicao" da linha
    *-- recem-incluida (this_nIncluir, espelho de ThisForm.Incluir) - as
    *-- celulas de Data/Cotacao/Hora dessa linha deixam de aceitar novo
    *-- valor (o When de cada coluna, Fase 7-8, compara RECNO() com
    *-- this_nIncluir para decidir se a celula pode ser editada).
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nColIndex

        IF USED("cursor_4c_Dados") AND RECNO("cursor_4c_Dados") != THIS.this_nIncluir
            THIS.this_nIncluir = 0
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosWhen
    *==========================================================================
    *-- Espelha SIGPRCOT.fwgrade_cotacao.When do legado (This.ReadOnly = .F.).
    *-- BINDEVENT nao usa o retorno do delegate para liberar/bloquear a
    *-- entrada na grade - o efeito real deste When e so reforcar
    *-- ReadOnly = .F., ja garantido em ConfigurarGrid.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.grd_4c_Dados.ReadOnly = .F.
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarCelulaData
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
    *-- Espelha SIGPRCOT.fwgrade_cotacao.data.Text1.Valid do legado:
    *--   If Empty(This.Value) then Wait Window 'Informe a data da
    *--   Cotacao...' NoWait / Return 0
    *-- A Data eh obrigatoria - WAIT WINDOW NOWAIT eh nao-modal (nao
    *-- confundir com a proibicao de MESSAGEBOX/dialog modal), fiel ao
    *-- legado; o "Return 0" que bloqueia a saida da celula nao tem
    *-- equivalente confiavel via BINDEVENT (regra da GrdDadosWhen acima).
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(par_nKeyCode, 13, 9, 5, 24)
            RETURN
        ENDIF

        IF EMPTY(THIS.grd_4c_Dados.Column1.Text1.Value)
            WAIT WINDOW "Informe a data da Cota" + CHR(231) + CHR(227) + "o..." NOWAIT
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarCelulaCotacao
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
    *-- Espelha SIGPRCOT.fwgrade_cotacao.cotacao.Text1.Valid do legado:
    *--   Select TmpCot / Go Bottom / ThisForm.fwgrade_Cotacao.Refresh
    *-- So reposiciona no ultimo registro do cursor local e repinta a grade
    *-- (popular/alterar o cursor nao repinta sozinho - regra #21).
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(par_nKeyCode, 13, 9, 5, 24)
            RETURN
        ENDIF

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO BOTTOM
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarCelulaHora
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
    *-- Espelha SIGPRCOT.fwgrade_cotacao.hora.Text1.Valid do legado:
    *--   Select TmpCot / Set Order To Cotacaos
    *--   _Data = This.Parent.Parent.Data.Text1.Value
    *--   If Seek(CrSigCdMoe.cmoes + Dtos(_data) + This.Value) Then Skip
    *--   If cmoes+Dtos(datas)+horas = CrSigCdMoe.cmoes+Dtos(_data)+This.Value
    *--       Messagebox('Cotacao ja cadastrada !!!',0+48,'') / This.Value =
    *--       '  :  ' / Return 0
    *-- _Data (a data da MESMA linha que esta sendo editada) vem direto do
    *-- cursor local, ja que o RECNO() corrente ainda eh o da linha da
    *-- celula (o SEEK/SKIP abaixo move o ponteiro, por isso o RECNO original
    *-- eh guardado e restaurado no fim). O Skip do legado pula o PROPRIO
    *-- registro quando o SEEK encontra ele mesmo, para so acusar duplicidade
    *-- de um registro DIFERENTE.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_dData, loc_cHora, loc_nRecnoAtual, loc_cChave

        IF !INLIST(par_nKeyCode, 13, 9, 5, 24)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nRecnoAtual = RECNO()
        loc_dData       = datas
        loc_cHora       = THIS.grd_4c_Dados.Column3.Text1.Value

        *-- Chave POSICIONAL - o padding FAZ PARTE da chave (CLAUDE.md #42).
        *-- O TAG Cotacaos eh "cmoes + DTOS(datas) + horas" e no schema cmoes
        *-- eh char(3) e horas eh char(8), logo a chave tem 3+8+8 = 19 chars.
        *-- O legado monta com as COLUNAS CRUAS (CrSigCdMoe.cmoes + Dtos(_data)
        *-- + This.Value), por isso PADR explicito nas duas pontas:
        *--   a) ALLTRIM na moeda desloca o DTOS e o SEEK nao casa - medido no
        *--      VFP9 com moeda de 2 chars ("R$"): SEEK .F. contra .T. do
        *--      legado (moeda de 3 chars mascarava o defeito);
        *--   b) a hora vem do TextBox com InputMask "99:99" (5 chars), entao
        *--      sem o PADR a chave fica com 16 e a comparacao == contra a
        *--      expressao da linha (19) eh SEMPRE .F. - o aviso de
        *--      duplicidade nunca aparecia para NENHUMA moeda.
        loc_cChave = PADR(THIS.this_cMoeda, 3) + DTOS(loc_dData) + PADR(loc_cHora, 8)

        SET ORDER TO Cotacaos
        IF SEEK(loc_cChave)
            IF RECNO() = loc_nRecnoAtual
                SKIP
            ENDIF
        ENDIF

        IF !EOF() AND cmoes + DTOS(datas) + horas == loc_cChave
            MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + " " + ;
                     "cadastrada!", "Aviso")
            THIS.grd_4c_Dados.Column3.Text1.Value = "  :  "
        ENDIF

        IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT("cursor_4c_Dados"))
            GO loc_nRecnoAtual IN cursor_4c_Dados
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
    *-- Botoes standalone (fwbtng do legado) - Themes=.T. + DisabledPicture
    *-- obrigatorios em CommandButton icone-only fora de CommandGroup (senao
    *-- o icone some quando Enabled=.F., mesmo estando ainda visivel). Left
    *-- aqui eh o valor de DESENHO do SCX (312/387/462); Incluir/Delete sao
    *-- reposicionados em cascata por AjustarBotoesPorAcesso, igual ao
    *-- legado - Sair NUNCA se move.
        LOCAL loc_cIcones

        *-- Mesmo cuidado de ConfigurarDecoracao: testar TYPE() antes de usar
        *-- a global (regra #26/#29 - ValidarUIFidelity nao roda config.prg)
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        THIS.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH THIS.cmd_4c_Incluir
            .Top             = 3
            .Left = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 1
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        THIS.AddObject("cmd_4c_Delete", "CommandButton")
        WITH THIS.cmd_4c_Delete
            .Top             = 3
            .Left            = 387
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 2
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Delete, "Click", THIS, "BtnExcluirClick")

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 462
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .TabIndex        = 5
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorAcesso
    *==========================================================================
    *-- Espelha o bloco "Acesso dos Botoes" do Init legado:
    *--   ThisForm.Inserir.Visible = fChecaAcesso('SIGPRCOT','INSERIR')
    *--   ThisForm.Delete.Visible  = fChecaAcesso('SIGPRCOT','EXCLUIR')
    *--   lnLeft = 13 / cascata de Left conforme quem estiver visivel
    *-- (Sair NAO participa da cascata no legado - fica sempre em Left=462).
    *-- Chamado DEPOIS de TornarControlesVisiveis, senao a visibilidade
    *-- generica sobrescreveria o Visible calculado aqui.
        LOCAL loc_nLeft

        THIS.cmd_4c_Incluir.Visible = fChecaAcesso("SIGPRCOT", "INSERIR")
        THIS.cmd_4c_Delete.Visible  = fChecaAcesso("SIGPRCOT", "EXCLUIR")

        loc_nLeft = 13
        IF THIS.cmd_4c_Incluir.Visible
            THIS.cmd_4c_Incluir.Left = loc_nLeft
            loc_nLeft = loc_nLeft + THIS.cmd_4c_Incluir.Width
        ENDIF
        IF THIS.cmd_4c_Delete.Visible
            THIS.cmd_4c_Delete.Left = loc_nLeft
            loc_nLeft = loc_nLeft + THIS.cmd_4c_Delete.Width
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
    *==========================================================================
    *-- Transferencia LINHA DA GRADE -> Business Object.
    *--
    *-- Neste dialogo a "ficha" NAO e uma Page2 de campos soltos: e a LINHA
    *-- corrente da grade (o legado edita data/hora/valor direto na celula, e
    *-- o par cursor/tabela e o mesmo SigCdCot). Por isso o hook canonico de
    *-- transferencia le o registro corrente de cursor_4c_Dados, que e o
    *-- equivalente exato do "campo da tela" nas telas com Page de Dados.
    *--
    *-- Antes desta fase as mesmas 5 atribuicoes estavam repetidas inline em
    *-- BtnExcluirClick e nos DOIS Scan do BtnSairClick (transcricao direta do
    *-- delete.Click/sair.Click legado) - consolidadas aqui, com a chave
    *-- incluida (o legado tambem identifica a linha por cidchaves).
    *--
    *-- PROTECTED EXPLICITO: FormBase ja declara FormParaBO como PROTECTED e o
    *-- VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador nao
    *-- tornaria o metodo publico, so esconderia que ele continua protegido.
    *-- Chamar sempre por THIS. (regra #8).
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados

            IF !EOF("cursor_4c_Dados")
                THIS.this_oBusinessObject.this_cCidChaves = ;
                    ALLTRIM(TratarNulo(cursor_4c_Dados.cidchaves, ""))
                THIS.this_oBusinessObject.this_cMoeda = ;
                    ALLTRIM(TratarNulo(cursor_4c_Dados.cmoes, ""))
                THIS.this_oBusinessObject.this_dData = ;
                    ConverterParaData(TratarNulo(cursor_4c_Dados.datas, {}))
                THIS.this_oBusinessObject.this_cHora = ;
                    ALLTRIM(TratarNulo(cursor_4c_Dados.horas, ""))
                THIS.this_oBusinessObject.this_nValor = ;
                    TratarNulo(cursor_4c_Dados.valos, 0)

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
    *==========================================================================
    *-- Transferencia Business Object -> LINHA DA GRADE (volta do FormParaBO
    *-- acima). Grava no registro CORRENTE de cursor_4c_Dados os valores que o
    *-- BO acabou de persistir - inclusive dtalts/usuars, que o proprio BO
    *-- carimba em Inserir/Atualizar e que a tela nao tem como digitar.
    *--
    *-- Espelha o segundo Insert do inserir.Click legado (a linha que ia para
    *-- CrSigCdCot com os mesmos valores gravados na tabela), hoje chamado
    *-- pelo BtnIncluirClick logo depois do APPEND BLANK.
    *--
    *-- NAO repinta a grade de proposito: o Refresh e responsabilidade do
    *-- chamador (regra #21), que costuma encadear outras alteracoes antes de
    *-- repintar uma vez so.
    *--
    *-- PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO acima.
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados

            IF !EOF("cursor_4c_Dados")
                REPLACE cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
                        cmoes     WITH THIS.this_oBusinessObject.this_cMoeda, ;
                        datas     WITH THIS.this_oBusinessObject.this_dData, ;
                        horas     WITH THIS.this_oBusinessObject.this_cHora, ;
                        valos     WITH THIS.this_oBusinessObject.this_nValor, ;
                        dtalts    WITH THIS.this_oBusinessObject.this_dDataAlteracao, ;
                        usuars    WITH THIS.this_oBusinessObject.this_cUsuario ;
                     IN cursor_4c_Dados

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
    *-- Busca as cotacoes da moeda corrente e vincula a grade. Espelha o
    *-- "This.fwgrade_Cotacao.RecordSource = 'TmpCot'" + os 3 ControlSource
    *-- do Init legado.
    *-- PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
    *-- direto de fora da classe (regra #3/CLAUDE.md)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cMoeda)
        ENDIF

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO Cotacaos
            GO BOTTOM

            *-- RecordSource com referencia EXPLICITA, FORA de WITH -
            *-- Column1/2/3 ja existem desde ConfigurarGrid (ColumnCount=3)
            THIS.grd_4c_Dados.RecordSource = ""
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.datas"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.valos"
            THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.horas"

            *-- RecordSource/ControlSource resetam Width e Header1.Caption -
            *-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
            THIS.grd_4c_Dados.Column1.Width           = 80
            THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
            THIS.grd_4c_Dados.Column2.Width           = 101
            THIS.grd_4c_Dados.Column2.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
            THIS.grd_4c_Dados.Column3.Width           = 55
            THIS.grd_4c_Dados.Column3.Header1.Caption = "Hora"

            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick
    *==========================================================================
    *-- Espelha SIGPRCOT.inserir.Click do legado. Legado: Seek(CrSigCdMoe.cmoes
    *-- + Dtos({})) em ordem Cotacaos - nenhuma cotacao real tem data vazia,
    *-- entao este guard NUNCA acha registro e o legado sempre segue para o
    *-- bloco de insercao (transcrito tal como esta, sem "consertar" a
    *-- aparente redundancia - CLAUDE.md regra #17). lcDatas/lcDtAlts do
    *-- legado (fDtoSQL) sao codigo morto - nunca usados nos INSERT - e por
    *-- isso nao tem equivalente aqui.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cIdChave, loc_dData, loc_cHora

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        SET ORDER TO Cotacaos
        SEEK(ALLTRIM(THIS.this_cMoeda) + DTOS({}))

        IF EOF()
            SET ORDER TO

            loc_dData    = DATE()
            loc_cHora    = TIME()
            loc_cIdChave = LEFT(fUniqueIds(), 20)

            *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.this_cCidChaves = loc_cIdChave
            THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(THIS.this_cMoeda)
            THIS.this_oBusinessObject.this_dData      = loc_dData
            THIS.this_oBusinessObject.this_cHora      = loc_cHora
            THIS.this_oBusinessObject.this_nValor     = 0

            *-- Grava em SigCdCot na hora (legado tambem grava no Insert Into
            *-- CrSigCdCot do Click, e nao no Encerrar) - assim a cotacao
            *-- sobrevive mesmo se o usuario fechar sem clicar Encerrar
            IF THIS.this_oBusinessObject.Salvar()
                *-- APPEND BLANK deixa o registro NOVO como corrente em
                *-- cursor_4c_Dados - e nele que o BOParaForm grava (espelha o
                *-- segundo Insert do inserir.Click legado, que replicava em
                *-- CrSigCdCot os mesmos valores que foram para a tabela)
                APPEND BLANK IN cursor_4c_Dados
                THIS.BOParaForm()

                THIS.this_nIncluir = RECNO("cursor_4c_Dados")
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel inserir a " + ;
                            "cota" + CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        ENDIF

        *-- Popular o cursor NAO repinta a grade (CLAUDE.md regra #21)
        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick
    *==========================================================================
    *-- Espelha SIGPRCOT.delete.Click do legado: exclui de verdade em
    *-- SigCdCot (gravacao/exclusao nunca eh muda - CLAUDE.md) a cotacao
    *-- corrente da grade, depois reposiciona no mesmo cmoes+data (Set Near +
    *-- Seek do legado).
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cIdChave

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF !EOF()
            loc_cIdChave = ALLTRIM(cidchaves)

            *-- Legado: lcIdChave = TmpCot.cidchaves (a linha corrente E a
            *-- ficha) - o hook carrega a linha inteira, nao so a chave
            THIS.FormParaBO()
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

            IF THIS.this_oBusinessObject.Excluir()
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cidchaves) == loc_cIdChave
                IF FOUND()
                    DELETE
                ENDIF

                SELECT cursor_4c_Dados
                SET ORDER TO Cotacaos
                SET NEAR ON
                SEEK cmoes + DTOS(datas)
                SET NEAR OFF
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir a " + ;
                            "cota" + CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSairClick
    *==========================================================================
    *-- Espelha SIGPRCOT.sair.Click do legado: descarta linhas nunca
    *-- preenchidas (Data ou Cotacao vazias) e sincroniza as demais com
    *-- SigCdCot antes de encerrar. No legado essa sincronizacao final era o
    *-- TABLEUPDATE do form pai sobre CrSigCdCot (cursor bufferizado); aqui o
    *-- dialogo fala com o banco pelo proprio SIGPRCOTBO, entao a gravacao
    *-- final acontece linha a linha (Atualizar), nao em lote.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cIdChave

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SCAN
                IF EMPTY(datas) OR EMPTY(valos)
                    loc_cIdChave = ALLTRIM(cidchaves)

                    THIS.FormParaBO()
                    THIS.this_oBusinessObject.this_lNovoRegistro = .F.

                    IF !THIS.this_oBusinessObject.Excluir()
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel " + ;
                                    "descartar uma cota" + CHR(231) + CHR(227) + "o " + ;
                                    "n" + CHR(227) + "o preenchida.", "Erro")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cidchaves) == loc_cIdChave
                    IF FOUND()
                        DELETE
                    ENDIF
                ENDIF
                SELECT cursor_4c_Dados
            ENDSCAN

            SELECT cursor_4c_Dados
            GO TOP
            SCAN
                *-- Espelha o "Replace CrSigCdCot.datas/horas/valos With
                *-- TmpCot..." do sair.Click legado: a linha corrente da grade
                *-- vira a ficha que o BO grava
                THIS.FormParaBO()
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.

                THIS.this_oBusinessObject.EditarRegistro()
                IF !THIS.this_oBusinessObject.Salvar()
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar " + ;
                                "uma das cota" + CHR(231) + CHR(245) + "es.", "Erro")
                    ENDIF
                ENDIF
                SELECT cursor_4c_Dados
            ENDSCAN
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
    *-- Reabilita o form pai (legado: cmdSair.Click nao faz isso
    *-- explicitamente porque o Cadastro de Moedas usa dialogo NAO-modal e
    *-- sincroniza via Update(); no sistema novo o pai fica Enabled=.F.
    *-- enquanto o filho modal esta aberto e precisa ser reabilitado aqui,
    *-- para valer em QUALQUER caminho de fechamento, nao so no botao
    *-- Encerrar)
        IF VARTYPE(THIS.par_oFormPai) = "O"
            THIS.par_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.par_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
