*==============================================================================
* FormSIGOPCFE.prg - Pesquisa de Saldos por Funcionario
* Origem: SIGOPCFE.SCX (task686)
* Herda de: FormBase
* Tipo: OPERACIONAL (form de consulta/processamento, SEM tabela propria)
*       Layout FLAT (sem PageFrame Page1/Page2) - filtros (Material/Grupo/Conta),
*       grade de resultado (Funcionario/Nome/Fase/Saldo/Ultimo Balanco) e botoes
*       de acao (Processar/Video/Impressora/Encerrar) direto no form, igual ao
*       SCX legado. Aberto direto pelo menu (popMovimentos), sem form pai.
*
* Fase 3/8 - Estrutura base: cabecalho + orquestrador de montagem visual.
* Fase 4/8 - Grade de resultado (grd_4c_Dados) + botoes de acao
*            (Processar/Video/Impressora/Encerrar), equivalentes aos CRUD
*            dos forms CRUD (este form OPERACIONAL nao tem Incluir/Alterar/
*            Excluir/Buscar - sao os 4 botoes reais do SIGOPCFE.SCX).
* Fase 5/8 - Filtros, parte 1: Material (txt_4c_Mat/txt_4c_DMat) + lookup
*            em SigCdPro + FormParaBO (sincroniza a tela com o BO).
* Fase 6/8 - Filtros, parte 2: Grupo (txt_4c_Grupo/txt_4c__Dgrupo) com
*            lookup via fAcessoContab(), Conta (txt_4c_Conta/txt_4c_Dconta)
*            com lookup via cursor_4c_Cli/FormBuscaAuxiliar, as opcoes
*            Chk_Saldo/chkFalha e o container cnt_4c_Mensagem ("Aguarde...").
* Fase 7/8 - Eventos principais: CmdProcessaClick/CmdVisualizarClick/
*            CmdImprimirClick ligados a logica REAL no BO
*            (SIGOPCFEBO.ProcessarSaldos/ExibirRelatorio) - apuracao
*            completa do saldo (SigCdPro/SigCdCli/SigMvEst/SigCdNec/
*            SigMvCab/SigCdPsc/SigOpCfe, transcricao literal do
*            Processa.Click legado) e emissao do SigOpCfe.frx (copiado do
*            legado para projeto\app\reports\).
* Fase 8/8 - Eventos auxiliares e consolidacao final:
*            - AjustarOrdemTabulacao(): os 17 TabIndex declarados no SCX
*              (ordem de tabulacao eh comportamento visivel - PILAR 1).
*            - HabilitarCampos(par_lHabilitar): fonte UNICA do .Enabled dos
*              filtros, reproduzindo os PROCEDURE When do legado (o When de
*              Get_DMat so libera a busca por descricao enquanto o codigo
*              do material esta vazio).
*            - AjustarBotoesPorModo(): fonte UNICA de grd_4c_Dados.Visible e
*              de cmd_4c_Visualizar/cmd_4c_Imprimir.Enabled, antes espalhada
*              entre ValidarMatExec e CmdProcessaClick - e que por isso nao
*              desligava os botoes no caminho "Nenhum Saldo Selecionado!!!".
*            - FormParaBO (agora PUBLIC) / BOParaForm / LimparCampos: par de
*              transferencia tela<->BO e estado inicial consolidado.
*            - Imprimir(): FormParaBO antes de emitir, porque o legado monta
*              o subtitulo do FRX lendo Get_Mat/Get_DMat da TELA.
*
* NAO existem BtnSalvarClick/BtnCancelarClick/BtnBuscarClick/CarregarLista
* neste form: o SIGOPCFE.SCX nao tem Page1(Lista)/Page2(Dados), nem modo
* INCLUIR/ALTERAR/EXCLUIR, nem botao de gravar/cancelar/buscar - os botoes
* REAIS do legado sao quatro (Processa/Visualizar/Imprimir/Saida) e todos
* tem handler (CmdProcessaClick/CmdVisualizarClick/CmdImprimirClick/
* CmdSaidaClick). Criar aqueles nomes exigiria inventar superficie que o
* legado nao tem (viola o PILAR 1) ou escrever metodo vazio (proibido pela
* regra de completude). A carga da grade vive em CarregarDados().
*==============================================================================

DEFINE CLASS FormSIGOPCFE AS FormBase

    *-- Propriedades visuais (dump SIGOPCFE.SCX: Width=800, Height=600, Tahoma 8)
    Height       = 600
    Width        = 800
    Caption      = "Pesquisa de Saldos por Funcion" + CHR(225) + "rio"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    TitleBar     = 0
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia dos lookups de filtro (regra #37/#47 -
    *-- FormBuscaAuxiliar eh MODAL e tira o foco do TextBox, o que
    *-- redispara o proprio LostFocus; e guarda de valor-ja-validado,
    *-- para nao reabrir o picker quando o valor nao mudou)
    this_lEmLookup              = .F.
    this_cUltimoMatValidado     = ""
    this_cUltimoDMatValidado    = ""
    this_cUltimoGrupoValidado   = ""
    this_cUltimoDGrupoValidado  = ""
    this_cUltimoContaValidado   = ""
    this_cUltimoDContaValidado  = ""

    *-- Estado do resultado apurado, consumido por AjustarBotoesPorModo()
    *-- (fonte UNICA do estado de grd_4c_Dados/cmd_4c_Visualizar/
    *-- cmd_4c_Imprimir). Nasce .T. porque o SCX legado NAO declara
    *-- Grade.Visible nem Visualizar/Imprimir.Enabled - isto eh, a tela abre
    *-- com a grade visivel e os dois botoes habilitados; o legado so os
    *-- derruba no Valid de Get_Mat (material trocado invalida o resultado) e
    *-- os reacende no fim do Processa.Click.
    this_lResultadoValido       = .T.

    *==========================================================================
    * Init - ShowWindow=1/WindowType=1 ficam fixos na declaracao da classe
    * (padrao estavel de 143 dos 149 forms de forms\operacionais\ - ver
    * feedback_propriedade_readonly_em_runtime na memoria): nenhuma atribuicao
    * em runtime a WindowType/ShowWindow. O TestFormWrapper.prg ja baixa
    * WindowType para 0 por conta propria antes do Show() em modo teste; o
    * padrao anterior (classe com ShowWindow=0/WindowType=0 + restauracao
    * condicional aqui) cria a janela top-level JA no CREATEOBJECT quando o
    * CorretorAutomatico duplica a declaracao de ShowWindow (ultima linha
    * vence), e a tentativa de baixar WindowType depois estoura "Property
    * WINDOWTYPE is read-only." - o TIMEOUT que esse padrao tentava evitar
    * ja foi medido como inexistente (ShowWindow=1 na classe + Show() sob
    * vfp9.exe -T funciona normalmente).
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCFEBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Estrutura visual base (Fase 3) via orquestrador
                THIS.ConfigurarPageFrame()

                *-- Sincronizar caption nos labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Cursores de referencia (SigCdPam/Pac/OpOpt/Ope/Opd/Gcr/Pro/Cli/Gccr)
                *-- Pulados em validacao de UI (sem conexao SQL - Problema 4 FORMCOR_LICOES)
                *-- cnt_4c_Mensagem replica o "Aguarde! Preparando arquivos."
                *-- do Init() legado (CntMensagem.Visible = .t. ... .Refresh
                *-- ... CarregarCursoresReferencia ... CntMensagem.Visible = .f.)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde! Preparando arquivos."
                    THIS.cnt_4c_Mensagem.Visible = .T.
                    THIS.Refresh()
                    THIS.this_oBusinessObject.CarregarCursoresReferencia()
                    THIS.cnt_4c_Mensagem.Visible = .F.
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial consolidado (Fase 8/8): LimparCampos()
                *-- zera os filtros, o BO e a grade de resultado, e fecha
                *-- chamando HabilitarCampos()/AjustarBotoesPorModo(). Roda
                *-- DEPOIS de TornarControlesVisiveis porque aquele forca
                *-- Visible = .T. em tudo e sobrescreveria o estado da grade.
                THIS.LimparCampos()

                *-- NUNCA atribuir THIS.Visible = .T. aqui (dentro de Init/
                *-- InicializarForm, logo durante o proprio CREATEOBJECT):
                *-- isso realiza a janela ANTES do caller (menu.prg/
                *-- TestFormWrapper) rodar o proprio Show(), e com a janela
                *-- ja realizada o WindowType vira READ-ONLY - estourando
                *-- "Property WINDOWTYPE is read-only." no primeiro caller
                *-- que tenta normalizar o modo antes de Show() (regra
                *-- "propriedade_readonly_em_runtime" - mesma classe de erro
                *-- do comentario acima sobre WindowType/ShowWindow). Visible
                *-- fica por conta EXCLUSIVA do .Show() externo.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SIGOPCFEBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual
    * SIGOPCFE.SCX e Form PLANO sem PageFrame (cntSombra + filtros + grade +
    * botoes direto no form). Mantido o nome "ConfigurarPageFrame" so para
    * preservar o papel arquitetural de ponto de entrada da montagem visual
    * (mesmo padrao de FormFop/FormDCC), delegando para helpers dedicados.
    * Fase 3: cabecalho. Fase 4: grade de resultado + botoes de acao.
    * Fase 5: filtros, parte 1 - Material (txt_4c_Mat/txt_4c_DMat) + Shape1.
    * Fase 6: filtros, parte 2 - Grupo/Conta/checkboxes/cnt_4c_Mensagem
    * (ConfigurarFiltros() completo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()

        *-- Ordem de tabulacao (Fase 8/8): depende de TODOS os controles ja
        *-- criados, por isso fecha a montagem visual.
        THIS.AjustarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - Transcreve os TabIndex declarados no SCX
    * legado (PILAR 1: a ordem de tabulacao eh comportamento visivel). O
    * dump declara 17 indices nos filhos diretos da Form, nesta ordem:
    *
    *    1 Get_grupo    -> txt_4c_Grupo          10 Say1        -> lbl_4c_Label1
    *    2 get_Dgrupo   -> txt_4c__Dgrupo        11 cntMensagem -> cnt_4c_Mensagem
    *    3 Get_conta    -> txt_4c_Conta          12 Grade       -> grd_4c_Dados
    *    4 Get_dconta   -> txt_4c_Dconta         13 Visualizar  -> cmd_4c_Visualizar
    *    5 Get_Mat      -> txt_4c_Mat            14 Imprimir    -> cmd_4c_Imprimir
    *    6 Get_DMat     -> txt_4c_DMat           15 Saida       -> cmd_4c_Saida
    *    7 Chk_Saldo    -> chk_4c_Chk_Saldo      16 Say2        -> lbl_4c_Label2
    *    8 chkFalha     -> chk_4c_ChkFalha       17 Say5        -> lbl_4c_Label5
    *    9 Processa     -> cmd_4c_Processa
    *
    * Atribuidos em ordem CRESCENTE de proposito: em VFP9 atribuir TabIndex
    * reposiciona o controle na sequencia e DESLOCA os irmaos, entao so
    * percorrendo 1..N na ordem desejada o resultado final eh o pretendido.
    *
    * shp_4c_Shape1 fica de fora porque a classe base Shape NAO tem TabIndex
    * (conferido em automation\propriedades_baseclasses.txt - regra #33:
    * atribuir propriedade inexistente derruba o Init e a tela nao abre), e
    * cnt_4c_Sombra tambem - o cntSombra do legado nao declara TabIndex.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Grupo.TabIndex      = 1
            THIS.txt_4c__Dgrupo.TabIndex    = 2
            THIS.txt_4c_Conta.TabIndex      = 3
            THIS.txt_4c_Dconta.TabIndex     = 4
            THIS.txt_4c_Mat.TabIndex        = 5
            THIS.txt_4c_DMat.TabIndex       = 6
            THIS.chk_4c_Chk_Saldo.TabIndex  = 7
            THIS.chk_4c_ChkFalha.TabIndex   = 8
            THIS.cmd_4c_Processa.TabIndex   = 9
            THIS.lbl_4c_Label1.TabIndex     = 10
            THIS.cnt_4c_Mensagem.TabIndex   = 11
            THIS.grd_4c_Dados.TabIndex      = 12
            THIS.cmd_4c_Visualizar.TabIndex = 13
            THIS.cmd_4c_Imprimir.TabIndex   = 14
            THIS.cmd_4c_Saida.TabIndex      = 15
            THIS.lbl_4c_Label2.TabIndex     = 16
            THIS.lbl_4c_Label5.TabIndex     = 17
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AjustarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Cria os filtros de pesquisa do SIGOPCFE.SCX.
    * Fase 5/8 (parte 1 de 2): Shape1 (decorativo) + Material (Get_Mat/
    * Get_DMat -> txt_4c_Mat/txt_4c_DMat).
    * Fase 6/8 (parte 2 de 2): Grupo (Get_grupo/get_Dgrupo -> txt_4c_Grupo/
    * txt_4c__Dgrupo), Conta (Get_conta/Get_dconta -> txt_4c_Conta/
    * txt_4c_Dconta), os CheckBoxes (Chk_Saldo/chkFalha) e o cnt_4c_Mensagem
    * (equivalente ao CntMensagem do legado - nasce oculto, Fase 7/8 exibe
    * durante o processamento).
    * Posicoes/propriedades EXATAS do dump (SIGOPCFE.SCX):
    *   Shape1     Top=7/Left=563/Width=229/Height=110, BorderColor=136,189,188
    *   Say1       "Material : " Top=183/Left=126/Width=58
    *   Get_Mat    Top=180/Left=186/Width=108/MaxLength=14  (SigCdPro.CPros)
    *   Get_DMat   Top=180/Left=295/Width=303/MaxLength=40  (SigCdPro.DPros)
    *   Say5       "Grupo : "  Top=123/Left=146 (classe say pura - regra #23)
    *   Get_grupo  Top=119/Left=186/Width=80   (SigCdGcr.Codigos)
    *   get_Dgrupo Top=119/Left=268/Width=302/MaxLength=40 (SigCdGcr.Descrs)
    *   Say2       "Conta :"   Top=150/Left=146
    *   Get_conta  Top=146/Left=186/Width=80   (SigCdCli.IClis)
    *   Get_dconta Top=146/Left=268/Width=302  (SigCdCli.RClis)
    *   Chk_Saldo  "Nao Mostrar Saldos Zerados" Top=207/Left=188/W=153/H=15
    *   chkFalha   "Nao checar falha" Top=207/Left=385/W=99/H=15
    *   cntMensagem Top=268/Left=151/W=497/H=63 (Visible=.F. - exibido so
    *               durante o processamento, Fase 7/8)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 563
                .Width       = 229
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Material : "
                .Left      = 126
                .Top       = 183
                .Width     = 58
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Mat", "TextBox")
            WITH THIS.txt_4c_Mat
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 186
                .Top           = 180
                .Width         = 108
                .MaxLength     = 14
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Mat, "LostFocus", THIS, "ValidarMat")

            THIS.AddObject("txt_4c_DMat", "TextBox")
            WITH THIS.txt_4c_DMat
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 295
                .Top           = 180
                .Width         = 303
                .MaxLength     = 40
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_DMat, "LostFocus", THIS, "ValidarDMat")

            *-- Grupo (Get_grupo/get_Dgrupo -> SigCdGcr.Codigos/Descrs)
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo :"
                .Left      = 146
                .Top       = 123
                .Width     = 45
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Grupo", "TextBox")
            WITH THIS.txt_4c_Grupo
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 186
                .Top               = 119
                .Width             = 80
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")

            THIS.AddObject("txt_4c__Dgrupo", "TextBox")
            WITH THIS.txt_4c__Dgrupo
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 268
                .Top               = 119
                .Width             = 302
                .MaxLength         = 40
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c__Dgrupo, "LostFocus", THIS, "ValidarDGrupo")

            *-- Conta/Funcionario (Get_conta/Get_dconta -> SigCdCli.IClis/RClis)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta :"
                .Left      = 146
                .Top       = 150
                .Width     = 40
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Conta", "TextBox")
            WITH THIS.txt_4c_Conta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 186
                .Top               = 146
                .Width             = 80
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Conta, "LostFocus", THIS, "ValidarConta")

            THIS.AddObject("txt_4c_Dconta", "TextBox")
            WITH THIS.txt_4c_Dconta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 268
                .Top               = 146
                .Width             = 302
                .MaxLength         = 50
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Dconta, "LostFocus", THIS, "ValidarDConta")

            *-- Opcoes de processamento (Chk_Saldo/chkFalha). AutoSize=.T. no
            *-- SCX eh NO-OP em CheckBox criado por AddObject (regra #23/
            *-- "autosize_noop_em_checkbox") - usar AutoSize=.F. + Width/
            *-- Height EXATOS do dump (ja calculados pelo Form Designer).
            THIS.AddObject("chk_4c_Chk_Saldo", "CheckBox")
            WITH THIS.chk_4c_Chk_Saldo
                .Top       = 207
                .Left      = 188
                .Width     = 153
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = CHR(78) + CHR(227) + "o Mostrar Saldos Zerados"
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("chk_4c_ChkFalha", "CheckBox")
            WITH THIS.chk_4c_ChkFalha
                .Top         = 207
                .Left        = 385
                .Width       = 99
                .Height      = 15
                .FontName    = "Tahoma"
                .FontSize    = 8
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = CHR(78) + CHR(227) + "o checar falha"
                .ToolTipText = CHR(78) + CHR(227) + "o calcula e  n" + CHR(227) + "o subtrai a falha do saldo final"
                .ForeColor   = RGB(90, 90, 90)
                .Themes      = .F.
                .Value       = 0
                .Visible     = .T.
            ENDWITH

            *-- cntMensagem - nasce OCULTO (so aparece durante o
            *-- processamento, "Aguarde..." - Fase 7/8 completa o uso em
            *-- Processar). TornarControlesVisiveis() tem excecao explicita
            *-- para CNT_4C_MENSAGEM (nao forca Visible=.T. no container,
            *-- so nos filhos dele).
            THIS.AddObject("cnt_4c_Mensagem", "Container")
            WITH THIS.cnt_4c_Mensagem
                .Top           = 268
                .Left          = 151
                .Width         = 497
                .Height        = 63
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_Mensagem.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Mensagem.lbl_4c_Label1
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 14
                .Alignment  = 2
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = "Processando Movimenta" + CHR(231) + CHR(245) + "es..."
                .Height     = 25
                .Left       = 82
                .Top        = 19
                .Width      = 295
                .ForeColor  = RGB(255, 0, 0)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarMat - BINDEVENT de LostFocus em txt_4c_Mat (legado: PROCEDURE
    * Valid de Get_Mat). PUBLIC (alvo de BINDEVENT - regra #3).
    *==========================================================================
    PROCEDURE ValidarMat()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarMatExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarMatExec - Replica PROCEDURE Valid de Get_Mat: campo vazio limpa
    * Mat/DMat; campo preenchido abre o lookup (AbrirBuscaMat) e invalida o
    * resultado anterior (ThisForm.Grade.Visible=.f. / Visualizar.Enabled=.f.
    * / Imprimir.Enabled=.f. no legado - aqui grd_4c_Dados/cmd_4c_Visualizar/
    * cmd_4c_Imprimir, criados na Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE ValidarMatExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Mat.Value)

        IF loc_cValor == THIS.this_cUltimoMatValidado
            RETURN
        ENDIF
        THIS.this_cUltimoMatValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Mat.Value  = ""
            THIS.txt_4c_DMat.Value = ""
            THIS.txt_4c_Mat.Refresh()
            THIS.txt_4c_DMat.Refresh()
        ELSE
            THIS.AbrirBuscaMat()

            *-- Material trocado invalida o resultado apurado (legado:
            *-- Grade.Visible/Visualizar.Enabled/Imprimir.Enabled = .f.),
            *-- agora pelo funil unico AjustarBotoesPorModo (Fase 8/8).
            THIS.this_lResultadoValido = .F.
            THIS.AjustarBotoesPorModo()
        ENDIF

        *-- When de Get_DMat depende de Get_Mat estar vazio: reavaliar em
        *-- AMBOS os ramos (regra #40 - reabilitar no funil de volta).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * AbrirBuscaMat - Lookup de Material em SigCdPro (CPros/DPros), padrao
    * canonico FormBuscaAuxiliar (regra #37): Init ja tenta match exato; so
    * mostra o picker quando nao encontra sozinho.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMat()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_Mat.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdPro", ;
            "cursor_4c_BuscaMat", ;
            "CPros", ;
            loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
                    THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                    THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
                        THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                        THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                        THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    ELSE
                        THIS.txt_4c_Mat.Value  = ""
                        THIS.txt_4c_DMat.Value = ""
                        THIS.this_cUltimoMatValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMat")
            USE IN cursor_4c_BuscaMat
        ENDIF

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDMat - BINDEVENT de LostFocus em txt_4c_DMat (legado: PROCEDURE
    * Valid de Get_DMat). PUBLIC (alvo de BINDEVENT - regra #3).
    *==========================================================================
    PROCEDURE ValidarDMat()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDMatExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarDMatExec - Replica PROCEDURE Valid de Get_DMat: busca reversa
    * por descricao. Ao contrario de Get_Mat, o legado NAO toca
    * Grade.Visible/Visualizar.Enabled/Imprimir.Enabled aqui.
    *==========================================================================
    PROTECTED PROCEDURE ValidarDMatExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_DMat.Value)

        IF loc_cValor == THIS.this_cUltimoDMatValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDMatValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Mat.Value  = ""
            THIS.txt_4c_DMat.Value = ""
            THIS.txt_4c_Mat.Refresh()
            THIS.txt_4c_DMat.Refresh()
        ELSE
            THIS.AbrirBuscaDMat()
        ENDIF

        *-- A busca reversa PREENCHE txt_4c_Mat, e o When de Get_DMat passa a
        *-- recusar o campo (legado: Return Empty(ThisForm.Get_Mat.Value)) -
        *-- por isso o funil tambem roda aqui (Fase 8/8).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * AbrirBuscaDMat - Lookup reverso de Material em SigCdPro por DPros.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaDMat()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_DMat.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdPro", ;
            "cursor_4c_BuscaMat", ;
            "DPros", ;
            loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
                    THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                    THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
                        THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                        THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                        THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    ELSE
                        THIS.txt_4c_Mat.Value  = ""
                        THIS.txt_4c_DMat.Value = ""
                        THIS.this_cUltimoMatValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMat")
            USE IN cursor_4c_BuscaMat
        ENDIF

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarGrupo / ValidarDGrupo - BINDEVENT de LostFocus em txt_4c_Grupo/
    * txt_4c__Dgrupo (legado: PROCEDURE Valid de Get_grupo/get_Dgrupo).
    * PUBLIC (alvo de BINDEVENT - regra #3).
    * Delegam para fAcessoContab() (utils\functions.prg), que faz sozinho o
    * lookup (SEEK em SigCdGcr + browse fwBuscaSimples quando necessario),
    * a checagem de acesso do usuario ao grupo contabil E preenche os DOIS
    * TextBox (pCod/pDsc) - padrao canonico do projeto (ver
    * Formsigrepes.prg ValidarGrpEstoque/ValidarDsGrpEstoque).
    *==========================================================================
    PROCEDURE ValidarGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF loc_cValor == THIS.this_cUltimoGrupoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c__Dgrupo.Value = ""
            THIS.txt_4c__Dgrupo.Refresh()
        ELSE
            =fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
        ENDIF

        THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
    ENDPROC

    PROCEDURE ValidarDGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDGrupoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarDGrupoExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c__Dgrupo.Value)

        IF loc_cValor == THIS.this_cUltimoDGrupoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Grupo.Value = ""
            THIS.txt_4c_Grupo.Refresh()
        ELSE
            =fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
        ENDIF

        THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
    ENDPROC

    *==========================================================================
    * ValidarConta / ValidarDConta - BINDEVENT de LostFocus em txt_4c_Conta/
    * txt_4c_Dconta (legado: PROCEDURE Valid de Get_conta/Get_dconta).
    * PUBLIC (alvo de BINDEVENT - regra #3).
    * NAO usa fAcessoContas() aqui (regra de memoria "facessocontas_lookup_
    * ux" - a funcao auto-popula com o 1o match parcial sem selecao
    * explicita do usuario). Em vez disso: SEEK no cursor_4c_Cli (ja
    * carregado por CarregarCursoresReferencia, filtrado GerBals = 1, igual
    * ao TmpCli do legado) e, sem match exato, abre o picker canonico.
    *==========================================================================
    PROCEDURE ValidarConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarContaExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)

        IF loc_cValor == THIS.this_cUltimoContaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Dconta.Value = ""
            THIS.txt_4c_Dconta.Refresh()
        ELSE
            IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalCodigo")
                THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
                THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
            ELSE
                THIS.AbrirBuscaConta("IClis", loc_cValor)
            ENDIF
            THIS.txt_4c_Conta.Refresh()
            THIS.txt_4c_Dconta.Refresh()
        ENDIF

        THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
    ENDPROC

    PROCEDURE ValidarDConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDContaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarDContaExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Dconta.Value)

        IF loc_cValor == THIS.this_cUltimoDContaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Conta.Value = ""
            THIS.txt_4c_Conta.Refresh()
        ELSE
            IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalNome")
                THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
                THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
            ELSE
                THIS.AbrirBuscaConta("RClis", loc_cValor)
            ENDIF
            THIS.txt_4c_Conta.Refresh()
            THIS.txt_4c_Dconta.Refresh()
        ENDIF

        THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Lookup de Conta/Funcionario em SigCdCli (IClis/
    * RClis), filtrado a GerBals = 1 (mesmo filtro de cursor_4c_Cli/TmpCli -
    * so contas habilitadas para balanco). par_cCampo indica o campo de
    * busca inicial ("IClis" ou "RClis" - chamado por ValidarConta/
    * ValidarDConta respectivamente).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaConta(par_cCampo, par_cValor)
        LOCAL loc_oBusca
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_BuscaConta", ;
            par_cCampo, ;
            par_cValor, ;
            "Cadastro de Contas", ;
            .F., ;
            .F., ;
            "GerBals = 1")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
                    ELSE
                        THIS.txt_4c_Conta.Value  = ""
                        THIS.txt_4c_Dconta.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_Conta.Value  = ""
                    THIS.txt_4c_Dconta.Value = ""
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia os filtros digitados na tela para o Business
    * Object: Material (txt_4c_Mat/txt_4c_DMat), Grupo (txt_4c_Grupo/
    * txt_4c__Dgrupo), Conta (txt_4c_Conta/txt_4c_Dconta) e as opcoes de
    * processamento (chk_4c_Chk_Saldo/chk_4c_ChkFalha - CheckBox.Value eh
    * NUMERICO, regra #36: comparar com = 1, nunca atribuir direto a
    * property LOGICAL do BO).
    *==========================================================================
    *-- PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
    *-- FormParaBO, e em VFP9 a subclasse NAO alarga escopo herdado - escrever
    *-- "PROCEDURE FormParaBO" sem o modificador nao torna o metodo publico,
    *-- so esconde que ele continua protegido (medido: chamada de fora estoura
    *-- "Property FORMPARABO is not found", e PEMSTATUS(...,5) devolve .T.
    *-- porque so responde "existe?", nao "da para chamar daqui?").
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cMaterial     = ALLTRIM(THIS.txt_4c_Mat.Value)
        THIS.this_oBusinessObject.this_cDescMaterial = ALLTRIM(THIS.txt_4c_DMat.Value)
        THIS.this_oBusinessObject.this_cGrupo        = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cDescGrupo    = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
        THIS.this_oBusinessObject.this_cConta        = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDescConta    = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_lNaoMostrarSaldosZerados = (THIS.chk_4c_Chk_Saldo.Value = 1)
        THIS.this_oBusinessObject.this_lNaoChecarFalha          = (THIS.chk_4c_ChkFalha.Value = 1)
    ENDPROC

    *==========================================================================
    * BOParaForm - Reciproco de FormParaBO (Fase 8/8): espelha os filtros e as
    * opcoes do Business Object de volta nos controles da tela. Usado por
    * LimparCampos(), depois de THIS.this_oBusinessObject.LimparDados() - o BO
    * eh a fonte do estado zerado e a tela passa a refleti-lo, em vez de cada
    * metodo repetir a lista de valores iniciais.
    *
    * CheckBox.Value eh NUMERICO (regra #36/CLAUDE.md): converter o LOGICAL do
    * BO com IIF(..., 1, 0), nunca atribuir o logico direto.
    *
    * PROTECTED obrigatorio, pelo mesmo motivo de FormParaBO: FormBase.prg
    * declara PROTECTED PROCEDURE BOParaForm e o escopo herdado nao se alarga.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.txt_4c_Mat.Value       = loc_oBO.this_cMaterial
        THIS.txt_4c_DMat.Value      = loc_oBO.this_cDescMaterial
        THIS.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
        THIS.txt_4c__Dgrupo.Value   = loc_oBO.this_cDescGrupo
        THIS.txt_4c_Conta.Value     = loc_oBO.this_cConta
        THIS.txt_4c_Dconta.Value    = loc_oBO.this_cDescConta

        THIS.chk_4c_Chk_Saldo.Value = IIF(loc_oBO.this_lNaoMostrarSaldosZerados, 1, 0)
        THIS.chk_4c_ChkFalha.Value  = IIF(loc_oBO.this_lNaoChecarFalha, 1, 0)

        *-- Guardas de "valor ja validado" acompanham a tela: sem isto o
        *-- proximo LostFocus compararia o valor novo com o antigo e pularia
        *-- o lookup (regra #37).
        THIS.this_cUltimoMatValidado    = ALLTRIM(loc_oBO.this_cMaterial)
        THIS.this_cUltimoDMatValidado   = ALLTRIM(loc_oBO.this_cDescMaterial)
        THIS.this_cUltimoGrupoValidado  = ALLTRIM(loc_oBO.this_cGrupo)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(loc_oBO.this_cDescGrupo)
        THIS.this_cUltimoContaValidado  = ALLTRIM(loc_oBO.this_cConta)
        THIS.this_cUltimoDContaValidado = ALLTRIM(loc_oBO.this_cDescConta)

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c__Dgrupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Fonte UNICA do .Enabled dos campos de filtro
    * (Fase 8/8). Reproduz os PROCEDURE When do SCX legado, que sao o que
    * decide se o campo aceita entrada:
    *
    *   Get_DMat.When   -> Return Empty(ThisForm.Get_Mat.Value)
    *   Get_grupo.When  -> Return .t.
    *   Get_conta.When  -> Return .t.
    *   Get_dconta.When -> Return .y.   (.Y. eh .T. em VFP9)
    *   get_Dgrupo.When -> Return .y.
    *   Get_Mat / Chk_Saldo / chkFalha  -> sem When (sempre acessiveis)
    *
    * Ou seja: a busca reversa por descricao de material (txt_4c_DMat) so
    * esta disponivel enquanto o codigo (txt_4c_Mat) esta vazio - exatamente
    * como no legado, onde o When de Get_DMat recusa o foco depois que o
    * codigo foi preenchido. Por isso este metodo tem de ser chamado em TODO
    * caminho que altera txt_4c_Mat (os validadores e os lookups), nao so na
    * inicializacao (regra #40: quem desabilita tem de reabilitar no funil).
    *
    * par_lHabilitar eh a chave mestra, usada por CmdProcessaClick para
    * bloquear a digitacao enquanto o painel "Aguarde..." esta na tela.
    * Omitido/invalido = .T.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.txt_4c_Grupo.Enabled     = loc_lHabilitar
        THIS.txt_4c__Dgrupo.Enabled   = loc_lHabilitar
        THIS.txt_4c_Conta.Enabled     = loc_lHabilitar
        THIS.txt_4c_Dconta.Enabled    = loc_lHabilitar
        THIS.txt_4c_Mat.Enabled       = loc_lHabilitar
        THIS.chk_4c_Chk_Saldo.Enabled = loc_lHabilitar
        THIS.chk_4c_ChkFalha.Enabled  = loc_lHabilitar

        *-- When de Get_DMat: so enquanto o codigo do material esta vazio
        THIS.txt_4c_DMat.Enabled = loc_lHabilitar AND EMPTY(ALLTRIM(THIS.txt_4c_Mat.Value))
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Fonte UNICA do estado da grade de resultado e dos
    * dois botoes de emissao (Fase 8/8), governada por this_lResultadoValido:
    *
    *   legado, fim do Processa.Click (apurou saldo):
    *       ThisForm.Grade.Visible = .t. / Visualizar.Enabled = .t. /
    *       Imprimir.Enabled = .t. / Grade.Refresh
    *   legado, Valid de Get_Mat (material trocado invalida o resultado):
    *       ThisForm.Grade.Visible = .f. / Visualizar.Enabled = .f. /
    *       Imprimir.Enabled = .f.
    *   legado, Processa.Click com EOF ("Nenhum Saldo Selecionado!!!"):
    *       Return ANTES das tres linhas - os botoes PERMANECEM desligados.
    *
    * Antes da Fase 8 essas atribuicoes estavam espalhadas em dois metodos; o
    * caminho de EOF do processamento nao as derrubava e a tela ficava
    * oferecendo Video/Impressora sobre um resultado que nao veio.
    *
    * PUBLIC (sem PROTECTED): alvo dos harness de verificacao e de
    * TesteAutomatico.prg, que chamam THIS.oForm.AjustarBotoesPorModo() de
    * fora da classe (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.grd_4c_Dados.Visible      = THIS.this_lResultadoValido
        THIS.cmd_4c_Visualizar.Enabled = THIS.this_lResultadoValido
        THIS.cmd_4c_Imprimir.Enabled   = THIS.this_lResultadoValido
    ENDPROC

    *==========================================================================
    * LimparCampos - Estado inicial consolidado (Fase 8/8): zera o BO
    * (LimparDados), espelha o BO na tela (BOParaForm), descarta o resultado
    * apurado e repoe o .Enabled dos campos e o estado dos botoes.
    *
    * Chamado por InicializarForm() para que o estado de abertura da tela
    * tenha UMA origem, em vez de ficar implicito nos .Value = "" espalhados
    * pelo ConfigurarFiltros.
    *
    * PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
    * LimparCampos (ver nota em FormParaBO).
    *
    * O ZAP eh seguro aqui: cursor_4c_Saldo nasce de CREATE CURSOR, logo com
    * Buffering = 1 (regra #52), e o Form nao declara DataSession = 2.
    *
    * this_lResultadoValido volta a .T. de proposito - e NAO a .F.: o SCX
    * legado nao declara Grade.Visible nem Visualizar/Imprimir.Enabled, logo
    * a tela ABRE com a grade (vazia) visivel e os dois botoes habilitados, e
    * quem clicar em Video/Impressora antes de processar recebe o aviso
    * "Nenhuma Informacao Selecionada!!!" do proprio metodo de emissao.
    * Derrubar os botoes aqui seria desvio do PILAR 1.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
                THIS.BOParaForm()
            ENDIF

            IF USED("cursor_4c_Saldo")
                SELECT cursor_4c_Saldo
                ZAP
            ENDIF

            THIS.this_lResultadoValido = .T.
            THIS.AjustarBotoesPorModo()
            THIS.HabilitarCampos(.T.)
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Sombra com labels de titulo
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80 (BackColor=100,100,100)
    * Novo: Top=0, Width=THIS.Width (800, igual ao legado - PILAR 1; este
    * cntSombra ja existia no SCX, nao eh o cabecalho injetado da regra #11).
    * lblSombra/lblTitulo transcritos do dump (FontSize=18, Width=769) -
    * os 4 botoes de acao (Fase 4) desenham por cima do canto direito do
    * proprio cnt_4c_Sombra, igual ao legado.
    *==========================================================================
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
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Cria grd_4c_Dados (equivalente a Grade do legado) e
    * o cursor placeholder cursor_4c_Saldo (equivalente a TmpSaldo, criado no
    * Load do legado: Codigo c(10), Nome c(50), Fase c(10), Saldo n(12,3),
    * Data d). O resultado real so eh populado quando Processar (Fase 7/8)
    * roda; aqui a grade nasce vazia mas com a estrutura final.
    * Posicao/propriedades EXATAS do dump: Top=230, Left=119, Width=561,
    * Height=326 (nao escala com o form - a area de dados nao precisou
    * crescer, so o cabecalho/botoes usam a largura nova de 1000px).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Saldo")
                SET NULL ON
                CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
                                                Saldo N(12,3), Data D)
                SET NULL OFF
                INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
                INDEX ON Codigo + Fase TAG Codigo
                INDEX ON Fase + Codigo TAG Carrega
            ENDIF

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 230
                .Left              = 119
                .Width             = 561
                .Height            = 326
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .RowHeight         = 17
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .ColumnCount       = 5
                .Visible           = .T.
            ENDWITH

            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Vincula/revincula grd_4c_Dados a cursor_4c_Saldo.
    * Este eh o metodo Carregar* que alimenta a grade neste form (nao ha
    * "CarregarLista": a lista do SIGOPCFE nao eh uma listagem CRUD
    * independente, eh o RESULTADO do processamento disparado pelos campos de
    * filtro - ver nota de Fase 8/8 no cabecalho do arquivo). PUBLIC para ser
    * alcancavel por LimparCampos() e pelos harness de verificacao.
    * Column.Width/Header1 sao redefinidos DEPOIS do ControlSource (Problema
    * 48 CLAUDE.md: RecordSource reseta Width para 90 e Header1.Caption para
    * "Header1"). Chamado agora (grade vazia) e sera chamado de novo quando
    * Processar (fase futura) repopular cursor_4c_Saldo - por isso tambem
    * fecha com GO TOP + Refresh (regra #21: popular cursor nao repinta a
    * grade por si so).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_oErro, loc_oGrid
        TRY
            IF !USED("cursor_4c_Saldo")
                SET NULL ON
                CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
                                                Saldo N(12,3), Data D)
                SET NULL OFF
                INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
                INDEX ON Codigo + Fase TAG Codigo
                INDEX ON Fase + Codigo TAG Carrega
            ENDIF

            loc_oGrid = THIS.grd_4c_Dados
            loc_oGrid.RecordSource = ""
            loc_oGrid.RecordSource = "cursor_4c_Saldo"

            loc_oGrid.Column1.ControlSource = "cursor_4c_Saldo.Codigo"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Saldo.Nome"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Saldo.Fase"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Saldo.Saldo"
            loc_oGrid.Column5.ControlSource = "cursor_4c_Saldo.Data"

            WITH loc_oGrid.Column1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Funcion" + CHR(225) + "rio"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column2
                .FontName  = "Tahoma"
                .FontSize  = 7
                .Width     = 196
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Nome"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 7
            ENDWITH

            WITH loc_oGrid.Column3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Fase"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 86
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Saldo"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 83
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = CHR(218) + "ltimo Balan" + CHR(231) + "o"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            SELECT cursor_4c_Saldo
            GO TOP
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria os 4 botoes de acao reais do SIGOPCFE.SCX
    * (Processar/Video/Impressora/Encerrar - este form OPERACIONAL nao tem
    * CRUD Incluir/Alterar/Excluir). Standalone CommandButton com Picture
    * usa Themes=.T. + DisabledPicture (nao o Themes=.F. literal do SCX) -
    * Visualizar/Imprimir sao Enabled/Disabled durante o processamento
    * (legado: ThisForm.Visualizar.Enabled / ThisForm.Imprimir.Enabled) e
    * sem isso o icone desaparece quando Enabled=.F.
    * Posicoes: Top=3/Left/Width=75/Height=75 EXATOS do dump (Processa=500,
    * Imprimir=575, Visualizar=650, Saida=725 - contiguos, sem sobra),
    * sobre o canto direito do cnt_4c_Sombra (criado antes, logo os botoes
    * desenham por cima, igual ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Processa", "CommandButton")
            WITH THIS.cmd_4c_Processa
                .Top               = 3
                .Left              = 500
                .Width             = 75
                .Height            = 75
                .FontBold          = .T.
                .FontItalic        = .T.
                .FontName          = "Comic Sans MS"
                .FontSize          = 8
                .FontExtend        = .F.
                .WordWrap          = .T.
                .Picture           = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture   = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption           = "Processar"
                .PicturePosition   = 13
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .T.
                .Cancel            = .F.
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "CmdProcessaClick")

            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 575
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Caption         = "Impressora"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")

            THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH THIS.cmd_4c_Visualizar
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Caption         = "V" + CHR(237) + "deo"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "CmdVisualizarClick")

            THIS.AddObject("cmd_4c_Saida", "CommandButton")
            WITH THIS.cmd_4c_Saida
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption         = "Encerrar"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "CmdSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSaidaClick - Encerra o form (legado: PROCEDURE Saida.Click = 1
    * linha, "Thisform.Release"). PUBLIC (sem PROTECTED) - alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE CmdSaidaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Delega para o handler nativo do form OPERACIONAL
    * (padrao canonico de FormFop/Formdmo/FormFis: o nome real do botao de
    * saida varia por form - aqui cmd_4c_Saida/CmdSaidaClick -, e este
    * wrapper so existe para o TesteAutomatico.prg localizar o metodo de
    * encerramento sem renomear o handler real nem o objeto do botao).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSaidaClick()
    ENDPROC

    *==========================================================================
    * CmdProcessaClick - Dispara o processamento de saldos (Fase 7/8).
    * Guarda transcrita literalmente do inicio do Processa.Click do legado
    * (If Empty(ThisForm.Get_Mat.Value) / Messagebox('O Produto Deve Ser
    * Informado!!!') / ThisForm.Get_Mat.SetFocus / Return 0); o restante do
    * algoritmo (apuracao de saldo cruzando SigCdPro/SigCdCli/SigMvEst/
    * SigCdNec/SigMvCab/SigCdPsc, ~900 linhas no legado) fica no BO -
    * THIS.this_oBusinessObject.ProcessarSaldos() - que ja recebe os
    * filtros via FormParaBO().
    *
    * O container "Aguarde..." (cnt_4c_Mensagem, Fase 6) replica o
    * CntMensagem.Visible = .t./.f. que envolve a primeira consulta
    * (crSigMvEst) do legado; o restante do processamento (varios
    * fwprogressbar) fica no BO.
    *==========================================================================
    PROCEDURE CmdProcessaClick()
        LOCAL loc_lSucesso, loc_oErro

        THIS.FormParaBO()

        IF EMPTY(THIS.this_oBusinessObject.this_cMaterial)
            MsgAviso("O Produto Deve Ser Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Mat.SetFocus()
            RETURN
        ENDIF

        loc_lSucesso = .F.

        THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..."
        THIS.cnt_4c_Mensagem.Top     = 112
        THIS.cnt_4c_Mensagem.Visible = .T.
        THIS.HabilitarCampos(.F.)
        THIS.Refresh()

        *-- TRY/CATCH so em volta do processamento (Fase 8/8): ProcessarSaldos
        *-- devolve .F. nos caminhos previstos, mas uma falha inesperada
        *-- (fwprogressbar, SQLEXEC) nao pode deixar a tela com o painel
        *-- "Aguarde..." no ar e os campos desabilitados para sempre - o
        *-- restabelecimento abaixo roda em qualquer saida. Sem RETURN dentro
        *-- do bloco (regra #1).
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarSaldos()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdProcessaClick")
        ENDTRY

        THIS.cnt_4c_Mensagem.Visible = .F.
        THIS.HabilitarCampos(.T.)

        *-- Grade/Video/Impressora pelo funil unico: no legado as tres linhas
        *-- que os religam ficam DEPOIS do "Return" do caminho de EOF, ou
        *-- seja, resultado vazio mantem tudo desligado (Fase 8/8).
        THIS.this_lResultadoValido = loc_lSucesso
        THIS.AjustarBotoesPorModo()

        IF loc_lSucesso
            THIS.CarregarDados()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdVisualizarClick / CmdImprimirClick - Video e Impressora (legado:
    * Visualizar.Click chama Impressao('V'), Imprimir.Click chama
    * Impressao('I')). Delegam para o metodo Imprimir(), que por sua vez
    * delega ao BO (THIS.this_oBusinessObject.ExibirRelatorio) - que monta
    * TmpCabec e dispara o SigOpCfe.frx via ExecutarReportForm.
    *==========================================================================
    PROCEDURE CmdVisualizarClick()
        THIS.Imprimir("V")
    ENDPROC

    PROCEDURE CmdImprimirClick()
        THIS.Imprimir("I")
    ENDPROC

    PROTECTED PROCEDURE Imprimir(par_cSaida)
        LOCAL loc_lSucesso

        *-- FormParaBO ANTES de emitir (Fase 8/8): o subtitulo do SigOpCfe.frx
        *-- eh montado pelo BO a partir de this_cMaterial/this_cDescMaterial,
        *-- e o legado le os DOIS campos direto da TELA no momento da emissao
        *-- ('Material : ' + Alltrim(This.Get_Mat.Value) + ' - ' +
        *-- Alltrim(This.Get_DMat.Value)). Sem esta linha, trocar o material
        *-- depois de processar imprimia o cabecalho com o material ANTERIOR.
        THIS.FormParaBO()

        loc_lSucesso = THIS.this_oBusinessObject.ExibirRelatorio(par_cSaida)

        IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna os controles visiveis recursivamente
    * EXCECOES: cnt_4c_Mensagem (equivalente ao CntMensagem do legado, que
    * nasce com Visible=.F. e so e exibido durante o processamento/Aguarde) e
    * cnt_4c_Sombra (cabecalho - sempre visivel, mas nao deve ser forcado por
    * este metodo generico) - os containers em si NAO sao forcados a
    * Visible=.T. aqui, mas os filhos deles sao preparados recursivamente
    * para que aparecam corretamente quando exibidos.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_MENSAGEM", "CNT_4C_SOMBRA")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Fecha cursores de referencia e restaura o menu do sistema
    * (DODEFAULT() ao final - FormBase.Destroy() faz o fix do menu encolhido)
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores[31], loc_nI

        loc_aCursores[1]  = "cursor_4c_Pam"
        loc_aCursores[2]  = "cursor_4c_Pac"
        loc_aCursores[3]  = "cursor_4c_OpOpt"
        loc_aCursores[4]  = "cursor_4c_Ope"
        loc_aCursores[5]  = "cursor_4c_Opd"
        loc_aCursores[6]  = "cursor_4c_Gcr"
        loc_aCursores[7]  = "cursor_4c_Pro"
        loc_aCursores[8]  = "cursor_4c_Cli"
        loc_aCursores[9]  = "cursor_4c_Gccr"
        loc_aCursores[10] = "cursor_4c_Saldo"
        *-- Cursores de trabalho do processamento (Fase 7/8 - ProcessarSaldos)
        loc_aCursores[11] = "cursor_4c_Resumo"
        loc_aCursores[12] = "cursor_4c_Opera"
        loc_aCursores[13] = "cursor_4c_MvEst"
        loc_aCursores[14] = "cursor_4c_CliDet"
        loc_aCursores[15] = "cursor_4c_Fcx"
        loc_aCursores[16] = "cursor_4c_Nens"
        loc_aCursores[17] = "cursor_4c_NensI"
        loc_aCursores[18] = "cursor_4c_Opi"
        loc_aCursores[19] = "cursor_4c_Gru"
        loc_aCursores[20] = "cursor_4c_Ggrp"
        loc_aCursores[21] = "cursor_4c_Eest"
        loc_aCursores[22] = "cursor_4c_EestI"
        loc_aCursores[23] = "cursor_4c_Esti2"
        loc_aCursores[24] = "cursor_4c_Pesa"
        loc_aCursores[25] = "cursor_4c_PesaI"
        loc_aCursores[26] = "cursor_4c_Uni"
        loc_aCursores[27] = "cursor_4c_UltBal"
        loc_aCursores[28] = "cursor_4c_SaldoI"
        loc_aCursores[29] = "cursor_4c_Total"
        loc_aCursores[30] = "cursor_4c_Empresa"
        loc_aCursores[31] = "TmpCabec"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
