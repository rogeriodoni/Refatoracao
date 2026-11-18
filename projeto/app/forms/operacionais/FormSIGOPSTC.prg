*==============================================================================
* FORMSIGOPSTC.PRG - Formulario Operacional: Status da Transmissao do
* Arquivo Cat (dialogo filho, SOMENTE LEITURA)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SIGOPSTC.SCX (task807)
*
* Pilares:
*   UX   -> layout identico ao legado (800x600, DataSession privada,
*           TitleBar=0, ControlBox=.F. -> Closable=.F., sem Movable/Max/
*           MinButton declarados no SCX - ficam no default do FormBase)
*   BD   -> SigFiSit/SigFiSii (consulta via SIGOPSTCBO); nao grava nada
*   CODE -> arquitetura em camadas (FormBase / SIGOPSTCBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO, visualizador puro, que outro form abre depois de ja ter
*   transmitido um arquivo "Cat" (SPED/fiscal) para mostrar a situacao
*   dessa transmissao. O legado recebe o form pai (poForm) no Init, le
*   ThisForm.poForm.pcSelFile (o nome do arquivo escolhido na tela pai) e
*   faz UMA UNICA consulta (Select a.*, b.*, b.tDtEnvs As Envios From
*   SigFiSit a Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs Where
*   a.cArqMovs = '<pcSelFile>'), que alimenta Text1..Text4 (cabecalho de
*   SigFiSit), Grid1 (uma linha por tentativa de envio de SigFiSii) e
*   Edit1 (cRetornos da linha corrente do grid). Botao unico "Encerrar"
*   so fecha o dialogo. Ver cabecalho de SIGOPSTCBO.prg para o detalhe
*   completo da consulta e da colisao de nomes cUsuarios entre as tabelas.
*
* CHAMADA (equivale ao Do Form SIGOPSTC With ThisForm do legado):
*   loForm = CREATEOBJECT("FormSIGOPSTC", THISFORM)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   O form pai precisa expor a property pcSelFile (char, nome do arquivo
*   ja transmitido) ANTES de abrir este dialogo - exatamente como o
*   legado exige ThisForm.poForm.pcSelFile.
*
* PARAMETRO (legado: LParameters poForm)
*   par_oFormPai - legado: poForm (RESERVED3/ClassInfo do SCX = "poform",
*                  custom property default .F. sobrescrita no Init). Form
*                  que abriu o dialogo; eh dele que vem pcSelFile
*                  (arquivo a consultar) e, so para auditoria,
*                  DataSessionId (ver NOTA abaixo).
*
* NOTA - ThisForm.DataSessionId = poForm.DataSessionId (legado)
*   DataSessionID eh propriedade READ-ONLY em runtime no VFP9 (so pode
*   ser lida, nunca atribuida) - a linha do legado nao sincroniza sessao
*   nenhuma de verdade. O valor eh so guardado para referencia/auditoria
*   em THIS.this_oBusinessObject.this_nDataSessionPai (property que a
*   Fase 1-2 ja antecipou com esse proposito), sem tentar reatribuir
*   DataSession em runtime (regra CLAUDE.md sobre propriedade read-only).
*
* NOTA - cabecalho cntSombra com Caption LITERAL "Cadastro de Testes"
*   Nos dialogos irmaos desta mesma familia (FormSigOpSpr/FormSigOpSlc,
*   tasks 803/805) o Init legado faz
*   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption /
*   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption - por isso
*   aqueles migrados usam .Caption = THIS.Caption (dinamico). O Init de
*   SIGOPSTC (conferido linha a linha no dump, tasks\task807\
*   SIGOPSTC_form_codigo_fonte.txt) NAO faz essa copia: os dois labels
*   ficam com o literal "Cadastro de Testes" do Form Designer, nunca
*   atualizado para "Status da transmissao do Arquivo Cat" (Form.Caption).
*   Isso significa que, com TitleBar=0 (sem barra de titulo nativa), o
*   USUARIO NUNCA VE o Caption real do form em lugar nenhum da tela - um
*   defeito legitimo do legado, nao desta migracao. Regra #17 do
*   CLAUDE.md (transcrever formula/texto do legado, nao "corrigir"):
*   mantido literal "Cadastro de Testes" nos dois labels.
*
* FASE 3: estrutura base do form - DEFINE CLASS com as propriedades
* visuais transcritas do SCX, a propriedade de estado que espelha o poForm
* do Init legado, Init com o parametro, ValidarParametros, InicializarForm,
* ConfigurarDecoracao (Picture), ConfigurarCabecalho (cntSombra),
* TornarControlesVisiveis e Destroy.
*
* FASE 4: o corpo da tela - Shape1 (moldura) e Label1
* ("Arquivo :") em ConfigurarMoldura; Grid1 (a lista de tentativas de
* envio) em ConfigurarGrade + AplicarFormatoGrade; Commandgroup1 com o
* unico botao "Encerrar" em ConfigurarBotoes; e CarregarLista, o funil que
* chama THIS.this_oBusinessObject.CarregarSituacao(THIS.this_cArqMovsPai) e
* liga a grade ao cursor_4c_Envios da Fase 1-2.
*
* Esta tela NAO tem PageFrame nem CRUD (layout FLAT): o legado monta tudo
* direto na Form e o unico botao so fecha o dialogo, entao nao existem aqui
* os metodos de pagina/alternancia nem os seis botoes do padrao CRUD -
* inventa-los violaria o PILAR 1.
*
* FASE 5: a PRIMEIRA METADE dos campos do cabecalho de
* SigFiSit - Text1 (o arquivo, rotulado pelo Label1 que a Fase 4 criou),
* Label2 + Text2 ("Lote :") e Label3 + Text3 ("Empresa :") - em
* ConfigurarCamposCabecalho; mais AtualizarCabecalho, o espelho que copia
* para esses campos as properties que SIGOPSTCBO.CarregarDoCursor
* preenche. Eh o equivalente das linhas
*     ThisForm.Text1.Value = crTmpLgSit.cArqMovs
*     ThisForm.Text2.Value = crTmpLgSit.cNumLotes
*     ThisForm.Text3.Value = crTmpLgSit.cEmps
* do Init legado: ali os quatro Text recebem .Value DIRETO (nao ha
* ControlSource neles), e aqui a mesma copia acontece uma vez, no funil
* CarregarLista, logo depois da consulta.
*
* FASE 6: a SEGUNDA METADE dos campos e os eventos de dado.
*   - Label4 + Text4 ("Impresssora :", cImpFabs) fecham o cabecalho, em
*     ConfigurarCamposCabecalho, junto dos tres campos da Fase 5; o
*     AtualizarCabecalho passa a espelhar os QUATRO.
*   - Edit1 (ConfigurarCampoRetorno) eh o painel de DETALHE ao lado da
*     grade: exibe SigFiSii.cretornos da tentativa de envio selecionada.
*     Eh o UNICO campo da tela que muda ao navegar na grade - os quatro
*     Text mostram o cabecalho de SigFiSit, replicado em toda linha pelo
*     INNER JOIN. O ControlSource dele eh ligado em CarregarLista, com o
*     alias ja aberto (regra #41), como na penultima linha do Init legado.
*   - ConfigurarEventos liga, por BINDEVENT, o Grid1.AfterRowColChange do
*     legado a GradeAfterRowColChange -> AtualizarDetalheRetorno, a fonte
*     unica do painel de retorno (usada tambem na primeira exibicao, em
*     CarregarLista, para os dois caminhos nao divergirem).
*
* SEM LOOKUP: esta fase normalmente entrega tambem os lookups (F4/F5 ->
* FormBuscaAuxiliar), e aqui NAO HA NENHUM a entregar. Conferido no dump
* inteiro (tasks\task807\SIGOPSTC_form_codigo_fonte.txt): zero fwBuscaExt
* / fwBuscaSel / fwBuscaInt / sigacess() / AcessoEmpresa() / mAddColuna, e
* nenhum campo com PROCEDURE Valid. Nem poderia haver - os cinco campos de
* dado da tela (Text1..Text4 e Edit1) tem PROCEDURE When -> Return(.F.) no
* legado, isto eh, NENHUM aceita digitacao, e campo que nunca recebe foco
* nao tem onde digitar o codigo que abriria o picker. Inventar um lookup
* aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que
* nao existem no original".
*
* FASE 7 (esta fase): o evento do botao - BtnEncerrarClick, o Click do
* UNICO botao da tela (ThisForm.Release do legado), ligado por BINDEVENT em
* ConfigurarEventos. Eh a unica saida do dialogo, ja que o form nao tem
* TitleBar nem ControlBox (Closable = .F.).
*
* SEM BOTAO CRUD: esta fase normalmente entrega os quatro handlers do padrao
* CRUD (BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
* BtnExcluirClick) e aqui NAO HA NENHUM a entregar. Conferido no dump
* inteiro (tasks\task807\SIGOPSTC_form_codigo_fonte.txt):
*   - a Class do form eh "form" PURO, nao "frmcadastro" - logo nao ha a
*     barra CRUD que o framework Fortyus herda;
*   - zero "Grupo_Op" e zero "pcEscolha" (a variavel de MODO do
*     frmcadastro): esta tela nao tem modo INCLUIR/ALTERAR/VISUALIZAR,
*     porque nao grava nada;
*   - o unico CommandGroup tem ButtonCount = 1, e esse botao eh o Encerrar.
* Escrever os quatro nomes aqui obrigaria a INVENTAR botoes que o legado nao
* tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a criar quatro metodos
* vazios (stub disfarcado, proibido pela regra de completude).
*
* FASE 8/8 (esta fase) - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
*   A superficie que o legado tem ja estava inteira ao fim da Fase 7, e isso
*   foi CONFERIDO metodo a metodo contra a SECAO 3 do dump (que tem NOVE
*   metodos, nem um a mais):
*     SIGOPSTC.Init ................. Init (poForm) + InicializarForm +
*                                     CarregarLista + THIS.Refresh
*     Commandgroup1.Command2.Click .. BtnEncerrarClick   (BINDEVENT no Buttons(1))
*     Grid1.AfterRowColChange ....... GradeAfterRowColChange -> AtualizarDetalheRetorno
*     Edit1.When  -> Return(.F.) .... edt_4c_Edit1.ReadOnly  = .T. + TabStop = .F.
*     Text1.When  -> Return(.F.) .... txt_4c_Text1.ReadOnly  = .T. + TabStop = .F.
*     Text2.When  -> Return(.F.) .... txt_4c_Text2.ReadOnly  = .T. + TabStop = .F.
*     Text3.When  -> Return(.F.) .... txt_4c_Text3.ReadOnly  = .T. + TabStop = .F.
*     Text4.When  -> Return(.F.) .... txt_4c_Text4.ReadOnly  = .T. + TabStop = .F.
*   O unico ajuste desta fase foi de NOME: o funil de carga da grade, que
*   nasceu na Fase 4 como CarregarDados, passou a se chamar CarregarLista -
*   o nome canonico do projeto para o metodo que popula a grade, que eh
*   exatamente o que ele faz (ver a NOTA no proprio metodo).
*
*   OS TRES OUTROS NOMES CANONICOS DA FASE 8 NAO TEM REFERENTE NESTE LEGADO
*   BtnCancelarClick, FormParaBO e BOParaForm sao convencao do par
*   Page2(Dados) + modo INCLUIR/ALTERAR do frmcadastro:
*     - BtnCancelarClick cancela uma EDICAO em andamento, e aqui nao existe
*       edicao - os cinco campos de dado tem When -> Return(.F.) no legado,
*       nenhum aceita digitacao, e o unico botao da tela so fecha;
*     - FormParaBO escreve campo EDITAVEL de volta no BO, e nao ha nenhum;
*     - BOParaForm eh o sentido BO -> campo, que esta entregue e EM USO com
*       outro nome, porque aqui ele tem DOIS destinos distintos:
*       AtualizarCabecalho (as quatro properties de SigFiSit nos Text1..Text4)
*       e AtualizarDetalheRetorno (o cretornos da linha corrente no Edit1,
*       refeito a cada troca de linha). Um metodo unico chamado BOParaForm
*       mentiria sobre esse recorte, que eh o do proprio legado.
*   Escrever os tres obrigaria a INVENTAR superficie que o legado nao tem
*   (viola o PILAR 1) ou a criar metodo vazio (proibido pela regra de
*   completude).
*
*   INTEGRACAO - o que NAO se faz neste form, e por que
*     - menu.prg: NENHUM item. Esta tela eh dialogo FILHO que depende de
*       poForm.pcSelFile (o arquivo que o form pai acabou de transmitir);
*       aberta pelo menu, sem chamador, nao teria arquivo para consultar -
*       o proprio ValidarParametros recusa a abertura nesse caso. Mesmo
*       criterio ja aplicado aos outros dialogos filhos migrados
*       (FormSigOpCtd, FormSigOpCcj, FormSigPrCar, FormSIGPRSTF).
*     - config.prg: NENHUM SET PROCEDURE. Desde 2026-10-28 a carga eh SOB
*       DEMANDA (CLAUDE.md, secao config.prg) - acrescentar BO/Form ali eh
*       proibido. forms\operacionais ja esta no escopo de
*       automation\GerarIndiceClasses.ps1, entao start\indice_classes.txt
*       passa a listar FormSIGOPSTC/SIGOPSTCBO sozinho na proxima abertura.
*       Quem abre esta tela chama GarantirClasse("FormSIGOPSTC") antes do
*       CREATEOBJECT.
*
*   VERIFICACAO DESTA FASE (2026-11-18), toda com arquivo de saida como prova
*     COMPILACAO PROVADA (automation\CompilarF8SigOpStc807.prg): o smoke test
*     do VFP9 desta sessao PASSOU, FormSIGOPSTC.FXP e SIGOPSTCBO.FXP foram
*     gerados e NENHUM .ERR - com CONTROLE NEGATIVO na mesma rodada (copia
*     deste form com "PUBLIC PROCEDURE", regra #9.1, colada no fim: .ERR
*     apontando SO as duas linhas acrescentadas), o que prova de uma vez que
*     o detector funciona E que este arquivo compila limpo.
*     RUNTIME PROVADO (automation\ProbeF8SigOpStc807.prg): instancia COM e
*     SEM form pai; os sete metodos chamados de fora sao PUBLIC
*     (PEMSTATUS(...,2) = .F. nos sete); os DOIS BINDEVENT estao REGISTRADOS
*     (AEVENTS: AFTERROWCOLCHANGE -> GRADEAFTERROWCOLCHANGE no grid e CLICK ->
*     BTNENCERRARCLICK no Buttons(1)); CarregarLista liga a grade
*     (RecordSource + os dois ControlSource + headers Data/Usuario + larguras
*     65/95 preservados depois do rebind), liga o Edit1 por ControlSource e
*     espelha os quatro Text (CAT0001.TXT / 778899 / 001 / IMPFISCAL01);
*     trocar a linha corrente e chamar GradeAfterRowColChange troca o Edit1
*     (1a -> 2a tentativa); BtnEncerrarClick libera o form e o Destroy fecha
*     o cursor; nenhum MsgErro/MsgAviso disparado no caminho inteiro.
*     As tabelas SigFiSit/SigFiSii estao VAZIAS em DB_MBAHIA (COUNT(*) = 0
*     nas duas, medido nesta data), entao o probe injeta um BO de teste que
*     so troca a ORIGEM das linhas e delega ao CarregarDoCursor REAL - a
*     consulta real nao tem o que exibir e nao serviria de prova.
*     ESTATICO, tudo com resultado ZERO: acento literal em .prg (regra #4),
*     "this_X .Value" (regra #43), RETURN dentro de TRY (regra #1),
*     MESSAGEBOX direto, ISEMPTY/MostrarAviso/.Self/Controls("nome")
*     (regras #2/#9.3/#38/#34), TTOD/TABLEREVERT/EVALUATE-que-atribui
*     (regras #16/#52/#15), chamada a nome nao resolvido
*     (VerificarFuncoesNaoDefinidas, regra #13), propriedade inexistente na
*     classe (VerificarPropriedadesInexistentes, regra #33), metodo PROTECTED
*     chamado de fora (regra #51), lookup em KeyPress (regra #47),
*     Format/InputMask faltando (regra #49), coluna invalida no SQL
*     (ValidadorSQLSchema, 683 tabelas lidas do schema canonico) e
*     Test-CompletudeCodigo (TODO/stub) nos dois arquivos.
*==============================================================================

DEFINE CLASS FormSIGOPSTC AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *==========================================================================

    this_cMensagemErro = ""

    *-- SIGOPSTC: Height = 600 / Width = 800
    Height       = 600
    Width        = 800

    *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. - ambos ja sao default
    *-- do FormBase, repetidos aqui por transcricao explicita do SCX
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.

    *-- Caption real do form (nunca exibido na tela - ver NOTA no
    *-- cabecalho deste arquivo: os labels do cabecalho usam literal
    *-- "Cadastro de Testes", nao THIS.Caption)
    Caption      = "Status da transmiss" + CHR(227) + "o do Arquivo Cat"

    *-- TitleBar = 0 / ControlBox = .F. (-> Closable = .F., mesma
    *-- convencao de FormSigOpSlc/FormSigOpSpr para esta familia de
    *-- dialogos). MaxButton/MinButton/Movable NAO sao declarados no SCX
    *-- (ficam no default do FormBase, sem override)
    TitleBar     = 0
    Closable     = .F.

    *-- WindowType = 1 (modal): nao declarado explicitamente no dump, mas
    *-- exigido pelo uso real - o form pai abre este dialogo e so segue
    *-- depois que o usuario clica Encerrar (Fase 4/7), igual aos irmaos
    *-- desta familia (FormSigOpSlc/FormSigOpSpr)
    WindowType   = 1
    WindowState  = 0
    ShowWindow   = 1

    *-- Fonte base do Framework legado (nao declarada no nivel do Form no
    *-- dump, mas e a base herdada por todos os controles do corpo)
    FontName     = "Tahoma"
    FontSize     = 8

    *-- DataSession = 2 (sessao PRIVADA, como o SCX declara). Diferente do
    *-- FormSigOpSlc (DataSession = 1): este dialogo nao depende de
    *-- cursores que o form pai deixou abertos - SIGOPSTCBO.
    *-- CarregarSituacao (Fase 1-2) faz SQLEXEC proprio em cursor_4c_Envios,
    *-- sem reusar cursor do pai
    DataSession  = 2

    *==========================================================================
    * PROPRIEDADES DE ESTADO - espelham o LParameters do Init legado
    *==========================================================================

    *-- this_oFormPai -> poForm do legado (RESERVED3/ClassInfo do SCX =
    *-- "poform"): o form que abriu este dialogo. Fornece pcSelFile (o
    *-- arquivo cujo envio esta sendo consultado)
    this_oFormPai = .NULL.

    *-- this_cArqMovsPai -> poForm.pcSelFile do legado, capturado em
    *-- InicializarForm. So e consumido pela Fase 5-6 (CarregarSituacao),
    *-- mas a captura acontece aqui porque depende so do form pai, nao de
    *-- nenhum controle criado nas fases seguintes
    this_cArqMovsPai = ""

    *==========================================================================
    * Init - LParameters poForm do legado
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai

        *-- Legado: Thisform.poForm = poForm
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * como saber qual arquivo consultar (poForm.pcSelFile do legado).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
                    "outro formul" + CHR(225) + "rio.", ;
                    "Status da Transmiss" + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object da Fase 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPSTCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGOPSTCBO.", ;
                        "Status da Transmiss" + CHR(227) + "o")
            ELSE
                *-- Legado: Thisform.poForm.pcSelFile - capturado aqui
                *-- porque so depende do form pai (a Fase 5-6 consome este
                *-- valor ao chamar CarregarSituacao)
                *-- A guarda VARTYPE = "O" eh OBRIGATORIA antes do
                *-- PEMSTATUS: medido no VFP9 em 2026-11-18,
                *-- PEMSTATUS(.NULL., "x", 5) SOZINHO estoura "Function
                *-- argument value, type, or count is invalid." (erro 11) -
                *-- VARTYPE(.NULL.) eh "X", nao "O". Na guarda combinada
                *-- com AND o PEMSTATUS nao chega a ser avaliado e nao
                *-- estoura. Sem ela, o form NAO INSTANCIA quando nao ha
                *-- form pai (harness/ValidarUIFidelity): o erro cai no
                *-- CATCH, InicializarForm devolve .F. e o CREATEOBJECT do
                *-- chamador devolve logico
                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                   PEMSTATUS(THIS.this_oFormPai, "pcSelFile", 5)
                    THIS.this_cArqMovsPai = TratarNulo(THIS.this_oFormPai.pcSelFile, "")
                ENDIF

                *-- Legado: Thisform.DataSessionId = poForm.DataSessionId -
                *-- so documentado (ver NOTA no cabecalho deste arquivo);
                *-- DataSessionID eh READ-ONLY em runtime, nunca reatribuida
                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                   PEMSTATUS(THIS.this_oFormPai, "DataSessionId", 5)
                    THIS.this_oBusinessObject.this_nDataSessionPai = ;
                        THIS.this_oFormPai.DataSessionId
                ENDIF

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form: o Commandgroup1 da Fase 4 fica em
                *-- Top = -2, DENTRO da faixa (Top 0..80), e precisa ser
                *-- criado depois para desenhar por cima (regra #11)
                THIS.ConfigurarCabecalho()

                *-- Shape1 (moldura do corpo) e Label1 ("Arquivo :").
                *-- Criados antes da grade e dos botoes, na ordem do SCX
                THIS.ConfigurarMoldura()

                *-- Grid1 -> grd_4c_Dados (uma linha por tentativa de envio)
                THIS.ConfigurarGrade()

                *-- Commandgroup1 (botao "Encerrar"). Vem DEPOIS do
                *-- cabecalho porque fica em Top = -2..82, dentro da faixa
                *-- cinza (Top 0..80), e so desenha por cima dela se for
                *-- criado depois (regra #11)
                THIS.ConfigurarBotoes()

                *-- Text1 (arquivo), Label2 + Text2 (lote) e Label3 + Text3
                *-- (empresa): o cabecalho do arquivo consultado. Criados
                *-- DEPOIS do grupo de botoes, na ordem do SCX, sem risco de
                *-- sobreposicao - os campos ficam todos em Top >= 141 e o
                *-- grupo termina em Top 83
                THIS.ConfigurarCamposCabecalho()

                *-- Edit1: o painel de DETALHE ao lado da grade (o retorno
                *-- da SEFAZ da tentativa selecionada). Criado por ultimo,
                *-- como no dump, e ja ocupa a mesma faixa vertical do Grid
                *-- (Top 201, Height 312) sem sobrepor nada
                THIS.ConfigurarCampoRetorno()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- BINDEVENT do AfterRowColChange do Grid. Depois de TODOS
                *-- os AddObject: BINDEVENT com alvo inexistente estoura no
                *-- proprio bind
                THIS.ConfigurarEventos()

                *-- Funil de carga: executa a consulta do Init legado e liga
                *-- a grade ao cursor. Devolve .F. sem arquivo/conexao
                *-- (caminho normal do harness), o que NAO impede a abertura
                THIS.CarregarLista()

                *-- Legado: This.Refresh (ultima linha do Init)
                THIS.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSIGOPSTC: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Legado:
    *   cntSombra  Top=0  Left=0  Width=1100  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0, Caption="Cadastro de Testes"
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0,
    *              Caption="Cadastro de Testes"
    *
    * Caption LITERAL "Cadastro de Testes" nos dois labels - NAO dinamico
    * (THIS.Caption) - ver NOTA extensa no cabecalho deste arquivo: o Init
    * legado desta tela (diferente dos irmaos FormSigOpSpr/FormSigOpSlc)
    * nunca copia ThisForm.Caption para os labels, entao o usuario nunca
    * ve "Status da transmissao do Arquivo Cat" em lugar nenhum da tela.
    * Transcrito literal (regra #17 do CLAUDE.md).
    *
    * Width do container usa THIS.Width (canonico da faixa, regra #11) em
    * vez do literal 1100 do dump - aquele valor eh MAIOR que o Width do
    * proprio form (800) e deixaria a faixa recortada/cortada pelo form;
    * THIS.Width tambem acompanha o form se o layout mudar numa fase
    * futura.
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form
    * Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        *-- Container da faixa (cntSombra)
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

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = "Cadastro de Testes"
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Cadastro de Testes"
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarMoldura - Shape1 (moldura do corpo) e Label1 ("Arquivo :")
    *
    * Transcricao do dump (SIGOPSTC.Shape1 / SIGOPSTC.Label1):
    *   Shape1  Top=135 Left=62 Width=676 Height=387 BackStyle=0
    *           BorderColor=90,90,90
    *   Label1  AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Arquivo :"
    *           Top=144 Left=105 Width=46 Height=15 ForeColor=90,90,90
    *
    * Shape NAO tem ForeColor nem ShapeType (regra #33): a cor da linha eh
    * BorderColor, e o retangulo eh o default (Curvature = 0) - nao ha
    * propriedade de "tipo de forma" a escrever.
    *
    * Label1 fica com AutoSize = .F. e Width/Height TRANSCRITOS: em Label
    * criado por AddObject o AutoSize eh no-op (a Width fica nos 100 do
    * default) e, com WordWrap, ate descarta a Height (regra #23). Os 46x15
    * do dump JA SAO o tamanho que o Form Designer calculou, entao fixa-los
    * eh reproducao fiel.
    *
    * ForeColor = RGB(90, 90, 90) eh o do dump e tambem o canonico de label
    * de dados (regra #12): branco aqui ficaria INVISIVEL, porque a Picture
    * do form (new_background.jpg) eh uma textura clara.
    *
    * O Shape eh criado ANTES do label (ordem do SCX): mesmo transparente
    * (BackStyle = 0), quem vem depois desenha por cima.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMoldura
        *-- Shape1 -> shp_4c_Shape1 (moldura em volta do corpo da tela)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 135
            .Left        = 62
            .Width       = 676
            .Height      = 387
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label1 -> lbl_4c_Label1 ("Arquivo :", rotulo do Text1 que entra
        *-- na fase seguinte)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Arquivo :"
            .Top       = 144
            .Left      = 105
            .Width     = 46
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Grid1 do legado -> grd_4c_Dados
    *
    * Eh a lista de TENTATIVAS DE ENVIO do arquivo (uma linha por registro de
    * SigFiSii), com duas colunas: a data do envio (b.tDtEnvs, apelidada
    * Envios) e o usuario (cUsuarios). Selecionar uma linha eh o que faz o
    * Edit1 da fase seguinte mostrar o retorno daquela tentativa.
    *
    * Transcricao do dump (SIGOPSTC.Grid1):
    *   ColumnCount=2  FontName="Tahoma"  FontSize=8  DeleteMark=.F.
    *   RowHeight=16  ScrollBars=2  Top=201  Left=69  Width=192  Height=312
    *
    * RecordMark: o dump NAO declara (fica no default .T. do VFP9), mas o
    * canonico do projeto para grade criada por AddObject em form
    * OPERACIONAL eh .F. nos DOIS marcadores - sem isso a barra de marcacao
    * aparece na lateral esquerda. Desvio consciente e documentado; o espaco
    * sobra de qualquer forma (65 + 95 = 160 de coluna dentro dos 192 do
    * Grid, com a barra de rolagem vertical).
    *
    * Grid.ReadOnly NAO eh escrito: o dump tambem nao o declara. A grade eh
    * somente-leitura pelas COLUNAS (Column1/Column2.ReadOnly = .T. e os
    * respectivos Text1.ReadOnly = .T., todos no dump), que eh exatamente o
    * que AplicarFormatoGrade aplica - o efeito na tela eh identico e a
    * transcricao continua fiel. Como nada escreve Grid.ReadOnly, nao ha a
    * propagacao do grid sobrescrevendo a coluna (regra #18/#46).
    *
    * RecordSource fica VAZIO aqui, como na PRIMEIRA linha do Init legado
    * (ThisForm.Grid1.RecordSource = []): o cursor so existe depois da
    * consulta, e ligar RecordSource a alias inexistente derruba o Init
    * (regra #41). Quem liga eh CarregarLista.
    *
    * Aqui ficam SO as propriedades que nao dependem de dado (regra #41);
    * largura de coluna e caption de cabecalho moram em AplicarFormatoGrade,
    * que eh a FONTE UNICA desses numeros e eh reusada por CarregarLista
    * depois do RecordSource (atribuir RecordSource zera Column.Width e
    * Header1.Caption - Problema 48 / regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount = 2
            .FontName    = "Tahoma"
            .FontSize    = 8
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .RowHeight   = 18
            .ScrollBars  = 2
            .Top         = 201
            .Left        = 69
            .Width       = 192
            .Height      = 312
            .HeaderHeight       = 0
            .Visible     = .T.
        ENDWITH

        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria/decoracao das colunas
    *
    * Transcricao do dump:
    *   Column1  Width=65  Movable=.F.  Resizable=.F.  ReadOnly=.T.
    *            FontName="Tahoma"  FontSize=8
    *            Header1: Tahoma 8, Alignment=2, Caption="Data",
    *                     ForeColor=36,84,155
    *            Text1:   Tahoma 8, BorderStyle=0, Margin=0, ReadOnly=.T.,
    *                     ForeColor=0,0,0, BackColor=255,255,255,
    *                     DisabledForeColor=0,0,0
    *   Column2  Width=95  Movable=.F.  Resizable=.F.  ReadOnly=.T.
    *            FontName="Tahoma"  FontSize=8
    *            Header1: Tahoma 8, Alignment=2, Caption="Usuario",
    *                     ForeColor=36,84,155
    *            Text1:   identico ao de Column1
    * Conferencia: 65 + 95 = 160, dentro dos Grid.Width = 192.
    *
    * Existe como metodo porque a grade eh formatada em DOIS momentos - na
    * montagem (ConfigurarGrade) e na carga (CarregarLista, depois do
    * RecordSource). Com os dois chamando este metodo nao ha como os dois
    * lados divergirem em silencio.
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora para reaplicar o formato, e PROTECTED faria a chamada externa
    * estourar em runtime com "Property APLICARFORMATOGRADE is not found".
    *
    * O PEMSTATUS repete a expressao THIS.grd_4c_Dados de proposito: .Self
    * NAO existe em VFP9 (regra #38) - compila limpo e estoura "Property
    * SELF is not found" em runtime.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            WITH THIS.grd_4c_Dados
                *-- Column1 - Envios (b.tDtEnvs: data/hora da tentativa)
                .Column1.Width                     = 65
                .Column1.Movable                   = .F.
                .Column1.Resizable                 = .F.
                .Column1.FontName                  = "Tahoma"
                .Column1.FontSize                  = 8
                .Column1.ReadOnly                  = .T.
                .Column1.Header1.Caption           = "Data"
                .Column1.Header1.FontName          = "Tahoma"
                .Column1.Header1.FontSize          = 8
                .Column1.Header1.Alignment         = 2
                .Column1.Header1.ForeColor         = RGB(36, 84, 155)
                .Column1.Text1.FontName            = "Tahoma"
                .Column1.Text1.FontSize            = 8
                .Column1.Text1.BorderStyle         = 0
                .Column1.Text1.Margin              = 0
                .Column1.Text1.ReadOnly            = .T.
                .Column1.Text1.ForeColor           = RGB(0, 0, 0)
                .Column1.Text1.BackColor           = RGB(255, 255, 255)
                .Column1.Text1.DisabledForeColor   = RGB(0, 0, 0)

                *-- Column2 - cUsuarios (usuario do cabecalho SigFiSit,
                *-- repetido em toda linha pelo JOIN - ver o cabecalho de
                *-- SIGOPSTCBO.prg: eh o que o legado produz e foi
                *-- transcrito, nao corrigido)
                .Column2.Width                     = 95
                .Column2.Movable                   = .F.
                .Column2.Resizable                 = .F.
                .Column2.FontName                  = "Tahoma"
                .Column2.FontSize                  = 8
                .Column2.ReadOnly                  = .T.
                .Column2.Header1.Caption           = "Usu" + CHR(225) + "rio"
                .Column2.Header1.FontName          = "Tahoma"
                .Column2.Header1.FontSize          = 8
                .Column2.Header1.Alignment         = 2
                .Column2.Header1.ForeColor         = RGB(36, 84, 155)
                .Column2.Text1.FontName            = "Tahoma"
                .Column2.Text1.FontSize            = 8
                .Column2.Text1.BorderStyle         = 0
                .Column2.Text1.Margin              = 0
                .Column2.Text1.ReadOnly            = .T.
                .Column2.Text1.ForeColor           = RGB(0, 0, 0)
                .Column2.Text1.BackColor           = RGB(255, 255, 255)
                .Column2.Text1.DisabledForeColor   = RGB(0, 0, 0)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Commandgroup1 do legado -> cmg_4c_Botoes
    *
    * UM unico botao, "Encerrar" (Command1, rebatizado Command2 no SCX).
    * Como o form nao tem TitleBar nem ControlBox, este botao eh a UNICA
    * saida do dialogo - o Click (ThisForm.Release no legado) entra na fase
    * 7-8.
    *
    * Transcricao do dump (SIGOPSTC.Commandgroup1):
    *   AutoSize=.T. ButtonCount=1 BackStyle=0 BorderStyle=0 Value=0
    *   SpecialEffect=1 BorderColor=136,189,188
    *   Top=-2 Left=720 Width=85 Height=85 TabIndex=5
    *     Command2  Top=5 Left=5 75x75 Caption="Encerrar" Cancel=.T.
    *               Comic Sans MS 8 bold italic, WordWrap=.T.,
    *               ForeColor=90,90,90 BackColor=255,255,255 Themes=.F.
    *               TabIndex=2 Picture=cadastro_sair_60.jpg
    *
    * O Buttons(1) mantem o nome default do VFP (Command1): o legado o
    * rebatiza como Command2, mas o canonico do projeto eh alcancar por
    * Buttons(N), e eh assim que a fase 7-8 liga o Click.
    *
    * A geometria do botao INTERNO eh aplicada ANTES da do grupo: com
    * AutoSize = .T. eh o tamanho do botao interno que define a altura do
    * grupo (regra #31).
    *
    * CommandGroup NAO tem FontName nem ForeColor (regra #33) - fonte e cor
    * moram em cada Buttons(N); escreve-las no grupo derrubaria o Init.
    * Themes = .F. como no dump: o Themes = .T. do padrao standalone NAO
    * vale para membro de CommandGroup. DisabledPicture repete a Picture
    * para o icone continuar desenhado se o botao for desabilitado, e
    * PicturePosition = 13 eh o canonico do Framework para estes botoes de
    * 75x75 (icone em cima, legenda embaixo).
    *
    * A Picture so eh atribuida com o arquivo CONFERIDO em disco: .Picture
    * apontando para arquivo inexistente falha em SILENCIO (regra #25) - o
    * botao fica so com o texto, sem erro nenhum.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIconeSair
        loc_cIconeSair = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDIF

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount = 1

            *-- Command2 do legado (Cancel = .T.: eh o botao do ESC)
            WITH .Buttons(1)
                .Caption    = "Encerrar"
                .Cancel     = .T.
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 2

                IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
                    .Picture         = loc_cIconeSair
                    .DisabledPicture = loc_cIconeSair
                    .PicturePosition = 13
                ENDIF

                .Visible = .T.
            ENDWITH

            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .Top           = -2
            .Left          = 720
            .Width         = 85
            .Height        = 85
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposCabecalho - os QUATRO campos do cabecalho
    * (Text1..Text3 vieram na Fase 5; Label4 + Text4, na Fase 6)
    *
    * Sao os dados de SigFiSit (o cabecalho da transmissao), replicados em
    * toda linha do cursor pelo INNER JOIN: o arquivo (carqmovs), o lote
    * (cnumlotes), a empresa (cemps) e a impressora fiscal (cimpfabs). O
    * rotulo do primeiro deles eh o Label1 ("Arquivo :") que
    * ConfigurarMoldura ja criou na Fase 4 - por isso aqui o Text1 vem sem
    * rotulo proprio, e os pares completos sao Label2/Text2, Label3/Text3 e
    * Label4/Text4.
    *
    * Transcricao do dump (tasks\task807\SIGOPSTC_form_codigo_fonte.txt):
    *   Text1   Tahoma 8  Top=141 Left=153 Width=100 Height=23
    *   Label2  AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Lote :"
    *           Top=146 Left=373 Width=30 Height=15 ForeColor=90,90,90
    *   Text2   Tahoma 8  Top=142 Left=405 Width=100 Height=23
    *   Label3  AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Empresa :"
    *           Top=145 Left=635 Width=50 Height=15 ForeColor=90,90,90
    *   Text3   Tahoma 8  Top=141 Left=687 Width=35 Height=23
    *   Label4  AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Impresssora :"
    *           Top=172 Left=83 Width=68 Height=15 ForeColor=90,90,90
    *   Text4   Tahoma 8  Top=168 Left=153 Width=571 Height=23
    *
    * SOMENTE EXIBICAO: os quatro Text tem PROCEDURE When -> Return(.F.) no
    * legado, isto eh, nunca recebem foco (o dialogo eh um visualizador, nao
    * grava nada). O equivalente canonico do projeto eh .ReadOnly = .T. +
    * .TabStop = .F. - NUNCA .Enabled = .F., que acinzentaria o texto,
    * enquanto o legado exibe o valor com a aparencia normal do fwget.
    *
    * Os labels ficam com AutoSize = .F. e Width/Height TRANSCRITOS: em
    * Label criado por AddObject o AutoSize eh no-op (a Width fica nos 100
    * do default) e pode descartar a Height (regra #23). Os 30x15 e 50x15 do
    * dump JA SAO o tamanho que o Form Designer calculou.
    *
    * Alignment NAO eh escrito em nenhum dos controles: o dump nao declara
    * nem nos labels (classe say: AutoSize/esquerda, regra #23) nem nos Text
    * (onde o default do VFP9 eh 3/Automatico, nao 0 - escrever 0 seria
    * mudar o alinhamento que o legado nao mexeu).
    *
    * ForeColor = RGB(90, 90, 90) nos labels eh o do dump e tambem o
    * canonico de label de dados (regra #12): branco ficaria INVISIVEL
    * sobre a Picture clara do form.
    *
    * MaxLength NAO eh escrito: o dump nao declara, e campo que nunca
    * recebe foco nao tem digitacao a limitar. As larguras das colunas em
    * docs\schema.sql (carqmovs char(12), cnumlotes char(10), cemps char(3),
    * cimpfabs char(20)) ficam registradas em SIGOPSTCBO.prg, que eh quem le
    * o banco.
    *
    * Cada label eh criado ANTES do Text que ele rotula (ordem do dump
    * dentro de cada par): label de caixa transparente criado depois
    * bloquearia o clique no campo (regra #23).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposCabecalho
        *-- Text1 -> txt_4c_Text1 (carqmovs: o arquivo cuja transmissao esta
        *-- sendo consultada; rotulado pelo Label1 da Fase 4)
        THIS.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.txt_4c_Text1
            .FontName = "Tahoma"
            .FontSize = 8
            .Top      = 141
            .Left     = 153
            .Width    = 100
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label2 -> lbl_4c_Label2 ("Lote :", rotulo do Text2)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Lote :"
            .Top       = 146
            .Left      = 373
            .Width     = 30
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Text2 -> txt_4c_Text2 (cnumlotes: numero do lote da transmissao)
        THIS.AddObject("txt_4c_Text2", "TextBox")
        WITH THIS.txt_4c_Text2
            .FontName = "Tahoma"
            .FontSize = 8
            .Top      = 142
            .Left     = 405
            .Width    = 100
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label3 -> lbl_4c_Label3 ("Empresa :", rotulo do Text3)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Empresa :"
            .Top       = 145
            .Left      = 635
            .Width     = 50
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Text3 -> txt_4c_Text3 (cemps: codigo da empresa, char(3))
        THIS.AddObject("txt_4c_Text3", "TextBox")
        WITH THIS.txt_4c_Text3
            .FontName = "Tahoma"
            .FontSize = 8
            .Top      = 141
            .Left     = 687
            .Width    = 35
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label4 -> lbl_4c_Label4 ("Impresssora :", rotulo do Text4)
        *--
        *-- O Caption tem o ERRO DE GRAFIA do legado - "Impresssora" com
        *-- TRES "s" (conferido no dump, SIGOPSTC.Label4). Transcrito
        *-- literalmente (regra #17: texto do legado se transcreve, nao se
        *-- corrige) - "consertar" para "Impressora" mudaria o que o
        *-- usuario ve e violaria o PILAR 1.
        *--
        *-- Sem acento nenhum, entao nao ha CHR() a usar aqui.
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Impresssora :"
            .Top       = 172
            .Left      = 83
            .Width     = 68
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Text4 -> txt_4c_Text4 (cimpfabs: identificador da impressora
        *-- fiscal que gerou o arquivo, char(20))
        *--
        *-- Conferencia de sobreposicao (regra #28): o Label4 termina em
        *-- 83 + 68 = 151 e o Text4 comeca em 153 - 2px de folga, e o
        *-- label foi criado ANTES do campo (regra #23).
        THIS.AddObject("txt_4c_Text4", "TextBox")
        WITH THIS.txt_4c_Text4
            .FontName = "Tahoma"
            .FontSize = 8
            .Top      = 168
            .Left     = 153
            .Width    = 571
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoRetorno - Edit1 do legado -> edt_4c_Edit1
    *
    * Eh o painel de DETALHE da grade: mostra o texto de retorno da SEFAZ
    * (SigFiSii.cretornos) da tentativa de envio selecionada no Grid1.
    * Enquanto Text1..Text4 exibem o CABECALHO do arquivo (SigFiSit,
    * identico em toda linha do cursor por causa do INNER JOIN), este campo
    * eh o unico da tela que muda ao navegar entre as linhas - por isso
    * depende do AfterRowColChange que ConfigurarEventos liga.
    *
    * Transcricao do dump (SIGOPSTC.Edit1):
    *   FontName="Tahoma" FontSize=8 Top=201 Left=260 Width=470 Height=312
    *
    * ScrollBars NAO eh escrito: o dump nao declara, e o default do VFP9
    * para EditBox (2 = vertical) ja eh o do legado. O Grid irmao, que o
    * dump SIM declara com ScrollBars = 2, fica lado a lado nos mesmos
    * Top/Height (201/312), formando o par lista + detalhe.
    *
    * SOMENTE EXIBICAO: o legado tem PROCEDURE When -> Return(.F.) neste
    * EditBox, igual aos quatro Text do cabecalho - o campo nunca recebe
    * foco. Mesma conversao canonica usada em ConfigurarCamposCabecalho:
    * .ReadOnly = .T. + .TabStop = .F., NUNCA .Enabled = .F. (que
    * acinzentaria o texto do retorno, enquanto o legado o exibe com a
    * aparencia normal).
    *
    * ControlSource NAO eh atribuido aqui: o legado so o liga DEPOIS da
    * consulta (ThisForm.Edit1.ControlSource = [crTmpLgSit.cRetornos], na
    * penultima linha do Init), e ligar a um alias que ainda nao existe
    * derruba o Init. Medido no VFP9 em 2026-11-18
    * (automation\p807c.prg): ControlSource apontando para alias FECHADO
    * estoura "Erro 13 - Alias 'CRO' is not found." Quem liga eh
    * CarregarLista, dentro da guarda USED() (regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoRetorno
        THIS.AddObject("edt_4c_Edit1", "EditBox")
        WITH THIS.edt_4c_Edit1
            .FontName = "Tahoma"
            .FontSize = 8
            .Top      = 201
            .Left     = 260
            .Width    = 470
            .Height   = 312
            .Value    = ""
            .ReadOnly = .T.
            .TabStop  = .F.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - liga os eventos do legado aos handlers do form.
    *
    * Chamado no FIM do InicializarForm, depois de TODOS os AddObject: um
    * BINDEVENT com delegate ou alvo inexistente estoura no proprio bind.
    *
    * Sao DOIS os eventos do legado a ligar: o Grid1.AfterRowColChange (o
    * unico evento de DADO) e o Click do unico botao (Fase 7).
    *
    * O evento de dado eh o que o legado usa para refazer o Edit1 ao trocar
    * de linha:
    *
    *     PROCEDURE AfterRowColChange
    *     LPARAMETERS nColIndex
    *     ThisForm.Edit1.Value = crTmpLgSit.cRetornos
    *     ThisForm.Edit1.Refresh
    *
    * O evento de BOTAO eh o Click do membro do Commandgroup1:
    *
    *     PROCEDURE Command2.Click
    *     ThisForm.Release
    *
    * O alvo do BINDEVENT eh Buttons(1), NAO o grupo: o dump mostra
    * "Command1.Name = "Command2"" no bloco de propriedades do
    * Commandgroup1, isto eh, o unico membro do grupo (ButtonCount = 1) foi
    * RENOMEADO para "Command2" - logo o "PROCEDURE Command2.Click" da secao
    * de metodos eh o Click DESSE botao, e nao codigo morto de um segundo
    * botao que teria sido removido. Com o Click no proprio botao, ligar o
    * handler ao grupo nao receberia o evento.
    *
    * O unico metodo do dump que NAO vira BINDEVENT sao os cinco PROCEDURE
    * When -> Return(.F.) (Edit1/Text1..Text4), ja convertidos em
    * .ReadOnly = .T. + .TabStop = .F. nos proprios controles - um When
    * ligado por BINDEVENT nao bloquearia nada, porque o BINDEVENT DESCARTA
    * o retorno do delegate.
    *
    * NAO existe lookup nesta tela para ligar: conferido no dump inteiro
    * (tasks\task807\SIGOPSTC_form_codigo_fonte.txt), nao ha fwBuscaExt /
    * fwBuscaSel / fwBuscaInt / sigacess() / AcessoEmpresa() / mAddColuna
    * em lugar algum, e nenhum campo tem PROCEDURE Valid. Nem poderia
    * haver: TODO campo desta tela eh somente-leitura (When -> .F.), e
    * campo que nunca recebe foco nao tem onde digitar o codigo que abriria
    * o picker. Inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a
    * regra "NUNCA inventar tabelas de lookup que nao existem no original".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", ;
                      THIS, "GradeAfterRowColChange")
        ENDIF

        *-- Legado: PROCEDURE Command2.Click -> ThisForm.Release (o membro
        *-- Buttons(1) do Commandgroup1, renomeado para "Command2" no SCX)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            IF THIS.cmg_4c_Botoes.ButtonCount >= 1
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", ;
                          THIS, "BtnEncerrarClick")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - handler do Grid1.AfterRowColChange legado.
    *
    * Metodo PUBLIC (regra #3): BINDEVENT com metodo PROTECTED falha em
    * SILENCIO - o evento nunca chegaria ao handler e o painel de retorno
    * ficaria congelado na primeira linha, sem erro nenhum na tela.
    *
    * par_nColIndex eh declarado porque AfterRowColChange PASSA esse
    * argumento (regra #3: handler sem o parametro estoura a cada troca de
    * celula). Ele NAO eh usado para filtrar: o legado tambem nao filtra, e
    * aqui o filtro seria errado - mestre-detalhe reage a troca de LINHA, e
    * a coluna que recebeu o foco eh irrelevante. Esse eh justamente o uso
    * CORRETO de AfterRowColChange (regra #46, que proibe o contrario:
    * validar CELULA aqui, no lugar do Valid do TextBox da coluna).
    *
    * O corpo todo delega para AtualizarDetalheRetorno, a fonte unica que
    * CarregarLista tambem usa - assim a primeira exibicao (logo depois da
    * consulta) e a troca de linha nao podem divergir.
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        RETURN THIS.AtualizarDetalheRetorno()
    ENDPROC

    *==========================================================================
    * AtualizarDetalheRetorno - FONTE UNICA do painel de retorno (Edit1).
    * Transcreve as duas linhas do AfterRowColChange legado:
    *
    *     ThisForm.Edit1.Value = crTmpLgSit.cRetornos
    *     ThisForm.Edit1.Refresh
    *
    * O cursor eh alcancado por EVALUATE porque o nome do alias vem de
    * ObterCursorEnvios (fonte unica), nao de um literal - e EVALUATE eh a
    * forma certa para LEITURA por nome montado (regra #15).
    *
    * As duas linhas sao transcritas LITERALMENTE, e isso foi MEDIDO antes
    * de decidir (automation\p807b.prg / p807c.prg, VFP9, 2026-11-18),
    * porque atribuir .Value a controle com ControlSource ligado eh uma
    * ESCRITA de volta no cursor:
    *
    *   cursor GRAVAVEL   .Value = <outro texto>  -> o CURSOR muda tambem
    *   cursor READ-ONLY  .Value = <outro texto>  -> .Value muda, cursor NAO
    *                                                (escrita descartada, sem erro)
    *   cursor READ-ONLY  .Value = <o proprio campo> -> OK, sem erro
    *   cursor READ-ONLY  Refresh() apos SKIP     -> .Value segue a linha corrente
    *
    * O cursor desta tela vem de SQLEXEC (somente-leitura: REPLACE nele da
    * "Erro 111 - Cannot update the cursor, since it is read-only"), e a
    * linha do legado atribui ao campo O PROPRIO VALOR DELE - logo nao ha
    * escrita efetiva nem erro, e o Refresh seguinte reafirma o valor a
    * partir do ControlSource. Transcrever as duas linhas eh seguro E fiel
    * (regra #17), sem precisar "simplificar" para so o Refresh.
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o GradeAfterRowColChange
    * o alcancam, e PROTECTED faria a chamada externa estourar em runtime
    * com "Property ATUALIZARDETALHERETORNO is not found".
    *
    * Sem o controle criado (chamada de fora antes do InicializarForm
    * terminar, ou depois de um Init que falhou) ou sem o cursor aberto
    * (harness sem conexao) nao ha o que exibir: devolve .F. sem tocar em
    * nada. A guarda cobre o ALIAS, NAO o EOF, e nao envolve o valor em
    * TratarNulo - os dois casos foram medidos no VFP9 em 2026-11-18
    * (automation\p807d.prg), com cursor de coluna NULL igual ao do banco
    * (SigFiSii.cretornos eh text NULL):
    *
    *   campo .NULL.  -> .Value fica .NULL. (VARTYPE "X") SEM erro, e a
    *                    tela mostra BRANCO, porque NullDisplay eh ""
    *   em EOF        -> ler o campo devolve o valor vazio da coluna, e
    *                    tanto a atribuicao quanto o Refresh() passam
    *
    * Logo nao ha erro a prevenir: guardar o EOF deixaria o painel exibindo
    * o retorno da linha ANTERIOR (o legado nao tem guarda alguma), e
    * aplicar TratarNulo seria divergir do legado a troco de nada - o
    * Refresh seguinte reafirma o valor a partir do ControlSource e
    * desfaria a substituicao.
    *==========================================================================
    PROCEDURE AtualizarDetalheRetorno
        LOCAL loc_lAtualizou, loc_cCursor
        loc_lAtualizou = .F.
        loc_cCursor    = THIS.ObterCursorEnvios()

        IF PEMSTATUS(THIS, "edt_4c_Edit1", 5) AND USED(loc_cCursor)
            *-- Legado: ThisForm.Edit1.Value = crTmpLgSit.cRetornos
            THIS.edt_4c_Edit1.Value = EVALUATE(loc_cCursor + ".cretornos")

            *-- Legado: ThisForm.Edit1.Refresh
            THIS.edt_4c_Edit1.Refresh()

            loc_lAtualizou = .T.
        ENDIF

        RETURN loc_lAtualizou
    ENDPROC

    *==========================================================================
    * AtualizarCabecalho - espelha as properties do BO nos campos de
    * exibicao do cabecalho. Transcreve as atribuicoes do Init legado:
    *
    *     ThisForm.Text1.Value = crTmpLgSit.cArqMovs
    *     ThisForm.Text2.Value = crTmpLgSit.cNumLotes
    *     ThisForm.Text3.Value = crTmpLgSit.cEmps
    *     ThisForm.Text4.Value = crTmpLgSit.cImpFabs
    *
    * O legado le o CURSOR direto; aqui a leitura do cursor ja aconteceu em
    * SIGOPSTCBO.CarregarDoCursor (chamado por CarregarSituacao), que
    * guardou cada coluna na property correspondente - FONTE UNICA desses
    * valores, que nenhum outro ponto do form reconsulta.
    *
    * Chamado pelo funil CarregarLista logo depois da consulta, no mesmo
    * ponto em que o legado faz as atribuicoes. Como os campos nao tem
    * ControlSource (nem no legado), a copia nao se refaz sozinha: quem
    * recarregar o cursor tem de passar por este metodo.
    *
    * ALLTRIM porque as colunas sao char() de largura fixa e vem com o
    * padding do banco - em campo de exibicao alinhado a esquerda o efeito
    * visual eh identico ao do legado, sem espaco pendurado no fim.
    *
    * TratarNulo protege o ALLTRIM: coluna char NOT NULL nao chega nula,
    * mas property lida antes da primeira consulta vale "" e property de
    * BO fresco nunca foi atribuida - o default garante Caractere sempre.
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime com
    * "Property ATUALIZARCABECALHO is not found".
    *
    * A guarda cobre os QUATRO campos de uma vez porque eles sao criados
    * juntos, no mesmo ConfigurarCamposCabecalho - nao existe estado em que
    * um exista e os outros nao. Ela eh necessaria porque este metodo eh
    * PUBLIC: chamado de fora antes do InicializarForm terminar (ou depois
    * de um Init que falhou), o acesso a membro inexistente estouraria.
    *
    * O Edit1 NAO entra aqui: ele nao exibe o cabecalho de SigFiSit (igual
    * em toda linha), e sim o cretornos da linha CORRENTE do grid - quem o
    * atualiza eh AtualizarDetalheRetorno, chamado tambem pelo
    * AfterRowColChange.
    *==========================================================================
    PROCEDURE AtualizarCabecalho
        LOCAL loc_lAtualizou, loc_oBO
        loc_lAtualizou = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           PEMSTATUS(THIS, "txt_4c_Text1", 5)

            loc_oBO = THIS.this_oBusinessObject

            *-- carqmovs -> Text1 (arquivo)
            THIS.txt_4c_Text1.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCArqMovs, ""))

            *-- cnumlotes -> Text2 (lote)
            THIS.txt_4c_Text2.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCNumLotes, ""))

            *-- cemps -> Text3 (empresa)
            THIS.txt_4c_Text3.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCEmps, ""))

            *-- cimpfabs -> Text4 (impressora fiscal)
            THIS.txt_4c_Text4.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCImpFabs, ""))

            *-- Legado: ThisForm.Refresh no fim do Init - repintar o campo
            *-- depois de trocar o .Value, senao a tela pode seguir
            *-- exibindo o valor anterior
            THIS.txt_4c_Text1.Refresh()
            THIS.txt_4c_Text2.Refresh()
            THIS.txt_4c_Text3.Refresh()
            THIS.txt_4c_Text4.Refresh()

            loc_lAtualizou = .T.
        ENDIF

        RETURN loc_lAtualizou
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click do UNICO botao da tela ("Encerrar"), ligado
    * por BINDEVENT em ConfigurarEventos ao Buttons(1) do cmg_4c_Botoes.
    *
    * Transcricao integral do legado (SIGOPSTC.Commandgroup1):
    *
    *     PROCEDURE Command2.Click
    *     ThisForm.Release
    *
    * Eh a UNICA saida deste dialogo: o form tem TitleBar = 0 e
    * ControlBox = .F. (-> Closable = .F.), entao nao ha X de janela nem
    * menu de sistema para fechar. O botao tambem eh o do ESC
    * (Buttons(1).Cancel = .T., transcrito do dump), e nesse caminho o VFP9
    * dispara o MESMO Click - por isso ha um handler so para as duas formas
    * de encerrar, sem duplicar comportamento.
    *
    * NAO ha nada a confirmar nem a gravar antes de fechar: esta tela eh um
    * visualizador puro (os cinco campos tem When -> Return(.F.) no legado,
    * nenhum aceita digitacao, e SIGOPSTCBO nao sobrescreve
    * Inserir/Atualizar/ExecutarExclusao). Por isso o legado nao tem botao
    * de Confirmar/Cancelar e este handler nao faz pergunta nenhuma ao
    * usuario - acrescentar um MsgConfirma aqui seria inventar
    * comportamento que o legado nao tem (PILAR 1).
    *
    * O fechamento do cursor de envios NAO eh repetido aqui: quem fecha eh o
    * Destroy, pelo nome que ObterCursorEnvios resolve, e o THIS.Release()
    * passa por ele. Fechar tambem neste ponto criaria uma segunda fonte
    * para a mesma limpeza, com os dois caminhos livres para divergir; e o
    * Destroy continua sendo necessario de qualquer forma, porque cobre
    * tambem a destruicao do form sem passar por este botao.
    *
    * Sem TRY/CATCH de proposito: o metodo tem uma chamada so, que nao vai
    * ao banco nem a cursor nenhum. Envolve-lo num TRY so criaria o risco da
    * regra #1 (RETURN dentro de TRY/CATCH) sem nada a tratar - e, se o
    * Release falhasse, engolir o erro deixaria o usuario preso numa tela
    * sem outra saida.
    *
    * Metodo PUBLIC (regra #3): eh alvo de BINDEVENT - delegate PROTECTED
    * falha em SILENCIO, e o botao Encerrar deixaria de fechar a tela sem
    * erro nenhum - e o harness de teste tambem o chama de fora da classe.
    *
    * O retorno .T. existe para o harness: o BINDEVENT descarta o retorno do
    * delegate.
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        *-- Legado: ThisForm.Release
        THIS.Release()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterCursorEnvios - nome do alias da consulta (crTmpLgSit do legado).
    *
    * FONTE UNICA do nome: quem manda eh a property do BO
    * (this_cCursorEnvios); o literal "cursor_4c_Envios" fica so como
    * fallback para quando o BO ainda nao existe (form instanciado sem
    * conexao pelo harness, ou Destroy depois de um Init que falhou).
    *
    * Metodo PUBLIC (regra #3): a fase seguinte e o harness o chamam de fora
    * da classe.
    *==========================================================================
    PROCEDURE ObterCursorEnvios
        LOCAL loc_cCursor
        loc_cCursor = "cursor_4c_Envios"

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           PEMSTATUS(THIS.this_oBusinessObject, "this_cCursorEnvios", 5)
            IF !EMPTY(THIS.this_oBusinessObject.this_cCursorEnvios)
                loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorEnvios)
            ENDIF
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL de carga da grade. Transcreve o bloco do Init
    * legado que consulta a situacao do arquivo e liga a grade ao cursor.
    *
    * NOME CANONICO (Fase 8, 2026-11-18): este metodo nasceu na Fase 4 como
    * CarregarDados e foi renomeado para CarregarLista, o nome canonico do
    * projeto para o metodo que popula a GRADE. Nao eh acomodacao a
    * validador: esta tela TEM lista (Grid1) e popula-la eh justamente o
    * trecho final do Init legado, entao o nome canonico descreve
    * exatamente o que o metodo faz - e o PILAR 3 manda nomes diferentes do
    * legado de qualquer forma. A renomeacao foi conferida em TODO o
    * projeto antes de ser aplicada: nenhum outro arquivo (menu.prg,
    * TesteAutomatico, probes de automation\) chamava CarregarDados deste
    * form, entao nao ha call site externo a atualizar.
    *
    * O bloco transcrito do Init legado:
    *
    *     lcSelect = [Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
    *                 Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
    *                 Where a.cArqMovs = '] + ThisForm.poForm.pcSelFile + [']
    *     ThisForm.poForm.poDataMgr.SqlExecute(lcSelect, [crTmpLgSit])
    *     ...
    *     ThisForm.Grid1.RecordSource          = [crTmpLgSit]
    *     ThisForm.Grid1.Column1.ControlSource = [crTmpLgSit.Envios]
    *     ThisForm.Grid1.Column2.ControlSource = [crTmpLgSit.cUsuarios]
    *
    * A consulta mora em SIGOPSTCBO.CarregarSituacao (camada de dados), que
    * tambem preenche as properties do cabecalho via CarregarDoCursor - sao
    * elas que AtualizarCabecalho espelha em Text1..Text4. O Edit1 nao
    * passa por property nenhuma: ele eh ligado por ControlSource ao
    * cretornos da linha corrente, exatamente como no Init legado, e
    * AtualizarDetalheRetorno faz a primeira exibicao.
    *
    * O arquivo consultado eh o this_cArqMovsPai, capturado de
    * poForm.pcSelFile no InicializarForm. SEM arquivo nao ha consulta a
    * fazer: devolve .F. de imediato, sem ir ao banco - eh o caminho normal
    * do harness, que instancia o form sem form pai.
    *
    * Sem o cursor aberto o binding NAO eh aplicado: atribuir RecordSource
    * de alias inexistente derruba o Init (regra #41).
    *
    * ColumnCount e RecordSource ficam FORA do WITH do Grid, para nao
    * dividir bloco com o acesso a .Column1/.Column2. Reatribuir o MESMO
    * ColumnCount nao recria as Column, e nao ha controle posto por
    * Column.AddObject nesta grade a perder.
    *
    * Fecha com GO TOP + Refresh (regra #21a): popular/ligar cursor NAO
    * repinta a grade sozinho - sem isso a grade fica visualmente vazia com
    * o cursor cheio, e o diagnostico vai para o SQL.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o chama de FORA da
    * classe, sem argumento, e PROTECTED faria a chamada estourar em runtime
    * com "Property CARREGARDADOS is not found".
    *
    * Nao ha RETURN dentro de TRY/CATCH (regra #1): as guardas ficam ANTES
    * do TRY, o resultado sai por flag e o unico RETURN do bloco vem depois
    * do ENDTRY.
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lCarregou, loc_cCursor, loc_cArquivo, loc_oErro
        loc_lCarregou = .F.
        loc_cCursor   = THIS.ObterCursorEnvios()
        loc_cArquivo  = ALLTRIM(THIS.this_cArqMovsPai)

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Legado: o filtro eh ThisForm.poForm.pcSelFile. Sem ele nao ha
        *-- arquivo cuja transmissao consultar
        IF EMPTY(loc_cArquivo)
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarSituacao(loc_cArquivo) AND ;
               USED(loc_cCursor)

                SELECT (loc_cCursor)
                GO TOP

                THIS.grd_4c_Dados.ColumnCount  = 2
                THIS.grd_4c_Dados.RecordSource = loc_cCursor

                *-- Column1 = Envios (b.tDtEnvs), Column2 = cUsuarios
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = loc_cCursor + ".envios"
                    .Column2.ControlSource = loc_cCursor + ".cusuarios"
                ENDWITH

                *-- Rede de seguranca do Problema 48: RecordSource/
                *-- ControlSource zeram Column.Width e Header1.Caption.
                *-- Mesma fonte usada na montagem, entao nao ha numero
                *-- duplicado aqui
                THIS.AplicarFormatoGrade()

                *-- Legado: ThisForm.Text1..Text4.Value = crTmpLgSit.<coluna>,
                *-- logo depois da consulta. Os campos nao tem ControlSource
                *-- (nem aqui, nem no legado), entao a copia tem de acontecer
                *-- neste funil - ela le as properties que CarregarDoCursor
                *-- acabou de preencher
                THIS.AtualizarCabecalho()

                *-- Legado: ThisForm.Edit1.ControlSource = [crTmpLgSit.cRetornos]
                *-- (penultima linha do Init). SO aqui, com o alias ja aberto:
                *-- ControlSource de alias fechado estoura "Erro 13 - Alias
                *-- nao encontrado" (medido no VFP9, regra #41)
                IF PEMSTATUS(THIS, "edt_4c_Edit1", 5)
                    THIS.edt_4c_Edit1.ControlSource = loc_cCursor + ".cretornos"
                ENDIF

                *-- Primeira exibicao do retorno (a linha corrente eh a 1a,
                *-- pelo GO TOP acima). Mesma fonte unica que o
                *-- AfterRowColChange usa ao trocar de linha, para os dois
                *-- caminhos nao divergirem
                THIS.AtualizarDetalheRetorno()

                *-- Legado: ThisForm.Refresh no fim do Init. GO TOP antes,
                *-- porque o binding move o ponteiro do alias
                SELECT (loc_cCursor)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                loc_lCarregou = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a situa" + CHR(231) + CHR(227) + "o de " + ;
                    "transmiss" + CHR(227) + "o: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Status da Transmiss" + CHR(227) + "o")
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.
    * por padrao. Percorre recursivamente containers/sub-containers para
    * tornar tudo visivel. Este dialogo nao tem containers flutuantes
    * (toggle por botao) - todo o corpo fica sempre visivel quando a tela
    * abre, diferente de outros forms OPERACIONAIS desta mesma pasta.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisivelContainer(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarControlesVisivelContainer - recursao auxiliar de
    * TornarControlesVisiveis para sub-containers (ex.: cnt_4c_Sombra)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisivelContainer(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisivelContainer(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - fecha o cursor de envios (cursor_4c_Envios, criado por
    * SIGOPSTCBO.CarregarSituacao atraves de CarregarLista) antes de
    * encerrar. O nome do alias vem de ObterCursorEnvios, a fonte unica.
    *
    * DODEFAULT() na ULTIMA linha (regra do CLAUDE.md): FormBase.Destroy()
    * zera this_oBusinessObject e restaura o menu principal apos form
    * modal.
    *==========================================================================
    PROCEDURE Destroy
        LOCAL loc_cCursor
        loc_cCursor = THIS.ObterCursorEnvios()

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE
