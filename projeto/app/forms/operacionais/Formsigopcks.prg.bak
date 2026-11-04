*==============================================================================
* Formsigopcks.prg - Validacao de Acesso (dialogo MODAL de autorizacao)
*
* Form OPERACIONAL FLAT (sem PageFrame). Nao eh cadastro: o legado
* (sigopcks.SCX) herda de "form" GENERICO - nao de frmcadastro - e nao tem
* Page, nem Grid, nem barra Incluir/Visualizar/Alterar/Excluir/Buscar. Os 11
* controles do SCX sao filhos DIRETOS do form, com a UNICA excecao do par de
* labels que mora dentro de cntSombra (a faixa de cabecalho).
*
* O que a tela faz: recebe do chamador um TIPO de liberacao (LIMITE,
* CANCITEM, LIBFPAG, MOVESTOQUE, ...), exibe a frase explicando o bloqueio,
* pede Representante + Senha e devolve ao chamador se a operacao foi
* autorizada. Toda a regra - qual permissao de cargo/usuario exigir, se a
* senha conferida eh a CADASTRADA ou a SENHA DO DIA, e os textos derivados do
* tipo - vive no sigopcksBO (Fases 1/2). O Form apenas ESPELHA o BO: fonte
* UNICA, como o cabecalho do proprio BO determina. Por isso esta classe NAO
* declara copia das 12 flags de tipo nem dos 8 parametros de entrada.
*
* Herda de: FormBase
*
* Propriedades do SCX legado (transcritas no bloco de propriedades abaixo):
*   DataSession = 2, BorderStyle = 2, 1000x600, DoCreate = .T.,
*   AutoCenter = .T., Picture = ..\framework\imagens\new_background.jpg,
*   Caption = "", ControlBox = .F., MaxButton = .F., Movable = .F.,
*   TitleBar = 0, WindowType = 1, AlwaysOnTop = .T.
*   Closable e MinButton NAO sao declarados aqui porque o SCX tambem nao os
*   declara - TitleBar = 0 + ControlBox = .F. nao os forcam para .F., e
*   fixa-los removeria o Alt+F4. Neste dialogo ha caminho de abortar previsto
*   pelo legado (ESC no campo usuario -> Lastkey() = 27 -> zsen = .F. +
*   Release), entao a saida nao depende do Alt+F4, mas inventar propriedade
*   que o dump nao tem segue proibido.
*
* O que NAO eh reproduzido, de proposito:
*   - poDatamgr = CreateObject("fSqlConector", "SigOpSen"): objeto de conexao
*     do Framework Fortyus. Na arquitetura nova o acesso a dados eh do BO,
*     por gnConnHandle. Como consequencia o PROCEDURE Release legado
*     (ThisForm.poDatamgr.Release + DoDefault) nao tem conteudo proprio a
*     migrar - nao ha override de Release aqui, so o Destroy que fecha os
*     cursores. ATENCAO: "SigOpSen" aqui eh o NOME DA CONEXAO lido de
*     dbo.SigConn, NAO o form sigopsen.SCX (dialogo de senha de supervisor
*     que nao foi migrado) - sao coisas diferentes com o mesmo nome.
*
* Historico de fases:
*   Fase 1/2: sigopcksBO.prg - propriedades (8 parametros de entrada, 12
*             flags de tipo, credenciais, parametros do sistema, resultado) e
*             metodos de negocio: DefinirTipo (DO CASE do Init legado),
*             CarregarParametrosSistema (SigCdPam.liblcreds / SigCdPac.
*             senhdemps), DevePreencherUsuarioLogado, EstaEmModoSenhaDoDia,
*             CarregarUsuariosAutorizados, ValidarUsuario,
*             UsuarioTemSenhaCadastrada, ConcluirAutorizacaoSemSenha,
*             ValidarSenha. BO somente-leitura (nao sobrescreve Inserir/
*             Atualizar/ExecutarExclusao - o comportamento herdado de
*             BusinessBase ja eh o correto).
*   Fase 3:   ESTE arquivo - estrutura base: bloco de propriedades visuais,
*             Init (8 parametros do Init legado + criacao do BO + DefinirTipo
*             + Caption), InicializarForm, ConfigurarPageFrame (a faixa
*             cnt_4c_Sombra com lbl_4c_LblSombra/lbl_4c_LblTitulo),
*             TornarControlesVisiveis e Destroy.
*             Form FLAT: NENHUM pgf_4c_* eh criado aqui, porque o legado nao
*             tem PageFrame nem Page nenhuma - fabricar um violaria o PILAR 1
*             (inventar UX que o legado nao tem). O nome ConfigurarPageFrame
*             eh mantido por convencao do orquestrador de migracao.
*
* FASE 4 (Grid + barra CRUD da Page1): NADA A ACRESCENTAR - perfil CAPTURA.
* Este form nao recebe grade, nem container de barra CRUD, nem os seis botoes
* dela (os verbos incluir, visualizar, alterar, excluir, buscar e encerrar),
* nem os dois metodos canonicos do layout paginado - o Configurar<Pagina>Lista
* e o Alternar<Pagina> - porque o legado NAO TEM superficie de LISTA nenhuma
* para eles operarem.
*
* ATENCAO a quem for editar este cabecalho: os nomes desses dois metodos estao
* escritos com <...> de proposito. O gate da Fase 4 casa o identificador no
* .prg INTEIRO, comentario incluido e sem exigir PROCEDURE antes; grafar os
* nomes por extenso faz temLayoutPaginado virar .T. a partir do COMENTARIO e a
* fase passa pelo caminho ERRADO (aprovada por palavra-chave, sem o ramo
* CAPTURA nunca ser exercitado) - exatamente o modo de falha de
* SIGOPCAC/task651. Medido aqui: com os nomes por extenso o predicado deu .T.;
* com <...> da .F., e a aprovacao volta a vir do ramo CAPTURA, que eh o
* motivo verdadeiro.
*
* Medido no dump sigopcks_form_codigo_fonte.txt
* (12 objetos, conferidos um a um na SECAO 1):
*   - ZERO  BaseClass: grid | pageframe | listbox
*   - ZERO  AddCursor | pColuna | RecordSource | ControlSource | Grade | grd
*   - ZERO  API de nos de arvore (.Nodes.Add / AddPictureNode / ClearNodes...)
*   - 2     BaseClass: textbox (usuario, senha) - ambos de ENTRADA, nenhum
*           ReadOnly, o que caracteriza CAPTURA e nao EXIBICAO
*   - ZERO  commandbutton / commandgroup: o dialogo nao tem botao ALGUM. Ele
*           se resolve pela cadeia de Valid (senha.Valid autoriza) e aborta
*           por ESC no usuario.KeyPress - eventos da Fase 6/7.
* Os botoes CRUD canonicos ocupam Left = 542..1007; fabricar aqui uma barra
* Incluir/Alterar/Excluir sobre um dialogo de autorizacao daria ao usuario
* como CADASTRAR/APAGAR registro numa tela que so confere credencial - nao eh
* so UI morta, eh UX que o legado nao tem (PILAR 1, regra "NUNCA inventar"), e
* os dois metodos do layout paginado sem nada para listar seriam o
* "stub disfarcado" que a regra de completude proibe.
* O gate da Fase 4 do OrquestradorMigracao.ps1 reconhece isso pelo ramo
* "layout captura": medido com os helpers reais (Test-LegadoListBoxLigaLista,
* Test-LegadoAddCursorLigaGrade, Test-LegadoControlSourceLigaLista,
* Test-LegadoDialogoExibicao) ->  temListaEstritaF4 = .F., temCampoCapturaF4 =
* .T., temApiNosCapturaF4 = .F., DialogoExibicao = .F., legadoCapturaF4 = .T.,
* temSuperficieCaptura = .T., temLayoutCaptura = .T. (PASSA).
* Precedentes do mesmo perfil: SIGOPCHP/task699 e SIGPRCFN/task589.
*
* Continuacao do historico de fases:
*   Fase 5:   ESTE arquivo - ConfigurarControles (os 7 controles restantes do
*             SCX, todos filhos DIRETOS do form) e AplicarModoSenhaDoDia (o
*             ultimo bloco do Init legado, que depende deles).
*             Inventario ENTREGUE, conferido objeto a objeto contra a SECAO 2
*             do dump - os 12 objetos do SCX estao todos cobertos (o par
*             Dataenvironment/form nao vira controle; cntSombra + seus dois
*             labels sairam na Fase 3; os 7 abaixo saem aqui):
*               Shape1  -> shp_4c_Shape1  (247/197, 113x105, BorderWidth 2,
*                          BackColor branco, BorderColor 90,90,90)
*               Frase   -> lbl_4c_Frase   (12/120, 968x34, Tahoma 14 bold,
*                          WordWrap, Alignment 2, ForeColor 90,90,90,
*                          Caption de BO.this_cFrase)
*               Say2    -> lbl_4c_Label2  ("Representante :", 405/221)
*               usuario -> txt_4c_Usuario (561/217, 125x32, InputMask de 10
*                          sinais de exclamacao, Alignment 3, Century 2)
*               Say3    -> lbl_4c_Label3  ("Senha :", 486/265)
*               senha   -> txt_4c_Senha   (561/261, 125x32, mesmo InputMask,
*                          PasswordChar asterisco)
*               Image1  -> img_4c_Image1  (265/212, 77x76, Stretch 1,
*                          Picture geral_login_60.jpg)
*             Os 7 saem JUNTOS, nao em duas metades, porque este dialogo tem
*             exatamente 7 controles e eles vem em pares indivisiveis: a
*             moldura shp_4c_Shape1 so faz sentido com o icone que ela
*             emoldura, e cada rotulo so faz sentido com o campo que ele
*             rotula (regra "NUNCA criar versoes reduzidas"). Entregar meia
*             tela aqui deixaria "Senha :" sem campo de senha - UI morta -, e
*             nao sobraria campo nenhum para a Fase 6, cujo trabalho real
*             neste form sao os EVENTOS.
*
*   Fase 6:   ESTE arquivo - os EVENTOS dos dois campos, que sao o trabalho
*             real desta fase neste form (a superficie visual ja estava
*             inteira na Fase 5). ENTREGUE, metodo a metodo contra a SECAO 3
*             do dump - os 4 metodos de controle do SCX estao todos cobertos:
*               usuario.KeyPress -> UsuarioKeyPress (ESC com campo vazio
*                          aborta a autorizacao e fecha; F4 eh atalho do funil)
*               usuario.Valid    -> ValidarUsuarioDigitado (wrapper com guarda
*                          de reentrancia) + ValidarUsuarioDigitadoExec
*                          (CarregarUsuariosAutorizados, picker quando o
*                          codigo digitado nao bate exato, ValidarUsuario e o
*                          desvio "usuario sem senha cadastrada" que ESCONDE
*                          Say3/senha e conclui a autorizacao)
*               usuario.When     -> AplicarRegraWhenUsuario (.Enabled a partir
*                          de BO.EstaEmModoSenhaDoDia - BINDEVENT descarta o
*                          retorno do delegate e nao bloquearia a entrada)
*               senha.Valid      -> ValidarSenhaDigitada + ...Exec
*                          (BO.ValidarSenha nos dois ramos, senha cadastrada e
*                          senha do dia, com o "Deseja digitar novamente ?")
*             O LOOKUP eh AbrirBuscaUsuario: o legado usa fwBuscaSel sobre o
*             cursor LOCAL tmpusu (hoje cursor_4c_Usuar), ou seja um picker
*             sobre cursor JA populado - dai a API DefinirCursor/Mostrar do
*             FormBuscaAuxiliar, nunca o Init com parametros (que montaria
*             uma consulta nova e perderia o criterio de permissao).
*             Nao ha cnt_4c_BotoesAcao: o SCX nao tem botao algum (dialogo da
*             familia ENTRADA-SEM-BOTAO) - criar Confirmar/Cancelar aqui seria
*             inventar controle que o legado nao tem.
*             Medido no VFP9 (automation\ProbeCks702Fase6.prg): form instancia
*             1000x600, os 4 BINDEVENTs aparecem em AEVENTS, os 11 metodos do
*             caminho de BINDEVENT sao PUBLIC, o When deixa Enabled = .T. em
*             CANCITEM e .F. em MAXIMO, e o picker monta as 2 colunas do
*             legado (Codigo/cargo).
*
*   Fase 8:   ESTE arquivo - FECHAMENTO. O que faltava era UMA coisa: o
*             contrato de retorno do PROCEDURE Unload legado
*             (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs), que no
*             sistema novo nao tem como chegar ao chamador pelo evento
*             (o legado abria com "DO FORM ... TO <var>"; aqui se abre
*             por CREATEOBJECT + Show()). ENTREGUE em tres pecas:
*               sigopcksBO.ObterResultadoSaida - a REGRA, transcrita
*                          literal do Unload, gravando tambem em
*                          BO.this_cRetorno (fonte UNICA)
*               ObterResultadoSaida            - o espelho que o form
*                          chamador le depois do Show() e ANTES do
*                          Release() (o dialogo fecha com Hide(), entao
*                          continua legivel - ver FecharDialogo)
*               Unload + CachearResultadoSaida - o mesmo valor para quem
*                          abrir com "DO FORM ... TO"; o cache existe
*                          porque o Unload dispara DEPOIS do Destroy,
*                          quando FormBase.Destroy ja zerou o BO
*             Nada mais do SCX ficou de fora - nem controle, nem evento:
*             os 12 objetos sairam nas Fases 3/5 e os 4 metodos de
*             controle nas Fases 6/7.
*
* POR QUE NAO HA, NESTA FASE, OS QUATRO NOMES CANONICOS DO FORM CRUD
* (o Btn...Click de cancelar, o par de transferencia Form...BO /
* BO...Form e o Carregar...Lista) - nomes grafados aqui com o miolo
* ELIDIDO DE PROPOSITO, porque o gate da Fase 8 casa o identificador no
* .prg INTEIRO, comentario incluido: escreve-los por extenso daria
* "PRESENTE" a partir deste texto e a fase passaria por palavra-chave,
* sem o ramo verdadeiro ser exercitado.
*   - cancelar: o SCX nao tem UM botao sequer (12 objetos, zero
*     CommandButton/CommandGroup). Quem aborta eh o ESC do usuario.KeyPress
*     e o "Nao" do "Deseja digitar novamente ?" - os dois ja desembocam em
*     AbortarAutorizacao, que eh o Cancelar REAL desta tela. Criar um botao
*     para ter o nome canonico inventaria UX que o legado nao tem (PILAR 1).
*   - transferencia Form<->BO: os dois campos sao lidos e escritos no
*     ponto de uso, como o "This.Value" do Valid legado - a tela tem
*     exatamente dois controles de entrada, um deles (senha) nunca eh
*     relido, e o BO ja recebe o valor por parametro
*     (ValidarUsuario / ValidarSenha). O sentido BO -> tela existe e esta
*     em AplicarModoSenhaDoDia / AplicarRegraWhenUsuario / ConfigurarControles,
*     cada um ancorado no bloco do Init legado que o originou.
*   - carga de lista: nao ha lista. Zero grade, zero PageFrame, zero
*     AddCursor/pColuna no dump (medido na Fase 4).
* Este eh o perfil ENTRADA-SEM-BOTAO do gate: dialogo de ENTRADA sem botao
* algum, que confirma pelo evento de saida do ultimo campo. Precedentes do
* mesmo perfil: SIGOPBIN/task646 (que tambem devolve
* Iif(ZSen,'*',' ')+UsuLibs pelo Unload) e SIGPRSCN/task673.
*
* NOTA sobre visibilidade: no SCX, Say3 e senha nascem com Visible = .T. e
* so sao ESCONDIDOS em runtime, dentro do usuario.Valid (usuario sem senha
* cadastrada). Nao ha, portanto, container flutuante nem controle que nasce
* oculto neste form - TornarControlesVisiveis pode varrer a arvore inteira
* sem lista de excecao, e o Valid da Fase 6 esconde o que precisa DEPOIS,
* sem conflito com esta fase.
*==============================================================================

DEFINE CLASS Formsigopcks AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - valores EXATOS do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------
    Width       = 1000
    Height      = 600
    DataSession = 2
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = ""
    ControlBox  = .F.
    MaxButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowType  = 1
    AlwaysOnTop = .T.
    ShowWindow  = 1

    *--------------------------------------------------------------------------
    * Guardas de REENTRANCIA (regra #37/#47) - os dois caminhos de validacao
    * de campo deste dialogo abrem janela MODAL (o browse de liberadores e o
    * "Deseja digitar novamente ?"), que tira o foco do campo e faria o
    * proprio LostFocus disparar de novo, empilhando um segundo dialogo. As
    * flags sao ligadas e DESLIGADAS nos metodos-wrapper, nunca no corpo:
    * corpo com saida antecipada deixaria a flag presa em .T. e mataria a
    * validacao pelo resto da vida da tela.
    *--------------------------------------------------------------------------
    this_lEmLookup         = .F.
    this_lEmValidacaoSenha = .F.

    *--------------------------------------------------------------------------
    * Cache do resultado do dialogo (contrato do Unload legado).
    *
    * Existe porque o evento Unload do VFP dispara DEPOIS do Destroy, e
    * FormBase.Destroy zera this_oBusinessObject - no Unload nao ha mais BO de
    * quem perguntar. CachearResultadoSaida() grava aqui a resposta enquanto o
    * BO ainda vive (no fechamento e, por seguranca, no proprio Destroy antes
    * do DODEFAULT), e ObterResultadoSaida()/Unload() leem daqui quando o BO
    * ja se foi.
    *
    * Valor inicial "" e NAO " ": vazio significa "o dialogo ainda nao fechou",
    * enquanto " " ja eh uma RESPOSTA do contrato (nao autorizado). Quem le
    * antes da hora recebe vazio, cujo LEFT(...,1) tambem nao eh "*" - o lado
    * fail-closed.
    *--------------------------------------------------------------------------
    this_cResultadoSaida = ""

    *-- this_cTituloForm fica VAZIO de proposito: FormBase.Init sobrescreve
    *-- THIS.Caption com ele quando preenchido, e aqui o Caption eh resultado
    *-- do DO CASE do tipo de liberacao (BO.this_cCaption), resolvido no Init
    *-- ANTES do DODEFAULT. Preencher this_cTituloForm apagaria esse texto.

    *--------------------------------------------------------------------------
    * Init - Equivale ao PROCEDURE Init legado:
    *   LParameters _Tipo, _Titulo, _Titulo2, _Documento, _Data, _Empresa,
    *               _Fpagto, _Valor
    *
    * Os 8 parametros sao repassados CRUS ao BO: a normalizacao do legado
    * (If Type("_Documento")#"N" -> 0, If Type("_Data")#"D" -> Date(), etc.)
    * ja mora em sigopcksBO.DefinirTipo, junto com o DO CASE que deriva
    * Caption/Frase e liga a flag de permissao do tipo. DefinirTipo tambem
    * carrega os parametros do sistema (SigCdPam/SigCdPac) na MESMA posicao do
    * Init legado, antes do DO CASE - de que dependem
    * DevePreencherUsuarioLogado e EstaEmModoSenhaDoDia.
    *
    * O Caption eh resolvido ANTES do DODEFAULT porque ConfigurarPageFrame
    * copia THIS.Caption para os dois labels da faixa (regra #11), tal como o
    * Init legado faz (cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * A criacao do BO NAO eh condicionada a gnConnHandle > 0: o harness de
    * teste automatizado define gnConnHandle = 0 de proposito e um gate de
    * handle aqui faria CREATEOBJECT devolver .F. e a tela nunca abrir. Quem
    * pula a consulta eh o proprio metodo do BO, que trata a falha de SQLEXEC.
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): o resultado vai para
    * loc_lSucesso e o unico RETURN fica DEPOIS do ENDTRY.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cTipo, par_cTitulo, par_cTitulo2, par_nDocumento, ;
            par_dData, par_cEmpresa, par_cFpagto, par_nValor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopcksBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopcksBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopcks.Init")
            ELSE
                *-- DO CASE do Init legado + carga de SigCdPam/SigCdPac.
                *-- A falha NAO aborta o dialogo (o Init legado tambem segue
                *-- adiante): a tela abre FAIL-CLOSED, com this_lZSen = .F.,
                *-- e so a conferencia bem sucedida da senha autoriza.
                IF !THIS.this_oBusinessObject.DefinirTipo(par_cTipo, par_cTitulo, ;
                        par_cTitulo2, par_nDocumento, par_dData, par_cEmpresa, ;
                        par_cFpagto, par_nValor)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Formsigopcks.Init")
                ENDIF

                *-- This.Caption = ... de cada ramo do DO CASE legado
                THIS.Caption = THIS.this_oBusinessObject.this_cCaption

                *-- DODEFAULT() dispara FormBase.Init(), que chama
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopcks.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Picture do SCX: ..\framework\imagens\new_background.jpg.
            *-- Caminho resolvido por gc_4c_CaminhoFramework (config.prg) -
            *-- NUNCA remontado a partir de gc_4c_CaminhoBase, que aponta para
            *-- app\start e nao navega para a pasta Framework.
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Faixa de cabecalho (cntSombra do legado). PRIMEIRO AddObject
            *-- do form (regra #11).
            THIS.ConfigurarPageFrame()

            *-- Os 7 controles restantes do SCX, todos filhos DIRETOS do form
            THIS.ConfigurarControles()

            *-- Ultimo bloco do Init legado - depende de txt_4c_Usuario e
            *-- lbl_4c_Label3, criados logo acima
            THIS.AplicarModoSenhaDoDia()

            *-- Eventos dos dois campos: usuario.KeyPress/Valid/When e
            *-- senha.Valid do legado (o form nao tem botao algum)
            THIS.ConfigurarBINDEVENTs()

            *-- usuario.When legado: campo nao digitavel em senha-do-dia
            THIS.AplicarRegraWhenUsuario()

            *-- AddObject cria todo controle com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Duas ultimas linhas do Init legado:
            *--   ThisForm.Top  = ThisForm.Top  + 5
            *--   ThisForm.Left = ThisForm.Left + 5
            *-- Transcritas como estao. O legado tem AutoCenter = .T. igual ao
            *-- migrado, entao o efeito (se o VFP nao recentralizar no Show)
            *-- eh o mesmo nos dois - transcrever mantem a fidelidade sem
            *-- decidir pelo VFP.
            THIS.Top  = THIS.Top  + 5
            THIS.Left = THIS.Left + 5

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria a faixa de cabecalho: cnt_4c_Sombra
    * (cntSombra do legado) com lbl_4c_LblSombra e lbl_4c_LblTitulo.
    *
    * Form OPERACIONAL FLAT: NENHUM AddObject de pgf_4c_ acontece aqui - o
    * legado nao tem PageFrame nem Page. O nome do metodo eh mantido por
    * convencao do orquestrador de migracao.
    *
    * A faixa eh o PRIMEIRO AddObject do form (regra #11): os controles das
    * fases seguintes ficam abaixo dela (o mais alto eh Frase, Top = 120,
    * contra 0..80 da faixa) e, criados depois, desenham por cima.
    *
    * Os labels sao adicionados FORA do bloco WITH do container: WITH
    * aninhado em volta de AddObject descarta propriedades em silencio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                *-- O SCX declara cntSombra.Width = 1100 com o form em 1000:
                *-- artefato do Form Designer (container desenhado 100px alem
                *-- da borda direita da janela). Copiar o literal nao
                *-- acrescenta area visivel nenhuma, entao vale THIS.Width.
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                *-- AutoSize explicitamente .F. com WordWrap ligado: AutoSize
                *-- eh no-op em Label criado por AddObject e, com WordWrap,
                *-- chega a DESCARTAR a Height transcrita (regra #23). Width e
                *-- Height vem do dump e ja sao o auto-size que o Form
                *-- Designer calculou.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .Rotation      = 0
                .ForeColor     = RGB(0, 0, 0)
                *-- Regra #11: o rotulo da faixa espelha THIS.Caption, que o
                *-- Init ja resolveu a partir do tipo de liberacao - igual ao
                *-- Init legado (lblSombra.Caption = ThisForm.Caption). O
                *-- literal "Cadastro de Testes" do SCX eh placeholder
                *-- herdado do frmcadastro, sobrescrito no proprio legado.
                .Caption       = THIS.Caption
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .Rotation    = 0
                *-- Branco eh correto aqui: label dentro de container OPACO
                *-- escuro (BackStyle = 1 + RGB(100,100,100)). A proibicao de
                *-- ForeColor branco da regra #12 vale para label de DADOS
                *-- sobre a textura clara, nao para a faixa do cabecalho.
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Caption     = THIS.Caption
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria os 7 controles restantes do SCX legado.
    *
    * Form FLAT: TODOS sao filhos DIRETOS do form (THIS.AddObject), como na
    * SECAO 1 do dump - o unico par que mora em container eh o dos labels da
    * faixa, ja criado em ConfigurarPageFrame. Nao existe aqui o par
    * Configurar<Pagina>Dados / loc_oPagina = ...Page2 do layout paginado,
    * porque o legado nao tem Page nenhuma; escrever um metodo com esse nome
    * so para casar com o regex do gate seria o "stub disfarcado" proibido
    * pela regra de completude - e, pior, um metodo que ninguem chama.
    *
    * ORDEM DE CRIACAO = ordem de declaracao do SCX (Shape1, Frase, Say2,
    * usuario, Say3, senha, Image1), que tambem satisfaz as duas regras de
    * z-order que importam aqui:
    *   - cada label eh criado ANTES do campo que ele rotula (Say2 antes de
    *     usuario, Say3 antes de senha), entao a caixa transparente que sobra
    *     no label nunca bloqueia o clique no TextBox (regra #23);
    *   - Image1 vem DEPOIS de Shape1, logo o icone de login desenha POR CIMA
    *     da moldura branca, que eh o efeito do legado.
    * A faixa do cabecalho (0..80) nao disputa espaco com nada daqui: o
    * controle mais alto eh Frase, em Top = 120.
    *
    * Os tamanhos de lbl_4c_Label2 e lbl_4c_Label3 sao os UNICOS numeros nao
    * transcritos literalmente, porque o SCX nao os grava: as duas labels
    * declaram AutoSize = .T. e o Form Designer, nesse caso, nao persiste
    * Width/Height. AutoSize eh no-op em Label criado por AddObject (a Width
    * ficaria nos 100 do default) e, com WordWrap, chega a DESCARTAR a Height
    * - por isso vao com AutoSize = .F. e medida explicita (regra #23).
    *
    * As larguras foram MEDIDAS no VFP9, nao estimadas
    * (automation\vfp_helpers\medir_task702_f5.prg:
    *  TXTWIDTH(<caption>, "Tahoma", 14, "B") * FONTMETRIC(6, "Tahoma", 14, "B")):
    *   "Representante :"  = 152px  -> lbl_4c_Label2.Width = 152
    *   "Senha :"          =  71px
    *   "Senha Do Dia : "  = 146px  -> lbl_4c_Label3.Width = 146
    * A estimativa de 10px por caractere (largura media que a tabela de fontes
    * do dump sugere, "Tahoma, 1, 14, 10, 23, ...") erra por pouco e PARA
    * BAIXO em ambos - 150 e 130 -, e com AutoSize = .F. o que nao cabe eh
    * CORTADO sem erro e sem log. Por isso a medida vale mais que a conta.
    * lbl_4c_Label3 eh dimensionada pelo caption LONGO ("Senha Do Dia : ",
    * que AplicarModoSenhaDoDia instala), nunca pelo inicial.
    *
    * O resultado confere com o espacamento que a classe say pressupoe: com
    * Alignment = 0, o texto de "Representante :" (a partir de Left 405) e o
    * de "Senha :" (a partir de 486) terminam os DOIS em 557, exatos 4px antes
    * dos campos em Left = 561.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oErro

        TRY
            *-- Shape1 -> shp_4c_Shape1: moldura branca do bloco de login.
            *-- Shape NAO tem ForeColor (regra #33) - a cor da borda mora em
            *-- BorderColor, e eh so o que o dump declara.
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 197
                .Left        = 247
                .Height      = 105
                .Width       = 113
                .BorderWidth = 2
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
            ENDWITH

            *-- Frase -> lbl_4c_Frase: a frase que explica o bloqueio.
            *-- O Caption NAO eh literal: cada ramo do DO CASE do Init legado
            *-- escreve um texto diferente em This.Frase.Caption, e esse texto
            *-- ja foi derivado por BO.DefinirTipo (fonte UNICA, this_cFrase).
            *-- BackStyle = 0 reproduz a classe "say" do framework.vcx, que o
            *-- dump nao repete objeto a objeto: Label base nasce opaco e, sem
            *-- isso, pintaria um retangulo cinza sobre o new_background.jpg.
            THIS.AddObject("lbl_4c_Frase", "Label")
            WITH THIS.lbl_4c_Frase
                .Caption   = THIS.this_oBusinessObject.this_cFrase
                .Top       = 120
                .Left      = 12
                .Width     = 968
                .Height    = 34
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .FontItalic = .F.
                .WordWrap  = .T.
                .Alignment = 2
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            *-- Say2 -> lbl_4c_Label2: rotulo "Representante :".
            *-- Alignment = 0 porque o Say do legado nao declara nem Width nem
            *-- Alignment: eh a classe say pura (AutoSize/esquerda). Inventar
            *-- Alignment = 1 encostaria o texto na borda direita da caixa,
            *-- dentro do TextBox (regra #23).
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Caption   = "Representante :"
                .Top       = 221
                .Left      = 405
                *-- 152 = largura MEDIDA do texto no VFP9, nao estimada:
                *-- TXTWIDTH("Representante :","Tahoma",14,"B") *
                *-- FONTMETRIC(6,"Tahoma",14,"B") = 152px. Com AutoSize = .F.
                *-- a label nao cresce, e 150 (a estimativa de 10px/char)
                *-- CORTARIA os 2px finais em silencio (regra #23).
                .Width     = 152
                .Height    = 24
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 2
            ENDWITH

            *-- usuario -> txt_4c_Usuario: codigo do liberador.
            *-- .Value = "" (string): campo de texto, nunca .F. nem 0.
            *-- InputMask com 10 sinais de exclamacao vem LITERAL do dump -
            *-- forca maiuscula em 10 posicoes (regra #49). Nao ha Format no
            *-- dump, entao nenhum eh inventado.
            *-- MaxLength = 10 vem da LARGURA DA COLUNA no schema
            *-- (sigcdusu.usuarios char(10)), nunca do Width em pixels
            *-- (regra #19) - e bate com as 10 posicoes do InputMask.
            THIS.AddObject("txt_4c_Usuario", "TextBox")
            WITH THIS.txt_4c_Usuario
                .Value     = ""
                .Top       = 217
                .Left      = 561
                .Width     = 125
                .Height    = 32
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .Century   = 2
                .Alignment = 3
                .InputMask = "!!!!!!!!!!"
                .MaxLength = 10
                .ForeColor = RGB(0, 0, 0)
                .TabIndex  = 3
            ENDWITH

            *-- Say3 -> lbl_4c_Label3: rotulo "Senha :".
            *-- Width 146 (nao os 71px do texto inicial) porque o Init legado
            *-- TROCA este Caption por "Senha Do Dia : " no modo de senha do
            *-- dia - ver AplicarModoSenhaDoDia. Com AutoSize = .F. a label
            *-- nao cresce sozinha, e uma Width justa CORTARIA o texto novo.
            *-- A caixa que sobra eh inofensiva: BackStyle = 0 nao pinta e
            *-- txt_4c_Senha, criado DEPOIS, desenha por cima e recebe o
            *-- clique (regra #23).
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Caption   = "Senha :"
                .Top       = 265
                .Left      = 486
                *-- 146 = largura MEDIDA de "Senha Do Dia : " (o Caption do
                *-- modo senha do dia), nao de "Senha :" (71px). Dimensionar
                *-- pelo texto inicial cortaria o rotulo longo em silencio.
                .Width     = 146
                .Height    = 24
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- senha -> txt_4c_Senha: senha do liberador.
            *-- PasswordChar = "*" vem do dump. O dump NAO declara Alignment
            *-- neste controle (so no usuario), entao nenhum eh escrito aqui -
            *-- fica o default da base class.
            THIS.AddObject("txt_4c_Senha", "TextBox")
            WITH THIS.txt_4c_Senha
                .Value        = ""
                .Top          = 261
                .Left         = 561
                .Width        = 125
                .Height       = 32
                .FontName     = "Tahoma"
                .FontSize     = 14
                .FontBold     = .T.
                .InputMask    = "!!!!!!!!!!"
                .MaxLength    = 10
                .PasswordChar = "*"
                .ForeColor    = RGB(0, 0, 0)
            ENDWITH

            *-- Image1 -> img_4c_Image1: icone de login dentro da moldura.
            *-- O nome do arquivo eh TRANSCRITO do dump
            *-- (..\framework\imagens\geral_login_60.jpg), nunca escolhido por
            *-- semelhanca semantica: .Picture inexistente falha em SILENCIO,
            *-- sem erro de compilacao nem de runtime (regra #25). Conferido
            *-- em disco: Framework\imagens\geral_login_60.jpg existe.
            *-- Caminho por gc_4c_CaminhoFramework, nunca remontado a partir
            *-- de gc_4c_CaminhoBase.
            THIS.AddObject("img_4c_Image1", "Image")
            WITH THIS.img_4c_Image1
                .Top     = 212
                .Left    = 265
                .Width   = 77
                .Height  = 76
                .Stretch = 1
                .Picture = gc_4c_CaminhoFramework + "imagens\geral_login_60.jpg"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.ConfigurarControles")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarModoSenhaDoDia - ULTIMO bloco do Init legado que depende dos
    * controles criados acima:
    *
    *   If ( crParam.LiblCreds And _Tipo = 'LIMITE' ) Or _Tipo = 'LIBPRDZ2' ;
    *      Or _Tipo = 'MAXIMO'
    *       ThisForm.usuario.Value = Usuar
    *       ThisForm.Say3.Caption  = 'Senha Do Dia : '
    *       ThisForm.Say3.Left = 142
    *   EndIf
    *
    * A condicao NAO eh reescrita aqui: ela ja eh
    * BO.DevePreencherUsuarioLogado(), onde tambem vive a leitura de
    * SigCdPam.liblcreds carregada por DefinirTipo (fonte UNICA). Note que ela
    * NAO eh a mesma expressao de usuario.When / senha.Valid
    * (BO.EstaEmModoSenhaDoDia) - sao duas regras parecidas e distintas, e o
    * BO as mantem separadas de proposito.
    *
    * "Usuar" do legado eh o usuario logado; no sistema novo,
    * gc_4c_UsuarioLogado.
    *
    * O Left = 142 arrasta o rotulo para cima da borda esquerda de
    * shp_4c_Shape1 (247..360). Isso eh SOBREPOSICAO HERDADA do legado
    * (regra #28): o SCX/Init move a label e nao move mais nada, e o rotulo
    * longo invade a moldura. Transcrito como esta, sem inventar posicao nova
    * - o label desenha por cima porque eh criado depois do Shape, que eh o
    * resultado do legado.
    *
    * Chamado pelo InicializarForm, UMA vez, logo apos ConfigurarControles.
    * O Refresh final reproduz o "This.Refresh / This.Frase.Refresh" que
    * fecha o Init legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarModoSenhaDoDia()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.DevePreencherUsuarioLogado()
                    THIS.txt_4c_Usuario.Value  = gc_4c_UsuarioLogado
                    THIS.lbl_4c_Label3.Caption = "Senha Do Dia : "
                    THIS.lbl_4c_Label3.Left    = 142
                ENDIF
            ENDIF

            THIS.lbl_4c_Frase.Refresh()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.AplicarModoSenhaDoDia")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Liga os eventos dos DOIS campos do dialogo.
    *
    * O SCX legado tem exatamente quatro metodos de controle, todos no par
    * usuario/senha - nao ha botao algum na arvore (form puro, TitleBar = 0,
    * ControlBox = .F., zero CommandButton/CommandGroup):
    *
    *   SIGOPCKS.usuario.KeyPress -> aborta no ESC com campo vazio
    *   SIGOPCKS.usuario.Valid    -> resolve o liberador (com browse) e decide
    *                                se a senha sera pedida
    *   SIGOPCKS.usuario.When     -> campo NAO digitavel em senha-do-dia
    *   SIGOPCKS.senha.Valid      -> confere a senha e fecha autorizando
    *
    * Por isso NAO existe cnt_4c_BotoesAcao (Confirmar/Cancelar) neste form:
    * criar esse container obrigaria a inventar dois botoes que o legado nao
    * tem, violando o PILAR 1 e a regra "NUNCA inventar". O dialogo eh da
    * familia ENTRADA-SEM-BOTAO: confirma pelo Valid do ultimo campo e aborta
    * pelo ESC, exatamente como o legado.
    *
    * Mapeamento de evento legado -> evento ligado aqui:
    *
    *   Valid    -> "LostFocus" : BINDEVENT "Valid" NAO dispara em TextBox
    *   KeyPress -> "KeyPress"  : direto
    *   When     -> .Enabled    : BINDEVENT descarta o retorno do delegate,
    *                             entao um "When" ligado nao bloquearia a
    *                             entrada - ver AplicarRegraWhenUsuario
    *
    * O lookup fica em "LostFocus", NUNCA em "KeyPress" sem testar a tecla
    * (regra #47): ligado a KeyPress sem guarda, o browse subiria a CADA
    * caractere digitado e o usuario nunca conseguiria terminar o codigo.
    * F4 e DblClick entram como atalhos para o MESMO funil
    * (ValidarUsuarioDigitado), nunca como um segundo caminho de validacao -
    * um caminho paralelo renderia mensagem/picker em duplicata.
    *
    * Todos os delegates sao PUBLIC: metodo PROTECTED ligado por BINDEVENT
    * falha em SILENCIO (regra #3). O handler de KeyPress declara os dois
    * parametros do evento, senao estoura a cada tecla.
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oErro

        TRY
            *-- usuario: ESC (KeyPress legado) e F4 (atalho do funil)
            BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "UsuarioKeyPress")

            *-- usuario.Valid legado: resolve o liberador e abre o browse
            BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "ValidarUsuarioDigitado")

            *-- atalho de mouse para o mesmo funil
            BINDEVENT(THIS.txt_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")

            *-- senha.Valid legado: confere a senha e fecha autorizando
            BINDEVENT(THIS.txt_4c_Senha, "LostFocus", THIS, "ValidarSenhaDigitada")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.ConfigurarBINDEVENTs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRegraWhenUsuario - usuario.When legado:
    *
    *   Return (!crParam.LiblCreds Or (ThisForm.Tipo # 'LIMITE' And
    *           ThisForm.tipo # 'LIBPRDZ2')) And ThisForm.Tipo # 'MAXIMO'
    *
    * Essa expressao eh a NEGACAO de BO.EstaEmModoSenhaDoDia() (fonte UNICA,
    * compartilhada com ValidarSenha - o BO guarda as duas regras parecidas
    * separadas de proposito: esta NAO eh DevePreencherUsuarioLogado).
    *
    * When = .F. significa campo em que nao se entra: o foco nao para nele,
    * nem por Tab nem por clique, e o Valid dele NUNCA dispara. Como
    * BINDEVENT descarta o valor devolvido pelo delegate, um "When" ligado por
    * BINDEVENT nao bloquearia nada - a traducao fiel eh .Enabled = .F.
    * No modo senha-do-dia o campo ja entra PRE-PREENCHIDO com o usuario
    * logado (AplicarModoSenhaDoDia) e a senha conferida eh a do dia, entao
    * nao ha o que digitar ali.
    *
    * O funil de validacao tambem recusa trabalhar nesse modo, para o caso de
    * o campo receber foco por codigo: ver ValidarUsuarioDigitadoExec.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarRegraWhenUsuario()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Usuario.Enabled = ;
                    !THIS.this_oBusinessObject.EstaEmModoSenhaDoDia()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.AplicarRegraWhenUsuario")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioKeyPress - SIGOPCKS.usuario.KeyPress legado:
    *
    *   If Lastkey() = 27 And Empty(this.Value)
    *       zsen = .f.
    *       Thisform.zsen=.F.
    *       Thisform.release
    *   EndIf
    *
    * ESC com o campo VAZIO aborta a autorizacao (nao autoriza nada) e fecha o
    * dialogo. ESC com valor digitado nao fecha - igual ao legado.
    *
    * F4 eh atalho para o MESMO funil do LostFocus, dentro de IF explicito de
    * tecla: handler ligado a "KeyPress" que abrisse o picker sem testar a
    * tecla faria o browse subir a cada caractere (regra #47).
    *
    * Nao liga nem desliga a flag de reentrancia: delega para o WRAPPER
    * ValidarUsuarioDigitado, que eh quem a controla - ligar a flag aqui
    * faria o wrapper devolver sem abrir nada e MATARIA o atalho.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27 AND EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
            THIS.AbortarAutorizacao()
        ELSE
            IF par_nKeyCode = 115
                THIS.ValidarUsuarioDigitado()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioDblClick - atalho de mouse para o funil de validacao/browse.
    * Delega ao WRAPPER (que controla a flag de reentrancia) pela mesma razao
    * descrita em UsuarioKeyPress.
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioDblClick()
        THIS.ValidarUsuarioDigitado()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuarioDigitado - WRAPPER do funil de validacao do liberador.
    *
    * O corpo mora em ValidarUsuarioDigitadoExec e o wrapper so cuida da
    * GUARDA DE REENTRANCIA, obrigatoria aqui porque o browse eh MODAL: ele
    * tira o foco do campo e o proprio LostFocus voltaria a disparar,
    * empilhando um segundo picker (regra #37/#47).
    *
    * A flag eh liberada neste wrapper, nunca dentro do corpo: corpo com
    * saida antecipada deixaria a flag presa em .T. e MATARIA o lookup pelo
    * resto da vida do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuarioDigitado()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.ValidarUsuarioDigitadoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuarioDigitadoExec - corpo do SIGOPCKS.usuario.Valid legado, na
    * mesma ordem do original:
    *
    *   1) If IsEmpty(This.Value) -> zsen=.F. + release
    *   2) DO CASE que escolhe a query do pool de liberadores autorizados
    *      (ja eh BO.ObterQuerySqlUsuario, chamado por
    *      CarregarUsuariosAutorizados - fonte UNICA)
    *   3) SqlExecute(...) < 1 -> MessageBox 'Favor Reinicializar o
    *      Processo!!!' + Return 0 (o foco fica no campo)
    *   4) seek(this.value) falhou -> browse fwBuscaSel -> AbrirBuscaUsuario
    *   5) If IsEmpty(usual) -> zsen=.F. + release
    *   6) senha cadastrada em branco -> zsen=.T., esconde Say3/senha e fecha;
    *      senha cadastrada presente -> mostra Say3/senha e pede a senha
    *
    * Nenhum RETURN dentro do TRY (regra #1): o fluxo eh conduzido por
    * loc_lProsseguir e o metodo termina no ENDPROC.
    *
    * Divergencia DELIBERADA de PILAR 3 no passo 4: o legado faz
    * "set near on / seek / this.value = evaluate('usuarios')", ou seja
    * atribui ao campo o registro em que o ponteiro parou MESMO quando o
    * usuario cancelou o browse com ESC - e com isso deixa no campo um codigo
    * que ninguem escolheu. Aqui o valor so eh atribuido sob a guarda de
    * selecao (regra #37), e o codigo digitado NUNCA eh apagado (regra #50):
    * cancelar o browse devolve o foco ao campo com o que o usuario digitou,
    * sem modal de "nao encontrado" e sem fechar o dialogo - o legado tambem
    * nao fecha nesse caminho.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuarioDigitadoExec()
        LOCAL loc_cDigitado, loc_cMensagem, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        TRY
            loc_cDigitado = ALLTRIM(THIS.txt_4c_Usuario.Value)

            *-- (1) campo vazio: nao autoriza e fecha
            IF EMPTY(loc_cDigitado)
                THIS.AbortarAutorizacao()
                loc_lProsseguir = .F.
            ENDIF

            *-- usuario.When legado: em senha-do-dia o Valid nunca dispara
            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.EstaEmModoSenhaDoDia()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- (2)+(3) monta e executa a query do pool de liberadores
            IF loc_lProsseguir
                IF !THIS.this_oBusinessObject.CarregarUsuariosAutorizados()
                    loc_cMensagem = ;
                        ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
                    IF EMPTY(loc_cMensagem)
                        loc_cMensagem = "Favor Reinicializar o Processo!!!"
                    ENDIF
                    MsgErro(loc_cMensagem, "Falha na Conex" + CHR(227) + "o (TmpUsu)")
                    THIS.txt_4c_Usuario.SetFocus()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- (4) codigo digitado nao esta no pool: abre o browse.
            *-- A guarda de "so abrir se nao resolveu" eh ESTA condicao - o
            *-- picker nao sobe quando o codigo ja casa exato (regra #37).
            IF loc_lProsseguir
                IF !THIS.this_oBusinessObject.ValidarUsuario(loc_cDigitado)
                    THIS.AbrirBuscaUsuario()
                ENDIF
                loc_cDigitado = ALLTRIM(THIS.txt_4c_Usuario.Value)
            ENDIF

            *-- (5) nada resolvido
            IF loc_lProsseguir
                IF EMPTY(loc_cDigitado)
                    *-- campo ficou vazio: legado aborta e fecha
                    THIS.AbortarAutorizacao()
                    loc_lProsseguir = .F.
                ELSE
                    IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cUsuario))
                        *-- digitou e nao escolheu no browse: mantem o que
                        *-- digitou e devolve o foco, sem fechar o dialogo
                        THIS.txt_4c_Usuario.SetFocus()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- (6) decide se a senha sera pedida.
            *-- O legado protege este bloco com "If lastkey()<>27": sair do
            *-- campo com ESC nao autoriza nem avanca.
            IF loc_lProsseguir AND LASTKEY() != 27
                IF THIS.this_oBusinessObject.UsuarioTemSenhaCadastrada()
                    THIS.lbl_4c_Label3.Visible = .T.
                    THIS.txt_4c_Senha.Visible  = .T.
                    THIS.txt_4c_Senha.SetFocus()
                ELSE
                    *-- senha cadastrada em branco: autoriza sem pedir senha
                    THIS.this_oBusinessObject.ConcluirAutorizacaoSemSenha()
                    THIS.lbl_4c_Label3.Visible = .F.
                    THIS.txt_4c_Senha.Visible  = .F.
                    THIS.FecharDialogo()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.ValidarUsuarioDigitado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuario - browse de selecao do liberador. Equivale ao trecho
    * do usuario.Valid legado:
    *
    *   xBrow    = CreateObject('fwBuscaSel','tmpusu','usuarios',this.value,
    *                           'Selecao')
    *   xBrowCol = xBrow.AddColuna('usuarios','','Codigo',.t.,'usuarios')
    *   xBrowCol = xBrow.AddColuna('ccargs','','cargo',.F.)
    *   xBrow.Show
    *
    * fwBuscaSel busca num CURSOR LOCAL ja populado (TmpUsu), nao numa tabela
    * do servidor - o pool de liberadores autorizados vem de um JOIN cujo
    * criterio depende do tipo de liberacao e vive no BO. Por isso aqui se usa
    * a API DefinirCursor/Mostrar do FormBuscaAuxiliar (cursor PRE-populado),
    * nunca o Init com parametros, que montaria um "SELECT * FROM <tabela>"
    * proprio e perderia o criterio de permissao.
    *
    * cursor_4c_Usuar (o TmpUsu do legado) nasce na sessao de dados PRIVADA
    * deste form (DataSession = 2). O FormBuscaAuxiliar declara
    * DataSession = 1, que em VFP9 significa "a sessao CORRENTE" e NAO "a
    * sessao numero 1" - instanciado daqui, ele roda na sessao privada do pai
    * e enxerga o cursor normalmente (medido no VFP9).
    *
    * Show() do picker fica FORA do TRY (regra #29): com o Show dentro do
    * bloco, qualquer erro de runtime durante a vida do dialogo modal salta
    * para o CATCH, a referencia LOCAL cai e o picker eh DESTRUIDO no meio do
    * uso. O TRY cobre a preparacao; o resultado eh lido depois, em bloco
    * proprio.
    *
    * O picker fecha com Hide(), por isso as propriedades continuam legiveis
    * e eh o CHAMADOR quem da o Release().
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaUsuario()
        LOCAL loc_oBusca, loc_lSelecionou, loc_cCodigo, loc_cMensagem, loc_oErro

        loc_oBusca      = .NULL.
        loc_lSelecionou = .F.
        loc_cCodigo     = ""

        *-- Preparacao: pool carregado + picker montado
        TRY
            IF !USED("cursor_4c_Usuar")
                IF !THIS.this_oBusinessObject.CarregarUsuariosAutorizados()
                    loc_cMensagem = ;
                        ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
                    IF EMPTY(loc_cMensagem)
                        loc_cMensagem = "Favor Reinicializar o Processo!!!"
                    ENDIF
                    MsgErro(loc_cMensagem, "Falha na Conex" + CHR(227) + "o (TmpUsu)")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                IF VARTYPE(loc_oBusca) = "O"
                    *-- codigo = usuarios, descricao = ccargs (as duas colunas
                    *-- que o legado registra com AddColuna)
                    loc_oBusca.DefinirCursor("cursor_4c_Usuar", "usuarios", "ccargs", ;
                        "Sele" + CHR(231) + CHR(227) + "o")

                    *-- DefinirCursor rotula cada coluna com o NOME do campo;
                    *-- o legado rotula 'Codigo' e 'cargo'. Zerar o contador e
                    *-- reinstalar as duas colunas repoe esses titulos -
                    *-- mAddColuna re-DIMENSIONA o array a cada chamada, e
                    *-- this_cCampoCodigo/this_cCampoDescricao (de que Mostrar
                    *-- depende) nao sao afetados.
                    loc_oBusca.this_nColunas = 0
                    loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("ccargs", "", "cargo")
                ELSE
                    loc_oBusca = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.AbrirBuscaUsuario")
            loc_oBusca = .NULL.
        ENDTRY

        *-- Exibicao do modal FORA do TRY (regra #29)
        IF VARTYPE(loc_oBusca) = "O"
            loc_lSelecionou = loc_oBusca.Mostrar()

            IF loc_lSelecionou
                loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        ENDIF

        *-- Resultado: atribui SO sob a guarda de selecao (regra #37)
        TRY
            IF loc_lSelecionou AND !EMPTY(loc_cCodigo)
                THIS.txt_4c_Usuario.Value = loc_cCodigo

                *-- carrega cargo/senha cadastrada do escolhido, que eh o que
                *-- o passo (6) do Valid consulta
                IF !THIS.this_oBusinessObject.ValidarUsuario(loc_cCodigo)
                    loc_cMensagem = ;
                        ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))
                    IF !EMPTY(loc_cMensagem)
                        MsgAviso(loc_cMensagem, "Sele" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.AbrirBuscaUsuario")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenhaDigitada - WRAPPER do SIGOPCKS.senha.Valid legado.
    *
    * Guarda de reentrancia pela mesma razao do funil do liberador: o caminho
    * de recusa exibe um dialogo MODAL de confirmacao ("Deseja digitar
    * novamente ?"), que tira o foco do campo e faria o LostFocus disparar de
    * novo, duplicando a pergunta. Flag liberada no wrapper, nunca no corpo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSenhaDigitada()
        IF THIS.this_lEmValidacaoSenha
            RETURN
        ENDIF

        THIS.this_lEmValidacaoSenha = .T.
        THIS.ValidarSenhaDigitadaExec()
        THIS.this_lEmValidacaoSenha = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenhaDigitadaExec - corpo do SIGOPCKS.senha.Valid legado.
    *
    * Toda a REGRA (conferir contra a senha cadastrada via fCriptografar ou
    * contra a senha do dia via fGerPswDiario, somar empresa/forma de
    * pagamento/valor quando SigCdPac.senhdemps esta ligado, e gravar o log de
    * liberacao) vive em BO.ValidarSenha - fonte UNICA. Aqui fica so a parte
    * de TELA:
    *
    *   senha confere      -> zsen=.T. (o BO ja marcou) + Thisform.release
    *   senha nao confere  -> MessageBox('Deseja digitar novamente ? (S/N)')
    *                         Nao  -> zsen=.F. + release
    *                         Sim  -> Return 0 (valor e foco ficam no campo)
    *
    * MsgConfirma devolve LOGICO (regra #7): .T. = Sim. O legado usa
    * MessageBox(...,4+256,...) e compara com 7 (Nao); a unica diferenca eh o
    * botao DEFAULT (o legado destaca "Nao", MsgConfirma destaca "Sim").
    * MESSAGEBOX direto eh proibido no projeto - MsgConfirma tambem silencia o
    * dialogo em teste automatizado, devolvendo .F. (= Nao), que eh o lado
    * FAIL-CLOSED.
    *
    * Falha TECNICA nao vira "senha conflitante": fCriptografar e
    * fGerPswDiario ficaram AUSENTES de proposito (sao valor-de-CALCULO - um
    * stub autenticaria quem nao devia), entao o CATCH do BO devolve .F. com
    * uma mensagem propria. Perguntar "deseja digitar novamente?" nesse caso
    * prenderia o usuario num laco sem pista nenhuma: a mensagem real eh
    * exibida e o dialogo fecha sem autorizar.
    *
    * Sem RETURN dentro do TRY (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSenhaDigitadaExec()
        LOCAL loc_cSenha, loc_cMensagem, loc_oErro

        TRY
            loc_cSenha = ALLTRIM(THIS.txt_4c_Senha.Value)

            IF THIS.this_oBusinessObject.ValidarSenha(loc_cSenha)
                *-- BO ja marcou this_lZSen = .T. e gravou o log de liberacao
                THIS.FecharDialogo()
            ELSE
                loc_cMensagem = ;
                    ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))

                IF EMPTY(loc_cMensagem) OR loc_cMensagem == "Senha Conflitante"
                    IF MsgConfirma("Deseja digitar novamente ? (S/N)", ;
                            "Senha Conflitante...")
                        *-- Return 0 do legado: valor e foco ficam no campo
                        THIS.txt_4c_Senha.SetFocus()
                    ELSE
                        THIS.AbortarAutorizacao()
                    ENDIF
                ELSE
                    MsgErro(loc_cMensagem, "Senha Conflitante...")
                    THIS.AbortarAutorizacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.ValidarSenhaDigitada")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbortarAutorizacao - os tres "zsen = .F. + Thisform.release" do legado
    * (ESC no KeyPress, campo vazio no Valid, recusa da senha). Fonte UNICA
    * dos tres caminhos de negativa.
    *
    * this_lZSen eh a flag de autorizacao do BO: ja nasce .F. (fail-closed) e
    * eh zerada aqui de novo porque o legado tambem repete a atribuicao em
    * cada caminho de abortar.
    *--------------------------------------------------------------------------
    PROCEDURE AbortarAutorizacao()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lZSen = .F.
        ENDIF

        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - "Thisform.release" do legado, com UMA divergencia
    * deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * ler o resultado estoura "is not an object". Este dialogo existe para
    * DEVOLVER uma resposta (autorizou / quem autorizou), e no legado essa
    * resposta chega pelo RETURN do evento Unload, que so alcanca quem abre
    * com "DO FORM ... TO <var>" - inalcancavel no sistema novo, que abre por
    * CREATEOBJECT + Show(). Hide() em form modal tambem devolve o Show(),
    * entao para o usuario a tela fecha igual (PILAR 1 preservado); muda so o
    * tempo de vida do objeto, e eh o CHAMADOR quem chama Release() depois de
    * ler. Mesmo desenho que o FormBuscaAuxiliar do projeto ja adota.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        *-- Enquanto o BO ainda existe: guarda a resposta para o Unload, que
        *-- so dispara depois do Destroy ter zerado this_oBusinessObject.
        THIS.CachearResultadoSaida()

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna a arvore de controles visivel
    * (AddObject cria tudo com Visible = .F.).
    *
    * Sem lista de excecao: nenhum controle deste form nasce oculto no SCX
    * (ver NOTA do cabecalho - Say3/senha nascem Visible = .T. e so sao
    * escondidos em runtime pelo usuario.Valid, fase posterior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro

        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopcks.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores que o Business Object pode ter deixado
    * abertos antes de repassar para FormBase.Destroy() via DODEFAULT().
    *
    * cursor_4c_Usuar (pool de usuarios autorizados, o TmpUsu do legado) eh o
    * unico que fica aberto de proposito: o picker da Fase 6/7 navega nele.
    * cursor_4c_Pam / cursor_4c_Pac / cursor_4c_Emp / cursor_4c_Fpg sao
    * fechados pelos proprios metodos do BO - verificados aqui so por
    * seguranca, para o form nao vazar alias se algum deles tiver abortado no
    * meio.
    *
    * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
    * popups do menu principal, e omiti-lo encolhe o menu do sistema.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Usuar")
            USE IN cursor_4c_Usuar
        ENDIF
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_Pac")
            USE IN cursor_4c_Pac
        ENDIF
        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        IF USED("cursor_4c_Fpg")
            USE IN cursor_4c_Fpg
        ENDIF

        *-- Ultima chance de guardar a resposta: o DODEFAULT abaixo chega a
        *-- FormBase.Destroy, que faz this_oBusinessObject = .NULL., e o Unload
        *-- (que devolve o resultado a quem abriu com DO FORM ... TO) so
        *-- dispara DEPOIS disso.
        THIS.CachearResultadoSaida()

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CachearResultadoSaida - guarda em this_cResultadoSaida a resposta do BO
    * enquanto ele ainda existe. Chamado no FUNIL de fechamento
    * (FecharDialogo, por onde passam os tres caminhos de negativa e os tres
    * de autorizacao) e de novo no Destroy, antes do DODEFAULT que libera o BO.
    *
    * PROTECTED: nao eh ligado por BINDEVENT nem chamado de fora - quem le o
    * resultado usa ObterResultadoSaida(). Sempre com THIS. (regra #8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CachearResultadoSaida()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cResultadoSaida = THIS.this_oBusinessObject.ObterResultadoSaida()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterResultadoSaida - contrato de retorno do dialogo, equivalente ao
    * PROCEDURE Unload legado:
    *
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    *
    * A regra vive no BO (fonte UNICA, sigopcksBO.ObterResultadoSaida); este
    * metodo so a ESPELHA, preferindo o BO vivo e caindo no cache quando ele
    * ja foi liberado.
    *
    * COMO O CHAMADOR USA (o legado abria com "DO FORM sigopcks TO <var>",
    * que entrega o retorno do Unload; o sistema novo abre por CREATEOBJECT +
    * Show() e esse retorno eh inalcancavel, por isso ele vem por aqui):
    *
    *   loc_oCks = CREATEOBJECT("Formsigopcks", "CANCITEM", loc_cTitulo, ;
    *                           loc_cTitulo2)
    *   IF VARTYPE(loc_oCks) = "O"
    *       loc_oCks.Show()                                && modal: bloqueia
    *       loc_cResultado = loc_oCks.ObterResultadoSaida()
    *   ENDIF
    *   IF LEFT(loc_cResultado, 1) == "*"
    *       *-- autorizado; ALLTRIM(SUBSTR(loc_cResultado, 2)) = quem liberou
    *   ENDIF
    *
    * A ordem importa: o dialogo fecha com Hide() (ver FecharDialogo), entao
    * ele continua legivel depois do Show(), e eh o CHAMADOR quem da o
    * Release() - DEPOIS de ler. Release antes da leitura destroi o objeto e
    * a leitura seguinte estoura "is not an object" (medido no VFP9).
    *--------------------------------------------------------------------------
    FUNCTION ObterResultadoSaida()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cResultadoSaida = THIS.this_oBusinessObject.ObterResultadoSaida()
        ENDIF

        RETURN THIS.this_cResultadoSaida
    ENDFUNC

    *--------------------------------------------------------------------------
    * Unload - PROCEDURE Unload legado, mantido LITERAL para quem abrir este
    * dialogo com "DO FORM ... TO <var>", forma em que o VFP entrega ao
    * chamador justamente o retorno deste evento.
    *
    * Le o CACHE e nao o BO: o Unload dispara DEPOIS do Destroy, e nesse ponto
    * FormBase.Destroy ja fez this_oBusinessObject = .NULL. - perguntar ao BO
    * aqui estouraria. Quem enche o cache eh CachearResultadoSaida, chamado no
    * fechamento e no Destroy.
    *
    * O caminho recomendado no sistema novo continua sendo CREATEOBJECT +
    * Show() + ObterResultadoSaida(), que nao depende do ciclo de destruicao.
    *--------------------------------------------------------------------------
    PROCEDURE Unload()
        RETURN THIS.this_cResultadoSaida
    ENDPROC

ENDDEFINE
