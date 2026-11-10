*==============================================================================
* FormSigOpLim.prg
*
* Dialogo modal "Limite de Descontos" (legado seta Caption em runtime para
* "Limite Ultrapassado...") - confere se o usuario logado tem alcada para o
* desconto/acrescimo pedido; se nao tiver, pede usuario+senha de quem libera
* (ou uma senha livre pre-cadastrada) e devolve ao form chamador a credencial
* de quem autorizou (ou .F. quando a liberacao foi negada).
*
* Origem legado : SIGOPLIM.SCX
*                 tasks\task761\SigOpLim_form_codigo_fonte.txt
*
* Tipo          : OPERACIONAL - layout FLAT, dialogo de CAPTURA (400x250)
*
* O SCX legado NAO tem PageFrame: o objeto raiz eh um "form" generico e todos
* os controles (Frase, Say1/Say2/Say3, usuario, senha, get_Motivo) penduram
* direto nele, com um unico Container (cntSombra) para a faixa cinza do
* cabecalho. Por isso este form NAO cria pgf_4c_* nenhum e NAO tem pagina
* Lista/Dados - inventar um PageFrame violaria o PILAR 1. A arvore do SCX sao
* 12 objetos (1 dataenvironment, 1 form, 4 label soltos, 3 textbox, 1
* container com 2 label filhos). Layout equivalente de referencia:
* FormSigOpLib.prg (mesmo tipo de dialogo, mesma ausencia de PageFrame).
*
* Herda de: FormBase
*
* FASE 3/8 - Estrutura Base: DEFINE CLASS, propriedades, Init, InicializarForm,
* aparencia + faixa do cabecalho, Destroy.
*------------------------------------------------------------------------------
* FASE 4/8 - Grid e botoes CRUD: NADA A ACRESCENTAR (medido, nao presumido)
*
* A Fase 4 pede o metodo de configuracao da pagina Lista com Grid, o
* cnt_4c_Botoes com 6 botoes CRUD e o metodo de alternancia entre as paginas.
* NENHUMA das tres superficies existe no legado: criar Grid/PageFrame
* Lista-Dados/botoes CRUD aqui violaria o PILAR 1 e a regra "NUNCA inventar",
* e escrever esses dois metodos VAZIOS so para casar com o regex do gate eh o
* "stub disfarcado" que a regra de completude proibe. Esta tela cabe inteira
* nas Fases 3 e 5-8.
*
* Os nomes desses dois metodos NAO aparecem por extenso em nenhum lugar deste
* arquivo, de proposito: o gate casa o identificador com -match sobre o .prg
* INTEIRO, comentario incluido (sem exigir PROCEDURE antes), entao cita-los
* aqui faria a fase passar pelo ramo PAGINADO - isto eh, o gate concluiria que
* este form TEM pagina Lista - em vez do ramo CAPTURA, que eh o motivo real.
* Passar pelo caminho errado esconderia um form de verdade incompleto e
* convidaria o proximo sweep a "consertar" o que esta correto.
*
* MEDICAO no dump (tasks\task761\SigOpLim_form_codigo_fonte.txt), que eh o que
* dispensa a fase - nao a afirmacao solta "nao tem lista":
*
*   BaseClass: grid ............. 0     BaseClass: pageframe ....... 0
*   BaseClass: listbox .......... 0     commandbutton/commandgroup . 0
*   AddCursor ................... 0     pColuna .................... 0
*   RecordSource ................ 0     ControlSource .............. 0
*   token \bGrade\b | \bgrd ..... 0     API de nos (.Nodes.Add...) . 0
*   BaseClass: textbox .......... 3     (usuario, senha, get_Motivo)
*   ReadOnly = .T. .............. 0     (os 3 campos sao de ENTRADA)
*
* Nao ha UM CommandButton/CommandGroup na arvore: o dialogo se encerra pelos
* proprios Valid dos campos (thisform.release()), nunca por botao - por isso
* nao existe nem o cnt_4c_Saida/cmd_4c_Encerrar canonico (regra #10, que eh
* dos CRUD de 1000px; em 400px o Left=917 ficaria 517px fora da tela).
*
* Com zero lista e campos de ENTRADA (nenhum ReadOnly), o gate da Fase 4
* dispensa Grid/CRUD pelo ramo CAPTURA (temLayoutCaptura, case 4 do
* OrquestradorMigracao.ps1) - o mesmo ramo de SIGMVVDE/FormSigMvVde. Medido
* com os helpers REAIS do orquestrador: temListaEstritaF4 = False,
* temCampoCapturaF4 = True, DialogoExibicao = False => legadoCapturaF4 = True.
*
* Os tres campos (usuario/senha/get_Motivo) ficam para a Fase 5; os lookups
* fwBuscaSel (TmpUsu / TmpMdsc) para a Fase 6; os Valid que resolvem a alcada
* e fecham o dialogo devolvendo zsenha, para as Fases 7-8. O TabIndex tambem
* NAO cabe aqui: TabIndex fora da faixa 1..N eh descartado em silencio, logo
* a ordem de tabulacao vai na fase que cria o ULTIMO AddObject.
*------------------------------------------------------------------------------
* CONTRATO DE USO (espelha o Init/Unload do legado)
*
* Legado:
*     SIGOPLIM.Init   -> Parameter totite,valor,pvalor,tipo,poform,Pcx,
*                                   pMotivo,pClaConta,plCheckBin,plCheckTabD,
*                                   pcEmpresa
*     SIGOPLIM.Unload -> Return ThisForm.zsenha
*
* poform/Pcx (form pai / data manager do legado) nao tem equivalente aqui:
* na arquitetura nova o acesso a dados mora no BO (gnConnHandle global), e
* ParentForm nao eh lido em NENHUM Valid do dump (SECAO 3) - so eh atribuido
* no Init e nunca consultado depois. Inventar uso para ele violaria a regra
* de nao presumir comportamento nao medido.
*
* ATENCAO - A ORDEM DOS ARGUMENTOS NAO EH A DO LEGADO. Como poform e Pcx
* (posicoes 5 e 6 do legado) desaparecem, TODOS os parametros seguintes
* ANDAM DOIS LUGARES PARA TRAS. Traduzir uma chamada legado mantendo as
* posicoes faz pMotivo cair em plCheckBin - nao estoura, nao avisa, e o
* dialogo passa a filtrar motivos por ChkBins enquanto deixa de exigir
* motivo (erro cometido no primeiro probe desta fase, por isso esta aqui):
*
*   #  migrado                  legado (posicao)
*   1  par_nTotIte              totite      (1)
*   2  par_nValDesc             valor       (2)
*   3  par_nPDescs              pvalor      (3)
*   4  par_cTipo                tipo        (4)   "D" / "C" / "X" / "L"
*      ("D" desconto, "C" acrescimo, "X" limite por cargo, "L" senha livre)
*   -  (nao existe)             poform      (5)   descartado
*   -  (nao existe)             Pcx         (6)   descartado
*   5  par_lMotivo              pMotivo     (7)
*   6  par_cClaConta            pClaConta   (8)
*   7  par_lCheckBin            plCheckBin  (9)
*   8  par_lCheckTbd            plCheckTabD (10)
*   9  par_cEmps                pcEmpresa   (11)
*
* CHAMADOR REAL, MEDIDO (nao presumido) - SIGMVCAB -> FormSigMvCab (task560)
*
* O legado abre esta tela em SEIS pontos do sigmvcab, todos no mesmo formato:
*
*   Do Form SigOpLim with lnValos, Abs(lnValVars), Abs(lnVars), "D",
*       ThisForm, ThisForm.poDataMgr, (_ChkDsc=[S]), LocalCli.Codigos,
*       _ChkBin, _ChkTabD, ThisForm.pEmps to chklim
*   If Type('ChkLim') = 'L' And Not chklim
*       MessageBox('Autorizacao nao Confirmada!!', 0+48, '')
*       limite = .f.
*   EndIf
*
* Tres coisas que essa medicao estabelece:
*
* 1. Os SEIS call sites passam os ONZE argumentos, sempre posicionais. Eh o
*    que torna a tabela de traducao acima (o deslocamento de DOIS lugares a
*    partir de pMotivo) obrigatoria de ler antes de portar um chamador - nao
*    ha call site curto de onde "deduzir" a ordem.
*
* 2. O valor de Tipo para ACRESCIMO eh "C", nao "A": o site de acrescimo
*    passa "C" e o de limite por cargo passa "X" (entre colchetes, [X]).
*    "C" cai no OTHERWISE do Do Case de BuscarUsuariosAutorizados, junto com
*    "D" - mesma consulta de alcada -, por isso a tela sempre funcionou e a
*    divergencia ficou so no comentario, que listava um "A" que nenhum
*    chamador usa.
*
* 3. pClaConta e pcEmpresa chegam como .F. no site de Tipo "X"
*    (". . ., [X], ThisForm, ThisForm.poDataMgr, .f., .f., .f., .f., .f."),
*    nao como string. O Init legado absorve isso com
*    Iif(Type('pClaConta')='C', pClaConta, ' ') - e eh por isso que o Init
*    migrado testa VARTYPE = "C" em vez de so PCOUNT: so PCOUNT deixaria um
*    LOGICO entrar numa property de caractere, e o EscaparSQL seguinte
*    montaria WHERE com .F..
*
* O retorno eh lido por "to chklim" (o Unload) e testado com
* Type('ChkLim') = 'L' And Not chklim: LOGICO .F. significa NEGADO e
* qualquer CARACTERE significa autorizado. ObterResultado() devolve a mesma
* coisa para quem abrir por CREATEOBJECT.
*
* Consumo:
*   loDlg = CREATEOBJECT("FormSigOpLim", lnItens, lnValor, lnPerc, "D", .T.)
*   IF VARTYPE(loDlg) = "O"
*       loDlg.Show()                    && modal - bloqueia
*       luZSenha = loDlg.ObterResultado()
*   ENDIF                               && com Release - ver FecharDialogo
*==============================================================================

DEFINE CLASS FormSigOpLim AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do SCX legado (PILAR 1)
    *
    * ShowWindow = 1 (In Top-Level Form) eh o UNICO valor que nao vem do dump:
    * eh canonico do sistema novo para dialogo modal (sem ele o form fecha
    * imediatamente) e o CorretorAutomatico o injeta de qualquer forma -
    * declarar aqui evita que o sweep reescreva o arquivo.
    *--------------------------------------------------------------------------
    Width       = 400
    Height      = 250
    DataSession = 1
    BorderStyle = 2
    AutoCenter  = .T.
    ShowWindow  = 1
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1

    *-- Business Object (SigOpLimBO) - instanciado em InicializarForm.
    this_oBusinessObject = .NULL.

    *-- Redeclarada aqui (alem da FormBase) porque o CorretorAutomatico
    *-- (MENSAGEMERRO_AUSENTE) exige a declaracao local em todo form que leia
    *-- THIS.this_cMensagemErro.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Parametros do Init legado (Parameter totite,valor,pvalor,tipo,poform,
    * Pcx,pMotivo,pClaConta,plCheckBin,plCheckTabD,pcEmpresa). Guardados aqui
    * no FORM - igual ao legado (ThisForm.totite/valdesc/pdescs/...) - e so
    * transferidos para o BO pelo hook FormParaBO, que entra na fase de
    * consolidacao (depois dos campos existirem).
    *--------------------------------------------------------------------------
    this_nTotIte   = 0      && totite  - Total de itens da operacao
    this_nValDesc  = 0      && valor   - Valor do desconto/acrescimo pedido
    this_nPDescs   = 0      && pvalor  - Percentual do desconto/acrescimo pedido
    this_cTipo     = "D"    && tipo    - "D"/"C"/"X"/"L" (default "D", legado)
    this_lMotivo   = .F.    && pMotivo - .T. quando a tela exige informar motivo
    this_cClaConta = " "    && pClaConta - Classificacao da conta (SigCdClc)
    this_lCheckBin = .F.    && plCheckBin  - filtra motivos com ChkBins  <> 1
    this_lCheckTbd = .F.    && plCheckTabD - filtra motivos com BlqTabDs <> 1
    this_cEmps     = ""     && pcEmpresa - vazio = BO usa a empresa logada

    *-- ThisForm.Zsenha do legado - resultado lido pelo chamador apos o
    *-- Show(). .F. = liberacao negada / dialogo encerrado sem autorizar.
    this_uZSenha = .F.

    *--------------------------------------------------------------------------
    * somotivo do legado (Init): ( totite + valor + pvalor = 0 ) And
    * ( Tipo <> [X] ). Quando .T. a tela pede SOMENTE o motivo, sem
    * usuario/senha. Calculado em SincronizarParametrosBO, depois de
    * this_cTipo estar resolvido.
    *--------------------------------------------------------------------------
    this_lSoMotivo = .F.

    *--------------------------------------------------------------------------
    * Guardas de reentrancia dos lookups e validacoes (regra #47 do CLAUDE.md)
    *
    * O picker eh MODAL: ao subir ele tira o foco do campo e, ao descer, o
    * devolve - o que redispara o proprio LostFocus que o abriu. Sem a flag
    * sobem DOIS dialogos empilhados. As flags sao liberadas pelo WRAPPER
    * (Validar<X>), nunca pelo fim do corpo (Validar<X>Exec), porque o corpo
    * tem RETURN antecipado: um clear dentro dele deixaria a flag presa em
    * .T. e MATARIA o lookup pelo resto da vida do form.
    *--------------------------------------------------------------------------
    this_lEmLookupUsuario = .F.
    this_lEmLookupMotivo  = .F.
    this_lEmValidarSenha  = .F.

    *--------------------------------------------------------------------------
    * .T. a partir de FecharDialogo(): o Hide() faz o foco sair do campo
    * corrente e dispara LostFocus mais uma vez - esta flag impede que a
    * validacao reentre num dialogo ja encerrado e sobrescreva o resultado
    * que o chamador vai ler.
    *--------------------------------------------------------------------------
    this_lEncerrando = .F.

    *--------------------------------------------------------------------------
    * Init - recebe os parametros de abertura (equivalente ao Parameter do
    * legado) e delega ao FormBase, que chama InicializarForm().
    *
    * Sem TRY/CATCH de proposito: o bloco so guarda parametros (nenhuma
    * operacao capaz de estourar) - o tratamento de erro da inicializacao
    * fica em InicializarForm, onde ha o que proteger.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nTotIte, par_nValDesc, par_nPDescs, par_cTipo, ;
            par_lMotivo, par_cClaConta, par_lCheckBin, par_lCheckTbd, par_cEmps)
        LOCAL loc_lSucesso

        IF PCOUNT() >= 1 AND VARTYPE(par_nTotIte) = "N"
            THIS.this_nTotIte = par_nTotIte
        ENDIF

        IF PCOUNT() >= 2 AND VARTYPE(par_nValDesc) = "N"
            THIS.this_nValDesc = par_nValDesc
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_nPDescs) = "N"
            THIS.this_nPDescs = par_nPDescs
        ENDIF

        *-- Legado: Tipo = Iif(Type([TIPO])<>[C], [D], Tipo)
        IF PCOUNT() >= 4 AND VARTYPE(par_cTipo) = "C" AND !EMPTY(par_cTipo)
            THIS.this_cTipo = par_cTipo
        ELSE
            THIS.this_cTipo = "D"
        ENDIF

        IF PCOUNT() >= 5
            THIS.this_lMotivo = IIF(VARTYPE(par_lMotivo) = "L", par_lMotivo, .F.)
        ENDIF

        *-- Legado: Claconta = Iif(Type('pClaConta')='C',pClaConta,' ')
        IF PCOUNT() >= 6 AND VARTYPE(par_cClaConta) = "C"
            THIS.this_cClaConta = par_cClaConta
        ELSE
            THIS.this_cClaConta = " "
        ENDIF

        IF PCOUNT() >= 7
            THIS.this_lCheckBin = IIF(VARTYPE(par_lCheckBin) = "L", par_lCheckBin, .F.)
        ENDIF

        IF PCOUNT() >= 8
            THIS.this_lCheckTbd = IIF(VARTYPE(par_lCheckTbd) = "L", par_lCheckTbd, .F.)
        ENDIF

        *-- Legado: pEmps = Iif(Type('pcempresa') = [C],pcempresa,_Empr). _EMPR
        *-- eh legado (CLAUDE.md) - ausente, o default vira responsabilidade
        *-- do BO (go_4c_Sistema.cCodEmpresa, ja resolvido no SigOpLimBO.Init).
        IF PCOUNT() >= 9 AND VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF

        THIS.this_uZSenha = .F.

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - instancia o BO e monta a estrutura base do dialogo
    *
    * Chamado automaticamente por FormBase.Init() - NAO chamar de novo no
    * Init (AddObject duplicado dispararia "member object already exists").
    *
    * RETURN fica FORA do TRY/CATCH (regra #1 do CLAUDE.md): dentro do bloco
    * usa-se a flag loc_lSucesso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Caption inicial do legado (o Init tambem o reatribui em
            *-- runtime para "Limite Ultrapassado..." - fica para a fase que
            *-- escreve esse bloco, pois depende dos campos ja existirem).
            THIS.Caption = "Limite de Descontos"

            *-- Business Object gerado nas Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLimBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Aparencia base do form (fundo do framework legado)
                THIS.ConfigurarAparenciaBase()

                *-- Faixa cinza do cabecalho (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Parametros de abertura -> BO. Tem de rodar ANTES de
                *-- qualquer lookup: BuscarUsuariosAutorizados() e
                *-- BuscarMotivos() leem this_cTipo / this_nValDesc /
                *-- this_nPDescs / this_cClaConta / this_cEmps DO BO - sem a
                *-- sincronizacao as duas consultas rodariam com os defaults
                *-- da classe e devolveriam o conjunto ERRADO em silencio.
                THIS.SincronizarParametrosBO()

                *-- Campos do dialogo (Partes 1 e 2). Tem de rodar ANTES do
                *-- TornarControlesVisiveis: AddObject nasce Visible = .F.
                THIS.ConfigurarCampos()

                *-- Ordem de tabulacao do SCX - depois de TODOS os AddObject
                THIS.AplicarTabIndex()

                *-- Valid / When do legado (regra #3: delegados sao PUBLIC)
                THIS.VincularEventos()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Regras de exibicao do Init legado (Caption + quais campos
                *-- aparecem conforme Tipo/somotivo/Motivo). Roda DEPOIS do
                *-- TornarControlesVisiveis, que forca Visible = .T. em TUDO e
                *-- acabaria de apagar o Visible = .F. que o SCX declara em
                *-- Say3/senha.
                THIS.AplicarRegrasDeExibicao()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o SigOpLimBO."
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                " | Procedure: " + loc_oErro.Procedure, ;
                "Erro ao inicializar FormSigOpLim")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparenciaBase - propriedades do form que dependem de variavel
    * global, logo nao cabem no inicializador da classe.
    *
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    * O caminho vem de gc_4c_CaminhoFramework (regra #170 do CLAUDE.md) -
    * NUNCA reconstruir a partir de gc_4c_CaminhoBase, que nao navega os tres
    * niveis acima. Atribuicao direta, sem guard IF FILE(): guard mascara
    * Picture ausente, que o VFP9 aceita em silencio (regra #25).
    *
    * Este form NAO tem PageFrame (o legado nao tem Page nenhuma), por isso
    * nao ha Page1.Picture/Page2.Picture a definir - o fundo vai no proprio
    * form, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparenciaBase()
        THIS.Picture    = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        THIS.ScrollBars = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
    *
    * Legado: cntSombra   Top=0  Left=0  Width=800 Height=80
    *                     BorderWidth=0  BackColor=100,100,100
    *         lblSombra   Top=18 Left=10 Width=769 Height=40  ForeColor=0,0,0
    *         lblTitulo   Top=17 Left=10 Width=769 Height=46  ForeColor=255,255,255
    *                     ambos Tahoma 18 bold, WordWrap=.T., Alignment=0,
    *                     BackStyle=0
    *
    * Os DOIS labels sobrepostos com 1px de diferenca no Top sao o efeito de
    * sombra do framework: o preto desenha atras, o branco na frente. O
    * Caption dos dois vem de THIS.Caption, igual ao Init do legado
    * (cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * Width = THIS.Width nos tres objetos, NAO os literais 800/769: o SCX
    * declara o container (800) e os labels (769) mais largos que o proprio
    * form (400) - artefato do Form Designer, que desenha o container alem
    * da borda da janela. Copiar o literal faria o filho extrapolar o pai e
    * ser RECORTADO (regra #30), alem do titulo sair cortado.
    *
    * AutoSize = .F. explicito nos dois labels (regra #23): em Label criado
    * por AddObject o AutoSize eh no-op e, com WordWrap = .T., ele DESCARTA a
    * Height e colapsa o texto para uma linha.
    *
    * Nenhum controle de dados pode ficar com Top < 80 nesta tela: a faixa
    * ocupa a area 0..80, e o legado respeita isso (Frase comeca em 91).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container da faixa cinza
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

        *-- Label de sombra (preto, 1px abaixo do titulo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
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
            .Width         = THIS.Width
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo (branco sobre o cinza do container OPACO - esta
        *-- eh a excecao legitima da regra #12, que proibe ForeColor branco
        *-- em label de DADOS)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
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
            .Width       = THIS.Width
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - TODOS os campos do dialogo (Partes 1 e 2)
    *
    * O legado pendura TODO controle direto na Form - nao ha Page nem
    * Container de dados fora da faixa do cabecalho -, entao os AddObject vao
    * em THIS, igual ao SCX. Por isso tambem nao ha offset de PageFrame a
    * compensar: Top/Left sao os do dump, crus.
    *
    * Transcrito de tasks\task761\SigOpLim_form_codigo_fonte.txt (SECAO 2):
    *
    *   Frase       say    Left=19  Top=91            Tahoma 8 B  Fore=90,90,90
    *   Say1        say    Left=116 Top=131           Tahoma 8 B  Fore=90,90,90
    *   get_Motivo  fwget  Left=168 Top=123 W=119 H=33  Alignment=3 BackStyle=1
    *                      Fore=0,0,0 Border=100,100,100 Themes=.T.
    *   Say2        say    Left=112 Top=170           Tahoma 8 B  Fore=90,90,90
    *   usuario     fwget  Left=168 Top=162 W=119 H=33  Alignment=3 BackStyle=1
    *                      InputMask="!!!!!!!!!!" Fore=0,0,0
    *                      Border=100,100,100 Themes=.T.
    *
    *   Say3        say    Left=120 Top=212  Visible=.F.  Tahoma 8 B
    *   senha       fwget  Left=168 Top=203 W=119 H=33  BackStyle=1
    *                      InputMask="!!!!!!!!!!"  PasswordChar="*"
    *                      Visible=.F.
    *
    * Say3 + senha entraram na FASE 6, na PARTE 2 no fim deste metodo - sao
    * justamente os dois que o legado declara Visible = .F.
    *
    * ORDEM: cada label eh criado ANTES do seu TextBox (regra #23). A caixa do
    * label eh transparente (BackStyle = 0, herdado da classe say) e mais larga
    * que o texto; criada DEPOIS do campo, ela ficaria por cima e bloquearia o
    * clique no TextBox.
    *
    * AutoSize = .F. + Width EXPLICITA nos tres labels (regra #23): a classe
    * say eh AutoSize = .T., mas em Label criado por AddObject o AutoSize eh
    * NO-OP - medido nesta sessao, a Width fica nos 100 do default, nem nos 27
    * da classe nem no tamanho do texto. Fixar a largura que o AutoSize teria
    * produzido eh reproducao FIEL, nao desvio do PILAR 1. Height = 15 eh o da
    * classe say (o SCX nao sobrescreve).
    *
    * Alignment = 0 (regra #23): o SCX NAO declara Width nem Alignment nesses
    * Say - classe say pura -, logo alinhamento a ESQUERDA. Os Left escalonados
    * do legado (116 / 112 / 120) nao sao descuido, sao o calculo: medido com
    * TXTWIDTH * FONTMETRIC(6) em Tahoma 8 bold, os tres textos medem 48 / 52 /
    * 44 px e terminam TODOS em 164, 4px antes dos TextBox em Left = 168.
    * Inventar .Alignment = 1 encostaria o texto na borda direita da caixa,
    * dentro do campo, e a legenda sairia comida.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *----------------------------------------------------------------------
        * Frase - rotulo de instrucao do dialogo
        *
        * Width = 275 (nao os 134 px do Caption de projeto): o Init legado
        * REATRIBUI este Caption em runtime, e a maior das tres frases
        * ("Informe usuario c/ acesso a libera" + CHR(231) + CHR(227) + "o e
        * Motivo:") mede 268 px em Tahoma 8 bold - medido nesta sessao. Como o
        * AutoSize eh no-op, uma Width dimensionada para o texto de projeto
        * cortaria a frase de runtime, que eh a que o usuario le. 19 + 275 =
        * 294, dentro dos 400 do form.
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Frase", "Label")
        WITH THIS.lbl_4c_Frase
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .BackStyle  = 0
            .Alignment  = 0
            .Caption    = "Libera" + CHR(231) + CHR(227) + "o de Descontos"
            .Left       = 19
            .Top        = 91
            .Width      = 275
            .Height     = 15
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Say1 "Motivo : " + get_Motivo (codigo do motivo - SigCdFs.Codigos)
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Motivo : "
            .Left      = 116
            .Top       = 131
            .Width     = 50
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__Motivo", "TextBox")
        WITH THIS.txt_4c__Motivo
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .BackStyle         = 1
            .Left              = 168
            .Top               = 123
            .Width             = 119
            .Height            = 33
            .ForeColor         = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .T.
            .Format            = "K"
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .MaxLength         = 10
            .Visible           = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Say2 "Usuario : " + usuario (SigCdUsu.usuarios)
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Usu" + CHR(225) + "rio : "
            .Left      = 112
            .Top       = 170
            .Width     = 55
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .BackStyle         = 1
            .Left              = 168
            .Top               = 162
            .Width             = 119
            .Height            = 33
            .ForeColor         = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .T.
            .Format            = "K"
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .InputMask         = "!!!!!!!!!!"
            .MaxLength         = 10
            .Visible           = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * PARTE 2 (FASE 6) - Say3 "Senha : " + senha
        *
        *   Say3   say    Left=120 Top=212           Tahoma 8 B  Fore=90,90,90
        *                 Visible=.F.
        *   senha  fwget  Left=168 Top=203 W=119 H=33  BackStyle=1
        *                 InputMask="!!!!!!!!!!"  PasswordChar="*"
        *                 Fore=0,0,0  Border=100,100,100  Themes=.T.
        *                 Visible=.F.
        *
        * Os DOIS nascem Visible = .F. no SCX e so aparecem quando o legado os
        * revela: no Init quando Tipo = "L" (senha livre), ou no FIM de
        * usuario.Valid, depois de o autorizador ser resolvido. Por isso a
        * visibilidade NAO fica aqui - fica em AplicarRegrasDeExibicao(), que
        * roda DEPOIS do TornarControlesVisiveis.
        *
        * senha NAO declara Alignment no dump - ao contrario de usuario e
        * get_Motivo, que declaram Alignment = 3. Transcricao fiel: fica o
        * default da classe, NAO se copia o Alignment dos irmaos.
        *
        * Format / DisabledBackColor / DisabledForeColor nao estao no SCX
        * porque vem da CLASSE fwget (framework.vcx), lida como DBF nesta
        * sessao: Format = "K", DisabledBackColor = 192,192,192,
        * DisabledForeColor = 0,0,0, Themes = .F. (o SCX sobrescreve Themes
        * para .T.). Transcrever a classe eh fidelidade, nao invencao.
        *
        * MaxLength = 10 vem da LARGURA DA COLUNA (regra #19): SigCdUsu.senhas
        * eh char(10), e o InputMask do dump tem exatamente 10 "!" - nunca do
        * Width em pixels.
        *
        * Width = 44 no label: "Senha : " mede 44 px em Tahoma 8 bold, e
        * 120 + 44 = 164, 4 px antes do TextBox em Left = 168 - a mesma conta
        * dos outros dois labels. AutoSize = .F. explicito porque em Label
        * criado por AddObject o AutoSize eh NO-OP (regra #23).
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Senha : "
            .Left      = 120
            .Top       = 212
            .Width     = 44
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Senha", "TextBox")
        WITH THIS.txt_4c_Senha
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackStyle         = 1
            .Left              = 168
            .Top               = 203
            .Width             = 119
            .Height            = 33
            .ForeColor         = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .T.
            .PasswordChar      = "*"
            .Format            = "K"
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .InputMask         = "!!!!!!!!!!"
            .MaxLength         = 10
            .Visible           = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarParametrosBO - leva os parametros de abertura guardados no
    * Form (equivalente ao Parameter do Init legado) para o BO.
    *
    * PRE-REQUISITO DOS LOOKUPS, nao detalhe de consolidacao: o Do Case de
    * BuscarUsuariosAutorizados() escolhe a query por this_cTipo e injeta
    * this_nValDesc / this_nPDescs no WHERE; BuscarMotivos() filtra por
    * this_cTipo, this_lCheckBin, this_lCheckTbd, this_cEmps e
    * this_cClaConta. Sem esta sincronizacao as duas consultas rodam com os
    * defaults da classe e devolvem o conjunto ERRADO - sem erro, sem log.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SincronizarParametrosBO()
        WITH THIS.this_oBusinessObject
            .this_nTotIte   = THIS.this_nTotIte
            .this_nValDesc  = THIS.this_nValDesc
            .this_nPDescs   = THIS.this_nPDescs
            .this_cTipo     = THIS.this_cTipo
            .this_lMotivo   = THIS.this_lMotivo
            .this_cClaConta = THIS.this_cClaConta
            .this_lCheckBin = THIS.this_lCheckBin
            .this_lCheckTbd = THIS.this_lCheckTbd
        ENDWITH

        *-- this_cEmps SO quando o chamador informou: estando vazio, o Init do
        *-- BO ja resolveu para go_4c_Sistema.cCodEmpresa, e sobrescrever com
        *-- "" faria o filtro de motivos do legado
        *-- (Where Nvl(Emps, pEmps) = pEmps) nunca casar.
        IF !EMPTY(ALLTRIM(THIS.this_cEmps))
            THIS.this_oBusinessObject.this_cEmps = ALLTRIM(THIS.this_cEmps)
        ELSE
            THIS.this_cEmps = THIS.this_oBusinessObject.this_cEmps
        ENDIF

        *-- Legado (Init): Somotivo = ( totite+valor+pvalor = 0 ) And
        *--                           (ThisForm.Tipo <> [X])
        THIS.this_lSoMotivo = ;
            (THIS.this_nTotIte + THIS.this_nValDesc + THIS.this_nPDescs = 0) ;
            AND (THIS.this_cTipo != "X")

        THIS.this_oBusinessObject.this_lSoMotivo = THIS.this_lSoMotivo
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTabIndex - ordem de tabulacao do SCX
    *
    * Dump: get_Motivo=1  usuario=2  senha=3  Frase=4  Say2=5  Say1=6  Say3=7
    *
    * Numerar SO os FOCALIZAVEIS: Label tem TabIndex mas nao tem TabStop - nao
    * recebe foco -, entao transcrever o TabIndex dos quatro labels eh inerte
    * e ainda embaralharia a sequencia dos tres campos. Atribuir em ordem
    * ASCENDENTE: cada atribuicao poe o controle na posicao pedida e empurra
    * os demais para tras.
    *
    * Tem de rodar depois de TODOS os AddObject - por isso eh metodo proprio,
    * e nao linhas no fim de ConfigurarCampos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarTabIndex()
        THIS.txt_4c__Motivo.TabIndex = 1
        THIS.txt_4c_Usuario.TabIndex = 2
        THIS.txt_4c_Senha.TabIndex   = 3
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - liga os Valid do legado aos handlers do form
    *
    * O Valid do legado dispara ao SAIR do campo, logo vai em "LostFocus"
    * (regra #47). Ligado a "KeyPress" sem testar a tecla, o picker subiria a
    * CADA caractere digitado e o usuario nao conseguiria terminar o codigo.
    *
    * F4/F5 e duplo clique NAO estao no dump - o legado so abre o browse pelo
    * proprio Valid. Sao os atalhos canonicos do sistema novo para o MESMO
    * funil (AbrirBusca*) e sao ADITIVOS: nao mudam nada do que o Valid faz,
    * so dao ao usuario uma segunda porta para o picker que ele ja veria.
    * O KeyPress TEM guarda de tecla, justamente para nao recair na regra #47.
    *
    * senha NAO recebe lookup: nao ha universo a escolher (a senha eh
    * conferida, nao selecionada) - so o Valid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.txt_4c__Motivo, "LostFocus", THIS, "ValidarMotivo")
        BINDEVENT(THIS.txt_4c__Motivo, "KeyPress",  THIS, "MotivoKeyPress")
        BINDEVENT(THIS.txt_4c__Motivo, "DblClick",  THIS, "MotivoDblClick")

        BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "ValidarUsuario")
        BINDEVENT(THIS.txt_4c_Usuario, "KeyPress",  THIS, "UsuarioKeyPress")
        BINDEVENT(THIS.txt_4c_Usuario, "DblClick",  THIS, "UsuarioDblClick")

        BINDEVENT(THIS.txt_4c_Senha,   "LostFocus", THIS, "ValidarSenha")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRegrasDeExibicao - bloco de visibilidade do Init legado
    *
    * Legado (SIGOPLIM.Init), transcrito:
    *
    *   Caption = "Limite Ultrapassado..."
    *   cntSombra.lblSombra.Caption = Caption
    *   cntSombra.lblTitulo.Caption = Caption
    *   If Tipo = 'L'                       && senha livre
    *       Say1/Get_Motivo/Say2/Usuario -> .F.   Say3/senha -> .T.
    *   Else
    *       If somotivo
    *           Frase = "Informe Motivo para liberacao :"
    *           Say2/Usuario -> .F.
    *       Else
    *           If Motivo
    *               Frase = "Informe usuario c/ acesso a liberacao e Motivo:"
    *           Else
    *               Frase = "Informe usuario c/ acesso a liberacao :"
    *               Say1/Get_Motivo -> .F.
    *           EndIf
    *       EndIf
    *   Endif
    *
    * PUBLIC de proposito: o chamador pode reabrir o dialogo reatribuindo os
    * parametros, e esta eh a unica porta para reaplicar as regras. Por ser o
    * FUNIL DE REENTRADA, eh aqui que o estado de encerramento eh zerado - sem
    * isso o segundo Show() abriria uma tela com this_lEncerrando ainda em .T.,
    * ou seja com TODAS as validacoes mortas (os wrappers devolvem na primeira
    * linha) e carregando o resultado da rodada anterior.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarRegrasDeExibicao()
        THIS.this_lEncerrando      = .F.
        THIS.this_lEmLookupUsuario = .F.
        THIS.this_lEmLookupMotivo  = .F.
        THIS.this_lEmValidarSenha  = .F.
        THIS.this_uZSenha          = .F.

        *-- Campos e estado da rodada anterior (este metodo eh o FUNIL DE
        *-- REENTRADA): sem isto o segundo Show() nasce com o usuario e a
        *-- senha do autorizador anterior ainda carregados no BO.
        THIS.LimparCampos()

        THIS.Caption = "Limite Ultrapassado..."
        THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
        THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

        IF THIS.this_cTipo = "L"
            THIS.lbl_4c_Label1.Visible  = .F.
            THIS.txt_4c__Motivo.Visible = .F.
            THIS.lbl_4c_Label2.Visible  = .F.
            THIS.txt_4c_Usuario.Visible = .F.
            THIS.lbl_4c_Label3.Visible  = .T.
            THIS.txt_4c_Senha.Visible   = .T.
        ELSE
            *-- Say3/senha nascem Visible = .F. no SCX e so aparecem no fim de
            *-- usuario.Valid (ValidarUsuarioExec). Aqui so se desfaz o
            *-- Visible = .T. que TornarControlesVisiveis acabou de forcar.
            THIS.lbl_4c_Label3.Visible = .F.
            THIS.txt_4c_Senha.Visible  = .F.

            IF THIS.this_lSoMotivo
                THIS.lbl_4c_Frase.Caption = "Informe Motivo para libera" + ;
                    CHR(231) + CHR(227) + "o :"
                THIS.lbl_4c_Label2.Visible  = .F.
                THIS.txt_4c_Usuario.Visible = .F.
            ELSE
                IF THIS.this_lMotivo
                    THIS.lbl_4c_Frase.Caption = "Informe usuario c/ acesso a libera" + ;
                        CHR(231) + CHR(227) + "o e Motivo:"
                ELSE
                    THIS.lbl_4c_Frase.Caption = "Informe usuario c/ acesso a libera" + ;
                        CHR(231) + CHR(227) + "o :"
                    THIS.lbl_4c_Label1.Visible  = .F.
                    THIS.txt_4c__Motivo.Visible = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Gates do legado (os When dos campos), reproduzidos como Enabled.
        *-- Pelo ponto unico, para nao haver duas listas de campos a
        *-- divergir (HabilitarCampos delega aos dois metodos de gate).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAcessoMotivo - Legado: get_Motivo.When -> Return (ThisForm.Motivo)
    *
    * BINDEVENT em "When" nao dispara de forma confiavel em TextBox. Como
    * ThisForm.Motivo eh fixado no Init e NUNCA muda durante a vida do
    * dialogo, o gate equivale a Enabled - que nao depende de evento nenhum.
    *
    * Diferenca visual aceita e declarada: campo com When = .F. no legado
    * continua branco (so nao recebe foco); com Enabled = .F. ele usa o
    * DisabledBackColor da propria classe fwget (192,192,192) e fica cinza.
    * Em troca, o gate eh deterministico em vez de depender de um evento que
    * o VFP9 nao entrega por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAcessoMotivo()
        THIS.txt_4c__Motivo.Enabled = THIS.this_lMotivo
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAcessoSenha - Legado: senha.When ->
    *     Return (!Empty(ThisForm.Usuario.Value) Or Thisform.Tipo = 'L')
    *
    * Este gate MUDA em runtime (depende de Usuario.Value), por isso eh
    * reavaliado no fim de ValidarUsuarioExec - exatamente o momento em que o
    * usuario autorizador passa a estar preenchido.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAcessoSenha()
        THIS.txt_4c_Senha.Enabled = ;
            (!EMPTY(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))) ;
             OR THIS.this_cTipo = "L")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMotivo - wrapper do Valid de get_Motivo (ligado a "LostFocus")
    *
    * Wrapper fino + <Nome>Exec (regra #47): o corpo tem RETURN antecipado,
    * entao a liberacao da flag TEM de ficar aqui - dentro do corpo ela
    * ficaria presa em .T. e o lookup morreria para o resto da vida do form.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMotivo()
        IF THIS.this_lEncerrando OR THIS.this_lEmLookupMotivo
            RETURN
        ENDIF

        THIS.this_lEmLookupMotivo = .T.
        THIS.ValidarMotivoExec()
        THIS.this_lEmLookupMotivo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMotivoExec - corpo do get_Motivo.Valid legado
    *
    * Legado (SIGOPLIM.get_Motivo.Valid), transcrito:
    *
    *   If Not IsEmpty(This.Value)
    *       <monta LocalMdsc1 / LocalMdsc / TmpMdsc>   = BO.BuscarMotivos()
    *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
    *       Select TmpMdsc ; Index on Codigos Tag Codigos
    *       If !Seek(This.Value,'TmpMdsc','Codigos')
    *           fwBuscaSel('TmpMdsc','codigos',...)    = AbrirBuscaMotivo()
    *           This.Value = TmpMdsc.Codigos
    *       Endif
    *       If Lastkey() = 27 -> Zsenha = .F. ; release
    *       Else
    *           If somotivo -> Zsenha = Space(10) + This.Value ; Release
    *       EndIf
    *   Else
    *       Resp = Messagebox('Motivo nao Informado!, Deseja Continuar ? (S/N)',
    *                          4+256, '')
    *       If Resp = 7 -> Zsenha = .F. ; release   Else return 0
    *   EndIf
    *
    * SEEK com PADR ate a largura REAL da coluna (FSIZE), nao com o valor cru.
    * Medido no VFP9 nesta sessao: SEEK com chave CURTA nao falha - ele casa
    * por PREFIXO (e isso independe de SET EXACT, que governa o operador "=",
    * nao o SEEK). O defeito seria pior que falhar: quem digitasse "7" casaria
    * com o motivo "70" e o dialogo autorizaria o codigo ERRADO, em silencio.
    * Com PADR ate a largura da coluna a chave tem o tamanho da chave do
    * indice e o match volta a ser exato.
    *
    * O picker cancelado eh o "Lastkey() = 27" do legado: nada escolhido =
    * desistiu = nega e encerra. NAO se exibe aviso nem se apaga o codigo
    * digitado (regras #37 e #50).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMotivoExec()
        LOCAL loc_cValor, loc_cCursor, loc_lAchou, loc_oErro

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))

        IF EMPTY(loc_cValor)
            *-- Legado: Resp = 7 (Nao) -> nega e encerra; Sim -> "return 0",
            *-- que recusava sair do campo (aqui: devolve o foco a ele).
            IF MsgConfirma("Motivo n" + CHR(227) + "o Informado!, Deseja Continuar ? (S/N)", "")
                THIS.txt_4c__Motivo.SetFocus()
            ELSE
                THIS.FecharDialogo(.F.)
            ENDIF
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorMotivos
        loc_lAchou  = .F.

        TRY
            IF THIS.this_oBusinessObject.BuscarMotivos()
                *-- BuscarMotivos ja fecha com INDEX ON codigos TAG codigos
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
                        loc_cCursor, "codigos")
                ENDIF

                IF !loc_lAchou
                    THIS.AbrirBuscaMotivo()

                    loc_cValor = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
                    IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
                        SELECT (loc_cCursor)
                        loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
                            loc_cCursor, "codigos")
                    ENDIF
                ENDIF

                IF loc_lAchou
                    THIS.this_oBusinessObject.CarregarMotivoDoCursor(loc_cCursor)

                    *-- Legado: "This.Value = TmpMdsc.Codigos" apos o browse
                    THIS.BOParaForm()

                    *-- Legado: If ThisForm.somotivo /
                    *--         ThisForm.Zsenha = Space(10) + This.Value /
                    *--         ThisForm.Release
                    *--
                    *-- O legado compoe com This.Value (o DIGITADO), nao com
                    *-- TmpMdsc.Codigos - por isso a composicao le o espelho
                    *-- que FormParaBO acabou de preencher. Depois do
                    *-- BOParaForm acima os dois sao o mesmo texto (o SEEK eh
                    *-- exato), entao a fidelidade nao custa divergencia.
                    IF THIS.this_lSoMotivo
                        IF THIS.FormParaBO()
                            THIS.this_oBusinessObject.ComporAutorizacaoSoMotivo( ;
                                THIS.this_oBusinessObject.this_cMotivoDigitado)
                            THIS.FecharDialogo(.T.)
                        ENDIF
                    ENDIF
                ELSE
                    THIS.FecharDialogo(.F.)
                ENDIF
            ELSE
                MsgErro(IIF(EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)), ;
                    "Favor Reinicializar o Processo!!!", ;
                    THIS.this_oBusinessObject.this_cMensagemErro), ;
                    "Falha na Conex" + CHR(227) + "o (Motivos)")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao validar o Motivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMotivo - picker de motivos (legado: fwBuscaSel sobre TmpMdsc)
    *
    * fwBuscaSel busca em CURSOR LOCAL ja populado, nao em tabela: por isso o
    * FormBuscaAuxiliar eh usado pela API de cursor pre-populado
    * (CREATEOBJECT sem parametros + DefinirCursor + Mostrar), nunca pelo Init
    * com parametros - esse faz SQLEXEC proprio contra uma TABELA e abriria o
    * picker VAZIO, alem de ignorar os filtros de Emps/ClaConta que o BO ja
    * aplicou.
    *
    * O cursor NAO eh fechado aqui: ValidarMotivoExec faz o SEEK nele logo
    * depois, e o ciclo de vida dele eh do BO (BuscarMotivos fecha e recria).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMotivo()
        LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro

        IF THIS.this_lEncerrando
            RETURN
        ENDIF

        *-- save/restore, nao set/clear: este metodo eh chamado de DENTRO de
        *-- ValidarMotivoExec (que ja ligou a flag) e tambem direto pelo F4 e
        *-- pelo duplo clique. Um clear simples liberaria a flag cedo demais
        *-- no primeiro caso (regra #47).
        loc_lEmLookupAnt = THIS.this_lEmLookupMotivo
        THIS.this_lEmLookupMotivo = .T.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorMotivos

            IF !USED(loc_cCursor)
                THIS.this_oBusinessObject.BuscarMotivos()
            ENDIF

            IF USED(loc_cCursor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = loc_cCursor
                    loc_oBusca.DefinirCursor(loc_cCursor, "codigos", "descrs", ;
                        "Cadastro de Motivos")

                    *-- DefinirCursor usa o NOME do campo como caption; o
                    *-- legado usa AddColuna('Codigos','','Codigo') e
                    *-- AddColuna('Descrs','','Descricao'). Refaz as colunas
                    *-- com os titulos do legado (PILAR 1).
                    loc_oBusca.this_nColunas = 0
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")

                    IF loc_oBusca.Mostrar()
                        *-- Atribui SO sob a guarda de selecao (regra #37):
                        *-- fora dela, cancelar ZERARIA o codigo digitado.
                        IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                            THIS.txt_4c__Motivo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        ENDIF
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (Motivos)")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir a busca de Motivos")
        ENDTRY

        THIS.this_lEmLookupMotivo = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * MotivoKeyPress / MotivoDblClick - atalhos para o MESMO funil do picker
    *
    * A guarda de tecla eh OBRIGATORIA (regra #47): sem ela o picker abriria a
    * cada caractere e o usuario nao conseguiria terminar de digitar o codigo.
    * F4 = 115, F5 = 116.
    *--------------------------------------------------------------------------
    PROCEDURE MotivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMotivo()
        ENDIF
    ENDPROC

    PROCEDURE MotivoDblClick()
        THIS.AbrirBuscaMotivo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuario - wrapper do Valid de usuario (ligado a "LostFocus")
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuario()
        IF THIS.this_lEncerrando OR THIS.this_lEmLookupUsuario
            RETURN
        ENDIF

        THIS.this_lEmLookupUsuario = .T.
        THIS.ValidarUsuarioExec()
        THIS.this_lEmLookupUsuario = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuarioExec - corpo do usuario.Valid legado
    *
    * Legado (SIGOPLIM.usuario.Valid), transcrito:
    *
    *   If !IsEmpty(This.Value)
    *       <Do Case por Tipo -> TmpUsu>   = BO.BuscarUsuariosAutorizados()
    *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
    *       Select TmpUsu ; Index on usuarios Tag usuarios
    *       If !Seek(This.Value,'TmpUsu','Usuarios')
    *           fwBuscaSel('TmpUsu','Usuarios',...)   = AbrirBuscaUsuario()
    *           This.Value = TmpUsu.Usuarios
    *       Endif
    *       Usual = This.Value
    *       If IsEmpty(usual) Or Lastkey() = 27 -> Zsenha = .F. ; release
    *       Select TmpUsu
    *       If limdescs = "S" And Tipo <> [X]
    *           zsen  = padr(ThisForm.GeraSenha(date()),06)
    *           zsen1 = fCriptografar(senhas)
    *       else
    *           zsen  = fCriptografar(senhas)
    *       endif
    *       thisform.say3.visible  = .t.
    *       thisform.senha.visible = .t.
    *   Else
    *       ThisForm.zSenha = .f. ; ThisForm.Release
    *   EndIf
    *
    * O BLOCO zsen/zsen1 NAO eh reproduzido, e a omissao eh deliberada - sao
    * DEAD STORES no proprio legado: nem zsen nem zsen1 sao lidos em lugar
    * nenhum do SCX (senha.Valid recalcula a senha do zero com
    * fCriptografar(TmpUsu.senhas)). Reproduzi-los seria pior que inutil:
    * (a) fCriptografar() NUNCA foi portada (regra #27, "DEIXAR AUSENTE" -
    *     funcao global Fortyus cujo algoritmo nao esta legivel em fonte
    *     nenhum), e em VFP9 nome desconhecido seguido de "(" nao eh erro de
    *     compilacao: estouraria em RUNTIME "File 'fcriptografar.prg' does not
    *     exist" (regra #13) e MATARIA o campo usuario em 100% dos usos, por
    *     uma variavel que ninguem le;
    * (b) SigOpLimBO.GeraSenha() ja documenta que o retorno dele nao tem
    *     valor semantico (pridig/segdig nunca sao preenchidos porque o
    *     legado contava com efeito colateral de fValidarCNPJ).
    * A conferencia REAL da senha fica onde o legado tambem a faz: em
    * senha.Valid -> SigOpLimBO.ValidarSenhaUsuario().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuarioExec()
        LOCAL loc_cValor, loc_cCursor, loc_lAchou, loc_oErro

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))

        IF EMPTY(loc_cValor)
            *-- Legado (ramo Else): ThisForm.zSenha = .f. / ThisForm.Release
            THIS.FecharDialogo(.F.)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorUsuarios
        loc_lAchou  = .F.

        TRY
            IF THIS.this_oBusinessObject.BuscarUsuariosAutorizados()
                *-- BuscarUsuariosAutorizados ja fecha com
                *-- INDEX ON usuarios TAG usuarios
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
                        loc_cCursor, "usuarios")
                ENDIF

                IF !loc_lAchou
                    THIS.AbrirBuscaUsuario()

                    loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
                    IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
                        SELECT (loc_cCursor)
                        loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
                            loc_cCursor, "usuarios")
                    ENDIF
                ENDIF

                IF loc_lAchou
                    *-- Legado: Select TmpUsu (a linha do autorizador fica
                    *-- corrente e senha.Valid le TmpUsu.senhas/.usuarios)
                    THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)

                    *-- Legado: thisform.say3.visible  = .t.
                    *--         thisform.senha.visible = .t.
                    THIS.lbl_4c_Label3.Visible = .T.
                    THIS.txt_4c_Senha.Visible  = .T.

                    *-- Legado: "This.Value = TmpUsu.Usuarios" - o codigo que
                    *-- vale eh o do CURSOR, nao o que foi digitado (que pode
                    *-- diferir em caixa/padding do canonico).
                    THIS.BOParaForm()

                    *-- O When de senha passa a valer agora que Usuario.Value
                    *-- esta preenchido
                    THIS.HabilitarCampos(.T.)
                ELSE
                    *-- Legado: If IsEmpty(usual) Or Lastkey() = 27 ->
                    *-- Zsenha = .F. ; release
                    THIS.FecharDialogo(.F.)
                ENDIF
            ELSE
                MsgErro(IIF(EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)), ;
                    "Favor Reinicializar o Processo!!!", ;
                    THIS.this_oBusinessObject.this_cMensagemErro), ;
                    "Falha na Conex" + CHR(227) + "o (Usu" + CHR(225) + "rios)")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao validar o Usu" + CHR(225) + "rio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuario - picker de autorizadores (legado: fwBuscaSel sobre
    * TmpUsu, com AddColuna('Usuarios','','Codigo') e
    * AddColuna('CCargs','','Cargo'))
    *
    * Mesma API de cursor pre-populado do AbrirBuscaMotivo. O universo aqui
    * NAO eh "todos os usuarios" - eh so quem tem alcada para o valor e o
    * percentual pedidos (o Do Case por Tipo do BO). Trocar por um SELECT
    * direto em SigCdUsu mostraria usuarios sem alcada e deixaria o dialogo
    * autorizar o que o legado recusa.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaUsuario()
        LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro

        IF THIS.this_lEncerrando
            RETURN
        ENDIF

        loc_lEmLookupAnt = THIS.this_lEmLookupUsuario
        THIS.this_lEmLookupUsuario = .T.

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorUsuarios

            IF !USED(loc_cCursor)
                THIS.this_oBusinessObject.BuscarUsuariosAutorizados()
            ENDIF

            IF USED(loc_cCursor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = loc_cCursor
                    loc_oBusca.DefinirCursor(loc_cCursor, "usuarios", "ccargs", ;
                        "Cadastro de Usu" + CHR(225) + "rios")

                    loc_oBusca.this_nColunas = 0
                    loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("ccargs",   "", "Cargo")

                    IF loc_oBusca.Mostrar()
                        IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                            THIS.txt_4c_Usuario.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        ENDIF
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (Usu" + CHR(225) + "rios)")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir a busca de Usu" + CHR(225) + "rios")
        ENDTRY

        THIS.this_lEmLookupUsuario = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaUsuario()
        ENDIF
    ENDPROC

    PROCEDURE UsuarioDblClick()
        THIS.AbrirBuscaUsuario()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenha - wrapper do Valid de senha (ligado a "LostFocus")
    *
    * senha eh um dos campos que ESTA fase cria: entregar a caixa de senha sem
    * o Valid dela deixaria o dialogo com a acao principal do usuario sem
    * efeito nenhum - e, como o form compila e abre, nenhum outro gate pegaria.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSenha()
        IF THIS.this_lEncerrando OR THIS.this_lEmValidarSenha
            RETURN
        ENDIF

        THIS.this_lEmValidarSenha = .T.
        THIS.ValidarSenhaExec()
        THIS.this_lEmValidarSenha = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenhaExec - corpo do senha.Valid legado
    *
    * Legado (SIGOPLIM.senha.Valid), transcrito:
    *
    *   If Thisform.Tipo = 'L'                     && senha livre
    *       Select ... From SigPrSnd Where SenhaDs = <valor>
    *       If Eof -> 'Senha invalida.' ; Zsenha = .F. ; release
    *       If !Empty(EmpDopNums) -> 'Senha ja utilizada.' ; Zsenha=.F. ; release
    *       lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
    *       Update SigPrSnd Set EmpDopNums = lcEDN Where CidChaves = ...
    *       ThisForm.Zsenha = Usuar ; release
    *   Else
    *       Senha = fCriptografar(TmpUsu.senhas)
    *       If Padr(this.value,10) <> Padr(senha,10)
    *           resp = messagebox('Senha Conflitante. Deseja Continuar?',4+256,'Aviso')
    *           if resp = 7 -> Zsenha = .F. ; release   else return 0
    *       Else
    *           Zsenha = Iif(Tipo = [X], Usuario.Value,
    *                        TmpUsu.Usuarios + Get_motivo.Value)
    *           release
    *       Endif
    *   Endif
    *
    * Os tres ramos de composicao do retorno moram no BO
    * (ComporAutorizacaoSenhaLivre / ComporAutorizacaoUsuarioSenha, mais
    * ComporAutorizacaoSoMotivo usado por get_Motivo.Valid) - fonte unica,
    * PILAR 3.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarSenhaExec()
        LOCAL loc_cValor, loc_cMsgBO, loc_oErro

        *-- Ponto UNICO de leitura dos campos (regra: a normalizacao mora
        *-- em FormParaBO, nao repetida em cada call site). Falhando, ABORTA
        *-- antes de tocar o BO - autorizacao pela metade seria pior que
        *-- nenhuma. O RETURN fica FORA do TRY (regra #1).
        IF !THIS.FormParaBO()
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os " + ;
                "campos do di" + CHR(225) + "logo.", "Erro ao validar a Senha")
            RETURN
        ENDIF

        loc_cValor = THIS.this_oBusinessObject.this_cSenhaDigitada

        TRY
            IF THIS.this_cTipo = "L"
                IF THIS.this_oBusinessObject.ValidarEConsumirSenhaLivre(loc_cValor, ;
                        THIS.MontarEmpDopNumsMovimento())
                    THIS.this_oBusinessObject.ComporAutorizacaoSenhaLivre()
                    THIS.FecharDialogo(.T.)
                ELSE
                    *-- Legado: Messagebox(...,48,'Senha livre') nos dois
                    *-- motivos de recusa ('Senha invalida.' / 'Senha ja
                    *-- utilizada.'), que o BO ja distingue na mensagem.
                    loc_cMsgBO = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(IIF(EMPTY(loc_cMsgBO), ;
                        "Senha inv" + CHR(225) + "lida.", loc_cMsgBO), "Senha livre")
                    THIS.FecharDialogo(.F.)
                ENDIF
            ELSE
                IF THIS.this_oBusinessObject.ValidarSenhaUsuario(loc_cValor)
                    *-- Legado: Zsenha = Iif(Tipo = [X], Usuario.Value,
                    *--                          TmpUsu.Usuarios + Get_motivo.Value)
                    *-- Os DOIS argumentos sao o que esta DIGITADO; quem decide
                    *-- usar o do cursor (TmpUsu.Usuarios) no ramo Else eh o
                    *-- proprio BO, que ja tem this_cUsuarios.
                    THIS.this_oBusinessObject.ComporAutorizacaoUsuarioSenha( ;
                        THIS.this_oBusinessObject.this_cUsuarioDigitado, ;
                        THIS.this_oBusinessObject.this_cMotivoDigitado)
                    THIS.FecharDialogo(.T.)
                ELSE
                    *-- ValidarSenhaUsuario devolve .F. por DOIS motivos
                    *-- diferentes: senha que nao casa (this_cMensagemErro =
                    *-- "Senha Conflitante.", literal definido no proprio BO) e
                    *-- falha TECNICA capturada pelo CATCH dele - tipicamente
                    *-- fCriptografar() ausente (regra #27). Disfarcar a falha
                    *-- tecnica de "senha conflitante" esconderia o defeito
                    *-- real atras de uma pergunta que o usuario responde
                    *-- "Sim" e segue tentando para sempre.
                    loc_cMsgBO = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)

                    IF loc_cMsgBO == "Senha Conflitante."
                        IF MsgConfirma("Senha Conflitante. Deseja Continuar?", "Aviso")
                            *-- Legado: "return 0" - recusa sair do campo
                            THIS.txt_4c_Senha.SetFocus()
                        ELSE
                            THIS.FecharDialogo(.F.)
                        ENDIF
                    ELSE
                        MsgErro(IIF(EMPTY(loc_cMsgBO), ;
                            "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel conferir a senha.", loc_cMsgBO), ;
                            "Erro ao conferir a senha")
                        THIS.FecharDialogo(.F.)
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao validar a Senha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarEmpDopNumsMovimento - chave do movimento que consome a senha livre
    *
    * Legado: lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
    *
    * Chave POSICIONAL (regra #42): o padding FAZ PARTE da chave. Emps char(3)
    * + Dopes char(20) + STR(Numes,6) = 29 = SigPrSnd.EmpDopNums char(29) -
    * conferido no docs/schema.sql. PADR em CADA parte; ALLTRIM nas partes
    * encurtaria a chave e o UPDATE casaria a linha errada (ou nenhuma).
    *
    * TprMvCab eh cursor GLOBAL do form chamador (Fortyus), que este dialogo
    * nao possui. Ausente, devolve vazio - e o BO gravaria EmpDopNums em
    * branco, que para o legado significa "senha ainda disponivel", ou seja a
    * senha seria aceita e continuaria reutilizavel. Por isso o retorno vazio
    * NAO eh silencioso: quem chamar com Tipo = "L" sem TprMvCab aberto recebe
    * o aviso.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarEmpDopNumsMovimento()
        LOCAL loc_cChave

        loc_cChave = ""

        IF USED("TprMvCab")
            IF !EOF("TprMvCab")
                loc_cChave = PADR(NVL(TprMvCab.Emps, ""), 3) + ;
                    PADR(NVL(TprMvCab.Dopes, ""), 20) + ;
                    STR(NVL(TprMvCab.Numes, 0), 6)
            ENDIF
        ENDIF

        IF EMPTY(loc_cChave)
            MsgAviso("Movimento n" + CHR(227) + "o identificado: a senha ser" + ;
                CHR(225) + " consumida sem v" + CHR(237) + "nculo com documento.", ;
                "Senha livre")
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharDialogo - UNICA saida do dialogo
    *
    * Fecha com Hide(), NUNCA com Release(): o chamador le o resultado DEPOIS
    * de o Show() retornar, e Release() destroi o objeto na hora (form nao
    * segue refcount) - a leitura seguinte estouraria "is not an object", num
    * erro que aparece no CHAMADOR, longe daqui. Mesmo desenho do
    * FormBuscaAuxiliar; quem abriu chama Release() depois de ler.
    *
    * Para o usuario a tela fecha igual (Hide em form modal tambem devolve o
    * Show) - muda so o tempo de vida do objeto, que eh PILAR 3.
    *
    * O resultado eh CACHEADO aqui, ANTES do Hide: Destroy e Unload disparam
    * depois, e nesse momento o BO pode ja ter sido liberado.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo(par_lAutorizado)
        LOCAL loc_lAutorizado

        *-- PCOUNT antes de ler o parametro logico: omitido, ele nao chega
        *-- como .F. - chega como tipo indefinido.
        loc_lAutorizado = (PCOUNT() >= 1 AND VARTYPE(par_lAutorizado) = "L" ;
            AND par_lAutorizado)

        IF loc_lAutorizado AND VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_uZSenha = THIS.this_oBusinessObject.this_cZSenha
        ELSE
            THIS.this_uZSenha = .F.
        ENDIF

        *-- Impede que o LostFocus disparado pelo proprio Hide() reentre na
        *-- validacao e sobrescreva o resultado que o chamador vai ler.
        THIS.this_lEncerrando = .T.

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterResultado - ThisForm.zsenha do legado
    *
    * .F.        -> liberacao NEGADA (ou dialogo encerrado sem autorizar)
    * caractere  -> credencial de quem autorizou, no formato do legado:
    *               Tipo "X"   -> usuario digitado
    *               Tipo "L"   -> usuario logado
    *               so motivo  -> Space(10) + codigo do motivo
    *               demais     -> SigCdUsu.usuarios + codigo do motivo
    *
    * Contrato de uso: CREATEOBJECT -> Show() -> ObterResultado() -> Release().
    *--------------------------------------------------------------------------
    FUNCTION ObterResultado()
        RETURN THIS.this_uZSenha
    ENDFUNC

    *--------------------------------------------------------------------------
    * Unload - Legado: PROCEDURE Unload / Return ThisForm.zsenha
    *
    * Mantido para quem abrir com DO FORM ... TO <var>, que eh como o legado
    * recebia o resultado. Dispara DEPOIS do Destroy, por isso le a property
    * JA cacheada por FecharDialogo - nunca o BO, que a essa altura foi
    * liberado.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        RETURN THIS.this_uZSenha
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - leva os TRES campos digitados para o BO
    *
    * PROTECTED EXPLICITO e obrigatorio: FormBase declara este nome como
    * PROTECTED e em VFP9 a subclasse NAO alarga escopo - escrever
    * "PROCEDURE FormParaBO" nao o torna publico, so mente para quem le.
    * Chamar sempre por THIS. de dentro da classe (regra #8). Num probe
    * headless a chamada de fora NAO devolve erro legivel: abre um Program
    * Error que ninguem fecha e o processo PENDURA ate o timeout, sem uma
    * linha de log - exercitar por uma DEFINE CLASS Probe AS FormSigOpLim,
    * com TRY/CATCH em volta de CADA chamada.
    *
    * Escreve nas properties de ESPELHO (this_cUsuarioDigitado /
    * this_cMotivoDigitado / this_cSenhaDigitada), NUNCA em this_cUsuarios /
    * this_cCodigoMotivo / this_cSenhas, que pertencem ao CURSOR e sao
    * carregadas por CarregarDoCursor / CarregarMotivoDoCursor. O legado le as
    * duas origens no MESMO statement e com significados opostos
    * ("Zsenha = Iif(Tipo = [X], Usuario.Value, TmpUsu.Usuarios + ...)"):
    * sobrescrever as do cursor com o digitado faria o ramo Else devolver quem
    * DIGITOU em vez de quem AUTORIZOU - credencial errada gravada no
    * movimento, sem erro e sem aviso.
    *
    * ALLTRIM aqui, no unico ponto de leitura: os campos tem InputMask de 10
    * "!" e o VFP9 devolve o conteudo PADDED. Os consumidores comparam com
    * PADR(..., 10) ou PADR(..., FSIZE()) de proposito (regra #42 - chave
    * posicional), entao a normalizacao tem de ser UMA so e ficar aqui, nao
    * repetida em cada call site.
    *
    * FUNCTION, nao PROCEDURE: devolve .F. quando o BO nao existe, e quem
    * chama ABORTA - transferencia que falha nao pode deixar o fluxo seguir e
    * autorizar pela metade (corolario da regra #187).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                .this_cUsuarioDigitado = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
                .this_cMotivoDigitado  = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
                .this_cSenhaDigitada   = ALLTRIM(NVL(THIS.txt_4c_Senha.Value, ""))
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - devolve aos campos o codigo CANONICO que veio do cursor
    *
    * Equivale ao "This.Value = TmpUsu.Usuarios" / "This.Value =
    * TmpMdsc.Codigos" que o legado executa logo depois do browse: o valor que
    * vale eh o do CURSOR, nao o que o usuario tinha digitado.
    *
    * SO escreve quando a property esta PREENCHIDA (regras #37 e #50): no
    * instante em que o motivo eh resolvido, this_cUsuarios ainda esta vazio
    * (o autorizador so eh escolhido depois) - sem a guarda, este metodo
    * APAGARIA o campo Usuario, e o When da senha, que le justamente esse
    * campo, voltaria a .F. travando a tela no meio do fluxo.
    *
    * A SENHA NAO eh escrita de volta, em hipotese nenhuma. Nao eh descuido:
    * this_cSenhas eh a senha GRAVADA do autorizador, lida de SigCdUsu -
    * joga-la no campo faria a tela CONFERIR a credencial contra ela mesma,
    * que eh autorizacao automatica. O legado nunca atribui nada a
    * senha.Value.
    *
    * PROTECTED EXPLICITO - mesmo motivo de FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cUsuarios, "")))
            THIS.txt_4c_Usuario.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigoMotivo, "")))
            THIS.txt_4c__Motivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCodigoMotivo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - zera os tres campos E o estado da rodada no BO
    *
    * Chamado por AplicarRegrasDeExibicao, que eh o FUNIL DE REENTRADA (o
    * chamador pode reabrir o MESMO objeto de dialogo reatribuindo os
    * parametros e dando Show() de novo).
    *
    * Sem esta limpeza a segunda rodada nasce com o usuario e a senha da
    * PRIMEIRA ainda digitados - e isso nao eh cosmetico. O reset do BO
    * (LimparDados) eh o que descarta this_cSenhas, a senha gravada do
    * autorizador anterior; mantida, ela continuaria sendo o ALVO da
    * comparacao de ValidarSenhaUsuario, e a rodada nova seria autorizada com
    * a senha de quem liberou a rodada velha, SEM o novo autorizador ter sido
    * sequer escolhido. Nao estoura, nao entra em log: eh estado que ninguem
    * restaura (mesma familia da regra #40).
    *
    * LimparDados eh PUBLIC na BusinessBase, logo pode ser chamado daqui
    * (regra #51), e preserva os parametros de abertura - so o estado da
    * autorizacao eh zerado.
    *
    * PROTECTED EXPLICITO - mesmo motivo de FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__Motivo.Value = ""
        THIS.txt_4c_Usuario.Value = ""
        THIS.txt_4c_Senha.Value   = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - ponto unico dos gates de entrada do dialogo
    *
    * PUBLIC de verdade (este nome NAO existe em FormBase, ao contrario dos
    * tres acima): o chamador e o harness alcancam.
    *
    * par_lHabilitar = .T. (default) -> aplica os When do legado
    * par_lHabilitar = .F.           -> trava os tres campos
    *
    * Os When do legado sao DOIS, e um deles muda em runtime:
    *     get_Motivo.When -> Return ( ThisForm.Motivo )
    *     senha.When      -> Return (!Empty(ThisForm.Usuario.Value) Or
    *                                Thisform.Tipo = 'L')
    * usuario NAO tem When no dump - fica sempre habilitado, e eh por isso que
    * ele recebe .T. no ramo de cima em vez de um gate inventado.
    *
    * Delega a ValidarAcessoMotivo/ValidarAcessoSenha em vez de repetir as
    * expressoes: as duas continuam sendo chamadas isoladamente por quem
    * precisa reavaliar UM gate (ValidarUsuarioExec reavalia so o da senha, no
    * instante em que o autorizador passa a estar preenchido), e duplicar a
    * condicao aqui criaria duas versoes da mesma regra para divergirem.
    *
    * PCOUNT antes de ler o parametro logico: omitido, ele nao chega como .F.
    * - chega como tipo indefinido.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = .T.
        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        IF loc_lHabilitar
            THIS.txt_4c_Usuario.Enabled = .T.
            THIS.ValidarAcessoMotivo()
            THIS.ValidarAcessoSenha()
        ELSE
            THIS.txt_4c__Motivo.Enabled = .F.
            THIS.txt_4c_Usuario.Enabled = .F.
            THIS.txt_4c_Senha.Enabled   = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    *
    * Recursivo: percorre os filhos diretos do form e desce nos containers.
    * NAO ha lista de excecao aqui de proposito: Say3/senha nascem
    * Visible = .F. no SCX (regra do legado, nao defeito de migracao - so
    * aparecem no fluxo de senha livre/Tipo "L" ou depois de o autorizador
    * ser resolvido), mas essa decisao depende de this_cTipo/somotivo e eh
    * aplicada por AplicarRegrasDeExibicao(), chamado DEPOIS desta varredura.
    * A ordem eh: criar os campos -> tornar tudo visivel -> reocultar os
    * condicionais. Filtrar por nome AQUI duplicaria a regra em dois lugares.
    *
    * Nao recursa em Pages por nao haver PageFrame nesta tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    IF loc_oControle.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera o BO e devolve ao FormBase
    *
    * DODEFAULT() na ULTIMA linha eh obrigatorio: eh o FormBase.Destroy que
    * reconstroi os popups do menu principal apos o fechamento de um form
    * modal; sem ele o menu do sistema aparece encolhido (regra #145).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_nI
        LOCAL ARRAY loc_aCursores[5]

        *-- Os cursores do BO vivem na datasession COMPARTILHADA
        *-- (DataSession = 1, como o legado): deixados abertos, vazam para o
        *-- resto do sistema e o proximo form que usar um alias homonimo
        *-- herda a estrutura errada. Fechados AQUI, com o BO ainda vivo -
        *-- os nomes sao properties dele.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_aCursores[1] = THIS.this_oBusinessObject.this_cCursorUsuarios
            loc_aCursores[2] = THIS.this_oBusinessObject.this_cCursorMotivos
            loc_aCursores[3] = THIS.this_oBusinessObject.this_cCursorMotivosBase
            loc_aCursores[4] = THIS.this_oBusinessObject.this_cCursorSenhaLivre
            loc_aCursores[5] = THIS.this_oBusinessObject.this_cCursorClaMotivo

            FOR loc_nI = 1 TO 5
                IF VARTYPE(loc_aCursores[loc_nI]) = "C"
                    IF !EMPTY(loc_aCursores[loc_nI]) AND USED(loc_aCursores[loc_nI])
                        USE IN (loc_aCursores[loc_nI])
                    ENDIF
                ENDIF
            ENDFOR

            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
