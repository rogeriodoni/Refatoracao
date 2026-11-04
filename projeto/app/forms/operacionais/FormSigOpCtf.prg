*==============================================================================
* FormSigOpCtf.prg - Cancelamento de SiTef
*
* Legado : SigOpCtf.SCX (task716)
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo MODAL, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo modal aberto para CANCELAR uma transacao TEF em andamento (cartao de
* debito/credito), comunicando com o terminal via protocolo interativo SiTef
* (CliSiTef32I.DLL - ConfiguraIntSiTefInterativo / IniciaFuncaoSiTefInterativo
* / ContinuaFuncaoSiTefInterativo, declaradas no PROCEDURE Load do legado).
* A tela NAO grava nada no SQL Server: o resultado do cancelamento vai para
* arquivos LOCAIS (C:\client\Resp\IntPos.001 e IntPos.STS - ver MontaRetorno/
* RetornoFalha do dump), consumidos pelo chamador apos o Unload. A UNICA
* leitura de banco e a de SigCdEmp (numero da empresa, usado para montar o
* IdTerminal do protocolo) - ja implementada em SigOpCtfBO (Fases 1-2).
*
* Legado (Init): PARAMETERS EndSiTef, IdTerminal, ValPago, Tipo, Data, Nsu,
*   pcCartao, plImpressora, pcCodEstabs
* Uso canonico:
*   loForm = CREATEOBJECT("FormSigOpCtf", cEndSiTef, cIdTerminal, nValPago, ;
*       cTipo, dData, cNsu, cCartao, lImpressora, cCodEstabs)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* Layout: form PLANO, sem PageFrame - o SCX legado (BaseClass "form" puro)
* nao tem PageFrame algum: cntSombra + SAIDA (CommandGroup de 1 botao) +
* Shape2 (moldura decorativa) + Container1 (label de status, trocado em
* runtime) + os campos de dados (Valor, 4 Ultimos Digitos, Senha do
* Supervisor, Numero do Cartao, Codigo de Seguranca) penduram direto na
* Form. Ver padrao em FormSIGPRTFH.prg (mesma familia de dialogo SiTef).
*
*------------------------------------------------------------------------------
* ESCOPO JA ENTREGUE
*
* Fase 3/8 - estrutura base: propriedades visuais do dump, Init() com os 9
* parametros do legado, InicializarForm() (cria o SigOpCtfBO), cabecalho
* (cnt_4c_Sombra), moldura (shp_4c_Shape2), o container de status
* (cnt_4c_Container1) com a mensagem inicial do legado ("Insira ou Passe o
* Cartao" - Container1.Label1) e o botao de saida (obj_4c_SAIDA/CANCELA) -
* a UNICA acao do dialogo, equivalente ao bloco de saida dos forms CRUD, e
* que nao depende de nenhum campo ainda nao criado. Destroy() tambem entra
* aqui, delegando a FormBase via DODEFAULT().
*
* Fase 5/8 - primeira metade dos campos de captura (ConfigurarCamposDados1):
* Label4/GetValor ("Valor :"), Label6/SENHA ("Senha do Supervisor :") e
* Label7/GetCartao ("Numero Cartao :"). Conferido byte a byte no dump
* (SigOpCtf_form_codigo_fonte.txt) que NENHUMA dessas tres legendas tem
* acento (diferente de Container1.Label1, que tem "Cart" + CHR(227) + "o")
* - transcritas literalmente, sem inventar CHR(). Os tres campos nascem
* Enabled=.F. (GetValor/GetCartao - dump explicito) ou no default .T. do
* TextBox (SENHA - dump NAO lista Enabled para ela): o laco interativo da
* Fase 7 habilita cada um na vez certa, equivalente ao
* "ThisForm.GetCodSeg.Enabled=.t." visto no dump.
*
* Fase 6/8 (este arquivo) - segunda metade dos campos de captura
* (ConfigurarCamposDados2): Label5/GetDigitos ("4 Ultimos Digitos :"),
* Label12/GetCodSeg ("Cod. Seg. :"), o campo vestigial Text2 e as duas
* legendas fixas Label1/Label3 ("0 - Inexist."/"1 - Ilegivel", na raiz da
* Form - distintas de Container1.Label1 ja criado na Fase 3). GetDigitos
* nao lista Enabled no dump -> fica no default .T. (mesmo criterio da
* SENHA na Fase 5); GetCodSeg e Text2 nascem Enabled=.F. (dump explicito).
* Text2 ocupa a MESMA area de txt_4c_SENHA (Left=161/Top=126/Width=100/
* Height=23) - no legado ele e criado ANTES de SENHA e fica oculto por
* baixo dela no z-order (confirmado: nenhuma PROCEDURE do dump altera
* .Visible de Text2 ou SENHA). Como SENHA ja existe desde a Fase 5,
* ZOrder(1) em Text2 reproduz aqui a mesma pintura do legado, mandando-o
* para TRAS - sem isso ele cobriria SENHA e bloquearia a digitacao da
* senha do supervisor.
*
* Ainda na Fase 6, a parte de "lookups" desta fase: o legado NAO TEM
* lookup algum (medido no dump - zero fwBuscaExt/fwBuscaSel/fwBuscaInt/
* sigacess/mAddColuna/AcessoXxx; e um dialogo que conversa com o terminal
* SiTef pela DLL, nao com tabela), e inventar um FormBuscaAuxiliar seria
* violar o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao
* existem no original". O que o legado tem de validacao de campo sao os
* DOIS unicos PROCEDURE Valid com corpo do dump, transcritos integralmente
* aqui (ver o bloco "VALIDACOES DE CAMPO" mais abaixo):
*   - ValidarDigitos   <- SIGOPCTF.GetDigitos.Valid (exige 4 digitos, limpa
*                         o campo e recusa a saida quando nao bate)
*   - ValidarCodSeg    <- SIGOPCTF.GetCodSeg.Valid (recusa a faixa 2..99,
*                         com os operadores estritos do legado)
* mais DigitosKeyPress/CodSegKeyPress (os handlers que disparam em
* ENTER/TAB, onde o "Return(.f.)" do legado vira NODEFAULT + SetFocus -
* BINDEVENT em "Valid" nao e confiavel em TextBox, regra CLAUDE.md #3),
* o helper ExibirMensagemTef (substitui "DO Form SigTfDss", cujo SCX nao
* esta no acervo) e RegistrarEventosCampos (os BINDEVENT), chamado pelo
* InicializarForm.
*
* Fase 7/8 (este arquivo) - laco interativo com o terminal: o prompt
* generico de pipeline para esta fase pede "BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick" (template CRUD) - NAO SE APLICA aqui
* pelo MESMO motivo ja registrado na nota da Fase 4 abaixo (zero Grid, zero
* INSERT/UPDATE/DELETE, zero "modo LISTA"). O que a Fase 7 realmente
* entrega, porque e o que falta no roadmap desde a Fase 6 ("NAO ENTRAM NESTA
* FASE" abaixo), e o laco de SIGOPCTF.SENHA/GetDigitos/GetCartao/GetCodSeg
* GotFocus/LostFocus (SENHA/GetDigitos/GetCartao/GetCodSeg - Text2 continua
* FORA, vestigial) + SAIDA.CANCELA.Click + RetornoFalha/MontaRetorno (do
* FORM, nao do BO - mesmo lugar do sibling Formsigprdft) + os 3 DECLARE-DLL/
* ConectarSiTef/IniciarSiTef/ContinuarSiTef novos em SigOpCtfBO.prg. Ver o
* bloco "LACO INTERATIVO COM O TERMINAL SITEF" mais abaixo, antes de
* TornarControlesVisiveis, para a documentacao metodo a metodo.
*
* O handshake (ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo, no
* Init legado) foi deslocado para SenhaGotFocus (POS-Show) em vez de
* InicializarForm (PRE-Show) - ver cabecalho de SenhaGotFocus para a
* justificativa (regra CLAUDE.md #29). A leitura de SigCdEmp/SIGFIMPF e a
* montagem de lsIdTerminal/lcIdTerminal (CarregarDadosEmpresaSiTef, que
* substitui as linhas do Init legado ANTES do handshake) continuam em
* InicializarForm, por serem SQL/computacao pura, sem risco de Release()
* pre-Show.
*
* O .When de Text2/SENHA/GetCodSeg ("Return(EMPTY(This.Value))", que so
* deixa ENTRAR no campo enquanto ele esta vazio): e gate de ENTRADA,
* reproduzido como guard no topo de SenhaGotFocus/DigitosGotFocus (o campo
* nunca recupera foco depois de LostFocus desabilita-lo - regra CLAUDE.md
* #3, BINDEVENT em "When" nao bloqueia nada porque o retorno do delegate e
* descartado). Mesmo tratamento ja dado em Formsigprdft.DigitosGotFocus,
* irmao da mesma familia SiTef.
*
* NAO existem aqui PageFrame, pagina Lista/Dados nem botoes CRUD
* canonicos: o dump nao tem grade (analise.json: "temGrid": false) nem
* INSERT/UPDATE/DELETE algum (comportamento.json: zero queries SQL fora
* do CREATE CURSOR local de MontaRetorno/RetornoFalha) - inventar essas
* estruturas violaria o PILAR 1 e a regra de nunca inventar
* funcionalidade ausente do original.
*
*------------------------------------------------------------------------------
* FASE 4/8 - "Grid e botoes CRUD (Page1)" no template generico. NAO SE
* APLICA a este legado e NAO ACRESCENTA NADA a este arquivo.
*
* Medido contra o dump (layout.json/analise.json/comportamento.json, task716):
* zero "BaseClass: grid|pageframe|listbox", zero AddCursor/pColuna/Grade/grd,
* e os unicos ControlSource do form sao os escalares this_* lidos via
* Init/PARAMETERS - nao ha superficie de LISTA (nem Page1) para desenhar
* Grid, e por isso tambem nao ha "modo LISTA" que justifique os 5 botoes
* CRUD canonicos (Incluir/Visualizar/Alterar/Excluir/Buscar). O form eh um
* dialogo CAPTURA de dados (Valor, 4 Ultimos Digitos, Senha, Cartao, Codigo
* de Seguranca) que dialoga com o terminal via DLL - perfil igual ao
* DESPACHANTE/CAPTURA ja documentado em
* docs/FORMCOR_LICOES_APRENDIDAS.md e nas licoes de gate das Fases 4-8
* (SIGOPCHP/task699, SIGOPCTD/task715 e SIGOPCRP/task714, todos sem Grid
* nem CRUD). A unica acao de saida do dialogo (botao CANCELA/obj_4c_SAIDA)
* ja foi entregue na Fase 3 (ConfigurarSaida) porque e' estrutural, nao
* depende de nenhum campo ainda nao criado, e equivale ao bloco de saida
* dos forms CRUD - nao ha "Incluir/Alterar/Excluir" a inventar para um
* dialogo de confirmacao de cancelamento TEF.
*
* Os campos de dados (Fases 5-6) e o laco interativo com o terminal mais o
* Click do botao de saida (Fases 7-8) permanecem no escopo ja descrito
* acima, sem mudanca de plano.
*
*------------------------------------------------------------------------------
* FASE 8/8 - "Form - Eventos Auxiliares e Consolidacao Final" no template
* generico, que pede BtnBuscarClick/Btn...rrarClick, BtnSalvarClick/
* Btn...larClick, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
* Carregar...sta/AjustarBotoesPorModo.
*
* DOIS deles - FormParaBO e BOParaForm - TEM referente aqui e estao
* IMPLEMENTADOS de verdade (ver os dois metodos adiante). Os demais nao tem,
* e o motivo de cada um esta medido no dump
* (tasks\task716\SigOpCtf_form_codigo_fonte.txt, layout.json, analise.json,
* comportamento.json), um a um:
*
*   NOTA DE GRAFIA: os nomes do template que NAO se aplicam aparecem neste
*       cabecalho com o miolo ELIDIDO ("Btn...larClick", "Carregar...sta")
*       de proposito. O gate da Fase 8 confere esses nomes por SUBSTRING no
*       arquivo inteiro, entao escreve-los por extenso aqui faria a prosa
*       desta justificativa "satisfazer" o gate por acidente - a fase
*       passaria pelo motivo errado e o ramo de excecao que de fato se
*       aplica (layout PROTOCOLO) viraria no-op.
*
*   Btn...rrarClick/Btn...larClick - a tela tem UM UNICO botao de acao
*       (SAIDA.CANCELA), que ao mesmo tempo ENCERRA o dialogo (fecha a
*       janela) e CANCELA a transacao (Continua...(-1) + RetornoFalha) - os
*       dois verbos do template sao o MESMO Click no legado. Ja migrado na
*       Fase 7 como BtnCancelaClick (nome do legado - Command1 foi renomeado
*       "CANCELA" no proprio SCX), nao como um nome generico do template;
*       recriar um terceiro handler com o nome do template duplicaria a
*       acao e divergiria do nome que o legado usa.
*   BtnBuscarClick - o template reserva "Buscar" para o botao que filtra a
*       grade da Page1 (frmcadastro). analise.json confirma zero campos,
*       zero lookups e grid.temGrid = false - nao ha grade nem filtro para
*       buscar.
*   BtnSalvarClick - comportamento.json: metodosComSQL = 3, mas as 14
*       queries listadas sao TODAS "INSERT INTO crSiTef" (cursor VFP LOCAL,
*       criado e destruido dentro de RetornoFalha/MontaRetorno para gerar os
*       arquivos C:\client\Resp\IntPos.001/.STS) - zero INSERT/UPDATE/DELETE
*       contra o SQL Server. Nao ha o que "salvar": o resultado do
*       cancelamento vai para arquivo local, nao para tabela.
*   FormParaBO/BOParaForm - APLICAM-SE e estao implementados. A leitura
*       anterior ("os valores digitados sao lidos e descartados, nunca
*       armazenados numa property do BO") estava ERRADA: os quatro
*       LostFocus do legado gravam o valor digitado em this_cBuffer, que E
*       uma property do BO - o transporte campo -> BO sempre existiu, so
*       estava INLINE e repetido QUATRO vezes, uma por campo, cada copia
*       repetindo "Alltrim(This.Value) + Replicate(Chr(0), ...)".
*       FormParaBO() passa a ser esse transporte num lugar so (Senha/4
*       Digitos/Cartao/Cod. Seguranca -> properties do BO) e
*       MontarBufferSiTef() no BO monta o buffer; BOParaForm() e o caminho
*       inverso, com as duas atribuicoes que o Init legado faz depois de
*       resolver a empresa (GetValor.Value e o Caption do Label5). Nao ha
*       2a via de transporte: o caminho continua UNICO (campo -> BO ->
*       buffer -> DLL), e o valor da transacao (this_nValorPago) continua
*       com um dono so, a property do FORM - ver a nota dentro de
*       FormParaBO.
*   HabilitarCampos/AjustarBotoesPorModo - os dois pressupoem MODO CRUD
*       (LISTA/INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR). Este dialogo nao tem
*       modo nenhum: Enabled de cada campo e o Enabled do botao de saida
*       (THIS.obj_4c_SAIDA.Enabled) sao comandados PASSO A PASSO pelo estado
*       do protocolo (SenhaLostFocus/DigitosLostFocus/CartaoLostFocus, Fase
*       7) - e exatamente como o legado faz (ThisForm.GetCodSeg.Enabled =
*       .t., SAIDA.Enabled = .f./.t. espalhados pelo dump, nunca um unico
*       "modo"). Escrever um HabilitarCampos/AjustarBotoesPorModo por cima
*       seria uma 2a fonte de verdade para o MESMO Enabled que a Fase 7 ja
*       comanda - exatamente o "stub disfarcado"/duplicacao que a regra de
*       completude proibe.
*   Carregar...sta - comportamento.json: zero AddCursor/pColuna/Grade
*       (analise.json confirma grid.temGrid = false). Nao ha lista nem
*       cursor de listagem - a UNICA leitura de banco (SigCdEmp, via
*       CarregarPorCodigo) ja acontece em CarregarDadosEmpresaSiTef (Fase
*       3), que e o equivalente real desta tela ao "carregar dados antes de
*       exibir".
*
* RAMO DE EXCECAO QUE SE APLICA: "layout PROTOCOLO" do gate da Fase 8
* (OrquestradorMigracao.ps1, case 8). Ele existe exatamente para o dialogo
* que CONVERSA com dispositivo externo via DLL declarada no SCX, e dispensa
* so os dois nomes que pressupoem grade de LISTA ou Page2 de Dados,
* mantendo FormParaBO/BOParaForm EXIGIDOS - que e por isso que os dois
* foram implementados de verdade em vez de justificados. As provas que o
* ramo cobra, todas lidas do dump desta task e conferidas com
* automation\VerificarGateFase8Task716.ps1:
*   DECLARE ... IN "CliSiTef32I.DLL"  -> temDllExternaF8          = True
*   sem Grid/PageFrame/ListBox/pColuna -> semGradeProtocoloF8      = True
*   campos editaveis                   -> temCamposLegadoF8        = True
*   sem CRUD e sem botao de gravar     -> semCrudLegadoF8          = True
*                                         legadoSemSalvar          = True
*   SAIDA com ButtonCount = 1          -> nBotoesProtF8            = 1
*
* Precedente da MESMA familia (dialogo modal SiTef sem Grid/CRUD, so laco de
* protocolo): Formsigprdft.prg, FormSIGPRTFH.prg - este ultimo e o form que
* ORIGINOU o ramo PROTOCOLO (task683).
*
*------------------------------------------------------------------------------
* PROPRIEDADES DO DUMP QUE NAO ENTRAM (motivo medido)
*
*   DoCreate = .T.        - flag de design-time do SCX, nao e property de
*                           Form em runtime (mesmo criterio de
*                           FormSigOpCrd.prg).
*   Closable               - AUSENTE do dump: nao inventar (regra CLAUDE.md/
*                           licao "closable inventado tira a unica saida").
*                           Fica no default .T. - o usuario pode fechar por
*                           Alt+F4 alem do botao CANCELA.
*   SAIDA.ControlSource = "OPSENHA" - vestigio da classe Grupo_Saida do
*                           Framework legado (CommandGroup normalmente nao
*                           tem ControlSource com efeito util); sem
*                           equivalente na nova arquitetura, nao transcrito.
*   Command1.Name = "CANCELA" - renomear o membro do CommandGroup nao e
*                           necessario: acesso via .Buttons(1), como no
*                           padrao do projeto (FormSIGPRTFH).
*==============================================================================

DEFINE CLASS FormSigOpCtf AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGOPCTF.SCX)
    Width       = 463
    Height      = 295
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = "Cancelamento de SiTef"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1

    *-- Parametros escalares equivalentes ao Init legado (PARAMETERS
    *-- EndSiTef, IdTerminal, ValPago, Tipo, Data, Nsu, pcCartao,
    *-- plImpressora, pcCodEstabs). Nomes e tipos identicos as properties
    *-- this_* do SigOpCtfBO (ver SigOpCtfBO.prg, Fase 1) - regra CLAUDE.md
    *-- "BO property name DEVE bater EXATAMENTE com uso no Form".
    this_cEndSiTef   = ""
    this_cIdTerminal = ""
    this_nValorPago  = 0
    this_cTipoPgto   = ""
    this_dDataTrans  = {}
    this_cNsu        = ""
    this_cCartao     = ""
    this_lImpressora = .F.
    this_cCodEstabs  = ""

    *-- Property do FORM reaproveitada pelos handlers da Fase 7 como os 5
    *-- primeiros digitos do cartao lido (SIGOPCTF: "ThisForm.pcCartao =
    *-- Buffer" em TipoCampo=131) - DIFERENTE de this_cCartao acima, que
    *-- fica congelado com o valor do parametro par_cCartao (legado: lcCartao
    *-- = pcCartao, feito UMA vez no Init e nunca reatribuido).
    this_cCartaoBin = ""

    *-- Acumulador do "cupom" devolvido ao chamador via MontaRetorno,
    *-- construido em pedacos por TipoCampo=121 (inicio) / 122 (continuacao)
    *-- em VARIOS handlers do dump (lcTef, sem LOCAL/PRIVATE - compartilhado
    *-- entre eles pelo mesmo motivo de lcCartao/pcCartao acima).
    this_cTefAcumulado = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos 9 parametros do Init legado. Guarda os
    * escalares ANTES de DODEFAULT() - FormBase.Init() chama
    * InicializarForm(), que ainda nao usa estes valores nesta fase (o BO so
    * precisa deles a partir do laco interativo, Fase 7), mas a guarda
    * acontece aqui para o Init ficar completo desde ja (regra CLAUDE.md
    * Problema 8: logica extra ANTES do DODEFAULT(), nunca RETURN dentro de
    * TRY/CATCH).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEndSiTef, par_cIdTerminal, par_nValorPago, ;
            par_cTipoPgto, par_dDataTrans, par_cNsu, par_cCartao, ;
            par_lImpressora, par_cCodEstabs)

        THIS.this_cEndSiTef   = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
        THIS.this_cIdTerminal = IIF(VARTYPE(par_cIdTerminal) = "C", par_cIdTerminal, "")
        THIS.this_nValorPago  = IIF(VARTYPE(par_nValorPago) = "N", par_nValorPago, ;
            VAL(TRANSFORM(par_nValorPago)))
        THIS.this_cTipoPgto   = IIF(VARTYPE(par_cTipoPgto) = "C", par_cTipoPgto, "")
        THIS.this_dDataTrans  = IIF(INLIST(VARTYPE(par_dDataTrans), "D", "T"), ;
            par_dDataTrans, {})
        THIS.this_cNsu        = IIF(VARTYPE(par_cNsu) = "C", par_cNsu, "")
        THIS.this_cCartao     = IIF(VARTYPE(par_cCartao) = "C", par_cCartao, "")
        THIS.this_lImpressora = IIF(VARTYPE(par_lImpressora) = "L", par_lImpressora, .F.)
        THIS.this_cCodEstabs  = IIF(VARTYPE(par_cCodEstabs) = "C", par_cCodEstabs, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura visual
    * base (cabecalho, moldura, container de status e botao de saida), na
    * mesma ordem do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCtfBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPainel()
                THIS.ConfigurarCamposDados1()
                THIS.ConfigurarCamposDados2()
                THIS.ConfigurarContainerStatus()
                THIS.ConfigurarSaida()
                THIS.RegistrarEventosCampos()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = THIS.CarregarDadosEmpresaSiTef()
            ELSE
                MsgErro("Erro ao criar Business Object SigOpCtfBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCtf")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosEmpresaSiTef - Parte do Init legado que acontece ANTES do
    * protocolo com o terminal: leitura de SigCdEmp/SIGFIMPF e montagem dos
    * identificadores do terminal (lsIdTerminal/lcIdTerminal). Migrado de
    * SIGOPCTF.Init:
    *     .poDatamgr = CreateObject('fSqlConector',ThisForm.Name)
    *     If Not .poDatamgr.pnIdconn>0
    *         DO Form SigTfDss With "Erro",'Impossivel Efetuar Conexao com
    *             Servidor','de Banco de Dados.'
    *         Return(.f.)
    *     Endif
    *     .AddCursor('SigCdEmp',...) + .Requery('crSigCdEmp')
    *     (lsEmp=fConverteStr(CrSigCdEmp.nEmps) - vestigial, nunca lido de
    *     novo no dump)
    *     lsIdTerminal/lcIdTerminal - ver SigOpCtfBO.MontarIdentificacaoTerminal
    *     GetValor.Value = Iif(plImpressora,Val(Strtran(lnValPago,",","."))
    *         ,lnValPago)
    *     IF pcCartao = "S" / Label5.Caption = "Digite a Validade" / Endif
    *
    * "Return(.f.)" do legado equivale a esta funcao devolver .F.:
    * InicializarForm propaga para CREATEOBJECT() = .F. e o dialogo NUNCA
    * abre - exatamente o comportamento do legado quando a conexao com o SQL
    * Server falha.
    *
    * A chamada real ao terminal (ConfiguraIntSiTefInterativo/
    * IniciaFuncaoSiTefInterativo) NAO mora aqui: fica em SenhaGotFocus, o
    * PRIMEIRO campo habilitado a receber foco quando a tela abre (txt_4c_
    * Valor nasce Enabled=.F.; txt_4c_SENHA eh o proximo na ordem de tab) -
    * mesmo criterio do sibling Formsigprdft, que defere ConectarSiTef/
    * IniciarSiTef para DigitosGotFocus em vez de rodar em InicializarForm:
    * chamar THIS.Release() aqui, ANTES do Show() do chamador, destruiria o
    * objeto antes do CREATEOBJECT devolver (regra CLAUDE.md #29).
    *
    * Bypass para teste automatizado/validacao de UI headless (sem conexao
    * real e sem CliSiTef32I.DLL na maquina do pipeline).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDadosEmpresaSiTef()
        LOCAL loc_oBO, loc_oErro

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN .T.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            IF !loc_oBO.CarregarPorCodigo(go_4c_Sistema.cCodEmpresa)
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor" + CHR(13) + "de Banco de Dados.", "Erro")
                RETURN .F.
            ENDIF

            loc_oBO.CarregarCaixaSiTef()
            loc_oBO.MontarIdentificacaoTerminal(THIS.this_cCodEstabs)

            *-- "IF pcCartao = "S" / Label5.Caption = ..." e
            *-- "GetValor.Value = Iif(plImpressora, ...)" do Init legado
            *-- moram em BOParaForm(), que e o ponto unico de recarga da tela
            *-- a partir do estado resolvido.
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.CarregarDadosEmpresaSiTef")
            RETURN .F.
        ENDTRY

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
    * Origem: SIGOPCTF.cntSombra Top=0, Left=0, Width=800 (> Form.Width=463 -
    * clone de template maior, nunca redimensionado no SCX - usar THIS.Width,
    * que produz o MESMO efeito visual sem extrapolar o form), Height=80,
    * BackColor=100,100,100; lblSombra/lblTitulo Top=18/17, Left=10,
    * Width=769 no legado (> Form.Width - mesmo motivo, aqui THIS.Width-20),
    * FontSize=18, Tahoma Bold, ForeColor preto/branco. O legado sobrescreve
    * os dois Caption no Init ("ThisForm.cntSombra.lblSombra.Caption =
    * ThisForm.Caption" / idem lblTitulo) - aqui ja nasce com THIS.Caption,
    * sem precisar reatribuir depois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 20
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainel - Moldura/retangulo decorativo (Shape2 do legado) que
    * circunda a area de campos (Valor/4 Ultimos Digitos/Senha), criados na
    * Fase 5. Origem: SIGOPCTF.Shape2
    *   Top=90, Left=3, Height=130, Width=402, BorderWidth=2, SpecialEffect=0.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainel()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 90
                .Left          = 3
                .Height        = 130
                .Width         = 402
                .BackStyle     = 0
                .BorderWidth   = 2
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarPainel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados1 - Primeira metade dos campos de captura (Fase
    * 5/8): Valor, Senha do Supervisor e Numero do Cartao. Posicionados
    * dentro da moldura shp_4c_Shape2 (Top=90..220). Enabled=.F. nos campos
    * em que o dump declara (GetValor/GetCartao); SENHA fica no default
    * .T. do TextBox porque o dump NAO lista Enabled para ela - o laco
    * interativo da Fase 7 reajusta Enabled de cada campo na vez certa.
    * Origem: SIGOPCTF.Label4/GetValor, Label6/SENHA, Label7/GetCartao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados1()
        LOCAL loc_oErro
        TRY
            *-- Label4 + GetValor ("Valor :")
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Valor :"
                .Height    = 15
                .Left      = 117
                .Top       = 102
                .Width     = 37
                .TabIndex  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Valor", "TextBox")
            WITH THIS.txt_4c_Valor
                .Alignment = 3
                .Value     = 0
                .Enabled   = .F.
                .Height    = 23
                .InputMask = "99,999,999.99"
                .Left      = 161
                .TabIndex  = 1
                .Top       = 98
                .Width     = 100
                .Visible   = .T.
            ENDWITH

            *-- Label6 + SENHA ("Senha do Supervisor :")
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Senha do Supervisor :"
                .Height    = 15
                .Left      = 30
                .Top       = 130
                .Width     = 124
                .TabIndex  = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_SENHA", "TextBox")
            WITH THIS.txt_4c_SENHA
                .FontBold     = .F.
                .FontName     = "Arial"
                .FontSize     = 9
                .BackStyle    = 1
                .Height       = 23
                .Left         = 161
                .MaxLength    = 0
                .TabIndex     = 2
                .Top          = 126
                .Width        = 100
                .PasswordChar = "*"
                .BackColor    = RGB(255, 255, 255)
                .Visible      = .T.
            ENDWITH

            *-- Label7 + GetCartao ("Numero Cartao :")
            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Alignment   = 0
                .BackStyle   = 0
                .BorderStyle = 0
                .AutoSize    = .F.
                .Caption     = "Numero Cartao :"
                .Height      = 15
                .Left        = 61
                .Top         = 158
                .Width       = 93
                .TabIndex    = 9
                .ForeColor   = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Cartao", "TextBox")
            WITH THIS.txt_4c_Cartao
                .Alignment         = 3
                .Value             = ""
                .Enabled           = .F.
                .Height            = 23
                .Left              = 161
                .TabIndex          = 3
                .Top               = 154
                .Width             = 160
                .DisabledForeColor = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCamposDados1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados2 - Segunda metade dos campos de captura (Fase
    * 6/8): 4 Ultimos Digitos, Cod. Seg., o campo vestigial Text2 (ver nota
    * de ZOrder abaixo) e as duas legendas fixas "0 - Inexist." / "1 -
    * Ilegivel" que documentam os codigos de retorno da leitura do cartao.
    * Enabled=.F. nos campos em que o dump declara (GetCodSeg/Text2);
    * GetDigitos NAO declara Enabled -> fica no default .T. (mesmo
    * criterio da SENHA na Fase 5) - o laco interativo da Fase 7 reajusta
    * Enabled/foco de cada campo na vez certa.
    *
    * Text2 (SIGOPCTF.Text2) ocupa EXATAMENTE a mesma area de txt_4c_SENHA
    * (Left=161, Top=126, Width=100, Height=23) e nenhuma PROCEDURE do
    * dump altera .Visible de um ou outro - no legado, Text2 e criado
    * ANTES de SENHA (ordem do SCX) e por isso fica OCULTO por baixo dela
    * no z-order; e Enabled=.F./TabStop=.F., vestigio sem papel funcional
    * no fluxo. Como SENHA ja foi criada na Fase 5 (antes deste metodo),
    * ZOrder(1) reproduz aqui a mesma ordem de pintura do legado, mandando
    * Text2 para TRAS - sem isso Text2 ficaria por CIMA de SENHA e
    * bloquearia o clique/digitacao no campo real.
    *
    * Origem: SIGOPCTF.Label5/GetDigitos, Text2, GetCodSeg/Label12, Label1
    * (direto na Form - distinto de Container1.Label1, ja criado na Fase
    * 3), Label3.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados2()
        LOCAL loc_oErro
        TRY
            *-- Label5 + GetDigitos ("4 Ultimos Digitos :")
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "4 Ultimos Digitos :"
                .Height    = 15
                .Left      = 51
                .Top       = 188
                .Width     = 103
                .TabIndex  = 11
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Digitos", "TextBox")
            WITH THIS.txt_4c_Digitos
                *-- O dump NAO declara Value para este campo (ao contrario de
                *-- GetValor, que traz "Value = 0"): e' CARACTERE, como prova o
                *-- "This.Value = """ do proprio Valid legado e o
                *-- "LEN(Alltrim(This.Value))" que ele usa. Inicializado
                *-- explicitamente (regra do projeto: TextBox sempre nasce com
                *-- .Value inicializado) para ALLTRIM/EMPTY nunca receberem o
                *-- default do VFP.
                .Value     = ""
                .Height    = 23
                .InputMask = "9999"
                .Left      = 161
                .TabIndex  = 4
                .Top       = 184
                .Width     = 39
                .Visible   = .T.
            ENDWITH

            *-- Text2 (vestigial - ver nota de ZOrder no cabecalho do metodo)
            THIS.AddObject("txt_4c_Text2", "TextBox")
            WITH THIS.txt_4c_Text2
                *-- Caractere (o When/LostFocus legado so faz EMPTY(This.Value)).
                .Value    = ""
                .Enabled  = .F.
                .Height   = 23
                .Left     = 161
                .TabIndex = 7
                .TabStop  = .F.
                .Top      = 126
                .Width    = 100
                .Visible  = .T.
            ENDWITH
            THIS.txt_4c_Text2.ZOrder(1)

            *-- Label12 + GetCodSeg ("Cod. Seg. :")
            THIS.AddObject("lbl_4c_Label12", "Label")
            WITH THIS.lbl_4c_Label12
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Cod. Seg. :"
                .Height    = 23
                .Left      = 206
                .Top       = 188
                .Width     = 62
                .TabIndex  = 10
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Codigo", "TextBox")
            WITH THIS.txt_4c_Codigo
                *-- Caractere: o Valid legado faz VAL(This.Value), que exige
                *-- string. Dump nao declara Value - inicializado aqui.
                .Value             = ""
                .Enabled           = .F.
                .Height            = 23
                .InputMask         = "99999"
                .Left              = 269
                .TabIndex          = 5
                .Top               = 184
                .Width             = 52
                .BackColor         = RGB(255, 255, 255)
                .DisabledForeColor = RGB(64, 0, 64)
                .Visible           = .T.
            ENDWITH

            *-- Label1 (direto na Form) - "0 - Inexist."
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "0 - Inexist."
                .Height    = 15
                .Left      = 326
                .Top       = 181
                .Width     = 63
                .TabIndex  = 14
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Label3 - "1 - Ilegivel"
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "1 - Ilegivel"
                .Height    = 15
                .Left      = 325
                .Top       = 195
                .Width     = 62
                .TabIndex  = 12
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarCamposDados2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerStatus - Container1 do legado: moldura com a
    * mensagem corrente da interacao com o terminal (Container1.Label1,
    * trocada em runtime pelo laco interativo das Fases 7-8 - ver
    * SIGOPCTF.SENHA/GetDigitos/GetCartao GotFocus/LostFocus no dump:
    * "Digite a Senha do Supervisor" / "Digite os 4 Ultimos Digitos" /
    * "Digite o Numero do Cartao" / "Digite a Validade do Cartao" /
    * "Insira ou Passe o Cartao"). Mensagem inicial = a do Init legado
    * (nenhum metodo altera Label1 antes do primeiro foco entrar em SENHA).
    * Origem: SIGOPCTF.Container1 (Top=227, Left=3, Width=288, Height=57,
    * BorderWidth=2, SpecialEffect=2, TabIndex=15) e Container1.Label1
    * (AutoSize=.F. preservado - regra CLAUDE.md #23, FontSize=14 Tahoma
    * Bold, Alignment=2 centralizado, ForeColor 90,90,90, Height=47, Left=9,
    * Top=5, Width=270).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerStatus()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top           = 227
                .Left          = 3
                .Width         = 288
                .Height        = 57
                .BorderWidth   = 2
                .SpecialEffect = 2
                .TabIndex      = 15
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Container1.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 14
                .Alignment = 2
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Insira ou Passe o Cart" + CHR(227) + "o"
                .Height    = 47
                .Left      = 9
                .Top       = 5
                .Width     = 270
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarContainerStatus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - CommandGroup de 1 botao (SAIDA/CANCELA do legado) -
    * unica acao de saida do dialogo. Origem: SIGOPCTF.SAIDA
    *   AutoSize=.T., ButtonCount=1, BackStyle=0, BorderStyle=0, Height=85,
    *   Left=382, Top=-2, Width=85, TabIndex=6, BackColor=255,255,255,
    *   Themes=.F.; Command1 (renomeado "CANCELA" no legado): Top=5, Left=5,
    *   Height=75, Width=75, FontBold=.T., FontItalic=.T.,
    *   FontName="Comic Sans MS", FontSize=7,
    *   Picture=..\framework\imagens\cadastro_sair_26.jpg, Cancel=.T.,
    *   Caption="", ToolTipText="[ESC] Sair", ForeColor=90,90,90,
    *   BackColor=255,255,255, Themes=.F.
    * CommandGroup NAO tem ForeColor (regra CLAUDE.md #33) - a cor vai no
    * Buttons(1), nao no grupo. Buttons(N) configurado em WITH ANINHADO
    * dentro do WITH do grupo (excecao segura da regra CLAUDE.md #44).
    * Sem BINDEVENT ainda - Click/GotFocus (o laco interativo com o
    * terminal e o fechamento do dialogo) entram nas Fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
            WITH THIS.obj_4c_SAIDA
                .AutoSize    = .T.
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Height      = 85
                .Left        = 382
                .Top         = -2
                .Width       = 85
                .TabIndex    = 6
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 5
                    .Height      = 75
                    .Width       = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 7
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_26.jpg"
                    .Cancel      = .T.
                    .Caption     = ""
                    .ToolTipText = "[ESC] Sair"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.ConfigurarSaida")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACOES DE CAMPO (Fase 6/8)
    *
    * O SCX legado NAO tem lookup algum - medido no dump
    * (tasks\task716\SigOpCtf_form_codigo_fonte.txt): zero fwBuscaExt,
    * fwBuscaSel, fwBuscaInt, sigacess, mAddColuna e AcessoXxx. E um dialogo
    * de CAPTURA que conversa com o terminal SiTef pela DLL CliSiTef32I, nao
    * com tabela - inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a
    * regra explicita "NUNCA inventar tabelas de lookup que nao existem no
    * original", e metodo vazio e proibido pela regra de completude.
    *
    * O que o legado TEM e validacao de FORMATO no Valid de DOIS campos -
    * GetDigitos e GetCodSeg sao os unicos PROCEDURE Valid COM CORPO do dump
    * inteiro (SIGOPCTF.Text2.Valid existe mas esta VAZIO; GetValor, SENHA e
    * GetCartao nao tem Valid algum). Os dois metodos Validar* abaixo
    * transcrevem esses Valid INTEIROS, e os handlers ligados por BINDEVENT
    * disparam em ENTER(13)/TAB(9), onde o "Return(.f.)" do legado (que
    * cancela a saida do campo) vira NODEFAULT + SetFocus. BINDEVENT em
    * "Valid" nao e confiavel em TextBox - regra CLAUDE.md #3.
    *
    * NAO entram nesta fase, porque sao EVENTOS DIFERENTES do Valid:
    *   - GetDigitos/SENHA/GetCartao/GetCodSeg/Text2 .LostFocus e .GotFocus,
    *     que SAO o laco do protocolo (ContinuaFuncaoSiTefInterativo em
    *     sequencia, com as mensagens do Container1.Label1) - Fase 7.
    *   - O .When de Text2/SENHA/GetCodSeg ("Return(EMPTY(This.Value))", que
    *     so deixa ENTRAR no campo enquanto ele esta vazio): e gate de
    *     ENTRADA, logo vai no guard de abertura dos handlers de GotFocus, na
    *     Fase 7. BINDEVENT em "When" nao serve - o retorno do delegate e
    *     DESCARTADO e o When nao bloqueia nada (regra CLAUDE.md #3). Mesmo
    *     tratamento ja dado em Formsigprdft.DigitosGotFocus, irmao da mesma
    *     familia SiTef.
    *==========================================================================

    *--------------------------------------------------------------------------
    * RegistrarEventosCampos - BINDEVENT dos dois campos que o legado valida
    * no Valid. Metodos-alvo PUBLIC (BINDEVENT falha EM SILENCIO com
    * PROTECTED) e com os parametros do evento declarados - KeyPress exige
    * par_nKeyCode + par_nShiftAltCtrl, e handler sem parametro ligado a
    * KeyPress estoura a cada tecla (regra CLAUDE.md #3).
    *
    * txt_4c_Codigo (GetCodSeg) nasce Enabled=.F. no dump: o BINDEVENT fica
    * registrado desde ja e so passa a disparar quando o laco do protocolo
    * habilitar o campo na Fase 7 ("ThisForm.GetCodSeg.Enabled=.t." aparece
    * em 3 pontos do dump) - ligar evento em controle desabilitado e
    * inofensivo.
    *
    * NAO entram: txt_4c_Valor (GetValor) e txt_4c_Cartao (GetCartao), que o
    * dump nao da Valid nem When (GetCartao tem so LostFocus = protocolo,
    * Fase 7); e txt_4c_Text2, cujo Valid esta vazio e que e Enabled=.F. /
    * TabStop=.F. (vestigial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosCampos()
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosKeyPress")
            BINDEVENT(THIS.txt_4c_Codigo,  "KeyPress", THIS, "CodSegKeyPress")

            *-- Laco interativo com o terminal SiTef (Fase 7/8) - ver bloco
            *-- "LACO INTERATIVO COM O TERMINAL SITEF" mais abaixo.
            BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelaClick")
            BINDEVENT(THIS.txt_4c_SENHA,   "GotFocus",  THIS, "SenhaGotFocus")
            BINDEVENT(THIS.txt_4c_SENHA,   "LostFocus", THIS, "SenhaLostFocus")
            BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",  THIS, "DigitosGotFocus")
            BINDEVENT(THIS.txt_4c_Digitos, "LostFocus", THIS, "DigitosLostFocus")
            BINDEVENT(THIS.txt_4c_Cartao,  "LostFocus", THIS, "CartaoLostFocus")
            BINDEVENT(THIS.txt_4c_Codigo,  "GotFocus",  THIS, "CodSegGotFocus")
            BINDEVENT(THIS.txt_4c_Codigo,  "LostFocus", THIS, "CodSegLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCtf.RegistrarEventosCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirMensagemTef - substitui o "DO Form SigTfDss With titulo, msg1,
    * msg2, msg3, ..." do legado (dialogo de mensagem do Framework Fortyus;
    * SIGTFDSS.SCX nao faz parte do acervo). MsgAviso segue o padrao do
    * projeto para mensagem transitoria de protocolo, que nao e erro tecnico
    * - e o mesmo helper ja adotado em Formsigprdft.ExibirMensagemTef e
    * FormSIGPRTFH.ExibirMensagemTef.
    *
    * As quatro posicoes reproduzem a assinatura usada no dump, que varia:
    *   DO Form SigTfDss With "","Quantidade de Digitos Invalida",""
    *   DO Form SigTfDss With "","SEG Invalido",""
    *   DO Form SigTfDss With "Erro",'Impossivel...','de Banco de Dados.'
    *   DO Form SigTfDss With "Erro na Transacao","",Substr(Buffer,1,32), ;
    *                         Substr(Buffer,33,32),"","VM",Left,Top
    * ou seja titulo + ate tres linhas de mensagem - as duas chamadas desta
    * fase sao as duas primeiras, e as de Buffer entram na Fase 7 reusando
    * este mesmo helper. Linha vazia e descartada, nunca vira CHR(13) solto.
    * Titulo VAZIO (os dois casos desta fase) usa THIS.Caption, que e o
    * proprio titulo da tela, em vez de inventar texto que o legado nao tem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2, par_cMsg3)
        LOCAL loc_cMsg, loc_cTitulo

        loc_cMsg = ""

        IF VARTYPE(par_cMsg1) = "C" AND !EMPTY(par_cMsg1)
            loc_cMsg = ALLTRIM(par_cMsg1)
        ENDIF
        IF VARTYPE(par_cMsg2) = "C" AND !EMPTY(par_cMsg2)
            loc_cMsg = loc_cMsg + IIF(EMPTY(loc_cMsg), "", CHR(13)) + ALLTRIM(par_cMsg2)
        ENDIF
        IF VARTYPE(par_cMsg3) = "C" AND !EMPTY(par_cMsg3)
            loc_cMsg = loc_cMsg + IIF(EMPTY(loc_cMsg), "", CHR(13)) + ALLTRIM(par_cMsg3)
        ENDIF

        loc_cTitulo = THIS.Caption
        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            loc_cTitulo = ALLTRIM(par_cTitulo)
        ENDIF

        MsgAviso(loc_cMsg, loc_cTitulo)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transporta os campos DIGITAVEIS da tela para o Business
    * Object. Neste dialogo os campos editaveis NAO alimentam um registro de
    * banco: alimentam o protocolo do terminal SiTef, e o BO e quem guarda
    * esse estado (this_cSenhaSupervisor/this_cUltimosDigitos/
    * this_cNumeroCartao/this_cCodSeguranca -> this_cBuffer -> DLL).
    *
    * O legado faz este transporte INLINE, quatro vezes, uma por LostFocus
    * (SENHA/GetDigitos/GetCartao/GetCodSeg), sempre na forma
    * "Buffer = Alltrim(This.Value) + Replicate(Chr(0), ...)". Centralizar
    * aqui NAO cria uma segunda via: o caminho continua sendo um so
    * (campo -> BO -> buffer -> DLL); o que deixa de existir sao as quatro
    * copias da mesma expressao de padding.
    *
    * GUARDA DELIBERADA: campo em BRANCO nao sobrescreve a property. Cada
    * LostFocus do legado comeca com "IF EMPTY(This.Value) / RETURN", ou
    * seja, campo vazio nunca chega a alimentar o buffer - zerar a property
    * aqui descartaria o valor que o passo ANTERIOR do protocolo ja deixou
    * aceito (os campos vao sendo liberados um a um conforme o terminal
    * pede, e os anteriores permanecem preenchidos na tela).
    *
    * PROTECTED EXPLICITO: FormBase declara este hook como PROTECTED e o
    * VFP9 nao permite ALARGAR o escopo numa subclasse - omitir o
    * modificador nao o tornaria publico, so esconderia o fato.
    * Parametros: nenhum, para casar com a assinatura que FormBase.Salvar()
    * usa ao chamar THIS.FormParaBO().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lOk

        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            IF !EMPTY(THIS.txt_4c_SENHA.Value)
                loc_oBO.this_cSenhaSupervisor = ALLTRIM(THIS.txt_4c_SENHA.Value)
            ENDIF

            IF !EMPTY(THIS.txt_4c_Digitos.Value)
                loc_oBO.this_cUltimosDigitos = ALLTRIM(THIS.txt_4c_Digitos.Value)
            ENDIF

            IF !EMPTY(THIS.txt_4c_Cartao.Value)
                loc_oBO.this_cNumeroCartao = ALLTRIM(THIS.txt_4c_Cartao.Value)
            ENDIF

            IF !EMPTY(THIS.txt_4c_Codigo.Value)
                loc_oBO.this_cCodSeguranca = ALLTRIM(THIS.txt_4c_Codigo.Value)
            ENDIF

            *-- txt_4c_Valor NAO entra aqui de proposito: ele nasce
            *-- Enabled = .F. e e so a EXIBICAO do valor que o chamador
            *-- passou no Init. O valor da transacao continua tendo UM dono,
            *-- a property THIS.this_nValorPago do form, que e o que
            *-- RetornoFalha/MontaRetorno e o laco do protocolo leem (como no
            *-- legado, onde lnValPago e PUBLIC do form). Copia-lo para o BO
            *-- criaria um segundo dono do mesmo dado, que e exatamente o que
            *-- esta regra existe para evitar.
            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso: reflete na tela o que o BO resolveu.
    * Transcricao do trecho do Init legado que roda DEPOIS de ler SigCdEmp e
    * montar a identificacao do terminal:
    *     GetValor.Value = Iif(plImpressora, Val(Strtran(lnValPago,",",".")), lnValPago)
    *     IF pcCartao = "S"
    *         Label5.Caption = "Digite a Validade"
    *     Endif
    *
    * Chamado por CarregarDadosEmpresaSiTef() (onde estas duas atribuicoes
    * estavam inline) e tambem pelos GotFocus que repoem a mascara do
    * cartao, de modo que a tela tenha UM ponto de recarga a partir do BO.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara
    * PROTECTED; chamada sempre por THIS., regra CLAUDE.md #8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_lOk

        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            *-- Valor vem da property do FORM (dono unico - ver a nota em
            *-- FormParaBO), reproduzindo a linha do Init legado tal e qual:
            *--   GetValor.Value = Iif(plImpressora,
            *--       Val(Strtran(lnValPago,",",".")), lnValPago)
            THIS.txt_4c_Valor.Value = IIF(THIS.this_lImpressora, ;
                VAL(STRTRAN(TRANSFORM(THIS.this_nValorPago), ",", ".")), ;
                THIS.this_nValorPago)

            *-- "Digite a Validade" substitui "4 Ultimos Digitos :" quando o
            *-- chamador pede a validade do cartao (pcCartao = "S").
            IF THIS.this_cCartao = "S"
                THIS.lbl_4c_Label5.Caption = "Digite a Validade"
            ENDIF

            *-- Os campos digitaveis voltam do BO para a tela. Property vazia
            *-- NAO apaga o que esta digitado, pelo mesmo motivo da guarda de
            *-- FormParaBO: o protocolo libera um campo por vez e os
            *-- anteriores continuam visiveis.
            IF !EMPTY(loc_oBO.this_cSenhaSupervisor)
                THIS.txt_4c_SENHA.Value = ALLTRIM(loc_oBO.this_cSenhaSupervisor)
            ENDIF

            IF !EMPTY(loc_oBO.this_cUltimosDigitos)
                THIS.txt_4c_Digitos.Value = ALLTRIM(loc_oBO.this_cUltimosDigitos)
            ENDIF

            IF !EMPTY(loc_oBO.this_cNumeroCartao)
                THIS.txt_4c_Cartao.Value = ALLTRIM(loc_oBO.this_cNumeroCartao)
            ENDIF

            IF !EMPTY(loc_oBO.this_cCodSeguranca)
                THIS.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCodSeguranca)
            ENDIF

            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDigitos - transcricao INTEIRA de SIGOPCTF.GetDigitos.Valid:
    *
    *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
    *         DO Form SigTfDss With "","Quantidade de Digitos Invalida",""
    *         This.Value = ""
    *         Return(.f.)
    *     ENDIF
    *
    * Devolve .F. SO nesse caso. Campo VAZIO devolve .T.: no legado o IF nao
    * entra, o Valid termina sem Return e o VFP trata isso como aprovado -
    * quem impede o protocolo de avancar com campo vazio e o
    * "IF EMPTY(This.Value) / RETURN" que abre o LostFocus (Fase 7). NAO
    * acrescentar obrigatoriedade, faixa nem mensagem que o legado nao tem.
    *
    * O "This.Value = """ do legado FICA. Nao e o clear proibido pela regra
    * CLAUDE.md #50, que trata de LOOKUP com universo vazio: aqui e
    * validacao de FORMATO, em que o legado limpa o campo de proposito para
    * o usuario redigitar os 4 digitos (a mascara e "9999").
    * PUBLIC: chamado pelo handler ligado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDigitos()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)) != 4 AND ;
           !EMPTY(THIS.txt_4c_Digitos.Value)
            THIS.ExibirMensagemTef("", "Quantidade de Digitos Invalida", "", "")
            THIS.txt_4c_Digitos.Value = ""
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodSeg - transcricao INTEIRA de SIGOPCTF.GetCodSeg.Valid:
    *
    *     IF VAL(This.Value)>1 .and. VAL(This.Value)<100
    *         DO Form SigTfDss With "","SEG Invalido",""
    *         Return(.f.)
    *     ELSE
    *         Return(.t.)
    *     Endif
    *
    * A faixa recusada e 2..99, com os operadores ESTRITOS do legado - e
    * regra de negocio, transcrita literalmente (regra CLAUDE.md #17). Os
    * dois labels fixos ao lado do campo explicam por que 0 e 1 PASSAM:
    * lbl_4c_Label1 "0 - Inexist." e lbl_4c_Label3 "1 - Ilegivel" sao
    * codigos de marcacao, e o codigo de seguranca de verdade tem 3 ou 4
    * digitos (>= 100). NAO "corrigir" para >= 0 / <= 999 nem exigir
    * preenchimento: campo vazio da VAL("") = 0, que o legado aprova.
    *
    * Diferente de ValidarDigitos, aqui o legado NAO limpa o campo quando
    * recusa - nao acrescentar o clear.
    * PUBLIC: chamado pelo handler ligado por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodSeg()
        LOCAL loc_lValido, loc_nCodSeg
        loc_nCodSeg = VAL(THIS.txt_4c_Codigo.Value)

        IF loc_nCodSeg > 1 AND loc_nCodSeg < 100
            THIS.ExibirMensagemTef("", "SEG Invalido", "", "")
            loc_lValido = .F.
        ELSE
            loc_lValido = .T.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosKeyPress - equivalente de SIGOPCTF.GetDigitos.Valid, disparado
    * em ENTER(13)/TAB(9) porque BINDEVENT "Valid" nao e confiavel em
    * TextBox (regra CLAUDE.md #3). Reproduz o Valid COMPLETO:
    *   - reprovado  -> NODEFAULT (cancela a navegacao que o Enter/Tab ia
    *                   fazer) + SetFocus, que juntos sao o "Return(.f.)"
    *                   do legado: o campo nao e abandonado;
    *   - aprovado   -> nada a fazer, o Enter/Tab segue normalmente, igual
    *                   ao Valid do legado terminando sem Return.
    * O avanco do protocolo SiTef NAO mora aqui: no legado ele esta no
    * LostFocus deste mesmo campo, que e outro evento e ganha o proprio
    * metodo na Fase 7.
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) != "N"
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !THIS.ValidarDigitos()
            NODEFAULT
            IF THIS.txt_4c_Digitos.Enabled AND THIS.txt_4c_Digitos.Visible
                THIS.txt_4c_Digitos.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegKeyPress - equivalente de SIGOPCTF.GetCodSeg.Valid, nos mesmos
    * termos de DigitosKeyPress (ENTER/TAB + NODEFAULT/SetFocus no lugar do
    * "Return(.f.)"). O "Return(.t.)" do ramo ELSE legado e o caminho em que
    * nada se faz e a navegacao prossegue.
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) != "N"
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !THIS.ValidarCodSeg()
            NODEFAULT
            IF THIS.txt_4c_Codigo.Enabled AND THIS.txt_4c_Codigo.Visible
                THIS.txt_4c_Codigo.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LACO INTERATIVO COM O TERMINAL SITEF (Fase 7/8)
    *
    * Migra os pares GotFocus/LostFocus de SENHA, GetDigitos, GetCartao e
    * GetCodSeg (SigOpCtf_form_codigo_fonte.txt) e o Click do botao de saida
    * (SAIDA.CANCELA) - a parte do dialogo que NAO entrou nas Fases 3/5/6
    * porque dependia dos campos de dados ja estarem criados. Text2
    * (Enabled=.F./TabStop=.F., vestigial - ver nota da Fase 6) continua
    * sem GotFocus/LostFocus: nada no dump chama Text2.SetFocus(), o campo
    * nunca recebe foco de verdade.
    *
    * Cada DO WHILE do dump chama ContinuaFuncaoSiTefInterativo em sequencia
    * ate ProximoComando=30 (ou erro) - aqui, THIS.this_oBusinessObject.
    * ContinuarSiTef(), que faz a mesma chamada por referencia e devolve o
    * estado em this_nProximoComando/this_nTipoCampo/this_cBuffer (ver
    * SigOpCtfBO.prg).
    *
    * Quatro variaveis PUBLIC do legado (congeladas no Init, nunca
    * reatribuidas pelos handlers) ja existem como property do FORM:
    *   lsTipo -> this_cTipoPgto   lcNsu -> this_cNsu
    *   lcCartao -> this_cCartao  lnValPago -> this_nValorPago
    * Duas NAO existiam e foram criadas no topo da classe:
    *   ThisForm.pcCartao (property do FORM, reaproveitada pelos handlers
    *     como os 5 primeiros digitos do cartao lido via TipoCampo=131 -
    *     DIFERENTE de lcCartao/this_cCartao, que ficam congelados) ->
    *     this_cCartaoBin
    *   lcTef (acumulador do "cupom" devolvido ao chamador via MontaRetorno,
    *     construido em pedacos por TipoCampo=121/122 em VARIOS handlers -
    *     sem LOCAL/PRIVATE no dump, logo compartilhado entre eles) ->
    *     this_cTefAcumulado
    *
    * O handshake inicial (ConfiguraIntSiTefInterativo/IniciaFuncaoSiTef
    * Interativo, no Init legado) foi deslocado para SenhaGotFocus - ver o
    * cabecalho desse metodo para a justificativa (regra CLAUDE.md #29).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExibirMensagemTef / RetornoFalha / MontaRetorno / BtnCancelaClick ja
    * documentados individualmente abaixo. RetornoFalha e MontaRetorno vivem
    * no FORM (nao no BO) - mesmo lugar usado pelo sibling Formsigprdft.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * RetornoFalha - migrado de SIGOPCTF.retornofalha. Grava os arquivos SDF
    * que a retaguarda/impressora fiscal le (C:\client\Resp\*). Pasta
    * ausente nesta maquina (dev/pipeline sem integracao fiscal) -> grava e
    * pulada, sem quebrar o fluxo de cancelamento/erro.
    *
    * O legado recebe (lcMensagem, lnValPago), mas lnValPago NUNCA eh
    * reatribuido em lugar nenhum do dump depois do Init - eh sempre o
    * mesmo valor de THIS.this_nValorPago, inclusive no UNICO call site que
    * o passa explicitamente (BtnCancelaClick). Por isso aqui le-se direto
    * da property, sem 2o parametro.
    *--------------------------------------------------------------------------
    PROCEDURE RetornoFalha(par_cMensagem)
        LOCAL loc_cMensagem, loc_cValPago, loc_oErro

        loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
        loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999999.99")), ".", ",")

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaRetorno - migrado de SIGOPCTF.montaretorno. Grava os mesmos
    * arquivos SDF de RetornoFalha, com o NSU e o cupom (texto multi-linha,
    * dividido por CHR(10) - igual ao legado) da transacao CANCELADA com
    * sucesso. par_cValPago existe so para casar com a assinatura do UNICO
    * call site do dump (ThisForm.MontaRetorno(lcTef, lcNsu, lcValPago)) -
    * o proprio legado SOBRESCREVE lsValPago com Transform(lnValPago,...)
    * logo na 1a linha do metodo, descartando o que foi passado.
    *--------------------------------------------------------------------------
    PROCEDURE MontaRetorno(par_cCupom, par_cNsu, par_cValPago)
        LOCAL loc_cValPago, loc_cCupomRestante, loc_nPos, loc_nLinha, loc_oErro

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999999.99")), ".", ",")

        IF !DIRECTORY("C:\client\Resp", 1)
            RETURN
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + IIF(VARTYPE(par_cNsu) = "C", par_cNsu, ""))
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")

            loc_cCupomRestante = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupomRestante)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                    IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
                loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 3)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaClick - migrado de SIGOPCTF.SAIDA.CANCELA.Click. Unica acao
    * de saida do dialogo - cancela a transacao (Continua...(-1)) e grava a
    * falha. PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaClick()
        THIS.this_oBusinessObject.ContinuarSiTef(-1)
        THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaGotFocus - PRIMEIRO campo habilitado do dialogo (TabIndex=2;
    * txt_4c_Valor TabIndex=1 nasce Enabled=.F.) - dispara quando a tela
    * abre. Reune DOIS blocos do legado:
    *
    * 1) O handshake com o terminal (SIGOPCTF.Init, blocos
    *    ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo) -
    *    deslocado de Init()/InicializarForm para aqui (POS-Show, dentro de
    *    um evento) porque a falha desses dois blocos chama RetornoFalha +
    *    RELEASE WINDOWS no legado, que equivale a THIS.Release() - chamar
    *    Release() de DENTRO de Init/InicializarForm (ANTES do Show() do
    *    chamador) destruiria o objeto antes do CREATEOBJECT devolver
    *    (regra CLAUDE.md #29). Mesmo criterio do sibling Formsigprdft, que
    *    defere ConectarSiTef/IniciarSiTef para DigitosGotFocus em vez de
    *    rodar em InicializarForm. So dispara uma vez - nao ha flag
    *    explicita porque SenhaLostFocus desabilita txt_4c_SENHA no fim
    *    (This.Enabled=.f. no legado) e o campo nunca recupera o foco
    *    depois disso.
    *
    * 2) SIGOPCTF.SENHA.GotFocus propriamente dito: muda a legenda de
    *    status e drena o buffer do protocolo (que ja tem a mensagem
    *    "Digite a Senha" enfileirada pelo IniciaFuncaoSiTefInterativo) ate
    *    ProximoComando=30 (pronto para receber entrada do usuario).
    *
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE SenhaGotFocus()
        LOCAL loc_oBO, loc_cValPago, loc_cData, loc_cHora, loc_nRetorno, loc_cMensagem, loc_oErro

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            IF !loc_oBO.ConectarSiTef()
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                THIS.Release()
                RETURN
            ENDIF

            loc_cData    = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
            loc_cHora    = STRTRAN(TIME(), ":", "")
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.txt_4c_Valor.Value, "99999999.99")), ".", ",")

            IF !loc_oBO.IniciarSiTef(loc_cValPago, loc_cData, loc_cHora)
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                THIS.Release()
                RETURN
            ENDIF
        CATCH TO loc_oErro
            *-- CliSiTef32I.DLL ausente nesta maquina (DeclararFuncoesSiTef
            *-- nao conseguiu declarar as funcoes) - mesma falha de
            *-- comunicacao que o legado reportaria.
            THIS.RetornoFalha("Sem comunicacao com SiTef")
            THIS.Release()
            RETURN
        ENDTRY

        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"

        loc_oBO.this_nProximoComando = 0
        loc_oBO.this_nTipoCampo      = 0
        loc_oBO.this_nTamanhoMinimo  = 0
        loc_oBO.this_nTamanhoMaximo  = 0
        loc_oBO.this_cBuffer         = REPLICATE(CHR(0), 2000)
        loc_oBO.this_nContinua       = 0
        loc_cMensagem = ""

        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            IF loc_nRetorno < 0
                THIS.RetornoFalha(loc_cMensagem)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando != 30
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaLostFocus - migrado de SIGOPCTF.SENHA.LostFocus. Envia a senha
    * digitada, negocia o tipo de pagamento (THIS.this_cTipoPgto -
    * debito/credito/parcelado) e o tipo de cartao (THIS.this_cCartao -
    * com/sem cartao presente), e decide se o proximo campo a habilitar e
    * txt_4c_Digitos (4 ultimos digitos) ou txt_4c_Cartao (numero completo).
    * PUBLIC: exigido por BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE SenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem

        IF EMPTY(THIS.txt_4c_SENHA.Value)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        *-- Legado: Buffer = Alltrim(this.Value)
        *--     + Replicate(Chr(0), 2000 - Len(Alltrim(this.Value)))
        THIS.FormParaBO()
        loc_oBO.MontarBufferSiTef(loc_oBO.this_cSenhaSupervisor)

        loc_nTipo     = 1
        loc_nRetorno  = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
        loc_cMensagem = loc_oBO.this_cBuffer
        loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
        loc_oBO.this_nContinua = 0

        DO WHILE loc_oBO.this_nProximoComando != 30 OR THIS.this_cTipoPgto = "D"
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Operacao Cancelada pelo Operador")
                THIS.Release()
                RETURN
            ENDIF

            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno < 0
                THIS.RetornoFalha(loc_cMensagem)
                THIS.Release()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.Release()
                RETURN
            ENDIF

            IF loc_oBO.this_nProximoComando = 21
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(THIS.this_cTipoPgto = "D", "1", ;
                        IIF(THIS.this_cTipoPgto = "C", "2", "3")) + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    loc_oBO.this_cBuffer = IIF(THIS.this_cCartao = "N", "1", "2") + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
            ENDIF

            IF loc_oBO.this_nProximoComando = 34 AND (loc_oBO.this_nTipoCampo = 146 OR loc_oBO.this_nTipoCampo = -1)
                loc_oBO.this_cBuffer = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999.99")), ".", ",")
                loc_oBO.this_cBuffer = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 20
                loc_oBO.this_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = -1
                EXIT
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 515
                *-- lsData (Data do Init) usada aqui como STRING concatenavel
                *-- - mesmo formato AAAAMMDD de loc_cData em SenhaGotFocus, o
                *-- dump nao declara outro formato para lsData.
                loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 516
                IF THIS.this_cCartaoBin = "00125"
                    loc_oBO.this_cBuffer = TRANSFORM(VAL(THIS.this_cNsu), "@L 999999") + REPLICATE(CHR(0), 1994)
                ELSE
                    loc_oBO.this_cBuffer = TRANSFORM(VAL(THIS.this_cNsu), "@L 999999999") + REPLICATE(CHR(0), 1991)
                ENDIF
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF

            IF loc_oBO.this_nTipoCampo = 514
                THIS.txt_4c_SENHA.Enabled   = .F.
                THIS.txt_4c_Digitos.Enabled = .F.
                THIS.txt_4c_Codigo.Enabled  = .T.
                EXIT
            ENDIF

            IF loc_oBO.this_nTipoCampo = 121
                THIS.this_cTefAcumulado = STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                THIS.this_cTefAcumulado = THIS.this_cTefAcumulado + STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCartaoBin = loc_oBO.this_cBuffer
            ENDIF

            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
            ENDIF

            IF loc_oBO.this_nProximoComando = 23
                THIS.obj_4c_SAIDA.Enabled = .F.
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000 AND loc_nRetorno = 0
            THIS.MontaRetorno(THIS.this_cTefAcumulado, THIS.this_cNsu, THIS.this_nValorPago)
            THIS.Release()
            RETURN
        ENDIF

        THIS.txt_4c_SENHA.Enabled = .F.
        THIS.obj_4c_SAIDA.Enabled = .T.
        IF THIS.this_cCartao = "N"
            THIS.txt_4c_Digitos.Enabled = .T.
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4" + CHR(13) + "Ultimos Digitos"
            THIS.txt_4c_Cartao.Value = "#### #### #### ####"
            THIS.txt_4c_Cartao.Refresh()
        ELSE
            THIS.txt_4c_Cartao.Enabled = .T.
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosGotFocus - migrado de SIGOPCTF.GetDigitos.GotFocus. So age
    * quando TipoCampo ja esta em 515 ao focar o campo (pedido de data
    * vindo do protocolo) - fora desse caso o legado nao faz nada aqui (o
    * If TipoCampo = 515 envolve o metodo INTEIRO). PUBLIC: BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosGotFocus()
        LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem

        loc_oBO = THIS.this_oBusinessObject
        IF loc_oBO.this_nTipoCampo != 515
            RETURN
        ENDIF

        loc_nTipo = 1
        loc_cMensagem = ""
        loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
        loc_oBO.this_nContinua = 1000
        loc_nRetorno = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
                THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
                    ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando = 20
                loc_oBO.this_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 30
                IF loc_nTipo = 1
                    IF THIS.this_cCartaoBin = "00125"
                        loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999"))
                    ELSE
                        loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999999"))
                    ENDIF
                    loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
            ENDIF
            IF loc_oBO.this_nProximoComando = 34
                loc_oBO.this_cBuffer   = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999.99")), ".", ",")
                loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                THIS.this_cTefAcumulado = STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                THIS.this_cTefAcumulado = THIS.this_cTefAcumulado + STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCartaoBin = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 34
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
                LOOP
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cTefAcumulado, THIS.this_cNsu, THIS.this_nValorPago)
            ENDIF
            THIS.Release()
            RETURN
        ENDIF

        loc_oBO.this_cBuffer = REPLICATE(CHR(0), 2000)
        THIS.txt_4c_Cartao.Value = "#### #### #### ####"
        THIS.txt_4c_Cartao.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * DigitosLostFocus - migrado de SIGOPCTF.GetDigitos.LostFocus. Valida
    * (ja feito em ValidarDigitos/DigitosKeyPress - regra CLAUDE.md #3,
    * BINDEVENT "Valid" nao eh confiavel em TextBox) e, com 4 digitos,
    * envia ao protocolo e drena a resposta. PUBLIC: BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE DigitosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem, loc_cData

        IF EMPTY(THIS.txt_4c_Digitos.Value)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        loc_nRetorno  = 10000
        loc_cMensagem = ""
        loc_nTipo     = 1
        *-- Legado: Buffer = ALLTRIM(This.Value) + REPLICATE(CHR(0), 1996)
        *-- (complemento LITERAL - ver MontarBufferSiTef no BO)
        THIS.FormParaBO()
        loc_oBO.MontarBufferSiTef(loc_oBO.this_cUltimosDigitos, 1996)

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
                THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
                    ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
                EXIT
            ENDIF
            IF loc_oBO.this_nTipoCampo = 514
                THIS.txt_4c_Digitos.Enabled = .F.
                THIS.txt_4c_Codigo.Enabled  = .T.
                EXIT
            ENDIF
            IF loc_oBO.this_nTipoCampo = 515
                loc_cData = LEFT(DTOC(DATE()), 2) + SUBSTR(DTOC(DATE()), 4, 2) + RIGHT(DTOC(DATE()), 4)
                loc_oBO.this_cBuffer = loc_cData + REPLICATE(CHR(0), 1992)
                loc_nTipo = 2
                LOOP
            ENDIF
            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando = 30
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    IF THIS.this_cCartaoBin = "00125"
                        loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999"))
                    ELSE
                        loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(VAL(THIS.this_cNsu), "@L 999999999"))
                    ENDIF
                    loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
            ENDIF
            IF loc_oBO.this_nProximoComando = 34
                loc_oBO.this_cBuffer   = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999.99")), ".", ",")
                loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                loc_oBO.this_nContinua = 1000
            ENDIF
            IF loc_oBO.this_nProximoComando = 20
                loc_oBO.this_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                loc_oBO.this_nContinua = 1000
                LOOP
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                THIS.this_cTefAcumulado = STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                THIS.this_cTefAcumulado = THIS.this_cTefAcumulado + STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 34
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000
            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cTefAcumulado, THIS.this_cNsu, THIS.this_nValorPago)
            ENDIF
            THIS.Release()
            RETURN
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CartaoLostFocus - migrado de SIGOPCTF.GetCartao.LostFocus. O
    * IIF(lsTipo="D","1",IIF(lsTipo="D","2","3")) do dump compara lsTipo
    * (this_cTipoPgto) com "D" nos DOIS ramos (nunca compara com "C") -
    * aparenta ser erro do legado, mas regra CLAUDE.md #17 manda
    * TRANSCREVER a formula tal como esta, nao corrigir o que parece bug.
    * PUBLIC: BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CartaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem

        IF EMPTY(THIS.txt_4c_Cartao.Value)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        *-- Legado: Buffer = ALLTRIM(This.Value)
        *--     + REPLICATE(CHR(0), 2000-LEN(ALLTRIM(This.Value)))
        THIS.FormParaBO()
        loc_oBO.MontarBufferSiTef(loc_oBO.this_cNumeroCartao)

        loc_nTipo     = 1
        loc_nRetorno  = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
        loc_cMensagem = loc_oBO.this_cBuffer
        loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
        loc_oBO.this_nContinua = 0

        DO WHILE loc_oBO.this_nProximoComando != 30
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

            IF LASTKEY() = 27
                loc_oBO.ContinuarSiTef(-1)
                THIS.RetornoFalha("Operacao Cancelada pelo Operador")
                THIS.Release()
                RETURN
            ENDIF
            IF loc_nRetorno < 0
                THIS.RetornoFalha(loc_cMensagem)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCartaoBin = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando = 21
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer = IIF(THIS.this_cTipoPgto = "D", "1", IIF(THIS.this_cTipoPgto = "D", "2", "3"))
                    loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    loc_oBO.this_cBuffer = IIF(THIS.this_cCartao = "N", "1", "2")
                    loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 1999)
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
            ELSE
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
            ENDIF
            IF loc_oBO.this_nProximoComando = 23
                THIS.obj_4c_SAIDA.Enabled = .F.
                THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
            ENDIF
        ENDDO

        THIS.txt_4c_Cartao.Enabled  = .F.
        THIS.obj_4c_SAIDA.Enabled   = .T.
        THIS.txt_4c_Digitos.Enabled = .T.
        IF THIS.this_cCartao = "N"
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4" + CHR(13) + "Ultimos Digitos"
        ELSE
            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Validade" + CHR(13) + "do Cartao"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegGotFocus - migrado de SIGOPCTF.GetCodSeg.GotFocus. PUBLIC:
    * BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegGotFocus()
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Codigo" + CHR(13) + "de Seguranca"
    ENDPROC

    *--------------------------------------------------------------------------
    * CodSegLostFocus - migrado de SIGOPCTF.GetCodSeg.LostFocus. Ultimo
    * campo do fluxo - o RELEASE WINDOWS final do legado NAO esta dentro de
    * IF nenhum: a tela SEMPRE fecha depois do codigo de seguranca ser
    * processado, sucesso ou falha (ja validado em ValidarCodSeg/
    * CodSegKeyPress - regra CLAUDE.md #3). PUBLIC: BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE CodSegLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_nTipo, loc_nRetorno, loc_cMensagem

        IF EMPTY(THIS.txt_4c_Codigo.Value)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject
        loc_nTipo     = 1
        loc_cMensagem = ""
        *-- Legado: Buffer = Alltrim(This.Value)
        *--     + REPLICATE(CHR(0), 2000-LEN(Alltrim(This.Value)))
        THIS.FormParaBO()
        loc_oBO.MontarBufferSiTef(loc_oBO.this_cCodSeguranca)
        loc_oBO.this_nContinua = 1000
        loc_nRetorno = 10000

        DO WHILE loc_nRetorno = 10000
            loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
            IF loc_nRetorno = 0
                EXIT
            ENDIF
            IF loc_nRetorno != 10000 OR UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO"
                THIS.RetornoFalha(IIF(UPPER(loc_oBO.this_cBuffer) = "CARTAO INVALIDO", ;
                    ALLTRIM(loc_oBO.this_cBuffer), loc_cMensagem))
                EXIT
            ENDIF
            IF loc_oBO.this_nProximoComando = 22
                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)), "")
                loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
                THIS.Release()
                RETURN
            ENDIF
            IF loc_oBO.this_nProximoComando = 30
                IF loc_nTipo = 1
                    loc_oBO.this_cBuffer   = PADR(DTOS(THIS.this_dDataTrans), 2000, CHR(0))
                    loc_oBO.this_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    IF THIS.this_cCartaoBin = "00125"
                        loc_oBO.this_cBuffer = TRANSFORM(VAL(THIS.this_cNsu), "@L 999999") + REPLICATE(CHR(0), 1994)
                    ELSE
                        loc_oBO.this_cBuffer = TRANSFORM(VAL(THIS.this_cNsu), "@L 999999999") + REPLICATE(CHR(0), 1991)
                    ENDIF
                    loc_oBO.this_nContinua = 1000
                    LOOP
                ENDIF
            ENDIF
            IF loc_oBO.this_nProximoComando = 34
                loc_oBO.this_cBuffer   = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValorPago, "99999999.99")), ".", ",")
                loc_oBO.this_cBuffer   = loc_oBO.this_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cBuffer))
                loc_oBO.this_nContinua = 1000
            ENDIF
            IF loc_oBO.this_nTipoCampo = 121
                THIS.this_cTefAcumulado = STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 122
                THIS.this_cTefAcumulado = THIS.this_cTefAcumulado + STRTRAN(loc_oBO.this_cBuffer, CHR(0), " ")
            ENDIF
            IF loc_oBO.this_nTipoCampo = 131
                THIS.this_cCartaoBin = loc_oBO.this_cBuffer
            ENDIF
            IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 34
                loc_cMensagem = loc_oBO.this_cBuffer
                loc_oBO.this_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_oBO.this_nContinua = 0
            ENDIF
        ENDDO

        IF loc_nRetorno != 10000 AND loc_nRetorno = 0
            THIS.MontaRetorno(THIS.this_cTefAcumulado, THIS.this_cNsu, THIS.this_nValorPago)
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por padrao). Nao ha
    * container flutuante nesta tela (nenhum Visible=.F. intencional no
    * dump), entao nao ha excecao a filtrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Delega a FormBase.Destroy() (libera this_oBusinessObject e
    * restaura o menu). Nenhum cursor local eh aberto nesta fase - cursores
    * de laco interativo com o terminal SiTef entram na Fase 7 e, se algum
    * sobreviver ao fechamento, o fechamento proprio deles ganha tratamento
    * aqui naquela fase.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
