*==============================================================================
* FormSigOpChb.prg
* Form Operacional: Dialogo de Busca de Cheque (SIGOPCHB)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo modal flat (sem PageFrame), chamado por forms de
*       movimentacao de cheques (ParentForm) para localizar um cheque por
*       Banco/Agencia/Conta/Cheque/Vencimento/Valor/Controle/Protocolo/Arquivo
*       (inclusive leitura via leitor de codigo de barras) e devolver o
*       registro encontrado ao cursor local do chamador (CrSigChe)
* SCX Origem: SigOpChb.SCX
*
* Parametros Init: par_lLeCheque, par_cChqLido, par_lLeitor, par_oOldForm
*   par_lLeCheque - Thisform.LeCheque do legado: .T. enquanto o leitor de
*                   codigo de barras esta "capturando" teclas no GetBanco
*   par_cChqLido  - Thisform.ChqLido do legado: acumulador de caracteres
*                   lidos pelo leitor de codigo de barras
*   par_lLeitor   - Thisform.Leitor do legado: .T. quando o ultimo Valid do
*                   GetBanco decodificou com sucesso uma leitura do leitor
*   par_oOldForm  - Thisform.ParentForm do legado: form chamador, usado para
*                   SqlExecute/CursorQuery via ParentForm.PoDataMgr e para
*                   inserir o registro encontrado no cursor local CrSigChe
*                   do chamador
*
* FASE 4/8 (Grid + botoes CRUD da Page1): NAO APLICAVEL a este form. O dump
* do legado (SigOpChb_form_codigo_fonte.txt) nao tem PageFrame (raiz Class:
* form, sem BaseClass: pageframe), nao tem Grid/AddCursor/pColuna/Grade
* (nenhuma lista de registros) e os 9 campos de entrada (GetBanco/GetAgencia/
* GetConta/GetCheque/GetVencimento/GetValor/GetControle/GetProtocolo/
* GetArquivo, todos BaseClass: textbox) NAO sao ReadOnly - sao campos de
* digitacao, resolvidos pelo unico fluxo de busca do legado (Procura.Click).
* Nao ha "lista" para paginar (Page1) nem para CRUD (Incluir/Visualizar/
* Alterar/Excluir/Buscar): inventar PageFrame Lista/Dados com 6 botoes CRUD
* (ramo paginado) ou uma grade (ramo flat) aqui violaria o PILAR 1
* (fidelidade ao legado) e a regra "NUNCA inventar" - o dialogo inteiro cabe
* na estrutura flat da Fase 3. Grid/botoes CRUD ficam de fora deste form; os
* botoes reais (Procurar/Cancelar) entram nas fases 7/8. O gate da Fase 4
* (OrquestradorMigracao.ps1) reconhece este caso pelo ramo "layout captura":
* legado sem lista (teste estrito) + pelo menos um campo EDITAVEL + esqueleto
* da Fase 3 ja construido (InicializarForm + AddObject) - ja satisfeito pela
* estrutura criada na Fase 3 (ConfigurarCabecalho/ConfigurarGrupos), sem
* necessidade de alteracao nesta fase. Ver tambem FormSigMvVde.prg (mesma
* nota, mesmo ramo de gate).
*
* FASE 6/8 (campos restantes + lookups) - LOOKUPS: NAO HA NENHUM neste form.
* Varredura do dump (SigOpChb_form_codigo_fonte.txt) pelos padroes de lookup
* do legado Fortyus - fwBuscaExt / fwBuscaSel / fwBuscaInt / mAddColuna /
* sigacess( / Acesso<Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|
* Produto|Titulo>( - devolve ZERO ocorrencia: os nove criterios sao campos de
* DIGITACAO livre (numero de banco/agencia/conta/cheque, data, valor,
* controle, protocolo, arquivo), resolvidos pelo unico Procura.Click, que faz
* Seek no cursor local CrSigChe do chamador e, falhando, um Select em SigChe.
* Criar AbrirLookup*/AbrirBusca* aqui significaria INVENTAR tabela de lookup
* que o legado nunca consulta - proibido pelo PILAR 1 e pela regra "NUNCA
* inventar tabelas de lookup que nao existem no original" - e metodo vazio e
* proibido pela regra de completude. O que esta fase de fato entrega aqui:
* os 4 campos restantes (Valor/Controle/Protocolo/Arquivo), o ControlSource
* dos nove campos, os nove When() de exclusao mutua e os dois Valid do dump
* (GetBanco - leitor de codigo de barras; GetArquivo - reformatacao).
*
* FASE 8/8 (eventos auxiliares e consolidacao) - o que entra e o que NAO tem
* referente nesta tela.
*
* ENTREGUE nesta fase:
*   CarregarLista()    - executa a busca e popula cursor_4c_SigChe, o cursor
*                        de RESULTADO que o form chamador le (o CrSigChe do
*                        legado). PUBLIC: acionado por CmdProcuraClick e pelo
*                        harness TesteAutomatico.prg.
*   FormParaBO()       - le os nove criterios da tela para as propriedades de
*                        criterio do BO (os memvares _Proc* do legado).
*   BOParaForm()       - caminho inverso, fonte unica do sentido BO -> tela;
*                        usado por LimparCampos e pela decodificacao do
*                        leitor de codigo de barras.
*   LimparCampos()     - repoe os nove criterios no estado do Init legado.
*                        Os TRES acima sao PROTECTED: FormBase ja os declara
*                        assim e o VFP9 nao permite alargar o escopo na
*                        subclasse (regra #51).
*   BtnCancelarClick() - handler do btnCancela (Caption "Cancelar",
*                        Cancel = .T.), nome canonico da ACAO.
*
* SEM REFERENTE no legado (nao sao criados: inventa-los violaria o PILAR 1 e
* a regra "NUNCA inventar", e declara-los vazios violaria a regra de
* completude):
*   BtnSalvarClick / BtnConfirmarClick - o dump NAO tem botao de gravar. Os
*       dois unicos CommandButton sao "Procura" (Picture
*       cadastro_procurar_60.jpg) e "btnCancela" (cadastro_cancelar_60.jpg);
*       nao existe Insert/Update/Delete contra tabela nenhuma - a unica
*       escrita do legado tem como alvo o CURSOR local CrSigChe. O botao de
*       acao desta tela e "Procurar", entregue em CmdProcuraClick().
*   BtnBuscarClick     - "Buscar" e o botao de filtro da pagina Lista do
*       frmcadastro. Esta tela INTEIRA e a busca; o verbo do legado e
*       "Procurar" e o handler leva esse nome.
*   BtnEncerrarClick   - nao ha botao "Encerrar"/"Sair" no dump; quem fecha e
*       o proprio Cancelar (Cancel = .T. responde ao ESC, como no legado).
*   HabilitarCampos    - os nove campos sao SEMPRE editaveis. A restricao que
*       o legado aplica e de FOCO, pelos nove When() (exclusao mutua entre os
*       grupos de criterio), ja transcritos em ValidarFocoCampo() - nenhum
*       Get* do dump declara ReadOnly ou Enabled = .F. Alternar .Enabled
*       acinzentaria campos que o legado mantem normais (PILAR 1).
*   AjustarBotoesPorModo / AlternarPagina - nao ha modo INCLUIR/ALTERAR/
*       VISUALIZAR/EXCLUIR nem PageFrame: o dump e um form flat (Class: form,
*       sem BaseClass: pageframe) sem pcEscolha, sem Grupo_Op e sem frmcadastro,
*       e os dois botoes estao sempre habilitados.
*==============================================================================

*==============================================================================
* TextBoxBuscaCheque - TextBox com When() proprio, usado pelos 9 campos de
* criterio de busca (Banco/Agencia/Conta/Cheque/Vencimento/Valor/Controle/
* Protocolo/Arquivo). AddObject() com a classe nativa "TextBox" NAO aceita
* codigo customizado (so propriedades), e e exatamente o When() de cada
* Get* do SCX legado que implementa a exclusao mutua entre os grupos de
* criterio (preencher Controle/Protocolo bloqueia os demais campos, etc).
* Por isso o When() mora nesta subclasse - ela so guarda o NOME do grupo
* (this_cGrupoWhen) e delega para FormSigOpChb.ValidarFocoCampo(), onde os
* 9 bodies de When do dump estao transcritos literalmente.
*==============================================================================
DEFINE CLASS TextBoxBuscaCheque AS TextBox

    this_cGrupoWhen = ""

    FUNCTION When()
        IF VARTYPE(THISFORM) = "O" AND PEMSTATUS(THISFORM, "ValidarFocoCampo", 5)
            RETURN THISFORM.ValidarFocoCampo(THIS.this_cGrupoWhen)
        ENDIF
        RETURN .T.
    ENDFUNC

ENDDEFINE

DEFINE CLASS FormSigOpChb AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    Width        = 500
    Height       = 250
    AutoCenter   = .T.
    Caption      = "Procurar"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Propriedades customizadas do legado (RESERVED3: chqlido/lecheque/leitor/ordenar/parentform)
    this_lLeCheque   = .F.    && Thisform.LeCheque - leitor de codigo de barras "capturando"
    this_cChqLido    = ""     && Thisform.ChqLido - acumulador de teclas do leitor
    this_lLeitor     = .F.    && Thisform.Leitor - .T. apos decodificar leitura do leitor
    this_cOrdenar    = ""     && Thisform.Ordenar - propriedade customizada do legado (nao referenciada no codigo extraido)
    this_oParentForm = .NULL. && Thisform.ParentForm - form chamador (PoDataMgr + CrSigChe)

    *-- Criterios de busca. No legado cada Get* tem ControlSource apontando
    *-- para um memvar _Proc* criado pelo Store do Init (SIGOPCHB.Init:576-584)
    *-- e o Procura.Click LE EXCLUSIVAMENTE esses memvares (_ProcVen/_ProcVal/
    *-- _ProcBco/_ProcAge/_ProcCon/_ProcChe/_ProcControle/_ProcProtocolo/
    *-- _ProcArquivo) para montar a chave do Seek e o Where do SqlExecute.
    *-- Aqui os memvares viram propriedades do form (PILAR 3) e os TextBox
    *-- continuam ligados por ControlSource = "ThisForm.<prop>", preservando
    *-- a semantica do legado: digitar no campo atualiza a propriedade, e a
    *-- busca le a propriedade. O TIPO de cada uma reproduz o Store legado.
    this_cProcBco       = ""   && _ProcBco       - Space(03)
    this_cProcAge       = ""   && _ProcAge       - Space(04)
    this_cProcCon       = ""   && _ProcCon       - Space(10)
    this_cProcChe       = ""   && _ProcChe       - Space(06)
    this_dProcVen       = {}   && _ProcVen       - { / / }
    this_nProcVal       = 0    && _ProcVal       - 0
    this_cProcControle  = ""   && _ProcControle  - Space(08)
    this_cProcProtocolo = ""   && _ProcProtocolo - Space(08)
    this_cProcArquivo   = ""   && _ProcArquivo   - Space(06)

    *==================================================================
    * Init - Armazena parametros antes de DODEFAULT (que chama InicializarForm)
    *==================================================================
    PROCEDURE Init(par_lLeCheque, par_cChqLido, par_lLeitor, par_oOldForm)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_lLeCheque = IIF(VARTYPE(par_lLeCheque) = "L", par_lLeCheque, .F.)
        THIS.this_cChqLido  = IIF(VARTYPE(par_cChqLido) = "C", par_cChqLido, "")
        THIS.this_lLeitor   = IIF(VARTYPE(par_lLeitor) = "L", par_lLeitor, .F.)
        IF VARTYPE(par_oOldForm) = "O"
            THIS.this_oParentForm = par_oOldForm
        ENDIF

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura visual
    * basica do dialogo (cabecalho + grupos). Campos, botoes e eventos sao
    * adicionados nas fases seguintes.
    *==================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpChbBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigOpChbBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigOpChb.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarGrupos()
                THIS.InicializarCriteriosBusca()
                THIS.ConfigurarCamposBusca1()
                THIS.ConfigurarCamposBusca2()
                THIS.AplicarValoresIniciaisBusca()
                THIS.ConfigurarEventosBusca()
                THIS.ConfigurarBotoesAcao()

                *-- Equivalente ao ThisForm.GetBanco.SetFocus no fim do Init
                *-- legado. Guardado por gb_4c_ValidandoUI - SetFocus exige
                *-- form visivel e a validacao de UI instancia sem Show().
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.txt_4c_Banco.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpChb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * ConfigurarCabecalho - Container cinza escuro com o titulo do dialogo
    * (equivalente ao cntSombra/lblSombra/lblTitulo do SCX legado)
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Procurar"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 21
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Procurar"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = THIS.Width - 21
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarGrupos - Shapes de agrupamento visual dos criterios de
    * busca (equivalente a Shape1/Shape2 do SCX legado)
    *==================================================================
    PROTECTED PROCEDURE ConfigurarGrupos()
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 4
            .Left        = 321
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .FillStyle   = 1
            .BackColor   = RGB(192, 192, 192)
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 100
            .Left        = 102
            .Height      = 133
            .Width       = 295
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .BackColor   = RGB(192, 192, 192)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarCamposBusca1 - PRIMEIRA METADE dos campos de busca
    * (5 dos 9 campos do legado, na ordem de TabIndex do SCX):
    *   GetBanco / GetAgencia / GetConta / GetCheque  -> grupo da esquerda,
    *       dentro de shp_4c_Shape1 (criterio Banco+Agencia+Conta+Cheque)
    *   GetVencimento                                 -> grupo da direita,
    *       dentro de shp_4c_Shape2 (criterio Vencimento+Valor)
    * Os 4 campos restantes (GetValor/GetControle/GetProtocolo/GetArquivo)
    * entram na Fase 6, junto com os Valid/When e o Procura.Click.
    *
    * Labels e TextBoxes vao direto em THIS (dialogo flat, sem PageFrame/
    * Page2 - ver nota da FASE 4 no cabecalho do arquivo). Top/Left/Width/
    * Height transcritos de layout.json / do dump do SCX, SEM compensacao
    * +29 (nao ha PageFrame oculto neste form).
    *
    * InputMask/ForeColor/TabIndex transcritos LITERALMENTE do dump
    * (SIGOPCHB.Get*): "999"/"9999"/"9999999999"/"999999" restringem a
    * digitacao a digitos, exatamente como o legado - os quatro criterios
    * sao numeros de banco/agencia/conta/cheque. O GetVencimento declara
    * InputMask = "" (override VAZIO do Form Designer) e por isso NAO
    * recebe InputMask aqui.
    *
    * .Value reproduz o tipo que o Init do legado atribui a cada campo
    * (ThisForm.Get*.Value = ...) e o memvar do ControlSource:
    *   _ProcBco = Space(03) / _ProcAge = Space(04) / _ProcCon = Space(10)
    *   _ProcChe = Space(06) / _ProcVen = { / / }  (DATE)
    * MaxLength vem do tamanho desses mesmos memvares - nao ha coluna de
    * banco associada a estes campos de criterio de busca.
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCamposBusca1()

        *-- Banco (Say "Banco :" + GetBanco, TabIndex 1/2 do legado)
        THIS.AddObject("lbl_4c_Banco", "Label")
        WITH THIS.lbl_4c_Banco
            .Top       = 110
            .Left      = 127
            .Width     = 38
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Banco :"
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Banco", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Banco
            .Top           = 107
            .Left          = 167
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .InputMask     = "999"
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 2
            .ControlSource  = "ThisForm.this_cProcBco"
            .this_cGrupoWhen = "BANCO"
            .Visible       = .T.
        ENDWITH

        *-- Agencia (Say "Agencia :" + GetAgencia, TabIndex 3/4 do legado)
        THIS.AddObject("lbl_4c_Agencia", "Label")
        WITH THIS.lbl_4c_Agencia
            .Top       = 134
            .Left      = 118
            .Width     = 47
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ag" + CHR(234) + "ncia :"
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Agencia", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Agencia
            .Top           = 131
            .Left          = 167
            .Width         = 40
            .Height        = 23
            .Value         = ""
            .InputMask     = "9999"
            .MaxLength     = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 4
            .ControlSource  = "ThisForm.this_cProcAge"
            .this_cGrupoWhen = "AGENCIA"
            .Visible       = .T.
        ENDWITH

        *-- Conta (Say "Conta :" + GetConta, TabIndex 5/6 do legado)
        THIS.AddObject("lbl_4c_Conta", "Label")
        WITH THIS.lbl_4c_Conta
            .Top       = 158
            .Left      = 127
            .Width     = 38
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Conta
            .Top           = 155
            .Left          = 167
            .Width         = 81
            .Height        = 23
            .Value         = ""
            .InputMask     = "9999999999"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 6
            .ControlSource  = "ThisForm.this_cProcCon"
            .this_cGrupoWhen = "CONTA"
            .Visible       = .T.
        ENDWITH

        *-- Cheque (Say "Cheque :" + GetCheque, TabIndex 7/8 do legado)
        THIS.AddObject("lbl_4c_Cheque", "Label")
        WITH THIS.lbl_4c_Cheque
            .Top       = 182
            .Left      = 119
            .Width     = 46
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cheque :"
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Cheque", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Cheque
            .Top           = 179
            .Left          = 167
            .Width         = 52
            .Height        = 23
            .Value         = ""
            .InputMask     = "999999"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 8
            .ControlSource  = "ThisForm.this_cProcChe"
            .this_cGrupoWhen = "CHEQUE"
            .Visible       = .T.
        ENDWITH

        *-- Vencimento (Say3 "Vencimento :" + GetVencimento, TabIndex 9/10
        *-- do legado). Campo DATE: o Init do legado faz
        *-- ThisForm.GetVencimento.Value = { / / } e o memvar do
        *-- ControlSource e' _ProcVen = { / / }. Sem InputMask (o dump
        *-- declara InputMask = "", override vazio) e sem MaxLength
        *-- (nao se aplica a campo de data).
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 110
            .Left      = 243
            .Width     = 64
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vencimento :"
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Vencimento", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Vencimento
            .Top           = 107
            .Left          = 309
            .Width         = 81
            .Height        = 23
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 10
            .ControlSource  = "ThisForm.this_dProcVen"
            .this_cGrupoWhen = "VENCIMENTO"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarCamposBusca2 - SEGUNDA METADE dos campos de busca (os 4
    * restantes, na ordem de TabIndex do SCX): GetValor (grupo da direita,
    * continuacao de shp_4c_Shape2) / GetControle / GetProtocolo /
    * GetArquivo (abaixo de shp_4c_Shape1/shp_4c_Shape2, soltos no form,
    * exatamente como no dump - Left=309 continua a coluna da direita).
    *
    * .Value reproduz o estado final que o Init do legado deixa em cada
    * campo (a ultima atribuicao ThisForm.Get*.Value = ... sobrescreve o
    * Store nos memvars _Proc*): GetValor.Value=0, GetControle.Value=''
    * (char sem MaxLength no dump), GetProtocolo.Value='' (idem),
    * GetArquivo.Value=Space(6) com MaxLength=6 (unico desta leva com
    * MaxLength/InputMask declarados no dump).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCamposBusca2()

        *-- Valor (Say4 "Valor :" + GetValor, TabIndex 11/12 do legado)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 134
            .Left      = 274
            .Width     = 33
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor :"
            .TabIndex  = 11
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Valor", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Valor
            .Top           = 131
            .Left          = 309
            .Width         = 81
            .Height        = 23
            .Value         = 0
            .InputMask     = "999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 12
            .ControlSource  = "ThisForm.this_nProcVal"
            .this_cGrupoWhen = "VALOR"
            .Visible       = .T.
        ENDWITH

        *-- Controle (Say1 "Controle :" + GetControle, TabIndex 13/14)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 158
            .Left      = 257
            .Width     = 50
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Controle :"
            .TabIndex  = 13
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Controle", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Controle
            .Top           = 155
            .Left          = 309
            .Width         = 66
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 14
            .ControlSource  = "ThisForm.this_cProcControle"
            .this_cGrupoWhen = "CONTROLE"
            .Visible       = .T.
        ENDWITH

        *-- Protocolo (Say2 "Protocolo :" + GetProtocolo, TabIndex 15/16)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 182
            .Left      = 253
            .Width     = 54
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Protocolo :"
            .TabIndex  = 15
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Protocolo", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Protocolo
            .Top           = 179
            .Left          = 309
            .Width         = 67
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 16
            .ControlSource  = "ThisForm.this_cProcProtocolo"
            .this_cGrupoWhen = "PROTOCOLO"
            .Visible       = .T.
        ENDWITH

        *-- Arquivo (Say5 "Arquivo :" + GetArquivo, TabIndex 17/18)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 208
            .Left      = 261
            .Width     = 46
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Arquivo :"
            .TabIndex  = 17
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Arquivo", "TextBoxBuscaCheque")
        WITH THIS.txt_4c_Arquivo
            .Top           = 203
            .Left          = 309
            .Width         = 52
            .Height        = 23
            .Value         = SPACE(6)
            .InputMask     = "999999"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 18
            .ControlSource  = "ThisForm.this_cProcArquivo"
            .this_cGrupoWhen = "ARQUIVO"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * InicializarCriteriosBusca - Transcricao literal do bloco Store do
    * Init legado (SIGOPCHB.Init:576-584), que CRIA os memvares ligados
    * por ControlSource aos nove Get*. Aqui eles sao propriedades do
    * form, entao o Store vira atribuicao - os TAMANHOS e os TIPOS sao
    * os do legado, nao estimativa:
    *
    *   Store Space(03) To _ProcBco        Store Space(04) To _ProcAge
    *   Store Space(10) To _ProcCon        Store Space(06) To _ProcChe
    *   Store { / / }   To _ProcVen        Store 0         To _ProcVal
    *   Store Space(08) To _ProcControle   Store Space(08) To _ProcProtocolo
    *   Store Space(6)  To _ProcArquivo
    *
    * Roda ANTES de ConfigurarCamposBusca1/2 porque o ControlSource de
    * cada TextBox exige a propriedade ja existente e com o tipo certo.
    *==================================================================
    PROTECTED PROCEDURE InicializarCriteriosBusca()
        THIS.this_cProcBco       = SPACE(3)
        THIS.this_cProcAge       = SPACE(4)
        THIS.this_cProcCon       = SPACE(10)
        THIS.this_cProcChe       = SPACE(6)
        THIS.this_dProcVen       = {}
        THIS.this_nProcVal       = 0
        THIS.this_cProcControle  = SPACE(8)
        THIS.this_cProcProtocolo = SPACE(8)
        THIS.this_cProcArquivo   = SPACE(6)
    ENDPROC

    *==================================================================
    * AplicarValoresIniciaisBusca - Transcricao literal das NOVE ultimas
    * atribuicoes do Init legado (SIGOPCHB.Init:586-594), que rodam
    * DEPOIS do Store e sobrescrevem os memvares atraves do
    * ControlSource de cada campo:
    *
    *   ThisForm.GetBanco.Value      = ''   GetAgencia.Value   = ''
    *   ThisForm.GetConta.Value      = ''   GetCheque.Value    = ''
    *   ThisForm.GetVencimento.Value = { / / }
    *   ThisForm.GetValor.Value      = 0    GetControle.Value  = ''
    *   ThisForm.GetProtocolo.Value  = ''   GetArquivo.Value   = Space(6)
    *
    * A ORDEM importa e e a do legado: Store primeiro, campos depois -
    * por isso Banco/Agencia/Conta/Cheque/Controle/Protocolo terminam
    * VAZIOS (e nao com o Space(N) do Store) e so Arquivo fica com
    * Space(6). Reproduzir so o Store deixaria o estado inicial errado.
    *
    * O corpo mora em LimparCampos() porque o estado inicial do legado E o
    * estado "limpo" desta tela sao o MESMO estado, e existe um segundo
    * caminho que precisa dele: o legado criava um form NOVO a cada
    * abertura (btnCancela/Procura terminam em ThisForm.Release), enquanto
    * aqui o dialogo fecha com Hide() e pode ser reaberto pelo mesmo
    * chamador (ver FecharDialogo) - sem repor o estado do Init, a segunda
    * abertura herdaria os criterios digitados na primeira. Manter os nove
    * literais em DOIS lugares deixaria os dois caminhos divergirem.
    *==================================================================
    PROTECTED PROCEDURE AplicarValoresIniciaisBusca()
        THIS.LimparCampos()
    ENDPROC

    *==================================================================
    * LimparCampos - Repoe os NOVE criterios de busca no estado inicial do
    * Init legado (ver AplicarValoresIniciaisBusca acima para a ordem
    * Store -> campos que define esses valores). A transferencia para a
    * tela passa pelo BO (THIS.BOParaForm), que e a fonte unica do
    * caminho BO -> campos - por isso os valores sao escritos nas
    * propriedades de criterio do BO e nao direto nos nove .Value.
    *
    * PROTECTED porque FormBase declara os tres hooks (LimparCampos/
    * FormParaBO/BOParaForm) como PROTECTED e o VFP9 nao permite alargar
    * o escopo numa subclasse - medido no probe da fase. So ha chamadas de
    * DENTRO da classe (AplicarValoresIniciaisBusca e FecharDialogo).
    *==================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_cBanco      = ""
            loc_oBO.this_cAgencia    = ""
            loc_oBO.this_cConta      = ""
            loc_oBO.this_cCheque     = ""
            loc_oBO.this_dVencimento = {}
            loc_oBO.this_nValor      = 0
            loc_oBO.this_cControle   = ""
            loc_oBO.this_cProtocolo  = ""
            loc_oBO.this_cArquivo    = SPACE(6)
        ENDIF

        THIS.BOParaForm()
    ENDPROC

    *==================================================================
    * FormParaBO - Transfere os NOVE criterios digitados na tela para as
    * propriedades de criterio do BO (this_cBanco/this_cAgencia/
    * this_cConta/this_cCheque/this_dVencimento/this_nValor/
    * this_cControle/this_cProtocolo/this_cArquivo). No legado esse papel
    * era dos memvares _Proc* ligados por ControlSource, lidos
    * diretamente pelo Procura.Click; aqui a leitura da tela acontece
    * UMA vez, neste metodo, e a busca (CarregarLista) le exclusivamente
    * o BO - assim nao ha duas fontes para o mesmo criterio.
    *
    * Vencimento passa por ConverterParaData porque o .Value do TextBox
    * nasce DATE (atribuido {} no LimparCampos) e um registro carregado
    * do SQL Server chega DATETIME - TTOD() nao aceita DATE (regra #16).
    * Valor confere o VARTYPE antes de atribuir: TextBox com InputMask
    * numerica pode devolver Caractere se algo escrever texto nele, e
    * this_nValor alimenta FormatarNumeroSQL no BO.
    *==================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
                "o foi poss" + CHR(237) + "vel ler os crit" + CHR(233) + "rios da tela.", ;
                "FormSigOpChb.FormParaBO")
        ELSE
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_cBanco      = THIS.txt_4c_Banco.Value
            loc_oBO.this_cAgencia    = THIS.txt_4c_Agencia.Value
            loc_oBO.this_cConta      = THIS.txt_4c_Conta.Value
            loc_oBO.this_cCheque     = THIS.txt_4c_Cheque.Value
            loc_oBO.this_dVencimento = ConverterParaData(THIS.txt_4c_Vencimento.Value)
            loc_oBO.this_nValor      = IIF(VARTYPE(THIS.txt_4c_Valor.Value) = "N", ;
                                           THIS.txt_4c_Valor.Value, ;
                                           VAL(TRANSFORM(THIS.txt_4c_Valor.Value)))
            loc_oBO.this_cControle   = THIS.txt_4c_Controle.Value
            loc_oBO.this_cProtocolo  = THIS.txt_4c_Protocolo.Value
            loc_oBO.this_cArquivo    = THIS.txt_4c_Arquivo.Value

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==================================================================
    * BOParaForm - Caminho inverso de FormParaBO: pinta os NOVE campos da
    * tela a partir das propriedades de criterio do BO. Fonte unica do
    * sentido BO -> tela, usada por LimparCampos (repor o estado do Init)
    * e por ValidarBancoLeitura (os quatro campos decodificados pelo
    * leitor de codigo de barras).
    *
    * O BO ja expoe CarregarDoCursor(<alias de SigChe>), que preenche
    * essas mesmas nove propriedades a partir de um registro localizado -
    * com este metodo o chamador consegue reabrir o dialogo com os
    * criterios de um cheque ja encontrado.
    *==================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
                "o foi poss" + CHR(237) + "vel exibir os crit" + CHR(233) + "rios na tela.", ;
                "FormSigOpChb.BOParaForm")
        ELSE
            loc_oBO = THIS.this_oBusinessObject

            THIS.txt_4c_Banco.Value      = loc_oBO.this_cBanco
            THIS.txt_4c_Agencia.Value    = loc_oBO.this_cAgencia
            THIS.txt_4c_Conta.Value      = loc_oBO.this_cConta
            THIS.txt_4c_Cheque.Value     = loc_oBO.this_cCheque
            THIS.txt_4c_Vencimento.Value = ConverterParaData(loc_oBO.this_dVencimento)
            THIS.txt_4c_Valor.Value      = IIF(VARTYPE(loc_oBO.this_nValor) = "N", ;
                                               loc_oBO.this_nValor, 0)
            THIS.txt_4c_Controle.Value   = loc_oBO.this_cControle
            THIS.txt_4c_Protocolo.Value  = loc_oBO.this_cProtocolo
            THIS.txt_4c_Arquivo.Value    = loc_oBO.this_cArquivo

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==================================================================
    * ConfigurarEventosBusca - BINDEVENTs dos criterios de busca.
    *
    * GetBanco.KeyPress/Valid do legado implementam a leitura via leitor
    * de codigo de barras (nKeyCode=60 inicia a captura, nKeyCode=58
    * decodifica). BINDEVENT "Valid" nao dispara de forma confiavel em
    * TextBox (regra do projeto) - por isso a logica do Valid legado vira
    * o metodo THIS.ValidarBancoLeitura(), chamado DIRETO pelo KeyPress
    * (This.Valid do legado), nao via BINDEVENT "Valid".
    *
    * GetArquivo.Valid (Trans(Val(...))) e reformatacao pura de texto -
    * sem SQL/CarregarDados, por isso pode ir em "LostFocus" sem risco de
    * recursao (regra do projeto so veda LostFocus para metodos pesados).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarEventosBusca()
        BINDEVENT(THIS.txt_4c_Banco, "KeyPress", THIS, "BancoKeyPress")
        BINDEVENT(THIS.txt_4c_Arquivo, "LostFocus", THIS, "ValidarArquivo")
    ENDPROC

    *==================================================================
    * ConfigurarBotoesAcao - Botoes reais do dialogo (Procura/Cancela),
    * geometria/Picture/Cancel transcritos do dump:
    *   Procura    - Top=3, Left=350, Picture=cadastro_procurar_60.jpg
    *   btnCancela - Top=3, Left=425, Picture=cadastro_cancelar_60.jpg,
    *                Cancel=.T.
    * O SCX legado NAO declara Width/Height (herdados da classe fwbtng) -
    * usado o canonico 75x75 dos botoes standalone do framework novo
    * (mesmo padrao de FormSigOpBcb.ConfigurarBotoes: Themes=.T. +
    * DisabledPicture repetindo o Picture, exigido em standalone
    * CommandButton com icone - regra do projeto). 350+75=425 e 425+75=500
    * fecham exatamente na largura do form (Width=500), sem sobra.
    *==================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_Procura", "CommandButton")
        WITH THIS.cmd_4c_Procura
            .Top             = 3
            .Left            = 350
            .Width           = 75
            .Height          = 75
            .TabIndex        = 19
            .Caption         = "Procurar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnCancela", "CommandButton")
        WITH THIS.cmd_4c_BtnCancela
            .Top             = 3
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .TabIndex        = 20
            .Cancel          = .T.
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT exige que o metodo alvo ja exista em THIS no momento
        *-- do bind - a classe inteira (incluindo CmdProcuraClick/
        *-- BtnCancelarClick, declarados mais abaixo neste arquivo) ja
        *-- esta compilada quando InicializarForm roda.
        BINDEVENT(THIS.cmd_4c_Procura,    "Click", THIS, "CmdProcuraClick")
        BINDEVENT(THIS.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==================================================================
    * CmdProcuraClick - Transcricao do Procura.Click legado, que faz
    * exatamente duas coisas: busca e fecha. A busca inteira (ordem de
    * prioridade do Do Case, consulta e insercao no cursor de resultado)
    * mora em THIS.CarregarLista(); o fechamento em THIS.FecharDialogo()
    * (Hide, nao Release - ver comentario do metodo) em vez do
    * "ThisForm.Release" literal do legado.
    *
    * A busca fica em metodo proprio porque ha um SEGUNDO caminho que
    * dispara a mesma acao no legado: o GetBanco.Valid chama
    * "ThisForm.Procura.Click" depois de decodificar o leitor de codigo
    * de barras (ver ValidarBancoLeitura).
    *==================================================================
    PROCEDURE CmdProcuraClick()
        THIS.CarregarLista()
        THIS.FecharDialogo()
    ENDPROC

    *==================================================================
    * CarregarLista - Executa a busca e popula o cursor de RESULTADO
    * (cursor_4c_SigChe), que e a lista que este dialogo entrega ao
    * chamador. No legado essa lista e o cursor CrSigChe do form PAI,
    * alimentado pelo proprio Procura.Click:
    *
    *   lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(
    *                [Select * From SigChe Where ]+lcWher,'CrCheque')
    *   If lnErro > 0
    *       Select CrCheque
    *       Scan
    *           Scatter to Memvar Memo
    *           Insert Into CrSigChe From Array Memvar
    *       EndScan
    *   Endif
    *
    * Nao ha Grid nesta tela (o dump do legado nao tem BaseClass: grid
    * nem AddCursor/pColuna/RecordSource) - a "lista" e o conjunto de
    * registros de SigChe, e quem a exibe e a grade do form chamador,
    * que le cursor_4c_SigChe depois que o dialogo fecha (ver
    * FecharDialogo, que usa Hide() justamente para o cursor sobreviver).
    *
    * Divergencias deliberadas em relacao ao literal do legado, as duas
    * documentadas no proprio BO (SigOpChbBO.BuscarCheque):
    *   - o SELECT roda pela conexao do sistema novo (gnConnHandle,
    *     dentro do BO) e nao por ParentForm.podatamgr.SqlExecute;
    *   - a insercao descarta duplicata pela PK (Nums) no lugar do Seek
    *     local que o legado fazia em CrSigChe antes de ir ao banco - o
    *     conjunto final de cheques na lista e o mesmo.
    *
    * Retorna .T. quando a busca pode ser executada (inclusive com ZERO
    * linhas - criterio sem nenhum cheque e resposta valida, nao erro) e
    * .F. so quando o SQL falhou ou a leitura da tela nao foi possivel.
    *==================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_nResultado, loc_cNums, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.FormParaBO()
                *-- FormParaBO ja exibiu o motivo
            ELSE
                *-- Fecha o cursor temporario de uma busca anterior ANTES do
                *-- SQLEXEC do BO. O guard pelo Buffering e obrigatorio:
                *-- TABLEREVERT sobre cursor sem buffering dispara erro 1586
                *-- (regra #52), e USE IN fecha o alias mesmo com buffer sujo.
                IF USED("cursor_4c_SigCheTmp")
                    IF CURSORGETPROP("Buffering", "cursor_4c_SigCheTmp") > 1
                        TABLEREVERT(.T., "cursor_4c_SigCheTmp")
                    ENDIF
                    USE IN cursor_4c_SigCheTmp
                ENDIF

                loc_oBO = THIS.this_oBusinessObject

                loc_nResultado = loc_oBO.BuscarCheque( ;
                    ALLTRIM(loc_oBO.this_cBanco), ALLTRIM(loc_oBO.this_cAgencia), ;
                    ALLTRIM(loc_oBO.this_cConta), ALLTRIM(loc_oBO.this_cCheque), ;
                    loc_oBO.this_dVencimento, loc_oBO.this_nValor, ;
                    ALLTRIM(loc_oBO.this_cControle), ALLTRIM(loc_oBO.this_cProtocolo), ;
                    ALLTRIM(loc_oBO.this_cArquivo), "cursor_4c_SigCheTmp")

                IF loc_nResultado < 0
                    *-- BuscarCheque ja exibiu a mensagem do SQL Server
                    loc_lSucesso = .F.
                ELSE
                    IF loc_nResultado > 0 AND USED("cursor_4c_SigCheTmp")
                        IF !USED("cursor_4c_SigChe")
                            SELECT * FROM cursor_4c_SigCheTmp ;
                                INTO CURSOR cursor_4c_SigChe READWRITE
                        ELSE
                            SELECT cursor_4c_SigCheTmp
                            SCAN
                                loc_cNums = Nums
                                SELECT cursor_4c_SigChe
                                LOCATE FOR Nums = loc_cNums
                                IF !FOUND()
                                    SELECT cursor_4c_SigCheTmp
                                    SCATTER MEMVAR MEMO
                                    INSERT INTO cursor_4c_SigChe FROM MEMVAR
                                ENDIF
                                SELECT cursor_4c_SigCheTmp
                            ENDSCAN
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_SigChe")
                        SELECT cursor_4c_SigChe
                        GO TOP
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_SigCheTmp")
                    USE IN cursor_4c_SigCheTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpChb.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * BtnCancelarClick - Transcricao do btnCancela.Click legado
    * (ThisForm.Release). Ver FecharDialogo().
    *
    * O objeto legado chama-se "btnCancela" e tem Caption "Cancelar" e
    * Cancel = .T. - o handler leva o nome canonico da ACAO
    * (BtnCancelarClick), nao o nome do objeto legado. PUBLIC porque e
    * acionado por BINDEVENT (regra #3) e chamado de fora pelo harness
    * TesteAutomatico.prg.
    *==================================================================
    PROCEDURE BtnCancelarClick()
        THIS.FecharDialogo()
    ENDPROC

    *==================================================================
    * FecharDialogo - Fecha a tela SEM destruir o objeto (Hide, nao
    * Release). THIS.Release() mata a referencia que o chamador guarda
    * (VARTYPE vira "X") antes de ele conseguir ler cursor_4c_SigChe (os
    * cheques encontrados) - o resultado ficaria inalcancavel para quem
    * abriu com CREATEOBJECT + Show() (regra do projeto, mesmo padrao do
    * FormBuscaAuxiliar). O CHAMADOR eh responsavel por ler o cursor e
    * so depois chamar Release() no dialogo.
    *
    * Repoe os criterios no estado do Init (THIS.LimparCampos) porque o
    * legado terminava em ThisForm.Release e a abertura seguinte SEMPRE
    * construia um form novo, com os nove campos no estado do Init. Como
    * aqui a instancia sobrevive ao fechamento, sem este reset a segunda
    * abertura comecaria com os criterios digitados na primeira - e o
    * When() de exclusao mutua bloquearia o foco dos campos "errados".
    * O cursor de RESULTADO (cursor_4c_SigChe) nao e tocado: e justamente
    * o que o chamador vem ler depois do Hide.
    *==================================================================
    PROCEDURE FecharDialogo()
        THIS.Hide()
        THIS.LimparCampos()
    ENDPROC

    *==================================================================
    * ValidarFocoCampo - Reproduz, campo a campo, os NOVE When() do dump
    * do legado (GetBanco/GetAgencia/GetConta/GetCheque/GetVencimento/
    * GetValor/GetControle/GetProtocolo/GetArquivo). Chamado pelo When()
    * de TextBoxBuscaCheque (THISFORM.ValidarFocoCampo) - por isso e
    * metodo PUBLIC (quem chama e outra classe, nao THIS).
    *
    * Os grupos NAO sao simetricos - transcritos literalmente do dump,
    * inclusive a inconsistencia do legado em GetArquivo.When (que inclui
    * IsEmpty(ThisForm.GetArquivo.Value) checando a si mesmo).
    *==================================================================
    FUNCTION ValidarFocoCampo(par_cCampo)
        LOCAL loc_lPermite
        loc_lPermite = .T.

        *-- O When() dispara ao receber foco e os nove bodies do legado
        *-- leem o .Value dos OUTROS campos. Enquanto ConfigurarCamposBusca1/2
        *-- ainda nao terminaram, parte deles nao existe - e erro dentro de
        *-- When() derruba o Init do form. Sem os nove controles, nao ha
        *-- exclusao mutua a aplicar: libera o foco (comportamento do legado,
        *-- cujo form ja nasce com todos os Get* instanciados pelo SCX).
        IF !(PEMSTATUS(THIS, "txt_4c_Banco", 5)      AND PEMSTATUS(THIS, "txt_4c_Agencia", 5) AND ;
             PEMSTATUS(THIS, "txt_4c_Conta", 5)      AND PEMSTATUS(THIS, "txt_4c_Cheque", 5) AND ;
             PEMSTATUS(THIS, "txt_4c_Vencimento", 5) AND PEMSTATUS(THIS, "txt_4c_Valor", 5) AND ;
             PEMSTATUS(THIS, "txt_4c_Controle", 5)   AND PEMSTATUS(THIS, "txt_4c_Protocolo", 5) AND ;
             PEMSTATUS(THIS, "txt_4c_Arquivo", 5))
            RETURN .T.
        ENDIF

        DO CASE
        CASE par_cCampo = "BANCO"
            loc_lPermite = EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Protocolo.Value)

        CASE INLIST(par_cCampo, "AGENCIA", "CONTA", "CHEQUE")
            loc_lPermite = EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)

        CASE par_cCampo = "VENCIMENTO"
            loc_lPermite = EMPTY(THIS.txt_4c_Valor.Value) AND ;
                           EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)

        CASE par_cCampo = "VALOR"
            loc_lPermite = EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
                           EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)

        CASE par_cCampo = "CONTROLE"
            loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
                           EMPTY(THIS.txt_4c_Agencia.Value) AND ;
                           EMPTY(THIS.txt_4c_Conta.Value) AND ;
                           EMPTY(THIS.txt_4c_Cheque.Value) AND ;
                           EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
                           EMPTY(THIS.txt_4c_Valor.Value) AND ;
                           EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)

        CASE par_cCampo = "PROTOCOLO"
            loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
                           EMPTY(THIS.txt_4c_Agencia.Value) AND ;
                           EMPTY(THIS.txt_4c_Conta.Value) AND ;
                           EMPTY(THIS.txt_4c_Cheque.Value) AND ;
                           EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
                           EMPTY(THIS.txt_4c_Valor.Value) AND ;
                           EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)

        CASE par_cCampo = "ARQUIVO"
            loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
                           EMPTY(THIS.txt_4c_Agencia.Value) AND ;
                           EMPTY(THIS.txt_4c_Conta.Value) AND ;
                           EMPTY(THIS.txt_4c_Cheque.Value) AND ;
                           EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
                           EMPTY(THIS.txt_4c_Valor.Value) AND ;
                           EMPTY(THIS.txt_4c_Controle.Value) AND ;
                           EMPTY(THIS.txt_4c_Arquivo.Value)
        ENDCASE

        RETURN loc_lPermite
    ENDFUNC

    *==================================================================
    * BancoKeyPress - Transcricao literal do GetBanco.KeyPress legado:
    * captura caracteres do leitor de codigo de barras (inicia em
    * nKeyCode=60, decodifica em nKeyCode=58 chamando ValidarBancoLeitura
    * no lugar de This.Valid - BINDEVENT "Valid" nao e confiavel em
    * TextBox). Precisa ser PUBLIC (chamado via BINDEVENT - regra #3).
    *==================================================================
    PROCEDURE BancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 60
            IF !THIS.this_lLeCheque
                THIS.this_cChqLido = ""
            ENDIF
            THIS.this_lLeCheque = .T.
        ENDIF

        IF THIS.this_lLeCheque
            THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
            NODEFAULT
        ENDIF

        IF par_nKeyCode = 58
            THIS.ValidarBancoLeitura()
            THIS.this_lLeCheque = .F.
        ENDIF
    ENDPROC

    *==================================================================
    * ValidarBancoLeitura - Transcricao literal do GetBanco.Valid legado:
    * decodifica o buffer acumulado pelo leitor (33+ caracteres) e
    * distribui Banco/Agencia/Conta/Cheque, disparando a busca - o
    * "ThisForm.Procura.Click" do legado, aqui THIS.CmdProcuraClick().
    *==================================================================
    PROTECTED PROCEDURE ValidarBancoLeitura()
        LOCAL loc_cLeitor, loc_oBO
        loc_cLeitor = IIF(THIS.this_lLeCheque, THIS.this_cChqLido, "")

        THIS.this_lLeitor = .F.

        IF LASTKEY() = 9
            KEYBOARD "{CTRL+TAB}"
        ELSE
            IF LEN(loc_cLeitor) >= 33
                THIS.this_lLeitor = .T.

                *-- Os QUATRO campos decodificados (mesmas posicoes e
                *-- tamanhos do Substr legado) entram pelo BO, que e a fonte
                *-- unica do caminho BO -> tela. O FormParaBO antes do
                *-- recorte preserva os outros CINCO criterios: BOParaForm
                *-- repinta os nove, e sem o snapshot os cinco nao-tocados
                *-- seriam sobrescritos pelo que estivesse no BO.
                IF THIS.FormParaBO()
                    loc_oBO = THIS.this_oBusinessObject
                    loc_oBO.this_cBanco   = SUBSTR(loc_cLeitor, 2, 3)
                    loc_oBO.this_cAgencia = SUBSTR(loc_cLeitor, 5, 4)
                    loc_oBO.this_cConta   = SUBSTR(loc_cLeitor, 23, 10)
                    loc_oBO.this_cCheque  = SUBSTR(loc_cLeitor, 14, 6)
                    THIS.BOParaForm()

                    *-- "ThisForm.Procura.Click" do legado. Chamada direta ao
                    *-- handler, nao ao .Click do botao: o Click so existe
                    *-- como delegate via BINDEVENT, e o PEMSTATUS que
                    *-- cercaria o botao devolve .T. pelo NOME sem garantir
                    *-- que o bind aconteceu (regra #3/#34).
                    THIS.CmdProcuraClick()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==================================================================
    * ValidarArquivo - Transcricao literal do GetArquivo.Valid legado
    * (This.Value = Trans(Val(This.Value),'@L 999999')). Formatacao pura
    * de texto, sem SQL/CarregarDados - seguro em "LostFocus" (regra do
    * projeto so veda LostFocus para metodos pesados/recursivos). Precisa
    * ser PUBLIC (chamado via BINDEVENT - regra #3).
    *==================================================================
    PROCEDURE ValidarArquivo()
        THIS.txt_4c_Arquivo.Value = TRANSFORM(VAL(THIS.txt_4c_Arquivo.Value), "@L 999999")
    ENDPROC

    *==================================================================
    * Destroy - Libera a referencia ao form chamador e fecha o cursor
    * local de busca (cursor_4c_SigChe, populado por CarregarLista) se
    * ainda estiver aberto. So executa quando o CHAMADOR libera este
    * dialogo (apos ler o cursor) - ver FecharDialogo().
    *==================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigChe")
            USE IN cursor_4c_SigChe
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
