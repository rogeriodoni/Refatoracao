*==============================================================================
* FormSigOpCoc.prg - Carta de Operacoes de Cheques
* Origem: SigOpCoc.SCX (task705) | Herda de: FormBase
* Tipo: OPERACIONAL - dialogo MODAL de layout FLAT (o legado NAO tem PageFrame)
* BO: SigOpCocBO | Tabela de origem dos dados: SigCdOpt (Cabs / Rods)
* Gerado: Fase 3/8 - Form, estrutura base
* Fase 5/8 - Campos: os DOIS EditBox e os DOIS labels do legado
* Fase 6/8 - Campos restantes e lookups:
*   (a) ControlSource dos DOIS EditBox, transcrito do dump e descartado pela
*       migracao: getCabs.ControlSource = "CrSigCdOpt.Cabs" e
*       getRods.ControlSource = "CrSigCdOpt.Rods". Entra guardado, fora do
*       Init (regra #41) - ver VincularCamposAoCursorOrigem.
*   (b) FormParaBO, que NAO existia: o form tinha a direcao BO -> tela e nao a
*       inversa, entao o que o usuario digitava NUNCA chegava ao BO e o OK
*       gravaria o valor carregado na abertura, em silencio.
*   (c) os handlers dos campos (ValidarCabecalho / ValidarRodape) ligados por
*       BINDEVENT em LostFocus + InteractiveChange, que ocupam o lugar da
*       escrita continua que o ControlSource fazia no legado.
*   ZERO lookup, MEDIDO (nao suposto): varredura no dump por
*   fwbusca|mAddColuna|sigacess\(|Acesso<X>\(|FormBuscaAuxiliar devolve 0
*   ocorrencias, e tasks\task705\analise.json declara "lookups": []. O SCX nao
*   tem Valid nem KeyPress em getCabs/getRods - os handlers acima por isso NAO
*   carregam regra de negocio nenhuma, e nada de dominio foi inventado: cabs e
*   rods sao "text" NULL em SigCdOpt, sem tamanho (nada de MaxLength - regra
*   #19) e sem lista de valores. Fabricar lookup ou validacao aqui violaria o
*   PILAR 1.
*   NAO ha "ultimos 50% dos campos" a acrescentar: o dump tem 11 objetos, dos
*   quais exatamente 2 de entrada (BaseClass: editbox) e 2 labels de dados, e
*   os quatro ja foram entregues INTEGRALMENTE na Fase 5.
* Fase 7/8 - Eventos principais dos botoes: BtnOKClick e BtnCancelarClick,
*   ligados por BINDEVENT ao Click de cada Buttons(N) do Grupo_Saida (ver o
*   fim de ConfigurarBotoesSaida). Sao os DOIS unicos eventos de botao que o
*   legado tem, e ate esta fase NENHUM dos dois existia: o dialogo desenhava
*   OK e Cancelar e os dois cliques nao faziam NADA - sem gravar, sem fechar.
*
*   NAO entram aqui os quatro BtnIncluirClick/BtnAlterarClick/
*   BtnVisualizarClick/BtnExcluirClick da barra CRUD, porque este legado NAO
*   TEM barra CRUD - e isso foi MEDIDO no dump, nao suposto: a raiz eh
*   "Class: form" (nao frmcadastro), nao ha Grupo_Op, nao ha objeto cujo nome
*   termine em Incluir/Alterar/Visualizar/Excluir e nao ha <X>.Click desses
*   verbos. A unica evidencia de modo eh pcEscolha, que chega como PARAMETRO
*   do Init ("LParameters pDatasession, pEscolha") - isto eh, quem decide o
*   modo eh o form PAI, e este form so o OBEDECE. Inventar os quatro botoes
*   violaria o PILAR 1 e criar os quatro metodos vazios violaria a regra de
*   completude; o que a fase exige de um legado sem CRUD eh um handler por
*   botao que o dump PROVA existir, e o Grupo_Saida tem ButtonCount = 2.
*
* Fase 8/8 - Eventos auxiliares e CONSOLIDACAO FINAL. Quatro entregas, todas
*   com trabalho REAL (nenhum metodo de corpo vazio):
*
*   (a) FecharDialogo() - CORRECAO DE DEFEITO, nao acabamento. Os dois
*       handlers da Fase 7 terminavam em THIS.Release(), transcricao literal
*       do "ThisForm.Release" legado. Medido no VFP9 (2026-10-20): Release()
*       DESTROI o objeto mesmo havendo variavel externa apontando para ele - a
*       referencia do chamador vira VARTYPE "X" e a leitura seguinte estoura
*       "is not an object". Form object NAO segue refcount de COM. Como este
*       dialogo publica um protocolo de retorno (this_lConfirmado, lido pelo
*       PAI depois do Show() - ver "Abertura" no fim deste cabecalho), o
*       Release literal tornava esse protocolo INALCANCAVEL. O legado nao
*       sofria disso porque abre com "Do Form ... With ..." e nao le retorno
*       nenhum: o dado chegava ao pai pelo cursor COMPARTILHADO CrSigCdOpt,
*       que o PILAR 3 eliminou. Fecha-se com Hide(), que em form modal TAMBEM
*       devolve o Show() (PILAR 1 intacto - para o usuario a tela fecha
*       igual); muda so o tempo de vida do objeto, que eh PILAR 3, e eh o
*       CHAMADOR quem da o Release() depois de ler. Mesmo desenho que o
*       FormBuscaAuxiliar e o Formsigopcks do projeto ja adotam.
*
*   (b) HabilitarCampos(par_lHabilitar) e AjustarBotoesPorModo() - os nomes
*       CANONICOS do projeto para os dois metodos de modo que a Fase 5 e a
*       Fase 4 criaram com nome local (AplicarModoNosCampos /
*       AplicarModoNosBotoesSaida). RENOMEADOS, nao duplicados: manter as duas
*       grafias criaria duas fontes para a MESMA regra, que divergem em
*       silencio na primeira alteracao (CLAUDE.md #44, item 6). Passam a
*       PUBLIC porque o harness do pipeline (TesteAutomatico.prg) chama
*       AjustarBotoesPorModo direto no oForm, de FORA da classe, e
*       PEMSTATUS(...,5) devolve .T. mesmo em metodo PROTECTED - o teste entra
*       no branch e a chamada real estoura "Property ... is not found".
*       Nenhum dos dois esta em FormBase, entao PUBLIC aqui nao alarga escopo
*       herdado (regra #51).
*
*   (c) LimparCampos() - fecha um buraco que o proprio codigo da Fase 6 ja
*       prometia. O comentario de CarregarCamposDaOrigem dizia "sem origem
*       alcancavel o BO mantem os defaults vazios, e eh esse vazio que tem de
*       aparecer na tela - nunca o valor de uma abertura anterior", mas isso
*       so era verdade na PRIMEIRA abertura: o BO eh criado uma vez por form e
*       CarregarCamposDaOrigem eh PUBLIC/reentrante, entao numa segunda carga
*       sem origem o this_cCabs/this_cRods da carga ANTERIOR continuava no BO
*       e reaparecia na tela. PROTECTED porque FormBase declara o hook assim
*       (regra #51). Nao escreve em campo VINCULADO por ControlSource - ali
*       atribuir .Value escreveria no registro do cursor, apagando o dado.
*
*   (d) this_cOperacaos propagado do BO de origem - sem a chave, o
*       ObterChavePrimaria() do SigOpCocBO devolvia "" e o RegistrarAuditoria
*       do BusinessBase saia pelo "IF EMPTY(loc_cChave) / RETURN .F.": a
*       gravacao funcionava e NAO deixava rastro em LogAuditoria.
*
*   O QUE NAO ENTRA, e por que (medido no dump, nao suposto):
*     - CarregarLista(): NAO existe lista neste legado. A arvore do SCX tem 11
*       objetos e ZERO "BaseClass: grid|pageframe|listbox"; nao ha AddCursor,
*       pColuna, RecordSource de grade nem objeto chamado Grade/grd. Nao ha o
*       que listar - criar o metodo exigiria INVENTAR uma grade (viola o
*       PILAR 1) ou gerar corpo vazio (proibido pela regra de completude).
*     - BtnBuscarClick() / BtnEncerrarClick() / BtnSalvarClick(): nao ha
*       botao "Buscar", "Encerrar" nem "Salvar" no SCX. O Grupo_Saida tem
*       ButtonCount = 2 e a SECAO 3 do dump declara exatamente DOIS Click -
*       "OK.Click" e "Sair.Click" -, que sao o BtnOKClick e o
*       BtnCancelarClick da Fase 7. O botao de ACAO desta tela eh o OK (e eh
*       ele que carrega o icone cadastro_salvar_60.jpg no legado).
*     - AlternarPagina(): nao ha PageFrame (layout FLAT), logo nao ha Page1 de
*       Lista nem Page2 de Dados para alternar, e a regra #40 (reabilitar os
*       botoes no funil de volta) nao tem a que se aplicar - este dialogo nao
*       volta para lista nenhuma, ele FECHA.
*   Mesma familia documental do FormSIGOPBIN (dialogo de entrada sem CRUD).
*
* ESTRUTURA DO LEGADO (SIGOPCOC.SCX) - 545 x 291, raiz "form" generico
*   SIGOPCOC
*     +- cntSombra (Container)        -> cnt_4c_Sombra        (faixa do cabecalho)
*     |    +- lblSombra (Label)       -> lbl_4c_LblSombra
*     |    +- lblTitulo (Label)       -> lbl_4c_LblTitulo
*     +- getCabs  (fwmemo/EditBox)    -> obj_4c_GetCabs       (Fase 5 - AQUI)
*     +- getRods  (fwmemo/EditBox)    -> obj_4c_GetRods       (Fase 5 - AQUI)
*     +- Say1 "Cabecalho :" (say)     -> lbl_4c_Label1        (Fase 5 - AQUI)
*     +- Say2 "Rodape :"    (say)     -> lbl_4c_Label2        (Fase 5 - AQUI)
*     +- Grupo_Saida (CommandGroup)   -> obj_4c_Grupo_Saida   (Fase 4)
*          OK (Command2) -> .Buttons(2) -> BtnOKClick       (Fase 7 - AQUI)
*          Sair (Command1) -> .Buttons(1) -> BtnCancelarClick (Fase 7 - AQUI)
*
* ESTA FASE (5/8) entrega os QUATRO objetos de dados que faltavam - os dois
* sao TODOS os campos do legado, nao metade: o dump tem exatamente 2 controles
* de entrada (BaseClass: editbox) e 2 labels de dados, e dividir isso ao meio
* deixaria a tela com um campo so, o que a regra "PROIBIDO versao reduzida"
* impede. Junto vem o que as fases anteriores deixaram explicitamente para
* esta - a aplicacao de ReadOnly nos campos (HabilitarCampos) e a carga
* inicial do Init legado (Select CrSigCdOpt / getCabs.Value = Cabs /
* getRods.Value = Rods), em BOParaForm + CarregarCamposDaOrigem.
*
* ZERO PageFrame no legado: todo controle pendura DIRETO na Form. Por isso nao
* existe ConfigurarPaginaLista/ConfigurarPaginaDados nem a compensacao +29 do
* pgf_4c_Paginas (Top = -29) - os Top do SCX entram LITERAIS.
* Nomes dos objetos conforme tasks\task705\mapeamento.json, para a etapa
* 07_validarUI casar migrado x legado sem falso "objeto nao encontrado".
*
* CONTRATO DO DIALOGO (Init legado: LParameters pDatasession, pEscolha)
*   Set DataSession to pDatasession -> o dialogo opera na sessao de dados do
*       form PAI, para alcancar o registro em edicao. No sistema novo isso eh
*       obtido NAO declarando DataSession (fica 1 = sessao corrente/default, a
*       mesma do chamador); this_nDataSessionOrigem guarda o valor recebido
*       para fidelidade e diagnostico.
*   ThisForm.pcEscolha = pEscolha -> this_cEscolha
*   InList(pcEscolha, CONSULTAR, EXCLUIR, PROCURAR) -> somente leitura: oculta
*       o OK, reposiciona o Grupo_Saida (+64 / -64) e poe os dois EditBox em
*       ReadOnly. O ESTADO eh resolvido aqui (this_lSomenteLeitura); a
*       APLICACAO nos controles acontece quando eles existirem (Fases 4-5).
*
* Abertura (form PAI = FormOpt, botao cmd_4c_BtnCarta; o legado faz
* "Do Form SigOpCoc With ThisForm.DataSessionId, ThisForm.pcEscolha"):
*
*   loForm = CREATEOBJECT("FormSigOpCoc", SET("Datasession"), THIS.this_cModoAtual)
*   IF VARTYPE(loForm) = "O"
*       loForm.this_oBOOrigem = THIS.this_oBusinessObject   && OptBO
*       loForm.CarregarCamposDaOrigem()
*       loForm.Show()                      && FORA de TRY - regra #29
*       IF loForm.this_lConfirmado         && .T. somente quando deu OK
*           *-- Cabs/Rods ja estao no OptBO; o Salvar() do PAI persiste
*       ENDIF
*   ENDIF
*
* A ORDEM eh contrato: o dialogo fecha com Hide(), continua legivel depois do
* Show() e so morre no Release() do CHAMADOR. Ler DEPOIS do Release estoura
* "is not an object"; NAO dar o Release vaza o objeto e o BO dele.
*==============================================================================

DEFINE CLASS FormSigOpCoc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do SCX legado (PILAR 1)
    * Declaradas no dump: BorderStyle, Height, Width, AutoCenter, Caption,
    * ControlBox, TitleBar, WindowType. NAO declaradas no dump e por isso NAO
    * inventadas aqui: Closable, MaxButton, MinButton - sem barra de titulo
    * elas nao DESENHAM, mas Closable segue .T. e o Alt+F4 continua sendo a
    * saida de aborto que o legado permitia.
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 545
    Height      = 291
    BorderStyle = 2
    AutoCenter  = .T.
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1                 && MODAL: o Show() bloqueia e a tela vive
    ShowWindow  = 1
    Caption     = "Carta de Opera" + CHR(231) + CHR(245) + "es de Cheques"

    *--------------------------------------------------------------------------
    * Estado / protocolo do dialogo
    *--------------------------------------------------------------------------
    this_oBusinessObject    = .NULL.
    this_cEscolha           = ""      && pcEscolha do legado (ClassInfo: pcescolha)
    this_nDataSessionOrigem = 0       && pDatasession recebido do form pai
    this_lSomenteLeitura    = .F.     && .T. em CONSULTAR / EXCLUIR / PROCURAR
    this_lConfirmado        = .F.     && .T. somente quando o usuario acionou OK

    *-- Ligacao com o registro em edicao no form pai (o cursor global
    *-- CrSigCdOpt do Fortyus nao existe nesta migracao - ver o cabecalho de
    *-- SigOpCocBO.prg)
    this_cCursorOrigem      = "CrSigCdOpt"
    this_oBOOrigem          = .NULL.

    *-- Geometria BASE do Grupo_Saida, transcrita do dump (SECAO 2). Fica em
    *-- property porque o reposicionamento do modo somente-leitura tem de ser
    *-- ABSOLUTO: o Init legado faz "Left + 64" / "Width - 64" uma UNICA vez,
    *-- num modal de vida curta, mas aqui o funil AplicarModoEscolha eh PUBLIC
    *-- e pode rodar de novo - incremental, o grupo DERIVARIA 64px por chamada
    *-- (regra #31: reaplicar no funil exige valor absoluto, nao acumulado).
    this_nSaidaLeftBase     = 389     && Grupo_Saida.Left      do SCX
    this_nSaidaWidthBase    = 160     && Grupo_Saida.Width     do SCX
    this_nSairLeftBase      = 80      && Command1Left   do SCX

    *==========================================================================
    * Init - recebe os dois parametros do Init legado e delega ao FormBase
    * Os parametros sao OPCIONAIS: os harness do pipeline (TestFormWrapper /
    * ValidarUIFidelity) instanciam com CREATEOBJECT sem argumento, e nesse
    * caso valem os defaults das properties.
    * DODEFAULT() eh quem chama InicializarForm() - NAO chamar de novo aqui.
    *==========================================================================
    PROCEDURE Init(par_nDataSession, par_cEscolha)
        *-- guardar ANTES do DODEFAULT: InicializarForm ja le este estado
        IF VARTYPE(par_nDataSession) = "N"
            THIS.this_nDataSessionOrigem = par_nDataSession
        ENDIF

        IF VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - instancia o BO e desenha a estrutura base
    * Sem gate de gnConnHandle: este dialogo nao consulta o SQL Server (o
    * legado nao tem Insert/Update/Delete nem AddCursor), entao exigir conexao
    * aqui so impediria a tela de abrir em modo de teste.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCocBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- aparencia base da Form (nao ha PageFrame a configurar)
                THIS.ConfigurarPageFrame()

                *-- faixa cinza do cabecalho: PRIMEIRO AddObject da tela, para
                *-- os containers/botoes criados depois desenharem POR CIMA
                THIS.ConfigurarCabecalho()

                *-- campos de dados (Say1/getCabs/Say2/getRods). Ficam entre a
                *-- faixa e os botoes so por clareza de leitura: eles vivem em
                *-- Top = 99..268, fora tanto da faixa (0..80) quanto do
                *-- Grupo_Saida (Top -2..83, Left 389..549), entao nao ha
                *-- sobreposicao a resolver por ordem de AddObject.
                THIS.ConfigurarCampos()

                *-- Grupo_Saida DEPOIS da faixa, para desenhar POR CIMA dela:
                *-- com Top = -2 o grupo invade a area do cabecalho (regra #11)
                THIS.ConfigurarBotoesSaida()

                THIS.TornarControlesVisiveis()

                *-- DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
                *-- em tudo: eh AplicarModoEscolha quem ESCONDE o botao OK em
                *-- CONSULTAR/EXCLUIR/PROCURAR, e na ordem inversa a varredura
                *-- apagaria esse Visible = .F.
                THIS.AplicarModoEscolha()

                *-- carga inicial dos dois campos, equivalente ao
                *-- "Select CrSigCdOpt / getCabs.Value = Cabs" do Init legado.
                *-- Depois de AplicarModoEscolha porque eh ela quem entrega
                *-- this_cCursorOrigem / this_oBOOrigem ao BO.
                THIS.CarregarCamposDaOrigem()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar SigOpCocBO (VARTYPE: " + ;
                    VARTYPE(THIS.this_oBusinessObject) + ")"
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Proc: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao inicializar FormSigOpCoc")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - aparencia base da Form
    * NAO cria PageFrame: o SCX legado nao tem nenhum (layout FLAT) e inventar
    * um violaria o PILAR 1. O nome do metodo eh mantido porque eh o ponto de
    * configuracao base dos forms do projeto - mesmo papel que em
    * FormSIGPRSTF, outro dialogo FLAT. O que ele faz aqui eh transcrever o
    * Picture de fundo que o SCX declara.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Picture = ..\framework\imagens\new_background.jpg (SCX legado)
        *-- Sem guarda IF FILE(): o arquivo existe no acervo, e mascarar a
        *-- ausencia faria o fundo sumir em silencio (regra #25).
        THIS.Picture    = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.FontName   = "Tahoma"
        THIS.FontSize   = 8
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do cabecalho (cntSombra do legado)
    * Legado: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *
    * O Width=800 do dump eh artefato do Form Designer: o CONTAINER esta
    * desenhado 255px mais largo que a propria janela (Form.Width = 545), e os
    * labels dentro dele vem com Width=769. Copiar esses literais jogaria o
    * texto para fora da area visivel e CORTARIA o titulo - por isso a faixa
    * usa THIS.Width e os labels THIS.Width - 20 (eles tem Left = 10).
    *==========================================================================
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

        *-- lblSombra: texto PRETO, 1px abaixo do titulo (efeito de sombra)
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
            .Top           = 18
            .Left          = 10
            .Height        = 40
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: texto BRANCO sobre a faixa cinza
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Top         = 17
            .Left        = 10
            .Height      = 46
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - os quatro objetos de dados do legado, pendurados
    * DIRETO na Form (nao ha container nem PageFrame no SCX)
    *
    * Legado (SECAO 2 do dump):
    *   Say1    "Cabecalho :"  Left=85   Top=99    classe say
    *   getCabs                Left=156  Top=99   276x84  classe fwmemo
    *   Say2    "Rodape :"     Left=101  Top=184   classe say
    *   getRods                Left=156  Top=184  276x84  classe fwmemo
    *
    * LABELS - classe "say" (framework.vcx): AutoSize=.T. FontName="Tahoma"
    * FontSize=8 BackStyle=0 Height=15 ForeColor=90,90,90, e Alignment nao
    * declarado (default 0 = esquerda). O SCX sobrescreve SO Caption/Left/Top,
    * entao o resto vem da classe:
    *   - ForeColor RGB(90, 90, 90), NUNCA branco: a Form tem Picture
    *     new_background.jpg (textura CLARA) e label branco sumiria (regra #12).
    *   - Alignment = 0 e NADA de .Width inventado com Alignment = 1: os Left
    *     85 e 101 do dump ja sao o escalonamento que a classe AutoSize produz.
    *     Medido no VFP9 em 2026-10-30 (TXTWIDTH * FONTMETRIC(6), Tahoma 8):
    *     "Cabecalho :" = 57px -> termina em 142; "Rodape :" = 44px -> termina
    *     em 145. Os dois param ANTES do EditBox (Left = 156), que eh
    *     exatamente o que a regra #23 manda conferir.
    *   - AutoSize = .F. com Width/Height EXPLICITOS: AutoSize eh no-op em
    *     Label criado por AddObject (a Width ficaria nos 100 do default, e
    *     101 + 100 = 201 invadiria o campo). Width 60 / 48 cabe o texto
    *     medido e termina em 145 / 149, antes dos 156 (regra #23).
    *   - WordWrap fica no default .F.: texto de UMA linha, e Height = 15 da
    *     classe. Com WordWrap = .T. o par AutoSize/Height volta a brigar.
    * Os labels sao criados ANTES dos EditBox para o campo desenhar por cima e
    * a caixa transparente do label nunca bloquear o clique (regra #23).
    *
    * EDITBOX - classe "fwmemo" (framework.vcx): FontName="Tahoma" FontSize=8
    * Themes=.F. DisabledBackColor=192,192,192 DisabledForeColor=0,0,0. O SCX
    * sobrescreve so a geometria. ScrollBars fica no default 2 (vertical) - a
    * classe nao declara, e eh o que o usuario precisa num memo de 84px.
    *
    * SEM MaxLength de proposito: SigCdOpt.cabs e SigCdOpt.rods sao "text" no
    * schema (conferido em docs\schema.sql), ou seja SEM limite de tamanho.
    * MaxLength aqui so poderia vir de um palpite - e copiar o Width (276)
    * seria exatamente o defeito da regra #19.
    *
    * .Value = "" (CARACTERE) na criacao: EditBox assume o tipo do que for
    * atribuido, e nascer logico faria o primeiro BOParaForm estourar
    * "Operator/operand type mismatch".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- Say1: rotulo do Cabecalho
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Top       = 99
            .Left      = 85
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cabe" + CHR(231) + "alho :"
            .Visible   = .T.
        ENDWITH

        *-- getCabs: memo do Cabecalho da carta (SigCdOpt.cabs)
        THIS.AddObject("obj_4c_GetCabs", "EditBox")
        WITH THIS.obj_4c_GetCabs
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Top               = 99
            .Left              = 156
            .Width             = 276
            .Height            = 84
            .ScrollBars        = 2
            .Themes            = .F.
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .ToolTipText       = "Cabe" + CHR(231) + "alho impresso na carta de opera" + ;
                                 CHR(231) + CHR(245) + "es"
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Say2: rotulo do Rodape
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Top       = 184
            .Left      = 101
            .Width     = 48
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Rodap" + CHR(233) + " :"
            .Visible   = .T.
        ENDWITH

        *-- getRods: memo do Rodape da carta (SigCdOpt.rods)
        THIS.AddObject("obj_4c_GetRods", "EditBox")
        WITH THIS.obj_4c_GetRods
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Top               = 184
            .Left              = 156
            .Width             = 276
            .Height            = 84
            .ScrollBars        = 2
            .Themes            = .F.
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .ToolTipText       = "Rodap" + CHR(233) + " impresso na carta de opera" + ;
                                 CHR(231) + CHR(245) + "es"
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- EVENTOS dos dois campos (Fase 6)
        *--
        *-- O SCX legado NAO declara Valid nem KeyPress em getCabs/getRods: o
        *-- que levava o digitado para o registro era o ControlSource
        *-- ("CrSigCdOpt.Cabs" / "CrSigCdOpt.Rods"), que escreve no cursor
        *-- continuamente. No caminho canonico desta migracao a origem eh o BO
        *-- do form pai (this_oBOOrigem), onde nao existe cursor a vincular -
        *-- entao estes dois handlers ocupam EXATAMENTE o lugar daquela
        *-- ligacao: normalizam o valor e o devolvem ao BO. NAO carregam regra
        *-- de negocio nenhuma, porque o legado nao tem nenhuma aqui (cabs e
        *-- rods sao "text" NULL em SigCdOpt - sem tamanho e sem dominio a
        *-- validar) e inventar validacao violaria o PILAR 1.
        *--
        *-- "LostFocus" + "InteractiveChange" de proposito: LostFocus eh a
        *-- posicao do Valid legado e InteractiveChange reproduz a escrita
        *-- CONTINUA que o ControlSource fazia. Nenhum dos dois passa
        *-- parametro, por isso os handlers nao declaram nenhum (regra #3); e
        *-- como nao abrem dialogo modal, nao ha reentrancia a guardar
        *-- (regra #37). Handlers PUBLIC - BINDEVENT falha em SILENCIO com
        *-- metodo PROTECTED.
        BINDEVENT(THIS.obj_4c_GetCabs, "LostFocus",         THIS, "ValidarCabecalho")
        BINDEVENT(THIS.obj_4c_GetCabs, "InteractiveChange", THIS, "ValidarCabecalho")
        BINDEVENT(THIS.obj_4c_GetRods, "LostFocus",         THIS, "ValidarRodape")
        BINDEVENT(THIS.obj_4c_GetRods, "InteractiveChange", THIS, "ValidarRodape")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesSaida - Grupo_Saida do legado (CommandGroup, 2 botoes)
    *
    * Este eh o UNICO conjunto de botoes do dialogo. O SCX legado NAO tem Grid,
    * NAO tem lista e NAO tem os 6 botoes CRUD (Incluir/Visualizar/Alterar/
    * Excluir/Buscar/Encerrar): a arvore do dump tem 11 objetos, com ZERO
    * "BaseClass: grid|pageframe|listbox" e ZERO AddCursor/pColuna/Grade. Nao
    * ha o que listar - fabricar barra CRUD violaria o PILAR 1 e a regra "NUNCA
    * inventar". Medido no gate da Fase 4: este legado cai no ramo "layout
    * captura" (sem lista + campos de ENTRADA), que dispensa Grid+CRUD.
    *
    * Legado (SECAO 2 do dump):
    *   Grupo_Saida  AutoSize=.T. ButtonCount=2 BackStyle=0 BorderStyle=0
    *                Value=1 Top=-2 Left=389 Width=160 Height=85
    *                SpecialEffect=1 BorderColor=136,189,188
    *   Command2 "OK"        Top=5 Left=5  75x75 cadastro_salvar_60.jpg   TabIndex=1
    *   Command1 "Cancelar"  Top=5 Left=80 75x75 cadastro_cancelar_60.jpg TabIndex=2 Cancel=.T.
    *
    * Enderecamento por .Buttons(N), NAO por .Name: o legado renomeia
    * Command1 -> Sair e Command2 -> OK, e renomear membro de grupo quebraria a
    * referencia por indice. Mapa fixo deste form:
    *   .Buttons(1) = Command1 = Sair/Cancelar     .Buttons(2) = Command2 = OK
    *
    * .ButtonCount vem ANTES de qualquer .Buttons(N): CommandGroup criado por
    * AddObject nasce com ButtonCount = 0, e .Buttons(1) estouraria "BUTTONS is
    * not an object" (medido - nao eh problema da sintaxe do WITH).
    *
    * O grupo NAO recebe ForeColor nem FontName: CommandGroup nao tem essas
    * propriedades (medido em automation\propriedades_baseclasses.txt) e
    * atribui-las derrubaria o Init - regra #33. A fonte vai em cada botao.
    *
    * Left=389 + Width=160 = 549 contra Form.Width = 545: os 4px finais do
    * CONTAINER sao recortados, exatamente como no legado (mesma geometria e
    * mesma largura de janela). Nenhum BOTAO se perde - Sair termina em 544 - e
    * o grupo eh BackStyle = 0, entao nada visivel fica de fora (regra #30).
    *
    * SpecialEffect / PicturePosition / MousePointer / AutoSize dos BOTOES nao
    * aparecem no dump porque vem da CLASSE do Framework, nao da instancia; os
    * valores estao em docs\framework_frmcadastro_layout.md ("Propriedades
    * comuns de TODOS os botoes"). Sem eles, o CommandButton base do VFP9
    * desenharia o icone AO LADO do texto, e nao acima dele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesSaida()
        THIS.AddObject("obj_4c_Grupo_Saida", "CommandGroup")

        WITH THIS.obj_4c_Grupo_Saida
            *-- PRIMEIRO: sem ButtonCount, .Buttons(N) nao resolve
            .ButtonCount = 2

            *-- .Buttons(2) = Command2 do legado = OK (confirma e fecha)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .Caption         = "\<OK"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .TabIndex        = 1
                .AutoSize        = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            *-- .Buttons(1) = Command1 do legado = Sair/Cancelar. Cancel = .T.
            *-- faz o ESC acionar este botao, como no legado.
            WITH .Buttons(1)
                .Top             = 5
                .Left            = THIS.this_nSairLeftBase
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Cancelar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .TabIndex        = 2
                .Cancel          = .T.
                .AutoSize        = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            *-- geometria do GRUPO por ULTIMO: com AutoSize = .T. eh o botao
            *-- INTERNO que define o tamanho do grupo. Medido no VFP9 em
            *-- 2026-10-30: com AutoSize = .T. o CommandGroup IGNORA qualquer
            *-- atribuicao a .Width (num grupo de teste, .Width = 160 e depois
            *-- 96 ficaram ambos em 94, o valor que ele mesmo calculou); .Left
            *-- continua valendo. Aqui isso nao atrapalha e ainda CONFIRMA os
            *-- botoes: o AutoSize derivou 160 x 85 - exatamente o que o dump
            *-- declara - a partir de 5+75+75+5 e 5+75+5. As linhas .Width /
            *-- .Height abaixo ficam por fidelidade ao dump, cientes de que o
            *-- AutoSize prevalece.
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Value         = 1
            .Top           = -2
            .Left          = THIS.this_nSaidaLeftBase
            .Width         = THIS.this_nSaidaWidthBase
            .Height        = 85
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Fase 7 - eventos dos botoes. O legado tem um Click por BOTAO, nao um
        * Click de GRUPO (SECAO 3: "PROCEDURE Sair.Click" e "PROCEDURE
        * OK.Click"), entao a ligacao eh feita em cada Buttons(N) e nao no
        * CommandGroup - assim nao eh preciso desempatar por .Value, e o botao
        * escondido em CONSULTAR/EXCLUIR/PROCURAR simplesmente nao dispara.
        *
        * Buttons(2) = Command2 do dump = OK      -> BtnOKClick
        * Buttons(1) = Command1 do dump = Sair    -> BtnCancelarClick
        *
        * Handlers PUBLIC: BINDEVENT nao dispara metodo PROTECTED, e falha em
        * SILENCIO quando o alvo nao eh alcancavel (regra #3).
        *----------------------------------------------------------------------
        BINDEVENT(THIS.obj_4c_Grupo_Saida.Buttons(2), "Click", THIS, "BtnOKClick")
        BINDEVENT(THIS.obj_4c_Grupo_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - poe nos botoes o estado que o Init legado
    * derivava de pcEscolha:
    *   If InList(ThisForm.pcEscolha, 'CONSULTAR', 'EXCLUIR', 'PROCURAR')
    *       ThisForm.Grupo_Saida.OK.Visible = .f.
    *       ThisForm.Grupo_Saida.Left  = ThisForm.Grupo_Saida.Left  + 64
    *       ThisForm.Grupo_Saida.Width = ThisForm.Grupo_Saida.Width - 64
    *       ThisForm.Grupo_Saida.Sair.Left = 5
    *   Endif
    *
    * Em valor ABSOLUTO (base +/- 64) e com ramo ELSE que REPOE o estado de
    * escrita - ver this_nSaidaLeftBase. O legado nao precisa do ELSE porque o
    * dialogo dele nasce e morre num unico modo; aqui o metodo eh reentrante.
    *
    * O .Width eh NO-OP e esta aqui so por fidelidade: medido no VFP9, com
    * AutoSize = .T. o CommandGroup descarta toda atribuicao a .Width, entao o
    * "Width - 64" do legado tambem nunca surtiu efeito la. Sem consequencia
    * visual - o grupo eh BackStyle = 0 e BorderStyle = 0, isto eh, nao desenha
    * nada de si mesmo; o que o usuario ve sao os botoes, e esses obedecem
    * (medido: em CONSULTAR o grupo vai para Left = 453, o OK desaparece e o
    * Cancelar assume Left = 5). NAO trocar por AutoSize = .F. para "fazer o
    * Width colar": o dump declara AutoSize = .T. e a troca mudaria o
    * dimensionamento do grupo sem ganho nenhum.
    *
    * NOME CANONICO do projeto (Fase 8) - era AplicarModoNosBotoesSaida.
    * PUBLIC de proposito: o harness do pipeline (TesteAutomatico.prg) chama
    * AjustarBotoesPorModo direto no oForm, de FORA da classe. Com PROTECTED a
    * chamada estoura "Property AJUSTARBOTOESPORMODO is not found" em runtime,
    * porque o PEMSTATUS(...,5) que o harness usa como guarda devolve .T. de
    * qualquer jeito (so confere EXISTENCIA, nao escopo). O metodo nao existe
    * em FormBase, entao PUBLIC aqui nao alarga escopo herdado (regra #51).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lSoLeitura

        *-- o grupo pode ainda nao existir se AplicarModoEscolha (PUBLIC) for
        *-- chamado de fora antes de InicializarForm concluir
        IF !PEMSTATUS(THIS, "obj_4c_Grupo_Saida", 5)
            RETURN
        ENDIF

        loc_lSoLeitura = THIS.this_lSomenteLeitura

        WITH THIS.obj_4c_Grupo_Saida
            *-- OK sai de cena em CONSULTAR/EXCLUIR/PROCURAR e volta nos demais
            .Buttons(2).Visible = !loc_lSoLeitura

            IF loc_lSoLeitura
                .Left            = THIS.this_nSaidaLeftBase + 64
                .Width           = THIS.this_nSaidaWidthBase - 64
                .Buttons(1).Left = 5
            ELSE
                .Left            = THIS.this_nSaidaLeftBase
                .Width           = THIS.this_nSaidaWidthBase
                .Buttons(1).Left = THIS.this_nSairLeftBase
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - poe nos dois EditBox o estado que o Init legado
    * derivava de pcEscolha, no MESMO If dos botoes:
    *       ThisForm.getCabs.ReadOnly = .t.
    *       ThisForm.getrods.ReadOnly = .t.
    *
    * Com ramo ELSE que REPOE ReadOnly = .F., pela mesma razao do irmao
    * AjustarBotoesPorModo: o legado atravessa esse If UMA vez, num modal de
    * vida curta, enquanto aqui o funil AplicarModoEscolha eh PUBLIC e
    * reentrante - sem o ELSE, um unico CONSULTAR travaria os campos para
    * sempre (regra #31: reaplicar no funil exige estado ABSOLUTO).
    *
    * Sem mexer em BackColor: o legado so troca ReadOnly, e o cinza de campo
    * desabilitado ja vem do DisabledBackColor da classe fwmemo.
    *
    * NOME CANONICO do projeto (Fase 8) - era AplicarModoNosCampos. Nao esta
    * em FormBase, logo PUBLIC aqui nao alarga escopo herdado (regra #51), e
    * PUBLIC eh o que permite ao form PAI reaplicar o modo depois de trocar
    * this_cEscolha sem reabrir o dialogo.
    *
    * par_lHabilitar eh OPCIONAL e segue a assinatura canonica do projeto
    * (HabilitarCampos(par_lHabilitar)). Omitido, o estado vem do modo que o
    * legado derivou de pcEscolha - que eh a UNICA fonte de verdade desta tela
    * e o que todos os call sites internos querem. Passado, vale o parametro:
    * eh assim que o harness e o form pai podem travar/soltar os campos sem
    * mexer em this_cEscolha.
    *
    * O teste de "foi passado?" eh PCOUNT(), NUNCA VARTYPE. Medido no VFP9
    * (2026-10-30): parametro LOGICO omitido chega com VALOR .F. e
    * VARTYPE/TYPE iguais a "L" - indistinguivel de um .F. passado de
    * proposito. Com "IF VARTYPE(par_lHabilitar) = 'L'" a chamada sem
    * argumento de AplicarModoEscolha caia no ramo do parametro, lia !.F. e
    * punha os DOIS EditBox em ReadOnly = .T. em TODO modo - inclusive
    * INCLUIR/ALTERAR: a tela abria com OK visivel e os campos travados, sem
    * erro nenhum (medido: SoLeitura=.F. e RO_Cabs=.T.). PCOUNT() devolve 0 no
    * omitido e 1 no passado, e eh o unico jeito de separar os dois casos.
    * Parametro CARACTERE/NUMERICO nao sofre disso (o omitido chega logico,
    * entao VARTYPE = "C"/"N" ja prova que veio) - por isso o Init deste form
    * continua certo testando VARTYPE.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lSoLeitura

        *-- os campos podem ainda nao existir se AplicarModoEscolha (PUBLIC)
        *-- for chamado de fora antes de InicializarForm concluir
        IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            RETURN
        ENDIF

        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lSoLeitura = !par_lHabilitar
        ELSE
            loc_lSoLeitura = THIS.this_lSomenteLeitura
        ENDIF

        THIS.obj_4c_GetCabs.ReadOnly = loc_lSoLeitura
        THIS.obj_4c_GetRods.ReadOnly = loc_lSoLeitura
    ENDPROC

    *==========================================================================
    * LimparCampos - zera Cabs/Rods no BO e nos dois EditBox (Fase 8)
    *
    * Fecha o buraco que o comentario de CarregarCamposDaOrigem ja prometia e
    * nao cumpria: "sem origem alcancavel o BO mantem os defaults vazios ...
    * nunca o valor de uma abertura anterior". Isso valia so na PRIMEIRA
    * carga - o BO eh criado UMA vez por form, e CarregarCamposDaOrigem eh
    * PUBLIC e reentrante (o form pai a chama depois de atribuir
    * this_oBOOrigem), entao numa segunda carga SEM origem o this_cCabs da
    * carga anterior continuava no BO e voltava para a tela.
    *
    * NAO escreve em campo VINCULADO por ControlSource: ali o .Value eh o
    * campo do cursor, e atribuir "" APAGARIA o cabecalho/rodape do registro
    * - uma gravacao que ninguem pediu. Por isso o teste de ControlSource
    * vazio antes de cada atribuicao. No caminho vinculado nao ha o que
    * limpar: quem manda na tela eh o proprio registro.
    *
    * PROTECTED porque FormBase declara o hook assim - em VFP9 a subclasse NAO
    * alarga escopo de metodo herdado (regra #51), e omitir o modificador aqui
    * so esconderia que ele continua protegido.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCabs = ""
            THIS.this_oBusinessObject.this_cRods = ""
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
            IF EMPTY(THIS.obj_4c_GetCabs.ControlSource)
                THIS.obj_4c_GetCabs.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            IF EMPTY(THIS.obj_4c_GetRods.ControlSource)
                THIS.obj_4c_GetRods.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - leva Cabs/Rods do BO para os dois EditBox
    * PROTECTED porque FormBase ja declara o hook assim: em VFP9 a subclasse
    * NAO alarga escopo, e escrever sem PROTECTED aqui so esconderia que ele
    * continua protegido. Quem precisa disparar a carga de fora usa o
    * CarregarCamposDaOrigem(), que eh PUBLIC.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            RETURN
        ENDIF

        *-- TratarNulo porque cabs/rods sao "text" NULL no schema: coluna
        *-- vazia chega como .NULL. e atribuir isso ao EditBox trocaria o tipo
        *-- do .Value. O 2o argumento eh o valor PADRAO, nao um codigo de tipo:
        *-- passar "C" ali gravaria a LETRA "C" no cabecalho da carta.
        THIS.obj_4c_GetCabs.Value = TratarNulo(THIS.this_oBusinessObject.this_cCabs, "")
        THIS.obj_4c_GetRods.Value = TratarNulo(THIS.this_oBusinessObject.this_cRods, "")
    ENDPROC

    *==========================================================================
    * FormParaBO - leva o que esta nos dois EditBox para o BO (Fase 6)
    *
    * Direcao INVERSA do BOParaForm, e a que faltava: sem ela o usuario digita
    * e o valor NUNCA chega ao BO, entao o OK gravaria o conteudo CARREGADO na
    * abertura e nao o DIGITADO - falha silenciosa, sem erro em tela nenhum.
    *
    * SEM ALLTRIM: o legado grava o .Value CRU
    *       Replace Cabs With ThisForm.getCabs.Value, ;
    *               Rods With ThisForm.getrods.Value
    * e cabs/rods sao "text" no schema (SigCdOpt) - aparar o texto aqui mudaria
    * o dado gravado. TratarNulo entra apenas para proteger o TIPO: coluna
    * "text" NULL devolve .NULL. ao EditBox quando o ControlSource esta
    * vinculado, e um .NULL. levado ao BO quebraria as operacoes de string do
    * REPLACE em SigOpCocBO.GravarNaOrigem.
    *
    * PROTECTED porque FormBase declara o hook assim - em VFP9 a subclasse NAO
    * alarga escopo de metodo herdado (regra #51). Quem precisa disparar de
    * fora usa os handlers PUBLIC ValidarCabecalho/ValidarRodape.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cCabs = TratarNulo(THIS.obj_4c_GetCabs.Value, "")
        THIS.this_oBusinessObject.this_cRods = TratarNulo(THIS.obj_4c_GetRods.Value, "")
    ENDPROC

    *==========================================================================
    * ValidarCabecalho - handler do campo getCabs (Fase 6)
    * Ligado por BINDEVENT em "LostFocus" e "InteractiveChange" (ver
    * ConfigurarCampos). Ocupa o lugar da ligacao ControlSource do legado:
    * normaliza o valor e o devolve ao BO. Nenhuma regra inventada - o SCX
    * legado nao tem Valid neste campo e a coluna destino eh "text" NULL.
    *
    * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
    *
    * Em somente leitura (CONSULTAR/EXCLUIR/PROCURAR) nao transfere nada: o
    * legado deixa os dois campos ReadOnly e esconde o OK, logo nao existe
    * valor digitado a levar para o BO.
    *==========================================================================
    PROCEDURE ValidarCabecalho()
        IF THIS.this_lSomenteLeitura
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
            RETURN
        ENDIF

        *-- normaliza o proprio campo antes de transferir: .NULL. vindo da
        *-- coluna "text" trocaria o tipo do .Value e travaria a digitacao
        IF ISNULL(THIS.obj_4c_GetCabs.Value)
            THIS.obj_4c_GetCabs.Value = ""
        ENDIF

        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * ValidarRodape - handler do campo getRods (Fase 6)
    * Gemeo de ValidarCabecalho - mesmas razoes, mesmo escopo PUBLIC.
    *==========================================================================
    PROCEDURE ValidarRodape()
        IF THIS.this_lSomenteLeitura
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            RETURN
        ENDIF

        IF ISNULL(THIS.obj_4c_GetRods.Value)
            THIS.obj_4c_GetRods.Value = ""
        ENDIF

        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * VincularCamposAoCursorOrigem - transcreve o ControlSource dos dois
    * EditBox do SCX legado (Fase 6):
    *       getCabs.ControlSource = "CrSigCdOpt.Cabs"
    *       getRods.ControlSource = "CrSigCdOpt.Rods"
    *
    * Por que NAO fica em ConfigurarCampos: no Init o alias ainda nao existe, e
    * ControlSource apontando para cursor inexistente estoura "Alias ... is not
    * found" DENTRO do TRY do InicializarForm - o CREATEOBJECT devolve .F., o
    * menu nao entra no IF VARTYPE(loForm) = "O" e o usuario clica e NADA abre,
    * sem erro visivel (regra #41). Por isso a vinculacao roda depois, em
    * CarregarCamposDaOrigem, e SO quando o alias esta aberto e tem as colunas.
    *
    * So vincula no caminho do CURSOR, que eh o que o legado literalmente faz
    * ("Select CrSigCdOpt"). No caminho canonico desta migracao (this_oBOOrigem
    * = o BO do form pai) nao existe cursor a vincular, e vincular ali faria o
    * valor vindo do BO ser ESCRITO no alias ja na abertura, ANTES do OK -
    * divergencia que o legado nao tem. Nesse caminho a transferencia eh
    * explicita, pelo par BOParaForm / FormParaBO.
    *
    * Fica VISIVEL que, vinculado, o que o usuario digita vai para o cursor na
    * hora: eh o comportamento do legado, cujo Sair.Click so faz Release sem
    * desfazer nada - NAO acrescentar restauracao que o legado nao tem.
    *==========================================================================
    PROTECTED FUNCTION VincularCamposAoCursorOrigem()
        LOCAL loc_cAlias, loc_lPodeVincular

        IF !PEMSTATUS(THIS, "obj_4c_GetCabs", 5) OR !PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            RETURN .F.
        ENDIF

        loc_cAlias        = ALLTRIM(TratarNulo(THIS.this_cCursorOrigem, ""))
        loc_lPodeVincular = .F.

        *-- exige alias ABERTO e com as DUAS colunas: TYPE devolve "U" quando o
        *-- campo nao existe e "C"/"M" quando eh texto/memo
        IF VARTYPE(THIS.this_oBOOrigem) != "O" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            IF TYPE(loc_cAlias + ".Cabs") $ "CM" AND TYPE(loc_cAlias + ".Rods") $ "CM"
                loc_lPodeVincular = .T.
            ENDIF
        ENDIF

        IF loc_lPodeVincular
            THIS.obj_4c_GetCabs.ControlSource = loc_cAlias + ".Cabs"
            THIS.obj_4c_GetRods.ControlSource = loc_cAlias + ".Rods"
        ELSE
            THIS.obj_4c_GetCabs.ControlSource = ""
            THIS.obj_4c_GetRods.ControlSource = ""
        ENDIF

        RETURN loc_lPodeVincular
    ENDFUNC

    *==========================================================================
    * DesvincularCamposDoCursorOrigem - solta o ControlSource dos dois campos
    * Chamado no Destroy: o alias do form pai pode ser fechado antes deste
    * dialogo morrer, e EditBox vinculado a alias fechado estoura no proximo
    * repaint. Atribuir "" apenas DESLIGA a ligacao, sem consultar o alias,
    * entao eh seguro mesmo com o cursor ja fechado.
    *==========================================================================
    PROTECTED PROCEDURE DesvincularCamposDoCursorOrigem()
        IF PEMSTATUS(THIS, "obj_4c_GetCabs", 5)
            THIS.obj_4c_GetCabs.ControlSource = ""
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_GetRods", 5)
            THIS.obj_4c_GetRods.ControlSource = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarCamposDaOrigem - carga inicial dos dois campos, equivalente as
    * tres linhas do Init legado:
    *       Select CrSigCdOpt
    *       ThisForm.getCabs.Value = CrSigCdOpt.Cabs
    *       ThisForm.getrods.Value = CrSigCdOpt.Rods
    *
    * O cursor global CrSigCdOpt do Fortyus nao existe nesta migracao, entao a
    * origem eh resolvida nos dois caminhos que o BO ja preve (ver o cabecalho
    * de SigOpCocBO.prg): this_oBOOrigem (o OptBO do form PAI - caminho
    * canonico) e, na falta dele, o alias this_cCursorOrigem quando estiver
    * aberto na sessao de dados - que eh literalmente a situacao do legado,
    * possivel aqui porque o dialogo nao declara DataSession e portanto roda na
    * sessao do chamador.
    *
    * PUBLIC de proposito: o form PAI so consegue atribuir this_oBOOrigem
    * DEPOIS do CREATEOBJECT (o Init legado recebe apenas pDatasession e
    * pEscolha), entao ele precisa poder repetir a carga antes do Show():
    *       loForm = CREATEOBJECT("FormSigOpCoc", SET("Datasession"), "ALTERAR")
    *       loForm.this_oBOOrigem = THIS.this_oBusinessObject
    *       loForm.CarregarCamposDaOrigem()
    *       loForm.Show()
    * Nao eh chamado de dentro de AplicarModoEscolha justamente para nao
    * sobrescrever o que o usuario ja digitou se o funil de modo rodar de novo.
    *==========================================================================
    PROCEDURE CarregarCamposDaOrigem()
        LOCAL loc_lSucesso, loc_oErro, loc_lVinculado
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- parte do vazio em TODO caminho: sem isto, uma segunda
                *-- carga sem origem alcancavel exibiria o Cabs/Rods da carga
                *-- ANTERIOR (o BO eh criado UMA vez por form e este metodo eh
                *-- PUBLIC/reentrante). Nao toca em campo vinculado por
                *-- ControlSource - ver LimparCampos.
                THIS.LimparCampos()

                IF VARTYPE(THIS.this_oBOOrigem) = "O"
                    *-- caminho canonico: le direto o BO do form pai, espelho
                    *-- exato do que SigOpCocBO.GravarNaOrigem escreve de volta
                    THIS.this_oBusinessObject.this_oBOOrigem = THIS.this_oBOOrigem
                    THIS.this_oBusinessObject.this_cCabs = ;
                        TratarNulo(THIS.this_oBOOrigem.this_cCabs, "")
                    THIS.this_oBusinessObject.this_cRods = ;
                        TratarNulo(THIS.this_oBOOrigem.this_cRods, "")

                    *-- chave do registro em edicao, SO para a auditoria: sem
                    *-- ela o ObterChavePrimaria do SigOpCocBO devolve "" e o
                    *-- RegistrarAuditoria do BusinessBase sai pelo
                    *-- "IF EMPTY(loc_cChave) / RETURN .F." - a gravacao
                    *-- funciona e nao deixa rastro em LogAuditoria.
                    *-- PEMSTATUS porque o BO de origem eh de OUTRA classe
                    *-- (OptBO hoje) e nao se pode presumir a property.
                    IF PEMSTATUS(THIS.this_oBOOrigem, "this_cOperacaos", 5)
                        THIS.this_oBusinessObject.this_cOperacaos = ;
                            TratarNulo(THIS.this_oBOOrigem.this_cOperacaos, "")
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    *-- caminho alternativo: o alias do registro em edicao esta
                    *-- aberto na sessao (o "Select CrSigCdOpt" do legado).
                    *-- CarregarDoCursor ja guarda tambem os valores de entrada
                    *-- que o Cancelar usa para restaurar.
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor( ;
                        THIS.this_cCursorOrigem)
                ENDIF

                *-- ControlSource do legado: vincula os dois EditBox ao alias
                *-- quando ELE eh a origem (o "Select CrSigCdOpt" do Init
                *-- legado). Vinculado, a tela ja exibe o conteudo do cursor, e
                *-- reatribuir .Value aqui ESCREVERIA no registro - por isso o
                *-- BOParaForm roda so no caminho SEM vinculo.
                loc_lVinculado = THIS.VincularCamposAoCursorOrigem()

                IF !loc_lVinculado
                    *-- repinta os campos SEMPRE: sem origem alcancavel o BO
                    *-- fica com os campos que o LimparCampos acima zerou, e
                    *-- eh esse vazio que tem de aparecer na tela - nunca o
                    *-- valor de uma abertura anterior
                    THIS.BOParaForm()
                ENDIF

                *-- nos DOIS caminhos o BO termina igual ao que esta na TELA,
                *-- para o OK da Fase 7 gravar o que o usuario ve
                THIS.FormParaBO()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar Cabe" + CHR(231) + "alho/Rodap" + CHR(233) + ":" + ;
                CHR(13) + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpCoc.CarregarCamposDaOrigem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AplicarModoEscolha - resolve o estado que o Init legado derivava de
    * pcEscolha e propaga o protocolo para o BO:
    *   If InList(pcEscolha, CONSULTAR, EXCLUIR, PROCURAR) -> somente leitura
    * O Grupo_Saida (Fase 4) e os EditBox getCabs/getRods (Fase 5) recebem o
    * estado aqui, por AjustarBotoesPorModo e HabilitarCampos - os
    * dois reentrantes e com ramo ELSE, porque este funil eh PUBLIC.
    * Metodo PUBLIC: o harness do pipeline chama de fora da classe.
    *==========================================================================
    PROCEDURE AplicarModoEscolha()
        *-- Os TRES primeiros nomes sao os do legado, transcritos do Init:
        *--     If InList(ThisForm.pcEscolha, 'CONSULTAR', 'EXCLUIR', 'PROCURAR')
        *-- "VISUALIZAR" entra na Fase 8 por TRADUCAO de vocabulario, nao por
        *-- politica nova: quem passa o modo eh o form PAI (o legado faz
        *-- "Do Form SigOpCoc With ThisForm.DataSessionId, ThisForm.pcEscolha"),
        *-- e no frmcadastro legado o modo de consulta se chama 'CONSULTAR'
        *-- enquanto no sistema novo o this_cModoAtual equivalente se chama
        *-- "VISUALIZAR". Sem o quarto nome, abrir a carta pelo FormOpt em
        *-- VISUALIZAR daria uma tela EDITAVEL com o botao OK a mostra - o
        *-- oposto do legado, sem erro nenhum na tela. "ALTERAR" eh comum as
        *-- duas vocabularios e "INCLUIR"/"INSERIR" sao os dois modos de
        *-- escrita, entao nada mais precisa de traducao.
        THIS.this_lSomenteLeitura = INLIST(ALLTRIM(UPPER(THIS.this_cEscolha)), ;
            "CONSULTAR", "EXCLUIR", "PROCURAR", "VISUALIZAR")

        *-- o dialogo nasce sem confirmacao: so o OK marca this_lConfirmado
        THIS.this_lConfirmado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cEscolha        = THIS.this_cEscolha
            THIS.this_oBusinessObject.this_nDataSession    = THIS.this_nDataSessionOrigem
            THIS.this_oBusinessObject.this_lSomenteLeitura = THIS.this_lSomenteLeitura
            THIS.this_oBusinessObject.this_lConfirmado     = .F.
            THIS.this_oBusinessObject.this_cCursorOrigem   = THIS.this_cCursorOrigem

            IF VARTYPE(THIS.this_oBOOrigem) = "O"
                THIS.this_oBusinessObject.this_oBOOrigem = THIS.this_oBOOrigem
            ENDIF
        ENDIF

        *-- propaga o estado para os botoes e para os dois EditBox. Sem
        *-- argumento em HabilitarCampos de proposito: o estado desta tela vem
        *-- de this_lSomenteLeitura, que o legado deriva de pcEscolha - passar
        *-- um literal aqui criaria uma SEGUNDA fonte para a mesma regra.
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *==========================================================================
    * BtnOKClick - evento do botao OK (Fase 7)
    *
    * TRANSCRICAO do OK.Click legado, que eh o UNICO ponto de gravacao desta
    * tela:
    *       Select CrSigCdOpt
    *       Replace Cabs With ThisForm.getCabs.Value, ;
    *               Rods With ThisForm.getrods.Value
    *       ThisForm.Release
    *
    * As tres linhas viram, nesta arquitetura:
    *   1. FormParaBO()                 - leva o DIGITADO para o BO. Os
    *      handlers de campo ja fazem isso a cada tecla, mas repetir aqui
    *      cobre o caminho em que o usuario clica no OK sem o campo perder o
    *      foco (o LostFocus do EditBox dispara DEPOIS do Click do botao).
    *   2. EditarRegistro() + Salvar()  - o Replace. Salvar() eh quem chama
    *      Atualizar() -> GravarNaOrigem(), que devolve Cabs/Rods ao registro
    *      do form pai (BO de origem) ou, na falta dele, faz o Replace direto
    *      no alias - exatamente os dois caminhos que SigOpCocBO documenta.
    *      EditarRegistro() vem ANTES porque BusinessBase.Salvar() recusa quem
    *      nao esta em edicao ("Nao esta em modo de edicao"): sem ela o OK
    *      falharia sempre. Ambos sao PUBLIC na base - o form NUNCA chama
    *      Inserir()/Atualizar(), que sao PROTECTED (regra #51).
    *   3. FecharDialogo()              - fecha o dialogo, SO em caso de
    *      sucesso: falhando, a tela fica aberta com o texto do usuario
    *      preservado, em vez de fechar engolindo a edicao. Fecha com Hide()
    *      e nao com Release() para o form pai conseguir LER
    *      this_lConfirmado depois do Show() - ver FecharDialogo.
    *
    * SEM MsgInfo de sucesso: o legado nao exibe nenhuma, e o dialogo fechando
    * ja eh o retorno visual. SEM MsgErro na falha: BusinessBase.Salvar() ja
    * reporta toda recusa por ExibirFalha e marca this_lErroExibido (regra
    * #20) - repetir aqui exibiria a mesma falha duas vezes. O ELSE existe so
    * para o caso de a base deixar passar algo sem exibir.
    *
    * Guard de somente leitura: em CONSULTAR/EXCLUIR/PROCURAR o legado ESCONDE
    * o OK, logo nao ha clique possivel. O guard cobre a chamada por codigo
    * (harness do pipeline, form pai) e eh o que impede gravar numa tela que o
    * usuario ve como consulta. Fica ANTES do TRY - RETURN dentro de TRY/CATCH
    * eh proibido (regra #1).
    *
    * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
    *==========================================================================
    PROCEDURE BtnOKClick()
        LOCAL loc_oErro, loc_lGravou

        *-- nada a confirmar quando a tela esta em consulta
        IF THIS.this_lSomenteLeitura
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel - " + ;
                "n" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar Cabe" + CHR(231) + ;
                "alho/Rodap" + CHR(233) + ".", "FormSigOpCoc")
            RETURN
        ENDIF

        loc_lGravou = .F.

        TRY
            *-- 1. o que esta na TELA passa a ser o que esta no BO
            THIS.FormParaBO()

            *-- 2. o Replace do legado, pela porta PUBLIC do BusinessBase
            IF THIS.this_oBusinessObject.EditarRegistro()
                loc_lGravou = THIS.this_oBusinessObject.Salvar()
            ELSE
                *-- EditarRegistro so recusa com this_lNovoRegistro ligado, e
                *-- ela NAO exibe nada: aqui a falha nao pode ser muda
                MsgErro(TratarNulo(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar a edi" + ;
                    CHR(231) + CHR(227) + "o do registro."), "FormSigOpCoc")
            ENDIF

            IF loc_lGravou
                *-- protocolo lido pelo form pai depois do Show(): este flag
                *-- vive na FORM e sobrevive ao Destroy, que zera o BO
                THIS.this_lConfirmado = .T.

                *-- 3. ThisForm.Release do legado - ver FecharDialogo, que
                *-- fecha com Hide() para o pai poder LER este flag
                THIS.FecharDialogo()
            ELSE
                *-- a base ja reportou; so falamos se ela nao tiver falado
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o " + ;
                        "Cabe" + CHR(231) + "alho/Rodap" + CHR(233) + " da carta.", ;
                        "FormSigOpCoc")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpCoc.BtnOKClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - evento do botao Sair/Cancelar (Fase 7)
    *
    * TRANSCRICAO do Sair.Click legado, que tem UMA linha so:
    *       ThisForm.Release
    *
    * NAO pede confirmacao e NAO restaura valor nenhum - o legado nao faz as
    * duas coisas, e acrescenta-las mudaria o comportamento da tela (PILAR 1).
    * Em particular: no caminho em que os EditBox estao vinculados por
    * ControlSource ao alias de origem, o que o usuario digitou JA foi escrito
    * no cursor durante a digitacao, e o Sair legado tambem nao desfaz isso -
    * "restaurar" aqui inventaria um desfazer que o legado nunca teve. O que
    * o Cancelar de fato garante eh nao disparar a gravacao do OK: no caminho
    * canonico (BO do form pai) nada chega ao pai sem passar por GravarNaOrigem.
    *
    * CancelarEdicao() (PUBLIC em BusinessBase) devolve o BO ao estado de
    * consulta, para que um OK posterior numa reabertura nao encontre o BO
    * ainda "em edicao" de uma sessao anterior.
    *
    * Fecha pelo MESMO funil do OK (FecharDialogo, com Hide()): o form pai le
    * this_lConfirmado = .F. para saber que nao deve aproveitar nada, e com
    * Release() essa leitura estouraria "is not an object".
    *
    * Este botao tem Cancel = .T. no dump, entao ESC tambem cai aqui.
    *
    * PUBLIC: BINDEVENT nao dispara metodo PROTECTED (regra #3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            *-- o dialogo sai SEM confirmacao: o form pai le este flag para
            *-- saber que nao deve aproveitar nada
            THIS.this_lConfirmado = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lConfirmado = .F.
                THIS.this_oBusinessObject.CancelarEdicao()
            ENDIF

            *-- ThisForm.Release do legado - ver FecharDialogo
            THIS.FecharDialogo()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpCoc.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
    * deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no VFP9 (2026-10-20): THIS.Release() destroi o objeto mesmo
    * havendo variavel externa apontando para ele - form object NAO segue
    * refcount de COM. A referencia do chamador vira VARTYPE "X" e a leitura
    * seguinte estoura "is not an object". Este dialogo PUBLICA um protocolo
    * de retorno (this_lConfirmado, que o form pai le depois do Show() para
    * saber se deve aproveitar a edicao), entao o Release literal tornava esse
    * protocolo inalcancavel - defeito que o legado nao tem porque la o dado
    * chegava ao pai pelo cursor COMPARTILHADO CrSigCdOpt, eliminado pelo
    * PILAR 3.
    *
    * Hide() em form modal TAMBEM devolve o Show(), entao para o usuario a
    * tela fecha igual (PILAR 1 preservado); muda so o tempo de vida do
    * objeto, que eh PILAR 3, e eh o CHAMADOR quem chama Release() depois de
    * ler. Mesmo desenho que o FormBuscaAuxiliar ("Usa Hide() em vez de
    * Release() para permitir leitura de propriedades") e o Formsigopcks do
    * projeto ja adotam.
    *
    * NAO existe PROCEDURE Unload no SCX legado (SECAO 3 declara tres metodos:
    * Init, Sair.Click e OK.Click), entao nao ha contrato de retorno por
    * "DO FORM ... TO <var>" a espelhar aqui - acrescentar um Unload com
    * RETURN inventaria protocolo que o legado nunca teve.
    *
    * Solta o ControlSource ANTES de esconder: entre o Hide() e o Release()
    * do chamador o form continua vivo, e o pai pode fechar o alias de origem
    * nesse intervalo - EditBox vinculado a alias morto estoura no proximo
    * repaint. Desvincular NAO desfaz nada: no caminho vinculado o digitado ja
    * foi escrito no cursor durante a digitacao, e o Sair legado tambem nao
    * desfaz (ver VincularCamposAoCursorOrigem).
    *
    * Funil UNICO dos dois botoes: OK e Cancelar compartilham a decisao de
    * COMO fechar, e so divergem no this_lConfirmado que cada um deixa.
    *==========================================================================
    PROCEDURE FecharDialogo()
        THIS.DesvincularCamposDoCursorOrigem()

        THIS.Hide()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria os controles com Visible = .F.
    * Percorre os controles da Form e os filhos de cada container. Este
    * dialogo nao tem container flutuante (nenhum objeto do SCX nasce com
    * Visible = .F.), entao nao ha lista de excecao a respeitar.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera o BO e as referencias ao form pai
    * DODEFAULT() eh a ULTIMA linha: FormBase.Destroy reconstroi os popups do
    * menu principal, e sem ele o menu encolhe ao fechar o dialogo.
    *==========================================================================
    PROCEDURE Destroy()
        *-- solta o ControlSource antes de tudo: o alias do form pai pode
        *-- ja ter sido fechado, e EditBox vinculado a alias morto estoura
        *-- no proximo repaint
        THIS.DesvincularCamposDoCursorOrigem()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- referencia ao BO do form PAI: soltar sem destruir o objeto dele
        THIS.this_oBOOrigem = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
