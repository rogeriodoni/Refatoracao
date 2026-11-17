*==============================================================================
* Formsigopsen.prg - Dialogo de Senha de Autorizacao
*
* Legado  : sigopsen.SCX (form OPERACIONAL, modal, WindowType = 1, 400x180)
* Herda de: FormBase
* BO      : sigopsenBO (classes\sigopsenBO.prg)
*
* Tipo de layout: FLAT (OPERACIONAL)
*   A arvore de objetos do SCX legado tem a raiz num "form" GENERICO (nao
*   frmcadastro, nao frmrelatorio) e NAO declara nenhuma Page: os nove objetos
*   (cntSombra com lblSombra/lblTitulo, Frase, Say2, usuario, Say3, senha e
*   Image1) penduram direto na Form. Nao existe, portanto, pagina de Lista nem
*   pagina de Dados a reproduzir - criar essa estrutura aqui seria inventar
*   superficie que o legado nao tem (viola o PILAR 1). O layout eh transcrito
*   objeto a objeto, com as coordenadas absolutas do dump e SEM a compensacao
*   de -29 usada nos forms de cadastro.
*
* Funcao da tela:
*   Dialogo MODAL de AUTORIZACAO ("senha de supervisor"). O chamador informa um
*   TIPO de liberacao; a tela exibe o texto correspondente, pede usuario e
*   senha e devolve se a operacao foi autorizada. O tipo determina (a) o titulo
*   e a frase exibidos, (b) qual permissao de cargo/usuario sera exigida na
*   consulta de usuarios e (c) se a senha conferida eh a senha CADASTRADA do
*   usuario ou a SENHA DO DIA calculada a partir do documento.
*
*   Por ser gate de AUTORIZACAO, o estado inicial eh sempre "NAO autorizado"
*   (this_lZSen = .F.): falha de qualquer natureza deixa a tela FAIL-CLOSED.
*
* Correspondencia legado -> migrado (objetos; ver tasks\task799\mapeamento.json)
*   SIGOPSEN                     -> Formsigopsen
*   SIGOPSEN.cntSombra           -> cnt_4c_Sombra                   (Fase 3)
*   SIGOPSEN.cntSombra.lblSombra -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
*   SIGOPSEN.cntSombra.lblTitulo -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
*   SIGOPSEN.Frase               -> lbl_4c_Frase
*   SIGOPSEN.Say2                -> lbl_4c_Label2
*   SIGOPSEN.usuario             -> txt_4c_Usuario
*   SIGOPSEN.Say3                -> lbl_4c_Label3
*   SIGOPSEN.senha               -> txt_4c_Senha
*   SIGOPSEN.Image1              -> img_4c_Image1
*
*   ORDEM DE CRIACAO (importa, e o SCX legado ja a estabelece): a faixa cinza
*   cnt_4c_Sombra eh o PRIMEIRO AddObject da tela. O lbl_4c_Frase do legado
*   fica em Top = 46..80, isto eh, DENTRO da area da faixa (0..80), e tem
*   ForeColor branco justamente porque desenha POR CIMA do cinza - ele eh filho
*   da Form, nao do container, e no SCX eh criado depois da faixa. Todo
*   controle acrescentado a esta tela entra DEPOIS de ConfigurarCabecalho.
*
* Correspondencia legado -> migrado (comportamento)
*   SIGOPSEN.Init  (Lparameters pTip, pTi1, pTi2, pDoc, pDat, pEmp, pFpg, pVal)
*     CreateObject([fSqlConector]) + teste pnIdconn > 0
*                                       -> THIS.ValidarParametros()
*     normalizacao Type([pDoc]) <> [N] ...
*                                       -> THIS.Init() (bloco PCOUNT/VARTYPE)
*     zera as 21 flags + .UsuLibs = Usuar
*                                       -> sigopsenBO.Init() + THIS.ConfigurarParametrosBO()
*     2 CursorQuery (SigCdPam/SigCdPac)  -> THIS.CarregarParametrosSistema()
*     Do Case pTip ... (25 ramos)        -> THIS.ConfigurarPorTipo()
*     .cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption
*                                       -> THIS.ConfigurarCabecalho()
*     If (crParam.LiblCreds And ...)     -> THIS.AvaliarSenhaDoDia()
*   SIGOPSEN.usuario.When     -> THIS.UsuarioEditavel() (via .Enabled)
*   SIGOPSEN.usuario.Valid    -> THIS.UsuarioLostFocus/UsuarioLostFocusExec
*   SIGOPSEN.usuario.KeyPress -> THIS.UsuarioKeyPress
*   SIGOPSEN.senha.Valid      -> THIS.SenhaLostFocus/SenhaLostFocusExec
*     (consultas, senha livre, senha cadastrada x senha do dia e log ficam
*      no BO, em sigopsenBO.ConferirSenha(); aqui ficam so as decisoes de
*      TELA: o dialogo "Deseja digitar novamente ?", o foco de volta no
*      campo e o fechamento publicando o resultado)
*   SIGOPSEN.Unload (Return Iif(This.ZSen,[*],[ ]) + This.UsuLibs)
*                                       -> THIS.MontarRetorno() / this_cRetorno
*   SIGOPSEN.Release (poDataMgr.Release + DoDefault)
*                                       -> THIS.FecharDialogo() + THIS.Destroy()
*
*   O valor de retorno do legado chega ao chamador por "DO FORM ... TO var",
*   que depende do Unload. O sistema novo abre o dialogo com CREATEOBJECT, e
*   nesse caminho o Unload NAO alimenta variavel nenhuma - por isso a resposta
*   eh publicada na property this_cRetorno (montada por MontarRetorno com a
*   MESMA expressao do legado) e lida pelo chamador depois do Show().
*
* Uso (o dialogo DEVOLVE resultado, por isso o chamador eh quem libera):
*   loForm = CREATEOBJECT("Formsigopsen", "LIMITE", lcConta, "", 0, DATE())
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()                      && modal: retorna quando a tela fecha
*       IF loForm.this_lZSen               && autorizado?
*           lcUsuLib = loForm.this_cUsuLibs
*       ENDIF
*   ENDIF
*==============================================================================

DEFINE CLASS Formsigopsen AS FormBase

    *==========================================================================
    * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
    *
    *   DataSession = 1 / BorderStyle = 2 / Height = 180 / Width = 400
    *   AutoCenter = .T. / Caption = "" / ControlBox = .F. / TitleBar = 0
    *   WindowType = 1 / BackColor = 255,255,255 / Themes = .F.
    *   Picture = ..\framework\imagens\new_background.jpg
    *
    * DataSession = 1 eh a sessao CORRENTE (compartilhada): esta tela le o
    * cursor do movimento aberto pelo form CHAMADOR (TprMvCab) e por isso NAO
    * pode ter datasession privada - o dump declara 1, e a transcricao literal
    * eh tambem o que faz a tela funcionar.
    *
    * MaxButton / MinButton / Closable NAO sao declarados aqui porque o dump
    * tambem nao os declara: com TitleBar = 0 nao ha barra onde eles aparecam,
    * e inventar Closable = .F. so tiraria uma saida que o legado mantem.
    *
    * BackColor e Picture ficam em ConfigurarAparencia: o primeiro porque RGB()
    * eh funcao e nao pode aparecer em inicializador de propriedade de DEFINE
    * CLASS, e o segundo porque depende da global gc_4c_CaminhoIcones.
    *==========================================================================
    this_cMensagemErro = ""
    DataSession = 1
    ShowWindow = 1
    Width       = 400
    Height      = 180
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = ""
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1
    Themes      = .F.

    *==========================================================================
    * Entrada recebida do chamador
    *
    * Legado: Lparameters pTip, pTi1, pTi2, pDoc, pDat, pEmp, pFpg, pVal
    *   pTip - TIPO da liberacao (CUSTOPROD, LIMITE, CANCITEM, ...) - define
    *          titulo, frase, flag de permissao e forma de conferir a senha
    *   pTi1 - 1o texto variavel do dialogo. POLIMORFICO no legado: em 24 dos
    *          25 ramos do Do Case entra como TEXTO (Alltrim(pTi1)), mas no
    *          ramo CHDEVOLVIDO entra como CONTAGEM (pTi1 = 1 / Str(pTi1)).
    *          Por isso ele eh guardado nas DUAS formas, com
    *          this_lTituloNumerico registrando como o chamador o enviou -
    *          converter sempre para texto perderia o teste "= 1" do ramo do
    *          cheque devolvido.
    *   pTi2 - 2o texto variavel do dialogo
    *   pDoc - numero do documento (base da senha do dia)
    *   pDat - data do documento (base da senha do dia)
    *   pEmp - empresa (SigCdEmp.Cemps)
    *   pFpg - forma de pagamento (SigOpFp.Fpags)
    *   pVal - valor da forma de pagamento
    *
    * O objeto de conexao do framework Fortyus (poDataMgr) NAO vira property:
    * no sistema novo a conexao eh a global gnConnHandle.
    *==========================================================================
    this_cTipo           = ""
    this_cTitulo         = ""
    this_nTitulo         = 0
    this_lTituloNumerico = .F.
    this_cTitulo2        = ""
    this_nNroDoc         = 0
    this_dDatDoc         = {}
    this_cEmpresa        = ""
    this_cFpagto         = ""
    this_nValFpag        = 0

    *==========================================================================
    * Estado e resultado do dialogo
    *
    * this_lZSen    - "zsen" do legado: .T. SOMENTE quando a senha foi
    *                 conferida com sucesso. Nasce .F. (gate FAIL-CLOSED) e eh
    *                 o que o chamador le para saber se liberou.
    * this_cUsuLibs - "usulibs" do legado: usuario que concedeu a liberacao
    *                 (ou, no caminho de senha do dia, a senha gerada).
    * this_cRetorno - string devolvida ao chamador, montada por MontarRetorno()
    *                 com a expressao do Unload legado.
    * this_cFrase   - texto do segundo rotulo da tela (Frase do legado),
    *                 resolvido por ConfigurarPorTipo() a partir do tipo.
    * this_lSenhaDoDia - .T. quando o dialogo passa a pedir a SENHA DO DIA em
    *                 vez da senha cadastrada (bloco final do Init legado).
    * this_lParametrosCarregados - .T. apos SigCdPam/SigCdPac serem lidos.
    *==========================================================================
    this_lZSen                 = .F.
    this_cUsuLibs              = ""
    this_cRetorno              = ""
    this_cFrase                = ""
    this_lSenhaDoDia           = .F.
    this_lParametrosCarregados = .F.

    *==========================================================================
    * Controle do lookup do campo usuario
    *
    * this_lEmLookupUsuario - guarda de REENTRANCIA. O picker eh MODAL: ao
    *     abrir ele tira o foco do campo, o que faz o proprio LostFocus
    *     disparar de novo e empilharia um segundo dialogo (regra #37).
    *
    * this_cUltimoUsuarioValidado - ultimo valor ja resolvido. O legado
    *     valida no Valid; aqui a validacao mora no LostFocus (regra #47),
    *     que dispara SEMPRE que o campo perde o foco - sem este guard,
    *     apenas tabular pelo campo reabriria o picker a cada passagem. O
    *     valor inicial eh um SENTINELA mais longo que os 10 caracteres de
    *     SigCdUsu.usuarios, para que nenhum valor digitavel possa casar com
    *     ele (string vazia casaria com o campo vazio e mataria o caminho de
    *     saida do dialogo, que eh justamente "usuario em branco").
    *
    * this_lDialogoEncerrado - a tela ja se fechou (gate resolvido ou
    *     recusado). Depois do Hide() o campo ainda pode disparar LostFocus;
    *     sem esta flag a validacao rodaria uma segunda vez sobre um dialogo
    *     que ja devolveu resposta ao chamador.
    *==========================================================================
    this_lEmLookupUsuario       = .F.
    this_cUltimoUsuarioValidado = "@@SEM VALIDACAO@@"
    this_lDialogoEncerrado      = .F.

    *==========================================================================
    * Controle da conferencia da senha (Fase 8)
    *
    * this_lEmValidacaoSenha - guarda de REENTRANCIA do mesmo tipo da do
    *     campo usuario. A conferencia pode exibir o dialogo "Deseja digitar
    *     novamente ?", que eh MODAL: ele tira o foco do campo senha e faz o
    *     proprio LostFocus disparar de novo, encadeando uma segunda
    *     conferencia sobre a mesma senha (regra #37). A flag eh liberada por
    *     um wrapper fino, porque o corpo tem RETURN antecipado (regra #47).
    *
    * this_cUltimaSenhaValidada - ultima senha JA conferida. O legado valida
    *     no Valid; aqui a validacao mora no LostFocus (regra #47), que
    *     dispara em TODA perda de foco - sem este guard, so tabular pelo
    *     campo reconferiria a senha e o usuario levaria o dialogo de
    *     conflito de novo sem ter digitado nada. O sentinela eh mais longo
    *     que os 10 caracteres de SigCdUsu.senhas para que nenhum valor
    *     digitavel possa casar com ele (string vazia casaria com o campo
    *     vazio, que eh um caminho de conflito valido). Ele eh LIMPO quando o
    *     usuario escolhe redigitar, para a nova tentativa ser conferida.
    *==========================================================================
    this_lEmValidacaoSenha   = .F.
    this_cUltimaSenhaValidada = "@@SEM VALIDACAO@@"

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros do chamador e dispara a inicializacao.
    *
    * Legado: Lparameters pTip, pTi1, pTi2, pDoc, pDat, pEmp, pFpg, pVal, com o
    * bloco de normalizacao If (Type([pDoc]) <> [N]) pDoc = 0 / If (Type([pDat])
    * <> [D]) pDat = Date() / ... reproduzido abaixo por PCOUNT + VARTYPE.
    *
    * NENHUM parametro eh obrigatorio: parametro ausente apenas mantem o
    * default declarado acima, exatamente como o legado faz. Init que recusa
    * instanciacao por falta de parametro reprova o harness de teste (que
    * instancia sem argumento) e deixa a tela inalcancavel.
    *
    * Os valores sao guardados ANTES do DODEFAULT() porque eh o DODEFAULT() que
    * chama InicializarForm(), e de la saem o titulo, a frase e as flags de
    * permissao - todos derivados destes parametros.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cTipo, par_uTitulo, par_cTitulo2, par_nNroDoc, par_dDatDoc, par_cEmpresa, par_cFpagto, par_nValFpag)
        LOCAL loc_lSucesso

        IF PCOUNT() >= 1 AND VARTYPE(par_cTipo) = "C"
            THIS.this_cTipo = UPPER(ALLTRIM(par_cTipo))
        ENDIF

        *-- pTi1 do legado: texto em 24 ramos, contagem no ramo CHDEVOLVIDO
        IF PCOUNT() >= 2
            DO CASE
                CASE VARTYPE(par_uTitulo) = "N"
                    THIS.this_nTitulo         = par_uTitulo
                    THIS.this_cTitulo         = ALLTRIM(STR(par_uTitulo))
                    THIS.this_lTituloNumerico = .T.
                CASE VARTYPE(par_uTitulo) = "C"
                    THIS.this_cTitulo         = par_uTitulo
                    THIS.this_nTitulo         = VAL(par_uTitulo)
                    THIS.this_lTituloNumerico = .F.
            ENDCASE
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_cTitulo2) = "C"
            THIS.this_cTitulo2 = par_cTitulo2
        ENDIF

        *-- Legado: If (Type([pDoc]) <> [N]) / pDoc = 0 / EndIf
        IF PCOUNT() >= 4 AND VARTYPE(par_nNroDoc) = "N"
            THIS.this_nNroDoc = par_nNroDoc
        ELSE
            THIS.this_nNroDoc = 0
        ENDIF

        *-- Legado: If (Type([pDat]) <> [D]) / pDat = Date() / EndIf
        IF PCOUNT() >= 5 AND VARTYPE(par_dDatDoc) = "D"
            THIS.this_dDatDoc = par_dDatDoc
        ELSE
            THIS.this_dDatDoc = DATE()
        ENDIF

        *-- Legado: If (Type([pEmp]) <> [C]) / pEmp = [] / EndIf
        IF PCOUNT() >= 6 AND VARTYPE(par_cEmpresa) = "C"
            THIS.this_cEmpresa = par_cEmpresa
        ELSE
            THIS.this_cEmpresa = ""
        ENDIF

        *-- Legado: If (Type([pFpg]) <> [C]) / pFpg = [] / EndIf
        IF PCOUNT() >= 7 AND VARTYPE(par_cFpagto) = "C"
            THIS.this_cFpagto = par_cFpagto
        ELSE
            THIS.this_cFpagto = ""
        ENDIF

        *-- Legado: If (Type([pVal]) <> [N]) / pVal = 0 / EndIf
        IF PCOUNT() >= 8 AND VARTYPE(par_nValFpag) = "N"
            THIS.this_nValFpag = par_nValFpag
        ELSE
            THIS.this_nValFpag = 0
        ENDIF

        *-- Legado: .ZSen = .f. / .UsuLibs = Usuar
        *-- O gate nasce NAO autorizado, e o usuario que responde pela
        *-- liberacao comeca sendo o que esta logado (Usuar do legado).
        THIS.this_lZSen    = .F.
        THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
        THIS.this_cRetorno = ""

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Guarda de conexao do Init legado:
    *     .poDataMgr = CreateObject([fSqlConector], .Name)
    *     If (.poDataMgr.pnIdconn > 0) ... Else
    *         =Messagebox([Impossivel Efetuar Conexao Com o Servidor ...])
    *         Return .f.
    *     EndIf
    *
    * No sistema novo o equivalente de pnIdconn eh o handle global
    * gnConnHandle. A guarda fica num metodo PROPRIO, chamado ANTES do TRY de
    * InicializarForm, e com BYPASS no topo para modo de teste / validacao de
    * UI: o harness de teste define gnConnHandle = 0 DE PROPOSITO (sentinela,
    * para nao esperar o timeout TCP de um servidor inacessivel) e espera que
    * os forms pulem o acesso a dados por gb_4c_ModoTeste / gb_4c_ValidandoUI,
    * nao por checagem de handle. Sem o bypass, a tela reprovaria SEMPRE no
    * teste de instanciacao, sem nenhum erro de SQL no log.
    *
    * PUBLIC (sem PROTECTED): alcancavel pelo harness, que chama metodos do
    * form de fora da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        loc_lValido = .T.

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                loc_lValido = .F.
        ENDCASE

        IF !loc_lValido
            THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                "o Com o Servidor de Banco de Dados..."
            MsgErro(THIS.this_cMensagemErro, "CreateObject")
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init().
    *
    * Monta a estrutura base da tela na ordem do Init legado: conexao, objeto
    * de negocio, parametros do sistema, resolucao do TIPO (que define o
    * Caption) e so depois a faixa do cabecalho - que copia justamente esse
    * Caption, como no legado (.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * O RETURN da guarda fica FORA do TRY (regra: nunca RETURN dentro de
    * TRY/CATCH), e o resultado do bloco protegido vai para loc_lSucesso.
    *
    * CREATEOBJECT do BO roda INCONDICIONALMENTE dentro do TRY - sem gate de
    * gnConnHandle, que ja foi tratado em ValidarParametros().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.

        TRY
            *-- Objeto de negocio (gerado nas fases de BO)
            THIS.this_oBusinessObject = CREATEOBJECT("sigopsenBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Repassa ao BO os parametros recebidos do chamador
                THIS.ConfigurarParametrosBO()

                *-- Parametros do sistema (SigCdPam / SigCdPac). Gate de
                *-- AUTORIZACAO: sem eles a tela NAO abre, como no legado.
                IF THIS.CarregarParametrosSistema()
                    *-- Titulo, frase e flag de permissao a partir do TIPO
                    THIS.ConfigurarPorTipo()

                    *-- Aparencia da janela (fundo e cor de fundo)
                    THIS.ConfigurarAparencia()

                    *-- Faixa cinza do cabecalho (cntSombra do legado).
                    *-- PRIMEIRO AddObject da tela: os controles de dados
                    *-- entram depois, para desenharem por cima dela.
                    THIS.ConfigurarCabecalho()

                    *-- Bloco final do Init legado: decide se a tela passa a
                    *-- pedir a senha do dia em vez da senha cadastrada
                    THIS.AvaliarSenhaDoDia()

                    *-- Campos da tela: frase da liberacao e linha do usuario.
                    *-- Depende de ConfigurarPorTipo (frase) e de
                    *-- AvaliarSenhaDoDia (campo travado e pre-preenchido).
                    THIS.ConfigurarCamposUsuario()

                    *-- Restante dos campos: icone, linha da senha e o
                    *-- campo de senha. Criados DEPOIS da linha do usuario
                    *-- (ordem do SCX) e DEPOIS de AvaliarSenhaDoDia, que
                    *-- decide o rotulo da linha.
                    THIS.ConfigurarCamposSenha()

                    *-- Valid / KeyPress dos campos do legado, por BINDEVENT.
                    *-- Depois de TODO AddObject: BINDEVENT em controle que
                    *-- ainda nao existe estoura no proprio bind.
                    THIS.LigarEventos()

                    *-- AddObject cria todo controle com Visible = .F.
                    THIS.TornarControlesVisiveis(THIS)

                    *-- Sincroniza a tela com o estado do BO. Roda DEPOIS de
                    *-- TornarControlesVisiveis, que forca Visible = .T. em
                    *-- tudo: eh este passo que devolve a visibilidade e a
                    *-- habilitacao governadas pelo estado do dialogo, para
                    *-- a tela nao abrir divergindo do BO.
                    THIS.BOParaForm()

                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio sigopsenBO"
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao inicializar Formsigopsen")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou.
    *
    * O BO guarda o estado da autorizacao (tipo, documento, empresa, forma de
    * pagamento, valor) e eh quem monta a consulta de usuarios e a baixa da
    * senha livre; o form eh so a superficie. Os nomes das properties sao os
    * declarados em sigopsenBO.prg.
    *
    * this_cTitulo do BO recebe a forma em TEXTO de pTi1 (o BO declara a
    * property como caractere); a forma numerica fica no form, onde eh usada
    * pelo ramo CHDEVOLVIDO de ConfigurarPorTipo().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarParametrosBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Legado, no MESMO bloco em que zera as 21 flags de tipo:
        *--     .UsuLibs = Usuar
        *-- INCONDICIONAL - o liberador nasce sendo o usuario LOGADO, e so
        *-- eh substituido quando o fluxo do campo usuario resolve outro
        *-- ("thisform.usulibs = this.value") ou quando a conferencia da
        *-- senha do dia grava nele a senha gerada. Sem esta linha, um
        *-- dialogo RECUSADO sem o usuario ter sido informado (ESC no campo
        *-- em branco) devolveria " " em vez do " " + usuario logado que o
        *-- Unload legado monta, e o log do ramo de movimento sairia com o
        *-- liberador em branco nos tipos em que o campo usuario nasce
        *-- travado.
        THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")

        WITH THIS.this_oBusinessObject
            .this_cTipo    = THIS.this_cTipo
            .this_cTitulo  = THIS.this_cTitulo
            .this_cTitulo2 = THIS.this_cTitulo2
            .this_nNroDoc  = THIS.this_nNroDoc
            .this_dDatDoc  = THIS.this_dDatDoc
            .this_cEmpresa = THIS.this_cEmpresa
            .this_cFpagto  = THIS.this_cFpagto
            .this_nValFpag = THIS.this_nValFpag
            .this_lZSen    = .F.
            .this_cUsuLibs = THIS.this_cUsuLibs
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - As duas CursorQuery do Init legado:
    *
    *   .poDataMgr.CursorQuery([SigCdPam], [crParam], .f., .f., [LibLCreds])
    *   If Not Used([crParam]) -> MessageBox + Return .f.
    *   .poDataMgr.CursorQuery([SigCdPac], [crParac], .f., .f., [SenhDEmps])
    *   If Not Used([crParam]) -> MessageBox + Return .f.
    *
    * O 5o argumento da CursorQuery eh a lista de campos, logo as consultas
    * equivalentes sao "SELECT liblcreds FROM SigCdPam" e "SELECT senhdemps
    * FROM SigCdPac". NENHUMA das duas leva WHERE: conferido no schema
    * canonico, nem SigCdPam nem SigCdPac tem coluna de empresa (as unicas
    * colunas que contem "emps" sao blqmemps, libtremps e a propria senhdemps)
    * - sao tabelas de parametro de linha unica, e inventar um WHERE Emps aqui
    * faria o SQL Server recusar a consulta.
    *
    * UM desvio deliberado do literal: o legado testa "Used([crParam])" DUAS
    * vezes e nunca testa crParac. Aqui cada carga confere o SEU cursor - sem
    * isso a falha da segunda passaria calada e estouraria depois, ao ler
    * CrParac.SenhDEmps na conferencia da senha. O caminho de sucesso tem
    * desfecho identico ao do legado.
    *
    * As duas colunas sao "bit" no SQL Server, que chega ao VFP ora como
    * Logico ora como Numerico conforme o driver - por isso ConverterParaLogico
    * em vez de comparar com 1.
    *
    * Em modo de teste / validacao de UI nao ha conexao (o harness define
    * gnConnHandle = 0 de proposito) e um SQLEXEC sem handle valido BLOQUEIA o
    * processo em vez de devolver erro: a carga eh pulada nesses dois modos,
    * devolvendo .T. para a estrutura visual - que eh o que esses modos medem -
    * continuar sendo montada. Os parametros ficam nos defaults do BO.
    *
    * PUBLIC: eh o ponto de recarga dos parametros do sistema e pode ser
    * chamado de fora (harness e chamador), nao so de dentro da classe.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cCursor, loc_nResultado, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN .T.
        ENDIF

        loc_lSucesso = .F.

        TRY
            *-- SigCdPam.liblcreds -> crParam do legado
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorParam

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT liblcreds FROM SigCdPam", loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                MsgErro(THIS.this_cMensagemErro, ;
                    "Falha na Conex" + CHR(227) + "o (CursorQuery - crParam)")
            ELSE
                SELECT (loc_cCursor)
                GO TOP
                THIS.this_oBusinessObject.this_lLiblCreds = ;
                    IIF(EOF(loc_cCursor), .F., ConverterParaLogico(EVALUATE(loc_cCursor + ".liblcreds")))

                *-- SigCdPac.senhdemps -> crParac do legado
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorParac

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", loc_cCursor)

                IF loc_nResultado < 1 OR !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, ;
                        "Falha na Conex" + CHR(227) + "o (CursorQuery - crParac)")
                ELSE
                    SELECT (loc_cCursor)
                    GO TOP
                    THIS.this_oBusinessObject.this_lSenhDEmps = ;
                        IIF(EOF(loc_cCursor), .F., ConverterParaLogico(EVALUATE(loc_cCursor + ".senhdemps")))

                    THIS.this_lParametrosCarregados = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Falha na Conex" + CHR(227) + "o (Par" + CHR(226) + "metros do Sistema)")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPorTipo - Transcricao do "Do Case pTip" do Init legado.
    *
    * Cada ramo define TRES coisas: o Caption da janela (que a faixa do
    * cabecalho copia), o texto do rotulo Frase e a flag de permissao que a
    * consulta de usuarios vai exigir. As flags moram no BO, que eh quem monta
    * essa consulta.
    *
    * Os textos sao transcritos LITERALMENTE do dump, com acentos escritos em
    * CHR(): sao o que o usuario le para entender QUAL liberacao esta sendo
    * pedida, e reescrever a frase mudaria a informacao exibida.
    *
    * Quatro fidelidades que o ramo-a-ramo exige:
    *   - DTENTREGA DESLIGA this_lFinanc em vez de ligar uma flag, exatamente
    *     como o legado (.Financ = .f.) - esse tipo cai no ramo "Otherwise" da
    *     consulta de usuarios, que exige AltCots.
    *   - LIBPRZENT, LIBVMOVDUP e LIBVLM definem SO o Caption; o legado nao
    *     toca na Frase nesses tres, e a Frase segue vazia.
    *   - MAXIMO concatena o 2o texto no Caption SEM Alltrim, e eh o unico ramo
    *     assim.
    *   - LIBPRDZ, LIBPRDZ2 e LIBPESO compartilham UM ramo (InList no legado).
    *
    * O tipo eh comparado com "==" sobre o valor ja passado por UPPER+ALLTRIM,
    * para a correspondencia nao depender de SET EXACT nem do tamanho do
    * literal (o legado grava "LIBVlM" em caixa mista, que entra aqui como
    * LIBVLM).
    *
    * Nao existe "Otherwise": tipo desconhecido deixa titulo e frase vazios e
    * nenhuma flag ligada, e a conferencia de usuario cai no ramo AltCots - o
    * mesmo desfecho do legado, que tambem nao tem Otherwise aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPorTipo()
        LOCAL loc_cTipo, loc_cCaption, loc_cFrase

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cTipo    = UPPER(ALLTRIM(THIS.this_cTipo))
        loc_cCaption = ""
        loc_cFrase   = ""

        WITH THIS.this_oBusinessObject
            DO CASE
                CASE loc_cTipo == "CUSTOPROD"
                    loc_cCaption     = "Custo Produto"
                    loc_cFrase       = ALLTRIM(THIS.this_cTitulo)
                    .this_lCustoProd = .T.

                CASE loc_cTipo == "DTENTREGA"
                    loc_cCaption  = "Prazo de Entrega"
                    loc_cFrase    = ALLTRIM(THIS.this_cTitulo) + " Fora do Prazo de Entrega"
                    .this_lFinanc = .F.

                CASE loc_cTipo == "CHDEVOLVIDO"
                    loc_cCaption  = "Cheque Devolvido"
                    loc_cFrase    = "A Conta " + ALLTRIM(THIS.this_cTitulo2) + " Possui " + ;
                        IIF(THIS.this_nTitulo = 1, ;
                            "1 Cheque Devolvido Pendente", ;
                            ALLTRIM(STR(THIS.this_nTitulo)) + " Cheques Devolvidos Pendentes")
                    .this_lFinanc = .T.

                CASE loc_cTipo == "LIMITE"
                    loc_cCaption  = "Limite Excedido"
                    loc_cFrase    = "O Limite da Conta " + ALLTRIM(THIS.this_cTitulo) + " Foi Excedido"
                    .this_lFinanc = .T.

                CASE loc_cTipo == "ALTERAIMPOSTO"
                    loc_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    .this_lFinanc = .T.

                CASE loc_cTipo == "CANCITEM"
                    loc_cCaption    = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase      = ALLTRIM(THIS.this_cTitulo2)
                    .this_lCancItem = .T.

                CASE loc_cTipo == "LIBFPAG"
                    loc_cCaption   = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase     = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibFpag = .T.

                CASE INLIST(loc_cTipo, "LIBPRDZ", "LIBPRDZ2", "LIBPESO")
                    loc_cCaption       = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase         = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibProducao = .T.

                CASE loc_cTipo == "SDINSUF"
                    loc_cCaption        = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase          = ALLTRIM(THIS.this_cTitulo2)
                    .this_lSaldoEstoque = .T.

                CASE loc_cTipo == "MAXIMO"
                    *-- Unico ramo que concatena o 2o texto SEM Alltrim
                    loc_cCaption  = "Valor M" + CHR(225) + "ximo Excedido :" + THIS.this_cTitulo2
                    loc_cFrase    = "Valor da Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                        ALLTRIM(THIS.this_cTitulo) + " Foi Excedido"
                    .this_lFinanc = .T.

                CASE loc_cTipo == "DTVALIDA"
                    loc_cCaption      = "Validade da Opera" + CHR(231) + CHR(227) + "o"
                    loc_cFrase        = ALLTRIM(THIS.this_cTitulo) + " Fora da Validade"
                    .this_lLibValida  = .T.

                CASE loc_cTipo == "LIBTITULO"
                    loc_cCaption        = "Liberar T" + CHR(237) + "tulo"
                    loc_cFrase          = ALLTRIM(THIS.this_cTitulo)
                    .this_lLiberaTitulo = .T.

                CASE loc_cTipo == "LIBERAFPG"
                    loc_cCaption    = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase      = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibFpag2 = .T.

                CASE loc_cTipo == "LIBOPE"
                    loc_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibOpe = .T.

                CASE loc_cTipo == "LIBMOVUSU"
                    loc_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibMovUsu = .T.

                CASE loc_cTipo == "LIBQTMIN"
                    loc_cCaption    = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase      = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibQtMin = .T.

                CASE loc_cTipo == "LIBLIMITADOR"
                    loc_cCaption        = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase          = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibLimitador = .T.

                CASE loc_cTipo == "MOVESTOQUE"
                    loc_cCaption      = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase        = ALLTRIM(THIS.this_cTitulo2)
                    .this_lMovEstoque = .T.

                CASE loc_cTipo == "LIBLEILAO"
                    loc_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibLeilao = .T.

                CASE loc_cTipo == "LIBDUPEND"
                    loc_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibDupEnd = .T.

                CASE loc_cTipo == "LIBPRZENT"
                    *-- O legado nao toca na Frase neste ramo
                    loc_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    .this_lLibPrzEnt = .T.

                CASE loc_cTipo == "LIBVMOVDUP"
                    *-- O legado nao toca na Frase neste ramo
                    loc_cCaption      = ALLTRIM(THIS.this_cTitulo)
                    .this_lLibVMovDup = .T.

                CASE loc_cTipo == "LIBVLM"
                    *-- O legado nao toca na Frase neste ramo
                    loc_cCaption        = ALLTRIM(THIS.this_cTitulo)
                    .this_lLibValMaxMal = .T.

                CASE loc_cTipo == "LIBSENEXC"
                    loc_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibExcPrd = .T.

                CASE loc_cTipo == "LIBSUBN"
                    loc_cCaption   = ALLTRIM(THIS.this_cTitulo)
                    loc_cFrase     = ALLTRIM(THIS.this_cTitulo2)
                    .this_lLibSubn = .T.
            ENDCASE

            .this_cCaption = loc_cCaption
            .this_cFrase   = loc_cFrase
        ENDWITH

        THIS.Caption     = loc_cCaption
        THIS.this_cFrase = loc_cFrase

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparencia - Propriedades visuais da janela que dependem de
    * funcao ou de variavel global e por isso nao cabem no bloco de declaracao
    * da classe.
    *
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    *         BackColor = 255,255,255
    *
    * O caminho vem de gc_4c_CaminhoIcones (vbmp\), onde o arquivo existe -
    * NUNCA remontar o caminho a partir de gc_4c_CaminhoBase. Sem guard
    * IF FILE(): o arquivo existe no acervo, e esconder a ausencia de imagem
    * atras de um guard eh justamente o que faz o fundo desaparecer em silencio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.BackColor  = RGB(255, 255, 255)
        THIS.ScrollBars = 0

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
    *
    * Legado:
    *   cntSombra            Top=0  Left=0  Width=800 Height=80
    *                        BorderWidth=0 BackColor=100,100,100
    *   cntSombra.lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *   cntSombra.lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *   ambos: Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * Dois desvios DELIBERADOS do literal do dump, ambos ja catalogados:
    *
    * (1) WIDTH - o SCX declara o container com 800 e os labels com 769, mas o
    *     proprio form tem 400: o Form Designer desenhou a faixa 400px mais
    *     larga que a janela. Copiar o literal faria o container e os labels
    *     ficarem RECORTADOS pela borda do form, cortando o titulo no meio
    *     (controle fora da area do pai eh cortado sem erro e sem log). Usa-se
    *     THIS.Width no container e THIS.Width - 20 nos labels (Left = 10 de
    *     cada lado), que eh o equivalente responsivo do literal.
    *
    * (2) CAPTION - o dump traz "Cadastro de Testes" nos dois labels, texto de
    *     template que ficou no SCX (o ToolTipText do lblTitulo ainda diz
    *     "Titulo do Relatorio"). O titulo real da tela eh o Caption do form,
    *     resolvido por ConfigurarPorTipo() a partir do tipo de liberacao - eh
    *     exatamente o que o Init legado faz nas duas linhas
    *     .cntSombra.lblSombra.Caption = ThisForm.Caption.
    *
    * AutoSize = .F. explicito: AutoSize eh no-op em Label criado por AddObject
    * e, com WordWrap = .T., chega a descartar a Height - o par Width/Height
    * transcrito do SCX ja eh o tamanho calculado pelo Designer.
    *
    * ForeColor branco eh legitimo aqui: o lbl_4c_LblTitulo fica dentro de
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
            .Width         = THIS.Width - 20
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
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AvaliarSenhaDoDia - Bloco FINAL do Init legado:
    *
    *   If (crParam.LiblCreds And pTip = [LIMITE]) Or InList(pTip, [LIBPRDZ2], [MAXIMO])
    *       .usuario.Value = Usuar
    *       .Say3.Caption  = [Senha Do Dia :]
    *       .Say3.Left     = 142
    *   EndIf
    *
    * Nestes tres casos a tela deixa de conferir a senha CADASTRADA do usuario
    * e passa a conferir a SENHA DO DIA, calculada a partir do numero e da data
    * do documento (e, quando SenhDEmps esta ligado, tambem da empresa e da
    * forma de pagamento). A decisao eh publicada em this_lSenhaDoDia, e tanto
    * o preenchimento do campo de usuario quanto o rotulo "Senha Do Dia :"
    * leem essa flag assim que os controles existem.
    *
    * O usuario que responde pela liberacao ja fica gravado no BO aqui - eh o
    * ".usuario.Value = Usuar" do legado, que no sistema novo eh
    * gc_4c_UsuarioLogado.
    *
    * Esta flag NAO eh o mesmo predicado do When do campo usuario
    *   Return (Not crParam.LiblCreds Or (Tipo <> [LIMITE] And Tipo <> [LIBPRDZ2])) And (Tipo <> [MAXIMO])
    * - as duas expressoes divergem, por exemplo, quando LiblCreds esta
    * desligado e o tipo eh LIBPRDZ2 (ali o campo fica EDITAVEL e a senha ainda
    * eh a do dia). O When eh transcrito a parte, junto com o campo.
    *
    * PUBLIC: eh reavaliada sempre que os parametros do sistema sao
    * recarregados, inclusive de fora da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AvaliarSenhaDoDia()
        LOCAL loc_cTipo, loc_lLiblCreds

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cTipo      = UPPER(ALLTRIM(THIS.this_cTipo))
        loc_lLiblCreds = THIS.this_oBusinessObject.this_lLiblCreds

        THIS.this_lSenhaDoDia = (loc_lLiblCreds AND loc_cTipo == "LIMITE") OR ;
            INLIST(loc_cTipo, "LIBPRDZ2", "MAXIMO")

        THIS.this_oBusinessObject.this_lSenhaDoDia = THIS.this_lSenhaDoDia

        IF THIS.this_lSenhaDoDia
            *-- Legado: .usuario.Value = Usuar
            THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            THIS.this_oBusinessObject.this_cUsuario = THIS.this_cUsuLibs
            THIS.this_oBusinessObject.this_cUsuLibs = THIS.this_cUsuLibs
        ENDIF

        RETURN THIS.this_lSenhaDoDia
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposUsuario - Primeiro bloco de campos da tela: a frase que
    * explica a liberacao e a linha "Usuario :" com o campo de digitacao.
    *
    * Legado (transcrito do dump - PILAR 1):
    *   Frase    AutoSize=.F. FontBold=.T. FontItalic=.T. FontName="Tahoma"
    *            WordWrap=.T. Alignment=2 Height=34 Left=2 Top=46 Width=394
    *            TabIndex=1 ForeColor=255,255,255   (o Caption vem do Init)
    *   Say2     FontBold=.T. FontName="Tahoma" Caption="Usuario : "
    *            Left=112 Top=102 TabIndex=2 ForeColor=90,90,90
    *   usuario  FontName="Tahoma" FontSize=12 Century=2 Alignment=3
    *            Height=30 InputMask="!!!!!!!!!!" Left=168 Top=94 Width=119
    *            TabIndex=3 ForeColor=0,0,0
    *
    * O que o dump NAO declara vem da CLASSE do framework legado, nunca de
    * palpite (docs\FRAMEWORK_class_codigo_fonte.txt):
    *   say    AutoSize=.T. FontName="Tahoma" FontSize=8 BackStyle=0
    *          Height=15 Width=27 ForeColor=90,90,90
    *   fwget  FontName="Tahoma" FontSize=8 Format="K" Height=23 Width=100
    *          DisabledBackColor=192,192,192 DisabledForeColor=0,0,0 Themes=.F.
    *
    * ForeColor BRANCO no lbl_4c_Frase eh legitimo e NAO vira RGB(90,90,90):
    * Top=46 com Height=34 deixa a frase em 46..80, isto eh, INTEIRAMENTE
    * dentro da faixa cnt_4c_Sombra (0..80), que eh container OPACO com
    * BackColor RGB(100,100,100). A frase eh filha da Form, nao do container, e
    * desenha POR CIMA do cinza - condicao exata da excecao de branco. Eh
    * tambem por isso que este metodo roda DEPOIS de ConfigurarCabecalho.
    *
    * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
    * criado por AddObject (a largura fica nos 100 do default) e, com
    * WordWrap = .T., chega a DESCARTAR a Height - a frase de duas linhas
    * (Height = 34) colapsaria para uma e a segunda linha desapareceria sem
    * erro e sem log. Na Frase o par Width/Height vem do dump; no
    * lbl_4c_Label2, que herda AutoSize = .T. da classe say e nao declara
    * tamanho nenhum, a Width eh medida para caber a legenda - NUNCA os 27 da
    * classe, que sao a largura do Caption "Label" e cortariam a legenda.
    *
    * Alignment = 0 no lbl_4c_Label2: a classe say desenha da esquerda, e o
    * dump nao declara nem Alignment nem Width. Inventar Alignment = 1 jogaria
    * o texto contra a borda direita da caixa, que cai DENTRO do TextBox, e a
    * legenda sairia comida pelo campo. Os 54px fazem a legenda terminar em
    * 166, 2px antes do campo (Left = 168) - o mesmo escalonamento que o legado
    * usa na linha de baixo, onde a legenda mais curta ("Senha : ") comeca mais
    * a direita (Left = 120) para terminar no mesmo lugar.
    *
    * MaxLength = 10 vem da LARGURA DA COLUNA (SigCdUsu.usuarios eh char(10)),
    * nunca do Width em pixels, e casa com os 10 "!" do InputMask.
    *
    * Enabled reproduz o When do campo usuario no legado, calculado por
    * UsuarioEditavel(). When nao pode ser ligado por BINDEVENT - o bind
    * descarta o retorno do delegate e o gate nao bloquearia nada -, e
    * reproduzir When por Enabled eh o que o projeto ja faz (FormCLC). As cores
    * de desabilitado vem da classe fwget, para o campo travado ficar com a
    * mesma aparencia que tem no legado.
    *
    * Nos tipos em que a tela passa a conferir a senha do dia, o legado
    * preenche o campo com o usuario logado (.usuario.Value = Usuar) - valor ja
    * resolvido por AvaliarSenhaDoDia() em this_cUsuLibs.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposUsuario()
        *-- Frase que explica a liberacao pedida (Frase do legado)
        THIS.AddObject("lbl_4c_Frase", "Label")

        WITH THIS.lbl_4c_Frase
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = THIS.this_cFrase
            .Top        = 46
            .Left       = 2
            .Width      = 394
            .Height     = 34
            .ForeColor  = RGB(255, 255, 255)
            .TabIndex   = 1
            .Visible    = .T.
        ENDWITH

        *-- Rotulo "Usuario :" (Say2 do legado)
        THIS.AddObject("lbl_4c_Label2", "Label")

        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .WordWrap  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Usu" + CHR(225) + "rio : "
            .Top       = 102
            .Left      = 112
            .Width     = 54
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- Campo de digitacao do usuario (usuario do legado, classe fwget)
        THIS.AddObject("txt_4c_Usuario", "TextBox")

        WITH THIS.txt_4c_Usuario
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 12
            .Century           = 2
            .Alignment         = 3
            .Format            = "K"
            .InputMask         = "!!!!!!!!!!"
            .MaxLength         = 10
            .Top               = 94
            .Left              = 168
            .Width             = 119
            .Height            = 30
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 3
            .Enabled           = THIS.UsuarioEditavel()
            .Visible           = .T.
        ENDWITH

        *-- Legado: .usuario.Value = Usuar quando a conferencia passa a ser
        *-- pela senha do dia
        IF THIS.this_lSenhaDoDia
            THIS.txt_4c_Usuario.Value = THIS.this_cUsuLibs
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioEditavel - Predicado do When do campo usuario no legado:
    *
    *   Return (Not crParam.LiblCreds Or (ThisForm.Tipo <> [LIMITE] And
    *           (ThisForm.Tipo <> [LIBPRDZ2]))) And (ThisForm.Tipo <> [MAXIMO])
    *
    * Nos tipos em que a liberacao eh conferida contra a senha do dia o campo
    * de usuario deixa de aceitar digitacao: ele ja chega preenchido com o
    * usuario logado, e quem responde pela liberacao eh a senha, nao o nome.
    *
    * NAO eh o mesmo predicado de AvaliarSenhaDoDia(): com LiblCreds desligado
    * e tipo LIBPRDZ2 o campo continua EDITAVEL e a senha ainda eh a do dia -
    * as duas expressoes do legado divergem nesse ponto, e cada uma eh
    * transcrita como esta escrita la.
    *
    * crParam.LiblCreds eh lido do BO (cursor_4c_Param, carregado por
    * CarregarParametrosSistema, onde a coluna passa por ConverterParaLogico e
    * chega sempre como logico). BO ausente deixa a flag em .F., que eh o
    * default do legado e o lado seguro: mantem o campo editavel em vez de
    * travar a tela.
    *
    * PUBLIC: eh reavaliado sempre que os parametros do sistema ou o tipo da
    * liberacao mudam, inclusive de fora da classe.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioEditavel()
        LOCAL loc_cTipo, loc_lLiblCreds, loc_lEditavel

        loc_lLiblCreds = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lLiblCreds = THIS.this_oBusinessObject.this_lLiblCreds
        ENDIF

        loc_cTipo = UPPER(ALLTRIM(THIS.this_cTipo))

        loc_lEditavel = (!loc_lLiblCreds OR !INLIST(loc_cTipo, "LIMITE", "LIBPRDZ2")) ;
            AND !(loc_cTipo == "MAXIMO")

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposSenha - Restante dos campos da tela: a linha
    * "Senha :" com o campo mascarado e o icone de login.
    *
    * Legado (transcrito do dump - PILAR 1):
    *   Say3   FontBold=.T. FontName="Tahoma" Caption="Senha : "
    *          Left=120 Top=135 Visible=.T. ForeColor=90,90,90
    *   senha  FontName="Tahoma" FontSize=12 Height=30
    *          InputMask="!!!!!!!!!!" Left=168 Top=127 Visible=.T.
    *          Width=119 PasswordChar="*" ForeColor=0,0,0
    *   Image1 Picture=..\framework\imagens\geral_login_60.jpg Stretch=0
    *          Height=32 Left=44 Top=109 Width=32
    *
    * O que o dump nao declara vem da CLASSE, nunca de palpite: say
    * (AutoSize=.T. FontSize=8 BackStyle=0 Height=15) e fwget (FontSize=8
    * Format="K" DisabledBackColor=192,192,192 DisabledForeColor=0,0,0
    * Themes=.F.). O dump nao declara TabIndex para nenhum destes tres, e a
    * ordem dos AddObject (depois da linha do usuario, que tem TabIndex=3)
    * ja reproduz a sequencia de tabulacao do legado.
    *
    * Alignment NAO eh declarado no campo de senha porque o dump tambem nao
    * declara: TextBox criado por AddObject nasce com Alignment = 3 (medido),
    * que eh o mesmo valor que o legado obtem da classe.
    *
    * MaxLength = 10 vem da LARGURA DA COLUMA (SigCdUsu.senhas eh char(10)),
    * nunca do Width em pixels, e casa com os 10 "!" do InputMask e com o
    * Padr(this.value,10) que o legado usa para comparar a senha.
    *
    * .Picture vem ANTES de .Width/.Height: Image com Stretch = 0 descarta a
    * geometria declarada e assume o tamanho NATURAL do arquivo no momento em
    * que o Picture eh atribuido. Aqui as duas coincidem (geral_login_60.jpg
    * medido: 32x32, exatamente os 32x32 do dump), entao a ordem nao muda o
    * resultado - mas a ordem certa eh a que continua fiel se o arquivo for
    * trocado por outro de tamanho diferente.
    *
    * UM desvio DELIBERADO, no rotulo em modo SENHA DO DIA. O Init legado faz
    *   .Say3.Caption = [Senha Do Dia :]   /   .Say3.Left = 142
    * mas Say3 eh AutoSize da classe say e esse texto mede ~76px em Tahoma 8
    * bold: 142 + 76 = 218 invade o campo de senha, que comeca em 168. Como
    * Say3 eh criado ANTES de senha, o TextBox (opaco) desenha por cima e o
    * rotulo sai cortado em "Senha Do" - o legado tem a sobreposicao
    * HERDADA do SCX, e transcrever o 142 literalmente a REPRODUZIRIA
    * (regra #28: comparar migrado x legado nunca pega este caso, porque os
    * dois concordam). Preserva-se a INTENCAO do legado - rotulo terminando
    * poucos pixels antes do campo, o mesmo escalonamento das outras duas
    * linhas ("Usuario : " Left=112 Width=54 e "Senha : " Left=120 Width=46,
    * ambos terminando em 166) - usando Left=86 com Width=80. O texto que
    * identifica QUAL senha o usuario deve digitar eh a unica informacao
    * dessa linha; esconder metade dele custa mais que 56px de posicao.
    *
    * AutoSize = .F. explicito no rotulo: AutoSize eh no-op em Label criado
    * por AddObject (a largura fica nos 100 do default) e, com WordWrap,
    * chega a descartar a Height. Como o dump nao traz Width/Height para
    * Say3 (a classe say calculava), a largura eh medida para caber a
    * legenda - a de 27 da classe eh a largura do Caption "Label" e
    * cortaria o texto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposSenha()
        LOCAL loc_cCaption, loc_nLeft, loc_nWidth

        *-- Legado: no modo senha do dia o Init troca o Caption e reposiciona
        *-- o rotulo (ver o desvio documentado acima)
        IF THIS.this_lSenhaDoDia
            loc_cCaption = "Senha Do Dia :"
            loc_nLeft    = 86
            loc_nWidth   = 80
        ELSE
            loc_cCaption = "Senha : "
            loc_nLeft    = 120
            loc_nWidth   = 46
        ENDIF

        *-- Rotulo da linha da senha (Say3 do legado)
        THIS.AddObject("lbl_4c_Label3", "Label")

        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .WordWrap  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = loc_cCaption
            .Top       = 135
            .Left      = loc_nLeft
            .Width     = loc_nWidth
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo da senha (senha do legado, classe fwget)
        THIS.AddObject("txt_4c_Senha", "TextBox")

        WITH THIS.txt_4c_Senha
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 12
            .Format            = "K"
            .InputMask         = "!!!!!!!!!!"
            .MaxLength         = 10
            .PasswordChar      = "*"
            .Top               = 127
            .Left              = 168
            .Width             = 119
            .Height            = 30
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Icone de login a esquerda dos dois campos (Image1 do legado)
        THIS.AddObject("img_4c_Image1", "Image")

        WITH THIS.img_4c_Image1
            .Picture = gc_4c_CaminhoIcones + "geral_login_60.jpg"
            .Stretch = 0
            .Top     = 109
            .Left    = 44
            .Width   = 32
            .Height  = 32
            .Visible = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarEventos - Liga por BINDEVENT os eventos que o legado escreve nos
    * controles. Roda DEPOIS de todo AddObject: BINDEVENT em controle que
    * ainda nao existe estoura no proprio bind.
    *
    * O legado tem codigo em DOIS eventos do campo usuario:
    *   usuario.Valid    - resolve o usuario (consulta + picker + senha)
    *   usuario.KeyPress - ESC com o campo em branco encerra o dialogo
    *
    * O Valid vai para "LostFocus", nunca para "KeyPress" (regra #47): o
    * Valid legado dispara ao SAIR do campo, e um handler de KeyPress que
    * abre picker sem testar a tecla abriria o dialogo a CADA caractere -
    * digitando "MARCELO" o picker subiria no "M" e o usuario nao
    * conseguiria terminar de digitar. BINDEVENT em "Valid" de TextBox
    * tambem nao dispara de forma confiavel no VFP9.
    *
    * O When do campo usuario NAO eh ligado por BINDEVENT: o bind descarta o
    * retorno do delegate, entao o gate nao bloquearia nada. Ele eh
    * reproduzido por Enabled, calculado por UsuarioEditavel() (ver
    * ConfigurarCamposUsuario).
    *
    * F4 e DblClick sao entradas ADICIONAIS para o mesmo picker, convencao
    * do projeto para campo com lookup. Sao aditivas: nao retiram nem
    * alteram nenhum caminho do legado, apenas dispensam o usuario de
    * digitar um codigo invalido so para a lista aparecer.
    *
    * O campo SENHA tem UM evento no legado - o Valid, que eh o fluxo de
    * ACAO da tela (senha livre de SigPrSnd, senha cadastrada ou senha do
    * dia, log de liberacao e o desfecho do gate). Ele vai para
    * "LostFocus" pelo mesmo motivo do campo usuario, e com mais razao:
    * ligado a "KeyPress" ele conferiria uma senha INCOMPLETA a cada
    * caractere digitado e dispararia o dialogo "Deseja digitar novamente
    * ?" na primeira tecla.
    *
    * O campo senha NAO recebe KeyPress nem DblClick: o legado nao escreve
    * nenhum dos dois nele (nao ha lookup de senha, e o ESC do dialogo mora
    * no campo usuario). Inventar aqui um atalho que o legado nao tem seria
    * acrescentar superficie (PILAR 1) - e a saida do dialogo continua
    * existindo pelos dois caminhos do legado: ESC no campo usuario em
    * branco, e responder "Nao" ao dialogo de conflito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarEventos()
        BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "UsuarioLostFocus")
        BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "UsuarioKeyPress")
        BINDEVENT(THIS.txt_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")

        BINDEVENT(THIS.txt_4c_Senha, "LostFocus", THIS, "SenhaLostFocus")

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioLostFocus - Equivalente ao Valid do campo usuario legado.
    *
    * WRAPPER FINO, so para a guarda de reentrancia: o corpo fica em
    * UsuarioLostFocusExec() porque ele tem RETURN antecipado em varios
    * caminhos (campo vazio, valor ja validado, consulta falhou) e, com
    * set/clear no proprio corpo, qualquer um desses RETURN deixaria a flag
    * LIGADA para sempre - e dai o lookup nunca mais abriria (regra #47). O
    * wrapper libera a flag em UMA linha que nenhum RETURN do corpo
    * consegue pular.
    *
    * A reentrancia eh real: o picker eh MODAL, tira o foco do campo e faz o
    * proprio LostFocus disparar de novo; sem a guarda abririam DOIS
    * dialogos empilhados (regra #37).
    *
    * this_lDialogoEncerrado barra a segunda passada depois do Hide(): o
    * dialogo ja devolveu a resposta ao chamador, revalidar o campo ali
    * poderia sobrescrever this_lZSen depois de lido.
    *
    * PUBLIC: BINDEVENT so funciona com metodo PUBLIC - PROTECTED falha em
    * silencio (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioLostFocus()
        IF THIS.this_lEmLookupUsuario OR THIS.this_lDialogoEncerrado
            RETURN
        ENDIF

        THIS.this_lEmLookupUsuario = .T.
        THIS.UsuarioLostFocusExec()
        THIS.this_lEmLookupUsuario = .F.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioLostFocusExec - Corpo do Valid do campo usuario legado.
    *
    * Legado, na ordem:
    *   1. If Empty(This.Value) -> ZSen = .f. / ThisForm.Release / Return .t.
    *   2. Do Case ... monta lcQuery conforme a liberacao pedida
    *   3. If (SqlExecute(lcQuery,'TmpUsu') < 1) -> MessageBox / Return .f.
    *   4. index on usuarios tag usuarios / set near on
    *      if not seek(this.value) -> fwBuscaSel('tmpusu','usuarios',...)
    *   5. thisform.usulibs = this.value
    *   6. If IsEmpty(usual) -> zsen = .F. / release
    *      Else If lastkey() <> 27
    *              If IsEmpty(TmpUsu.senhas) -> autoriza na hora, esconde a
    *                                           linha da senha e fecha
    *              Else -> mostra a linha da senha e espera
    *
    * Os passos 2 e 3 moram no BO (MontarQueryUsuarios /
    * CarregarUsuariosAutorizados): a escolha de QUAL permissao de cargo
    * sera exigida eh regra de negocio, e eh no BO que vivem as 21 flags de
    * liberacao que ConfigurarPorTipo() liga.
    *
    * TRES desvios deliberados, todos documentados:
    *
    * (1) O "index on usuarios tag usuarios" + "set near on" + "seek" do
    *     legado vira LOCALIZACAO POR PREFIXO em LocalizarUsuario(): cursor
    *     de SQL pass-through eh somente-leitura (nao aceita INDEX ON) e,
    *     com o SET EXACT ON que o sistema novo liga no startup, SEEK
    *     exigiria a chave inteira e o codigo parcial nunca casaria - o
    *     oposto do legado, onde o seek casava prefixo.
    *
    * (2) O legado, DEPOIS do picker, faz "this.value = evaluate('usuarios')"
    *     INCONDICIONALMENTE: com o picker cancelado o campo recebe o codigo
    *     do registro em que o SET NEAR ON deixou o cursor, isto eh, o
    *     usuario digita um codigo, desiste da lista e o campo volta
    *     preenchido com OUTRO usuario. Aqui o codigo eh gravado apenas
    *     quando houve selecao de fato (regras #37 e #50: nunca escrever nem
    *     APAGAR o campo quando o picker nao devolveu nada). O desfecho do
    *     cancelamento eh o mesmo do legado - nao autoriza e o dialogo
    *     continua aberto -, sem a troca de valor nas costas do usuario.
    *
    * (3) O "zsen = fCriptografar(TmpUsu.senhas)" do legado NAO eh
    *     transcrito aqui. Esse zsen eh uma variavel GLOBAL solta (nao
    *     ThisForm.ZSen) que o Valid do campo senha sobrescreve antes de
    *     qualquer uso - a unica decisao tomada neste ponto eh
    *     IsEmpty(TmpUsu.senhas). Como fCriptografar nao foi portada
    *     (achado (1) do cabecalho do BO), transcrever a linha morta faria a
    *     tela estourar na resolucao de TODO usuario, inclusive dos que nem
    *     chegam a digitar senha. A chamada que importa fica no fluxo de
    *     conferencia da senha, onde a ausencia da funcao tem de ficar
    *     VISIVEL em vez de virar stub que autentica errado em silencio.
    *
    * Lista de autorizados VAZIA encerra o dialogo NEGANDO, sem mensagem -
    * eh o desfecho do legado (cursor vazio -> usual vazio -> zsen = .F. +
    * release). Nao se trata de "nada encontrado" no sentido da regra #50
    * (ali o universo vazio eh um lookup que nao deve bloquear digitacao):
    * aqui nao existe NENHUM usuario habilitado a conceder esta liberacao,
    * entao nao ha o que o usuario possa digitar para prosseguir.
    *
    * Sem RETURN dentro do TRY (regra #1): os caminhos internos usam
    * loc_lProsseguir e o unico RETURN fica depois do ENDTRY. Os RETURN dos
    * guards estao ANTES do TRY, fora do bloco.
    *
    * PUBLIC: chamado pelo wrapper e pelos testes do harness.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioLostFocusExec()
        LOCAL loc_oBO, loc_cValor, loc_cCursor, loc_lProsseguir, loc_lAchou, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            RETURN
        ENDIF

        loc_cValor = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))

        *-- Legado: If Empty(This.Value) -> ZSen = .f. / ThisForm.Release
        IF EMPTY(loc_cValor)
            THIS.this_lZSen    = .F.
            loc_oBO.this_lZSen = .F.
            THIS.FecharDialogo()
            RETURN
        ENDIF

        *-- Guard de valor-nao-mudou: o Valid legado roda ao sair do campo;
        *-- o LostFocus roda em toda perda de foco, inclusive na volta do
        *-- proprio picker (ver this_cUltimoUsuarioValidado)
        IF loc_cValor == THIS.this_cUltimoUsuarioValidado
            RETURN
        ENDIF

        loc_lProsseguir = .T.
        loc_lAchou      = .F.
        loc_cCursor     = loc_oBO.this_cCursorUsuarios

        TRY
            *-- Passos 2 e 3 do legado (Do Case + SqlExecute em TmpUsu)
            IF !loc_oBO.CarregarUsuariosAutorizados()
                MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
                    "Favor Reinicializar o Processo!!!", loc_oBO.this_cMensagemErro), ;
                    "Falha na Conex" + CHR(227) + "o (TmpUsu)")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cCursor = loc_oBO.this_cCursorUsuarios
                loc_lAchou  = THIS.LocalizarUsuario(loc_cValor)

                *-- Legado: if not seek(this.value) -> abre o fwBuscaSel
                IF !loc_lAchou
                    IF THIS.AbrirBuscaUsuario()
                        loc_cValor = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
                        loc_lAchou = THIS.LocalizarUsuario(loc_cValor)
                    ENDIF
                ENDIF

                THIS.this_cUltimoUsuarioValidado = loc_cValor

                *-- Legado: thisform.usulibs = this.value
                THIS.this_cUsuLibs    = loc_cValor
                loc_oBO.this_cUsuLibs = loc_cValor
                loc_oBO.this_cUsuario = loc_cValor

                DO CASE
                    CASE loc_lAchou
                        *-- Le a linha do usuario resolvido (usuarios /
                        *-- senhas / ccargs / cativos) para as properties
                        loc_oBO.CarregarDoCursor(loc_cCursor)

                        IF EMPTY(ALLTRIM(loc_oBO.this_cSenhaCadastrada))
                            *-- Legado: If IsEmpty(TmpUsu.senhas) -> zsen = .t.
                            *-- say3/senha invisiveis + release
                            loc_oBO.this_lExigeSenha   = .F.
                            THIS.lbl_4c_Label3.Visible = .F.
                            THIS.txt_4c_Senha.Visible  = .F.
                            THIS.this_lZSen            = .T.
                            loc_oBO.this_lZSen         = .T.
                            THIS.FecharDialogo()
                        ELSE
                            *-- Legado: Else -> say3/senha visiveis e espera
                            loc_oBO.this_lExigeSenha   = .T.
                            THIS.lbl_4c_Label3.Visible = .T.
                            THIS.txt_4c_Senha.Visible  = .T.
                        ENDIF

                    CASE !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                        *-- Nenhum usuario habilitado a conceder esta
                        *-- liberacao: nega e encerra (cursor vazio no legado
                        *-- deixava "usual" vazio -> zsen = .F. + release).
                        *-- usulibs volta a vazio porque no legado ele recebia
                        *-- o "this.value" lido do cursor VAZIO: dialogo
                        *-- recusado nao devolve nome de liberador.
                        THIS.this_cUsuLibs    = ""
                        loc_oBO.this_cUsuLibs = ""
                        THIS.this_lZSen       = .F.
                        loc_oBO.this_lZSen    = .F.
                        THIS.FecharDialogo()

                    OTHERWISE
                        *-- Picker dispensado sem selecionar: nao autoriza e
                        *-- o dialogo segue aberto, com o que o usuario
                        *-- digitou PRESERVADO no campo (regras #37 e #50)
                        THIS.this_lZSen    = .F.
                        loc_oBO.this_lZSen = .F.
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao validar o usu" + CHR(225) + "rio")
        ENDTRY

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioKeyPress - KeyPress do campo usuario legado:
    *
    *   If (Lastkey() = 27) And Empty(This.Value)
    *       ZSen = .f. / ThisForm.ZSen = .f. / ThisForm.Release
    *   EndIf
    *
    * ESC com o campo em branco eh a saida do dialogo NEGANDO a liberacao -
    * esta tela nao tem botao algum, e este eh o unico caminho de
    * cancelamento junto com o campo deixado vazio.
    *
    * F4 eh a entrada ADICIONAL do picker (convencao do projeto). Ela chama
    * AbrirBuscaUsuario() DIRETO em vez de delegar ao funil do LostFocus:
    * o funil comeca testando "campo vazio -> encerra o dialogo", e F4 com o
    * campo em branco tem de ABRIR A LISTA, nao fechar a tela.
    *
    * A guarda de reentrancia aqui eh SAVE/RESTORE, nao set/clear: este
    * handler pode ser alcancado de dentro de um fluxo que ja ligou a flag,
    * e um clear simples a liberaria cedo demais (regra #47).
    *
    * Nenhuma outra tecla eh interceptada: o DO CASE sem OTHERWISE deixa a
    * digitacao seguir normalmente.
    *
    * LPARAMETERS obrigatorio - handler de KeyPress sem os parametros do
    * evento estoura a cada tecla (regra #3).
    *
    * PUBLIC: exigencia do BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt

        IF PCOUNT() < 1 OR VARTYPE(par_nKeyCode) != "N"
            RETURN
        ENDIF

        DO CASE
            CASE par_nKeyCode = 27
                IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))
                    THIS.this_lZSen = .F.

                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.this_lZSen = .F.
                    ENDIF

                    THIS.FecharDialogo()
                ENDIF

            CASE par_nKeyCode = 115
                loc_lEmLookupAnt           = THIS.this_lEmLookupUsuario
                THIS.this_lEmLookupUsuario = .T.
                THIS.AbrirBuscaUsuario()
                THIS.this_lEmLookupUsuario = loc_lEmLookupAnt
        ENDCASE

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioDblClick - Terceira entrada do mesmo picker, pela convencao do
    * projeto (duplo clique no campo com lookup). Aditiva, como o F4.
    *
    * Guarda SAVE/RESTORE pelo mesmo motivo do UsuarioKeyPress.
    *
    * PUBLIC: exigencia do BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioDblClick()
        LOCAL loc_lEmLookupAnt

        loc_lEmLookupAnt           = THIS.this_lEmLookupUsuario
        THIS.this_lEmLookupUsuario = .T.
        THIS.AbrirBuscaUsuario()
        THIS.this_lEmLookupUsuario = loc_lEmLookupAnt

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuario - Picker de selecao do usuario autorizado.
    *
    * Legado (dentro do Valid do campo usuario):
    *   xBrow    = CreateObject('fwBuscaSel','tmpusu','usuarios',this.value,'Selecao')
    *   xBrowCol = xBrow.AddColuna('usuarios','','Codigo',.t.,'usuarios')
    *   xBrowCol = xBrow.AddColuna('ccargs','','cargo',.F.)
    *   xBrow.Show
    *
    * fwBuscaSel busca num CURSOR LOCAL ja carregado, nao numa tabela do
    * servidor - no sistema novo isso eh o FormBuscaAuxiliar pela API
    * DefinirCursor/Mostrar, que exibe o cursor como ele esta e NAO dispara
    * consulta propria. A API alternativa (CREATEOBJECT com parametros)
    * seria errada aqui: ela monta um SELECT na tabela, e o universo desta
    * busca nao eh "todos os usuarios", eh "os usuarios que podem conceder
    * ESTA liberacao" - a consulta filtrada que o BO acabou de rodar.
    *
    * As legendas das duas colunas sao as do legado ("Codigo" e "cargo",
    * esta em minuscula como escrita la). DefinirCursor cria as duas colunas
    * usando o NOME do campo como titulo, por isso os titulos sao
    * reescritos em seguida em this_aColunas[n, 3].
    *
    * F4/DblClick podem chegar antes de qualquer LostFocus, com o cursor
    * ainda inexistente: nesse caso a lista eh carregada aqui. Pelo caminho
    * do LostFocus ela ja esta carregada e nenhuma consulta eh repetida.
    *
    * Lista vazia nao abre picker vazio (regra #36): devolve .F. e quem
    * chamou decide - pelo LostFocus isso cai no ramo que nega a liberacao e
    * encerra o dialogo, como no legado.
    *
    * O valor eh gravado no campo SOMENTE quando houve selecao, e o codigo
    * digitado NUNCA eh apagado quando nao houve (regras #37 e #50).
    *
    * Release() ao final, depois de ler o resultado: FormBuscaAuxiliar fecha
    * com Hide() justamente para o chamador poder ler as properties.
    *
    * PUBLIC: eh o funil do lookup, chamado pelo LostFocus, pelo F4 e pelo
    * DblClick.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaUsuario()
        LOCAL loc_oBO, loc_oBusca, loc_cCursor, loc_lSelecionou

        loc_lSelecionou = .F.
        loc_oBO         = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorUsuarios

        *-- Entrada por F4/DblClick: a lista ainda pode nao ter sido carregada
        IF !USED(loc_cCursor)
            IF !loc_oBO.CarregarUsuariosAutorizados()
                MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
                    "Favor Reinicializar o Processo!!!", loc_oBO.this_cMensagemErro), ;
                    "Falha na Conex" + CHR(227) + "o (TmpUsu)")
                RETURN .F.
            ENDIF
        ENDIF

        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
            RETURN .F.
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.DefinirCursor(loc_cCursor, "usuarios", "ccargs", ;
                "Sele" + CHR(231) + CHR(227) + "o")
            loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
            loc_oBusca.this_aColunas[2, 3] = "cargo"

            IF loc_oBusca.Mostrar()
                THIS.txt_4c_Usuario.Value = loc_oBusca.cCodigoSelecionado
                THIS.txt_4c_Usuario.Refresh()
                loc_lSelecionou = .T.
            ENDIF

            loc_oBusca.Release()
        ENDIF

        RETURN loc_lSelecionou
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarUsuario - Equivalente do "seek(this.value)" legado sobre o
    * cursor de usuarios autorizados, posicionando-o na linha encontrada
    * (quem chama le o registro corrente depois).
    *
    * Por que LOCATE e nao SEEK: o cursor vem de SQL pass-through e eh
    * somente-leitura, logo nao aceita o "index on usuarios tag usuarios" do
    * legado; e o sistema novo liga SET EXACT ON no startup, com o que SEEK
    * passaria a exigir a chave INTEIRA e um codigo parcial nunca casaria -
    * o contrario do legado, onde o seek casava PREFIXO. O teste explicito
    * UPPER(LEFT(usuarios, LEN(valor))) == valor reproduz esse prefixo e nao
    * depende de SET EXACT nem de SET NEAR.
    *
    * A ordenacao da lista, que no legado vinha do indice, vem do ORDER BY
    * da consulta montada pelo BO.
    *
    * PUBLIC: usado pelo fluxo de validacao e pelos testes do harness.
    *--------------------------------------------------------------------------
    PROCEDURE LocalizarUsuario(par_cValor)
        LOCAL loc_oBO, loc_cCursor, loc_cValor

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorUsuarios

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        loc_cValor = UPPER(ALLTRIM(NVL(par_cValor, "")))

        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR UPPER(LEFT(usuarios, LEN(m.loc_cValor))) == m.loc_cValor

        RETURN FOUND(loc_cCursor)
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaLostFocus - Equivalente ao Valid do campo senha legado, que eh o
    * fluxo de ACAO desta tela: eh aqui que a liberacao eh concedida ou
    * recusada.
    *
    * WRAPPER FINO, so para a guarda de reentrancia, pelo mesmo desenho do
    * UsuarioLostFocus: o corpo tem RETURN antecipado em varios caminhos
    * (campo de senha oculto, senha ja conferida, usuario nao resolvido) e,
    * com set/clear no proprio corpo, qualquer um desses RETURN deixaria a
    * flag LIGADA para sempre - e dai a senha nunca mais seria conferida e o
    * gate ficaria impossivel de passar (regra #47). O wrapper libera a flag
    * em UMA linha que nenhum RETURN do corpo consegue pular.
    *
    * A reentrancia eh real: o corpo pode exibir o dialogo "Deseja digitar
    * novamente ?", que eh MODAL, tira o foco do campo senha e faz o proprio
    * LostFocus disparar de novo - sem a guarda a mesma senha seria
    * conferida em cascata e o usuario levaria o dialogo repetido (regra
    * #37).
    *
    * this_lDialogoEncerrado barra a passada que acontece DEPOIS do Hide():
    * esconder a janela faz o campo com foco perder o foco, e a conferencia
    * nao pode rodar de novo depois de a resposta ter sido publicada em
    * this_cRetorno / this_lZSen.
    *
    * PUBLIC: BINDEVENT so funciona com metodo PUBLIC - PROTECTED falha em
    * silencio (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE SenhaLostFocus()
        IF THIS.this_lEmValidacaoSenha OR THIS.this_lDialogoEncerrado
            RETURN
        ENDIF

        THIS.this_lEmValidacaoSenha = .T.
        THIS.SenhaLostFocusExec()
        THIS.this_lEmValidacaoSenha = .F.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaLostFocusExec - Corpo do Valid do campo senha legado.
    *
    * A regra de negocio inteira (as duas consultas, a baixa da senha livre,
    * a escolha entre senha cadastrada e senha do dia, as duas formas de
    * comparar e o log) esta no BO, em ConferirSenha(). O que fica aqui eh o
    * que eh decisao de TELA:
    *
    *   1. de onde vem a senha digitada (o campo) e para onde ela vai (o BO)
    *   2. o dialogo "Deseja digitar novamente ? (S/N)" do legado
    *   3. para onde volta o foco quando o usuario quer redigitar
    *   4. fechar o dialogo publicando o resultado
    *
    * Desfechos do legado, na mesma ordem:
    *
    *   autorizado           -> Thisform.zsen = .T. / Thisform.release
    *   senha conflitante    -> if messagebox('Deseja digitar novamente ? (S/N)',
    *                              4+256, 'Senha Conflitante...') = 7
    *                              thisform.zsen=.F. / thisform.release
    *                           else
    *                              return 0       && NAO deixa sair do campo
    *                           endif
    *
    * O "return 0" do legado eh o Valid recusando a saida do campo: a tela
    * fica aberta, o texto digitado PERMANECE (o legado nao limpa o campo) e
    * o foco volta para a senha. Reproduzido por SetFocus() no campo mais a
    * limpeza do guard this_cUltimaSenhaValidada - sem limpar o guard, a
    * segunda tentativa com a MESMA senha nao seria reconferida e o usuario
    * conseguiria sair do campo sem resposta, que eh justamente o que o
    * "return 0" impede.
    *
    * Guard do campo OCULTO: quando o usuario resolvido nao tem senha
    * cadastrada, o fluxo do campo usuario esconde rotulo e campo de senha e
    * ja encerra o dialogo autorizando (IsEmpty(TmpUsu.senhas) do legado).
    * Conferir senha de um campo que a tela escondeu converteria essa
    * liberacao em conflito.
    *
    * Guard do USUARIO em branco: o legado so alcanca o Valid da senha com o
    * usuario resolvido - campo de usuario vazio encerra o dialogo no
    * proprio fluxo do usuario. Sem este guard, tabular pela senha antes de
    * informar o usuario dispararia uma conferencia contra usuario nenhum.
    *
    * FALHA TECNICA (conexao caida, ou fCriptografar/fGerPswDiario ausentes)
    * nao eh "senha errada": ela vem do BO com this_lRedigitarSenha
    * DESLIGADO e this_cMensagemErro preenchido. Nesse caso a tela mostra a
    * causa real e FECHA NEGANDO - gate de autorizacao falha FECHADO, e
    * oferecer "digitar novamente" so prenderia o usuario num ciclo de erros
    * que redigitar nao resolve.
    *--------------------------------------------------------------------------
    PROCEDURE SenhaLostFocusExec()
        LOCAL loc_oBO, loc_cSenha, loc_cUsuario, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "txt_4c_Senha", 5) ;
                OR !PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            RETURN
        ENDIF

        *-- Campo escondido pelo fluxo do usuario: liberacao sem senha
        IF !THIS.txt_4c_Senha.Visible
            RETURN
        ENDIF

        loc_cSenha = NVL(THIS.txt_4c_Senha.Value, "")

        IF VARTYPE(loc_cSenha) != "C"
            loc_cSenha = ""
        ENDIF

        *-- Guard de valor-nao-mudou: o Valid legado roda ao sair do campo;
        *-- o LostFocus roda em TODA perda de foco, inclusive na volta do
        *-- dialogo de conflito (ver this_cUltimaSenhaValidada)
        IF loc_cSenha == THIS.this_cUltimaSenhaValidada
            RETURN
        ENDIF

        loc_cUsuario = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))

        IF EMPTY(loc_cUsuario)
            RETURN
        ENDIF

        THIS.this_cUltimaSenhaValidada = loc_cSenha

        TRY
            *-- Leva usuario e senha da tela para o BO antes de conferir
            THIS.FormParaBO()

            IF loc_oBO.ConferirSenha(loc_cSenha)
                *-- Legado: Thisform.zsen = .T. / Thisform.release
                THIS.this_lZSen    = .T.
                THIS.this_cUsuLibs = loc_oBO.this_cUsuLibs
                THIS.FecharDialogo()
            ELSE
                DO CASE
                    CASE loc_oBO.this_lRedigitarSenha
                        *-- Senha conflitante: a pergunta do legado
                        IF THIS.ConfirmarRedigitacaoSenha()
                            *-- "return 0" do legado: tela aberta, texto
                            *-- preservado e foco de volta na senha
                            THIS.this_cUltimaSenhaValidada = "@@SEM VALIDACAO@@"
                            THIS.BOParaForm()
                            THIS.txt_4c_Senha.SetFocus()
                        ELSE
                            *-- Resposta "Nao": nega e encerra
                            THIS.this_lZSen    = .F.
                            loc_oBO.this_lZSen = .F.
                            THIS.FecharDialogo()
                        ENDIF

                    OTHERWISE
                        *-- Falha tecnica: nega, mostra a causa e encerra
                        THIS.this_cMensagemErro = NVL(loc_oBO.this_cMensagemErro, "")

                        MsgErro(IIF(EMPTY(ALLTRIM(THIS.this_cMensagemErro)), ;
                            "Favor Reinicializar o Processo!!!", THIS.this_cMensagemErro), ;
                            "Falha na Conex" + CHR(227) + "o")

                        THIS.this_lZSen    = .F.
                        loc_oBO.this_lZSen = .F.
                        THIS.FecharDialogo()
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            *-- Gate de autorizacao: erro inesperado NEGA a liberacao
            THIS.this_lZSen    = .F.
            loc_oBO.this_lZSen = .F.

            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao conferir a senha")
        ENDTRY

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarRedigitacaoSenha - O dialogo do ramo de conflito do legado:
    *
    *   if messagebox('Deseja digitar novamente ? (S/N)', 4+256,
    *                 'Senha Conflitante...' ) = 7
    *
    * Devolve .T. quando o usuario quer DIGITAR DE NOVO e .F. quando
    * desiste (o 7 do legado eh o "Nao").
    *
    * MsgConfirma eh a funcao canonica do projeto para Sim/Nao e devolve
    * LOGICAL, nao numerico (regra #7) - MESSAGEBOX direto eh proibido.
    *
    * Duas diferencas em relacao ao MESSAGEBOX legado, as duas sem efeito
    * sobre o desfecho:
    *   - MsgConfirma usa 36 (Sim/Nao + icone de pergunta) onde o legado usa
    *     4+256 (Sim/Nao + segundo botao como default), entao muda o icone e
    *     qual botao nasce com foco;
    *   - em modo de teste automatizado MsgConfirma grava a pergunta em
    *     arquivo e devolve .F. sem abrir dialogo, o que aqui significa
    *     "desistir" - FAIL-CLOSED, o unico desfecho aceitavel para um gate
    *     de autorizacao rodando sem ninguem na frente da tela.
    *
    * O texto vai transcrito do legado, com os acentos em CHR() (regra #4).
    *
    * PUBLIC: usado pelo fluxo de conferencia e pelos testes do harness.
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarRedigitacaoSenha()
        LOCAL loc_lRedigitar

        loc_lRedigitar = MsgConfirma("Deseja digitar novamente ? (S/N)", ;
            "Senha Conflitante...")

        RETURN loc_lRedigitar
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Leva para o BO o conteudo dos campos da tela.
    *
    * Esta tela tem DOIS campos editaveis, e os dois entram aqui:
    *   txt_4c_Usuario -> this_cUsuario  (SigCdUsu.usuarios char(10))
    *   txt_4c_Senha   -> this_cSenha    (conferida contra SigCdUsu.senhas
    *                                     char(10) ou contra a senha do dia)
    *
    * Nao existe terceiro campo a mapear: os demais objetos da tela sao
    * rotulos, a faixa do cabecalho e o icone. Tudo o mais que o BO precisa
    * (tipo, documento, data, empresa, forma de pagamento, valor) nao vem de
    * campo da tela e sim dos PARAMETROS do chamador, repassados uma vez por
    * ConfigurarParametrosBO().
    *
    * O usuario sobe em UPPER+ALLTRIM porque eh assim que o legado o usa na
    * consulta ("usual = upper(usual)"); a senha sobe CRUA, sem UPPER e sem
    * ALLTRIM, porque a comparacao da senha cadastrada eh
    * "Padr(this.value,10) # Padr(senha,10)" - posicional nos 10 caracteres -
    * e trimar ou mudar a caixa aqui mudaria o resultado da comparacao. A
    * caixa alta que o usuario ve vem do InputMask "!!!!!!!!!!" do campo, que
    * eh do legado.
    *
    * this_cUsuLibs NAO eh tocado aqui: quem o resolve eh o fluxo do campo
    * usuario (o "thisform.usulibs = this.value" do legado) ou, nos tipos de
    * senha do dia, o Init atraves de AvaliarSenhaDoDia() - e, no desfecho
    * desse caminho, o proprio ConferirSenha(), que grava nele a senha
    * gerada. Reescrever usulibs a cada transferencia de tela apagaria essas
    * tres resolucoes.
    *
    * PROTECTED: FormParaBO eh hook PROTECTED de FormBase, e subclasse NAO
    * alarga escopo - declarar PUBLIC aqui nao tornaria o metodo chamavel de
    * fora, so divergiria da base (regra #51). Chamado sempre com THIS.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_uValor, loc_lResultado

        loc_lResultado = .F.
        loc_oBO        = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        *-- Usuario que concede a liberacao
        IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            loc_uValor = NVL(THIS.txt_4c_Usuario.Value, "")
            loc_oBO.this_cUsuario = IIF(VARTYPE(loc_uValor) = "C", ;
                UPPER(ALLTRIM(loc_uValor)), "")
        ENDIF

        *-- Senha digitada (CRUA - a comparacao legado eh posicional)
        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            loc_uValor = NVL(THIS.txt_4c_Senha.Value, "")
            loc_oBO.this_cSenha = IIF(VARTYPE(loc_uValor) = "C", loc_uValor, "")
        ENDIF

        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Reflete na tela o estado que o BO mantem.
    *
    * Caminho inverso do FormParaBO, com os mesmos dois campos mais o que o
    * legado altera em runtime a partir do estado do dialogo:
    *
    *   this_cUsuario   -> txt_4c_Usuario.Value
    *   this_cFrase     -> lbl_4c_Frase.Caption   (Frase do legado, resolvida
    *                      pelo tipo da liberacao em ConfigurarPorTipo)
    *   this_lExigeSenha-> lbl_4c_Label3.Visible / txt_4c_Senha.Visible
    *                      (o "thisform.say3.visible / senha.visible" que o
    *                      Valid do usuario legado liga e desliga conforme o
    *                      usuario ter ou nao senha cadastrada)
    *
    * O campo SENHA nao recebe valor de volta: o legado nunca escreve nele,
    * e repintar a senha a partir de property transformaria o guard de
    * "valor nao mudou" numa reconferencia em cascata.
    *
    * Fecha aplicando o estado de habilitacao por HabilitarCampos(), para
    * que exista UM ponto so decidindo o que esta editavel.
    *
    * Chamado em tres momentos: no fim da inicializacao (para a tela nascer
    * coerente com o BO), no caminho de redigitar senha e, por heranca, pelo
    * Cancelar() de FormBase.
    *
    * PROTECTED: hook PROTECTED de FormBase, como o FormParaBO (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_cUsuario, loc_lResultado

        loc_lResultado = .F.
        loc_oBO        = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            loc_cUsuario = NVL(loc_oBO.this_cUsuario, "")
            THIS.txt_4c_Usuario.Value = IIF(VARTYPE(loc_cUsuario) = "C", loc_cUsuario, "")
        ENDIF

        *-- Frase que explica a liberacao pedida
        IF PEMSTATUS(THIS, "lbl_4c_Frase", 5)
            THIS.this_cFrase = NVL(loc_oBO.this_cFrase, "")

            IF VARTYPE(THIS.this_cFrase) != "C"
                THIS.this_cFrase = ""
            ENDIF

            THIS.lbl_4c_Frase.Caption = THIS.this_cFrase
        ENDIF

        *-- Linha da senha: o legado a esconde quando o usuario resolvido
        *-- nao tem senha cadastrada
        IF PEMSTATUS(THIS, "lbl_4c_Label3", 5)
            THIS.lbl_4c_Label3.Visible = loc_oBO.this_lExigeSenha
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            THIS.txt_4c_Senha.Visible = loc_oBO.this_lExigeSenha
        ENDIF

        *-- Dialogo ja resolvido nao aceita mais digitacao
        THIS.HabilitarCampos(!THIS.this_lDialogoEncerrado)

        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Ponto UNICO que decide o que esta editavel na tela.
    *
    * par_lHabilitar = .F. tranca os dois campos; .T. devolve cada um ao
    * estado que o legado lhe da:
    *
    *   txt_4c_Usuario - o When do campo usuario legado, calculado por
    *       UsuarioEditavel(). O When nao pode ser ligado por BINDEVENT (o
    *       bind descarta o retorno do delegate e o gate nao bloquearia
    *       nada), e reproduzi-lo por Enabled eh o que o projeto ja faz.
    *       Habilitar nao pode IGNORAR esse gate: nos tipos de senha do dia
    *       o campo nasce travado com o usuario logado, e destrava-lo
    *       deixaria o usuario pedir liberacao em nome de outra pessoa.
    *
    *   txt_4c_Senha - editavel enquanto a tela exigir senha
    *       (this_lExigeSenha). Campo de senha que a tela escondeu nao volta
    *       habilitado.
    *
    * Chamado por BOParaForm, que eh o unico lugar que aplica estado de tela
    * - assim nao existem duas regras de habilitacao divergindo.
    *
    * PUBLIC: nao eh hook de FormBase, e o chamador do dialogo (ou o harness)
    * pode precisar trancar a tela por conta propria.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oBO, loc_lExigeSenha

        loc_lHabilitar = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", ;
            par_lHabilitar, .T.)

        loc_oBO        = THIS.this_oBusinessObject
        loc_lExigeSenha = IIF(VARTYPE(loc_oBO) = "O", loc_oBO.this_lExigeSenha, .T.)

        IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            THIS.txt_4c_Usuario.Enabled = loc_lHabilitar AND THIS.UsuarioEditavel()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            THIS.txt_4c_Senha.Enabled = loc_lHabilitar AND loc_lExigeSenha
        ENDIF

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Devolve a tela ao estado de "nada informado".
    *
    * Hook PROTECTED de FormBase, chamado por FormBase.Novo(). Nesta tela ele
    * nao tem equivalente no legado (o dialogo vive UM gate e fecha), mas a
    * implementacao herdada nao serve: ela eh vazia, e deixar os guards de
    * validacao apontando para os valores antigos faria a tela aceitar sair
    * dos campos sem reconferir nada - o oposto do que um gate de
    * autorizacao precisa.
    *
    * Limpa os DOIS campos e, junto com eles, os DOIS guards de
    * valor-nao-mudou, que sao estado de validacao e nao de dado: sem
    * devolve-los ao sentinela, o proximo valor digitado poderia casar com o
    * guard e pular a conferencia. O sentinela eh mais longo que as colunas
    * (char(10) nas duas), entao nenhum valor digitavel casa com ele.
    *
    * NAO mexe em this_lZSen nem em this_cUsuLibs: esses sao a RESPOSTA do
    * dialogo, lida pelo chamador depois do Show(), e limpa-los aqui poderia
    * apagar uma autorizacao ja concedida.
    *
    * PROTECTED: hook PROTECTED de FormBase (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Usuario", 5)
            THIS.txt_4c_Usuario.Value = ""
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            THIS.txt_4c_Senha.Value = ""
        ENDIF

        THIS.this_cUltimoUsuarioValidado = "@@SEM VALIDACAO@@"
        THIS.this_cUltimaSenhaValidada   = "@@SEM VALIDACAO@@"

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarRetorno - Expressao do Unload legado:
    *
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    *
    * Autorizado devolve "*" seguido do usuario que liberou; recusado devolve
    * um espaco no lugar do asterisco. O chamador do legado recebia isso em
    * "DO FORM ... TO var"; aqui o resultado eh publicado em this_cRetorno e
    * tambem devolvido, para o chamador poder ler de qualquer um dos dois
    * jeitos depois do Show().
    *
    * O estado vem do BO quando ele existe (eh ele que conclui a conferencia da
    * senha) e espelha nas properties do form, que sao o que o chamador le.
    *
    * PUBLIC: eh o canal de resposta do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE MontarRetorno()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_lZSen    = THIS.this_oBusinessObject.this_lZSen
            THIS.this_cUsuLibs = THIS.this_oBusinessObject.this_cUsuLibs
        ENDIF

        THIS.this_cRetorno = IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cRetorno = THIS.this_cRetorno
        ENDIF

        RETURN THIS.this_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - o "ThisForm.Release" do legado, com UMA divergencia
    * deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no projeto: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * a leitura seguinte estoura "is not an object". Esta tela existe para
    * DEVOLVER uma autorizacao, e no legado essa resposta chega por outro
    * caminho: o Unload alimenta o "DO FORM ... TO var" do chamador. Esse canal
    * nao existe no sistema novo, que abre o dialogo com CREATEOBJECT + Show()
    * e le o resultado numa property - entao fechar com Release() aqui
    * destruiria o form antes de o chamador conseguir ler this_lZSen, e o gate
    * de autorizacao ficaria sem como responder.
    *
    * O retorno eh montado ANTES de esconder a tela, para que a resposta esteja
    * publicada no instante em que o Show() devolve o controle ao chamador.
    *
    * Hide() em form modal tambem devolve o Show(), portanto para o usuario a
    * tela fecha igual (PILAR 1 preservado); muda so o tempo de vida do objeto,
    * que eh PILAR 3. Cabe ao CHAMADOR chamar Release() depois de ler (ver o
    * bloco "Uso" do cabecalho). Mesmo desenho que o FormBuscaAuxiliar do
    * projeto ja adota.
    *
    * PUBLIC: eh o unico ponto de fechamento da tela, e o chamador pode
    * precisar fecha-la por conta propria.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.MontarRetorno()

        *-- Marca o dialogo como encerrado ANTES do Hide(): esconder a
        *-- janela faz o campo com foco disparar LostFocus, e a validacao do
        *-- usuario nao pode rodar de novo depois de a resposta ter sido
        *-- publicada em this_cRetorno/this_lZSen.
        THIS.this_lDialogoEncerrado = .T.

        THIS.Hide()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis os controles criados por
    * AddObject, que nascem com Visible = .F.
    *
    * O SCX legado declara Visible = .T. explicito em Say3 e senha, e nao
    * declara Visible = .F. em objeto nenhum - nao ha, portanto, controle que
    * deva nascer oculto nesta tela, e nao existe lista de excecao. Os dois
    * campos de senha SAO escondidos em runtime (o Valid do usuario faz
    * thisform.say3.visible=.f. quando o usuario nao tem senha cadastrada), mas
    * isso acontece DEPOIS da abertura, dentro do fluxo de conferencia.
    *
    * NAO recursa dentro de Grid: os "controles" de um Grid sao as Columns, e a
    * visibilidade delas eh gerenciada pelo proprio VFP a partir do
    * ColumnCount - mexer nisso de fora so cria divergencia com o bind.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
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
    * Destroy - Fecha os cursores de trabalho e libera o BO.
    *
    * Legado: ThisForm.poDataMgr.Release + =DoDefault()
    *
    * Os cursores sao os declarados pelo BO (usuarios autorizados, releitura
    * da senha do usuario, os dois de parametro, senha livre, empresa e forma
    * de pagamento). O cursor do MOVIMENTO
    * (TprMvCab) NAO eh fechado aqui: ele pertence ao form CHAMADOR, que abriu
    * esta tela, e fecha-lo deixaria o chamador sem os dados dele depois da
    * autorizacao.
    *
    * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
    * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
    * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
    * existe para o caso em que o buffer de fato tenha algo a descartar).
    *
    * O retorno eh montado antes de soltar o BO - eh a ultima chance de
    * publicar a resposta, caso a tela seja destruida sem passar por
    * FecharDialogo.
    *
    * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
    * restaura os popups do menu principal depois de um form modal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_cCursor
        LOCAL ARRAY loc_aCursores[7]

        THIS.MontarRetorno()

        loc_aCursores[1] = "cursor_4c_Usuarios"
        loc_aCursores[2] = "cursor_4c_Param"
        loc_aCursores[3] = "cursor_4c_Parac"
        loc_aCursores[4] = "cursor_4c_SenhaLivre"
        loc_aCursores[5] = "cursor_4c_Empresa"
        loc_aCursores[6] = "cursor_4c_Fpagto"
        loc_aCursores[7] = "cursor_4c_SenhaUsuario"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cCursor = loc_aCursores[loc_nI]

            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
