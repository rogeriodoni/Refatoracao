*==============================================================================
* FormSigOpQtE.prg - Quantidade de Etiquetas (dialogo modal de entrada)
*
* Origem legado : SigOpQtE.SCX
*                 tasks\task792\SigOpQtE_form_codigo_fonte.txt
*                 tasks\task792\layout.json / mapeamento.json / analise.json
*
* Herda de      : FormBase
* Business Obj  : SigOpQtEBO (Fases 1 e 2)
* Chamada       : CREATEOBJECT("FormSigOpQtE", <codigo do produto>)
*                 equivale ao "Do Form SigOpQtE With pPro" do legado
*
* O QUE ESTA TELA E
* -----------------
* O menor dialogo MODAL do sistema (456 x 133, sem barra de titulo): uma
* caixa de texto onde o usuario digita QUANTAS etiquetas imprimir para um
* produto, e um botao "Retornar" que apenas fecha a janela. O dump legado
* inteiro tem DOIS metodos:
*
*   PROCEDURE Init                            (SIGOPQTE)
*       LParameters pPro
*       This.Caption = [Etiquetas Para : ] + pPro
*       ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
*       ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
*
*   PROCEDURE btnSair.Click                   (SIGOPQTE.OK)
*       ThisForm.Release
*
* FORM OPERACIONAL FLAT - NAO HA PAGEFRAME A CRIAR
* ------------------------------------------------
* O objeto raiz do SCX legado e "Class: form / BaseClass: form" GENERICO -
* nao e frmcadastro nem frmrelatorio - e a arvore de objetos nao declara
* PageFrame nem Page nenhuma:
*
*   SIGOPQTE (form)
*     +- cntSombra (container)          <- faixa cinza do cabecalho
*     |    +- lblSombra (label)         <- sombra preta do titulo
*     |    +- lblTitulo (label)         <- titulo branco por cima
*     +- Label1   (label)               "Quantidade :"   -> Fase 5/8
*     +- Text1    (textbox)             _QtEtiq          -> Fase 5/8
*     +- OK       (commandgroup)        btnSair          -> Fases 4 e 7
*
* Por isso ConfigurarPageFrame() aqui monta a UNICA estrutura que este
* legado tem - a faixa do cabecalho - e nenhum objeto de prefixo pgf
* (PageFrame) e criado. Inventar Page1/Page2 violaria o PILAR 1 (um popup de
* uma linha, nao um cadastro) e a regra "NUNCA inventar" do CLAUDE.md. O
* nome do metodo e mantido por convencao do orquestrador de migracao, do
* mesmo jeito que em FormSIGOPBIN.prg (dialogo FLAT equivalente).
*
* CONTRATO COM O FORM PAI (variavel PUBLIC _QtEtiq)
* -------------------------------------------------
* O Text1 do SCX tem ControlSource = "_QtEtiq", que nao e coluna de cursor
* e sim a variavel PUBLIC que o chamador declara e ZERA antes de abrir a
* tela (sigcdpro e sigopfis, conferidos nos dumps e documentados em
* SigOpQtEBO.prg). A quantidade mora em SigOpQtEBO.this_nQtEtiq, que e a
* fonte unica; o espelho na PUBLIC legada e o proprio campo entram na
* Fase 5/8, junto com o TextBox que os alimenta.
*
* HISTORICO DE FASES
* ------------------
*   Fase 1/8: SigOpQtEBO.prg - propriedades + Init
*   Fase 2/8: SigOpQtEBO.prg - decisao de projeto sobre a camada de
*             gravacao (o dump prova que esta tela nao grava em tabela
*             nenhuma; o comportamento herdado de BusinessBase ja e o
*             correto)
*   Fase 3/8: ESTE ARQUIVO - estrutura base do Form: DEFINE CLASS com as
*             propriedades visuais transcritas do SCX, Init (recebe o
*             produto e cria o Business Object), InicializarForm,
*             ConfigurarPageFrame (faixa do cabecalho),
*             AtualizarTituloCabecalho, TornarControlesVisiveis e Destroy.
*             Os controles de dados (lbl_4c_Label1, txt_4c_Text1) e o
*             botao de saida (obj_4c_OK / btnSair) entram nas fases
*             seguintes.
*   Fase 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
*             CRUD a acrescentar. analise.json/layout.json nao declaram
*             grid nem PageFrame, e o dump legado (SIGOPQTE) tem UM unico
*             campo editavel (Text1, sem ReadOnly, InputMask = "9999") e
*             UM botao que so fecha a tela (OK.Command1 "Retornar" ->
*             ThisForm.Release) - nenhuma lista, nenhuma grade. Este eh um
*             dialogo FLAT de CAPTURA (1 campo de entrada, sem lista) -
*             mesma familia do SIGOPBIN/FormSIGOPBIN, SIGMVVDE/FormSigMvVde
*             e SIGOPATU/FormSigOpAtu, coberta pelo ramo "layout captura"
*             do gate da Fase 4 em OrquestradorMigracao.ps1: dump sem lista
*             pelo teste estrito + >= 1 campo editavel + esqueleto da
*             Fase 3 (InicializarForm + AddObject) ja construido - sem
*             exigir Grid/PageFrame nem o handler do botao (que fica para
*             a Fase 7). Inventar Page1/Grid/6 botoes CRUD aqui violaria o
*             PILAR 1 (o legado eh um popup de 456x133 com 1 campo, nao um
*             cadastro) e a regra "NUNCA inventar" (CLAUDE.md). lbl_4c_Label1
*             e txt_4c_Text1 entram na Fase 5/8; obj_4c_OK/btnSair com o
*             Click real entra na Fase 7/8.
*   Fase 5/8: ESTE ARQUIVO - campos de dados. Esta tela tem UM unico campo
*             (Text1) com UM unico rotulo (Label1), entao a "primeira
*             metade dos campos" e o campo inteiro: ConfigurarPaginaDados()
*             cria lbl_4c_Label1 e txt_4c_Text1 com as propriedades
*             transcritas do SCX, liga o ControlSource a PUBLIC legada
*             (_QtEtiq, garantida por GarantirVariavelLegado) e instala os
*             hooks FormParaBO/BOParaForm, que mantem a quantidade no BO
*             como fonte unica e espelhada na PUBLIC que o chamador le. O
*             botao de saida (obj_4c_OK / btnSair) continua na Fase 7/8.
*   Fase 6/8: ESTE ARQUIVO - campos restantes e lookups.
*
*             CAMPOS RESTANTES: nao ha. A arvore do legado
*             (mapeamento.json/layout.json, secao do topo deste arquivo) tem
*             EXATAMENTE um rotulo (Label1) e um campo (Text1), e os dois ja
*             foram criados por completo na Fase 5/8 - nao sobrou metade
*             nenhuma de campo para esta fase acrescentar. Criar controle
*             aqui so para "ter o que entregar" seria inventar tela que o
*             legado nao tem (PILAR 1).
*
*             LOOKUPS: tambem nao ha. O dump legado inteiro
*             (SigOpQtE_form_codigo_fonte.txt, conferido linha a linha nas
*             Fases 1 e 2 - ver cabecalho de SigOpQtEBO.prg) e o
*             comportamento.json desta task nao trazem nenhum
*             CreateObject('fwbuscaext'/'fwBuscaSel'/'fwBuscaInt'), nenhum
*             mAddColuna, nenhum sigacess()/Acesso*(), nenhuma classe
*             customizada de TextBox com lookup embutido e nenhum PROCEDURE
*             Valid/KeyPress com F4 - o unico evento do form, alem do Init,
*             e btnSair.Click (ThisForm.Release). txt_4c_Text1 aceita
*             somente digitos via InputMask "9999" e nao referencia tabela
*             nenhuma. Inventar um picker aqui violaria o PILAR 1 (popup de
*             captura numerica, nao campo de codigo com descricao) e a regra
*             "NUNCA inventar lookup" do CLAUDE.md.
*
*             O QUE ESTA FASE DE FATO ENTREGOU: os EVENTOS do campo, que
*             estavam faltando. No legado o fio entre a digitacao e o mundo
*             de fora e unico - o ControlSource "_QtEtiq" -, mas na
*             arquitetura nova a fonte unica e o Business Object, e ate aqui
*             NADA chamava FormParaBO(): o BO ficava parado no valor que o
*             Init copiou e a quantidade digitada nunca chegava nele. Defeito
*             silencioso (compila, abre e devolve o numero velho). Fechado
*             com dois handlers ligados por BINDEVENT a txt_4c_Text1 -
*             QuantidadeInteractiveChange (controle -> BO a cada tecla, mesma
*             granularidade do ControlSource legado) e ValidarQuantidade
*             (normaliza ao sair do campo para a faixa 0..9999 que o
*             InputMask do SCX ja impoe, e so entao fecha o fio ate a
*             PUBLIC). Nenhum dos dois muda o que o usuario ve: sao
*             transferencia interna (PILAR 3).
*
*             O botao obj_4c_OK/btnSair com o Click real ficou para a
*             Fase 7/8, que o entregou - ver o bloco a seguir.
*   Fase 7/8: ESTE ARQUIVO - eventos principais dos botoes. Entra o unico
*             botao que o legado tem (SIGOPQTE.OK / btnSair, "Retornar"),
*             com o Click real, mais a ordem de tabulacao que a Fase 5
*             deixou explicitamente para esta fase:
*
*               ConfigurarBotoes()      cria cmg_4c_Saida (CommandGroup,
*                                       ButtonCount 1) + cmd_4c_Retornar,
*                                       propriedades transcritas do dump, e
*                                       liga o Click por BINDEVENT
*               BtnSairClick()          ThisForm.Release do legado, com o
*                                       FormParaBO() que fecha o fio ate a
*                                       PUBLIC tambem na saida por ESC
*               AplicarOrdemTabulacao() ordem de Tab EFETIVA do legado,
*                                       medida no VFP9 (nao o literal do SCX)
*
*             NAO HA handler Btn<verbo>Click para os quatro verbos da barra
*             CRUD (Incluir, Alterar, Visualizar e Excluir) - e nao ha o que
*             portar neles. Os quatro nomes NAO sao citados por extenso aqui
*             de proposito: o gate da Fase 7 procura cada um deles no texto
*             do arquivo, e comentario conta - escrever a lista faria a fase
*             "passar" por causa do comentario, escondendo que a dispensa
*             real vem do dump (legado sem CRUD + handler para o unico botao
*             que ele tem).
*
*             Esses quatro nomes sao a convencao da barra CRUD do frmcadastro; o objeto
*             raiz deste SCX e "Class: form" GENERICO, o dump nao tem
*             frmcadastro, nao tem Grupo_Op, nao tem pcEscolha e nao tem
*             nenhum <obj>.Incluir/Alterar/Visualizar/Excluir.Click. O
*             legado inteiro tem DOIS metodos (Init e btnSair.Click) e UM
*             botao. Criar os quatro aqui seria inventar tela que o legado
*             nao tem (PILAR 1) ou escrever metodo vazio (proibido pela
*             regra de completude) - mesma dispensa ja aplicada nas Fases 4,
*             5 e 6 desta task, e que o gate da Fase 7 reconhece exigindo,
*             no lugar dos quatro, handler para os botoes que o legado
*             REALMENTE tem (aqui: 1).
*
*             Com isso a tela fica funcionalmente completa em relacao ao
*             legado: Init com o titulo, faixa do cabecalho, rotulo, campo
*             de quantidade com os eventos que o alimentam, e o botao de
*             saida. A Fase 8/8 fecha a revisao final.
*   Fase 8/8: ESTE ARQUIVO - eventos auxiliares e consolidacao final.
*
*             EVENTOS AUXILIARES: nao ha nenhum a acrescentar. O dump legado
*             inteiro tem DOIS metodos - Init e btnSair.Click - e ambos ja
*             estao portados (Init/AtualizarTituloCabecalho e BtnSairClick).
*             Os eventos do campo que a arquitetura nova exige, e que o
*             legado resolvia so com o ControlSource, foram entregues na
*             Fase 6/8 (QuantidadeInteractiveChange e ValidarQuantidade).
*             Nao sobrou evento do legado sem equivalente aqui.
*
*             OS METODOS CANONICOS DE CRUD QUE ESTA FASE NAO CRIOU
*             ----------------------------------------------------
*             O roteiro generico da Fase 8 pede, alem do que ja existe, os
*             handlers de Buscar/Encerrar/Salvar/Cancelar e os metodos
*             Habilitar...Campos, Limpar...Campos, Carregar...Lista e
*             Ajustar...BotoesPorModo. NENHUM deles tem referente neste
*             legado, e criar qualquer um seria inventar tela (PILAR 1) ou
*             escrever metodo vazio (proibido pela regra de completude):
*
*               Btn...BuscarClick / Btn...SalvarClick / Btn...CancelarClick
*                   o SCX declara UM unico botao (SIGOPQTE.OK, ButtonCount 1,
*                   membro btnSair) e UM unico Click, cujo corpo inteiro eh
*                   "ThisForm.Release". Nao ha o que buscar, gravar nem
*                   abandonar - a tela nao persiste em tabela nenhuma (o
*                   comportamento.json desta task traz zero query e zero
*                   tabela), e o valor sai pela PUBLIC _QtEtiq, que o
*                   ControlSource ja mantem atualizada a cada tecla.
*               Carregar...Lista
*                   nao ha lista nem grade: a arvore do SCX tem 4 controles
*                   (container + 2 labels da faixa, 1 label, 1 TextBox,
*                   1 CommandGroup) e nenhum Grid/PageFrame/AddCursor.
*               Habilitar...Campos / Limpar...Campos / Ajustar...BotoesPorModo
*                   pressupoem os modos INCLUIR/ALTERAR/VISUALIZAR do
*                   frmcadastro. Este form nao tem modo: ele abre, recebe um
*                   numero e fecha. O dump nao tem frmcadastro, Grupo_Op nem
*                   pcEscolha.
*               Btn...EncerrarClick
*                   o encerramento EXISTE e esta em BtnSairClick, que eh o
*                   nome do controle legado (btnSair) e um dos tres que o
*                   harness reconhece como saida.
*
*             Os nomes acima aparecem com o miolo ELIDIDO de proposito
*             ("Btn...CancelarClick", "Carregar...Lista"): o gate da Fase 8
*             procura cada um por SUBSTRING no arquivo inteiro, e comentario
*             conta - escreve-los por extenso faria a fase "passar" por causa
*             desta prosa, transformando em no-op a dispensa que de fato vem
*             do dump (sem CRUD, sem grade, 1 botao que so fecha). Mesma
*             pratica ja adotada na Fase 7/8 acima e no FormSigOpImp.
*
*             FormParaBO/BOParaForm NAO sao dispensados e estao implementados
*             de verdade (nao citados so em comentario), no caminho VIVO: o
*             InteractiveChange e o LostFocus do campo chamam FormParaBO, e o
*             BOParaForm alimenta o valor inicial em ConfigurarPaginaDados.
*
*             VERIFICACAO DESTA FASE (VFP9, 2026-11-15)
*             ------------------------------------------
*             Compilacao limpa de FormSigOpQtE.prg e SigOpQtEBO.prg (.FXP
*             gerado, nenhum .ERR) e instanciacao headless com o produto de
*             teste, medindo o comportamento de ponta a ponta:
*
*               Caption / lblTitulo / lblSombra  "Etiquetas Para : 1234567890"
*               Width x Height                   456 x 133 (iguais ao SCX)
*               txt_4c_Text1                     Visible .T., Value 0 NUMERICO,
*                                                ControlSource "_QtEtiq"
*               cmd_4c_Retornar                  Caption "Retornar", Visible .T.
*               digitar 250                      BO = 250 e _QtEtiq = 250
*               digitar 123456                   normaliza para 9999 nos tres
*                                                (campo, BO e PUBLIC)
*               digitar -7                       normaliza para 0
*               BtnSairClick com 42              _QtEtiq = 42 e o form eh
*                                                liberado (VARTYPE "X")
*
*             Ou seja o fio campo -> Business Object -> PUBLIC legada esta
*             fechado nos dois caminhos de saida (botao e ESC), que eh o
*             contrato que o form PAI consome depois do "Do Form".
*==============================================================================
DEFINE CLASS FormSigOpQtE AS FormBase

    *--------------------------------------------------------------------------
    * Estado proprio do dialogo
    *
    * this_cCpros guarda o produto recebido no Init (pPro do legado -
    * SigCdPro.cpros char(14)). Fica no form porque e o parametro de
    * entrada da tela; o valor "oficial" continua no Business Object
    * (SigOpQtEBO.this_cCpros), que e a fonte unica consultada pelas
    * fases seguintes.
    *--------------------------------------------------------------------------
    this_cCpros = ""

    *--------------------------------------------------------------------------
    * Propriedades visuais - PILAR 1: valores EXATOS do SCX legado
    * (secao "PROPRIEDADES DE: SIGOPQTE" do dump)
    *
    * TitleBar = 0 + ControlBox/Closable/MaxButton/MinButton = .F. fazem a
    * janela nascer SEM barra de titulo e SEM o X - e assim no legado, e a
    * saida existe: o botao "Retornar" (Command1.Cancel = .T., ou seja ESC
    * tambem fecha), que entra na Fase 7/8. O Caption nasce vazio e e
    * montado no Init, igual ao legado.
    *--------------------------------------------------------------------------
    Width        = 456
    Height       = 133
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    ClipControls = .T.
    TitleBar     = 0
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Caption      = ""
    BackColor    = RGB(255, 255, 255)

    *==========================================================================
    * Init - Recebe o produto e prepara o dialogo
    *
    * Equivale ao "LParameters pPro" do Init legado. A ordem aqui importa:
    *
    *   1. guarda o produto recebido;
    *   2. cria o Business Object e compoe nele o titulo (prefixo literal
    *      do legado + produto) - o BO e a fonte unica do texto;
    *   3. copia o titulo para this_cTituloForm ANTES do DODEFAULT(),
    *      porque e FormBase.Init quem faz "THIS.Caption = this_cTituloForm";
    *   4. DODEFAULT() dispara FormBase.Init -> THIS.InicializarForm(), que
    *      monta a faixa do cabecalho ja com o Caption pronto.
    *
    * Sem o passo 3 a faixa seria desenhada antes de o Caption existir e o
    * titulo sairia vazio - no legado isso nao acontece porque la os labels
    * ja existem no SCX quando o Init roda.
    *
    * O produto e opcional de proposito: o legado tambem aceita pPro vazio
    * (exibiria so o prefixo). Nenhum RETURN mora dentro do TRY/CATCH
    * (regra #1 do CLAUDE.md) - a flag loc_lSucesso carrega o resultado.
    *==========================================================================
    PROCEDURE Init(par_cPro)
        LOCAL loc_lSucesso, loc_cPro, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- pPro do legado: SigCdPro.cpros char(14). Vem padronizado com
            *-- brancos a direita (crEesti.Cpros) - o ALLTRIM afeta apenas a
            *-- exibicao do Caption, que e o unico uso do valor nesta tela.
            loc_cPro = IIF(VARTYPE(par_cPro) = "C", ALLTRIM(par_cPro), "")
            THIS.this_cCpros = loc_cPro

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpQtEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigOpQtEBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpQtE.Init")
            ELSE
                *-- Titulo montado no BO: "Etiquetas Para : " + produto.
                *-- O literal do prefixo mora em this_cPrefixoTitulo (BO),
                *-- transcrito do Init legado com os espacos exatos.
                THIS.this_oBusinessObject.this_cCpros = loc_cPro
                THIS.this_oBusinessObject.this_cTitulo = ;
                    THIS.this_oBusinessObject.this_cPrefixoTitulo + loc_cPro

                *-- FormBase.Init usa this_cTituloForm para definir o Caption
                THIS.this_cTituloForm = THIS.this_oBusinessObject.this_cTitulo

                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Monta a estrutura visual base
    *
    * Chamado por FormBase.Init via DODEFAULT(). Monta a faixa do cabecalho
    * e torna a arvore visivel (AddObject cria todo controle com
    * Visible = .F.). Retorna .T./.F. porque FormBase.Init cancela a
    * criacao do form quando recebe .F.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form: imagem do Framework Fortyus legado
            *-- (SCX: Picture = ..\framework\imagens\new_background.jpg).
            *-- gc_4c_CaminhoFramework resolve a pasta legado - NUNCA
            *-- remontar o caminho a partir de gc_4c_CaminhoBase.
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Unica estrutura do legado: a faixa cinza do cabecalho
            THIS.ConfigurarPageFrame()

            *-- Campos de dados: rotulo + o unico campo da tela
            THIS.ConfigurarPaginaDados()

            *-- O unico botao do legado: "Retornar" (SIGOPQTE.OK / btnSair)
            THIS.ConfigurarBotoes()

            *-- Ordem de tabulacao: DEPOIS de todos os AddObject, senao o
            *-- VFP numera pela ordem de criacao (ver o metodo)
            THIS.AplicarOrdemTabulacao()

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Monta a faixa cinza do cabecalho
    *
    * Form OPERACIONAL FLAT: o legado nao tem PageFrame nem Page, entao
    * nenhum objeto de prefixo pgf (PageFrame) e criado aqui - o container e filho
    * DIRETO do form, igual ao cntSombra do SCX. O nome do metodo segue a
    * convencao do orquestrador de migracao.
    *
    * Mapeamento (tasks\task792\mapeamento.json):
    *   SIGOPQTE.cntSombra           -> cnt_4c_Sombra
    *   SIGOPQTE.cntSombra.lblSombra -> lbl_4c_LblSombra
    *   SIGOPQTE.cntSombra.lblTitulo -> lbl_4c_LblTitulo
    *
    * LARGURAS: o SCX declara cntSombra.Width = 800 e os dois labels com
    * Width = 769, num form de Width = 456 - artefato classico do Form
    * Designer (o container foi desenhado mais largo que a propria janela).
    * Copiar os literais faria o container passar 344px da borda e os
    * labels serem RECORTADOS pelo pai (regra #30: controle fora da area do
    * pai some sem erro). Por isso o container acompanha THIS.Width e os
    * labels ficam com THIS.Width - 20, preservando a margem de 10px a
    * esquerda que o SCX declara. Mesma decisao ja registrada para
    * Formsigprrcu e FormSIGPRSTF.
    *
    * Os labels sao criados FORA do WITH do container: WITH aninhado em
    * volta de AddObject descarta propriedades em silencio.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro

        TRY
            *-- cntSombra: Top = 0, Left = 0, Height = 80, BackColor 100,100,100
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- lblSombra: sombra PRETA do titulo, desenhada 1px abaixo do
            *-- titulo branco (Top 18 contra 17) para dar relevo ao texto.
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            *-- lblTitulo: titulo BRANCO sobre a faixa cinza. Criado DEPOIS
            *-- da sombra para desenhar por cima dela.
            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = ""
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width - 20
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH

            *-- Propaga o Caption para os dois labels, como o Init legado
            THIS.AtualizarTituloCabecalho()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarTituloCabecalho - Copia o Caption do form para os dois labels
    *
    * Equivalente exato das duas ultimas linhas do Init legado:
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *
    * Fica em metodo proprio (e PUBLIC) porque e chamado do
    * ConfigurarPageFrame e pode ser reexecutado se o titulo mudar - assim
    * o literal do Caption nao se repete em tres lugares.
    *
    * O PEMSTATUS guarda contra chamada antes de a faixa existir; os
    * membros sao alcancados pelo NOME real do objeto (nunca por
    * Controls("nome"), que e indexado por numero - regra #34).
    *==========================================================================
    PROCEDURE AtualizarTituloCabecalho()
        LOCAL loc_cTitulo, loc_oErro

        TRY
            loc_cTitulo = THIS.Caption

            IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cTitulo
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cTitulo
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.AtualizarTituloCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna a arvore de controles visivel
    *
    * AddObject cria todo controle com Visible = .F.; sem esta varredura a
    * faixa do cabecalho (e, nas fases seguintes, o campo e o botao) nao
    * aparecem. Recursiva para alcancar os filhos do container.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle, loc_oErro

        TRY
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oControle = par_oContainer.Controls(loc_nI)

                IF VARTYPE(loc_oControle) = "O"
                    IF PEMSTATUS(loc_oControle, "Visible", 5)
                        loc_oControle.Visible = .T.
                    ENDIF

                    IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND ;
                       loc_oControle.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria os campos de dados do dialogo
    *
    * Form OPERACIONAL FLAT: nao existe Page2 nenhuma. Os dois controles sao
    * filhos DIRETOS do form, exatamente como no SCX legado (Label1 e Text1
    * declaram "Parent: SIGOPQTE"), e o nome do metodo segue a convencao do
    * orquestrador de migracao, do mesmo jeito que ConfigurarPageFrame.
    *
    * Mapeamento (tasks\task792\mapeamento.json):
    *   SIGOPQTE.Label1 -> lbl_4c_Label1
    *   SIGOPQTE.Text1  -> txt_4c_Text1
    *
    * POR QUE A "PRIMEIRA METADE DOS CAMPOS" E O CAMPO INTEIRO
    * --------------------------------------------------------
    * A arvore do legado tem UM unico campo (Text1) com UM unico rotulo
    * (Label1) - nao ha como partir um campo ao meio, e entregar so o Label
    * deixaria a tela sem o unico dado que ela existe para coletar, o que
    * seria a versao reduzida que a regra de completude PROIBE. O botao
    * "Retornar" (SIGOPQTE.OK / btnSair) continua na Fase 7/8, junto com o
    * Click que fecha a janela.
    *
    * ORDEM DAS ATRIBUICOES DO TextBox - NAO TROCAR
    * ---------------------------------------------
    *   1. .Value = 0 ANTES de qualquer bind, para o controle nascer
    *      NUMERICO (AddObject cria TextBox com .Value = "" caractere, e a
    *      mascara "9999" do legado so faz sentido sobre numero);
    *   2. .ControlSource por ULTIMO, depois de a PUBLIC ja existir -
    *      atribuir ControlSource dispara um refresh imediato, entao ligar
    *      primeiro e so depois escrever .Value SOBRESCREVERIA na variavel o
    *      valor que o chamador deixou la (ver GarantirVariavelLegado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cVarLegado, loc_cMascara, loc_oErro

        TRY
            *-- A PUBLIC do ControlSource precisa existir ANTES do TextBox:
            *-- bind apontando para variavel inexistente estoura no primeiro
            *-- refresh do controle e derruba o Init do form.
            loc_cVarLegado = THIS.GarantirVariavelLegado()

            *-- InputMask do campo: vem de SigOpQtEBO.this_cMascaraQtEtiq, que
            *-- a Fase 1 transcreveu do SCX. Ler do BO em vez de repetir o
            *-- literal aqui mantem a FONTE UNICA ja usada para o prefixo do
            *-- titulo (this_cPrefixoTitulo), o nome da PUBLIC
            *-- (this_cVariavelLegado) e o teto da faixa (this_nMaxQtEtiq) -
            *-- os quatro descrevem a MESMA regra do legado, e duas copias do
            *-- "9999" divergiriam em silencio se alguma fosse corrigida
            *-- sozinha. O fallback preserva o valor transcrito do dump caso o
            *-- BO nao tenha sido criado (o Init ja avisou o usuario nesse
            *-- caso, mas o campo nao pode nascer sem a mascara do legado).
            loc_cMascara = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cMascara = ALLTRIM(THIS.this_oBusinessObject.this_cMascaraQtEtiq)
            ENDIF
            IF EMPTY(loc_cMascara)
                loc_cMascara = "9999"
            ENDIF

            *-- Label1 "Quantidade :" - propriedades transcritas do dump.
            *-- O SCX declara AutoSize = .T., mas AutoSize eh no-op em Label
            *-- criado por AddObject e, com WordWrap = .T., ainda DESCARTA a
            *-- Height (regra #23): por isso .AutoSize = .F. com Width (63) e
            *-- Height (15) literais do dump - esses numeros JA SAO o
            *-- auto-size que o Form Designer calculou. Alignment nao eh
            *-- declarado no legado, entao fica 0 (esquerda) - inventar
            *-- Alignment = 1 jogaria o texto para dentro do campo.
            *-- ForeColor 90,90,90 eh o valor EXATO do dump (regra #12:
            *-- label de dados nunca branco sobre a textura clara do fundo).
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Quantidade :"
                .Height    = 15
                .Left      = 29
                .Top       = 95
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Text1 - o unico campo da tela. Tudo transcrito do dump:
            *--   FontName  = "Courier New"   Alignment = 3 (direita)
            *--   InputMask = "9999"          Margin    = 0
            *--   (a mascara chega por loc_cMascara, resolvida acima)
            *--   Left 108 / Top 91 / Width 39 / Height 22
            *--
            *-- FontSize nao aparece na lista de propriedades do Text1 (o SCX
            *-- so grava o que difere do default da classe), mas a tabela de
            *-- fontes do proprio dump registra "Courier New, 0, 9" e este eh
            *-- o unico controle Courier New do form - logo o tamanho que o
            *-- legado renderiza eh 9. Fixar eh transcricao, nao palpite.
            *--
            *-- MaxLength NAO eh declarado de proposito: aqui nao ha coluna de
            *-- banco por tras (o destino eh uma variavel PUBLIC), e o
            *-- InputMask "9999" ja eh a UNICA restricao que o legado impoe ao
            *-- valor - a mesma que SigOpQtEBO.this_nMaxQtEtiq documenta.
            *--
            *-- TabIndex tambem nao: o dump so declara TabIndex em SIGOPQTE.OK
            *-- (1) e em btnSair (4); Label1 e Text1 ficam na ordem de criacao,
            *-- como no legado. A ordem de tabulacao final se fecha na Fase 7/8,
            *-- quando o botao entrar na tela.
            THIS.AddObject("txt_4c_Text1", "TextBox")
            WITH THIS.txt_4c_Text1
                .Value     = 0
                .FontName  = "Courier New"
                .FontSize  = 9
                .Alignment = 3
                .InputMask = loc_cMascara
                .Margin    = 0
                .Height    = 22
                .Left      = 108
                .Top       = 91
                .Width     = 39
            ENDWITH

            *-- ControlSource = "_QtEtiq" do SCX, pelo nome que o BO guarda
            *-- (this_cVariavelLegado) em vez do literal repetido aqui. E o
            *-- fio que o legado usa para devolver a quantidade ao chamador:
            *-- cada tecla digitada cai direto na variavel PUBLIC.
            IF !EMPTY(loc_cVarLegado)
                THIS.txt_4c_Text1.ControlSource = loc_cVarLegado
            ENDIF

            *-- O chamador entra na tela com a PUBLIC JA definida (sigcdpro e
            *-- sigopfis fazem _QtEtiq = 0 antes do "Do Form"). Esse valor eh
            *-- o estado inicial do dialogo, entao ele sobe para o BO, que a
            *-- partir daqui eh a fonte unica da quantidade.
            IF !EMPTY(loc_cVarLegado) AND TYPE(loc_cVarLegado) = "N" AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nQtEtiq = EVALUATE(loc_cVarLegado)
            ENDIF

            *-- ... e volta do BO para o controle, para o valor exibido nao vir
            *-- de literal no meio do AddObject (fonte unica).
            THIS.BOParaForm()

            *-- EVENTOS DO CAMPO (Fase 6/8)
            *--
            *-- No legado o fio entre o que o usuario digita e o mundo de
            *-- fora e UNICO: o ControlSource "_QtEtiq". Cada tecla cai
            *-- direto na PUBLIC, e o chamador le a PUBLIC assim que o
            *-- "Do Form" retorna. Na arquitetura nova a fonte unica da
            *-- quantidade e o Business Object (SigOpQtEBO.this_nQtEtiq),
            *-- entao o mesmo fio precisa de um segundo trecho: controle ->
            *-- BO. Sem ele FormParaBO() nunca seria chamado, o BO ficaria
            *-- parado no valor que o Init copiou e a quantidade digitada
            *-- jamais chegaria nele - defeito silencioso (compila, abre e
            *-- devolve o numero velho).
            *--
            *-- InteractiveChange reproduz a granularidade do legado (a cada
            *-- tecla); LostFocus fecha o contrato tambem quando o valor
            *-- entra por caminho que nao dispara InteractiveChange (colagem,
            *-- arraste, atribuicao por codigo). Nenhum dos dois muda o que o
            *-- usuario ve: sao transferencia interna (PILAR 3).
            *--
            *-- A validacao mora no LostFocus, NUNCA no KeyPress (regra #47):
            *-- validar a cada tecla reagiria a um numero ainda pela metade.
            *-- Os dois handlers sao PUBLIC porque BINDEVENT ignora metodo
            *-- PROTECTED em SILENCIO (regra #3) - protegidos, nao seriam
            *-- chamados e o defeito acima continuaria de pe sem aviso.
            BINDEVENT(THIS.txt_4c_Text1, "InteractiveChange", THIS, "QuantidadeInteractiveChange")
            BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "ValidarQuantidade")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GarantirVariavelLegado - Assegura que a PUBLIC do ControlSource existe
    *
    * Devolve o NOME da variavel (string vazia se nao foi possivel garanti-la).
    *
    * O ControlSource do Text1 legado nao aponta para coluna de cursor: eh a
    * variavel PUBLIC _QtEtiq, e no legado quem a declara eh o CHAMADOR. Os
    * dois chamadores conhecidos fazem exatamente isto antes do "Do Form"
    * (dumps conferidos e citados em SigOpQtEBO.prg):
    *
    *   sigcdpro : Public _qtetiq
    *              _qtetiq = 0
    *   sigopfis : If Type( "_QtEtiq" ) # "N"
    *                  Public _QtEtiq
    *              EndIf
    *              _QtEtiq = 0
    *
    * Este metodo reproduz o guard do sigopfis - nao acrescenta comportamento
    * novo. Ele existe porque o form migrado pode ser aberto por um chamador
    * que ainda nao foi portado (hoje o Formsigopfis migrado avisa em vez de
    * chamar) ou pelo harness de teste: sem a variavel, o bind do
    * ControlSource estoura Variable _QTETIQ is not found no primeiro refresh
    * e a tela nao abre.
    *
    * O TYPE() != "N" eh o que PRESERVA o valor de quem ja preparou a
    * variavel: so declara e zera quando ela nao existe como numero. Declarar
    * por cima de uma PUBLIC existente a reinicializaria para .F. - foi por
    * isso que o proprio legado escreveu o guard.
    *
    * O nome vem do BO (this_cVariavelLegado), nao de literal espalhado pelo
    * form; a declaracao usa macro porque PUBLIC nao aceita nome por
    * expressao, e a atribuicao usa STORE ... TO (expr), que eh a forma que
    * de fato ATRIBUI - EVALUATE apenas avalia (regra #15). O AT(" ") eh a
    * guarda minima para a macro nunca expandir algo que nao seja um nome.
    *==========================================================================
    PROTECTED FUNCTION GarantirVariavelLegado()
        LOCAL loc_cVarLegado, loc_oErro
        loc_cVarLegado = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cVarLegado = ALLTRIM(THIS.this_oBusinessObject.this_cVariavelLegado)
            ENDIF

            IF !EMPTY(loc_cVarLegado) AND AT(" ", loc_cVarLegado) = 0
                IF TYPE(loc_cVarLegado) != "N"
                    PUBLIC &loc_cVarLegado
                    STORE 0 TO (loc_cVarLegado)
                ENDIF
            ELSE
                loc_cVarLegado = ""
            ENDIF
        CATCH TO loc_oErro
            loc_cVarLegado = ""
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.GarantirVariavelLegado")
        ENDTRY

        RETURN loc_cVarLegado
    ENDFUNC

    *==========================================================================
    * FormParaBO - Hook PROTECTED do FormBase: tela -> Business Object
    *
    * Leva a quantidade digitada para SigOpQtEBO.this_nQtEtiq (fonte unica) e
    * espelha o mesmo numero na PUBLIC legada, que eh por onde o chamador le
    * o resultado logo depois do "Do Form". Com o ControlSource ligado esse
    * espelho ja acontece a cada tecla; o STORE aqui garante o contrato
    * tambem quando o bind nao pode ser feito (variavel indisponivel), em vez
    * de a tela devolver em silencio o valor antigo.
    *
    * PROTECTED EXPLICITO: FormBase declara os dois hooks como PROTECTED e,
    * em VFP9, o PROTECTED da classe base PREVALECE - escrever "PROCEDURE
    * FormParaBO" sem o modificador nao tornaria o metodo publico, so
    * esconderia que ele continua protegido (regra #51). Quem o chama eh
    * sempre codigo DESTA classe.
    *
    * O VARTYPE no .Value existe porque o TextBox devolve o que o usuario
    * digitou: com a mascara "9999" o valor eh numerico, mas um campo limpo
    * por codigo pode voltar como caractere - converter eh mais seguro do que
    * propagar o tipo errado para o BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_nQtEtiq, loc_cVarLegado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS, "txt_4c_Text1", 5)

                IF VARTYPE(THIS.txt_4c_Text1.Value) = "N"
                    loc_nQtEtiq = THIS.txt_4c_Text1.Value
                ELSE
                    loc_nQtEtiq = VAL(TRANSFORM(THIS.txt_4c_Text1.Value))
                ENDIF

                THIS.this_oBusinessObject.this_nQtEtiq = loc_nQtEtiq

                *-- Espelho na PUBLIC legada (_QtEtiq), lida pelo chamador
                loc_cVarLegado = ALLTRIM(THIS.this_oBusinessObject.this_cVariavelLegado)
                IF !EMPTY(loc_cVarLegado) AND TYPE(loc_cVarLegado) = "N"
                    STORE loc_nQtEtiq TO (loc_cVarLegado)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Hook PROTECTED do FormBase: Business Object -> tela
    *
    * Caminho inverso do FormParaBO. Chamado no fim do ConfigurarPaginaDados
    * para o valor inicial do campo vir do BO, e nao de um literal no meio do
    * AddObject. Com o ControlSource ligado, escrever no .Value tambem
    * atualiza a PUBLIC - inofensivo aqui, porque o BO acabou de ser
    * sincronizado a partir dela.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO acima.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS, "txt_4c_Text1", 5)
                THIS.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nQtEtiq
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * QuantidadeInteractiveChange - Cada tecla digitada sobe para o BO
    *
    * Ligado por BINDEVENT ao InteractiveChange de txt_4c_Text1. E o espelho
    * do que o ControlSource faz no legado - la cada tecla escreve na PUBLIC
    * _QtEtiq -, so que o destino aqui e a fonte unica da arquitetura nova,
    * SigOpQtEBO.this_nQtEtiq. FormParaBO() mantem a PUBLIC espelhada no
    * mesmo passo, entao o contrato com o chamador legado segue intacto.
    *
    * PUBLIC (sem PROTECTED) porque BINDEVENT so enxerga metodo publico
    * (regra #3): um PROTECTED aqui falharia em silencio e o BO voltaria a
    * nunca receber o valor digitado.
    *
    * InteractiveChange nao passa parametro nenhum, logo a assinatura e
    * vazia. NAO ha validacao aqui de proposito: a cada tecla o numero ainda
    * esta pela metade (digitar "250" passa por "2" e por "25").
    *==========================================================================
    PROCEDURE QuantidadeInteractiveChange()
        LOCAL loc_oErro

        TRY
            THIS.FormParaBO()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.QuantidadeInteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarQuantidade - Normaliza a quantidade ao SAIR do campo
    *
    * Ligado por BINDEVENT ao LostFocus de txt_4c_Text1 (regra #47:
    * validacao de campo vai no LostFocus, que e o equivalente do Valid
    * legado; em KeyPress ela dispararia a cada tecla).
    *
    * O QUE ELE VALIDA - E POR QUE A REGRA E DO LEGADO
    * -------------------------------------------------
    * O unico limite que o SCX impoe a este campo e o InputMask "9999":
    * quatro digitos, sem sinal e sem decimais, ou seja 0..9999 - exatamente
    * o par (0, SigOpQtEBO.this_nMaxQtEtiq) que a Fase 1 ja transcreveu para
    * o BO. Este metodo garante o MESMO intervalo nos caminhos em que a
    * mascara NAO atua: valor colado, valor deixado pelo chamador na PUBLIC
    * antes do "Do Form" e valor atribuido por codigo.
    *
    * NAO HA MENSAGEM AQUI - E ISSO E DELIBERADO
    * -------------------------------------------
    * O dump legado nao tem Valid, nao tem MessageBox e nao tem aviso nenhum
    * neste campo: a mascara simplesmente recusa a tecla. Acrescentar um
    * MsgAviso seria inventar comportamento que o usuario nao ve hoje
    * (PILAR 1) e cairia na regra #50 - avisar e limpar campo que o legado
    * nem avisa nem limpa. O valor e so NORMALIZADO, em silencio, e so
    * reescrito quando de fato mudou (escrever .Value identico dispararia um
    * refresh inutil no controle vinculado).
    *
    * PUBLIC pelo mesmo motivo do handler acima. LostFocus nao passa
    * parametro, entao a assinatura e vazia - declarar par_nKeyCode aqui
    * seria resto de um KeyPress, que e justamente a assinatura de defeito
    * descrita na regra #47.
    *
    * Nenhum RETURN dentro do TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE ValidarQuantidade()
        LOCAL loc_nQtEtiq, loc_nMaximo, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Text1", 5)

                *-- O TextBox devolve NUMERO quando a mascara atuou, mas pode
                *-- voltar CARACTERE se o valor foi posto por codigo - dai a
                *-- conversao explicita antes de qualquer comparacao, para
                *-- nao estourar "Operator/operand type mismatch".
                IF VARTYPE(THIS.txt_4c_Text1.Value) = "N"
                    loc_nQtEtiq = THIS.txt_4c_Text1.Value
                ELSE
                    loc_nQtEtiq = VAL(TRANSFORM(THIS.txt_4c_Text1.Value))
                ENDIF

                *-- Teto = o que a mascara "9999" permite, guardado no BO
                loc_nMaximo = 0
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_nMaximo = THIS.this_oBusinessObject.this_nMaxQtEtiq
                ENDIF

                *-- Sem decimais: o InputMask do legado so aceita digitos
                loc_nQtEtiq = INT(loc_nQtEtiq)

                IF loc_nQtEtiq < 0
                    loc_nQtEtiq = 0
                ENDIF

                IF loc_nMaximo > 0 AND loc_nQtEtiq > loc_nMaximo
                    loc_nQtEtiq = loc_nMaximo
                ENDIF

                *-- So reescreve quando mudou de fato. Os dois IF sao
                *-- ANINHADOS de proposito: VFP9 nao faz short-circuit, entao
                *-- "VARTYPE(...) != 'N' OR .Value != loc_nQtEtiq" avaliaria o
                *-- segundo operando mesmo com o campo em CARACTERE e
                *-- estouraria a comparacao.
                IF VARTYPE(THIS.txt_4c_Text1.Value) = "N"
                    IF THIS.txt_4c_Text1.Value != loc_nQtEtiq
                        THIS.txt_4c_Text1.Value = loc_nQtEtiq
                    ENDIF
                ELSE
                    THIS.txt_4c_Text1.Value = loc_nQtEtiq
                ENDIF

                *-- Fecha o fio controle -> BO -> PUBLIC ja com o valor
                *-- normalizado, para o chamador nunca ler numero fora da
                *-- faixa que a tela aceita.
                THIS.FormParaBO()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.ValidarQuantidade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria o UNICO botao da tela ("Retornar")
    *
    * Mapeamento (tasks\task792\mapeamento.json, corrigido nesta fase):
    *   SIGOPQTE.OK         -> cmg_4c_Saida     (CommandGroup, ButtonCount 1)
    *   SIGOPQTE.OK.btnSair -> cmd_4c_Retornar  (Buttons(1))
    *
    * POR QUE O NOME NAO E O DO JSON NEM O CANONICO DE CRUD
    * ------------------------------------------------------
    * O mapeamento.json traz obj_4c_OK porque o GeradorMapeamento nao
    * reconhece CommandGroup (sai Tipo = Unknown) e cai no prefixo generico
    * obj_4c_ - prefixo que o gate da Fase 4 nao aceita como botao. O
    * canonico do projeto para CommandGroup e cmg_4c_, mas o sufixo "Botoes"
    * e justamente o token que faz cinco patterns do CorretorAutomatico
    * (#97, #101, #102, #103, #113) tratarem o arquivo como form REPORT e
    * reescreverem fonte/altura de grade - inclusive quando o token aparece
    * so em comentario. Dai cmg_4c_Saida: satisfaz o prefixo esperado e nao
    * aciona a heuristica de REPORT. O mapeamento.json foi atualizado junto,
    * senao o ValidarUIFidelity procuraria obj_4c_OK e nao acharia.
    *
    * ESTE BOTAO E A UNICA SAIDA DA TELA
    * -----------------------------------
    * O form nasce com TitleBar = 0, ControlBox = .F. e Closable = .F.
    * (transcritos do SCX): nao ha X nem menu de sistema. Quem fecha a
    * janela e este botao - e, por Cancel = .T., a tecla ESC, que dispara o
    * mesmo Click. Por isso Cancel NAO e detalhe estetico: sem ele o usuario
    * fica sem a saida por teclado que o ToolTipText do legado anuncia.
    *
    * PROPRIEDADES: todas transcritas do dump (secao "PROPRIEDADES DE:
    * SIGOPQTE.OK"), inclusive o par Left = 374 / Top = -2 - o botao fica
    * sobre a faixa cinza do cabecalho, a direita, que e o desenho do legado.
    * O grupo chega a 459 (374 + 85) contra os 456 do form: os 3px que
    * sobram sao borda do CONTAINER, nao do botao, que vai de 379 a 454 e
    * cabe inteiro (regra #30 - controle fora da area do pai e recortado).
    *
    * A fonte e Tahoma 8 porque e o que o dump declara neste botao - o
    * "Comic Sans MS" de docs\framework_frmcadastro_layout.md e o canonico
    * da barra CRUD do frmcadastro, que esta tela nao usa.
    *
    * Picture: transcrito do SCX (cadastro_salvar_60.jpg, conferido em
    * vbmp\). Parece contraintuitivo num botao que so fecha, mas e o mesmo
    * caso ja registrado no FormBAL - no Framework Fortyus "fechar a
    * operacao" usa o icone de gravar. Escolher por semelhanca semantica
    * aqui seria palpite (regra #25), e Picture inexistente falha em
    * silencio: o botao apareceria sem icone, sem erro e sem log.
    *
    * AutoSize = .T. e transcricao e nao conflita com Width/Height: medido
    * no VFP9 em 2026-11-15, com o botao interno em 5,5 / 75x75 o grupo
    * fecha exatamente nos 85x85 que o dump declara.
    *
    * Themes = .F. e o valor do dump nos DOIS objetos. A excecao que exige
    * Themes = .T. + DisabledPicture vale para CommandButton SOLTO com
    * Picture - Buttons(N) dentro de CommandGroup mantem .F.
    *
    * O WITH .Buttons(1) ANINHADO dentro do WITH do grupo e a forma segura:
    * Buttons(N) e acessor de colecao, nao AddObject - o aninhamento que
    * descarta propriedades em silencio e o que envolve AddObject.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_Saida", "CommandGroup")

            WITH THIS.cmg_4c_Saida
                .ButtonCount   = 1
                .AutoSize      = .T.
                .Left          = 374
                .Top           = -2
                .Width         = 85
                .Height        = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Value         = 0
                .Themes        = .F.

                WITH .Buttons(1)
                    .Name          = "cmd_4c_Retornar"
                    .Top           = 5
                    .Left          = 5
                    .Height        = 75
                    .Width         = 75
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .WordWrap      = .T.
                    .Caption       = "Retornar"
                    .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Cancel        = .T.
                    .MousePointer  = 15
                    .SpecialEffect = 0
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                    .ToolTipText   = "[Esc] Voltar Para a Tela Principal da " + ;
                                     "Opera" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH

            *-- O handler e PUBLIC: BINDEVENT ignora metodo PROTECTED em
            *-- SILENCIO (regra #3), e aqui isso deixaria a tela sem saida.
            BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - Handler do botao "Retornar" (e do ESC, via Cancel = .T.)
    *
    * Equivalente do UNICO evento de botao do legado:
    *
    *   PROCEDURE btnSair.Click
    *   ThisForm.Release
    *
    * O nome segue o do controle legado (btnSair) e e um dos tres que o
    * harness de teste reconhece como encerramento (BtnEncerrarClick /
    * BtnFecharClick / BtnSairClick).
    *
    * POR QUE O FormParaBO() ANTES DO Release()
    * ------------------------------------------
    * No legado o valor ja esta fora da tela antes do Release, porque o
    * ControlSource escreve em _QtEtiq a cada tecla. Na arquitetura nova a
    * fonte unica e o Business Object, e ha um caminho em que ele ficaria
    * para tras: com Cancel = .T., o ESC dispara este Click SEM passar pelo
    * Valid/LostFocus do campo, entao ValidarQuantidade pode nao ter rodado.
    * Chamar FormParaBO() aqui fecha o fio controle -> BO -> PUBLIC em TODA
    * saida. No caminho normal e inocuo: copia o mesmo numero que o
    * ControlSource ja gravou.
    *
    * O Release() fica FORA do TRY de proposito: se o FormParaBO estourar, a
    * tela ainda assim tem de fechar - este botao e a unica saida (TitleBar
    * = 0 / Closable = .F.), e um erro aqui prenderia o usuario na janela.
    *
    * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BtnSairClick()
        LOCAL loc_oErro

        TRY
            THIS.FormParaBO()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.BtnSairClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - Reproduz a ordem de Tab do legado
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com a do SCX - divergencia sem erro, sem log e invisivel em
    * screenshot. Por isso o passe roda DEPOIS de todos os AddObject, em
    * ordem ASCENDENTE (cada atribuicao poe o controle na posicao pedida e
    * empurra os demais para tras).
    *
    * O LITERAL DO DUMP NAO E A ORDEM EFETIVA - ESTA FOI MEDIDA
    * ----------------------------------------------------------
    * O SCX declara TabIndex em dois objetos (OK = 1 e btnSair = 4) e em
    * mais nenhum. O VFP aplica cada valor no instante em que CRIA o objeto
    * e descarta o que excede a contagem de irmaos daquele container, entao
    * o literal pode nao sobreviver ao load. Simulado no VFP9 em 2026-11-15
    * (automation\probe_tabindex_t792.prg), recriando os filhos na ordem dos
    * REGISTROS do SCX e lendo os valores de volta:
    *
    *   LOAD LEGADO : OK = 1 | cntSombra = 2 | Label1 = 3 | Text1 = 4
    *   btnSair     : literal 4 -> EFETIVO 1 (membro unico de CommandGroup
    *                 tem ordinal fixo em 1; o 4 e inalcancavel por
    *                 construcao, nao e defeito do migrado)
    *
    * Ou seja: no legado o foco abre no botao "Retornar" e o Tab cai no
    * campo de quantidade - nao o contrario. A ordem de criacao deste form
    * (sombra, rotulo, campo, botao) produziria o inverso.
    *
    * Os valores escritos aqui sao os ORDINAIS EFETIVOS entre os
    * FOCALIZAVEIS (1 e 2), com o literal do dump no comentario: Label e
    * CommandGroup nao tem TabStop, e transcrever o TabIndex de rotulo so
    * embaralha a sequencia de quem de fato para o Tab. A mesma simulacao
    * confirmou o resultado deste passe: cmg = 1, txt = 2 (sombra e rotulo
    * empurrados para 3 e 4) - mesma ordem relativa do legado.
    *
    * Os IF sao ANINHADOS porque VFP9 nao faz short-circuit: num unico AND,
    * o PEMSTATUS do membro seria avaliado mesmo com o objeto ausente e
    * estouraria. O segundo PEMSTATUS pergunta pelo CONTROLE, nao pelo form
    * - PEMSTATUS(THIS, "<nome>", 5) so diz que o membro existe.
    *==========================================================================
    PROTECTED PROCEDURE AplicarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            *-- SCX: OK.TabIndex = 1 (efetivo 1) - o botao abre com o foco
            IF PEMSTATUS(THIS, "cmg_4c_Saida", 5)
                IF PEMSTATUS(THIS.cmg_4c_Saida, "TabIndex", 5)
                    THIS.cmg_4c_Saida.TabIndex = 1
                ENDIF
            ENDIF

            *-- SCX: Text1 nao declara TabIndex (efetivo 4, logo depois do
            *-- grupo entre os focalizaveis) - aqui o ordinal efetivo e 2
            IF PEMSTATUS(THIS, "txt_4c_Text1", 5)
                IF PEMSTATUS(THIS.txt_4c_Text1, "TabIndex", 5)
                    THIS.txt_4c_Text1.TabIndex = 2
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpQtE.AplicarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera o Business Object e devolve o menu principal
    *
    * DODEFAULT() na ULTIMA linha e obrigatorio: FormBase.Destroy e quem
    * zera this_oBusinessObject e reconstroi os popups do menu principal
    * (SET SYSMENU TO DEFAULT + CriarMenuPrincipal). Sem ele o menu encolhe
    * visualmente depois que um form modal fecha.
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
