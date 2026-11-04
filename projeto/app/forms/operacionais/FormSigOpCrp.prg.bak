*==============================================================================
* FormSigOpCrp.prg
*
* Dialogo de Procura de Lancamento - Extrato de Conta Corrente Individual
* Legado: SigOpCrp.SCX (task714)
*
* FASE 4/8 - Campos de pesquisa (txt_4c_Lancamento/Valor/Historico + labels) e
* obj_4c_Commandgroup1 (Procurar/Encerrar), com os eventos GotFocus/LostFocus/
* Click que fecham o ciclo de BuscarRegistro() do SigOpCrpBO.
*
* FASE 5/8 - Sem campo NOVO: o legado tem 3 campos e os 3 ja entregues na
* Fase 4 (este dialogo nao tem Page2 - a superficie de campos e' unica).
* O trabalho da fase foi reconciliar os 3 campos com os defaults da CLASSE do
* framework (fweditdata/fwget) que o SCX nao sobrescreve e o migrador havia
* descartado: Format "K", Themes = .F., FontName/FontSize e o Height de
* txt_4c_Lancamento. Detalhamento e' evidencia no cabecalho de
* ConfigurarControlesPesquisa().
*
* FASE 6/8 - "Campos restantes e lookups". Os dois itens do titulo da fase
* ficam resolvidos POR AUSENCIA neste form; o terceiro e' o que ela entrega:
*
*   1) Campos restantes: NAO HA. O legado tem exatamente 3 campos
*      (getLancamento / getValor / getHistorico) e os 3 ja estao criados desde
*      a Fase 4 - este dialogo nao tem Page2, a superficie de campos e' unica.
*      Acrescentar um 4o campo seria inventar UI que o legado nao tem.
*
*   2) Lookups: NAO HA NENHUM NO LEGADO - e por isso nenhum foi criado.
*      Medido no dump (tasks\task714\SigOpCrp_form_codigo_fonte.txt): zero
*      ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt, de mAddColuna, de
*      sigacess( e das funcoes Acesso*( ; e zero PROCEDURE KeyPress, zero
*      F4/F5. Os tres Valid do legado NAO sao lookup: nenhum deles consulta
*      tabela - cada um so zera os OUTROS dois criterios de pesquisa (e o
*      Continuar), que e' validacao de exclusao mutua. Inventar
*      FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra explicita "NUNCA
*      inventar tabelas de lookup que nao existem no original"; e metodo
*      AbrirLookup* vazio e' proibido pela regra de completude.
*
*   3) O que a fase DE FATO entrega: o Valid dos 3 campos digitaveis, agora
*      com o nome canonico Validar<Campo> (antes Txt<Campo>LostFocus, que e'
*      a assinatura de defeito da regra #47) - ver o cabecalho do bloco
*      ValidarLancamento / ValidarValor / ValidarHistorico.
*
*   Tambem NAO ha container cnt_4c_BotoesAcao (Salvar/Cancelar): isto nao e'
*   um CRUD. O legado tem UM CommandGroup de 2 botoes - Procurar e Encerrar -
*   ja entregue na Fase 4, e nao grava nada (so faz LOCATE/CONTINUE no cursor
*   do form pai).
*
* FASE 7/8 - "Eventos principais dos botoes" (BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick). O template generico pressupoe a barra
* CRUD do frmcadastro (Incluir/Alterar/Visualizar/Excluir/Buscar), que este
* dialogo NAO TEM - medido no dump (SigOpCrp_form_codigo_fonte.txt): o UNICO
* agrupador de botoes e' Commandgroup1, ButtonCount=2, com os metodos
* btnOK.Click (buscar/continuar no cursor do pai) e btnSair.Click
* (ThisForm.Release); zero ocorrencia de Incluir/Alterar/Visualizar/Excluir em
* qualquer metodo deste dump. Criar os 4 handlers do template seria inventar
* funcionalidade que o legado nunca teve - exatamente a violacao que a regra
* "NUNCA inventar" e o PILAR 1 proibem (mesma familia de falso-positivo do
* precedente task699/SIGOPCHP: dialogo filho, OPERACIONAL, sem barra CRUD).
*
* Os "eventos principais dos botoes" DESTE form sao BtnProcurarClick e
* BtnEncerrarClick - a totalidade dos Click do Commandgroup1 legado - e os
* dois ja estao implementados abaixo desde a Fase 4 (criacao do
* CommandGroup, BINDEVENT e corpo completo). Nao ha codigo novo para esta
* fase.
*
* NOTA SOBRE O TEMPLATE GENERICO DE FASE 4 ("Grid + 6 botoes CRUD em Page1"):
* NAO SE APLICA a este form. O dump (SigOpCrp_form_codigo_fonte.txt) e o
* layout.json/analise.json de task714 confirmam: BorderStyle=2/TitleBar=0/
* WindowType=1 (dialogo modal), SEM PageFrame (nenhuma Page1/Page2), SEM Grid,
* SEM AddCursor/pColuna - "temGrid": false em analise.json. O legado tem
* exatamente 3 campos de pesquisa e 1 CommandGroup de 2 botoes (Procurar /
* Encerrar), todos direto no Form. Inventar Grid+6 botoes CRUD violaria o
* PILAR 1 (UI que o legado nao tem) e a regra "NUNCA inventar" - mesma familia
* de falso-positivo documentada para forms DESPACHANTE/CAPTURA sem superficie
* de lista (precedente: task699/SIGOPCHP, perfil CAPTURA). Como os campos e os
* botoes sao a UNICA superficie real deste dialogo (nao ha Page separada para
* "grid" versus "campos"), a Fase 4 entrega aqui o conteudo completo: campos +
* botoes + eventos - nao apenas os botoes isolados.
*
*------------------------------------------------------------------------------
* NAO E UM CRUD - e um dialogo FILHO, modal, sem barra de titulo, aberto pelo
* extrato de Conta Corrente Individual (Formsigopind) no clique do botao
* "Procura":
*
*     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
*
* Por isso este form:
*   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 520x200, igual
*     ao SCX legado);
*   - recebe DOIS parametros no Init - o DataSessionId do form pai (legado:
*     "Arquivos") e o OBJETO do form pai (legado: "pFormPai") - guardados em
*     this_nDataSessionPai/this_oFormPai porque o BO usa o primeiro para
*     SET DATASESSION TO antes de tocar no cursor CrSigMvCcr do pai (ver
*     SigOpCrpBO.prg), e o Form usa o segundo so para se posicionar do lado
*     do pai (legado: ThisForm.Top/Left a partir de ThisForm.FormPai).
*
* O cabecalho (cntSombra/lblSombra/lblTitulo do legado) e o MESMO componente
* visual usado nos cadastros CRUD (framework.vcx), so que aqui aparece direto
* no Form (sem Page), porque este dialogo nao tem PageFrame. Nomes dos objetos
* fixados em tasks\task714\mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
* lbl_4c_LblTitulo.
*
*==============================================================================
* FASE 8/8 - CONSOLIDACAO FINAL
*==============================================================================
* A fase entrega os TRES hooks canonicos que esta tela de fato tem, extraindo
* para metodo proprio o codigo que ja existia ESPALHADO nos handlers - isto eh
* PILAR 3 (fonte unica), nao UI nova:
*
*   FormParaBO()   - os 3 campos -> as 3 properties de criterio do BO. O corpo
*                    estava inline no BtnProcurarClick; agora o Click chama o
*                    hook, que eh o UNICO lugar que le os TextBox de criterio.
*   BOParaForm()   - as 3 properties de criterio do BO -> os 3 campos. O corpo
*                    estava TRIPLICADO (uma copia em cada Validar<Campo>, cada
*                    uma espelhando so os DOIS campos irmaos); agora as tres
*                    chamam o mesmo hook, que espelha os tres. Espelhar o
*                    proprio campo de volta eh inocuo e necessario: o
*                    ValidarCriterio* do BO nunca altera o criterio que ACABOU
*                    de mudar, so zera os outros dois.
*   LimparCampos() - os defaults do Init legado (Ctod('  /  /  ') / 0.00 / '')
*                    num funil unico: zera as properties do BO e refaz a tela
*                    pelo BOParaForm. O Init legado faz exatamente isso, campo
*                    a campo; aqui o estado tem UMA fonte (o BO).
*
* Com os hooks no lugar, os valores iniciais que os WITH de AddObject atribuem
* deixam de ser a fonte do estado e passam a ter uma funcao so: FIXAR O TIPO de
* .Value (Date / Numeric / Character) no instante da criacao - TextBox assume o
* tipo do que lhe for atribuido primeiro, e sem isso o {} / 0.00 / "" do
* BOParaForm seria a primeira atribuicao e o tipo passaria a depender da ordem
* de chamada. Por isso eles FICAM.
*
*------------------------------------------------------------------------------
* O QUE O TEMPLATE DA FASE PEDE E NAO TEM REFERENTE NESTE LEGADO
*------------------------------------------------------------------------------
* O template generico da Fase 8 lista metodos do form CRUD (frmcadastro). Os
* que faltam aqui faltam porque a SUPERFICIE deles nao existe no SCX - criar
* qualquer um seria inventar UI (viola o PILAR 1 e a regra "NUNCA inventar") ou
* escrever metodo vazio, que a regra de completude proibe:
*
*   BtnBuscarClick     -> o botao de busca DESTA tela se chama "Procurar" no
*                         SCX (Commandgroup1.btnOK), e o handler dele eh o
*                         BtnProcurarClick ja entregue. Um segundo handler com
*                         o nome canonico seria o MESMO botao duas vezes.
*   BtnSalvarClick     -> nao existe botao de gravar: medido no dump, os UNICOS
*                         Click sao btnOK.Click (Locate/Continue no cursor do
*                         PAI) e btnSair.Click ("Thisform.Release"). A tela nao
*                         escreve em tabela nenhuma.
*   BtnCancelarClick   -> "Cancelar" eh o botao que ABANDONA uma edicao na
*                         Page2 de Dados. Nao ha PageFrame, nem Page2, nem modo
*                         de edicao, nem registro em edicao. O 2o botao do SCX
*                         eh "Encerrar" (Cancel = .T., Click = Release) e o
*                         migrado o entrega com o nome do legado
*                         (BtnEncerrarClick). Renomea-lo para Cancelar faria o
*                         nome MENTIR sobre o que o metodo faz.
*   CarregarLista      -> nao ha grade NEM cursor de listagem neste form. A
*                         grade eh do form PAI (Formsigopind:
*                         pgf_4c_1.Page2.grd_4c_Lancamento) e quem a popula eh
*                         o pai; este dialogo so MOVE o ponteiro do cursor
*                         CrSigMvCcr do pai (Locate/Continue) e manda o pai
*                         repintar - exatamente o que o btnOK.Click legado faz.
*   HabilitarCampos    -> a tela nunca desabilita campo: zero Enabled = .F. e
*                         zero ReadOnly no SCX inteiro. Os 3 campos sao sempre
*                         digitaveis.
*   AjustarBotoesPorModo -> nao ha MODO. O SCX nao tem pcEscolha nem
*                         INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR; os 2 botoes estao
*                         sempre habilitados.
*
* O gate da Fase 8 reconhece esta forma de tela pelo ramo NAVEGADOR-DO-PAI
* (automation\OrquestradorMigracao.ps1, Test-LegadoNavegadorDoCursorDoPai), que
* dispensa BtnCancelarClick/CarregarLista exigindo em troca exatamente o que
* esta entregue acima: o handler do botao de acao do legado MAIS os dois hooks
* FormParaBO/BOParaForm.
*==============================================================================

DEFINE CLASS FormSigOpCrp AS FormBase

    *--------------------------------------------------------------------------
    * Layout (pixel-perfect do legado - SIGOPCRP.SCX)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 520
    Height       = 200
    AutoCenter   = .F.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    WindowState  = 0
    AlwaysOnTop  = .T.
    ShowWindow   = 1
    Caption      = "Procura"

    *--------------------------------------------------------------------------
    * Propriedades customizadas
    *
    * this_oFormPai        - legado: ThisForm.FormPai. Objeto do extrato de
    *                        Conta Corrente (Formsigopind) que abriu este
    *                        dialogo. Usado so para posicionamento (Top/Left)
    *                        nesta fase; nas fases de evento (7/8) tambem
    *                        recebe o Refresh/SetFocus da grade do pai.
    *
    * this_nDataSessionPai - legado: parametro "Arquivos" do Init, o mesmo
    *                        DataSessionId repassado ao BO (SigOpCrpBO usa
    *                        para SET DATASESSION TO antes de ler CrSigMvCcr).
    *--------------------------------------------------------------------------
    this_oFormPai         = .NULL.
    this_nDataSessionPai  = 0

    *==========================================================================
    * Init - recebe os dois parametros do "DO FORM SigOpCrp WITH ..." legado
    *
    * Guardar os dois ANTES de DODEFAULT(): FormBase.Init() chama
    * ja preenchidos (um para instanciar o BO, outro para posicionar o form).
    *==========================================================================
    PROCEDURE Init(par_nDataSessionPai, par_oFormPai)
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            THIS.this_nDataSessionPai = par_nDataSessionPai
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase.Init(). Cria o BO, posiciona o
    * dialogo ao lado do form pai e monta o cabecalho.
    *
    * O BO (SigOpCrpBO) nao faz nenhum acesso a servidor no proprio Init (ver
    * nota de arquitetura no cabecalho de SigOpCrpBO.prg) - por isso a
    * instanciacao roda sempre, inclusive em gb_4c_ValidandoUI, sem o guard
    * que outros forms usam para pular CarregarLista().
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrpBO", THIS.this_nDataSessionPai)
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpCrpBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- FASE 8: o resto so corre com o BO VIVO. Antes, a falha do
            *-- CREATEOBJECT apenas marcava o flag e a execucao seguia; agora
            *-- LimparCampos/BOParaForm tocam o BO, e sem este IF o usuario
            *-- levaria DOIS dialogos de erro - o real e um "Property is not
            *-- found" derivado dele, que esconde a causa.
            IF loc_lSucesso
                THIS.PosicionarJuntoAoFormPai()

                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

                THIS.ConfigurarCabecalho()

                THIS.ConfigurarControlesPesquisa()

                *-- Os defaults do Init legado (Ctod('  /  /  ') / 0.00 / '')
                *-- passam pelo funil unico, para tela e BO nascerem com o
                *-- MESMO estado. Os valores dos WITH de AddObject ficam porque
                *-- sao o que FIXA o TIPO de cada .Value (ver cabecalho).
                THIS.LimparCampos()

                THIS.TornarControlesVisiveis(THIS)
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarJuntoAoFormPai - Transcricao do bloco de posicionamento do
    * Init legado:
    *
    *     ThisForm.Top  = ThisForm.FormPai.Top
    *     ThisForm.Left = (ThisForm.FormPai.Left + ThisForm.FormPai.Width) - ThisForm.Width
    *
    * isto eh, o dialogo nasce encostado na borda DIREITA do form pai, na
    * mesma altura do topo dele. Sem this_oFormPai (form aberto fora do fluxo
    * do extrato, ex.: teste isolado), AutoCenter continua .F. e o form fica
    * na posicao default do VFP9 - nao ha pai para copiar Top/Left.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.Top  = THIS.this_oFormPai.Top
            THIS.Left = (THIS.this_oFormPai.Left + THIS.this_oFormPai.Width) - THIS.Width
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
    *
    * Mesmo componente visual do cabecalho canonico dos cadastros CRUD
    * (framework.vcx: cntSombra/lblSombra/lblTitulo), so que direto no Form -
    * este dialogo nao tem PageFrame/Page para hospeda-lo. Nomes fixados em
    * tasks\task714\mapeamento.json (cnt_4c_Sombra, nao cnt_4c_Cabecalho).
    *
    * Width da faixa e dos dois labels usa THIS.Width (520) em vez do 800/769
    * literal do dump: aqueles numeros sao o default da CLASSE do framework
    * (dimensionada para o form 800px dos cadastros) e nunca foram
    * sobrescritos neste SCX de 520px - copiar ao pe da letra faria a faixa
    * estourar a borda do dialogo. Top/Left/Height/FontName/FontSize/
    * ForeColor sao TODOS transcritos do dump (regra #23: nada inventado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top          = 18
            .Left         = 10
            .Width        = THIS.Width - 31
            .Height       = 40
            .FontName     = "Tahoma"
            .FontSize     = 18
            .FontBold     = .T.
            .FontUnderline = .F.
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(0, 0, 0)
            .Caption      = THIS.Caption
            .Visible      = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 31
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControlesPesquisa - os 3 campos de pesquisa (+ labels) e o
    * CommandGroup Procurar/Encerrar. Transcricao pixel-perfect do dump
    * (SigOpCrp_form_codigo_fonte.txt, SECAO 2) - nomes conforme
    * tasks\task714\mapeamento.json.
    *
    * Os 3 TextBox nascem com o mesmo default do Init legado (Ctod('  /  /  '),
    * 0.00, '') - aqui replicado via {} / 0.00 / "", pois este metodo roda
    * ANTES de qualquer busca.
    *
    * ForeColor nao declarado nos 3 Say = RGB(90,90,90), o canonico de label
    * de dados fora do cabecalho (regra #12) - o Form.Picture (textura clara)
    * tornaria um ForeColor branco invisivel.
    *
    *--------------------------------------------------------------------------
    * FASE 5/8 - A BASE DE UM CAMPO SAO DUAS FONTES: O DUMP *E* A CLASSE
    *--------------------------------------------------------------------------
    * Esta fase pede "metade dos campos da Page2". Este dialogo nao tem Page2
    * (nem PageFrame) e tem EXATAMENTE 3 campos, todos entregues na Fase 4 -
    * nao ha campo NOVO a acrescentar, e inventar um quarto violaria o PILAR 1
    * e a regra "NUNCA inventar". O trabalho desta fase foi, portanto,
    * RECONCILIAR esses 3 campos com a sua base real.
    *
    * O que se achou: o migrador transcreveu so os OVERRIDES do SCX e
    * descartou os defaults da CLASSE do framework que o SCX nao sobrescreve.
    * Medido em Framework\framework.vcx (docs\FRAMEWORK_class_codigo_fonte.txt,
    * blocos "PROPRIEDADES DE: fweditdata" e "PROPRIEDADES DE: fwget"):
    *
    *   fweditdata (getLancamento) : FontName "Tahoma" / FontSize 8 /
    *                                Alignment 3 / Height 23 / Width 80 /
    *                                Themes .F.          -- SEM Format
    *   fwget (getValor/Historico) : FontName "Tahoma" / FontSize 8 /
    *                                Format "K" / Height 23 / Width 100 /
    *                                Themes .F.
    *
    * Dai as 4 correcoes aplicadas abaixo (nenhuma eh invencao - todas tem
    * referente no dump ou na classe):
    *
    *  1) Format = "K" em txt_4c_Valor e txt_4c_Historico. O dump nao declara
    *     Format nesses dois, mas a classe fwget declara - e override vazio
    *     nao existe aqui (regra #49 proibe transcrever Format = "", nao
    *     proibe transcrever o default da classe). "K" sozinho seleciona o
    *     conteudo ao entrar no campo (severidade BAIXA/UX da regra #49);
    *     sem ele o usuario tem de apagar o valor anterior a mao.
    *     txt_4c_Lancamento NAO leva Format: fweditdata nao tem.
    *
    *  2) Themes = .F. nos 3. Sem isso as DUAS propriedades que o migrador
    *     corretamente transcreveu do dump - SpecialEffect = 1 e
    *     BorderColor = RGB(100,100,100) - ficam inertes, porque com Themes
    *     no default (.T.) a borda do TextBox e' desenhada pelo tema do
    *     Windows. A classe do framework pina Themes = .F. exatamente para
    *     que elas valham. Mesma familia do
    *     [[feedback_standalone_commandbutton_themes]].
    *
    *  3) FontName "Tahoma" / FontSize 8 nos 3. A classe pina os dois; o
    *     TextBox criado por AddObject nao herda a fonte do Form. Sem isso os
    *     campos saem numa fonte diferente das labels irmas, que JA estao em
    *     Tahoma 8. Pratica canonica: FormCor.txt_4c_Codigo.
    *
    *  4) txt_4c_Lancamento.Height: 23, nao 21. O dump de getLancamento NAO
    *     declara Height (declara so Left/Top/SpecialEffect/TabIndex/
    *     ForeColor/BorderColor), logo vale o 23 da classe fweditdata - o
    *     mesmo dos outros dois campos da linha. O 21 anterior nao tinha
    *     referente nem no dump nem na classe.
    *
    * Alignment: a classe fweditdata declara 3, que e' tambem o default REAL
    * do TextBox criado por AddObject (medido - ver
    * [[feedback_textbox_alignment_default_e_3_nao_0]]); fica EXPLICITO para o
    * ValidarUIFidelity comparar sem depender do default.
    *
    * O que deliberadamente NAO entrou, para nao inventar:
    *   - InputMask: nem o dump nem fweditdata/fwget declaram (regra #49);
    *   - MaxLength: idem. Hists e' C(60), mas estes campos sao CRITERIO DE
    *     BUSCA (nada aqui e' gravado), entao a regra #19 nao se aplica -
    *     limitar a digitacao seria restricao que o legado nao tem;
    *   - DisabledBackColor/DisabledForeColor da fwget: inalcancaveis, este
    *     dialogo nunca desabilita campo (nao ha Enabled = .F. em lugar
    *     nenhum do SCX nem do migrado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesPesquisa()
        *----------------------------------------------------------------------
        * lbl_4c_Label1 "Data :" + txt_4c_Lancamento
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Left      = 120
            .Top       = 116
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Lancamento", "TextBox")
        WITH THIS.txt_4c_Lancamento
            .Left          = 154          && dump getLancamento.Left
            .Top           = 113          && dump getLancamento.Top
            .Width         = 80           && classe fweditdata (dump nao declara)
            .Height        = 23           && classe fweditdata (dump nao declara)
            .FontName      = "Tahoma"     && classe fweditdata
            .FontSize      = 8            && classe fweditdata
            .Alignment     = 3            && classe fweditdata
            .Themes        = .F.          && classe fweditdata - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getLancamento.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getLancamento.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getLancamento.BorderColor
            .Value         = {}           && legado Init: Ctod('  /  /  ')
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Lancamento, "GotFocus", THIS, "TxtLancamentoGotFocus")
        BINDEVENT(THIS.txt_4c_Lancamento, "LostFocus", THIS, "ValidarLancamento")

        *----------------------------------------------------------------------
        * lbl_4c_Label2 "Valor :" + txt_4c_Valor
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Left      = 303
            .Top       = 116
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Left          = 338          && dump getValor.Left
            .Top           = 113          && dump getValor.Top
            .Width         = 80           && dump getValor.Width
            .Height        = 23           && dump getValor.Height (= classe fwget)
            .FontName      = "Tahoma"     && classe fwget
            .FontSize      = 8            && classe fwget
            .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
            .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getValor.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getValor.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getValor.BorderColor
            .Value         = 0.00         && legado Init: getValor.Value = 0.00
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Valor, "GotFocus", THIS, "TxtValorGotFocus")
        BINDEVENT(THIS.txt_4c_Valor, "LostFocus", THIS, "ValidarValor")

        *----------------------------------------------------------------------
        * lbl_4c_Label3 "Historico :" + txt_4c_Historico
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Left      = 102
            .Top       = 140
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Historico", "TextBox")
        WITH THIS.txt_4c_Historico
            .Left          = 154          && dump getHistorico.Left
            .Top           = 137          && dump getHistorico.Top
            .Width         = 264          && dump getHistorico.Width
            .Height        = 23           && classe fwget (dump nao declara)
            .FontName      = "Tahoma"     && classe fwget
            .FontSize      = 8            && classe fwget
            .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
            .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getHistorico.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getHistorico.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getHistorico.BorderColor
            .Value         = ""           && legado Init: getHistorico.Value = ''
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Historico, "GotFocus", THIS, "TxtHistoricoGotFocus")
        BINDEVENT(THIS.txt_4c_Historico, "LostFocus", THIS, "ValidarHistorico")

        *----------------------------------------------------------------------
        * obj_4c_Commandgroup1 - Procurar (Buttons(1)) / Encerrar (Buttons(2))
        * ButtonCount DEVE ser setado ANTES de qualquer Buttons(N) (senao
        * "BUTTONS is not an object").
        *----------------------------------------------------------------------
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = -2
            .Left          = 365
            .Width         = 160
            .Height        = 85
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        *-- NAO atribuir .TabIndex aqui: o grupo e' o ULTIMO AddObject, e
        *-- atribuir no meio da criacao o puxa para a frente dos campos.
        *-- A ordem de tabulacao inteira vai em AplicarOrdemTabulacao(),
        *-- chamado depois de TODOS os AddObject.

        WITH THIS.obj_4c_Commandgroup1.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .Caption         = "\<Procurar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnProcurarClick")

        WITH THIS.obj_4c_Commandgroup1.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        THIS.AplicarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - ordem de tabulacao do legado
    *
    * O TabIndex nao pode ser atribuido dentro do WITH de cada AddObject: o
    * VFP aplica o valor no instante da criacao e CLAMPA ao numero de objetos
    * que existem ali, entao o grupo de botoes (ultimo AddObject) com
    * .TabIndex = 4 era puxado para a 4a posicao e o Tab saltava de "Data"
    * direto para os botoes, pulando Valor e Historico. Medido no VFP9 em
    * 2026-10-30: TabIndex efetivo era Lancamento=3, Commandgroup1=4,
    * Valor=6, Historico=8.
    *
    * O valor LITERAL do dump tambem nao serve como alvo - no legado ele
    * sofre o MESMO clamp. Simulando o load do SCX (recriando os filhos na
    * ordem dos REGISTROS e aplicando o valor logo apos cada AddObject),
    * a ordem EFETIVA do legado lida de volta foi:
    *
    *     getLancamento=1  getValor=2  getHistorico=3
    *     cntSombra=4      Commandgroup1=5   Say1=6  Say2=7  Say3=8
    *
    * isto eh, entre os FOCALIZAVEIS: Lancamento -> Valor -> Historico ->
    * Commandgroup1 (os botoes vem por ULTIMO, nao em 4o). O SCX declara
    * Commandgroup1.TabIndex = 4, mas esse 4 e' inalcancavel por construcao
    * (o grupo e' o 2o registro criado) - transcrever o literal seria FIEL AO
    * ARQUIVO e INFIEL A TELA.
    *
    * Numerar so os FOCALIZAVEIS: Label nao tem TabStop (medido: a property
    * nem existe), entao transcrever o TabIndex dos tres Say e' inerte e
    * ainda embaralha a sequencia de quem realmente para o Tab.
    *
    * Atribuicao em ordem ASCENDENTE e depois de todos os AddObject - cada
    * atribuicao poe o controle na posicao pedida e empurra os demais para
    * tras. Com a ordem de criacao deste form a sequencia ja sai correta, ou
    * seja na pratica isto e' um no-op; fica como documentacao e como guarda
    * caso alguem reordene os AddObject.
    *==========================================================================
    PROCEDURE AplicarOrdemTabulacao()
        THIS.txt_4c_Lancamento.TabIndex    = 1    && SCX getLancamento TabIndex = 1
        THIS.txt_4c_Valor.TabIndex         = 2    && SCX getValor      TabIndex = 2
        THIS.txt_4c_Historico.TabIndex     = 3    && SCX getHistorico  TabIndex = 3
        THIS.obj_4c_Commandgroup1.TabIndex = 4    && SCX declara 4; efetivo = depois dos 3 campos
    ENDPROC

    *==========================================================================
    * TxtLancamentoGotFocus / TxtValorGotFocus / TxtHistoricoGotFocus
    *
    * Transcricao do GotFocus dos 3 campos legado (This.Tag = <valor de
    * entrada>). O estado fica no BO (AtualizarTag*), nao no .Tag do TextBox -
    * so existe para o par Valid/LostFocus seguinte comparar entrada x saida.
    *==========================================================================
    PROCEDURE TxtLancamentoGotFocus()
        THIS.this_oBusinessObject.AtualizarTagDatas(THIS.txt_4c_Lancamento.Value)
    ENDPROC

    PROCEDURE TxtValorGotFocus()
        THIS.this_oBusinessObject.AtualizarTagValors(THIS.txt_4c_Valor.Value)
    ENDPROC

    PROCEDURE TxtHistoricoGotFocus()
        THIS.this_oBusinessObject.AtualizarTagHistorico(THIS.txt_4c_Historico.Value)
    ENDPROC

    *==========================================================================
    * ValidarLancamento / ValidarValor / ValidarHistorico
    *
    * FASE 6 - estes TRES metodos sao a entrega da fase: o Valid de cada campo
    * DIGITAVEL do legado. Os 3 campos deste dialogo aceitam digitacao
    * (nenhum tem ReadOnly nem When -> .f. no dump) e cada um tem um Valid de
    * verdade, entao reproduzi-los e' trabalho DESTA fase, nao da 7/8.
    *
    * Transcricao do Valid dos 3 campos legado - ligados a "LostFocus" porque
    * BINDEVENT "Valid" nao funciona de forma confiavel em TextBox (regra
    * critica #2 do CLAUDE.md). LostFocus cobre as tres saidas de campo que
    * disparam o Valid legado (Enter, Tab e clique fora) e NAO passa
    * parametro, por isso a assinatura e' vazia - handler sem parametro
    * ligado a "KeyPress" estouraria a cada tecla (regra #3).
    *
    * NOME: Validar<Campo> e' o nome canonico do projeto para o handler que
    * reproduz o Valid de um campo. O nome anterior (Txt<Campo>LostFocus) era
    * justamente a assinatura que a regra #47 marca como defeito - ela proibe
    * handler batizado <X>LostFocus porque, no acervo, esse nome aparece
    * ligado a "KeyPress" (picker abrindo a cada tecla). Aqui o binding sempre
    * esteve correto; o que estava fora da convencao era o nome. Os handlers
    * de GotFocus acima NAO entram nesse renome: eles nao validam nada -
    * capturam o valor de ENTRADA (a metade Tag do par) - e o nome deles casa
    * com o evento a que estao ligados.
    *
    * SEM GUARDA DE REENTRANCIA, de proposito: o corpo so escreve .Value nos
    * outros dois TextBox, e escrever .Value nao move o foco - nada redispara
    * o proprio LostFocus. A guarda das regras #37/#47 existe para handler que
    * abre form MODAL (picker); aqui nao ha picker nenhum.
    *
    * O ValidarCriterio* do BO compara entrada x saida e, mudando, ja zera as
    * OUTRAS duas properties de criterio - fonte unica da regra (PILAR 3),
    * inclusive da assimetria do legado: o Valid de Data NAO limpa
    * ThisForm.Continuar, os de Valor e Historico limpam. Aqui so falta
    * espelhar esse zeramento nos TextBox visiveis - exatamente o que o legado
    * faz com ThisForm.get*.Value = Ctod('  /  /  ') / 0.00 / ''.
    *==========================================================================
    PROCEDURE ValidarLancamento()
        IF THIS.this_oBusinessObject.ValidarCriterioDatas(THIS.txt_4c_Lancamento.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    PROCEDURE ValidarValor()
        IF THIS.this_oBusinessObject.ValidarCriterioValors(THIS.txt_4c_Valor.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    PROCEDURE ValidarHistorico()
        IF THIS.this_oBusinessObject.ValidarCriterioHistorico(THIS.txt_4c_Historico.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - FASE 8: tela -> BO (os 3 criterios de pesquisa)
    *
    * Legado: o btnOK.Click le ThisForm.get<Campo>.Value DIRETO, dentro do
    * proprio Do Case. Na arquitetura em camadas quem decide a precedencia dos
    * criterios eh o BO (SigOpCrpBO.BuscarRegistro testa this_dDatas /
    * this_nValors / this_cHists), entao o Form tem de alimentar as tres
    * properties ANTES de chamar a busca - este metodo eh esse unico ponto de
    * leitura dos TextBox de criterio.
    *
    * FUNCTION (nao PROCEDURE) e com retorno conferido pelo chamador: sem o
    * retorno, uma falha aqui deixaria o BtnProcurarClick seguir e o LOCATE
    * rodaria com os criterios do clique ANTERIOR, movendo o cursor do pai para
    * o registro errado sem erro na tela.
    *
    * Nenhuma conversao de tipo eh necessaria nos tres: os .Value nascem
    * Date / Numeric / Character nos WITH de AddObject (ver nota de tipo no
    * cabecalho do arquivo) e as properties do BO sao declaradas nos mesmos
    * tipos ({} / 0.00 / "") - MEDIDO no VFP9 (automation\probe714.prg):
    * VARTYPE devolve D / N / C nos tres controles recem-criados.
    *
    * PROTECTED explicito, e nao por estilo: FormBase.prg:285 declara
    * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o
    * escopo - escrever "FUNCTION FormParaBO" sem o modificador nao torna o
    * metodo publico, so ESCONDE que ele continua protegido (regra #51; medido
    * no probe: chamar loForm.FormParaBO() de fora estoura Program Error e
    * pendura o VFP). Declarar PROTECTED deixa o arquivo dizer a verdade. Os
    * tres hooks sao chamados SO por THIS. - BtnProcurarClick, os tres
    * Validar<Campo>, LimparCampos e InicializarForm.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                .this_dDatas  = THIS.txt_4c_Lancamento.Value
                .this_nValors = THIS.txt_4c_Valor.Value
                .this_cHists  = THIS.txt_4c_Historico.Value
            ENDWITH
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - FASE 8: BO -> tela (os 3 criterios de pesquisa)
    *
    * Sentido inverso do FormParaBO, e o unico ponto que ESCREVE nos TextBox de
    * criterio. Chamado de dois lugares:
    *
    *   1) os tres Validar<Campo>, quando o ValidarCriterio* do BO confirma que
    *      o campo mudou e portanto ja zerou os outros dois criterios - o
    *      legado espelha isso com ThisForm.get<Outro>.Value = <default>;
    *   2) o LimparCampos, depois de zerar as properties.
    *
    * Espelha os TRES campos, inclusive o que acabou de ser digitado - e eh o
    * que permite UM hook em vez das tres copias que havia antes (cada uma
    * espelhando um par diferente de campos), que era a forma de as copias
    * divergirem em silencio ao acrescentar um quarto criterio.
    *
    * Espelhar o proprio campo so eh seguro porque o ValidarCriterio* do BO
    * GUARDA o valor de saida na property do proprio criterio antes de zerar os
    * outros dois. Essa linha foi acrescentada aos tres metodos do BO nesta
    * mesma fase, depois de o probe (automation\probe714c.prg) mostrar o
    * contrario: sem ela a property ficava com o valor ANTERIOR (ela so era
    * alimentada pelo FormParaBO, que roda no Procurar e nao no Valid), e este
    * hook devolvia o valor velho ao campo, APAGANDO o que o usuario tinha
    * acabado de digitar - ValidarValor com 777 deixava a tela em [ / / |0|],
    * que eh o defeito da regra #50. Ao mexer em qualquer um dos dois lados,
    * reexecutar aquele probe: o par "BO guarda o proprio criterio" +
    * "hook espelha os tres" vale junto ou nenhum dos dois vale.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Lancamento.Value = .this_dDatas
                THIS.txt_4c_Valor.Value      = .this_nValors
                THIS.txt_4c_Historico.Value  = .this_cHists
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - FASE 8: funil unico dos defaults do Init legado
    *
    *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
    *     ThisForm.getValor.Value      = 0.00
    *     ThisForm.getHistorico.Value  = ''
    *
    * Zera as properties de criterio do BO e refaz a tela pelo BOParaForm, para
    * o estado ter UMA fonte (o BO) - sem isso tela e BO poderiam discordar,
    * que eh como um criterio "invisivel" sobreviveria a um clique seguinte e
    * moveria o cursor do pai para o registro errado.
    *
    * Zera tambem o this_cContinuar: ele eh o estado de "continuar de onde
    * parei" dos criterios Valor e Historico (legado: ThisForm.Continuar), e
    * limpar os campos sem limpar o acumulador faria o proximo clique entrar no
    * ramo Continue de uma pesquisa que o usuario ja abandonou.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        WITH THIS.this_oBusinessObject
            .this_dDatas     = {}
            .this_nValors    = 0.00
            .this_cHists     = ""
            .this_cContinuar = ""
        ENDWITH

        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * BtnProcurarClick - transcricao de SIGOPCRP.Commandgroup1.btnOK.Click
    *
    * Esta e' a entrega da Fase 7/8 ("eventos principais dos botoes") para
    * este form: o legado so tem este Click e o de BtnEncerrarClick abaixo -
    * ver nota no cabecalho do arquivo sobre a ausencia de
    * Incluir/Alterar/Visualizar/Excluir.
    *
    * 1) Copia os 3 campos da tela para as properties de criterio do BO
    *    (o legado le ThisForm.get*.Value direto dentro do Click - aqui o
    *    BO so testa THIS.this_dDatas/this_nValors/this_cHists, entao o
    *    form precisa alimenta-las antes de chamar BuscarRegistro).
    * 2) BuscarRegistro() faz o LOCATE/CONTINUE no cursor do pai.
    * 3) Refresh + SetFocus na grade do pai - INCONDICIONAL, igual ao legado
    *    (roda mesmo quando o dialogo vai fechar na sequencia).
    * 4) this_lFecharDialogo / this_cCampoFoco decidem Release ou SetFocus
    *    local - mesma assimetria do segundo Do Case legado (ver cabecalho
    *    de SigOpCrpBO.prg, secao "PRECEDENCIA DOS CRITERIOS").
    *==========================================================================
    PROCEDURE BtnProcurarClick()
        *-- FASE 8: a copia tela -> BO saiu daqui para o hook FormParaBO (fonte
        *-- unica). Retorno conferido: falhando a transferencia, o LOCATE
        *-- rodaria com os criterios do clique ANTERIOR e moveria o cursor do
        *-- pai para o registro errado, sem nada na tela.
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.BuscarRegistro()

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "pgf_4c_1", 5)
                IF PEMSTATUS(THIS.this_oFormPai.pgf_4c_1.Page2, "grd_4c_Lancamento", 5)
                    THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.Refresh()
                    THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        DO CASE
            CASE THIS.this_oBusinessObject.this_lFecharDialogo
                THIS.Release()
            CASE THIS.this_oBusinessObject.this_cCampoFoco == "VALOR"
                THIS.txt_4c_Valor.SetFocus()
            CASE THIS.this_oBusinessObject.this_cCampoFoco == "HISTORICO"
                THIS.txt_4c_Historico.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - transcricao de SIGOPCRP.Commandgroup1.btnSair.Click
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - identico ao padrao dos demais forms (percorre
    * Pages de PageFrame e Controls de Container recursivamente). Este form
    * nao tem PageFrame nem container flutuante Visible=.F., mas o metodo fica
    * generico para as proximas fases (obj_4c_Commandgroup1 e os TextBox de
    * campo entram sempre visiveis).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - nenhum cursor local a fechar (CrSigMvCcr pertence ao form pai
    * e nao deve ser tocado aqui); DODEFAULT() preserva o fix de menu/popup da
    * FormBase (regra #29 / Erro58).
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
